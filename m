Return-Path: <linux-kernel+bounces-54095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE984AAAC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9173D1C22705
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937EB50256;
	Mon,  5 Feb 2024 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pk1pQImR"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AA50241;
	Mon,  5 Feb 2024 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176058; cv=fail; b=WCOwNjJdilzNOBYFmNzM74HYE7aIAngy4yLZyOV9xa/WIDVreBCZX5W40plLZO5JG6H4M4bnRWqre7hqzOBaymB5Qmh17bjySt0jNPAvK4sBAV41gegMba2S2gTcd+W8ISlRcZvh96V1PIMQfW0a1L3A4eVQdBCle8ZuwyPDsJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176058; c=relaxed/simple;
	bh=qW3xZSPxV69HhCqaxH4lMTpKrUoMPbR7IONE/5QS6Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jqt5ZLzSKLjkvRqIbnm92hkHmoPFrNWLEb8PObXwRn6aVMGTVFON9QvYk9xrg7ux6yH8YIvYzohBUFwb884ORTLTG1BlSivrFftaUlSOZ/JYzdwT2d4m915iW+UF9+bmIZVm5jZxybbSXLxh1quD97VUTWCEi3qS9bO2xBMyHAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pk1pQImR; arc=fail smtp.client-ip=40.107.7.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuFN4GCyNXhcfOzsSG4dpv4IK+WftmZJTnba5orX8Z/ZSaf85emO1laYo5bXNoQ9e8WzJtHyP2VMDCy75FoQkKC1CI5IdTfGmEhChZXU+fXZpt677OfNW5jKV2dHOanUz0VLtgOQ08Xs8fGMed0G43c42SkGXcx9AtHjyDKbRFxyg1TVknmvc0QiGuZfFGwPx2cu/aMYR5kZ4s2o09lV47WsL1VFGvEV+HJRUZxfjKr6gV6PuENUvz+cfax4yzlRY+RgfEOVJan6744KESfrHXlE+J6WhtPxV5MscdKV4XLpez2ANYdS4dLCGM2u56NQotGmT7rlqW51atEtaY8V8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=Dp+Vx+zmiIwuhH63to4Aj7jHLYAxLIbpna/ZHxQBVngUNUFAMUinTRBWf7HWT/kPsVUWUNHqdh2AJq9D0byE+m745JkyrS5AjZJ+V+tm0wR9HhpliQjquUf+NLvObqyNE/3w1iLsvKuw3ZqXVnURrL6X5iWDgLJQwLQEwJZv3sEBDf7QTA2HyNEiE8VsKgyt0QaiTBEMpI0NCacXuoj9GQPQb9oWchuqrmnSsx4+Ub6RnY2BBbu5sfxkDVzJQBzyw3mGkK/aRAIUD7WG7h2vSLXFywxi6h0mwwR5ydF4VEMIw/AD52RyEJG3x5C5fAJu8JdVsZBbArsKyCjkektTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=pk1pQImRT4Lsj32rDUI3o5KyEJYqubChH/XzaPHnCQhmEMnvvfacxUf2g9OC0LUWKImefCajXsjc9qYTjHwiF/rfhwaczXTi9fpLXbHvNqDy8uBt8l1KMbwhTfNx0h18cx6FyFeXwW/WRTIxzbkj+S340gTeeUYJSoXV2yLhupA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9205.eurprd04.prod.outlook.com (2603:10a6:20b:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 23:34:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 23:34:12 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v7 7/8] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date: Mon,  5 Feb 2024 18:33:25 -0500
