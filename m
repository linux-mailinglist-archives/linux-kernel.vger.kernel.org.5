Return-Path: <linux-kernel+bounces-46659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8C0844253
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1052D1F2C4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD8113B7A3;
	Wed, 31 Jan 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BTJlKvs5"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905E12DDAC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712647; cv=none; b=B2a6ga/2JEF9sp74SEiFwyXWUKJIMa10whzXutFKuDRNOqDiNNOselpPHmapOO0NOMCnFgwqqqcH3PvkRcNFHSGrXJEIc3dlkve7FyleaO79e6GlXtIM6HROJsg7QA3NZIda4Gt/6i1l3/CwuvzF2UcYJ1LZR5B1Lyg1/1PDEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712647; c=relaxed/simple;
	bh=vnpHwrQqTGh83jGF/mOVjN3+jGO3XbGrHiR+lyiDEhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iBazvxKuUF6dcrQmfEWVsUuAiRoMYMihOpNbgFHGa3ClqGvsmNoHHFQ7JT27RHR4AxAJ/qI4ZbB1dwOO8ZXXcCL/v7ZmszQgc4tLSTpp5RBokPX0T1mZm2wV+3RF4NgiJoQgs0szrlpXxrEizlWjhdji9awM4RBBFtqT4FOBna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BTJlKvs5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5100cb238bcso9591178e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712634; x=1707317434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wz2gqR1nPObBws/2+IzSMmJxUoIVsWcR8/Agl6zU7c=;
        b=BTJlKvs5nbQT6nRdhAjXGkQd9Q6fwGCJQvuPdQFPmnJS8d+a2sHfzlJeV8pn6kAMhS
         oHExKIDFzj4LPtsCUJtm4o+wzWlp3RQda0f8ncEQ/8xMrc+ewDHFV6ZdbHw5B0GJG+DH
         j8A5AoU8ikGEOnTl1xoEvCT1Wr4fcXycFyY7HCt9cgK3xXHWWEOGdvsuuDFv+m/8K9a4
         DretvJrMN4zMDlVtvqbzydbT9RjH6Shcyz5WLucr5JAQtCEyKBoWMvMOTkpPRFPK45UX
         IencXlHe9Aq3ctfBxdc8A4TmE8cdjSmo8fVDJBVqSUkafKf8tbivwQGI2GtcE3A7PC62
         BP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712634; x=1707317434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wz2gqR1nPObBws/2+IzSMmJxUoIVsWcR8/Agl6zU7c=;
        b=ddtW0C+tdvK3geL0j33SSj2fCQOD4R9i+nPAfdDgx69NSaeR5eHJIBeN9ysqx7l3bW
         bMmPZ0LuwbnBNkOM4SkDW0BitrbOEkG2Oh8GnDHu5WawvlEX7mco7+PU0oHQZNl7IkHT
         BA78S2Cjx/tVr2CRltVSq0XEACz9Jw1eDwHHrjrY1xzhLm14d+vLW110oD+fJ8NC9Qto
         bKNBCzsex9pavA9BJ7mNfMgZmBXCmj25JZ8QyHIi2/BeVplxfg5wnhC+vKqHVWh+F59P
         p2IJBEokt8R9gKYiS0RhtG3i8d/42eP/rgDA2YvcYA9XWrfBxbKo0zlqHyAjY3Anfyfq
         UM2g==
X-Gm-Message-State: AOJu0YzxYZSmIFD3ShKHd+L9z+tHRVMhFF6a3QHert7wcInAFMXYKEE5
	8aQy/yTKrkN901h/g/xXLYpZ8Rrt9FGcwkWp4G2hSSnzURAGmcfoLPGQjKRWqUM2YsfXHovYZCc
	s
X-Google-Smtp-Source: AGHT+IFTogmGPaDg22Z/MWClfa0tHiLONNGZpAQCPNxgB4YYGYyC8m+ZLtvwDMhfaW64JZFzW4PRyg==
X-Received: by 2002:ac2:4c41:0:b0:510:1ac1:652a with SMTP id o1-20020ac24c41000000b005101ac1652amr1669567lfk.53.1706712634666;
        Wed, 31 Jan 2024 06:50:34 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:34 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 23/28] sbitmap.h: move declarations to sbitmap_types.h
