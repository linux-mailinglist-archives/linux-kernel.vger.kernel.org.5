Return-Path: <linux-kernel+bounces-43439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22E8413E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1951F23E08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ACC15A4B7;
	Mon, 29 Jan 2024 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IX3FTQ44"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2058.outbound.protection.outlook.com [40.107.13.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0315A482;
	Mon, 29 Jan 2024 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558054; cv=fail; b=ZMspTi/1Xk6S7c/H23ysUVswbf/RoDkzCzh6EhUeoD4SLGMJnMwdvvUuHoZS4gz0usdEpVDnQ3qjj2CJD8QluknyzaIqBwjRu5WBZXlFXmbI45Lv0baMrh/tVOrzTLpIJxHcasBOss/EVD0Ad0U51mxPJYsRfdfI4hqa8l2ud6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558054; c=relaxed/simple;
	bh=qW3xZSPxV69HhCqaxH4lMTpKrUoMPbR7IONE/5QS6Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GGnxQqaZdcO0ai4Zkj1qtW+A3cAXglschXXzUz9NSggEY/3M5ulPnyyCPa8Crt1bLPx0YxtmwCjbMkHt3HrX20Q2sDiDpUNv5ynZmhNesZThAMf4fRhhIcTJgCEKOAhFZ0JDTkjObA86kwLCzgZ//SXfLlsjRKYU9m73cz7VbBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IX3FTQ44; arc=fail smtp.client-ip=40.107.13.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja5KbNayUsHiToz0hrFzqI0ZfDCQgDdi+F1Yxn9mhEgwMYICM8Mf09nrZZha0uqcJHSm5mL3T19sWDe9ZgOPtl5qmedQBEpQpOolLicMVl3AP+HaxgFcOEuX10Q7Os+gUeuVojpnNFvh0A5T6oZwgxJwzP6Ye8sitw1YwB00wpgnysjyw5QKbQkMdQWwwwDeCCR5CvY1hAxqWHJpSITXzqYPBUHFAqiLfyxe5WCCh/IvlCS8P0zRb+oUOaEq9JFRZ+GGDtbh4lqjd4ZdF//ZcFCwgRuVX5IzwrKgRr5eb/eLZfGN2ygSx6seD/V3Tg75O9v4Su8Q7rZzqjX74G6pag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=g9kLR2JZXIzzjPGlvPkOXrB/GR8Ou+NUp5SvSnwH7g1UnsSM32mnYuQtCBkh63mcqOX9G6yu1ihePuZxBkO9JjTFz2T0sflxrCqKMQrMTqNyv0KC6d0w4NNCtmEPpYkL2NTP2dfkJ2bPz7r8K+Zv+T/qdkDZ7xxd66lKkKCMUJBV7Xy+DN/xRqg9YPH5cIXmv6TroBlonF0jbqV7toufKFJ07oW+mP/HYeeEmtpgRHG5TLPt0KhAvnh/bNKV1Cro2mO5LqTln9Q6eebF5iOMj3OCiN7IlxeIcPnmIMZ9OSwm0lK54V0seDFcUtSd6j2/yMejoAzTXoSuMsbQNqNjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=IX3FTQ44KGIXgp5YDirWhojfiYOTN5/K1VaUjCfG54lerQpEbjg3GAktzd5saVwazG1SR9ZiU9Vc+tD0nOIUYZZ6WQvOrntV5BZBybRbgUQdZqdpt7mGjdR8EifSkD1E3Zaq8TIlQdbTqNWqFfFkKUPSWEWDz5FCwcyFXxhZUM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 19:54:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 19:54:09 +0000
