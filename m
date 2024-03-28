Return-Path: <linux-kernel+bounces-123079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 661798901D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3AC2B21F04
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319B3130AFC;
	Thu, 28 Mar 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZF5f5MFi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F431304A2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636315; cv=none; b=ts+fR0iNF9qRX3SqHv/OMu1LjTMbII3jgUb8SFv70E3VjqqhQVKmCl2CpHN2bldbYwu9tcZIgoZ5iPPqYTB8hnRXEiIm82c9XXErw0nTJ4OvyMeo2U4mCjJzBuWGiRkaB/TeleD1OAS2yex/mu7Ifk+hESr14fXq0SYSOfF0LAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636315; c=relaxed/simple;
	bh=P/namayAJc9PfxjfEk8wEjObmYq0Kqq75a2/TudFZH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IjDMq9QxPqElPOu4SMuAeZrzVV2dwEOxa/NHEVAi0VqM/tkWSyf4DIsXuf5A4mRkxkT1YV3oTVgR3g7kyPJsepDCkPpcL98SDzUpWV8NlxHaiYucvL2liGsf474YbXjThkLiss55Wy+rozDwMsTJeUdVYPL54cwp7HbLXMRJAis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZF5f5MFi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711636309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qNTS6ONEjhkSlwvd+QMMysgnmH2L9ctPwNE84WSqcAc=;
	b=ZF5f5MFiCSJoxJ/gVt1elYIibHR1koQeFjAjJPY+tpc5kl8BNrAOz1HPaZigl1g1oI5dUK
	J80uRrWhIwtqvTjndgnUzmy9OBIldfsaIj3SOlSZbQH6ftXUrRFkoAdtpIrNF738zhrI3R
	+X7mdSTcsQy40b+0qST+ZM3/p96LYhw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-hftYBB-1NFa-1uOuxnj7cQ-1; Thu,
 28 Mar 2024 10:31:46 -0400
X-MC-Unique: hftYBB-1NFa-1uOuxnj7cQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70C172800E80;
	Thu, 28 Mar 2024 14:31:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.130])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3230E3C54;
	Thu, 28 Mar 2024 14:31:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.9-rc2
Date: Thu, 28 Mar 2024 15:31:17 +0100
Message-ID: <20240328143117.26574-1-pabeni@redhat.com>
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

The following changes since commit cba9ffdb9913dfe6be29f049ce920ce451ce7cc4:

  Merge tag 'net-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-03-21 14:50:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc2

for you to fetch changes up to 18685451fc4e546fc0e718580d32df3c0e5c8272:

  inet: inet_defrag: prevent sk release while still in use (2024-03-28 12:06:22 +0100)

----------------------------------------------------------------
Including fixes from bpf, WiFi and netfilter.

Current release - regressions:

 - ipv6: fix address dump when IPv6 is disabled on an interface

Current release - new code bugs:

 - bpf: temporarily disable atomic operations in BPF arena

 - nexthop: fix uninitialized variable in nla_put_nh_group_stats()

Previous releases - regressions:

 - bpf: protect against int overflow for stack access size

 - hsr: fix the promiscuous mode in offload mode

 - wifi: don't always use FW dump trig

 - tls: adjust recv return with async crypto and failed copy to userspace

 - tcp: properly terminate timers for kernel sockets

 - ice: fix memory corruption bug with suspend and rebuild

 - at803x: fix kernel panic with at8031_probe

 - qeth: handle deferred cc1

Previous releases - always broken:

 - bpf: fix bug in BPF_LDX_MEMSX

 - netfilter: reject table flag and netdev basechain updates

 - inet_defrag: prevent sk release while still in use

 - wifi: pick the version of SESSION_PROTECTION_NOTIF

 - wwan: t7xx: split 64bit accesses to fix alignment issues

 - mlxbf_gige: call request_irq() after NAPI initialized

 - hns3: fix kernel crash when devlink reload during pf initialization

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexandra Winter (1):
      s390/qeth: handle deferred cc1

Alexei Starovoitov (5):
      bpf: Clarify bpf_arena comments.
      libbpf, selftests/bpf: Adjust libbpf, bpftool, selftests to match LLVM
      selftests/bpf: Remove hard coded PAGE_SIZE macro.
      selftests/bpf: Add arena test case for 4Gbyte corner case
      Merge branch 'check-bloom-filter-map-value-size'

Andrei Matei (2):
      bpf: Check bloom filter map value size
      bpf: Protect against int overflow for stack access size

Andrii Nakryiko (2):
      Merge branch 'bpf-arena-followups'
      libbpf: fix u64-to-pointer cast on 32-bit arches

Arnaldo Carvalho de Melo (1):
      libbpf: Define MFD_CLOEXEC if not available

Artem Savkov (1):
      arm64: bpf: fix 32bit unconditional bswap

Arınç ÜNAL (1):
      net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530

Ayala Beker (1):
      wifi: mac80211: correctly set active links upon TTLM

