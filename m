Return-Path: <linux-kernel+bounces-117336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839A88AA26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAFC1C3573F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85574A2D;
	Mon, 25 Mar 2024 15:11:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90DE3DABF4;
	Mon, 25 Mar 2024 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379518; cv=none; b=QP8tntWHndO6sEXAzXWk+lqkZpg8lDccNGgArj7bIaFNJogC7ijGilEZTGxC29nmqTDjlivBfTUvWr6mplf85fgI1tFQsEdtQUufomwhleXMmEwJrwBBKQWh+7o02ieiyCjN/UVe+fnEC7sCSJBg/2srmT2bzM2Lkq5T78+f+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379518; c=relaxed/simple;
	bh=pgOcfgxlv/nSynxzM2kyQFJ6ORAtCrKGEwsFqJe07ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wo9HeURdRHmRIwgTSA1g54uOIj+DSf2+ewUPP9kMf7+3NO1ABq3p05QaGkNnt8pt9FAQht5BDQHD20wvWB2MVhg/NxIAOio6ff2u4NY59n/T817rkFXes3n3s2FfGkBIXeRSjTnFpwlIvZBH7Gb6vMrW6sMDOqFV5pCl2++xD5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AD6E2F4;
	Mon, 25 Mar 2024 08:12:28 -0700 (PDT)
