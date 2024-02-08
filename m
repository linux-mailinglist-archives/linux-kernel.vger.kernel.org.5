Return-Path: <linux-kernel+bounces-57669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA7A84DC04
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BC6284EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA157318B;
	Thu,  8 Feb 2024 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L/qiVQsf"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2107.outbound.protection.outlook.com [40.92.42.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750871B2D;
	Thu,  8 Feb 2024 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382180; cv=fail; b=r+77dko5UGDIvajghOu1YW9GaE33sOLZ7KFKaDtLwtIM1t9unPngs12Lc+qbDNS1tfcXyhLQmen383AFiGdtlz53Uz6Ma0Xcxg7xtrMY+y2PJPT7nBaN3DZCRD2Lg7kpHLZmZnbI3bjv6Emh3E1oVpM3yaZFalhGiWtgBUVbdJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382180; c=relaxed/simple;
	bh=4l5VlATYOtXiw8DStCBe5UbmUWWLG2QgU3Y2EYARxZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yt3RHgCEUW/0Y/k+XcfONf3werh7RVDZeur0eAAF3lLk5NndiFmU95EgiCegjYkema0b7NF2NZOGJTMEY299tcqNiw3qfY1JchD+D+dRlJoLmc1mhemcvFLAOR2xGqrHHrPFtZjdmyhllirnYGGq8I+S9sDbaD3Sk3mo8ANyhDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=L/qiVQsf; arc=fail smtp.client-ip=40.92.42.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBoP8Vs9vBgOa/hB55UariqoAQfv7AhkQRGnz6e2+ybE4Of85nlBMQFsp86K7OLIGejCaWrqKjIfg4jWQCgI4RdO1+sLWPpLM4M/u9toUx66fZlVvjofeuVus3IgFFT7XAewlrIVs+TF1JUaIbLquPCAiRwgbSuUSIq5fae+FUNDCU5y8ThW6p2xdvpVAb3D4frcSQcWuzeTiNTAzBjDIDh9k4ToJjc5asxjrzhJK0We/+A1cWQD+iaOA+9EwGB3LLQHeBDgXi/yybS9+9m109nGiA9GFCZDSCM7M5/yUyuNr6UY1qCrzZYc8dJy7awrwQUgSuMQBG0JHqSkkR4rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWWhY8tJTP1RlZ50pTTqMJeT20HPXWBM9HGPcTeqxaw=;
 b=VuoTfn4hmU+c5F40I/ii0it1Z745kDlRC6WdYuiF+miMSo8xnCxuymc1jjnYm06QoGVo0dXdSAs6TQDqhHVlO4B2xFmjXDlLYJ0A0hu6C/gG6RRi4CEMrGTJP1gjP1zj7pN+jIxrP2NLy++DREeOPChLuPijuNXM9yTxm/6mAaZ/guJHaRj9e+9O3EbyE/majGUWHlJ2+iqPSyEB4PNAFmxHMceERzaY0cn+mPYb6lBer+jHeipAGvJ05tsVjz3gnCwJGP2mHe2SOQU0eQFq6aTrAJjr3IITAOGnMrQSqxpt/FoxcLUhcMJq2D6dN8sOfbgAe2Qxrsg+qUZDpp8Trw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWWhY8tJTP1RlZ50pTTqMJeT20HPXWBM9HGPcTeqxaw=;
 b=L/qiVQsfzi8H4wlxuF2phCiX8FuwabT3Rk/OC8oealAUIcbjfLx06rsuLdklnqx0Sx5XEVeip6eYJF5xOuO+SMN5W0or4T/Cy1iVBkTDIu57STdujSXBHH0Pzc/0eVLTTE+NKgrwhIdhk0Z/PMIwKarAa20xbpi1Q6DmWdO6fvPk6E7HKvEaQTYLkg1RceHMFm8dbFjjxE+AMaevZauhJiZZnJlDKJWI+qbdsjKxnLAQQVuMwrXvxQT/9vREIPRyT3LJ+00Yqlsh9F7aPUK92Pda7aVeZxQ1fwUtSQGUChRV2a69/xQV4TpjBPPMwvhPmXyvvUclmIN0kR1dZG4lTQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5985.namprd20.prod.outlook.com (2603:10b6:930:73::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 08:49:37 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 08:49:36 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH v7 8/8] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
Date: Thu,  8 Feb 2024 16:48:56 +0800
Message-ID:
 <IA1PR20MB495352F0D7B2AAA826FDEB1CBB442@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [1L+cBdK1gHdX+fodjltukbodrCc5qleCI2XEo3e2AcykAn99c8ck5Ysz7D2h79IO]
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240208084858.1113628-8-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fbad37-1414-45e4-3b53-08dc2882e11d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/GzKykz3fnSZtC+Zfy7bk9pLxytHhljzXrJExJAsk7G68W9ZfTEVFKwM2e4SQgXg7LiiDt+E14NrQqy/0mj2Z2hmEraKlrQtjAwh0oH3X0AwQs5mrZzxoglMMwsJT7XwX57cBSRzIM+ITgdq7qtupNMrxUqXVC0rRnybuxnjaSxOOCxUSYHNEkzuWgkb/4jPsnzxBZAERUaMtkLIG5VRKAu6Lk2q57KiNc9IGjI7bjhHKz7SW2VtNmAsOni/6w4r6zem8LGIg92WFlmy/Uny/yz6ZH9A36knfd+XpG6D0JGCZTtdwyehrulGZ5oaHU6fc6InBbO8HyrfcpJPEeeGFLkKjDX0rN+uaviiwlRbhQrbRP3ThdYeP8wb5UMG8EpHmGyi2ZEBn2P0cvSCy9Zcuf5UG+cGFcxS99qXFMSzPGZOL9paTClqtW+ppW2rKXYQY/mgR9qbCPrHdUuK9sSLbB11iptWw0oR0MtS+JzEBOWUMf9ksDklrJ4FJ9sLgPXKpLSda/MOsnryMkdxGAW2gsQKaAVNLR+Fo7ggy53FdySkWMaXO74NIJQ/D+FgL3kY+KoKjeyLtfIHvBHL1qHCjTx2S02eZMJmFGb9NaDT+ASgZD/5oDXNa5zN27Kfv/OL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kR4sD53APuLti2G6yKLi6h4+Ov1mnuMlOzXnLnpekzbNV9/Wjvm4avPXpJ+U?=
 =?us-ascii?Q?JpnlV2jITHQ5sJIjcDMPqPSnhleOXDTDXc7G0nfJj1ZG3Ba9Le0P3TWNdLkA?=
 =?us-ascii?Q?2ukOoaK/FkTp4WYE0ypdp7W+WVcFWdyM3Acqr/bwgjnD+I2pHwdY5CNFerRk?=
 =?us-ascii?Q?vIBW8KBP4xhLM6xFSYR1XFXtmoazX4XsET9oUjibadanZgc9OhlU7QsywBeS?=
 =?us-ascii?Q?QH44DDhoD9/1aSHgx9mMoMklXa86GwOfiPuBDqkqqURyBZ4+ICbmkSP1NpyX?=
 =?us-ascii?Q?7i8USOTZQi+JrjRKW8xpogryTFVYKXoIh7ENQG2RWBLZe96vB++cY0G/ZlUe?=
 =?us-ascii?Q?PLlyM/8ImoHtdnkLqLfKrPiUcZ0upduGUF7fhm5WYFiqquNwkInOKVRxR03j?=
 =?us-ascii?Q?AcbyUzkj2R/fVfohMwqIUoT6cj7eyV72pUDgOue0H23FQe01A9gS6BjHAYPF?=
 =?us-ascii?Q?IGm0OARluUIThfKYioVl1IXJwAJnVagUx8tBvIwcSgqjGebs8vmpn8e1Gtcf?=
 =?us-ascii?Q?7G+j0q1EmF9Euk511Z0TfCkt43xFGBF1NNMW4WRwJayRSJwPajwDJg78VSjH?=
 =?us-ascii?Q?Bombtjpy31Lew4rNaDN51Ta/fAH/F9azqTxCqCixPcPTL8ay+Un51IiR0XIg?=
 =?us-ascii?Q?OUReXlk11d0jjb+npaluginS+aIhkCnMItILUDxMqPobRz8LpFSSJLlkYCoR?=
 =?us-ascii?Q?KtMxw8CXdjHytKjpBZziPO/hkOwb3fTzW1bUKzQof/kyU0sq+SSMJe+nmmV7?=
 =?us-ascii?Q?Zxh/3FeZF82FeY/OHMGrwAABAO8xTH2Ie89kYQNfwOjXNIdAlALH0ZOzmWIs?=
 =?us-ascii?Q?MUcTLB3l5DvpAfwLov7d38UMJ1uZ5ynk7BrdH2gqse6Y6y1McoTmwcgRJgay?=
 =?us-ascii?Q?Itcf+UNUEkwzkKLVm0Mn2XL7Y0qr04DAaqM2G+EFItXMSFdbXRD+A6SIY0x0?=
 =?us-ascii?Q?vzm7X+gRI3B2CTImJleqbJwQ1zUsUSgjUv8Sky9P1HHNq+UyRsAnZdLk64u3?=
 =?us-ascii?Q?ZD+gLfGjZnuv0woeeVJ0QMe80BxIhuhO/LxchfeOQfwReHd0uTGkp1/uBYZE?=
 =?us-ascii?Q?URQqnEXlB+630iuzYV4cApl7xeyc0oq2ElVyRfJQXOmdPfjjawqo5W8+YlcA?=
 =?us-ascii?Q?rQp1O9ZMRC4HsEDPMhMNQL7CIeGaI20VC/6vtY/wXcdKYZ1o1iner+vvbY6B?=
 =?us-ascii?Q?CHMoOy+lyEMr0fEBa7Ix/NpuV8YyYfUSET/plKroWlGAgOhYXUwqLPezWf9F?=
 =?us-ascii?Q?qZzQpVR0ofTv5Ya7v6IrEPwab7tzR4e6sRj47v/zFA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fbad37-1414-45e4-3b53-08dc2882e11d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 08:49:36.8845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5985

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
2.43.0


