Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D167DBB0C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjJ3Nl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjJ3Nes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:34:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04271C9;
        Mon, 30 Oct 2023 06:34:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45062C433C8;
        Mon, 30 Oct 2023 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698672885;
        bh=NASYNgJ0YM6uDgrUR4jFfd41hFdl5EP+19vJP32b3ZY=;
        h=From:To:Cc:Subject:Date:From;
        b=doajSIoMSn6Fk5bMGIgMw1fvEtg8z/5hZUwDnd63YDxQYE+upcns1OqJe/Eznx7qg
         sjMInbX1tyYviGD6Gk834nrc6S3uSLC+MQUz4DusCqFHY2TQv0P9H0Ht+3RiK4JPSF
         2p9etVfplpa79pdeGnKwfcqQog1wCfnAjZb8bsBeCD8sPpvv9nPTll97BFJERuzdHu
         8qHPMK5SOe/961gGHAtfHwwf/PmkEc2QY6+dDWfKw/Dczouza39IzKgvNM8liTlnco
         aOQxnXUraFmjpx/lq0nzL/YLHHgGQuLhn1R8P82wqTC08roLjdvVdvvdV3cgT5j3ti
         CUU4GRZswukfA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.7
Date:   Mon, 30 Oct 2023 13:34:36 +0000
Message-Id: <20231030133445.45062C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ec8b010979036c2fe79a64adb6ecc0bd11e91d1:

  spi: npcm-fiu: Fix UMA reads when dummy.nbytes == 0 (2023-10-02 15:03:19 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.7

for you to fetch changes up to 1b2e883e1af895b62808b044ac96b77e7c9017b1:

  spi: Merge up fix (2023-10-30 13:20:58 +0000)

----------------------------------------------------------------
spi: Updates for v6.7

This is a very quiet release for SPI, we've got cleanups and minor fixes
but only a few new driver specific features.  The bulk of the changes in
terms of diffstat are the cleanups, plus one bit of performance work for
McSPI.

 - Conversions to use devm_clk_get_enabled() and to remove outdated
   terms for controller and device.
 - Device mode support for the Renesas CSI.
 - Cleanups and improvements to the device tree bindings aimed at making
   validation better.
 - PIO FIFO usage for the OMAP2 McSPI, improving performance.

----------------------------------------------------------------
Andy Shevchenko (4):
      spidev: Decrease indentation level in spidev_ioctl() SPI_IOC_RD_MODE*
      spidev: Switch to use spi_get_csgpiod()
      spidev: Simplify SPI_IOC_RD_MODE* cases in spidev_ioctl()
      spi: Don't use flexible array in struct spi_message definition

Bartosz Golaszewski (2):
      spi: bcm2835: reduce the abuse of the GPIO API
      spi: bcm2835: add a sentinel at the end of the lookup array

Christophe JAILLET (1):
      spi: at91-usart: Remove some dead code

Dhruva Gole (2):
      spi: spi-cadence-quadspi: add runtime pm support
      spi: spi-cadence-quadspi: Fix missing unwind goto warnings

Fabrizio Castro (2):
      spi: renesas,rzv2m-csi: Add CSI (SPI) target related property
      spi: rzv2m-csi: Add target mode support

Geert Uytterhoeven (1):
      spi: mpc52xx-psc: Make mpc52xx_psc_spi_transfer_one_message() static

Greg Kroah-Hartman (1):
      spi: spidev: make spidev_class constant

Han Xu (1):
      spi: nxp-fspi: use the correct ioremap function

Hans de Goede (1):
      spi: Export acpi_spi_find_controller_by_adev()

Kees Cook (1):
      spi: mchp-pci1xxxx: Annotate struct pci1xxxx_spi with __counted_by

Li Zetao (25):
      spi: ar934x: Use helper function devm_clk_get_enabled()
      spi: armada-3700: Use helper function devm_clk_get_prepared()
      spi: aspeed: Use helper function devm_clk_get_enabled()
      spi: ath79: Use helper function devm_clk_get_enabled()
      spi: spi-axi-spi-engine: Use helper function devm_clk_get_enabled()
      spi: bcm2835: Use helper function devm_clk_get_enabled()
      spi: bcm2835aux: Use helper function devm_clk_get_enabled()
      spi: spi-cadence: Use helper function devm_clk_get_enabled()
      spi: spi-cavium-thunderx: Use helper function devm_clk_get_enabled()
      spi: davinci: Use helper function devm_clk_get_enabled()
      spi: dw-bt1: Use helper function devm_clk_get_enabled()
      spi: dw-mmio: Use helper function devm_clk_get_*()
      spi: spi-fsl-dspi: Use helper function devm_clk_get_enabled()
      spi: lantiq-ssc: Use helper function devm_clk_get_enabled()
      spi: meson-spicc: Use helper function devm_clk_get_enabled()
      spi: spi-meson-spifc: Use helper function devm_clk_get_enabled()
      spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()
      spi: microchip-core: Use helper function devm_clk_get_enabled()
      spi: mtk-snfi: Use helper function devm_clk_get_enabled()
      spi: npcm-fiu: Use helper function devm_clk_get_enabled()
      spi: orion: Use helper function devm_clk_get_enabled()
      spi: pic32-sqi: Use helper function devm_clk_get_enabled()
      spi: pic32: Use helper function devm_clk_get_enabled()
      spi: spl022: Use helper function devm_clk_get_enabled()
      spi: rockchip: Use helper function devm_clk_get_enabled()

Mark Brown (8):
      spi: sun6i: fix RX data corruption in DMA mode
      Merge existing fixes from spi/for-6.6 into new branch
      spidev: A few cleanups
      spi: switch to use modern name (part3)
      spi: Use devm_clk_get_*() helper function to
      spi: qup: Allow scaling power domains and
      spi: Add RZ/V2M CSI target support
      spi: Merge up fix

Rob Herring (4):
      spi: dt-bindings: arm,pl022: Move child node properties to separate schema
      spi: dt-bindings: st,stm32-spi: Move "st,spi-midi-ns" to spi-peripheral-props.yaml
      spi: dt-bindings: Make "additionalProperties: true" explicit
      spi: stm32: Explicitly include correct DT includes

Stephan Gerhold (4):
      spi: dt-bindings: qup: Document power-domains and OPP
      spi: qup: Parse OPP table for DVFS support
      spi: dt-bindings: qup: Document interconnects
      spi: qup: Vote for interconnect bandwidth to DRAM

Uwe Kleine-König (1):
      spi: Drop warning from spi_stop_queue()

Vaishnav Achath (2):
      spi: omap2-mcspi: Fix hardcoded reference clock
      spi: omap2-mcspi: Add FIFO support without DMA

Vijaya Krishna Nivarthi (1):
      spi: spi-geni-qcom: Rename the label unmap_if_dma

Yang Yingliang (21):
      spi: lm70llp: switch to use modern name
      spi: lp-8841: switch to use modern name
      spi: meson-spicc: switch to use modern name
      spi: meson-spifc: switch to use modern name
      spi: microchip-core-qspi: switch to use modern name
      spi: microchip-core: switch to use modern name
      spi: mpc512x-psc: switch to use modern name
      spi: mpc52xx-psc: switch to use modern name
      spi: mpc52xx: switch to use modern name
      spi: mt65xx: switch to use modern name
      spi: mt7621: switch to use modern name
      spi: mtk-nor: switch to use modern name
      spi: mtk-snfi: switch to use modern name
      spi: mux: switch to use spi_alloc_host()
      spi: mxic: switch to use modern name
      spi: mxs: switch to use modern name
      spi: npcm-pspi: switch to use modern name
      spi: nxp-fspi: switch to use modern name
      spi: oc-tiny: switch to use modern name
      spi: omap-uwire: switch to use modern name
      spi: omap2-mcspi: switch to use modern name

Zhang Shurong (1):
      spi: tegra: Fix missing IRQ check in tegra_slink_probe()

 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |   2 +
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   2 +
 .../bindings/spi/arm,pl022-peripheral-props.yaml   |  61 ++++
 .../bindings/spi/nvidia,tegra210-quad.yaml         |   1 +
 .../devicetree/bindings/spi/qcom,spi-qup.yaml      |  13 +
 .../devicetree/bindings/spi/renesas,rzv2m-csi.yaml |   9 +
 .../devicetree/bindings/spi/rockchip-sfc.yaml      |   2 +
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |   2 +
 .../bindings/spi/spi-peripheral-props.yaml         |   6 +
 .../devicetree/bindings/spi/spi-pl022.yaml         |  51 ---
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |  20 --
 drivers/spi/Kconfig                                |   3 +-
 drivers/spi/spi-ar934x.c                           |  22 +-
 drivers/spi/spi-armada-3700.c                      |  23 +-
 drivers/spi/spi-aspeed-smc.c                       |  16 +-
 drivers/spi/spi-at91-usart.c                       |  22 +-
 drivers/spi/spi-ath79.c                            |  11 +-
 drivers/spi/spi-axi-spi-engine.c                   |  25 +-
 drivers/spi/spi-bcm2835.c                          |  69 ++--
 drivers/spi/spi-bcm2835aux.c                       |  23 +-
 drivers/spi/spi-cadence-quadspi.c                  |  45 ++-
 drivers/spi/spi-cadence.c                          |  23 +-
 drivers/spi/spi-cavium-thunderx.c                  |   8 +-
 drivers/spi/spi-davinci.c                          |  11 +-
 drivers/spi/spi-dw-bt1.c                           |  23 +-
 drivers/spi/spi-dw-mmio.c                          |  31 +-
 drivers/spi/spi-fsl-dspi.c                         |  12 +-
 drivers/spi/spi-geni-qcom.c                        |   6 +-
 drivers/spi/spi-lantiq-ssc.c                       |  10 +-
 drivers/spi/spi-lm70llp.c                          |  20 +-
 drivers/spi/spi-lp8841-rtc.c                       |  56 +--
 drivers/spi/spi-meson-spicc.c                      | 121 +++----
 drivers/spi/spi-meson-spifc.c                      |  79 ++--
 drivers/spi/spi-microchip-core-qspi.c              |  39 +-
 drivers/spi/spi-microchip-core.c                   |  83 ++---
 drivers/spi/spi-mpc512x-psc.c                      |  54 +--
 drivers/spi/spi-mpc52xx-psc.c                      |  38 +-
 drivers/spi/spi-mpc52xx.c                          |  56 +--
 drivers/spi/spi-mt65xx.c                           | 190 +++++-----
 drivers/spi/spi-mt7621.c                           |  50 +--
 drivers/spi/spi-mtk-nor.c                          |  14 +-
 drivers/spi/spi-mtk-snfi.c                         |  67 +---
 drivers/spi/spi-mux.c                              |   2 +-
 drivers/spi/spi-mxic.c                             |  68 ++--
 drivers/spi/spi-mxs.c                              |  70 ++--
 drivers/spi/spi-npcm-fiu.c                         |  14 +-
 drivers/spi/spi-npcm-pspi.c                        |  68 ++--
 drivers/spi/spi-nxp-fspi.c                         |  32 +-
 drivers/spi/spi-oc-tiny.c                          |  30 +-
 drivers/spi/spi-omap-uwire.c                       |  32 +-
 drivers/spi/spi-omap2-mcspi.c                      | 400 ++++++++++++++-------
 drivers/spi/spi-orion.c                            |  11 +-
 drivers/spi/spi-pci1xxxx.c                         |   2 +-
 drivers/spi/spi-pic32-sqi.c                        |  27 +-
 drivers/spi/spi-pic32.c                            |   8 +-
 drivers/spi/spi-pl022.c                            |  11 +-
 drivers/spi/spi-qup.c                              |  50 ++-
 drivers/spi/spi-rockchip.c                         |  30 +-
 drivers/spi/spi-rzv2m-csi.c                        | 127 ++++---
 drivers/spi/spi-stm32.c                            |   3 +-
 drivers/spi/spi-tegra20-slink.c                    |   2 +
 drivers/spi/spi.c                                  |   9 +-
 drivers/spi/spidev.c                               |  42 +--
 include/linux/spi/spi.h                            |  28 +-
 64 files changed, 1211 insertions(+), 1274 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/arm,pl022-peripheral-props.yaml
