Return-Path: <linux-kernel+bounces-145654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C28C8A5904
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB951F218B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1F783A10;
	Mon, 15 Apr 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJLQUOs1"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342585268
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201563; cv=none; b=BtbxKhWmXsvIcauTrHEXMMABsQrJl4YHJrz5hDZI89zfzEvJUltpBAxYu2hmK7q2u35ukZ3gljOoTkn8lP6w4NaI7G1uzHO/at5C3FNj107TRjd1IU75LcqQY81gXhB42pOeq7SqX6QkfUN6TNN/k2sqpj/gTdgiwhBZjSA2vbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201563; c=relaxed/simple;
	bh=pDqpPLj4qmpz6qIGdATZILDnKVbrqLD2jtZdMCM1byo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InU3vBYTAt+f3KvyuN1lg1VTRL3LzUoxR3Lj9CF1y8XL7w2CiAGBD89aT/xTWRvSNwrLk93XsGrnJ9Ks6pcbnzRlLJkbBSMkwBxOgR8FghEtwYilZE6siJd49wCfPAJz6Y86+bFIfroS6kxZtJQWylxi55ZZX4qhnrEC1D7ccqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJLQUOs1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so997955a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713201561; x=1713806361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ftt1wlC5vn+OAyWyZNr8D22lSmnA0oAAZ/IwpKgu3E=;
        b=JJLQUOs1Pdh+vNoK2d8VxpuRCZwf7Jf62rQkmwsoUWmHOUTPU6lYzhtCWia1/8Bm+Q
         6ZKedxKVz8mOKLbfCxK4Ev6Tyh/VPAIHoL3XpAClgzmHrd8kr3w9VeY9YR7RCox7FYtI
         RPZ1SdUcDsQQA0diPoO5c+kNOPiUZ/QJro1cNI5IYNZvx3JH/j5CLa57DJxvzSXqbaId
         r//nqibSlsVZ2tPY9F2Y3REy2AIOkg9QNUFSVn2emWxpyRmZ7cNr5ikJ2hxk5fXnUNkY
         hrhOxuUIN6T/nRchcodQR8IRN786nb/88zRnDOznu8GMi2htkkuYJb8WRk3Eism8I2Pi
         NwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201561; x=1713806361;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ftt1wlC5vn+OAyWyZNr8D22lSmnA0oAAZ/IwpKgu3E=;
        b=PET+MXSvVF0F+8ajiKMZ0jWDqILlpqEebl844SScObWX6+OPS5VOMTPp6mpS2CArrg
         qBVdLvIo3zbsJWHZl3ENj+7HnXpn3Vrj5unK7sGK+jd6xgJ/evJVxsfrwaXi3WYLBITd
         w0bFA/DrXazOQwm8hMRKu9rXvTnPnXd7twigsfk1hln+oHfaIB5wZwsuplOG601JA3Zg
         K/kGfUAYSVuPMngytrp7E8y7g3VrV6vNCCAlYtmWpRvPCGM74QkHyGLwltaQcRpLkZxk
         bATlIBNMffm5AFt8xH52FWMaAf2m6UQi63SnIaPkoZf+NJjkGHA1plTlJw+CAvX3cgPI
         KHPA==
X-Forwarded-Encrypted: i=1; AJvYcCUFEAdmoQNa0PoJpQXPDvJgFm00uVHSGwz42fBMY/pJf0tQDjMPT5iC/PwQThm7Bfr6DH7J+hOXUvp7/4geFy5qhWjQTfAqCWsxHnhy
X-Gm-Message-State: AOJu0YxdrVs4oCFSKoB9Jry++WFthl+qhAV0cuoHuHRyzzFPbGcEcAwR
	MmfzzszzRzsgmHZY5QGa1bjWxEn7i9/ompCu5UUWJqlywp4b+9zL
X-Google-Smtp-Source: AGHT+IF5I7CUmmaoFvwK3SVG9GhKVEy4AarbCQA8oQBcJAZLx+3bOZ1JGWosjLM5SoLJEKPUKgit5A==
X-Received: by 2002:a17:90a:f2d7:b0:2a2:b9f8:e0b0 with SMTP id gt23-20020a17090af2d700b002a2b9f8e0b0mr6933990pjb.19.1713201560649;
        Mon, 15 Apr 2024 10:19:20 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a537abb536sm8751648pjq.57.2024.04.15.10.19.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Apr 2024 10:19:20 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 4/4] mm/filemap: optimize filemap folio adding
Date: Tue, 16 Apr 2024 01:18:56 +0800
Message-ID: <20240415171857.19244-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415171857.19244-1-ryncsn@gmail.com>
References: <20240415171857.19244-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Instead of doing multiple tree walks, do one optimism range check with
lock hold, and exit if raced with another insertion.  If a shadow exists,
check it with a new xas_get_order helper before releasing the lock to
avoid redundant tree walks for getting its order.

Drop the lock and do the allocation only if a split is needed.

In the best case, it only need to walk the tree once.  If it needs to
alloc and split, 3 walks are issued (One for first ranged conflict check
and order retrieving, one for the second check after allocation, one for
the insert after split).

Testing with 4K pages, in an 8G cgroup, with 16G brd as block device:

  echo 3 > /proc/sys/vm/drop_caches

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
    --buffered=1 --ioengine=mmap --rw=randread --time_based \
    --ramp_time=30s --runtime=5m --group_reporting

Before:
bw (  MiB/s): min= 1027, max= 3520, per=100.00%, avg=2445.02, stdev=18.90, samples=8691
iops        : min=263001, max=901288, avg=625924.36, stdev=4837.28, samples=8691

After (+7.3%):
bw (  MiB/s): min=  493, max= 3947, per=100.00%, avg=2625.56, stdev=25.74, samples=8651
iops        : min=126454, max=1010681, avg=672142.61, stdev=6590.48, samples=8651

Test result with THP (do a THP randread then switch to 4K page in hope it
issues a lot of splitting):

  echo 3 > /proc/sys/vm/drop_caches

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
      --buffered=1 --ioengine=mmap -thp=1 --readonly \
      --rw=randread --time_based --ramp_time=30s --runtime=10m \
      --group_reporting

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
      --buffered=1 --ioengine=mmap \
      --rw=randread --time_based --runtime=5s --group_reporting

Before:
bw (  KiB/s): min= 4141, max=14202, per=100.00%, avg=7935.51, stdev=96.85, samples=18976
iops        : min= 1029, max= 3548, avg=1979.52, stdev=24.23, samples=18976·

READ: bw=4545B/s (4545B/s), 4545B/s-4545B/s (4545B/s-4545B/s), io=64.0KiB (65.5kB), run=14419-14419msec

After (+12.5%):
bw (  KiB/s): min= 4611, max=15370, per=100.00%, avg=8928.74, stdev=105.17, samples=19146
iops        : min= 1151, max= 3842, avg=2231.27, stdev=26.29, samples=19146

READ: bw=4635B/s (4635B/s), 4635B/s-4635B/s (4635B/s-4635B/s), io=64.0KiB (65.5kB), run=14137-14137msec

The performance is better for both 4K (+7.5%) and THP (+12.5%) cached read.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 lib/test_xarray.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 mm/filemap.c      | 56 ++++++++++++++++++++++++++++++++------------
 2 files changed, 100 insertions(+), 15 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 0efde8f93490..8732a311f613 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -2017,6 +2017,64 @@ static noinline void check_xas_get_order(struct xarray *xa)
 	}
 }
 
+static noinline void check_xas_conflict_get_order(struct xarray *xa)
+{
+	XA_STATE(xas, xa, 0);
+
+	void *entry;
+	int only_once;
+	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 20 : 1;
+	unsigned int order;
+	unsigned long i, j, k;
+
+	for (order = 0; order < max_order; order++) {
+		for (i = 0; i < 10; i++) {
+			xas_set_order(&xas, i << order, order);
+			do {
+				xas_lock(&xas);
+				xas_store(&xas, xa_mk_value(i));
+				xas_unlock(&xas);
+			} while (xas_nomem(&xas, GFP_KERNEL));
+
+			/*
+			 * Ensure xas_get_order works with xas_for_each_conflict.
+			 */
+			j = i << order;
+			for (k = 0; k < order; k++) {
+				only_once = 0;
+				xas_set_order(&xas, j + (1 << k), k);
+				xas_lock(&xas);
+				xas_for_each_conflict(&xas, entry) {
+					XA_BUG_ON(xa, entry != xa_mk_value(i));
+					XA_BUG_ON(xa, xas_get_order(&xas) != order);
+					only_once++;
+				}
+				XA_BUG_ON(xa, only_once != 1);
+				xas_unlock(&xas);
+			}
+
+			if (order < max_order - 1) {
+				only_once = 0;
+				xas_set_order(&xas, (i & ~1UL) << order, order + 1);
+				xas_lock(&xas);
+				xas_for_each_conflict(&xas, entry) {
+					XA_BUG_ON(xa, entry != xa_mk_value(i));
+					XA_BUG_ON(xa, xas_get_order(&xas) != order);
+					only_once++;
+				}
+				XA_BUG_ON(xa, only_once != 1);
+				xas_unlock(&xas);
+			}
+
+			xas_set_order(&xas, i << order, order);
+			xas_lock(&xas);
+			xas_store(&xas, NULL);
+			xas_unlock(&xas);
+		}
+	}
+}
+
+
 static noinline void check_destroy(struct xarray *xa)
 {
 	unsigned long index;
@@ -2069,6 +2127,7 @@ static int xarray_checks(void)
 	check_multi_store_advanced(&array);
 	check_get_order(&array);
 	check_xas_get_order(&array);
+	check_xas_conflict_get_order(&array);
 	check_xa_alloc();
 	check_find(&array);
 	check_find_entry(&array);
diff --git a/mm/filemap.c b/mm/filemap.c
index 17a66ea544e7..7b0b2229d4ed 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -852,7 +852,9 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
-	bool huge = folio_test_hugetlb(folio);
+	void *alloced_shadow = NULL;
+	int alloced_order = 0;
+	bool huge;
 	long nr;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -861,6 +863,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
 	xas_set_order(&xas, index, folio_order(folio));
+	huge = folio_test_hugetlb(folio);
 	nr = folio_nr_pages(folio);
 
 	gfp &= GFP_RECLAIM_MASK;
@@ -868,16 +871,10 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	folio->mapping = mapping;
 	folio->index = xas.xa_index;
 
-	do {
-		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
+	for (;;) {
+		int order = -1, split_order = 0;
 		void *entry, *old = NULL;
 
-		if (order > folio_order(folio)) {
-			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
-					order, gfp);
-			if (xas_error(&xas))
-				goto error;
-		}
 		xas_lock_irq(&xas);
 		xas_for_each_conflict(&xas, entry) {
 			old = entry;
@@ -885,19 +882,33 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 				xas_set_err(&xas, -EEXIST);
 				goto unlock;
 			}
+			/*
+			 * If a larger entry exists,
+			 * it will be the first and only entry iterated.
+			 */
+			if (order == -1)
+				order = xas_get_order(&xas);
+		}
+
+		/* entry may have changed before we re-acquire the lock */
+		if (alloced_order && (old != alloced_shadow || order != alloced_order)) {
+			xas_destroy(&xas);
+			alloced_order = 0;
 		}
 
 		if (old) {
-			if (shadowp)
-				*shadowp = old;
-			/* entry may have been split before we acquired lock */
-			order = xa_get_order(xas.xa, xas.xa_index);
-			if (order > folio_order(folio)) {
+			if (order > 0 && order > folio_order(folio)) {
 				/* How to handle large swap entries? */
 				BUG_ON(shmem_mapping(mapping));
+				if (!alloced_order) {
+					split_order = order;
+					goto unlock;
+				}
 				xas_split(&xas, old, order);
 				xas_reset(&xas);
 			}
+			if (shadowp)
+				*shadowp = old;
 		}
 
 		xas_store(&xas, folio);
@@ -913,9 +924,24 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 				__lruvec_stat_mod_folio(folio,
 						NR_FILE_THPS, nr);
 		}
+
 unlock:
 		xas_unlock_irq(&xas);
-	} while (xas_nomem(&xas, gfp));
+
+		/* split needed, alloc here and retry. */
+		if (split_order) {
+			xas_split_alloc(&xas, old, split_order, gfp);
+			if (xas_error(&xas))
+				goto error;
+			alloced_shadow = old;
+			alloced_order = split_order;
+			xas_reset(&xas);
+			continue;
+		}
+
+		if (!xas_nomem(&xas, gfp))
+			break;
+	}
 
 	if (xas_error(&xas))
 		goto error;
-- 
2.44.0