From: Frank Li <Frank.Li@nxp.com>
To: ilpo.jarvinen@linux.intel.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
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
Subject: [PATCH v5 7/8] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date: Mon, 29 Jan 2024 14:53:20 -0500
Message-Id: <20240129195321.229867-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129195321.229867-1-Frank.Li@nxp.com>
References: <20240129195321.229867-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: c802b221-65dc-4b5f-21de-08dc21040eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kZUgcPk/fGFL+Pl+j9IrrL1zAPH1iBsaRZosGJelPR5wLif5NQwRPiJhYgUdRwk+ghmj6tqT0eAn3bNIAVKLciBDoUMgcoRWUKr3shb4GJTwBityOYbJUWS0F+Tv5jvv2eo5tmYxq5XZIlGBCSFbXrL9Kcb1zRK/ISuAR9MCI6BUYlbtgF+vK9Z8yWz+wJmO/FU385VJtxTGvo5a3mN3KG1fi2C7gQMCrVFQdrTjvOohD+rCfEBFRsrDViTHbzm38jNtyA5xDueg8Vv5MipwiGIgIrsgWO7e50F3sSGzLSG4W0IhxoPCGSqwyJD6u3nb6YXbDJx12J+xKA9ErjrUBzBgLLPChiWHRmrro5NydYeoo5he/K1pUREo4bwV6X4ywgJVtUS4SNRHBJp8uz8Rgy9M1/kKU3UlAazMBd3XZHFXjyFS8dASpLFvU8tAvMyYDZxM1Nk8Axeqsir5zM4Ijn8bnw/qMf7nyCPnStTM7jMhP8K8Lr5iURf7Ihfa7Y6MZzpN6nWV8RjIE6rVaiyBOdcQFkSYmkye15BttXyftYevcupZ9R7S7iK0LttGFbt9kidLzkeuz6qTJbNhWrAShelz/eq7l16F/eCgosnP/84/DqyNt7TUW0A1MuNNaY7w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(52116002)(83380400001)(6512007)(6666004)(6506007)(38100700002)(66946007)(4326008)(5660300002)(8936002)(8676002)(7416002)(41300700001)(2616005)(316002)(478600001)(6916009)(2906002)(66476007)(6486002)(66556008)(86362001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OwnJCm8diFHQlh/69CJKHPIEFgY331duu77bh/Fw5TSrjDwAX7sfAX0Nv1AL?=
 =?us-ascii?Q?FNf3JZIvY2pQmlidFX9p00HUsjPE50NIkDxsQDwjmTWEeF5Nz2n83jnUlyyB?=
 =?us-ascii?Q?Ht79mcFwKfmhLq3IQ0xQj/IvklXgTrzSV9KbquJcAwrFYk0LMX6DM6SiR50B?=
 =?us-ascii?Q?TNkDNrxrM05Kum12Y2HayBZsHeWdH7j1VBcTqrEFMBnebfqj5GnviP6JhuPz?=
 =?us-ascii?Q?Fds2ui2SCWs6EbtTn7Sn7esilCFI20C1asoxoFiufL7mIumRt9h0foPHlHtZ?=
 =?us-ascii?Q?dMMmGxtL72MTPIEfUx05OJ44scIIZK9D8bXe0dNr7lLRqB79FEdO+1+n4Med?=
 =?us-ascii?Q?t9AJfazrlYeMkKS0mGyTdQUYyUB0xPbONUAxgm15sV4EGqWH6QCsXY1PBQP7?=
 =?us-ascii?Q?l2OUSZ8XwbCl78022c3KSS+vrG87KjZCE6pquGP0amZjJXoxz531j6vWp1dj?=
 =?us-ascii?Q?Sry7BG6/0viLEqEvotb+w/eqEHqDoiiNnbwcrX082pKVD/gjhJoETVi9G2yq?=
 =?us-ascii?Q?nUF8jX+ylipVau21B5MpVwI99ifPTsB5YemKQPLw8VjerlCrxFsSD/N0WwHV?=
 =?us-ascii?Q?v38JptSuHErmpGjtC1t227Tdbw6vjSjnqFGFpZr38uGQvrB3NVADhV+MTD+8?=
 =?us-ascii?Q?R9W2+Ux8JfYXPv8bUS1lXewZhq4Il4tlWicLzBmIX/bAhwo6rO641uRAxBqF?=
 =?us-ascii?Q?QvWUXVS+kAh0pRkop/Dqriz9Wkp/5L+ejAa6R3W0P83A21DEwj8nXfkuUNjJ?=
 =?us-ascii?Q?4oUZlP6lNT8aQ9uCJ4WWLbqDfs8s8PSHeibw1Yx/bIHidlylMEHwZoZWRNB3?=
 =?us-ascii?Q?TxE8Y7LbpDHohBdI1B4a+nSJ8bM38ezHhgbHQpM3bq0kBn5j7mgLYKikPcMS?=
 =?us-ascii?Q?0Kd+JQQ+5cJCrDi709BN9Jkgb9R1vz7ntHS4ueD5dwi+dMct9PCESThAIOW3?=
 =?us-ascii?Q?uoFJu2kk8nbbGjSqe3AB1mLzkuEGf07oMLAH5q9WngGtqS3I8QhUWHgAryFo?=
 =?us-ascii?Q?UuNmQg8PW+0TwgfdvZUIAOLxt4epFmVPU6wMEeUWKut0eC2wtERFH/tMBUNE?=
 =?us-ascii?Q?sZbx0jZiEUWRi8PX1M7Z/2PXVVvGrzMZ0OOKWFYapNGHxyqQX0xR2QP6SUrl?=
 =?us-ascii?Q?PjFBuX8NHwN/r//+arkyna8x4UCDtLl3wlkJYhts07CdUX2sWBNeoge5bvqt?=
 =?us-ascii?Q?VF1LXFj822FHTH/yTuUZ7x2Ee+l2eH6poB5mp99tAXKwUfnc95oXQTdhiHYa?=
 =?us-ascii?Q?JDrWJhggHmm98iHC4t06Ioj1BHuwqI+tSQwDs0oibNyWmnSd62WJrPfA9aCm?=
 =?us-ascii?Q?xyBL6hiNX5UiZkQLusu/Kk5vmeLkBiOF5d8x1VmGCiCvTpsIVRupqyVy0ZgO?=
 =?us-ascii?Q?HR3Qbq9SoLOcm+gVcIhzAi34/coVkfumHW5XCytHWeTDZv0MPATvMsmpW0y0?=
 =?us-ascii?Q?EZhbALiZX7+JGKhxYR7O0qSiRUh2IbHjmJy9wZKyvhN8w8C26md0/0BKN6ez?=
 =?us-ascii?Q?yis8/QRKnlIGvGrlcQki/Zx2RdQWP+MI/OePJXXW8SGDDKUVVahhE/JXk/eO?=
 =?us-ascii?Q?wRsgeVFlikOWynA3+MnEpnJAhXBfR09ALL1dd80w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c802b221-65dc-4b5f-21de-08dc21040eb2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 19:54:09.1628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzAmIu5xNWHNp78ormglTp4+wcf+odu1fPNAHSS6ZxMzJK8e9BwzMAd82gwhV3aOkCP93Z7+2LV0WVREEk1E1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128

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


