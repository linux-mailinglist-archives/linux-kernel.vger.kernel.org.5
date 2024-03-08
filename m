Return-Path: <linux-kernel+bounces-96753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A5F876104
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EAA8B21D41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87636535A7;
	Fri,  8 Mar 2024 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0VYFicQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D322F0F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890610; cv=none; b=i1UsHFhLQ/BuIK1ADm2ZXbOTiCVn1x2uNYHH96nA1ENbGY8k+HZcxuNDSRc2D5k/k6Byg3VaOCO0FsqUADjMvckJkq41MfYX3QUmuFx4a4ngFcBO/9lc+PR9KX+vTKFm79MWgpRdIz0x5Pa3OyHuuKrVQHQsaRzce8yF84mhNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890610; c=relaxed/simple;
	bh=cHxDtPD5GqLcS7QfoTk1er6MLptRT5zrTJXmF/Bz/GI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mQD7HirWRec9uAq17ZEQcMVUPlcNU7duQF4YC1wF28AY0GfrKS2+YvnTIkwSk0Ggq6FmzSyLQ8tXCYbru1D7sA6lKeQlJnnjybnkOqnBBufsJigIl5qf6rcRx0J2pDOjKxJ8WJfYF0jFVaL2RkyH/aDBG/FZO2iA+2+UU0lf7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0VYFicQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709890608; x=1741426608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cHxDtPD5GqLcS7QfoTk1er6MLptRT5zrTJXmF/Bz/GI=;
  b=h0VYFicQMiWxkTlwPM8M/mJV1Si8/qARFLrhAb8m/0cJYmdG66euMkmn
   EVY1fq9A6FWbJ8hhzttTB2lqPpeoXJCkWlCCJEe6e3uCM9/XO9aBud+hp
   cdAYj/+yZS8IhbE4USS9IxmVL3DFPbt5X736HYx0WSU8Al745vi7UK4Ut
   QuMs/rxahKz470m3Bv0obLeDREkY6q2kSFRO39bClBx2QSIO8MKutskJ6
   5HazcI/l1xDRrINcePsHqqS7vgdSbtLFphJspxZzYMuWhwyHMhYro1YmH
   ARyAQpOoU5b7IiU9uJvNlvYg56XvRX7aTt7HpdkwZ1ut//NWu8B01a5Gk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15171688"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15171688"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 01:36:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10291906"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 Mar 2024 01:36:45 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riWeh-0006FD-1A;
	Fri, 08 Mar 2024 09:36:43 +0000
Date: Fri, 8 Mar 2024 17:36:31 +0800
From: kernel test robot <lkp@intel.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: WARNING: modpost: "__udelay"
 [drivers/phy/qualcomm/phy-qcom-qmp-combo.ko] has no CRC!
Message-ID: <202403081758.s52DG2CO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3aaa8ce7a3350d95b241046ae2401103a4384ba2
commit: d1abd69534bec16c43c633313e8e937af1354a7a phy: qcom-qmp: Introduce Kconfig symbols for discrete drivers
date:   1 year, 1 month ago
config: sparc-randconfig-r006-20221121 (https://download.01.org/0day-ci/archive/20240308/202403081758.s52DG2CO-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240308/202403081758.s52DG2CO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403081758.s52DG2CO-lkp@intel.com/

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
WARNING: modpost: "__udelay" [kernel/rcu/rcutorture.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/rcu/rcuscale.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/time/test_udelay.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/scftorture.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/ext4/ext4.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/ext4/ext4.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [fs/cramfs/cramfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/gfs2/gfs2.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/f2fs/f2fs.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [lib/crypto/libchacha20poly1305.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/allwinner/phy-sun6i-mipi-dphy.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/phy/cadence/phy-cadence-torrent.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/hisilicon/phy-hi3670-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/hisilicon/phy-hisi-inno-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-keembay-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/intel/phy-intel-lgm-emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/lantiq/phy-lantiq-vrx200-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/marvell/phy-armada38x-comphy.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/phy/qualcomm/phy-qcom-qmp-combo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/ralink/phy-ralink-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-inno-dsidphy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-snps-pcie3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/samsung/phy-exynos5-usbdrd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/sunplus/phy-sunplus-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/l4f00242t03.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/as3711_bl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/qcom/clk-qcom.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/qcom/gcc-ipq4019.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/clk/qcom/clk-spmi-pmic-div.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/qcom/qcom_rpmh.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/samsung/exynos-usi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/ti-abb-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_dw.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_omap.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/tty/serial/sccnxp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/msm_serial.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/omap-rng.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/misc/eeprom/eeprom_93xx46.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/eeprom/eeprom_93xx46.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/altera-stapl/altera-stapl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/ssbi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/atmel-hlcdc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/rn5t618.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/acer-ec-a500.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/libiscsi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/esp_scsi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/sun_esp.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/diskonchip.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/lpc32xx_mlc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/sh_flctl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/mxc_nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/bcm47xxnflash/bcm47xxnflash.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/brcmnand/brcmnand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/stm32_fmc2_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/ecc-mtk.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-armada-3700.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-cadence-quadspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-mt7621.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-npcm-pspi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-pxa2xx-platform.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/spi/spi-pxa2xx-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-tegra20-slink.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/sfp.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/mdio/mdio-bitbang.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-ipq4019.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-moxart.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-mscc-miim.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/mv643xx_eth.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/mediatek/mtk_star_emac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/renesas/ravb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/samsung/sxgbe/samsung-sxgbe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/sun/sunbmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/davicom/dm9000.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/korina.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ipa/ipa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/phy/phy-tegra-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/dwc3/dwc3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/dwc3/dwc3-meson-g12a.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/mtu3/mtu3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/oxu210hp-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/isp116x-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/isp1362-hcd.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/c67x00/c67x00.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/musb/musb_hdrc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/musb/ux500.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/i8042.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/olpc_apsp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-ds2404.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-msm6242.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-r7301.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-stm32.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-x1205.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-pca.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-jz4780.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-mt65xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-owl.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/busses/i2c-pca-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-pca-platform.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/busses/i2c-s3c2410.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-s3c2410.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-rcar.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca9541.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca954x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/dw-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mt20xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/atbm8830.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/mt312.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/si2168.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv0288.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

