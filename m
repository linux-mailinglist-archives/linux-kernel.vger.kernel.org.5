Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD525771529
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjHFNHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHFNHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:07:35 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167BC19A6;
        Sun,  6 Aug 2023 06:07:33 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RJfr114Plz9sNb;
        Sun,  6 Aug 2023 15:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691327249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g6sEdVa7J+6lcy1g1QB7y/EzCKzoUvGk1CHP/7ocrU8=;
        b=Wiw7MvMYMFpo64BhUYjRXXiFQY7BbMiKAK8oQHskLaKKEfFbyzF6YTkiGparTeS70oDGGk
        +OUWh+ahcoVKTzcPQ2UA24VUFCQCtkYRIY9gFPpJZYZ8CQ2d5IPx1DAE0t7Aqqa+DibTnY
        FM9NBaHuk8Crxq2eyz8WRSGwtNk8L9edCxWtNEyZzyHnDezsYvutjfZRrBAeqRURYkr1rs
        w6oJxeCbws/vWAiXJ4lkOqNVqxwn7JQHWXgPgUeIPUWwy2I+50mVwFOiagqNA+kyv2Bn4h
        bkxB9cbbNgYNeGn7U1bU8jpsh53rdiTvCSiGz1z45L8/kF1ewx+1j6NFvTJMDw==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 06 Aug 2023 15:06:47 +0200
Subject: [PATCH v5 02/11] clk: sunxi-ng: nkm: consider alternative parent
 rates when determining rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-pll-mipi_set_rate_parent-v5-2-db4f5ca33fc3@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2859; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=BoixBk50el6YgCVc74Xk+M8fXWIcHSM+fM1Ls01062E=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkz5sGvdjnx51+hIuZm7FBfXFWWJyiHnTdCyQ8u
 EoqWN2aEpiJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZM+bBgAKCRCaaaIIlErT
 xyyeC/0TF5kq/cc5XjwGXaNyO/SfJIIx/CEhiUrULFaTag9VAHiv1IvGZf4nyy9GyjNsrYVn/cG
 MovwMh2oyIUPItgCvk6tQE79NQTzxVMLFLRFSf1oe/sTF7DUUQcPp8L7BQ/zUsFv7NEauvgm/bY
 SyFguUozojqc+l6jZ6fB3EmzVNSg7sERADhJ61qHgiw2/rqi4iOS+uOxoAONEssXFgEoseus4Ig
 LZX+AQXTv0H0/cR4amA5Npgn1rCqUQcFANX7sYgfhRgWrt/dGfrib9+3jiWjs0f+iFf6GaAUUkd
 7eLkrIULHKNjczJ2jLNDH/qZ0qZqR9+mZ8BFg9TsFU26Vokm0NX3XfVAjUPdQygmyKfEG1f3OGw
 B4q1KlylxV19RB20Occ5K+7AbeNPR20rKXPXCk7hsrkROJiKWMlkyirni7GICkSyxdaLs/X8TJu
 17vk0aediTaMz2k+monA8ZViqBbKTekuNlfgqddCngsqrnqhA3Ctr7iAaH46IXBh9gt54=
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

In case the CLK_SET_RATE_PARENT flag is set, consider using a different
parent rate when determining a new rate.

To find the best match for the requested rate, perform the following
steps for each NKM combination:
 - calculate the optimal parent rate,
 - find the best parent rate that the parent clock actually supports
 - use that parent rate to calculate the effective rate.

In case the clk does not support setting the parent rate, use the same
algorithm as before.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index f267142e58b3..ea1b77e9b57f 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/math.h>
 
 #include "ccu_gate.h"
 #include "ccu_nkm.h"
@@ -16,6 +17,45 @@ struct _ccu_nkm {
 	unsigned long	m, min_m, max_m;
 };
 
+static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *parent_hw,
+						       unsigned long *parent, unsigned long rate,
+						       struct _ccu_nkm *nkm)
+{
+	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent = *parent;
+	unsigned long best_n = 0, best_k = 0, best_m = 0;
+	unsigned long _n, _k, _m;
+
+	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
+		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
+			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
+				unsigned long tmp_rate;
+
+				tmp_parent = clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
+
+				tmp_rate = tmp_parent * _n * _k / _m;
+				if (tmp_rate > rate)
+					continue;
+
+				if ((rate - tmp_rate) < (rate - best_rate)) {
+					best_rate = tmp_rate;
+					best_parent_rate = tmp_parent;
+					best_n = _n;
+					best_k = _k;
+					best_m = _m;
+				}
+			}
+		}
+	}
+
+	nkm->n = best_n;
+	nkm->k = best_k;
+	nkm->m = best_m;
+
+	*parent = best_parent_rate;
+
+	return best_rate;
+}
+
 static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 				       struct _ccu_nkm *nkm)
 {
@@ -124,7 +164,10 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
-	rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
+		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+	else
+		rate = ccu_nkm_find_best_with_parent_adj(parent_hw, parent_rate, rate, &_nkm);
 
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nkm->fixed_post_div;

-- 
2.41.0

