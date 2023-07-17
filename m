Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9DA756518
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGQNew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjGQNet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:34:49 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF56D1;
        Mon, 17 Jul 2023 06:34:47 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4R4NNh29vnz9spM;
        Mon, 17 Jul 2023 15:34:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689600884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPWCHbaMIzPJhoorxt9HLF+kv4sZYegCcJXZOrRKrWE=;
        b=04fVJiZMhngVED/Pi8lx6h0xC5TrS3ghl8MRos+jdHoBkK4RYfzP+J7Z3OzHd+aTdwVxxj
        TZnQgTeq2fhVSyD8uphoqt4xtiCV2Is69RvL7XuoGpFqmF6FJt/esQ+5voG76rhwM1je8F
        52geNyGydIyifzJPVt765+jB4rrtvB/RdY8d1UQgI1Up21ClXHyy0wRLuswKdklq2yrF16
        1AoLcnxN5Y1Cp1xdQVL9CK4/cXzieSO/y2h2YQLEaQg/Riug5gIjL4Yuh5gpu/2VqlNGAA
        gHAoRWsUXDTdGIx6pRXpuW/NGyY6ph+lOA+s7mPQsGdMBlNYf3BqiZWsqdZ6sQ==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 17 Jul 2023 15:34:26 +0200
Subject: [PATCH v4 02/11] clk: sunxi-ng: nkm: consider alternative parent
 rates when determining rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-pll-mipi_set_rate_parent-v4-2-04acf1d39765@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=ln8ewZB8HSlEkTwEPnYVk2xiK3z7aFrdhE31L9k7BeE=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBktUNmBiTRyNBUXsoPkUobN7y+D/M84n6Ihezx/
 KIsuAQwbISJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZLVDZgAKCRCaaaIIlErT
 x8mfC/4xmWR7TpNRcNtu6On+oaAp0H/+K7AOZP1gdw1xLCJOXl9mGeYL7ljQLqfh8WF9eRo+6jn
 Tyo9Q3fpCcorU9J8yx75k+xqfWqL6SY7mnZhCBLOrhCypR1P4eaVkYMBwYaSHr/TDPBaIJT+u9H
 IXWYrd+KcYzTi17mp/d5zq1BhhOEjtE5GXSd/NQwYsT2KY13aR8crSiLulzaF9a91AGKfJSHY8l
 ajeMK7Ey5yjGWPwHQ/QIqeClx1wiIaqUi4svjaq6RhwhwhSJCTiFV2eBPFyBe/9QUXyA3h7qLPQ
 7cNdnijiR7KbMJHsGulPj/YbJtQaCLVZDyBv+GtVqxwupZ46KfJMaAE3IbmS5TAGnqWjgXbFNOT
 Ird7Nyy6Pno14Tyw13oi/3evBs/Z0Sv7qjrmRZO+okjE0sBG255Pzxq6204gK8j7XNOiI8379HO
 Jisb/I+ujmzOjXx0XsIJQLr0gY0xVeCg0J6JrlNp/ROiV25ZweDOoaSwdg0gWhF4i9Zws=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 44 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index f267142e58b3..750e2b8da24b 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/math.h>
 
 #include "ccu_gate.h"
 #include "ccu_nkm.h"
@@ -16,6 +17,44 @@ struct _ccu_nkm {
 	unsigned long	m, min_m, max_m;
 };
 
+static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *phw, struct _ccu_nkm *nkm,
+						       unsigned long *parent, unsigned long rate)
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
+				tmp_parent = clk_hw_round_rate(phw, rate * _m / (_n * _k));
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
@@ -124,7 +163,10 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
-	rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
+		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+	else
+		rate = ccu_nkm_find_best_with_parent_adj(parent_hw, &_nkm, parent_rate, rate);
 
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nkm->fixed_post_div;

-- 
2.41.0

