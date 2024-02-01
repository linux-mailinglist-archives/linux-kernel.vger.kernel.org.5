Return-Path: <linux-kernel+bounces-48701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F5845FEF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA7D28F93E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB71364D5;
	Thu,  1 Feb 2024 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbuAEGMx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093FC12FB08;
	Thu,  1 Feb 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812248; cv=none; b=GE3iPptPzfWOTqVRyQacCY16WmZUJZEJ91haVkIaMRyAGZBBZAU8uUy/ulZ0PXZOTCg2w5x0wNcaU63bBZVYdV8Y1vT8AFBWJ4g8O2ckVJn8d62hkpQ1YdqDDt0VPLN4XaIpAKH7TtU/MfeAiV/eevl8mWfxRyTK5AQo6X5fQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812248; c=relaxed/simple;
	bh=mZxyWFmtWxbEdMtWbAoc3TtrLI2reIByblxLtgLFwbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ILAiM+1wrIt0Yr+4ye1s8x2vknzYZsqjZAMPWdinR+QxSSnVe+7P9pkf2TmDBAI57p5yyEwd1WcltDs5lGCYyyy9OdzLNV2FcimJx4lyVzl50S27FVXa2M3dZOU2m+efCTKzewnZnBWFoeQFvgWLcd/4udQXOV33t7gd9SBDpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbuAEGMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BACC433F1;
	Thu,  1 Feb 2024 18:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706812247;
	bh=mZxyWFmtWxbEdMtWbAoc3TtrLI2reIByblxLtgLFwbY=;
	h=From:To:Cc:Subject:Date:From;
	b=LbuAEGMxo2Cfb82pPfIT37NfHdyxj5thoviV+9/rOsfgG00CmFyc7YomLvhYJglY4
	 jREfbxSPFnCsYz3cs/3ArnMGaRgCbHVlgrYXo4yxLsNvyMRo+x/KcGW9isUPqMXCiZ
	 k2NZ29JNxYpIpEa4CGPJr/aRFiZ3L/AXTDFZZ17tAv7W8XMTPLR2DE2KOl+QhF8khk
	 66pAmE3wQdH0X0yNPndCd5yMzkbBOriZZhY4ytnpTWKN4gMXBIwwN9lIUioD6Oazph
	 DlJHw1SoPf3rB7OeokEX82PGe8sQwvg60mNcImaILKl82VFhRONJ68au6GkgpO3Yvj
	 7A6yFAoEd8rnw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.8-rc3
Date: Thu,  1 Feb 2024 10:30:46 -0800
Message-ID: <20240201183046.3491512-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7:

  Merge tag 'net-6.8-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-01-25 10:58:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8-rc3

for you to fetch changes up to 4e192be1a225b7b1c4e315a44754312347628859:

  Merge tag 'batadv-net-pullrequest-20240201' of git://git.open-mesh.org/linux-merge (2024-02-01 09:25:53 -0800)

----------------------------------------------------------------
Including fixes from netfilter.

As Paolo promised we continue to hammer out issues in our selftests.
This is not the end but probably the peak.

Current release - regressions:

 - smc: fix incorrect SMC-D link group matching logic

Current release - new code bugs:

 - eth: bnxt: silence WARN() when device skips a timestamp, it happens

Previous releases - regressions:

 - ipmr: fix null-deref when forwarding mcast packets

 - conntrack: evaluate window negotiation only for packets in the REPLY
   direction, otherwise SYN retransmissions trigger incorrect window
   scale negotiation

 - ipset: fix performance regression in swap operation

Previous releases - always broken:

 - tcp: add sanity checks to types of pages getting into
   the rx zerocopy path, we only support basic NIC -> user,
   no page cache pages etc.

 - ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()

 - nt_tables: more input sanitization changes

 - dsa: mt7530: fix 10M/100M speed on MediaTek MT7988 switch

 - bridge: mcast: fix loss of snooping after long uptime,
   jiffies do wrap on 32bit

 - xen-netback: properly sync TX responses, protect with locking

 - phy: mediatek-ge-soc: sync calibration values with MediaTek SDK,
   increase connection stability

 - eth: pds: fixes for various teardown, and reset races

