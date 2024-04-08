Return-Path: <linux-kernel+bounces-135302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0EF89BEA3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A329B23627
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4DA6A8CA;
	Mon,  8 Apr 2024 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h2GdTKpv"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2100.outbound.protection.outlook.com [40.107.104.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF46A328;
	Mon,  8 Apr 2024 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578041; cv=fail; b=n0iLa7InQLE040nKDuu9nvzX5GfEqHy3vVLtBYXB/58jzh1989KN3BipwgtoY6TdZ8Jz38ZhKm5RJXbR4mpNc2oeYsBLTO8hVN9ki8NaaqOO+rA5IuKyGoF8iVT558BW1mIV1TucI2No0rnwhDQ8Nh6biJr4sr1i4Ys0qd+v6UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578041; c=relaxed/simple;
	bh=/nCrm3MPPDlE4v5xmkBteuqThER1QdYk2Y22EVFN9PM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PjRG+d1OVFR8rprguPiPtGM72sBbuCdJkhVlrNN2OohgrZJm52bdJE0Ycu2vPQZqPQXmDNUzy6oAs1txEV4M/Wfcz9p2FiixOiFiukd6DG1okdgav+w6x27jiWPRLB0/IQu9DpZVJHtYoC6tH0Dvi4/A6zT1ej6wZPzY2vvVbYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=h2GdTKpv; arc=fail smtp.client-ip=40.107.104.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O82EhtKWAXLI0V4pybAktTh6fVtPQaTtNhGDnIKGY/ItvzXFTDtlNisVFPXUccd0YnfEgY4SL54ncfCsjeXM4QHQFexJBaIdHAsnmXTEzvQxQ6PLFV5JTDsn1LBs1RSL366C4ldeqMpVe9mxaP0j2TXdBPyT2cHEeum194maEgdgaieCHEzCbyZgYSSigfhk2NegYccGqiZL+VsM4p1G8MNKO5rIZh7fVY5BTyEerfpPmt0VywlXq2Xlz0f+Bj7dm4Ft+3YD6AVooTNaP9E1uMKL4RIZbs78byDlk0Ofu8E3FKFcZMlmpfSGppDQzcsxC+yC2WQ9xqfPsBYgUZLYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC9/hsXvLpcsSZ2/zcwidhkcx/lSKz5cPkQOa6Ew4K8=;
 b=Z+dVXOxUnEQXCzCna+vSrxVP/YAdIodWBqSIAIYwhy1cu77Y5FK/ygfMnRnapvzZZJE4TEB1ydJuYdqeC/bE1/ynpusIj1nVJ5OoMh+reh15tpZlVjLh9lIOQY7UyDP9M28aAVQP46j5bFMWZM9UHjdh4MdEUyI4PB1CtvOQ1qIPGbzH491Np7/CGM2sN8eMraNFgy3Lsk9VuQhv2fYXgQMjXLOdqZILyY5FaXw9L+l2o3q3/KeWDAm5iVKRQZ+t6XWjYufhNtkGEMZfCa9yyOYKVNEy6XFE8KWIhGfI4gY6Kit2E9JsjLZ8A52tCYktWWnq3rwIr7/x3Jksfsm2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC9/hsXvLpcsSZ2/zcwidhkcx/lSKz5cPkQOa6Ew4K8=;
 b=h2GdTKpvJmMCvKxlrOd6Pty0KtTOaWOHgoDDWtayeVPxi1bsm24O9IsAEj8iqwaUAHbuYpOnZ/i7N33EaZCDGEZY8woa8HQGzpvPVxMbLnlAeLiYstHxwoFsjO3AV8Ee8wLH2mXK3Km3KRjBIQbfJMbVZpBQSHzHNfgair+xGQ0=
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10)
 by PA1PR04MB10416.eurprd04.prod.outlook.com (2603:10a6:102:446::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 12:07:12 +0000
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57]) by PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 12:07:12 +0000
From: Mirela Rabulea <mirela.rabulea@nxp.com>
To: shawnguo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@denx.de,
	festevam@gmail.com,
	alexander.stein@ew.tq-group.com,
	Frank.li@nxp.com,
	ming.qian@nxp.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	mchehab@kernel.org,
	hverkuil@xs4all.nl,
	linux-media@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] media: dt-bindings: nxp,imx8-jpeg: Add clocks entries
