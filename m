Return-Path: <linux-kernel+bounces-43555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4020B84156F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACB5288F77
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4324815A489;
	Mon, 29 Jan 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SCouR4lB"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58709159580;
	Mon, 29 Jan 2024 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566518; cv=fail; b=d+T7zm2xi7lgULciA+Djtlh7jV5dIlqRyAAHaLKZQXtO0EpQUCYXSQZABwocvQ54hYPuLnYKhsBUEtXlD6WhYH+bDk2PZHUXcV6B5C/7tiFaN1XSCRIhDq9rAtONOI/k939oKNxFQEFWyDz+Z9YvC2RLa3lrkQOzBqXdQenQmkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566518; c=relaxed/simple;
	bh=B0mUuDPcHx3QSG5naayUKs/WE/yr0Iq/2O0UC8PUMmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbhAE5g+Lep96oL7MvzdwH4AsEc1reSz6CtK/rWyYFREo5eoegihHAi2ocsQbZ4srM64K23ls9bD2ZoEfygPDkJnHJ9iHmKON/XePnvYB9CE5ikGWxIvvYnEBVhbmOAMKmGFIwjRAmpJmHnSwsTRAqXmLTZb33MmcSClvvwNgzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SCouR4lB; arc=fail smtp.client-ip=40.107.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7/5dMkO2b18Rup6leSfqPNHGkVE/FnXG6h6ORhq8kp6PXtAMwp1ETAv5Wc32MTAYVLvrCJNrW8jetYfX0CdgXwtaUATxOtV5hy/8Fc9FGn1EIU5RGOX/6yugtInI/CEE/S42fiSkf4bs1B0dQ4bbpY2xWkNgT4Pelo5WJpkMBuw8sy8rMbNw6FJWEdEPcMIP6kL49YLofWlAXzn+VrYhneAGWpU1UD50IPRN9YeuwBkqtkCh7aOqL+/ExSQIdNyKO0KRAb89Ml5i1jSWDuH1YJuGLiRXjhFND1TnUJN2ZbTwnTe0986n90/qdcKfZ36kBHr7CvG2XlB5/FE6EomUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0W3+0GXeOA2ct0akqoU7iq86MoybwV8eLs6pGROlnA=;
 b=H6MjgPBSO/yyK/KIXi9tURpZeIf/KNzf8ZSCKjTgxu5F1X9IWGsNpmnNB45lvAoVzbYUd/OZKjpX/kYGHRab+nY5w3V1jdoExFwW4MOUCxs/F16b/EU471GLEHNyes8PhvdHSf33juPnoBPKgWhMJfe1/ZJDH7JjN9/H6qoILiaaPFwSQE0H7R5hPw4DyhqvGQU8khqf/T0V40Cyb43upnuLK6Jlk7A6DemgnX+lD0ZH900Ue4V6FWmNypOs+AzIfP6C2y/ejxt0n2/JFzDWBs/Qszk/p7mxJpfC86nNKG/DN05/xmTus16qOBHc1buVHPVpO03NuDct8iJR7NFLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0W3+0GXeOA2ct0akqoU7iq86MoybwV8eLs6pGROlnA=;
 b=SCouR4lBNAH4BZzflmd5UUaPy7d18Vnh+XdObTPAIgte/YNgVasQkrjplw4+1BeSNkAhXIJtU9lGAxQtVwPANrmcTVTfsmS5JpZsWDKv55kXP76q32ydvNgkntT6KiJxNTAZgHoZm7PB7+7s+yi0FWmVJM4clc/617ml8J5Rxjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7205.eurprd04.prod.outlook.com (2603:10a6:10:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 22:15:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 22:15:14 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 2/3] arm64: dts: imx8dxl-evk: add i2c3 and its children nodes
