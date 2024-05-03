Return-Path: <linux-kernel+bounces-167117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7F8BA4B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B91285548
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29853C13D;
	Fri,  3 May 2024 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsfLQNvD"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E15BA53
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697446; cv=none; b=Upm0bGjbcVEsQXJKpbTHHdGVZpp0N2ncUlKuG+1inJKonDcZb466c+eQ+EHE9pF7WFe9zDgyaCgtxQgHwhKLvPLgGKJ7APXC43ptlqfVHdthNcJb6g9ekqmqa/UoWx2tboAI7NtItsZiR10vY3nn3ju5szjbXpyVm6XgYVYb818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697446; c=relaxed/simple;
	bh=oo35akT61XO3wO/d9UTFiaShvoX1k6kBZrsC7V0RB3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=luaSd0eWW5RA0jQSktbM/BpWoKeMwbi7gh2LfB9rFrdsIR01fqrSAR4Kiwqye144QD6cv5JZiFjflVYhyq/t5LuuTwCfYS2MkioZfX2hQZQ2sKv9KV3c6oWmvweV5aAnQxjBN/mi54tTyuDgAJqWpnImKKQ4UO8rhoYm5pPuIBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsfLQNvD; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso6152441a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714697444; x=1715302244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pttzJ1oL5psmDKSRscVzWJxl+ExC61y0Qf6UalfkVjI=;
        b=VsfLQNvDN93PviHEDp4FNI/ZYhzQK7vOlBQCXTQ6IGstCdbAwezE2e9Ofpc1QpOpii
         iv3rSqrwt+f4StKBQ4YY8917GibT2nM2huM6sCHsGayx3VmwtPTJ8FuHctV19ALTmKd9
         zUpheGVYR4pYD7M5NXoYsXAW0GuxRZlxypBBTM48obBWTNqYmd31fjCl2NvQGgCVQg1/
         uir2X+vMdJ6K12/9LSRU9urvcLgAZp20r82pxigGavAlmFwZmG5azUzZrOTaNFAH6Nw4
         I67sj86pAUWkw14MKHV7isw3wmQ80dIwWVfGZ/5iszA6f5g2fY6Zg1lddikTXIuIFKea
         GhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714697444; x=1715302244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pttzJ1oL5psmDKSRscVzWJxl+ExC61y0Qf6UalfkVjI=;
        b=upR0aXerUDXPv6NqKNXW/p/8nXrcOOoY/dJXo8saPi8MqmpHU0x6nzA1yCOQbqv9e5
         r9hXYeN3w/GpIYlVHucizEDBdBu2p1Z3JhsIBUMvP+5Yp+94HP+layMKv5pma7bhrsK7
         gaeqZKvFfmE+jM/n3qTXDVPVn0b2XCMfWhN9XwoXNCDjh9XoRas6DYOHX4rcqy3eIhIu
         FKCzxJeqXb+bGR+jdn9Gfq/jSZrtQFWk5c1Qw2dQRbpmzRkkPeUw6YPtYKrCTHtrpXVD
         WvCtEIRsQjkhyHXNGv6NVqL4JPxd9fJF04p1z2WIPqYN4rrLgsVNHCcOvKobCjwXIkG9
         xzVA==
X-Forwarded-Encrypted: i=1; AJvYcCWooKIMOuC1P+9nlUGWldig5lFk11HtDDwGvw22t0Wl06qBW+HsO8Nar4cfRefMXN6uLTKLm8oXAxNWZV2GMHtkjecRvfUsIs6oXpaG
X-Gm-Message-State: AOJu0Yz+8G+JR4wyffF9GeiUIschJYfiLAJ80p+54Er4563UFBsBVdXq
	h9rbmnf4AOEzbUcPdKDLxz7AiW2zGc3mMhoU/Ca24ydvzwn/cXYb
