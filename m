Return-Path: <linux-kernel+bounces-147112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860648A6FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25991F2155E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365CE1311A9;
	Tue, 16 Apr 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jKuKRcTn"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018641332A1;
	Tue, 16 Apr 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280761; cv=fail; b=h0U3kS0BUNf1FFDujgGCtLSs5gReghA/YOZkdWCIbnbuw+tf3LNb0v7EBdY8ccKzLztbaVOuQ34uJv9gtcitwWjzWg+mH959anSeo+DNkADLQqxcsypilMB2MYQyKydLsqLVIbHCLQIhGklq42foJOTbc701TDHBMTkWB4VMF/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280761; c=relaxed/simple;
	bh=pTuxIVGmdEWugKCvQG75OxjakV0JH0oIKolepisN3X4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lKF2ZKyBsXBLVhz1eLmPUnbpOjDPZ1uPljmomM+REgp7dHqLTs20Eb46vYRxcD4z3mZLJn7lQL0b/z+entdiv+yaE+gwLAkQklAsxya1VFhGUuOOqgRoKFH4jIgBiessBaBygm0365Akv3tB9T/lrhtcUajo8OZK/4KYulZF9Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jKuKRcTn; arc=fail smtp.client-ip=40.107.105.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+L9mwsC1aA7/GR7SKHTk/JVOBdbu3KcsON6LVs50uyJG6oi1kRRpcQyZpp5yiLF6MaXXqKoU45U4zZFJ4fXVcU6t4s2WW6+klOvXtAiJfFLQpTS9cc7LjOa9ncSAazc8Ayn1XyZW2+twFyXPxXmutDUyN7/+2Wos6fdtB1aOU9yTPAMAoGmP19SzhuruGzfLHKYsmJQU/z8Tt2kpg2U9fBzPeryP2yrF7d//mmVYubroyg+hmf3Aoo0ZbZbiWx8H0iZT7q3jdfHg3LXwFK/fElH5mkW1odsv5504vz+GSRJOSNaY47vqoEOYEkJ8yonYEHsuRYyT5MaULHlR05MBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRksF2g3QDMzehRt4Usp/FoD17du8Q3c4Jh1C1+abJg=;
 b=VK17LvC8nFjvw7w+gjmncoef/J0lf/bmuZAyMNCmDhePnISAroOAmV+K53dlfkALdA/P9jZZwIFhkv7Wan5CCFSgbEmFBQk1QzcaXABL7dQlDAqgaof+knlHZzmvsA4T/CPpNM9zjbBQjrnxNHZ1Yn/XZZ4f8XJF0FSqy6VI+4z8BD44rTXc5xXhRG/tq+jWmOZw2VnjayRPK7zlin45ERf0OeO7R6AWqV4rAgfHX2x6Cy7Guwc06UEmeblgsmdzHaodYjpZ3siFp7B2jbGO334Ljhq6e0HjnUlwdu6DU8TJu7GwInKZZq7sGjQATyQAAUgpKTq3O9kivowdxRf6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRksF2g3QDMzehRt4Usp/FoD17du8Q3c4Jh1C1+abJg=;
 b=jKuKRcTn1sWHoPPAEp4DFwDd7Hzz3t6S1ZwNtWlUqzs2+a9O/bSk8QN/8AuE/AoSkPtodHke/7c2r8VKzJG0zz4RDXhmyUQerzAfAH+zPf1uQNjVKQAriWEXibBWKsXdT0iRenpE0QOPWnfIoq2IC8TmvuOdkAKortM5NzMIy7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:19:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:19:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 16 Apr 2024 23:26:42 +0800
