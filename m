Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30FB7B3264
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjI2MWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjI2MW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:22:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24912DB;
        Fri, 29 Sep 2023 05:22:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1590C433CD;
        Fri, 29 Sep 2023 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695990144;
        bh=9EKJr3PFIh1a+gXECJAJEOLaisQanpB6Fd1nMoqT75c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=p2bhIBbji8BE4KzrRh/JC6VOWPQiyLqJb14zTJE68vFrS8I+n2/XVR1N1Jbf7Zep7
         hed0oL+5lmJbX1sAcwDvZO9jPlek4mWtkmGqWDrXce30Iq84PVgXFl3GzyO8jhrnLq
         Zc6H0Z+6g+dBuGxzMHduZdODd0gfB/j+7VP5xR2fh6Bz5q7SsPow13lC7X4KifrYcn
         ZZo+CtzzSQffUci2LGlTRCDT7aMBd8Po/HhyDx+wO3tUVh0Qqc4fBtUa0hx84itRIw
         KhpMhLvtb5sV69Pt27AM1gmnt+t7UgnUMWvXQ9ePNQzuWpkC87dd6nzV58QcvaVwdl
         oHiCb1yDm9eJg==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 14:22:02 +0200
Subject: [PATCH 4/5] clk: si544: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-clk-maple-si-v1-4-e26cfcaf27bd@kernel.org>
References: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org>
In-Reply-To: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9EKJr3PFIh1a+gXECJAJEOLaisQanpB6Fd1nMoqT75c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFsF4mSCHwgxsTDAnCuZWOH2Ao3eb+t+nUH9bY
 7u1hd9LeByJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbBeAAKCRAk1otyXVSH
 0CGZB/98CAjKH0f+BDJZS1XcXWoQ/rktRibb/ib5h4WebPFbFhD/ld9Ed3CMDpO5EUUMg1trIua
 wrzM3EKapEIJbVjwdfG2RI79L+5Lw+ztsvuZH2ORRghyKg3vxDzOVq/42e7QBJ28eABqskQGhEA
 W8Y+zLQwaCMkhqrgOa2itEbwyadJViLpkj/GCzS+/R0wPDF1L0AyTCnR047x/HltZO2h05Gv7yp
 2AHn65VzJx+8pK0sgaKflYU1PZw0FFz+3RkDSOXykMPPK72Oniym1DL3v1nz949CMFEM78K12Fi
 UU3KakHEi6vC3wbXno85ItpXq0esygzKEotrPW/2OOP4/ybP
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
 drivers/clk/clk-si544.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si544.c b/drivers/clk/clk-si544.c
index 22925968aa35..c4288cf83f9f 100644
--- a/drivers/clk/clk-si544.c
+++ b/drivers/clk/clk-si544.c
@@ -446,7 +446,7 @@ static bool si544_regmap_is_volatile(struct device *dev, unsigned int reg)
 static const struct regmap_config si544_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = SI544_REG_PAGE_SELECT,
 	.volatile_reg = si544_regmap_is_volatile,
 };

-- 
2.39.2

