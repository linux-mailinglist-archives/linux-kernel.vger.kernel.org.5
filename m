Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E996375BF5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGUHKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGUHJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:09:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD0A2D7E;
        Fri, 21 Jul 2023 00:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30935613F9;
        Fri, 21 Jul 2023 07:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1870EC433C7;
        Fri, 21 Jul 2023 07:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689923381;
        bh=fsrYWcK7YUDwW5EUZ1gn9ZIMVIGkgbU1ULCwl39qicc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=OrSgLaC56p8xHXAPqjWtxZzr/trelbbtbqUT9ykpv4alDW9ARvPFEChwjaUBbGT1S
         QTQFZ3a0/7Qlp5QyMT8vLcGaTGp11DdSxGufXkfIGN5jTyMWqNwZ9BpmrIcrnwmvfJ
         f0OBKLA6UKRdC4M+3/H8JRSPDAdOArE3Ny9K8c+TGaL5/MWAbh6/Fa6YhKw14BiE6x
         7tFj4EEdCYIxpM+e44S5Dlxgb8bM6wRT2ZHt9bI/AM0cQANFKc4+dJ47LWF1rv3vu4
         eZwnrPh8bwxfvbMeEviue0bCXxeWwvyfJiMBcr5h5DVmdJBNBR9+H/KDJLXv3HKmdv
         9BPuOsHiq5rpA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Fri, 21 Jul 2023 09:09:33 +0200
Subject: [PATCH 2/2] clk: Introduce kunit wrapper around
 __clk_determine_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-clk-fix-kunit-lockdep-v1-2-32cdba4c8fc1@kernel.org>
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
In-Reply-To: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <yujie.liu@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338; i=mripard@kernel.org;
 h=from:subject:message-id; bh=fsrYWcK7YUDwW5EUZ1gn9ZIMVIGkgbU1ULCwl39qicc=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCm79HWcZA2ZMsra5v4ouPWh9X3YAi5Wli77KqPXkVNP6
 Ct+LPjUUcrCIMbFICumyBIjbL4k7tSs151sfPNg5rAygQxh4OIUgIlMjmL471Vt6ry6ePPS/4pK
 utyRuy89XSl9ZUHLP3+pa0tZI2x0uBgZNufOdvkkFcw02+96FI/Qn0ipI/pxcf+5cmuqlrDxNrR
 wAAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kunit tests are meant to test the behaviour of providers but don't
run those functions with the clk prepare_lock held which results in
lockdep warning.

__clk_determine_rate is one of the functions being executed from a test
which should have the lock held. Let's introduce a wrapper around it
meant to be used only by kunit tests.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/linux-clk/2b594e50-2bbf-4a2d-88e6-49fc39f3957a@roeck-us.net/
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202301310919.b9d56ee3-yujie.liu@intel.com
Fixes: 262ca38f4b6e ("clk: Stop forwarding clk_rate_requests to the parent")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/clk/clk.c            | 25 +++++++++++++++++++++++++
 drivers/clk/clk_test.c       |  2 +-
 include/linux/clk-provider.h | 10 ++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8ee9bd02af76..8fdbfec6bd85 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1669,6 +1669,31 @@ int __clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 }
 EXPORT_SYMBOL_GPL(__clk_determine_rate);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+/**
+ * __clk_kunit_determine_rate - get the closest rate actually supported by a clock
+ * @hw: determine the rate of this clock
+ * @req: target rate request
+ *
+ * Useful for clk_ops such as .set_rate and .determine_rate. Only usable
+ * in a kunit test context. Use __clk_determine_rate() otherwise.
+ */
+int __clk_kunit_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	int ret;
+
+	if (!kunit_get_current_test())
+		return -EINVAL;
+
+	clk_prepare_lock();
+	ret = __clk_determine_rate(hw, req);
+	clk_prepare_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__clk_kunit_determine_rate);
+#endif
+
 /**
  * clk_hw_round_rate() - round the given rate for a hw clk
  * @hw: the hw clk for which we are rounding a rate
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index a64f7036baa3..b835e08892b4 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -2232,7 +2232,7 @@ static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
 
 	clk_kunit_init_rate_request(hw, &req, DUMMY_CLOCK_RATE_2);
 
-	ret = __clk_determine_rate(hw, &req);
+	ret = __clk_kunit_determine_rate(hw, &req);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	KUNIT_EXPECT_EQ(test, req.rate, DUMMY_CLOCK_RATE_2);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index efdebfa3fce9..43049f2c1dd2 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1352,6 +1352,16 @@ void clk_hw_get_rate_range(struct clk_hw *hw, unsigned long *min_rate,
 void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 			   unsigned long max_rate);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+int __clk_kunit_determine_rate(struct clk_hw *hw, struct clk_rate_request *req);
+#else
+static inline int __clk_kunit_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
+{
+	return -ENOENT;
+}
+#endif
+
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
 {
 	dst->clk = src->clk;

-- 
2.41.0

