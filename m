Return-Path: <linux-kernel+bounces-57663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B684DBF0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FFE1F2260E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5901F6DD02;
	Thu,  8 Feb 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XM83+2Lq"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2017.outbound.protection.outlook.com [40.92.42.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69E6E2DE;
	Thu,  8 Feb 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382153; cv=fail; b=nG2AvCaRT+KO3FYU3PYGa5ZRjgeDz+0ejKlCVupvIZtm/kzCXtrdXUcXh3RAMAuu6Ug6QvTyvOPKn5XIGcGNmPmp82m/euyf8yKjhme1mexGTLClLrx9VHPRdG9cBN4KhnRZIKrnefFHNqC4MYr6zWkqViLP3axfUlmdaZXFYZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382153; c=relaxed/simple;
	bh=ejub+3iH5kAYj3xgpEJtaf4E3VuowN9V9RLWwv1VMjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BL3Q81TUA7fOb+374XZKh5apXfYFMhxFX+AerEWyq+kqua/TquCxdU28Fk8V1N3yof5qnB+vWZCE6CCVzvFI33YASifRtMED/eIK0bfMLa6f4ugbPNvuQiJkOltdXASIi9qcLzt0ezRaVIrsxbK4AD2+wSYRw4TuKddnL3rXg8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XM83+2Lq; arc=fail smtp.client-ip=40.92.42.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2M79xfPJ9qphGiAtDQYMjx/CdPnQaESydL55ezY1uaTTbIsE6DNRcgDSJZh4u8ZOhrnTsmxxLcOxrgIkbI4T5huwALb/pxuwwFuLXo6+jLix52s3PoFB2WTYGC87PylnjBhv7NlU5OQvvGghSa/wGBQSmHgtFF/VwtNMTKJtkNiP7r/sLNMYapIgy+cAjpRUrSvrat4vRmRZotxzwXiNcc17BqXmeKGYzHR0bn3/Y2V+kKpMy3L4ogjFCAVWU1DJWUZKMkbUoAiPoKrMwJTji8QneAjg/ih3UUGYP4/L44CT6E5ohkStIzgV5Tf9s3k827BZ/RU4iMkLrjWDBBz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RaCQlIfR6SKoXqzVm/xabl63e+kKEp2SUfSXCgEn70=;
 b=EgzW2czEGYvqRnmEYPCDhTvO8cRgWYhWc9kj0wmaQvljO8gao1XcnLoKiUt/JqWXmLtZ098UuZuW1m4yg9IGQg8nC0MBQ9+o7HhQLibldMfApyLdvNFHzx8gmjy0taDPLkU7Z9On+hb0nqEEjf6WkbueQYWlYjPImOPbkvioU/MOY+vrEUp3eFvbSkzyq8wPrnsFTJZ1DhkdxkD5bTiVdsYsJ0J1PDxmeqUs8bD6Ipnh83pzlOCaWD+JVyUK48JvAv8dF4n9EdUfbJ0om/HW6BVTnQI9cljn/LZyy/a4ryS6Y1czmtR1u7hm63bIeavlq9ZCmkg7WeKQ+TNHsFe/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RaCQlIfR6SKoXqzVm/xabl63e+kKEp2SUfSXCgEn70=;
 b=XM83+2LqkIJM5J/CoodORjWBHNuk4GKbYKbW+2n2hfehe8xBJ0LKVEqY1p2tV/C1sbW40zE28dULZyP74ez9ITaPAiyRO4d6xiYwEkZCDEEXYgzwlMIqOWeP+Ztx6C092BwaWsPTD1pwj6ki9uXEVRe8IK21IDpTJkkPwgXDal0/MYFH7fZOmbXz1B7gggLfGSfcVUT3UtWj5uTAu2QNfWSkDegF4+Wqp1fCp923s5Xxu1ZJf+2ie4RXwDHiyhIdYsZwSFvvKG6dP3PZ4dXxsjV1HoCHXjRmxzruHYk0zwSz+0KJjJRJTQfoK3kla/NjV8kfsdRlXOBoN8iVGouwaw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5985.namprd20.prod.outlook.com (2603:10b6:930:73::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 08:49:08 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 08:49:08 +0000
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
Subject: [PATCH v7 3/8] clk: sophgo: implement clk_ops for CV1800 series clock controller driver
Date: Thu,  8 Feb 2024 16:48:51 +0800
Message-ID:
 <IA1PR20MB49534558A17C332722AF5BC2BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49533B0C8B05FF5679E0C2F4BB442@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [PEynzEnP2ELR7y+tqWQ7xvFS7++wDEM5byC9bhh0xLSv2RnxwyJ6SEFSUX9jPHVE]
X-ClientProxiedBy: TYCP286CA0249.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240208084858.1113628-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: e682a34e-ba18-4fc7-847c-08dc2882cff9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fFlsUiNohDXwrlWTzBwK+HfmJMYsblruPvD1+xk/ZgAQW37ws8aTD8yzjgMak100G4v/6qgdvRetYbLyUDtlQtbDBHtQDb2ksMSAMOCdmfoeYU/ITYHLRgXVE0eu/v6Gf1Lsrte+uT0yoF5lELG1S7OI+SKJi01ApRA++TCE3gkcpd+BApkxw3fUuPgPR9EOQrFtTg4+GMCOoZI+asf+7I7Y9WUoeuEbjNwRGM8rjPSLnLx2BkYaxIGzMqutAmv1/a9JQuU9CZ75hmAaZgXkKg+1QcP+sXWfFZJ70b3+eI3XWfFv2wuLqmq0Mpz4EHI2lwRLpZ9YD4xTnWBc68q1I+yogoouXbgj3due2jFpdiUsChYMzmCYchcj31FMpvoJtzdsgVgqBJpQ7hmTjKUV9NiRoxgTQGD3MHVZra30CjLNW+DtTxQu6j/iDYx1aBBQYTQO996FqegF1BDHsbmKazpvRv+IPNlOE0pmCs8cfzTv+UuNrRpsgdrdLYh1/uycq4UjsZ7SNTp3GioPcJPhtPIi/EJiExfxkVuEwdvvhzZynad1948LueJ9wj1c3nBJAfFBo0fBbn861WnUiMBLtV1zEV+oYA4wP5Rvwjv9NnrgbJ7DKGeWI/a0HpHiSuMm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cIcIjttInc809vFMXO26UXGj8dGtYC/Sf9pbzBSI694WwiCn46mzM5XZJK2g?=
 =?us-ascii?Q?wsSpefSI3fr6LhUDd1ABRhUGIprQmJIggAPNpeuuutvsrF1zEeTYm6+gEo1+?=
 =?us-ascii?Q?NBl6pXlpUAbq+A9Tol/9DtOGBzRvpsXJ0nvG+frciy/8iBVw0H7++qpl5EEI?=
 =?us-ascii?Q?7IeTR8wJCzSzZ4avvi30ojFQxjODMlFOKrSkKz311NrbNs4M43MudcywoOQd?=
 =?us-ascii?Q?YXYT3TqUzvoinDLprK+KvFnpZx/yoYJLywCGPGfRE45IuMNI4Mjg9JkQlxJw?=
 =?us-ascii?Q?eV0HhVl2tlc1JFWzTxJ/Ozjxu98OX9OvLcAylBZ/A1N6PRgVdgMmMB8HSSVP?=
 =?us-ascii?Q?4YEg4xkWzLjNsf7V0fkJv3ShFf+KbLYXkMwCkbNMH93TrPLfyeXyQrisc2SD?=
 =?us-ascii?Q?7lTf/+Efu0iFlrcBAMdf4O28SEvMDZUEQ5tUhfRmqoUEmQcSPc60sGkpLhDV?=
 =?us-ascii?Q?SZiT2HAEHD4wXWvpye3B/Op9U9h8HmKiEExqFmqErDludLKjQ5QjthXN0YbZ?=
 =?us-ascii?Q?aJ3/42RBE+uXWH4RRL3M0Ccfdthz3xRXGbsPkJq1ELTdo5TpuNUWKvMtBxNy?=
 =?us-ascii?Q?+zBCaqGO0RcGPrs+YKGKEj1MRp6x8PSr4MX8LdwBf8QuKA1TohJuurJ3gvfH?=
 =?us-ascii?Q?/GprThjELuIZKm1MktqC/JyiXv3arE76ETJ/oYcIjMbsWBg7vw1d6xI/uMbF?=
 =?us-ascii?Q?M60pv5y5lenDZH5Xvsq1UTTHcTEd1xl9ktvpx0BdPvfA5aPSU9B1ivrGw0ev?=
 =?us-ascii?Q?vTceJlZRuWos6srpF0ImoXJWMSD3nF2bPCzA82Mi7DxReMgFfHAZaj1MMf/F?=
 =?us-ascii?Q?Or/zWnMH99huhumr84E4Y/T/t098H5FbxLaePK5W4UaoN+VwKBfHnSvr8+4n?=
 =?us-ascii?Q?fC4ap3cAfJ4X+a2azuHrcCpiJyhxQpT3yTBavKQ8i88kg97nFtx4d4tDu4qS?=
 =?us-ascii?Q?XUK9ofNHoc0c6KEkO3FcZSz4JzPa/eVnK4hQGTgprfhU8BwQkAkBc1tlWRvV?=
 =?us-ascii?Q?67GKtMpnj7eUQ+q5EdEfrW5xNlqYezqTm315Nz4YqLI0soh81RwCuVhpxNpB?=
 =?us-ascii?Q?9XMUhXa4MFytWXSx3UvWDzouky50giYZQheZlYGAfCX8ENoMdyeZ36sLJ3ps?=
 =?us-ascii?Q?uD+bIQbak9PXis2znYXR/c0Fq3xVg+g8CKR+cEfIsCX4HndjQPAq164usshG?=
 =?us-ascii?Q?Bem1lVuptAsxRIbEgvu5OC6tUXTgkQIeTPo7MO7O9l99UwYO1NewqNvv75lD?=
 =?us-ascii?Q?qjDCyd4tyG1M7FZeYjYgVHLTuJx8GkKbR8Olcu+aKw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e682a34e-ba18-4fc7-847c-08dc2882cff9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 08:49:08.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5985

Add clk_ops implement of pll and ip clocks for the clock controller.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/milkv-duo/duo-files/blob/6f4e9b8ecb459e017cca1a8df248a19ca70837a3/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
---
 drivers/clk/sophgo/clk-cv18xx-ip.c  | 889 ++++++++++++++++++++++++++--
 drivers/clk/sophgo/clk-cv18xx-pll.c | 414 ++++++++++++-
 2 files changed, 1239 insertions(+), 64 deletions(-)

diff --git a/drivers/clk/sophgo/clk-cv18xx-ip.c b/drivers/clk/sophgo/clk-cv18xx-ip.c
index cd397d102442..5ffe2a4c6394 100644
--- a/drivers/clk/sophgo/clk-cv18xx-ip.c
+++ b/drivers/clk/sophgo/clk-cv18xx-ip.c
@@ -11,88 +11,877 @@
 #include "clk-cv18xx-ip.h"

 /* GATE */
+static inline struct cv1800_clk_gate *hw_to_cv1800_clk_gate(struct clk_hw *hw)
+{
+	struct cv1800_clk_common *common = hw_to_cv1800_clk_common(hw);
+
+	return container_of(common, struct cv1800_clk_gate, common);
+}
+
+static int gate_enable(struct clk_hw *hw)
+{
+	struct cv1800_clk_gate *gate = hw_to_cv1800_clk_gate(hw);
+
+	return cv1800_clk_setbit(&gate->common, &gate->gate);
+}
+
+static void gate_disable(struct clk_hw *hw)
+{
+	struct cv1800_clk_gate *gate = hw_to_cv1800_clk_gate(hw);
+
+	cv1800_clk_clearbit(&gate->common, &gate->gate);
+}
+
+static int gate_is_enabled(struct clk_hw *hw)
+{
+	struct cv1800_clk_gate *gate = hw_to_cv1800_clk_gate(hw);
+
+	return cv1800_clk_checkbit(&gate->common, &gate->gate);
+}
+
+static unsigned long gate_recalc_rate(struct clk_hw *hw,
+				      unsigned long parent_rate)
+{
+	return parent_rate;
+}
+
+static long gate_round_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long *parent_rate)
+{
+	return *parent_rate;
+}
+
+static int gate_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	return 0;
+}
+
 const struct clk_ops cv1800_clk_gate_ops = {
-	.disable = NULL,
-	.enable = NULL,
-	.is_enabled = NULL,
+	.disable = gate_disable,
+	.enable = gate_enable,
+	.is_enabled = gate_is_enabled,

-	.recalc_rate = NULL,
-	.round_rate = NULL,
-	.set_rate = NULL,
+	.recalc_rate = gate_recalc_rate,
+	.round_rate = gate_round_rate,
+	.set_rate = gate_set_rate,
 };

 /* DIV */
