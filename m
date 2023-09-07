Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2E2797E7F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbjIGWBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjIGWBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:01:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8355A1BC1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:01:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4FDC433C8;
        Thu,  7 Sep 2023 22:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694124064;
        bh=k7mlEL3gaSbyri3qEsjgQyvY6i0fSzCbyaQ8oVx5bgE=;
        h=From:To:Cc:Subject:Date:From;
        b=qZwObeqEQiCGyqZP0IriP8UuhFmj50ByHI2IFay/iEL8fvLQ1d5kn4A97T6AYzv37
         JpG+fDdXlGL5vjwxbi/UcjsSilo67AQR1PSItcSoiW207iOPllSlB65jPOeNHcAcj/
         hvNp5RpRpmXxnz0CNjFm2dCzIl8HscEw+N1bDghTkhm2bc7xtsPXvAJ4K4MZ/ElmZZ
         GJEWg7BeOt7XxXXyEFyU4tLc8JQlnDBMU+AWqhLHFzsvYqVpgQce1XJvkrcgvgCxxe
         j+DspGJ62eNOoFYb9hcJGFGDPkvhVoUZBg3e1+fnvPA7Mha9OrGz93IFea25fYRtG0
         aD+ITdNdNWw+g==
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.6-rc1
Date:   Thu,  7 Sep 2023 15:01:03 -0700
Message-ID: <20230907220103.3900219-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The following changes since commit bd6c11bc43c496cddfc6cf603b5d45365606dbd5:

  Merge tag 'net-next-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2023-08-29 11:33:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc1

for you to fetch changes up to 1b36955cc048c8ff6ba448dbf4be0e52f59f2963:

  net: enetc: distinguish error from valid pointers in enetc_fixup_clear_rss_rfs() (2023-09-07 11:19:42 -0700)

----------------------------------------------------------------
Including fixes from netfilter and bpf.

Current release - regressions:

 - eth: stmmac: fix failure to probe without MAC interface specified

Current release - new code bugs:

 - docs: netlink: fix missing classic_netlink doc reference

Previous releases - regressions:

 - deal with integer overflows in kmalloc_reserve()

 - use sk_forward_alloc_get() in sk_get_meminfo()

 - bpf_sk_storage: fix the missing uncharge in sk_omem_alloc

 - fib: avoid warn splat in flow dissector after packet mangling

 - skb_segment: call zero copy functions before using skbuff frags

 - eth: sfc: check for zero length in EF10 RX prefix

Previous releases - always broken:

 - af_unix: fix msg_controllen test in scm_pidfd_recv() for
   MSG_CMSG_COMPAT

 - xsk: fix xsk_build_skb() dereferencing possible ERR_PTR()

 - netfilter:
   - nft_exthdr: fix non-linear header modification
   - xt_u32, xt_sctp: validate user space input
   - nftables: exthdr: fix 4-byte stack OOB write
   - nfnetlink_osf: avoid OOB read
   - one more fix for the garbage collection work from last release

 - igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU

 - bpf, sockmap: fix preempt_rt splat when using raw_spin_lock_t

 - handshake: fix null-deref in handshake_nl_done_doit()

 - ip: ignore dst hint for multipath routes to ensure packets
   are hashed across the nexthops

 - phy: micrel:
   - correct bit assignments for cable test errata
   - disable EEE according to the KSZ9477 errata

Misc:

 - docs/bpf: document compile-once-run-everywhere (CO-RE) relocations

 - Revert "net: macsec: preserve ingress frame ordering", it appears
   to have been developed against an older kernel, problem doesn't
   exist upstream

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alex Henrie (1):
      net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr

Björn Töpel (1):
      selftests/bpf: Include build flavors for install target

Bodong Wang (1):
      mlx5/core: E-Switch, Create ACL FT for eswitch manager in switchdev mode

Corinna Vinschen (1):
      igb: disable virtualization features on 82580

Daniel Borkmann (1):
      bpf: Annotate bpf_long_memcpy with data_race

David S. Miller (5):
      Merge branch 'net-data-race-annotations'
      Merge branch 'dst-hint-multipath'
      Merge branch 'af_unix-data-races'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'sja1105-fixes'

David Vernet (3):
      bpf, docs: Move linux-notes.rst to root bpf docs tree
      bpf, docs: Add abi.rst document to standardization subdirectory
      bpf, docs: s/eBPF/BPF in standards documents

Donald Hunter (1):
      doc/netlink: Fix missing classic_netlink doc reference