Message-Id: <20240205233326.552576-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205233326.552576-1-Frank.Li@nxp.com>
References: <20240205233326.552576-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 67880ca9-1b3f-4f63-cccf-08dc26a2f538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E+qIA56m5lvApYF+o1o7GBfoj5UmdHfUteXKzQRE+xbjNIHyNj3ZqFeRDh/Ds3kS7FJ/DGEFuB7BiZGvKGm7MHnhcsmds75+VDzIWFjG+uKwPMAq++RJWfp/uPXuO7NIYGcASny3FAeaSpHfdSkGm4KdEvb46JYJQdFNWJNoBmS+xsQhd4Sa02xfPTyVyVX6oyD3T/WstcEav+jZDkbZhXI9OCAVk0uSmsr2FNwS0ttCOPmAL1FCZEHDb/8FJiP9Q0IGJT+3RcQldSBPuCWCrsfbin0vWY8FxyMOZ926/GcC/xoGT75fzWgB27u2ohAiBW91OfScPASlE0K/XsiYcynLdeCeTtAgB57jdKEHuewlCjX9R3+wJnABaUE1XVw7+yhc4ZQFkU5N9cyS9gzHD44e7mLypIxAhsjzFNVebkCh7Y25ahp4NGFM4wALyYV7Vd1U7POo4p2+S2/h2ZHm6h4LSIIGGpGpc4XavlwIcsUPT9hOmFB9mU6gm9kzGes9x+3aJg+JI2v4B1aGocVsHpZhpXzsdfKvXHizH+K4pgIzsPxfTiBySEH6kIhP2E00glChrf9MNNU//2FebOTYEnkTCtil8+EtFUOHlc46HA/1GbUjuVT18XNbjmcBPR4h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(1076003)(2616005)(26005)(86362001)(41300700001)(7416002)(6486002)(5660300002)(2906002)(38350700005)(316002)(37006003)(66476007)(66556008)(66946007)(478600001)(8676002)(34206002)(4326008)(8936002)(36756003)(6512007)(6506007)(52116002)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rFCbeAkN54O3jnosWw7KLYVF0OFEC9DV7zX7xw/bvZ/0jL+Jmu4Ak7iC30sR?=
 =?us-ascii?Q?KzjX+loBuo9XQt04UgKK4kqYXkl04ttaRUgXboHjLYlbeTmOIT6GcuYhJbrp?=
 =?us-ascii?Q?zDIrF2/C7tMrSIEuf3F55sF2wgG4R7H5UNXiUuvRdMIYO0xTTup4NV5g4UJk?=
 =?us-ascii?Q?Lk3vk1b0oxqNNIHACgAb8j4sqQn/p9Wkhh2LKAxvnU0UW0V1BfHSb1fxlXlg?=
 =?us-ascii?Q?Rg3AdI+nKjjIHi74R/i0PN5hZzygSdPVM4UH24tgXuONOD6jwENFYuGDeOrD?=
 =?us-ascii?Q?l+tppC5Emp3voNP2X9G2MtAlIF4SyqEKHzbpptqXwbInQ59bAyKmClPsIFYb?=
 =?us-ascii?Q?/FJvVX8QYx0uh7pzsGZEooAK32Mbf+TfM0rlbPghwvrPfSx9uUfE4uOFCplI?=
 =?us-ascii?Q?+ykXZatMmQXassfnHqxR53Q+LghljuaPB8r6+q5YgJodGiK/rkIPZhLulN0s?=
 =?us-ascii?Q?SUyAeQWbSBzNkWDEIGBkS6zcODvHbLuEOaGgTwUY4tq+bYjzidMhDQLS/7Sz?=
 =?us-ascii?Q?zxJuqnEbGI8Q7ileU7ezpIa3JH4GGpJQ3amiPNI8kcsEEzop4ZMqoTautde4?=
 =?us-ascii?Q?Q1wnCrWE73yUK2idr56Ax+IX2gKcx75GxENa+I1NXaZ+srTkZbVRyG/xmSwd?=
 =?us-ascii?Q?vvkKuQz0JivGGXFdIdSPTKwZkYe/8rZW8+bIQi8BLdz548/ZuQvx2cDrLibO?=
 =?us-ascii?Q?h8FDvpAK5lJ3T4wK4kpeYZeaLgz2kWuahk5ZTjweoLG15/Eksx0iKAb/LJUK?=
 =?us-ascii?Q?FhYoabxpGq6RSTbLAf/pflH1ZGC0LBR1dmWkUI8GaGO0DZd+PwOnfPO87fty?=
 =?us-ascii?Q?HEHZkwESf0Qvg5p0jRADXq5GJ0Zpf3iRFetvru4QD7i+EjgBr97YP4kQzDBf?=
 =?us-ascii?Q?S8vyuSL6BUFCkIpXDgTXpW9n+A5tbDnzaaWk0OcOKaR6bDdZSWOTkXhF2rdl?=
 =?us-ascii?Q?xfhr58Iqiqk1KOLSxaKvj46VgRIQpk21mFziLlcfglpnLarUdcPmexhoadDH?=
 =?us-ascii?Q?ZdxK3QZ3Sul7dKziSL+2QgvyeONPsshM4KTMsXPqqLut/335C9LWTmNNKhvr?=
 =?us-ascii?Q?JpcC5n/Hm/6nFYG0fejUeAle6XIE8S3aNQBSDYfJ407tnxI8HOITuIqV71QP?=
 =?us-ascii?Q?pSXrvZr5Nlpihs/M0RPvS+B1raNZq6lwRkxGmHh3oMmufMiLjdus36Pq0nqH?=
 =?us-ascii?Q?aBV2MzzCLyT43wJTDQ1nL6gmsShwDpLUjUATW1OV26QEWdqd7fBvzZHogiO5?=
 =?us-ascii?Q?zQLSTkbRlfPM3uBzgDzSLnwU8uOc5S3oUCGmMSGPCpfhL9KbQbpB92p6wCZy?=
 =?us-ascii?Q?bTPM8AwImusDQTgZC89ZmhTqKeCHSH9yaf0YGog/Y9eaqaoxCZj3Y8dWKZVF?=
 =?us-ascii?Q?z6Ro7mELQ80praKM/E4+lwdG0N0dCGp6I1hMgXvUXqmuihP57exPSAcqkwcB?=
 =?us-ascii?Q?RBsUPNDG58Cqe+RzF2l5NE0IB5ygm+BtUSGG/GF+Z+et61f1xnaMAjdkyjhR?=
 =?us-ascii?Q?PS81YadiUhjEl4b6poNGSdAlFSIHMZ/TriMkwBQdA+ETz01ImFsXSUUIeDGt?=
 =?us-ascii?Q?dO2Z955id8mrd7Aecd8PnUAuKooct7/Tbij4entc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67880ca9-1b3f-4f63-cccf-08dc26a2f538
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 23:34:12.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VT0CkpdGr+d8b2i+GWI792D7AUxxnR719i7RE5dcEKGiPJo+eJUNRvHcgXoRixFRolvXeOptv4SWF5Vu7mp4wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9205

