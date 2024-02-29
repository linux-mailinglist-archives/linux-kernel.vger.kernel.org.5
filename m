Return-Path: <linux-kernel+bounces-85929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1086BCE4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CA11F25193
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EA817547;
	Thu, 29 Feb 2024 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUb2pqt8"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E4134AA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167140; cv=none; b=kc14ZtRD7RDdMQdpLiRveV3JmWPXuIcnefttN4i4TJxWIdeG/cd3+kWaRZE1+yRoZlZbC5fCqhRh/TGNJC3roEN5YApF/iyR4sT5rY6/CP4EDK1I9p92nXVbjUrnB50MO4MxBJoh8jsmL4Ahz46Z4TVFVOg54pzsYGLFJsTiAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167140; c=relaxed/simple;
	bh=/VyAw9wBKYJlNjDR0pZggTu+d9r8B6/nY09fzfomcx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bxxC49O+K0hY3xGgANGpo/ha+oqmlwgKb2rKs4y1/znCx+nwePMGEdvTwPHxqjBRJZVIL46LZq8tDoF9bCH+/xVgNm0bm43djg4RrYITu/LFsbY9+yftaiBoTSe9rPFjaHMUCgHBgtV1q8Pe2oiQlu3v9jJ2CTnhufswrWinehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUb2pqt8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so3489125ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167137; x=1709771937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNEaXVngxEEVFW2r7SF7/R/SOQEyIxB42KfKsKpMTi0=;
        b=fUb2pqt8o3xmFnsDHDQDyBs3KPeRgw9E+Co8rjfitzA6Xqm+NqI8+agnQRbR32jMP4
         OAGqTpiDney/799uXT5Mx8Tn6Gp+AnGKDy4HHNkGEMn0e5U6ipvh8IXHx4yBM4OCTwMJ
         h57wPC0oyGVHkONBiEbG0GAYCK2dHpIkSO7qdNsSAOonOfURPUcYa2gxxxELspzgLY+Y
         p7AUPGL5Ata1tpYrKDg6zDywnYIb7TY3x841dOCQFmLRut4RlM2Tu6+8rr6ALgrO+Ti4
         GskIbA7J2pv2BV9s1SKQtK+TsJ9C+3QkgQUDZLdQOww0gSLQVsU4TTyWmd8h+oyDxaz+
         5DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167137; x=1709771937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNEaXVngxEEVFW2r7SF7/R/SOQEyIxB42KfKsKpMTi0=;
        b=OLXbtkADlwy+menILhjkL3Qv3HLcmaPLw8fluKgKRqWRXWH397oaBpibabKuc5AJhE
         B2R9Tf7nwuMEDIIM9zZ6ONp6EBe8jLFl+AqSjT0lviIWsnDcWO4bNApBVIboNcUU2oqG
         RHXhB14LyFSK/W0iCcqq09zrTPw8xQZj8Z27lT7JcZJ9NEeS0DkwHlPW0XfYzBsR6XGx
         K0k4/bA5aiTIEzOaV1regXI6xvB//G5hqbR96CSUvHU++iiWwEDPf3y8qRyDwqUBYSrG
         FvB0X1dPZI9ahxLl95+Oyw/KmYp1W6S+rwft8QBPdb56CcslWuJ+WZ/crvuMPwl/eq+W
         LmmA==
X-Forwarded-Encrypted: i=1; AJvYcCXEhGEHs6FYQaCOhMSq1y5Ucz15m1Drxrt92otIo6n9kxWZkZEHEDnG7tMLyBqt+hS5pdzX/8dmrElunfpNGkN/qku9NX/n/EpcDGT8
X-Gm-Message-State: AOJu0Ywp57FW7ajuPVryOhTAQ0VFF33XLCcUifMKr24IQ5Lpf6Ds1OEs
	5ma+zE0VWTN09JhTl5LxaiImZf1me6aplriH+SfyPMa7rcWT0gxo
X-Google-Smtp-Source: AGHT+IHR7uqhk7gVftB4fR9v+bC0QoXfZ4ovI4Z48TBsdfkzzx38SqwehsO7O7NBUo+/+reJ8o+fsg==
X-Received: by 2002:a17:902:d38d:b0:1dc:8db3:16e9 with SMTP id e13-20020a170902d38d00b001dc8db316e9mr530965pld.45.1709167137495;
        Wed, 28 Feb 2024 16:38:57 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:5158:ed66:78b3:7fda])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001d9641003cfsm62647pll.142.2024.02.28.16.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:38:57 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	chrisl@kernel.org
Cc: 21cnbao@gmail.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	kasong@tencent.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	hannes@cmpxchg.org,
	linux-arm-kernel@lists.infradead.org,
	Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Minchan Kim <minchan@kernel.org>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH RFC v2 4/5] mm: swap: introduce swapcache_prepare_nr and swapcache_clear_nr for large folios swap-in
Date: Thu, 29 Feb 2024 13:37:52 +1300
Message-Id: <20240229003753.134193-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229003753.134193-1-21cnbao@gmail.com>
References: <20240229003753.134193-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache") supports
one entry only, to support large folio swap-in, we need to handle multiple
swap entries.

Cc: Kairui Song <kasong@tencent.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: SeongJae Park <sj@kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/swap.h |   1 +
 mm/swap.h            |   1 +
 mm/swapfile.c        | 117 ++++++++++++++++++++++++++-----------------
 3 files changed, 72 insertions(+), 47 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b3581c976e5f..2691c739d9a4 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -480,6 +480,7 @@ extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
