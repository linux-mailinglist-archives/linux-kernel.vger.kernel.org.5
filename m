Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC9C7B34DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjI2O0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjI2O01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:26:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35A01B6;
        Fri, 29 Sep 2023 07:26:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F64C433CA;
        Fri, 29 Sep 2023 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695997585;
        bh=sejfCcVQti2Hi8yDe3f20hbpcbYbp6CNahq98VEjTTs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=D49Fy1gG40zXkfUkXiYPjOBhKb97foft4tMjLSqdeuevmDCDLa7D2Ld1lYNtaEGm0
         36MnJ4mi0480zSIXrgJQJWmVUT3zfBfuDOoYOIKLC1Pxr1fq01gkc1CzN3p4F2Jqu9
         M7ql95SbM2mi+lj4nWAQwL1trmZKC47Sg/4UXZONpPiUSVdq9QQ/MhcrUBf5xkxIxx
         mUrM03QVnF1jKzW28v3WZqUGVmVSQgJ8r4ZIFWqZYDrYZ9lrJzwpnyTYtbBJzYEl8j
         +ibijrMpNCzjWqMtS4o3MU4uAjsRVf8S929e+D1Hke8cOq82QnJRteVPKBC5QAtCOW
         LCNd5GrPShT6w==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 16:26:08 +0200
Subject: [PATCH 4/4] clk: versaclock7: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-clk-maple-versaclk-v1-4-24dd5b3d8689@kernel.org>
References: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org>
In-Reply-To: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Alex Helms <alexander.helms.jy@renesas.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sejfCcVQti2Hi8yDe3f20hbpcbYbp6CNahq98VEjTTs=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBlFt6HIXHja+8p20IPJvS0bbuD7/si4p9bG1/Wt
 xioKS4KFzeJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbehwAKCRAk1otyXVSH
 0FnhB/iiR9k4uSZN3HpWNB22ExzRN6CZnZk+i0JKce4/yfdm+6uiDrLQXWhDBeXiHOdT8n0ax6l
 J+FLIkEsUf1qFzM1qS+ndCVYCRgjTsaNQtOyhSwKnQN7hGIf/60FcK9B3Y8WxwxpHU4pWYysDFG
 BL0PQQ2I4S3NnyMxAYNMDXmelbXqYemwwJi5XoXTCJ7y0a7vLh/WRxO7bzht3Hu9NPf39G4Df76
 r9lg3jsdlKk0978s6N98kaquQISn388TCqsDeXuzaIlQid3GkM4lDMEYplYtk3aoVlhWO5pnRwZ
 t/FPmTkusYWorqWBFeL1aixT9LhihrD0Tjg8mBtAgZZFU1E=
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
 drivers/clk/clk-versaclock7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock7.c b/drivers/clk/clk-versaclock7.c
index 9ab35c1af0ff..f323263e32c3 100644
--- a/drivers/clk/clk-versaclock7.c
+++ b/drivers/clk/clk-versaclock7.c
@@ -1275,7 +1275,7 @@ static const struct regmap_config vc7_regmap_config = {
 	.ranges = vc7_range_cfg,
 	.num_ranges = ARRAY_SIZE(vc7_range_cfg),
 	.volatile_reg = vc7_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.can_multi_write = true,
 	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,

-- 
2.39.2

