Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA07E1CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjKFI4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjKFI4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:56:07 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D66F83;
        Mon,  6 Nov 2023 00:56:02 -0800 (PST)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Mon, 6 Nov 2023
 16:55:59 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH V6 0/4] Add C3 SoC PLLs and Peripheral clock
Date:   Mon, 6 Nov 2023 16:55:50 +0800
Message-ID: <20231106085554.3237511-1-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds support for the peripheral and PLL clock controller
found on the Amlogic C3 SoC family, such as C302X or C308L.

Changes since V5 [3]:
 - Fix some typo and modify formart for MARCO. Suggested by Jerome.
 - Add pad clock for peripheral input clock in bindings.
 - Add some description for explaining why ddr_dpll_pt_clk and cts_msr_clk are out of tree.
Changes since V4 [10]:
 - Change some fw_name of clocks. Suggested by Jerome.
 - Delete minItem of clocks.
 - Add CLk_GET_RATE_NOCACHE flags for gp1_pll
 - Fix some format. and fix width as 8 for mclk_pll_dco.
 - exchange gate and divder for fclk_50m clock.
 - add CLK_SET_RATE_PARENT for axi_a_divder & axi_b_divder.
 - add CLK_IS_CRITICAL for axi_clk
 - Optimized macro define for pwm clk.
 - add cts_oscin_clk mux between 24M and 32k
 - add some missing gate clock, such as ddr_pll.
Changes since V3 [7]:
 - Modify Kconfig desc and PLL yaml clk desc. 
 - Fix some format.Suggested by Yixun and Jerome.
 - Add flag CLK_GET_RATE_NOCACHE for sys_clk.
 - Optimized macro define for pwm clk.
 - Use flag CLK_IS_CRITICAL for axi_clk.
 - Add some description for some clocks.
 - Use FCLK_50M instead of FCLK_DIV40.
Changes since V2 [4]:
 - Modify some format, include clk name & inline, and so on.
 - Define marco for pwm clock.
 - Add GP1_PLL clock.
 - Modify yaml use raw instead of macro.
Changes since V1 [2]:
 - Fix errors when check binding by using "make dt_binding_check".
 - Delete macro definition.

Xianwei Zhao (4):
  dt-bindings: clock: add Amlogic C3 PLL clock controller bindings
  dt-bindings: clock: add Amlogic C3 peripherals clock controller
    bindings
  clk: meson: c3: add support for the C3 SoC PLL clock
  clk: meson: c3: add c3 clock peripherals controller driver

 .../clock/amlogic,c3-peripherals-clkc.yaml    |  104 +
 .../bindings/clock/amlogic,c3-pll-clkc.yaml   |   59 +
 drivers/clk/meson/Kconfig                     |   26 +
 drivers/clk/meson/Makefile                    |    2 +
 drivers/clk/meson/c3-peripherals.c            | 2745 +++++++++++++++++
 drivers/clk/meson/c3-pll.c                    |  895 ++++++
 .../clock/amlogic,c3-peripherals-clkc.h       |  237 ++
 .../dt-bindings/clock/amlogic,c3-pll-clkc.h   |   44 +
 8 files changed, 4112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
 create mode 100644 drivers/clk/meson/c3-peripherals.c
 create mode 100644 drivers/clk/meson/c3-pll.c
 create mode 100644 include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h


base-commit: 57b55c76aaf1ba50ecc6dcee5cd6843dc4d85239
-- 
2.39.2

