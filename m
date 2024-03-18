Return-Path: <linux-kernel+bounces-106538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4909287F015
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0125B2839A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225FB5676D;
	Mon, 18 Mar 2024 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IZPY9GQ+"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2051.outbound.protection.outlook.com [40.107.241.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D205646B;
	Mon, 18 Mar 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788454; cv=fail; b=QJ5Nol51Lk8EzuMRW4UCxRe0qEnJYYOoRuTWBnneNy/xERuoK6wmq7YnBnEbEe19xOpr8z39Ln6mD9X1xs7tzrkqejRrdprI3A62dEt2scEtd5nYASFIKsCBgdbKC9XLo9G2YfWlA5K62js94T1HufFaRVL28Y5glmzAT98+Ryc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788454; c=relaxed/simple;
	bh=1syz/aUeJNCMRuMdqZfLAmwttcSh8oLFScKSrTznruE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bkv5fv7JepZ76Hw4rmxN0NAtShnRbnJE3YflV0SDiYJbstwieucjcwYKlZM03aSoffuN+sM/W7o6HDN4T51w130rbk0bJQTJsrV1US3t58vXx+CScLAAHxNTliEGR9p4V7IEccq/Uncas1emkhY3KUuwjN1/dmODKkMmpveix5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IZPY9GQ+; arc=fail smtp.client-ip=40.107.241.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TivXBqXBA6v+Q/GexWClbYJJlKjLHamfxkfzCZUuxTfyg2YSVD3jg8QW9rHQ1seODi4vrpoDwu89U5CrdWOeWZJLguJS5DtLxEa8ciofZjXHPcft9qgF+UBNxW8OGxLnTk43/gTYzOHGSt+bd5Tp7338cOZezh6jSio8Syb1W12syXK+lSLjmVdQA6Mcxh0VHGs33Nyj+AA3CsP2FzucZBPOgJLznR1zuDgCZIPb1QmD1qFvbcQh+fRWl2eVY0eCJ2bqVghPqYztShiT9wRV6dA3E6XzdjdLNaipOucC2c5jeWaenOhi8yBeUIiO3/MDLloU3BjTZtIjH8GXKUZe6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+87M1nJCCt3nFThf9vTFK1j4y9JjuhQ/XCHl3Fycsc=;
 b=SS3lD5EI1Kh8dt4zKC7l8cnryWaHIymYQh68bJpSjn66WBea8NMQriF2ydMOVbB3edAvRZBOmGzJVgwFHWQVb4YLGsBnUkzYTEEzFLCHCsKc0Ymh39LdpIMI1TXFhdu6JB5otMkuJVASb5PP1DkQGRt+Dk0Voo8kY0yTIoUTn7HL3rlrvWoTp/jf+nSoPQJ0mKEynM2YhIaftyquJ3cgIvSiB4UC8RxAcvVysGxFg+lc4mAdAY0t0jefcPIb6Bde60t6fi2tnKH6fYSaFjh3m6CuW1Srv7Fjx0gFkSjSp9h8miEi5ypEt0D5LRWi2O9dpsSGa8lBvJuRaC5m9Ox7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+87M1nJCCt3nFThf9vTFK1j4y9JjuhQ/XCHl3Fycsc=;
 b=IZPY9GQ+8zQNf5mweEuhBnStXGZ7Mfgiekmp1aOcc+ZIJNQiCMC2/lNaPfkzyQsMkrmc93jc1JRqZeIgQ5hJ/cUdrgBAxQp//LzzzD9kY7JNXaWCOv1TF1yCl6p5It9T1Or2OFmgsNog6iJHkZVM6U3OuNSITMPO95Jb6ZgA3us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 19:00:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:00:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Mar 2024 15:00:07 -0400
