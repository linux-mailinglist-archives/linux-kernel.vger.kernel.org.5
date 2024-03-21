Return-Path: <linux-kernel+bounces-110197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07538885B62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA211C21E05
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991298664F;
	Thu, 21 Mar 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fLaVV0ah"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF7E8625F;
	Thu, 21 Mar 2024 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033475; cv=fail; b=RBD2XgDoi6L89nx2MNcxeHTyvPq3cWJ4xOpKxpW/2iW4QPqU9pQ4UKxtDOt+Ok4CD87HoOnKIoAVl8+/6+S095+njBBxtAYv0Fv1ZrWbFe4HFjsTAlHpWS+a2eebzLOJXDW4L3K3lze6hoXHDiCP2BvPdf18ntdtvEUJdtBap/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033475; c=relaxed/simple;
	bh=1zLFM1PbEs4P2h2NyGL2hlusKCOxxaFjzdHJT/cglsc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YoA1Y5Nx9C+DMkT/4ORN9kIuMA+ddaU3QY978mFAq01H97VdIR8Rw3rusWljM2vPQFxtIvSC1Ha/SQsq18IUG7Q/1l03L4wpuXMJ64SDHPqySx3HjuouR5wjIOJWGOBK3PM9ws8oFCQMV5fTGnJQtZCFRln3ViNwM7UtaniUxNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fLaVV0ah; arc=fail smtp.client-ip=40.107.15.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7/plrA34P9jLWJPiB2eMlxNElc+whmg9IpRVqIDFbvuq1NuRplbx9T40kfAW5ZG/wrTrfAAFqJjm0QDaVypZ/1XgIuIQ7t3kTSau8ckygoj8wb0f5AH9MmIb8GrihUkg5FHyiWIAymfQyCwihVxyHZE3zIwdjonAamIYTJF2mbhSvtart6Lr26zy8p7OCUlp1ajbPUunWOO3l05IhPHmj0DOP+PvWqkzf1VDF3PvNLsV/OGu5leSb9Akz+wZQDSI1xayAG951yAzAXGCTpqe8Zgr8rPyZZ1nn9Ci8BziqicglQmVGfjj9vPD4YZFHaCGPK9Nww6L5/yEKFJ9dgn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8GIHj5Vj+nxFYFGoXsUi9GsA8NxysTkUy6qq+4cSL0=;
 b=ZP87Y68UpujJYY7IwoI5aZf7iKkmkiUmUwhCu+wQptYjgFyzPZA8jXI3x14ea3Y7bDYCrhSRZCWYey28bsyQgK2cu7UnmS10laUM8xu7PoHDcOoN8pQYBK0eCJgUCX22oXmPuMHL+yUCFcN46hHIylYP5viMtItdqlyijNXLAHceg+G/fYGVyNYHUB79g4cV1joEqEkYjWkcLSRLVoOgKHKCswb5DXIt4w290QxVswoAPvSHts1mSy8o3bTYPSUDmSbCq7ORuPtKkGIA9pFMC3zhMvALwP6s6OTATQC32kSCLUfQb3sRcoaMzHfFgEfP4gti4KiA1RGwxyrq5FNotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8GIHj5Vj+nxFYFGoXsUi9GsA8NxysTkUy6qq+4cSL0=;
 b=fLaVV0ahG6WG7QscwXEk89k6iQ0uyohWJ1xbAURX1rh+QS55VStGKyJV/uupX3bG00j/KvLjUluwav00PP9XQ6Kshzt54hzYjqinNmCyT3PnVtSvxA6BOs33BqDu4AbILW6iwUx4DTaCIH9fWLC0MxEsKWqguzww/KOiHTHHIfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9880.eurprd04.prod.outlook.com (2603:10a6:150:119::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 15:04:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 15:04:28 +0000
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
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] ASoC: dt-bindings: fsl-audmix: Convert fsl,audmix.txt to yaml
Date: Thu, 21 Mar 2024 11:04:00 -0400
Message-Id: <20240321150401.2464783-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9880:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d33b5fd-e864-4c13-4b2b-08dc49b83443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nO6m6rIV8OT7LbYjk/+wbsACLGUJU91r0nCzd8tssxLVxpfRYuQWexbcXK6aMr+9R7IqfckkeGjC3uYYFpuNB79vXWCgcDgO5YjGbcziPfDjYPss5dwzHDsFVJYstxW2gibAYhegXG8rgYcMjHj2gDTkVMCe5DqsrtncZbChlbjIvhcVzgRcgu6ryIn9G1ckYAbuEOHp453wiv+iM7koFcypKqfTw+/WgfTTAKwMrH1QuRRAQqD+tLnKwY8Sk45WQAKe8W2zIof/nJlJr1VJupgIhnhPkaUz0M3ZsWLl3CWVHrfhdRtRpBUIC87fVZmJnuv022Vg9SMj0s70dqAjmGvDKF2n/W6054VmUJxjDnklpucVxN6T5qSVAm2Z/nbFk4VWweaCmzasJf/eqDucfFWO6B10e0CUBvbjgr8mb9MEnoWyXN0dZqdlVlqKZlo3OFlKUWmmXJ4M0rOwKacPeAfPA8wtjjGlztiNXz2ngJmwnlRVXxcKNqs7rxr9w+liNHXc/UOW5r9/UXjm3usV0Y3X3NH0Oyaobi62eR1xOimE97ipYJYae9ksS/vIaVssNUR3ZFY/MAG5SPhVndC1FtNTEEmh7h1tXxGtqhWyKhX/Z9vYVU3WScLBXzy5ydHbgEKHK6AmpHiuxy012CF5+g/h66tMD2oJEfhOmExkjwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7y1NFH5UgGs+A4n9QgELBJAmOUEhodS3S00EVtSBwRsmkI2k02p7jt77aDa8?=
 =?us-ascii?Q?xcLVjesudrG7CPQMaVSGiQ9/GoxYd/euTZLmn+a2TAYmTioAlWqUrLtKKoiW?=
 =?us-ascii?Q?ZhzlXJrKRySPquWrireUGnTHQ3Vw6RsQmsGznCwsCREPNYRzlHL/RGxzgbMB?=
 =?us-ascii?Q?xO3W27xJLzioFecSEFAVWvz7mE24lYxW69qQCF24hUqPucghjzXrAgdct/n2?=
 =?us-ascii?Q?qK1TPU6r66raU5+Hh+p0uC/IL5QcLhZs1vtYb5xKxjJiU4ijkKrTgGCXkb+4?=
 =?us-ascii?Q?MBnuuLhYHxkajPEcRaLa0QgLY2vSDqntG0MSu1eTkEQDLktS3vRMfJeUc52Y?=
 =?us-ascii?Q?1dU3x3DVjVmXFZBPwXajXisp1tvLkDjLkKoNEMh/ohlr2DDWyltNjDekZu00?=
 =?us-ascii?Q?IMci40W8sNl7KoIagLjfzm4Nivcy3jfuDRr9SmW/XgoXqXoODDy11B67Q6d+?=
 =?us-ascii?Q?M565R4urM4Q9akO/JvL90u/30ISiwOwZVuf71FqhKn2bFI8LoncbrIdDaoyf?=
 =?us-ascii?Q?V/DkEK5KsyRN/17W4ovsSYPIbSgzq0H0RtwKUVWep7GYpgxInGSFOnCR1Gn5?=
 =?us-ascii?Q?DnYjdZu/DAlvxtlbnc7b7/HLv6Ip1jntjy0H7ZRIFZgwVOCoKH1PM/fQ2hDr?=
 =?us-ascii?Q?iU2EWuG9MRvDLAtNTZx81wO39mXgwfZOCMU1jjlytHw+VRwz7rMFMfHEySh3?=
 =?us-ascii?Q?oB0d8Pb/WmKDNrXDEli0QlrQqWlE5qJPAhTx5/Dbegjzmth41njY0eKraEB3?=
 =?us-ascii?Q?6my458g58eNOqaw8OQYcDdSf4enpz1Zph0O7jHxsQ/1nMoL2WVlZHVmHe4TL?=
 =?us-ascii?Q?bmNSR37CNvuk/pqHny+NyS+7Rw/FRDXDBTb/tJ2PaOhJI04bP1uHfJG/R3cq?=
 =?us-ascii?Q?9Zim22vpz913oWChkuaxhah2XnIhXnBiy3Q4rQ5J/aNmwPN8uVYl4aY8FdnV?=
 =?us-ascii?Q?Yj5cZWDGOg71cytrwSa+yRXyqfOjO2/zpjsNrbR9LajhzrXZ20dPMIdgGViy?=
 =?us-ascii?Q?9tyTqXk5iV3fw9dWsLWQwUmWKsUz1g46NTb8L2wNbDD0MAD6g9FhfPrhZZlF?=
 =?us-ascii?Q?ygugUJ9Grvn7KJiOB3rP+WAhdjyhjUCz3m9NZHjytKGrXoDF4VkBGr2glsL+?=
 =?us-ascii?Q?YxaidlTVMTKN1wEZYonMai+dMX8XTSdOSQseKsJ2lRnZctp7gEETvZ75HwoK?=
 =?us-ascii?Q?pxgs5MQUWtwlGh2y59uQZeY2rDjn6zqHmrgGd5KOwMa5/IyAXS9HUrLNMND8?=
 =?us-ascii?Q?GfxH+svuCcLKQv01SHQW7V/asBbz5Q6Ge44D80UFSzBNSsnAylb3UsMSJGTg?=
 =?us-ascii?Q?0Ade/oO7pp8uyV/hWgVkZXVblJxltfPfCmetfuEEWoxChub6IODyA/2yHIiI?=
 =?us-ascii?Q?Eq3vBYEox2fFa9bMWX/E9DhXtgEJm9k6BSiV0ctphdWBFtf/JaXJ1LgiwsQC?=
 =?us-ascii?Q?ttjdYlNp2cYCvQcH7/PjTl1wTi66rs4icqjlf2mWB+00tr8lGPxGpEL8CxeA?=
 =?us-ascii?Q?7ZS6Q3MWN28nnNgrNVsPj5GtL+bV78ijkBpmO6Ss1eRWLboJ1WZciu0hwfNp?=
 =?us-ascii?Q?ItG33LB9IEuwNcBqT8Z+5hannXah9wNOzKMunPdL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d33b5fd-e864-4c13-4b2b-08dc49b83443
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 15:04:28.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/U/QDhmCOGfpd1QrApizzsGoEe5iEYGFrjzqIjjgKBa1Zu7fsisvq6Tqhf6f/BbUMESh9EwlFAkxOBjuNuETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9880

