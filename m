Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE0772478
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjHGMoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjHGMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:44:12 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E088170B;
        Mon,  7 Aug 2023 05:44:10 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RKGGb2b9kz9sls;
        Mon,  7 Aug 2023 14:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691412247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xI2XtQy9/8BiyYedLMS7iqa0KU9c36EUPArQdRGOxBQ=;
        b=JPaOJk3E74uICdzWH7geM/TOdGTORdg12KZXne32kB5hQ5Eaq8jmqtC0s8Gxy8LqwNbiJj
        uQN8RaVKsFjhHlT9kVYCr+nmnnNzMMae9wNvEWyhbVg4OzXTFynoJCCh2HT0W1goaF7fjx
        GGbbmA8tSuCHz2/BcC7A2Do2uQJybT/xvMrza+5jbxYZ+fTJhxkoI4burqpadXiT7Umghq
        vLVGrgOmHUn0aVwbPQil57J+CrVYCKX1cjNDjNYG/iq0CXxaN799K2K1xNvAgLcuGBbpaD
        YpKz/zcgLMBYG9xzxMHDNXDSiUfvi7YGL3NrB6a4PFpE6ijt33Jx/yS55+skBQ==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 07 Aug 2023 14:43:36 +0200
Subject: [PATCH v6 03/11] clk: sunxi-ng: a64: allow pll-mipi to set
 parent's rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-pll-mipi_set_rate_parent-v6-3-f173239a4b59@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=Lc6iH3J9lp5ZKkHkcprA7ejcVK33NT1XKW3ZK3AQRuk=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBk0OcKIr3rPts+hD8qdYeRNcF3WRTLwZuXLt2NP
 DF8xXpxA+OJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZNDnCgAKCRCaaaIIlErT
 x+tUDACOB7FWM73UvXVMgv8OeS0ZdBA1ZDO4RjI83we3tZwKMMzerbVQtuMM75inhl738Tcydqo
 0j1nVF0NO1Fryc8WSJS3qjKyAKBx+JzcslVc4NZuEYB4BNX5erpU9/RIoDEA7mf6GqpAt10KzEm
 rwuMfPXhxeCXA7Q8oyZUWg6LFxG2Wd42RFWADvglYRmUIbuE+795I9CMcyJH4O1gJpnf71HM3ua
 vxD7Gkuf5TnUWljt/VcWbIfwTP5hU1X+49SN4hJfxZ7+VJMPQfyE2tWiLMqcUQX6OTjZsdII2C7
 T1C1L03yAPaYmd8kcHaFwTE8UqEX4YS6QqtAVCeH6iVmJcV37jaU3J+JERTOJmOMxMznqPSMhD4
 oZYC3doPebidFJ66o+ERQhoPeCB97EO4akFxt70cZJzlMYPt7cUTxYdOwQXBOZPbcL2xYtEj3MD
 XrlatJykUOi/f/QH02GEyVme5CX/z9JGKEMjmEmuRc72EZMeX5ambV6pT711vHgsXLPmI=
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

The nkm clock now supports setting the parent's rate. Utilize this
option to find the optimal rate for pll-mipi.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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