Date: Mon,  8 Apr 2024 15:06:53 +0300
Message-Id: <20240408120654.1196880-1-mirela.rabulea@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0177.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::34) To PAXPR04MB9231.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9231:EE_|PA1PR04MB10416:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YslSjzYneqSN+H6XeoFSrA8xnT4nRoC8i5KNNmSZzKT+afgm4j9WJ2hR+WGns8VBkJRahUPemaszljTRPuoUB+kVUdl5ZMKqJtZ12oUg6Cdg44q/au1gR4i1xvMbCOj8MdgYToehCWrVqUnXD92499f+ymiY6uA/FCsUaDmpCxj0mKfxBUlizthjUTiGiJq1GrDktKLf7NHfxyWp9mOqrCiTXtxR0ffSaeW/q3bxP6kFUytxUp7f4lVzIcSpAVjTVfcUIoJ7GcJQ7zLu1F7A0RirPe6Mqu45TLrJ3NOB2IchdC2zDnekWCW6Uj+vUMMcWdJtLusssq96VCW3PIwRHk6LjjaxD9zy10if5Pn0/TZy56ZMJS4DxTCBEUF/aBqOVeFHWspJVedGVIRCbDusoIgPQKTSxX4VQr4msdTWB7JsTGbj8YqllZFhQkxh1mnVoWIlGIR51+wQCSCFAc6V4qfbieMj4bJNvR/6Yza3DOfXYZt6B0gBGbK/N3cANymraYc4uM33iouh/DAudoI1vxs+ltycJHT8mkpAkdj8Y+w/f907zkyKdvl4LsEOtl0Tg5QrF4LobY+XwWsf6h/kvf1JJwLru3zR3AHMrpNnyxLAVTVXqd1qi8lFPXd5l9PEjKvvyVSJDOkgAXS6jCgw15TptVNeddInl1Yc7YSu5DQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9231.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qXUSYvbKEfaOZTTJRnqQoa9YW5wS+g+ZS5qxBFXC/zbGnFHMnemW85d7i3ae?=
 =?us-ascii?Q?VB6qin2h00L/SoIAMUeZvYSQItIMRmnRenMlFn1I4EgwvWbO/6n9ufkOCaFY?=
 =?us-ascii?Q?o/RmP1I6t6UuHYdS5NjByX5usfR2Ck1uB+6ulPFDL4otNbXzy5UxcT+AnFFb?=
 =?us-ascii?Q?ZdhabUop55TDq7MdAJcvnJ9pYOFuQUsoHhs/0LGceKlQuoaa/wuG8l64H4B0?=
 =?us-ascii?Q?NMMLuSQRxmAkzoGtLvDuWZaPe3NCBNgp5AqztManHZg2Y9/20vYR78zouwCO?=
 =?us-ascii?Q?BwLWIZHbE3TkbcCkk0VeivxwER2YaP0TLsFSw64AA8DvP58C/cQe5/ZFvSRk?=
 =?us-ascii?Q?oZlujJEkJp/VQlxROTKdosiDj+EBw9MdfcaDw7O2jPIxUoHOF7JFnNpenC7D?=
 =?us-ascii?Q?yTZ7/uZ+zgvp5YtYF4myCJYSPFokzHW1ZO+35bWma0jZJjlyc42BkJYWFwz5?=
 =?us-ascii?Q?vS2oBn8POpZO+Cz+Y5h0f4brbJWtvaVdEMYHKJki3Qre0yBdJA6LMCvvhlCD?=
 =?us-ascii?Q?/Qbt3XruM5FY6Q6e9r9fgEutM2APyzMeSEhUFdGbAEJ7LSgCa1lPzJWVmLFh?=
 =?us-ascii?Q?yYRyYf5xET5t6TA/tJzAYTUidleLrthEBmoOTGQEa28MGxppu+KskfF5B+ru?=
 =?us-ascii?Q?qDIKgP/VsrO+mWThBRqLLp7BlGX0yUbnk9kMWiEbvgsBDCjVUSSv0TQrSZ9f?=
 =?us-ascii?Q?98oqC4d4OYSg7r5wxhikXGxN48IbcNbY3XEDcjTlEezI7icq1+bmUBY3Ar1W?=
 =?us-ascii?Q?75QrY+qDP3Zpwm82DvSm+JvWj0ZGdcFXCDzp6w9n6S1BlHJFwPIgSFOBq/Ey?=
 =?us-ascii?Q?u+S9QOQzZBcwMFCpe/nO5rdVKtwRhxe0ThbHbixI43xvitT3O7ULEtjb3S9g?=
 =?us-ascii?Q?BpB5kJnICicuXkHysoGodr8wNhIcOdM2uSGEZKv7wM5+qm7KVUGDDreRtga3?=
 =?us-ascii?Q?iwWUbehIbpE1+7r/woTd0PtBNIMfS90q+4acmf03rrkf7x35ogvC2DGhgNJg?=
 =?us-ascii?Q?h1xTmRAlEKnluTG0YCVdYuk/TTXHEsa+Mi12dcz+N0BSR+Jz/8IjZFzLpyHa?=
 =?us-ascii?Q?StRwnkBUovt3myp6gDBG4/WChnIQjbAbYJY+btN+nSlJhgBXXVS1l0K09+ux?=
 =?us-ascii?Q?cLiL12+HxltusAszECJOyMf0AvHa2J0cOqnU/L58bfqEtXJf8WFS9DZlgcAi?=
 =?us-ascii?Q?m0T4jQsFCt+QpoLuGT1QWr/DdtU6R9MsgsN9gJ6c9V69M6ZyhZrC/4mxQCpx?=
 =?us-ascii?Q?OO4tg/6vM5DI/awsb3ENZ2HbDlfx8sfHvQ1ulAySWGpFEVffkhVQhGYTCb25?=
 =?us-ascii?Q?vpvsmnimh+MY8+IshnQYEvQZNViMoJDcPmKLWun8k42gBH5CWnpae5JCboyY?=
 =?us-ascii?Q?srTj/vVUyHtHzzgqtwJGTlUOndWox0y1aAJCfnhyx37skBa9/TUFSHTKN4WI?=
 =?us-ascii?Q?oxXIEZkPkGnJwfymdPC0wK9rmZ5NsvxI0Azm1VYs7OPfQUDW03gRo4O9gFHe?=
 =?us-ascii?Q?lCHDAPN5BMlH3o0ewMvLSesWA8Vi3nI7EIY0+PcwYgKxIZ0BtXtxEr6ESlh4?=
 =?us-ascii?Q?9tV52epwYklS2Xm8gGKuFApcELQLB/Um1SsUGCL2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d051b5-7bea-4b0e-6d6e-08dc57c46c24
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9231.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:07:12.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBGaZ31hr1aa6+lAFO++Xu/nNbVflqVz8tLmUlpkFACwMt6m3uLnyNOSpkx1rDtWUNKXpV47svG270IpME4kqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10416

