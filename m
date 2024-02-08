Return-Path: <linux-kernel+bounces-58270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8822C84E3C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC73E1C23F67
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F298A7B3CE;
	Thu,  8 Feb 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6pi+m7e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE977F33
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405167; cv=none; b=Pwu97Qm9jm5q3NLXL0ZJz2xeTbiLnS6EEBKTEAqh4eRvC2CTP5moQbY2WgVgISRx1nsQ6GSUtUbjxGc6UNGqQGUbiSUOszzg3mlSMAqnyqXI9hpHCwbgzJgmkQgdCR5MNqi3TniM8vy3DKL7iEufO5BR5MCWP7Y6PpewjgMYf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405167; c=relaxed/simple;
	bh=RFIJ0KiDhhCBl9EBLdbQnLEyeeKR5/9NEEKDYFhddi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZOhEYbQYy9lNANlhXLH1W3/cQ9pbEvn9KTk84wnYQ76qjJhEQzqtiUutEBOb+1SEk9YaZdbt5OP0pABs9435cW8ysJwZM7rYZaFqn9q91+OwX/ChoB3obC2Ts7JjMl1OfT5vHk0Xd/BOdkSdA0cQBG7JbBlNayIcFU4BLTlxdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6pi+m7e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707405164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L2yT4Q5HbZZn/pnZIT3JCILdiZlRIsvOkywrtD15a3A=;
	b=A6pi+m7eZJgxaYCAaPjU8PJJAUEDk3dAsA0iYG9Pr12Fkcz8drV+aR01Nh7qfULjajVo/+
	nnklBHMmwl97yyFr6syovI8EEs375NqTZXoMnCDUq5Z9e2Ma60oGKMoGHk+DRkvH41vQ2a
	3KGZZahWCcLfWsc+37sp13hKz+638yQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592--Ue-R4fZNV6oj7O5ElkVjg-1; Thu, 08 Feb 2024 10:12:41 -0500
X-MC-Unique: -Ue-R4fZNV6oj7O5ElkVjg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C19E6863735;
	Thu,  8 Feb 2024 15:12:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.247])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D5FC492BFD;
	Thu,  8 Feb 2024 15:12:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.8-rc4
Date: Thu,  8 Feb 2024 16:12:37 +0100
Message-ID: <20240208151237.48692-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hi Linus!

The following changes since commit 41b9fb381a486360b2daaec0c7480f8e3ff72bc7:

  Merge tag 'net-6.8-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-02-01 12:39:54 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc4

for you to fetch changes up to 63e4b9d693e0f8c28359c7ea81e1ee510864c37b:

  Merge tag 'nf-24-02-08' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-02-08 12:56:40 +0100)

----------------------------------------------------------------
Including fixes from WiFi and netfilter.

Current release - regressions:

  - nic: intel: fix old compiler regressions

  - netfilter: ipset: missing gc cancellations fixed

Current release - new code bugs:

  - netfilter: ctnetlink: fix filtering for zone 0

Previous releases - regressions:

  - core: fix from address in memcpy_to_iter_csum()

  - netfilter: nfnetlink_queue: un-break NF_REPEAT

  - af_unix: fix memory leak for dead unix_(sk)->oob_skb in GC.

  - devlink: avoid potential loop in devlink_rel_nested_in_notify_work()

  - iwlwifi:
    - mvm: fix a battery life regression
    - fix double-free bug

  - mac80211: fix waiting for beacons logic

  - nic: nfp: flower: prevent re-adding mac index for bonded port

Previous releases - always broken:

  - rxrpc: fix generation of serial numbers to skip zero

  - tipc: check the bearer type before calling tipc_udp_nl_bearer_add()

  - tunnels: fix out of bounds access when building IPv6 PMTU error

  - nic: hv_netvsc: register VF in netvsc_probe if NET_DEVICE_REGISTER missed

  - nic: atlantic: fix DMA mapping for PTP hwts ring

Misc:

  - selftests: more fixes to deal with very slow hosts

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexandra Winter (1):
      s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Allison Henderson (1):
      MAINTAINERS: Maintainer change for rds

