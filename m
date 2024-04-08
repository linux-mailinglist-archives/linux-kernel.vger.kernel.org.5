Return-Path: <linux-kernel+bounces-135310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2386389BEB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A2ECB23773
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6BC6A352;
	Mon,  8 Apr 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wg9Y+bNO"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A56F065
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578490; cv=none; b=luQIKSRJUOW/w4PdMPKh6qkdSbhneX2yAOxtsuOFUVyV4nmItVKVrturNunQ9f90uV0JwKVYMTNxyXvIR0sm1VdXNwKKy5j3OQnFFNGUgt00xQVKHIJxaVkr6FdU7hMaVCPnqsJJl19Lvql9sSkWb4/eGyFLm7bvUO/aGKxRM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578490; c=relaxed/simple;
	bh=K85CdXy6VdcxA0gwmSB8c4kMdbKtGSBBwLSLRWqSPIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YeTshVBkgzaUTQ4e2vOGikwWgjb84e3m2/nF8PePIvvTOOBEQA13qezRnGeqR6Wzd6N3T8CKb9I9Up1po6b1GGHgs0osrsoFA1DD8BmoAmrqfPWeNwUATEs7cfQyr+S3Vndkbrv/eog6s0eIMe1rO/f8rym+T1EWvofrg9fBKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wg9Y+bNO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a2474f2595so3572201a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712578486; x=1713183286; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkNlcb91n/5YmjH6EI5qNjc9lwvi5OJF+TEyy7RKmos=;
        b=Wg9Y+bNOMqsqlO7ShuhKKPywB90gDFDiAJ8MShWaqgmwIVMt/w/rj1wnNai+FoAkij
         44aT4q1kEa+fMcqSdHC6EHpRTw8xsBdqgGO5/H7GYn3A3Y2h6Nt7j9klk6Ch5QWs+Ll3
         Oyjf5GwQDrQTPvuk8F9UsTOTILRYiamxPmETUFLSgjWGOXhuWLv7ZrVhfkb8/bqIAflO
         mJQ4jR+yEFfLFr4rlXxHBDAXh3I7za3OJNMZ+OI+8JLF5o5bJ84SnTtuxn0cgmwzCUr3
         RzCdgsSIWSFWPeY9UxI+aCU4VwC9OUUsm2jTzA2/ndQf0tEXGJQbB9lRU8CCH7E9kRpN
         dquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712578486; x=1713183286;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkNlcb91n/5YmjH6EI5qNjc9lwvi5OJF+TEyy7RKmos=;
        b=qZiRGTxK24AS0zg2giyWMJeEEVPYTUF89UCeHqm9bIk6+FSmrsjYRMS6umVQKgg7ju
         Deka5dy5RHY6/hfeAjrv3UmMtqyHTUhD++hYDF6htK54EX09ncwOenPIRCSa3E+S4T/h
         cwWl8LBAbWVdxAKPwBZmOS9yFPSKS7X1axJBUdmjyo/Q6QvQbDD/o0l4VJ343aTQdcLf
         pF6B73g4myCVROQLiX5yNSn+I5wNl864mpDJB4w3Xlz4kmahcb9TWibFKT7jwZwZWEVF
         U7stF1cD0VjalHdCwFSohmR6IOCMhH6fpK/LsSWTjCg2KscCrj3HupS6JFnbeZ4Lf3Dv
         OjqA==
X-Forwarded-Encrypted: i=1; AJvYcCVBK/q2i0VsAkwbws1ImuTOfkp5I9GVdUkm9X2uK3ksrk2bex+Lh/fWoPRCG3+H3Cl6JZqQTav5qQvl06eq9137JgvIvrAQECB3SkHl
X-Gm-Message-State: AOJu0YzIOMmhrqWxlW9XfxWZH6Ef07IlH/UmZiJL3PGeAiwbc82Tm6ag
	IjR0vME0bqDHdpFfDwjN64c9ic8/AtCPovRHNYuRCLZzEx+NAx3XGS0PuMF/+WU=
