Return-Path: <linux-kernel+bounces-130371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C0897825
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6F67B38822
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C219F156661;
	Wed,  3 Apr 2024 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="MnsVUK80"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2052.outbound.protection.outlook.com [40.92.23.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819915358A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165048; cv=fail; b=R4EDbtTsvdMOQjCQ9rIZcOzlcD6+Ffk396MryrXLYWBc8t37BK3ZK8JHJ60WTBAKrZ09z7jl559BVcuWz/sOXT2RKSJYtn+PrqnG7a6Ch5hmEaj69eG0qZ9rg0GuhCAX+WqG/URPnndEO0SGu/sRdrbSKggRrBIxZ5u6CMhQagw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165048; c=relaxed/simple;
	bh=tC4vYz/7R9389WbN0/0dmuaEa6f3TDq00gicaHYT8tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pE61vHE3FbHwWbnV8Hq+4HDX4pmBkKfu8dZI/42jYN/R5bAwndJQf5O2tpWq70TgFFAwBt+jsUF8f/ayOsRbaNRLYpDNdEYvYPm5s1JihLfLNoOvyD8brVRzG4VdJoD1e6ibXzKCTn7yeT4UfaoCs15khbu67n2+lKbW6+Pezjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=MnsVUK80; arc=fail smtp.client-ip=40.92.23.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/LPsJXrMUsxgPjM9PIAw2Eo/+85liYT4G6NNny8qq2MCZV2rZpmkjegm6p1p/LMFdBbOdIBE/uzVsR3TWLqycWByh01qK72lQlml6HCyOpEHK0myYwid66pJ0Z8ZAs68YCcqzglP6Sht6AZEHT/N7c5VTcAxj8ckEtfSai6bXGBlfIk/WRlD7wo9e1avlGtWnRA5ZsmxnDhv7znSBwtisCNQ7qDy6axoxHTXQITsC7Qyhz32o/pO9nEZRkYm2Y1BlLt5f4Lp/PNHWi3qjwqeLA3v2RxU+7p6r0QyiVTLmzr8GAME2xxyTUgHQrdwEDu5BT/bqaMV0T9d4Hca2WWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noLrXu9xBI8xepZCb9I2SSIlyL4AHRWIbFVp2PsAGXw=;
 b=OHIf7Hu7Ny6Y9p3kiAPiKk994VYoWRA7OsWBHoCvF2yiPcgVJSPVwSBr1jQPuVeC6lIlnYPHIY3M1aA2+Ev6DTheugDWMsrSbyky900jRd4vmFgISPdZ30yiWy4TsTBNcBUnL+TyqloBo+iBeJsIcNn/PhhPVa4RfdH8MX4qgYyKL2GIjiriSxOAu/h4W+hybGVoJ2uidYE+/nfXtfggpHRgNRzpi7zcdLPA21Rohx3lTSif9wEIIcWFxPrvicUnRjWLbdn8wEFQZzJ+pD7KUIyHn3dvwaAk68vUxiczCatxDMU6qxISuUahRQYLHtVs+Evw2dCWYSAI1Rv8iMsyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noLrXu9xBI8xepZCb9I2SSIlyL4AHRWIbFVp2PsAGXw=;
 b=MnsVUK80FQ/V7ufR82dAzsqrU63UjcIgM4g6YUWPuzRH84kKzmQTuC/iQylD+Du1pf2RcN04r+KtGS8KGxfT+PFnzV6eiLGRS0tDt6IctsVYSSA1dHxoYvqverF9Q48WS3trwYumhgQGXJQt6XxomlHQa1aGoooA4l38H3ks4GsRXE/WuwlPhvuWdLvBZpE9w0a2UnI8Ldz+xrJb0/uyaJROPwGhbfYT0JBTVyKUN07sR3tfEZzGt3ZzG8o5V+xFx4MtPzCN7j2zjJDzlvkxDFDCuZXVTSk7h/cETe/Vz0GjDfP0ul5+OLI0jjjOPlG3kpF1Vbdqx30MvWRmK7SKvg==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by LV3P220MB1248.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 17:24:05 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 17:24:05 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd 2/2] mfd: rsmu: add FemtoClock3 support
Date: Wed,  3 Apr 2024 13:23:42 -0400
Message-ID:
 <LV3P220MB12026D0B7F12C63FFBF3BDF9A03D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403172342.4056-1-lnimi@hotmail.com>
