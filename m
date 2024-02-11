Return-Path: <linux-kernel+bounces-60997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B361850C38
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D418BB2183A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCB12B9D6;
	Sun, 11 Feb 2024 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VVdAkXpp"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7117BD5
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693353; cv=none; b=T3Rd4xsaatQYQAidnOD2sDty9w7NznMZKMxjd9sZLOeyjtrS/OCLeGQ91cBrgRYdCmxk3rqR+hzwG9qD98hxwDWymX3ex/+3ILT18diD4GA1YUQjsYA3MMt4Oz7//NFJCWwId3o2zLxzPDxvKR0cZSngKIhiUqhhPAiOp+dUAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693353; c=relaxed/simple;
	bh=ksB6Hw/gRhmpDEm9p0F3Nd/QWj2mSxCXzPil0t2rrzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=npSmgwz26dfS9xTegvh1fT8IaMCzS39s/8+ZUxuen/xRd7KdnHHlxk9zDsHK2ZBihxVsvy74Nj38bi8gt9goXHPnBUK7RRIJAMKPIZ5JJ9AqDprqZFR/X0ltpBaK/1le6NxjTYuuChO5PibeYVEUqtVmUq+Hyf/xQw/3RKdK6Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VVdAkXpp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso3099073a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693348; x=1708298148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aGSUgEoaSxD8Wnq2siQ6MwOZ/81RxBpHb5g/H05JE8=;
        b=VVdAkXppunXT5Nn4afeMAmOZShUXwbg9DjFHq+NsxITnd13sx1jfE19ptt/Wztg6/4
         oxOPw5bQC04PQyxoIP9Rpy3/jW87YMfLV6vlrMnOkRurTXJJEAvG8jPVW8GEFo5QfwSf
         qlXAksJYIdTG+bbyyp4xMYXalHuTIW3dZLWuqfsA8SGT+g/HU8WA+w/HLAbSs21TFYjn
         P7QELhdQdVrMOObl+25wH7tW1waZfkxgTQCJu4VFlX2FnDKGVGyzV1jmZrnWHojjHn7k
         z13M3oP5sTTbaiZkcTo/5fi4RuwrbLR/zHzCRC+rrdxSPHHyrEBCClU4uhrshIvc9Ivc
         Z9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693348; x=1708298148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aGSUgEoaSxD8Wnq2siQ6MwOZ/81RxBpHb5g/H05JE8=;
        b=HG0DVjmiyV4ZsySFJynQ6CwDxgewhvW3U3lYEG6TG0z81M5k19GqJ+6f6o4cVdK/jc
         u4WOaaABcqpZBYQOZg1KzEGl6ZSmZQKxqIiDBpo5XJ+UpktlnkBHfuUWVIBSuzP9TZOX
         ukEXhloCDeh14J6U6ZHSi9qtZPbj+2E1sVUqFHVLE7sJXaqxDhobqZ1An4gnS9KG+XZ6
         na3lMgu7RuuUUtqzZy4aSbZflzsVZNbcx4i/ICvEFJ8khLn7o7ndHZQDB8hxyPOT0qC7
         5MVVJUhJ88zujuiyMS/B5Oui0adfgzDSPSbVpvkeI+goE/U1utdQNyzh2lQqEXrs316Y
         ZkGQ==
X-Gm-Message-State: AOJu0Yy25L4Mq5LM1nWpRd1GapIbBjhMOlskBg9Laugp0ApKgSPclKxo
	4XKlmknZGeT/P/g1xFy3KMU08bVWDohGD0Yyhx0n0ODrgPUDHBLypBQqKshRlUeEXfmGwfiDc/D
	e
X-Google-Smtp-Source: AGHT+IFKrE756zAYCc8No7fb+rmDorrcBOOI1yZr+lm0EkRy6YgX3cFuONsip0azEJkAXR6O7XLPLw==
X-Received: by 2002:aa7:ce16:0:b0:561:a936:18d1 with SMTP id d22-20020aa7ce16000000b00561a93618d1mr1113119edv.39.1707693348203;
        Sun, 11 Feb 2024 15:15:48 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:47 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 17/35] xarray.h: move declarations to xarray_types.h
Date: Mon, 12 Feb 2024 00:15:00 +0100
Message-Id: <20240211231518.349442-18-max.kellermann@ionos.com>
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
 include/drm/gpu_scheduler.h  |  2 +-
 include/linux/blkdev.h       |  2 +-
 include/linux/list_lru.h     |  5 ++-
 include/linux/mlx5/driver.h  |  2 +-
 include/linux/msi.h          |  2 +-
 include/linux/pci.h          |  2 +-
 include/linux/xarray.h       | 56 +----------------------------
 include/linux/xarray_types.h | 70 ++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h  |  2 +-
 include/net/sch_generic.h    |  2 +-
 include/sound/core.h         |  5 ++-
 11 files changed, 86 insertions(+), 64 deletions(-)
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
index 7e1fc101a5c3..e67298984913 100644
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
index 792b67ceb631..5e8cd106dae4 100644
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a0fee72c45a4..f2a5638503a3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -44,7 +44,7 @@
 #include <linux/pci_ids.h>
 
 #ifdef CONFIG_PCI_DOE
-#include <linux/xarray.h>
+#include <linux/xarray_types.h>
 #endif
 
 #ifndef CONFIG_PCI_IOV
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index fd6ada66f6b5..ff1e63ec4865 100644
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
 #include <linux/math.h> // for DIV_ROUND_UP()
@@ -225,37 +225,12 @@ static inline int xa_err(void *entry)
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
@@ -278,35 +253,6 @@ enum xa_lock_type {
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
index 7a92421640be..50826b5e7b85 100644
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