Convert fsl,audmix.txt to yaml to let dtb check tools check audmix part.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - Add | at descript
    - Add phandle-array according to rob's feedback
    
    $ref: /schemas/types.yaml#/definitions/phandle-array
    minItems: 2
    items:
     - description: the AUDMIX output
       maxItems: 1
     - description: serial audio input 1
       maxItems: 1
     - description: serial audio input 2
       maxItems: 1
    
    dt_binding_check and DTB_CHECK passed.
    
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,audmix.yaml
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/sound/fsl,audmix.example.dts
      CHKDT   Documentation/devicetree/bindings/processed-schema.json
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      DTC_CHK Documentation/devicetree/bindings/sound/fsl,audmix.example.dtb

 .../devicetree/bindings/sound/fsl,audmix.txt  | 50 -----------
 .../devicetree/bindings/sound/fsl,audmix.yaml | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 50 deletions(-)
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
index 0000000000000..9413b901cf778
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,audmix.yaml
@@ -0,0 +1,83 @@
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
+description: |
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
+    description: contain a list of phandles to AUDMIX connected DAIs.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 2
+    items:
+      - description: the AUDMIX output
+        maxItems: 1
+      - description: serial audio input 1
+        maxItems: 1
+      - description: serial audio input 2
+        maxItems: 1
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


