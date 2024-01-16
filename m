Return-Path: <linux-kernel+bounces-26912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C5282E7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBB11C228EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769D125BF;
	Tue, 16 Jan 2024 01:49:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7BF111B0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rPYaJ-0000l1-8h; Tue, 16 Jan 2024 02:49:47 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rPYaI-0008V9-1k; Tue, 16 Jan 2024 02:49:46 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rPYaI-001Ipo-2n;
	Tue, 16 Jan 2024 02:49:45 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Tue, 16 Jan 2024 02:49:42 +0100
Subject: [PATCH 2/3] usb: gadget: legacy: add 9pfs multi gadget
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-ml-topic-u9p-v1-2-ad8c306f9a4e@pengutronix.de>
References: <20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de>
In-Reply-To: <20240116-ml-topic-u9p-v1-0-ad8c306f9a4e@pengutronix.de>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: v9fs@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9509;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=Xu6jhE/WKBDfZroRTls+7q0f0LPBQz+JPndm2l4PnmI=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBlpeC5YN8375TXaFRS2Zh/6M+xFr4mcr/zcDuAF
 m5uMeRl+9OJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZaXguQAKCRC/aVhE+XH0
 q0qeEACJaHVRsNJiBecygz2LA35PwtVSan7Op3Mx8Dgd7xOVjfdUBaL/3ejGQnIQ7oENHAWXS1i
 u09Ke/QPKXtxg2smvCsVlhvqSAgGaD1pSBw8b3efOUMmsRqhECh8Ywk9PZ6S1ALlNhScShOYL8Q
 GQy3LSDOCnXcr7gIpgKss8RSfWSGX5AIg5SGglYa8sY0wqSJ8RsRQLWffjfcd/CnTrbrZjZGXls
 IM/bJicMstrAaM8W8TchY7Vvh3mo+KHRNc4iTSlym+6k7SYgrIARmUdjNy6UYIh8uxdAvUxEi3h
 2M1TDzj6DTvQJ+G70EYN4JS2LE/Ztr5/tIJ6ZtZxfrLOV2WzP1sKnMDZd6H+9s7pGYawilHSeMh
 4fdI129wmmZTNCFcU7LV6YD8GYKP2/OCvoKNqYoS2o3r13mVfvgosChL33jZLW3D8Em6AGITi8Q
 pEAyFQXlff1z6i8yOgdS2rs/fqRFYfI+vZH2d6JkqDLh+FV8KKasCYxNtS5kVdi4YXcsOREGV89
 awPtNxC+tvGXymyrEFCvVMBIohsfboMcaPEgfdteFeCPh36AaznJNPu2CrBsHaqctPKpqQ+27hS
 zi9v9Pe0dWu0ruQtJNtT+T8w2YFC2ag2WJ+9JWtNSbI9xOHFwhWy94NU8W9AgDp1uQ2ERTBXJux
 rXOKdZJ3ogPSDIQ==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add the newly introduced 9pfs transport gadget interface with an new
multi composed gadget together with acm and eem.

The usb forwarding can be started as follows:

Start the Network export via diod to localhost:

$ diod -f -n -d 0 -S -l 0.0.0.0:9999 -e $PWD

Start the python transport:

$ python p9_fwd.py

The gadget can then mount the exported filesystem:

$ mount -t 9p -o trans=usbg,aname=$PWD usb9pfs0 /mnt/9p

When using this legacy module, it is also possible to
mount the 9PFS usb dir as root filesystem. The kernel
commandline looks like this:

root=usb9pfs0 rootfstype=9p rootflags=trans=usbg,cache=loose,uname=root,access=0,dfltuid=0,dfltgid=0,aname=/path/to/rootfs

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/legacy/9pfs.c   | 260 +++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/legacy/Kconfig  |  15 +++
 drivers/usb/gadget/legacy/Makefile |   2 +
 3 files changed, 277 insertions(+)

