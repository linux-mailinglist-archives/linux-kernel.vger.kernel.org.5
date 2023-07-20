Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778BA75B9BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGTVqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGTVqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B191719
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:46:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27D7961BEF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD37C433C7;
        Thu, 20 Jul 2023 21:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689889560;
        bh=NJyysQw1XlxbubfpLPbrmyvRACzdbsH+oAYETc9wxM8=;
        h=From:To:Cc:Subject:Date:From;
        b=NK1ZgcDdmK1nzgsb6XQsodSEfwZaIirKRYpFeyNQPo3rB6DOD41pHKFHXfFkVOQL+
         7XgJR10tARdje62CwgMAf/In30i46iTe+Hc/HpOcMTkdz4e7IXv5NLSVVrNQo1fzNM
         Ihy8iRg6oF3jEUvZVIQbIGRtRO4pOgiF+EC97/S4k3kwGSOIAV48rcEyfWyiZsgdWy
         w4r9DB0xlKPhhJqpPGqQZxfMlVjlerWLsUvmyWSZdolw3QF4OXQ9IRpVDVHGgSo2ND
         5+nUYHLHyXzZFNsW0p0raGgJsUrr8ROei2esEfoRASjk3/cZjSG2idROplR9E7oCA8
         8Lv0ABmqX+dsg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.5-rc3
Date:   Thu, 20 Jul 2023 14:45:59 -0700
Message-ID: <20230720214559.163647-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The following changes since commit b1983d427a53911ea71ba621d4bf994ae22b1536:

  Merge tag 'net-6.5-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-07-13 14:21:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc3

for you to fetch changes up to 75d42b351f564b2568392a4e53cd74a3d9df4af2:

  Merge tag 'for-net-2023-07-20' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth (2023-07-20 12:57:55 -0700)

----------------------------------------------------------------
Including fixes from BPF, netfilter, bluetooth and CAN.

Current release - regressions:

 - eth: r8169: multiple fixes for PCIe ASPM-related problems

 - vrf: fix RCU lockdep splat in output path

Previous releases - regressions:

 - gso: fall back to SW segmenting with GSO_UDP_L4 dodgy bit set

 - dsa: mv88e6xxx: do a final check before timing out when polling

 - nf_tables: fix sleep in atomic in nft_chain_validate

Previous releases - always broken:

 - sched: fix undoing tcf_bind_filter() in multiple classifiers

 - bpf, arm64: fix BTI type used for freplace attached functions

 - can: gs_usb: fix time stamp counter initialization

 - nft_set_pipapo: fix improper element removal (leading to UAF)

Misc:

 - net: support STP on bridge in non-root netns, STP prevents
   packet loops so not supporting it results in freezing systems
   of unsuspecting users, and in turn very upset noises being made

 - fix kdoc warnings

 - annotate various bits of TCP state to prevent data races

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Ahmed Zaki (3):
      iavf: use internal state to free traffic IRQs
      iavf: fix a deadlock caused by rtnl and driver's lock circular dependencies
      iavf: fix reset task race with iavf_remove()

Alan Stern (1):
      net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb

Alexander Duyck (1):
      bpf, arm64: Fix BTI type used for freplace attached functions

Alexei Starovoitov (1):
      Merge branch 'two-more-fixes-for-check_max_stack_depth'

Andy Shevchenko (1):
      Bluetooth: MGMT: Use correct address for memcpy()

Arnd Bergmann (1):
      Bluetooth: coredump: fix building with coredump disabled

Daniel Golle (2):
      net: ethernet: mtk_eth_soc: handle probe deferral
      net: ethernet: mtk_eth_soc: always mtk_get_ib1_pkt_type

David S. Miller (1):
      Merge branch 'sched-fixes'

Ding Hui (2):
      iavf: Fix use-after-free in free_netdev
      iavf: Fix out-of-bounds when setting channels on remove

Douglas Anderson (1):
      Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()

Eric Dumazet (13):
      tcp: annotate data-races around tcp_rsk(req)->txhash
      tcp: annotate data-races around tcp_rsk(req)->ts_recent
      tcp: annotate data-races around tp->tcp_tx_delay
      tcp: annotate data-races around tp->tsoffset
      tcp: annotate data-races around tp->keepalive_time
      tcp: annotate data-races around tp->keepalive_intvl
      tcp: annotate data-races around tp->keepalive_probes
      tcp: annotate data-races around icsk->icsk_syn_retries
      tcp: annotate data-races around tp->linger2
      tcp: annotate data-races around rskq_defer_accept
      tcp: annotate data-races around tp->notsent_lowat
      tcp: annotate data-races around icsk->icsk_user_timeout
      tcp: annotate data-races around fastopenq.max_qlen

Fedor Ross (1):
      can: mcp251xfd: __mcp251xfd_chip_set_mode(): increase poll timeout

Florian Kauer (1):
      igc: Prevent garbled TX queue with XDP ZEROCOPY

