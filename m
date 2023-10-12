Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95577C6BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378006AbjJLLGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343814AbjJLLGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19FDCF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697108714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mwGju3Xeqw9ZXRBWglPx2ULyIsJ1jXFa8nItaSrqhkY=;
        b=LAdDAhxFkenEjE/gmtdP95YWT+xOVEa8faAjaW9tw3Mr1H+dX1y1nA5Jvyd05pwjL/eViD
        WEB1S0+ZKW9D22Tnz/FVRUbTRzgi0ZQ2iJuFCK4T9u5EjcXnX0SCmCPvN7vQNNu+1gH0N7
        TEly3v+K9fdntBmQhyShOGTocrn+lhY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-qiByKE1PMCeK9RIs6a6Jjw-1; Thu, 12 Oct 2023 07:05:09 -0400
X-MC-Unique: qiByKE1PMCeK9RIs6a6Jjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4643B1C0896B;
        Thu, 12 Oct 2023 11:05:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1653710F1BE7;
        Thu, 12 Oct 2023 11:05:07 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.6-rc6
Date:   Thu, 12 Oct 2023 13:04:43 +0200
Message-ID: <20231012110443.13091-1-pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

We have a regression in TC currently under investigation,
otherwise the things that stand off most are probably the
TCP and AF_PACKET fixes, with both issues coming from 6.5.

The following changes since commit f291209eca5eba0b4704fa0832af57b12dbc1a02:

  Merge tag 'net-6.6-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-10-05 11:29:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc6

for you to fetch changes up to b91e8403373cab79375a65f5cf3495e2cd0bbdfa:

  Merge branch 'rswitch-fix-issues-on-specific-conditions' (2023-10-12 11:22:24 +0200)

----------------------------------------------------------------
Including fixes from CAN and BPF.

Previous releases - regressions:

 - af_packet: fix fortified memcpy() without flex array.

 - tcp: fix crashes trying to free half-baked MTU probes

 - xdp: fix zero-size allocation warning in xskq_create()

 - can: sja1000: always restart the tx queue after an overrun

 - eth: mlx5e: again mutually exclude RX-FCS and RX-port-timestamp

 - eth: nfp: avoid rmmod nfp crash issues

 - eth: octeontx2-pf: fix page pool frag allocation warning

Previous releases - always broken:

 - mctp: perform route lookups under a RCU read-side lock

 - bpf: s390: fix clobbering the caller's backchain in the trampoline

 - phy: lynx-28g: cancel the CDR check work item on the remove path

 - dsa: qca8k: fix qca8k driver for Turris 1.x

 - eth: ravb: fix use-after-free issue in ravb_tx_timeout_work()

 - eth: ixgbe: fix crash with empty VF macvlan list

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Andrew Kanner (1):
      xdp: Fix zero-size allocation warning in xskq_create()

Björn Töpel (2):
      riscv, bpf: Sign-extend return values
      riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values

Dan Carpenter (2):
      mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type
      ixgbe: fix crash with empty VF macvlan list

Daniel Borkmann (6):
      bpf: Fix BPF_PROG_QUERY last field check
      bpf: Handle bpf_mprog_query with NULL entry
      selftests/bpf: Test bpf_mprog query API via libbpf and raw syscall
      selftests/bpf: Adapt assert_mprog_count to always expect 0 count
      selftests/bpf: Test query on empty mprog and pass revision into attach
      selftests/bpf: Make seen_tc* variable tests more robust

David S. Miller (2):
      Merge branch 'lynx-28g-fixes'
      Merge branch 'qca8k-fixes'

David Vernet (2):
      bpf: Fix verifier log for async callback return values
      selftests/bpf: Add testcase for async callback return value failure

Dinghao Liu (1):
      ieee802154: ca8210: Fix a potential UAF in ca8210_probe

Eric Dumazet (2):
      net: refine debug info in skb_checksum_help()
      net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()

Gerd Bayer (1):
      net/smc: Fix dependency of SMC on ISM

Gustavo A. R. Silva (1):
      net: sched: cls_u32: Fix allocation size in u32_init()

Haibo Chen (2):
      arm64: dts: imx93: add the Flex-CAN stop mode by GPR
      can: flexcan: remove the auto stop mode for IMX93

Ilya Leoshkevich (2):
      s390/bpf: Fix clobbering the caller's backchain in the trampoline
      s390/bpf: Fix unwinding past the trampoline

Ioana Ciornei (1):
      phy: lynx-28g: cancel the CDR check work item on the remove path

Jakub Kicinski (5):
      Merge branch 'ravb-fix-use-after-free-issues'
      Merge tag 'linux-can-fixes-for-6.6-20231009' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'ieee802154-for-net-2023-10-10' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan
      net: tcp: fix crashes trying to free half-baked MTU probes

Javier Carrasco (1):
      net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read

Jeremy Cline (1):
      nfc: nci: assert requested protocol is valid

Jeremy Kerr (1):
      mctp: perform route lookups under a RCU read-side lock

John Watts (1):
      can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set

Kory Maincent (1):
      ethtool: Fix mod state of verbose no_mask bitset

Kuniyuki Iwashima (1):
      af_packet: Fix fortified memcpy() without flex array.

Lorenz Bauer (1):
      bpf: Refuse unused attributes in bpf_prog_{attach,detach}

Lukas Magel (1):
      can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Marc Kleine-Budde (1):
      Merge patch series "arm64: dts: imx93: add the Flex-CAN stop mode by GPR"

