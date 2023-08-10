Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47AB7780E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjHJS71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjHJS7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7569626BC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A5166722
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228C6C433C7;
        Thu, 10 Aug 2023 18:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691693963;
        bh=zV8iXn482Xl44urEsvg1+8q3ua3/0QByt+8pojQG1WQ=;
        h=From:To:Cc:Subject:Date:From;
        b=rJ8lGztYkhyTMWSlzDA9vF27YeW5aUOos3lv4sG0uiOrY7Y78IQz9hyks/RKe/g2D
         iPxN9b/EAQ1v7mkb1rFA8qJLog+FZxBErqf2wMBSodQrl3mGbgIhdZ1Sop4ov5QfVN
         8IV0HAOpILs3349AJ/Fb6E2+qUgrz65OaORNN94JPu3wYuj279+vjhZiu77yNx2oIu
         +xQqLmZTBWHcJWri475u0mUPUBTlqdHoy8GUiZkfVsUb93FJHfv1lf/Re0qluUw0C2
         tblWzWTG26DVonLAOBiYloQVAoDVHZ3zgrNJCZ8DHTD+uNyjuP/rXKjO18IwOTDur0
         /cyyX2LacZvtA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.5-rc6
Date:   Thu, 10 Aug 2023 11:59:22 -0700
Message-ID: <20230810185922.92197-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The following changes since commit 999f6631866e9ea81add935b9c6ebaab0579d259:

  Merge tag 'net-6.5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-08-03 14:00:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc6

for you to fetch changes up to 5e3d20617b055e725e785e0058426368269949f3:

  net: hns3: fix strscpy causing content truncation issue (2023-08-10 11:47:56 -0700)

----------------------------------------------------------------
Including fixes from netfilter, wireless and bpf.

Still trending up in size but the good news is that the "current"
regressions are resolved, AFAIK.

We're getting weirdly many fixes for Wake-on-LAN and suspend/resume
handling on embedded this week (most not merged yet), not sure why.
But those are all for older bugs.

Current release - regressions:

 - tls: set MSG_SPLICE_PAGES consistently when handing encrypted
   data over to TCP

Current release - new code bugs:

 - eth: mlx5: correct IDs on VFs internal to the device (IPU)

