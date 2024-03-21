Return-Path: <linux-kernel+bounces-110458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACCA885F36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1121C23C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE09136655;
	Thu, 21 Mar 2024 17:01:22 +0000 (UTC)
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98455135A71;
	Thu, 21 Mar 2024 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.229.23.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040481; cv=none; b=Hd+pAqeGvvOAU0Wo//Cguil8DUhYWgLHD6KYePJuqRLOKoX6sA0TMk/KDZdJ1w1WcgUQ8jlEdfwpGlkuO303dLqJEjBXxS5zSMBsE5xM6gI37A1SenzIMWfHhgXVUQ2Kbls32SDDc9gbk9PdK81tw7KA+ZBGg+K1X+uCThSVkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040481; c=relaxed/simple;
	bh=NjdCYzjubCfhlMPFrxBNJk0QJ3KZcuke0jwiS/KMkFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UUZLopL9xAvnxOGABQazUO6OBU30waf1d6ZRlzo8GbrRxkONkQRuEIB6GqscYWvDqFVtYS1F2fBiGde4e5prWNBN696/HnTl1J2n8F9grmD8WOp7d1gmykD/fk2m/dDo8mS3WVxpgA6EB6kbFtXdwo80hgDjdLMzPd899XCBGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk; spf=pass smtp.mailfrom=dudau.co.uk; arc=none smtp.client-ip=80.229.23.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dudau.co.uk
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
	by smtp.dudau.co.uk (Postfix) with SMTP id B878B4172F42;
	Thu, 21 Mar 2024 16:51:27 +0000 (GMT)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Thu, 21 Mar 2024 16:51:27 +0000
Date: Thu, 21 Mar 2024 16:51:27 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Haijun Liu <haijun.liu@mediatek.com>
Cc: Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: net: wwan: t7xx: BUG: Unaligned access when loading mtk_t7xx module
Message-ID: <Zfxlj3pYUk4ys47T@bart.dudau.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

I'm trying to use a Fibocom FM350-GL modem with a Quartzpro64 board based
on RK3588 using Linus' tip of the tree and I'm getting a memory alignment
fault when modprobe-ing the mtk_t7xx driver.

The exception happens in t7xx_cldma_hw_set_start_addr() as the virtual
address is not a 64bit address (ffff800085a1f00*4*). The same issue
seems to have been found by openwrt people a few days ago:

https://forum.openwrt.org/t/fibocom-fm350-gl-support/142682/67


Looking at the code I can see that the registers used for building the
virtual address use the START_ADDRL (low) macro, which is wrong (that
would be 32bit aligned, not 64bit). Except that ....

/* CLDMA TX */
#define REG_CLDMA_UL_START_ADDRL_0	0x0004
#define REG_CLDMA_UL_START_ADDRH_0	0x0008
#define REG_CLDMA_UL_CURRENT_ADDRL_0	0x0044
#define REG_CLDMA_UL_CURRENT_ADDRH_0	0x0048
[....]
#define REG_CLDMA_DL_START_ADDRL_0	0x0478
#define REG_CLDMA_DL_START_ADDRH_0	0x047c
#define REG_CLDMA_DL_CURRENT_ADDRL_0	0x04b8
#define REG_CLDMA_DL_CURRENT_ADDRH_0	0x04bc

There seems to be an unholy mess of register offsets. UL_START_ADDRL_0 is
at a 32bit offset, but DL_START_ADDRL_0 is at a 64bit offset.
UL_START_ADDRH_0 is at a 64bit offset, but DL_START_ADDRH_0 is not.

Given that all accesses to those registers are io{read,write}64(),
I question the need to have an High and Low register definition, so one of
these can be removed and offsets corrected by someone with access to the
documentation that gives correct information for the registers. I had a
go at guessing that UL registers are at 0x8 and 0x48 offsets and DL
registers are at 0x0478 and 0x04b8, but while that fixes the alignment
exception, I now get a "CLDMA{0,1} queue 0 is not empty" message.

For anyone trying to reproduce this: you first need to modify the
device tree to slightly reduce the 3rd MEM area so that BAR0 of the
root complex does not fit in and allocates all the available memory:

--8<-------------------------------------------------
diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
index 74e8ed4531f0d..75db20440a590 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
@@ -219,7 +219,7 @@ pcie3x4: pcie@fe150000 {
                power-domains = <&power RK3588_PD_PCIE>;
                ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>,
                         <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x00e00000>,
-                        <0x03000000 0x0 0x40000000 0x9 0x00000000 0x0 0x40000000>;
+                        <0x03000000 0x0 0x40000000 0x9 0x00000000 0x0 0x3fff0000>;
                reg = <0xa 0x40000000 0x0 0x00400000>,
                      <0x0 0xfe150000 0x0 0x00010000>,
                      <0x0 0xf0000000 0x0 0x00100000>;
--8<-------------------------------------------------

After reboot, "dmesg | grep -i pci" gives:

[    0.000000] Kernel command line: earlycon=uart8250,mmio32,0xfeb50000 rootwait root=/dev/mmcblk0p2 rw pci=realloc=on
[    0.011344] PCI/MSI: /interrupt-controller@fe600000/msi-controller@fe640000 domain created
[    0.011388] PCI/MSI: /interrupt-controller@fe600000/msi-controller@fe660000 domain created
[    0.119664] PCI: CLS 0 bytes, default 64
[    0.169966] pciehp: pcie_port_service_register = 0
[    0.488618] rockchip-dw-pcie a40000000.pcie: host bridge /pcie@fe150000 ranges:
[    0.489346] rockchip-dw-pcie a40000000.pcie: Parsing ranges property...
[    0.489368] rockchip-dw-pcie a40000000.pcie:       IO 0x00f0100000..0x00f01fffff -> 0x00f0100000
[    0.490173] rockchip-dw-pcie a40000000.pcie:      MEM 0x00f0200000..0x00f0ffffff -> 0x00f0200000
[    0.490970] rockchip-dw-pcie a40000000.pcie:      MEM 0x0900000000..0x093ffeffff -> 0x0040000000
[    0.499585] rockchip-dw-pcie a40000000.pcie: iATU: unroll T, 8 ob, 8 ib, align 64K, limit 8G
[    0.704878] rockchip-dw-pcie a40000000.pcie: PCIe Gen.3 x1 link up
[    0.705811] rockchip-dw-pcie a40000000.pcie: PCI host bridge to bus 0000:00
[    0.706451] pci_bus 0000:00: root bus resource [bus 00-0f]
[    0.706957] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xf0100000-0xf01fffff])
[    0.707814] pci_bus 0000:00: root bus resource [mem 0xf0200000-0xf0ffffff]
[    0.708437] pci_bus 0000:00: root bus resource [mem 0x900000000-0x93ffeffff] (bus address [0x40000000-0x7ffeffff])
[    0.709401] pci_bus 0000:00: scanning bus
[    0.709441] pci 0000:00:00.0: [1d87:3588] type 01 class 0x060400 PCIe Root Port
[    0.710114] pci 0000:00:00.0: BAR 0 flags 00040200 [mem 0x00000000-0x3fffffff]
[    0.710772] pci 0000:00:00.0: BAR 1 flags 00040200 [mem 0x00000000-0x3fffffff]
[    0.711428] pci 0000:00:00.0: ROM flags 00046200 [mem 0x00000000-0x0000ffff pref]
[    0.712105] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    0.712585] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    0.713157] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    0.713777] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    0.714529] pci 0000:00:00.0: supports D1 D2
[    0.714923] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    0.715448] pci 0000:00:00.0: PME# disabled
[    0.715717] pci 0000:00:00.0: vgaarb: pci_notify
[    0.722215] pci_bus 0000:00: fixups for bus
[    0.722231] pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 0
[    0.722335] pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-0f] (conflicts with (null) [bus 00-0f])
[    0.723310] pci_bus 0000:01: scanning bus
[    0.723398] pci 0000:01:00.0: [14c3:4d75] type 00 class 0x0d4000 PCIe Endpoint
[    0.724134] pci 0000:01:00.0: BAR 0 flags 0014220c [mem 0x00000000-0x00007fff 64bit pref]
[    0.724943] pci 0000:01:00.0: BAR 2 flags 00140204 [mem 0x00000000-0x007fffff 64bit]
[    0.725691] pci 0000:01:00.0: BAR 4 flags 0014220c [mem 0x00000000-0x007fffff 64bit pref]
[    0.726819] pci 0000:01:00.0: supports D1 D2
[    0.727212] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.727822] pci 0000:01:00.0: PME# disabled
[    0.728145] pci 0000:01:00.0: 7.876 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x1 link at 0000:00:00.0 (capable of 15.752 Gb/s with 8.0 GT/s PCIe x2 link)
[    0.729852] pci 0000:01:00.0: vgaarb: pci_notify
[    0.740863] pci_bus 0000:01: fixups for bus
[    0.740877] pci_bus 0000:01: bus scan returning with max=01
[    0.740893] pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 1
[    0.740907] pci_bus 0000:00: bus scan returning with max=ff
[    0.740934] pci 0000:00:00.0: BAR 0 [mem size 0x40000000]: can't assign; no space
[    0.741617] pci 0000:00:00.0: BAR 0 [mem size 0x40000000]: failed to assign
[    0.742248] pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: can't assign; no space
[    0.742923] pci 0000:00:00.0: BAR 1 [mem size 0x40000000]: failed to assign
[    0.743554] pci 0000:00:00.0: bridge window [mem 0xf0800000-0xf0ffffff]: assigned
[    0.744233] pci 0000:00:00.0: bridge window [mem 0x900000000-0x900bfffff 64bit pref]: assigned
[    0.745030] pci 0000:00:00.0: ROM [mem 0xf0200000-0xf020ffff pref]: assigned
[    0.745677] pci 0000:01:00.0: BAR 2 [mem 0xf0800000-0xf0ffffff 64bit]: assigned
[    0.746377] pci 0000:01:00.0: BAR 4 [mem 0x900000000-0x9007fffff 64bit pref]: assigned
[    0.747128] pci 0000:01:00.0: BAR 0 [mem 0x900800000-0x900807fff 64bit pref]: assigned
[    0.747879] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    0.748358] pci 0000:00:00.0:   bridge window [mem 0xf0800000-0xf0ffffff]
[    0.748990] pci 0000:00:00.0:   bridge window [mem 0x900000000-0x900bfffff 64bit pref]
[    0.749781] pcieport 0000:00:00.0: vgaarb: pci_notify
[    0.749936] pcieport 0000:00:00.0: assign IRQ: got 79
[    0.753110] pcieport 0000:00:00.0: PME: Signaling with IRQ 88
[    0.754465] pcieport 0000:00:00.0: AER: enabled with IRQ 89
[    0.755023] pcieport 0000:00:00.0: save config 0x00: 0x35881d87
[    0.755037] pcieport 0000:00:00.0: save config 0x04: 0x00100507
[    0.755048] pcieport 0000:00:00.0: save config 0x08: 0x06040001
[    0.755059] pcieport 0000:00:00.0: save config 0x0c: 0x00010000
[    0.755071] pcieport 0000:00:00.0: save config 0x10: 0x00000000
[    0.755081] pcieport 0000:00:00.0: save config 0x14: 0x00000000
[    0.755092] pcieport 0000:00:00.0: save config 0x18: 0x00ff0100
[    0.755103] pcieport 0000:00:00.0: save config 0x1c: 0x000000f0
[    0.755113] pcieport 0000:00:00.0: save config 0x20: 0xf0f0f080
[    0.755124] pcieport 0000:00:00.0: save config 0x24: 0x40b14001
[    0.755135] pcieport 0000:00:00.0: save config 0x28: 0x00000000
[    0.755145] pcieport 0000:00:00.0: save config 0x2c: 0x00000000
[    0.755156] pcieport 0000:00:00.0: save config 0x30: 0x00000000
[    0.755166] pcieport 0000:00:00.0: save config 0x34: 0x00000040
[    0.755177] pcieport 0000:00:00.0: save config 0x38: 0x00000000
[    0.755187] pcieport 0000:00:00.0: save config 0x3c: 0x0002014f
[    0.755225] pcieport 0000:00:00.0: vgaarb: pci_notify