Received: from mango.localdomain (unknown [10.57.15.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 571643F64C;
	Mon, 25 Mar 2024 08:11:52 -0700 (PDT)
From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: jens.wiklander@linaro.org,
	sumit.garg@linaro.org,
	corbet@lwn.net,
	balint.dobszay@arm.com,
	sudeep.holla@arm.com,
	rdunlap@infradead.org,
	krzk@kernel.org,
	gyorgy.szing@arm.com
Subject: [PATCH v4 1/5] tee: Refactor TEE subsystem header files
Date: Mon, 25 Mar 2024 16:11:01 +0100
Message-Id: <20240325151105.135667-2-balint.dobszay@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325151105.135667-1-balint.dobszay@arm.com>
References: <20240325151105.135667-1-balint.dobszay@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sumit Garg <sumit.garg@linaro.org>

Since commit 25559c22cef8 ("tee: add kernel internal client interface"),
it has been a common include/linux/tee_drv.h header file which is shared
to hold TEE subsystem internal bits along with the APIs exposed to the
TEE client drivers. However, this practice is prone to TEE subsystem
internal APIs abuse and especially so with the new TEE implementation
drivers being added to reuse existing functionality.

In order to address this split TEE subsystem internal bits as a separate
header file: include/linux/tee_core.h which should be the one used by
TEE implementation drivers. With that include/linux/tee_drv.h lists only
APIs exposed by TEE subsystem to the TEE client drivers.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
---
 MAINTAINERS                         |   1 +
 drivers/tee/amdtee/amdtee_private.h |   2 +-
 drivers/tee/amdtee/call.c           |   2 +-
 drivers/tee/amdtee/core.c           |   3 +-
 drivers/tee/amdtee/shm_pool.c       |   2 +-
 drivers/tee/optee/call.c            |   2 +-
 drivers/tee/optee/core.c            |   2 +-
 drivers/tee/optee/device.c          |   2 +-
 drivers/tee/optee/ffa_abi.c         |   2 +-
 drivers/tee/optee/notif.c           |   2 +-
 drivers/tee/optee/optee_private.h   |   2 +-
 drivers/tee/optee/rpc.c             |   2 +-
 drivers/tee/optee/smc_abi.c         |   2 +-
 drivers/tee/tee_core.c              |   2 +-
 drivers/tee/tee_private.h           |  35 ----
 drivers/tee/tee_shm.c               |   2 +-
 drivers/tee/tee_shm_pool.c          |   2 +-
 include/linux/tee_core.h            | 296 ++++++++++++++++++++++++++++
 include/linux/tee_drv.h             | 285 +++-----------------------
 19 files changed, 343 insertions(+), 305 deletions(-)
 create mode 100644 include/linux/tee_core.h

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..fd221a7d4d1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21684,6 +21684,7 @@ F:	Documentation/driver-api/tee.rst
 F:	Documentation/tee/
 F:	Documentation/userspace-api/tee.rst
 F:	drivers/tee/
+F:	include/linux/tee_core.h
 F:	include/linux/tee_drv.h
 F:	include/uapi/linux/tee.h
 
diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
index 6d0f7062bb87..d87050033894 100644
--- a/drivers/tee/amdtee/amdtee_private.h
+++ b/drivers/tee/amdtee/amdtee_private.h
@@ -9,7 +9,7 @@
 
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/kref.h>
 #include <linux/types.h>
 #include "amdtee_if.h"
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index e9b63dcb3194..4c21b02be4af 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -5,7 +5,7 @@
 
 #include <linux/device.h>
 #include <linux/tee.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/psp-tee.h>
 #include <linux/slab.h>
 #include <linux/psp.h>
diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 3c15f6a9e91c..e487231d25dc 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -9,13 +9,12 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/device.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 #include <linux/firmware.h>
 #include "amdtee_private.h"
-#include "../tee_private.h"
 #include <linux/psp-tee.h>
 
 static struct amdtee_driver_data *drv_data;
diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
index f0303126f199..6346e0bc8a64 100644
--- a/drivers/tee/amdtee/shm_pool.c
+++ b/drivers/tee/amdtee/shm_pool.c
@@ -4,7 +4,7 @@
  */
 
 #include <linux/slab.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/psp.h>
 #include "amdtee_private.h"
 
diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index a91e50be11be..16eb953e14bb 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -7,7 +7,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/types.h>
 #include "optee_private.h"
 
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 3aed554bc8d8..f762e3a25119 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -13,7 +13,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/types.h>
 #include "optee_private.h"
 
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 1892e49a8e6a..d296c70ddfdc 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -7,7 +7,7 @@
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/uuid.h>
 #include "optee_private.h"
 
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index ecb5eb079408..cee8ccb84cb8 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -11,7 +11,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/types.h>
 #include "optee_private.h"
 #include "optee_ffa.h"
diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
index 05212842b0a5..0d7878e770cd 100644
--- a/drivers/tee/optee/notif.c
+++ b/drivers/tee/optee/notif.c
@@ -9,7 +9,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include "optee_private.h"
 
 struct notif_entry {
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 7a5243c78b55..a0698ac18993 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -9,7 +9,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/rhashtable.h>
 #include <linux/semaphore.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/types.h>
 #include "optee_msg.h"
 
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index e69bc6380683..f086812f1179 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -8,7 +8,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include "optee_private.h"
 #include "optee_rpc_cmd.h"
 
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a37f87087e5c..9c296b887dc1 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -23,7 +23,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include "optee_private.h"
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index e59c20d74b36..82ad095d2b1c 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -11,7 +11,7 @@
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/uaccess.h>
 #include <crypto/hash.h>
 #include <crypto/sha1.h>
diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
index 754e11dcb240..9bc50605227c 100644
--- a/drivers/tee/tee_private.h
+++ b/drivers/tee/tee_private.h
@@ -12,41 +12,6 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 
-#define TEE_DEVICE_FLAG_REGISTERED	0x1
-#define TEE_MAX_DEV_NAME_LEN		32
-
-/**
- * struct tee_device - TEE Device representation
- * @name:	name of device
- * @desc:	description of device
- * @id:		unique id of device
- * @flags:	represented by TEE_DEVICE_FLAG_REGISTERED above
- * @dev:	embedded basic device structure
- * @cdev:	embedded cdev
- * @num_users:	number of active users of this device
- * @c_no_user:	completion used when unregistering the device
- * @mutex:	mutex protecting @num_users and @idr
- * @idr:	register of user space shared memory objects allocated or
- *		registered on this device
- * @pool:	shared memory pool
- */
-struct tee_device {
-	char name[TEE_MAX_DEV_NAME_LEN];
-	const struct tee_desc *desc;
-	int id;
-	unsigned int flags;
-
-	struct device dev;
-	struct cdev cdev;
-
-	size_t num_users;
-	struct completion c_no_users;
-	struct mutex mutex;	/* protects num_users and idr */
-
-	struct idr idr;
-	struct tee_shm_pool *pool;
-};
-
 int tee_shm_get_fd(struct tee_shm *shm);
 
 bool tee_device_get(struct tee_device *teedev);
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 731d9028b67f..96a45c817427 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -8,7 +8,7 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
 #include <linux/highmem.h>
diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
index 058bfbac657a..80004b55628d 100644
--- a/drivers/tee/tee_shm_pool.c
+++ b/drivers/tee/tee_shm_pool.c
@@ -6,7 +6,7 @@
 #include <linux/dma-buf.h>
 #include <linux/genalloc.h>
 #include <linux/slab.h>
-#include <linux/tee_drv.h>
+#include <linux/tee_core.h>
 #include "tee_private.h"
 
 static int pool_op_gen_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
new file mode 100644
index 000000000000..d9b3ba8e8fa9
--- /dev/null
+++ b/include/linux/tee_core.h
@@ -0,0 +1,296 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 Linaro Limited
+ */
+
+#ifndef __TEE_CORE_H
+#define __TEE_CORE_H
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/tee.h>
+#include <linux/tee_drv.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+/*
+ * The file describes the API provided by the generic TEE driver to the
+ * specific TEE driver.
+ */
+
+#define TEE_SHM_DYNAMIC		BIT(0)  /* Dynamic shared memory registered */
+					/* in secure world */
+#define TEE_SHM_USER_MAPPED	BIT(1)  /* Memory mapped in user space */
+#define TEE_SHM_POOL		BIT(2)  /* Memory allocated from pool */
+#define TEE_SHM_PRIV		BIT(3)  /* Memory private to TEE driver */
+
+#define TEE_DEVICE_FLAG_REGISTERED	0x1
+#define TEE_MAX_DEV_NAME_LEN		32
+
+/**
+ * struct tee_device - TEE Device representation
+ * @name:	name of device
+ * @desc:	description of device
+ * @id:		unique id of device
+ * @flags:	represented by TEE_DEVICE_FLAG_REGISTERED above
+ * @dev:	embedded basic device structure
+ * @cdev:	embedded cdev
+ * @num_users:	number of active users of this device
+ * @c_no_user:	completion used when unregistering the device
+ * @mutex:	mutex protecting @num_users and @idr
+ * @idr:	register of user space shared memory objects allocated or
+ *		registered on this device
+ * @pool:	shared memory pool
+ */
+struct tee_device {
+	char name[TEE_MAX_DEV_NAME_LEN];
+	const struct tee_desc *desc;
+	int id;
+	unsigned int flags;
+
+	struct device dev;
+	struct cdev cdev;
+
+	size_t num_users;
+	struct completion c_no_users;
+	struct mutex mutex;	/* protects num_users and idr */
+
+	struct idr idr;
+	struct tee_shm_pool *pool;
+};
+
+/**
+ * struct tee_driver_ops - driver operations vtable
+ * @get_version:	returns version of driver
+ * @open:		called when the device file is opened
+ * @release:		release this open file
+ * @open_session:	open a new session
+ * @close_session:	close a session
+ * @system_session:	declare session as a system session
+ * @invoke_func:	invoke a trusted function
+ * @cancel_req:		request cancel of an ongoing invoke or open
+ * @supp_recv:		called for supplicant to get a command
+ * @supp_send:		called for supplicant to send a response
+ * @shm_register:	register shared memory buffer in TEE
+ * @shm_unregister:	unregister shared memory buffer in TEE
+ */
+struct tee_driver_ops {
+	void (*get_version)(struct tee_device *teedev,
+			    struct tee_ioctl_version_data *vers);
+	int (*open)(struct tee_context *ctx);
+	void (*release)(struct tee_context *ctx);
+	int (*open_session)(struct tee_context *ctx,
+			    struct tee_ioctl_open_session_arg *arg,
+			    struct tee_param *param);
+	int (*close_session)(struct tee_context *ctx, u32 session);
+	int (*system_session)(struct tee_context *ctx, u32 session);
+	int (*invoke_func)(struct tee_context *ctx,
+			   struct tee_ioctl_invoke_arg *arg,
+			   struct tee_param *param);
+	int (*cancel_req)(struct tee_context *ctx, u32 cancel_id, u32 session);
+	int (*supp_recv)(struct tee_context *ctx, u32 *func, u32 *num_params,
+			 struct tee_param *param);
+	int (*supp_send)(struct tee_context *ctx, u32 ret, u32 num_params,
+			 struct tee_param *param);
+	int (*shm_register)(struct tee_context *ctx, struct tee_shm *shm,
+			    struct page **pages, size_t num_pages,
+			    unsigned long start);
+	int (*shm_unregister)(struct tee_context *ctx, struct tee_shm *shm);
+};
+
+/**
+ * struct tee_desc - Describes the TEE driver to the subsystem
+ * @name:	name of driver
+ * @ops:	driver operations vtable
+ * @owner:	module providing the driver
+ * @flags:	Extra properties of driver, defined by TEE_DESC_* below
+ */
+#define TEE_DESC_PRIVILEGED	0x1
+struct tee_desc {
+	const char *name;
+	const struct tee_driver_ops *ops;
+	struct module *owner;
+	u32 flags;
+};
+
+/**
+ * tee_device_alloc() - Allocate a new struct tee_device instance
+ * @teedesc:	Descriptor for this driver
+ * @dev:	Parent device for this device
+ * @pool:	Shared memory pool, NULL if not used
+ * @driver_data: Private driver data for this device
+ *
+ * Allocates a new struct tee_device instance. The device is
+ * removed by tee_device_unregister().
+ *
+ * @returns a pointer to a 'struct tee_device' or an ERR_PTR on failure
+ */
+struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
+				    struct device *dev,
+				    struct tee_shm_pool *pool,
+				    void *driver_data);
+
+/**
+ * tee_device_register() - Registers a TEE device
+ * @teedev:	Device to register
+ *
+ * tee_device_unregister() need to be called to remove the @teedev if
+ * this function fails.
+ *
+ * @returns < 0 on failure
+ */
+int tee_device_register(struct tee_device *teedev);
+
+/**
+ * tee_device_unregister() - Removes a TEE device
+ * @teedev:	Device to unregister
+ *
+ * This function should be called to remove the @teedev even if
+ * tee_device_register() hasn't been called yet. Does nothing if
+ * @teedev is NULL.
+ */
+void tee_device_unregister(struct tee_device *teedev);
+
+/**
+ * tee_session_calc_client_uuid() - Calculates client UUID for session
+ * @uuid:		Resulting UUID
+ * @connection_method:	Connection method for session (TEE_IOCTL_LOGIN_*)
+ * @connectuon_data:	Connection data for opening session
+ *
+ * Based on connection method calculates UUIDv5 based client UUID.
+ *
+ * For group based logins verifies that calling process has specified
+ * credentials.
+ *
+ * @return < 0 on failure
+ */
+int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
+				 const u8 connection_data[TEE_IOCTL_UUID_LEN]);
+
+/**
+ * struct tee_shm_pool - shared memory pool
+ * @ops:		operations
+ * @private_data:	private data for the shared memory manager
+ */
+struct tee_shm_pool {
+	const struct tee_shm_pool_ops *ops;
+	void *private_data;
+};
+
+/**
+ * struct tee_shm_pool_ops - shared memory pool operations
+ * @alloc:		called when allocating shared memory
+ * @free:		called when freeing shared memory
+ * @destroy_pool:	called when destroying the pool
+ */
+struct tee_shm_pool_ops {
+	int (*alloc)(struct tee_shm_pool *pool, struct tee_shm *shm,
+		     size_t size, size_t align);
+	void (*free)(struct tee_shm_pool *pool, struct tee_shm *shm);
+	void (*destroy_pool)(struct tee_shm_pool *pool);
+};
+
+/*
+ * tee_shm_pool_alloc_res_mem() - Create a shm manager for reserved memory
+ * @vaddr:	Virtual address of start of pool
+ * @paddr:	Physical address of start of pool
+ * @size:	Size in bytes of the pool
+ *
+ * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
+ */
+struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
+						phys_addr_t paddr, size_t size,
+						int min_alloc_order);
+
+/**
+ * tee_shm_pool_free() - Free a shared memory pool
+ * @pool:	The shared memory pool to free
+ *
+ * The must be no remaining shared memory allocated from this pool when
+ * this function is called.
+ */
+static inline void tee_shm_pool_free(struct tee_shm_pool *pool)
+{
+	pool->ops->destroy_pool(pool);
+}
+
+/**
+ * tee_get_drvdata() - Return driver_data pointer
+ * @returns the driver_data pointer supplied to tee_register().
+ */
+void *tee_get_drvdata(struct tee_device *teedev);
+
+/**
+ * tee_shm_alloc_priv_buf() - Allocate shared memory for private use by specific
+ *                            TEE driver
+ * @ctx:	The TEE context for shared memory allocation
+ * @size:	Shared memory allocation size
+ * @returns a pointer to 'struct tee_shm' on success or an ERR_PTR on failure
+ */
+struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
+
+/**
+ * tee_shm_is_dynamic() - Check if shared memory object is of the dynamic kind
+ * @shm:	Shared memory handle
+ * @returns true if object is dynamic shared memory
+ */
+static inline bool tee_shm_is_dynamic(struct tee_shm *shm)
+{
+	return shm && (shm->flags & TEE_SHM_DYNAMIC);
+}
+
+/**
+ * tee_shm_put() - Decrease reference count on a shared memory handle
+ * @shm:	Shared memory handle
+ */
+void tee_shm_put(struct tee_shm *shm);
+
+/**
+ * tee_shm_get_id() - Get id of a shared memory object
+ * @shm:	Shared memory handle
+ * @returns id
+ */
+static inline int tee_shm_get_id(struct tee_shm *shm)
+{
+	return shm->id;
+}
+
+/**
+ * tee_shm_get_from_id() - Find shared memory object and increase reference
+ * count
+ * @ctx:	Context owning the shared memory
+ * @id:		Id of shared memory object
+ * @returns a pointer to 'struct tee_shm' on success or an ERR_PTR on failure
+ */
+struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
+
+static inline bool tee_param_is_memref(struct tee_param *param)
+{
+	switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
+	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
+	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
+	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * teedev_open() - Open a struct tee_device
+ * @teedev:	Device to open
+ *
+ * @return a pointer to struct tee_context on success or an ERR_PTR on failure.
+ */
+struct tee_context *teedev_open(struct tee_device *teedev);
+
+/**
+ * teedev_close_context() - closes a struct tee_context
+ * @ctx:	The struct tee_context to close
+ */
+void teedev_close_context(struct tee_context *ctx);
+
+#endif /*__TEE_CORE_H*/
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 71632e3c5f18..786b9ae6cf4d 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -1,40 +1,28 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2015-2022 Linaro Limited
+ * Copyright (c) 2015-2024 Linaro Limited
  */
 
 #ifndef __TEE_DRV_H
 #define __TEE_DRV_H
 
 #include <linux/device.h>
-#include <linux/idr.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/mod_devicetable.h>
 #include <linux/tee.h>
 #include <linux/types.h>
-#include <linux/uuid.h>
 
 /*
- * The file describes the API provided by the generic TEE driver to the
- * specific TEE driver.
+ * The file describes the API provided by the TEE subsystem to the
+ * TEE client drivers.
  */
 
-#define TEE_SHM_DYNAMIC		BIT(0)  /* Dynamic shared memory registered */
-					/* in secure world */
-#define TEE_SHM_USER_MAPPED	BIT(1)  /* Memory mapped in user space */
-#define TEE_SHM_POOL		BIT(2)  /* Memory allocated from pool */
-#define TEE_SHM_PRIV		BIT(3)  /* Memory private to TEE driver */
-
-struct device;
 struct tee_device;
-struct tee_shm;
-struct tee_shm_pool;
 
 /**
  * struct tee_context - driver specific context on file pointer data
  * @teedev:	pointer to this drivers struct tee_device
- * @list_shm:	List of shared memory object owned by this context
  * @data:	driver specific context data, managed by the driver
  * @refcount:	reference counter for this structure
  * @releasing:  flag that indicates if context is being released right now.
@@ -57,134 +45,6 @@ struct tee_context {
 	bool cap_memref_null;
 };
 
-struct tee_param_memref {
-	size_t shm_offs;
-	size_t size;
-	struct tee_shm *shm;
-};
-
-struct tee_param_value {
-	u64 a;
-	u64 b;
-	u64 c;
-};
-
-struct tee_param {
-	u64 attr;
-	union {
-		struct tee_param_memref memref;
-		struct tee_param_value value;
-	} u;
-};
-
-/**
- * struct tee_driver_ops - driver operations vtable
- * @get_version:	returns version of driver
- * @open:		called when the device file is opened
- * @release:		release this open file
- * @open_session:	open a new session
- * @close_session:	close a session
- * @system_session:	declare session as a system session
- * @invoke_func:	invoke a trusted function
- * @cancel_req:		request cancel of an ongoing invoke or open
- * @supp_recv:		called for supplicant to get a command
- * @supp_send:		called for supplicant to send a response
- * @shm_register:	register shared memory buffer in TEE
- * @shm_unregister:	unregister shared memory buffer in TEE
- */
-struct tee_driver_ops {
-	void (*get_version)(struct tee_device *teedev,
-			    struct tee_ioctl_version_data *vers);
-	int (*open)(struct tee_context *ctx);
-	void (*release)(struct tee_context *ctx);
-	int (*open_session)(struct tee_context *ctx,
-			    struct tee_ioctl_open_session_arg *arg,
-			    struct tee_param *param);
-	int (*close_session)(struct tee_context *ctx, u32 session);
-	int (*system_session)(struct tee_context *ctx, u32 session);
-	int (*invoke_func)(struct tee_context *ctx,
-			   struct tee_ioctl_invoke_arg *arg,
-			   struct tee_param *param);
-	int (*cancel_req)(struct tee_context *ctx, u32 cancel_id, u32 session);
-	int (*supp_recv)(struct tee_context *ctx, u32 *func, u32 *num_params,
-			 struct tee_param *param);
-	int (*supp_send)(struct tee_context *ctx, u32 ret, u32 num_params,
-			 struct tee_param *param);
-	int (*shm_register)(struct tee_context *ctx, struct tee_shm *shm,
-			    struct page **pages, size_t num_pages,
-			    unsigned long start);
-	int (*shm_unregister)(struct tee_context *ctx, struct tee_shm *shm);
-};
-
-/**
- * struct tee_desc - Describes the TEE driver to the subsystem
- * @name:	name of driver
- * @ops:	driver operations vtable
- * @owner:	module providing the driver
- * @flags:	Extra properties of driver, defined by TEE_DESC_* below
- */
-#define TEE_DESC_PRIVILEGED	0x1
-struct tee_desc {
-	const char *name;
-	const struct tee_driver_ops *ops;
-	struct module *owner;
-	u32 flags;
-};
-
-/**
- * tee_device_alloc() - Allocate a new struct tee_device instance
- * @teedesc:	Descriptor for this driver
- * @dev:	Parent device for this device
- * @pool:	Shared memory pool, NULL if not used
- * @driver_data: Private driver data for this device
- *
- * Allocates a new struct tee_device instance. The device is
- * removed by tee_device_unregister().
- *
- * @returns a pointer to a 'struct tee_device' or an ERR_PTR on failure
- */
-struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
-				    struct device *dev,
-				    struct tee_shm_pool *pool,
-				    void *driver_data);
-
-/**
- * tee_device_register() - Registers a TEE device
- * @teedev:	Device to register
- *
- * tee_device_unregister() need to be called to remove the @teedev if
- * this function fails.
- *
- * @returns < 0 on failure
- */
-int tee_device_register(struct tee_device *teedev);
-
-/**
- * tee_device_unregister() - Removes a TEE device
- * @teedev:	Device to unregister
- *
- * This function should be called to remove the @teedev even if
- * tee_device_register() hasn't been called yet. Does nothing if
- * @teedev is NULL.
- */
-void tee_device_unregister(struct tee_device *teedev);
-
-/**
- * tee_session_calc_client_uuid() - Calculates client UUID for session
- * @uuid:		Resulting UUID
- * @connection_method:	Connection method for session (TEE_IOCTL_LOGIN_*)
- * @connectuon_data:	Connection data for opening session
- *
- * Based on connection method calculates UUIDv5 based client UUID.
- *
- * For group based logins verifies that calling process has specified
- * credentials.
- *
- * @return < 0 on failure
- */
-int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
-				 const u8 connection_data[TEE_IOCTL_UUID_LEN]);
-
 /**
  * struct tee_shm - shared memory object
  * @ctx:	context using the object
@@ -195,15 +55,12 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
  * @pages:	locked pages from userspace
  * @num_pages:	number of locked pages
  * @refcount:	reference counter
- * @flags:	defined by TEE_SHM_* in tee_drv.h
+ * @flags:	defined by TEE_SHM_* in tee_core.h
  * @id:		unique id of a shared memory object on this device, shared
  *		with user space
  * @sec_world_id:
  *		secure world assigned id of this shared memory object, not
  *		used by all drivers
- *
- * This pool is only supposed to be accessed directly from the TEE
- * subsystem and from drivers that implements their own shm pool manager.
  */
 struct tee_shm {
 	struct tee_context *ctx;
@@ -219,87 +76,52 @@ struct tee_shm {
 	u64 sec_world_id;
 };
 
-/**
- * struct tee_shm_pool - shared memory pool
- * @ops:		operations
- * @private_data:	private data for the shared memory manager
- */
-struct tee_shm_pool {
-	const struct tee_shm_pool_ops *ops;
-	void *private_data;
+struct tee_param_memref {
+	size_t shm_offs;
+	size_t size;
+	struct tee_shm *shm;
 };
 
-/**
- * struct tee_shm_pool_ops - shared memory pool operations
- * @alloc:		called when allocating shared memory
- * @free:		called when freeing shared memory
- * @destroy_pool:	called when destroying the pool
- */
-struct tee_shm_pool_ops {
-	int (*alloc)(struct tee_shm_pool *pool, struct tee_shm *shm,
-		     size_t size, size_t align);
-	void (*free)(struct tee_shm_pool *pool, struct tee_shm *shm);
-	void (*destroy_pool)(struct tee_shm_pool *pool);
+struct tee_param_value {
+	u64 a;
+	u64 b;
+	u64 c;
 };
 
-/*
- * tee_shm_pool_alloc_res_mem() - Create a shm manager for reserved memory
- * @vaddr:	Virtual address of start of pool
- * @paddr:	Physical address of start of pool
- * @size:	Size in bytes of the pool
- *
- * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failure.
- */
-struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
-						phys_addr_t paddr, size_t size,
-						int min_alloc_order);
+struct tee_param {
+	u64 attr;
+	union {
+		struct tee_param_memref memref;
+		struct tee_param_value value;
+	} u;
+};
 
 /**
- * tee_shm_pool_free() - Free a shared memory pool
- * @pool:	The shared memory pool to free
- *
- * The must be no remaining shared memory allocated from this pool when
- * this function is called.
+ * tee_shm_alloc_kernel_buf() - Allocate kernel shared memory for a
+ *                              particular TEE client driver
+ * @ctx:	The TEE context for shared memory allocation
+ * @size:	Shared memory allocation size
+ * @returns a pointer to 'struct tee_shm' on success or an ERR_PTR on failure
  */
-static inline void tee_shm_pool_free(struct tee_shm_pool *pool)
-{
-	pool->ops->destroy_pool(pool);
-}
+struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
 
 /**
- * tee_get_drvdata() - Return driver_data pointer
- * @returns the driver_data pointer supplied to tee_register().
+ * tee_shm_register_kernel_buf() - Register kernel shared memory for a
+ *                                 particular TEE client driver
+ * @ctx:	The TEE context for shared memory registration
+ * @addr:	Kernel buffer address
+ * @length:	Kernel buffer length
+ * @returns a pointer to 'struct tee_shm' on success or an ERR_PTR on failure
  */
-void *tee_get_drvdata(struct tee_device *teedev);
-
-struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
-struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
-
 struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
 					    void *addr, size_t length);
 
-/**
- * tee_shm_is_dynamic() - Check if shared memory object is of the dynamic kind
- * @shm:	Shared memory handle
- * @returns true if object is dynamic shared memory
- */
-static inline bool tee_shm_is_dynamic(struct tee_shm *shm)
-{
-	return shm && (shm->flags & TEE_SHM_DYNAMIC);
-}
-
 /**
  * tee_shm_free() - Free shared memory
  * @shm:	Handle to shared memory to free
  */
 void tee_shm_free(struct tee_shm *shm);
 
-/**
- * tee_shm_put() - Decrease reference count on a shared memory handle
- * @shm:	Shared memory handle
- */
-void tee_shm_put(struct tee_shm *shm);
-
 /**
  * tee_shm_get_va() - Get virtual address of a shared memory plus an offset
  * @shm:	Shared memory handle
@@ -352,25 +174,6 @@ static inline size_t tee_shm_get_page_offset(struct tee_shm *shm)
 	return shm->offset;
 }
 
-/**
- * tee_shm_get_id() - Get id of a shared memory object
- * @shm:	Shared memory handle
- * @returns id
- */
-static inline int tee_shm_get_id(struct tee_shm *shm)
-{
-	return shm->id;
-}
-
-/**
- * tee_shm_get_from_id() - Find shared memory object and increase reference
- * count
- * @ctx:	Context owning the shared memory
- * @id:		Id of shared memory object
- * @returns a pointer to 'struct tee_shm' on success or an ERR_PTR on failure
- */
-struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
-
 /**
  * tee_client_open_context() - Open a TEE context
  * @start:	if not NULL, continue search after this context
@@ -470,18 +273,6 @@ int tee_client_invoke_func(struct tee_context *ctx,
 int tee_client_cancel_req(struct tee_context *ctx,
 			  struct tee_ioctl_cancel_arg *arg);
 
-static inline bool tee_param_is_memref(struct tee_param *param)
-{
-	switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
-	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
-	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
-	case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
-		return true;
-	default:
-		return false;
-	}
-}
-
 extern const struct bus_type tee_bus_type;
 
 /**
@@ -509,18 +300,4 @@ struct tee_client_driver {
 #define to_tee_client_driver(d) \
 		container_of(d, struct tee_client_driver, driver)
 
-/**
- * teedev_open() - Open a struct tee_device
- * @teedev:	Device to open
- *
- * @return a pointer to struct tee_context on success or an ERR_PTR on failure.
- */
-struct tee_context *teedev_open(struct tee_device *teedev);
-
-/**
- * teedev_close_context() - closes a struct tee_context
- * @ctx:	The struct tee_context to close
- */
-void teedev_close_context(struct tee_context *ctx);
-
 #endif /*__TEE_DRV_H*/
-- 
2.34.1


