Return-Path: <linux-kernel+bounces-167119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154038BA4B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5298285633
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B40DDC0;
	Fri,  3 May 2024 00:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deFtn49Y"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FFCCA7D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697460; cv=none; b=Fdh+vo3MFI+qBm8ySjfSAoOmV01LZ+RqyafSeKJ/SvEQMvwdfmdGiRYAORpW3YB9LAe11JfSgRq3wkz2JYfK2ZE7uqrIJpNZPkD1rQ0xyiPV6nMlknVfby/gZnSjV4vBBi7jZfoIlheqW77YvvriMEROIDe6ZywNZ072m7KvXus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697460; c=relaxed/simple;
	bh=tcDnZKQv8l8iz93Yo4hfUJB3P9kNF5o4attE/UqX+GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIA0YBLZuwh4xPmEjLxTmrmkF847i3LE3eQoWhTLpMSSrffICpwT/3HXjWEALea65zgi+L4qOT+9RLrFSwBGyEIHvcmVDVp1oEKPcauMglVTJM3Mmhsz+ofJcYVvI2D6qVhw8PDR0yNU5n99VrhIwEGFNh+K56BEyCjMJ1ReB3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deFtn49Y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ec5387aed9so31516225ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714697458; x=1715302258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFl5l9cUG6TUpWzvnR4XiCKTQilGE1cDMcBQh7vvAdE=;
        b=deFtn49Yv6nvFEJHdXm2g/OaZvkH5u9JxvTUE6ZoI3G8O5PR9sNnbY4faQgyVN7qun
         z0nfineGlK+FzxVDCfjXsYCAkXQdSdHtDmYnt5EOlcxM+8zkBwmx6IVqjH9f1rLD7+QI
         iJF7vNZ1/n3fB6bp2MMA9nXEDrF7E9GIT6kv73KKFfw2sRcIAZ7DTubTO31ZGIEyRQw4
         JtsFizlv0eY/a14FZ84PJGDYRy5X0G16gz55sekR7BIMKQ/KMN9HZwadam6m8G32We9u
         dh6gyJiyVemorpKEUVbFSSCNaiSPTh+9bWXGvg74xvckmgXJnd6LcPRmZjkHBMFkyOZL
         aQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714697458; x=1715302258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFl5l9cUG6TUpWzvnR4XiCKTQilGE1cDMcBQh7vvAdE=;
        b=JVb9tqHUj1fZbvJdpGZZXosGxZ5Id6QrWtGbYqZgdNwJ8Ew0WMmuTcizIm+qNtoTVu
         KZUkew6QoNRBugtuzMS1ejiuOYGMAHK5bPwvWgSkGCWtBYTDFSDUzJIwnJ8Mcn5RXJrx
         jjMnpqSquAZIUboLx/gjiCpFJwao28GE/UqsYsQeK2EKDCclYytLbCluavEmGjBzVzRj
         CXuwMKuEnQuuvJSRFBBqjceHs10aDfPqAYDV6NoYWpO6qokqJ7valOMR2ZKg6yW30lva
         w8hkzRtVXn0L1JzrlQDYZVILzllMBQWGMDAEtRrwl0CIHD4shp4cPIErxCdvTW/ERY0m
         Y4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUfClw4t3yvmApQWGdy/zNdPY+Yc1VJmVS4bW+HeB14pxXqRw5XSJxfOnBep74xcJ5KywXSFSaZ8OSLB2F4VVNYvtum34iEUoHLrLYy
X-Gm-Message-State: AOJu0YyO8vE1tYdYImnR9kd531uuj7yKhl/94Z1i5uib6yl6xFa4CvKb
	Q8+8Sz3dJwSdYrDoVLQkqJIqSY+fGo2l6rww8uJFS6Nwio4JInGz
X-Google-Smtp-Source: AGHT+IHgGPs6Tx/aHvD+V7N1MdRzTr0fR1RogpKIZp6wEsXbZrG/1C29hAfRf2MxmZtp2ra0jMkL5g==
X-Received: by 2002:a17:902:b495:b0:1ea:f7d4:cf2b with SMTP id y21-20020a170902b49500b001eaf7d4cf2bmr1203978plr.17.1714697458583;
        Thu, 02 May 2024 17:50:58 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001ec48e41d2esm1969175plh.212.2024.05.02.17.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 17:50:58 -0700 (PDT)
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
	ziy@nvidia.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH v3 2/6] mm: remove swap_free() and always use swap_free_nr()
Date: Fri,  3 May 2024 12:50:19 +1200
Message-Id: <20240503005023.174597-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503005023.174597-1-21cnbao@gmail.com>
References: <20240503005023.174597-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

