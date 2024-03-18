Return-Path: <linux-kernel+bounces-106583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4879187F0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B284E1F227B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A255730B;
	Mon, 18 Mar 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFyfxmNg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DFE57865
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791777; cv=none; b=Ki2ZxLcQfwneNe2HwDCLE0nexjoC0Vo+iD1DNUylSJBnKZjgGZl1ESEv5Gx0QBQFNzY3HNxhXhdxmIxOBc9qOx+emsydm2nQeoGxpYAz5EHi+5+puuxbF6ReemG3KAzBoQ2dBPPzJsZzNrIOrl6LCEK3t5aWa/G4g6T5qi8w9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791777; c=relaxed/simple;
	bh=mePIc5OGKwxP+/7c/3F34DqFDAJ8XJKSmChHMS6t32w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nhYfqMM2YH1AAPIV6Oi51rBzTfmh4upxUj2oggi5rPzSz/q8lP9I4Tvaw1KrdS1hre+nT99Sm4qULzZ/ttSSztYhrRLkJEBHIz28gZqchroFgcwL4OXvXSFHaZuKJ0E1JbmWeesvtHgG5Ted0k+Og7KFWrx8okA4YGCQzx+jYO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFyfxmNg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710791775; x=1742327775;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mePIc5OGKwxP+/7c/3F34DqFDAJ8XJKSmChHMS6t32w=;
  b=QFyfxmNgpzqQvHbjn/Ppidww972XNtHj64pa68IOVygX2dNxbxwUe1U4
   sYwgltzEG3Y0zjszfWoXB3XZMqZMPanrLQAl/7EYswm19nCLbsh9NC22I
   jWRmxB+8Ko+OUKlfNqjjCJnKpzO8APVTflrjuL14CCQVTULBWEDID3714
   F9IUNCpxAQXxTr2H36LOx/hY+2tRB3yCISNZaB04sV9mFCBLpD59uuKO+
   67ZGz/D3IGZAQfikTAk0Jgjt1iwQaU3iQxNVMPG7X1mA+teMMwFWMSyZW
   WT7bUo1s04eWOku59dcpmnd0Cj/kbzyc7sanMgsyFJHnk4iFQKhBc+dY2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5495137"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="5495137"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 12:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="13539123"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Mar 2024 12:56:12 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rmJ5e-000HDI-2Y;
	Mon, 18 Mar 2024 19:56:10 +0000
Date: Tue, 19 Mar 2024 03:56:05 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: "__ashldi3"
 [drivers/net/ethernet/mellanox/mlxsw/mlxsw_pci.ko] has no CRC!
