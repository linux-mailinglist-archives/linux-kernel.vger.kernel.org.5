Return-Path: <linux-kernel+bounces-19008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2EC826663
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF741B210B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE6513AE3;
	Sun,  7 Jan 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCIkBfPV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAF125A6;
	Sun,  7 Jan 2024 22:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB59C433C7;
	Sun,  7 Jan 2024 22:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704667098;
	bh=LvcbQN/QjJ9hFM+Mpj4RpGZZRNqG10z4C29uBZgizQo=;
	h=From:To:Cc:Subject:Date:From;
	b=WCIkBfPVCqeYVmOvQ4SDIXOLII39kAlNpxACcJ6xvtSF4LXDOBEg6s9lD6oQ2j9MS
	 T+zx10NBba50B3FjxT8dmImooNyOlLqqJYiSko7Dly43WYKet42Bs8CepHa+pPLB4K
	 JpEH/Tp+MKIacMXX/rXFcL5GQ4XRvek9d2Nzlb9rLehoFjct6kCDHJAsEcZWvL0p0h
	 JwrtDSzEUJYlm7BkggbbyjDK0t3dJAp8NFPoKYkj/WjzO1oPB/i5li6Yb+XRiacvj+
	 wlbnk+wHfESjbeI8L/yL4ecnMC+zYeXlzUOBV/LqMIXvO4fvZwdp/8q8LGCErX9pbG
	 7ADasrPMmTMew==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI updates for v6.8
Date: Sun, 07 Jan 2024 22:38:09 +0000
Message-Id: <20240107223817.EDB59C433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.8

for you to fetch changes up to f6cd66231aa58599526584ff4df1bdde8d86eac8:

  spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc (2023-12-21 20:44:05 +0000)

----------------------------------------------------------------
spi: Updates for v6.8

A moderately busy release for SPI, the main core update was the merging
of support for multiple chip selects, used in some flash configurations.
There were also big overhauls for the AXI SPI Engine and PL022 drivers,
plus some new device support for ST.

There's a few patches for other trees, API updates to allow the
multiple chip select support and one of the naming modernisations
touched a controller embedded in the USB code.

 - Support for multiple chip selects.
 - A big overhaul for the AXI SPI engine driver, modernising it and
   adding a bunch of new features.
 - Modernisation of the PL022 driver, fixing some issues with submitting
   messages while in atomic context in the process.
 - Many drivers were converted to use new APIs which avoid outdated
   terminology for devices and controllers.
 - Support for ST Microelectronics STM32F7 and STM32MP25, and Renesas
   RZ/Five.

----------------------------------------------------------------
Alain Volmat (1):
      spi: stm32: use dma_get_slave_caps prior to configuring dma channel

Amit Kumar Mahapatra (4):
      spi: spi-zynqmp-gqspi: fix driver kconfig dependencies
      mfd: tps6594: Use spi_get_chipselect() API to access spi->chip_select
      ALSA: hda/cs35l56: Use set/get APIs to access spi->chip_select
      spi: Add multi-cs memories support in SPI core

Andrew Davis (1):
      spi: sprd: adi: Use devm_register_restart_handler()

Andy Shevchenko (3):
      treewide, spi: Get rid of SPI_MASTER_HALF_DUPLEX
      spi: pxa2xx: Use inclusive language
      spi: pxa2xx: Update DMA mapping and using logic in the documentation

Ben Wolsieffer (4):
      spi: stm32: rename stm32f4_* to stm32fx_*
      spi: stm32: use callbacks for read_rx and write_tx
      spi: stm32: add STM32F7 support
      spi: add stm32f7-spi compatible

Chia-Lin Kao (AceLan) (2):
      spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP
      mtd: spi-nor: Stop reporting warning message when soft reset is not suported

Christophe JAILLET (1):
      spi: ingenic: convert not to use dma_request_slave_channel()

