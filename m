Return-Path: <linux-kernel+bounces-89742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C2286F4F2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C588281D5C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF353C2E9;
	Sun,  3 Mar 2024 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="er9iBUNq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF747C126
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709471034; cv=none; b=qMgGPuhK7gE1aca9gadcZe6UIS+ZnJYeQYprwUO/PL7+WUO6mHiLeH7ixu8VRtTM4F39B9FhFRY287evsSX19uxNeXy87Vbp1R+cun5KmJFycAnEfNn6N3kU0lcyXR/rXLT1ZiZKgn+TAXAvFipVuelAGLp7uLnZdHtlGXqcRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709471034; c=relaxed/simple;
	bh=UdEabIOMuGXimUOBjIwbGvb/JTJ673funtWnezzpM9s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IZ+DzJK1zTPlYviQ1hjbMuthyACblwJorHnfb8aiXVFefVHCm0IJyaE2yuzHRV9/jryVlqKqnswbFal2U6htHR62Yxr7xsUhgM6JUxZ1chudanYfmWLFae5cwH+QeDfm7Ov5T/zNsent9solrlWmbqcNp/YxR1E+AtF/w95WasM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=er9iBUNq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709471032; x=1741007032;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UdEabIOMuGXimUOBjIwbGvb/JTJ673funtWnezzpM9s=;
  b=er9iBUNqTZ0/lsyQcG8+J/tvgAWQFyx5UqDfAZBNLillLJy722cTmqH6
   JxSdOV/bgrtaL9KQd1QN/ANRSkXbkk148zm/D7Xe4+JGg8ejazz7DoX+T
   ff7P2b6PhZcTmTePDqhJelmDUlwDl6bRtxo1mEbGVyUm+vIs/NHyGWZAA
   LhDwEfs1B/JjTDbSoB2SYmuYreF8IFqxMvH0Vc3735okKAIvnwHJGFaB+
   V9azhpmr9yjy8zPcGoQJbWVTqIq/ynlzDwccfdX5Ir1G4zKO+4gfVHupT
   neQ4e/yRndj6GgtectvCK4ugFgQxAxMTMNvm+uF63KULS3nh+/5p7Fytx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11001"; a="4130872"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="4130872"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 05:03:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="13399775"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 03 Mar 2024 05:03:48 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rglVJ-0001m4-27;
	Sun, 03 Mar 2024 13:03:45 +0000
