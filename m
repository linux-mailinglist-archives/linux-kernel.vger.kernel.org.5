Return-Path: <linux-kernel+bounces-123109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC29890246
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DFB5B22F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99CD12F392;
	Thu, 28 Mar 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OGCYxWau"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942D68626D;
	Thu, 28 Mar 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637533; cv=fail; b=mkhqumcUk1VBx8wqNKyYPf9m2n/wr0hwHn8vZmyZTijlb7aPPswnvXJfE4nlwv9VryGje3ypQTgCkHjDpjUvUuxiLuUkeAH1gNpHKvasg8HGrZeOos4gcCNw+w5BEEHldnygLyfWu4s8acqzYsscxsYMUXaib8YZD65/4vi0D/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637533; c=relaxed/simple;
	bh=1syz/aUeJNCMRuMdqZfLAmwttcSh8oLFScKSrTznruE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TZ2pWQloH1kgIfVPd2DNz1Rz/JEcOVG3MlojMxRk/TOYRQrIaeEYw9vZj6MattrK0EC9fgNVZayjaFlUw1jPL+sC6MQnbtdXiIm8K45xYFmAoklBeAjZ2Z5Gqqpq+0TtXVHX1ey+RN+tYUX5qEgmzxMxpYlQ3lrwTeeQrVh8N40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OGCYxWau; arc=fail smtp.client-ip=40.107.7.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGJkAYHvEynnV3sHHp1szx9QOknstQCpQF1Gmja8HqKaHHkOhXumtC+5yY15dYOjl9qn5k/F8O7j1Oz3+QcP4WwyUn8jGERbdSUNn31mgHhIK3GKAH4kIE8dUlSTnzy0Csh+/JENCyBx5IBPOweP0hMeOutawURPpsJ3ugA+CfQDXHfG7FP9kv4VlEgnovgMz02NB1KTviCDUqBYM6POXg+OBozfLiPWx0ZY8yuedPhy7zzJ2cqqUI+a8Qfr1ZyxaU41umg7joYQN4vU/A/y+Mkfdtc1FFxwS1XYukH6mSo4xj70Lf9aHFieaK37DpTI0UdVhb2Qek0jcp4aQKO35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+87M1nJCCt3nFThf9vTFK1j4y9JjuhQ/XCHl3Fycsc=;
 b=nJRv3MxgI+8BLi5g0D3uOWM4wSxEGKdVJXAIwCSJz8NiuaXbRmWNYhYNb1tyrhM296mxfU8yUQUYd5oQX0I5veIVyjbMtktxi7j6T/qnbVqPGXi/DrZnMg7nSebTj4N+6TtNzIZxd5eeIw5msSOH4DPjvQTgQen2PGVqFOniZxE9NuQbp2FHFuTaoiChwi98v7if7fQjo1vk1IK2d9RKKrLIB/IhHidnBb0U3tGR8bWTj8jxEGhaSsMcyknFdJLSRK/jA3FpDOMIJoHJDSPfP9HA3LJaglZKhfDLEA9DGQL8biLTPHPgI/nzLbtD19Ufg4N+iP9MCkNrEoyZtV5Ijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+87M1nJCCt3nFThf9vTFK1j4y9JjuhQ/XCHl3Fycsc=;
 b=OGCYxWauxCfZGD1ncOJnx1BDgLvApjX3DQl3vYjqAUb+Z3a2HSSWVALnz5rjbYxOJ4qFaQF/o4Po80p3dro8V5cVgjTm/k7G6bK6hWeNQ+sVYGWOQmGk/axkpTMfggJSfrsY1XHf39TyS8ETNfB5w1tpeQzSh4KYSHnaVp+GBxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 14:52:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 14:52:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 28 Mar 2024 10:51:33 -0400
