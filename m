Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53567EE09B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbjKPMWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345138AbjKPMWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:22:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29C5187
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700137330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RS6x6ngjtH6dv8LjllYNvgoIqtxlV5eVBlBJB1lPQw0=;
        b=gmStcDHot9/PKLeoYfIKclmsH0jvGYNuzH9HKED048KyivyyNp6VkuWoeI5y5ChUsbipnx
        UJuaruW222L4tg/rBiKMmPVqybYdHvRtLwZ2S7hOCLwGmsChRD6EA7ZETOJ7shKauGaWBA
        HJMOMJ40YlghBKplve97llLztnGNKn8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-Bz-tVgdkMS-6XDk3p12g6A-1; Thu, 16 Nov 2023 07:22:07 -0500
X-MC-Unique: Bz-tVgdkMS-6XDk3p12g6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ABBA8007B3;
        Thu, 16 Nov 2023 12:22:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECF762026D4C;
        Thu, 16 Nov 2023 12:22:05 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.7-rc2
Date:   Thu, 16 Nov 2023 13:21:40 +0100
Message-ID: <20231116122140.28033-1-pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Notably this includes the fix for the eBPF regression you have been
notified of.

The following changes since commit 89cdf9d556016a54ff6ddd62324aa5ec790c05cc:

  Merge tag 'net-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-09 17:09:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc2

for you to fetch changes up to cff088d924df871296412e6b819823f42d1bb9a5:

  Merge tag 'nf-23-11-15' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2023-11-16 11:02:52 +0100)

----------------------------------------------------------------
Including fixes from BPF and netfilter.

Current release - regressions:

 - core: fix undefined behavior in netdev name allocation

 - bpf: do not allocate percpu memory at init stage

 - netfilter: nf_tables: split async and sync catchall in two functions

 - mptcp: fix possible NULL pointer dereference on close

Current release - new code bugs:

 - eth: ice: dpll: fix initial lock status of dpll

Previous releases - regressions:

 - bpf: fix precision backtracking instruction iteration

 - af_unix: fix use-after-free in unix_stream_read_actor()

 - tipc: fix kernel-infoleak due to uninitialized TLV value

 - eth: bonding: stop the device in bond_setup_by_slave()

 - eth: mlx5:
   - fix double free of encap_header
   - avoid referencing skb after free-ing in drop path

 - eth: hns3: fix VF reset

 - eth: mvneta: fix calls to page_pool_get_stats

Previous releases - always broken:

 - core: set SOCK_RCU_FREE before inserting socket into hashtable

 - bpf: fix control-flow graph checking in privileged mode

 - eth: ppp: limit MRU to 64K

 - eth: stmmac: avoid rx queue overrun

 - eth: icssg-prueth: fix error cleanup on failing initialization

 - eth: hns3: fix out-of-bounds access may occur when coalesce info is
 	      read via debugfs

 - eth: cortina: handle large frames

Misc:

 - selftests: gso: support CONFIG_MAX_SKB_FRAGS up to 45

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alex Pakhunov (2):
      tg3: Move the [rt]x_dropped counters to tg3_napi
      tg3: Increment tx_dropped in tg3_tso_bug()

Alexei Starovoitov (1):
      Merge branch 'bpf-control-flow-graph-and-precision-backtrack-fixes'

Anders Roxell (1):
      selftests: bpf: xskxceiver: ksft_print_msg: fix format type error

Andrii Nakryiko (5):
      bpf: handle ldimm64 properly in check_cfg()
      bpf: fix precision backtracking instruction iteration
      selftests/bpf: add edge case backtracking logic test
      bpf: fix control-flow graph checking in privileged mode
      selftests/bpf: add more test cases for check_cfg()

Arkadiusz Kubalewski (3):
      ice: dpll: fix initial lock status of dpll
      ice: dpll: fix check for dpll input priority range
      ice: dpll: fix output pin capabilities

Baruch Siach (2):
      net: stmmac: fix rx budget limit check
      net: stmmac: avoid rx queue overrun

ChunHao Lin (2):
      r8169: add handling DASH when DASH is disabled
      r8169: fix network lost after resume on DASH systems

Dan Carpenter (1):
      netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()

Dan Nowlin (1):
      ice: fix DDP package download for packages without signature segment

David S. Miller (1):
      Merge branch 'hns3-fixes'

Dust Li (1):
      net/mlx5e: fix double free of encap_header

Erez Shitrit (1):
      net/mlx5: DR, Allow old devices to use multi destination FTE

