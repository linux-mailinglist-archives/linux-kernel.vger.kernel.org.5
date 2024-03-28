Return-Path: <linux-kernel+bounces-123110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D8890248
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36344B2235C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204C812E1F7;
	Thu, 28 Mar 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sJyDnJhf"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020912F38D;
	Thu, 28 Mar 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637536; cv=fail; b=CxFgrM2P2cHuPm5ouwSmioL04+rcpbjzTvwA4N1mWYkCjDjyXz0RXJj7fpcWG5dNe6JkC0NvLPW/kfRL0z4qHRa3pcXe/wiymggBPbtte41JqeluaHfjv4IcsgepcyHmYeu58OrjKW/2/b/djZzy5NbNFZpCawbYB02ZbllycLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637536; c=relaxed/simple;
	bh=Bvl3g9HoEjMtFNKSjWKZPWBsS0SGyMK2g73h4t4lBt4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eiYEZFwOChS5DkQO+89e5FRAJEeLWvf8vIFxS7i3ocJVatOP2qTDTOqTxOn2mdNZe7EjTb8mItc9S1mwLrChkSGgHAOmQsUPTR4XG1H7rORLM0pYEqQru0ibTFBVdVeW83m3t6U/kf+vqje1HDMikzsqwmgtxIlnvxwfd7XTMcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sJyDnJhf; arc=fail smtp.client-ip=40.107.7.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHTqDgSypz3PyTUJaS1+P14VBG32Q7QpoP5jYXNrcPttn7KCN44SvNqlG/LojOSwEJwZgp1T9DRoUeAS0Huug/AQh/Jq32FaB7mxVCIEbVzha+OLPXWrIyX23gxPSY5vQJCpZlC7ntehQ7DYEc5/h2WkTcuwOcYlDgrL32sHcCLKgeDNv735rtRXCCgkEtCW9Vn61bFS6fTLhqu9a6CR2DK3LguvKDSvBicvtEo3PBRsTic3lqwmR0tqKLI95Kk5jELL8KXeJKMB5dRlKQEMO0YCPLlP9u+4u9qd8sb8KLAuIorsvjH+H2JUhMxVmv8//BKKO8ThjFlC0CoJ0ROnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svR5J7tYDVHn/jmNnxX9WGrcgV66oobZQYpWyz4HRhY=;
 b=GmWDS8fEJB/Zq3W6DZbYaIb4EiyNsAuaBCqcB3VgPALzVf7YwrF8g/AfcZbXiTpJgusRAPrXjlohEBq2Wph8Tm5h9Sn7KY/hSd2GszTL1W6jaBP14FNvrr941CdHrOGOESUA+4bAE77CCE8Xusj49XhOiRbkchQ6hBiL0jOIPNHVbkSXpus0YC6DmJ9fLY7TFJGbH5/cjUH0HTH2C4uk0LQ6LtMZNDqxd8dklr39m0cm926em+ZL1zkdxeyvKeZ+9pJPS6Rbn87KoSLuVa6bgKDgJuV0eLD5mkE8qaEi5GF/wb1/PBnksrtjj+y1DOramObmkDE3vlgEZYYRERTKWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svR5J7tYDVHn/jmNnxX9WGrcgV66oobZQYpWyz4HRhY=;
 b=sJyDnJhfN7w8/JlSbii9LGwqueYA0T70uGQxjE+BNeiuuCvwsJ2IjC7ED6Y6hakXZ9Sej2YFWFKdWc62s6ytOAimdaQK8X18hIOGOTUK9eigGHfOYEEHL2AbOdnqhfcbe6T086xuAIK04vswe3PFV766F1Sg5hw4IVvl9/40KLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 14:52:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 14:52:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 28 Mar 2024 10:51:34 -0400
