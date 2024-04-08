Return-Path: <linux-kernel+bounces-134980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C14E89B990
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A931F2131B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53CF38393;
	Mon,  8 Apr 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SkF4/67E"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2121.outbound.protection.outlook.com [40.107.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB32BAF6;
	Mon,  8 Apr 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563102; cv=fail; b=JDAtmMkkW0xUDGY1lCvulzzqFQDiYI/qlCpmdyhqKEyekTiWrYzt0upfgd6STc27MIXAWYJajfH2eaZ47oW62MfXwJEM7w/1JDteF+FdSvvLZgfll1gXLo+dB1kud7jT9ZSydDcE0hWpk6mrUdzMVjdSMYRCcuaE7i3KFRDLCiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563102; c=relaxed/simple;
	bh=+G6ekYNYShQMw4dlXmhlZtDr3usQTnHRTgxSXL7K/zs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D2CO/sUSrUSQVVuvUb1+3pr21dBjtoJZwLnFhbQ6V1RYjxk5qE7NwqKByiPhclVs8lbEN/YZ8RkcnQY5rLWoqU5bO/3Fr4XTg0rcz/KXT3sSWrFKTPqEH8FAxY3OjBlfR5EW6aSqRbMk9SR6ZCOKUevWhQv2sJWUMNNW7aJIm0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SkF4/67E; arc=fail smtp.client-ip=40.107.20.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8Lp0A7EA4Y8rdA4GWg54kiVMika26MijZaLs9As6WtZJvyD2qnK66wjKtspV5G+AMp9cHCq82b4xN+dAMKeA8hW3l37abMtlMWFB+1MTQ0kVinhlwQE8+cDgg9UbHbIpk8EkLJnIXRoB3xEwFX0gqkDQbTxaKcpT0KdgzI9XrbtQ246hkoqgQGSZdAz/Os8+YD09ahR2t42TrjSeeZgP0lvgLEb3FgkDgIPm9EZP8w3K0JDXefH+tywONUoL0uo0O9ML+GSkY+N20vOyCHU2x0pPmSE1QfyAFqFFfIv0qyNd/bv1nqjhasrDgmWtJJShCkxI4W8dvHKNj6AWGpPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw+zR2FYL4uZyJWN7bTdu5W2MNsOZCTJW+JQOSh69gA=;
 b=JFb7M+GOs0ehLqZDk+QLcxceTr/rrkj8+5O94gNynoGASsW8Pz7yUpBGZUzoKeLBjqzI/QnY9yQANUXR6iqjXqlWk4aKomG0yh4ThsQ2TszVrmyly2J4vm02pc87EsI1s/gQpQpzhuMjJgD6xFAJaPS1Yg0NDsDtUA8oefWsV1Jd248pA1nT99Rj/6l9r2tMttuVYHopvjqO0yERcr1P0EpSx0KkRhna+OMusuY8cgU1tjWfrM0H0vblMyRM77CQR625FeFa+RvZvn/OliOJJMwjkUqDdGjciJ5nclwPbTkCoIFklazTV1ppbgnSgb73q0peNQlowQGP/pY8odYWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw+zR2FYL4uZyJWN7bTdu5W2MNsOZCTJW+JQOSh69gA=;
 b=SkF4/67EyYmuoM3yXdObs6Uo9x0znxrj75KJCULp0rkTouqMRgRtqf5Lawod2hy/rXF9fdxlvOeSHrNtMwvqQMNdB0p19pZ1X8412uZrcl7F76EayvDIddygYZjfIQ2wuEb7YwK42oC+QRi+VQf/WDK6WL3lXA1gLr1SduLP4h4=
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com (2603:10a6:102:2bb::10)
 by AS1PR04MB9359.eurprd04.prod.outlook.com (2603:10a6:20b:4db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 07:58:17 +0000
Received: from PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57]) by PAXPR04MB9231.eurprd04.prod.outlook.com
 ([fe80::c2ee:dfc0:577:cc57%3]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 07:58:17 +0000
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
Subject: [PATCH v5 1/2] media: dt-bindings: nxp,imx8-jpeg:: Add clocks entries
Date: Mon,  8 Apr 2024 10:58:06 +0300
Message-Id: <20240408075806.1194297-1-mirela.rabulea@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0057.eurprd03.prod.outlook.com
 (2603:10a6:803:50::28) To PAXPR04MB9231.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9231:EE_|AS1PR04MB9359:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oISNo1D+XLChmSNObMgH/iupJAKakIPE+xr9D1dFjndmJvKI1e3TITOe7MT+6EUpfpHs6QflmQk3Na5hHKWHjKML/a0Qml9hEfu/MWRNfYC3GykiaLyRPBER3VLM0ztxeg8M+nBmzH+uny3cgThH4m+gW47w4QjIH9aiINAauJ1wYOZAuZwzamGzFHXfNaqD42n/DPbxiRIT5GwIvSRxxRyLfQzOSdU9zjw374cneuCbTC2xkkkNnBvKemksSNKsuPgOcC9bC8Bk3At8XSC+sP+HHj4xPSKkTswwp9mDKg8fEQG45xY2l9F6YIDGOl/hmmdnoDRFJNs4TUF75MXml8q8v2LF0+UakJivuovikZpbgzhICMhBD7E9Vlr4uXbOu6h8pNEBrINCl5mLek+nQ/VqNC1dRQy9E/kDIVCTMZGQQghbYm644ofYIt68ZV/rtpO6khgnRdQyDg3OC5IrpCJXOIesyd6qY/s/DgzwpzwhOSlj6i2DrhQnfSbHq3M58JBrzmroR7tIMCaX3nem1ZxMIjZjz93Nwcdn73QGeJ+D7SgjktiRTBXnA/WlsLu5kA4efX1JMEnYeWrymXSNs+5meQpEwEVRviOvr4DKllKN0o4sYl7eerTUvDj9i5m2sM67WHwFC3cVEQJSKiZwBLjtH+F4DMHx/yP2s0+JYq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9231.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CoKYB4qhhX38uxTzR4rSX6bKr7uWNSne1ALleAOimnom1nP4odoPse4VqXyk?=
 =?us-ascii?Q?b3I/zFRC4P1E4ujF193AtYkWTOJUjmXRgatOUmlcYEfrO6MYU25tqu1CdRMT?=
 =?us-ascii?Q?TQf9nR9AVVwMxz75JelfSkIwy/luKQrobng1PaX72uc7CL/IP49q5djU+/B1?=
 =?us-ascii?Q?kfaupaM/ytrYeFX/a35kTACgF5K1Oj/FrlyIPlkKCbiSZANVEHmW8lePiBQ2?=
 =?us-ascii?Q?Kx42BVI1IGvPpWZt/FY7qBsb043b84x8klkiWZrbX+eMHQE9D5FhJhlZiB8V?=
 =?us-ascii?Q?Zr+CE+IjBykMGTB4522YyhT5Wmor2yJ4MHQfIQI3wwhMOg4EigWupvYwS0uZ?=
 =?us-ascii?Q?Rumz3xEHp7Oy+o+0/0Nv3pluaQ7Ngu2dLHL7q67BycUtrTQCybQCLQVal2vn?=
 =?us-ascii?Q?QA3QdBGR5M+jLqf3OWF1x0emYRLLrOmodjw2EAfWj4z83I6RhcHeunYzkbcM?=
 =?us-ascii?Q?EuOuienNDMGNdSVaR5LSH8qef05q1O2j7qR3WAHWWFS9G6dYes4Cdk3iDb5W?=
 =?us-ascii?Q?N4LRiTSLVOlmiaC8vegMkoF3Y7+DTgYxHt7sNpRX8Xz8bM8zCmS+oIB0WMk2?=
 =?us-ascii?Q?+PyIs+I/K6q9rFVssxBzw5HIITwCYC1C/XZLDbMM6ra9mlSEDOHofzMZAC+U?=
 =?us-ascii?Q?3TkOHiuhgYmjJa/oyfJmW8YdDtb7VZMN7i0eA8fMHXBUnle32XmGsJFvWHNm?=
 =?us-ascii?Q?SfH+yG0EJiwE7bOQ8RXxnGI4RDZFvHa0A0ourkhuFTNQALITv3541BBv3RZc?=
 =?us-ascii?Q?/UyPOTn2Nh4jZGxTpUc+StcwznOClbsp5Cbi5XCU/fwULqqcYmOHJpDquewA?=
 =?us-ascii?Q?ajaMSd8GTcLv+Pn8lGe4I0Icvu8tbqasbZcmZUFoPS9rdbO/iAFcZ87IXBdy?=
 =?us-ascii?Q?jm9X0ttMseGQM/OdfIeC46vH2twm43/mDBg9rYFwBiul0vsQRF+zgLuor+7P?=
 =?us-ascii?Q?1LW8X9iPY90fo7Y9BkuPa1DyGDeLwPYRamFUTxkbD0+DojRJHgq68TuU48++?=
 =?us-ascii?Q?DF7O5BwD63rsads++JhlKBkfNyMnuicpqmPIUm1wUUujyrHriEAm7H4S2q+/?=
 =?us-ascii?Q?LGIGI0AK5LozVNBTBhZXa+MtBQpgD6OK515hiqyr6TUUZyLPmhQanIwbylHa?=
 =?us-ascii?Q?QYzWmat6vx61eQuhOMKWk6pWaekZdlX5yr36cEZMQjkcLeEjwkj01XvLcTf6?=
 =?us-ascii?Q?jgsnvBzZFA7HlVYVX9g974Cuhnynh7uUQA1MgkGZgvUwUnhQEnjDdU9/6C21?=
 =?us-ascii?Q?CPmHUwH0xb14bAhxp66+oIFDEIUO9GIBp6WzTQupqjoiwjHkw7uyjD4w2zIe?=
 =?us-ascii?Q?BNCyzUqSK4514q2ezL35UdPXDoQrsMvcSVnTaBZlYqY/hoFMa5D+oBTZgxhe?=
 =?us-ascii?Q?VIfrjSpp3Oeup8OQQKt/6lvXawVQofym5xzQCms3rM/b0T2lnOZXvNPLxTzZ?=
 =?us-ascii?Q?nLhceKII4lqZ2yS8YmPXpef+pxQjH2oEwqz5JECBsILrE5pYuzPy7p/2U3ol?=
 =?us-ascii?Q?BFBSXjy2Dpjm+n5vAXSu0FO0Wevxo26reEeq9FZNFjBnEkq07z0ihb2jSrJL?=
 =?us-ascii?Q?472k8XzieLcTwSa0VYyrk7DicD36W9SqddYX6q2o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5846a223-265a-43c0-bc09-08dc57a1a671
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9231.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 07:58:17.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTojo9ETMa7kcDjPQVEoUB/di7zfaHsFvaMnuA72VvQhkUKRJmtwRyXkB+kdAYZ2K66qzgsOFOTDW/gUajm40w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9359

From: Fabio Estevam <festevam@gmail.com>

The JPEG decoder/encoder present in iMX8QXP and iMX8QM SoCs need
the PER and IPG clocks to be functional, so add the clock entries.

This also fixes the following schema warning:

imx8qm-apalis-eval.dtb: jpegdec@58400000: 'assigned-clock-rates', 'assigned-clocks', 'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/media/nxp,imx8-jpeg.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
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


