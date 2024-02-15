Return-Path: <linux-kernel+bounces-67393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BC3856AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0868285B18
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905A312882C;
	Thu, 15 Feb 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5W0+ggk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD3136676;
	Thu, 15 Feb 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017687; cv=none; b=acdOrz/E24K8xInF1W96sZlOLRyKbhDr915DGVNsSEjciGhuQGChBqrWC88I8aObLxqANDrTF7Ps3sInE48BLJ+1Fz8N/lX5+y/YtC7nUaU1PHE/BXSE5bZggFzKzQOLHozs9SQPag+U8SmTB4BOqKdGBwyNHcHg1fYAaOR+Dm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017687; c=relaxed/simple;
	bh=Ewvmk35fJMqC+64TDSr4ZQqvpKrjdh6e8nzRlZgkAcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B53UoUa/OKLn25VGyuVATUvGfuybMTou6q00R+1adkzQx7dPDBKA35xrf6nMOUjeSU3jQ5MC3iCm1eVU7zVwjaPcRowWMsmEoIMRmU+ncoMYoRTK10r/C2VJpw5JQ7q3HQ8gdOutpYW7bpuIkYUKqg9u8wevJU5ncZ6v/SRvOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5W0+ggk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A77C433C7;
	Thu, 15 Feb 2024 17:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708017686;
	bh=Ewvmk35fJMqC+64TDSr4ZQqvpKrjdh6e8nzRlZgkAcU=;
	h=From:To:Cc:Subject:Date:From;
	b=U5W0+ggk+ZYsj4BnA1LFi5qoTFwGYnG844Sn+Nva22TMWys9WCxb1XkDL4EkFljDv
	 0BR9dfkeYMc4dATph1I+Hh67uTLmg3Zguv8a6xg1/BvCOCoitWXnMAlfhcqTdsuVmV
	 g3rswGXuUlVQfSzRX5lIPj3SstQbdlrrtUevjvokvmKhlS1NpsfE2MmOuf3XENFZHV
	 5HV0Er/Nof3rKGlL111TRNWQ2OHiy/8clSfK7s4gKGFa9hZRl/rLGB+TJf+neNOf0I
	 /LgIqxGRREH8xAA2GqZTz4V+0xBknuhxaoAyDiXs9X/NdZDdy3VZbCagY7vXGQl++B
	 PUAwox5WdNf9A==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.8-rc5
Date: Thu, 15 Feb 2024 09:21:25 -0800
Message-ID: <20240215172125.400403-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 1f719a2f3fa67665578c759ac34fd3d3690c1a20:

  Merge tag 'net-6.8-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-02-08 15:09:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc5

for you to fetch changes up to c40c0d3a768c78a023a72fb2ceea00743e3a695d:

  Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue (2024-02-15 08:06:51 -0800)

----------------------------------------------------------------
Including fixes from can, wireless and netfilter.

Current release - regressions:

 - af_unix: fix task hung while purging oob_skb in GC

 - pds_core: do not try to run health-thread in VF path

Current release - new code bugs:

 - sched: act_mirred: don't zero blockid when net device is being deleted

Previous releases - regressions:

 - netfilter:
   - nat: restore default DNAT behavior
   - nf_tables: fix bidirectional offload, broken when unidirectional
     offload support was added

 - openvswitch: limit the number of recursions from action sets

 - eth: i40e: do not allow untrusted VF to remove administratively
   set MAC address

Previous releases - always broken:

 - tls: fix races and bugs in use of async crypto

 - mptcp: prevent data races on some of the main socket fields,
   fix races in fastopen handling

 - dpll: fix possible deadlock during netlink dump operation

 - dsa: lan966x: fix crash when adding interface under a lag
   when some of the ports are disabled

 - can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

Misc:

 - handful of fixes and reliability improvements for selftests

 - fix sysfs documentation missing net/ in paths

 - finish the work of squashing the missing MODULE_DESCRIPTION()
   warnings in networking

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaron Conole (2):
      net: openvswitch: limit the number of recursions from action sets
      selftests: openvswitch: Add validation for the recursion test

Allison Henderson (1):
      net:rds: Fix possible deadlock in rds_message_put

Arnd Bergmann (2):
      bnad: fix work_queue type mismatch
      ethernet: cpts: fix function pointer cast warnings

