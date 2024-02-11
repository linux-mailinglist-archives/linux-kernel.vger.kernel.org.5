Return-Path: <linux-kernel+bounces-60750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FB8850921
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469301F217E4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9505FDA3;
	Sun, 11 Feb 2024 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="JORhU7jl"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132765D8E1
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654642; cv=none; b=qeMAV8EVbB8hOlOdvXxdGYBYxpt9MWqXpyqcSefhFwYvyN5CGqgGo50USj8MePgw/M2ZFhlg7tKbyq9yGJK136LmNt1vEHLiW6QzXm4SuKnxK4xNhNImtH+fo5ygP5UdrlsjmGaL6YAAt1St7k/5JAq7VW0fPLnEwXdCIOonEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654642; c=relaxed/simple;
	bh=4QO81KEDKay0yFCAsc2rxdLCjv2qqeiYr3qK18+rth8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ed/4cyTAlo2hnZ4dGYzPCdCkNW6Rzji1z+q+rvcYRokYF9mKHvnmwQ6G0A+l+SWWGbMnZb3SpsiijTG1+XJFV4TkzF+Iyn0JWzpSJcKXJrAUfWgjpeHhdLHp0zqmyxzaIpPoDHx1LrJZTtxbSKo+tevQrTZ1QLt5Ibr5rpJj47k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=JORhU7jl; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso27945651fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654634; x=1708259434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55y/MpLm4siZas8N+/jjEVmpsMcuf6T3/F4NQL7Vz68=;
        b=JORhU7jlRiBHmmTdjFYM+zidxn+AxRcZ0qxTjCMkkUh4zXx3RqcGz0Mbz0m4ZA205R
         psSMGNwe/sjpHV/za2aDiY6SN8E+m2X7kuTlallaNVxCITC1h/GL/PBEHg8BqDLA2J9y
         QZ/zWAP+uLW8D23D2SVm3UoPoiJxYqFUIN95SwmL+nte1JyKVQd+hl0c5Vt+qEfnqzW9
         LvwOIu/DFtOL1rT8bMqIAd6OJQSrCiqxiCGOgofMvjzZS0h9S9qJ+mZecaII20fFJEde
         op55mErF5Z8LBWvLS5glg8Ihzg+1k5/En7rm9oYpzdAEJUIcb6RBFUhIa+otjLshhWFr
         MICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654634; x=1708259434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55y/MpLm4siZas8N+/jjEVmpsMcuf6T3/F4NQL7Vz68=;
        b=b6f/3m1NPeVsS5ppm1cgCivsQD5Z9LEcxAy3pnBHl/QoHqCH77RIaPBxykAVNAVwoJ
         zZGnEHECBmA0Xt4+quWdJalDzH7e4GktF/qFn61XO69MIX12pH1kWGLwd+VGs1OPGxQt
         E9wpg343trUbjMuBPJukjJA7N4lFRam1d1M8vzAUo/lpMKZDP8FgnuvDxWayyx+ePNZe
         mmLCrSoBiodlQwdjdvdgoFXRAMTQ6u6AukyELCTdLQPdtJckqBDgxa26Z6/VS0LA/srv
         I/ZdkDVnLBXp3lRUCQeYGn81+tqq83g7f6p/7ob0ZNebWk+Te04uzr4UUMhlgTcIMg52
         UTMw==
X-Gm-Message-State: AOJu0Ywy15TIw1xA5WwwNpw7KiPdOnGFYn3IG5fMuFDfMU6cfjTS9ck3
	VKhTZY9XC5f6il/sqQelL/Hgm2gYo41+xrFpei0EhaZHrPjWP6SLPrVA75BRHNE8TzEPH1pk4tK
	J
X-Google-Smtp-Source: AGHT+IH0YQoUU34eAAXO3kOzR7tM81kWHtwoXhxf+oYQLYrO2JBFsYnuWRk2M1jjdorBReTmSoGsgA==
X-Received: by 2002:a2e:9619:0:b0:2d0:6c48:8777 with SMTP id v25-20020a2e9619000000b002d06c488777mr2616676ljh.27.1707654634508;
        Sun, 11 Feb 2024 04:30:34 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:33 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 20/35] bio.h: move declarations to bio_types.h
Date: Sun, 11 Feb 2024 13:29:45 +0100
Message-Id: <20240211123000.3359365-21-max.kellermann@ionos.com>
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


