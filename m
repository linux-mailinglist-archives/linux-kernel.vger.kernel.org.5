Return-Path: <linux-kernel+bounces-36074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5EB839B23
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FB91F22642
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD014F89F;
	Tue, 23 Jan 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nbzwooXG"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E24F602;
	Tue, 23 Jan 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045199; cv=fail; b=iQK2nSE7tNRsUY8S5aS+c9ZE+iBsdbxaYN6soCm2x+LKdoOzLAEHEfQ5F7590iyPSrvgJyn7RgfvF9YrKGG+vOsGB62xlmYzXxnJt2nZiJ/DAp+U8m4wzfhrdP9glsxixWJ347J9SqV7tW3tEox3zZTuFZ7EOTOCG5y7SNBD7XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045199; c=relaxed/simple;
	bh=qW3xZSPxV69HhCqaxH4lMTpKrUoMPbR7IONE/5QS6Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VBVA/uNW9Ew8/C0kpmyrUSZKlPgk5ldIAm27r7KFBnv2WgMu1AjCeI49KCZZXOQ+tl1EpT65BK0/sACTgyhKheNM1hqwIICBQjLdR4t5z00yBYL+wCDdyY+mJGEiMCmKo+N1yQk/Edl82sDJSx+PFu0WZD02VC6znlX+fnXjYOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nbzwooXG; arc=fail smtp.client-ip=40.107.8.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQkoMnKcI+cAHlqwDxkZe8St78cldX8mLX13TydtWoWBj17qIKrSS+/MHeDRyFeN9wGXxfWdBbErZMyMXfnhNFDh0Iu6ZknHiEOTEVL3czld9AlwRCdYbu8YtslLQs2H/V7nprQLH4EIVsmb1CORkIX85dykftT9/Xg3+wy17FAS5EVUXwWrZPFBw9GAVjJEvJuhOBjho4DR/hy9Jp6qtgQhRh/m8B640wEoJ7ZqGK05wnZkPyXdryTglT/XP3X9cc7jJMCXQ30VuBkOVK8fQUmHUDyoZqfJ+3lHqx08JNVTP7gPD8+IcqaaIHIGOPosZo+NuhMWbWxeHDBFMvNwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=eCZYYK2+Vop/Dn9CY1kZAPUpxPPxmhSKUGyzdc1FJAojn70A6g2gR4DYzOl95zuXC1urkA9pHlAo4jUZ3KVaWy1eajayW+ry2ciGsZAqQ7Pb2aQqD+1u5fZTPzTd4bhU/9CEsfYtPco4xFQsOyxL928aGUBW3yfqc2guzgGZfcfZE9OIOKN2gzQKwbgXn5ephbcGZEKEHekXjgBKU4keruvpOUI1fJzCjxgVqRbjwYudIYxfy0cPnoqhvOUiN9DYPDnZvI/V9qIVHvMM30DHfm3KgJIec7YqjAgX78RH6daoSwbRvRmMSLp4ZYhUHY30KZMe56MMnr8TrJjqQE8pCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=nbzwooXG28MsYrQ46t2SBfeCRv9vdbirXMa0W9fMDrXMj7t+8LExvO2xZD8WejZLl7eZAJ4TknVvOk3pb+Prm0XnqogqsCQu9Epa9oTgNz+hfljPHQFTsyd/hd3PNzGzVtj3NYFeCeqD2Or8p/n0vevP1X450RhLkU0xxC3W6SA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9553.eurprd04.prod.outlook.com (2603:10a6:10:2ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 21:26:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 21:26:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
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
Subject: [PATCH v3 7/8] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date: Tue, 23 Jan 2024 16:25:48 -0500
Message-Id: <20240123212549.3858137-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123212549.3858137-1-Frank.Li@nxp.com>
References: <20240123212549.3858137-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3eec78-dd0d-412c-66aa-08dc1c59f9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VEhdNmPsduZdhiXpc+MT8NviyoANebv10G6W3fE4xgYE7LoTwFyNIwVIBhTckWPPUc695hKZiJl7/CWBm4+i85jgKiZeLAC0a5zTVgCHWyac8VrzerQLzwxF6grllsw6jgpmcQ21j5nKBFGtKmE9RAGsZpsa+q5yszN8raL8WNZE9pL8I5ZqcjUSxYgGcEibMoNNEkfxizu7HMTfAoL3rKLCB0dgWreqO+ZLddjcw5SYVYdONOWbxwOomZvw1fS8lXK4aiJ8/crV3l0UcpgbGo63NjIGbBb2uc0FKrM2rMEVb2b6UyAP/Sdx5+Xj2Kp/fvD3+9I8riLA4ZU6gpAurtcGQbgw8g+TbKq6uAZLIFvxDzf7lfPbDo4Ozz97jc3Abb0EExyDxAnWvTEdJ0w/XEhkc4VH+OtttWp5ytCdcrMI1d657ASJdG8hScuwJZU5iWRTYNAYkZN2Bf+9ahXPt+LZbwfAY7STDjjgxwPJzbQaLRrN1/oizukpIfBbZpeitBffJ8a0U6W/j1KLGGwT2MR0yJggI1fbIeyq7+qKpax812vTu4Fcb2BdDPNKGU0M3v9ArUVGAr9kWdOXgy64e8uLqMCXX+LIWRZS6NC8jYkN9rcif+cd3HS6kXtlTikw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(66946007)(37006003)(8676002)(316002)(8936002)(34206002)(66556008)(83380400001)(4326008)(6506007)(52116002)(2616005)(66476007)(6512007)(6666004)(478600001)(5660300002)(41300700001)(36756003)(38350700005)(6486002)(2906002)(7416002)(26005)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sqOV5rqtaH2Q2JXn3duq809CKGprlvBtGGOTyRzZaVQ3R4E4m8iqbmKj12l7?=
 =?us-ascii?Q?cBMMsegFE0GaNA6BA65kWqPwAWtaLeDCsV7kq/FyBBtfWkIGHmT06a7klbRH?=
 =?us-ascii?Q?X/XV3DvmjpudGBe83f4QN+8JPlcbVhnLSIP+hFMIkhz/UgIyAcKy1aRE/Xqe?=
 =?us-ascii?Q?PtFQS32bzr3zySuW2ZAwuHUN8LmHcyTXrXNMWGcoP3lWLgW1qcP/FeqYaHdP?=
 =?us-ascii?Q?2yNbkREaMvh3ZRebz0OCGG3oJmo0xYpKO2FiUfcryBH0MbR2VesdUr45YIoy?=
 =?us-ascii?Q?pbkO7MXdCDu9Fr7ZTaqOQWR7ANXMZQb2/1sZOYCWgk8sQeTBnCu1HYRE1Go4?=
 =?us-ascii?Q?zNOs63dkZGoFMXJ2Etjly5NaWbIAxGP9IX2zEkMUt0xXZCudDwDln7sj5GM1?=
 =?us-ascii?Q?f7P5kbnCcP0bFdi+ERsWpy9Sw8VYwRWz651OK7bYZY/xkGyjgcW6QS8dO5Eq?=
 =?us-ascii?Q?XSa/YAgjA21OsJa+MhVC/c2gt0GKZHsbrdi4oURzsQ/CfbP4R2ZeCpn7yppT?=
 =?us-ascii?Q?+M5HUeDZuPYQz4cLsBsGt6ExAxsdEbr/m1RdmOh10sSnD7R+8JpqTUygwAdE?=
 =?us-ascii?Q?AT6SoA9M/t6h5VhmlG9sjEy5gxENbpU15bAJHPhm3CCgrTVqboDrEtCU5sLf?=
 =?us-ascii?Q?4e/yOTZhzpYIWPzzYVT8qtTH6+G/RDe6CIWKpL0Z4AjpVwnO/WmFKIbTzotL?=
 =?us-ascii?Q?qiKajWCWhHZM942iwwLDfpFKlEFQPxqVLu+yAFCNfMJUhWoTbAOH92KMKRpq?=
 =?us-ascii?Q?IKkF47EfzVuvCljT0Fw5r/BAyvbbJ1rRmkRFHxTW8TFKwsSJIZ1zzxMb14d4?=
 =?us-ascii?Q?LEDshnYGNPZ3wbk2TCSLEbW+V1nwj0ynAbNVwF2mUjEG5F3qeYsDkoziULsa?=
 =?us-ascii?Q?8X7AHz1iiuKAi0X0VoEZL3m9lxEOkn9fqsL3Lj5mDaTAUlQW6rJGGT4RELm6?=
 =?us-ascii?Q?FHQ2t2PDBKGGMlw9dj69OWS4UFeYupYNH8AXMs7jna20v7yg0DbfbgkPYVHi?=
 =?us-ascii?Q?I4Ug1sfK2y7fHmigKIhV3T92Un2+85b6y9fDGRkvQn5yWA1rt50FwEhPmRj0?=
 =?us-ascii?Q?i4ufuHbI8PYjnjKucAYI9bHRLS30mF1ZMl/Tsnscz5zTrIre0NDnxsEuaRY7?=
 =?us-ascii?Q?4R3FG+Hj/sfhnxO5FQYwApLnB4r4scLj+G2SML0pWY11FCBjeTs6+fAWcSEE?=
 =?us-ascii?Q?3TrHQSm331+9MCyqZcWzRNuTLpI4NQNKUb4GY8MIyRwSQ3jFye7TrnyOWQx7?=
 =?us-ascii?Q?pvZbjWsuFZtxLy4cCd7sXD1m91F62fzwJ2e+M9jL8c/kt0KN8kURTLD6bZvb?=
 =?us-ascii?Q?OGfm7yC4aMqWBBVH0a8LruHWAtu2ZV8nKAzcpEEoXM08utt7cLfb6MGjNKXa?=
 =?us-ascii?Q?tjuVH51g3Bw7c/1I53UlcPU15Fn9me0M1vQCwC4EjRZMqOFznQGdimHkHo4L?=
 =?us-ascii?Q?W5/lhTzf0WqFWGnoo/gUiuIgZESvaTjuFhERuHVkWHiYTKLtqusHmmrL4a2P?=
 =?us-ascii?Q?H9aJPSz94rVrp5BlKaL3Y28YzPDECP6UJIvmni3QDghFNnHg5aDoBOTB6iHn?=
 =?us-ascii?Q?GK0yoHrmmxcwL6c2nP9xf6TO550rDWnrk/3tBk9h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3eec78-dd0d-412c-66aa-08dc1c59f9a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 21:26:34.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMowag6AmRtl+rwcmJKnLtFR7r5PBGiwsmdi5ql1C0jYgbjUSGhogRcXr1m7XnZC3Ynj+/ATlQJyLAWzpE3w/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9553

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