Breno Leitao (17):
      net: fill in MODULE_DESCRIPTION()s for xfrm
      net: fill in MODULE_DESCRIPTION()s for mpoa
      net: fill in MODULE_DESCRIPTION()s for af_key
      net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
      net: fill in MODULE_DESCRIPTION()s for ipv6 modules
      net: fill in MODULE_DESCRIPTION()s for ipv4 modules
      net: fill in MODULE_DESCRIPTION()s for net/sched
      net: fill in MODULE_DESCRIPTION()s for ipvtap
      net: fill in MODULE_DESCRIPTION()s for dsa_loop_bdinfo
      net: sysfs: Fix /sys/class/net/<iface> path for statistics
      net: fill in MODULE_DESCRIPTION()s for xen-netback
      net: fill in MODULE_DESCRIPTION()s for ieee802154/fakelb
      net: fill in MODULE_DESCRIPTION()s for plip
      net: fill in MODULE_DESCRIPTION()s for fddik/skfp
      net: fill in MODULE_DESCRIPTION()s for ppp
      net: fill in MODULE_DESCRIPTION()s for mdio_devres
      net: fill in MODULE_DESCRIPTION()s for missing arcnet

Chuck Lever (1):
      net/handshake: Fix handshake_req_destroy_test1

Dan Carpenter (2):
      wifi: iwlwifi: Fix some error codes
      wifi: iwlwifi: uninitialized variable in iwl_acpi_get_ppag_table()

Daniel Gabay (1):
      wifi: iwlwifi: mvm: use correct address 3 in A-MSDU

Dave Ertman (1):
      ice: Add check for lport extraction to LAG init

David S. Miller (4):
      Merge branch 'tls-fixes'
      Merge branch 'net-misplaced-fields'
      Merge branch 'mptcp-misc-fixes'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Dmitry Antipov (2):
      net: smc: fix spurious error message from __sock_release()
      net: sctp: fix skb leak in sctp_inq_free()

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix a crash when we run out of stations

Eric Dumazet (4):
      tcp: move tp->scaling_ratio to tcp_sock_read_txrx group
      tcp: move tp->tcp_usec_ts to tcp_sock_read_txrx group
      net-device: move lstats in net_device_read_txrx
      net: add rcu safety to rtnl_prop_list_size()

Felix Fietkau (1):
      netfilter: nf_tables: fix bidirectional offload regression

Florian Fainelli (1):
      net: bcmasp: Handle RX buffer allocation failure

Gavrilov Ilia (1):
      pppoe: Fix memory leak in pppoe_sendmsg()

Geliang Tang (2):
      mptcp: check addrs list in userspace_pm_get_local_id
      MAINTAINERS: update Geliang's email address

Horatiu Vultur (1):
      lan966x: Fix crash when adding interface under a lag

Ido Schimmel (5):
      selftests: net: Fix bridge backup port test flakiness
      selftests: forwarding: Fix layer 2 miss test flakiness
      selftests: forwarding: Fix bridge MDB test flakiness
      selftests: forwarding: Suppress grep warnings
      selftests: forwarding: Fix bridge locked port test flakiness

Ivan Vecera (3):
      i40e: Do not allow untrusted VF to remove administratively set MAC
      i40e: Fix waiting for queues of all VSIs to be disabled
      i40e: Fix wrong mask used during DCB config

Jakub Kicinski (14):
      Merge branch 'selftests-forwarding-various-fixes'
      Merge branch 'net-openvswitch-limit-the-recursions-from-action-sets'
      Merge branch 'net-fix-module_description-for-net-p5'
      net: tls: factor out tls_*crypt_async_wait()
      tls: fix race between async notify and socket close
      tls: fix race between tx work scheduling and socket close
      net: tls: handle backlogging of crypto requests
      selftests: tls: use exact comparison in recv_partial
      net: tls: fix returned read length with async decrypt
      Merge branch 'selftests-net-more-pmtu-sh-fixes'
      Merge tag 'wireless-2024-02-14' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      selftests: tls: increase the wait in poll_partial_rec_async
      Merge branch 'fix-module_description-for-net-p6'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Jiri Pirko (2):
      dpll: fix possible deadlock during netlink dump operation
      net/mlx5: DPLL, Fix possible use after free after delayed work timer triggers

Johannes Berg (1):
      wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()

Keqi Wang (1):
      connector/cn_proc: revert "connector: Fix proc_event_num_listeners count not cleared"

Kuniyuki Iwashima (1):
      af_unix: Fix task hung while purging oob_skb in GC.

Kunwu Chan (1):
      igb: Fix string truncation warnings in igb_set_fw_version

Kyle Swenson (1):
      netfilter: nat: restore default DNAT behavior

Maciej Fijalkowski (2):
      i40e: avoid double calling i40e_pf_rxq_wait()
      i40e: take into account XDP Tx queues when stopping rings

Magnus Karlsson (1):
      bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY

Maxim Galaganov (1):
      selftests: net: ip_local_port_range: define IPPROTO_MPTCP

Maxime Jayat (1):
      can: netlink: Fix TDCO calculation using the old data bittiming

