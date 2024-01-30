Return-Path: <linux-kernel+bounces-44129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39420841DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E543128FA87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293555785;
	Tue, 30 Jan 2024 08:25:31 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2056.outbound.protection.partner.outlook.cn [139.219.17.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992954F93;
	Tue, 30 Jan 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603130; cv=fail; b=XzuKfyKo3Pzu9MOY+z+sJY/4oOETQp7lK1d1yiFCAqNTSmdYHR5g4XOWoamblOXPpGXyNPGv7Y9AlnhG+TVv4kQdky8Aln7cTzWO+dE3cnwXoqvN7K1wT19LuFu/N59ZQo3JKTI15C8ACxOgnht/nGvEIhmWSJgcTNVX9bcGiVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603130; c=relaxed/simple;
	bh=ocYT44f2kjWjPUO4TgklcRyUQr3Fr+BJxNmcVg0Jf+g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Vx+OotEnEv5gdkHE2gLOuyz+YlQX7cfL2qA8PBtwMQF7Hxham8ZtDZoIsPTvCk2JpevOqQoX4RBwmS8I4nM94jUEJZ0US7YqOKJB4OdwKIZUFo6WHSE+E6iLSYbu53vG/UV9GWx5X/nARTKhkKIRw/r6dMUCVaVsW9z7LNRsN1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIljnRQT0qpZMqNUjc2y1iReUIqzNF20QGA8MSYwTAQQQ3i2tHIbXKfMwV9OcNYQj+I/i6ttx3rwNu0/pw9+/UOM7SnofxAa6X/al+n5/jv3g3v0l9nwCTbOfS87yh2qI+GNMPZcx3OoiX5f535TnrF+A1tD/XFRJ2BJn9UrtQHxxMFkcRU+TPDYnGDRP6nCtdoqFb4Jgg2gmtiU9OfZURCFP3qRB/ReJxxHGTGVuNz0Cm5hzaRq5ghHLeMLABta1Px6BZy0MBGUBfC9UmNtqJGRt/cNWvaQseczfNPqxQx/WoTb2/hoSMc5+kLsMQQh8ncExMMAHtGnKCZYUzIB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qNBV9xKj5tqOUkFNZLlgTTg9UwitWr14GOqQWCkpJQ=;
 b=QvVmLtdJSe7sF29g3YNVnBhz8OlIJKxlms+po6wuk5BzpulL8JfMfgCMhKCgu0c/pzGiWtIZ2pAFW7BnEw0Ex4izMWNtWOH9xrjXf/5hkhSSMRPTkor89OUDCig2/3Qew8/kgFGnaUvtUjrBWFVDBMmKvw3ZxH3DwnU0iBfB+TV/j6gF4HgW8uck5qxbVuFu+tFAiQY+5BKFZxkLoZ2fkTwW+hOJYoqKz5KgMn3jBW4MaKbfJ/ZrQf4tXi/6AqsUtjLy1zOrxSplNVq6igk+K1Yl/ssENf89wM9KlcPfpT7R7wAbH0F4M7OqeH3r0rDG3XveTD4e/FL/s8qPtwQDcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0512.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 08:25:17 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::148c:e1dd:302a:196b]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::148c:e1dd:302a:196b%6])
 with mapi id 15.20.7228.022; Tue, 30 Jan 2024 08:25:17 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [v2] riscv: dts: starfive: jh7110: Add camera subsystem nodes