Previous releases - regressions:

 - phy: at803x: fix WoL support / reporting on AR8032

 - bonding: fix incorrect deletion of ETH_P_8021AD protocol VID
   from slaves, leading to BUG_ON()

 - tun: prevent tun_build_skb() from exceeding the packet size limit

 - wifi: rtw89: fix 8852AE disconnection caused by RX full flags

 - eth/PCI: enetc: fix probing after 6fffbc7ae137 ("PCI: Honor
   firmware's device disabled status"), keep PCI devices around
   even if they are disabled / not going to be probed to be
   able to apply quirks on them

 - eth: prestera: fix handling IPv4 routes with nexthop IDs

Previous releases - always broken:

 - netfilter: re-work garbage collection to avoid races between
   user-facing API and timeouts

 - tunnels: fix generating ipv4 PMTU error on non-linear skbs

 - nexthop: fix infinite nexthop bucket dump when using maximum
   nexthop ID

 - wifi: nl80211: fix integer overflow in nl80211_parse_mbssid_elems()

Misc:

 - unix: use consistent error code in SO_PEERPIDFD

 - ipv6: adjust ndisc_is_useropt() to include PREFIX_INFO,
   in prep for upcoming IETF RFC

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Andrea Claudi (2):
      selftests: mptcp: join: fix 'delete and re-add' test
      selftests: mptcp: join: fix 'implicit EP' test

Andrew Kanner (2):
      drivers: net: prevent tun_build_skb() to exceed the packet size limit
      net: core: remove unnecessary frame_sz check in bpf_xdp_adjust_tail()

Chris Mi (1):
      net/mlx5e: Unoffload post act rule when handling FIB events

Claudiu Beznea (1):
      MAINTAINERS: update Claudiu Beznea's email address

Daniel Jurgens (3):
      net/mlx5: Return correct EC_VF function ID
      net/mlx5: Allow 0 for total host VFs
      net/mlx5: Fix devlink controller number for ECVF

David Rheinsberg (1):
      net/unix: use consistent error code in SO_PEERPIDFD

David S. Miller (3):
      Merge branch 'at803x-wol'
      Merge branch 'enetc-probe-fix'
      Merge branch 'smc-fixes'

Eric Dumazet (4):
      net/packet: annotate data-races around tp->status
      dccp: fix data-race around dp->dccps_mss_cache
      macsec: use DEV_STATS_INC()
      tcp: add missing family to tcp_set_ca_state() tracepoint

Fedor Pchelkin (1):
      drivers: vxlan: vnifilter: free percpu vni stats on error path

Felix Fietkau (1):
      wifi: cfg80211: fix sband iftype data lookup for AP_VLAN

Florian Westphal (3):
      tunnels: fix kasan splat when generating ipv4 pmtu error
      selftests: net: test vxlan pmtu exceptions with tcp
      netfilter: nf_tables: don't skip expired elements during walk

Gal Pressman (1):
      net/mlx5e: Take RTNL lock when needed before calling xdp_set_features()

Gerd Bayer (2):
      net/smc: Fix setsockopt and sysctl to specify same buffer size again
      net/smc: Use correct buffer sizes when switching between TCP and SMC

Hao Chen (1):
      net: hns3: fix strscpy causing content truncation issue

Ido Schimmel (20):
      nexthop: Fix infinite nexthop dump when using maximum nexthop ID
      nexthop: Make nexthop bucket dump more efficient
      nexthop: Fix infinite nexthop bucket dump when using maximum nexthop ID
      selftests: forwarding: Skip test when no interfaces are specified
      selftests: forwarding: Switch off timeout
      selftests: forwarding: bridge_mdb: Check iproute2 version
      selftests: forwarding: bridge_mdb_max: Check iproute2 version
      selftests: forwarding: Set default IPv6 traceroute utility
      selftests: forwarding: Add a helper to skip test when using veth pairs
      selftests: forwarding: ethtool: Skip when using veth pairs
      selftests: forwarding: ethtool_extended_state: Skip when using veth pairs
      selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
      selftests: forwarding: ethtool_mm: Skip when MAC Merge is not supported
      selftests: forwarding: tc_actions: Use ncat instead of nc
      selftests: forwarding: tc_flower: Relax success criterion
      selftests: forwarding: tc_tunnel_key: Make filters more specific
      selftests: forwarding: tc_flower_l2_miss: Fix failing test with old libnet
      selftests: forwarding: bridge_mdb: Fix failing test with old libnet
      selftests: forwarding: bridge_mdb_max: Fix failing test with old libnet
      selftests: forwarding: bridge_mdb: Make test more robust

Jakub Kicinski (12):
      Merge branch 'tunnels-fix-ipv4-pmtu-icmp-checksum'
      Merge branch 'mptcp-more-fixes-for-v6-5'
      net: tls: avoid discarding data on record close
      Merge branch 'wireguard-fixes-for-6-5-rc6'
      Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'
      Merge tag 'mlx5-fixes-2023-08-07' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'nexthop-nexthop-dump-fixes'
      Merge branch 'selftests-forwarding-various-fixes'
      Merge tag 'wireless-2023-08-09' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'nf-23-08-10' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      net: tls: set MSG_SPLICE_PAGES consistently

Jason A. Donenfeld (1):
      wireguard: allowedips: expand maximum node depth

Jian Shen (1):
      net: hns3: restore user pause configure when disable autoneg

Jianbo Liu (1):
      net/mlx5e: TC, Fix internal port memory leak

Jie Wang (2):
      net: hns3: refactor hclge_mac_link_status_wait for interface reuse
      net: hns3: add wait until mac link down

Jonas Gorski (1):
      net: marvell: prestera: fix handling IPv4 routes with nhid

Keith Yeo (1):
      wifi: nl80211: fix integer overflow in nl80211_parse_mbssid_elems()

Lama Kayal (1):
      net/mlx5e: Add capability check for vnic counters

Larry Finger (2):
      MAINTAINERS: Update entry for rtl8187
      MAINTAINERS: Remove tree entry for rtl8180

Li Yang (2):
      net: phy: at803x: fix the wol setting functions
      net: phy: at803x: remove set/get wol callbacks for AR8032

Maciej Żenczykowski (1):
      ipv6: adjust ndisc_is_useropt() to also return true for PIO

Magnus Karlsson (1):
      xsk: fix refcount underflow in error path

Martin KaFai Lau (1):
      Merge branch 'bug fixes for sockmap'

Moshe Shemesh (2):
      net/mlx5: Skip clock update work when device is in error state
      net/mlx5: Reload auxiliary devices in pci error handlers

Muhammad Husaini Zulkifli (1):
      igc: Add lock to safeguard global Qbv variables

Nathan Chancellor (1):
      mISDN: Update parameter type of dsp_cmx_send()

Nick Child (5):
      ibmvnic: Enforce stronger sanity checks on login response
      ibmvnic: Unmap DMA login rsp buffer on send login fail
      ibmvnic: Handle DMA unmapping of login buffs in release functions
      ibmvnic: Do partial reset on login failure
      ibmvnic: Ensure login failure recovery is safe from other resets

Nitya Sunkad (1):
      ionic: Add missing err handling for queue reconfig

Pablo Neira Ayuso (4):
      netfilter: nf_tables: GC transaction API to avoid race with control plane
      netfilter: nf_tables: adapt set backend to use GC transaction API
      netfilter: nft_set_hash: mark set element as dead when deleting from packet path
      netfilter: nf_tables: remove busy mark and gc batch API

Paolo Abeni (2):
      mptcp: avoid bogus reset on fallback close
      mptcp: fix disconnect vs accept race

Petr Tesarik (1):
      wifi: brcm80211: handle params_v1 allocation failure

Ping-Ke Shih (1):
      wifi: rtw89: fix 8852AE disconnection caused by RX full flags

Piotr Gardocki (1):
      iavf: fix potential races for FDIR filters

Shay Drory (1):
      net/mlx5: LAG, Check correct bucket when modifying LAG

Souradeep Chakrabarti (1):
      net: mana: Fix MANA VF unload when hardware is unresponsive

Vlad Buslov (1):
      vlan: Fix VLAN 0 memory leak

Vladimir Oltean (4):
      net: dsa: ocelot: call dsa_tag_8021q_unregister() under rtnl_lock() on driver remove
      PCI: move OF status = "disabled" detection to dev->match_driver
      net: enetc: reimplement RFS/RSS memory clearing as PCI quirk
      net: enetc: remove of_device_is_available() handling

Wen Gong (1):
      wifi: ath12k: Fix buffer overflow when scanning with extraie

Xiang Yang (1):
      mptcp: fix the incorrect judgment for msk->cb_flags

Xu Kuohai (4):
      bpf, sockmap: Fix map type error in sock_map_del_link
      bpf, sockmap: Fix bug that strp_done cannot be called
      selftests/bpf: fix a CI failure caused by vsock sockmap test
      selftests/bpf: Add sockmap test for redirecting partial skb data

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix wrong allocation of modify hdr pattern

Yonglong Liu (1):
      net: hns3: fix deadlock issue when externel_lb and reset are executed together

Ziyang Xuan (1):
      bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

 MAINTAINERS                                        |  27 +-
 drivers/isdn/mISDN/dsp.h                           |   2 +-
 drivers/isdn/mISDN/dsp_cmx.c                       |   2 +-
 drivers/isdn/mISDN/dsp_core.c                      |   2 +-
 drivers/net/bonding/bond_main.c                    |   4 +-
 drivers/net/dsa/ocelot/felix.c                     |   2 +
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    | 125 +++++----
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  14 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |   4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  29 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   1 +
 drivers/net/ethernet/ibm/ibmvnic.c                 | 112 +++++++-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   5 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.c        |  11 +-
 drivers/net/ethernet/intel/igc/igc.h               |   4 +
 drivers/net/ethernet/intel/igc/igc_main.c          |  34 ++-
 .../ethernet/marvell/prestera/prestera_router.c    |  14 +-
 .../mellanox/mlx5/core/diag/reporter_vnic.c        |  98 ++++---
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  11 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  21 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   5 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c    |   3 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_ptrn.c |   2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |  37 ++-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  23 +-
 drivers/net/macsec.c                               |  28 +-
 drivers/net/phy/at803x.c                           |  47 ++--
 drivers/net/tun.c                                  |   2 +-
 drivers/net/vxlan/vxlan_vnifilter.c                |  11 +-
 drivers/net/wireguard/allowedips.c                 |   8 +-
 drivers/net/wireguard/selftest/allowedips.c        |  16 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |   3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   5 +
 drivers/net/wireless/realtek/rtw89/mac.c           |   2 +-
 drivers/pci/bus.c                                  |   4 +-
 drivers/pci/of.c                                   |   5 -
 include/linux/skmsg.h                              |   1 +
 include/net/cfg80211.h                             |   3 +
 include/net/netfilter/nf_tables.h                  | 120 +++-----
 include/trace/events/tcp.h                         |   5 +-
 net/8021q/vlan.c                                   |   3 +-
 net/core/filter.c                                  |   6 -
 net/core/skmsg.c                                   |  10 +-
 net/core/sock.c                                    |   2 +-
 net/core/sock_map.c                                |  10 +-
 net/dccp/output.c                                  |   2 +-
 net/dccp/proto.c                                   |  10 +-
 net/ipv4/ip_tunnel_core.c                          |   2 +-
 net/ipv4/nexthop.c                                 |  28 +-
 net/ipv6/ndisc.c                                   |   3 +-
 net/mptcp/protocol.c                               |   4 +-
 net/mptcp/protocol.h                               |   1 -
 net/mptcp/subflow.c                                |  60 ++--
 net/netfilter/nf_tables_api.c                      | 307 ++++++++++++++++-----
 net/netfilter/nft_set_hash.c                       |  85 +++---
 net/netfilter/nft_set_pipapo.c                     |  68 +++--
 net/netfilter/nft_set_rbtree.c                     | 146 ++++++----
 net/packet/af_packet.c                             |  16 +-
 net/smc/af_smc.c                                   |  79 ++++--
 net/smc/smc.h                                      |   2 +-
 net/smc/smc_clc.c                                  |   4 +-
 net/smc/smc_core.c                                 |  25 +-
 net/smc/smc_sysctl.c                               |  10 +-
 net/tls/tls_device.c                               |  64 ++---
 net/tls/tls_main.c                                 |   3 -
 net/wireless/nl80211.c                             |   5 +-
 net/xdp/xsk.c                                      |   1 +
 .../selftests/bpf/prog_tests/sockmap_listen.c      |  74 ++++-
 .../selftests/bpf/progs/test_sockmap_listen.c      |  14 +
 tools/testing/selftests/net/fib_nexthops.sh        |  10 +
 .../testing/selftests/net/forwarding/bridge_mdb.sh |  59 ++--
 .../selftests/net/forwarding/bridge_mdb_max.sh     |  19 +-
 tools/testing/selftests/net/forwarding/ethtool.sh  |   2 +
 .../net/forwarding/ethtool_extended_state.sh       |   2 +
 .../testing/selftests/net/forwarding/ethtool_mm.sh |  18 +-
 .../selftests/net/forwarding/hw_stats_l3_gre.sh    |   2 +
 .../net/forwarding/ip6_forward_instats_vrf.sh      |   2 +
 tools/testing/selftests/net/forwarding/lib.sh      |  17 ++
 tools/testing/selftests/net/forwarding/settings    |   1 +
 .../testing/selftests/net/forwarding/tc_actions.sh |   6 +-
 .../testing/selftests/net/forwarding/tc_flower.sh  |   8 +-
 .../selftests/net/forwarding/tc_flower_l2_miss.sh  |  13 +-
 .../selftests/net/forwarding/tc_tunnel_key.sh      |   9 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   6 +-
 tools/testing/selftests/net/pmtu.sh                |  35 +++
 92 files changed, 1432 insertions(+), 693 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/settings
