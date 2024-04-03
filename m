Return-Path: <linux-kernel+bounces-130441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5547A897829
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7091F20FC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8077F153597;
	Wed,  3 Apr 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PkmXbBSY"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2023.outbound.protection.outlook.com [40.92.42.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D7152DE9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168706; cv=fail; b=mlnbIFmoTMG6MjiWqhBhuon13QV04PRisZD1DaAYvEczN2R0DfWOf3ShkM9QLAWzxXjnGZ15UGYlFGZvYRMvzLvsL6NKr9DS1nOD8/zyrqojSPHR8jyZCnyySzYfX5zfWiB1Bjp4N2CK09Z5fML3A55Zy9FJ4B7xDqnWNDRzLq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168706; c=relaxed/simple;
	bh=9DtE7G3c/nlLQVyVnVNnsfxjAI0JiS7SD8Npztd709Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HDzIulnjF/KVTnBVCypOL2gUN4nDNUvuxI5Dj93s8u5KY5+b9EDp2JnMg4RBo7JbNLJbFMh4wjUtL59/Xfu1SEtpRLW+YQIvWXwDJ06QX2VgUAggcDM1iha+nAWbjWOemBnX7/EnoS6UUAn+c3D5P+27favH4zcwLLb6k0X1ogg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=PkmXbBSY; arc=fail smtp.client-ip=40.92.42.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j53oZ/NQfd2qKoj+FHuZMWASml+Yh5kOyqK8Wu/w6k6ujmbJTEhud91LI9Bm17GGUQGpr5H9GXo9JcgieJ7tA/n7qUKzEwLr0PLIGIQMHCg4F8dGjjC9hfnnlIC0oJWb2Psu/OA0Vn06DMsDz2zS1hEga/uD/JNwxkUnvksHrY3EAxOswjOT0YWNJYLe6NDnzElayh4fo8/ED5dYaL04N1ElNhH1NmnBvYee44wOdOpEX9plcpZyVNU8JgA/gf+8oegWxMjVfh6/Zx+FerWzxs2htJGXZLoVGRkehFJtx47KUpJdwXGB8QsanYFC4PsjAC3kezEw8UQxA+OXTOTXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWkD7smQphI1G4PTZoUo4OtUXslb1JBNa71nmzXWR0s=;
 b=ZouSm9M19n87u6hrj9Nrk3rteSyD0isi4Ryo1pNKyOHRckDqM+TTcOMw4jXK22DBWyi55TluaU8IxuSMk/8c1jc6tEjVpm7YP7O1SOiMaviiARZlmJ6bKx4MDZdasuTaoQyCTuaZTjDO5dKHEUjuNTk3WQ7tacaWI+VQw53VxWAAMQ0GT8CMw8s6j+a2ngUeMld+XwYxtlY7UP8kjyagpRomf2D8fXe3GtaHmaTvcRteQZahrapAbhvRreXuOJ4a4JvxffD4E5RyTCvgxLEDnP5RlZdZebYULKZN4KSda0AhlpYGvaZONQsWomzgoPgFaTCf8VlVIfNsI/VqM6/pJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWkD7smQphI1G4PTZoUo4OtUXslb1JBNa71nmzXWR0s=;
 b=PkmXbBSYmceNTPKRCc1eHoAa97fX5wjB5BrmqMWTrf419QOYIM+02qxcTPZn83Lc3/Yi9Cn48BlwBRPApljTU1T6OhyXVemoMLHW6qI+qzcQrgApHT0OErzkCWyWByCW8ke1ankCFFmApalQUBoIzh9e7pOT7W+jsvnvUpqwfz19QhyXStb3b5KSrHIHXhHijW+U8vOByi6WRVonF8Y863sMWUh6y+L2q+a7JVqAdBjitbd7QfTy/e9Ssd+E+16Y5zpXMnobdXmBkCz8Tf/53pSTyNrR1o4uI0t3CcrawmgHg7f+HSkcHQZa3DXNRp2kGI3yL4fwX0SLxzX2xHZwig==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by CO3P220MB0783.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 18:25:01 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 18:24:55 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd v1 1/2] mfd: rsmu: support I2C SMBus access
Date: Wed,  3 Apr 2024 14:24:35 -0400
Message-ID:
 <LV3P220MB12025CBC81EA7F4351966BF8A03D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ATwirDISN3WhD1bUCYluiaNjTlcKAnue]
