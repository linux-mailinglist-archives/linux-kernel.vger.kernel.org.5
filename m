Return-Path: <linux-kernel+bounces-95571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD87874F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41180281766
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886512BF3B;
	Thu,  7 Mar 2024 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iovziMpu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436FD12BEAE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816831; cv=none; b=ghRDzB0KZ1qSaJsZJJc6Vs5KtNcy3BmEp3v7oKiebTXIWKLkx8lXH6aQTg91iDLISBc28hmEWL6z3H3Zf0crowb2+5OpyVHxhyQIX8ipp9zMAPMWkdXuWBMZhs4ET5UFy0LjPFS9Q6TE8wdb2voykGGtj3i57T77LGuOfC3v1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816831; c=relaxed/simple;
	bh=+LUuu36Z34xDrulMOQ+hr91HzNBbeak+SXbHPo9qVU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cpK+2XS7QEXFwEnKYVPvOiS4wpI/gnXNxQqNCfh5hSgnA1gPUtGw+tQTs3kMB9mBD2tgWbaKjVvzbK6LGXBxiogLqlqdbBSbOQqdyhG0rnzt7QHq3ppiP/qHQNeoZyegVNSnUxbT0XmcEYV6egi0kkc7BOIKyo0n44+9Oj1Xmzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iovziMpu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709816828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n5fFrgxhp5E1QdCyPLQMUKbWKbxspjyuUmflgj9zOxk=;
	b=iovziMpuuGNhp4dwUfl2d4b2q7UbnbWdUn6LP/raa6p5JFsiW0FbbmME/ZTbUmSR16KQCv
	stx1/sUFn3PrQvxFMLI7iKYymay4MMGCJx3dTH11NSxt2jjsPOto9WybOoJQCEEiXs/s6d
	mtyQuAkbNweirUTYUpeWd4qw/mI9bls=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-0V1YElWqO-yQ91DE3Ny5fw-1; Thu, 07 Mar 2024 08:07:04 -0500
X-MC-Unique: 0V1YElWqO-yQ91DE3Ny5fw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 698758007B5;
	Thu,  7 Mar 2024 13:07:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.155])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3457017AA6;
	Thu,  7 Mar 2024 13:07:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.8-rc8
Date: Thu,  7 Mar 2024 14:06:04 +0100
Message-ID: <20240307130604.485199-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi Linus!

The following changes since commit 87adedeba51a822533649b143232418b9e26d08b:

  Merge tag 'net-6.8-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-02-29 12:40:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc8

for you to fetch changes up to ba18deddd6d502da71fd6b6143c53042271b82bd:

  net: pds_core: Fix possible double free in error handling path (2024-03-07 12:03:19 +0100)

----------------------------------------------------------------
Including fixes from bpf, ipsec and netfilter.

No solution yet for the stmmac issue mentioned in the last PR,
but it proved to be a lockdep false positive, not a blocker.

Current release - regressions:

  - dpll: move all dpll<>netdev helpers to dpll code, fix build
    regression with old compilers

Current release - new code bugs:

  - page_pool: fix netlink dump stop/resume

Previous releases - regressions:

  - bpf: fix verifier to check bpf_func_state->callback_depth when pruning
       states as otherwise unsafe programs could get accepted

  - ipv6: avoid possible UAF in ip6_route_mpath_notify()

  - ice: reconfig host after changing MSI-X on VF

  - mlx5:
    - e-switch, change flow rule destination checking
    - add a memory barrier to prevent a possible null-ptr-deref
    - switch to using _bh variant of of spinlock where needed

Previous releases - always broken:

  - netfilter: nf_conntrack_h323: add protection for bmp length out of range

  - bpf: fix to zero-initialise xdp_rxq_info struct before running XDP
	program in CPU map which led to random xdp_md fields

  - xfrm: fix UDP encapsulation in TX packet offload

  - netrom: fix data-races around sysctls

  - ice:
    - fix potential NULL pointer dereference in ice_bridge_setlink()
    - fix uninitialized dplls mutex usage

  - igc: avoid returning frame twice in XDP_REDIRECT

  - i40e: disable NAPI right after disabling irqs when handling xsk_pool

  - geneve: make sure to pull inner header in geneve_rx()

  - sparx5: fix use after free inside sparx5_del_mact_entry

  - dsa: microchip: fix register write order in ksz8_ind_write8()

Misc:

  -  selftests: mptcp: fixes for diag.sh

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexei Starovoitov (1):
      Merge branch 'check-bpf_func_state-callback_depth-when-pruning-states'

