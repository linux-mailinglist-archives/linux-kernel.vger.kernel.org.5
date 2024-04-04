Return-Path: <linux-kernel+bounces-132127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34338898FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A611F25840
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B07A13BAFB;
	Thu,  4 Apr 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvj4zVYm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2F13473D;
	Thu,  4 Apr 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265485; cv=none; b=h1I/T3Jq7SJh3QRDutgEEp5RZ+uY+tbRot+6jgVRsoIEWFIwtHeAdgYwSdaFIbvmnMsXm4qLEaw0nAb5fXwLzvIGgnd6Ch2t/MQnqCWNmMUgLizpy1J4oQKrimM2uTfi9NKDA/ujb7+bh2txqOmftwaQhKLGKs8jqrIuH8Tq0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265485; c=relaxed/simple;
	bh=fh9bOZaW86nsJAkx5fmDExPhNn+9CkxhF3A7TwLsMt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SorK4WStDZbqioWOktHioJw3RbCJaXx697EjgoPrFhAaCfuEcCe1EDQzPhYlbL1aZ3nnsoxluxxCfeg/qy2aJbkEn5C9yJfBnkdmKMgnxj5KNvF5KexCJa76wFyjGahKkbMsvqWgFWTJ2HAwXWvYJVKe5INWOoseH5n0eJ/GLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvj4zVYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDA4C433C7;
	Thu,  4 Apr 2024 21:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712265484;
	bh=fh9bOZaW86nsJAkx5fmDExPhNn+9CkxhF3A7TwLsMt8=;
	h=From:To:Cc:Subject:Date:From;
	b=bvj4zVYmUln8xLyf1qdNLQSSbhys2oDGhK+Uj/KL5AqWkQaf2tudBXq7C9LLPu61R
	 5OKvkRFo9eF8irlJzv5uqfRucFu/GIE37VZjsK9kYHcecHeofvpXZqN+vYqTD/RWGV
	 /NdPTRmSlHQuLdE/J0wfdBhsecWSStPlCGrILApGlhls8KVic/A2x4Wl2ooYFaYoom
	 ji9E67GoSGscitA86aXKkh6NbD4EOb80PaB/tQ/sA8+O5wYBOgfbInofbZc4VgaEv7
	 kNuOb+IIrAT3JpxHK/5oUYbT5bnyhB0WRg5Sg3NtPB14W0WHMjmOjmR61k1qyRefcs
	 EzrdebnqYJabQ==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.9-rc3
Date: Thu,  4 Apr 2024 14:18:03 -0700
Message-ID: <20240404211803.2089033-1-kuba@kernel.org>
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

The following changes since commit 50108c352db70405b3d71d8099d0b3adc3b3352c:

  Merge tag 'net-6.9-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-03-28 13:09:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc3

for you to fetch changes up to 1cfa2f10f4e90a353c3ee2150866b4cf72579153:

  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2024-04-04 11:37:39 -0700)

----------------------------------------------------------------
Including fixes from netfilter, bluetooth and bpf.

Fairly usual collection of driver and core fixes. The large selftest
accompanying one of the fixes is also becoming a common occurrence.

Current release - regressions:

 - ipv6: fix infinite recursion in fib6_dump_done()

 - net/rds: fix possible null-deref in newly added error path

Current release - new code bugs:

 - net: do not consume a full cacheline for system_page_pool

 - bpf: fix bpf_arena-related file descriptor leaks in the verifier

 - drv: ice: fix freeing uninitialized pointers, fixing misuse of
   the newfangled __free() auto-cleanup

Previous releases - regressions:

 - x86/bpf: fixes the BPF JIT with retbleed=stuff

 - xen-netfront: add missing skb_mark_for_recycle, fix page pool
   accounting leaks, revealed by recently added explicit warning

 - tcp: fix bind() regression for v6-only wildcard and v4-mapped-v6
   non-wildcard addresses

 - Bluetooth:
   - replace "hci_qca: Set BDA quirk bit if fwnode exists in DT"
     with better workarounds to un-break some buggy Qualcomm devices
   - set conn encrypted before conn establishes, fix re-connecting
     to some headsets which use slightly unusual sequence of msgs

 - mptcp:
   - prevent BPF accessing lowat from a subflow socket
   - don't account accept() of non-MPC client as fallback to TCP

 - drv: mana: fix Rx DMA datasize and skb_over_panic

 - drv: i40e: fix VF MAC filter removal

Previous releases - always broken:

 - gro: various fixes related to UDP tunnels - netns crossing problems,
   incorrect checksum conversions, and incorrect packet transformations
   which may lead to panics

 - bpf: support deferring bpf_link dealloc to after RCU grace period

 - nf_tables:
   - release batch on table validation from abort path
   - release mutex after nft_gc_seq_end from abort path
   - flush pending destroy work before exit_net release

 - drv: r8169: skip DASH fw status checks when DASH is disabled

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aleksandr Loktionov (2):
      i40e: fix i40e_count_filters() to count only active/new filters
      i40e: fix vf may be used uninitialized in this function warning

