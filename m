Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A3E786D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbjHXLDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbjHXLCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A12D19B6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692874850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QAfwdEDndECSlDGorQjnh/S+F3+SKEyMi4kul5pbia0=;
        b=K8nszRKW1ibcWC4bucTcVb3yZCz+ycuF0UCpPJT40blpjltmepRwx2yKV2R72AGW4cng+a
        3yI5b4XnHOIjf8cjhcKEKH/yc+38+JtD4Cqk0eghi5cFZlwbbsbscxQrpq5wgXuTgH23aV
        3hTi/uauKFxXxKO7+SBo3bSSVLMM3V4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-BlUxG03TPHOaVS6aUlFt0A-1; Thu, 24 Aug 2023 07:00:44 -0400
X-MC-Unique: BlUxG03TPHOaVS6aUlFt0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9503185A7B8;
        Thu, 24 Aug 2023 11:00:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 878B01121314;
        Thu, 24 Aug 2023 11:00:42 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for 6.5-rc8
Date:   Thu, 24 Aug 2023 13:00:37 +0200
Message-ID: <20230824110037.31215-1-pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

I preserved the new section introduced by Jakub in the previous -net
PR, I hope it makes things clearer.

No known outstanding regressions.

The following changes since commit 0e8860d2125f51ba9bca67a520d826cb8f66cf42:

  Merge tag 'net-6.5-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-08-18 06:52:23 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc8

for you to fetch changes up to 8938fc0c7e16e0868a1083deadc91b95b72ca0da:

  Merge tag 'nf-23-08-23' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2023-08-24 10:33:22 +0200)

----------------------------------------------------------------
Networking fixes for 6.5-rc8, including fixes from wifi, can
and netfilter

Fixes to fixes:

  - nf_tables:
    - GC transaction race with abort path
    - defer gc run if previous batch is still pending

Previous releases - regressions:

  - ipv4: fix data-races around inet->inet_id

  - phy: fix deadlocking in phy_error() invocation

  - mdio: fix C45 read/write protocol

  - ipvlan: fix a reference count leak warning in ipvlan_ns_exit()

  - ice: fix NULL pointer deref during VF reset

  - i40e: fix potential NULL pointer dereferencing of pf->vf i40e_sync_vsi_filters()

  - tg3: use slab_build_skb() when needed

  - mtk_eth_soc: fix NULL pointer on hw reset

Previous releases - always broken:

  - core: validate veth and vxcan peer ifindexes

  - sched: fix a qdisc modification with ambiguous command request

  - devlink: add missing unregister linecard notification

  - wifi: mac80211: limit reorder_buf_filtered to avoid UBSAN warning

  - batman:
    - do not get eth header before batadv_check_management_packet
    - fix batadv_v_ogm_aggr_send memory leak

  - bonding: fix macvlan over alb bond support

  - mlxsw: set time stamp fields also when its type is MIRROR_UTC

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alessio Igor Bogani (1):
      igb: Avoid starting unnecessary workqueues

Amit Cohen (1):
      mlxsw: Fix the size of 'VIRT_ROUTER_MSB'

Andrii Staikov (1):
      i40e: fix potential NULL pointer dereferencing of pf->vf i40e_sync_vsi_filters()

Anh Tuan Phan (1):
      selftests/net: Add log.txt and tools to .gitignore

Arınç ÜNAL (1):
      net: dsa: mt7530: fix handling of 802.1X PAE frames

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: fix NULL pointer on hw reset

Danielle Ratson (1):
      mlxsw: pci: Set time stamp fields also when its type is MIRROR_UTC

David S. Miller (1):
      Merge branch 'fixed_phy_register-return-value'

Edward Cree (1):
      sfc: allocate a big enough SKB for loopback selftest packet

Eric Dumazet (3):
      sock: annotate data-races around prot->memory_pressure
      dccp: annotate data-races in dccp_poll()
      ipv4: fix data-races around inet->inet_id