Subject: [PATCH v7 1/4] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-asrc_8qxp-v7-1-01ce5264a761@nxp.com>
References: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
In-Reply-To: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
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
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710788441; l=2330;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1syz/aUeJNCMRuMdqZfLAmwttcSh8oLFScKSrTznruE=;
 b=jCSnKr6kYbYvLTkeujBreoC3V6MfuKLmbvIBCBUm9M0O8f9nOCXcY0Z9O/ipicIwWqza43Wqm
 rBdKOJfYtBbARcXP31RqBGJQTtBYLoQhGSZ0upGZarseAuTYTy63Y3H
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::31) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff5982f-2c56-4054-e6d7-08dc477db9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8i4jkdcsAfBuqRbkEJNAY8PSZuU2g5k1uKc3nSg6ZU/HtE//jyXtHFrxqQDqtPOAh42tOCBX+2pI2N2sqymdlvO8AJn6i5kuUI7Cc6ElxOh7hl7QUwv35rzt1ZnhGNog7LDRaJuzPllj1CFo90JoYUyFGXH/gHR6LLKBfGeEEUCGDeN5+rYyjVuM1lz0XMoMxN9LGYKJlJLra8SfkA28c7AHNlnWVKN2pl1h8KuP7q3j2/tpk3cPoHDCQP5s+5R5c36gFuMfSHswRS2va6SZRddG2IyTvhnMlOvaggPzgw+Q1myUSAHWxBIt0ErdWCtpxl9Bm0EmyHURsN8OdVV0VI273z6STUwHZ0It/y8dS0A2YsO1wQzQf0bGbJXKNuwatLlmraeQ+Kngq6Zvlv6z81YePX2KxgQjQsMkCyNm9SbfwGqdTEBehrpXeIRxTUvofScJ1w2SKwlUAfAe7qY1EPjjmbaJ+K5s25RS+Jr9Z5n69T6IqtIwRsGctL696+EVLiCq0uk3ykK+sX+bTzjQBPOkPlOatWZOuDhnDrMOxbbfVAYfceYyRKAeAcV9j3Ls0Oxyt//72bjAHGgcFIZO4//V7r5Ki8kIlD508AjXzGAm/zIq1Rz7xKIMYQk7CoVARFLKZoDiH1z06z26j6vViUOE1asPc8V/dV9VzjxwPEKo+V7pgf+brhJKaxPeYWigxyquvPIsedRsvT0aRGPiw4xCUORJ1YKY6sXdILfIXsM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHpZSDByM1RMdUNlSnFFaVlZUDdzTzRWa2V5Y0dvNVcvblJjeVJ6VEF5UERH?=
 =?utf-8?B?SFdiakRhNVJNTHEzcTVjcTZiejFmcDJpaVB4UFFML0txRk9VbHBWYVU2RjJB?=
 =?utf-8?B?NmwvYWNQNFF4dkUxb2pmNlBaNTF0Y3RWWUl0SUxoNDZMZ0pPNjNTSy92RmRw?=
 =?utf-8?B?NmRTSnZhMzhOVmtTVzdlSHBFV1U2K2VjaE1YRTJwL3ZpankxNkhLQ2pQK2gz?=
 =?utf-8?B?Y1gxOVRwSHlacytFUGgwRlBDY3RrNVUvTHd6bC9abnJhblRldzRndTBia1FX?=
 =?utf-8?B?MHozTVF6VFlsa2E3Wkp6RFN4NVdDeEVRSitlYlgrT1dtbGtHZER1d1g1VVJ3?=
 =?utf-8?B?OXZYZEZ4VXQxMEM5aUFYMlVEK3JRT1RQalR5YXBDc3laSmRzekZFMkN6WHNn?=
 =?utf-8?B?SHJFQ2l3UldUS29scWFHSFZMbWxkWkhYV0F6d1hYWXhyc2M2Q0w4Tmcxa003?=
 =?utf-8?B?eElrem14Uk5VMjV2NG9VMDhOcVZmeG9IOUNLSnJ3Tk9zdWVMVDFFWXRKcmFJ?=
 =?utf-8?B?cXBkVkVTOVRMWms5TENIcEM4eGI4ellLRFE4SUxXdGhzUm9SWHZIcnVhUzdR?=
 =?utf-8?B?dWFrYVdEM09UZENuY29sMzJpeTgwb1M5WW5waGVLMGtZNE12dTJvU3ArTlov?=
 =?utf-8?B?WFpJVGRhQnlFVUk2RkNzSXcyakFkT1pJZER0RHdNYVd2aVdqcXVmVDl4bjBk?=
 =?utf-8?B?R1l1cFFYUXBnVFVZeGxRNVhSQXRYOXNWWmRZUGZjaUFFZ0pLdldWT0NBRkJr?=
 =?utf-8?B?emNQWWxQczVWcm5KaWVEZlBZN0RpSW1wYlpKc25XWWZDc0lMdTlyU3A0Tk9S?=
 =?utf-8?B?WGl4eU8vaHFHdjlZSkhIQ1VVL2RvZ1Z6cWlzUE9LUzZBeUtTZDVQc0FpVWh6?=
 =?utf-8?B?czAvcW5OREVteFN2bXlVWE4zOVNhNEZCdmxpZlQxNWw4NVB1QXhtekVJNlNL?=
 =?utf-8?B?c2ZpazhLL2swbUhQT2hlaGx6QkJXcmNDMDdValZxUjRYYVZ6V1pyMDk4Tlln?=
 =?utf-8?B?d0dqaUM1MXc4eWFib1RjMk5VeUlKVHY5WlhwelNCYXNzUU44SUc0elRNd1Yw?=
 =?utf-8?B?djZjNG9XNzE4OEJta0w4a3hiVHFReUh1UUZHbTEwY0V1MzU1MThEb1N4VEtU?=
 =?utf-8?B?TjFuRTNqZWd5Y0IxM3BmbTd1c3Zib0JmMm92ME9KeUdNRkE5U0MzSWs0RTlY?=
 =?utf-8?B?Vmd4UjdFdFZrM2NDNTBRb1lVdERoOVlCQTNzYXZFYzNzQUhaWXZGbFFLWkdP?=
 =?utf-8?B?WTZzUUIwSDhTWEVzVVpTeWpCK0hWU2wzRmR1OGxEcEdPenMwQUtMcWpKT1N3?=
 =?utf-8?B?a1o3dGExaUVXS1NwSXJGOFl2ckFkZmowcTFtYndvTGRwT2JTeDV3SkRKYWIv?=
 =?utf-8?B?TVlFQVpqbDBPeU1NVVJGdVdSK3pRN3ZSNXpIUjdaQVM4NXFrTTJkeXVsZTFE?=
 =?utf-8?B?ZCsySmtWV2ZOZTF5VVZPR3dodDhtSklQa2VsUFIyQU5DRXJqSVpQTjNpbTZv?=
 =?utf-8?B?R2RWMCtjY0F0QVpmaXd2S25JZzE4M0lHSXdpTCt4OHVYTU0wekR5ZXRNY3BI?=
 =?utf-8?B?dEtpeWp2Zms4TTV6eFlBdHEzRDl5SUsrMEFGTDNVVHBwYm1zQUNVVGUvckdh?=
 =?utf-8?B?akNmVHVqb0Z3UGRUWFhURU5xYmU3WVc4cE84UXZyeUdTVWY1emMxRFUycnB0?=
 =?utf-8?B?RlluMFZTRmNydnZLTHVZcmExbG9SRWxITjJzT3VxcmtQV284WjRoL0g3RjRB?=
 =?utf-8?B?VTNITE5NeUNVS2JDT2N1bFliQ3JEVU12b2dpN1RmRFVRWDhvQTJGa2NqSWxw?=
 =?utf-8?B?RDkySmY3R1BtUkMzS0xFREx4ZHUxQmdLbHNsVmdFL1R2NmFIbmhVM0hCcTAv?=
 =?utf-8?B?Mm5ScU00b3QwaWlSSTd4aWk2dmpwNXFBN2JQMU5SbnMzY0s0OEdLanVzaXdO?=
 =?utf-8?B?aGlaYk1lcFBOYnVvdWc4V2RwV0xySkFjajh4aXAwUzQ4TW1RL1dXT1VhUXph?=
 =?utf-8?B?R1FNNnpseDhzcjZQTFZCU05uRWliVGdQWThEbDB6d2Y1VWs1cGlkdk9qYjc4?=
 =?utf-8?B?UlE4NytDb1VzTDU5YW1YU3FpZG5KL0tFZCt5L1FUdXcybFpySTU5eDU2eHFn?=
 =?utf-8?Q?FNHA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff5982f-2c56-4054-e6d7-08dc477db9bd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:00:49.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GW388ECMpL+uv7mulgW1Jf0x0H5UII3xPd/3KTOuSX8RKQVo190X4xk9GQdgnqsJahmpRGWuIAeXrHc6CvIzHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119

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


