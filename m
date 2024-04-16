Return-Path: <linux-kernel+bounces-147110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E60D8A6F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158E81F2172F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D06131182;
	Tue, 16 Apr 2024 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hXZ3mtcW"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7CA131E33;
	Tue, 16 Apr 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280754; cv=fail; b=DFiQ7fyIY0kIQhN+P/0QsE6X5EEQsqAHsAVJ6mo65k8H/ieF3rZXgK3YXb8c5HXKv3k2TiN0c2gKpnWlhskk94ZuVJXRSYa9dJNgnszZgrs6nP/GXeAdvEeE5SPnQfVknLFlJz10GVrOx6//vLwGoH3dKXFnBqxSOOsbXcrCIWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280754; c=relaxed/simple;
	bh=h4vgkasPXvnp9aXHiiq3vWW+733OPrwVbEX6EEK4ZN4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=d1p+OwNbcuX8v4T1tZX8ygKibefHuFZNSewUZ1Ki7cvPK20YRBuOsZn6Yq2s5QKVcsZSNwnz16ksWWBpBZBsSi5mdDR+0sWHp9te9PeSz7WL3arVHtOcwc1RF6mOFFWgAXdO8TFuGf0tVfN9cPvHrXQbTuRK/ksER/5UBMNubQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hXZ3mtcW; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJYt0I5IPl6GtgvnLr8R1EmUyV+Due/+aq9Uvn+PMuZ6K94ZsHq1nDqpZ/LXg3HKRSkOy7BfO8e5o0tejN3COUnY+tJsC3jC4sUd/9pYkDF+ocbKoxJvZjtK/JUIzbfGb2mGwJExzFuK5RfEl4a8Gnq3OdpI8CQpjI9ym2wXyWgp93ZGWCv6XzA1Vf4DGVOh/l/jqBwUCmNK8Lig2P5EpSuvlQretQv3mOdkGJev4kD9KNMEMa4pF/zU3Y+MlqOod3RZhKRTt9jqYpwuwGYAAqYcaumlDp+/YpdwTw0bf2HVxWotMlLXlw5scnwZtgzhaXDXkYFp5EPQrNyXOjXX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPCXs3YT4FToZvDeU5ULKgKOGkSYbDX4qZUMPu4Sob8=;
 b=Iss81yyZcUm5AVyTDreb2KOrbfuGvIUARdtwKOLqGh9QPPp8h/fbfg8mfjfIixe9w223HdkvXzSvm1iqjc8TnHllq9jV9f+ZBUUKOhdtgkldYrLG4S4A7WyvrcNr5pWkg07V0iqgpF35JeXW6A0ygKaI0z4mQPAjwYSl2Aupw0oMtfmisontPtI2ZAnoQhqaQmDNge73Sr0iT5noekeG0yy+EkBBJ5UXh/eIXzYMSgX1ghD0lA4e9/s0e/29zyd1DBxNyVzH8N8FJmnYUffZrHq87uDZ+iQK78bywD1sy3wjAI/poPy4YP+hGksmSRGIQFKulOTDQKy3hKdi0OygNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPCXs3YT4FToZvDeU5ULKgKOGkSYbDX4qZUMPu4Sob8=;
 b=hXZ3mtcW6O5HbibrVSh3odAVU4aJEif7vd9jNsaVx0Vhxt8ar6CuVwzo2chTrPWgL88UJo6cHppzX0g194jYE8ODssKcsrr3dK2dv0OiVetP2OIJThUkuBqpuOPzaCyAtGX/G6xlTgIqI3lDLG3CLwuJpGeKHXDB7DaF3itoJDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:19:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:19:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 16 Apr 2024 23:26:40 +0800