Date: Sun, 3 Mar 2024 21:02:50 +0800
From: kernel test robot <lkp@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: "strcpy" [net/dsa/dsa_core.ko] has no CRC!
Message-ID: <202403032017.GWhmSRWd-lkp@intel.com>
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
commit: 9538ebce88ffa074202d592d468521995cb1e714 net: dsa: add trace points for FDB/MDB operations
date:   11 months ago
config: alpha-randconfig-r014-20221225 (https://download.01.org/0day-ci/archive/20240303/202403032017.GWhmSRWd-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240303/202403032017.GWhmSRWd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403032017.GWhmSRWd-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

Is "strcat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncpy" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncpy" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "strncat" [vmlinux] version generation failed, symbol will not be versioned.
Is "strncat" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "strcat" [fs/dlm/dlm.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/ext4/ext4.ko] has no CRC!
WARNING: modpost: "strncpy" [fs/ext4/ext4.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "strcat" [fs/overlayfs/overlay.ko] has no CRC!
WARNING: modpost: "strncpy" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/ocfs2/ocfs2.ko] has no CRC!
WARNING: modpost: "strncpy" [fs/ocfs2/ocfs2.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/ocfs2/ocfs2_stackglue.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/ocfs2/cluster/ocfs2_nodemanager.ko] has no CRC!
WARNING: modpost: "strcpy" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/backlight/backlight.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/pm2fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/matrox/matroxfb_base.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/matrox/matroxfb_crtc2.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/neofb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/vt8623fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/sm501fb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/mb862xx/mb862xxfb.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/video/fbdev/ocfb.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/tty/n_gsm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/char/tpm/tpm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/hisilicon/hibmc/hibmc-drm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/drm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/radeon/radeon.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/mgag200/mgag200.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/nouveau/nouveau.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/nouveau/nouveau.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/gpu/drm/ast/ast.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/gpu/drm/virtio/virtio-gpu.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/misc/eeprom/idt_89hpesx.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/misc/cb710/cb710.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/nfc/s3fwrn5/s3fwrn5.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/scsi_transport_fc.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/scsi/sd_mod.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/mdio/mdio-gpio.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/brocade/bna/bna.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/brocade/bna/bna.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/chelsio/cxgb3/cxgb3.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/mellanox/mlx4/mlx4_core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/mellanox/mlx4/mlx4_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/mellanox/mlx4/mlx4_en.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "strncat" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/intel/ipw2x00/ipw2200.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/wireless/intel/ipw2x00/ipw2200.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/marvell/mwifiex/mwifiex.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/marvell/mwifiex/mwifiex_pcie.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/wireless/marvell/mwl8k.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/can/sja1000/peak_pci.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/dsa/qca/qca8k.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/dsa/mt7530.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/net/dsa/lan9303-core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/net/plip/plip.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/message/fusion/mptbase.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/message/fusion/mptbase.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/message/fusion/mptsas.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i2c/busses/i2c-designware-core.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/i2c/busses/i2c-taos-evm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/power/supply/bq2415x_charger.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/adt7475.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/nct7802.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/hwmon/thmc50.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/watchdog/pcwd.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/leds/leds-lm3530.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/leds/leds-lp3952.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/hid/uhid.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/iio/adc/mcp3422.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mtd/parsers/redboot.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mtd/devices/block2mtd.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mtd/tests/mtd_pagetest.ko] has no CRC!
WARNING: modpost: "strncpy" [drivers/mtd/sm_ftl.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/mtd/ubi/ubi.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/w1/slaves/w1_therm.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "strcat" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/w1/wire.ko] has no CRC!
WARNING: modpost: "strcpy" [drivers/fpga/fpga-mgr.ko] has no CRC!
WARNING: modpost: "strcpy" [net/core/pktgen.ko] has no CRC!
WARNING: modpost: "strncpy" [net/netfilter/nft_fib.ko] has no CRC!
WARNING: modpost: "strncpy" [net/netfilter/ipset/ip_set.ko] has no CRC!
WARNING: modpost: "strncpy" [net/ipv4/netfilter/ip_tables.ko] has no CRC!
WARNING: modpost: "strcpy" [net/ipv4/netfilter/ip_tables.ko] has no CRC!
WARNING: modpost: "strncpy" [net/ipv6/netfilter/ip6_tables.ko] has no CRC!
WARNING: modpost: "strcpy" [net/ipv6/netfilter/ip6_tables.ko] has no CRC!
WARNING: modpost: "strcpy" [net/ipv6/ipv6.ko] has no CRC!
WARNING: modpost: "strcpy" [net/ipv6/sit.ko] has no CRC!
WARNING: modpost: "strcpy" [net/ipv6/ip6_tunnel.ko] has no CRC!
>> WARNING: modpost: "strcpy" [net/dsa/dsa_core.ko] has no CRC!
WARNING: modpost: "strncpy" [net/dsa/dsa_core.ko] has no CRC!
WARNING: modpost: "strcpy" [net/wireless/cfg80211.ko] has no CRC!
WARNING: modpost: "strncpy" [net/caif/chnl_net.ko] has no CRC!
WARNING: modpost: "strcpy" [net/can/can-bcm.ko] has no CRC!
WARNING: modpost: "strcpy" [net/rxrpc/rxrpc.ko] has no CRC!
WARNING: modpost: "strcpy" [net/tipc/tipc.ko] has no CRC!
WARNING: modpost: "strncpy" [net/tipc/tipc.ko] has no CRC!
WARNING: modpost: "strcpy" [net/9p/9pnet_fd.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

