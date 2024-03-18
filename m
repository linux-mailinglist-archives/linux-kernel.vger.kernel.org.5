Return-Path: <linux-kernel+bounces-106576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3017B87F086
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8592843B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FBC57326;
	Mon, 18 Mar 2024 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WAZxgrQ3"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA756774;
	Mon, 18 Mar 2024 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791158; cv=fail; b=O/41ziY5p7wWgQ3h6otVkBzU4weGwVxdun6x/2DCMwc5zp4I4itEt/6rxZ+bEm29iw197Y19e3sWEhUW25veMbHALH4p0fJjw4WAOeQSqQsF+YlOU0KrB01I2/raPuV36/eFp0UJDcncfY4lKVEBNOnQmgM1t98TnaeeGEjBpWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791158; c=relaxed/simple;
	bh=yc002MT+GmM1P/BpkAN/5VXoouYa5bMeN//BQnawdkE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c7gqVmIbEFfRIp80Jb1+3YwDpztMYRjRhc/clOJyX5ePdLBzCYXHL27bUMLSXQbf9fvzwu5g9NmHQuqVj9n7AIzGrnHLgKRpW7hqqkNAm7FJUM1XGFb2q6A1OVrqwkJ2/IzT2rhrQhqK3ObUbVowSD01GGuNSrK6jp4REEPCAfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WAZxgrQ3; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9nUp+OzKhZjsDnAOEQCMxw5M2bZFXXeyKhRWHGqbfqoEngdkonw5t0/utZokzhZpEcOtnYh3aqCqY/9ZjH1TYoeW8kH+nvojPbEzYM4g1PRbnZ+f5kZLNH9ETIaxhwezjmpqY3Z22o78WXXbfPd6TKX7BwquiP45gqOlMR/tATIYjyeVCPFt4LsP9UDh+dsu4KAKRXrmzmQwwRn9jUN3ewA8ZE3Xydf/iicRPH/CaPw1AoR7Arxv6X/4lOOs/t0EjkKHMv9Sv0cQ4oVZgegc85aJp6zvm61XbH7wzTrpaQNnpYQsvV4AU+o2F+7BUPgNH7rDCvpGxyMzRrh/HXMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Grbht3TEkgdPqmEHjTaA9g92TVDNr5Jc7ivj0I1oX+s=;
 b=KOix8LjI2cIsJ4zrrzRB56K+dQmczmx6ucKL+I81HIFbR6XBEcPxN8FuF2B/5IhljAlrMtv3DRxkmvOuqwAqKhEGRPIgKKzc85J7xOW5y4oli/xFWiNz8775480AxIROaJcqftlFaMifZQlp4T1BN2/ZoDLViacugjv5GJUIdTg3mb0jvm2nvz1LQY34QAcSdTjD5inc0Asd/ye4i3aHP0W3AxDf4lVdEx6bP/UgdRr80+WSHFFGa/y/fw/a/0atVD3UtOqD+unuBoNdrkNiS0vyBw2J7R1CWHUn73cvayQ2jguQsXX3Vv0LYEfX9m3WIUKbseQE84y1dNXHwX1OoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Grbht3TEkgdPqmEHjTaA9g92TVDNr5Jc7ivj0I1oX+s=;
 b=WAZxgrQ3WsZHRBTtgPezdQVBFgjHE0aKRNYM6I6YrPnuGs9vLeEhtoQtnJ9H5sWmP8kBtv0/UpiLRz3tTKKX+gDETq8lRNs58nqheoLnRHGLNBcKa/ramXg+9ueGxmL5Q5u02SaT4U2t1naLhgZTALv1WqeaeOZ9sYfXH/42svU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 18 Mar
 2024 19:45:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:45:53 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt to yaml
