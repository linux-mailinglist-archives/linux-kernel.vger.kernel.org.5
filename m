Return-Path: <linux-kernel+bounces-99999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F79C87907F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB69BB22649
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5434878271;
	Tue, 12 Mar 2024 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ix4l1ImW"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D67828C;
	Tue, 12 Mar 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235031; cv=fail; b=kT06WZ8xu+/ptkeOh8E1O1NWnbUz5nRb5/WD0P33IyD0r4Wmg7OhKmHeTQK8KyOm7Kb7XxRtWb2U3XoEWopWxrIO9f1BU8fRxV1olNdCG1pB2WsrEnMgpOA0U8TjzAhsBtYdyO3Efdh9jgSgmUdTQRg6+LMCnPj0rOPACZF9XaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235031; c=relaxed/simple;
	bh=mEddcBmSoS38U2pd7ScMVIwHinvb581ha6ge2Gu/04Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sgZ0c5H/0K85SCS5DZhcI34JgcfiSYLnKGdO0IuTHT+J62+u+ckth+mSdz8EtMrR+ep9MHKD+pibstKLDFQkG1pUlgWqR2vQqRhUGXdYyhg8jSnpP99vTQ8YTWHc0CXR2Qds/OGvUZ623EdpGfcr6ykwqx6w31sWDQezGz3EaNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ix4l1ImW; arc=fail smtp.client-ip=40.107.105.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsFsgWijNCX2mpas9i3iKPwexoNkb7MguyB/S6oZqiOOwqZ5a5ZqgeD49uT6Hu9/34q3eVB+P5sbDVc1hFcafl/F7ZBFeG4d5apwqw3xU0liC/1MsPxYfMUU9F1P+VYzxlTgOqYbRtXyyoG/5lDqvyMCiU/iNiehGie814HIlwKGzD6W7q3cx0esK+iEsUzvdSSh5TNpukMvMZkanbRIZV0cM9bdFhFz98VRQ2Oswb39es2bhti3zT7JrHefi1J+Od5XA86E54As+Ncw+Q5aZa12buNX+XqEuE9O3zDIrEg00YYa+oaJt/pkRvIL7++FrMvxPkdfN4CEgZuYFsDcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL48/gKVxU44asqHbC6xgpZ+7wTeQw+ou+MApLGIZ/I=;
 b=FNT0zTtY1Mn5INyAOLcc2OujORUT+Lcf1Ekbbm0bD/N6hdFD8E4ElQEf+88NCX5G55nPWapaF9PbR0fFRIV6XlBf6gG1sQmZwZLytdxj4jOXLsJDSplBQiSZUBgNTXQAvBPxHMZ/tv2oE2sBQtzWkFOROksGpSphlKJMQMDvEug1Zuw5d6J2aliVctGAVDqtvSm3HNbwsUEqbFiL+1myar6WKAKgLtJTCiwI+xMYs7uyfNbSXe1ghkqIhz1frKHle2nDA7gj6HQW2NSRNJENQyJ09HLtkjiLo2XuwK7XPxt865k7UA9PxWpeOwivdMcJ2LHxZegN0dvq84DQ7VRbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL48/gKVxU44asqHbC6xgpZ+7wTeQw+ou+MApLGIZ/I=;
 b=Ix4l1ImWKOATYSfmsVjXBgh634EuwHmM28PKNBvbys8UfzIiEkk2c+xfyyBle0/YBLujP1E2Bn7Asu00XM9qUxdoD7HKzW90LhfSSXqkSRLMMZga3PIXhpJgNUUTo3pM6GHkklA9q2Sbj2IM291dVj9WCpyARohaM2aRR4l5fA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 09:17:05 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:17:05 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/10] arm64: dts: imx8ulp-evk: enable usb nodes and add ptn5150 nodes
