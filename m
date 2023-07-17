Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13136756522
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGQNfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGQNfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:35:01 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D455210FA;
        Mon, 17 Jul 2023 06:34:56 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4R4NNs3xktz9sn0;
        Mon, 17 Jul 2023 15:34:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689600893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLlZ20gT3AYBxK1XNMqqr6vr/q9ctYDYjWAuz89wTeI=;
        b=FauePXE2BeyhtMEhZ8a/oZikKUJ9mLjJOdTlEybsRzYiibAYAvL0UkdQgEDB62QAPflBvs
        wbS91bJHsZHzcrF2zrEDrMkOylTmTWrgujlqfPIHjzXJsOuMnMnRjxLqUwyko+2f6H0J0N
        QAqFxM+PXBfMyqimi/pr6sWpZmXr59XesOF+O9/hr8Y5Wxv3+BqD2yPIhrt0ogryZaxWXy
        KDYf7stY0+c7q6V8VqNTwBX2vM8bTUczPvS/JyIgmuLMSf0cbUlk/MdYfmy26rDVVqMnoL
        3Uwt48aYlMmG2GxQDMqcjLHWgipbPEHdOzAwHpEdx5v4z5L0LmBhWY+ITyACGg==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 17 Jul 2023 15:34:31 +0200
Subject: [PATCH v4 07/11] clk: sunxi-ng: nm: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-pll-mipi_set_rate_parent-v4-7-04acf1d39765@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5089; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=NepBBc4l97PvUGu6ZIRJp/OdImGWyPyBUbamE+1jv1o=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBktUNn9Y3lBf5N2ajTepXKLJ+mjiTtVwbQxpO2O
 aboO54rn+SJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZLVDZwAKCRCaaaIIlErT
 xxbXDACKhryJmCyCo+ZOit2eroVXh9w6WrCLSafRUolxDHQJP2mlATGDQeDT4QH1AGD2NC5XHpk
 a10nSqVFEuMZQY5xzkvnXxA3vebDr8M6P/F8LH+K1p7ip3WiVcoqGSnD5lueKlr2AFvMhofLHyo
 QW+MMYUuHGD5CQK0TRcmmpTLRs7RSgxp1dC1gNqo4fGxW6KXNwI7RdlLM1hFp57aDhybhjMG8Yp
 J8wnh+usI7hbFbuHZMFo/m+2HbbTj/UioyWuQRELXTuzmFO+hwvn7YPyCG3a70tCWw6oMlQkcCl
 GzSlEIMWH+4j49a0Ipdke/5TZs10eU3x9gWgc096u0SpZH5Ez/qVaLhZyNFlP/zKwfxPF1Wmi6O
 SGGa+KOjAgx/kctVOccga2SylFEjmBZnmxUuLdpbwbEBDoPBgl6UpuIXEzR3i1cgorEosVhKuqV
 mPs0yWLHUUIFqVe6+cLoH5OoxwjEgRxVD/bZpWigvBsRxqQDsVs7sAp25hb3O1FK26Lqs=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4R4NNs3xktz9sn0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper function ccu_is_better_rate() to determine the rate that
is closest to the requested rate, thereby supporting rates that are
higher than the requested rate if the clock uses the
CCU_FEATURE_CLOSEST_RATE.

Add the macro SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST which
sets CCU_FEATURE_CLOSEST_RATE.