Date: Wed, 31 Jan 2024 15:50:03 +0100
Message-Id: <20240131145008.1345531-24-max.kellermann@ionos.com>
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
 block/blk-mq.h                |   1 +
 include/linux/blk-mq.h        |   2 +-
 include/linux/sbitmap.h       | 124 +-------------------------------
 include/linux/sbitmap_types.h | 129 ++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+), 124 deletions(-)
 create mode 100644 include/linux/sbitmap_types.h

diff --git a/block/blk-mq.h b/block/blk-mq.h
index f75a9ecfebde..cc8e690171db 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -3,6 +3,7 @@
 #define INT_BLK_MQ_H
 
 #include <linux/blk-mq.h>
+#include <linux/sbitmap.h>
 #include "blk-stat.h"
 
 struct blk_mq_tag_set;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ed3760b04baa..201ee354a3d5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -4,7 +4,7 @@
 
 #include <linux/bio.h>
 #include <linux/blkdev.h>
-#include <linux/sbitmap.h>
+#include <linux/sbitmap_types.h>
 #include <linux/lockdep_types.h>
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index f7279f7632fe..c43d1c0eafbb 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -9,142 +9,20 @@
 #ifndef __LINUX_SCALE_BITMAP_H
 #define __LINUX_SCALE_BITMAP_H
 
+#include <linux/sbitmap_types.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
-#include <linux/cache.h>
 #include <linux/list.h>
 #include <linux/log2.h>
 #include <linux/minmax.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/wait_types.h>
 
 struct seq_file;
 
-/**
- * struct sbitmap_word - Word in a &struct sbitmap.
- */
-struct sbitmap_word {
-	/**
-	 * @word: word holding free bits
-	 */
-	unsigned long word;
-
-	/**
-	 * @cleared: word holding cleared bits
-	 */
-	unsigned long cleared ____cacheline_aligned_in_smp;
-} ____cacheline_aligned_in_smp;
-
-/**
- * struct sbitmap - Scalable bitmap.
- *
- * A &struct sbitmap is spread over multiple cachelines to avoid ping-pong. This
- * trades off higher memory usage for better scalability.
- */
-struct sbitmap {
-	/**
-	 * @depth: Number of bits used in the whole bitmap.
-	 */
-	unsigned int depth;
-
-	/**
-	 * @shift: log2(number of bits used per word)
-	 */
-	unsigned int shift;
-
-	/**
-	 * @map_nr: Number of words (cachelines) being used for the bitmap.
-	 */
-	unsigned int map_nr;
-
-	/**
-	 * @round_robin: Allocate bits in strict round-robin order.
-	 */
-	bool round_robin;
-
-	/**
-	 * @map: Allocated bitmap.
-	 */
-	struct sbitmap_word *map;
-
-	/*
-	 * @alloc_hint: Cache of last successfully allocated or freed bit.
-	 *
-	 * This is per-cpu, which allows multiple users to stick to different
-	 * cachelines until the map is exhausted.
-	 */
-	unsigned int __percpu *alloc_hint;
-};
-
 #define SBQ_WAIT_QUEUES 8
 #define SBQ_WAKE_BATCH 8
 
