Return-Path: <linux-kernel+bounces-42090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E83783FC31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2541C20F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B15EEDA;
	Mon, 29 Jan 2024 02:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uFlMhdhc"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2030.outbound.protection.outlook.com [40.92.42.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9997EECC;
	Mon, 29 Jan 2024 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706495196; cv=fail; b=fq90p+jWq+HIXFgqfdDntKuUhVNy3dPX+n18Wd/GOFlvkej/gXw9IPakkz+8iODiEMDPg3FRdbebaKXuyE1vbs9fjF4kbihjSCP4zmNsqxGRPJ72h9H4tl18IGcwj+BA6titOY77MernBnEGgvH/6JUguLEm2sv9upex37nvss4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706495196; c=relaxed/simple;
	bh=ha7bBHL49WHn75L//mPuuExozF3RFYE3QqlyNES3eOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mrw2Wu89JtusrhC0G0wIiPdHQ5rT2ewhnWJSQGgrSHa0N1RdmwcZ96lv4w30f1g6NVSahY8I+G3Ur9cYqnqqnzkKXzWtpN1B1x90IU8LBb5KXv4PGLmRZHPyIr16BVTOTCimBVkoHnCDF/dWYyQyaq8MRqJmtJR9ZZQ1Syw4YxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uFlMhdhc; arc=fail smtp.client-ip=40.92.42.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI8D+kPbQk4yIKSQQndniHSpnOhSXCrwxQ222wNslii3hJCfXAHXgmsSnzRynmTzlMqcofs3DfWZXfZS2EAntWXnYIrAPYxm7QttaLi10chBtlGYBUTE/W/lFAd1WRt2JiwmNaUTc2GddCn2GzftkUmBn3U+MiAf+BKxie4kaj45G6fBJxm167pvVVd43PKOjBhDWBLdQOqN7E/ABKhqKbhYdFuEz0KWEu53DkW1Jwuov0Ix0xcnScKqrSXtqGJgpiSYmOUa6xrUyvoaOcOelP/Xe0MOen0gSDkdtuFQqsCQcGOmeSa37VsjWLKHMhKDyUv3zv942oiK1Zktrt8+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rBrZVGTFGUjfjSCZZBpKxpxpmQrlYk1oJkWawv1DWw=;
 b=IC6KzzeNThjHS9B0suI2SFt9hJ7mJCnb4vZfyPukqDBxAsFVfej5SCPwF8TOn2g/90KvCQJx+kflPqbM1yhWf9a7E7UshGq6aUiJrH0Q2MebzzcmrT1bV41vCJQM4e7XiQvj84oJJ9DO6RrWPfD7mjR/qT7mjtNXqeEQZTig/iU8Pz1SwHtmNPqo4u0j30eCQphNQJmAOeqNQ+BGl/NVtAPPpPX/Duhn+scjlQ+7Cdl9gqvfpgvEDloHNoB8/F/1iu88f4hGh0l0VXhlrYxYuyG95cS3/nQnGqcPXatuFHJcIl8b/2tOxs9fSHzkiUzT+oOywButDN9v7d29P6oqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rBrZVGTFGUjfjSCZZBpKxpxpmQrlYk1oJkWawv1DWw=;
 b=uFlMhdhcx0GhBW2/SfsBWaGYvFkRcNexu6myZbTfqdinaS2xacoYWciBfkv4bUzT3V9GCqCHgdMMGwpbwxfmwuhp8vBg44vBOthfZDwxwKX73Tu85vzXYP9LTeIeZ1cmh8gsyzMFrpDcjnYrdetNrBbBv6B1ec45V+o9EKHxElb/XDj062uCUreednxBJbLr56vMXjSZSf0y5UDGtEhGLv5BAWVS105w/mcSjKieDt1pFDK5vHOv65YV8dWQ0N9r1r73GFnGdFERP5e1WEzCXqiXktXN3xHUXi3ZMRJ33U8Er+JLTXBbpIuIuRxkyBrdrdTlqtCADMfeKb8dcsY53Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5925.namprd20.prod.outlook.com (2603:10b6:510:27f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.29; Mon, 29 Jan
 2024 02:26:30 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 02:26:30 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	Inochi Amaoto <inochiama@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] riscv: dts: sophgo: cv18xx: Add spi devices
