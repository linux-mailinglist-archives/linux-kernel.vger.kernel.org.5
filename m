Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB197A1A45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjIOJVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjIOJVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:13 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5DD1FFA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so29721191fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769663; x=1695374463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbUDGne8XHRV8NpnbXLwkauduLPIsEvNE20ti9xIZAo=;
        b=qHKXOCtdWSatJUeWAKlJoCbr5r7Y8LyAFIan+8mz0Z1WGYPATAXIKWCWJmU6NqB5Ra
         uiB0JKZejD5ccVQFkzs2j1kBgo7ESMXEqVgcuaKZM72tP2iHsH2XdRCqPyXkhn06ky1C
         tugUbVEWQxaVmsQ40nWGXGeSMzVqe97OYaUWzxk94iFMx7YbLkvIFhBgPVpyCE0Ytvx0
         2eG6iEdRq9uH/nXpyNhP1TgiEIUYaHH5fqEb6qzN46RewdSbGoNqKdruyb+bB7CoX82e
         9RqfdRm7QN/ZqfHN8fPAhNzWppZ0iejqescs3LyE5JllVquq8U1zWQNpmIiGXQ0JmmH1
         a8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769663; x=1695374463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbUDGne8XHRV8NpnbXLwkauduLPIsEvNE20ti9xIZAo=;
        b=IrXk2sGSiDsIKtk5qmP1yVdU/yMF66oxLLgFKGYAVcQRZTnhjtZPkiCLw3Rx7Y1kiE
         MPvG4dtOAM86Z4XodrbOE/y3OrOW0LQMi+BBWGv31GdEPkWtKkVxLyKsK0Vlo1hr7ZN5
         btaJzvKyW4LRBC2XjjMRaq5hqvDG8wpxeuOQdMpmRL1nDNn/U5su+IVcHi1Utgb824ZO
         aN/8Um48Gr/qkR4GTCtrmlwlIr3RgH/8VbskrvArHbmhIrPnV9ZMbzbMghQUfFkifND4
         hQ6KQ/XcY5IlwkWEKo3O8mf2oGLm78vAyiuMvnEMOyJ+IX1SchLMXZu6HcFC1JPg2Jbt
         hUtw==
X-Gm-Message-State: AOJu0YyoqZ23WN7evFc/yf8JrfY5Se6urp9GKmJwmsJry/984HqkvSjJ
        JRFkR4mPwWyEeoAVyEPNXThuVw==
X-Google-Smtp-Source: AGHT+IEsFFzgCYn8PouRFC8Fe+yd5/XaogKCqWlR4itAeqKHd4Y1JMjP5DV2XaM1YZLja2cku1VJnQ==
X-Received: by 2002:a2e:740b:0:b0:2b9:5eae:814f with SMTP id p11-20020a2e740b000000b002b95eae814fmr1003250ljc.50.1694769663077;
        Fri, 15 Sep 2023 02:21:03 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:02 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andreas Farber <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 01/17] pmdomain: Prepare to move Kconfig files into the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:47 +0200
Message-Id: <20230915092003.658361-2-ulf.hansson@linaro.org>
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

Rather than having the various Kconfig files for the genpd providers
sprinkled across subsystems, let's prepare to move them into the pmdomain
subsystem along with the implementations.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/Kconfig          | 2 ++
 drivers/pmdomain/Kconfig | 4 ++++
 2 files changed, 6 insertions(+)
 create mode 100644 drivers/pmdomain/Kconfig

diff --git a/drivers/Kconfig b/drivers/Kconfig
index efb66e25fa2d..3aebffb2efe9 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -175,6 +175,8 @@ source "drivers/soundwire/Kconfig"
 
 source "drivers/soc/Kconfig"
 
+source "drivers/pmdomain/Kconfig"
+
 source "drivers/devfreq/Kconfig"
 
 source "drivers/extcon/Kconfig"
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
new file mode 100644
index 000000000000..ac77cf4271a7
--- /dev/null
+++ b/drivers/pmdomain/Kconfig
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "PM Domains"
+
+endmenu
-- 
2.34.1

