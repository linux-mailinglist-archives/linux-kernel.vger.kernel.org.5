Return-Path: <linux-kernel+bounces-60993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1FD850C34
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641EE1F21063
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AFD208C1;
	Sun, 11 Feb 2024 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BMlIphIS"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3795179A8
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693349; cv=none; b=K1GN53Sjx6xSSzhr6pV3iSmBom+AWx8JwbYOyLlTsJmgg/K+UOQQWPL750ztDNLIPmB5PlFIcHN8kN0d7hyMJNOoWEZ7NyftZpImYzp5fH9omhdxWt4gqKFRDcml9U5zIOcgewf16gYWQjQGTOcyYl7edEe3n8+i3C5QMITC5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693349; c=relaxed/simple;
	bh=HTmS7KgIHpTSgp6cqH/ynIQyNkUm0EieqPOuHqM5KOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pX73jdiIO29rCXNUrY5EKqoZYVEFQSIn6lfrk6l7huAPPmz/0XbsxgswIHGcz1u4ECr0G9bJNivt/SmjRadqgNXWPuvM/l1eTybx/yxL/phdw7Rr+ueUYdJ7Nttufj3t12DLDtxkd4SUajnxeMQVLQDmENMvzfykaYnMOIfLDY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BMlIphIS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51165a488baso3512421e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693345; x=1708298145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCAe8mO/KUlyg+BnRuX+JoIprh3UWXF6vcGK++EkmGw=;
        b=BMlIphISqBaGsxqLltp9QaHVHWJG+jcPqLFsEdL4XTYg/ahFcJwydSalk4T3ZyIqLd
         jpSkgeH+kzetFdqGz2xjrcxr3kicdAamhgrX4mkvE4OD15w9wKnT6X4EI+KZ8x+FswM0
         ELUZiQsd5b3px6TVigJSQW9c5JVXu3FKVNdrTGC0VTkLT4fIAFyi6AMWpNpJKHGph0Fm
         m2b5wZusqe1GbK9x05MmcFqJrkBQwwaWE79w79KcCB4+a0rZkLevWIgw6Dc02wylF340
         zv26yO8vG1c3Lo7M+b3RsESJXrWm8ulPHyjhdpsIYLtBgYGJm1/NyTUrnWFkyVSX5XhH
         z02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693345; x=1708298145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCAe8mO/KUlyg+BnRuX+JoIprh3UWXF6vcGK++EkmGw=;
        b=Ay/6r64mjxkZkxb70EWj6qQ+Oqy5iss61JLUEVOsplgoIvlNV9KpO2FA8dgjOwHREN
         UrATXWRoTfvqCRAGTMSeYvwVVXsxXhQtW25QsOPf1ptT/JytnagWGDVinqUhzSMkE+Qv
         fQmK2POX8uocY6fMLiI38UoYC6Q2OwlJDaaW2lG5po3Uf2ccP7Gh72Xp8+hOfmw8Xk2z
         Uuo87utYCvire8X0MYulBTZRSBK9Nlc2wjBZnqAzmFoU50hs31ajoblbEHsJ8HJakH7m
         YGQyPFBbTnVWONqhudsjI6WeB8+ULbBNXqdx4aUz+d08Lrx3c+ngnlCM3WTdFyo5ML5G
         032g==
X-Gm-Message-State: AOJu0Yx/wReuCXLKZVB2qlutPTgAms4SK30vO4Zy21M3M0ggW+Wvkfjd
	lzHSrcZV1Ob0qcvTT9GxmN8a0RlCJ0IWKTb8uqGzw75XhqY/F2wY44lRHuXMGfN+cVdyNs3i4wi
	i
X-Google-Smtp-Source: AGHT+IEUH9FcB/cBxomMwKOrRzdPFAofiH2prq4I30aCbLOlTxoD1PGzBeecpR//959bT8w5N6nKUg==
X-Received: by 2002:ac2:4114:0:b0:511:4d99:9ee with SMTP id b20-20020ac24114000000b005114d9909eemr2974937lfi.53.1707693344810;
        Sun, 11 Feb 2024 15:15:44 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:43 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 12/35] bvec.h: move declarations to bvec_types.h
