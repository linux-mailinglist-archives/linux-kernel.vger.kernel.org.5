Return-Path: <linux-kernel+bounces-84910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1125486AD94
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B461C22DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3567C145354;
	Wed, 28 Feb 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mo/MS2s9"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCD27E788;
	Wed, 28 Feb 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119823; cv=fail; b=ioT88u+4Xx/2/mdBE8b5fKTdRUx1QWS79DEnX+FXoq5cQSHhyzMfjQQTKh2lUvlcK6tHMpO85OwlwxqaNHZKpG/YTlRQ/o20oiFseBdHIVNGgRFSutuxAS93YO08nQAZEeKU52WHDnFQwPyR+VeYA6H6PaM9qJXld6hVldfbepo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119823; c=relaxed/simple;
	bh=6UwsFZ8KUwP7eaQh2iNec2tNYZtxJdAW+Rf+qBwF9gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmlTrz16nNALKYCOJNblzA/sOz6WlxpvpQuwEqO9+qayJckpMBlJwZ9dKcEabOoLTG79kFE2DakNAx7rK5i/URFnZvLPKA8gUXqRVmN61NKJX55d1Rcp9eSYxuUKWPuBQu+VvaSAzbtfZr5cqY+vSUHHP0aHaO/zgsVdqzQug3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mo/MS2s9; arc=fail smtp.client-ip=40.107.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWFEumjmiIOe/qLguvkfkgSyAlqeJpoSVwWWtV/zPbXj5V9Jhje4B/Lx8/k2q8GS98X65h47TM2zT31Y5YGeXBcncrNI4Uq1U8D7o9NcVkXJ/3yMf8Tl8nerwLwG5JcgKecdjYo+liFsZ3A+9iYiQNI/BFlSoaC5QZqon6ZxeFdNkFpvon8a6+hlOYP39BsXw3LwDOoMOpsfX2YwM5iRyYiw9VHfWOxU9rrZRnNJlOlEFOa4Rg3vmg4BZPLUzqGcrHt63vfnjkQaA1W5EG1KQ2OU3OqbeBe+mABZomQjIR47JwJVaV0u8iFE5T0RRhrV01Zg51g3xhvfBxUy0XNgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzNpfvCydXD3YzV7OuaUoExT9tNFkJ9sNYHtQ0atk20=;
 b=fI5KfpFYjqGvibVG+7asHsnVrB5xh/QeVGdzGIhKHFKprXoDYBWbbhsNmFbxayhyTo/sW/FRxXG+GvO9SsyoyGDAiH9rILGJxy3I2/B5JUgVKbLWyj4i7/2w8f9uxK2cYVlqtt1/g20sSGkVoYHMEHQQpeluGeF+mZoWDBHu88z6IGGV4gQm255KQSpOAveqGQqypmWCk0wo5+v0jUBQczqpY6c1IqoxeFCVBky/HQSg8GnfEyoiG6voyXzbUSnltcbW97ZWQgdyyMymMRWFzJGbEj1+wqXQJmuN3o+6A8fav78hDPu+YuSBq3JhKLiBdR6GiaXX/QfUZSviJtWKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzNpfvCydXD3YzV7OuaUoExT9tNFkJ9sNYHtQ0atk20=;
 b=Mo/MS2s95qX8qKra0oNFsD1KxTUxlqNNxTfRsiAmLeKzE8KpYa13wifx9zlkPg8KU/07TEthEL5kQ0cS45w5CFg7p98kM6GmS2XZjp2ppX72EzSXiO1DsK3fGTg3mNfiLfXYl0tssw4d4ZA1hg60nFxSAra4iS7FtDa0sfFQ8ZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 11:30:15 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:30:09 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/11] arm64: dts: imx8ulp: add usb nodes