Date: Mon, 18 Mar 2024 15:45:34 -0400
Message-Id: <20240318194535.2274543-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0203.namprd05.prod.outlook.com
 (2603:10b6:a03:330::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6d4c5d-36e4-41bc-17df-08dc4784052c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fzk5bWO88mm8aY8Jy8PRwPPI3k7+Evf6ePGud5c6ngrCzO44f8uo8W4MWXlepM9zJIjBgNiumYCdX/K0s+Woz5BA5bQ0mzvjJ8DjLmwjAE51DoX+iHlSA8FVq+aOE0vjHz9igBVjXUvFkmG3I3+RQmyRe4m4tlIUF6mhVwoVodfWphksUSRTMexShsuIDMGeN53nC+OPRO6woAUa3qLRsSS4/pM2e0f20IylMF/WC8udhFG01pxck/u3QCz0cXQrirkGj/voNBVdan0TAm5DdQonRFuhm4dcKma5wRNB594otKZsHLdiRVwWQNpwVvLvanQP5kAFirSrnOHMuoVv90L2G9+fDSPFfIqA2c+TioSrrMfWlBNJupFOUOShu/ZlUqceXOND2BXuBOI92tHoDNEXEYF54vwZqgxK1TY9HfimkrruWXaa1EgNdlRCxn35zyk8Z8dco+up3VIvr5/xY4BxmupcTHScw5S4kvGkZpdl+cd4eoIV+ZTO6nNJPfevDC8eDApfEEXMKMQSH8o2t2UN7UIr+mJ5RLboAz3euBVGC3HHp99oolvLd+20F8qJZO1U7bHrhPT62WfRPlw7FN9uG08x3T+VQ3AJaR6KRMW0EBDSVheSlFruA+8oU3y7Mx6M7y1kDKU35KIysJQT458cG1YmCVjVOZh1c57Hi4M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0dZEQSAMWFYD4Qq13RTF0dMXSInn47gOJOm4i1RtTJhcIdt7QQuBq/voMdDO?=
 =?us-ascii?Q?a69HSZflA0vd+XsdtQg4b/whWUT2hWBb4eQoDTBFZLWrkbbk+M16+BmgUjsO?=
 =?us-ascii?Q?cMlL5qN/G+yR7TqWH8YHLSvqA3Sl9gcccaYdcYoSc5n7VBcImU+R+0+zvf88?=
 =?us-ascii?Q?GmczL8fO5Y9AL19RXKm9WFLTRuuOxLLTv0BFtwh1SrS4jQCEavtoKmubzB1l?=
 =?us-ascii?Q?B+GvU1+rQ0jFgh5ep/1t0hzp1FdNeFzBqJc3mTLmmX35Z9GEqeZ1Pnpydj3B?=
 =?us-ascii?Q?yPowzSMexIMP2qkAtM3ChtA1RnGXQLJ75LsRkHIl8Ymd1rjfuId+gNF415j6?=
 =?us-ascii?Q?/xxK3+6filWwQF+WVn6FlQzNw1QAbrEPQ2J/UsJ3DlCN19bdrqYYL8/ezAsZ?=
 =?us-ascii?Q?x7NaYwRXtFNynHwRHKOG2Al/46zoJMWIEC+4ds3mfncjUIFHn2FbGu0lTJc2?=
 =?us-ascii?Q?NgePgl0oBfKOtPV9PfnBGRks7+XM0XTfFVj41EjLaQbJH4f7kre67MRq76vG?=
 =?us-ascii?Q?/kQcpvNmo8ponj2MUJ1F9tLJrSO4vxIhVzOnn/BqAXDKxoyzxUIn6i2BUZ88?=
 =?us-ascii?Q?6ZtR3Sg3uce/3ZYxTW1z07mQ9eTcIPLXDtbuTebyarRM8CX8GU2aCMI4Xkpf?=
 =?us-ascii?Q?4++BehKjhx4DQszYBan4eDHAYm4MohCu0AIK7zVwwMKwiTgAig/cG86nbxNj?=
 =?us-ascii?Q?kqT3QJWmZcjQrFErd+EvC2UbQCWWDEecYmyWm+HlsN8nz/CvCNBBbd8yco19?=
 =?us-ascii?Q?LvCBr7LKTaTQ6OmW1gf/Uowsk24v2axXDl2ZWDC/3MVNJhiwmFpW9mlcCDb7?=
 =?us-ascii?Q?RMT8OeIjtavBylc6mN3Bfi7QIhKKW+36Al/LCfXDbFANbcTeowX+pv9NGOR5?=
 =?us-ascii?Q?R/VVEoayRpPS2aWSNfA1w64u8obiCY8kP8UGHiwcze8O7CuKIThY7I2svRjE?=
 =?us-ascii?Q?1CvNEgwTJ6E5dXrchNUeE4H/093Rpuy1inaUwyDQM944U0y+1/0yfRuWcfBp?=
 =?us-ascii?Q?4KLPsVWs2/v92hEKF56e/PV3FZ0q5z+8Up196vIEOc9cTYM1ZixioKJ+8i4c?=
 =?us-ascii?Q?ms/ki+SmihjuOodNV2Sp8vqkWMNxTDPbzpf0UWuaGOqKCsjTKrmvdcz6SgMK?=
 =?us-ascii?Q?d59HT7nBTzcpY8HVTLRmyMDChBOHJY6FTwpVtPw7IQYTfIRq7PqpHkGRbEe/?=
 =?us-ascii?Q?mShf46wnUWoJzIyNJJqJilMkDXE7QeSu82FMs/o3fgA8jcN5HKG7OnEwjTsU?=
 =?us-ascii?Q?NKfLdxskrtuxYcW+ULzV2H+9y2l1ON1tX9NivEISXroona+dtuLw0yv09+Fr?=
 =?us-ascii?Q?IYHaER4gY7AcMV/X6bhu5UoApyasLLYJh1y6tA088bq8h30CaS5afv55k1cA?=
 =?us-ascii?Q?FZsV8yHJ2Ufhdb68qEmCmM/lxScrR6PYlRiOsIBzrnI24LDnqjWh4UI6Z8wA?=
 =?us-ascii?Q?Zxnf8p/7ZUXKYiNG9QwmypES3TM4J5F2qL/qDnl+SSX8dJtPWr5dggwdRB5f?=
 =?us-ascii?Q?u1dWb2S8NkCsBjSekyZwCl5BG5bx2J5eZ8LbO17/GKeWGmbn0ZAxv2BTX4Kl?=
 =?us-ascii?Q?ldok2VltxuvnL9X9+hC12mxjbHoh+832BYzP2Z6m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6d4c5d-36e4-41bc-17df-08dc4784052c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:45:52.9322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDo9JWCxHhwHc1HkkdiOqlI0aee6Dri6Eq8Rkt1MRsT7pd2RuAPREwtAh7seEBTixTPso6RlJ+VEhsl3wDh9+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429

Convert fsl,esai.txt to yaml. So DTB_CHECK tools can verify dts file about
esai part.

clock-names 'spba' is optional according to description. So minItems of
clocks and clock-names is 3.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Pass dt_binding check
     make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esai.yaml
      DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dts
      LINT    Documentation/devicetree/bindings
      CHKDT   Documentation/devicetree/bindings/processed-schema.json
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dtb

 .../devicetree/bindings/sound/fsl,esai.txt    |  68 -----------
 .../devicetree/bindings/sound/fsl,esai.yaml   | 110 ++++++++++++++++++
 2 files changed, 110 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,esai.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
deleted file mode 100644
index 90112ca1ff423..0000000000000
--- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
+++ /dev/null
@@ -1,68 +0,0 @@
-Freescale Enhanced Serial Audio Interface (ESAI) Controller
-
-The Enhanced Serial Audio Interface (ESAI) provides a full-duplex serial port
-for serial communication with a variety of serial devices, including industry
-standard codecs, Sony/Phillips Digital Interface (S/PDIF) transceivers, and
-other DSPs. It has up to six transmitters and four receivers.
-
-Required properties:
-
-  - compatible		: Compatible list, should contain one of the following
-			  compatibles:
-			  "fsl,imx35-esai",
-			  "fsl,vf610-esai",
-			  "fsl,imx6ull-esai",
-			  "fsl,imx8qm-esai",
-
-  - reg			: Offset and length of the register set for the device.
-
-  - interrupts		: Contains the spdif interrupt.
-
-  - dmas		: Generic dma devicetree binding as described in
-			  Documentation/devicetree/bindings/dma/dma.txt.
-
-  - dma-names		: Two dmas have to be defined, "tx" and "rx".
-
-  - clocks		: Contains an entry for each entry in clock-names.
-
-  - clock-names		: Includes the following entries:
-	"core"		  The core clock used to access registers
-	"extal"		  The esai baud clock for esai controller used to
-			  derive HCK, SCK and FS.
-	"fsys"		  The system clock derived from ahb clock used to
-			  derive HCK, SCK and FS.
-	"spba"		  The spba clock is required when ESAI is placed as a
-			  bus slave of the Shared Peripheral Bus and when two
-			  or more bus masters (CPU, DMA or DSP) try to access
-			  it. This property is optional depending on the SoC
-			  design.
-
-  - fsl,fifo-depth	: The number of elements in the transmit and receive
-			  FIFOs. This number is the maximum allowed value for
-			  TFCR[TFWM] or RFCR[RFWM].
-
-  - fsl,esai-synchronous: This is a boolean property. If present, indicating
-			  that ESAI would work in the synchronous mode, which
-			  means all the settings for Receiving would be
-			  duplicated from Transmission related registers.
-
-Optional properties:
-
-  - big-endian		: If this property is absent, the native endian mode
-			  will be in use as default, or the big endian mode
-			  will be in use for all the device registers.
-
-Example:
-
-esai: esai@2024000 {
-	compatible = "fsl,imx35-esai";
-	reg = <0x02024000 0x4000>;
-	interrupts = <0 51 0x04>;
-	clocks = <&clks 208>, <&clks 118>, <&clks 208>;
-	clock-names = "core", "extal", "fsys";
-	dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
-	dma-names = "rx", "tx";
-	fsl,fifo-depth = <128>;
-	fsl,esai-synchronous;
-	big-endian;
-};
diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.yaml b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
new file mode 100644
index 0000000000000..9e31283933d1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Enhanced Serial Audio Interface (ESAI) Controller
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  The Enhanced Serial Audio Interface (ESAI) provides a full-duplex serial port
+  for serial communication with a variety of serial devices, including industry
+  standard codecs, Sony/Phillips Digital Interface (S/PDIF) transceivers, and
+  other DSPs. It has up to six transmitters and four receivers.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx35-esai
+      - fsl,vf610-esai
+      - fsl,imx6ull-esai
+      - fsl,imx8qm-esai
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+    maxItems: 4
+
+  clock-names:
+    minItems: 3
+    description: |
+      core:   The core clock used to access registers.
+      extal:  The esai baud clock for esai controller used to
+              derive HCK, SCK and FS.
+      fsys:   The system clock derived from ahb clock used to
+              derive HCK, SCK and FS.
+      spba:   The spba clock is required when ESAI is placed as a
+              bus slave of the Shared Peripheral Bus and when two
+              or more bus masters (CPU, DMA or DSP) try to access
+              it. This property is optional depending on the SoC
+              design.
+    items:
+      - const: core
+      - const: extal
+      - const: fsys
+      - const: spba
+
+  dmas:
+    minItems: 2
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  fsl,fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The number of elements in the transmit and receive
+                 FIFOs. This number is the maximum allowed value for
+                 TFCR[TFWM] or RFCR[RFWM].
+
+  fsl,esai-synchronous:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: This is a boolean property. If present, indicating
+                 that ESAI would work in the synchronous mode, which
+                 means all the settings for Receiving would be
+                 duplicated from Transmission related registers.
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If this property is absent, the native endian mode
+                 will be in use as default, or the big endian mode
+                 will be in use for all the device registers.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - fsl,fifo-depth
+  - fsl,esai-synchronous
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    esai@2024000 {
+      compatible = "fsl,imx35-esai";
+      reg = <0x02024000 0x4000>;
+      interrupts = <0 51 0x04>;
+      clocks = <&clks 208>, <&clks 118>, <&clks 208>;
+      clock-names = "core", "extal", "fsys";
+      dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
+      dma-names = "rx", "tx";
+      fsl,fifo-depth = <128>;
+      fsl,esai-synchronous;
+      big-endian;
+    };
-- 
2.34.1


