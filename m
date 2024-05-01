Return-Path: <linux-kernel+bounces-165583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E32A8B8E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047C01F21CAC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F1114285;
	Wed,  1 May 2024 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="bvu6entD"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2082.outbound.protection.outlook.com [40.92.18.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F37D52F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581193; cv=fail; b=KE87MxeFPdw2Ep1svbyZV+M1+Rjv/ktVnE9rWrhfnPhJWLFM/Ppa+kKN6TJDQqcoedPafIBKxHaa6tJEv4E/yZNEbwwZmNNTNHSbGxz9A4awEBNUqcqph9IQIXIUwKaW02G2SbjOvIrD6G99LshwSd6AJmmAQIbz0Tg9B8c/W94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581193; c=relaxed/simple;
	bh=GqtEhx8JNb9I6etgafa3giSTj1G4TVcITf3/DUKCsQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gSVx5SZpDECqZKTIGOqs6njpKBcR2qXhliKq6snnskx+szgU4GLoUj3ivs24ULuN8oUwk9LyGZXks1UxRH+IrsEejd6hjHIBe4gWVsppztTMvTuZwwb6QCVcRUxcmoOAtPGcMd9o8+pmNOgxcpwQEcL63Vm0jXBvMwyAdX0lhfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=bvu6entD; arc=fail smtp.client-ip=40.92.18.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChCMno2LEGxYPIS3ZQoH+tzjD7nSWWIS57g+eTCUcv+GZVHzJic6BqOtp7PP8sUpHmG4K726RFtlTrosZqY8yzQh6P7ufMN0sfcLntRe69VVhbg6EJg/BwUB3QM9u/8tYDPF0VxtBa07EjMlpz8fzWjg2pjr7sJNw96Hns6e6ZT5wNOgDW3lyW//iGdFgpVU0jmw6S6LCm0xgBHLpU/TsaPYBXjKx0yhhslpMaNOSF4c/e0+OeYnj+KELIEjWfxwv3q5mLQB22ZyZgQFlMeUNLLStSrtIG8GQyaKcrb5EfKelHn6cslNY9fy3wZP3lJZNi6Xj0aIZ6x6oEyp9HT1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7BfRkNEAHYbw+cRCSvr/qTzWigCixAIUfnpHsgiuws=;
 b=du5mef5m9YlkaYHzI4cTjWRYf7lgHfPQXRcWpsMlj4WYU5tdcVKydv5pAZYprk4nAQtZuCX1qBN0H3apuy7Ohc2do/6nfEVpHolavplmARghmtDFrPKGwWf/6jaGOPxjrm8/folVFMaGAEpWoOry0wcKcT9jp7Wm9QKkC4zYMBXE0edyCWBIFEhOB0TD4nD86ECsvJrDaNw7GKkLylpDGSlk8+rIqS7IdmTIHJTzf7aq3V8nj44eSZ6tzghqMPPnyn5Q+PegWPy/1PSaICFMiJ62jnjj4kepjt3h0SZFJQIkhS48S+3RRlzZ8aRa+Pu6YT0N8NZncYL0jZm/FukmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7BfRkNEAHYbw+cRCSvr/qTzWigCixAIUfnpHsgiuws=;
 b=bvu6entDvZf5puQUfD5zQ14Y1ezt2A2lk7IDIXlXv/p20RgNi2Tb+99B2VsQ9+BMemAgZ4ESZCeiRVjW2hkumHurJx6osGN/W+Bilq35UaPcH/K0xPjD+jLW9ywoPolXUancU1oGQtqvQweH0zlRZECUIBQanIcNxKPxvYWM146mFFsPFP2M+Z+3nIxjnDPvIfXf4fBjbr70SxFH0qkYo+MiqBMODFW4m/dlinjRmHzngr9oM9/dXQCWu/nZgmZ10yQcyfGmzouUvk5bfVFJavqdZT3rE43ee+VXIpPbNxloJifc0xzOidrouWMfSYqIdOkKzX5151Q4Z5xkH9Bi/A==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by SJ2P220MB1335.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:595::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 16:33:10 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 16:33:10 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd v2 1/2] mfd: rsmu: support I2C SMBus access
Date: Wed,  1 May 2024 12:32:55 -0400
Message-ID:
 <LV3P220MB12021342F302AADEB6C1601CA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501163256.28463-1-lnimi@hotmail.com>
