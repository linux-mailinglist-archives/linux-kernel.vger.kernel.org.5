Return-Path: <linux-kernel+bounces-158971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672818B278C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7551C21953
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF9914EC47;
	Thu, 25 Apr 2024 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUjEJBBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E614E2DF;
	Thu, 25 Apr 2024 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065917; cv=none; b=C8+P3lxSIcTwo/BT7MPxhwHhrEzqVVj54Rf4ucQE5/5m1cH1mQJMMK8GrULGSKyLSBTZwUoswz5gwUAYTtXvLsxZSUq56sCPiunuR98bianUgyc9TdklNAphSaSqdEytlJwF45423XNHFnWjqQJRqlZz4KUB0lyGYWzSa8p1c9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065917; c=relaxed/simple;
	bh=EKA96jF0TmDrbuZBe7xdF1NXy+3hnwQDGrrf7uNb5Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tuYvVdcK0BxM2AO1stCXNiI4iVD/brc2IobztMS+0i9aWidCteqtZamytHzMYO6FemMbFXR6SQv68Mnfqpu8M7VZDJ3wPQlpDIzVFXGi+USCWec/VP9KdP+ZxmDLq1GeeqcZYdx02zAv5ffYSsqcfdozcBrW7I79LWd5LKCsLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUjEJBBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC67C113CE;
	Thu, 25 Apr 2024 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714065917;
	bh=EKA96jF0TmDrbuZBe7xdF1NXy+3hnwQDGrrf7uNb5Hk=;
	h=From:To:Cc:Subject:Date:From;
	b=tUjEJBBeBWhegtHEw1LUYFPnsb5EeIReWLYa5cpmeMj4jZXsccWQnAsuCZQUiiSLw
	 1Q5jvY0ia46vm8ux8lBDkgMJxK3ksboesnQYhOo6MiMyMPcRU9p7CgbHSmRk6ADBqC
	 nz+fDBX2bVGq7jxW4agHCxDR6XNnlcqLO/4kwVRP76ugBMlKVLp9XKGUUz4yCBzI32
	 Q+tSwaLgVOgkqP5z1ZFgdW63A0gprTFTpjm9ZTTsU6n7dHcRaH2dgDxrjMeFiHIIO/
	 dY+b0aI9n6FC6B1sL2egMgaUIh2SBUMsJ1CpxxyreCzC4H3vgWViPJDDgQcBz3UjMx
	 XpD4GnRrMYsEg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.9-rc6
Date: Thu, 25 Apr 2024 10:25:16 -0700
Message-ID: <20240425172516.2251761-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 7586c8501d090609c6eb1af6ba05e3ed68806c83:

  Merge tag 'net-6.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-04-18 11:40:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc6

for you to fetch changes up to e8baa63f8789d34b5c2e61f36ab60d693b65b1dc:

  Merge tag 'nf-24-04-25' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-04-25 08:46:53 -0700)

----------------------------------------------------------------
Including fixes from netfilter, wireless and bluetooth.

Nothing major, regression fixes are mostly in drivers, two more
of those are flowing towards us thru various trees. I wish some of
the changes went into -rc5, we'll try to keep an eye on frequency
of PRs from sub-trees.

Also disproportional number of fixes for bugs added in v6.4,
strange coincidence.

Current release - regressions:

 - igc: fix LED-related deadlock on driver unbind

 - wifi: mac80211: small fixes to recent clean up of the connection
   process

 - Revert "wifi: iwlwifi: bump FW API to 90 for BZ/SC devices",
   kernel doesn't have all the code to deal with that version, yet

 - Bluetooth:
   - set power_ctrl_enabled on NULL returned by gpiod_get_optional()
   - qca: fix invalid device address check, again

 - eth: ravb: fix registered interrupt names

Current release - new code bugs:

 - wifi: mac80211: check EHT/TTLM action frame length

Previous releases - regressions:

 - fix sk_memory_allocated_{add|sub} for architectures where
   __this_cpu_{add|sub}* are not IRQ-safe

 - dsa: mv88e6xx: fix link setup for 88E6250

