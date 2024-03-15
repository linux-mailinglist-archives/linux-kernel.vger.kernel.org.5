Return-Path: <linux-kernel+bounces-104116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA4C87C924
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0FD282975
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F41B7EB;
	Fri, 15 Mar 2024 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jwGHxwNU"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1152E15E88;
	Fri, 15 Mar 2024 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487539; cv=fail; b=Fp2HR6g2Ch3pgkm7UBHHUpiHfpMglsY6xL4ZDasCt6UpHV0sjX3gouLbk6raGKd5ro4+gDfjekn+9aaoqic6StSm4guPOpmillatQ3olw1GxNpE8/KGAOVOp4MhdmlEWbk7fHb3WNb2vIRfRQi9UmGBDyNjLYt2RadvAEf+lNas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487539; c=relaxed/simple;
	bh=3dmZHo07xt0iEkaiDPG7rQaCjgZRFTrlsze+xltTjBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYfs2L9clnRLVksKKz8sfEOwwjThvLwpyk3Y+llkp44U8NkucBR6OC9jdVNeEdBqnSfWDCcigfXwILi2yg+idNksIsifFrpbYs5RSY9pOT+ZvTY7uDTLfh7B+RR/sNVbBbbYb8m5WOPsAjqzes2VSVy3C/SMoTYjfYSPk860nAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jwGHxwNU; arc=fail smtp.client-ip=40.107.14.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLWG4gpPLq5bRe4eM1g9koT3PZr0Wfbh0R5qxLgQrDf/Qe96gx2gQrDIalhdoocxKj2p0P38HFFmh1cHJkpPDUK500y3bkjqBJGGZBsYR0hQanL+k37CzBcEPBurRo/YJA6Nb8XQNIkgU99abOAOnQl3tWa+Sv0+Pypfqqy1okTpqtAstBNJhV3b9q7a5kulCOA1l6+UamSjRXBxn4WN2VQRAdgPv9+IfRHeoYfqhahAKg7C9c1vgleIjMb5yZrxAYIsPfQ8wocvhtpIVLFQnqUFYv8Z6qo6QVAo+RIaZgS82ORV8Ob5iGPu29i9xjUo/19oTB4suboeHS8rMKC4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2rCNipOyEvAT/IRvsmf1Mv73yjTb5Yo1brt8ffV3uE=;
 b=aiLLx6JF78G3hPa0WrwbNtvDC/FyIjE/H5ljBMOOeRf08uRmPOM39lsvaLMfqe+js6ZfC1T2MgjuB0ZTCg/7Lawu9FP3EBmOzcQzqgUnJeemJXFywMk5r4xZT1MCnbEjI9s/iMd1XVr+RyFlKafcOIAXSv8wip/pupC0cL/lI7S1U/MyQAiWcqczcwsyWTW+oTBkDUk8tUIp6MTXTulxzR851CCOavW5Qk8t9p/AdUuADzDeEibzd3HmLaz/4k0/6yplZ1DcmB3PVypujK51sOyV71tnV5IXBAtNs+45G/5bJZ17KDUBwLSqG76wee4V9Jehd/A/M1nGSmm8yFux9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2rCNipOyEvAT/IRvsmf1Mv73yjTb5Yo1brt8ffV3uE=;
 b=jwGHxwNURWaBTHc4/6Itslb7CYzoV+X6koCAQpFdt3GEeNBVDJVgEwRSzyO0+MOdR2TXJZ6aSFHWOgOGc1lLsdaPRo17Xg5WqCw1tX+RHRAc+O5bBFqf7i3Vwa762MHyff80PTwf4fZKRNQrlEZYHFCuJfkvtWSyBfzqct4uw+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 15 Mar
 2024 07:25:33 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 07:25:33 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/11] usb: chipidea: ci_hdrc_imx: align usb wakeup clock name with dt-bindings
