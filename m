Return-Path: <linux-kernel+bounces-46648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8191684424C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B79B2E5FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783812F59D;
	Wed, 31 Jan 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="d56Y0ZZC"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FECA12C549
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712635; cv=none; b=Xg+D1Srn70WQU1zFB4b92GagThFmqPQP/bBGuWJ6wuuSDmN9vRX2I/NgHe6/FFgVQpIiexJWRHbKZeOaXb7kmFJ/Q+7dgPRpwrM95+VKVmjzSqq+wU+aOf5T7xk8HlIVlVdnEBwqDg610VtWSLnEC4FpOQrLBy4q0ortioYFsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712635; c=relaxed/simple;
	bh=6haVGB7qj89dCVCoz4v6U5VeTFAe/pcxMUUhclMUdxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESSDwD0cNvCfmGaN0pCfpcLrZlgWI5wGWgYsspjIoRPzDrGFY5YWcFW9aL6n13qEJbqTSPmKjMZMNa786gb+xLsAwD1AwbSQfrtrsOOJWdvoL6fQhwucUTOx5KvX+mfkSq0+Zq69KNk+lGzh8B2N66ZBr32rtjA/4kD24hSjzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=d56Y0ZZC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so28231055e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712630; x=1707317430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wM1ayL1muZuU62vQAm31x/zI/OYBHxOOfh3cwYHrrIQ=;
        b=d56Y0ZZC1tbQRsD6Stbd3vukxqJrb7P+sY0JA5Ex8JSTRxz2SL3wb72WNc+5cO5eby
         fk6oknOY4P3O0pRvGFkqTAQfQ7A6w4kMpv/FrNbYGTuBhW3UAYngeCEX/VybAWshUmMQ
         HGgM1ENwlnSP74HgHXp/NBoz618wyERsxdwgNEeOMJKt3rMmrbPXhJgEzVzjYmzijgZN
         RzZCYUr3Njju6FRemUtaEDgotFt4kBhLnpGe459L9F7o7XreREQ5q3xIk2Qd6VryJi7M
         k/DFzICZdVVj6QR4H8UQIJQj0HOUg+OUX4iMoa+JJERSuKb2qx9zW8utf2Y44BGQ2M7Y
         4QLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712630; x=1707317430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wM1ayL1muZuU62vQAm31x/zI/OYBHxOOfh3cwYHrrIQ=;
        b=gDG0IRZCgAGkh+iMXrIQbhp1EMpOnvYJi3pgCYL+cMkSp3Rb5zAaOWF0KOOb1rbuk7
         36U+fiK9CjXI7vrcvFSmFfr059LLSpy9ufYNf8eVZkrch5TOawKlIymZT429sMq4WnwH
         G12RIH7yQ5IGNKP3X1jrydLCsL+q27rMkX+wajRpvCI6mClrEV0lffZCwa4eV5uv27+d
         YtguRmE4UF0aHyEYX138dBVEtDcClcPeYMw+gonU8xbJ3CVo/P8nXWV4xHPZsjrLG0XG
         oQYLmf4B1VkwD4TSjVU0y+bYnVn923CPJNMK0Xv5F+j7Z78Rgi5UXw9XSAt8qAsj/IAO
         bgeQ==
X-Gm-Message-State: AOJu0YwNXnJ+4aGja8SdnEAWee9ayuo2ZHYg5rCzdEdN1H4979nYQAMe
	ISgoFf4ZZzzp+6tmQSA/GwM2q0/mJnOy7jrHGg1X7kdl7pYXdUNOAQZy1Aotj1bHCABspBqHvag
	D
X-Google-Smtp-Source: AGHT+IHdDyNTJ8lAE1w7c6njWPUH9Tr8l9NQp5gQVymokde30tmleAh6zNfT5JIJ4reSuBnmQY5kHQ==
X-Received: by 2002:a05:600c:510a:b0:40f:afa9:7f1 with SMTP id o10-20020a05600c510a00b0040fafa907f1mr1323377wms.22.1706712630087;
        Wed, 31 Jan 2024 06:50:30 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:29 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 17/28] xarray.h: move declarations to xarray_types.h
Date: Wed, 31 Jan 2024 15:49:57 +0100
Message-Id: <20240131145008.1345531-18-max.kellermann@ionos.com>
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
 include/drm/gpu_scheduler.h  |  2 +-
 include/linux/blkdev.h       |  2 +-
 include/linux/list_lru.h     |  5 ++-
 include/linux/mlx5/driver.h  |  2 +-
 include/linux/msi.h          |  2 +-
 include/linux/xarray.h       | 56 +----------------------------
 include/linux/xarray_types.h | 70 ++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h  |  2 +-
 include/net/sch_generic.h    |  2 +-
 include/sound/core.h         |  5 ++-
 10 files changed, 85 insertions(+), 63 deletions(-)
 create mode 100644 include/linux/xarray_types.h

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 9a89f72a3bac..f2fb8931cb17 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -27,7 +27,7 @@
 #include <drm/spsc_queue.h>
 #include <linux/dma-fence.h>
 #include <linux/completion_types.h>