Subject: [PATCH 06/11] arm64: dts: imx93-11x11-evk: update resource table
 address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-imx93-dts-4-13-v1-6-da8ac02e8413@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281224; l=1062;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=CLhZ37ZF4E+NIrVOCWZ1K/HaEhBstYTmmr8Sw8zJ5ZQ=;
 b=A2keneqx5PPAydbDmzz/ejcmm1tWL7fnz583IAzUaK+LMpJ4bKiKEg1hcHT5n1/6Vi8rmWc+B
 Gh+OX72C949Abh5xNTed0B7jkeksSr/E5U/xH6R+D3FipITr04R6IR0
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
X-MS-Office365-Filtering-Correlation-Id: f9d11bef-1469-4681-aab3-08dc5e289471
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a7pMxHWCFxRGBleqKX9izfI+DQoM6dmQQD9cyzgk1rx381hVyKCDmaHuSVBS4xjKmASEEgzq+4wlc6f/wcrKNYHrZ7xwBfwAvyS+CtCaFX4ujApjDAjN0TbSkNQvf2GSmInYE4qhkvpVWJMcgLBF0xKHB2Rq6fF1q91r199q9aq4AkAUeNMz9upKaxWap6O9t4qR6CZ45QJ/CeXtPsBLK/f9//f9WfaRKYeyyMtGYmlpsVYZADptxDyTtOznG1eAMEeztrGRcE3UulEVZ/QE1owIJFELjvzZ3U9YmI0n7fB/P4aaf7tiq5ofWTS3UA5jArMzGdYGmY3h3hAYNXnZBTQiFN5kx42nWksGUy+Um07kvVr7UeiukX2PteOTySJLIIQf2mdZNpKIJoB+WLrYFqOemelwbJ+qcWj9kavP0IWYN9KPENrNbPLWcKgBXPl/icWzMpX91iqxxNrWBwQ3upU/NDThS8LRKT2RgVYvUg5g9eyZZeJ7MHkQUWEwgh5HG0aD69AeTy3TPN9YbBrXMo5bCZoYRe4RklRU3I1+r1s8BqwLBj2jnMgnguCojFA++tg2Akb8F8tg1BqOSkFrOPQOIr3iqquOHJAzNttYrJ7b5TQY6qLSsjyZcLvAduif8nd7zewIjAliC9Q5/2EEew/lR98f3H6b+hEGyrtllVW5Ft8yrE7vgTXXlbb9zs5YYAOLWrXZxY9z6RQjubuklm3jvVa/rkTdu6XZxubUAhY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmFEanhWeDVSTy9EYm9GclVaZ0JGMm5FRmlFR05pUTRhYWVOc2hBWHdNUmNS?=
 =?utf-8?B?Y2RNcjE5alBTQWxaWHhuYkxNUWVBeWNtTEN3Q1kzV21ZVXUzaGZ2bDY1NDFs?=
 =?utf-8?B?K0ZWak50SWF0Rjl5OUFqTGREK3U2YzJoQ0FhcWFEN2EzaU9oMnpuVnVQb2wr?=
 =?utf-8?B?aUVPeDh3VTIxbXYvMnFsOWwxdC9NSnBaV1h4MURSN1NwUWxOeHkvajRiMnRs?=
 =?utf-8?B?dTNVYlhhZjFMV3ZvS2llbG92bEh1bjN6bU1uQ004NEd1dDlZd0NPUGpOT2JN?=
 =?utf-8?B?L01pWXprWDV2Nm9kZlV4dVdXVFRSSHJuQ0FHbDNVNVdSWHU0SUR4aS9LUGdp?=
 =?utf-8?B?MXdvaGZ2NUEwOWwvYW1samt5eGk3aEZQSEswNk12bWt4by9DejJxUHIyN05B?=
 =?utf-8?B?NkdXa3lhSEdJZElEM05kSWtBRkx6WWlQOVA0cjNFajE0UmoraEkyODN0S1RI?=
 =?utf-8?B?NWRKNG1PMzdoMmIzdVFwRXo5UEtFWHd1c1VFZ2NoNUxuWWJmR3AzN2ZMOWpH?=
 =?utf-8?B?d0RGWGR2OS9JMGlGeHBES2F6c2xRUWVnYzNDVExCcHU5UmY0dVY2ZGdjS0Uy?=
 =?utf-8?B?R2VCSDRFbHFDTng2am9zcXYwcHpLbDhrMWpiaTJ3Wks3OHJnN0kwOHFBMXkr?=
 =?utf-8?B?ZFB4alpsTlZUVXVsSVl6QzRIYXBXYzhOOUZ1SVU0TktPeWtyLzBIL2FCczdn?=
 =?utf-8?B?d3VDUlNGRmtOR0ZlWVZTNnJkRGNFVnU0UG5ncGlBSldSYXJrbUdFMnRGSlBw?=
 =?utf-8?B?Z0ZMTi9SekpPM3NqUGlySk0yVEZvRE1IeS9CSGFkbkJRdGlhZ29vNFh1bk9w?=
 =?utf-8?B?aTh3ZTIxb0JnL3luRVpVazNMZjlabUN3ZWVnWm5HRmc0M2MvT1FYeWwvaVI5?=
 =?utf-8?B?RG81NnJ6RDR6ekVyK2NDdyt6WEw2Rlh3NVo2ZmU0c290R1NBSWZWNHdWdzI4?=
 =?utf-8?B?QlJINHRQWno2UVV0bGhEcm1nNXF6czE2WTFyNGh0a3ZRb0Z0R2ZGNDRsNWYx?=
 =?utf-8?B?VzhvUUExVjhuOTJCVDdZMWFMbVB4cDBhMFBYRWxrNVRlK2pNaFJVd09zQS93?=
 =?utf-8?B?TXNZa1hLc2p5WE5lbzZoalRuNmZZV1dnSHIyWTUzYWNYVUdpeUV3UDd1N1pH?=
 =?utf-8?B?YjlOUUI2M2NYVFlYaDFVd2FOV3ZEZkIwc2pURDJmSGxDVWFYdTc2bDdvVjZp?=
 =?utf-8?B?ZWNqK0pWUE1wamxqQ2JKTFN0OHBVRUs2aFhaWGZ4bUVOeXpiT0J6cFdxMURJ?=
 =?utf-8?B?bFVRdHhpcEpsSjM2Y25adzhTNlhTTFFtK0NlMVViNzFobWMxRU9VWHdBVlA4?=
 =?utf-8?B?djN6ZWxpaVYzbGFhRk8wVkFGd0FiaDJzaHpiN2p1TFhteGMwSGNPSEVmbjFy?=
 =?utf-8?B?L3U3MW5lY1dicHRHMXNLRllwRGErVERPcEFhczZ6ZytiWDdnc2tSMFdaWHNW?=
 =?utf-8?B?UEs5eTRFb2UzUCsveGF1bU43Sk8vSFdEMWdDNDdad0xLdmVRZWw3bnpiWkNS?=
 =?utf-8?B?TGN1cmZlb1VRL2VMcmVWV0wyUmo5TU01M1VKb2dyVWRYWjV1ME42U1pmUjBS?=
 =?utf-8?B?TWFPa0hmWEc2V3UrbS9ZK213YU9lbXpJQTRiNzJFdDByQks4OHFJMVMvODBt?=
 =?utf-8?B?SXU0YXFHdkpML1pzOGxqVWlxMFJIbXl6KzQwc0RaWDEveXRjUnpJa3orZjRQ?=
 =?utf-8?B?dk5qSzF5V1hxOXJnZWsrcTdWc1FDSld1Wlhnd0JFQTljL2lxT3VwUWZNN3ZX?=
 =?utf-8?B?RERRaDJzcEhxSjJpMm44M0hNbFdMUFAyWHhYQW5NRk5tNGNuTWlTWXNndlhK?=
 =?utf-8?B?SXgyYUc3YjEwTG50TTFJK0Z3ZlEzVzRQdlpEK21IWEFwVjlJY3FzQjVrNG82?=
 =?utf-8?B?VzFOcWwzTmVnWWFTVnppTW9OVGlhWlRTWXVLdnZzMDcxaFZtNlhxeU02VDBy?=
 =?utf-8?B?UTFmc003eXd0ekROUWNBeEllN0FWUnhwcTBoV2lGTlg1QWdUdTZjZlZuTk1Y?=
 =?utf-8?B?VzFsd2FSRjRUWjRsMnRnRkYvMENXSHJ3WS9BWWMweEJoOHdSZUdzWkFreXpQ?=
 =?utf-8?B?TS80Y2U1QVU5TUJoYUZ0MlBGWnlqaENtV3BZWFZVUUt4b2ZTeUh4MFlXa2tR?=
 =?utf-8?Q?9M//Ibl7xPe0KSWbQDkjk3Szx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d11bef-1469-4681-aab3-08dc5e289471
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:19:16.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHvLDG58aPmwq+XJEkv5iXJTMUxATaw3exyn0r6CDHYv/+TkxfDByt2Ae2afNw49rXif+D1GhMbTB4XmOwEYqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183

From: Peng Fan <peng.fan@nxp.com>

Because i.MX93 A1 ROM used the last 4KB TCM area, update the resource
table to avoid conflict. Also correct vdev1vring node name to align with
reg.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 07e85a30a25f..b7b52576586f 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -38,7 +38,7 @@ vdev0vring1: vdev0vring1@a4008000 {
 			no-map;
 		};
 
-		vdev1vring0: vdev1vring0@a4000000 {
+		vdev1vring0: vdev1vring0@a4010000 {
 			reg = <0 0xa4010000 0 0x8000>;
 			no-map;
 		};
@@ -48,8 +48,8 @@ vdev1vring1: vdev1vring1@a4018000 {
 			no-map;
 		};
 
-		rsc_table: rsc-table@2021f000 {
-			reg = <0 0x2021f000 0 0x1000>;
+		rsc_table: rsc-table@2021e000 {
+			reg = <0 0x2021e000 0 0x1000>;
 			no-map;
 		};
 

-- 
2.37.1