diff --git a/drivers/usb/gadget/legacy/9pfs.c b/drivers/usb/gadget/legacy/9pfs.c
new file mode 100644
index 0000000000000..e38fc89c89ded
--- /dev/null
+++ b/drivers/usb/gadget/legacy/9pfs.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * usb9pfs.c -- Gadget usb9pfs
+ *
+ * Copyright (C) 2023 Michael Grzeschik
+ */
+
+/*
+ * Gadget usb9pfs only needs two bulk endpoints, and will use the usb9pfs usb
+ * transport to mount host filesystem via usb gadget.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/usb/composite.h>
+#include <linux/netdevice.h>
+
+#include "u_eem.h"
+#include "u_ether.h"
+
+/*-------------------------------------------------------------------------*/
+USB_GADGET_COMPOSITE_OPTIONS();
+
+USB_ETHERNET_MODULE_PARAMETERS();
+
+/* Defines */
+
+#define DRIVER_VERSION_STR "v1.0"
+#define DRIVER_VERSION_NUM 0x1000
+
+#define DRIVER_DESC	"Composite Gadget (9P + ACM + NCM)"
+
+/*-------------------------------------------------------------------------*/
+
+#define DRIVER_VENDOR_NUM	0x1d6b		/* Linux Foundation */
+#define DRIVER_PRODUCT_NUM	0x0109		/* Linux-USB 9PFS Gadget */
+
+/*-------------------------------------------------------------------------*/
+
+static struct usb_device_descriptor device_desc = {
+	.bLength =		sizeof(device_desc),
+	.bDescriptorType =	USB_DT_DEVICE,
+
+	/* .bcdUSB = DYNAMIC */
+
+	.bDeviceClass =		USB_CLASS_MISC,
+	.bDeviceSubClass =	2,
+	.bDeviceProtocol =	1,
+
+	/* .bMaxPacketSize0 = f(hardware) */
+
+	/* Vendor and product id can be overridden by module parameters.  */
+	.idVendor =		cpu_to_le16(DRIVER_VENDOR_NUM),
+	.idProduct =		cpu_to_le16(DRIVER_PRODUCT_NUM),
+	/* .bcdDevice = f(hardware) */
+	/* .iManufacturer = DYNAMIC */
+	/* .iProduct = DYNAMIC */
+	/* NO SERIAL NUMBER */
+	/*.bNumConfigurations =	DYNAMIC*/
+};
+
+static const struct usb_descriptor_header *otg_desc[2];
+
+static struct usb_string strings_dev[] = {
+	[USB_GADGET_MANUFACTURER_IDX].s = "",
+	[USB_GADGET_PRODUCT_IDX].s = DRIVER_DESC,
+	[USB_GADGET_SERIAL_IDX].s = "",
+	{  }			/* end of list */
+};
+
+static struct usb_gadget_strings stringtab_dev = {
+	.language	= 0x0409,	/* en-us */
+	.strings	= strings_dev,
+};
+
+static struct usb_gadget_strings *dev_strings[] = {
+	&stringtab_dev,
+	NULL,
+};
+
+static struct usb_configuration cdc_driver_conf = {
+	.label          = DRIVER_DESC,
+	.bConfigurationValue = 1,
+	/* .iConfiguration = DYNAMIC */
+	.bmAttributes   = USB_CONFIG_ATT_SELFPOWER,
+};
+
+static struct usb_function *f_9pfs;
+static struct usb_function_instance *fi_9pfs;
+
+static struct usb_function *f_acm;
+static struct usb_function_instance *fi_acm;
+
+static struct usb_function *f_eem;
+static struct usb_function_instance *fi_eem;
+
+static int cdc_do_config(struct usb_configuration *c)
+{
+	int ret;
+
+	if (gadget_is_otg(c->cdev->gadget)) {
+		c->descriptors = otg_desc;
+		c->bmAttributes |= USB_CONFIG_ATT_WAKEUP;
+	}
+
+	f_9pfs = usb_get_function(fi_9pfs);
+	if (IS_ERR(f_9pfs))
+		return PTR_ERR(f_9pfs);
+
+	ret = usb_add_function(c, f_9pfs);
+	if (ret < 0)
+		goto err_func_9pfs;
+
+	f_acm = usb_get_function(fi_acm);
+	if (IS_ERR(f_acm)) {
+		ret = PTR_ERR(f_acm);
+		goto err_func_acm;
+	}
+
+	ret = usb_add_function(c, f_acm);
+	if (ret)
+		goto err_conf;
+
+	f_eem = usb_get_function(fi_eem);
+	if (IS_ERR(f_eem)) {
+		ret = PTR_ERR(f_eem);
+		goto err_eem;
+	}
+
+	ret = usb_add_function(c, f_eem);
+	if (ret)
+		goto err_run;
+
+	return 0;
+err_run:
+	usb_put_function(f_eem);
+err_eem:
+	usb_remove_function(c, f_acm);
+err_conf:
+	usb_put_function(f_acm);
+err_func_acm:
+	usb_remove_function(c, f_9pfs);
+err_func_9pfs:
+	usb_put_function(f_9pfs);
+	return ret;
+}
+
+static int usb9pfs_bind(struct usb_composite_dev *cdev)
+{
+	struct f_eem_opts	*eem_opts = NULL;
+	int status;
+
+	fi_9pfs = usb_get_function_instance("usb9pfs");
+	if (IS_ERR(fi_9pfs))
+		return PTR_ERR(fi_9pfs);
+
+	/* set up serial link layer */
+	fi_acm = usb_get_function_instance("acm");
+	if (IS_ERR(fi_acm)) {
+		status = PTR_ERR(fi_acm);
+		goto err_conf_acm;
+	}
+
+	fi_eem = usb_get_function_instance("eem");
+	if (IS_ERR(fi_eem)) {
+		status = PTR_ERR(fi_eem);
+		goto err_conf_eem;
+	}
+
+	eem_opts = container_of(fi_eem, struct f_eem_opts, func_inst);
+
+	gether_set_qmult(eem_opts->net, qmult);
+	if (!gether_set_host_addr(eem_opts->net, host_addr))
+		pr_info("using host ethernet address: %s", host_addr);
+	if (!gether_set_dev_addr(eem_opts->net, dev_addr))
+		pr_info("using self ethernet address: %s", dev_addr);
+
+	/* Allocate string descriptor numbers ... note that string
+	 * contents can be overridden by the composite_dev glue.
+	 */
+	status = usb_string_ids_tab(cdev, strings_dev);
+	if (status < 0)
+		return status;
+
+	device_desc.iManufacturer = strings_dev[USB_GADGET_MANUFACTURER_IDX].id;
+	device_desc.iProduct = strings_dev[USB_GADGET_PRODUCT_IDX].id;
+	device_desc.iSerialNumber = strings_dev[USB_GADGET_SERIAL_IDX].id;
+
+	/* support OTG systems */
+	if (gadget_is_otg(cdev->gadget)) {
+		if (!otg_desc[0]) {
+			struct usb_descriptor_header *usb_desc;
+
+			usb_desc = usb_otg_descriptor_alloc(cdev->gadget);
+			if (!usb_desc) {
+				status = -ENOMEM;
+				goto err_conf_otg;
+			}
+			usb_otg_descriptor_init(cdev->gadget, usb_desc);
+			otg_desc[0] = usb_desc;
+			otg_desc[1] = NULL;
+		}
+	}
+
+	status = usb_add_config(cdev, &cdc_driver_conf, cdc_do_config);
+	if (status)
+		goto err_free_otg_desc;
+
+	usb_ep_autoconfig_reset(cdev->gadget);
+	usb_composite_overwrite_options(cdev, &coverwrite);
+
+	dev_info(&cdev->gadget->dev, DRIVER_DESC " version: " DRIVER_VERSION_STR "\n");
+
+	return 0;
+
+err_free_otg_desc:
+	kfree(otg_desc[0]);
+	otg_desc[0] = NULL;
+err_conf_otg:
+	usb_put_function_instance(fi_eem);
+err_conf_eem:
+	usb_put_function_instance(fi_acm);
+err_conf_acm:
+	usb_put_function_instance(fi_9pfs);
+	return status;
+}
+
+static int usb9pfs_unbind(struct usb_composite_dev *cdev)
+{
+	if (!IS_ERR_OR_NULL(f_eem))
+		usb_put_function(f_eem);
+	usb_put_function_instance(fi_eem);
+	if (!IS_ERR_OR_NULL(f_acm))
+		usb_put_function(f_acm);
+	usb_put_function_instance(fi_acm);
+	if (!IS_ERR_OR_NULL(f_9pfs))
+		usb_put_function(f_9pfs);
+	usb_put_function_instance(fi_9pfs);
+	kfree(otg_desc[0]);
+	otg_desc[0] = NULL;
+
+	return 0;
+}
+
+static struct usb_composite_driver usb9pfs_driver = {
+	.name		= "usb9pfs",
+	.dev		= &device_desc,
+	.strings	= dev_strings,
+	.max_speed	= USB_SPEED_SUPER,
+	.bind		= usb9pfs_bind,
+	.unbind		= usb9pfs_unbind,
+};
+
+module_usb_composite_driver(usb9pfs_driver);
+
+MODULE_AUTHOR("Michael Grzeschik");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/gadget/legacy/Kconfig b/drivers/usb/gadget/legacy/Kconfig
index 0a7b382fbe27c..8569aecc1487b 100644
--- a/drivers/usb/gadget/legacy/Kconfig
+++ b/drivers/usb/gadget/legacy/Kconfig
@@ -62,6 +62,21 @@ config USB_ZERO
 	  Say "y" to link the driver statically, or "m" to build a
 	  dynamically linked module called "g_zero".
 
+config USB_9PFS
+	tristate "Gadget 9PFS"
+	select USB_LIBCOMPOSITE
+	select USB_U_SERIAL
+	select USB_U_ETHER
+	select USB_F_ACM
+	select USB_F_EEM
+	select USB_F_9PFS
+	select NET_9P
+	help
+	  9PFS Transport Layer
+
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "g_9pfs".
+
 config USB_ZERO_HNPTEST
 	bool "HNP Test Device"
 	depends on USB_ZERO && USB_OTG
diff --git a/drivers/usb/gadget/legacy/Makefile b/drivers/usb/gadget/legacy/Makefile
index 4d864bf82799d..99c098800d898 100644
--- a/drivers/usb/gadget/legacy/Makefile
+++ b/drivers/usb/gadget/legacy/Makefile
@@ -8,6 +8,7 @@ ccflags-y			+= -I$(srctree)/drivers/usb/gadget/udc/
 ccflags-y			+= -I$(srctree)/drivers/usb/gadget/function/
 
 g_zero-y			:= zero.o
+g_9pfs-y			:= 9pfs.o
 g_audio-y			:= audio.o
 g_ether-y			:= ether.o
 g_serial-y			:= serial.o
@@ -26,6 +27,7 @@ g_acm_ms-y			:= acm_ms.o
 g_tcm_usb_gadget-y		:= tcm_usb_gadget.o
 
 obj-$(CONFIG_USB_ZERO)		+= g_zero.o
+obj-$(CONFIG_USB_9PFS)		+= g_9pfs.o
 obj-$(CONFIG_USB_AUDIO)		+= g_audio.o
 obj-$(CONFIG_USB_ETH)		+= g_ether.o
 obj-$(CONFIG_USB_GADGETFS)	+= gadgetfs.o

-- 
2.39.2