Misc:

 - hsr: silence WARN() if we can't alloc supervision frame, it happens

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Andrew Halaney (1):
      MAINTAINERS: Drop unreachable reviewer for Qualcomm ETHQOS ethernet driver

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix failed probe due to unsupported C45 reads

Benjamin Poirier (5):
      selftests: team: Add missing config options
      selftests: bonding: Check initial state
      selftests: net: Remove executable bits from library scripts
      selftests: net: List helper scripts in TEST_FILES Makefile variable
      selftests: forwarding: List helper scripts in TEST_FILES Makefile variable

Breno Leitao (2):
      bnxt_en: Make PTP timestamp HWRM more silent
      net: sysfs: Fix /sys/class/net/<iface> path

Brett Creeley (6):
      pds_core: Prevent health thread from running during reset/remove
      pds_core: Cancel AQ work on teardown
      pds_core: Use struct pdsc for the pdsc_adminq_isr private data
      pds_core: Prevent race issues involving the adminq
      pds_core: Clear BARs on reset
      pds_core: Rework teardown/setup flow to be more common

Christophe JAILLET (1):
      ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()

Daniel Golle (3):
      net: ethernet: mtk_eth_soc: set DMA coherent mask to get PPE working
      net: phy: mediatek-ge-soc: sync driver with MediaTek SDK
      net: dsa: mt7530: fix 10M/100M speed on MT7988 switch

Dmitry Safonov (2):
      selftests/net: Rectify key counters checks
      selftests/net: Repair RST passive reset selftest

Donald Hunter (1):
      doc/netlink/specs: Add missing attr in rt_link spec

Eric Dumazet (4):
      ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()
      tcp: add sanity checks to rx zerocopy
      llc: call sock_orphan() at release time
      af_unix: fix lockdep positive in sk_diag_dump_icons()

Esben Haabendal (2):
      net: stmmac: do not clear TBS enable bit on link up/down
      net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings

Fedor Pchelkin (1):
      nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Geetha sowjanya (1):
      octeontx2-pf: Remove xdp queues on program detach

Hangbin Liu (1):
      selftests/net/lib: update busywait timeout value

Helge Deller (1):
      ipv6: Ensure natural alignment of const ipv6 loopback and router addresses

Horatiu Vultur (1):
      net: lan966x: Fix port configuration when using SGMII interface

Hui Zhou (2):
      nfp: flower: add hardware offload check for post ct entry
      nfp: flower: fix hardware offload for the transfer layer port

Ido Schimmel (1):
      selftests: net: Add missing matchall classifier

Jacob Keller (1):
      e1000e: correct maximum frequency adjustment values

Jakub Kicinski (14):
      selftests: tcp_ao: add a config file
      Merge branch 'selftests-net-a-few-fixes'
      selftests: tcp_ao: set the timeout to 2 minutes
      Merge branch 'nfp-flower-a-few-small-conntrack-offload-fixes'
      selftests: net: add missing config for nftables-backed iptables
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'selftests-net-a-couple-of-typos-fixes-in-key-management-rst-tests'
      Merge branch 'pds_core-various-fixes'
      Merge branch 'selftests-net-a-few-pmtu-sh-fixes'
      Merge branch 'selftests-net-more-small-fixes'
      selftests: net: add missing config for NF_TARGET_TTL
      Merge branch 'mptcp-fixes-for-recent-issues-reported-by-ci-s'
      Merge tag 'nf-24-01-31' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'batadv-net-pullrequest-20240201' of git://git.open-mesh.org/linux-merge

Jan Beulich (1):
      xen-netback: properly sync TX responses

Jozsef Kadlecsik (1):
      netfilter: ipset: fix performance regression in swap operation

Linus Lüssing (3):
      batman-adv: mcast: fix mcast packet type counter on timeouted nodes
      batman-adv: mcast: fix memory leak on deleting a batman-adv interface
      bridge: mcast: fix disabled snooping after long uptime

Matthias May (1):
      selftests: net: add missing config for GENEVE

