Return-Path: <linux-kernel+bounces-84917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298EE86ADAE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7AD1C23B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FFC14AD2E;
	Wed, 28 Feb 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NiF2FHWP"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEF36CDD0;
	Wed, 28 Feb 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119844; cv=fail; b=q7GCuuBN5rk33r656OWIdcvUwy1q/7J6l90tEOUADlr7UQTgWAiK8Mm1KyHcYjtKaBb0iUXfIQ2IuCzyOSt+pavf78I0RXMwxgv4wuLFQ9qC46HRIFQhaLjrHk177DLvwCU/4CY22DZFFG4hxMfW/AfSGPgkfHRYwLPM59ZpSfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119844; c=relaxed/simple;
	bh=Y49ZKzsQ64w4B1BWszHgROP5ol5JiO+9qLV91glpFK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qMBv/WBJkp65/F66KiE9dC5ejlJeVijj2QgslUC//qrP4dYiyia4EoJL4zPADeEPGpWNHuOsCTOiX5ru0npF55l0ef2AO0O8lm8TR767WZNQVF9OO/NNtJ+Pr4OLqvEI4MQlth+zbMDq8UF7VXwBSv+w7ieKnRx7xP+1Q0CgrEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NiF2FHWP; arc=fail smtp.client-ip=40.107.14.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWbqltC541b8FHjhDVAitQ5obkPXqLFiYKzO3wTmcWxSQ2qw2+1cz4iKx1+9ke+gdZI4lafQQLn6HLR5kcQldz28HuA1AGtRH2KsaqZJ0Lq4yYwRrC//1JwC0BeIEti/0d4ROkHgKzeclZsWGx9WsvUfQkaj3jqnGsUJ+CKKlIqc/ctTjilrZ8xBv/DVY5Fut2d7YA6htOoHqpCSybCkghew0lQAnL1Q3xEKmmMDP2yhymox+MRu+Qhb5A/k3CYVlpaFsvQvqo8yyST8UMH6N/HLDNm0cPZZQbcT8CJODNhccXjuzrEpcRcYI7wVGRCY/9eY+6pXGrb6ck3pIZ8ZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjgXSvQCevAlt71uaWkdkXASk5frRs1gZXMTki+ddnU=;
 b=ddihGyeejU8w9VG11h7t1z7FY5Q5e7RYBydCbD3++uGZUIY+FzEDUgFQVG9xKikHZtFJyfOzJ1wLxcDqQ4+X4BR9Fm009O3wTjyf5LUvmYb8Ul8046AwBE5kRrghQjZdHtnZR6APwDZ5WS9mcU0LPPv0xneRrQ4blN16TUv3Xa4WNVv4DHc4SEYBdqK9GGw75h/4i4n3w5h04F3nZI6qqF5jpIA4Us7nQzNIajhZytzxHc/jmQIkWLvGnAlJQGgScNHjU76cOGk6PkXyF5eZEHXT1FpA0xON6qeiiLAT8TQCi9UwqQtxbXn/bT/RUJbR+AUM9KCG4aJP3KBcPyKWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjgXSvQCevAlt71uaWkdkXASk5frRs1gZXMTki+ddnU=;
 b=NiF2FHWPWkBrCNEGlZAtCU8ZRV+RSEYhjdva0VZkBbBLFtfriSQVZu1iMwKBG/I/Bx6qk65aM5sLMOLWAK/G7+lf62JgGYCMvqyR+QNhsl3r6yJO+8pValUA6vxq3VOUrp9ZHprViig8KI2Zn2JrSlzvRuI25hDJVHqdzQA+TdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 11:30:39 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:30:39 +0000
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
Subject: [PATCH v7 08/11] ARM: dts: imx6: remove fsl,anatop property from usb controller node
Date: Wed, 28 Feb 2024 19:30:01 +0800
Message-Id: <20240228113004.918205-8-xu.yang_2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d861e1-880a-45ec-547c-08dc3850b08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fAGjaRnrkhoPqdjub75Z7ZBixE4SlL4hQdRtptVDKSiEKTHnhEdDIMHL+J1/inEbIyq2Dp80kkB6lv38u9vD+6Su2WEWbcoly5hzyle42WsPxW/55oqDMJnMzgq8La9Mdwwb3ItnxxbJAiio0FFbG3kK93Hx//5/zBxP3U4VG8SFPMLEieLWBVChqExt0rABIG7ySVLxmNYSA93c7UL8uc50eNMKXR9Mpo8A40rQWKuWpSHRBFCHVCYETBV9FCY+E3sjNQWwiRc6XqZhGoJWBCMdHaXWCtrQtPu0XnoIzHro6M3W66MXBpM8+bdzyzZ+IIAihEU/BgCN8A+pcmMaLBusBQTd/F8NA+zkQQSLGU0fWEqH49dGmM6gT3lu5vbGRv4a3h2MGBLRet+9M99JwkceVh0Kyo65420BrUOnNFz3EyxoJgelmWOTJ11C0vk5xEiNfU7y1QIT08IIHg70oAAY9QOMzbofabFoOvHkKKAL2CCsEeEZ3CwmOmXb2UjY16i31Q2xkv5LevJ45tJlzUZQg0dL6sHXRwljucGCuOVi0fvkUIMv84WlqLmagKz9zdSWnfYJVlSucxzXxKQEDNroAssU0ruvjM7XzSqx++HbNngYivyLBBmPkD11IEHDJao1G1m9fyW3FgmJDEABd17IBEClFbJBORQA5qGeDYADfYqOhCTZVE3KZUKMAmkx+af9j6hKy4mciuYzWmqw5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aYtA4RfI2uF1pTXqeDWIapxHJiNbmw1dZfm+5lSiihzVFyX/DE+ufl7TlE6T?=
 =?us-ascii?Q?eUU3gW3FXSsQKOe2ZH6dZ36p1YqrFdLbMdT00wOYiXP2seX/YifhOov7Pv9C?=
 =?us-ascii?Q?3CK49aBZ/iXvUuBXcxSItIk4FedaWGZf3w/QYfcf7EcoW8cpxAi4o9l1PmRX?=
 =?us-ascii?Q?UoXqtRXER6uuPfaXX9r/JAF3/eqbZXOj9Z9A5wCr3I6FXL3Kh9B1UoJpH9P+?=
 =?us-ascii?Q?ng3I4fP04JT018g0ncJaDOkeCsb/JwPtMUYXJXGicnVcntGCX8OD5KN3iZI/?=
 =?us-ascii?Q?xeslx2Zt9KqaVsGc1gWvAJs5Ojmg9gxMR3a58rqpYemf3/OuXG1dtcvTv6vj?=
 =?us-ascii?Q?mYT2DRGNy7SI2mpsVdTJn7r3M15u9nXtw7UiO5B4zJ4Q7syeQ3KQrBbne0oq?=
 =?us-ascii?Q?J4vd6/scMcW1pNwAp9nVT2i7BUsXqO7Q06oaqh6L1q2wzpRq4K6jDSfx89pU?=
 =?us-ascii?Q?6/E5IdjC1PiyJFAv2tP+pseuAQT+lIxwElmu5XKkblcQytz8vTxJtmNx3x/s?=
 =?us-ascii?Q?ixEcTULpNVV7aepfXh78A4fNjx9tnwvsK/6+rxmtfD9TNI4J2HQRdh3nFssH?=
 =?us-ascii?Q?2FhARzS45BM/y4sXbBkz1+cxczebzfJFT2IGPviPTG354/7sbYs0jHqPuZXE?=
 =?us-ascii?Q?F9LMKwyM+fs1V3A0kYnloB2Ft80gWIkbHVOx4wgXn3Jfk0KZCONugGekvygP?=
 =?us-ascii?Q?5HTc/0XNzhST2LccXe2gmjJ4aTCGDZTgaxpyazpJoCyUOxSORfdPuJaR0jVj?=
 =?us-ascii?Q?LEHS/eibLz6Q4pnALD43qBh3lmYG3+AwIrUuXf/ddLRQTgbJwZfmOi40eoRF?=
 =?us-ascii?Q?sVKrI5KD1sSC1ir9qVl8jspgay2RIIHnBX5T9jlMNvndDr/ISwjanyHhOU21?=
 =?us-ascii?Q?eMmpXn4HCNVRQpEAe9uHxGpLMa/jM7LUvliMjXrFX8DnZKKjKKKkoa4H5Yw3?=
 =?us-ascii?Q?FjPCc28ukg5x1ASeDGcUcnj7FydafIsbBYkzKWVdjoeS/JCHyXH9jPXkjyTI?=
 =?us-ascii?Q?Tm3e3Oasp4sDBPQShtDPkIOB1f0LQvWxTB0203TzUQEhM/XOv6EhmTviWCRA?=
 =?us-ascii?Q?qv/ZZYkwZiqX3RuCHwrFhxqgNb/S2a3qHiKn0LU9+hO870O63l/AxE9gIvWC?=
 =?us-ascii?Q?uESPpC58mNQRGSIv389RxUgL1FI8Pn1e9evQ9C0teszr5h0nupGhikhOBuYJ?=
 =?us-ascii?Q?zsnu6JGwVRUP97rQ74HtQ7GHigD3oGPlEyKvNueBPJgayrwagNwwpUJQZ76m?=
 =?us-ascii?Q?0zcOKNjUJw04XlVq/cZkTaaJ89DPANG3Vk0z8Y1BXM0pAY34zPn0pLrhRgqP?=
 =?us-ascii?Q?iKVH/gbZ7qAKUxdFfN1+2UmwzkbyjKlRBMxBzeuwH8Ty5hiwwnZG+e8K9GcU?=
 =?us-ascii?Q?tYKRHUNzmsYoANyD86mH4b/D26kVjNKd+bJgZIYnre/XPiq2ng2IDrcUI0Pd?=
 =?us-ascii?Q?y4TEQ863e29xVnTLQR39iDvtUWjL76TsCnfW8DcE4/p1K8uXqpa3BZaxDpXZ?=
 =?us-ascii?Q?rgh+qQHdiZUHVvgWekgvhuz8Vf17AuuIetrnJZ0gCKHuCSR7lLYjqLRi8/8J?=
 =?us-ascii?Q?jMTmCrEv1Ja2KR9wohEjsTNL1QTEvSl9wjFBMZWA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d861e1-880a-45ec-547c-08dc3850b08a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:30:39.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZJLClN/o14i3bJkUVmq9n2uXp2hEgZOdeOyyjyjRz7RIM4u5yrFSf5uS71jXcJydVlJYLcfgNwZXXiE9bFa/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

