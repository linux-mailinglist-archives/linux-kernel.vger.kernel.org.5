Return-Path: <linux-kernel+bounces-110500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE8C885FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D1DB21F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62411292CE;
	Thu, 21 Mar 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGELp7XT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6CAFC1E;
	Thu, 21 Mar 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042407; cv=none; b=ushAWGg9uHN9y/p/syrvvHN1FHgTkYL3pbe/dASt92cD6sP2WvSYXlg92GXyASN+fQhsLF9wwey54FtSRi+Q8hJTqYIGSdZLps136khuGZj6t8NnRSdPnS8SWkBIXgetx175rQPJM3KrDPcPEMwPVaj4hjsCgq//lHo0W/Gt1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042407; c=relaxed/simple;
	bh=1tE3fFmQXGVrppqpWx+U6sOsY4wuCN1n7Ud7ljdRiUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mbb7fkFGFS5t1PLXSvtXtJd4eZdvDcx1vrBNHOmPLzd3TZhCX4xOsHQWhA3CsotpOH6y2cjAZV5NOYCyyr4aWRLbetmraZgzyR2WkwIxWcgIs27CHFnGBcNZgxIEf4klBc+zxrkqa/uFYvVbYPJxpJWCdL6H2h6jWiutPcF5nNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGELp7XT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189F8C433F1;
	Thu, 21 Mar 2024 17:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711042406;
	bh=1tE3fFmQXGVrppqpWx+U6sOsY4wuCN1n7Ud7ljdRiUc=;
	h=From:To:Cc:Subject:Date:From;
	b=RGELp7XTkDQPY0Mp2301c2soQ0ihTVg+t0HQCt6uqroEkCI0qhXKPc6rYh0NOv3j1
	 L1c9J9EQfa502AacbauVx9XIOK2Hmo2ts6D/IgpyPTwIrTWJvZXsRhzsfq/q4sue91
	 fg25MUE5skM5zMWhCT3sC2D1qkq4565ootj5TEjhdUDYKnf7dcnFTm8UwbUaAcH6re
	 HddUyumFfBtlKOCZRgVn63edNB22mv0qxvjJI2jLtEIJ/LE7kpU7tQ3ahMOR0FALOH
	 1b5kbH5w7uTevbvwOkw5THN+cPtriHsaFUKKDbNVT7vM2kypuIkwfNQTaQsGPX38Tq
	 b+/+7eU7Rqn5Q==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.9-rc1
Date: Thu, 21 Mar 2024 10:33:25 -0700
Message-ID: <20240321173325.3227312-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

I'd like to highlight Florian W stepping down as a netfilter
maintainer due to constant stream of bug reports.
Not sure what we can do but IIUC this is not the first such case.

The following changes since commit 9187210eee7d87eea37b45ea93454a88681894a4:

  Merge tag 'net-next-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2024-03-12 17:44:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc1

for you to fetch changes up to f99c5f563c174a49ea1cbf4754539b05cfde40c4:

  Merge tag 'nf-24-03-21' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-03-21 15:16:17 +0100)

----------------------------------------------------------------
Including fixes from CAN, netfilter, wireguard and IPsec.

Current release - regressions:

 - rxrpc: fix use of page_frag_alloc_align(), it changed semantics
   and we added a new caller in a different subtree

 - xfrm: allow UDP encapsulation only in offload modes

Current release - new code bugs:

 - tcp: fix refcnt handling in __inet_hash_connect()

 - Revert "net: Re-use and set mono_delivery_time bit for userspace tstamp
   packets", conflicted with some expectations in BPF uAPI

Previous releases - regressions:

 - ipv4: raw: fix sending packets from raw sockets via IPsec tunnels

 - devlink: fix devlink's parallel command processing

 - veth: do not manipulate GRO when using XDP

 - esp: fix bad handling of pages from page_pool

