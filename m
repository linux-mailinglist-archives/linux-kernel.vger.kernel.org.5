Return-Path: <linux-kernel+bounces-147060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ACE8A6EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C531F21568
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F3E130E4E;
	Tue, 16 Apr 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dLm+TqGd"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BBF130ACD;
	Tue, 16 Apr 2024 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278911; cv=fail; b=XW41514Nxw0BPM5D0aMLdBOPaLsil6Ab0MfA2yAXQlhvl2l4mMWy7G/TIacyrZbHW6X75Inl6Ao4BPb+TS7R8JCskprKn6Na851nexHRinVtG/BPUJxnOrfdgFNsZmPqYmQxnZA9lc56RMdXNZOhi+Hja1KOgPUrhCrnmm6DXSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278911; c=relaxed/simple;
	bh=9USMoIaTPLoVV6P4zkfQ689SqYesEU1SR1dFWTanOAM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sco05z8damO/sA4hsW99GkRfql7MoMk/2qnIr4CAfTLZHSpkktxe0uKJImtPi5S71S5kXYRaOEgCpBN6HBbX9lm/Yoz2cCEMO2Uh5HhmCx39apZ8SZ8K8wUuLeiNsuhpG8hFzvWAUe0uaWnjSuNDKvmxO/ljjfydhxvRDgv8Mck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dLm+TqGd; arc=fail smtp.client-ip=40.107.8.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llykNozD9i5nCaS8QtO3pgZm7iDtYc1dYpYikOuhp8BT+0ic3XBp7IOBiqD2ug2h0P0Isy7TjouMdmiKk8zfo6kCSlyTafaZaZy8+1EoQ5uW+sxgV+0FkwlgrVP1z3HtZ8rJkDqmnK2WNElmLmqZyvkG1uftmxDBHF2+ZMs/0wRT5cDJCzoPhwlL9nR4kiSkpylPEzkKNs75z7r5tzTz/15gFAzPRfdwy1CzjJrXutlDL8hzJx70nQomAaV+CQ6nVNU0jWDv5LJVkNfObTdWrGsXWJCTKK2WjfY7YNECaDUx1ZJOwqJ1pqOid0rYIwMvahmBZEqsH1KBe6m8wMfZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2INUclF1YnhXt20NRMV1OkiBAKSpTWTc+rr+1C+LeI=;
 b=WUX/X9hkkSpPEvuRPW9PpDQ7DQm0djv2WiZaUFPzxA9F3LxrjgL1ETrvGW+RDl+vCLe7jxN2URrDlwykqmJA9sLD8JrzG5cELiBOELnXPC5jJFYFLH6eil89zPGupaFew+Q3lzgLPHZr8lNLUakibgEYx9NsH1yVBnq4GQLXI6FMHfnwdcPv/sr7pvp9RBlcItG0GDDgF084ux9YSyzqySii+wWuJhfY5ltwnAOu9Usv4qdz66aTVYLakLMCQZmea9ggaIflQ32lVYN4gUbL+ZvxxX+kWCsHHf8Wn5QtKNSRsWHxLB7T44sCE/Ax6Jy4va5rhdHjwxTZZ8HDiuehTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2INUclF1YnhXt20NRMV1OkiBAKSpTWTc+rr+1C+LeI=;
 b=dLm+TqGdu7G6KMYxUe9W1AyR1/kUHCTl6ynCKiSijNPnzDRutRklXazcd3tsb5MRetAc0oJZGTpqcDl3uQTS0SX53YJTEKtK7UfdG28jkRfMRZsgh5aky6AD3g3xnM+QG6E+v7cAvE5gz+Eaz0WMN8XGgyg3gxYPf/QQ4iC+nDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:48:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:48:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 16 Apr 2024 10:47:48 -0400
Subject: [PATCH v2 2/4] ASoC: dt-bindings: fsl-esai: Add ref:
 dai-common.yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-esai_arm_dts_warning-v2-2-879e59c0c3b8@nxp.com>