Subject: [PATCH v8 1/5] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-asrc_8qxp-v8-1-801cd6bb5be2@nxp.com>
References: <20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com>
In-Reply-To: <20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711637518; l=2330;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1syz/aUeJNCMRuMdqZfLAmwttcSh8oLFScKSrTznruE=;
 b=wBTzCPY9EsFE47/fc3zDX+LAyqVqegaso1VroFc0+c5Zsdi2yGYofjfC7uTmaon6AAK4z6+FW
 6whJ7OeiSTyBLzh6pOFUydgU+nuplUrD1J4Vpq5n7vfEwTUKEkA3EYZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebe12f6-cf34-453a-1ce0-08dc4f36a343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AGE9f86TcDV5WY9qzedqRk4hcza/98aGaVHngnnC86QkosK9/40S1MmIHVfzFTfBoYj8eIzRWqxMI3v0wr+TWFFRkSA2eOzafPPSuJNk+vBVmEOsCAUQJ3KRhx06Ci8jz7Mqr1Q4ROy4MKlmVnMYD/OkYjj6wWWZtg2qeMtgruYquXeequa9I92aZdGTVOnJT3db0BAF2kd9bqawPrtWxCbi6y41dDzbzDDswfpEMvYMKsVJdOcNlB/SNKp/MpexiFN6N82ThgF5htKtI4Gy1qweUFn12sVbJ0dqBKSkP/jrq2K3XaFFnFrurhjs+CcMsHc+LKtRUgDPVtqmpBCHKclSfC1z6WAhGpPDBsr52QmiyoIQ1+v+BP9bA0cFdz+ezk3/3iV/bCc4Qf2qGFRdjru8Z0YCFdt0uPOfzPCCq0FD0ddcL01frK45jTc0Y9dTJiwbk8EoBXRP3BrKIwubo94hY0hwx3qx2knFWH3Q6UwKgeuXTZtsefF+2kNg/Ml8lcRt+T0cnKZT0YZaQuGBoKMdte59Uf+W/Ln0m1fQns+a3EZ1e+he6r0bFvZsOepAJeX2EK6vdXRzFm3wnNXm/LVWqfIePMm23JU8ARchCdKNqBhdOISfIDYj6fiJvNe2TZQ8ZfqiHg/BGfiFN3lnk/Ojm+J8E0/YaAvbWwJiN0RKf9fM8Ucj08aB+bsFW2Y5/RN4vqlzbVNn1aZk0fWaWQy8WEnzrHaW8kVE+4flc5k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ui9KK3NzbmVVQ04yYjAyWFkrTDN4MFZNS0pCdUY2RnVqVG5ZM2JMQ1Fzc0RB?=
 =?utf-8?B?TnZENVAydDMyS05naW9yemUwNmwwdXdicEJRTUdjSDRMTEJZWFpKZ3RGRDlP?=
 =?utf-8?B?MFZUbk4wYm8wUHcwTml5ODVwbXBoWGZxUE51M0gwU0NlQkVlSll0cmo5Z2NP?=
 =?utf-8?B?UmdrSTdFVjN1RnU2elJUT011MitZaUxSYW1pazN4cUZ4SHpTck9TS0RsbWw1?=
 =?utf-8?B?MW03eVhWRHNTV0RUSC9OSGdwRGgzcjlzSzVDL0lwaFJLR2R3MGV1dkpJRHpP?=
 =?utf-8?B?SkFPakphSklFN0FTdTdHc1NZbGVwMU5GM1BrdkttN0lFWkhTaEk5WUg3WjR5?=
 =?utf-8?B?b2Z6Zzh6TEp2blVLdkdRUFppbTJvOUw0dThVb01sRHNEaTRhL3VkMEhZQzFl?=
 =?utf-8?B?VkN4ZU5OOXdDZWtuZWpoQ1pGQ1RQN1pJSmxUcmVPUi9GSHBiOUQ3SFVqMTJj?=
 =?utf-8?B?bVBWNkEwbHBWVUtQTmhQMXVTeWFnQTJtVFEwNXdtREMyWEEvamt6QW9qNVht?=
 =?utf-8?B?SkdSeTZsbUZYZzF3d0xITFBXc3N2N0dpbFpkOTJXSVFtRGVWdEZQM2VrZlQr?=
 =?utf-8?B?RFJHVWkyRzFRNzN4OXlpNld6N3lRQkNJRWJaalFKeDBvVGZoZkRadUpyTVFi?=
 =?utf-8?B?OFg2SWttRCtUTlNMTE5yNlBLWXgwcVRXNUFGR3NvenBDRG5JVkNwQUJVcTIz?=
 =?utf-8?B?Y2pqZGdtQms5WW5mSmt5RlN1RFR5Z0FUdWhaWXg2Zk8vb2NjdVU2c0ZCeEtl?=
 =?utf-8?B?ZnVMNzBwN0tqWmlDZHo2ZENNbjcxUlp3UERuOTJrKzlYSDBTa0w0SSs4NGV1?=
 =?utf-8?B?UW5PY01rdEtwRGllc2YwRFBwZThjZEdlNzFvTStTRHlPTGNvUkNqTHdnOXlz?=
 =?utf-8?B?anJLek5MZ3N0V1FaYXZ4b0ZNd0J5VVp5ZVA1emtyRklWQWFJUFM4R3cyaGI1?=
 =?utf-8?B?RjlMc01IYnIrNitHeTlkLzVhdWVCZ2FuNUZ6M2xFK0JTeHZ1eFo4NHFPbFdM?=
 =?utf-8?B?K2tzSFB3VG45dERwdjhnUDNOZXUzMUxUa1MycTZoWExtMUpmMFgvWUNSWWlE?=
 =?utf-8?B?cjF2TkxDeE10SUNvc2tGdW9OS0szVTBOZ081QTVtQ2dHYnBFY0ZNVi9UQzAz?=
 =?utf-8?B?dlo0OHVQZEtVVHZmR3RtWVZRTHc3UFFEeElweE84R3JpYUVFVzFKeFIvMUJE?=
 =?utf-8?B?M3VWZnVyUzNpY3dHYjk1Vi9ISWdHUWdMdm1uVE45OGtBSVRDTEtTSFhETTlv?=
 =?utf-8?B?ZzV2UENCRStYOGZ2azZ1L0ZlSERNMGZIbDkvWWduV05ib1llK1hiVVJBKzlF?=
 =?utf-8?B?UDdZT1JldlB4WVYvR21lbWJLdG1CUklPcXAwejRKZExRY3Fjb3dCMGJnTG54?=
 =?utf-8?B?WXpIa3FSbUNhMzdxaTdoa0tRcDhZQWEreVcwdEduMzVITWZReVZQSVdXWWZy?=
 =?utf-8?B?c0N1eUhVRE1abkl6U0hMRlRxQlEzajFvbHB5Nmg3VnpNbTRjUll4U2kyeFNn?=
 =?utf-8?B?bFZVRlRaemtoalNuTjJobWJjY1RXZnVnTFFjSHN4VUxzWEJIMHRhWU5qRS9C?=
 =?utf-8?B?TDFZOXdsSGI2UGVnblh2R1FVcENhanJNdkphM1ZxN2JMcjFnRi9QSTIzSUVl?=
 =?utf-8?B?d2s4VUF2dFZ3ejhBek9IVjZyaXg3REt3aFlPekF1R3NadkZKNHByWmNsYUsv?=
 =?utf-8?B?b0R0b0VVbjU2UGdkcnIvNUlFUGh3azhKQWZaU00vK25lcjZNWi9OdUZEenBK?=
 =?utf-8?B?QnNIcS9QdE8yTU9McVVvbHo0TURMaGkwdVUyYjdCV1Z1c0xDL2dMMVlVMm5l?=
 =?utf-8?B?SGo0dlhxMzJnSzRXL1pFUERlY2F4bnhQQjNVOFQ2TjdVTjR6bmpkSXRYbGxF?=
 =?utf-8?B?WkRPTWhiNFRaa2lVRTZLN1NjV2J3V2JTeUFpS1NkYmVtbUFOVC9VbTBaNlpJ?=
 =?utf-8?B?TmhhZzhWMXR2eXlFTjNzeGsrY1cvQjVOMkFsL1FxYU82WDNhblU1WnpLSS9t?=
 =?utf-8?B?S0RvS1M3d3NBaVBoNVY3TDluZEkrRzhGeDZUb1MxWFZOMmxvaUt4c1QxVXU3?=
 =?utf-8?B?YnVKQ1MzdHFiSEU4MzEvTTRielhhdUg5OVdNb2I3blRXRFFtVWNpaW10eU1X?=
 =?utf-8?Q?I3GVFB9XsKt+SYQmQ4uaZJGxU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebe12f6-cf34-453a-1ce0-08dc4f36a343
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:52:06.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Acdp5POrWKiYKnTYj0+1S6ym1vEL3qXB41vEnb3kcxhYgMsWqEcQpQwMqJbnkBDQ8wCXGjWn843i4ZTtU4TASA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

Add power-domains property for asrc and spdif since fsl,imx8qm-asrc/spdif
and fsl,imx8qxp-asrc/spdif require 'power-domains'.

Set 'power-domains' as required property for compatible string
fsl,imx8qm-asrc/spdif and fsl,imx8qxp-asrc/spdif.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml | 14 ++++++++++++++
 Documentation/devicetree/bindings/sound/fsl,spdif.yaml    | 15 +++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index bfef2fcb75b14..76aa1f2484883 100644
--- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
@@ -74,6 +74,9 @@ properties:
       - const: asrck_f
       - const: spba
 
+  power-domains:
+    maxItems: 1
+
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: The mutual sample rate used by DPCM Back Ends
@@ -131,6 +134,17 @@ allOf:
       properties:
         fsl,asrc-clk-map: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-asrc
+              - fsl,imx8qxp-asrc
+    then:
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 1d64e8337aa4b..56f8c0c8afdea 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -86,6 +86,9 @@ properties:
       registers. Set this flag for HCDs with big endian descriptors and big
       endian registers.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -97,6 +100,18 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-spdif
+              - fsl,imx8qxp-spdif
+    then:
+      required:
+        - power-domains
+
 examples:
   - |
     spdif@2004000 {

-- 
2.34.1