David Lechner (24):
      dt-bindings: spi: axi-spi-engine: convert to yaml
      MAINTAINERS: add entry for AXI SPI Engine
      spi: axi-spi-engine: simplify driver data allocation
      spi: axi-spi-engine: use devm_spi_alloc_host()
      spi: axi-spi-engine: use devm action to reset hw on remove
      spi: axi-spi-engine: use devm_request_irq()
      spi: axi-spi-engine: use devm_spi_register_controller()
      spi: axi-spi-engine: check for valid clock rate
      spi: axi-spi-engine: move msg state to new struct
      spi: axi-spi-engine: use message_prepare/unprepare
      spi: axi-spi-engine: remove completed_id from driver state
      spi: axi-spi-engine: remove struct spi_engine::msg
      spi: axi-spi-engine: add support for cs_off
      spi: axi-spi-engine: add support for any word size
      spi: axi-spi-engine: return void from spi_engine_compile_message()
      spi: axi-spi-engine: populate xfer->effective_speed_hz
      spi: axi-spi-engine: remove spi_engine_get_clk_div()
      spi: axi-spi-engine: fix sleep ticks calculation
      spi: axi-spi-engine: remove xfer arg from spi_engine_gen_sleep()
      spi: axi-spi-engine: implement xfer->cs_change_delay
      spi: axi-spi-engine: restore clkdiv at end of message
      spi: axi-spi-engine: remove delay from CS assertion
      spi: axi-spi-engine: add watchdog timer
      spi: axi-spi-engine: fix struct member doc warnings

Lad Prabhakar (1):
      spi: dt-bindings: renesas,rspi: Document RZ/Five SoC

Mark Brown (7):
      Add STM32F7 SPI support
      spi: axi-spi-engine improvements
      spi: spl022: fix sleeping in interrupt context
      spi: axi-spi-engine: improvements round 2
      spi: Add support for stacked/parallel memories
      spi: pxa2xx: Update documentation
      spi: pl022: clean up some unused variables

Nam Cao (6):
      spi: introduce SPI_TRANS_FAIL_IO for error reporting
      spi: spl022: switch to use default spi_transfer_one_message()
      spi: pl022: delete unused cur_gpiod in struct pl022
      spi: pl022: delete unused next_msg_cs_active in struct pl022
      spi: pl022: delete description of cur_msg
      spi: pl022: update description of internal_cs_control()

Nandhini Srikandan (2):
      spi: dw: Remove Intel Thunder Bay SOC support
      spi: dw: Remove Intel Thunder Bay SOC support

Raag Jadav (1):
      spi: intel: make mem_ops comparison unique to opcode match

Randy Dunlap (1):
      spi: mpc52xx: explicitly include linux/platform_device.h

Uwe Kleine-König (2):
      spi: cadence-xspi: Drop useless assignment to NULL
      spi: spi-ti-qspi: Convert to platform remove callback returning void

Valentin Caron (2):
      dt-bindings: spi: stm32: add st,stm32mp25-spi compatible
      spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc

Wolfram Sang (1):
      spi: sh-msiof: Enforce fixed DTDL for R-Car H3

