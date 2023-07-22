Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E122175D8C9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 03:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjGVBlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 21:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGVBlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 21:41:12 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6174B1986;
        Fri, 21 Jul 2023 18:41:10 -0700 (PDT)
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [167.220.83.99])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7C1CE236FF42;
        Fri, 21 Jul 2023 18:41:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C1CE236FF42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689990069;
        bh=c0I42YqgWeoYNBohyC70WuA9P9rAMTllOz7ToVJj6qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PEUGv2pglYxSke6IqXJnRo6iTAE9NRaUOsAiX0BT398grPrdHjq6HZksoOmHoJ8ws
         N5xoxcOqHlxUtD3Us4Ky/JbTLPnoGnPj/HamnTREX857Ix6upbOOssZwrjGKN+d5Bx
         9IxLhG+ux0CzZ8b5HqgvzCnBGpGMuc05fKcRL+QM=
From:   Shyam Saini <shyamsaini@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-scsi@vger.kernel.org, shyamsaini@linux.microsoft.com,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Tyler Hicks <code@tyhicks.com>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Paul Moore <paul@paul-moore.com>,
        Allen Pais <apais@linux.microsoft.com>
Subject: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
Date:   Fri, 21 Jul 2023 18:40:37 -0700
Message-Id: <20230722014037.42647-2-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Bennée <alex.bennee@linaro.org>

[This is patch 1 from [1] Alex's submission and this RPMB layer was
originally proposed by [2]Thomas Winkler ]

A number of storage technologies support a specialised hardware
partition designed to be resistant to replay attacks. The underlying
HW protocols differ but the operations are common. The RPMB partition
cannot be accessed via standard block layer, but by a set of specific
commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
partition provides authenticated and replay protected access, hence
suitable as a secure storage.

The initial aim of this patch is to provide a simple RPMB Driver which
can be accessed by Linux's optee driver to facilitate fast-path for
RPMB access to optee OS(secure OS) during the boot time. [1] Currently,
Optee OS relies on user-tee supplicant to access eMMC RPMB partition.

A TEE device driver can claim the RPMB interface, for example, via
class_interface_register(). The RPMB driver provides a series of
operations for interacting with the device.

  * program_key - a one time operation for setting up a new device
  * get_capacity - introspect the device capacity
  * get_write_counter - check the write counter
  * write_blocks - write a series of blocks to the RPMB device
  * read_blocks - read a series of blocks from the RPMB device

The detailed operation of implementing the access is left to the TEE
device driver itself.

The framing details and HW specific bits (JDEC vs NVME frames) are
left to the lower level TEE driver to worry about.

Without kernel fast path to RPMB access doesn't work when IMA try to
extend ftpm's PCR registers.

This fast-path would require additional work in linux optee driver and
as well as in MMC driver.

[1] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@linaro.org/
[2] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas.winkler@intel.com/
[3] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>

Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus  Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tyler Hicks <code@tyhicks.com>
Cc: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Allen Pais <apais@linux.microsoft.com>
---
 MAINTAINERS           |   7 +
 drivers/Kconfig       |   1 +
 drivers/Makefile      |   2 +
 drivers/rpmb/Kconfig  |  11 ++
 drivers/rpmb/Makefile |   7 +
 drivers/rpmb/core.c   | 439 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/rpmb.h  | 182 +++++++++++++++++
 7 files changed, 649 insertions(+)
 create mode 100644 drivers/rpmb/Kconfig
 create mode 100644 drivers/rpmb/Makefile
 create mode 100644 drivers/rpmb/core.c
 create mode 100644 include/linux/rpmb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 139106909db6..52d2020ba1d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18480,6 +18480,13 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-rotate.yaml
 F:	drivers/media/platform/sunxi/sun8i-rotate/
 
