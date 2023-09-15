Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1785A7A1A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjIOJWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjIOJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CF6272E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:33 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500760b296aso2341360e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769691; x=1695374491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSDTY9PIBZaWnuB156Z6IV6vLXbcGWaKRrqSpGIqxY0=;
        b=hyTxnyJK24Ib1GIRwQExbeJx+HPV2gvn/s1DV5Us+0a4VnsSwC/Peqm6bKqQFpp5Jm
         uDDFPAs215WbAdA1BkujQqA5Mj1+ehg/gbpkGrXp5/22NB5TlzygAZco5VbK4fHHG3Ce
         pObLWXqAI+4EQp5dscMzEfe1B5HMDX980kkTadmsX46Juj3G6c7K2sOGsEyIrqA6V+RG
         to4HzSf7Mt2i3/tMbWu1lLR1XbDhP3ReMYLnsqyaYHXV5zOq0j5GO6EYCxH2FrGxqJJK
         XdNh6M5BnwVi2b6zia5KFvsk1lca4w2eny12DCObBBDPiHH/8ncT4W5v1x/Uwom41pNQ
         idZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769691; x=1695374491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSDTY9PIBZaWnuB156Z6IV6vLXbcGWaKRrqSpGIqxY0=;
        b=PsIL9fYUNOfHwETbu7l9yWzqVQ0CCEWOK7YWWBD8l7tx8P4NYesMXBBtjYcl/ZBNi9
         cM2pHRnoK/pFxOKWRedJleXM+qIiqSzkFkIYIqPxhYsEbYaNDnFZRHdXYfvWU5uGzz+0
         4mkI8DPTar1a5pSd+17dkv7n9bJrWznLifSve8xCaJeVgYixhWWsV37zpo4XesQCHknE
         hhc5yMoM0JQfKSFooiNxwXuKqiSf7aLl2vgInj7yRkhT5suxmrlkLvdWwwjNpkEzyjQu
         9lC3V0541IduBWDKz/upT5oPyEBJFdBETC4IIGKMeI7CIbxpO9J5QwtmklrYxbleJ+Ua
         xARQ==
X-Gm-Message-State: AOJu0Yx9Vjprk/KjrJVafw0RJeWt7AZPcDtFpvvX5YjjaKMrBZ3MkAZ/
        4AnYDraUkJXgVmnNwFGOq44isQ==
X-Google-Smtp-Source: AGHT+IE8ou11tW8HL58ljba8dxgaBkkR87BS3tgnZFYHGFtichyS2uz30CZsvntAaczYxD65pJiO/g==
X-Received: by 2002:a05:6512:39cc:b0:4fd:d254:edc6 with SMTP id k12-20020a05651239cc00b004fdd254edc6mr1290975lfu.26.1694769691466;
        Fri, 15 Sep 2023 02:21:31 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:30 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 16/17] pmdomain: ti: Move and add Kconfig options to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:20:02 +0200
Message-Id: <20230915092003.658361-17-ulf.hansson@linaro.org>
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

The TI_SCI_PM_DOMAINS Kconfig option belongs closer to its corresponding
implementation, hence let's move it from the soc subsystem to the pmdomain
subsystem.

While at it, let's also add a Kconfig option the omap_prm driver, rather
than using ARCH_OMAP2PLUS directly.

Cc: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig     |  1 +
 drivers/pmdomain/ti/Kconfig  | 22 ++++++++++++++++++++++
 drivers/pmdomain/ti/Makefile |  2 +-
 drivers/soc/ti/Kconfig       | 12 ------------
 4 files changed, 24 insertions(+), 13 deletions(-)
 create mode 100644 drivers/pmdomain/ti/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 98e04589bef4..33bfec9c4f7a 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -15,5 +15,6 @@ source "drivers/pmdomain/st/Kconfig"
 source "drivers/pmdomain/starfive/Kconfig"
 source "drivers/pmdomain/sunxi/Kconfig"
 source "drivers/pmdomain/tegra/Kconfig"
+source "drivers/pmdomain/ti/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/ti/Kconfig b/drivers/pmdomain/ti/Kconfig
new file mode 100644
index 000000000000..67c608bf7ed0
--- /dev/null
+++ b/drivers/pmdomain/ti/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config OMAP2PLUS_PRM
+	bool
+	depends on ARCH_OMAP2PLUS
+	default ARCH_OMAP2PLUS
+
+if SOC_TI
+
+config TI_SCI_PM_DOMAINS
+	tristate "TI SCI PM Domains Driver"
+	depends on TI_SCI_PROTOCOL
+	depends on PM_GENERIC_DOMAINS
+	help
+	  Generic power domain implementation for TI device implementing
+	  the TI SCI protocol.
+
+	  To compile this as a module, choose M here. The module will be
+	  called ti_sci_pm_domains. Note this is needed early in boot before
+	  rootfs may be available.
+
+endif
diff --git a/drivers/pmdomain/ti/Makefile b/drivers/pmdomain/ti/Makefile
index 69580afbb436..af6cd056c158 100644
--- a/drivers/pmdomain/ti/Makefile
+++ b/drivers/pmdomain/ti/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_ARCH_OMAP2PLUS)		+= omap_prm.o
+obj-$(CONFIG_OMAP2PLUS_PRM)		+= omap_prm.o
 obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 2cae17b65fd9..1a93001c9e36 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -50,18 +50,6 @@ config WKUP_M3_IPC
 	  to communicate and use the Wakeup M3 for PM features like suspend
 	  resume and boots it using wkup_m3_rproc driver.
 
-config TI_SCI_PM_DOMAINS
-	tristate "TI SCI PM Domains Driver"
-	depends on TI_SCI_PROTOCOL
-	depends on PM_GENERIC_DOMAINS
-	help
-	  Generic power domain implementation for TI device implementing
-	  the TI SCI protocol.
-
-	  To compile this as a module, choose M here. The module will be
-	  called ti_sci_pm_domains. Note this is needed early in boot before
-	  rootfs may be available.
-
 config TI_K3_RINGACC
 	tristate "K3 Ring accelerator Sub System"
 	depends on ARCH_K3 || COMPILE_TEST
-- 
2.34.1

