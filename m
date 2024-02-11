Return-Path: <linux-kernel+bounces-61001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DEA850C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CC9281E97
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0667438DDF;
	Sun, 11 Feb 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="K+AwpE4b"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9A18629
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693356; cv=none; b=VAWMuUJLy2ZL8G8ixD9p+pi5YSPX/bqOD0vOuZQeZxmoDf0sP52F1i72eIS6XUYCFMFdeoxCjaF/FVEjBS3Q+K3YGLySqV4rtVCbp6AULiZX5RqEdgZM2T2iZ3OUmdeXRqJfD/lXrm8BMQXfhtJd4CJ+rJxtqb6eLQVTqWkP9CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693356; c=relaxed/simple;
	bh=4QO81KEDKay0yFCAsc2rxdLCjv2qqeiYr3qK18+rth8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtFaQGOxMf3jvqZa6U01a8XDZbqwmWl3eHYLXoHHzoj99oC+7EYIh1lKy7RipQMEWGYK79PyRufPdiMH84JppehIc+MbEDfvWnx9lhPpPsxeGC8tYxuW+VTktReel2hYf2lJ57GZh9VXbWBJRYTQz2rYoJo07saUI1C5MA61ZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=K+AwpE4b; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0a96bad85so39112571fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693351; x=1708298151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55y/MpLm4siZas8N+/jjEVmpsMcuf6T3/F4NQL7Vz68=;
        b=K+AwpE4byvDtDyfUkVynE6dFJLdK9KW4loWvaZsdhuuDbWKR/yVUvJk5P6JSi1CgS7
         6KtzE0H9U4gcLYxM9qPgrjkTaF3MUx0fvIvX8ZQyLf9DBmPETrJyTnAVQchikNUPomIz
         xGd1dlzSYzlxE+0Jhef5Grm3Tk5tuVVOabY6HY7gL6RXha5JxwVcCWDS4+6onr9xct16
         1882gk23g7JbNsoxGdTW/LBKwcI7EiNs828f6TvOWwQCF7lI/18fCmgEeJqsuKYpU3oc
         SL8M0LIRGUD2Qi9heKwBYFX5OJVzhgTxEE20YurFidEqxDvyVqYd50dW4n+hSG8fqTj4
         fWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693351; x=1708298151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55y/MpLm4siZas8N+/jjEVmpsMcuf6T3/F4NQL7Vz68=;
        b=g1aklStMN+Ic5CfSqtutPS5abK4Mc/iBXnb+UCS6aK26iJaigpFOrgHA3JwNnG1+E4
         R39cFddU4ZEp3wJTFn++peWYem7BrlQaJLUZ8zgG9zKrdZBSIEo/p1/KAW7MdpWfM9wH
         y1XHc40o1ED/dFcSuSmEoWcaxWRxFklHZVUwnAUYdP80FAr7mYg3Nk+hOm3mo2JiP8SM
         dbkYYlCsy7E6BReZ5NqdR+7MtRCJbUJ2TqoVtqxJOfEGGOXcMt6uFZfaPdB9ZZ8VGPtK
         FD0YbvwDWci/NoOGSSsve3olVPai+JWTagXqmgvlMd45Ea5TbRvsOUkuI7szL+oP5z/2
         3xJw==
X-Gm-Message-State: AOJu0YxpTHAXcZnSo3MhgbGHE5NEDbwsk5bolsNqs5F45301LkT+Vmu3
	gFdbeW+FCGwK5sjhxc9yCW9JjWxRXpKTg3YFwe1NdKPCPZbWJFyCSAjuQq0Z1M2v2OJyN9ILaix
	N
X-Google-Smtp-Source: AGHT+IEcIUP7Q1QYdbGUby2TcHDpBGRr5j0cHVVTqlGOoNDvCSWrJTxXsbnMS8CoOic+/IRkThJ+cw==
X-Received: by 2002:a05:651c:1545:b0:2d0:e35a:3ba6 with SMTP id y5-20020a05651c154500b002d0e35a3ba6mr4040106ljp.7.1707693351599;
        Sun, 11 Feb 2024 15:15:51 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:51 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 20/35] bio.h: move declarations to bio_types.h
Date: Mon, 12 Feb 2024 00:15:03 +0100
Message-Id: <20240211231518.349442-21-max.kellermann@ionos.com>
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