Date: Mon, 29 Jan 2024 17:14:57 -0500
Message-Id: <20240129221458.250492-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129221458.250492-1-Frank.Li@nxp.com>
References: <20240129221458.250492-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f78c989-6df8-470c-cd3d-08dc2117c43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pM+3Q2LcVNEpFy7YlR8GwG251h6tNdCAleIzbjQW2iMAjg5Pj83TRs9tXzi69Kbq0FmaklXMkMF2iaMWEOgvt0+l9ScH6BxcAU4R9lunVzfbo+zxMzr5lq+f1GNzKXfJg3U0D6dHCWTuTsRFgi/OvWIPLx7JTdUog4cJz2CmKZGp38nmn2JFbxa3zQdJx+rcXzDbw3U5nfyo+M90x1FCSPIfnT4foUvExhvuUTw9NhGp4UZ1PfPT4FtHByUi59/LEHsp89+w5Ijo35EuLjngiN0NSvSBVDhtPtuGusgd/MRbpOT4hz1TToOz9yrJFjWwW3zUm6xQrmqtlCfmJH6graNrgPtSiapEZSrYyw2bzv0+K5EDXwyevvcQOo4hbb7mHMBMk5uChcPEWPG0vWUU3HYgAECl7Ga1lbvZm3pl8eryc3APOZI3ScmnogCwxcDGmBRt6R8V9YR6fnd/vu/v81/ffoz+4UmH7XZz9lsJ21pSzziGAte+WxwuYHbLlU/6gmGtoMopgyB1kO60bb7QRy4tSqfjiKumMbOsxis3Suleuz1UtW5sBsagniTrClGtoiCOv9pB2rmEGfxyRIFl/9Q9pOfyZgtsdDtGiUaAG9ai6WwimCLIwEAIeiSlesFcZZhIoYFRCRz2Py/SYVq7UWEcAjbLIgJnSDeccPWaeB8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(26005)(83380400001)(6506007)(6666004)(6512007)(52116002)(36756003)(86362001)(38350700005)(7416002)(8676002)(41300700001)(4326008)(8936002)(5660300002)(66946007)(38100700002)(6486002)(66476007)(2906002)(110136005)(921011)(66556008)(2616005)(478600001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JqmchQxScmXIuyJRY7r66ZPxvqzo3dg9pnT5ZvZCl1rqp8uWYKIKgLdc44qS?=
 =?us-ascii?Q?p1vz64f3+sE46Bd9F1jZfnR9KN+uToqqov4Qjj+YOvplECnBj0CTbsmJ6UaA?=
 =?us-ascii?Q?wLS27YvZMeoNrjPz1rdt6WUYUCCBzS49pUsgzkCgqC4LHC0Bnn66sYEFhnjN?=
 =?us-ascii?Q?V1l7Oj2kT99qYa6TtNL9H4wxRYki5H5xD/spmp1pVW2f8yAcM9vbFO2dGRWn?=
 =?us-ascii?Q?mG2/USmkIn3LALiuOeyWlmeak9annu22aVH+Cblb36Uy5Ubczm8aEaCjpTR+?=
 =?us-ascii?Q?hQcnyxQWtdB6wM5udPUb9N75PK+i8mEMOM12NBNboSOHpEwbK9/cvUp5ETi5?=
 =?us-ascii?Q?+UhhAZsf6jwuCgCWnYQ+dbUK1mncHfeBEQ1oLbtGg205kHji4iMBRBcpxJiq?=
 =?us-ascii?Q?Hh2/+r1lE2LTAVuLx6gHJHAqJIjqtwiJZx4Y1KX82RJbDHfJnWrDUJUkdPEV?=
 =?us-ascii?Q?/1YCfclq6Mw2zQU3/bQPEsnHGYPIyh4X+P3u8J9rvGJa2tj8JWF7dXB+VmDK?=
 =?us-ascii?Q?EBQvyS8JIOJfEQCkDrWAPzzuD00ibNK2BXxFhP+9jZjMH4CUGdtEWdRf8Du+?=
 =?us-ascii?Q?to6svd4Qi6WpAAPQ7+JdLR12RhE2Ry8VF1hOrdALUxoMV4rETkNMRoqDlYFI?=
 =?us-ascii?Q?7DWCiTJP4lknznnx4AKXuH38rqi6vlrbRa+LR0iS64Qr1Sm08iOpKmhh47BU?=
 =?us-ascii?Q?2xS1jnQptRyrgrDKVWchxMij3Rqo0Q6H2+ZKG/Low41E6WjMiusLQxBqAlng?=
 =?us-ascii?Q?FRlfdkk1+oZhKckSGG56zJC5EVqZTUOsTuVLSkY2n0P48OsCSiqbEFiBClOq?=
 =?us-ascii?Q?s1eC2238meITWWMXtkoMxKtFZquTOUAvrGCRg5v2Gxv3kn3KoC5NC4VW+gxD?=
 =?us-ascii?Q?KTq2yMsXPEzykdHAfgi6My3TY5S7ZsyGwsWS60eMFQ7muXvZ0X5FuaBMyFb6?=
 =?us-ascii?Q?HnZkjteyAuzpl7Cqt/T8SlsWUkEF2TPn280JPVWMP0qTx/SqjGmk8PdOZiOo?=
 =?us-ascii?Q?vUZo95ebrATlUIFmVcaa1I4Tb7nls8FNCBfQA+rLBVpIEXVcT2iWddeQ9c1P?=
 =?us-ascii?Q?Gppv8+R69cnnaqEf+heeNm8eIrK4eicGwVesawydPv4uBdTSM5YViFiQDpjH?=
 =?us-ascii?Q?ocJWo2S7NVAuykcSdSvZEZesfDJj76vYqo8zMN6eMGEeE6AJlTK8pOyAsIc+?=
 =?us-ascii?Q?DSC/+OS4/HTdfQLV70ALCIYF1qaxYOxqv3aFrmbiMPA0FLKV9BgDxLm6Lvv0?=
 =?us-ascii?Q?cvO+evNs+lbTm35sXiJ9mjO2hUa+Q0EfI1UIqfDg0pja9zqDCToQaysfdpjs?=
 =?us-ascii?Q?77PXpgWsX+gNrYSIrPjT6Mw6dgyQk5lgreq129+Qkl/KC99UsNDI9XGyj+iA?=
 =?us-ascii?Q?um7Y0Wbi9TRFjPjp4z2w8VuFdr56Y6AvsqiZ5mjAgnITlEFil/HQPesaBBZj?=
 =?us-ascii?Q?WxVHgjN/fy2DcV7MSj4vS5c6Gr7SlWi+1bb0KTJtT95gOPFyP1T++wacABzE?=
 =?us-ascii?Q?jZneDM86mi4+qxhc9o1OgIwAuzWRGzLBb0NdAM1xmjTSUFUXktRBBDQxiv6/?=
 =?us-ascii?Q?FJRvxsoSL/riK6a42BxwNRbg7iaEJuRkBHJCYy/Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f78c989-6df8-470c-cd3d-08dc2117c43f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 22:15:14.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHtdUsYn1cfk4wrGlRlY5bvPC7cWwcicm8GZbTFtQVRUiG3IhEK3Xncmvb/+37EAymiogVK2q9V0+GGNSn3KKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7205

Add i2c3 bus node. Add i2c gpio expandor pca6416 and i2c mux pca9548.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index b972658efb176..d313cf1dd79d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -261,6 +261,61 @@ i2c@6 {
 	};
 };
 
+&i2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	pca6416_3: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&lsio_gpio2>;
+		interrupts = <5 IRQ_TYPE_EDGE_RISING>;
+	};
+
+	pca9548_2: i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0>;
+		};
+
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+		};
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+		};
+
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+		};
+	};
+};
+
 &lpuart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
-- 
2.34.1