Arnd Bergmann (1):
      net: bql: fix building with BQL disabled

Aya Levin (1):
      net/mlx5: Fix fw reporter diagnose output

Daniel Borkmann (2):
      xdp, bonding: Fix feature flags when there are no slave devs anymore
      selftests/bpf: Fix up xdp bonding test wrt feature flags

David S. Miller (2):
      Merge branch 'mptcp-test-fixes'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Eduard Zingerman (2):
      bpf: check bpf_func_state->callback_depth when pruning states
      selftests/bpf: test case for callback_depth states pruning logic

Edward Adam Davis (1):
      net/rds: fix WARNING in rds_conn_connect_if_down

Emeel Hakim (1):
      net/mlx5e: Fix MACsec state loss upon state update in offload path

Emil Tantilov (1):
      idpf: disable local BH when scheduling napi for marker packets

Eric Dumazet (2):
      geneve: make sure to pull inner header in geneve_rx()
      net/ipv6: avoid possible UAF in ip6_route_mpath_notify()

Florian Kauer (1):
      igc: avoid returning frame twice in XDP_REDIRECT

Florian Westphal (1):
      netfilter: nft_ct: fix l3num expectations with inet pseudo family

Gavin Li (1):
      Revert "net/mlx5: Block entering switchdev mode with ns inconsistency"

Geliang Tang (1):
      selftests: mptcp: diag: return KSFT_FAIL not test_cnt

Guillaume Nault (1):
      xfrm: Clear low order bits of ->flowi4_tos in decode_session4().

Horatiu Vultur (1):
      net: sparx5: Fix use after free inside sparx5_del_mact_entry

Ivan Vecera (1):
      i40e: Fix firmware version comparison function

Jacob Keller (1):
      ice: virtchnl: stop pretending to support RSS over AQ or registers

Jakub Kicinski (6):
      page_pool: fix netlink dump stop/resume
      Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'mlx5-fixes-2024-03-01' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      dpll: move all dpll<>netdev helpers to dpll code
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'ipsec-2024-03-06' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec

Jason Xing (12):
      netrom: Fix a data-race around sysctl_netrom_default_path_quality
      netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser
      netrom: Fix data-races around sysctl_netrom_network_ttl_initialiser
      netrom: Fix a data-race around sysctl_netrom_transport_timeout
      netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries
      netrom: Fix a data-race around sysctl_netrom_transport_acknowledge_delay
      netrom: Fix a data-race around sysctl_netrom_transport_busy_delay
      netrom: Fix a data-race around sysctl_netrom_transport_requested_window_size
      netrom: Fix a data-race around sysctl_netrom_transport_no_activity_timeout
      netrom: Fix a data-race around sysctl_netrom_routing_control
      netrom: Fix a data-race around sysctl_netrom_link_fails_count
      netrom: Fix data-races around sysctl_net_busy_read

Jesse Brandeburg (1):
      ice: fix typo in assignment

Jianbo Liu (2):
      net/mlx5: E-switch, Change flow rule destination checking
      net/mlx5e: Change the warning when ignore_flow_level is not supported

Lena Wang (1):
      netfilter: nf_conntrack_h323: Add protection for bmp length out of range

Leon Romanovsky (1):
      xfrm: Pass UDP encapsulation in TX packet offload

Maciej Fijalkowski (3):
      ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able
      i40e: disable NAPI right after disabling irqs when handling xsk_pool
      ice: reorder disabling IRQ and NAPI in ice_qp_dis

Masahisa Kojima (1):
      MAINTAINERS: net: netsec: add myself as co-maintainer

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: diag: avoid extra waiting

Michal Schmidt (1):
      ice: fix uninitialized dplls mutex usage

Michal Swiatkowski (1):
      ice: reconfig host after changing MSI-X on VF

Mike Yu (2):
      xfrm: fix xfrm child route lookup for packet offload
      xfrm: set skb control buffer based on packet offload as well

Moshe Shemesh (1):
      net/mlx5: Check capability for fw_reset

Nathan Chancellor (1):
      xfrm: Avoid clang fortify warning in copy_to_user_tmpl()

Niklas Söderlund (1):
      dt-bindings: net: renesas,ethertsn: Document default for delays

Oleksij Rempel (1):
      net: lan78xx: fix runtime PM count underflow on link stop

Pablo Neira Ayuso (3):
      netfilter: nf_tables: disallow anonymous set with timeout flag
      netfilter: nf_tables: reject constant set with timeout
      netfilter: nf_tables: mark set as dead when unbinding anonymous set with timeout

