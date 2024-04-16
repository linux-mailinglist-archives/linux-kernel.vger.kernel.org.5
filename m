Return-Path: <linux-kernel+bounces-147078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDDB8A6F30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E85B253C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707812FF67;
	Tue, 16 Apr 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="d7FmyMg8"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2083.outbound.protection.outlook.com [40.92.23.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001E12F5BE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279643; cv=fail; b=KAOvE0VMPkPS6dCol5+lZtMjQvqdC9+4S4iwz5p07gHk5pqOof/B1ZcwscbJGT5UJmBk4Loj4Qyc+sRys/E+mCx7pG+fvUZceIvKihHGArKYuT7DrSG0hQbJITWexJ7Q9UhedEeQaAocbmVtxQWbgWBUV84/XfYA5Q5WwBHQPBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279643; c=relaxed/simple;
	bh=9DtE7G3c/nlLQVyVnVNnsfxjAI0JiS7SD8Npztd709Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ydao6Vpo9MsBkR6EEr+Vpa+M4Ru+F1xSyDl/XS96/OmRfOm5JZLgGr9Cpmj4/6DVVNObD4SMiUUOcHm1U/0KCMGulmB0c641NQ4ezZlgpVV1dcEpbhkWm5WBWTpVRVTOlR0i7FTAHF7DBoSPR5jAauoatrr/0J2sc7FjKwDx1lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=d7FmyMg8; arc=fail smtp.client-ip=40.92.23.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvcIQS6DERwYUzuBxXzkd4e6DVNptr4WkYnND1ZnwliZvP5OwzWaoSIDtsDgl9ZpMWb0ic8l2i6pnOVC7HAg16EfUfDocKHVVdopQVKpeVQe/GT68W6pvr1ehbILQU7HNZQR4vDn6WAiCXw0ZXPq+pso4NdGwKtWnY1MAxFpKClgZjXJxSei6LFyQ56v1uqL3FJGHXi9Qdf+TMPrM/k1G6/EB7mpwKb5FNKDqQTSz+M2KDq4MIXdmf8AgdsHBc+IOZj+sYQWYkop/adMS1PA0vTjTBH/qo4/7HkV+FaAA+yObbNufPkYIjTsWqmPiwqJtaKxAPH4THBq6v0P9UhhKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWkD7smQphI1G4PTZoUo4OtUXslb1JBNa71nmzXWR0s=;
 b=FVBer4JMazu7Sz6F01v/mp22Dljm8/6DEdPfuDzRMYjwJgwzScF9jeRmbZESTjPg74XjqKnPBMh8JQOXIUaTrCk7y7ZjxC8OTLN2XL4Us/rRbFORxTTt9WiC/jyPiJ1nGpulxUdnnrpBQg7Z/zpN6Wk/4f7nRMN5aRbuamuyp/MKvVWkhAG4H3uGkxe8fPzsur6FOCVry8CxJEzaSWkmvf/EDrl2FzANJ2coO7O4Ep2iADocKisfj56QzP1gYtoUAFQoDSScluwltmKqjVhcgehy8wj1z2wQOi8ah2aWMRy4kPrKb1wPvA7+mGP9GnpDfJFTHHIwTmqg5e2aPHdA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWkD7smQphI1G4PTZoUo4OtUXslb1JBNa71nmzXWR0s=;
 b=d7FmyMg8AhbErRbvDehpOsgDf9mmymxtKhEkgL6KaoMHgMbd5RieAHWj/yUq5ZHB5gZLb6x61+wqNvST5dn9w4QWs8dv+kjp0+n/gkSyy8/+2IHiZz2/+qkg8OycvtcFm3a8KVxmRThbBF7Nrqe551JBq8NSD0+05NxBPT8yYLXwoVPoLZEoTyFI//UVg7yvvqDKYtY11NdNdrTYEdGJfj6NCUnEOeBzaTyff/67rYEQkSMkMQSvqyFzqtI61oB12fwcS9s/ofrrVHwM8yZw10Jd99Kx1v5pL0Si4UnS+h8pH6TDFWJGEYlvsA+ueXdCmriRm/F2Ru+X1xacYueEfw==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by LV3P220MB1504.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 16 Apr
 2024 15:00:36 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:00:36 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd v1 1/2] mfd: rsmu: support I2C SMBus access
