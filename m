Return-Path: <linux-kernel+bounces-38632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2178283C370
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F7D1C23E55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03934F88D;
	Thu, 25 Jan 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCtDrSXj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717850A82
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188590; cv=none; b=hpbTZhTiSedYn91XRW92m/nKxb5fIIqbFnoPxEW8B5Tkg5EuJgTIhIUeawLc802PVtDUhEE/rRV6at6yR5iyNY+LahmdTqYx3I1PFehpim9YmzIoXE1rP5zB7lv16ZJip6n23bQ/Ic+kyXrlWGSrliny3wDm1jZLI1ojlFF5Fs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188590; c=relaxed/simple;
	bh=zgcRHDVO3UcRazzTAHysZG4GG7r3Uc5shJ7cwmtOWPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ga/RUmHW+5hWvl3mg58ovJVQPk3VtPSxzaRpQ9WhotabPbx9PaOUnAj0Oo6JxNTakx0bGzW0cUje175juXSQ/Ref4itvB7RB5WJ/HeHru+g7liPsOg076YovZjeEw7sPIYzTWXLpGJnxvcZpvXqIg+u8e5hEmiTZlsX8nxYyEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCtDrSXj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706188587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+YvQgYm6cd0JHSMYoDmutkMgQpSXysYVuSgvth2yPP8=;
	b=eCtDrSXjKWToErTu9dUhv+E2rS3wly5PMpUc9/MjtXU7l8VHe+HzRYH5l8JhQ5p5JUxnSq
	/O0RqnQL3r8K4AuOUM6StQvrwsagnkYhaBQ9oClJb2TsUpI0c9t+oaQLFlGUFrEusDQcsx
	Lki/Lz6735byFaBGye/73RQ6Ag05BOw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-bwRcF_xROKaRk7pvdZuumg-1; Thu,
 25 Jan 2024 08:16:25 -0500
X-MC-Unique: bwRcF_xROKaRk7pvdZuumg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3904A3C2B606;
	Thu, 25 Jan 2024 13:16:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 034043C2E;
	Thu, 25 Jan 2024 13:16:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.8-rc2
Date: Thu, 25 Jan 2024 14:16:06 +0100
Message-ID: <20240125131606.32850-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hi Linus!

Jakub is doing a lot of work to include the self-tests in our CI,
as a result a significant amount of self-tests related fixes is
flowing in (and will likely continue in the next few weeks).

The following changes since commit 736b5545d39ca59d4332a60e56cc8a1a5e264a8e:

  Merge tag 'net-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-01-18 17:33:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc2

for you to fetch changes up to 0a5bd0ffe790511d802e7f40898429a89e2487df:

  Merge branch 'tsnep-xdp-fixes' (2024-01-25 11:59:44 +0100)

----------------------------------------------------------------
Including fixes from bpf, netfilter and WiFi.

Current release - regressions:

  - bpf: fix a kernel crash for the riscv 64 JIT

  - bnxt_en: fix memory leak in bnxt_hwrm_get_rings()

  - revert "net: macsec: use skb_ensure_writable_head_tail to expand the skb"

Previous releases - regressions:

  - core: fix removing a namespace with conflicting altnames

  - tc/flower: fix chain template offload memory leak

  - tcp:
    - make sure init the accept_queue's spinlocks once
    - fix autocork on CPUs with weak memory model

  - udp: fix busy polling

  - mlx5e:
    - fix out-of-bound read in port timestamping
    - fix peer flow lists corruption

  - iwlwifi: fix a memory corruption

Previous releases - always broken:

  - netfilter:
    - nft_chain_filter: handle NETDEV_UNREGISTER for inet/ingress basechain
    - nft_limit: reject configurations that cause integer overflow

  - bpf: fix bpf_xdp_adjust_tail() with XSK zero-copy mbuf, avoiding
    a NULL pointer dereference upon shrinking

  - llc: make llc_ui_sendmsg() more robust against bonding changes

  - smc: fix illegal rmb_desc access in SMC-D connection dump

  - dpll: fix pin dump crash for rebound module

  - bnxt_en: fix possible crash after creating sw mqprio TCs

  - hv_netvsc: calculate correct ring size when PAGE_SIZE is not 4 Kbytes

Misc:

  - several self-tests fixes for better integration with the netdev CI

  - added several missing modules descriptions

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'net-bpf_xdp_adjust_tail-and-intel-mbuf-fixes'

Arkadiusz Kubalewski (4):
      dpll: fix broken error path in dpll_pin_alloc(..)
      dpll: fix pin dump crash for rebound module
      dpll: fix userspace availability of pins
      dpll: fix register pin with unregistered parent pin