Message-ID: <202403190316.Pi05st2q-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0a7b0acecea273c8816f4f5b0e189989470404cf
commit: 918327e9b7ffb45321cbb4b9b86b58ec555fe6b3 ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL
date:   6 weeks ago
config: sparc-randconfig-r013-20220805 (https://download.01.org/0day-ci/archive/20240319/202403190316.Pi05st2q-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240319/202403190316.Pi05st2q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403190316.Pi05st2q-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: "__ashrdi3" [fs/quota/quota_tree.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/binfmt_misc.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/jfs/jfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/gfs2/gfs2.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/f2fs/f2fs.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [fs/f2fs/f2fs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/f2fs/f2fs.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [lib/crypto/libchacha20poly1305.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/bus/mhi/host/mhi_pci_generic.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-bcm-kona-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/samsung/phy-exynos5-usbdrd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pwm/pwm-pca9685.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/dwc/pci-meson.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/switches/idt_gen3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/rapidio/rio-scan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/qcom_spmi-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_base.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/tty/serial/8250/8250_base.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_dw.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/8250/8250_tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sunzilog.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/rp2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/tty/serial/sifive.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/block/floppy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/block/mtip32xx/mtip32xx.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/misc/eeprom/eeprom_93cx6.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/cardreader/rtsx_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/hpilo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/axp20x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/aic7xxx/aic7xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/aacraid/aacraid.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/pm8001/pm80xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/fdomain.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/bfa/bfa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/csiostor/csiostor.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/dmx3191d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/sym53c8xx_2/sym53c8xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/esp_scsi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/am53c974.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/scsi/mpi3mr/mpi3mr.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/mpi3mr/mpi3mr.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/atp870u.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/sun_esp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/initio.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/a100u2w.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/myrb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/ipr.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/scsi/hptiop.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/stex.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/libiscsi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/be2iscsi/be2iscsi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/esas2r/esas2r.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/scsi/scsi_debug.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_util.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0002.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/chips/cfi_cmdset_0001.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/qinfo_probe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/lpddr/lpddr_cmds.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/cafe_nand.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/cafe_nand.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/ams-delta.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mtd/nand/raw/nandsim.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/mtd/nand/raw/gpio.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-ipq4019.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/3com/3c59x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/atheros/atlx/atl1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/dec/tulip/dmfe.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/dec/tulip/winbond-840.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/dec/tulip/de2104x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/dec/tulip/tulip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/dlink/dl2k.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/engleder/tsnep.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/ethernet/engleder/tsnep.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] has no CRC!
>> WARNING: modpost: "__ashldi3" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/natsemi/natsemi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/neterion/s2io.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/packetengines/hamachi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/realtek/r8169.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/sun/sungem.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/via/via-rhine.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/via/via-velocity.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/wiznet/w5100.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/wiznet/w5300.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/fealnx.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/net/ppp/ppp_async.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wan/wanxl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wan/pc300too.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/wwan/t7xx/mtk_t7xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/c_can/c_can.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/c_can/c_can_platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/flexcan/flexcan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/grcan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/fddi/defxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/plip/plip.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/sungem_phy.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/kaweth.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/lan78xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/asix.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/dm9601.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/sr9800.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/usb/smsc95xx.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/firewire/firewire-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/firewire/firewire-ohci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/oxu210hp-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/sl811-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-fsl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ssb-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/net2272.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/net2280.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/m66592-udc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/gadget/udc/m66592-udc.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/gadget/udc/r8a66597-udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/r8a66597-udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/pch_udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/mv_udc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/bdc/bdc.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/usb/gadget/function/usb_f_mass_storage.ko] has no CRC!
WARNING: modpost: "__ashrdi3" [drivers/usb/gadget/function/usb_f_mass_storage.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/dwc3/dwc3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/dwc3/dwc3-meson-g12a.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/dwc2/dwc2.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/c67x00/c67x00.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/musb/musb_hdrc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/i8042.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/serio/apbps2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/input/rmi4/rmi_core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/busses/i2c-amd8111.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca9541.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i2c/muxes/i2c-mux-pca954x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/dw-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/i3c/master/svc-i3c-master.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/mt20xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tuner-simple.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/tuners/tda18271.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/media/dvb-core/dvb-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ptp/ptp_idt82p33.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/pmbus/ucd9000.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/pmbus/zl6100.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/hwmon/powr1220.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/hwmon/sht15.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/dw_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/da9063_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/watchdog/gpio_wdt.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/isdn/hardware/mISDN/hfcmulti.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/isdn/hardware/mISDN/avmfritz.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/isdn/hardware/mISDN/avmfritz.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/isdn/hardware/mISDN/speedfax.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/isdn/hardware/mISDN/speedfax.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/isdn/hardware/mISDN/mISDNisar.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-pci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/cb710-mmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/toshsd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/rtsx_usb_sdmmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-cadence.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-of-dwcmshc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-omap.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/host/sdhci-xenon-driver.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mmc/core/pwrseq_emmc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ufs/core/ufshcd-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-mt6360.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/flash/leds-rt8515.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/leds/leds-bcm6358.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/accel/mma9551_core.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/ad7606.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/iio/adc/cc10001_adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/adc/cc10001_adc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/gyro/itg3200.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/iio/proximity/ping.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/fpga/altera-freeze-bridge.ko] has no CRC!
WARNING: modpost: "___rw_read_exit" [drivers/vdpa/vdpa_user/vduse.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/ata/libata.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

