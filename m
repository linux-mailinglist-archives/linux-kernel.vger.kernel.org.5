Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD55278AA1F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjH1KTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjH1KSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32611CC8;
        Mon, 28 Aug 2023 03:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADE25637F1;
        Mon, 28 Aug 2023 10:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B1BC433C9;
        Mon, 28 Aug 2023 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693217915;
        bh=glyfAB7WjJkrmwci4eu/8aOVzKAjIbvy+bp2sfMOj2M=;
        h=From:To:Cc:Subject:Date:From;
        b=aPY+hQA+cbTTTSvY1iW1XIMGYb63BPzeZ8qwYxJ8DdwOZBxw2rpED31cJya44LcVY
         ShOVuB26HNpDp/TqzXFt6E1ZeuV08g0JhgyD5yYljR5/eVe5eFDRNU3/K6O/atIH4U
         fExCSrMrxqyHTx822EboDdOScGffoGhFgWdbciyicftb38d8R1BkF6Cd82zmV17u6u
         OjrelSLSoJt87//tUybcrY3rhoe7+Z30C+JbVs9ruoGNJU7nIhCXtZ2d5jwns9htYN
         nqZF6X4c6v7OkB6x7JznbyaoLkRTv4abcTlnTlxmRafKZR2BdpTQ7UNclYSRAjnOWo
         K/oVFAvk4cePA==
Message-ID: <3f23f4016225109af97b67053a757218.broonie@kernel.org>
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.6
Date:   Mon, 28 Aug 2023 11:18:15 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

  Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.6

for you to fetch changes up to 60ea3db33fbddf559e18567ca8897f6bb9f25290:

  spi: at91-usart: Use PTR_ERR_OR_ZERO() to simplify code (2023-08-22 13:51:35 +0100)

----------------------------------------------------------------
spi: Updates for v6.6

There's been quite a lot of generic activity here, but more
administrative than featuers.  We also have a bunch of new drivers,
including one that's part of a MFD so we pulled in the core parts of
that:

 - Lots of work from both Yang Yingliang and Andy Shevchenko on moving
   to host/device/controller based terminology for devices.
 - QuadSPI SPI support for Allwinner sun6i.
 - New device support Cirrus Logic CS43L43, Longsoon, Qualcomm GENI
   QuPv3 and StarFive JH7110 QSPI.

----------------------------------------------------------------
Alexander Danilenko (1):
      spi: tegra114: Remove unnecessary NULL-pointer checks

Alexander Stein (5):
      spi: spi-fsl-lpspi: Remove num_cs from device struct
      spi: spi-fsl-lpspi: Move controller initialization further down
      spi: spi-fsl-lpspi: Read chip-select amount from hardware for i.MX93
      spi: lpspi: Add power-domains to the DT bindings
      spi: fspi: Add power-domains to the DT bindings

Andy Shevchenko (14):
      spi: Remove unneeded OF node NULL checks
      spi: Drop duplicate IDR allocation code in spi_register_controller()
      spi: Replace if-else-if by bitops and multiplications
      spi: Use sysfs_emit() to instead of s*printf()
      spi: Sort headers alphabetically
      spi: Get rid of old SPI_MASTER_NO_TX & SPI_MASTER_NO_RX
      spi: Get rid of old SPI_MASTER_MUST_TX & SPI_MASTER_MUST_RX
      spi: Rename SPI_MASTER_GPIO_SS to SPI_CONTROLLER_GPIO_SS
      spi: Convert to SPI_CONTROLLER_HALF_DUPLEX
      spi: Fix spelling typos and acronyms capitalization
      spi: Remove code duplication in spi_add_device*()
      spi: Kill spi_add_device_locked()
      spi: Use BITS_TO_BYTES()
      spi: Use struct_size() helper

Charles Keepax (3):
      dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
      mfd: cs42l43: Add support for cs42l43 core driver
      pinctrl: cs42l43: Add support for the cs42l43

Chen Jiahao (2):
      spi: s3c64xx: Clean up redundant dev_err_probe()
      spi: microchip-core: Clean up redundant dev_err_probe()

