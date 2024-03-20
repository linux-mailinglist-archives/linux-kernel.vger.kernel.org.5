Return-Path: <linux-kernel+bounces-108460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A72C880ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D9F1C2136F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7BA156E4;
	Wed, 20 Mar 2024 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hABomN/S"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23D14296
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710913866; cv=none; b=UIa1doO6VzxZoc1TZsT1uM5OhUvn3wdFfNqx/cvEVg2lX9XUZtCxhkgT89R3LIBma24zj+NDtFkp5HZvVMsiwTZhddz1YkuxDASth3cSWAYDPLVFOBSxVTK7pUfwKfXGq4gqsXb63DuVuxjnliEJBpyFf7Xh+/JHDFGNZxxXtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710913866; c=relaxed/simple;
	bh=wBromfwoqJcopLxYMpXREwGzbQU9imjyvJCwk6l4edI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S+FQ+N72mw3/kGjUX4HovyKzyTnBJMDWdW5N3X7x87+JlmRaWTQAtd2oXPqJPG6wtglblic3oYf0WkBSZAvYtVx+HttKSivpEApUn7yhB+Rncp4sUJxx0VpUt3Ig9br9xUyHKD8NReUF93zxE68IgIqWRwgXR4mSi+1PJoTys24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hABomN/S; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710913864; x=1742449864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wBromfwoqJcopLxYMpXREwGzbQU9imjyvJCwk6l4edI=;
  b=hABomN/SlPqZvWp6G9l9zNnGChPIdtPafSt99qNx2yY2GgHlWcKwzZkT
   IIb0EWBujW4CBVgieTPQTU2mdq3euzyl2ZobIEyqp8r/xOMqurJS6662O
   jxJpCKhW9nUmd5uceTeqimj4mJ4ihaVw9xeCYOa1wSUjkLLxsqtgRTFEq
   LS3J2meXBRcJzfkohflSLVSzjCtaGd0N2I3gauZwR5wV1Pr5kFq2RGqiS
   u9bSZ3keL102H8cv/7gMtj+OmY/oX02BGvbO9hL+Wx5TKjN/pvPZL8/hc
   mQh2IMywzm1dPbZq338fWU5+3a++WXeZZikPGFuxORCItY9rBsWZWAnse
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="23321628"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="23321628"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 22:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="14070013"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Mar 2024 22:51:01 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmoqn-000INn-2V;
	Wed, 20 Mar 2024 05:50:57 +0000
