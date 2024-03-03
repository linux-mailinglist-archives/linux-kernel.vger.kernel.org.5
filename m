Return-Path: <linux-kernel+bounces-89923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CE486F758
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981E21F2116F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1380A7A718;
	Sun,  3 Mar 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvufBnHj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB679DB7
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709503401; cv=none; b=oqOkdczKsqqYAzgVFvQfth7t9pAUgqh914m4PaDsL3dd7dWsicu3De8GuB4BHaa4n3g0vf8V3GnTGAHt+RZKvB4qjKiK3PGb+zikv5SB8RqsJlvoX2BLWuw5mDCx7ZQxWc1tao9O6n6lEwoWhZukk3x8y0DbKYdSY0aYpF+6/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709503401; c=relaxed/simple;
	bh=404hrQkFSafNGGqfuGVD2td27gUerFRf+a20Dy8mPwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ltLF5WSKuMRqegJm7TMDwPtmdesetdlQJwYXLCLefzjJ0ibknYryC2YCEY+PMXIksajQS2O0cton9yCLA8q2WiHzw3CzDw2GxTT243dbunyVo7j0X0EBC8YeW8Ztb+SHAsCw7j4RZXAwGQj31u5vHxY2vERk3zP4BMFDFFzxhf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvufBnHj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709503398; x=1741039398;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=404hrQkFSafNGGqfuGVD2td27gUerFRf+a20Dy8mPwE=;
  b=UvufBnHjHXfXZOwuPTGbiDSsE2dnsAic9o0EQHAtomjCMT0ZjAho+AiT
   5WQo8yNM6MpKblVnpDxS32eTULTqfGdg3Uzw4cPLnJcF6ueYaOENgt4qD
   PGAe8nfQ7rI0zeGdgDa1wtK4S0fC3altLWEJMsuhqOsQipPypTWUlITYY
   r49Mu9GzhDCIFqMbhmEpzVdUeRRgMwfKW4ZI53svynsDVeanrey/MI8BU
   /XHU+1r7/mvuFTvvGRK6+WVxar9zy0kQi/1ghHKcBfYlBlAICCQHBfMGP
   svIMh1+rW/sU3RkYjeFUQjQHVq/wqB//4Zo52NkqBLHYkXL1LxHirjqbv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7801008"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="7801008"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 14:03:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="39635552"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2024 14:03:16 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgtvO-00028K-0n;
	Sun, 03 Mar 2024 22:03:14 +0000
Date: Mon, 4 Mar 2024 06:02:08 +0800
From: kernel test robot <lkp@intel.com>
To: Jing Cai <jing.cai@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Chris Lu <chris.lu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: WARNING: modpost: "strcpy" [drivers/bluetooth/btmtk.ko] has no CRC!
Message-ID: <202403040552.0iyr20St-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58c806d867bf265c6fd16fc3bc62e2d3c156b5c9
commit: 0b70151328781a89c89e4cf3fae21fc0e98d869e Bluetooth: btusb: mediatek: add MediaTek devcoredump support
date:   7 months ago
config: alpha-buildonly-randconfig-r004-20220321 (https://download.01.org/0day-ci/archive/20240304/202403040552.0iyr20St-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040552.0iyr20St-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403040552.0iyr20St-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "strncpy" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/sis/sisfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/arkfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/mmp/fb/mmpfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/regulator/virtual.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/misc/ti-st/st_drv.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/misc/ics932s401.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/misc/lkdtm/lkdtm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/misc/apds9802als.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/scsi_transport_fc.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/libfc/libfc.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/libfc/libfc.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/qla4xxx/qla4xxx.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/scsi/qla4xxx/qla4xxx.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/qla4xxx/qla4xxx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/bfa/bfa.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/smartpqi/smartpqi.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/atp870u.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/bnx2i/bnx2i.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/qedi/qedi.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/nvme/host/nvme-fabrics.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/nvme/host/nvme-fc.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/aquantia/atlantic/atlantic.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/broadcom/bnx2.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/broadcom/tg3.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/net/ethernet/broadcom/tg3.ko] has no CRC!
WARNING: modpost: "strncat" [drivers/net/ethernet/broadcom/tg3.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] has no CRC!
WARNING: modpost: "strncat" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/cortina/gemini.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/e100.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/intel/e100.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/intel/e1000/e1000.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/e1000/e1000.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/intel/igb/igb.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/igb/igb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/intel/iavf/iavf.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/net/ethernet/intel/iavf/iavf.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/intel/fm10k/fm10k.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "strncat" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/qlogic/qede/qede.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/message/fusion/mptbase.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/message/fusion/mptbase.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/message/fusion/mptctl.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/cdrom/cdrom.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/input/touchscreen/sun4i-ts.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i2c/busses/i2c-at91.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i2c/busses/i2c-jz4780.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i3c/i3c.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/i3c/i3c.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/media/rc/rc-core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/w1/slaves/w1_therm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/power/supply/wm831x_backup.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/charger-manager.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/power/supply/bq2415x_charger.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/power/supply/bq256xx_charger.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/f71882fg.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/amc6821.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/thmc50.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/hwmon/pmbus/pmbus_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/isdn/mISDN/mISDN_core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/isdn/mISDN/mISDN_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mmc/core/mmc_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mmc/core/mmc_block.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/leds/led-class-multicolor.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/leds/leds-lm3530.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/leds/leds-lp3952.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/leds/leds-lp5521.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/leds/leds-lp5523.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/leds/leds-wm831x-status.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hid/hid.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hid/hid-wiimote.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/rpmsg/rpmsg_ns.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/rpmsg/virtio_rpmsg_bus.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/devfreq/governor_userspace.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/memory/brcmstb_dpfe.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/perf/arm_smmuv3_pmu.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/perf/marvell_cn10k_tad_pmu.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwtracing/intel_th/intel_th.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwtracing/intel_th/intel_th_gth.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwtracing/stm/stm_console.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/fpga/dfl-fme.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/ata/libata.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/bluetooth/hci_vhci.ko] has no CRC!
>> WARNING: modpost: "strcpy" [drivers/bluetooth/btmtk.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/soundwire/soundwire-bus.ko] has no CRC!
WARNING: modpost: "strcpy" [net/x25/x25.ko] has no CRC!
WARNING: modpost: "strcpy" [net/can/can-bcm.ko] has no CRC!
WARNING: modpost: "strcpy" [net/bluetooth/bluetooth.ko] has no CRC!
WARNING: modpost: "strcpy" [net/9p/9pnet_fd.ko] has no CRC!
WARNING: modpost: "strcpy" [net/caif/caif.ko] has no CRC!
WARNING: modpost: "strncpy" [net/caif/chnl_net.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

