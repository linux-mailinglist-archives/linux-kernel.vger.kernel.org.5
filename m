Return-Path: <linux-kernel+bounces-147106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D4D8A6F93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AF21C21322
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF991311AC;
	Tue, 16 Apr 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G4N42Grm"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398B130ACF;
	Tue, 16 Apr 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280737; cv=fail; b=LSsXg3hp/Rs6VA6Oxj8Tcqnn5izN18Rvmq19LoktouGvXqM+NbS8LbwWvGEmnJ7EKkTjcdYMsHNq6Os+opsQDDpNUGfcY3t29reFDPxTS6df6a+DICp+gDNP0iQL7kVSWkAVAS+Mv+vZIrOJJvglu/3MkDw3rQMkHx2xf7uabZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280737; c=relaxed/simple;
	bh=JsIIh7Y80cAOz4WoF9AmblChvGJpEopvvP41b0iSatw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=YKBpDfUf7TdNPk8Hts7K/kL/TgyoV37EykabHwhNfCsdJa7ul6akn5qEudeH/VWIncvoTexViuLQaCeGFdGGElIEd6X+g3ePrwklwUcGV1BEZGALQlM39+JzrHiyjftMFMg6oLqAPYgJ4gRY9kKKxovXTLUUlHqIz1YfD7z62lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=G4N42Grm; arc=fail smtp.client-ip=40.107.249.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GumBoukuvSF5v0g6DFSnPIDNwrFTYaGJz6kC3yi8eklo7YHCnTHTtG5MhWJrasVdLMop+DvrDxrhtKTMrUQHKKMBO1gw7c+bCoNgqIHfgx9/+g47lxDMgEaIGFmVdLcbtlZFEaQHxVQFAfedsG9SsnWut0vWBbM3Ly/FusIM1DhBJpCGgF9pJetoc6OysgiNrdHaNb6wkYMkuRxlGYg4O603XNFZxtDv7x3/UA6BQI0ZU2cjdMprNdMBlfgx3Bv2KQRXnvish3ok/SH6+VWhKY+CyapM/OSnGctmRdDNFPBy49/ntXciSFHmw9HX4avQeuVs7swJn1W7oNMCUNb63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIiPZgx437rXfo8+Uxf43NySzKtZKVzSpnlZrdBaRek=;
 b=eP/BGrfS4etZFPuT9eG1pGxqeRLEMyTn+1cb72Hi7mP8wZ1dy8Zt/hGOUcayO/Wh1CQ2nEYVKURn/MF7hFn7PfNBDArKmbCD50aUkbyvoJL0WGYN7BLeUxr5zDyIcoVOPsNYCmlzfS0jIwo/oOuAk7DWIJ9UOyiEM+Y4rq5xxooCXpbvQ/28l5Z/JArXDxIgfWUvmtanClu9kzaFhIriQYtrZt7Hr4RIH4rj0mghoS3lmNX7CZffSELcBg3OJepj1C4MUzNab75pQAbSh/wN9V/Y8zNkuyFI7ppivZPE46nYGHtAJQLK/o0Qxeiks9mTgbldKOLh3ORUPHTByZ8pJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIiPZgx437rXfo8+Uxf43NySzKtZKVzSpnlZrdBaRek=;
 b=G4N42Grm5khfI36wGodmMS/OXJJ5r3xBgzwjrzCJloZDLRcCfg0ZDhojg4eM4MIBgNkK7KygboRl04apwSP3SUKMG+uh9tme1titCzCVE2qTDOm6G3qjpBSw2VlHhhj7pt13RfYNmStU4gm/EkKOuvr8GlgxZffYlmTkM552Lq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7039.eurprd04.prod.outlook.com (2603:10a6:800:12b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:18:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:18:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/11] arm64: dts: imx93: various update
