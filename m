Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423007656B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjG0PEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjG0PEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:04:01 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E0F30DC;
        Thu, 27 Jul 2023 08:03:57 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RCa9bg025977;
        Thu, 27 Jul 2023 17:03:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=4QX9Z5N4IBM3jR26vAY1wmUBBclNiX7yJiB7oyvXpaY=;
 b=SbICJBKEE06AVt/6QZ8YwTym9UXq5fUHXrwtyuLUR9vrUJY5/oeyHOsTnDd2tXTGuN1Y
 vt9PJkAYOo/oH3ODcYtiy7KkvEN+Ddbsrsb5Ey2UVwTt289oy67QyGRDcmluBKuQcBrH
 aiSQN+42dRh65xy7lcIE4ibqP0ItFxqTcUTTaflRLKW2ut06Vq8tKGozQiZ/tHjfMLJU
 1pdAupouRV7+kLQytLSJsCDdqHcAtC6nMAfcnuSdlHwpL3GkhYZYEiV4GXuTDZ2Ozq7I
 DT8cSilKgi0q7fSm1ne81nRj/X+jnxLmkKEy1mwwlads0de6svtfW5x4H0Bui7w6weV1 1A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s3n7wtbr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:03:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5AE710002A;
        Thu, 27 Jul 2023 17:03:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CE3D3209BA0;
        Thu, 27 Jul 2023 17:03:36 +0200 (CEST)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 27 Jul
 2023 17:03:36 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [RFC v2 01/11] iio: introduce iio backend device
Date:   Thu, 27 Jul 2023 17:03:12 +0200
Message-ID: <20230727150324.1157933-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new device type in IIO framework.
This backend device does not compute channel attributes and does not expose
them through sysfs, as done typically in iio-rescale frontend device.
Instead, it allows to report information applying to channel
attributes through callbacks. These backend devices can be cascaded
to represent chained components.
An IIO device configured as a consumer of a backend device can compute
the channel attributes of the whole chain.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/Makefile               |   1 +
 drivers/iio/industrialio-backend.c | 107 +++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  56 +++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 drivers/iio/industrialio-backend.c
 create mode 100644 include/linux/iio/backend.h

diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 9622347a1c1b..9b59c6ab1738 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o industrialio-event.o inkern.o
+industrialio-$(CONFIG_IIO_BACKEND) += industrialio-backend.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 
diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
new file mode 100644
index 000000000000..7d0625889873
--- /dev/null
+++ b/drivers/iio/industrialio-backend.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/* The industrial I/O core, backend handling functions
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/property.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/backend.h>
+
+static DEFINE_IDA(iio_backend_ida);
+
+#define to_iio_backend(_device) container_of((_device), struct iio_backend, dev)
+
+static void iio_backend_release(struct device *device)
+{
+	struct iio_backend *backend = to_iio_backend(device);
+
+	kfree(backend->name);
+	kfree(backend);
+}
+
+static const struct device_type iio_backend_type = {
+	.release = iio_backend_release,
+	.name = "iio_backend_device",
+};
+
+struct iio_backend *iio_backend_alloc(struct device *parent)
+{
+	struct iio_backend *backend;
+
+	backend = devm_kzalloc(parent, sizeof(*backend), GFP_KERNEL);
+
+	backend->dev.parent = parent;
+	backend->dev.type = &iio_backend_type;
+	backend->dev.bus = &iio_bus_type;
+	device_initialize(&backend->dev);
+
+	return backend;
+};
+EXPORT_SYMBOL(iio_backend_alloc);
+
+void iio_backend_free(struct device *dev)
+{
+	if (dev)
+		put_device(dev);
+}
+EXPORT_SYMBOL(iio_backend_free);
+
+int iio_backend_register(struct iio_backend *backend)
+{
+	struct fwnode_handle *fwnode;
+	int id;
+
+	id = ida_alloc(&iio_backend_ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+	backend->id = id;
+
+	dev_set_name(&backend->dev, "backend%d", backend->id);
+
+	if (dev_fwnode(&backend->dev))
+		fwnode = dev_fwnode(&backend->dev);
+	else
+		fwnode = dev_fwnode(backend->dev.parent);
+	device_set_node(&backend->dev, fwnode);
+
+	return device_add(&backend->dev);
+};
+EXPORT_SYMBOL(iio_backend_register);
+
+void iio_backend_unregister(struct iio_backend *backend)
+{
+	device_del(&backend->dev);
+};
+EXPORT_SYMBOL(iio_backend_unregister);
+
+struct iio_backend *fwnode_iio_backend_get(struct fwnode_handle *fwnode, int index)
+{
+	struct iio_backend *backend;
+	struct fwnode_reference_args iiospec;
+	struct device *bdev;
+	int ret;
+
+	if (index < 0)
+		return ERR_PTR(-EINVAL);
+
+	ret = fwnode_property_get_reference_args(fwnode, "io-backends",
+						 "#io-backend-cells", 0,
+						 index, &iiospec);
+	if (ret)
+		return ERR_PTR(ret);
+
+	bdev = bus_find_device_by_fwnode(&iio_bus_type, iiospec.fwnode);
+	if (!bdev) {
+		fwnode_handle_put(iiospec.fwnode);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	backend = to_iio_backend(bdev);
+
+	fwnode_handle_put(iiospec.fwnode);
+
+	return backend;
+};
+EXPORT_SYMBOL(fwnode_iio_backend_get);
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
new file mode 100644
index 000000000000..d90d345a4625
--- /dev/null
+++ b/include/linux/iio/backend.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * The industrial I/O core, backend handling functions
+ *
+ * Author: Olivier Moysan <olivier.moysan@foss.st.com>.
+ */
+
+#ifndef _IIO_BACKEND_H_
+#define _IIO_BACKEND_H_
+#include <linux/iio/iio.h>
+
+struct iio_backend_ops;
+struct iio_backend;
+
+/**
+ * struct iio_backend_ops - operations structure for an iio_backend
+ * @enable:	switch on backend
+ * @disable:	switch off backend
+ * @read_raw:	read data from backend
+ **/
+struct iio_backend_ops {
+	int (*enable)(struct iio_backend *backend);
+	int (*disable)(struct iio_backend *backend);
+	int (*read_raw)(struct iio_backend *backend, int *val, int *val2, long mask);
+};
+
+/**
+ * truct iio_backend - industrial I/O backend device
+ * @ops:	operations structure
+ * @module:	owner of this driver module
+ * @id:		unique id number
+ * @name:	unique name
+ * @dev:	associated device
+ * @priv:	private data pointer
+ **/
+struct iio_backend {
+	const struct iio_backend_ops	*ops;
+	struct module			*owner;
+	int				id;
+	const char			*name;
+	struct device			dev;
+	struct list_head		list;
+	void				*priv;
+};
+
+struct iio_backend *iio_backend_alloc(struct device *parent);
+
+void iio_backend_free(struct device *dev);
+
+int iio_backend_register(struct iio_backend *backend);
+
+void iio_backend_unregister(struct iio_backend *backend);
+
+struct iio_backend *fwnode_iio_backend_get(struct fwnode_handle *fwnode, int index);
+
+#endif /* _IIO_BACKEND_H_ */
-- 
2.25.1

