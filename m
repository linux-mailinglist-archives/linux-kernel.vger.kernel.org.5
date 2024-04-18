Return-Path: <linux-kernel+bounces-150631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C38AA211
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABBBFB20D91
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD5D16F913;
	Thu, 18 Apr 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfsROpqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA91EA74;
	Thu, 18 Apr 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465103; cv=none; b=uvz+iW3VS+Cahgc0q+H7h0DS730w0DRlOdtuRngr4gLUMWZOacsGl5TiIDjVdT7eNaK898RG1odI3CL9CW3dhKssLYl3Wz814GTXeXLSJq/GZSkwOtAcUV2Szi0sIWTj6UyYG8qZMBocfLw1RKGLnS8MuHNy1fJI4raeDn/Ba7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465103; c=relaxed/simple;
	bh=EcMudFT3vkPfA3FBxceS1cyQN3IzyJLJcVCJUgm0+yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J0o7NZJQm4i6YNIedyeiYYqUvLfRrrxLmjP8t9dQxyqX7m5g7UJJ7frul4WEZ8PO8GDNXWTJ62MDssYR8sMuHsE6DIRbjCYo/F5BoBSlZ/+3stDkfGm/RPX6LRkF09/aNZL/fkFF0VRwH4bT2CMU6UpNUXP6yNvdmiTbgx1ok0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfsROpqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04B9C113CC;
	Thu, 18 Apr 2024 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713465103;
	bh=EcMudFT3vkPfA3FBxceS1cyQN3IzyJLJcVCJUgm0+yw=;
	h=From:To:Cc:Subject:Date:From;
	b=HfsROpqHtvbOQEpN3Zdm4Y2EMojdJH9GKd+s2bTwb8tG29m67lhoGn+XWcC91ks8f
	 g5EjALvYB/ZOy/sOkusO7BxZ/8Geul58vHV0DrCBlfwcb6ZA2cqP2MYDq5YjPDHN6F
	 U1H/uUKw+F1HImXnxCygzc5SVPrSAx6dIj3+o7V1EaYMmkESvM/hwRswIPttj64uoq
	 pArJp4K7CZEoZrpHIMGX7cc0FQUtZn3Du1ThRmxWFgFEVP2aOlNvD5PRktgHR9p+Ra
	 WRWjkfGH9klNWUIijMByfc3Zpo1LebV4M0Qww1uUUE3PVFLNe+gTe+vJGZYu2oWSs+
	 xIhRZwp/1Rqdw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.9-rc5
Date: Thu, 18 Apr 2024 11:31:42 -0700
Message-ID: <20240418183142.3569793-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit 2ae9a8972ce04046957f8af214509cebfd3bfb9c:

  Merge tag 'net-6.9-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-04-11 11:46:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc5

for you to fetch changes up to c24cd679b075b0e953ea167b0aa2b2d59e4eba7f:

  net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using them (2024-04-18 09:57:03 -0700)

----------------------------------------------------------------
A little calmer than usual, probably just the timing of sub-tree PRs.

Including fixes from netfilter.

Current release - regressions:

 - inet: bring NLM_DONE out to a separate recv() again, fix user space
   which assumes multiple recv()s will happen and gets blocked forever

 - drv: mlx5:
  - restore mistakenly dropped parts in register devlink flow
  - use channel mdev reference instead of global mdev instance
    for coalescing
  - acquire RTNL lock before RQs/SQs activation/deactivation

Previous releases - regressions:

 - net: change maximum number of UDP segments to 128, fix virtio
   compatibility with Windows peers

 - usb: ax88179_178a: avoid writing the mac address before first reading

Previous releases - always broken:

 - sched: fix mirred deadlock on device recursion

 - netfilter:
   - br_netfilter: skip conntrack input hook for promisc packets
   - fixes removal of duplicate elements in the pipapo set backend
   - various fixes for abort paths and error handling

 - af_unix: don't peek OOB data without MSG_OOB

 - drv: flower: fix fragment flags handling in multiple drivers

 - drv: ravb: fix jumbo frames and packet stats accounting

Misc:

 - kselftest_harness: fix Clang warning about zero-length format

 - tun: limit printing rate when illegal packet received by tun dev

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Arınç ÜNAL (2):
      net: dsa: mt7530: fix mirroring frames received on local port
      net: dsa: mt7530: fix port mirroring for MT7988 SoC switch

Asbjørn Sloth Tønnesen (2):
      net: sparx5: flower: fix fragment flags handling
      octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation

Carolina Jubran (2):
      net/mlx5e: Acquire RTNL lock before RQs/SQs activation/deactivation
      net/mlx5e: Prevent deadlock while disabling aRFS

David S. Miller (2):
      Merge tag 'nf-24-04-11' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'mt7530-fixes'

Dmitry Safonov (4):
      selftests/tcp_ao: Make RST tests less flaky
      selftests/tcp_ao: Zero-init tcp_ao_info_opt
      selftests/tcp_ao: Fix fscanf() call for format-security
      selftests/tcp_ao: Printing fixes to confirm with format-security

Eric Dumazet (1):
      net/sched: Fix mirred deadlock on device recursion

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: fix WED + wifi reset

Florian Westphal (1):
      netfilter: nft_set_pipapo: do not free live element

Gerd Bayer (1):
      s390/ism: Properly fix receive message buffer allocation

