Return-Path: <linux-kernel+bounces-142711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C7A8A2F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931391F229C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B918249F;
	Fri, 12 Apr 2024 13:19:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67278824A0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927961; cv=none; b=Pxswi36XTkUIdBL4SPyDuGtP2lRhO/j/kN9kYRyk0eosK9u1/kLHlJQ0cSzLnCHZGM4zU9t80s/0B0wRPQn294jqmqIcWWcdQhZvyMjSa9ZNvERU3BAKA4Ivk4usNjFFEnnj19wP3C+D1s6nz0gSQ87gQzGlGReCqveRjNwQc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927961; c=relaxed/simple;
	bh=snRnpxvkyWnPsYC43Zoiypgop15LpRmxruQf/aQeNJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GSm1uM63vbo4c31Ok6jnq4SmG4Jl5OqXXpq8fNHTOFLUHFS6aGZKPgkMAfgPBkHPAe3AzhEA40jAOMkO5aQ27P6WFGn4R5rCTnfmEXJCQNZxTBNaPLlSFcH5+G1zB0QF5ZwgWscfyaDtvQdVggjVKuN0zBncAUePhH04uId6AdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF897339;
	Fri, 12 Apr 2024 06:19:47 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36B793F766;
	Fri, 12 Apr 2024 06:19:17 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Speed up boot with faster linear map creation
Date: Fri, 12 Apr 2024 14:19:05 +0100
Message-Id: <20240412131908.433043-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

It turns out that creating the linear map can take a significant proportion of
the total boot time, especially when rodata=full. And most of the time is spent
waiting on superfluous tlb invalidation and memory barriers. This series reworks
the kernel pgtable generation code to significantly reduce the number of those
TLBIs, ISBs and DSBs. See each patch for details.

The below shows the execution time of map_mem() across a couple of different
systems with different RAM configurations. We measure after applying each patch
and show the improvement relative to base (v6.9-rc2):

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
base           |  168   (0%) | 2198   (0%) | 8644   (0%) | 17447   (0%)
no-cont-remap  |   78 (-53%) |  435 (-80%) | 1723 (-80%) |  3779 (-78%)
batch-barriers |   11 (-93%) |  161 (-93%) |  656 (-92%) |  1654 (-91%)
no-alloc-remap |   10 (-94%) |  104 (-95%) |  438 (-95%) |  1223 (-93%)

This series applies on top of v6.9-rc2. All mm selftests pass. I've compile and
boot tested various PAGE_SIZE and VA size configs.

---

Changes since v2 [2]
====================

  - Independently increment ptep/pmdp in alloc_init_cont_[pte|pmd]() rather than
    return the incremented value from int_[pte|pmd]() (per Mark)
  - Removed explicit barriers from alloc_init_cont_pte() and instead rely on the
    barriers in pte_clear_fixmap() (per Mark)
  - Significantly simplify approach to avoiding fixmap during alloc (patch 3
    reworked) (per Mark)
  - Dropped patch 4 - not possible with simplified patch 3 and improvement (~2%)
    didn't warrant complexity (per Mark)


Changes since v1 [1]
====================

  - Added Tested-by tags (thanks to Eric and Itaru)
  - Renamed ___set_pte() -> __set_pte_nosync() (per Ard)
  - Reordered patches (biggest impact & least controversial first)
  - Reordered alloc/map/unmap functions in mmu.c to aid reader
  - pte_clear() -> __pte_clear() in clear_fixmap_nosync()
  - Reverted generic p4d_index() which caused x86 build error. Replaced with
    unconditional p4d_index() define under arm64.


[1] https://lore.kernel.org/linux-arm-kernel/20240326101448.3453626-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/20240404143308.2224141-1-ryan.roberts@arm.com/

Thanks,
Ryan

Ryan Roberts (3):
  arm64: mm: Don't remap pgtables per-cont(pte|pmd) block
  arm64: mm: Batch dsb and isb when populating pgtables
  arm64: mm: Don't remap pgtables for allocate vs populate

 arch/arm64/include/asm/pgtable.h |   9 ++-
 arch/arm64/mm/mmu.c              | 101 +++++++++++++++++--------------
 2 files changed, 65 insertions(+), 45 deletions(-)

--
2.25.1