+#define _DIV_EN_CLK_DIV_FACTOR_FIELD		BIT(3)
+
+#define DIV_GET_EN_CLK_DIV_FACTOR(_reg) \
+	FIELD_GET(_DIV_EN_CLK_DIV_FACTOR_FIELD, _reg)
+
+#define DIV_SET_EN_DIV_FACTOR(_reg) \
+	_CV1800_SET_FIELD(_reg, 1, _DIV_EN_CLK_DIV_FACTOR_FIELD)
+
+static inline struct cv1800_clk_div *hw_to_cv1800_clk_div(struct clk_hw *hw)
+{
+	struct cv1800_clk_common *common = hw_to_cv1800_clk_common(hw);
+
+	return container_of(common, struct cv1800_clk_div, common);
+}
+
+static int div_enable(struct clk_hw *hw)
+{
+	struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
+
+	return cv1800_clk_setbit(&div->common, &div->gate);
+}
+
+static void div_disable(struct clk_hw *hw)
+{
+	struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
+
+	cv1800_clk_clearbit(&div->common, &div->gate);
+}
+
+static int div_is_enabled(struct clk_hw *hw)
+{
+	struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
+
+	return cv1800_clk_checkbit(&div->common, &div->gate);
+}
+
+static int div_helper_set_rate(struct cv1800_clk_common *common,
+			       struct cv1800_clk_regfield *div,
+			       unsigned long val)
+{
+	unsigned long flags;
+	u32 reg;
+
+	if (div->width == 0)
+		return 0;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	reg = readl(common->base + div->reg);
+	reg = cv1800_clk_regfield_set(reg, val, div);
+	if (div->initval > 0)
+		reg = DIV_SET_EN_DIV_FACTOR(reg);
+
+	writel(reg, common->base + div->reg);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+}
+
+static u32 div_helper_get_clockdiv(struct cv1800_clk_common *common,
+				   struct cv1800_clk_regfield *div)
+{
+	u32 clockdiv = 1;
+	u32 reg;
+
+	if (!div || div->initval < 0 || (div->width == 0 && div->initval <= 0))
+		return 1;
+
+	if (div->width == 0 && div->initval > 0)
+		return div->initval;
+
+	reg = readl(common->base + div->reg);
+
+	if (div->initval == 0 || DIV_GET_EN_CLK_DIV_FACTOR(reg))
+		clockdiv = cv1800_clk_regfield_get(reg, div);
+	else if (div->initval > 0)
+		clockdiv = div->initval;
+
+	return clockdiv;
+}
+
+static u32 div_helper_round_rate(struct cv1800_clk_regfield *div,
+				 struct clk_hw *hw, struct clk_hw *parent,
+				 unsigned long rate, unsigned long *prate)
+{
+	if (div->width == 0) {
+		if (div->initval <= 0)
+			return DIV_ROUND_UP_ULL(*prate, 1);
+		else
+			return DIV_ROUND_UP_ULL(*prate, div->initval);
+	}
+
+	return divider_round_rate_parent(hw, parent, rate, prate, NULL,
+					 div->width, div->flags);
+}
+
+static long div_round_rate(struct clk_hw *parent, unsigned long *parent_rate,
+			   unsigned long rate, int id, void *data)
+{
+	struct cv1800_clk_div *div = data;
+
+	return div_helper_round_rate(&div->div, &div->common.hw, parent,
+				     rate, parent_rate);
+}
+
+static bool div_is_better_rate(struct cv1800_clk_common *common,
+			       unsigned long target, unsigned long now,
+			       unsigned long best)
+{
+	if (common->features & CLK_DIVIDER_ROUND_CLOSEST)
+		return abs_diff(target, now) < abs_diff(target, best);
+
+	return now <= target && now > best;
+}
+
+static int mux_helper_determine_rate(struct cv1800_clk_common *common,
+				     struct clk_rate_request *req,
+				     long (*round)(struct clk_hw *,
+						   unsigned long *,
+						   unsigned long,
+						   int,
+						   void *),
+				     void *data)
+{
+	unsigned long best_parent_rate = 0, best_rate = 0;
+	struct clk_hw *best_parent, *hw = &common->hw;
+	unsigned int i;
+
+	if (clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT) {
+		unsigned long adj_parent_rate;
+
+		best_parent = clk_hw_get_parent(hw);
+		best_parent_rate = clk_hw_get_rate(best_parent);
+
+		best_rate = round(best_parent, &adj_parent_rate,
+				  req->rate, -1, data);
+
+		goto find;
+	}
+
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+		unsigned long tmp_rate, parent_rate;
+		struct clk_hw *parent;
+
+		parent = clk_hw_get_parent_by_index(hw, i);
+		if (!parent)
+			continue;
+
+		parent_rate = clk_hw_get_rate(parent);
+
+		tmp_rate = round(parent, &parent_rate, req->rate, i, data);
+
+		if (tmp_rate == req->rate) {
+			best_parent = parent;
+			best_parent_rate = parent_rate;
+			best_rate = tmp_rate;
+			goto find;
+		}
+
+		if (div_is_better_rate(common, req->rate,
+				       tmp_rate, best_rate)) {
+			best_parent = parent;
+			best_parent_rate = parent_rate;
+			best_rate = tmp_rate;
+		}
+	}
+
+	if (best_rate == 0)
+		return -EINVAL;
+
+find:
+	req->best_parent_hw = best_parent;
+	req->best_parent_rate = best_parent_rate;
+	req->rate = best_rate;
+	return 0;
+}
+
+static int div_determine_rate(struct clk_hw *hw,
+			      struct clk_rate_request *req)
+{
+	struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
+
+	return mux_helper_determine_rate(&div->common, req,
+					 div_round_rate, div);
+}
+
+static unsigned long div_recalc_rate(struct clk_hw *hw,
+				     unsigned long parent_rate)
+{
+	struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
+	unsigned long val;
+
+	val = div_helper_get_clockdiv(&div->common, &div->div);
+	if (val == 0)
+		return 0;
+
+	return divider_recalc_rate(hw, parent_rate, val, NULL,
+				   div->div.flags, div->div.width);
+}
+
+static int div_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
+	unsigned long val;
+
+	val = divider_get_val(rate, parent_rate, NULL,
+			      div->div.width, div->div.flags);
+
+	return div_helper_set_rate(&div->common, &div->div, val);
+}
+
 const struct clk_ops cv1800_clk_div_ops = {
-	.disable = NULL,
-	.enable = NULL,
-	.is_enabled = NULL,
+	.disable = div_disable,
+	.enable = div_enable,
+	.is_enabled = div_is_enabled,

-	.determine_rate = NULL,
-	.recalc_rate	= NULL,
-	.set_rate = NULL,
+	.determine_rate = div_determine_rate,
+	.recalc_rate	= div_recalc_rate,
+	.set_rate = div_set_rate,
 };

