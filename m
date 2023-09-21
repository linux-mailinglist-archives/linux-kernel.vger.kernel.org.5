Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD077A96CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjIURED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjIURDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:03:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2134.outbound.protection.outlook.com [40.107.92.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E011736;
        Thu, 21 Sep 2023 10:02:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfQdZKXUso/LPoYNWWLoNu/16059cHzbBqZ5s+ir09maYF4TDGU4vlowuso8sP2q++iXE4r1cwf4i9zJKypxVZ49uEorukXo0sIw427lSYMekYiqHjB2SALBWq6VO0SVjoWiRCqKiHEAb0jjtnGOKTBtEdUBl+kUS3hjdLcUnZfvPEH6uHl537hQUM8AfWU/fz2HD2jbIdXadDhnJdGQ4b3Ejne4gXqKUSOk2lY7dUTnzLp/1R6XphgpBD/8a1N90TdVjs5XfBiDP15qDKGstE4ns8QKf09HEyRGxh/HI5iklKtk6d01HkUd+BEmTIG73TpLGXTz5FWoj9YcrHX+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFCSvvar8qcYQV+9Cnk9e3tXoEGjn7Kfra7vk24FIyg=;
 b=MQpr9WmTm/kEA1mvM4upWasFBNU6az0lNWp+Rle643Rch0r+q8SyebzJrYl0gZEok5Om9ryOGuuCNMaK8DiTyAXMnGNMMtnEpE9gYEgicQWWW2XmNYlmXZXHcy40FEX0W5Pje5CKgwQymQUO9l0Ha1ELBtRQ1rUL23zPkv9ign/RaVWEeIGAVi7CvrA0vIVqDaI3TP0mPRaydmV0txEmPiVnHn/5arBRnIEZ+2ISAegbah7xttj5SSbG9Ae8QjodgPiHJGEUNRywtybOI6DVdQIhCmKNYgS1B8SLUBFeXxZJcCb5thej7Y4jHRtJFw7u41I0HFxUJKQB70iavX7Lpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipt.br; dmarc=pass action=none header.from=ipt.br; dkim=pass
 header.d=ipt.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipt.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFCSvvar8qcYQV+9Cnk9e3tXoEGjn7Kfra7vk24FIyg=;
 b=RyUYbATucaxXN+ubdqk1OLXtSqOPJIjg1hp+iMwViJC4K68Cc3VLMGxpYahhJEa90bhptWSGvv0QzqQyrXbqzb2lFFPBhNn9FmVejHL5pP0tZTYbGRY3II3MeFaS5dIp5MiZql+yhJnvAWOmESxMD2fUHnkGZ3OsZYV9NG65odE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipt.br;
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1a4::6)
 by CPVP152MB4863.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Thu, 21 Sep
 2023 14:36:52 +0000
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::33a9:1d82:af5d:6419]) by CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::33a9:1d82:af5d:6419%6]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 14:36:52 +0000
From:   Fernando Eckhardt Valle <fevalle@ipt.br>
To:     hdegoede@redhat.com, mpearson-lenovo@squebb.ca, corbet@lwn.net,
        hmh@hmh.eng.br, markgross@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v4] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Date:   Thu, 21 Sep 2023 11:36:22 -0300