Florian Westphal (3):
      netfilter: nf_tables: fix spurious set element insertion failure
      netfilter: nf_tables: can't schedule in nft_chain_validate
      netfilter: nft_set_pipapo: fix improper element removal

Geetha sowjanya (1):
      octeontx2-pf: Dont allocate BPIDs for LBK interfaces

Heiner Kallweit (3):
      r8169: fix ASPM-related problem for chip version 42 and 43
      r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")
      Revert "r8169: disable ASPM during NAPI poll"

Ido Schimmel (1):
      vrf: Fix lockdep splat in output path

Jakub Kicinski (10):
      Merge branch 'net-fix-kernel-doc-problems-in-include-net'
      Merge branch 'selftests-tc-increase-timeout-and-add-missing-kconfig'
      Merge tag 'linux-can-fixes-for-6.5-20230717' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'tcp-annotate-data-races-in-tcp_rsk-req'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'r8169-revert-two-changes-that-caused-regressions'
      Merge branch 'tcp-add-missing-annotations'
      Merge tag 'nf-23-07-20' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'for-net-2023-07-20' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth

John Fastabend (1):
      mailmap: Add entry for old intel email

Kumar Kartikeya Dwivedi (3):
      bpf: Fix subprog idx logic in check_max_stack_depth
      bpf: Repeat check_max_stack_depth for async callbacks
      selftests/bpf: Add more tests for check_max_stack_depth bug

Kuniyuki Iwashima (6):
      bridge: Add extack warning when enabling STP in netns.
      Revert "tcp: avoid the lookup process failing to get sk in ehash table"
      llc: Check netns in llc_dgram_match().
      llc: Check netns in llc_estab_match() and llc_listener_match().
      llc: Don't drop packet from non-root netns.
      Revert "bridge: Add extack warning when enabling STP in netns."

Linus Walleij (1):
      dsa: mv88e6xxx: Do a final check before timing out

Marc Kleine-Budde (3):
      can: gs_usb: gs_can_open(): improve error handling
      can: gs_usb: fix time stamp counter initialization
      Merge patch series "can: gs_usb: fix time stamp counter initialization"

Marcin Szycik (3):
      iavf: Wait for reset in callbacks which trigger it
      Revert "iavf: Detach device during reset task"
      Revert "iavf: Do not restart Tx queues after reset task failure"

Mark Brown (1):
      net: dsa: ar9331: Use explict flags for regmap single read/write

Matthieu Baerts (3):
      selftests: tc: set timeout to 15 minutes
      selftests: tc: add 'ct' action kconfig dep
      selftests: tc: add ConnTrack procfs kconfig

Michal Swiatkowski (1):
      ice: prevent NULL pointer deref during reload

Pablo Neira Ayuso (2):
      netfilter: nf_tables: skip bound chain in netns release path
      netfilter: nf_tables: skip bound chain on rule flush

Paolo Abeni (2):
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'net-support-stp-on-bridge-in-non-root-netns'

Pauli Virtanen (4):
      Bluetooth: use RCU for hci_conn_params and iterate safely in hci_sync
      Bluetooth: hci_event: call disconnect callback before deleting conn
      Bluetooth: ISO: fix iso_conn related locking and validity issues
      Bluetooth: SCO: fix sco_conn related locking and validity issues

Petr Oros (1):
      ice: Unregister netdev and devlink_port only once

Randy Dunlap (9):
      net: bonding: remove kernel-doc comment marker
      net: cfg802154: fix kernel-doc notation warnings
      codel: fix kernel-doc notation warnings
      devlink: fix kernel-doc notation warnings
      inet: frags: eliminate kernel-doc warning
      net: llc: fix kernel-doc notation warnings
      net: NSH: fix kernel-doc notation warning
      pie: fix kernel-doc notation warning
      rsi: remove kernel-doc comment marker

Shannon Nelson (1):
      mailmap: add entries for past lives

Siddh Raman Pant (1):
      Bluetooth: hci_conn: return ERR_PTR instead of NULL when there is no link

Subbaraya Sundeep (1):
      octeontx2-pf: mcs: Generate hash key using ecb(aes)

