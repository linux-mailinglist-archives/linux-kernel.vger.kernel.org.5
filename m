Return-Path: <linux-kernel+bounces-150957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0658AA727
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7ABE282879
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E26EC2;
	Fri, 19 Apr 2024 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SWrecIPH"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C6BE4B;
	Fri, 19 Apr 2024 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497369; cv=fail; b=pLsXd7IY6O+s4tmi0yYETDgh2Sma6KB5+blRuKY1nhzfu9DLMdO8v74PKj0TYGMv4/a7nmAXqnNZVxTk3dD+hnne8nihzEB59UhQbvtEw6hCCIHQcOk0piVLNQtNJp6e70gKkuwJwuYkWnu0kEi3B0OXCTNZ0NJdUOrB590Rrw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497369; c=relaxed/simple;
	bh=oNJHSxz5BV1+N8SGnTHwY3adBbcwCx7NOG6wE92LPF8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iYAv9S45hffxTJToWYJOhq9hILOJ4X472FlcBhKMwRa0wpvFQnP4S/0+Q8hl2rGp0IpKc3hmavmyY5JMzdBssgKFuZwGHy/tT22ZnbSKeKYv7iMqaVNsZBcc7ZVrexiEt/jf3QJDvgOu2UaF/gKht3OiUhEkoY0kOli40SXawic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SWrecIPH; arc=fail smtp.client-ip=40.107.6.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQ7z1ich/wodgDrkBAzLutIjlwRHtqOHIojqsmdknHuNldjx91USiSJ41VmjDxG1xA21ftZOgL5MSEwtlmGvp4IWpWPh/gLwKVXQg4Az6XUDuvZn+x1LTnm42CvqgXNFOKn6yctlO8NVhI2tObwRhKyRwoNfbLn6D92EU+DlQH/njmS6+oB4J1/wVGNGjtBdVRb+q6MQm+0LDJaLgQe9mdgol9nythelQ/c1aTcE8jTjg5hiEtwlYcensqgvhUvAz6O2K0tdlZqXKmd4lTgpkc4FUtCwmNfFwzQ6TIis3E9BfLoEjuCYVNSRsFqIK8dyKx7gvQaBgagTOA1XhYqqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbeMMzeCVw0tlxjqUopoDEXz+dzhZ3rLxjqKiGivFq8=;
 b=H7e5+MDspVaRTGnt+jVLcYoNtL6vH8yX67cI/VwRCjZG5xLGQBFHje4TpZcKBGLArChEAbxax+QJqcjTe+U5E3lEnT1A+NSYl+7PScf4iQsKLIVd+IXmzcEN9rB33ATy6/AUXRpmLRJzwEYjfqGK7EPItPZhtN9Tv37QvfXrhclb8C8VttXMru3wZgRNXonhl4xy0ATo4eHk5AzH6WsFT7QFnXRO6iYMTsUc1cQLIS1GrxEiqeqe+9gSrO4sZt61ioW6UpkRJRGxoVHky7ZGBAa+hszu6ueDCjSr61wShFxH6Qvy1u1rS9vq7zLBGyzCnokanYV8hek4pxsPBlpCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbeMMzeCVw0tlxjqUopoDEXz+dzhZ3rLxjqKiGivFq8=;
 b=SWrecIPHN1/mIQ2TIooieW+gvln3RAElxRKdpuFQQ0t0z5mcMnfzAOXDU109bnate1S9iq8cfqRFRFXML0s1QeYaf3hXWEOzADF00f4ZEdutPMViW3reByqpSH5WVUZKGVYL3Dvn7PsZ8V72Q++odqPNmBk0fc8mNRei2zmiseE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:29:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:36:59 +0800