Date: Tue, 12 Mar 2024 17:16:56 +0800
Message-Id: <20240312091703.1220649-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312091703.1220649-1-xu.yang_2@nxp.com>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d551a25-9459-437b-4e97-08dc42752f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6b+CZK/2unTyl9qaRTj0b66ieLlQ+zN/3qMFQ5USXuhYjh+ABfWt9JvBPm3fwQ7N/8XDGC067hrizC+q9EiFWg+DDrCIr92Rwk3W/I4xcJWAg+5hFtd/ra7ocWFVN07h+MV8q3iwFKtZGxcjJbXMnSRVru6M/apef1JqtiQLSgMPKy9DdiJVnJbxvNT+iWXeDc4Potc4rrxDlAsiZe/qgfGQ27M44eyx6OUfx/k8RO4PDG5TXEqNr6OAiyLwSB89JGg7p0i5pQt4IklMT2nB4QC0Gtctsq6BuAxK7Xg7kyPKBlxI08IqPt1kZ5XPWiPMjtELr6YwVqy0M+mYcS95PYJptpb3J35PX8Tu8CXuiDhgedAny9mKg9YFNtiv4T0TbAOUgBxCkQY2ApCEvjseeram635mLjW89Q2Nahi+Kp0T1hTzc9sHTVU+Fi0mrL/aUTAcWqSKv5QDPctMqmVzJ5+nJ8Dzsvskl1/ffG0DnZSYo974kVvDhj1VFxHLiX4jyyriilXZrud8n5glPA4CNKXvACaidhf/EbBqkIuc0IqIhP7hVq5Cs6c6bs/9M2acZHrz6brPJfpJgjf4wAKE4qsm420iiZL/g6VwF/KuZ9tBwuhGowO1JAWKn/RWUWuDjEzq5JqQ1lPtGYNb+4TaZHE9Glgg1l0DARVyOi1hUOVYUkNi/tIbiqPhN5hb7/IhNXWdcVuw1NVrLm/Vc3Fi7A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ed+P2GoW4KPuuR49TYcQ8693RQ9tcnQDjSNKYTK80dX3SKc1YwcvCfViDhm7?=
 =?us-ascii?Q?sTMhS+i1pd4RNVnN+ydE8hrIRZHE3M0yHJMT7YpBwA10tPXT2sM6L8g5woGo?=
 =?us-ascii?Q?4QLB0c4XXx1jrINs5R+IShDJ3Gfv7H0OW10d3cib9R8/aqHYSVo7QbAVzhfR?=
 =?us-ascii?Q?HsbonxDZeVIv24S6bfjKp5BKHIMBsSIqmQJ6m4H/PHQVtHv2mqFfWpuGxvG0?=
 =?us-ascii?Q?WDDtN2T4K4lThGVodFISxZpttd9P7Sy+9L5XfBvm5t96ojWebUNto0R9zUNx?=
 =?us-ascii?Q?0GSH9qI/zNIQt/M4TcVvaz6qZrKgRE36pSkG8Wz5X0HA+uxciMC5KsWsEXsD?=
 =?us-ascii?Q?ayK9SDjWKUXC0PcIXkJlk1lmu8LGSSEdxfCU8LAgKnnrv9rAUNUZ/HOYOCL9?=
 =?us-ascii?Q?1flSwXIXBmHgvrh+4nQmf9Uf9dgj+aAo/HfwbuZoB2cWPCZaw9vQChEcG4L6?=
 =?us-ascii?Q?f1kPSXvVVvc62Z2O4vZHPYWrPD0bLPmgLTaX1B2ZV7vVTxs3hy8XA7phFkZQ?=
 =?us-ascii?Q?yLaRKNpksKVBRq1ubGSRx8zoYdCQClVFsWWyFPDtTn7st0lhaUAqWBSKmrvZ?=
 =?us-ascii?Q?HC4o3J7Co4/fpwkoGvOkK60t8ImqBTMQBkpBacn08JonEdP/nSAYfB31NH8r?=
 =?us-ascii?Q?jpvoen7JvxOov5KQu2SHAfVCXYOGK5NT9SX4TB9l0rMyav0dKHzglQo7zr9c?=
 =?us-ascii?Q?MRl/OgIMajdc+HVT/uJqUAdZvtNgTQsbae9u7s8HU3QmM90PbEClO8ghleRu?=
 =?us-ascii?Q?8GAhedwcANKl5Hc+WgkHzqAqFty3hTe+A9zxy2/6TAr/avToAHN2SmnV0Zuv?=
 =?us-ascii?Q?/qhvC4Iji5p5XU3N0Wm+Og7L6WaaT6d5dCwXBjkzqaYQVJpBV49RTu9gdGeW?=
 =?us-ascii?Q?iYanYeUW3HxgMnbGGlh3s1JmHxoRWoxmq5ymJUCx5Z8ftrg9GEFZiGKjRTiA?=
 =?us-ascii?Q?0YgbKZlhd0foUOFJtcE671JPtxfRSnM6qOB+cwHNs75R3P4e+irqKja1Sos8?=
 =?us-ascii?Q?5moSLfyys4UpG46JJ3sPhvJmyFvC0Bp6qh5DBBWpaP3NglecyOOoIGMgCa3y?=
 =?us-ascii?Q?GRFGNDObTuPPm8nJUAcru993qzEF32Dc+apUtdSD42Q32qerwtW39Ma4pRLR?=
 =?us-ascii?Q?rBegeXrKAH9KE/pib91fKCIcX0zdYz7fpRzuUKX890yKR/DSI/lHcf6nMbAY?=
 =?us-ascii?Q?eEV6z82tIJEXWEHJdEhV9JG6EydJ7Jq4ED7h2KHphztiffn3Orn4JwlQrcdC?=
 =?us-ascii?Q?Sc8jKr3pWmHZeAUIPOGbQgZaB8jUXp7rpLhgSoaMLxe5yb72GdEBoTdJakVc?=
 =?us-ascii?Q?kcfrRfkxmk9WLf5jR1Lk12wzf8j0Ru5wEL7N43mgt5smybgXCoqRB8tU97rq?=
 =?us-ascii?Q?6WDhso1sJcAKEzqpbcQjzd9KY/oJ0M+sm0vCC5hN63UoTVjEzIvfSS4LPg1J?=
 =?us-ascii?Q?C5x6oFH8xwqDq+yDL7M+0pLah/GKNgmrzGlH6l11uOhHP1XxPskK1EO8r1fb?=
 =?us-ascii?Q?zm9ak4gv8PxxS+lSBBsc6lSUMKassUGn3xb5QuiyzQtzNkYX6EV577ljqxqU?=
 =?us-ascii?Q?PxDSESyBcvHH2mD+2plQvrGMJUVeqxfFsYGCo2E+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d551a25-9459-437b-4e97-08dc42752f88
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:17:05.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tG/0WwZrnEe+pakgfw9OCOThRa3/7v/JwW/Kxhb/P+0kUs3DveVj3Ig/erFenD2khilodEeOp7Wd/YDf4z8kQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876