Subject: [PATCH 04/11] arm64: dts: imx93: add nvmem property for fec1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-imx93-dts-4-13-v1-4-da8ac02e8413@nxp.com>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
In-Reply-To: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281223; l=954;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=JLTOuCLoI8j1TNY27GmZ1hdlZ+YhirB+Br5tAz7LGFY=;
 b=flOSy/Sh+thMPSgc4Q+nyGRzEOAMeUdq16KGeyaWOKD+6K0fd/4YGm/0Wjwn5e7vIlmjFHeRg
 Mzh6GzU9xGLC/gYcVMBlAzzVea4iza+2H9HrsaP+EhcHkliyg2Gcmf2
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d92526-734c-4055-122b-08dc5e288fe9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dt0Z92JoMxfZwL4TYkaZSCIInccDQAb9kBo7CquUQ89lKcEi854ofYIzHpRBKllU3KQHEx3PSGfTd/3FwH4AOk0kYs4lb/SBTdBvmj/NIGXHQJg6M/LBvwdKyQIfetRsQMTwy4ROqCxqVnlNTrMRvVe/mHv8CVnXU1dOtZ9BmEuP+HHmkAaNwiTFt1Pz4zkYsdTt6vLOTrey5Nr8PVQRem0lPyHhlmLo4fgAfOT8SwFjb2pUoIkFTAdhgDLyk+yT3otrZ6z3g3WA0ayDHGuqsuesesLX2ht26rWAPEfwS09MewIn3pNZANjjdL9rDb+fkdHDy6n4EtLUbOz4XwlTkPQil/Gc5N0NzenOr1J+LE/cAkCcV+deAiQTjRHKjX5VTYnt+Qgy8ASgGf7O5yh6Kucuy1ghbqz0bOyWx3Ezg4f4wluisK5kLh8N+jMEARS8JinkR5KY/byNTq1A+DRIhoq/xcK9pOeJTRXz65NfNMEMGwAWDg5IsZP7TqUD73p8jiWaXS550nEofq2oRCvgsooykZv3YTVPAE2N1USS4V33W0vQl/wO9atWD7ftsBXx7o1/Rt3SVC2/Y/fjl2uNpCwgqjKdYSLCx9+zB9R8lG+cFuHv0/ZPmcZe7wZIhhKfjn7L14pnOV42dMgEl2Bp1dHzaf/+121w+anKA6kjcBH2W48wnHgQ2XcLeYvDbbJfg8jB6jKagUgZlmjj94dvkxcjtlcXOtVB1z0xJzaCyC0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVYxYXA4dytvejRzcE5zYkg5QXZPSytpN1VvZ1N5Y3pvODgvSTNVQUFOY09z?=
 =?utf-8?B?eWVJL0xMdDM0YVJaNzRuT1F5YzNyMDIxaVYyZFpROGU2bTNSQ1N4SVNSYVNk?=
 =?utf-8?B?NGx2MmNUaXBIcndjTk55bkJXYTk0WHg2RzFPazlQcndQVTRqVFlYQlNTMkxw?=
 =?utf-8?B?NU9Pd3ZOMFVTOWxienlXNzRMN3BUcGd2b2xNVU9zYzE5REwrZWdUTUZEenFW?=
 =?utf-8?B?Q1d6V1BPRkpkRVgxdzlvNU94RzZ6bGdVMTkrOXZEOHY1RklNeGsvdE9Zajcv?=
 =?utf-8?B?ZlNHVEZrTngwQ0poeUQ4Z2lMbUkzWGZnY3VLeGJxVmZoajlaaUcrUC9VOGJj?=
 =?utf-8?B?SUZVU3gwSGY1OCt4YWV0Nmt0bXBRTTdrcWtwQVFjOU1ndkpyK2VUYkRnZkhk?=
 =?utf-8?B?bUtIWVVNelZmeFNnbVJFRlRva1Vqd0FqMFFSK3k3TmZQOTZjcERjcDE4Sk41?=
 =?utf-8?B?bjVvVWZqcUUvSnhUTUxBVFpDem5Dbjd6ZzEzRnpmQ0IxNXZUbitZaVdxNWtO?=
 =?utf-8?B?TVZXQWl2QUVwVGhNaTNYUjZhTmZXQWsyWUNReEVRWm94QWxBSkplQXpPa3VQ?=
 =?utf-8?B?NHZFK0NoY3RWcGx3Y3ZOVnh4SzZvRkl5RG1EQmZFZFZJSFBhUER2OGJRb1FU?=
 =?utf-8?B?Rit4SUNxZUFya2U1QW42RlpmeGsxcjh5R2JvaDhuRzlZNlJiK2NyNGlXTDkz?=
 =?utf-8?B?YkFtZ2s4aE5BUkl6UHdUVVdUWU1DcDRZT1FMTUloYTdxeTJRVE9nSU9Qdm5S?=
 =?utf-8?B?a095bDdvS3FrZHpqNDc1UXlXRTRuTjIyNzlFTzl0dXMxQm1qbk94UjFUS3BW?=
 =?utf-8?B?bXBNRVpYYjNocXV4ZVNiMHAwblNPZzFUV3NKM3RSa0owdzJsWTZqRU8xRU4y?=
 =?utf-8?B?QWpxamUyV2xPSWg5eFhjU0gxNjg5czFGTDU0Wm9nbHc0bjBpZzk3RE5rS09O?=
 =?utf-8?B?M1FsNmJxWmFFVjQ3OU9wZ3d3MlZrM2NjVjMzMXFSRDQ5UHBEd2M2K2hHQ2I3?=
 =?utf-8?B?bm1venZHaElOQzdzeGN0Zmd5SGRjQnpOTVBZbFdlMnhnL1NjdDdMNHFtOWNT?=
 =?utf-8?B?dng5L094S3d2U3U0bElmUmJJL1Y0NFlqSFczUHFXMlhNQ3pJTUZPWFZlZWFI?=
 =?utf-8?B?elFaM2xNMG5vdTJEL3Z5T3cvWk9RR2xZZzJCM2FNazhmRFg5SkdKb09CTklS?=
 =?utf-8?B?TEowaDlUSmNFQzE5OHlzQnBDTThFVU43Vk9nV042QjQ4NENaMklwU3ZuYmRD?=
 =?utf-8?B?bS9uK2NaVXBsdFdSaGFmYjE4eVFXV3YxOVFnV0poaFdZRGhMakNmb0R3L2pB?=
 =?utf-8?B?UUZ0UHRveVAwN0lvc2IyQXJOWC95WDdlYVQ3d0lzaDQ3ZFNPRUpZd3NpTFBB?=
 =?utf-8?B?Z3JKamRmUC9pUkRTcWVzUlV1N29zMzlKRXlyQ2t4WGd6N0k3L2labTRKUkhS?=
 =?utf-8?B?MFFpYk1HOVVnZkROSEgxYVZpYlQxNExVUjR3a3gxYjZrZGNuNlFlWXV6dEF1?=
 =?utf-8?B?SGtRS1VGV0FIcGV4NFBKam9KSXUrUFJlTGhFT0k5cnFOdE1RUnN2SFoxWWxN?=
 =?utf-8?B?R1N4UU5mNjR4Z05kb3FGbmx4WUZtaUluTXFBL1dmNkNLVWs5NVowK012eCtK?=
 =?utf-8?B?REl2ZXZRTUh5TmRtbXV6bXE3OElKNTZOd1BEQ1Z2dm1SR2kyMGNOekFMcVVN?=
 =?utf-8?B?bE04UVRxUkNxK0Q2REhGL3QzTHJhRlpsM21VeWJQMzhESTJYKzJKVXhrMmxJ?=
 =?utf-8?B?R28ydjdzd1JFbDZQRGtTa09wcjdnUkZZMkZPSXp3T3BkeVRvdEhUeXQ0RDM0?=
 =?utf-8?B?NUV0Y1lIY1RLS3pFVkEvbHp2S3hZSml0dUEvVUxvR0M0WWhzTHB1ZS9GaWQy?=
 =?utf-8?B?b0libnc4UzhBOEN0bXpINkl1amVlbmFFcG1zK3lQNXE5d1oyMzk4RG41ajEr?=
 =?utf-8?B?R0VyUEFMT0FlblpRRnpaYXFhWkpsSnpLYzJOdGpJbWVla1VnbXZkYkJiMWFi?=
 =?utf-8?B?a2pzR28wSHRJcUpGd2N3SmJ2ZnFKcmIvZnpsUWFCMWhZZWtlRm9WekNycVRn?=
 =?utf-8?B?ZGcrVW93czdRNlZXNXBxQUpYWlhNRXZKSDV5K09WNkVRdkR2U0lEeWJ0N0Zq?=
 =?utf-8?Q?8kHnvLfB6GYs1YATL08e41B9S?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d92526-734c-4055-122b-08dc5e288fe9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:19:08.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/II/OH8CcAohLB6d1BkN+RBMQY5omDpJOfUeVhoDnzIpt8RAShF9Z4r2RezxfcP2e0uBpbxyc2zjdqR7Up1hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183

From: Peng Fan <peng.fan@nxp.com>

Add nvmem property for fec1 to get mac address.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 1c5e2049a37a..b09014b9a719 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1067,6 +1067,8 @@ fec: ethernet@42890000 {
 				fsl,num-tx-queues = <3>;
 				fsl,num-rx-queues = <3>;
 				fsl,stop-mode = <&wakeupmix_gpr 0x0c 1>;
+				nvmem-cells = <&eth_mac1>;
+				nvmem-cell-names = "mac-address";
 				status = "disabled";
 			};
 
@@ -1176,6 +1178,11 @@ ocotp: efuse@47510000 {
 			reg = <0x47510000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			eth_mac1: mac-address@4ec {
+				reg = <0x4ec 0x6>;
+			};
+
 		};
 
 		s4muap: mailbox@47520000 {

-- 
2.37.1