Subject: [PATCH v2 04/12] arm64: dts: imx93: assign usdhc[1..3] root clock
 to 400MHz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-4-9076e1d7d399@nxp.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=2352;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=0U2zo71EC9Wu15E32rrl4zFFUOLw4/kKO/mst7UPUWU=;
 b=2GbmJS3Vbju9NJboam+oOXs/rlAtA5JKYqDguBg2nVmglA4UFZSDqROLiPMro4A+yLc4E6GJd
 L+ZMKz8GYknAHOi/NmKr4dQkGz7c3k1vqzpOectREg6I/R35utxE4Yj
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7dcbd0-38d0-45ac-8ba7-08dc6020ea07
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kk26SXBslI0GDgVqqRT1YHnxFbxAm/0lXe04DNdj6Y3/OGRdbiQUlILb9EBP5xq4NmXGpW4zGWSo5TK/A21nHguCVzW8iiqQUR8Hrk7U1wY3u9YKWLn+M/jHDp0AdAZPPpx4BwOnSsJsUkG7yWcdD+9ZKcrwP5vqScRoim/E6Nnb16iJMY4UhYfkmgesHbKt9k1qYd9hN3o3vBXbIX4HxI6wlq/lRoMTe6SMWuGafA5V4G2EijEwpZVMAi5/S4gFkC/qOJkDGay/Oxu1GmnpwnK73nSzc50A8e4l9iZsq72oY12Hze94jOplbKFXJEK1iuqOOe1gWqV0BNCDNX6h7RucA63CJ4VH+GnJJtjC41pkIsOJZIT9Yd6GuS68BmmSRYaRLAmtEC0ygKniwomYIarQ4rmo59FsDMe0fp2uT0rxBMcS9iFzf7h6qWoRf0Ty9yEWFFMdsUtH1jhllEjeeIddWZIFd3ErDHyALOWkXxDYlI5nkVLkO49LkWiqgqQp7QkgETGo2n8i8C0nXJOUF7rBMUN9wcdwCTdvEC6W99R9FKUMlSWrJpffkvRd9awz1MeDV4gNr0yVyqm6lfGP2H/AZSfcleXqFtQyGL4Sk9dKKHLz/t3eoqbAV7WWDDAla27VEK3Nz6lQqBmsP11AqML5OLmAQBOcZlHmMQBHPFZ5shdy1Vb8hoPObw75Ri/FT0PPSOx/ZdgMgIIiCiNgKHfUT5pqGWm55STY9H5ryvY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3dQekQ5WS82ZWpydGFnZjhSd1ZXTU1LcnUrWGZ6NUcxL0IyYlBxZ0UzSlQ1?=
 =?utf-8?B?UTlJSHRkVHRQUVRGeXVZb05mNzVHMXpFOWo2VEV4NGp0M204Q01TVFgwRGp3?=
 =?utf-8?B?SmVyRGxmL2hLcDJUTGlrTWwxejd3YUJkN2VXb3lzZXkvTlI4OEIva3Y3cjVa?=
 =?utf-8?B?dUNYbDFZZEZjdVBjZ1FGWFFNR2d4SlFMbytpYmY4SGQwWXY5QnY3Tit5c1Fx?=
 =?utf-8?B?dEc4alZSdjk5Vm5rSGtDekd3VVlNM2FYamNhRjhueUNZZmlxQ2RVMWlqQ2lm?=
 =?utf-8?B?SFpndUxPb1FuSlJlTXZOT3M4UmFmUWI4N1IzVWlkd3JLVkYwRHNrTkIxaWJO?=
 =?utf-8?B?ZndiblVKbHVHWmRrYzJSRVBNblZoNWkySzZVMU84ZkNKUStZZXkzM0lvemF4?=
 =?utf-8?B?aThnN3MvNGNzYlU3M1ZpWmcwSUZ5SS9JYjBSc0pMbm15RGNCOWQ3VUdLR25j?=
 =?utf-8?B?YXVCRVdTY2xlSitEZWRJbEJHeWRVRzRtMVlWY1YycnlOaVYxSUJQZHNOMyto?=
 =?utf-8?B?KzV4NEg4QTFZZkljajJ1RVVHdVA1MkJpVG04ME1qbEJ1Wlc2VS82MHo0Tkcv?=
 =?utf-8?B?UENvYm9pdy9xTjdGQlZJcyt3eHpHZUtrMFZWNW92WG5ReEFUUkdIQkVGeFhp?=
 =?utf-8?B?ZE5ZcUY0aTN1UGxSaDViWU9TeXpQRXpZK0huM2REZUFKa0ZMaHErK2QrZXVJ?=
 =?utf-8?B?RlFHNHBoL2Z5RCs2SXNWTjRzb1V0VXBWTHRScUVLUytaTUpPa2tsL1ErdkZq?=
 =?utf-8?B?ZlVWVXByT3dNR2xYRGN1WFVaMTYwWkVLNDViSDA1QVIzd0ZzL2JXeHcyLzRa?=
 =?utf-8?B?b3dRTjk5NkRuN2pKUS85RFB4QzNwZmtZZ3diVUZYWUlUcDN1Z1pGdC9IeHpx?=
 =?utf-8?B?dWVzSGNTbWJyZ1dnc2dmVU8rZEF6UXZiU0d6MDJoTGdnTlF3alk1RVJnVUlB?=
 =?utf-8?B?SWwzRGd0RlRISWdOQldhQUpkVGMvVS9BSFc5dkZ3a2FjVzBKd2JXL1VyRlNr?=
 =?utf-8?B?Q05VQm10cHAzcHJaOHpUcDBYaVUrNjQ5TGIwV1dsSW9wZTgvMkZCWVQxUG9q?=
 =?utf-8?B?Wmx2Ny9kek43dy9kVVp6c0IwYjV5RWk3cUdlWndKc0U0NHlyKzkvVDJwajlH?=
 =?utf-8?B?TDk1MHYvakp4K1ArUUdPa204amxWSURjQlB6UHBHRUNGK21TUjE0d0JhQXdN?=
 =?utf-8?B?NERGb3hnamRmNGVZd0pzRXhXbHY1ZG1lSk1QZzg5YUgyb3BwVElmVnFKTHZs?=
 =?utf-8?B?UTVFUk9WZy9UMmUwQTNNVDZBWS9kMmhteWpCNG5nUFIzc1JhU08zKzMrdFBr?=
 =?utf-8?B?elZjZ2FRWnNBOVNDanAzWk5GWWptSFdVbjlMSU5mK2NQNFNqc1Nhd3hYa3JN?=
 =?utf-8?B?RVNVa1dDaXQzUjBYWWFkRUJOUEMxQXp4L3Q0N1MwWnBocDdZc202Uyt2T0M5?=
 =?utf-8?B?Q2hRSzZqN2JZN1N3TTlBc1hVU0tWOXlQa2RvNEhtb21EQUVQaDlJYTFyZllS?=
 =?utf-8?B?ZHV6eGplNEdlZmJJb0dTbE1JZ1BkS0VOSnloeDhXdE84cDY5MnBlajZOWEtS?=
 =?utf-8?B?NnRGMmZZbjFZdUxTcC8xb3hwVXBTVk5XeW9iZkhDZWEycytETlJGcWhDWm4x?=
 =?utf-8?B?bUNNekZzaHpOYUlZelRRUURyKzZlTGR1VldaQ3FXakVuaDB3QXgwdlNUTGR4?=
 =?utf-8?B?Kys5czRqTWxYMFZqU1Z0bjA1ZlNhaVpYcmVVMFpwTHhnWGhMdTdEVnYvb2gw?=
 =?utf-8?B?enRKZjJEYTRJUlQ0ejFIaWJCcnh6cERGT1VheEpWSFhZWlJuamFCRFNVMysv?=
 =?utf-8?B?b243am42eGFSSFJsc2xHZ3BNSURiNlFJaEJmSWZIUmkyeVU5a0ZuVVJKOERp?=
 =?utf-8?B?Wk0zL05oeUt6bzFnTkVzUmxDdVJhcEE5eTBtNDBmMEhMb2hoUy8zUHdlYlYx?=
 =?utf-8?B?WWxQbUg0bzJUbFBQSy81cUV2OTA0eGpRUE1LSkdEb2IzS1JBNkxUUHJDMkNH?=
 =?utf-8?B?aXJTanMvc0JoUGQ1bHVScFgrR0tSQVlOeHUzQmV4eVdPODNxY0kza1JFdWU5?=
 =?utf-8?B?dGFaR1lmaHN6RVJ6R040K0RQQUllVXVTM25KRGpwWCtSbkRKMGxkS3JCVVBj?=
 =?utf-8?Q?hcRC2ACLvPlYudaT18HrhHl+u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7dcbd0-38d0-45ac-8ba7-08dc6020ea07
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:26.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghhKnmlTZPX7xMVzV9cMQ/q1K9vsCWugqv/1lbSLweLY0QkDniQ9AmOK4t5UWbQavrCIIyA1N/weCSCd4nPpdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802