Marek Behún (2):
      net: dsa: qca8k: fix regmap bulk read/write methods on big endian systems
      net: dsa: qca8k: fix potential MDIO bus conflict when accessing internal PHYs via management frames

Markus Schneider-Pargmann (1):
      can: tcan4x5x: Fix id2_register for tcan4553

Michal Swiatkowski (1):
      ice: block default rule setting on LAG interface

Miquel Raynal (1):
      can: sja1000: Always restart the Tx queue after an overrun

Moshe Shemesh (1):
      devlink: Hold devlink lock on health reporter dump get

Nils Hoppmann (1):
      net/smc: Fix pos miscalculation in statistics

Paolo Abeni (2):
      Merge branch 'add-update_pn-flag'
      Merge branch 'rswitch-fix-issues-on-specific-conditions'

Radu Pirea (NXP OSS) (4):
      net: macsec: indicate next pn update when offloading
      octeontx2-pf: mcs: update PN only when update_pn is true
      net: phy: mscc: macsec: reject PN update requests
      net/mlx5e: macsec: use update_pn flag instead of PN comparation

Randy Dunlap (1):
      net: skbuff: fix kernel-doc typos

Ratheesh Kannoth (1):
      octeontx2-pf: Fix page pool frag allocation warning

Roger Pau Monne (1):
      xen-netback: use default TX queue size for vifs

Vladimir Oltean (2):
      phy: lynx-28g: lock PHY while performing CDR lock workaround
      phy: lynx-28g: serialize concurrent phy_set_mode_ext() calls to shared registers

Will Mortensen (1):
      net/mlx5e: Again mutually exclude RX-FCS and RX-port-timestamp

Yanguo Li (1):
      nfp: flower: avoid rmmod nfp crash issues

Yoshihiro Shimoda (4):
      ravb: Fix up dma_free_coherent() call in ravb_remove()
      ravb: Fix use-after-free issue in ravb_tx_timeout_work()
      rswitch: Fix renesas_eth_sw_remove() implementation
      rswitch: Fix imbalance phy_power_off() calling

 arch/arm64/boot/dts/freescale/imx93.dtsi           |   4 +-
 arch/riscv/net/bpf_jit_comp64.c                    |  18 +-
 arch/s390/net/bpf_jit_comp.c                       |  25 +-
 drivers/net/can/Kconfig                            |   2 +-
 drivers/net/can/flexcan/flexcan-core.c             |  46 +---
 drivers/net/can/flexcan/flexcan.h                  |   2 -
 drivers/net/can/m_can/tcan4x5x-core.c              |   2 +-
 drivers/net/can/sja1000/sja1000.c                  |   8 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |  15 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |  32 +++
 drivers/net/ethernet/intel/ice/ice_lag.h           |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |   6 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   5 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_macsec.c  |  13 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   1 +
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   3 +-
 .../ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c   |   4 +-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c   |  10 +-
 .../net/ethernet/netronome/nfp/flower/conntrack.c  |  19 +-
 drivers/net/ethernet/netronome/nfp/flower/main.h   |   2 +
 .../net/ethernet/netronome/nfp/flower/metadata.c   |   2 +
 .../net/ethernet/netronome/nfp/flower/offload.c    |  24 +-
 .../net/ethernet/netronome/nfp/flower/qos_conf.c   |  20 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   6 +-
 drivers/net/ethernet/renesas/rswitch.c             |  12 +-
 drivers/net/ieee802154/ca8210.c                    |  17 +-
 drivers/net/macsec.c                               |   2 +
 drivers/net/phy/mscc/mscc_macsec.c                 |   6 +
 drivers/net/usb/dm9601.c                           |   7 +-
 drivers/net/xen-netback/interface.c                |   4 -
 drivers/phy/freescale/phy-fsl-lynx-28g.c           |  27 +-
 drivers/s390/net/Kconfig                           |   2 +-
 include/linux/skbuff.h                             |   4 +-
 include/net/macsec.h                               |   1 +
 include/uapi/linux/if_packet.h                     |   6 +-
 kernel/bpf/mprog.c                                 |  10 +-
 kernel/bpf/syscall.c                               |  21 +-
 kernel/bpf/tcx.c                                   |   8 +-
 kernel/bpf/verifier.c                              |   6 +-
 net/can/isotp.c                                    |  19 +-
 net/core/dev.c                                     |   8 +-
 net/devlink/health.c                               |  30 +--
 net/ethtool/bitset.c                               |  32 ++-
 net/ipv4/tcp_output.c                              |   1 +
 net/mctp/route.c                                   |  22 +-
 net/nfc/llcp_core.c                                |  30 +--
 net/nfc/nci/core.c                                 |   5 +
 net/packet/af_packet.c                             |   7 +-
 net/sched/cls_u32.c                                |   2 +-
 net/smc/Kconfig                                    |   1 +
 net/smc/smc_stats.h                                |  14 +-
 net/xdp/xsk_queue.c                                |  10 +
 .../testing/selftests/bpf/prog_tests/tc_helpers.h  |  16 +-
 tools/testing/selftests/bpf/prog_tests/tc_links.c  |  64 ++---
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   | 271 +++++++++++++++++++--
 tools/testing/selftests/bpf/prog_tests/timer.c     |   6 +-
 tools/testing/selftests/bpf/progs/timer_failure.c  |  47 ++++
 58 files changed, 712 insertions(+), 280 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/timer_failure.c