Miri Korenblit (1):
      wifi: iwlwifi: clear link_id in time_event

Oleksij Rempel (1):
      can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Pablo Neira Ayuso (1):
      netfilter: nft_set_pipapo: fix missing : in kdoc

Paolo Abeni (12):
      selftests: net: add more missing kernel config
      mptcp: drop the push_pending field
      mptcp: fix rcv space initialization
      mptcp: fix more tx path fields initialization
      mptcp: corner case locking for rx path fields initialization
      mptcp: really cope with fastopen race
      selftests: net: cope with slow env in gro.sh test
      selftests: net: cope with slow env in so_txtime.sh test
      selftests: net: more strict check in net_helper
      selftests: net: more pmtu.sh fixes
      Merge tag 'linux-can-fixes-for-6.8-20240214' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'nf-24-02-15' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Parav Pandit (1):
      devlink: Fix command annotation documentation

Paul Barker (1):
      net: ravb: Count packets instead of descriptors in GbEth RX path

Randy Dunlap (1):
      net: ti: icssg-prueth: add dependency for PTP

Sabrina Dubroca (1):
      net: tls: fix use-after-free with partial reads and async decrypt

Sasha Neftin (1):
      igc: Remove temporary workaround

Shannon Nelson (2):
      ionic: minimal work with 0 budget
      pds_core: no health-thread in VF path

Simon Horman (1):
      net: stmmac: xgmac: use #define for string constants

Subbaraya Sundeep (1):
      octeontx2-af: Remove the PF_FUNC validation for NPC transmit rules

Vadim Fedorenko (1):
      net-timestamp: make sk_tskey more predictable in error path

Victor Nogueira (1):
      net/sched: act_mirred: Don't zero blockid when net device is being deleted

