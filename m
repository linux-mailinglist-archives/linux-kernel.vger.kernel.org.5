Return-Path: <linux-kernel+bounces-76559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386EF85F926
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3F71C20AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F48512F5B5;
	Thu, 22 Feb 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dROAf6cl"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4845789F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607235; cv=fail; b=pc487NGgjA58n7v1jY4lHtciJ9Lf1757dkqbAkI59TJrIUACDK5ZrzGlLeu8UKTU7seopk3Gm5I1AWDFBhcTAweL+lWgcpSFFHxmqurwlBwSC7W7vcenR9jp2OIQxHGciiI3mKa2EAwbbeJ2WYsapDLpIlRc9P48DlBusFR+7BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607235; c=relaxed/simple;
	bh=26cM9jz/UZ2mVgCXrjudAkAtbd8jj5BJSgVnPJRRhlU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VO1ZMkj3iAJDsZYWCT0zHsIsekl+65yaOUv9DJz2VSkWpcBbtmOmShR2f0EvJEnUXQ1f2okeUXMgihxGW+4Zd7KHOhYnyaLjMNwpJsn+lG3UBA7xdZBNnCmhoLOppUQqBTTPnCcSbqMRlEzMMre88ZjjrrQ6LBINqX/z25Dsv2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dROAf6cl; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JB/2KFlpnRMY5WUUjlD9u037VN8/xtAMk0YSOqZa6c2O18uTaptbfAtkQLrpSOLka0wEjoxO6ugw1oWvVWQVYf786OogDZ/02wE/iQHJHOeXxjMjOakf8pLPTy2X71WEbnSOl+xtvEavcoIndBvzu4G2MjQnFsPDfzsNlUBJEeXWh3gi6IBc5tAIjoYzFGLbcHie6HvBSlcA9GLHNS2T0n6NM40dCNhA5O9AbBNys2j2GPqv4gPrn3WC4Xkaaw/tdD0HVRGl+ThE5xpqXsEQm2G/Aw9H02tAOIb8wYkUcEKAg1sHcCOYYBgJ7aGLG0eTyh9w3is1Mh2MGNnotw2nNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMTNQ/XpYPC9U+OTC9AG+TzLXxVm2k0hjZRR9g+OusQ=;
 b=b8vT30OOf6revrwhOxh/cko3NPp4tgTDdZmZN5v6OpQKGhHvMX0u6PnkR9Tws6Di374+BGjbfLVLyQXR0x5b3d6+tUbgSlJsHSOkmdHX/5iLsX9k5z8FosB76ddvt0H70wP59Zoc0qXR9ELrZ1prsN48IW7y7YE1b0RY76XIoeuU/oMieoLlWZKQj/XLikD0oG1vtTw/S4gPEKCwlmL1R2fmNXpU+TVKgNVDsCUZNRg8wOwgr3Yb9u8+wfzGQaAqgpiv5HYxGo5FrwPynMgVUztopp4vo3ovNvCDbc8JyP1fCjQIzQuL0r4L001zwl07fL24Moj7d5bBTPKVZSl29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMTNQ/XpYPC9U+OTC9AG+TzLXxVm2k0hjZRR9g+OusQ=;
 b=dROAf6cl8wX+JgWgb2eFYny2zuH6I6Mp0C7whX1wzHTLQP88kC89h2eiDFOc2ENZTwC+OYB7JH0i2mIkTh/v6itvEsr5IuoLymnbFDYUOtr3wv2FbGuQhNw8g7vaGhFMlcTmXu0U+JHxCMfidY71lJMCoXdmGkTYkvB1uT4JVOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by PAXPR04MB9471.eurprd04.prod.outlook.com (2603:10a6:102:2b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43; Thu, 22 Feb
 2024 13:07:06 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::1a09:3c2:866a:8b2b]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::1a09:3c2:866a:8b2b%5]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 13:07:06 +0000
From: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
To: shawnguo@kernel.org
Cc: kernel@pengutronix.de,
	f.fainelli@gmail.com,
	kuba@kernel.org,
	abel.vesa@linaro.org,
	haibo.chen@nxp.com,
	peng.fan@nxp.com,
	shengjiu.wang@nxp.com,
	frank.li@nxp.com,
	laurentiu.palcu@nxp.com,
	mirela.rabulea@nxp.com,
	linux-kernel@vger.kernel.org,
	daniel.baluta@nxp.com,
	aisheng.dong@nxp.com,
	linux-imx@nxp.com,
	a.fatoum@pengutronix.de
