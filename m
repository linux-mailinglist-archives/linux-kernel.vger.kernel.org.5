Return-Path: <linux-kernel+bounces-36176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD382839D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F130B1C235D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31BE5B5BD;
	Tue, 23 Jan 2024 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o6djDPLc"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194D65B5A4;
	Tue, 23 Jan 2024 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051492; cv=fail; b=fu59QGUjqFi1qlWvZE9GP3SSn5DRh1nisAjg7bi8ZdzsO2eg9xybLcpL5hmdty+VNpfhnvxv4RVuFkiOhmN3ci5L+UvsfeMVkzGzUBpdw8qeqAHgAPX2CMMghtb1191SGjcrRcsyhFRaZZElalqLPIILVWz66XTsaU84tjDk04E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051492; c=relaxed/simple;
	bh=qW3xZSPxV69HhCqaxH4lMTpKrUoMPbR7IONE/5QS6Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cM8KMycpCrflgQ6YJXH4Q9slPuhqHx1LUIMnaWiIfmrgeeslq0AAhR3Ij2eT1eISAySooMa2HKGR5CjInLwjND/0rys4mkK5AHfHTlgNDRW20jhgZQaGZaQ0OQ/1U5xC+IgQSnLOPD6pO/HLhtGXEANn45TTz5IxM9ThbSUlzxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o6djDPLc; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvCyuhp1M6Fpl6z3ERyyy+J2fuVttXt/I8f/dNJ9U9nx3Rsa1NJPetXpzU35NShltkgD0gHyxcoTcQFUvQmEqnUXduGBpuYM0/HkCZ9pbEjb2+CC6kNEcMOFXxtxKBNZBajewUIDoap8ChrUvsVpd8Ut9sInn2W5FvMxvlBOEIGdIcYxMQN3ZO28jwzc76ct8PG8qPcqFpNLHY4v4hc7cagAGjp2zK8+91//eka1Dxv9V6BFeanvpWhFEG6W5kHtZBFqfw9XTkRfhyMcU/TlMdI/LU5aN2GNeRPvN80rqzpQ7FDKy5X3wcMBV654WcNi4D6ysH6BfE328pm/zdIo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=gGplKMk66GaTweVFF4futDGQXoLj3fNk9Gx8JTRiLvAnjNq6AabCa5ae+3uPm7R+2+/2dB/f8AVluKNGT+vmtxA56d8EZED3xQUFN5BchDUHBBWkxdK3SbMzNSvX7Q/o/KMQivlHsKI5ys7AN9keGrMoujNKCMsS8jKqdxrAXUM00cp5CVToHyp8n7jDCh0CXd5K1gFOpiVdodwPlbmOqANhCLwGSdMPIb8J7BaKcr1bA0zIxqTxv3CLgqQGE70OvbeDBtlcjxX72BZMSv7PNDDUjw3hN6dwicAm890a6KjVh8PyltU9qkVg+ahtgBiSsDiu/QKue4JPiIEDaVn/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=o6djDPLcg3Iy+MZV6n+rXtSxmQcr5SKNpH4+AR1MOgqxfIZoDetIje3QswF7f57V40hKy6vFldcCKf93hcDuBvzA948oD2OUd3fszcpWzkr7tFVTDyg75hLqNKFUiGodevHYehnEo4JW0tAqa6qLAIGP9NChEpwLRAE2OAj+0xE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9475.eurprd04.prod.outlook.com (2603:10a6:10:367::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 23:11:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 23:11:27 +0000
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
Subject: [PATCH v4 7/8] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date: Tue, 23 Jan 2024 18:10:42 -0500
Message-Id: <20240123231043.3891847-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123231043.3891847-1-Frank.Li@nxp.com>
References: <20240123231043.3891847-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 16094cb2-92e2-44e8-f7fe-08dc1c68a0ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Htne0ajP4IMNXAZ6lfasz3D+XF/CZN5yFMSI9tlNxqSR9DrWZWMQtlko0OY3XuJiqXV1v28LYlkHH2u/odw5hevBU8S2p/RNF4+iWaoTz/QsyDGmZkcjIg5lkOksSPApq7u5WQOymPKsOfmDHyDaE51+UgdIZf/BNMBPNQL/f25Pjkh/dBSFDRquSEv9wAgrmUmmUWID3CjEgLCMqu9d4t3xU95945ob6b7eGKArmkugqEns3J0RKQoqmBEz/b71KGXOJyd1BRiJImm6z2Q0ugmNTVnC0oJjOLQlDVHv9HDU5V4uxyGgqv3mrY8B6B6NPjdDgnYSHjjuDqR591UHjL/bB64o0AQTHwkll64Y9r25PuufCcowGhBeymWOuXVegLSlUTC4V5FWT8VwTejmDZ0fKd7YvTIjkMkm0+SIMsTn2hnGiGf+VsRNLEFVtzf4NRCc9jJ1KFaD8+DpcGjPw06R88PbPBq+cjGi2TKlvQPzJyP7Q1oeFQB8Ck9IebIb8sOLzzPal6lrvTPXMHK1yiqORdQLFBjd3GH9J180Lcb6Qb0l4NT7aMTVCh+S1fZgs3N4gx8gR3evBqF9yZ0dQLngAvPTiIebSv7n4pekkf0fotuLc3hdhO7k2hAISefP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(1076003)(83380400001)(66946007)(2616005)(26005)(6506007)(6512007)(38100700002)(478600001)(2906002)(8676002)(34206002)(8936002)(4326008)(7416002)(37006003)(52116002)(5660300002)(66476007)(6486002)(66556008)(316002)(6666004)(36756003)(38350700005)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JQ0Asx+ws/CFcKCI49iioicjK8+wCX+mNMUVNtHgo+B7LIMZmIW0lZCAe5hy?=
 =?us-ascii?Q?Ai4v0idJxQ8pBlHiXS74ZXD9LXCzj+z+koGm1YyBwEPQqmuAKdqmHYB8fSPg?=
 =?us-ascii?Q?BKJ7U2IaSo7r68XuOARZglcpXPpefuwRIOtjvts0lYWxWMnMwMyiGa/7DWcB?=
 =?us-ascii?Q?X4iIaAXuEcIiUkVDSkvkitq0zp1znqwOc0EjJsqCUCU0RaESLfFEQdjEYopv?=
 =?us-ascii?Q?t0JJ5TYd7F+/n00C8bE05XWLljjnumx9I0kUxx3XUkgDc6Uw1sRXd7nJDZaK?=
 =?us-ascii?Q?0el1vrbL2M4Ud0j3LSXt0jzsch0Tda+vNpsfNrGH0yd/8mYOnBG8WdyvxNgL?=
 =?us-ascii?Q?ZI2yB+9hF011AkyuB8QkI2DJuheyYEmhtHjWEa701CdaGpEYygCkTwjltmmy?=
 =?us-ascii?Q?9qtA8LpYfeWp22SQMmvhlBXwHUHNaC0jzTrU+OODiUXNFDCfh/Z/eP8A0UZo?=
 =?us-ascii?Q?s3RFmTuX46M1iV4VxNIJZPTOJvq5PNT+nmI6SmgKX18ouYzZ+yd3Ks8cVP9Y?=
 =?us-ascii?Q?eVFSsShOXPUWYvTB/2BMCfZldtU6rLCsgL6lCIS69G5xpbSSXZFkunMObFPN?=
 =?us-ascii?Q?zkY1VWe8Gc+JvYhdZI4hDdAlwAXsju3FZo/EcxpHWmH6cbWnlL8dUhDEcUKA?=
 =?us-ascii?Q?0ftEp+q6X86p9gssj/gcxbhQGnNCc61+tXzfkMv3H2ERCQuiHXtVyN5S6s9E?=
 =?us-ascii?Q?JyYJSQmO0HLnCMq7/mwu4MANkz0Zj3clMPVVYIh6Uj8xLoKZaPmoUdq+91FV?=
 =?us-ascii?Q?qtOOkdGF/lQ2dWN7niYT968ZZE3I45+NgZ9qxYXoDjUUpGKx2X7FskNzGeIK?=
 =?us-ascii?Q?GDpknzGyG1zhjEInEbaKogQGx+hX8NWE1HxV1QyqjK4bQFtJlaHSlj9aCL3t?=
 =?us-ascii?Q?vQ9jBrpRI9JJ50zNFGqTHhersL7fnRdxcOFJiVxCPA9whghx4058BSx3Nw4O?=
 =?us-ascii?Q?K8jWZu5wRbqPdRHr15c/xt3eNqg4vS5hLadrN4xxkBCoyQ6NtHhCu+VxFAVr?=
 =?us-ascii?Q?U4OpNAeF6j0NLIXHLnQnVhSioOJNRri60TszGWJShDT0NYIlN8bycexTBBIs?=
 =?us-ascii?Q?2f7SqHpxFwGLqEiKpYpcSM2lCYzHsCNdGJOyLDJHO3TkWujJ7eSyaqud+b54?=
 =?us-ascii?Q?yF0TXKcdoBMFkzjL5JlLPLrMOnYn7XTn+WfeZlTzYR+0PJG4fxgNxXVp+r10?=
 =?us-ascii?Q?2018lxPhBGxzqE4dhwhtL5Ydc17vyr1UNhRFe6dK9VsAn7Zt53WkoPRdmJIv?=
 =?us-ascii?Q?uEcXAid+CdaaMFq+8gTz1I9Kv/9BLAJOfMkccAbqpC+xeI2pOrEBT9ZkyG/X?=
 =?us-ascii?Q?tvJ1iPSfCI0UNUVPXCWhkJDN40HNOurwrY/k7Yj8Z1SLubtLy/WEyZaSuvEn?=
 =?us-ascii?Q?NBxn7qvUUFX287RF3DZpJGL4Zjce24I1wbXio13+MIYyw90Gh0NgeqJiccHp?=
 =?us-ascii?Q?IIWat3uGdz5jP1uRzX6o/QwiPbnj//LCu56ymkwBlxlyvgKu1FlkQeV6QnNK?=
 =?us-ascii?Q?r8Ha251uRpJ0EpA/h0yta4c/7xht8mVAkm6gNWbC1DaJXpu2dGzs2i1elP11?=
 =?us-ascii?Q?FOwsB7KFtVEIR+nSn01iZaN2tO0x+1+s3wiKBOGj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16094cb2-92e2-44e8-f7fe-08dc1c68a0ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 23:11:27.8777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bISyMDA6DxCy9H3LddpE7lLHA+ARrDlZA6RLJdXlw+9EQyxy8mlyFTz4JKcddR40B0ORwnpLyRalwALvOKQm3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9475

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