This property is not needed for usb controller. The usb phy needs it
instead.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v7:
 - new patch
---
 arch/arm/boot/dts/nxp/imx/imx6sll.dtsi | 1 -
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi  | 2 --
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi  | 1 -
 3 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi
index 3659fd5ecfa6..ddeb5b37fb78 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sll.dtsi
@@ -683,7 +683,6 @@ usbotg1: usb@2184000 {
 				clocks = <&clks IMX6SLL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,anatop = <&anatop>;
 				ahb-burst-config = <0x0>;
 				tx-burst-size-dword = <0x10>;
 				rx-burst-size-dword = <0x10>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index df3a375f0a3e..b8d95957ca09 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -929,7 +929,6 @@ usbotg1: usb@2184000 {
 				clocks = <&clks IMX6SX_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,anatop = <&anatop>;
 				ahb-burst-config = <0x0>;
 				tx-burst-size-dword = <0x10>;
 				rx-burst-size-dword = <0x10>;
@@ -957,7 +956,6 @@ usbh: usb@2184400 {
 				fsl,usbphy = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc 2>;
 				phy_type = "hsic";
-				fsl,anatop = <&anatop>;
 				dr_mode = "host";
 				ahb-burst-config = <0x0>;
 				tx-burst-size-dword = <0x10>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index a27a7554c2e7..9eb4eee0c272 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -855,7 +855,6 @@ usbotg1: usb@2184000 {
 				clocks = <&clks IMX6UL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,anatop = <&anatop>;
 				ahb-burst-config = <0x0>;
 				tx-burst-size-dword = <0x10>;
 				rx-burst-size-dword = <0x10>;
-- 
2.34.1


