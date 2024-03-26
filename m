Return-Path: <linux-kernel+bounces-118240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D85488B69E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213FE1F3FEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBDA1CA9E;
	Tue, 26 Mar 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPrZaLOx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C01CA81
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415622; cv=none; b=DAB0rElgO1tUZkH5mSSsDSMBDSQpTDfAroQFVcQ1gGtKDe/hT4PggEaBlyhWOxR0qmhCkqzVnkMk/ENbtX3ekDERnmTVrle+MLEmCZfMN+RczYpptxQCEMJh4NSOdAcIxdZxv+2mGvwQ/0wJ77DYodFvzVLDH6v9wyEPsVytV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415622; c=relaxed/simple;
	bh=VsWug0Bhzr6SFa8nAgBUyH/fv0OSUEDTzgTlGSuv188=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WtJv/l3ooNYRvhhDnfd7BO4Pekd+fffNRGeOnV4bF7d3ue48J9VSPISOY2upUYkdl4D9t3WSlHNdYgDdRLrac+PKrHPEjg5m31ispJumT+P6d/uQWBrXia0qGw44WqR0G8p5Ht/rwyhZvS2AgPc20+yHKYhvlQg05BfnmRwd61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPrZaLOx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711415620; x=1742951620;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VsWug0Bhzr6SFa8nAgBUyH/fv0OSUEDTzgTlGSuv188=;
  b=lPrZaLOxBYnziVQSNTzyQec3c9OSkaqiUGQN7JpRjtiStAC+YuKIthB6
   mNDQjD2+HJlH6dD+12Y9yjUlNdIcxP7ku0w+cE+PD/xcxs/vu1Suo0U6b
   KIfSulXH53qt8Fm07UKfFBBFlKLBTSHeaws0HElH1LmfmV7WhiZGG6ho0
   M7wcn7xo7yRgW0y72toT/A2kzdiQq4Wq3YxaAVZ/BtvxalrAJk5J5g9aC
   4rm0K/GVXZm9n0qaq2WWJM9UdopQDUMoFfPVGYZ0G+tey/T8BThiddzSK
   pond/cLtdRiJUhXJk0bZ98GYSARcjWgHtm7UnLiJknP13mc4B6+uRsfAC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10242876"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="10242876"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:13:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15764541"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Mar 2024 18:13:37 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rovNf-000Myc-16;
	Tue, 26 Mar 2024 01:13:35 +0000
Date: Tue, 26 Mar 2024 09:12:46 +0800
From: kernel test robot <lkp@intel.com>
To: Stanley Chang <stanley_chang@realtek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: "__udelay" [drivers/phy/realtek/phy-rtk-usb2.ko]
 has no CRC!
Message-ID: <202403260940.uCSeFZ0R-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stanley,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   928a87efa42302a23bb9554be081a28058495f22
commit: eeda494542e55b603c7b80e14bfc5ee4ab7f9814 phy: realtek: usb: add new driver for the Realtek RTD SoC USB 2.0 PHY
date:   8 weeks ago
config: sparc-randconfig-r133-20231119 (https://download.01.org/0day-ci/archive/20240326/202403260940.uCSeFZ0R-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240326/202403260940.uCSeFZ0R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403260940.uCSeFZ0R-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-maltron.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-mf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-microsoft.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ntrig.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ortek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-pl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-petalynx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-primax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-redragon.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-retrode.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-saitek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sony.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-speedlink.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-steelseries.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sunplus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-tmff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-tivo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-twinhan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-uclogic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-viewsonic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-waltop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-light.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-log.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-loopback.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-raw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-gbphy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-spilib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem-apple-efuses.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_u-boot-env.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rpmsg/rpmsg_char.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/counter/ftm-quaddec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ieee802154/ieee802154_socket.o
ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!
WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.
Is "empty_zero_page" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.
Is "__udelay" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.
Is "__ndelay" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__ashldi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__ashrdi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.
Is "bzero_1page" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.
Is "__copy_1page" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__divdi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.
Is "___rw_read_enter" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.
Is "___rw_read_exit" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.
Is "___rw_read_try" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.
Is "___rw_write_enter" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__lshrdi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.
Is "__muldi3" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "__udelay" [kernel/time/test_udelay.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [fs/cramfs/cramfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__udelay" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/gfs2/gfs2.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/bcachefs/bcachefs.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [fs/bcachefs/bcachefs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/bcachefs/bcachefs.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [lib/crypto/libchacha20poly1305.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-g12a-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-axg-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-brcm-sata.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-brcm-usb-dvr.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/freescale/phy-fsl-imx8mq-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/hisilicon/phy-hi3670-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/hisilicon/phy-histb-combphy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/hisilicon/phy-hisi-inno-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-keembay-emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-keembay-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/lantiq/phy-lantiq-vrx200-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/marvell/phy-mmp3-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/marvell/phy-armada38x-comphy.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/phy/realtek/phy-rtk-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/renesas/r8a779f0-ether-serdes.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/samsung/phy-exynos5-usbdrd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/gpio/gpio-pisosr.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/switches/idt_gen3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/rio-scan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/ili9320.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/l4f00242t03.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/lms283gf05.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/vgg2432a4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/core/fb_ddc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/arcfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cyber2000fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/i740fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/aty128fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/savage/savagefb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/neofb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/vt8623fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cirrusfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/broadsheetfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/sm501fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/carminefb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/mb862xx/mb862xxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/ssd1307fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/sh/usb-dmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/mediatek/mtk-cqdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/altera-msgdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/dw/dw_dmac_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/hsu/hsu_dma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/tegra210-adma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/uniphier-xdmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/ixp4xx/ixp4xx-npe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/mediatek/mtk-mutex.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/qcom/qcom_rpmh.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/mt6359-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/rk808-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/reset/reset-imx7.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_omap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sunzilog.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/msm_serial.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/mxs-auart.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/samsung_tty.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/tty/serial/sccnxp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/intel-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/geode-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/omap-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/mxc-rnga.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ingenic-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/stm32-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/meson-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ks-sa-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/parport/parport_pc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/misc/eeprom/eeprom_93cx6.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/ti-st/st_drv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/cardreader/rtsx_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/altera-stapl/altera-stapl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/ene-kb3930.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/axp20x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/ssbi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/acer-ec-a500.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/scsi/sd_mod.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0001.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/qinfo_probe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/ingenic/ingenic_nand.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/cafe_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/cafe_nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/fsmc_nand.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/gpio.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/marvell_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/marvell_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/lpc32xx_slc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/sh_flctl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/stm32_fmc2_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-loopback-test.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-armada-3700.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-bcm-qspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-cadence.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-davinci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-fsl-qspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-lm70llp.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-pic32.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-rzv2m-csi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-sh.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

