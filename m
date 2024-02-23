Return-Path: <linux-kernel+bounces-77688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF716860906
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35141C21B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBF5D51B;
	Fri, 23 Feb 2024 02:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zq6gwVHO"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80008C2DA;
	Fri, 23 Feb 2024 02:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708656581; cv=fail; b=Cp/Ck2tc/h46XntlBDRnVV8qFsaDVHyrcVUvuD90NEVIyEue9GBvF7Uq18Gkozyfx6oOP7YTdeG+C70rGdZk/vmMCTB8qnr1T+opZrteJIZqY0eER7e39XXMDSADlPucbG4x8pedFwQ5ebkVTtJ+JcBbqVdMlGVoVOQSQVdwOaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708656581; c=relaxed/simple;
	bh=KW5SpCdEPL2LdGBPcT2TppJpU/y8LjS7cdd7DA9J2o8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bOiRPqchyfqFGyMEgSe3mXUN9uL0VO79pUGT+GRtsgP0ZLwu2TQOnENk2HvYyqfAOerzCSfA/B1P7sohLPDT7KgiSLf0njTf7UeMsINzEE5rbRNzRWaCU2GKArCcB2lfJHZXGFrTSpsKkPu+ZiozVXUllQw1F8qU+151VDvPi2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zq6gwVHO; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBrI3ZXZp2y4X0+wCAGFkRdsYJJ2HBJ/AvFm1kTL2qSgxWbT0FwUC71oPO+woT1gSk3afVZoWDvk9NpN5pe/UujA3xy3nR/jKjqGRaxgIK4TL5BAQmC8LwghkOUTCWKAvOXpyGxt0n1IbuhW4FYock9/6VNTPA8cXrfW/xVx/oaUTYtn3Mp3WcZRm5WCd5vZI7clmOLzeP1kicwJk9XfWn+u0CPTTueRdVGZSVB+zWUMJv7FJ/jWl1xa8NsIIIuWChMS5yfokiqQw4f+Pes/sch0jZXICwGEksixLu2MkEpWU3FGWVvNoO+nvGZsLyBh8/kIqUkEvFf8H1Yyu2sGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5vhtTEqu/O6IOvfHYimy7LsQIkOKHvC8ntMI5hAvSU=;
 b=SG+Y8NDV7Ru19xfIMuIUUh6nxaWaRvzIDMffqXu5zoqNCJNZjnIca8Lt/DsRrADNLzoiOofBd89kksm7IwH915SuBgfcBDCDiCfWo9fZX1mIn4EUkb9bZzQ5g6mpXizK3Q352qWIsoYkUtwHlc/auiDyceOpoAVZV5CryGvq7chrsMARUXnUAwmuBi1Nuo+5RUQUdhLrzkmJbnRyjr7AoYX7wdopIzTKVW9EkNijkilk9BBUkAcqZINb7FLO/PjKbXYlWkZn96C7yJD0IiGbjhEWmwUZYsGYtEMauWBbI/YhDUxBOCE+Mwi82OVfhfInE75bQhZDet6hZp6XvMvm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5vhtTEqu/O6IOvfHYimy7LsQIkOKHvC8ntMI5hAvSU=;
 b=Zq6gwVHO6mLMt4O8o2pZksVqr4BmIdV3lOt2E6dAfiGypSBCJ9HmuZ9g04lr9Or6QX32Yqgbo4bW101BRNi1/b3719dmlo4ZxrCKiBC7h6nE8aGR9miI0jYPn+zH0huketB/SfHCGDqa/qeOni3PuG5N03DljgFvBUmcKG0eiAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DBAPR04MB7237.eurprd04.prod.outlook.com (2603:10a6:10:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Fri, 23 Feb
 2024 02:49:36 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::6ab4:485b:3d5e:e0e6]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::6ab4:485b:3d5e:e0e6%7]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 02:49:36 +0000