-#include <linux/xarray.h>
+#include <linux/xarray_types.h>
 #include <linux/wait_types.h>
 #include <linux/workqueue_types.h>
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3916d2f0a9af..d2c0934a7224 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -23,7 +23,7 @@
 #include <linux/sched.h>
 #include <linux/uio.h> // for iov_iter_is_aligned()
 #include <linux/uuid.h>
-#include <linux/xarray.h>
+#include <linux/xarray_types.h>
 
 struct module;
 struct request_queue;
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index f2882a820690..bf0b71faa059 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -11,7 +11,10 @@
 #include <linux/list.h>
 #include <linux/nodemask.h>
 #include <linux/shrinker.h>
-#include <linux/xarray.h>
+
+#ifdef CONFIG_MEMCG_KMEM
+#include <linux/xarray_types.h>
+#endif
 
 struct mem_cgroup;
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index d9b99aca9e72..07956bd2e55b 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -41,7 +41,7 @@
 #include <linux/semaphore.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <linux/xarray.h>
+#include <linux/xarray_types.h>
 #include <linux/workqueue_types.h>
 #include <linux/mempool.h>
 #include <linux/interrupt.h>
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 04fd2c856287..a3969b00a793 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -21,7 +21,7 @@
 #include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
 #include <linux/msi_api.h>
-#include <linux/xarray.h>
+#include <linux/xarray_types.h>
 #include <linux/mutex_types.h>
 #include <linux/list.h>
 #include <linux/irq.h>
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 0983c697648a..aab0539f925d 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -9,10 +9,10 @@
  * See Documentation/core-api/xarray.rst for how to use the XArray.
  */
 
+#include <linux/xarray_types.h>
 #include <linux/bitmap.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
-#include <linux/gfp_types.h>
 #include <linux/kconfig.h>
 #include <linux/kernel.h>
 #include <linux/rcupdate.h>
@@ -224,37 +224,12 @@ static inline int xa_err(void *entry)
 	return 0;
 }
 
-/**
- * struct xa_limit - Represents a range of IDs.
- * @min: The lowest ID to allocate (inclusive).
- * @max: The maximum ID to allocate (inclusive).
- *
- * This structure is used either directly or via the XA_LIMIT() macro
- * to communicate the range of IDs that are valid for allocation.
- * Three common ranges are predefined for you:
- * * xa_limit_32b	- [0 - UINT_MAX]
- * * xa_limit_31b	- [0 - INT_MAX]
- * * xa_limit_16b	- [0 - USHRT_MAX]
- */
-struct xa_limit {
-	u32 max;
-	u32 min;
-};
-
 #define XA_LIMIT(_min, _max) (struct xa_limit) { .min = _min, .max = _max }
 
 #define xa_limit_32b	XA_LIMIT(0, UINT_MAX)
 #define xa_limit_31b	XA_LIMIT(0, INT_MAX)
 #define xa_limit_16b	XA_LIMIT(0, USHRT_MAX)
 