Tanmay Patil (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()

Tomasz Moń (1):
      Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014

Tristram Ha (1):
      net: dsa: microchip: correct KSZ8795 static MAC table access

Victor Nogueira (5):
      net: sched: cls_matchall: Undo tcf_bind_filter in case of failure after mall_set_parms
      net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
      net: sched: cls_u32: Undo refcount decrement in case update failed
      net: sched: cls_bpf: Undo tcf_bind_filter in case of an error
      net: sched: cls_flower: Undo tcf_bind_filter in case of an error

Vladimir Oltean (1):
      net: phy: prevent stale pointer dereference in phy_init()

Wang Ming (3):
      bna: Remove error checking for debugfs_create_dir()
      net: ethernet: Remove repeating expression
      net: ipv4: Use kfree_sensitive instead of kfree

Yan Zhai (1):
      gso: fix dodgy bit handling for GSO_UDP_L4

Yuanjun Gong (5):
      net:ipv6: check return value of pskb_trim()
      drivers: net: fix return value check in emac_tso_csum()
      drivers:net: fix return value check in ocelot_fdma_receive_skb
      ipv4: ip_gre: fix return value check in erspan_fb_xmit()
      ipv4: ip_gre: fix return value check in erspan_xmit()

YueHaibing (1):
      can: bcm: Fix UAF in bcm_proc_show()

Ziyang Xuan (1):
      can: raw: fix receiver memory leak

 .mailmap                                           |   3 +
 arch/arm64/net/bpf_jit_comp.c                      |   8 +-
 drivers/bluetooth/btusb.c                          |   1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  10 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |   1 +
 drivers/net/can/usb/gs_usb.c                       | 130 ++++++-----
 drivers/net/dsa/microchip/ksz8795.c                |   8 +-
 drivers/net/dsa/microchip/ksz_common.c             |   8 +-
 drivers/net/dsa/microchip/ksz_common.h             |   7 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   7 +
 drivers/net/dsa/qca/ar9331.c                       |   4 +-
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c    |   5 -
 drivers/net/ethernet/intel/iavf/iavf.h             |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  39 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 237 +++++++++++++--------
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   5 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  13 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  27 ---
 drivers/net/ethernet/intel/ice/ice_main.c          |  10 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   4 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  | 137 ++++++++----
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   5 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  29 +--
 drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c    |   2 +-
 drivers/net/ethernet/mscc/ocelot_fdma.c            |   3 +-
 drivers/net/ethernet/qualcomm/emac/emac-mac.c      |   7 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  45 +++-
 drivers/net/ethernet/ti/cpsw_ale.c                 |  24 ++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   1 -
 drivers/net/phy/phy_device.c                       |  21 +-
 drivers/net/usb/usbnet.c                           |   6 +
 drivers/net/vrf.c                                  |  12 +-
 include/linux/tcp.h                                |   2 +-
 include/net/bluetooth/hci_core.h                   |   7 +-
 include/net/bonding.h                              |   2 +-
 include/net/cfg802154.h                            |   3 +-
 include/net/codel.h                                |   4 +-
 include/net/devlink.h                              |  28 +--
 include/net/inet_frag.h                            |   2 +-
 include/net/llc_conn.h                             |   2 +-
 include/net/llc_pdu.h                              |   6 +-
 include/net/nsh.h                                  |   2 +-
 include/net/pie.h                                  |   2 +-
 include/net/rsi_91x.h                              |   2 +-
 include/net/tcp.h                                  |  31 ++-
 kernel/bpf/verifier.c                              |  32 ++-
 net/bluetooth/hci_conn.c                           |  14 +-
 net/bluetooth/hci_core.c                           |  42 +++-
 net/bluetooth/hci_event.c                          |  15 +-
 net/bluetooth/hci_sync.c                           | 121 +++++++++--
 net/bluetooth/iso.c                                |  55 +++--
 net/bluetooth/mgmt.c                               |  28 ++-
 net/bluetooth/sco.c                                |  23 +-
 net/can/bcm.c                                      |  12 +-
 net/can/raw.c                                      |  57 +++--
 net/ipv4/esp4.c                                    |   2 +-
 net/ipv4/inet_connection_sock.c                    |   2 +-
 net/ipv4/inet_hashtables.c                         |  17 +-
 net/ipv4/inet_timewait_sock.c                      |   8 +-
 net/ipv4/ip_gre.c                                  |   6 +-
 net/ipv4/tcp.c                                     |  57 ++---
 net/ipv4/tcp_fastopen.c                            |   6 +-
 net/ipv4/tcp_ipv4.c                                |  10 +-
 net/ipv4/tcp_minisocks.c                           |  11 +-
 net/ipv4/tcp_output.c                              |   6 +-
 net/ipv4/udp_offload.c                             |  16 +-
 net/ipv6/ip6_gre.c                                 |   3 +-
 net/ipv6/tcp_ipv6.c                                |   4 +-
 net/ipv6/udp_offload.c                             |   3 +-
 net/llc/af_llc.c                                   |   2 +-
 net/llc/llc_conn.c                                 |  49 +++--
 net/llc/llc_if.c                                   |   2 +-
 net/llc/llc_input.c                                |   3 -
 net/llc/llc_sap.c                                  |  18 +-
 net/netfilter/nf_tables_api.c                      |  12 +-
 net/netfilter/nft_set_pipapo.c                     |   6 +-
 net/sched/cls_bpf.c                                |  99 ++++-----
 net/sched/cls_flower.c                             |  99 ++++-----
 net/sched/cls_matchall.c                           |  35 ++-
 net/sched/cls_u32.c                                |  48 ++++-
 .../selftests/bpf/progs/async_stack_depth.c        |  25 ++-
 tools/testing/selftests/tc-testing/config          |   2 +
 tools/testing/selftests/tc-testing/settings        |   1 +
 84 files changed, 1155 insertions(+), 716 deletions(-)
 create mode 100644 tools/testing/selftests/tc-testing/settings
