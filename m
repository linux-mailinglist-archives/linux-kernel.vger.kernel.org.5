Return-Path: <linux-kernel+bounces-60741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EB085090D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE11D1C222B5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43E75C91E;
	Sun, 11 Feb 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GvRlx9M3"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424445B1F8
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654631; cv=none; b=SDK02wEczilFuGBjDzBwvPZtuS4aIb199OSvngKkDnElT6ROwTdX1cfPWzFe8vvyxzqbbxhy4tIdZqrnERC7iwxuKVEcASCpHrYBngmUIfj87KNE2bH4T5nZR46S55wOkvlfYUViIhrRhPt4auENHRZ21n91V/do/qflS+dx4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654631; c=relaxed/simple;
	bh=HTmS7KgIHpTSgp6cqH/ynIQyNkUm0EieqPOuHqM5KOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fu0lPVGnleqCFJEm3pKckOto4hidHeGPRBNZlt7XwxOl46EeBHrrAiOodPKs4H1dcbiX/gMfIu1DTwdJm2LvFn1bLJG/QXj2KeRA73oO2tgAQbbLYt5Kvgs6TeH3kXN0M1+y01SJ6zcDUrq+dgHgczwSIvGp6s4ggrSQQ5cSH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GvRlx9M3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5605c7b1f32so3136862a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654626; x=1708259426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCAe8mO/KUlyg+BnRuX+JoIprh3UWXF6vcGK++EkmGw=;
        b=GvRlx9M3CPd3W7hWoZnTTg12P+dCAptA+9LABJV767k09hXL9fLZcBIlnW3C8m8TH7
         IgIHSYwi2Aw8E598mA1b2rXI5HYB2JefKrE4YwCCm+tKvTxh5OCGN19amn1KgZJ/Z6m1
         3qPxFMHekkfeD8tRcvOtmGY8IlSjmeStY3OCTVfMstnZxGEcqPNpYHTPxDjG+PIjUMzs
         hM30a3UON5IqDHfddOFTY7MwcmZ8IjD7NxPLK1vBXNymWBEEzwnW2a7krnRQUkK+9jqZ
         fBFhF7fUAuf1h132rT1syh3uRVwsEWwiqajZR02RG0p3PE68dj0llYjvzvKZ2Id1XBn0
         Vd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654626; x=1708259426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCAe8mO/KUlyg+BnRuX+JoIprh3UWXF6vcGK++EkmGw=;
        b=vkoFajBnZFooXWxJ3hZJogAzRJjsT3KzIFqV4IO2nVv4j9x1CjInryct7RnZbHFrZ6
         L9bHj1vOYFmeliCfbEOL+qq4mVgER6qJCz+K21CmlARe5nrI3V3eJU1yQTamsbTld9D6
         v50cH7GRSkMGW7uuZx1U0h3oL5kf3QE0nOY8G2SS8Kt5tJO85h0W9bnY/yXuWCjGhGKa
         yXFuME+j6V7Zeq1r1jV8o/hp70fT4BCZKZXTF6f/W3pTawL2p6g3/fKcFaxEueK17Hd1
         gAL//Rg7VxV/pLq29AbGhtvTVxwfrkZE3vPcWVpNbB8djA3AjmsLqLxje+S2w7Veijed
         dAow==
X-Gm-Message-State: AOJu0Yxztw2flL2O9B72TK4kOUQSoYrAzwKxqEpuDyTYxMukSpn0BM3A
	SzZ6v1sbMsUdoAeuLM+x2i6p8GM0sjGWsAwtj7hPRHMGY/w/VypVnwMe6uzkoBIhAHITTb4paeF
	v
X-Google-Smtp-Source: AGHT+IE/MXKB1+acU9beMkNmzzSaiyvEyQw9OWNiBb2qUKFZHpJwup2o3mUgK4EOQTe+BxaYe/6G/A==
X-Received: by 2002:aa7:c3cd:0:b0:560:d73b:aff4 with SMTP id l13-20020aa7c3cd000000b00560d73baff4mr2473856edr.3.1707654626039;
        Sun, 11 Feb 2024 04:30:26 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:25 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 12/35] bvec.h: move declarations to bvec_types.h
Date: Sun, 11 Feb 2024 13:29:37 +0100
Message-Id: <20240211123000.3359365-13-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211123000.3359365-1-max.kellermann@ionos.com>
References: <20240211123000.3359365-1-max.kellermann@ionos.com>
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


