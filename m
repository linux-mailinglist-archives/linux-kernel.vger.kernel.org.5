Return-Path: <linux-kernel+bounces-46637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4EC84423A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422F21C21EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB2B12BE85;
	Wed, 31 Jan 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EnWe27ji"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58812AAEB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712625; cv=none; b=koqlDmrZN4iNdGM9v1W0vFisYwF0dFDUcFbDVU0EZeILjBtEStvseePoIznen4TVKJN1WNbkQCh7YhhQzv9xz/0MfK/t3AJqKfgBZEciWEVdsebeBqNlvGtcsVzXd/BHpxYSQz6T9czXRAv13iLKFvlhQRb0hm7wDF6XrzJA968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712625; c=relaxed/simple;
	bh=e3KQQ8+zCLINo4Sf2cQoc1an738oG5Ir6NwQFdrDhx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xf6ARLPNVYwaVWIecOstr+KpYbdqYuA2HXbRhfhsDk+8MNrwgo2UNkkRV40eCzZv/HGTR1uPdkgPqR7pzEX1lRVPhnzs1WV6EqwkulC5qCpT8HHL+ox+oc235IxS7jfGL3lDF47jLK876GeeN4IVlD0tbyyCkfbgiPmTDTKUC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EnWe27ji; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40efcb37373so20757035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712620; x=1707317420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0K+ei0pYx2M/YIfe+G1/p1ruQcoxU3kcjnOHUIvPQ8=;
        b=EnWe27jimHreAIc2Gglk5S8rPcxg4/QWlp5h9U4Yxuv1Eaml/kBUfxThxJ07c6w0PD
         GKZwBF5SsQwroF0Zv5iB6qhQtglLaP8xh5bDgjOWIrGtS099QaUMQQ0EwAUTTPkD/XQk
         Tw54kuHffg/ntZVXGh73bP1M+rU9Iih307Gf6KmRPjKakmOTgUHJNgfGVwsNJtN29XyC
         zEabPQsMK+HTozgO4AAvB+0TO8Y+FMj/ZWpdmkuVpmf2F7bdoWCVv6DFMhzT4NRUdT/3
         T3BNguXZYk8fGxmCxKNB1XBOYzmloKPLcqd1cr0FTNs8Gmymicz+NjpkD5amr4tTr4cb
         o76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712620; x=1707317420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0K+ei0pYx2M/YIfe+G1/p1ruQcoxU3kcjnOHUIvPQ8=;
        b=Tt6Kz0GmnUGMRacNJs82O9zRc6hl2RwzUsI0bTPRBClcj3qDhtEHL9bn1bmWXODRQK
         MzxnUl1Kdprc/syMhQ+8hp5s0TLmdQxT61aUxlTGfyNNadyTFK430G7rHZSWEiNlPwty
         MpeQUfpbggyymKDjeFv0KBLx1MmU+0wqAOOv+kvzgRwkEU7MbrF5Ct3VGF/PD9WALQTL
         2394uaB77KaOCad0Cjk1rtKSN+FgB2EWpxxaRzCKDdeZRVp11VKAeA/Cd5FfDmCXbvfm
         HjeHz0V3ZJ7UCTe8niCy+E8WIVwVMeMCzRHsR79q5IbBRpwUOTf5c0N2akSa3QaQ4oCy
         5NHw==
X-Gm-Message-State: AOJu0YyHLVhiOzdrmuo6Mg26q4alLSkGKYuYESl1ftXg01F/5hTr9FLB
	NQrIhZxwfE+gY++a9HkN6M3OSf3L5NqRiigZ7pUBtW2cPfHRmJs3vBKESMfyW1P6q+TPPnqGAoH
	c
X-Google-Smtp-Source: AGHT+IHlWEoi/l0kcpRbXUo/jtbHqg3pBYqavOeLrUQCTEJ1ktzE+jdbJwYg6NEXkv+jQrgZiPbn+w==
X-Received: by 2002:a05:6000:dc9:b0:33a:e43a:4b98 with SMTP id dw9-20020a0560000dc900b0033ae43a4b98mr1419615wrb.7.1706712620249;
        Wed, 31 Jan 2024 06:50:20 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:20 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 07/28] sysfs.h: move declarations to sysfs_types.h
