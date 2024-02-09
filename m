Return-Path: <linux-kernel+bounces-59625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1209484F9C8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336821C22C26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420797C0A9;
	Fri,  9 Feb 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LcPeQo3b"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31F7BB04
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496857; cv=none; b=JwmmI0azllr7qfLim8BsRcfyBxm6jnNifoSh4+PbFAiN9uzyv2mzrcSbAKqZ1rJQkKWVOKXrNQNYsXxez0SD+K4UG3w8s2rjTZWp7ZwryKvtld3nZobBzL+UfcfZCbLw5fyjOLiq5z8iuVXgskaSaRKbfTFoMu3fT2GAa/3P9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496857; c=relaxed/simple;
	bh=FlfryTRGDdyF0z2mZ9UhX2PTECwgKYOqoLIQpD1+7dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DmJwSzwxIt23Fd+2+FAuHoOVCxADQErr9JYFsEgOb+tFvsRH9plC3yZh+FVCioeKL7F5QCgToitnaFCWqz5uvDKhUVakzMT+1vZ6ciic3SJBDOyrGoTlPbIwk5JsHxFx7ncVUeOvC4YfzandTk6pv4N3sdMsW+89isq02ssush8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LcPeQo3b; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a30e445602cso438565666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496851; x=1708101651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxG16Tl9aF75BCbOOBZ8CaUnNnP0NXfy2/Hg/yLLjHQ=;
        b=LcPeQo3byrugMJC0xAJhCfCb0EzxVylpsCMT/FnaLR9JtofyDFbJuTzUD4JGOqevuQ
         tWnis4YkjROBaQxXZeu8AZX6jJa2EzlxjBjPw8ayeGJN3oNmAyuLSU0DDkSByLZhBQjQ
         xXoJftQ005Mdjv5aAwlYv19FOmfWjgOsscFrxqJphUyQKAgjNjiNguMbSuiRFtlufQqF
         RnHJQ94XTabo+G3QywQi4O9Exoz76NeN21NdNwXcmllky1mFNKI+pLijJpXuHbJDfTrh
         zyThwCa/SjKKdLN5kdmjwulGW1n3o56c7VGmWgwRG8guetFRPjR/ghq0XGcxo4TNy5ZJ
         mRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496851; x=1708101651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxG16Tl9aF75BCbOOBZ8CaUnNnP0NXfy2/Hg/yLLjHQ=;
        b=QSWL4s3mmM8BuUNrzuCd3eXLmcmGERIgbhTS7xc9JW24hdN1frtP90AIfcYbmV2iyp
         qTaF2fZsaK+VHXh3QcInKE2CLSTcev0b8joGbAeN/2qORaDph/Z8ymYVpZQGADvrTx6F
         Xzcm7h3mNJp+PSOBxKZqCMmZSG5zXhNVV7+/jbOGwibgTGC7SnMKZV3Cc4PsgvN2ct38
         juBeGRLUox4CzWhJhORiDnzZ5hTdU/2xOcEHsD9Yeukzs+FPBsVdN/ZQggnZk34nJbAx
         75ojjeqiPZEi2phIRZUuvd2R8NpOaTTi0xAf+gIVC/i5VdCycQ/gZNIYTgEa8jDS8PCY
         wuWQ==
X-Gm-Message-State: AOJu0YzC2arK0zqZQXR7QGDpt+80M7HEmH/Xw5JxE6c1M8w/TPle5Orc
	miu5GoflGG14hvzogVOos5ln8+5dCHhi4sJtj6wYlTHSRdjOFgTFWeRNm97AuCs1rtp3tVbPlhx
	+
X-Google-Smtp-Source: AGHT+IF7l4jBVZTYg8cO/j3z0dzFIYOWwrDFdUe9Mlaqfxa+iQAr7FVvIGFeu//x6Ts8UtlACkrX1w==
X-Received: by 2002:a17:907:f8c:b0:a38:8c12:9c3a with SMTP id kb12-20020a1709070f8c00b00a388c129c3amr1242393ejc.11.1707496851284;
        Fri, 09 Feb 2024 08:40:51 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:40:49 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 07/35] sysfs.h: move declarations to sysfs_types.h
Date: Fri,  9 Feb 2024 17:39:59 +0100
Message-Id: <20240209164027.2582906-8-max.kellermann@ionos.com>
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
 drivers/firmware/dmi-sysfs.c    |  1 +
 drivers/firmware/memmap.c       |  1 +
 drivers/input/vivaldi-fmap.c    |  1 +
 include/linux/device/bus.h      |  2 +-
 include/linux/iio/buffer_impl.h |  3 +-
 include/linux/kobject.h         |  2 +-
 include/linux/module.h          |  2 +-
 include/linux/perf_event.h      |  2 +-
 include/linux/sysfs.h           | 63 +----------------------
 include/linux/sysfs_types.h     | 89 +++++++++++++++++++++++++++++++++
 include/linux/thermal.h         |  2 +-
 include/net/netdev_rx_queue.h   |  2 +-
 include/rdma/ib_sysfs.h         |  2 +-
 kernel/kheaders.c               |  1 +
 lib/kobject.c                   |  1 +
 mm/cma_sysfs.c                  |  1 +
 16 files changed, 105 insertions(+), 70 deletions(-)
 create mode 100644 include/linux/sysfs_types.h

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index b6a72128e818..158cc26a0331 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -25,6 +25,7 @@
 #include <linux/dmi.h>
 #include <linux/capability.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/io.h>
 #include <asm/dmi.h>
diff --git a/drivers/firmware/memmap.c b/drivers/firmware/memmap.c
index 4cf473815372..a188b204a012 100644
--- a/drivers/firmware/memmap.c
+++ b/drivers/firmware/memmap.c
@@ -14,6 +14,7 @@
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
index cd29809a05e4..462a2d604b03 100644
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
index 6fed6884d2e6..0500b023b5cc 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -13,6 +13,7 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
+#include <linux/sysfs_types.h>
 #include <linux/kernfs.h>
 #include <linux/kernel.h> // for VERIFY_OCTAL_PERMISSIONS()
 #include <linux/compiler.h>
@@ -23,16 +24,6 @@ struct kobject;
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
@@ -54,39 +45,6 @@ do {							\
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
@@ -164,25 +122,6 @@ static const struct attribute_group _name##_group = {		\
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
index e0bdda259a29..14450673bd8b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -12,7 +12,7 @@
 
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
index 48ba445604f8..f53564596438 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -22,6 +22,7 @@
 #include <linux/uidgid.h>
 #include <linux/workqueue.h>
 #include <linux/kref.h>
+#include <linux/sysfs.h>
 
 /**
  * kobject_namespace() - Return @kobj's namespace tag.
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index f50db3973171..2c75ea0827c4 100644
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


