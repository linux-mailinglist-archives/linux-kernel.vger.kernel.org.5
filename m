Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFE7ADF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjIYSm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjIYSmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:42:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2134.outbound.protection.outlook.com [40.107.244.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D55595;
        Mon, 25 Sep 2023 11:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAYhOYNmXtF+CwvIS6i9H0Hj8eoEyqWw1fZi4Wz+fp5YUikaF7ZcLjYUI0efCa7B0bgdP6YMioBrL4EUCTZsR9NXC/RxS7ijLzr5uVXvDlvqbJq5PFIy1eZx0JDs730USRsjtKfKp6szMEcu0P/h9u+Bsl2ZO5wTDyRA0qYfX3loOUj06kBWeUk9ivssF5tJ4HuAEfqhhOOQgohx3FVRtddBkf31g2ayFLW+4TxHpg3rPFeQyz590ttJ0uMIIDghqI+N5jVEgwbwNcV+0SLVUv1KEc9VxMAKzbxxvOC5pbMnWR7reBLOxLOUa2CCTXr+IZxbcanOHimzPurCHB7YeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aDJRdlWuHz+F7Mml48ESGQympOBtEKpcyOh4bdzkXA=;
 b=kU+/X28vLfel3MSKM868JZzUsjdJ9u716q2+cj2yQwuwXZDX0TgDlpy97Un5YHtzEBG6pjMeXaBamKfoerdZFrj9kd08DBu7xBnyalUJDV8k/BRwyp1UJFiMrDFq889K87av1YI7Bw95RLNPzzX3Sp0KxisVCeLBczOZ3oDfj2bg1nRj0oQ9gCbXCPQDc9/LzrB/aujAYXEixxUlZ1tbBhUIvvzBDzKKvS7VzZxSBO37seGB8R9TeghN3WfNAuGK1HXmrUJpdR+DHBnXhUIvN7eyrwkbI0I51U5seY7VI7fWlBnn+aVYFEgLOsNPjcjNoF4qE0AmE2ZxQc6XGQdG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipt.br; dmarc=pass action=none header.from=ipt.br; dkim=pass
 header.d=ipt.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipt.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aDJRdlWuHz+F7Mml48ESGQympOBtEKpcyOh4bdzkXA=;
 b=KcMwxlvX6kZyZJzw395Tn1uDrgKIiHSlcByjf/Uez8z1fxaSfV47Gp55DQwYrMPdVk8B9VZ9MY5AkM0kC9TJPi7P+P50J5BstWvnXBJ3/9gcQ0Fa3ApUqke4mjx+OUGEQjABEX96ZbNR937yVKFRlYxK5Xkq/ZnWE18KFWK5Bwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipt.br;
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1a4::6)
 by RO2P152MB4776.LAMP152.PROD.OUTLOOK.COM (2603:10d6:10:6f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Mon, 25 Sep 2023 18:42:11 +0000
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::7a85:9362:f3e7:ad3]) by CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::7a85:9362:f3e7:ad3%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 18:42:11 +0000
From:   Fernando Eckhardt Valle <fevalle@ipt.br>
To:     ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        mpearson-lenovo@squebb.ca, corbet@lwn.net, hmh@hmh.eng.br,
        markgross@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Date:   Mon, 25 Sep 2023 15:41:33 -0300
