Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C217771532
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjHFNH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjHFNHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:07:44 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3345319A6;
        Sun,  6 Aug 2023 06:07:41 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RJfrB21Yxz9smF;
        Sun,  6 Aug 2023 15:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691327258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TjD5RUuDvuJH5h092AsaV1mTvvtxTHcezWL7uVLhzVw=;
        b=WCIkSL59yRzbxO7Cd+5CXfhrgRYJ/GOmpNs51kMCd5Bu7oVwa9XhpUsS5bX32JmZEfdrUT
        wYb0CVU2wPmreomP1pEOvXC5p/pwsTIlQvJVdS+aqY1SxmhYRDk8B/0daapvaFsdFV2eD1
        Zqki1CdcY/gsArMj30ul0jFvLWIE7nwNxj3FNzX0ISkswUKJCs7CRYJFQLG2EmdFzplg22
        AhtzSWPG/pCXTE3BWfgPA2+avtkupHPuNgEwitIlOOmTUE805Vb0u4YCbjqGxTeGmp+QvX
        JgOEhNrs7NAHUglyt2LNbOU6xBoseWpcydZIJdBRkgRYq+NkT+ccNQG3haNPJw==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 06 Aug 2023 15:06:53 +0200
Subject: [PATCH v5 08/11] clk: sunxi-ng: mux: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-pll-mipi_set_rate_parent-v5-8-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3440; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=OvKXg4vQ+wbmZqDkAPDAPHykvEpUGR9vUTxoWn/TvUI=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkz5sH2rQD7N/pKO3IK5DJNPbc4o7hwgupuHQYO
 TDQwMj2j4iJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZM+bBwAKCRCaaaIIlErT
 x5riC/wJLP4De2988WYJxP7YFoz01YlNlZ5JrrNcLp6JQXF9WgmXZLSszca6hxejUI4Ls+oy2yr
 mwh3tHNoWMxP0S/heYro7SWGvsMfnKJrjT/N4zP4qPBbraqeMHT9VcNRO5o8llNXopH5d+zxYkn
 uk4XNFB0beUcnesz+4YUirpwxBwvlvpvrF5B1BMltbjrVkJNuQQobsDnxXAYQGcL2MLuddks0SQ
 zwK1rRBuTKs2gGysrmWd3bc/ZBQyo+ta8bPc6JlpkPwA7Iw10yO1OhpgkA97ZttwUw6K0o443dj
 U6rvciUazUIk4tW+MREXoCnOJ5U5PrRtiFxSqfVP8Af+AUj4T0M7gyk0giiYZ9alYK+kwHlV+GP
 /SSudMzjQMFGtTYsR3LuY0ju2+1PWpqg748JPGMB0SjTbpuiku+7UGED5fEHYepVdB8QWhqeJTS
 F9104esWTQYC5u8VZWq/rPGVyialabn9GLuNlkvYPJNEb93Ws9s62FyQy9sRx7GZeI0uI=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RJfrB21Yxz9smF
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