From: Haibo Chen <haibo.chen@nxp.com>

1. Config SDHC1 clock 400MHz to support eMMC HS400ES mode
2. The original usdhc2 and usdhc3 root clock is 200MHz. Then WIFI
on usdhc3 at SDR104 mode can work under 200MHz. But if imx93 work
under Low Drive mode, the usdhc3 pad signal is not good under 200MHz,
SDR104 mode can't work stable. Need to downgrade to 133MHz to let
WIFI work stable. To cover all the cases, for Norminal Drive mode,
keep usdhc root at 400MHz, then card(SD/wifi) can work at SDR104 mode
under 200MHz to get the best performance. For Low Drive mode,
bootloader need override usdhc root clock to 266MHz, and the
card(SD/wifi) work at SDR104 mode under 133MHz, can work stable.

Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index d762d96afcd5..9a7cb59e2c7f 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1018,6 +1018,9 @@ usdhc1: mmc@42850000 {
 					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC1_GATE>;
 				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&clk IMX93_CLK_USDHC1>;
+				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
+				assigned-clock-rates = <400000000>;
 				bus-width = <8>;
 				fsl,tuning-start-tap = <1>;
 				fsl,tuning-step = <2>;
@@ -1032,6 +1035,9 @@ usdhc2: mmc@42860000 {
 					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC2_GATE>;
 				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&clk IMX93_CLK_USDHC2>;
+				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
+				assigned-clock-rates = <400000000>;
 				bus-width = <4>;
 				fsl,tuning-start-tap = <1>;
 				fsl,tuning-step = <2>;
@@ -1095,6 +1101,9 @@ usdhc3: mmc@428b0000 {
 					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC3_GATE>;
 				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&clk IMX93_CLK_USDHC3>;
+				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
+				assigned-clock-rates = <400000000>;
 				bus-width = <4>;
 				fsl,tuning-start-tap = <1>;
 				fsl,tuning-step = <2>;

-- 
2.37.1


