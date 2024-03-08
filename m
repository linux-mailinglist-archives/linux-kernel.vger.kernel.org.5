Return-Path: <linux-kernel+bounces-97299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDD387686F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A71B1F22144
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5585D8E8;
	Fri,  8 Mar 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pt33OXLp"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3C56478;
	Fri,  8 Mar 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915193; cv=fail; b=utuEkmfrU/3h2/RGf26UHoYZZg9rYw/M+tY5X3nu2TknDu2FiHMwDsj3UcinV7upCA5td0Bd7olDeoYaxetrLk4kR06MqLYcit6sS+hoj4j49D15eKUCiFYG72mJQ1XLvY/ytMI9JAispkCmXmNEeKKH70fHkSCcUn3gI+b45cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915193; c=relaxed/simple;
	bh=qW3xZSPxV69HhCqaxH4lMTpKrUoMPbR7IONE/5QS6Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sqwfttUJtBX4iMVx4kZlXWerLrXEcMyoPJS23pWSK5Ff58MHhEt+IrnE/hheWq2GqXbHsfuJEc1xjO9dE9pBVnutgW4zFAgr3l5a5nWrMuHrOw7WUwMKRTHGhMy57VSCToSRabywSx5mq0f0XxN95niUqxn4ajglD1TE97w0ULY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pt33OXLp; arc=fail smtp.client-ip=40.107.8.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6refx98ULpLKSENe7K3w5V9KqhSyGQOLqDVTVqhXWlFmLMdBtG6EWmdKw4rjVRy4fMJn54KFrfcM1hfyEzN1SCTuTQs7lq0tBsZBPVTNtkmDlRHWi2Qm81A7nwWHG+c/XmdyyLgDtRNLjYGtf1IEMUMw1PpGvutO6f2yFNmjMW5i6oztq0CCbCEWkKRJZ3HxPKi8omM4Gs5QFx2roAxcVXNaYEGUD+aTmFn9+smVxxHOckIU8AP7ejeeM/Q1P9k5TIQStRFlK2VtvuaG9Bpon/Z8sXhqjQbv2y4Luw8YqEX+mcJy/hMZFE0qmRiMYB5XFOwozYs4ob2uVGnNzU8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=ZQsS+edj743bhozBXozfWNp9Q0DVTgEOxS7wIdnGQUfl7+kgrzp72mAAAT20p5DrOxVqqLwKZPA7iFGNvXdg4mLyhPrqkCTpChWjdAHTzUwpA62cCYMR86VlREzCv2Es0Uq3PcLGtpdzrkoTQL+sN+56R/QR/4BL0AD6f96yqVKWkQHCqjRKiQGL7QM3jcCB1dCZCfcCPBcBdnw9cPRqbl136IwTKQdBpzOloy49cYBypuCI97qy1Oljs+FxyvHL4P+61C3zr1SXGSXAgZEha5DZtlOebkg/RREJ20v6zFxkuNMqvnS3dtWK/Wp5w886fuiEVOWXBadMFxsf3tNjuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6ARtUV31Aw0WkrJm4RAXeC+QYXs6+F2YjWwVs9OYOM=;
 b=Pt33OXLp3Mz3/8ah66pPJ3gIkjHevRPMmpg9+edG3zg0WxEn3M6quHlPrVMefD6TsHQv1zK1e7i/+LMT8gb8ZCJvqVQOXmUpOyddpWCVxPgso4+Igy8++d1ZEpJWWwfErgMstLGKAqhogsnyBnwJ/+MYuP5l24h8TeTmOTH1i5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9864.eurprd04.prod.outlook.com (2603:10a6:102:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 16:26:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 16:26:28 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	alexandre.belloni@bootlin.com
Cc: conor.culhane@silvaco.com,
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
Subject: [PATCH v9 7/8] i3c: add API i3c_dev_gettstatus_format1() to get target device status
Date: Fri,  8 Mar 2024 11:25:17 -0500
Message-Id: <20240308162518.1615468-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308162518.1615468-1-Frank.Li@nxp.com>
References: <20240308162518.1615468-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 636bfc23-f5ce-438b-b7ce-08dc3f8c81b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vy4ESECLqL2+dM+73PBXpKR0MDMYG7M2nCDKZ8TthRNqSK+hZ4jdWCOK6yMB+ax85xN4SOW3pvUaeO1q9b5PguJpoUK6oREvhlUmSZfioge27f4Isas+SSQ9Pa072t0foElaDwEtIRqtujSAttt/OM7v+A5bNrkt/pfQYt0dB107OdBZo3YZb1zofnmVAZuPtPue58N5A0WN2S2InCHouQEOuslNKUtxrDYaOZKEQJWLbfHvsPRdSZRE5iQU0TSU8FBE5TazoxuV9N9LvRFTBL6vi2T3Ik2pzm75n36AQoSyKX8sOLhbSCsEuf0gsM8r7YS9WgqEPfe4A81wme47hP+HEWm3IKLXVapuQERhhbu4aoTOaQk3kc5XQDa1F3xerzY4GmasrE6gUYDLoplcLQDClhVls4nt5+WDub7KPQgb2vH/ceI/2UydyFurLgg/38MXAUMeEZe6l3cNgzVFPDISK7k15jXBeritCNxBEp+143Sb7wQdcn1a9/ZvatGdQHtpBIMFsTghxSp8tAi+iKX1byCYFmx+VRlBi4vdxI6zkR8sRaUqUxv5kCcbOoyZ8DkIvR5Q/tXWuohSdgvAyQZbF5mrPTFAJJaMcCyNbDR0FI0l0FF00l4D+CYJTtDI32QbkRrJJqanlTG3CQJzXXb91F3N62p+l1EL+pJpW6dZATYi9C8Pdp8JPMaTAvtD2FgCCimJLZJuZD4egxiDe1f7HoWEbkljgA392wpfK4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jn+vRoSDruetO9Ssm3oYyjw8w7/xERYQ026u6bICfIylPDPBACr/hDEBHaS8?=
 =?us-ascii?Q?ia35OGlFVJZ1W6znQ2qQbCpLviRa4i6hNnuPN9DMwOLwvBxUOHHJcue2bEDk?=
 =?us-ascii?Q?b32xhljC1T1ftvb2ivIOYcszNU2r9F7kgMlKYjfbhBGzzWHz1hEPwPlSW48R?=
 =?us-ascii?Q?H/deDl8GgvuCxISbCHG187xtBzo8B0Z+AEaWDeJo+5XfCqie+dzcUGAXV/OK?=
 =?us-ascii?Q?hwANVkDy+AzlRSY/lQoyl4EPj1NIP99KtWJ381cCVlJq6ALQnbKZC5FJxj58?=
 =?us-ascii?Q?GmmqDCWiz8ZolerUi1MT2s3pJVKOuZLBgVPJPdPq2KxkT8/m4Fd48JZmHDBE?=
 =?us-ascii?Q?HopvffdVHU83v3HmmOrOzGvaFGVDOQaSH5RZHu0H8y4Rc2bUTM/dh2uASRxJ?=
 =?us-ascii?Q?O/5NcB8FOIoQXw/IlG8sisnimWhv3YAt4+Ny/9WfOZAs/1K4cCkTrl/Ssrq0?=
 =?us-ascii?Q?I5pyuBujuwjWR1QnLjBmYzK81saRCcbXKpDNuM5ly9UmcBIbsn5JBAC6eSgQ?=
 =?us-ascii?Q?PVQo6J4P89RxVsAedc4SJy6VUdBiPkib+SvSiSO8FWzNQYQOp/1q7nl0T+tD?=
 =?us-ascii?Q?ZcP76CM0xtRHg/0hF8EkS5ovsiPn+4U5styIdPWWoHQlsb2G1fOcPi9Nvc9B?=
 =?us-ascii?Q?NYQBstBoVuDBnOAguQNUFIxZshAizb5eqPy3tV6wB523KLib9mixEcqHmiZF?=
 =?us-ascii?Q?TmnYlfx2b2NN9ehyVmUuqhpZfV2QtpiDJ+kyaHvEzMRxmXC610qlX9sfci96?=
 =?us-ascii?Q?dXIALfQ4ReTfuFK7zBaHwIfTgCxqt15yulvcefIZG6SMomnDF4epAvhzmtpx?=
 =?us-ascii?Q?HZYqX4bb00ZuY+tlm4kF2GZ8EZn90wPs3xvbzKbqnBNLXU/Gm1L/sX/W975+?=
 =?us-ascii?Q?TK1x44yIqbanl2dH2LPKiynfMF+Z+jLOpE/pIDeLVtJhMMm/009YC9sJlWKZ?=
 =?us-ascii?Q?5/5LTVwFJuR6KLkYAXgTtPwhdOOBHvPULeSem+uL0ht3qPARJY4Hm0apCRPY?=
 =?us-ascii?Q?xjbrymK+S5uKpIlnuXP7nLiAzI4pdt0Hqa/HRIl9kGkrg/7JW3V4DtGWGnYx?=
 =?us-ascii?Q?MtJUk0dyt71463WRUrhvJf08H0lLdrCyROjLja+xrPchCDRCwv6bCDm7wntk?=
 =?us-ascii?Q?qNODqWz7R7OAI6TQmGrV8siaJaaAunHv0x5QE0wtix4o2LDZ4oHj2q+BfTvJ?=
 =?us-ascii?Q?X0qtAB/+MmVTAwsvrYrFl9YTjYC9DPksRpYyAqNbDWJSzMEQ7FGBB0rSyM+j?=
 =?us-ascii?Q?uj0+ja0M15j7w6K3eJlOorRCWH0eBRqTqRpYsCnuaEQy/YPzuo1nvuAqZWnx?=
 =?us-ascii?Q?PZ0DU5THJhxAxOtKtcgLTa0VpY137Oj7JznqUgFQRHNXYmp66PWAmSmc12BI?=
 =?us-ascii?Q?i5cc88z8LoPRvmyX3KfrfKAshwP2dioV7IG9WcNdj1Fsff5oG7WcBU6nsY8v?=
 =?us-ascii?Q?peAtwKoO/5O9n3MHf1VAh7T8aJCRXJ+C7zzWvn2CYTx7YDE+iIDvcVPO4AxG?=
 =?us-ascii?Q?Edb7jIKT3p08Wa+/sEaePchauCEJnqc6H4tIIQqql2Be2aXJjXlsPU3VG4XW?=
 =?us-ascii?Q?iN2PYRconr5+1cRAHMJjF1qsV78MWziWBv4GTc7n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636bfc23-f5ce-438b-b7ce-08dc3f8c81b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:26:28.5846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiTBssdwM0rQdYIUeTB7qMT86WaYZoqOlQX2pIyVuBP19mcsGgKMK2plcCNm27MJhEAyYYSV+u4R/p0lX44p1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9864

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


