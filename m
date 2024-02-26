Return-Path: <linux-kernel+bounces-81452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27D867624
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E021C252DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A0C82896;
	Mon, 26 Feb 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FL+TuqDS"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2058.outbound.protection.outlook.com [40.107.7.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0681ACE;
	Mon, 26 Feb 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953128; cv=fail; b=WuD9UI1cDU9ggcCEf/GyttccuaKPbO4+dnFQnfd0yJnZSt5XPwTRBcmHvZ74Q6rfixrAkd4Tohn2x+l2eccaDqktzRh+PleKgH+0KMdGLKJKnveLrHlj9CJTVZdoniu7I9FpZvPDAFGsGQpTOkDy7glGFx2hgsQwMDnmzXEIyVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953128; c=relaxed/simple;
	bh=o6ncHl3BNfjFT+AO8ES0BKJxTftIkfZi3uvdwo0U00s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=vAEzd+lvVmA5RJ9VMVjOBRJe6pU7i8mUJaseFNupPd/5E9RRSE6Hi0jlROMjRgpW6qkQ+fizOSHKHrFyzOizQmN8iwQMy9hOoUICVOjtf09HIpjYajjXkobkwsHO42dAbgmwQ7ujfLWtRBAnSdMzb2+LHuWGEShX2M15Y2Vz4hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FL+TuqDS; arc=fail smtp.client-ip=40.107.7.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtPk3fAXZ8q0lPkAlkq8WahepHbFAULAvRjmP+uVA/8ucmgXT3YYmOpIFTMIMfL4auBSlbbAcCFHMP57uze7HyNI0asjor1mXwafkd6FMrqxMcyub4gwFaV4B4aDh+/GxM/Nvqs5g5xL3p54Hr5D6htSOC21zoW+YYhoGrblIM5aVpyIfFOT/d9ZhfOTvp61GKJbHS0iBT3GZxG5SD2PgFmVONwpq0FhpuQjVOFJBqB4DvPsz3YfxIM5g1mVRKVg3gom98Ncagmi5pN3Iyt3YNiKpZMFV81bFzrv2BYW8xgyT4vIbjUhJaqVc0PIT65fVskS0lV6waiO/SNzvgdCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wXqMLI3qOdnms64WOExCHmw2ftiIy07msiGSmSyyhU=;
 b=jPoLumMYuvADCGRWmPDRtcKNjDmUiLNXRWzH2uNYTr5cU3VcEq6c2SczDRGOJoLoHNiwceHyURTS1UHE1poix2VFOEk9v2Ctc+FfLjFdguelQHzeDJNZyjGTiKYg9Lt84jxue4C1EWFjPRpSbCdSY4M5lHQClOkF8P548FjNLVh5cT+GpUhvxTmOn/xTzZc+s4288g/YFuvU3ywWX8LyD9xJq04BGAqmlWQvkb6zY2/J8kPprawv7lEBHQqIBrLqQEOu3z+Wk3RTrt0WORflwF26wyw4SyACMsGmE5ZnHZB/6wKrYPFEevCVeHPWah0CcpdTjy8jTwGJeFXNjc7Cdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wXqMLI3qOdnms64WOExCHmw2ftiIy07msiGSmSyyhU=;
 b=FL+TuqDSq5oFaIbqDBwMkZZvLxWKrzjmY6thKTZZ4yS0aDll3+FnvNoz/87hnMiJeds7iW1YvUV6Wxil+tTXz0cSbZP5F8PaAwT8kkUnJdY4p1t0sNvcyT8oMJJ+uh4Bd7/i3JEmW+xuO2SZR49aHYAdmwhxDdfZ+BZ9lF6Oz8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 13:12:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 13:12:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/3] arm64: dts: add i.MX95 and EVK board