I3C standard 5.1.9.3.15 Get Device Status (GETSTATUS):
Get request for one I3C Target Device to return its current status.

Add API to fetch it with format1.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/device.c       | 24 ++++++++++++++++++++++++
 drivers/i3c/internals.h    |  1 +
 drivers/i3c/master.c       | 26 ++++++++++++++++++++++++++
 include/linux/i3c/device.h |  1 +
 4 files changed, 52 insertions(+)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 1a6a8703dbc3a..aa26cf50ab9c6 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -196,6 +196,30 @@ void i3c_device_free_ibi(struct i3c_device *dev)
 }
 EXPORT_SYMBOL_GPL(i3c_device_free_ibi);
 
+/**
+ * i3c_device_getstatus_format1() - Get device status with format 1.
+ * @dev: device for which you want to get status.
+ * @status: I3C status format 1
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status)
+{
+	int ret = -EINVAL;
+
+	if (!status)
+		return -EINVAL;
+
+	i3c_bus_normaluse_lock(dev->bus);
+	if (dev->desc)
+		ret = i3c_dev_getstatus_format1_locked(dev->desc, status);
+
+	i3c_bus_normaluse_unlock(dev->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_getstatus_format1);
+
 /**
  * i3cdev_to_dev() - Returns the device embedded in @i3cdev
  * @i3cdev: I3C device
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 908a807badaf9..976ad26ca79c2 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
 int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
 			       const struct i3c_ibi_setup *req);
 void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status);
 #endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3afa530c5e322..ff61a218bcc6d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2988,6 +2988,32 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
 	dev->ibi = NULL;
 }
 
+int i3c_dev_getstatus_format1_locked(struct i3c_dev_desc *dev, u16 *status)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	struct i3c_ccc_getstatus *format1;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	format1 = i3c_ccc_cmd_dest_init(&dest, dev->info.dyn_addr, sizeof(*format1));
+	if (!format1)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETSTATUS, &dest, 1);
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	*status = be16_to_cpu(format1->status);
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
 static int __init i3c_init(void)
 {
 	int res;
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index e119f11948efe..66920045ff042 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -345,4 +345,5 @@ void i3c_device_free_ibi(struct i3c_device *dev);
 int i3c_device_enable_ibi(struct i3c_device *dev);
 int i3c_device_disable_ibi(struct i3c_device *dev);
 
+int i3c_device_getstatus_format1(struct i3c_device *dev, u16 *status);
 #endif /* I3C_DEV_H */
-- 
2.34.1