References: <20240501163256.28463-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [vcr+neDcosvm8isZFAZfKKDuXe7hbBXc]
X-ClientProxiedBy: BL1PR13CA0276.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::11) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240501163256.28463-2-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|SJ2P220MB1335:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc37fa2-d865-4ce4-ca0c-08dc69fc6351
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	F2/PsfMAatR48JAszdX77mfb/JRoQkKWw+4rBqdaAHBpH+G9ZOwYEJf1uxRpe7PSQBy1KtqHvPxT1cIeuC44/MfE5n0DFgQKvx8HkExs8u2SPG9rTrpccG0ZYTHa0lp5VPBKkY7fLGFt92PebEtMp2vr/0dcku/j15hy9bkWF60Sr90RiXZaBIvPAOIAYeAVrzr21FfjQEadIpFQjkPXQkJFVL//v6p6evbs5orV4G3JdaMKBlwyJ9G4q/7NrRnagdXgjkR8PauuYZAQosHQKG/MA0Iap8v7ZscKYa2tR1IS4RyKnh9UQwmzLNkBd/mSMCRQdEgv2CnnLXCA0bsbzFgH2e2YqvIaNDhCyk0odkluTn/52MeLvoU6vXx0rDcOJhHtAFich19Tur5QlPB9ceBLeShdSATkRVcox2FBuuEw2mz33IszaiHiG5/33zgj6kFcLRU/vMT3OkErM03oxg1g4as2SmMsOCjGU0iih5sN1VxIyNHUng2oW5MJbXl0OQ6F1e6Kh4b/s1ejqHiHvb+0gnVZWN94bMc4e9aBX6rWjzqK2B2eYdmEnyz4d5IU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Od1OoFqjB8CypRCNAQ/EQ112wRgl+b7H5hGqWIjzhCZywdKN2HBy5G5x2myd?=
 =?us-ascii?Q?KW2j9lL6HqnymSnZ+z3WEYD0GKlKDn3FxnBlrE9UuTlqerSJO4PL9T+5E+eg?=
 =?us-ascii?Q?+c+22ODgluyjN14Q4eOnnHDmHwC6no5U13MU4awg6wN9A+Io77nASp9b55LQ?=
 =?us-ascii?Q?AHJjDwvHYWUV9zO9I7vFvwjl+o0/zVr1X0AhPJEZi4OgXb7GL066HgwKLXbP?=
 =?us-ascii?Q?y9qsROvj76GQx/dTWGsluE7lsOliEnMkSH4jbZWm/t/Jnlu83+oBWkMuvuel?=
 =?us-ascii?Q?NRsqRWtzoPzleNpgXwok8fjdIv52DRg23e+K4lIgbN16T6Wp/Ze4CfU3yJ2N?=
 =?us-ascii?Q?qKvOnH20aFYKpnYBzohZAn8iNyHeTo8kSRtdGyUHCEstvDM7RN4KuOoqrwkQ?=
 =?us-ascii?Q?QX8t3az9Wt7dE+ybfMPdhDJUWI2GFXo6RSYP/DtrO+41K5683shD6HOX5OP0?=
 =?us-ascii?Q?z7Kp/d5SQcG4l1BkZuRXXfZroP9hf5ZFOHfle0ynZ4RcH7faLYoGb2/Zzxw1?=
 =?us-ascii?Q?la14F0kfrW0jUoZ7BzRnyqlM0Pnp440EJRWvQ2IMNlnYLTRiREiCgpji7xM9?=
 =?us-ascii?Q?zLzPjgQF9IBKCTK2Q3uzu6z+ychzyAdRpNv6wVPTmAGyPsK2ljhwJFK4MHEA?=
 =?us-ascii?Q?mw++4dM0KygEaVgGOdgQxlbavG45CH+oDXOMWniH69LwdTHF127Zd5m8QOlF?=
 =?us-ascii?Q?qB+eYTtRqC+fR3KxhEiHxcmGdOp73Sg7PGSZBAzOoNmga2GLiv/xPDjAFO2T?=
 =?us-ascii?Q?ilsifPKqsFyv8VHBk7POijmGnOrqpDlwyd93r4BLV2JCQo0ZJFTfqDdbbIrG?=
 =?us-ascii?Q?G3C1qxGNH+bsk86sxH2/VKbsYVW8hJ8oiu32gnzs7ud3wyVCmkCyuAbLkHoy?=
 =?us-ascii?Q?uyGhpcWq6h/eDBYQOWHi+iz6brpnx05s21cyJIkL1Oo/ofEVu9aWg4I8oSmu?=
 =?us-ascii?Q?SRHjdgO7nrlLpCc0vEdCVmQWzM089+GMw8qs242kpKdcVTMAmKiYpeaVPccx?=
 =?us-ascii?Q?q4UqM5eQAJhUUPsKMX31me73zuJ7vYetJBDZb6V09+aTckIWuIEQWqfylFUH?=
 =?us-ascii?Q?BtwXuMUXwJByhEXY6Osb8fo2yFEayHJVgAYZb7AuzAMPld2Zb74Gcp8FKSJC?=
 =?us-ascii?Q?b2re6KjKVND+s8ZIori42m3oWCfBNNtBO2u7fYqS3VHGH6F/d9SjYidL9QPY?=
 =?us-ascii?Q?Gmn+XecaQpdBPq4fXVJJtms6Tnay8ehnQcmZ748C3WmiZsXz9/W/tSj9wzA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc37fa2-d865-4ce4-ca0c-08dc69fc6351
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:33:10.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P220MB1335

From: Min Li <min.li.xe@renesas.com>

8a3400x device implements its own reg_read and reg_write,
which only supports I2C bus access. This patch adds support
for SMBus access.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
- Provide cover-letter suggested by Lee

 drivers/mfd/rsmu_i2c.c | 107 +++++++++++++++++++++++++++++++++++------
 drivers/mfd/rsmu_spi.c |   8 +--
 2 files changed, 97 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
index 5711e512b..cba64f107 100644
--- a/drivers/mfd/rsmu_i2c.c
+++ b/drivers/mfd/rsmu_i2c.c
@@ -32,6 +32,8 @@
 #define	RSMU_SABRE_PAGE_ADDR		0x7F
 #define	RSMU_SABRE_PAGE_WINDOW		128
 
+typedef int (*rsmu_rw_device)(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 bytes);
+
 static const struct regmap_range_cfg rsmu_sabre_range_cfg[] = {
 	{
 		.range_min = 0,
@@ -54,7 +56,28 @@ static bool rsmu_sabre_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static int rsmu_read_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u16 bytes)
+static int rsmu_smbus_i2c_write_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 bytes)
+{
+	struct i2c_client *client = to_i2c_client(rsmu->dev);
+
+	return i2c_smbus_write_i2c_block_data(client, reg, bytes, buf);
+}
+
+static int rsmu_smbus_i2c_read_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 bytes)
+{
+	struct i2c_client *client = to_i2c_client(rsmu->dev);
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(client, reg, bytes, buf);
+	if (ret == bytes)
+		return 0;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
+static int rsmu_i2c_read_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 bytes)
 {
 	struct i2c_client *client = to_i2c_client(rsmu->dev);
 	struct i2c_msg msg[2];
@@ -84,10 +107,11 @@ static int rsmu_read_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u16 bytes)
 	return 0;
 }
 
-static int rsmu_write_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u16 bytes)
+static int rsmu_i2c_write_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 bytes)
 {
 	struct i2c_client *client = to_i2c_client(rsmu->dev);
-	u8 msg[RSMU_MAX_WRITE_COUNT + 1]; /* 1 Byte added for the device register */
+	/* we add 1 byte for device register */
+	u8 msg[RSMU_MAX_WRITE_COUNT + 1];
 	int cnt;
 
 	if (bytes > RSMU_MAX_WRITE_COUNT)
@@ -107,7 +131,8 @@ static int rsmu_write_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u16 bytes
 	return 0;
 }
 
-static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg)
+static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg,
+				    rsmu_rw_device rsmu_write_device)
 {
 	u32 page = reg & RSMU_CM_PAGE_MASK;
 	u8 buf[4];
@@ -136,35 +161,35 @@ static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg)
 	return err;
 }
 
-static int rsmu_reg_read(void *context, unsigned int reg, unsigned int *val)
+static int rsmu_i2c_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct rsmu_ddata *rsmu = i2c_get_clientdata((struct i2c_client *)context);
 	u8 addr = (u8)(reg & RSMU_CM_ADDRESS_MASK);
 	int err;
 
-	err = rsmu_write_page_register(rsmu, reg);
+	err = rsmu_write_page_register(rsmu, reg, rsmu_i2c_write_device);
 	if (err)
 		return err;
 
-	err = rsmu_read_device(rsmu, addr, (u8 *)val, 1);
+	err = rsmu_i2c_read_device(rsmu, addr, (u8 *)val, 1);
 	if (err)
 		dev_err(rsmu->dev, "Failed to read offset address 0x%x\n", addr);
 
 	return err;
 }
 
-static int rsmu_reg_write(void *context, unsigned int reg, unsigned int val)
+static int rsmu_i2c_reg_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct rsmu_ddata *rsmu = i2c_get_clientdata((struct i2c_client *)context);
 	u8 addr = (u8)(reg & RSMU_CM_ADDRESS_MASK);
 	u8 data = (u8)val;
 	int err;
 
-	err = rsmu_write_page_register(rsmu, reg);
+	err = rsmu_write_page_register(rsmu, reg, rsmu_i2c_write_device);
 	if (err)
 		return err;
 
