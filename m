Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50DE7B4480
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 00:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjI3We3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 18:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjI3We1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 18:34:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FE6CF;
        Sat, 30 Sep 2023 15:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9a5bGazxXweaihtF5XEKkQT71MLkd13SLyXx0UsDBiZfuEV44HWjAvlrwRx0Ic1bSK/eHSBT989Ip8OV/50SMBHmN8+vuCQm/6xv/tREPq3Z0MQqAAHwgJ+UsSFXlXEweWFj9grmwg+QnknJwkbllwNqev7C9T5ckGChYKE9AMx96i2qBxOdyphislwXMRtZGg9ykDc/zPGCzkQ95VI5QqUa5uKzxY1Oc7ZcghJlT7WeMiHc/6PJJ1JzvE8EPX77ycbyd5ZJCt5PF9d7ztKI/E05fFnP6emhJ2IpMRiYbSq/W95as5Qv7tWkmRep22SBaVNBG2Pd8lCJedvihRZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2ZUGmPFeIbaa40ikX5CjtX8HrLvG8twnUatfGN+5tQ=;
 b=c5mAuQ4PzMkQDO7iEJJRiT9i1/3L/+fh+tnGaWg6QezL05/qL5fpWdvHdwWsg05aJz6nBPr4zQFO8ofbfgBT0Q7LrVFl+K5b7Yt4Pb5Zxlz8k67fCd3JUvhoGCuAHDzjK2SXCi/sAJRP55UoI9BufrW1RHP/rMyAlZaXGdRdDSOzJX5seTMwZDhPrbc74jgzYiBN9c79gJ0WPTsIFRGtEMRpYKKaQqit2em8/a3DZU3toOR2sB/DTXG43Pjx+oXFu4M7x+NMNuFKSwVkJMQ799BqkJZURgErZ55TgM8TPaMoHz539fy5AnegRsCjxFJpObEiTaot58tkB9c9tzE/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2ZUGmPFeIbaa40ikX5CjtX8HrLvG8twnUatfGN+5tQ=;
 b=eZwLVOXRknEYq3GHNBdn8gCdpeRrjz4bkC6TUflgpzGmT6eSgY5xya7pyJzreGqbBTxb1SfpT8lvvCVkt6fHtu/V9Wsrjq4lXIcVU3AdGMgVpCAMCRGCaO//CurTUqoagrYeZ8BGzg39HXXGz/Gv7xFr79JFRaKiZSkHrrdpDaKwV/V3mPl5DK78oU0O3pf5YvoSw8QKmjSOOwrnYG5//rf8Rl2sI8B4ZspxFt0r+K5FjvJWiUD3yqgdpGz/FawGBoao6TgzjDW1l/92HnOhHKMhy6IudqQp5vPBc6jRCDLkscx0hi1Y1wS5WdvJJb/nZET9JkfSw0ZdyUgXPWF35w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB5631.namprd20.prod.outlook.com (2603:10b6:8:10d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sat, 30 Sep
 2023 22:34:22 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::d050:882f:a8a7:8263%5]) with mapi id 15.20.6838.024; Sat, 30 Sep 2023
 22:34:22 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
        Inochi Amaoto <inochiama@outlook.com>
Subject: [PATCH 4/5] riscv: dts: sophgo: add initial CV1800B SoC device tree
Date:   Sun,  1 Oct 2023 06:34:21 +0800
Message-ID: <IA1PR20MB4953CFE2FB68704D03082B4EBBC7A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230930123937.1551-5-jszhang@kernel.org>
References: <20230930123937.1551-5-jszhang@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [2L0fNImHv4TNWtWJextpm+Nw8/AdP+PvCtlaEBlfaEA=]
X-ClientProxiedBy: TYCP286CA0063.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::12) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230930223421.6878-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: d99653a0-b891-424b-70b2-08dbc20564a9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ezg4vJnp2STOM7k5IKIrsEhMYL6CVNuW3mKbAgrlweRhX/Q0czFPfXILQcKJlv/GcfB8of3a7w8ZimFi5LwjQt8m7AG/OhzL5x0svpfDEtPcpIUm8x+h5Z9EbOgFht5tBRnUbBhIMH8w49ztgw+DgphPwfoIoWuIhB5UO32YUnKhpXW00nJY+ZiAsORodBmAjGrv6zoQLqMXowKsWrOvOIrWCz2zPHP7z8pmzZpiQghT18sQlwKvM+xGty+tz9m0PaRMCJMQR3Q5zNtq2EPcMtuxFkhvyGcWf908jXK5QWp5jBAvtXfc8sbKSZatQBS5ZlhPB13ljZ3TLMWFhGB4i/UrAH6oqN7hoCRgan8UaTOM4fQEoYADHczchRgAX9LELxqc8b/5F+F3MBgFwFRLSxNCtmpog0IChJ8J2tN6YkF32/xAKpeK1QojVaiwlGiUSxB4Z+qEf1755VLHxp1zEvtT7Zdqxn7qFl/87NOYT5Ddnv9fCgmdAIiBn4nMS1Bw2hrcUAtCh1EQhq8wFZ2ctRtUauthafQ3NbUFFbxlR5xmGAWFMW7gk9SzofxZpOan2cGcH4KXk6oRH62k2Cu7OTQyfIYbPuwtyrPihg6mhNQZ2evtyLJ5U+McnQIqduIk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ouvd9fuoi2rE/01X6EFXJE7TNUQEXfjZ86EklBEb/ZBvNwj3lJjelNs4ijQo?=
 =?us-ascii?Q?FLHD+YCBxkLl3LKQQpWIfVYgXhxGK5TRWelthDD4dK9gCDGtsDQ8M/JlxH3N?=
 =?us-ascii?Q?AO+Znt3lZCWwIjt93NSwvx5zNf+5sH9jvJrhuxmuEznFHCDScH92zuBnat7/?=
 =?us-ascii?Q?/W7XD+gxrR4mMUV4Jl1Txqq1pZgCCRluDAWP/y5jOYQaO1vIo1A9MIsO6unT?=
 =?us-ascii?Q?xBv3xJunXhekOFVSZXPlPK6HpdEN1bZ4opHE38YfNgk3HmGQ9NyrlYgMKclT?=
 =?us-ascii?Q?Ys6DrC9vgG+1G82ZMsFz3M0iNiQ1GWjWfaFShbP7Oy+2U0ELMh8LKGDo+gXJ?=
 =?us-ascii?Q?Fn0i4+KeEc8ZuVG+WwnoRHf6gAmHCLfLr8hPj6Arla6EOchgpM2MujdnxGra?=
 =?us-ascii?Q?+gzLB9naFl1j2MkchqOuHBUrIaHZAgoWOdnsYhIvomBtuYQlQDNtHLYDRkVc?=
 =?us-ascii?Q?PBKAFukTepHdzy8b//06ClvB+j7RJtyHgSslCQx+mp+6tNHPb2oeGU7XtGcb?=
 =?us-ascii?Q?EvahKjO00KAavDCz8e4H+PsdB/k3I8VyhSsnQUInUODs6FwZHJI4Rj2VFufL?=
 =?us-ascii?Q?XCGjk7Q8k231VC/D51DGykN2OfqBgiFZAID9Ibk/l4kdGe4EDunZn9Q/2sJB?=
 =?us-ascii?Q?hDgUMq/hAFjCpu6daIO6h8pVZa4GrSBS+cKByKOJbkKDhfC2fehc164fQcHJ?=
 =?us-ascii?Q?hRwU//MnXNHyizEdFrqoG4R71BFm5GCs1BmLvmbEKmWJgSKUJgjznaA3GxV+?=
 =?us-ascii?Q?DOdfDELyRcKDcxp1559Y7Zd6Ty5dFDGNYD1a3pS1jJlRDP24vM+ssBzX9Uxp?=
 =?us-ascii?Q?h1ff2AkZ4pPiIVE26LoEdDPAGRFUX45+ZXlahGsqKnpcgajFXrorId36GI6e?=
 =?us-ascii?Q?Dg2NbrxRm4jRLBqa8xhUDvEAz3LrTy7TplHyw2iSgJTWqLe7pqQRFpljRX5R?=
 =?us-ascii?Q?E/1/wv0p7IhttPhzgA4kDQNvX+IBadlyhmEiJhINPS9zB/iYXZXpglMZIXlN?=
 =?us-ascii?Q?m9yw3q7AENGm8go7ONFmto9uG3NAA0dpvVlkCZkM0eokwJZG6VsFEAXLd2S6?=
 =?us-ascii?Q?4qtH8KDEbzWm9y148BVciUv7x5WPVAJ/cEa/rvUtRVdiebMU9YPzMP7iGh9x?=
 =?us-ascii?Q?UUbVxLIy4SrgaGhfytOUktAl98EoI5aPt41xw8g+V8JdlDCU+sCHlR8CKD1c?=
 =?us-ascii?Q?VPUKV4z/gWaQBlOgc6x37FkDfquCqWJAkUaVZrJAD1NTiGBEdtbzEWaXQc4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99653a0-b891-424b-70b2-08dbc20564a9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 22:34:22.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB5631
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jisheng

You add the clint dt-bindings of CV1800B clint, but I don't see the clint
node in this dt. The SBI needs this clint node to provide timer for linux.
AFAIK, the dt of SBI comes from the linux or the bootloader, and bootloader
may load the linux dt and pass it to the SBI. I think it is better to add
the clint node.

In addition, please separate the peripheral node to a different file, which
can be reused by both the CV1800 series and CV1810 series.

Thanks,
Inochi

>
>Add initial device tree for the CV1800B RISC-V SoC by SOPHGO.
>
>Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>---
> arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 117 ++++++++++++++++++++++++
> 1 file changed, 117 insertions(+)
> create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>
>diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>new file mode 100644
>index 000000000000..8829bebaa017
>--- /dev/null
>+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
>@@ -0,0 +1,117 @@
>+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>+/*
>+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
>+ */
>+
>+#include <dt-bindings/interrupt-controller/irq.h>
>+
>+/ {
>+	compatible = "sophgo,cv1800b";
>+	#address-cells = <1>;
>+	#size-cells = <1>;
>+
>+	cpus: cpus {
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+		timebase-frequency = <25000000>;
>+
>+		cpu0: cpu@0 {
>+			compatible = "thead,c906", "riscv";
>+			device_type = "cpu";
>+			reg = <0>;
>+			d-cache-block-size = <64>;
>+			d-cache-sets = <512>;
>+			d-cache-size = <65536>;
>+			i-cache-block-size = <64>;
>+			i-cache-sets = <128>;
>+			i-cache-size = <32768>;
>+			mmu-type = "riscv,sv39";
>+			riscv,isa = "rv64imafdc";
>+			riscv,isa-base = "rv64i";
>+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
>+					       "zifencei", "zihpm";
>+
>+			cpu0_intc: interrupt-controller {
>+				compatible = "riscv,cpu-intc";
>+				interrupt-controller;
>+				#address-cells = <0>;
>+				#interrupt-cells = <1>;
>+			};
>+		};
>+	};
>+
>+	osc: oscillator {
>+		compatible = "fixed-clock";
>+		clock-output-names = "osc_25m";
>+		#clock-cells = <0>;
>+	};
>+
>+	soc {
>+		compatible = "simple-bus";
>+		interrupt-parent = <&plic>;
>+		#address-cells = <1>;
>+		#size-cells = <1>;
>+		dma-noncoherent;
>+		ranges;
>+
>+		uart0: serial@04140000 {
>+			compatible = "snps,dw-apb-uart";
>+			reg = <0x04140000 0x100>;
>+			interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
>+			clocks = <&osc>;
>+			reg-shift = <2>;
>+			reg-io-width = <4>;
>+			status = "disabled";
>+		};
>+
>+		uart1: serial@04150000 {
>+			compatible = "snps,dw-apb-uart";
>+			reg = <0x04150000 0x100>;
>+			interrupts = <45 IRQ_TYPE_LEVEL_HIGH>;
>+			clocks = <&osc>;
>+			reg-shift = <2>;
>+			reg-io-width = <4>;
>+			status = "disabled";
>+		};
>+
>+		uart2: serial@04160000 {
>+			compatible = "snps,dw-apb-uart";
>+			reg = <0x04160000 0x100>;
>+			interrupts = <46 IRQ_TYPE_LEVEL_HIGH>;
>+			clocks = <&osc>;
>+			reg-shift = <2>;
>+			reg-io-width = <4>;
>+			status = "disabled";
>+		};
>+
>+		uart3: serial@04170000 {
>+			compatible = "snps,dw-apb-uart";
>+			reg = <0x04170000 0x100>;
>+			interrupts = <47 IRQ_TYPE_LEVEL_HIGH>;
>+			clocks = <&osc>;
>+			reg-shift = <2>;
>+			reg-io-width = <4>;
>+			status = "disabled";
>+		};
>+
>+		uart4: serial@041c0000 {
>+			compatible = "snps,dw-apb-uart";
>+			reg = <0x041c0000 0x100>;
>+			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
>+			clocks = <&osc>;
>+			reg-shift = <2>;
>+			reg-io-width = <4>;
>+			status = "disabled";
>+		};
>+
>+		plic: interrupt-controller@70000000 {
>+			compatible = "sophgo,cv1800b-plic", "thead,c900-plic";
>+			reg = <0x70000000 0x4000000>;
>+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
>+			interrupt-controller;
>+			#address-cells = <0>;
>+			#interrupt-cells = <2>;
>+			riscv,ndev = <101>;
>+		};
>+	};
>+};
>--
>2.40.1
>
>
