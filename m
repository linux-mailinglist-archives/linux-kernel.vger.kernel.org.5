Return-Path: <linux-kernel+bounces-89687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D986F42B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59A51C20A1D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD37AD5C;
	Sun,  3 Mar 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJ+ydgQQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D8AD35
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709458368; cv=none; b=aCaWly6mYBlwM55M2F7StY4BEE7aOaHFuMEcKxd2WcfE/BaBY/qSK9uREx4LflkIkfsqy6H24/B3b4gAqhf0lTqfhA9mLtOEauSpEVW6Sm7u5v+ttruJZaFy/tKdAOUJXK8Xvg1uGJZ4JJJxr+jgDyt8WBcR7olLyXLMHBv6qLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709458368; c=relaxed/simple;
	bh=bEmtJZ/Iwe/+dMt2LldCtxBZpGDPZYUILKfOfWxZRWs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=toJ8RiVVEQ+Z5QMcwU58LdlfsaMHKxoSUnUjsRsKxz4vU1TWff2j443hZnybR4VBfHBhFUyRhzGcKz98iWmfYK8Z/yNhJ1qlYJI5mVLSeTaioWHWMoNtwf9Tx8xpa5BbUaXYRqou6Hbk1TaL366FQunoVzP62rI/KXDBas7yQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJ+ydgQQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709458366; x=1740994366;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bEmtJZ/Iwe/+dMt2LldCtxBZpGDPZYUILKfOfWxZRWs=;
  b=oJ+ydgQQvzPCdHCgJXgfWTJW+vRVDLh2UjLy+65j0b/15PULeSI4ohF5
   Y+E2cl+ugeqGq4VSAUzD3VfV5W6KLmwBPaW80aXhx353YmTHwplopDgRy
   qTlgDsfWp0M4Cg9DoevzKijaEfc2lfHoEsRyX5/qO8AENH/ahbQ4ssHZ+
   x3Fkt7OKkKo31meCVPtyUQ6TmEm/brmSE1/FJkzv4LL7+MnN6iAmR+jLW
   CrdhQA7WBRhtG8kEsKT43F5RRSHZeMI6Rtvf05vKKbCGAmy89AQX+9WX+
   Dv5/+SAl/b9ft2XQkGP7TMGfcCuN7W7ZHRnai0fl3crgQxNbrmsVbgXw0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11001"; a="14536220"
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="14536220"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 01:32:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,200,1705392000"; 
   d="scan'208";a="13171665"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 03 Mar 2024 01:32:44 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgiD4-0001fI-0R;
	Sun, 03 Mar 2024 09:32:42 +0000
Date: Sun, 3 Mar 2024 17:32:11 +0800
From: kernel test robot <lkp@intel.com>
To: Willem de Bruijn <willemb@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: WARNING: modpost: "strcpy" [net/core/gso_test.ko] has no CRC!
Message-ID: <202403031752.dwXgZG8e-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   04b8076df2534f08bb4190f90a24e0f7f8930aca
commit: 1b4fa28a8b07eb331aeb7fbfc806c0d2e3dc3627 net: parametrize skb_segment unit test to expand coverage
date:   5 months ago
config: alpha-randconfig-s032-20220318 (https://download.01.org/0day-ci/archive/20240303/202403031752.dwXgZG8e-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240303/202403031752.dwXgZG8e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403031752.dwXgZG8e-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-winfast.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-winfast-usbii-deluxe.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-x96max.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-xbox-360.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-xbox-dvd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-zx-irdec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/rc-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/pci/saa7134/saa7134-empress.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/pci/saa7134/saa7134-dvb.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/host/of_mmc_spi.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/mmc_core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/sdio_uart.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-a4tech.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-apple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-belkin.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-cherry.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-dr.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ezkey.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-vivaldi-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-gyration.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kensington.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-keytouch.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-kye.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lcpower.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-lenovo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-magicmouse.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-mf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-microsoft.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-monterey.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-ortek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-pl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-petalynx.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-saitek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-semitek.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-speedlink.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-sunplus.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-gaff.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-topseed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-twinhan.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-zydacron.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/hid/hid-viewsonic.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/goldfish/goldfish_pipe.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/parport/parport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/touchscreen/cyttsp_i2c_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/matrix-keymap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/vivaldi-fmap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/input/tests/input_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iio/buffer/kfifo_buf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/core/dev_addr_lists_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/802/mrp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/8021q/8021q.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/packet/af_packet.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/packet/af_packet_diag.o
WARNING: modpost: missing MODULE_DESCRIPTION() in net/nfc/nci/nci.o
WARNING: modpost: EXPORT symbol "strcpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strcat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "strcat" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "strcat" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/char/ipmi/ipmi_msghandler.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/char/ipmi/ipmi_ssif.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/tty/n_gsm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_cmdline_parser_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_connector_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_dp_mst_helper_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_framebuffer_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_plane_helper_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_probe_helper_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/base/regmap/regmap-kunit.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/misc/eeprom/idt_89hpesx.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/misc/ti-st/st_drv.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/misc/c2port/core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/nfc/s3fwrn5/s3fwrn5.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mtd/ubi/ubi.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/wireless/broadcom/brcm80211/brcmfmac/brcmfmac.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/marvell/mwifiex/mwifiex.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/marvell/mwifiex/mwifiex_sdio.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/plip/plip.ko] has no CRC!
WARNING: modpost: "strncat" [drivers/net/ieee802154/adf7242.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/bq24190_charger.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/bq2515x_charger.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/hwmon/pmbus/pmbus_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mmc/core/mmc_core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/leds/leds-lp3952.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/parport/parport.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/input/rmi4/rmi_core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/iio/proximity/sx9324.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/thunderbolt/thunderbolt.ko] has no CRC!
>> WARNING: modpost: "strcpy" [net/core/gso_test.ko] has no CRC!
WARNING: modpost: "strcpy" [net/can/can-bcm.ko] has no CRC!
WARNING: modpost: "strcpy" [net/rfkill/rfkill.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