Message-Id: <20230921143622.72387-1-fevalle@ipt.br>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPXP152CA0015.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103::27)
 To CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPVP152MB5053:EE_|CPVP152MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a51a26-9f1e-4398-836a-08dbbab0321a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VQbKix4Xzk6KP5PDogl0GsZT1sj12FqGDCpnxsPr6fSEgZj086tjTQRgeEalDGirrl+yiLPqBavOPS1jD4nabTOQ1YdjK+ZJnsKERkt+PLiqAr3rj1JXH6EVu+MwmmOtSaxmZ4WmoLOsXIyjBWtSGNCGLY137/ELz8zd8+Vzmm+vpXkDKmIEhBWayMvFIzFZJkiTQ+WaA1yqhfHpUDwR94/sqfSpB2KuIDmEClkMWmggoYx3aQQzlDyA7JrCDGRE90XSY3rGO8t31SWBsH3WKXiaGk5GZaryn+jaOuqVIq7UblnBFHzf5M4X2vRhHjKXIOkvkjgafOf3kNhk/QWys8+KL2qGfX6D+nIAaJobFoPdAzRoSSe7Hkz5WdzeTi4Et/euK382MI6B+JzKTXYSOpLTd193cLinS6Wd0zF9y5stE2V0vzU9eIM4TCG/3hD/QHbLy7kTGG56g7eF7cTXINuh8xvJCH3tm0aofuUI1whzThnLqYnJ6CUsu1cAfWM/FHP66rawazw9VOj+I3Cuzr3ektCr2l9yk/4+hZC3I7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(136003)(346002)(396003)(186009)(1800799009)(451199024)(41320700001)(6666004)(52116002)(6506007)(66476007)(66946007)(66556008)(478600001)(966005)(6486002)(786003)(6512007)(41300700001)(8676002)(8936002)(36756003)(2616005)(5660300002)(1076003)(86362001)(316002)(2906002)(83380400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0UyBsWoi+8AlSqYbAnYwTVXaDnAtTZ8Ooj5BSlz/U2P0hhbwP5w2AFolynTQ?=
 =?us-ascii?Q?nNgDu4PW2Uc99o9c97XJV73p4TcP+XCMKqmPCpvQn0dkVVPWpbmlfq7lITNe?=
 =?us-ascii?Q?YQQGQ3B9aWWTagK4Hh+5h0HX8oyyl/oIh0GLaip5iBgqGBW32QwApBeN2INj?=
 =?us-ascii?Q?LEknBYWMl4e8f+FTMcMjmEQzfbwkubsB4TBQ/K4Lh8UJTTM8UIfKW1bQ4Wi0?=
 =?us-ascii?Q?65ceYJlgTU6CcJHSBGjZlU6D6IQwA/0LeFsm2UYYviGSW6UMjJoODGaV3l5p?=
 =?us-ascii?Q?m9A/lz28+B2cBiL5reB2Idz8DLbaollH6o+ZsdNaKNls3tzcdnXtChzk4WLH?=
 =?us-ascii?Q?+PMWqircrm9veHktPKAG4e0D0Wqa1Bw2wACTgpkQ2jeX7TJHYN2sRURNmGbX?=
 =?us-ascii?Q?lm4g4jlg4c445qjxnqSHkWVLHGJMD2DI+d3Ltqe9WtgKdOG+LQKEbVdgO6uH?=
 =?us-ascii?Q?wAwXyUXmF8OUlpUjcUICvgPEKy0/R84YEv7J9UVx4DXiQ2oI1JwQRj1/Vhq9?=
 =?us-ascii?Q?A0D908oTAMBuR3wRUFfQz8oJfnByJf5NfxcXceh9CbjnSXUTe/NTQBX8p0UB?=
 =?us-ascii?Q?PAMYVbf55xx/cqwstgOXVy08VMbd4EWbbQL/UP6u94KmPY457btptHZk0SSQ?=
 =?us-ascii?Q?b9ln4kRpncxpfskye4cosIH08TiFc4k4TvVO7fqw0685D6QQ1m+RRNqLoPPa?=
 =?us-ascii?Q?xXk9dLQAuVcwrvgXs8gdCS2onwcof/OX0vqN2yDwYJERvdiB+eVe5z48jcXH?=
 =?us-ascii?Q?EXjmBBecsn4TJP0BUOY9LkMcQ/BLH+8mzfZmyybgDhuq+Dougyz+vTAaXAWf?=
 =?us-ascii?Q?6Sr6ton6m/UC5/VFCnpNYxZZzYMIDM7laM2Wdsq4FcfE6c3hsFWAE4W7jKvl?=
 =?us-ascii?Q?0MPZ0iXwbns2jDb0QmBtQoA4PYbL/isu1V/12HzpEDV5gEpDH6g/2HcLtOu3?=
 =?us-ascii?Q?oKtV79b0yV6JRcz1KevotIlC/aRkuejnELaKpRofSdVTbLbTu/nwBjp7XeOo?=
 =?us-ascii?Q?I+RKcz5+fSU/AwE+tAW42Gxhz5HnREj8cC9iqegfcbrQFksEIC/ODAVphFS9?=
 =?us-ascii?Q?NB1TndTgvu03hwEjovGZSd91j5N9g52qCu+ysOEAR7yd70NBTfva68HocF8P?=
 =?us-ascii?Q?BpWWmSBloRcbRD4NHIQR6qpuUKuW5gBZFQzpoPlkXaIHtYJYK8hpcSfCEUxV?=
 =?us-ascii?Q?13eAdCG0l/5j+HOdKA90gqEnw1M6jbOsYzHJL8kRRfrn4Q9OILPioZRWfvkl?=
 =?us-ascii?Q?i3eyXz2mHFjsuT19/QxMiUiWLdWKfKnhBHP85K+8vMnyUimw7oQLtUmbspsS?=
 =?us-ascii?Q?XLdohEwbo8RWnFoKhvcZVxkgcZj9pQK3cPxxeS6I9cwbBW0KCKe089f8Naht?=
 =?us-ascii?Q?Wpv43qNCw4ZCQPOTVTVEp/VU/hyufQyYNJ+MFW39aSe2m3d9eP0aBAeQNXIp?=
 =?us-ascii?Q?kBx47nVXxDlp224fPLl/WWO9giTvK5CUJUzJyWZ9UD0j9uO1nCfrJTBxamZ3?=
 =?us-ascii?Q?VXfKT8OPplne9wgxbNAmELuZlB5sng/uWZktEhFi2ThaX+leyZoTSXiV53eL?=
 =?us-ascii?Q?hC0Vnn1zlNhc/TGe+b34Yy9Kd2Yeq/om3snTPyIbtrolRKgrGK3LK1o9SxDm?=
 =?us-ascii?Q?5tjKPSy1EoQHTh6ARmP1VSok6gwa68+UBiwHQuFg+pOc?=
X-OriginatorOrg: ipt.br
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a51a26-9f1e-4398-836a-08dbbab0321a
X-MS-Exchange-CrossTenant-AuthSource: CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 14:36:52.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aab57f47-5b85-4924-8047-691190100bd7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGRqukusScgEb3rwUkS06Sm8/EkCeIWYvzzeabZ09Bdat3uZjCFZlr3ixqib4TRz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPVP152MB4863
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
 drivers/platform/x86/thinkpad_acpi.c          | 79 +++++++++++++++++++
 2 files changed, 99 insertions(+)

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
index d70c89d32..f430cc9ed 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10785,6 +10785,80 @@ static struct ibm_struct dprc_driver_data = {
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
+		strscpy(auxmac, "unavailable", AUXMAC_LEN);
+		goto auxmacinvalid;
+	}
+
+	if (obj->string.pointer[AUXMAC_BEGIN_MARKER] != '#' ||
+	    obj->string.pointer[AUXMAC_END_MARKER] != '#') {
+		pr_info("Invalid header for MAC address pass-through.\n");
+		strscpy(auxmac, "unavailable", AUXMAC_LEN);
+		goto auxmacinvalid;
+	}
+
+	if (strncmp(obj->string.pointer + AUXMAC_START, "XXXXXXXXXXXX", AUXMAC_LEN) != 0)
+		strscpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_LEN + 1);
+	else
+		strscpy(auxmac, "disabled", AUXMAC_START);
+
+auxmacinvalid:
+	kfree(obj);
+	return 0;
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
+static struct attribute *auxmac_attributes[] = {
+	&dev_attr_auxmac.attr,
+	NULL
+};
+
+static const struct attribute_group auxmac_attr_group = {
+	.attrs = auxmac_attributes,
+};
+
 /* --------------------------------------------------------------------- */
 
 static struct attribute *tpacpi_driver_attributes[] = {
@@ -10843,6 +10917,7 @@ static const struct attribute_group *tpacpi_groups[] = {
 	&proxsensor_attr_group,
 	&kbdlang_attr_group,
 	&dprc_attr_group,
+	&auxmac_attr_group,
 	NULL,
 };
 
@@ -11414,6 +11489,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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

