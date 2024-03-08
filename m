Return-Path: <linux-kernel+bounces-96519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B64875D75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1D83B227E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3469236134;
	Fri,  8 Mar 2024 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRpMfuCZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5D33080
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 05:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874641; cv=none; b=axLHZDg2L8fQLaElUMHMYI6ZVsmNYVDw1n1awIDKTqaBc00JMU/PPh7obOBonyZPddCPmOYtRdmScnza67g50DlW+FZflWLXeJ5+CLeHPaZZ08wmnW/06Sh5w9t2/5vSJEtDQvbQTpzE9ZvlE8UhYoHHs6LKocXYJs2yXGFNzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874641; c=relaxed/simple;
	bh=Zi42QkZZ1QD73TMU0UQ2EChgulnhu+XHM+SlPNhM0Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tBWd7amqEUVcjfF+crVkFjcKabjRjN3VcZ2JXVUHTbr0ksy6b5PHLqmNvNEVzVwF49EXm32Q1w4FkVutXnfUmOcTNTbxvZu7cHin68JtnYAjyeHKhNHjvWEbVKpHS/NsvcfJkmwbfICUDcI/E/RCpV9H9EL4YmBgsuKMpT/spss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRpMfuCZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709874639; x=1741410639;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zi42QkZZ1QD73TMU0UQ2EChgulnhu+XHM+SlPNhM0Cs=;
  b=GRpMfuCZsPzj0CjJof+a3fhHorNZkD2d5g1RWY33wAKijhUDEvX62AGO
   C155WyCG72+VLlQHRfrgaEAy5Y+LBP3qU0WovHdkgBxo0nkLn+ZGO4Hx7
   Z8fwyn5pZDEq2Pu4Wv/lo91eoX8MR+4KorzeOm3rO5TDAhOslb+6jXQLP
   Zli8G0ns6ihP+1G+A3uauNqnH+OExopArC5VewmUoVR43agJtSD1rdolz
   Od2T0ZRCr7PaksBJ45/IeQAV4yqXZPXrCKuO5PS4ZARMwtXS5CvDcKAnk
   NxVFB5R5RPjGTHQ4WQLLSp0TW9cT0mCU3zCo9nQRDT5Jm2O70h0z+BdDY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="27055985"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="27055985"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 21:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="33506122"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Mar 2024 21:10:36 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riSV8-00062x-0M;
	Fri, 08 Mar 2024 05:10:34 +0000
Date: Fri, 8 Mar 2024 13:09:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: ERROR: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko]
 undefined!
Message-ID: <202403081354.dMqO8W7Y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Maciej,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3aaa8ce7a3350d95b241046ae2401103a4384ba2
commit: f01dda1cb85e14a1d51c3cedad0feaaf71a93b4b parport_pc: Let chipset drivers mask unsupported modes
date:   1 year, 2 months ago
config: sparc-randconfig-r062-20230821 (https://download.01.org/0day-ci/archive/20240308/202403081354.dMqO8W7Y-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240308/202403081354.dMqO8W7Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403081354.dMqO8W7Y-lkp@intel.com/

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

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
WARNING: modpost: "__ashldi3" [fs/ext4/ext4.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/ext4/ext4.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/ext4/ext4.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/jbd2/jbd2.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/ntfs3/ntfs3.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/ntfs3/ntfs3.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/ntfs3/ntfs3.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [block/t10-pi.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/test_bpf.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/test_bpf.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/842/842_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/842/842_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/842/842_decompress.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/842/842_decompress.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/xz/xz_dec.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/xz/xz_dec.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/bus/mhi/host/mhi_pci_generic.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-kona-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/cadence/phy-cadence-salvo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/ili9320.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/lms283gf05.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/video/backlight/ktd253-backlight.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/aty128fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/savage/savagefb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/gxt4500.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/sm501fb.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/tty/serial/sccnxp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sc16is7xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/rp2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/char/xillybus/xillybus_core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iommu/iova.ko] has no CRC!
>> ERROR: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!
>> ERROR: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!
>> ERROR: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!
>> ERROR: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!
>> WARNING: modpost: "__udelay" [drivers/parport/parport_pc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/ti-st/st_drv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/sm501.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mfd/sm501.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/atmel-hlcdc.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/scsi/sd_mod.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/scsi/sd_mod.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/nvme/host/nvme-core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/nvme/host/nvme-core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/nvme/host/nvme.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/nvme/target/nvmet.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/nvme/target/nvmet.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/nvme/target/nvmet.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0020.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/chips/cfi_cmdset_0020.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0001.ko] has no CRC!
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