Jakub Kicinski (5):
      Merge branch 'af_unix-fix-msg_oob-bugs-with-msg_peek'
      Merge branch 'mlx5-fixes'
      inet: bring NLM_DONE out to a separate recv() again
      selftests: kselftest_harness: fix Clang warning about zero-length format
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid writing the mac address before first reading

Kuniyuki Iwashima (2):
      af_unix: Call manage_oob() for every skb in unix_stream_read_generic().
      af_unix: Don't peek OOB data without MSG_OOB.

Lei Chen (1):
      tun: limit printing rate when illegal packet received by tun dev

Marcin Szycik (1):
      ice: Fix checking for unsupported keys on non-tunnel device

Michal Swiatkowski (2):
      ice: tc: check src_vsi in case of traffic from VF
      ice: tc: allow zero flags in parsing tc flower

Pablo Neira Ayuso (7):
      netfilter: br_netfilter: skip conntrack input hook for promisc packets
      netfilter: nft_set_pipapo: walk over current view on netlink dump
      netfilter: flowtable: validate pppoe header
      netfilter: flowtable: incorrect pppoe tuple
      netfilter: nf_tables: missing iterator type in lookup walk
      netfilter: nf_tables: restore set elements when delete set fails
      netfilter: nf_tables: fix memleak in map from abort path

Paolo Abeni (4):
      Merge branch 'selftests-net-tcp_ao-a-bunch-of-fixes-for-tcp-ao-selftests'
      Merge branch 'net-stmmac-fix-mac-capabilities-procedure'
      Merge branch 'ravb-ethernet-driver-bugfixes'
      Merge tag 'nf-24-04-18' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Paul Barker (4):
      net: ravb: Count packets instead of descriptors in R-Car RX path
      net: ravb: Allow RX loop to move past DMA mapping errors
      net: ravb: Fix GbEth jumbo packet RX checksum handling
      net: ravb: Fix RX byte accounting for jumbo packets

Rahul Rameshbabu (1):
      net/mlx5e: Use channel mdev reference instead of global mdev instance for coalescing

Serge Semin (3):
      net: stmmac: Apply half-duplex-less constraint for DW QoS Eth only
      net: stmmac: Fix max-speed being ignored on queue re-init
      net: stmmac: Fix IP-cores specific MAC capabilities

Shay Drory (2):
      net/mlx5: Lag, restore buckets number to default after hash LAG deactivation
      net/mlx5: Restore mistakenly dropped parts in register devlink flow

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using them

Tariq Toukan (1):
      net/mlx5: SD, Handle possible devcom ERR_PTR

Vanillan Wang (1):
      net:usb:qmi_wwan: support Rolling modules

Yuri Benditovich (1):
      net: change maximum number of UDP segments to 128

Ziyang Xuan (2):
      netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()
      netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()

 drivers/net/dsa/mt7530.c                           | 16 +++--
 drivers/net/dsa/mt7530.h                           |  4 ++
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        | 15 +++-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |  7 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |  6 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |  7 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  | 27 ++++---
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  4 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  7 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |  1 -
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   | 61 ++++++++++------
 drivers/net/ethernet/renesas/ravb_main.c           | 68 +++++++++---------
 drivers/net/ethernet/stmicro/stmmac/common.h       |  1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  2 +
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |  2 +
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  7 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    | 18 +++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 29 +++-----
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           | 18 +++++
 drivers/net/tun.c                                  | 18 ++---
 drivers/net/usb/ax88179_178a.c                     |  4 +-
 drivers/net/usb/qmi_wwan.c                         |  1 +
 drivers/s390/net/ism_drv.c                         | 37 +++++++---
 include/linux/udp.h                                |  2 +-
 include/net/netfilter/nf_flow_table.h              | 12 +++-
 include/net/netfilter/nf_tables.h                  | 14 ++++
 include/net/sch_generic.h                          |  1 +
 net/bridge/br_input.c                              | 15 ++--
 net/bridge/br_netfilter_hooks.c                    |  6 ++
 net/bridge/br_private.h                            |  1 +
 net/bridge/netfilter/nf_conntrack_bridge.c         | 14 ++--
 net/core/dev.c                                     |  6 ++
 net/ipv4/fib_frontend.c                            |  5 ++
 net/netfilter/nf_flow_table_inet.c                 |  3 +-
 net/netfilter/nf_flow_table_ip.c                   | 10 +--
 net/netfilter/nf_tables_api.c                      | 82 +++++++++++++++++++---
 net/netfilter/nft_lookup.c                         |  1 +
 net/netfilter/nft_set_bitmap.c                     |  4 +-
 net/netfilter/nft_set_hash.c                       |  8 +--
 net/netfilter/nft_set_pipapo.c                     | 25 ++++---
 net/netfilter/nft_set_rbtree.c                     |  4 +-
 net/sched/sch_generic.c                            |  1 +
 net/unix/af_unix.c                                 | 12 ++--
 tools/testing/selftests/kselftest.h                | 10 +--
 tools/testing/selftests/kselftest_harness.h        |  2 +-
 tools/testing/selftests/net/tcp_ao/lib/proc.c      |  2 +-
 tools/testing/selftests/net/tcp_ao/lib/setup.c     | 12 ++--
 tools/testing/selftests/net/tcp_ao/rst.c           | 23 +++---
 .../selftests/net/tcp_ao/setsockopt-closed.c       |  2 +-
 tools/testing/selftests/net/udpgso.c               |  2 +-
 56 files changed, 438 insertions(+), 219 deletions(-)

