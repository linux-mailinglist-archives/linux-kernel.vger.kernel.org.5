Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920447D106A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377304AbjJTNUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376933AbjJTNUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:20:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0054419E;
        Fri, 20 Oct 2023 06:20:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB88C433C7;
        Fri, 20 Oct 2023 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697808044;
        bh=EG30UqUQC1/T0Ivz2ZS6ZstgK+eGwKAGIHTJTjqU8qU=;
        h=From:To:Cc:Subject:Date:From;
        b=UmwC7uHF40gz5hlzklO6rUFd+3sDe8gCyRUMuGZS50hja/jeCs0YHc0lLxSETNpnL
         bRJ0mcJGK7Kcd0wm7jtkSQUCfsg2bnN97+E17F82YPxpp0Te5BuRG2cKW1H+yiDUI/
         aa7ECC0cadj0RQplp2CGN9/tRzraZJ3GmDZq6llOAMajyug4DQl1OiR1rwzh8l95Q9
         DDmXY0VyEdnzwoS3KhYMazjhOf0VWwhLhb4hjfCBNQi/Y4rtmeYU+cv/dIl4cemVhJ
         yIh1Fhkr3OdyA/7Osf+UhKfxsFMUcNyniW5MIi2LZTP+fdRj3zEAYRvOgI1JwU8wd1
         hntVrzkmM26Bw==
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
Subject: [PATCH] clk: meson: S4: select CONFIG_COMMON_CLK_MESON_CLKC_UTILS
Date:   Fri, 20 Oct 2023 15:19:58 +0200
Message-Id: <20231020132036.1181762-1-arnd@kernel.org>
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

Without this, the newly added driver fails to link:

aarch64-linux-ld: drivers/clk/meson/s4-pll.o: in function `meson_s4_pll_probe':
s4-pll.c:(.text+0x13c): undefined reference to `meson_clk_hw_get'

Fixes: e787c9c55edad ("clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index c5303e4c16043..3c28560b0faba 100644
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
-- 
2.39.2

