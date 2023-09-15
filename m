Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472917A1A51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjIOJVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjIOJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B123F2700
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bfcc35ef7bso23652141fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769680; x=1695374480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CP3f1sHM5Nj5iu5CRIA2O8JEDQIcldDJUxmizaosav4=;
        b=METGsl2OYLmWau3/hjxKQ/nTyQIpV0fRVgG926+BSQdKiMLEDNEmQW48g4p9bpQzga
         8viEzWUK4hBS4FohAGXx/Cdm6uzyCoJNd56T1odXCwHDLTtROn9y8dA92lRvZpMwW/A+
         U7DVwd7tpX0gbxLYuYuVdvlq0OM7LV7oTVMH3KQoJGs1OuBuHmJcrAAFfP015r7TLc26
         NQJ6fnDXPC1Vu+oAsd8p6V4aNPFipcO6a+6NG6GN1mEHEVv8AagzqzVTqeNgu6iq3j6s
         eGRL1x92WhVpC7ypMsU40jfdTEGDbC7w8SC2JpD3FBnmNrxWNYjqcCaPwwYlSnXQ1jeE
         jtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769680; x=1695374480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CP3f1sHM5Nj5iu5CRIA2O8JEDQIcldDJUxmizaosav4=;
        b=HwH+JctXtznmDlO0i4fnqpOa/AYHzESsTMNg9Cw2ZOhU7jD8L5XeVMn63ge+XuSncF
         xbP/zaJ+Z+b003CLTsiIsBCjbYaKuhSsW/lO7eR4SrJm/l+Xiv0EO4K7Jm6VpmhTMLI3
         zt9hrZnIXJekgkcuYknTHzVGDhY9QrW613/lJNNXGKbxVRdT/ef1u7wpWVMHTqZEsUwQ
         Goam/tNjaXGfZYvkhMeY1ur/iOVFMycZwncUY5V+zaCm5+sngpvG2kZHIxJS69NB/EWD
         tFT3WR/aPZ8ZzCkFa7BFMahhvAK2U8XHRMmC81hyWKzCQlPvpX7Tf+xezq3SHIYoOo+v
         wIPQ==
X-Gm-Message-State: AOJu0YwA6SU3cGyIJk+aSg7zUCw2F6Sz9gfLh74vjSo6G+pC74ZKZpUW
        LkjD5BKyHW18vk+MB324WjY0Qw==
X-Google-Smtp-Source: AGHT+IHPlaacG/gOBVJctrl1sdlsMKaUAGjfwl65ptqYhYWAn3prdG0qyTiCr8K2Oo6HMHyZs5IEqQ==
X-Received: by 2002:a2e:8887:0:b0:2b6:dc55:c3c7 with SMTP id k7-20020a2e8887000000b002b6dc55c3c7mr1141914lji.20.1694769679779;
        Fri, 15 Sep 2023 02:21:19 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:19 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-mips@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v2 05/17] pmdomain: bcm: Move Kconfig options to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:51 +0200
Message-Id: <20230915092003.658361-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915092003.658361-1-ulf.hansson@linaro.org>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig options belongs closer to the corresponding implementations,
hence let's move them from the soc subsystem to the pmdomain subsystem.

Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: <linux-mips@vger.kernel.org>
Cc: <linux-rpi-kernel@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig     |  1 +
 drivers/pmdomain/bcm/Kconfig | 46 ++++++++++++++++++++++++++++++++++++
 drivers/soc/bcm/Kconfig      | 42 --------------------------------
 3 files changed, 47 insertions(+), 42 deletions(-)
 create mode 100644 drivers/pmdomain/bcm/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 482d9e970e14..ddc05d6af100 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -4,5 +4,6 @@ menu "PM Domains"
 source "drivers/pmdomain/actions/Kconfig"
 source "drivers/pmdomain/amlogic/Kconfig"
 source "drivers/pmdomain/apple/Kconfig"
