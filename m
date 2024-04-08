Return-Path: <linux-kernel+bounces-134742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1D289B643
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422C4B21B90
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD663BF;
	Mon,  8 Apr 2024 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sOO0o+sz"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2133.outbound.protection.outlook.com [40.107.22.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F95522F;
	Mon,  8 Apr 2024 03:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545671; cv=fail; b=HJ5lVB/WRbD+d8Wg0ABnXp293y+ztllNSIby58YYK1s4pZkfM8TdKi9O+gq69JOhJHjC5VsLMZgSiq4ZS2ORaH6Q6FRh9JJURmL5Nf0jaDPzR7DxgQ1ThJd2SjHorjzBSVozKevhKKoL5sOh7vzCIc2NlgIGf+ZoVVr3F3hkJIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545671; c=relaxed/simple;
	bh=qvkG6+3y9co4gozhwyzZhK6s2pRVrvqvo9BdbhLKjxA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ueeluzuNMpMVVBx3iwZmjQOeWhj42W75kGzOQCLCtAF/PRYB8CrjfNeFzbSlT2T3DSLE/DI5g3l5T8YYmHxsQlUnPsz8mbP27hbruqHT7dBOSeTCst1iy7HQDPg7Romh32fO6DEj3E2MbFvaMnAP/3us3qzi7oUqX7Z7hsUM15s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sOO0o+sz; arc=fail smtp.client-ip=40.107.22.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV5nvqy5XUMl8aIQZOdu9tDQXsv+u6YhJPYR9Vn5HF2VdKmUxgH6jUquS+bvwG+Ea5YWntLJKNas3aegZKmsTqWiCuw5G9ApVMAfur0QmqzW0ZlbZaMvT5peUK7N/mdyqdLArJ0/ZFpHF4nM3qZPGpMR9h4zDvi3cnzAjzhxl097YvGUbZkee+L2yGBbPOA30E4uPFhXQ8L2lihcKp6y730suQaRePl54f0I6RFa9wZBBpQyhsOaXlTC+m76AorXhCnH4IGnVgD3IM8zB14vn1uvo8hb64Z2cz1/W3Za/TXiKCjzXXksq2eM9MJJbDY2CD7OGsEhwMX7+O+jd+Je+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPVUd+25D4BBiF/1iv7dQhG1F/OANy8Q7W8+fYBYOaQ=;
 b=e2Iu9oAk4D3qoQX4okW+DSqlHZwqt/DhfCEM72FSJIHVkNNX0l9I1VNLJchRenVFGLIJIruPCfTxZJPbo9d/yy6d61OLYw+5xmndYektrExmWy/coxHjjlo4f9rMMaSPtQP+01sOMwwdy4EByGYnug8MoEmt8RK6fuBU8KMa/divS15RZ23rW+5j3KKkEsQdIARDBa/yrOkUImSVaIKh/qh11XRTN3dNQamd7vSsz4qEZE9OyntaUQpAFbykSG8+yWHM96n/hnLLX/c0rp9uzpu4bH1u/Rd2O/MLZD8pk+RugVAn/S1u2zkCTE6ZpJfcGIzTInrcwSTs7HpK7AoQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPVUd+25D4BBiF/1iv7dQhG1F/OANy8Q7W8+fYBYOaQ=;
 b=sOO0o+szykpz98LLcoabvsUkOSMuz7+ZN5YLZOwVHcI+0H86fnibvwerNzhIBO2y6jDuMSJFT3v0J7JGk5aBBdIweUvYZb23UjWv+VyGK4nil1nYb8SZM6sxW/B3nZ8ctLIQi1qCaIhJINWrEflM8aNKS/4Hn059OW/Xum2Bz2o=
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10)
 by DBBPR04MB7561.eurprd04.prod.outlook.com (2603:10a6:10:209::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 03:07:46 +0000
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57]) by PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 03:07:46 +0000
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
Subject: [PATCH v4 1/2] dt-bindings: media: imx8-jpeg: Add clocks entries
Date: Mon,  8 Apr 2024 06:07:33 +0300
Message-Id: <20240408030734.1191069-1-mirela.rabulea@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0230.eurprd07.prod.outlook.com
 (2603:10a6:802:58::33) To PAXPR04MB9231.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9231:EE_|DBBPR04MB7561:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	54A+21/JmArOUC/6xjWBPOP9NYKfTC0g+MT6ZN4ipaFtJNRME4VAqSf+8ADJHlsJzskJQ0WhYK5bDnOridNK35pJP/XzR+vXmvU6qKasUkno3iHq3hyV6lxsCTwHPVklSmx5LZp15WWpl+fFYKmHZJnKUX+SwCjieBdD+BbC1feXadAPevhbysQzUAmfO8/aP7I1wgy/CgOSba2ZR8dlJVqCEupkjO7NTwTYwSInErcDZ4920EWaSmI5vBedhAigEv+Xy1n+0SqGWk9EqwyrvC9xZQ6X/Yadg4odq2l057BvlExJGD+ICxsDMPoTahTUsyB41pRMRSmG7LfUPtl+hS/xVipFsJAhDjcy9DxgaikEs2tdY2+rnvDcWvuzlG9/66Z7SkErV4evLmkJdKEZSCnLuaSn9MtdcMAuJgosHHlUXB8iNpqf879M8QNwh1j8WzeY5t4VRsNuK8xPide4VDUssoSu9D8vXaNIn2zxr4HjJX6RokTlPujSAfRaGkBu4CYgL5CCdoUfiwyONR/tp5YnuG2tZhMUO861KtvD85n1uIOTy6b6a/AGGAYnRC7IFBOgxmhFwe+uG4vpjVf0MEJlkcL8RA3upHngJRqybtKIh4TiEOJxB0BybS4CK5ViU1NxefdUG26L149TfPuGN+9hlebW/GvHvX6cf4JO4+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9231.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9OBZKNNlUf/Y2ccS4GTe6CbZvSxHw2oUmqzYBMttmP1vJkt/Lw0L+/iZZwIm?=
 =?us-ascii?Q?7wMyVVI0DDGUnrgju7kpHISBH2I8li0HZsSuPF2w8AelWQ31ScIRW7SXItIj?=
 =?us-ascii?Q?OUoSNHEUBibuDSGI7bCAEmqk7CdU15IRphur7nTWebGkatBhuf3rvVuU3zfG?=
 =?us-ascii?Q?BZd00uKjW/3N+ZuRvjmSNzJcEgbkyeZ/4fAlEVq6hoF/8bEyKjZRDxobeEto?=
 =?us-ascii?Q?QAlZf7nLjcJoGHfYSGo3B9IUZBBBTBPhiaVRkIZTplLYLLluGp24ev5D+UuS?=
 =?us-ascii?Q?X9R2jOTs/0ONpGZjwte5s0oyN5XtCiwLcp+mW+Rro1AVA+gTwGNLomzq3W9H?=
 =?us-ascii?Q?B1PZIq0xAikX802bbK2TslQzJbYzKsepGT8sid540wGML/pnwuUlsUxsO08n?=
 =?us-ascii?Q?h7ngio0/6lWrM27Efu/Nf0WzTn8kB5eu2MvbFlHoEDu8EXbrwY5X1rAWc0jD?=
 =?us-ascii?Q?hOrmeqHJYI4Qx953xCbRMOLN4E1pXGj4p7o4Ws5eo9j7jCcetFGK06xg2RWL?=
 =?us-ascii?Q?ngsqNEo2UHhDoJPuu9k6xy8gp9EAndY5u4sTTCTnYWX4FqYi5LPFCiAKlchf?=
 =?us-ascii?Q?Lg73m0Mcf85IlRvdFgwPCvphK0yS/2Z+J06QvQ6PwtNnT9K7wqt5LJTkxd86?=
 =?us-ascii?Q?wZIuFXQubJq9cmdfE+rBP+nTRRBC30w3k7njhDBx20OHJQDTqym4PUZqJMkD?=
 =?us-ascii?Q?wpR4bYdXBN9QJ01h79LQSarzGvaXb6vXCPFRkd54adAFBSB7batPNy+Y2I1u?=
 =?us-ascii?Q?2wWPn5jFXxpm1OyiJJVSOPZDqrepjUdT41iqYmbzid6SdcnWHwTYkfGvqNTo?=
 =?us-ascii?Q?ZSyHLeppceJMFDeeXqXYR0UCJ9bcW2kFvMb8joXO3GEMoXed4mFQckQ3Okda?=
 =?us-ascii?Q?5PQurh++DuwL8ZwT9wDaODgftfndNSoclzd98O4LOBs2+feFFq/qaGQHbOQx?=
 =?us-ascii?Q?Qbz6r9y/bJUb3a9MCuTjNUG3so4ZJKVgA89h5xYcPbc4Ob5a4eB+boM5dVyh?=
 =?us-ascii?Q?ATcPKqrdIdXWdNA8gNTfsvcwbrwsUX+YWOZyyhu1Ll/1uMgYZmBAhBizkJPM?=
 =?us-ascii?Q?IJQmH3JMmcO070WLfdrNbRZ+LFcNzKYgGQedaRlTwxCq4F6IuTvO9b/dhEbc?=
 =?us-ascii?Q?jAzOyZ4MiSvSY4hIjbG2MxxyrDJHgdmh7DTvRRYn5y/OiiR6UDU0IB4UONXA?=
 =?us-ascii?Q?z5b/IQ5VtCnPUdpsOI1e40/PWxhLAgWGLHzpyBhIizBpbUZgmCl3d3qKMZog?=
 =?us-ascii?Q?MGOwNuMBXyPJdZ91L+fxI7SOoxWmQO+TV7BJyWrTD9lSsA652O5VQgNwo8DA?=
 =?us-ascii?Q?zra04dF6I6yRn1ZDHMKUwzPRcZ2+uzk5YYM9z8YH8bc5ikhWE5uaOUQVD7Xx?=
 =?us-ascii?Q?mx3NZK1ex5Btai6FaabgvQg1HwgHPF96lumE/zlfm1TF7SY798Xq8qgMGr1v?=
 =?us-ascii?Q?R+yizXwiplXgyHeBQfxF4hI9XBzx2cwEuODYYwEiUIBq4UWV9nmnaSc5lzry?=
 =?us-ascii?Q?Ev6aZ3a6ngb4+bfkKoRaGVKhBS0c9U1akgwZrixclFvJ362Db9iqFUkAHoFe?=
 =?us-ascii?Q?Mu2NKeZM69C3xwPy71H+ZO0yLrSQfC6Fu7lNxsku?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30631981-b7a8-4ace-7a8d-08dc577910cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9231.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 03:07:46.5612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ys3oc6E56eduFu9QFSoFYyqk1aejKhBwlpLEQt7gaMIDv5piE8sDCr0Q/cIPRs+15wsjXB82BuZ/3vbCBs2BNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7561

