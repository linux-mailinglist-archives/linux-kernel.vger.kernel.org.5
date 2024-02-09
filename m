Return-Path: <linux-kernel+bounces-59641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0AA84F9DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30551F25D83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B312838C;
	Fri,  9 Feb 2024 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PyllQndE"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576184A46
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496873; cv=none; b=ut3eYxUttLqEd87GZ3BNfiNsDdWif0+IpZeQ7Ozd244h1fYbfuWUGwTQRY5VB8sp5wVCDzQR50zYJT2BfP55L0OtKFP/sdvAo7EuwszlF16o1ZkdIvPzi9isH/e2+84dY6+GqYuA8WLYreOuVJA5PZTh6pJFoE4oxqg1DB3NYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496873; c=relaxed/simple;
	bh=vnpHwrQqTGh83jGF/mOVjN3+jGO3XbGrHiR+lyiDEhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qi/RDSzwkRT0165gVJKEiZP//zhN/l76bsAhd6RRQz7p13C9HYJMWVCmKNcS1+sFchmkvw2L+1+eG7r1B9HU14sCOX9dATa30isA2HrFvx5Oc4VsBoP1m5LF1jJvY4pKY1ZpBuCkFXj7pFfGKtJ1Wucon+Gx1g3RWRmuT3GAtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PyllQndE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3850ce741bso116937766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496867; x=1708101667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wz2gqR1nPObBws/2+IzSMmJxUoIVsWcR8/Agl6zU7c=;
        b=PyllQndEVkcy+2/3LaziRMiSGcduo9FNhBOw0ossioLloxpaL3xzDf3BX2QHISJi6B
         aYkDvGJ7zQkjG++j9KchAWpGfTMZZrfd4ugX6/HSYa5MXnk4YeyXMdnNp2ycMA9JaVlX
         eDSZ+hE0z77OR+WhPzAhcfchwBMBRAbX6mBqNEUdzbaJvKT64lCQub8jkH1i0ppuBfzF
         6H5b8E2s2ljtgkYoXlbcKKKXx3eHJb7knv1DDGQ1fePT72RPrMIoX+42hnEwKmYEXOOu
         ZDxJlIBS0AwCI2AteiBbhsKx8AW7TJgMAN42x+zcmK792wPNx3xQOJ+5+pbOWCG9SFjP
         mQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496867; x=1708101667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wz2gqR1nPObBws/2+IzSMmJxUoIVsWcR8/Agl6zU7c=;
        b=FDM6w6829TIA1bM9nHkfAq+uTuUbPxgYa2ZQK1irbc/FCuJFSccXTORF3+RoWFzR8U
         vmSuqkSAEzW1NZt7rza3g8FmaRut2s/7jPg3YeEdz5AhV7XQdoOMMSQVP2PEihWY9L38
         eA4lYw7mQoJ64T4QCi4PaC8JTPH8Z5VlJLj1R9Q0ulV7D19NTlodmm2Gsig7A6qB8/30
         Sv1Dx2aWiMCxHqqp27fouCEgpooexngEpwxWcNZYE8KKfvFNqW55XSob82Awyg4MtBIi
         rERA5H1JCP0s/JkZGfpMlbFqUViD/6AincUAuSXvoEKHSA9CRtzksd+sftVT0n78gpNl
         KcTg==
X-Gm-Message-State: AOJu0YwBE8FSbDSunFUzVm05Ur/NbvXk2O8moNbUurxhyhO+TUt57tvR
	JaAp+La+I1p8hbM95tqJx6x9o08iQ3NJQQjw0hQ26ntdA3fG1BaZ9EYQNNGgorJOrclYxDxm8mt
	A
X-Google-Smtp-Source: AGHT+IGGTXKNflNCCf2uoojsKReAIxzJ5NBC9J4NgqeAgoVeofOA8mqJ13I6cP6jYrep43tqMgJ1XQ==
X-Received: by 2002:a17:906:c04:b0:a34:96e9:f46c with SMTP id s4-20020a1709060c0400b00a3496e9f46cmr1407768ejf.31.1707496867197;
        Fri, 09 Feb 2024 08:41:07 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:07 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 23/35] sbitmap.h: move declarations to sbitmap_types.h
Date: Fri,  9 Feb 2024 17:40:15 +0100
Message-Id: <20240209164027.2582906-24-max.kellermann@ionos.com>
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


