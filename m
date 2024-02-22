Return-Path: <linux-kernel+bounces-76499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B185F7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231691F242DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DECA5FB8C;
	Thu, 22 Feb 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V38fMTpM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC93F9ED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708604414; cv=none; b=dy9TzWILCkpjBnqmnqBZkyfqnpP3W++Aw+mjqBMnxgYF3bP1L99OOblcvlCN3FbWFLoVcABCK0q2DiNeN61oP5hM1qrZz9yessrpfXl+U3xjS/iY8VduYdEUpKxAKlYJ64+Gd4ckNf+T4pCG2Qd2m1K4StQPheDR/58ihQIg9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708604414; c=relaxed/simple;
	bh=fcyw9hRjBpxAQzHjE29u+Md8/UmHcVqEL6FMEIsU7Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=elerpyD38RxtlODfmByfCbSIqfqY6akWhnFB0UyEhzIzUWokWhIJsdenmxBygxQP6n2Oslr0yLkfILQJCOQwxeRn/ijDEzgjE8lpJqV5HBP2YZl4j50yCTOuCPIz7Y8zGmxbyfTasznxlX0rpP3VmRykJ8zyAf3NBpVNkT255kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V38fMTpM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708604411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oaLooiI9kHSDxg3YrQvhXmEPdEW5ntCvNIdBOEcaSCI=;
	b=V38fMTpMXcJnmEoUbUnAp0Ohc64w2rRWUN0oxgGGTglILHeL7kdYV0g9PXQw4M9/f54s5M
	VDcueHAT3MzUsmQiFQE29FDr7CPbkxwmjWDwJew4rm479cRRf7HK9nMP8KDxe1hCMSmo3/
	qvTxuadoXTCpPOBO9VaKcn/RLk3CM5E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-ZRwB6YoBNHqBpsz5bAg6UQ-1; Thu, 22 Feb 2024 07:20:08 -0500
X-MC-Unique: ZRwB6YoBNHqBpsz5bAg6UQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9DC9832C06;
	Thu, 22 Feb 2024 12:20:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9FCAF8CF1;
	Thu, 22 Feb 2024 12:20:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.8.0-rc6
Date: Thu, 22 Feb 2024 13:19:50 +0100
Message-ID: <20240222121950.35761-1-pabeni@redhat.com>
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

Notably one bpf fix required touching the arch specific x86 bits and it has
been acked by Thomas.

There is a known mptcp regression, the fix did not make it into this PR and
will land the next week.

