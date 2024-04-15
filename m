Return-Path: <linux-kernel+bounces-144604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD338A484D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1193281A10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBE51EB35;
	Mon, 15 Apr 2024 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5MWRPie"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C31D53F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163520; cv=none; b=R7a/wRsAN4sQF79+yxmB1Aq2yL+3NBbXF03pGSZBsm69HFEcRdtkQGhRaP0S+pvPacuz+W3rm9aoefn13QrAhIa0EC0W5NCa5VZcJiLYGaIOQeFCwuwkIyRs/OJ6xg+gWFoFn5Vx1J+QnTZJ1oKEzi91nb6sdXmbDB8Vlpiiyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163520; c=relaxed/simple;
	bh=W6FhwViSXRz6bQPs524APsC5i/eWy8eLJBaZhylokmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t7ZJU5yQgf88BOlClivQCb38VuBoI1o1igYPlOHQ9kAj6vn3cqY1hPDxVqAbe4vMRG424LHp2FQvH0pVxOOXjO3okzZsVUQFvK/lazVuFM04ydec1UEdlcRgozBtzrtZggrgAj7itP+gh+8LnhJcXbuIBC7x7B8a16mF3z422yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5MWRPie; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713163517; x=1744699517;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=W6FhwViSXRz6bQPs524APsC5i/eWy8eLJBaZhylokmo=;
  b=e5MWRPiehVp4DpySBdlcdhdUMdeFcrtmhFZiflIjCTLL+Q6x/wHiO2ru
   AjZjok5ZnyoyTGbbqT61DngLmffHHANwAZclc5f2oHQW/ETTlchrzFWKs
   AvwVMu5HhrbfjGQGYbODcQy8kDxD5uWAC7I0vYsZ/dso+hikNJsohhvcs
   IRVpbl/GWL/Y2EpxqCXYlvOGPPkAQS3DzPembOz2Et4nJgyvC2dTmQiMA
   MyScPF7lVsWZGwi0TpU4jN/IHwXNNTGlu539TmSER5j5fQCZ6Nnj8ZrIP
   4QvVwAhKQkkcRkk9SDwt2bOjaium/GfyuFQfRoQnEskx6viw7HQkbg9Xz
   A==;
X-CSE-ConnectionGUID: DNBXum+BQ+aGZfrlm1ipOw==
X-CSE-MsgGUID: 3L65fvk2Qfa0Ttu2Nw/LGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8372370"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8372370"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:45:16 -0700
X-CSE-ConnectionGUID: SIAVybLPQmitcoZEYbNmiQ==
X-CSE-MsgGUID: JnV8k06qR/Kf5g3IyRRuBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="59258039"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 14 Apr 2024 23:45:15 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwG5V-00041S-22;
	Mon, 15 Apr 2024 06:45:10 +0000
Date: Mon, 15 Apr 2024 14:44:50 +0800
From: kernel test robot <lkp@intel.com>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: WARNING: modpost: "__ashldi3"
 [drivers/crypto/intel/qat/qat_common/intel_qat.ko] has no CRC!
