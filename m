Return-Path: <linux-kernel+bounces-150501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D638AA036
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A841C21F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8317164F;
	Thu, 18 Apr 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VPaVGMiP"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E316F8F3;
	Thu, 18 Apr 2024 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458220; cv=fail; b=THX9KSiDu/FykA/Xc4TqNTgoXYspTMCQyL63D9GBPDrwZc5jk/4YR0B0LJnqyTtnlYgOqpxmxjLOEDqx+JCu6qRX/WhKgAU1vDWVQeJ6tEI8G0F0+/ftMjTnGr7UM94/DufTUMRdA0LquOybSmFj85lwXOGXqjWvzV6Q6g3pRb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458220; c=relaxed/simple;
	bh=Anf5/cBCqL2nH+zYCUD3DObM7bD8CDoVdBveSiz8u0s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qvDq/XrZgUOSFXIiEWKHt3VGUAuwUtc9xw3YCF2DYcoDzTbVcf90iH+FQQ6TyGR4HiBI/9TEzRKS5A053gMkIB4hdrVBe1Z/bojPl+GoSypDVAK82BDbON8NyBcK5t8awTwgt6n6wYpXSnTDRGAiNS4Flm4xQgugD72mXwuvJnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VPaVGMiP; arc=fail smtp.client-ip=40.107.104.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XttueOwe9yrULQDGSMnZbNFQZ5PWlk9jC5uHKkGxOcj0ncnME2NHA4k+5tYMu3EWt5oCb2Grtjl4VXMiWfQGEwPZlkFZCHn66hZjwA/ZUzvf56/csYsLR5X5UDredVOP95MCo5FBCmJQ13PMl90N+9a4sJ3iucAx1CafKO6BzJFPf6BoPNl0TGmfEeID1Wt5q6HuSprj34OiOYilTn1PV7+UVwN0jAF1hrt7nUPnFHf+k6MA90+7iEYtc3Y2q3TmjLfs2HYqurhMr6/xE6qjVSgFhyA0AyEAoeNXUb1t7B3kLnU/4gNS2pxV1vZn9sGc5RokclR3XlTRsLhwR64NFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSjCqqd+Vrp4x4jUtklycv3HmWHkcAADRrDv+UEVxvQ=;
 b=NVvBVE3pdRmpI7QRL54pq3VSohkdp6VfshnUl74XmRFwDypz8GfKeDqoeYq38QFWXgwwhzjjCl4uL83iLZm/rvMIVqGRUxiYEUAcbdGfUdO+k4Q7sEgMMZQZ5VJ/JGxqBPRno7loYd/3hVLSO9GgJtSgmrqMndR//avgejiNLk3o1b8Q9EGc931nUli0LRGr30qJbHD543hC8TJNZD0cFMOAvy3J6qxIVloAfdNhVIiZVHcY23D7dbzvaEKwlqlccgyKC6fu6F1NRCKo2v4fwaq/AD3erxHPDeOkDsxqk+wq8PuMTorVnTIu1BPYw9WWm/d9KT67mlXVMK2R6lRtnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSjCqqd+Vrp4x4jUtklycv3HmWHkcAADRrDv+UEVxvQ=;
 b=VPaVGMiPoZrAg50fx46A0+qiTpxyLsUbj6evQSTNNQHcLOdg/GTSLgk89Ds3VgYMVnFhrphiM9gHH1S0unrUsXuH6OJrNsRw4k+I6hpsnCuI5uwdz/BISqnh2VCUcupmMnU66K3zq7F/cYI73FLMmOIKeEDxg4hfNzZH2TZ0YaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7079.eurprd04.prod.outlook.com (2603:10a6:20b:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:36:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:36:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:36:36 -0400
Subject: [PATCH v2 01/10] arm64: dts: imx8-ss-audio: remove memory-region =
 <&dsp_reserved>;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dts_8qm_audio-v2-1-e40fe76b60a6@nxp.com>
References: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
In-Reply-To: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713458209; l=757;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Anf5/cBCqL2nH+zYCUD3DObM7bD8CDoVdBveSiz8u0s=;
 b=yhf7LIM9coCkjNovrhM5nXo3lqsJmYnTXyp/TIg0hM7kYzImOJ5qQbcuNYN04mvJkJpoYMykq
 7SsjkQVrC5/DWZ4JqHKf22RfFJE2mccpA72r35XFiM4Jnlb9wnQLB69
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da4155d-40ef-4847-1c50-08dc5fc5c2bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qMXf7uruEAd2ws8wvmbMlXvJi42uAGQ1U0bxBr37JLzrdGVnu8iqk3cCAG3F2kY9wspAXW4NiM/Z8bU3xE3wj3hZ+2jdAQrQBZugZZh3kQH2ONaPni48p5giVntzPgT3ka0Top8d3K8nNB5oe3uG2jskordoFvf+GV0GhbpaxbXRld5LVQakZEG06F53mNtwDVFQzhGut+sp71omkLICViIg0IHKyYuMtx2WMprESl8Ov58Rdax3a1N409ATjbQbPe+zq2Sc3SIyNlppFg5mEdNjl/4an7Avhu4m0Gp99GIDauphr1RC5HASqgWram2XruTlI8Ekv4rI7Czu9NMQDbCPf2a6mNYdOn9Gee6O9y/+44G4K4+ReqKA8k3NZOLDhQx4cnrwfluD4uQtR3DxoEVL7Y/oRJdp8u5dThF7RXk3SB1XnRAYAIHKlwQzG4UisePf+/gI0MyGT0lfqTBjytfWXY5n9azL9TVYHLez/wRHNKg+324V5bn/RoReH475WiFXJ+aQlmnTj4x3BmCENig0crJPsJgRROr0l2q6f/zYLosIQJx9/U6wGkOqxl3I8nI6FlbzRzoCHEo/0c76l+6Gtcl8X+55Ji7vv7XMyuFagyZA5XNyXk8ngBEAL7OKqRjz9/oJv32yY9poiiHQ0ALabKGowLMNJ+9OkqyQpyzfB/zUWKpeIw4pwP+yv219mF8X+q1fQptHWqJIwF364b6mrGtg6YygKsA/s3Sq95k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1NrZDRDSUpzOXFpUkhVUkUzaEpoUUtWR3k3a0gyTi9IckYwRWd5MFJ1VWh2?=
 =?utf-8?B?VTRVcDF4VFc1aHgwUXlFL3hiY0ZVS3lCNitPblhYdzRQanI3SXRLQ050UkVL?=
 =?utf-8?B?eG1qK3IwOU02bFJpbHJKdWhDTnd4VTROYm94dWxhSmxOaFlRSnltQnVwZjVk?=
 =?utf-8?B?a3YyQlZHYVBjWElxTkxxaGxKNFZnRWsvamxMcGxHN1VUeEszb3VKaEFXMitr?=
 =?utf-8?B?cGZrdkd5Z1ovY0NZdThTWDZuTmZGaVljRmJHT25QN1dTek1GV3FjekVrN3dT?=
 =?utf-8?B?UG5mZUh5S09rOGpNNXJMTTNJMGthNjJBaXBmRGtvUHplSmE3SjhlK1A3M0F0?=
 =?utf-8?B?bHBtdGczUjg5SklRRWRIRldWRFVMQUk2dU1JSVVwYzFBRlBWYTF0NUlhbnVP?=
 =?utf-8?B?bVFiUE1yM0tXTVR2REFQNkZtSDVna1FHWVNuZkRid0wxcmZIZHJFUDYyd3dx?=
 =?utf-8?B?eFlPUE9DU1UwdUtJTEVUaDl6dzVRTVdaaXUwVkREamI5aEdpVUF2Q1RQTzky?=
 =?utf-8?B?SWpzcVVrV2JISzFDeHlIMCt1ZW9FWFovT01SN1N1NnlkTUxlcEVwU0pFRVhl?=
 =?utf-8?B?ODMwcUtrVTBwcjRxVnA0WEZnSUJpSVZRWk1tdjVwQlZxaHF3SXpUck1MU0E0?=
 =?utf-8?B?TnNSY0NRT3lMeXR3c1MxQVI3MWdvQXhlWHk0aVU1WnlSOXVhRzNmVzA4cVBW?=
 =?utf-8?B?YXMxZUs5QStRM29CVkYrMHl1alg5Q0VJcjFFTFJrbFVIeTZZK3JtZVRJQlNG?=
 =?utf-8?B?c1M4OXQxQnJCcFVpZWpaQTN0WlBDNW02REtYSU42VHQ3cHc4OWhwRWNYVDhN?=
 =?utf-8?B?eDlFSE92K2EvNmQzNDJ2aHQwblkxZ3ZIMENFVW5ScjU2SEJqYU1QY1cwTndn?=
 =?utf-8?B?WDQ4MkRSd2NJNXhqSmRaRE1GNVZscFdUT1RvOHVNUXZ0UzBzNDdWNFRJclJq?=
 =?utf-8?B?bjZwSWg3V2lEMlNHa3JWWEgzcVhST0lhNk9VQkdkMU01aFhGaU8wNDNLeVMx?=
 =?utf-8?B?TzljeGhFSUJJMFF6eUJZZ1ByL3h4aW4wcGlsZkZGbHRJU1IvZ3JZZVlIVFJy?=
 =?utf-8?B?T2RFb1BrLzRNSkpUWTZHVUJOdE5FUVNObEhaZW02NjBmZlRPTWxwRVlNeFJS?=
 =?utf-8?B?eWIrL1AydWhyTVJGeVUyS0FOZFdRdnpDQjJPdUtlNG9MRGppUjBSdkpXb2ZP?=
 =?utf-8?B?NkRIVm5naUNQYnZtQnl1V2JxRlVFeHZzeUVobU41T3p3TFRrM0FjMjdlVzBr?=
 =?utf-8?B?N1M5S2toSzRlWmF2Q050UnBOZThzR2ppZVVhQlVnUGI0VktyTnZUV3BHa1Ni?=
 =?utf-8?B?akZFK0RaK1FRN1R5V2xtRjlUWnlwbEFqUDlpbVFHRDZ0OGJ1clBta3lCT3lh?=
 =?utf-8?B?cUkyODZISkFLYnpDTE14OHkzK29MSUVValkvNU1pajBuNEw4b2FzVXpWYitP?=
 =?utf-8?B?ZXJqYnpHQi96dGg3SjUvMUV0Vk9XUFZ2dVdqSlo0bGFJdWZYczAvcEE0ZnQ1?=
 =?utf-8?B?aGx0VUFyNjFmT0k5K1FRZ3lLbExFbE9QOGs1UEtIbmVWUEpFbk5FMysvUFRr?=
 =?utf-8?B?OGMwdzltUjI3L0pUQUZSTzRQK0F5UzU0am9CN25ybEJQSklJcDJ2MEg5dWtp?=
 =?utf-8?B?UU5pS0dzM3V4YjdhdGRTNGQyMWxHQzNjQ3FMa2p4dkVhbU5GVk1NaUJQVStt?=
 =?utf-8?B?MlViZm5La0w5a2RMYlgxVzRiak1OSkJsVDc0S1owcVJnMCtmSVRIejV4cVNI?=
 =?utf-8?B?TkFOM0ZrSkF2Uk55QXBPM3Q4TlZ1amtqbkx1dkptbG9QUHRYcWJsTHEzSnIy?=
 =?utf-8?B?ZjdyMVBTcDM0djVZZGROdDNhdTNjTlgxZGtXTitRTERocW9uR1VKS2kzU05u?=
 =?utf-8?B?ekJDbEVEUjNHMTRNQTNsVTN0cE9nMEc0ZG44YjhLL1gyQk9GMk1JdldsNDd2?=
 =?utf-8?B?M3pwVUV3bTFSVEhOOStsRGRQdDJJRGQ2aXZFR1laS0tLYTlPcCtFdGs3NTRm?=
 =?utf-8?B?WHBBQ3FQRXB3c3Z6dUlWS2dNaDZKcFo0RFAxSlhDUkFBN2NidUZRRk9VQ2Nw?=
 =?utf-8?B?dFFoR3RRMHJzZ3ZJVTdFWHgvYWJCcGpyK3g4Nlg4aDVJWm1aTlVlVmtNVm5X?=
 =?utf-8?Q?QxrPNaOyjxBkW/bnVBtwktJsh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da4155d-40ef-4847-1c50-08dc5fc5c2bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:36:56.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRifiVaKP7G025WkKPMATzUXEnQG4ReenUDLyLn70zBqzcog2kigloC/qW4B2bpN0ix24Ynd0iC9SYZagKsdwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7079

Different boards have different DDR memory sizes and layouts for reserved
memory. This change reduces future dependencies to add 'imx8qm-ss-audio'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index 897cbb7b67422..ff5df0fed9e96 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -447,7 +447,6 @@ dsp: dsp@596e8000 {
 			<&lsio_mu13 2 1>,
 			<&lsio_mu13 3 0>,
 			<&lsio_mu13 3 1>;
-		memory-region = <&dsp_reserved>;
 		status = "disabled";
 	};
 

-- 
2.34.1