Subject: [PATCH v2] MAINTAINERS: Use a proper mailinglist for NXP i.MX development
Date: Thu, 22 Feb 2024 15:06:41 +0200
Message-Id: <20240222130641.1213359-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0014.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::24) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|PAXPR04MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ccf877-7bd8-41d3-c694-08dc33a72b5b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8LTbUvBDWynBZ9qHwyC0ou1zyXGgdHkXZ/AOzSo7fWIhEwanlfCeSyQEYAw9WJRxOkhDBLuUVwRVG1v5c65JZMd5gnzfZsYbNUno7aSCMPRG5fe6Mh/aJ2t6IbbK/U7rKiV4RqZHYiCjWnmIqPHZpviV7bE3UoK8DeN7DYCzWOEsox2/IiC2ckAk3TGQpQi32DFs8OHpWs40Ekbd0crqJA7IqqQBChXtyIyHnLPnN6Id3dsWRJP+6UKY9+AJFcAL46vdQFJTAsyfFm2cV5tYWymFPjZLAJBwj+ktH+U7Zi5EuLHkrMg8io73yVWLcxPSX/c5/LQq82fKfkKc8dHc2cWwbq4YxmbnlIoai/fxMcAH54wIp5YCHqisiJ5JmGfSmvytzn3JXySXyDCyjenfDhfhBUAki+nf3pgnlo6kpd5ADV9tBQo91aMNv846f0NqKa12a1MR9NdXiLrTw39ATeDk0LQJMu/4jlQSGG00Bb/tr7Be2sUhb8p6/NCajjP8eAlL0Bc4LdInusQQaM110oaEY3k7VmPCl6VrCAGSaLZ78vAs8A9FmVyEFqfdDyNWF15xuSiZSXAOCN1vQ0/QQSBk4eIfnVQO0kkN5R+awus=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UYu04v77Tyyzi0L9ErEE/VD/SEuuFlNjaqv7QDgUNGqEAX4lcADyzwdR0vaK?=
 =?us-ascii?Q?oX8ItJsPq0ANXg82DhsbesQWIPozQYqd5grvK4SOAbRUTjtpuL+Th/SRUDPX?=
 =?us-ascii?Q?tVTba7kNsqNae2mlFCXHM9pF+5ysFdoLg3xIMJ8/QSFg62AZs+xKRXqcyMN3?=
 =?us-ascii?Q?nZC2gXYtlc1MhqxIKDJknSz6j1ROtI0/w8u6wTlx2yZhWdB5XqU8A50Ol1gE?=
 =?us-ascii?Q?keZooumEYLlhDlFvB+BxkiP8E6OzW3iZorIxE4l93O+IHQ8mNMgF1ZxQu49w?=
 =?us-ascii?Q?fobVZ0D521olzBtIzDZ6ZHuO0pyfTAu28oiMsgg5yt3ImnBzEvQWAMKCVTji?=
 =?us-ascii?Q?lfu7VFT1WB50VPyvZh4SjXV+6FMZbavaTq3DkHJz5a6cLytFdS7AxqjT+BeE?=
 =?us-ascii?Q?gLjpCQKrA/GnMwkenQ5atYFJR/OhzimSz6+kdMabEbnhtvkifgUNQ8R08JXy?=
 =?us-ascii?Q?74dkNGn2TDms4sL9VEXnZNKNlekbKJuU1774dXQkAwAxD86h6VXFqNnirk56?=
 =?us-ascii?Q?/tj8SmpJgypySbXS+YgLIlMaE0aOmeC5fu0jp0NBveer8jpNNVFdbHswoqg9?=
 =?us-ascii?Q?nrUeUdjUqnVMWHSpYROk4Z5ltGbSvYeDZsfxj4zbXwRzIxOXSm7wka1NOS6w?=
 =?us-ascii?Q?O5M57WjXjZBb6DFaL/VJK7sFsrCFojpbmGbLSnbido1dHXsaxK3Teeg2jUWe?=
 =?us-ascii?Q?n2Ghh19J32bBYjFFVlgWu7yVAAD6L6ISvinbCugHEomL0NTtawYDf101SLGp?=
 =?us-ascii?Q?wYbfWkEB4sKBxOK5zzWnPFYF/ngNQ8fDnj+ctMchCmUNi3Xh82WUabl0WUab?=
 =?us-ascii?Q?Cbf5gRadWnMw+1YSRVplLDZ/JlmQ+qpBLlJm2dNAssPKXHPcQEtCfCIeizAK?=
 =?us-ascii?Q?Mz6BPFArgWRY+fmgTxniOwjO0THuq9vV8Wgq7e+EaoJIZU75lIAiGoRCD0xb?=
 =?us-ascii?Q?kKMFjjQlHnG51Zt98XVgWKBiuuYseGKTaVTZCJC2IkYP0kD3Q6TYwZppzFFb?=
 =?us-ascii?Q?0NMbzmpDGgwJ1KxGJL6mDtZHViRqoyxl1+gSmrrp+d6cQk9x+V1/ABGHUbwh?=
 =?us-ascii?Q?MIiGt6R+acsuqWe3WuMSPvxbeE/57D9q9UfEwUvN2qKcrZkZFQZ/b1EXdcnj?=
 =?us-ascii?Q?8NFKu8YTSNy87QaNL+rHTAAGbf58okWiONB410KP1OmdrEzLSz6GcR82bltU?=
 =?us-ascii?Q?dtk5s4WnBYptwNUNu4SIicxOZzNApyI1zLGkG6Vh9G+v9ZyU6kvMV0WDp74/?=
 =?us-ascii?Q?qcV1JFQXiRcdJKWwP44YkOSi3Ykw8MYv7A9p8r+2n1syU/4+HRH33/+ztK8L?=
 =?us-ascii?Q?fL+UP54PwqMgzW72YjkOutskbkrFp0JhqA8+v8+0NfOwVAGRzWv7aSseaGB4?=
 =?us-ascii?Q?2AOBdgTCGl8ShiwJBxoQnwEWNyaCF6IDon+vlUY+/RTm/lQh6TM3PZskU9aB?=
 =?us-ascii?Q?s3bXLn6w6aI6WzTV0jtZOtrGMY3NxlEa0JQYYD5Dr2h/DoHgxEiEyUjNR6/l?=
 =?us-ascii?Q?HW5l2RgneaGuJ7/ma2/H/qX91BToCmSalcUB/q/GLBtB+JBostcWG4HAJvAC?=
 =?us-ascii?Q?x1egqXmFGZSe9zS4/IbpEXdKSlN/DTqs7bf/VmIt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ccf877-7bd8-41d3-c694-08dc33a72b5b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 13:07:06.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUnVxaEeqU6pQeDjorjsrKA6D1SgJ1DCsxbKxit4WSjMQxeotf1eNg6lQTrksH0Hzp7D6hELXZLddncP8j/axA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9471