To streamline maintenance efforts, we propose discontinuing the use of
swap_free(). Instead, we can simply invoke swap_free_nr() with nr set
to 1. This adjustment offers the advantage of enabling batch processing
within kernel/power/swap.c. Furthermore, swap_free_nr() is designed with
a bitmap consisting of only one long, resulting in overhead that can be
ignored for cases where nr equals 1.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Hugh Dickins <hughd@google.com>
---
 include/linux/swap.h |  5 -----
 kernel/power/swap.c  |  7 +++----
 mm/memory.c          |  2 +-
 mm/rmap.c            |  4 ++--
 mm/shmem.c           |  4 ++--
 mm/swapfile.c        | 19 +++++--------------
 6 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d1d35e92d7e9..f03cb446124e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -482,7 +482,6 @@ extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
-extern void swap_free(swp_entry_t);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
@@ -561,10 +560,6 @@ static inline int swapcache_prepare(swp_entry_t swp)
 	return 0;
 }
 
-static inline void swap_free(swp_entry_t swp)
-{
-}
-
 static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 }
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 5bc04bfe2db1..6befaa88a342 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -181,7 +181,7 @@ sector_t alloc_swapdev_block(int swap)
 	offset = swp_offset(get_swap_page_of_type(swap));
 	if (offset) {
 		if (swsusp_extents_insert(offset))
-			swap_free(swp_entry(swap, offset));
+			swap_free_nr(swp_entry(swap, offset), 1);
 		else
 			return swapdev_block(swap, offset);
 	}
@@ -200,12 +200,11 @@ void free_all_swap_pages(int swap)
 
 	while ((node = swsusp_extents.rb_node)) {
 		struct swsusp_extent *ext;
-		unsigned long offset;
 
 		ext = rb_entry(node, struct swsusp_extent, node);
 		rb_erase(node, &swsusp_extents);
-		for (offset = ext->start; offset <= ext->end; offset++)
-			swap_free(swp_entry(swap, offset));
+		swap_free_nr(swp_entry(swap, ext->start),
+			     ext->end - ext->start + 1);
 
 		kfree(ext);
 	}
diff --git a/mm/memory.c b/mm/memory.c
index eea6e4984eae..f033eb3528ba 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4225,7 +4225,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * We're already holding a reference on the page but haven't mapped it
 	 * yet.
 	 */
-	swap_free(entry);
+	swap_free_nr(entry, 1);
 	if (should_try_to_free_swap(folio, vma, vmf->flags))
 		folio_free_swap(folio);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 087a79f1f611..39ec7742acec 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1865,7 +1865,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				goto walk_done_err;
 			}
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
-				swap_free(entry);
+				swap_free_nr(entry, 1);
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				goto walk_done_err;
 			}
@@ -1873,7 +1873,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			/* See folio_try_share_anon_rmap(): clear PTE first. */
 			if (anon_exclusive &&
 			    folio_try_share_anon_rmap_pte(folio, subpage)) {
-				swap_free(entry);
+				swap_free_nr(entry, 1);
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				goto walk_done_err;
 			}
diff --git a/mm/shmem.c b/mm/shmem.c
index fa2a0ed97507..bfc8a2beb24f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1836,7 +1836,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	 * in shmem_evict_inode().
 	 */
 	shmem_recalc_inode(inode, -1, -1);
-	swap_free(swap);
+	swap_free_nr(swap, 1);
 }
 
 /*
@@ -1927,7 +1927,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 	delete_from_swap_cache(folio);
 	folio_mark_dirty(folio);
-	swap_free(swap);
+	swap_free_nr(swap, 1);
 	put_swap_device(si);
 
 	*foliop = folio;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ec12f2b9d229..ddcd0f24b9a1 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1343,19 +1343,6 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
 	swap_range_free(p, offset, 1);
 }
 
-/*
- * Caller has made sure that the swap device corresponding to entry
- * is still around or has not been recycled.
- */
-void swap_free(swp_entry_t entry)
-{
-	struct swap_info_struct *p;
-
-	p = _swap_info_get(entry);
-	if (p)
-		__swap_entry_free(p, entry);
-}
-
 static void cluster_swap_free_nr(struct swap_info_struct *sis,
 		unsigned long offset, int nr_pages)
 {
@@ -1385,6 +1372,10 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
 	unlock_cluster_or_swap_info(sis, ci);
 }
 
+/*
+ * Caller has made sure that the swap device corresponding to entry
+ * is still around or has not been recycled.
+ */
 void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 	int nr;
@@ -1930,7 +1921,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		new_pte = pte_mkuffd_wp(new_pte);
 setpte:
 	set_pte_at(vma->vm_mm, addr, pte, new_pte);
-	swap_free(entry);
+	swap_free_nr(entry, 1);
 out:
 	if (pte)
 		pte_unmap_unlock(pte, ptl);
-- 
2.34.1