+extern int swapcache_prepare_nr(swp_entry_t, int nr);
 extern void swap_free(swp_entry_t);
 extern void swap_nr_free(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
diff --git a/mm/swap.h b/mm/swap.h
index fc2f6ade7f80..1cec991efcda 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -42,6 +42,7 @@ void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
+void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, int nr);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c0c058ee7b69..c8c8b6dbaeda 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3308,7 +3308,7 @@ void si_swapinfo(struct sysinfo *val)
 }
 
 /*
- * Verify that a swap entry is valid and increment its swap map count.
+ * Verify that nr swap entries are valid and increment their swap map count.
  *
  * Returns error code in following case.
  * - success -> 0
@@ -3318,66 +3318,73 @@ void si_swapinfo(struct sysinfo *val)
  * - swap-cache reference is requested but the entry is not used. -> ENOENT
  * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
  */
-static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+static int __swap_duplicate_nr(swp_entry_t entry, int nr, unsigned char usage)
 {
 	struct swap_info_struct *p;
 	struct swap_cluster_info *ci;
 	unsigned long offset;
-	unsigned char count;
-	unsigned char has_cache;
-	int err;
+	unsigned char count[SWAPFILE_CLUSTER];
+	unsigned char has_cache[SWAPFILE_CLUSTER];
+	int err, i;
 
 	p = swp_swap_info(entry);
 
 	offset = swp_offset(entry);
 	ci = lock_cluster_or_swap_info(p, offset);
 
-	count = p->swap_map[offset];
-
-	/*
-	 * swapin_readahead() doesn't check if a swap entry is valid, so the
-	 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
-	 */
-	if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
-		err = -ENOENT;
-		goto unlock_out;
-	}
+	for (i = 0; i < nr; i++) {
+		count[i] = p->swap_map[offset + i];
 
-	has_cache = count & SWAP_HAS_CACHE;
-	count &= ~SWAP_HAS_CACHE;
-	err = 0;
-
-	if (usage == SWAP_HAS_CACHE) {
-
-		/* set SWAP_HAS_CACHE if there is no cache and entry is used */
-		if (!has_cache && count)
-			has_cache = SWAP_HAS_CACHE;
-		else if (has_cache)		/* someone else added cache */
-			err = -EEXIST;
-		else				/* no users remaining */
+		/*
+		 * swapin_readahead() doesn't check if a swap entry is valid, so the
+		 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
+		 */
+		if (unlikely(swap_count(count[i]) == SWAP_MAP_BAD)) {
 			err = -ENOENT;
+			goto unlock_out;
+		}
 
-	} else if (count || has_cache) {
-
-		if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
-			count += usage;
-		else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
-			err = -EINVAL;
-		else if (swap_count_continued(p, offset, count))
-			count = COUNT_CONTINUED;
-		else
-			err = -ENOMEM;
-	} else
-		err = -ENOENT;			/* unused swap entry */
-
-	if (!err)
-		WRITE_ONCE(p->swap_map[offset], count | has_cache);
+		has_cache[i] = count[i] & SWAP_HAS_CACHE;
+		count[i] &= ~SWAP_HAS_CACHE;
+		err = 0;
+
+		if (usage == SWAP_HAS_CACHE) {
+
+			/* set SWAP_HAS_CACHE if there is no cache and entry is used */
+			if (!has_cache[i] && count[i])
+				has_cache[i] = SWAP_HAS_CACHE;
+			else if (has_cache[i])		/* someone else added cache */
+				err = -EEXIST;
+			else				/* no users remaining */
+				err = -ENOENT;
+		} else if (count[i] || has_cache[i]) {
+
+			if ((count[i] & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
+				count[i] += usage;
+			else if ((count[i] & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
+				err = -EINVAL;
+			else if (swap_count_continued(p, offset + i, count[i]))
+				count[i] = COUNT_CONTINUED;
+			else
+				err = -ENOMEM;
+		} else
+			err = -ENOENT;			/* unused swap entry */
+	}
 
+	if (!err) {
+		for (i = 0; i < nr; i++)
+			WRITE_ONCE(p->swap_map[offset + i], count[i] | has_cache[i]);
+	}
 unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
 	return err;
 }
 
+static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+{
+	return __swap_duplicate_nr(entry, 1, usage);
+}
+
 /*
  * Help swapoff by noting that swap entry belongs to shmem/tmpfs
  * (in which case its reference count is never incremented).
@@ -3416,17 +3423,33 @@ int swapcache_prepare(swp_entry_t entry)
 	return __swap_duplicate(entry, SWAP_HAS_CACHE);
 }
 
-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+int swapcache_prepare_nr(swp_entry_t entry, int nr)
+{
+	return __swap_duplicate_nr(entry, nr, SWAP_HAS_CACHE);
+}
+
+void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, int nr)
 {
 	struct swap_cluster_info *ci;
 	unsigned long offset = swp_offset(entry);
-	unsigned char usage;
+	unsigned char usage[SWAPFILE_CLUSTER];
+	int i;
 
 	ci = lock_cluster_or_swap_info(si, offset);
-	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
+	for (i = 0; i < nr; i++)
+		usage[i] = __swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE);
 	unlock_cluster_or_swap_info(si, ci);
-	if (!usage)
-		free_swap_slot(entry);
+	for (i = 0; i < nr; i++) {
+		if (!usage[i]) {
+			free_swap_slot(entry);
+			entry.val++;
+		}
+	}
+}
+
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+	swapcache_clear_nr(si, entry, 1);
 }
 
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
-- 
2.34.1


