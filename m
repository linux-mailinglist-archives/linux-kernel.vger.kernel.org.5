Return-Path: <linux-kernel+bounces-50700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3047847D07
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D151F236B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ACF130ADF;
	Fri,  2 Feb 2024 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nB4dbEqD"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E945130AE3;
	Fri,  2 Feb 2024 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915414; cv=fail; b=A5JB7VWaEFfb5wAmMpWlhqFFAiT4wZtBv2fY3XRyRwudK1NaZVtVlu4/BYrSmN2wclQS0Ku0GKpVQEFfgOkD90GQjmwNXcRSIOLCQSRaNN7lUNPrEHoXgWswo6WQsirU89MbB7Eo9WshManSkBXDaAj6dqKTOOS4n5TZqio0fMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915414; c=relaxed/simple;
	bh=qW3xZSPxV69HhCqaxH4lMTpKrUoMPbR7IONE/5QS6Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kKJb5JcKOU+1wOxZRgQuyng+b9AQ13WT7wJ6fIpA9YwFD3yhZQ0323mZibJD5MZX809/M+OXzFd1bal/ihNU1BIeypnR9Q8XUY62z7RlFuRj6cEOUdbPvi2Dx7kuYyPhqFvTAKa+oi/TO4bbY9ceD6rs7afIb+QKQZDczv7J7iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nB4dbEqD; arc=fail smtp.client-ip=40.107.105.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN0NGlZc1Hp/J0dycMWIse7QcCs7pa1B1hfoeCtKvlLkTZTRrxjW6kPqo7iq4qKu21cuuAjDXBPt8qhQxAyMHuBBI9JHoVGSs1v2QZfLaiQ0i9zaGqkeIZ9jWLy/szr0WMIu2GkVfqUTB2URgn+rmByGTfUG/OniQunojRvAYSAS6BXFAir5mQlyCWUrXhYDfI2YBL006EBi9dkSyvXq9j5EaBbB4gKKFk4s/6xHdfHRiy5JzmMN3dJaUR98mKsuA3baWBYzgBMI6W3N52IfpSMuukrWDH42OhqVuN9FtyGRbOLWTFhvg35GiKcvxU5Z7EMeVjy5zYxnZusxSoaFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=k98gRmZlhyljDzrYxpkAq3jBPU7ByZSL0WHIhR8AixIy1IJQOcvVsFz+uoRC4BFAt4xAwTOtzen2alErnjHZRWjMPoh5al8xQjnAIL8PSk46MuGMJiX9HhoYzlXEbg67hyuivUdWtF3RQV/zqerw/FLLduRsR7IrCuUb/bdLQwLcpakotXk1ULJUM4BCIwqgPv9uc4jVTOWPiYtVNgFC4s0+0PpsilmC97lDnw7JYViFbq5kdOIH92IPLgg0AE5yXKr/YN7MBcm85frLCknnRePfeKomyYUstsVAGUrQdzkvwrACl7B1BZjrxA7BRD63HIos59iGJZELtwvMOrON5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=nB4dbEqDqMefBXvKfRGM5jH7ZIoH84lTKdlLPlPPgAT3EbDH6gGBxa0H8di1CLQcqf7oEK5k49msJe62oKMnhh6F/ZzbuKjj9y7ysJsZ7Aj6gzyeSMCT7PSXfrtAEy5MeuUdq0G/crtsvgAExZrTdLnYClGWBMjTKC34jK21/WY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9997.eurprd04.prod.outlook.com (2603:10a6:20b:67c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Fri, 2 Feb
 2024 23:10:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 23:10:11 +0000
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
Subject: [PATCH v6 7/8] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date: Fri,  2 Feb 2024 18:09:24 -0500
Message-Id: <20240202230925.1000659-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202230925.1000659-1-Frank.Li@nxp.com>
References: <20240202230925.1000659-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9997:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6f4271-3085-43f5-5927-08dc24441b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2e19k4956BBOeuZould0nj4I3dHdeFg4iIa1IYPhpZ2DnS9y86roJJb+UxjbH1xruk5ssM6mvrVGbzX4I+ngHp8f4gap8n6Z0neYSkILflO99sn97SKjS1zb721omV+N39cuJS+/WzihHXm/Lu2lFf3TVmVmWmLP2/koDIoubtBzGQKBd+hcoMAqtxrcWvnuyLZxEN+0ohjurX7hw1va6s+cAxXZm8vh/CVBzNGy0SHLJcvgIYgNUT2tRAPFP6aLuVSGbwpRGag7eIHJPJ9QyBZoqA+AB87LaRySjvzfYM2/wYfPgyMxLZKjEwXzXPZRInQ0m8cw98aM3QbksADlSZ6IZFQZsAPstyzzTv08tvY+eVjcswn8R4Zbilinm7SouRrp5pTTSCQbcP0nNI+bGOoiW5LxjQuPdpLw5nxB3b2NHaOQookRx5QqjvuIto2JV/PLghXsRHHY2D1KdQKGq2L1TDkP1O/KzqFYmQIGjMGKnb9QFreZ2aaUB9YaohC70ZFIPKZzFsKmBKFt7garki6sCI3VUlXQSsTLELG77isRlbiKiAtGLNfGd8/EE8p4RB2ha4H7jiekJjL2HRmFqGu6u+S2jH7ePM0wUOVhnUsHwdX6eGTphQGd0p1rlULv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(1076003)(41300700001)(26005)(38350700005)(52116002)(7416002)(6512007)(316002)(36756003)(37006003)(6506007)(83380400001)(6666004)(478600001)(66556008)(38100700002)(66476007)(4326008)(6486002)(2906002)(86362001)(66946007)(8936002)(8676002)(34206002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yhJx0QPRyEDZDApgZ+iDO//7kmulgB2u1WfdUZ1ivJA4AvL9pga8NbcQhto8?=
 =?us-ascii?Q?wJfsI277CUeTPXxR2hqJJsv+RiXizK+Z7uUQjyktmyuJ+9paa4ww2qXueEPY?=
 =?us-ascii?Q?AxwuNWG4hXpDbsXDLpV8hNxXTyQC0/IrB7IrfAwRibjZqS47OK4tqgNuEdHc?=
 =?us-ascii?Q?6PfWtsisR10GjyoQrx/s+Go9H73f0JF5OS1P0RJnPcgXOMoTxVeO+oNxdht+?=
 =?us-ascii?Q?pbKxW033hC7fuL1LDh9SR/K6scI6p7W1Oj7ZPnmRemLFhSXbWEtMdPS5UmHI?=
 =?us-ascii?Q?PX2/X6yWfHJksA6NdQQHsF7H90yePKP3dxUydP/abkJAmuyrJT2oBs3KUno1?=
 =?us-ascii?Q?Fuok9SEzkHch+DYUR9DhxW8Z0RBVqLm/7VReiPwpx/vRV8+QcpvbxSS8dYTI?=
 =?us-ascii?Q?eBG/KTqYl2xJCfjjvi7p7ZJkTCoJRt9zDunl8hrz1Ovs+mr9a8vza4TRYRP5?=
 =?us-ascii?Q?IcPdqTUB5FvwjzOJdjXcbJichSlp0yCNOsUYgwzyObqOSVI6BNJk7OhtRWAR?=
 =?us-ascii?Q?HjAXEKCca/0R4mIFwW756GleKSTO6I41KDxZzNuHLVqOe94ktwi4tSesN/W5?=
 =?us-ascii?Q?MWUVMcp0KVURuEtme5+6LRRYlbV5eTXwebc1iaxk5IEym7CQpLE8VgMa1HDt?=
 =?us-ascii?Q?mCKBVp2Dteu4fo8o3gRukX9q9Hsgt2o8MLaFf7XWrIEXNNawCfbRHOJAwhka?=
 =?us-ascii?Q?Mp3Cj+e7i3K9SyBz3+HGDI8Hpmdu8ghip7n4Pf+pgAg1lK/hb69QcB0l+PaP?=
 =?us-ascii?Q?k3LAulRlZaNQ/ZzkqmTSXctLEz+2l+zTyVDaP3u3g/wYPTtpZInPQQb9JknV?=
 =?us-ascii?Q?lKJ2rQzZYORC04L7j5JKZn+TO8u8pZMvakABd9QThmGIHiKVOs9GiTP9BezV?=
 =?us-ascii?Q?l3cmadBbcAR94v9DB2BHgKVeFVJ3GR5EHTkFNXUcVwjsnq0S7GobQ7FqxCse?=
 =?us-ascii?Q?r3nI7JHwOtfuoxb4fbLlAJSV7mEwmtQjzV667p1qJnzV/VrBn605HcVvHE4v?=
 =?us-ascii?Q?BDLb1adKZYjcHYbsSvsCGexadK17PmE2gLhpd/iXUEji7qx7h/X/CG9S8eD3?=
 =?us-ascii?Q?XK3oe6IK11Y+QVUl/hctQge2FrQO0Y37TxYgg61gyMTK8XjnRvn0ZOqI+Smv?=
 =?us-ascii?Q?H0XwtSuw1AKDItK93LwCG2+h80mP4LIUb3/7ShUIhVoluK+cx4MomVgH53/q?=
 =?us-ascii?Q?5KhOI6V6hRONc7STAwWQG/JU4N0jetrb2d3xdoBITZ1xJ/zToYR5WQqqDR2t?=
 =?us-ascii?Q?Q9dzK7zLv3jZeW1BMsTwxgAuJp5+Mx9jftHu6y85IldxL4P/Wl/J2o/7Po28?=
 =?us-ascii?Q?lSamLJQaDRbJ+p2qpyJyKjL6So8PveTpf7UkiT4C5XGMHfARThdmkpG/nxyW?=
 =?us-ascii?Q?OvFkvMUs0t6SCfd2aNgDH0FSadVSb1xFgEDqw3aFdcRBujaiNQ26/FQaWiab?=
 =?us-ascii?Q?PNnM3JHyS4JaDTYaxtR0kkg5qsGbvqrsYNrLTwzlvV+GbzNB5uUqJpmPC/uh?=
 =?us-ascii?Q?KXy/iTMZnNGY6zRrCGXMdTfzbvGp2+M1W4KVlwHtaxmMgaWk4At5kl3nw3an?=
 =?us-ascii?Q?0znEgOTltLtiGXafE11/lRcWzdLMEldZskIZS1vW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6f4271-3085-43f5-5927-08dc24441b31
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 23:10:11.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tOYJRThW4Bo2fWvgfEDRQECels9yMEb9lG4DmLQcDXQuu7yCKtIfaIgKvGzSoEcZKpojm/d3EVpZmdNhyWv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9997

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


