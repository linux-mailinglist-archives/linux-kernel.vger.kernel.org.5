Return-Path: <linux-kernel+bounces-45683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A813184340D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2C91C22988
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8CDDB8;
	Wed, 31 Jan 2024 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WOySVxoM"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7735DF63;
	Wed, 31 Jan 2024 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668801; cv=fail; b=b1WtiFfv3wU9yDMPQQm5rku3JnSsTDF4keoiBCuv85PjyPGaHvx49cXfB7VkH8eOqr23BY6hkabYyv/A/d4x1F58xsJdEPKxNQs+DoXI/Dwy/v2b27JyTZljC36hjt+yhq6EhmHHfGqYeSavw5bwJ06POqE9cYRh4Hj57CONjLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668801; c=relaxed/simple;
	bh=G5ElJpWhT3pGReeJcp0jbPVl6KbZZVlPy1UNIYo6Pek=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Npjmoo355Vf6HYaCuRl7GRjv0orFCnMAiWhMxyGVbqwMO/onVYbcv4SvjNAGsejeHI2LUT2ieSVOFPUSw190SN76xAshuNpqleSFdI+dwAMzmZKcE78dmMOuT9/cLWSnVqA0gV8LHWdmXcFZiBjTcopbPPW75dTcu3UhLLijDHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WOySVxoM; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7ecObvEH3GHApKPh25F8Iqf/qAOqPGL4Y6IRKU1a+l7NmHDij7kUmt+3IQ85ROS149BxDr2cl6rtBYCpD7Jk2OPtbkxzT/OwxDvgeB9qmE7ICzJyVGMR3qD2EEbr8XYiQUkQy65n2BSVCrDwHmUZXOsxdGB9v3D9KVvAjpcEBOYz/II60N43GZ0ajMtKalpb6UmzwdpzwQxnXbnn2dsKW4ymuGlO7upyOt5erNT/2otTyTYCbT1nnO+hUl4p8S7IBom7iowGPL6wuhZa85P4OwFEdpEla4MApoewAgX2Djo9mKnQg0T+GdJm5/AslnPXC17bIxCxyY/YVWMhhF6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUnnXqxbCRxxx8DRUxCr8ZqF09IqFIpC2RZMYl+rsiA=;
 b=c8hoijOI/N+S+NWylaLsMx18JTONsyO2OWzi0EIRB7NJOVw5eEFKoZxMVfBkteIPu1+ixcI61SBfwWqs2s/qzsTTeosh0B9mQLLTDoMU/pesLAgnXil93XZdHH0Ara3q6/9nUYkQe4/2uSDL13FqMkaAL2evq7f22PRRRkkSByG+pQ7FgqHUOzQjINQ0z7hFAHJFS6l0p7JViU1oTRgmobKq7LoCums3JOdJuOnWujwlirtU9atOMIMZSiIBskEmJoTbCuOtClSRBnaxiMuYsLvgPgpcTJmItXd+lEqg56S7DPnSsGNs5iCciUffK9MeVCZpjXsMipEbCEdxu4c/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUnnXqxbCRxxx8DRUxCr8ZqF09IqFIpC2RZMYl+rsiA=;
 b=WOySVxoMmESw4+18AKGDT1+UmWZ+p7MWVuGgisp/QtvFfFmdJzEFll1Rc6GoTKRPnNDK5Z7oc+/RJ2w+K81VhvOuLzKDiW/n/1CxtmNiuO80qPZRoQ7oCreGK4uQN8SOkSdKx6t0fqBJxAMTqq4p+0wDLhnU2iim2UAGER/B2nQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PAXPR04MB8527.eurprd04.prod.outlook.com (2603:10a6:102:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 02:39:57 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f702:c85a:d3f2:ffa1]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::f702:c85a:d3f2:ffa1%4]) with mapi id 15.20.7202.035; Wed, 31 Jan 2024
 02:39:57 +0000