Date: Mon, 26 Feb 2024 21:20:15 +0800
Message-Id: <20240226-imx95-dts-v2-0-00e36637b07e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA+Q3GUC/23MSw6DIBSF4a2YOy4N3PoAR91H44Ao1DsQDBhCY
 9h7qeMO/5OT74RoApkIY3NCMIkieVcDbw3Mq3Zvw2ipDcix5Sgkoy2rji1HZFqb9iH6fhB6gPr
 fg7GUL+s11V4pHj58LjqJ3/pPSYJxhqpTViqLXMiny/t99htMpZQvPxvhiaAAAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708953624; l=1752;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=o6ncHl3BNfjFT+AO8ES0BKJxTftIkfZi3uvdwo0U00s=;
 b=/dMn3qlBID371+j/B1+a3FqZTrCZm0WlsrXJw0UepXBEkCF/tk8ByI+IKKLj81MtnRkAy01vM
 HRPi5ia9i7QC6m2vzjgQe2N2h3WvkJcZ1Z/esnhb3F0Rx4Ch2PHkWoz
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 00016eda-8f80-471b-77eb-08dc36cc84d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	04dLTvU78PiWWq886As35AAZmAC6pOkYgKOj7Rg4u2iQzQJ9Tc7V2AFD8zzcmU1mKJL9bEAsgvRed12B0qMgN78E2lXwh5yjW7Nq+ewcuEpWoDy40xfgKttr0OEqlN2tColkvzp+fl+P24IsKqYxjyZGqRL2ZJ4BguMAyPPzAapMs+3eH8LJD4M6AfbhcVMQHcLVRmV2EnpJ+KuusD3NmGk2L0yJvbtd+tzgxv+TSOPzC6Q7MZmZepTJlQzhJfkeOisjIDXYt1G/wz5vQF/NLYth0WUj5mgNCMfaoRaxue35kCM4dVhIh9Icb/PX3VBJD4WjhjvA6e0QoQAkirjiYUWJJ8TJVOX6j2cQhkjtDVw4M2srB6EkJor/AgyplnMzNP5YtP5LhgfQTIXRfPfLiUq+5qEUR/DMUFEB2fyMI5jOE4GrC9NfnLjPji9LBI7oOgM1ihdPmfuiizKOBo/vyf5IjbtkUZxhIMglamk6ziDPlNyQtufhQ7KUgiqsb/LGwB4COlzj6MyKTH7hz75Hjkrf6BUShilC7LBhywzVh7ywy3IcafuEDUpVrSE02lCCrzvliILP9jD84kR10ijSjLXyWxdbgd1iu1Dgm5VEzchmgG4DmGOtmEJlDRryACCLcsqeyq0PRgXdyBzC1R68OGpnNY3iw65r/lh+P9QVL9Q+groui/9eFiIAh6grVCfvICt3+g1GRYaI78uxJcGo7w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTVMTXFhMUFEeHRWc1dJYUI3eVpmem8yK1NSY0F2UVFvVVB3L3RUVmUxUUJX?=
 =?utf-8?B?VzA4eWwvbnZBYy9rZFZrTFlwelJjMWtoSXcrTzkrb2VTd2VhOENURDdkY1NG?=
 =?utf-8?B?OTg0ckhoTU5nUTRUNW9WS2FKWHE4bVg2WWFUTEFNcm00ZTlRd2k4Q2tTOFlW?=
 =?utf-8?B?emsxbzgrSEx0dFNtS3MrdUZWQ3VLSFM5b2FTUUdydmxQY1hITlpwcTIxTk9I?=
 =?utf-8?B?NzBQbk9BbFJyYlM5K2JuNWtjQ0U0bmZBTFhDei9pS2t0OEFiZVdzcWtQSG9Q?=
 =?utf-8?B?V2ZZY1Fuekh3T0RqdmdVN0x0STBvNEdGTjhnbk11TkRSd0hkQ2ZmYTRqK0xP?=
 =?utf-8?B?NEhWMmZYRUFyRkI1YklhZlZHSVZUdjRUKzJjcStSNmpJSDQ3WTAxMTl2ZzRW?=
 =?utf-8?B?SnhMRzhNMGh6N1p1cyswTjdXNWtHYklvWEZFSU9LRnZEQkE1TzNTOFcvWkUx?=
 =?utf-8?B?TnRsbDBnR2h4eENFQ3VIWmxQUHNkb1dTWlkzc2FPdU55YkhlNkl4a0Fxd0lt?=
 =?utf-8?B?TVltcm5yOUp3aHAwSmtaOXlKcHhwdDBPVUNGMTVEakEyd0RHR0ZXTEluRlJy?=
 =?utf-8?B?MlozMGcyWjBVbDltV1dMREFzMFJiU0MxUGUvaWRWeVVFbnRkWUJIVUpWTE5G?=
 =?utf-8?B?RjRVK0ljYlJCWGtKWjR0R2ZVbnZXZnZETEdEQlFoZndXRHBZWldxb0MxMDlo?=
 =?utf-8?B?NWdob3ZDZlNvT1VIWGo1UEdKVkc5cXhISEs4YldvVWwvUk5sdUNHUVU1SG5E?=
 =?utf-8?B?cXh1MUZocTU5QzZpMU9NdkJVUThqbUVKZHZoWDRlbTBLQ0R3emFCdGY2Q3pS?=
 =?utf-8?B?ZjJmT3hQc2RnaUtRWnJhSTZsaEdtWWNLS1J4TW16VG9aclo5N2RjdlQ3VGpR?=
 =?utf-8?B?SXB4Q25BM3htY0NKYjNWc1JqZHBZbjVnVm1MdEFKMDJEYm5xYk1GcUJVbVI2?=
 =?utf-8?B?QXBBcmMrajdESVNPd0duenozRTBiUEZTREM1aDBuZUtFclNGbmJPemorWmR4?=
 =?utf-8?B?U0pUT0xhNUpXTzhSNCt3VGlnb0xwR2F2bEhpKzMzemV4R1FuUTNxV3NvK0Jk?=
 =?utf-8?B?YUp3eWNHVHl2eFZvTEpDajE3WG9rNzVjR3NLS1JScWdiK05aakJSZVY0Q0Q0?=
 =?utf-8?B?WTljcTlla282SVY0NEhzb0IxamJzVHZEVWxBSVN2TlZMRTV4eUJYcUhCSExk?=
 =?utf-8?B?Q1FkeXZKNFFkVHhSVkhqUEhHK0FMNnpqQndpSGl0V0ZKcW03Kzlid1lDYjBS?=
 =?utf-8?B?WXVGVDYzNUZsaGV6VHdHZVdJV0NLbWgyUEJ6S2tkVlJHdTFYZGRUbFJ0WVl1?=
 =?utf-8?B?Q1RJaE04YW4xbEowRTZrSGZZUjF1S2FQZEhhd0wvc3M1ZTBRTjNZc3hNRDRz?=
 =?utf-8?B?V01mbklPL3lyMFdsL2diTFpuMVhLSDBJWjFJUC9peUJyRWNiTEw1VUlJTWxQ?=
 =?utf-8?B?dzA2OFBmaWpzNUdYWUNFSCswT2dFZVVLMXI0cml3ZjdqWXhRQ0ozR2NIRlJ0?=
 =?utf-8?B?MlBXREU2UHJBaDVydW1HNEhpMVlEdzJKUVVtamNoam9SSXpOVHNLZE1NS09H?=
 =?utf-8?B?NDRFazUwYmQ5RHdxOFFPcmkxWFJodE9hUWJYSzUrZUNsVnhxdk5nYzVyVHdZ?=
 =?utf-8?B?Q3pwMlZLdDZrZERTUEJmZHMyRTRlcnpTWTQwY2JnZ3VFbWpOaml3dlN1aHVG?=
 =?utf-8?B?ejVMdVFZWjBJMzJ2LzZEamNCU2IxYTRrNHhjOVVvVVREdzE4czRPNGI4QURR?=
 =?utf-8?B?Z1BXbTVVSVVZZkYvbVRzRXVjajQzb05qT2pGYWZsQnFWY2UvQm0yNmFyUjhD?=
 =?utf-8?B?ZUw0c0VmdEtpSjdnT2JMTEhiR1MyU293OERWaUpNZUIyQUMyMVp0ZlZxRGky?=
 =?utf-8?B?RkF6RVVrcUNxdFFoN09wVXdpWURyWEZJdjRmWEJkMEpwclhJOUxBT3N3ekly?=
 =?utf-8?B?VGZTS0FqdjlVRXQ4VDNVY2RCZTFWSHFWN01NZGhIbFU0dHp2RnVnYUdsdW1S?=
 =?utf-8?B?eVZ0WXJURGdUWUlJeFBEb1F2Q3FYTEpMcVU0eFpiTkV6eVdJNmVNcDBlL0t4?=
 =?utf-8?B?bjJYNVNTK1FjOGttb29hRXVnelA2dU05UExCTVpRck5kRFdYT1hPSlBxaVFR?=
 =?utf-8?Q?6m47DYTBqR81+RLP2M+DgMC/I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00016eda-8f80-471b-77eb-08dc36cc84d4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 13:12:01.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nwEMf7FV4Bn968Jtq76LyKzrl6uNpIlJMcZFQ7mn2knoTemnuojakn7lV/EEq1/7emzIkPn3MWnB3Nj7nFQRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8185

