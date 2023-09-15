Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72197A1A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjIOJVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjIOJVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:32 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7746F1FE1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bfc2b26437so29393961fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769678; x=1695374478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtEkXdqn2AKXcoldY8q7JCFJLuqJ45MWZNi1FoZm5Ic=;
        b=X1M0eMvW4a64EH7sZyA8kK2N0GzNr59RGMBBZpIc3RcYtuAgmqrM5ETlT5QS8b6qQW
         sxvyMuzZU6BODd/a3a7SrYiDdE/kj9F41D3UzpKhXW85/6jdhUdRzNrAQ0F1zb+5Y2MW
         LIayGMeeYhENW74RSm4Or4tnOoeBCPjFOYHHnpshO9OkbN15OggrwpODilT/0J5zxj0p
         bajfXtmGZm/+HXRi27HzpR+CfwiuZdvZQFj7NfyDSgL//ri2Z0AgZaTeUnv1GqhiHb/V
         VxZXmZWv7mCiqkC3cEQ3x+24dXlVvmC4OLm1ELsSbBVc9pUd/DPN2ivf+IqTC399GnNK
         +JHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769678; x=1695374478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtEkXdqn2AKXcoldY8q7JCFJLuqJ45MWZNi1FoZm5Ic=;
        b=SpN1nR51HOYJyNRrLrxrQrSUrLOwVGmSiqwuviKstugJ2biIbkIJlwkTHscYfqAqFU
         MAlGU68Hg1IyezPNeflqRkjQihum2S9n/Cdt+kRpRZhE8kSB6DudVcbVuXgDtPE3LUWH
         Fk/i8LoJDd0CtHl+jff6mgNFtAJGRSFf8ark/Iif4ojH+0eyhy6bCok5ulzyKu1mFBQ8
         LRzPjJEi9RzyerVoA0UeCDj0X+PbCl/EbZ1K1bwzoItpbeH5YflVES1Leljr6BXJE67R
         HzaYDQw3oIT7SC4Yxy0bSPOqkJoRZL0hFYOL7xr2TFbf0SqMBdbNCjmyOmfUqb3G06bf
         awKg==
X-Gm-Message-State: AOJu0YwDWXi6nbGDXfiEAUa8ENH8w6FwXNaDWZGtdySLvq39C2o2m0U6
        Kd+3BkM8QWuTtg06p+3Mvm2hgw==
X-Google-Smtp-Source: AGHT+IFx5SAj9k17uZVn4NqPVoiWz/nsVg3nOnzOEp+JkWLtAilL3VHRVFLGDM2LReEURtgNYbQOYg==
X-Received: by 2002:a2e:9987:0:b0:2bc:daa2:7838 with SMTP id w7-20020a2e9987000000b002bcdaa27838mr1012473lji.19.1694769677864;
        Fri, 15 Sep 2023 02:21:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:17 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 03/17] pmdomain: amlogic: Move Kconfig options to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:49 +0200
Message-Id: <20230915092003.658361-4-ulf.hansson@linaro.org>
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

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: <linux-amlogic@lists.infradead.org>
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig         |  1 +
 drivers/pmdomain/amlogic/Kconfig | 39 ++++++++++++++++++++++++++++++++
 drivers/soc/amlogic/Kconfig      | 35 ----------------------------
 3 files changed, 40 insertions(+), 35 deletions(-)
 create mode 100644 drivers/pmdomain/amlogic/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index e410c4b8071a..03c8991ad0fd 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -2,5 +2,6 @@
 menu "PM Domains"
 
 source "drivers/pmdomain/actions/Kconfig"
+source "drivers/pmdomain/amlogic/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/amlogic/Kconfig b/drivers/pmdomain/amlogic/Kconfig
new file mode 100644
index 000000000000..2108729909b5
--- /dev/null
+++ b/drivers/pmdomain/amlogic/Kconfig
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Amlogic PM Domains"
+
+config MESON_GX_PM_DOMAINS
+	tristate "Amlogic Meson GX Power Domains driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on PM && OF
+	default ARCH_MESON
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	help
+	  Say yes to expose Amlogic Meson GX Power Domains as
+	  Generic Power Domains.
+
+config MESON_EE_PM_DOMAINS
+	tristate "Amlogic Meson Everything-Else Power Domains driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on PM && OF
+	default ARCH_MESON
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	help
+	  Say yes to expose Amlogic Meson Everything-Else Power Domains as
+	  Generic Power Domains.
+
+config MESON_SECURE_PM_DOMAINS
+	tristate "Amlogic Meson Secure Power Domains driver"
+	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
+	depends on PM && OF
+	depends on HAVE_ARM_SMCCC
+	default ARCH_MESON
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	help
+	  Support for the power controller on Amlogic A1/C1 series.
+	  Say yes to expose Amlogic Meson Secure Power Domains as Generic
+	  Power Domains.
+
+endmenu
diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index 174a9b011461..d08e398bdad4 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -26,41 +26,6 @@ config MESON_GX_SOCINFO
 	  Say yes to support decoding of Amlogic Meson GX SoC family
 	  information about the type, package and version.
 
-config MESON_GX_PM_DOMAINS
-	tristate "Amlogic Meson GX Power Domains driver"
-	depends on ARCH_MESON || COMPILE_TEST
-	depends on PM && OF
-	default ARCH_MESON
-	select PM_GENERIC_DOMAINS
-	select PM_GENERIC_DOMAINS_OF
-	help
-	  Say yes to expose Amlogic Meson GX Power Domains as
-	  Generic Power Domains.
-
-config MESON_EE_PM_DOMAINS
-	tristate "Amlogic Meson Everything-Else Power Domains driver"
-	depends on ARCH_MESON || COMPILE_TEST
-	depends on PM && OF
-	default ARCH_MESON
-	select PM_GENERIC_DOMAINS
-	select PM_GENERIC_DOMAINS_OF
-	help
-	  Say yes to expose Amlogic Meson Everything-Else Power Domains as
-	  Generic Power Domains.
-
-config MESON_SECURE_PM_DOMAINS
-	tristate "Amlogic Meson Secure Power Domains driver"
-	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
-	depends on PM && OF
-	depends on HAVE_ARM_SMCCC
-	default ARCH_MESON
-	select PM_GENERIC_DOMAINS
-	select PM_GENERIC_DOMAINS_OF
-	help
-	  Support for the power controller on Amlogic A1/C1 series.
-	  Say yes to expose Amlogic Meson Secure Power Domains as Generic
-	  Power Domains.
-
 config MESON_MX_SOCINFO
 	bool "Amlogic Meson MX SoC Information driver"
 	depends on (ARM && ARCH_MESON) || COMPILE_TEST
-- 
2.34.1

