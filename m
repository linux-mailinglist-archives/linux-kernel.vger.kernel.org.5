Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11077D00D7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbjJSRrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345646AbjJSRrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:47:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5A8106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:47:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDADCC433C8;
        Thu, 19 Oct 2023 17:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697737657;
        bh=Cv+5AyH2vKzunvSMtHg7hEMfbpW4c9qOwmuC8rQWkxE=;
        h=From:To:Cc:Subject:Date:From;
        b=MMZiJCG8W7HuZr/VWpAcq7V4bPjRk+W5Jb4BX+l8i5YEnUXMEsNJ7WJg/diIsLECV
         dTDUjSRQ7u2H2uD+O3zJe/OVMMqsQD/+nO3eZVyaMP9VYV7vX1/oWhJRgVBA4r+G3x
         bk8oAtdhM0eS+PI1jJBq82M17P//QoEsdRnFtSDU8kZoqHymXonVB7zsoq5DNDiGJa
         hzWMbtga6fiU7lFNVEcYk3FqLZmWw4RdzTq30xWozjJCuRD3H5Soju0t3IsoY2yJMl
         luClwsN66Nc5rHN0bxchGnDPh6RXv+FZPMMImxLUYzVbPF+RMNu74BBT7DBPoKm9oZ
         YJt6rLe1taVSw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.6-rc7
Date:   Thu, 19 Oct 2023 10:47:35 -0700
Message-ID: <20231019174735.1177985-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Happy Nov 1st to you and your surrounding spirits.

The following changes since commit e8c127b0576660da9195504fe8393fe9da3de9ce:

  Merge tag 'net-6.6-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-10-12 13:07:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc7

for you to fetch changes up to 524515020f2552759a7ef1c9d03e7dac9b1ff3c2:

  Revert "ethtool: Fix mod state of verbose no_mask bitset" (2023-10-19 09:27:12 -0700)

----------------------------------------------------------------
Including fixes from bluetooth, netfilter, WiFi.

Feels like an up-tick in regression fixes, mostly for older releases.
The hfsc fix, tcp_disconnect() and Intel WWAN fixes stand out as fairly
clear-cut user reported regressions. The mlx5 DMA bug was causing strife
for 390x folks. The fixes themselves are not particularly scary, tho.
No open investigations / outstanding reports at the time of writing.

Current release - regressions:

 - eth: mlx5: perform DMA operations in the right locations,
   make devices usable on s390x, again

 - sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve,
   previous fix of rejecting invalid config broke some scripts

 - rfkill: reduce data->mtx scope in rfkill_fop_open, avoid deadlock

 - revert "ethtool: Fix mod state of verbose no_mask bitset",
   needs more work

Current release - new code bugs:

 - tcp: fix listen() warning with v4-mapped-v6 address

Previous releases - regressions:

 - tcp: allow tcp_disconnect() again when threads are waiting,
   it was denied to plug a constant source of bugs but turns out
   .NET depends on it

 - eth: mlx5: fix double-free if buffer refill fails under OOM

 - revert "net: wwan: iosm: enable runtime pm support for 7560",
   it's causing regressions and the WWAN team at Intel disappeared

 - tcp: tsq: relax tcp_small_queue_check() when rtx queue contains
   a single skb, fix single-stream perf regression on some devices

Previous releases - always broken:

 - Bluetooth:
   - fix issues in legacy BR/EDR PIN code pairing
   - correctly bounds check and pad HCI_MON_NEW_INDEX name

 - netfilter:
   - more fixes / follow ups for the large "commit protocol" rework,
     which went in as a fix to 6.5
   - fix null-derefs on netlink attrs which user may not pass in

 - tcp: fix excessive TLP and RACK timeouts from HZ rounding
   (bless Debian for keeping HZ=250 alive)

 - net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation, prevent
   letting frankenstein UDP super-frames from getting into the stack

 - net: fix interface altnames when ifc moves to a new namespace

 - eth: qed: fix the size of the RX buffers

 - mptcp: avoid sending RST when closing the initial subflow

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaron Conole (4):
      selftests: openvswitch: Add version check for pyroute2
      selftests: openvswitch: Catch cases where the tests are killed
      selftests: openvswitch: Skip drop testing on older kernels
      selftests: openvswitch: Fix the ct_tuple for v4

Albert Huang (1):
      net/smc: fix smc clc failed issue when netdevice not in init_net

Amir Tzin (1):
      net/mlx5e: Fix VF representors reporting zero counters to "ip -s" command

