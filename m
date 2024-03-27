Return-Path: <linux-kernel+bounces-121510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ED288E98D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A5DB35192
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA188139D0D;
	Wed, 27 Mar 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlJtizVA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA04137C4F;
	Wed, 27 Mar 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553091; cv=none; b=K8Gc/kVqRs9Px7baYYfHaKkPAJjr4r2RahISoMA/fqnQSQn3xD/TvS0dPlez2faSUeEOl4KF3/C2HNlfeb5HsruWP1no5PlzYHfbG4aPZpXivG9j9EO72A+I1uT7OYz1NS4fsVjmJW8bHtvf6Yk2jdvVzqYcSU7FUETJvqaMqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553091; c=relaxed/simple;
	bh=YuLkF9Z+FIw9qgWIRQbpESpKngwjwTeo7VxYdY1Lr8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSmrzV3r1cZwTLxDltpdiO6aqSj2NA7WS8qB87liGr8QA3GTlCsQQvY/SZ4NEpeLJz1mtduWTYHVVhPNpkPzm8pRw+/HUEC+dlUB5ygEIN3eusOaW0GtfBG1f9qYBJrS6ummW043wb90ojlg0KPKfer8tOdf61eF8X13hAugdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlJtizVA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553089; x=1743089089;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YuLkF9Z+FIw9qgWIRQbpESpKngwjwTeo7VxYdY1Lr8g=;
  b=LlJtizVAsDsK76F3KH7oMC5wF11FIGWWMx9wG8UgbTcQHkg+F24oBY8J
   ClccXcRLK+Fm9yqWPEAUgSada3A3A2GYViyC1rrm3kfpc7F/ZmjaLc4lt
   +F2vQb2oMYDnhBbmw1QEQd7l9akS27dI9fylDEmedusl4gDo4Hcdfc3xc
   cofmTgeBrGvPSZePMVZ9XKOGtYvAMXyeZsDaEW1qUEd1PO+7UtMZKYMwF
   hLX8EMPKP6w3/D62xoNGhFl07fJW3dOKPOzup1UmE8GfAcG81kks4TniU
   p9kXj0urGjuQDjK59sepP00Dxg60aIyDFakyo1Fvlhmx0BQQ5Ew3844OE
   Q==;
X-CSE-ConnectionGUID: WvLz6PJyQgiPBGdhvxU45w==
X-CSE-MsgGUID: HTiGmH87Sl+Sk3r5WBGSfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518071"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518071"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414049"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:24:34 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 00/21] ice: add PFCP filter support
Date: Wed, 27 Mar 2024 16:23:37 +0100
Message-ID: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for creating PFCP filters in switchdev mode. Add pfcp module
that allows to create a PFCP-type netdev. The netdev then can be passed to
tc when creating a filter to indicate that PFCP filter should be created.

To add a PFCP filter, a special netdev must be created and passed to tc
command:

  ip link add pfcp0 type pfcp
  tc filter add dev eth0 ingress prio 1 flower pfcp_opts \
    1:12ab/ff:fffffffffffffff0 skip_hw action mirred egress redirect \
    dev pfcp0

Changes in iproute2 [1] are required to use pfcp_opts in tc.

ICE COMMS package is required as it contains PFCP profiles.

Part of this patchset modifies IP_TUNNEL_*_OPTs, which were previously
stored in a __be16. All possible values have already been used, making
it impossible to add new ones.

