Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99A7DB30B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjJ3GAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3GAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:00:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F574A9;
        Sun, 29 Oct 2023 23:00:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD29C433C8;
        Mon, 30 Oct 2023 06:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698645611;
        bh=2dWKctULE0nUwSFKf+fpemu7Au9dBQgPNQGUtB0+MJE=;
        h=From:To:Cc:Subject:Date:From;
        b=bIL2SBlu5W7TGq+ak6JLjazdG6JBVr8GqaDnjj7qb2rHncgBe6GmoFFNl6A/yRwYH
         t1yzCK0sLYxVTwRfu6IWB9cxEPrwJ5b3g+OZUw+epaYYirGuj4oZonSinZJ+kpZZc/
         C5OM/cenQ9VasGgdkbnXykAQgJwD6xtNKvksRaJBb1Gj/w+0w4x7R3zfFtMP5kqwaL
         pV+5iVxeVStenTJX1QByCHVAlbMG3rZMmxUz0kObEyLIFqVALWmWXlSaq3kZdWAhqr
         aoPWq1ldBCh1dZAdcd8a8QyI7LMReW0pqYrM+tPxDANOKXphc0gqvXopUAh436dxtL
         plKGe1MpyBBdQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: Expand led_colors[] array
Date:   Mon, 30 Oct 2023 13:47:57 +0800
Message-Id: <20231030054757.3476-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 472d7b9e8141 ("dt-bindings: leds: Expand LED_COLOR_ID
definitions") expands LED_COLOR_ID definitions for dt-binding. However,
it doesn't expand the led_colors[] array in leds core, so if any of
the newly expaned LED_COLOR_ID definitions is used, the sysfs will
emit null in the led's name color part. Let's expand the led_colors[]
array too.

Before the commit:
/sys/class/leds # ls
(null):indicator-0

After the commit:
/sys/class/leds # ls
orange:indicator-0

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/leds/led-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 04f9ea675f2c..742595d923ee 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -36,6 +36,11 @@ const char * const led_colors[LED_COLOR_ID_MAX] = {
 	[LED_COLOR_ID_IR] = "ir",
 	[LED_COLOR_ID_MULTI] = "multicolor",
 	[LED_COLOR_ID_RGB] = "rgb",
+	[LED_COLOR_ID_PURPLE] = "purple",
+	[LED_COLOR_ID_ORANGE] = "orange",
+	[LED_COLOR_ID_PINK] = "pink",
+	[LED_COLOR_ID_CYAN] = "cyan",
+	[LED_COLOR_ID_LIME] = "lime",
 };
 EXPORT_SYMBOL_GPL(led_colors);
 
-- 
2.40.1

