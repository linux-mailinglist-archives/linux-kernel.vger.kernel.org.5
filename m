Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A217C927D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 05:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjJND3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 23:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJND3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 23:29:02 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9BFC0;
        Fri, 13 Oct 2023 20:28:58 -0700 (PDT)
X-UUID: bb6b3defdbf7419c90c7d3bc44c3da64-20231014
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c558d7f0-915c-41bc-b38f-8bca20620a3b,IP:5,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-35
X-CID-INFO: VERSION:1.1.32,REQID:c558d7f0-915c-41bc-b38f-8bca20620a3b,IP:5,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-35
X-CID-META: VersionHash:5f78ec9,CLOUDID:7cd51bc4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:231014112849SB64LA8R,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: bb6b3defdbf7419c90c7d3bc44c3da64-20231014
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <aichao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2130785070; Sat, 14 Oct 2023 11:28:47 +0800
From:   Ai Chao <aichao@kylinos.cn>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v2] platform/x86: support to store/show powermode value for Inspur
Date:   Sat, 14 Oct 2023 11:28:44 +0800
Message-Id: <20231014032844.3823198-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support to store/show powermode value for Inspur by WMI interface.
This driver provides support for Inspur WMI hotkeys. User used Fn+Q to
change the power mode. If desktop applications receive hotkey(Fn+Q)
event, then it get the currently power mode and change the power mode.
The desktop applications modify brightness and cpufreq based on
power mode.

change for v2
- Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.
- Add more explanation.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/platform/x86/Kconfig      |  14 ++
 drivers/platform/x86/Makefile     |   3 +
 drivers/platform/x86/inspur-wmi.c | 210 ++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/platform/x86/inspur-wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2a1070543391..fa2a4335c83d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -988,6 +988,20 @@ config TOUCHSCREEN_DMI
 	  the OS-image for the device. This option supplies the missing info.
 	  Enable this for x86 tablets with Silead or Chipone touchscreens.
 
+config INSPUR_WMI
+	tristate "Inspur WMI hotkeys driver"
+	depends on ACPI_WMI
+	depends on INPUT
+	help
+	This driver provides support for Inspur WMI hotkeys.
+	User used Fn+Q to change the power mode. If desktop applications
+	receive hotkeys(Fn+Q) event, then it get the currently power mode
+	and change the power mode. The desktop applications modify brightness
+	and cpufreq based on power mode.
+
+	To compile this driver as a module, choose M here: the module
+	will be called inspur-wmi.
+
 source "drivers/platform/x86/x86-android-tablets/Kconfig"
 
 config FW_ATTR_CLASS
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index b457de5abf7d..9285c252757e 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -98,6 +98,9 @@ obj-$(CONFIG_TOSHIBA_WMI)	+= toshiba-wmi.o
 # before toshiba_acpi initializes
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 
+# Inspur
+obj-$(CONFIG_INSPUR_WMI)	+= inspur-wmi.o
+
 # Laptop drivers
 obj-$(CONFIG_ACPI_CMPC)		+= classmate-laptop.o
 obj-$(CONFIG_COMPAL_LAPTOP)	+= compal-laptop.o
