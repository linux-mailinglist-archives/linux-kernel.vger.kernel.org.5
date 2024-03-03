Return-Path: <linux-kernel+bounces-89943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F6C86F7DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE811F21119
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408E7B3DA;
	Sun,  3 Mar 2024 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnXxZ7q/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51CD7AE50
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709508573; cv=none; b=FASoRvfLBF8oEPk9W2tibuc2kJ4izvufKslmUWiQ0OUFnKavDMrA+6mgcl/+IkiCr2yf3XO9k/EwpmuzP3+gtpET7i9HU6wEID2RXsenuJoekqjzRG22kBs0duQkm2FYsszIqbARUfE/9coyyp/iNi3ufRXokwK8u418Dkh+w7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709508573; c=relaxed/simple;
	bh=YlmYJbfJBhoa9aEJz/R6jtxDm6+NzvXtj8C245JkjP0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n2GOTMHHfMg5QK5sViHksjMubkL53VRelsd+yeLTiyaM1mjdkP2FdYhjKm/vmMgbzn3U4Dz3wAmOjhKtdLKISTCVkGnIATO4KAu3m4rce+3xYM8q6wYxZD3J5nmne4uQ/gng8LMlEiNMkCM6hVRh0j3rb7pSuQAzxhfxzQrDCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnXxZ7q/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709508571; x=1741044571;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YlmYJbfJBhoa9aEJz/R6jtxDm6+NzvXtj8C245JkjP0=;
  b=WnXxZ7q/eTJ/7vqSR4e9QwW2mmEc5FWYpf9s4J+YJnY1QrThbA6KnP8F
   O1HJzH7lh/66lq1ZHwoFy1nMJn3FjmlAXNQDpAxnsAgZm63sK9UkibCFf
   BqLfP3obGEKbmYYqkttp4XRo254v0oHm050k74dS8P3D61gLyeauMxsSW
   w9oVdRdjWGSsT64Ut6fb3G62dJ6A2KT7tyGmuM5CJhmTRbk3A51AMJKr+
   AoeX1zvJ8+eyJvUW16aCQTvhMZkT198OOmtmtHXbAqYWuP6Hu6PTkx/Qq
   sbzEZefaxTFJQTj5MSRoBny1KHFj1hLDtr6Ekchoylr29ZKabaowROfq1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3851280"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="3851280"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 15:29:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="9245946"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 03 Mar 2024 15:29:30 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgvGp-0002Ai-0q;
	Sun, 03 Mar 2024 23:29:27 +0000
Date: Mon, 4 Mar 2024 07:29:23 +0800
From: kernel test robot <lkp@intel.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: "strcpy" [drivers/clk/clk_test.ko] has no CRC!
Message-ID: <202403040734.dhA2hwnR-lkp@intel.com>
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
commit: 831187c6946f29ba8309d386d5ca466eec8b9f79 clk: Parameterize clk_leaf_mux_set_rate_parent
date:   5 months ago
config: alpha-randconfig-s032-20220318 (https://download.01.org/0day-ci/archive/20240304/202403040734.dhA2hwnR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040734.dhA2hwnR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403040734.dhA2hwnR-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-pv951.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-rc6-mce.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-real-audio-220-32-keys.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-reddo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-snapstream-firefly.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-streamzap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-su3000.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-tanix-tx3mini.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-tanix-tx5max.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-tbs-nec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-technisat-ts35.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-technisat-usb2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-terratec-cinergy-c-pci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-terratec-cinergy-s2-hd.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-terratec-cinergy-xs.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-terratec-slim-2.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-terratec-slim.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-tevii-nec.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-tivo.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-total-media-in-hand-02.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-total-media-in-hand.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-trekstor.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-tt-1500.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-twinhan1027.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-twinhan-dtv-cab-ci.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-vega-s9x.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-videomate-m1f.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-videomate-s350.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-videomate-tv-pvr.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-videostrong-kii-pro.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-wetek-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/rc/keymaps/rc-wetek-play2.o
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
>> WARNING: modpost: "strcpy" [drivers/clk/clk_test.ko] has no CRC!
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
WARNING: modpost: "strcpy" [net/can/can-bcm.ko] has no CRC!
WARNING: modpost: "strcpy" [net/rfkill/rfkill.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

