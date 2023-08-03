Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B661576F43A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjHCUuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjHCUt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:49:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2089911F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A293061D61
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE56C433C8;
        Thu,  3 Aug 2023 20:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691095795;
        bh=3NfRQ0d28NuxQ7YTdnA1Ssgv4V9r5ej0bDprAr+07WU=;
        h=From:To:Cc:Subject:Date:From;
        b=SaQONshpMyeW3jk4KBB0Zuh7ZXIRVa2nHciOai8mOHxfSXwmJAHYQOvAwiiQrGQAB
         FVUikTDqsmorsPSTZEOWiLHZTDXdBDSH9K19x1ADLk8jbgRekP1y5k+SJhd5qGb5P6
         zw30YplkWu0c2FYCSV4jZ09wfIAU2waaGoXykDJDUscfZ2TBC/QJMsdVdToQPKil/C
         b83SpM/TNrn7hvK2nWXH1kz6OEETQPWHa5ghEGV/11umk74xCv3RySVt+gOoLimQMD
         MvA3RG1NVyOVkcNedAAgrD41NbUER0+IJ5Asmh/xNo5DeINGSHZLiSbjyXik8ZyCNV
         scU2ZuJRgaWQA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.5-rc5
Date:   Thu,  3 Aug 2023 13:49:53 -0700
Message-ID: <20230803204953.2556070-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The following changes since commit 57012c57536f8814dec92e74197ee96c3498d24e:

  Merge tag 'net-6.5-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-07-27 12:27:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc5

for you to fetch changes up to 0765c5f293357ee43eca72e27c3547f9d99ac355:

  MAINTAINERS: update TUN/TAP maintainers (2023-08-03 11:57:38 -0700)

----------------------------------------------------------------
Including fixes from bpf and wireless.

Nothing scary here. Feels like the first wave of regressions
from v6.5 is addressed - one outstanding fix still to come
in TLS for the sendpage rework.

Current release - regressions:

 - udp: fix __ip_append_data()'s handling of MSG_SPLICE_PAGES

 - dsa: fix older DSA drivers using phylink

Previous releases - regressions:

 - gro: fix misuse of CB in udp socket lookup

 - mlx5: unregister devlink params in case interface is down

 - Revert "wifi: ath11k: Enable threaded NAPI"

Previous releases - always broken:

 - sched: cls_u32: fix match key mis-addressing

 - sched: bind logic fixes for cls_fw, cls_u32 and cls_route

 - add bound checks to a number of places which hand-parse netlink

 - bpf: disable preemption in perf_event_output helpers code

 - qed: fix scheduling in a tasklet while getting stats

 - avoid using APIs which are not hardirq-safe in couple of drivers,
   when we may be in a hard IRQ (netconsole)

 - wifi: cfg80211: fix return value in scan logic, avoid page
   allocator warning

 - wifi: mt76: mt7615: do not advertise 5 GHz on first PHY
   of MT7615D (DBDC)

Misc:

 - drop handful of inactive maintainers, put some new in place

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Alexandra Winter (1):
      s390/qeth: Don't call dev_close/dev_open (DOWN/UP)

Alexei Starovoitov (1):
      Merge branch 'bpf-disable-preemption-in-perf_event_output-helpers-code'

Amir Tzin (1):
      net/mlx5e: Fix crash moving to switchdev mode when ntuple offload is set

Benjamin Poirier (1):
      vxlan: Fix nexthop hash size

Brian Norris (1):
      MAINTAINERS: Update mwifiex maintainer list

Chengfeng Ye (1):
      mISDN: hfcpci: Fix potential deadlock on &hc->lock

Chris Mi (2):
      net/mlx5e: Don't hold encap tbl lock if there is no encap action
      net/mlx5: fs_chains: Fix ft prio if ignore_flow_level is not supported

Dan Carpenter (1):
      net: ll_temac: fix error checking of irq_of_parse_and_map()

David Howells (1):
      udp: Fix __ip_append_data()'s handling of MSG_SPLICE_PAGES

David S. Miller (2):
      Merge branch 'net-data-races'
      Merge branch 'tun-tap-uid'

Dragos Tatulea (2):
      net/mlx5e: xsk: Fix invalid buffer access for legacy rq
      net/mlx5e: xsk: Fix crash on regular rq reactivation

Duoming Zhou (1):
      net: usb: lan78xx: reorder cleanup operations to avoid UAF bugs

