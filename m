Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C763C7A1A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjIOJVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjIOJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AF61FF5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:20 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso29937751fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769678; x=1695374478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIvhidofVsmyJzzhpGisC+BAHcAy8W3Roljgbbr6x7o=;
        b=G88d7+sk+YMjDXhUPDW6hhIuOTT2jRL/m4mkziCa8dy9rLoHrjZVER6a6MroO6Ud4z
         3zAYXGr3T6FjE5a00T4GGKJmL3WAra4WxhIq0sJ0Lapf37ovcCGOEdG+TUx3qV0tmjgF
         Y1R/tRTh8sUjhB1xP/pRe/W+IM0yxsfQxjheEcPY1EdXOipG/2imrv4KK60DyIHFhukF
         d1DwN1w2Cei665VpFeaE6wHuKzFMgx/5TtW+HVHUdJfbgWN+xwxaesgZlEj/qMTjMcQl
         wj8eOuFf76QKt5EKcU+5GOz7/txxstlPpBsCZRH3YlGMBMtLFZ33skdb7SBrPnxpUOER
         yvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769678; x=1695374478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIvhidofVsmyJzzhpGisC+BAHcAy8W3Roljgbbr6x7o=;
        b=RrqwVUDkvgRsJdV31jJHgVAjljxPDD8GOuK6t8pmnegXwkPhq9iOEwnTHP/YgUDgyI
         lQvWJkGzvFaYustbVsJDpKLCMVYzrV5sSmrvqgH1CJy8rNIIWkg+Fg84lFcj3NIYAoFW
         UuT9fI8xGatnrhe1Xr6KNtqm2/QtDahpDb/XYmZZTCwjchWsXW0MOCxlYoBw85QudQ6Z
         VUeong30+rjcsPleqx2L6K6gpnRwBkkfjV3W0Sy6G+YIOtJI6OGzkWYfF63RXZD5rjvX
         L1J5HCOKqnuvHxQV93XUAlJeT4KpGXz6vYDvl9sQgaZaT5uodPB5cqTjHjwDe+iJDGEH
         WdFA==
X-Gm-Message-State: AOJu0Yzj7dHu4/2jh2FSpzEQ4KCkxJ2Rya6rQAbjwblP/eXiYG3yr4C6
        m2587P6rKCzJ1+g8jDAIeQKqxQ==
X-Google-Smtp-Source: AGHT+IHAQ1iI+KB4DwlX9IrPYGMVQNjUB4liAC9r/LpWZWzZwOnLogKuDYvJOCgw36npmE6DOTZBbQ==
X-Received: by 2002:a2e:7010:0:b0:2bc:c750:d9be with SMTP id l16-20020a2e7010000000b002bcc750d9bemr1141692ljc.29.1694769678814;
        Fri, 15 Sep 2023 02:21:18 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:18 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev
Subject: [PATCH v2 04/17] pmdomain: apple: Move Kconfig option to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:50 +0200
Message-Id: <20230915092003.658361-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915092003.658361-1-ulf.hansson@linaro.org>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig option belongs closer to the corresponding implementation,
hence let's move it from the soc subsystem to the pmdomain subsystem.

Cc: Hector Martin <marcan@marcan.st>
Cc: Sven Peter <sven@svenpeter.dev>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: <asahi@lists.linux.dev>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig       |  1 +
 drivers/pmdomain/apple/Kconfig | 18 ++++++++++++++++++
 drivers/soc/apple/Kconfig      | 13 -------------
 3 files changed, 19 insertions(+), 13 deletions(-)
 create mode 100644 drivers/pmdomain/apple/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 03c8991ad0fd..482d9e970e14 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -3,5 +3,6 @@ menu "PM Domains"
 
 source "drivers/pmdomain/actions/Kconfig"
 source "drivers/pmdomain/amlogic/Kconfig"
+source "drivers/pmdomain/apple/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/apple/Kconfig b/drivers/pmdomain/apple/Kconfig
new file mode 100644
index 000000000000..12237cbcfaa9
--- /dev/null
+++ b/drivers/pmdomain/apple/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+if ARCH_APPLE || COMPILE_TEST
+
+config APPLE_PMGR_PWRSTATE
+	bool "Apple SoC PMGR power state control"
+	depends on PM
+	select REGMAP
+	select MFD_SYSCON
+	select PM_GENERIC_DOMAINS
+	select RESET_CONTROLLER
+	default ARCH_APPLE
+	help
+	  The PMGR block in Apple SoCs provides high-level power state
+	  controls for SoC devices. This driver manages them through the
+	  generic power domain framework, and also provides reset support.
+
+endif
diff --git a/drivers/soc/apple/Kconfig b/drivers/soc/apple/Kconfig
index a1596fefacff..eff486a77337 100644
--- a/drivers/soc/apple/Kconfig
+++ b/drivers/soc/apple/Kconfig
@@ -4,19 +4,6 @@ if ARCH_APPLE || COMPILE_TEST
 
 menu "Apple SoC drivers"
 
-config APPLE_PMGR_PWRSTATE
-	bool "Apple SoC PMGR power state control"
-	depends on PM
-	select REGMAP
-	select MFD_SYSCON
-	select PM_GENERIC_DOMAINS
-	select RESET_CONTROLLER
-	default ARCH_APPLE
-	help
-	  The PMGR block in Apple SoCs provides high-level power state
-	  controls for SoC devices. This driver manages them through the
-	  generic power domain framework, and also provides reset support.
-
 config APPLE_RTKIT
 	tristate "Apple RTKit co-processor IPC protocol"
 	depends on MAILBOX
-- 
2.34.1

