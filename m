Return-Path: <linux-kernel+bounces-63105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998E2852AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9FE21F2334C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80678225CE;
	Tue, 13 Feb 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qvB8czZa"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2077.outbound.protection.outlook.com [40.92.42.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F1224E4;
	Tue, 13 Feb 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812583; cv=fail; b=Y+rK8z/EZNh2E0xEm2qC5zmzGNpayuALUppBgbzrss1xII4vaFGE4aMZm9ZcdElIyA9BJGwAEIcZVMjYEBUniQmJUX0SIP7WSAAEYFU2xkMjSUARDEDkY/7LdzvP3KvQzK9aBtXp+g0ZE+A7fA6jB7vkFb5WUKVwuiB57y2Sp6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812583; c=relaxed/simple;
	bh=hXwgKDxT89zuvOrHKbR1bGyVOLUzwOEULfVI/CnCaiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BGTIP5gxFmXvvFotPmqF/Ws8prCMLiDxd3QYI0OS7rEsz0zhdvCHNXaO1agF/7klvyGojbeBNGnWQkexoX9UEHwYKydJtOKpfE+5rQGqGQAT0SlSgHAMwx37+P1s/mAJ4+nT6RTX2cPjBVlVW8iCIaV9KSw7kzmOCE1CVZT2WnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qvB8czZa; arc=fail smtp.client-ip=40.92.42.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS7G57vTmjq1NXVdkeliNwCGh7hTjGBhmn8qmezk+myg8hVV1BRzn17UCoKjlPT/FSo9vOAXgbb4MoKr3TxIGbWyg24n1lmIDBikRtd506yyJcBXwiw25eqcurv2gOtVDtEbGiVePimyJYYwbemOSc2seD+038BaoS+lkpjfI3orhaJLYM3wV1tUXjnwMs+L5D7rY/89gpwUFH+Ul2G7vz0cP4NjINpupFWsz8ywxukuHmv9wL629Nh6tV5CEpz5AJ+oXYLlqJRgwC63LvExC2HBQ9ihc5HBSk69uGCpUh9ewJBgAYD8obuxzEhzPQMtPAukjx2z1cG+CREVxRCdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aivRtlQin53NfAEHnLNl1OuvTbcn8EoyLcYyOsuGQz0=;
 b=hu/WaCXdwNrrN6Wopm5xq4gB2vKHTLXmMuObPV9jGBmFV0/FMI/nEexonc3K9fNuHLk1EpG1rVt0vukhFvpSuX0ZooWOU6RYBmaaOa7nGep12X1BNRUWhXeGXwVHeGAtJo39wN+A+KlWg65/Q5ylCedpcHXF2AnlOEl33rdktchwFAHMUQH2/jfavV6VwIYUHGlaqNQipJznknw4vXLwAWjz2b8XLrIhdRtK4mZNAtQ6qZ+jzKRebGMJ9e2/Rdf7xyyyM/3aUd8EDwTunuIRTk/3XViX7E1KXlr9sk4Adb8/iyWJGdJKkJIVKODdSlUrdJN6hdF38e/RmrgDn9/+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aivRtlQin53NfAEHnLNl1OuvTbcn8EoyLcYyOsuGQz0=;
 b=qvB8czZadqZ7+AXlXwNYd1THcQbIYlohgLvdg0ZEWSBMtNT2tY7kWNiBsh+PzhVrN4L7d2ug89hWwOKZDjCr09T9CLr6ZZq7aLD6ZFeOZ7FPGNx8axlj+gdYF0omX0VxG0f/dYnSmVjL0u/U8uwhoXjlvAPz4asPzUOWXMev4hahcnautZKSY8HJKBfwjaMVV3IziHxO//g6YsvJmPEnONnoACr2LIn7GNeYWDTzvbRCTOJyI/+4PuBpPwS+VCnAUWtpUzktUmz4OETGAW5LkwDDMfdm/o7W7FY3hceqteObD0RrvHmmQ83uYt3y5J/AYppGGhvPdaMlByELrbt+Eg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB3776.namprd20.prod.outlook.com (2603:10b6:5:3ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 08:22:58 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 08:22:58 +0000
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
Subject: [PATCH v8 4/8] clk: sophgo: Add clock support for CV1800 SoC
Date: Tue, 13 Feb 2024 16:22:36 +0800
Message-ID:
 <IA1PR20MB49530E6DBA1F484CEBA1173EBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [yIQn6wRLNrT3b2EJtiJKYSa3mwflsZjf/BkqaIL4QjxoMBU2CEejijhgAOhd+lxj]
