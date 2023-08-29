Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0DF78C5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjH2Nes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbjH2Ndf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8964719F;
        Tue, 29 Aug 2023 06:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0908065763;
        Tue, 29 Aug 2023 13:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C39C433C8;
        Tue, 29 Aug 2023 13:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315961;
        bh=BUv0dUR3yzGvu4wJm1+oQsHMjru5un0H9rT5BRsHxwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SURM7Ql5Zqxtk8leYdDQFmnwzsmKG5B6JKl+/dEM4qHsJ7S5lJ5z7bkpjBdWDWyv8
         kox/X8N07zmJEeXfl88eOIVjAbMhu5FVsCTtNc+LbNG5yu5Qn9ySeJ52ni9XG4EoFc
         1VlJQJlSntWjlwckvX0WpgmmWpwHIMqE3rPil/S0vPyHp7R90IZe8nEdryod94iAa1
         a3Ln8qca9cOi250KYyr+Kmwzi8BIhvPYzMAuq4l+YUz8WIIUVmIGsIQ6tWTn8W5OTV
         7ffRv8qKwySlyphvcvMo9Fy7BySxOYyZEAh/sR2DnSRejoSCa9t+OYCbSMkh+IMjvF
         q+XtfaBl2WL5A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 16/17] gpiolib: fix reference leaks when removing GPIO chips still in use
Date:   Tue, 29 Aug 2023 09:32:03 -0400
Message-Id: <20230829133211.519957-16-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 3386fb86ecdef0d39ee3306aea8ec290e61b934f ]

After we remove a GPIO chip that still has some requested descriptors,
gpiod_free_commit() will fail and we will never put the references to the
GPIO device and the owning module in gpiod_free().

Rework this function to:
- not warn on desc == NULL as this is a use-case on which most free
  functions silently return
- put the references to desc->gdev and desc->gdev->owner unconditionally
  so that the release callback actually gets called when the remaining
  references are dropped by external GPIO users

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5be8ad61523eb..6e7701f80929f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2175,12 +2175,18 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 
 void gpiod_free(struct gpio_desc *desc)
 {
-	if (desc && desc->gdev && gpiod_free_commit(desc)) {
-		module_put(desc->gdev->owner);
-		gpio_device_put(desc->gdev);
-	} else {
+	/*
+	 * We must not use VALIDATE_DESC_VOID() as the underlying gdev->chip
+	 * may already be NULL but we still want to put the references.
+	 */
+	if (!desc)
+		return;
+
+	if (!gpiod_free_commit(desc))
 		WARN_ON(extra_checks);
-	}
+
+	module_put(desc->gdev->owner);
+	gpio_device_put(desc->gdev);
 }
 
 /**
-- 
2.40.1

