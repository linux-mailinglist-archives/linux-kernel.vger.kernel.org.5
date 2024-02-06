Return-Path: <linux-kernel+bounces-55456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE3684BCEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8531C21183
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CFD12E75;
	Tue,  6 Feb 2024 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/c+TUFQ"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EDA134A5;
	Tue,  6 Feb 2024 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244123; cv=none; b=kabmGoC/Cn0HVUzIln1mNUOc8SojDFsFk/sUvfAB558qnJHT0WlrerSQoeFfD4VARFUtHGrsSWShVAvN2EPxflc709XQRH2eYwPVBvCtBgx1lFtpuXU9zD198Jg2jCXvop9fOWibHBRAgkShHJREONpSPJ2dtQnu9j4gV1U2ewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244123; c=relaxed/simple;
	bh=0+RZHcCp/NMCytXSWyHreluR2lQnnemCua1HlFSZCew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdyHIZIFyOepOtKe69XZG72bTlGjwxJdbw70GdI/uLfbn7fgFRQfcX+7+G6gzCj0/2ySDRruYYFzdktzF4fYYykNe00wSh0fDJPqzOJLqcLOy+hNkDgcYM1hlyx2JUzt4iIuj0W5iHOaWpf4lfY3Vly4oWQc0JGtiwZT0bPWRJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/c+TUFQ; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59cb1e24e91so1447043eaf.0;
        Tue, 06 Feb 2024 10:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707244120; x=1707848920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ri33dEDMSF+uLhQGu0qPBpIz5K4xYUeshxoTcvF1uRc=;
        b=M/c+TUFQEKbhpPOyx3KVKKL3qPHbWBjXl/s9sSMawRC2QbiYH7F0npH2Zl7TZTSusq
         pvPutyoHheLs3Xhay0fDunCAkuZJGw39O48exSvxmwEUujtsD2CC+WWHzOKadzw6J27n
         0YYCs+5JawTym125r+/Sij2pGS+Rx3L4I7qYxtCa20AcpPhzuytIGWaCdeoLmqso9SBQ
         A67QnPdxgxXf6aY3J3CeZXSLl3gLVCNgyVWt7wiFqRVT/Uw7eZzP7UlXDZYpb0qgWndH
         yRg17vfnze5DmCzj7953oLBwutCJw4cYQpEbRtOW1aEvRDXVjSUvBCZZPmOd4+lEYYOr
         5I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707244120; x=1707848920;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri33dEDMSF+uLhQGu0qPBpIz5K4xYUeshxoTcvF1uRc=;
        b=tyH5Np68Ln/SkTQnpnR5TkbMfw8zmDriUeLLM4cqrWxlbrF9yUIv0gPaoWy3TlgiCt
         IxijtGaq6r+COzFh8SXPXafBIcAiFCiUZaKJYkuGWElKJ+U+C+MlUir5/9WgKug20mxr
         rMCLgvrfc7HIsGmnHeXwuhkzv/sUMyMlo6zt2WdTc8GIsYO+ETs66R3DIofxg5YFnfKc
         7HAnoMS6JDXpZPdqnByAMW+vR/RFLDaEWdYoZQz0XKT5LgYzdV3Uv7l0jP9g/KCcRxg+
         uVYNDMcOykKWjBpYvIaWjUlbqcSHplIpf9WAse3Kp2dqghqpq5Ug15FAGlKL48gG5TZB
         Gr8g==
X-Gm-Message-State: AOJu0Yx75AYj9RpqNkahDVy7fdAFrKMWfKPVR0Lus1gx80eIk3Yi7hi3
	53KPJ+b/soID6d4gzfB/sFGCLBwuKmqbM6jEyiaQTfg7sNaiHPK2
X-Google-Smtp-Source: AGHT+IHLfQO1mq7zCZus8p7hf70KIAOyXJuPclrtTGt9F4DIPIbnjtaI+hylLkx1qbCPL4009cfXrQ==
X-Received: by 2002:a05:6358:2490:b0:176:56b9:d4e1 with SMTP id m16-20020a056358249000b0017656b9d4e1mr322603rwc.23.1707244120454;
        Tue, 06 Feb 2024 10:28:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVtbiL616DbzpVKTfBYtVTxwY4aYLBihKCF6hKfBFX++CaF/KM9zQ+Dj4p6+/D1Zh+tP8ejZa7KmFkCAJQ6S8IsphXfNGQD2PriTPN9UgdxOqrl2uRrVck6ZJ6Eg4YWkz+lkRvOMlPnNqcD+S+N47qrYQx1ZNC+irwh+Uh6kzOEgfWGvgz/QPAdv34ePV7JuFjHiCsmzYJO8em2DqDq6uRt6s/8PeWLgkjZbdYlm/jzK+0mDxGOfL4z4+bfMQSFLSPDmsUJo3K3FiaycIWsDCOBvbr9Edva8Y10ufQIMKbWjVUrparXKzDG+y6OotQOWVeWYEPisCV/mkKnN/GDUIi2jUzPca1g9ikCydDqK6LaEsHt+NKW/C/yAKcy2LSPuXvhxIghicuYxlk4jDGkO/+odTI2UqHI1iXoCYDSvo8QTpi+miu+7e+qcfUG4i6u9JL0GpLpe5PujBPJFL6gOXhBAh/9
Received: from KASONG-MB2.tencent.com ([1.203.117.232])
        by smtp.gmail.com with ESMTPSA id g20-20020a635214000000b005d8b89bbf20sm2446839pgb.63.2024.02.06.10.28.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Feb 2024 10:28:39 -0800 (PST)
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
Subject: [PATCH v2] mm/swap: fix race when skipping swapcache
Date: Wed,  7 Feb 2024 02:25:59 +0800
Message-ID: <20240206182559.32264-1-ryncsn@gmail.com>
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
after PT unlocked. Racers will simply busy wait since it's a rare
and very short event.

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
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Yu Zhao <yuzhao@google.com>

---
Update from V1:
- Add some words on ZRAM case, it will discard swap content on swap_free so the race window is a bit different but cure is the same. [Barry Song]
- Update comments make it cleaner [Huang, Ying]
- Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]
- Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO instead of "direct swapin path" [Yu Zhao]
- Update commit message.
- Collect Review and Acks.

 include/linux/swap.h |  5 +++++
 mm/memory.c          | 15 +++++++++++++++
 mm/swap.h            |  5 +++++
 mm/swapfile.c        | 13 +++++++++++++
 4 files changed, 38 insertions(+)

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
index 7e1f4849463a..1749c700823d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
+			if (swapcache_prepare(entry))
+				goto out;
+
 			/* skip swapcache */
 			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
 						vma, vmf->address, false);
@@ -4116,6 +4126,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+	/* Clear the swap cache pin for direct swapin after PTL unlock */
+	if (folio && !swapcache)
+		swapcache_clear(si, entry);
 out:
 	if (si)
 		put_swap_device(si);
@@ -4124,6 +4137,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out_page:
+	if (!swapcache)
+		swapcache_clear(si, entry);
 	folio_unlock(folio);
 out_release:
 	folio_put(folio);
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


