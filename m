Return-Path: <linux-kernel+bounces-68372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47683857961
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD968B25281
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC431BF3A;
	Fri, 16 Feb 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDS4mTov"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D71BF35;
	Fri, 16 Feb 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077075; cv=none; b=l2JTeW1Zd911puentyApnvgc0AYbISn9xDgytzLgwwbqk0B7FpcQd0KumaaN3FVVLVTvvneS48mnzJQL/WoMcJppeOnR/d48RXGLtYusLsJ5/yG9SZbqz09UvH2LpXmzXdfDUvdkJavyU9RSUL3Mx16SGNJlnUg8LmJ4+eV2AVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077075; c=relaxed/simple;
	bh=AO1Wioodok2yf+QhQ+JekjTF9j2rg/6jELEXU64mFBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Czgc3Ca2dl838JStNRBc9FvXv8SqjzjGLBQsDA/kRPzFP0PUDR+r9cy1QQH4fzIbr3nzgW5b4EwEiq+/p1/v0b2B+fH41jqkLPgTNPCAGTnhimupVkGDlEl+eHcLJQe3Z54n7bA9YJlxXPlQzfSvWiL6sMkX8dvBZ4fBJGtm/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDS4mTov; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e1126f57f1so1067845b3a.2;
        Fri, 16 Feb 2024 01:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708077073; x=1708681873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2vHnI5LSLRE33MfHS1ReUQs4VrL3VJWSAdI/Ri9+mw=;
        b=NDS4mTovYFqW/sTz5q/yf2WlN6T8OapOnVWdOVH7Ge8Z9qflFXu81dC0y6iDOigZLe
         Yt7qPbgGPFCZWyVs1NHDCzGmZGN2qF2MvJl4bErbgjTTv8eO4H3MuO31HPg3CvhQkH0I
         dR/xwgpyvLjI/BblxGUkbfj/UZwKpat0yRNArDxrRW0uMLi/hbWXUedBHU00J8j32p0r
         FCTpzwBsYtjwq3AGsM0QMElK/QJ93UqD+0NoEr79f9BwqHf/ozCyr1H5ZtESw+sQ/xWU
         Vt4KvvJ0FPdDlZ+Dwsk95IgWot5BG4ivTAls2K/dAZjwWY7cfq5dgNm+8hqREjGOzVc6
         8R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708077073; x=1708681873;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2vHnI5LSLRE33MfHS1ReUQs4VrL3VJWSAdI/Ri9+mw=;
        b=CFheSX1X5ZNQG60YRzgdbkI/0BNo+ybY0w82RIlc0XzKP59lFpn4ofIEwro/7aCrDa
         w5SE4Zr9XK1qbPzZAfJfU9tGuS/4/dd6L05ZAfuR2D/xqCLFbNS04NAK4ZBSZoJwuBnM
         zN7Bf9u8UeeUeLrcMZOj5YNJe9eKlOkHQYSzFhXAxhtqHknq7GYXdwD1tB85DxMzesg5
         s10vc4X1jvzZT/cqhj2LN+3ByeqIiZUm3DrcH1zlaH6/AzEGM28/i83uEgvqFdLpl3Z6
         rdJEv222yyqahtpQ3j+wvYScVg7kkpVLpO0OCBznJPUSEupqiAiENs7NCqGz3lZe1x/Z
         nyQA==
X-Forwarded-Encrypted: i=1; AJvYcCVNoW09ORab1c5yeN/xczsQk/ulNi36izGYJMSSR2+Cijg5T8w5j3OjZqVk+vlPBs9w/vmAFtVJtQDIDOBFTlj/VdEevc5XRiLBx1BvbaW/IZU4LGmq8nTuQLAcpxq+mepijpD9
X-Gm-Message-State: AOJu0YyIRR6tG9+mHhV/vikbrtrgh2cfljtznlBkcmtxTVqFa8DGuKLc
	BkKfks6yROcaCiEWoy1eQXTafZdpbTTkC+LWOIy+UxTQWiK6a24H
X-Google-Smtp-Source: AGHT+IFTwCs2pTznLZJ82SbUjDhcvlz/NrKzcAMR4Y7uIhuLCFXev6otDwqhGTvJK3KFyyKrVECpbA==
X-Received: by 2002:a05:6a00:1a8d:b0:6e0:84d4:e009 with SMTP id e13-20020a056a001a8d00b006e084d4e009mr4803464pfv.21.1708077072936;
        Fri, 16 Feb 2024 01:51:12 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.232])
        by smtp.gmail.com with ESMTPSA id fc16-20020a056a002e1000b006e13bf2b955sm898709pfb.113.2024.02.16.01.51.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Feb 2024 01:51:12 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Barry Song <v-songbaohua@oppo.com>,
	SeongJae Park <sj@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3] mm/swap: fix race when skipping swapcache
Date: Fri, 16 Feb 2024 17:51:05 +0800
Message-ID: <20240216095105.14502-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
swapin the same entry at the same time, they get different pages (A, B).
Before one thread (T0) finishes the swapin and installs page (A)
to the PTE, another thread (T1) could finish swapin of page (B),
swap_free the entry, then swap out the possibly modified page
reusing the same entry. It breaks the pte_same check in (T0) because
PTE value is unchanged, causing ABA problem. Thread (T0) will
install a stalled page (A) into the PTE and cause data corruption.