Aleksandr Mishin (2):
      net: phy: micrel: Fix potential null pointer dereference
      octeontx2-af: Add array index check

Alexei Starovoitov (1):
      Merge branch 'x86-bpf-fixes-for-the-bpf-jit-with-retbleed-stuff'

Andrii Nakryiko (2):
      bpf: put uprobe link's path and task in release callback
      bpf: support deferring bpf_link dealloc to after RCU grace period

Antoine Tenart (5):
      udp: do not accept non-tunnel GSO skbs landing in a tunnel
      gro: fix ownership transfer
      udp: do not transition UDP GRO fraglist partial checksums to unnecessary
      udp: prevent local UDP tunnel packets from being GROed
      selftests: net: gro fwd: update vxlan GRO test expectations

Anton Protopopov (1):
      bpf: fix possible file descriptor leaks in verifier

Atlas Yu (1):
      r8169: skip DASH fw status checks when DASH is disabled

Bastien Nocera (1):
      Bluetooth: Fix TOCTOU in HCI debugfs implementation

Christophe JAILLET (1):
      net: dsa: sja1105: Fix parameters order in sja1110_pcs_mdio_write_c45()

Dan Carpenter (1):
      ice: Fix freeing uninitialized pointers

David S. Miller (1):
      Merge branch 'gro-fixes'

David Thompson (1):
      mlxbf_gige: stop interface during shutdown

Davide Caratti (1):
      mptcp: don't account accept() of non-MPC client as fallback to TCP

Duanqiang Wen (1):
      net: txgbe: fix i2c dev name cannot match clkdev

Duoming Zhou (1):
      ax25: fix use-after-free bugs caused by ax25_ds_del_timer

Eric Dumazet (5):
      net: do not consume a cacheline for system_page_pool
      erspan: make sure erspan_base_hdr is present in skb->head
      net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()
      net/sched: act_skbmod: prevent kernel-infoleak
      netfilter: validate user input for expected length

Geliang Tang (1):
      selftests: mptcp: join: fix dev in check_endpoint

Haiyang Zhang (1):
      net: mana: Fix Rx DMA datasize and skb_over_panic

Hariprasad Kelam (1):
      octeontx2-af: Fix issue with loading coalesced KPU profiles

Heiner Kallweit (1):
      r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d

Horatiu Vultur (1):
      net: phy: micrel: lan8814: Fix when enabling/disabling 1-step timestamping

Hui Wang (1):
      Bluetooth: hci_event: set the conn encrypted before conn establishes

Ivan Vecera (2):
      i40e: Enforce software interrupt during busy-poll exit
      i40e: Fix VF MAC filter removal

Jakub Kicinski (10):
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'tcp-fix-bind-regression-and-more-tests'
      Merge tag 'for-net-2024-03-29' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      selftests: reuseaddr_conflict: add missing new line at the end of the output
      Merge branch 'mptcp-fix-fallback-mib-counter-and-wrong-var-in-selftests'
      Merge branch 'net-fec-fix-to-suspend-resume-with-mac_managed_pm'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'nf-24-04-04' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf

Jakub Sitnicki (1):
      bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Jesper Dangaard Brouer (1):
      xen-netfront: Add missing skb_mark_for_recycle

Joan Bruguera Micó (1):
      x86/bpf: Fix IP for relocating call depth accounting

Johan Hovold (5):
      Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
      dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
      arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
      Bluetooth: add quirk for broken address properties
      Bluetooth: qca: fix device-address endianness

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid the interface always configured as random address

Joshua Hay (1):
      idpf: fix kernel panic on unknown packet types

Krzysztof Kozlowski (1):
      ptp: MAINTAINERS: drop Jeff Sipek

Kuniyuki Iwashima (9):
      tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6 non-wildcard addresses.
      tcp: Fix bind() regression for v6-only wildcard and v4(-mapped-v6) non-wildcard addresses.
      selftest: tcp: Make bind() selftest flexible.
      selftest: tcp: Define the reverse order bind() tests explicitly.
      selftest: tcp: Add v4-v4 and v6-v6 bind() conflict tests.
      selftest: tcp: Add more bind() calls.
      selftest: tcp: Add bind() tests for IPV6_V6ONLY.
      selftest: tcp: Add bind() tests for SO_REUSEADDR/SO_REUSEPORT.
      ipv6: Fix infinite recursion in fib6_dump_done().

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync

Lukasz Majewski (1):
      net: hsr: Use full string description when opening HSR network device

Mahmoud Adam (1):
      net/rds: fix possible cp null dereference

Marco Pinna (1):
      vsock/virtio: fix packet delivery to tap device

Michael Krummsdorf (1):
      net: dsa: mv88e6xxx: fix usable ports on 88e6020

Natanael Copa (1):
      tools/resolve_btfids: fix build with musl libc

Nikita Kiryushin (1):
      tg3: Remove residual error handling in tg3_suspend

Pablo Neira Ayuso (5):
      netfilter: nf_tables: release batch on table validation from abort path
      netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path
      netfilter: nf_tables: flush pending destroy work before exit_net release
      netfilter: nf_tables: reject new basechain after table flag update
      netfilter: nf_tables: discard table flag update with pending basechain deletion