Previous releases - always broken:

 - ip: validate dev returned from __in_dev_get_rcu(), prevent possible
   null-derefs in a few places

 - switch number of for_each_rcu() loops using call_rcu() on the iterator
   to for_each_safe()

 - macsec: fix isolation of broadcast traffic in presence of offload

 - vxlan: drop packets from invalid source address

 - eth: mlxsw: trap and ACL programming fixes

 - eth: bnxt: PCIe error recovery fixes, fix counting dropped packets

 - Bluetooth:
  - lots of fixes for the command submission rework from v6.4
  - qca: fix NULL-deref on non-serdev suspend

Misc:

 - tools: ynl: don't ignore errors in NLMSG_DONE messages

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alex Elder (1):
      mailmap: add entries for Alex Elder

Arkadiusz Kubalewski (1):
      dpll: fix dpll_pin_on_pin_register() for multiple parent pins

Avraham Stern (1):
      wifi: iwlwifi: mvm: remove old PASN station when adding a new one

Bartosz Golaszewski (1):
      Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()

Chun-Yi Lee (1):
      Bluetooth: hci_sync: Using hci_cmd_sync_submit when removing Adv Monitor

Dan Carpenter (1):
      net: ti: icssg-prueth: Fix signedness bug in prueth_init_rx_chns()

Daniel Golle (1):
      net: phy: mediatek-ge-soc: follow netdev LED trigger semantics

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FN920C04 compositions

David Bauer (1):
      vxlan: drop packets from invalid src-address

David Christensen (1):
      MAINTAINERS: eth: mark IBM eHEA as an Orphan

David S. Miller (2):
      Merge branch 'bnxt_en-aer-fixes'
      Merge tag 'wireless-2024-04-23' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Duanqiang Wen (3):
      net: libwx: fix alloc msix vectors failed
      Revert "net: txgbe: fix i2c dev name cannot match clkdev"
      Revert "net: txgbe: fix clk_name exceed MAX_DEV_ID limits"

Duoming Zhou (1):
      ax25: Fix netdev refcount issue

Eric Dumazet (4):
      icmp: prevent possible NULL dereferences from icmp_build_probe()
      net: fix sk_memory_allocated_{add|sub} vs softirqs
      ipv4: check for NULL idev in ip_route_use_hint()
      net: usb: ax88179_178a: stop lying about skb->truesize

Erwan Velu (1):
      i40e: Report MFS in decimal base instead of hex

Felix Fietkau (1):
      wifi: mac80211: split mesh fast tx cache into local/proxied/forwarded

Geert Uytterhoeven (1):
      net: ravb: Fix registered interrupt names

Hangbin Liu (1):
      bridge/br_netlink.c: no need to return void function

Hyunwoo Kim (3):
      tcp: Fix Use-After-Free in tcp_ao_connect_init
      net: gtp: Fix Use-After-Free in gtp_dellink
      net: openvswitch: Fix Use-After-Free in ovs_ct_exit

Ido Schimmel (12):
      mlxsw: core: Unregister EMAD trap using FORWARD action
      mlxsw: core_env: Fix driver initialization with old firmware
      mlxsw: pci: Fix driver initialization with old firmware
      mlxsw: spectrum_acl_tcam: Fix race in region ID allocation
      mlxsw: spectrum_acl_tcam: Fix race during rehash delayed work
      mlxsw: spectrum_acl_tcam: Fix possible use-after-free during activity update
      mlxsw: spectrum_acl_tcam: Fix possible use-after-free during rehash
      mlxsw: spectrum_acl_tcam: Rate limit error message
      mlxsw: spectrum_acl_tcam: Fix memory leak during rehash
      mlxsw: spectrum_acl_tcam: Fix warning during rehash
      mlxsw: spectrum_acl_tcam: Fix incorrect list API usage
      mlxsw: spectrum_acl_tcam: Fix memory leak when canceling rehash work

Igor Artemiev (1):
      wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class

Ismael Luceno (1):
      ipvs: Fix checksumming on GSO of SCTP packets

Jacob Keller (1):
      ice: fix LAG and VF lock dependency in ice_reset_vf()

