Return-Path: <linux-kernel+bounces-106563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B6E87F051
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB60282007
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2205E5675D;
	Mon, 18 Mar 2024 19:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U6z5d8/X"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0F56470;
	Mon, 18 Mar 2024 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789521; cv=fail; b=WfBHrXyAf3/2A52FheVy+vUHNbodHNEV3A8crIzuxkYAXksFqhFtaB+4krNjmJkCfS9fuqiktlKEvOLKecXVsXUMdvh8qQGMFi9kJGJmM6iEVhMmPZnEwvg4uFTvCVoLQPzvo8K6rCQfQYa5MGWLs/O/zr/VfjBz4scRjMWbHBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789521; c=relaxed/simple;
	bh=KJ3vCL3cXoWoRi6jZhqATR75FBvynQKtKLGR6tC7ue8=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sY7irGj69mHnzY/lIk6syZQEU8MeNlTEsbTHaSwqfoVYV4iqayY/Q7uLWZdZGK119aUKYcNHROkYZ03rRILDZ+zTOHYg4v7hC3JCSD6ACsW9U4kjgLIeQNbCD92re//nhcBhOrx+qDLnzmf88L2aUGwYIUmtuEe2/bs3rMjsO8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=U6z5d8/X; arc=fail smtp.client-ip=40.107.14.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcGo2tQ6rrmSdCYLXLrp6bYzwSfKN08AnTOqoWKcEO9ALhGkEk+MCktGDCOErZ25hG3IdBKjAZ0M6kWf96PPpWEI1iCx47if2iv2DkvHy5rMqECy7CjW1MZWrOBTdaNgj9+SNn3C7wTmodbo1cfMYtBmmlQCsySLtDdMv7A02on54qtYLPbWpNZkIhiJyeRS9fwcnivDTKr7KdK9AEfRtePrlyUMMChu204Mkyh4XKa1ao5N4t3FPFr9lqMHfgvlRo+cwJI4AscfBEHsIlSIs2vcfaXuTBesk2zIiSwFz0wURK7raYfS/QVlstKrS+DOt4ctXITClxHgIK85RleCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZWbUpCq/gHoGB2mwe/jr3f/z2vC2G9c7W6actd1Stc=;
 b=ju6V/R46+1nSYfgoc0KbVsFiecKZlxdA2PJrmjKIVwCgVXojw4Jq8/e5KejiNEUf5CpplkilH9lDghPBhpesAe3CrNA73U1Aid1UPSAxGP0zHeKWkxMl+h/m2o8DJYvDC1YSqY8To+95Bi/es444IBw+c1HIEH7Xu001o3iDsU0Ap62ounvOEaXBLPtMAjsZLZ7lm2r49gm3oTpf4fkMUN8uzDV6XPG+XAyYGGIsNlhe78BR3aXTze3m2m9yBwBU01UctmwqOR3RLCEJEM+ikNVd6QHgtLk2P9vfL0sXWFkALwzOYdmZoqCAYxldRQfPmwjKYRJSZcwBpfj7Vb2cpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZWbUpCq/gHoGB2mwe/jr3f/z2vC2G9c7W6actd1Stc=;
 b=U6z5d8/Xh5SryEqUpD2QZIAq+4OTytX45XjxCJYn34neMwOSyZNqmflhkkx8hJ9ycscorG/yjKx83b2cpbUA0tuPa+O19xzAY1+YNmSP/RY02kqvG43PaHFB3NNWnKxV0C+63BFtJRknZ5UerlZGN71Q/2z9TH7yhNt6z27dihM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10244.eurprd04.prod.outlook.com (2603:10a6:150:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 19:18:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:18:35 +0000
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
Subject: [PATCH 1/1] ASoC: dt-bindings: fsl-audmix: Convert fsl,audmix.txt to yaml
Date: Mon, 18 Mar 2024 15:18:21 -0400
Message-Id: <20240318191822.2271229-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::30) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10244:EE_
X-MS-Office365-Filtering-Correlation-Id: 656cb60b-8e89-4730-022d-08dc478034d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qbSP3Yas8gw49Y9+uC8osxQqWGayUr/ncTGV7DqOTudDTO57JHia0rGZg6H8wRdv8oeTsD/CiIWBeXdtDvKYDlgZ1MqDpGV67jj24O5b8MxRJMxIoKkeJ1akGn9CwbK41ZeqcXXAgErILlthcpTljrHouzAizztUMkcqWcPntK+pPOxntLqKV+3FaLBoCzwcyawOSK8FhmTWsc0jfQcxMEH+arosy6iFdrFC18aLfrx9CJufa0fAubSqK2Iqpl48phnmKlJ5wNMPOkHXc+Tmb4q1ftdfXdl3zCHxUerz1SVnedBPnD8Pj8dD5rpmS6UUZUfmUiYvOxmRRwBoha/yBUmzbIi7u1jDYgG4ijGYUdORRpEFDveeQ3Mn7QEGrYsYquWUZjY44e+oSrhusWa+aFrlqRlSys1XFLh5oVMQqXH+oCvB+Yf1pJDPuFl2cmyjgaEB8TjtImQqfMG8pRgnmoig3Ot8wTnQl4XYRPXzOZ1L7up+WVV/yj+hzI8Y3VxdECiEV0ojkWSuc0Q6TlcrlGQ185QY1dXz74nHLQHfeCjntMKaMnKEbr/2v71LrdkmMrxhI4Y2Kv77Pr1joUNGccdUBnBMd+JFc1YMuOwEFFtq/DxHAsv4myLZYEn4AUPM5OcELRVBQhPKQfqE7ypNaUIK96oTSqidZ/Y8gjaeeSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wAveVdgpAk9vQfW77TnzMBpJ/9UpX6u18nb2bIu4f+1+01sxkZHx7RpkOYej?=
 =?us-ascii?Q?gokd+aSpCPJBdqI30zch5itbj1MbFlAXNNRkl/ictF3fLEhihcIUMEsghgIZ?=
 =?us-ascii?Q?MoNoV7BYDpsBbSJG0sQrMbRyFaC7Q2rsbnLr7xSmul7OEeZCuCb2qi9iGVU4?=
 =?us-ascii?Q?vlZrCXysQ57GZcUrwyLbhFP2qpVF00/YIww/jBrCYXvEB+G9OUp8UhOl42lK?=
 =?us-ascii?Q?vDHwWtpzrKDXLUGZZYWMwDFslNXj0dkXaowk3YaKuuFqapsHclK/40Z7x09S?=
 =?us-ascii?Q?tD2AP5nu5HPAwGtNhBuFv6JgE1imjZgtm3l0h1LdHBXTiYbeoX35uoJ44UP4?=
 =?us-ascii?Q?e11wEsmz2y+xifGFMMHZOv+xdpzgsrGB7I15T30r5A4FkfSty6bhFtrDXdCS?=
 =?us-ascii?Q?iyuG7pYHUkz8az86Ws1H6qrpfTHFQZdDcq17Vraq+xsGdBRcnbly21u7QJHE?=
 =?us-ascii?Q?/TZfPLhERoB35qSjbs4sRzgqfhrkxdOcDxehBC0QtPF/2I5+hgfy4TUgjVqK?=
 =?us-ascii?Q?OTxxuqxx8PVQy9Rw669ZlGna/vh5zO5bG5W+Sow51YoOpmCfjT3JWO0V9/7V?=
 =?us-ascii?Q?W3FgkAIH3yixYonxFySynokiKFoXS+owwdHFKnqQ6+xtP6eBv6NAyTzQdXTw?=
 =?us-ascii?Q?WoWT64vQMJxLt3CNBN3IV4LMxEkda7UvOi9QPFI8chxJll17/OQGAdq+f0fP?=
 =?us-ascii?Q?R5Y12av9ZWzZD0qVx43BFTtnBSt2vFTGu/F74Q3cg92OEZnhb/iLyyoB3loO?=
 =?us-ascii?Q?d1XGkv3rwgbhusa0gaRrNlupeNy91anPkrm9KS0ruCoUpSRrYMVFJU4tf11W?=
 =?us-ascii?Q?FhA3PpR9hv982R4JF23+5u5q9dN5KqG7HO5BHS/U3UL/mvvbw+BhQRaJ6YFs?=
 =?us-ascii?Q?HKwHMJg4JxYo5/S0zcnNq3Nknd7me3T51TNpKTnDxubuIzDvbfdY0b2U4HiT?=
 =?us-ascii?Q?ZFNil+k27rvLIiuoHF/q4sjFB463Ga2b7c4yhEp3yYZpuqvztiL6rLGXBDWL?=
 =?us-ascii?Q?MuF3k+j1+U1Qx+evxprDL2w9+MqMJXeTAOEZ4I9VZ9JVTGS+9Q9vVZuTnNrK?=
 =?us-ascii?Q?biC0w+lgFfS/eNLKGJMm7EAiY5mdKOQYIgxTr90EODW8DdFY7BC0NnZSboHF?=
 =?us-ascii?Q?yYmTAaOruHmZh4UINSmZtZT336IAc5d+26QBFHYV5OlfUs8XL0gIGAqd9yST?=
 =?us-ascii?Q?ql2Alx7f2lEYXCkZodeOhH2G4xCC3ySfLY0XpaQ8QjWQwNm8EUKhqBcB5U30?=
 =?us-ascii?Q?PO3GyMQNeTB2o6HOzvVKj0I2DXsCC0yMmVfh6fL7AlsHLc45UMpc1xLN/H7Y?=
 =?us-ascii?Q?1EMug2rRNsomatmMZyFw6JSUxWU13ZBxdSUfK/gzFNqolUBbu8BNQCOwjIfY?=
 =?us-ascii?Q?BgOBhQWevLSUsN/ydQ/GSht7tsmTTMTqcDl4NBoSGVknkBm+8SXEujneIIGF?=
 =?us-ascii?Q?AUsQOpmi8dLOsQEsP/T4h7ljM8HLiL99woI1JtReON5ZyGECXwwLe/CXFtZ1?=
 =?us-ascii?Q?SjXLaw303vC7NevcgcVRMS//4QTHspEaImspr6vi2ejSr7P05p6MpSqibsHD?=
 =?us-ascii?Q?0IY68IJ0JpKr+bvNYJtX/KEvYtb49g7bi/J+Bd1R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656cb60b-8e89-4730-022d-08dc478034d7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:18:35.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9LcUbjq4gAsbXpkMreIKJpEZ8ZAEZmJuOnewcX/LnZSUo4H2x71iQ6CqpcWQWUg8XZXiZuuvrth3SoMJREi3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10244