The following changes since commit 359e54a93ab43d32ee1bff3c2f9f10cb9f6b6e79:

  l2tp: pass correct message length to ip6_append_data (2024-02-22 10:42:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8.0-rc6

for you to fetch changes up to 359e54a93ab43d32ee1bff3c2f9f10cb9f6b6e79:

  l2tp: pass correct message length to ip6_append_data (2024-02-22 10:42:17 +0100)

----------------------------------------------------------------
Including fixes from bpf and netfilter.

Current release - regressions:

  - af_unix: fix another unix GC hangup

Previous releases - regressions:

  - core: fix a possible AF_UNIX deadlock

  - bpf: fix NULL pointer dereference in sk_psock_verdict_data_ready()

  - netfilter: nft_flow_offload: release dst in case direct xmit path is used

  - bridge: switchdev: ensure MDB events are delivered exactly once

  - l2tp: pass correct message length to ip6_append_data

  - dccp/tcp: unhash sk from ehash for tb2 alloc failure after check_estalblished()

  - tls: fixes for record type handling with PEEK

  - devlink: fix possible use-after-free and memory leaks in devlink_init()

Previous releases - always broken:

  - bpf: fix an oops when attempting to read the vsyscall
  	 page through bpf_probe_read_kernel

  - sched: act_mirred: use the backlog for mirred ingress

  - netfilter: nft_flow_offload: fix dst refcount underflow

  - ipv6: sr: fix possible use-after-free and null-ptr-deref

  - mptcp: fix several data races

  - phonet: take correct lock to peek at the RX queue

Misc:

  - handful of fixes and reliability improvements for selftests

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
The following changes since commit 4f5e5092fdbf5cec6bedc19fbe69cce4f5f08372:

  Merge tag 'net-6.8-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-02-15 11:39:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.8.0-rc6

for you to fetch changes up to 359e54a93ab43d32ee1bff3c2f9f10cb9f6b6e79:

  l2tp: pass correct message length to ip6_append_data (2024-02-22 10:42:17 +0100)

----------------------------------------------------------------
Including fixes from bpf and netfilter.

Current release - regressions:

  - af_unix: fix another unix GC hangup

Previous releases - regressions:

  - core: fix a possible AF_UNIX deadlock

  - bpf: fix NULL pointer dereference in sk_psock_verdict_data_ready()

  - netfilter: nft_flow_offload: release dst in case direct xmit path is used

  - bridge: switchdev: ensure MDB events are delivered exactly once

  - l2tp: pass correct message length to ip6_append_data

  - dccp/tcp: unhash sk from ehash for tb2 alloc failure after check_estalblished()

  - tls: fixes for record type handling with PEEK

  - devlink: fix possible use-after-free and memory leaks in devlink_init()

Previous releases - always broken:

  - bpf: fix an oops when attempting to read the vsyscall
  	 page through bpf_probe_read_kernel

  - sched: act_mirred: use the backlog for mirred ingress

  - netfilter: nft_flow_offload: fix dst refcount underflow

  - ipv6: sr: fix possible use-after-free and null-ptr-deref

  - mptcp: fix several data races

  - phonet: take correct lock to peek at the RX queue

Misc:

  - handful of fixes and reliability improvements for selftests

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alex Elder (1):
      net: ipa: don't overrun IPA suspend interrupt registers

Alexander Gordeev (1):
      net/iucv: fix the allocation size of iucv_path_table array

Alexei Starovoitov (1):
      Merge branch 'fix-the-read-of-vsyscall-page-through-bpf'

David S. Miller (4):
      Merge branch 'bridge-mdb-events'
      Merge branch 'inet-fix-NLM_F_DUMP_INTR-logic'
      Merge branch 'mptcp-fixes'
      Merge branch 'bcmasp-fixes'

Eric Dumazet (3):
      ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
      ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid
      net: implement lockless setsockopt(SO_PEEK_OFF)

Florian Fainelli (1):
      net: bcmasp: Indicate MAC is in charge of PHY PM

Florian Westphal (2):
      netfilter: nf_tables: set dormant flag on hook register failure
      netfilter: nf_tables: use kzalloc for hook allocation

Geliang Tang (2):
      mptcp: add needs_id for userspace appending addr
      mptcp: add needs_id for netlink appending addr

Gianmarco Lusvardi (1):
      bpf, scripts: Correct GPL license name

Hangbin Liu (1):
      selftests: bonding: set active slave to primary eth1 specifically

Hari Bathini (1):
      bpf: Fix warning for bpf_cpumask in verifier

Horatiu Vultur (1):
      net: sparx5: Add spinlock for frame transmission from CPU

Hou Tao (3):
      x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
      x86/mm: Disallow vsyscall page read for copy_from_kernel_nofault()
      selftest/bpf: Test the read of vsyscall page under x86-64

Jakub Kicinski (7):
      net/sched: act_mirred: use the backlog for mirred ingress
      net/sched: act_mirred: don't override retval if we already lost the skb
      docs: netdev: update the link to the CI repo
      Merge branch 'tls-fixes-for-record-type-handling-with-peek'
      tools: ynl: make sure we always pass yarg to mnl_cb_run
      tools: ynl: don't leak mcast_groups on init error
      Merge branch 'tools-ynl-fix-impossible-errors'

Jeremy Kerr (1):
      net: mctp: put sock on tag allocation failure

Jianbo Liu (1):
      net/sched: flower: Add lock protection when remove filter handle

Jiri Pirko (1):
      devlink: fix port dump cmd type

Justin Chen (1):
      net: bcmasp: Sanity check is off by one

Justin Iurman (2):
      Fix write to cloned skb in ipv6_hop_ioam()
      selftests: ioam: refactoring to align with the fix

Kees Cook (1):
      enic: Avoid false positive under FORTIFY_SOURCE

Kuniyuki Iwashima (3):
      dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().
      arp: Prevent overflow in arp_req_get().
      af_unix: Drop oob_skb ref before purging queue in GC.

Kurt Kanzenbach (1):
      net: stmmac: Fix EST offset for dwmac 5.10

Martin KaFai Lau (2):
      bpf: Fix racing between bpf_timer_cancel_and_free and bpf_timer_cancel
      selftests/bpf: Test racing between bpf_timer_cancel_and_free and bpf_timer_cancel

Matthieu Baerts (NGI0) (7):
      selftests: mptcp: pm nl: also list skipped tests
      selftests: mptcp: pm nl: avoid error msg on older kernels
      selftests: mptcp: diag: fix bash warnings on older kernels
      selftests: mptcp: simult flows: fix some subtest names
      selftests: mptcp: userspace_pm: unique subtest names
      selftests: mptcp: diag: unique 'in use' subtest names
      selftests: mptcp: diag: unique 'cestab' subtest names

Pablo Neira Ayuso (3):
      netfilter: nft_flow_offload: reset dst in route object after setting up flow
      netfilter: nft_flow_offload: release dst in case direct xmit path is used
      netfilter: nf_tables: register hooks last when adding new chain/flowtable

Paolo Abeni (7):
      mptcp: fix lockless access in subflow ULP diag
      mptcp: fix data races on local_id
      mptcp: fix data races on remote_id
      mptcp: fix duplicate subflow creation
      Merge branch 'ioam6-fix-write-to-cloned-skb-s'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'nf-24-02-22' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Pavel Sakharov (1):
      net: stmmac: Fix incorrect dereference in interrupt handlers

Randy Dunlap (1):
      net: ethernet: adi: requires PHYLIB support

Rémi Denis-Courmont (2):
      phonet: take correct lock to peek at the RX queue
      phonet/pep: fix racy skb_queue_empty() use

Sabrina Dubroca (5):
      tls: break out of main loop when PEEK gets a non-data record
      tls: stop recv() if initial process_rx_list gave us non-DATA
      tls: don't skip over different type records from the rx_list
      selftests: tls: add test for merging of same-type control messages
      selftests: tls: add test for peeking past a record of a different type

Sebastian Andrzej Siewior (1):
      xsk: Add truesize to skb_add_rx_frag().

Shannon Nelson (1):
      ionic: use pci_is_enabled not open code

Shigeru Yoshida (1):
      bpf, sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready()

Siddharth Vadapalli (1):
      net: phy: realtek: Fix rtl8211f_config_init() for RTL8211F(D)(I)-VD-CG PHY

Simon Horman (1):
      MAINTAINERS: Add framer headers to NETWORKING [GENERAL]

Subbaraya Sundeep (1):
      octeontx2-af: Consider the action set by PF

Tobias Waldekranz (2):
      net: bridge: switchdev: Skip MDB replays of deferred events on offload
      net: bridge: switchdev: Ensure deferred event delivery on unoffload

Tom Parkin (1):
      l2tp: pass correct message length to ip6_append_data

Vasiliy Kovalev (3):
      ipv6: sr: fix possible use-after-free and null-ptr-deref
      devlink: fix possible use-after-free and memory leaks in devlink_init()
      gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()

Yafang Shao (2):
      bpf: Fix an issue due to uninitialized bpf_iter_task
      selftests/bpf: Add negtive test cases for task iter

 Documentation/process/maintainer-netdev.rst        |  2 +-
 MAINTAINERS                                        |  2 +
 arch/x86/include/asm/vsyscall.h                    | 10 +++
 arch/x86/mm/fault.c                                |  9 --
 arch/x86/mm/maccess.c                              | 10 +++
 drivers/net/ethernet/adi/Kconfig                   |  1 +
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |  6 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  3 +
 drivers/net/ethernet/cisco/enic/vnic_vic.c         |  3 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  4 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  1 +
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |  2 +
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 20 -----
 drivers/net/gtp.c                                  | 10 +--
 drivers/net/ipa/ipa_interrupt.c                    |  2 +-
 drivers/net/phy/realtek.c                          |  4 +-
 include/net/netfilter/nf_flow_table.h              |  2 +-
 include/net/switchdev.h                            |  3 +
 include/net/tcp.h                                  |  2 +-
 kernel/bpf/helpers.c                               |  5 +-
 kernel/bpf/task_iter.c                             |  2 +
 kernel/bpf/verifier.c                              |  2 +
 net/bridge/br_switchdev.c                          | 84 ++++++++++++-------
 net/core/skmsg.c                                   |  7 +-
 net/core/sock.c                                    | 23 +++---
 net/devlink/core.c                                 | 12 ++-
 net/devlink/port.c                                 |  2 +-
 net/ipv4/arp.c                                     |  3 +-
 net/ipv4/devinet.c                                 | 21 ++++-
 net/ipv4/inet_hashtables.c                         | 25 +++++-
 net/ipv4/udp.c                                     |  7 +-
 net/ipv6/addrconf.c                                | 21 ++++-
 net/ipv6/exthdrs.c                                 | 10 +++
 net/ipv6/seg6.c                                    | 20 +++--
 net/iucv/iucv.c                                    |  4 +-
 net/l2tp/l2tp_ip6.c                                |  2 +-
 net/mctp/route.c                                   |  2 +-
 net/mptcp/diag.c                                   |  8 +-
 net/mptcp/pm_netlink.c                             | 69 ++++++++++------
 net/mptcp/pm_userspace.c                           | 15 ++--
 net/mptcp/protocol.c                               |  2 +-
 net/mptcp/protocol.h                               | 15 +++-
 net/mptcp/subflow.c                                | 15 ++--
 net/netfilter/nf_flow_table_core.c                 | 17 +++-
 net/netfilter/nf_tables_api.c                      | 81 +++++++++---------
 net/phonet/datagram.c                              |  4 +-
 net/phonet/pep.c                                   | 41 ++++++++--
 net/sched/act_mirred.c                             | 36 ++++----
 net/sched/cls_flower.c                             |  5 +-
 net/switchdev/switchdev.c                          | 73 +++++++++++++++++
 net/tls/tls_main.c                                 |  2 +-
 net/tls/tls_sw.c                                   | 24 ++++--
 net/unix/af_unix.c                                 | 19 +----
 net/unix/garbage.c                                 | 22 ++---
 net/xdp/xsk.c                                      |  3 +-
 scripts/bpf_doc.py                                 |  2 +-
 tools/net/ynl/lib/ynl.c                            | 19 ++++-
 tools/testing/selftests/bpf/prog_tests/iters.c     |  1 +
 .../selftests/bpf/prog_tests/read_vsyscall.c       | 57 +++++++++++++
 tools/testing/selftests/bpf/prog_tests/timer.c     | 35 +++++++-
 tools/testing/selftests/bpf/progs/iters_task.c     | 12 ++-
 tools/testing/selftests/bpf/progs/read_vsyscall.c  | 45 ++++++++++
 tools/testing/selftests/bpf/progs/timer.c          | 34 +++++++-
 .../selftests/drivers/net/bonding/bond_options.sh  |  2 +
 .../testing/selftests/net/forwarding/tc_actions.sh |  3 -
 tools/testing/selftests/net/ioam6.sh               | 38 ++++-----
 tools/testing/selftests/net/ioam6_parser.c         | 95 +++++++++++-----------
 tools/testing/selftests/net/mptcp/diag.sh          | 41 ++++++----
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  8 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  3 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  4 +-
 tools/testing/selftests/net/tls.c                  | 45 ++++++++++
 75 files changed, 870 insertions(+), 378 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_vsyscall.c