Message-Id: <20230925184133.6735-1-fevalle@ipt.br>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPYP284CA0045.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:81::14) To CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:103:1a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPVP152MB5053:EE_|RO2P152MB4776:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0786bb-0195-4315-be64-08dbbdf720d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkzsL4sv/Qze229UND8qh8nv07fOKhuQGx1NQ8LKIynJoxvQYz1eGooafoynZ3cxuzIHDYQP+b2nFdl4lFM0NUeb3mNpBvcrX4eiZx8UtJ8zc5AKr0bYV8r0pqkGrn/81KFnJ1/M+Qm3tpwWLWQDsh1FaoyZm4Wfso4n47MBACaojp6+LVGb1YelQa5dv4PWZyUPu3tkcqOuUjj78ACUDo8LpwqbgFZLxRY/GaE2XcENh+X6DkZ5sE7pMmNrLxCocALDxpPF1N+kUZaEI+VO9I1cFO3jd8VkjiYsruUe3Bi/cXmXTNWDtv6mzvKuceCagmMr3rCqC8tWLkjF46PBOB23DMsTPcmDtOvU/dZeIE1qhcRCcS5s2WSVkT9APBjF00tnQzO3ctmnbJiAjO1baTRGxk5G+pIz3IVnJppkjoAuqyRJcJui92UJhsWQ0haW798KlBUclC6Pa7bXdGcSYDsMVTSckYp5MTTeA93hvv7qMGUUt0V9Wx9PP6IXZsTD+om8gx7YxIOiDuPgeTxffUCi2emEWXu9GpmkyP4jvsnhk7aCMt/PwbHtNsxVBBCbwobikLIzhXO047JVJ13CRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(376002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(52116002)(83380400001)(921005)(86362001)(38100700002)(41320700001)(36756003)(1076003)(2616005)(2906002)(8936002)(8676002)(41300700001)(7416002)(66556008)(66946007)(316002)(786003)(66476007)(5660300002)(478600001)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oBYjt4i4clgI0FkVQhsCywU8Vd+/iXQYChWijX/CiBky8i386xS1tG5LIoY4?=
 =?us-ascii?Q?1BQYyFaOskHNrO90qn5ctpUxYIIL52wbAuaE/t6UBT7VmspPRm5oHF4EPASc?=
 =?us-ascii?Q?TTgGLa3Zpzil56oc1twRPNSfpBsgnCDxdZ1ENjjiGum+fBy8Apxb2hcNTHqm?=
 =?us-ascii?Q?VLo6LFzpyCYutaod8cKn9yPQpkmNGyr0HO+p+IiiCGMEAPpnrTzGZftM6d+o?=
 =?us-ascii?Q?xPlr9UfeYKqhGUL9LX6ClBfyOmvhcFcwt41JIHobaUP7zFX6VW9aK5TdDoPQ?=
 =?us-ascii?Q?WDQX0z9BCIZ04oUmjjploAblB+6kMwHhOXcrHbPMpW4Z2SBh9TlNH/ycA/mw?=
 =?us-ascii?Q?6xtlXErWpQUS+bcKb6hSbaVG62v7ggIUbhY2+TwNqhDdW2Z1A1PTumKx1mDs?=
 =?us-ascii?Q?ZrEspZxelXafz+1fLiNN/4W74PHOXmTUy6gsALenN1on1FbWJgHKIfPKvQXb?=
 =?us-ascii?Q?Mk8Vzs8KEcu5t2CVB+tfxenU+56y+8FcbRTnyJTuxFk1tJivQPQaMZJhNl6C?=
 =?us-ascii?Q?KlnDKdJvZuz3ImTKuu6rujS00t0lO1J3Gqqs0ZvHkO8rhK6h7hY/YIdNrR24?=
 =?us-ascii?Q?sNs1XtzRvU/0DhNYIWE7193GgVsjcaarxqrm9IZpuqKSR6NFgMDUA1NUBQB5?=
 =?us-ascii?Q?U1CLN6W6YSCrGPJ4Ltwjzd3KvWKB4daLcuumT6x73O2tSFYhYrHPhwtfZjly?=
 =?us-ascii?Q?l65Oe8zaFvLv0Fh1rL/iZpMO9NzJmAhjCGQqy97JdDWY4BiJEb4+aiYDZYV9?=
 =?us-ascii?Q?VxLV8I4BjDlmUJFRWdoRbxxZegsWIJ2vIbDpnO5MK0qfxPteDrUU3EY5qG+t?=
 =?us-ascii?Q?r6WsoqwCIZ65rESJUmPer3V5+ZHEjMYvaMe66ro8jRfzVd9tVlIATlApewLE?=
 =?us-ascii?Q?gXMCy/dK0i1YFF5xtleWiPtCkXIRhyv75u/fZXhQMzeY8NyXFVSK021tEPb1?=
 =?us-ascii?Q?iY61Q8ByCvcV+cyZXO4Jr5HVce0Pnevz96tUmVA2p5FasFoDu7JruIJ8TaHb?=
 =?us-ascii?Q?jivYigLVb327S0K/hf9XAgdfaDz6MlkdECfAoFmCdQ/isapD7cR2Co6oWvGW?=
 =?us-ascii?Q?YfXzquSA/kZlTYt53gcfO5h/3CpYP/E93rVynLORU92ZcLn4XQsuj6hogLfa?=
 =?us-ascii?Q?Fj6YZfav/a0vRrZGq1xo6KXzNg8EN/PLqSTRPrelX6dUVmIhcHI0dMmIfM9J?=
 =?us-ascii?Q?x2kBOO1wCr77pVNU/K3EZSZoIdNVW7w96SoKea2aEbum82L47E1Z4pLgw/JF?=
 =?us-ascii?Q?NTUIwPBQpIX3CLEZapem4bCXZ98fSMsPA4X4SCOqX0hMeqZDCJrcpa2oGse8?=
 =?us-ascii?Q?fovp/LjeScRZHuQ/FkTJpq4b32onxtV/Mq1M56W4LOTiFLNLIdAoltPzW3lk?=
 =?us-ascii?Q?R1TylUza5iPUOUxoZD9e6hEqFwfyoJwQyJDj5ToPM5N7NJ/yV3CNy98+kgTu?=
 =?us-ascii?Q?LL2zTET6KDAQFouF+8tomiMqXbmKHgMUnXfi2jYhPH4sExU4erWyE5YDPjF4?=
 =?us-ascii?Q?upQVlU4fGRFQEb9dS49OL2RfOiPz7EcH4FLsVzIY0pejGVwGCqWZ2YhaPEqG?=
 =?us-ascii?Q?pTP/hIavqCFgrE1ov0aB/wMCf/cBtO5+iuPsXno3G6i0aprJoxT4Z0ru+ZiG?=
 =?us-ascii?Q?5EI8PrM56Es0HTQlkFsrYXSUnhollnth42WSI/lQjO5t?=
X-OriginatorOrg: ipt.br
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0786bb-0195-4315-be64-08dbbdf720d5
X-MS-Exchange-CrossTenant-AuthSource: CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 18:42:10.9877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aab57f47-5b85-4924-8047-691190100bd7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDgbvU/8SfvjOb3l+fb3HjpzKJ2fTskqsAJl0NJS84y+Nw5iIGv0UpvM/kG3HO7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: RO2P152MB4776
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
 drivers/platform/x86/thinkpad_acpi.c          | 81 +++++++++++++++++++
 2 files changed, 101 insertions(+)

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
index d70c89d32..2324ebb46 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10785,6 +10785,82 @@ static struct ibm_struct dprc_driver_data = {
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
+		strscpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_LEN + 1);
+	else
+		strscpy(auxmac, "disabled", AUXMAC_LEN);
+
+free:
+	kfree(obj);
+	return 0;
+
+auxmacinvalid:
+	strscpy(auxmac, "unavailable", AUXMAC_LEN);
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
@@ -10843,6 +10919,7 @@ static const struct attribute_group *tpacpi_groups[] = {
 	&proxsensor_attr_group,
 	&kbdlang_attr_group,
 	&dprc_attr_group,
+	&auxmac_attr_group,
 	NULL,
 };
 
@@ -11414,6 +11491,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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

