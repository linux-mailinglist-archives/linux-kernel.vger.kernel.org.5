Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6E7B3260
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjI2MW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjI2MWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:22:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD61CBE;
        Fri, 29 Sep 2023 05:22:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE2EC433C8;
        Fri, 29 Sep 2023 12:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695990140;
        bh=uU6BchDTcioDE+msuC5ol+hgAsHPchG9dQMHXe5Agqw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=K/ZWB86q5PZAg6Lj4RErBAKNzMYkHFlSx+afXqGfdGw5o3RfdQbGZxsMgD03ECFTD
         +1zCWuZvHFGrpYWwEcWTykYFnGXBf/ncgBfIL6PooNEcpwoI9VV8H27SW8T2heMmyi
         8jHJ15oNvMSc6ezuH3Og0htyZoRqhY5xbN2EuMZzIsMkb386PEVCP3xK67f3Eyae2E
         dXD2uZR9iXMEvWSoFAnQa7Qx4XSxYUzGnGIUMi1Bk8bw3xkjQkMeUQxYysLntvJZnh
         qQ1HH8J6a7R9aATXnbYv8SG4e+UDj7TGGm43JI1lxlHgKUO9TsZbv4r1SiczWIz6BU
         UlvMOgabb2zXQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 14:21:59 +0200
Subject: [PATCH 1/5] clk: si514: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-clk-maple-si-v1-1-e26cfcaf27bd@kernel.org>
References: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org>
In-Reply-To: <20230929-clk-maple-si-v1-0-e26cfcaf27bd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uU6BchDTcioDE+msuC5ol+hgAsHPchG9dQMHXe5Agqw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFsF2oSp0bLsU6l5GRaB9UhQd50lHN4fsDZ3xu
 wUnJOSXAuCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbBdgAKCRAk1otyXVSH
 0E2mB/40dcBuve26+3Xu+ED2SLwp9FcP+Psk7MJEkz+2rcSnQwi0votUx8oNZHVMn1GSu/H+QC6
 6Km92X50+OWe8WPXHOpoElORiMat/pW1eKysJWrS3xjeoB+4h6vNRDba1UwDlTIzebP+/6LxKNw
 CDL+KBJ8oyLzlRmuOdxioyEYxi2X/gQW6ma84+QVgNAPrQLEP0t35r+wIu9GGE3SsT29JqlSBh5
 5KIiiVBScHR+LXwSbTuC6xFzuEGh5UT9P+kg4SVVMUSOz8hkBSadCYeWsc6O9O2lbKnO0pl+gB4
 w6jdOO3QGk6BU91Ffd27Ylqr+6YF/JAnPzVSxCvIKAH1T+Z3
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
 drivers/clk/clk-si514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si514.c b/drivers/clk/clk-si514.c
index e8c18afac184..6ee148e5469d 100644
--- a/drivers/clk/clk-si514.c
+++ b/drivers/clk/clk-si514.c
@@ -321,7 +321,7 @@ static bool si514_regmap_is_writeable(struct device *dev, unsigned int reg)
 static const struct regmap_config si514_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = SI514_REG_CONTROL,
 	.writeable_reg = si514_regmap_is_writeable,
 	.volatile_reg = si514_regmap_is_volatile,

-- 
2.39.2