-	err = rsmu_write_device(rsmu, addr, &data, 1);
+	err = rsmu_i2c_write_device(rsmu, addr, &data, 1);
 	if (err)
 		dev_err(rsmu->dev,
 			"Failed to write offset address 0x%x\n", addr);
@@ -172,12 +197,57 @@ static int rsmu_reg_write(void *context, unsigned int reg, unsigned int val)
 	return err;
 }
 
-static const struct regmap_config rsmu_cm_regmap_config = {
+static int rsmu_smbus_i2c_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct rsmu_ddata *rsmu = i2c_get_clientdata((struct i2c_client *)context);
+	u8 addr = (u8)(reg & RSMU_CM_ADDRESS_MASK);
+	int err;
+
+	err = rsmu_write_page_register(rsmu, reg, rsmu_smbus_i2c_write_device);
+	if (err)
+		return err;
+
+	err = rsmu_smbus_i2c_read_device(rsmu, addr, (u8 *)val, 1);
+	if (err)
+		dev_err(rsmu->dev, "Failed to read offset address 0x%x\n", addr);
+
+	return err;
+}
+
+static int rsmu_smbus_i2c_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct rsmu_ddata *rsmu = i2c_get_clientdata((struct i2c_client *)context);
+	u8 addr = (u8)(reg & RSMU_CM_ADDRESS_MASK);
+	u8 data = (u8)val;
+	int err;
+
+	err = rsmu_write_page_register(rsmu, reg, rsmu_smbus_i2c_write_device);
+	if (err)
+		return err;
+
+	err = rsmu_smbus_i2c_write_device(rsmu, addr, &data, 1);
+	if (err)
+		dev_err(rsmu->dev,
+			"Failed to write offset address 0x%x\n", addr);
+
+	return err;
+}
+
+static const struct regmap_config rsmu_i2c_cm_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 8,
 	.max_register = 0x20120000,
-	.reg_read = rsmu_reg_read,
-	.reg_write = rsmu_reg_write,
+	.reg_read = rsmu_i2c_reg_read,
+	.reg_write = rsmu_i2c_reg_write,
+	.cache_type = REGCACHE_NONE,
+};
+
+static const struct regmap_config rsmu_smbus_i2c_cm_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 8,
+	.max_register = 0x20120000,
+	.reg_read = rsmu_smbus_i2c_reg_read,
+	.reg_write = rsmu_smbus_i2c_reg_write,
 	.cache_type = REGCACHE_NONE,
 };
 
@@ -219,7 +289,15 @@ static int rsmu_i2c_probe(struct i2c_client *client)
 
 	switch (rsmu->type) {
 	case RSMU_CM:
-		cfg = &rsmu_cm_regmap_config;
+		if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+			cfg = &rsmu_i2c_cm_regmap_config;
+		} else if (i2c_check_functionality(client->adapter,
+						   I2C_FUNC_SMBUS_I2C_BLOCK)) {
+			cfg = &rsmu_smbus_i2c_cm_regmap_config;
+		} else {
+			dev_err(rsmu->dev, "Unsupported i2c adapter\n");
+			return -ENOTSUPP;
+		}
 		break;
 	case RSMU_SABRE:
 		cfg = &rsmu_sabre_regmap_config;
@@ -236,6 +314,7 @@ static int rsmu_i2c_probe(struct i2c_client *client)
 		rsmu->regmap = devm_regmap_init(&client->dev, NULL, client, cfg);
 	else
 		rsmu->regmap = devm_regmap_init_i2c(client, cfg);
+
 	if (IS_ERR(rsmu->regmap)) {
 		ret = PTR_ERR(rsmu->regmap);
 		dev_err(rsmu->dev, "Failed to allocate register map: %d\n", ret);
diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
index ca0a1202c..39d9be1e1 100644
--- a/drivers/mfd/rsmu_spi.c
+++ b/drivers/mfd/rsmu_spi.c
@@ -106,10 +106,10 @@ static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg)
 			return 0;
 		page_reg = RSMU_CM_PAGE_ADDR;
 		page = reg & RSMU_PAGE_MASK;
-		buf[0] = (u8)(page & 0xff);
-		buf[1] = (u8)((page >> 8) & 0xff);
-		buf[2] = (u8)((page >> 16) & 0xff);
-		buf[3] = (u8)((page >> 24) & 0xff);
+		buf[0] = (u8)(page & 0xFF);
+		buf[1] = (u8)((page >> 8) & 0xFF);
+		buf[2] = (u8)((page >> 16) & 0xFF);
+		buf[3] = (u8)((page >> 24) & 0xFF);
 		bytes = 4;
 		break;
 	case RSMU_SABRE:
-- 
2.39.2


