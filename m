Return-Path: <linux-kernel+bounces-89505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A971B86F14D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370FD2839CC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0947222F0D;
	Sat,  2 Mar 2024 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rGGj3kXM"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADE21340;
	Sat,  2 Mar 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396899; cv=fail; b=AOOXwWmLZ/EUomqJRNpFZRKq4zrGhanduQTaiH7As5mf3xD+QqXPLudP99Mu4Ifg2YjwYJREl2ZyXgjGLdNubLgVPh/2g2cJ9McTO298M28b7PHhf8+S3iHCBOJi39bUnRhCwB0rV65WfC2CJUo2l6qRW61HO/15i3hNGITj0sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396899; c=relaxed/simple;
	bh=efEdkq18VB8yUM/pRGZHcAFgZrMHm9Tu8YgmXJ1rMl8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FZO0JxTx1YwAtxLpMw0ENsmqv4J8ataT4nnYzF8Y+CcoyQ/4eJnrZTiJ9sCLD2FiwdL/DkjS6SEL0x9UHhpgIcZPtYZQL2dQr9y0tXs5enqvb2d+OqmLmi3iKUEw68afSqJlpq9Y3AYdPEgXMsJxGMDhgaaxSoDx3/+Ytzh/JDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rGGj3kXM; arc=fail smtp.client-ip=40.107.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKJX2de2DOJSbrBUo92JYpH9NwjTTlLpcJErMOeTgKJHipeu4RR7oCeccCwAVAvqURaZHE7MZXLYiV8zeu9NJ+RghqZ0JDRgPuILQWma8iA1TZKXYA1r/mAz4gjgzCnvcULBYM3u4GDic/U/Krsj/qCz9ho4sg2CljnXlsbGZQFBiAOqssX82qHwu3e1G/R2Ow8pV40rtHIP2OMFtP3NWvcVpFv3l3jRPcjutsqUt8hy6bfRCRp25KYHVpk7J6lDPsut0H6YAUiMxKj3EPx7DdYdZPABCVl0+DniQZyaM3gC2jXAilM/oly/bl2kHZspQzWhQ38xKYtPDf7vrWeNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhjlP8ih9qa/0bEyzpDpugfj56QPNSobZS2os+a96Bk=;
 b=IvYAzd+bKqtDimDKUH6H8qVq1LmlUPClufcHc2riH8QE8n7wxyLHiveYEUibVJax8DbwgYSgAjztR+ec0CqmvgJxvcCahUvZPjbJzYEnUfSA3GGIA28cuxyQ3KJSxTMCS6bWHVlm7KjbPJAEoV/5kN2nDoRHHrjQlD8Uqclm6Lb8t8GOOJE+9Q24U7+icgKC1IpYMlCxCpqOEH5RtL7byYC3mIylDOnNA30brbQ5qwbwkCUCA/lazuoaycfay2aBy6IVmL7lh56sxNfzzv/HfpjpLbF1u3cIqlWc8cqOR5zrE4fkVBgNTMlrYmCN05GwJOPUyhEFvMCZ58lqoRQ7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhjlP8ih9qa/0bEyzpDpugfj56QPNSobZS2os+a96Bk=;
 b=rGGj3kXM1Wt7VVVpqUfj9hpBNaWrIQR/k3Ph94qYSRZn+nfvnrwLsIDNDwF9OPMiQ4jRU5Rvl7jc8hPyouafRBsmcbbPNcu2Ro4Tr1nMMHCj06eOw9JCvxZkMujavs6ll/Ptx6V5bnYsVZgr/xTGcxT1cX9WQM2ROqPg57mKUko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8385.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.36; Sat, 2 Mar
 2024 16:28:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Sat, 2 Mar 2024
 16:28:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 02 Mar 2024 11:27:45 -0500