From: carlos.song@nxp.com
To: broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	linux-imx@nxp.com,
	benjamin@bigler.one,
	stefanmoring@gmail.com
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: fix the burst length at DMA mode and CPU mode
Date: Wed, 31 Jan 2024 10:46:23 +0800
Message-Id: <20240131024623.329240-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|PAXPR04MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: b695d28a-0f24-4811-b527-08dc2205e990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X6U+q3g6q3XfcWP/FuDIRJerJ0xw0mRY1sDAfghtfEY01Q+Gq+jgDnB205T9Z+OrlNecfVJ7C8tRLsT+9zwwu/CQg9mzmSSv3GCyn9x6yYEo+RZq2cyXbLik6WSd4j6BrH8oOw07mckJ68RG7Id1PoZf/cKfcgV7WDg8fK9U1lHEQVT/yS38HDsskD3gtDFkhILtYAHKdWSCxhZhQAiCB9LkD6Ue/7E9BnqANIxe1Qhk08w1CEEZOiTPMaSG7+aLam5koxr8SHfv5w5URrqPgaZaXhYFQiK8JCGvJ9lPDnfO97gw99Ni0K6QEzpVBipnco2sJy60VnGzILtRPTPyKxpnmfDCe8DMRohjH/BC9BJbgL3BDp7vJku7AYnAFiJRMKtKp/TzVvBWIc50+wWzJLlBiqWmz9GS9ns6wNQnxjchN69VrHWkNdN8YFDQMy14tmPEnAiKo9f3ETKv7QcL0u/vbedKvQPEJxm6bbIQIkC9xZ+8hcDDjw3Y4cqnh/0d2cWhENzyR5abndnH2InykbyoOEjsBooZ/nKc1Y3AaV8jgjp6rZCwB3YMxdytc708ZB9ULHhNL9jFKN/tcBAwPtY8m/Rev8BaeGfJyo5FLpSLzQRzr3g8mpMGN/+hzmEK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8936002)(6486002)(4326008)(5660300002)(316002)(86362001)(8676002)(2906002)(66476007)(66946007)(66556008)(38350700005)(478600001)(36756003)(52116002)(38100700002)(6666004)(6512007)(6506007)(9686003)(41300700001)(83380400001)(26005)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zai85eAztl8/OMN9Rpi/SdudsHK4eIgmILxKJM6RisQhQfyUCtRe5/VYhrAZ?=
 =?us-ascii?Q?dj/PVvNHkTkeKOaLeLqRAiP2gQCzOPUS3RFhe5d+KXfGiJ+s8FC6iWJf61TQ?=
 =?us-ascii?Q?cDbVFTSXjXNVvfTDaEsnBn7dWrDwcQcPu4teAdSygnm4vWYYmDtHjfa3CgKn?=
 =?us-ascii?Q?piZyGcA/H07mTESSObUSPIcS+zYF6Bx6pfr5XvcaRbboNJtOLGmQEloq2h0d?=
 =?us-ascii?Q?iIpPr8GLSAkeBiRuKfj9NbNG1yw6aqh0/sy/ydFGMZuwHVLGwzhDod8U0H9z?=
 =?us-ascii?Q?9O9Ig6KBvCnVr7LYkehfBGaDvt96GEGS8vJ+qDk4hPdCV683lv7N+Odl3630?=
 =?us-ascii?Q?v0VYaSZCq01fUwraEplUuH1J6sUeLmTBPpdB8FNy6EJN6VFmaU/2sjJdarCO?=
 =?us-ascii?Q?UL0S//YIphtXnJD3TzQmxaF4y8VGtSwxRcsCmlR6ZrZE+FaSERY6gtSIgiUk?=
 =?us-ascii?Q?r6sBitiKbZknWxwQqDnar8VfQ5e4T7Fkyu1vbr0lh9s9cgLKZbhHWaMV0Nsw?=
 =?us-ascii?Q?A/d0e4M+q4L9r7Ub4v5sDn5mBfgI+7CSFd0oc9kw30X/8k0Vo64lV6p6YkBD?=
 =?us-ascii?Q?TUuwfWiqpBAoCMNfr0DWSuzW1LTy+1Tg5uEPcO2hHc+KLm+gP6xcFGPsWlb3?=
 =?us-ascii?Q?fssASO8j9SISZ22Jl+pLHFL8g7RGrKJkZnYuWngFfNa2FK7sUGBcljfdFuDF?=
 =?us-ascii?Q?+VpDxhumcvQX3Wc9Cv0K1GKTiQ8+3OI0BBnOupO9ULcm5uITI4VNQpPkxXIF?=
 =?us-ascii?Q?/mwPdy/yQEnTmeA7gAqvcs2t3/Xj+wGEqQbuW0iFV6LmaXbIC1xz0lWjlA2j?=
 =?us-ascii?Q?PJlcET5Xzg2laJME2fSdRu/X9IVK2YGuyl2/nNmRogdrQJNh2pJWFH14EmnA?=
 =?us-ascii?Q?HRrLMLz3BJlQlWp3flZ7kwiiQ7nBCWu5NHkItczVYpbo/K4Tt3FwGVWY1wXa?=
 =?us-ascii?Q?LerJ12TIfCUjdkOBGDQYYvlRaESMekCUDYlumSS4HS5UlgEjxUFXJhGaYreo?=
 =?us-ascii?Q?UtDcHPILOJSYNK34NpZMv9kTFTKMeqY7gBfFwg8TQAg5N/MwTzrl6oEog7YO?=
 =?us-ascii?Q?b5wfBkl51C4anrZ6ObFxL1AP8G7coW1lB0NGWwCsINDlbX8hWV42bga38GAk?=
 =?us-ascii?Q?jqiqlQ9DxUdhpd0qy9AvpYkan4ZY8d0XDed8BLcFrAkZzRwnYHQ6gYuSR8Xy?=
 =?us-ascii?Q?LlDlx5nxciGw2ctxxZS5/vF8H2YkPMp8GyFew7yN+QrAjUipEqLhSDx0qJEl?=
 =?us-ascii?Q?xBIedn9p1i9uLLJ0YxQijLcokgkMXcpgu8J5f/XMG+bB8b50Fncq/3lTWJZs?=
 =?us-ascii?Q?XhAvFFabod7M+dwfZ+kamEi3YVB94g3DBqrCTr81leOv3eKt+Jvb5/DPczLY?=
 =?us-ascii?Q?yXrib8WOBJCeT2mwAeH0QQXJKwedmfKPcU5jz5Q4KaV1aAZMx1KjBpittSvH?=
 =?us-ascii?Q?PSOwztqppbTMNGAdOd2iRpy2Eimz1CyL7nvlMI/ZzRQc7zUobZ0zu993gb1o?=
 =?us-ascii?Q?7RWyY1DpBD89mYpxm/3GMede11wCqhowewH0Xcrw+UJvJKnDBOo1RQGQ/mk3?=
 =?us-ascii?Q?tWQAjApd51Q1f9OUHNZkHkfdX+GCCQ2NP3DOSU0x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b695d28a-0f24-4811-b527-08dc2205e990
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 02:39:57.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrcCP34wVwrtNK+7m83VNxTZgcSVL3sUADGnEbUPZ5+qclf+rHLh31CHutF9U+Pca6Oa8JFUHLA/Xv5M5CP6rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8527

