Return-Path: <linux-kernel+bounces-42851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC158407B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4324A28C1F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEA266B46;
	Mon, 29 Jan 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAKOPNei"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A466B5F;
	Mon, 29 Jan 2024 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536669; cv=none; b=qwABMJ8SfT/QsJIfrNAmb/ft0UZ2ftYDyo4dLCKdxKUHxYD9sgbLMfq4s0OoQQH1tHOR8bEL7LjRTQXrucSQqga2TWkJAC53iPrDOcmmS31R4AM4vgJUXn0NFoKK7SzbzFRYcJfDPHS5hwmZA2Xd0EMrTvno30MO0q3jBOR3DQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536669; c=relaxed/simple;
	bh=NLrE0l8CIIWHQblyExJp8WZ4C1WqOcu10JTv+kwmFjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5p+IZglNu7xY/xfeXHpN9QpOPX7La9wK6WYvBxYIBZhD5nQ0om6ovYhmarQ5gQT/OmUxBBzKWPi8GZ+6NvV1EpQ0OZeWZB3QLabIaK6cbNbxcfQ07oK+gd5ZUdMOhQMh5dHM0ff/6zLy7RLeIRhRG9/UUwdN+RciJr7Kcy3Ua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAKOPNei; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706536667; x=1738072667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NLrE0l8CIIWHQblyExJp8WZ4C1WqOcu10JTv+kwmFjY=;
  b=gAKOPNeiBE3VeAqDbv6KQSh3y/EE5ib1PCUPQAnPWLdq9iAEKwmkqzCP
   F0vjCUpY1j1tD6xHasIBXVxIKCHdsG8J+eXdXnJyCX+08DR3rD53vyZ4W
   mEYi4gX+zn3znbGf1O9i4GCRAiqauSNGa64IKhmQhLF8GFPXUYWiMo2CC
   hmA2JoIGprG/B+TZrhF1rDGM8ogR/uPp7m+1ktqddlJBOkTcmwsvUiZgP
   /ISKcbuBLwOIxYQSJBw3dU5UaPyQZ76huJ7Qhbz6b3CvDik8mj7owcdle
   D8JBz7IXqAgTLFPk1ryXA4QtmMDPc42cLz6VCJId+2aqBHBgHjq9Lhj7m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="434120642"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="434120642"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 05:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="911064235"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="911064235"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2024 05:57:38 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUS8l-0004Jw-2N;
	Mon, 29 Jan 2024 13:57:35 +0000
Date: Mon, 29 Jan 2024 21:57:24 +0800
From: kernel test robot <lkp@intel.com>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, catalin.marinas@arm.com,
	will@kernel.org, robh+dt@kernel.org, frowand.list@gmail.com,
	vgupta@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
	guoren@kernel.org, monstr@monstr.eu, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, dinguyen@kernel.org, chenhuacai@kernel.org,
	tsbogend@alpha.franken.de, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
	mpe@ellerman.id.au, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 18/46] of: reserved_mem: Add code to dynamically allocate
 reserved_mem array
Message-ID: <202401292157.5rBrHUhI-lkp@intel.com>
References: <20240126235425.12233-19-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126235425.12233-19-quic_obabatun@quicinc.com>

Hi Oreoluwa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm64/for-next/core powerpc/next powerpc/fixes jcmvbkbc-xtensa/xtensa-for-next linus/master v6.8-rc2 next-20240129]
[cannot apply to vgupta-arc/for-curr vgupta-arc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oreoluwa-Babatunde/of-reserved_mem-Change-the-order-that-reserved_mem-regions-are-stored/20240127-081735
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240126235425.12233-19-quic_obabatun%40quicinc.com
patch subject: [PATCH 18/46] of: reserved_mem: Add code to dynamically allocate reserved_mem array
config: riscv-randconfig-r071-20240128 (https://download.01.org/0day-ci/archive/20240129/202401292157.5rBrHUhI-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240129/202401292157.5rBrHUhI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401292157.5rBrHUhI-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux: section mismatch in reference: alloc_reserved_mem_array+0x76 (section: .text) -> memblock_alloc_try_nid (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: alloc_reserved_mem_array+0x142 (section: .text) -> memblock_free (section: .meminit.text)
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/refscale.o
WARNING: modpost: missing MODULE_DESCRIPTION() in mm/kasan/kasan_test_module.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp437.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp737.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp852.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp857.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_cp950.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_iso8859-15.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_utf8.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-croatian.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-greek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-iceland.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-inuit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/mac-romanian.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/binfmt_misc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/cramfs/cramfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/isofs/isofs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/hfs/hfs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/sysv/sysv.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/efs/efs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/qnx6/qnx6.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/pstore/pstore.o
WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-keys/trusted.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/cast_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in crypto/ecc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in block/t10-pi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/crypto/libdes.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ubsan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpio/gpio-mc33880.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpio/gpio-pl061.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/video/fbdev/vfb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/qcom/hdma.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/regulator/max20411-regulator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/hw_random/omap-rng.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/hw_random/omap3-rom-rng.o
WARNING: modpost: drivers/char/hw_random/mxc-rnga: section mismatch in reference: mxc_rnga_driver+0x10 (section: .data) -> mxc_rnga_remove (section: .exit.text)
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-abt-y030xx067a.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-newvision-nv3052c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/panel/panel-orisetech-ota5601a.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/lontium-lt9611uxc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/sil-sii8620.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/bridge/sii9234.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/misc/open-dice.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/pcf50633-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mfd/qcom-pm8008.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/scsi/scsi_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/common/nvme-auth.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-fabrics.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-fc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spi/spi-fsl-lib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/charlcd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44780_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/class/usbtmc.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/storage/uas.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/misc/isight_firmware.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_fs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/gadget/function/usb_f_printer.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/chipidea/ci_hdrc_msm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/rtc/rtc-tps65910.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/leds/flash/leds-rt4505.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/crypto/atmel-sha204a.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-bootrom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-light.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-log.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-power-supply.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-raw.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-vibrator.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-gbphy.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-i2c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/staging/greybus/gb-spilib.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hwmon/mr75203.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/greybus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/buffer/kfifo_buf.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