Benjamin Berg (1):
      wifi: ath11k: rely on mac80211 debugfs handling for vif

Benjamin Poirier (1):
      selftests: bonding: Increase timeout to 1200s

Bernd Edlinger (1):
      net: stmmac: Wait a bit for the reset to take effect

Breno Leitao (10):
      net: fill in MODULE_DESCRIPTION()s for 8390
      net: fill in MODULE_DESCRIPTION()s for Broadcom bgmac
      net: fill in MODULE_DESCRIPTION()s for liquidio
      net: fill in MODULE_DESCRIPTION()s for ep93xxx_eth
      net: fill in MODULE_DESCRIPTION()s for nps_enet
      net: fill in MODULE_DESCRIPTION()s for enetc
      net: fill in MODULE_DESCRIPTION()s for fec
      net: fill in MODULE_DESCRIPTION()s for fsl_pq_mdio
      net: fill in MODULE_DESCRIPTION()s for litex
      net: fill in MODULE_DESCRIPTION()s for rvu_mbox

David S. Miller (2):
      Merge branch 'tun-fixes'
      Merge branch 'dpll-fixes'

Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_any_create_groups

Emmanuel Grumbach (1):
      wifi: iwlwifi: fix a memory corruption

Eric Dumazet (2):
      llc: make llc_ui_sendmsg() more robust against bonding changes
      udp: fix busy polling

Felix Fietkau (1):
      wifi: mac80211: fix race condition on enabling fast-xmit

Florian Westphal (3):
      netfilter: nft_limit: reject configurations that cause integer overflow
      netfilter: nf_tables: restrict anonymous set and map names to 16 bytes
      netfilter: nf_tables: reject QUEUE/DROP verdict parameters

George Guo (1):
      netfilter: nf_tables: cleanup documentation

Gerhard Engleder (2):
      tsnep: Remove FCS for XDP data path
      tsnep: Fix XDP_RING_NEED_WAKEUP for empty fill ring

Hangbin Liu (1):
      selftests: bonding: do not test arp/ns target with mode balance-alb/tlb

Horatiu Vultur (1):
      net: micrel: Fix PTP frame parsing for lan8814

Ido Schimmel (1):
      net/sched: flower: Fix chain template offload

Jakub Kicinski (8):
      Merge branch 'bnxt_en-bug-fixes'
      net: fix removing a namespace with conflicting altnames
      Merge tag 'wireless-2024-01-22' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      selftests: fill in some missing configs for net
      selftests: net: fix rps_default_mask with >32 CPUs
      selftests: netdevsim: fix the udp_tunnel_nic test
      Merge branch 'fix-module_description-for-net-p2'
      Merge tag 'nf-24-01-24' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Jenishkumar Maheshbhai Patel (1):
      net: mvpp2: clear BM pool before initialization

Johannes Berg (1):
      wifi: mac80211: fix potential sta-link leak

Kalle Valo (1):
      wifi: p54: fix GCC format truncation warning with wiphy->fw_version

Kuniyuki Iwashima (2):
      llc: Drop support for ETH_P_TR_802_2.
      selftest: Don't reuse port for SO_INCOMING_CPU test.

Leon Romanovsky (2):
      net/mlx5e: Allow software parsing when IPsec crypto is enabled
      net/mlx5e: Ignore IPsec replay window values on sender side

Lin Ma (1):
      vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING

Lukas Bulwahn (1):
      wifi: cfg80211/mac80211: remove dependency on non-existing option

Maciej Fijalkowski (10):
      xsk: recycle buffer in case Rx queue was full
      xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags
      xsk: fix usage of multi-buffer BPF helpers for ZC XDP
      ice: work on pre-XDP prog frag count
      ice: remove redundant xdp_rxq_info registration
      intel: xsk: initialize skb_frag_t::bv_offset in ZC drivers
      ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue
      xdp: reflect tail increase for MEM_TYPE_XSK_BUFF_POOL
      i40e: set xdp_rxq_info::frag_size
      i40e: update xdp_rxq_info::frag_size for ZC enabled Rx queue

Michael Chan (5):
      bnxt_en: Wait for FLR to complete during probe
      bnxt_en: Fix memory leak in bnxt_hwrm_get_rings()
      bnxt_en: Fix RSS table entries calculation for P5_PLUS chips
      bnxt_en: Prevent kernel warning when running offline self test
      bnxt_en: Fix possible crash after creating sw mqprio TCs

Michael Kelley (1):
      hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes

Michal Kazior (1):
      wifi: cfg80211: fix missing interfaces when dumping

Michal Schmidt (1):
      idpf: distinguish vports by the dev_port attribute

Moshe Shemesh (1):
      net/mlx5: Bridge, fix multicast packets sent to uplink

Pablo Neira Ayuso (2):
      netfilter: nft_chain_filter: handle NETDEV_UNREGISTER for inet/ingress basechain
      netfilter: nf_tables: validate NFPROTO_* family

Paolo Abeni (3):
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'mlx5-fixes-2024-01-24' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'tsnep-xdp-fixes'

Pu Lehui (1):
      riscv, bpf: Fix unpredictable kernel crash about RV64 struct_ops

Rahul Rameshbabu (3):
      Revert "net: macsec: use skb_ensure_writable_head_tail to expand the skb"
      net/mlx5e: Fix operation precedence bug in port timestamping napi_poll context
      net/mlx5: Use mlx5 device constant for selecting CQ period mode for ASO

Saeed Mahameed (1):
      net/mlx5e: Use the correct lag ports number when creating TISes

Salvatore Dipietro (1):
      tcp: Add memory barrier to tcp_push()

Sharath Srinivasan (1):
      net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Shenwei Wang (1):
      net: fec: fix the unhandled context fault from smmu

Tariq Toukan (2):
      net/mlx5: Fix query of sd_group field
      net/mlx5e: Fix inconsistent hairpin RQT sizes

Tirthendu Sarkar (1):
      i40e: handle multi-buffer packets that are shrunk by xdp prog

Vlad Buslov (1):
      net/mlx5e: Fix peer flow lists handling

Wen Gu (1):
      net/smc: fix illegal rmb_desc access in SMC-D connection dump

Yevgeny Kliteynik (2):
      net/mlx5: DR, Use the right GVMI number for drop action
      net/mlx5: DR, Can't go to uplink vport on RX rule

Yishai Hadas (1):
      net/mlx5: Fix a WARN upon a callback command failure

Yunjian Wang (2):
      tun: fix missing dropped counter in tun_xdp_act
      tun: add missing rx stats accounting in tun_xdp_act

Zhengchao Shao (3):
      tcp: make sure init the accept_queue's spinlocks once
      netlink: fix potential sleeping issue in mqueue_flush_file
      ipv6: init the accept_queue's spinlocks in inet6_create

