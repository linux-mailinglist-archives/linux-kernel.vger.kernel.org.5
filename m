Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB127B46CF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjJAK3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbjJAK3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:29:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC95BD;
        Sun,  1 Oct 2023 03:29:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEF5C433CA;
        Sun,  1 Oct 2023 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696156170;
        bh=/VxdOJAySw27/fj7UgHN0P2mUR/wtgUc79z8VGSGBAY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=d/tGCYPSNOGPIJO5ODj6h9+jq1cEKEsxUucq17SkuapczsSjGjXrarTH25YAkF8nd
         ysWK4Me9ijSdT6p/nmlEdNBZ2MICmWwEEtzpUb81Uw8IPLVYOuLJ1dr5GbD55/8gHj
         xSX+1yLbRWiqDlkkXMkFb5HxytjL+gPCpgGxgtVz7rq1KMg1SiCG2M63EbEinMTlCG
         NhyhmLnyJiLtb+01YOBLVL+5IidTeIA2iC58bUCuy53RIEX3KQePxIi8MaVhhpXRBp
         oLRSUMb7p3CtZ7XYJaoYUKOde7j9HVszUvIfiB5ureBPJRNEo9c4M7x4rvnCsRcJ2c
         YSkRdHQUoJwug==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 11:27:49 +0100
Subject: [PATCH 2/7] mfd: tps65090: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-mfd-ti-maple-v1-2-0657862de3f6@kernel.org>
References: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
In-Reply-To: <20231001-mfd-ti-maple-v1-0-0657862de3f6@kernel.org>
To:     Lee Jones <lee@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/VxdOJAySw27/fj7UgHN0P2mUR/wtgUc79z8VGSGBAY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGUoBQ4KBYoLQoPXhfYAXG3OR6Hy6IRKqDPle/
 fjj49263YKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRlKAQAKCRAk1otyXVSH
 0PjYB/98/4fGHM/WZVFH8dFcci6FwC6Lk/gr4eeyOSXpHxRAgc/O0RQ+MMdzyteujT31TsNlLvu
 F2x24VOhjAq8y2uX8HqodBhAGi+sQ994PlQ2j64NVfaxEWjoBnWkiyjxjk8+RPRtJ34rDL9ATlt
 jByRl2oz0WzkiWPqw03gzTGJwPOyVAzQJ4CLx0XI1UFO5ct1fJ6t5+eGVqb5GY1ZGrNBcnPtCVp
 h57r95BMVlXi9IzDBcoHpRVgK91kwpWg9tOWYgEbInWhgAIkf2m7UrOXnd23IJ3HCw9c0oOQ+gZ
 SOzpkkVXW5QGwmgcBGQ4jkK+xd7FnQCKveK87PgtqNiiyNCl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/mfd/tps65090.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index 9245e11219f3..b764badaa62a 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -151,7 +151,7 @@ static const struct regmap_config tps65090_regmap_config = {
 	.val_bits = 8,
 	.max_register = TPS65090_MAX_REG,
 	.num_reg_defaults_raw = TPS65090_NUM_REGS,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = is_volatile_reg,
 };
 

-- 
2.39.2