Ziqi Zhao (1):
      can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

 .mailmap                                           |   9 +-
 .../ABI/testing/sysfs-class-net-statistics         |  48 ++++----
 Documentation/netlink/specs/dpll.yaml              |   4 -
 Documentation/networking/devlink/devlink-port.rst  |   2 +-
 .../networking/net_cachelines/net_device.rst       |   4 +-
 .../networking/net_cachelines/tcp_sock.rst         |   4 +-
 MAINTAINERS                                        |   2 +-
 drivers/connector/cn_proc.c                        |   5 +-
 drivers/dpll/dpll_netlink.c                        |  20 +--
 drivers/dpll/dpll_nl.c                             |   4 -
 drivers/dpll/dpll_nl.h                             |   2 -
 drivers/net/arcnet/arc-rawmode.c                   |   1 +
 drivers/net/arcnet/arc-rimi.c                      |   1 +
 drivers/net/arcnet/capmode.c                       |   1 +
 drivers/net/arcnet/com20020-pci.c                  |   1 +
 drivers/net/arcnet/com20020.c                      |   1 +
 drivers/net/arcnet/com20020_cs.c                   |   1 +
 drivers/net/arcnet/com90io.c                       |   1 +
 drivers/net/arcnet/com90xx.c                       |   1 +
 drivers/net/arcnet/rfc1051.c                       |   1 +
 drivers/net/arcnet/rfc1201.c                       |   1 +
 drivers/net/bonding/bond_main.c                    |   5 +-
 drivers/net/can/dev/netlink.c                      |   2 +-
 drivers/net/dsa/dsa_loop_bdinfo.c                  |   1 +
 drivers/net/ethernet/amd/pds_core/main.c           |   6 +
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |   3 +
 drivers/net/ethernet/brocade/bna/bnad.c            |  12 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  24 ++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  38 +++++-
 drivers/net/ethernet/intel/ice/ice_lag.c           |  25 +++-
 drivers/net/ethernet/intel/ice/ice_lag.h           |   3 +
 drivers/net/ethernet/intel/igb/igb.h               |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  35 +++---
 drivers/net/ethernet/intel/igc/igc_phy.c           |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  32 -----
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |   2 +-
 .../net/ethernet/microchip/lan966x/lan966x_lag.c   |   9 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |   9 ++
 drivers/net/ethernet/renesas/ravb_main.c           |  22 ++--
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  69 +++++------
 drivers/net/ethernet/ti/Kconfig                    |   1 +
 drivers/net/ethernet/ti/cpts.c                     |  17 ++-
 drivers/net/fddi/skfp/skfddi.c                     |   1 +
 drivers/net/ieee802154/fakelb.c                    |   1 +
 drivers/net/ipvlan/ipvtap.c                        |   1 +
 drivers/net/phy/mdio_devres.c                      |   1 +
 drivers/net/plip/plip.c                            |   1 +
 drivers/net/ppp/bsd_comp.c                         |   1 +
 drivers/net/ppp/ppp_async.c                        |   1 +
 drivers/net/ppp/ppp_deflate.c                      |   1 +
 drivers/net/ppp/ppp_generic.c                      |   1 +
 drivers/net/ppp/ppp_synctty.c                      |   1 +
 drivers/net/ppp/pppoe.c                            |  23 ++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  15 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   4 +
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  73 +++++++++--
 drivers/net/xen-netback/netback.c                  |   1 +
 include/linux/netdevice.h                          |  10 +-
 include/linux/tcp.h                                |   6 +-
 include/net/tls.h                                  |   5 -
 net/6lowpan/core.c                                 |   1 +
 net/atm/mpc.c                                      |   1 +
 net/can/j1939/j1939-priv.h                         |   3 +-
 net/can/j1939/main.c                               |   2 +-
 net/can/j1939/socket.c                             |  46 ++++---
 net/core/dev.c                                     |   5 +-
 net/core/rtnetlink.c                               |  15 ++-
 net/handshake/handshake-test.c                     |   5 +-
 net/ipv4/ah4.c                                     |   1 +
 net/ipv4/esp4.c                                    |   1 +
 net/ipv4/ip_gre.c                                  |   1 +
 net/ipv4/ip_output.c                               |  13 +-
 net/ipv4/ip_tunnel.c                               |   1 +
 net/ipv4/ip_vti.c                                  |   1 +
 net/ipv4/ipip.c                                    |   1 +
 net/ipv4/tcp.c                                     |   3 +-
 net/ipv4/tunnel4.c                                 |   1 +
 net/ipv4/udp_tunnel_core.c                         |   1 +
 net/ipv4/xfrm4_tunnel.c                            |   1 +
 net/ipv6/ah6.c                                     |   1 +
 net/ipv6/esp6.c                                    |   1 +
 net/ipv6/ip6_output.c                              |  13 +-
 net/ipv6/ip6_udp_tunnel.c                          |   1 +
 net/ipv6/mip6.c                                    |   1 +
 net/ipv6/sit.c                                     |   1 +
 net/ipv6/tunnel6.c                                 |   1 +
 net/ipv6/xfrm6_tunnel.c                            |   1 +
 net/key/af_key.c                                   |   1 +
 net/mac80211/tx.c                                  |   5 +-
 net/mptcp/fastopen.c                               |   6 +-
 net/mptcp/options.c                                |   9 +-
 net/mptcp/pm_userspace.c                           |  13 +-
 net/mptcp/protocol.c                               |  31 ++---
 net/mptcp/protocol.h                               |  16 +--
 net/mptcp/subflow.c                                |  71 ++++++-----
 net/netfilter/nf_nat_core.c                        |   5 +-
 net/netfilter/nft_flow_offload.c                   |   1 +
 net/netfilter/nft_set_pipapo.h                     |   4 +-
 net/openvswitch/flow_netlink.c                     |  49 +++++---
 net/rds/recv.c                                     |  13 +-
 net/sched/act_mirred.c                             |   2 -
 net/sched/em_canid.c                               |   1 +
 net/sched/em_cmp.c                                 |   1 +
 net/sched/em_meta.c                                |   1 +
 net/sched/em_nbyte.c                               |   1 +
 net/sched/em_text.c                                |   1 +
 net/sched/em_u32.c                                 |   1 +
 net/sctp/inqueue.c                                 |  14 ++-
 net/smc/af_smc.c                                   |   1 +
 net/tls/tls_sw.c                                   | 135 ++++++++++-----------
 net/unix/garbage.c                                 |   7 +-
 net/xfrm/xfrm_algo.c                               |   1 +
 net/xfrm/xfrm_user.c                               |   1 +
 tools/testing/selftests/net/config                 |   6 +-
 .../selftests/net/forwarding/bridge_locked_port.sh |   4 +-
 .../testing/selftests/net/forwarding/bridge_mdb.sh |  14 ++-
 .../selftests/net/forwarding/tc_flower_l2_miss.sh  |   8 +-
 tools/testing/selftests/net/gro.sh                 |   5 +
 tools/testing/selftests/net/ip_local_port_range.c  |   4 +
 tools/testing/selftests/net/net_helper.sh          |  11 +-
 .../selftests/net/openvswitch/openvswitch.sh       |  13 ++
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |  71 ++++++++---
 tools/testing/selftests/net/pmtu.sh                |   4 +-
 tools/testing/selftests/net/so_txtime.sh           |  29 ++++-
 .../selftests/net/test_bridge_backup_port.sh       |  23 ++++
 tools/testing/selftests/net/tls.c                  |  12 +-
 129 files changed, 819 insertions(+), 491 deletions(-)