+static inline struct cv1800_clk_bypass_div *
+hw_to_cv1800_clk_bypass_div(struct clk_hw *hw)
+{
+	struct cv1800_clk_div *div = hw_to_cv1800_clk_div(hw);
+
+	return container_of(div, struct cv1800_clk_bypass_div, div);
+}
+
+static long bypass_div_round_rate(struct clk_hw *parent,
+				  unsigned long *parent_rate,
+				  unsigned long rate, int id, void *data)
+{
+	struct cv1800_clk_bypass_div *div = data;
+
+	if (id == -1) {
+		if (cv1800_clk_checkbit(&div->div.common, &div->bypass))
+			return *parent_rate;
+		else
+			return div_round_rate(parent, parent_rate, rate,
+					      -1, &div->div);
+	}
+
+	if (id == 0)
+		return *parent_rate;
+
+	return div_round_rate(parent, parent_rate, rate, id - 1, &div->div);
+}
+
+static int bypass_div_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
+{
+	struct cv1800_clk_bypass_div *div = hw_to_cv1800_clk_bypass_div(hw);
+
+	return mux_helper_determine_rate(&div->div.common, req,
+					 bypass_div_round_rate, div);
+}
+
+static unsigned long bypass_div_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct cv1800_clk_bypass_div *div = hw_to_cv1800_clk_bypass_div(hw);
+
+	if (cv1800_clk_checkbit(&div->div.common, &div->bypass))
+		return parent_rate;
+
+	return div_recalc_rate(hw, parent_rate);
+}
+
+static int bypass_div_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct cv1800_clk_bypass_div *div = hw_to_cv1800_clk_bypass_div(hw);
+
+	if (cv1800_clk_checkbit(&div->div.common, &div->bypass))
+		return 0;
+
+	return div_set_rate(hw, rate, parent_rate);
+}
+
+static u8 bypass_div_get_parent(struct clk_hw *hw)
+{
+	struct cv1800_clk_bypass_div *div = hw_to_cv1800_clk_bypass_div(hw);
+
+	if (cv1800_clk_checkbit(&div->div.common, &div->bypass))
+		return 0;
+
+	return 1;
+}
+
+static int bypass_div_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct cv1800_clk_bypass_div *div = hw_to_cv1800_clk_bypass_div(hw);
+
+	if (index)
+		return cv1800_clk_clearbit(&div->div.common, &div->bypass);
+
+	return cv1800_clk_setbit(&div->div.common, &div->bypass);
+}
+
 const struct clk_ops cv1800_clk_bypass_div_ops = {
-	.disable = NULL,
-	.enable = NULL,
-	.is_enabled = NULL,
+	.disable = div_disable,
+	.enable = div_enable,
+	.is_enabled = div_is_enabled,

-	.determine_rate = NULL,
-	.recalc_rate = NULL,
-	.set_rate = NULL,
+	.determine_rate = bypass_div_determine_rate,
+	.recalc_rate = bypass_div_recalc_rate,
+	.set_rate = bypass_div_set_rate,

-	.set_parent = NULL,
-	.get_parent = NULL,
+	.set_parent = bypass_div_set_parent,
+	.get_parent = bypass_div_get_parent,
 };

 /* MUX */
