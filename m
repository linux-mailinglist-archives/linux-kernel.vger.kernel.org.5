Return-Path: <linux-kernel+bounces-39425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CAC83D0FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57091F24EDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCB517BAE;
	Thu, 25 Jan 2024 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kdeeEq19"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA77175A1;
	Thu, 25 Jan 2024 23:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227046; cv=none; b=bycPv/+VOPdq0uWMEOWVcsWiZ+9IpH0q3HIClxXT/yIF1M9I0vMlsaDrt1kMuAbyJOTWBGxHq88fiyL3Zl6IIhcppVuwf//WAGeG9vl/fj1TmNyXgCzsjaz5LIW87MktKYsvf1Bcc+8IGIJTBccRaCkoyC4JO3TOp50Cc4+StiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227046; c=relaxed/simple;
	bh=npEXHBcEGfd2G3jWgChAxp6c2zYrUmmD20Sh6NrdvwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVJhrqDkob5e2wXEi3RbS+tJisocffV89pLrM362fViXUZh6GElyFzunuzkUV1nVrZPLpRpudZFb381rKESXfJoceRzB1MkRcGIOQQKipFzpzFrEJ7996eNibv2OuGL0T9eJNsAZ8X7Kpk/txAGdPO1YNEUkHw6AnDMTJkBY1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kdeeEq19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5F5C43394;
	Thu, 25 Jan 2024 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706227045;
	bh=npEXHBcEGfd2G3jWgChAxp6c2zYrUmmD20Sh6NrdvwA=;
	h=From:To:Cc:Subject:Date:From;
	b=kdeeEq19kZXW9yEe7O8gNw4xRaO/6SUmBizhkWQ5VS+8rVGZGdqhXvN9wpucBuMKh
	 rTH2TCHzL3X50VMg6CcQIWcMkpJsWza6Bp0T/jpNJF1ywP2vcVUBXzBPtYOyq5HRUj
	 1QlnpAPjdUBaRqpfwVeUdlV3eBQsFOd56wMtmdXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.268