Subject: [PATCH v2 2/4] arm64: dts: imx8dxl: add lpuart device in cm40
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240302-m4_lpuart-v2-2-89a5952043b6@nxp.com>
References: <20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com>
In-Reply-To: <20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709396885; l=1850;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VujU8+XI0tMmITTO8Cha9rb3l6YvyOKqA72uwNXfTR0=;
 b=T9S4rHltkzTLTjqEoCVfOwmSXp8hfDlmyfb9IQAR67UG3d2HGt+Iex81NNOUQ3INPO0kGbGSd
 76gEJ2thQIUA55xw3213bsMCDpbg98jf0MYxXoSlWX+wXm/wJ9TwcV4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e8d072-38c4-4c4b-0956-08dc3ad5c31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z5sR0xF2QYyxZsK02EsgL7ZNRr0FBrvbNPukaGQR0cSoU/P3zm1YmEkszbzeaR+CbFcsER47SMPtqURMMzXcE9qAvhw25tcGA7hWe9WxTsF/hF8NqIq/Wy+Or/OooCGtAxvRbvx+TPg5vUejxiMaa+CT1G+Nfnm/1+Xw3LkCPhLN4ZfCtFd3+cUPCyydwPn2W/7l/lpeoi0bQoN2XF2ZM3/M/+dC5atAvubfm1iT77Np56/Clj704noLHQ8HzPuOFB0Sm+9I+gJWewI4KHuoId5Al9PSsEpy7dEA0+SxN4vrr72Pj5G10PT5qULaqTmtZulxUsP8n91rAKF2RrF/FiplhQSXXZGRktXntK+h+9OZFZ4zHKlCWUAZZ4uOTLnmnktp5GCtjvjHNE1OAxtFOTCXJ5s/0GpAbYpFsNs9OG3RhDh/DvEgU8RTMeQ+UGfH5gIEpNumHKnC6yIDM4eO5ygPgopF6HgBeAkza7tPQediRnIzQGfeO82xwJYkNnMCjVILuTVi9ctsCzQcxpgXKeF8dKrYUXL2ia+Gkilc0TUJetTvfcf3kTHGTR3AGyuOt5rDvCpwoF/BafY3MouC+tq0p9yPhGqNoQn42hVuZDeD/XcJHg7oB3vioaVzO3ZbSu7fdwqMPJmCRWjufUYailsA3klF5F2QbR2glGz5DKEnmW1lBHgeJuwMMxuuAVTlwWY4DqPp3oLAOeWo5vmQyaMrVRk9fLwR5xX2xTW4gLM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE01S2pxTVREU245THJoWkQ3Y2tlL21nN3JySEFTR1cwdWpvOFpqWU0yUjFP?=
 =?utf-8?B?bzc2Yjg0VzVBNmhhVzZIc09LQkdJOHNFRyt5QW1YUURmOTRYejNoV3NCSUtH?=
 =?utf-8?B?RVVEQmJGWVFLdllCMTRIZ1BnSDZNSnRXcnkyZGZpM3NDNGZlWkYzbXE2ZTZw?=
 =?utf-8?B?SHErOXdRank4MFJRb2t2NWFzWGJEWUIwUDIzN1VWZkJFWmlsQUxBRFFHNDJY?=
 =?utf-8?B?SHQzS0lhR3Q5TmVmU3d4WTlmTnR3RktGNDR5RFNoMG5mVnJ4YnVNUjgxK09P?=
 =?utf-8?B?R3JkWTlhS1k0eG1Fb2l4aVFZR1ZrY2djZFdZMGZnbUliT1hIaUN3WjJFREZZ?=
 =?utf-8?B?YlJsYlpCT0RvNXQwMzFPUy8wLzA3ajN1UnVPUGhINUFPTmJyNE01RFcydmIw?=
 =?utf-8?B?WFZMaFpNVzZQVytOVmNGNk9ZUElyRENGZ2VGbHNxK1JBT2l6Nm9vTDE5OFNo?=
 =?utf-8?B?SU9RbjlCS0VJbjJIVTVXaUdBSUdyb1BFbC83NkVRWW1LdzhUYTlhdDZVaDdp?=
 =?utf-8?B?TmVzQlNjL2pYT3BrZk55U1AydXAvc3JXTzRmWWlzU283ejZGblBBL3dlUmda?=
 =?utf-8?B?Tys2amtGbldtVzhpL1htc3dCUnhsdHZFemM3MzdrUzVkOStGclFwSURINVVT?=
 =?utf-8?B?QUdTTGxQaVRCeGpDZVVRYlZzdTBUTnRGclk0OVF5Z2ozNmk0QldESGRYclJC?=
 =?utf-8?B?MzhQNFhBQjV3eE0vT1hTRlVXMVJ1bXFSV2Nudm5IUkZFNzJwZndrWTFFVDdB?=
 =?utf-8?B?VmZZeFhpb3FPYkNPQnhtS0lCQXNKbkRuL3p3dUU3VDlqWXo4U1JEYXpKTzUw?=
 =?utf-8?B?S3czVURPbWFINDI1clFxbXBsemJFbVdMYmx0SXRnQldRTExxZXI2R2lPZmJX?=
 =?utf-8?B?T25UbVZuZkx4aHJ1WGJDbVZUei9jemwrbHpKd3BUNGxoSTVhR1NESitnRHA4?=
 =?utf-8?B?bXpKWCtuVTdJM09NdkdQRURhT2hJdG5OVi9ocVYxVm9zTVUwcVZ5N3I4REdv?=
 =?utf-8?B?cC82MFNVVlJIZGY3ZHpJcWpXUVpCREFoY0ZrZS93ZEp5L0o1eHYxNkt0STVW?=
 =?utf-8?B?dVF0RnFGMUxYb2EwcWduMmhxR1VjNkpVMXVBd240aExQMUZ4MkRXSWZqMXcw?=
 =?utf-8?B?VmVWb041L3hYM2FjVmFQYTBYclpFUkhWN1JXb1BkY0JTTVFTY0ZSdWNkdUxn?=
 =?utf-8?B?MTlRMTZpUktEOEZ3UElDaXRvNUR3WjR0UDdqNFgzcStGNWN5M0pSYmh4RXhW?=
 =?utf-8?B?RUEwRmxVRTJGZjFVQlAweUYxeit2dlRXRTk1Q0w0bkpKdkJwemN2dSt0UDdW?=
 =?utf-8?B?N3BJa0gxY1lQcXZpOURSS2hWZ3U0T2JCTmhqZVBGTURUdU9FK3dpZWlJdk45?=
 =?utf-8?B?cG8xc0w1WmhSZ1MwZHkwN2FuQnAzYjZGY2dIZjQybmUrcXgvOTNKcjFieFBQ?=
 =?utf-8?B?YTZkeWRJM3JyMDZDTUgvYjRPTGY5ekFwTVJ0N0Z3VlY4Skx3UFdvcS94S2Nj?=
 =?utf-8?B?eXZMU0ZKaXgzcGpzQmxnU0RteVlFdE5pQyttQ1JES0lIT1Rvd0g2RFFtOUlO?=
 =?utf-8?B?bnN2TU1OS0tDbjd0eklweDlwWVBkb0lqUk1WTVhQZ1MrekVrZUNSK0FGcWFy?=
 =?utf-8?B?YlpCYlBQOUZrazlJc1JzSWdvVWR1eVlKQ3dxSHFodDJIOUJ0U01aWWZjcXRi?=
 =?utf-8?B?Y3JNL21OYUZlakFQRTR4N2dwUmk3WC82VHV1bnlLbzVDWlIxTGhmYWxLYkhs?=
 =?utf-8?B?SWpnZERtcjBHQ2FYZnVWRURZR1dOQVFvelZxeUc2Q2M1bE1tQVdRTnJMaWRJ?=
 =?utf-8?B?SHN3cVk0Vm8zS2RscVlUN3A5YStlL1FZT0NBUG5hYUhMaU0xejM2c0ZYRUVN?=
 =?utf-8?B?WWFESFo2blNMTWRUeVBacU5KUTBzd3paSUNKVG9WeFdnVk5abzNOdXViMHJV?=
 =?utf-8?B?bUJnMDFaQkw1T3JldnlOWWFEb1MrSS85VXpOY2E5TkxJYkVGaTNhckNwZXVB?=
 =?utf-8?B?dEZLZkNreW15VVpYYlBTRnJDUzlVSzdVNU9YRTdxeTFQaFJKcTV3aDllRHBn?=
 =?utf-8?B?dERrR0VVOFlVOE1WekJzNGVIak90eVNya0FCclV5bzFQdEY0NjFUeUNBOWhC?=
 =?utf-8?Q?8edTf6VUh00C5/AEVuV4Cgbla?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e8d072-38c4-4c4b-0956-08dc3ad5c31e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 16:28:15.6496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gqold2O3647FTznnIYgBc5+cyuxJIhW0ElQnZRhpPwUx+GimkPI4oq7unqy2I/e2/aNGLkh2LUCQy09+1uTHwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8385