From: Daniel Baluta <daniel.baluta@nxp.com>

So far we used an internal linux-imx@nxp.com email address to
gather all patches related to NXP i.MX development.

Let's switch to an open mailing list that provides ability
for people from the community to subscribe and also have
a proper archive.

List interface at: https://lists.linux.dev.
Archive is at: https://lore.kernel.org/imx/

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
- changed from R to L as per Ahmad suggestion
- removed name 'NXP Linux Team' from list name as per Aisheng suggestion

 MAINTAINERS | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..2344eda616f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2156,7 +2156,7 @@ M:	Shawn Guo <shawnguo@kernel.org>
 M:	Sascha Hauer <s.hauer@pengutronix.de>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 R:	Fabio Estevam <festevam@gmail.com>
-R:	NXP Linux Team <linux-imx@nxp.com>
+L:	imx@lists.linux.dev
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
@@ -8489,7 +8489,7 @@ FREESCALE IMX / MXC FEC DRIVER
 M:	Wei Fang <wei.fang@nxp.com>
 R:	Shenwei Wang <shenwei.wang@nxp.com>
 R:	Clark Wang <xiaoning.wang@nxp.com>
-R:	NXP Linux Team <linux-imx@nxp.com>
+L:	imx@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -8524,7 +8524,7 @@ F:	drivers/i2c/busses/i2c-imx.c
 FREESCALE IMX LPI2C DRIVER
 M:	Dong Aisheng <aisheng.dong@nxp.com>
 L:	linux-i2c@vger.kernel.org
-L:	linux-imx@nxp.com
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
 F:	drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -15704,7 +15704,7 @@ F:	drivers/iio/gyro/fxas21002c_spi.c
 NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER
 M:	Haibo Chen <haibo.chen@nxp.com>
 L:	linux-iio@vger.kernel.org
-L:	linux-imx@nxp.com
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
 F:	Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
@@ -15741,7 +15741,7 @@ F:	drivers/gpu/drm/imx/dcss/
 NXP i.MX 8QXP ADC DRIVER
 M:	Cai Huoqing <cai.huoqing@linux.dev>
 M:	Haibo Chen <haibo.chen@nxp.com>
-L:	linux-imx@nxp.com
+L:	imx@lists.linux.dev
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
@@ -15749,7 +15749,7 @@ F:	drivers/iio/adc/imx8qxp-adc.c
 
 NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER
 M:	Mirela Rabulea <mirela.rabulea@nxp.com>
-R:	NXP Linux Team <linux-imx@nxp.com>
+L:	imx@lists.linux.dev
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
@@ -15759,7 +15759,7 @@ NXP i.MX CLOCK DRIVERS
 M:	Abel Vesa <abelvesa@kernel.org>
 R:	Peng Fan <peng.fan@nxp.com>
 L:	linux-clk@vger.kernel.org
-L:	linux-imx@nxp.com
+L:	imx@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
 F:	Documentation/devicetree/bindings/clock/imx*
@@ -19630,7 +19630,7 @@ F:	drivers/mmc/host/sdhci-of-at91.c
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) NXP i.MX DRIVER
 M:	Haibo Chen <haibo.chen@nxp.com>
-L:	linux-imx@nxp.com
+L:	imx@lists.linux.dev
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-imx.c
-- 
2.25.1