Date: Fri, 15 Mar 2024 15:24:55 +0800
Message-Id: <20240315072455.2481613-11-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315072455.2481613-1-xu.yang_2@nxp.com>
References: <20240315072455.2481613-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 85564c37-c3bc-4498-9162-08dc44c119f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	68LZUvftbSfAumJxVSjNK1QZb59q6zfzPYsfx/aEBsPN7C2ynGuKMP3ZwTdwwcGIQV9t+dQt7O6F8zia3PPWDhH8gX1I3ijKFfeBEXSKE4SkzKQGwUUE8OjuaC35AYoGEJKdx3Opg+jf5gvFWtqXxJ+KB6D7LEH1WdA7Ps5lMoL6rczJGfi+ZqUD7rLR1wudp7bTffFpp3Qp4DzjFYG4nhA0Or8lwj2+XmUkB6bGFfiuvWljMlCsZ1ix7xuCKMjB3taPH22xklTVRvQBcCyCZO8xHR/7gFcApiXgQL6ecgFmJs/h9wRdvnyVHyGgGmqGOsLUV2PtqlcoanoRMkKpm7sZdRfKC0EdhjYMaIwY/zIW4cKJigsUNI8RusAGGXutQ4faw5tHejs/JVTE8SY2dgH7a8YiEoG6B2sPi6tfG8fxgW8RfxQR3v/L/kvao9rMa8Lb+iFLHipcvHFVG/w6AG1IZpK++ytksT31MrQu08cUZAqwJeKITI7zHuVT8ysGWN3bcZRr6sIQBF6hevfPhUvNJs2vZnIE0Ju2FsyZnB7gZw2HbNNTp7dEfPm5/OY6+TS8l0unHRn0U3k+vKNkDKj2E5RyGHUGogZBGKyRCETMlJ9y1iIpF6Rnv+ag5DYnHWV947g1OpfpicR4ui9DAlzrSiKech8c6kQvtk2b7HQtQpTVS2p9cDmMH1FhjeoOTEHnfxknc7r+4jUVJaWQk5pcHaYuNvtssVCjr3k/ZWs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pCUNe+OdIkeh4BG9fTsWThHsGDJwmcspUBPvweJ2tKK5k7Bsrf/FNGsCEO2J?=
 =?us-ascii?Q?3hRfFyDzeJpeUtHJRBYEFMXcyS4bRXZRC1rpNUJAeOCQ3wwucvBODMe1BfQC?=
 =?us-ascii?Q?FvJbQeBcGiamTfjwOqLBJaGDfwuLeOdXSqVtPyaZ9B+QPX0XWzKMKYu/+H9F?=
 =?us-ascii?Q?W1gJR0IGpnk76kZZSNhTl/v6/O58J0tTPamN3rwAbxwT7ncB8S5MKNmUH1RN?=
 =?us-ascii?Q?Z16AddNd5Ub9mPA83kkUrwFrNP1XDJf5ewmxRY2nmT9J5bCVY9gYuMXEtec8?=
 =?us-ascii?Q?fsZhPQS0hmAODExIrfZwSY9GbLBuKIaVCPuWZlagACEXCE7wrag18utThHPh?=
 =?us-ascii?Q?JEaNI/lB2ShvAkLAtHOziffrNQjVQPX460wQUNyLbzu5bH7od92UYEWaQUO8?=
 =?us-ascii?Q?Bynsxoh59oTxKT8Q04GG+xlq3jZgCx3uNOnhJaNcYGTAoF0eK1m5Q2hS+LmU?=
 =?us-ascii?Q?kvKhHo68DhsPTuWKTRge2Cs4Fi+0q0Ew9wQ/PKmJy26fAyfcRbFKOk1s+TaA?=
 =?us-ascii?Q?QckWWjHX55pccU+9ZO+5MggiKlL2GfHCm5CgNx2/MrUga+tsZJXOGtHmhu4f?=
 =?us-ascii?Q?P/sJmWRxMK/Pa0euEOfemR4spstjcIIt7MCY6qNKnjwWc0xgo8sRGgJ6Bfse?=
 =?us-ascii?Q?N4M9IOEiB29bwBxJrwuQSJl7VA/cdjzU1N7ZzdEKShBodfQoRQ3WexEVVgC4?=
 =?us-ascii?Q?qxfWLRxIWWMISBwPTUTo4rIgNyRms5/lO3nZHykdO/Vr3F+aU1X5KBmNeXca?=
 =?us-ascii?Q?dXmEvdH+m7SMcD4RFi/ZMQ2SwP/7T/09h1claYUupHW8/K/r4cBldMj6prdP?=
 =?us-ascii?Q?OEPdfVLeDb/90Yp15Kj9AnFXYpw500IEjranGBvXfmlvcy8PQFCRL5KLAJCj?=
 =?us-ascii?Q?/ajatcOplZ+shCqYPY5igM6fukaZssvn44lXPD4uMvdqTEdqMKvR/UACcrl0?=
 =?us-ascii?Q?bX3xY7y0qbP68Es68SoQJ4yd3465WdJspN7s1f+lkPFQFyN99yK2YrJZnb3B?=
 =?us-ascii?Q?WoxIhI2MSW+tPkdwqVQuNvqlihPYaw4WLhe9Fnl/oLmiOmuRWkc1W4VFfKZ8?=
 =?us-ascii?Q?bt6wwpquWg+YSCj0GcwTlLidzxMED2f6J66CH4VIyJYWF09pUdjmZwQirmLz?=
 =?us-ascii?Q?sCMN2TtNyOrflXAFecRiGX8NeUL8Xsx3aYdUXxTSC6SYl4sCOpdpuDzInwMG?=
 =?us-ascii?Q?ip8caVJeaVaDWRkxRgzLlhtpxAPCB8mOl7cVKd82DKwHP5rDhTnJKxGMCToJ?=
 =?us-ascii?Q?/lNzIwlhG0rwnqgFsq6CI287aqMJQ2tN1aYFvoYrZkmrR8ZB+AD6P/bR3n8B?=
 =?us-ascii?Q?7SXLebz4Tn65pUoHKfN3v2OzTwulcOzOM8DOBpnVjlYd75p+UmDUyor3S01U?=
 =?us-ascii?Q?8Qn5q6Ck18Ag0z5Uuh0CDs9xCvAfEVXwuV+GUBuP1Ve5MRUuiVECRPaOTVD2?=
 =?us-ascii?Q?FDZ6YS5H+flZIiPpNecwiqq737sY3f26p6a1fGPBJ8cB/QD9CG4vnh6bTSD2?=
 =?us-ascii?Q?ac1DvBb9dvU5wXxQW0Fd07zFo/hJj7vetFvEG/ns2ODMjgD4g6V0QKdYM7wT?=
 =?us-ascii?Q?W3AK1p2ieOwo1VZRnswtVR+XP9qGLFDrshJRD8eb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85564c37-c3bc-4498-9162-08dc44c119f6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:25:33.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBRS9mlPGyVWdqwQEwt1uueDkQUANV6ghswRK/Ld+5F3LQi/vptrFc82O2pnndiwCcTZbgM7IFSozjfGGGgDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

The dt-bindings is going to use "usb_wakeup" as wakup clock name. This will
align the change with dt-bindings.

Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
Changes in v6:
 - add Acked-by tag
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - no changes
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index ae9a6a17ec6e..a17b6d619305 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -212,7 +212,7 @@ static int imx_get_clks(struct device *dev)
 		/* Get wakeup clock. Not all of the platforms need to
 		 * handle this clock. So make it optional.
 		 */
-		data->clk_wakeup = devm_clk_get_optional(dev, "usb_wakeup_clk");
+		data->clk_wakeup = devm_clk_get_optional(dev, "usb_wakeup");
 		if (IS_ERR(data->clk_wakeup))
 			ret = dev_err_probe(dev, PTR_ERR(data->clk_wakeup),
 					"Failed to get wakeup clk\n");
-- 
2.34.1