Date: Tue, 16 Apr 2024 11:00:19 -0400
Message-ID:
 <LV3P220MB1202D9C33F782332A7CB9F4AA0082@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240416150020.9898-1-lnimi@hotmail.com>
References: <20240416150020.9898-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [XKbx9F8t7GOpzO6SQQL+A0iH5HJrVzZY]
X-ClientProxiedBy: QB1P288CA0027.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::40) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240416150020.9898-2-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|LV3P220MB1504:EE_
X-MS-Office365-Filtering-Correlation-Id: 6443e24c-242c-4f02-4e64-08dc5e25f912
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnosrztZXhUVqOS2T8ZhzTZY2sHLa9C8Yv+txnaQoqSVAh4sPupNyjo9Bw3UcBWX+783aeH3XiOUY/9oj8fujw538BQskiHz8OpW0wZ6z54aNQp+qi5yupfbThgqmS/V9NmYHXzRgOIIdBwPWfKtIAYBzRWKAgP7b33g8h9UkIbx4MwREEVCdGDgoSPoiU1wDyqFzNUITQzSQ5jFdJ0aa/KOFEwaoerLWof8vAp+Ii4FSo4Y6586JdDBFxS+0oH4PYIrPOrlNPdpsmmojPoFvodbk00FSU/qen6qlfsfooJY1cHRf13+e3ZKZSOK0LdBA5WQOuJUElc01A1HANNJXoCY1HRJoX853u6Ii0JEVdxFEecGlbV8f1W61GeE1WbF+istZkZGomHg3ov2w+hF9tIirEesGPYklLowRCrC+LN9EGplEBj4e32UQeN03LndXgc/9kOWowOyMu19A+pZoCIRMumHK4AXQKVL4BqcTZp+W2U2DwMo15anHklY4r8McfnA+SnmeLPcIhVk5EiR1oBLUQMSa9Pk+HwJD+tomHAH7xdlTsw+DUYltVjYYdGXm1o6sy9eU2EkiY+OSmjS001FD2BGh3/xyZA3F7kxyVKWFXRnWCbgEHZwwqbTSTdnWpfQZ5JVj31cuqnX2Tk4AHxQQ4irC4gatGL7aEBqP65vlvDBOuwV16WX59K6egmC6uAsOxLPDy693koa+GhxaCdwXZgBy+Rr9wOasxvTJ2tm4TAX9KRwW5b0zjeKomAP+GE=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c+XWfy/880IMNAVbDY3dXMfmcwniJ91idxKRkWlG8f4XaY526KoZV79sNrFEDZhRkvFYHUud59t7wTu0ESNPg0Q2/MzGLyHW60nPVYshNfhq5iLB+xWc8hAHhUJkbp+b93RvffNe5K7903xQpNpoulp2K9JV9pS6KJsEp/VyMW0vLCo8M5NJjOWCMJuYqyQckLUpgfi9NtMXivThW5ugIM0RPhyTKkwu25CXasqwIYLS46bKTfoRzZhYE7KUJf+q7vzzvVPWGwz046US1wcGPiD+sKly+kxWvA5dDsEETI/CQdY8xjoY48CXrhkPyykwqXXseL0CXflMNKV5NLMe8zt5boTFv9CtZrj5zekMgwLpj0C+S+TrLGR91tzJOuLZSFt4OxP4k8neyt3e9BYQZrTnRrF9Sn/m6hrlK5OV6rDcmAA40K48sjt7oQP2Ymnb0kkqkDMdD+26EbnJ3u1mU8K9mTxNliQcH4XEJ8R/gBFD+9S22ocTJgM+ZXg3Bx1KiLYgXGefmxWLVH8JVRzcfkOUQgwfnf4uuGvc5vrHjuGIZ7N8qF7EXV91c0yNWyK7
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Amv5UCfLOkE9nAq6P/qbnGxLteOal5yLhXkCp2/g2jskI3ATLuj3/YQO4u1W?=
 =?us-ascii?Q?+BdKZsyBx5XjS8cNCT/O7n8EX/DBZHQWSGaBsEPFQjfeu4zsw3ZGg3eHCja8?=
 =?us-ascii?Q?OvhdUsUZkbj36740SvLgbwK9L5L7QvVeiccxfnrY+K/Jq7pPxvRWoJ0RBO9X?=
 =?us-ascii?Q?4p5Iictkvfdjfr07VpE5KQq4El43LLaFsKW1EYV1ZpfOJNQEL9cyNHRA4rql?=
 =?us-ascii?Q?W+ByqJsVFEDBZrWgeKov21XS8TpTG1WSW9kjwTQWMMRotDw3Y4L4SprC/pq4?=
 =?us-ascii?Q?v8G5/2nQwGWWnxErQ09Z2mSAJGEVOrQ13rI8GaUEhevhLyRU6xcsVjjXaPxN?=
 =?us-ascii?Q?daOVUidkJ/UXlXNaU1350hZUUUSrpheATV4wmQqCpGv4GXZAMc4EpsmIU16g?=
 =?us-ascii?Q?mA9Q6muPdavVZ5OQxQ3G+l2ibEXqmznaGDp0oWo95Zn4YqTPNRfKOgbZliJN?=
 =?us-ascii?Q?brlGptzCHDnPxgQGzf7vKTLMM5JkhsGf88lPC+KTd6loIIVSNBegAbEE5C/n?=
 =?us-ascii?Q?mkLgLkoNLBhbg9zIE1l7XcNZsR6xskSm+st+COwLktMD/rnHm5M62qZifEU9?=
 =?us-ascii?Q?CviH7/ySVH+mcXrXY2Ao+q5C/tjg+HLCoEuIrtycpoBH/DMq7IkmwRAc4GUm?=
 =?us-ascii?Q?Y9G6oDKMhEeZVPHEirIMcBBGioQ+XZpts27qsWAsCwsm/l1pOKPxRP/0Q0Fl?=
 =?us-ascii?Q?i0cF0YdDUXfRfD3PRe7z48mZteoAoDFVttg8PTeCWlJ7hEexD0Rz6+5eTNYA?=
 =?us-ascii?Q?2v5M0Xc5RUrUiy2OKtFJqUDLbFcduAtztXMtL1RxcNo+iWoPIWTJ545RGNmO?=
 =?us-ascii?Q?t5BQ3PaG+Pf9LW6q+dOJjSqqIGGOaqLZ229xPasA03TM+PYZhYT2523lxM1q?=
 =?us-ascii?Q?DKLOb8Rrzwsi8bwUyeuGruyh7tfMib9b4GY2n2KDakxsgcKqoPhbl5BqaFcB?=
 =?us-ascii?Q?LK3EO4YbO28VHr2DTuqYkhKymnLMCGZcOhjvoJzqpfVhEaJ8qDpThDwjDp1A?=
 =?us-ascii?Q?5NjOWSxV1p6U0Yc/m/GlujsiOBT+hbrhygtTyMk755+Qosl2JDiE8LJGWmhK?=
 =?us-ascii?Q?KBzLi/QQkD6So1xcv85dRL6cgypA4IOydc8Kizdgxc1a3PGXRhZqelxIUbIE?=
 =?us-ascii?Q?Rwnipk8Y64vjRtozT4QRn9f33k5n9zMln1bj85AtQ6Tkmzy9zSNnDrc+biqu?=
 =?us-ascii?Q?JnpyC1TC/hzp1TXz46CsW7o81r1L9st5kTqjvli6RBlYbAyMTbvUvq/XgoA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6443e24c-242c-4f02-4e64-08dc5e25f912
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:00:36.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P220MB1504

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


