Return-Path: <linux-kernel+bounces-93158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4152872BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5AB1F2D43B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF893179B2;
	Wed,  6 Mar 2024 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuNuzncz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE8817;
	Wed,  6 Mar 2024 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683930; cv=none; b=i1WyUOjaGefk2Xos7k7r8mJaAIpU4lmpAwa/TKQbqtTXLYsND8485QFNNSi+ey3TZrR6UG6aTihI+6UVEJJ3kLnf9IVrtGTT/qnlPPTsitDMQ9wRL6e1Ie8ErN1S2CT/6glCd0H2cuCf8JGwmpHvLVHxxQJHCb1NNLeYASDL3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683930; c=relaxed/simple;
	bh=VjqFb+792DmN0ilxw7UhrsTId54QKmptBSdzy0wdoxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DjQNEwAVct5ynwzcqHpOwq+tKIod+jiPzDxpKm0w8moZhOcWRUqDBBMboG3iLXEOVOWiyMN0rY2gyGfhbzE97GXWC2Fs6OAHHcUNOMGh0WRX9Dn/FBgifYwrtHBT33GS37CctzvB0y+gHSOPguia9v197wXC9x7/ozTAM3BHpSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuNuzncz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709683927; x=1741219927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VjqFb+792DmN0ilxw7UhrsTId54QKmptBSdzy0wdoxI=;
  b=WuNuznczLAmbFQrv3q0+1A6WsSzgxlh7EQbrpzH2GI+co/621fzWqHrZ
   YvywNu14h3B1h+f02kAQRgtrgmOIB0Sxo2LSs/3fnyteVKPsx7+tweowl
   qkDEvccoYv4jOOCzhyf0yBA/YFFbSkKHYnrTmuUXnTVNN+uod+AIlOBZe
   amYwAR/WJbpdb1ugm6EI3zYWjf6RDkC4cMjVjfC04DNkVRf3qYIICBiyi
   1qdlqs8ebMapoV87wwn14buWIXW/BCERticVsrx3so9ENmswTyZezlv0C
   1VPY2KWEaFk8gnV+f9UMdmvOjDD1agIEz9Pcl+6N+Ph8Dvf0eQ7p/bUMD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14921675"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="14921675"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 16:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9519955"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2024 16:12:05 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rhet7-0003ln-2S;
	Wed, 06 Mar 2024 00:12:01 +0000
Date: Wed, 6 Mar 2024 08:11:05 +0800
From: kernel test robot <lkp@intel.com>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Subject: WARNING: modpost: "__udelay"
 [drivers/media/pci/saa7146/hexium_orion.ko] has no CRC!
Message-ID: <202403060852.Vgg0tWp7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Hans,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   29cd507cbec282e13dcf8f38072a100af96b2bb7
commit: 39d08ab979b7995d22dd6b3ce74d3179f02847a1 media: Revert "media: saa7146: deprecate hexium_gemini/orion, mxb and ttpci"
date:   1 year, 1 month ago
config: sparc-randconfig-s033-20230621 (https://download.01.org/0day-ci/archive/20240306/202403060852.Vgg0tWp7-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240306/202403060852.Vgg0tWp7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403060852.Vgg0tWp7-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux.o: section mismatch in reference: leon_pci_init (section: .text) -> pci_assign_unassigned_resources (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: grpci2_of_driver (section: .data) -> grpci2_of_match (section: .init.rodata)
WARNING: modpost: vmlinux.o: section mismatch in reference: grpci1_of_driver (section: .data) -> grpci1_of_match (section: .init.rodata)
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
WARNING: modpost: "__udelay" [kernel/locking/locktorture.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__udelay" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/f2fs/f2fs.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [lib/crypto/libchacha20poly1305.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/gpio/gpio-latch.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/rio-scan.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/video/backlight/ktd253-backlight.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/ipmi/ipmi_si.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/clk-palmas.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sunzilog.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sc16is7xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/jsm/jsm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/omap-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/stm32-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ks-sa-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/block/mtip32xx/mtip32xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/hpilo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/c2port/core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/axp20x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/megaraid/megaraid_mbox.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/aic7xxx/aic7xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/aic94xx/aic94xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/esp_scsi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/sun_esp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/a100u2w.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/ipr.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/stex.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/mvumi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/esas2r/esas2r.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/scsi/sd_mod.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/cyttsp4_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/elants_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/mms114.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/raydium_i2c_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/wdt87xx_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/sx8654.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/misc/adxl34x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/misc/drv260x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-ds2404.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-x1205.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-rk3x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/i3c-master-cdns.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7183.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7604.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/bt819.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/cx25840/cx25840.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/ks0127.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/tc358743.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/vpx3220.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/max2165.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mt20xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tuner-simple.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tda18271.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/common/saa7146/saa7146.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/media/pci/saa7146/hexium_orion.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/cx25821/cx25821.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/dt3155/dt3155.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/ivtv/ivtv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/v4l2-core/tuner.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/si4713/si4713.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/tea575x.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/w1/masters/ds2482.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/masters/sgi_w1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/lm93.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/hwmon/sht15.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/pcwd_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/da9062_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/gpio_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/rave-sp-wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-milbeaut.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/cb710-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/toshsd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-of-dwcmshc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-omap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-lt3593.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/rts5208/rts5208.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/adi-axi-adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/pressure/dlhl60d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/ping.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/libata.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/ata/libata.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/libahci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/sata_sx4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pcmcia/pcmcia_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-pr-ip-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mux/mux-core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/siox/siox-bus-gpio.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

