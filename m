Return-Path: <linux-kernel+bounces-130442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7237D897883
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0050B32B4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F643153831;
	Wed,  3 Apr 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Pu7MBY8a"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2023.outbound.protection.outlook.com [40.92.42.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EE015356D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168708; cv=fail; b=Ri3Nqfkg6nLDIKYXIv6ix2SBHIvUvnPvxSgMORvt4kFrFW/9qT/MTH5yP+3LfgwPXfSZiPMOE7oWjXjKfoG2tnaF7FxCcBg14C6YI6Zg9PMwczvmipifRP+AsYdxv+NhF3wRnt+Fvlf2SiERkznI5k4K1VyJI0v3kgL2BLCT0XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168708; c=relaxed/simple;
	bh=oiOlpeQ8+pKut2TV6xpH0LS+1v75EqCt50JjtLV3MxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tSf4yBA3+HFZ4OMTkMoYQzywEYjg2k/w3dVBvJ412KyrC0ujnAdYf6qGFwrAPd80MJXLR/Scchfu925VcbeJ8gGOGszuGuznuyPA8GAKhdaj696GyG/p/rkW/PiYqPQnPazrxGitAwiWrguW6NnGv7L7FeRTzSJ6K22jq7daNmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Pu7MBY8a; arc=fail smtp.client-ip=40.92.42.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTseedk2FxlQFIE0VeR5nbDTz0XSzh0hc9Q+mt089Df9m4EcW/L8I50aGlLWY3G0MiJmT13W/ioUWzl6bF5p6FEX1eZXhkREvLFL+Xqfuihj90MFvTt3Vdynd5qDoQjm+A9kxQr1aLaSvzHfARVQXE6XEfVWiLWHyJnfiysR5FBG73JVNDz1BKAOvLRDfygJtl5NxoypIrWukKhUSsjGrHLAUgseD1hXaliWwRkFhCE/FTgFQxxZKqzaOyfaA327zqhyY0/frdF7x/YABhLJYlrDcSUJ0K8OA4UTf+AmadL1kCQajtUxsk18dw+Wf3VKKA9mkQewhboHjCyJ+/gqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJOCqS/AvEeq91GY1q5dIHbRScPtPDOQhbsNbWeuIzQ=;
 b=WGJsomLhKsKd6JyENMGiWfBS2fRITzqO6mY3x7sCGa6FPI8sDLxLnjVqGiu9uaBou1Smw0E3CFa3knpOHb8/n8WzEAdXFjS34AwSMkXvwkUm+yhjyRt5UV4i3ait3Jo5mBO3TmXT9HfL1hcoU/ZaZBbTlAADVwR1XXB5UtZ/bBw09/3xDOU2mAlTIrgJLItTs/OZ+uU1M4F8vf6RBMERcn5B9RhLzt/si9I6TydNVHX5taDx+Ipb8KrGBsJkJocoxuvw+vQt4SM+GF8Fvr+Nks4Q3R/Ng/MarRpcykz733Yx5wKlYfFT7oCMfph3DiHF11egSakP7DuW/34mq3MDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJOCqS/AvEeq91GY1q5dIHbRScPtPDOQhbsNbWeuIzQ=;
 b=Pu7MBY8aIU/4I5CokzEFsYGSvE9D0zBmPVOleTVUCEmwLJXR4h9v0f79X+iGpUYuLPNgaRuWmDs4bclGHTh1iDAsmwT39YUJTLFSSFD0ToUYbxikn3qwvWUZbPOy7lD1WPs3lhiFgsIiaMt8I9YseO0iLt8KAGpjuSfzebl1yfeHvmLZvnux2oU9LelDwO97gsQltHbEQu2Ng9rj0l8QS0M4BiSaeY7ZJzDZL6LKgNXW2b1rxRygwxv+89aJ07sjgMB/pPEp/YHvm+yHzoiu6phBIK5aXPL+hD0zwAVGKLQl/XJlcPAKu2AmDBg9j8xhbqcS97Q33ARtVpt47jIJ/g==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by CO3P220MB0783.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 18:25:02 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 18:25:01 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd v1 2/2] mfd: rsmu: add FemtoClock3 support
Date: Wed,  3 Apr 2024 14:24:36 -0400
Message-ID:
 <LV3P220MB12028BFE760123BAAC8F351AA03D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403182436.7353-1-lnimi@hotmail.com>
