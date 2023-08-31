Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E304878E440
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbjHaBPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjHaBPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:15:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B948CD6;
        Wed, 30 Aug 2023 18:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD362B80B84;
        Thu, 31 Aug 2023 01:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58321C433C7;
        Thu, 31 Aug 2023 01:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693444475;
        bh=thkcXcUP5TbS18PRX/SbKV5eHYpgaeiW4mJx42hGeQM=;
        h=From:To:Cc:Subject:Date:From;
        b=I1eQNVbEEFnqeDt2G5NTnFzN+JKkA+/+M2m+dhejAHIyXNB7hcoC4DfgtbeDCbu6W
         6QM7p8sqU6qca7HWFWwjkBuvB7c0N0YuHVdUh+wlO/zGJO0eZ21V4/PkM6aOEYQuNf
         zLTpBa0yPHukRVdEUk+Ha4263nQJy39eNInF2/J4lW2arsl64K+I5pgM5SBpp2uG7S
         jW0dM+O5kzEjldt0+568BNc085cBnv5TcTTR00XX4uN7ZeJcxtdMsjxkZO2ctUXvAd
         1QwIEuWA7yrcqED9ttXlTx5vtFjDxXFQ6FDiXfcZdDraen/CZzQaS+1Nt31559zEZK
         pxgir4Qax4KDQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Wed, 30 Aug 2023 18:14:32 -0700
