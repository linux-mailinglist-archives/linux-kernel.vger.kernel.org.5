Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579857B3263
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjI2MW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjI2MWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:22:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ED81AE;
        Fri, 29 Sep 2023 05:22:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F813C433C9;
        Fri, 29 Sep 2023 12:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695990143;
        bh=8vtoklAMKyM/uK4ucBw83Q5gp7Y+EKU5jK8pCBlbL8U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=LJkRBydTdEF8m6PJ6TAORWNuGdfY737RwaM9YQR+BiFwiduj9WKSTO0xGoTmkhXzg
         ikkAt2TtVsx0ErhCJAZz+OTJxCUamFnqaS/CA1K9o7Uii7IQHc4fl3yJV7q691DKLB
         YUxDmq4FvVI29cL2QcXqf9IVa3XyoYBg7a8TirUw9kZ46qpegcJ99LPXtby7QDQAdX
         I0kaq9giaETMg9Y3M0mCHUFAunMso0xDIezCbh7y4PHJJyIilktOJE65vhovZ5jBD3
         I6fxjpOwmPuym2i1Ub+yPQfez+/ZRBgaly2Tv9yDLQ09oUHk0aVOqQxyv/hE2YdFoO
         208ep0sGid5lA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 14:22:01 +0200
Subject: [PATCH 3/5] clk: si5351: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-clk-maple-si-v1-3-e26cfcaf27bd@kernel.org>
References: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org>
In-Reply-To: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8vtoklAMKyM/uK4ucBw83Q5gp7Y+EKU5jK8pCBlbL8U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFsF3EDFMbNr3/tnRU+ZheBnfhZp8JxPFWy6Qr
 RSKNv5N0BOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbBdwAKCRAk1otyXVSH
 0K1GB/40CgeJm4giC6VvFiIsCIhIjhNrO0Q5RLmTQNe4F5X/eqruj9pd8SPwD5Szrk+cLShVYne
 yDPkh3dOBVhdHP+2JddNcjIjtERQnnA4lTlFcSE9EVRqThMlR7n4EYS+Hk7Vc9b/0FHu5+js2tu
 e6ARmv7dE0ROhqhIB2zOhBhYNU8CiL6f501j8Rh+W4LTNDr7D6G0c8plA7Gqc6uQDotO7bZ8Wea
 byULhNHBijIlKN3sIGTablPXsTMCL8RQX2vS11n+iu2uzs8paYDaEXBTc+QSSkd2zXQz895RK+O
 0E4WczOdOKWQCVoeAs3rowRqJ38CiZTec9vd2oPKS5N376TO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/clk/clk-si5351.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 00fb9b09e030..cbf7cde01157 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -206,7 +206,7 @@ static bool si5351_regmap_is_writeable(struct device *dev, unsigned int reg)
 static const struct regmap_config si5351_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = 187,
 	.writeable_reg = si5351_regmap_is_writeable,
 	.volatile_reg = si5351_regmap_is_volatile,

-- 
2.39.2