+static inline struct cv1800_clk_mux *hw_to_cv1800_clk_mux(struct clk_hw *hw)
+{
+	struct cv1800_clk_common *common = hw_to_cv1800_clk_common(hw);
+
+	return container_of(common, struct cv1800_clk_mux, common);
+}
+
+static int mux_enable(struct clk_hw *hw)
+{
+	struct cv1800_clk_mux *mux = hw_to_cv1800_clk_mux(hw);
+
+	return cv1800_clk_setbit(&mux->common, &mux->gate);
+}
+
+static void mux_disable(struct clk_hw *hw)
+{
+	struct cv1800_clk_mux *mux = hw_to_cv1800_clk_mux(hw);
+
+	cv1800_clk_clearbit(&mux->common, &mux->gate);
+}
+
+static int mux_is_enabled(struct clk_hw *hw)
+{
+	struct cv1800_clk_mux *mux = hw_to_cv1800_clk_mux(hw);
+
+	return cv1800_clk_checkbit(&mux->common, &mux->gate);
+}
+
+static long mux_round_rate(struct clk_hw *parent, unsigned long *parent_rate,
+			   unsigned long rate, int id, void *data)
+{
+	struct cv1800_clk_mux *mux = data;
+
+	return div_helper_round_rate(&mux->div, &mux->common.hw, parent,
+				     rate, parent_rate);
+}
+
+static int mux_determine_rate(struct clk_hw *hw,
+			      struct clk_rate_request *req)
+{
+	struct cv1800_clk_mux *mux = hw_to_cv1800_clk_mux(hw);
+
+	return mux_helper_determine_rate(&mux->common, req,
+					 mux_round_rate, mux);
+}
+
+static unsigned long mux_recalc_rate(struct clk_hw *hw,
+				     unsigned long parent_rate)
+{
+	struct cv1800_clk_mux *mux = hw_to_cv1800_clk_mux(hw);
+	unsigned long val;
+
+	val = div_helper_get_clockdiv(&mux->common, &mux->div);
+	if (val == 0)
+		return 0;
+
+	return divider_recalc_rate(hw, parent_rate, val, NULL,
+				   mux->div.flags, mux->div.width);
+}
+
+static int mux_set_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long parent_rate)
+{
+	struct cv1800_clk_mux *mux = hw_to_cv1800_clk_mux(hw);
+	unsigned long val;
+
+	val = divider_get_val(rate, parent_rate, NULL,
+			      mux->div.width, mux->div.flags);
+
+	return div_helper_set_rate(&mux->common, &mux->div, val);
+}
+
+static u8 mux_get_parent(struct clk_hw *hw)
+{
+	struct cv1800_clk_mux *mux = hw_to_cv1800_clk_mux(hw);
+	u32 reg = readl(mux->common.base + mux->mux.reg);
+
+	return cv1800_clk_regfield_get(reg, &mux->mux);
+}
+
+static int _mux_set_parent(struct cv1800_clk_mux *mux, u8 index)
+{
+	u32 reg;
+
+	reg = readl(mux->common.base + mux->mux.reg);
+	reg = cv1800_clk_regfield_set(reg, index, &mux->mux);
+	writel(reg, mux->common.base + mux->mux.reg);
+
+	return 0;
+}
+
+static int mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct cv1800_clk_mux *mux = hw_to_cv1800_clk_mux(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(mux->common.lock, flags);
+
+	_mux_set_parent(mux, index);
+
+	spin_unlock_irqrestore(mux->common.lock, flags);
+
+	return 0;
+}
+
 const struct clk_ops cv1800_clk_mux_ops = {
-	.disable = NULL,
-	.enable = NULL,
-	.is_enabled = NULL,
+	.disable = mux_disable,
+	.enable = mux_enable,
+	.is_enabled = mux_is_enabled,

-	.determine_rate = NULL,
-	.recalc_rate = NULL,
-	.set_rate = NULL,
+	.determine_rate = mux_determine_rate,
+	.recalc_rate = mux_recalc_rate,
+	.set_rate = mux_set_rate,

-	.set_parent = NULL,
-	.get_parent = NULL,
+	.set_parent = mux_set_parent,
+	.get_parent = mux_get_parent,
 };

