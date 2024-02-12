Return-Path: <linux-kernel+bounces-61480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E534A8512C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B931F2419A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7FA3BB31;
	Mon, 12 Feb 2024 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XTzHhAej"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67AA3A8FE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738938; cv=none; b=ebC6gNDJcQv2rX/C8jO9SxIMl0e2xkfKN4fIPwrvrm0FAlxc+WqD4m1q0DTEaAwUN4jS1RXTBfqew2JohSHoe91f5tWda6sLwPOZ1xZQ3t7aCN8sOBenOlRaWQLl1eZT9eEXmCtKVBvA3nnCAl+DOZdtLzUz3+W9op3jf7A7rAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738938; c=relaxed/simple;
	bh=4QO81KEDKay0yFCAsc2rxdLCjv2qqeiYr3qK18+rth8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SIfIZtu6ReIeVVx2UsqSpfrGWo6WvqL3MiYfsFsi3ySfNK6KvXfW3KzBn7ti5hAZ5iYxacuUr9I7aTjaOV+pBkY6jsSH4f4hs4u7l/wGDsXE9DlOvG17X2CpL5NY4Sx+YLnKQFlQKDyuNROyOiDZBgp7mY+yteyo4m7scmBG3dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XTzHhAej; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3ca07df603so95048466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738934; x=1708343734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55y/MpLm4siZas8N+/jjEVmpsMcuf6T3/F4NQL7Vz68=;
        b=XTzHhAej6WjkMa9rOsqo1pQSOyph+hjF5EeIJIGrx3jwItD6tYZXZmV1RQgVHLWH7w
         8nNU1rB21x9s+xJKzc0R4MHICazEyKJr20eT59vaEo+xe1UiDOIUe61AoiZXb/o8fQbY
         TCfiV9446TOjTWixallOlv8P0HGZ9l+cw5AmihQFQM2L2F711mnZ2CXhjxZqwLLsm7pY
         37nbirvCk46bHOJ1URqvIubXxPX2PascKKsdtn1C8gZzBhpD0O04efEkzY/Ql0wCzrWa
         O8avCSMhkqznACvu6ln+BEBfOELKVlJGGzOKt8cO3DR0hQ5A2Whw/IYhnIkbHJly2IWW
         QWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738934; x=1708343734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55y/MpLm4siZas8N+/jjEVmpsMcuf6T3/F4NQL7Vz68=;
        b=uUFyLR74OhaU8er11XW2df68kYZY5KQjfacdFy4TZZGMAGQjLi50q4bSxb5kFsdaEu
         eQoCAKdH55kgoLG1ul/ylxFK/4PJ6PpYHBy55dGLhD4wzL4Fz3wig0X5W4g82qQEsra4
         PnBg6eZ0lHsAjxKfgUcmepp1+DDeI+2BxJNhFwJHEbrNq7nm2CLEyIyfeyR4cVCnQZ4I
         3inHLMp8AA8WTbStPeXWKQEXYeKaxPbZfklpbFNuPNjUM2UoIxvw6ohXywPDD9MCZn7w
         MHzu8B08+ruZEQo/jMjaaOfd5+rzG37NCfYcgNy1ISZn5AUcvONtrPX1kZh4QdUy0qAM
         FM5A==
X-Gm-Message-State: AOJu0Yyvtn0a8WvZjP98Ag7upFlmpPrkB7AwjTzbFnItiF2xz/p0eb73
	NRReeKo6iYz6R4JTc6PmQKDPyJcvNsfaeUQ8X92kRh6KOKz1u/YzTJxIlostk0nKZNteFPX60jy
	P
X-Google-Smtp-Source: AGHT+IEK1fS5kdhTqTaCVe+EI6mAKN4pANC+6qzGdWUlBK6FSAm6+2sxl19FuTIdh7CY3hIC8iV8Fg==
X-Received: by 2002:a17:906:234b:b0:a37:478c:6021 with SMTP id m11-20020a170906234b00b00a37478c6021mr5285669eja.76.1707738933926;
        Mon, 12 Feb 2024 03:55:33 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:33 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 20/35] bio.h: move declarations to bio_types.h