Date: Wed, 28 Feb 2024 19:29:55 +0800
Message-Id: <20240228113004.918205-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228113004.918205-1-xu.yang_2@nxp.com>
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: e004a189-4575-418c-1b74-08dc38509ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	btNDV21Z1BzCV/u39unAcpfwZovPUvnEgQ+8hMosre46VToutJ0sT43HeGbaXdZmdsS7Wo3hCwrHdrXkeUewfAGS10VLn89EnjbqLjxirW5KiReWOCdTEIE1vaG9WyxhtYw/4SS0ZTRsfWdbNXo3PhYgFVbpmN4Ejp+aXA9B5CkE4CDTUEll6YVr5yvK58qv+4WSMLpntTgtiKUdUW1B+Fcriq6coYpqxGp+T+diOvozAKvdolH/55UAKfJ1UUSXbbBHoJ/VUSWWdleB0ho+8sNGAsTzDHFbfQ4KOUIZFLEucuUaxOVciZx4Um2Hn7z4LdiPqDz9502ofsAY2Ede2XxtFWyj8KjGCoysirrDPau6Bb3qFnDdpbis9fgX344/db4Dtm6iKf9CyW/j64HbbAlZpnGG2zoNvdZh55+jqP1N/IvAsB2PTDDUDr4afM0xzupnORLic0FgMCmPeCVt4qMEhy49BBurYcwg5+nCY/VbrRLQK723/ACel0AhBGusl+z2FzxlLExPpDlbfBMwWM7/ICpxnwiR8TVj+9Mh1km4DJjDz1aphVjgB20EENgf+o4rV8Zr6aOE1PcDRaKUkt+/ekmzViAdUUbjvgQT/Ih8Kcti2APKQOlUEiPaFL7Y7SwUcVk7HfmCLhXPZKmGD0OYGcCR4i3zGQ8CfsjfCA4l5y2+xAHTEb4/O+w6vsdey5zuxs2KIm6X7JNrjnt+mw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BSxCsSNj65wcfh3MFzCsBGZEI5yWHtItagZhX+kBLSRzy8ZMZNvG+ToFkyCJ?=
 =?us-ascii?Q?VCZrlG7Jdg5EEOvKB8+4HlTXyubHVT1wvktuQnzkSs6tcJxxWJ8Yi4/2SuZ9?=
 =?us-ascii?Q?re0nO8IirYvuNQ9bYJJF0fjLpL97VN8kfOP9ctSNZM5nAV+GYGHcTV5p0Gor?=
 =?us-ascii?Q?qglXviKVxFkksGMwQLD9+1tgxy9rXAMKoDYgXQiFu/Q8EXo05GHKpomlSjlJ?=
 =?us-ascii?Q?DnuV1SmpET4h9onDAH+O8TeM4RGvEgQXRMUTlXgZyfdpKBx/9r2i5PLRXI14?=
 =?us-ascii?Q?WrIyYZA1Fnx0y4pK2GJWyoD7f3Al53t02yYrm92IXV+wB2xcoLYOKnQS+L4Q?=
 =?us-ascii?Q?r4MP0A3Dkb5VqUNDJjkdRCuyinIWyGXm0EjRtrQWDGorPlO4pz9iaZdzZ7fS?=
 =?us-ascii?Q?bU37FLcYprXP/hQq0cCj75b/lyjS9vcDjDV6/bUf20iN3R6CiaVfH6GNazay?=
 =?us-ascii?Q?RvXH40BEUtajfqzvhFeGH6hbvpr3zncXJtJR5K7HeTcW0wWGV5GgIWkJ3OVt?=
 =?us-ascii?Q?Lk0AZaWcqoKU4pgDLSpdGHebcmH2zl6OVO+F2dlLYX3+R8xHrqMzvJ+3Q1ab?=
 =?us-ascii?Q?xvUkzSIV6goWKfwUfcpykOyHGFFu/Off6T6eEaqmO2xQGPRg8rnhtTcpfpAf?=
 =?us-ascii?Q?Uxn0AXtvBtmXmgJdUNpF9509USxb+ZpPkNuUz4N5Vqg+dxliqbbxiB5bUmbJ?=
 =?us-ascii?Q?7vtckgISW4aZc1+VaOmsq7lqDG3YGLSfNTC8v+B6KB81CbQBc3XM5ewwu476?=
 =?us-ascii?Q?5nrb7iIaTCaKMJoulZd455IP8nckTKQZp8cTPjU1lCI4FTYASoZ4sVn2UzPP?=
 =?us-ascii?Q?3ayZXxl86rMarPTtTKsft4sD6Vv7eQHvyCSA96xm2a252Yvo03flDJUSsUKs?=
 =?us-ascii?Q?NlSIDJYXXalTILeTc7xUg7nmXhAmDOqHkDNCXI9FzMArNxxo0Qga/yBf60Jk?=
 =?us-ascii?Q?XGpveSSG0uWjA7qs4CxKORaT80tgq0yIrOBGTnYbjUiPcyFNqKIsb6Mn1MSj?=
 =?us-ascii?Q?k0BAJFgg+YYqECgnpHb880rE5vkPdYTKuzzUkwHpH9ntq7kQtMUpkqNlLi/5?=
 =?us-ascii?Q?eeEtGHg2KixAI3zz2Wz604GbyBgpwKh/IrRqpR1aee2VU6VQn3lnINFoyxpj?=
 =?us-ascii?Q?9t4F4ciXiYTdnSrEzkRdxLSD/wWByIM2cXdN1QuY5mKD8HWsAqteiEghc5PH?=
 =?us-ascii?Q?YQsKZUOBCDs2N1TIaBTPnv8/fiqhDvjJzZXPYgjCEz9aJhvxHZhgPzcdr/D4?=
 =?us-ascii?Q?fCvIAz+tD+hE0p5MJ50DuYQVC1JIakRkZX4+yx1czzCJ8rdxyOwr4FitKlGi?=
 =?us-ascii?Q?Wi+vJ009dqSzjA/kvJaYbkgZV2Y3kZ2XGIZ/OyXPnybwpVQgcxAx8rzjmv1Z?=
 =?us-ascii?Q?KTYHrc/TBhc/kAzPbFMLe5FyeLX3KDJSAYnSvU38DwiGlATMjMtu59OsFDOC?=
 =?us-ascii?Q?AbwYhEvW+5NIbjM+rjKZ8ECQZ2oaeH/3ia0n7H6kHhyaDEBbdhwqeZ8fpaLA?=
 =?us-ascii?Q?nazneYXYfN0F2XAbsm6/dJ5V+NUHGheqjAVrZWsK09vYE2tgIJOEQPsCtRG2?=
 =?us-ascii?Q?mBTAJK1EypLpb7vvHYW6lC7FGrm6pjdLuj/mhamP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e004a189-4575-418c-1b74-08dc38509ef4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:30:09.7618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z0A3gUmwiw7l8phVC1u+p0KhRYc8kZaWr3M3wRzFHUXQksLNhDOCJ3xztwn5F5aKl+TdB4Pxjz0wUpuARrahA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332