Arkadiusz Bokowy (1):
      Bluetooth: vhci: Fix race when opening vhci device

Arnd Bergmann (1):
      Bluetooth: avoid memcmp() out of bounds warning

Bagas Sanjaya (1):
      Revert "net: wwan: iosm: enable runtime pm support for 7560"

Christoph Paasch (1):
      netlink: Correct offload_xstats size

Dan Carpenter (1):
      net: usb: smsc95xx: Fix an error code in smsc95xx_reset()

David S. Miller (1):
      Merge branch 'ovs-selftests'

Dong Chenchen (1):
      net: xfrm: skip policies marked as dead while reinserting policies

Dragos Tatulea (3):
      net/mlx5e: RX, Fix page_pool allocation failure recovery for striding rq
      net/mlx5e: RX, Fix page_pool allocation failure recovery for legacy rq
      net/mlx5e: XDP, Fix XDP_REDIRECT mpwqe page fragment leaks on shutdown

Dust Li (1):
      net/smc: return the right falback reason when prefix checks fail

Edward AD (1):
      Bluetooth: hci_sock: fix slab oob read in create_monitor_event

Eric Dumazet (6):
      xfrm: interface: use DEV_STATS_INC()
      xfrm: fix a data-race in xfrm_gen_index()
      xfrm: fix a data-race in xfrm_lookup_with_ifid()
      tun: prevent negative ifindex
      tcp: tsq: relax tcp_small_queue_check() when rtx queue contains a single skb
      ipv4: fib: annotate races around nh->nh_saddr_genid and nh->nh_saddr

Florian Fainelli (1):
      net: phy: bcm7xxx: Add missing 16nm EPHY statistics

Florian Westphal (2):
      netfilter: nfnetlink_log: silence bogus compiler warning
      netfilter: nft_payload: fix wrong mac header matching

Gavrilov Ilia (1):
      net: pktgen: Fix interface flags printing

Geert Uytterhoeven (1):
      neighbor: tracing: Move pin6 inside CONFIG_IPV6=y section

Geliang Tang (1):
      mptcp: avoid sending RST when closing the initial subflow

Ido Schimmel (2):
      selftests: fib_tests: Disable RP filter in multipath list receive test
      selftests: fib_tests: Count all trace point invocations

Iulia Tanasescu (1):
      Bluetooth: ISO: Fix invalid context error

Jakub Kicinski (14):
      Merge branch 'selftests-fib_tests-fixes-for-multipath-list-receive-tests'
      Merge tag 'nf-23-10-12' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'intel-wired-lan-driver-updates-2023-10-11-i40e-ice'
      Merge tag 'mlx5-fixes-2023-10-12' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge tag 'for-net-2023-10-13' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'ipsec-2023-10-17' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge tag 'wireless-2023-10-18' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'nf-23-10-18' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      net: fix ifname in netlink ntf during netns move
      net: check for altname conflicts when changing netdev's netns
      net: avoid UAF on deleted altname
      net: move altnames together with the netdevice
      selftests: net: add very basic test for netdev names and namespaces
      Merge branch 'mptcp-fixes-for-v6-6'

Jesse Brandeburg (2):
      ice: fix over-shifted variable
      ice: reset first in crash dump kernels

Jianbo Liu (1):
      net/mlx5e: Don't offload internal port if filter device is out device

Jinjie Ruan (1):
      net: dsa: bcm_sf2: Fix possible memory leak in bcm_sf2_mdio_register()

Jiri Pirko (1):
      netlink: specs: devlink: fix reply command values

Jiri Wiesner (1):
      bonding: Return pointer to data after pull on skb

Johannes Berg (3):
      wifi: cfg80211: use system_unbound_wq for wiphy work
      wifi: mac80211: fix error path key leak
      net: rfkill: reduce data->mtx scope in rfkill_fop_open

Josua Mayer (1):
      net: rfkill: gpio: prevent value glitch during probe

Kees Cook (2):
      netfilter: nf_tables: Annotate struct nft_pipapo_match with __counted_by
      Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name

Kory Maincent (1):
      Revert "ethtool: Fix mod state of verbose no_mask bitset"

Krzysztof Kozlowski (1):
      nfc: nci: fix possible NULL pointer dereference in send_acknowledge()

Kuniyuki Iwashima (1):
      tcp: Fix listen() warning with v4-mapped-v6 address.

Lama Kayal (1):
      net/mlx5e: Take RTNL lock before triggering netdev notifiers