Date: Wed, 31 Jan 2024 15:49:47 +0100
Message-Id: <20240131145008.1345531-8-max.kellermann@ionos.com>
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
 drivers/firmware/dmi-sysfs.c                  |  1 +
 drivers/firmware/memmap.c                     |  1 +
 drivers/input/vivaldi-fmap.c                  |  1 +
 drivers/of/kobj.c                             |  1 +
 .../staging/greybus/audio_manager_module.c    |  1 +
 include/linux/device/bus.h                    |  2 +-
 include/linux/iio/buffer_impl.h               |  3 +-
 include/linux/kobject.h                       |  2 +-
 include/linux/module.h                        |  2 +-
 include/linux/perf_event.h                    |  2 +-
 include/linux/sysfs.h                         | 63 +------------
 include/linux/sysfs_types.h                   | 89 +++++++++++++++++++
 include/linux/thermal.h                       |  2 +-
 include/net/netdev_rx_queue.h                 |  2 +-
 include/rdma/ib_sysfs.h                       |  2 +-
 kernel/kheaders.c                             |  1 +
 lib/kobject.c                                 |  1 +
 mm/cma_sysfs.c                                |  1 +
 18 files changed, 107 insertions(+), 70 deletions(-)
 create mode 100644 include/linux/sysfs_types.h

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 8d91997036e4..6bce0273beca 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -24,6 +24,7 @@
 #include <linux/dmi.h>
 #include <linux/capability.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/io.h>
 #include <asm/dmi.h>
diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index a92d17c6fc0f..b87645e67673 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/mm.h>
 
 /*
diff --git a/drivers/input/vivaldi-fmap.c b/drivers/input/vivaldi-fmap.c
index 0d29ec014e2f..72845c0720f2 100644
--- a/drivers/input/vivaldi-fmap.c
+++ b/drivers/input/vivaldi-fmap.c
@@ -9,6 +9,7 @@
 #include <linux/input/vivaldi-fmap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 
 /**
diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index 3dbce1e6f184..95a7a461f8e9 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "of_private.h"
 
diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
index 5f9dcbdbc191..2adb1c1fc2a7 100644
--- a/drivers/staging/greybus/audio_manager_module.c
+++ b/drivers/staging/greybus/audio_manager_module.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "audio_manager.h"
 #include "audio_manager_private.h"
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index bdd8ac64f629..a6fc75a825a3 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -16,7 +16,7 @@
 
 #include <linux/klist.h>
 #include <linux/pm.h>
-#include <linux/sysfs.h> // for struct attribute
+#include <linux/sysfs_types.h> // for struct attribute
 
 struct device_driver;
 struct device_node;
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 184f8c399854..df4cad6a8c8e 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -1,7 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _IIO_BUFFER_GENERIC_IMPL_H_
 #define _IIO_BUFFER_GENERIC_IMPL_H_
-#include <linux/sysfs.h>
+
+#include <linux/sysfs_types.h> // for struct attribute_group
 #include <linux/kref_types.h>
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index fc5c0fffc262..55e7d15aa7cc 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -18,7 +18,7 @@
 #include <linux/kobject_types.h>
 #include <linux/types.h>
 #include <linux/list.h>
-#include <linux/sysfs.h>
+#include <linux/sysfs_types.h> // for struct attribute
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/spinlock_types.h>
diff --git a/include/linux/module.h b/include/linux/module.h
index 426d3bdf83bb..ba3c0d129cb5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -27,7 +27,7 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
-#include <linux/sysfs.h> // for struct attribute
+#include <linux/sysfs_types.h> // for struct attribute
 #include <linux/dynamic_debug.h>
 
 #include <linux/percpu.h>
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index eaf5d5f76e0e..b3aec977b0e4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -55,7 +55,7 @@ struct perf_guest_info_callbacks {
 #include <linux/static_key.h>
 #include <linux/jump_label_ratelimit.h>
 #include <linux/atomic.h>
-#include <linux/sysfs.h>
+#include <linux/sysfs_types.h>
 #include <linux/perf_regs.h>
 #include <linux/cgroup.h>
 #include <linux/refcount_types.h>
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 34e29761d125..b0e27637b400 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -13,6 +13,7 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
+#include <linux/sysfs_types.h>
 #include <linux/kernfs.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
@@ -22,16 +23,6 @@ struct kobject;
 struct module;
 struct bin_attribute;
 
-struct attribute {
-	const char		*name;
-	umode_t			mode;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	bool			ignore_lockdep:1;
-	struct lock_class_key	*key;
-	struct lock_class_key	skey;
-#endif
-};
-
 /**
  *	sysfs_attr_init - initialize a dynamically allocated sysfs attribute
  *	@attr: struct attribute to initialize
@@ -53,39 +44,6 @@ do {							\
 #define sysfs_attr_init(attr) do {} while (0)
 #endif
 
-/**
- * struct attribute_group - data structure used to declare an attribute group.
- * @name:	Optional: Attribute group name
- *		If specified, the attribute group will be created in
- *		a new subdirectory with this name.
- * @is_visible:	Optional: Function to return permissions associated with an
- *		attribute of the group. Will be called repeatedly for each
- *		non-binary attribute in the group. Only read/write
- *		permissions as well as SYSFS_PREALLOC are accepted. Must
- *		return 0 if an attribute is not visible. The returned value
- *		will replace static permissions defined in struct attribute.
- * @is_bin_visible:
- *		Optional: Function to return permissions associated with a
- *		binary attribute of the group. Will be called repeatedly
- *		for each binary attribute in the group. Only read/write
- *		permissions as well as SYSFS_PREALLOC are accepted. Must
- *		return 0 if a binary attribute is not visible. The returned
- *		value will replace static permissions defined in
- *		struct bin_attribute.
- * @attrs:	Pointer to NULL terminated list of attributes.
- * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
- *		Either attrs or bin_attrs or both must be provided.
- */
-struct attribute_group {
-	const char		*name;
-	umode_t			(*is_visible)(struct kobject *,
-					      struct attribute *, int);
-	umode_t			(*is_bin_visible)(struct kobject *,
-						  struct bin_attribute *, int);
-	struct attribute	**attrs;
-	struct bin_attribute	**bin_attrs;
-};
-
 /*
  * Use these macros to make defining attributes easier.
  * See include/linux/device.h for examples..
@@ -163,25 +121,6 @@ static const struct attribute_group _name##_group = {		\
 };								\
 __ATTRIBUTE_GROUPS(_name)
 
-struct file;
-struct vm_area_struct;
-struct address_space;
-
-struct bin_attribute {
-	struct attribute	attr;
-	size_t			size;
-	void			*private;
-	struct address_space *(*f_mapping)(void);
-	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
-			char *, loff_t, size_t);
-	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
-			 char *, loff_t, size_t);
-	loff_t (*llseek)(struct file *, struct kobject *, struct bin_attribute *,
-			 loff_t, int);
-	int (*mmap)(struct file *, struct kobject *, struct bin_attribute *attr,
-		    struct vm_area_struct *vma);
-};
-
 /**
  *	sysfs_bin_attr_init - initialize a dynamically allocated bin_attribute
  *	@attr: struct bin_attribute to initialize
diff --git a/include/linux/sysfs_types.h b/include/linux/sysfs_types.h
new file mode 100644
index 000000000000..2840a1935ea1
--- /dev/null
+++ b/include/linux/sysfs_types.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * sysfs.h - definitions for the device driver filesystem
+ *
+ * Copyright (c) 2001,2002 Patrick Mochel
+ * Copyright (c) 2004 Silicon Graphics, Inc.
+ * Copyright (c) 2007 SUSE Linux Products GmbH
+ * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
+ *
+ * Please see Documentation/filesystems/sysfs.rst for more information.
+ */
+
+#ifndef _SYSFS_TYPES_H_
+#define _SYSFS_TYPES_H_
+
+#include <linux/types.h>
+#include <linux/lockdep_types.h>
+
+struct kobject;
+struct module;
+struct bin_attribute;
+
+struct attribute {
+	const char		*name;
+	umode_t			mode;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	bool			ignore_lockdep:1;
+	struct lock_class_key	*key;
+	struct lock_class_key	skey;
+#endif
+};
+
+/**
+ * struct attribute_group - data structure used to declare an attribute group.
+ * @name:	Optional: Attribute group name
+ *		If specified, the attribute group will be created in
+ *		a new subdirectory with this name.
+ * @is_visible:	Optional: Function to return permissions associated with an
+ *		attribute of the group. Will be called repeatedly for each
+ *		non-binary attribute in the group. Only read/write
+ *		permissions as well as SYSFS_PREALLOC are accepted. Must
+ *		return 0 if an attribute is not visible. The returned value
+ *		will replace static permissions defined in struct attribute.
+ * @is_bin_visible:
+ *		Optional: Function to return permissions associated with a
+ *		binary attribute of the group. Will be called repeatedly
+ *		for each binary attribute in the group. Only read/write
+ *		permissions as well as SYSFS_PREALLOC are accepted. Must
+ *		return 0 if a binary attribute is not visible. The returned
+ *		value will replace static permissions defined in
+ *		struct bin_attribute.
+ * @attrs:	Pointer to NULL terminated list of attributes.
+ * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
+ *		Either attrs or bin_attrs or both must be provided.
+ */
+struct attribute_group {
+	const char		*name;
+	umode_t			(*is_visible)(struct kobject *,
+					      struct attribute *, int);
+	umode_t			(*is_bin_visible)(struct kobject *,
+						  struct bin_attribute *, int);
+	struct attribute	**attrs;
+	struct bin_attribute	**bin_attrs;
+};
+
+struct file;
+struct vm_area_struct;
+struct address_space;
+
+struct bin_attribute {
+	struct attribute	attr;
+	size_t			size;
+#ifdef __cplusplus
+	void			*private_;
+#else
+	void			*private;
+#endif
+	struct address_space *(*f_mapping)(void);
+	ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
+			char *, loff_t, size_t);
+	ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
+			 char *, loff_t, size_t);
+	loff_t (*llseek)(struct file *, struct kobject *, struct bin_attribute *,
+			 loff_t, int);
+	int (*mmap)(struct file *, struct kobject *, struct bin_attribute *attr,
+		    struct vm_area_struct *vma);
+};
+
+#endif /* _SYSFS_TYPES_H_ */
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index db474472e982..f58dcf5712ad 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -13,7 +13,7 @@
 #include <linux/of.h>
 #include <linux/idr.h>
 #include <linux/device.h>
