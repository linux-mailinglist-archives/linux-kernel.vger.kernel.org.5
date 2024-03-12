Return-Path: <linux-kernel+bounces-100006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08B2879091
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3291F2355E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2BF7AE59;
	Tue, 12 Mar 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V+5nmWl0"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2069.outbound.protection.outlook.com [40.107.105.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21537A712;
	Tue, 12 Mar 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235056; cv=fail; b=TwHxML3OCruWXRJK/6wR76ppVxRvWnjwWiUd0ioA13sPbjYo1dH9ixr8FyTUfRmU8/M2yiaopaXZmzGN+Og/9M5A+MYhDA6isvhjGGvhhe1qpKEiHAsQy+TkFCJlq/lPwXaS+C2fKN/yHCExvTm+HcJgc57+oPJel885e/z0dV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235056; c=relaxed/simple;
	bh=N31P637R0M1yxUFp9OpdQuRGbcrccLdnlJI73j5Pxy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AuJGflNDIVPWYQfzZOAVpvSsOo1lZIsfflzjYcg9byyGqnOlYv9MBOLUl/9ovuzea3/JkG5wXIp4v8tPW91TZKQODlp5wVT3yzZsK8cFh3Gm1OC8GmTPUjaOpJjRxuvlEldXcOjh9elG2QFlhy9zB7wlZgCGvRRQ1g0JV5oTegA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=V+5nmWl0; arc=fail smtp.client-ip=40.107.105.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr2mRj1v8N207dXRHVA48ECbfYnQC0eGRgsmezFbqjeUaTE21YpqpFU9ksuTI9gyi9QdMBPIfg+m1w8f3ly1rQNWY/l6CmEwWEpwR03AzM1kHC0QQzYXyAHc5g+gWKE7JguRhL5hsfTt+pCVAjEXb29a/Y7/lCaPoH8ta7BwZBeotHi/zb23X/V0Orjmw+ZqTpTOHvZ4nPTuq/nvRIDyCtnXjIN751I3+Xx7YyZxNlqVCL3/kWzxdjw9rgyRUfKy81BHPra8aBtWM1jnhpZcnevKsNnavmq/AF/BYp0CVSti16lwME4MhgbkVM/BGq/RmZiaZ5BwreqtGBLr8axPGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHHFWhWkgPG2hHrytmze84YyacUB7ukMkIfadblW1wk=;
 b=Mfe9FU3b6NNZKtGI5JIXKIIRWaY1IVNwo6KedCFoD3VIOcDk4gh9uQkgjr0jCZ3PMleZQfer9nhjWkteGJWHS1KOdhMaYsbF6HKlv2ZZARzQyjTcDUlQcICdoMUzLKNNS3KVtj1eBQZh83dxji3oAF69e3wl4OZ8TqfFvGA4CpHm1g68YYUsSkiKFB3g8XY46zz8dAGQ1rDK0Op7CdS0FNtYbgy0LCcZlx3I37J5TEqa8Yla6PVfbbFEJuRbdaFGF6c9xmkNUT/rGt29SHVdIDC9ZFyJAbD/SqFxx/nC7riee1ikpNSK1nrpH9oLoqdfHUdtazY5CGeLOiN2lmLrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHHFWhWkgPG2hHrytmze84YyacUB7ukMkIfadblW1wk=;
 b=V+5nmWl0gnh1D/juWjADYcBuDhrvgcLtjmr9HeAblBLevF9h89z0FUWTYg0Ycw+XWZ8wN8nl9OXBg0Pjt3jto1sLBh5k5H2a/1RZK7P1UzFdWZUTEd4pctsnBk8HJtwMpbDgaEaCp1LYPdXZQ09WzEp9jam1+qALetlS3KY71xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 09:17:32 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:17:32 +0000
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
Subject: [PATCH v8 08/10] arm64: dts: imx93: add usb nodes
Date: Tue, 12 Mar 2024 17:17:01 +0800
Message-Id: <20240312091703.1220649-8-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3bf0e97a-a4dd-4e59-98bb-08dc42753f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p1ZT5B7gDfaIDQ5m4GyCLN5izmzAahDWl1xq3fHHthdhD27cV7IvXoU2zb+hfvPSEb4GFUQPm7aPnRMpOQRlWKVB79JSh5ceUNrum1ofmvB7RhhVQDECo/2UJfFL5zAHlAXEBCqmXk35DJ2VR0tUlWwj0ta9NlfnuN3BUpA8/RePKOASQ314/LKkxOfcXB9jVuWjSXq4fDoM6qt7Iyl2m/zTWtsnMbyOk2/uQLd9JQDSUH7TLEkUIgdgyR47M7XoSXpmwJXafLzxfpOjQYLv91+v6IIN43Qw7+L36RnkrwNSMuvRE30bixDyy1EPz0SdMXX2qunbk3ePpd9jlPD3+D64EXBS0XKF1GahmhpDlTtSK4k1MYwZZZkJ+NhsWc9lHLuyBlpXc60rX0Nm6H6DKugKWB3fZIjg4AcRfFgzhLQ1CGpB3OPXINsm+TlzMzPQaDwcBRZlaEYWgFaFGCeENjlXkcLC3l/+Plj7Qc+SNeiTPZb+oZD1RA0slcnTIzaTq/XegHLUoPPq4xqcD/EKE28HqUxo0y9UVw2goLKcrEZBdqrS1gKjVLLyRNweej9RxKwCy5f5xUK/eiNxf3UxPRKXZuhQdRjqUuj5/ITT0UAURYJge50Ve2/6OUDvkeuLiitG/fqShPLN2kyCQcruhC1uOnJAoq682pbPCk5FUOsXYob9lGvy7hD0Fc79gA0DLbpHytf5DEyQ3KAAHCND29A6D2TNJ/jGTtJRFyTIpzk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2qNc8cWUUcg+FIfCIW3q0mqNQLN0+dfY5ftWsmjGfDwAfF61rA9Noy+kDJt+?=
 =?us-ascii?Q?62J+D7vuN13Pim0PZiotM82o0F/ezj0EJl3Z0GNNwnrCbZOsew8iACfsQR5x?=
 =?us-ascii?Q?vhOo+GGL9ROZQ9aYlRvqDjyMZ9kERd96CKZ0W1gXb3z8WkyGvMx11MW21Epb?=
 =?us-ascii?Q?2gIMPTlBUJV/gH0HkGdVYjt7fu1F1E17TevAOcmjjfAAJH1Eq294FUfeW4o8?=
 =?us-ascii?Q?JpAS5HR2ZPGN4soo02215P5sw7LXfc5o/e3L7mExNL/087qRmYjCIQIeiJ22?=
 =?us-ascii?Q?p9kvgAzzkoT/GEYuKHnPfYdYjCBmlNeTRaKdeB6V4sa17vgut5u6vnFZ6jZm?=
 =?us-ascii?Q?vGAq1OQsE+FTVKUl/BWfj4zcgUzxq6CTaunlCGIyggwtcpbUfeYbAXBM/f1g?=
 =?us-ascii?Q?gf8vahv3546iF5KjpfVC70JpCBUoqn4e80p1kes56TCE7wB1DVeGnw9qQx1R?=
 =?us-ascii?Q?+WeMZCb8UJjedN0Z2KFnnQ3GbeEulKn+ezRdVNpzlrZzoeTenwbiT9A50d6Y?=
 =?us-ascii?Q?+B8YEftX3HaNVjBTccjbiksZUnIF+P/tNJ1pMAl4jmKHwuAm6W5HA1oKCDaD?=
 =?us-ascii?Q?IKhGtSUQoh1UpA3YEIw9xC1JfLvrKZQi7a0nt5136hNHxUGQmTmX1YCGF7Wb?=
 =?us-ascii?Q?mPy1jvqhp0ESwU0QbpyjJUmc570FgaDONRr3fCX01xAfrM+shTpKzsPwOnb7?=
 =?us-ascii?Q?8adLt9hVMY1jSb1ny4rmJ0tZid/t3kVnKS6yNLlAxrrIyMg+sxDYn729SdqU?=
 =?us-ascii?Q?cHoxKVnUJrEznRI2ZMx4vuaif5cMk7SToKYiLN/CU20eHhf0W7JgCvv4u3ZN?=
 =?us-ascii?Q?/Gg0Ug9Cx87o1OUaLk49SyqfM9S+OrUTNQHnpL2CBY3ZKpohsw0efQDyY3DJ?=
 =?us-ascii?Q?enkxgRLsgkxi+pwY9fD5zM1mb+yvQErb7xB+GNe6H3p1RQasxQtxbfHvPKr7?=
 =?us-ascii?Q?uqk24xJSjmFwfTCuwFioUgvX+WCK7mbxOnNCYm+uGhle7v9y+geooHEBLxkA?=
 =?us-ascii?Q?vGmzcW1tiyfvbxpUXyd6TlDid38n0umI4dH4ywQK058H+grfHsgghpauD8ra?=
 =?us-ascii?Q?hwplMzaxkHzIZtPdJAUp/HcvIvb4fkjmWzFpPjuQ+abXGLbfWq8uR0kZznBI?=
 =?us-ascii?Q?IeIntzMq+5TJuKQWSToUg5Dcrdm3lMKglMF64By2iKALHMAgvSf18Reekk59?=
 =?us-ascii?Q?FDedoyJYKLSwvOc5tziQ/wkREzPIrWf6crMb21xps+ujPWCPUa8ZcfKCQQh+?=
 =?us-ascii?Q?coytwbpj+bUl8fVyaQTdWuO5AzuMEWP7vEPz33VxzDGRO3ybqom7DqtpfrjQ?=
 =?us-ascii?Q?2zfXG31ZwAP0QI2uT5sisIvdmxSBAuWRznuwvpQg28IhPeZ9l4NqwbEwoGsg?=
 =?us-ascii?Q?yG0PY9Nd9C2kKHwvkcLvpehtwvpQ0XRqbegzVQ+WKXSnEFgx8ya25P+yz/K3?=
 =?us-ascii?Q?Jsk75kBWVjzGCywWvq4bStCjJ7WR6N1Xzr90F6AWCe1tgZlPVjrbbdX2wDgQ?=
 =?us-ascii?Q?VTybiBbQid4LXoI9TDMXCeLPnznSFz7GoW8itVrNrLB7NGRsTF6xp/2fT3Yt?=
 =?us-ascii?Q?STVMPI968FvlxC3JYViLyBSTtzUa+PQ8t3sATa/l?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf0e97a-a4dd-4e59-98bb-08dc42753f23
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:17:31.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dbD56jWmRWbWuYVwmsAw6rLC/V5VUUgnILHmks4rs/njIPCqjBPl7hshE8wnYjtDoh0cZiMqVsoADspg1DO5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876

