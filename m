Return-Path: <linux-kernel+bounces-147114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B618A6FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F63B248AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D160134410;
	Tue, 16 Apr 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B7GcFrCs"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC0A134406;
	Tue, 16 Apr 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280770; cv=fail; b=HcpWVJ4PzyO21g0DvQKpcxn3QPXkRUZDLiezS7EJXfKfRnCR2SaQby5nTt8quXItriyxlv3C03bTREhy/zO3a6wbL326Ztz5YmUqcEcpmZa6uj42jmcD8AMd5JPBNtRD9FAGChOrWZTFXbCFR24AQWUhERt9i9jJRAoZs1oPWBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280770; c=relaxed/simple;
	bh=G5KiBP2fYGV57i4N6Iy2S/SHJ5StjpqTeJPC2rBgcTQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tksFZAC1TuB8SLSL8Y7Kw6uhyB7C9iHDTTXenTaOzkKIhaW6CYWyef1i8zbA1l7jUce1SqQ/hFhw36fvj/Mkvcw2kFqMlkZttngatAZBWS1elQSW4ZqTIL8Qkm1Oq6ulL4CVfXXKS1roAVbdM6MBM+7gTwRFQRWjI8BBFhAHPxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B7GcFrCs; arc=fail smtp.client-ip=40.107.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsP4RHzqao9qEixCX3K5ITMDIJrGhqAR1cKK99zt4bK1RcDX0/+/OC6QsewhV5zee+bmmQInkkUijMB+PXcrNVLRJUwvfD22g1+qs2+IOih2kieVC57yyhupTV9KDML7x3z5s7G43fQk4/cV1Wu7epMFVf0y9ZGoBCC2mPj0zQ7D9vSXI9nMN6/cDs84Y68ocbPlTvELRCBGkUIgniRhxRpXHaAr1hZHOLjcuZYcNdi3dzP7i70EhLpWXVmlU+CzrdnNHlr1Q21KZ9P7V3wAUj5VkZGI2zbHHxdFY4hK/+fs0nVNQTx1JvRTRpb+NCejabJjdTgEWIi+QDSPScPQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Utj7ItaEHtvIsv0ZHYVfFXFu+fj+P2M3yxfR5i0ip94=;
 b=DTOK3XFY9Ep6KjPvTrOw6hVOYTmnEYkTExMu0Cj8soD27BtA7LWf7VMZ1XUgKIYMFtqLLdaz8L6Jf2eHRx5xFc93hP9A6jqP1q492Bv+dScGjsW6UcYBiT3htTe5yNYf2VenzX5K9+sw7aGOlIHLp5K85liX5w1giSOC6TUVR2sVNyISYlau3JN6yITnBSWvek3DehElBAQ8pcVjnZCQCE0wMWTmgdOcTjqA/PZSW0lOlX5opmS33gb3hVZX/Y5BhqAr/pJUNWJitH2qjY+jWRt97S82tm40W771FBoNbyv5B2oCLwMW+W7LCiFtkRR4pIU67PSwxeWFuEjXBPkFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utj7ItaEHtvIsv0ZHYVfFXFu+fj+P2M3yxfR5i0ip94=;
 b=B7GcFrCsava0OTIl2AqbuHXoLLmwReI4GM8hNz/a811Wsx+u8Gz3zsqWK0wYQyJJ4JSL/EwyImN+01M3qczqzpUkJIXmXx9mBIB8cz6sZ9mG5CMr9f5q05dxYyiDvd4k4YD2h+uuYPZJeoP8gl+CyQunte2+KtrvZ5pYaou9aiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:19:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:19:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 16 Apr 2024 23:26:44 +0800
