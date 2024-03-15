Return-Path: <linux-kernel+bounces-104243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FC187CB27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C00C1F21A71
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5C182D8;
	Fri, 15 Mar 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMc9m7Im"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A674518624
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497468; cv=none; b=AmKCdv+zogjUTbTEMKK9JDo/M0B/WbXlIz+04BwX+Tqf9b1q/WBeNfL+O0RAaysfTHvgxFYJTvymv6ELbaa/y4kP3eJW3JpFtRtU42ryIXlGssgSv3IugohNFeB2AqLiXF83y9NLMNCT4Fv4u81umOQfW65e7/LgCQIcG2rK/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497468; c=relaxed/simple;
	bh=HQEnTbJvDq/Q0+ZITefaVgNTVapt0byjB7S9oFq3aXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e3N51GAxERvZBrpXoxamhktfg/fMr9CwkPYAxbhMiwODV/U17v9q9XbMBvxJzk62U9Uz+xTi8e3GbXa5v0clSUpPdkwCo4vWp59fkHkUIPQHBwCylxyttN4EvpCJ/VMF2V07tESdNqRYthdwbuxMGGNmhpjuzYMPIiZvg6Lq/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMc9m7Im; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710497467; x=1742033467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HQEnTbJvDq/Q0+ZITefaVgNTVapt0byjB7S9oFq3aXk=;
  b=gMc9m7ImBdreY/I5orgadJTNceAXtCbr+MnAYc1RbwgPmVc535oaY6pq
   J5+dq7wHQ9Avkt7DqyiEt3M5GjEsiztsjU6GQhQZdYd5nA5aAiMC5hr9D
   8rFxlDV13Vc7Kh8S9bMHNOs+1qE1tmKTjnSNigOT5nHF4mVaRR1HxrZvL
   jLzquJPX6zO+905RwO0PN4mWJcb4zK4UMJw/qfvNStBb6hU6OxdEpaOHP
   nD3GdlrqtG3P99bk/7RNXueCdPSFOI/XPyGNr6Pjpgybl2eCBIunnBPvV
   wnxBV7AF9JMTMQ7lSe/mWw07Dxpv/jWyanG+YEZB0PhN5yFDY1P3sCH1N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5545444"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5545444"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 03:11:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="35753174"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Mar 2024 03:11:04 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rl4Wk-000EKD-0n;
	Fri, 15 Mar 2024 10:11:02 +0000
Date: Fri, 15 Mar 2024 18:10:07 +0800
From: kernel test robot <lkp@intel.com>
To: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: WARNING: modpost: "__udelay" [sound/soc/apple/snd-soc-apple-mca.ko]
 has no CRC!
Message-ID: <202403151819.OiJ905Ty-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5eb28f6d1afebed4bb7d740a797d0390bd3a357
commit: d8b3e396088d787771f19fd3b7949e080dc31d6f ASoC: apple: mca: Fix SERDES reset sequence
date:   1 year, 1 month ago
config: sparc-randconfig-r016-20230603 (https://download.01.org/0day-ci/archive/20240315/202403151819.OiJ905Ty-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240315/202403151819.OiJ905Ty-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403151819.OiJ905Ty-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/ams-delta.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/fsmc_nand.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/atmel/atmel-nand-controller.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/lpc32xx_slc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/lpc32xx_mlc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/sh_flctl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/mxc_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/txx9ndfmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/mtk_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/ecc-mtk.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/gameport/gameport.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/imx_keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/matrix_keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/samsung-keypad.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/sh_keysc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/tegra-kbc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/rmi4/rmi_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ssb/ssb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad7280a.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad7476.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/ad7606.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad7949.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/aspeed_adc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/aspeed_adc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/cc10001_adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/cc10001_adc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/hx711.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/imx8qxp-adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/max11410.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/max1241.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/mt6577_auxadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/meson_saradc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/nau7802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/palmas_gpadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/sun4i-gpadc-iio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads8344.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/ad5592r-base.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/dac/ad5766.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/stm32-dac-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/stm32-dac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/pressure/dlhl60d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/as3935.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/srf04.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/resolver/ad2s1200.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/core/snd-timer.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/hda/snd-hda-codec.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/sparc/snd-sun-dbri.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-adau1373.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-adau17x1.ko] has no CRC!
WARNING: modpost: "__ndelay" [sound/soc/codecs/snd-soc-adau1977.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-ak4458.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-ak4613.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-ak4641.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-arizona.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs35l41-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs42l51.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs42l73.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs4265.ko] has no CRC!
WARNING: modpost: "__ndelay" [sound/soc/codecs/snd-soc-cs4270.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs4271.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-da732x.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-l3.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-madera.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-max98357a.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-nau8540.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-nau8822.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-nau8825.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-peb2466.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-rk3328.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-rt286.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-rt298.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-rt5616.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-rt5645.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-rt5670.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-rt5677.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-sgtl5000.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-sta32x.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-sta350.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tas5086.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tlv320aic23.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tlv320aic31xx.ko] has no CRC!
WARNING: modpost: "__ndelay" [sound/soc/codecs/snd-soc-tlv320aic31xx.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tlv320aic3x.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-twl4030.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-uda1380.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8510.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8711.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8903.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8904.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8961.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8962.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8974.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8978.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8995.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm9081.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm-hubs.ko] has no CRC!
>> WARNING: modpost: "__udelay" [sound/soc/apple/snd-soc-apple-mca.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/amd/acp_audio_dma.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-asrc.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-sai.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-easrc.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-xcvr.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/mediatek/mt8186/snd-soc-mt8186-afe.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/mediatek/mt8188/snd-soc-mt8188-afe.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/meson/snd-soc-meson-t9015.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/mxs/snd-soc-mxs.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/sh/snd-soc-fsi.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/sh/rcar/snd-soc-rcar.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/sh/snd-soc-rz-ssi.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/sti/snd-soc-sti.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/stm/snd-soc-stm32-sai.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/stm/snd-soc-stm32-i2s.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/ti/snd-soc-davinci-asp.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/ti/snd-soc-omap-mcbsp.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/xilinx/snd-soc-xlnx-formatter-pcm.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/hda/snd-hda-core.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/hda/ext/snd-hda-ext-core.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

