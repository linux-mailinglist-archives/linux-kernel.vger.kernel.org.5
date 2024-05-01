Return-Path: <linux-kernel+bounces-165585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097CD8B8E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E9BB22E59
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7937318654;
	Wed,  1 May 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Aw0gqetU"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2066.outbound.protection.outlook.com [40.92.40.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8A17C68
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581198; cv=fail; b=J7LdTCyz0KgKAgAVCH307rLzMDAgHKkVr2zFphqquauefZdw5rjdUL8esX9AdxvDGSViWRw8T4bhAkT0hny8AB4Lf4HPDaGLOKKGk/4dPdWfLCo2NSxsTvjKINKg2/DhjNh61Bl7CkkphvfDMKPJqtF4Mv6aQ8ZGROLggBo25kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581198; c=relaxed/simple;
	bh=XXOmZa9F3s4D/tLC9s8GQ8B2Espcejx9Qgoh+zKPjts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nB620LR65kGSsAqS9DUI/u3KmEveEpkNLAqo3GR4dIooOLHICiuqcfsVktxtdoBYyH0pPfAOXTH7a/g2ihBt9xicAbbwKgLpi6mJwq8ig2SLZcoW9t4t//rI9Cf3q8oV4TYzJGoz6vXzId3dgKBYzptSBK0zgj+Qx43fes1b+aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Aw0gqetU; arc=fail smtp.client-ip=40.92.40.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILnsO+a+BW39hTP4aH4fJQTi8jQC7y/cZrJAPF7Dro2SeKGq1fQHX4u685JBIFn7qs6lD8vTyrQecyew1Fvt8ghFNb8NfLAerX4Dk3/i2qdW5Vep1djKY5Ii+s5mbkbFDLSB4c6zHjcTAyAYByGZzUa23iwv9xW8jITJfnu87GMiRjKDNP1S27eKUlhBpHfLgI85YHLHpGmxoEC76/Z/gQNudF5+vqajz5iLOQjVYsEICeYhlW2UwyKMgHBGkZH4POoEvbIinu1nmtau+EIJ+WYJ8dWHT+thoSg30WCLPjcvEUagSqM3ZC1qEjPNzNfEKpqJb4bYtpaAXNFq7Tfhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J00G649Y7XvECg1kmjaJuNbq6mua6ZaDJmrwxIHIEI=;
 b=XpTfINSJsKocbBcc+ZF0ipNvR7+Ngz8Onrg5q9kyF8GedKfSks1R9Qo7z8AROfCVEyIF+16rWtcRq+7kDBT2z9g4KNLJ2eM723Qi1eKnZDd5zWDEnNKMGYuuJ96ikjE2kWaZS3EaB1rmHEMcgtWqz8LZS2iVe/RTPvI8GjwEZBdOwQgCkn500Pft7KdypkraAkiEbljSnFydVD0aO1AXsAhoCuOdJ95+wvmh5jZDWMPLm32XVhLj+AqjzRtnspR8AAF4Z8+cRzNFdUCrTtqc6nFaUOYw2ESHEQ4mXlgxnAO/K8ZztVQ46GhUFeH0Meauy979H85NRgfibo1JQiRnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J00G649Y7XvECg1kmjaJuNbq6mua6ZaDJmrwxIHIEI=;
 b=Aw0gqetUvuci+PU+Vt1+OXISnTsE/PCAOb4D4feaIX4luLnZTkm/PUyCpbJOd2KMjxE9fx3oTMVBlpBMt4X3hsIhlXKexDoKN6SWkdacr/tFjI3z1BzSZvMEtizkq6AY3bKF1JNpiQ6j5ZVRU8EN5APAHkig9jHlYn5gGJtCSqE4qeSg7x23d+4osiG8PvgP/bZHXVK5Q7kzp2Vq95iUihHeKZtgm+tML4LTSjPvtvbmdFkyKDuGoQaRMNOgfGJciGzfPA/LZ6zIgQ09pX4QfZwXpy2bvJZE6yWvE2xlDfhboMKFVO0+eqlgb2LZtWqz1Hxdl4+FD94SjY7NcX9y0Q==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by EA2P220MB1484.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:251::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 16:33:14 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 16:33:14 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd v2 2/2] mfd: rsmu: add FemtoClock3 support
Date: Wed,  1 May 2024 12:32:56 -0400
Message-ID:
 <LV3P220MB120270F8FC18DCCCFD534D82A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501163256.28463-1-lnimi@hotmail.com>
