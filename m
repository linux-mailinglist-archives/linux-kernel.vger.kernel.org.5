Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70EC7B326F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjI2MY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjI2MY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:24:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108431AA;
        Fri, 29 Sep 2023 05:24:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C678C433C7;
        Fri, 29 Sep 2023 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695990265;
        bh=4tyGEKQoD54F309kzc3I827i2mFS05bybclL1pdrQwE=;
        h=From:Date:Subject:To:Cc:From;
        b=tpDrWTuo/4+eCC3qQDiRvbFszen09z5iV6FDlyNTMFzy0hSxVVhheKjcWZA9GUyVr
         qfJYzbqd6Es6kmEZhQpMsxo6fvCP/VxrvudwGTY8qK1HbXuyb0M3eo8XsO4Mi2kbdi
         maiqC52tDXqfynBDJmSIoD3xivGCt2UaQnnxkU1x3UUUrq5IzD9klxH8DAgJiSnW5Q
         80nujpgJjj7kKnLEGEZjwZACUztFC30ePMhWnKv7ZM0fZ0bHACSIznFxOrXF4r9XSb
         BbJdT48FJ3/4g0xFLLBXok0TTmZiPaR6ntdl+l8UXtSxaioLuFZbKquGcfg9kspbZH
         njVpuwXHzUeKA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 14:24:13 +0200
Subject: [PATCH] gpio: pca953x: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-gpio-pca953x-maple-v1-1-d7960eac3d07@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOzBFmUC/x3MPQqAMAxA4atIZgO1xSFeRRz6EzWgtrQgBfHuF
 sdveO+Bwlm4wNQ9kPmWIvFqGPoO/G6vjVFCM2iljSJNuCWJmLyl0VQ8bToYnSFH5AOp4KCFKfM
 q9Z/Oy/t+BVVPJ2QAAAA=
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4tyGEKQoD54F309kzc3I827i2mFS05bybclL1pdrQwE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFsH3FTgOQsdLN/QvqjPLMtHT3+ayhsSDRQTRd
 5dgzfnWhQeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbB9wAKCRAk1otyXVSH
 0AYjB/9blw78FadCL9NV5VZSOajO7XbH27oggZPpo65Nu7Ee1I0/SclFoQdZgmzg1dJP992uCxf
 WDlRnKqO2RlNfIfBlZobqKv8n0wbzaGYS0CkssGm3v9sRMuCiDhcp2VX5vHio5CI5I9ILpvsRy1
 biSVaYfv82WteyxC5PVYN7s+gS4JH/1kHpmNR+EheN2kibObAObCBhbSDU3doGOSZXsUux2OXMQ
 tpJlQszVmvwnty1GS1CUEWgIHcuZ6U4hpkvdh3ibThRC+N5x1j2hALXmfTFKCdeTGFt6Dp+pRTf
 21kzLPK9//Yr6GWvhFIUE/TRp3mCFFPS8IzLXuDthwRL+Lnm
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
 drivers/gpio/gpio-pca953x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index bdd50a78e414..528ccb59b52a 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -414,7 +414,7 @@ static const struct regmap_config pca953x_i2c_regmap = {
 	.volatile_reg = pca953x_volatile_register,
 
 	.disable_locking = true,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = 0x7f,
 };
 
@@ -430,7 +430,7 @@ static const struct regmap_config pca953x_ai_i2c_regmap = {
 	.volatile_reg = pca953x_volatile_register,
 
 	.disable_locking = true,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.max_register = 0x7f,
 };
 

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-gpio-pca953x-maple-b39b99cd90db

Best regards,
-- 
Mark Brown <broonie@kernel.org>

