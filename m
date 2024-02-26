Return-Path: <linux-kernel+bounces-81455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BC86763D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C8EB240AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7565984FB4;
	Mon, 26 Feb 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HlHk3LHC"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE761678;
	Mon, 26 Feb 2024 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953139; cv=fail; b=Tk/0og/s48gaN8GU/KT1X6rVI+M1+skHJAQB0TMhMwhcgGbcRWmPEqUjr4fzeOLF/YqwJz3Q4blsTjoGDPv3cNQ3Szh5kgqvHOFkW/Cd/cgY9L9bMS0u0vRAgHkxb/tdajjd5HvcOp5imMyb8zw0kusFzVmQqXnpudbeEsB+hOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953139; c=relaxed/simple;
	bh=+aAYPpVS38pB0AjV7zSDgJfWBMp9uCvbgC5w16mNE1Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rS8moTPpKFPA/Xx2BGztdlhGTjiA/ZqUSDLAgEJ9RnZSf3isoUsUjCt5XI6POKrCPx49ZP/wDo0DRvWO5O6erajFsvXDoWg7lg/vpAOKuWyQZtXYs7cyUvUBHDr/9aOfcRFUQ29prGwxWVQO8acY+Svlz03ZZc96XF6jcShhaH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HlHk3LHC; arc=fail smtp.client-ip=40.107.14.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDYqXY4XuTwA7L3qx1oplRQVSP6Pv/H7JZMQudDzFrEqAMMO1rtjBQcv7jK/kKfgbIxv14D6a76naCTCh27JHr40XP9fC0ZsB9elyXCclOJgxItl4Nno2o8FEfrJcM3uM/HUKvdupNgDiX41VY9HuqCvMahCc8niJTTGsDlxH7TWgnC3ZfCSXawPJOjhfx6fNvzGDho5wBPyBbIpEYNQvqeDjKEdyZIdA5rpDvQ9KdTbWo3oKxDnWRdLHh64mxH7YDwyNhcHB6XQaqbV6j5IuftrmTl2eBYAlFcFKaXEb+PHZGZ4S5VhX0+9uSfKm/XeglvVbr5pLvQl9N+6dDyGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v0eXBcfiu15vUxdy32/0jKYbUrRXl+9Vr5ZHg6q9Yg=;
 b=K4EKDPysgS+BJaJkB4pQ9tIzaMyDx7sZSg5+yEGmgP3LRlFYjt87lOUyc+tlCnaVw0Vu7p6tzwbzn5JOzgi8lW/5WfK8ZtonTbGwpjNB2p966llWsTPrfFPsDJU9lGEK9AtHQHxat12GAPSriLz1dE6LtFFGxjwzcGmsciwEOGKUotd1dgjZ3P/2a67cxfzN+PEKGn4Kg6/1xZlgE73eEG2hPWT5JoZVh1LPerch8mqJYqsg68rfrwyhZeqThz7+jIuOTWJysNxUqN/gBJSX4cKWHoX6+SILKByL0JmwG62hO1ZbuqvT2eSxc3TypEPXOA4yZ6AvRfPXOiM7bS53fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v0eXBcfiu15vUxdy32/0jKYbUrRXl+9Vr5ZHg6q9Yg=;
 b=HlHk3LHCS5wNJX9A+G4rdeFZGEuSQHuqBh/Qqji2N3C9Q9IjRxQLM0N+FV3e92vc6tNpTA577FdlN0OOL64if7grlP2Fnd1O+F+/+DUh27+mUTgIh60qYe54XS7CZG3UtHZuFjMABqb72Ylkt0HiyfAwtHiPBvtxk2t6AvKg/hs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6903.eurprd04.prod.outlook.com (2603:10a6:20b:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 13:12:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 13:12:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 26 Feb 2024 21:20:18 +0800
Subject: [PATCH v2 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK minimal
 board dts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-imx95-dts-v2-3-00e36637b07e@nxp.com>
References: <20240226-imx95-dts-v2-0-00e36637b07e@nxp.com>
In-Reply-To: <20240226-imx95-dts-v2-0-00e36637b07e@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708953624; l=3563;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=zNZu27gZRyyDdsvY8YsKvNZ3I3fm2ZdTSwV2zyxhD20=;
 b=/2WNVjbBBR1xqBCwVWlEZFwTzaT/J43hG4uXGcLo6WlZiOEowlYlq+tW2lPGCYWGcqT2eELDW
 l8yQC7BFTZhBjBi+OsE3/fOvfQQorji/WbPYey/iw87HFmpvTOOp+zF
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 72aa0d12-5b95-48e7-42e6-08dc36cc8c0c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EQNaGTdBfIwHyas+Ppskl/4MyNY9mYfLNUEh0snjNX6GUenBXQV0AiSd2smmj6TU/f/xkMiG5Y68QX+7WRn7luc/NlkRCQGrRoxDTTmnovVnv39+fNZYFzBaOALiAMI3+FGVuxd58FMGKuA9u9QPXDujH7Yaxi29Yhr836205tTTMbIPXD7zipVoL/yPeG/hqexerV5ZSoZ6K7pKQwXgcivD1BtGvRxBoJEXBG4pnaKEU0Ju0rmIxh7aqx3WxVKoENMwUYjJuUHFMPxiUXMotAZOG+rAj84/TcgsS1njgYWkAslhe59K4yLF9TeJbcDua+LyK2FD27ft68Zx2krfP2K0vKaos0A7w50/CVaz3b10zW7PjVPqZm0ELfk8f+Sw83fM/P13BP7cDds/cGbGGu7fYvTBeGofcUujxgN99XxJruDXDK6wyJzqnx82b6mBakbAgNHjLYiuDTSSeFTY8LcfsUh33cs/ifltBkcyeWbqz5tp8QIQOSVLNMsWhIfrNVxnJPGXFoNtvb0/HbHpAzzssLylZOSFve9f/cmcFcuWki1JpbJC16/ibfv/vVbZc4YlCSvwTR/afFXTGXYY8HwCjQ+Ry/49yYZ0LoL1WR4byaJJPIVZOjOpMpaANePL3jrx5aRNO4fimePvMNOCsM0lJYgRknr6b+h0XmPP8KkpgLflLnZ1ghqRfIX9AV0VcRuv4ep/63rzQnfXA1hXwmGOBzWainjosG4bEvPVMBs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vm93eUYrK0prbTBnNFRtcjlIWmQxZmxHMXhYd2FvejZlUXhDYTZubnRwMjRh?=
 =?utf-8?B?Q25sRm9lV2oyNUk3eDE2YklLczRvbXlNOUNFL3FsOXBjVUtyQW5GRDJ5ZURL?=
 =?utf-8?B?SGRqeGZsOUFZOFBOak41OWUybW01M09Gcnk0WGlkWkVnSXA1d01JUUxUdkJh?=
 =?utf-8?B?azVQcUFlb2JpbXR4WFUySzc3aVJEY2IxMkhCbkVFTkhiL0o1S0lSYTFDYWU2?=
 =?utf-8?B?TU4vZDJTOFpTdTlLL2NRZEZqZlRKTmJIMUNKNVFVZEhwc1pRT2pmR0p2OTJY?=
 =?utf-8?B?amlBQlBzWjU3RStqTFBqdHhBYWhnNjMzcUhsZlY1eHlJL3F3aks4UVFjb3Zn?=
 =?utf-8?B?SmxPUWZ2MGVmbStySmcyaDJXOFdraUVadkpLb1J6N1l3blFwazdmeXVpenNR?=
 =?utf-8?B?b0swamc5OE1qUUg4RjdxenNnRG1nRlBEaDR1a3h4dGVWRlRxNjZRVW90RDBw?=
 =?utf-8?B?Qnc1eFpGQ3Q4Tnk2Ri9MVURzMHlqeThyVU5ZQ3Z4V1Q3QzNBREJxVlIvUzI5?=
 =?utf-8?B?Z0hlOFgzZW80QUFxdit1TG1va0d0Qk1oVnZxSW80QzNyRVNLUUl2dkZvV3F6?=
 =?utf-8?B?UHZvU0FkSDI2ZnF1MWtEWVQzQU1zYksvQTN3TXpyOFM3Y1d5QStBSUZoc2RY?=
 =?utf-8?B?U1FCOXVDQkJINFZCTUVmajY3OE9aTkw4OEdkSHRjQ2xrZXRaK1hYY2doWGRX?=
 =?utf-8?B?YTlUb2pIV0RnUFk3VmN1T1RmV0hLMW5qZ2s1U04yN1NkcFYySmVkeStDRmM4?=
 =?utf-8?B?VjFJMFBhWGVQcEZ5djVweFhHKzllK3A3elZzUE9DQjB5YUNENlZpeGxGV1ZD?=
 =?utf-8?B?SVBLNy9jL1NkekZ4V0hXY241MGE4TnhYM2JmK1UvYUZDa1JNbGNGOWZadGxK?=
 =?utf-8?B?ZUlSdkY0QktCRFhiQXc2MDZlOVZ0My9Hb1REY1crR1BDWk5JTGI2Z1ZVV0Jz?=
 =?utf-8?B?eUJqeVdQODZJa1FtUWZGb21iSnorcmEyYWxXWGo3UVY4TERyaXlkWXJEQXNR?=
 =?utf-8?B?eFE1TFlZNmJ2aldYS3FoejVPbE91cGJKbW1jZWtGa21VVnhGM09rUmY2Smcz?=
 =?utf-8?B?NjVITjd6ZVlKZExSSVY2NjhjaEdNQ1VoSk5IekdndXZES2tlQ2tmSVRQSCtK?=
 =?utf-8?B?d3hIN3FERS8yYzNTWWhzKzVSMUhqTWhKL2E5R3c0N2RaSGdtdFEvSDZmY0lu?=
 =?utf-8?B?MVNsbjBvaDdqSWQyemZHd1pZdWFUOWtWWlNQeG44MnpqOE1VTENEMGRZNGcy?=
 =?utf-8?B?SHEzUjhCek5oZ0IrMFFmbzdWNTdtQWU5WjNTdytUWVFnaEZobG9vUi8yMEh6?=
 =?utf-8?B?d3o2L1RvcjJ6Y0lycFZRamdtRnk5aTUrSGtJWlhQYUdyK2JoMmFGU1ZpTThU?=
 =?utf-8?B?QXZGOGt1UXdvTExyU1UxSVlDRjhidDYrS2hoSVI1dGhXR3RUdDZJSTJwUWdz?=
 =?utf-8?B?QkkwY3lmOUtBa3VveUgrUkR5VFlFQ3ZScHdibmxMeUVDUnI1aEFwRXhnUGla?=
 =?utf-8?B?R3FDVkkrR3dHbys4UWZNNldqeUNSTzNSV0c1UG9SL2h0bzVxbk1ZZC91ZVZt?=
 =?utf-8?B?a20wbUl6cTZyMjdQdVlKVWhEUWpOSE9iRHlPaE5qQ3E5N3AzMGxEaExwSkJv?=
 =?utf-8?B?MTZicW5kVlZTSWluYjE0bUlCa095dlV2WHdzR05yd2tjWHFYem13K1g4SGFE?=
 =?utf-8?B?d1h0RTNrVGI2MTlGeVQ2eDNhMk5CQW55a0FXYUwyb3EybmV2L3dPYjd2cXEy?=
 =?utf-8?B?RjZUeFREMC9sSWVRcVczZCtmbHhVOVJjMStNeWE1Q3J0bmt5bDNISktmY0RE?=
 =?utf-8?B?S0JrWmpPMXlkTmdIRjFpK0t1aWJHZ0lKVnk0VTBldVJ1WU5yS3lMNnpSRUxQ?=
 =?utf-8?B?R0VDWGR6dVNENWs2M1YvZDZEUzl2a1ltVEl1YUI3R0RHbFRweENmODlwZVVm?=
 =?utf-8?B?b1RidmR0cXFFckMwa0YrWTRBUjdBMmluL0R4V1dxQi9VVzdnZUNnQlhhbzQ4?=
 =?utf-8?B?ODRrMjVkWi9CZHQ4S1lPK1MvVTlKOUFBY2pNSGlzRHpsT1YrN0R4Q1BWMjdH?=
 =?utf-8?B?ai9HSzI0TklTOTBtb0ZCK1UyS3JsS2ZBb1l6V2tYUHNZQWlnNVJGRmZsaFcw?=
 =?utf-8?Q?2qHG2lzXCMgI/8dOJqFikG7wn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72aa0d12-5b95-48e7-42e6-08dc36cc8c0c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 13:12:13.2289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WbHmz1zaXqWueoLTkxwJb4IV2/9f1U6cJ5Njuz+tYkjlW57JlzWYzOl73y6Nsgu3NmoVcxaX/lCrCwmYTmlww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6903

From: Peng Fan <peng.fan@nxp.com>

Add a minimal dts for i.MX95 19x19 EVK board:
 - lpuart1 as console
 - sdhc1/2 as storage

As of now, because scmi pinctrl support not ready, so count on
bootloader to set the pinctrl.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |   1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 115 ++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 518149d295a1..c830ff88f5f8 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -209,6 +209,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
new file mode 100644
index 000000000000..ffef1cd9eb92
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include "imx95.dtsi"
+
+/ {
+	model = "NXP i.MX95 19X19 board";
+	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
+
+	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+		serial0 = &lpuart1;
+		serial1 = &lpuart2;
+		serial2 = &lpuart3;
+		serial3 = &lpuart4;
+		serial4 = &lpuart5;
+		serial5 = &lpuart6;
+		serial6 = &lpuart7;
+		serial7 = &lpuart8;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0 0x80000000 0 0x7F000000>;
+			size = <0 0x3c000000>;
+			linux,cma-default;
+			reusable;
+		};
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "+V1.8_SW";
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&displaymix_irqsteer {
+	status = "okay";
+};
+
+&lpuart1 {
+	/* console */
+	status = "okay";
+};
+
+&mu7 {
+	status = "okay";
+};
+
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&usdhc2 {
+	non-removable;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&wdog3 {
+	status = "okay";
+};

-- 
2.37.1