From: Fabio Estevam <festevam@denx.de>

The JPEG decoder/encoder present in iMX8QXP and iMX8QM SoCs need
the PER and IPG clocks to be functional, so add the clock entries.

This also fixes the following schema warning:

imx8qm-apalis-eval.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
Changes since v5:
- Remove one extra ":" from subject (thanks Fabio!)
- Use <festevam@denx.de> address for both Author and Signed-of (Fabio's feedback)

Changes since v4:
- Remove redundant description and update subject prefix (per Krzysztof's feddback)

Changes since v3:
- Add items for clocks (per Krzysztof's feddback)
- Add description for clocks (per Conor's feddback to the other similar patch from Alexander)
- Add "media:" to the subject
- Add Mirela's signed-off
- For the similar patches that were sent for this issue, should Co-developed-by/Signed-off-by be added? Alexander Stein? Frank Li?

Changes since v2:
- Remove clock-names. (Mirela)

 .../devicetree/bindings/media/nxp,imx8-jpeg.yaml      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
index 3d9d1db37040..2be30c5fdc83 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
@@ -31,6 +31,11 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    items:
+      - description: AXI DMA engine clock for fetching JPEG bitstream from memory (per)
+      - description: IP bus clock for register access (ipg)
+
   interrupts:
     description: |
       There are 4 slots available in the IP, which the driver may use
@@ -49,6 +54,7 @@ properties:
 required:
   - compatible
   - reg
+  - clocks
   - interrupts
   - power-domains
 
@@ -56,12 +62,15 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/firmware/imx/rsrc.h>
 
     jpegdec: jpegdec@58400000 {
         compatible = "nxp,imx8qxp-jpgdec";
         reg = <0x58400000 0x00050000 >;
+        clocks = <&img_jpeg_dec_lpcg IMX_LPCG_CLK_0>,
+                 <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
         interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
@@ -76,6 +85,8 @@ examples:
     jpegenc: jpegenc@58450000 {
         compatible = "nxp,imx8qm-jpgenc", "nxp,imx8qxp-jpgenc";
         reg = <0x58450000 0x00050000 >;
+        clocks = <&img_jpeg_enc_lpcg IMX_LPCG_CLK_0>,
+                 <&img_jpeg__lpcg IMX_LPCG_CLK_4>;
         interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.25.1


