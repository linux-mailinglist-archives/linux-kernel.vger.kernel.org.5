Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BC37943ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjIFTwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjIFTwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:52:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2120.outbound.protection.outlook.com [40.107.244.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2538095;
        Wed,  6 Sep 2023 12:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS7+l/eaF7GMEm2XpDzMZ0Y/TaMq3a+TiRgnTdvgtadofrk9H3D3SJzXq439jPTQQmdcl3sIFLuSXXU9o+gud+GqLeygY2/+gq23HA9bCmWxt3ZFDznJ/gEUYh0F9cLgpnyXiynhijJtDmNsdYXFcXC08zJkB+GJsSwmO+CuJDvYg89vRv+eU+rmtjewP12YdPv5jGvLLNZ4gKogF3MuqVagWwjHTXv0s7azWUHqTrIgzRW5jzg5yYhTGd2INglRENcW0sPeyXp1dAL/Dv83WXtSsq150Q6xpbrGD0zJVabzDgd/M7Pm3JSKT1OcUpQennX9mE2hN/bRZqIw/yArpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSG4GmGtYcVFN7/yNwHlUMVTb2qL9EYb49wFHvmc4Ns=;
 b=CyhXrnzL/5JdVsARfYyTYMU2Vpi8mi7DRzA6+H3IS4FsR0O3cxKs06GvmNZH4A9QnXhMj7rD5si7D6JyDFKfpXo1ii8wvtU+/taW8dvyh2f6OFVBUFxbXIDOKQ+zxn4Rn24o/PDzJmzUuvfQ2E0UEh1I54Bj0u6aZYa736DNTBy9EMxv6gPPjw2i7NBm5uRS1G3bPtX771/k6ucWcwL9l/0fg9Y6hMIp31ry6U4S+nRidWxkjfHkEqx5wS/D6R5H59LKOhBvRGrEFM+Ed7iH6izQn/AnFdLere7s+7+GaM24XbXTQP4DVrIfAELia70GP2NCRbXPYnB/WT/WfSH5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipt.br; dmarc=pass action=none header.from=ipt.br; dkim=pass
 header.d=ipt.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipt.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSG4GmGtYcVFN7/yNwHlUMVTb2qL9EYb49wFHvmc4Ns=;
 b=Yg4FvgtQCsy9g9ZvUFb4RpuyRC0RE58Nz6jc/9+3GdMJbBGfeJe1tVoMqDxj4vvqfLNVYWFaBikVd3yLv22xvd0acLGcufhXThKFcYFWvMBfgGBe4LbAuH928vgPKcZ8AJCW1RrczCB2uAyT5ybP02tJUiYRyWqFrdV+WlnAd84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipt.br;
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:1a4::6)
 by RO2P152MB4713.LAMP152.PROD.OUTLOOK.COM (2603:10d6:10:68::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Wed, 6 Sep 2023 19:52:22 +0000
Received: from CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::d973:8d11:70bb:7900]) by CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 ([fe80::d973:8d11:70bb:7900%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 19:52:22 +0000
From:   Fernando Eckhardt Valle <fevalle@ipt.br>
To:     hmh@hmh.eng.br, hdegoede@redhat.com, markgross@kernel.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        mpearson-lenovo@squebb.ca
Subject: [PATCH] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Date:   Wed,  6 Sep 2023 16:52:04 -0300
Message-Id: <20230906195204.4478-1-fevalle@ipt.br>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP6P284CA0002.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:1aa::7) To CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
 (2603:10d6:103:1a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPVP152MB5053:EE_|RO2P152MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: e6180746-fd15-4835-e4df-08dbaf12c910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3l7ReHSMU+B9KY/AvrnJEEKmHEyNLBy71kFKAmJdbyYXbq0Js6CS/tlwA3D+vs+bM8NwecYPr9mp7o1c5T5rYeAdhKSgqybxBleQj3uqxNK0kZlaWKI2D/2MwOiHnAmc3SbKdiVSRtbYjq6pYJWNes98sg33r0H4/QPxm3qqMdGwV6jTOKYT+SjQZ0LjHFfDHHUqbQPhh8SX0k2L45Th7rnpf4CSKR1oZYg7n3xv79oYugXH1jDp5QAQQzwkgw4Y5EDFodZYEHyPghkSPv5XCvo+Nz2vsMx7Nsl3FMtsRfO08AigmKQLpxct65FrSzz9LxIyvjw+g80fEsMFldcOVCV2gDn/4NZGyLFipoZCD39DUjn8TdjU8V/yl+lLYvHwXdT+6oBtgh+6Ej78z5bBhqu6kWP9xYvIXNPrOyD2Gyzn7Xbf/eqFa8hwz6ei5B4yPozk14D3R9EV2969uckyN9WihhiMUDPQ+iZQuARzefPHPkRkKIHgWX5LcnVGr00biEdZTnHVjMN6m8w1XCpOwfg8iIEmrYUMAlN44Leo4Y7VbSGr+kfye05LFq0AdVkq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39850400004)(186009)(1800799009)(451199024)(2616005)(38100700002)(1076003)(6486002)(52116002)(6506007)(6512007)(36756003)(83380400001)(478600001)(8676002)(8936002)(66476007)(66946007)(66556008)(5660300002)(86362001)(786003)(316002)(6666004)(2906002)(41300700001)(41320700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/6/bH+JmXTbTedIJWMe9c8eRShGP6bvUY+r83cyWggl0EGHzFn1t+d18zI34?=
 =?us-ascii?Q?0I+s5SEbkBxmyuiIc2xev6A+s11hlt2pP9fmimmVeGzIzN2HSkECXFL3Rui4?=
 =?us-ascii?Q?4oUdP27A597ERA9N9J6v3Gx9xRWEZIHJemd6QtO8US7ifADtAKKb3SX7YJ6o?=
 =?us-ascii?Q?aBndD/G9fUDU26QXlI8wAilt+3F7icgbm1+ubeWlhTK6GQAKgH1XM26bgrJm?=
 =?us-ascii?Q?3g4KHRfKyC5h0ccV40sYpAfxl17i2D1OzDlIuJbq+25FA4i/JhgtFuDO6tFx?=
 =?us-ascii?Q?81zdkFwjR2G7K8I2WMrxPjQ3neYjN/0ds4jLf8BEUiZk+f8SGyVfjyYISe0v?=
 =?us-ascii?Q?9BmHFXaCZITGSYiI0Nz0G6iGstOCwkSVuKV2E0YOKts13m44ApF7/veWWLhW?=
 =?us-ascii?Q?F9OlQ8iMM7UsIwVgvwtjLV+Zt1NHSy+kXYXSBRoHxT4LDM10PpEwHmukEAN8?=
 =?us-ascii?Q?4YlE3bjem5Giiw9c2a8G/9+OTS/GWlv/pZm3ZFvYe4WNNadjfZbn+UR+kShV?=
 =?us-ascii?Q?4QomlAe4Dlb/x4QRCXsLXgGrBTXs2rHS1P9rv2nHVNgliy3ZIrERv1r2wHCF?=
 =?us-ascii?Q?7lulQ7QR8v7QeGjG2Sztnaag4Ws8j1e1AousC81pxFr0KYbXqXMOZhBdm+/+?=
 =?us-ascii?Q?w5bchv4EZOtwD/Hfg8tvF0Wst4XeHyGEvt5MzAdZSqNKMyy+uPPMPNLRi5mC?=
 =?us-ascii?Q?CRaHWlFMmIVgy18zgtD7jG4rDUybK71KEgpcd4ppjDqCagdEIHHRjh36PUiy?=
 =?us-ascii?Q?OR6dUuzYeYnzF1WWL7XyZadp3m8OivIGcYwd2zp2P88KCHRN+2VEDN+ULiPm?=
 =?us-ascii?Q?HWDCV6BSjM1R5wSG833GvIKLul/o5YUxalw+2QJp1qLW56BHawcXJmTW7ZIQ?=
 =?us-ascii?Q?hCAL27deuFSse1NNAi061Fo9T8rqatN3/Xetz474jxZKCbyp2yGA+76X0pEJ?=
 =?us-ascii?Q?DsvdUkXphu/XyNjRBy5ZA4fiwwNIsS5VnKJygsywAGMhv7JFDghUsWXbkfvn?=
 =?us-ascii?Q?KKuijuRpLpuIf16sajxk/Exg3c8c4FJBg53mj+g+1u1/6vPxNO45RDSZ7cYd?=
 =?us-ascii?Q?BQeaz0jeX5AOwAHCslnhUzbH4MMX9KMaGjZZ0n80SFGIyDRKt24+IWtpxkp+?=
 =?us-ascii?Q?wt6Kz5joarRpnPTNUg9KEFZfBjE5QmYVYmIhGtxch6PwybExZ9RvPlldlwWF?=
 =?us-ascii?Q?QKF4notOtCldIaJMqTycNSvp7oFxCsdl55QUiXkTNky/EnYG5TcxC7L7tJqX?=
 =?us-ascii?Q?xyhyemErwOjZPpJGv3kw7h5raXxlz/AgPLTKo65ftGrJs3EEPNmFRfzz+mH9?=
 =?us-ascii?Q?6x9ydKtbsTMaJpthv85QD0GWVtvDz+jJ8+uhzNfdjz6j36lPCbjZ93A4hxkJ?=
 =?us-ascii?Q?XZGqQIL/K4TEgPtgW8HBlj5EJ/nwK8OP3PXjWw0rSOLuMz7dkMjnNEMgmSPh?=
 =?us-ascii?Q?lDFFenzgLFK8abvOb+/sGYS4HdCkqM3kgTDzxb+dot66In8Iyy94snUGW3JR?=
 =?us-ascii?Q?ELVhZQNWfTt76Ue5IOEbM5VMfT9bjOXONgYdn6Y1MJAIV4axWnTFvYvm0/Jl?=
 =?us-ascii?Q?bmE2Ng0vY/uHzSfFOXSwPZMFtzxT7p+k7UD0TuUb3yxgrP5EPtswkwJCrmK+?=
 =?us-ascii?Q?CeP2bJWEuEMKTNXkwQSrZAR6t542y3rMEJ/8h+1Tk5ms?=
X-OriginatorOrg: ipt.br
X-MS-Exchange-CrossTenant-Network-Message-Id: e6180746-fd15-4835-e4df-08dbaf12c910
X-MS-Exchange-CrossTenant-AuthSource: CPVP152MB5053.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 19:52:22.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aab57f47-5b85-4924-8047-691190100bd7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6jeSgwz+A53Ime2xx+IOevr8BIWtKtEX+yHeIn8dD8zzw0UceJF2k0/2bYLGED0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: RO2P152MB4713
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

Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
---
 drivers/platform/x86/thinkpad_acpi.c | 77 ++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d70c89d32..0b1c36b0d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10785,6 +10785,78 @@ static struct ibm_struct dprc_driver_data = {
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
+	memcpy(auxmac, obj->string.pointer + AUXMAC_START, AUXMAC_LEN);
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
+	if (strncmp(auxmac, "XXXXXXXXXXXX", AUXMAC_LEN) == 0)
+		memcpy(auxmac, "disabled", 9);
+
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
@@ -10843,6 +10915,7 @@ static const struct attribute_group *tpacpi_groups[] = {
 	&proxsensor_attr_group,
 	&kbdlang_attr_group,
 	&dprc_attr_group,
+	&auxmac_attr_group,
 	NULL,
 };
 
@@ -11414,6 +11487,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
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

