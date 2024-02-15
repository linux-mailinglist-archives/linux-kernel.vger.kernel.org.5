Return-Path: <linux-kernel+bounces-66872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1CE8562EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AAF282FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0C12C802;
	Thu, 15 Feb 2024 12:18:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612E12BEAF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999489; cv=none; b=Fk8l0vunljLVs2ehqDhvsqAkmbPaHt9z87k+Im7kx3kpyxg0FpODvEqljQtSKKGOtGig5cO99IsrgFjEDEUNG1VCrXx0WUnm/4y3aoLgTr5H2tMdHRPxiYYgEB6Fq4p4JYQxvh7lWYNHwe0r2CSKmoh3TPskk8g4wcwkucb/tCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999489; c=relaxed/simple;
	bh=x9FtnrleqpJuZy6f30x2br9cQeME+hU2HTs978RoTLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qdG81AQy9t1duLggBJlhR1MNxAUWDG8LCPXd2GZfVlO8Utjn/YDNJTYOvaSWQhQ3U8n13Zokyw/i4EAjjPkhJm+5LivQtv6qAnnbaPcRI4piGa+Z7DjxeNYThtBi6ckB4ycDXQ+JI4GFyhFQLeDC88KE9i+tO5BzzOqumBXNSrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C309F1FB;
	Thu, 15 Feb 2024 04:18:46 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256853F766;
	Thu, 15 Feb 2024 04:18:04 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: David Hildenbrand <david@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 0/4] Reduce cost of ptep_get_lockless on arm64
Date: Thu, 15 Feb 2024 12:17:52 +0000
Message-Id: <20240215121756.2734131-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an RFC for a series that aims to reduce the cost and complexity of
ptep_get_lockless() for arm64 when supporting transparent contpte mappings [1].
The approach came from discussion with Mark and David [2].

It introduces a new helper, ptep_get_lockless_norecency(), which allows the
access and dirty bits in the returned pte to be incorrect. This relaxation
permits arm64's implementation to just read the single target pte, and avoids
having to iterate over the full contpte block to gather the access and dirty
bits, for the contpte case.

It turns out that none of the call sites using ptep_get_lockless() require
accurate access and dirty bit information, so we can also convert those sites.
Although a couple of places need care (see patches 2 and 3).

Arguably patch 3 is a bit fragile, given the wide accessibility of
vmf->orig_pte. So it might make sense to drop this patch and stick to using
ptep_get_lockless() in the page fault path. I'm keen to hear opinions.

I've chosen the name "recency" because it's shortish and somewhat descriptive,
and is alredy used in a couple of places to mean similar things (see mglru and
damon). I'm open to other names if anyone has better ideas.

If concensus is that this approach is generally acceptable, I intend to create a
series in future to do a similar thing with ptep_get() -> ptep_get_norecency().

---
This series applies on top of [1].

[1] https://lore.kernel.org/linux-mm/20240215103205.2607016-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/a91cfe1c-289e-4828-8cfc-be34eb69a71b@redhat.com/

Thanks,
Ryan

Ryan Roberts (4):
  mm: Introduce ptep_get_lockless_norecency()
  mm/gup: Use ptep_get_lockless_norecency()
  mm/memory: Use ptep_get_lockless_norecency() for orig_pte
  arm64/mm: Override ptep_get_lockless_norecency()

 arch/arm64/include/asm/pgtable.h |  6 ++++
 include/linux/pgtable.h          | 55 ++++++++++++++++++++++++++++--
 kernel/events/core.c             |  2 +-
 mm/gup.c                         |  7 ++--
 mm/hugetlb.c                     |  2 +-
 mm/khugepaged.c                  |  2 +-
 mm/memory.c                      | 57 ++++++++++++++++++++------------
 mm/swap_state.c                  |  2 +-
 mm/swapfile.c                    |  2 +-
 9 files changed, 102 insertions(+), 33 deletions(-)

--
2.25.1


