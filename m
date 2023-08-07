Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA0772495
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjHGMor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjHGMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:44:28 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3494019BD;
        Mon,  7 Aug 2023 05:44:20 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RKGGm5dS2z9sWQ;
        Mon,  7 Aug 2023 14:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691412256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v0+pPKgWXMRtQfEcq7Lwac7P0rHRUc81juXc47wwEhw=;
        b=2GYm8z6Uftu4xkYbu0pLp9ZvmPh2ymuBckFacYhOXdpNfxZTrVcTYgi8SUolK/mMkxMfgZ
        6U8KiKUUvoDLDJlXkVHSsA0uUFgJVRzGWnfVCwAtQ5ScoeJJEGgnYNlfhTs7W5eRnO7EOM
        qAXMFlbDMweivfZ4c86KlyVwnmARAmXgYLoWNMSqpcRo9AABrmBv3EMMvcceVEE2DDi4p8
        T7YWkDFJZ0c6aR8Kx+28vYC2OawGRiq8lsSTg3CwYFhUIR6Rr0rvXrDBeFB7hPEqQ94t0R
        BKtv0sAhGu9lSaSBRhzFvafS8n1mGWwQTxgpbduF+z0QmdppUB18AQ/IZ8C6BA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 07 Aug 2023 14:43:41 +0200
Subject: [PATCH v6 08/11] clk: sunxi-ng: mux: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-pll-mipi_set_rate_parent-v6-8-f173239a4b59@oltmanns.dev>
References: <20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev>
In-Reply-To: <20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=89fqPS+TY+dHyrz3Q+lbonRwaAXXziauHi+C8rJELvg=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBk0OcLb4CblL6ckG0P5i4esDuUHY+FbF3NAFjZy
 JTCGN7PWFyJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZNDnCwAKCRCaaaIIlErT
 x2oyC/4isk1uDQVoFJy3vdcYBc2xIE9Dcm12BWDGx5QVDGMu3aa7IKQ6ESBpJytPtqDTuQ1T2uy
 nqBzXUbo3+UK0SNrR8xx/6jPzYtf7Zemgp4Nd10nD0dxDsw3oeb4P2Xbv4Lm9Mus7AWgBlHULeh
 26KEJQpzoEw9G7YE9mpAR6M6Kg4vWGOlGDs0ON7yN0zpxiZsXwrvOrsMtUjVaSP0qljm4lwhKVW
 OHB9D5nU9D2ZLg9EZbBVtKosIzD7JYaocotBpddtyamD6AhcRgbAdS7NdznKlf/lA1rQzp+6vf4
 onL1InUYOmSHOlAUWrtbbd3C/mNZwhzk/0qqZJclsUw1k5EG9L/Q2Qm4ZZ6BglzEL0EJvaLqRQz
 7sJRiQQ+dspmyWEW+k4wyVYlttXoi5MK8Kfpi6IuV3TNL4pFAVAMyRxEaWl9XOIlZRfFjUaz7Zh
 YyPSI0WCOKyNJLmz7ryy3qqUoDslu8tXgCbVn8pSDbNWsehaGG4qzK/GFFVeHo3JpryJM=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When finding the best rate for a mux clock, consider rates that are
higher than the requested rate when CCU_FEATURE_ROUND_CLOSEST is used.
Furthermore, introduce an initialization macro that sets this flag.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_mux.c | 13 ++++++++++++-
 drivers/clk/sunxi-ng/ccu_mux.h | 38 +++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 3ca695439620..5edc63b46651 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -242,6 +242,17 @@ static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
 	return ccu_mux_helper_set_parent(&cm->common, &cm->mux, index);
 }
 
+static int ccu_mux_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	struct ccu_mux *cm = hw_to_ccu_mux(hw);
+
+	if (cm->common.features & CCU_FEATURE_CLOSEST_RATE)
+		return clk_mux_determine_rate_flags(hw, req, CLK_MUX_ROUND_CLOSEST);
+
+	return clk_mux_determine_rate_flags(hw, req, 0);
+}
+
 static unsigned long ccu_mux_recalc_rate(struct clk_hw *hw,
 					 unsigned long parent_rate)
 {
@@ -259,7 +270,7 @@ const struct clk_ops ccu_mux_ops = {
 	.get_parent	= ccu_mux_get_parent,
 	.set_parent	= ccu_mux_set_parent,
 
-	.determine_rate	= __clk_mux_determine_rate,
+	.determine_rate	= ccu_mux_determine_rate,
 	.recalc_rate	= ccu_mux_recalc_rate,
 };
 EXPORT_SYMBOL_NS_GPL(ccu_mux_ops, SUNXI_CCU);
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index 2c1811a445b0..eb1172ebbd94 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -46,20 +46,36 @@ struct ccu_mux {
 	struct ccu_common	common;
 };
 
+#define SUNXI_CCU_MUX_TABLE_WITH_GATE_FEAT(_struct, _name, _parents, _table,	\
+				     _reg, _shift, _width, _gate,		\
+				     _flags, _features)				\
+	struct ccu_mux _struct = {						\
+		.enable	= _gate,						\
+		.mux	= _SUNXI_CCU_MUX_TABLE(_shift, _width, _table),		\
+		.common	= {							\
+			.reg		= _reg,					\
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,		\
+							      _parents,		\
+							      &ccu_mux_ops,	\
+							      _flags),		\
+			.features	= _features,				\
+		}								\
+	}
+
+#define SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(_struct, _name, _parents,	\
+					      _table, _reg, _shift,	\
+					      _width, _gate, _flags)	\
+	SUNXI_CCU_MUX_TABLE_WITH_GATE_FEAT(_struct, _name, _parents,	\
+					   _table, _reg, _shift,	\
+					   _width, _gate, _flags,	\
+					   CCU_FEATURE_CLOSEST_RATE)
+
 #define SUNXI_CCU_MUX_TABLE_WITH_GATE(_struct, _name, _parents, _table,	\
 				     _reg, _shift, _width, _gate,	\
 				     _flags)				\
-	struct ccu_mux _struct = {					\
-		.enable	= _gate,					\
-		.mux	= _SUNXI_CCU_MUX_TABLE(_shift, _width, _table),	\
-		.common	= {						\
-			.reg		= _reg,				\
-			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
-							      _parents, \
-							      &ccu_mux_ops, \
-							      _flags),	\
-		}							\
-	}
+	SUNXI_CCU_MUX_TABLE_WITH_GATE_FEAT(_struct, _name, _parents,	\
+					   _table, _reg, _shift,	\
+					   _width, _gate, _flags, 0)
 
 #define SUNXI_CCU_MUX_WITH_GATE(_struct, _name, _parents, _reg,		\
 				_shift, _width, _gate, _flags)		\

-- 
2.41.0

