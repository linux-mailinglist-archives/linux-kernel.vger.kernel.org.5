Return-Path: <linux-kernel+bounces-141431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BFF8A1E25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486CD1C23243
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174053A1CB;
	Thu, 11 Apr 2024 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="AbH0x84f"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2095.outbound.protection.outlook.com [40.92.46.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFFF39FD5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857975; cv=fail; b=DU8NsS+yT6PUIPsusLqeXj0vwU6G6Sc91ot86euvJAOYt/1Dzf5ZBQKgoDb2dnxtqpc2aKTCX1TDG9jPnzWYh6jf6+H786sxaFlDVL3LWiOQTvPOY9Q0CVrfecSDY0zjX05LZtpmkCERWnSpm0x4jtWj7/XvUsK/gjJl1xQ2OJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857975; c=relaxed/simple;
	bh=a2wxkvTEJwEhe0ExV+/jelE077FR07JP+bJPxEg+1sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XqfONFlOqWMhgh9B5JwG+r7/lnGDLWD+avxiPL3Jvi2xbGc/zZ1WG1HGieq08QlkqiHV5W1Ly/b9XvXoM3ktuRkoGWQCAZVBEjCJR64y7aAmrMel7D6eyVZYr+SSXlEvKMHSbMEvsZxWOJLOK7IO6zrUewctcSzKIXNtwZL9KV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=AbH0x84f; arc=fail smtp.client-ip=40.92.46.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZQIvsAL15/A45VfBwA1DGx/1U5+ZXCRTSJBkIOYOunLrr7x2pJJyQHvZy4YHsbJi1PquGO1P1WTuR2TIYMRZkcm14M3EDUWJRvgSQ5BsFmGV9gozLaFQunVdi991JX9FbeYCD+EUWZOGVJFkD7zBumypvkL5lig6zgAogrsvxxd8mK4iF1iH/hP2bqQ/UGHCvqekchD4/VHz9XXCsLEKXZWepwQ9GYgqEhzAHSK35PLlrmEXNcldniCDBnnvRYFWEjI+uPyOHWG68noqyYkir31PDEAflckYAZS6K2dkdaZXAMIZQtPkMHOLeK8mQ7wUumuNG9KkQGc1Xl6wa5axQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LejaDCVGC4w5zFGP+Y3j6qN744oVMRHjWP21dmQDO6A=;
 b=QCPQENoRP1h//4f2PypgUtsGi6qvdtT+g4lElEFkGssuYn43aIu7qtAH29BJDO+cbq2Pv4WadkEGyPCvQorTK41KibztwZ5P3XnExNMH4gvN19MZN5AdISuAtkUILMj3LzQnhLuN06v/tXEl60BWBE9rKrGCZNwQ0PPaf/8s1b5nEzfdiWXHwrVOXSkAet7Y1412fc56qLjZ15+fvf89KkdDUbAza5P1BAmjW1/ZjhG0xOTWr/KR59DG6vhVD76JNvyWCptQyOknVkwNBnrVi7n0PIkub+Lzw/GLSShAbeSXLdphNKUjhb7Ar1VCuhWopTIksCSgzpadr7Zcn4cOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LejaDCVGC4w5zFGP+Y3j6qN744oVMRHjWP21dmQDO6A=;
 b=AbH0x84fcioXgpBInrAnb3IhvQ/ih3gN3C9y+jxH1mbepjIEvSsjbsV/zxoFSuPSBUZFL0G7yueY1ayYZjIqA1V3745Tb1lY5E2snSsGGQfGK48OqZorr7TlUXfoglFLOtQ/txY3ydqdKFQz0PYFhceh4tcb9Ux263G9ujOdmPB7cK0J21sdV9K3xaSEfWk/oXEWOofYay85xFM0t/SKYK9Ne7KygV2aN8AJdMMS6NcRslsvFWRRbdF8wTFv48z/vTsxzmxf6nNqXchFsgNGvHx019pi8iGlCDAuvUaQrxHRHu//8tvY7ffY6Z0vP5ytCdlakD8maGMqlzQz2qbY5g==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by LV3P220MB1055.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 17:52:52 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 17:52:52 +0000
From: Min Li <lnimi@hotmail.com>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH mfd v1 1/2] mfd: rsmu: support I2C SMBus access
Date: Thu, 11 Apr 2024 13:52:39 -0400
Message-ID:
 <LV3P220MB12022B2F96505825BDDE6A2AA0052@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [PzCDDYMYUdykLqaqX1jOKf1U2iY9VqCf]
