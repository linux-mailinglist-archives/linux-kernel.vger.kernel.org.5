Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F587AAFD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjIVKnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjIVKm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:42:59 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4608FCDA;
        Fri, 22 Sep 2023 03:42:52 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 81BE0E07;
        Fri, 22 Sep 2023 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1695379371;
        bh=JYm8BcM9/KAma3UN/bNDkHDqNyw66K9b6awe2AtcQjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGHTXYEs8gbpqvzfMndMgkQ9wWOq1AhrAGJjzFZ0nswSX1vxNIOrQqDM1Vb9BQAV7
         MTKYrynqAphAyL8XxfMfG3k+QtGytjBuU0AiBw0KNvJKlAjG7JsJo0yPKTRaqTinIp
         735t2vjgusXhwz8uTOUzCTZzv+jdsLrYmOpUo9BI=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        "Milton D. Miller II" <mdmii@outlook.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Eddie James <eajames@linux.ibm.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 2/2] watchdog: aspeed: Add support for aspeed,reset-mask DT property
Date:   Fri, 22 Sep 2023 03:42:34 -0700
Message-ID: <20230922104231.1434-6-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230922104231.1434-4-zev@bewilderbeest.net>
References: <20230922104231.1434-4-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property allows the device-tree to specify how the Aspeed
watchdog timer's reset mask register(s) should be set, so that
peripherals can be individually exempted from (or opted in to) being
reset when the watchdog timer expires.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/watchdog/aspeed_wdt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b72a858bbac7..b4773a6aaf8c 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -79,6 +79,8 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
 #define WDT_CLEAR_TIMEOUT_STATUS	0x14
 #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
+#define WDT_RESET_MASK1		0x1c
+#define WDT_RESET_MASK2		0x20
 
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
@@ -402,6 +404,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 
 	if ((of_device_is_compatible(np, "aspeed,ast2500-wdt")) ||
 		(of_device_is_compatible(np, "aspeed,ast2600-wdt"))) {
+		u32 reset_mask[2];
+		size_t nrstmask = of_device_is_compatible(np, "aspeed,ast2600-wdt") ? 2 : 1;
 		u32 reg = readl(wdt->base + WDT_RESET_WIDTH);
 
 		reg &= wdt->cfg->ext_pulse_width_mask;
@@ -419,6 +423,13 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 			reg |= WDT_OPEN_DRAIN_MAGIC;
 
 		writel(reg, wdt->base + WDT_RESET_WIDTH);
+
+		ret = of_property_read_u32_array(np, "aspeed,reset-mask", reset_mask, nrstmask);
+		if (!ret) {
+			writel(reset_mask[0], wdt->base + WDT_RESET_MASK1);
+			if (nrstmask > 1)
+				writel(reset_mask[1], wdt->base + WDT_RESET_MASK2);
+		}
 	}
 
 	if (!of_property_read_u32(np, "aspeed,ext-pulse-duration", &duration)) {
-- 
2.40.0.5.gf6e3b97ba6d2.dirty