Subject: [PATCH 08/11] arm64: dts: imx93-11x11-evk: add different usdhc
 pinctrl for different timing usage
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-imx93-dts-4-13-v1-8-da8ac02e8413@nxp.com>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
In-Reply-To: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281224; l=4577;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=llEiY/5OnUc6shhi+Ccz28hv01yOemdhaRxTciJwC4k=;
 b=ppkm5RtF8XrJImc6U1PIc1OJRmggyMKb+gqqnbeYL9RH1H1caarFbsZlh2wNJ1TM/XrMxHbVr
 W/sGbNQdJxlCswZkJ824/yW/qiWzPCClXkHSKEOTE5yRHoNN3i62qrj
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: fb56ce86-9aa9-4ed0-f5dd-08dc5e289953
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IYXiKsIZKIL97q1j9DCWDPkdQZRY0wVY3pXFbzfyl1MuyzntXLAgxvjBS3kgKAKKqIILXKJOD/U6soq4q62NxuOCeOc91Mu5z1VwBwzXdX+2LHCfVzL/RqchS6jdA7Hz4YZFVUDGmWwaUFenr0bY5Jus7zW3mYP3SLB06bF8PIWgrWobvQroXiQoZ1Ez2EaRviJYrCm7/Be8EQd1K3V5aTywfpVDR2ZoTUz2X6xWSnk72giKxcoD3zuWVrv9SQQ68r7uHndymNjc3N73PAmkgVS4RjfklPqDWUACHpFq67gJmNE7yB4qzjupURV4pHX6oxH8srO7GVtPnwlyCBW1cUJWMYc3i2waEN0EQIrZA2ooOZFoytOQ0XeWcVrXA1DOgj3/F5gvp7LrkwsyEh21R52bG1ka0rwb2GP0L0NyD1DKTMuyG1smWCacTtJwua4Ms2GpcA2p0MGlavTO5cWajTP2YYWmmh2gfB1zI1oT/sSvWhKJmqDLzO0/+FxKOY+2CP2Hu6HVZuVT5YYSniKiYDh9IBNi/akk7+WsQfZ4wA4mrfhf1nN2n2Sp6PMNL7t7Lk54BPWWKjWMrJHtEOgBgMk4EJAaKXRKr4pxqpMAHMLzDzhympGoBfIOkLkXk9ohdFKbtclAofQfbeLwWCt6hQLPYJwPBP7rc8nQRY9OfVKaGTxceQo0WNEgy/8u3eZ2bFBat3AM7D0K7qcw1PK1wLZQOUxeK63Rnvr6kA2TecM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHVDTC9BZnRHUnJTMGQyNnVYYVRRMDc2OUIzazVJcHArT25rODZtUWVNbkZl?=
 =?utf-8?B?ZVpVK3FsUmRBUjZ1cVpZay9FdXp0MnNad0dTamV6b0Q1cG4zcUxHSFl4QUpC?=
 =?utf-8?B?ZHViZU5LU1V2dldrcWZuWFlVQm54ZTFMYmpzRzJ3eE0wRGY2MnNYT3RrWXNt?=
 =?utf-8?B?Rk9IcjJQblVDMVlPc01UK05rYzFTWnhsOXBvS0NFRkpNK2FVSjJxRGlNeXd0?=
 =?utf-8?B?VnZYd2ZSZWUyazdLbFlGdWNQVmdodlkwSTFwdTNVbXp5cHg3OE9BOGRsUUpY?=
 =?utf-8?B?dktYQ1ZJdHRhNUxWTTlpcmwyRTE0ZFVtWWRoeHhRWGpKV015QTc1UERlTkpI?=
 =?utf-8?B?YmlpTGJVaUZKZDFiSXdDaXRxTDZXek5QeEZKd3gyNVhWVGZxenRMa29CNzZM?=
 =?utf-8?B?SXF1N0ZUZ21MRjIyTHVETCtYZVdtMGVpZHhJdHNOZVhhdWVpajFyU3UzdjQ4?=
 =?utf-8?B?a3o1Y25HYW9YZXdkdDhvMVdjWm1DUmp0QnJnT0JXSFIzVjRvYm1WUllBaEg0?=
 =?utf-8?B?bjJSaWRiR2FKNXJudyt4WHIxV3NtbDRkRXhZbnA1RVRCb1NpQmdKanM5NEpq?=
 =?utf-8?B?ak1UaGxNVk5iVFlxeE9KOFBmTDFQanlxV2tYWmpic2VvVWd1U3Q1dCtwL2Fj?=
 =?utf-8?B?UitRUzZ5RlV3TkE1UzJLY1M3ZjQ1NkJhRnpCYmlrWWdTU0RkWSs3STl1WjAw?=
 =?utf-8?B?ZjFaaGZHVHNOQjFOeTE1ZVBzU0g5MlZIVXJVb2VyVTBZbnJoYTdJQ1I5THVa?=
 =?utf-8?B?Z3owb3N2S2tsRE90Q3NsN3NMUzQ4Q2d4Sm1ZcURpSmF4cmVZdVlGMS93ZTZl?=
 =?utf-8?B?Q0lya21JOHpQTWw5djJVSlNXN3dKRmw3cDBORjZjc0lhem5wMngrd2RyZ1Y5?=
 =?utf-8?B?YTZWMTVNaFBjcGFjL3pJWFNkZU1lZGs2OGp0ZnRMWlJlTXg5T1NtV1B2RXVi?=
 =?utf-8?B?TnpmcXh0a1B3NnRxRHlNNDRiaFRndHRkdVVIR0phYnJhaUxMUmVSQi9HbVN2?=
 =?utf-8?B?QXBiRENwL0VFS2RnQ212bXp6NTNob0ZwMm5DbEtMamo4LzdTQ0daT2k4eCsy?=
 =?utf-8?B?YWtOcG1rc0YyVnVMbnI3dTAxYzlqUlB4N3llbXBpSWxaMkFYb2cvSjdyeHpp?=
 =?utf-8?B?OFFZRnJ1WFNWSUk4dnRudWhLall2bVhHQldjZWhNdWFkcG1uVEw1c2xLa1JT?=
 =?utf-8?B?MXB5anZKdm16ZitvczJvaXhtWERndFMxd1dyb1ZBZlB5OUFCRlhDa2kyTXJM?=
 =?utf-8?B?NEdTcXViOEd4Ukd2RDV4ckFadXBibmxSTWhzYUlSb2JzQkJ6dkF5WjR1M0Jw?=
 =?utf-8?B?UzBsZFpaK2x4ZTBFMjYxSU9CczBINGtlS1A5N3V0dUtpdGdBclZuQ3RiOFcr?=
 =?utf-8?B?SXA4aE1yUFZwS28zcHJjTlJJdUx3aG1JQm53d1ppVk9XcDlmU3RxU1dzVEl2?=
 =?utf-8?B?cUFRb2ZkWnc4YTNGTUt6dlMzRnVWSitiZHRhbjhldEdVMER3NmVGOStaaUc3?=
 =?utf-8?B?aXRRb2ZnKy9RanA1VDBGNnhjbEc0aC9LVWZ0THdrTXRNQ3lRczBXOWRTOFlt?=
 =?utf-8?B?TGhxUzhmdUdzNnVQTk1iY2IvSE50SS9leXFlbkZKeXlrc0ptREYrLzlxUVBC?=
 =?utf-8?B?UFhOZVhHR0VNSkpodXovdUs4Vk8xcXI2ZFdMMldWTWZPeUdTTVB1cmw4bGRD?=
 =?utf-8?B?ZDkxeFQzSUhnbitHYnFnWjhyVkM0ZWU2eXhZVTlXejJlcFl1QzRhUThmWG5F?=
 =?utf-8?B?WFgwMjM2N2xvTUFaNDdqUkxMaUgyZ1VnanoxdHNuc1FCdENlUDUrQVpJQ0sy?=
 =?utf-8?B?c1IvUXhXeTV4SjZpRVRjWUlZZEI3d1JyNFZnU2Z3Ty9tb1RGWG9RZmlleUd2?=
 =?utf-8?B?N3c3clZiTEdpaUNEMVljWFJxWWlhNGJ2M1NsQnpFVC85bG1Ta1VpaWJNWEpv?=
 =?utf-8?B?cDNlVGlqcmgwUFg1ZGdMeVFsV244N2FaR0VaWTl6T2ZRUGJnc0ttU1JYd0Er?=
 =?utf-8?B?VzdnNlA5dkZjUlJHVFdhQUdLbTVqN21YRnNPRGdZeWRyRDhZTUtxOVMvdmZR?=
 =?utf-8?B?MG1oeUo4QlZDNHFSYUdCV3MxSDEvakR1aVdlSGFpTlNBcTA2d0IrV09XUDVG?=
 =?utf-8?Q?2xTVgdzVF+4IFkfEj+4QoWXIK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb56ce86-9aa9-4ed0-f5dd-08dc5e289953
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:19:24.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OC54mOf7lMOAfTHuZGcYkZglUXOV8NuL2PM030kSq6gyhGkFRXh23XkPUswIkLcssgbisefOB6cg8FrW0acSCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194

