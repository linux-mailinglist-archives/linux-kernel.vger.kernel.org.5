Return-Path: <linux-kernel+bounces-141432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D6B8A1E26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB1E28B12D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A7E3D3A5;
	Thu, 11 Apr 2024 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ENo0QoJh"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2021.outbound.protection.outlook.com [40.92.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C43CF40
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857981; cv=fail; b=DHpUC5a2cYWn2zOhfN7HIT486k7F+BtzC2iMV9e1zcquNSZQ2PNZb7iB7NZ0O4ci6Wovp+g4yg8UhaSspBndhqJ66575Pm9FpU29qP6tZECV1fG6uTQPJqct71KbtZdHwJeqYMBs9xj2U9iV7m40EnTnlSd6uzwgSdSYA9VVlOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857981; c=relaxed/simple;
	bh=oiOlpeQ8+pKut2TV6xpH0LS+1v75EqCt50JjtLV3MxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V5NP4TiB6awJpue/fSF9ZQa+Gx7t3X6SQweBBoI9ZiAgxawNpo0+BOcsLCVwAwFn/LM92sSAK8+W4HKxKFWQIGTK8jVtSRMvmhgRnkttfZHMFnL/sKxZWc4lt/wyEgc+ST/CaIMgMtEAA9rccldFN0Aok3JIwbPbhNnlyQPgsFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ENo0QoJh; arc=fail smtp.client-ip=40.92.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFn+jPaLw2sN9DDBmnyCVDZKAgVAVF1l735vppQRJ+ICaNpm0SBzDoS38041hzlMLp/IUWuit3qVgsoIBnl9LLXb8vvIQH+HsQ2i5mETeIoWX/fRzgo48BlwWIeuJTHLPJ4fcfONofXdBh682mIGbNYbM/TTP9fZAZTXLQP1lb82AE75tZIMGVFPwAe0SnNJCMf/qIaNCSVRRhQLofp3niv3QsUg0LF8z9arNglawxKpGnSlbjGmxEzqkTqe9+jKzxU2wrz5qQkRYj2fht2fWvCzR7NgW0SXMhice25mUdwkYlIoGhFEj3PwD9D1lpqzoV/mE9Fy3fRNDFODQsD5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJOCqS/AvEeq91GY1q5dIHbRScPtPDOQhbsNbWeuIzQ=;
 b=BbK1BsgEZ0Ty70XlHdP+RaCVUrhjHJ02sChho6m0EjI6xwCJwDgU1/m247VQa5GSr7d0V3jkRczB+0whvaI7HyeooYvFrwL1T7NY9CI9drvrhbQVrY6Qe0f9JtP+b4cm5Ewy09cTsQeWV0o6iwqBEDPYQRPzE1CDB4G04oFcY1r1kEXfKJdaJU9bePLSlpDI0WUPRpEbmVgdKrGITvN8i3jn+zjXc2tx90Eks7bzNe+JrKJgfbWNf74DsZZT/IZHqljR0Fw3RgWq8jfGQM0JcKjYCxt3CtokJt6aqzfVR9n6sXSkj5u8Oj4zsY07UClrM0BlgkIPcUEZCmnOjQ+MLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJOCqS/AvEeq91GY1q5dIHbRScPtPDOQhbsNbWeuIzQ=;
 b=ENo0QoJhBFv0ttO4jYwUpG/GJ28EVd2fTVZTUqK4JRZQY6fg5/elEvsxdXYJRwvw7wFok+5Hn0bHeXr3Q9zrVwD4kRnDJx1O3yy9SXEitGcgNZ2tVjHbIdBBvF/lhs7BJQ3BdCb7R0UPgIgNRrQLU7HH32n3rAKSZWY9wmz2nS/0OXF8C1WU9vlkuv/Ii+j8OPnCsQYPe1aCGGPmh6qWc2BCTs7Ak6EobmANw4ACe0sykehf5ObPk131v8YXjX1G4EwB1tmyzvJ5NIAz92Dzp18gQom5miuv+5KoS2xyFnsEw3NM9FNx+xjSBn27LFBYjJNH4Ccnkj7RjWAKT9wY0Q==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by LV3P220MB1055.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 17:52:58 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 17:52:58 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd v1 2/2] mfd: rsmu: add FemtoClock3 support
Date: Thu, 11 Apr 2024 13:52:40 -0400
Message-ID:
 <LV3P220MB12025D3DF84F591EC0A9262FA0052@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <53efc0ac491055cedbef156b3c3410fa5342e637.1712857691.git.lnimi@hotmail.com>
References: <53efc0ac491055cedbef156b3c3410fa5342e637.1712857691.git.lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [593r5wHdYYdXOdNfMe4JZIKf38Hrze8L]
X-ClientProxiedBy: YQBPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::17) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID:
 <b45c947b06a4d902ec482ea07ab4d764df984e99.1712857691.git.lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|LV3P220MB1055:EE_
