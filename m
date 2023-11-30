Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3D7FEF96
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345450AbjK3M55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345369AbjK3M5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:57:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E9C10C9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701349080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0ASa9WpbKWW7aZFBB+5VpaDclg9OAib7/Ai6IndLNTE=;
        b=K/BUMA2UnK37qi4PQqxrS0+oSqS5GPuDm5oKqDNeTUc/YBjtVABemIB7Fnj+urWAJoqlnv
        S9D4BU0f6D1xhi933yzMWKoh5UH2pbpzHINcwzA/zaxqDdfPfW8lMIgl4Q/kg/Ju+Q7G5n
        IkpZ5hDz+6OYYlHXVkyK5RDQs1avjgE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-kJoUytKpPc6Jkcb_56_PPQ-1; Thu, 30 Nov 2023 07:56:55 -0500
X-MC-Unique: kJoUytKpPc6Jkcb_56_PPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB32E866DCA;
        Thu, 30 Nov 2023 12:56:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FE8A40C6EB9;
        Thu, 30 Nov 2023 12:56:53 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.7-rc4
Date:   Thu, 30 Nov 2023 13:56:38 +0100
Message-ID: <20231130125638.726279-1-pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

We just received a report regarding the WiFi/debugfs fixes below possibly
causing some dmesg noise - trying to register multiple times the same entry.
I hope it should not block this.

The following changes since commit d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7:

  Merge tag 'net-6.7-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-23 10:40:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc4

for you to fetch changes up to 777f245eec8152926b411e3d4f4545310f52cbed:

  Merge branch 'net-ravb-fixes-for-the-ravb-driver' (2023-11-30 10:59:11 +0100)

----------------------------------------------------------------
Including fixes from bpf and wifi.

Current release - regressions:

  - neighbour: fix __randomize_layout crash in struct neighbour

  - r8169: fix deadlock on RTL8125 in jumbo mtu mode

Previous releases - regressions:

  - wifi:
    - mac80211: fix warning at station removal time
    - cfg80211: fix CQM for non-range use

  - tools: ynl-gen: fix unexpected response handling

  - octeontx2-af: fix possible buffer overflow

  - dpaa2: recycle the RX buffer only after all processing done

  - rswitch: fix missing dev_kfree_skb_any() in error path

Previous releases - always broken:

  - ipv4: fix uaf issue when receiving igmp query packet

  - wifi: mac80211: fix debugfs deadlock at device removal time

  - bpf:
    - sockmap: af_unix stream sockets need to hold ref for pair sock
    - netdevsim: don't accept device bound programs

  - selftests: fix a char signedness issue

  - dsa: mv88e6xxx: fix marvell 6350 probe crash

  - octeontx2-pf: restore TC ingress police rules when interface is up

  - wangxun: fix memory leak on msix entry

  - ravb: keep reverse order of operations in ravb_remove()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Ben Greear (1):
      wifi: mac80211: handle 320 MHz in ieee80211_ht_cap_ie_to_sta_ht_cap

Claudiu Beznea (6):
      net: ravb: Check return value of reset_control_deassert()
      net: ravb: Use pm_runtime_resume_and_get()
      net: ravb: Make write access to CXR35 first before accessing other EMAC registers
      net: ravb: Start TX queues after HW initialization succeeded
      net: ravb: Stop DMA in case of failures on ravb_open()
      net: ravb: Keep reverse order of operations in ravb_remove()

Dan Carpenter (1):
      wifi: iwlwifi: mvm: fix an error code in iwl_mvm_mld_add_sta()

Daniel Borkmann (1):
      netkit: Reject IFLA_NETKIT_PEER_INFO in netkit_change_link

Dave Ertman (1):
      ice: Fix VF Reset paths when interface in a failed over aggregate

David S. Miller (2):
      Merge branch 'rswitch-fixes'
      Merge branch 'dpaa2-eth-fixes'

Edward Adam Davis (1):
      mptcp: fix uninit-value in mptcp_incoming_options

Elena Salomatkina (1):
      octeontx2-af: Fix possible buffer overflow

Furong Xu (1):
      net: stmmac: xgmac: Disable FPE MMC interrupts

Geetha sowjanya (1):
      octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64

Greg Ungerer (2):
      net: dsa: mv88e6xxx: fix marvell 6350 switch probing
      net: dsa: mv88e6xxx: fix marvell 6350 probe crash

Gustavo A. R. Silva (1):
      neighbour: Fix __randomize_layout crash in struct neighbour

Heiner Kallweit (2):
      r8169: fix deadlock on RTL8125 in jumbo mtu mode
      r8169: prevent potential deadlock in rtl8169_close

Hou Tao (1):
      bpf: Add missed allocation hint for bpf_mem_cache_alloc_flags()

Ioana Ciornei (2):
      dpaa2-eth: increase the needed headroom to account for alignment
      dpaa2-eth: recycle the RX buffer only after all processing done

Jakub Kicinski (5):
      Merge branch 'selftests-net-fix-a-few-small-compiler-warnings'
      ethtool: don't propagate EOPNOTSUPP from dumps
      tools: ynl-gen: always construct struct ynl_req_state
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'wireless-2023-11-29' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jiawen Wu (1):
      net: libwx: fix memory leak on msix entry

