Return-Path: <linux-kernel+bounces-61483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15578512D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38119B24210
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE43D576;
	Mon, 12 Feb 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Vsoo8FPP"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49539AE6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738940; cv=none; b=S6rmueJmaAciA4oY4IFpNAzOscDpLHYczsrLmVMhcIcyz/bnrG+21xd0mzs+2TJDFA4AVv/mDTzokCa6t0748n5u5aBNcpBUC9Vw37eQjiJTQft0fuP7VN0oUyqdY7G34ABpEa2Qj5s/HmT+6sXtt1mrZ5w7amGC/D3hT4N0xG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738940; c=relaxed/simple;
	bh=vnpHwrQqTGh83jGF/mOVjN3+jGO3XbGrHiR+lyiDEhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fy/wpdaEjUCqDd+dVNhJCdq/JrV+Su+FQril5ba/ieO5zPyfLTr6MI1miuZHY05o+k10YwDj4fB38XCmMq6e0yDU66Cbn6xolNMcJSPjjHz+g0tOcmM5ljJiOpGuq8M7j9B8fdK9aGmB3Iw4EVQNnKJhekcSIB8hKGWpBRbgfhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Vsoo8FPP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso3694672a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738936; x=1708343736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wz2gqR1nPObBws/2+IzSMmJxUoIVsWcR8/Agl6zU7c=;
        b=Vsoo8FPPjdSBGPALb0JUSN/yZTbauqU9oT7HgL5WSMNGdcrmPJqQ59KH8BP+4yZUqw
         CTQ3sb9NlTgDx75j2YNiO6Bgbfu2Y6VIMrM5X2H2gXg4YXxcxZvDHGi4+9R5IcCY1e2e
         MQtRO0GGBZp/HH3iQP2j4MBc1ogsUF0TD53Ws0yfjAyQfOUGy83su6uYA8Sv0uEBxZ8E
         0dgiJwRUC6pGG275hT7C1tP34jfyTrvMg4pcXMSbs30otWmZGQ/UzVyEpjzCaDI6PEAE
         WeLt8FJSy7+aJf+FFTNC2EhcoGjg2jox2gEt5LsI/JdSaeJdT+NHF1v/ob5QocYMPc/A
         vkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738936; x=1708343736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wz2gqR1nPObBws/2+IzSMmJxUoIVsWcR8/Agl6zU7c=;
        b=wf3fXB/ETHund7zigGaPMoPThCoVXd/SazyDFmgXZj61D84OIv89k7IW/zbUa8pQK4
         0FTm7z3yLcSBbQN5Dj40NxlQCxfK/JblrckJI02dzFhQqJuvR3QDfVbBRo0RP7FI1sZg
         zbSBEVIcygMMRPjP78pNiTJ1Z6opq0Y61XdHY3pezYNETrzwhgig1ChrjbCYnyZ0D4cb
         c+97s9W7gacHJy+bfyE88oL6UC1QTLnzLT9CGpPuxSd1lEbje0XlnXISx1byMhBxYB4h
         mxuW4fnMgkWpdgvHR0H3fUWhQF0Y9GiZiPqb+XDDN//0WkrmAJL78Jo0KA4Rn5+z1aau
         JlGw==
X-Gm-Message-State: AOJu0Yw28uWIH991dJFS6E5hbLfkCuyAQiQaHr3KEs22PQTENXwTAVp/
	XE/h/Kz0vL9CgcAgAPOUql/Ylc/6OkZrqftFDhWGBmgA0XOW7n2hNxlBvosJWgnS8b7hXn3XhzV
	J
X-Google-Smtp-Source: AGHT+IFS0/DruPSPpAd8quACT8RJpfQc9p4hNFPsoV86Hhiv3i78lVMAegdZQQthSd3V4zWA9hOg7g==
X-Received: by 2002:a17:906:af10:b0:a3c:b14:32e with SMTP id lx16-20020a170906af1000b00a3c0b14032emr5020901ejb.47.1707738935915;
        Mon, 12 Feb 2024 03:55:35 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:35 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 23/35] sbitmap.h: move declarations to sbitmap_types.h
Date: Mon, 12 Feb 2024 12:54:48 +0100
Message-Id: <20240212115500.2078463-24-max.kellermann@ionos.com>
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