References: <20240416-esai_arm_dts_warning-v2-0-879e59c0c3b8@nxp.com>
In-Reply-To: <20240416-esai_arm_dts_warning-v2-0-879e59c0c3b8@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713278896; l=832;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9USMoIaTPLoVV6P4zkfQ689SqYesEU1SR1dFWTanOAM=;
 b=1AERr4SE7+coz86/SGYClnsCeiFzQcCQ+b/VTt6gTJY85V77ru5ADuOfO+9zfT94h53TiuMlp
 lIEOlBhgEEoCXMzQBo0xsHU7XwEvoyH1U6cldQ1RUkvl5DMXIF6z6eH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 819bdb50-7069-495e-fa7e-08dc5e244670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d9OjXwEpwAcMXdV33CkCfnsteCff7WsXHdAY8Tl5dWMbdm6D3Ye2OPHm3kExbtCW/tlVaqgn4rkleNePI7ZhcPYYwMhRuITJKQXoefgNSy+5seCKD/8KQA2Eewlod6R/Sp2kHKFDzOA2CQiOab1Y/yAk2fr4o5TKvIIE+XnPei2gLG6/6XnR4Ce0wa7UL4mXQab6tq4RXRcHhFKkGKsdY/8QsuC1VGDs3+iRf7CRcLZsHaLobr7hmSp3tBQUxTdcEe8/3ayk+WZ8OzmAKKGncz0vMc2680uHXRXru7sJmX8ymA/2E/WN2K22woesatI91O8OuCRgIC8LojqI1zciAQKm5x8BB6VcoZeChn0IXLUmB5SCNrcGHyCUDS79j+NnhfQJCdtMZmdWkgH/V6U0+yAkKA3R0hNX6BYllsKBSrmi+Ydn6YPRWWNq0l6BWFgNjdyS9ICdv8VvbvKT5KGt38GxeML7TOdAj0NuXQnk0tdIWe0F8b5PMVLYEJrZrm/kdMagmsWSnWQf92SsYgb6+4rYgnqg3sOnGaYNkLxQ5jwccsuWKPuPj2M9wMZ/NKEucYMz8onYitpBKvf+EGA2P0K2zWZHZjZ5uY7e5pzm67Trl7+BQ5qVpvaVsyVUjE1FZfnkXVCW2dGsODhUOCZ/GVNR0kSusWIbVkDxzIUDCFoVuchNFJfPajjQ9H9VSlS/73ni+uuwI0fiaW9Bkj0xcXPy6/Y8iJMu531m+PVJQH8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(7416005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTQrWEE2ZDl2L29oTWlmaDQzWDBxbWc5WW5keE56Y285akJwYmE1K01lRmNV?=
 =?utf-8?B?Y3pTaVFQTUtqTDlpNzg3RnBYN3VxbGJwWjcwblpjazYzQnZpNmkzNW4zTHdw?=
 =?utf-8?B?cUN4Vi9yMXFMRWp0S0VpT3lwNTlFUzl3V2tkNTRPeGd1WFl2RndJd0J1akNL?=
 =?utf-8?B?T1VtaVNEMzl3NndycUczdDU0ZXNBVnFmV1BQTGZCcmhaUzl1UWtYMy9RUElj?=
 =?utf-8?B?RHJ3RW1id1AxUG5kbjZ5L0FaWkt2QTQ2Zk90VmZ4anhJbjhUQXhTbWdLaG8y?=
 =?utf-8?B?RGtuNFpHbXpnN09wcjZwZEZaelZNWStwWUZ3cmJiRkVFdGJjSVZvNktIL3RK?=
 =?utf-8?B?R3NmYklVa094OU83R1pEaGZTeFNzR09lQVNuNkRjQTk1WXpaR3Bub2kxSUJB?=
 =?utf-8?B?cUs4R1BQMGFYQ203eGJpc2tCVWwyV2FPZTE5NEhDWERFN0o1Wm91b2ZjZ3Rt?=
 =?utf-8?B?NVJ1WFpxZzZrSTBBQXdFZEpTbkRyMk12c2NkWjlyaTNybi9EeEE1dUV0MVZm?=
 =?utf-8?B?d2lLQ3hUS1A3NjM3bjdXMWxRdWN5N2wwQ0tiZFdObDBwN1hGTFBXV2d1QStj?=
 =?utf-8?B?aDJnQWozbEtqU2kzMUFxUDlUY0YyYlRJSGM5Y2NYU0F1L0JOaVNQQ2kySEI2?=
 =?utf-8?B?VjlOOUpJTmpkaWl1d05SZFA3UzBheFFqYWVNdFpORVVQRm9aNERrenFxcGJM?=
 =?utf-8?B?MklQckxVS2ZlWUFMWC82VW8xVGRFcnc5c2lYQVZ4WW4wQUw5MlFrREVpYW4w?=
 =?utf-8?B?YlJyangrT3FlV3NOYVN0bzg5Uk9WMVZNSTkraWRPMGx5NlZqUkZMeG04V3Zh?=
 =?utf-8?B?TUQrSDFaZ2syUHc2YWhZc09OekgzVTRsbjJreGFtZXAwYkhzRUk1QmkxRStH?=
 =?utf-8?B?aDBTTVg1L0JYTnk0Y0M0NWUySWpNYjFqdFpuaVVudkk1ajg3YnNxVG1JOUFx?=
 =?utf-8?B?bzd4dEl2TDl3ZjhZdjNadXhvbFRJQUNYTFpySmovVGxTOWxORnJrdFZmTkR6?=
 =?utf-8?B?UlZjMENoY1RCM3dxN05Ld1lvOXllNEhkQU9CbE9hU3FVcFoycUpZN09vTEtr?=
 =?utf-8?B?TTZUYTNBejJramxsek9TYldKZ2JpTTlGSnNLcE9qNXBqdXVDWnRFREZhOEZR?=
 =?utf-8?B?bTNhS2NVUGFUTmFVdHBKQ294NUlsUTV1bHp6WkozVWptZnlkeEV3Rld5VWV1?=
 =?utf-8?B?eDVCOHh0SXE4ZnpyRDdzRTM0U3NvWlNqWlMrSEY0TXg4ZHNvVHN4dEJBOUg2?=
 =?utf-8?B?SDh5UWxUSS9kUENBbGUyU28zSVdFak16OUNXOVVnZzE0QkJvdjFTVlJWNkcv?=
 =?utf-8?B?cUZMVTNFSmZ1SlpXbTdzaUlZVTBQczlTSDdmTGJMRm1KMGpST2lDekpRRFZR?=
 =?utf-8?B?eVBCRkhXeFM5aUdLVVVIclA1a0xpbkc0T2ptbDlveWhNVU0zditRMDd5TEZP?=
 =?utf-8?B?OHB2czNPWW9lZzBXM0RSTTZMRW9UaHdMVkVzWlNtTTVYQWQzWTV1aU1Wa1I1?=
 =?utf-8?B?bGJLUmx1bC9ETlM2SzBGc0YzNjMveWNTNVhMRHA3QWVEMXZFVjg4QWFTOTMr?=
 =?utf-8?B?RlRKdmdWOVdrRXZua3BZOEFWSEszaWtMYkFaekJleldSemhXTjFaZTdaZ0Nu?=
 =?utf-8?B?WWNmeFVkeTV6blZsOFh2blZlN0dHRWhPOWttVGliZkpFdXhXUS9KcXMxZldn?=
 =?utf-8?B?c25XMTRFWXZIeWQrZ2NwUDdkVGZ6M0t6MlQyNnY0K2kzVVVITUdCNnoxbit2?=
 =?utf-8?B?UTh3d0JtSnZuVGUrOXNDNlVPWDZHeUNDUXlEbDFrV01DdGVvZ1JkYldFZE01?=
 =?utf-8?B?TlBBZ0FNMnhkTkR3OFMxcTdoQ1k3VHpqNlNJQmVDVHlIQmM3UnJ5Qy9QOWRV?=
 =?utf-8?B?SE5kZXRNTXJmNWlZTGtNK0dFQWFjUHkxSFdLOEQzYjNrZC93WXdPUkNXVGVp?=
 =?utf-8?B?WVRZcVZjVENNVWJtUWhPMUlzak9XbzdWaTYyclFoUlFURVM2dTZ2T2dTMWNZ?=
 =?utf-8?B?b1p1cHpZc0MyQ2JSSmptVVNUOVUvTnJDZEJBdlpHMDBBUXB0SHhHVHNKRFlO?=
 =?utf-8?B?UDkwVGxseC9STXYxMVZDMEtyYUpXdE1URG9CSGZTc2dDRXZOb3p3T0Z3T2U2?=
 =?utf-8?Q?lu7kEjHFnfTbW4wm7VOo5rohH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819bdb50-7069-495e-fa7e-08dc5e244670
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:48:27.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Klj/ePcyIM8Ci8U4VmmFcqkP9vRc+lBl4fNPLevasr9CWt5ZHBV3t8xbUrg7+ZK7w9wOk3j8KeDgiZSYtD/dfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

Add ref: dai-common.yaml to fix below warning.
arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,esai.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.yaml b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
index 2a64e682b5178..f99ed20fa684a 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
@@ -99,6 +99,9 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: dai-common.yaml#
+
 examples:
   - |
     esai@2024000 {

-- 
2.34.1