From: Fabio Estevam <festevam@gmail.com>

The JPEG decoder/encoder present in iMX8QXP and iMX8QM SoCs need
the PER and IPG clocks to be functional, so add the clock entries.

This also fixes the following schema warning:

imx8qm-apalis-eval.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---

Changes since v3:
- Add items for clocks (per Krzysztof's feddback)
- Add description for clocks (per Conor's feddback to the other similar patch from Alexander)
- Add "media:" to the subject
- Add Mirela's signed-off
- For the similar patches that were sent for this issue, should Co-developed-by/Signed-off-by be added? Alexander Stein? Frank Li?

Changes since v2:
- Remove clock-names. (Mirela)

 .../devicetree/bindings/media/nxp,imx8-jpeg.yaml   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
index 3d9d1db37040..cc040feb77d7 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
@@ -31,6 +31,14 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    description:
+      The JPEG decoder/encoder requires two clocks for it's wrapper (AXI and APB),
+      and one clock for it's core engine (AXI, same source as for the wrapper)
+    items:
+      - description: AXI DMA engine clock for fetching JPEG bitstream from memory (per)
+      - description: IP bus clock for register access (ipg)
+
   interrupts:
     description: |
       There are 4 slots available in the IP, which the driver may use
@@ -49,6 +57,7 @@ properties:
 required:
   - compatible
   - reg
+  - clocks
   - interrupts
   - power-domains
 
@@ -56,12 +65,15 @@ additionalProperties: false
 
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
@@ -76,6 +88,8 @@ examples:
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


