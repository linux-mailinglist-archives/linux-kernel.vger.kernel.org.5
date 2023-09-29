Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F5E7B36B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjI2PYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjI2PYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:24:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB9CCE;
        Fri, 29 Sep 2023 08:24:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBADC433CA;
        Fri, 29 Sep 2023 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696001044;
        bh=anSMO0wLoARN9dIrEDCmjrHsEo1QptfdT0Azmz+4gp4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nezdD6wE91NjhW3T8Dsrdhd0FPS/xY+sQRBNP6nSHF2wJ1fi4azcBZLYRx06vc+PS
         4qnwYKwkETkZ7Nvm6Z5rfVU65YSXwicWnTmMVh4SSTyOJXiBguRcoyPH1w5vAF6vZz
         +OpHaJ02OLsmcdZ/Wm83k9tcn3Cc76yjC1i7WL7IHAxN3gK4gJCchEsMIVbXiuDdyC
         3jv1c7JIS1FzHZ+lAbJ4OoLoeCGKgHGw9W3H8N1RsjEEWK+6zh+jV4aMEkkgqHAjH7
         mNEv6YhsqSoh7bx7nchXDiMG6Lc2X94EoMM4iWik9ZnEo+FBdU/bD7fT0pOdQjlQ70
         arsJXGLCW82uw==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 17:23:37 +0200
Subject: [PATCH 3/4] leds: lm392x: Convert to use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-leds-maple-v1-3-ba5f9dcb1e75@kernel.org>
References: <20230929-leds-maple-v1-0-ba5f9dcb1e75@kernel.org>
In-Reply-To: <20230929-leds-maple-v1-0-ba5f9dcb1e75@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=broonie@kernel.org;
 h=from:subject:message-id; bh=anSMO0wLoARN9dIrEDCmjrHsEo1QptfdT0Azmz+4gp4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFuwLY+XvWFRdzu+evIvN/Z81F88orD48TxyHx
 cxGL2FMZs6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbsCwAKCRAk1otyXVSH
 0GXJB/9dAfKx0BSdL/xm5/nidS0HiZpwmdt+/wwnYvyh/F1zXvtULOvLQR5cWxUKrh1J/5bTivE
 lLlJ0Y+EW4VA++GP9ePBkl0Kq6LN+f+m1TOrXCbI4X3cV0zDfhfpygMyoDa8eJ73TREPsMPGBSO
 QTXgxXCLyfbgreX0XfqX1mZCEt9jzE0GlmbCpzql0pEGlL1rjIi+sjH4IwrMblOL89EcPqWeZQP
 q690jtCapjhxSlDFfif5tmimk56h+fVT8N8Exdn5q9pOAw6d1UqKUg6mjZVYIWmo6StryAjUiTQ
 wvCysJZRi1RcZU6D3UdRxNP3sHVXFRLk4T8odUODgjXsEBrr
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
 drivers/leds/leds-lm3692x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index f8ad61e47a19..c319ff4d70b2 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -139,7 +139,7 @@ static const struct regmap_config lm3692x_regmap_config = {
 	.max_register = LM3692X_FAULT_FLAGS,
 	.reg_defaults = lm3692x_reg_defs,
 	.num_reg_defaults = ARRAY_SIZE(lm3692x_reg_defs),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int lm3692x_fault_check(struct lm3692x_led *led)

-- 
2.39.2