-#include <linux/sysfs.h>
+#include <linux/sysfs_types.h>
 #include <linux/workqueue_types.h>
 #include <uapi/linux/thermal.h>
 
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 4841ec031857..7122cb4b7e44 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -4,7 +4,7 @@
 
 #include <linux/kobject_types.h>
 #include <linux/netdevice.h>
-#include <linux/sysfs.h>
+#include <linux/sysfs_types.h>
 #include <net/xdp.h>
 
 /* This structure contains an instance of an RX queue. */
diff --git a/include/rdma/ib_sysfs.h b/include/rdma/ib_sysfs.h
index 3b77cfd74d9a..ece1b920c690 100644
--- a/include/rdma/ib_sysfs.h
+++ b/include/rdma/ib_sysfs.h
@@ -5,7 +5,7 @@
 #ifndef DEF_RDMA_IB_SYSFS_H
 #define DEF_RDMA_IB_SYSFS_H
 
-#include <linux/sysfs.h>
+#include <linux/sysfs_types.h>
 
 struct ib_device;
 
diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 42163c9e94e5..b48bd8a23cda 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/kobject.h>
 #include <linux/init.h>
+#include <linux/sysfs.h>
 
 /*
  * Define kernel_headers_data and kernel_headers_data_end, within which the
diff --git a/lib/kobject.c b/lib/kobject.c
index c7b3513158ad..b7aa69ed802e 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -21,6 +21,7 @@
 #include <linux/uidgid.h>
 #include <linux/workqueue.h>
 #include <linux/kref.h>
+#include <linux/sysfs.h>
 
 /**
  * kobject_namespace() - Return @kobj's namespace tag.
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index 56347d15b7e8..8af53a35fbc6 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -8,6 +8,7 @@
 #include <linux/cma.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "cma.h"
 
-- 
2.39.2


