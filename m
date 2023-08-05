Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF768770E45
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjHEHHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjHEHHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:07:21 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7103C2D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:07:20 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37576ouK013850;
        Sat, 5 Aug 2023 15:06:50 +0800 (+08)
        (envelope-from zhifeng.tang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RHtrF5HV0z2K1r9q;
        Sat,  5 Aug 2023 15:05:01 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Sat, 5 Aug
 2023 15:06:48 +0800
From:   Zhifeng Tang <zhifeng.tang@unisoc.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Zhifeng Tang <zhifeng.tang@unisoc.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Maxime Ripard <mripard@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhifeng Tang <zhifeng.tang23@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH] clk: sprd: Composite driver support offset config
Date:   Sat, 5 Aug 2023 15:06:43 +0800
Message-ID: <20230805070643.30705-1-zhifeng.tang@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL: SHSQR01.spreadtrum.com 37576ouK013850
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The composite interface support the offset configuration,
which is userd to support mux and div in different registers.

Signed-off-by: Zhifeng Tang <zhifeng.tang@unisoc.com>
---
 drivers/clk/sprd/composite.h | 38 +++++++++++++++++++++++++-----------
 drivers/clk/sprd/div.c       |  6 +++---
 drivers/clk/sprd/div.h       | 17 +++++++++++-----
 3 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/sprd/composite.h b/drivers/clk/sprd/composite.h
index adbabbe596b7..74765584021d 100644
--- a/drivers/clk/sprd/composite.h
+++ b/drivers/clk/sprd/composite.h
@@ -19,24 +19,24 @@ struct sprd_comp {
 };
 
 #define SPRD_COMP_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _table,	\
-				 _mshift, _mwidth, _dshift, _dwidth,	\
-				 _flags, _fn)				\
+				 _mshift, _mwidth, _doffset, _dshift,	\
+				 _dwidth, _flags, _fn)			\
 	struct sprd_comp _struct = {					\
 		.mux	= _SPRD_MUX_CLK(_mshift, _mwidth, _table),	\
-		.div	= _SPRD_DIV_CLK(_dshift, _dwidth),		\
+		.div	= _SPRD_DIV_CLK(_doffset, _dshift, _dwidth),	\
 		.common = {						\
 			.regmap		= NULL,				\
 			.reg		= _reg,				\
 			.hw.init = _fn(_name, _parent,			\
 				       &sprd_comp_ops, _flags),		\
-			 }						\
+		}							\
 	}
 
 #define SPRD_COMP_CLK_TABLE(_struct, _name, _parent, _reg, _table,	\
 			    _mshift, _mwidth, _dshift, _dwidth, _flags)	\
 	SPRD_COMP_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _table,	\
-				 _mshift, _mwidth, _dshift, _dwidth,	\
-				 _flags, CLK_HW_INIT_PARENTS)
+				 _mshift, _mwidth, 0x0, _dshift,	\
+				 _dwidth, _flags, CLK_HW_INIT_PARENTS)
 
 #define SPRD_COMP_CLK(_struct, _name, _parent, _reg, _mshift,		\
 		      _mwidth, _dshift, _dwidth, _flags)		\
@@ -47,14 +47,30 @@ struct sprd_comp {
 				 _mshift, _mwidth, _dshift,		\
 				 _dwidth, _flags)			\
 	SPRD_COMP_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _table,	\
-				 _mshift, _mwidth, _dshift, _dwidth,	\
-				 _flags, CLK_HW_INIT_PARENTS_DATA)
+				 _mshift, _mwidth, 0x0, _dshift,	\
+				 _dwidth, _flags,			\
+				 CLK_HW_INIT_PARENTS_DATA)
 
 #define SPRD_COMP_CLK_DATA(_struct, _name, _parent, _reg, _mshift,	\
 			   _mwidth, _dshift, _dwidth, _flags)		\
