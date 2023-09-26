Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9728F7AF4F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjIZUWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbjIZUWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:22:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2109.outbound.protection.outlook.com [40.107.93.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C1011D;
        Tue, 26 Sep 2023 13:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzbfrA9rSKoeMWBFry80AxEPtVlkA8r2P4PwHpZE1KFA9nm9qY6gCW8pt7J6ooc4YoClBXGarqu2333iHWUP3UuqFhDIr1SWej13u4unn8LL10k2xw9mXZ7Oh2eHiPV6KZDw5evbknpp0+v0H5iFxofBDO+oV0RpZ1k1l3ybu8l3JpmRgHcOkWUewjjcKgEm93W0AL3a9qeBBLLxzYim7tjwPbQ7Wd6Nq76If+JA+RGrKXJsIm41zySqnI5DwFl2JAgIfnz3LfmsJLRL0B3n7STMWWaJg9cI9PZrsO4CWvGS8lTFLYluiQS/JVi2Ceagdp7MpOnHdlMOaCUOZV3OSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2zLDXad2lfw0jP+BSyPpo8jTVHif7L6nO7a9qtQ26M=;
 b=YQyRLcIiUktLVP9Vm6+rWwDvDfYxD+pDvOdQy93BJgy3HcnmTPXPNvGo/xvcsIfwIqthmXPY7RB8aUBRdkB9Y+xo6c+hoyK0NFTCmWmwNhKV2lC+HFhv/sxT+sr7wcdHRMurBY0uZDjOPQQBjenE+jxjEkPGt5bDEcFy6x1yTVm7fJPMaiCv0X8a1XErfcBO/mkrWvowjD0qRlsWITPlCYaK3m/VwKwjACrgHDHe05yKBXos8XcaD/CyQcduWHSjYA6It4gsonNeA8fM3VGKiWpLxx/t76/4daCdi++3c5sf8Du+kRx0dr0soWLlbwTOAzMn0TiocKhuwCME9w1k9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipt.br; dmarc=pass action=none header.from=ipt.br; dkim=pass
 header.d=ipt.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipt.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2zLDXad2lfw0jP+BSyPpo8jTVHif7L6nO7a9qtQ26M=;
 b=f2oAgOZjqoHeJMZeSElOzOTZdWnDi0CA2jlVfzYfSLW8+IGaI4gFBaSxEf23r03e+9JSLe8infKh2i1iMRm53WbHS93uXoFRMP4eG1t3SwBDXnw1qmch7XM+BTWhxVeR8OqTLo5XXtkgfOY9W821cu68EWqN9n8OVWxCAT+7Yus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipt.br;
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1a4::6)
 by CPWP152MB4270.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:10b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 20:22:04 +0000
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::7a85:9362:f3e7:ad3]) by CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::7a85:9362:f3e7:ad3%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 20:22:04 +0000
From:   Fernando Eckhardt Valle <fevalle@ipt.br>
To:     ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        mpearson-lenovo@squebb.ca, corbet@lwn.net, hmh@hmh.eng.br,
        markgross@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Date:   Tue, 26 Sep 2023 17:21:44 -0300
