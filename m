Return-Path: <linux-kernel+bounces-46645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C353A84423F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C98290ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9189712C559;
	Wed, 31 Jan 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fjWgfBdD"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06C12BF13
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712631; cv=none; b=qnhyX9s3I0mWX1iT8AoFzIHrKZ/8Be5e3ofd0Mib74xEX7r9kvLfW+NuB/YIFFKghZ0lYSTc6g87WIiyPIkrDAp453GXeest7BAwd7ekGJHb1VmTlnanHcQ/zmtxo+oXoXVC6OEbQcLVh3Amyb6lyPmY/qD7LMyrMvDQbX3Bhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712631; c=relaxed/simple;
	bh=nr5Z35SJ6TsMVseA4udiDyZYQLbt12PZ6Zg2bhnq3RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2q4uzMqAEFqk+4QkMuIqeDoo4xIU7l0nXyxD4f2iLzyoxhIcfoxlJGbXUafyNOve4JrG1eAMDmdcFbc30vvddZUNj5s6tmu9N2smkyKNB2AkOU71EOQJ9H3pUwxo20xq1n6UozhyVj47csFNFVCMDyIVCicCytnw7b6KLCV2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fjWgfBdD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so15543745e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712626; x=1707317426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixJxOzrAktkBTAcc5ADo7AICuAwWjUqvYJlGkoY3KJA=;
        b=fjWgfBdDcdVXYC4iF1jz7hY1/IwQhD2Vfq73aTD0x2dScHvtHmBrQDAFDuUmYMLZK1
         liInBl+F9BZBBgHq1ND8GvLL4QAVD4hBH5kTM36vKcGriBsmJiUmW/600FxiNH1ijG5g
         B7ABaPQb5iv8H+4ergxPsPkMhSbF2l850J23OeGTmXOEzWkurHmeWBkloOi+zIhY61vF
         0ndOYqUoh4Dmb843iyYSIFnv0tHQrpc2IaHa0skdjGceygXHKPsc/CVxDfQylhRL/W6y
         j0L9bE5zUBFrRwCarTsS6t/UXmcnC5o5D0oh1ITY3ql8Dqpa4aoyJI+BNr+YObv/rTnm
         yGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712626; x=1707317426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixJxOzrAktkBTAcc5ADo7AICuAwWjUqvYJlGkoY3KJA=;
        b=vU5gbma8urPwVWWOgrjzxVVgNjgaAHsuqRBX7c0YAypBB1qYwmBuNLNyycqsL+dpjs
         H1FoVJ8+1fSZCOzFQcFkD/bYUQdkxM2ree00L3oTmUHAKZmZjJmOamjcthGlqU2oznjM
         UkJ8uO3ARcIatreDltj0RNVjvhLMzZ2RweYElagVhMDP0hc5B5pK+4Rx6hJvoSwjqKKi
         Odq5ljO9NikdoHZIxCMhHEocrIRbA+Bt+QM01K5KzXbIsLSYfMnbaDUlfIJAbaoOdDcd
         tzN3nMEofYMD3mmkf6+ZwTnER8vO2qAyU225TfSHZevRKHANM7qTBorKIszwjjI79iKt
         7QPA==
X-Gm-Message-State: AOJu0Yz2xGDudbPAVJsWT/4KJ7koWZBwVCGNnZGZQkZDIN/eRuV4UPPC
	u/EUQT9lzAgS7lWxIv+x3zPp1gbuSiX7Msf4b6eQ0/DpDOgnxFJloVg7ReTVxcf5ZN1AgsPjynz
	T
X-Google-Smtp-Source: AGHT+IFtI47RiGnZH8ttx349bnjHnGWVnFQksaGX6/AipBP646uXmqtJJnZwEf/hTNNCECx+lPxidg==
X-Received: by 2002:a05:600c:354f:b0:40f:b376:6021 with SMTP id i15-20020a05600c354f00b0040fb3766021mr1373319wmq.3.1706712626000;
        Wed, 31 Jan 2024 06:50:26 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:24 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 12/28] bvec.h: move declarations to bvec_types.h
Date: Wed, 31 Jan 2024 15:49:52 +0100
Message-Id: <20240131145008.1345531-13-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131145008.1345531-1-max.kellermann@ionos.com>
References: <20240131145008.1345531-1-max.kellermann@ionos.com>
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
index 270454a6703d..6e0749779ca5 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -9,7 +9,7 @@
 #define _LINUX_IOV_ITER_H
 
 #include <linux/uio.h>
-#include <linux/bvec.h>
+#include <linux/bvec_types.h>
 
 typedef size_t (*iov_step_f)(void *iter_base, size_t progress, size_t len,
 			     void *priv, void *priv2);
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