Benjamin Berg (2):
      wifi: iwlwifi: mvm: guard against invalid STA ID on removal
      wifi: iwlwifi: mvm: include link ID when releasing frames

Bjørn Mork (1):
      net: wwan: t7xx: Split 64bit accesses to fix alignment issues

Christian Marangi (1):
      net: phy: qcom: at803x: fix kernel panic with at8031_probe

Claus Hansen Ries (1):
      net: ll_temac: platform_get_resource replaced by wrong function

Dan Carpenter (1):
      nexthop: fix uninitialized variable in nla_put_nh_group_stats()

David Thompson (2):
      mlxbf_gige: stop PHY during open() error paths
      mlxbf_gige: call request_irq() after NAPI initialized

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: pick the version of SESSION_PROTECTION_NOTIF

Eric Dumazet (1):
      tcp: properly terminate timers for kernel sockets

Felix Fietkau (1):
      wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes

Florian Westphal (1):
      inet: inet_defrag: prevent sk release while still in use

Francesco Dolcini (1):
      MAINTAINERS: wifi: mwifiex: add Francesco as reviewer

Hangbin Liu (1):
      scripts/bpf_doc: Use silent mode when exec make cmd

Hari Bathini (1):
      bpf: fix warning for crash_kexec

Hariprasad Kelam (1):
      Octeontx2-af: fix pause frame configuration in GMP mode

Herve Codina (1):
      net: wan: framer: Add missing static inline qualifiers

Ido Schimmel (2):
      ipv6: Fix address dump when IPv6 is disabled on an interface
      selftests: vxlan_mdb: Fix failures with old libnet

Igor Artemiev (1):
      wifi: cfg80211: fix rdev_dump_mpp() arguments order

Ilan Peer (1):
      wifi: iwlwifi: mvm: Configure the link mapping for non-MLD FW

Ilya Leoshkevich (1):
      s390/bpf: Fix bpf_plt pointer arithmetic

Jakub Kicinski (5):
      tools: ynl: fix setting presence bits in simple nests
      Merge branch 'tls-recvmsg-fixes'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      selftests: netdevsim: set test timeout to 10 minutes
      Merge tag 'wireless-2024-03-27' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jeff Johnson (1):
      wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc

Jesse Brandeburg (1):
      ice: fix memory corruption bug with suspend and rebuild

Jian Shen (1):
      net: hns3: mark unexcuted loopback test result as UNEXECUTED

Jie Wang (1):
      net: hns3: fix index limit to support all queue stats

Johan Hovold (1):
      wifi: mac80211: fix mlme_link_id_dbg()

Johannes Berg (8):
      wifi: cfg80211: add a flag to disable wireless extensions
      wifi: iwlwifi: mvm: disable MLO for the time being
      wifi: mac80211: fix prep_connection error path
      wifi: iwlwifi: mvm: rfi: fix potential response leaks
      wifi: iwlwifi: fw: don't always use FW dump trig
      wifi: iwlwifi: read txq->read_ptr under lock
      wifi: iwlwifi: mvm: handle debugfs names more carefully
      kunit: fix wireless test dependencies

Justin Chen (2):
      net: bcmasp: Bring up unimac after PHY link up
      net: bcmasp: Remove phy_{suspend/resume}

Kuniyuki Iwashima (1):
      netfilter: arptables: Select NETFILTER_FAMILY_ARP when building arp_tables.c

Kurt Kanzenbach (1):
      igc: Remove stale comment about Tx timestamping

Matt Bobrowski (1):
      bpf: update BPF LSM designated reviewer list

Pablo Neira Ayuso (3):
      netfilter: nf_tables: reject destroy command to remove basechain hooks
      netfilter: nf_tables: reject table flag and netdev basechain updates
      netfilter: nf_tables: skip netdev hook unregistration if table is dormant

Paolo Abeni (5):
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'
      Merge tag 'for-net' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge tag 'nf-24-03-28' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'net-bcmasp-phy-managements-fixes'

Ping-Ke Shih (2):
      wifi: rtw89: coex: fix configuration for shared antenna for 8922A
      MAINTAINERS: wifi: add git tree for Realtek WiFi drivers

Prasad Pandit (1):
      dpll: indent DPLL option type by a tab

Przemek Kitszel (1):
      ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Pu Lehui (1):
      riscv, bpf: Fix kfunc parameters incompatibility between bpf and riscv abi

Puranjay Mohan (5):
      bpf: Temporarily disable atomic operations in BPF arena
      bpf, arm64: fix bug in BPF_LDX_MEMSX
      bpf: verifier: fix addr_space_cast from as(1) to as(0)
      selftests/bpf: verifier_arena: fix mmap address for arm64
      bpf: verifier: reject addr_space_cast insn without arena

Quentin Monnet (1):
      MAINTAINERS: Update email address for Quentin Monnet

Raju Lakkaraju (1):
      net: lan743x: Add set RFE read fifo threshold for PCI1x1x chips

Ravi Gunasekaran (1):
      net: hsr: hsr_slave: Fix the promiscuous mode in offload mode

