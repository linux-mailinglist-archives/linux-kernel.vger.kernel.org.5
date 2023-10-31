Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FDD7DD7C3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344910AbjJaVa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJaVa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:30:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CDBB9;
        Tue, 31 Oct 2023 14:30:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72177C433C7;
        Tue, 31 Oct 2023 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698787852;
        bh=bZ1HYdoFK1riQ/FP4rE7Tr5oTpN3affLHlOpTnVVbp0=;
        h=From:To:Cc:Subject:Date:From;
        b=r6i2d8WeZwEaNSqxB3TDv2TUn31df7gDy+qLpA/QFNzFbiJswZ/qBkuQpyQ0jYMmP
         2b94iSpG+Jq6XUnZxQ33PwtO8MY4NrXzFkSnQRJ3O2VLND9oEo0/RvkGmQoKQONFF1
         l/tSiSHSmx6VXQA4vRzLsyXcsUGfBQY3qpX+qAw4Qte030qxcaUjpsV7C+zJKVju7L
         AXOaZ7MyfmBhff1V4MamYrVKCVhNzcS+Vm+vpRunL6HaujS6uhrL7nokVbjGiKwDho
         Q45RGG+nKEr/UiWVOnOFzRLglI9mx7fbAeRMcVXR2pLOtTHJPfv2iKOSn881igs+fW
         m1mxlzyN2cyNA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Tue, 31 Oct 2023 14:30:50 -0700
