Return-Path: <linux-kernel+bounces-61489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32A48512D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A791F227F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119743D96A;
	Mon, 12 Feb 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="TcT9R0Fc"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC023C491
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738947; cv=none; b=qQ1Q4tXFA31f9oPddj5nwVO9V1bvzsWaLRZFKw+/qgsiAnzmlNlttGvlD3aKE9+lK2RVazzBTJYna5BcY5DHKdD3+U6W1qWcpSk3c4W6rovyp8xi0n9CS/uyaQ7PJqodtj6UK5KX6bxLyQYgO7MVrIMlmSbICZB5WSk6VkwRIYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738947; c=relaxed/simple;
	bh=TFd3IriyRtV14Q4iD6Y0DJVRX/3NF3OaAnuGRDo5Gn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hiGyqiZt8WepoN13zt/lT2OfygwfJWM+mb5oKb7x8R5ygfQJSI9+ZY5XZHuHZO3fr+zT5eGSjcnLgx2amXRzMvxEVQ0cmOYy/K6AIXkJ5zHY1o8iUvTPJqwCEjH8qFixP0F+1JG/sDLdLSA96Qza260gcvEajpu1gOI2i5aM73I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=TcT9R0Fc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51178bbb5d9so2565701e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738941; x=1708343741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loiHli0V/kSRYrYi4oxN9uOqze2d5xYhhe5Mm1BFOuo=;
        b=TcT9R0FcR6zRsWZHjKefGF3tcdpw8xs7987BQaK2mG2PhfI1bsoB0M1zsT8sFZPpuW
         9KWGFr1QDGKSO1ng89wnKk+MU4qJGZ6Jo8tlSj4VsTw6jp5SiTGZvQyXvoildVhqf/fJ
         4TDFbmLNOeCVgDUtlllEm1wFBJoe2+dY+Ey+JM0bTWaD/ZH+WKd3Sd3+/w5ZltscYfxy
         oUym2HTvvDh6m88O4WppazMWOUQJXsT0/4GCL9ZK0u9G3GTskbmpKMNg9sr21JHoiqoM
         K2mwZpz9DXAAJWCzah69LDQ+laahZPx6lxOD7HM+c3y8ZdUJ26Rgq6EC5shz18F3rfoy
         rXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738941; x=1708343741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loiHli0V/kSRYrYi4oxN9uOqze2d5xYhhe5Mm1BFOuo=;
        b=oqXqZsGaYBqPxC5+HOEjq0R4oMT49sr9v7QwuBC7D5nJOJEIXwrpLlVDIs7QE2RmGb
         lSUWaX+EPamvdse/yFyjgEgt0xtDm/xrSM3g5OoN7pFpWBRoDFpKBRmnl7xG1PF8bYx9
         lwylNMr3kx/CHUI5c/Pu5Il1f4BE4CdFSocX8N/gRhNZoO4/BK+sN0F7kI8FtSUoTo7j
         IEZ7Kqgqqd/F5HeJ8BN8GNpoMr9/LOaFWqDFg978Z9JbuFnGBpV4R0kFVLL1GzUVcU/X
         lHo5cNE2DN3JL31/WV65c6BsWJye963uY5bhF4oO+lPxzKXHFLnMXXIUqilKVpsCj5gY
         A+Mg==
X-Gm-Message-State: AOJu0Yy4HXzJikQi5AYy2qjLmULSjFZhUjDQii6zbrp2nqiXCclRO8a4
	RaRo26i8eI33gyI4PNIHeCxeQDh+IKzVasiZzITQckOoNq4C9DMNbc1in1y/Ppz6LnHjS1LYwsx
	9
X-Google-Smtp-Source: AGHT+IHgMMK+MM2i1oyXUi1NHtcI9/GAyhfH519uslD8yr5dHsx82ozuJ61sqma2t9orkilGTdLDmQ==
X-Received: by 2002:a05:6512:39d1:b0:511:3a93:5b7a with SMTP id k17-20020a05651239d100b005113a935b7amr5006311lfu.21.1707738941318;
        Mon, 12 Feb 2024 03:55:41 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:40 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 28/35] radix-tree.h: move declarations to radix-tree_types.h
Date: Mon, 12 Feb 2024 12:54:53 +0100
Message-Id: <20240212115500.2078463-29-max.kellermann@ionos.com>
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
index 068fc9f3e883..459ad296f822 100644
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


