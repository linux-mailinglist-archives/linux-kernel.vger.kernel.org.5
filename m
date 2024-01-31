Return-Path: <linux-kernel+bounces-46652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565884425F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 356D2B2F8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7A131758;
	Wed, 31 Jan 2024 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UGvQSYJx"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA20012CDB5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712638; cv=none; b=J4/zZYWhG6ULXdtGi8DZDI54zUQvStJi79K20zzRpCXnQicQyrT5gsvZYCbuAc1PJn0++mS8FY9gzl1eHrWrM7k9EgJPXagpgPQU1IKwx2WpiPXYK2zMI/ez2LpDWUqPHrfvTB5CVh+9F4CG0YNOHdkaDW6JCx90PDuh6naERA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712638; c=relaxed/simple;
	bh=2TL9S1a7CAfvT5a3dQDGBKtCc+wGYZQWPNf9vz6whTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2DgYUNEjZZ5TIMzyZmeGyUH44N1CmIRumzZSqnol4AGAXeUKpwwi21o2Z/d7wTmeiyexWkcxFNNjWkRs/9oMA+NXo8+gmK7UqOTpGDofMeSV/aEyZ4E24yAtFM+jlpXGXJufY0d0YnFGVctntlxeY2T0HjzBT2cNEFmcVNfDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UGvQSYJx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33af6129f3cso1438515f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712632; x=1707317432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiFBM/EMkCCkjB2eKBAcYBjIG3J3PbUJDIO7IjNITIw=;
        b=UGvQSYJxs/1mIfxf3DRfd2LyTmj5c351/aGb2gM4VqB/RCxoRWcOqy130BUvL/mE6g
         HjVO8KOkb8tKBtzR0UiQE98vPjv0mlgoYBBKrcaIhHprFrCuZgFGoCSxbIAJZBbT+rvQ
         FyNNfUa5UY7a0hOTkO50Kl7ErQQzKIvah42HKIRcir+Fy2Vis6hZDzBGMVByVNS36Ind
         9W3sUJ1+7mQ7EsOl9Xi67xWx/oWmxoWfDPsnQbIpfiuRgDJk3kaLlYq8SzmUuRsd+R5J
         WK4K03MnPb6CZiMjMC0ZpRZq34XIum/5QSfzdSQrsX8aOVV0gyBh4KK//t+AEvyZXZjt
         1DUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712632; x=1707317432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiFBM/EMkCCkjB2eKBAcYBjIG3J3PbUJDIO7IjNITIw=;
        b=whqAg9A8D8iY9PN8447/pu7lFmw80vnW92vGbT1BP8E6dtbUkcmAbVlNdEv+gegsjT
         IYE0MMqfGVmZlcB70q8onI6bk37/JPgyx0+8GOJ1nRFQTmlNLOXdDTEEmFdZjd6SNmKK
         nWOukM182Yg1jZRVH8p8YWk+alx9/bYg3JIxQCAylWbZPWPB8zZCUb3wJSfT+vO+RO4N
         P2M9HIQ7DJrpZB/BFhtwceN8AIhXsvpke3/JCUxS8sFGogmZj/Yi6/sB4M91RJGpfA8t
         Je0JxTCn/4QZsi4GICSmYUCXs8Cd/pYGmDNzpGyOiihYwnloMWNElF205VPRI45Eauzg
         VJCA==
X-Gm-Message-State: AOJu0YyfQNIVJtZbO7WN3BNh9v9Zkm7AU/610OPe60KGPsNXjGMuqKG1
	Bo9+EXSt40IDYv3YzZESMwTU3uau1/Wxr+prU9iWPu8G3HQASw4EEKwhF1ZtmEtzi67dEb5GTaf
	L
X-Google-Smtp-Source: AGHT+IEOZgZuXcNml2QlBLHSp8DQzM6BvicvUdTotU+y+Y2j3nXw6VSfVY4ac9hwsQFaoY911ftN8w==
X-Received: by 2002:adf:e74c:0:b0:33a:e52c:975b with SMTP id c12-20020adfe74c000000b0033ae52c975bmr1347129wrn.70.1706712632530;
        Wed, 31 Jan 2024 06:50:32 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:31 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 20/28] bio.h: move declarations to bio_types.h
Date: Wed, 31 Jan 2024 15:50:00 +0100
Message-Id: <20240131145008.1345531-21-max.kellermann@ionos.com>
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
index a5e41a54de18..09e8f023070c 100644
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


