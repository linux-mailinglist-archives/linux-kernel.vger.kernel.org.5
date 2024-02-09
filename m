Return-Path: <linux-kernel+bounces-59648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEBC84F9E6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0799B1C25EFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854512B151;
	Fri,  9 Feb 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WHBhn4i5"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E571272D7
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496878; cv=none; b=dNip9Qp1j4MuB2fzmEBBK7ttwJcGrZlmZ0xNodhAGCaSnYX3sVlpXpxUplXrkQRvJy3O2rQ3eHTLl732cBEIu6VvI24xeFSwhUCX9KA3ATvvtO4cPcLdsQqaoxKC3aULizvUe945ozFbgA+PEkv6S3u0lGzM8LpSJmrt64lMf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496878; c=relaxed/simple;
	bh=9VepcIf+uQXyWSLDd7i+zmQ7WwRV4PEenyG1HPJqLa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/CvkWVP2Vmw9L83GOAwv/yqv5ExeAHtrwz6tZH45XLQgJrHksM+sOMlMsoCVHsA6D3wsCcmPWPtrucf/ws36N3qlqHHbBYu12OaTM4U0AZXqFacdLso2+WbU76SyHEs+K6jhwSEKdelvVIf8Tv5QtBu93TriGXRYPrDZ3Q6doI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WHBhn4i5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-560e9c7a094so1581113a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496872; x=1708101672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX6bIIKIb3vW/PKEEaoSMBsPTHp310cah7cFw0U4FkA=;
        b=WHBhn4i5Ro4GrMKzpgEcLWroaUEbfh++P/pmUzzY9Z7Bwn46Ppg/zjuMgvf+Y+r5+m
         Xk2zxnkUDxUupeeGyyYrD6QFqfB6rzJmDoJf2/wnaal/qXzIxswzIYij19kjIdtETKnC
         1dr0LxoPL2WH+CyjYB23m9EF3mh+ZGMgptl/wqx24IvW/hjLhQTlxnUcp3Of2hWQRIY9
         gWc3Xxw6KreE3dT1qhWgYyplG36DP9OqvwxaPLLuYqhgAHVcrFGgosEM7zAZoYH9hWAf
         Nu+E/dP1zwy63SMqjHPuea/lKTVc27CXINI2Ih7XIxWC8g9WPXnpzlxKibJCEYyCRBax
         Al2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496872; x=1708101672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XX6bIIKIb3vW/PKEEaoSMBsPTHp310cah7cFw0U4FkA=;
        b=njPIDk+fh1jLOw37Y/J4ABLIcR3IsxB4A+YQ7D21Oi2vTrg/QeDQStAHUXc5p8JgyE
         FVVu/jjJg4uiGIzteFfb70sv0mtiQO50a/WiPqCaBIXDxBbObFI52JJXuNWkOrA195Dq
         bDgmtFHhBNfrNDgsTfcFdf+AV8LTFuQ7z0txRSgNAZefZCO9DbW9T02YovXQRulzbxxj
         RO9Gh6hcAgd6B2bOUTT56EtrtaCD6+GGPt9KJvKUhsB854f7mtAZzULU8L64V47h2Xub
         7sWpvrEbE7DohsdU5HFa106VEEMRgjREcAShpyIM3Z4iWc/+GSnY4RjrMVJUA/8qhjYN
         YfUg==
X-Gm-Message-State: AOJu0YyJ+BJ3P6pTxzlS5eH8dJReXB3twVvX0rcOcRrApF1f/tWvkoJf
	lSe6b3n7BDgGZcC926+IxhDq6LX082NBBj5FQnET7gG7E8xxE1d3aDho/uIUFPTvUkNOncZSlhA
	K
