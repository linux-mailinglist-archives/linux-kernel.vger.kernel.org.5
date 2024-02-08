Return-Path: <linux-kernel+bounces-57666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E1684DBFB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144911C25BDC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1E96F515;
	Thu,  8 Feb 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UCQtkUNf"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2063.outbound.protection.outlook.com [40.92.44.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85C6F096;
	Thu,  8 Feb 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382164; cv=fail; b=ftGhgov+ztJMLg54NZ8rnII2Zz4wLlWVgEjE4TRGLH/YSldwTQHLfWwaSYyqq/we6inN7vyiz87DIB+j/wAgbNiwSgrYz+Ec2OPk4Ni5vfhLpqkdm4hthzrKgKLjvwwL5L5+Haql4xiqgust74sBarQMxZ13F+6Jt2iQKVv+Uiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382164; c=relaxed/simple;
	bh=Z7XGgLOJuNP65ehH1oFVhZkqAT+IpkbPfgGcssk6hGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jMevd+OFZuaAQ96C1S6OmIji3aCF6cvknp4izs7dOVNM80t4EDXmkIF+m6TuO6U1JZH/2VXy+shZE1dFFSioSkXDVLllSBwOX/ohDEKVOIlbKDKeK1QuakZ/Yr8R9tIboSoQ11mdnFN1yVcLMZogEU5rY5w+g/GN6th7SqPmz4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UCQtkUNf; arc=fail smtp.client-ip=40.92.44.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRxSlsgv9spwvDusAyLV5JUURt9KfoqTN0xdFL7eTBThgHHjlwn6GLzCAfACVqk7MTSv4v3K0NqAc7BKto5EN/emxkvc99K3yQgQSQhz99buGuurAPc2cTH8aBeL+Yi1l1AubP7fAcrdsDlNtXLX6JvhCF5jqBFsGVKN0fRGxdkgKDnLz5Xz6jU4oC+lvV0LZpwxNj/RpnqnWvvyezW5jqOhKiF1cvjHRyJ3QcS8aD7AckW13pvPaYlKUclDq5MrJwQ7Q0TcLegzslEVaow8XTABJ1T2qes6kDrEDzwFvf2E/aWTBN6ABBHnKCMcxcmkXVbteEfgAn+2TY5CaGgDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1su204SXBy/Z/LfGL9/6NDhY5tjm8dLC01zK9wca/o=;
 b=WkwvsNSZWIbI0eT+NPqNiTThwABYecJg2T1arwfKsytPuaaSm8IAoW4UR18edLg8IbGIP4cL9DET7gzbBcBADsfn7eiJorjuGsGHF9e9+05zirsyiFtvP/yMGbmBM0jcmlS1xzD35tIQY00b79I8iWgV0ZiOoUGVFSFvpZtqSRic61of/b2iLtBt5vQatleO3W+86uYumGTyPLjdlyVInydqf2WS307w20+i1nZAfxaN68FD2BSGcGi532dCn5pLdUuh4SvSK0S8+oZPRt3ocjWUzBAzYYorM9gVFENfxm2UhUEqy0aHgPqvXFIn+mynPNN0q9KMSeykXcfn983mDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1su204SXBy/Z/LfGL9/6NDhY5tjm8dLC01zK9wca/o=;
 b=UCQtkUNfILvWUS6sjMGPPOQoYvCXJ23djneOdSHvQWwphz07syi1K8x6UA8nNh96OGI7Fxdgnug8IbRLYLxb/93liXi4GJ+DoLm2shqabUZPI+pFUnhoTIrAe8LPOneAMwXZM4EvC0H/QQ8hh6JKRZ4niX8JMJ1vOwTw4rv4EzTUVKpr0xq0T34vhfKGPnNwrHjebmtZH7xJ5rhd4kQiUmPk19Wf7o2NvDtAuko82d9ETtygyelVQPawDRfDxNrTZEBeGlAWO1eJ66AxGyemLRZkbVaPuuSg6ANurAIUXYI/KuBKKZj3TaCZsseEkipNJ95+JdcVBF0WnrfWwWY+mw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5985.namprd20.prod.outlook.com (2603:10b6:930:73::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 08:49:20 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 08:49:20 +0000
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
Subject: [PATCH v7 5/8] clk: sophgo: Add clock support for CV1810 SoC
Date: Thu,  8 Feb 2024 16:48:53 +0800
Message-ID:
 <IA1PR20MB4953455C71A389EB530689F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [C42X7Ibad/jEH5WjMOvQXJKh445C2Ye88owzu4pPz4U1SaDcV6jAhsPObXubUp8F]
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240208084858.1113628-5-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: de834233-420a-4718-88eb-08dc2882d736
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fnqXpmb42lv4G88A1bsZC/tJGKS7wozwr5IEewH82KoA/J/GFuCIcgR1Kq0hB9xWaFOzWB8JWlmSoEJnJngSSfsVOyD1I4RB37fbCQ4toocOBK8H3QxvZjp2Le8SkypQX/f4/WLGiFkNtKLKseetUB+J8kALehyFE7uo5uZoZJFTSoY/DBwcw3SxDdwRgS/228Whl/o7kHZOAhzl4cJKCw/v4upWNFJPPATunnJwsLn4cX3ytUs4Jru1cPtdKKrbBdCDjCPHGPAHBcEpBzO1Itxf1fBE2LufzCzM7OYhtSA1kSBc1neSnXjHyAf9lVm12Ga9uoy9LJ2tWv88BoBYHyDhRPFwytA6endVVM0V6Cm+rASt3MDov7zfdQapTHbh4iRHhUqe1NkKgH0QTtdMRn6P3rBiaY7d2WtcfBwf9FFLcChf73415FsBMQ5YnHWqmA/n77QUMnq1FE62QkWKHOf6cDoAY89wxjm06vAFRkXDjNIkGd3NwGL59AVkaUGUsUkN3qfSflivqeyh5IBaHfKF0ko6RpNxmKm+dxA4nUL8u4Gou2gJ17TD4M/1jMfjAXUo6ffRF/AklsvsX5+So6MMpuAmvFFKM6hWdQNZ0dcffHtkmaM4S6SUTDdQjHzW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Mq5Zur+/RyKmwU7F3VTVlmdI6vYkrWCbGUiygbPGtLKYzF7+Hs7Ua72Ktsq?=
 =?us-ascii?Q?mFP1sktHIpQLIdz8yRS5R5F7Po+Vh3zflljIfyShQ2UIF7yr/W60rrxjjK02?=
 =?us-ascii?Q?vKIRfjh58NpQwPjVKwSTs3bvr7cbh7SrBMrL+SZrYUu/08gCPkxUcw5UWAXi?=
 =?us-ascii?Q?Ey0A7fn34JmEUwQFkke2xY3R256M8dJopQHohLEKIFfc+gjesVNBNuyvrSH8?=
 =?us-ascii?Q?s2rfqXdFs9MC2QaaqLHKNr0GCR5SHKWt8RHRQ/3FKGWmVY7fQ+3lrp/UbbF8?=
 =?us-ascii?Q?diXXP5pOgd1nz6bc3n6xcKFKQjKJzhtcRurUnrrpqOT/Isu9iEj2kKtB4FPY?=
 =?us-ascii?Q?Lofw04DgI8sqL8EgNwDr9exqPrBy2Y5U7EaVv9+25HFJcmDker0Y8pNK4GZK?=
 =?us-ascii?Q?YY/TkMheOHOtAzN9RrmHpSWgs6laxVekywVTz80jJx0YeYUZsf8KPRZLGHYa?=
 =?us-ascii?Q?006RClJzpZ5HB7AHJagbDq+2aO39OYTEKY7cl/SdxIBXjAwJz0X9qcFmz/SI?=
 =?us-ascii?Q?VUsJVQjKpRWv7o7g8MJOohnjEskLVMvTOAT7+4pZhr/gfmrrqX2VB+888QOE?=
 =?us-ascii?Q?4LG3DEBh5pxZX8LE8Uf0F8yNqgVww5/c0azuy0A6k3kDzwaSntV4t7E4QZZf?=
 =?us-ascii?Q?evH2YKQUrRuaG1G12vVFSR4cwgncwRYmBVbfbwO+swGPoZGnFqv+qKLUdNfL?=
 =?us-ascii?Q?q/gnl0u0brQ2ZY6Mx4Bz3TaXsmC8/6KYKD2z+Ngni0mjM/iOHyWmQxU6UG+6?=
 =?us-ascii?Q?xSSRLX9oeiiHN7+5cMnJ7cZ7UiH+SX8bnbhAy8W2/Jl0gk057T/8Y9CuJlT4?=
 =?us-ascii?Q?aErecIG6xOxuL4Rl0436gvKXGNbawX5f8Yf26XrwsvbrR806+MGw7tPpscls?=
 =?us-ascii?Q?zcg/6JRqweiD/mKbNuLLpD1rwEXzZiXPX8KvCwOdE83lgnD7mgEq8m2pecYf?=
 =?us-ascii?Q?uSSZ0WNy2XI/uOQfisbvbKVSd9XQo0XIH43sqpvSZ+FHNvE+F3FKJ1YkYwWm?=
 =?us-ascii?Q?RuaFBUo12q2mVNIZbTwNhkkH2Ox+VgV/9aVS+JOlO2wiHpafMp/+IL91jTJm?=
 =?us-ascii?Q?TilHzTUaS1gVJRpuIo4rnPE9x16qATGFuByXO9NmXAlvEROKZWq1JFS5pVSZ?=
 =?us-ascii?Q?l0hniFvXzIClSrqWS7Q2OdC+2JYj2BbXIhub4TiZ+gAzTQimsctKAt77nTK4?=
 =?us-ascii?Q?HnPEG2k9cbmrKdLs9XefOkg5GQnDo4+vftLZb6gIdP1FSwivtThMaOLZTfYk?=
 =?us-ascii?Q?j78M9tYvoYF//xQT6hvkT1hz5QSEzZ1S8dAsPy+shA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de834233-420a-4718-88eb-08dc2882d736
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 08:49:20.2976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5985

Add clock definition and init code for CV1810 SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8df248a19ca70837a3/duo/datasheet/CV180X-Clock-v1.xlsx
---
 drivers/clk/sophgo/clk-cv1800.c | 191 ++++++++++++++++++++++++++++++++
 drivers/clk/sophgo/clk-cv1800.h |   1 +
 2 files changed, 192 insertions(+)

diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1800.c
index cc820ea9926f..6ee8ef56570c 100644
--- a/drivers/clk/sophgo/clk-cv1800.c
+++ b/drivers/clk/sophgo/clk-cv1800.c
@@ -664,6 +664,11 @@ static CV1800_BYPASS_MUX(clk_src_vip_sys_1, clk_vip_sys_parents,
 			 REG_DIV_CLK_SRC_VIP_SYS_1, 8, 2,
 			 REG_CLK_BYP_0, 24,
 			 0);
+static CV1800_BYPASS_DIV(clk_disp_src_vip, clk_disp_vip_parents,
+			 REG_CLK_EN_2, 7,
+			 REG_DIV_CLK_DISP_SRC_VIP, 16, 4, 8, CV1800_DIV_FLAG,
+			 REG_CLK_BYP_0, 25,
+			 0);
 static CV1800_BYPASS_MUX(clk_src_vip_sys_2, clk_vip_sys_parents,
 			 REG_CLK_EN_3, 29,
 			 REG_DIV_CLK_SRC_VIP_SYS_2, 16, 4, 2, CV1800_DIV_FLAG,
@@ -1247,6 +1252,191 @@ static const struct cv1800_clk_desc cv1800_desc = {
 	.pre_init	= cv1800_pre_init,
 };

+static struct clk_hw_onecell_data cv1810_hw_clks = {
+	.num	= CV1810_CLK_MAX,
+	.hws	= {
+		[CLK_MPLL]		= &clk_mpll.common.hw,
+		[CLK_TPLL]		= &clk_tpll.common.hw,
+		[CLK_FPLL]		= &clk_fpll.common.hw,
+		[CLK_MIPIMPLL]		= &clk_mipimpll.common.hw,
+		[CLK_A0PLL]		= &clk_a0pll.common.hw,
+		[CLK_DISPPLL]		= &clk_disppll.common.hw,
+		[CLK_CAM0PLL]		= &clk_cam0pll.common.hw,
+		[CLK_CAM1PLL]		= &clk_cam1pll.common.hw,
+
+		[CLK_MIPIMPLL_D3]	= &clk_mipimpll_d3.common.hw,
+		[CLK_CAM0PLL_D2]	= &clk_cam0pll_d2.common.hw,
+		[CLK_CAM0PLL_D3]	= &clk_cam0pll_d3.common.hw,
+
+		[CLK_TPU]		= &clk_tpu.mux.common.hw,
+		[CLK_TPU_FAB]		= &clk_tpu_fab.common.hw,
+		[CLK_AHB_ROM]		= &clk_ahb_rom.common.hw,
+		[CLK_DDR_AXI_REG]	= &clk_ddr_axi_reg.common.hw,
+		[CLK_RTC_25M]		= &clk_rtc_25m.common.hw,
+		[CLK_SRC_RTC_SYS_0]	= &clk_src_rtc_sys_0.div.common.hw,
+		[CLK_TEMPSEN]		= &clk_tempsen.common.hw,
+		[CLK_SARADC]		= &clk_saradc.common.hw,
+		[CLK_EFUSE]		= &clk_efuse.common.hw,
+		[CLK_APB_EFUSE]		= &clk_apb_efuse.common.hw,
+		[CLK_DEBUG]		= &clk_debug.common.hw,
+		[CLK_AP_DEBUG]		= &clk_ap_debug.div.common.hw,
+		[CLK_XTAL_MISC]		= &clk_xtal_misc.common.hw,
+		[CLK_AXI4_EMMC]		= &clk_axi4_emmc.common.hw,
+		[CLK_EMMC]		= &clk_emmc.mux.common.hw,
+		[CLK_EMMC_100K]		= &clk_emmc_100k.common.hw,
+		[CLK_AXI4_SD0]		= &clk_axi4_sd0.common.hw,
+		[CLK_SD0]		= &clk_sd0.mux.common.hw,
+		[CLK_SD0_100K]		= &clk_sd0_100k.common.hw,
+		[CLK_AXI4_SD1]		= &clk_axi4_sd1.common.hw,
+		[CLK_SD1]		= &clk_sd1.mux.common.hw,
+		[CLK_SD1_100K]		= &clk_sd1_100k.common.hw,
+		[CLK_SPI_NAND]		= &clk_spi_nand.mux.common.hw,
+		[CLK_ETH0_500M]		= &clk_eth0_500m.div.common.hw,
+		[CLK_AXI4_ETH0]		= &clk_axi4_eth0.common.hw,
+		[CLK_ETH1_500M]		= &clk_eth1_500m.div.common.hw,
+		[CLK_AXI4_ETH1]		= &clk_axi4_eth1.common.hw,
+		[CLK_APB_GPIO]		= &clk_apb_gpio.common.hw,
+		[CLK_APB_GPIO_INTR]	= &clk_apb_gpio_intr.common.hw,
+		[CLK_GPIO_DB]		= &clk_gpio_db.common.hw,
+		[CLK_AHB_SF]		= &clk_ahb_sf.common.hw,
+		[CLK_AHB_SF1]		= &clk_ahb_sf1.common.hw,
+		[CLK_A24M]		= &clk_a24m.common.hw,
+		[CLK_AUDSRC]		= &clk_audsrc.mux.common.hw,
+		[CLK_APB_AUDSRC]	= &clk_apb_audsrc.common.hw,
+		[CLK_SDMA_AXI]		= &clk_sdma_axi.common.hw,
+		[CLK_SDMA_AUD0]		= &clk_sdma_aud0.mux.common.hw,
+		[CLK_SDMA_AUD1]		= &clk_sdma_aud1.mux.common.hw,
+		[CLK_SDMA_AUD2]		= &clk_sdma_aud2.mux.common.hw,
+		[CLK_SDMA_AUD3]		= &clk_sdma_aud3.mux.common.hw,
+		[CLK_I2C]		= &clk_i2c.div.common.hw,
+		[CLK_APB_I2C]		= &clk_apb_i2c.common.hw,
+		[CLK_APB_I2C0]		= &clk_apb_i2c0.common.hw,
+		[CLK_APB_I2C1]		= &clk_apb_i2c1.common.hw,
+		[CLK_APB_I2C2]		= &clk_apb_i2c2.common.hw,
+		[CLK_APB_I2C3]		= &clk_apb_i2c3.common.hw,
+		[CLK_APB_I2C4]		= &clk_apb_i2c4.common.hw,
+		[CLK_APB_WDT]		= &clk_apb_wdt.common.hw,
+		[CLK_PWM_SRC]		= &clk_pwm_src.mux.common.hw,
+		[CLK_PWM]		= &clk_pwm.common.hw,
+		[CLK_SPI]		= &clk_spi.div.common.hw,
+		[CLK_APB_SPI0]		= &clk_apb_spi0.common.hw,
+		[CLK_APB_SPI1]		= &clk_apb_spi1.common.hw,
+		[CLK_APB_SPI2]		= &clk_apb_spi2.common.hw,
+		[CLK_APB_SPI3]		= &clk_apb_spi3.common.hw,
+		[CLK_1M]		= &clk_1m.common.hw,
+		[CLK_CAM0_200]		= &clk_cam0_200.mux.common.hw,
+		[CLK_PM]		= &clk_pm.common.hw,
+		[CLK_TIMER0]		= &clk_timer0.common.hw,
+		[CLK_TIMER1]		= &clk_timer1.common.hw,
+		[CLK_TIMER2]		= &clk_timer2.common.hw,
+		[CLK_TIMER3]		= &clk_timer3.common.hw,
+		[CLK_TIMER4]		= &clk_timer4.common.hw,
+		[CLK_TIMER5]		= &clk_timer5.common.hw,
+		[CLK_TIMER6]		= &clk_timer6.common.hw,
+		[CLK_TIMER7]		= &clk_timer7.common.hw,
+		[CLK_UART0]		= &clk_uart0.common.hw,
+		[CLK_APB_UART0]		= &clk_apb_uart0.common.hw,
+		[CLK_UART1]		= &clk_uart1.common.hw,
+		[CLK_APB_UART1]		= &clk_apb_uart1.common.hw,
+		[CLK_UART2]		= &clk_uart2.common.hw,
+		[CLK_APB_UART2]		= &clk_apb_uart2.common.hw,
+		[CLK_UART3]		= &clk_uart3.common.hw,
+		[CLK_APB_UART3]		= &clk_apb_uart3.common.hw,
+		[CLK_UART4]		= &clk_uart4.common.hw,
+		[CLK_APB_UART4]		= &clk_apb_uart4.common.hw,
+		[CLK_APB_I2S0]		= &clk_apb_i2s0.common.hw,
+		[CLK_APB_I2S1]		= &clk_apb_i2s1.common.hw,
+		[CLK_APB_I2S2]		= &clk_apb_i2s2.common.hw,
+		[CLK_APB_I2S3]		= &clk_apb_i2s3.common.hw,
+		[CLK_AXI4_USB]		= &clk_axi4_usb.common.hw,
+		[CLK_APB_USB]		= &clk_apb_usb.common.hw,
+		[CLK_USB_125M]		= &clk_usb_125m.div.common.hw,
+		[CLK_USB_33K]		= &clk_usb_33k.common.hw,
+		[CLK_USB_12M]		= &clk_usb_12m.div.common.hw,
+		[CLK_AXI4]		= &clk_axi4.mux.common.hw,
+		[CLK_AXI6]		= &clk_axi6.div.common.hw,
+		[CLK_DSI_ESC]		= &clk_dsi_esc.div.common.hw,
+		[CLK_AXI_VIP]		= &clk_axi_vip.mux.common.hw,
+		[CLK_SRC_VIP_SYS_0]	= &clk_src_vip_sys_0.mux.common.hw,
+		[CLK_SRC_VIP_SYS_1]	= &clk_src_vip_sys_1.mux.common.hw,
+		[CLK_SRC_VIP_SYS_2]	= &clk_src_vip_sys_2.mux.common.hw,
+		[CLK_SRC_VIP_SYS_3]	= &clk_src_vip_sys_3.mux.common.hw,
+		[CLK_SRC_VIP_SYS_4]	= &clk_src_vip_sys_4.mux.common.hw,
+		[CLK_CSI_BE_VIP]	= &clk_csi_be_vip.common.hw,
+		[CLK_CSI_MAC0_VIP]	= &clk_csi_mac0_vip.common.hw,
+		[CLK_CSI_MAC1_VIP]	= &clk_csi_mac1_vip.common.hw,
+		[CLK_CSI_MAC2_VIP]	= &clk_csi_mac2_vip.common.hw,
+		[CLK_CSI0_RX_VIP]	= &clk_csi0_rx_vip.common.hw,
+		[CLK_CSI1_RX_VIP]	= &clk_csi1_rx_vip.common.hw,
+		[CLK_ISP_TOP_VIP]	= &clk_isp_top_vip.common.hw,
+		[CLK_IMG_D_VIP]		= &clk_img_d_vip.common.hw,
+		[CLK_IMG_V_VIP]		= &clk_img_v_vip.common.hw,
+		[CLK_SC_TOP_VIP]	= &clk_sc_top_vip.common.hw,
+		[CLK_SC_D_VIP]		= &clk_sc_d_vip.common.hw,
+		[CLK_SC_V1_VIP]		= &clk_sc_v1_vip.common.hw,
+		[CLK_SC_V2_VIP]		= &clk_sc_v2_vip.common.hw,
+		[CLK_SC_V3_VIP]		= &clk_sc_v3_vip.common.hw,
+		[CLK_DWA_VIP]		= &clk_dwa_vip.common.hw,
+		[CLK_BT_VIP]		= &clk_bt_vip.common.hw,
+		[CLK_DISP_VIP]		= &clk_disp_vip.common.hw,
+		[CLK_DSI_MAC_VIP]	= &clk_dsi_mac_vip.common.hw,
+		[CLK_LVDS0_VIP]		= &clk_lvds0_vip.common.hw,
+		[CLK_LVDS1_VIP]		= &clk_lvds1_vip.common.hw,
+		[CLK_PAD_VI_VIP]	= &clk_pad_vi_vip.common.hw,
+		[CLK_PAD_VI1_VIP]	= &clk_pad_vi1_vip.common.hw,
+		[CLK_PAD_VI2_VIP]	= &clk_pad_vi2_vip.common.hw,
+		[CLK_CFG_REG_VIP]	= &clk_cfg_reg_vip.common.hw,
+		[CLK_VIP_IP0]		= &clk_vip_ip0.common.hw,
+		[CLK_VIP_IP1]		= &clk_vip_ip1.common.hw,
+		[CLK_VIP_IP2]		= &clk_vip_ip2.common.hw,
+		[CLK_VIP_IP3]		= &clk_vip_ip3.common.hw,
+		[CLK_IVE_VIP]		= &clk_ive_vip.common.hw,
+		[CLK_RAW_VIP]		= &clk_raw_vip.common.hw,
+		[CLK_OSDC_VIP]		= &clk_osdc_vip.common.hw,
+		[CLK_CAM0_VIP]		= &clk_cam0_vip.common.hw,
+		[CLK_AXI_VIDEO_CODEC]	= &clk_axi_video_codec.mux.common.hw,
+		[CLK_VC_SRC0]		= &clk_vc_src0.mux.common.hw,
+		[CLK_VC_SRC1]		= &clk_vc_src1.div.common.hw,
+		[CLK_VC_SRC2]		= &clk_vc_src2.div.common.hw,
+		[CLK_H264C]		= &clk_h264c.common.hw,
+		[CLK_APB_H264C]		= &clk_apb_h264c.common.hw,
+		[CLK_H265C]		= &clk_h265c.common.hw,
+		[CLK_APB_H265C]		= &clk_apb_h265c.common.hw,
+		[CLK_JPEG]		= &clk_jpeg.common.hw,
+		[CLK_APB_JPEG]		= &clk_apb_jpeg.common.hw,
+		[CLK_CAM0]		= &clk_cam0.common.hw,
+		[CLK_CAM1]		= &clk_cam1.common.hw,
+		[CLK_WGN]		= &clk_wgn.common.hw,
+		[CLK_WGN0]		= &clk_wgn0.common.hw,
+		[CLK_WGN1]		= &clk_wgn1.common.hw,
+		[CLK_WGN2]		= &clk_wgn2.common.hw,
+		[CLK_KEYSCAN]		= &clk_keyscan.common.hw,
+		[CLK_CFG_REG_VC]	= &clk_cfg_reg_vc.common.hw,
+		[CLK_C906_0]		= &clk_c906_0.common.hw,
+		[CLK_C906_1]		= &clk_c906_1.common.hw,
+		[CLK_A53]		= &clk_a53.common.hw,
+		[CLK_CPU_AXI0]		= &clk_cpu_axi0.div.common.hw,
+		[CLK_CPU_GIC]		= &clk_cpu_gic.div.common.hw,
+		[CLK_XTAL_AP]		= &clk_xtal_ap.common.hw,
+		[CLK_DISP_SRC_VIP]	= &clk_disp_src_vip.div.common.hw,
+	},
+};
+
+static int cv1810_pre_init(struct device *dev, void __iomem *base,
+			   struct cv1800_clk_ctrl *ctrl,
+			   const struct cv1800_clk_desc *desc)
+{
+	cv18xx_clk_disable_a53(base);
+	cv18xx_clk_disable_auto_pd(base);
+
+	return 0;
+}
+
+static const struct cv1800_clk_desc cv1810_desc = {
+	.clks_data	= &cv1810_hw_clks,
+	.pre_init	= cv1810_pre_init,
+};
+
 static int cv1800_clk_init_ctrl(struct device *dev, void __iomem *reg,
 				struct cv1800_clk_ctrl *ctrl,
 				const struct cv1800_clk_desc *desc)
@@ -1319,6 +1509,7 @@ static int cv1800_clk_probe(struct platform_device *pdev)

 static const struct of_device_id cv1800_clk_ids[] = {
 	{ .compatible = "sophgo,cv1800-clk", .data = &cv1800_desc },
+	{ .compatible = "sophgo,cv1810-clk", .data = &cv1810_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cv1800_clk_ids);
diff --git a/drivers/clk/sophgo/clk-cv1800.h b/drivers/clk/sophgo/clk-cv1800.h
index 1b9c04b5ac3a..1e7107b5d05e 100644
--- a/drivers/clk/sophgo/clk-cv1800.h
+++ b/drivers/clk/sophgo/clk-cv1800.h
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/sophgo,cv1800.h>

 #define CV1800_CLK_MAX			(CLK_XTAL_AP + 1)
+#define CV1810_CLK_MAX			(CLK_DISP_SRC_VIP + 1)

 #define REG_PLL_G2_CTRL			0x800
 #define REG_PLL_G2_STATUS		0x804
--
2.43.0