Ryosuke Yasuoka (1):
      nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Sabrina Dubroca (4):
      tls: recv: process_rx_list shouldn't use an offset with kvec
      tls: adjust recv return with async crypto and failed copy to userspace
      selftests: tls: add test with a partially invalid iov
      tls: get psock ref after taking rxlock to avoid leak

Sergey Shtylyov (1):
      MAINTAINERS: split Renesas Ethernet drivers entry

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: consider having one active link

Stanislav Fomichev (1):
      xsk: Don't assume metadata is always requested in TX completion

Steven Zou (1):
      ice: Refactor FW data type and fix bitmap casting issue

Yonglong Liu (1):
      net: hns3: fix kernel crash when devlink reload during pf initialization

linke li (1):
      net: mark racy access on sk->sk_rcvbuf

 .mailmap                                           |   3 +-
 MAINTAINERS                                        |  40 +++-
 arch/arm64/net/bpf_jit_comp.c                      |   4 +-
 arch/riscv/net/bpf_jit_comp64.c                    |  16 ++
 arch/s390/net/bpf_jit_comp.c                       |  46 ++---
 drivers/dpll/Kconfig                               |   2 +-
 drivers/net/dsa/mt7530.c                           |   5 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  43 ++---
 .../hns3/hns3_common/hclge_comm_tqp_stats.c        |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  19 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   4 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   3 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |  18 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |  24 ++-
 drivers/net/ethernet/intel/ice/ice_switch.h        |   4 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   4 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |  16 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   5 +
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |  21 ++-
 drivers/net/ethernet/microchip/lan743x_main.c      |  18 ++
 drivers/net/ethernet/microchip/lan743x_main.h      |   4 +
 drivers/net/ethernet/xilinx/ll_temac_main.c        |   2 +-
 drivers/net/phy/qcom/at803x.c                      |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  16 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |  59 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   4 +
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c       |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  20 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   5 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   2 +-
 drivers/net/wwan/t7xx/t7xx_cldma.c                 |   4 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c             |   9 +-
 drivers/net/wwan/t7xx/t7xx_pcie_mac.c              |   8 +-
 drivers/s390/net/qeth_core_main.c                  |  38 +++-
 include/linux/framer/framer.h                      |   4 +-
 include/linux/skbuff.h                             |   7 +-
 include/net/cfg80211.h                             |   2 +
 include/net/inet_connection_sock.h                 |   1 +
 include/net/sock.h                                 |   7 +
 include/net/xdp_sock.h                             |   2 +
 kernel/bpf/arena.c                                 |  25 ++-
 kernel/bpf/bloom_filter.c                          |  13 ++
 kernel/bpf/helpers.c                               |   2 +-
 kernel/bpf/verifier.c                              |  27 ++-
 net/core/sock.c                                    |   4 +-
 net/hsr/hsr_slave.c                                |   3 +-
 net/ipv4/inet_connection_sock.c                    |  14 ++
 net/ipv4/inet_fragment.c                           |  70 +++++--
 net/ipv4/ip_fragment.c                             |   2 +-
 net/ipv4/netfilter/Kconfig                         |   1 +
 net/ipv4/nexthop.c                                 |   4 +-
 net/ipv4/tcp.c                                     |   2 +
 net/ipv6/addrconf.c                                |   5 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   2 +-
 net/mac80211/cfg.c                                 |   5 +-
 net/mac80211/debug.h                               |   2 +-
 net/mac80211/ieee80211_i.h                         |   4 +-
 net/mac80211/mlme.c                                |  15 +-
 net/netfilter/nf_tables_api.c                      |  50 ++++-
 net/nfc/nci/core.c                                 |   5 +
 net/tls/tls_sw.c                                   |   7 +-
 net/wireless/trace.h                               |   2 +-
 net/wireless/wext-core.c                           |   7 +-
 scripts/bpf_doc.py                                 |   4 +-
 tools/bpf/bpftool/gen.c                            |   2 +-
 tools/lib/bpf/libbpf.c                             |  10 +-
 tools/net/ynl/ynl-gen-c.py                         |   7 +-
 tools/testing/kunit/configs/all_tests.config       |   2 +
 tools/testing/selftests/bpf/bpf_arena_common.h     |   2 +-
 .../testing/selftests/bpf/prog_tests/arena_htab.c  |   8 +-
 .../testing/selftests/bpf/prog_tests/arena_list.c  |   7 +-
 .../selftests/bpf/prog_tests/bloom_filter_map.c    |   6 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/arena_htab.c     |   2 +-
 tools/testing/selftests/bpf/progs/arena_list.c     |  10 +-
 tools/testing/selftests/bpf/progs/verifier_arena.c |  10 +-
 .../selftests/bpf/progs/verifier_arena_large.c     |  68 +++++++
 .../selftests/drivers/net/netdevsim/settings       |   1 +
 tools/testing/selftests/net/test_vxlan_mdb.sh      | 205 +++++++++++++--------
 tools/testing/selftests/net/tls.c                  |  34 ++++
 86 files changed, 865 insertions(+), 337 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_large.c
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/settings


