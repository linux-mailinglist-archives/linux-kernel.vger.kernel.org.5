Return-Path: <linux-kernel+bounces-60745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C77850917
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A10D28187A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392715B5B0;
	Sun, 11 Feb 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UPtqly9v"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89C5C916
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654636; cv=none; b=pQ4WNfaEWSu/jtf8vTomwsFOlaoojodEOQUCjQaMDK5I0MmBOdzzE5yN0WbCyhJiX3n7Nc7Tox5qmgpS9CznnZUip0CofzjkptNh2a8NprQyPKl5mtLuXbzjxONUHPGSUgODLlnFA48yeMg8pYvPDo6IoJoZXeRHvvWJz+g/rQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654636; c=relaxed/simple;
	bh=ksB6Hw/gRhmpDEm9p0F3Nd/QWj2mSxCXzPil0t2rrzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lAz3UY3947kXS8WH2ru7u9/5NUZa4+4CuIvVG4LHrJHfBH7/pqFNjcptciUTOcOfbuu8lgGCXEyauC6c0W3wxuoBHHlw0yduWZuaj+GmisjYLI+HaFaPEaFSYXEXEwkTr8njPGDdBJp3oVbdfNAvcBXh+d5q188brLIgosa6T2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UPtqly9v; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56174bbad45so1018776a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654630; x=1708259430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aGSUgEoaSxD8Wnq2siQ6MwOZ/81RxBpHb5g/H05JE8=;
        b=UPtqly9vXETpG4RzUgWjLump3hR5XImP5K6DUnpIh46QhqO0rERuwwF+wwCLvwYw3H
         G36ZTwiYsH7poJh6jWQYpVqyXrSfeyittyIkPC3AX/nMQFfPkgMfKWJC505lh3n/IWig
         VPcTSja3EtiS9LSjNtZvUbSz0JDQcLf8Sk7BCvhY96RWwJxUfFroWLBdfH3TMNWMETjs
         ncOT+Mz5uJGiROZvPt0as1I4Kd4/m3INypx6CTjbN42KHPvdUaR1/QgI9Q+D+U9VzFvy
         8u/VJ9V4YCx2Dgc5/vNaHCUNfdv/7+59IridfRgEGTJb+yVyuf5X/TKFDPtjNIx8iJzH
         7wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654630; x=1708259430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aGSUgEoaSxD8Wnq2siQ6MwOZ/81RxBpHb5g/H05JE8=;
        b=NyogWvPIS0tXode4FzXpUIxcGY9tZ0L5PPEeCtl0F4Zvz1FCQ9ExqRjA/l2AEwWlDp
         iyJ1ac1/vGsu0CZFPVRdKnHdALvp96b+jHXtEy9H6y/pi6IUoySFkYV3Tszm3r/OYZaO
         Z8mrJqljPr3VAGFUebQK/lpNkgok7zQVYs0M9y/Azt4S5Oe/jxOP3XQF0TtyquVR6BQc
         iu4KuymjW5JaIgHBlDuifMZwFOfWBXcS1ilodU4xjANrfjgzOhu/N0G6d47+gL539o/R
         qbeNDHQuMZ0rM7BO0nFbqrTQMUPJji12KCH0ad8q6qS9hWFCm7mrUuKcgpgDwcPeYur6
         4iBg==
X-Gm-Message-State: AOJu0YwLRjFXWL7YEPB+1oYLtEDoMYNUk1xVmXs+uZd0b6YDe/JZFhn5
	cv+8HD4AihQYxSgqJQpJHbECjPO2sfXPzRTdV/bkIqg8f0YKchW/xa1uGfpZgA+Tv3cHP7rLp3F
	L
X-Google-Smtp-Source: AGHT+IH+5xE/aMXm3R+CXbrTkV36AVf0OTsI6s48buO4uSSfHSXB/vPc0XKGikZqOD+bP3v08OHuPQ==
X-Received: by 2002:aa7:db54:0:b0:560:941:131b with SMTP id n20-20020aa7db54000000b005600941131bmr2363383edt.26.1707654630256;
        Sun, 11 Feb 2024 04:30:30 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:29 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 17/35] xarray.h: move declarations to xarray_types.h
Date: Sun, 11 Feb 2024 13:29:42 +0100
Message-Id: <20240211123000.3359365-18-max.kellermann@ionos.com>
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


