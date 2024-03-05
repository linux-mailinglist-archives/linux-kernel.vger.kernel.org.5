Return-Path: <linux-kernel+bounces-92770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AA38725BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5361F264D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2A817584;
	Tue,  5 Mar 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FeEiC1Zg"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A58171A7;
	Tue,  5 Mar 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660008; cv=fail; b=c/s2NhzjhvizQRXyOKY/RDyGMPV8I0552nMhOz/6+7MsiGF9bOwR0tisIWkif1mL9bSiG5fkrZLlrPZBNeLJbqruUnfJdxpSg7v0t2rMnp4z2kNYuVU5Zl59NotSF9GFNDjAAAwFu+aaC//NeiM/uu2KBsAgQfn+1+YJt1ciVZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660008; c=relaxed/simple;
	bh=/2HWkq3Mm1iUSRkJDy7WMODf+P4negKVy28NKaq5Zj4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RxpvYl5ph4zV2CPe/o8Bq1611L41aA6wcutjOUN6EoRmJRyIJDVkDh+jimf655u0kVDFUL37lNFKUr0TMXPixtwigF0EPaTxzD5DLqPeOJv2khsm+Q+EL1VbZ7bTwDybNV91vjGtetCRKfNum5Y9o4pK3XCkX/u0QPb3IolGxBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FeEiC1Zg; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9o1OU+XjPmAxVsgc38IxUyL83onJxqJL2zFaU/xOmMSuO5zKKjKbqMer611M6aVAC98nCkSeQF1RvzyXKNvstTlsjG5DySgR0TXu8A6l9gCJzcTvQSDsUunJ6WvP+WrqrqYpkDuOx3gTNYm/qpCXEIBvLv6mMl1URqM9q3kuqx0bH5FjvuCN9w3gOo319v4rb+duWhdm72iGRA1T2YX+T0F2vC3Ch7BahDr4VsiSxQFRASk8PRFFDrbEtjZjpwojVLw8A5V3rqChGfvGbSx8AQONVPWSsdyClMJqbu5E+2uNNzw5cnfXv3BkomNRfGIcEfq/t1w7S5XcGEHJsh9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/KHtMUPtsyENuHOeToNttq4guUrlqWCDtHLM1euBe4=;
 b=lC6vzNiXJAvX5LRPwNkfInJ+7ek/iPvJHwk3AZ+9uXa21qUQla6AR7z/h7HQFRTMaSS1nNq4FI00KswA7fSybUDvnAfwLejfcl98GLrGyfUdUgQbpTDTHpayZVO4nglw3G/PeTg/PdtupbJFIBHy1/APy1eUryfNKCv0WnAylirYnjPRf2ftSpyVfVr5Rctkq+tanVT/cfD14vAesmkJRDadv1oWOlrx1Z9czojWNdVBsp8hMz/sCl4rhStUy8ZFrtOX9R5x9eqh0pt4N9MNdGOGbCC3qlLjZKpIlcnnsHX/M8KA5t9aw+YBnB6lHe0JkGLQiDl/MfHI8UkJ3z2Qcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/KHtMUPtsyENuHOeToNttq4guUrlqWCDtHLM1euBe4=;
 b=FeEiC1ZgeQGpmiqF/SoXQJIyu4vgNS5EaqnlHCFFb98OKFge0PhtZ3cNHXkb5nJIyScRBXyKoJz41dE3Z5hZObhroYy9t8VIAAWihKEizNQ9UvkLAlN0R8Oj0MbDdOmwHhfBfESR6rzhXZtRCosAM+xywY0PtkbmzAmUw2N7Sac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7856.eurprd04.prod.outlook.com (2603:10a6:102:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 17:33:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 17:33:25 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 05 Mar 2024 12:33:02 -0500
Subject: [PATCH v4 1/4] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-asrc_8qxp-v4-1-c61b98046591@nxp.com>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
In-Reply-To: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709659997; l=2277;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/2HWkq3Mm1iUSRkJDy7WMODf+P4negKVy28NKaq5Zj4=;
 b=Fy/xb3ldFP8wnnjK3P66I7BXsJCCFV9StqD8U6YzXXThNa4w6qfUgK6nEWN7hXcgnc4GXPN7O
 IHblCcc1q89AocjGYhXlnnKfXZSn0LIbu3+07mQBtf0BHmAPe3B8bXh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 6876ee05-d78a-4397-eb63-08dc3d3a5cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ajHuv0FGaYu3siQUOIf3JSE/Q1Fq+ENepyEjo513OLAEqPVbheJyoEHzKLypHDNxoQyeyTsmjbYazaaR6pbyN9sGdv9wL4ObwqQr1YuteNDFdrSeUy7pG8+h9IfoSRFAEqUTkQ8zfUHiljpbrpp2ql4xHZqtDFyefQ/zAGWNq9qoVMLGI9jrm/k84+XdjXMN+AcjQ1EK/TcFKg5lLwOlSgnq9L/3xDwDcTMCtIxq/28CEQ0LacWxh83Ap73yVex3hDgt0BLOAUXLLTKQRdqndZXwK2XMkZ9aGS7eO/w3RtmlTTa6uZMMpWN7XrCbt5erlS2qPjSPVOVkzFK594VN8D9vmM+DbRKX1O5ACvMseB/n11xioDeKX5pWERqumUs+e+U60gSylhew/GTEeikqQSPe6HXdc4bXk02uhRQacCW6nKNUbOIOnwnrtXqxQBhLdYd9ua/CbYjGfGVxhMAScabfYXaGYLIyKskYbCjRdAhCSDBE9/Mz1ZQkDo6OmCb8O464ufBC38+ZXCI/6+ydtkcbX8YFMqYaWUybJYLAqlveK5EVBeggZDaThCl5D3nIfzZUS0R47ai7IivUs9a3H3muM0QgAEryTxUg1tZ3CTYYxlb2V9BNJB2d53DsfXMEUuUbUTT1ECbRPCj0Y8NnBXspIhzXMaSolJfPLU9bHnlCRp03RYV3oGd6eNHr1SIMRygZzA3Zwo8jZqA3tKwQ0H5ntm6Jcil7uKEc5mD+gKY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXhoa0hlMWZUL21ZVGJwZVk5emZwcVQ4dWFCSXc3cDdvNEwyRThYdnJOaVpo?=
 =?utf-8?B?NUsrUUlLUExuQXhReFBjbzVFdjVZeFZ3TUdZTVA2alZOdjFzODVZcEpCdi9o?=
 =?utf-8?B?azJ2ZHlvMmFXYS9aOHM4c1pFQTRaNjExdE9lWmJEVVVVb1FQTGpHU0tocW42?=
 =?utf-8?B?bjdTMFhGaExjUSt6aDVqbUVyTXhMR1ZpUUNXZkxQeUpoTm5tL0RwTkRCVlJI?=
 =?utf-8?B?V0ZXWXJnOEs4UUh3aTZKV1ZDQmtvaTNoVm1hWEZ1UGgyaXhEb2Vrd1EzVlQ2?=
 =?utf-8?B?QWVDUVBLRmhRWW1jazBZcE9YUEFYa0RBM3dkUFd0YzFENWlXMnNVK1BORjRm?=
 =?utf-8?B?NlNIUTJMMjl0ODhzSkEyeFhlU0N5SGFBNFZJVDVPL3RlMHpaekpwamZZMmNV?=
 =?utf-8?B?bGJDc3NZUWdxdnhGTTlmVm5zbEtFWmFsKzIxaGNLRW9BdGlWR1hDeFNDWk9Y?=
 =?utf-8?B?M1VtVEFuWlZOaytvaHJ1RjNRYVZWUmIrditvVm1rcENxR29NMWxsbjc4MXZn?=
 =?utf-8?B?V01lOER4dzBIcEJXbGpHdjMrRTRkRklnUDAyNXJZV3hiU1BhT3BXSUNqRXpE?=
 =?utf-8?B?N3JHcnB2QlZTMnE0dkhJc0lnU20rR0ZhL0dxNTJQV0xid0phTEQySitQSlMy?=
 =?utf-8?B?VGdIZCtsNmtEOVVxYVpHY3FJcHhwOUNnWUJqUXFjdzB0eTlTY0FteGRuc0Fy?=
 =?utf-8?B?WnR5eUNVMXNvWmJmUkVmYk4zbHlPQmlaNjNTWmlyQmNmWE5nOW5ERnRZZmpn?=
 =?utf-8?B?bDBNcGlKdisySVRHYmZoUDFqdDgyNHk4YXlkT1drUms2bVZESm0wS2liQm5r?=
 =?utf-8?B?amRlV3BzNm9sWlhpUWtZRUpEdnYvSGJBZStDNXpNNVRrV1Iwc0NxaThqR3Zn?=
 =?utf-8?B?aEV4R0NuMkRZV1kvNTdVcjFTQURlMHdESnZJeDlJc0RnUTQyYWduSkhhS1hS?=
 =?utf-8?B?RG1WS1JDR0x4amRVNU1YeDZYSlJsNzl5L2Y3YnNHc0hMZVZMeENGRHBaWWRy?=
 =?utf-8?B?c25HcjMrVTViS1JDVUtLZ0ppYTlZSXdyVDJ5NXVMckJKdGpsNVdOUkNnUTV0?=
 =?utf-8?B?RG80Tjdua0tlbSs2Mjd3S1JKR3c5YzZPb3ZMZXBLK1BrYTNxQUliMEhYcG4r?=
 =?utf-8?B?SFhZdEdOa3UvVi9YVExGSmJOMnVDUkRBbWxZcXBXTWtmN2ppeEgwTDg3VTZZ?=
 =?utf-8?B?VjlkemhneEJRZCtKaDh4ZnBUQlNoR3dXN2RZT0xXcGlkQmZ2OG9NSjFndHZS?=
 =?utf-8?B?OUtsOGVSK004Tm9UOXQwbDRHR1BYNmRPMWFmSUNxQ2sxR211SXJnakZMN0RD?=
 =?utf-8?B?VlpndDcxN1kzd3F5S05DblBLdTJkWFZSOVVuVXU1aEQ5aXMzSU9qejdiWk5C?=
 =?utf-8?B?ZEpHc0x1SHZ6bDB0Q1k4S25YSmVUZjZXV1kzRkpaNGw5Yi94UDlqTjdEenRU?=
 =?utf-8?B?OVdHa2JOazNTTXhLQVpsOXZsdmtRTitmY2lQdCtYYXM3bHkyL0xGYjRwc3Fv?=
 =?utf-8?B?dnJnbnppS3NnamNyeUVvb1dMRVZkaW8walc2S08rSE8yNWZ0RjNlS0lTNVc0?=
 =?utf-8?B?c1hDV2s5QmtUMGJzeEFMb2NpR1FVTmlQU0RJZ2hMMUlkTWJwWGoyK3EzS3Ay?=
 =?utf-8?B?MXdKS0hJdjlCVE9OT0xuVGpIT0UxVENSU3pCRHhSQXlBTlBxUy95QWVMK0FJ?=
 =?utf-8?B?MEtNYzBULzFFSFYySm1TUnE0OHdQOTJoZW1nd0pZVkJEWlpNY0d1bk1SNUR4?=
 =?utf-8?B?ek1MSXhuanJkVEFySGNZd0pRRTBxNFlyWEpTL3VNazhEUWczekVyU2NmMkpF?=
 =?utf-8?B?NVZwZFVGUGZNSEY4OUZjTktYeTZzU3FvdkFVSURSbElENWFKemtsL0c2U1lh?=
 =?utf-8?B?WFVBajllRDgra2lDUUpLRVBOVXd5VmdkOHpvb2RWeHVNeWljQ1FGK3crZzh1?=
 =?utf-8?B?b1ZKTXB4eHFCUzVLSXFRUDZlOWh1Z25GM3hEUm1xN01ySVB2QVh4VHIrTXJL?=
 =?utf-8?B?Y0hOWGNJVHg4TnFCRi80Y0xOaWNPZDFwSmVpSlNMejBNbUNGZ21Nb0Z1NDRO?=
 =?utf-8?B?UWR2WlFoem5BYkpiazVZMlJOaEJXbSs0YTczTVNLaGlnS1RVa05RSHl5emtG?=
 =?utf-8?Q?BA21DwffpA2k8ow5etN73mHPT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6876ee05-d78a-4397-eb63-08dc3d3a5cc8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:33:25.4739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJ5g4NWLeWMZ0FXXyMzGigFBh5ROjnqXe1rDfYJ3junU6KluYaNwN8Lin6Yyf04qJ0MET9JqOHmGi1gp7reRBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7856

Add power-domains property for asrc and spdif since fsl,imx8qm-asrc/spdif
and fsl,imx8qxp-asrc/spdif require 'power-domains'.

Set 'power-domains' as required property for compatible string
fsl,imx8qm-asrc/spdif and fsl,imx8qxp-asrc/spdif.

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