Yang Yingliang (27):
      spi: cadence-quadspi: add missing clk_disable_unprepare() in cqspi_probe()
      spi: sprd-adi: switch to use spi_alloc_host()
      spi: sprd: switch to use modern name
      spi: st-ssc4: switch to use modern name
      spi: stm32-qspi: switch to use modern name
      spi: stm32: switch to use modern name
      spi: sun4i: switch to use modern name
      spi: sun6i: switch to use modern name
      spi: sunplus-sp7021: switch to use modern name
      spi: synquacer: switch to use modern name
      spi: geni-qcom: switch to use modern name
      spi: tegra114: switch to use modern name
      spi: tegra20-sflash: switch to use modern name
      spi: tegra20-slink: switch to use modern name
      spi: tegra210-quad: switch to use modern name
      spi: spi-ti-qspi: switch to use modern name
      spi: wpcm-fiu: switch to use devm_spi_alloc_host()
      spi: topcliff-pch: switch to use modern name
      spi: uniphier: switch to use modern name
      spi: xcomm: switch to use modern name
      spi: xilinx: switch to use modern name
      spi: xlp: switch to use modern name
      spi: xtensa-xtfpga: switch to use modern name
      spi: zynq-qspi: switch to use modern name
      spi: zynqmp-gqspi: switch to use modern name
      spi: cs42l43: switch to use devm_spi_alloc_host()
      spi: ljca: switch to use devm_spi_alloc_host()

 .../devicetree/bindings/spi/adi,axi-spi-engine.txt |  31 -
 .../bindings/spi/adi,axi-spi-engine.yaml           |  66 +++
 .../devicetree/bindings/spi/renesas,rspi.yaml      |   2 +-
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |   2 -
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |   2 +
 Documentation/spi/pxa2xx.rst                       |  59 +-
 MAINTAINERS                                        |  10 +
 drivers/input/rmi4/rmi_spi.c                       |   2 +-
 drivers/mfd/tps6594-spi.c                          |   2 +-
 drivers/mmc/host/mmc_spi.c                         |   2 +-
 drivers/mtd/nand/spi/core.c                        |   2 +-
 drivers/mtd/spi-nor/core.c                         |   5 +-
 drivers/net/ethernet/micrel/ks8851_spi.c           |   4 +-
 drivers/spi/Kconfig                                |   3 +-
 drivers/spi/atmel-quadspi.c                        |   2 +-
 drivers/spi/spi-ath79.c                            |   2 +-
 drivers/spi/spi-axi-spi-engine.c                   | 519 +++++++++++------
 drivers/spi/spi-bcm-qspi.c                         |   2 +-
 drivers/spi/spi-cadence-quadspi.c                  |   4 +-
 drivers/spi/spi-cadence-xspi.c                     |   1 -
 drivers/spi/spi-cs42l43.c                          |   2 +-
 drivers/spi/spi-dw-mmio.c                          |   1 -
 drivers/spi/spi-geni-qcom.c                        |  96 ++--
 drivers/spi/spi-ingenic.c                          |  15 +-
 drivers/spi/spi-intel.c                            |  10 +-
 drivers/spi/spi-ljca.c                             |   2 +-
 drivers/spi/spi-mem.c                              |   6 +-
 drivers/spi/spi-mpc52xx.c                          |   1 +
 drivers/spi/spi-npcm-fiu.c                         |   2 +-
 drivers/spi/spi-pl022.c                            | 382 +++---------
 drivers/spi/spi-sh-msiof.c                         |  17 +
 drivers/spi/spi-sprd-adi.c                         |  32 +-
 drivers/spi/spi-sprd.c                             |   4 +-
 drivers/spi/spi-st-ssc4.c                          |  70 +--
 drivers/spi/spi-stm32-qspi.c                       |  18 +-
 drivers/spi/spi-stm32.c                            | 638 +++++++++++++++------
 drivers/spi/spi-sun4i.c                            |  72 +--
 drivers/spi/spi-sun6i.c                            | 148 ++---
 drivers/spi/spi-sunplus-sp7021.c                   |  88 +--
 drivers/spi/spi-synquacer.c                        |  82 +--
 drivers/spi/spi-tegra114.c                         | 118 ++--
 drivers/spi/spi-tegra20-sflash.c                   |  76 +--
 drivers/spi/spi-tegra20-slink.c                    |  98 ++--
 drivers/spi/spi-tegra210-quad.c                    |  80 +--
 drivers/spi/spi-ti-qspi.c                          | 103 ++--
 drivers/spi/spi-topcliff-pch.c                     | 226 ++++----
 drivers/spi/spi-uniphier.c                         | 194 +++----
 drivers/spi/spi-wpcm-fiu.c                         |   4 +-
 drivers/spi/spi-xcomm.c                            |  32 +-
 drivers/spi/spi-xilinx.c                           |  58 +-
 drivers/spi/spi-xlp.c                              |  40 +-
 drivers/spi/spi-xtensa-xtfpga.c                    |  30 +-
 drivers/spi/spi-zynq-qspi.c                        |  28 +-
 drivers/spi/spi-zynqmp-gqspi.c                     |  50 +-
 drivers/spi/spi.c                                  | 262 +++++++--
 drivers/usb/gadget/udc/max3420_udc.c               |   2 +-
 include/linux/spi/spi-mem.h                        |   2 +
 include/linux/spi/spi.h                            |  65 ++-
 sound/pci/hda/cs35l56_hda_spi.c                    |   2 +-
 59 files changed, 2156 insertions(+), 1722 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/adi,axi-spi-engine.txt
 create mode 100644 Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml

