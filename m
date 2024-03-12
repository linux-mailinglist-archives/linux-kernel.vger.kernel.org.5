Return-Path: <linux-kernel+bounces-100150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304C287929E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DC71C22582
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666D7993A;
	Tue, 12 Mar 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WregRMyw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5307178691
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241232; cv=none; b=szdM/6DhBRwZgx1A1l9CQnlCjgstQnEzFtxNKoho4STPAwh1v+zrlDqggRUqdry2LIRjIqmVQm5FCRvIt6y7j3S00AieW/Jck+luLGbyguvL12Q4b8oISZo9Iw9tpRZ29vc5ER/hGCGTv4Ob7nqs2e7lChMTwBTI6/N4YYeerMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241232; c=relaxed/simple;
	bh=oC0txnZALqkVir1sH8kJnxYuQsvfpR5iBeoV9ahnVyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZTb+9TucV+zA2pgyxnM5oAXXPHYna8ssjMMtb1aLRcxwHJDfw3j1mPiCAgU9+5hnKmlYJkztgAYUPMH6ceVnWFCLp6IbHhisk2IHPqGPwcqhViVNDIbxahZ3h3GIzqxUaUQVq0cmxuqBDU3MsjeO9iJz1gxLiO7YPZdP3xlAn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WregRMyw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710241230; x=1741777230;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oC0txnZALqkVir1sH8kJnxYuQsvfpR5iBeoV9ahnVyQ=;
  b=WregRMywHQxgXV5hMeYCo9jMFJ39gNK0AhTEBVq3HWrbW34Vwo5USi2+
   NP5u8Kj/YaXjZN37eEUm11EU/+9xJ9v/8I/0EreuUSfjnJiU2S/q9zCo+
   /7lpMotrvgBTYP2sxcwkEYkxJOmnNKe9r3koAiPk9xQElzCDs6io7jK9A
   LZV0Fjp7b7C6e698W462kJoN+EH44bjQou6k27l5+oSgrQsd/vwMDgQyu
   DPaOyy8BHYKkNVvlgNdO7CBKzf4wZxA6WDvlS5ieY3wvjpnKJE2VuN7NY
   mJGqmfPUMQ5UJWOtC343Yo0yuosFPlIzlXkmo1FDq1JvBn0rdMLQ6bTQu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8760718"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8760718"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 04:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="48947489"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 12 Mar 2024 04:00:27 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjzrt-000A3l-1d;
	Tue, 12 Mar 2024 11:00:25 +0000
Date: Tue, 12 Mar 2024 19:00:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Gao Xiang <xiang@kernel.org>, Yue Hu <huyue2@coolpad.com>,
	Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Subject: WARNING: modpost: "__ashrdi3" [fs/erofs/erofs.ko] has no CRC!
Message-ID: <202403121805.86ZfrC2n-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   855684c7d938c2442f07eabc154e7532b4c1fbf9
commit: 3acea5fc335420ba7ef53947cf2d98d07fac39f7 erofs: avoid hardcoded blocksize for subpage block support
date:   11 months ago
config: sparc-randconfig-r003-20220921 (https://download.01.org/0day-ci/archive/20240312/202403121805.86ZfrC2n-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240312/202403121805.86ZfrC2n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403121805.86ZfrC2n-lkp@intel.com/

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
WARNING: modpost: "__udelay" [kernel/locking/locktorture.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [kernel/locking/locktorture.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/rcu/rcutorture.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/scftorture.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/squashfs/squashfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/squashfs/squashfs.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/squashfs/squashfs.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/sysv/sysv.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/sysv/sysv.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/ufs/ufs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/ufs/ufs.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/ufs/ufs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/udf/udf.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/udf/udf.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/udf/udf.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/udf/udf.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/omfs/omfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/befs/befs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/befs/befs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/erofs/erofs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/erofs/erofs.ko] has no CRC!
>> WARNING: modpost: "__ashrdi3" [fs/erofs/erofs.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [lib/crypto/libchacha20poly1305.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/zstd/zstd_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/zstd/zstd_compress.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/842/842_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/842/842_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/842/842_decompress.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/842/842_decompress.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-gxl-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-g12a-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-brcm-sata.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-sr-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-keembay-emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-keembay-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-lgm-emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/marvell/phy-mmp3-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-typec.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/samsung/phy-exynos-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/st/phy-stm32-usbphyc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pinctrl/bcm/pinctrl-bcm2835.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/gpio/gpio-pisosr.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/pwm/pwm-atmel.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-atmel.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-imx-tpm.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-rcar.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/pwm/pwm-renesas-tpu.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-renesas-tpu.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-stm32-lp.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/pwm/pwm-stm32-lp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/ili9320.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/as3711_bl.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/video/backlight/ktd253-backlight.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/omap2/omapfb/dss/omapdss.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/arcfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/ipmi/ipmi_si.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/sprd/clk-sprd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/clk-plldig.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/ixp4xx/ixp4xx-npe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/qcom/qcom_rpmh.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/qcom_spmi-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/reset/reset-berlin.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/reset/reset-imx7.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_base.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_omap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/samsung_tty.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/msm_serial.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/mxs-auart.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/mtk-rng.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/misc/eeprom/eeprom_93xx46.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/eeprom/eeprom_93xx46.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/altera-stapl/altera-stapl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/rn5t618.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-loopback-test.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-bitbang.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-lm70llp.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/spi/spi-mt65xx.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/spi/spi-mt65xx.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/spi/spi-mtk-snfi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-npcm-pspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-orion.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-sh-hspi.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-sh-hspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-sprd-adi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-xtensa-xtfpga.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spmi/spmi-pmic-arb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spmi/spmi-mtk-pmif.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/lcd2s.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/phy/phy-am335x-control.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/phy/phy-tegra-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-brcm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/isp116x-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/isp1362-hcd.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/host/r8a66597-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/r8a66597-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-fsl.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/usb/misc/uss720.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/misc/onboard_usb_hub.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/pxa27x_udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/bdc/bdc.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/usb/gadget/function/usb_f_mass_storage.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/usb/gadget/function/usb_f_mass_storage.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/isp1760/isp1760.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/isp1760/isp1760.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/cdns3/cdns-usb-common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/cdns3/cdns3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/serial/keyspan.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