Antoine Tenart (1):
      tunnels: fix out of bounds access when building IPv6 PMTU error

Arend van Spriel (1):
      MAINTAINERS: wifi: brcm80211: cleanup entry

Benjamin Berg (2):
      wifi: iwlwifi: mvm: skip adding debugfs symlink for reconfig
      wifi: iwlwifi: do not announce EPCS support

Breno Leitao (9):
      wifi: fill in MODULE_DESCRIPTION()s for wlcore
      wifi: fill in MODULE_DESCRIPTION()s for wl1251 and wl12xx
      wifi: fill in MODULE_DESCRIPTION()s for Broadcom WLAN
      wifi: fill in MODULE_DESCRIPTION()s for ar5523
      wifi: fill in MODULE_DESCRIPTION()s for wcn36xx
      wifi: fill in MODULE_DESCRIPTION()s for p54spi
      wifi: fill in MODULE_DESCRIPTION()s for wl18xx
      wifi: fill in MODULE_DESCRIPTION()s for wilc1000
      wifi: fill in MODULE_DESCRIPTION()s for mt76 drivers

Daniel Basilio (1):
      nfp: use correct macro for LengthSelect in BAR config

Daniel de Villiers (1):
      nfp: flower: prevent re-adding mac index for bonded port

David Howells (4):
      rxrpc: Fix generation of serial numbers to skip zero
      rxrpc: Fix delayed ACKs to not set the reference serial number
      rxrpc: Fix response to PING RESPONSE ACKs to a dead call
      rxrpc: Fix counting of new acks and nacks

David S. Miller (2):
      Merge branch 'nfp-fixes'
      Merge branch 'rxrpc-fixes'

Dmitry Safonov (1):
      selftests/net: Amend per-netns counter checks

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix a battery life regression

Eric Dumazet (3):
      netdevsim: avoid potential loop in nsim_dev_trap_report_work()
      inet: read sk->sk_family once in inet_recv_error()
      ppp_async: limit MRU to 64K

Felix Fietkau (1):
      wifi: mt76: mt7996: fix fortify warning

Felix Huettner (1):
      netfilter: ctnetlink: fix filtering for zone 0

Florian Westphal (4):
      netfilter: nfnetlink_queue: un-break NF_REPEAT
      netfilter: nft_set_pipapo: store index in scratch maps
      netfilter: nft_set_pipapo: add helper to release pcpu scratch area
      netfilter: nft_set_pipapo: remove scratch_aligned pointer

Furong Xu (2):
      net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
      net: stmmac: xgmac: fix a typo of register name in DPP safety handling

Gerhard Engleder (1):
      tsnep: Fix mapping for zero copy XDP_TX action

Gregory Greenman (1):
      MAINTAINERS: remove myself as iwlwifi driver maintainer

Ivan Vecera (1):
      net: atlantic: Fix DMA mapping for PTP hwts ring

Jakub Kicinski (3):
      Merge branch 'selftests-net-more-fixes'
      selftests: cmsg_ipv6: repeat the exact packet
      Merge tag 'wireless-2024-02-06' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

James Hershaw (1):
      nfp: enable NETDEV_XDP_ACT_REDIRECT feature flag

Jesse Brandeburg (1):
      net: intel: fix old compiler regressions

Jiri Pirko (1):
      devlink: avoid potential loop in devlink_rel_nested_in_notify_work()

Johannes Berg (13):
      wifi: iwlwifi: fix double-free bug
      wifi: cfg80211: fix wiphy delayed work queueing
      wifi: iwlwifi: remove extra kernel-doc
      wifi: cfg80211: detect stuck ECSA element in probe resp
      wifi: mac80211: improve CSA/ECSA connection refusal
      wifi: mac80211: fix RCU use in TDLS fast-xmit
      wifi: mac80211: set station RX-NSS on reconfig
      wifi: mac80211: fix driver debugfs for vif type change
      wifi: mac80211: initialize SMPS mode correctly
      wifi: mac80211: fix unsolicited broadcast probe config
      wifi: mac80211: fix waiting for beacons logic
      wifi: mac80211: adding missing drv_mgd_complete_tx() call
      wifi: mac80211: accept broadcast probe responses on 6 GHz

