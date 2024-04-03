Return-Path: <linux-kernel+bounces-130370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E21A897846
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B16BB38632
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863E153597;
	Wed,  3 Apr 2024 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ETqh013B"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2051.outbound.protection.outlook.com [40.92.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB207152175
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165046; cv=fail; b=KxC6NUpFsOQ3hjFuidNkaalpzlOhjW3we2FQ2tP1tyjD31xgStDFoNHej/yReQETRzWZosLoa8DiURn6EvHsxgCyDqPTzK2inQa1A0L4Ml33QTT7q6nxAY/GPXGEfnwpQydk5S73/AFh5aV3BITdrbK2rxEHlvBbvkmIcGno7ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165046; c=relaxed/simple;
	bh=RkokDViYWxOPlFkrG+/5u9++wK1uVbRfmkRdoCK37C0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rlExcfESfIAsELMPphp+tC10Yrdda2Q/9tj0L2cp1U50j+lMEW/BZu7X2y9OxqsUE1Hfm8XKC915epnPwBnIIHE6SCDa+7g3gxYATWPNn4Mj+5mvH6e4Fru9K6vXXISWGLuO2ON1UytbvzPOYCDDVTdJl3VHAwSQ161b05I0+aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ETqh013B; arc=fail smtp.client-ip=40.92.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdbwWF3hEON4brAH30gWB5nhlflqQAA2zXmec4YVWZLjo5qnaS2pkgIUl1S2GAVyCd3POPjU2oQ2KuPAFmkAAAxXMJ/mWYBZR6oIHMKCjCcYoQ+k75sv1f9+IMZGhNqEtC2GxItCDvtfRRPn37p33x8zonnUxBWH7n4dIba+rEqBLwSueqjs392LKie6xgl34gwxvqHHNf91OkjDsV371cDPIFTdF0t2bcDwld1ul49euRDQZafDcX1Mgp51lDjfky979TLg0qCGOMN3MUutt/NvTgFJnCH1iR49DtvwWQB4POPNfx43ZVtAnRLEWMwjTb/xJtFyAarZbMJFG80jwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3g2rRSOBq4b6iMb/aJz2QJ2bs8YoKPCL8lKmKokf2g=;
 b=EAqqkzTLsVUAJ/I2mZEDKLti07eC7y6VX91p9FID+hwSmBy4SOl6K5yHA8MsKoWZ+W4g/xb9ifbQ++KIXX203YCz5xbmCbH1eytUQcYen6nZFetv8IYqQ731H7E8XEept8H0h5D0xsZRnNizNHUNqL1c6aTb+gzmvTVSonkhh4aoCJLxUfxQKLrE2VVe4rXp3fvrCMY++PMOYLS6SU9QtWeK/SbuEpciTQar8ztAQJrUOrRSku7n57J7CztekaSU0O0Zv96vdy9fNpyQX3IT8Y1s6xGmubjMNjlydlsEFky93vj+M408PC5paa319rtb/87RMEdohO+o0Qzk6Jz3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3g2rRSOBq4b6iMb/aJz2QJ2bs8YoKPCL8lKmKokf2g=;
 b=ETqh013B3CX5vj1bWAR+oQCNy31fOIJOa/Q4GoUYlKsHs+TzdSBZFWByvOqYja3B6j1LTK4hXSvyc1EevnpCHVf1uIs0XybcmwIsPKEYcev18oseq1pD+ZiuoGtZAr7dL1tfWFnKFnWPvu0FFsF9VMm93Seg3WC+j1V9Ncwz/3PteU2tlLFrTx7gYKNRFXMqzkqSOhzidIZ3mAE2wSKcTnvVJy8Ufog7eFGdUvBWvqRlUNJ/SqLbNCGsEE1EA7ejgEpL38uzJicUa+LiNd+042SygsLMA13tti6bwof5bMuMkUQsqkp8RGFVwqwMKsnR00+igGwB9YLWiigvMUrg5Q==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by MN0P220MB1952.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:4c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 17:24:02 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 17:24:02 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd 1/2] mfd: rsmu: support I2C SMBus access
Date: Wed,  3 Apr 2024 13:23:41 -0400
Message-ID:
 <LV3P220MB1202F6BA918D7CCC90264E8DA03D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [deBoWR2c7ui6CwewTOhjicymbjKyqfxu]