Lee, Chun-Yi (2):
      Bluetooth: hci_event: Ignore NULL link key
      Bluetooth: Reject connection with the device which has same BD_ADDR

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix using memcmp when comparing keys
      Bluetooth: hci_event: Fix coding style

MD Danish Anwar (3):
      net: ti: icssg-prueth: Fix tx_total_bytes count
      net: ethernet: ti: Fix mixed module-builtin object
      net: ti: icssg-prueth: Fix r30 CMDs bitmasks

Ma Ke (2):
      net: ipv6: fix return value check in esp_remove_trailer
      net: ipv4: fix return value check in esp_remove_trailer

Maher Sanalla (1):
      net/mlx5: Handle fw tracer change ownership event based on MTRC

Manish Chopra (1):
      qed: fix LL2 RX buffer allocation

Mateusz Pacuszka (1):
      ice: Fix safe mode when DDP is missing

Mateusz Polchlopek (1):
      docs: fix info about representor identification

Matthieu Baerts (2):
      selftests: mptcp: join: correctly check for no RST
      selftests: mptcp: join: no RST when rm subflow/addr

Max Chou (1):
      Bluetooth: btrtl: Ignore error return for hci_devcd_register()

Michal Schmidt (1):
      i40e: prevent crash on probe if hw registers have invalid values

Neal Cardwell (1):
      tcp: fix excessive TLP and RACK timeouts from HZ rounding

Pablo Neira Ayuso (4):
      netfilter: nf_tables: do not remove elements if set backend implements .abort
      netfilter: nf_tables: do not refresh timeout when resetting element
      netfilter: nft_set_rbtree: .deactivate fails if element has expired
      netfilter: nf_tables: revert do not remove elements if set backend implements .abort

Paolo Abeni (5):
      tcp: allow again tcp_disconnect() when threads are waiting
      tcp_bpf: properly release resources on error paths
      Merge branch 'net-fix-bugs-in-device-netns-move-and-rename'
      tcp: check mptcp-level constraints for backlog coalescing
      mptcp: more conservative check for zero probes

Pauli Virtanen (1):
      Bluetooth: hci_sync: always check if connection is alive before deleting

Pedro Tammela (1):
      net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner curve

Phil Sutter (2):
      netfilter: nf_tables: audit log object reset once per table
      selftests: netfilter: Run nft_audit.sh in its own netns

Shailend Chand (1):
      gve: Do not fully free QPL pages on prefill errors

Shay Drory (2):
      net/mlx5: Perform DMA operations in the right locations
      net/mlx5: E-switch, register event handler before arming the event

Shinas Rasheed (1):
      octeon_ep: update BQL sent bytes before ringing doorbell

Vlad Buslov (1):
      net/mlx5: Bridge, fix peer entry ageing in LAG mode

Vladimir Oltean (1):
      net: mdio-mux: fix C45 access returning -EIO after API change

Willem de Bruijn (1):
      net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation

Xingyuan Mo (2):
      nf_tables: fix NULL pointer dereference in nft_inner_init()
      nf_tables: fix NULL pointer dereference in nft_expr_inner_parse()

Zhang Changzhong (1):
      xfrm6: fix inet6_dev refcount underflow problem