Message-Id: <20230926202144.5906-1-fevalle@ipt.br>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP5P284CA0080.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:93::13) To CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:103:1a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPVP152MB5053:EE_|CPWP152MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 709985b3-2364-4a1f-6aba-08dbbece3f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1Rz8EyMjQqz1nRX0O+D84SOBR+yWU3waJvNmp0IALq0J2JEGmlU9uNZR1J2RSn7TavA90I3P9pzVVRQlbNPB3JOGIU7YZtIzPgMaYH9igr4JYbc/Qj0M6k6IdmeMXtL3L4FukhhFMELDyy+/0LEwZ/u8wFCHW6/7IHDQMCDZqf1XmNLksqoz04QWIEvvr7+uuXJpEEW9huCJnvXM2cD7aCtXhSZZVh7LsZRnDRFqO4LylSrfMFJOzxNDS0BBWhJ5mPCedacHMvxtCUC1KoBXj7WK3SAdU6FmDWV16kMSm0m7asUJWkfwwa+XYyR71uTFWG1xgKnM8IezqpFFv4ILr58RsVZkC3H0b/n4VfXncHJTv+ch3oT9H7wiOuS3m+xLP2QJHu59RuQzHREG2gWnhjmZSqxltuAehTnc8r01tL/DGGI+wuNvVg27VIHLZnzhz8yJcQ7eMunVnTA4qMHbR/AvkM5V92dm/IzTHeAatKwr8DsxbHiVMv/hM15sxGYcIRE7wVy5Badsly/KnrXcdCEV37FwxCpgRmyHiUcs3MjI84Lo5Y2aQ85iItYLhi/CUBFC81nV97S3Sd3Qb5kag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39850400004)(366004)(396003)(376002)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6666004)(6486002)(52116002)(6506007)(83380400001)(921005)(86362001)(41320700001)(38100700002)(36756003)(1076003)(2616005)(2906002)(8676002)(8936002)(41300700001)(7416002)(66556008)(786003)(66946007)(316002)(66476007)(5660300002)(966005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lVPtLVhCa4WQ/ZbeFZYhFDLdJgwRghk2xmd9gEqfI0j6zEaVaU8RfbZSjsRu?=
 =?us-ascii?Q?7PvVn9iOTmbplhae9zyE03L6BWDEpSeCzm1ePGqmWuLXK1m9p5nUcQ8vEsPc?=
 =?us-ascii?Q?Sd5BOba4R0U5BLqV4Ir8TPlcRSavfO9aP9BCo2Csp3RVZwm6KxBmZKQVkumv?=
 =?us-ascii?Q?+1BvRt0YWOdBSEESoPB9hlYXfZKwjdJS0PXOXwn+0gQEMpgISsghQ3QkmQ42?=
 =?us-ascii?Q?RHpgQhxuY3pPZH7vjbVwNsDqogfRqmLH+FvpUKcQZN/cszzrn8m9cms3Yp85?=
 =?us-ascii?Q?Aeyu9PaKlwpid7UguRWhjxpbGtdJlWfntplF+GkwPH8rDg5xs3XMT0ntpMjR?=
 =?us-ascii?Q?OgQEe7RcBrZK/TuuFL4nksWWJ3UJ9NdP/kf5dNRWO0m3PMkxARQVqRBOJ1cx?=
 =?us-ascii?Q?fs6fbDlHCA1TZJUyg64MdrxEbBCkj09X8EGXw5NRZpYR1z89A8BIqJqJx19F?=
 =?us-ascii?Q?NjZ2/mTPTMJjZ0rPOcUeI1C9KNGroU+E3H0av3LyqpyPYygRA0wHVQbElysm?=
 =?us-ascii?Q?4y8HNHeXquC/yqlLD+zk8QFFbAOdIZIiy1BTlOPKZ+fJB0arW+93S8KFM7CJ?=
 =?us-ascii?Q?Tn3cNs8olOBO/tmz4IR8nBM43jeB6gEKmhAWRvPIeAKvPLgrnhhpCGMKfNj3?=
 =?us-ascii?Q?iYhWAfaN2bC3a/+bf8vKHMQRHGRjKLndnl9B1Vluao0xUATs5E23mXDTydZ4?=
 =?us-ascii?Q?MmJit5alNtOmysL0yWDDnW1cF1MOKFPcUiQtBZj5A9C8oGj7csQraJRI5ywH?=
 =?us-ascii?Q?y6MTUTo0ExZ3FyuP3Fi40BmZRctX2eptZ8ZOGGvYlhX6HOPHPkqw1rUUaA8R?=
 =?us-ascii?Q?Jhyd1/cgMewnj24OQzIHWCfqSwQQXrlYm1sghoE3PBbwrSqg+ObrWSA9Mavx?=
 =?us-ascii?Q?cVioCJ0+ITKGKG2js5EgvNMORO44KoVMvT5Nx4IhWMumMA/HGMM3c3Uk/I6c?=
 =?us-ascii?Q?s5ZmdeZkvIhN9AXinP9TTU8mPo/wRHd+kGg13UtVsMc5EmmxMEBm1MNISuTe?=
 =?us-ascii?Q?ApLScTFujfcsrVFm8RUPqr36iRbqInp7+0IMGJbdC5oDolv3wR9eBaWUmDmL?=
 =?us-ascii?Q?XkCCy2K9YSCInbkrzyJ60wPJ1mAvzeLqSAEUIr/KSya8ZG2pRkt1dgupcQ/h?=
 =?us-ascii?Q?Cq07MfAb8WIwPUa1GLG819RqC4sqhZuTqpuxPQTbIxf902ZiaLQh9FGNDVno?=
 =?us-ascii?Q?X7GUh3bFIfdFjV8o9ecM0zwoXBfoJ1U7IrjmkurHTQVtXT3/c9DHGbS6eCla?=
 =?us-ascii?Q?Pm2YwVMJbtgm9+0A/7hFBJUkS62S+StYTs6PiPgXD8AE1L6JXxaZeTQeivR0?=
 =?us-ascii?Q?YWAjDMJhCbR1jXbRPhgfLrKwtXXW1Veq7dyvHM3lwmmrdjumcnPTpUrRk2KA?=
 =?us-ascii?Q?wx851lVEl7sdp0Ls4lqZvSijC+V5FxFQiDPQRRyJzz+pg9n9EyX5tEUZh8No?=
 =?us-ascii?Q?l1byC8cU1xbnZvDYBvkl2RrdFMFXsp6S31FSzjhR59o5B89q8L/Qqa6uwrrc?=
 =?us-ascii?Q?m+5iL5rA1xYUx19t6mkVBHIZhxnSdAxw6qzBcqdmzlNTVsLOhed51Tx4oGEo?=
 =?us-ascii?Q?FXEUwGlnwmPU+yOx9rYplHjiyYjrWxGqLc6oK81XGEMnP1Xhb1fcrBYORkXN?=
 =?us-ascii?Q?y9YeQhhJ2MyWXXK1jLjqlkBzwH/IV38FNVk8oWTjt0E3?=
X-OriginatorOrg: ipt.br
X-MS-Exchange-CrossTenant-Network-Message-Id: 709985b3-2364-4a1f-6aba-08dbbece3f9f
X-MS-Exchange-CrossTenant-AuthSource: CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 20:22:04.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aab57f47-5b85-4924-8047-691190100bd7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rELzkzwMakZaPpQb2wQCvYH+C5F06rPeQEFAciixg9oV28BvlphrcQ5LXgbmSOio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPWP152MB4270
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Thinkpads have a feature called MAC Address Pass-through.
This patch provides a sysfs interface that userspace can use
to get this auxiliary mac address.

Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
---
Changes in v6:
- New adjustment to the strcpy() offset.
- Added is_visible attribute.
Changes in v5:
- Repeated code deleted.
- Adjusted offset of a strscpy().
Changes in v4:
- strscpy() in all string copies.
Changes in v3:
- Added null terminator to auxmac string when copying auxiliary
mac address value.
Changes in v2:
- Added documentation.
- All handling of the auxmac value is done in the _init function.
---
 .../admin-guide/laptops/thinkpad-acpi.rst     | 20 +++++
 drivers/platform/x86/thinkpad_acpi.c          | 88 +++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
index e27a1c3f6..98d304010 100644
--- a/Documentation/admin-guide/laptops/thinkpad-acpi.rst
+++ b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
@@ -53,6 +53,7 @@ detailed description):
 	- Lap mode sensor
 	- Setting keyboard language
 	- WWAN Antenna type