Convert fsl,audmix.txt to yaml to let dtb check tools check audmix part.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    dt_binding_check and DTB_CHECK passed.
    
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,audmix.yaml
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/sound/fsl,audmix.example.dts
      CHKDT   Documentation/devicetree/bindings/processed-schema.json
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      DTC_CHK Documentation/devicetree/bindings/sound/fsl,audmix.example.dtb

 .../devicetree/bindings/sound/fsl,audmix.txt  | 50 ------------
 .../devicetree/bindings/sound/fsl,audmix.yaml | 78 +++++++++++++++++++
 2 files changed, 78 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
deleted file mode 100644
index 840b7e0d6a631..0000000000000
--- a/Documentation/devicetree/bindings/sound/fsl,audmix.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-NXP Audio Mixer (AUDMIX).
-
-The Audio Mixer is a on-chip functional module that allows mixing of two
-audio streams into a single audio stream. Audio Mixer has two input serial
-audio interfaces. These are driven by two Synchronous Audio interface
-modules (SAI). Each input serial interface carries 8 audio channels in its
-frame in TDM manner. Mixer mixes audio samples of corresponding channels
-from two interfaces into a single sample. Before mixing, audio samples of
-two inputs can be attenuated based on configuration. The output of the
-Audio Mixer is also a serial audio interface. Like input interfaces it has
-the same TDM frame format. This output is used to drive the serial DAC TDM
-interface of audio codec and also sent to the external pins along with the
-receive path of normal audio SAI module for readback by the CPU.
-
-The output of Audio Mixer can be selected from any of the three streams
- - serial audio input 1
- - serial audio input 2
- - mixed audio
-
-Mixing operation is independent of audio sample rate but the two audio
-input streams must have same audio sample rate with same number of channels
-in TDM frame to be eligible for mixing.
-
-Device driver required properties:
-=================================
-  - compatible		: Compatible list, contains "fsl,imx8qm-audmix"
-
-  - reg			: Offset and length of the register set for the device.
-
-  - clocks		: Must contain an entry for each entry in clock-names.
-
-  - clock-names		: Must include the "ipg" for register access.
-
-  - power-domains	: Must contain the phandle to AUDMIX power domain node
-
-  - dais		: Must contain a list of phandles to AUDMIX connected
-			  DAIs. The current implementation requires two phandles
-			  to SAI interfaces to be provided, the first SAI in the
-			  list being used to route the AUDMIX output.
-
-Device driver configuration example:
-======================================
-  audmix: audmix@59840000 {
-    compatible = "fsl,imx8qm-audmix";
-    reg = <0x0 0x59840000 0x0 0x10000>;
-    clocks = <&clk IMX8QXP_AUD_AUDMIX_IPG>;
-    clock-names = "ipg";
-    power-domains = <&pd_audmix>;
-    dais = <&sai4>, <&sai5>;
-  };
diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.yaml b/Documentation/devicetree/bindings/sound/fsl,audmix.yaml
new file mode 100644
index 0000000000000..fc65b76ea35ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,audmix.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,audmix.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Audio Mixer (AUDMIX).
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  The Audio Mixer is a on-chip functional module that allows mixing of two
+  audio streams into a single audio stream. Audio Mixer has two input serial
+  audio interfaces. These are driven by two Synchronous Audio interface
+  modules (SAI). Each input serial interface carries 8 audio channels in its
+  frame in TDM manner. Mixer mixes audio samples of corresponding channels
+  from two interfaces into a single sample. Before mixing, audio samples of
+  two inputs can be attenuated based on configuration. The output of the
+  Audio Mixer is also a serial audio interface. Like input interfaces it has
+  the same TDM frame format. This output is used to drive the serial DAC TDM
+  interface of audio codec and also sent to the external pins along with the
+  receive path of normal audio SAI module for readback by the CPU.
+
+  The output of Audio Mixer can be selected from any of the three streams
+    - serial audio input 1
+    - serial audio input 2
+    - mixed audio
+
+  Mixing operation is independent of audio sample rate but the two audio
+  input streams must have same audio sample rate with same number of channels
+  in TDM frame to be eligible for mixing.
+
+properties:
+  compatible:
+    const: fsl,imx8qm-audmix
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ipg
+
+  power-domains:
+    maxItems: 1
+
+  dais:
+    description:
+      Must contain a list of phandles to AUDMIX connected
+      DAIs. The current implementation requires two phandles
+      to SAI interfaces to be provided, the first SAI in the
+      list being used to route the AUDMIX output.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - dais
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    audmix@59840000 {
+      compatible = "fsl,imx8qm-audmix";
+      reg = <0x59840000 0x10000>;
+      clocks = <&amix_lpcg 0>;
+      clock-names = "ipg";
+      power-domains = <&pd_audmix>;
+      dais = <&sai4>, <&sai5>;
+    };
-- 
2.34.1