Add a minimal i.MX95 dtsi and EVK board dts.
i.MX95 has a M33 running SCMI firmware, but as of now, the scmi pinctrl
driver still not ready for i.MX95, so we count on bootloader to
configure the pinctrl for lpuart and sdhc and it boots well. After pinctrl
driver ready, we could move to use scmi pinctrl.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Addressed Rob and Krzysztof's comments, and fix dts_check issue
  To pass the dtbs_check, need apply:
   https://lore.kernel.org/all/20240226070910.3379108-1-peng.fan@oss.nxp.com/
   https://lore.kernel.org/all/20240226130243.3820915-1-peng.fan@oss.nxp.com/
   https://lore.kernel.org/all/20240226130516.3821803-1-peng.fan@oss.nxp.com/
   https://lore.kernel.org/all/20240226130826.3824251-1-peng.fan@oss.nxp.com/
   https://lore.kernel.org/all/20240219-imx-mailbox-v8-1-75535a87794e@nxp.com/

- Link to v1: https://lore.kernel.org/r/20240218-imx95-dts-v1-0-2959f89f2018@nxp.com

---
Peng Fan (3):
      dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
      arm64: dts: freescale: add i.MX95 basic dtsi
      arm64: dts: freescale: add i.MX95 19x19 EVK minimal board dts

 Documentation/devicetree/bindings/arm/fsl.yaml    |    6 +
 arch/arm64/boot/dts/freescale/Makefile            |    1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  115 ++
 arch/arm64/boot/dts/freescale/imx95-clock.h       |  187 ++++
 arch/arm64/boot/dts/freescale/imx95-power.h       |   55 +
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 1177 +++++++++++++++++++++
 6 files changed, 1541 insertions(+)
---
base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
change-id: 20240218-imx95-dts-aae4316671a7

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


