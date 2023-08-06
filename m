Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3915B771531
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjHFNHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjHFNHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:07:41 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D7E19B1;
        Sun,  6 Aug 2023 06:07:39 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RJfr84fGkz9ssc;
        Sun,  6 Aug 2023 15:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691327256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jP7azlWe913nN4pLhChAwYmOVnXxCr1K6ASPbVey0qI=;
        b=hg8A0IP+6qI1I3ktOHf4Yv0W+VaGmw8irBaJlfFOw6SlWKBUV2sw6igr3WxgrvYYd0mt7h
        p7kBREL0g6/ZDD1ZiPdpQI3dW0j1UGkp5k54b/wnBDl2qgA8n29mxEDdYswI/P4s4a1cU3
        CN/BZB3bN+jiEutDfJ853kH9ifsQuYyYdkvFtgzXKQhBc3qRMvWDU/IEwcERtKA3Lsi72v
        8R6K4nHjmG+oxvcMFxGPHOJtj6tr5Xd+DHvUz/zGTFid7CqvQyePz1COXohdinS1rzb34U
        DnMqqFLYM9V5JkXwVway+ugYd9/SM3O6bS2A3OBqG6ang+Wqt3+IFywC+kbxQg==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 06 Aug 2023 15:06:52 +0200
Subject: [PATCH v5 07/11] clk: sunxi-ng: nkm: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-pll-mipi_set_rate_parent-v5-7-db4f5ca33fc3@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3786; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=88DH4FmkecM+BvpS+IIc+feAri98ehm0OPoAyhARAxs=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkz5sHMDzT02nFpWO+c/LmS60zlKqDNPcMKxq5N
 qLTTlHlqyKJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZM+bBwAKCRCaaaIIlErT
 x6SpC/sEiAeZYXhqG1P5D/E5rBVyUb9hwzWLZBvlpwDOoNGCrTtALN1bKllGg6oLlKJIi9ikNiH
 hvAMyvwyukEHs1II+4yjcBnfYs/Yb49/taalpPqjKEzf/5qWncIxzQp/qe3/je9enP8K66AI7Cr
 YMAEZn2GSceKIIV/mg/CySf69G3NVIt6RT0b5cT06+Od0XGvtmZy4lpxjJnmtvMKRg2Xs2TygU7
 +tr261aGVg2OEaGgwyCcHJYsIvSA5ExZ8yLJcZM+haR7l9HClnIDokRgNoGZ7WbWmuyEOL+oCk3
 CT+Qy12ceYOY+ZVRmpZxoY4qq6FpcaAt0tl3sYdGPkyrekUsHMIGuBqRndF+/BnejgFPjCWKOQf
 GH+4v+BuKA48ES3wVv2Yeb5XIRTuiavatR6gAdE4sMMhojvbGkGDUvmWIn1GdSSa/85+Li+f/ic
 OnDcM7xyv7DsT2leB/B7TT/ynEUsB3l4LqetGJ2MZPx4ycLIe7ecBQbOiF1zPtDTKdZko=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RJfr84fGkz9ssc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When finding the best rate for a NKM clock, consider rates that are
higher than the requested rate, if the CCU_FEATURE_CLOSEST_RATE flag is
set by using the helper function ccu_is_better_rate().

Accommodate ccu_mux_helper_determine_rate to this change.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_mux.c |  2 +-
 drivers/clk/sunxi-ng/ccu_nkm.c | 20 +++++++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 1d557e323169..3ca695439620 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -139,7 +139,7 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
 			goto out;
 		}
 
-		if ((req->rate - tmp_rate) < (req->rate - best_rate)) {
+		if (ccu_is_better_rate(common, req->rate, tmp_rate, best_rate)) {
 			best_rate = tmp_rate;
 			best_parent_rate = parent_rate;
 			best_parent = parent;
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index ea1b77e9b57f..896bb1ef8642 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -17,7 +17,8 @@ struct _ccu_nkm {
 	unsigned long	m, min_m, max_m;
 };
 
-static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *parent_hw,
+static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common,
+						       struct clk_hw *parent_hw,
 						       unsigned long *parent, unsigned long rate,
 						       struct _ccu_nkm *nkm)
 {
@@ -33,10 +34,8 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *parent_hw,
 				tmp_parent = clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
 
 				tmp_rate = tmp_parent * _n * _k / _m;
-				if (tmp_rate > rate)
-					continue;
 
-				if ((rate - tmp_rate) < (rate - best_rate)) {
+				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
 					best_rate = tmp_rate;
 					best_parent_rate = tmp_parent;
 					best_n = _n;
@@ -57,7 +56,7 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *parent_hw,
 }
 
 static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
-				       struct _ccu_nkm *nkm)
+				       struct _ccu_nkm *nkm, struct ccu_common *common)
 {
 	unsigned long best_rate = 0;
 	unsigned long best_n = 0, best_k = 0, best_m = 0;
@@ -70,9 +69,7 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 
 				tmp_rate = parent * _n * _k / _m;
 
-				if (tmp_rate > rate)
-					continue;
-				if ((rate - tmp_rate) < (rate - best_rate)) {
+				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
 					best_rate = tmp_rate;
 					best_n = _n;
 					best_k = _k;
@@ -165,9 +162,10 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 		rate *= nkm->fixed_post_div;
 
 	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
-		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm, &nkm->common);
 	else
-		rate = ccu_nkm_find_best_with_parent_adj(parent_hw, parent_rate, rate, &_nkm);
+		rate = ccu_nkm_find_best_with_parent_adj(&nkm->common, parent_hw, parent_rate, rate,
+							 &_nkm);
 
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nkm->fixed_post_div;
@@ -202,7 +200,7 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
-	ccu_nkm_find_best(parent_rate, rate, &_nkm);
+	ccu_nkm_find_best(parent_rate, rate, &_nkm, &nkm->common);
 
 	spin_lock_irqsave(nkm->common.lock, flags);
 

-- 
2.41.0