Previous releases - always broken:

 - report RCU QS for busy network kthreads (with Paul McK's blessing)

 - tcp/rds: fix use-after-free on netns with kernel TCP reqsk

 - virt: vmxnet3: fix missing reserved tailroom with XDP

Misc:

 - couple of build fixes for Documentation

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Abhishek Chauhan (1):
      Revert "net: Re-use and set mono_delivery_time bit for userspace tstamp packets"

Arınç ÜNAL (3):
      net: dsa: mt7530: prevent possible incorrect XTAL frequency selection
      net: dsa: mt7530: fix link-local frames that ingress vlan filtering ports
      net: dsa: mt7530: fix handling of all link-local frames

Breno Leitao (2):
      wireguard: device: leverage core stats allocator
      wireguard: device: remove generic .ndo_get_stats64

Daniel Golle (2):
      net: mediatek: mtk_eth_soc: clear MAC_MCR_FORCE_LINK only when MAC is up
      net: ethernet: mtk_eth_soc: fix PPE hanging issue

David Howells (2):
      rxrpc: Fix use of changed alignment param to page_frag_alloc_align()
      rxrpc: Fix error check on ->alloc_txbuf()

David S. Miller (2):
      Merge branch 'veth-xdp-gro'
      Merge branch 'octeontx2-pf-mbox-fixes'

Dragos Tatulea (1):
      net: esp: fix bad handling of pages from page_pool

Duanqiang Wen (1):
      net: txgbe: fix clk_name exceed MAX_DEV_ID limits

Eric Dumazet (4):
      tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()
      net/sched: taprio: proper TCA_TAPRIO_TC_ENTRY_INDEX check
      packet: annotate data-races around ignore_outgoing
      net: move dev->state into net_device_read_txrx group

Felix Maurer (1):
      hsr: Handle failures in module init

Florian Westphal (1):
      MAINTAINERS: step down as netfilter maintainer

Herve Codina (2):
      net: wan: fsl_qmc_hdlc: Fix module compilation
      lib/bitmap: Fix bitmap_scatter() and bitmap_gather() kernel doc

Ido Schimmel (1):
      selftests: forwarding: Fix ping failure due to short timeout

Ignat Korchagin (2):
      net: veth: do not manipulate GRO when using XDP
      selftests: net: veth: test the ability to independently manipulate GRO and XDP

Jakub Kicinski (5):
      Merge branch 'tcp-rds-fix-use-after-free-around-kernel-tcp-reqsk'
      docs: networking: fix indentation errors in multi-pf-netdev
      tools: ynl: add header guards for nlctrl
      Merge tag 'ipsec-2024-03-19' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch 'report-rcu-qs-for-busy-network-kthreads'

Jason A. Donenfeld (3):
      wireguard: netlink: check for dangling peer via is_dead instead of empty list
      wireguard: netlink: access device through ctx instead of peer
      wireguard: selftests: set RISCV_ISA_FALLBACK on riscv{32,64}

Jens Axboe (1):
      net: remove {revc,send}msg_copy_msghdr() from exports

Jiri Pirko (1):
      devlink: fix port new reply cmd type

Kuniyuki Iwashima (3):
      rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
      tcp: Fix refcnt handling in __inet_hash_connect().
      tcp: Clear req->syncookie in reqsk_alloc().

Leon Romanovsky (1):
      xfrm: Allow UDP encapsulation only in offload modes

Linu Cherian (1):
      octeontx2-af: Use matching wake_up API variant in CGX command interface

Martin Jocić (1):
      can: kvaser_pciefd: Add additional Xilinx interrupts

Michal Koutný (1):
      net/sched: Add module alias for sch_fq_pie

Nikita Kiryushin (1):
      net: phy: fix phy_read_poll_timeout argument type in genphy_loopback

Nikita Zhandarovich (1):
      wireguard: receive: annotate data-race around receiving_counter.counter

Pablo Neira Ayuso (2):
      netfilter: nft_set_pipapo: release elements in clone only from destroy path
      netfilter: nf_tables: do not compare internal table flags on updates

Paolo Abeni (5):
      Merge branch 'rxrpc-fixes-for-af_rxrpc'
      Merge branch 'wireguard-fixes-for-6-9-rc1'
      Merge branch 'mt7530-dsa-subdriver-fix-vlan-egress-and-handling-of-all-link-local-frames'
      Merge tag 'linux-can-fixes-for-6.9-20240319' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'nf-24-03-21' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Quan Tian (1):
      netfilter: nf_tables: Fix a memory leak in nf_tables_updchain

Sean Anderson (2):
      soc: fsl: qbman: Always disable interrupts when taking cgr_lock
      soc: fsl: qbman: Use raw spinlock for cgr_lock

Shannon Nelson (1):
      ionic: update documentation for XDP support

Shay Drory (1):
      devlink: Fix devlink parallel commands processing

Shigeru Yoshida (1):
      hsr: Fix uninit-value access in hsr_get_node()

Subbaraya Sundeep (5):
      octeontx2: Detect the mbox up or down message via register
      octeontx2-pf: Wait till detach_resources msg is complete
      octeontx2-pf: Use default max_active works instead of one
      octeontx2-pf: Send UP messages to VF only when VF is up.
      octeontx2-af: Use separate handlers for interrupts

Thinh Tran (1):
      net/bnx2x: Prevent access to a freed page in page_pool

Tobias Brunner (1):
      ipv4: raw: Fix sending packets from raw sockets via IPsec tunnels

William Tu (1):
      vmxnet3: Fix missing reserved tailroom

Yan Zhai (3):
      rcu: add a helper to report consolidated flavor QS
      net: report RCU QS on threaded NAPI repolling
      bpf: report RCU QS in cpumap kthread

Yewon Choi (1):
      rds: introduce acquire/release ordering in acquire/release_in_xmit()

 .../device_drivers/ethernet/pensando/ionic.rst     |  22 ++++
 Documentation/networking/multi-pf-netdev.rst       |  50 ++++-----
 .../networking/net_cachelines/net_device.rst       |   2 +-
 MAINTAINERS                                        |   1 -
 drivers/net/can/kvaser_pciefd.c                    |   4 +-
 drivers/net/dsa/mt7530.c                           |  66 ++++++++----
 drivers/net/dsa/mt7530.h                           |  22 +++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h    |   6 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   |  43 +++++++-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   6 ++
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c |  17 +--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  31 ++++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |  20 ++--
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 119 ++++++++++++++-------
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  71 +++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   7 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c            |  18 ++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   2 +-
 drivers/net/phy/phy_device.c                       |   4 +-
 drivers/net/veth.c                                 |  18 ----
 drivers/net/vmxnet3/vmxnet3_xdp.c                  |   6 +-
 drivers/net/wan/fsl_qmc_hdlc.c                     |   2 +-
 drivers/net/wireguard/device.c                     |  11 +-
 drivers/net/wireguard/netlink.c                    |  10 +-
 drivers/net/wireguard/receive.c                    |   6 +-
 drivers/soc/fsl/qbman/qman.c                       |  25 +++--
 include/linux/bitmap.h                             |  44 ++++----
 include/linux/netdevice.h                          |   2 +-
 include/linux/rcupdate.h                           |  31 ++++++
 include/linux/skbuff.h                             |  16 ++-
 include/linux/socket.h                             |   7 --
 include/net/request_sock.h                         |   7 +-
 kernel/bpf/cpumap.c                                |   3 +
 net/core/dev.c                                     |   8 +-
 net/devlink/netlink.c                              |  13 +--
 net/devlink/port.c                                 |   2 +-
 net/hsr/hsr_framereg.c                             |   4 +
 net/hsr/hsr_main.c                                 |  15 ++-
 net/ipv4/esp4.c                                    |   8 +-
 net/ipv4/inet_hashtables.c                         |   2 +-
 net/ipv4/inet_timewait_sock.c                      |  45 ++++----
 net/ipv4/ip_output.c                               |   1 -
 net/ipv4/raw.c                                     |   2 +-
 net/ipv4/syncookies.c                              |   3 +
 net/ipv4/tcp_minisocks.c                           |   4 -
 net/ipv6/esp6.c                                    |   8 +-
 net/ipv6/ip6_output.c                              |   2 +-
 net/ipv6/raw.c                                     |   2 +-
 net/ipv6/syncookies.c                              |   3 +
 net/netfilter/nf_tables_api.c                      |  29 ++---
 net/netfilter/nft_set_pipapo.c                     |   5 +-
 net/packet/af_packet.c                             |   8 +-
 net/rds/send.c                                     |   5 +-
 net/rxrpc/sendmsg.c                                |   4 +-
 net/rxrpc/txbuf.c                                  |   4 +-
 net/sched/sch_fq_pie.c                             |   2 +
 net/sched/sch_taprio.c                             |   3 +-
 net/socket.c                                       |  14 +--
 net/xfrm/xfrm_device.c                             |   3 +-
 tools/net/ynl/Makefile.deps                        |   1 +
 tools/perf/trace/beauty/include/linux/socket.h     |   7 --
 .../net/forwarding/vxlan_bridge_1d_ipv6.sh         |   4 +-
 .../net/forwarding/vxlan_bridge_1q_ipv6.sh         |   4 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |   4 +
 tools/testing/selftests/net/veth.sh                |  24 ++++-
 .../selftests/wireguard/qemu/arch/riscv32.config   |   1 +
 .../selftests/wireguard/qemu/arch/riscv64.config   |   1 +
 71 files changed, 608 insertions(+), 344 deletions(-)