From: Liu Ying <victor.liu@nxp.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com
Subject: [PATCH] arm64: dts: imx8mp-evk: Fix hdmi@3d node
Date: Fri, 23 Feb 2024 10:57:38 +0800
Message-Id: <20240223025738.2486807-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DBAPR04MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 493b3014-3365-4a44-7e38-08dc341a126c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vo5vveK935rhAZ7hIVKxNv9ka/pYQ1srtRXQFor+7Z3mfUw4JJu2Z4Nkgso8f3/oipDS/EXNE8OlQKNbk3F5KHx6m6G8hFyFageSg7ZAbG4drSQz+gJ88o+kL0xeJY7q7Drz/OFIx45ovfwd91tq/763+mG4rBVdhNNziGC2yU3TinQc051TZErNG31Yc169Ql5Ydw7MPSPlNrLPWIr/HxRYQHNBP2/1s7gr0Ji2yjrKq7LSISPYW78B7oCbEhIBM4NeW3eUK9++x6YrIvN1dmVbjQIc+aNdnegEnM6d758odgsz3mY9nhgfFLTQvkamRC/SNyhvSvgGvC036j7hLWj1kpUxAFIL8xeqLaqyoGjC6A62EhSYUJJ6zhjT3Wv8GZIMGKdPdI1mG83sfAQrHgncsoZxMoBr+ONJuOZyZj0okTTwSlLfitqgvrP+lu8e1b7RTMCaTYDt6IhcXYuJHDTwJmUF1JGBGrCe6meVGh8O9czRgUUFeZCrfVnRd3PVZxj3Y8DgoiFIYfFu45i0mVKyZSGYGZv7RKsk0VMlANaSyII7BQh2HMCtZoHvnUQbF2GxEFza5SP6WUdvlGG/m9DYmvT6SDYVDAfIb36PaQUnXorM4iutRIWyOnpM4u4S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7r+ADHGg5PkgF441YnvfkRhaY3GhU+QDkWQjTkqmy7DkdG6I0ftkbLlvNwfU?=
 =?us-ascii?Q?K0zROkNZoiiLZ88QcDU5wEDlY5twZnhfBUYHdC5VTAkJp1RFtmedW65ADflr?=
 =?us-ascii?Q?EZaFFAXvKkE/Nqg+JqRcXh9VxTjG+eNeoNAWRkiFCUtI7/SNtcn28wNP5Blf?=
 =?us-ascii?Q?HDK4yw7g49gwJlxhrHvg2/w1DBXAwVblvgLrjiviiwMfCRHxdFxQGoH/RGu1?=
 =?us-ascii?Q?dR+NWY++mOexC44jVfNgbqT1tC1QtCMrTnpgMFQHrPHQW2V7cjlq8gayysZ4?=
 =?us-ascii?Q?9rN6PkVqqRs8M0DHBpKiz3Ai+22PLqdK7x+qeSP8s6sVDMBsN/OSd4+d3Ks4?=
 =?us-ascii?Q?M9MX0Vr0mBpkJV9xRBe95APr4DitAgXTJLH4egtIWYGn523cDNTAQrMH3+D2?=
 =?us-ascii?Q?+NRODa/0rYkWgCtTJpDSj2fHttLGxFzXYWD0XJW8zou/6CLPxSIG0Onyo1bp?=
 =?us-ascii?Q?kjiI5a8L342THG9fPkkGheEhdyrplnB1cEBNDg2TqJ5DGtfEwhHXEyPy+Zfx?=
 =?us-ascii?Q?8D8RlUx61l8fz76jxKcaIVRClwP73KfiOIoKYtGJOC2PF0XH45H9kcEm16r8?=
 =?us-ascii?Q?UBahwP9DErM9H5+k2VFQzItCQQZqOhjYcgGBQW62Su+2+idy5G/OPnAeYowE?=
 =?us-ascii?Q?KwlM5xO//RGZyiBoNqDm9vAxs0hNBXDDJpF2GQttnIWW993nQ88pUDg4CwhF?=
 =?us-ascii?Q?+th40cTQ81zV614WIq9calNH3NBWTsmrscnSW1KgUXaPiKheRJeH3OaHMvVb?=
 =?us-ascii?Q?GYjGsB1bQ4XbUkzHStCdCF41lKyQh9jEKhSwG1Tu7BplGi2PjnQ2hvW6gKu5?=
 =?us-ascii?Q?awjgdt2ZInJOs0cC5Hg2aawelMT9NSgZERvecHXYK8hwy1zs6UDpdI1Rg2Lq?=
 =?us-ascii?Q?TFhNqPer4pS2emtkSx9d3Mp63AqVQ09sFF96f5r1Pq/s+p/FXyEm6iSMHhzx?=
 =?us-ascii?Q?aK8vcTy8X0WQN9Y9NdR7t/H0NFzsix8Sp9K77lvV1XZbkhw4sGsEilGO4HuY?=
 =?us-ascii?Q?t4mXvUw5fe7oXOy5kghyb5gKTagbEY+jhUOhMdREA9Ad9CRMzYySQ4yDdQNM?=
 =?us-ascii?Q?Wcwx/JIESiYDzJJdZ39MpuEG6EwLulGr6g1F+QekLVkE7Hwl20MXpmtjgDOJ?=
 =?us-ascii?Q?bIjWF8NDwpXNvWUlLTkMMLsGYOo7zZNt3fwcES30+UT7Vwax/cZRS7WU+ZOo?=
 =?us-ascii?Q?WafgA4IX5az2isU5zfu4w3KS8dHRXZ0jww3WyP4VMXWC06wSKUr4+ECgQcXJ?=
 =?us-ascii?Q?h/04M5e0cnEwaXzmoLmrh2bs1AArtKN3nPGA5ZWhEJe5JyGMuKSdynT77cxs?=
 =?us-ascii?Q?+YG3EQDd859ADuoKOES5j5t4oRM9VO6PxzJ8T8/PoLgTOWkj0A2d/1jZSnRj?=
 =?us-ascii?Q?SC9KKvy2mw60OS3enyRdcItBNWVXnImxwSaw0jW8bPAM3gYnpx0nU8D/q0yP?=
 =?us-ascii?Q?MuYZ73b52e2xs0cDKaz8XihtaLEuInIU1juwiJtXMOvEqrpkOqxMbZks/uly?=
 =?us-ascii?Q?yvVQemdECJRewW12KYfwugPVB3E67ozjerigQRyYvfc3NIPqEKc+DNBSIMZo?=
 =?us-ascii?Q?G0+GBQxB1OQFDiWgcZh7o7O36I3Y88Q8qY8CNvj0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493b3014-3365-4a44-7e38-08dc341a126c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 02:49:36.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhQLpIihPPC7rl4tXJA+cFBRyaMBtijl0C0iFUm79OTrL1T2SfhCALJAyA4ytiwGV1h6mnSBNsRYkx6sQTSoRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237

