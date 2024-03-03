Return-Path: <linux-kernel+bounces-89865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244E386F6B1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BA71F21465
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACFE79B6C;
	Sun,  3 Mar 2024 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyUCackn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E21BE49
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493005; cv=none; b=dd8NLN+u6yH50OQtY4HC3NFXDMOWKD0WEojsRRcxsQ285+NrXoeChYn8V18jxR/rJzCi8cEvFmgGvwTdZFfgk0E2INlwLZyjF75Q3/5InnlOLy2JWEgjZIRfD/oQyjX6KuhjdjjDCujeTJP7wOhJO3ZWSfF+B5ufCY+XtJLwtFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493005; c=relaxed/simple;
	bh=Hba6oGgosc6iwpGMmhuvvHdDdH9qXw51Goup0NOi2RI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IIaE9WjWtXaAXi3Fu2BjVzY9bwmbeQAWpdCBXFuERpzZEJNgeaYY0TUWuRzkBGrgOXoL3q0VZKsqVQF+aLkULGx5/NeZvLFFyj3WqmdeFMipeuh/wQ8gw8A3Q31yYXVSHf9c88qMElR5PVvtISh4Q5HDULT8AeK0q4gD7E/gq5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyUCackn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709493004; x=1741029004;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hba6oGgosc6iwpGMmhuvvHdDdH9qXw51Goup0NOi2RI=;
  b=hyUCackn4pnVr3NJjAVsxO9vzg5n4oAeVeHoAHkAIqTSEAd7zwvuVpgA
   SAGtKSmEWMcI+7qJVG/1cTOS+gxN4XZq3P6BNfxFJ/MLXX0UZzZUUKpfG
   +7FZU5528pOWJKk5eE384HyN6v5o9pvCPnD+3Iw7brtPY/DYyr8X7j42x
   ydpHPeIdKhZnfmFIftAA/3+oy3h438ALFgUGk1vwtONK7C2ESVnbrckE1
   +RvZyhz30g6n3DQ50t8a528q1+x0H50J0aojYqtLYQ7zUDrbUP+X1Oq8e
   V51Qn9l7GuVa9Eny3k/YADnf+JnPHjJZCl5mVCRUY0hWECDQi4WGiqiRu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7795067"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="7795067"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 11:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="13441951"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Mar 2024 11:09:59 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgrDg-00022K-10;
	Sun, 03 Mar 2024 19:09:56 +0000
Date: Mon, 4 Mar 2024 03:09:04 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: "strcat" [lib/strcat_kunit.ko] has no CRC!
Message-ID: <202403040332.AgBq81MC-lkp@intel.com>
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
commit: 3bf301e1ab85e18ed0e337ce124dc71d6d7b5fd7 string: Add Kunit tests for strcat() family
date:   10 months ago
config: alpha-randconfig-r032-20221115 (https://download.01.org/0day-ci/archive/20240304/202403040332.AgBq81MC-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040332.AgBq81MC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403040332.AgBq81MC-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux.o: EXPORT_SYMBOL used for init/exit symbol: page_is_ram (section: .init.text)
WARNING: modpost: EXPORT symbol "strcpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strcat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strcat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "strcpy" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "strcat" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "strncat" [lib/kunit/kunit.ko] has no CRC!
WARNING: modpost: "strncpy" [lib/test_hexdump.ko] has no CRC!
WARNING: modpost: "strcpy" [lib/test_rhashtable.ko] has no CRC!
WARNING: modpost: "strcpy" [lib/crc64-rocksoft.ko] has no CRC!
WARNING: modpost: "strncat" [lib/strcat_kunit.ko] has no CRC!
>> WARNING: modpost: "strcat" [lib/strcat_kunit.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/cyber2000fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/sis/sisfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/savage/savagefb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/mb862xx/mb862xxfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/ocfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/char/ipmi/ipmi_si.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/char/ipmi/ipmi_si.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/char/ipmi/ipmi_watchdog.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_cmdline_parser_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_connector_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_dp_mst_helper_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_framebuffer_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_plane_helper_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_probe_helper_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/hisilicon/hibmc/hibmc-drm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/nouveau/nouveau.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/nouveau/nouveau.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/base/regmap/regmap-kunit.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/misc/cb710/cb710.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/misc/apds990x.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/misc/c2port/core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/firewire/firewire-core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i2c/busses/i2c-at91.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i2c/busses/i2c-owl.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/media/dvb-frontends/cxd2841er.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/media/platform/nxp/imx7-media-csi.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/power/supply/wm831x_backup.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/power/supply/wm831x_power.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/bq2515x_charger.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/bq25980_charger.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/leds/leds-lm3530.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/leds/leds-wm831x-status.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hid/hid-wiimote.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hid/hid-sensor-custom.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/staging/vme_user/vme_tsi148.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/staging/greybus/gb-loopback.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/staging/sm750fb/sm750fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/adc/hx711.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/adc/mcp3422.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/adc/mxs-lradc-adc.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/light/cm32181.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/proximity/srf08.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/iio/proximity/sx9324.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/test/iio-test-rescale.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/perf/marvell_cn10k_tad_pmu.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/rapidio/rapidio.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/adm1029.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/adt7462.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/adt7475.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/f71882fg.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/fschmd.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/i5k_amb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/amc6821.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/hwmon/pmbus/pmbus_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwtracing/stm/stm_console.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/fpga/fpga-mgr.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/fpga/dfl-fme.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