Edward Cree (1):
      sfc: fix field-spanning memcpy in selftest

Eric Dumazet (18):
      net: flower: fix stack-out-of-bounds in fl_set_key_cfm()
      net: annotate data-races around sk->sk_reserved_mem
      net: annotate data-race around sk->sk_txrehash
      net: annotate data-races around sk->sk_max_pacing_rate
      net: add missing READ_ONCE(sk->sk_rcvlowat) annotation
      net: annotate data-races around sk->sk_{rcv|snd}timeo
      net: add missing READ_ONCE(sk->sk_sndbuf) annotation
      net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
      net: annotate data-races around sk->sk_mark
      net: add missing data-race annotations around sk->sk_peek_off
      net: add missing data-race annotation for sk_ll_usec
      net: annotate data-races around sk->sk_priority
      tcp_metrics: fix addr_same() helper
      tcp_metrics: annotate data-races around tm->tcpm_stamp
      tcp_metrics: annotate data-races around tm->tcpm_lock
      tcp_metrics: annotate data-races around tm->tcpm_vals[]
      tcp_metrics: annotate data-races around tm->tcpm_net
      tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen

Eugen Hristev (1):
      dt-bindings: net: rockchip-dwmac: fix {tx|rx}-delay defaults/range in schema

Hans de Goede (1):
      wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v1()

Hou Tao (2):
      bpf, cpumap: Make sure kthread is running before map update returns
      bpf, cpumap: Handle skb as well when clean up ptr_ring

Ilan Peer (1):
      wifi: cfg80211: Fix return value in scan logic

Jakub Kicinski (10):
      MAINTAINERS: stmmac: retire Giuseppe Cavallaro
      Merge tag 'mlx5-fixes-2023-07-26' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      bnxt: don't handle XDP in netpoll
      Merge branch 'net-sched-bind-logic-fixes-for-cls_fw-cls_u32-and-cls_route'
      Merge branch 'bnxt_en-2-xdp-bug-fixes'
      Merge branch 'mlx5-ipsec-fixes'
      Merge branch 'tcp_metrics-series-of-fixes'
      Merge tag 'wireless-2023-08-03' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      MAINTAINERS: update TUN/TAP maintainers

Jamal Hadi Salim (1):
      net: sched: cls_u32: Fix match key mis-addressing

Jianbo Liu (4):
      net/mlx5e: Move representor neigh cleanup to profile cleanup_tx
      net/mlx5e: kTLS, Fix protection domain in use syndrome when devlink reload
      net/mlx5: fs_core: Make find_closest_ft more generic
      net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_prio

Jiri Olsa (2):
      bpf: Disable preemption in bpf_perf_event_output
      bpf: Disable preemption in bpf_event_output

Jonas Gorski (1):
      prestera: fix fallback to previous version on same major version

Kalle Valo (12):
      Revert "wifi: ath11k: Enable threaded NAPI"
      Revert "wifi: ath6k: silence false positive -Wno-dangling-pointer warning on GCC 12"
      MAINTAINERS: wifi: rtw88: change Ping as the maintainer
      MAINTAINERS: wifi: atmel: mark as orphan
      MAINTAINERS: wifi: mark cw1200 as orphan
      MAINTAINERS: wifi: mark ar5523 as orphan
      MAINTAINERS: wifi: mark rndis_wlan as orphan
      MAINTAINERS: wifi: mark wl3501 as orphan
      MAINTAINERS: wifi: mark zd1211rw as orphan
      MAINTAINERS: wifi: mark b43 as orphan
      MAINTAINERS: wifi: mark mlw8k as orphan
      MAINTAINERS: add Jeff as ath10k, ath11k and ath12k maintainer

Kees Cook (1):
      wifi: ray_cs: Replace 1-element array with flexible array

Konstantin Khorenko (1):
      qed: Fix scheduling in a tasklet while getting stats

Kuniyuki Iwashima (2):
      net/sched: taprio: Limit TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME to INT_MAX.
      selftest: net: Assert on a proper value in so_incoming_cpu.c.

Laszlo Ersek (2):
      net: tun_chr_open(): set sk_uid from current_fsuid()
      net: tap_open(): set sk_uid from current_fsuid()

Leon Romanovsky (1):
      net/mlx5e: Set proper IPsec source port in L4 selector

Lin Ma (3):
      bpf: Add length check for SK_DIAG_BPF_STORAGE_REQ_MAP_FD parsing
      rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length
      net: dcb: choose correct policy to parse DCB_ATTR_BCN