Christophe Leroy (1):
      spi: fsl-cpm: Properly define and use IO pointers

Fabrizio Castro (9):
      spi: rzv2m-csi: Add missing include
      spi: rzv2m-csi: Adopt HZ_PER_MHZ for max spi clock
      spi: rzv2m-csi: Rework CSI_CKS_MAX definition
      spi: rzv2m-csi: Leave readl_poll_timeout calls for last
      spi: rzv2m-csi: Replace unnecessary ternary operators
      spi: rzv2m-csi: Squash timing settings into one statement
      spi: rzv2m-csi: Improve data types, casting and alignment
      spi: rzv2m-csi: Get rid of the x_trg{_words} tables
      spi: rzv2m-csi: Make use of device_set_node

Jinjie Ruan (1):
      spi: at91-usart: Use PTR_ERR_OR_ZERO() to simplify code

Jonas Gorski (1):
      dt-bindings: spi: convert spi-brcm63xx.txt to YAML

Krzysztof Kozlowski (3):
      spi: sc18is602: fix Wvoid-pointer-to-enum-cast warning
      spi: pxa2xx: fix Wvoid-pointer-to-enum-cast warning
      spi: amd: fix Wvoid-pointer-to-enum-cast warning

Kunihiko Hayashi (1):
      spi: dw: Set default value if reg-io-width isn't specified

Li Zetao (1):
      spi: mpc5xxx-psc: Fix unsigned expression compared with zero

Lucas Tanure (2):
      soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
      spi: cs42l43: Add SPI controller support

Maksim Kiselev (2):
      spi: sun6i: add quirk for dual and quad SPI modes support
      spi: sun6i: add dual and quad SPI modes support for R329/D1/R528/T113s

Mark Brown (12):
      spi: amlogic-spifc-a1: fixes and improvements for
      Allwinner R329/D1/R528/T113s Dual/Quad SPI modes
      spi: Header and core clean up and refactoring
      spi: rzv2m-csi: Code refactoring
      spi: Merge up fixes from mainline
      spi: Merge up fixes from Linus' tree
      spi-geni-qcom: Add SPI device mode support for GENI
      spi: switch to use modern name
      spi: switch to use modern name (part2)
      mfd: Immutable branch between MFD, Pinctrl and soundwire due for the v6.6 merge window
      Add cs42l43 PC focused SoundWire CODEC
      spi: switch to use modern name (part4)

Martin Kurbanov (2):
      spi: amlogic-spifc-a1: implement adjust_op_size()
      spi: amlogic-spifc-a1: add support for max_speed_hz

Michal Simek (2):
      dt-bindings: spi: spi-cadence: Describe power-domains property
      dt-bindings: spi: spi-cadence: Add label property

Minjie Du (1):
      spi: fsl-dspi: Use dev_err_probe() in dspi_request_dma()

Praveen Talari (2):
      soc: qcom: geni-se: Add SPI Device mode support for GENI based QuPv3
      spi: spi-geni-qcom: Add SPI Device mode support for GENI based QuPv3

Rajeshwar R Shinde (1):
      spi: spi-mpc52xx-psc: Fix an unsigned comparison that can never be negative

Rob Herring (1):
      spi: Explicitly include correct DT includes

Ruan Jinjie (3):
      spi: stm32: Remove redundant dev_err_probe()
      spi: spi-zynq: Do not check for 0 return after calling platform_get_irq()
      spi: Do not check for 0 return after calling platform_get_irq()

Stefan Moring (1):
      spi: Increase imx51 ecspi burst length based on transfer length

Thierry Reding (3):
      dt-bindings: spi: tegra-slink: Convert to json-schema
      dt-bindings: spi: tegra-sflash: Convert to json-schema
      dt-bindings: spi: Convert Tegra114 SPI to json-schema

Uwe Kleine-König (1):
      spi: rzv2m-csi: Convert to platform remove callback returning void

Valentin Caron (1):
      spi: stm32: disable device mode with st,stm32f4-spi compatible

Wang Ming (1):
      spi: Use dev_err_probe instead of dev_err