Date: Thu, 25 Jan 2024 15:57:22 -0800
Message-ID: <2024012523-correct-decode-bd7b@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.268 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                          |    2 
 arch/arc/kernel/signal.c                                          |    6 
 arch/arm/boot/dts/qcom-apq8064.dtsi                               |    2 
 arch/arm/mach-davinci/Kconfig                                     |    1 
 arch/arm/mach-sunxi/mc_smp.c                                      |    4 
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts            |    2 
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                        |    2 
 arch/mips/alchemy/devboards/db1200.c                              |    2 
 arch/mips/alchemy/devboards/db1550.c                              |    2 
 arch/mips/kernel/setup.c                                          |    4 
 arch/powerpc/lib/Makefile                                         |    2 
 arch/powerpc/perf/imc-pmu.c                                       |    6 
 arch/powerpc/platforms/44x/Kconfig                                |    1 
 arch/powerpc/platforms/powernv/opal-irqchip.c                     |    2 
 arch/powerpc/platforms/powernv/opal-powercap.c                    |    6 
 arch/powerpc/platforms/powernv/opal-xscom.c                       |    5 
 arch/powerpc/platforms/pseries/hotplug-memory.c                   |   21 -
 arch/s390/include/asm/pci_io.h                                    |   32 +-
 arch/s390/pci/pci_mmio.c                                          |   12 
 arch/x86/kernel/kvmclock.c                                        |   12 
 arch/x86/lib/misc.c                                               |    2 
 crypto/af_alg.c                                                   |   14 +
 crypto/scompress.c                                                |    6 
 drivers/acpi/acpi_lpit.c                                          |    2 
 drivers/acpi/acpi_video.c                                         |   12 
 drivers/acpi/property.c                                           |    4 
 drivers/acpi/resource.c                                           |    7 
 drivers/android/binder.c                                          |    2 
 drivers/android/binder_alloc.c                                    |   29 +-
 drivers/base/swnode.c                                             |    3 
 drivers/bluetooth/btmtkuart.c                                     |   11 
 drivers/clk/clk-si5341.c                                          |    4 
 drivers/clk/rockchip/clk-rk3128.c                                 |    2 
 drivers/clk/zynqmp/clk-mux-zynqmp.c                               |    2 
 drivers/crypto/ccp/ccp-ops.c                                      |    5 
 drivers/crypto/sahara.c                                           |  127 +++-------
 drivers/crypto/virtio/Kconfig                                     |    1 
 drivers/crypto/virtio/virtio_crypto_common.h                      |    2 
 drivers/crypto/virtio/virtio_crypto_core.c                        |   26 +-
 drivers/edac/thunderx_edac.c                                      |   10 
 drivers/firmware/ti_sci.c                                         |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                       |    4 
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c                               |    4 
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                               |    5 
 drivers/gpu/drm/bridge/tc358767.c                                 |    2 
 drivers/gpu/drm/drm_crtc.c                                        |    8 
 drivers/gpu/drm/drm_drv.c                                         |   10 
 drivers/gpu/drm/exynos/exynos_drm_dma.c                           |    8 
 drivers/gpu/drm/exynos/exynos_hdmi.c                              |    2 
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c                         |    9 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c                             |    4 
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c                |    2 
 drivers/gpu/drm/radeon/r100.c                                     |    4 
 drivers/gpu/drm/radeon/r600_cs.c                                  |    4 
 drivers/gpu/drm/radeon/radeon_display.c                           |    7 
 drivers/gpu/drm/radeon/radeon_vm.c                                |    8 
 drivers/gpu/drm/radeon/si.c                                       |    4 
 drivers/gpu/drm/radeon/sumo_dpm.c                                 |    4 
 drivers/gpu/drm/radeon/trinity_dpm.c                              |    4 
 drivers/hid/wacom_wac.c                                           |   32 --
 drivers/hwtracing/coresight/coresight-etm4x.h                     |    2 
 drivers/i2c/busses/i2c-s3c2410.c                                  |   40 +--
 drivers/infiniband/hw/mthca/mthca_cmd.c                           |    4 
 drivers/infiniband/hw/mthca/mthca_main.c                          |    2 
 drivers/input/joystick/xpad.c                                     |    1 
 drivers/input/keyboard/atkbd.c                                    |   50 +++
 drivers/input/serio/i8042-x86ia64io.h                             |    8 
 drivers/media/dvb-core/dvbdev.c                                   |    2 
 drivers/media/usb/cx231xx/cx231xx-core.c                          |    2 
 drivers/media/usb/pvrusb2/pvrusb2-context.c                       |    3 
 drivers/mmc/host/Kconfig                                          |    5 
 drivers/mtd/mtd_blkdevs.c                                         |    4 
 drivers/mtd/nand/raw/fsl_ifc_nand.c                               |    2 
 drivers/net/dsa/vitesse-vsc73xx-core.c                            |    2 
 drivers/net/ethernet/broadcom/tg3.c                               |   11 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c            |    8 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c                |    2 
 drivers/net/ethernet/renesas/ravb_main.c                          |    2 
 drivers/net/phy/micrel.c                                          |    1 
 drivers/net/wireless/marvell/libertas/Kconfig                     |    2 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                   |    2 
 drivers/net/wireless/marvell/mwifiex/fw.h                         |    1 
 drivers/net/wireless/marvell/mwifiex/ioctl.h                      |    1 
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c                    |    8 
 drivers/net/wireless/realtek/rtlwifi/pci.c                        |   79 +-----
 drivers/net/wireless/realtek/rtlwifi/pci.h                        |    5 
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c              |   20 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c        |   16 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.h        |    1 
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.c              |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.h              |    1 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.c              |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c              |   66 +----
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c              |   20 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c              |   20 -
 drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c      |    8 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c              |   19 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h                       |    7 
 drivers/net/wireless/realtek/rtw88/mac80211.c                     |    4 
 drivers/net/xen-netback/netback.c                                 |   44 ++-
 drivers/nvme/host/nvme.h                                          |    5 
 drivers/nvme/target/tcp.c                                         |   20 +
 drivers/of/base.c                                                 |    1 
 drivers/of/unittest-data/tests-phandle.dtsi                       |   10 
 drivers/of/unittest.c                                             |   74 +++--
 drivers/parport/parport_serial.c                                  |   64 +++++
 drivers/pci/controller/dwc/pci-keystone.c                         |    9 
 drivers/pinctrl/cirrus/Kconfig                                    |    3 
 drivers/reset/hisilicon/hi6220_reset.c                            |    2 
 drivers/s390/block/scm_blk.c                                      |    7 
 drivers/scsi/fnic/fnic_debugfs.c                                  |    3 
 drivers/scsi/hisi_sas/hisi_sas_main.c                             |    4 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                            |    2 
 drivers/spi/spi-sh-msiof.c                                        |   17 +
 drivers/tty/serial/8250/8250_omap.c                               |    2 
 drivers/tty/serial/imx.c                                          |    2 
 drivers/uio/uio.c                                                 |    7 
 drivers/usb/chipidea/core.c                                       |    7 
 drivers/usb/dwc3/core.c                                           |   39 ---
 drivers/usb/dwc3/ep0.c                                            |    5 
 drivers/usb/mon/mon_bin.c                                         |    7 
 drivers/usb/phy/phy-mxs-usb.c                                     |    3 
 drivers/usb/typec/class.c                                         |    4 
 drivers/video/fbdev/core/fb_defio.c                               |    6 
 drivers/watchdog/bcm2835_wdt.c                                    |    3 
 drivers/watchdog/hpwdt.c                                          |    2 
 drivers/watchdog/watchdog_dev.c                                   |    3 
 fs/f2fs/namei.c                                                   |    2 
 fs/f2fs/xattr.c                                                   |    6 
 fs/gfs2/rgrp.c                                                    |    2 
 fs/jbd2/journal.c                                                 |    4 
 fs/nfs/blocklayout/blocklayout.c                                  |    2 
 fs/nfs/nfs4proc.c                                                 |    3 
 fs/pstore/ram_core.c                                              |    2 
 include/crypto/if_alg.h                                           |    3 
 include/drm/drm_bridge.h                                          |    2 
 include/net/bluetooth/hci_core.h                                  |    1 
 include/uapi/linux/virtio_crypto.h                                |    1 
 init/do_mounts.c                                                  |    9 
 kernel/bpf/lpm_trie.c                                             |    3 
 kernel/debug/kdb/kdb_main.c                                       |   14 -
 kernel/dma/coherent.c                                             |    4 
 kernel/time/tick-sched.c                                          |    5 
 kernel/trace/ring_buffer.c                                        |    6 
 kernel/trace/trace.c                                              |    6 
 kernel/trace/trace_output.c                                       |    6 
 lib/idr.c                                                         |    2 
 lib/test_ida.c                                                    |   40 +++
 net/bluetooth/hci_conn.c                                          |    8 
 net/bluetooth/hci_event.c                                         |   11 
 net/core/neighbour.c                                              |    9 
 net/ipv6/ip6_tunnel.c                                             |   26 +-
 net/ncsi/internal.h                                               |    9 
 net/ncsi/ncsi-netlink.c                                           |    4 
 net/ncsi/ncsi-pkt.h                                               |    7 
 net/ncsi/ncsi-rsp.c                                               |   26 +-
 net/netfilter/ipvs/ip_vs_xmit.c                                   |    4 
 net/netfilter/nf_tables_api.c                                     |    3 
 net/netlabel/netlabel_calipso.c                                   |   52 ++--
 net/netlabel/netlabel_cipso_v4.c                                  |    4 
 net/netlabel/netlabel_mgmt.c                                      |    8 
 net/netlabel/netlabel_unlabeled.c                                 |   10 
 net/netlabel/netlabel_user.h                                      |    4 
 net/vmw_vsock/virtio_transport_common.c                           |   13 -
 security/apparmor/policy_unpack.c                                 |    4 
 security/selinux/hooks.c                                          |    7 
 sound/pci/hda/patch_realtek.c                                     |   10 
 sound/pci/oxygen/oxygen_mixer.c                                   |    2 
 sound/soc/atmel/sam9g20_wm8731.c                                  |   61 ++++
 sound/soc/codecs/cs35l33.c                                        |    4 
 sound/soc/codecs/cs35l34.c                                        |    4 
 sound/soc/codecs/cs43130.c                                        |    6 
 sound/soc/codecs/da7219-aad.c                                     |    2 
 sound/soc/codecs/nau8822.c                                        |    9 
 sound/soc/codecs/rt5645.c                                         |   10 
 sound/soc/intel/skylake/skl-pcm.c                                 |    9 
 sound/soc/intel/skylake/skl-sst-ipc.c                             |    4 
 tools/perf/builtin-record.c                                       |   23 +
 tools/perf/builtin-top.c                                          |   22 +
 tools/perf/util/bpf-event.c                                       |   11 
 tools/perf/util/bpf-event.h                                       |   19 -
 tools/perf/util/env.c                                             |   90 +++++--
 tools/perf/util/env.h                                             |   10 
 tools/perf/util/evlist.c                                          |   21 -
 tools/perf/util/evlist.h                                          |    2 
 tools/perf/util/genelf.c                                          |    6 
 tools/perf/util/header.c                                          |    8 
 tools/perf/util/top.h                                             |    2 
 tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh |   52 ++++
 tools/testing/selftests/net/fib_nexthop_multiprefix.sh            |    4 
 tools/testing/selftests/powerpc/math/fpu_preempt.c                |    9 
 tools/testing/selftests/powerpc/math/vmx_preempt.c                |   10 
 192 files changed, 1277 insertions(+), 795 deletions(-)

Alex Deucher (1):
      drm/amdgpu/debugfs: fix error code when smc register accessors are NULL

Amit Cohen (1):
      mlxsw: spectrum_acl_erp: Fix error flow of pool allocation failure

Andrew Lunn (1):
      net: netlabel: Fix kerneldoc warnings

Arnaldo Carvalho de Melo (3):
      perf record: Move sb_evlist to 'struct record'
      perf top: Move sb_evlist to 'struct perf_top'
      perf bpf: Decouple creating the evlist from adding the SB event

Arnd Bergmann (3):
      EDAC/thunderx: Fix possible out-of-bounds string access
      wifi: libertas: stop selecting wext
      ARM: davinci: always select CONFIG_CPU_ARM926T

Arseniy Krasnov (1):
      virtio/vsock: fix logic which reduces credit update messages

Artem Chernyshev (1):
      scsi: fnic: Return error if vmalloc() failed

Benjamin Coddington (1):
      blocklayoutdriver: Fix reference leak of pnfs_device_node

Bhaskar Chowdhury (1):
      ncsi: internal.h: Fix a spello

Cameron Williams (2):
      parport: parport_serial: Add Brainboxes BAR details
      parport: parport_serial: Add Brainboxes device IDs and geometry

Carlos Llamas (7):
      binder: use EPOLLERR from eventpoll.h
      binder: fix trivial typo of binder_free_buf_locked()
      binder: fix comment on binder_alloc_new_buf() return value
      binder: fix async space check for 0-sized buffers
      binder: fix use-after-free in shinker's callback
      binder: fix race between mmput() and do_exit()
      binder: fix unused alloc->free_async_space

Chao Yu (1):
      f2fs: fix to avoid dirent corruption

Charles Keepax (1):
      pinctrl: lochnagar: Don't build on MIPS

Chengming Zhou (1):
      crypto: scomp - fix req->dst buffer overflow

Chih-Kang Chang (1):
      wifi: rtw88: fix RX filter in FIF_ALLMULTI flag

Christian A. Ehrhardt (1):
      of: Fix double free in of_parse_phandle_with_args_map

Christoph Niedermaier (1):
      serial: imx: Correct clock error message in function probe()

Christophe JAILLET (4):
      firmware: ti_sci: Fix an off-by-one in ti_sci_debugfs_create()
      MIPS: Alchemy: Fix an out-of-bound access in db1200_dev_setup()
      MIPS: Alchemy: Fix an out-of-bound access in db1550_dev_setup()
      kdb: Fix a potential buffer overflow in kdb_local()

Claudiu Beznea (1):
      net: phy: micrel: populate .soft_reset for KSZ9131

Colin Ian King (2):
      x86/lib: Fix overflow when counting digits
      rtlwifi: rtl8192de: make arrays static const, makes object smaller

Curtis Klein (1):
      watchdog: set cdev owner before adding

Dan Carpenter (1):
      media: dvbdev: drop refcount on error path in dvb_device_open()

Daniel Thompson (1):
      kdb: Censor attempts to set PROMPT without ENABLE_MEM_READ

Dario Binacchi (1):
      drm/bridge: Fix typo in post_disable() description

Dave Airlie (1):
      nouveau/tu102: flush all pdbs on vmm flush

David Lin (2):
      ASoC: nau8822: Fix incorrect type in assignment and cast to restricted __be16
      wifi: mwifiex: configure BSSID consistently when starting AP

David Rau (1):
      ASoC: da7219: Support low DC impedance headset

Dinghao Liu (1):
      crypto: ccp - fix memleak in ccp_init_dm_workarea

Dmitry Baryshkov (3):
      ARM: dts: qcom: apq8064: correct XOADC register address
      drm/msm/mdp4: flush vblank event on disable
      drm/drv: propagate errors from drm_modeset_register_all()

Eric Biggers (1):
      f2fs: explicitly null-terminate the xattr list

Eric Dumazet (1):
      ip6_tunnel: fix NEXTHDR_FRAGMENT handling in ip6_tnl_parse_tlv_enc_lim()

Esther Shimanovich (1):
      Input: i8042 - add nomux quirk for Acer P459-G2-M

Fedor Pchelkin (2):
      apparmor: avoid crash when parsed profile name is empty
      ipvs: avoid stat macros calls from preemptible context

Florian Lehner (1):
      bpf, lpm: Fix check prefixlen before walking trie

Florian Westphal (1):
      netfilter: nf_tables: mark newset as dead on transaction abort

Francesco Dolcini (1):
      Bluetooth: btmtkuart: fix recv_buf() return value

Gavrilov Ilia (1):
      calipso: fix memory leak in netlbl_calipso_add_pass()

Geert Uytterhoeven (1):
      of: unittest: Fix of_count_phandle_with_args() expected value message

Gonglei (Arei) (1):
      crypto: virtio - Handle dataq logic with tasklet

Greg Kroah-Hartman (2):
      Revert "ASoC: atmel: Remove system clock tree configuration for at91sam9g20ek"
      Linux 5.4.268

Guanghui Feng (1):
      uio: Fix use-after-free in uio_open

Gui-Dong Han (1):
      usb: mon: Fix atomicity violation in mon_bin_vma_fault

Hangbin Liu (1):
      selftests/net: fix grep checking for fib_nexthop_multiprefix

Hans de Goede (3):
      Input: atkbd - skip ATKBD_CMD_GETID in translated mode
      ACPI: resource: Add another DMI match for the TongFang GMxXGxx
      Input: atkbd - use ab83 as id when skipping the getid command

Heikki Krogerus (1):
      Revert "usb: typec: class: fix typec_altmode_put_partner to put plugs"

Heiko Carstens (1):
      tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug

Herbert Xu (1):
      crypto: af_alg - Disallow multiple in-flight AIO requests

Ian Rogers (1):
      perf env: Avoid recursively taking env->bpf_progs.lock

Ilpo Järvinen (2):
      wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code
      wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors

Inki Dae (1):
      drm/exynos: fix a wrong error checking

James Clark (1):
      coresight: etm4x: Fix width of CCITMIN field

Jan Beulich (1):
      xen-netback: don't produce zero-size SKB frags

Jani Nikula (1):
      drm/crtc: fix uninitialized variable use

Jason Gerecke (1):
      HID: wacom: Correct behavior when processing some confidence == false touches

Jay Buddhabhatti (1):
      drivers: clk: zynqmp: calculate closest mux rate

Jerry Hoemann (1):
      watchdog/hpwdt: Only claim UNKNOWN NMI if from iLO

Jiri Olsa (1):
      perf env: Add perf_env__numa_node()

Joakim Zhang (1):
      dma-mapping: clear dev->dma_mem to NULL after freeing it

Joe Perches (1):
      rtlwifi: Use ffs in <foo>_phy_calculate_bit_shift

Judy Hsiao (1):
      neighbour: Don't let neigh_forced_gc() disable preemption for long

Kamil Duljas (2):
      ASoC: Intel: Skylake: Fix mem leak in few functions
      ASoC: Intel: Skylake: mem leak in skl register function

Keith Busch (1):
      nvme: introduce helper function to get ctrl state

Kirill A. Shutemov (1):
      x86/kvm: Do not try to disable kvmclock if it was not enabled

Konrad Dybcio (1):
      drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks

Krzysztof Kozlowski (2):
      reset: hisilicon: hi6220: fix Wvoid-pointer-to-enum-cast warning
      arm64: dts: qcom: sdm845-db845c: correct LED panic indicator