References: <20240403182436.7353-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fH+s96B6bivJcazcXY7NFlmKPDeunhtj]
X-ClientProxiedBy: QB1P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::31) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240403182436.7353-2-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|CO3P220MB0783:EE_
X-MS-Office365-Filtering-Correlation-Id: 70493276-9f23-4809-11a0-08dc540b5e94
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BjhdPCyViRTF1LyqBVEOMPUzsMexosIbHzHOlFeiC5ev22W4tO9mxAZIie6e6MFdeIafEwLDCFALGl+JJBKFfCIiG++g9Lfp0P184HVxk3pzSUBydiOc/dvY/aiFBGo3r0/JSKz0xE/YddDulK0z98x/rl+xWidi8iU/eVPVRdywxXcIKer1mySWf1bBhSE3SbCU4Z1n+g036lK6kw6WWRYVFwJCQCepw0ShdsZQZGRP2RlkZRiqCrfJnMvgikYdUKEikbKN3yR45lfkHXr+OS7Mi5CmMfLdhqDuJR6ma9hBed7OGYJi48RDYDtq8s/P6+e1oAbNe2DowpkTtekqxuJbHRCNOWnAhSTeFU6k0xSwIZ7Hp6Jc09XQFatFxw+IiQDrsx6K0K/pVPtCTr7Yx7mszW+1d/OrWvPXGA3KPZexGcZ/y6zXfOtNV1V7ZbhbjqMOW17JwKH3RwtKxXFSjdHZ5dFTXWKKSYmzZvM9Gk01Xzxl7mUktYx66+xJYw71jl+SdPTz90NBRGjCQG9ZAxHbxYWBch6GUDsy3Ah0Cqs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WNVweHg64VuYglfbY+/YpMvnIECJ7sE82Vm4VwOGMqSLTqPoUuvpOiLyPIU0?=
 =?us-ascii?Q?quXR+prwsJ6ZK9sHx1eS7NTEIRVg/UDxrfSnQQrysfJ1LoOgqGnn3Pnozual?=
 =?us-ascii?Q?6ZGtW3Xu5KHQEw6MlFpfyD0iHkY/4gDpE4ISvtZfQ58aUcrUiMZNSK9OlmHY?=
 =?us-ascii?Q?MBjnf7HwkdIvEzVwIZg1TEpce0jKxHz+ER2g+W7HzRiloyMTUUz/P5Xi6p5R?=
 =?us-ascii?Q?gacgknHB2EVF4uaLnjlhnv93dx2EzIg0vLgKm2tyLuk6lyWrnANVCflG5W+b?=
 =?us-ascii?Q?YqyBGihwYjv+Bi/iUalIWX1oUVCT5GTLtWS+Pwz82jrRuFyGaYr5Jlo/9QwX?=
 =?us-ascii?Q?H91FZoiniD0jCHzx8ktg20zYShCiVuh9D65GAou0g1Yb5Bp3qtJ2p3UYLhq0?=
 =?us-ascii?Q?ls7GyDMEOlfYmBgNkn5uCLVJu8rLX78h9dqP6lX9uiMhxExbyfBOOEj7O6ux?=
 =?us-ascii?Q?qFbZV/7TXXHAKjg/SDoGqRrRBuxiZV3tiRzoXvabVokk/p66yVWMq9VmHfNe?=
 =?us-ascii?Q?T7RZQSSrA0z5tYX/LYM9JeR4er85g85MyRGrN1VbsB4dscxojJAFHdoI7L5y?=
 =?us-ascii?Q?cRhbRpuLNINVzkNyjv+qxBH2k+1yVtONs3z6hvA0wKry2fdtInsiUURpJXHF?=
 =?us-ascii?Q?FxtYBhwx02dD2xwG4dhP8s+Bp5MRlXDeTfqs1nqdodqBi80+Q5r9pUzW7So2?=
 =?us-ascii?Q?avmGrTivWeaYLQjsN1EUcRyZjuGGR2/0FYgFj+d8TobB5BOEMD1p+OXJfjle?=
 =?us-ascii?Q?Ol9xLJ1VtoHFSTcmtvIjiJCEjYuJjYUHhosooJdIueGfFk7Pku3u0OwzN69m?=
 =?us-ascii?Q?wiwumZXHtCSvZevTTe0il/kYEtgQu1I22D7mHTLsd9J/GdzzupElPGhruqv0?=
 =?us-ascii?Q?6RWQZYdhn7acMplNsK/ug8lyrZJ0xKxj3Wy7KYcA/XxAXX+DPEnG0IqFnvFl?=
 =?us-ascii?Q?VdUWGnwj9HcabrdHQexSXGKR9Gy0BHD9id/1FJlflbX96yS/WoNmkmjNNjIP?=
 =?us-ascii?Q?68WBYvwMbHQCq7q6hC8nR4k/cjgxRMnxLlSB/iU5tgHsRHSfoy+tu2lxCOea?=
 =?us-ascii?Q?GtvsnzUZctLOfDF/z6HSoCzWZEIM9IPOjylz774S40wAlI9sLOpCACC6omSV?=
 =?us-ascii?Q?rTHMfAaRuRsSir1zXe0nUWe+zTzD2hjJXRnvx08Tfql56DnPnPQVpqU66g4a?=
 =?us-ascii?Q?DqQtDbWO9zB2ZrwKljkIv7Hx/p/ap57MzdsaCpUzpzCqZXNG/OAKvfguhMw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 70493276-9f23-4809-11a0-08dc540b5e94
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 18:24:59.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3P220MB0783