From: Luke Wang <ziniu.wang_1@nxp.com>

imx93-11x11-evk dts use the strongest driver strength for
default(high-speed), 100MHz(SDR50/DDR50/DDR52) and
200MHz(SDR104/HS200/HS400) timing. To make usdhc working appropriately for
each timing, add X1 drive strength to default timing and X3 drive
strength to 100MHz timing.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 68 +++++++++++++++++++++--
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 2b67724db685..f848cb0922ef 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -161,8 +161,8 @@ &lpuart5 {
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1>;
-	pinctrl-2 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
@@ -171,8 +171,8 @@ &usdhc1 {
 &usdhc2 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
 	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
 	bus-width = <4>;
@@ -391,6 +391,40 @@ MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
 
 	/* need to config the SION for data and cmd pad, refer to ERR052021 */
 	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x1582
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x40001382
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x40001382
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x40001382
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x40001382
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x40001382
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x40001382
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x40001382
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x40001382
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x40001382
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x158e
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000138e
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000138e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000138e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000138e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000138e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000138e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000138e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000138e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000138e
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
 			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400013fe
@@ -420,6 +454,32 @@ MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
 
 	/* need to config the SION for data and cmd pad, refer to ERR052021 */
 	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x1582
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x40001382
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x40001382
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x40001382
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x40001382
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x40001382
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000138e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000138e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
 			MX93_PAD_SD2_CMD__USDHC2_CMD		0x400013fe

-- 
2.37.1


