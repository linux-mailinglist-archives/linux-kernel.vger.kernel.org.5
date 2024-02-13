Return-Path: <linux-kernel+bounces-63109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C38852B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8753C1C21A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007DB22334;
	Tue, 13 Feb 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="U4smRfWx"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2041.outbound.protection.outlook.com [40.92.15.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3062940D;
	Tue, 13 Feb 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812602; cv=fail; b=HDwxv+QMNqS9IUoxEXXyyVjfpTOM1U3gXaxqWAOxWJtNtNio6oi+jrOM8zWXl6VA57Lykc/cPJFeWW2kPByo2g6mJjteAtOL6b7xcJF1K7zyAknVFXWXbagM0TCNjLKbRwP4kSU5Tsvb5xQrS1ky565Kb/HG6K7bLtGqnjMUZ60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812602; c=relaxed/simple;
	bh=j0YFqDLrVB6p/qewm7BdBZaNWb+9et08c7w1rq+TqVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=poN46dvf2RZf44WukaHKYxuhWa2Uej2wzXhn0hK5CS8Nz/znQ+hQSvlznFdCuA1jYohuAGTW0RjwKclC5ur35UZ0oFQmbnJ8JXyfLwUR0QiyAFXorG63tbJnC2wAj5u+qgIPe8OE7bLMd+he0NUc+/d4U/uHO9MoSZYFEMM85M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=U4smRfWx; arc=fail smtp.client-ip=40.92.15.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcKd1qhozzi9GPYnZGmaST46OtAAQhpn4FwHCzlgQX/rMr2r2/IUEzmOYxThAtC3idLV9KazApr3Q3dhgR0S5zw4iPGee3VUyMU2rW7V4oxV0iMk2CUed1KVVbNir9hkJw/KVNu6s5efxVTaQxLjHebj43v7YgHYBBsnzvCVlmC8feBnYuciIjfW/JFR+/feCgSCE3B78ym3JPSXPuEWrzrwyT9huMpwY9fRtfF+fsbOymOYOmlKYMAy4REEo30rzcwoDQ37OsbT5neAdV76S33Wmil5I05IjdU+3Bn+2ONTGZwIseSynyoxNFgbJpRp/cCp1/7GKMaBcdtO24x37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weCkVjGKX55Z8IJIrlCWo17og2J2tJDerIg+HBoNhdQ=;
 b=PkRNPZ41G6bxngMyS8fiMEmjOzjMStLNSpHhoIUPHd2ZwvdngksLr6k0csedSOVJ8NCFugUib73rbOYH0AugnIVBtYGYd3wL5LLEXPY9BNnwQLbkduGE5v7EjFM/En/UoFRXLkhEZ+2N2Sc4qhM7S3wSi9qyXTtRq1AL3xuSYP4QwDnO5Fmm8ApJulccZVnCp/2UYGMfl6jqfhAvMjBo28UoeTWV3FT7loZxG96XK3QbpbEDgfWukQ/TtdOgzuX0c/D1ObSAHTMkV3smxgKJP8ggYf+DiIy1EUx8JjIXdOxyFyWEBFfBGXSml1enPk1YG8oD7Unk9hClbfSgFBNYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weCkVjGKX55Z8IJIrlCWo17og2J2tJDerIg+HBoNhdQ=;
 b=U4smRfWxv+IyXpzwsvdzOvJGGoJhsiKG1IauOdeT7j5v97RecKVZ1xK0bUPOl5U5TPgJ5aGgZlYwZrt6glulysOYDeK6D2wUV1FbYjUn4gxA2dMSovDxsQ7VGcsz4lv/LRrf2BmU+b4NSNOicV7JfyOnxj8c2028FBZVbbcePFTc5WITipJKTmhIQ5ny8mX6wdoAZ/92AQqq0EuD0pj0xycinTHsvl/TH4x1os2mWlyKSsEyIRbWPFhnSaBZpNkgv058lFDgo4TXSScUZw8WLq1/dGZrTFyzPeZYLo75ta5oq1x82/+8kdBH/sCjdBKRtv6RbdgfVacr/oqd9M1peQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB3776.namprd20.prod.outlook.com (2603:10b6:5:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 08:23:18 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 08:23:18 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 8/8] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
Date: Tue, 13 Feb 2024 16:22:40 +0800
Message-ID:
 <IA1PR20MB4953B7A8E00DF94B8B25A0C6BB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nmoKBqumVqVU2/6W4FApKSQkv1jFhnSoAjUPmZ8UM0sKP70bdlaasjvMr8sY2W0F]
