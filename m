Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19BF7F2A18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjKUKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjKUKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:17:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF367125
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:17:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F7AAC433BF;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700561839;
        bh=/oSYl9flhPg0YBaXCGjLnSwfN1N7d5GTC2/31nLbnZE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=rmMxqQQubXghz6KJ7UnbtmlZySgbJ1w0ygmmUytVsASIMB89jnssl6O+KmcbiqySU
         i+ekLSuRo8zlV/ggc61WG1asB/6IiC/kZKJ6z5+mBxOcKKd8iztX5gsJrjnrMDNmh2
         ZqGhKgKRqP4R7BFwQ0Vo9xicXLfMzDW52Ot09jCSeeLWH9UF1iAoS49tBLOGDpMZba
         SXIxCblEK5VKfpb6XEE0c5VDzYt3fGbTmXGCTh6P7ubGImPPhK5yagYRyUQJPiXZ3i
         +mv1XoRQv8zNFAazzwHaq0c2EPqXLxYfPzcTYM5qEu0gBu/O+1QIPzV6oGJ7P88c1r
         864m0EfOwyz4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 38BD2C61D93;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
From:   Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date:   Tue, 21 Nov 2023 11:20:16 +0100
Subject: [PATCH 03/12] iio: add the IIO backend framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-dev-iio-backend-v1-3-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700562016; l=13626;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HcGNaoT+k8sdTWJ8i/Vb681dJIK2Fw5tfRlbp57sJyg=;
 b=iKnQgFUEOnzPYrctZAN21MreJUgdK98FQxaKQavEdeJkp1K7N3sRIuRaNn7XzGflQIiK5LN5D
 Oh4LJ2Hy+2YCoHBqoqjaHpWqDOQS1oIxJm+MZXr7FwH+Be4MxUI0jz1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nuno Sa <nuno.sa@analog.com>

This is a Framework to handle complex IIO aggregate devices.

The typical architecture is to have one device as the frontend device which
can be "linked" against one or multiple backend devices. All the IIO and
userspace interface is expected to be registers/managed by the frontend
device which will callback into the backends when needed (to get/set
some configuration that it does not directly control).

The basic framework interface is pretty simple:
 - Backends should register themselves with @devm_iio_backend_register()
 - Frontend devices should get backends with @devm_iio_backend_get()

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 MAINTAINERS                        |   7 +
 drivers/iio/Kconfig                |   5 +
 drivers/iio/Makefile               |   1 +
 drivers/iio/industrialio-backend.c | 302 +++++++++++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  58 +++++++
 5 files changed, 373 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c885d784dcb1..c20e288f23f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10163,6 +10163,13 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/rc/iguanair.c
 
+IIO BACKEND FRAMEWORK
+M:	Nuno Sa <nuno.sa@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/industrialio-backend.c
+F:	include/linux/iio/backend.h
+
 IIO DIGITAL POTENTIOMETER DAC
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 52eb46ef84c1..451671112f73 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -71,6 +71,11 @@ config IIO_TRIGGERED_EVENT
 	help
 	  Provides helper functions for setting up triggered events.
 
+config IIO_BACKEND
+	tristate
+	help
+	  Framework to handle complex IIO aggregate devices.
+
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
 source "drivers/iio/addac/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 9622347a1c1b..0ba0e1521ba4 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_IIO_GTS_HELPER) += industrialio-gts-helper.o
 obj-$(CONFIG_IIO_SW_DEVICE) += industrialio-sw-device.o
 obj-$(CONFIG_IIO_SW_TRIGGER) += industrialio-sw-trigger.o
 obj-$(CONFIG_IIO_TRIGGERED_EVENT) += industrialio-triggered-event.o