To avoid code duplication, add the macros
SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT that allows selecting
arbitrary features and use it in the original
SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX as well as the newly introduced
SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST macros.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_nm.c | 11 ++++------
 drivers/clk/sunxi-ng/ccu_nm.h | 48 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index c1fd11542c45..35d00783d748 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -28,7 +28,7 @@ static unsigned long ccu_nm_calc_rate(unsigned long parent,
 }
 
 static unsigned long ccu_nm_find_best(unsigned long parent, unsigned long rate,
-				      struct _ccu_nm *nm)
+				      struct _ccu_nm *nm, struct ccu_common *common)
 {
 	unsigned long best_rate = 0;
 	unsigned long best_n = 0, best_m = 0;
@@ -39,10 +39,7 @@ static unsigned long ccu_nm_find_best(unsigned long parent, unsigned long rate,
 			unsigned long tmp_rate = ccu_nm_calc_rate(parent,
 								  _n, _m);
 
-			if (tmp_rate > rate)
-				continue;
-
-			if ((rate - tmp_rate) < (rate - best_rate)) {
+			if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
 				best_rate = tmp_rate;
 				best_n = _n;
 				best_m = _m;
@@ -159,7 +156,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	_nm.min_m = 1;
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
-	rate = ccu_nm_find_best(*parent_rate, rate, &_nm);
+	rate = ccu_nm_find_best(*parent_rate, rate, &_nm, &nm->common);
 
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nm->fixed_post_div;
@@ -210,7 +207,7 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 					   &_nm.m, &_nm.n);
 	} else {
 		ccu_sdm_helper_disable(&nm->common, &nm->sdm);
-		ccu_nm_find_best(parent_rate, rate, &_nm);
+		ccu_nm_find_best(parent_rate, rate, &_nm, &nm->common);
 	}
 
 	spin_lock_irqsave(nm->common.lock, flags);
diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
index 2904e67f05a8..93c11693574f 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.h
+++ b/drivers/clk/sunxi-ng/ccu_nm.h
@@ -108,7 +108,7 @@ struct ccu_nm {
 		},							\
 	}
 
-#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(_struct, _name,	\
+#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT(_struct, _name,	\
 						 _parent, _reg,		\
 						 _min_rate, _max_rate,	\
 						 _nshift, _nwidth,	\
@@ -116,7 +116,8 @@ struct ccu_nm {
 						 _frac_en, _frac_sel,	\
 						 _frac_rate_0,		\
 						 _frac_rate_1,		\
-						 _gate, _lock, _flags)	\
+						 _gate, _lock, _flags,	\
+						 _features)		\
 	struct ccu_nm _struct = {					\
 		.enable		= _gate,				\
 		.lock		= _lock,				\
@@ -129,7 +130,7 @@ struct ccu_nm {
 		.max_rate	= _max_rate,				\
 		.common		= {					\
 			.reg		= _reg,				\
-			.features	= CCU_FEATURE_FRACTIONAL,	\
+			.features	= _features,			\
 			.hw.init	= CLK_HW_INIT(_name,		\
 						      _parent,		\
 						      &ccu_nm_ops,	\
@@ -137,6 +138,47 @@ struct ccu_nm {
 		},							\
 	}
 
+#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(_struct, _name,	\
+						 _parent, _reg,		\
+						 _min_rate, _max_rate,	\
+						 _nshift, _nwidth,	\
+						 _mshift, _mwidth,	\
+						 _frac_en, _frac_sel,	\
+						 _frac_rate_0,		\
+						 _frac_rate_1,		\
+						 _gate, _lock, _flags)	\
+	SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT(_struct, _name,	\
+						_parent, _reg,		\
+						_min_rate, _max_rate,	\
+						_nshift, _nwidth,	\
+						_mshift, _mwidth,	\
+						_frac_en, _frac_sel,	\
+						_frac_rate_0,		\
+						_frac_rate_1,		\
+						_gate, _lock, _flags,	\
+						CCU_FEATURE_FRACTIONAL)
+
+#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(_struct, _name, \
+						 _parent, _reg,		\
+						 _min_rate, _max_rate,	\
+						 _nshift, _nwidth,	\
+						 _mshift, _mwidth,	\
+						 _frac_en, _frac_sel,	\
+						 _frac_rate_0,		\
+						 _frac_rate_1,		\
+						 _gate, _lock, _flags)	\
+	SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT(_struct, _name,	\
+						_parent, _reg,		\
+						_min_rate, _max_rate,	\
+						_nshift, _nwidth,	\
+						_mshift, _mwidth,	\
+						_frac_en, _frac_sel,	\
+						_frac_rate_0,		\
+						_frac_rate_1,		\
+						_gate, _lock, _flags,	\
+						CCU_FEATURE_FRACTIONAL |\
+						CCU_FEATURE_CLOSEST_RATE)
+
 #define SUNXI_CCU_NM_WITH_GATE_LOCK(_struct, _name, _parent, _reg,	\
 				    _nshift, _nwidth,			\
 				    _mshift, _mwidth,			\

-- 
2.41.0