Eric Dumazet (4):
      ipvlan: add ipvlan_route_v6_outbound() helper
      ptp: annotate data-race around q->head and q->tail
      bonding: stop the device in bond_setup_by_slave()
      af_unix: fix use-after-free in unix_stream_read_actor()

Gal Pressman (1):
      net: Fix undefined behavior in netdev name allocation

Gavin Li (1):
      net/mlx5e: fix double free of encap_header in update funcs

Geliang Tang (1):
      mptcp: add validity check for sending RM_ADDR

Itamar Gozlan (1):
      Revert "net/mlx5: DR, Supporting inline WQE when possible"

Jakub Kicinski (8):
      Revert "ptp: Fixes a null pointer dereference in ptp_ioctl"
      Merge branch 'fix-large-frames-in-the-gemini-ethernet-driver'
      Merge branch 'r8169-fix-dash-devices-network-lost-issue'
      Merge branch 'pds_core-fix-irq-index-bug-and-compiler-warnings'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'mptcp-misc-fixes-for-v6-7'
      Merge https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'mlx5-fixes-2023-11-13-manual'

Jan Kiszka (2):
      net: ti: icssg-prueth: Add missing icss_iep_put to error path
      net: ti: icssg-prueth: Fix error cleanup on failing pruss_request_mem_region

Jian Shen (2):
      net: hns3: fix add VLAN fail issue
      net: hns3: fix incorrect capability bit display for copper port

Jianbo Liu (1):
      net/mlx5e: Don't modify the peer sent-to-vport rules for IPSec offload

Jijie Shao (2):
      net: hns3: fix VF reset fail issue
      net: hns3: fix VF wrong speed and duplex issue

Johnathan Mantey (1):
      Revert ncsi: Propagate carrier gain/loss events to the NCSI controller

Jozsef Kadlecsik (1):
      netfilter: ipset: fix race condition between swap/destroy and kernel side add/del/test

Linkui Xiao (1):
      netfilter: nf_conntrack_bridge: initialize err to 0

Linus Walleij (3):
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Handle large frames
      net: ethernet: cortina: Fix MTU max setting

MD Danish Anwar (1):
      MAINTAINERS: add entry for TI ICSSG Ethernet driver

Maher Sanalla (1):
      net/mlx5: Free used cpus mask when an IRQ is released

Marek Behún (1):
      net: mdio: fix typo in header

Niklas Söderlund (1):
      dt-bindings: net: ethernet-controller: Fix formatting error

Pablo Neira Ayuso (2):
      netfilter: nf_tables: bogus ENOENT when destroying element which does not exist
      netfilter: nf_tables: split async and sync catchall in two functions

Paolo Abeni (5):
      mptcp: deal with large GSO size
      mptcp: fix possible NULL pointer dereference on close
      mptcp: fix setsockopt(IP_TOS) subflow locking
      selftests: mptcp: fix fastclose with csum failure
      Merge tag 'nf-23-11-15' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Rahul Rameshbabu (7):
      net/mlx5: Decouple PHC .adjtime and .adjphase implementations
      net/mlx5e: Avoid referencing skb after free-ing in drop path of mlx5e_sq_xmit_wqe
      net/mlx5e: Track xmit submission to PTP WQ after populating metadata map
      net/mlx5e: Update doorbell for port timestamping CQ before the software counter
      net/mlx5: Increase size of irq name buffer
      net/mlx5e: Check return value of snprintf writing to fw_version buffer
      net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors

Ravi Gunasekaran (1):
      MAINTAINERS: net: Update reviewers for TI's Ethernet drivers

Saeed Mahameed (1):
      net/mlx5e: Reduce the size of icosq_str

Shannon Nelson (2):
      pds_core: use correct index to mask irq
      pds_core: fix up some format-truncation complaints

Shigeru Yoshida (2):
      tty: Fix uninit-value access in ppp_sync_receive()
      tipc: Fix kernel-infoleak due to uninitialized TLV value

Stanislav Fomichev (1):
      net: set SOCK_RCU_FREE before inserting socket into hashtable

Sven Auhagen (1):
      net: mvneta: fix calls to page_pool_get_stats

Vlad Buslov (2):
      net/mlx5e: Fix pedit endianness
      macvlan: Don't propagate promisc change to lower dev in passthru

Willem de Bruijn (2):
      net: gso_test: support CONFIG_MAX_SKB_FRAGS up to 45
      ppp: limit MRU to 64K

Xin Long (1):
      net: sched: do not offload flows with a helper in act_ct

Yang Li (1):
      netfilter: nft_set_rbtree: Remove unused variable nft_net

