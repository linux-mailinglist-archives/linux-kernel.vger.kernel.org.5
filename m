Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B817CEE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjJSDGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjJSDF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:05:58 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE349F;
        Wed, 18 Oct 2023 20:05:55 -0700 (PDT)
X-UUID: 58ad13f757eb40448adcceab124fda2c-20231019
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:5ab4bded-b106-4a26-a538-407c74f03a00,IP:15,
        URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:20
X-CID-INFO: VERSION:1.1.32,REQID:5ab4bded-b106-4a26-a538-407c74f03a00,IP:15,UR
        L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:20
X-CID-META: VersionHash:5f78ec9,CLOUDID:b4a01ac0-14cc-44ca-b657-2d2783296e72,B
        ulkID:231019110546LRCLYHZO,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|17|1
        02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 58ad13f757eb40448adcceab124fda2c-20231019
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <aichao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 104807895; Thu, 19 Oct 2023 11:05:43 +0800
From:   Ai Chao <aichao@kylinos.cn>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v4] platform/x86: inspur-wmi: Add platform profile support
Date:   Thu, 19 Oct 2023 11:05:34 +0800
Message-Id: <20231019030534.157971-1-aichao@kylinos.cn>
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

Add support for Inspur platforms to used the platform profile feature.

This will allow users to determine and control the platform modes
between low-power, balanced and performance modes.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---

v4: Add select ACPI_PLATFORM_PROFILE
v3: Remove input device, using the platform profile interface
v2: Remove Event GUID, remove inspur_wmi_notify and inspur_wmi_notify.

 drivers/platform/x86/Kconfig      |  11 ++
 drivers/platform/x86/Makefile     |   3 +
 drivers/platform/x86/inspur-wmi.c | 216 ++++++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/platform/x86/inspur-wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2a1070543391..44f371876170 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -988,6 +988,17 @@ config TOUCHSCREEN_DMI
 	  the OS-image for the device. This option supplies the missing info.
 	  Enable this for x86 tablets with Silead or Chipone touchscreens.
 
+config INSPUR_WMI
+	tristate "Inspur WMI platform profile driver"
+	depends on ACPI_WMI
+	select ACPI_PLATFORM_PROFILE
+	help
+	This will allow users to determine and control the platform modes
+	between low-power, balanced and performance modes.
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
index 000000000000..243f31dd162c
--- /dev/null
+++ b/drivers/platform/x86/inspur-wmi.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Inspur WMI power mode
+ *
+ *  Copyright (C) 2018	      Ai Chao <aichao@kylinos.cn>
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_profile.h>
+#include <linux/wmi.h>
+
+#define WMI_INSPUR_POWERMODE_BIOS_GUID "596C31E3-332D-43C9-AEE9-585493284F5D"
+
+enum inspur_wmi_method_ids {
+	INSPUR_WMI_GET_POWERMODE = 0x02,
+	INSPUR_WMI_SET_POWERMODE = 0x03,
+};
+
+/**
+ * Power Mode:
+ *           0x0: Balance Mode
+ *           0x1: Performance Mode
+ *           0x2: Power Saver Mode
+ */
+enum inspur_tmp_profile {
+	INSPUR_TMP_PROFILE_BALANCE	= 0,
+	INSPUR_TMP_PROFILE_PERFORMANCE	= 1,
+	INSPUR_TMP_PROFILE_POWERSAVE	= 2,
+};
+
+struct inspur_wmi_priv {
+	struct wmi_device *wdev;
+	struct platform_profile_handler handler;
+};
+
+static int inspur_wmi_perform_query(struct wmi_device *wdev,
+				    enum inspur_wmi_method_ids query_id,
+				    void *buffer, size_t insize,
+				    size_t outsize)
+{
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer input = { insize, buffer};
+	union acpi_object *obj;
+	acpi_status status;
+	int ret = 0;
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
+	if (obj->type != ACPI_TYPE_BUFFER ||
+	    obj->buffer.length != outsize) {
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
+static int inspur_platform_profile_set(struct platform_profile_handler *pprof,
+				       enum platform_profile_option profile)
+{
+	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
+						    handler);
+	u8 ret_code[4] = {0, 0, 0, 0};
+	int ret;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_BALANCED:
+		ret_code[0] = INSPUR_TMP_PROFILE_BALANCE;
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		ret_code[0] = INSPUR_TMP_PROFILE_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_LOW_POWER:
+		ret_code[0] = INSPUR_TMP_PROFILE_POWERSAVE;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = inspur_wmi_perform_query(priv->wdev, INSPUR_WMI_SET_POWERMODE,
+				       ret_code, sizeof(ret_code),
+				       sizeof(ret_code));
+
+	if (ret < 0)
+		return ret;
+
+	if (ret_code[0])
+		return -EBADRQC;
+
+	return 0;
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
+static int inspur_platform_profile_get(struct platform_profile_handler *pprof,
+				       enum platform_profile_option *profile)
+{
+	struct inspur_wmi_priv *priv = container_of(pprof, struct inspur_wmi_priv,
+						    handler);
+	u8 ret_code[4] = {0, 0, 0, 0};
+	int ret;
+
+	ret = inspur_wmi_perform_query(priv->wdev, INSPUR_WMI_GET_POWERMODE,
+				       &ret_code, sizeof(ret_code),
+				       sizeof(ret_code));
+	if (ret < 0)
+		return ret;
+
+	if (ret_code[0])
+		return -EBADRQC;
+
+	switch (ret_code[1]) {
+	case INSPUR_TMP_PROFILE_BALANCE:
+		*profile = PLATFORM_PROFILE_BALANCED;
+		break;
+	case INSPUR_TMP_PROFILE_PERFORMANCE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		break;
+	case INSPUR_TMP_PROFILE_POWERSAVE:
+		*profile = PLATFORM_PROFILE_LOW_POWER;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
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
+	priv->handler.profile_get = inspur_platform_profile_get;
+	priv->handler.profile_set = inspur_platform_profile_set;
+
+	set_bit(PLATFORM_PROFILE_LOW_POWER, priv->handler.choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, priv->handler.choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->handler.choices);
+
+	return platform_profile_register(&priv->handler);
+}
+
+static void inspur_wmi_remove(struct wmi_device *wdev)
+{
+	platform_profile_remove();
+}
+
+static const struct wmi_device_id inspur_wmi_id_table[] = {
+	{ .guid_string = WMI_INSPUR_POWERMODE_BIOS_GUID },
+	{  }
+};
+
+MODULE_DEVICE_TABLE(wmi, inspur_wmi_id_table);
+
+static struct wmi_driver inspur_wmi_driver = {
+	.driver = {
+		.name = "inspur-wmi",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table = inspur_wmi_id_table,
+	.probe = inspur_wmi_probe,
+	.remove = inspur_wmi_remove,
+};
+
+module_wmi_driver(inspur_wmi_driver);
+
+MODULE_AUTHOR("Ai Chao <aichao@kylinos.cn>");
+MODULE_DESCRIPTION("Inspur WMI Platform Profile");
+MODULE_LICENSE("GPL");
-- 
2.25.1

