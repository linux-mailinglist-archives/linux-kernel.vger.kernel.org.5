Return-Path: <linux-kernel+bounces-90032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02B586F917
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C0AB20D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0BA612E;
	Mon,  4 Mar 2024 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ju2M5S33"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10E611A;
	Mon,  4 Mar 2024 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709524268; cv=none; b=PhiNk+N3xAkF9RnaXwc6e5wYVAdPpr6pXt7rSZD876G3+MgD96qWhX/jCqItqKTYETGGtv9XuxQ8uaVT/RCaph4qCxVkbnvmpdBvr5CQQzgvnhp/xR8H7mNPGYgoVLBVKEjuRAIBXkmGy/j2a4UgnnhHMYTCRkVxO3D8zqoFb3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709524268; c=relaxed/simple;
	bh=SYNRknKSSrLHCA4uTn0YmSfvsIhhGcOKi15/aY4sdE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gHQx6QfVU/dgtmc3/KxoiyeEMRbMuLm5ZfIlYJBi0v/xZrsh7JQcVOMikrdqMTTixvCGToPlqJ6cDB4kPAjsZY1Q4lxjFToKxE7cmCqPYp1c/04d87XjNFlXxBhyibScl8ruvWrG7xmg1xMhY3uDXehqDqTLGnKbLGYJvAp9lE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ju2M5S33; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709524266; x=1741060266;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SYNRknKSSrLHCA4uTn0YmSfvsIhhGcOKi15/aY4sdE0=;
  b=ju2M5S33+4jATd6osjHaQiePJajQynYxQzCrqGb13khdaeWUWr/J9XhU
   dK2K6yrnRR8rDfUqje6K6zghh/FHP0sj7zmxCd/NmBcYIqR89Mtt26Tvp
   kwqKPjANwUApLOY1jvpCMbi1Qi1Ox1i+5qWH/NHB7OpdDhbDMV0n+8W3W
   uZ8CmLKwDkP+sEMpHwQGtnGDZ3HyIbCGmJq8aP53TVw4FuEldVcheLiZJ
   rAxJZFgRwANvM86Xd34VdBfz1xHS0Eor4lMZ586xdqcYDZx9bgnS/DGdQ
   vCDBcG2nYQG/6Y5suDqWhESevxepMAqKNPKvCN7d+h50irD1+t1PRx6QJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7770073"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7770073"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 19:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9212868"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Mar 2024 19:51:04 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgzLw-0002KN-2a;
	Mon, 04 Mar 2024 03:51:00 +0000
Date: Mon, 4 Mar 2024 11:50:47 +0800
From: kernel test robot <lkp@intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Subject: WARNING: modpost: "__ashldi3" [drivers/media/v4l2-core/videodev.ko]
 has no CRC!
Message-ID: <202403041109.BmYl5mGm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90d35da658da8cff0d4ecbb5113f5fac9d00eb72
commit: a6b995ed03ffeb36f06c4a46d8804c24d776de6f media: subdev: use streams in v4l2_subdev_link_validate()
date:   1 year, 1 month ago
config: sparc-buildonly-randconfig-r001-20230222 (https://download.01.org/0day-ci/archive/20240304/202403041109.BmYl5mGm-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403041109.BmYl5mGm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403041109.BmYl5mGm-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

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
WARNING: modpost: "__udelay" [kernel/scftorture.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [fs/cramfs/cramfs.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/zstd/zstd_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/zstd/zstd_compress.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/zstd/zstd_decompress.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/zstd/zstd_common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/ipmi/ipmi_si.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/xilinx/xilinx_dpdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/altera-msgdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/idma64.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/mt6359-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/qcom_spmi-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sunzilog.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_base.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/tty/serial/8250/8250_base.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_dw.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_tegra.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/tty/serial/sccnxp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sc16is7xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/char/xillybus/xillybus_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/altera-stapl/altera-stapl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/atmel-hlcdc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/qinfo_probe.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/devices/phram.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtdoops.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/ubi/ubi.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/ubi/gluebi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/sbus/char/uctrl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-r7301.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-bit.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-arb-gpio-challenge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7604.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7842.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/bt819.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/mt9t112.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/mt9v032.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/ov6650.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/tda1997x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/max2165.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mt20xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mxl5007t.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tuner-simple.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tda18271.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/platform/cadence/cdns-csi2rx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/atbm8830.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stb6000.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv0288.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/dvb-frontends/stv0910.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv6110.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/dvb-frontends/tda10086.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/zl10353.ko] has no CRC!
>> WARNING: modpost: "__ashldi3" [drivers/media/v4l2-core/videodev.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/v4l2-core/videodev.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-core/dvb-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-pr-ip-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spmi/hisi-spmi-controller.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/comedi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/ad7606.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/adi-axi-adc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/hx711.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/palmas_gpadc.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/adc/ti-ads1015.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/afe/iio-rescale.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/common/ms_sensors/ms_sensors_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/potentiometer/ad5272.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/pressure/dlhl60d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/ping.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/iio/industrialio.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/core/snd-timer.ko] has no CRC!
WARNING: modpost: "__ashldi3" [sound/core/snd-pcm-dmaengine.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/ac97/snd-ac97-codec.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/hda/snd-hda-codec.ko] has no CRC!
WARNING: modpost: "__ashldi3" [sound/pci/hda/snd-hda-codec-generic.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [sound/pci/hda/snd-hda-codec-generic.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/sparc/snd-sun-dbri.ko] has no CRC!
WARNING: modpost: "__ashldi3" [sound/soc/snd-soc-core.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/snd-soc-core.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-adau1701.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-adau17x1.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-ak4458.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-aw8738.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs35l41-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs42l51.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs42l73.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs4265.ko] has no CRC!
WARNING: modpost: "__ndelay" [sound/soc/codecs/snd-soc-cs4270.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-cs4271.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-dmic.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-max98357a.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-nau8540.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-nau8810.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-nau8822.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-nau8824.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-rk3328.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-rt5616.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-rt5645.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-sgtl5000.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-sta32x.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tas5086.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tlv320aic23.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tlv320aic31xx.ko] has no CRC!
WARNING: modpost: "__ndelay" [sound/soc/codecs/snd-soc-tlv320aic31xx.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-tlv320aic3x.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8510.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8711.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8903.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8904.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8974.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/codecs/snd-soc-wm8978.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/amd/acp_audio_dma.ko] has no CRC!
WARNING: modpost: "__ashldi3" [sound/soc/fsl/snd-soc-fsl-asrc.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-asrc.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/soc/fsl/snd-soc-fsl-sai.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/hda/snd-hda-core.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/hda/ext/snd-hda-ext-core.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