Jozsef Kadlecsik (1):
      netfilter: ipset: Missing gc cancellations fixed

Kees Cook (1):
      wifi: brcmfmac: Adjust n_channels usage for __counted_by

Kuniyuki Iwashima (1):
      af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.

Mario Limonciello (1):
      wifi: mac80211: Drop WBRF debugging statements

Michael Lass (1):
      net: Fix from address in memcpy_to_iter_csum()

Miri Korenblit (1):
      wifi: iwlwifi: exit eSR only after the FW does

Pablo Neira Ayuso (7):
      netfilter: nft_compat: narrow down revision to unsigned 8-bits
      netfilter: nft_compat: reject unused compat flag
      netfilter: nft_compat: restrict match/target protocol to u16
      netfilter: nft_set_pipapo: remove static in nft_pipapo_get()
      netfilter: nft_ct: reject direction for ct id
      netfilter: nf_tables: use timestamp to check for set element timeout
      netfilter: nft_set_rbtree: skip end interval element from gc

Paolo Abeni (7):
      selftests: net: cut more slack for gro fwd tests.
      selftests: net: fix setup_ns usage in rtnetlink.sh
      selftests: net: fix tcp listener handling in pmtu.sh
      selftests: net: avoid just another constant wait
      selftests: net: let big_tcp test cope with slow env
      Merge branch 'cpsw-enable-mac_managed_pm-to-fix-mdio'
      Merge tag 'nf-24-02-08' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Petr Tesarik (1):
      net: stmmac: protect updates of 64-bit statistics counters

Ratheesh Kannoth (1):
      octeontx2-af: Initialize maps.

Shigeru Yoshida (1):
      tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

Shradha Gupta (1):
      hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Sinthu Raja (2):
      net: ethernet: ti: cpsw_new: enable mac_managed_pm to fix mdio
      net: ethernet: ti: cpsw: enable mac_managed_pm to fix mdio