Florian Westphal (3):
      netfilter: nf_tables: validate all pending tables
      netfilter: nf_tables: fix out of memory error handling
      netfilter: nf_tables: defer gc run if previous batch is still pending

Hangbin Liu (4):
      selftests: bonding: do not set port down before adding to bond
      bonding: fix macvlan over alb bond support
      selftest: bond: add new topo bond_topo_2d1c.sh
      selftests: bonding: add macvlan over bond testing

Hariprasad Kelam (1):
      octeontx2-af: SDP: fix receive link config

Ido Schimmel (3):
      mlxsw: reg: Fix SSPR register layout
      selftests: mlxsw: Fix test failure on Spectrum-4
      rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Jakub Kicinski (6):
      Merge tag 'batadv-net-pullrequest-20230816' of git://git.open-mesh.org/linux-merge
      Merge branch 'mlxsw-fixes-for-spectrum-4'
      net: validate veth and vxcan peer ifindexes
      Merge tag 'wireless-2023-08-22' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'can-fixes-for-6-5-rc7'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Jamal Hadi Salim (1):
      net/sched: fix a qdisc modification with ambiguous command request

Jesse Brandeburg (1):
      ice: fix receive buffer size miscalculation

Jiri Pirko (1):
      devlink: add missing unregister linecard notification

Josua Mayer (1):
      net: sfp: handle 100G/25G active optical cables in sfp_parse_support

Kees Cook (1):
      tg3: Use slab_build_skb() when needed

Lu Wei (1):
      ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()

Marek Behún (1):
      leds: trigger: netdev: rename 'hw_control' sysfs entry to 'offloaded'

Michael Ellerman (1):
      ibmveth: Use dcbf rather than dcbfl

Oliver Hartkopp (2):
      can: isotp: fix support for transmission of SF without flow control
      can: raw: add missing refcount for memory leak fix

Pablo Neira Ayuso (3):
      netfilter: nf_tables: flush pending destroy work before netlink notifier
      netfilter: nf_tables: GC transaction race with abort path
      netfilter: nf_tables: use correct lock to protect gc_list

Paolo Abeni (2):
      Merge branch 'fix-macvlan-over-alb-bond-support'
      Merge tag 'nf-23-08-23' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Petr Oros (2):
      Revert "ice: Fix ice VF reset during iavf initialization"
      ice: Fix NULL pointer deref during VF reset

Ping-Ke Shih (1):
      wifi: mac80211: limit reorder_buf_filtered to avoid UBSAN warning

Randy Dunlap (1):
      wifi: iwlwifi: mvm: add dependency for PTP clock

Remi Pommarel (3):
      batman-adv: Do not get eth header before batadv_check_management_packet
      batman-adv: Fix TT global entry leak when client roamed back
      batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Ruan Jinjie (2):
      net: bgmac: Fix return value check for fixed_phy_register()
      net: bcmgenet: Fix return value check for fixed_phy_register()

Sabrina Dubroca (1):
      MAINTAINERS: add entry for macsec

Sasha Neftin (1):
      igc: Fix the typo in the PTM Control macro

Serge Semin (2):
      net: mdio: mdio-bitbang: Fix C45 read/write protocol
      net: phy: Fix deadlocking in phy_error() invocation

Sven Eckelmann (3):
      batman-adv: Trigger events for auto adjusted MTU
      batman-adv: Don't increase MTU when set by user
      batman-adv: Hold rtnl lock during MTU update via netlink

Thinh Tran (1):
      bnx2x: new flag for track HW resource allocation