+static inline struct cv1800_clk_bypass_mux *
+hw_to_cv1800_clk_bypass_mux(struct clk_hw *hw)
+{
+	struct cv1800_clk_mux *mux = hw_to_cv1800_clk_mux(hw);
+
+	return container_of(mux, struct cv1800_clk_bypass_mux, mux);
+}
+
+static long bypass_mux_round_rate(struct clk_hw *parent,
+				  unsigned long *parent_rate,
+				  unsigned long rate, int id, void *data)
+{
+	struct cv1800_clk_bypass_mux *mux = data;
+
+	if (id == -1) {
+		if (cv1800_clk_checkbit(&mux->mux.common, &mux->bypass))
+			return *parent_rate;
+		else
+			return mux_round_rate(parent, parent_rate, rate,
+					      -1, &mux->mux);
+	}
+
+	if (id == 0)
+		return *parent_rate;
+
+	return mux_round_rate(parent, parent_rate, rate, id - 1, &mux->mux);
+}
+
+static int bypass_mux_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
+{
+	struct cv1800_clk_bypass_mux *mux = hw_to_cv1800_clk_bypass_mux(hw);
+
+	return mux_helper_determine_rate(&mux->mux.common, req,
+					 bypass_mux_round_rate, mux);
+}
+
+static unsigned long bypass_mux_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct cv1800_clk_bypass_mux *mux = hw_to_cv1800_clk_bypass_mux(hw);
+
+	if (cv1800_clk_checkbit(&mux->mux.common, &mux->bypass))
+		return parent_rate;
+
+	return mux_recalc_rate(hw, parent_rate);
+}
+
+static int bypass_mux_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct cv1800_clk_bypass_mux *mux = hw_to_cv1800_clk_bypass_mux(hw);
+
+	if (cv1800_clk_checkbit(&mux->mux.common, &mux->bypass))
+		return 0;
+
+	return mux_set_rate(hw, rate, parent_rate);
+}
+
+static u8 bypass_mux_get_parent(struct clk_hw *hw)
+{
+	struct cv1800_clk_bypass_mux *mux = hw_to_cv1800_clk_bypass_mux(hw);
+
+	if (cv1800_clk_checkbit(&mux->mux.common, &mux->bypass))
+		return 0;
+
+	return mux_get_parent(hw) + 1;
+}
+
+static int bypass_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct cv1800_clk_bypass_mux *mux = hw_to_cv1800_clk_bypass_mux(hw);
+
+	if (index == 0)
+		return cv1800_clk_setbit(&mux->mux.common, &mux->bypass);
+
+	return cv1800_clk_clearbit(&mux->mux.common, &mux->bypass);
+}
+
 const struct clk_ops cv1800_clk_bypass_mux_ops = {
-	.disable = NULL,
-	.enable = NULL,
-	.is_enabled = NULL,
+	.disable = mux_disable,
+	.enable = mux_enable,
+	.is_enabled = mux_is_enabled,

-	.determine_rate = NULL,
-	.recalc_rate = NULL,
-	.set_rate = NULL,
+	.determine_rate = bypass_mux_determine_rate,
+	.recalc_rate = bypass_mux_recalc_rate,
+	.set_rate = bypass_mux_set_rate,

-	.set_parent = NULL,
-	.get_parent = NULL,
+	.set_parent = bypass_mux_set_parent,
+	.get_parent = bypass_mux_get_parent,
 };

 /* MMUX */
+static inline struct cv1800_clk_mmux *hw_to_cv1800_clk_mmux(struct clk_hw *hw)
+{
+	struct cv1800_clk_common *common = hw_to_cv1800_clk_common(hw);
+
+	return container_of(common, struct cv1800_clk_mmux, common);
+}
+
+static u8 mmux_get_parent_id(struct cv1800_clk_mmux *mmux)
+{
+	struct clk_hw *hw = &mmux->common.hw;
+	struct clk_hw *parent = clk_hw_get_parent(hw);
+	unsigned int i;
+
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+		if (parent == clk_hw_get_parent_by_index(hw, i))
+			return i;
+	}
+
+	unreachable();
+}
+
+static int mmux_enable(struct clk_hw *hw)
+{
+	struct cv1800_clk_mmux *mmux = hw_to_cv1800_clk_mmux(hw);
+
+	return cv1800_clk_setbit(&mmux->common, &mmux->gate);
+}
+
+static void mmux_disable(struct clk_hw *hw)
+{
+	struct cv1800_clk_mmux *mmux = hw_to_cv1800_clk_mmux(hw);
+
+	cv1800_clk_clearbit(&mmux->common, &mmux->gate);
+}
+
+static int mmux_is_enabled(struct clk_hw *hw)
+{
+	struct cv1800_clk_mmux *mmux = hw_to_cv1800_clk_mmux(hw);
+
+	return cv1800_clk_checkbit(&mmux->common, &mmux->gate);
+}
+
+static long mmux_round_rate(struct clk_hw *parent, unsigned long *parent_rate,
+			    unsigned long rate, int id, void *data)
+{
+	struct cv1800_clk_mmux *mmux = data;
+	s8 div_id;
+
+	if (id == -1) {
+		if (cv1800_clk_checkbit(&mmux->common, &mmux->bypass))
+			return *parent_rate;
+
+		id = mmux_get_parent_id(mmux);
+	}
+
+	div_id = mmux->parent2sel[id];
+
+	if (div_id < 0)
+		return *parent_rate;
+
+	return div_helper_round_rate(&mmux->div[div_id],
+				     &mmux->common.hw, parent,
+				     rate, parent_rate);
+}
+
+static int mmux_determine_rate(struct clk_hw *hw,
+			       struct clk_rate_request *req)
+{
+	struct cv1800_clk_mmux *mmux = hw_to_cv1800_clk_mmux(hw);
+
+	return mux_helper_determine_rate(&mmux->common, req,
+					 mmux_round_rate, mmux);
+}
+
+static unsigned long mmux_recalc_rate(struct clk_hw *hw,
+				      unsigned long parent_rate)
+{
+	struct cv1800_clk_mmux *mmux = hw_to_cv1800_clk_mmux(hw);
+	unsigned long val;
+	struct cv1800_clk_regfield *div;
+
+	if (cv1800_clk_checkbit(&mmux->common, &mmux->bypass))
+		return parent_rate;
+
+	if (cv1800_clk_checkbit(&mmux->common, &mmux->clk_sel))
+		div = &mmux->div[0];
+	else
+		div = &mmux->div[1];
+
+	val = div_helper_get_clockdiv(&mmux->common, div);
+	if (val == 0)
+		return 0;
+
+	return divider_recalc_rate(hw, parent_rate, val, NULL,
+				   div->flags, div->width);
+}
+
+static int mmux_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	struct cv1800_clk_mmux *mmux = hw_to_cv1800_clk_mmux(hw);
+	struct cv1800_clk_regfield *div;
+	unsigned long val;
+
+	if (cv1800_clk_checkbit(&mmux->common, &mmux->bypass))
+		return parent_rate;
+
+	if (cv1800_clk_checkbit(&mmux->common, &mmux->clk_sel))
+		div = &mmux->div[0];
+	else
+		div = &mmux->div[1];
+
+	val = divider_get_val(rate, parent_rate, NULL,
+			      div->width, div->flags);
+
+	return div_helper_set_rate(&mmux->common, div, val);
+}
+
+static u8 mmux_get_parent(struct clk_hw *hw)
+{
+	struct cv1800_clk_mmux *mmux = hw_to_cv1800_clk_mmux(hw);
+	struct cv1800_clk_regfield *mux;
+	u32 reg;
+	s8 clk_sel;
+
+	if (cv1800_clk_checkbit(&mmux->common, &mmux->bypass))
+		return 0;
+
+	if (cv1800_clk_checkbit(&mmux->common, &mmux->clk_sel))
+		clk_sel = 0;
+	else
+		clk_sel = 1;
+	mux = &mmux->mux[clk_sel];
+
+	reg = readl(mmux->common.base + mux->reg);
+
+	return mmux->sel2parent[clk_sel][cv1800_clk_regfield_get(reg, mux)];
+}
+
+static int mmux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct cv1800_clk_mmux *mmux = hw_to_cv1800_clk_mmux(hw);
+	struct cv1800_clk_regfield *mux;
+	unsigned long flags;
+	u32 reg;
+	s8 clk_sel = mmux->parent2sel[index];
+
+	if (index == 0 || clk_sel == -1) {
+		cv1800_clk_setbit(&mmux->common, &mmux->bypass);
+		goto release;
+	}
+
+	cv1800_clk_clearbit(&mmux->common, &mmux->bypass);
+
+	if (clk_sel)
+		cv1800_clk_clearbit(&mmux->common, &mmux->clk_sel);
+	else
+		cv1800_clk_setbit(&mmux->common, &mmux->clk_sel);
+
+	spin_lock_irqsave(mmux->common.lock, flags);
+
+	mux = &mmux->mux[clk_sel];
+	reg = readl(mmux->common.base + mux->reg);
+	reg = cv1800_clk_regfield_set(reg, index, mux);
+
+	writel(reg, mmux->common.base + mux->reg);
+
+release:
+	spin_unlock_irqrestore(mmux->common.lock, flags);
+
+	return 0;
+}
+
 const struct clk_ops cv1800_clk_mmux_ops = {
-	.disable = NULL,
-	.enable = NULL,
-	.is_enabled = NULL,
+	.disable = mmux_disable,
+	.enable = mmux_enable,
+	.is_enabled = mmux_is_enabled,

-	.determine_rate = NULL,
-	.recalc_rate = NULL,
-	.set_rate = NULL,
+	.determine_rate = mmux_determine_rate,
+	.recalc_rate = mmux_recalc_rate,
+	.set_rate = mmux_set_rate,

-	.set_parent = NULL,
-	.get_parent = NULL,
+	.set_parent = mmux_set_parent,
+	.get_parent = mmux_get_parent,
 };

 /* AUDIO CLK */
