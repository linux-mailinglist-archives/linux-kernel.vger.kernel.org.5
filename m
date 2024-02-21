Return-Path: <linux-kernel+bounces-74168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E412685D0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AB51C23FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778503AC01;
	Wed, 21 Feb 2024 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W8JlJZGw"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F73A8E1;
	Wed, 21 Feb 2024 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498309; cv=fail; b=tlSy/lA7WrhyI+hSwiCxGx1M596oviu+pp9e8CBqLCJhtxXH4pL1J1+jHrzAx0MPNzC9KXq1dht3dh5o6fjQ3ZS9FWPapOGWqHHZbnfs5Zpgql8jh7sLARhghRdT0utPdiLsdr94IsX6MkkiJUZnar2lb97Jv0vEU9oQuFUNFTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498309; c=relaxed/simple;
	bh=nq1ihAcP1x1dSdpb/cAV8aLY/EzNGN9j7TrqPenQ2/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=glYF1bfXtMweNb1iwdrxh7FFscZY6jxbrxkIyCBjHO191TXu2wTQz9paYMUY1zBJ8CqZIeEMNylvIPzphO40doLSWsMOOiAATraAA7F8js9rPU4cd9fzfiOObbR4mKQ2nfZm9XaFivyqVrtMUaYzjuKvZEvKwEPb+J8Ars8ShW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W8JlJZGw; arc=fail smtp.client-ip=40.107.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJdti1zECQUKRUg597zR6QcdIx0UCOjWhAUiBeKzrFFKNEzGXid+TahITe12vVlbnPj16qj+4UsVRqJUy21FA1EajBPSZJe4nq1H+4e9/SI/nDjCIxwva/N2Q36hTB5PYP2d9KGIEm5AVmTcx6pftlh+SVeaEao6Kem1KOj6SI/MLIT9eRTVzKXPCsb8sDd3yKEywz1hbTL13P4PXHULsqASyIPVnvOZoXvqMGmAFZvs/o21OI+zn+CGNo3wxo0s57VKPdDA2jmdb6gy1pJ6nbafThCn/MUGY97sdQlYXOv+uxORU3/WIfSeAuSdeNDBV95A5VjHTvYybFATAVoM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4zReIWs7rc4IupR5I6CHPP+Uxix/ZgoGRzkBt7yCRc=;
 b=ib6tdNF3ePLfhHNM5Rgclml+YqBCXs+yoQR8+E/iqpyeDe0cKGAAKl5JbOMcjuEMP2GGI9cnWHkYxAflN545JiN2oSWq15FEk1bFaxbyqgtE4u7Edutz5xlp3rI0IMsUBmuEvZpwW86xXX3nY9L/YKEhfR/mvA183sA5fCbHVjCVOIuALY55HcRguIGVzQJEBuXaaxKsc902Ixd3fcnRFbCNhyaZfyGQ07cviSjQiLljp63aopER9W+dFsiU3eEvPW9SQumi9Dk+gRKEmDqGIziNdofhRFTbf1mcchO4gZqWfbnylT1SMpmSO2VZcD7pX5YghnrSJerBUIaOD6xqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4zReIWs7rc4IupR5I6CHPP+Uxix/ZgoGRzkBt7yCRc=;
 b=W8JlJZGwTz9aLCWGO/xp/rPri1JnXsYWd3m6md5L3yyhMUkhWHhCNrOzgTobJ8/ugOEs1kqN0yR0tt0g6Z+AJ5n1EP/qZQzOlYc73teGG1offk2ZU754gjBk27XwC75QgKT98wMI1wpnALelokBBPYv1HMeVUZ74MUAYojikOlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 06:51:45 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 06:51:45 +0000
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
Subject: [PATCH v6 3/9] arm64: dts: imx8ulp-evk: enable usb nodes and add ptn5150 nodes
Date: Wed, 21 Feb 2024 22:58:40 +0800
Message-Id: <20240221145846.1611627-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221145846.1611627-1-xu.yang_2@nxp.com>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 26be403d-2bbf-4203-2afc-08dc32a99140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tziXB8j4jlZCDdeO0z2fsF3jkN6itbB4ENSQn9wSZoNyUwCR+71PD0ktQg4GKePY1yMZ/6nHTtjAk8NOMFZtQZpwvhLHjvMNIbzsB/K5VUKhFDo76mN0gbOz9ZN4BcSU3JhtWlGMJEg9RxQuxj9UGkggoZrIUUxK1svm2aL7K2w1Sx+kkHqOg2C2wvyMID4Ydrmk0g5yben2Cj1VfuEcaCFTQEiW4ba+y6soLe2px5SuQEelvKUsP7luh4Ey4d3nBE5QpImwxyC7EDCGH2Gf5sjvGc1PJnpKC+edRQ2JVozd0+XaeKlTgjEm7mbqhmEsk6Su0o1MCZGjBo+Wo9VHE4XDeasHTdq2HKH6scyd30rLDqfJUPD46S246VdZZFLg8oMvnhIgx6xEiCH3RZMokTiGke1vIXJGk7K6FCWOHntZMq0ObZ3y93L+BKHfCBDA6kc4t/a/5HWdDo8SNTCk2ODkUuYGnlv/QOtgyqUn6sVhIYMBK8FKHMNiTJresLidlrJlSycKHpmaGkxu5gkZ3gO1762VJ+3Z5Na8HvRT7MptlpZFi+pVxP2sA+PaRE7zSoC/WEcCXIrsK8OCqfZjeg/qsUTDhfFsB3OtBSUMakZq6CQCNGqO5LBVnZ2LSO9B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VIWJmRPkYcrCX8YDhD6jRxGgXpssvtVIhtmXmztK3KlAxwvSYs6QlxTXCMIU?=
 =?us-ascii?Q?aD1+RaZSOw/ENhiAXhDBYMpOVF51M8kKqLtd/Vqp3/fPnX4Ei8XHmiOu8/CX?=
 =?us-ascii?Q?yw1VIWn/AR0qlCQ2+mRPYEPYJ2v80XmHpgEbh3ifOnVQ9b7b2IM+1sxPKEKR?=
 =?us-ascii?Q?61LbC/QS1M/5cEGdrlRyh+vcbR7ZWnmfMMPMu3vQlexE14NQUpaLF7ZcFTIF?=
 =?us-ascii?Q?kyFBBPDxthrwbvCXBXo1MzC3zArG52JHoRy+zfD3uACS2nSWQGi/zb9J1c6o?=
 =?us-ascii?Q?snobaVzMtIZTQdhmglSiEmXouSy9r1eUOLI5P0t1jCGrNZ/KsVv6B81ifVYu?=
 =?us-ascii?Q?8/6JlhlgUI0zRXS5G9riYGPojaiyPS9WjYgDUtrAAjeQ7qtvWUydStrMpnPg?=
 =?us-ascii?Q?aumx9fJXZxtCKJ9rBdoy/3ey23zws8SeftHdo1RFsVqLP27RB/hmZ1DWXg/u?=
 =?us-ascii?Q?ynzkEacUFI3W/jD6UpCHDbfAw/0AtUm2T/Q+ZWNCyHWekDwVpPw/VySfYYwj?=
 =?us-ascii?Q?C1Cmd6uoskV8S1I/lO44fnsDoMUwbYPnLro1BVCAH7bLCwuwCI9QuDWcQo55?=
 =?us-ascii?Q?fzZYbyaIx6QJ7alzo8MSHU+x0EEdFLkLpJ8DC/QtdOnmpp+WWIrnCUW3vnho?=
 =?us-ascii?Q?Ad83kDz4/jpAOS6FsNfFKHLRmGpokbP8/TR9IB1nEAQUjt4UVJu7NA599Lxh?=
 =?us-ascii?Q?Gtu8xqlh4X00q9JZTDEdBA3n9tlerPDScCJTfSdJpQy8etSeBXlHk26XQh+U?=
 =?us-ascii?Q?oGmfWxENivhqattvSzIw+KnczvYEyl/hXu9DSLsG2me/YoRYJ+vA30nRWdPf?=
 =?us-ascii?Q?1t4/2HqQqTJgcGzfgUPYThVRqFNVjJhAekWuOez5TiTJw8Bx5mx4zBRfqGOc?=
 =?us-ascii?Q?jRznfr9qzVj/aBx5VizoqToPLacbQv6X+95FcDzn83UtFM+vv9P9JSf4TxMz?=
 =?us-ascii?Q?E4sFaqhSi15frcQyDhJoVS6Y8K1TOyOR5YfJW2fYkPyDvfmUiVvgLH52foRy?=
 =?us-ascii?Q?ixqou9+wm5tHBom5G/wEbXzs+wj9lEeXmOmiq/KBrxtK/tcduPxHcOffpML8?=
 =?us-ascii?Q?uPyLPoj9pkwdtjaz98qt+b612Z9lspOpZoMB8hvSTwkOtOYOBYt57VdSYmhJ?=
 =?us-ascii?Q?LneMXcKdnNNTmdYUq+me1xyijIcNL2ja7RI2BlLnqkfA5Hxu8qgz8konuciT?=
 =?us-ascii?Q?rPiQEfnBQUsAwhzabOYYTprsUTWf1EHYJKxNoyC0+HTCZ2kgCzAN89+I3PN9?=
 =?us-ascii?Q?FK1N6tNR/VmfKnoiX7Jo1+OBI+M67Yk30gjsrDYPG5Wg1Gceaec8qSlUaWg2?=
 =?us-ascii?Q?ngyb6NQnVyrPwSo18ZOfmpXpCGyM3wdHRmoJ/ULBs8kh2XDLZbxlviNNWEDT?=
 =?us-ascii?Q?35M6iAB1JhPalUO/6x87omENetXBC2HrqjdY5udJWglCWoBZTAHDkmUyrfxc?=
 =?us-ascii?Q?fBhP0ALxbeLYjJjKFMJ38l3gFPpHI4LUbn5aQJtm7xx1qOeKuThcbO+hNvDJ?=
 =?us-ascii?Q?lTWQRqySmP69/zvXzOc0vIvhPq5+vuGGPuB5ccnGh39ALPUgnWAS4R8WAD/L?=
 =?us-ascii?Q?7TUoKt1KOOUeNgmTdT/FbPW4AZollU2gVpnzMGzO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26be403d-2bbf-4203-2afc-08dc32a99140
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:51:45.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9MT5I/B+07OpdBMP6tnMJCOq4RsAv4YrRGtY6a/SJro4ggtBkXztQRGVm1XAaP7DX9rpwTTSaVspBhzgCSnzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

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


