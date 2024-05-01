Return-Path: <linux-kernel+bounces-165537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA078B8DB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616371F21714
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF227130ADA;
	Wed,  1 May 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="HvPFpfTk"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2109.outbound.protection.outlook.com [40.92.18.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68565130A68
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579521; cv=fail; b=quJU4H/Smli0sa2JM+nK4n3TOvc50xwaQJf1LnXByo+Kd9JYH5slx7Jhsn+/fWsxjH/LWiU/dducfO8aujwHwZL+4AfXffpomNU2Eq26E1zLzJD4NHXymVkxNrC0TkvZ4fUQFT+Kqs57filfMP7YYlZBwY9mLj+wU4vykhAEH18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579521; c=relaxed/simple;
	bh=XXOmZa9F3s4D/tLC9s8GQ8B2Espcejx9Qgoh+zKPjts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICzDDe1RMt+OqI+H+aufiXggGfHF9DArzSh4sUwUl/8u+RCk+0hLusbXwT1e34w+D2PsAh/3gpnEzGmJJ7Reoa919ij0oSIQm9BZc8Ex6DnWmT5v2dBk640wUGrzG3fl1Uj2aikol+oUK/J20L/YTR+Hu/ADULhcNeRGLzNJss4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=HvPFpfTk; arc=fail smtp.client-ip=40.92.18.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANWlosdplPq3sPcGKyTsmG+cUbi0JYVYUh3fh9ytjkKseuXaQz5/P8r9LvkqBHX1XhEAZZX3AywveAtHX/EPIyhjFZijlRq56Pn1z8ceZlmq80fc123Ex/89Qb4B7LfNhMH4qGtQNwUVHo/0933i1klLOtxQE+W9E8kL/Ga1ljelvVajySxI0RQ6O9wF4jvISmIOga4sV+zrdHhJo0Q5joSmFa1udi4RTSuxZiNekBfCMZSq0TNPtLjQS/3FBGx04woKMDtKA53G4wHWHHNNgs7XNm6L9ufNTobFSxZ9ZGaZq6iyTJBY7Us7W9vbMAXEPQ3nYlvOfaY588OEN4Df+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J00G649Y7XvECg1kmjaJuNbq6mua6ZaDJmrwxIHIEI=;
 b=ImIV29TGDywZ8rpTez0j+YB1Oyv+mwn5EfX2W6M3v89AodJBsIJIfElNkSbH7qNDml4P3aCgFMYJK4+ZG6yNX2dkRLGfoNmXv6XFN4jOBXTNHzrZ6x0mFI0oVzXbwPXW6JlALUIu0Pexvm1sjC1uI+u0THPbiJcX8wRSiKAzXpvzmj0tO7j0tZBw/tM33eIo8EHFhwGlvVNedmGDT0WdErOyfJOYYvZjEsna571c0hFc3RCCDMIXQbL/u57P2fHy0yhpafJPkqwW0wRKDXyowsQCfp3gyEg1i6zD6UJcUbmFTMbvme/UmNhwhDpkyySEtutDgWxOM6AeguWhx/jIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J00G649Y7XvECg1kmjaJuNbq6mua6ZaDJmrwxIHIEI=;
 b=HvPFpfTkThBV5E/kZz9XEAxncGWG1RQOUfSOB5xHTOdOTvvs0bW8bxkhYDvDyHteNC02xhb2hxnpvTZejYv6s0N0x5ylSXf3JcH05HEbpJmRPNV2AzjIKesGiuZnzDr0EBHWt9tz8ER7bysc8h0frcLJOgW5CFyq5O0NRajsLY1aeLuFCW8P2IdKHIzRJh9zdneLZqC57JbnDCOe8op7XPu3nj6OP2KfTT5vSFiaeeDv2wxAVF5hr5eKxg1irVaQoUGlN/ALsbDlHyROlEk4BC/Mu92y5CrkodK2DHK+G3aytKsOcZi5Mn14k+TZn5d4JKXj6RK+TN1Ptlws71RjVQ==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by EA2P220MB1331.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:257::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 16:05:18 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 16:05:18 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd v1 2/2] mfd: rsmu: add FemtoClock3 support
Date: Wed,  1 May 2024 12:04:58 -0400
Message-ID:
 <LV3P220MB12021E4DC88EAF37705EABB4A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501160458.27588-1-lnimi@hotmail.com>