Jakub Kicinski (8):
      Merge branch 'mlxsw-fixes'
      tools: ynl: don't ignore errors in NLMSG_DONE messages
      Merge branch 'mlxsw-various-acl-fixes'
      eth: bnxt: fix counting packets discarded due to OOM and netpoll
      Merge tag 'for-net-2024-04-24' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'fix-isolation-of-broadcast-traffic-and-unmatched-unicast-traffic-with-macsec-offload'
      Merge branch 'intel-wired-lan-driver-updates-2024-04-23-i40e-iavf-ice'
      Merge tag 'nf-24-04-25' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Jason Reeder (1):
      net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets

Johan Hovold (3):
      Bluetooth: qca: fix invalid device address check
      Bluetooth: qca: fix NULL-deref on non-serdev suspend
      Bluetooth: qca: fix NULL-deref on non-serdev setup

Johannes Berg (12):
      wifi: mac80211: check EHT/TTLM action frame length
      wifi: mac80211: don't use rate mask for scanning
      Revert "wifi: iwlwifi: bump FW API to 90 for BZ/SC devices"
      wifi: mac80211: fix idle calculation with multi-link
      wifi: mac80211: mlme: re-parse with correct mode
      wifi: mac80211: mlme: fix memory leak
      wifi: mac80211: mlme: re-parse if AP mode is less than client
      wifi: nl80211: don't free NULL coalescing rule
      wifi: mac80211_hwsim: init peer measurement result
      wifi: mac80211: remove link before AP
      wifi: mac80211: fix unaligned le16 access
      wifi: iwlwifi: mvm: fix link ID management

Justin Chen (1):
      net: bcmasp: fix memory leak when bringing down interface

Kalle Valo (1):
      wifi: ath11k: use RCU when accessing struct inet6_dev::ac_list

Kuniyuki Iwashima (1):
      af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().

Luiz Augusto von Dentz (3):
      Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sync
      Bluetooth: hci_event: Fix sending HCI_OP_READ_ENC_KEY_SIZE
      Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID

Lukas Wunner (1):
      igc: Fix LED-related deadlock on driver unbind

MD Danish Anwar (1):
      net: phy: dp83869: Fix MII mode failure

Matthias Schiffer (1):
      net: dsa: mv88e6xx: fix supported_interfaces setup in mv88e6250_phylink_get_caps()

Michael Chan (1):
      bnxt_en: Fix error recovery for 5760X (P7) chips

Miri Korenblit (1):
      wifi: iwlwifi: mvm: return uid from iwl_mvm_build_scan_cmd

Nathan Chancellor (1):
      Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

Pablo Neira Ayuso (1):
      netfilter: nf_tables: honor table dormant flag from netdev release event path

Paul Geurts (1):
      NFC: trf7970a: disable all regulators on removal

Peter Münster (1):
      net: b44: set pause params only when interface is up

Rahul Rameshbabu (4):
      macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads
      ethernet: Add helper for assigning packet type when dest address does not match device address
      macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst
      net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec

Richard Kinder (1):
      wifi: mac80211: ensure beacon is non-S1G prior to extracting the beacon timestamp field

Sabrina Dubroca (1):
      tls: fix lockless read of strp->msg_ready in ->poll

Sean Wang (1):
      Bluetooth: btusb: mediatek: Fix double free of skb in coredump

Sindhu Devale (1):
      i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Su Hui (1):
      octeontx2-af: fix the double free in rvu_npc_freemem()

Sudheer Mogilappagari (1):
      iavf: Fix TC config comparison with existing adapter TC config

Vikas Gupta (2):
      bnxt_en: refactor reset close code
      bnxt_en: Fix the PCI-AER routines