Fibocom modem is on 0000:01:00.0

Crash happens at insmod time:

[root@quartzpro64 ~]# insmod ~dliviu/mtk_t7xx.ko
[  520.509674] mtk_t7xx 0000:01:00.0: enabling device (0000 -> 0002)
[  520.510272] mtk_t7xx 0000:01:00.0: requesting region 0 for 0000:01:00.0
[  520.510899] mtk_t7xx 0000:01:00.0: requesting region 2 for 0000:01:00.0
[  520.522717] (unnamed net_device) (dummy): netif_napi_add_weight() called with weight 128
[  520.531037] wwan wwan0: port wwan0fastboot0 attached
[  520.534022] wwan wwan0: port wwan0fastboot0 disconnected
[root@quartzpro64 ~]# [  520.543305] Unable to handle kernel paging request at virtual address ffff800085a1f004
[  520.544008] Mem abort info:
[  520.544256]   ESR = 0x0000000096000061
[  520.544587]   EC = 0x25: DABT (current EL), IL = 32 bits
[  520.545055]   SET = 0, FnV = 0
[  520.545327]   EA = 0, S1PTW = 0
[  520.545605]   FSC = 0x21: alignment fault
[  520.545959] Data abort info:
[  520.546214]   ISV = 0, ISS = 0x00000061, ISS2 = 0x00000000
[  520.546695]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[  520.547139]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  520.547606] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000003ab5000
[  520.548194] [ffff800085a1f004] pgd=1000000004921003, p4d=1000000004921003, pud=1000000004922003, pmd=00680000f0a00711
[  520.549129] Internal error: Oops: 0000000096000061 [#1] PREEMPT SMP
[  520.549680] Modules linked in: mtk_t7xx r8169 dwmac_rk hantro_vpu stmmac_platform stmmac v4l2_vp9 rockchip_saradc snd_soc_simple_card v4l2_h264 industrialio_triggered_buffer rfkill_gpio crct10dif_ce snd_soc_simple_card_utils tee rk805_pwrkey rtc_hym8563 pcs_xpcs kfifo_buf phy_rockchip_naneng_combphy rockchip_thermal ahci_dwc rockchip_dfi snd_soc_rockchip_i2s_tdm v4l2_mem2mem rockchipdrm videobuf2_dma_contig phy_rockchip_inno_usb2 analogix_dp videobuf2_memops dw_hdmi_qp videobuf2_v4l2 dw_mipi_dsi videodev dw_hdmi videobuf2_common drm_display_helper wwan mc cec drm_dma_helper drm_kms_helper snd_soc_simple_amplifier adc_keys cfg80211 rfkill uio_pdrv_genirq uio sch_fq_codel drm fuse drm_panel_orientation_quirks backlight dm_mod nfnetlink ip_tables x_tables ipv6 crc_ccitt
[  520.555692] CPU: 4 PID: 94 Comm: kworker/u33:0 Not tainted 6.8.0-11808-g9f98dafcc47f-dirty #45
[  520.556449] Hardware name: PINE64 QuartzPro64 (DT)
[  520.556870] Workqueue: md_hk_wq t7xx_md_hk_wq [mtk_t7xx]
[  520.557361] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  520.557974] pc : t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
[  520.558533] lr : t7xx_cldma_start+0x88/0x11c [mtk_t7xx]
[  520.559009] sp : ffff80008394bd40
[  520.559301] x29: ffff80008394bd40 x28: 0000000000000000 x27: 0000000000000000
[  520.559935] x26: ffff0001022e1828 x25: ffff0001012dae80 x24: ffff000102c048a0
[  520.560567] x23: 0000000000000000 x22: ffff000102c04a38 x21: ffff000102c04080
[  520.561199] x20: ffff000102c040b0 x19: 0000000000000000 x18: ffffffffffffffff
[  520.561831] x17: 0000000000000000 x16: ffff0003fdee98b8 x15: 0000000000000002
[  520.562461] x14: 0000000000000000 x13: 0000000000000009 x12: 0000000000000000
[  520.563092] x11: 0000000000000000 x10: ffff0003fdee9920 x9 : 0000000000000000
[  520.563723] x8 : ffff0001031a1088 x7 : ffff000102c04898 x6 : 0000000000000018
[  520.564355] x5 : 00000000000008f0 x4 : 0000000000000001 x3 : 0000000000000000
[  520.564986] x2 : 0000000105af7000 x1 : ffff800085a1f004 x0 : ffff800085a1f004
[  520.565618] Call trace:
[  520.565838]  t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
[  520.566369]  t7xx_md_hk_wq+0x3c/0x7c [mtk_t7xx]
[  520.566785]  process_one_work+0x148/0x29c
[  520.567148]  worker_thread+0x2fc/0x40c
[  520.567485]  kthread+0x110/0x114
[  520.567775]  ret_from_fork+0x10/0x20
[  520.568099] Code: f9400800 91001000 8b214001 d50332bf (f9000022)
[  520.568637] ---[ end trace 0000000000000000 ]---
[  520.569044] note: kworker/u33:0[94] exited with irqs disabled
[  520.569578] note: kworker/u33:0[94] exited with preempt_count 1
[  520.569970] Unable to handle kernel paging request at virtual address ffff800085a1d004
[  520.570804] Mem abort info:
[  520.571053]   ESR = 0x0000000096000061
[  520.571385]   EC = 0x25: DABT (current EL), IL = 32 bits
[  520.571854]   SET = 0, FnV = 0
[  520.572126]   EA = 0, S1PTW = 0
[  520.572406]   FSC = 0x21: alignment fault
[  520.572761] Data abort info:
[  520.573017]   ISV = 0, ISS = 0x00000061, ISS2 = 0x00000000
[  520.573501]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[  520.573946]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  520.574415] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000003ab5000
[  520.575005] [ffff800085a1d004] pgd=1000000004921003, p4d=1000000004921003, pud=1000000004922003, pmd=00680000f0a00711
[  520.575942] Internal error: Oops: 0000000096000061 [#2] PREEMPT SMP
[  520.576494] Modules linked in: mtk_t7xx r8169 dwmac_rk hantro_vpu stmmac_platform stmmac v4l2_vp9 rockchip_saradc snd_soc_simple_card v4l2_h264 industrialio_triggered_buffer rfkill_gpio crct10dif_ce snd_soc_simple_card_utils tee rk805_pwrkey rtc_hym8563 pcs_xpcs kfifo_buf phy_rockchip_naneng_combphy rockchip_thermal ahci_dwc rockchip_dfi snd_soc_rockchip_i2s_tdm v4l2_mem2mem rockchipdrm videobuf2_dma_contig phy_rockchip_inno_usb2 analogix_dp videobuf2_memops dw_hdmi_qp videobuf2_v4l2 dw_mipi_dsi videodev dw_hdmi videobuf2_common drm_display_helper wwan mc cec drm_dma_helper drm_kms_helper snd_soc_simple_amplifier adc_keys cfg80211 rfkill uio_pdrv_genirq uio sch_fq_codel drm fuse drm_panel_orientation_quirks backlight dm_mod nfnetlink ip_tables x_tables ipv6 crc_ccitt
[  520.582516] CPU: 7 PID: 412 Comm: kworker/u33:1 Tainted: G      D            6.8.0-11808-g9f98dafcc47f-dirty #45
[  520.583410] Hardware name: PINE64 QuartzPro64 (DT)
[  520.583833] Workqueue: md_hk_wq t7xx_ap_hk_wq [mtk_t7xx]
[  520.584327] pstate: 804000c9 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  520.584942] pc : t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
[  520.585504] lr : t7xx_cldma_start+0x88/0x11c [mtk_t7xx]
[  520.585981] sp : ffff80008400bd40
[  520.586275] x29: ffff80008400bd40 x28: 0000000000000000 x27: 0000000000000000
[  520.586907] x26: ffff0001022e1828 x25: ffff000100e081c0 x24: ffff000102c068a0
[  520.587539] x23: 0000000000000000 x22: ffff000102c06a38 x21: ffff000102c06080
[  520.588171] x20: ffff000102c060b0 x19: 0000000000000000 x18: ffffffffffffffff
[  520.588803] x17: 000000040044ffff x16: ffff0003fdee98b8 x15: 0000000000000002
[  520.589434] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  520.590066] x11: 0000000000000000 x10: ffff0003fdee9940 x9 : 0000000000000000
[  520.590697] x8 : ffff0001031a1088 x7 : ffff000102c06898 x6 : 0000000000000018
[  520.591329] x5 : 00000000000008f0 x4 : 0000000000000001 x3 : 0000000000000000
[  520.591960] x2 : 0000000105eb8000 x1 : ffff800085a1d004 x0 : ffff800085a1d004
[  520.592592] Call trace:
[  520.592812]  t7xx_cldma_hw_set_start_addr+0x1c/0x3c [mtk_t7xx]
[  520.593341]  t7xx_ap_hk_wq+0x44/0x78 [mtk_t7xx]
[  520.593758]  process_one_work+0x148/0x29c
[  520.594121]  worker_thread+0x2fc/0x40c
[  520.594457]  kthread+0x110/0x114
[  520.594747]  ret_from_fork+0x10/0x20
[  520.595071] Code: f9400800 91001000 8b214001 d50332bf (f9000022)
[  520.595609] ---[ end trace 0000000000000000 ]---
[  520.596017] note: kworker/u33:1[412] exited with irqs disabled
[  520.596544] note: kworker/u33:1[412] exited with preempt_count 1

[root@quartzpro64 ~]# [  580.895345] mtk_t7xx 0000:01:00.0: MD handshake timeout
[  580.895821] mtk_t7xx 0000:01:00.0: Boot Handshake failure


Best regards,
Liviu


-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!

