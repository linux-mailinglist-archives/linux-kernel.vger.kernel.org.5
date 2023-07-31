Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFE876A201
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGaUfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGaUfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DD8118
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC47C612A4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0647C433C8;
        Mon, 31 Jul 2023 20:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690835735;
        bh=SqoZhNkMbULZnSpK8mWm/QgqaYLUyltlcxLo45LuySM=;
        h=From:To:Cc:Subject:Date:From;
        b=rccM63VZ46bK2fuV/vc1E6kASLsXmhqw0Lw7Ufc09lcQJSp1VDFeRS5CNcznXnpi/
         nHoEGklyyK7dLDG+CyWtUUu2KjhPaB2LFQy0TMmbvDk3nvE1Z9SXZ2hvhhCnnpXM8f
         hCa63pkPTl0IquhDW7+T2pXi6mS06aRZawnjwOA4ot6+U6VvJwBtrxynFOX8MwoCr/
         khJ48UUxKIs9ztfEomQ9mPzXB9ycT6/Q1QI2A6vVeqFbhchsTG6sNfubhvkpQfoxbA
         2wm8t5uB47QAiQhKNqfSx+9Y0agft6WqMdlJzK+nDIt/lKJIo1hwieXqkMLwsohFSd
         Q3jJ2f9DhPdZA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pxa: remove use of symbol_get()
Date:   Mon, 31 Jul 2023 22:34:57 +0200
Message-Id: <20230731203527.424561-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The spitz board file uses the obscure symbol_get() function
to optionally call a function from sharpsl_pm.c if that is
built. However, the two files are always built together
these days, and have been for a long time, so this can
be changed to a normal function call.

Link: https://lore.kernel.org/lkml/20230731162639.GA9441@lst.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This should get merged along with Christoph's other
patches for updating the symbol_get() references to
use EXPORT_SYMBOL_GPL().
---
 arch/arm/mach-pxa/sharpsl_pm.c |  2 --
 arch/arm/mach-pxa/spitz.c      | 14 +-------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index d29bdcd5270e0..72fa2e3fd3531 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -216,8 +216,6 @@ void sharpsl_battery_kick(void)
 {
 	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(125));
 }
-EXPORT_SYMBOL(sharpsl_battery_kick);
-
 
 static void sharpsl_battery_thread(struct work_struct *private_)
 {
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index b88ab6d007b68..dd6d66c913701 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>	/* symbol_get ; symbol_put */
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio_keys.h>
@@ -518,17 +517,6 @@ static struct gpiod_lookup_table spitz_ads7846_gpio_table = {
 	},
 };
 
-static void spitz_bl_kick_battery(void)
-{
-	void (*kick_batt)(void);
-
-	kick_batt = symbol_get(sharpsl_battery_kick);
-	if (kick_batt) {
-		kick_batt();
-		symbol_put(sharpsl_battery_kick);
-	}
-}
-
 static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
 	.dev_id = "spi2.1",
 	.table = {
@@ -556,7 +544,7 @@ static struct corgi_lcd_platform_data spitz_lcdcon_info = {
 	.max_intensity		= 0x2f,
 	.default_intensity	= 0x1f,
 	.limit_mask		= 0x0b,
-	.kick_battery		= spitz_bl_kick_battery,
+	.kick_battery		= sharpsl_battery_kick,
 };
 
 static struct spi_board_info spitz_spi_devices[] = {
-- 
2.39.2

