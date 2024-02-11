Return-Path: <linux-kernel+bounces-60751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C489850924
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC1D5B239BE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD305FEF6;
	Sun, 11 Feb 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="O3jWqn6T"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB5D5EE62
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654643; cv=none; b=MbzhuS4iCrPXAZlbMCYpwm6U/I3ikocQaybuKvzq0APLEa+mXZPFvLhAaGOk79cfNpmXg78u+KCB9o2L82ijYSZE3MJvaR8gTgsp8i5VU+L9GG9ibnLs7F2U7ma9tk0vQLbIvAFm22Z9IY/JIkAp58FHo2tTinEjcf5Znqz9bIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654643; c=relaxed/simple;
	bh=vnpHwrQqTGh83jGF/mOVjN3+jGO3XbGrHiR+lyiDEhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h7Pl52OdDSBxvw+PUS+DFi3iF/2m6i9a2xlCQk9+uyaChP0PK1T5c/wCalwYgs1/WLjNdvwrKikQMoWwEHrdQYUW/JAO9UcPOpGDMQjiz8BYJiGzTn0f2PHkYQZBeP12R5E4b8DFnzirxRqhT3X0TAJS/pe8g3BgBZwX2ryJ4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=O3jWqn6T; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d0e2adfeefso18218851fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654637; x=1708259437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wz2gqR1nPObBws/2+IzSMmJxUoIVsWcR8/Agl6zU7c=;
        b=O3jWqn6TBhdn58vJ6+ZghSCVF9ibZf591mH/oMdH57WRG0oKMVgyVz1yr9iMtmSbkb
         58AxokZQXoZvKjJ9bWQwLCMxG/7krfdu4JJ3AyLMTo/ghvHxRmKEp/ckmTjp06M0bpIl
         bpFh02Vfv/dtXxSzRzQt5WjU9kkWRZOJHeFOT4oHrHATmmKIzikHlnlVBWdSPECTPObH
         NB/9hTAodY4DYfFWN+rdfDpZ6rog72ptLwWq3SXMJSArtfrwt/C4jTG/c2o6WuXsy6tB
         57eEqQyhZaJWaSME6I+LL4nXdw1HhfrGrYGr5dBIOly9ybKMu0H/NKViv5cRPqacJsKV
         i1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654637; x=1708259437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wz2gqR1nPObBws/2+IzSMmJxUoIVsWcR8/Agl6zU7c=;
        b=VmIcIjEsleyNC+td/ci98InNaJzMW9d3AD3c0nmOBiE4bLF9RVcDRZdC/TPo03B4R2
         COtVVmaX/miV/3Ss3r/4DT59/4K/v8QFD7di8Ymz+InbDurjlLP2fZos89bxAUfW1ZyT
         o4rGKoyxKqgQHIc9x1XvM5ltFg4gxFKOV86wI3tiWcfSQJHVgVMDI63nDd5RRSyMHVUo
         MHqPzS9F8nImywa0dRQhzoNyMzH2K0c4qBAbHc1n+tJQhROKVo7QKiwdDY6T4IOpuwar
         BKL2phcxTAqlbge8GjFMxrWBmBHAcqTYAnTTAmiK6o60o5esaLyfrKYvK7oB+04ILHQ6
         jpCg==
X-Gm-Message-State: AOJu0YwbbkStSR5zGxCwljM40Yfv+tcaxi7uRWdgugQeAzqXbyl1qeZQ
	8gYOXtlKqyaif4Qh6FBymzU+YkPr5N6RM9+ZtSMTtKhjUOueNDsAGmbfGyPvJ0dsYWb08ZdLSGB
	Y
X-Google-Smtp-Source: AGHT+IG9uzCo0aiPOsRi6BuL7DUS2Nx1Xx4LX9lWEhcROTiKcMBjDmncHYTw9qB33rXtIT4Bhhxxlw==
X-Received: by 2002:a2e:8755:0:b0:2d0:a6ef:651d with SMTP id q21-20020a2e8755000000b002d0a6ef651dmr2389120ljj.47.1707654636837;
        Sun, 11 Feb 2024 04:30:36 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:36 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 23/35] sbitmap.h: move declarations to sbitmap_types.h
Date: Sun, 11 Feb 2024 13:29:48 +0100
Message-Id: <20240211123000.3359365-24-max.kellermann@ionos.com>
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


