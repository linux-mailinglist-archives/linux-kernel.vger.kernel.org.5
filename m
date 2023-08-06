Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC4A77152D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHFNHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjHFNHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:07:39 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D619B0;
        Sun,  6 Aug 2023 06:07:36 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RJfr54g3Qz9sb4;
        Sun,  6 Aug 2023 15:07:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691327253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyHR6cW2QR6OnAUrfo88G/ExONveB495BGT7pOTWnE0=;
        b=l3KOqfbgTmCZkmEXjDTQuModwoc6v57f3zYbDbSaHQTCj524Oy/FgH0/1T1rWEx8tFW90Y
        YD6g1XSjJczHkzEW4CClVas++io+rH61uZ71nbgy2XVxANoVIEHoYWzzbIMPj5ajlqu5Kk
        4ilKdhqGpvYd/wjZd6+ujQCp71pAL9wBL+ImjV0C28z6wPQPMfzvJJK+K3jNvOQ21e5vBO
        oGCg+OQyZsMLO1MwW1Dh2JQLGfDGhRYH5kPDHCN/fvTc77CqA5ZrvUnM2uNCAF2Lvtf6yZ
        jWLybfN11ugOBBB+GgHgMlmI5dDutOLwVpPj2cmWb1eVhxd9dcjTvYu+D77+lg==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 06 Aug 2023 15:06:50 +0200
Subject: [PATCH v5 05/11] clk: sunxi-ng: Add helper function to find
 closest rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-pll-mipi_set_rate_parent-v5-5-db4f5ca33fc3@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=G9TxumF2IGfxEJiLa7uWr7K3JxoemmvIjofrmdkSxSk=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkz5sHqkjDz9bsW7VEf79eXkQGEmgFt2dyGd0Hw
 Cekysc4/WKJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZM+bBwAKCRCaaaIIlErT
 xwGhDACR9HIIL1q5cZAhnOzYErN7FS23jf5MPGkEw/xKvP1TWnnrJtw5YdwVJnlQSisFMHil2sG
 CqeLtCIUBHvO8kHwYpoINOFwpAuBLsO/xNlfXvWlTvtlG0CcJJo5lkf1RV5JJiWF83wptxGUzNA
 uDBACJU66Fu7Q28jFD6kMD70bfAGJ2ALPbZc8Mif8Kqy3l4Vq8ZVR8t1c1ueICA9i8/bjhuty9E
 4G1rwU0UDKJ8k0FnIpAlV4GidMI+Mc8xi8D6ZZkld4F5xD0WFtJrnvYZxr1RlL+ioWoGRJzI6HB
 S+jGAxHMOp3IYA4fbTACXDx8adSKEgJXBjeWewjdPsluDZ4tMzlHHB8luc7GxC8We+++AvIVj4o
 wR3D0EFs7VJpkctOqg4AlT5kmStPttAxxB4IB4aE2XSUHvYdFjhjMqINbV2OyUC7p+OXioMBoxu
 1toI56pd5lRNpdL/+EHRpUONkPO2+SIYQFEjqi0r/PSLWLa/GHuXheuAIxrpWHC9QGM9E=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RJfr54g3Qz9sb4
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