X-ClientProxiedBy: QB1P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::31) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240403182436.7353-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|CO3P220MB0783:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cdb836a-668e-4d75-7b47-08dc540b5c9b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qsfIjwaNKrNnwFdoOzM8tXi+T/zdDMFGyEfQS4fte4jGvDFJ/sE4m91anEF9kwhLufJsvDQ41gIFCd1ylNT8F+I9L8JhiSl5AdDCbcYPvOwgSpmPSleUwLcqlHQ7bfbwGnaWal/0eFZX3biaM7Ii6A0eWt2eyRs/Bg3ug1OZHnbDXFlMyWjFz0nM2ad61uk1km3/ztJqMrxvkfbTO4Yao94x4YSrElVul+bthTX94/Vu8YYYPJyHV3FEBXQtD+Q3MGeU96vGM+WgZGuotNu8OGGdcUdgg9oHyBSZH+prvKmnnSDkVfTTRrlGvhfc6BKvo6ckntgUZ+Ey4YTm4oBoYg+ZD8nV6NdbjDfYzd5XXkC99JipGaYWpvIx30yVyU6KE6TDmjNa16xE/JUagefFJqE9lYXt3cjHj1muHlIr8v+Jm7wZnTkDw+vNCvNxUrZdNTAaHLnZJO/xerBjcSvSM2g7FXvxNBWafhgP0XQ6+KBvoZmarwjMOut9gCMyzWk1zOEjJH0Yb9mn8DlscNQQQ/YZc+DajlW5PU6j8LTtzebgt91RgT/TT0DnQZyGBJRN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AF6oDzfE/yc9zVPLCPR1PY4NZQRNvfMM71dG0JaUro66HsfIEKePkrBX27dw?=
 =?us-ascii?Q?JHvz2BkU4EiDadQgGcX8h0d7aO9yl3iPsZtXpcwiXoLhNXPExORb5Km1pfoT?=
 =?us-ascii?Q?BfC+iHV2zNqUOLfLZRExLC7y+CCIoqulAPjUybDWomvzvSd5+5Mi7HoAtEEO?=
 =?us-ascii?Q?nzWxt0W3EAa44+f6o4mKpnh8dBHXiEuzANmTtrs+kUND2THRSvugij4KeN/y?=
 =?us-ascii?Q?Q34/XiEBwp+5Y2YLe+UroyFnk+rqDyLlO9ja86FRZ3JpBC0GIFeL5bqocbZt?=
 =?us-ascii?Q?jCqUL6ZTt3BjPsnMXzMcQngjHH5nke+hIi8GZ6RbIAgJPbrE0HqJVOjJAS4V?=
 =?us-ascii?Q?WzKPnIF+nWyPo/f0snHLdi6TQQilb1OspB9MjCy1N+1txBdWdmUQ4UjzOUtp?=
 =?us-ascii?Q?n6/H3BZH/UPaBcn05ABV/er7Q9V4RAPP0sx087QrFrHnq3vfQ2hR2Hnt7hNp?=
 =?us-ascii?Q?S8y6thEy4CYd5xtWt+sfYZtlDQNdNNRE2y4tML4k4u7LYsKX5+MxKaeaWx5o?=
 =?us-ascii?Q?5zt6f4hxyEgkoYjgh14XfbTOUpLlsGQFZLEMxLvqTQa6htOEKyNTkpn+Q0jC?=
 =?us-ascii?Q?HgEnYO4ct8qCxTGS5SsSZMfl4xASrNvzcyrfk0KnSlKecl/3Y9eLSbL2GYp8?=
 =?us-ascii?Q?9ieBRHyvOHeaDOgO2OoB/XcYy8F2gRzA18YvGqARNyugRDO6ZPqTxPFbZ/wR?=
 =?us-ascii?Q?8FZHKPvh9jC8I3uHy7wn+BDkFA04wMckIe8kAyNCK5ClMA2tZghiFo8XwNO0?=
 =?us-ascii?Q?FS3HMUCZIMGMxiSZTPK44uiMM6IGbqWJMn/wAgddGwuJooVneCdkXCYnpkGE?=
 =?us-ascii?Q?uSoZiw420xcXkiJ/SiXsjfjPaaE2H0t88Zef5cP8EQoIUCTri9RN5VpYfZn1?=
 =?us-ascii?Q?mSTQRNx/VfKGQa+Teqn8YkxW7eAjubPgwS0cIoVfdiVoB8izQm/Et3CaDroo?=
 =?us-ascii?Q?B2/u0xtapH8Si5QHvdXS/ynRfAaeiIpCUO8SFbCapgUxkZDzPerhCboTg06c?=
 =?us-ascii?Q?rdkXWyKmUndkBQEDR8V6Ovuxrg3hPI7JcBhodNLtQmjI1jXZPsM4bufjixuG?=
 =?us-ascii?Q?kRQeXYrlgXAI+yIrKwdEGliVvG2UB2UIGXzQ+VEs4v4Twcuc2eLv7tYuzKDN?=
 =?us-ascii?Q?qkrAMgRajjnwYaNDNn65VHaMK5YcYrQSV5/KtObXcW7ra82VMsfWrLY7D6b2?=
 =?us-ascii?Q?AyfbPrXA4A1PHj2PoTci8EGRIb1UFRa9lnRcSmu1vhQO3Y/f0rQbQ3yDJDU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdb836a-668e-4d75-7b47-08dc540b5c9b
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 18:24:55.8494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3P220MB0783

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