Date: Wed, 20 Mar 2024 13:50:01 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: WARNING: modpost: "__udelay"
 [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
Message-ID: <202403201308.YKe7Vkt2-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Leon,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4145ce1e7bc247fd6f2846e8699473448717b37
commit: a128f9d4c1227dfcf7f2328070760cb7ed1ec08d net/mlx5e: Fix scheduling of IPsec ASO query while in atomic
date:   9 months ago
config: sparc-randconfig-r053-20240101 (https://download.01.org/0day-ci/archive/20240320/202403201308.YKe7Vkt2-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240320/202403201308.YKe7Vkt2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403201308.YKe7Vkt2-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: vmlinux.o: section mismatch in reference: leon_pci_init (section: .text) -> pci_assign_unassigned_resources (section: .init.text)
WARNING: modpost: vmlinux.o: section mismatch in reference: grpci2_of_driver (section: .data) -> grpci2_of_match (section: .init.rodata)
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
WARNING: modpost: "__udelay" [kernel/scftorture.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/ocfs2/ocfs2.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/ocfs2/ocfs2.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/gfs2/gfs2.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [security/keys/encrypted-keys/encrypted-keys.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-kona-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/cadence/phy-cadence-salvo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/gpio/gpio-pisosr.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/switches/idt_gen2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/switches/idt_gen3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/vt8623fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/ssd1307fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/lp.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/misc/eeprom/eeprom_93cx6.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/misc/eeprom/eeprom_93xx46.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/eeprom/eeprom_93xx46.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/hpilo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/c2port/core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/altera-stapl/altera-stapl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/aic7xxx/aic7xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/aic7xxx/aic79xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/pm8001/pm80xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/fdomain.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/qla4xxx/qla4xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/bfa/bfa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/csiostor/csiostor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/sym53c8xx_2/sym53c8xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/esp_scsi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/am53c974.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/sun_esp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/a100u2w.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/myrb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/ipr.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/scsi/hptiop.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/be2iscsi/be2iscsi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/esas2r/esas2r.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/pdc_adma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/sata_mv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/pata_it821x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/pata_legacy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-loopback-test.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/spi/spi-lm70llp.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/mdio/mdio-bitbang.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-mscc-miim.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/3com/3c59x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/atheros/atl1c/atl1c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/b44.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/genet/genet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/bnx2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/cnic.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/bcmsysport.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/chelsio/cxgb/cxgb.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/dec/tulip/dmfe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/dec/tulip/de2104x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/emulex/benet/be2net.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/prestera/prestera.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/qlogic/netxen/netxen_nic.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/stmicro/stmmac/stmmac.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/wiznet/w5100.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/xilinx/ll_temac.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/ethernet/dnet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/jme.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/fddi/defxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/b53/b53_common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/bcm-sf2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/mt7530.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/dsa/vitesse-vsc73xx-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/ks0108.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/panel.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/lcd2s.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/m66592-udc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/gadget/udc/m66592-udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/mv_udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/dwc2/dwc2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/musb/musb_hdrc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/algos/i2c-algo-pca.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-amd8111.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/w1/masters/ds2482.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/masters/sgi_w1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/w1/slaves/w1_ds28e17.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/pcwd_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/da9052_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/da9063_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/gpio_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/isdn/hardware/mISDN/hfcpci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/isdn/hardware/mISDN/hfcmulti.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/isdn/hardware/mISDN/w6692.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ufs/core/ufshcd-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bcm6358.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bd2802.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-ktd2692.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-rt8515.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/crypto/hifn_795x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/crypto/hifn_795x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/rts5208/rts5208.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/staging/iio/impedance-analyzer/ad5933.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-ps-spi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/xilinx-spi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-pr-ip-core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/fsi/fsi-master-gpio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fsi/fsi-master-gpio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/parport/parport.ko] has no CRC!
ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!
WARNING: modpost: "__udelay" [drivers/input/serio/i8042.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/apbps2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/gameport/gameport.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [drivers/infiniband/core/ib_uverbs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad7476.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/ad7606.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ad7949.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/hi8435.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/max11410.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/max1241.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/palmas_gpadc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads7924.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/ti-ads124s08.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/ad5592r-base.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/dac/ad5755.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/dac/ad5766.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/gyro/itg3200.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/potentiometer/ad5272.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/pressure/dlhl60d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/resolver/ad2s1200.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/core/snd-timer.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/i2c/other/snd-ak4114.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/i2c/other/snd-ak4113.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/i2c/other/snd-ak4xxx-adda.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/drivers/snd-mtpav.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/drivers/opl3/snd-opl3-lib.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/drivers/mpu401/snd-mpu401-uart.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-ad1889.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-als300.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-atiixp.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-atiixp-modem.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-cmipci.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-cs4281.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-ens1370.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-ens1371.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-es1938.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-es1968.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-intel8x0m.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-maestro3.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-rme96.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/snd-via82xx.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/ac97/snd-ac97-codec.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/au88x0/snd-au8810.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/au88x0/snd-au8820.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/ctxfi/snd-ctxfi.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/ca0106/snd-ca0106.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/lx6464es/snd-lx6464es.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/echoaudio/snd-darla20.ko] has no CRC!
WARNING: modpost: "__udelay" [sound/pci/echoaudio/snd-layla20.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

