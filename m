Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAA75651C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGQNfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGQNe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:34:58 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3505131;
        Mon, 17 Jul 2023 06:34:50 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4R4NNl62XSz9sTm;
        Mon, 17 Jul 2023 15:34:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689600887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/AP7UiU8qhdUXkhdNLxJOtFL/gExqBQUGjN0bV4ALI=;
        b=p/8X/pMDRn3VDPLMa9zLgWy+rJIex7YxNUplJXmFOQs6YGNqZ8+77rYfoLWuXmFTTOf7ju
        ppV5CGi8C4+BplaaYXXwPDf6ycWJ+j/hK0gyZ/5wSxA0SOQ+kz7dJI5gcJgewmCNnzzSVU
        ld/OkigUvNfkqojRM7wHBT3tc2g1oGDSeBpple/Dx/hiVnsWR7I+aK8i0RCnVC81lKooSN
        huhnH281gRXYrX9zpLlP/HQCjAIJ77IjDVI/K9yI0n5D6sK394ihjlYMcPuBYhmPSU+aHt
        DTqWEV8AlihINbJ27qrfjiXX9yu5b5WRSiMWMA+JpqNSy+lP2mjh3v7d8NkULQ==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 17 Jul 2023 15:34:28 +0200
Subject: [PATCH v4 04/11] clk: sunxi-ng: a64: allow pll-mipi to set
 parent's rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-pll-mipi_set_rate_parent-v4-4-04acf1d39765@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=852; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=MYgMUXDylKq1ueF0/z4NSPOcrbzoRllAat6F65tgrPA=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBktUNnxvQm4kVTKSzVBGDfgQtD8lSHZzj2+2z1W
 HNjRC5aMdOJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZLVDZwAKCRCaaaIIlErT
 x5o8C/9q96AvAhFPEi/8WLlv4yDjFChHVlw6zt991yUMF2Aq4UtVoMQdqNXVWyAUBGXkvOaoc+8
 xeIe582TfsjmepFqB1beJG2HyX4AVYpKb4cG8oh7wjgzVYBJWNXbCYc1q7FRSfUmpiiO9Oc3KHh
 2Ixd5hknOEwibM/9LJr67U0hTyAEJsi6W+e0SsyMybKw1xxMvx6WwvN2F6P+g08Vp8CW5QSgzUN
 j5LZafiUP+uEyVxgknLdGilQJ4nSwv6COsrqg/n6tfktXUeklQX3+kR0h+qT1Dkb23dwbc1EdxD
 CNkONrQZG4S7S5kj/AqrahT6YCFg+/FMNiZfE1NzyOvErvHqd6dJcVg0jyuWQZlncGnXsm+1qnV
 yrLIVO7A6O4e38svoOrJ+U246MjJgcR1O26CtaFQGaE1lNi+7qiCg2pe+xzL6Fe5MG5mKbsrv4s
 SLvEjCD8jdxlpdUNXOuAUq0f6wPJ0fl24fZ3mBR2afhmjYBZEdhu58TGzwW5YDgjHSCdo=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nkm clock now supports setting the parent's rate. Utilize this
option to find the optimal rate for pll-mipi.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 41519185600a..a139a5c438d4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -179,7 +179,8 @@ static struct ccu_nkm pll_mipi_clk = {
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
-					      &ccu_nkm_ops, CLK_SET_RATE_UNGATE),
+					      &ccu_nkm_ops,
+					      CLK_SET_RATE_UNGATE | CLK_SET_RATE_PARENT),
 	},
 };
 

-- 
2.41.0

