Return-Path: <linux-kernel+bounces-103413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A9C87BF17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE354B23D88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3D570CC5;
	Thu, 14 Mar 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAer+px7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60670CBC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427116; cv=none; b=ZmGXt6x67CtEx7xmuzgXjvRojMRIQKHUmniYTOq8GYyP20RhrZdwJe8OKW0qsHg8SdGHZoMhpKvpakjnClfT0qTnX+7LiyCXxdkcFDO93iqW5kpBLoIDmyvUQ3/vmhuTDXdftR2Tptalerj/PRBXxQChQYK1JFpf40/4Hda1GZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427116; c=relaxed/simple;
	bh=qD/pk0P8PwbR8DVrVq4RSRORIxSAp9+ypAHr2O6dVpc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Oh+7NusqydeX8dkxQ4xa1dhgauogEAAyuhkQ5rrWz7W36lyP18j/+nHO3VYMalrpwmah7L/SjYINEhTh2bWulxyHHaeP7ZD2jqXC3BozGJ7bbJJ7cwosKDZXQaqk6N4vKVXMr9L0V9iXI32cCYxi6Rmle9aocTX9rAIwTat1kRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAer+px7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710427114; x=1741963114;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qD/pk0P8PwbR8DVrVq4RSRORIxSAp9+ypAHr2O6dVpc=;
  b=ZAer+px7L3V1lMLOvx4E1TpvMlZdvez4xFqtyBryOv5SAxEuaDVY8Y7V
   XiMoolaADN7TZZc9HFuXYfY0S8klhPr+RDgcWjE6CJ3Hg2aTHfED9h5Q5
   1bRQ+4+Z8Gnc78Vm1XbDCY0349gCznHBJNRKqizUnRi87PUkwxtLDy+pD
   W8nyr+dx8ml2dwgDQyx84zvo7pOqGNFB8dTVDQI6ghuylSWKDRfqG8meO
   VF5FelefMwb7Pz6N2fZd7FCbwgcqARF241p0l8XuwFbWiEL6pbE7+HsxL
   SRaVlC6XxadRYxTPj8qRS4wi0kLq3dh4EuZ1xGLszg/6yyNCnlZ8mM2dr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5099099"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5099099"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 07:38:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="12376383"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Mar 2024 07:38:32 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkmE1-000DVR-1Y;
	Thu, 14 Mar 2024 14:38:29 +0000
Date: Thu, 14 Mar 2024 22:38:15 +0800
From: kernel test robot <lkp@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: WARNING: modpost: "__udelay"
 [drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.ko] has no CRC!
Message-ID: <202403142249.HPj5VUoc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ulf,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   480e035fc4c714fb5536e64ab9db04fedc89e910
commit: e2ad626f8f409899baf1bf192d0533a851128b19 pmdomain: Rename the genpd subsystem to pmdomain
date:   6 months ago
config: sparc-randconfig-r005-20230515 (https://download.01.org/0day-ci/archive/20240314/202403142249.HPj5VUoc-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240314/202403142249.HPj5VUoc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403142249.HPj5VUoc-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-waltop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_simpleondemand.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/adc/xilinx-ams.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem-apple-efuses.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_brcm_nvram.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_u-boot-env.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mm-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/interconnect/imx/imx8mn-interconnect.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/parsers/brcm_u-boot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_cmdset_0020.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/spmi-pmic-arb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/pcmcia_rsrc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/yenta_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pcmcia/i82092.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/counter/ftm-quaddec.o
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
WARNING: modpost: "__udelay" [kernel/rcu/rcutorture.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/rcu/rcuscale.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "__ndelay" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/scftorture.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/reiserfs/reiserfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/reiserfs/reiserfs.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/reiserfs/reiserfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/ext2/ext2.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/ext2/ext2.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/ext2/ext2.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/fat/fat.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/fat/fat.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/fat/fat.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "__ashldi3" [crypto/ecc.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [crypto/ecc.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [block/t10-pi.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-g12a-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-brcm-sata.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-brcm-usb-dvr.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-sr-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/hisilicon/phy-hi3670-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/hisilicon/phy-hisi-inno-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-keembay-emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-keembay-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-lgm-emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/marvell/phy-pxa-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-inno-dsidphy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/samsung/phy-exynos-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/gpio/gpio-aggregator.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/gpio/gpio-latch.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pwm/pwm-pca9685.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/pcie-altera.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pci/controller/pcie-brcmstb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/pcie-brcmstb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/core/fb_ddc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/arcfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cyber2000fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/i740fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/riva/rivafb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/nvidia/nvidiafb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/radeonfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/savage/savagefb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/vt8623fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/sstfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cirrusfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/qcom/qcom_ice.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/ti-abb-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sunzilog.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sunsab.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sh-sci.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/tty/serial/sccnxp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sc16is7xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/c2port/core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/altera-stapl/altera-stapl.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/scsi/scsi_common.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/scsi/sd_mod.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/scsi/sd_mod.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/nvme/host/nvme-core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/nvme/host/nvme-core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/nvme/host/nvme.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/nvme/target/nvmet.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/nvme/target/nvmet.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/nvme/target/nvmet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-loopback-test.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-bcm-qspi.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/spi/spi-bcm-qspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-davinci.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/spi/spi-mtk-snfi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-orion.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-pic32.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-pxa2xx-platform.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-pxa2xx-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-sh.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-st-ssc4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-tegra114.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-tegra20-slink.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-uniphier.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/spi/spi-zynq-qspi.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/spi/spi-zynqmp-gqspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/sbus/char/uctrl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/phy/phy-am335x-control.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/phy/phy-tegra-usb.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/usb/host/xhci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-pci-renesas.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-mtk-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/dwc3/dwc3.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/dwc3/dwc3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/isp1760/isp1760.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/isp1760/isp1760.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/c67x00/c67x00.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/olpc_apsp.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/input/mouse/psmouse.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/as5011.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/analog.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/input/joystick/gf2k.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/input/joystick/gf2k.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/gf2k.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/edt-ft5x06.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/elants_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/ili210x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/mms114.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/input/touchscreen/pixcir_i2c_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/raydium_i2c_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/stmpe-ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/wdt87xx_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/sx8654.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/zforce_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/rohm_bu21023.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/zinitix.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-ds2404.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-omap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-r7301.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-rs5c348.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-bit.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-amd8111.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-altera.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-bcm-iproc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-davinci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-digicolor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-eg20t.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-jz4780.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-mt65xx.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i2c/busses/i2c-mt65xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-ocores.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-pnx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-pxa.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/busses/i2c-s3c2410.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-s3c2410.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-stm32f4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-stm32f7-drv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-arb-gpio-challenge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-ltc4306.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca9541.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca954x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/i2c-core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/i2c-core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i3c/i3c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/i3c-master-cdns.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/dw-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/w1/masters/ds2482.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