+static inline struct cv1800_clk_audio *
+hw_to_cv1800_clk_audio(struct clk_hw *hw)
+{
+	struct cv1800_clk_common *common = hw_to_cv1800_clk_common(hw);
+
+	return container_of(common, struct cv1800_clk_audio, common);
+}
+
+static int aclk_enable(struct clk_hw *hw)
+{
+	struct cv1800_clk_audio *aclk = hw_to_cv1800_clk_audio(hw);
+
+	cv1800_clk_setbit(&aclk->common, &aclk->src_en);
+	return cv1800_clk_setbit(&aclk->common, &aclk->output_en);
+}
+
+static void aclk_disable(struct clk_hw *hw)
+{
+	struct cv1800_clk_audio *aclk = hw_to_cv1800_clk_audio(hw);
+
+	cv1800_clk_clearbit(&aclk->common, &aclk->output_en);
+	cv1800_clk_clearbit(&aclk->common, &aclk->src_en);
+}
+
+static int aclk_is_enabled(struct clk_hw *hw)
+{
+	struct cv1800_clk_audio *aclk = hw_to_cv1800_clk_audio(hw);
+
+	return cv1800_clk_checkbit(&aclk->common, &aclk->output_en);
+}
+
+static int aclk_determine_rate(struct clk_hw *hw,
+			       struct clk_rate_request *req)
+{
+	struct cv1800_clk_audio *aclk = hw_to_cv1800_clk_audio(hw);
+
+	req->rate = aclk->target_rate;
+
+	return 0;
+}
+
+static unsigned long aclk_recalc_rate(struct clk_hw *hw,
+				      unsigned long parent_rate)
+{
+	struct cv1800_clk_audio *aclk = hw_to_cv1800_clk_audio(hw);
+	u64 rate = parent_rate;
+	u64 factor = 2;
+	u32 regval;
+
+	if (!cv1800_clk_checkbit(&aclk->common, &aclk->div_en))
+		return 0;
+
+	regval = readl(aclk->common.base + aclk->m.reg);
+	factor *= cv1800_clk_regfield_get(regval, &aclk->m);
+
+	regval = readl(aclk->common.base + aclk->n.reg);
+	rate *= cv1800_clk_regfield_get(regval, &aclk->n);
+
+	return DIV64_U64_ROUND_UP(rate, factor);
+}
+
+static void aclk_determine_mn(unsigned long parent_rate, unsigned long rate,
+			      u32 *m, u32 *n)
+{
+	u32 tm = parent_rate / 2;
+	u32 tn = rate;
+	u32 tcommon = gcd(tm, tn);
+	*m = tm / tcommon;
+	*n = tn / tcommon;
+}
+
+static int aclk_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	struct cv1800_clk_audio *aclk = hw_to_cv1800_clk_audio(hw);
+	unsigned long flags;
+	u32 m, n;
+
+	aclk_determine_mn(parent_rate, rate,
+			  &m, &n);
+
+	spin_lock_irqsave(aclk->common.lock, flags);
+
+	writel(m, aclk->common.base + aclk->m.reg);
+	writel(n, aclk->common.base + aclk->n.reg);
+
+	cv1800_clk_setbit(&aclk->common, &aclk->div_en);
+	cv1800_clk_setbit(&aclk->common, &aclk->div_up);
+
+	spin_unlock_irqrestore(aclk->common.lock, flags);
+
+	return 0;
+}
+
 const struct clk_ops cv1800_clk_audio_ops = {
-	.disable = NULL,
-	.enable = NULL,
-	.is_enabled = NULL,
+	.disable = aclk_disable,
+	.enable = aclk_enable,
+	.is_enabled = aclk_is_enabled,

-	.determine_rate = NULL,
-	.recalc_rate = NULL,
-	.set_rate = NULL,
+	.determine_rate = aclk_determine_rate,
+	.recalc_rate = aclk_recalc_rate,
+	.set_rate = aclk_set_rate,
 };
diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
index 345bb5e27cfd..ee5a289d39cc 100644
--- a/drivers/clk/sophgo/clk-cv18xx-pll.c
+++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
@@ -10,25 +10,411 @@

 #include "clk-cv18xx-pll.h"

+static inline struct cv1800_clk_pll *hw_to_cv1800_clk_pll(struct clk_hw *hw)
+{
+	struct cv1800_clk_common *common = hw_to_cv1800_clk_common(hw);
+
+	return container_of(common, struct cv1800_clk_pll, common);
+}
+
+static unsigned long ipll_calc_rate(unsigned long parent_rate,
+				    unsigned long pre_div_sel,
+				    unsigned long div_sel,
+				    unsigned long post_div_sel)
+{
+	unsigned long rate = parent_rate;
+
+	rate *= div_sel;
+	do_div(rate, pre_div_sel * post_div_sel);
+
+	return rate;
+}
+
+static unsigned long ipll_recalc_rate(struct clk_hw *hw,
+				      unsigned long parent_rate)
+{
+	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
+	u32 value;
+
+	value = readl(pll->common.base + pll->pll_reg);
+
+	return ipll_calc_rate(parent_rate,
+			      PLL_GET_PRE_DIV_SEL(value),
+			      PLL_GET_DIV_SEL(value),
+			      PLL_GET_POST_DIV_SEL(value));
+}
+
+static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
+			  unsigned long prate, unsigned long *rate,
+			  u32 *value)
+{
+	unsigned long best_rate = 0;
+	unsigned long trate = *rate;
+	unsigned long pre_div_sel = 0, div_sel = 0, post_div_sel = 0;
+	unsigned long pre, div, post;
+	u32 detected = *value;
+	unsigned long tmp;
+
+	for_each_pll_limit_range(pre, &limit->pre_div) {
+		for_each_pll_limit_range(div, &limit->div) {
+			for_each_pll_limit_range(post, &limit->post_div) {
+				tmp = ipll_calc_rate(prate, pre, div, post);
+
+				if (tmp > trate)
+					continue;
+
+				if ((trate - tmp) < (trate - best_rate)) {
+					best_rate = tmp;
+					pre_div_sel = pre;
+					div_sel = div;
+					post_div_sel = post;
+				}
+			}
+		}
+	}
+
+	if (best_rate) {
+		detected = PLL_SET_PRE_DIV_SEL(detected, pre_div_sel);
+		detected = PLL_SET_POST_DIV_SEL(detected, post_div_sel);
+		detected = PLL_SET_DIV_SEL(detected, div_sel);
+		*value = detected;
+		*rate = best_rate;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ipll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	u32 val;
+	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
+
+	return ipll_find_rate(pll->pll_limit, req->best_parent_rate,
+			      &req->rate, &val);
+}
+
+static void pll_get_mode_ctrl(unsigned long div_sel,
+			      bool (*mode_ctrl_check)(unsigned long,
+						      unsigned long,
+						      unsigned long),
+			      const struct cv1800_clk_pll_limit *limit,
+			      u32 *value)
+{
+	unsigned long ictrl = 0, mode = 0;
+	u32 detected = *value;
+
+	for_each_pll_limit_range(mode, &limit->mode) {
+		for_each_pll_limit_range(ictrl, &limit->ictrl) {
+			if (mode_ctrl_check(div_sel, ictrl, mode)) {
+				detected = PLL_SET_SEL_MODE(detected, mode);
+				detected = PLL_SET_ICTRL(detected, ictrl);
+				*value = detected;
+				return;
+			}
+		}
+	}
+}
+
+static bool ipll_check_mode_ctrl_restrict(unsigned long div_sel,
+					  unsigned long ictrl,
+					  unsigned long mode)
+{
+	unsigned long left_rest = 20 * div_sel;
+	unsigned long right_rest = 35 * div_sel;
+	unsigned long test = 184 * (1 + mode) * (1 + ictrl) / 2;
+
+	return test > left_rest && test <= right_rest;
+}
+
+static int ipll_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	u32 regval, detected = 0;
+	unsigned long flags;
+	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
+
+	ipll_find_rate(pll->pll_limit, parent_rate, &rate, &detected);
+	pll_get_mode_ctrl(PLL_GET_DIV_SEL(detected),
+			  ipll_check_mode_ctrl_restrict,
+			  pll->pll_limit, &detected);
+
+	spin_lock_irqsave(pll->common.lock, flags);
+
+	regval = readl(pll->common.base + pll->pll_reg);
+	regval = PLL_COPY_REG(regval, detected);
+
+	writel(regval, pll->common.base + pll->pll_reg);
+
+	spin_unlock_irqrestore(pll->common.lock, flags);
+
+	cv1800_clk_wait_for_lock(&pll->common, pll->pll_status.reg,
+			      BIT(pll->pll_status.shift));
+
+	return 0;
+}
+
+static int pll_enable(struct clk_hw *hw)
+{
+	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
+
+	return cv1800_clk_clearbit(&pll->common, &pll->pll_pwd);
+}
+
+static void pll_disable(struct clk_hw *hw)
+{
+	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
+
+	cv1800_clk_setbit(&pll->common, &pll->pll_pwd);
+}
+
+static int pll_is_enable(struct clk_hw *hw)
+{
+	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
+
+	return cv1800_clk_checkbit(&pll->common, &pll->pll_pwd) == 0;
+}
+
 const struct clk_ops cv1800_clk_ipll_ops = {
-	.disable = NULL,
-	.enable = NULL,
-	.is_enabled = NULL,
+	.disable = pll_disable,
+	.enable = pll_enable,
+	.is_enabled = pll_is_enable,

-	.recalc_rate = NULL,
-	.determine_rate = NULL,
-	.set_rate = NULL,
+	.recalc_rate = ipll_recalc_rate,
+	.determine_rate = ipll_determine_rate,
+	.set_rate = ipll_set_rate,
 };

