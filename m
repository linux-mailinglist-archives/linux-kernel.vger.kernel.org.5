Return-Path: <linux-kernel+bounces-88385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCED886E0DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F08F2874D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369D66E2AE;
	Fri,  1 Mar 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oICTOxHL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312B6D1D8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294953; cv=none; b=gZFkcA6EDa0afs+JQgk/ZLNHOvFbhPF7ymmfPKWta2DoXicmo+H0EFXsk57oj05MJkJhPW/C7PP/cyYJnplof5gV0m2Ws+iqZSvOxGEGXSVVW2rjPJcXPMkuTvmlf0ll3SEL0S2+ykQjNBJ6iFH6SPZ6a03L7PHVea2JqShRD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294953; c=relaxed/simple;
	bh=mzRJEphcLhvNOvK3qQIt5Sm6ecGfCfg/vGKnwceyVBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QTCam+V9pdWI82ZZsQhUf1Vec39pCccg2Qn6iZl+3Uydb9W+Ft1goSczQMwg7/PGHkTQoj/PrO37QClAwKyEf1GeuGGg9XnAACgXuKcze7Nn9f+JoqshSiE9dlWMkVItc6baE7O3ODCe7wOpQJIYxOaBba0LSR7tjskoPgWDBIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oICTOxHL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709294951; x=1740830951;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mzRJEphcLhvNOvK3qQIt5Sm6ecGfCfg/vGKnwceyVBQ=;
  b=oICTOxHLfcZwseyU/bg9XfDzGFtqM48yxZLAqsG138YABRN5j17rE8Xd
   slg3f6tRKVqu06kWAYRURV2tcg0E+8BiSBymOO2TtFVq3IMr/i7CnwfjM
   uYjfDVrqARvyZUsxX8q4Sve3jwDy2LP2bI01fgbcX6BR0jeAh+/JDGypb
   WUYe/pP28GJZwJ0mz6jZHC9wNYhBqN0u5QrF5qeOskaKMFKa9m8Pj7VDS
   Hnenq7BSoNydRuFxTqWYaswuSKTbeGycrBlJnMuf6n4whhk1AyBZ64BtE
   v09vjLVnUACYuxezSOu+RpZG8ebc5V0neQVbYdbBvqLbT1XWN8f82zKMM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="21283894"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="21283894"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 04:09:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8079318"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 01 Mar 2024 04:09:08 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rg1hI-000Dpp-2t;
	Fri, 01 Mar 2024 12:09:05 +0000
Date: Fri, 1 Mar 2024 20:08:05 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: "strcpy" [drivers/base/regmap/regmap-kunit.ko] has
 no CRC!
Message-ID: <202403011914.TnZPFgsx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   87adedeba51a822533649b143232418b9e26d08b
commit: 2238959b6ad27040275439edd6893e309bc729a3 regmap: Add some basic kunit tests
date:   11 months ago
config: alpha-randconfig-r023-20230913 (https://download.01.org/0day-ci/archive/20240301/202403011914.TnZPFgsx-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403011914.TnZPFgsx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403011914.TnZPFgsx-lkp@intel.com/

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
WARNING: modpost: "strncpy" [fs/reiserfs/reiserfs.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/autofs/autofs4.ko] has no CRC!
WARNING: modpost: "strncpy" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/video/backlight/sky81452-backlight.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/mmp/fb/mmpfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/cyber2000fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_cmdline_parser_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_connector_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_dp_mst_helper_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_framebuffer_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_plane_helper_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/tests/drm_probe_helper_test.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/nouveau/nouveau.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/nouveau/nouveau.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/virtio/virtio-gpu.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/etnaviv/etnaviv.ko] has no CRC!
>> WARNING: modpost: "strcpy" [drivers/base/regmap/regmap-kunit.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/misc/eeprom/idt_89hpesx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/misc/enclosure.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/misc/c2port/core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/nvdimm/nd_btt.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/dax/dax.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/scsi_mod.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/snic/snic.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/BusLogic.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/aic7xxx/aic7xxx.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/scsi/aic7xxx/aic7xxx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/aic7xxx/aic79xx.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/scsi/aic7xxx/aic79xx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/ips.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/qla4xxx/qla4xxx.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/qla4xxx/qla4xxx.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/elx/efct.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/bfa/bfa.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/hpsa.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/smartpqi/smartpqi.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/myrs.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/nvme/host/nvme-fabrics.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/phy/nxp-c45-tja11xx.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/asix/ax88796c.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] has no CRC!
WARNING: modpost: "strncat" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/e100.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/igb/igb.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/igc/igc.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/fm10k/fm10k.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/marvell/mvpp2/mvpp2.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/sfc/siena/sfc-siena.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/apm/xgene/xgene-enet.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/plip/plip.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/usb/host/ehci-hcd.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/usb/host/isp1362-hcd.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/usb/misc/usbsevseg.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/usb/musb/musb_hdrc.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/input/misc/axp20x-pek.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/ptp/ptp_ocp.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/w1/slaves/w1_therm.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/bq24190_charger.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/md/md-mod.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/md/md-mod.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/md/dm-mod.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/md/dm-mod.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/md/dm-cache.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/md/dm-zoned.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/mmc/host/vub300.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/leds/leds-lp3952.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/hid/uhid.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/staging/rts5208/rts5208.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/staging/sm750fb/sm750fb.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/staging/greybus/gb-firmware.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/rpmsg/qcom_glink.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwtracing/intel_th/intel_th.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/target/target_core_mod.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/target/target_core_mod.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mtd/devices/phram.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mtd/devices/block2mtd.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/atm/solos-pci.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/most/most_core.ko] has no CRC!
WARNING: modpost: "strcpy" [net/bluetooth/bluetooth.ko] has no CRC!
WARNING: modpost: "strcpy" [net/rfkill/rfkill.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

