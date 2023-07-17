Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575D6756524
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjGQNfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjGQNfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:35:15 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFEB1980;
        Mon, 17 Jul 2023 06:34:59 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4R4NNw3Svtz9sXk;
        Mon, 17 Jul 2023 15:34:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689600896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlTJuOBcXldwNheInskRcuqMdDaXa3wlYPUBaUVJITM=;
        b=k3Izz2QDMb4ZkG7IdiVrxI4xiC2CYmFKBAPQsC9m8jqjf3xoziGkIDTMs6Yv1jKAVxTW7c
        nxWUALor4jJ3y+1Zht/k8H7RaK8CHGpZlnfXW39dK1ak0pIiTpLOClXSyrLq3oiNp+i54a
        qCeCRH/t4RBpvrpo1GAsg+M0Pnd5kDXN+S8PcQY1W85RWtkHa3810Y0JWzctpE7A+l3dML
        EYqJWgUYsXi+QJMijoa91VI/cBFrb69m+kaRGajxhE2YvCGqHg1mvZ0uh89UDpfBdiVsDJ
        BJId1g7oXD8lp9Gkr3ZnlC5eb3fx0mkUYAHHHVXpRCr/QxlDwQYEHAXOmxWM0g==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 17 Jul 2023 15:34:32 +0200
Subject: [PATCH v4 08/11] clk: sunxi-ng: nkm: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-pll-mipi_set_rate_parent-v4-8-04acf1d39765@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3726; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=QflG05ovfcYkdKjU+vIi9ERE1oD6pVxvlipjsNU5BvM=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBktUNn4hmkcdxGSrDuWuDUm1o7lKzVeUSIiR/VN
 5cUaRPKDoCJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZLVDZwAKCRCaaaIIlErT
 x8EdC/wMKH2lWa2XhH6vFrr4FfyZCnlE9m584JJSfG2UVEaRUIzh7hLvIUC68KvBShSyFtZuX60
 8+eq7o5e4wQh+j6J5W5yxD4t0XDxBhxBvUfqjifbm92vVi119LVinHbZ6cYOApuARW+MRqVJCGS
 v7E2aLzLCOfLXrbVZeQIuSGszrtZvw1dYul1GIGUyNjER0XAzHaJpF+0iQeTO0KvArCgQvXEPB6
 VVczu+kl70h4jnv+gyxt/i28SkjhSzzYJ3HA8TEkGCB4iWnn7wx3WwFzQMIIHNfCrBU0vCgh9NH
 sRM4+V+yxXOgjd2AQTPxY9t5QETLVLqU7OTYi9+/IrFSPR+lNhvzX5Mc6+daIwExsIxRcHGoNX7
 gDhe6LW4VBQKLfnV9VZ6G3GChdB6zVY27wPNg2kf5SDj/AcOxh0mLiUUD9tlPblR+lhxOjJfsqw
 rbvKLi5iqgg9gZ9QmVSYsFyLZuOHioFbFzexXZ62Zz2U/sBm2BIOwdLMjDtOgvhnJNcJ4=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4R4NNw3Svtz9sXk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When finding the best rate for a NKM clock, consider rates that are
higher than the requested rate, if the CCU_FEATURE_CLOSEST_RATE flag is
set by using the helper function ccu_is_better_rate().

Accommodate ccu_mux_helper_determine_rate to this change.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_mux.c |  2 +-
 drivers/clk/sunxi-ng/ccu_nkm.c | 18 ++++++++----------
 2 files changed, 9 insertions(+), 11 deletions(-)

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
index 793160bc2d47..5439b9351cd7 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -39,6 +39,7 @@ static unsigned long ccu_nkm_optimal_parent_rate(unsigned long rate, unsigned lo
 }
 
 static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *phw, struct _ccu_nkm *nkm,
+						       struct ccu_common *common,
 						       unsigned long *parent, unsigned long rate)
 {
 	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent = *parent;
@@ -54,10 +55,8 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *phw, struc
 				tmp_parent = clk_hw_round_rate(phw, tmp_parent);
 
 				tmp_rate = tmp_parent * _n * _k / _m;
-				if (tmp_rate > rate)
-					continue;
 
-				if ((rate - tmp_rate) < (rate - best_rate)) {
+				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
 					best_rate = tmp_rate;
 					best_parent_rate = tmp_parent;
 					best_n = _n;
@@ -78,7 +77,7 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *phw, struc
 }
 
 static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
-				       struct _ccu_nkm *nkm)
+				       struct _ccu_nkm *nkm, struct ccu_common *common)
 {
 	unsigned long best_rate = 0;
 	unsigned long best_n = 0, best_k = 0, best_m = 0;
@@ -91,9 +90,7 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 
 				tmp_rate = parent * _n * _k / _m;
 
-				if (tmp_rate > rate)
-					continue;
-				if ((rate - tmp_rate) < (rate - best_rate)) {
+				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
 					best_rate = tmp_rate;
 					best_n = _n;
 					best_k = _k;
@@ -186,9 +183,10 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 		rate *= nkm->fixed_post_div;
 
 	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
-		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm, &nkm->common);
 	else
-		rate = ccu_nkm_find_best_with_parent_adj(parent_hw, &_nkm, parent_rate, rate);
+		rate = ccu_nkm_find_best_with_parent_adj(parent_hw, &_nkm, &nkm->common,
+							 parent_rate, rate);
 
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nkm->fixed_post_div;
@@ -223,7 +221,7 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
-	ccu_nkm_find_best(parent_rate, rate, &_nkm);
+	ccu_nkm_find_best(parent_rate, rate, &_nkm, &nkm->common);
 
 	spin_lock_irqsave(nkm->common.lock, flags);
 

-- 
2.41.0

