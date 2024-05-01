Return-Path: <linux-kernel+bounces-165536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6345A8B8DB6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1618D286264
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8D9130A7B;
	Wed,  1 May 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="HVj1IeKz"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2109.outbound.protection.outlook.com [40.92.18.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03312FB3E
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579520; cv=fail; b=cfHJO34o3BhcNzJB3dhlPUqERtegvrbfYTMgSzpoe8sBlxKJiPeNNQXsj7whQF6Pb3dU659UcvQaxXb8uGorWwDh0iHAe0BsnVL8BlO5uTkMnnacM4qMc+PHkOdSe2xqD7JjcxxnK8I7D4bmyRro37F7JLTw03FIV2Qine1QGvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579520; c=relaxed/simple;
	bh=9DtE7G3c/nlLQVyVnVNnsfxjAI0JiS7SD8Npztd709Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mF7nNkmCRVds7voaIhO3/VHOpByaUkfFfkKCy4ofsHFA7t+7IIFzi8Gm3UADqh3j+le/DE6ABCsOR2DeG/tHoc0OpyLRGS5y1Qz9NwZC0KNWLFp6PrBKT6ZYK7vCiEbfTo7VN7pXCX6krdwVxKr39rAvC5rLYNYRWLcFa+y2eLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=HVj1IeKz; arc=fail smtp.client-ip=40.92.18.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NE80USEz3dfllu+6o861DNGe8+gxxM7AlQkkqu+wSOanVRYnE2GgNDrUCq0Qtxc7WpQWfQbo6NjlNRLBKeohrf6AHxAlHjtUr1WIuMQwjhF/1WKpi/G0GDw7tgd2mi6Qcbqu1EHD+BOOThhUTT+/2wWOvAsYtM8zTf/qoZ3yizOCWeP9OtPyjaXrm05ZpUAUN6z6nVi9QmYnB0f3ZsPCMrHcvR+vKYC450Q15b8Cj83rNLXKgdV+GfLGryvJj9LMMwJl403tizzXp5eBmqEzulqfc6gfxIIlHIJC4trx+MKxUR3Jb1XtERgWDvPPZX1kCBZ0ixZu4SHAXuhKTSnjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWkD7smQphI1G4PTZoUo4OtUXslb1JBNa71nmzXWR0s=;
 b=FeuFcFCM53vPaGtHopZS7Vg0biUO5gw9cSj9caVHi5Dr8iPNZODHywI0NCp1xe8+o9B+bErVebM4BeNRuNFXpR5DTXJLxmOYbQ1FlxnbWtk73qXbyukx9ft0gvg6nudleCCSWOe9sBMxJy+MI2nzSSYUoCbHh/nUa7OJisQkRAKXhRohsqVZw3ThpxhddOmtuB86RezFib7vZdWsNOxW5JjTw68GKZkZs9vUBP4SieOnheVKfb6rUiqIk0RgYXNqHS4vAsczOSZDnPye0dn3rsXYcYJX38VP+axJxNqx42iRJ9i1TCPEFuEVI1YxjYYvcRyPdxmdg6VbuR4b7O6KAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWkD7smQphI1G4PTZoUo4OtUXslb1JBNa71nmzXWR0s=;
 b=HVj1IeKzljAXH6YplQsuWa1GeYGcM58iCBVmMpTL6zKzs3+h4dhZiOluaCC6zxWaX9zBfvVUyovV0zwWgWZo28fH2tZ+VQTLzlB71Qz6T3AhOaw8FM6B0PdD2tcZaf5i4dGxNc03Tc/ZzLIRDwHsMWzNYO1klyKK51hOoVkXpfYOZibUpAvmJojSwA41Eu8bP/Pp7xgJffftmrcV5NemsPoNtrNHkiP95spegnpFArcW4o7iHl0oOMIJoLonvant4HS/j6W4b8WwNgAKIOeagf5cV3f3HdJBVyLnTZAIIdnqBNPGqeWGqHlgng8UAuzRNOPqW/2FFMOD4f3MOLCB9w==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by EA2P220MB1331.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:257::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 16:05:17 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 16:05:17 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd v1 1/2] mfd: rsmu: support I2C SMBus access
Date: Wed,  1 May 2024 12:04:57 -0400
Message-ID:
 <LV3P220MB12024B2BF24D9DF1FAB3FC46A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501160458.27588-1-lnimi@hotmail.com>
