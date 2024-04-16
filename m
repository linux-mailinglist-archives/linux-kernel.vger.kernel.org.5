Return-Path: <linux-kernel+bounces-147079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8048A6F31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45512847C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B24F12F5BE;
	Tue, 16 Apr 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="N3seVFP2"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2083.outbound.protection.outlook.com [40.92.23.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBBE12F5B7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279648; cv=fail; b=NEhnE4QCYtgGQHmayMvXbBM71wYvgBP6LefU3P+tQD6lKXBRvC6t3+Z8kRenlhCRM/Kd5H0XL5Sx4CmIuUp29yh4fm1rEd0JFuW3G5moXr/wLlyyH1kAyP4AWnfKCMfgOVbb7FwLZi2vxgq97D1QEaGM7C6MOtzET2z7PKBnMLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279648; c=relaxed/simple;
	bh=XXOmZa9F3s4D/tLC9s8GQ8B2Espcejx9Qgoh+zKPjts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKD5dMYRZ7YcELN7trhOoW9F2Yxq1S6n+Qh2qAZAHoMt8VmfYl4OBFxIZ67G7HZPpuRYWCaCy0yjCvJI+MYDvgWGzwLhbarZO1Hl8KGtk1zAezKE8eCrgEkBeTNuB4uuVAYRd7LlW/haqGBNxj2aHljp5QrWFkt7altLIkHsMXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=N3seVFP2; arc=fail smtp.client-ip=40.92.23.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO+HkvcqBvfvNqaiCfNJNdTbNQY2rzAq9GPVsP6ilwqOhTa3Do44TRqMrdaFbyuZsPlODbDEugK7CQUzu3sFwI0KOTx8NIIPkxGefgOiNxPYyNZHzWbE9efT6AErmUQJRG6R6LyTqSj9L+/tO0K7IN43y4xH29CDpdXtpaMNM9GxJxUSctlDWmsN2flxtvZ7I6+k3EbeTusyZ4eP8UhTEYq0W6+HwgPF38VOZk4aCjJcpLfWa4Zg6y5Nj7nsxwzRW8ceUYD2DO5g5a67Pt5t+YAFrp68f8mxCdP9FNjSxAkxKM4GOQuLtdAvtQRYUti5RWzHGAmPhi2Uh/9n5DJyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J00G649Y7XvECg1kmjaJuNbq6mua6ZaDJmrwxIHIEI=;
 b=gKSmaga9Db+zqNXXKXn2x+8hnMksxglfIjevUbw4D8tNvkCFHGvjvZiLLogOWyW3yduxqGHxQVqZf+n+a2BAitZIndKPAn5ZGnlLliS+rbbR4Wtqb1Okyxy3zYUr3+83pnfkXKq0tHgmidWUnHzInTdU/Vc5xnVBHv7ZwHb+lVyY0yC/+qJ/vmajaugVkwaf9as3mruwmxTOoFrLAKIDazSI2en2YzzM6TTET04CGF/1nodoun+8Wae9OvDi00iJWNTnitlju2fXfr/gJAUXp8x34oQDoHuIIot6uUhdJ7cZ8gaSOa69rfEMJYU3nwGSdUP8T/kdEyPYSXlqhKhdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J00G649Y7XvECg1kmjaJuNbq6mua6ZaDJmrwxIHIEI=;
 b=N3seVFP2LNtXOjmBX30YMaXryorHLamqVRP/WMUgUUrkj7c3/4FXHTPCR4oVyGxtBX0iDQMFqk0QD138EnzfMhWafbhLQy3ZhmtL9z12EoVKFxPqvL3ALc1FWjuup1ON+azTbSQSwrnwDGF9rOash+MSgRCijP0Fke6PWIybPWq01jom651ZTXwfycQI6+TgdH7N4vkPCdNa7A9WJMdsxZBEDnCGSLqgbW0kN+CLj0luI9m++57CzbKwKOZlENLIs+KJlZGsUcnPX2tpUaUWOpa/hMWbC+zpV7U8OVUGS1I+VE3g0DEJu4sVBKncr8fwxhhOyZ6CStBDgQEN+HYjDg==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by LV3P220MB1504.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 16 Apr
 2024 15:00:40 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:00:38 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd v1 2/2] mfd: rsmu: add FemtoClock3 support
