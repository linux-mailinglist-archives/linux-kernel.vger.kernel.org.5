Return-Path: <linux-kernel+bounces-104736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F22587D2EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E7BB21464
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131BE4B5A6;
	Fri, 15 Mar 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccFmpgk4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA9947A67
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524304; cv=none; b=pJywiGcI+Pf+fi92a2JsgGZVzpTVHDcxmE9k3bvIPa2mKzII8CsaIpj0H+cHv3V1bWCkWsacaRyhzf6KZvA4Tb46u9twlIAhqYgP1U3UFry+kkiHA/uiQu8JxRtnAaTF7sI6DcLogAXodxfXXh4+b7HYLG2q4YHCqGsat4XQ1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524304; c=relaxed/simple;
	bh=wabM9zuNvfEiCQjjHB/kxoHasp3SoqAgjhkF6HWdxig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lsOeLV5YC9aLvHF0gl9ea8SvoHbpTdw1fd6PV+FoLPJFN6xU9MnWlQfsEPAMUMhGsiyTUf/jB9t3OXXPZBKWzXXZj5DEFYfWL8y44S4yeokv4FwlufZP/Cn9g2Q5QNobJZU6hndTtVfPYO32O6ut9jb+tOx2CNhdApVzFqTQsaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccFmpgk4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710524302; x=1742060302;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wabM9zuNvfEiCQjjHB/kxoHasp3SoqAgjhkF6HWdxig=;
  b=ccFmpgk4R00tVikiWRFAQhCv38a9A/mC5JWjDNVhL3B1Uq/x8kMpxKGB
   aT8huqvkDBjMrPXd/8cVPr0cvEoIh5T9cz7Hieolv1LIBjrtvhxdHUZC0
   o7e1k8VTCzabxrfyjAChIxusXMAP+4wYoRghLbLG7AnWZaQUw3yn2d4WE
   OVwnl1611fuz0aruo1YcJ2FaG/zqNTQFM5B1D5nS0eDcVa32c1aBvJ5IF
   FNNub9wq9ewWkt+efCpkp4eGmNiP+QnIQnRL8wMqJdO7V6YKhkgIbwFrE
   NTmSr7eOLOrGr/Vq74UC1HAyGtkPRtqC6rQblmzmwlukuxwTZE4qysNLe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="16859569"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="16859569"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 10:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="17212270"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 15 Mar 2024 10:38:18 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlBVY-000EgJ-1F;
	Fri, 15 Mar 2024 17:38:16 +0000
Date: Sat, 16 Mar 2024 01:38:06 +0800
From: kernel test robot <lkp@intel.com>
To: Martin Kaiser <martin@kaiser.cx>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: WARNING: modpost: "__udelay" [drivers/char/hw_random/st-rng.ko] has
 no CRC!