Kunwu Chan (5):
      powerpc/powernv: Add a null pointer check to scom_debug_init_one()
      powerpc/powernv: Add a null pointer check in opal_event_init()
      powerpc/powernv: Add a null pointer check in opal_powercap_init()
      powerpc/imc-pmu: Add a null pointer check in update_events_in_group()
      net: dsa: vsc73xx: Add null pointer check to vsc73xx_gpio_probe

Laurent Dufour (1):
      powerpc/pseries/memhotplug: Quieten some DLPAR operations

Leon Romanovsky (1):
      RDMA/usnic: Silence uninitialized symbol smatch warnings

Lin Ma (1):
      net: qualcomm: rmnet: fix global oob in rmnet_policy

Linus Walleij (2):
      ASoC: cs35l33: Fix GPIO name and drop legacy include
      ASoC: cs35l34: Fix GPIO name and drop legacy include

Luca Weiss (1):
      Input: xpad - add Razer Wolverine V2 support

Luiz Augusto von Dentz (1):
      Bluetooth: Fix bogus check for re-auth no supported with non-ssp

Maciej Strozek (2):
      ASoC: cs43130: Fix the position of const qualifier
      ASoC: cs43130: Fix incorrect frame delay configuration

Marek Szyprowski (2):
      i2c: s3c24xx: fix read transfers in polling mode
      i2c: s3c24xx: fix transferring more than one message in polling mode

Masahiro Yamada (1):
      powerpc: add crtsavres.o to always-y instead of extra-y

Matthew Wilcox (Oracle) (1):
      ida: Fix crash in ida_free when the bitmap is empty

Maurizio Lombardi (3):
      nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length
      nvmet-tcp: fix a crash in nvmet_req_complete()
      nvmet-tcp: Fix the H2C expected PDU len calculation

Michael Ellerman (1):
      selftests/powerpc: Fix error handling in FPU/VMX preemption tests

Mickaël Salaün (1):
      selinux: Fix error priority for bind with AF_UNSPEC on PF_INET6 socket

Nam Cao (1):
      fbdev: flush deferred work in fb_deferred_io_fsync()

Namhyung Kim (1):
      perf genelf: Set ELF program header addresses properly

Nathan Lynch (1):
      powerpc/pseries/memhp: Fix access beyond end of drmem array

Nikita Kiryushin (2):
      ACPI: video: check for error while searching for backlight device parent
      ACPI: LPIT: Avoid u32 multiplication overflow

Nikita Yushchenko (1):
      net: ravb: Fix dma_addr_t truncation in error case

Nikita Zhandarovich (3):
      drm/radeon/r600_cs: Fix possible int overflows in r600_cs_check_reg()
      drm/radeon/r100: Fix integer overflow issues in r100_cs_track_check()
      drm/radeon: check return value of radeon_ring_lock()

Niklas Schnelle (1):
      s390/pci: fix max size calculation in zpci_memcpy_toio()

Osama Muhammad (1):
      gfs2: Fix kernel NULL pointer dereference in gfs2_rgrp_dump

Ovidiu Panait (9):
      crypto: sahara - remove FLAGS_NEW_KEY logic
      crypto: sahara - fix ahash selftest failure
      crypto: sahara - fix processing requests with cryptlen < sg->length
      crypto: sahara - fix error handling in sahara_hw_descriptor_create()
      crypto: sahara - fix ahash reqsize
      crypto: sahara - fix wait_for_completion_timeout() error handling
      crypto: sahara - improve error handling in sahara_sha_process()
      crypto: sahara - fix processing hash requests with req->nbytes < sg->length
      crypto: sahara - do not resize req->src when doing hash operations

Pablo Neira Ayuso (1):
      netfilter: nf_tables: skip dead set elements in netlink dump

Peter Delevoryas (1):
      net/ncsi: Fix netlink major/minor version numbers

Peter Robinson (1):
      mmc: sdhci_omap: Fix TI SoC dependencies

RD Babiera (1):
      usb: typec: class: fix typec_altmode_put_partner to put plugs

Ram Muthiah (1):
      crypto: virtio - don't use 'default m'

Randy Dunlap (1):
      powerpc/44x: select I2C for CURRITUCK

Ricardo B. Marliere (1):
      media: pvrusb2: fix use after free on context disconnection

Ronald Monthero (1):
      mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response