X-ClientProxiedBy: TYBP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::21) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240213082243.591875-8-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB3776:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e537e09-e3b9-4eb5-3b9e-08dc2c6d082f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qUEjElS5LYyFV+BZccYyyakXAVtDE3OT+UQQ5otvDpaD+ccWFVuppNL3w/RxqDl78n/UytS9ZdLwk9ejpKc6hrpzRY41otTT9RUI0PxClvvUlOm4MiMhipVSDHVdrh8jM/jF4OaYGFi6S2FXqvK74Jj/22IR9+lOUXNkjJQWvngPH2ePFpS1iEw5N6Q8FlLBhCoJyaxUJpCYQuRdsp93MVl9hzyf5wgjdZ0/pPi9cru+M2dTjki6VmteOJK/f3dQCxy58SlztU94rTN4PHitPW6XHOKuibCHcDb0jPlvrNUo26qwK0AB3NZ+ccb0+2bDTrJOFwU+PTmZLxoP7IlnjbQvvYcs3C1K40BCb5WQFtopZTQb6ASJFGBs6bg39cydrNIvrAQua5YlDY605RUgzxWKIfc0EwB+wGtArhVJ88eS+r+93CDp1ruORwOgHUnFpXz/B+pKzH8AIORopJAiEeMFmli0tmgSS+GowX1Sv94b6ovMkTe4RcsSdYcPIwC8h6ZAFI9NG6dc8c5dmXDV26uYsQkvZ/QnwhbCyw2fNC6NHfEMLP578NEqmnIHPga8alAq/IEABI2Kye0EGmzAp333/QJaF+dcEuEoi3mRRDykJVLIf0TESKAM5mpGgbIm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tw/gSBJa91DWKGm/WSB3IwnSRrjh7PjueN6wVv3j5Di5p1kzx1HWluocl8TW?=
 =?us-ascii?Q?Q7rzlR0J7cEZPTC6AWVHpeA9U+c56Rx4YWuRPjH5IJ56C/qhzREeZ+pGUlr7?=
 =?us-ascii?Q?ahTRbalJj0QR2kO9kxIuqTw42ktxbsXQWJWYkjTwgq5wF5FC6Qou+Ww06+7Y?=
 =?us-ascii?Q?RhQ70P44RVizFbrapyvmuEh7C9CdWb1zy1rz1rMcvhRRd0tUxpGdf/EPu7lf?=
 =?us-ascii?Q?HjJoRE6t77uve+/AVrVa1KsRzNJqAY68EujxSECoDC/CAq83cNNotSdZGr5s?=
 =?us-ascii?Q?eMjgshg0YGUidx1sU394JrcnUjmAM3GWPABbdBK1Rl4MdeJDzkRjiaYK0zZw?=
 =?us-ascii?Q?0XYsLf5hGfguR02tmED+o51M76ImdjEdvcGdKLOmJ9nWzEfGZOGjrXxHGoVA?=
 =?us-ascii?Q?Mk4Jm1PDJrFBFf63j1Czp6BzJubRCfhbdzjH9Fe1x2G8qYFf95vXoK4yuiJB?=
 =?us-ascii?Q?qI+ilSIjzUsFUr+AcD+7qQmnS63g8DO1kw6vOR38TQ7BXtJ4kVPpu5XgAQW6?=
 =?us-ascii?Q?V/S6PeoL/Y3IxY4VuEH/02MR55y1c0kDRXM9r3tf5UTlIxQy381MrbihPfCl?=
 =?us-ascii?Q?45oWKQY/9jxkZBx5A9hedJkkoWFTJTcic5FbnBRm6p2oG0bLfhd1FD/IPXXy?=
 =?us-ascii?Q?aVQHgry7dl85wnehm5dGUwGyW0o8q4v+E25Na8UJq+91yQFoj8nAGV4bvKEd?=
 =?us-ascii?Q?G+iBU/Ahn90ETPLeRO+8U0GMA9Bn8YRwOKEDuZGPba1vP1MxIIHGPR29kD9f?=
 =?us-ascii?Q?ACEiI9Qz2xjjsv5Of7VMhRIITMtdCShZPjxEDpaTibVTcphf83ezh64m6IDf?=
 =?us-ascii?Q?PPAV6Sc7ueX48xF1+rSnaWD5psnWOgruzpLJD1tYYtA4z1SQT5dmN+qtxaiM?=
 =?us-ascii?Q?m/w3MUk9Me4WMuKPZLazCuK1y8uH3lWI5pDrZRagPt0pZS6zO25Lh61OMGlf?=
 =?us-ascii?Q?5pMYpVRtEY3/keirsmFXKfEvlFXbCVgTa8vH7iC7+pSwtLNUiXoQgLcIpWx5?=
 =?us-ascii?Q?JjTWxm3KOiP7Qhu4Z4hvj7wSsjGov1B+hYxI2MQoeCbL43XTqxtUYI3puhZF?=
 =?us-ascii?Q?DlqXB3PQbweSWnjqJU3lHeZuV+iA6+oXOkoSUebsRxN3O4Gr8hPvr+wUA5Gf?=
 =?us-ascii?Q?vj6FfWjuYAdfpbi/1skcg3q2/A1JakG15G5kNjQXtUg+gORuaWXG/j0Fql50?=
 =?us-ascii?Q?xAYYBrp5WE0NZ6no/NVO7U/1OBL1riDzhgBTof72hhyH95BVDR5+MyM5OSbT?=
 =?us-ascii?Q?kqKeOIbfgshUsoCHrivGm3XAmmr9ZlBX8W5eu98/2b/q5H7uh6Q2VozGHb0r?=
 =?us-ascii?Q?QGE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e537e09-e3b9-4eb5-3b9e-08dc2c6d082f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:23:18.1608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB3776

Add missing clocks of uart node for CV1800B and CV1812H.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 6ea1b2784db9..7c88cbe8e91d 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -5,6 +5,7 @@
  */

 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sophgo,cv1800.h>

 / {
 	#address-cells = <1>;
@@ -135,7 +136,8 @@ uart0: serial@4140000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04140000 0x100>;
 			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART0>, <&clk CLK_APB_UART0>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -145,7 +147,8 @@ uart1: serial@4150000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04150000 0x100>;
 			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART1>, <&clk CLK_APB_UART1>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -155,7 +158,8 @@ uart2: serial@4160000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04160000 0x100>;
 			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART2>, <&clk CLK_APB_UART2>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -165,7 +169,8 @@ uart3: serial@4170000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x04170000 0x100>;
 			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART3>, <&clk CLK_APB_UART3>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -175,7 +180,8 @@ uart4: serial@41c0000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x041c0000 0x100>;
 			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc>;
+			clocks = <&clk CLK_UART4>, <&clk CLK_APB_UART4>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
--
2.43.1


