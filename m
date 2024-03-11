Return-Path: <linux-kernel+bounces-98417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BC38779C9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254A02811E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B86EBE;
	Mon, 11 Mar 2024 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEH7NncQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4A37462
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710123495; cv=none; b=Go+WBGy3kMtL27Cw1B5hnzJVUu3Txz5uIc2K+HOe3BVNO0hJ1fQGvlbHvgd83lVQKNjqiDSty/BYLJlH5MMvyYX3Xm6c2fQbOsMBYp46jgsphDvmGO6ojEjaqMPLBwwyRq3S+IN0UzDmpUJ+jSNmqoEP00M8Ti2JkOgYIlEliVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710123495; c=relaxed/simple;
	bh=uz6FJxCEYQdKqSllQGG03zzz/o+fuscmUkLJxRazXdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s/tps3C8YKb+kHykIIdvj/YFwQrh5JgJ2+0q/VMOwDU8GM26w7yEGyPVc4Bs4Q/Y3MUyhQ18EwQhf4Sw0DKtNrauCL139myti3kejOrk+/8pZ/tpwUXHDs3A97veDh+mhGFoZ7CTArXmt+mBRWzx/bTeZvXbesuJYCYZuY90sho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEH7NncQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710123492; x=1741659492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uz6FJxCEYQdKqSllQGG03zzz/o+fuscmUkLJxRazXdc=;
  b=lEH7NncQTfFRo06hL2KaLblvjyghZb/7U+7f7hdVx1OC2WIj3mr+YoPP
   9NysJyI/EE8Da85jdxlOdS9j3GheEA8Nj1uTUcacBGMvQOXk/NeWFyCg/
   PnaxCDp3Q1lGMrVNqmx8NiHfMnobi6a6efx2cGWHafvVMZfA70xhghQG/
   3odgles5/LezNDH810scD643WyoJnaq++S+hs9bbEatLpK0thzKUYd0Zn
   rtkqbVcE4EchR79nzJPSTzGwN7h+1ThvrxgJzcotHEl/iVOCGy7x3lZOh
   giEjFlm/rjShZ+yQPpiB69OkzN6SnQXm7an0EF9A19Kt3Dp310vsNHT+8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4886776"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="4886776"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 19:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="48476602"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Mar 2024 19:18:09 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjVEs-0008pR-2r;
	Mon, 11 Mar 2024 02:18:06 +0000
Date: Mon, 11 Mar 2024 10:17:55 +0800
From: kernel test robot <lkp@intel.com>
To: Emil Renner Berthing <kernel@esmil.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Samin Guo <samin.guo@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>
Subject: WARNING: modpost: "__udelay" [drivers/hwmon/sfctemp.ko] has no CRC!
Message-ID: <202403111019.VvcVNxlT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Emil,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8f897f4afef0031fe618a8e94127a0934896aba
commit: 7f2958e845d2c8bf1100dc088dbdc31af2a80fd0 hwmon: (sfctemp) Add StarFive JH71x0 temperature sensor
date:   11 months ago
config: sparc-randconfig-r051-20240309 (https://download.01.org/0day-ci/archive/20240311/202403111019.VvcVNxlT-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240311/202403111019.VvcVNxlT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403111019.VvcVNxlT-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "__udelay" [drivers/media/rc/gpio-ir-tx.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/media/rc/gpio-ir-tx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/rc/ir-hix5hd2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/rc/serial_ir.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/thermal/k3_j72xx_bandgap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-s3c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-milbeaut.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/alcor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/mtk-sd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/davinci_mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/renesas_sdhi_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/cb710-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/dw_mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sh_mmcif.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sunxi-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/toshsd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-esdhc-imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-bcm-kona.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-xenon-driver.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/core/pwrseq_emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bcm6358.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-lt3593.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/iio/impedance-analyzer/ad5933.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/rtl8192e/rtl8192e/r8192e_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/rtl8723bs/r8723bs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/rts5208/rts5208.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mailbox/sprd-mailbox.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/memory/tegra/tegra30-emc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/memory/tegra/tegra210-emc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/ad7606.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/bcm_iproc_adc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/hx711.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/imx8qxp-adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/mt6577_auxadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/meson_saradc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/rcar-gyroadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/sun4i-gpadc-iio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads7924.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/ad5592r-base.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/gyro/itg3200.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/pressure/dlhl60d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/ping.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/nvmem/nvmem_meson_mx_efuse.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/nvmem/nvmem-mxs-ocotp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/nvmem/nvmem-rockchip-otp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0001.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/ingenic/ingenic_nand.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/davinci_nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/marvell_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/marvell_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/lpc32xx_slc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/lpc32xx_mlc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/txx9ndfmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/stm32_fmc2_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pcmcia/pcmcia_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/i8042.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/olpc_apsp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/imx_keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/matrix_keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/pmic8xxx-keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/samsung-keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/sh_keysc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/tegra-kbc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/mouse/vsxxxaa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/as5011.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/db9.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/gamecon.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/gf2k.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/grip_mp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/cyttsp4_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/elants_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/ilitek_ts_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/raydium_i2c_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/wdt87xx_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/sx8654.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/tps6507x-ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/zforce_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/zinitix.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/rmi4/rmi_core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/w1/masters/ds2482.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/masters/mxc_w1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/masters/sgi_w1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/wire.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/lm93.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/powr1220.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/hwmon/sfctemp.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/hwmon/sht15.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ssb/ssb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-freeze-bridge.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/drivers/vx/snd-vx-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/au88x0/snd-au8810.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/ctxfi/snd-ctxfi.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/cs46xx/snd-cs46xx.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/lx6464es/snd-lx6464es.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/echoaudio/snd-darla20.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/echoaudio/snd-mona.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/echoaudio/snd-echo3g.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/echoaudio/snd-indigodjx.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/oxygen/snd-oxygen-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/trident/snd-trident.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/vx222/snd-vx222.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-ad1889.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-intel8x0.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-intel8x0m.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-via82xx.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-via82xx-modem.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