Message-ID: <20231031213051.2294917-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 790437bbe0ef7e5cb5d091dd711c0d61d03945a5:

  clk: stm32: Fix a signedness issue in clk_stm32_composite_determine_rate() (2023-10-12 17:30:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 0a6d7f8275f255eda823c0f0b61d024f6f5b483d:

  Merge branch 'clk-cleanup' into clk-next (2023-10-30 14:12:53 -0700)

----------------------------------------------------------------
Herein lies a smallish collection of clk driver updates and some core
clk framework changes for the merge window. The core framework changes
are only improving the debugfs interface to allow phase adjustments and
report which consumers of a clk there are. These are most likely only of
interest to kernel developers.

On the clk driver side, it's a ghastly amount of updates with only a
handful of new clk drivers. We have a couple new clk drivers for
Qualcomm, per usual, and a driver for Renesas, Amlogic, and TI
respectively. The updates are spread throughout the clk drivers. Some
highlights are fixing kunit tests for different configurations like
lockdep and big-endian, avoiding integer overflow in rate settable clks,
moving clk_hw_onecell_data to the end of allocations so that drivers
don't corrupt their private data, and migrating clk drivers to the
regmap maple tree. Otherwise it's the usual fixes to clk drivers that
only come along with testing the drivers on real hardware.

New Drivers:
 - Add clock driver for TWL6032
 - Initial support for the Qualcomm SM4450 Global Clock Controller and
   SM4450 RPMh clock controllers
 - Add Camera Clock Controller on Qualcomm SM8550
 - Add support for the Renesas RZ/G3S (R9A08G045) SoC
 - Add Amlogic s4 main clock controller support

Updates:
 - Make clk kunit tests work with lockdep
 - Fix clk gate kunit test for big-endian
 - Convert more than a handful of clk drivers to use regmap maple tree
 - Consider the CLK_FRAC_DIVIDER_ZERO_BASED in fractional divider clk
   implementation
 - Add consumer info to clk debugfs
 - Fix various clk drivers that have clk_hw_onecell_data not at the end
   of an allocation
 - Drop CLK_SET_RATE_PARENT for clocks with fixed-rate GPLLs across a
   variety of Qualcomm IPQ platforms
 - Add missing parent of APCS PLL on Qualcomm IPQ6018
 - Add I2C QUP6 clk on Qualcomm IPQ6018 but mark it critical to avoid
   problems with RPM
 - Implement safe source switching for a53pll and use on Qualcomm
   IPQ5332
 - Add support for Stromer Plus PLLs to Qualcomm clk driver
 - Switch Qualcomm SM8550 Video and GPU clock controllers to use OLE PLL
   configure method
 - Non critical fixes to halt bit checks in Qualcomm clk drivers
 - Add SMMU GDSC for Qualcomm MSM8998
 - Fix possible integer overflow in Qualcomm RCG frequency calculation
   code
 - Remove RPM managed clks from Qualcomm MSM8996 GCC driver
 - Add HFPLL configuration for the three HFPLLs in Qualcomm MSM8976
 - Switch Qualcomm MSM8996 CBF clock driver's remove function to return
   void
 - Fix missing dependency for s4 clock controllers
 - Select MXC_CLK when building in the CLK_IMX8QXP
 - Fixes for error handling paths in i.MX8 ACM driver
 - Move the clocks check in i.MX8 ACM driver in order to log any error
 - Drop the unused return value of clk_imx_acm_detach_pm_domains
 - Drop non-existant IMX8MP_CLK_AUDIOMIX_PDM_ROOT clock
 - Fix error handling in i.MX8MQ clock driver
 - Allow a different LCDIF1 clock parent if DT describes it for i.MX6SX
 - Keep the SCU resource table sorted in the i.MX8DXL rsrc driver
 - Move the elcdif PLL clock registration above lcd_clk, as it is its
   parent
 - Correct some ENET specific clocks for i.MX8DXL platform
 - Drop the VPU_UART and VPUCORE from i.MX8QM as latest HW revision
   doesn't have them
 - Remove "de-featured" MLB support from i.MX8QM/QXP/DXL platforms
 - Skip registering clocks owned by Cortex-A partition SCU-based
   platforms
 - Add CAN_1/2 to i.MX8QM and M4_0, PI_0_PWM_0 and PI_0_I2C_0 to
   i.MX8QXP resources

----------------------------------------------------------------
Abel Vesa (1):
      clk: imx: Select MXC_CLK for CLK_IMX8QXP

Adam Ford (1):
      clk: imx8mp: Remove non-existent IMX8MP_CLK_AUDIOMIX_PDM_ROOT

Adam Skladowski (4):
      clk: qcom: clk-hfpll: Configure l_val in init when required
      clk: qcom: hfpll: Allow matching pdata
      dt-bindings: clock: qcom,hfpll: Document MSM8976 compatibles
      clk: qcom: hfpll: Add MSM8976 PLL data

Ajit Pandey (4):
      dt-bindings: clock: qcom: Add RPMHCC for SM4450
      clk: qcom: rpmh: Add RPMH clocks support for SM4450
      dt-bindings: clock: qcom: Add GCC clocks for SM4450
      clk: qcom: Add GCC driver support for SM4450

Andreas Kemnade (1):
      clk: twl: add clock driver for TWL6032

Arnd Bergmann (1):
      clk: meson: S4: select CONFIG_COMMON_CLK_MESON_CLKC_UTILS

Baruch Siach (1):
      clk: gate: fix comment typo and grammar

Biju Das (6):
      clk: si521xx: Use i2c_get_match_data() instead of device_get_match_data()
      clk: clk-si544: Simplify probe() and is_valid_frequency()
      clk: rs9: Use i2c_get_match_data() instead of device_get_match_data()
      clk: si5351: Simplify probe
      clk: si570: Simplify probe
      clk: cdce925: Extend match support for OF tables

Bjorn Andersson (2):
      Merge branch '20230707035744.22245-2-quic_jkona@quicinc.com' into clk-for-6.7
      Merge branch '20230909123431.1725728-1-quic_ajipan@quicinc.com' into clk-for-6.7

Christophe JAILLET (5):
      clk: imx: imx8: Fix an error handling path in clk_imx_acm_attach_pm_domains()
      clk: imx: imx8: Fix an error handling path if devm_clk_hw_register_mux_parent_data_table() fails
      clk: imx: imx8: Fix an error handling path in imx8_acm_clk_probe()
      clk: imx: imx8: Add a message in case of devm_clk_hw_register_mux_parent_data_table() error
      clk: imx: imx8: Simplify clk_imx_acm_detach_pm_domains()

Claudiu Beznea (18):
      clk: renesas: rzg2l: Use core->name for clock name
      clk: renesas: rzg2l: Simplify the logic in rzg2l_mod_clock_endisable()
      clk: renesas: rzg2l: Use FIELD_GET() for PLL register fields
      clk: renesas: rzg2l: Use u32 for flag and mux_flags
      dt-bindings: clock: renesas,rzg2l-cpg: Document RZ/G3S SoC
      clk: renesas: rzg2l: Wait for status bit of SD mux before continuing
      clk: renesas: rzg2l: Lock around writes to mux register
      clk: renesas: rzg2l: Trust value returned by hardware
      clk: renesas: rzg2l: Fix computation formula
      clk: renesas: rzg2l: Remove critical area
      clk: renesas: rzg2l: Add support for RZ/G3S PLL
      clk: renesas: rzg2l: Add struct clk_hw_data
      clk: renesas: rzg2l: Remove CPG_SDHI_DSEL from generic header
      clk: renesas: rzg2l: Refactor SD mux driver
      clk: renesas: rzg2l: Add divider clock for RZ/G3S
      clk: renesas: Add minimal boot support for RZ/G3S SoC
      clk: renesas: rzg2l: Use %x format specifier to print CLK_ON_R()
      clk: renesas: r9a08g045: Add clock and reset support for SDHI1 and SDHI2

Dan Carpenter (4):
      clk: keystone: pll: fix a couple NULL vs IS_ERR() checks
      clk: ti: fix double free in of_ti_divider_clk_setup()
      clk: at91: remove unnecessary conditions
      clk: mediatek: fix double free in mtk_clk_register_pllfh()

Danila Tikhonov (1):
      clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src

Devi Priya (1):
      clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies

Dirk Behme (1):
      clk: renesas: rcar-gen3: Extend SDnH divider table

Dmitry Baryshkov (2):
      clk: qcom: gpucc-sm8550: switch to clk_lucid_ole_pll_configure
      clk: qcom: videocc-sm8550: switch to clk_lucid_ole_pll_configure

Fabio Estevam (1):
      clk: imx: imx6sx: Allow a different LCDIF1 clock parent

Frank Oltmanns (2):
      clk: fractional-divider: Improve approximation when zero based and export
      clk: fractional-divider: tests: Add test suite for edge cases

Geert Uytterhoeven (1):
      Merge tag 'renesas-r9a08g045-dt-binding-defs-tag' into renesas-clk-for-v6.7

Gustavo A. R. Silva (4):
      clk: visconti: Fix undefined behavior bug in struct visconti_pll_provider
      clk: visconti: Add bounds-checking coverage for struct visconti_pll_provider
      clk: socfpga: Fix undefined behavior bug in struct stratix10_clock_data
      clk: socfpga: agilex: Add bounds-checking coverage for struct stratix10_clock_data

Jagadeesh Kona (4):
      dt-bindings: clock: qcom: Add SM8550 camera clock controller
      clk: qcom: clk-alpha-pll: Add support for lucid ole pll configure
      clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
      clk: qcom: camcc-sm8550: Add support for qdss, sleep and xo clocks

Jiasheng Jiang (6):
      clk: mediatek: clk-mt6765: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt6779: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt6797: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt7629-eth: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt7629: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt2701: Add check for mtk_alloc_clk_data

John Keeping (1):
      clk: Allow phase adjustment from debugfs

Jonathan Neuschäfer (1):
      clk: npcm7xx: Fix incorrect kfree

Kathiravan Thirumoorthy (6):
      clk: qcom: ipq8074: drop the CLK_SET_RATE_PARENT flag from PLL clocks
      clk: qcom: ipq6018: drop the CLK_SET_RATE_PARENT flag from PLL clocks
      clk: qcom: ipq5018: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
      clk: qcom: ipq9574: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
      clk: qcom: ipq5332: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
      clk: qcom: apss-ipq6018: add the GPLL0 clock also as clock provider

Konrad Dybcio (4):
      clk: qcom: gcc-msm8996: Remove RPM bus clocks
      clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
      clk: qcom: smd-rpm: Move CPUSS_GNoC clock to interconnect

Luca Weiss (1):
      clk: qcom: mmcc-msm8974: remove ocmemcx_ahb_clk

Marek Vasut (2):
      clk: renesas: r8a7795: Constify r8a7795_*_clks
      clk: si521xx: Increase stack based print buffer size in probe

Mark Brown (10):
      clk: cdce925: Convert to use maple tree register cache
      clk: si514: Convert to use maple tree register cache
      clk: si5341: Convert to use maple tree register cache
      clk: si5351: Convert to use maple tree register cache
      clk: si544: Convert to use maple tree register cache
      clk: si570: Convert to use maple tree register cache
      clk: versaclock3: Remove redundant _is_writeable()
      clk: versaclock3: Convert to use maple tree register cache
      clk: versaclock5: Convert to use maple tree register cache
      clk: versaclock7: Convert to use maple tree register cache

Peng Fan (5):
      clk: imx: imx8mq: correct error handling path
      clk: imx: imx8qm-rsrc: drop VPU_UART/VPUCORE
      clk: imx8: remove MLB support
      clk: imx: scu: ignore clks not owned by Cortex-A partition
      clk: imx: imx8qm/qxp: add more resources to whitelist

Ralph Siemsen (2):
      clk: renesas: r9a06g032: Fix kerneldoc warning
      clk: renesas: r9a06g032: Name anonymous structs

Randy Dunlap (1):
      clk: linux/clk-provider.h: fix kernel-doc warnings and typos

Rob Herring (2):
      clk: qcom: Replace of_device.h with explicit includes
      clk: Use device_get_match_data()

Robert Chiras (1):
      clk: imx: imx8qxp: Fix elcdif_pll clock

Robert Marko (1):
      clk: qcom: gcc-ipq6018: add QUP6 I2C clock

Samuel Holland (2):
      clk: analogbits: Allow building the library as a module
      clk: sifive: Allow building the driver as a module

Sergio Paracuellos (1):
      clk: ralink: mtmips: quiet unused variable warning

Shenwei Wang (1):
      clk: imx: imx8qxp: correct the enet clocks for i.MX8DXL

Stephen Boyd (14):
      clk: asm9620: Remove 'hw' local variable that isn't checked
      Merge tag 'renesas-clk-for-v6.7-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      clk: Drive clk_leaf_mux_set_rate_parent test from clk_ops
      clk: Parameterize clk_leaf_mux_set_rate_parent
      Merge tag 'renesas-clk-for-v6.7-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-meson-v6.7-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'clk-imx-6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'clk-meson-v6.7-2' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'qcom-clk-for-6.7' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      clk: Fix clk gate kunit test on big-endian CPUs
      Merge branches 'clk-doc', 'clk-amlogic', 'clk-mediatek', 'clk-twl' and 'clk-imx' into clk-next
      Merge branches 'clk-debugfs', 'clk-spreadtrum', 'clk-sifive', 'clk-counted' and 'clk-qcom' into clk-next
      Merge branches 'clk-renesas', 'clk-kunit', 'clk-regmap' and 'clk-frac-divider' into clk-next
      Merge branch 'clk-cleanup' into clk-next

Uwe Kleine-König (1):
      clk: qcom: cbf-msm8996: Convert to platform remove callback returning void

Varadarajan Narayanan (6):
      clk: qcom: ipq5332: Drop set rate parent from gpll0 dependent clocks
      clk: qcom: config IPQ_APSS_6018 should depend on QCOM_SMEM
      clk: qcom: clk-alpha-pll: introduce stromer plus ops
      clk: qcom: apss-ipq-pll: Use stromer plus ops for stromer plus pll
      clk: qcom: apss-ipq-pll: Fix 'l' value for ipq5332_pll_config
      clk: qcom: apss-ipq6018: ipq5332: add safe source switch for a53pll

Viorel Suman (1):
      clk: imx: imx8dxl-rsrc: keep sorted in the ascending order

Vishal Badole (1):
      clk: Show active consumers of clocks in debugfs

Yang Yingliang (1):
      clk: renesas: r9a06g032: Use for_each_compatible_node()

Yu Tu (4):
      dt-bindings: clock: document Amlogic S4 SoC PLL clock controller
      dt-bindings: clock: document Amlogic S4 SoC peripherals clock controller
      clk: meson: S4: add support for Amlogic S4 SoC PLL clock driver
      clk: meson: S4: add support for Amlogic S4 SoC peripheral clock controller

Zhifeng Tang (1):
      clk: sprd: Composite driver support offset config

 .../clock/amlogic,s4-peripherals-clkc.yaml         |   96 +
 .../bindings/clock/amlogic,s4-pll-clkc.yaml        |   49 +
 .../devicetree/bindings/clock/qcom,hfpll.txt       |    3 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../devicetree/bindings/clock/qcom,sm4450-gcc.yaml |   55 +
 .../bindings/clock/qcom,sm8450-camcc.yaml          |    8 +-
 .../bindings/clock/renesas,rzg2l-cpg.yaml          |    1 +
 drivers/clk/.kunitconfig                           |    1 +
 drivers/clk/Kconfig                                |   16 +
 drivers/clk/Makefile                               |    2 +
 drivers/clk/analogbits/Kconfig                     |    2 +-
 drivers/clk/analogbits/wrpll-cln28hpc.c            |    8 +
 drivers/clk/at91/clk-utmi.c                        |   12 +-
 drivers/clk/clk-asm9260.c                          |    6 +-
 drivers/clk/clk-cdce925.c                          |   67 +-
 drivers/clk/clk-fractional-divider.c               |   27 +-
 drivers/clk/clk-fractional-divider_test.c          |  147 +
 drivers/clk/clk-gate.c                             |    2 +-
 drivers/clk/clk-gate_test.c                        |   30 +-
 drivers/clk/clk-lochnagar.c                        |    9 +-
 drivers/clk/clk-npcm7xx.c                          |    2 +-
 drivers/clk/clk-renesas-pcie.c                     |    2 +-
 drivers/clk/clk-si514.c                            |    2 +-
 drivers/clk/clk-si521xx.c                          |    6 +-
 drivers/clk/clk-si5341.c                           |    2 +-
 drivers/clk/clk-si5351.c                           |    6 +-
 drivers/clk/clk-si544.c                            |   53 +-
 drivers/clk/clk-si570.c                            |   69 +-
 drivers/clk/clk-twl.c                              |  197 +
 drivers/clk/clk-versaclock3.c                      |    8 +-
 drivers/clk/clk-versaclock5.c                      |    2 +-
 drivers/clk/clk-versaclock7.c                      |    2 +-
 drivers/clk/clk.c                                  |   65 +-
 drivers/clk/clk_test.c                             |  130 +-
 drivers/clk/davinci/da8xx-cfgchip.c                |    8 +-
 drivers/clk/davinci/pll.c                          |   10 +-
 drivers/clk/davinci/psc.c                          |   10 +-
 drivers/clk/imx/Kconfig                            |    1 +
 drivers/clk/imx/clk-imx6sx.c                       |   14 +-
 drivers/clk/imx/clk-imx8-acm.c                     |   35 +-
 drivers/clk/imx/clk-imx8dxl-rsrc.c                 |    3 +-
 drivers/clk/imx/clk-imx8mq.c                       |   17 +-
 drivers/clk/imx/clk-imx8qm-rsrc.c                  |    5 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.h                 |    1 -
 drivers/clk/imx/clk-imx8qxp-rsrc.c                 |    4 +-
 drivers/clk/imx/clk-imx8qxp.c                      |   13 +-
 drivers/clk/imx/clk-scu.c                          |   20 +
 drivers/clk/keystone/pll.c                         |   15 +-
 drivers/clk/mediatek/clk-mt2701.c                  |    8 +
 drivers/clk/mediatek/clk-mt6765.c                  |    6 +
 drivers/clk/mediatek/clk-mt6779.c                  |    4 +
 drivers/clk/mediatek/clk-mt6797.c                  |    6 +
 drivers/clk/mediatek/clk-mt7629-eth.c              |    4 +
 drivers/clk/mediatek/clk-mt7629.c                  |    6 +
 drivers/clk/mediatek/clk-pll.c                     |    6 +-
 drivers/clk/meson/Kconfig                          |   25 +
 drivers/clk/meson/Makefile                         |    2 +
 drivers/clk/meson/s4-peripherals.c                 | 3813 ++++++++++++++++++++
 drivers/clk/meson/s4-peripherals.h                 |   56 +
 drivers/clk/meson/s4-pll.c                         |  867 +++++
 drivers/clk/meson/s4-pll.h                         |   38 +
 drivers/clk/qcom/Kconfig                           |   17 +
 drivers/clk/qcom/Makefile                          |    2 +
 drivers/clk/qcom/apss-ipq-pll.c                    |    4 +-
 drivers/clk/qcom/apss-ipq6018.c                    |   61 +-
 drivers/clk/qcom/camcc-sm8550.c                    | 3565 ++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |   92 +
 drivers/clk/qcom/clk-alpha-pll.h                   |    3 +
 drivers/clk/qcom/clk-cbf-8996.c                    |   12 +-
 drivers/clk/qcom/clk-hfpll.c                       |    4 +
 drivers/clk/qcom/clk-hfpll.h                       |    1 +
 drivers/clk/qcom/clk-rcg2.c                        |   14 +-
 drivers/clk/qcom/clk-rpmh.c                        |   21 +
 drivers/clk/qcom/clk-smd-rpm.c                     |   16 +-
 drivers/clk/qcom/gcc-ipq5018.c                     |    6 +-
 drivers/clk/qcom/gcc-ipq5332.c                     |    4 -
 drivers/clk/qcom/gcc-ipq6018.c                     |   27 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |    6 -
 drivers/clk/qcom/gcc-ipq9574.c                     |    4 -
 drivers/clk/qcom/gcc-msm8960.c                     |   13 +-
 drivers/clk/qcom/gcc-msm8974.c                     |   10 +-
 drivers/clk/qcom/gcc-msm8996.c                     |  237 +-
 drivers/clk/qcom/gcc-sm4450.c                      | 2898 +++++++++++++++
 drivers/clk/qcom/gcc-sm8150.c                      |    2 +-
 drivers/clk/qcom/gpucc-sm8550.c                    |   10 +-
 drivers/clk/qcom/hfpll.c                           |   59 +-
 drivers/clk/qcom/kpss-xcc.c                        |    9 +-
 drivers/clk/qcom/krait-cc.c                        |   14 +-
 drivers/clk/qcom/mmcc-msm8960.c                    |   16 +-
 drivers/clk/qcom/mmcc-msm8974.c                    |   18 -
 drivers/clk/qcom/mmcc-msm8998.c                    |    7 +-
 drivers/clk/qcom/mmcc-sdm660.c                     |    8 +-
 drivers/clk/qcom/videocc-sm8550.c                  |   10 +-
 drivers/clk/ralink/clk-mtmips.c                    |   20 +-
 drivers/clk/renesas/Kconfig                        |    7 +-
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    4 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |   69 +-
 drivers/clk/renesas/r9a07g043-cpg.c                |   19 +-
 drivers/clk/renesas/r9a07g044-cpg.c                |   19 +-
 drivers/clk/renesas/r9a08g045-cpg.c                |  248 ++
 drivers/clk/renesas/rcar-cpg-lib.c                 |   15 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |  465 ++-
 drivers/clk/renesas/rzg2l-cpg.h                    |   39 +-
 drivers/clk/rockchip/clk-rk3399.c                  |    9 +-
 drivers/clk/samsung/clk-exynos-clkout.c            |    8 +-
 drivers/clk/sifive/Kconfig                         |    2 +-
 drivers/clk/sifive/sifive-prci.c                   |   10 +-
 drivers/clk/socfpga/clk-agilex.c                   |   12 +-
 drivers/clk/socfpga/clk-s10.c                      |    6 +-
 drivers/clk/socfpga/stratix10-clk.h                |    4 +-
 drivers/clk/sprd/composite.h                       |   36 +-
 drivers/clk/sprd/div.c                             |    6 +-
 drivers/clk/sprd/div.h                             |   17 +-
 drivers/clk/ti/adpll.c                             |   14 +-
 drivers/clk/ti/divider.c                           |    8 +-
 drivers/clk/visconti/pll.c                         |    6 +-
 drivers/clk/visconti/pll.h                         |    4 +-
 .../clock/amlogic,s4-peripherals-clkc.h            |  236 ++
 include/dt-bindings/clock/amlogic,s4-pll-clkc.h    |   43 +
 include/dt-bindings/clock/imx8mp-clock.h           |    1 -
 include/dt-bindings/clock/qcom,mmcc-msm8974.h      |    1 -
 include/dt-bindings/clock/qcom,sm4450-gcc.h        |  197 +
 include/dt-bindings/clock/qcom,sm8550-camcc.h      |  187 +
 include/dt-bindings/clock/r9a08g045-cpg.h          |  242 ++
 include/linux/clk-provider.h                       |   15 +-
 126 files changed, 14392 insertions(+), 833 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
 create mode 100644 drivers/clk/clk-fractional-divider_test.c
 create mode 100644 drivers/clk/clk-twl.c
 create mode 100644 drivers/clk/meson/s4-peripherals.c
 create mode 100644 drivers/clk/meson/s4-peripherals.h
 create mode 100644 drivers/clk/meson/s4-pll.c
 create mode 100644 drivers/clk/meson/s4-pll.h
 create mode 100644 drivers/clk/qcom/camcc-sm8550.c
 create mode 100644 drivers/clk/qcom/gcc-sm4450.c
 create mode 100644 drivers/clk/renesas/r9a08g045-cpg.c
 create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
 create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm4450-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h
 create mode 100644 include/dt-bindings/clock/r9a08g045-cpg.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