-/**
- * struct sbq_wait_state - Wait queue in a &struct sbitmap_queue.
- */
-struct sbq_wait_state {
-	/**
-	 * @wait: Wait queue.
-	 */
-	wait_queue_head_t wait;
-} ____cacheline_aligned_in_smp;
-
-/**
- * struct sbitmap_queue - Scalable bitmap with the added ability to wait on free
- * bits.
- *
- * A &struct sbitmap_queue uses multiple wait queues and rolling wakeups to
- * avoid contention on the wait queue spinlock. This ensures that we don't hit a
- * scalability wall when we run out of free bits and have to start putting tasks
- * to sleep.
- */
-struct sbitmap_queue {
-	/**
-	 * @sb: Scalable bitmap.
-	 */
-	struct sbitmap sb;
-
-	/**
-	 * @wake_batch: Number of bits which must be freed before we wake up any
-	 * waiters.
-	 */
-	unsigned int wake_batch;
-
-	/**
-	 * @wake_index: Next wait queue in @ws to wake up.
-	 */
-	atomic_t wake_index;
-
-	/**
-	 * @ws: Wait queues.
-	 */
-	struct sbq_wait_state *ws;
-
-	/*
-	 * @ws_active: count of currently active ws waitqueues
-	 */
-	atomic_t ws_active;
-
-	/**
-	 * @min_shallow_depth: The minimum shallow depth which may be passed to
-	 * sbitmap_queue_get_shallow()
-	 */
-	unsigned int min_shallow_depth;
-
-	/**
-	 * @completion_cnt: Number of bits cleared passed to the
-	 * wakeup function.
-	 */
-	atomic_t completion_cnt;
-
-	/**
-	 * @wakeup_cnt: Number of thread wake ups issued.
-	 */
-	atomic_t wakeup_cnt;
-};
-
 /**
  * sbitmap_init_node() - Initialize a &struct sbitmap on a specific memory node.
  * @sb: Bitmap to initialize.
diff --git a/include/linux/sbitmap_types.h b/include/linux/sbitmap_types.h
new file mode 100644
index 000000000000..078c7859905c
--- /dev/null
+++ b/include/linux/sbitmap_types.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_SCALE_BITMAP_TYPES_H
+#define __LINUX_SCALE_BITMAP_TYPES_H
+
+#include <linux/cache.h>
+#include <linux/types.h>
+#include <linux/wait_types.h>
+
+/**
+ * struct sbitmap_word - Word in a &struct sbitmap.
+ */
+struct sbitmap_word {
+	/**
+	 * @word: word holding free bits
+	 */
+	unsigned long word;
+
+	/**
+	 * @cleared: word holding cleared bits
+	 */
+	unsigned long cleared ____cacheline_aligned_in_smp;
+} ____cacheline_aligned_in_smp;
+
+/**
+ * struct sbitmap - Scalable bitmap.
+ *
+ * A &struct sbitmap is spread over multiple cachelines to avoid ping-pong. This
+ * trades off higher memory usage for better scalability.
+ */
+struct sbitmap {
+	/**
+	 * @depth: Number of bits used in the whole bitmap.
+	 */
+	unsigned int depth;
+
+	/**
+	 * @shift: log2(number of bits used per word)
+	 */
+	unsigned int shift;
+
+	/**
+	 * @map_nr: Number of words (cachelines) being used for the bitmap.
+	 */
+	unsigned int map_nr;
+
+	/**
+	 * @round_robin: Allocate bits in strict round-robin order.
+	 */
+	bool round_robin;
+
+	/**
+	 * @map: Allocated bitmap.
+	 */
+	struct sbitmap_word *map;
+
+	/*
+	 * @alloc_hint: Cache of last successfully allocated or freed bit.
+	 *
+	 * This is per-cpu, which allows multiple users to stick to different
+	 * cachelines until the map is exhausted.
+	 */
+	unsigned int __percpu *alloc_hint;
+};
+
+/**
+ * struct sbq_wait_state - Wait queue in a &struct sbitmap_queue.
+ */
+struct sbq_wait_state {
+	/**
+	 * @wait: Wait queue.
+	 */
+	wait_queue_head_t wait;
+} ____cacheline_aligned_in_smp;
+
+/**
+ * struct sbitmap_queue - Scalable bitmap with the added ability to wait on free
+ * bits.
+ *
+ * A &struct sbitmap_queue uses multiple wait queues and rolling wakeups to
+ * avoid contention on the wait queue spinlock. This ensures that we don't hit a
+ * scalability wall when we run out of free bits and have to start putting tasks
+ * to sleep.
+ */
+struct sbitmap_queue {
+	/**
+	 * @sb: Scalable bitmap.
+	 */
+	struct sbitmap sb;
+
+	/**
+	 * @wake_batch: Number of bits which must be freed before we wake up any
+	 * waiters.
+	 */
+	unsigned int wake_batch;
+
+	/**
+	 * @wake_index: Next wait queue in @ws to wake up.
+	 */
+	atomic_t wake_index;
+
+	/**
+	 * @ws: Wait queues.
+	 */
+	struct sbq_wait_state *ws;
+
+	/*
+	 * @ws_active: count of currently active ws waitqueues
+	 */
+	atomic_t ws_active;
+
+	/**
+	 * @min_shallow_depth: The minimum shallow depth which may be passed to
+	 * sbitmap_queue_get_shallow()
+	 */
+	unsigned int min_shallow_depth;
+
+	/**
+	 * @completion_cnt: Number of bits cleared passed to the
+	 * wakeup function.
+	 */
+	atomic_t completion_cnt;
+
+	/**
+	 * @wakeup_cnt: Number of thread wake ups issued.
+	 */
+	atomic_t wakeup_cnt;
+};
+
+#endif /* __LINUX_SCALE_BITMAP_TYPES_H */
-- 
2.39.2


