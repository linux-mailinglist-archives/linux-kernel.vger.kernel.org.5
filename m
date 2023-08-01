Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E3E76BB5C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjHARgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHARgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:36:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1984BE53;
        Tue,  1 Aug 2023 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OiAddSX0ELWK4uOqDiiBlj4EDsp11VIp0UdNjLcR73Q=; b=hwIKMU/53Hdyq9e37shW+WfWm4
        qaVPuqT1yfAVhRMp4WRUuQ6c0NF9yNps2UuWjRgqD5mX9VrTRO2bVtiaL/RdjsFO9bIvJ0hBtXDBD
        RSZOayCNmjTcr339Kvr5ruFS6jIVvPH7HlMYWqLRxEq5nQ6URnx50+8CafMEfC2RfdoPaNsd4xs8a
        mhfP4rYdElxPCU6VSvKdr8RuaKWgxQ1Nrm+SWHt+66UvHZ8+SoqfWyQugiERZsSm+ihytZYwjEo30
        y1fnUl8hna1Dh+0hJLe3PBC6X2+MJaOZ3OJtDHZ7rApIr2nYeZFUFvhp3D0LnoTWS73bgHLlGr01O
        v9vAxxSg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQtHs-002w4G-03;
        Tue, 01 Aug 2023 17:36:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, Joshua Kinard <kumba@gentoo.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list),
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH 1/5] ARM: pxa: remove use of symbol_get()
Date:   Tue,  1 Aug 2023 19:35:40 +0200
Message-Id: <20230801173544.1929519-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801173544.1929519-1-hch@lst.de>
References: <20230801173544.1929519-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mach-pxa/sharpsl_pm.c |  2 --
 arch/arm/mach-pxa/spitz.c      | 14 +-------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index d29bdcd5270e0f..72fa2e3fd35318 100644
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
index d01ea54b0b7820..cc691b199429ca 100644
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

