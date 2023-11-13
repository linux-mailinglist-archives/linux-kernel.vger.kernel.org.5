Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7B97E93E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjKMBHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjKMBHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:07:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453B71BE5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:07:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95996C433CC;
        Mon, 13 Nov 2023 01:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699837658;
        bh=ytHfU7p/l8yTC1DRGaIhHXhYJOUHNecTRODoCvWVCbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2ujH9Nf9K0O6y6t0TvBjTkOQrqUTOcw+oSVWtmflT4R6Yf1nfHbRgvuSMKt9woxV
         ZtEzkWP9sXbzNiljmyleWSsO4+Jis9umphWZCLTLgRbKy/ufJFB9wpPwN60jSLhtlE
         WK9BRPEIX8Pc8h63mY9JP/ncinldTpLpx/IR+IQsWl274EjyJAdQ7h5lrCL8BLGIHc
         0C92Kl18OKu0nH5jmIhBZAkQAw+E4iy5TAjIVNO19IYbPwXyJJTCxvpamXOWvom5XI
         R5b+VNh1rOyraFprRjtekyQ/ZjWB7iGMPEqOMaWswyNgf0D/7RfiWyJ4PpDliaKmdJ
         Xws60KmLzdCKA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 2/4] reset: Add reset controller support for Sophgo CV1800B SoC
Date:   Mon, 13 Nov 2023 08:55:01 +0800
Message-Id: <20231113005503.2423-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231113005503.2423-1-jszhang@kernel.org>
References: <20231113005503.2423-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller support for Sophgo CV1800B SoC reusing the
reset-simple driver.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/reset/Kconfig        | 3 ++-
 drivers/reset/reset-simple.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index ccd59ddd7610..2034f69d5953 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -213,7 +213,7 @@ config RESET_SCMI
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST || EXPERT
-	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
+	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || ARCH_SOPHGO || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
 	depends on HAS_IOMEM
 	help
 	  This enables a simple reset controller driver for reset lines that
@@ -228,6 +228,7 @@ config RESET_SIMPLE
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
 	   - SiFive FU740 SoCs
+	   - Sophgo SoCs
 
 config RESET_SOCFPGA
 	bool "SoCFPGA Reset Driver" if COMPILE_TEST && (!ARM || !ARCH_INTEL_SOCFPGA)
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 7ea5adbf2097..573753ae3e08 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -151,6 +151,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 	{ .compatible = "snps,dw-high-reset" },
 	{ .compatible = "snps,dw-low-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "sophgo,cv1800b-reset",
+		.data = &reset_simple_active_low },
 	{ /* sentinel */ },
 };
 
-- 
2.42.0