The hdmi@3d node's compatible string is "adi,adv7535" instead of
"adi,adv7533" or "adi,adv751*".

Fix the hdmi@3d node by means of:
* Use default register addresses for "cec", "edid" and "packet", because
  there is no need to use a non-default address map.
* Add missing interrupt related properties.
* Drop "adi,input-*" properties which are only valid for adv751*.
* Add VEXT_3V3 fixed regulator.
* Add "*-supply" properties, since most are required.
* Fix label names - s/adv7533/adv7535/.

Fixes: 65344b9bed3a ("arm64: dts: imx8mp-evk: Add HDMI support")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 33 +++++++++++++-------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index f87fa5a948cc..9beba8d6a0df 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -23,7 +23,7 @@ hdmi-connector {
 
 		port {
 			hdmi_connector_in: endpoint {
-				remote-endpoint = <&adv7533_out>;
+				remote-endpoint = <&adv7535_out>;
 			};
 		};
 	};
@@ -107,6 +107,13 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 	};
 
+	reg_vext_3v3: regulator-vext-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VEXT_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "wm8960-audio";
@@ -364,7 +371,7 @@ BUCK4 {
 				regulator-always-on;
 			};
 
-			BUCK5 {
+			reg_buck5: BUCK5 {
 				regulator-name = "BUCK5";
 				regulator-min-microvolt = <1650000>;
 				regulator-max-microvolt = <1950000>;
@@ -415,14 +422,16 @@ &i2c2 {
 
 	hdmi@3d {
 		compatible = "adi,adv7535";
-		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
-		reg-names = "main", "cec", "edid", "packet";
+		reg = <0x3d>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 		adi,dsi-lanes = <4>;
-		adi,input-depth = <8>;
-		adi,input-colorspace = "rgb";
-		adi,input-clock = "1x";
-		adi,input-style = <1>;
-		adi,input-justification = "evenly";
+		avdd-supply = <&reg_buck5>;
+		dvdd-supply = <&reg_buck5>;
+		pvdd-supply = <&reg_buck5>;
+		a2vdd-supply = <&reg_buck5>;
+		v3p3-supply = <&reg_vext_3v3>;
+		v1p2-supply = <&reg_buck5>;
 
 		ports {
 			#address-cells = <1>;
@@ -431,7 +440,7 @@ ports {
 			port@0 {
 				reg = <0>;
 
-				adv7533_in: endpoint {
+				adv7535_in: endpoint {
 					remote-endpoint = <&dsi_out>;
 				};
 			};
@@ -439,7 +448,7 @@ adv7533_in: endpoint {
 			port@1 {
 				reg = <1>;
 
-				adv7533_out: endpoint {
+				adv7535_out: endpoint {
 					remote-endpoint = <&hdmi_connector_in>;
 				};
 			};
@@ -524,7 +533,7 @@ port@1 {
 			reg = <1>;
 
 			dsi_out: endpoint {
-				remote-endpoint = <&adv7533_in>;
+				remote-endpoint = <&adv7535_in>;
 				data-lanes = <1 2 3 4>;
 			};
 		};
-- 
2.37.1