Zhipeng Lu (2):
      net/mlx5e: fix a double-free in arfs_create_groups
      fjes: fix memleaks in fjes_hw_setup

 arch/riscv/net/bpf_jit_comp64.c                    |  5 +-
 drivers/dpll/dpll_core.c                           | 68 ++++++++++++++++++----
 drivers/dpll/dpll_core.h                           |  4 +-
 drivers/dpll/dpll_netlink.c                        | 57 +++++++++++++-----
 drivers/net/ethernet/8390/8390.c                   |  1 +
 drivers/net/ethernet/8390/8390p.c                  |  1 +
 drivers/net/ethernet/8390/apne.c                   |  1 +
 drivers/net/ethernet/8390/hydra.c                  |  1 +
 drivers/net/ethernet/8390/stnic.c                  |  1 +
 drivers/net/ethernet/8390/zorro8390.c              |  1 +
 drivers/net/ethernet/broadcom/bcm4908_enet.c       |  1 +
 drivers/net/ethernet/broadcom/bgmac-bcma-mdio.c    |  1 +
 drivers/net/ethernet/broadcom/bgmac-bcma.c         |  1 +
 drivers/net/ethernet/broadcom/bgmac-platform.c     |  1 +
 drivers/net/ethernet/broadcom/bgmac.c              |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 49 +++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c      |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  7 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |  2 +-
 drivers/net/ethernet/cavium/liquidio/lio_core.c    |  1 +
 drivers/net/ethernet/cirrus/ep93xx_eth.c           |  1 +
 drivers/net/ethernet/engleder/tsnep_main.c         | 17 +++++-
 drivers/net/ethernet/ezchip/nps_enet.c             |  1 +
 drivers/net/ethernet/freescale/enetc/enetc.c       |  1 +
 drivers/net/ethernet/freescale/fec_main.c          |  3 +
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 47 ++++++++++-----
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 49 ++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |  4 +-
 drivers/net/ethernet/intel/ice/ice_base.c          | 37 +++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx.c          | 19 +++---
 drivers/net/ethernet/intel/ice/ice_txrx.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h      | 31 +++++++---
 drivers/net/ethernet/intel/ice/ice_xsk.c           |  4 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |  2 +
 drivers/net/ethernet/litex/litex_liteeth.c         |  1 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    | 27 ++++++++-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |  5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  2 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |  1 +
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   | 10 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  | 26 +++++----
 .../net/ethernet/mellanox/mlx5/core/en_common.c    | 21 ++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  5 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge_mcast.c |  3 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |  2 +
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c  |  2 +-
 .../mellanox/mlx5/core/steering/dr_action.c        | 17 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    | 21 +++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  3 +
 drivers/net/fjes/fjes_hw.c                         | 37 +++++++++---
 drivers/net/hyperv/netvsc_drv.c                    |  4 +-
 drivers/net/macsec.c                               | 25 ++++++--
 drivers/net/phy/micrel.c                           | 11 ++++
 drivers/net/tun.c                                  | 10 +++-
 drivers/net/wireless/ath/ath11k/core.h             |  4 --
 drivers/net/wireless/ath/ath11k/debugfs.c          | 25 ++++----
 drivers/net/wireless/ath/ath11k/debugfs.h          | 12 +---
 drivers/net/wireless/ath/ath11k/mac.c              | 12 +---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |  4 +-
 drivers/net/wireless/intersil/p54/fwio.c           |  2 +-
 include/linux/mlx5/driver.h                        |  1 +
 include/linux/mlx5/fs.h                            |  1 +
 include/linux/mlx5/mlx5_ifc.h                      | 12 ++--
 include/linux/mlx5/vport.h                         |  1 +
 include/linux/skmsg.h                              |  6 --
 include/net/inet_connection_sock.h                 |  8 +++
 include/net/inet_sock.h                            |  5 --
 include/net/llc_pdu.h                              |  6 +-
 include/net/netfilter/nf_tables.h                  | 49 ++++++++++++----
 include/net/sch_generic.h                          |  4 ++
 include/net/sock.h                                 | 18 +++++-
 include/net/xdp_sock_drv.h                         | 27 +++++++++
 net/8021q/vlan_netlink.c                           |  4 ++
 net/core/dev.c                                     |  9 +++
 net/core/dev.h                                     |  3 +
 net/core/filter.c                                  | 44 ++++++++++++--
 net/core/request_sock.c                            |  3 -
 net/core/sock.c                                    | 11 +++-
 net/ipv4/af_inet.c                                 |  3 +
 net/ipv4/inet_connection_sock.c                    |  4 ++
 net/ipv4/tcp.c                                     |  1 +
 net/ipv6/af_inet6.c                                |  3 +
 net/llc/af_llc.c                                   | 24 +++++---
 net/llc/llc_core.c                                 |  7 ---
 net/mac80211/Kconfig                               |  1 -
 net/mac80211/sta_info.c                            |  7 ++-
 net/mac80211/tx.c                                  |  2 +-
 net/netfilter/nf_tables_api.c                      | 20 +++----
 net/netfilter/nft_chain_filter.c                   | 11 +++-
 net/netfilter/nft_compat.c                         | 12 ++++
 net/netfilter/nft_flow_offload.c                   |  5 ++
 net/netfilter/nft_limit.c                          | 23 +++++---
 net/netfilter/nft_nat.c                            |  5 ++
 net/netfilter/nft_rt.c                             |  5 ++
 net/netfilter/nft_socket.c                         |  5 ++
 net/netfilter/nft_synproxy.c                       |  7 ++-
 net/netfilter/nft_tproxy.c                         |  5 ++
 net/netfilter/nft_xfrm.c                           |  5 ++
 net/netlink/af_netlink.c                           |  2 +-
 net/rds/af_rds.c                                   |  2 +-
 net/sched/cls_api.c                                |  9 ++-
 net/sched/cls_flower.c                             | 23 ++++++++
 net/smc/smc_diag.c                                 |  2 +-
 net/wireless/Kconfig                               |  1 -
 net/wireless/nl80211.c                             |  1 +
 net/xdp/xsk.c                                      | 12 ++--
 net/xdp/xsk_buff_pool.c                            |  1 +
 .../selftests/drivers/net/bonding/bond_options.sh  |  8 +--
 .../testing/selftests/drivers/net/bonding/settings |  2 +-
 .../drivers/net/netdevsim/udp_tunnel_nic.sh        |  9 +++
 tools/testing/selftests/net/config                 | 28 +++++++++
 tools/testing/selftests/net/rps_default_mask.sh    |  6 +-
 tools/testing/selftests/net/so_incoming_cpu.c      | 68 ++++++++++++++++------
 120 files changed, 928 insertions(+), 341 deletions(-)


