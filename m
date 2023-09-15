Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EE17A1A50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjIOJVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjIOJVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E1D2709
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bfc5218dd8so29976921fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769681; x=1695374481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuAjnu1aml6mLrGf4NjQSS9NQOpzPUDHjaWJhb6ElQI=;
        b=s5TADoJZjIV1YQ5UMnw5KulHyneootBKndBYX6dx7y3ZX0ISe79Rt5vhPvcKEkEKET
         qTSHM6wY+pZOb7qdk4IEOuM6l+XggqfUu7f8m1EY02lXEUK5JEA9xarFhSsryARliEZz
         En6YLln0u0sOMD3Fm9ofTQIB+hpQL93cXH+CQ2PSotPpupBqdLj1RrIbWFJ+oPaSBYua
         se6eX/p4t4dF1F6IBuZJYGvle/1mgObf9W9Z378i0lp2VagfSF1gT+ZOVwkR6tR9PwpC
         mikAlJd0IElNb/NIbpgxGRpPwY/BgJrM3rVcnU5kYBbbhp6xMGVYW3Lr/Jr/vArBwIR3
         6S/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769681; x=1695374481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuAjnu1aml6mLrGf4NjQSS9NQOpzPUDHjaWJhb6ElQI=;
        b=SpAesNqq2HW1B00C0XZxOaidvVdPsO+GVCzj7Kunra/TcpvtEevKnk7dZ9SSKfCwpD
         i6X825tuLN91gr+KyFWhMjQ5v15x20C2Vns4B3OPES3xkRupPaSJ1gLWVwvLzI61UkvA
         oPIfB3A+M8aBEFP6i4rQSaOnnOoqjoAGXic+s14/5oQJ+DD3e4INJf+fBjTVKifkoAWM
         /nUSiKusJas76BhhtyL75b15JYkyh46+j+AtVCklgbrfaYzGzt/GF7AatUDgSfPbtEhe
         OyXIkaaRhNQIouEsng3YsdOf7yq9tt7zUfIbHdStwtsSirDLXzWS6t2pZMps6EFofv2T
         bsJw==
X-Gm-Message-State: AOJu0YwHYSWj5xqltU2AZEuAeLfdtcpeeA06FDfA7Vo+DPXlM2Xba04o
        mGx1YRuq92A7UIOHkQCvmYcfsg==
X-Google-Smtp-Source: AGHT+IHXR2CQ7Hv88Rx2+B5/Du0EO5B0lQBAb20t9J+UIEwpeQW6vZcWCwAfDkQD/PfD2zXRvkmw0A==
X-Received: by 2002:a2e:880c:0:b0:2b6:cf64:7a8e with SMTP id x12-20020a2e880c000000b002b6cf647a8emr1038527ljh.19.1694769681271;
        Fri, 15 Sep 2023 02:21:21 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:20 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v2 06/17] pmdomain: imx: Move Kconfig options to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:52 +0200
Message-Id: <20230915092003.658361-7-ulf.hansson@linaro.org>
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
hence let's move them from the soc- and firmware subsystem to the pmdomain
subsystem.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: <kernel@pengutronix.de>
Cc: <linux-imx@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/imx/Kconfig |  6 ------
 drivers/pmdomain/Kconfig     |  1 +
 drivers/pmdomain/imx/Kconfig | 29 +++++++++++++++++++++++++++++
 drivers/soc/imx/Kconfig      | 19 -------------------
 4 files changed, 30 insertions(+), 25 deletions(-)
 create mode 100644 drivers/pmdomain/imx/Kconfig

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index c027d99f2a59..183613f82a11 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -22,9 +22,3 @@ config IMX_SCU
 
 	  This driver manages the IPC interface between host CPU and the
 	  SCU firmware running on M4.
-
-config IMX_SCU_PD
-	bool "IMX SCU Power Domain driver"
-	depends on IMX_SCU
-	help
-	  The System Controller Firmware (SCFW) based power domain driver.
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index ddc05d6af100..e2c85f20a0c3 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -5,5 +5,6 @@ source "drivers/pmdomain/actions/Kconfig"
 source "drivers/pmdomain/amlogic/Kconfig"
 source "drivers/pmdomain/apple/Kconfig"
 source "drivers/pmdomain/bcm/Kconfig"
+source "drivers/pmdomain/imx/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/imx/Kconfig b/drivers/pmdomain/imx/Kconfig
new file mode 100644
index 000000000000..00203615c65e
--- /dev/null
+++ b/drivers/pmdomain/imx/Kconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "i.MX PM Domains"
+
+config IMX_GPCV2_PM_DOMAINS
+	bool "i.MX GPCv2 PM domains"
+	depends on ARCH_MXC || (COMPILE_TEST && OF)
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	select REGMAP_MMIO
+	default y if SOC_IMX7D
+
+config IMX8M_BLK_CTRL
+	bool
+	default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
+	depends on PM_GENERIC_DOMAINS
+	depends on COMMON_CLK
+
+config IMX9_BLK_CTRL
+	bool
+	default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
+	depends on PM_GENERIC_DOMAINS
+
+config IMX_SCU_PD
+	bool "IMX SCU Power Domain driver"
+	depends on IMX_SCU
+	help
+	  The System Controller Firmware (SCFW) based power domain driver.
+
+endmenu
diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 76a4593baf0a..2a90ddd20104 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -1,14 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "i.MX SoC drivers"
 
-config IMX_GPCV2_PM_DOMAINS
-	bool "i.MX GPCv2 PM domains"
-	depends on ARCH_MXC || (COMPILE_TEST && OF)
-	depends on PM
-	select PM_GENERIC_DOMAINS
-	select REGMAP_MMIO
-	default y if SOC_IMX7D
-
 config SOC_IMX8M
 	tristate "i.MX8M SoC family support"
 	depends on ARCH_MXC || COMPILE_TEST
@@ -28,15 +20,4 @@ config SOC_IMX9
 	help
 	  If you say yes here, you get support for the NXP i.MX9 family
 
-config IMX8M_BLK_CTRL
-	bool
-	default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
-	depends on PM_GENERIC_DOMAINS
-	depends on COMMON_CLK
-
-config IMX9_BLK_CTRL
-	bool
-	default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
-	depends on PM_GENERIC_DOMAINS
-
 endmenu
-- 
2.34.1

