Return-Path: <linux-kernel+bounces-108471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300C3880AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0A81F2251A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6475156E4;
	Wed, 20 Mar 2024 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Opoh/sSJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC18125B4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914525; cv=none; b=MVVTFNaqu3B8YDSkDLqz7j5humMPaioxNRqK3CnaWxjzr8Zn31WIt76w6lY5SCTXX6ZnUCdMBGrP5hvMMZMu+ONz//T3oJNUM0pKq0LffCNyTz+9TnMY8B1rzXu8rknPzZ0vVg/FCr1AzQFlKJPktnBculhw3cg/HDLFLjzLnQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914525; c=relaxed/simple;
	bh=8PzdOY8/SJpv5QVH8o4zzSDOFaF7VamvSndAlxHEqqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HISZ6QBklSRszqMzVgqwbGCU0H/bHsL90vX98+ItNWfg8nEpCcIyWMdWMmwjCIKvxzITwNrwMBoBHq0V2wuL/JSE8/kDAiKEwn+bLVTUhhI6xjV+yeORx3ATIr/an9U8eIUJk8En5aU3G3W8ari+dHIxaQZAe08Vandaj9vIwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Opoh/sSJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710914523; x=1742450523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8PzdOY8/SJpv5QVH8o4zzSDOFaF7VamvSndAlxHEqqk=;
  b=Opoh/sSJS/B0S0jg3+6Mm18y+ZjKO0eeWq5nLsIop/T2P7ypAViTLPRh
   yysM0Vbo1wtYxZrMsOyCK8ZGSASrA07tQnt/M9WuqRStP/jx/nahTZqQB
   8v13nXX1w04Qmr7UbREuHVoP6A68YnkEG8w0mEmoXQbBpCRgnCj/lP5tb
   7i6nMsm+9OvZuTB/5Jw06wY1LoTwi7LJZs/MbKDO53HCOzgi+nIoQN0xT
   SzA6NLDOhocrM0zo0P3IgRcNCTMChi1kktSSgLScze99KhNYi9XQmxokq
   amO3OXjpCfIW9aSuPfVQduz8dLByb3CDudW3K++MbFB6R6XlyO0WIta+9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="9591589"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="9591589"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 23:02:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14025607"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Mar 2024 23:02:00 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmp1S-000IOR-09;
	Wed, 20 Mar 2024 06:01:58 +0000
Date: Wed, 20 Mar 2024 14:01:12 +0800
From: kernel test robot <lkp@intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: WARNING: modpost: "__udelay" [drivers/media/i2c/mt9m114.ko] has no
 CRC!
Message-ID: <202403201313.MKh3aqYw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Laurent,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4145ce1e7bc247fd6f2846e8699473448717b37
commit: 24d756e914fc3418bad7897b0657aefa9ef848e8 media: i2c: Add driver for onsemi MT9M114 camera sensor
date:   6 months ago
config: sparc-randconfig-001-20231208 (https://download.01.org/0day-ci/archive/20240320/202403201313.MKh3aqYw-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240320/202403201313.MKh3aqYw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403201313.MKh3aqYw-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-gbphy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-i2c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-pwm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/fbtft/fbtft.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/goldfish/goldfish_pipe.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwtracing/intel_th/intel_th_msu_sink.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvmem/nvmem_u-boot-env.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vdpa/vdpa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/vdpa/ifcvf/ifcvf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/parport/parport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_util.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/chips/cfi_cmdset_0020.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mtd/maps/map_funcs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/hisi-spmi-controller.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/core/dev_addr_lists_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_vti.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/esp4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/xfrm4_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/tunnel4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/raw_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/xfrm/xfrm_user.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/ah6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv6/xfrm6_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/smc/smc_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/caif/caif_usb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/packet/af_packet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/kcm/kcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/6lowpan/6lowpan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ieee802154/6lowpan/ieee802154_6lowpan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nfc_digital.o
ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!
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
WARNING: modpost: "__udelay" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "__ndelay" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/scftorture.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-kona-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/gpio/gpio-aggregator.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/gpio/gpio-latch.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pwm/pwm-pca9685.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/radeonfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/matrox/matroxfb_DAC1064.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/neofb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/carminefb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/mb862xx/mb862xxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/ssd1307fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/ipmi/ipmi_si.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/xilinx/xilinx_dpdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/rk808-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/hpilo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/altera-stapl/altera-stapl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/axp20x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/rn5t618.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-pxa2xx-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/firewire/firewire-ohci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/ks0108.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-ds2404.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-msm6242.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-pca.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-arb-gpio-challenge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca9541.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adp1653.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7183.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/media/i2c/mt9m114.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/mt9v032.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/media/i2c/tvp5150.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tuner-simple.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tda18271.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/atbm8830.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/mb86a16.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv0288.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/platform/cadence/cdns-csi2rx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/saa7134/saa7134-dvb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/pci/dt3155/dt3155.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/pmbus/max15301.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/pmbus/zl6100.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/ad7418.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/hs3001.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/lm93.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/powr1220.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-is31fl319x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-lt3593.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-mt6360.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-aat1290.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-ktd2692.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [drivers/infiniband/core/ib_uverbs.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/crypto/hifn_795x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/crypto/hifn_795x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/media/av7110/dvb-ttpci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/media/av7110/sp8870.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/fbtft/fbtft.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/fbtft/fb_agm1264k-fl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/fbtft/fb_bd663474.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/fbtft/fb_hx8340bn.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/fbtft/fb_ili9325.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/fbtft/fb_ili9340.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/fbtft/fb_ili9341.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/fbtft/fb_st7789v.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/fbtft/fb_tinylcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/fbtft/fb_uc1701.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/fbtft/fb_upd161704.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/cc10001_adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/cc10001_adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/hi8435.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/hx711.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/max11410.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/nau7802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/palmas_gpadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads8344.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads124s08.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/pressure/dlhl60d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/as3935.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/ping.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/resolver/ad2s1200.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-ps-spi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/parport/parport.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0001.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/qinfo_probe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/ams-delta.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/gpio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/intel-nand-controller.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spmi/hisi-spmi-controller.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/i8042.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/apbps2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/gameport/gameport.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ssb/ssb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bcma/bcma.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/thunderbolt/thunderbolt.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [net/rxrpc/rxperf.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