Date: Mon, 12 Feb 2024 12:54:45 +0100
Message-Id: <20240212115500.2078463-21-max.kellermann@ionos.com>
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
 include/linux/bio.h       | 74 +---------------------------------
 include/linux/bio_types.h | 84 +++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h    |  2 +-
 3 files changed, 86 insertions(+), 74 deletions(-)
 create mode 100644 include/linux/bio_types.h

diff --git a/include/linux/bio.h b/include/linux/bio.h
index b8562d4b57b2..cada670f63d8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -5,6 +5,7 @@
 #ifndef __LINUX_BIO_H
 #define __LINUX_BIO_H
 
+#include <linux/bio_types.h>
 #include <linux/mempool.h>
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
@@ -20,35 +21,6 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
 	return min(nr_segs, BIO_MAX_VECS);
 }
 
-#define bio_prio(bio)			(bio)->bi_ioprio
-#define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
-
-#define bio_iter_iovec(bio, iter)				\
-	bvec_iter_bvec((bio)->bi_io_vec, (iter))
-
-#define bio_iter_page(bio, iter)				\
-	bvec_iter_page((bio)->bi_io_vec, (iter))
-#define bio_iter_len(bio, iter)					\
-	bvec_iter_len((bio)->bi_io_vec, (iter))
-#define bio_iter_offset(bio, iter)				\
-	bvec_iter_offset((bio)->bi_io_vec, (iter))
-
-#define bio_page(bio)		bio_iter_page((bio), (bio)->bi_iter)
-#define bio_offset(bio)		bio_iter_offset((bio), (bio)->bi_iter)
-#define bio_iovec(bio)		bio_iter_iovec((bio), (bio)->bi_iter)
-
-#define bvec_iter_sectors(iter)	((iter).bi_size >> 9)
-#define bvec_iter_end_sector(iter) ((iter).bi_sector + bvec_iter_sectors((iter)))
-
-#define bio_sectors(bio)	bvec_iter_sectors((bio)->bi_iter)
-#define bio_end_sector(bio)	bvec_iter_end_sector((bio)->bi_iter)
-
-/*
- * Return the data direction, READ or WRITE.
- */
-#define bio_data_dir(bio) \
-	(op_is_write(bio_op(bio)) ? WRITE : READ)
-
 static inline void *bio_data(struct bio *bio)
 {
 	if (bio_has_data(bio))
@@ -521,18 +493,6 @@ static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
 	bio_associate_blkg(bio);
 }
 
