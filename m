Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FF27B34D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjI2O0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjI2O0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:26:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C3E1A4;
        Fri, 29 Sep 2023 07:26:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D45C433C8;
        Fri, 29 Sep 2023 14:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695997579;
        bh=Zw7LkgQ/jKyOg203queN+Fkkg1u+kROALg4WtGtfvCc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=EVH9jRguqswD55Xh3REVy5atRnfNRD7jy5K3A6PMZ2hwYDtVBPPrx22APc/fen2e5
         lZ8X3uPC6B8R71sKQO0GOiu+fr96b0gCpYCuOG3nmtD2fnI5teqJD/+EC7Ak1LjoLi
         6FcuZPfAuguQwCQsYWJIHGEuhfXqESB0aFarjt4bKyAKO0VmFaax8czh4pxKw8goDm
         efEd/jlZnA6/HQyYQ9otdA5xmZ2gZgQBXvQcXdix75pslsI8aWwrxEEwOen6fAZpEK
         AEKSM0k4vOdnbdkAtJNCzNVVyQUH6Dq0hNzBf0jBtM8JKbd8x/WMw1MxkRNDZhcPYK
         L5FBjWmvbtg4g==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 16:26:05 +0200
Subject: [PATCH 1/4] clk: versaclock3: Remove redundant _is_writeable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-clk-maple-versaclk-v1-1-24dd5b3d8689@kernel.org>
References: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org>
In-Reply-To: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Alex Helms <alexander.helms.jy@renesas.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Zw7LkgQ/jKyOg203queN+Fkkg1u+kROALg4WtGtfvCc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFt6F7PaipmJ69d/cW/ps7RCYA6xxUmTpTT6T4
 d+4P6XyfryJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbehQAKCRAk1otyXVSH
 0POhB/9KpT0m755dGN/X1/7bXWbyfTwS4nPkXjX8GlPt9lmLuyvpurVy6QnVnn/beGfUanJKlY5
 nQodCL8Y0nH2eHq9oBl216ODJznp+p5Z7KohuuGVkdEghB+tWUyDtC7sI2PQSjzPcpwsxIxO0V8
 GzTG/7Ogxa0WFUxK1AtSb+ruFt2jLWkAvtfKiW9dtO97j0sCm00M+c8B18OAC2gVSLZuoZdg8/c
 R32MJodHAJFAeTuaGMUf3ex5G3AHq0kcJZS5zcSxBwgHa2wV9WNAy45Hg7Ltg1YHs2W7/kiaxwd
 bLO3VUgSDgPjO7jI1WjSRhMut2c1VlKSmDsDbfobn5BhKe/Q
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

The versaclock3 driver provides an _is_writeable() function which returns
true for all registers. This is the default assumption for regmaps so we
can remove the function for a very minor improvement in performance and
code size.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/clk/clk-versaclock3.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index 7ab2447bd203..a5ab48ff242c 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -586,17 +586,11 @@ static const struct clk_ops vc3_clk_mux_ops = {
 	.get_parent = vc3_clk_mux_get_parent,
 };
 
-static bool vc3_regmap_is_writeable(struct device *dev, unsigned int reg)
-{
-	return true;
-}
-
 static const struct regmap_config vc3_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.cache_type = REGCACHE_RBTREE,
 	.max_register = 0x24,
-	.writeable_reg = vc3_regmap_is_writeable,
 };
 
 static struct vc3_hw_data clk_div[5];

-- 
2.39.2

