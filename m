Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E6772485
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjHGMob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjHGMoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:44:16 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71261721;
        Mon,  7 Aug 2023 05:44:14 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RKGGg2jgtz9sbF;
        Mon,  7 Aug 2023 14:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691412251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7S6C5RiSumrJfz42U1M/i1EZIbkB/8kA+J3OWBudPh0=;
        b=mxX90osoghfcoNAkh7pt+Q3K/V5cbYvVVLIGr/gPOalFU5UlXbbSVazySe0pVlKhrtVpLB
        XDSoLhFTVctlrfLfFtzvbuj7lXhuXyZbIlwaLN9NDlcDBQFAVXV6QdnrDG5fUzYW5WZe08
        xhwZXIZlD4asy+Sz1c1O/YFTyufY5vkGhHY8ryRFYQrG2qoLtCAZgYr0ZFZZFTeQmnx5fa
        2PCtdO2gg1UB4qAt7MTFFOUcBs3f0W8Vi40Q+n3jOTL8y1Xdp/KXL3RlRIEuknuNLKKb3z
        f8oMiA4ukYn+6iTos7KcsYbpOkVZaanBCRYJMzfpFazI8dgEsin+yiq22eiKTA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 07 Aug 2023 14:43:38 +0200
Subject: [PATCH v6 05/11] clk: sunxi-ng: Add helper function to find
 closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-pll-mipi_set_rate_parent-v6-5-f173239a4b59@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2110; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=GNz6YFitptd/iU8xYw3UneQLsMtDUEwC7Tg8y73qcgg=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBk0OcKJH/KZtB8NiUE9YPrjmIq0Yfi4KAlgUVWK
 vYSXi6ILbyJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZNDnCgAKCRCaaaIIlErT
 x+czDACS1qQUFTkA+fXSqlWeYYcYXJMNNT+MBRXjQX4wyMvsNUoPl94gTdVpG085tWfFhY2uWY/
 92iw9E++jfBc5ru8JUJ8iG5AKEUB9YMMpebC+R4YFYuIaowcTPficLov3ysOwJ75qeGJMIhemIp
 ZpoCvzVV2RtLsljO0yxdYRcacOQOALMkfh+k1fQ3Wwf5bx6hcwZd8Wc1ON9ggNmjTxaj9oXthXG
 pLF3awM7aiC/fcxsMDDM9VOwflw2mIJG7ZzYq352t9KGKQGCyxJB0pnxot5Ul1mXnUTT6Gpm6Le
 TZNdTYtcVYFOT+9j1L8ACGa0vU23/CcKyoNKSnT7iJXLbRqMnv0/wOWzOjohrit2eJoxxes88vo
 A/c39ja4ItA+VQMFGddj+G7Nc6jnqpug9fsx0nj7vmasd5mqaij6e06jkFkH5LFphq0PG3zlChR
 jORG2gX8aoYc/6BwWdy3O3uigqLj7sqTCoAMp75uPLCZC4YPClf+6OJAJmFEMeOpqIc88=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RKGGg2jgtz9sbF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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