-	SPRD_COMP_CLK_DATA_TABLE(_struct, _name, _parent, _reg,	NULL,	\
-				 _mshift, _mwidth, _dshift, _dwidth,	\
-				 _flags)
+	SPRD_COMP_CLK_DATA_TABLE(_struct, _name, _parent, _reg, NULL,	\
+				 _mshift, _mwidth, _dshift,		\
+				 _dwidth,  _flags)
+
+#define SPRD_COMP_CLK_DATA_TABLE_OFFSET(_struct, _name, _parent, _reg,	\
+					_table, _mshift, _mwidth,	\
+					_dshift, _dwidth, _flags)	\
+	SPRD_COMP_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _table,	\
+				 _mshift, _mwidth, 0x4, _dshift,	\
+				 _dwidth, _flags,			\
+				 CLK_HW_INIT_PARENTS_DATA)
+
+#define SPRD_COMP_CLK_DATA_OFFSET(_struct, _name, _parent, _reg,	\
+				  _mshift, _mwidth, _dshift,		\
+				  _dwidth, _flags)			\
+	SPRD_COMP_CLK_DATA_TABLE_OFFSET(_struct, _name, _parent, _reg,	\
+					NULL, _mshift, _mwidth,		\
+					_dshift, _dwidth,  _flags)
 
 static inline struct sprd_comp *hw_to_sprd_comp(const struct clk_hw *hw)
 {
diff --git a/drivers/clk/sprd/div.c b/drivers/clk/sprd/div.c
index c7261630cab4..0fb41d653f1e 100644
--- a/drivers/clk/sprd/div.c
+++ b/drivers/clk/sprd/div.c
@@ -25,7 +25,7 @@ unsigned long sprd_div_helper_recalc_rate(struct sprd_clk_common *common,
 	unsigned long val;
 	unsigned int reg;
 
-	regmap_read(common->regmap, common->reg, &reg);
+	regmap_read(common->regmap, common->reg - div->offset, &reg);
 	val = reg >> div->shift;
 	val &= (1 << div->width) - 1;
 
@@ -53,10 +53,10 @@ int sprd_div_helper_set_rate(const struct sprd_clk_common *common,
 	val = divider_get_val(rate, parent_rate, NULL,
 			      div->width, 0);
 
-	regmap_read(common->regmap, common->reg, &reg);
+	regmap_read(common->regmap, common->reg - div->offset, &reg);
 	reg &= ~GENMASK(div->width + div->shift - 1, div->shift);
 
-	regmap_write(common->regmap, common->reg,
+	regmap_write(common->regmap, common->reg - div->offset,
 			  reg | (val << div->shift));
 
 	return 0;
diff --git a/drivers/clk/sprd/div.h b/drivers/clk/sprd/div.h
index f5d614b3dcf1..db6b62ee6a8d 100644
--- a/drivers/clk/sprd/div.h
+++ b/drivers/clk/sprd/div.h
@@ -20,12 +20,14 @@
  * classes.
  */
 struct sprd_div_internal {
+	u32	offset;
 	u8	shift;
 	u8	width;
 };
 
-#define _SPRD_DIV_CLK(_shift, _width)	\
+#define _SPRD_DIV_CLK(_offset, _shift, _width)	\
 	{				\
+		.offset = _offset,	\
 		.shift	= _shift,	\
 		.width	= _width,	\
 	}
@@ -35,10 +37,10 @@ struct sprd_div {
 	struct sprd_clk_common	common;
 };
 
-#define SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,		\
+#define SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, _offset,	\
 				_shift, _width, _flags, _fn)		\
 	struct sprd_div _struct = {					\
-		.div	= _SPRD_DIV_CLK(_shift, _width),		\
+		.div	= _SPRD_DIV_CLK(_offset, _shift, _width),	\
 		.common	= {						\
 			.regmap		= NULL,				\
 			.reg		= _reg,				\
@@ -49,12 +51,17 @@ struct sprd_div {
 
 #define SPRD_DIV_CLK(_struct, _name, _parent, _reg,			\
 		     _shift, _width, _flags)				\
-	SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,		\
+	SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, 0x0,	\
 				_shift, _width, _flags, CLK_HW_INIT)
 
+#define SPRD_DIV_CLK_FW_NAME(_struct, _name, _parent, _reg,		\
+			_shift, _width, _flags)				\
+	SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, 0x0,	\
+				_shift, _width, _flags, CLK_HW_INIT_FW_NAME)
+
 #define SPRD_DIV_CLK_HW(_struct, _name, _parent, _reg,			\
 			_shift, _width, _flags)				\
-	SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg,		\
+	SPRD_DIV_CLK_HW_INIT_FN(_struct, _name, _parent, _reg, 0x0,	\
 				_shift, _width, _flags, CLK_HW_INIT_HW)
 
 static inline struct sprd_div *hw_to_sprd_div(const struct clk_hw *hw)
-- 
2.17.1