+RPMB SUBSYSTEM
+M:	?
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/rpmb/*
+F:	include/linux/rpmb.h
+
 RPMSG TTY DRIVER
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
 L:	linux-remoteproc@vger.kernel.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 514ae6b24cb2..9db924f85e07 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -242,5 +242,6 @@ source "drivers/peci/Kconfig"
 source "drivers/hte/Kconfig"
 
 source "drivers/cdx/Kconfig"
+source "drivers/rpmb/Kconfig"
 
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 7241d80a7b29..f8f8d9212567 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -195,3 +195,5 @@ obj-$(CONFIG_PECI)		+= peci/
 obj-$(CONFIG_HTE)		+= hte/
 obj-$(CONFIG_DRM_ACCEL)		+= accel/
 obj-$(CONFIG_CDX_BUS)		+= cdx/
+obj-$(CONFIG_RPMB)             += rpmb/
+
diff --git a/drivers/rpmb/Kconfig b/drivers/rpmb/Kconfig
new file mode 100644
index 000000000000..f2a9ebdc4435
--- /dev/null
+++ b/drivers/rpmb/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015-2019, Intel Corporation.
+
+config RPMB
+	tristate "RPMB partition interface"
+	help
+	  Unified RPMB partition interface for RPMB capable devices such as
+          eMMC and UFS. Provides interface for in kernel security controllers to
+	  access RPMB partition.
+
+	  If unsure, select N.
diff --git a/drivers/rpmb/Makefile b/drivers/rpmb/Makefile
new file mode 100644
index 000000000000..24d4752a9a53
--- /dev/null
+++ b/drivers/rpmb/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015-2019, Intel Corporation.
+
+obj-$(CONFIG_RPMB) += rpmb.o
+rpmb-objs += core.o
+
+ccflags-y += -D__CHECK_ENDIAN__
diff --git a/drivers/rpmb/core.c b/drivers/rpmb/core.c
new file mode 100644
index 000000000000..5bb7dbaa5464
--- /dev/null
+++ b/drivers/rpmb/core.c
@@ -0,0 +1,439 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2015 - 2019 Intel Corporation. All rights reserved.
+ * Copyright(c) 2021 - 2022 Linaro Ltd.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+
+#include <linux/rpmb.h>
+#include "rpmb-cdev.h"
+
+static DEFINE_IDA(rpmb_ida);
+
+/**
+ * rpmb_dev_get() - increase rpmb device ref counter
+ * @rdev: rpmb device
+ */
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	return get_device(&rdev->dev) ? rdev : NULL;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_get);
+
+/**
+ * rpmb_dev_put() - decrease rpmb device ref counter
+ * @rdev: rpmb device
+ */
+void rpmb_dev_put(struct rpmb_dev *rdev)
+{
+	put_device(&rdev->dev);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_put);
+
+/**
+ * rpmb_program_key() - program the RPMB access key
+ * @rdev: rpmb device
+ * @keylen: length of key data
+ * @key: key data
+ *
+ * A successful programming of the key implies it has been set by the
+ * driver and can be used.
+ *
+ * Return:
+ * *        0 on success
+ * *        -EINVAL on wrong parameters
+ * *        -EPERM key already programmed
+ * *        -EOPNOTSUPP if device doesn't support the requested operation
+ * *        < 0 if the operation fails
+ */
+int rpmb_program_key(struct rpmb_dev *rdev, int klen, u8 *key, int rlen, u8 *resp)
+{
+	int err;
+
+	if (!rdev || !key)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	err = -EOPNOTSUPP;
+	if (rdev->ops && rdev->ops->program_key) {
+		err = rdev->ops->program_key(rdev->dev.parent, rdev->target,
+					     klen, key, rlen, resp);
+	}
+	mutex_unlock(&rdev->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rpmb_program_key);
+
+/**
+ * rpmb_get_capacity() - returns the capacity of the rpmb device
+ * @rdev: rpmb device
+ *
+ * Return:
+ * *        capacity of the device in units of 128K, on success
+ * *        -EINVAL on wrong parameters
+ * *        -EOPNOTSUPP if device doesn't support the requested operation
+ * *        < 0 if the operation fails
+ */
+int rpmb_get_capacity(struct rpmb_dev *rdev)
+{
+	int err;
+
+	if (!rdev)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	err = -EOPNOTSUPP;
+	if (rdev->ops && rdev->ops->get_capacity)
+		err = rdev->ops->get_capacity(rdev->dev.parent, rdev->target);
+	mutex_unlock(&rdev->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rpmb_get_capacity);
+
+/**
+ * rpmb_get_write_counter() - returns the write counter of the rpmb device
+ * @rdev: rpmb device
+ * @len: size of request frame
+ * @request: request frame
+ * @rlen: size of response frame
+ * @resp: response frame
+ *
+ * Return:
+ * *        counter
+ * *        -EINVAL on wrong parameters
+ * *        -EOPNOTSUPP if device doesn't support the requested operation
+ * *        < 0 if the operation fails
+ */
+int rpmb_get_write_counter(struct rpmb_dev *rdev, int len, u8 *request, int rlen, u8 *resp)
+{
+	int err;
+
+	if (!rdev)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	err = -EOPNOTSUPP;
+	if (rdev->ops && rdev->ops->get_write_counter)
+		err = rdev->ops->get_write_counter(rdev->dev.parent, rdev->target,
+						 len, request, rlen, resp);
+	mutex_unlock(&rdev->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rpmb_get_write_counter);
+
+/**
+ * rpmb_write_blocks() - write data to RPMB device
+ * @rdev: rpmb device
+ * @addr: block address (index of first block - 256B blocks)
+ * @count: number of 256B blosks
+ * @data: pointer to data to program
+ *
+ * Write a series of blocks to the RPMB device.
+ *
+ * Return:
+ * *        0 on success
+ * *        -EINVAL on wrong parameters
+ * *        -EACCESS no key set
+ * *        -EOPNOTSUPP if device doesn't support the requested operation
+ * *        < 0 if the operation fails
+ */
+int rpmb_write_blocks(struct rpmb_dev *rdev, int len, u8 *request,
+		      int rlen, u8 *response)
+{
+	int err;
+
+	if (!rdev || !len || !request)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	err = -EOPNOTSUPP;
+	if (rdev->ops && rdev->ops->write_blocks) {
+		err = rdev->ops->write_blocks(rdev->dev.parent, rdev->target,
+					      len, request, rlen, response);
+	}
+	mutex_unlock(&rdev->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rpmb_write_blocks);
+
+/**
+ * rpmb_read_blocks() - read data from RPMB device
+ * @rdev: rpmb device
+ * @addr: block address (index of first block - 256B blocks)
+ * @count: number of 256B blocks
+ * @data: pointer to data to read
+ *
+ * Read a series of one or more blocks from the RPMB device.
+ *
+ * Return:
+ * *        0 on success
+ * *        -EINVAL on wrong parameters
+ * *        -EACCESS no key set
+ * *        -EOPNOTSUPP if device doesn't support the requested operation
+ * *        < 0 if the operation fails
+ */
+int rpmb_read_blocks(struct rpmb_dev *rdev, int addr, int count, int len, u8 *data)
+{
+	int err;
+
+	if (!rdev || !count || !data)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	err = -EOPNOTSUPP;
+	if (rdev->ops && rdev->ops->read_blocks) {
+		err = rdev->ops->read_blocks(rdev->dev.parent, rdev->target,
+					     addr, count, len, data);
+	}
+	mutex_unlock(&rdev->lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(rpmb_read_blocks);
+
+
+static void rpmb_dev_release(struct device *dev)
+{
+	struct rpmb_dev *rdev = to_rpmb_dev(dev);
+
+	ida_simple_remove(&rpmb_ida, rdev->id);
+	kfree(rdev);
+}
+
+struct class rpmb_class = {
+	.name = "rpmb",
+	.owner = THIS_MODULE,
+	.dev_release = rpmb_dev_release,
+};
+EXPORT_SYMBOL(rpmb_class);
+
+/**
+ * rpmb_dev_find_device() - return first matching rpmb device
+ * @data: data for the match function
+ * @match: the matching function
+ *
+ * Return: matching rpmb device or NULL on failure
+ */
+static
+struct rpmb_dev *rpmb_dev_find_device(const void *data,
+				      int (*match)(struct device *dev,
+						   const void *data))
+{
+	struct device *dev;
+
+	dev = class_find_device(&rpmb_class, NULL, data, match);
+
+	return dev ? to_rpmb_dev(dev) : NULL;
+}
+
+struct device_with_target {
+	const struct device *dev;
+	u8 target;
+};
+
+static int match_by_parent(struct device *dev, const void *data)
+{
+	const struct device_with_target *d = data;
+	struct rpmb_dev *rdev = to_rpmb_dev(dev);
+
+	return (d->dev && dev->parent == d->dev && rdev->target == d->target);
+}
+
+/**
+ * rpmb_dev_find_by_device() - retrieve rpmb device from the parent device
+ * @parent: parent device of the rpmb device
+ * @target: RPMB target/region within the physical device
+ *
+ * Return: NULL if there is no rpmb device associated with the parent device
+ */
+struct rpmb_dev *rpmb_dev_find_by_device(struct device *parent, u8 target)
+{
+	struct device_with_target t;
+
+	if (!parent)
+		return NULL;
+
+	t.dev = parent;
+	t.target = target;
+
+	return rpmb_dev_find_device(&t, match_by_parent);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_find_by_device);
+
+/**
+ * rpmb_dev_unregister() - unregister RPMB partition from the RPMB subsystem
+ * @rdev: the rpmb device to unregister
+ * Return:
+ * *        0 on success
+ * *        -EINVAL on wrong parameters
+ */
+int rpmb_dev_unregister(struct rpmb_dev *rdev)
+{
+	if (!rdev)
+		return -EINVAL;
+
+	mutex_lock(&rdev->lock);
+	rpmb_cdev_del(rdev);
+	device_del(&rdev->dev);
+	mutex_unlock(&rdev->lock);
+
+	rpmb_dev_put(rdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_unregister);
+
+/**
+ * rpmb_dev_unregister_by_device() - unregister RPMB partition
+ *     from the RPMB subsystem
+ * @dev: the parent device of the rpmb device
+ * @target: RPMB target/region within the physical device
+ * Return:
+ * *        0 on success
+ * *        -EINVAL on wrong parameters
+ * *        -ENODEV if a device cannot be find.
+ */
+int rpmb_dev_unregister_by_device(struct device *dev, u8 target)
+{
+	struct rpmb_dev *rdev;
+
+	if (!dev)
+		return -EINVAL;
+
+	rdev = rpmb_dev_find_by_device(dev, target);
+	if (!rdev) {
+		dev_warn(dev, "no disk found %s\n", dev_name(dev->parent));
+		return -ENODEV;
+	}
+
+	rpmb_dev_put(rdev);
+
+	return rpmb_dev_unregister(rdev);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_unregister_by_device);
+
+/**
+ * rpmb_dev_get_drvdata() - driver data getter
+ * @rdev: rpmb device
+ *
+ * Return: driver private data
+ */
+void *rpmb_dev_get_drvdata(const struct rpmb_dev *rdev)
+{
+	return dev_get_drvdata(&rdev->dev);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_get_drvdata);
+
+/**
+ * rpmb_dev_set_drvdata() - driver data setter
+ * @rdev: rpmb device
+ * @data: data to store
+ */
+void rpmb_dev_set_drvdata(struct rpmb_dev *rdev, void *data)
+{
+	dev_set_drvdata(&rdev->dev, data);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_set_drvdata);
+
+/**
+ * rpmb_dev_register - register RPMB partition with the RPMB subsystem
+ * @dev: storage device of the rpmb device
+ * @target: RPMB target/region within the physical device
+ * @ops: device specific operations
+ *
+ * Return: a pointer to rpmb device
+ */
+struct rpmb_dev *rpmb_dev_register(struct device *dev, u8 target,
+				   const struct rpmb_ops *ops)
+{
+	struct rpmb_dev *rdev;
+	int id;
+	int ret;
+
+	if (!dev || !ops)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->program_key)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->get_capacity)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->get_write_counter)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->write_blocks)
+		return ERR_PTR(-EINVAL);
+
+	if (!ops->read_blocks)
+		return ERR_PTR(-EINVAL);
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	id = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		ret = id;
+		goto exit;
+	}
+
+	mutex_init(&rdev->lock);
+	rdev->ops = ops;
+	rdev->id = id;
+	rdev->target = target;
+
+	dev_set_name(&rdev->dev, "rpmb%d", id);
+	rdev->dev.class = &rpmb_class;
+	rdev->dev.parent = dev;
+
+	rpmb_cdev_prepare(rdev);
+
+	ret = device_register(&rdev->dev);
+	if (ret)
+		goto exit;
+
+	rpmb_cdev_add(rdev);
+
+	dev_dbg(&rdev->dev, "registered device\n");
+
+	return rdev;
+
+exit:
+	if (id >= 0)
+		ida_simple_remove(&rpmb_ida, id);
+	kfree(rdev);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(rpmb_dev_register);
+
+static int __init rpmb_init(void)
+{
+	ida_init(&rpmb_ida);
+	class_register(&rpmb_class);
+	return rpmb_cdev_init();
+}
+
+static void __exit rpmb_exit(void)
+{
+	rpmb_cdev_exit();
+	class_unregister(&rpmb_class);
+	ida_destroy(&rpmb_ida);
+}
+
+subsys_initcall(rpmb_init);
+module_exit(rpmb_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("RPMB class");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
new file mode 100644
index 000000000000..0c9749cf064d
--- /dev/null
+++ b/include/linux/rpmb.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 */
+/*
+ * Copyright (C) 2015-2019 Intel Corp. All rights reserved
+ * Copyright (C) 2021-2022 Linaro Ltd
+ */
+#ifndef __RPMB_H__
+#define __RPMB_H__
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <uapi/linux/rpmb.h>
+#include <linux/kref.h>
+
+#define RPMB_API_VERSION 0x80000001
+
+/**
+ * struct rpmb_ops - RPMB ops to be implemented by underlying block device
+ *
+ * @program_key    : program device key (once only op).
+ * @get_capacity   : rpmb size in 128K units in for region/target.
+ * @get_write_count: return the device write counter
+ * @write_blocks   : write blocks to RPMB device
+ * @read_blocks    : read blocks from RPMB device
+ * @block_size     : block size in half sectors (1 == 256B)
+ * @wr_cnt_max     : maximal number of blocks that can be
+ *                   written in one access.
+ * @rd_cnt_max     : maximal number of blocks that can be
+ *                   read in one access.
+ * @dev_id         : unique device identifier
+ * @dev_id_len     : unique device identifier length
+ */
+struct rpmb_ops {
+	int (*program_key)(struct device *dev, u8 target,
+			   int keylen, u8 *key_frame,
+			   int rlen, u8 *resp);
+	int (*get_capacity)(struct device *dev, u8 target);
+	int (*get_write_count)(struct device *dev, u8 target,
+			       int len, u8 *requests,
+			       int rlen, u8 *resp);
+	int (*write_blocks)(struct device *dev, u8 target,
+			    int len, u8 *requests,
+			    int rlen, u8 *resp);
+	int (*read_blocks)(struct device *dev, u8 target,
+			   int addr, int count,
+			   int len, u8 *data);
+	u16 block_size;
+	u16 wr_cnt_max;
+	u16 rd_cnt_max;
+	const u8 *dev_id;
+	size_t dev_id_len;
+};
+
+/**
+ * struct rpmb_dev - device which can support RPMB partition
+ *
+ * @lock       : the device lock
+ * @dev        : device
+ * @id         : device id
+ * @target     : RPMB target/region within the physical device
+ * @cdev       : character dev
+ * @status     : device status
+ * @ops        : operation exported by rpmb
+ */
+struct rpmb_dev {
+	struct mutex lock; /* device serialization lock */
+	struct device dev;
+	int id;
+	u8 target;
+#ifdef CONFIG_RPMB_INTF_DEV
+	struct cdev cdev;
+	unsigned long status;
+#endif /* CONFIG_RPMB_INTF_DEV */
+	const struct rpmb_ops *ops;
+};
+
+#define to_rpmb_dev(x) container_of((x), struct rpmb_dev, dev)
+
+#if IS_ENABLED(CONFIG_RPMB)
+struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
+void rpmb_dev_put(struct rpmb_dev *rdev);
+struct rpmb_dev *rpmb_dev_find_by_device(struct device *parent, u8 target);
+struct rpmb_dev *rpmb_dev_get_by_type(u32 type);
+struct rpmb_dev *rpmb_dev_register(struct device *dev, u8 target,
+				   const struct rpmb_ops *ops);
+void *rpmb_dev_get_drvdata(const struct rpmb_dev *rdev);
+void rpmb_dev_set_drvdata(struct rpmb_dev *rdev, void *data);
+int rpmb_dev_unregister(struct rpmb_dev *rdev);
+int rpmb_dev_unregister_by_device(struct device *dev, u8 target);
+
+int rpmb_program_key(struct rpmb_dev *rdev,
+		     int klen, u8 *key, int rlen, u8 *resp);
+int rpmb_get_capacity(struct rpmb_dev *rdev);
+int rpmb_get_write_counter(struct rpmb_dev *rdev,
+			 int len, u8 *request, int rlen, u8 *resp);
+int rpmb_write_blocks(struct rpmb_dev *rdev,
+		      int len, u8 *request, int rlen, u8 *resp);
+int rpmb_read_blocks(struct rpmb_dev *rdev, int addr, int count, int len, u8 *data);
+
+#else
+static inline struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev)
+{
+	return NULL;
+}
+
+static inline void rpmb_dev_put(struct rpmb_dev *rdev) { }
+
+static inline struct rpmb_dev *rpmb_dev_find_by_device(struct device *parent,
+						       u8 target)
+{
+	return NULL;
+}
+
+static inline
+struct rpmb_dev *rpmb_dev_get_by_type(enum rpmb_type type)
+{
+	return NULL;
+}
+
+static inline void *rpmb_dev_get_drvdata(const struct rpmb_dev *rdev)
+{
+	return NULL;
+}
+
+static inline void rpmb_dev_set_drvdata(struct rpmb_dev *rdev, void *data)
+{
+}
+
+static inline struct rpmb_dev *
+rpmb_dev_register(struct device *dev, u8 target, const struct rpmb_ops *ops)
+{
+	return NULL;
+}
+
+static inline int rpmb_dev_unregister(struct rpmb_dev *dev)
+{
+	return 0;
+}
+
+static inline int rpmb_dev_unregister_by_device(struct device *dev, u8 target)
+{
+	return 0;
+}
+
+static inline int rpmb_program_key(struct rpmb_dev *rdev,
+				   int klen, u8 *key,
+				   int rlen, u8 *resp)
+{
+	return 0;
+}
+
+static inline int rpmb_set_key(struct rpmb_dev *rdev, u8 *key, int keylen);
+{
+	return 0;
+}
+
+static inline int rpmb_get_capacity(struct rpmb_dev *rdev)
+{
+	return 0;
+}
+
+static inline int rpmb_get_write_counter(struct rpmb_dev *rdev,
+				       int len, u8 *request, int rlen, u8 *resp)
+{
+	return 0;
+}
+
+static inline int rpmb_write_blocks(struct rpmb_dev *rdev,
+				    int len, u8 *request, int rlen, u8 *resp);
+{
+	return 0;
+}
+
+static inline int rpmb_read_blocks(struct rpmb_dev *rdev, int addr, int count,
+				   int len, u8 *data)
+{
+	return 0;
+}
+
+#endif /* CONFIG_RPMB */
+
+#endif /* __RPMB_H__ */
-- 
2.34.1