Lukasz Majewski (1):
      net: dsa: microchip: KSZ9477 register regmap alignment to 32 bit boundaries

Mark Brown (1):
      net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode

Martin KaFai Lau (1):
      Merge branch 'Two fixes for cpu-map'

Martin Kohn (1):
      net: usb: qmi_wwan: add Quectel EM05GV2

Michael Chan (1):
      bnxt_en: Fix max_mtu setting for multi-buf XDP

Michal Schmidt (1):
      octeon_ep: initialize mbox mutexes

Paul Fertser (1):
      wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)

Rafal Rogalski (1):
      ice: Fix RDMA VSI removal during queue rebuild

Rafał Miłecki (1):
      dt-bindings: net: mediatek,net: fixup MAC binding

Richard Gobert (1):
      net: gro: fix misuse of CB in udp socket lookup

Ross Maynard (1):
      USB: zaurus: Add ID for A-300/B-500/C-700

Russell King (Oracle) (1):
      net: dsa: fix older DSA drivers using phylink

Shay Drory (3):
      net/mlx5: Honor user input for migratable port fn attr
      net/mlx5: DR, Fix peer domain namespace setting
      net/mlx5: Unregister devlink params in case interface is down

Somnath Kotur (1):
      bnxt_en: Fix page pool logic for page size >= 64K

Stefano Garzarella (1):
      test/vsock: remove vsock_perf executable on `make clean`

Thierry Reding (1):
      net: stmmac: tegra: Properly allocate clock bulk data

Tomas Glozar (1):
      bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire

Vlad Buslov (1):
      net/mlx5: Bridge, set debugfs access right to root-only

Yuanjun Gong (3):
      net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()
      net: dsa: fix value check in bcm_sf2_sw_probe()
      net: korina: handle clk prepare error in korina_probe()

Yue Haibing (1):
      ip6mr: Fix skb_under_panic in ip6mr_cache_report()

Zhengchao Shao (3):
      net/mlx5e: fix double free in macsec_fs_tx_create_crypto_table_groups
      net/mlx5: DR, fix memory leak in mlx5dr_cmd_create_reformat_ctx
      net/mlx5: fix potential memory leak in mlx5e_init_rep_rx