Message-ID: <20230831011434.3247387-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 238e192bedd9b57f8ed026788956387350f2ccb9:

  dt-bindings: clk: qcom,gcc-msm8998: Add missing GPU/MMSS GPLL0 legs (2023-08-13 19:49:47 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 41680df0975e04b959a28bf6ab85fd6a307ae0ea:

  Merge branch 'clk-qcom' into clk-next (2023-08-30 14:39:58 -0700)

----------------------------------------------------------------
This pull request is full of clk driver changes. In fact, there aren't any
changes to the clk framework this time around. That's probably because everyone
was on vacation (yours truly included). We did lose a couple clk drivers this
time around because nobody was using those devices. That skews the diffstat a
bit, but either way, nothing looks out of the ordinary here. The usual suspects
are chugging along adding support for more SoCs and fixing bugs.

If I had to choose, I'd say the theme for the past few months has been
"polish". There's quite a few patches that migrate to
devm_platform_ioremap_resource() in here. And there's more than a handful of
patches that move the NR_CLKS define from the DT binding header to the driver.
There's even patches that migrate drivers to use clk_parent_data and clk_hw to
describe clk tree topology. It seems that the spring (summer?) cleaning bug got
some folks, or the semiconductor shortage finally hit the software side.

New Drivers:
 - StarFive JH7110 SoC clock drivers
 - Qualcomm IPQ5018 Global Clock Controller driver
 - Versa3 clk generator to support 48KHz playback/record with audio codec on
   RZ/G2L SMARC EVK

Removed Drivers:
 - Remove non-OF mmp clk drivers
 - Remove OXNAS clk driver

Updates:
 - Add __counted_by to struct clk_hw_onecell_data and struct spmi_pmic_div_clk_cc
 - Move defines for numbers of clks (NR_CLKS) from DT headers to drivers
 - Introduce kstrdup_and_replace() and use it
 - Add PLL rates for Rockchip rk3568
 - Add the display clock tree for Rockchip rv1126
 - Add Audio Clock Generator (ADG) clocks on Renesas R-Car Gen3 and RZ/G2 SoCs
 - Convert sun9i-mmc clock to use devm_platform_get_and_ioremap_resource()
 - Fix function name in a comment in ccu_mmc_timing.c
 - Parameter name correction for ccu_nkm_round_rate()
 - Implement CLK_SET_RATE_PARENT for Allwinner NKM clocks, i.e. consider alternative
   parent rates when determining clock rates
 - Set CLK_SET_RATE_PARENT for Allwinner A64 pll-mipi
 - Support finding closest (as opposed to closest but not higher) clock rate
   for NM, NKM, mux and div type clocks, as use it for Allwinner A64 pll-video0
 - Prefer current parent rate if able to generate ideal clock rate for Allwinner NKM clocks
 - Clean up Qualcomm SMD RPM driver, with interconnect bus clocks moved out to
   the interconnect drivers
 - Fix various PM runtime bugs across many Qualcomm clk drivers
 - Migrate Qualcomm MDM9615 is to parent_hw and parent_data
 - Add network related resets on Qualcomm IPQ4019
 - Add a couple missing USB related clocks to Qualcomm IPQ9574
 - Add missing gpll0_sleep_clk_src to Qualcomm MSM8917 global clock controller
 - In the Qualcomm QDU1000 global clock controller, GDSCs, clkrefs, and GPLL1 are
   added, while PCIe pipe clock, SDCC rcg ops are corrected
 - Add missing GDSCs to and correct GDSCs for the SC8280XP global clock controller driver
 - Support retention for the Qualcomm SC8280XP display clock controller GDSCs.
 - Qualcommm's SDCC apps_clk_src is marked with CLK_OPS_PARENT_ENABLE to fix
   issues with missing parent clocks across sc7180, sm7150, sm6350 and sm8250,
   while sm8450 is corrected to use floor ops
 - Correct Qualcomm SM6350 GPU clock controller's clock supplies
 - Drop unwanted clocks from the Qualcomm IPQ5332 GCC driver
 - Add missing OXILICX GDSC to Qualcomm MSM8226 GCC
 - Change the delay in the Qualcomm reset controller to fsleep() for correctness
 - Extend the Qualcomm SM83550 Video clock controller to support SC8280XP
 - Add graphics clock support on Renesas RZ/G2M, RZ/G2N, RZ/G2E, and R-Car H3,
   M3-W, and M3-N SoCs
 - Add Clocked Serial Interface (CSI) clocks on Renesas RZ/V2M
 - Add PWM (MTU3) clock and reset on Renesas RZ/G2UL and RZ/Five
 - Add the PDM IPC clock for i.MX93
 - Add 519.75MHz frequency support for i.MX9 PLL
 - Simplify the .determine_rate() implementation for i.MX GPR mux
 - Make the i.MX8QXP LPCG clock use devm_platform_ioremap_resource()
 - Add the audio mux clock to i.MX8
 - Fix the SPLL2 MULT range for PLLv4
 - Update the SPLL2 type in i.MX8ULP
 - Fix the SAI4 clock on i.MX8MP
 - Add silicon revision print for i.MX25 on clocks init
 - Drop the return value from __mx25_clocks_init()
 - Fix the clock pauses on no-op set_rate for i.MX8M composite clock
 - Drop restrictions for i.MX PLL14xx and fix its max prediv value
 - Drop the 393216000 and 361267200 from i.MX PLL14xx rate table to allow
   glitch free switching

----------------------------------------------------------------
Adam Ford (4):
      clk: renesas: rcar-gen3: Add support for ZG clock
      clk: renesas: r8a774a1: Add 3DGE and ZG support
      clk: renesas: r8a774e1: Add 3DGE and ZG support
      clk: renesas: r8a774b1: Add 3DGE and ZG support

Ahmad Fatoum (2):
      clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op
      clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz

Alibek Omarov (2):
      clk: rockchip: rk3568: Add PLL rate for 101MHz
      clk: rockchip: rk3568: Fix PLL rate setting for 78.75MHz

Andy Shevchenko (4):
      lib/string_helpers: Add kstrdup_and_replace() helper
      driver core: Replace kstrdup() + strreplace() with kstrdup_and_replace()
      clk: tegra: Replace kstrdup() + strreplace() with kstrdup_and_replace()
      clk: ti: Replace kstrdup() + strreplace() with kstrdup_and_replace()

Arnd Bergmann (1):
      clk: qcom: fix some Kconfig corner cases

Biju Das (5):
      dt-bindings: clock: Add Renesas versa3 clock generator bindings
      clk: Add support for versa3 clock driver
      clk: renesas: r9a07g043: Add MTU3a clock and reset entry
      clk: vc5: Use i2c_get_match_data() instead of device_get_match_data()
      clk: vc7: Use i2c_get_match_data() instead of device_get_match_data()

Bjorn Andersson (5):
      Merge branch 'd1c5aa4a8535c645fdb06df62a562918516ba0c6.1686289721.git.quic_varada@quicinc.com' into clk-for-6.6
      Merge branch '20230620-topic-sc8280_gccgdsc-v2-2-562c1428c10d@linaro.org' into clk-for-6.6
      Merge branch '20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org' into clk-for-6.6
      Merge branch '1690533192-22220-2-git-send-email-quic_srichara@quicinc.com' into clk-for-6.6
      Merge branch '20230622-topic-8998clk-v2-1-6222fbc2916b@linaro.org' into clk-for-6.6

Chancel Liu (2):
      dt-bindings: clock: imx93: Add PDM IPG clk
      clk: imx93: Add PDM IPG clk

Christophe JAILLET (3):
      clk: renesas: rzg2l: Simplify .determine_rate()
      clk: starfive: Simplify .determine_rate()
      clk: imx: clk-gpr-mux: Simplify .determine_rate()

Danila Tikhonov (1):
      clk: qcom: gcc-sm7150: Add CLK_OPS_PARENT_ENABLE to sdcc2 rcg

David Wronek (1):
      clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src

Dmitry Baryshkov (8):
      dt-bindings: clock: qcom,lcc.yaml: describe clocks for lcc,qcom-mdm9615
      dt-bindings: clock: drop qcom,lcc-mdm9615 header file
      dt-bindings: clock: provide separate bindings for qcom,gcc-mdm9615
      clk: qcom: gcc-mdm9615: use ARRAY_SIZE instead of specifying num_parents
      clk: qcom: drop lcc-mdm9615 in favour of lcc-msm8960
      clk: qcom: gcc-mdm9615: use proper parent for pll0_vote clock
      clk: qcom: gcc-mdm9615: use parent_hws/_data instead of parent_names
      clk: qcom: gcc-mdm9615: drop the cxo clock

Duje Mihanović (5):
      clk: mmp: Remove old non-OF clock drivers
      clk: mmp2: Move number of clocks to driver source
      clk: pxa168: Move number of clocks to driver source
      clk: pxa1928: Move number of clocks to driver source
      clk: pxa910: Move number of clocks to driver source

Dylan Hung (1):
      dt-bindings: clock: ast2600: Add I3C and MAC reset definitions

Emil Renner Berthing (1):
      clk: starfive: Add StarFive JH7110 System-Top-Group clock driver

Fabrizio Castro (1):
      clk: renesas: r9a09g011: Add CSI related clocks

Frank Oltmanns (11):
      clk: sunxi-ng: nkm: Use correct parameter name for parent HW
      clk: sunxi-ng: nkm: consider alternative parent rates when determining rate
      clk: sunxi-ng: a64: allow pll-mipi to set parent's rate
      clk: sunxi-ng: Add feature to find closest rate
      clk: sunxi-ng: Add helper function to find closest rate
      clk: sunxi-ng: nm: Support finding closest rate
      clk: sunxi-ng: nkm: Support finding closest rate
      clk: sunxi-ng: mux: Support finding closest rate
      clk: sunxi-ng: div: Support finding closest rate
      clk: sunxi-ng: a64: select closest rate for pll-video0
      clk: sunxi-ng: nkm: Prefer current parent rate

Geert Uytterhoeven (4):
      clk: renesas: emev2: Remove obsolete clkdev registration
      clk: renesas: r8a7795: Add 3DGE and ZG support
      clk: renesas: r8a7796: Add 3DGE and ZG support
      clk: renesas: r8a77965: Add 3DGE and ZG support

Imran Shaik (8):
      dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
      clk: qcom: gcc-qdu1000: Fix gcc_pcie_0_pipe_clk_src clock handling
      clk: qcom: gcc-qdu1000: Fix clkref clocks handling
      clk: qcom: gcc-qdu1000: Register gcc_gpll1_out_even clock
      clk: qcom: gcc-qdu1000: Add gcc_ddrss_ecpri_gsi_clk support
      clk: qcom: gcc-qdu1000: Add support for GDSCs
      clk: qcom: gcc-qdu1000: Update the SDCC clock RCG ops
      clk: qcom: gcc-qdu1000: Update the RCGs ops

Jacky Bai (1):
      clk: imx: Add 519.75MHz frequency support for imx9 pll

Jagan Teki (1):
      clk: rockchip: rv1126: Add PD_VO clock tree

Johan Hovold (8):
      clk: qcom: camcc-sc7180: fix async resume during probe
      clk: qcom: dispcc-sm8450: fix runtime PM imbalance on probe errors
      clk: qcom: dispcc-sm8550: fix runtime PM imbalance on probe errors
      clk: qcom: gcc-sc8280xp: fix runtime PM imbalance on probe errors
      clk: qcom: lpasscc-sc7280: fix missing resume during probe
      clk: qcom: q6sstop-qcs404: fix missing resume during probe
      clk: qcom: mss-sc7180: fix missing resume during probe
      clk: qcom: turingcc-qcs404: fix missing resume during probe

Kathiravan T (2):
      clk: qcom: ipq5332: drop the mem noc clocks
      clk: qcom: ipq5332: drop the gcc_apss_axi_clk_src clock

Kees Cook (2):
      clk: Annotate struct clk_hw_onecell_data with __counted_by
      clk: qcom: clk-spmi-pmic-div: Annotate struct spmi_pmic_div_clk_cc with __counted_by

Konrad Dybcio (37):
      clk: qcom: gpucc-sm6350: Introduce index-based clk lookup
      clk: qcom: gpucc-sm6350: Fix clock source names
      clk: qcom: gcc-sc8280xp: Add missing GDSC flags
      clk: qcom: gcc-sc8280xp: Add missing GDSCs
      dt-bindings: interconnect: Add Qcom RPM ICC bindings
      soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
      soc: qcom: smd-rpm: Use tabs for defines
      clk: qcom: smd-rpm: Move some RPM resources to the common header
      interconnect: qcom: icc-rpm: Introduce keep_alive
      interconnect: qcom: Add missing headers in icc-rpm.h
      interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
      interconnect: qcom: smd-rpm: Add rpmcc handling skeleton code
      interconnect: qcom: Define RPM bus clocks
      interconnect: qcom: sdm660: Hook up RPM bus clk definitions
      interconnect: qcom: msm8996: Hook up RPM bus clk definitions
      interconnect: qcom: qcs404: Hook up RPM bus clk definitions
      interconnect: qcom: msm8939: Hook up RPM bus clk definitions
      interconnect: qcom: msm8916: Hook up RPM bus clk definitions
      interconnect: qcom: qcm2290: Hook up RPM bus clk definitions
      interconnect: qcom: icc-rpm: Control bus rpmcc from icc
      clk: qcom: smd-rpm: Separate out interconnect bus clocks
      interconnect: qcom: icc-rpm: Fix bucket number
      interconnect: qcom: icc-rpm: Set bandwidth on both contexts
      interconnect: qcom: icc-rpm: Set correct bandwidth through RPM bw req
      interconnect: qcom: icc-rpm: Fix bandwidth calculations
      clk: qcom: dispcc-sc8280xp: Use ret registers on GDSCs
      dt-bindings: clock: qcom,sm8350-videocc: Add SC8280XP
      clk: qcom: videocc-sm8350: Add SC8280XP support
      clk: qcom: reset: Use the correct type of sleep/delay based on length
      dt-bindings: clock: qcom,mmcc: Add GPLL0_DIV for MSM8998
      clk: qcom: gcc-msm8998: Control MMSS and GPUSS GPLL0 outputs properly
      clk: qcom: mmcc-msm8998: Properly consume GPLL0 inputs
      clk: qcom: gpucc-msm8998: Use the correct GPLL0 leg with old DTs
      clk: qcom: gcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: gcc-sm8450: Use floor ops for SDCC RCGs
      clk: qcom: smd-rpm: Add a way to define bus clocks with rate and flags
      clk: qcom: smd-rpm: Set XO rate and CLK_IS_CRITICAL on PCNoC

Krzysztof Kozlowski (12):
      dt-bindings: clock: xlnx,versal-clk: drop select:false
      clk: samsung: exynos3250: do not define number of clocks in bindings
      clk: samsung: exynos4: do not define number of clocks in bindings
      clk: samsung: exynos5250: do not define number of clocks in bindings
      clk: samsung: exynos5260: do not define number of clocks in bindings
      clk: samsung: exynos5410: do not define number of clocks in bindings
      clk: samsung: exynos5420: do not define number of clocks in bindings
      clk: samsung: exynos5433: do not define number of clocks in bindings
      clk: samsung: exynos7885: do not define number of clocks in bindings
      clk: samsung: exynos850: do not define number of clocks in bindings
      clk: samsung: exynoautov9: do not define number of clocks in bindings
      dt-bindings: clock: samsung: remove define with number of clocks

Kuninori Morimoto (1):
      clk: renesas: rcar-gen3: Add ADG clocks

Luca Weiss (2):
      clk: qcom: mmcc-msm8974: Add OXILICX_GDSC for msm8226
      clk: qcom: gcc-sm6350: Fix gcc_sdcc2_apps_clk_src

Manivannan Sadhasivam (1):
      clk: qcom: gcc-sc8280xp: Allow PCIe GDSCs to enter retention state

Marco Felsch (3):
      clk: imx8mp: fix sai4 clock
      dt-bindings: clocks: imx8mp: make sai4 a dummy clock
      clk: imx: pll14xx: align pdiv with reference manual

Martin Kaiser (2):
      clk: imx25: print silicon revision during init
      clk: imx25: make __mx25_clocks_init return void

Mike Looijmans (3):
      clk: lmk04832: Set missing parent_names for output clocks
      clk: lmk04832: Don't disable vco clock on probe fail
      clk: lmk04832: Support using PLL1_LD as SPI readback pin

Minjie Du (1):
      drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()

Nathan Chancellor (1):
      clk: qcom: Fix SM_GPUCC_8450 dependencies

Neil Armstrong (24):
      clk: oxnas: remove obsolete clock driver
      dt-bindings: clk: oxnas: remove obsolete bindings
      clk: meson: introduce meson-clkc-utils
      clk: meson: migrate meson-eeclk out of hw_onecell_data to drop NR_CLKS
      clk: meson: migrate meson-aoclk out of hw_onecell_data to drop NR_CLKS
      clk: meson: migrate a1 clock drivers out of hw_onecell_data to drop NR_CLKS
      clk: meson: migrate meson8b out of hw_onecell_data to drop NR_CLKS
      clk: meson: migrate axg-audio out of hw_onecell_data to drop NR_CLKS
      dt-bindings: clk: gxbb-clkc: expose all clock ids
      dt-bindings: clk: axg-clkc: expose all clock ids
      dt-bindings: clk: g12a-clks: expose all clock ids
      dt-bindings: clk: g12a-aoclkc: expose all clock ids
      dt-bindings: clk: meson8b-clkc: expose all clock ids
      dt-bindings: clk: amlogic,a1-peripherals-clkc: expose all clock ids
      dt-bindings: clk: amlogic,a1-pll-clkc: expose all clock ids
      dt-bindings: clk: axg-audio-clkc: expose all clock ids
      clk: meson: aoclk: move bindings include to main driver
      clk: meson: eeclk: move bindings include to main driver
      clk: meson: a1: move bindings include to main driver
      clk: meson: meson8b: move bindings include to main driver
      clk: meson: axg-audio: move bindings include to main driver
      dt-bindings: clock: amlogic: convert amlogic,gxbb-clkc.txt to dt-schema
      dt-bindings: clock: amlogic: convert amlogic,gxbb-aoclkc.txt to dt-schema
      dt-bindings: soc: amlogic: document System Control registers

Otto Pflüger (2):
      dt-bindings: clock: gcc-msm8917: Add definition for GPLL0_SLEEP_CLK_SRC
      clk: qcom: gcc-msm8917: Enable GPLL0_SLEEP_CLK_SRC

Patrick Whewell (1):
      clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src

Peng Fan (1):
      clk: imx: imx8ulp: update SPLL2 type

Rob Herring (2):
      dt-bindings: arm: hisilicon,cpuctrl: Merge "hisilicon,hix5hd2-clock" into parent binding
      clk: Explicitly include correct DT includes

Robert Marko (2):
      dt-bindings: clock: qcom: ipq4019: add missing networking resets
      clk: qcom: gcc-ipq4019: add missing networking resets

Ruan Jinjie (1):
      clk: cdce925: Remove redundant of_match_ptr()

Shengjiu Wang (2):
      dt-bindings: clock: fsl,imx8-acm: Add audio clock mux support
      clk: imx: imx8: add audio clock mux driver

Shubhrajyoti Datta (2):
      dt-bindings: clock: versal: Add versal-net compatible string
      dt-bindings: clock: versal: Convert the xlnx,zynqmp-clk.txt to yaml

Sricharan Ramabadhran (1):
      clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018

Stephan Gerhold (1):
      soc: qcom: smd-rpm: Move icc_smd_rpm registration to clk-smd-rpm

Stephen Boyd (14):
      Merge tag 'clk-starfive-for-6.6' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into clk-starfive
      Merge tag 'renesas-clk-for-v6.6-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'clk-meson-v6.6-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'sunxi-clk-for-6.6-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'sunxi-clk-for-6.6-2' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
      Merge tag 'renesas-clk-for-v6.6-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
      Merge tag 'v6.6-rockchip-clk1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into clk-rockchip
      Merge tag 'clk-imx-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux into clk-imx
      Merge tag 'samsung-clk-6.6' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-samsung
      Merge tag 'qcom-clk-for-6.6' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-qcom
      Merge branches 'clk-bindings', 'clk-starfive', 'clk-rm', 'clk-renesas' and 'clk-cleanup' into clk-next
      Merge branches 'clk-versa', 'clk-strdup', 'clk-amlogic', 'clk-allwinner' and 'clk-rockchip' into clk-next
      Merge branches 'clk-imx', 'clk-samsung', 'clk-annotate', 'clk-marvell' and 'clk-lmk' into clk-next
      Merge branch 'clk-qcom' into clk-next

Taniya Das (1):
      dt-bindings: clock: qcom: Update my email address

Uwe Kleine-König (1):
      clk: versaclock3: Switch to use i2c_driver's probe callback

Varadarajan Narayanan (1):
      clk: qcom: gcc-ipq9574: Add USB related clocks

Xingyu Wu (5):
      clk: starfive: Add StarFive JH7110 PLL clock driver
      clk: starfive: jh7110-sys: Add PLL clocks source from DTS
      clk: starfive: Add StarFive JH7110 Image-Signal-Process clock driver
      clk: starfive: Add StarFive JH7110 Video-Output clock driver
      reset: starfive: jh7110: Add StarFive STG/ISP/VOUT resets support

Yang Yingliang (2):
      clk: qcom: lcc-msm8960: change pxo_parent_data to static
      clk: qcom: gcc-ipq5018: change some variable static

Yangtao Li (13):
      clk: sunxi: sun9i-mmc: Use devm_platform_get_and_ioremap_resource()
      clk: imx: clk-imx8qxp-lpcg: Convert to devm_platform_ioremap_resource()
      clk: actions: Convert to devm_platform_ioremap_resource()
      clk: axm5516: Convert to devm_platform_ioremap_resource()
      clk: bm1880: Convert to devm_platform_ioremap_resource()
      clk: fsl-sai: Convert to devm_platform_ioremap_resource()
      clk: gemini: Convert to devm_platform_ioremap_resource()
      clk: hsdk-pll: Convert to devm_platform_ioremap_resource()
      clk: mediatek: Convert to devm_platform_ioremap_resource()
      clk: ti: Use devm_platform_get_and_ioremap_resource()
      clk: socfpga: agilex: Convert to devm_platform_ioremap_resource()
      clk: nuvoton: Convert to devm_platform_ioremap_resource()
      clk: mvebu: Convert to devm_platform_ioremap_resource()

Yassine Oudjana (2):
      dt-bindings: clock: qcom,msm8996-cbf: Add compatible for MSM8996 Pro
      clk: qcom: cbf-msm8996: Add support for MSM8996 Pro

Ye Li (1):
      clk: imx: pllv4: Fix SPLL2 MULT range

Zhang Jianhua (1):
      clk: sunxi-ng: Modify mismatched function name

 .../bindings/arm/hisilicon/controller/cpuctrl.yaml |   20 +
 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |   64 -
 .../bindings/clock/amlogic,gxbb-aoclkc.yaml        |   85 +
 .../bindings/clock/amlogic,gxbb-clkc.txt           |   53 -
 .../bindings/clock/amlogic,gxbb-clkc.yaml          |   37 +
 .../devicetree/bindings/clock/fsl,imx8-acm.yaml    |  282 ++
 .../devicetree/bindings/clock/hix5hd2-clock.txt    |   30 -
 .../devicetree/bindings/clock/oxnas,stdclk.txt     |   28 -
 .../bindings/clock/qcom,gcc-apq8064.yaml           |    2 +-
 .../bindings/clock/qcom,gcc-ipq4019.yaml           |    2 +-
 .../bindings/clock/qcom,gcc-ipq8074.yaml           |    2 +-
 .../bindings/clock/qcom,gcc-msm8976.yaml           |    2 +-
 .../bindings/clock/qcom,gcc-msm8996.yaml           |    2 +-
 .../bindings/clock/qcom,gcc-msm8998.yaml           |    2 +-
 .../devicetree/bindings/clock/qcom,gcc-other.yaml  |    5 +-
 .../devicetree/bindings/clock/qcom,gcc-qcs404.yaml |    2 +-
 .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml |    2 +-
 .../devicetree/bindings/clock/qcom,gcc-sc7280.yaml |    2 +-
 .../devicetree/bindings/clock/qcom,gcc-sdm845.yaml |    2 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8150.yaml |    2 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |    2 +-
 .../devicetree/bindings/clock/qcom,gcc.yaml        |    2 +-
 .../devicetree/bindings/clock/qcom,gpucc.yaml      |    2 +-
 .../bindings/clock/qcom,ipq5018-gcc.yaml           |   63 +
 .../devicetree/bindings/clock/qcom,lcc.yaml        |   34 +
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |    4 +-
 .../bindings/clock/qcom,msm8996-cbf.yaml           |    4 +-
 .../bindings/clock/qcom,msm8998-gpucc.yaml         |    2 +-
 .../bindings/clock/qcom,qdu1000-gcc.yaml           |    3 +-
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    2 +-
 .../bindings/clock/qcom,sc7180-camcc.yaml          |    2 +-
 .../bindings/clock/qcom,sc7180-dispcc.yaml         |    2 +-
 .../bindings/clock/qcom,sc7180-lpasscorecc.yaml    |    2 +-
 .../devicetree/bindings/clock/qcom,sc7180-mss.yaml |    2 +-
 .../bindings/clock/qcom,sc7280-camcc.yaml          |    2 +-
 .../bindings/clock/qcom,sc7280-dispcc.yaml         |    2 +-
 .../bindings/clock/qcom,sc7280-lpasscc.yaml        |    2 +-
 .../bindings/clock/qcom,sc7280-lpasscorecc.yaml    |    2 +-
 .../bindings/clock/qcom,sdm845-dispcc.yaml         |    2 +-
 .../bindings/clock/qcom,sm8350-videocc.yaml        |    4 +-
 .../devicetree/bindings/clock/qcom,videocc.yaml    |    2 +-
 .../devicetree/bindings/clock/renesas,5p35023.yaml |   86 +
 .../bindings/clock/starfive,jh7110-ispcrg.yaml     |   87 +
 .../bindings/clock/starfive,jh7110-pll.yaml        |   46 +
 .../bindings/clock/starfive,jh7110-stgcrg.yaml     |   82 +
 .../bindings/clock/starfive,jh7110-syscrg.yaml     |   18 +-
 .../bindings/clock/starfive,jh7110-voutcrg.yaml    |   90 +
 .../devicetree/bindings/clock/xlnx,versal-clk.yaml |   87 +-
 .../devicetree/bindings/clock/xlnx,zynqmp-clk.txt  |   63 -
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  |  160 +
 .../soc/starfive/starfive,jh7110-syscon.yaml       |   93 +
 MAINTAINERS                                        |   13 +
 drivers/base/core.c                                |    5 +-
 drivers/clk/Kconfig                                |   16 +-
 drivers/clk/Makefile                               |    2 +-
 drivers/clk/actions/owl-common.c                   |    6 +-
 drivers/clk/actions/owl-common.h                   |    2 +-
 drivers/clk/axs10x/pll_clock.c                     |    3 +-
 drivers/clk/baikal-t1/clk-ccu-div.c                |    1 -
 drivers/clk/bcm/clk-bcm2835.c                      |    2 +-
 drivers/clk/bcm/clk-bcm63xx-gate.c                 |    1 -
 drivers/clk/bcm/clk-sr.c                           |    2 +-
 drivers/clk/clk-aspeed.c                           |    5 +-
 drivers/clk/clk-ast2600.c                          |    4 +-
 drivers/clk/clk-axm5516.c                          |    4 +-
 drivers/clk/clk-bm1880.c                           |   11 +-
 drivers/clk/clk-cdce925.c                          |    2 +-
 drivers/clk/clk-cs2000-cp.c                        |    2 +-
 drivers/clk/clk-en7523.c                           |    3 +-
 drivers/clk/clk-fsl-sai.c                          |    4 +-
 drivers/clk/clk-gemini.c                           |    6 +-
 drivers/clk/clk-gpio.c                             |    2 +-
 drivers/clk/clk-hsdk-pll.c                         |    5 +-
 drivers/clk/clk-k210.c                             |    1 -
 drivers/clk/clk-lmk04832.c                         |   35 +-
 drivers/clk/clk-milbeaut.c                         |    3 +-
 drivers/clk/clk-oxnas.c                            |  251 --
 drivers/clk/clk-palmas.c                           |    1 -
 drivers/clk/clk-plldig.c                           |    2 -
 drivers/clk/clk-qoriq.c                            |    2 +-
 drivers/clk/clk-scpi.c                             |    1 -
 drivers/clk/clk-si5351.c                           |    2 +-
 drivers/clk/clk-sp7021.c                           |    3 +-
 drivers/clk/clk-versaclock3.c                      | 1143 ++++++
 drivers/clk/clk-versaclock5.c                      |    3 +-
 drivers/clk/clk-versaclock7.c                      |    3 +-
 drivers/clk/hisilicon/clk-hi3559a.c                |    2 +-
 drivers/clk/hisilicon/clk-hi3620.c                 |    1 -
 drivers/clk/hisilicon/clk-hi3660.c                 |    2 +-
 drivers/clk/hisilicon/clk-hi3670.c                 |    2 +-
 drivers/clk/hisilicon/clk-hi6220-stub.c            |    2 +-
 drivers/clk/hisilicon/clk-hi6220.c                 |    3 -
 drivers/clk/hisilicon/clk-hip04.c                  |    3 -
 drivers/clk/hisilicon/clk.c                        |    2 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c            |    2 +-
 drivers/clk/hisilicon/crg-hi3798cv200.c            |    2 +-
 drivers/clk/imx/Makefile                           |    3 +-
 drivers/clk/imx/clk-composite-8m.c                 |   12 +-
 drivers/clk/imx/clk-fracn-gppll.c                  |    1 +
 drivers/clk/imx/clk-gpr-mux.c                      |    8 +-
 drivers/clk/imx/clk-imx25.c                        |    5 +-
 drivers/clk/imx/clk-imx8-acm.c                     |  476 +++
 drivers/clk/imx/clk-imx8mp.c                       |    5 -
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |    6 +-
 drivers/clk/imx/clk-imx8qxp.c                      |    1 -
 drivers/clk/imx/clk-imx8ulp.c                      |    4 +-
 drivers/clk/imx/clk-imx93.c                        |    4 +-
 drivers/clk/imx/clk-pll14xx.c                      |   13 +-
 drivers/clk/imx/clk-pllv4.c                        |   46 +-
 drivers/clk/imx/clk-scu.c                          |    2 +-
 drivers/clk/imx/clk.h                              |    1 +
 drivers/clk/keystone/pll.c                         |    2 +-
 drivers/clk/keystone/sci-clk.c                     |    3 +-
 drivers/clk/mediatek/clk-mt2701-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c              |    4 +-
 drivers/clk/mediatek/clk-mt2701.c                  |   10 +-
 drivers/clk/mediatek/clk-mt2712.c                  |    4 +-
 drivers/clk/mediatek/clk-mt6765.c                  |   23 +-
 drivers/clk/mediatek/clk-mt6779-aud.c              |    4 +-
 drivers/clk/mediatek/clk-mt6779.c                  |    2 -
 drivers/clk/mediatek/clk-mt6797.c                  |    2 -
 drivers/clk/mediatek/clk-mt7622-aud.c              |    2 +-
 drivers/clk/mediatek/clk-mt7622-eth.c              |    4 +-
 drivers/clk/mediatek/clk-mt7622-hif.c              |    4 +-
 drivers/clk/mediatek/clk-mt7622.c                  |    4 +-
 drivers/clk/mediatek/clk-mt7629-eth.c              |    2 -
 drivers/clk/mediatek/clk-mt7629-hif.c              |    4 +-
 drivers/clk/mediatek/clk-mt7629.c                  |    2 -
 drivers/clk/mediatek/clk-mt7981-apmixed.c          |    4 +-
 drivers/clk/mediatek/clk-mt7981-eth.c              |    4 +-
 drivers/clk/mediatek/clk-mt7981-infracfg.c         |    4 +-
 drivers/clk/mediatek/clk-mt7981-topckgen.c         |    4 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c          |    4 +-
 drivers/clk/mediatek/clk-mt7986-eth.c              |    4 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c         |    4 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c         |    4 +-
 drivers/clk/mediatek/clk-mt8167-aud.c              |    4 +-
 drivers/clk/mediatek/clk-mt8167-img.c              |    4 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c           |    4 +-
 drivers/clk/mediatek/clk-mt8167-mm.c               |    4 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c             |    4 +-
 drivers/clk/mediatek/clk-mt8173-mm.c               |    2 +-
 drivers/clk/mediatek/clk-mt8183.c                  |    4 +-
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c       |    2 +-
 drivers/clk/mediatek/clk-mt8188-topckgen.c         |    2 +-
 drivers/clk/mediatek/clk-mt8192-cam.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-img.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c     |    2 +-
 drivers/clk/mediatek/clk-mt8192-ipe.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-mdp.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-mfg.c              |    2 +-
 drivers/clk/mediatek/clk-mt8192-msdc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c         |    2 +-
 drivers/clk/mediatek/clk-mt8192-vdec.c             |    2 +-
 drivers/clk/mediatek/clk-mt8192-venc.c             |    2 +-
 drivers/clk/mediatek/clk-mt8192.c                  |    4 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c       |    2 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c         |    2 +-
 drivers/clk/mediatek/clk-mt8365.c                  |    4 +-
 drivers/clk/mediatek/clk-mt8516-aud.c              |    4 +-
 drivers/clk/meson/Kconfig                          |    9 +
 drivers/clk/meson/Makefile                         |    1 +
 drivers/clk/meson/a1-peripherals.c                 |  327 +-
 drivers/clk/meson/a1-peripherals.h                 |   67 -
 drivers/clk/meson/a1-pll.c                         |   40 +-
 drivers/clk/meson/a1-pll.h                         |   19 -
 drivers/clk/meson/axg-aoclk.c                      |   48 +-
 drivers/clk/meson/axg-aoclk.h                      |   18 -
 drivers/clk/meson/axg-audio.c                      |  853 +++--
 drivers/clk/meson/axg-audio.h                      |   75 -
 drivers/clk/meson/axg.c                            |  287 +-
 drivers/clk/meson/axg.h                            |   63 -
 drivers/clk/meson/g12a-aoclk.c                     |   72 +-
 drivers/clk/meson/g12a-aoclk.h                     |   32 -
 drivers/clk/meson/g12a.c                           | 1491 ++++----
 drivers/clk/meson/g12a.h                           |  145 -
 drivers/clk/meson/gxbb-aoclk.c                     |   14 +-
 drivers/clk/meson/gxbb-aoclk.h                     |   15 -
 drivers/clk/meson/gxbb.c                           |  850 ++---
 drivers/clk/meson/gxbb.h                           |   81 -
 drivers/clk/meson/meson-aoclk.c                    |   11 +-
 drivers/clk/meson/meson-aoclk.h                    |    3 +-
 drivers/clk/meson/meson-clkc-utils.c               |   25 +
 drivers/clk/meson/meson-clkc-utils.h               |   19 +
 drivers/clk/meson/meson-eeclk.c                    |   11 +-
 drivers/clk/meson/meson-eeclk.h                    |    3 +-
 drivers/clk/meson/meson8b.c                        | 1318 +++----
 drivers/clk/meson/meson8b.h                        |  117 -
 drivers/clk/microchip/clk-pic32mzda.c              |    2 +-
 drivers/clk/mmp/Makefile                           |    4 -
 drivers/clk/mmp/clk-audio.c                        |    6 +-
 drivers/clk/mmp/clk-mmp2.c                         |  454 ---
 drivers/clk/mmp/clk-of-mmp2.c                      |    4 +-
 drivers/clk/mmp/clk-of-pxa168.c                    |    4 +-
 drivers/clk/mmp/clk-of-pxa1928.c                   |    7 +-
 drivers/clk/mmp/clk-of-pxa910.c                    |    4 +-
 drivers/clk/mmp/clk-pxa168.c                       |  354 --
 drivers/clk/mmp/clk-pxa910.c                       |  325 --
 drivers/clk/mvebu/ap-cpu-clk.c                     |    1 -
 drivers/clk/mvebu/armada-37xx-periph.c             |    5 +-
 drivers/clk/mvebu/armada-37xx-tbg.c                |    4 +-
 drivers/clk/mvebu/cp110-system-controller.c        |    2 +-
 drivers/clk/nuvoton/clk-ma35d1.c                   |    3 +-
 drivers/clk/qcom/Kconfig                           |   28 +-
 drivers/clk/qcom/Makefile                          |    2 +-
 drivers/clk/qcom/apss-ipq-pll.c                    |    2 +-
 drivers/clk/qcom/camcc-sc7180.c                    |    4 +-
 drivers/clk/qcom/camcc-sc7280.c                    |    2 +-
 drivers/clk/qcom/clk-cbf-8996.c                    |   10 +-
 drivers/clk/qcom/clk-cpu-8996.c                    |    2 +-
 drivers/clk/qcom/clk-rpm.c                         |    1 -
 drivers/clk/qcom/clk-rpmh.c                        |    1 -
 drivers/clk/qcom/clk-smd-rpm.c                     |  340 +-
 drivers/clk/qcom/clk-spmi-pmic-div.c               |    2 +-
 drivers/clk/qcom/dispcc-qcm2290.c                  |    2 +-
 drivers/clk/qcom/dispcc-sc8280xp.c                 |    8 +-
 drivers/clk/qcom/dispcc-sm6115.c                   |    2 +-
 drivers/clk/qcom/dispcc-sm8450.c                   |   15 +-
 drivers/clk/qcom/dispcc-sm8550.c                   |   15 +-
 drivers/clk/qcom/gcc-apq8084.c                     |    1 -
 drivers/clk/qcom/gcc-ipq4019.c                     |    7 +-
 drivers/clk/qcom/gcc-ipq5018.c                     | 3724 ++++++++++++++++++++
 drivers/clk/qcom/gcc-ipq5332.c                     |  209 +-
 drivers/clk/qcom/gcc-ipq6018.c                     |    1 -
 drivers/clk/qcom/gcc-ipq806x.c                     |    2 +-
 drivers/clk/qcom/gcc-ipq8074.c                     |    1 -
 drivers/clk/qcom/gcc-ipq9574.c                     |   37 +
 drivers/clk/qcom/gcc-mdm9607.c                     |    1 -
 drivers/clk/qcom/gcc-mdm9615.c                     |  262 +-
 drivers/clk/qcom/gcc-msm8660.c                     |    1 -
 drivers/clk/qcom/gcc-msm8909.c                     |    1 -
 drivers/clk/qcom/gcc-msm8916.c                     |    1 -
 drivers/clk/qcom/gcc-msm8917.c                     |    4 +-
 drivers/clk/qcom/gcc-msm8939.c                     |    1 -
 drivers/clk/qcom/gcc-msm8953.c                     |    1 -
 drivers/clk/qcom/gcc-msm8976.c                     |    2 +-
 drivers/clk/qcom/gcc-msm8994.c                     |    1 -
 drivers/clk/qcom/gcc-msm8996.c                     |    1 -
 drivers/clk/qcom/gcc-msm8998.c                     |   65 +-
 drivers/clk/qcom/gcc-qdu1000.c                     |  162 +-
 drivers/clk/qcom/gcc-sa8775p.c                     |    2 +-
 drivers/clk/qcom/gcc-sc7180.c                      |    3 +-
 drivers/clk/qcom/gcc-sc7280.c                      |    2 +-
 drivers/clk/qcom/gcc-sc8180x.c                     |    1 -
 drivers/clk/qcom/gcc-sc8280xp.c                    |  147 +-
 drivers/clk/qcom/gcc-sdm660.c                      |    1 -
 drivers/clk/qcom/gcc-sdm845.c                      |    1 -
 drivers/clk/qcom/gcc-sdx65.c                       |    2 +-
 drivers/clk/qcom/gcc-sdx75.c                       |    3 +-
 drivers/clk/qcom/gcc-sm6115.c                      |    3 +-
 drivers/clk/qcom/gcc-sm6125.c                      |    1 -
 drivers/clk/qcom/gcc-sm6350.c                      |    1 +
 drivers/clk/qcom/gcc-sm6375.c                      |    3 +-
 drivers/clk/qcom/gcc-sm7150.c                      |    5 +-
 drivers/clk/qcom/gcc-sm8150.c                      |    1 -
 drivers/clk/qcom/gcc-sm8250.c                      |    3 +-
 drivers/clk/qcom/gcc-sm8450.c                      |    7 +-
 drivers/clk/qcom/gcc-sm8550.c                      |    3 +-
 drivers/clk/qcom/gpucc-msm8998.c                   |    3 +-
 drivers/clk/qcom/gpucc-sa8775p.c                   |    4 +-
 drivers/clk/qcom/gpucc-sdm660.c                    |    1 -
 drivers/clk/qcom/gpucc-sm6115.c                    |    3 +-
 drivers/clk/qcom/gpucc-sm6125.c                    |    3 +-
 drivers/clk/qcom/gpucc-sm6350.c                    |   18 +-
 drivers/clk/qcom/gpucc-sm6375.c                    |    3 +-
 drivers/clk/qcom/gpucc-sm8350.c                    |    2 +-
 drivers/clk/qcom/gpucc-sm8450.c                    |    3 +-
 drivers/clk/qcom/gpucc-sm8550.c                    |    3 +-
 drivers/clk/qcom/lcc-ipq806x.c                     |    1 -
 drivers/clk/qcom/lcc-mdm9615.c                     |  572 ---
 drivers/clk/qcom/lcc-msm8960.c                     |   20 +-
 drivers/clk/qcom/lpass-gfm-sm8250.c                |    2 +-
 drivers/clk/qcom/lpassaudiocc-sc7280.c             |    3 +-
 drivers/clk/qcom/lpasscc-sc7280.c                  |   16 +-
 drivers/clk/qcom/lpasscc-sc8280xp.c                |    4 +-
 drivers/clk/qcom/lpasscorecc-sc7180.c              |    2 +-
 drivers/clk/qcom/lpasscorecc-sc7280.c              |    3 +-
 drivers/clk/qcom/mmcc-msm8974.c                    |   12 +-
 drivers/clk/qcom/mmcc-msm8994.c                    |    1 -
 drivers/clk/qcom/mmcc-msm8996.c                    |    1 -
 drivers/clk/qcom/mmcc-msm8998.c                    |   36 +-
 drivers/clk/qcom/mss-sc7180.c                      |   13 +-
 drivers/clk/qcom/q6sstop-qcs404.c                  |   15 +-
 drivers/clk/qcom/reset.c                           |    3 +-
 drivers/clk/qcom/tcsrcc-sm8550.c                   |    3 +-
 drivers/clk/qcom/turingcc-qcs404.c                 |   13 +-
 drivers/clk/qcom/videocc-sm8350.c                  |   42 +-
 drivers/clk/qcom/videocc-sm8450.c                  |    3 +-
 drivers/clk/qcom/videocc-sm8550.c                  |    3 +-
 drivers/clk/ralink/clk-mt7621.c                    |    3 +-
 drivers/clk/renesas/clk-emev2.c                    |    3 -
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |    3 +
 drivers/clk/renesas/r8a774b1-cpg-mssr.c            |    3 +
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a774e1-cpg-mssr.c            |    4 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    3 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |    3 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |    3 +
 drivers/clk/renesas/r8a77990-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r8a77995-cpg-mssr.c            |    1 +
 drivers/clk/renesas/r9a07g043-cpg.c                |    3 +
 drivers/clk/renesas/r9a09g011-cpg.c                |   15 +
 drivers/clk/renesas/rcar-gen3-cpg.c                |   35 +-
 drivers/clk/renesas/rcar-gen3-cpg.h                |    1 +
 drivers/clk/renesas/rcar-usb2-clock-sel.c          |    1 -
 drivers/clk/renesas/renesas-cpg-mssr.c             |    1 -
 drivers/clk/renesas/rzg2l-cpg.c                    |   11 +-
 drivers/clk/rockchip/clk-rk3568.c                  |    5 +-
 drivers/clk/rockchip/clk-rv1126.c                  |   61 +-
 drivers/clk/samsung/clk-exynos-arm64.c             |    3 +-
 drivers/clk/samsung/clk-exynos-audss.c             |    3 +-
 drivers/clk/samsung/clk-exynos3250.c               |   11 +-
 drivers/clk/samsung/clk-exynos4.c                  |    5 +-
 drivers/clk/samsung/clk-exynos4412-isp.c           |    5 +-
 drivers/clk/samsung/clk-exynos5-subcmu.c           |    2 +-
 drivers/clk/samsung/clk-exynos5250.c               |    5 +-
 drivers/clk/samsung/clk-exynos5260.c               |   41 +-
 drivers/clk/samsung/clk-exynos5410.c               |    5 +-
 drivers/clk/samsung/clk-exynos5420.c               |    5 +-
 drivers/clk/samsung/clk-exynos5433.c               |   65 +-
 drivers/clk/samsung/clk-exynos7885.c               |   15 +-
 drivers/clk/samsung/clk-exynos850.c                |   36 +-
 drivers/clk/samsung/clk-exynosautov9.c             |   31 +-
 drivers/clk/samsung/clk-fsd.c                      |    2 -
 drivers/clk/sifive/sifive-prci.c                   |    2 +-
 drivers/clk/socfpga/clk-agilex.c                   |    7 +-
 drivers/clk/socfpga/clk-s10.c                      |    3 +-
 drivers/clk/spear/spear1310_clock.c                |    1 -
 drivers/clk/spear/spear1340_clock.c                |    1 -
 drivers/clk/spear/spear3xx_clock.c                 |    2 +-
 drivers/clk/sprd/common.c                          |    2 +-
 drivers/clk/sprd/sc9860-clk.c                      |    2 +-
 drivers/clk/sprd/ums512-clk.c                      |    2 +-
 drivers/clk/starfive/Kconfig                       |   33 +
 drivers/clk/starfive/Makefile                      |    4 +
 drivers/clk/starfive/clk-starfive-jh7100-audio.c   |    1 -
 drivers/clk/starfive/clk-starfive-jh7110-isp.c     |  232 ++
 drivers/clk/starfive/clk-starfive-jh7110-pll.c     |  507 +++
 drivers/clk/starfive/clk-starfive-jh7110-stg.c     |  173 +
 drivers/clk/starfive/clk-starfive-jh7110-sys.c     |   66 +-
 drivers/clk/starfive/clk-starfive-jh7110-vout.c    |  239 ++
 drivers/clk/starfive/clk-starfive-jh7110.h         |    6 +
 drivers/clk/starfive/clk-starfive-jh71x0.c         |   10 +-
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |   41 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c             |    2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c               |    2 +
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c               |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c                 |    2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c               |    2 +-
 drivers/clk/sunxi-ng/ccu_common.c                  |   12 +
 drivers/clk/sunxi-ng/ccu_common.h                  |    6 +
 drivers/clk/sunxi-ng/ccu_div.h                     |   30 +
 drivers/clk/sunxi-ng/ccu_mmc_timing.c              |    2 +-
 drivers/clk/sunxi-ng/ccu_mux.c                     |   15 +-
 drivers/clk/sunxi-ng/ccu_mux.h                     |   38 +-
 drivers/clk/sunxi-ng/ccu_nkm.c                     |   55 +-
 drivers/clk/sunxi-ng/ccu_nm.c                      |   13 +-
 drivers/clk/sunxi-ng/ccu_nm.h                      |   48 +-
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c           |    1 -
 drivers/clk/sunxi/clk-sun9i-mmc.c                  |   11 +-
 drivers/clk/tegra/clk-device.c                     |    2 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |    2 +-
 drivers/clk/tegra/clk-tegra20.c                    |    1 -
 drivers/clk/tegra/clk-tegra30.c                    |    1 -
 drivers/clk/tegra/clk.c                            |    8 +-
 drivers/clk/ti/adpll.c                             |    8 +-
 drivers/clk/ti/clk.c                               |    4 +-
 drivers/clk/ti/clkctrl.c                           |    9 +-
 drivers/clk/uniphier/clk-uniphier-core.c           |    1 -
 drivers/clk/xilinx/xlnx_vcu.c                      |    2 +-
 drivers/clk/zynqmp/clkc.c                          |    3 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c             |    3 +-
 drivers/interconnect/qcom/Makefile                 |    2 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c         |   77 +
 drivers/interconnect/qcom/icc-rpm.c                |  220 +-
 drivers/interconnect/qcom/icc-rpm.h                |   56 +-
 drivers/interconnect/qcom/msm8916.c                |    5 +-
 drivers/interconnect/qcom/msm8939.c                |    6 +-
 drivers/interconnect/qcom/msm8974.c                |    2 +-
 drivers/interconnect/qcom/msm8996.c                |   10 +-
 drivers/interconnect/qcom/qcm2290.c                |    8 +-
 drivers/interconnect/qcom/qcs404.c                 |    5 +-
 drivers/interconnect/qcom/sdm660.c                 |    8 +-
 drivers/interconnect/qcom/smd-rpm.c                |   23 +-
 drivers/interconnect/qcom/smd-rpm.h                |   15 -
 drivers/phy/qualcomm/phy-qcom-edp.c                |    2 +-
 drivers/reset/starfive/reset-starfive-jh7110.c     |   30 +
 drivers/soc/qcom/smd-rpm.c                         |   17 +-
 .../clock/amlogic,a1-peripherals-clkc.h            |   53 +
 include/dt-bindings/clock/amlogic,a1-pll-clkc.h    |    5 +
 include/dt-bindings/clock/ast2600-clock.h          |   12 +
 include/dt-bindings/clock/axg-audio-clkc.h         |   65 +
 include/dt-bindings/clock/axg-clkc.h               |   48 +
 include/dt-bindings/clock/exynos3250.h             |   18 -
 include/dt-bindings/clock/exynos4.h                |    5 -
 include/dt-bindings/clock/exynos5250.h             |    3 -
 include/dt-bindings/clock/exynos5260-clk.h         |   25 -
 include/dt-bindings/clock/exynos5410.h             |    2 -
 include/dt-bindings/clock/exynos5420.h             |    3 -
 include/dt-bindings/clock/exynos5433.h             |   42 -
 include/dt-bindings/clock/exynos7885.h             |    4 -
 include/dt-bindings/clock/exynos850.h              |   10 -
 include/dt-bindings/clock/g12a-aoclkc.h            |    7 +
 include/dt-bindings/clock/g12a-clkc.h              |  130 +
 include/dt-bindings/clock/gxbb-clkc.h              |   65 +
 include/dt-bindings/clock/imx8-clock.h             |   28 +
 include/dt-bindings/clock/imx8mp-clock.h           |    2 +-
 include/dt-bindings/clock/imx93-clock.h            |    3 +-
 include/dt-bindings/clock/marvell,mmp2-audio.h     |    1 -
 include/dt-bindings/clock/marvell,mmp2.h           |    1 -
 include/dt-bindings/clock/marvell,pxa168.h         |    1 -
 include/dt-bindings/clock/marvell,pxa1928.h        |    3 -
 include/dt-bindings/clock/marvell,pxa910.h         |    1 -
 include/dt-bindings/clock/meson8b-clkc.h           |   97 +
 include/dt-bindings/clock/qcom,gcc-ipq4019.h       |    6 +
 include/dt-bindings/clock/qcom,gcc-ipq5018.h       |  183 +
 include/dt-bindings/clock/qcom,gcc-msm8917.h       |    1 +
 include/dt-bindings/clock/qcom,gcc-sc8280xp.h      |   10 +
 include/dt-bindings/clock/qcom,ipq9574-gcc.h       |    2 +
 include/dt-bindings/clock/qcom,lcc-mdm9615.h       |   44 -
 include/dt-bindings/clock/qcom,qdu1000-gcc.h       |    4 +-
 include/dt-bindings/clock/samsung,exynosautov9.h   |   18 -
 include/dt-bindings/clock/starfive,jh7110-crg.h    |   80 +
 include/dt-bindings/interconnect/qcom,rpm-icc.h    |   13 +
 include/dt-bindings/reset/qcom,gcc-ipq5018.h       |  122 +
 include/dt-bindings/reset/starfive,jh7110-crg.h    |   60 +
 include/linux/clk-provider.h                       |    2 +-
 include/linux/clk/mmp.h                            |   18 -
 include/linux/soc/qcom/smd-rpm.h                   |   20 +-
 include/linux/string_helpers.h                     |    2 +
 include/soc/imx/revision.h                         |    1 +
 lib/string_helpers.c                               |   15 +
 434 files changed, 13649 insertions(+), 7119 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/hix5hd2-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/oxnas,stdclk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5018-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
 delete mode 100644 drivers/clk/clk-oxnas.c
 create mode 100644 drivers/clk/clk-versaclock3.c
 create mode 100644 drivers/clk/imx/clk-imx8-acm.c
 delete mode 100644 drivers/clk/meson/axg-aoclk.h
 delete mode 100644 drivers/clk/meson/g12a-aoclk.h
 delete mode 100644 drivers/clk/meson/gxbb-aoclk.h
 create mode 100644 drivers/clk/meson/meson-clkc-utils.c
 create mode 100644 drivers/clk/meson/meson-clkc-utils.h
 delete mode 100644 drivers/clk/mmp/clk-mmp2.c
 delete mode 100644 drivers/clk/mmp/clk-pxa168.c
 delete mode 100644 drivers/clk/mmp/clk-pxa910.c
 create mode 100644 drivers/clk/qcom/gcc-ipq5018.c
 delete mode 100644 drivers/clk/qcom/lcc-mdm9615.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-isp.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-pll.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-stg.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-vout.c
 create mode 100644 drivers/interconnect/qcom/icc-rpm-clocks.c
 delete mode 100644 drivers/interconnect/qcom/smd-rpm.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq5018.h
 delete mode 100644 include/dt-bindings/clock/qcom,lcc-mdm9615.h
 create mode 100644 include/dt-bindings/interconnect/qcom,rpm-icc.h
 create mode 100644 include/dt-bindings/reset/qcom,gcc-ipq5018.h
 delete mode 100644 include/linux/clk/mmp.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
