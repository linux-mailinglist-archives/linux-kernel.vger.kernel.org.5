Return-Path: <linux-kernel+bounces-89950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA45286F7FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AE41F21249
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40738137E;
	Mon,  4 Mar 2024 00:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmlbQ+Ik"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AE1385
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 00:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709512961; cv=none; b=C5wVZ7bXQgbS8FhXjMrUosNakaiqABeMKlyFemdwt0ecy51e5MXTzKP/fWF9WCANT9M15a45ol17onbPzngDbkrLic6mYm9IGE7xa9gsK7RjAYoVxySdEvBbIkknTnaomZ5eafOVlEaK+OaI4kPzDoEA58nhPZSggPRUwVPM1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709512961; c=relaxed/simple;
	bh=fFqNIK8y1CcTYrN00EdlE8zbImFrHPJMAhLru41RiiU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u6SC9dumKkIcNZCXFuE716sJHLpeseuTQpN4nRDvEyJcc6rYRx4GuhFWvDdtUF4oJB/j/fBKe9rYWE8rFfYnE7AQi+bhgO5OjMCBKCBEvQS3IQ8WKRHzsKxtgxIDQENEiscEm7uoSSCrYy9EL7sy1jkghmyI8yn+y0bL/eryM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmlbQ+Ik; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709512959; x=1741048959;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fFqNIK8y1CcTYrN00EdlE8zbImFrHPJMAhLru41RiiU=;
  b=MmlbQ+IkWOmAbVgT6dhREx1FaR3FMadhd85+Wpj0R/zDD01qV1KA2kS1
   M2RZeWytYsfH6dbm5e/VkHV4r+jSOwF5qgY8ZWXanu6sYHycCI1Ewur+w
   +zqc/78byPjoeh5H5yOQGfYHhOBSm+UXevbycUHqdytWSFTEIBa2QdRJc
   q9eYam9RpY0YTgiN9uECk0j6dPoGD0R/Ui2NTyaZGUBx54r0oFtQNKZxM
   XN+Eqp2C8Aj1kEtvvxv441+/w8Jg168iqPfhRORtghclyaQe3nkkI1VZ7
   AJsJk0gD6iLdpkuYuHyhDKh5I9OA0oN2Z46BiAT2AMALOGN9PmSyl5miR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="6939913"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="6939913"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 16:42:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="9257395"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 03 Mar 2024 16:42:36 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgwPZ-0002E8-20;
	Mon, 04 Mar 2024 00:42:33 +0000