X-MS-Office365-Filtering-Correlation-Id: edb1fefe-fcac-4f76-7f34-08dc5a5038de
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oU9bA0i3PYAwRrV2dcS8tr9i20MlQskMQp8oYk1AGIMYZRJxuIdHjccw8PPHOn/YvE6GS894vbpQRJKHlm/GVOsPNTTkdWen5nVjValuTCo7xM1I2v9zUy2+gGHhmNVlhugs1uA+b5MFAYszmixTxMMjHrlH4+nCcPnS2ZvQQAVtc2l0B0nt4tXWYbO97//+O3h6yaU8inds8KvJJuIrIJttNl9b1osMZIjVzISO18mmDXeDtHdTb7cq9CFfvoYDcYQMfZyGn9oDv87uXXQODWTj+iCvtZ2A770OCmIW1P8g7hXSk2wHpMrEB8QmnO6lWRJ6+e5JgO16qPreD+6+Gn68sa5EsLGsvtTKd9SRBIZzUJ0vriry/hVXx2fcQ2LhI80bNOWqtK33vyamRO9KAyeWq555BMOYAZtkCLviY6IrYQeNxawvXyjvzhJrfYtwhhSfhs7M0PYz+1ZVnvQ3lpU3AOKkX244FKZmUpLsVcLoVEDn2ZqlApS2ju22ejVk3JIKRlwr4QAE0KkGj2l3gh19SKEpZEUPeeKY3dAoavo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ptjBt9XwfHC4xDZyug6Z90x5lt5irt2mXP42fgJ/TGDx4gVZnb8XIZ89b98W?=
 =?us-ascii?Q?gUp1kqvzPvPlYVbxJwBqv8rsHhWPdsWHlkj1LiyfjAhAy1FyQatuGKSuu04E?=
 =?us-ascii?Q?Rlj8OComIwACMUs4T5sw3Qmv/KNECWtnDJ+wT1j+jF3uUfAcHSsWiJjQ6bA1?=
 =?us-ascii?Q?Cy3U0a32jOBdXPF0uvlSz5eZMoEMLjowiJvDiZCOTQuK4SmonAq+RileoxFU?=
 =?us-ascii?Q?EE1jWCvyLMa6EPBQ08PEVr3JIGBgE96SBw19l/ZVgCgvUylDL0nphHpaCiZJ?=
 =?us-ascii?Q?GkWBZYoKCzU60zrXXCF5STUBw1AVHpc9hYlThiWJYMQ4Fgi58roju9KbXsLt?=
 =?us-ascii?Q?vjoGeotavAJ6Twr38eRhqVAT+zlQ/FpKR/hWE+hPHbXErY6SD84JXVP3Lmpt?=
 =?us-ascii?Q?by+UddkCm/330qXTiz8oB+bzCwlguYWSrX6j0Eiq1KmmDtB4t5mmO3Hgl2Sc?=
 =?us-ascii?Q?OXU5zpYKPy1kSjjveIiYHr5To+y7Hw19j+cowVPdEHn9wH+yXA5TCTFFlgk/?=
 =?us-ascii?Q?IFwDSSpAMbX8gIdEh9qxjyX7cdIUOFTUlu3h8pC79j9kn2/Q+1Tu9CG/aNhA?=
 =?us-ascii?Q?w0JG0/j5ORLCmOZuWpzg5H749MwS2sLc+1zvhZyltXc3ojGR/u4vVbWbZipv?=
 =?us-ascii?Q?rpC0AXoaZLTIe28O8Pvpb+XK1BiN4GqlD/wpKH+zTitC0sW8R0GAHjRsBxfg?=
 =?us-ascii?Q?vta9r5CXgdbHuBZnkEwZgWNxNapoSzkUaG7zc7tN13+LiMg1XvWDy2PhGuf6?=
 =?us-ascii?Q?RGN3dXyTo42r7Z1bqp6mCycqInOcao4rRrUgSyvNJcYNCOeYC6WsSAAUYh3b?=
 =?us-ascii?Q?IY1MP/SeGLe4VUeohnu1DOxvJeKdKFLaM3Wrob/2U2Gp6MD3A2wTRk5djEaw?=
 =?us-ascii?Q?q4KCMk5l9ShFAAxsmApUQ3Dp73pYy5Nd6Dl4t5OZohTTkjsOtL+DwAtLbij+?=
 =?us-ascii?Q?jyMiD/UhkNjXI/aIez667D4UfI32lS1r5tCP9K5AHV99fJMO7Ay6DyhPfr8c?=
 =?us-ascii?Q?AC/14/W/M/YdXD82MZHPPkLXhRLEUPDXkswLYp3E+rHRPS3AgCjq6egkWi4G?=
 =?us-ascii?Q?aKd28UWZDawU0T1QmVaznoOgJaOlqI238n/wRmz9kTEgybBSXQp5itO+2USk?=
 =?us-ascii?Q?3L2axUX2TYf+YOncW1661U9eGPtaEOXQOL+PAsBa1EIlWNPraSZIZCeFl51G?=
 =?us-ascii?Q?gfC7diX0Z2OXiz3rnxP9Q+iF5aoP9CPBwHzyKQw6++oye/wIUQtM7tKZs6c?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: edb1fefe-fcac-4f76-7f34-08dc5a5038de
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:52:58.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P220MB1055

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


