Return-Path: <linux-kernel+bounces-89388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F10886EFB6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE05F285546
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA3612E48;
	Sat,  2 Mar 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVqKMXQ8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB179F0
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709370076; cv=none; b=N5Ls7y81f5nIBVgrFp3DaZ+zap2RrPuEq9OH+fmbdlakTbzXzfmxDwGYMtB/K41geIzitGxcmNIUq6vuEzU5GRm4HGOjIk41dWpvBtxPWA5wbr5NKl7hCgb5Nmr552t7lxOKc6Wfi8Dac9hqhr2OVFp+ym/wVT0WPPKmO62oCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709370076; c=relaxed/simple;
	bh=ftnU55mfyn2Q8iPjeZln8pOXq7c0lelEbbgwW57bkCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EJwgROZRAYVKdYaErof4L2u3iGVTRX9CTFPiSuOieIohkAc6zImJSrIQZNWaMx2rjQaG+g19mJ6LJHxMjhYZLcLA+YQyb+k0Tr3S8fYZ0mbrDaw83KYbQ6+yILxaweWo0URonJU7i7SSj7XqJwVCB0TMt8Bigh54GwFR3mXoyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVqKMXQ8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709370074; x=1740906074;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ftnU55mfyn2Q8iPjeZln8pOXq7c0lelEbbgwW57bkCg=;
  b=dVqKMXQ83Jjy5n6rl/jO2rN4ZHijLqFefTafFRtSgfI/5bNrqrHsoaXM
   p95IxNJAXIW9ZU4f6l6Zch2XI46Jr1hDrTu0T5r2xnLYNo6BRDmotcy5P
   O0zEpRzRPPGqzFSPyafWRCnDL9Bo6DQbSjoA1pIBbIb4xypGr4JbHE/kA
   fsqsPZB94It190BfAKuolca/ch16L8g024LbisGHL4G55WyiyKnpjqZx6
   CC/SJCEtIVqkJZeZ6MNOKRG2H6LwXINHkhrB95m2Dt9O6x+UbErlXC0HJ
   iibJe7YARSTWmHpC1l51iJ0T035XN3OcTTtwIaeHot79HRDxtjmz2gnss
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3778064"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="3778064"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 01:01:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="45968312"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 02 Mar 2024 01:01:12 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgLEz-000EUX-1o;
	Sat, 02 Mar 2024 09:01:09 +0000
Date: Sat, 2 Mar 2024 17:00:25 +0800
From: kernel test robot <lkp@intel.com>
To: Manish Mandlik <mmandlik@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: WARNING: modpost: "strcpy" [drivers/bluetooth/hci_vhci.ko] has no
 CRC!
Message-ID: <202403021638.hopNnMWF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5ad3cb0ed525b80c7f66c32b49a68c1f3510bec9
commit: ab4e4380d4e158486e595013a2635190e07e28ce Bluetooth: Add vhci devcoredump support
date:   10 months ago
config: alpha-buildonly-randconfig-r004-20220321 (https://download.01.org/0day-ci/archive/20240302/202403021638.hopNnMWF-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403021638.hopNnMWF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403021638.hopNnMWF-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "strcpy" [drivers/video/fbdev/sis/sisfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/arkfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/mmp/fb/mmpfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/regulator/virtual.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/block/pktcdvd.ko] has no CRC!
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
WARNING: modpost: "strncpy" [drivers/net/phy/nxp-c45-tja11xx.ko] has no CRC!
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
>> WARNING: modpost: "strcpy" [drivers/bluetooth/hci_vhci.ko] has no CRC!
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

