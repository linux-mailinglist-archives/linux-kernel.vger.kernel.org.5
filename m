Return-Path: <linux-kernel+bounces-59638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E6D84F9D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68AC1F217F7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A857BB0F;
	Fri,  9 Feb 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Pbj42Ruu"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21177BB02
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496870; cv=none; b=F6hxTdKAmk2374NbA9NQjbn0hYJbejcX8miT9ydNGGKl+yVhbLq2IqzBmZq1pNyD8LuWEv6oiUzMRZkxAlvB/SUdYCV1StlcQQrOZ5Da2Yh5CwBkfL5bws/52nJPNg3U06SmRmna+AhXzo2VIDF224ZWEPzlhgUep5eDePrqnZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496870; c=relaxed/simple;
	bh=4QO81KEDKay0yFCAsc2rxdLCjv2qqeiYr3qK18+rth8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HhqjzNDpvjGBkHtk1gQiEgg23f7Bak9Y2a/iveA8cSQAHjNwAit6PyMHVK4W14PrBMdaqUC3blZkZ+ZOjjhUlRdcN35iq9TrOvgUdWgFhXMD682FTdeB3pIRya7Qdeak0OLmnNErdtn40LII9/op2LTl3BItOuydklCUFGL9i/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Pbj42Ruu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26fa294e56so151821966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496864; x=1708101664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55y/MpLm4siZas8N+/jjEVmpsMcuf6T3/F4NQL7Vz68=;
        b=Pbj42RuuyS6HCvjRCjl7V+R3GJ8LdeH196ae5vGt/4QMKPl5PUBopzzLWChFZZ8gSx
         qBzek+22s5WiS0EGX3AKrleKm2DPcCgyTYgRiPBsLHVNeDmCA2Znl6dbTUXhk8eMTXfJ
         b2ti209U6k12B0W1rlPe6HlXBOrqM2B4hlcDcjeMtj+iQ9ctxIgWHYAYYx7VEgU3NAop
         48cF1elK8bS/owvVYgWEz6TG4GoFAWR3WkqQfcvHrizeWQWC3QZyGrjf1iQRv1lcoy+G
         IuAoEUqXylLvvu19naqkarnEe0CIPkx2AZ7kDFr4NfaR5IGcl7wPIkk00QV/ChL7uNzF
         PVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496864; x=1708101664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55y/MpLm4siZas8N+/jjEVmpsMcuf6T3/F4NQL7Vz68=;
        b=VtGOWRMMQetos0wOES2ws4Oop6B8O7GFzBYeEImvf2Ha8FO0XDf7AN4TQWSoajSVe9
         GOHLlRIwGKqIfzIHvKxyPizdbtNBkUah/RxQ6jXsUoE+B4/G66h8Pqv+0ZFfT9rqYl5a
         CP+X357dcNMESAO1gJo4iEgbbUQehz0O+8OB8T3Q5C7oaU9NZLgo4AD2YyXQpicQPtGw
         Maw3bCM+2fyi0HLIleqGBcPt10iXdWphkPx/EzZidH8TOFPLqE0AoOYa4a5TEdoHPXTY
         nGmyKRyJXiY1aaHcrK59p9bs3x71qCYQ5xsvNVvlZeiqOhqvuJ9IdMD1HWd0wREHttXy
         MVQA==
X-Gm-Message-State: AOJu0YyxrIKZp4lNi5mkzCsXYQ6yXYpy1lVty6msirAq2JnzQPsHW65q
	rRzx1SA44mKENLYV0445ANpNeaWCTGFs7ny7x4AnsyfuQ/rCA8S5U/7nuBSBdgXfYq2oluoDhsp
	o
X-Google-Smtp-Source: AGHT+IFfiUQhj+X8XeDjclvuPlDBYxcyK5ta5SXvToyDb02HAL6R4ZvvsW2o837JSqfnfK/rm0CijQ==
X-Received: by 2002:a17:906:1cc1:b0:a35:aadc:a522 with SMTP id i1-20020a1709061cc100b00a35aadca522mr1562288ejh.57.1707496864714;
        Fri, 09 Feb 2024 08:41:04 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:04 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 20/35] bio.h: move declarations to bio_types.h
Date: Fri,  9 Feb 2024 17:40:12 +0100
Message-Id: <20240209164027.2582906-21-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209164027.2582906-1-max.kellermann@ionos.com>
References: <20240209164027.2582906-1-max.kellermann@ionos.com>
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