Eduard Zingerman (2):
      docs/bpf: Add description for CO-RE relocations
      docs/bpf: Fix "file doesn't exist" warnings in {llvm_reloc,btf}.rst

Edward Cree (1):
      sfc: check for zero length in EF10 RX prefix

Eric Dumazet (14):
      net/sched: fq_pie: avoid stalls in fq_pie_timer()
      sctp: annotate data-races around sk->sk_wmem_queued
      ipv4: annotate data-races around fi->fib_dead
      net: read sk->sk_family once in sk_mc_loop()
      net/handshake: fix null-ptr-deref in handshake_nl_done_doit()
      net: use sk_forward_alloc_get() in sk_get_meminfo()
      net: annotate data-races around sk->sk_forward_alloc
      mptcp: annotate data-races around msk->rmem_fwd_alloc
      net: annotate data-races around sk->sk_tsflags
      net: annotate data-races around sk->sk_bind_phc
      net: deal with integer overflows in kmalloc_reserve()
      gve: fix frag_list chaining
      igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU
      ip_tunnels: use DEV_STATS_INC()

Florian Westphal (2):
      net: fib: avoid warn splat in flow dissector
      netfilter: nftables: exthdr: fix 4-byte stack OOB write

Geetha sowjanya (1):
      octeontx2-af: Fix truncation of smq in CN10K NIX AQ enqueue mbox handler

Hao Chen (2):
      net: hns3: fix byte order conversion issue in hclge_dbg_fd_tcam_read()
      net: hns3: fix debugfs concurrency issue between kfree buffer and read

Heng Guo (1):
      net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated

Ilya Leoshkevich (1):
      s390/bpf: Pass through tail call counter in trampolines

Jakub Kicinski (7):
      Merge tag 'nf-23-08-31' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      docs: netdev: document patchwork patch states
      docs: netdev: update the netdev infra URLs
      net: phylink: fix sphinx complaint about invalid literal
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Revert "net: team: do not use dynamic lockdep key"

Jian Shen (1):
      net: hns3: fix tx timeout issue

Jianbo Liu (1):
      net/mlx5e: Clear mirred devices array if the rule is split

Jie Wang (1):
      net: hns3: remove GSO partial feature bit

Jijie Shao (2):
      net: hns3: Support query tx timeout threshold by debugfs
      net: hns3: fix invalid mutex between tc qdisc and dcb ets command issue

Jiri Olsa (1):
      selftests/bpf: Fix d_path test

John Fastabend (2):
      bpf, sockmap: Fix preempt_rt splat when using raw_spin_lock_t
      bpf, sockmap: Fix skb refcnt race after locking changes

Kuniyuki Iwashima (5):
      af_unix: Fix msg_controllen test in scm_pidfd_recv() for MSG_CMSG_COMPAT.
      af_unix: Fix data-races around user->unix_inflight.
      af_unix: Fix data-race around unix_tot_inflight.
      af_unix: Fix data-races around sk->sk_shutdown.
      af_unix: Fix data race around sk->sk_err.

Kyle Zeng (1):
      netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c

Liang Chen (1):
      veth: Fixing transmit return status for dropped packets

Lukasz Majewski (1):
      net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)

Magnus Karlsson (1):
      xsk: Fix xsk_diag use-after-free error during socket cleanup

Martin KaFai Lau (3):
      bpf: bpf_sk_storage: Fix invalid wait context lockdep report
      bpf: bpf_sk_storage: Fix the missing uncharge in sk_omem_alloc
      selftests/bpf: Check bpf_sk_storage has uncharged sk_omem_alloc

Mohamed Khalfella (1):
      skbuff: skb_segment, Call zero copy functions before using skbuff frags

Oleksij Rempel (1):
      net: phy: micrel: Correct bit assignments for phy_device flags

Olga Zaborska (3):
      igc: Change IGC_MIN to allow set rx/tx value between 64 and 80
      igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80
      igb: Change IGB_MIN to allow set rx/tx value between 64 and 80

Oliver Neukum (1):
      NFC: nxp: add NXP1002

Pablo Neira Ayuso (2):
      netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction
      netfilter: nf_tables: Unbreak audit log reset

Paolo Abeni (2):
      Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'
      Merge tag 'nf-23-09-06' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Phil Sutter (3):
      netfilter: nf_tables: Audit log setelem reset
      netfilter: nf_tables: Audit log rule reset
      netfilter: nf_tables: uapi: Describe NFTA_RULE_CHAIN_ID

Quan Tian (1):
      net/ipv6: SKB symmetric hash should incorporate transport ports