Date: Tue, 30 Jan 2024 00:25:09 -0800
Message-Id: <20240130082509.217683-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0512:EE_
X-MS-Office365-Filtering-Correlation-Id: f35434a7-91fd-4901-9a10-08dc216cfd62
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T/iWT2frfOSIFY5lkufR1xBaM0J3DpA6eex1muYzysEBKXfvUO5he9kTb+d3Gxevw87WrDkfykdPV7owrfwYdh9b1Ly08+9WdwqfsLchI8DGtJUHCoNrKaI/OF8VDsa3BK6H/ovamwxbdoxXd3AitRlbQl9OkUtsaTHNpt2HLCM0/Fti4nmHrRxJx1A/dhqBtj/83TIkUgn4W4l/4PqoXIfTTpBuyVRh16Hj5cvp87O0uE4iPxCO5Qac/diC/l/gPvE/HzfN3WBgCL+f85zJmg67G7m9Uc0VtCwAkjdAXg6J3tFzefns4uGIhoZZCYk6GDJTnTxOOsMRdieYG3tqOSz23qKpkjXtS1SWeWWQEWkXLK38j2AV7aG0YSpyYgr9RqS5cgE3cudoXncK0t0IZRcz97oeo3ydjtbROcPBRyDcgArhxerXsZv43dQUWwsiUV3ETB91ASEniOs9MyPKfv9oIAaVlKBjRf3QqArkTSkuFEQFTGCHJ3jdQOIT5PA5QM12jZtx/8DSqQ2+cfV5qxWR52isCSssOVV94849ZZdMFPm7nyU/Jmq8emMCJBCm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(396003)(366004)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38350700005)(38100700002)(41320700001)(41300700001)(40160700002)(7416002)(2616005)(44832011)(83380400001)(5660300002)(1076003)(2906002)(26005)(508600001)(110136005)(66946007)(54906003)(66556008)(66476007)(4326008)(52116002)(6666004)(8936002)(8676002)(36756003)(40180700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KdrPvJTqUCVtb5rX8LDOTjhZqsTZ06hYfom0ZvH/2rQbljJEYpX4DauM0x9r?=
 =?us-ascii?Q?4KlIZrH/D3j/PrufHyWbnPyEda2npRlMMIXjxLfX0sRTb4nBiJL9KoCzyqAl?=
 =?us-ascii?Q?LImTO98eopyJ364BHlF/dlYMGGZrJT5Cr9SNKaVK6x3vbY53/qXZvpbfkOd1?=
 =?us-ascii?Q?3m2gy5OWm3I2hDikgz8TO8g47d+radDSkNqqEyvRpbvSmYXtcL/A7/51KBoW?=
 =?us-ascii?Q?rlxi7D7FTtWvBEQmLoenmMfjRXRblxUT5/24v4likH2NZKsE/7aeDK0rTnig?=
 =?us-ascii?Q?CjIhx0PaoFrNaRt+dlaLRRulMdgNUb9Idyup38qYiHWRjMUtWtEK44A4EOyi?=
 =?us-ascii?Q?w6jsanjf8Li/brk442U0XqIwsHSb+JEwKybED1MhWhNt30UCbcFPyycsdCb8?=
 =?us-ascii?Q?eqLd+8Mmv4HQTE6gZj7+pRhKE7LREc7e+7RopyEm9dLE7xjK4Z9LR77EN0iA?=
 =?us-ascii?Q?1k/7sMHsY7kUKueoNsho89sO5tEOsD0sfXmCYrjZ4ooih+iIpOFLbdP2/CrT?=
 =?us-ascii?Q?AILtGRJkQXJe+1Y/WnZKE1zvKFXitsWcsugQwgGoDwlqQZ/zRr8znokc10j9?=
 =?us-ascii?Q?EfBUq3SJnO8cd+Jt7sk0kCxInB8jxOOnro2rYYxmDWDWBx1WYjtTwp66oAiY?=
 =?us-ascii?Q?v8GBwu2/OI+SLdxnVlinA7DFP1jQv5KEJD9FkU2cnkwV6I1oDyYQTgP/Q+cr?=
 =?us-ascii?Q?jTYaXlgYBKP7McA7CpyjH8WxXCBGOyerszPrhru4fH2fUnWIucbwgvCaB+GX?=
 =?us-ascii?Q?ozu3CXCL8JQ+euf77CqVR9sXrDK/JIckqXwa4LDIdC4/atKBdP6aA0SEkXyu?=
 =?us-ascii?Q?Stib+ciz22qyCMaoipuG9P582BBHztZFBkaCMvG5JhB7Za4siufDhaBXDE6u?=
 =?us-ascii?Q?8LB31IJi7AdQHH8MkP3psJaWYuzvzQFAJDMNCzVhVmcyEOsFBN9B5M4MMwMb?=
 =?us-ascii?Q?ZX7IoJH0+9ztepa8JYDeSCBHhclNKZbMauh7MCvRKE/EwN6RriL/PbBAdL7N?=
 =?us-ascii?Q?9BDN1blpN6G/jSFkp81JUBMuVr1oYZ40MCbCPT6hES7fOqbwFqA4QNVDv68M?=
 =?us-ascii?Q?IsZ3lMbweXdoGXXALNYP8WkGbsIr9DjS/DyNowcbmVZiCr3ybwwKECYPipXu?=
 =?us-ascii?Q?/muRlVRFX4KviQrDs9zjBQR5Eu6A3Kb4QmSxCtUEfZA/eSHkKis1zCy4SVaO?=
 =?us-ascii?Q?JE1xNTcF7qsMo4AJhwOTgKD54+NUF35XoOfKupLHE8ZQQiC3frl5JB2xFdwl?=
 =?us-ascii?Q?Lddkme+FYKbQQgW2850Fmlx9zSQpZA0dZpDauAIGgQJJOQ8w+mgpDvy1Sszp?=
 =?us-ascii?Q?Y7ACk/CDV29e4x2wYp8LvsM48RaLjrqn/vnuT3PPJLYEAuvJcWp0YHWkLmtz?=
 =?us-ascii?Q?GW20oHc8ULjpHU/wJ/CKTe4C4+opv4oi7yO+uZI80zho+fzGifPjxX9Crg8I?=
 =?us-ascii?Q?VS7CApfq21Brq341DJEAfLPivimDLBho0rdpLolwcwf88p0jv6zf9Y2rN/Nv?=
 =?us-ascii?Q?PtROhNz5tRlAT4h7LqQJ51qW62WV5w0Oa8PATBgdKuli6NaRgsqxwkeABCBI?=
 =?us-ascii?Q?Xtx4e01oNOoxacCh+pk8eyy+at/qAqgRAsZbFPm39TXgSxJqBuerN9cO5bzj?=
 =?us-ascii?Q?C9qXlTqB9S0xUpZodO7j/3k=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35434a7-91fd-4901-9a10-08dc216cfd62
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 08:25:17.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1VPPKY8XmH6/a9nUjX8xo9KVAs9PmaZVwGKFoJyR8xbYDdYywNh0cbbZCYFxuboiSR6wgM+bmAl+NqvLX8SBmSNGsGgFQx9kOqWaQVkUggQ+rTr5CkC0IBEGVeCZhWM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0512

Add camera subsystem nodes for the StarFive JH7110 SoC. They contain the
imx219, dphy-rx, csi2rx, camss nodes.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 103 ++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  67 ++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index b89e9791efa7..e0027bb379ef 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -30,6 +30,37 @@ cpus {
 		timebase-frequency = <4000000>;
 	};
 
+	imx219_clk: imx219-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "imx219_clk";
+		clock-frequency = <24000000>;
+		#clock-cells = <0>;
+	};
+
+	imx219_vana_2v8: 2p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vana";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+
+	imx219_vdig_1v8: 1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdig";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+	};
+
+	imx219_vddl_1v2: 1p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vddl";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0x1 0x0>;
@@ -125,6 +156,59 @@ &tdm_ext {
 	clock-frequency = <49152000>;
 };
 
+&camss {
+	assigned-clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
+			  <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>;
+	assigned-clock-rates = <49500000>, <198000000>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+		};
+
+		port@1 {
+			reg = <1>;
+
+			camss_from_csi2rx: endpoint {
+				remote-endpoint = <&csi2rx_to_camss>;
+			};
+		};
+	};
+};
+
+&csi2rx {
+	assigned-clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>;
+	assigned-clock-rates = <297000000>;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			csi2rx_from_imx219: endpoint {
+				remote-endpoint = <&imx219_to_csi2rx>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			csi2rx_to_camss: endpoint {
+				remote-endpoint = <&camss_from_csi2rx>;
+			};
+		};
+	};
+};
+
 &gmac0 {
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
@@ -228,6 +312,25 @@ &i2c6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c6_pins>;
 	status = "okay";
+
+	imx219: sensor@10 {
+		compatible = "sony,imx219";
+		reg = <0x10>;
+		clocks = <&imx219_clk>;
+		reset-gpios = <&sysgpio 18 GPIO_ACTIVE_HIGH>;
+		VANA-supply = <&imx219_vana_2v8>;
+		VDIG-supply = <&imx219_vdig_1v8>;
+		VDDL-supply = <&imx219_vddl_1v2>;
+
+		port {
+			imx219_to_csi2rx: endpoint {
+				remote-endpoint = <&csi2rx_from_imx219>;
+				data-lanes = <1 2>;
+				clock-noncontinuous;
+				link-frequencies = /bits/ 64 <456000000>;
+			};
+		};
+	};
 };
 
 &i2srx {
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 45213cdf50dc..6ea1c3f5dded 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -1104,6 +1104,32 @@ pwrc: power-controller@17030000 {
 			#power-domain-cells = <1>;
 		};
 
+		csi2rx: csi@19800000 {
+			compatible = "starfive,jh7110-csi2rx", "cdns,csi2rx";
+			reg = <0x0 0x19800000 0x0 0x10000>;
+			clocks = <&ispcrg JH7110_ISPCLK_VIN_SYS>,
+				 <&ispcrg JH7110_ISPCLK_VIN_APB>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF0>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF1>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF2>,
+				 <&ispcrg JH7110_ISPCLK_VIN_PIXEL_IF3>;
+			clock-names = "sys_clk", "p_clk",
+				      "pixel_if0_clk", "pixel_if1_clk",
+				      "pixel_if2_clk", "pixel_if3_clk";
+			resets = <&ispcrg JH7110_ISPRST_VIN_SYS>,
+				 <&ispcrg JH7110_ISPRST_VIN_APB>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF0>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF1>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF2>,
+				 <&ispcrg JH7110_ISPRST_VIN_PIXEL_IF3>;
+			reset-names = "sys", "reg_bank",
+				      "pixel_if0", "pixel_if1",
+				      "pixel_if2", "pixel_if3";
+			phys = <&csi_phy>;
+			phy-names = "dphy";
+			status = "disabled";
+		};
+
 		ispcrg: clock-controller@19810000 {
 			compatible = "starfive,jh7110-ispcrg";
 			reg = <0x0 0x19810000 0x0 0x10000>;
@@ -1121,6 +1147,47 @@ ispcrg: clock-controller@19810000 {
 			power-domains = <&pwrc JH7110_PD_ISP>;
 		};
 
+		csi_phy: phy@19820000 {
+			compatible = "starfive,jh7110-dphy-rx";
+			reg = <0x0 0x19820000 0x0 0x10000>;
+			clocks = <&ispcrg JH7110_ISPCLK_M31DPHY_CFG_IN>,
+				 <&ispcrg JH7110_ISPCLK_M31DPHY_REF_IN>,
+				 <&ispcrg JH7110_ISPCLK_M31DPHY_TX_ESC_LAN0>;
+			clock-names = "cfg", "ref", "tx";
+			resets = <&ispcrg JH7110_ISPRST_M31DPHY_HW>,
+				 <&ispcrg JH7110_ISPRST_M31DPHY_B09_AON>;
+			power-domains = <&aon_syscon JH7110_AON_PD_DPHY_RX>;
+			#phy-cells = <0>;
+		};
+
+		camss: isp@19840000 {
+			compatible = "starfive,jh7110-camss";
+			reg = <0x0 0x19840000 0x0 0x10000>,
+			      <0x0 0x19870000 0x0 0x30000>;
+			reg-names = "syscon", "isp";
+			clocks = <&ispcrg JH7110_ISPCLK_DOM4_APB_FUNC>,
+				 <&ispcrg JH7110_ISPCLK_ISPV2_TOP_WRAPPER_C>,
+				 <&ispcrg JH7110_ISPCLK_DVP_INV>,
+				 <&ispcrg JH7110_ISPCLK_VIN_P_AXI_WR>,
+				 <&ispcrg JH7110_ISPCLK_MIPI_RX0_PXL>,
+				 <&syscrg JH7110_SYSCLK_ISP_TOP_CORE>,
+				 <&syscrg JH7110_SYSCLK_ISP_TOP_AXI>;
+			clock-names = "apb_func", "wrapper_clk_c", "dvp_inv",
+				      "axiwr", "mipi_rx0_pxl", "ispcore_2x",
+				      "isp_axi";
+			resets = <&ispcrg JH7110_ISPRST_ISPV2_TOP_WRAPPER_P>,
+				 <&ispcrg JH7110_ISPRST_ISPV2_TOP_WRAPPER_C>,
+				 <&ispcrg JH7110_ISPRST_VIN_P_AXI_RD>,
+				 <&ispcrg JH7110_ISPRST_VIN_P_AXI_WR>,
+				 <&syscrg JH7110_SYSRST_ISP_TOP>,
+				 <&syscrg JH7110_SYSRST_ISP_TOP_AXI>;
+			reset-names = "wrapper_p", "wrapper_c", "axird",
+				      "axiwr", "isp_top_n", "isp_top_axi";
+			power-domains = <&pwrc JH7110_PD_ISP>;
+			interrupts = <92>, <87>, <90>, <88>;
+			status = "disabled";
+		};
+
 		voutcrg: clock-controller@295c0000 {
 			compatible = "starfive,jh7110-voutcrg";
 			reg = <0x0 0x295c0000 0x0 0x10000>;
-- 
2.25.1