* 1-3: add new bitmap_{read,write}(), which is used later in the IP
       tunnel flags code (from Alexander's ARM64 MTE series[2]);
* 4-14: some bitmap code preparations also used later in IP tunnels;
* 15-17: convert IP tunnel flags from __be16 to a bitmap;
* 18-21: add PFCP module and support for it in ice.

[1] https://lore.kernel.org/netdev/20230614091758.11180-1-marcin.szycik@linux.intel.com
[2] https://lore.kernel.org/linux-kernel/20231218124033.551770-1-glider@google.com

Alexander Lobakin (14):
  bitops: add missing prototype check
  bitops: make BYTES_TO_BITS() treewide-available
  bitops: let the compiler optimize {__,}assign_bit()
  linkmode: convert linkmode_{test,set,clear,mod}_bit() to macros
  s390/cio: rename bitmap_size() -> idset_bitmap_size()
  fs/ntfs3: add prefix to bitmap_size() and use BITS_TO_U64()
  btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
  tools: move alignment-related macros to new <linux/align.h>
  bitmap: introduce generic optimized bitmap_size()
  bitmap: make bitmap_{get,set}_value8() use bitmap_{read,write}()
  lib/bitmap: add compile-time test for __assign_bit() optimization
  ip_tunnel: use a separate struct to store tunnel params in the kernel
  ip_tunnel: convert __be16 tunnel flags to bitmaps
  net: net_test: add tests for IP tunnel flags conversion helpers

Alexander Potapenko (2):
  lib/test_bitmap: add tests for bitmap_{read,write}()
  lib/test_bitmap: use pr_info() for non-error messages

Marcin Szycik (2):
  ice: refactor ICE_TC_FLWR_FIELD_ENC_OPTS
  ice: Add support for PFCP hardware offload in switchdev

Michal Swiatkowski (1):
  pfcp: always set pfcp metadata

Syed Nayyar Waris (1):
  lib/bitmap: add bitmap_{read,write}()

Wojciech Drewek (1):
  pfcp: add PFCP module

 drivers/net/Kconfig                           |  13 +
 drivers/net/Makefile                          |   1 +
 net/core/Makefile                             |   2 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |   4 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |  12 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |   8 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun.h   |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_ipip.h   |   2 +-
 fs/ntfs3/ntfs_fs.h                            |   4 +-
 include/linux/bitmap.h                        |  95 ++++--
 include/linux/bitops.h                        |  23 +-
 include/linux/cpumask.h                       |   2 +-
 include/linux/linkmode.h                      |  27 +-
 include/linux/netdevice.h                     |   7 +-
 include/net/dst_metadata.h                    |  10 +-
 include/net/flow_dissector.h                  |   2 +-
 include/net/gre.h                             |  70 ++--
 include/net/ip6_tunnel.h                      |   4 +-
 include/net/ip_tunnels.h                      | 139 ++++++--
 include/net/pfcp.h                            |  90 ++++++
 include/net/udp_tunnel.h                      |   4 +-
 include/uapi/linux/if_tunnel.h                |  36 +++
 include/uapi/linux/pkt_cls.h                  |  14 +
 tools/include/linux/align.h                   |  12 +
 tools/include/linux/bitmap.h                  |   9 +-
 tools/include/linux/bitops.h                  |   2 +
 tools/include/linux/mm.h                      |   5 +-
 drivers/md/dm-clone-metadata.c                |   5 -
 drivers/net/bareudp.c                         |  19 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   9 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |  85 +++++
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  68 +++-
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |   6 +-
 .../mellanox/mlx5/core/en/tc_tun_geneve.c     |  12 +-
 .../mellanox/mlx5/core/en/tc_tun_gre.c        |   8 +-
 .../mellanox/mlx5/core/en/tc_tun_vxlan.c      |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  16 +-
 .../ethernet/mellanox/mlxsw/spectrum_ipip.c   |  56 ++--
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |  10 +-
 .../ethernet/netronome/nfp/flower/action.c    |  27 +-
 drivers/net/geneve.c                          |  44 ++-
 drivers/net/pfcp.c                            | 302 ++++++++++++++++++
 drivers/net/vxlan/vxlan_core.c                |  14 +-
 drivers/s390/cio/idset.c                      |  12 +-
 fs/btrfs/free-space-cache.c                   |   8 +-
 fs/ntfs3/bitmap.c                             |   4 +-
 fs/ntfs3/fsntfs.c                             |   2 +-
 fs/ntfs3/index.c                              |  11 +-
 fs/ntfs3/super.c                              |   2 +-
 kernel/trace/trace_probe.c                    |   2 -
 lib/math/prime_numbers.c                      |   2 -
 lib/test_bitmap.c                             | 203 ++++++++++--
 net/bridge/br_vlan_tunnel.c                   |   9 +-
 net/core/filter.c                             |  26 +-
 net/core/flow_dissector.c                     |  20 +-
 net/core/{gso_test.c => net_test.c}           | 129 +++++++-
 net/ipv4/fou_bpf.c                            |   2 +-
 net/ipv4/gre_demux.c                          |   2 +-
 net/ipv4/ip_gre.c                             | 144 +++++----
 net/ipv4/ip_tunnel.c                          | 109 +++++--
 net/ipv4/ip_tunnel_core.c                     |  82 +++--
 net/ipv4/ip_vti.c                             |  41 ++-
 net/ipv4/ipip.c                               |  33 +-
 net/ipv4/ipmr.c                               |   2 +-
 net/ipv4/udp_tunnel_core.c                    |   5 +-
 net/ipv6/addrconf.c                           |   3 +-
 net/ipv6/ip6_gre.c                            |  85 ++---
 net/ipv6/ip6_tunnel.c                         |  14 +-
 net/ipv6/sit.c                                |  38 ++-
 net/netfilter/ipvs/ip_vs_core.c               |   6 +-
 net/netfilter/ipvs/ip_vs_xmit.c               |  20 +-
 net/netfilter/nft_tunnel.c                    |  44 +--
 net/openvswitch/flow_netlink.c                |  61 ++--
 net/psample/psample.c                         |  26 +-
 net/sched/act_tunnel_key.c                    |  36 +--
 net/sched/cls_flower.c                        | 134 +++++++-
 tools/perf/util/probe-finder.c                |   4 +-
 78 files changed, 1988 insertions(+), 624 deletions(-)
 create mode 100644 include/net/pfcp.h
 create mode 100644 tools/include/linux/align.h
 create mode 100644 drivers/net/pfcp.c
 rename net/core/{gso_test.c => net_test.c} (67%)

---
From v5[3]:
* 6.9-rc1;
* move IP tunnel flags KUnit test from the bitmap test suite to the
  networking KUnit (CONFIG_NET_TEST) (Yury);
* pick tags (Yury, Peter); now the entire series is fully tagged
  (except the above tests);
* no functional changes besides the tests.

From v4[4]:
* rebase on top of 6.8-rc1;
* collect all the dependencies together in one series (did I get it
  right? :s);
* no functional changes.

[3] https://lore.kernel.org/netdev/20240201122216.2634007-1-aleksander.lobakin@intel.com
[4] https://lore.kernel.org/netdev/20231207164911.14330-1-marcin.szycik@linux.intel.com

v3: https://lore.kernel.org/intel-wired-lan/20230721071532.613888-1-marcin.szycik@linux.intel.com
v2: https://lore.kernel.org/intel-wired-lan/20230607112606.15899-1-marcin.szycik@linux.intel.com
v1: https://lore.kernel.org/intel-wired-lan/20230601131929.294667-1-marcin.szycik@linux.intel.com
-- 
2.44.0


