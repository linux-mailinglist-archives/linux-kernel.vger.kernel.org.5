Return-Path: <linux-kernel+bounces-105103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF08287D922
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193FA1C20DCB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B53DDC9;
	Sat, 16 Mar 2024 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="On5VTf91"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC24DDA0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710573402; cv=none; b=ZoQ24TB9LSnKIt7RfrHUdaTv8x7PGinYpD+0T+Am1IPiOHO2iKr6iUS2ydRxR8a6Zmz/J2rucejdXDXoeeKma+A2TVzYZZfWmS2cNnQoiva+If0j4WekcT0mWwBQJUWczInu0wp1r0sJWt+2LojRZsmoak/PRkx8wLcHv6uAlh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710573402; c=relaxed/simple;
	bh=H7rInrQrrR/VqYGdfL9V1bFcP0SpEDR65vCgBN7ekIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tS7vips8jxAU7r4dc4c8AzSr5I/kvnhDIYMva63nphEiXQXAllbsN8SBjMVAa0wLka/YLu7pBwqtcfTD8P6O47eBtm9bA6ogJjYyKnFiyDTO6zwEFHqa7fD+ldulxoIomK5b6bJfszI9oUWs3Zc1qtWFlZTryQvFk6c4AYimEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=On5VTf91; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710573400; x=1742109400;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H7rInrQrrR/VqYGdfL9V1bFcP0SpEDR65vCgBN7ekIk=;
  b=On5VTf91JqVczGBqUe2op5tcbzz/uTIDRH931jRnyHUxYcn08Cv8h/2k
   6n3h+nO1kIFeREYTh7ULJJiUMUlyZiFnIxWCGwWG1lDqxgUV1yfmtRukM
   OZoRu/CzBjw3PMzgBaXRQQsVysScxbgIJIOXOV2iSDjhw0c6F/dPUhs12
   Tzo+5JJlT4TQ5o+gnF6jUBT1XXHl3H7omuikTxGKjenPL7d28zzM7e1Gn
   UmwnGkVDehzZRxDaEvvcwtwpsUEGWco3qvms8/3e0PhlEut7J/lETTgzN
   EWQ4ptroLCbCXWjbniYZpQkeFDRI1nD7gyazS6dLXhpnsR+YZDOEjSrm9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5582472"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5582472"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 00:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="43961213"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Mar 2024 00:16:38 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlOHT-000FA1-2g;
	Sat, 16 Mar 2024 07:16:35 +0000
Date: Sat, 16 Mar 2024 15:16:01 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: "__udelay" [drivers/comedi/drivers/rti800.ko] has
 no CRC!
Message-ID: <202403161556.fN71B0Ha-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   66a27abac311a30edbbb65fe8c41ff1b13876faa
commit: 98a15816636044f25be4644db2a3e09fad68aaf7 Revert "comedi: add HAS_IOPORT dependencies"
date:   6 months ago
config: sparc-buildonly-randconfig-r006-20211222 (https://download.01.org/0day-ci/archive/20240316/202403161556.fN71B0Ha-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403161556.fN71B0Ha-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403161556.fN71B0Ha-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

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
WARNING: modpost: "__udelay" [kernel/rcu/rcutorture.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/rcu/rcuscale.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/binfmt_misc.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [lib/crypto/libchacha20poly1305.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/test_bitmap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-g12a-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-axg-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-kona-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-brcm-sata.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-brcm-usb-dvr.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-sr-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/cadence/phy-cadence-salvo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/hisilicon/phy-histb-combphy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/lantiq/phy-lantiq-vrx200-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/mediatek/phy-mtk-ufs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/ralink/phy-ralink-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-inno-dsidphy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-typec.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/xilinx/phy-zynqmp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/l4f00242t03.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/video/backlight/ktd253-backlight.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/arcfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/broadsheetfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/qcom/qcom_rpmh.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/reset/reset-imx7.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/omap-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/stm32-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ks-sa-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-loopback-test.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-cadence-quadspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-fsl-qspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-lm70llp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-mt7621.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-pic32.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-pic32-sqi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-sh-hspi.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-sh-hspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-tegra210-quad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-tegra20-slink.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-uniphier.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/imx_keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/matrix_keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/adi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/analog.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/db9.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/gamecon.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/sidewinder.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/cyttsp4_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/misc/adxl34x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/misc/cma3000_d0x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-meson.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-msm6242.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-stm32.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-core/dvb-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/radio-cadet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/tea575x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/power/supply/sc27xx_fuel_gauge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/thermal/rockchip_thermal.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/thermal/ti-soc-thermal/ti-soc-thermal.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bcm6358.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-lt3593.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-aat1290.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-ktd2692.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-rt8515.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/hwspinlock/u8500_hsem.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/nvmem/nvmem-imx-ocotp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/nvmem/nvmem-vf610-ocotp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fsi/fsi-master-hub.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/parport/parport.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/parport/parport.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/comedi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl812.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl816.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl818.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/comedi/drivers/rti800.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/das800.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/mpc624.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/cb_das16_cs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_labpc_common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad7476.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/ad7606.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad7949.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad9467.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/adi-axi-adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/bcm_iproc_adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/hi8435.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/hx711.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/imx8qxp-adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/max1241.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/mt6577_auxadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/rcar-gyroadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads124s08.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/stm32-dac-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/stm32-dac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/frequency/ad9523.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/as3935.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/ping.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/srf04.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/xilinx-spi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-pr-ip-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-freeze-bridge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mux/mux-core.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/core/snd-timer.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [sound/core/seq/snd-seq.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/ac97/snd-ac97-codec.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/hda/snd-hda-codec.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/snd-soc-core.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-adau17x1.ko] has no CRC!
WARNING: modpost: "__ndelay" [sound/soc/codecs/snd-soc-adau1977.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-aw8738.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cpcap.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs35l41-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-dmic.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-jz4740-codec.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-madera.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-max98357a.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/mt6359-accdet.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-peb2466.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tlv320aic23.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tlv320aic3x.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8510.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8711.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8995.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm-hubs.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/amd/acp_audio_dma.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-asrc.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-sai.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-ssi.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-xcvr.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/kirkwood/snd-soc-kirkwood.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/sti/snd-soc-sti.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/xilinx/snd-soc-xlnx-formatter-pcm.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/hda/snd-hda-core.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/hda/ext/snd-hda-ext-core.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

