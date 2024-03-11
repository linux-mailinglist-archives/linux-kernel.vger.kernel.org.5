Return-Path: <linux-kernel+bounces-98837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BC087801B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B30F1C213E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72A38F87;
	Mon, 11 Mar 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOcWG3j5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF43D3A5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160968; cv=none; b=pBG3be8lEHlEku5l4mPoJP2IcFuGUtfaQ1KWhwFHJqVCuTb/wfiopaiiu3EhvTOe2D4NZj2ZONPiCr9wlvIOTtSJS6Gvqsd4w59jyqXZEK41qwHWmQRlyDXGqOQt1vc/Ph6ZnKnksS9vJYmsTNX+YVU6437nQWY37iXJd7DFds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160968; c=relaxed/simple;
	bh=5OQ4qcBYbzM6kJkSC6Jqy45eBv3GfYBV9Hlt+BNIVGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UCZbD6mRqHXVSdktUSREVSTmX62Wv1qGHp2DLwjiD6HTiXv/Q5Ueaxk1K+LDQ71nIv4y97JQerxTrqo/4s0xCwjNeEgnI60m3Bvx45oZUCFIQS93G52jVbrxETQJthGNP+y4MQF5EZSAgdxQotxoWX/PCV4lZ3BVLygO6RiqfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOcWG3j5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710160965; x=1741696965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5OQ4qcBYbzM6kJkSC6Jqy45eBv3GfYBV9Hlt+BNIVGM=;
  b=IOcWG3j5X3KL7AsjDehc5MdjOB2Ji43T3Jkfw5eQaEToDLxuv/N/UDPK
   zzcYzKkRYNB3aSB/uOusMckgKf5k71VMaYXD8Nd58g9+gZExyIeaTkHXK
   S2e758cM8KFZOFv1+O++qLvNrhXbqY56D+zUYa7DUK8L9q9cmwAxGcjKx
   1s+L59mi0qPkwwz84RG0ynHBSpEBHCg+5ufajcmJXkQnSxG0x5fa8ahn3
   1VGCczGOL/oGyi/k1wxEFABIsVxIWJRAaVY5YSY0a/GfBzgrEk0AlS9FU
   cPYhUBAm1S/kXZiSgrnLoXGk8/p6X9SoRIYwohy/wkUqxnEWtkNOXHO7o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4696532"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4696532"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11226413"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Mar 2024 05:42:43 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjezI-00097T-3A;
	Mon, 11 Mar 2024 12:42:40 +0000
Date: Mon, 11 Mar 2024 20:41:45 +0800
From: kernel test robot <lkp@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: WARNING: modpost: "__ashldi3" [drivers/usb/host/xhci-hcd.ko] has no
 CRC!
Message-ID: <202403112033.yTAiFr6w-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8f897f4afef0031fe618a8e94127a0934896aba
commit: 7be6a87c2473957090995b7eb541e31d57a2c801 sparc: allow PM configs for sparc32 COMPILE_TEST
date:   1 year, 1 month ago
config: sparc-randconfig-r005-20230515 (https://download.01.org/0day-ci/archive/20240311/202403112033.yTAiFr6w-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240311/202403112033.yTAiFr6w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403112033.yTAiFr6w-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

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
WARNING: modpost: "__udelay" [drivers/soc/amlogic/meson-gx-pwrc-vpu.ko] has no CRC!
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
>> WARNING: modpost: "__ashldi3" [drivers/usb/host/xhci-hcd.ko] has no CRC!
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
WARNING: modpost: "__udelay" [drivers/w1/masters/mxc_w1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/power/reset/atc260x-poweroff.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/power/reset/piix4-poweroff.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/power/supply/sc27xx_fuel_gauge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/ad7418.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/lm93.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hwmon/ltc2947-core.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/hwmon/ltc2947-core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hwmon/nct6775-core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/hwmon/nct6775-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/powr1220.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/hwmon/sht15.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/thermal/ti-soc-thermal/ti-soc-thermal.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/raid0.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/raid456.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/bcache/bcache.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/md/bcache/bcache.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/bcache/bcache.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/accessibility/speakup/speakup_acntsa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/accessibility/speakup/speakup.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mmc/core/mmc_block.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-s3c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/davinci_mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/uniphier-sd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/moxart-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/owl-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/rtsx_usb_sdmmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-bcm-kona.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-iproc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-msm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sunplus-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-xenon-driver.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ufs/core/ufshcd-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bcm6358.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