Vladimir Oltean (1):
      net: dsa: felix: fix oversize frame dropping for always closed tc-taprio gates

 .../ABI/testing/sysfs-class-led-trigger-netdev     |  20 +--
 MAINTAINERS                                        |  10 ++
 drivers/leds/trigger/ledtrig-netdev.c              |   8 +-
 drivers/net/bonding/bond_alb.c                     |   6 +-
 drivers/net/can/vxcan.c                            |   7 +-
 drivers/net/dsa/mt7530.c                           |   4 +
 drivers/net/dsa/mt7530.h                           |   2 +
 drivers/net/dsa/ocelot/felix_vsc9959.c             |   3 +
 drivers/net/ethernet/broadcom/bgmac.c              |   2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |   2 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |  21 +--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  32 +++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c   |  17 ++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   2 +-
 drivers/net/ethernet/broadcom/tg3.c                |   5 +-
 .../chelsio/inline_crypto/chtls/chtls_cm.c         |   2 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   5 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |   3 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |   8 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  34 ++---
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |   1 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   1 -
 drivers/net/ethernet/intel/igb/igb_ptp.c           |  24 ++--
 drivers/net/ethernet/intel/igc/igc_defines.h       |   2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   3 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |  12 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c   |   4 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |   8 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h          |   9 --
 .../ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c    |   2 +-
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c        |   4 +-
 drivers/net/ethernet/sfc/falcon/selftest.c         |   2 +-
 drivers/net/ethernet/sfc/selftest.c                |   2 +-
 drivers/net/ethernet/sfc/siena/selftest.c          |   2 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   3 +-
 drivers/net/mdio/mdio-bitbang.c                    |   4 +-
 drivers/net/phy/phy.c                              |  11 +-
 drivers/net/phy/sfp-bus.c                          |  10 ++
 drivers/net/veth.c                                 |   5 +-
 drivers/net/wireless/intel/iwlwifi/Kconfig         |   1 +
 include/net/bonding.h                              |  11 +-
 include/net/inet_sock.h                            |   2 +-
 include/net/ip.h                                   |  15 +-
 include/net/mac80211.h                             |   1 +
 include/net/netfilter/nf_tables.h                  |   6 +
 include/net/rtnetlink.h                            |   4 +-
 include/net/sock.h                                 |   7 +-
 net/batman-adv/bat_v_elp.c                         |   3 +-
 net/batman-adv/bat_v_ogm.c                         |   7 +-
 net/batman-adv/hard-interface.c                    |  14 +-
 net/batman-adv/netlink.c                           |   3 +
 net/batman-adv/soft-interface.c                    |   3 +
 net/batman-adv/translation-table.c                 |   1 -
 net/batman-adv/types.h                             |   6 +
 net/can/isotp.c                                    |  22 +--
 net/can/raw.c                                      |  35 +++--
 net/core/rtnetlink.c                               |  25 +++-
 net/dccp/ipv4.c                                    |   4 +-
 net/dccp/proto.c                                   |  20 +--
 net/devlink/leftover.c                             |   3 +
 net/ipv4/af_inet.c                                 |   2 +-
 net/ipv4/datagram.c                                |   2 +-
 net/ipv4/tcp_ipv4.c                                |   4 +-
 net/mac80211/rx.c                                  |  12 +-
 net/netfilter/nf_tables_api.c                      |  23 +--
 net/netfilter/nft_set_hash.c                       |   3 +
 net/netfilter/nft_set_pipapo.c                     |  13 +-
 net/netfilter/nft_set_rbtree.c                     |   3 +
 net/sched/sch_api.c                                |  53 +++++--
 net/sctp/socket.c                                  |   4 +-
 .../testing/selftests/drivers/net/bonding/Makefile |   4 +-
 .../drivers/net/bonding/bond-break-lacpdu-tx.sh    |   4 +-
 .../selftests/drivers/net/bonding/bond_macvlan.sh  |  99 +++++++++++++
 .../selftests/drivers/net/bonding/bond_options.sh  |   3 -
 .../drivers/net/bonding/bond_topo_2d1c.sh          | 158 +++++++++++++++++++++
 .../drivers/net/bonding/bond_topo_3d1c.sh          | 118 ++-------------
 .../selftests/drivers/net/mlxsw/sharedbuffer.sh    |  16 +--
 tools/testing/selftests/net/.gitignore             |   2 +
 79 files changed, 664 insertions(+), 356 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
 create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh

