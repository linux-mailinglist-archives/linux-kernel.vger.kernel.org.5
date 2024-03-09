Return-Path: <linux-kernel+bounces-97821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE888876FF3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742B0281BFD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2049F3770B;
	Sat,  9 Mar 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dFY4exOo"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2018.outbound.protection.outlook.com [40.92.19.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29B137142;
	Sat,  9 Mar 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709975024; cv=fail; b=bH/RBK7ky9I9VrXISncgb0CLEh8B11xASM2K6byJT4lb4Fl1cNoSExv7vIhGwvrdAy2e9W+3sLjgehrOO9226kJn5XH3C2KS1mq2aYyNsHM3i6aEhjms0JjtQuMfdcQvPv/HUnSZE//iCLX9At3Wdd797JOuntwU6itX/sBTiq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709975024; c=relaxed/simple;
	bh=Dos7ojuleSWUKF7O7FCB95BdRulLJB8sTOWX8SGH11Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cvHimbzLJCRW7XZ1VR5hQEovnm13BGgGjVAJdam6cYB0agtMeoNsO5811h7H0ytci8/5kHHC4f4f8v91RcwFVxEa6G9nwuYNnqfq1VMnMrsyeJ4NbMemsQvxsoRVIuqSfyWrKU3wG1QwYQWYc+sO0EI6zMFFdcrCaeUMdsXWDUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dFY4exOo; arc=fail smtp.client-ip=40.92.19.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDCl5JNw6I5XKvXmgz4as7fI0q8QYpY8/1z54UDieam7R473cu86NhgN48YAztc7axDiHqcRkUgCz7F1FUk7d0QgjWlAwQzdUUfWinrESWqVEeJW5iPowRwzIaCV4PKjVFsJQ/McUecXgLotnByVPDorg/9v4tCtmu3gkdS0E94pAPM+WOFSQnZ1RkZOx1JX4Mgv/d3RztQ0btMY5/6wFMBGa9giv972zKksB+AJ3nHDCneld5iXBxHRq5F+LCZaWrfKxL00YC3P3jbaIWT8s/McRgK6yOYs6ojsDvg027/YDKYgwClZNUxtwhX1pKnlFARiHPgRl5Ezkxs2oHtCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxW+d+dh0NRewqaT51NCzjfGqqxbEehSVMBfbwWCPXc=;
 b=jiN8/0a2Ygc88HJt19ikmy3zxemMn9m8N3olalzKRO8anZVAjcAh47B9SpR8la/qL9CkJ8VYui4X+XOVuXFqksjf50KfRW00GDPZhIx5+90yrCu3RpPYRfUueKmedT3YMxp1P2m+CzDcqcmrDEdaBG3RCWXOOZCM4ATRIZCOUXUizr9hAzZ1BTSfs/FpVoQXeUKkdWRSn7wkyvGHJSaOubx8eVkO3BKW0OmHwf5hTqknT0XFzUzZiCNLf5PGB3BaorMMG2STeaoIUqQbyhjPhC2vGVmtfgioRvD6Xeomm7wzH+9F0kd151isp888vndBMVZRUTC0aou84VZz2pczYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxW+d+dh0NRewqaT51NCzjfGqqxbEehSVMBfbwWCPXc=;
 b=dFY4exOozh4QyctfBJtQdfNPBVFnV0cf/hZ/ZJUNhuYC7+5ve7+ifB4wahMikDcNg9TRieWiHQ1ja5d/ABiXbFG9CNLTTthtl48EI+S/yTtKCMTdcFqTAs9onjGsv+99Yh3SDihhf9vrpWbvha7vLNqZtqzKcMhlkeESxDFp7mtOH4hV+3Ffgfi+HyFFrnYmD0YW+36NH+/AOgfZw0qZ4TdoIzgvC4Y1JwLZM78/kruPxhcQMXaFn31hAVIQ+p9HtdMe2rGvlUWBxRnuQrqfV1TdT1mN1V9B9s0CN7txJ+6e1MV2lEcKQXrhUTO6Ft9YKNJc95zuJK4G96s/aZqFRQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MW5PR20MB4260.namprd20.prod.outlook.com (2603:10b6:303:191::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sat, 9 Mar
 2024 09:03:37 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7362.030; Sat, 9 Mar 2024
 09:03:37 +0000
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
Subject: [PATCH v9 3/6] clk: sophgo: Add clock support for CV1810 SoC
Date: Sat,  9 Mar 2024 17:02:53 +0800
Message-ID:
 <IA1PR20MB495357FB5EEA1623DAB08C94BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [y8mFnvXXdQyu+m7A+59UgvR03Yahsh7eCzw3i3PZb2k=]
X-ClientProxiedBy: TYCP301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240309090257.927623-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MW5PR20MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d08f8a-8e49-4ae2-9e44-08dc4017ce65
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jDmhGtQRiJEVNTPU9crwbZtrHrGFlRdB6w/QmsbvzIpFAt2eAxe6XbCO19+DoyITjc9SX0rlwa6Ji0vqci+ealsSjvWV5rV1cDM5Gcq0f6WedIYBQlMZrVv7DQzwHtdfSohEqgIcerLXF5EQYpHUvcRIA2KtDpEdwlws0+d9t2Gv1R0Gs8JWGjZxSBg4IwhYqd7bhNrLGhgPdXGBskoGcppoS/qV5XQ2O4Dp+deOEHBEk/lUMFr7tQ5cMM7H+q0evFPO8hz+qmD/6+R4By9Rg33+RoYtvvAKXsPP8V//X3uoalWRNSx6cyl5EeRiYwYijHLdrtHj+FublJs5+2Rt5y/R3CYtovu7uTjRAEuhMtoWVLJd2vFs5xHpp7ZGCFQjAQV6ZPovXsDbN2qHUcpzHIO+ym53SwKeX+S7Ghfl7ujopsuk6MngEvaKA37Oo7Hp8UvwhPFmbovpPKOwXwbJAVQ2rh1BsLmpqlSuyc2lsr+A0g9FXJttt5wwqvj4didUEKVuicRtBbITNDCkzpCNqebn/D4ZJVeX4itKHMUWcPFnaXwL0+DppAoBI6c+7AZl+wC1i3oQlyv8eUtmol2tglxxmY7e1Ngq7v62hRJLvT/sJgfdjdpjdsJXrguI2Eqv13v78gcvO38pmOQwh+PCgkV+JkEvLM82pzcp4TGgpFUQmfeSL3aYKHF35UOqzfOU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7220Qbx/0JXnb/7cr7H241TNW+WjC/5AQxEYNNXLUi/V6IxRCjQJi23jo8MK?=
 =?us-ascii?Q?yGd+QSC8jWqDPHqBMLSJInznEHlx+3Ze7mwz0CM9yjNgZRzveC0MjQOgWXlM?=
 =?us-ascii?Q?qzi4jub53P2hfsYuuSbNS9mLZurvwm1TbfPXP4et0JtSyatF8waUXbkxsX+Z?=
 =?us-ascii?Q?UO56hXsGR11x1SBD2T/f++ci+H1FgN3lWMa7OUaAVuh6suGilLJvUFwkATeu?=
 =?us-ascii?Q?p/JywdPLw0Rojl2teflTFK8n9kDwC/08KpcFgGc90pSUgyu5IQP59tNkOu2J?=
 =?us-ascii?Q?KNl+MQlVK5cjrwZTKHxlcBS5mCjcqNefbE91Vhr5Q+eIgTBXYz3+K3d42GxX?=
 =?us-ascii?Q?6IP8wR+l9ahSFbtQsVEvx+4UKMzg2W5KJuZVQwq7C+Ql9ZbtxGoN1BhB4SQB?=
 =?us-ascii?Q?0wwnAJxhpFxdHSVmPwmrLJ8PqYL2Bo4D2R3I/Hf7xxw8KpaZpZbzApYFN2tP?=
 =?us-ascii?Q?B6eaMvR+rQCW8V4MhbmO9ilJE5/9fCvVfRD7uINVIqWDf0jFpb8hZHmj0VU1?=
 =?us-ascii?Q?nY6oD+XqQ6sx2CXG9XrncZ2CJzjYuqiiFaMJu8AkDf8bwDMXAAeEQqgpfSbn?=
 =?us-ascii?Q?Hb90ZnUj0Wr0NGOOkyp3MoY9gpX+OWQjky8Z9Nk8KMfNBwBShw0HpsOgCE3x?=
 =?us-ascii?Q?VvS1VST3dvIB8jwq74DfXzs7XmFiQVFe7mF9b+/nuAPENEFJKnNUPOBPViVx?=
 =?us-ascii?Q?RBFBiGu9WDXwFM0UajkLhZ3r+aj+r3GFq/G0P1BeNsEJVa9MxWj1ntjzUnHx?=
 =?us-ascii?Q?Oiu32JicTUlbiNchhzVoabit0DHl8sUDUphUShlZEQqXe7I4EMQWML1dfOGL?=
 =?us-ascii?Q?qq032bMKvLRZYqOv0bqegL30v0VegaKmQE1bRQgbyDnQhaQ3qi2eKb/LTfgO?=
 =?us-ascii?Q?7lBcez2Jt72Ac/bE0JJchEWC8CBoYeDw9+prydsu3fU4Wwi1goCurx6G+8WR?=
 =?us-ascii?Q?KQjgpeUT3JgQIgZjUA9vVi/RD4uai5tcW0cQI8ZjlSBh+90sOkyo47ZkV/zz?=
 =?us-ascii?Q?NtRD6Ck6wiw1p+X7py/ORix3qOlMS8MR7sImMXLhi0mv18S3tgjZfMu4UY15?=
 =?us-ascii?Q?fy1RMLrlzGV84MY9WHjsu8TdQpmrPUD3mV74bZczfz84A3W41PtV1uKHcna0?=
 =?us-ascii?Q?hWzxbiEMAMoahYLaKMUl9D7dh6MBPdwkLPOcA65VNn4sWKxHqzFo343oDrYt?=
 =?us-ascii?Q?iVfgv37DSRRR+uXnPOxBfWwo4IxIHDeilHedlGXeXC/LTdeX5qRwN/fjDw+2?=
 =?us-ascii?Q?mx9xEIkz5KrBK/5N9elt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d08f8a-8e49-4ae2-9e44-08dc4017ce65
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 09:03:37.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4260

Add clock definition and init code for CV1810 SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8df248a19ca70837a3/duo/datasheet/CV180X-Clock-v1.xlsx
---
 drivers/clk/sophgo/clk-cv1800.c | 195 ++++++++++++++++++++++++++++++++
 drivers/clk/sophgo/clk-cv1800.h |   1 +
 2 files changed, 196 insertions(+)

diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1800.c
index 6606a2701b12..c7d4aa6c8343 100644
--- a/drivers/clk/sophgo/clk-cv1800.c
+++ b/drivers/clk/sophgo/clk-cv1800.c
@@ -631,6 +631,10 @@ static const struct clk_parent_data clk_vip_sys_parents[] = {
 	{ .hw = &clk_disppll.common.hw },
 	{ .hw = &clk_fpll.common.hw },
 };
+static const struct clk_parent_data clk_disp_vip_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_disppll.common.hw },
+};

 static CV1800_BYPASS_DIV(clk_dsi_esc, clk_bypass_axi6_bus_parents,
 			 REG_CLK_EN_2, 3,
@@ -660,6 +664,11 @@ static CV1800_BYPASS_MUX(clk_src_vip_sys_1, clk_vip_sys_parents,
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
@@ -1243,6 +1252,191 @@ static const struct cv1800_clk_desc cv1800_desc = {
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
@@ -1311,6 +1505,7 @@ static int cv1800_clk_probe(struct platform_device *pdev)

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
2.44.0


