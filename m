Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD6475651B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGQNfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjGQNe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:34:58 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAFB103;
        Mon, 17 Jul 2023 06:34:49 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4R4NNk0BPCz9sqj;
        Mon, 17 Jul 2023 15:34:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689600886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxSpbKadXwGFFmICM4KCVhlYhVMAa5nTGvXXvvCR/6c=;
        b=C8pe7OXk8RmslfUhyHWhNO1IAtnp2revBFmvlWYWs4pPEwjPuzxgx4oGVOm/nj+6w3TjzE
        /byQuUXA3cFygxHe6MO7QXpb6p+rP1xlv8EDye4yJ5GSrKwhSin4zrB6or+fQKoDzrdSDd
        B70RVo2tyg+/NHo/rVYnUi8xgOHpMj03QzG8Z5J7fN0XHE8rgQczeMQsKRFmYPqEFLBUde
        8OOogZnIznjMwQjqkNBYU+UJUkcCPd9FLtbICDR1lPnRHsSFepaZS6fY4kAVYC7Wz+bXke
        hbMNcyY/kM66phckmFXXIwlgojxvAq2nNFtDqxu95dnComl3b7wyFAZRILDXqQ==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 17 Jul 2023 15:34:27 +0200
Subject: [PATCH v4 03/11] clk: sunxi-ng: nkm: Improve determine rate when
 setting parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-pll-mipi_set_rate_parent-v4-3-04acf1d39765@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3162; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=ybYcatfzXzLhtH3Us9O9aTKgAbrOK5YclAuVqdRWKwM=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBktUNnbBuKGKMOIVIPQcqh33VQB7vClVkKoHIDR
 onfsZc+Gk6JAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZLVDZwAKCRCaaaIIlErT
 xyBjC/9k/2f+UphH0jsSxuPMHBPNOkwewxe5ctT/T+mDGggMT8aTLtvJTrBkOE/+QkBYPZYwzVn
 PjJh/JJLKKxSno6MIYixIr1m5N5sEiN2IdnbXcQ7FldjLxmXSFkuIBPft4rMCefIorle4AWmRkt
 4j2hyOjn5oevtUQ+/+XyixdE4kdu8/cXW24bxdu5zNWkA33EkFL1qNHrmCImPOqv1r28nhZmGuN
 uSO7XCCclDwDLJ23OrGCKXl7WCFFTkiFhHjplSOEChoYDQGwO+flDmtjpJ67CZe21pV/ZcglEES
 Tria8vZKA737utAYpVjz8oXp/SmzcaZ6MQMTyXAepfwRaL/Ndq2ON5rjS94/mlFxyV8SNYv0kld
 k33OMm1FSdXXIP2MIpKSiC0+bJSQ2JN8Mi/JaLzlHxUjRgQtrpj75TI+V+pbC+OH0x/S3yAoPDc
 pTzVNaX5rs05gNeQ46W2fMz7KWwGutatxTlDXuDPrqD11nUmIuthZ24Zfk00qH4+qrkm0=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4R4NNk0BPCz9sqj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the SET_PARENT_RATE flag independent of the parents round_rate or
determine_rate implementation.

Currently, the algorithm for ccu_nkm_find_best_with_parent_adj simply
calculates the optimal parent rate as
    (1) parent = rate * m / (n * k)

Due to integer division (1) might return a parent rate that is too low.
So using this value for asking the parent for a rate it supports via
clk_hw_round_rate causes problems on
 a) parents that only support finding rates that are lower than the
    requested rate - which is the default for sunxi-ng ccu's.
 b) parents that incidentally also support the truncated rate.

In those cases ccu_nkm_determine_rate might return A' when A is
requested and A'' when rate A' is requested.

Prevent this by trying to find a parent rate so that
    (2) _rate = parent * n * k / m
matches the requested rate exactly, if possible.

Background:
===========
determine_rate may be called multiple times by the clk framework when
setting a clock's rate. But the clk framework expects that the values
determine_rate returns (i.e. the rate and parent_rate) are consistent
with previous calls.

Specifically, clock's have to ensure that if determine_rate is called
with requested rate A and the best rate it can find is A', it must also
return A' when called with requested rate A'.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 750e2b8da24b..793160bc2d47 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -17,6 +17,27 @@ struct _ccu_nkm {
 	unsigned long	m, min_m, max_m;
 };
 
+/*
+ * Calculate the optimal parent when determining the nkm clock's rate.
+ *
+ * This function is used when the nkm clock supports setting the parent rate and ensures that the
+ * determine_rate function returns consistent values. I.e., when determine rate is called for rate A
+ * and the best rate it can find is A', this function ensures that determine_rate will also return
+ * A' when A' is requested.
+ */
+static unsigned long ccu_nkm_optimal_parent_rate(unsigned long rate, unsigned long n,
+				 unsigned long k, unsigned long m)
+{
+	unsigned long _rate, parent;
+
+	parent = DIV_ROUND_UP(rate * m, n * k);
+
+	_rate = parent * n * k / m;
+	if (_rate > rate)
+		parent = rate * m / (n * k);
+	return parent;
+}
+
 static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *phw, struct _ccu_nkm *nkm,
 						       unsigned long *parent, unsigned long rate)
 {
@@ -29,7 +50,8 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct clk_hw *phw, struc
 			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
 				unsigned long tmp_rate;
 
-				tmp_parent = clk_hw_round_rate(phw, rate * _m / (_n * _k));
+				tmp_parent = ccu_nkm_optimal_parent_rate(rate, _n, _k, _m);
+				tmp_parent = clk_hw_round_rate(phw, tmp_parent);
 
 				tmp_rate = tmp_parent * _n * _k / _m;
 				if (tmp_rate > rate)

-- 
2.41.0