-/*
- * BIO list management for use by remapping drivers (e.g. DM or MD) and loop.
- *
- * A bio_list anchors a singly-linked list of bios chained through the bi_next
- * member of the bio.  The bio_list also caches the last list member to allow
- * fast access to the tail.
- */
-struct bio_list {
-	struct bio *head;
-	struct bio *tail;
-};
-
 static inline int bio_list_empty(const struct bio_list *bl)
 {
 	return bl->head == NULL;
@@ -656,38 +616,6 @@ static inline void bio_inc_remaining(struct bio *bio)
  */
 #define BIO_POOL_SIZE 2
 
-struct bio_set {
-	struct kmem_cache *bio_slab;
-	unsigned int front_pad;
-
-	/*
-	 * per-cpu bio alloc cache
-	 */
-	struct bio_alloc_cache __percpu *cache;
-
-	mempool_t bio_pool;
-	mempool_t bvec_pool;
-#if defined(CONFIG_BLK_DEV_INTEGRITY)
-	mempool_t bio_integrity_pool;
-	mempool_t bvec_integrity_pool;
-#endif
-
-	unsigned int back_pad;
-	/*
-	 * Deadlock avoidance for stacking block drivers: see comments in
-	 * bio_alloc_bioset() for details
-	 */
-	spinlock_t		rescue_lock;
-	struct bio_list		rescue_list;
-	struct work_struct	rescue_work;
-	struct workqueue_struct	*rescue_workqueue;
-
-	/*
-	 * Hot un-plug notifier for the per-cpu cache, if used
-	 */
-	struct hlist_node cpuhp_dead;
-};
-
 static inline bool bioset_initialized(struct bio_set *bs)
 {
 	return bs->bio_slab != NULL;
diff --git a/include/linux/bio_types.h b/include/linux/bio_types.h
new file mode 100644
index 000000000000..bf0d8def2777
--- /dev/null
+++ b/include/linux/bio_types.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2001 Jens Axboe <axboe@suse.de>
+ */
+#ifndef __LINUX_BIO_TYPES_H
+#define __LINUX_BIO_TYPES_H
+
+#include <linux/mempool.h>
+#include <linux/workqueue_types.h>
+
+#define bio_prio(bio)			(bio)->bi_ioprio
+#define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
+
+#define bio_iter_iovec(bio, iter)				\
+	bvec_iter_bvec((bio)->bi_io_vec, (iter))
+
+#define bio_iter_page(bio, iter)				\
+	bvec_iter_page((bio)->bi_io_vec, (iter))
+#define bio_iter_len(bio, iter)					\
+	bvec_iter_len((bio)->bi_io_vec, (iter))
+#define bio_iter_offset(bio, iter)				\
+	bvec_iter_offset((bio)->bi_io_vec, (iter))
+
+#define bio_page(bio)		bio_iter_page((bio), (bio)->bi_iter)
+#define bio_offset(bio)		bio_iter_offset((bio), (bio)->bi_iter)
+#define bio_iovec(bio)		bio_iter_iovec((bio), (bio)->bi_iter)
+
+#define bvec_iter_sectors(iter)	((iter).bi_size >> 9)
+#define bvec_iter_end_sector(iter) ((iter).bi_sector + bvec_iter_sectors((iter)))
+
+#define bio_sectors(bio)	bvec_iter_sectors((bio)->bi_iter)
+#define bio_end_sector(bio)	bvec_iter_end_sector((bio)->bi_iter)
+
+/*
+ * Return the data direction, READ or WRITE.
+ */
+#define bio_data_dir(bio) \
+	(op_is_write(bio_op(bio)) ? WRITE : READ)
+
+/*
+ * BIO list management for use by remapping drivers (e.g. DM or MD) and loop.
+ *
+ * A bio_list anchors a singly-linked list of bios chained through the bi_next
+ * member of the bio.  The bio_list also caches the last list member to allow
+ * fast access to the tail.
+ */
+struct bio_list {
+	struct bio *head;
+	struct bio *tail;
+};
+
+struct bio_set {
+	struct kmem_cache *bio_slab;
+	unsigned int front_pad;
+
+	/*
+	 * per-cpu bio alloc cache
+	 */
+	struct bio_alloc_cache __percpu *cache;
+
+	mempool_t bio_pool;
+	mempool_t bvec_pool;
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	mempool_t bio_integrity_pool;
+	mempool_t bvec_integrity_pool;
+#endif
+
+	unsigned int back_pad;
+	/*
+	 * Deadlock avoidance for stacking block drivers: see comments in
+	 * bio_alloc_bioset() for details
+	 */
+	spinlock_t		rescue_lock;
+	struct bio_list		rescue_list;
+	struct work_struct	rescue_work;
+	struct workqueue_struct	*rescue_workqueue;
+
+	/*
+	 * Hot un-plug notifier for the per-cpu cache, if used
+	 */
+	struct hlist_node cpuhp_dead;
+};
+
+#endif /* __LINUX_BIO_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6bfa4b92bb32..6747965c3580 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -14,7 +14,7 @@
 #include <linux/timer_types.h>
 #include <linux/workqueue_types.h>
 #include <linux/wait_types.h>
-#include <linux/bio.h>
+#include <linux/bio_types.h>
 #include <linux/gfp_types.h>
 #include <linux/kdev_t.h>
 #include <linux/rcupdate.h>
-- 
2.39.2


