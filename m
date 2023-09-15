Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFAE7A1A66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjIOJWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjIOJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE1A268E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bf8b9c5ca0so30272761fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769689; x=1695374489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuZx/GEW25gG646YvVI9ekfBTZl9JZLAF7Xs48rC/qQ=;
        b=IJjT8vy3KXgaSwnc25Fw68yp7QjBX057yNx20TPUc795dnKZqyInQQwtiOwA92nT/o
         SYn70PksHZaQXe48doWAuOXXHzL+0HbCURjIijRXB1MIvN2mVRMo336eN9orF0Cd2M/d
         Wjsp6Oaw+vxixUNeoTkwexOSIfIHGH/emXKN5MCXrrnqDx+iVGAKQPmFumsjEX+A5Tq2
         RzchKReROrHYzXcfR2eHA22Scj3VSczY+Wnay3aBEA9BY0eJAXakDC1C6XJvxAJ5yl4F
         nQUpZhwtOvoXlZk+zzc2LExwQWZHpQlrD/UXwc4Z3M1v9EMDtdFabvYg0t43ACgIMnBp
         LpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769689; x=1695374489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuZx/GEW25gG646YvVI9ekfBTZl9JZLAF7Xs48rC/qQ=;
        b=bIWljzjuw7uO4GYjBOjGu+6u8upPr1fr61v87Iyvx6OSaGs2f+OkEbbDf/+c0FuZYi
         dHskIP25v/Xgq2rmWRP+6Sumiy6Lr//H8NVh5IUd12GBWTvlIfbtbZGoj/69R/QDjc2a
         wGBcA/IwBpxSp/YuqRuGkmS34gW4XJtDwNE5Zn15zN4HdhZWzyreB163JRBUoTrf3xxE
         o9WT2YwaaNBUOmH7TzymOphQLZcqlA9Tsq03JXu2qAS7KbG91eRV6+63awDtFDi+Smen
         awowYZ+G3dkz9gCnr8OEWiw53iWfjXMqSDp6OZIfk3VRhGOUA5EvDwgyClslsrlvAlYq
         KyCg==
X-Gm-Message-State: AOJu0YwfCEYDWezxTNvBbkwzqNqhNMeB7b+i6TzNKQUDZ23AU6A+2t+h
        RytvX23q5luUdrrSCAkzLfK2oA==
X-Google-Smtp-Source: AGHT+IEVb+rybmAw/IHW2BTXH8tfpMjLEmySPO9nsUGKFLlub7WqeGnWblxKCQk1yld1rt/N2pe2jA==
X-Received: by 2002:a2e:93c2:0:b0:2bc:da4a:4649 with SMTP id p2-20020a2e93c2000000b002bcda4a4649mr1078194ljh.22.1694769689024;
        Fri, 15 Sep 2023 02:21:29 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:28 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 14/17] pmdomain: sunxi: Move Kconfig option to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:20:00 +0200
Message-Id: <20230915092003.658361-15-ulf.hansson@linaro.org>
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

Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: <linux-sunxi@lists.linux.dev>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig       |  1 +
 drivers/pmdomain/sunxi/Kconfig | 10 ++++++++++
 drivers/soc/sunxi/Kconfig      |  9 ---------
 3 files changed, 11 insertions(+), 9 deletions(-)
 create mode 100644 drivers/pmdomain/sunxi/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 2286c36076db..10c3bc2e2444 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -13,5 +13,6 @@ source "drivers/pmdomain/rockchip/Kconfig"
 source "drivers/pmdomain/samsung/Kconfig"
 source "drivers/pmdomain/st/Kconfig"
 source "drivers/pmdomain/starfive/Kconfig"
+source "drivers/pmdomain/sunxi/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/sunxi/Kconfig b/drivers/pmdomain/sunxi/Kconfig
new file mode 100644
index 000000000000..17781bf8d86d
--- /dev/null
+++ b/drivers/pmdomain/sunxi/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SUN20I_PPU
+	bool "Allwinner D1 PPU power domain driver"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y to enable the PPU power domain driver. This saves power
+	  when certain peripherals, such as the video engine, are idle.
diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
index c5070914fc6a..8aecbc9b1976 100644
--- a/drivers/soc/sunxi/Kconfig
+++ b/drivers/soc/sunxi/Kconfig
@@ -19,12 +19,3 @@ config SUNXI_SRAM
 	  Say y here to enable the SRAM controller support. This
 	  device is responsible on mapping the SRAM in the sunXi SoCs
 	  whether to the CPU/DMA, or to the devices.
-
-config SUN20I_PPU
-	bool "Allwinner D1 PPU power domain driver"
-	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on PM
-	select PM_GENERIC_DOMAINS
-	help
-	  Say y to enable the PPU power domain driver. This saves power
-	  when certain peripherals, such as the video engine, are idle.
-- 
2.34.1