+source "drivers/pmdomain/bcm/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/bcm/Kconfig b/drivers/pmdomain/bcm/Kconfig
new file mode 100644
index 000000000000..9311e90b7707
--- /dev/null
+++ b/drivers/pmdomain/bcm/Kconfig
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Broadcom PM Domains"
+
+config BCM2835_POWER
+	bool "BCM2835 power domain driver"
+	depends on ARCH_BCM2835 || (COMPILE_TEST && OF)
+	default y if ARCH_BCM2835
+	select PM_GENERIC_DOMAINS if PM
+	select RESET_CONTROLLER
+	help
+	  This enables support for the BCM2835 power domains and reset
+	  controller.  Any usage of power domains by the Raspberry Pi
+	  firmware means that Linux usage of the same power domain
+	  must be accessed using the RASPBERRYPI_POWER driver
+
+config RASPBERRYPI_POWER
+	bool "Raspberry Pi power domain driver"
+	depends on ARCH_BCM2835 || (COMPILE_TEST && OF)
+	depends on RASPBERRYPI_FIRMWARE=y
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the RPi power domains which can be enabled
+	  or disabled via the RPi firmware.
+
+config BCM_PMB
+	bool "Broadcom PMB (Power Management Bus) driver"
+	depends on ARCH_BCMBCA || (COMPILE_TEST && OF)
+	default ARCH_BCMBCA
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the Broadcom's PMB (Power Management Bus) that
+	  is used for disabling and enabling SoC devices.
+
+if SOC_BCM63XX
+
+config BCM63XX_POWER
+	bool "BCM63xx power domain driver"
+	depends on BMIPS_GENERIC || (COMPILE_TEST && OF)
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the BCM63xx power domains controller on
+	  BCM6318, BCM6328, BCM6362 and BCM63268 SoCs.
+
+endif # SOC_BCM63XX
+
+endmenu
diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
index f96906795fa6..406617aa3056 100644
--- a/drivers/soc/bcm/Kconfig
+++ b/drivers/soc/bcm/Kconfig
@@ -1,27 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "Broadcom SoC drivers"
 
-config BCM2835_POWER
-	bool "BCM2835 power domain driver"
-	depends on ARCH_BCM2835 || (COMPILE_TEST && OF)
-	default y if ARCH_BCM2835
-	select PM_GENERIC_DOMAINS if PM
-	select RESET_CONTROLLER
-	help
-	  This enables support for the BCM2835 power domains and reset
-	  controller.  Any usage of power domains by the Raspberry Pi
-	  firmware means that Linux usage of the same power domain
-	  must be accessed using the RASPBERRYPI_POWER driver
-
-config RASPBERRYPI_POWER
-	bool "Raspberry Pi power domain driver"
-	depends on ARCH_BCM2835 || (COMPILE_TEST && OF)
-	depends on RASPBERRYPI_FIRMWARE=y
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the RPi power domains which can be enabled
-	  or disabled via the RPi firmware.
-
 config SOC_BCM63XX
 	bool "Broadcom 63xx SoC drivers"
 	depends on BMIPS_GENERIC || COMPILE_TEST
@@ -42,27 +21,6 @@ config SOC_BRCMSTB
 
 	  If unsure, say N.
 
-config BCM_PMB
-	bool "Broadcom PMB (Power Management Bus) driver"
-	depends on ARCH_BCMBCA || (COMPILE_TEST && OF)
-	default ARCH_BCMBCA
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the Broadcom's PMB (Power Management Bus) that
-	  is used for disabling and enabling SoC devices.
-
-if SOC_BCM63XX
-
-config BCM63XX_POWER
-	bool "BCM63xx power domain driver"
-	depends on BMIPS_GENERIC || (COMPILE_TEST && OF)
-	select PM_GENERIC_DOMAINS if PM
-	help
-	  This enables support for the BCM63xx power domains controller on
-	  BCM6318, BCM6328, BCM6362 and BCM63268 SoCs.
-
-endif # SOC_BCM63XX
-
 source "drivers/soc/bcm/brcmstb/Kconfig"
 
 endmenu
-- 
2.34.1