X-Google-Smtp-Source: AGHT+IFfK5GGl7qorWdzS2G13FCTbGOqPleIkWfqSm0HSSka/v9dDZlI5IJY9GpDyNObz5RMZjH0Ew==
X-Received: by 2002:a17:906:f752:b0:a38:53df:4c5d with SMTP id jp18-20020a170906f75200b00a3853df4c5dmr1638565ejb.34.1707496872278;
        Fri, 09 Feb 2024 08:41:12 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:41:11 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 28/35] radix-tree.h: move declarations to radix-tree_types.h
Date: Fri,  9 Feb 2024 17:40:20 +0100
Message-Id: <20240209164027.2582906-29-max.kellermann@ionos.com>
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
 drivers/usb/cdns3/cdnsp-mem.c    |  1 +
 include/linux/backing-dev-defs.h |  2 +-
 include/linux/iocontext.h        |  2 +-
 include/linux/irqdomain.h        |  2 +-
 include/linux/mlx4/device.h      |  2 +-
 include/linux/radix-tree.h       | 44 +---------------------------
 include/linux/radix-tree_types.h | 50 ++++++++++++++++++++++++++++++++
 kernel/dma/debug.c               |  1 +
 kernel/irq/irqdomain.c           |  1 +
 9 files changed, 58 insertions(+), 47 deletions(-)
 create mode 100644 include/linux/radix-tree_types.h

diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
index 97866bfb2da9..bab13f8a0b62 100644
--- a/drivers/usb/cdns3/cdnsp-mem.c
+++ b/drivers/usb/cdns3/cdnsp-mem.c
@@ -12,6 +12,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
+#include <linux/radix-tree.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
 
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index ffdd82f2f3e6..a48509f21b71 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -3,7 +3,7 @@
 #define __LINUX_BACKING_DEV_DEFS_H
 
 #include <linux/list.h>
-#include <linux/radix-tree.h>
+#include <linux/radix-tree_types.h>
 #include <linux/rbtree_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/percpu_counter_types.h>
diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index a05d8a45cce5..aa1409bd9edd 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -2,7 +2,7 @@
 #ifndef IOCONTEXT_H
 #define IOCONTEXT_H
 
-#include <linux/radix-tree.h>
+#include <linux/radix-tree_types.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue_types.h>
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 0503bd4ea55b..c439d47b37a9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -35,7 +35,7 @@
 #include <linux/irqhandler.h>
 #include <linux/of.h>
 #include <linux/mutex_types.h>
-#include <linux/radix-tree.h>
+#include <linux/radix-tree_types.h>
 
 struct device_node;
 struct fwnode_handle;
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 18d71b808bc2..e354c967a21d 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -37,7 +37,7 @@
 #include <linux/if_ether.h>
 #include <linux/pci.h>
 #include <linux/completion_types.h>
-#include <linux/radix-tree.h>
+#include <linux/radix-tree_types.h>
 #include <linux/cpu_rmap.h>
 #include <linux/crash_dump.h>
 
diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 231c526ec9b8..eb28f5be02cd 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_RADIX_TREE_H
 #define _LINUX_RADIX_TREE_H
 
+#include <linux/radix-tree_types.h>
 #include <linux/bitops.h>
 #include <linux/gfp_types.h>
 #include <linux/list.h>
@@ -20,10 +21,6 @@
 #include <linux/xarray.h>
 #include <linux/local_lock.h>
 
-/* Keep unconverted code working */
-#define radix_tree_root		xarray
-#define radix_tree_node		xa_node
-
 struct radix_tree_preload {
 	local_lock_t lock;
 	unsigned nr;
@@ -70,45 +67,6 @@ static inline bool radix_tree_is_internal_node(void *ptr)
 #define RADIX_TREE_MAX_PATH (DIV_ROUND_UP(RADIX_TREE_INDEX_BITS, \
 					  RADIX_TREE_MAP_SHIFT))
 
