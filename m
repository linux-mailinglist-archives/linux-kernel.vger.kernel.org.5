Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15EF756521
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjGQNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGQNfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:35:00 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544D10D3;
        Mon, 17 Jul 2023 06:34:54 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4R4NNq5hHTz9spg;
        Mon, 17 Jul 2023 15:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689600891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjFCY3HxW03cxoBZRPjTS+r4+YQ2i2FxYxF8BGQxqRs=;
        b=lqCftgPBqtnXs2n/n2lMayHb6woREijxYVm13HsND8SB3l1Y4qJ3Eq2HaxC5UQl2wJI/zT
        SJYJOeNEJ3sZjvPpvvqgdSrDEf7sbCdkq8imafn1yK+5vNAJ6lRrTxSkwcfxHaLs0d2d0u
        9lGPRqatT+/5C3Ohr4zDKQgmREJg4X6VyyvP84ZU2oi8UI6i6v5MrssVtx5c3QLeK640T5
        2j7i5f3K+w7DqDF54sUKk3B+2yz33CIFscESXSSPJz1mOFmqnJbJR9pFMA1thyYW5l/7Dj
        d7jT6xlIuVE6RDzslQzbkvU3EUKlVVYRiKHHkW0F3/c3i18jWqINHDvROfc3WA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 17 Jul 2023 15:34:30 +0200
Subject: [PATCH v4 06/11] clk: sunxi-ng: Add helper function to find
 closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-pll-mipi_set_rate_parent-v4-6-04acf1d39765@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2008; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=HKQcQnjj5qfhxp0P09j7Gl6Mbxsh+yyoCxFM8Ft7zNM=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBktUNnkE00hapfor0wr5bj5Dtq+dTlwCnMQOK+s
 ELOrs3x6XGJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZLVDZwAKCRCaaaIIlErT
 x2vPC/kB7w335bl9VHEBhhj2h+GQE8Tm+AEihJihO2JcP4vuBCX41g6ajVERRGp1AMsz/Q8Idlc
 zvXhmXWirHKdPNCLdBmuslbWZX2+PThnhwbTJhL6NfBB4bIm8l83IP2Wp1BIveLifnTiBqmHDtW
 Z4nWmHk695LPheIVjswfEznK1PVLV1NsRXPWBz1pUh7Ngfg6RRUw5VN17xB9t9+xsE41AJrd2hl
 nQibASXTfi1QKJdfYQ8NrW8xF2f0MbhcWoUGBJqZgvvWrZXsvtIHN/WE5/jea1rtz2ScD5f/qMi
 bQtMGxx96Qi3taoix4PZ4BX6+rCfAxPfYxFLMVOW8nBQyRiQ9hdETRG0hB6ZkSKpi2sR6rgOp1V
 0qsimH7eQI5ruaXd4RgUl2lqASGNSr7x62dCvhjVVsqVc2ZBQ8jkQRY2q8hz/5girb1zv9yOvn0
 dKeldput9qZJv2iOg2lJdSTTUP8rHTElyNGsfr8xBGTUh9z1dOdRNXnteDPSFRn41RJE4=
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

The default behaviour of clocks in the sunxi-ng driver is to select a
clock rate that is closest to but less than the requested rate.

Add the ccu_is_better_rate() helper function that - depending on the
fact if thc CCU_FEATURE_CLOSEST_RATE flag is set - decides if a rate is
closer than another rate.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_common.c | 12 ++++++++++++
 drivers/clk/sunxi-ng/ccu_common.h |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
index 8d28a7a079d0..8babce55302f 100644
--- a/drivers/clk/sunxi-ng/ccu_common.c
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -39,6 +39,18 @@ void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock)
 }
 EXPORT_SYMBOL_NS_GPL(ccu_helper_wait_for_lock, SUNXI_CCU);
 
+bool ccu_is_better_rate(struct ccu_common *common,
+			unsigned long target_rate,
+			unsigned long current_rate,
+			unsigned long best_rate)
+{
+	if (common->features & CCU_FEATURE_CLOSEST_RATE)
+		return abs(current_rate - target_rate) < abs(best_rate - target_rate);
+
+	return current_rate <= target_rate && current_rate > best_rate;
+}
+EXPORT_SYMBOL_NS_GPL(ccu_is_better_rate, SUNXI_CCU);
+
 /*
  * This clock notifier is called when the frequency of a PLL clock is
  * changed. In common PLL designs, changes to the dividers take effect
diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index 5ad219f041d5..942a72c09437 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -53,6 +53,11 @@ struct sunxi_ccu_desc {
 
 void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock);
 
+bool ccu_is_better_rate(struct ccu_common *common,
+			unsigned long target_rate,
+			unsigned long current_rate,
+			unsigned long best_rate);
+
 struct ccu_pll_nb {
 	struct notifier_block	clk_nb;
 	struct ccu_common	*common;

-- 
2.41.0