+#define PLL_SYN_FACTOR_DOT_POS		26
+#define PLL_SYN_FACTOR_MINIMUM		((4 << PLL_SYN_FACTOR_DOT_POS) + 1)
+
+static bool fpll_is_factional_mode(struct cv1800_clk_pll *pll)
+{
+	return cv1800_clk_checkbit(&pll->common, &pll->pll_syn->en);
+}
+
+static unsigned long fpll_calc_rate(unsigned long parent_rate,
+				    unsigned long pre_div_sel,
+				    unsigned long div_sel,
+				    unsigned long post_div_sel,
+				    unsigned long ssc_syn_set,
+				    bool is_full_parent)
+{
+	u64 dividend = parent_rate * div_sel;
+	u64 factor = ssc_syn_set * pre_div_sel * post_div_sel;
+	unsigned long rate;
+
+	dividend <<= PLL_SYN_FACTOR_DOT_POS - 1;
+	rate = dividend / factor;
+	dividend %= factor;
+
+	if (is_full_parent) {
+		dividend <<= 1;
+		rate <<= 1;
+	}
+
+	rate += DIV64_U64_ROUND_CLOSEST(dividend, factor);
+
+	return rate;
+}
+
+static unsigned long fpll_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
+	u32 value;
+	bool clk_full;
+	u32 syn_set;
+
+	if (!fpll_is_factional_mode(pll))
+		return ipll_recalc_rate(hw, parent_rate);
+
+	syn_set = readl(pll->common.base + pll->pll_syn->set);
+
+	if (syn_set == 0)
+		return 0;
+
+	clk_full = cv1800_clk_checkbit(&pll->common,
+					  &pll->pll_syn->clk_half);
+
+	value = readl(pll->common.base + pll->pll_reg);
+
+	return fpll_calc_rate(parent_rate,
+			      PLL_GET_PRE_DIV_SEL(value),
+			      PLL_GET_DIV_SEL(value),
+			      PLL_GET_POST_DIV_SEL(value),
+			      syn_set, clk_full);
+}
+
+static unsigned long fpll_find_synthesizer(unsigned long parent,
+					   unsigned long rate,
+					   unsigned long pre_div,
+					   unsigned long div,
+					   unsigned long post_div,
+					   bool is_full_parent,
+					   u32 *ssc_syn_set)
+{
+	u32 test_max = U32_MAX, test_min = PLL_SYN_FACTOR_MINIMUM;
+	unsigned long trate;
+
+	while (test_min < test_max) {
+		u32 tssc = (test_max + test_min) / 2;
+
+		trate = fpll_calc_rate(parent, pre_div, div, post_div,
+				       tssc, is_full_parent);
+
+		if (trate == rate) {
+			test_min = tssc;
+			break;
+		}
+
+		if (trate > rate)
+			test_min = tssc + 1;
+		else
+			test_max = tssc - 1;
+	}
+
+	if (trate != 0)
+		*ssc_syn_set = test_min;
+
+	return trate;
+}
+
+static int fpll_find_rate(struct cv1800_clk_pll *pll,
+			  const struct cv1800_clk_pll_limit *limit,
+			  unsigned long prate,
+			  unsigned long *rate,
+			  u32 *value, u32 *ssc_syn_set)
+{
+	unsigned long best_rate = 0;
+	unsigned long pre_div_sel = 0, div_sel = 0, post_div_sel = 0;
+	unsigned long pre, div, post;
+	unsigned long trate = *rate;
+	u32 detected = *value;
+	unsigned long tmp;
+	bool clk_full = cv1800_clk_checkbit(&pll->common,
+					       &pll->pll_syn->clk_half);
+
+	for_each_pll_limit_range(pre, &limit->pre_div) {
+		for_each_pll_limit_range(post, &limit->post_div) {
+			for_each_pll_limit_range(div, &limit->div) {
+				tmp = fpll_find_synthesizer(prate, trate,
+							    pre, div, post,
+							    clk_full,
+							    ssc_syn_set);
+
+				if ((trate - tmp) < (trate - best_rate)) {
+					best_rate = tmp;
+					pre_div_sel = pre;
+					div_sel = div;
+					post_div_sel = post;
+				}
+			}
+		}
+	}
+
+	if (best_rate) {
+		detected = PLL_SET_PRE_DIV_SEL(detected, pre_div_sel);
+		detected = PLL_SET_POST_DIV_SEL(detected, post_div_sel);
+		detected = PLL_SET_DIV_SEL(detected, div_sel);
+		*value = detected;
+		*rate = best_rate;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int fpll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
+	u32 val, ssc_syn_set;
+
+	if (!fpll_is_factional_mode(pll))
+		return ipll_determine_rate(hw, req);
+
+	fpll_find_rate(pll, &pll->pll_limit[2], req->best_parent_rate,
+		       &req->rate, &val, &ssc_syn_set);
+
+	return 0;
+}
+
+static bool fpll_check_mode_ctrl_restrict(unsigned long div_sel,
+					  unsigned long ictrl,
+					  unsigned long mode)
+{
+	unsigned long left_rest = 10 * div_sel;
+	unsigned long right_rest = 24 * div_sel;
+	unsigned long test = 184 * (1 + mode) * (1 + ictrl) / 2;
+
+	return test > left_rest && test <= right_rest;
+}
+
+static int fpll_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	u32 regval;
+	u32 detected = 0, detected_ssc = 0;
+	unsigned long flags;
+	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
+
+	if (!fpll_is_factional_mode(pll))
+		return ipll_set_rate(hw, rate, parent_rate);
+
+	fpll_find_rate(pll, &pll->pll_limit[2], parent_rate,
+		       &rate, &detected, &detected_ssc);
+	pll_get_mode_ctrl(PLL_GET_DIV_SEL(detected),
+			  fpll_check_mode_ctrl_restrict,
+			  pll->pll_limit, &detected);
+
+	spin_lock_irqsave(pll->common.lock, flags);
+
+	writel(detected_ssc, pll->common.base + pll->pll_syn->set);
+
+	regval = readl(pll->common.base + pll->pll_reg);
+	regval = PLL_COPY_REG(regval, detected);
+
+	writel(regval, pll->common.base + pll->pll_reg);
+
+	spin_unlock_irqrestore(pll->common.lock, flags);
+
+	cv1800_clk_wait_for_lock(&pll->common, pll->pll_status.reg,
+			      BIT(pll->pll_status.shift));
+
+	return 0;
+}
+
+static u8 fpll_get_parent(struct clk_hw *hw)
+{
+	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
+
+	if (fpll_is_factional_mode(pll))
+		return 1;
+
+	return 0;
+}
+
+static int fpll_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
+
+	if (index)
+		cv1800_clk_setbit(&pll->common, &pll->pll_syn->en);
+	else
+		cv1800_clk_clearbit(&pll->common, &pll->pll_syn->en);
+
+	return 0;
+}
+
 const struct clk_ops cv1800_clk_fpll_ops = {
-	.disable = NULL,
-	.enable = NULL,
-	.is_enabled = NULL,
+	.disable = pll_disable,
+	.enable = pll_enable,
+	.is_enabled = pll_is_enable,

-	.recalc_rate = NULL,
-	.determine_rate = NULL,
-	.set_rate = NULL,
+	.recalc_rate = fpll_recalc_rate,
+	.determine_rate = fpll_determine_rate,
+	.set_rate = fpll_set_rate,

-	.set_parent = NULL,
-	.get_parent = NULL,
+	.set_parent = fpll_set_parent,
+	.get_parent = fpll_get_parent,
 };
--
2.43.0


