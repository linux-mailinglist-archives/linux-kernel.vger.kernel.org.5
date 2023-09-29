Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D33F7B34D8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjI2O0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjI2O0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:26:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0FC1A4;
        Fri, 29 Sep 2023 07:26:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048A8C433CD;
        Fri, 29 Sep 2023 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695997583;
        bh=oBY3soSZF3SsFysTGE6a4Btp1eNwflyt47C1uRidxWE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=uShAj1BKI4qV+ZWq82jsq1cQ3GqJix/mYZCJafDp1fSn733PpFie2sjfDH9gGi6Af
         u5S6xbU0x9Bqhl3MpNq84tQrwxULfkSAzGKpp1gfpxjCquBC8nvpN/s97OMz5Ky3sc
         qLMwWK0IekDwJfgw6/3YyJow+4ODijM8uJ/nPdyAvYrqXgBC849+dVy8XvoaLmRdrH
         hIsrJ5j5F4McuplvgTD8Oiw5ooP/YHRy79w0JKHbofYfKIycLKMawpQSmDPRg13ay5
         TJ6/g4yxjqRmFR9hV+SQaozK5LwGUvYOR+W1vffpDzwQ7b5mAvF38ZcKLb6S4+OKUR
         /Z6rC4iijz5jA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 16:26:07 +0200
Subject: [PATCH 3/4] clk: versaclock5: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-clk-maple-versaclk-v1-3-24dd5b3d8689@kernel.org>
References: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org>
In-Reply-To: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Alex Helms <alexander.helms.jy@renesas.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oBY3soSZF3SsFysTGE6a4Btp1eNwflyt47C1uRidxWE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFt6GTzdwHoiUGD7uKWSyPtgDql6gcsZWsoEaK
 1u8FSkHegSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbehgAKCRAk1otyXVSH
 0Ki/B/0Yo7fANFWdcXWG2wo/wCMqLWi1fZD19xJsig5XJRajpdEqS72I3l2kQ8Lr+kz8MbQkLly
 i1n22pEkX4zwPz0WGB+F+hfQWsk84PzJiy3rx/mB2awh8JZYhsLAdnWcgChgWE8CEDUNPF6C0Tu
 ZEfUiW+1cOt6UKo4xHc6goqb/Jb7IhhGJc0dSd6Yi5Lt+gfL4wt8jbeTZqT71Uv+tkHPWHF+pLC
 q9cJ2Gu6lnJa/xMmrASw5RsbW4Ni7G9lCsnRq349B7rvcG+PD0UiFGQSyKeU4aK5IMzXd4k55i5
 jPOpL13I4G5XynPAKT1cZ12fqhJfz6VEuIVL5Qs6qHledWgs
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
 drivers/clk/clk-versaclock5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 17cbb30d20ad..6d31cd54d7cf 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -217,7 +217,7 @@ static bool vc5_regmap_is_writeable(struct device *dev, unsigned int reg)
 static const struct regmap_config vc5_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = 0x76,
 	.writeable_reg = vc5_regmap_is_writeable,
 };

-- 
2.39.2