X-Google-Smtp-Source: AGHT+IHZn4xNPFft1trJmRLs125/y+NhZFRZEO2EJIN/Viow45Qbc63czU6NPOJZBdzamMEkO23U5g==
X-Received: by 2002:a17:90a:43c4:b0:29b:c9ac:c563 with SMTP id r62-20020a17090a43c400b0029bc9acc563mr6824401pjg.19.1712578486691;
        Mon, 08 Apr 2024 05:14:46 -0700 (PDT)
Received: from bytedance ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090abc8100b002a28f39db9asm6268087pjr.53.2024.04.08.05.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:14:46 -0700 (PDT)
Date: Mon, 8 Apr 2024 20:14:39 +0800
From: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
To: akpm@linux-foundation.org, ryncsn@gmail.com, nphamcs@gmail.com
Cc: ying.huang@intel.com, songmuchun@bytedance.com, david@redhat.com,
	chrisl@kernel.org, guo.ziliang@zte.com.cn, yosryahmed@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] mm: swap: prejudgement swap_has_cache to avoid page
 allocation
Message-ID: <20240408121439.GA252652@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Based on qemu arm64 - latest kernel + 100M memory + 1024M swapfile.
Create 1G anon mmap and set it to shared, and has two processes
randomly access the shared memory. When they are racing on swap cache,
on average, each "alloc_pages_mpol + swapcache_prepare + folio_put"
took about 1475 us.

So skip page allocation if SWAP_HAS_CACHE was set, just
schedule_timeout_uninterruptible and continue to acquire page
via filemap_get_folio() from swap cache, to speedup
__read_swap_cache_async.

Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>
---
Changes in v2:
  - Fix the patch format and rebase to latest linux-next.
---
 include/linux/swap.h |  6 ++++++
 mm/swap_state.c      | 10 ++++++++++
 mm/swapfile.c        | 15 +++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 11c53692f65f..a374070e05a7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -492,6 +492,7 @@ extern sector_t swapdev_block(int, pgoff_t);
 extern int __swap_count(swp_entry_t entry);
 extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
+extern bool swap_has_cache(struct swap_info_struct *si, swp_entry_t entry);
 struct swap_info_struct *swp_swap_info(swp_entry_t entry);
 struct backing_dev_info;
 extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
@@ -583,6 +584,11 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
+static inline bool swap_has_cache(struct swap_info_struct *si, swp_entry_t entry)
+{
+	return false;
+}
+
 static inline swp_entry_t folio_alloc_swap(struct folio *folio)
 {
 	swp_entry_t entry;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 642c30d8376c..f117fbf18b59 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -462,6 +462,15 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		if (!swap_swapcount(si, entry) && swap_slot_cache_enabled)
 			goto fail_put_swap;
 
+		/*
+		 * Skipping page allocation if SWAP_HAS_CACHE was set,
+		 * just schedule_timeout_uninterruptible and continue to
+		 * acquire page via filemap_get_folio() from swap cache,
+		 * to speedup __read_swap_cache_async.
+		 */
+		if (swap_has_cache(si, entry))
+			goto skip_alloc;
+
 		/*
 		 * Get a new folio to read into from swap.  Allocate it now,
 		 * before marking swap_map SWAP_HAS_CACHE, when -EEXIST will
@@ -483,6 +492,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		if (err != -EEXIST)
 			goto fail_put_swap;
 
+skip_alloc:
 		/*
 		 * Protect against a recursive call to __read_swap_cache_async()
 		 * on the same entry waiting forever here because SWAP_HAS_CACHE
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3ee8957a46e6..b016ebc43b0d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1511,6 +1511,21 @@ int swp_swapcount(swp_entry_t entry)
 	return count;
 }
 
+/*
+ * Verify that a swap entry has been tagged with SWAP_HAS_CACHE
+ */
+bool swap_has_cache(struct swap_info_struct *si, swp_entry_t entry)
+{
+	pgoff_t offset = swp_offset(entry);
+	struct swap_cluster_info *ci;
+	bool has_cache;
+
+	ci = lock_cluster_or_swap_info(si, offset);
+	has_cache = !!(si->swap_map[offset] & SWAP_HAS_CACHE);
+	unlock_cluster_or_swap_info(si, ci);
+	return has_cache;
+}
+
 static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 					 swp_entry_t entry,
 					 unsigned int nr_pages)
-- 
2.25.1