Matthieu Baerts (NGI0) (8):
      selftests: mptcp: add missing kconfig for NF Filter
      selftests: mptcp: add missing kconfig for NF Filter in v6
      selftests: mptcp: add missing kconfig for NF Mangle
      selftests: mptcp: increase timeout to 30 min
      selftests: mptcp: decrease BW in simult flows
      selftests: mptcp: allow changing subtests prefix
      selftests: mptcp: join: stop transfer when check is done (part 1)
      selftests: mptcp: join: stop transfer when check is done (part 2)

Michal Vokáč (1):
      net: dsa: qca8k: fix illegal usage of GPIO

Mohammad Nassiri (1):
      selftests/net: Argument value mismatch when calling verify_counters()

Nicolas Dichtel (1):
      ipmr: fix kernel panic when forwarding mcast packets

Nikita Zhandarovich (1):
      net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()

Pablo Neira Ayuso (3):
      netfilter: nf_tables: restrict tunnel object to NFPROTO_NETDEV
      netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE when putting logger
      netfilter: nft_ct: sanitize layer 3 and 4 protocol number in custom expectations

Paolo Abeni (12):
      selftests: net: remove dependency on ebpf tests
      selftests: net: included needed helper in the install targets
      selftests: net: explicitly wait for listener ready
      selftests: net: add missing config for big tcp tests
      selftests: net: add missing required classifier
      selftests: net: give more time for GRO aggregation
      Merge branch 'net-stmmac-dwmac-imx-time-based-scheduling-support'
      selftests: net: add missing config for pmtu.sh tests
      selftests: net: fix available tunnels detection
      selftests: net: don't access /dev/stdout in pmtu.sh
      selftests: net: enable some more knobs
      mptcp: fix data re-injection from stale subflow

Parav Pandit (1):
      devlink: Fix referring to hw_addr attribute during state validation

Pavan Kumar Linga (1):
      idpf: avoid compiler padding in virtchnl2_ptype struct

Praveen Kaligineedi (1):
      gve: Fix skb truesize underestimation

Ryan Schaefer (1):
      netfilter: conntrack: correct window scaling with retransmitted SYN

Simon Horman (1):
      MAINTAINERS: Add connector headers to NETWORKING DRIVERS

Souradeep Chakrabarti (1):
      hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove

Wen Gu (1):
      net/smc: fix incorrect SMC-D link group matching logic

Xin Long (1):
      netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new

