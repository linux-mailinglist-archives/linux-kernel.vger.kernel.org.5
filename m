Return-Path: <linux-kernel+bounces-61004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEF9850C43
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C9E1F240A9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E4739AE7;
	Sun, 11 Feb 2024 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="TVYQICHi"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499A1EA73
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693360; cv=none; b=iNQdi+dssn0tT9fT4XG/PN0+Z64wvnl9ki/HanYZxBEA5i4GGo/djJaq900XKIsneMIrXw0wNVo6R3g18/4Mp0R/zaX7G+Wl8Mwtlyn/c1435D5ZCXdUXOq974SJol44batOUY767mO02aMRHgaR9TUk0kdykWFFGJbHSXu175E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693360; c=relaxed/simple;
	bh=vnpHwrQqTGh83jGF/mOVjN3+jGO3XbGrHiR+lyiDEhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mlZTAbwMRYQAve+LMjlLRYvBiYD+DTK6nSvHi0nhGFHzTKTGxpPK9jZu8Cqz7+IAjNvN3QjIoiTE/ohDJhjlZULcY2aXabxv+92kPD7JodV5QNJxOimyN6/Lw3BiqR0PJyMpQL6sQdBF44xdrJ/RYBOLqczfm0UWQAHWKHqtHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=TVYQICHi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d094bc2244so32571281fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693354; x=1708298154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wz2gqR1nPObBws/2+IzSMmJxUoIVsWcR8/Agl6zU7c=;
        b=TVYQICHize5gfJvxkwAVqf0T9BYSxjboJI0WG5WeamEqE73YWKYm4Bq4XOh2Qvzw0S
         84cjop6KtdeH9c32CtprI4423exWOpa79jgtCU2WxAIwOkhDLdSIYgPiKgC0ZguMfxJL
         BPNXMZkzJPWt7Cu4u6uIPsoIkYZr0NfReX4p09XbBfPuWfYpJnA97re1jVYStkOhoUHr
         ul9OO54UYaO4WWPPdeypa5ht/heAQPNsXDAo+WQUP8IEBPLUAOJ6egFCyJyGoOhOoU75
         9MKle/YF2x8Ogz8Q6/FBEubu6YCi3t4t7b6Q4BWwW4Cj4seoNPf4IRzKKLiTtnXdA0bm
         TkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693354; x=1708298154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wz2gqR1nPObBws/2+IzSMmJxUoIVsWcR8/Agl6zU7c=;
        b=Y/8qY/Zb0X3aNiJV5WwH7dFQyYu24W++HP6VdUNT/aKIbfgNN5M1cZcMmPjrkvZOmD
         gBqVM4A09qFaVlwq3n6YmW9Hr33QdhsqxrmoKNO33z1AvQkoZDtwEuZc3OpC2T3PhLT5
         8+kIizPbYwMLRl+e6vOqyyl7xzsJf+4JDqe4aMSVBfvRQaXYAjE6IkZlllFpSW3GaBqo
         L65L3NPvlDF5vsJqOO4tzqzEfGihttQjpeO2S76j0ZHP6HHOYFfrKmAJx0XLMAbkF2p6
         +eDfAZb8MfYGsxyiYq4UwKzkehySIY3LChy9i/hvkYL/3CfNyy+zmDbL4/jZDjz3eUeg
         loBA==
X-Gm-Message-State: AOJu0Yz1cgT7FrthPrs+pHgQXVNZkUzoou/zhifHPcX/atZdMuH78+u4
	EN3ho33VzdWULbkydY9uOXLv9vZViuCmn+CmGwJsnDduowZY/3Ck5fltWp5UlUMjDuwoyLOC6U1
	C
X-Google-Smtp-Source: AGHT+IHcJ2oGElNbblXAymkZvhH8K7DJYIJdJS81kwIiRzSG4/f3Y0/JpaeDNV8y9ts1amuzT0jriw==
X-Received: by 2002:a2e:a4ae:0:b0:2d0:e35a:3ba3 with SMTP id g14-20020a2ea4ae000000b002d0e35a3ba3mr2900653ljm.49.1707693354417;
        Sun, 11 Feb 2024 15:15:54 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:54 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 23/35] sbitmap.h: move declarations to sbitmap_types.h
Date: Mon, 12 Feb 2024 00:15:06 +0100
Message-Id: <20240211231518.349442-24-max.kellermann@ionos.com>
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