Date: Mon, 29 Jan 2024 10:26:23 +0800
Message-ID:
 <IA1PR20MB4953654F150743B649D5ADCEBB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49533BACE8D47590C1C341D2BB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49533BACE8D47590C1C341D2BB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [nYdR+MWgiAbjhFsiT20qn4z5q76ybYl7o5d2DVUtmE2GSVF8eRjLpOUcQkVKEsP8]
X-ClientProxiedBy: TYAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:404:14::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20240129022626.8595-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: adf42150-b4e7-4de2-1740-08dc2071b400
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnp1wg7CoaBAs0v5f8cuw07Y9im1akbz+aQ3s8sEHaSK5rcGe0vsBj3h569EphcPOYRn0u+UfMz6DsPPyTTs9SVJAiOxXsYjKaFJxsKksr/YGkO7RRzvCRqBqFbRETug/WLFF71VpJI+rLmteeA2e9mlKbDixrSHGqIBp64sauqwLewnxCxvHpG6+LV4AnrLUi9Lh9LuScDIB6ZjGvpZK06e5ffnh5eILUv1V3wvHMxbRakRqgSoWNJdvii7SWfT8fgtNdWuHa5iFTu99oWmrOSXICKTtZparg6IQycUCBjtcHNqkuX9z05nIdND5AjFzZtoThHmwkujvre9N+riYJOZ33oRy4fjgHqZmYnrpXXLQIRQk2Zy5m+xClzyAXMN04ju98bLxfy/GeY+pZ+4d5+l96+tq9Z5MkJzTC6AisEj6u11CbW1pHApeqiahmObgA0iojv9RjcZYMpR3xkR2Vjt4J3ARmKiSYvbr88rjP6PN/XK5d7D14hjhd3hgYwFS7jzgGBh1hH77Y9LrbM7qrjeitU4HgmjovwwlvSjMjfrqR+qvfcKdAY2fpIMJwC+Pvz1F2eycpYKcB9ex5tTgpIaVquuHYvW+3NbI9MDlgu2KuNDiZa16RO7MnyiL7EjT3irdvCKxRfhDsrQwPiCImEpyZ4k3WW2PpBJq4KkTOY76rlQdF1DArrn1rV78XxSJIw7LoG2NUNpRNp9OnGwug7oJWLzkF0iHPEK6Bb2zcNuSvg3pGJGeUlx/8NSe6IkA7s=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jlsB2x0V8w4IfEiWY88puI+x2HZcKBF3jr8sZ8oQc+fLPDPKyxfzGaxXiGXqT0cFPXDrS7pKQCXL10DPoR1ovSFiMrmlkm5JnKfut7s+1vTOFpS45yJw1LGzq42v7VclGBgq2h5YgqiKuarqJNtlf5Chb7jnbnoXbVHh4jcAecSGG5XB7qNcUG6yj6Kcji5G4AJ5cDWZaAZGhH/PybZkXiYgBYKJgTHbrkuVqmvhLjBBJ3xrZT+p6FNfSlz/fJUHGFUPDH/Og1F+Di/JoX+8BQ6xcHJey23Z+5Wpa2I5JEVT4R3/S8hM6ZywAhoXsm0i9bOrtzzJMFk73LTRrDZDmPNjRPM49/Jb2yYSq83ctcVd21qthqliBYWcvXC5NkEEWRwkOzt2oAv/HPJYoPA6MDO/jN9mPEcFpPt4EVRPQiMz+bfwYev5Q6UbQycUqVLQ5aPdWMeDIzKhU3Pc0gZEQD2bFDOLQy9XKAcdpHRI7EoIkKT9/hC16/+rcXNq7NEe4TEFngSbtOWcwo+ccQ1jpmZfIrHd0VmPKt5gMVMfciGpuM/QpzzF2Fn435mq1Cjp6wrpnLTdHvkjctz/yC/1Y2HjR7UQ7JtcNUB5dn6Rfr19+CcnO7r6WtCQhlhMHBse
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I0V16KOrfOLDnzUHwoPQ5UiJnrL5GBorxYQQx2oPkTMIUJyMsJ63AqvG7BdT?=
 =?us-ascii?Q?SehopUvQgmyJHphpZaoD5BIoj/JirM30p2HozS4DvJzn+FOhAJ/4M/ASMNOC?=
 =?us-ascii?Q?cDotMU7h38qU5XMqaheJ86zh+XjMkTJH0Vg9c0Ha4Ps7xBk34DKpE9WGPmN7?=
 =?us-ascii?Q?ossiXunMdR7JOj1UWJPMJ97cqZBNoFoaBDb+WJNK80bMpNMnIweMkjt3N8mK?=
 =?us-ascii?Q?vuDFeK7dFGIE1qJELmdI0tfJLz8ibU4vpaLWjM3/BPB2cu7Fg/NzOVBOLE/Y?=
 =?us-ascii?Q?Vn7Cc/yw7pEASWmIvcg5P75zaf6hoo06gaqHZnp7CTp59aqU57JN+MP7FPxw?=
 =?us-ascii?Q?77wsAa58WhQ00W8QuFkw16UKCkAp3GmgdOl0hmNgWrhZxkL55VnADAM5a16n?=
 =?us-ascii?Q?6QYcOrMNqnE1jDUgB2vp5VanYaBjrh5CDszU2uIqM4PAmtg4NiHJ1rg21cGF?=
 =?us-ascii?Q?HGFPJAc5TB7S6BQu72N43T2JGsBO7lxwbkiJs9rBm1io4CJ0cF0am9Hnx4fE?=
 =?us-ascii?Q?GosFuVe4rytNd/gv/hTJl7Vk4OF0oCCDuJDBnhB5aUupdaqNERn8hVPe2Pcv?=
 =?us-ascii?Q?r4rG/KWOKM6ft1AeDxnJIOPJKu/pmYX9S7uvrN/qXqGEm6TgcjHdJD63TIue?=
 =?us-ascii?Q?KV0WABHg9DGZ3reRWl3dnQNKHgcb6bvADjjC3KFeo5LNzADDhhQAoQ3ycPwi?=
 =?us-ascii?Q?5ymoltvk+fQ19rklXdIUpck2RgbYYUPVCBVxpQKE4pUxDRPPDCjktkl7Tx6R?=
 =?us-ascii?Q?pSDgvcHZTZr+6KhI3HQQyFc2IplGGV8oFadV1OestGAqThWbRzIjaJDe/NEt?=
 =?us-ascii?Q?9LTprkhdzXTWtlaoNl1MOVe9/p3cQk1H+rtMkeOM2WLXRT+r2YyEgNEK/8zx?=
 =?us-ascii?Q?HbaiKScfJdRk6E8qaTXfdhygSwjwGyPKJtbiMhmfP6x06r9UQn7yhzvZFbJ/?=
 =?us-ascii?Q?FIEnEgjeLn6cDlAd1jD54toffhVcPrKTTsHQBD8WdgI61zVJN9YxrSukdqlo?=
 =?us-ascii?Q?ynHRPKe7lhGDnEAyt51wVOmHm+klLkw0WLEvKBt0cCHDL+u+wJxqlUvOwOVD?=
 =?us-ascii?Q?CVe8aSaCdPCrfLfXzjOtnrGr9ug5GJtNa+vU+dKvI24/O9vYKlKRepgAoi3Y?=
 =?us-ascii?Q?LSqc2xw9uLz5MGpKwTA9vLJC98MZwa/WKjRgvok7eXo8/k3SCxPccy9+XtBx?=
 =?us-ascii?Q?wr4bugTYCQgWTLd1/+45BVgxygOXE4FSXH7aZLJZeOl3NrawtQwXhABflq9D?=
 =?us-ascii?Q?lyjU5Lmg8gwUs/6iIgTRliz0Qwyg4JYhG3tj46HIzg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf42150-b4e7-4de2-1740-08dc2071b400
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 02:26:30.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5925

Add spi devices for the CV180x, CV181x and SG200x soc.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 7c88cbe8e91d..e66f9e9feb48 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -176,6 +176,50 @@ uart3: serial@4170000 {
 			status = "disabled";
 		};

+		spi0: spi@4180000 {
+			compatible = "snps,dw-apb-ssi";
+			reg = <0x04180000 0x10000>;
+			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI0>;
+			clock-names = "ssi_clk", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi1: spi@4190000 {
+			compatible = "snps,dw-apb-ssi";
+			reg = <0x04190000 0x10000>;
+			interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI1>;
+			clock-names = "ssi_clk", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi2: spi@41a0000 {
+			compatible = "snps,dw-apb-ssi";
+			reg = <0x041a0000 0x10000>;
+			interrupts = <56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI2>;
+			clock-names = "ssi_clk", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spi3: spi@41b0000 {
+			compatible = "snps,dw-apb-ssi";
+			reg = <0x041b0000 0x10000>;
+			interrupts = <57 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI3>;
+			clock-names = "ssi_clk", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		uart4: serial@41c0000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x041c0000 0x100>;
--
2.43.0