Sakari Ailus (2):
      acpi: property: Let args be NULL in __acpi_node_get_property_reference
      software node: Let args be NULL in software_node_get_reference_args

Serge Semin (1):
      mips: Fix incorrect max_low_pfn adjustment

Sergey Shtylyov (1):
      pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()

Shuming Fan (1):
      ASoC: rt5650: add mutex to avoid the jack detection failure

Siddharth Vadapalli (1):
      PCI: keystone: Fix race condition when initializing PHYs

Sjoerd Simons (1):
      arm64: dts: armada-3720-turris-mox: set irq type for RTC

Stefan Berger (1):
      rootfs: Fix support for rootfstype= when root= is given

Stefan Wahren (2):
      ARM: sun9i: smp: fix return code check of of_property_match_string
      watchdog: bcm2835_wdt: Fix WDIOC_SETTIMEOUT handling

Steven Rostedt (Google) (3):
      tracing: Have large events show up as '[LINE TOO BIG]' instead of nothing
      tracing: Add size check when printing trace_marker output
      ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI

Su Hui (10):
      wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
      wifi: rtlwifi: add calculate_bit_shift()
      wifi: rtlwifi: rtl8188ee: phy: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192c: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192cu: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192ce: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192de: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192ee: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192se: using calculate_bit_shift()
      clk: si5341: fix an error code problem in si5341_output_clk_set_rate

Takashi Iwai (1):
      ALSA: oxygen: Fix right channel of capture volume mixer

Thinh Nguyen (2):
      Revert "usb: dwc3: Soft reset phy on probe for host"
      Revert "usb: dwc3: don't reset device side if dwc3 was configured as host-only"

Thinh Tran (1):
      net/tg3: fix race condition in tg3_reset_task()

Tiezhu Yang (1):
      perf top: Skip side-band event setup if HAVE_LIBBPF_SUPPORT is not set

Tomi Valkeinen (1):
      drm/bridge: tc358767: Fix return value on error case

Trond Myklebust (1):
      NFSv4.1/pnfs: Ensure we handle the error NFS4ERR_RETURNCONFLICT

Uttkarsh Aggarwal (1):
      usb: dwc: ep0: Update request status in dwc3_ep0_stall_restart

Uwe Kleine-König (1):
      serial: 8250: omap: Don't skip resource freeing if pm_runtime_resume_and_get() failed

Vasiliy Kovalev (1):
      ALSA: hda - Fix speaker and headset mic pin config for CHUWI CoreBook XPro

Vineet Gupta (1):
      ARC: fix spare error

Vineeth Vijayan (1):
      s390/scm: fix virtual vs physical address confusion

Weihao Li (1):
      clk: rockchip: rk3128: Fix HCLK_OTG gate register

Wolfram Sang (1):
      spi: sh-msiof: Enforce fixed DTDL for R-Car H3

Xiang Yang (1):
      drm/exynos: fix a potential error pointer dereference

Xu Yang (2):
      usb: phy: mxs: remove CONFIG_USB_OTG condition for mxs_phy_is_otg_host()
      usb: chipidea: wait controller resume finished for wakeup irq

Yang Yingliang (1):
      drm/radeon: check the alloc_workqueue return value in radeon_crtc_init()

Yihang Li (1):
      scsi: hisi_sas: Replace with standard error code return value

Zhang Yi (1):
      jbd2: correct the printing of write_flags in jbd2_write_superblock()

ZhaoLong Wang (1):
      mtd: Fix gluebi NULL pointer dereference caused by ftl notifier

Zheng Yejian (1):
      netlabel: remove unused parameter in netlbl_netlink_auditinfo()

Zhipeng Lu (6):
      drm/radeon/dpm: fix a memleak in sumo_parse_power_table
      drm/radeon/trinity_dpm: fix a memleak in trinity_parse_power_table
      media: cx231xx: fix a memleak in cx231xx_init_isoc
      drm/amd/pm: fix a double-free in si_dpm_init
      drivers/amd/pm: fix a use-after-free in kv_parse_power_table
      gpu/drm/radeon: fix two memleaks in radeon_vm_init

Ziqi Zhao (1):
      drm/crtc: Fix uninit-value bug in drm_mode_setcrtc

wangyangxin (1):
      crypto: virtio - Wait for tasklet to complete on device remove

zhenwei pi (1):
      virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC


