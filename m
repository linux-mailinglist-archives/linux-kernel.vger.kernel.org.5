Return-Path: <linux-kernel+bounces-98899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6118780D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49808B20FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2663D986;
	Mon, 11 Mar 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enTiOYW7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0113FE23
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164629; cv=none; b=DD1PCqIWeG1k3Xvcjd5knTw0e8Iy+JJz2UQozN8e59dLjQKYCf/VUib1r0gc5tfZe9R1m92GqNbSQzWZ24Eqp/NY2jP4n763pzlpbwVGk1HNplGu74v46gI5iwSc1m0QP7za9JzMzI/Od/MGDcY40dfp4961witsWc/q+gD9+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164629; c=relaxed/simple;
	bh=I+35W4sZ3mzw55Ao5t3sIEgJ4sJWEYIWIfX8lDAcmoI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bj7Op9+cEi3L7tDii2Rcsw0uW2aW9VlTi4r7fifKEC5CCDDLFTwjoltP0u7eXQkINZASZBZ7dy4qlXMBV+wbrFFISpUXNitpX5kXb3whZhXfqBFZxF2Otn4ZtyPZyyZeb7YRFgQt5RLgF2o4sBvE/LMLCJg/aVVWHRahH0P4Y6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enTiOYW7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710164628; x=1741700628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I+35W4sZ3mzw55Ao5t3sIEgJ4sJWEYIWIfX8lDAcmoI=;
  b=enTiOYW7/dPXKZep4Uy6Y6AasAk+/7uPlfoeDddX6jXpPeWGkWsO8ceu
   LSR3nQqFqvUCB9MtnVaiB1UXeO/Qp1SCseT4BjJHV52yfv0q/eoc+5yZM
   KV0Iv6j4iTawlu9Udyp5pnI5o7Fo/wVO6ZU8QpEARITO0g05SzuSx9+ro
   qmrlNtx8gXlWWKf//1AanJvyytvNZJsV/65pxKpMd47gCllO3qco9j39y
   +ZOg2M584/kNbPIGQ0YtaTZI+ydgUW9oNYtD+RIhhjW+zH60KxMt5Dxfa
   7dd02MZXuqcin9L7eqiGDkYJ7U8PqeC7XcviMHnFC6gxEMmD/jpqAjPoo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4962898"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4962898"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:43:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11085559"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Mar 2024 06:43:45 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjfwM-00099n-0d;
	Mon, 11 Mar 2024 13:43:42 +0000
Date: Mon, 11 Mar 2024 21:43:40 +0800
From: kernel test robot <lkp@intel.com>
To: Trevor Wu <trevor.wu@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: WARNING: modpost: "__udelay"
 [sound/soc/mediatek/mt8188/snd-soc-mt8188-afe.ko] has no CRC!
Message-ID: <202403112121.kptBWGws-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Trevor,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8f897f4afef0031fe618a8e94127a0934896aba
commit: bf106bf09376608e4992f9806c21842a4223f18b ASoC: mediatek: mt8188: add platform driver
date:   1 year, 2 months ago
config: sparc-randconfig-r016-20230603 (https://download.01.org/0day-ci/archive/20240311/202403112121.kptBWGws-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240311/202403112121.kptBWGws-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403112121.kptBWGws-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

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
WARNING: modpost: "__udelay" [sound/soc/amd/acp_audio_dma.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-asrc.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-sai.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-easrc.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-xcvr.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/mediatek/mt8186/snd-soc-mt8186-afe.ko] has no CRC!
>> WARNING: modpost: "__udelay" [sound/soc/mediatek/mt8188/snd-soc-mt8188-afe.ko] has no CRC!
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

