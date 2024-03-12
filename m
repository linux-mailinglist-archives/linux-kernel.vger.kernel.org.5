Return-Path: <linux-kernel+bounces-100003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD9F87908C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CDD284A13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84B27A14E;
	Tue, 12 Mar 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZAWyRdZl"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4F79B8D;
	Tue, 12 Mar 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235051; cv=fail; b=T5cUjU6SpuF5oB9qjmYqiJ3lm/o0/JHGhK/h8mYgAQu/+ijqC8rUNz/magXrGLdqpt6bRnAGGiZvBHN5by4PVzhxBgsRxqClCPg2o4ivAAcgt3UF1xPluM1S4Zkpfvz6knfztld73dmOCRa6WBOequ/Ti3BfD0xkeSGHgAwtOJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235051; c=relaxed/simple;
	bh=HZZrM79C4hRDhkokuUdxwlIAaHQrGp4FawCbLHOOaZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MZs0z1TL1vqTvLJxyArhjvH+jRkdml+eqVjBLYvTre4PVTejzpYILsHOqwvdy7eFlWVm9L/Si4PooDAjR3XR2+ny4dujmI1t3IQ49cJvJGzIjb+Z4r2e227mpB7WpdtxIT8bv5VohoGOgw3EtqcafIeqJt1AgYsdxDvXBDKBuHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZAWyRdZl; arc=fail smtp.client-ip=40.107.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjIbbGxKkIdmBoTPy4RhatPvMlykEG3/1suHcNKvUwSWTlJWW8ETzFpQHU+IlK86DaxEKF3jz2japobjxEjEGBH8Iacqf/Jb/6BGrs5AijPQvdT9av0P789KlajIdFn+EWrPbPaWeJKLBrGIfctsbz99/36RIMMNYhvdT0E3Jy5j3mR5engIK/g+Rb4ZB1QNjj++kattvNEAJIlWndME7Tclhs/h5t8uHYNMsdboeUCBUrMw7lFIVeooiBNwLbDLLsJtJRwhpUsesfM8COoZ5mr607RHkrnGaxNjDZXMajYAOg2LfSJ+a7eyl4IBNSQUZnEwk4iU0Yva0ukIKm151g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MENkU0hKKOQbe8RZIHBfDoh6bGNsRQXatEDNojGp5E=;
 b=BPwaCkIJXEJgVQb20zcLAtLx6sch4QlNJGbh4+fFlKO9MZg0SycM2P73hAwk67tiByQ6rZFSUojfIe5TmzoqV4lwrv1sFBzdFjn2PXqJbPh7AcnoFqyy0ChO/bE+1+dpNX5jpdhoubQPQSZ9V+O7gXP6fWU2Onj2jcTPu8Emap1yk0fr0jMi6EU8CEroo1pTomkSwm893hmc8ryO+GcS0SZDmry5MZ5alaOXGvOh6jlur/YFt7FkmZT8y1bMtiPmIRNd+dklpZQqa/FDfM8PEQygM12aIks664CfGq170zTqAP+NJ/4cEPFkBg7vLaQIWvwZMlb78V3RiEVn9+FaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MENkU0hKKOQbe8RZIHBfDoh6bGNsRQXatEDNojGp5E=;
 b=ZAWyRdZlT78s5fWcnJMOm4+qI4rl+Vn/UJL86kmtY7IjQ5Yt21VS+lue1H0jQ9u1DKmmKttMqIPxMjFfiZnSIA4CP9YoTpwAAKjordoyTzLcZoxOzZE9J8rVbvAmVxKoN9qrKlRbxqZQWatBdKVU0m3hJ2ctioYbT+lljhvPV/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7876.eurprd04.prod.outlook.com (2603:10a6:20b:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 09:17:27 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:17:27 +0000
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
Subject: [PATCH v8 07/10] ARM: dts: imx6: remove fsl,anatop property from usb controller node
Date: Tue, 12 Mar 2024 17:17:00 +0800
Message-Id: <20240312091703.1220649-7-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e3932b3-7a4b-43cb-4e93-08dc42753c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XYmmuaceoufLnDKvuueIfaZq4i+x+pL/eS3HM5ZvZ9kLZvvhUxm0Up8uGGqllC7YAI7FWv+bq9Bq0iGYRMuaNT9/xeGlXfLfCxBz01+UxMLIXsu7nPAUv3jejLmTJD0hGWCWjNQItA0vTFkbaoU23x9zQrAiab4uNwXmMWFukeGf40O6lDsve54fk5ep8xHpmeruA+hIQLE1gYBbElU/FMBROGHvXdkkLQ53HCroSJpIDJJ5pbdXQOPgKrZuyyevgVer7HhyirA7Solns7SnJYPIxrFWiTpx7X2nTP4Rp8kI3FGVn3nIjKYXbE0M8i9ahmygMuT8VgKYME/J1U+S5xhYJnCy+RsqiefSY/LF9aDVs2DklGcxO31ztB7w7NomoAtP7AuMMAHovhA3dmYFHgTlrAwb2gV45eOhiHMmBeh6qsP0J3jboqr75Wk560jPItHoarSdiZQApBkSNzn6S0FX1dleYdDIrN0/15Upljw5Y97vRHsmUK63w1SmolT3GmIcoK6Uvbd1FddWx5oCCXCw92HpQ57uABXx+zzlJvxzBpPRqSsWx6qkgqPnHQWDcMy0azOEs1E7filCbIr0BEu1D2mVX4X5Xvo0UIHGidAKPBNPxi1RF+spZBiRyn74E6QrQaajghoN1HVquH1HPuUeimqNCWEL5gYmkZQK46g/vlWrF4TTlekPN0GSdjN2hBKaUrfswuTOzPYPcAsWrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?okXpyFX9Mw8Sa6H1TZ9xwnXOWu4xJPcAjqgVNPjUO7y/X1hrGjJskOy+ykno?=
 =?us-ascii?Q?m1aKav9Fl/dAEfMgMOBIMQykQWP4CA8Z2R0warZy0pA69bOpOA0pfllojIUs?=
 =?us-ascii?Q?OVs5mumghTeTcW/hCu/7wH1XqlgUYilZ5DTf2z3oG44Gj/Rsy41va5lNvD9H?=
 =?us-ascii?Q?gMoysgkPG4UjRNNKhlsronozNKoGfDACLRtikMp7rDJKDXvnlHJjdE5As/Ny?=
 =?us-ascii?Q?a2gmTKMsfPiZrTUbcHwOq+a1IRpcxS+7u1mDbWisFpkKaCZlDVO/z4EqXgbG?=
 =?us-ascii?Q?GHK9iWwr4mmaEp+bfFaBo60R26je5G+f4xi8B8+4bFCvEZlCmEh+VYSJC5V/?=
 =?us-ascii?Q?BX9gAc8aNmwrQJ0oyo+E6C0CjxrFmMvzXNOjLKR4m9SM6oPMS0PDgohMiCD/?=
 =?us-ascii?Q?jBEVgcpKnhlWtj0U1aN9jmAYWD2ENozNGgwBwo3Hu73GJXoL3jTrEzkD4s3c?=
 =?us-ascii?Q?ZM8Va55r4Qu/HL51Q6Y7TCn4aTMqsCjm7B3AWEyirxEA6q0y9NHQ3Gsv4D07?=
 =?us-ascii?Q?qmxu8xLuFiT9r7Wifkoizq0+1Fk4XFERa5uRPJ3e5DcCBtqwAOZp7RXyTXS7?=
 =?us-ascii?Q?CNmXYxiUaQ4x49zRec/xkzW00ARfsCaTV3UfWYKujCr/+Grn8M+NUMfDzGCb?=
 =?us-ascii?Q?NDUpWzEFza0HA8V/Jg9AT+YEdZyiYVODzcrLs/tD+G2ItYw+HzC+Ove3C1mF?=
 =?us-ascii?Q?kulua8BCamYTD53LiYhxaahzSaPJwWGollwAhKJ2LUaj8j+6TGtbGlPtS8Ar?=
 =?us-ascii?Q?2DDuyhemfBtCehyVtD037TnjjDgeqek2uzVBlp1UGOCOfbv9un9idhCLE00h?=
 =?us-ascii?Q?6bMXinq3p3+ONZLW2rtwkVP5qsVSFLOFez3CkczXUs/sqY2SIySPJ/tQGLCC?=
 =?us-ascii?Q?Kf2/4/KtiTooqywbyVC9R5Wis6/YY7vX7cq9a8KU3JfNBeYoKmxJS75fwvzm?=
 =?us-ascii?Q?eg58EuTkS8h8+4NEDFScDIbq71eGmts/rGiN2LgiORp0218J0crm8WK0XsJE?=
 =?us-ascii?Q?aqwTFqp2lvS7eJ9gj1bFu0WUhMlveaTSEsA8dSAE0oxEPt2i9cCqDcZnyrCL?=
 =?us-ascii?Q?0QHFwD+c79+nDiRkBs2w7ykvPLb3427txEd5Vi2XrWMn4+buZVQcMMjFzUHM?=
 =?us-ascii?Q?73vvT7l+ttG4icCdMiYdJ6mrN8TulbUK3lC/FydykC7jqzh5VjfDjz02boox?=
 =?us-ascii?Q?QqYuVeEPCnQjkZHxl3OzHD+vgPMAKAH/OxvWj8PIFILiFEVIcLausysOiinU?=
 =?us-ascii?Q?ZuFVEtRpd1w0OC6tJ7eOnaM+SHZ2WgTt7AR6DNxTKl/dXpENpjoYUKJ25r7i?=
 =?us-ascii?Q?cqv83/6IDmG2Kf6q9QEk4gcoCs9789ZHTHMHk2Mh/1HjgZmfdyz1z4yFaxmK?=
 =?us-ascii?Q?lcsyxH10IKlmSH+8US41M3U8VIZG0yCpin3I/A6wEvH7BY0n/NAlbhK+1EGE?=
 =?us-ascii?Q?4WGeY1gk6i+kGfFRIAqhb2aMJYk61HHXzAORFng7dph1BJjnTkUfYnkaCRWC?=
 =?us-ascii?Q?w1CuegD5sddMPYvE7xJQTOBW/x03+nA2NTZElQaEUMFNc4tkz3BVUt5rwQJ/?=
 =?us-ascii?Q?SipB9GywrmlHmtRrpP2cuhHAExRrw4HmqQ/5XOpA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3932b3-7a4b-43cb-4e93-08dc42753c26
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:17:26.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cy6U21T0KozfGUTpBLjrIzPE6LmWo36wsClT0mBxwVqY5gLPT2jkq2lo0ZMJlvhlgW6rJ3A6rl+sDykGtuFXsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7876

This property is not needed for usb controller. The usb phy needs it
instead.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v7:
 - new patch
Changes in v8:
 - no changes
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