-/* The IDR tag is stored in the low bits of xa_flags */
-#define ROOT_IS_IDR	((__force gfp_t)4)
-/* The top bits of xa_flags are used to store the root tags */
-#define ROOT_TAG_SHIFT	(__GFP_BITS_SHIFT)
-
-#define RADIX_TREE_INIT(name, mask)	XARRAY_INIT(name, mask)
-
-#define RADIX_TREE(name, mask) \
-	struct radix_tree_root name = RADIX_TREE_INIT(name, mask)
-
-#define INIT_RADIX_TREE(root, mask) xa_init_flags(root, mask)
-
-static inline bool radix_tree_empty(const struct radix_tree_root *root)
-{
-	return root->xa_head == NULL;
-}
-
-/**
- * struct radix_tree_iter - radix tree iterator state
- *
- * @index:	index of current slot
- * @next_index:	one beyond the last index for this chunk
- * @tags:	bit-mask for tag-iterating
- * @node:	node that contains current slot
- *
- * This radix tree iterator works in terms of "chunks" of slots.  A chunk is a
- * subinterval of slots contained within one radix tree leaf node.  It is
- * described by a pointer to its first slot and a struct radix_tree_iter
- * which holds the chunk's position in the tree and its size.  For tagged
- * iteration radix_tree_iter also holds the slots' bit-mask for one chosen
- * radix tree tag.
- */
-struct radix_tree_iter {
-	unsigned long	index;
-	unsigned long	next_index;
-	unsigned long	tags;
-	struct radix_tree_node *node;
-};
-
 /**
  * Radix-tree synchronization
  *
diff --git a/include/linux/radix-tree_types.h b/include/linux/radix-tree_types.h
new file mode 100644
index 000000000000..d0d4e051a424
--- /dev/null
+++ b/include/linux/radix-tree_types.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_RADIX_TREE_TYPES_H
+#define _LINUX_RADIX_TREE_TYPES_H
+
+#include <linux/xarray_types.h>
+
+/* Keep unconverted code working */
+#define radix_tree_root		xarray
+#define radix_tree_node		xa_node
+
+#define RADIX_TREE_INIT(name, mask)	XARRAY_INIT(name, mask)
+
+#define RADIX_TREE(name, mask) \
+	struct radix_tree_root name = RADIX_TREE_INIT(name, mask)
+
+#define INIT_RADIX_TREE(root, mask) xa_init_flags(root, mask)
+
+static inline bool radix_tree_empty(const struct radix_tree_root *root)
+{
+	return root->xa_head == NULL;
+}
+
+/**
+ * struct radix_tree_iter - radix tree iterator state
+ *
+ * @index:	index of current slot
+ * @next_index:	one beyond the last index for this chunk
+ * @tags:	bit-mask for tag-iterating
+ * @node:	node that contains current slot
+ *
+ * This radix tree iterator works in terms of "chunks" of slots.  A chunk is a
+ * subinterval of slots contained within one radix tree leaf node.  It is
+ * described by a pointer to its first slot and a struct radix_tree_iter
+ * which holds the chunk's position in the tree and its size.  For tagged
+ * iteration radix_tree_iter also holds the slots' bit-mask for one chosen
+ * radix tree tag.
+ */
+struct radix_tree_iter {
+	unsigned long	index;
+	unsigned long	next_index;
+	unsigned long	tags;
+	struct radix_tree_node *node;
+};
+
+/* The IDR tag is stored in the low bits of xa_flags */
+#define ROOT_IS_IDR	((__force gfp_t)4)
+/* The top bits of xa_flags are used to store the root tags */
+#define ROOT_TAG_SHIFT	(__GFP_BITS_SHIFT)
+
+#endif /* _LINUX_RADIX_TREE_TYPES_H */
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index e7e236599307..1e892a5b0d93 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -20,6 +20,7 @@
 #include <linux/uaccess.h>
 #include <linux/export.h>
 #include <linux/device.h>
+#include <linux/radix-tree.h>
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/ctype.h>
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d3431093c40d..d3313b7a22c8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/radix-tree.h>
 #include <linux/sprintf.h>
 #include <linux/topology.h>
 #include <linux/seq_file.h>
-- 
2.39.2


