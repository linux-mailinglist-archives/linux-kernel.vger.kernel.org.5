Return-Path: <linux-kernel+bounces-96739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0128760DA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1C1282A7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B9B53376;
	Fri,  8 Mar 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeeahMxh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308434F61C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889651; cv=none; b=u0ppWjkqaCo1OS28lEOFjGey5uZe/iWLLg/MbDEkQykSwDRLvY8gHi2vnVLNxF6Z3v2uv1HO2bybCNyJn8oYea0bBg+YszUTTqNTBZiN+t+4gIZMwFrpM+eaZoHyENW8uUretS8aWTfIkZLcgNKnog64i6UhOn7RXCm2akSJOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889651; c=relaxed/simple;
	bh=m2mLWxHfLU91FTi+ynqflHTYvIQ9wyiLb5W1bvnIBuA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F8T+8S2VULaGMsCpRqXlr+jPAovSAa9nMFUZsJob9YTeH1nv5NdOt5Tk0DEq9pB7+LWV3979Ws2y08IEiIi7w4IuKd8EzHF5u2E7S+Dk/FWpj2qriSJ7TVoQV9CjN5CbieHxq7ztT/4SX3eiKuQcX44BF+TW16n/ICIzgt7BF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeeahMxh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709889648; x=1741425648;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m2mLWxHfLU91FTi+ynqflHTYvIQ9wyiLb5W1bvnIBuA=;
  b=QeeahMxhEqjv1ki8t9WNBQLOcEpKazityrPMUNNDz8D7mXMxG3XXx3se
   wRu8+wmM7hb8BCiILSFrp5ULYUl/LDLLa7/Hl685HdQ4mRxgqSArtd/R6
   YttoDUBweytEM+oG1FnRh4XASEDSwEzfrSzA2A/UQPZlKJvm125oA+zQA
   8R+ynAtPoNFxtQF/wbTFNOWAa2MtyGVYon24uIZCDWRWf4O14wakWxPWs
   bRYUblggPFnr3Ct2CmLakLO8XS0N6wyhbUe8/nwEbwP7e2dcM8QHTfPAK
   jxxMMeRTMFgpEV8mQ77YVXvNnUdvrfT0Z0xEnNFHHz7USnTZY5PRii/Kb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15168820"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15168820"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 01:20:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10289926"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 Mar 2024 01:20:45 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1riWPD-0006Eh-0S;
	Fri, 08 Mar 2024 09:20:43 +0000
Date: Fri, 8 Mar 2024 17:19:44 +0800
From: kernel test robot <lkp@intel.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-bcm-unimac.ko]
 has no CRC!
Message-ID: <202403081710.Vekh8jST-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3aaa8ce7a3350d95b241046ae2401103a4384ba2
commit: 268531be211f18c55f7ff5a1641d32c0fd0571cd net: mdio: mdio-bcm-unimac: Delay before first poll
date:   3 months ago
config: sparc-randconfig-r013-20230904 (https://download.01.org/0day-ci/archive/20240308/202403081710.Vekh8jST-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240308/202403081710.Vekh8jST-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403081710.Vekh8jST-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_text.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/sched/em_canid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/ip_gre.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/esp4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ipv4/xfrm4_tunnel.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ar9331.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_brcm.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_dsa.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_gswip.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_hellcreek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ksz.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_lan9303.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_mtk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_none.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ocelot.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_ocelot_8021q.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_qca.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_rtl8_4.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_sja1105.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_trailer.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/dsa/tag_xrs700x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nci/nci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/ieee802154/ieee802154_socket.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/hsr/hsr.o
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
WARNING: modpost: "__udelay" [kernel/rcu/rcutorture.ko] has no CRC!
WARNING: modpost: "__udelay" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "__ndelay" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/ecryptfs/ecryptfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/afs/kafs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/afs/kafs.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/crc4.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/crc4.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/842/842_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/842/842_compress.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/842/842_decompress.ko] has no CRC!
WARNING: modpost: "__ashldi3" [lib/842/842_decompress.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-kona-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/gpio/gpio-aggregator.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/gpio/gpio-latch.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-atmel-hlcdc.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/pwm/pwm-atmel-tcb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/backlight/as3711_bl.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/video/backlight/ktd253-backlight.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/sm501fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/ipmi/ipmi_si.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/clk/clk-cs2000-cp.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/clk/clk-cs2000-cp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/clk-cs2000-cp.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/clk/clk-versaclock7.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/clk/clk-versaclock7.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/virtio/virtio_balloon.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/char/xillybus/xillybus_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/eeprom/eeprom_93xx46.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/misc/eeprom/eeprom_93xx46.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/sm501.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mfd/sm501.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/atmel-hlcdc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-loopback-test.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-cadence.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/bcm7xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/dp83640.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-bcm-unimac.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/mdio/mdio-bitbang.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/cadence/macb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/cortina/gemini.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/engleder/tsnep.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/micrel/ks8851_par.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/microchip/enc28j60.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mscc/mscc_ocelot_switch_lib.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/mscc/mscc_ocelot_switch_lib.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/qualcomm/emac/qcom-emac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/samsung/sxgbe/samsung-sxgbe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/wiznet/w5300.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/altera/altera_tse.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/altera/altera_tse.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/ethernet/dnet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/arcnet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/com90io.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/com20020.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/b53/b53_common.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/dsa/microchip/ksz_switch.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/dsa/sja1105/sja1105.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/net/dsa/sja1105/sja1105.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/bcm-sf2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/mt7530.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/i8042.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/keyboard/matrix_keypad.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/input/mouse/psmouse.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/joystick/as5011.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/edt-ft5x06.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/ili210x.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/input/touchscreen/pixcir_i2c_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/raydium_i2c_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/sx8654.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/tps6507x-ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/zforce_ts.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/touchscreen/zinitix.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/rmi4/rmi_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rtc/rtc-x1205.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-pca.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-gpio.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/i2c/busses/i2c-pca-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-pca-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-arb-gpio-challenge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-ltc4306.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca9541.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca954x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7604.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/adv7842.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/bt819.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/ks0127.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/media/i2c/tvp5150.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/i2c/vpx3220.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/max2165.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mt20xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mxl5007t.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tda18271.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/platform/cadence/cdns-csi2tx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/atbm8830.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/mb86a16.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/mt312.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/s5h1420.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/si2168.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv0288.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/dvb-frontends/stv0910.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-frontends/stv6110.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/media/v4l2-core/videodev.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/media/v4l2-core/videodev.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-core/dvb-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ptp/ptp_idt82p33.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ptp/ptp_dfl_tod.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-lt3593.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-ktd2692.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/memory/dfl-emif.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/memory/dfl-emif.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/vdpa/vdpa.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0020.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/chips/cfi_cmdset_0020.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/ams-delta.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtd.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtdoops.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/spi-nor/spi-nor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pcmcia/pcmcia_core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/w1/masters/ds2482.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/masters/sgi_w1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