From: Carlos Song <carlos.song@nxp.com>

For DMA mode, the bus width of the DMA is equal to the size of data
word, so burst length should be configured as bits per word.

For CPU mode, because of the spi transfer len is in byte, so burst
length should be configured as bits per byte * spi_imx->count.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when using dma")
Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of assuming 8-bits")
---
 drivers/spi/spi-imx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 546cdce525fc..b4ade2d53fef 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -54,7 +54,7 @@ MODULE_PARM_DESC(polling_limit_us,
 #define MX51_ECSPI_CTRL_MAX_BURST	512
 /* The maximum bytes that IMX53_ECSPI can transfer in target mode.*/
 #define MX53_MAX_TRANSFER_BYTES		512
-
+#define BITS_PER_BYTE	8
 enum spi_imx_devtype {
 	IMX1_CSPI,
 	IMX21_CSPI,
@@ -660,15 +660,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 			<< MX51_ECSPI_CTRL_BL_OFFSET;
 	else {
 		if (spi_imx->usedma) {
-			ctrl |= (spi_imx->bits_per_word *
-				spi_imx_bytes_per_word(spi_imx->bits_per_word) - 1)
+			ctrl |= (spi_imx->bits_per_word - 1)
 				<< MX51_ECSPI_CTRL_BL_OFFSET;
 		} else {
 			if (spi_imx->count >= MX51_ECSPI_CTRL_MAX_BURST)
-				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST - 1)
+				ctrl |= (MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1)
 						<< MX51_ECSPI_CTRL_BL_OFFSET;
 			else
-				ctrl |= (spi_imx->count * spi_imx->bits_per_word - 1)
+				ctrl |= (spi_imx->count * BITS_PER_BYTE - 1)
 						<< MX51_ECSPI_CTRL_BL_OFFSET;
 		}
 	}
-- 
2.34.1


