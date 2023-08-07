Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D0F772477
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjHGMoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjHGMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:44:10 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657311722;
        Mon,  7 Aug 2023 05:44:08 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RKGGY36Knz9snc;
        Mon,  7 Aug 2023 14:44:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691412245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8ktluX8ISdNot5DVuNsCYEDtddUgFalgfYdbHRzW38=;
        b=v9QFVAcdrssP/cI8ELuc6Z9v/BvV7PtjZd6Ez6Xoe2FsJp1HgM5kqJ+BNOk9pawmzlkZfx
        xyz/nSkybAeOCu5kqRCsbNiO7imkOn5x0TnhYvWJEv7uuzLAsx4IJG2o3Rr9qRHMmcrKdx
        qfeXivqU5SiLf/ar2bdZkeFGxtoILavkp1N06z6eFAHJbvIl0LrcgECAW4umz4a+LRhqQQ
        JNfZKVxTWKs84n7jr3PppwO/nTRau6p7rjxUej9UL/nrX9rw+9Ybc4RJ1Q5SLXwgvODGsl
        leH83vQ4fupPbmCeDSLIDG7Pf+H6dNmBTGfZsXifmAXxbx1pBBga4CqncEKdeA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 07 Aug 2023 14:43:35 +0200
Subject: [PATCH v6 02/11] clk: sunxi-ng: nkm: consider alternative parent
 rates when determining rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-pll-mipi_set_rate_parent-v6-2-f173239a4b59@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=DhVDNfWw7/1aAXsxGZ2ImXUGfXIvkdSMT1LB/wIRtvw=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBk0OcKB1QCOVuSnP9f40U1kYo4xgG5KUuRdnVW5
 mC6MFJDoRSJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZNDnCgAKCRCaaaIIlErT
 xxYtC/92g6+CgrTGASkH/Ott8VxrMH8bycREhYf/t2+xQMjCk5E5e00rCo1JGKBcXlvQZC3UNDF
 Ppu1Divft8lTU+QR+x4rs4ycACV4EQ2SiKLi4AJlGDLBSk276R8Z6hUyqG1h+51+oV1Bv5rRg3V
 MsLmLpePWNmAFuNtPNkzv44Mnjsja7mFRcFLb9l1PD79McUTmXbmretcnW+aEh9HYuuXGpf+yhV
 h4zWqNcuwQUNwYMdYCkSxZ7ZpEUfCYe1bXpVGVEwqcJf+Xh5Y/yx4070guw7W4KIf++comIoVdj
 qp8toYdJ2vF05VZGqq62A1TQvJzoIAYxtCrBD8ow6RbsY7CxdX2A2Y5XBxa2BK35Jrpn1ZdLGHm
 2VfpeVuqghgdngI4kYk/1OCvU1+m9Cp4lumlgWYMPqwcVchCcj1eAmUNS8WjWnxPj+ikHVK8lYf
 e54ZbpL8ulSGHiHtgAZMVHAZ+oFukEWp9lycZoyzkryjnDWNUK9/8WOPOkTDTSoCQMUIY=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RKGGY36Knz9snc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clk/sunxi-ng/ccu_nkm.c | 44 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index f267142e58b3..2f60f3c33e30 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -16,6 +16,45 @@ struct _ccu_nkm {
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
@@ -124,7 +163,10 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
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

