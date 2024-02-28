Return-Path: <linux-kernel+bounces-85577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D9886B7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172EA289B56
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9930474433;
	Wed, 28 Feb 2024 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AjPl4fq5"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9074411;
	Wed, 28 Feb 2024 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147677; cv=fail; b=rB4yz2ycmF/KRmOoqeIJ9Hzk95mo/S0goIBUecCPsoVP+3mzqkU37+iq8iV8tbEqJs/qgY8dGiFSSqA1DO3+h+mEsChhIQEqRLVjrxcNVWp6Vf+9rrGdCFphlQBoCun2FJCaZFCfOFLU8/E58335fYJIRw9FwWUNsaTnq/JcY3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147677; c=relaxed/simple;
	bh=s4HI8Ojwzn52qIyPEPjb/4Z6X7sx1GRcAmXZBXZtRgk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gjmwG57RPxYJ9fpfLI1Dt1Ow1nPzOY+H/PbSdesjejRgKyh7xgGCM9ZWus0xBEkf6Qo6BiUvwH+w1dLLycmO7btG9lsSpYmE2Kg+ZwIXpFxc1TAs4ckNsnerJh9VWGbLiiIZI9puRvfEIt6H9V16DKq2Eba9NKw5oLdw+X0H08U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AjPl4fq5; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/pySiuppTrLTrAavgQgYRioGVNQh4PiHZJFFRpSPC84aVaQiY793lL6rwXQ/kLeDTCnv27E+0o6gfPppCpsm8DSb75DfnbM4JRdo06iOuYRjls+Ri4jHP8bwDkb5FjpSO4HG12XIsztkvQG4idMMty4RmcBlIc2h/PmjTi2rkNvla905aKYgaN5imNvvrnxzITedYbUv2JHh58IK8pbUXRk7YjhRSZ2A9h54T9JkHZiMhvB5/TBg5dvCILfvpTPJP1pqU6cWs1EKTtsWbxHF/IIXWpTYFIvfNdjp8T8KtTKozJ7hwm5xaC02jlCxN7wDW+W3rCs48BZavKob6Lm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR4Ijr6u0JBCrc65UMDTrB7v8I/4+cDx6GnC09iiTMA=;
 b=k7bVS8KDA5QFt4JjAul5hfhhu+U3svJPuQGpLEwxERYhhmrUI3CQ3EAKPN3rKznit8qbzzSEft9B9XTbvdeQCVocuUk04UCV72Q7Rx30eCvNtgnn1bKI1G8oHzDsnaFEhdx13rUptKU6mDHBg8wZvisi3/WI4wstCCTigs1792EQbYODBkYoLsOrh61AK3eyiAdDLaWxtpfDQwF4EQaE1ltcueqZHzb3VqE5Qld42Xz0twmBbRnRAV+8JWpBFXfdmDFhgKPy8uqKhqJScWrFfamGhEZUMeiRe4SHPCFngSY6UyTxjvwZpvRCsq1fLMo8ZB5D2JBpYq3QBQW9Mg5LgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR4Ijr6u0JBCrc65UMDTrB7v8I/4+cDx6GnC09iiTMA=;
 b=AjPl4fq5Zac9GILEfIbLsE5lfO6o1bN3i4tKTxvujSjGecjVo2IOiiXpG0s0Wqni0BSzc5urkuQL5l1bwQd9CG90/Ow4CmM1zRCdcfRdAaTxJNULzfbPawMOKVoXmIIEQhXtXpXsZWUU8qUwjZS5GMNQzM6OOFhQxVidACEpIQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9835.eurprd04.prod.outlook.com (2603:10a6:800:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 19:14:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:14:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Feb 2024 14:14:13 -0500
Subject: [PATCH v3 1/4] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains requirement
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-asrc_8qxp-v3-1-d4d5935fd3aa@nxp.com>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
In-Reply-To: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709147666; l=1359;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=s4HI8Ojwzn52qIyPEPjb/4Z6X7sx1GRcAmXZBXZtRgk=;
 b=GYCgL40uj1CwSvYJK7g2E2IUgCH/9ufTJWXOWGuI/bcg2LUOOTfWNRl+9qa4nXUbwlGXz+N0K
 OKwerUNLoV6BXsBnpMgSDzKybhJD1rdIiavxKhsWOozJf8tXIHz++ny
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e67fd5-234c-4442-5833-08dc38917f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ky6C3N4kD9ynb5wyeNmiMXpTGHB40/W27NwCHZGBqEWTnORe30BO0d8oALMpcyhK8OH4R8uG+v9xQlCTGzf21V9gvZUY/GNVd9aRvBK1YdRvGq3S7Qq3f3MNvyBGUshCNQca71zCjBhSnZeu3J8fg+ytTK77O6F2mBT5RMjLrDWCwaByONHtTA49V8zstPKuiaVn3J9O+O9X1xkiqPkfbQsvQ+qUau7Tt7nzzF8e5Yk1xeGd1HnZdHmGwjvGBcpZOxOgK9cH7GXJLBr3owTSQLydL3cYf8dODE1MViX3kVTCxuYf59o0v2AMnSEIHikevyf8q9P82BgYwwOm9Oc5f8Z7vgCIS8Vst/rTkGThKud5VRminwpahE2GqRQ07ML9O0nH2iPR33xeRq7jbiyW2syaF+ftdvOSk9jkhbKVN03wyz0AWlDFtjXZ0e5/Ebi9V2J0gTxhzDivCyxaOEriPk/yB82Xv7L5frJgtShyfmsihqbVsLTrsN7yVS5q1Ko6q0zy6KFBcE2jyPlJ9UX6JcMy/tCuqXbLQmDqwdjCLrnxlJGuBR5TxwU/xZuJVLoQIUFJ/D7Z5nP1KezLkIC2FSBQ/UNzRnWaJDZcPmd8UBy8db/eJ0liUP6AzwLD7wjfub57YHhXaYS31oSrm5vJcgTo8Bc4vjb6+j0GVrDiRWnhnJu7PhTDu63L55puuNYlP2KbTYi/TkqLoRW2dd0OSzrE2IFjHzkJJZQPuLBA8yU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmoxcmkycFpOWmlOU0VuQnJTdS9MVHhUclhBYzFMcDcrT0FEdVZRYXBFcTNB?=
 =?utf-8?B?V1dWK1FTaEVFWStOWjJGWFloVXVNdk11TUlKWHVMYldXbXoxa0hkdUpuM1ZY?=
 =?utf-8?B?c01MYm5nR09sNDR2VUROZnNIN1l5TDdzbnNQelNEWTdJbU1Ob3lwNDhJSTgr?=
 =?utf-8?B?WFZTR0dldGo3cXc5eEhpYVo2VlN4QXM4bWEwSnU1OTgyZkN3NnhrdWN3SjJ0?=
 =?utf-8?B?QjFpdkNkUk02YjNURTRjZU40ZUpwaXBUOXpoOVZsaVlIcnVRNGlBTFFCcFo3?=
 =?utf-8?B?NC9rb1krYWdOSEVWUFNYdFFKbTdnbFB5bnpYbEhNdGt2M29Fdm1GNkRNRDdn?=
 =?utf-8?B?ZjFyUTA4Z0ExNXpjdUdJV1o5TEkwMjlhQVlpUXlTZFVwMXhHejR2OFYwRnpW?=
 =?utf-8?B?dFN2MllpdWp2RExxRGVQNW1sZGhxOUlwbTg4VkQxeUZDRmpKcnBJeWppY3p5?=
 =?utf-8?B?R2M5MDArQ0JsSE9acmgySW9UMUw0NE9SOVJ1bXlUdFlUU3JSOFZwSjZzMmJO?=
 =?utf-8?B?OG5odzhaQXVBL1MxYm9yRElLVEx1L2dJUDdVY0tubDZCUkw4NkdCWmdXWVEw?=
 =?utf-8?B?cVZlaXZQRThLQkM0YmQvTlZHSHpkQm5KZE5OZ2pzb2dBTGtqY2xzdDVrajdW?=
 =?utf-8?B?WWZQdXN5WktqeE9oS1g1S25PQmZNQktadVAvNkk5NjBZanBmbnRENEdxcUhF?=
 =?utf-8?B?b3N2R1BsYjdmYkJEVWc0NGV5bTcxeWJUYmVBVm8yWGVtSDRuc0sxb3BzeHBq?=
 =?utf-8?B?aHd5MkcyM2ZNSk04UHNqNjdiRlluWnZXN25ldjMwSWduVlFRcEtaang2ZnBI?=
 =?utf-8?B?c0VyRlZQbW56Yk94L1Via2Z6bkt6UjlyaWhpTFltTXpyaHJqVFY5RFhMMEVG?=
 =?utf-8?B?OFY2T1hiY3N2Y2xhcVV2VlFRaGZIREJvR2ZMY1hyVjVZdEZkQWFvaVpUNzRL?=
 =?utf-8?B?YWFnMDE4dW1KUXc5bjVuU0dUd01mZVZ2MUtiejVxdE1zZ3hTY0ZKSmhIdGNy?=
 =?utf-8?B?djBDUGIvejZXV3ltcVE1aXd6OVVHU0pBNG1FQk92MzRvT3Y0c0tvNlFtVFdi?=
 =?utf-8?B?OGNZS3pCdE9xd2FMMlZ4OVJhVG42amhud2FNcWFJU2hvR3hsR3hXQlhrSFZw?=
 =?utf-8?B?bkNYZVhlcVVQUnloa1JqcmlZcmRGZ3JDOXFXRUsySWQ5MHNtTGNobGE1SS9N?=
 =?utf-8?B?Vk1sZENvdDcrUWNKZEhIY2hwTGhvTFkxcjZ2VHpvK0JyK2ZzL1lWSTE0ejN4?=
 =?utf-8?B?VHJqVzYxR3I4c3F3Y0twbExBWE53WEVDM0xZZjRVNU1GUkw0R1g2c0xHT01L?=
 =?utf-8?B?aHJFa0krY3VianArODdXMEpwaVU2VndoSzBGb1lzSlpSZlRaVThPN0pseTMy?=
 =?utf-8?B?Wm12OE01QS9kQmZmd0o1dTM1NW9pK2xubVN3MkE0bWxaMzREWmJpTVBXQmY5?=
 =?utf-8?B?NmJYOHg3TXJvbXJJTVFIeGJEdEVHYVNCV2NCcU5RT05mZnFyM2I2T2lrZDZp?=
 =?utf-8?B?dHBObG1DUlVtT1JvR091MERSc2F0aEk0R2gwYjM2V3dnVHJBaE5qL3RjKyt4?=
 =?utf-8?B?eVVBN2drRE9wWnpXdXJNYU05ZkdyY2dkMFFocXRWd1I5cDl6QTRFUXNzTkFP?=
 =?utf-8?B?dGdYamtxYnJMT080a3diWGt6S3hkcWNTaFV2ZlNRSU9rbG1zM0ROK1pidFBH?=
 =?utf-8?B?TFZmMkduQ0ROcnFXdldycVZmVXRnM21jVVg4K2ZZYUhkY3pscS94Zk5LN0di?=
 =?utf-8?B?R2lpdjNCRTJnOHJxRzlaeXhiUzA1aW8zaXpOTkdCSU03WkVQb2xNTHJBUDBV?=
 =?utf-8?B?bnVld2x1ZmhTWHRjbjhMZk44aWFxaUUva2R2T1hJOFVMWmt2SXl0bG5QaDM3?=
 =?utf-8?B?VVJtUUdRZkgxUFI5dm9IN0dHNk1JV2NLRURpN0x1Skp6K2pyZHBqV2E1MzFm?=
 =?utf-8?B?aDZXVVNmZkUyYlBBd3d2djlRU040L3VvajR3K2haVCtWVXYvemRwZDZmMGha?=
 =?utf-8?B?bnZuZHJ0eFBOVFQvWGJDMWtPUm9vaXk0c29JK2IvM3JsREZNM0g5TFMyYldj?=
 =?utf-8?B?WWN0cFFpV2M5Qy82bVkzVk8wUXdQWktwTmI3TEZyYkQvd3lKTXVHbTdPamtl?=
 =?utf-8?Q?SW7POg4ZEgI0F7tP2N+ODGGKj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e67fd5-234c-4442-5833-08dc38917f8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:14:34.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2C03umF7pW0SAL9M+B53XGKdfaJu4z7N+dH7iHMsDiI5bB/gk/tJ0xyYmJii4J/mgulYChFit4+mOXBekBx2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9835

Add power-domains property for asrc and spdif.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml | 3 +++
 Documentation/devicetree/bindings/sound/fsl,spdif.yaml    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index bfef2fcb75b14..98616507e3c10 100644
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
diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 1d64e8337aa4b..82430f1d5e5a2 100644
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

-- 
2.34.1


