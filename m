Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12126756527
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGQNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjGQNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:35:17 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EDD1989;
        Mon, 17 Jul 2023 06:35:02 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4R4NNy508Lz9smT;
        Mon, 17 Jul 2023 15:34:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689600898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0E2YxyVlvlZZLwdZIaLYPAboPPaw9Lb7xi7G+ICAFTw=;
        b=FyIcD/32deuQaum5goVHMwLDtKH7iTTNDwQs2ixSQ6wzkQrMz/XwePjexhMFIXXpqgcZ9Q
        dWIXIzFBl6cxpjSCYVLT1dPph2NwV41Cxw4A1QKCEj6l6I5pTtIqRuMbbDVwYlFwI9vabZ
        g/eERyKcbv+CxK0HXiihkyVB5RDcpjNrAntvyvEcL44S4vIZEv3p7H9hTWx5fProwTHcTZ
        ETczpQ2gLa6ExtLsbAVGBWqPPIaOmXhU0mf36VE8krmi2FlOJBp4k3MRQbWCFwLzUdZI2J
        efDeZ846y8em+9VTFGbftKteBWp4VPkzJbi5xnwl4u9d3x/8QNWOL1GBc+PGyA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 17 Jul 2023 15:34:33 +0200
Subject: [PATCH v4 09/11] clk: sunxi-ng: mux: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-pll-mipi_set_rate_parent-v4-9-04acf1d39765@oltmanns.dev>
References: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3394; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=50b4yF0rWOhBsSCHTe8QISi0j6DZgAFg9IkJskDKbcA=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBktUNoQCABQZ+UW9bcK8zqLkpe0sHTTdGyKRvGH
 KV3OkdhSymJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZLVDaAAKCRCaaaIIlErT
 x6ZCC/4in/1eidqlsbszdf0V5rn0nsO6q7eGNli2d1qJr783q3LJtVh9W8djbZAHchX1ogIVCLN
 +/U4kit5eNCvhlO5G064PsjuR0o8utyETStzULBKBNH7/ILI17gpjAPP45qHOf0B+f0dcDclmbZ
 y875noRynh/q323kDDC7kpUjqrOKxO3KdA6J4rDK4Y0VIIkvnr2bzD8+erU2ds9H799eENL1px6
 EIKb+IOPgQmxWaFtgBhCdgVcwNnYBChGdZZDTTcFjzw/v+CPAMLkd5Wfz9WFng/x5ecrLS9C9ls
 jXakCjbn15YBZAoVW8g1YSCUXy2JoVH36iYPhhuPWuKfgWs1iAEjkNlJdkWRNcpo6JhZjiyg64t
 in0XwwIOrO8r24Uhx7zqbBJw20WbXc2a5L+FEWT/Pt4Q6stAfIuxHw6BVBVx4c41/oDJC3vcyCZ
 yXl+hVJnTdXXPLHil7JtedPONFlEMz9kt0rI9TTurRYFrWNZvorKmYRgoKMdKC8qZP/NM=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4R4NNy508Lz9smT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When finding the best rate for a mux clock, consider rates that are
higher than the requested rate when CCU_FEATURE_ROUND_CLOSEST is used.
Furthermore, introduce an initialization macro that sets this flag.

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