Date: Tue, 16 Apr 2024 11:00:20 -0400
Message-ID:
 <LV3P220MB120294420A8AD3E731690725A0082@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240416150020.9898-1-lnimi@hotmail.com>
References: <20240416150020.9898-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [fZoNp9Z/WhDXjcGmyoGP5V6b0Q5YiXNb]
X-ClientProxiedBy: QB1P288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::40) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240416150020.9898-3-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|LV3P220MB1504:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fb01a8-8e8c-46e6-de1a-08dc5e25fa4a
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TUN1p22Wti5Ft1RyVx4SkPqXFR79QcFc+AN+nkV0hu8yYAbEME76LoS/DHo/7XbKXmZ1G6GYGSJ+pvMLVAilv9wTh5qHNGWGazjbH3oUXKnskpRsSVYU7fDtXY6bvhP3AJuNwuZgP6QxlAWKkUYUsJNjTW4SI2zRu/HxE86dMK4Xxwlc+yUOKWYn06fm9svYoM0EenIFAnGcZ14aBo57nSXYeUcy3mkwbXj8SMdn85910OSBGc4m1m1w6HDn0wiESMMu/+va0SdghOeCl6924rPGD9wnd0f6GW/DzD0xfHmZJ/MR94SH/8L3MTgzhrefyTBQ4PhbjmOOXRkXzkxlTHrbJ9TuZvhR5/+Qu9nWmzhH+pmRjk3txcnFHwRYOvaFm7XM7spegpinF8w0ITIvhrr8oEBIRn6LAByzDk/araUhA6ynzBpzWabO/bXYcgdtVbOSwkU5SV+0syGzl8PW93XXBtVfgBPK2gcgsTyJv2avy2/pMOjipziGLGVS+Bu6UFPNAlIvcypFocv3E4BhjmRrRFmnXU6lTrlhcz8nMu773XW+Df9Rr0cnYcd+FlpdImRbSNBhiuWc/wOl5MfB1gaX96ecPGjkTIp2PdmLf7mN4Xkl/40M+bvjAsCJR4aJHe+45vc9j4FCCjntqBVmLwlViONbE8xDhgkzSSefwZNpCt28TCpSdIsYaZwiY+HD8604SSZqGfDz1Bln5yLK6aZVGwadwTdQzlMxnAZq6u/lM2n6D8C9whrG0LYEj83DuCNUDwJFdq5Du+gwQaxylS3S39mCZM/VTo=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1xE3zfWK1nuM2mZJ2fX3kFWieoFbEs+hLoF6EcgXd7aMk+KfutQn/KgbPg4S3jrMyzmq58PMqcMfJWQi+39RRTqP2JcvK+/2YZO/8UdFummTIU0SqYEufpGu+DBnArYluPVmPF5TFBbgauHIT9sJcU/4RHIyBqC7DgwmMVKKFu7q3YtOxpD9gHbIORj9CL16W3UZ+iKlW9hFFFTjAXpMbR29+RKqth03M5uB82f6RvKoox7+MkQQKH7ExkPBy29fk0ZDZon1OGDWzbiOZLn1KgNO1u3nlkkPm7k4mP/bC2b3M9Vm825oWVg0HMh2ECzzllmFLEhVVzNyNvwsCEeVyNL5D7GIkv5rBSQmE04C3TKRrbOWyTV2IOryD4e/PlZEa1hsluGn+jyhvWaxml4XuPDo4wfloI0rImbDyeKbYSKwxGZfCH/GHN/STz8jNP0u7Q+a151641hOIQKFYT1FsbCdwCuUSC3euvIp9aZJiqqZZxVNbMnE4FSYyc+yACh0gTeT31UEzc0vg18YnW2hn9JmrHRw1JBHgWznxgI/9/k=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?abcSWqeIoQuOaPLVpEO48QHUbjq2Nj8WsXmGZ4d23v8vDMAVcWLS1zSxAckY?=
 =?us-ascii?Q?cwA/rA/cDwoCDi8eHx5WzFEsmTupVjR4MxGwsincQP3KNWNsLfgAHYvbimn6?=
 =?us-ascii?Q?3WLtk2FiUob/A4VykhpAH20mNW9He+bXYTVpdhd6kbLH/ob6xYeql9tNkOUq?=
 =?us-ascii?Q?pK34Jl0Um/2x4nHK5YhkSnW+nLtlSOvK688runQCW7mkh5O+nzDoDebfv1mR?=
 =?us-ascii?Q?FqjVtB7mZqJoMzeQaVxL9Suwrlh3YR8YFbWV06GY2DYm2UFe8HJh6pJtWbM9?=
 =?us-ascii?Q?9QH31NpENnSvrox66anxomotA82CtHBkCE3FJHnmU6+gyz8AV9MBa5z5wRj/?=
 =?us-ascii?Q?gPK8X0pzYO3elW7bEJfDbRVV4BEZUDHU1wib9WFu2LdxHAexotKRk2mK+vAx?=
 =?us-ascii?Q?fYrmZTDLkg16+tIvCm8opzVgbpAbgUXyIWp9MEhS1stXsmyD6Yht7FWMJshO?=
 =?us-ascii?Q?KVYrKRw10oKfhbPxkkARgPN4IcYKr8dRQP4lYQBdnUuWD+luFVgShiZdmHzA?=
 =?us-ascii?Q?fNUCpSfnpTqkRCsChlaekftjZPHpt4GFSujBazPa8+ajQJPww7Lh+CZ+M6hE?=
 =?us-ascii?Q?A2i/fNWhaD8T5CZHa4vOkmuN24i/QcOQQ+7fOqC1O/7V798fctUR3FE+ptlr?=
 =?us-ascii?Q?ESLOX4B4F3q3CGzpgcsmbEkL+3H3b4+ZEz2y1S3EusIjyHmW1BIJ+Xg+vvV+?=
 =?us-ascii?Q?3pXQcw49zlpL3sFRUtPC0u6eRA8uDefD+9Yn3WhjuZKJ3zuppn8uv/kUKAGA?=
 =?us-ascii?Q?S6K2aDEx1tik5XdVlaLnP+4CwrDQw1b85dow6fBI4TXUXWGzScOI3z81Hp2D?=
 =?us-ascii?Q?YvOlEQaumQLERewx9IAzHTeZMKusq0bRK1jhEJcLICUlSuHO36XEqHG7TAVt?=
 =?us-ascii?Q?7+XJ/gbwLjUj/qtDUzpSUbQk61/8pwDGZK7FqIjOfP40AQvvz0juaP1sKuXh?=
 =?us-ascii?Q?1qBCeL3sA6weA1lNHt2EgKviDcNGCMMjjZOxPLUfaRr/PlCeQZmNZJhY/8vj?=
 =?us-ascii?Q?vVps3e0sNfUOdtwe2voxnDylJbFbFQUS7lLJ4Zv4vv+SqOCqW+WPVWJhFeLK?=
 =?us-ascii?Q?QnyWb/XL0+VKhTYabUsbcAzJLFx4g+tcR9/fhgrpzKMM+UCixaOT3uK2CVBi?=
 =?us-ascii?Q?6QRz3Ge9AzInI44NMpiML4pVdOqddGvc0UzddHwPBkr3GTVqkb0JMjUdvApq?=
 =?us-ascii?Q?GDT72jqvz+AX+3y8583lLT1/4vPXQm8piL5woBI7Sefj2N/B5xFDdVXbT+w?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fb01a8-8e8c-46e6-de1a-08dc5e25fa4a
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:00:38.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P220MB1504

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