Paolo Abeni (2):
      mptcp: prevent BPF accessing lowat from a subflow socket.
      Revert "tg3: Remove residual error handling in tg3_suspend"

Paul Barker (2):
      net: ravb: Always process TX descriptor ring
      net: ravb: Always update error counters

Petr Oros (1):
      ice: fix enabling RX VLAN filtering

Phil Elwell (1):
      net: bcmgenet: Reset RBUF on first open

Piotr Wejman (1):
      net: stmmac: fix rx queue priority assignment

Su Hui (1):
      octeontx2-pf: check negative error code in otx2_open()

Tariq Toukan (1):
      MAINTAINERS: mlx5: Add Tariq Toukan

Uros Bizjak (1):
      x86/bpf: Fix IP after emitting call depth accounting

Vitaly Lifshits (2):
      e1000e: Workaround for sporadic MDI error on Meteor Lake systems
      e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue

Wei Fang (1):
      net: fec: Set mac_managed_pm during probe

William Tu (1):
      Documentation: Add documentation for eswitch attribute

Ziyang Xuan (1):
      netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()

 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   4 +
 .../networking/devlink/devlink-eswitch-attr.rst    |  76 ++
 Documentation/networking/devlink/index.rst         |   1 +
 Documentation/networking/representors.rst          |   1 +
 MAINTAINERS                                        |   3 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |   2 +
 arch/x86/include/asm/alternative.h                 |   4 +-
 arch/x86/kernel/callthunks.c                       |   4 +-
 arch/x86/net/bpf_jit_comp.c                        |  19 +-
 drivers/bluetooth/btqca.c                          |   8 +-
 drivers/bluetooth/hci_qca.c                        |  19 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   6 +-
 drivers/net/dsa/sja1105/sja1105_mdio.c             |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  16 +-
 drivers/net/ethernet/freescale/fec_main.c          |  11 +-
 drivers/net/ethernet/intel/e1000e/hw.h             |   2 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  38 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  18 +
 drivers/net/ethernet/intel/e1000e/phy.c            | 184 +++--
 drivers/net/ethernet/intel/e1000e/phy.h            |   2 +
 drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  13 +-
 drivers/net/ethernet/intel/i40e/i40e_register.h    |   3 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  82 ++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  45 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   2 +-
 .../net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   |  18 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |   2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   2 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |  10 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  40 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  24 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  40 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  38 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   8 +-
 drivers/net/phy/micrel.c                           |  31 +-
 drivers/net/usb/ax88179_178a.c                     |   2 +
 drivers/net/xen-netfront.c                         |   1 +
 include/linux/bpf.h                                |  16 +-
 include/linux/udp.h                                |  28 +
 include/net/bluetooth/hci.h                        |   9 +
 include/net/mana/mana.h                            |   1 -
 kernel/bpf/syscall.c                               |  35 +-
 kernel/bpf/verifier.c                              |   3 +
 kernel/trace/bpf_trace.c                           |  10 +-
 net/ax25/ax25_dev.c                                |   2 +-
 net/bluetooth/hci_core.c                           |   6 +-
 net/bluetooth/hci_debugfs.c                        |  64 +-
 net/bluetooth/hci_event.c                          |  25 +
 net/bluetooth/hci_sync.c                           |  10 +-
 net/bridge/netfilter/ebtables.c                    |   6 +
 net/core/dev.c                                     |   2 +-
 net/core/gro.c                                     |   3 +-
 net/core/sock_map.c                                |   6 +
 net/hsr/hsr_device.c                               |  13 +-
 net/ipv4/inet_connection_sock.c                    |  30 +-
 net/ipv4/ip_gre.c                                  |   5 +
 net/ipv4/netfilter/arp_tables.c                    |   4 +
 net/ipv4/netfilter/ip_tables.c                     |   4 +
 net/ipv4/udp.c                                     |   7 +
 net/ipv4/udp_offload.c                             |  23 +-
 net/ipv6/ip6_fib.c                                 |  14 +-
 net/ipv6/ip6_gre.c                                 |   3 +
 net/ipv6/netfilter/ip6_tables.c                    |   4 +
 net/ipv6/udp.c                                     |   2 +-
 net/ipv6/udp_offload.c                             |   8 +-
 net/mptcp/protocol.c                               |   2 -
 net/mptcp/sockopt.c                                |   4 +
 net/mptcp/subflow.c                                |   2 +
 net/netfilter/nf_tables_api.c                      |  50 +-
 net/rds/rdma.c                                     |   2 +-
 net/sched/act_skbmod.c                             |  10 +-
 net/sched/sch_api.c                                |   2 +-
 net/vmw_vsock/virtio_transport.c                   |   3 +-
 tools/include/linux/btf_ids.h                      |   2 +
 tools/testing/selftests/net/bind_wildcard.c        | 793 +++++++++++++++++++--
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |   9 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   4 +-
 tools/testing/selftests/net/reuseaddr_conflict.c   |   2 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |  10 +-
 85 files changed, 1620 insertions(+), 419 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-eswitch-attr.rst