William Qiu (3):
      dt-bindings: spi: add reference file to YAML
      dt-bindings: qspi: cdns,qspi-nor: Add clocks for StarFive JH7110 SoC
      spi: cadence-quadspi: Add clock configuration for StarFive JH7110 QSPI

Yang Yingliang (66):
      spi: amd: switch to use modern name
      spi: aspeed: switch to use modern name
      spi: spi-axi-spi-engine: switch to use modern name
      spi: bcm-qspi: switch to use modern name
      spi: bcm2835: switch to use modern name
      spi: bcm2835aux: switch to use modern name
      spi: bcm63xx-hsspi: switch to use modern name
      spi: bcm63xx: switch to use modern name
      spi: butterfly: switch to use modern name
      spi: cadence-xspi: switch to use modern name
      spi: cadence: switch to use modern name
      spi: clps711x: switch to use modern name
      spi: octeon: switch to use modern name
      spi: spi-cavium-thunderx: switch to use modern name
      spi: coldfire-qspi: switch to use modern name
      spi: davinci: switch to use modern name
      spi: dln2: switch to use modern name
      spi: dw: switch to use modern name
      spi: hisi-kunpeng: switch to use modern name
      spi: npcm-fiu: switch to use modern name
      spi: cadence-quadspi: switch to use modern name
      spi: amlogic-spifc-a1: switch to use devm_spi_alloc_host()
      spi: au1550: switch to use modern name
      spi: ep93xx: switch to use modern name
      spi: falcon: switch to use modern name
      spi: fsi: switch to use spi_alloc_host()
      spi: fsl-dspi: switch to use modern name
      spi: fsl-espi: switch to use modern name
      spi: fsl-lpspi: switch to use modern name
      spi: fsl-qspi: switch to use modern name
      spi: fsl-spi: switch to use modern name
      spi: gpio: switch to use modern name
      spi: gxp: switch to use modern name
      spi: bcmbca-hsspi: switch to use modern name
      spi: hisi-sfc-v3xx: switch to use modern name
      spi: img-spfi: switch to use modern name
      spi: imx: switch to use modern name
      spi: ingenic: switch to use devm_spi_alloc_host()
      spi: intel: switch to use modern name
      spi: jcore: switch to use modern name
      spi: lantiq: switch to use modern name
      spi: dw-mmio: keep old name same as documentation
      spi: rpc-if: switch to use devm_spi_alloc_host()
      spi: orion: switch to use modern name
      spi: mchp-pci1xxxx: switch to use modern name
      spi: pic32-sqi: switch to use modern name
      spi: pic32: switch to use modern name
      spi: spl022: switch to use modern name
      spi: ppc4xx: switch to use modern name
      spi: pxa2xx: switch to use modern name
      spi: spi-qcom-qspi: switch to use modern name
      spi: qup: switch to use modern name
      spi: rb4xx: switch to use modern name
      spi: realtek-rtl: switch to use devm_spi_alloc_host()
      spi: rockchip-sfc: switch to use modern name
      spi: rockchip: switch to use modern name
      spi: rspi: switch to use spi_alloc_host()
      spi: rzv2m-csi: switch to use devm_spi_alloc_host()
      spi: s3c64xx: switch to use modern name
      spi: sc18is602: switch to use modern name
      spi: sh-hspi: switch to use modern name
      spi: sh-msiof: switch to use modern name
      spi: sh-sci: switch to use modern name
      spi: sh: switch to use modern name
      spi: sifive: switch to use modern name
      spi: spi-sn-f-ospi: switch to use modern name

Yangtao Li (8):
      spi: atmel: Use devm_platform_get_and_ioremap_resource()
      spi: davinci: Use devm_platform_get_and_ioremap_resource()
      spi: ep93xx: Use devm_platform_get_and_ioremap_resource()
      spi: spi-nxp-fspi: Convert to devm_platform_ioremap_resource() and devm_platform_ioremap_resource_byname()
      spi: rspi: Use devm_platform_get_and_ioremap_resource()
      spi: tegra20-slink: Use devm_platform_get_and_ioremap_resource()
      spi: s3c64xx: Use devm_platform_get_and_ioremap_resource()
      spi: spi-cadence: Delete unmatched comments

