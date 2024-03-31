Return-Path: <linux-kernel+bounces-126039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BB2893147
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8701C21066
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB8B143C76;
	Sun, 31 Mar 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qx5DN+Hu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC98290A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711882469; cv=none; b=QLOfH/52ssimAJQ08whC89ufCKT/BoeinCk4SiiiGPvfeKeROQ6ghMmraZCp5e2GnLWupjqwcfmvg1B0lrqaEIW17wrgB1jTM8lPDsvlz8wbf8R5fqUin30zL/MJKeCUf7HXa0b2i98mim+BDiPC11w0N5NwsZzh2rqOrzryqT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711882469; c=relaxed/simple;
	bh=Mg9CfA3/gT2jJNfZHP+KPwbcK/aNNH1UymFF8gplRIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qz9zRez/zx7Of8/zpE2up2ik1DVHqlbwcZz431KuOwCX0h0ZRqccsh6lqPB8MEtmS8T/CZZeCiciCWMbnO/aeAUxKSzztP5XQIToBAVlyPBXj3QBIVjNRJvOuJZMtK2nAJdQgBVUNMQZpcZzotXhVQyLX1Vx+WXUGxtFWF3lzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qx5DN+Hu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711882467; x=1743418467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Mg9CfA3/gT2jJNfZHP+KPwbcK/aNNH1UymFF8gplRIk=;
  b=Qx5DN+HuYSMZVJG6a2kP7mUtzMAjdLMU5U0IWtEPCt5XJMjh7aN5iNQR
   95GzOQ18KjHDKAJ49iS1TpT//1Q283saERwdHI3MdUHElzktEvlasN+1d
   SN4g3Pjqdjo85c5cDN16374Pjt5lJ08KMDjtUvFqfL6JmJELTlP7Gckq3
   ujW/pWtbgN4GwNTKubRvtpChR5snBuzpfC9UKFkRnE96rPceqnk2rTPpi
   ALSlq4eYaF5GSOq7WlRtwRv7aIRJTTB1CKpEiw9frkKYM/qQmjWGcuunC
   Gn49HoH8W/4N6cP7JiBS4c9WYRxx1IIr6XYo0y25Hog5vSpV0qae85ZUl
   w==;
X-CSE-ConnectionGUID: xThnClanS+ub1Pbg+h8grQ==
X-CSE-MsgGUID: Qlc+zYuNRtOBnQjY2FTezA==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="18169726"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="18169726"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 03:54:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="18055230"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 31 Mar 2024 03:54:25 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqspR-00012m-38;
	Sun, 31 Mar 2024 10:54:21 +0000
Date: Sun, 31 Mar 2024 18:53:56 +0800
From: kernel test robot <lkp@intel.com>
To: Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: WARNING: modpost: "__lshrdi3"
 [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] has no CRC!
Message-ID: <202403311822.UM1q5WSF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rohan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   712e14250dd2907346617eba275c46f53db8fae7
commit: 9e95505fecb6b5a25b5230eb49c4d5b9e18077d0 net: stmmac: Add support for EST cycle-time-extension
date:   4 months ago
config: sparc-randconfig-r021-20220616 (https://download.01.org/0day-ci/archive/20240331/202403311822.UM1q5WSF-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240331/202403311822.UM1q5WSF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403311822.UM1q5WSF-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

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
WARNING: modpost: "__udelay" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "__ndelay" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "__ashldi3" [crypto/ecc.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [crypto/ecc.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/test_bpf.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/test_bpf.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/test_bitmap.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/842/842_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/842/842_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/842/842_decompress.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/842/842_decompress.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/switches/idt_gen2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/rio-scan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/ili9320.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/l4f00242t03.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/vgg2432a4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/core/fb_ddc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/riva/rivafb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/nvidia/nvidiafb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/aty128fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/radeonfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/savage/savagefb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/vt8623fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cirrusfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/gxt4500.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/ssd1307fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/idma64.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/qcom_spmi-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/twl-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/lp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/intel-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/geode-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/omap-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/mxc-rnga.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ingenic-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/xgene-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/stm32-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ks-sa-rng.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/char/xillybus/xillybus_core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/misc/eeprom/eeprom_93cx6.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/cardreader/rtsx_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/dw-xdata-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/rn5t618.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-loopback-test.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/sfp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/bcm7xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/spi_ks8995.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/mdio/mdio-bitbang.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/3com/3c574_cs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/3com/3c59x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/3com/typhoon.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/8390/axnet_cs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/8390/pcnet_cs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/alacritech/slicoss.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/alacritech/slicoss.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/alteon/acenic.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/bcmsysport.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/cortina/gemini.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/dec/tulip/dmfe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/dlink/sundance.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/microchip/enc28j60.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/natsemi/natsemi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/packetengines/hamachi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/samsung/sxgbe/samsung-sxgbe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/sis/sis190.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] has no CRC!
>> WARNING: modpost: "__lshrdi3" [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/ti/tlan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/xircom/xirc2ps_cs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/altera/altera_tse.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/altera/altera_tse.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/fealnx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wan/pc300too.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/arcnet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/com90xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/b53/b53_common.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/dsa/microchip/ksz_switch.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/mt7530.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/vitesse-vsc73xx-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/kaweth.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/sr9700.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/sr9800.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/smsc75xx.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/firewire/firewire-core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/firewire/firewire-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/lcd2s.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ohci-hcd.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/host/r8a66597-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/r8a66597-hcd.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/gadget/udc/m66592-udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/m66592-udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/udc-xilinx.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/usb/gadget/function/u_audio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/cdns3/cdns-usb-common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/cdns3/cdns3-imx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/musb/musb_hdrc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/chipidea/ci_hdrc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/chipidea/ci_hdrc_tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/grip_mp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/ads7846.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/da9034-ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/ili210x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/mms114.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/raydium_i2c_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/stmpe-ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/sx8654.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/tps6507x-ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/misc/drv260x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-ds2404.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-msm6242.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-r7301.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-pca.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/busses/i2c-pca-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-pca-platform.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i3c/i3c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/dw-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/wdt_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/gpio_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-milbeaut.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/rtsx_pci_sdmmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-cadence.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/memstick/host/jmb38x_ms.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-ktd2692.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/crypto/hifn_795x.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/extcon/extcon-fsa9480.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/adc/ad7192.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad9467.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/adc/ad9467.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/hx711.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/max1241.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/afe/iio-rescale.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/ad5755.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/iio/dac/dpot-dac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/gyro/itg3200.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/pressure/dlhl60d.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/qinfo_probe.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/devices/phram.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/cafe_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/cafe_nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/ams-delta.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/gpio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/intel-nand-controller.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtd.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtdoops.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/ubi/ubi.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/ubi/gluebi.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

