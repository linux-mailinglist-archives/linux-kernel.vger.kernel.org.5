Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B97D2FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjJWK2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjJWK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:28:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D45188;
        Mon, 23 Oct 2023 03:28:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCABDC433C7;
        Mon, 23 Oct 2023 10:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698056896;
        bh=6EIj0UlrOsSd3FcPrJWS3RVeP62yd7ggwxrvtzIHU48=;
        h=From:To:Cc:Subject:Date:From;
        b=uE3S4qhspmjtcgzEY+ko2fxQqWXVXR5QwvaDMyFyqnm1wI4xWMS18QqrNhFxcaQOC
         Ja67VnzSku3Vmw0t9Q1bd4tbejJYpkfDX88Vli3ioW2OJOEjVpOM8aDFKUkmJD7ORa
         Jv/fKhxJ0CYNtuRBqGuFyPN93sRDP8rU6quM1IOm4CcB31oVsIKWJ+lFY0xffMX6Y5
         0f3eB4y2zr3ADL9M0PsqiEOnRMUR1B+LirdfWIWRnMGZsJrYO4uCyjFf7QC74dYcgG
         ZTHOjU6oVg69yBa8vLzyHWeki+GP/yH7wjjEpoGfasYl9oWypSAjWcBxOn4tAQblHX
         F70YPqagESIFg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, Yu Tu <yu.tu@amlogic.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Jian Hu <jian.hu@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] clk: meson: S4: select CONFIG_COMMON_CLK_MESON_CLKC_UTILS
Date:   Mon, 23 Oct 2023 12:28:02 +0200
Message-Id: <20231023102810.4001943-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without this, the newly added drivers fail to link:

aarch64-linux-ld: drivers/clk/meson/s4-pll.o: in function `meson_s4_pll_probe':
s4-pll.c:(.text+0x13c): undefined reference to `meson_clk_hw_get'
aarch64-linux-ld: drivers/clk/meson/s4-peripherals.o: in function `meson_s4_periphs_probe':
s4-peripherals.c:(.text+0xb0): undefined reference to `meson_clk_hw_get'

Fixes: e787c9c55edad ("clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver")
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix up both drivers, the first version only addressed the s4-pll one.
---
 drivers/clk/meson/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index c5303e4c16043..29ffd14d267b6 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -149,6 +149,7 @@ config COMMON_CLK_S4_PLL
 	tristate "S4 SoC PLL clock controllers support"
 	depends on ARM64
 	default y
+	select COMMON_CLK_MESON_CLKC_UTILS
 	select COMMON_CLK_MESON_MPLL
 	select COMMON_CLK_MESON_PLL
 	select COMMON_CLK_MESON_REGMAP
@@ -161,6 +162,7 @@ config COMMON_CLK_S4_PERIPHERALS
 	tristate "S4 SoC peripherals clock controllers support"
 	depends on ARM64
 	default y
+	select COMMON_CLK_MESON_CLKC_UTILS
 	select COMMON_CLK_MESON_REGMAP
 	select COMMON_CLK_MESON_DUALDIV
 	select COMMON_CLK_MESON_VID_PLL_DIV
-- 
2.39.2