From: Alice Guo <alice.guo@nxp.com>

Add lpuart device in cm40 subsystem.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
index 68043ab74e765..b6af85b20ddd7 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
@@ -20,6 +20,18 @@ cm40_subsys: bus@34000000 {
 	#size-cells = <1>;
 	ranges = <0x34000000 0x0 0x34000000 0x4000000>;
 
+	cm40_lpuart: serial@37220000 {
+		compatible = "fsl,imx8qxp-lpuart";
+		reg = <0x37220000 0x1000>;
+		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cm40_uart_lpcg 1>, <&cm40_uart_lpcg 0>;
+		clock-names = "ipg", "baud";
+		assigned-clocks = <&clk IMX_SC_R_M4_0_UART IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_M4_0_UART>;
+		status = "disabled";
+	};
+
 	cm40_i2c: i2c@37230000 {
 		compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 		reg = <0x37230000 0x1000>;
@@ -53,6 +65,18 @@ cm40_intmux: intmux@37400000 {
 		status = "disabled";
 	};
 
+	cm40_uart_lpcg: clock-controller@37620000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x37620000 0x1000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_M4_0_UART IMX_SC_PM_CLK_PER>,
+			 <&cm40_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>;
+		clock-output-names = "cm40_lpcg_uart_clk",
+				     "cm40_lpcg_uart_ipg_clk";
+		power-domains = <&pd IMX_SC_R_M4_0_UART>;
+	};
+
 	cm40_i2c_lpcg: clock-controller@37630000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x37630000 0x1000>;

-- 
2.34.1


