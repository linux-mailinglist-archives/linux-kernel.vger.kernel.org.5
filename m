Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8D7B34D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjI2O0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjI2O0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:26:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9CC1A4;
        Fri, 29 Sep 2023 07:26:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DB7C433CB;
        Fri, 29 Sep 2023 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695997581;
        bh=PHkW5LlzxtfJIOrjyeQ0VbxZvJkl5oNvN0r2Mt8D8ME=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=joAt9QG+o3YOlBmYoMVZWtJ+0RZIpPxHF+jYHtYkx26jj5BS4zPkUxaVMEhqhhqOt
         oK7PwNeezJYGqmwMuXg98d28FcoTpocEA9GZmlxgUQsbJqHselHh5/VMsXM3+sg+MI
         xa99C3BgxICmaIIOIzSVojnAD1fz/WZsbQyKwp/HoUYQwHbs/aPCSfxDGyJej2VeTT
         M6DBhEIOGknxGn3m3Ms/HGPB0g52YMoOIBl3kZmWkpBrkOC7o/vLb0+13XZFnwhoE8
         wwh3gII+2Msbvx1k7bFBlMwnhq0t9ag83hIgUzUZnH3E7+PhsKRrsRRnewDq2hC9GJ
         mk187n2YNpRig==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 16:26:06 +0200
Subject: [PATCH 2/4] clk: versaclock3: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-clk-maple-versaclk-v1-2-24dd5b3d8689@kernel.org>
References: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org>
In-Reply-To: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Alex Helms <alexander.helms.jy@renesas.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=837; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PHkW5LlzxtfJIOrjyeQ0VbxZvJkl5oNvN0r2Mt8D8ME=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFt6GcPViAAEpgq5/50KiAU465RMOR7kGCWMPj
 OfFdxpeJT6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbehgAKCRAk1otyXVSH
 0BMfCACD2noxzhF9tu6nOaX1jTUd6aNVy8hgdg0p22j9mYHk2Jf8zWn3t6IJ9SYqwnkc4Z3UmyL
 9UzT2s6UBSXWwaUtV9C+liNEZ/EbQifMMEvOqQ0FLEtgYW0/EOYAJH/BXPTHS2MOspi/Uw+S3qV
 j6bm3GPFCSAj0G4sQw/B6SgdTGlgQdx+U0TBRGvnKHmRjzuzlNQYcGk3mFB+rIldayb+fxvyKAZ
 qzYtk/HnvBpOSxA4kXZUJ7M7lDxNFudNoZ2QBefQ7M/GUmtps57BAJFVsYqlu15DsIYNrYO/0jy
 Gzl3p8XALIibrs9DKXblSzWpK4X8o4AukFb30M4fPBlpgxTn
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
 drivers/clk/clk-versaclock3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index a5ab48ff242c..b4a89c083c11 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -589,7 +589,7 @@ static const struct clk_ops vc3_clk_mux_ops = {
 static const struct regmap_config vc3_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = 0x24,
 };
 

-- 
2.39.2