Zhipeng Lu (1):
      net: ipv4: fix a memleak in ip_setup_cork

 Documentation/ABI/testing/sysfs-class-net-queues   |  22 +--
 Documentation/netlink/specs/rt_link.yaml           |  10 ++
 MAINTAINERS                                        |   3 +-
 drivers/net/dsa/mt7530.c                           |   3 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   3 +-
 drivers/net/ethernet/amd/pds_core/adminq.c         |  60 +++++++--
 drivers/net/ethernet/amd/pds_core/core.c           |  46 +++++--
 drivers/net/ethernet/amd/pds_core/core.h           |   2 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c        |   4 +
 drivers/net/ethernet/amd/pds_core/dev.c            |  16 +--
 drivers/net/ethernet/amd/pds_core/devlink.c        |   3 +-
 drivers/net/ethernet/amd/pds_core/fw.c             |   3 +
 drivers/net/ethernet/amd/pds_core/main.c           |  26 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |   2 +-
 drivers/net/ethernet/google/gve/gve_rx.c           |   8 +-
 drivers/net/ethernet/intel/e1000e/e1000.h          |  20 +++
 drivers/net/ethernet/intel/e1000e/ptp.c            |  22 ++-
 drivers/net/ethernet/intel/idpf/virtchnl2.h        |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   1 -
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   7 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   5 +-
 .../net/ethernet/microchip/lan966x/lan966x_port.c  |   5 +-
 .../net/ethernet/netronome/nfp/flower/conntrack.c  |  46 ++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |   4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +
 drivers/net/hyperv/netvsc.c                        |   5 +-
 drivers/net/phy/mediatek-ge-soc.c                  | 147 ++++++++++++---------
 drivers/net/xen-netback/netback.c                  | 100 +++++++-------
 include/linux/netfilter/ipset/ip_set.h             |   4 +
 include/net/af_unix.h                              |  20 ++-
 include/net/ip.h                                   |   2 +-
 include/net/netfilter/nf_tables.h                  |   2 +
 net/batman-adv/multicast.c                         |   3 +
 net/bridge/br_multicast.c                          |  20 ++-
 net/bridge/br_private.h                            |   4 +-
 net/devlink/port.c                                 |   2 +-
 net/hsr/hsr_device.c                               |   4 +-
 net/ipv4/ip_output.c                               |  12 +-
 net/ipv4/ip_sockglue.c                             |   6 +-
 net/ipv4/ipmr.c                                    |   2 +-
 net/ipv4/raw.c                                     |   2 +-
 net/ipv4/tcp.c                                     |  12 +-
 net/ipv4/udp.c                                     |   2 +-
 net/ipv6/addrconf_core.c                           |  21 ++-
 net/ipv6/ip6_tunnel.c                              |  21 ++-
 net/llc/af_llc.c                                   |   2 +
 net/mptcp/protocol.c                               |   3 -
 net/netfilter/ipset/ip_set_bitmap_gen.h            |  14 +-
 net/netfilter/ipset/ip_set_core.c                  |  37 ++++--
 net/netfilter/ipset/ip_set_hash_gen.h              |  15 ++-
 net/netfilter/ipset/ip_set_list_set.c              |  13 +-
 net/netfilter/nf_conntrack_proto_sctp.c            |   2 +-
 net/netfilter/nf_conntrack_proto_tcp.c             |  10 +-
 net/netfilter/nf_log.c                             |   7 +-
 net/netfilter/nf_tables_api.c                      |  14 +-
 net/netfilter/nft_ct.c                             |  24 ++++
 net/netfilter/nft_tunnel.c                         |   1 +
 net/nfc/nci/core.c                                 |   4 +
 net/smc/smc_core.c                                 |  12 +-
 net/unix/af_unix.c                                 |  14 +-
 net/unix/diag.c                                    |   2 +-
 .../selftests/drivers/net/bonding/lag_lib.sh       |  11 ++
 tools/testing/selftests/drivers/net/team/config    |   4 +-
 tools/testing/selftests/net/Makefile               |   9 +-
 tools/testing/selftests/net/config                 |  16 +++
 tools/testing/selftests/net/forwarding/Makefile    |   2 +-
 tools/testing/selftests/net/lib.sh                 |   5 +-
 tools/testing/selftests/net/mptcp/config           |   3 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  27 ++--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   2 +-
 tools/testing/selftests/net/mptcp/settings         |   2 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   8 +-
 tools/testing/selftests/net/net_helper.sh          |   0
 tools/testing/selftests/net/pmtu.sh                |  18 +--
 tools/testing/selftests/net/setup_loopback.sh      |   0
 tools/testing/selftests/net/setup_veth.sh          |   2 +-
 tools/testing/selftests/net/tcp_ao/config          |  10 ++
 .../testing/selftests/net/tcp_ao/key-management.c  |  46 ++++---
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |  12 +-
 tools/testing/selftests/net/tcp_ao/rst.c           | 138 ++++++++++++-------
 tools/testing/selftests/net/tcp_ao/settings        |   1 +
 tools/testing/selftests/net/udpgro.sh              |   4 +-
 tools/testing/selftests/net/udpgro_bench.sh        |   4 +-
 tools/testing/selftests/net/udpgro_frglist.sh      |   6 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |   8 +-
 tools/testing/selftests/net/veth.sh                |   4 +-
 tools/testing/selftests/net/xdp_dummy.c            |  13 ++
 90 files changed, 845 insertions(+), 409 deletions(-)
 mode change 100755 => 100644 tools/testing/selftests/net/net_helper.sh
 mode change 100755 => 100644 tools/testing/selftests/net/setup_loopback.sh
 create mode 100644 tools/testing/selftests/net/tcp_ao/config
 create mode 100644 tools/testing/selftests/net/tcp_ao/settings
 create mode 100644 tools/testing/selftests/net/xdp_dummy.c