References: <20240501160458.27588-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [VPkSOF4JNcPaatljG4zlpvkiMuSXYbZa]
X-ClientProxiedBy: MN2PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:208:fc::25) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240501160458.27588-3-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|EA2P220MB1331:EE_
X-MS-Office365-Filtering-Correlation-Id: 1048edb1-d20c-4667-4aab-08dc69f87ed0
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	k75mK9vQmIR3borN1cVPCrpXZfFk445RusKe2ibZW0uj7Rd5NSEdUpwQSRivHCkUNnayulodL3UgER0zR4fEsL569YviLZqNR+AoZUQTnKg84d4FVZ8LO9khR8tCbGSlTT46jT1cuaoENm2PNUraskBxuAREGh6uNkMMK9sCcRSrsxde22sJamVsaFOVFXAMFIJ3aAxn8nYMA+eXCMbXc7ZJ7XJv2eZV7MIxBgvKsOQwvmlMxPZVtg0tjjuocNnLACOTpPHJVLJZkh0CmH8r9I3yze63aLOSH652RReqGbyfrbk070j63CarxukKSpqegCr2JpNuu99FNwGuqI+z9hPJ7sNo0otbfSPmQ4EgfuZ5iu2kLn4GDhzfQfMXnOMsnLPxbS4BieObudlEZ7Q6KFjFVyraaoNe6PZA8KKMuHTGjndRs3g8lqj04TgbqcJuhSMFxBwGOhsFqqGBmG/TgD9ACUGCntBdwjmfbRR02NbakMXA6NbK82MNo16poAmDAA1oZob3ntEinEPnlIgrQ9WVrxOyt8Fv8JEEPvdL5V8=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DojdGuzejEri4j0VB+9ceo/x5liV9QiaSy01rVQ/b6L5WpsTLgVKixzoQVL1?=
 =?us-ascii?Q?TCCP3oGR6p7MVUJThaQSO2c/5ky1Cw1rwRSERGYEjIQaRGaanfLToJhyXd8I?=
 =?us-ascii?Q?8coQKoUq2eSlP4Hmzeq0MP/bBivmY5Ou3YAI0p+FBC8SmYPMx7EMNqUFniNU?=
 =?us-ascii?Q?HKJW7bru4JJMv5hhOfSdQo8yShybUkwfvzvm+lN6tvAboiSyvE5BcyK/8uRy?=
 =?us-ascii?Q?lVtqnVf9dlOit2nFuXX3lvgjWwEexReP1i9+5l4YxxZMXDyiUR8QOo1v2nQE?=
 =?us-ascii?Q?Zflmgu9r2dTgKOz9pZo374Yog6w3ME5W36bVZy+RSZSnVMaMCr7fy+s7WF0T?=
 =?us-ascii?Q?55o+5e2VgFqbeM9+8mkHqxY/vm1Njr0ylmI6+P5eXHpbSfcoK6Imwxhw/aWL?=
 =?us-ascii?Q?ZqW8FBDbMMBc/Aaa9hRgm4t+BMYmaJevXjFQQpoPqyb3hmySocOGkC9gDHQZ?=
 =?us-ascii?Q?5rjj9IEXvbUFx6L4POSmVDyJ+7Ak3vpBDczNVyfFJX9MeX4t6R04In3dRds7?=
 =?us-ascii?Q?hOTzMPfTtWVmInLCXsVcYTxLS1KDKCv34XEtxeOUV3UvFYIbeMylJpKoaug+?=
 =?us-ascii?Q?A2Rcw+1EP/qnvMy42V3AJC1zifFgO3PV9rrgVh/WLrNVVV7NufzAwz5A/MrS?=
 =?us-ascii?Q?8Ax34mh2+jMgr4kNRLgtqONb1ZsBPnuqgm5w23ZvHRtcEFkStD1KcAXt7/4W?=
 =?us-ascii?Q?8prL4cc2/Xf8SHMQC5Wb16v4RM2MHc3PmHsXUcwitxgBiH9Pr/30xO1YupzF?=
 =?us-ascii?Q?QeJqFEk2ZK/sKiBubjr8NKoDALbjXexuqs2rlG6Vkb868Bt7YnaM+Q9JxuVL?=
 =?us-ascii?Q?X+ZKx8x0AvgoNMQdbBxrX4+37AroP8FzEEw8+3VkTrzJvqyn0MQ80fZvzNOC?=
 =?us-ascii?Q?dCSQV01sBSUoAg70h7iTLzATLzcBnVdu8BkdiwTXbK/GtfqAesApCdphgpYn?=
 =?us-ascii?Q?wrA5nX9cG4sx03WpxEeqr9MJpsonKRQr1zHR6/eYBkqCZBCileec0Bdjq65d?=
 =?us-ascii?Q?hGbD9yMY3YGKVY6Rb9YOrwwhObcl7vbi0T24oItd0oYIgIEmAhSQ9EMPIpTd?=
 =?us-ascii?Q?7XLktmIKPyWKRbPxXxlq8xGLxp4nSkec3m4nTDWeZRCpt8g9TDE+tVHEVKS4?=
 =?us-ascii?Q?zJF+dixfE/vART8GOQVDEj3bDjV51+APH030oIcW/IBw4TDv3GFFTp4Y0j/v?=
 =?us-ascii?Q?6LJjn8BSNtylJhINnooyOcPn9S/W3HpwhdeKUNmvvwqrFz2Ers4YLdwXano?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1048edb1-d20c-4667-4aab-08dc69f87ed0
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:05:18.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1331

From: Min Li <min.li.xe@renesas.com>

The RENESAS FemtoClock3 Wireless is a high-performance
jitter attenuator, frequency translator, and clock
synthesizer. This patch only adds I2C bus access for
FemtoClock3 through REGMAP.

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