Yinbo Zhu (2):
      spi: dt-bindings: add loongson spi
      spi: loongson: add bus driver for the loongson spi controller

Yuanjun Gong (2):
      spi: fix return value check in bcm2835_spi_probe()
      spi: use devm_clk_get_enabled() in mcfqspi_probe()

YueHaibing (1):
      spi: fsl: Remove unused extern declarations

Zhang Shurong (1):
      spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()

Zhang Zekun (1):
      spi: bcm-qspi: Simplify logic by using devm_platform_ioremap_resource_byname()

Zhu Wang (2):
      spi: fsl-spi: Do not check 0 for platform_get_irq()
      spi: omap2-mcspi: remove redundant dev_err_probe()

 .../devicetree/bindings/sound/cirrus,cs42l43.yaml  |  313 ++++++
 .../devicetree/bindings/spi/brcm,bcm63xx-spi.yaml  |   71 ++
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |   12 +-
 .../devicetree/bindings/spi/loongson,ls2k-spi.yaml |   46 +
 .../bindings/spi/nvidia,tegra114-spi.txt           |   61 -
 .../bindings/spi/nvidia,tegra114-spi.yaml          |  100 ++
 .../bindings/spi/nvidia,tegra20-sflash.txt         |   37 -
 .../bindings/spi/nvidia,tegra20-sflash.yaml        |   81 ++
 .../bindings/spi/nvidia,tegra20-slink.txt          |   37 -
 .../bindings/spi/nvidia,tegra20-slink.yaml         |   90 ++
 .../devicetree/bindings/spi/spi-bcm63xx.txt        |   33 -
 .../devicetree/bindings/spi/spi-cadence.yaml       |    6 +
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |    3 +
 .../devicetree/bindings/spi/spi-nxp-fspi.yaml      |    3 +
 .../devicetree/bindings/spi/spi-pl022.yaml         |    1 +
 MAINTAINERS                                        |   16 +-
 drivers/mfd/Kconfig                                |   23 +
 drivers/mfd/Makefile                               |    3 +
 drivers/mfd/cs42l43-i2c.c                          |   98 ++
 drivers/mfd/cs42l43-sdw.c                          |  239 ++++
 drivers/mfd/cs42l43.c                              | 1188 ++++++++++++++++++++
 drivers/mfd/cs42l43.h                              |   28 +
 drivers/pinctrl/cirrus/Kconfig                     |   11 +
 drivers/pinctrl/cirrus/Makefile                    |    2 +
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c           |  609 ++++++++++
 drivers/soundwire/bus.c                            |   32 +
 drivers/soundwire/bus_type.c                       |   12 +
 drivers/spi/Kconfig                                |   33 +
 drivers/spi/Makefile                               |    4 +
 drivers/spi/spi-amd.c                              |   52 +-
 drivers/spi/spi-amlogic-spifc-a1.c                 |   88 +-
 drivers/spi/spi-ar934x.c                           |    3 +-
 drivers/spi/spi-armada-3700.c                      |    3 +-
 drivers/spi/spi-aspeed-smc.c                       |   14 +-
 drivers/spi/spi-at91-usart.c                       |    8 +-
 drivers/spi/spi-ath79.c                            |    2 +-
 drivers/spi/spi-atmel.c                            |   10 +-
 drivers/spi/spi-au1550.c                           |   74 +-
 drivers/spi/spi-axi-spi-engine.c                   |   62 +-
 drivers/spi/spi-bcm-qspi.c                         |   64 +-
 drivers/spi/spi-bcm2835.c                          |  130 +--
 drivers/spi/spi-bcm2835aux.c                       |   92 +-
 drivers/spi/spi-bcm63xx-hsspi.c                    |   86 +-
 drivers/spi/spi-bcm63xx.c                          |   68 +-
 drivers/spi/spi-bcmbca-hsspi.c                     |   66 +-
 drivers/spi/spi-bitbang-txrx.h                     |   16 +-
 drivers/spi/spi-bitbang.c                          |    8 +-
 drivers/spi/spi-butterfly.c                        |   18 +-
 drivers/spi/spi-cadence-quadspi.c                  |  112 +-
 drivers/spi/spi-cadence-xspi.c                     |   31 +-
 drivers/spi/spi-cadence.c                          |   76 +-
 drivers/spi/spi-cavium-octeon.c                    |   32 +-
 drivers/spi/spi-cavium-thunderx.c                  |   32 +-
 drivers/spi/spi-clps711x.c                         |   42 +-
 drivers/spi/spi-coldfire-qspi.c                    |   77 +-
 drivers/spi/spi-cs42l43.c                          |  284 +++++
 drivers/spi/spi-davinci.c                          |   90 +-
 drivers/spi/spi-dln2.c                             |   94 +-
 drivers/spi/spi-dw-core.c                          |  112 +-
 drivers/spi/spi-dw-dma.c                           |   22 +-
 drivers/spi/spi-dw-mmio.c                          |   10 +-
 drivers/spi/spi-dw.h                               |    4 +-
 drivers/spi/spi-ep93xx.c                           |  187 ++-
 drivers/spi/spi-falcon.c                           |   34 +-
 drivers/spi/spi-fsi.c                              |    2 +-
 drivers/spi/spi-fsl-cpm.c                          |   74 +-
 drivers/spi/spi-fsl-dspi.c                         |   34 +-
 drivers/spi/spi-fsl-espi.c                         |   76 +-
 drivers/spi/spi-fsl-lib.c                          |    3 +-
 drivers/spi/spi-fsl-lib.h                          |    3 -
 drivers/spi/spi-fsl-lpspi.c                        |   89 +-
 drivers/spi/spi-fsl-qspi.c                         |   11 +-
 drivers/spi/spi-fsl-spi.c                          |   80 +-
 drivers/spi/spi-geni-qcom.c                        |   53 +-
 drivers/spi/spi-gpio.c                             |   77 +-
 drivers/spi/spi-gxp.c                              |    7 +-
 drivers/spi/spi-hisi-kunpeng.c                     |   84 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                    |   18 +-
 drivers/spi/spi-img-spfi.c                         |  118 +-
 drivers/spi/spi-imx.c                              |  128 ++-
 drivers/spi/spi-ingenic.c                          |    4 +-
 drivers/spi/spi-intel.c                            |   42 +-
 drivers/spi/spi-iproc-qspi.c                       |    9 +-
 drivers/spi/spi-jcore.c                            |   44 +-
 drivers/spi/spi-lantiq-ssc.c                       |   99 +-
 drivers/spi/spi-loongson-core.c                    |  279 +++++
 drivers/spi/spi-loongson-pci.c                     |   55 +
 drivers/spi/spi-loongson-plat.c                    |   47 +
 drivers/spi/spi-loongson.h                         |   49 +
 drivers/spi/spi-loopback-test.c                    |    2 +-
 drivers/spi/spi-lp8841-rtc.c                       |   11 +-
 drivers/spi/spi-meson-spicc.c                      |    3 +-
 drivers/spi/spi-microchip-core.c                   |    6 +-
 drivers/spi/spi-mpc512x-psc.c                      |    2 +-
 drivers/spi/spi-mpc52xx-psc.c                      |    2 +-
 drivers/spi/spi-mt65xx.c                           |    2 +-
 drivers/spi/spi-mt7621.c                           |    2 +
 drivers/spi/spi-mtk-nor.c                          |    3 +-
 drivers/spi/spi-mtk-snfi.c                         |    3 +-
 drivers/spi/spi-mxs.c                              |    2 +-
 drivers/spi/spi-npcm-fiu.c                         |   22 +-
 drivers/spi/spi-nxp-fspi.c                         |    7 +-
 drivers/spi/spi-omap-uwire.c                       |    2 +-
 drivers/spi/spi-omap2-mcspi.c                      |    4 +-
 drivers/spi/spi-orion.c                            |   91 +-
 drivers/spi/spi-pci1xxxx.c                         |   16 +-
 drivers/spi/spi-pic32-sqi.c                        |   86 +-
 drivers/spi/spi-pic32.c                            |  154 +--
 drivers/spi/spi-pl022.c                            |   94 +-
 drivers/spi/spi-ppc4xx.c                           |   44 +-
 drivers/spi/spi-pxa2xx.c                           |   26 +-
 drivers/spi/spi-qcom-qspi.c                        |   82 +-
 drivers/spi/spi-qup.c                              |  167 ++-
 drivers/spi/spi-rb4xx.c                            |   36 +-
 drivers/spi/spi-realtek-rtl.c                      |    2 +-
 drivers/spi/spi-rockchip-sfc.c                     |   30 +-
 drivers/spi/spi-rockchip.c                         |   60 +-
 drivers/spi/spi-rpc-if.c                           |    2 +-
 drivers/spi/spi-rspi.c                             |    7 +-
 drivers/spi/spi-rzv2m-csi.c                        |  122 +-
 drivers/spi/spi-s3c64xx.c                          |  138 ++-
 drivers/spi/spi-sc18is602.c                        |   53 +-
 drivers/spi/spi-sh-hspi.c                          |    4 +-
 drivers/spi/spi-sh-msiof.c                         |   51 +-
 drivers/spi/spi-sh-sci.c                           |   24 +-
 drivers/spi/spi-sh.c                               |   34 +-
 drivers/spi/spi-sifive.c                           |   80 +-
 drivers/spi/spi-slave-mt27xx.c                     |    2 +-
 drivers/spi/spi-sn-f-ospi.c                        |    6 +-
 drivers/spi/spi-sprd-adi.c                         |    3 +-
 drivers/spi/spi-sprd.c                             |    1 -
 drivers/spi/spi-stm32-qspi.c                       |    1 -
 drivers/spi/spi-stm32.c                            |   18 +-
 drivers/spi/spi-sun6i.c                            |   32 +-
 drivers/spi/spi-tegra114.c                         |   19 +-
 drivers/spi/spi-tegra20-sflash.c                   |    6 +-
 drivers/spi/spi-tegra20-slink.c                    |   11 +-
 drivers/spi/spi-tegra210-quad.c                    |    1 -
 drivers/spi/spi-ti-qspi.c                          |    3 +-
 drivers/spi/spi-wpcm-fiu.c                         |    3 +-
 drivers/spi/spi-xcomm.c                            |    2 +-
 drivers/spi/spi-xtensa-xtfpga.c                    |    2 +-
 drivers/spi/spi-zynq-qspi.c                        |    4 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |    8 +-
 drivers/spi/spi.c                                  |  219 ++--
 include/linux/mfd/cs42l43-regs.h                   | 1184 +++++++++++++++++++
 include/linux/mfd/cs42l43.h                        |  102 ++
 include/linux/soc/qcom/geni-se.h                   |    9 +
 include/linux/soundwire/sdw.h                      |    9 +
 include/linux/spi/pxa2xx_spi.h                     |    4 +-
 include/linux/spi/sh_msiof.h                       |    4 +-
 include/linux/spi/spi.h                            |  171 +--
 include/trace/events/spi.h                         |    2 +-
 153 files changed, 7500 insertions(+), 2582 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
 create mode 100644 drivers/mfd/cs42l43-i2c.c
 create mode 100644 drivers/mfd/cs42l43-sdw.c
 create mode 100644 drivers/mfd/cs42l43.c
 create mode 100644 drivers/mfd/cs42l43.h
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs42l43.c
 create mode 100644 drivers/spi/spi-cs42l43.c
 create mode 100644 drivers/spi/spi-loongson-core.c
 create mode 100644 drivers/spi/spi-loongson-pci.c
 create mode 100644 drivers/spi/spi-loongson-plat.c
 create mode 100644 drivers/spi/spi-loongson.h
 create mode 100644 include/linux/mfd/cs42l43-regs.h
 create mode 100644 include/linux/mfd/cs42l43.h
