Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28687A1EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjIOMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjIOMcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:32:01 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2113.outbound.protection.outlook.com [40.107.96.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B79B196;
        Fri, 15 Sep 2023 05:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1KroZyF0PPxeaBPyWE+x87an5VY7EI02JYYzNQ5e6jhR4xCAvZD0bH6Rvyw0dV7o/eTwZNcI/V54C1j7TCUgA03KcVr3E5BKKVLiaXWIJ/i59R3YmWZ49s/tcu5K2zqXHCyVmvUvhXW/l+AhvjjRce+hX8jJFjmZYEXMjbr/QuqVvs9Sx8PQKZTxkgyzqcUEiIIHcxOa/TtY/ho1zl3HSbnkNdEzwtNLqHrXaK2Eras7uDLVFTdkMzMXAg3013lmwGi8aGqreSRHKUHE31VZ28T9kH2j3DyZdpmBLfXIWcG0306TxraDbIewaXkit7vOZ5setmPF0tnPsNUvVbMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xO84jpXNICtVSNvh3NnN+iyRjqdWA9pcTCB8Z5xJfn0=;
 b=LUabm8ZLAkuZuoe5jIxKo2ls7t21WpjlZ5Iu5P7niLeaF2oYq2OdkvjHu5l+CKOcbuEJOVrMztXmwKwfwBbNOuJXoP+uHesIhL9mgPYOAQY8KmQxa/kU27KPF0efywi2x/natQJ9HNyybMn31ebOWDK+WQDztdjedpB6V8Qske0QAGoEvBshIa7G+6/P4JXXehgDlCOEraBp9VpgxOmLNgV/0HboQFqQnTNduZBHIGVPNL6VTKZ8IR9wZ/oIy3/rNAeOg2WQ+20US9T78LgQU5LG6hxlLvEsBzBKxFRz1flDh+GY2qFmG0ZNwzFOjsZX3085fB7ov5OmJb7S5h90Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipt.br; dmarc=pass action=none header.from=ipt.br; dkim=pass
 header.d=ipt.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipt.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO84jpXNICtVSNvh3NnN+iyRjqdWA9pcTCB8Z5xJfn0=;
 b=KTMZTimXNvuKQEbardKVcbXFqewPYzQezBfQlsQ1VgvbocPO/+xZJJ2SJ4U1iwXVP4TjBHAVTl3fZQW7rEG9jMK0vG39UkzMo6yUcQoSWemEQKC9r44tnoaohpVHfAs6ZMDe6jmfRZpvjmrzN0ZRKC5R1DvWfkQjGk7eEtXf7Bo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipt.br;
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1a4::6)
 by CPUP152MB5318.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 12:31:52 +0000
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::d973:8d11:70bb:7900]) by CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::d973:8d11:70bb:7900%5]) with mapi id 15.20.6792.022; Fri, 15 Sep 2023
 12:31:52 +0000
From:   Fernando Eckhardt Valle <fevalle@ipt.br>
To:     hdegoede@redhat.com, mpearson-lenovo@squebb.ca, corbet@lwn.net,
        hmh@hmh.eng.br, markgross@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Date:   Fri, 15 Sep 2023 09:31:36 -0300
Message-Id: <20230915123136.4286-1-fevalle@ipt.br>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP5P284CA0230.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:22e::12) To CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:103:1a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPVP152MB5053:EE_|CPUP152MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: da740f23-aabe-451c-097e-08dbb5e7bd34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGS3v79gtEUeREcYzC2ti5yVJmyMBTrouN3884q5EpUU2AVLhInW6YWzlwYlEQWDxDmEN9jronnJdPvYuMMOCaLCsbXcmhAJ9S4vb/mRvKBNZa2HnCliKnkSpfzqdIbyoub1GqRuVSidFcgjMlh3n92OMUKT4vDwH55rmALqbg4A/UKuXtBoQegT35YFkSzmVFBVuiuG7iLUAbIDQxhzu8O8Bq5Epr7jIvBNBpsP8ZZGJ/ScEhf88L4GaYuPZZQgeatx27mKo23RKOvpZewE7asl84+aspER3IHhvhugG4xrD3RxawnbXPkFsM6vM2DN2kKNH/Yd+uPAuZ4Nsptug08WQ6pf6OZbR64tsQieuvC22IWDTXY3rpe2i6PnwhFTwdiKPP7ZXVSBzVJh4FYeWMwO7IqZoDRAQIUdqHIPg5mQgk2qynV/rbIgGsfCJZPt1itvHbvE9vNz2ZjBO28G5ZuANPT6Z18JMwGU/MtVIYKYbxAe4SevHnPHWCKJytPv8xrtvq6pa8iiU5j8vmpezwA3ra6qO92a2cdE4h3UoFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39850400004)(396003)(346002)(451199024)(186009)(1800799009)(2906002)(38100700002)(41320700001)(41300700001)(86362001)(66946007)(66556008)(66476007)(36756003)(8936002)(8676002)(316002)(786003)(52116002)(83380400001)(5660300002)(6506007)(6486002)(6512007)(6666004)(2616005)(1076003)(478600001)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q3Ro5BPsPrylXOW2BCeMbRHlxvRtBgXeipSuOwcxnHRBt6AUatxv6I7/AUqF?=
 =?us-ascii?Q?dFW1dBIoKPaibqduP4pD08R9q2nViQxHPizdUPJnqsBqDrRSB8NXEEBZThO/?=
 =?us-ascii?Q?SWVMhNWxj/2JnJeElwGyhijYz3bhjDYYTbyy/px5UO4dmspRL7csx/LeOFE6?=
 =?us-ascii?Q?V0vtUAjpev/uvVipd39ZyGV+JzGyRrc9p7YRULyYctYcG9NUKOh9JIcghx29?=
 =?us-ascii?Q?KXr1VEhvCN57xh7trKHxcJxrnLac+ROYaJ8biIcLDBGstALcP/el4xoZskju?=
 =?us-ascii?Q?Gk0KtsQ8tCRkPQJv3laO9XSxrYXZuUlcr+Ta5YTRyPo1hHcmba5x0zM6SU0c?=
 =?us-ascii?Q?xqh3Er+AKKZCQZ4EQKsJ0vNeBYdwr0j9KxfoG6YsgISYzQIwFj2gWOIJ9Y7l?=
 =?us-ascii?Q?m3hRHEG8b4wgZFR9kHc7/lRDUexRl2TG4FN5K8yU9ZnbP/llfvoFY1cRRyvS?=
 =?us-ascii?Q?RZPbtl8uLVaFyh+9adhFefA3NYTrM9M8++6FTQqvRIP1PGxxNrOHkg67oJmo?=
 =?us-ascii?Q?X9fU2ThMVve+1PmNrOa1Rjb57tD/hogibPFjLRvrGP6ioPU12nG8kdv7TA0X?=
 =?us-ascii?Q?Tk/mRzdRlj7wKH8GTxG4TqdnRjYVxg2OABu/KMOC5IS+G1Xv6a3qgHwKCECK?=
 =?us-ascii?Q?HhYqILBViKio3SQbLHmQYr/qtOVqE8PCZEhVnlIqzsOubGMbCn+wxFCrMqbT?=
 =?us-ascii?Q?7GgPjFUBM3WTdhrFx3cvUwnTOQxspuIInzpFiaXdw9Ev2NVlHlnKUzkIWBGY?=
 =?us-ascii?Q?qmj2mEoOwsKM8iw2MZZQLcZOWdQZ7EKQgk/npUXt3eMGxKMAY1/tntVLsGyx?=
 =?us-ascii?Q?/4wRHx6iZWJKZtKocDem3It6pvwZsCwT4aLihOjguaLIczJTBuBrn4lVJ/6Y?=
 =?us-ascii?Q?uRSc8PQ/ypUtJzdP+RL7epUQcvLSOcIJvAtC9u1ZeyVEE51HrRKjo6sAKoYY?=
 =?us-ascii?Q?96sGuVN1HkA8eJXzpV8o/i0Oh7KODsDr9nW5JJfuprHPU6ZUF+g+ygRKzI/I?=
 =?us-ascii?Q?jf4qwxk0wxqvEoB0+Z+Jm1tOyO2C/R/f7ytexDIkesKaaP8d/mOHbTXxmOz4?=
 =?us-ascii?Q?Vc/v/+ETlyR/g7UMXv7qmYrRHFSJSUXP2UZ6aEYiRwhev+liz1DMwRLM6Wuu?=
 =?us-ascii?Q?xsIyX5bOhPwLAv67Ta4U8l/bZjb78eJEGakVCjSiSK/SVeNjOrZRv418KzXr?=
 =?us-ascii?Q?EEuV8/zBNtcODEX7B9BQqPGBcqKKPk8rCXtnx5w4lTOSMC5za88zQfoG8L5T?=
 =?us-ascii?Q?mpJueO0t9rMMLa2m1jB732gn7G9tzTbSYTMQa5M7e8n7LHMgZGdN2SwYV/Fo?=
 =?us-ascii?Q?wnHfFh2gEkz2XQYWW4DqN3Jr0Gg51QmWwR8yiKISGCe2o/PMmkEhvI0l7ix8?=
 =?us-ascii?Q?JriAJbODbnUwZwNYSIR4gQOovTTvdTTLg9UyeXjVZ+xICpiHz1aLWfpL9NJ+?=
 =?us-ascii?Q?Ki9W0osMIWm3kakYh+DLs6lxk7UhDzc96qXxU+5/dYvCsjYWs/zzhazlYI5n?=
 =?us-ascii?Q?EZ6F7RdkMttwLs+58Q9YhXHrBwcHB4X4gYIYqax5/OUWTtkd2plC8rWAlAyr?=
 =?us-ascii?Q?64+ZBLveoCap+GAra8iia+4BxrzBjFtMx24kKoeuq3vzLtsJQkbLTb/zPkNG?=
 =?us-ascii?Q?UQo6LIqdesLEUVMtQFddxkd4TeqV8Rs+9rhN03mn2mAA?=
X-OriginatorOrg: ipt.br
X-MS-Exchange-CrossTenant-Network-Message-Id: da740f23-aabe-451c-097e-08dbb5e7bd34
X-MS-Exchange-CrossTenant-AuthSource: CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 12:31:52.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aab57f47-5b85-4924-8047-691190100bd7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+q8u7opcLn266NOa5eXUmUz/Et6OotXnX1NvZEzfHJoe6XQOHpql39IxjzCBbL1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPUP152MB5318
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Thinkpads have a feature called Mac Address Passthrough.
This patch provides a sysfs interface that userspace can use
to get this auxiliary mac address.

Changes in v2:
- Added documentation
- All handling of the auxmac value is done in the _init function.

Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
---
 .../admin-guide/laptops/thinkpad-acpi.rst     | 20 +++++
 drivers/platform/x86/thinkpad_acpi.c          | 78 +++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/Documentation/admin-guide/laptops/thinkpad-acpi.rst b/Documentation/admin-guide/laptops/thinkpad-acpi.rst
index e27a1c3f6..6207c363f 100644
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
+Some newer Thinkpads have a feature called MAC Address Passthrough. This
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
index d70c89d32..05cc3a1e2 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10785,6 +10785,79 @@ static struct ibm_struct dprc_driver_data = {
 	.name = "dprc",
 };
 
+/*
+ * Auxmac
+ *
+ * This auxiliary mac address is enabled in the bios through the
+ * Mac Address Passthrough feature. In most cases, there are three
+ * possibilities: Internal Mac, Second Mac, and disabled.
+ *
+ */
+
+#define AUXMAC_LEN 12
+#define AUXMAC_START 9
+#define AUXMAC_STRLEN 22
+static char auxmac[AUXMAC_LEN];
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
+	obj = (union acpi_object *)buffer.pointer;
+
+	if (obj->type != ACPI_TYPE_STRING || obj->string.length != AUXMAC_STRLEN) {
+		pr_info("Invalid buffer for mac addr passthrough.\n");
+		goto auxmacinvalid;
+	}
+
+	if (strncmp(obj->string.pointer + 0x8, "#", 1) != 0 ||
+	    strncmp(obj->string.pointer + 0x15, "#", 1) != 0) {
+		pr_info("Invalid header for mac addr passthrough.\n");
+		goto auxmacinvalid;
+	}
+
+	if (strncmp(obj->string.pointer + 0x9, "XXXXXXXXXXXX", AUXMAC_LEN) == 0)
+		memcpy(auxmac, "disabled", 9);
+	else
+		memcpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_LEN);
+
+	kfree(obj);
+	return 0;
+
+auxmacinvalid:
+	kfree(obj);
+	memcpy(auxmac, "unavailable", 11);
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
@@ -10843,6 +10916,7 @@ static const struct attribute_group *tpacpi_groups[] = {
 	&proxsensor_attr_group,
 	&kbdlang_attr_group,
 	&dprc_attr_group,
+	&auxmac_attr_group,
 	NULL,
 };
 
@@ -11414,6 +11488,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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