diff --git a/drivers/platform/x86/inspur-wmi.c b/drivers/platform/x86/inspur-wmi.c
new file mode 100644
index 000000000000..ef6cfd87f074
--- /dev/null
+++ b/drivers/platform/x86/inspur-wmi.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Inspur WMI hotkeys
+ *
+ *  Copyright (C) 2018	      Ai Chao <aichao@kylinos.cn>
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/wmi.h>
+
+#define WMI_INSPUR_POWERMODE_BIOS_GUID "596C31E3-332D-43C9-AEE9-585493284F5D"
+
+enum inspur_wmi_method_ids {
+	INSPUR_WMI_GET_POWERMODE = 0x02,
+	INSPUR_WMI_SET_POWERMODE = 0x03,
+};
+
+struct inspur_wmi_priv {
+	struct input_dev *idev;
+	struct wmi_device *wdev;
+};
+
+static int inspur_wmi_perform_query(struct wmi_device *wdev,
+				    enum inspur_wmi_method_ids query_id,
+				    void *buffer, size_t insize,
+				    size_t outsize)
+{
+	union acpi_object *obj;
+	acpi_status status;
+	int ret = 0;
+	struct acpi_buffer input = { insize, buffer};
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+
+	status = wmidev_evaluate_method(wdev, 0, query_id, &input, &output);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&wdev->dev, "EC Powermode control failed: %s\n",
+			acpi_format_exception(status));
+		return -EIO;
+	}
+
+	obj = output.pointer;
+	if (!obj)
+		return -EINVAL;
+
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	/* Ignore output data of zero size */
+	if (!outsize)
+		goto out_free;
+
+	if (obj->buffer.length != outsize) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	memcpy(buffer, obj->buffer.pointer, obj->buffer.length);
+
+out_free:
+	kfree(obj);
+	return ret;
+}
+
+/**
+ * Set Power Mode to EC RAM. If Power Mode value greater than 0x3,
+ * return error
+ * Method ID: 0x3
+ * Arg: 4 Bytes
+ * Byte [0]: Power Mode:
+ *         0x0: Balance Mode
+ *         0x1: Performance Mode
+ *         0x2: Power Saver Mode
+ * Return Value: 4 Bytes
+ * Byte [0]: Return Code
+ *         0x0: No Error
+ *         0x1: Error
+ */
+static ssize_t powermode_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
+	int ret;
+	u32 mode;
+	u8 *ret_code;
+
+	ret = kstrtoint(buf, 0, &mode);
+	if (ret)
+		return ret;
+
+	ret = inspur_wmi_perform_query(priv->wdev,
+				       INSPUR_WMI_SET_POWERMODE,
+				       &mode, sizeof(mode), sizeof(mode));
+
+	if (ret < 0)
+		return ret;
+
+	ret_code = (u8 *)(&mode);
+	if (ret_code[0])
+		return -EBADRQC;
+
+	return count;
+}
+
+/**
+ * Get Power Mode from EC RAM, If Power Mode value greater than 0x3,
+ * return error
+ * Method ID: 0x2
+ * Return Value: 4 Bytes
+ * Byte [0]: Return Code
+ *         0x0: No Error
+ *         0x1: Error
+ * Byte [1]: Power Mode
+ *         0x0: Balance Mode
+ *         0x1: Performance Mode
+ *         0x2: Power Saver Mode
+ */
+static ssize_t powermode_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct inspur_wmi_priv *priv = dev_get_drvdata(dev);
+	u32 mode = 0;
+	int ret;
+	u8 *ret_code;
+
+	ret = inspur_wmi_perform_query(priv->wdev,
+				       INSPUR_WMI_GET_POWERMODE,
+				       &mode, sizeof(mode), sizeof(mode));
+	if (ret < 0)
+		return ret;
+
+	ret_code = (u8 *)(&mode);
+	if (ret_code[0])
+		return -EBADRQC;
+
+	return sprintf(buf, "%u\n", ret_code[1]);
+}
+
+static DEVICE_ATTR_RW(powermode);
+
+static struct attribute *inspur_wmi_attrs[] = {
+	&dev_attr_powermode.attr,
+	NULL,
+};
+
+static const struct attribute_group inspur_wmi_group = {
+	.attrs = inspur_wmi_attrs,
+};
+
+static const struct attribute_group *inspur_wmi_groups[] = {
+	&inspur_wmi_group,
+	NULL,
+};
+
+static int inspur_wmi_input_setup(struct wmi_device *wdev)
+{
+	struct inspur_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+
+	priv->idev = devm_input_allocate_device(&wdev->dev);
+	if (!priv->idev)
+		return -ENOMEM;
+
+	priv->idev->name = "Inspur WMI hotkeys";
+	priv->idev->phys = "wmi/input0";
+	priv->idev->id.bustype = BUS_HOST;
+	priv->idev->dev.parent = &wdev->dev;
+
+	return input_register_device(priv->idev);
+}
+
+static int inspur_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct inspur_wmi_priv *priv;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->wdev = wdev;
+	dev_set_drvdata(&wdev->dev, priv);
+
+	return inspur_wmi_input_setup(wdev);
+}
+
+static const struct wmi_device_id inspur_wmi_id_table[] = {
+	{ .guid_string = WMI_INSPUR_POWERMODE_BIOS_GUID },
+	{  }
+};
+
+static struct wmi_driver inspur_wmi_driver = {
+	.driver = {
+		.name = "inspur-wmi",
+		.dev_groups = inspur_wmi_groups,
+	},
+	.id_table = inspur_wmi_id_table,
+	.probe = inspur_wmi_probe,
+};
+
+module_wmi_driver(inspur_wmi_driver);
+
+MODULE_DEVICE_TABLE(wmi, inspur_wmi_id_table);
+MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
+MODULE_DESCRIPTION("Inspur WMI hotkeys");
+MODULE_LICENSE("GPL");
-- 
2.25.1