X-Google-Smtp-Source: AGHT+IHwKWVOqhPLXUS3QgE5M8ppn6dv6AiBYd2YOzDOOa8alWeAG+3bBTD/xcy6BjQudvLnFR6p9A==
X-Received: by 2002:a05:6a21:3985:b0:1a7:9adc:86de with SMTP id ad5-20020a056a21398500b001a79adc86demr1792275pzc.20.1714697444209;
        Thu, 02 May 2024 17:50:44 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001ec48e41d2esm1969175plh.212.2024.05.02.17.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 17:50:43 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: [PATCH v3 0/6] large folios swap-in: handle refault cases first
Date: Fri,  3 May 2024 12:50:17 +1200
Message-Id: <20240503005023.174597-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This patch is extracted from the large folio swapin series[1], primarily addressing
the handling of scenarios involving large folios in the swap cache. Currently, it is
particularly focused on addressing the refaulting of mTHP, which is still undergoing
reclamation. This approach aims to streamline code review and expedite the integration
of this segment into the MM tree.

It relies on Ryan's swap-out series[2], leveraging the helper function
swap_pte_batch() introduced by that series.

Presently, do_swap_page only encounters a large folio in the swap
cache before the large folio is released by vmscan. However, the code
should remain equally useful once we support large folio swap-in via
swapin_readahead(). This approach can effectively reduce page faults
and eliminate most redundant checks and early exits for MTE restoration
in recent MTE patchset[3].

The large folio swap-in for SWP_SYNCHRONOUS_IO and swapin_readahead()
will be split into separate patch sets and sent at a later time.

-v3:
 - optimize swap_free_nr using bitmap with single one "long"; "Huang, Ying"
 - drop swap_free() as suggested by "Huang, Ying", now hibernation can get
   batched;
 - lots of cleanup in do_swap_page() as commented by Ryan Roberts and "Huang,
   Ying";
 - handle arch_do_swap_page() with nr pages though the only platform which
   needs it, sparc, doesn't support THP_SWAPOUT as suggested by "Huang,
   Ying";
 - introduce pte_move_swp_offset() as suggested by "Huang, Ying";
 - drop the "any_shared" of checking swap entries with respect to David's
   comment;
 - drop the counter of swapin_refault and keep it for debug purpose per
   Ying
 - collect reviewed-by tags

-v2:
 - rebase on top of mm-unstable in which Ryan's swap_pte_batch() has changed
   a lot.
 - remove folio_add_new_anon_rmap() for !folio_test_anon()
   as currently large folios are always anon(refault).
 - add mTHP swpin refault counters
  Link:
  https://lore.kernel.org/linux-mm/20240409082631.187483-1-21cnbao@gmail.com/

-v1:
  Link: https://lore.kernel.org/linux-mm/20240402073237.240995-1-21cnbao@gmail.com/

Differences with the original large folios swap-in series
 - collect r-o-b, acked;
 - rename swap_nr_free to swap_free_nr, according to Ryan;
 - limit the maximum kernel stack usage for swap_free_nr, Ryan;
 - add output argument in swap_pte_batch to expose if all entries are
   exclusive
 - many clean refinements, handle the corner case folio's virtual addr
   might not be naturally aligned

[1] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@gmail.com/
[2] https://lore.kernel.org/linux-mm/20240408183946.2991168-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-mm/20240322114136.61386-1-21cnbao@gmail.com/

Barry Song (3):
  mm: remove swap_free() and always use swap_free_nr()
  mm: introduce pte_move_swp_offset() helper which can move offset
    bidirectionally
  mm: introduce arch_do_swap_page_nr() which allows restore metadata for
    nr pages

Chuanhua Han (3):
  mm: swap: introduce swap_free_nr() for batched swap_free()
  mm: swap: make should_try_to_free_swap() support large-folio
  mm: swap: entirely map large folios found in swapcache

 include/linux/pgtable.h | 26 ++++++++++++++----
 include/linux/swap.h    |  4 +--
 kernel/power/swap.c     |  7 ++---
 mm/internal.h           | 25 ++++++++++++++---
 mm/memory.c             | 61 +++++++++++++++++++++++++++++++++--------
 mm/rmap.c               |  4 +--
 mm/shmem.c              |  4 +--
 mm/swapfile.c           | 50 +++++++++++++++++++++++++++++----
 8 files changed, 143 insertions(+), 38 deletions(-)

-- 
2.34.1


