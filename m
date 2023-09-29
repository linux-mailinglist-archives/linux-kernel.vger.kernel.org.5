Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79347B36B8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjI2PY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjI2PYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:24:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945F3F9;
        Fri, 29 Sep 2023 08:24:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8530FC433CA;
        Fri, 29 Sep 2023 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696001041;
        bh=fBI8cLuaLqO/WvsGsTIjx9QYgkX5kcaru537d1XBIGk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FiPxc1DX0kRzVLJPOSmQQjuSHZrL2XDKoN7J7hRBl7/wHiUj6DAw8vtQhZjezko4P
         HtD55GIn/TTg0IIuf6K2bcK4DUNgCsMQ3LwQz0uHdkBD7YH0dUuQBTVPpxwiDZ1P/M
         h5QP34tcBlDwqJ4mfs07a+NbQQu6j8G1W5H9d7nmRlOERGm3FdE2l+9hupiAvQMCch
         2MuIrYgGT3sezwKag/hrvOpV0SQe+xPfnQmzMN1JiG2Xgwy08MDo6DsiyO5pnPPH7H
         iUY+RCPizJTg304Bx+3HUwqK7lEYm9Cwf+RdPVWolak76vYJVKXPl+/IcCtOaP+oyY
         rtszyJWKDg3Ag==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 29 Sep 2023 17:23:35 +0200
Subject: [PATCH 1/4] leds: lm3601x: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-leds-maple-v1-1-ba5f9dcb1e75@kernel.org>
References: <20230929-leds-maple-v1-0-ba5f9dcb1e75@kernel.org>
In-Reply-To: <20230929-leds-maple-v1-0-ba5f9dcb1e75@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fBI8cLuaLqO/WvsGsTIjx9QYgkX5kcaru537d1XBIGk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFuwKFGbKnC9uP/YHFPKf8riLwqgsVjOGwaB35
 8Lf1/EvqFyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRbsCgAKCRAk1otyXVSH
 0KTYB/wMYjyI8KbJo9B34uzHVBi1v7vJfYnihs1e2cMUWK6QE9Hs5behqyelt/absOQyVA/oHVz
 EEAS7mabv94Fg5HGeMQJqg9y/TDUFqCyHH9HZa58AA2TLUQP8u1fR4/UqMK7e5LS92K3B9FQmqM
 b8s4r72v4r1WX443CgR15cmygPmxcZmBI4VIe25CD2ZEsvYvv/3Biai+vhF5jL/cQujJGlq/P7Q
 AOafnd3esLHvmMpRh5qwm1pby3xkjPylOHnpWtTMXaB5US6QWYSr+Dz3fVWvuAhLvQb3Ln4S3UB
 bZEr0UWow58Up6wNGwecsZQJh7PpYpkX4EvAOA1UXXEHEC9g
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
 drivers/leds/flash/leds-lm3601x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/flash/leds-lm3601x.c b/drivers/leds/flash/leds-lm3601x.c
index b6c524facf49..8191be0ef0c6 100644
--- a/drivers/leds/flash/leds-lm3601x.c
+++ b/drivers/leds/flash/leds-lm3601x.c
@@ -123,7 +123,7 @@ static const struct regmap_config lm3601x_regmap = {
 	.max_register = LM3601X_DEV_ID_REG,
 	.reg_defaults = lm3601x_regmap_defs,
 	.num_reg_defaults = ARRAY_SIZE(lm3601x_regmap_defs),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.volatile_reg = lm3601x_volatile_reg,
 };
 

-- 
2.39.2