Date: Mon, 4 Mar 2024 08:41:34 +0800
From: kernel test robot <lkp@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Gow <davidgow@google.com>
Subject: WARNING: modpost: "strcpy" [lib/kunit/kunit.ko] has no CRC!
Message-ID: <202403040810.yoQCkEyj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58c806d867bf265c6fd16fc3bc62e2d3c156b5c9
commit: b67abaad4d25b5d9364a1d4f6bc18286ebaaa013 kunit: Allow kunit test modules to use test filtering
date:   7 months ago
config: alpha-randconfig-r062-20231222 (https://download.01.org/0day-ci/archive/20240304/202403040810.yoQCkEyj-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040810.yoQCkEyj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403040810.yoQCkEyj-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/reset/hisilicon/hi6220_reset.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/tty/serial/owl-uart.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/agp/alpha-agp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/lp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/dtlk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/hw_random/omap-rng.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/hw_random/nomadik-rng.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/ppdev.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/iova.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/lontium-lt9611.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/lontium-lt9611uxc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/sil-sii8620.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/sii9234.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/cirrus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_panel_orientation_quirks.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-slimbus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-w1.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/arizona.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/pcf50633-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/qcom-pm8008.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/aha1542.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/imm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-fabrics.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-fc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvmet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvme-loop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvmet-fc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/target/nvme-fcloop.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/phy/bcm87xx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/mdio/mdio-bitbang.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/pcs/pcs-lynx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/litex/litex_liteeth.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/marvell/octeontx2/af/rvu_mbox.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/smsc/smsc911x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/stmicro/stmmac/dwmac-altr-socfpga.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/ec_bhf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/plip/plip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ppp/ppp_generic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ppp/ppp_async.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ppp/bsd_comp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ppp/ppp_deflate.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/slip/slhc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/uio/uio_mf624.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/touchscreen/cyttsp_i2c_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rtc/lib_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rtc/rtc-rc5t583.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-ali1563.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/i2c/busses/i2c-qup.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/tuners/tda9887.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/pci/ttpci/budget-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/dvb-frontends/mb86a16.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/speedfax.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/isdn/hardware/mISDN/mISDNisar.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/host/tmio_mmc_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/host/renesas_sdhi_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/mmc_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_simple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_emmc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/sdio_uart.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/flash/leds-rt4505.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/framebuffer-coreboot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/memconsole.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firmware/google/memconsole-coreboot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_userspace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm-ccn.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/fsl_imx8_ddr_perf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/perf/arm_cspmu/arm_cspmu_module.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem-apple-efuses.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vdpa/vdpa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/parport/parport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/atm/nicstar.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/atm/iphase.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/atm/suni.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/atm/eni.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vhost/vringh.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/adc/xilinx-ams.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/buffer/kfifo_buf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/p8022.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/psnap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/stp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/bridge/bridge.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/atm/atm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/atm/lec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/chnl_net.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nci/nci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nfc_digital.o
WARNING: modpost: EXPORT symbol "strcpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strcat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncat" prototyped in <asm/asm-prototypes.h>?
>> WARNING: modpost: "strcpy" [lib/kunit/kunit.ko] has no CRC!
>> WARNING: modpost: "strncpy" [lib/kunit/kunit.ko] has no CRC!
WARNING: modpost: "strncat" [lib/kunit/kunit.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/video/backlight/sky81452-backlight.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/cyber2000fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/atmel_lcdfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/mmp/fb/mmpfb.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/video/fbdev/uvesafb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/etnaviv/etnaviv.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/misc/enclosure.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/nfc/nfcmrvl/nfcmrvl.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/libfc/libfc.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/fcoe/libfcoe.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/aic7xxx/aic7xxx.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/scsi/aic7xxx/aic7xxx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/aic7xxx/aic79xx.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/scsi/aic7xxx/aic79xx.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/qla4xxx/qla4xxx.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/qla4xxx/qla4xxx.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/mpi3mr/mpi3mr.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/esas2r/esas2r.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/nvme/host/nvme-fabrics.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/nvme/host/nvme-fc.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/nvme/target/nvmet.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/phy/nxp-c45-tja11xx.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/mdio/mdio-gpio.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] has no CRC!
WARNING: modpost: "strncat" [drivers/net/ethernet/broadcom/tg3.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] has no CRC!
WARNING: modpost: "strncat" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/e1000/e1000.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/igb/igb.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/igc/igc.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/i40e/i40e.ko] has no CRC!
WARNING: modpost: "strncat" [drivers/net/ethernet/intel/i40e/i40e.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/marvell/octeontx2/af/rvu_af.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/marvell/octeontx2/af/rvu_af.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "strncat" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/sfc/falcon/sfc-falcon.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/sfc/siena/sfc-siena.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/pensando/ionic/ionic.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/hamradio/baycom_par.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/plip/plip.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/message/fusion/mptsas.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/input/misc/axp20x-pek.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i2c/busses/i2c-jz4780.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/w1/slaves/w1_therm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mmc/core/mmc_core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/leds/leds-lp3952.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/parport/parport.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/atm/iphase.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/iio/adc/stm32-adc.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/most/most_core.ko] has no CRC!
WARNING: modpost: "strcpy" [net/can/can-bcm.ko] has no CRC!
WARNING: modpost: "strcpy" [net/netrom/netrom.ko] has no CRC!
WARNING: modpost: "strcpy" [net/rfkill/rfkill.ko] has no CRC!
WARNING: modpost: "strncpy" [net/caif/chnl_net.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