Date: Mon, 12 Feb 2024 00:14:55 +0100
Message-Id: <20240211231518.349442-13-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/blk_types.h  |  2 +-
 include/linux/bvec.h       | 84 +--------------------------------
 include/linux/bvec_types.h | 95 ++++++++++++++++++++++++++++++++++++++
 include/linux/iov_iter.h   |  2 +-
 include/linux/skbuff.h     |  2 +-
 5 files changed, 99 insertions(+), 86 deletions(-)
 create mode 100644 include/linux/bvec_types.h

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1c07848dea7e..9d2d8a8328a6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -7,7 +7,7 @@
 #define __LINUX_BLK_TYPES_H
 
 #include <linux/types.h>
-#include <linux/bvec.h>
+#include <linux/bvec_types.h>
 #include <linux/device.h>
 #include <linux/ktime.h>
 
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 555aae5448ae..fbb79e6ba953 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -7,6 +7,7 @@
 #ifndef __LINUX_BVEC_H
 #define __LINUX_BVEC_H
 
+#include <linux/bvec_types.h>
 #include <linux/highmem.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
@@ -14,26 +15,6 @@
 #include <linux/minmax.h>
 #include <linux/types.h>
 
-struct page;
-
-/**
- * struct bio_vec - a contiguous range of physical memory addresses
- * @bv_page:   First page associated with the address range.
- * @bv_len:    Number of bytes in the address range.
- * @bv_offset: Start of the address range relative to the start of @bv_page.
- *
- * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
- *
- *   nth_page(@bv_page, n) == @bv_page + n
- *
- * This holds because page_is_mergeable() checks the above property.
- */
-struct bio_vec {
-	struct page	*bv_page;
-	unsigned int	bv_len;
-	unsigned int	bv_offset;
-};
-
 /**
  * bvec_set_page - initialize a bvec based off a struct page
  * @bv:		bvec to initialize
@@ -74,69 +55,6 @@ static inline void bvec_set_virt(struct bio_vec *bv, void *vaddr,
 	bvec_set_page(bv, virt_to_page(vaddr), len, offset_in_page(vaddr));
 }
 
-struct bvec_iter {
-	sector_t		bi_sector;	/* device address in 512 byte
-						   sectors */
-	unsigned int		bi_size;	/* residual I/O count */
-
-	unsigned int		bi_idx;		/* current index into bvl_vec */
-
-	unsigned int            bi_bvec_done;	/* number of bytes completed in
-						   current bvec */
-} __packed;
-
-struct bvec_iter_all {
-	struct bio_vec	bv;
-	int		idx;
-	unsigned	done;
-};
-
-/*
- * various member access, note that bio_data should of course not be used
- * on highmem page vectors
- */
-#define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
-
-/* multi-page (mp_bvec) helpers */
-#define mp_bvec_iter_page(bvec, iter)				\
-	(__bvec_iter_bvec((bvec), (iter))->bv_page)
-
-#define mp_bvec_iter_len(bvec, iter)				\
-	min((iter).bi_size,					\
-	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
-
-#define mp_bvec_iter_offset(bvec, iter)				\
-	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
-
-#define mp_bvec_iter_page_idx(bvec, iter)			\
-	(mp_bvec_iter_offset((bvec), (iter)) / PAGE_SIZE)
-
-#define mp_bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= mp_bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= mp_bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= mp_bvec_iter_offset((bvec), (iter)),	\
-})
-
-/* For building single-page bvec in flight */
- #define bvec_iter_offset(bvec, iter)				\
-	(mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
-
-#define bvec_iter_len(bvec, iter)				\
-	min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),		\
-	      PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
-
-#define bvec_iter_page(bvec, iter)				\
-	(mp_bvec_iter_page((bvec), (iter)) +			\
-	 mp_bvec_iter_page_idx((bvec), (iter)))
-
-#define bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
-})
-
 static inline bool bvec_iter_advance(const struct bio_vec *bv,
 		struct bvec_iter *iter, unsigned bytes)
 {
diff --git a/include/linux/bvec_types.h b/include/linux/bvec_types.h
new file mode 100644
index 000000000000..23453c988154
--- /dev/null
+++ b/include/linux/bvec_types.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * bvec iterator
+ *
+ * Copyright (C) 2001 Ming Lei <ming.lei@canonical.com>
+ */
+#ifndef __LINUX_BVEC_TYPES_H
+#define __LINUX_BVEC_TYPES_H
+
+#include <linux/types.h>
+
+struct page;
+
+/**
+ * struct bio_vec - a contiguous range of physical memory addresses
+ * @bv_page:   First page associated with the address range.
+ * @bv_len:    Number of bytes in the address range.
+ * @bv_offset: Start of the address range relative to the start of @bv_page.
+ *
+ * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
+ *
+ *   nth_page(@bv_page, n) == @bv_page + n
+ *
+ * This holds because page_is_mergeable() checks the above property.
+ */
+struct bio_vec {
+	struct page	*bv_page;
+	unsigned int	bv_len;
+	unsigned int	bv_offset;
+};
+
+struct bvec_iter {
+	sector_t		bi_sector;	/* device address in 512 byte
+						   sectors */
+	unsigned int		bi_size;	/* residual I/O count */
+
+	unsigned int		bi_idx;		/* current index into bvl_vec */
+
+	unsigned int            bi_bvec_done;	/* number of bytes completed in
+						   current bvec */
+} __packed;
+
+struct bvec_iter_all {
+	struct bio_vec	bv;
+	int		idx;
+	unsigned	done;
+};
+
+/*
+ * various member access, note that bio_data should of course not be used
+ * on highmem page vectors
+ */
+#define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
+
+/* multi-page (mp_bvec) helpers */
+#define mp_bvec_iter_page(bvec, iter)				\
+	(__bvec_iter_bvec((bvec), (iter))->bv_page)
+
+#define mp_bvec_iter_len(bvec, iter)				\
+	min((iter).bi_size,					\
+	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
+
+#define mp_bvec_iter_offset(bvec, iter)				\
+	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
+
+#define mp_bvec_iter_page_idx(bvec, iter)			\
+	(mp_bvec_iter_offset((bvec), (iter)) / PAGE_SIZE)
+
+#define mp_bvec_iter_bvec(bvec, iter)				\
+((struct bio_vec) {						\
+	.bv_page	= mp_bvec_iter_page((bvec), (iter)),	\
+	.bv_len		= mp_bvec_iter_len((bvec), (iter)),	\
+	.bv_offset	= mp_bvec_iter_offset((bvec), (iter)),	\
+})
+
+/* For building single-page bvec in flight */
+ #define bvec_iter_offset(bvec, iter)				\
+	(mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
+
+#define bvec_iter_len(bvec, iter)				\
+	min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),		\
+	      PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
+
+#define bvec_iter_page(bvec, iter)				\
+	(mp_bvec_iter_page((bvec), (iter)) +			\
+	 mp_bvec_iter_page_idx((bvec), (iter)))
+
+#define bvec_iter_bvec(bvec, iter)				\
+((struct bio_vec) {						\
+	.bv_page	= bvec_iter_page((bvec), (iter)),	\
+	.bv_len		= bvec_iter_len((bvec), (iter)),	\
+	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
+})
+
+#endif /* __LINUX_BVEC_TYPES_H */
diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index c3adba9ff389..060626682481 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -9,7 +9,7 @@
 #define _LINUX_IOV_ITER_H
 
 #include <linux/uio.h>
-#include <linux/bvec.h>
+#include <linux/bvec_types.h>
 #include <linux/highmem.h> // for kmap_local_page()
 
 typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2dde34c29203..8ee67e49699b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -14,7 +14,7 @@
 #include <linux/compiler.h>
 #include <linux/time.h>
 #include <linux/bug.h>
-#include <linux/bvec.h>
+#include <linux/bvec_types.h>
 #include <linux/cache.h>
 #include <linux/rbtree.h>
 #include <linux/socket.h>
-- 
2.39.2