-typedef unsigned __bitwise xa_mark_t;
-#define XA_MARK_0		((__force xa_mark_t)0U)
-#define XA_MARK_1		((__force xa_mark_t)1U)
-#define XA_MARK_2		((__force xa_mark_t)2U)
-#define XA_PRESENT		((__force xa_mark_t)8U)
-#define XA_MARK_MAX		XA_MARK_2
-#define XA_FREE_MARK		XA_MARK_0
-
 enum xa_lock_type {
 	XA_LOCK_IRQ = 1,
 	XA_LOCK_BH = 2,
@@ -277,35 +252,6 @@ enum xa_lock_type {
 #define XA_FLAGS_ALLOC	(XA_FLAGS_TRACK_FREE | XA_FLAGS_MARK(XA_FREE_MARK))
 #define XA_FLAGS_ALLOC1	(XA_FLAGS_TRACK_FREE | XA_FLAGS_ZERO_BUSY)
 
-/**
- * struct xarray - The anchor of the XArray.
- * @xa_lock: Lock that protects the contents of the XArray.
- *
- * To use the xarray, define it statically or embed it in your data structure.
- * It is a very small data structure, so it does not usually make sense to
- * allocate it separately and keep a pointer to it in your data structure.
- *
- * You may use the xa_lock to protect your own data structures as well.
- */
-/*
- * If all of the entries in the array are NULL, @xa_head is a NULL pointer.
- * If the only non-NULL entry in the array is at index 0, @xa_head is that
- * entry.  If any other entry in the array is non-NULL, @xa_head points
- * to an @xa_node.
- */
-struct xarray {
-	spinlock_t	xa_lock;
-/* private: The rest of the data structure is not to be used directly. */
-	gfp_t		xa_flags;
-	void __rcu *	xa_head;
-};
-
-#define XARRAY_INIT(name, flags) {				\
-	.xa_lock = __SPIN_LOCK_UNLOCKED(name.xa_lock),		\
-	.xa_flags = flags,					\
-	.xa_head = NULL,					\
-}
-
 /**
  * DEFINE_XARRAY_FLAGS() - Define an XArray with custom flags.
  * @name: A string that names your XArray.
diff --git a/include/linux/xarray_types.h b/include/linux/xarray_types.h
new file mode 100644
index 000000000000..ff241ce647a9
--- /dev/null
+++ b/include/linux/xarray_types.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _LINUX_XARRAY_TYPES_H
+#define _LINUX_XARRAY_TYPES_H
+/*
+ * eXtensible Arrays
+ * Copyright (c) 2017 Microsoft Corporation
+ * Author: Matthew Wilcox <willy@infradead.org>
+ *
+ * See Documentation/core-api/xarray.rst for how to use the XArray.
+ */
+
+#include <linux/gfp_types.h>
+#include <linux/spinlock_types.h>
+#include <linux/types.h>
+
+/**
+ * struct xa_limit - Represents a range of IDs.
+ * @min: The lowest ID to allocate (inclusive).
+ * @max: The maximum ID to allocate (inclusive).
+ *
+ * This structure is used either directly or via the XA_LIMIT() macro
+ * to communicate the range of IDs that are valid for allocation.
+ * Three common ranges are predefined for you:
+ * * xa_limit_32b	- [0 - UINT_MAX]
+ * * xa_limit_31b	- [0 - INT_MAX]
+ * * xa_limit_16b	- [0 - USHRT_MAX]
+ */
+struct xa_limit {
+	u32 max;
+	u32 min;
+};
+
+typedef unsigned __bitwise xa_mark_t;
+#define XA_MARK_0		((__force xa_mark_t)0U)
+#define XA_MARK_1		((__force xa_mark_t)1U)
+#define XA_MARK_2		((__force xa_mark_t)2U)
+#define XA_PRESENT		((__force xa_mark_t)8U)
+#define XA_MARK_MAX		XA_MARK_2
+#define XA_FREE_MARK		XA_MARK_0
+
+/**
+ * struct xarray - The anchor of the XArray.
+ * @xa_lock: Lock that protects the contents of the XArray.
+ *
+ * To use the xarray, define it statically or embed it in your data structure.
+ * It is a very small data structure, so it does not usually make sense to
+ * allocate it separately and keep a pointer to it in your data structure.
+ *
+ * You may use the xa_lock to protect your own data structures as well.
+ */
+/*
+ * If all of the entries in the array are NULL, @xa_head is a NULL pointer.
+ * If the only non-NULL entry in the array is at index 0, @xa_head is that
+ * entry.  If any other entry in the array is non-NULL, @xa_head points
+ * to an @xa_node.
+ */
+struct xarray {
+	spinlock_t	xa_lock;
+/* private: The rest of the data structure is not to be used directly. */
+	gfp_t		xa_flags;
+	void __rcu *	xa_head;
+};
+
+#define XARRAY_INIT(name, flags) {				\
+	.xa_lock = __SPIN_LOCK_UNLOCKED(name.xa_lock),		\
+	.xa_flags = flags,					\
+	.xa_head = NULL,					\
+}
+
+#endif /* _LINUX_XARRAY_TYPES_H */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index a2f221a39cd2..7ffdd8c31151 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -41,7 +41,7 @@
 #include <linux/idr.h>
 #include <linux/skbuff.h>
 #include <linux/notifier.h>
-#include <linux/xarray.h>
+#include <linux/xarray_types.h>
 
 struct user_namespace;
 struct proc_dir_entry;
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 6ec5064156d9..9845ea172382 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -18,7 +18,7 @@
 #include <net/gen_stats.h>
 #include <net/rtnetlink.h>
 #include <net/flow_offload.h>
-#include <linux/xarray.h>
+#include <linux/xarray_types.h>
 
 struct Qdisc_ops;
 struct qdisc_walker;
diff --git a/include/sound/core.h b/include/sound/core.h
index f95f6863986f..7dcba88b2fb7 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -14,7 +14,10 @@
 #include <linux/stringify.h>
 #include <linux/printk.h>
 #include <linux/wait.h>
-#include <linux/xarray.h>
+
+#ifdef CONFIG_SND_CTL_FAST_LOOKUP
+#include <linux/xarray_types.h>
+#endif
 
 /* number of supported soundcards */
 #ifdef CONFIG_SND_DYNAMIC_MINORS
-- 
2.39.2