References: <20240403172342.4056-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [EviEojeC6tfAp6raGHtSqX9X25sA0npa]
X-ClientProxiedBy: YQBPR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::29) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240403172342.4056-2-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|LV3P220MB1248:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cae1ab2-d8e1-4732-dab6-08dc5402dc8d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0aTt5LQ/HB3VKtBKkC8xzxemrJQR4ugiaoMWLEqGNpIQ+i2QvnwREeXfAxjAWFiXBkDUWjzoXUGZp++Yqt/OBkYeQLTAEFHS3O0iUZlLGvjD9hPpNn9kxV/CJDidzA4KvdqF5Yu3vQk++g0MDhwXQfTlp6H7gw0SsQb9IC2qz5wNkeJTVoXedmGduaqrWkrAh/d5WYL1dmN1logxekm13B7NO+iliEmogwS2/2eAMu80x17TTHPcBJiWLEL34otVIYZXcCrdjWq9dEt3U8HpoGtKcQBYzbq+DlHMzoq+cq/IuJ119Lury5q099TDYPfh/onwhOGeQi3Q9tnzPjWJXFNxvUraaFQugNMncYBtj8hJ7cA2i2YLR0nap41wPRPERqtTbZSqczd+yjP8Mop5Yrsc0Fp2VsCGtrQeMu53Ctlmq4JZ+xQguvyZpDutOSE8uKWwCKtB1yKVFsfJqqfc/lRGq/JIVeEwI/tJMwkxMiwRGyO34S0T3InS8LqhVYqhjfmYmbZiXiIoaKQTScAvSrkMRzKbg0g3AkNdoOEMbCo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lj2EBGUu8HVOmli5cXAzRxSqgKSyB7YwiqtaI0OnyhLFe1LjpoP9QvA5HTPI?=
 =?us-ascii?Q?woeylbxFnefB08n+UYpu60FH7R7SXkHcBWBBkSViG+YMuJBVSg0hYtywThkQ?=
 =?us-ascii?Q?0uG31xy2o3umF9MXIQ+oqaZ7GzfKfjgQpnoDqKZILoFHw9IbDU0ggzg0aUDs?=
 =?us-ascii?Q?AQeNvJ8O1m8dSXD9HY2U3bgY77jAiPNxB7RPKnxUzRlwmjhEJZOpJOcQt4+R?=
 =?us-ascii?Q?OpxYr59iy79qKTkhU6EEDIRC/a11NZ0rERWAAWT214m70dPFFYg+0C71XpdN?=
 =?us-ascii?Q?khxY6z0RLtr0QwA4X7ZrmrIQNaxUPdWMbe5zJN+aLBsIG8NS+neLdUirkhRS?=
 =?us-ascii?Q?iH3kezC37UBJlgRlPcY7T+qpFXSRKGvAtTw5r3/1USZG2v5gvkPWFpU75s94?=
 =?us-ascii?Q?9mcjqH0QIiPkKkvIq3491/SvcSYyF/WdcmSjcRBg2B/eM4DquPsGrWFtLBYl?=
 =?us-ascii?Q?oQ8xxWw5EuUzF5h+n+hoL7dFPF/IjfuRFL+/IpfpMX6msv9gPi5zvUmplG8b?=
 =?us-ascii?Q?xXg2MTZRNLi6YYwwmT3IJjz8KaEdbMN2bEf9kUdIqQx2MzY3zU+45DeljdmM?=
 =?us-ascii?Q?ZPzbKqVjTU+2RRBhOKczl/4D/M7Lotun/JplhX9SLf1++H+U/o1KE+MP+Ebb?=
 =?us-ascii?Q?+FhUZmJf3oXrCzVaVAZnLP+Zaq6oxHfUjZen+5HyjSQtCt6oBFx90LUT5190?=
 =?us-ascii?Q?PXXBh38Mj9GA8G7XVWhCnwHm3Af+QoK+Y0+nbLVqJldhdFZh9qVZYuAc6U7d?=
 =?us-ascii?Q?dRPae2es8/mVWkRc+sw9mC+pQJ3KhVGxvas0y5w2jte09b5Rsk08JEz+xhhU?=
 =?us-ascii?Q?9/OEbYZH3iIX+wwj5/YYcapol75hiE66UDed4plDj6ukaaqKiEYyplR/0Yu8?=
 =?us-ascii?Q?N380AVX+/U9g0N58F9OMCHE6AfOM7lXHKgYaTi2mRht0lvWqSEYmFtubiASX?=
 =?us-ascii?Q?z425CPbV6e7PeViCfZjhIFyNdOCCY+PzZIms09d5ogwxYvMBTXxx3iydi8HV?=
 =?us-ascii?Q?be8L/hIOu/dMGW6tKl9wfIWmqmep1qB9ZL9tX8WkNH1OniBb0PfbEbs+aKKa?=
 =?us-ascii?Q?E9QPrCPji1cS6BRB59Lt23ocseqlVPyPmlQSkWwJeuenDYAeoTu+iVni5pNs?=
 =?us-ascii?Q?xZrqYbFjmWuBEO1u1a8n3VUUkgPtmEKgeT6j79IJV6ApzJgXFwg+/BXX9czV?=
 =?us-ascii?Q?L9IIkrnqxI9CYdSuqBW2Fmd+t3aBK2i5srZuwGDSG4lVfrQDPNBicWnsWkc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cae1ab2-d8e1-4732-dab6-08dc5402dc8d
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 17:24:04.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P220MB1248

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
index 40fdad01c..9d21ab8cb 100644
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