Subject: [PATCH v8 2/5] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-asrc_8qxp-v8-2-801cd6bb5be2@nxp.com>
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
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711637518; l=1393;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Bvl3g9HoEjMtFNKSjWKZPWBsS0SGyMK2g73h4t4lBt4=;
 b=68KOPmR/A7brBusl7ZNa7pMpw5iapF416y7pEcMdAtW062wYaV3ODZhGcABjLE36m9d67JiAh
 nzE1ZIP6yquDkQ+84DR1QLd5bwKwkh+KXEN9bQ2GCYdEUOrkwzOw3cK
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
X-MS-Office365-Filtering-Correlation-Id: 3d9b6da5-a902-4491-b866-08dc4f36a57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uEy70XsvjjAZSorc52khH/XlEQ4hLS4MGKVB2aUwvTp+IgMtZ4WaSl1VQOj+OsYDN1PNQLrbYEGX2xzXI4GFRj24Vbvxfpnxoqjm692l9WdV6qvFZTIV+2YQMq0hSPr27cqV7LuW3bnzkf5spmQXLSlPGTb43660wWGgmwQvQMa1Ymmji19so+m2whLJbTzBLZmlVaBA1d+DNB5CN9tUNVPi15vWpZE+CeO4+iHEuZa5mu5wwqpkm5tfTuXDYgoWTWwcEQrLX03FskPgqo48aMgdtTB/yRGVIV2QQGq8T9o/6Rjy1XVxOiEMg9DLwOz4zQ7YcC6ne8FZK6LeADnXapz+WyzxIScHFhyXvHlXJY/czsCQ0Ch9bN1V4vWUNrM33h43tYkTFe5D3cA4XI4HigsOrXCzq6JPYEHKDvbiAdFuszidXCfRVrlgyk9NMBbGC5taLGUqiv1lVre4IjWnf7oMVnkiZAPenUYRxRt95hqEXzi3oSjqUqmJ8Rb5IMz/nNpwD2bZP+1PXVmlafnzYGrvtdW+UK/wtqUS2Tkj9GpbQZXTc//bqNXhujNiCtsAn97zbNRT2xB8ttycI9Vovg6f1P4Y1BvDVvgduuVTrCRJbVBL79r/AoVDv7SvvfRN8yDqneKNoEajbcABFCcU7479vW+fu+ELrLpn3uPQTc/nToB1RxvTTSC/x4x3AvvQuGsF/NKKLQox58ofHUxK/QtlmyctseTayh08kGTNvcM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R09yN2ozU2NDV0xzSHE5L1phYUNSTExvQmlVTGhOSTFqallCYVNlTFNpc0lD?=
 =?utf-8?B?ZEV3LzZPVEFsT0h6Ukdidmx2UUZVL3VnaTdTVzl4dFY5dFdVb3h6emd4eW4z?=
 =?utf-8?B?UVFDOGJOZGl4ZFYyc3ROeDBBTVk1SHJWY1dGWVEzUjFKT0xCN3BwOU5SUWNz?=
 =?utf-8?B?WG8ycStCd0JTcXVMbUtCVXVqVXRwd0RZNTV0aDNLMDhLOUNCSXlYdnl5bjAx?=
 =?utf-8?B?TFpINXQrOVNwc0RrNm9IMHMyVjNjQktDQnRYWDlhODNpVEd1MFlPRGZuZFAy?=
 =?utf-8?B?YS9mNzRTRCtJNnI5L21hU21uL3drQmpBWjFWQnhjQnU3dENFczFlZnczYmpF?=
 =?utf-8?B?QTMxbVN1cWJGUVVSTWcrUTM3T0lHUmgrSkszWVVBN3Z1a1MxR1ZWV3QvQWUx?=
 =?utf-8?B?NFRVRW43cWg5MjRDbXpaTUUvYWJ6SzRuTmkreUZJbHltVDJRN3RpdHpEeUR2?=
 =?utf-8?B?MnY4aitreXR4SngrUzloVVpJMTZNK2ZDTitKVWxPQ1hJZDh3Q2F1bis3RXBM?=
 =?utf-8?B?aHdjejBIdEFDNldPSzd2VC9ENnVwN0IvMncvRkRmbG5ldW81MW9TanlWbHJ1?=
 =?utf-8?B?SVZlZjRGUjZSMHlKeCthSzZXaThCWjZoMWt2T3h4ekxsU0ZVS0ltamNMc3po?=
 =?utf-8?B?OTd3b1dTaW9zaGVDOWg3bEZSTWMyRmJJbkNIOHYydHlhM2lsWERyZGgvKy9t?=
 =?utf-8?B?dFl4Z1FSeDdFQzdBQ05kdnB4aDd2SUZxSFZObW1od0FnSDZTTmJReVhLYUl0?=
 =?utf-8?B?MjcxWng1em9JVnlWT2RXcnVtR3U3amtBdENWQ0dsdFVGT3FzSlk2aXp6azhh?=
 =?utf-8?B?NWppeUY0NHlaeGd4amRxbWxLUDd4YysvOUdINWxyYlY4QnhBeG5wZVRDeEth?=
 =?utf-8?B?UktvUDRPZysrdHRBNnZ0YjNrRkl0Y25lU1pUQTFkMDBxNldSdmNtalQ0Y1ZF?=
 =?utf-8?B?NjVtNmd0Y2tMR0VpN0hDU29qYmlTcWxtY3F4VHZJclNmM2dPNjVQZHBiYXBy?=
 =?utf-8?B?VjRFS2JXalkwVkgrSW9BZWR2Ylc4b09vM2w4Y2g1MmcrMDlFMFFKeWQ0UUk2?=
 =?utf-8?B?aVk3TEZuTTJ4UWI5MVFlYzZVM2JlUkYxTUhUbzFlVVcwV2tsa0JXMnhZOWlh?=
 =?utf-8?B?aFRzNEJTZDU0eFVWVnRmQlpsVUh5R1ZvR1graEhHSnRrSi9KV1N1VWJCYnZ0?=
 =?utf-8?B?NkFNSkNjcVF5ZXdtNENaZVBvTUxuQ1UxUTFZV29RdUZ2Ky96bTZaNWhHNjFV?=
 =?utf-8?B?cVNrM0ptVEJqdmRpVGY5U2ZGWXFuVlgvYnJraEw4SlFXZS9MQ3B4WXZXNzF6?=
 =?utf-8?B?T1NYSTV0YW9nNjlGcUN4NlBENUtPbjFGQjRPRW1GSWdBUVp0ZFhlWUJpU0pO?=
 =?utf-8?B?bjI3QTM3VERvWEhDUDNrbzV2c1ViZEp0QnZrUEdrS0hpMkxqenFuUHN1S0VQ?=
 =?utf-8?B?ajFZU1Rhak11bWljcFU2anVOVU8vZzVvNXZCcGJLeklUQlJpaCtqNjNPNXJR?=
 =?utf-8?B?a1pKU09pSDRNeUU4RlVUcXhoUmNwWkpLb2ZXLzhueGlFaHh5QW1EZ0lQNjdC?=
 =?utf-8?B?L0JSTzRaeWhvYzVnV1FjN0tsVzJ4VTM1anBuZGxQL09qNkk3ejEyZ3dtT3Jt?=
 =?utf-8?B?bmV0SkM2ZTBTL3VYVWEzN1drNU4zdVdmQ0dJTVpmUDM2TkxESVFjeGRIMWY2?=
 =?utf-8?B?b1JVaHQ0SktRTU5NQ1BJWWtOL0N0T1lQMlgzZlN6dXptcFRIT1FYODVqbHIx?=
 =?utf-8?B?YXBYWTM2cks1bWdDb0JkbmozV0NKYTVxaHdud2ZxejV1UzFCV0pQWHkwMlBK?=
 =?utf-8?B?RU9ydkxSSHBZbW1KSEF1Vmc4TDNWN040RkYvSXdEZ25CWThZSE5wc1BoSXk3?=
 =?utf-8?B?ZzV5WDh3TjZGaHl1RlFpeXdvZG5KZ0FROFg1a0RPZGtGdndwUlVySWt0NG44?=
 =?utf-8?B?OVZyUzhNYkVZeEU2MU1QK2plREVKeldVQXE1dHJrRHlRejhxSVFEeE5OYkJT?=
 =?utf-8?B?ODBCM3Vqd1diRjY3RTd0Q2RJVVBVRnQwb016RTRlaHNrYzVQajBIN05XQWZv?=
 =?utf-8?B?UXA1V1BUYlFDRnFFNXY3ZjhseW9oeUFlSmNwUFl2VU1wRVMvWWJpQjY3dUJw?=
 =?utf-8?Q?wkjgs9vfg4Pux4PyRdy5BXHTI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9b6da5-a902-4491-b866-08dc4f36a57c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:52:10.3787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teROhOQt6z16jdzM2cNREQTP+vK9wNQzQs8NLM/e3zPkTXT7pZg2hWGAaeagPzJoFYXaWuflFgo4RfGDxwFaMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
have 1 interrupt.

Increase max interrupt number to 2 and add restriction for platforms except
i.MX8QXP and i.MX8QM.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/sound/fsl,spdif.yaml         | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 56f8c0c8afdea..204f361cea27a 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -31,7 +31,10 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Combined or receive interrupt
+      - description: Transmit interrupt
 
   dmas:
     items:
@@ -101,6 +104,21 @@ required:
 additionalProperties: false
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8qm-spdif
+            - fsl,imx8qxp-spdif
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
   - if:
       properties:
         compatible:

-- 
2.34.1