One possible callstack is like this:

CPU0                                 CPU1
----                                 ----
do_swap_page()                       do_swap_page() with same entry
<direct swapin path>                 <direct swapin path>
<alloc page A>                       <alloc page B>
swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
<slow on later locks or interrupt>   <finished swapin first>
..                                  set_pte_at()
                                     swap_free() <- entry is free
                                     <write to page B, now page A stalled>
                                     <swap out page B to same swap entry>
pte_same() <- Check pass, PTE seems
              unchanged, but page A
              is stalled!
swap_free() <- page B content lost!
set_pte_at() <- staled page A installed!

And besides, for ZRAM, swap_free() allows the swap device to discard
the entry content, so even if page (B) is not modified, if
swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
it may also cause data loss.

To fix this, reuse swapcache_prepare which will pin the swap entry using
the cache flag, and allow only one thread to pin it. Release the pin
after PT unlocked. Racers will simply wait since it's a rare and very
short event. A schedule() call is added to avoid wasting too much CPU
or adding too much noise to perf statistics

Other methods like increasing the swap count don't seem to be a good
idea after some tests, that will cause racers to fall back to use the
swap cache again. Parallel swapin using different methods leads to
a much more complex scenario.

Reproducer:

This race issue can be triggered easily using a well constructed
reproducer and patched brd (with a delay in read path) [1]:

With latest 6.8 mainline, race caused data loss can be observed easily:
$ gcc -g -lpthread test-thread-swap-race.c && ./a.out
  Polulating 32MB of memory region...
  Keep swapping out...
  Starting round 0...
  Spawning 65536 workers...
  32746 workers spawned, wait for done...
  Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
  Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
  Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
  Round 0 Failed, 15 data loss!

This reproducer spawns multiple threads sharing the same memory region
using a small swap device. Every two threads updates mapped pages one by
one in opposite direction trying to create a race, with one dedicated
thread keep swapping out the data out using madvise.

The reproducer created a reproduce rate of about once every 5 minutes,
so the race should be totally possible in production.

After this patch, I ran the reproducer for over a few hundred rounds
and no data loss observed.

Performance overhead is minimal, microbenchmark swapin 10G from 32G
zram:

Before:     10934698 us
After:      11157121 us
Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)

Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: stable@vger.kernel.org

---
Update from V2:
- Add a schedule() if raced to prevent repeated page faults wasting CPU
  and add noise to perf statistics.
- Use a bool to state the special case instead of reusing existing
  variables fixing error handling [Minchan Kim].

V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/

Update from V1:
- Add some words on ZRAM case, it will discard swap content on swap_free so the race window is a bit different but cure is the same. [Barry Song]
- Update comments make it cleaner [Huang, Ying]
- Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
- Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO instead of "direct swapin path" [Yu Zhao]
- Update commit message.
- Collect Review and Acks.

V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/

 include/linux/swap.h |  5 +++++
 mm/memory.c          | 20 ++++++++++++++++++++
 mm/swap.h            |  5 +++++
 mm/swapfile.c        | 13 +++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4db00ddad261..8d28f6091a32 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
 	return 0;
 }
 
+static inline int swapcache_prepare(swp_entry_t swp)
+{
+	return 0;
+}
+
 static inline void swap_free(swp_entry_t swp)
 {
 }
diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463a..7059230d0a54 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
+	bool need_clear_cache = false;
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
@@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
+			/*
+			 * Prevent parallel swapin from proceeding with
+			 * the cache flag. Otherwise, another thread may
+			 * finish swapin first, free the entry, and swapout
+			 * reusing the same entry. It's undetectable as
+			 * pte_same() returns true due to entry reuse.
+			 */
+			if (swapcache_prepare(entry)) {
+				/* Relax a bit to prevent rapid repeated page faults */
+				schedule();
+				goto out;
+			}
+			need_clear_cache = true;
+
 			/* skip swapcache */
 			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
 						vma, vmf->address, false);
@@ -4117,6 +4132,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
+	/* Clear the swap cache pin for direct swapin after PTL unlock */
+	if (need_clear_cache)
+		swapcache_clear(si, entry);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4131,6 +4149,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_unlock(swapcache);
 		folio_put(swapcache);
 	}
+	if (need_clear_cache)
+		swapcache_clear(si, entry);
 	if (si)
 		put_swap_device(si);
 	return ret;
diff --git a/mm/swap.h b/mm/swap.h
index 758c46ca671e..fc2f6ade7f80 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct folio *folio,
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
@@ -97,6 +98,10 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 	return 0;
 }
 
+static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+}
+
 static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr)
 {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 556ff7347d5f..746aa9da5302 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3365,6 +3365,19 @@ int swapcache_prepare(swp_entry_t entry)
 	return __swap_duplicate(entry, SWAP_HAS_CACHE);
 }
 
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+	struct swap_cluster_info *ci;
+	unsigned long offset = swp_offset(entry);
+	unsigned char usage;
+
+	ci = lock_cluster_or_swap_info(si, offset);
+	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
+	unlock_cluster_or_swap_info(si, ci);
+	if (!usage)
+		free_swap_slot(entry);
+}
+
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
 {
 	return swap_type_to_swap_info(swp_type(entry));
-- 
2.43.0