X-ClientProxiedBy: YQBPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::17) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID:
 <53efc0ac491055cedbef156b3c3410fa5342e637.1712857691.git.lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|LV3P220MB1055:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2899e3-ce2d-4064-0d08-08dc5a5035a5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/9v9zola1v4NiQ/1AsVAeJVhDLs63KP/ntFGI7ijBy/VTT+/BQ3fmAiplKHnsLMiyQH0F3yRDJm/iEivjjgCR372+lFZwqNRGOarssJBAZs9nc6TsfRtoWJQpSlW5E7svVHPSZ50oKCz7HzkGcHgpLWzE1KpDJyRJ67Zn6HfSwvUs08s6Q5m+yD+Drxj8ZfJgkDDp6Ln5QGaZWdBNX1a+rvfuOaOWYH9/QS/e5tCw4V8VSy+FbiEWAtnuhuuMlUdjC/iMAHbJE8lSOnToCxFRHKMPnjbXMs/5JMhw7x9qvkkikEwxcMQyt+HQ7qWK8AvLK9QoFj/ae0peF60PC0d1clu1elEtnApJyvnEr7oIilN6TSHF6vNUtI4CHCNJmuVVf1iEquuKOSuaiJ1eBmevPI7FrefIdjqSXcCmIW5bn7DyI4vU3NfSB2jUJtvFm7f6O8iUuiC6aIpKmR4thlJwl5Ll7nq68K1aMbg3kztl5g57LMxtAGdv0335goD3e62yT9Oe9h4btRBV7Xa3Zz71Bgnno3oRMWQ6AzID2jMCDJoVovNOn9q5Zzfuq/N/YOW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/FKKXRND4NeUBbt1VGc+1C9afGPVvsUWSt64l9o12aaPhZDB0Al9DlJU8CER?=
 =?us-ascii?Q?2Pft8cZJv3ODlvPRZFD3rj48NlsiuuMZFfZo2Ds+gS9m2tkbVIGWYYCx2cIw?=
 =?us-ascii?Q?B/a7xpFkhPvXohw85lmB1CkgcpAWLZwAz7ziweMB6VjmwDjaO5J0uh0VbPLW?=
 =?us-ascii?Q?9OslnsNYD0i/x7E4UOk9Kfe9gTHG0WKQmBMtkGmp8RVSPLOITINzsdbcf5eH?=
 =?us-ascii?Q?a7bK00SEOSA+abRo1PVuWWbYTP0kItjLVz9k7luRBldmq3j06tTwK4UfxIVj?=
 =?us-ascii?Q?v5NS+JeGVnCEZ0CrvPjekeojVHK8JiTBv9Jpp9UQN7tyOTd84exOmoFFidXW?=
 =?us-ascii?Q?VIuVouO+2fC4YQ5ZIJketxYP+zPwCIkb18f4fMKFVKI9mY5FTMQ0wGiYa232?=
 =?us-ascii?Q?u+7dmihLToIhShMJ+mu3PtCRMv5S4EeudySWHhLlEwPbrbh/wLkxKASyuIO2?=
 =?us-ascii?Q?yaSNjw3v9/1qwW2Vs2bP8izP/pWqwG4ptXgvooJra5lvoKkfhD91qZNN2vI/?=
 =?us-ascii?Q?FZB+IBkLZEJ7grC369BkkkgEg+uVXmNJBgj4zk9XdFpMrRfsBlZ6GCqcRXcV?=
 =?us-ascii?Q?y1+ODp34YYH6e3POAE2PNkY0jt+mwMbxZgjGNnpBTr6zRZ9c6OVRdj6uudz5?=
 =?us-ascii?Q?tgwb8a6MHLsVMX+sxGodqnCBerdtNk9GH1b22JtNuA7CxdcDaKbpAR8QqudS?=
 =?us-ascii?Q?uROm753JTGJNeKBbuK4KBL7Stvlmp69Bpg+P6pBH4P+ocPR+xCb34hPkiW05?=
 =?us-ascii?Q?2EdwWFnxP0eCRQbL/qDRKx86ZNIRs+Nzt1nYDHjb4x/puBI1VnecEaXJFb7a?=
 =?us-ascii?Q?TiLT+k/+TA3Ku8yUqjiy0siZaJ0sZWq4tKQkXW2k2CK6vGUzGYK2GeffI09w?=
 =?us-ascii?Q?rtgvck6Bsre4ivirgtY9FsDqnOb0DEXeHcBU6X2aS0IFZoSSSlBzaw0nxzu+?=
 =?us-ascii?Q?Rx+codXzhadrNc5Jxkpur/7r+0fi/ws4PWeISPUWfY6nyJEbW/zmO4Su97fb?=
 =?us-ascii?Q?luZVX5/MwOO3o1b945XeaA33zIkGvXcct2E74J6aE+kDvQAcmma2HM57muWB?=
 =?us-ascii?Q?M8my4FnzoDZBC7mUra9DXPOAczSbzpHnWcKXkjcN5mvIHLWemypfxLcsFX1C?=
 =?us-ascii?Q?NXNTF6LEENzrWZ1Dmte05Y6U3R3zfKZ3tL3KtSWPMcUlzSIGHanKPzov1Lls?=
 =?us-ascii?Q?GVYTxhZxQ5+7u/AHy/Xn5fWUbsg0imO5nVMkJA55TsDUUjzCSCGqWsjkyvg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2899e3-ce2d-4064-0d08-08dc5a5035a5
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:52:52.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P220MB1055

From: Min Li <min.li.xe@renesas.com>

8a3400x device implements its own reg_read and reg_write,
which only supports I2C bus access. This patch adds support
for SMBus access.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
send the patch series as --thread suggested by Lee

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