Enable 2 USB nodes and add 2 PTN5150 nodes on i.MX8ULP evk board.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix format as suggusted by Fabio
 - add PTN5150 nodes
Changes in v3:
 - no changes
Changes in v4:
 - no changes
Changes in v5:
 - no changes
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - no changes
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 69dd8e31027c..bf418af31039 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -133,6 +133,64 @@ pcal6408: gpio@21 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	ptn5150_1: typec@1d {
+		compatible = "nxp,ptn5150";
+		reg = <0x1d>;
+		int-gpios = <&gpiof 3 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec1>;
+		status = "disabled";
+	};
+
+	ptn5150_2: typec@3d {
+		compatible = "nxp,ptn5150";
+		reg = <0x3d>;
+		int-gpios = <&gpiof 5 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec2>;
+		status = "disabled";
+	};
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <110>;
+	status = "okay";
+};
+
+&usbmisc1 {
+	status = "okay";
+};
+
+&usbotg2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <110>;
+	status = "okay";
+};
+
+&usbmisc2 {
+	status = "okay";
 };
 
 &usdhc0 {
@@ -224,6 +282,32 @@ MX8ULP_PAD_PTE13__LPI2C7_SDA	0x20
 		>;
 	};
 
+	pinctrl_typec1: typec1grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF3__PTF3           0x3
+		>;
+	};
+
+	pinctrl_typec2: typec2grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF5__PTF5           0x3
+		>;
+	};
+
+	pinctrl_usb1: usb1grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF2__USB0_ID	0x10003
+			MX8ULP_PAD_PTF4__USB0_OC	0x10003
+		>;
+	};
+
+	pinctrl_usb2: usb2grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTD23__USB1_ID	0x10003
+			MX8ULP_PAD_PTF6__USB1_OC	0x10003
+		>;
+	};
+
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTD1__SDHC0_CMD	0x3
-- 
2.34.1