References: <20240501163256.28463-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [tfmBCqiQqYp96HLrxmyMmnvJ5lvrzcRZ]
X-ClientProxiedBy: BL1PR13CA0276.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::11) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240501163256.28463-3-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|EA2P220MB1484:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a2bb0d-ec46-47c5-174f-08dc69fc65f6
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	JOhWKXQTCAxDpoQ6J9unTcc5IdKTde0wsZjohLQILgFe87BMLrvB75zETHC4DfMm4MfC8jm+BOa/+5QT1rdMeYlWo/NO/aOZWjvHEb5YZYNJEn9z79TJaDjCwlm+px6mSdmoE/fn7vGvyY27hd/QWeU3GNpWhd850DHjAmZgIq36E5iOXGopLRB+fWJ7vHko7x2gCRGY4WlH/ht+miwxyed4I2JgrxcdjjZCEAzFaCIjIaQGtpPDyvUnM0E+CDq0hKS3mqVQq8DUSuysctiGWu7ZFfMm7lHepgO01ZyJiY6tRLAm26NVI9yH4nYqlMvc7+7Cy/Z5sGhHPQQS7EC1eNKRO2bsDKpUlbpPugUu1x0BtKAZP2C1iwvpdDfCKPbFx1MkcL54ywhhZtD5cJlNzAYngYr1Ody3LCglEbxd4rl4D/3ZXo109EskKGvCJK05MnLI0kldog8Ra5QlRfN6ACzvvz4XLRPbNXo4yUA5IkfDBKioubsuT3HefuEaoXa0FZhLW2BtZCAysGAt50fnwNYUFd8lbaxS+52SD1xLOGk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3uPZ6nOmC18Bp1NDbvvC+vkGhB3VewJAsVDqtJyP3iq20Vg/nVWKBP/iLD+o?=
 =?us-ascii?Q?7BSEuKxqh3ite/buhGdq3t4LNAxk7v0ec7kKXvLvJEY2YC3zkhra7mF8Eyaq?=
 =?us-ascii?Q?dKQWopMK+k+t9RPC8bDg1tmLKn5rekhUrNIvd9wdtQxpttOF8R30HMcN/4Qi?=
 =?us-ascii?Q?FWHJIAOFuOMizDpq+HZb9m37iwo0hUkhqDXjx9fW3E4NNU175pHvc56fJ6XL?=
 =?us-ascii?Q?Qs9iqVX5FjJI+A1go+RQmFHS4JHIkasxDCAV+OXhRe5zz2yGpN2AQ/00Kkn5?=
 =?us-ascii?Q?RHX5YUpeLW+jjlTAFUl5Vm7IXg1OTzJR6AFZS4pTOCi443tIZipRghmUYxAy?=
 =?us-ascii?Q?bnEI09dUqU0YOI+4Wk2eSpt3JOhkvAyCN6WgVesHMfwu1clYasWT9X6lJu49?=
 =?us-ascii?Q?uWliC4m5+fEUWVRUimcPMm9cNY5SmWhq56dTi8owcEK1j/waF3VyPsxktIW/?=
 =?us-ascii?Q?At91HJn3ppejbv0dLXkx3STYHMzQl6faKGt1ZTkv155FDKca3sYOMQB9MaCS?=
 =?us-ascii?Q?7iR5AQjAgyWScyeaiEEjc1gw9YbgZRgmjJS1WvHoF4SwILKH8MX/gpBm5Erg?=
 =?us-ascii?Q?qVJC+FuHGpwaN51DLHPTPmBkY8D0DE0HClhytYDw/iEGSvQmHdCplOU9s//3?=
 =?us-ascii?Q?Vvc39tmm4Pl0M5pIo9DkKD5cC5iIlNDqBazcv/A3wvzmwk3udiuf5hZDbME7?=
 =?us-ascii?Q?E3doopsOGHv3nWhjzqNHBnWWeJ/dZDtuJa0R7l+u9caXMPlTE86ZPQawWLFz?=
 =?us-ascii?Q?HiQV+DgnwznnHF/9F+28PY5znE0cnSBUItp+kpuKADys8EnSMXLr7kdAmA4l?=
 =?us-ascii?Q?FNH8JR42/WMvQ6yAfiCD4RhTSjcdi3NniD6eSDPxCSipH1t+AaR75WOXD1cd?=
 =?us-ascii?Q?pVA79wL3N/CZfbT9OiwXj39vtqtkdYoV2z0sLXh0jPAVon+464NA1QLo29ec?=
 =?us-ascii?Q?sPn6iwdM6CDVEuW5RChi68EOz1aUDLaTD8DIuxQ93YfYU+PZZo3lOjEjU/i6?=
 =?us-ascii?Q?t2kLRMOjP5vyjcYq6yyNF30Iwni5Y4NhiKJAYibQoMhrFLgfpf0u9zPUZMdC?=
 =?us-ascii?Q?Lbm0kOtOYjA2IJICkCQf76yxtY/10MwYYQOvPkbFZxylRXflvS4Aa/E+xPhT?=
 =?us-ascii?Q?9cCaipdrJqHRngXLHMZ8/jJ8/HR8XBPkwbUARxow4eazd/zcdfEqNs6+sTI+?=
 =?us-ascii?Q?Dd41ThMJK9UmJ/EbOzqU6JBLwzT+DA20Jp78YQmvnLqdt3E/LKEC7xGMH/8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a2bb0d-ec46-47c5-174f-08dc69fc65f6
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:33:14.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1484

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