Ziyang Xuan (1):
      Bluetooth: Fix a refcnt underflow problem for hci_conn

 Documentation/netlink/specs/devlink.yaml           | 18 ++---
 Documentation/networking/representors.rst          |  8 +-
 drivers/bluetooth/btrtl.c                          | 10 +--
 drivers/bluetooth/hci_vhci.c                       |  3 +
 drivers/net/bonding/bond_main.c                    |  2 +-
 drivers/net/dsa/bcm_sf2.c                          | 24 +++---
 .../chelsio/inline_crypto/chtls/chtls_io.c         | 36 +++++++--
 drivers/net/ethernet/google/gve/gve_rx.c           | 18 ++++-
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  3 +-
 drivers/net/ethernet/intel/ice/ice_main.c          | 18 +++++
 .../net/ethernet/marvell/octeon_ep/octep_main.c    | 13 ++--
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      | 64 +++++++---------
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    | 11 +++
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |  3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |  8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   | 10 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    | 35 ++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h | 11 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  5 +-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   | 25 ++++++-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.h   |  3 +
 .../ethernet/mellanox/mlx5/core/esw/bridge_priv.h  |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  | 17 ++---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |  7 +-
 drivers/net/ethernet/ti/Kconfig                    |  5 ++
 drivers/net/ethernet/ti/Makefile                   |  7 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c       |  4 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c        |  9 +++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c        | 10 +++
 drivers/net/mdio/mdio-mux.c                        | 47 ++++++++++++
 drivers/net/phy/bcm7xxx.c                          |  3 +
 drivers/net/tun.c                                  |  7 +-
 drivers/net/usb/smsc95xx.c                         |  2 +-
 drivers/net/wwan/iosm/iosm_ipc_imem.c              | 17 -----
 drivers/net/wwan/iosm/iosm_ipc_imem.h              |  2 -
 drivers/net/wwan/iosm/iosm_ipc_pcie.c              |  4 +-
 drivers/net/wwan/iosm/iosm_ipc_port.c              | 17 +----
 drivers/net/wwan/iosm/iosm_ipc_trace.c             |  8 --
 drivers/net/wwan/iosm/iosm_ipc_wwan.c              | 21 +-----
 include/linux/virtio_net.h                         | 19 ++++-
 include/net/bluetooth/hci_mon.h                    |  2 +-
 include/net/netns/xfrm.h                           |  1 +
 include/net/sock.h                                 | 10 +--
 include/net/tcp.h                                  |  3 +
 include/trace/events/neigh.h                       |  4 +-
 net/bluetooth/hci_conn.c                           |  9 +++
 net/bluetooth/hci_event.c                          | 48 +++++++++---
 net/bluetooth/hci_sock.c                           |  3 +-
 net/bluetooth/hci_sync.c                           | 26 +++----
 net/core/dev.c                                     | 65 ++++++++++++----
 net/core/dev.h                                     |  3 +
 net/core/pktgen.c                                  | 14 ++--
 net/core/rtnetlink.c                               |  4 +-
 net/core/stream.c                                  | 12 +--
 net/ethtool/bitset.c                               | 32 ++------
 net/ipv4/af_inet.c                                 | 10 ++-
 net/ipv4/esp4.c                                    |  4 +-
 net/ipv4/fib_semantics.c                           | 14 ++--
 net/ipv4/inet_connection_sock.c                    |  1 -
 net/ipv4/inet_hashtables.c                         | 24 +++---
 net/ipv4/tcp.c                                     | 16 ++--
 net/ipv4/tcp_bpf.c                                 | 12 +++
 net/ipv4/tcp_ipv4.c                                |  1 +
 net/ipv4/tcp_output.c                              | 25 +++++--
 net/ipv4/tcp_recovery.c                            |  2 +-
 net/ipv6/esp6.c                                    |  4 +-
 net/ipv6/xfrm6_policy.c                            |  4 +-
 net/mac80211/key.c                                 |  3 +-
 net/mptcp/protocol.c                               | 43 ++++++-----
 net/netfilter/nf_tables_api.c                      | 70 +++++++++--------
 net/netfilter/nfnetlink_log.c                      |  2 +-
 net/netfilter/nft_inner.c                          |  1 +
 net/netfilter/nft_payload.c                        |  2 +-
 net/netfilter/nft_set_pipapo.h                     |  2 +-
 net/netfilter/nft_set_rbtree.c                     |  2 +
 net/nfc/nci/spi.c                                  |  2 +
 net/rfkill/core.c                                  |  5 +-
 net/rfkill/rfkill-gpio.c                           |  4 +-
 net/sched/sch_hfsc.c                               | 18 ++++-
 net/smc/af_smc.c                                   |  5 +-
 net/smc/smc_ib.c                                   |  7 +-
 net/smc/smc_ib.h                                   |  2 +-
 net/tls/tls_main.c                                 | 10 ++-
 net/tls/tls_sw.c                                   | 19 +++--
 net/wireless/core.c                                |  2 +-
 net/xfrm/xfrm_interface_core.c                     | 22 +++---
 net/xfrm/xfrm_policy.c                             | 27 ++++---
 tools/net/ynl/generated/devlink-user.c             | 54 +++++++-------
 tools/testing/selftests/net/Makefile               |  1 +
 tools/testing/selftests/net/fib_tests.sh           |  7 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 21 +++++-
 tools/testing/selftests/net/netns-name.sh          | 87 ++++++++++++++++++++++
 .../selftests/net/openvswitch/openvswitch.sh       | 21 +++++-
 .../testing/selftests/net/openvswitch/ovs-dpctl.py | 48 +++++++++++-
 tools/testing/selftests/netfilter/nft_audit.sh     | 52 +++++++++++++
 97 files changed, 967 insertions(+), 466 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns-name.sh
