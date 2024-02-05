Return-Path: <linux-kernel+bounces-52463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06A849883
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA50B29432
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF9A18C28;
	Mon,  5 Feb 2024 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJClS4v2"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9A1864D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131435; cv=none; b=ElHumNGqwGbsAEu30nkRz4/+4nFnuP542ygnenemeBu+tGgvcpwhHh7U7xFfzCoS+NAXSOXtxERUlQlbtaG2dwRJAaWeyM973LRkTZtbPHvI4+wk5RdDxBNfzG1JZBQapIsjshLhJycIXdvaaIJl5uWcgHGemwcytOKdPDZiovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131435; c=relaxed/simple;
	bh=lv3Iv/NL9d2BNGBRJb0aUNtUs8akPVlj0K20WDfVqHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TH5g1lycXwWzIBpDA3vRg7Jq5udCjcmWVbwVLkj5gkeMejxunoXxcoVhL8EDfur7sKGTh6onCW9LyMtIjt5zgUgVXnLCjDP2lsZtHEjA+G5XBdbs/rbagq5Im+q+BJrnLHSLuDawd/4LAx/e/khUX2wFxJoD317br10htwwKDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJClS4v2; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-599fc25071bso2894826eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707131432; x=1707736232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znkG0W/faimtWk9DtMNAMPJpERguc8HoaHMX5yV02eA=;
        b=ZJClS4v2XfVk3OSkSQkl5q8un7EUcYGZj+7sbeV5YKl4LaV+5Dfs8JNJxTEx3TeK3G
         Twpnwo/5ACDO9xO99vLqykJyLiJxsCJQ33eqU1S3CGhqNW+NLU4yOk0Xs4xbL3sacI1T
         mGmwFTYmdd/AxVlWRjCSF202lvS/PxNSbBCwzBafBuVDZ8CXMijh4xyOF704yf04nU4q
         SiVpycJiBx8DddufFopXCBZJimCT+mCTQl8HhPTQr1YU0fay5q+NLLQNEr7YvHX4/Ndu
         3zmoWta6KtHwhWEoIe7StJfGdlL8YV3G4bUF3fqMW60/J0FiirYVNfBS1ATo9GvG7dtY
         mxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707131432; x=1707736232;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znkG0W/faimtWk9DtMNAMPJpERguc8HoaHMX5yV02eA=;
        b=PElNGZARsEUizDkwtxj1OSw38qNjcwnbNEa0wFFOrwmvbPnIRc8mIQtLq+KzMWATZl
         8frOWsSyAqsofVt/SnrO3nX0Z0XHyqtRafsgun6s6vzsCL+BCxvA3CDpqpU+RoatDy/h
         UJZJTHN/mReKnXvFLNPU4fZTvnIMH/K0zIVyyrsYHCBfUpkZqiEUBE0aGJHBvKrQ5ikW
         AG1aHg2fcvlQ7um1zzW1LkgItJ/HDwdJZYfP+r0gGIs0Yc6ZAQLYEYcPgwE5hij0Gjpb
         5T+SK+V0NVB57ByZ+4aPSgR5ol+IPHNvcfQStA/YPupntk2MKxLUz4EZnLdbU71OB0Ur
         UMSg==
X-Gm-Message-State: AOJu0YwLvsJLr8yMqvMKl+iOiLgN63/Ht5V3+V78p6ADFggm3guxh8oS
	bziFCUciCg50NLRNC3edY+NrTY9y0nGm5y57Az8BrMzH7TVg00r7
X-Google-Smtp-Source: AGHT+IHQ9Q8046bQVtEk8K5lVJ+hLKWsPWhs2z4DES8voFDh08JPKRMGyWERvQeXH4ZbRUxqPzi/8g==
X-Received: by 2002:a05:6358:290d:b0:176:a01d:7889 with SMTP id y13-20020a056358290d00b00176a01d7889mr15491494rwb.30.1707131432415;
        Mon, 05 Feb 2024 03:10:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzcW31kd/ZTjZvFA7UJ/RFsXVXK6O8BjnA4HI23U3dBpGqOsuQWz5vuF5pXuTOWR9MeAdAHCJawLRGqD5ppoDpt5lO8kdIoe3OYyIRGBh8ly8kzOdJ+wHFWTYht66DyROlw/aYW4dhrNiA/TygbIp2FzuM5VOrN1rTrq+4VOP5s4hOdKSBwSiJxEYBbjoygvJd59u/URxwILc50NBdEykUyYd+6CD3O7lgw81oatlbO/1NTvv+WJWPqp4ChjNx14AzdyjbVdNDqYOR6UyBSui1HjiJu5sYdNb3SwpjpYFdjMRuS2bkA1Q27VQqLBuBCsptZ8/u5irIpe0ipPeCUUsiNWcUqwHBOlYlPqw7bzW6E19fFLLpVBYBaXpWVRmZyKQzgVhL2w==
Received: from KASONG-MB2.tencent.com ([114.254.2.8])
        by smtp.gmail.com with ESMTPSA id g37-20020a635665000000b005d748902a01sm6661064pgm.43.2024.02.05.03.10.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Feb 2024 03:10:31 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yu Zhao <yuzhao@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH] mm/swap: fix race condition in direct swapin path
Date: Mon,  5 Feb 2024 19:09:59 +0800
Message-ID: <20240205110959.4021-1-ryncsn@gmail.com>
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

In the direct swapin path, when two or more threads swapin the same entry
at the same time, they get different pages (A, B) because swap cache is
skipped. Before one thread (T0) finishes the swapin and installs page (A)
to the PTE, another thread (T1) could finish swapin of page (B),
swap_free the entry, then modify and swap-out the page again, using the
same entry. It break the pte_same check because PTE value is unchanged,
causing ABA problem. Then thread (T0) will then install the stalled page
(A) into the PTE so new data in page (B) is lost, one possible callstack
is like this:

CPU0                                CPU1
----                                ----
do_swap_page()                      do_swap_page() with same entry
<direct swapin path>                <direct swapin path>
<alloc page A>                      <alloc page B>
swap_readpage() <- read to page A   swap_readpage() <- read to page B
<slow on later locks or interrupt>  <finished swapin first>
..                                 set_pte_at()
                                    swap_free() <- Now the entry is freed.
                                    <write to page B, now page A stalled>
                                    <swap out page B using same swap entry>
pte_same() <- Check pass, PTE seems
              unchanged, but page A
              is stalled!
swap_free() <- page B content lost!
set_pte_at() <- staled page A installed!

To fix this, reuse swapcache_prepare which will pin the swap entry using
the cache flag, and allow only one thread to pin it. Release the pin
after PT unlocked. Racers will simply busy wait since it's a rare
and very short event.

Other methods like increasing the swap count don't seem to be a good
idea after some tests, that will cause racers to fall back to the
cached swapin path, two swapin path being used at the same time
leads to a much more complex scenario.

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
Signed-off-by: Kairui Song <kasong@tencent.com>
---
Huge thanks to Huang Ying and Chris Li for help finding this issue!

 mm/memory.c   | 19 +++++++++++++++++++
 mm/swap.h     |  5 +++++
 mm/swapfile.c | 16 ++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 7e1f4849463a..fd7c55a292f1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3867,6 +3867,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
+			/*
+			 * With swap count == 1, after we read the entry,
+			 * other threads could finish swapin first, free
+			 * the entry, then swapout the modified page using
+			 * the same entry. Now the content we just read is
+			 * stalled, and it's undetectable as pte_same()
+			 * returns true due to entry reuse.
+			 *
+			 * So pin the swap entry using the cache flag even
+			 * cache is not used.
+			 */
+			if (swapcache_prepare(entry))
+				goto out;
+
 			/* skip swapcache */
 			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
 						vma, vmf->address, false);
@@ -4116,6 +4130,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
+	/* Clear the swap cache pin for direct swapin after PTL unlock */
+	if (folio && !swapcache)
+		swapcache_clear(si, entry);
 out:
 	if (si)
 		put_swap_device(si);
@@ -4124,6 +4141,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
index 556ff7347d5f..f7d4ad152a7f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3365,6 +3365,22 @@ int swapcache_prepare(swp_entry_t entry)
 	return __swap_duplicate(entry, SWAP_HAS_CACHE);
 }
 
+/*
+ * Clear the cache flag and release pinned entry.
+ */
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


