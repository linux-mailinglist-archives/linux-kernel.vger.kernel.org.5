Return-Path: <linux-kernel+bounces-98179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8C6877616
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B901A1C20B17
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09891EB42;
	Sun, 10 Mar 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkLMYpkC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2C17556
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710066490; cv=none; b=MwwBMHHHnNwNVvB7NiBSO4hu+Dr8tnF2EE0daFY+QyVi4KF7WL27QUha6iTnLhLaUxm64LbQpd35KBB5+WAvun5S/cIsxiVWghcBA2ouqre03cMrnGzvuhU1LN61/sQGq+1EmtdyJHJYHqGxrycLg5zlU83HNkQRMPMTsIi2Lus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710066490; c=relaxed/simple;
	bh=En1dDgapHcyG8CdeW/8OOPp4eLifSjvYAnhRkvNfHsc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KDluY4QQCTGe3gVJuxd4Mv2IHo4FC+GngneCom9Iuz6fpcD3Bywyb6I2erk8ARv8ak3a8jm/ZwH+HZjENOWiUgf9ny5TwqwrhOEJBOfoA9rgfNhh3BhalqZrQAu0MRjK/2Ma0TsOu5nun0Sl7nQf6JYWIem7T/XK2hPV1TC0ss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkLMYpkC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710066488; x=1741602488;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=En1dDgapHcyG8CdeW/8OOPp4eLifSjvYAnhRkvNfHsc=;
  b=NkLMYpkC74V/V0dbO73IVSPWJGnHvQV6abZOKIVfN8qRW1rQEsHc45Zh
   K7f+mIB7JzO/IMi1YSm1VHphII5p5jm8n/fpbwAgj4EgDSjZrhPqIvAhE
   Bvv39wVNjjtLHNZw7vnoTW+Gz3JP2rSm9gLYTGMXeLVybRlQGPH5JXsR+
   0c8ypCMwR8sbIB/oc4NJ7D+AzhlGs5XRXoc2xBH3JwjSSb8hxVzACidkb
   2po5lWYI46YvMQlO3GHgNdk9G1E3vCFQKvQ38aXx+FcTmSPLodM2phP7k
   DXQx+F6n7a8608ZBYGHj7jxpUyUGhTeohRomuryTd2ZzwJbFmlyMURSUP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4663912"
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="4663912"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 03:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="10898692"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Mar 2024 03:28:05 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjGPT-0008At-0S;
	Sun, 10 Mar 2024 10:28:03 +0000
Date: Sun, 10 Mar 2024 18:27:40 +0800
From: kernel test robot <lkp@intel.com>
To: Axe Yang <axe.yang@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: WARNING: modpost: "__ashldi3" [drivers/mmc/host/mtk-sd.ko] has no
 CRC!
Message-ID: <202403101838.sjT2TQnS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   005f6f34bd47eaa61d939a2727fc648e687b84c1
commit: d3ddafd34bc4e353dc9fc2d193abc4c4463dc588 mmc: mtk-sd: Extend number of tuning steps
date:   3 months ago
config: sparc-buildonly-randconfig-r001-20230109 (https://download.01.org/0day-ci/archive/20240310/202403101838.sjT2TQnS-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240310/202403101838.sjT2TQnS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403101838.sjT2TQnS-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "__udelay" [kernel/time/test_udelay.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/scftorture.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/test_scanf.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/test_bitmap.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/842/842_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/842/842_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/842/842_decompress.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/842/842_decompress.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-kona-usb2.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/phy/cadence/phy-cadence-torrent.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/cadence/phy-cadence-salvo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/gpio/gpio-pisosr.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/ili9320.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/l4f00242t03.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/vgg2432a4.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/video/backlight/ktd253-backlight.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/xilinx/xilinx_dpdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/idma64.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/virtio/virtio.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/virtio/virtio.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/virtio/virtio_ring.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/virtio/virtio_balloon.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/mt6359-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/omap-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/mxc-rnga.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ingenic-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/xgene-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/stm32-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ks-sa-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/c2port/core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/altera-stapl/altera-stapl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-loopback-test.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-cadence.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/spi/spi-dw.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/spi/spi-zynqmp-gqspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/lcd2s.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/gadget/udc/r8a66597-udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/r8a66597-udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/mv_u3d_core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/usb/gadget/function/u_audio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/typec/tipd/tps6598x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/dwc2/dwc2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/oxu210hp-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/isp116x-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-hcd.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/host/r8a66597-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/r8a66597-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/misc/onboard_usb_hub.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-r7301.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-rs5c348.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-x1205.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-bit.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-pca.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-ocores.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/busses/i2c-pca-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-pca-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-rk3x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-arb-gpio-challenge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-ltc4306.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/i2c-core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/i2c-core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i3c/i3c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/dw-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adp1653.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7183.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/bt819.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/i2c/ccs/ccs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/i2c/ccs/ccs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/cx25840/cx25840.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/et8ek8/et8ek8.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/imx274.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/ks0127.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/mt9t112.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/mt9v032.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/ov6650.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/tc358743.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/media/i2c/tvp5150.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/vpx3220.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/max2165.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mt20xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mxl5007t.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tuner-simple.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tda18271.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/rc/rc-core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/rc/rc-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/platform/cadence/cdns-csi2tx.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/v4l2-core/videodev.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/v4l2-core/videodev.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/si4713/si4713.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/tea575x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/dsbr100.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/radio-keene.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/w1/masters/ds2482.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/mtk-sd.ko] has no CRC!
>> WARNING: modpost: "__ashldi3" [drivers/mmc/host/mtk-sd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/core/pwrseq_emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-is31fl319x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-ktd2692.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-rt8515.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/hid/hid-creative-sb0540.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hid/hid-creative-sb0540.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-ps-spi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-pr-ip-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fsi/fsi-master-hub.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0020.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/chips/cfi_cmdset_0020.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0001.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0001.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/qinfo_probe.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/devices/phram.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtd.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtdoops.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/spi-nor/spi-nor.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/ubi/ubi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pcmcia/pcmcia_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/apbps2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/gameport/gameport.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/mouse/vsxxxaa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/ads7846.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/cyttsp4_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/elants_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/ilitek_ts_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/mms114.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/wdt87xx_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/zforce_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/zinitix.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/comedi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl812.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl816.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/pcl818.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/mpc624.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_atmio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_labpc_common.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/accel/adxl345_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/adc/ad4130.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/adc/ad7192.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad7476.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/ad7606.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/adc/ad7793.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/adc/ad7793.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad7949.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/cc10001_adc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/cc10001_adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/hi8435.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/max11410.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/adc/ti-ads1015.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads8344.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/afe/iio-rescale.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/common/ms_sensors/ms_sensors_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/ad5592r-base.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/dac/ad5766.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/iio/dac/dpot-dac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/gyro/itg3200.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/frequency/ad9523.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/pressure/dlhl60d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/as3935.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/ping.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/srf04.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/resolver/ad2s1200.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/iio/industrialio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mux/mux-core.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/core/snd-timer.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [sound/core/seq/snd-seq.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [sound/core/seq/snd-seq-virmidi.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/drivers/mpu401/snd-mpu401-uart.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/sparc/snd-sun-cs4231.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/sparc/snd-sun-dbri.ko] has no CRC!
WARNING: modpost: "__ashldi3" [sound/virtio/virtio_snd.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [sound/virtio/virtio_snd.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