+obj-$(CONFIG_IIO_BACKEND) += industrialio-backend.o
 
 obj-y += accel/
 obj-y += adc/
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
new file mode 100644
index 000000000000..b11fcb2195c5
--- /dev/null
+++ b/drivers/iio/industrialio-backend.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Framework to handle complex IIO aggregate devices.
+ *
+ * The typical architecture is to have one device as the frontend device which
+ * can be "linked" against one or multiple backend devices. All the IIO and
+ * userspace interface is expected to be registers/managed by the frontend
+ * device which will callback into the backends when needed (to get/set some
+ * configuration that it does not directly control).
+ *
+ * The framework interface is pretty simple:
+ *   - Backends should register themselves with @devm_iio_backend_register()
+ *   - Frontend devices should get backends with @devm_iio_backend_get()
+ *
+ * Also to note that the primary target for this framework are converters like
+ * ADC/DACs so @iio_backend_ops will have some operations typical of converter
+ * devices. On top of that, this is "generic" for all IIO which means any kind
+ * of device can make use of the framework. That said, If the @iio_backend_ops
+ * struct begins to grow out of control, we can always refactor things so that
+ * the industrialio-backend.c is only left with the really generic stuff. Then,
+ * we can build on top of it depending on the needs.
+ *
+ * Copyright (C) 2023 Analog Devices Inc.
+ */
+#define pr_fmt(fmt) "iio-backend: " fmt
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/kref.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#include <linux/iio/backend.h>
+
+struct iio_backend {
+	struct list_head entry;
+	const struct iio_backend_ops *ops;
+	struct device *dev;
+	struct module *owner;
+	void *priv;
+	/*
+	 * mutex used to synchronize backend callback access with concurrent
+	 * calls to @iio_backend_unregister. The lock makes sure a device is
+	 * not unregistered while a callback is being run.
+	 */
+	struct mutex lock;
+	struct kref ref;
+};
+
+static LIST_HEAD(iio_back_list);
+static DEFINE_MUTEX(iio_back_lock);
+
+/*
+ * Helper macros to properly call backend ops. The main point for these macros
+ * is to properly lock the backend mutex on every call plus checking if the
+ * backend device is still around (by looking at the *ops pointer).
+ */
+#define iio_backend_op_call(back, op, args...) ({ \
+	struct iio_backend *__back = back; \
+	int __ret; \
+			\
+	guard(mutex)(&__back->lock); \
+	if (WARN_ON_ONCE(!__back->ops)) \
+		__ret = -ENODEV; \
+	else if (!__back->ops->op) \
+		__ret = -EOPNOTSUPP; \
+	else \
+		__ret = __back->ops->op(__back, ##args); \
+	\
+	__ret; \
+})
+
+#define iio_backend_void_op_call(back, op, args...) { \
+	struct iio_backend *__back = back; \
+						\
+	guard(mutex)(&__back->lock); \
+	WARN_ON_ONCE(!__back->ops); \
+		\
+	if (__back->ops && __back->ops->op) \
+		__back->ops->op(__back, ##args); \
+	\
+}
+
+/**
+ * iio_backend_chan_enable - Enable a backend channel.
+ * @back:	Backend device.
+ * @chan:	Channel number.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan)
+{
+	return iio_backend_op_call(back, chan_enable, chan);
+}
+EXPORT_SYMBOL_GPL(iio_backend_chan_enable);
+
+/**
+ * iio_backend_chan_disable - Disable a backend channel.
+ * @back:	Backend device.
+ * @chan:	Channel number.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan)
+{
+	return iio_backend_op_call(back, chan_disable, chan);
+}
+EXPORT_SYMBOL_GPL(iio_backend_chan_disable);
+
+/**
+ * iio_backend_chan_enable - Enable the backend.
+ * @back:	Backend device
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_enable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, enable);
+}
+EXPORT_SYMBOL_GPL(iio_backend_enable);
+
+/**
+ * iio_backend_disable - Disable the backend.
+ * @back:	Backend device
+ */
+void iio_backend_disable(struct iio_backend *back)
+{
+	iio_backend_void_op_call(back, disable);
+}
+EXPORT_SYMBOL_GPL(iio_backend_disable);
+
+/**
+ * iio_backend_data_format_set - Configure the channel data format
+ * @back:	Backend device
+ * @chan:	Channel number.
+ * @data:	Data format.
+ *
+ * Properly configure a channel with respect to the expected data format. A
+ * @struct iio_backend_data_fmt must be passed with the settings.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure
+ */
+int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
+				const struct iio_backend_data_fmt *data)
+{
+	if (!data || data->type >= IIO_BACKEND_DATA_TYPE_MAX)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, data_format_set, chan, data);
+}
+EXPORT_SYMBOL_GPL(iio_backend_data_format_set);
+
+static void iio_backend_free(struct kref *ref)
+{
+	struct iio_backend *back = container_of(ref, struct iio_backend, ref);
+
+	kfree(back);
+}
+
+static void iio_backend_release(void *arg)
+{
+	struct iio_backend *back = arg;
+
+	module_put(back->owner);
+	kref_put(&back->ref, iio_backend_free);
+}
+
+/**
+ * devm_iio_backend_get - Get a backend device
+ * @dev:	Device where to look for the backend.
+ * @name:	Backend name.
+ *
+ * Get's the backend associated with @dev.
+ *
+ * RETURNS:
+ * A backend pointer, negative error pointer otherwise.
+ */
+struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
+{
+	struct fwnode_handle *fwnode;
+	struct iio_backend *back;
+	int index = 0, ret;
+
+	if (name) {
+		index = device_property_match_string(dev, "io-backends-names",
+						     name);
+		if (index < 0)
+			return ERR_PTR(index);
+	}
+
+	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
+	if (IS_ERR(fwnode)) {
+		dev_err(dev, "Cannot get Firmware reference\n");
+		return ERR_CAST(fwnode);
+	}
+
+	guard(mutex)(&iio_back_lock);
+	list_for_each_entry(back, &iio_back_list, entry) {
+		struct device_link *link;
+
+		if (!device_match_fwnode(back->dev, fwnode))
+			continue;
+
+		fwnode_handle_put(fwnode);
+		kref_get(&back->ref);
+		if (!try_module_get(back->owner)) {
+			dev_err(dev, "Cannot get module reference\n");
+			return ERR_PTR(-ENODEV);
+		}
+
+		ret = devm_add_action_or_reset(dev, iio_backend_release, back);
+		if (ret)
+			return ERR_PTR(ret);
+
+		link = device_link_add(dev, back->dev,
+				       DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!link)
+			dev_warn(dev, "Could not link to supplier(%s)\n",
+				 dev_name(back->dev));
+
+		dev_dbg(dev, "Found backend(%s) device\n", dev_name(back->dev));
+		return back;
+	}
+
+	fwnode_handle_put(fwnode);
+	return ERR_PTR(-EPROBE_DEFER);
+}
+EXPORT_SYMBOL_GPL(devm_iio_backend_get);
+
+/**
+ * iio_backend_get_priv - Get driver private data
+ * @back	Backend device
+ */
+void *iio_backend_get_priv(const struct iio_backend *back)
+{
+	return back->priv;
+}
+EXPORT_SYMBOL_GPL(iio_backend_get_priv);
+
+static void iio_backend_unregister(void *arg)
+{
+	struct iio_backend *back = arg;
+
+	mutex_lock(&iio_back_lock);
+	list_del(&back->entry);
+	mutex_unlock(&iio_back_lock);
+
+	mutex_lock(&back->lock);
+	back->ops = NULL;
+	mutex_unlock(&back->lock);
+	kref_put(&back->ref, iio_backend_free);
+}
+
+/**
+ * devm_iio_backend_register - Register a new backend device
+ * @dev		Backend device being registered.
+ * @ops		Backend ops
+ * @priv	Device private data.
+ *
+ * @ops and @priv are both mandatory. Not providing them results in -EINVAL.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int devm_iio_backend_register(struct device *dev,
+			      const struct iio_backend_ops *ops, void *priv)
+{
+	struct iio_backend *back;
+
+	if (!ops || !priv) {
+		dev_err(dev, "No backend ops or private data given\n");
+		return -EINVAL;
+	}
+
+	back = kzalloc(sizeof(*back), GFP_KERNEL);
+	if (!back)
+		return -ENOMEM;
+
+	kref_init(&back->ref);
+	mutex_init(&back->lock);
+	back->ops = ops;
+	back->owner = dev->driver->owner;
+	back->dev = dev;
+	back->priv = priv;
+	mutex_lock(&iio_back_lock);
+	list_add(&back->entry, &iio_back_list);
+	mutex_unlock(&iio_back_lock);
+
+	return devm_add_action_or_reset(dev, iio_backend_unregister, back);
+}
+EXPORT_SYMBOL_GPL(devm_iio_backend_register);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Framework to handle complex IIO aggregate devices");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
new file mode 100644
index 000000000000..8ae6549b8246
--- /dev/null
+++ b/include/linux/iio/backend.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _IIO_BACKEND_H_
+#define _IIO_BACKEND_H_
+
+#include <linux/types.h>
+
+struct iio_backend;
+struct device;
+
+enum iio_backend_data_type {
+	IIO_BACKEND_TWOS_COMPLEMENT,
+	IIO_BACKEND_OFFSET_BINARY,
+	IIO_BACKEND_DATA_TYPE_MAX
+};
+
+/**
+ * struct iio_backend_data_fmt - Backend data format
+ * @type:		Data type.
+ * @sign_extend:	Bool to tell if the data is sign extended.
+ * @enable:		Enable/Disable the data format module. If disabled,
+ *			not formatting will happen.
+ */
+struct iio_backend_data_fmt {
+	enum iio_backend_data_type type;
+	bool sign_extend;
+	bool enable;
+};
+
+/**
+ * struct iio_backend_ops - operations structure for an iio_backend
+ * @enable:		Enable backend.
+ * @disable:		Disable backend.
+ * @chan_enable:	Enable one channel.
+ * @chan_disable:	Disable one channel.
+ * @data_format_set:	Configure the data format for a specific channel.
+ **/
+struct iio_backend_ops {
+	int (*enable)(struct iio_backend *back);
+	void (*disable)(struct iio_backend *back);
+	int (*chan_enable)(struct iio_backend *back, unsigned int chan);
+	int (*chan_disable)(struct iio_backend *back, unsigned int chan);
+	int (*data_format_set)(struct iio_backend *conv, unsigned int chan,
+			       const struct iio_backend_data_fmt *data);
+};
+
+int iio_backend_chan_disable(struct iio_backend *back, unsigned int chan);
+int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
+void iio_backend_disable(struct iio_backend *back);
+int iio_backend_enable(struct iio_backend *back);
+int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
+				const struct iio_backend_data_fmt *data);
+
+void *iio_backend_get_priv(const struct iio_backend *conv);
+struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
+int devm_iio_backend_register(struct device *dev,
+			      const struct iio_backend_ops *ops, void *priv);
+
+#endif

-- 
2.42.1