Message-ID: <202403160155.ZCSzy9QI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Martin,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5eb28f6d1afebed4bb7d740a797d0390bd3a357
commit: afa9d00ee0fda2387ad598d0b106e96a7ed360ae hwrng: st - support compile-testing
date:   9 months ago
config: sparc-randconfig-r051-20240309 (https://download.01.org/0day-ci/archive/20240316/202403160155.ZCSzy9QI-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240316/202403160155.ZCSzy9QI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403160155.ZCSzy9QI-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

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
WARNING: modpost: "__udelay" [kernel/rcu/rcuscale.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__udelay" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/xfs/xfs.ko] has no CRC!
WARNING: modpost: "__ashldi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "empty_zero_page" [lib/crypto/libchacha20poly1305.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [lib/test_scanf.ko] has no CRC!
WARNING: modpost: "__udelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ndelay" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/amlogic/phy-meson-axg-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/broadcom/phy-brcm-sata.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/phy/cadence/phy-cadence-torrent.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/cadence/phy-cadence-salvo.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/mediatek/phy-mtk-mipi-dsi-drv.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/ralink/phy-ralink-usb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/rockchip/phy-rockchip-typec.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/phy/sunplus/phy-sunplus-usb2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pinctrl/bcm/pinctrl-bcm2835.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/dwc/pci-meson.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/pci-aardvark.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/pcie-mediatek.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/pci/controller/pcie-brcmstb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/core/fb_ddc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cyber2000fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/matrox/matroxfb_DAC1064.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/riva/rivafb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/aty/aty128fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/neofb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s3fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/cirrusfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/s1d13xxxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/carminefb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/mb862xx/mb862xxfb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/video/fbdev/da8xx-fb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/sprd/clk-sprd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/sunxi-ng/sunxi-ccu.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/clk/clk-cs2000-cp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/mediatek/mtk-cqdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/xilinx/xilinx_dpdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/altera-msgdma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/idma64.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/dma/tegra210-adma.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/soc/qcom/qcom_rpmh.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/regulator/ti-abb-regulator.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/reset/reset-berlin.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/reset/reset-imx7.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/ba431-rng.ko] has no CRC!
>> WARNING: modpost: "__udelay" [drivers/char/hw_random/st-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/stm32-rng.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/char/hw_random/mtk-rng.ko] has no CRC!
ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!
WARNING: modpost: "__udelay" [drivers/parport/parport_pc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/altera-stapl/altera-stapl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/misc/dw-xdata-pcie.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/ene-kb3930.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/axp20x.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/si476x-core.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/ssbi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/atmel-hlcdc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/rn5t618.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/mfd/acer-ec-a500.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/arcmsr/arcmsr.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/aacraid/aacraid.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/aic94xx/aic94xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/fdomain.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/qla1280.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/scsi/qla2xxx/qla2xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/bfa/bfa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/dmx3191d.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/esp_scsi.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/am53c974.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/megaraid.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/mpt3sas/mpt3sas.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/sun_esp.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/myrb.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/ppa.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/imm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/stex.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/scsi/mvumi.ko] has no CRC!
WARNING: modpost: "__lshrdi3" [drivers/scsi/sd_mod.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/bcm7xxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/phy/icplus.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-ipq4019.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-moxart.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-mux-meson-g12a.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/mdio/mdio-mux-meson-gxl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/c_can/c_can.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/c_can/c_can_platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/flexcan/flexcan.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/can/m_can/m_can.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/adaptec/starfire.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/aquantia/atlantic/atlantic.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/atheros/atlx/atl1.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/atheros/atlx/atl2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/atheros/atl1c/atl1c.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/chelsio/cxgb3/cxgb3.ko] has no CRC!
WARNING: modpost: "__ashldi3" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/cisco/enic/enic.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/emulex/benet/be2net.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/freescale/gianfar_driver.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/hisilicon/hns/hns_dsaf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/mv643xx_eth.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/mvneta.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/skge.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/marvell/sky2.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/smsc/smsc9420.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/altera/altera_tse.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/net/ethernet/dnet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/ethernet/korina.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/arcnet.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/com90xx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/com90io.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/arcnet/com20020.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/net/fddi/defxx.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/firewire/firewire-ohci.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/hd44780.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/auxdisplay/lcd2s.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/phy/phy-am335x-control.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/cdns3/cdns-usb-common.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-platform.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/oxu210hp-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/isp1362-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/xhci-pci-renesas.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/host/r8a66597-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/r8a66597-hcd.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ehci-fsl.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/host/ssb-hcd.ko] has no CRC!
WARNING: modpost: "__ndelay" [drivers/usb/c67x00/c67x00.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/misc/onboard_usb_hub.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/chipidea/ci_hdrc.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/chipidea/ci_hdrc_msm.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/chipidea/ci_hdrc_tegra.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/renesas_usbhs/renesas_usbhs.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/renesas_usb3.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/renesas_usbf.ko] has no CRC!
WARNING: modpost: "__udelay" [drivers/usb/gadget/udc/mv_udc.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

