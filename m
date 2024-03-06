Return-Path: <linux-kernel+bounces-93329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8E872E11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131F5B25A0D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81301759F;
	Wed,  6 Mar 2024 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmRxlbo9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CB079E4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709700193; cv=none; b=lqnfOQ6Y9SY6qzonUA5y4Yp28Ddb5lh4stYVbkEmkI5waXg8uJa5IB3jFRqyg6+spZxgC5CVL+POShmG9Sf/MKnoXZUFVp+dOreeV0ae2mSfUDmFUC1rwARTTpdlwBBqxLryZG7rNINElmkdlzsqyPQEq6BRuU0IyGc26oJVNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709700193; c=relaxed/simple;
	bh=CiR77+lZ19i68pey4rjfW+qxBsThcbW1hpUDaNeywZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DjTptCDIZcQkD+aqwDscj+/wSv7kHAoT78dBQPhSzXUh0IQg9M5/2mM94JV+S88OAj0+yK6IkHJxIIkSmKZu8Subcr6CJHfno6NaMl3RQVZR3nFPxlNcm+7fs7DMFd8xZuErZmN67nD1khk38DeDGfpH+xqYN4L4T+0Vlq85rSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmRxlbo9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709700191; x=1741236191;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CiR77+lZ19i68pey4rjfW+qxBsThcbW1hpUDaNeywZs=;
  b=cmRxlbo9oDObfGD31yTueAq4YQMDg9I9M/b/6pu3eQJohFXR+rMfQE+U
   4Cn2xhcwx7ZlMmy0TQGoKYD+cj0LA8hQG6n+IM/pPEBb7pk8/xVVGYlsY
   3qzUqCJm/66LvptvvhA829x49Pviyezwf8u7dSe1OIwDEVZ4ycTIoyXWm
   3epbA78InF0bquz6pKxLZqeJ6kDU/Ebn7c8Gax1EQOYRbl8BATRTqpeqc
   Ihl8X/yEle4LpWYRUDytmt/YYTns2t82hQ5J6FY9K0s/ao9R2ws4Y29HD
   GAqV5a1ReVBCStAeYJ0Woc3pQE8Q+NAOSo1A9mPG1dvSGepRGosYK5iCx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4159690"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4159690"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 20:43:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9487774"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2024 20:43:09 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rhj7T-0003v1-0M;
	Wed, 06 Mar 2024 04:43:07 +0000
Date: Wed, 6 Mar 2024 12:42:24 +0800
From: kernel test robot <lkp@intel.com>
To: Tianfei Zhang <tianfei.zhang@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Raghavendra Khadatare <raghavendrax.anand.khadatare@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: WARNING: modpost: "__udelay" [drivers/ptp/ptp_dfl_tod.ko] has no CRC!
Message-ID: <202403061234.iDDn0x5D-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tianfei,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5847c9777c303a792202c609bd761dceb60f4eed
commit: 615927f1a487bd9066425df48d06cec3bb3d8dbb ptp: add ToD device driver for Intel FPGA cards
date:   11 months ago
config: sparc-randconfig-r034-20230513 (https://download.01.org/0day-ci/archive/20240306/202403061234.iDDn0x5D-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240306/202403061234.iDDn0x5D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403061234.iDDn0x5D-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

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
WARNING: modpost: "empty_zero_page" [lib/crypto/libchacha20poly1305.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/cadence/phy-cadence-salvo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/samsung/phy-exynos5-usbdrd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/core/fb_ddc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/aty128fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/radeonfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/savage/savagefb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/neofb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cirrusfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/sm501fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/carminefb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/mb862xx/mb862xxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/ipmi/ipmi_si.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/dw/dw_dmac_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/mt6359-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/twl-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sunsab.ko] has no CRC!
ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!
WARNING: modpost: "__udelay" [drivers/misc/cardreader/rtsx_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/dw-xdata-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/sm501.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/axp20x.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/cafe_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/cafe_nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/gpio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/intel-nand-controller.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/firewire/firewire-ohci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/ks0108.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/hd44780.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/sbus/char/uctrl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/isp116x-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/uhci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ssb-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/net2280.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/mv_udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/bdc/bdc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/dwc3/dwc3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/dwc2/dwc2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/cdns3/cdns-usb-common.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/c67x00/c67x00.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/serial/keyspan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/musb/musb_hdrc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/apbps2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-ds2404.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-msm6242.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-x1205.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-pcf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-pca.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/busses/i2c-pca-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-pca-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-arb-gpio-challenge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca9541.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/dw-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7604.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/bt819.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/imx274.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/imx296.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/mt9v032.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/ov6650.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mxl5007t.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/saa7134/saa7134.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/usb/cx231xx/cx231xx.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/ptp/ptp_dfl_tod.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/masters/sgi_w1.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/hwmon/sht15.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/pmbus/max15301.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/memstick/host/jmb38x_ms.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bcm6358.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-is31fl319x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/rapidio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/switches/idt_gen2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/devices/tsi721_mport.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/gameport/gameport.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ssb/ssb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/adi-axi-adc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/hx711.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/ad5592r-base.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/potentiometer/ad5272.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-freeze-bridge.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/siox/siox-bus-gpio.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [net/ceph/libceph.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