References: <20240501160458.27588-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [BiLWWKRy3/j3MKNkiVVrS8zHiEQioJPL]
X-ClientProxiedBy: MN2PR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:208:fc::25) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240501160458.27588-2-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|EA2P220MB1331:EE_
X-MS-Office365-Filtering-Correlation-Id: a84c7a95-2650-45d9-f51e-08dc69f87e02
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	iolqIzgNFosvjZjLNPdlEAzWgJp47QN1nEeiaLYoLBUf8vlgGrLmhH+PHtyoQiIr9SHq8GYW5gFeQQ5OvkCO8XDL/6ZQoYBZ4zgAemnHairbP7itw2oeJ5eea1QuLaVkpVCFmIq5GC8E5CUrxmEadSgQceF4nTHy0yxzLlTBmGlBXU7vkiodjbkgALxJ2oOAVuFkYiw7WZ++Ambsq3+8J+kCUiEk5k3/vKEpuKOYo+G4lsK9CaOKNYvD1/dYinEazkOoEeWdyQshAOHERcp8K+R007MtqooRj+RMuIAX7TNEgqGFfqrtGEjhWmgXydfgSrXUCH/AKb+fh9GF/U1uSTyWao3QxyeVWqUXNnEGY6T83rhUKLxbKIo6kX/nM7Bini5onmDWufiLlUA21ALRS6sc7S7NFrPxCAtPEJb2FSUeWT4NoKggtGeEnO/5ge9ICX8s5ghe+g8qOyRUeZVcW36rbGyG7Qa+tOOuddzDiF1BjFVDc+U9SnEwSPUS+LnUElXKsys0GaP93hnahb26PFtZAD9v2snNaD7ze8j2V8KLSjZJIdblpJ38+QQgbDyE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MnLQN24AaoSIXe5q1WBw7VVO6LIRW8z28Pvxdyf07Y1dQNcahqRJdSeEGEOd?=
 =?us-ascii?Q?nh7Bw0e9V654rCSTKYUkU4Y3tamyF0+reb/BSxj23+rq3N5YaGPc1p9u52o9?=
 =?us-ascii?Q?NkohESXOEvip3+/bEKCD3hP0KAdRToSvoMObK6rDT5qscfdgBQthi8YgRaym?=
 =?us-ascii?Q?uSynqOHypG/Py4LzWUGr6wxBbBUBPaEix3sLpjWjebIOfR664urixkVmQhW1?=
 =?us-ascii?Q?0fas7IG38wfXpQpNT3myHps/ahuIoKWEOMsTuJWPyHN2JhYpC/RkApNIrmP5?=
 =?us-ascii?Q?BsLZ3zIwdlpXoxKMRCejNbO3tZdPu0CnEvV7i+t6nZsXoU26yp/ZgzuTsS3H?=
 =?us-ascii?Q?h9ULdgoPDHAKT7Ton7b5CxmYoigNsOiGt7NpBwNdWoQXNwvWefS2GLtKajuU?=
 =?us-ascii?Q?nZmCgZY4S4GkROeZ98Aud1hrd42VB9lkXE/W4HgJi+gNpkRKTiruS/sgH2h8?=
 =?us-ascii?Q?0cGTU+4oZlhg28CgwKgRqnVu1Yir/g9RhM9FqvrNeCE24m8RWuJbrjBPwgRO?=
 =?us-ascii?Q?hus0RNk7nocYccPoEnOj6AJx/VVqul3MfyyLlGy23L46Q7EQHy7VpVil3k9i?=
 =?us-ascii?Q?+vxy5mlExwBux2VzgLETpI+DDW7BmN3f0UVA/FFUrIU3IkmcfNaM8WsVT3EG?=
 =?us-ascii?Q?oLBU0nH0WOEgWe5qqiR+V73hSUNROx46TfnfalESIzgFc3lrdjLQDi/1p7YF?=
 =?us-ascii?Q?NT//ALk9zg/YrFSLw8CCOJfkFhbR/HKVmTeT3crH7mDPND5D+c1kRFQkhXPa?=
 =?us-ascii?Q?KQeTxqGYH2FbJ4v97Kvj31P4LxeyLQatIjmBvG+NSeyIUYRDATdlYhI5yZvL?=
 =?us-ascii?Q?BXPqsh/jylXP9VV0wtnpsQ4gdGR9AVZjmbXPTtdYE42OiBP9/7dPAYKedj2j?=
 =?us-ascii?Q?lEXpD9dpbtGSzavyXmc7ExcpbqqcHT0xW3vRpw3DB7vH8UDAI8xQuZT+QOCF?=
 =?us-ascii?Q?cTTI93+9agZE6UAKVjsN4EM/xWItzv9RiDeBv4KFdQhcR4Ixz+T68AdqB/gI?=
 =?us-ascii?Q?SCkOZrtraUvO69+BI7XfEH1wfL2XgWyEDWue3emkITqjoKW6JrYVq928RRw5?=
 =?us-ascii?Q?bDedS963Oep+VCPRRaNKdLEEtoECUBotm16D1hNh/p7nzgCCyEhCBUuDDBWs?=
 =?us-ascii?Q?c6CzvjD8rqUfxtQKvvKM6f60mob1sS4TeL/vhKhWRvDMAaZzM7NkE71Q1EGo?=
 =?us-ascii?Q?FYBuRZcrl06XNeR2Z/zDmhtDirgj6rAIIOo1mvLCBG7B4UQUPCRwibcw/ZQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a84c7a95-2650-45d9-f51e-08dc69f87e02
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:05:16.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1331

From: Min Li <min.li.xe@renesas.com>

8a3400x device implements its own reg_read and reg_write,
which only supports I2C bus access. This patch adds support
for SMBus access.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
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