X-ClientProxiedBy: YQBPR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::29) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240403172342.4056-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|MN0P220MB1952:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1485ee-f829-4598-a4ed-08dc5402db31
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A6jyAe3XXn7Xtpo9pz7yFARbWqDEbsMponaTTA49JNhIeomTAwiRJ+ADqe/8FM+qdWFI7TRJ6yXyS9zkXMwDYI6DOj3s+GIamfwkt9XFxJtBxpIzJCNGkgBceqaFOxT9PS6HQvgm2HKTDwYqQgmYYJleirP3m+UGII02UZ5f39PskLrkLdhxIdESwaCOEtvCskzaiaJjC4HTJ9PiCMSyXp42AA8rh4GdSHlaY5Wy6t6p9F3AIvs0aIDgGyYfaF2K7VqqeqMv3YrAgLURskIezOzQpxyp0mGp34EIpIvYUmTpkbaynygMS02twVL4G2TyCrQ6M0tem4sWxcQrZoeTNgy9PWOXgiP+T4quWNtA9MmP9kIEKx0OguRco0T7CQfxnZ9fQsXGxVFY02oXtyfEFeBdfTFYwbJbvuEgDksk6+KFCRqHCZCB5I9N8tLckFWXDh4M13vHAMji2IpinC3wQuvVjj9rFQvc4OfX6vzOty0olCI+rjYK0W7sep86ZrPXjlXE1RGC8eytRJ157MsDHo9PBVhziSDpEigiDqQZJLKBGIvACVruYmSkduY0emD2
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FHrmvQGYrsZWs+2UQG52Z6sxMYtIpQFeoN6F4Fyt+aDsmftlM7nZX1hOR8rw?=
 =?us-ascii?Q?5yDZV+duAeH8qiNnb55Am9TzreehbT/AdtCN/ehZ/RAYpsTkgTAUKAcC4bvy?=
 =?us-ascii?Q?ohHehjb4EocAnAE4+UFi/2o8I7L3ZvkTbZYjs86XAGEvlbRo+Z3u9ZGFL3vn?=
 =?us-ascii?Q?PCiAudrk223zxojIKqJt1h4TIsfO16v8MuToSm957TYIGg9xh/L8HhqL3e6a?=
 =?us-ascii?Q?/H1IlADz/bCNj4Ol5AE3tLTpTQtzC0uSw4YWFU7zJyLdpq2alDMk45T553W3?=
 =?us-ascii?Q?Vn0nzF+MteWrgR4CsY9aI+L2VjsRmI78kUAZ4ecMWROpUwqamHcpCxWWouFj?=
 =?us-ascii?Q?KrEVr5FB48LmVuNWzHccg3T82a/rjI7oZAaOn0PhAHYGCK5j2FaVnh9x+VZR?=
 =?us-ascii?Q?yF9gXDFDReLUArCsiE3or/sfi3D0tcMufKyAEssvbfiO2po2/rqMH+kA2vrm?=
 =?us-ascii?Q?8Pnwcq5qTHQwtwYSBgxR7UYS+2JVCBXcq8lKdiDGL+Gf54gWsFE2sfDTEFES?=
 =?us-ascii?Q?0JRXDtYOoGShNtEHgp/chc+gpkCClLpGyqIYKOXXG0oqLpkJFTM6DfTINZ/D?=
 =?us-ascii?Q?wqOXVWvw4YGM2J/4aKgwKTdVkSpOhlDG4yOK0zTNNWXmZkpAG+YXVjVi5JVD?=
 =?us-ascii?Q?8tQq/SKOS+SQ25839YtqODqBadjsUGImb0H8s506+Mneu25pMEePt70BvlLg?=
 =?us-ascii?Q?C2A9DIuXFk0GPTzZ59nFg0kf3wK5GLyVtbu8fuAjKkn+g1Mapa0C+r/FpmGJ?=
 =?us-ascii?Q?b3+laTpuTlKEqK6tEDSNkIk7/HYFGZbEVW4MjohzD2NgglD+y/ridpnOJtq5?=
 =?us-ascii?Q?FBmyFeNPTFe35h5R8EacwqkkWWJe953o9bkHoJhgN21ya6c5sDkEOVCzc8Nq?=
 =?us-ascii?Q?yDEMb92eJdc9XLve7+ptAx6IsrpuYLlU7d5R1oxWHtDk78bkSA7cuR6jGMIE?=
 =?us-ascii?Q?2AeaQXO1rqn66lLAsdf88C7nZ118rd8wErOsI11M4xnHK9DadkFg4t/wMF9u?=
 =?us-ascii?Q?uuADPRVvEcF2xf3AIRfMspXR2pl7H8g09xk3qVg4aWW5rW9E4XQpZ5soJ7Zu?=
 =?us-ascii?Q?yM0aSubO5FOk6ciOnkn687h0BiBrX/S3Z6lKLAHuTPcUqLRPWKJDLUxIVxJs?=
 =?us-ascii?Q?w2DTY/fRVJKPgSF3ErzR6IBaiLTjglk+9SWmRyk7ErNOoyIT/agB7YWRoeSe?=
 =?us-ascii?Q?/kQSSJqOSssWIyZixI/6aMM1fK+pAbnvOdrtZFGlVhieWA8omEOpUx8plbA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1485ee-f829-4598-a4ed-08dc5402db31
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 17:24:02.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0P220MB1952

From: Min Li <min.li.xe@renesas.com>

8a3400x device implements its own reg_read and reg_write,
which only supports I2C bus access. This patch adds support
for SMBus access.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/mfd/rsmu_i2c.c | 109 +++++++++++++++++++++++++++++++++++------
 drivers/mfd/rsmu_spi.c |   8 +--
 2 files changed, 98 insertions(+), 19 deletions(-)

diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
index 5711e512b..40fdad01c 100644
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
 
@@ -188,7 +258,7 @@ static const struct regmap_config rsmu_sabre_regmap_config = {
 	.ranges = rsmu_sabre_range_cfg,
 	.num_ranges = ARRAY_SIZE(rsmu_sabre_range_cfg),
 	.volatile_reg = rsmu_sabre_volatile_reg,
-	.cache_type = REGCACHE_MAPLE,
+	.cache_type = REGCACHE_RBTREE,
 	.can_multi_write = true,
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