Johannes Berg (9):
      wifi: cfg80211: fix CQM for non-range use
      wifi: cfg80211: lock wiphy mutex for rfkill poll
      wifi: cfg80211: hold wiphy mutex for send_interface
      debugfs: fix automount d_fsdata usage
      debugfs: annotate debugfs handlers vs. removal with lockdep
      debugfs: add API to allow debugfs operations cancellation
      wifi: cfg80211: add locked debugfs wrappers
      wifi: mac80211: use wiphy locked debugfs helpers for agg_status
      wifi: mac80211: use wiphy locked debugfs for sdata/link

John Fastabend (2):
      bpf, sockmap: af_unix stream sockets need to hold ref for pair sock
      bpf, sockmap: Add af_unix test with both sockets in map

Lorenzo Bianconi (1):
      wifi: mt76: mt7925: fix typo in mt7925_init_he_caps

Michael-CY Lee (1):
      wifi: avoid offset calculation on NULL pointer

Ming Yen Hsieh (1):
      wifi: mt76: mt7921: fix 6GHz disabled by the missing default CLC config

Oldřich Jedlička (1):
      wifi: mac80211: do not pass AP_VLAN vif pointer to drivers during flush

Paolo Abeni (1):
      Merge branch 'net-ravb-fixes-for-the-ravb-driver'

Stanislav Fomichev (1):
      netdevsim: Don't accept device bound programs

Subbaraya Sundeep (1):
      octeontx2-pf: Restore TC ingress police rules when interface is up

Willem de Bruijn (4):
      selftests/net: ipsec: fix constant out of range
      selftests/net: fix a char signedness issue
      selftests/net: unix: fix unused variable compiler warning
      selftests/net: mptcp: fix uninitialized variable warnings

Yoshihiro Shimoda (4):
      net: rswitch: Fix type of ret in rswitch_start_xmit()
      net: rswitch: Fix return value in rswitch_start_xmit()
      net: rswitch: Fix missing dev_kfree_skb_any() in error path
      ravb: Fix races between ravb_tx_timeout_work() and net related ops

Zhengchao Shao (1):
      ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet

 drivers/net/dsa/mv88e6xxx/chip.c                   |  26 +++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  16 ++-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           | 122 +++++++++-------
 drivers/net/ethernet/intel/ice/ice_lag.h           |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  20 +++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |  25 ++++
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   4 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   2 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   9 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   | 120 ++++++++++++----
 drivers/net/ethernet/realtek/r8169_main.c          |   9 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  69 +++++----
 drivers/net/ethernet/renesas/rswitch.c             |  22 +--
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   2 +-
 drivers/net/netdevsim/bpf.c                        |   4 +-
 drivers/net/netkit.c                               |   6 +
 drivers/net/wireless/ath/ath9k/Kconfig             |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   4 +-
 fs/debugfs/file.c                                  | 100 +++++++++++++
 fs/debugfs/inode.c                                 |  71 +++++++--
 fs/debugfs/internal.h                              |  21 ++-
 include/linux/debugfs.h                            |  19 +++
 include/linux/ieee80211.h                          |   4 +-
 include/linux/skmsg.h                              |   1 +
 include/net/af_unix.h                              |   1 +
 include/net/cfg80211.h                             |  46 ++++++
 include/net/neighbour.h                            |   2 +-
 kernel/bpf/memalloc.c                              |   2 +
 net/core/skmsg.c                                   |   2 +
 net/ethtool/netlink.c                              |   1 +
 net/ipv4/igmp.c                                    |   6 +-
 net/mac80211/Kconfig                               |   2 +-
 net/mac80211/debugfs_netdev.c                      | 150 +++++++++++++------
 net/mac80211/debugfs_sta.c                         |  74 +++++-----
 net/mac80211/driver-ops.h                          |   9 +-
 net/mac80211/ht.c                                  |   1 +
 net/mptcp/options.c                                |   1 +
 net/unix/af_unix.c                                 |   2 -
 net/unix/unix_bpf.c                                |   5 +
 net/wireless/core.c                                |   6 +-
 net/wireless/core.h                                |   1 +
 net/wireless/debugfs.c                             | 160 +++++++++++++++++++++
 net/wireless/nl80211.c                             |  55 ++++---
 tools/net/ynl/generated/devlink-user.c             |  87 +++++++----
 tools/net/ynl/generated/ethtool-user.c             |  51 ++++---
 tools/net/ynl/generated/fou-user.c                 |   6 +-
 tools/net/ynl/generated/handshake-user.c           |   3 +-
 tools/net/ynl/ynl-gen-c.py                         |  10 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      |  51 +++++--
 .../selftests/bpf/progs/test_sockmap_listen.c      |   7 +
 tools/testing/selftests/net/af_unix/diag_uid.c     |   1 -
 tools/testing/selftests/net/cmsg_sender.c          |   2 +-
 tools/testing/selftests/net/ipsec.c                |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  11 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c      |  11 +-
 60 files changed, 1128 insertions(+), 337 deletions(-)