Date: Tue, 16 Apr 2024 23:26:36 +0800
Message-Id: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKyYHmYC/x3MSQqAMAxA0atI1gY6IdSriAttU83CgVZEkN7d4
 PIt/n+hUGYq0DcvZLq58LELdNtAWKd9IeQoBqOMU05b5O3xFuNV0KGwU9Hb4JMOswGJzkyJn38
 4jLV+04gmbWAAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>, 
 Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281223; l=1709;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=JsIIh7Y80cAOz4WoF9AmblChvGJpEopvvP41b0iSatw=;
 b=t0kSrZkLyh96LDTMiu7FJ5X8Zt0E/VBETegwvz8PhDhaaMP6hI24PNGECWn1Ch8Q8IgGQBgly
 ZeBWD+AVjE0CCqadm9Hfe7S9+P7WU4Ykk8tZVrsQr+8cnSyuethgdsL
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f1ea3d-1f3c-4dee-d33e-08dc5e2885cf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZU5PxCQPckFsWVde9bWTxLz4VGfFjE5JOJPwoxdxaGL22fhqJrJRO7gNduLtSoHCbtiyARheA1cXjw5yDnGhLzZMy6NXT+BchOj+WclBCiKoZVtUi9KUpVUuyuPG8KgBSFIOcbSWSm0p/owUcueo9oKb3wBzVv676o/Ofidhr86El7kfRel8lLMWhBstdtUWjnerkA766uzdN+/9zq+ns56xohmZ7+oYqjjqMBlJA8fOYKUTQ9Us3gwv/HCuoSYB+l051X8xT80PS/M0kNbeKH/2YJfQn0DFsV5yEGQmhE33ea0kw6R5muUSaxK57LVADtiGCBxu4xegilMb/1qwQVmu2L6C92V+4vJAhEGKLAwgA6JbLi7gu33NLsztYfnyI8gxQr7q/jQHLnWAntzsWW/ztW7/b21Dx20AY4pobFulgdGN0tGCFCy1M8BlteBqainE4DKT1RFuJhk3Hj1iRIHHhw9MzV0Bp7aWVyUBuctTaJ75sURe5ojTF64hjzc5bVcDmObiq6oJ8BIfjkMRF/xmY+8tY6asfO66lTdAYSElkKmABdmw9oMLCmpzw6/DR2AqY23jLicMmEO3O3YYDDNZ3Zdw2WqhJhKZIDa0vuZGgSXG0jQoE93nsDvCj/ohn/e/Jug4ti6aYEYfgBGuaZvo62jiGXOQ7qj6IhLrQKc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2hDQVJjRG0zZkd1bGVQSVJiRTNiL29JWVk0YmQ1RFFpbzR4eTk1VFVKZXFa?=
 =?utf-8?B?NGJuTmJ5ZXVXa21aVEYzSHFRMjB0UTZNT0N4dGczc2didXRaNGZ6VVJNaXYx?=
 =?utf-8?B?TmpQemJISGFaN2k5UXpXMWpjUVVFWEdzRlNGUEliS2t4ZEpUZHZIcE02YTdF?=
 =?utf-8?B?Q1NLMmJNbGZ3YlJ4MlZPT3d3d0dmSWF6L2s0WEFtQitkeHB1MTJCZnhwcmw5?=
 =?utf-8?B?Szk4elBGVnNMb2w4QUgyYXZwWWw4dDY2WXZWMkM4QTdVWEMrOS9Rbk8rMEFT?=
 =?utf-8?B?U0dSQ0ZkUllETG1mMzg0Vk9Eejh0Z3k5cTQ4b3NMY2JwQVBHZUIxb2sxVVMv?=
 =?utf-8?B?RWJoRWtUcmNLUHdWTlBxUlJaOStwZmdGcXd1bC9BTkZQZFJPekRhODY2U29M?=
 =?utf-8?B?dUxVTkJ5SEM2VWlKR0l0WHowZHd0RzkrNHBDVzdPNklUODhGalhxS09FR0NZ?=
 =?utf-8?B?YU5xUkdEbnU5MlNyOHVTWFhocVd2UTVBY1A1L09OSHNwekMwZS83Q3dEM3lE?=
 =?utf-8?B?Sk5vL0pjTGFBRy82SFhTMkRCMU81ckRVRDJZMC9DRW82ekhMdXYwcFZhRVJh?=
 =?utf-8?B?a3FoekNVaDJhR203OUQyNGpqMmNQUm9pSHdtcE9Ea1dMTzA2c0hLQmczbkg4?=
 =?utf-8?B?TnBaWmJEYklSVzNabXU1UmhSUkpSa2VtZG1zRUpWMlZkUkVuSUNOMlB0N0d2?=
 =?utf-8?B?ZFhuTFV5Z0pzRVltTVdxZW5GOXVUMnpVenh4cWRWaEN3bnBXc0FxYjdKa2ZZ?=
 =?utf-8?B?MDhYR0FKVmUzTmcyTG5RWTJhMVNDQitUQ29nRGprTzBuVGRXbGszb1RxRXVv?=
 =?utf-8?B?ZTdQK1ZwM2pnRXFubFhjeWEwcUg4Sm9OTjZxSXpheVlTZkIxdXByRXVGVHFU?=
 =?utf-8?B?ZHlWNi9FaStmT25HWlVsQmpvNlN1TmU3bENDdHd3TURvSVNqbFFHMHUreElI?=
 =?utf-8?B?cnVBM1B6bURlS2g0MUV3bXFhV1FnMDVPdklEUXNTSkZKVW9kUFMrMDg2bWpq?=
 =?utf-8?B?SmFNZTRqN2NhaGtlNTRSUW0vUHdZdXBTWXFCRjJNQ2pvUWN0ZFZmK0w0NjhM?=
 =?utf-8?B?RjVMazZhQThGZ1JtOEpGNkpiZmlrejRWOEpiTW5pWmVVdHhGTnJDSkdkUGFT?=
 =?utf-8?B?WUtrOWJVMGd2aHlJNm84dXFJb1A0ZkdpNitCRU1EeVdyU0JrYytFaU1vQm9k?=
 =?utf-8?B?T1hPcGFOVEZuUmNRS0srZlNaRW1BSllRa00wYnNKMmpjUDF2VGZpR1RGSCts?=
 =?utf-8?B?VWlqOWxZeFJVVnBneW5lZGxYa1F4YTcwSFBqVGZ5RkRQM1BsdExIRGV2VUww?=
 =?utf-8?B?QlBOTmlSS2dHOHBlc20zWUw4MElNU3hzVStvTkg1ZHNVb2FmTmViQVRBMWdJ?=
 =?utf-8?B?K1dTOHlXcThOVFM2bUt1a21rY0tqOUhYUmVNQ2ZqMk8zTkI1WGVnN0RQQXFE?=
 =?utf-8?B?cW5HU1lBQVBPMUZmdFNyeTkzaTRSTHM0NVZwak05UVh3WXUrYmIwWk5IckdC?=
 =?utf-8?B?WmtvMFFpWFUweFBXMkxwNW9PeUQramQ4aUFyaGsxQVVZQ2hiYTNtUG5zeEVn?=
 =?utf-8?B?VG9QK2FyUVRKbmFmbTNqS1ZCc1JYb21UTXlqKy9GOG5JMHkxUkNOa3J5S0xT?=
 =?utf-8?B?TlpKTFpJNmFVNEF3U2ZiL2dsUjJ1RENpRGZqMUE1VjREdUp2SnM2bTVKa05x?=
 =?utf-8?B?WXI2ZzhvTmJqNCs4K3J0TUdLMXRUVjIvdWFTak10UmlHclEzTU9NVzRVNzIw?=
 =?utf-8?B?SDROanZHNmV5amgwZWR4Y010cVkvQm14dy9BdFlhUGUwUmhsQytLUDdvOG5r?=
 =?utf-8?B?eWdnY1Rtd2Q5d2haU1p3MzYzQzZtWFRsVUd3eFBmbHpIT1gzSndETGFWRVhH?=
 =?utf-8?B?RXVINTJxR29nQUsxZEVoeG5sWUhwV0wyK2NEbTRnQk80QzhEbHF0KzBRTTFX?=
 =?utf-8?B?NmNpZnl4Y3FFcmlOSEt5NjVoT081RUpvUTc3bVNiUlhOS01NWGcyN3RrSmtJ?=
 =?utf-8?B?RE9Nd3VtbHEyemc3dDB4ck5iWFd0SllXYnMyRmhTNFZZZmhXL2xiQnYrUGV1?=
 =?utf-8?B?NURJUzh1VFp4M2pGM05VN1NJRTl5ZzZHU2JPRVNjaGQ5ZWJxbXdMUDgyU0N6?=
 =?utf-8?Q?UNnxpgDmdXHEk2JJPpoSOkKsv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f1ea3d-1f3c-4dee-d33e-08dc5e2885cf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:18:51.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOr+fMBj7GRODUbzI3UflfMapThmBHzYpjUcnoRPoPVn5oBY/lJd/A7S3Y0gvRmY8qfXNg1yOPHybtxP8AWhWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7039

