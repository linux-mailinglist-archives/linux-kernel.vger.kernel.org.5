Return-Path: <linux-kernel+bounces-99450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3F6878886
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81086284FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA07254F83;
	Mon, 11 Mar 2024 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmviCdjD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60454BE4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184319; cv=none; b=XTQGy/Qp7vyGpF30pl52pfCBC0MvWz0Mk4ljgKxe+C+vXgjrJ+wHiCDayFV0g+Uo+NVv1qCh3WDzopUMS9CxdLrZrLAgNh1uiVrUBz0+zPaGDOfPuBwz2KVWoL3pbs+2ijmR0wV9bg3++Qi6Ohta1NsHOLXctXqCViRhy+vLRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184319; c=relaxed/simple;
	bh=7hYuVl4h7nXnFmVyrCsoLYSn1d8tMpOx3MRZzchbHnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gvW6/gGZul1JIPUYgOk60jW9SQPqRPnIGi46qCQqavCQ6D8T+dpjTk0c2aYYd0KpPERQu+yi0UWxirLVhcFvgJOvCGUXjSdpy1QUMPxgj90qOv/6zwDrNNF0k8+SRKgWlYlTOSASIjq8kctOmULNAlcLXNzqEU6vZsD+FoGqTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmviCdjD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710184318; x=1741720318;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7hYuVl4h7nXnFmVyrCsoLYSn1d8tMpOx3MRZzchbHnE=;
  b=MmviCdjDJzt56ynd/FjdhkUTH/dn6dmhc1Ul7K8HNf2v7UXMMZPqE4wl
   vlrkh8xarNbh9iQwTAmg+oPi2j+NE0r6dnG9Py+vHbRkWTSVf0OeidKiB
   HC2HQ9WELlbVesJtZYT7zUh8yIeodzfAy91Mhzku30eIB1X4FYxIeM0MK
   VI6ea8GUueMa+dk7OSw8oTKfLpeGj7ilvQFAyZe90ef7UCSsUfaCdM6jI
   +a9rRkj1NShCrsZAOjvXm1lFD6E6WGuhipg21eVFSCNzM1Hu8uUvO/1ho
   k7mDp5uCnNKYTeOA4YNhfr4dYqVNhyzFN2ADMGtdrril0AW+nPZKd57Af
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8684299"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="8684299"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 12:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11334758"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Mar 2024 12:11:54 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjl3w-0009O1-2b;
	Mon, 11 Mar 2024 19:11:52 +0000
Date: Tue, 12 Mar 2024 03:11:11 +0800
From: kernel test robot <lkp@intel.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Petr Machata <petrm@nvidia.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	Simon Horman <simon.horman@corigine.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: WARNING: modpost: "__ashldi3" [net/netfilter/nf_tables.ko] has no
 CRC!
Message-ID: <202403120305.KdTgNyMb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ratheesh,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8f897f4afef0031fe618a8e94127a0934896aba
commit: 2b3082c6ef3b0104d822f6f18d2afbe5fc9a5c2c net: flow_dissector: Use 64bits for used_keys
date:   7 months ago
config: sparc-buildonly-randconfig-r004-20220113 (https://download.01.org/0day-ci/archive/20240312/202403120305.KdTgNyMb-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240312/202403120305.KdTgNyMb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403120305.KdTgNyMb-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "__udelay" [drivers/leds/flash/leds-rt8515.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/extcon/extcon-fsa9480.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/ntb/hw/epf/ntb_hw_epf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/xilinx-spi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fsi/fsi-master-hub.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/rapidio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/switches/idt_gen3.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/ata/libata.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/libata.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/ata/libata.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/ata/libata.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/ata/libahci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/libahci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/sata_mv.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/ata/sata_nv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/sata_nv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/sata_promise.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/sata_svw.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/sata_vsc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/pata_hpt37x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/pata_ns87415.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/pata_via.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/pata_sl82c105.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/pata_legacy.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0001.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/chips/cfi_cmdset_0001.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/qinfo_probe.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/devices/phram.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/mtd/nand/onenand/onenand.ko] has no CRC!
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
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/cadence-nand-controller.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtd.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtd_blkdevs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/mtdswap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/comedi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/dt3000.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/gsc_hpdi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/icp_multi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/jr3_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/cb_pcidas64.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/comedi/drivers/ni_660x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/ni_pcimio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/comedi/drivers/s626.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/adc/ad7192.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad7476.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/ad7606.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/adc/ad7793.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/adc/ad7793.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad7949.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad9467.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/adc/ad9467.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/adi-axi-adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/max1241.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/adc/nau7802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/nau7802.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/adc/ti-ads1015.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads8344.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads131e08.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/afe/iio-rescale.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/iio/common/hid-sensors/hid-sensor-iio-common.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/iio/common/ms_sensors/ms_sensors_i2c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/ad5592r-base.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/ad5755.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/dac/ad5766.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/iio/dac/dpot-dac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/gyro/itg3200.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/frequency/ad9523.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/as3935.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/ping.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/resolver/ad2s1200.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/iio/industrialio.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/thunderbolt/thunderbolt.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/thunderbolt/thunderbolt.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/siox/siox-bus-gpio.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [net/sched/act_police.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [net/sched/sch_gred.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [net/sched/sch_sfq.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [net/sched/sch_tbf.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [net/sched/sch_cake.ko] has no CRC!
>> WARNING: modpost: "__ashldi3" [net/netfilter/nf_tables.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [net/netfilter/xt_cluster.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [net/wireless/cfg80211.ko] has no CRC!
WARNING: modpost: "__ashldi3" [net/rxrpc/rxrpc.ko] has no CRC!
WARNING: modpost: "__ashldi3" [net/rds/rds.ko] has no CRC!
WARNING: modpost: "__ashldi3" [net/tipc/tipc.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [net/tipc/tipc.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [net/ceph/libceph.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