Zhipeng Lu (2):
      atm: idt77252: fix a memleak in open_card_ubr0
      octeontx2-pf: Fix a memleak otx2_sq_init

 MAINTAINERS                                        |  11 +-
 drivers/atm/idt77252.c                             |   2 +
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c    |   4 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  13 ++
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h   |   1 +
 drivers/net/ethernet/engleder/tsnep_main.c         |  16 ++-
 drivers/net/ethernet/intel/i40e/i40e_dcb.h         |   2 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h         |   2 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |   2 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  31 +++--
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  14 ++-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |   2 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |   1 +
 .../ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c  |   6 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |  57 ++++++---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  15 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  15 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |  15 ++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   3 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  57 ++++++++-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  15 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   | 129 +++++++++++++-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 133 ++++++++++-----------
 drivers/net/ethernet/ti/cpsw.c                     |   2 +
 drivers/net/ethernet/ti/cpsw_new.c                 |   3 +
 drivers/net/hyperv/netvsc_drv.c                    |  82 +++++++++----
 drivers/net/netdevsim/dev.c                        |   8 +-
 drivers/net/ppp/ppp_async.c                        |   4 +
 drivers/net/wireless/ath/ar5523/ar5523.c           |   1 +
 drivers/net/wireless/ath/wcn36xx/main.c            |   1 +
 .../broadcom/brcm80211/brcmfmac/bca/module.c       |   1 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   6 +-
 .../broadcom/brcm80211/brcmfmac/cyw/module.c       |   1 +
 .../broadcom/brcm80211/brcmfmac/wcc/module.c       |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   9 +-
 drivers/net/wireless/intersil/p54/p54spi.c         |   1 +
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c    |   1 +
 .../net/wireless/mediatek/mt76/mt7615/usb_sdio.c   |   1 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |   1 +
 .../net/wireless/mediatek/mt76/mt76x02_usb_mcu.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   1 +
 drivers/net/wireless/mediatek/mt76/sdio.c          |   1 +
 drivers/net/wireless/mediatek/mt76/usb.c           |   1 +
 drivers/net/wireless/mediatek/mt76/util.c          |   1 +
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   1 +
 drivers/net/wireless/microchip/wilc1000/sdio.c     |   1 +
 drivers/net/wireless/microchip/wilc1000/spi.c      |   1 +
 drivers/net/wireless/ti/wl1251/sdio.c              |   1 +
 drivers/net/wireless/ti/wl1251/spi.c               |   1 +
 drivers/net/wireless/ti/wl12xx/main.c              |   1 +
 drivers/net/wireless/ti/wl18xx/main.c              |   1 +
 drivers/net/wireless/ti/wlcore/main.c              |   1 +
 drivers/net/wireless/ti/wlcore/sdio.c              |   1 +
 drivers/net/wireless/ti/wlcore/spi.c               |   1 +
 drivers/s390/net/qeth_l3_main.c                    |   9 +-
 include/net/cfg80211.h                             |   4 +
 include/net/netfilter/nf_tables.h                  |  16 ++-
 include/trace/events/rxrpc.h                       |   8 +-
 include/uapi/linux/netfilter/nf_tables.h           |   2 +
 net/core/datagram.c                                |   2 +-
 net/devlink/core.c                                 |  12 +-
 net/ipv4/af_inet.c                                 |   6 +-
 net/ipv4/ip_tunnel_core.c                          |   2 +-
 net/mac80211/cfg.c                                 |  16 +--
 net/mac80211/debugfs_netdev.c                      |   4 +-
 net/mac80211/debugfs_netdev.h                      |   5 -
 net/mac80211/iface.c                               |   2 +-
 net/mac80211/mlme.c                                | 114 +++++++++++++-----
 net/mac80211/scan.c                                |  30 +++--
 net/mac80211/tx.c                                  |   7 +-
 net/mac80211/wbrf.c                                |   2 -
 net/netfilter/ipset/ip_set_core.c                  |   2 +
 net/netfilter/ipset/ip_set_hash_gen.h              |   4 +-
 net/netfilter/nf_conntrack_netlink.c               |  12 +-
 net/netfilter/nf_tables_api.c                      |   4 +-
 net/netfilter/nfnetlink_queue.c                    |  13 +-
 net/netfilter/nft_compat.c                         |  17 ++-
 net/netfilter/nft_ct.c                             |   3 +
 net/netfilter/nft_set_hash.c                       |   8 +-
 net/netfilter/nft_set_pipapo.c                     | 128 ++++++++++----------
 net/netfilter/nft_set_pipapo.h                     |  18 ++-
 net/netfilter/nft_set_pipapo_avx2.c                |  17 ++-
 net/netfilter/nft_set_rbtree.c                     |  17 +--
 net/rxrpc/ar-internal.h                            |  37 ++++--
 net/rxrpc/call_event.c                             |  12 +-
 net/rxrpc/call_object.c                            |   1 +
 net/rxrpc/conn_event.c                             |  10 +-
 net/rxrpc/input.c                                  | 115 +++++++++++++++---
 net/rxrpc/output.c                                 |   8 +-
 net/rxrpc/proc.c                                   |   2 +-
 net/rxrpc/rxkad.c                                  |   4 +-
 net/tipc/bearer.c                                  |   6 +
 net/unix/garbage.c                                 |  11 ++
 net/wireless/core.c                                |   3 +-
 net/wireless/scan.c                                |  59 ++++++++-
 tools/testing/selftests/net/big_tcp.sh             |   4 +-
 tools/testing/selftests/net/cmsg_ipv6.sh           |   4 +-
 tools/testing/selftests/net/pmtu.sh                |  23 +++-
 tools/testing/selftests/net/rtnetlink.sh           |   6 +-
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  |  12 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |  14 ++-
 tools/testing/selftests/net/udpgso_bench_rx.c      |   2 +-
 .../selftests/netfilter/conntrack_dump_flush.c     |  43 ++++++-
 130 files changed, 1104 insertions(+), 481 deletions(-)