Message-ID: <202404151404.vzUsD7AY-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tom,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bbac3facb5d6cc0171c45c9873a2dc96bea9680
commit: a4b16dad46576ce08ecb660fc923d0857dcae107 crypto: qat - Move driver to drivers/crypto/intel/qat
date:   1 year ago
config: sparc-buildonly-randconfig-r004-20221002 (https://download.01.org/0day-ci/archive/20240415/202404151404.vzUsD7AY-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240415/202404151404.vzUsD7AY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404151404.vzUsD7AY-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-s3c2410.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-sh_mobile.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-stm32f7-drv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-rcar.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-ltc4306.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca954x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7183.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7604.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7842.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/bt819.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/cx25840/cx25840.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/media/i2c/tvp5150.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/max2165.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mt20xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mxl5007t.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tuner-simple.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tda18271.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/rc/rc-core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/rc/rc-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/rc/gpio-ir-tx.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/media/rc/gpio-ir-tx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/rc/ir-hix5hd2.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/rc/imon_raw.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/usb/dvb-usb/dvb-usb-umt-010.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/usb/dvb-usb/dvb-usb-dw2102.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/usb/dvb-usb-v2/dvb-usb-anysee.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/usb/as102/dvb-as102.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/usb/cx231xx/cx231xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/usb/em28xx/em28xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/atbm8830.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/m88rs2000.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/mt312.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/si2168.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stb6000.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv0288.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv0299.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/dvb-frontends/stv0910.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv6110.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/dvb-frontends/tda10086.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/zl10353.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/v4l2-core/tuner.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/v4l2-core/videodev.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/v4l2-core/videodev.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-core/dvb-core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/cec/core/cec.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/cec/core/cec.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/radio/shark2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/si4713/si4713.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/tea575x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/radio/radio-keene.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/w1/masters/ds2482.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/power/reset/atc260x-poweroff.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/power/reset/piix4-poweroff.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/power/supply/88pm860x_charger.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/pcwd_usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/at91rm9200_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/dw_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/npcm_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/meson_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/digicolor_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/aspeed_wdt.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/watchdog/mena21_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/da9052_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/rave-sp-wdt.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/raid10.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/raid10.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/raid456.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-mod.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [drivers/md/dm-mod.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-mod.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-unstripe.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-bufio.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-bufio.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-crypt.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [drivers/md/dm-crypt.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-crypt.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-dust.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [drivers/md/dm-flakey.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-snapshot.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-snapshot.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-region-hash.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-region-hash.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-verity.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-verity.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-cache.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-cache.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-era.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-log-writes.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-log-writes.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-integrity.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-integrity.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/md/dm-zoned.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/md/dm-zoned.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/memstick/host/jmb38x_ms.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-is31fl319x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-lt3593.ko] has no CRC!
>> WARNING: modpost: "__ashldi3" [drivers/crypto/intel/qat/qat_common/intel_qat.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/hid/hid-creative-sb0540.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hid/hid-creative-sb0540.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mailbox/sprd-mailbox.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/hwspinlock/u8500_hsem.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/extcon/extcon-fsa9480.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/ntb/test/ntb_tool.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/ntb/test/ntb_tool.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/ntb/test/ntb_perf.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/ntb/test/ntb_perf.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/vdpa/vdpa.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/parsers/sharpslpart.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0020.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/chips/cfi_cmdset_0020.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/qinfo_probe.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/devices/phram.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/ams-delta.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/davinci_nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/fsmc_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/gpio.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/marvell_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/marvell_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/lpc32xx_slc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/sh_flctl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/mxc_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/txx9ndfmc.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/sunxi_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/brcmnand/brcmnand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/brcmnand/brcmnand.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/brcmnand/brcmnand.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/nand/raw/qcom_nandc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/stm32_fmc2_nand.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/meson_nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/meson_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/ecc-mtk.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtd.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtd_blkdevs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtdoops.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/ubi/ubi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/i8042.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/apbps2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/olpc_apsp.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/input/mouse/psmouse.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/misc/adxl34x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/misc/cma3000_d0x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/lm93.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hwmon/ltc2947-core.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/hwmon/ltc2947-core.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/hwmon/nct6775-core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/hwmon/nct6775-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/powr1220.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/hwmon/sht15.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bluetooth/bt3c_cs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bluetooth/bluecard_cs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bluetooth/btusb.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/core/snd-timer.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/i2c/other/snd-ak4xxx-adda.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/i2c/other/snd-ak4114.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/i2c/other/snd-ak4113.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/i2c/snd-cs8427.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/drivers/opl3/snd-opl3-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/drivers/mpu401/snd-mpu401-uart.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/drivers/vx/snd-vx-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-atiixp-modem.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-cmipci.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-cs4281.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-ens1370.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-es1938.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-es1968.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-fm801.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-intel8x0.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-rme96.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-via82xx.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-via82xx-modem.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/ac97/snd-ac97-codec.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/ali5451/snd-ali5451.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/au88x0/snd-au8810.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/ctxfi/snd-ctxfi.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/ca0106/snd-ca0106.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/cs46xx/snd-cs46xx.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/cs5535audio/snd-cs5535audio.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/echoaudio/snd-darla20.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/echoaudio/snd-layla24.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