X-ClientProxiedBy: TYAPR01CA0205.jpnprd01.prod.outlook.com
 (2603:1096:404:29::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240213082243.591875-4-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB3776:EE_
X-MS-Office365-Filtering-Correlation-Id: 788643cd-98d5-448e-08df-08dc2c6cfc2e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m6Y/7PETdj1E3s8w4jgxban/qC4HljMVu7eyEKUbrNskUpEa7APWaKAvpQ5MDfejXVL2KHoSNv3dXreP8FZ4gEyZaccxhKyF2ahVnwPGx4SBn+txi3baoyGnJoCMytprcCVt8xxupwOSC8m04uEpexNYWmBEFd6EmuqARD+4ebuHe66NY5/CclG75GnlwPOboOjzAqgcy6OV54CHPee6/yhylTk7NGt+uV3C+eAe9MDBW9T+EmonnAJ2oz+2X4qSCGocNM6EV3rYOqTvlwISTjXF41Yw2Bx6Hlpf81lOBKbeny0GwXuEo/iHNKoD0jhbW/nmr0DHXLPb7VXomVaRgNnIaJj04zBX+tq5S/G2HQsU/wZsaAYsVMLm0t7r/tuUJIsrZzdhyll9TT1UTJVfjsjMDS3Nu2Y+UNpCM5EsEXsTBGEkwb1I0KjQ7JcPDtWEJdGpGynzj4ekSNDOSBzV0PBl+POsH2D9rP72S8HzSRWEoCRfr8BKxmnODp+hKHmaqM4aCNZqXKUz8SFcuMRjWnv1mPDxuYOmBlsEfdZWhXTqw4dUe/7FgVUycXgmaaFpeP+xMlBqdZv7eaalRO9km5yHQoTetMKd03VcFiW8um10wqA54XhaeURJlBXK8rH/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AadqXTCfCF/r81JdVdkFrzX4zjIlpRTDGGJGRoHGK26eLmeIW8sxZUpevZ1M?=
 =?us-ascii?Q?qxuFZcs1hAMxwpELN/1TVb5KWYubJcjAUAkDRoNz8NQH78F2Asg7qI/MQ5Vh?=
 =?us-ascii?Q?A4fX9beYKbLiujOwPqxQOSEPA6IR6x77UK+VhkZ7FKXOYwjipVFMXsZX8j/j?=
 =?us-ascii?Q?JBmFyPHYHXULQi2MRibiAHlH92jM+NDUOx8+Ufx5fRjooWWMmggGyUgFMWkS?=
 =?us-ascii?Q?d1suIPXRpcSk1zzOiPF+V6qANFV6L6wN83ZK+QibMNTksWao47bfpMERfKVN?=
 =?us-ascii?Q?LuTOOmNpJ8L7NXkPgWwk0NEnIutbJB62lul8YxuZCKO/LSqTcPZlyT3dUncg?=
 =?us-ascii?Q?//4V77l2c5wzOukNO3ZOJ48rGzsTKO4CiwtEpfxBYOwjA+LjY1U4Nwmc0Y7S?=
 =?us-ascii?Q?//Y8DVj/qoSYhbj20iz2Fp2QxRn4rX7tX6kQ+Nqqsq/VINuvL2/O/AtYaX6h?=
 =?us-ascii?Q?i2iF7CBSLmxWoBtTZ8a0BpyZt1PdE5hoFamvXPmyyrw/mkMm/gVPorBGU0/p?=
 =?us-ascii?Q?XeAk6TSob1/4TH3EGtQb0ks+/UorA1P6vF9/l81+sXIVkZGWS5BfKWQnvQFt?=
 =?us-ascii?Q?N7LagPdZ5eVY0JX/YxM7JguTBJjB7bnnsgXRdDLe5NcA02XvUpWnlgnJaS0W?=
 =?us-ascii?Q?/4tzWGvSKsOrHt+qZxZyJHBQT45nwiPqzY0hjzydRbJhkuKekNEysu9THoe9?=
 =?us-ascii?Q?9gmFw0488UPWWLp2DveYBDfwpSNf11YdDdoz1u4MnUTyA5KCUwXsZWzeWq5d?=
 =?us-ascii?Q?aLBie8nVvT6bZ0eBU6lxygenGmF5ItuVrPp37Y4PUl9MlSs4BaxRovrj1j6l?=
 =?us-ascii?Q?DZxQFMqyUgoJVIZ6Pd/S7jyw6QmK14T/P/TuR1tLNQyY8TVJ29VuTPlv2HNG?=
 =?us-ascii?Q?hc/0KvAQiUAFu+TGdDxLDe4fvL89uu8FOmrFoK5P9pheSFk9tou9FqbI4jZ3?=
 =?us-ascii?Q?s8wtnus5vRwN7ItVrpBBBNsrWZEfdxJ7UlzuAZoC1sFLHFz1rgZjqeuEx5Cr?=
 =?us-ascii?Q?irH1r+dzAW0Q5XYh6l929wNXrUjLsofd/9gZcOzr1bzZ+QYfURb8kKfpr2y9?=
 =?us-ascii?Q?bYh2DUk+Eq5ij5Z2vfuWcyF1ih+9YxeCA1xgpobW8vf6EmVyWaTnR/HC95EH?=
 =?us-ascii?Q?dhLSivL/9VxGKlAn81zibswALmJ7XXiTWTluKH+pRvMGhv3qk/TVMaeG+gxH?=
 =?us-ascii?Q?NQRZbtKB499TOhmcW/mkg9Secuw9S5mo2n/IA2tFEQR+K2z6BzajR+Cswywn?=
 =?us-ascii?Q?d8ONTdbfWHCr2q8ebAP20iTYnhjMJZ9FnzI8HY0PWIvK8O09QXtWdOSRoSSx?=
 =?us-ascii?Q?NTs=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788643cd-98d5-448e-08df-08dc2c6cfc2e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:22:58.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB3776

Add clock definition and init code for CV1800 SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8df248a19ca70837a3/duo/datasheet/CV180X-Clock-v1.xlsx
---
 drivers/clk/sophgo/clk-cv1800.c | 1218 +++++++++++++++++++++++++++++++
 drivers/clk/sophgo/clk-cv1800.h |  122 ++++
 2 files changed, 1340 insertions(+)
 create mode 100644 drivers/clk/sophgo/clk-cv1800.h

diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1800.c
index 7183e67f20bf..6a78b1915f6d 100644
--- a/drivers/clk/sophgo/clk-cv1800.c
+++ b/drivers/clk/sophgo/clk-cv1800.c
@@ -9,7 +9,11 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>

+#include "clk-cv1800.h"
+
 #include "clk-cv18xx-common.h"
+#include "clk-cv18xx-ip.h"
+#include "clk-cv18xx-pll.h"

 struct cv1800_clk_ctrl;

@@ -26,6 +30,1219 @@ struct cv1800_clk_ctrl {
 	spinlock_t			lock;
 };

+#define CV1800_DIV_FLAG	\
+	(CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST)
+static const struct clk_parent_data osc_parents[] = {
+	{ .index = 0 },
+};
+
+static const struct cv1800_clk_pll_limit pll_limits[] = {
+	{
+		.pre_div	= _CV1800_PLL_LIMIT(1, 127),
+		.div		= _CV1800_PLL_LIMIT(6, 127),
+		.post_div	= _CV1800_PLL_LIMIT(1, 127),
+		.ictrl		= _CV1800_PLL_LIMIT(0, 7),
+		.mode		= _CV1800_PLL_LIMIT(0, 3),
+	},
+	{
+		.pre_div	= _CV1800_PLL_LIMIT(1, 127),
+		.div		= _CV1800_PLL_LIMIT(6, 127),
+		.post_div	= _CV1800_PLL_LIMIT(1, 127),
+		.ictrl		= _CV1800_PLL_LIMIT(0, 7),
+		.mode		= _CV1800_PLL_LIMIT(0, 3),
+	},
+};
+
+static CV1800_INTEGRAL_PLL(clk_fpll, osc_parents,
+			   REG_FPLL_CSR,
+			   REG_PLL_G6_CTRL, 8,
+			   REG_PLL_G6_STATUS, 2,
+			   pll_limits,
+			   CLK_IS_CRITICAL);
+
+static CV1800_INTEGRAL_PLL(clk_mipimpll, osc_parents,
+			   REG_MIPIMPLL_CSR,
+			   REG_PLL_G2_CTRL, 0,
+			   REG_PLL_G2_STATUS, 0,
+			   pll_limits,
+			   CLK_IS_CRITICAL);
+
+static const struct clk_parent_data clk_mipimpll_parents[] = {
+	{ .hw = &clk_mipimpll.common.hw },
+};
+static const struct clk_parent_data clk_bypass_mipimpll_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_mipimpll.common.hw },
+};
+static const struct clk_parent_data clk_bypass_fpll_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_fpll.common.hw },
+};
+
+struct cv1800_clk_pll_synthesizer clk_mpll_synthesizer = {
+	.en		= CV1800_CLK_BIT(REG_PLL_G6_SSC_SYN_CTRL, 2),
+	.clk_half	= CV1800_CLK_BIT(REG_PLL_G6_SSC_SYN_CTRL, 0),
+	.ctrl		= REG_MPLL_SSC_SYN_CTRL,
+	.set		= REG_MPLL_SSC_SYN_SET,
+};
+static CV1800_FACTIONAL_PLL(clk_mpll, clk_bypass_mipimpll_parents,
+			    REG_MPLL_CSR,
+			    REG_PLL_G6_CTRL, 0,
+			    REG_PLL_G6_STATUS, 0,
+			    pll_limits,
+			    &clk_mpll_synthesizer,
+			    CLK_IS_CRITICAL);
+
+struct cv1800_clk_pll_synthesizer clk_tpll_synthesizer = {
+	.en		= CV1800_CLK_BIT(REG_PLL_G6_SSC_SYN_CTRL, 3),
+	.clk_half	= CV1800_CLK_BIT(REG_PLL_G6_SSC_SYN_CTRL, 0),
+	.ctrl		= REG_TPLL_SSC_SYN_CTRL,
+	.set		= REG_TPLL_SSC_SYN_SET,
+};
+static CV1800_FACTIONAL_PLL(clk_tpll, clk_bypass_mipimpll_parents,
+			    REG_TPLL_CSR,
+			    REG_PLL_G6_CTRL, 4,
+			    REG_PLL_G6_STATUS, 1,
+			    pll_limits,
+			    &clk_tpll_synthesizer,
+			    CLK_IS_CRITICAL);
+
+struct cv1800_clk_pll_synthesizer clk_a0pll_synthesizer = {
+	.en		= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 2),
+	.clk_half	= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 0),
+	.ctrl		= REG_A0PLL_SSC_SYN_CTRL,
+	.set		= REG_A0PLL_SSC_SYN_SET,
+};
+static CV1800_FACTIONAL_PLL(clk_a0pll, clk_bypass_mipimpll_parents,
+			    REG_A0PLL_CSR,
+			    REG_PLL_G2_CTRL, 4,
+			    REG_PLL_G2_STATUS, 1,
+			    pll_limits,
+			    &clk_a0pll_synthesizer,
+			    CLK_IS_CRITICAL);
+
+struct cv1800_clk_pll_synthesizer clk_disppll_synthesizer = {
+	.en		= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 3),
+	.clk_half	= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 0),
+	.ctrl		= REG_DISPPLL_SSC_SYN_CTRL,
+	.set		= REG_DISPPLL_SSC_SYN_SET,
+};
+static CV1800_FACTIONAL_PLL(clk_disppll, clk_bypass_mipimpll_parents,
+			    REG_DISPPLL_CSR,
+			    REG_PLL_G2_CTRL, 8,
+			    REG_PLL_G2_STATUS, 2,
+			    pll_limits,
+			    &clk_disppll_synthesizer,
+			    CLK_IS_CRITICAL);
+
+struct cv1800_clk_pll_synthesizer clk_cam0pll_synthesizer = {
+	.en		= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 4),
+	.clk_half	= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 0),
+	.ctrl		= REG_CAM0PLL_SSC_SYN_CTRL,
+	.set		= REG_CAM0PLL_SSC_SYN_SET,
+};
+static CV1800_FACTIONAL_PLL(clk_cam0pll, clk_bypass_mipimpll_parents,
+			    REG_CAM0PLL_CSR,
+			    REG_PLL_G2_CTRL, 12,
+			    REG_PLL_G2_STATUS, 3,
+			    pll_limits,
+			    &clk_cam0pll_synthesizer,
+			    CLK_IGNORE_UNUSED);
+
+struct cv1800_clk_pll_synthesizer clk_cam1pll_synthesizer = {
+	.en		= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 5),
+	.clk_half	= CV1800_CLK_BIT(REG_PLL_G2_SSC_SYN_CTRL, 0),
+	.ctrl		= REG_CAM1PLL_SSC_SYN_CTRL,
+	.set		= REG_CAM1PLL_SSC_SYN_SET,
+};
+static CV1800_FACTIONAL_PLL(clk_cam1pll, clk_bypass_mipimpll_parents,
+			    REG_CAM1PLL_CSR,
+			    REG_PLL_G2_CTRL, 16,
+			    REG_PLL_G2_STATUS, 4,
+			    pll_limits,
+			    &clk_cam1pll_synthesizer,
+			    CLK_IS_CRITICAL);
+
+static const struct clk_parent_data clk_cam0pll_parents[] = {
+	{ .hw = &clk_cam0pll.common.hw },
+};
+
+/* G2D */
+static CV1800_FIXED_DIV(clk_cam0pll_d2, clk_cam0pll_parents,
+			REG_CAM0PLL_CLK_CSR, 1,
+			2,
+			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED);
+static CV1800_FIXED_DIV(clk_cam0pll_d3, clk_cam0pll_parents,
+			REG_CAM0PLL_CLK_CSR, 2,
+			3,
+			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED);
+static CV1800_FIXED_DIV(clk_mipimpll_d3, clk_mipimpll_parents,
+			REG_MIPIMPLL_CLK_CSR, 2,
+			3,
+			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED);
+
+/* TPU */
+static const struct clk_parent_data clk_tpu_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_tpll.common.hw },
+	{ .hw = &clk_a0pll.common.hw },
+	{ .hw = &clk_mipimpll.common.hw },
+	{ .hw = &clk_fpll.common.hw },
+};
+
+static CV1800_BYPASS_MUX(clk_tpu, clk_tpu_parents,
+			 REG_CLK_EN_0, 4,
+			 REG_DIV_CLK_TPU, 16, 4, 3, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_TPU, 8, 2,
+			 REG_CLK_BYP_0, 3,
+			 0);
+static CV1800_GATE(clk_tpu_fab, clk_mipimpll_parents,
+		   REG_CLK_EN_0, 5,
+		   0);
+
+/* FABRIC_AXI6 */
+static CV1800_BYPASS_DIV(clk_axi6, clk_bypass_fpll_parents,
+			 REG_CLK_EN_2, 2,
+			 REG_DIV_CLK_AXI6, 16, 4, 15, CV1800_DIV_FLAG,
+			 REG_CLK_BYP_0, 20,
+			 CLK_IS_CRITICAL);
+
+static const struct clk_parent_data clk_axi6_bus_parents[] = {
+	{ .hw = &clk_axi6.div.common.hw },
+};
+static const struct clk_parent_data clk_bypass_axi6_bus_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_axi6.div.common.hw },
+};
+
+/* FABRIC_AXI4 */
+static const struct clk_parent_data clk_axi4_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_fpll.common.hw },
+	{ .hw = &clk_disppll.common.hw },
+};
+
+static CV1800_BYPASS_MUX(clk_axi4, clk_axi4_parents,
+			 REG_CLK_EN_2, 1,
+			 REG_DIV_CLK_AXI4, 16, 4, 5, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_AXI4, 8, 2,
+			 REG_CLK_BYP_0, 19,
+			 CLK_IS_CRITICAL);
+
+static const struct clk_parent_data clk_axi4_bus_parents[] = {
+	{ .hw = &clk_axi4.mux.common.hw },
+};
+
+/* XTAL_MISC */
+static CV1800_GATE(clk_xtal_misc, osc_parents,
+		   REG_CLK_EN_0, 14,
+		   CLK_IS_CRITICAL);
+
+static const struct clk_parent_data clk_timer_parents[] = {
+	{ .hw = &clk_xtal_misc.common.hw },
+};
+
+/* TOP */
+static const struct clk_parent_data clk_cam0_200_parents[] = {
+	{ .index = 0 },
+	{ .index = 0 },
+	{ .hw = &clk_disppll.common.hw },
+};
+
+static CV1800_BYPASS_MUX(clk_cam0_200, clk_cam0_200_parents,
+			 REG_CLK_EN_1, 13,
+			 REG_DIV_CLK_CAM0_200, 16, 4, 1, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_CAM0_200, 8, 2,
+			 REG_CLK_BYP_0, 16,
+			 CLK_IS_CRITICAL);
+static CV1800_DIV(clk_1m, osc_parents,
+		  REG_CLK_EN_3, 5,
+		  REG_DIV_CLK_1M, 16, 6, 25, CV1800_DIV_FLAG,
+		  CLK_IS_CRITICAL);
+static CV1800_GATE(clk_pm, clk_axi6_bus_parents,
+		   REG_CLK_EN_3, 8,
+		   CLK_IS_CRITICAL);
+static CV1800_GATE(clk_timer0, clk_timer_parents,
+		   REG_CLK_EN_3, 9,
+		   CLK_IS_CRITICAL);
+static CV1800_GATE(clk_timer1, clk_timer_parents,
+		   REG_CLK_EN_3, 10,
+		   CLK_IS_CRITICAL);
+static CV1800_GATE(clk_timer2, clk_timer_parents,
+		   REG_CLK_EN_3, 11,
+		   CLK_IS_CRITICAL);
+static CV1800_GATE(clk_timer3, clk_timer_parents,
+		   REG_CLK_EN_3, 12,
+		   CLK_IS_CRITICAL);
+static CV1800_GATE(clk_timer4, clk_timer_parents,
+		   REG_CLK_EN_3, 13,
+		   CLK_IS_CRITICAL);
+static CV1800_GATE(clk_timer5, clk_timer_parents,
+		   REG_CLK_EN_3, 14,
+		   CLK_IS_CRITICAL);
+static CV1800_GATE(clk_timer6, clk_timer_parents,
+		   REG_CLK_EN_3, 15,
+		   CLK_IS_CRITICAL);
+static CV1800_GATE(clk_timer7, clk_timer_parents,
+		   REG_CLK_EN_3, 16,
+		   CLK_IS_CRITICAL);
+
+static const struct clk_parent_data clk_parents_1m[] = {
+	{ .hw = &clk_1m.common.hw },
+};
+static const struct clk_parent_data clk_uart_parents[] = {
+	{ .hw = &clk_cam0_200.mux.common.hw },
+};
+
+/* AHB ROM */
+static CV1800_GATE(clk_ahb_rom, clk_axi4_bus_parents,
+		   REG_CLK_EN_0, 6,
+		   0);
+
+/* RTC */
+static CV1800_GATE(clk_rtc_25m, osc_parents,
+		   REG_CLK_EN_0, 8,
+		   CLK_IS_CRITICAL);
+static CV1800_BYPASS_DIV(clk_src_rtc_sys_0, clk_bypass_fpll_parents,
+			 REG_CLK_EN_4, 6,
+			 REG_DIV_CLK_RTCSYS_SRC_0, 16, 4, 5, CV1800_DIV_FLAG,
+			 REG_CLK_BYP_1, 5,
+			 CLK_IS_CRITICAL);
+
+/* TEMPSEN */
+static CV1800_GATE(clk_tempsen, osc_parents,
+		   REG_CLK_EN_0, 9,
+		   0);
+
+/* SARADC */
+static CV1800_GATE(clk_saradc, osc_parents,
+		   REG_CLK_EN_0, 10,
+		   0);
+
+/* EFUSE */
+static CV1800_GATE(clk_efuse, osc_parents,
+		   REG_CLK_EN_0, 11,
+		   0);
+static CV1800_GATE(clk_apb_efuse, osc_parents,
+		   REG_CLK_EN_0, 12,
+		   0);
+
+/* WDT */
+static CV1800_GATE(clk_apb_wdt, osc_parents,
+		   REG_CLK_EN_1, 7,
+		   CLK_IS_CRITICAL);
+
+/* WGN */
+static CV1800_GATE(clk_wgn, osc_parents,
+		   REG_CLK_EN_3, 22,
+		   0);
+static CV1800_GATE(clk_wgn0, osc_parents,
+		   REG_CLK_EN_3, 23,
+		   0);
+static CV1800_GATE(clk_wgn1, osc_parents,
+		   REG_CLK_EN_3, 24,
+		   0);
+static CV1800_GATE(clk_wgn2, osc_parents,
+		   REG_CLK_EN_3, 25,
+		   0);
+
+/* KEYSCAN */
+static CV1800_GATE(clk_keyscan, osc_parents,
+		   REG_CLK_EN_3, 26,
+		   0);
+
+/* EMMC */
+static CV1800_GATE(clk_axi4_emmc, clk_axi4_bus_parents,
+		   REG_CLK_EN_0, 15,
+		   0);
+static CV1800_BYPASS_MUX(clk_emmc, clk_axi4_parents,
+			 REG_CLK_EN_0, 16,
+			 REG_DIV_CLK_EMMC, 16, 5, 15, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_EMMC, 8, 2,
+			 REG_CLK_BYP_0, 5,
+			 0);
+static CV1800_DIV(clk_emmc_100k, clk_parents_1m,
+		  REG_CLK_EN_0, 17,
+		  REG_DIV_CLK_EMMC_100K, 16, 8, 10, CV1800_DIV_FLAG,
+		  0);
+
+/* SD */
+static CV1800_GATE(clk_axi4_sd0, clk_axi4_bus_parents,
+		   REG_CLK_EN_0, 18,
+		   0);
+static CV1800_BYPASS_MUX(clk_sd0, clk_axi4_parents,
+			 REG_CLK_EN_0, 19,
+			 REG_DIV_CLK_SD0, 16, 5, 15, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SD0, 8, 2,
+			 REG_CLK_BYP_0, 6,
+			 0);
+static CV1800_DIV(clk_sd0_100k, clk_parents_1m,
+		  REG_CLK_EN_0, 20,
+		  REG_DIV_CLK_SD0_100K, 16, 8, 10, CV1800_DIV_FLAG,
+		  0);
+static CV1800_GATE(clk_axi4_sd1, clk_axi4_bus_parents,
+		   REG_CLK_EN_0, 21,
+		   0);
+static CV1800_BYPASS_MUX(clk_sd1, clk_axi4_parents,
+			 REG_CLK_EN_0, 22,
+			 REG_DIV_CLK_SD1, 16, 5, 15, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SD1, 8, 2,
+			 REG_CLK_BYP_0, 7,
+			 0);
+static CV1800_DIV(clk_sd1_100k, clk_parents_1m,
+		  REG_CLK_EN_0, 23,
+		  REG_DIV_CLK_SD1_100K, 16, 8, 10, CV1800_DIV_FLAG,
+		  0);
+
+/* SPI NAND */
+static CV1800_BYPASS_MUX(clk_spi_nand, clk_axi4_parents,
+			 REG_CLK_EN_0, 24,
+			 REG_DIV_CLK_SPI_NAND, 16, 5, 8, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SPI_NAND, 8, 2,
+			 REG_CLK_BYP_0, 8,
+			 0);
+
+/* GPIO */
+static CV1800_DIV(clk_gpio_db, clk_parents_1m,
+		  REG_CLK_EN_0, 31,
+		  REG_DIV_CLK_GPIO_DB, 16, 16, 10, CV1800_DIV_FLAG,
+		  CLK_IS_CRITICAL);
+static CV1800_GATE(clk_apb_gpio, clk_axi6_bus_parents,
+		   REG_CLK_EN_0, 29,
+		   CLK_IS_CRITICAL);
+static CV1800_GATE(clk_apb_gpio_intr, clk_axi6_bus_parents,
+		   REG_CLK_EN_0, 30,
+		   CLK_IS_CRITICAL);
+
+/* ETH */
+static CV1800_BYPASS_DIV(clk_eth0_500m, clk_bypass_fpll_parents,
+			 REG_CLK_EN_0, 25,
+			 REG_DIV_CLK_GPIO_DB, 16, 4, 3, CV1800_DIV_FLAG,
+			 REG_CLK_BYP_0, 9,
+			 0);
+static CV1800_GATE(clk_axi4_eth0, clk_axi4_bus_parents,
+		   REG_CLK_EN_0, 26,
+		   0);
+static CV1800_BYPASS_DIV(clk_eth1_500m, clk_bypass_fpll_parents,
+			 REG_CLK_EN_0, 27,
+			 REG_DIV_CLK_GPIO_DB, 16, 4, 3, CV1800_DIV_FLAG,
+			 REG_CLK_BYP_0, 10,
+			 0);
+static CV1800_GATE(clk_axi4_eth1, clk_axi4_bus_parents,
+		   REG_CLK_EN_0, 28,
+		   0);
+
+/* SF */
+static CV1800_GATE(clk_ahb_sf, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 0,
+		   0);
+static CV1800_GATE(clk_ahb_sf1, clk_axi4_bus_parents,
+		   REG_CLK_EN_3, 27,
+		   0);
+
+/* AUDSRC */
+static CV1800_ACLK(clk_a24m, clk_mipimpll_parents,
+		   REG_APLL_FRAC_DIV_CTRL, 0,
+		   REG_APLL_FRAC_DIV_CTRL, 3,
+		   REG_APLL_FRAC_DIV_CTRL, 1,
+		   REG_APLL_FRAC_DIV_CTRL, 2,
+		   REG_APLL_FRAC_DIV_M, 0, 22, CV1800_DIV_FLAG,
+		   REG_APLL_FRAC_DIV_N, 0, 22, CV1800_DIV_FLAG,
+		   24576000,
+		   0);
+
+static const struct clk_parent_data clk_aud_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_a0pll.common.hw },
+	{ .hw = &clk_a24m.common.hw },
+};
+
+static CV1800_BYPASS_MUX(clk_audsrc, clk_aud_parents,
+			 REG_CLK_EN_4, 1,
+			 REG_DIV_CLK_AUDSRC, 16, 8, 18, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_AUDSRC, 8, 2,
+			 REG_CLK_BYP_1, 2,
+			 0);
+static CV1800_GATE(clk_apb_audsrc, clk_axi4_bus_parents,
+		   REG_CLK_EN_4, 2,
+		   0);
+
+/* SDMA */
+static CV1800_GATE(clk_sdma_axi, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 1,
+		   0);
+static CV1800_BYPASS_MUX(clk_sdma_aud0, clk_aud_parents,
+			 REG_CLK_EN_1, 2,
+			 REG_DIV_CLK_SDMA_AUD0, 16, 8, 18, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SDMA_AUD0, 8, 2,
+			 REG_CLK_BYP_0, 11,
+			 0);
+static CV1800_BYPASS_MUX(clk_sdma_aud1, clk_aud_parents,
+			 REG_CLK_EN_1, 3,
+			 REG_DIV_CLK_SDMA_AUD1, 16, 8, 18, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SDMA_AUD1, 8, 2,
+			 REG_CLK_BYP_0, 12,
+			 0);
+static CV1800_BYPASS_MUX(clk_sdma_aud2, clk_aud_parents,
+			 REG_CLK_EN_1, 3,
+			 REG_DIV_CLK_SDMA_AUD2, 16, 8, 18, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SDMA_AUD2, 8, 2,
+			 REG_CLK_BYP_0, 13,
+			 0);
+static CV1800_BYPASS_MUX(clk_sdma_aud3, clk_aud_parents,
+			 REG_CLK_EN_1, 3,
+			 REG_DIV_CLK_SDMA_AUD3, 16, 8, 18, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SDMA_AUD3, 8, 2,
+			 REG_CLK_BYP_0, 14,
+			 0);
+
+/* SPI */
+static CV1800_GATE(clk_apb_spi0, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 9,
+		   0);
+static CV1800_GATE(clk_apb_spi1, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 10,
+		   0);
+static CV1800_GATE(clk_apb_spi2, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 11,
+		   0);
+static CV1800_GATE(clk_apb_spi3, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 12,
+		   0);
+static CV1800_BYPASS_DIV(clk_spi, clk_bypass_fpll_parents,
+			 REG_CLK_EN_3, 6,
+			 REG_DIV_CLK_SPI, 16, 6, 8, CV1800_DIV_FLAG,
+			 REG_CLK_BYP_0, 30,
+			 0);
+
+/* UART */
+static CV1800_GATE(clk_uart0, clk_uart_parents,
+		   REG_CLK_EN_1, 14,
+		   CLK_IS_CRITICAL);
+static CV1800_GATE(clk_apb_uart0, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 15,
+		   CLK_IS_CRITICAL);
+static CV1800_GATE(clk_uart1, clk_uart_parents,
+		   REG_CLK_EN_1, 16,
+		   0);
+static CV1800_GATE(clk_apb_uart1, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 17,
+		   0);
+static CV1800_GATE(clk_uart2, clk_uart_parents,
+		   REG_CLK_EN_1, 18,
+		   0);
+static CV1800_GATE(clk_apb_uart2, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 19,
+		   0);
+static CV1800_GATE(clk_uart3, clk_uart_parents,
+		   REG_CLK_EN_1, 20,
+		   0);
+static CV1800_GATE(clk_apb_uart3, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 21,
+		   0);
+static CV1800_GATE(clk_uart4, clk_uart_parents,
+		   REG_CLK_EN_1, 22,
+		   0);
+static CV1800_GATE(clk_apb_uart4, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 23,
+		   0);
+
+/* I2S */
+static CV1800_GATE(clk_apb_i2s0, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 24,
+		   0);
+static CV1800_GATE(clk_apb_i2s1, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 25,
+		   0);
+static CV1800_GATE(clk_apb_i2s2, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 26,
+		   0);
+static CV1800_GATE(clk_apb_i2s3, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 27,
+		   0);
+
+/* DEBUG */
+static CV1800_GATE(clk_debug, osc_parents,
+		   REG_CLK_EN_0, 13,
+		   CLK_IS_CRITICAL);
+static CV1800_BYPASS_DIV(clk_ap_debug, clk_bypass_fpll_parents,
+			 REG_CLK_EN_4, 5,
+			 REG_DIV_CLK_AP_DEBUG, 16, 4, 5, CV1800_DIV_FLAG,
+			 REG_CLK_BYP_1, 4,
+			 CLK_IS_CRITICAL);
+
+/* DDR */
+static CV1800_GATE(clk_ddr_axi_reg, clk_axi6_bus_parents,
+		   REG_CLK_EN_0, 7,
+		   CLK_IS_CRITICAL);
+
+/* I2C */
+static CV1800_GATE(clk_apb_i2c, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 6,
+		   0);
+static CV1800_BYPASS_DIV(clk_i2c, clk_bypass_axi6_bus_parents,
+			 REG_CLK_EN_3, 7,
+			 REG_DIV_CLK_I2C, 16, 4, 1, CV1800_DIV_FLAG,
+			 REG_CLK_BYP_0, 31,
+			 0);
+static CV1800_GATE(clk_apb_i2c0, clk_axi4_bus_parents,
+		   REG_CLK_EN_3, 17,
+		   0);
+static CV1800_GATE(clk_apb_i2c1, clk_axi4_bus_parents,
+		   REG_CLK_EN_3, 18,
+		   0);
+static CV1800_GATE(clk_apb_i2c2, clk_axi4_bus_parents,
+		   REG_CLK_EN_3, 19,
+		   0);
+static CV1800_GATE(clk_apb_i2c3, clk_axi4_bus_parents,
+		   REG_CLK_EN_3, 20,
+		   0);
+static CV1800_GATE(clk_apb_i2c4, clk_axi4_bus_parents,
+		   REG_CLK_EN_3, 21,
+		   0);
+
+/* USB */
+static CV1800_GATE(clk_axi4_usb, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 28,
+		   0);
+static CV1800_GATE(clk_apb_usb, clk_axi4_bus_parents,
+		   REG_CLK_EN_1, 29,
+		   0);
+static CV1800_BYPASS_FIXED_DIV(clk_usb_125m, clk_bypass_fpll_parents,
+			       REG_CLK_EN_1, 30,
+			       12,
+			       REG_CLK_BYP_0, 17,
+			       CLK_SET_RATE_PARENT);
+static CV1800_FIXED_DIV(clk_usb_33k, clk_parents_1m,
+			REG_CLK_EN_1, 31,
+			3,
+			0);
+static CV1800_BYPASS_FIXED_DIV(clk_usb_12m, clk_bypass_fpll_parents,
+			       REG_CLK_EN_2, 0,
+			       125,
+			       REG_CLK_BYP_0, 18,
+			       CLK_SET_RATE_PARENT);
+
+/* VIP SYS */
+static const struct clk_parent_data clk_vip_sys_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_mipimpll.common.hw },
+	{ .hw = &clk_cam0pll.common.hw },
+	{ .hw = &clk_disppll.common.hw },
+	{ .hw = &clk_fpll.common.hw },
+};
+
+static CV1800_BYPASS_DIV(clk_dsi_esc, clk_bypass_axi6_bus_parents,
+			 REG_CLK_EN_2, 3,
+			 REG_DIV_CLK_DSI_ESC, 16, 4, 5, CV1800_DIV_FLAG,
+			 REG_CLK_BYP_0, 21,
+			 0);
+static CV1800_BYPASS_MUX(clk_axi_vip, clk_vip_sys_parents,
+			 REG_CLK_EN_2, 4,
+			 REG_DIV_CLK_AXI_VIP, 16, 4, 3, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_AXI_VIP, 8, 2,
+			 REG_CLK_BYP_0, 22,
+			 0);
+
+static const struct clk_parent_data clk_axi_vip_bus_parents[] = {
+	{ .hw = &clk_axi_vip.mux.common.hw },
+};
+
+static CV1800_BYPASS_MUX(clk_src_vip_sys_0, clk_vip_sys_parents,
+			 REG_CLK_EN_2, 5,
+			 REG_DIV_CLK_SRC_VIP_SYS_0, 16, 4, 6, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SRC_VIP_SYS_0, 8, 2,
+			 REG_CLK_BYP_0, 23,
+			 0);
+static CV1800_BYPASS_MUX(clk_src_vip_sys_1, clk_vip_sys_parents,
+			 REG_CLK_EN_2, 6,
+			 REG_DIV_CLK_SRC_VIP_SYS_1, 16, 4, 6, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SRC_VIP_SYS_1, 8, 2,
+			 REG_CLK_BYP_0, 24,
+			 0);
+static CV1800_BYPASS_MUX(clk_src_vip_sys_2, clk_vip_sys_parents,
+			 REG_CLK_EN_3, 29,
+			 REG_DIV_CLK_SRC_VIP_SYS_2, 16, 4, 2, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SRC_VIP_SYS_2, 8, 2,
+			 REG_CLK_BYP_1, 1,
+			 0);
+static CV1800_GATE(clk_csi_mac0_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 18,
+		   0);
+static CV1800_GATE(clk_csi_mac1_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 19,
+		   0);
+static CV1800_GATE(clk_isp_top_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 20,
+		   0);
+static CV1800_GATE(clk_img_d_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 21,
+		   0);
+static CV1800_GATE(clk_img_v_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 22,
+		   0);
+static CV1800_GATE(clk_sc_top_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 23,
+		   0);
+static CV1800_GATE(clk_sc_d_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 24,
+		   0);
+static CV1800_GATE(clk_sc_v1_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 25,
+		   0);
+static CV1800_GATE(clk_sc_v2_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 26,
+		   0);
+static CV1800_GATE(clk_sc_v3_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 27,
+		   0);
+static CV1800_GATE(clk_dwa_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 28,
+		   0);
+static CV1800_GATE(clk_bt_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 29,
+		   0);
+static CV1800_GATE(clk_disp_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 30,
+		   0);
+static CV1800_GATE(clk_dsi_mac_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_2, 31,
+		   0);
+static CV1800_GATE(clk_lvds0_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_3, 0,
+		   0);
+static CV1800_GATE(clk_lvds1_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_3, 1,
+		   0);
+static CV1800_GATE(clk_csi0_rx_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_3, 2,
+		   0);
+static CV1800_GATE(clk_csi1_rx_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_3, 3,
+		   0);
+static CV1800_GATE(clk_pad_vi_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_3, 4,
+		   0);
+static CV1800_GATE(clk_pad_vi1_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_3, 30,
+		   0);
+static CV1800_GATE(clk_cfg_reg_vip, clk_axi6_bus_parents,
+		   REG_CLK_EN_3, 31,
+		   0);
+static CV1800_GATE(clk_pad_vi2_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_4, 7,
+		   0);
+static CV1800_GATE(clk_csi_be_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_4, 8,
+		   0);
+static CV1800_GATE(clk_vip_ip0, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_4, 9,
+		   0);
+static CV1800_GATE(clk_vip_ip1, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_4, 10,
+		   0);
+static CV1800_GATE(clk_vip_ip2, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_4, 11,
+		   0);
+static CV1800_GATE(clk_vip_ip3, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_4, 12,
+		   0);
+static CV1800_BYPASS_MUX(clk_src_vip_sys_3, clk_vip_sys_parents,
+			 REG_CLK_EN_4, 15,
+			 REG_DIV_CLK_SRC_VIP_SYS_3, 16, 4, 2, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SRC_VIP_SYS_3, 8, 2,
+			 REG_CLK_BYP_1, 8,
+			 0);
+static CV1800_BYPASS_MUX(clk_src_vip_sys_4, clk_vip_sys_parents,
+			 REG_CLK_EN_4, 16,
+			 REG_DIV_CLK_SRC_VIP_SYS_4, 16, 4, 3, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_SRC_VIP_SYS_4, 8, 2,
+			 REG_CLK_BYP_1, 9,
+			 0);
+static CV1800_GATE(clk_ive_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_4, 17,
+		   0);
+static CV1800_GATE(clk_raw_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_4, 18,
+		   0);
+static CV1800_GATE(clk_osdc_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_4, 19,
+		   0);
+static CV1800_GATE(clk_csi_mac2_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_4, 20,
+		   0);
+static CV1800_GATE(clk_cam0_vip, clk_axi_vip_bus_parents,
+		   REG_CLK_EN_4, 21,
+		   0);
+
+/* CAM OUT */
+static const struct clk_parent_data clk_cam_parents[] = {
+	{ .hw = &clk_cam0pll.common.hw },
+	{ .hw = &clk_cam0pll_d2.common.hw },
+	{ .hw = &clk_cam0pll_d3.common.hw },
+	{ .hw = &clk_mipimpll_d3.common.hw },
+};
+
+static CV1800_MUX(clk_cam0, clk_cam_parents,
+		  REG_CLK_EN_2, 16,
+		  REG_CLK_CAM0_SRC_DIV, 16, 6, 0, CV1800_DIV_FLAG,
+		  REG_CLK_CAM0_SRC_DIV, 8, 2,
+		  CLK_IGNORE_UNUSED);
+static CV1800_MUX(clk_cam1, clk_cam_parents,
+		  REG_CLK_EN_2, 17,
+		  REG_CLK_CAM1_SRC_DIV, 16, 6, 0, CV1800_DIV_FLAG,
+		  REG_CLK_CAM1_SRC_DIV, 8, 2,
+		  CLK_IGNORE_UNUSED);
+
+/* VIDEO SUBSYS */
+static const struct clk_parent_data clk_axi_video_codec_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_a0pll.common.hw },
+	{ .hw = &clk_mipimpll.common.hw },
+	{ .hw = &clk_cam1pll.common.hw },
+	{ .hw = &clk_fpll.common.hw },
+};
+static const struct clk_parent_data clk_vc_src0_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_disppll.common.hw },
+	{ .hw = &clk_mipimpll.common.hw },
+	{ .hw = &clk_cam1pll.common.hw },
+	{ .hw = &clk_fpll.common.hw },
+};
+static const struct clk_parent_data clk_vc_src1_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_cam1pll.common.hw },
+};
+
+static CV1800_BYPASS_MUX(clk_axi_video_codec, clk_axi_video_codec_parents,
+			 REG_CLK_EN_2, 8,
+			 REG_DIV_CLK_AXI_VIDEO_CODEC, 16, 4, 2, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_AXI_VIDEO_CODEC, 8, 2,
+			 REG_CLK_BYP_0, 26,
+			 0);
+
+static const struct clk_parent_data clk_axi_video_codec_bus_parents[] = {
+	{ .hw = &clk_axi_video_codec.mux.common.hw },
+};
+
+static CV1800_BYPASS_MUX(clk_vc_src0, clk_vc_src0_parents,
+			 REG_CLK_EN_2, 9,
+			 REG_DIV_CLK_VC_SRC0, 16, 4, 2, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_VC_SRC0, 8, 2,
+			 REG_CLK_BYP_0, 27,
+			 0);
+
+static CV1800_GATE(clk_h264c, clk_axi_video_codec_bus_parents,
+		   REG_CLK_EN_2, 10,
+		   0);
+static CV1800_GATE(clk_h265c, clk_axi_video_codec_bus_parents,
+		   REG_CLK_EN_2, 11,
+		   0);
+static CV1800_GATE(clk_jpeg, clk_axi_video_codec_bus_parents,
+		   REG_CLK_EN_2, 12,
+		   CLK_IGNORE_UNUSED);
+static CV1800_GATE(clk_apb_jpeg, clk_axi6_bus_parents,
+		   REG_CLK_EN_2, 13,
+		   CLK_IGNORE_UNUSED);
+static CV1800_GATE(clk_apb_h264c, clk_axi6_bus_parents,
+		   REG_CLK_EN_2, 14,
+		   0);
+static CV1800_GATE(clk_apb_h265c, clk_axi6_bus_parents,
+		   REG_CLK_EN_2, 15,
+		   0);
+static CV1800_BYPASS_FIXED_DIV(clk_vc_src1, clk_vc_src1_parents,
+			       REG_CLK_EN_3, 28,
+			       2,
+			       REG_CLK_BYP_1, 0,
+			       CLK_SET_RATE_PARENT);
+static CV1800_BYPASS_FIXED_DIV(clk_vc_src2, clk_bypass_fpll_parents,
+			       REG_CLK_EN_4, 3,
+			       3,
+			       REG_CLK_BYP_1, 3,
+			       CLK_SET_RATE_PARENT);
+
+/* VC SYS */
+static CV1800_GATE(clk_cfg_reg_vc, clk_axi6_bus_parents,
+		   REG_CLK_EN_4, 0,
+		   CLK_IGNORE_UNUSED);
+
+/* PWM */
+static CV1800_BYPASS_MUX(clk_pwm_src, clk_axi4_parents,
+			 REG_CLK_EN_4, 4,
+			 REG_DIV_CLK_PWM_SRC_0, 16, 6, 10, CV1800_DIV_FLAG,
+			 REG_DIV_CLK_PWM_SRC_0, 8, 2,
+			 REG_CLK_BYP_0, 15,
+			 CLK_IS_CRITICAL);
+
+static const struct clk_parent_data clk_pwm_parents[] = {
+	{ .hw = &clk_pwm_src.mux.common.hw },
+};
+
+static CV1800_GATE(clk_pwm, clk_pwm_parents,
+		   REG_CLK_EN_1, 8,
+		   CLK_IS_CRITICAL);
+
+/* C906 */
+static const struct clk_parent_data clk_c906_0_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_tpll.common.hw },
+	{ .hw = &clk_a0pll.common.hw },
+	{ .hw = &clk_mipimpll.common.hw },
+	{ .hw = &clk_mpll.common.hw },
+	{ .hw = &clk_fpll.common.hw },
+};
+static const struct clk_parent_data clk_c906_1_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_tpll.common.hw },
+	{ .hw = &clk_a0pll.common.hw },
+	{ .hw = &clk_disppll.common.hw },
+	{ .hw = &clk_mpll.common.hw },
+	{ .hw = &clk_fpll.common.hw },
+};
+
+static const s8 clk_c906_parent2sel[] = {
+	-1,	/* osc */
+	0,	/* mux 0: clk_tpll(c906_0), clk_tpll(c906_1) */
+	0,	/* mux 0: clk_a0pll(c906_0), clk_a0pll(c906_1) */
+	0,	/* mux 0: clk_mipimpll(c906_0), clk_disppll(c906_1) */
+	0,	/* mux 0: clk_mpll(c906_0), clk_mpll(c906_1) */
+	1	/* mux 1: clk_fpll(c906_0), clk_fpll(c906_1) */
+};
+
+static const u8 clk_c906_sel2parent[2][4] = {
+	[0] = {
+		1,
+		2,
+		3,
+		4
+	},
+	[1] = {
+		5,
+		5,
+		5,
+		5
+	},
+};
+
+static CV1800_MMUX(clk_c906_0, clk_c906_0_parents,
+		   REG_CLK_EN_4, 13,
+		   REG_DIV_CLK_C906_0_0, 16, 4, 1, CV1800_DIV_FLAG,
+		   REG_DIV_CLK_C906_0_1, 16, 4, 2, CV1800_DIV_FLAG,
+		   REG_DIV_CLK_C906_0_0, 8, 2,
+		   REG_DIV_CLK_C906_0_1, 8, 2,
+		   REG_CLK_BYP_1, 6,
+		   REG_CLK_SEL_0, 23,
+		   clk_c906_parent2sel,
+		   clk_c906_sel2parent[0], clk_c906_sel2parent[1],
+		   CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
+static CV1800_MMUX(clk_c906_1, clk_c906_1_parents,
+		   REG_CLK_EN_4, 14,
+		   REG_DIV_CLK_C906_1_0, 16, 4, 2, CV1800_DIV_FLAG,
+		   REG_DIV_CLK_C906_1_1, 16, 4, 3, CV1800_DIV_FLAG,
+		   REG_DIV_CLK_C906_1_0, 8, 2,
+		   REG_DIV_CLK_C906_1_1, 8, 2,
+		   REG_CLK_BYP_1, 7,
+		   REG_CLK_SEL_0, 24,
+		   clk_c906_parent2sel,
+		   clk_c906_sel2parent[0], clk_c906_sel2parent[1],
+		   CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
+
+/* A53 */
+static CV1800_BYPASS_DIV(clk_cpu_axi0, clk_axi4_parents,
+			 REG_CLK_EN_0, 1,
+			 REG_DIV_CLK_CPU_AXI0, 16, 4, 3, CV1800_DIV_FLAG,
+			 REG_CLK_BYP_0, 1,
+			 CLK_IS_CRITICAL);
+static CV1800_BYPASS_DIV(clk_cpu_gic, clk_bypass_fpll_parents,
+			 REG_CLK_EN_0, 2,
+			 REG_DIV_CLK_CPU_GIC, 16, 4, 5, CV1800_DIV_FLAG,
+			 REG_CLK_BYP_0, 2,
+			 CLK_IS_CRITICAL);
+static CV1800_GATE(clk_xtal_ap, osc_parents,
+		   REG_CLK_EN_0, 3,
+		   CLK_IS_CRITICAL);
+
+static const struct clk_parent_data clk_a53_parents[] = {
+	{ .index = 0 },
+	{ .hw = &clk_tpll.common.hw },
+	{ .hw = &clk_a0pll.common.hw },
+	{ .hw = &clk_mipimpll.common.hw },
+	{ .hw = &clk_mpll.common.hw },
+	{ .hw = &clk_fpll.common.hw },
+};
+
+static const s8 clk_a53_parent2sel[] = {
+	-1,	/* osc */
+	0,	/* mux 0: clk_tpll */
+	0,	/* mux 0: clk_a0pll */
+	0,	/* mux 0: clk_mipimpll */
+	0,	/* mux 0: clk_mpll */
+	1	/* mux 1: clk_fpll */
+};
+
+static const u8 clk_a53_sel2parent[2][4] = {
+	[0] = {
+		1,
+		2,
+		3,
+		4
+	},
+	[1] = {
+		5,
+		5,
+		5,
+		5
+	},
+};
+
+/*
+ * Clock for A53 cpu in the CV18XX/SG200X series.
+ * For CV180X and CV181X series, this clock is not used, but can not
+ * be set to bypass mode, or the SoC will hang.
+ */
+static CV1800_MMUX(clk_a53, clk_a53_parents,
+		   REG_CLK_EN_0, 0,
+		   REG_DIV_CLK_A53_0, 16, 4, 1, CV1800_DIV_FLAG,
+		   REG_DIV_CLK_A53_1, 16, 4, 2, CV1800_DIV_FLAG,
+		   REG_DIV_CLK_A53_0, 8, 2,
+		   REG_DIV_CLK_A53_1, 8, 2,
+		   REG_CLK_BYP_0, 0,
+		   REG_CLK_SEL_0, 0,
+		   clk_a53_parent2sel,
+		   clk_a53_sel2parent[0], clk_a53_sel2parent[1],
+		   CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
+
+static struct clk_hw_onecell_data cv1800_hw_clks = {
+	.num	= CV1800_CLK_MAX,
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
+	},
+};
+
+static void cv18xx_clk_disable_auto_pd(void __iomem *base)
+{
+	static const u16 CV1800_PD_CLK[] = {
+		REG_MIPIMPLL_CLK_CSR,
+		REG_A0PLL_CLK_CSR,
+		REG_DISPPLL_CLK_CSR,
+		REG_CAM0PLL_CLK_CSR,
+		REG_CAM1PLL_CLK_CSR,
+	};
+
+	u32 val;
+	int i;
+
+	/* disable auto power down */
+	for (i = 0; i < ARRAY_SIZE(CV1800_PD_CLK); i++) {
+		u32 reg = CV1800_PD_CLK[i];
+
+		val = readl(base + reg);
+		val |= GENMASK(12, 9);
+		val &= ~BIT(8);
+		writel(val, base + reg);
+	}
+}
+
+static void cv18xx_clk_disable_a53(void __iomem *base)
+{
+	u32 val = readl(base + REG_CLK_BYP_0);
+
+	/* Set bypass clock for clk_a53 */
+	val |= BIT(0);
+
+	/* Set bypass clock for clk_cpu_axi0 */
+	val |= BIT(1);
+
+	/* Set bypass clock for clk_cpu_gic */
+	val |= BIT(2);
+
+	writel(val, base + REG_CLK_BYP_0);
+}
+
+static int cv1800_pre_init(struct device *dev, void __iomem *base,
+			   struct cv1800_clk_ctrl *ctrl,
+			   const struct cv1800_clk_desc *desc)
+{
+	u32 val = readl(base + REG_CLK_EN_2);
+
+	/* disable unsupported clk_disp_src_vip */
+	val &= ~BIT(7);
+
+	writel(val, base + REG_CLK_EN_2);
+
+	cv18xx_clk_disable_a53(base);
+	cv18xx_clk_disable_auto_pd(base);
+
+	return 0;
+}
+
+static const struct cv1800_clk_desc cv1800_desc = {
+	.clks_data	= &cv1800_hw_clks,
+	.pre_init	= cv1800_pre_init,
+};
+
 static int cv1800_clk_init_ctrl(struct device *dev, void __iomem *reg,
 				struct cv1800_clk_ctrl *ctrl,
 				const struct cv1800_clk_desc *desc)
@@ -97,6 +1314,7 @@ static int cv1800_clk_probe(struct platform_device *pdev)
 }

 static const struct of_device_id cv1800_clk_ids[] = {
+	{ .compatible = "sophgo,cv1800-clk", .data = &cv1800_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, cv1800_clk_ids);
diff --git a/drivers/clk/sophgo/clk-cv1800.h b/drivers/clk/sophgo/clk-cv1800.h
new file mode 100644
index 000000000000..1b9c04b5ac3a
--- /dev/null
+++ b/drivers/clk/sophgo/clk-cv1800.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#ifndef _CLK_SOPHGO_CV1800_H_
+#define _CLK_SOPHGO_CV1800_H_
+
+#include <dt-bindings/clock/sophgo,cv1800.h>
+
+#define CV1800_CLK_MAX			(CLK_XTAL_AP + 1)
+
+#define REG_PLL_G2_CTRL			0x800
+#define REG_PLL_G2_STATUS		0x804
+#define REG_MIPIMPLL_CSR		0x808
+#define REG_A0PLL_CSR			0x80C
+#define REG_DISPPLL_CSR			0x810
+#define REG_CAM0PLL_CSR			0x814
+#define REG_CAM1PLL_CSR			0x818
+#define REG_PLL_G2_SSC_SYN_CTRL		0x840
+#define REG_A0PLL_SSC_SYN_CTRL		0x850
+#define REG_A0PLL_SSC_SYN_SET		0x854
+#define REG_A0PLL_SSC_SYN_SPAN		0x858
+#define REG_A0PLL_SSC_SYN_STEP		0x85C
+#define REG_DISPPLL_SSC_SYN_CTRL	0x860
+#define REG_DISPPLL_SSC_SYN_SET		0x864
+#define REG_DISPPLL_SSC_SYN_SPAN	0x868
+#define REG_DISPPLL_SSC_SYN_STEP	0x86C
+#define REG_CAM0PLL_SSC_SYN_CTRL	0x870
+#define REG_CAM0PLL_SSC_SYN_SET		0x874
+#define REG_CAM0PLL_SSC_SYN_SPAN	0x878
+#define REG_CAM0PLL_SSC_SYN_STEP	0x87C
+#define REG_CAM1PLL_SSC_SYN_CTRL	0x880
+#define REG_CAM1PLL_SSC_SYN_SET		0x884
+#define REG_CAM1PLL_SSC_SYN_SPAN	0x888
+#define REG_CAM1PLL_SSC_SYN_STEP	0x88C
+#define REG_APLL_FRAC_DIV_CTRL		0x890
+#define REG_APLL_FRAC_DIV_M		0x894
+#define REG_APLL_FRAC_DIV_N		0x898
+#define REG_MIPIMPLL_CLK_CSR		0x8A0
+#define REG_A0PLL_CLK_CSR		0x8A4
+#define REG_DISPPLL_CLK_CSR		0x8A8
+#define REG_CAM0PLL_CLK_CSR		0x8AC
+#define REG_CAM1PLL_CLK_CSR		0x8B0
+#define REG_CLK_CAM0_SRC_DIV		0x8C0
+#define REG_CLK_CAM1_SRC_DIV		0x8C4
+
+/* top_pll_g6 */
+#define REG_PLL_G6_CTRL			0x900
+#define REG_PLL_G6_STATUS		0x904
+#define REG_MPLL_CSR			0x908
+#define REG_TPLL_CSR			0x90C
+#define REG_FPLL_CSR			0x910
+#define REG_PLL_G6_SSC_SYN_CTRL		0x940
+#define REG_DPLL_SSC_SYN_CTRL		0x950
+#define REG_DPLL_SSC_SYN_SET		0x954
+#define REG_DPLL_SSC_SYN_SPAN		0x958
+#define REG_DPLL_SSC_SYN_STEP		0x95C
+#define REG_MPLL_SSC_SYN_CTRL		0x960
+#define REG_MPLL_SSC_SYN_SET		0x964
+#define REG_MPLL_SSC_SYN_SPAN		0x968
+#define REG_MPLL_SSC_SYN_STEP		0x96C
+#define REG_TPLL_SSC_SYN_CTRL		0x970
+#define REG_TPLL_SSC_SYN_SET		0x974
+#define REG_TPLL_SSC_SYN_SPAN		0x978
+#define REG_TPLL_SSC_SYN_STEP		0x97C
+
+/* clkgen */
+#define REG_CLK_EN_0			0x000
+#define REG_CLK_EN_1			0x004
+#define REG_CLK_EN_2			0x008
+#define REG_CLK_EN_3			0x00C
+#define REG_CLK_EN_4			0x010
+#define REG_CLK_SEL_0			0x020
+#define REG_CLK_BYP_0			0x030
+#define REG_CLK_BYP_1			0x034
+
+#define REG_DIV_CLK_A53_0		0x040
+#define REG_DIV_CLK_A53_1		0x044
+#define REG_DIV_CLK_CPU_AXI0		0x048
+#define REG_DIV_CLK_CPU_GIC		0x050
+#define REG_DIV_CLK_TPU			0x054
+#define REG_DIV_CLK_EMMC		0x064
+#define REG_DIV_CLK_EMMC_100K		0x06C
+#define REG_DIV_CLK_SD0			0x070
+#define REG_DIV_CLK_SD0_100K		0x078
+#define REG_DIV_CLK_SD1			0x07C
+#define REG_DIV_CLK_SD1_100K		0x084
+#define REG_DIV_CLK_SPI_NAND		0x088
+#define REG_DIV_CLK_ETH0_500M		0x08C
+#define REG_DIV_CLK_ETH1_500M		0x090
+#define REG_DIV_CLK_GPIO_DB		0x094
+#define REG_DIV_CLK_SDMA_AUD0		0x098
+#define REG_DIV_CLK_SDMA_AUD1		0x09C
+#define REG_DIV_CLK_SDMA_AUD2		0x0A0
+#define REG_DIV_CLK_SDMA_AUD3		0x0A4
+#define REG_DIV_CLK_CAM0_200		0x0A8
+#define REG_DIV_CLK_AXI4		0x0B8
+#define REG_DIV_CLK_AXI6		0x0BC
+#define REG_DIV_CLK_DSI_ESC		0x0C4
+#define REG_DIV_CLK_AXI_VIP		0x0C8
+#define REG_DIV_CLK_SRC_VIP_SYS_0	0x0D0
+#define REG_DIV_CLK_SRC_VIP_SYS_1	0x0D8
+#define REG_DIV_CLK_DISP_SRC_VIP	0x0E0
+#define REG_DIV_CLK_AXI_VIDEO_CODEC	0x0E4
+#define REG_DIV_CLK_VC_SRC0		0x0EC
+#define REG_DIV_CLK_1M			0x0FC
+#define REG_DIV_CLK_SPI			0x100
+#define REG_DIV_CLK_I2C			0x104
+#define REG_DIV_CLK_SRC_VIP_SYS_2	0x110
+#define REG_DIV_CLK_AUDSRC		0x118
+#define REG_DIV_CLK_PWM_SRC_0		0x120
+#define REG_DIV_CLK_AP_DEBUG		0x128
+#define REG_DIV_CLK_RTCSYS_SRC_0	0x12C
+#define REG_DIV_CLK_C906_0_0		0x130
+#define REG_DIV_CLK_C906_0_1		0x134
+#define REG_DIV_CLK_C906_1_0		0x138
+#define REG_DIV_CLK_C906_1_1		0x13C
+#define REG_DIV_CLK_SRC_VIP_SYS_3	0x140
+#define REG_DIV_CLK_SRC_VIP_SYS_4	0x144
+
+#endif /* _CLK_SOPHGO_CV1800_H_ */
--
2.43.1


