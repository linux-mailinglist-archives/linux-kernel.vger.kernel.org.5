Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896127A1A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjIOJW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjIOJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD85272A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:32 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bf5bf33bcdso32008211fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769690; x=1695374490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gMxgrLH8hAqI78TYEwxUv2pVCfDSw58e/K0s6X8qpQ=;
        b=m9EHb03qwFkHFRxKPPTBlJC1GPblNh5KWKwqCWZWhUQJbXARoxmIhEC+XHs0gbdMUM
         FjVH9pV5FO4nm/eINjHGt3vMwAry3dsA8RpFnNLRs7PfedJ+ltmoqbEuWYi0T+bPboWu
         UCNqQF52/gzPm0KnNfN7JiH4icKqEOOs93xU+pSr7UhAb7LqcTuCA+Q61z69BCFv8lrn
         7Q5HKTSZAyAaRszXMjUolVIZzPMYY3IvoDJdOVwI5yIslSrTmdE053TGemztbzKyhdZG
         O+lBcIw+OuoO8mk/adF1vdjt631M9Xg31xwFl5u/4Y4r26uDrb5lt+ggvheP0afYie1m
         MAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769690; x=1695374490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gMxgrLH8hAqI78TYEwxUv2pVCfDSw58e/K0s6X8qpQ=;
        b=MUZOeYzoTzhAtXIrmtp1pQiKK3b3yJSblJ499Nc/amhtaEYhUUPbNGtuo4RO+ihxW2
         DRc9WnVtLndWUtO+R89gG9xvNk5GylA4AgliBEQBKb6IvFQkN1pbdgfeRRx2n5rCpJiZ
         nQfaziEVDt2WrmDNd24Ipjj0bkNXjnkT4CfOUnWJVnxXUCpMiW8muCN1HZwKhwA7wiCK
         p/pkrF+EnYc3urcEoman7h4yaX3BfYZVtAG6bjO2LcNK3bJrmUnPi26oFISeM5iLDv5/
         ajveJs4TsWugBBmMCpS9gng+U5YbZuRmgE1RU3NS7j/7DQnTWRR7mAN/fiibFI2a7R49
         HhMg==
X-Gm-Message-State: AOJu0Yyy1RwsQZa8bniZXO+XHNCmhfEX1p22XFHvuVQ2jI9AitbFayoy
        tRG4SJWnlQesCMGJQJSkBW9sZA==
X-Google-Smtp-Source: AGHT+IEW7ELR0BC0aaaD7PdqOlQ9YNfd9KQIzAAoLD8DzPpKbNrDvmiROuNK6D31n0onkDPudHUjUg==
X-Received: by 2002:a2e:9409:0:b0:2bd:1bca:ebee with SMTP id i9-20020a2e9409000000b002bd1bcaebeemr874287ljh.19.1694769690056;
        Fri, 15 Sep 2023 02:21:30 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:29 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 15/17] pmdomain: tegra: Move Kconfig option to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:20:01 +0200
Message-Id: <20230915092003.658361-16-ulf.hansson@linaro.org>
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

The Kconfig option belongs closer to the corresponding implementation,
hence let's move it from the soc subsystem to the pmdomain subsystem.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: <linux-tegra@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig       | 1 +
 drivers/pmdomain/tegra/Kconfig | 6 ++++++
 drivers/soc/tegra/Kconfig      | 5 -----
 3 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 drivers/pmdomain/tegra/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 10c3bc2e2444..98e04589bef4 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -14,5 +14,6 @@ source "drivers/pmdomain/samsung/Kconfig"
 source "drivers/pmdomain/st/Kconfig"
 source "drivers/pmdomain/starfive/Kconfig"
 source "drivers/pmdomain/sunxi/Kconfig"
+source "drivers/pmdomain/tegra/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/tegra/Kconfig b/drivers/pmdomain/tegra/Kconfig
new file mode 100644
index 000000000000..13ade6d84696
--- /dev/null
+++ b/drivers/pmdomain/tegra/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SOC_TEGRA_POWERGATE_BPMP
+	def_bool y
+	depends on PM_GENERIC_DOMAINS
+	depends on TEGRA_BPMP
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 6f3098822969..f16beeabaa92 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -152,11 +152,6 @@ config SOC_TEGRA_PMC
 	select PM_GENERIC_DOMAINS
 	select REGMAP
 
-config SOC_TEGRA_POWERGATE_BPMP
-	def_bool y
-	depends on PM_GENERIC_DOMAINS
-	depends on TEGRA_BPMP
-
 config SOC_TEGRA20_VOLTAGE_COUPLER
 	bool "Voltage scaling support for Tegra20 SoCs"
 	depends on ARCH_TEGRA_2x_SOC || COMPILE_TEST
-- 
2.34.1

