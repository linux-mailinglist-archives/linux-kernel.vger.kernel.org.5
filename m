Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2153760436
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGYAnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGYAnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:43:00 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908FE1993
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:42:52 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-565f3881cbeso3483773eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690245772; x=1690850572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb3Vvpjv1LmFtv57q/x9jijKmz7uqCPq02odS2uEdoE=;
        b=NJz5PqvzKA92Zx6p/keou7qhR4dQjMQTGZKceWN2gyyZABNNExi9h9o6AsUcaoHajk
         l2JHilIUtr+3NvwhkDMJHlH7sAUJQRGdWWLCPwhZWey4RMvp8ksoxj3Q+7fb6fXuQu2S
         FIlXGfZFfparRohpUUi7z8Aa58ncz1lz0ihykjLa8mM3fdx9rBxIei/vy4OcsRc0OxRz
         Nbpp5bkxj6JFCFYct3COrH2sM7Lh8rrWSATU1tzBP0K7o3qOO/YomOpvn6ExEeKE0DBh
         0V4ipv7rGgmC2k1QtEcavM2waIfEj41z2ths0NsmFwxUs2TlDUXssTL2sG+D8vkbbGNH
         ImPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690245772; x=1690850572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb3Vvpjv1LmFtv57q/x9jijKmz7uqCPq02odS2uEdoE=;
        b=Vd1QQviVPUeLaUNxt8fNTGRHDwUadGfhiYe06F0Cs5WEYjm1f7KuI+e7w0d7LAirLI
         grpMTPWDEAtGRs/0SW9bHik33DC5eld/5IcRBQkv7G2Sb3EmbuGnzf9v3h7xhnmHgfBn
         cWRkcEi/qHOn5oBE9eylcsS28UWT+K7vijVAgAx0Ko48BHcd+1y8x4lCQrZjMg5f8g9m
         T0g0+PzG9ebws//qazoEoZyE5S/GNMxBdAodtyU4z9ecYI48F+NzpAZZvW1MDw9rSOR3
         Ox+Nu8N37G3GVNrkJbIcRVCcgrcLTxafG69uNnG3875+OyhEoPqfSoTL74UyHFnbOO9U
         DFOQ==
X-Gm-Message-State: ABy/qLYIQayWdsIEylhpa5jfHMrm+L2HUnQMZsHH0sj1J+AyjBrF8bcr
        iV7OUcnixyVS4kpCC1TDy3pegw==
X-Google-Smtp-Source: APBJJlEx7Lam5DEiLmiCEtXu/zND0jtP2cw7V2ldx1yMXL+Jl9Vp1s5OuX0uRGjreEk9+0xSHerGvQ==
X-Received: by 2002:a05:6358:52d0:b0:132:d07d:8f3b with SMTP id z16-20020a05635852d000b00132d07d8f3bmr11668726rwz.28.1690245771818;
        Mon, 24 Jul 2023 17:42:51 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id u135-20020a63798d000000b00553b9e0510esm9042655pgc.60.2023.07.24.17.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 17:42:51 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/2] clk: sifive: Allow building the driver as a module
Date:   Mon, 24 Jul 2023 17:42:48 -0700
Message-Id: <20230725004248.381868-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725004248.381868-1-samuel.holland@sifive.com>
References: <20230725004248.381868-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can reduce the kernel image size in multiplatform configurations.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Add MODULE_AUTHOR and MODULE_DESCRIPTION

 drivers/clk/sifive/Kconfig       |  2 +-
 drivers/clk/sifive/sifive-prci.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
index 2322f634a910..49597d95602e 100644
--- a/drivers/clk/sifive/Kconfig
+++ b/drivers/clk/sifive/Kconfig
@@ -10,7 +10,7 @@ menuconfig CLK_SIFIVE
 if CLK_SIFIVE
 
 config CLK_SIFIVE_PRCI
-	bool "PRCI driver for SiFive SoCs"
+	tristate "PRCI driver for SiFive SoCs"
 	default ARCH_SIFIVE
 	select RESET_CONTROLLER
 	select RESET_SIMPLE
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index e317f3454e93..09a76248a710 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -7,6 +7,7 @@
 #include <linux/clkdev.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include "sifive-prci.h"
 #include "fu540-prci.h"
@@ -618,9 +619,8 @@ static struct platform_driver sifive_prci_driver = {
 	},
 	.probe = sifive_prci_probe,
 };
+module_platform_driver(sifive_prci_driver);
 
-static int __init sifive_prci_init(void)
-{
-	return platform_driver_register(&sifive_prci_driver);
-}
-core_initcall(sifive_prci_init);
+MODULE_AUTHOR("Paul Walmsley <paul.walmsley@sifive.com>");
+MODULE_DESCRIPTION("SiFive Power Reset Clock Interface (PRCI) driver");
+MODULE_LICENSE("GPL");
-- 
2.40.1