There are 2 USB controllers on i.MX93. Add them.

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa9352LA/CA
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix format as suggested by Alexander
 - change compatible from fsl,imx8mm-usb to fsl,imx93-usb
Changes in v3:
 - replace deprecated fsl,usbphy with phys as suggested by Alexander
 - reorder nodes
Changes in v4:
 - fix the alignment
Changes in v5:
 - rename usb_wakeup_clk to usb_wakeup
Changes in v6:
 - rename usb_ctrl_root_clk to usb_ctrl_root
Changes in v7:
 - no changes
Changes in v8:
 - no changes
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8f2e7c42ad6e..4a7efccb4f67 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -183,6 +183,20 @@ mqs2: mqs2 {
 		status = "disabled";
 	};
 
+	usbphynop1: usbphynop1 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
+		clock-names = "main_clk";
+	};
+
+	usbphynop2: usbphynop2 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
+		clock-names = "main_clk";
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -1167,6 +1181,50 @@ media_blk_ctrl: system-controller@4ac10000 {
 			status = "disabled";
 		};
 
+		usbotg1: usb@4c100000 {
+			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+			reg = <0x4c100000 0x200>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
+				 <&clk IMX93_CLK_HSIO_32K_GATE>;
+			clock-names = "usb_ctrl_root", "usb_wakeup";
+			assigned-clocks = <&clk IMX93_CLK_HSIO>;
+			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+			assigned-clock-rates = <133000000>;
+			phys = <&usbphynop1>;
+			fsl,usbmisc = <&usbmisc1 0>;
+			status = "disabled";
+		};
+
+		usbmisc1: usbmisc@4c100200 {
+			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+				     "fsl,imx6q-usbmisc";
+			reg = <0x4c100200 0x200>;
+			#index-cells = <1>;
+		};
+
+		usbotg2: usb@4c200000 {
+			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+			reg = <0x4c200000 0x200>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
+				 <&clk IMX93_CLK_HSIO_32K_GATE>;
+			clock-names = "usb_ctrl_root", "usb_wakeup";
+			assigned-clocks = <&clk IMX93_CLK_HSIO>;
+			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+			assigned-clock-rates = <133000000>;
+			phys = <&usbphynop2>;
+			fsl,usbmisc = <&usbmisc2 0>;
+			status = "disabled";
+		};
+
+		usbmisc2: usbmisc@4c200200 {
+			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+				     "fsl,imx6q-usbmisc";
+			reg = <0x4c200200 0x200>;
+			#index-cells = <1>;
+		};
+
 		ddr-pmu@4e300dc0 {
 			compatible = "fsl,imx93-ddr-pmu";
 			reg = <0x4e300dc0 0x200>;
-- 
2.34.1


