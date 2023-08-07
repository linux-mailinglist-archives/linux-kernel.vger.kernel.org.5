Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3918A77248E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjHGMoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjHGMo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:44:26 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC391998;
        Mon,  7 Aug 2023 05:44:18 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RKGGl17cVz9smd;
        Mon,  7 Aug 2023 14:44:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691412255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5tQ98OlbFoBALCdfAJcGFpmCSr1McUfseOzgGp0PTY=;
        b=ccCHRN6NY3DW1K48ImhsJu9yD4i0iw5UynxoEb4uGbitKIkzMhxmFNiFYaGsRS1kBZ0TDM
        Qq84MFPBYAq3B4RdqYBvXk+8uMv4bGRhBtwWQT33B0aqnCEzoycue64+NrlOD0ot+xG75e
        teZxokiHfCvL4BR7rOGaRvsdi6NqnuD3rGrEK0Rd3erLRO2oHi3gliEQVznArO4y1ESjnA
        8JwxaqNu/R2YzPXq4Yd3t508ZMk6UkEpDBTPfRYJTPTLnlNyFxAjGKIRLcfaPViL5dvqUP
        FRVhqMrWGXhceOAFhNqDolU0YjPYeCVB1m206oUz/Rrls3TXMjn86b1IO0TqZA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 07 Aug 2023 14:43:40 +0200
Subject: [PATCH v6 07/11] clk: sunxi-ng: nkm: Support finding closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-pll-mipi_set_rate_parent-v6-7-f173239a4b59@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3842; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=MhP71vaxDH8c5zg0TT+00Y3yrnB4gc5lIl4iI9sXSDE=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBk0OcKJJBxSyYB7ebgHRDX5I5tMU1E8xNdRViiN
 vlu0LhdnnWJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZNDnCgAKCRCaaaIIlErT
 xzlZC/96ZiL2HTDvGuJrlUqavcGvc2d4pjQIpvTIsN11xzr0Ecjt0bYRIuyCpEcwFHZgQoVBlSu
 M1X/OcyGV2UAY05JteHix0yFbcQG2D+ceWrzqsn0MEsDgLWyi7Gd9bz6Jn3rrnYQPFvhAOmWy5W
 C4E2PQ3qX8d/nnZxkGOcbqeoq0D5MwGq0sI9CDaD9P03GCrLj+BTvAcAH3L3hpzlHzV5qsiWsYC
 2gpAirT6a8wxAABvkxWbIt4Onjm6qkhdIPBfvUKieZlP7RB1iGXZeu3+7CYoX27yBHbBTKeK9HQ
 CElaKhgW5AeZJjU56aemimv3r0ZBFI9oleMY9mMLapD4rEPMZSKHfCZhR2/YCehKh+xR3IV5MSA
 WUfB5nQG20yL0oLBQj4ikmG0qQ+GYsqs3ANqdx2SI3u1zVjMOSXvPFBh7GnSrW8pkHE4DDjPYK1
 NZY0Z80wWSky3SQ6bqlEvIXtdPzGBGIDFUCddKmgqC+jami7QdQlSLFfhLw9UqDNyKOhc=
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

When finding the best rate for a NKM clock, consider rates that are
higher than the requested rate, if the CCU_FEATURE_CLOSEST_RATE flag is
set by using the helper function ccu_is_better_rate().

Accommodate ccu_mux_helper_determine_rate to this change.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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
index 2f60f3c33e30..a714dcf0dfc1 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -16,7 +16,8 @@ struct _ccu_nkm {
 	unsigned long	m, min_m, max_m;
 };
 
-static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *parent_hw,
+static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common,
+						       struct clk_hw *parent_hw,
 						       unsigned long *parent, unsigned long rate,
 						       struct _ccu_nkm *nkm)
 {
@@ -32,10 +33,8 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *parent_hw,
 				tmp_parent = clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
 
 				tmp_rate = tmp_parent * _n * _k / _m;
-				if (tmp_rate > rate)
-					continue;
 
-				if ((rate - tmp_rate) < (rate - best_rate)) {
+				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
 					best_rate = tmp_rate;
 					best_parent_rate = tmp_parent;
 					best_n = _n;
@@ -56,7 +55,7 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *parent_hw,
 }
 
 static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
-				       struct _ccu_nkm *nkm)
+				       struct _ccu_nkm *nkm, struct ccu_common *common)
 {
 	unsigned long best_rate = 0;
 	unsigned long best_n = 0, best_k = 0, best_m = 0;
@@ -69,9 +68,7 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 
 				tmp_rate = parent * _n * _k / _m;
 
-				if (tmp_rate > rate)
-					continue;
-				if ((rate - tmp_rate) < (rate - best_rate)) {
+				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
 					best_rate = tmp_rate;
 					best_n = _n;
 					best_k = _k;
@@ -164,9 +161,10 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
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
@@ -201,7 +199,7 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
 	_nkm.min_m = 1;
 	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
 
-	ccu_nkm_find_best(parent_rate, rate, &_nkm);
+	ccu_nkm_find_best(parent_rate, rate, &_nkm, &nkm->common);
 
 	spin_lock_irqsave(nkm->common.lock, flags);
 

-- 
2.41.0

