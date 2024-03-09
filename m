Return-Path: <linux-kernel+bounces-97824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB785876FFD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F49281FD7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752913770B;
	Sat,  9 Mar 2024 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="j8Td3y7k"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2050.outbound.protection.outlook.com [40.92.19.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653E3A1CD;
	Sat,  9 Mar 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709975035; cv=fail; b=n0NMc6QR64z+weiAdO6jOIBvTeiiex/P+DzUEUzhxThLmqiga0cB0RzatxS1UWSGlIOJxv3OPPGGbZ9iegPzB9IC6pjDVXuaNDmdA9pAkqfXUdVzdjOI8JUyFxIqRJkLaMJCnR/C/EsuEKrUoknY6IU46iMty4F83MEPsmwArfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709975035; c=relaxed/simple;
	bh=tBY/w0hBxHRzGiwsfEAvpdBgpOx1yxTDZURME6i3ePs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XIoLj1vevAi9+67V/npW0RJzeau1yDbqGyHeN3bb7TQx6VHgRDLlg54k4lQoWjnRVmw/BzySd7l5RrV5CBoDbl9I8yL1skDkaHOwR+ZuZ2z8aPlEKw7QjQ7KkUdPVyU1/TTt6JxYLolfhIuvr4tyrdE2vQH+1KSNE+2a+zafu/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=j8Td3y7k; arc=fail smtp.client-ip=40.92.19.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M15tSgPNzWecBYjtI/WNfHc/oT/mA5dZZ7rN7cFiEyivUC8VxV/bkO71+tT662qddelA7emmHIs6qLCSdnn5FunUcnIhOloZ4x1sstMnm2u9bRXl+8jzt1BguJgZ7xRRARc6wL9yokvnwSgFUAt4ZgU6E1LbKIdEgHphathp0bTEf2LpqLwXPHkm5rT52PkYsOWRaD4cE1kKXFrFD2a6xuI7SgTpY33YFyIelzNNkYwMkaCX2QVk8Noyn3GuaUK3OS36xi/4JSi4OpsbcUV7GELioSBWJKtmaTFKJa/nHM/xFAs0j82uYLffM8Jof37Wag1bOpVESRlpDjwQEdUqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcbKUs4tjwPfmtoQHjJEtEOH870JPI5UD2IQCwte1Ag=;
 b=EGznzzHlVguge2LSiER+xFtUL9a2fQ2PFAidlcGure1f1ccy0xn7iJ9YuIPtILDt6Tvc1p8zYVDmOnZ03LPjAjfKNl3lmbgKUBzJ8tX3Y1rAuK7Xstu2fPUF71mJk90/WtPwEbY2uXcj541j1MTILBj+awqR71ufrKSFz/tV/v/piP/jWNQr+jmBNWcAKhK8mwDXKZ6WA51rcsJ9nna4a6F5WfXA7ydhLx2koXC7/KmthqnOKomY24Q6mIqWwboHMip+MWyqwFDMt2M4iwaWeP4sPzIdHEWjUqUee+ApZ7oQYmfqlLW08t2thOtlZeAje9aDndOZ7g+6tGBbEvXbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcbKUs4tjwPfmtoQHjJEtEOH870JPI5UD2IQCwte1Ag=;
 b=j8Td3y7k3qDi0qwOHKXcSOZDoZ6PfUa4zYeVILLsIjooyZIOO1xG4jEvC+Z5jErLhpkFTtkPPB0xTAGPZwrh5Jpqy2ocvRTWME2CmyMZ1dPiJNu6A4qU9WojfiSFzLSnG7vWAy0S+8kv0BPSIuR9ayFyyLFz3I4Ri4DdVAl95xxA/s1pMz8HgqhLOf8QnAUyusKmcGo4eNy/W6abQgpXBUy8yqALBox2Ma85nneRST4KzOfclrgc/6pWE4FESKcMiMplK/LajS1LXLsd9qcbR1p0g8U9rIOw+0G+OXFLyMqNZ+UfSrZP7tHZmTia8CzQUTJZHMOUTAE+MiHRuSwkJg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW5PR20MB4260.namprd20.prod.outlook.com (2603:10b6:303:191::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 09:03:51 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7362.030; Sat, 9 Mar 2024
 09:03:50 +0000
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
Subject: [PATCH v9 6/6] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
Date: Sat,  9 Mar 2024 17:02:56 +0800
Message-ID:
 <IA1PR20MB4953198222C3ABC2A2B6DE21BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [kOBpM/sz/uf1MNbDh/P5gclDBZEdpCu8SQWp2FtcV8o=]
X-ClientProxiedBy: TYCP286CA0347.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240309090257.927623-6-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW5PR20MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: cb95b0a0-d08e-4cf9-9a8a-08dc4017d682
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qK3HtK2pRHDet5tYICA67wXoayHMIMMKR7jDC0OSRz4qfB6/kkXQePqzeTmRMLa4jkYDyMRzci4WdzzNuJai0KhkYgmcgEjxwtl4sO3fMJnt7yTTapuUt78Fwq8FTX5ugt9GLV8D1kQ6MMK9c3aPlNzGJkRNcznw2v/DI71048KYqrEShat1lU5PWbi0N6GZgQMp/Ci6uiX02hMQNRgll04veQuWgtMsokpw9SoQqAb9kjAXv4s7NIUqq7idV2+JE2bTbF0AUFNOXPDZKg0rtzusE9hTArP+mBA2nFaAxfh/ntJiAOWyQ/Tb6+YwAgDV9zjMKB1+SKWjJE8chnKSsI7zt4TwJsUPUFCzR+vsxa8ycrSTsav57BpR9Zg4W/yY/tqS+tgm7suTjcC/RL3b5ZQp7z3bKBxCYN0txBG3IwYad8+JEuyahWV1ffaVdI3y7VeFdSyaxPUhLKThwaeehU/r+x15Q2prwH4MlTUusRpIsq1y+8dVVPwGX9l0xab8g6sAdr6uDjS4+tce8XqMMR4iJF3MLoaF/39qYT8YFyy6DF+LxCcWe9shJuDnzR9pnyA1LIAZX9svY2CuVh4HKs6UKsWp2Ky8RQjxoUA1PhqSd3b5BwRibkxR/wkS3JO4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fUAqNnkwRPgK6jKWEp27CZYAE2SAXvrgGFoDoQ/lz1IFcyj5Us2p9J6IVG98?=
 =?us-ascii?Q?k/BS3oygKFR6bAD4oGFGL+Sw1dK8S6Nvp/TiBcFt3YrW8oTiiLxuAcA4nGBr?=
 =?us-ascii?Q?ybA8sLGqHcwwA5hKgvIm7xQaP0OzcrP4I6SV9UNgZR+v9EK9I8Mna8cCYY2d?=
 =?us-ascii?Q?Ut4hMU0il4SlIHTq/5ks1tJ42joTZEBY134xBT/aQl0JtgGAZypJuptGCdJo?=
 =?us-ascii?Q?FU2Z0EtOJiFdd5SUXOawdvBsrYFrAxH0VMdDwgMRjqOEZx6CH3vf/cfjOWJi?=
 =?us-ascii?Q?2qqUosP953oVxE6tG7B65fTLeMUdtKM7Ns5H5cCNjTofiCEpUkAmB/FY+8gq?=
 =?us-ascii?Q?WxNtcvKsiz/jc2ypg1W4gvIpsqA2Yijnf7OeVAVyt9yov05Bb389J4kA5E/D?=
 =?us-ascii?Q?O5Nes9oxCQQ08ApvSXwHsyW50oZGriUigax962orNT4DS9GSObgBdtOqTr+0?=
 =?us-ascii?Q?4gsHmttkj8PrpnTUHYhALATsCYoRiRqG2gsVoobQH1Jvg8OTBkGWZnbi0lh2?=
 =?us-ascii?Q?GULYe29QR89339lXp3o6L+bKT6TopBSWcfPP9UFPNNDgcUVQxXYhGZscVAs/?=
 =?us-ascii?Q?qzhufYH0FGXvWbnEfuz2eQoav6BaAwfY+hG5KVeJ2FMY11qLnk8jUl8QiEtF?=
 =?us-ascii?Q?N5LUPdDPE4ZGvdGNk7BBmgWZtg6wa5IZRuBCYgQKZ3LRKmKvGvuh2MQ7FlDv?=
 =?us-ascii?Q?IDsJ1W7yNXVCZeY8vOWhNVSABNuDfAjxgK6qhhmKItQw+Mab2a6GMqR297e6?=
 =?us-ascii?Q?f0zRz8HBClubzba+DeSN5Q5qiUSCzcuRNcnOCgfpNBkK2qVz4DlmA5+0xwPq?=
 =?us-ascii?Q?t7EwTvDMUK8/cRmXsj1v3gT8hQJsRzokou7wEHqfgwheFRk9lCo5eTMjhzcP?=
 =?us-ascii?Q?qXl3Kmpp0X6A5QHf1QKSQXPJVuNsnJ5fDwxPlM3IREsHUiM44Plof318UXMv?=
 =?us-ascii?Q?Q1WJQQz5U9ZcZ9QVp7CT7Do1GD2AZYSrZijhm3l9UKpvUzeFJuh35ri+bKMG?=
 =?us-ascii?Q?pBesLK26sVXHkpBhx1LG+2O9d1Qp2mfn/06rtIDYLgr9A7OoOD2xCuTV965D?=
 =?us-ascii?Q?JWf7lTVBP5IheCxCQEvi1+W/UieuNnG57yfnus/+gt6McpBQutLeiqXbojnL?=
 =?us-ascii?Q?7uW76DsJrP2nC5re4yf/NwpPIYJ6rYNQhJz/V3pVdIf9kNi51FuZ0xXDUFsq?=
 =?us-ascii?Q?zYsS0dbQ0Gk4HdRWJEByHW8YAsvJ4+zn9pZttuP5IhRHHIHoqmujvma0l89h?=
 =?us-ascii?Q?I8UcDMiJXspVK5ARmgsz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb95b0a0-d08e-4cf9-9a8a-08dc4017d682
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 09:03:50.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4260

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
2.44.0