valis (3):
      net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
      net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free
      net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free

 .../devicetree/bindings/net/mediatek,net.yaml      |   7 +-
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |  10 +-
 MAINTAINERS                                        |  42 ++++----
 drivers/isdn/hardware/mISDN/hfcpci.c               |  10 +-
 drivers/net/dsa/bcm_sf2.c                          |   8 +-
 drivers/net/dsa/microchip/ksz_common.c             |  35 +++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  85 +++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |  14 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  18 ++++
 drivers/net/ethernet/korina.c                      |   3 +-
 .../ethernet/marvell/octeon_ep/octep_ctrl_mbox.c   |   3 +
 .../net/ethernet/marvell/prestera/prestera_pci.c   |   3 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |   3 -
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |   5 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |   4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |   4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.c    |   8 --
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c |  29 +++++-
 .../mellanox/mlx5/core/en_accel/macsec_fs.c        |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  10 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  29 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  20 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  21 +++-
 .../mellanox/mlx5/core/esw/bridge_debugfs.c        |   2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  17 ++--
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  | 109 ++++++++++++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |   2 +-
 .../ethernet/mellanox/mlx5/core/lib/fs_chains.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   1 +
 .../mellanox/mlx5/core/steering/dr_action.c        |   2 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |   5 +-
 .../mellanox/mlx5/core/steering/dr_domain.c        |  19 ++--
 .../mellanox/mlx5/core/steering/dr_ste_v0.c        |   7 +-
 .../mellanox/mlx5/core/steering/dr_ste_v1.c        |   7 +-
 .../mellanox/mlx5/core/steering/dr_types.h         |   2 +-
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/steering/mlx5dr.h  |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev_api.h      |  16 +++
 drivers/net/ethernet/qlogic/qed/qed_fcoe.c         |  19 +++-
 drivers/net/ethernet/qlogic/qed/qed_fcoe.h         |  17 +++-
 drivers/net/ethernet/qlogic/qed/qed_hw.c           |  26 ++++-
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c        |  19 +++-
 drivers/net/ethernet/qlogic/qed/qed_iscsi.h        |   8 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |  19 +++-
 drivers/net/ethernet/qlogic/qed/qed_l2.h           |  24 +++++
 drivers/net/ethernet/qlogic/qed/qed_main.c         |   6 +-
 drivers/net/ethernet/sfc/falcon/selftest.c         |  23 +++--
 drivers/net/ethernet/sfc/selftest.c                |  23 +++--
 drivers/net/ethernet/sfc/siena/selftest.c          |  23 +++--
 drivers/net/ethernet/socionext/netsec.c            |  11 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |   3 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |  12 ++-
 drivers/net/tap.c                                  |   2 +-
 drivers/net/tun.c                                  |   2 +-
 drivers/net/usb/cdc_ether.c                        |  21 ++++
 drivers/net/usb/lan78xx.c                          |   7 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/usb/zaurus.c                           |  21 ++++
 drivers/net/wireless/ath/ath11k/ahb.c              |   1 -
 drivers/net/wireless/ath/ath11k/pcic.c             |   1 -
 drivers/net/wireless/ath/ath6kl/Makefile           |   5 -
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |   7 +-
 drivers/net/wireless/legacy/rayctl.h               |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c |   6 +-
 drivers/s390/net/qeth_core.h                       |   1 -
 drivers/s390/net/qeth_core_main.c                  |   2 -
 drivers/s390/net/qeth_l2_main.c                    |   9 +-
 drivers/s390/net/qeth_l3_main.c                    |   8 +-
 include/net/gro.h                                  |  43 ++++++++
 include/net/inet_sock.h                            |   7 +-
 include/net/ip.h                                   |   2 +-
 include/net/route.h                                |   4 +-
 include/net/vxlan.h                                |   4 +-
 include/uapi/linux/pkt_cls.h                       |   4 +-
 kernel/bpf/cpumap.c                                |  35 ++++---
 kernel/trace/bpf_trace.c                           |  17 +++-
 net/can/raw.c                                      |   2 +-
 net/core/bpf_sk_storage.c                          |   5 +-
 net/core/rtnetlink.c                               |   8 +-
 net/core/sock.c                                    |  69 +++++++------
 net/core/sock_map.c                                |   2 -
 net/dcb/dcbnl.c                                    |   2 +-
 net/dccp/ipv6.c                                    |   4 +-
 net/dsa/port.c                                     |   9 +-
 net/ipv4/inet_diag.c                               |   4 +-
 net/ipv4/ip_output.c                               |  17 +++-
 net/ipv4/ip_sockglue.c                             |   2 +-
 net/ipv4/raw.c                                     |   2 +-
 net/ipv4/route.c                                   |   4 +-
 net/ipv4/tcp_ipv4.c                                |   4 +-
 net/ipv4/tcp_metrics.c                             |  70 ++++++++-----
 net/ipv4/udp.c                                     |   8 +-
 net/ipv4/udp_offload.c                             |   7 +-
 net/ipv6/ip6mr.c                                   |   2 +-
 net/ipv6/ping.c                                    |   2 +-
 net/ipv6/raw.c                                     |   6 +-
 net/ipv6/route.c                                   |   7 +-
 net/ipv6/tcp_ipv6.c                                |   9 +-
 net/ipv6/udp.c                                     |  12 ++-
 net/ipv6/udp_offload.c                             |   7 +-
 net/l2tp/l2tp_ip6.c                                |   2 +-
 net/mptcp/sockopt.c                                |   2 +-
 net/netfilter/nft_socket.c                         |   2 +-
 net/netfilter/xt_socket.c                          |   4 +-
 net/packet/af_packet.c                             |  12 +--
 net/sched/cls_flower.c                             |   5 +-
 net/sched/cls_fw.c                                 |   1 -
 net/sched/cls_route.c                              |   1 -
 net/sched/cls_u32.c                                |  57 +++++++++--
 net/sched/em_meta.c                                |   4 +-
 net/sched/sch_taprio.c                             |  15 ++-
 net/smc/af_smc.c                                   |   2 +-
 net/unix/af_unix.c                                 |   2 +-
 net/wireless/scan.c                                |   2 +-
 net/xdp/xsk.c                                      |   2 +-
 net/xfrm/xfrm_policy.c                             |   2 +-
 tools/testing/selftests/net/so_incoming_cpu.c      |   2 +-
 .../tc-testing/tc-tests/qdiscs/taprio.json         |  25 +++++
 tools/testing/vsock/Makefile                       |   2 +-
 123 files changed, 983 insertions(+), 447 deletions(-)
