Return-Path: <linux-kernel+bounces-71976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C20285AD54
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B021C1F21EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631253E30;
	Mon, 19 Feb 2024 20:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iGSaUt2T"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2B524BC;
	Mon, 19 Feb 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375265; cv=none; b=KUddflvpGt7IipK8l2KvWRG3iHCpi+BDvURkrPDTYzpetOI52hzI8Ne82v/sfBdRM24R67DiAjeGjxCakWroK9OnZDzW+YfYjrcKUEXOx15qwwW7LXpMUllTirJB4dF7BxaoW+DtkV4INQx/mqK7woBtxvsSJEdEsCVOdMQco3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375265; c=relaxed/simple;
	bh=ifk9qoz61SS5HWbaj1PxTuMj6QRxQZ/FYplg3zXL68U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=omBwxor3kHlD3rismeDGp/WtpJon9jAmmJzysFmXlGoe/rlNiRnny879gzizGNTkz9Djx0J3N71lot7tiLgNyfyldP/7iyhI6MUwOcQEPtCQuPm9TkFljYtk1UyGPgsquy5p10whx/Y/WUzVK6Uv/tbOrmZj0+GLGlaTQRCOWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iGSaUt2T; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 231CEC003ABD;
	Mon, 19 Feb 2024 12:40:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 231CEC003ABD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1708375257;
	bh=ifk9qoz61SS5HWbaj1PxTuMj6QRxQZ/FYplg3zXL68U=;
	h=From:To:Cc:Subject:Date:From;
	b=iGSaUt2T17kF4xyZzLWA5UpegDxXCgtO/Om4/0GzFu80L56tDpFnNAHrD4I17AR1w
	 /1LKqNdmsrEcdgQuJu1DWqHU4a7Vn4wnbK5FuTbjynUCnIgfTOerFlxrNx3jbBlltC
	 So4wa0GYCMWwzxbuph4dO8jkqDPtNoczdBeapEBo=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 81FC118041CAC4;
	Mon, 19 Feb 2024 12:40:55 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 0/3] Rework GENET MDIO controller clocking
Date: Mon, 19 Feb 2024 12:40:50 -0800
Message-Id: <20240219204053.471825-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series reworks the way that we manage the GENET MDIO
controller clocks around I/O accesses. During testing with a fully
modular build where bcmgenet, mdio-bcm-unimac, and the Broadcom PHY
driver (broadcom) are all loaded as modules, with no particular care
being taken to order them to mimize deferred probing the following bus
error was obtained:

[    4.344831] printk: console [ttyS0] enabled
[    4.351102] 840d000.serial: ttyS1 at MMIO 0x840d000 (irq = 29, base_baud = 5062500) is a Broadcom BCM7271 UART
[    4.363110] 840e000.serial: ttyS2 at MMIO 0x840e000 (irq = 30, base_baud = 5062500) is a Broadcom BCM7271 UART
[    4.387392] iproc-rng200 8402000.rng: hwrng registered
[    4.398012] Consider using thermal netlink events interface
[    4.403717] brcmstb_thermal a581500.thermal: registered AVS TMON of-sensor driver
[    4.440085] bcmgenet 8f00000.ethernet: GENET 5.0 EPHY: 0x0000
[    4.482526] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
[    4.514019] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    4.551304] SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
[    4.551324] CPU: 2 PID: 8 Comm: kworker/u8:0 Not tainted 6.1.53-0.1pre-g5a26d98e908c #2
[    4.551330] Hardware name: BCM972180HB_V20 (DT)
[    4.551336] Workqueue: events_unbound deferred_probe_work_func
[    4.551363] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.551368] pc : el1_abort+0x2c/0x58
[    4.551376] lr : el1_abort+0x20/0x58
[    4.551379] sp : ffffffc00a383960
[    4.551380] x29: ffffffc00a383960 x28: ffffff80029fd780 x27: 0000000000000000
[    4.551385] x26: 0000000000000000 x25: ffffff8002839005 x24: ffffffc00a1f9bd0
[    4.551390] x23: 0000000040000005 x22: ffffffc000a48084 x21: ffffffc00a3dde14
[    4.551394] x20: 0000000096000210 x19: ffffffc00a3839a0 x18: 0000000000000579
[    4.551399] x17: 0000000000000000 x16: 0000000100000000 x15: ffffffc00a3838c0
[    4.551403] x14: 000000000000000a x13: 6e69622f7273752f x12: 3a6e6962732f7273
[    4.551408] x11: 752f3a6e69622f3a x10: 6e6962732f3d4854 x9 : ffffffc0086466a8
[    4.551412] x8 : ffffff80049ee100 x7 : ffffff8003231938 x6 : 0000000000000000
[    4.551416] x5 : 0000002200000000 x4 : ffffffc00a3839a0 x3 : 0000002000000000
[    4.551420] x2 : 0000000000000025 x1 : 0000000096000210 x0 : 0000000000000000
[    4.551429] Kernel panic - not syncing: Asynchronous SError Interrupt
[    4.551432] CPU: 2 PID: 8 Comm: kworker/u8:0 Not tainted 6.1.53-0.1pre-g5a26d98e908c #2
[    4.551435] Hardware name: BCM972180HB_V20 (DT)
[    4.551437] Workqueue: events_unbound deferred_probe_work_func
[    4.551443] Call trace:
[    4.551445]  dump_backtrace+0xe4/0x124
[    4.551452]  show_stack+0x1c/0x28
[    4.551455]  dump_stack_lvl+0x60/0x78
[    4.551462]  dump_stack+0x14/0x2c
[    4.551467]  panic+0x134/0x304
[    4.551472]  nmi_panic+0x50/0x70
[    4.551480]  arm64_serror_panic+0x70/0x7c
[    4.551484]  do_serror+0x2c/0x5c
[    4.551487]  el1h_64_error_handler+0x2c/0x40
[    4.551491]  el1h_64_error+0x64/0x68
[    4.551496]  el1_abort+0x2c/0x58
[    4.551499]  el1h_64_sync_handler+0x8c/0xb4
[    4.551502]  el1h_64_sync+0x64/0x68
[    4.551505]  unimac_mdio_readl.isra.0+0x4/0xc [mdio_bcm_unimac]
[    4.551519]  __mdiobus_read+0x2c/0x88
[    4.551526]  mdiobus_read+0x40/0x60
[    4.551530]  phy_read+0x18/0x20
[    4.551534]  bcm_phy_config_intr+0x20/0x84
[    4.551537]  phy_disable_interrupts+0x2c/0x3c
[    4.551543]  phy_probe+0x80/0x1b0
[    4.551545]  really_probe+0x1b8/0x390
[    4.551550]  __driver_probe_device+0x134/0x14c
[    4.551554]  driver_probe_device+0x40/0xf8
[    4.551559]  __device_attach_driver+0x108/0x11c
[    4.551563]  bus_for_each_drv+0xa4/0xcc
[    4.551567]  __device_attach+0xdc/0x190
[    4.551571]  device_initial_probe+0x18/0x20
[    4.551575]  bus_probe_device+0x34/0x94
[    4.551579]  deferred_probe_work_func+0xd4/0xe8
[    4.551583]  process_one_work+0x1ac/0x25c
[    4.551590]  worker_thread+0x1f4/0x260
[    4.551595]  kthread+0xc0/0xd0
[    4.551600]  ret_from_fork+0x10/0x20
[    4.551608] SMP: stopping secondary CPUs
[    4.551617] Kernel Offset: disabled
[    4.551619] CPU features: 0x00000,00c00080,0000420b
[    4.551622] Memory Limit: none
[    4.833838] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

The issue here is that we managed to probe the GENET controller, the
mdio-bcm-unimac MDIO controller, but the PHY was still being held in a
probe deferral state because it depended upon a GPIO controller provider
not loaded yet. As soon as that provider is loaded however, the PHY
continues to probe, tries to disable the interrupts, and this causes a
MDIO transaction. That MDIO transaction requires I/O register accesses
within the GENET's larger block, and since its clocks are turned off,
the CPU gets a bus error signaled as a System Error.

The patch series takes the simplest approach of keeping the clocks
enabled just for the duration of the I/O accesses. This is also
beneficial to other drivers like bcmasp2 which make use of the same MDIO
controller driver.

Changes in v2:

- added missing ret assignment in the if (IS_ERR(priv->clk)) branch

- added Jacob's R-by tags

- corrected the commit ID being reverted in patch #3

Florian Fainelli (3):
  net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses
  net: bcmgenet: Pass "main" clock down to the MDIO driver
  Revert "net: bcmgenet: Ensure MDIO unregistration has clocks enabled"

 drivers/net/ethernet/broadcom/genet/bcmmii.c  |  6 +-
 drivers/net/mdio/mdio-bcm-unimac.c            | 93 ++++++++++---------
 include/linux/platform_data/mdio-bcm-unimac.h |  3 +
 3 files changed, 57 insertions(+), 45 deletions(-)

-- 
2.34.1


