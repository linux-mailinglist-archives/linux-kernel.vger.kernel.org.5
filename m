Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DC17A8D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjITULG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjITULA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:11:00 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66361CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=t1CeJIW6bR5SEY8SZTsSWNrRz+EyxymHp/0GFeRxitQ=; b=Esqx4s
        GinE5bEEgtGeNpdPwVenMk9YJsuxpliViXTmbMH35YLXLY9BLX5I+TAiikRkxdxw
        K0mCkkiGebBYKSia59Zq1sUEjwGat7fn5RPfVKwOwHNmvZfe4bidV5tUukSu4ZLd
        B3s1LS7sg6dtwZoj5cJP5LSeJ654MAOsEXtFck7w2gxcesKlrDIZdAhfl9tqHw64
        c6p/lgrGLQTmPHi+74Lyf4SyIfS7H2v7100s7Ln5Sdcr638zS7vDoJmvjbGStPds
        tMLT6tOvmlogUsJ7xu/AtopTAr2VY+X4HxRLcQE2bCYPEC6qVXLJtoHp56X38/Rh
        Fba0p73FgAxZTxZg==
Received: (qmail 720306 invoked from network); 20 Sep 2023 22:10:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Sep 2023 22:10:44 +0200
X-UD-Smtp-Session: l3s3148p1@Jgxq+M8FqskujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] watchdog: ar7_wdt: remove driver to prepare for platform removal
Date:   Wed, 20 Sep 2023 22:10:30 +0200
Message-Id: <20230920201035.3445-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AR7 is going to be removed from the Kernel, so remove its watchdog
support. This allows us to remove the platform because this driver
includes a platform specific header.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/Kconfig   |   6 -
 drivers/watchdog/Makefile  |   1 -
 drivers/watchdog/ar7_wdt.c | 315 -------------------------------------
 3 files changed, 322 deletions(-)
 delete mode 100644 drivers/watchdog/ar7_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 751458959411..b9f715d73fe8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1768,12 +1768,6 @@ config SIBYTE_WDOG
 	  To compile this driver as a loadable module, choose M here.
 	  The module will be called sb_wdog.
 
-config AR7_WDT
-	tristate "TI AR7 Watchdog Timer"
-	depends on AR7 || (MIPS && 32BIT && COMPILE_TEST)
-	help
-	  Hardware driver for the TI AR7 Watchdog Timer.
-
 config TXX9_WDT
 	tristate "Toshiba TXx9 Watchdog Timer"
 	depends on CPU_TX49XX || (MIPS && COMPILE_TEST)
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 7eab9de311cb..7cbc34514ec1 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -168,7 +168,6 @@ obj-$(CONFIG_INDYDOG) += indydog.o
 obj-$(CONFIG_JZ4740_WDT) += jz4740_wdt.o
 obj-$(CONFIG_WDT_MTX1) += mtx-1_wdt.o
 obj-$(CONFIG_SIBYTE_WDOG) += sb_wdog.o
-obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
 obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
 obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
 octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
deleted file mode 100644
index cdcaeb0961ac..000000000000
-- 
2.35.1

