Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D67B44B6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjI3Xr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjI3XrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:47:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2B2E3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 16:47:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F965C433C8;
        Sat, 30 Sep 2023 23:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696117637;
        bh=Zf4nouYLYQI8tNrjW24H+mOK6Dz/QfC2ed/ykA58U2o=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=R9K3n3IYiHv3iGaeD7sC90ua9n0+6QbUnkxfXJKS0Lon6tYh9/NXYFgU5kQYqe9T2
         aq4er02THXK++Cp3TTL6M0f1GIx+k5Pls0pRPuSFuU3xjeckoCkcqNZlhlFUqwf4rk
         b51M1Vh9ET7BYKCiQEtD3rgoSjfAmoV9cUpR1jbD+kM1i5qAj6+4Oc8PmxeDLA2ySn
         LgfMMs3dTL2z4ljR+h+Qe0AvBd9CIY5YM90CqUTwuMCYEllag0nTRQnhAauWLhEcnn
         zE5Q020qVKjq/B8Rtp88A9il11nW/0CJJsmHSd7ua7up1RZzfmEB+e7BTHcuE7fpug
         CptqROIMnkpSw==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 00:47:07 +0100
Subject: [PATCH 3/3] mfd: max8907: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-mfd-maxim-maple-v1-3-cdfeb48a4d15@kernel.org>
References: <20231001-mfd-maxim-maple-v1-0-cdfeb48a4d15@kernel.org>
In-Reply-To: <20231001-mfd-maxim-maple-v1-0-cdfeb48a4d15@kernel.org>
To:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Zf4nouYLYQI8tNrjW24H+mOK6Dz/QfC2ed/ykA58U2o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGLN9ebrgW15PGuDGBqmimSB8too6np4V20t1R
 j02SOSAsCyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRizfQAKCRAk1otyXVSH
 0Mm1B/4ifuZKMIFFwFo7U9mnpZaY+Ud9MuQUcc8jadnokVNdnzvaZ4UINPI/DjweRkkFIWwUP8E
 fifPlPFBFAlUHLbJSXPGF2cYcsQ7Bck77n41CfRlEnf/gyW8s2HAIbgU7xqQnA1qveOHG3g8UxW
 3D6YfsULIVXtZ/qpwy6otRoGloTlpccZZ5GZnlmN5SPmRyiOw3P35Jdb8R45a678klKGceFSrQH
 xQf6bwc0KL/lGUZ8ADH1bfXTotUUFdwr35mTLv6Okjw6EBlc94pwRV8qRQSs6RP55KRkhhROYal
 UFUqzF3gaqAX34cebjzVmC/tnLJa+cp+BueKi+5Yr9pJaTqo
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
 drivers/mfd/max8907.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 8bbe7979db91..accf426234b6 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -63,7 +63,7 @@ static const struct regmap_config max8907_regmap_gen_config = {
 	.precious_reg = max8907_gen_is_precious_reg,
 	.writeable_reg = max8907_gen_is_writeable_reg,
 	.max_register = MAX8907_REG_LDO20VOUT,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static bool max8907_rtc_is_volatile_reg(struct device *dev, unsigned int reg)
@@ -108,7 +108,7 @@ static const struct regmap_config max8907_regmap_rtc_config = {
 	.precious_reg = max8907_rtc_is_precious_reg,
 	.writeable_reg = max8907_rtc_is_writeable_reg,
 	.max_register = MAX8907_REG_MPL_CNTL,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const struct regmap_irq max8907_chg_irqs[] = {

-- 
2.39.2