Russell King (Oracle) (1):
      net: stmmac: failure to probe without MAC interface specified

Sabrina Dubroca (1):
      Revert "net: macsec: preserve ingress frame ordering"

Sebastian Andrzej Siewior (2):
      bpf: Invoke __bpf_prog_exit_sleepable_recur() on recursion in kern_sys_bpf().
      bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before recursion check.

Shigeru Yoshida (1):
      kcm: Destroy mutex in kcm_exit_net()

Sriram Yagnaraman (3):
      ipv4: ignore dst hint for multipath routes
      ipv6: ignore dst hint for multipath routes
      selftests: fib_tests: Add multipath list receive tests

Taehee Yoo (1):
      net: team: do not use dynamic lockdep key

Tirthendu Sarkar (1):
      xsk: Fix xsk_build_skb() error: 'skb' dereferencing possible ERR_PTR()

Vishal Chourasia (1):
      bpf, docs: Fix invalid escape sequence warnings in bpf_doc.py

Vladimir Oltean (4):
      net: dsa: sja1105: fix bandwidth discrepancy between tc-cbs software and offload
      net: dsa: sja1105: fix -ENOSPC when replacing the same tc-cbs too many times
      net: dsa: sja1105: complete tc-cbs offload support on SJA1110
      net: enetc: distinguish error from valid pointers in enetc_fixup_clear_rss_rfs()

Wander Lairson Costa (3):
      netfilter: xt_sctp: validate the flag_info count
      netfilter: xt_u32: validate user space input
      netfilter: nfnetlink_osf: avoid OOB read

Will Hawkins (1):
      bpf, docs: Correct source of offset for program-local call

Xiao Liang (1):
      netfilter: nft_exthdr: Fix non-linear header modification

Xu Kuohai (1):
      selftests/bpf: Fix a CI failure caused by vsock write

Yafang Shao (1):
      bpftool: Fix build warnings with -Wtype-limits

Yisen Zhuang (1):
      net: hns3: fix the port information display when sfp is absent

Yonghong Song (2):
      bpf: Prevent inlining of bpf_fentry_test7()
      selftests/bpf: Fix flaky cgroup_iter_sleepable subtest