Yonghong Song (1):
      bpf: Do not allocate percpu memory at init stage

Yonglong Liu (3):
      net: hns3: add barrier in vf mailbox reply process
      net: hns3: fix out-of-bounds access may occur when coalesce info is read via debugfs
      net: hns3: fix variable may not initialized problem in hns3_init_mac_addr()

Yuran Pereira (1):
      ptp: Fixes a null pointer dereference in ptp_ioctl

Ziwei Xiao (1):
      gve: Fixes for napi_poll when budget is 0

 .../bindings/net/ethernet-controller.yaml          |   4 +-
 MAINTAINERS                                        |  13 ++-
 drivers/net/bonding/bond_main.c                    |   6 ++
 drivers/net/ethernet/amd/pds_core/adminq.c         |   2 +-
 drivers/net/ethernet/amd/pds_core/core.h           |   2 +-
 drivers/net/ethernet/amd/pds_core/dev.c            |   8 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |   2 +-
 drivers/net/ethernet/broadcom/tg3.c                |  42 ++++++--
 drivers/net/ethernet/broadcom/tg3.h                |   4 +-
 drivers/net/ethernet/cortina/gemini.c              |  45 +++++---
 drivers/net/ethernet/cortina/gemini.h              |   4 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   8 +-
 drivers/net/ethernet/google/gve/gve_rx.c           |   4 -
 drivers/net/ethernet/google/gve/gve_tx.c           |   4 -
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   9 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  33 ++++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  25 ++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |   7 ++
 drivers/net/ethernet/intel/ice/ice_ddp.c           | 103 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  21 ++--
 drivers/net/ethernet/intel/ice/ice_dpll.h          |   1 -
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |  54 ++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   2 +
 drivers/net/ethernet/marvell/mvneta.c              |  28 +++--
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  20 +++-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |  30 +++---
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  13 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  12 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  60 ++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |  25 +++--
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   3 +-
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |  42 --------
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h  |   3 +
 .../mellanox/mlx5/core/steering/dr_action.c        |   3 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_send.c | 115 +++------------------
 drivers/net/ethernet/realtek/r8169_main.c          |  42 ++++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  15 ++-
 drivers/net/ipvlan/ipvlan_core.c                   |  41 +++++---
 drivers/net/macvlan.c                              |   2 +-
 drivers/net/ppp/ppp_synctty.c                      |   6 +-
 drivers/ptp/ptp_chardev.c                          |   3 +-
 drivers/ptp/ptp_clock.c                            |   5 +-
 drivers/ptp/ptp_private.h                          |   8 +-
 drivers/ptp/ptp_sysfs.c                            |   3 +-
 include/linux/bpf.h                                |  10 +-
 include/linux/mdio.h                               |   2 +-
 include/net/netfilter/nf_tables.h                  |   4 +-
 include/net/tc_act/tc_ct.h                         |   9 ++
 kernel/bpf/core.c                                  |   8 +-
 kernel/bpf/verifier.c                              |  87 +++++++++++-----
 net/bridge/netfilter/nf_conntrack_bridge.c         |   2 +-
 net/core/dev.c                                     |   4 +-
 net/core/gso_test.c                                |  14 +--
 net/ipv4/inet_hashtables.c                         |   2 +-
 net/mptcp/pm_netlink.c                             |   5 +-
 net/mptcp/protocol.c                               |  11 +-
 net/mptcp/sockopt.c                                |   3 +
 net/ncsi/ncsi-aen.c                                |   5 -
 net/netfilter/ipset/ip_set_core.c                  |  14 +--
 net/netfilter/nf_tables_api.c                      |  60 ++++++-----
 net/netfilter/nft_byteorder.c                      |   5 +-
 net/netfilter/nft_meta.c                           |   2 +-
 net/netfilter/nft_set_rbtree.c                     |   2 -
 net/sched/act_ct.c                                 |   3 +
 net/tipc/netlink_compat.c                          |   1 +
 net/unix/af_unix.c                                 |   9 +-
 tools/testing/selftests/bpf/progs/verifier_cfg.c   |  62 +++++++++++
 .../testing/selftests/bpf/progs/verifier_loops1.c  |   9 +-
 .../selftests/bpf/progs/verifier_precision.c       |  40 +++++++
 tools/testing/selftests/bpf/verifier/calls.c       |   6 +-
 tools/testing/selftests/bpf/verifier/ld_imm64.c    |   8 +-
 tools/testing/selftests/bpf/xskxceiver.c           |  19 ++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   2 +-
 80 files changed, 860 insertions(+), 457 deletions(-)

