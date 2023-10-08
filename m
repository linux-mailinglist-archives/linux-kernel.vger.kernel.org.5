Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9747BCD7B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbjJHJWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjJHJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:22:22 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C16DAB;
        Sun,  8 Oct 2023 02:22:18 -0700 (PDT)
X-UUID: 949b143830a5436bab682c79ba3f840e-20231008
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:432d4775-cef0-4e0d-bf09-34630c82924a,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:432d4775-cef0-4e0d-bf09-34630c82924a,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:d40691f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:231008172207O5IEME2I,BulkQuantity:0,Recheck:0,SF:19|44|38|24|17|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 949b143830a5436bab682c79ba3f840e-20231008
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <aichao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1423811136; Sun, 08 Oct 2023 17:22:04 +0800
From:   Ai Chao <aichao@kylinos.cn>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Ai Chao <aichao@kylinos.cn>
Subject: [PATCH] platform/x86: support to store/show powermode for Inspur
Date:   Sun,  8 Oct 2023 17:21:49 +0800
Message-Id: <20231008092149.967239-1-aichao@kylinos.cn>
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

Support to store/show powermode for Inspur.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/platform/x86/Kconfig      |  11 ++
 drivers/platform/x86/Makefile     |   3 +
 drivers/platform/x86/inspur-wmi.c | 180 ++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)
 create mode 100644 drivers/platform/x86/inspur-wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2a1070543391..9e565ee01a9f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -988,6 +988,17 @@ config TOUCHSCREEN_DMI
 	  the OS-image for the device. This option supplies the missing info.
 	  Enable this for x86 tablets with Silead or Chipone touchscreens.
 
+config INSPUR_WMI
+	tristate "Inspur WMI hotkeys driver"
+	depends on ACPI_WMI
+	depends on INPUT
+	help
+	This driver provides support for Inspur WMI hotkeys.
+	It's support to store/show powermode.
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
index 000000000000..6c4d722e98dc
--- /dev/null
+++ b/drivers/platform/x86/inspur-wmi.c
@@ -0,0 +1,180 @@
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
+#define WMI_INSPUR_POWERMODE_EVENT_GUID "854FA5AC-58C7-451D-AAB1-57D6F4E6DDD4"
+#define WMI_INSPUR_POWERMODE_BIOS_GUID "596C31E3-332D-43C9-AEE9-585493284F5D"
+
+enum inspur_wmi_method_ids {
+	INSPUR_WMI_GET_POWERMODE = 0x02,
+	INSPUR_WMI_SET_POWERMODE = 0x03,
+};
+
+struct inspur_wmi_priv {
+	struct input_dev *idev;
+};
+
+static int inspur_wmi_perform_query(char *guid,
+		enum inspur_wmi_method_ids query_id,
+		void *buffer, size_t insize, size_t outsize)
+{
+	union acpi_object *obj;
+	int ret = 0;
+	u32 wmi_outsize;
+	struct acpi_buffer input = { insize, buffer};
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+
+	wmi_evaluate_method(guid, 0, query_id, &input, &output);
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
+	wmi_outsize = min_t(size_t, outsize, obj->buffer.length);
+	memcpy(buffer, obj->buffer.pointer, wmi_outsize);
+
+out_free:
+	kfree(obj);
+	return ret;
+}
+
+static ssize_t powermode_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	int ret, mode;
+
+	ret = kstrtoint(buf, 0, &mode);
+	if (ret)
+		return ret;
+
+	inspur_wmi_perform_query(WMI_INSPUR_POWERMODE_BIOS_GUID,
+			INSPUR_WMI_SET_POWERMODE,
+			&mode, sizeof(mode), sizeof(mode));
+
+	return count;
+}
+
+
+static ssize_t powermode_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	int mode = 0;
+	u8 ret;
+	u8 *ret_code;
+
+	inspur_wmi_perform_query(WMI_INSPUR_POWERMODE_BIOS_GUID,
+			INSPUR_WMI_GET_POWERMODE,
+			&mode, sizeof(mode), sizeof(mode));
+	/*
+	 *Byte [0]: Return code, 0x0 No error, 0x01 Error
+	 *Byte [1]: Power Mode
+	 */
+	ret_code = (u8 *)(&mode);
+	ret = ret_code[1];
+
+	return sprintf(buf, "%u\n", ret);
+}
+
+DEVICE_ATTR_RW(powermode);
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
+const struct attribute_group *inspur_wmi_groups[] = {
+	&inspur_wmi_group,
+	NULL,
+};
+
+static void inspur_wmi_notify(struct wmi_device *wdev,
+		union acpi_object *obj)
+{
+	//to do
+}
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
+	int err;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(struct inspur_wmi_priv),
+			GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&wdev->dev, priv);
+
+	err = inspur_wmi_input_setup(wdev);
+	return err;
+}
+
+static void inspur_wmi_remove(struct wmi_device *wdev)
+{
+	struct inspur_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+
+	input_unregister_device(priv->idev);
+}
+
+static const struct wmi_device_id inspur_wmi_id_table[] = {
+	{ .guid_string = WMI_INSPUR_POWERMODE_EVENT_GUID },
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
+	.notify = inspur_wmi_notify,
+	.remove = inspur_wmi_remove,
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