From: Min Li <min.li.xe@renesas.com>

The RENESAS FemtoClock3 Wireless is a high-performance
jitter attenuator, frequency translator, and clock
synthesizer. This patch only adds support for I2C.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/mfd/rsmu_core.c  | 10 +++++-----
 drivers/mfd/rsmu_i2c.c   | 16 ++++++++--------
 include/linux/mfd/rsmu.h |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/rsmu_core.c b/drivers/mfd/rsmu_core.c
index 29437fd0b..951ddd92c 100644
--- a/drivers/mfd/rsmu_core.c
+++ b/drivers/mfd/rsmu_core.c
@@ -40,12 +40,12 @@ static struct mfd_cell rsmu_sabre_devs[] = {
 	},
 };
 
-static struct mfd_cell rsmu_sl_devs[] = {
+static struct mfd_cell rsmu_fc3_devs[] = {
 	[RSMU_PHC] = {
-		.name = "8v19n85x-phc",
+		.name = "rc38xxx-phc",
 	},
 	[RSMU_CDEV] = {
-		.name = "8v19n85x-cdev",
+		.name = "rc38xxx-cdev",
 	},
 };
 
@@ -61,8 +61,8 @@ int rsmu_core_init(struct rsmu_ddata *rsmu)
 	case RSMU_SABRE:
 		cells = rsmu_sabre_devs;
 		break;
-	case RSMU_SL:
-		cells = rsmu_sl_devs;
+	case RSMU_FC3:
+		cells = rsmu_fc3_devs;
 		break;
 	default:
 		dev_err(rsmu->dev, "Unsupported RSMU device type: %d\n", rsmu->type);
diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
index cba64f107..a3f50a184 100644
--- a/drivers/mfd/rsmu_i2c.c
+++ b/drivers/mfd/rsmu_i2c.c
@@ -262,11 +262,11 @@ static const struct regmap_config rsmu_sabre_regmap_config = {
 	.can_multi_write = true,
 };
 
-static const struct regmap_config rsmu_sl_regmap_config = {
+static const struct regmap_config rsmu_fc3_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 8,
 	.reg_format_endian = REGMAP_ENDIAN_BIG,
-	.max_register = 0x340,
+	.max_register = 0xE88,
 	.cache_type = REGCACHE_NONE,
 	.can_multi_write = true,
 };
@@ -302,8 +302,8 @@ static int rsmu_i2c_probe(struct i2c_client *client)
 	case RSMU_SABRE:
 		cfg = &rsmu_sabre_regmap_config;
 		break;
-	case RSMU_SL:
-		cfg = &rsmu_sl_regmap_config;
+	case RSMU_FC3:
+		cfg = &rsmu_fc3_regmap_config;
 		break;
 	default:
 		dev_err(rsmu->dev, "Unsupported RSMU device type: %d\n", rsmu->type);
@@ -336,8 +336,8 @@ static const struct i2c_device_id rsmu_i2c_id[] = {
 	{ "8a34001",  RSMU_CM },
 	{ "82p33810", RSMU_SABRE },
 	{ "82p33811", RSMU_SABRE },
-	{ "8v19n850", RSMU_SL },
-	{ "8v19n851", RSMU_SL },
+	{ "rc38xxx0", RSMU_FC3 },
+	{ "rc38xxx1", RSMU_FC3 },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, rsmu_i2c_id);
@@ -347,8 +347,8 @@ static const struct of_device_id rsmu_i2c_of_match[] = {
 	{ .compatible = "idt,8a34001",  .data = (void *)RSMU_CM },
 	{ .compatible = "idt,82p33810", .data = (void *)RSMU_SABRE },
 	{ .compatible = "idt,82p33811", .data = (void *)RSMU_SABRE },
-	{ .compatible = "idt,8v19n850", .data = (void *)RSMU_SL },
-	{ .compatible = "idt,8v19n851", .data = (void *)RSMU_SL },
+	{ .compatible = "idt,rc38xxx0", .data = (void *)RSMU_FC3 },
+	{ .compatible = "idt,rc38xxx1", .data = (void *)RSMU_FC3 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rsmu_i2c_of_match);
diff --git a/include/linux/mfd/rsmu.h b/include/linux/mfd/rsmu.h
index 0379aa207..b4a90fc81 100644
--- a/include/linux/mfd/rsmu.h
+++ b/include/linux/mfd/rsmu.h
@@ -11,11 +11,11 @@
 #define RSMU_MAX_WRITE_COUNT	(255)
 #define RSMU_MAX_READ_COUNT	(255)
 
-/* The supported devices are ClockMatrix, Sabre and SnowLotus */
+/* The supported devices are ClockMatrix, Sabre and FemtoClock3 */
 enum rsmu_type {
 	RSMU_CM		= 0x34000,
 	RSMU_SABRE	= 0x33810,
-	RSMU_SL		= 0x19850,
+	RSMU_FC3	= 0x38312,
 };
 
 /**
-- 
2.39.2


