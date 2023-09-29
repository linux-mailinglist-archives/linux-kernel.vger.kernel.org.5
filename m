Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B367B3267
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjI2MWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjI2MWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:22:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3D31B6;
        Fri, 29 Sep 2023 05:22:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E204C433C7;
        Fri, 29 Sep 2023 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695990146;
        bh=z+E9FqmMooqeTUkGAAzYcpfLUQpFSaIKO0eZ8M0W6aw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=R2OXz1tvVM6eyDaSmQoh0yqlR5cuwoTz7mFvL9pRKxKuddkjHiWxz1Gt6ThlGF5Bm
         sdY/g12dnQ9EJtQM6sfr56Fpjy/kA2l4EZXbNms6rspl+E42SFGLJ9ftum8x3CykId
         /V9/bTZumKvNL3YZO7U8vzKgRjVkfarkJy1zF9QBRhJBwswDR1jKUM5ryunG/Dg70Z
         grIvs5nzZJmr6IX6ospLm09Xr4ih+N2s/Q+7UOjEIf0HzdovzRYw1YoW/rphMEBLRa
         8Ysv4ECs3rqPo4S2H13VP8EeEYZEG5qveC65zZxvbazbzBcZO3UVYuT38rDC1j95+b
         wOrRyuf5RrYAw==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 14:22:03 +0200
Subject: [PATCH 5/5] clk: si570: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-clk-maple-si-v1-5-e26cfcaf27bd@kernel.org>
References: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org>
In-Reply-To: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=broonie@kernel.org;
 h=from:subject:message-id; bh=z+E9FqmMooqeTUkGAAzYcpfLUQpFSaIKO0eZ8M0W6aw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFsF5rCANkVtnQAdulkqJy7Gm8xHCHbZFpLw76
 9D8dkGAfyqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbBeQAKCRAk1otyXVSH
 0GN9B/9V4oPLafy4LSkn7m9Br0ow2JF/VSv2VfrIRCFZULjYN46AFzON6t0EkE+g6rN6MT4Hk55
 ok4PPQME5uhxlhweH+H3BEIrkMsNaYEmkCgqxP9/mVSNZ/VtLWFfa1YSMy919U7a78sayR8s7AJ
 OgHcagJYQ5sinRcTlrBTOOqlvhRQ9UTWipky+LqP6fLxv50j5ps1e06NTZmPCbB7SiDlJCLOxsa
 4l8IjnVcmyTk2c2F0sxBKr6/FYJBsYXiIKc2y0mNyPLLcwKcVN/LAugdsRhizNEOIK9S36XaJ3m
 ZtutAeRpAcJySqBtFDa9nNkGzAQhP16MamDyj4gYp1E5K2gB
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
 drivers/clk/clk-si570.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
index de0212fb5f87..262f582c9213 100644
--- a/drivers/clk/clk-si570.c
+++ b/drivers/clk/clk-si570.c
@@ -392,7 +392,7 @@ static bool si570_regmap_is_writeable(struct device *dev, unsigned int reg)
 static const struct regmap_config si570_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = 137,
 	.writeable_reg = si570_regmap_is_writeable,
 	.volatile_reg = si570_regmap_is_volatile,

-- 
2.39.2