+	- Auxmac
 
 A compatibility table by model and feature is maintained on the web
 site, http://ibm-acpi.sf.net/. I appreciate any success or failure
@@ -1511,6 +1512,25 @@ Currently 2 antenna types are supported as mentioned below:
 The property is read-only. If the platform doesn't have support the sysfs
 class is not created.
 
+Auxmac
+------
+
+sysfs: auxmac
+
+Some newer Thinkpads have a feature called MAC Address Pass-through. This
+feature is implemented by the system firmware to provide a system unique MAC,
+that can override a dock or USB ethernet dongle MAC, when connected to a
+network. This property enables user-space to easily determine the MAC address
+if the feature is enabled.
+
+The values of this auxiliary MAC are:
+
+        cat /sys/devices/platform/thinkpad_acpi/auxmac
+
+If the feature is disabled, the value will be 'disabled'.
+
+This property is read-only.
+
 Adaptive keyboard
 -----------------
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d70c89d32..9c19624a7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10785,6 +10785,89 @@ static struct ibm_struct dprc_driver_data = {
 	.name = "dprc",
 };
 
+/*
+ * Auxmac
+ *
+ * This auxiliary mac address is enabled in the bios through the
+ * MAC Address Pass-through feature. In most cases, there are three
+ * possibilities: Internal Mac, Second Mac, and disabled.
+ *
+ */
+
+#define AUXMAC_LEN 12
+#define AUXMAC_START 9
+#define AUXMAC_STRLEN 22
+#define AUXMAC_BEGIN_MARKER 8
+#define AUXMAC_END_MARKER 21
+
+static char auxmac[AUXMAC_LEN + 1];
+
+static int auxmac_init(struct ibm_init_struct *iibm)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+
+	status = acpi_evaluate_object(NULL, "\\MACA", NULL, &buffer);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	obj = buffer.pointer;
+
+	if (obj->type != ACPI_TYPE_STRING || obj->string.length != AUXMAC_STRLEN) {
+		pr_info("Invalid buffer for MAC address pass-through.\n");
+		goto auxmacinvalid;
+	}
+
+	if (obj->string.pointer[AUXMAC_BEGIN_MARKER] != '#' ||
+	    obj->string.pointer[AUXMAC_END_MARKER] != '#') {
+		pr_info("Invalid header for MAC address pass-through.\n");
+		goto auxmacinvalid;
+	}
+
+	if (strncmp(obj->string.pointer + AUXMAC_START, "XXXXXXXXXXXX", AUXMAC_LEN) != 0)
+		strscpy(auxmac, obj->string.pointer + AUXMAC_START, sizeof(auxmac));
+	else
+		strscpy(auxmac, "disabled", sizeof(auxmac));
+
+free:
+	kfree(obj);
+	return 0;
+
+auxmacinvalid:
+	strscpy(auxmac, "unavailable", sizeof(auxmac));
+	goto free;
+}
+
+static struct ibm_struct auxmac_data = {
+	.name = "auxmac",
+};
+
+static ssize_t auxmac_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	return sysfs_emit(buf, "%s\n", auxmac);
+}
+static DEVICE_ATTR_RO(auxmac);
+
+static umode_t auxmac_attr_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	return auxmac[0] == 0 ? 0 : attr->mode;
+}
+
+static struct attribute *auxmac_attributes[] = {
+	&dev_attr_auxmac.attr,
+	NULL
+};
+
+static const struct attribute_group auxmac_attr_group = {
+	.is_visible = auxmac_attr_is_visible,
+	.attrs = auxmac_attributes,
+};
+
 /* --------------------------------------------------------------------- */
 
 static struct attribute *tpacpi_driver_attributes[] = {
@@ -10843,6 +10926,7 @@ static const struct attribute_group *tpacpi_groups[] = {
 	&proxsensor_attr_group,
 	&kbdlang_attr_group,
 	&dprc_attr_group,
+	&auxmac_attr_group,
 	NULL,
 };
 
@@ -11414,6 +11498,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.init = tpacpi_dprc_init,
 		.data = &dprc_driver_data,
 	},
+	{
+		.init = auxmac_init,
+		.data = &auxmac_data,
+	},
 };
 
 static int __init set_ibm_param(const char *val, const struct kernel_param *kp)
-- 
2.25.1