Add USB nodes on i.MX8ULP platform which has 2 USB controllers.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
Changes in v3:
 - no changes
Changes in v4:
 - no changes
Changes in v5:
 - no changes
Changes in v6:
 - drop usbphy aliases
Changes in v7:
 - no changes
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c4a0082f30d3..7da9461a5745 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -472,6 +472,68 @@ usdhc2: mmc@298f0000 {
 				status = "disabled";
 			};
 
+			usbotg1: usb@29900000 {
+				compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
+				reg = <0x29900000 0x200>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB0>;
+				power-domains = <&scmi_devpd IMX8ULP_PD_USB0>;
+				phys = <&usbphy1>;
+				fsl,usbmisc = <&usbmisc1 0>;
+				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x8>;
+				rx-burst-size-dword = <0x8>;
+				status = "disabled";
+			};
+
+			usbmisc1: usbmisc@29900200 {
+				compatible = "fsl,imx8ulp-usbmisc", "fsl,imx7d-usbmisc",
+						"fsl,imx6q-usbmisc";
+				#index-cells = <1>;
+				reg = <0x29900200 0x200>;
+				status = "disabled";
+			};
+
+			usbphy1: usb-phy@29910000 {
+				compatible = "fsl,imx8ulp-usbphy", "fsl,imx7ulp-usbphy";
+				reg = <0x29910000 0x10000>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB0_PHY>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
+			usbotg2: usb@29920000 {
+				compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
+				reg = <0x29920000 0x200>;
+				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB1>;
+				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
+				phys = <&usbphy2>;
+				fsl,usbmisc = <&usbmisc2 0>;
+				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x8>;
+				rx-burst-size-dword = <0x8>;
+				status = "disabled";
+			};
+
+			usbmisc2: usbmisc@29920200 {
+				compatible = "fsl,imx8ulp-usbmisc", "fsl,imx7d-usbmisc",
+						"fsl,imx6q-usbmisc";
+				#index-cells = <1>;
+				reg = <0x29920200 0x200>;
+				status = "disabled";
+			};
+
+			usbphy2: usb-phy@29930000 {
+				compatible = "fsl,imx8ulp-usbphy", "fsl,imx7ulp-usbphy";
+				reg = <0x29930000 0x10000>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB1_PHY>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
 			fec: ethernet@29950000 {
 				compatible = "fsl,imx8ulp-fec", "fsl,imx6ul-fec", "fsl,imx6q-fec";
 				reg = <0x29950000 0x10000>;
-- 
2.34.1