This patchset has several updates in imx93 dtsi and imx93-11x11-evk dts
- add dma for lpspi/lpi2c
- add nvmem for fec/eqos
- update sdhc assigned clocks
- update resource table for m33
- add sleep pinctrl
- add reset gpios for network phys
- includes a defconfig patch to build in OCOTP ELE.

The nvmem binding patch got reviewed
https://lore.kernel.org/linux-arm-kernel/20240415-limes-chasing-dbc111fa9cf2@spud/T/#m930c2b7b7961a3640e70ee8c4b4d26172baa03ce

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Haibo Chen (1):
      arm64: dts: imx93: assign usdhc[1..3] root clock to 400MHz

Luke Wang (1):
      arm64: dts: imx93-11x11-evk: add different usdhc pinctrl for different timing usage

Peng Fan (8):
      arm64: dts: imx93: add dma support for lpi2c[1..8]
      arm64: dts: imx93: add dma support for lpspi[1..8]
      arm64: dts: imx93: add nvmem property for fec1
      arm64: dts: imx93: add nvmem property for eqos
      arm64: dts: imx93-11x11-evk: update resource table address
      arm64: dts: imx93-11x11-evk: add sleep pinctrl for eqos and fec
      arm64: dts: imx93-11x11-evk: add sleep pinctrl for sdhc2
      arm64: defconfig: build in OCOTP ELE

Wei Fang (1):
      arm64: dts: imx93-11x11-evk: add reset gpios for ethernet PHYs

 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 146 ++++++++++++++++++++--
 arch/arm64/boot/dts/freescale/imx93.dtsi          |  54 ++++++++
 arch/arm64/configs/defconfig                      |   2 +-
 3 files changed, 191 insertions(+), 11 deletions(-)
---
base-commit: 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39
change-id: 20240413-imx93-dts-4-13-60d93c9f1cb2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


