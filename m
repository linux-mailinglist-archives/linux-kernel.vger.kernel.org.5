Return-Path: <linux-kernel+bounces-122252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD688F443
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798151C29117
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF31C17C8B;
	Thu, 28 Mar 2024 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGDwoOT0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386273C0B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711587591; cv=none; b=Qy7aRv+dRVOUeWajL3J5LSj+WDZo+9ZE7hIdA2s4yl81VJdUlFX5fe02n/5+AYRww9q4FuFzX39GtnRTXOjJN9ubG73WsdNRyxcCHo3xvZ2Y4OtBqwOu3owz6aUf4fw+LsVKD0hYJZrJ4FvW3jRXZ/xKO4XAmGAofAQHVY4xMZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711587591; c=relaxed/simple;
	bh=o3Kc49Q5zcD5AzZ7SqoNIXVPoo9TPk54lyS6vUCs6H0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uH43CakKwjoe66lj7MmBSF2kp8y+SNCeEXCVlYntqiItwju8IYZGmXd8VsasfMgwpLTM3GAkeKLsAAaKcHRj71E3Pvg/wJW6NqbZw19CTSIyvAIiMKy/aNzLoOOiLfj3+UqO8uaxrcT/jtx/c5JnADIjgxC/qJvkqtMMhybZp/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGDwoOT0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711587589; x=1743123589;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o3Kc49Q5zcD5AzZ7SqoNIXVPoo9TPk54lyS6vUCs6H0=;
  b=OGDwoOT0D4w0PJ7fZAd6xAUidoWBEOk230jH57N4B3AN4LJatzsmbQ+C
   1RyqXd79aum5XB7wA1BLUdouwFAV0iX0WRobxO3wyOhBIHH17GNInyYbZ
   dZdGONZiSDQC/8fqk7ax235CU5IRaVnJ9KwdAE+Pvnh5rA3rnDsevxPAC
   3+74uIfxyF22vdva1Ud6wLfVrVLvrC3AdYgbR6rXfDYD+0p2lBTDFwMr7
   kTvV816ujfO2ETIIYNZK8sx1ZTggM4Lm3jLe17lXafyqtlyPyc7WZ2fAQ
   5dnGwlewxYqidEIwPhOb7iQk+wdpvBl+8oRa5/IWQFlhz5fTIQ/LxreM1
   g==;
X-CSE-ConnectionGUID: FndxvmTbR6Sc4eoye8g0Xg==
X-CSE-MsgGUID: A5maLExPRgC5VPj9XtqIHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6551555"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6551555"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16552153"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 17:59:46 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpe7M-0001ei-13;
	Thu, 28 Mar 2024 00:59:44 +0000
Date: Thu, 28 Mar 2024 08:59:00 +0800
From: kernel test robot <lkp@intel.com>
To: Martin Kaiser <martin@kaiser.cx>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: WARNING: modpost: "__udelay" [drivers/char/hw_random/st-rng.ko] has
 no CRC!
Message-ID: <202403280824.ocy0Ch9a-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Martin,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4076fa161217fcd64a578ca04586c4be728cb004
commit: afa9d00ee0fda2387ad598d0b106e96a7ed360ae hwrng: st - support compile-testing
date:   9 months ago
config: sparc-randconfig-r003-20230824 (https://download.01.org/0day-ci/archive/20240328/202403280824.ocy0Ch9a-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403280824.ocy0Ch9a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403280824.ocy0Ch9a-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux.o: section mismatch in reference: leon_pci_init (section: .text) -> pci_assign_unassigned_resources (section: .init.text)
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
WARNING: modpost: "__ashldi3" [fs/ext4/ext4.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/ext4/ext4.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/ext4/ext4.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/jbd2/jbd2.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/isofs/isofs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/jfs/jfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/jfs/jfs.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/jfs/jfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/nilfs2/nilfs2.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/nilfs2/nilfs2.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/nilfs2/nilfs2.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [block/t10-pi.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/test_scanf.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/crc4.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/crc4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/allwinner/phy-sun6i-mipi-dphy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-ns2-usbdrd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/cadence/phy-cadence-salvo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/marvell/phy-pxa-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/mediatek/phy-mtk-ufs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/ralink/phy-ralink-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-inno-dsidphy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-typec.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/st/phy-stm32-usbphyc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/sunplus/phy-sunplus-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pinctrl/bcm/pinctrl-bcm2835.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/gpio/gpio-latch.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/pwm/pwm-renesas-tpu.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-renesas-tpu.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-sifive.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/pcie-altera.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/nvidia/nvidiafb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/via/viafb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/neofb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/vt8623fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/broadsheetfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/sh_mobile_lcdcfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/sunxi-ng/sunxi-ccu.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/sh/usb-dmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/mediatek/mtk-cqdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/qcom/qcom_adm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/xilinx/xilinx_dpdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/dw/dw_dmac_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/idma64.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/tegra20-apb-dma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/ixp4xx/ixp4xx-npe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/reset/reset-berlin.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/reset/reset-imx7.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sunzilog.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sunsab.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/samsung_tty.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/mxs-auart.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/omap-rng.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/char/hw_random/st-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/stm32-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ks-sa-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/lp.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/char/xillybus/xillybus_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/cardreader/rtsx_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/hpilo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/axp20x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/ssbi.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/scsi/scsi_common.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/nvme/host/nvme-core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/nvme/host/nvme-core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/nvme/target/nvmet.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/nvme/target/nvmet.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/nvme/target/nvmet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/message/fusion/mptbase.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/ks0108.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/hd44780.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/lcd2s.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/pmic8xxx-keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/samsung-keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/tegra-kbc.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/input/mouse/psmouse.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-moxart.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-msc313.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-r7301.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-stmp3xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-x1205.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-eg20t.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-mt65xx.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i2c/busses/i2c-mt65xx.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/busses/i2c-synquacer.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-synquacer.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7183.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7842.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/bt819.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/i2c/ccs/ccs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/i2c/ccs/ccs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/cx25840/cx25840.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/et8ek8/et8ek8.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/imx415.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/mt9t112.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/ov6650.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/tc358743.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/tc358746.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/media/i2c/tvp5150.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/max2165.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mt20xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tuner-simple.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tda18271.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/atbm8830.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/m88rs2000.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/mb86a16.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/s5h1420.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stb6000.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv0288.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/dvb-frontends/stv0910.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/dvb-frontends/tda10086.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/zl10353.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/v4l2-core/videodev.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/v4l2-core/videodev.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-core/dvb-core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hwmon/nct6775-core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/hwmon/nct6775-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/sfctemp.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hwmon/pmbus/pmbus_core.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/hwmon/pmbus/pmbus_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/pmbus/max15301.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/pmbus/zl6100.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/thermal/k3_j72xx_bandgap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-pxav3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-s3c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-milbeaut.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/alcor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/mtk-sd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/davinci_mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/renesas_sdhi_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/cb710-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/dw_mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sh_mmcif.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/meson-mx-sdhc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/moxart-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/toshsd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/owl-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/rtsx_pci_sdmmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-esdhc-imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-of-esdhc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-of-dwcmshc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-bcm-kona.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-iproc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-msm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-omap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sunplus-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-xenon-driver.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/core/pwrseq_emmc.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

