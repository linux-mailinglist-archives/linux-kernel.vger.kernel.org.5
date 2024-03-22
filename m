Return-Path: <linux-kernel+bounces-111304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6558C886A74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886391C2104C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DDF3D968;
	Fri, 22 Mar 2024 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="S+hIzNgw"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2181.outbound.protection.outlook.com [40.92.62.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D041E522
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103640; cv=fail; b=FBeiW3o2eUV8EyOzkcwC823Bq4j+qhivV/WCLwhWitMpzNjqsJOaQ2THE+1ly4BcOarUDpNmwwhA7gjNKizOWXVvJVPkKpJHZrECtXrtGu8eWqQC0lly4VrwkdFC29VUX5b56dtSolt2FtzZMkthJbFlamfk1NH38HZ8XxBHXgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103640; c=relaxed/simple;
	bh=TedvefoKjqLUpkcG6q0lQZHmPRXX//n6STbWXrKiRbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LETZehxvYp2y4Do8hboY0sfrLTWHaiFB9O0dalyd2JgIUV8RhOiu79N7B6solO57TmRz8hgjCcqOJeNMyLTn8BxDpx5hY2Nbgr3K7PK3jl/9mzMHq7Kb22RROIjn2p4Dav1OPDtOpinn++aBzoV0EYNV7Wvu/RgnJV7xVhwZM2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=S+hIzNgw; arc=fail smtp.client-ip=40.92.62.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clEFixxes4k9NhV+ha67pCAImOHgC/VkDg02XMYR4lNbI4pElcqGHJjCN4LZlS/5Rt++K1+hlGI2wuWr/Ly5RcT70bXqJNBiVxzavOUHk3ledpHWxD2NTS7OLUHF5v3k6KKK5u5GhKbtUqL0VKWAqKjcdgj5E000XhA2La3yRFfrVBU3/PfMyD8tmM4zXXccuF2AAxVDo63DPpTysB4n22SnD6AmE2osERd8MoGM5UUN+nd9F53H5efZn1fhWhskdXTHqUWzZwkuVLfWr2v+F6dkUZkubp6A5G7EiewK/82vIID1H3LByXtEH5bC9tfCkSIl6AGv/v2umDiZOkCK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoSjnihk71r35Vf9ZGkawcWaLCOqV3v2KtZhe/O3IQk=;
 b=V7sJyyQq4B5AQuQ+L5ZyfG2Yyls0EMt7vcVmjGO/XmBg7qLj2QEGKoS6c8GgynifNGGlm76yZFtBPsMW40gjUuSkLz2f4hEp2brd2iLdMaT3t4FtxZQHmig+wLHEy0tZ92r4nyYq1gJF57y/K94inhE4CL3k4b0P41AJH7UGsXSqx0TYIoweFbw2LcZSR4wEPQJDiSAry+LY9CR9XzGZvNDd6VTu15DO/9W3Oxdl4vdjyqVRlkogS1vWemB3Bc7UWqn/8J4kBjbXipW2DOeNyzfhlPr8CHdTiJq86aFxbzgux10D58f887xTZ1LK5FoeToocAqJZSbUagC22GedL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoSjnihk71r35Vf9ZGkawcWaLCOqV3v2KtZhe/O3IQk=;
 b=S+hIzNgwPJ3KvYJpUXC5IMBKxszgY4Pkg6JlCoSVwpzijgsNAb0Bvo2cfUtwmBcPJUT2tiJI+2/tW4LowmoT8SA9H0iWKjCMnlEf6xGPhQbvT7vS3E0mvw/zMDQm0gvOtpSxYHCDV/fvOwJZ8CWLUPVD9Hf2K90j6AvqBs4HKNxThLBVaMWA3cids3/NJ/gQ6vFQAzMGynOewtpvprAOlYuzMnlnQjiPsbAK7WaYM9eVph6HTaCvLsw2OSLRAm+DOSmNBXZpi//lLdVj793DKHUMxkoCjK/uv6Ls7trbItt4yzscge6TZaMV0RoiIG5+akyIorati7jd5KXCksK46Q==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 SY8P282MB5238.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2b5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.30; Fri, 22 Mar 2024 10:33:53 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d%3]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 10:33:53 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Lee Jones <lee@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Stephen Horvath <s.horvath@outlook.com.au>
Subject: [PATCH 1/2] platform/chrome: cros_kbd_led_backlight: Automatically enable keyboard backlight control if feature present in EC
Date: Fri, 22 Mar 2024 20:27:58 +1000
Message-ID:
 <SY4P282MB306333469B31348E4A25A1A5C5312@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322102800.1322022-1-s.horvath@outlook.com.au>
References: <20240322102800.1322022-1-s.horvath@outlook.com.au>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:
 [rK0eoUIDiDIXk0VqnP+z3pxqnzb/M56pMIrU3z5OOYp+XVrkByV4P1MZwrvf1McGrN+Kw7sZWvA=]
X-ClientProxiedBy: SYCPR01CA0033.ausprd01.prod.outlook.com
 (2603:10c6:10:e::21) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <20240322102800.1322022-2-s.horvath@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|SY8P282MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b3ebc8-e234-4568-7431-08dc4a5b91da
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+rMX0N9HfGllSBHbNAT0X28rQbdXCp9Id7VFyBQHX2Hp4f63detznIgiBKSTpG5G9HDxIqXib+FPKY3xCP1ro39clrLS1infnAzElmEZ6aj6IKX26VH57ILAcF8f/rjIXdBYgn/ZV9+fFwD9ukB6wnq/LsF2Nc7OXIWqU6NcL/Y52t3f5PDuFsCUhpuQ4C3Wp1mrgb9RldDp8kEbRC9vRhkf37932z08P+XN/441xt55PQQjnCpFsUAKfPnO8V8T8UkdT2C/ea69ujPUCkAIY0abuA3Xcgn3fKJmIjqHSx1z1NnKE2oHgr9Q+TnaEvAylRe9ehRwGsG3A4CADnFAEQAIEMgO6dvRgTkUw1r0MszwyNSAc1b0RwdqYAt9cZFhjg3OnZWg6UQtbOLXyLWyOjJf3Vpv89+dE2n85bTG73M6Z3aIFYKr3JIQoeinyyTCq5eUJBowUFqnPIWTsgbLodLimRtHvzlSKS352nzK+diuMsENdKJmHihDDyeJXMbxXNecYNlOqPob4bSeGI8fuPdxNrBV3w0vZCkAFDlyFo3r1GZfIcdTfEvowRMvR7/tWHUT4voRCn0Xs94GpdMjgdilyYkNehlTmUa7E9Qpr9+xbVStdSpNkIeOtV2tMfL3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PmeEMBV6d1dBQ/lfX4EJL1UmMGY7vD5vFhKzg1DY1V7PurZN46pp4acft8++?=
 =?us-ascii?Q?4sszRKL+9X/1OqxtYAuWW/0pByuYADRho3yGa9v96f9zwgY87Wilxr6ISw35?=
 =?us-ascii?Q?a4PgV+Nivbc5in+Tz6SWgB2nUJC5XY/c5y1CagCmdjb84YOGebHiMT1buNvJ?=
 =?us-ascii?Q?pjsUaWKn7sTLpTWarrEQNZbqdR5OBL5x4H1JlBIU8iwUsMap7Wy396FMQofX?=
 =?us-ascii?Q?psCNknCGrXsHEwoRWRpVmWDRBLIjMdVehDlAE1dBGGZm6aAnypnuTZhGLRiq?=
 =?us-ascii?Q?w0JKkKVLl8QXJmFH/qP3frXcbjNuEcqNWhAePXvOCv7dH0MKHwzRrvYext2k?=
 =?us-ascii?Q?Ri9V9duZeDPTIyW+yFb1YaM8irZnG/Ia38UQ6wqQxh5EXIzv0DPbVraCZbBg?=
 =?us-ascii?Q?VSyBoO7t5WdeUI9FWtYweiO24L0JN+qkdrQaWJQIqLyUVT9hWinz9nK26lfB?=
 =?us-ascii?Q?EhwxCULGSUe/pM6z7fBAVI9oTtmnD1t7kQIQVR70Gk7PdKfvN02Kf/agPLG9?=
 =?us-ascii?Q?d3eHyhAh5VPvg3yH7EwMIo5cpf2S85FCJp3hd8FyXhma6EJAUW9QMWH9yNmq?=
 =?us-ascii?Q?5IMd5HHVJb1WXjzK7DfqJzx1/VRvlMjogQndhaaN/+52YmaSOG9GK+2+MnuM?=
 =?us-ascii?Q?lWLG5k97zwqYlYDNMrRnlmcvhQ4z8Gymnaz3hGAXaTmgD8rBLWf7tqxGEMi8?=
 =?us-ascii?Q?257k7UR2DRFsOlQP3I09ldtKqdNWiK1CWKlvyhQJ7z0dmltBx/IoiENWinP7?=
 =?us-ascii?Q?1hT6EnB52AsZMEtlQuWWM1tIpHR8jl+Jq7F1PizXvvVZhm8jE7G8arpJpHKU?=
 =?us-ascii?Q?5byXHzdWiMt/POayICppSjYbDGyD+KBAKu4w1O4tQka9JZDz5bRnp0gXMElu?=
 =?us-ascii?Q?3RQ+nPKfc9KFPR8awjbXVzcdT1n3JBRJKg/LeXwUCi7/p7NqInl72iBsArqD?=
 =?us-ascii?Q?zonL3PCo0GEAI9u1YAWSsF5dHCkvJEVXlQF0KmOGM9XjkurVARhshrCpE1q0?=
 =?us-ascii?Q?Ui6XDf3MwRj3bi2t08AZkPI928jzR+IPrc5M13oLY2fDFghFFZNKobhm74oW?=
 =?us-ascii?Q?E7UBJ8irrySJnu9kcRuoTocm9qlZQgYPUC93+DPRirdp9OFGNPhm3zMRHfFO?=
 =?us-ascii?Q?ycwmgZNg5lCAiLxB0fECbreOnqjs0fXvZslsQRJw25amPETliclD/JGdoBVr?=
 =?us-ascii?Q?vnSxfeMeYw9McJ3u0yIaw2UN2wpeqVT2SyTs4AwQoxoh0lR40HH1eXAvRUS4?=
 =?us-ascii?Q?p8WMukBwb7bI9xs0SQ+YxC+ozR6pnPJ3NotTBy+7bZrt7Cfz9bG1KAgo6ORS?=
 =?us-ascii?Q?WmadhzzJ5xcoGAVlMa9hFU9H?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b3ebc8-e234-4568-7431-08dc4a5b91da
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 10:33:53.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB5238

The keyboard backlight control is not enabled by default on all devices
with a Chromium EC, e.g. my Framework 13.
This patch adds a check for the feature and enables backlight control if
it is present.

I also fixed a bug that seemed like there was some confusion between
`cros_ec_dev` and `cros_ec_device`, so I'm not sure if this module even
worked until now.

Signed-off-by: Stephen Horvath <s.horvath@outlook.com.au>
---
 drivers/mfd/cros_ec_dev.c                     |  9 +++++++
 .../platform/chrome/cros_kbd_led_backlight.c  | 24 +++++++------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index a52d59cc2b1e..29b85ed5fece 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -99,6 +99,10 @@ static const struct mfd_cell cros_ec_wdt_cells[] = {
 	{ .name = "cros-ec-wdt", }
 };
 
+static const struct mfd_cell cros_ec_pwm_kbd_cells[] = {
+	{ .name = "chromeos-keyboard-leds", }
+};
+
 static const struct cros_feature_to_cells cros_subdevices[] = {
 	{
 		.id		= EC_FEATURE_CEC,
@@ -125,6 +129,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
 		.mfd_cells	= cros_ec_wdt_cells,
 		.num_cells	= ARRAY_SIZE(cros_ec_wdt_cells),
 	},
+	{
+		.id		= EC_FEATURE_PWM_KEYB,
+		.mfd_cells	= cros_ec_pwm_kbd_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_pwm_kbd_cells),
+	},
 };
 
 static const struct mfd_cell cros_ec_platform_cells[] = {
diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index 793fd3f1015d..06e9a57536af 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -171,12 +171,15 @@ static int keyboard_led_init_ec_pwm(struct platform_device *pdev)
 {
 	struct keyboard_led *keyboard_led = platform_get_drvdata(pdev);
 
-	keyboard_led->ec = dev_get_drvdata(pdev->dev.parent);
-	if (!keyboard_led->ec) {
+	struct cros_ec_dev *parent_ec = dev_get_drvdata(pdev->dev.parent);
+
+	if (!parent_ec) {
 		dev_err(&pdev->dev, "no parent EC device\n");
 		return -EINVAL;
 	}
 
+	keyboard_led->ec = parent_ec->ec_dev;
+
 	return 0;
 }
 
@@ -200,8 +203,10 @@ static int keyboard_led_probe(struct platform_device *pdev)
 	int error;
 
 	drvdata = device_get_match_data(&pdev->dev);
-	if (!drvdata)
-		return -EINVAL;
+	if (!drvdata) {
+		/* Assume EC if no match data is provided */
+		drvdata = &keyboard_led_drvdata_ec_pwm;
+	}
 
 	keyboard_led = devm_kzalloc(&pdev->dev, sizeof(*keyboard_led), GFP_KERNEL);
 	if (!keyboard_led)
@@ -236,22 +241,10 @@ static const struct acpi_device_id keyboard_led_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
 #endif
 
-#ifdef CONFIG_OF
-static const struct of_device_id keyboard_led_of_match[] = {
-	{
-		.compatible = "google,cros-kbd-led-backlight",
-		.data = &keyboard_led_drvdata_ec_pwm,
-	},
-	{}
-};
-MODULE_DEVICE_TABLE(of, keyboard_led_of_match);
-#endif
-
 static struct platform_driver keyboard_led_driver = {
 	.driver		= {
 		.name	= "chromeos-keyboard-leds",
 		.acpi_match_table = ACPI_PTR(keyboard_led_acpi_match),
-		.of_match_table = of_match_ptr(keyboard_led_of_match),
 	},
 	.probe		= keyboard_led_probe,
 };
-- 
2.43.0