Paolo Abeni (2):
      Merge branch 'netrom-fix-all-the-data-races-around-sysctls'
      Merge tag 'nf-24-03-07' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Rahul Rameshbabu (2):
      net/mlx5e: Use a memory barrier to enforce PTP WQ xmit submission tracking occurs after populating the metadata_map
      net/mlx5e: Switch to using _bh variant of of spinlock API in port timestamping NAPI poll context

Rand Deeb (1):
      net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()

Saeed Mahameed (1):
      Revert "net/mlx5e: Check the number of elements before walk TC rhashtable"

Sasha Neftin (1):
      intel: legacy: Partial revert of field get conversion

Steffen Klassert (1):
      Merge branch 'Improve packet offload for dual stack'

Steven Rostedt (Google) (1):
      tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string

Tobias Jakobi (Compleo) (1):
      net: dsa: microchip: fix register write order in ksz8_ind_write8()

Toke Høiland-Jørgensen (1):
      cpumap: Zero-initialise xdp_rxq_info struct before running XDP program

Yongzhi Liu (1):
      net: pds_core: Fix possible double free in error handling path

 .../devicetree/bindings/net/renesas,ethertsn.yaml  |  2 +
 Documentation/driver-api/dpll.rst                  |  2 +-
 MAINTAINERS                                        |  2 +-
 drivers/dpll/dpll_core.c                           | 25 +++++--
 drivers/dpll/dpll_netlink.c                        | 38 ++++++----
 drivers/net/bonding/bond_main.c                    |  2 +-
 drivers/net/dsa/microchip/ksz8795.c                |  4 +-
 drivers/net/ethernet/amd/pds_core/auxbus.c         | 12 ++--
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  3 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |  6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  2 +
 drivers/net/ethernet/intel/ice/ice_sriov.c         | 11 ++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |  9 +--
 .../ethernet/intel/ice/ice_virtchnl_allowlist.c    |  2 -
 drivers/net/ethernet/intel/ice/ice_xsk.c           |  9 +--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  2 +
 drivers/net/ethernet/intel/igc/igc_main.c          | 13 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 56 +++++++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |  6 ++
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   | 12 ++--
 .../ethernet/mellanox/mlx5/core/en/tc/post_act.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  | 82 ++++++++++++++--------
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  2 +
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c |  2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 46 ++++--------
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 22 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |  2 +-
 .../ethernet/microchip/sparx5/sparx5_mactable.c    |  4 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  2 +-
 drivers/net/geneve.c                               | 18 ++++-
 drivers/net/usb/lan78xx.c                          |  3 +-
 include/linux/dpll.h                               | 26 +++----
 include/linux/mlx5/mlx5_ifc.h                      |  4 +-
 include/linux/netdevice.h                          | 14 ++--
 include/net/sch_generic.h                          |  7 +-
 include/trace/events/qdisc.h                       | 20 +++---
 kernel/bpf/cpumap.c                                |  2 +-
 kernel/bpf/verifier.c                              |  3 +
 net/core/dev.c                                     | 22 ------
 net/core/page_pool_user.c                          |  3 +-
 net/core/rtnetlink.c                               |  4 +-
 net/ipv6/route.c                                   | 21 ++----
 net/netfilter/nf_conntrack_h323_asn1.c             |  4 ++
 net/netfilter/nf_tables_api.c                      |  7 ++
 net/netfilter/nft_ct.c                             | 11 ++-
 net/netrom/af_netrom.c                             | 14 ++--
 net/netrom/nr_dev.c                                |  2 +-
 net/netrom/nr_in.c                                 |  6 +-
 net/netrom/nr_out.c                                |  2 +-
 net/netrom/nr_route.c                              |  8 +--
 net/netrom/nr_subr.c                               |  5 +-
 net/rds/rdma.c                                     |  3 +
 net/rds/send.c                                     |  6 +-
 net/xfrm/xfrm_device.c                             |  2 +-
 net/xfrm/xfrm_output.c                             |  6 +-
 net/xfrm/xfrm_policy.c                             |  6 +-
 net/xfrm/xfrm_user.c                               |  3 +
 .../testing/selftests/bpf/prog_tests/xdp_bonding.c |  4 +-
 .../bpf/progs/verifier_iterating_callbacks.c       | 70 ++++++++++++++++++
 tools/testing/selftests/net/mptcp/diag.sh          | 15 ++--
 64 files changed, 443 insertions(+), 270 deletions(-)


