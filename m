Return-Path: <linux-kernel+bounces-117560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDC088AC97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C8B1FA3A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352113E401;
	Mon, 25 Mar 2024 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9PMTRzo"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199C713E040
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386863; cv=none; b=TEQDtR5g2Ti2xmWFYLRsGPUaEEkdpl0Mspf0OK4MhSvr8fdU0hKZsBkJmUftjhoCEhWIlV+umxThBnPCPUJ0K5/NWdgkC3DGRBgNy1cWywZCBZkhKGCd5SCJmxvj0PZ3fxUiSH9S11dQZkDXRJLiCSXCLh9nL8UxTiS9GMZMexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386863; c=relaxed/simple;
	bh=iPw0XrxbGujTBmrqCR3womr127ESmPQ9iYgG7xlX2ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQi3PcM0/GXN9aHOeKTMQdQn2zI7IGbYW56Tqf71vFnbHG82fQtVHV2F1xeePjbRcAVA0itSMWuJuwpiPH2rQnT3JVaav62KRjlAyl1DPrr+qjNnc24H3ULCgE5sC4ZQ2BYv7zrYCpgAD5yXzIeQRjmAdg13OMww394U9j+Exc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9PMTRzo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6c0098328so3054255b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711386861; x=1711991661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bxkVFzSJVoLggCSIdplAlTRqteX3zHBKMrMrFYGST98=;
        b=L9PMTRzoDJZN3HSwEq+F8FTMEIFQ8bq011jjck3UWbdMWvbKZ1bwEnR+LKRcuRxvcn
         nRu60PfgSgtwU8iYf4Bk6jYt8ZI/JAQTR0hQERuEzgtb2U+wQY6L90XagPRjx/OM70VX
         MhSjLt4gb8NRbbqyRVqxOMGKakqxbHDGIvHW8XjOA2wTeC3fpcrJNl7trZNWZLTjiOwD
         uYx+AmgPsut+lUHc2fuijfPCyIssJrjEn1pk/KxdsqOSFeYik1OTqlGZQvgyCFHGrWUG
         NzPfJQSUoMJBpSuHcskn3aHmUEJ7FnV9XuKUg+H/a3W4aWZ4oh/HXPpOyqyY//GqDdMM
         kruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386861; x=1711991661;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxkVFzSJVoLggCSIdplAlTRqteX3zHBKMrMrFYGST98=;
        b=k5ANQDIAI7APOaABOKfWuG7jTuPD8CiT6UKgcexaHKDg0OIKVCMUGLpw8WbL9tjun+
         7hpv3bCyZuzrWPhiMk0wiRp5FL9Q1tPyoioJx7SBZmHS/yXVcYrkQt5TmAF0n7/MV7Mu
         lu/SeMnamZf1mbBgabZIsoAineliu71kCp7FcQ4csUrRn/3iKylLhDrP47Su3aE/1Nt/
         KPtsusm6flT2maq8c3bcx3CZLj7tP0IFkb9V3s9moQ6FzHtQCvZ7CuAflBg0EUiS96WE
         NQxWYnOLJ/PKEqOevog7igDIcEjAtvILZrJAsdpqM83OYn/8sxkCPs4clbRRehj3sKw3
         NOOg==
X-Forwarded-Encrypted: i=1; AJvYcCUk7YKmDzLleu82jRSi3h/+ug6ZevKyNnMF2HKxnE+s+PM9z5QQR5QYaOK6TddoAhc2lI02e146GeLVjFsbtHHY1/Xbc9ytgTp0Lqam
X-Gm-Message-State: AOJu0Yzr6NOXQehdZfFakvL8kuEnu1wrd5JjYfWQ9BGd/wGjqIp50cIz
	z1bkEPUuVoaGMVgLGqa6ZdNnChOvYqs1KhHAN7blKdHq2EY+6y3P
X-Google-Smtp-Source: AGHT+IHqt40rBnvxQlAYOk3f3IH9W03fIAB5lQLk0ER2F//3YE3Sl2ab/cKHdSL/dz1j/62/GlTTNw==
X-Received: by 2002:a05:6a00:399f:b0:6e6:8b59:1bad with SMTP id fi31-20020a056a00399f00b006e68b591badmr8163470pfb.25.1711386860921;
        Mon, 25 Mar 2024 10:14:20 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id r16-20020a63d910000000b005dc5129ba9dsm6001812pgg.72.2024.03.25.10.14.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Mar 2024 10:14:20 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 4/4] mm/filemap: optimize filemap folio adding
Date: Tue, 26 Mar 2024 01:14:05 +0800
Message-ID: <20240325171405.99971-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325171405.99971-1-ryncsn@gmail.com>
References: <20240325171405.99971-1-ryncsn@gmail.com>
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

Instead of doing multiple tree walks, do one optimism range check
with lock hold, and exit if raced with another insertion. If a shadow
exists, check it with a new xas_get_order helper before releasing the
lock to avoid redundant tree walks for getting its order.

Drop the lock and do the allocation only if a split is needed.

In the best case, it only need to walk the tree once. If it needs
to alloc and split, 3 walks are issued (One for first ranged
conflict check and order retrieving, one for the second check after
allocation, one for the insert after split).

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
 lib/test_xarray.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 mm/filemap.c      | 56 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 98 insertions(+), 15 deletions(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 26e28b65d60a..f0e02a1ee3d5 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -2015,6 +2015,62 @@ static noinline void check_xas_get_order(struct xarray *xa)
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
+				xas_lock(&xas);
+				xas_set_order(&xas, j + (1 << k), k);
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
+				xas_lock(&xas);
+				xas_set_order(&xas, (i & ~1UL) << order, order + 1);
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
+			xas_store(&xas, NULL);
+		}
+	}
+}
+
+
 static noinline void check_destroy(struct xarray *xa)
 {
 	unsigned long index;
@@ -2067,6 +2123,7 @@ static int xarray_checks(void)
 	check_multi_store_advanced(&array);
 	check_get_order(&array);
 	check_xas_get_order(&array);
+	check_xas_conflict_get_order(&array);
 	check_xa_alloc();
 	check_find(&array);
 	check_find_entry(&array);
diff --git a/mm/filemap.c b/mm/filemap.c
index 6bbec8783793..90b86f22a9df 100644
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
2.43.0