valis (1):
      net: sched: sch_qfq: Fix UAF in qfq_dequeue()

 Documentation/bpf/btf.rst                          |  31 ++-
 Documentation/bpf/index.rst                        |   1 +
 .../bpf/{standardization => }/linux-notes.rst      |   0
 Documentation/bpf/llvm_reloc.rst                   | 304 +++++++++++++++++++++
 Documentation/bpf/standardization/abi.rst          |  25 ++
 Documentation/bpf/standardization/index.rst        |   2 +-
 .../bpf/standardization/instruction-set.rst        |  44 +--
 Documentation/process/maintainer-netdev.rst        |  36 ++-
 Documentation/userspace-api/netlink/intro.rst      |   2 +
 arch/s390/net/bpf_jit_comp.c                       |  10 +
 drivers/net/dsa/microchip/ksz_common.c             |  16 +-
 drivers/net/dsa/sja1105/sja1105.h                  |   2 +
 drivers/net/dsa/sja1105/sja1105_main.c             |  51 +++-
 drivers/net/dsa/sja1105/sja1105_spi.c              |   4 +
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |   2 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   5 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  11 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  19 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  20 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  14 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   5 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   2 -
 drivers/net/ethernet/intel/igb/igb.h               |   4 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   5 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h           |   4 +-
 drivers/net/ethernet/intel/igc/igc.h               |   4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  21 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c |   4 +-
 .../ethernet/mellanox/mlx5/core/en/tc/act/mirred.c |   1 +
 .../ethernet/mellanox/mlx5/core/en/tc/act/pedit.c  |   4 +-
 .../mlx5/core/en/tc/act/redirect_ingress.c         |   1 +
 .../ethernet/mellanox/mlx5/core/en/tc/act/vlan.c   |   1 +
 .../mellanox/mlx5/core/en/tc/act/vlan_mangle.c     |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  21 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  49 +++-
 drivers/net/ethernet/sfc/rx.c                      |  20 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   5 +-
 drivers/net/macsec.c                               |   3 +-
 drivers/net/phy/micrel.c                           |   9 +-
 drivers/net/veth.c                                 |   4 +-
 drivers/nfc/nxp-nci/i2c.c                          |   1 +
 include/linux/audit.h                              |   2 +
 include/linux/bpf.h                                |   2 +-
 include/linux/ipv6.h                               |   1 +
 include/linux/micrel_phy.h                         |   7 +-
 include/linux/phylink.h                            |   4 +-
 include/net/ip.h                                   |   3 +-
 include/net/ip6_fib.h                              |   5 +-
 include/net/ip_fib.h                               |   5 +-
 include/net/ip_tunnels.h                           |  15 +-
 include/net/scm.h                                  |  14 +-
 include/net/sock.h                                 |  29 +-
 include/uapi/linux/netfilter/nf_tables.h           |   1 +
 kernel/auditsc.c                                   |   2 +
 kernel/bpf/bpf_local_storage.c                     |  49 +---
 kernel/bpf/syscall.c                               |   2 +-
 kernel/bpf/trampoline.c                            |   5 +-
 net/bpf/test_run.c                                 |   1 +
 net/can/j1939/socket.c                             |  10 +-
 net/core/flow_dissector.c                          |   3 +-
 net/core/skbuff.c                                  |  54 ++--
 net/core/skmsg.c                                   |  12 +-
 net/core/sock.c                                    |  27 +-
 net/core/sock_map.c                                |  36 +--
 net/handshake/netlink.c                            |  18 +-
 net/ipv4/fib_semantics.c                           |   5 +-
 net/ipv4/fib_trie.c                                |   3 +-
 net/ipv4/igmp.c                                    |   3 +-
 net/ipv4/ip_forward.c                              |   1 -
 net/ipv4/ip_input.c                                |   3 +-
 net/ipv4/ip_output.c                               |   9 +-
 net/ipv4/ip_sockglue.c                             |   2 +-
 net/ipv4/ipmr.c                                    |   1 -
 net/ipv4/route.c                                   |   1 +
 net/ipv4/tcp.c                                     |   4 +-
 net/ipv4/tcp_output.c                              |   2 +-
 net/ipv4/udp.c                                     |   6 +-
 net/ipv6/addrconf.c                                |   2 +-
 net/ipv6/ip6_input.c                               |   3 +-
 net/ipv6/ip6_output.c                              |   3 +-
 net/ipv6/ip6mr.c                                   |   2 -
 net/ipv6/ping.c                                    |   2 +-
 net/ipv6/raw.c                                     |   2 +-
 net/ipv6/route.c                                   |   3 +
 net/ipv6/udp.c                                     |   2 +-
 net/kcm/kcmsock.c                                  |   2 +
 net/mptcp/protocol.c                               |  23 +-
 net/netfilter/ipset/ip_set_hash_netportnet.c       |   1 +
 net/netfilter/nf_tables_api.c                      |  54 +++-
 net/netfilter/nfnetlink_osf.c                      |   8 +
 net/netfilter/nft_exthdr.c                         |  42 +--
 net/netfilter/nft_set_rbtree.c                     |   8 +-
 net/netfilter/xt_sctp.c                            |   2 +
 net/netfilter/xt_u32.c                             |  21 ++
 net/sched/sch_fq_pie.c                             |  27 +-
 net/sched/sch_plug.c                               |   2 +-
 net/sched/sch_qfq.c                                |  22 +-
 net/sctp/proc.c                                    |   2 +-
 net/sctp/socket.c                                  |  10 +-
 net/socket.c                                       |  15 +-
 net/unix/af_unix.c                                 |   2 +-
 net/unix/scm.c                                     |   6 +-
 net/xdp/xsk.c                                      |  22 +-
 net/xdp/xsk_diag.c                                 |   3 +
 scripts/bpf_doc.py                                 |  56 ++--
 tools/bpf/bpftool/link.c                           |   2 +-
 tools/testing/selftests/bpf/Makefile               |  12 +
 .../selftests/bpf/prog_tests/bpf_obj_pinning.c     |   5 +-
 tools/testing/selftests/bpf/prog_tests/d_path.c    |  19 +-
 .../bpf/prog_tests/sk_storage_omem_uncharge.c      |  56 ++++
 .../selftests/bpf/prog_tests/sockmap_helpers.h     |  26 ++
 .../selftests/bpf/prog_tests/sockmap_listen.c      |   7 +
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |   1 +
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c |  61 +++++
 tools/testing/selftests/net/fib_tests.sh           | 155 ++++++++++-
 118 files changed, 1405 insertions(+), 410 deletions(-)
 rename Documentation/bpf/{standardization => }/linux-notes.rst (100%)
 create mode 100644 Documentation/bpf/standardization/abi.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sk_storage_omem_uncharge.c
 create mode 100644 tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
