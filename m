Return-Path: <linux-kernel+bounces-61473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE708512C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829ABB26936
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CF73B1A4;
	Mon, 12 Feb 2024 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FtzoP6uu"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B739AC9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738929; cv=none; b=hJJwHrNYhKqYiL8LGOvPANUyE5cEXenQPt9G07D4HUFjNQMqBZxVO7pAxAFhNiLpKnxtXGduTkLk6UEvY/umkfp6b9EgAd2l2xQA9Rozb24N2mF9IHCNduiroNIGz06ce6pQ9e4k5GqEb/Fsyo+6ryFXmYFZWPGxWZ8Ao/xFXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738929; c=relaxed/simple;
	bh=HTmS7KgIHpTSgp6cqH/ynIQyNkUm0EieqPOuHqM5KOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O1czKxAtO6dqr+TXYF2JVrt3SgOxc2Ot4Eqg2kw6iuhoMXj7nn4yqoHAM00Pbg1CuH72ZuVU7vt4gkmsp+NQsi8oCthje/y6lCU7Iv/FmUuKRmBCsCXig+qr0ywZm1WB3RSAsqL1ntsepumbbvLC/rdNybybE2/k1sPTthAocm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FtzoP6uu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a30f7c9574eso361733466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738925; x=1708343725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCAe8mO/KUlyg+BnRuX+JoIprh3UWXF6vcGK++EkmGw=;
        b=FtzoP6uuzZxgJVOV82ndafgsvNCeE8feMZmNCuNkR0kenbQ0mgfzU050l38YuOllLD
         6mOBSJoZOXOYsZ8KehoaT89Qt1U24EEEKidC2vUIncVIDRsHqtely8ZBFz47obUUGTq2
         NlJh73nHZ9A0nAL0GzkkbR2TrLRQ0qhv/NCLv9kUYnBhfXfUpdHXvCTyss33iHg7OxzC
         6Y3iNNDsLLLJayiXda8o87ADPiHqxkCH1xfi/hL8xvtLty8yMki4HNCr0DjNbvioPNQw
         j/0iWbUGwfdCmkWC7eigjYDinpi2F1uvATWXcPjbyWvBIIAHr3lxbRdzAp7+414DcCwP
         Lzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738925; x=1708343725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCAe8mO/KUlyg+BnRuX+JoIprh3UWXF6vcGK++EkmGw=;
        b=OgLXo96dw8RC48quawuHvfKcAo8GM9Wu6bxD3t4zb75U573sEYLFKEv83RvQkbg797
         bOGUNrtkL4zAAOiKxU7LOFe/PqIu7Yqkc6T0ValeRXtDl/sfV2TRPbaVhuoPueOCBfLG
         uMmrTbRLLr+IR6VZV8/EjHPrryzHK/NMa2v4FEfjt4X/MFbsZjW3rzNxDo6TimGWEqCi
         hyCSXl3ptNry3WjSWB6cXQK4d5+spmBpz2RbucAZNnU+rJNInUZmf3nFo6FZh0cGFC5c
         VOfmmR8A7FR1DkngTnp2CgrJcqup1Frm46gngxKcxh55MSWspDNjCocjzESL9iEEJIJ4
         zSbQ==
X-Gm-Message-State: AOJu0Yy98Lv4UsjsyqBz2ze/uJEH42DwoWjOqWu2jpN6aN0G5foTcbCs
	AJrMrokPjqHbYZ3d1sHGXTM+1rMkqDEBiXgLTBu9T6yPny2lYWKG5OMxU7G9xuX0uHyM75ueNml
	U
X-Google-Smtp-Source: AGHT+IHrh9pm2vOubQmRuvG9zcz4pYU/cOY7wSLLg7Yy4lsjcaxCzpebTGm/W1ZW3INiK8ZJpfRFPw==
X-Received: by 2002:a17:906:ece8:b0:a38:1673:682a with SMTP id qt8-20020a170906ece800b00a381673682amr4804067ejb.32.1707738924971;
        Mon, 12 Feb 2024 03:55:24 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:24 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 12/35] bvec.h: move declarations to bvec_types.h
Date: Mon, 12 Feb 2024 12:54:37 +0100
Message-Id: <20240212115500.2078463-13-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
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


