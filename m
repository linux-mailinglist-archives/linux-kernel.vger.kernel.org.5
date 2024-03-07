Return-Path: <linux-kernel+bounces-95353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BBC874CA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4100C1F22EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6808585632;
	Thu,  7 Mar 2024 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzRtYR+a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA35839F6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808418; cv=none; b=tgtWxHUovhHtvgU2JRGcGdur85cxMXuK90rDJnOJEV4Y75VEV6RGD4vtTzAXvdET0FdEkj14RqGXPGwbDbrzjSfj5+PSUsn5DD5tOxnSmRcQMImw+uESFCWlRM0cpYB+o+k+wprPgWjHEfRGtDoRSyOfN/2wH/qQEun2PJUE0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808418; c=relaxed/simple;
	bh=tFjzmVY3UHOXlTHGyj2zTBpg2JOGLKAb/xsC7aF1Apw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aLmxP8eG5sk+lgs2y7sVV+qXjiqYWqI3r8kxxZek+bel0ftREcACqslkOajBmto6TNyDVjpsG4/gIYhFufRZZKTNOS2grWhCYGmDVGvIFiMJU9K3PxsXRxP50+bfMWjYnELyM+H0s9tqrmRTRHqj5TLpz8iqVF3bxXXQBeLP4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzRtYR+a; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709808417; x=1741344417;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tFjzmVY3UHOXlTHGyj2zTBpg2JOGLKAb/xsC7aF1Apw=;
  b=BzRtYR+alk4as0ihrD6XMn3efXISgVtGbclILzwUBD4014uT+/vYFPqP
   vcewtyyLdx/O+r/Hl+AqqTKB8ThTJ+HwMi792J+wAX8qB+IlyHHHAt+IZ
   wNwgMhDiQGba6nHGbw7RfvKrz/sr9bv8YI0uDyy64pT9INFmzd3VX3N3f
   TTGUGuLcItqcNp5sitQuFAzraudHMt0iPF2wv1C7Bscym9Bei0I7MNqtC
   fQZneaUOl8oSV868sWt/AnLRSQjHVfWXLH1OAKURIP9Ji9ZAIThJ9iqnq
   k7ptydbD1LjEmBK8p2+6sqQ4vxZc4aD56a1/C9vDxGGkawoaEZCOY0msG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4327585"
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="4327585"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 02:46:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="9970271"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Mar 2024 02:46:54 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riBH2-00055x-0p;
	Thu, 07 Mar 2024 10:46:52 +0000
Date: Thu, 7 Mar 2024 18:46:34 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Cassel <niklas.cassel@wdc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: WARNING: modpost: "__ashldi3" [drivers/ata/libahci.ko] has no CRC!
Message-ID: <202403071842.ZJDlnRjb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Niklas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   67be068d31d423b857ffd8c34dbcc093f8dfff76
commit: 93c4aa449b88196c7d56a556cb6a2aad21ad8a7a ata: libata: read the shared status for successful NCQ commands once
date:   1 year, 2 months ago
config: sparc-randconfig-r062-20230821 (https://download.01.org/0day-ci/archive/20240307/202403071842.ZJDlnRjb-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240307/202403071842.ZJDlnRjb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403071842.ZJDlnRjb-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0001.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/ams-delta.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/gpio.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/cadence-nand-controller.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtdoops.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/spi-nor/spi-nor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-loopback-test.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-lm70llp.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/firewire/firewire-core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/firewire/firewire-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/sbus/char/uctrl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/i8042.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/rmi4/rmi_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-ds2404.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-msm6242.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-r7301.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-rs5c348.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-ltc4306.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca9541.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca954x.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i3c/i3c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/i3c-master-cdns.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/dw-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/et8ek8/et8ek8.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/imx274.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/mt9t112.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/mt9v032.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/ov6650.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mt20xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tuner-simple.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tda18271.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/v4l2-core/videodev.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/tea575x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/wl128x/fm_drv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ptp/ptp_idt82p33.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/watchdog/mena21_wdt.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-bufio.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-bufio.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-crypt.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [drivers/md/dm-crypt.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-crypt.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-thin-pool.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-thin-pool.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-verity.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-verity.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-integrity.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-integrity.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-writecache.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-writecache.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-milbeaut.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/alcor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/cb710-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/toshsd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/rtsx_pci_sdmmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-omap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/core/pwrseq_emmc.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mmc/core/mmc_block.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ufs/core/ufshcd-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bcm6358.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-rt8515.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/staging/vt6655/vt6655_stage.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/vt6655/vt6655_stage.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/accel/adxl345_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/adc/ad7793.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/adc/ad7793.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/hi8435.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/hx711.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/max11410.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/palmas_gpadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads124s08.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/afe/iio-rescale.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/dac/ad5766.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/iio/dac/dpot-dac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/frequency/ad9523.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/potentiometer/ad5272.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/ping.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/srf04.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/resolver/ad2s1200.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/vdpa/vdpa.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/ata/libata.ko] has no CRC!
>> WARNING: modpost: "__ashldi3" [drivers/ata/libahci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/libahci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spmi/hisi-spmi-controller.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/gameport/gameport.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/ad7418.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hwmon/lochnagar-hwmon.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/hwmon/lochnagar-hwmon.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/lm93.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hwmon/ltc2947-core.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/hwmon/ltc2947-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/powr1220.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/hwmon/sht15.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hwmon/pmbus/pmbus_core.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/hwmon/pmbus/pmbus_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/pmbus/max15301.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/pmbus/zl6100.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bluetooth/btmrvl_sdio.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/bluetooth/virtio_bt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/comedi.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/ntb/hw/idt/ntb_hw_idt.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/ntb/hw/epf/ntb_hw_epf.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/ntb/test/ntb_pingpong.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/ntb/test/ntb_pingpong.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/ntb/test/ntb_tool.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/ntb/test/ntb_tool.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/ntb/ntb_transport.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/ntb/ntb_transport.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-pr-ip-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-freeze-bridge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fsi/fsi-master-aspeed.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/fsi/fsi-master-gpio.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/fsi/fsi-master-gpio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fsi/fsi-master-gpio.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/fsi/fsi-master-gpio.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [net/wireless/cfg80211.ko] has no CRC!
WARNING: modpost: "__ashldi3" [net/mac80211/mac80211.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [net/mac80211/mac80211.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