WangYuli (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853

Yick Xie (1):
      udp: preserve the connected status if only UDP cmsg

Zijun Hu (1):
      Bluetooth: btusb: Fix triggering coredump implementation for QCA

 .mailmap                                           |  10 ++
 MAINTAINERS                                        |   3 +-
 drivers/bluetooth/btmtk.c                          |   7 +-
 drivers/bluetooth/btqca.c                          |  38 +++++++
 drivers/bluetooth/btusb.c                          |  11 +-
 drivers/bluetooth/hci_qca.c                        |  29 ++++--
 drivers/dpll/dpll_core.c                           |  58 ++++++-----
 drivers/net/dsa/mv88e6xxx/chip.c                   |  56 +++++++++-
 drivers/net/dsa/mv88e6xxx/port.h                   |  23 ++++-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  21 ++--
 drivers/net/ethernet/broadcom/b44.c                |  14 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  82 ++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  30 +++++-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  16 +--
 drivers/net/ethernet/intel/igc/igc.h               |   2 +
 drivers/net/ethernet/intel/igc/igc_leds.c          |  38 +++++--
 drivers/net/ethernet/intel/igc/igc_main.c          |   3 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   1 -
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |   1 +
 drivers/net/ethernet/mellanox/mlxsw/core.c         |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/core_env.c     |  20 ++--
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |  10 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    | 115 +++++++++++++--------
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.h    |   5 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  11 +-
 drivers/net/ethernet/ti/am65-cpts.c                |   5 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |   8 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   2 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   8 +-
 drivers/net/gtp.c                                  |   3 +-
 drivers/net/macsec.c                               |  46 +++++++--
 drivers/net/phy/dp83869.c                          |   3 +-
 drivers/net/phy/mediatek-ge-soc.c                  |  43 +++++---
 drivers/net/usb/ax88179_178a.c                     |  11 +-
 drivers/net/usb/qmi_wwan.c                         |   3 +
 drivers/net/vxlan/vxlan_core.c                     |   4 +
 drivers/net/wireless/ath/ath11k/mac.c              |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   3 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   2 +-
 drivers/nfc/trf7970a.c                             |  42 ++++----
 include/linux/etherdevice.h                        |  25 +++++
 include/net/af_unix.h                              |   3 +
 include/net/bluetooth/hci_core.h                   |   8 +-
 include/net/mac80211.h                             |   3 +
 include/net/macsec.h                               |   2 +
 include/net/sock.h                                 |  40 +++----
 include/net/tls.h                                  |   3 +-
 net/ax25/af_ax25.c                                 |   2 +-
 net/bluetooth/hci_conn.c                           |   6 +-
 net/bluetooth/hci_event.c                          |  25 +++--
 net/bluetooth/hci_sync.c                           |   9 +-
 net/bluetooth/l2cap_core.c                         |   2 +-
 net/bluetooth/l2cap_sock.c                         |   7 +-
 net/bluetooth/mgmt.c                               |  24 +++--
 net/bluetooth/sco.c                                |   7 +-
 net/bridge/br_netlink.c                            |   2 +-
 net/ethernet/eth.c                                 |  12 +--
 net/ipv4/icmp.c                                    |  12 ++-
 net/ipv4/route.c                                   |   3 +
 net/ipv4/tcp_ao.c                                  |   3 +-
 net/ipv4/udp.c                                     |   5 +-
 net/ipv6/udp.c                                     |   5 +-
 net/mac80211/chan.c                                |  27 ++++-
 net/mac80211/mesh.c                                |   8 +-
 net/mac80211/mesh.h                                |  36 ++++++-
 net/mac80211/mesh_pathtbl.c                        |  31 ++++--
 net/mac80211/mlme.c                                |  31 ++++--
 net/mac80211/rate.c                                |   6 +-
 net/mac80211/rx.c                                  |  17 ++-
 net/mac80211/scan.c                                |   1 +
 net/mac80211/tx.c                                  |  13 ++-
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |   6 +-
 net/netfilter/nft_chain_filter.c                   |   4 +-
 net/openvswitch/conntrack.c                        |   4 +-
 net/tls/tls.h                                      |   2 +-
 net/tls/tls_strp.c                                 |   6 +-
 net/unix/garbage.c                                 |   2 +-
 net/wireless/nl80211.c                             |   2 +
 net/wireless/trace.h                               |   4 +-
 tools/net/ynl/lib/ynl.py                           |   1 +
 85 files changed, 831 insertions(+), 385 deletions(-)

