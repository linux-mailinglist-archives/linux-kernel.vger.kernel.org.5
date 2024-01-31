Return-Path: <linux-kernel+bounces-46662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C36A484425C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0061F2CEE9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A97313D505;
	Wed, 31 Jan 2024 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Q6OgkEem"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793512F5BF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712655; cv=none; b=lof6EpNOGUGv+yja8kdBEzS1BI0+TgiXPP+eCpZzzTu9i+gPnDoUw3UbvLHLge1jR1eJoX69cCiLjqAc6rSiyoqrK2WM1HkuZthprfizuXR4FwNrT1X7XiopJ6OMRnfFkrds6DGN3+5wFhPXzOtDZm/uZ5vRaa8cdwtIGuRsJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712655; c=relaxed/simple;
	bh=gIQ/3xk8Xm0LHNSLVsk0kXBFAPGBf+ECgM3ZpQ5WEvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mCFU/EZ8Wn4uWsk+ifY3ADVvp/njnMSJ3wBJwoqmA5JhZB/1dJJg9nEsr/fdVBZ/oLNCA7rdCCwci7XPxpDmxjXc2we7WjuaIQrsK9nRu0RWlRY1d5bZWgMZb3nlHMRcW+QX2gKQ6G+qmOv/s26Dc32SxY6+ChqCN0OTbA27NUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Q6OgkEem; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b01484cd7so685262f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712638; x=1707317438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qict04cTZhzQ8vPQmllQ+bI/2VKK+lFkVbPcuSOC/8=;
        b=Q6OgkEemkpseXq/7/HUf5NPG9Efr8OIRUJXiBLeum1RtGvLriyp4BSLZZ/X15/1oXT
         /0lTxin4y3p08pYdS9hTjBvrTaaJOWLTJuoz2tGUaJahcsWXY+qPtmX5BF/N8N+vfcgN
         P0sdgCfEh5x+vfyN/6gbKFNSRLgCWsqbUsVgMKaSA0QnstuDCyBQBDZQ9QrWMhRMH/gl
         oEHHQZ2r8rGzZ7XJWFYqJsV0TRJR9nZwQ1YLheB3AkQeyQ+UN2YiV8xyXw1/OzuGY1GL
         xDVpwlXrk2hLLG3bgsjNWDCsia7UYGfBuymt21XEHrQiKikT+mjlQ2+El+bpi1tiapGz
         0RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712638; x=1707317438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qict04cTZhzQ8vPQmllQ+bI/2VKK+lFkVbPcuSOC/8=;
        b=X1NRrALEqB1df5UQonMpDlXhzPsgE0JUbdmSMKBwMAUWZb/oAkgM8w/nIr/ZC9pAZd
         s7fPzpcopFFZ/BhVS/pTxwuF1ZCZ/3ohGWm1F0ruvRmgN+oyUIiaudoXAL3qwm8bj7cn
         bUH4yuiZrlc9juO9pl26aq3UAY90nvXuDv5enqe9nu36BPJQgSVLEgkXDb47Ms73R90v
         x/ptblUBLKtowDy0e2qq5ilbA3k8kwejANp94ZG9nrsnKuUPkwGuQHaanXtmJ36RNUYb
         RqROcNitZD4iHDUkFIkxHmItyriXu8IB2qH/wO9LXk6Sn3M+tdH34NfJxV0KDaVuFc7n
         t+TQ==
X-Gm-Message-State: AOJu0YyOZOa3qResiXcxNxSpVN4mokilc2/HpK7daYM7kmvNXJ3skPVl
	y+A6nFTzG/s/3yO551vLtderaGaZcAPdgW7ieOCYNuvSJt8PYkdXZJvvVsyKhZBe1seWuLgGy4D
	C
X-Google-Smtp-Source: AGHT+IERisMJswAx9ZDgKYz7cfF4sYaUwa1BPauofdVkVtraUY5bMUXLme54umoiJrCgpe4GDmamCQ==
X-Received: by 2002:a5d:6b89:0:b0:33a:eda1:e68b with SMTP id n9-20020a5d6b89000000b0033aeda1e68bmr1166435wrx.24.1706712638419;
        Wed, 31 Jan 2024 06:50:38 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:38 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 28/28] radix-tree.h: move declarations to radix-tree_types.h
Date: Wed, 31 Jan 2024 15:50:08 +0100
Message-Id: <20240131145008.1345531-29-max.kellermann@ionos.com>
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
index a6e3792b15f8..4e6d802a2313 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -18,6 +18,7 @@
 #include <linux/uaccess.h>
 #include <linux/export.h>
 #include <linux/device.h>
+#include <linux/radix-tree.h>
 #include <linux/types.h>
 #include <linux/sched.h>
 #include <linux/ctype.h>
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0bdef4fe925b..397efc4f2ae3 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/radix-tree.h>
 #include <linux/topology.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-- 
2.39.2


