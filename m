Return-Path: <linux-kernel+bounces-99816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B6878DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE1D1F21D91
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D31C126;
	Tue, 12 Mar 2024 04:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMRoFAqO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B36FBE47;
	Tue, 12 Mar 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710217506; cv=none; b=Da4RUIRGqx+dseAQivrTuaEgXIwo3NZpNIpBNaMwrpselSMcmn1zMzz51RcMm5eyDKTUxuHrDCqfRgjEZcXlefoH/PaEA6o+yc18j2m8w+GcG+v98bzQ1FG+O6W0VFKZCPRK0pMtQCy3eX4UfOa0iZ6zXcExT3T8ZD87467NpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710217506; c=relaxed/simple;
	bh=E+pWx3Zk9z+DnAIrPHeN09dSDp6eoVFKW7N9uyI2Vfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rsoitwJ8Zq0uzM8dafKa7lf6pL9jL4sLMS0UDz72kd4uY9KC2yUPlaI0fUa4loOkgF8FvUKre/0ex6gsB/sab9k3pWlfa6gyzLG3ToBnOeFz+C01pe9poOsOv79iHic15ZMNQU7QVx9aaPNt3UiFqRV2bimJ4lG/Jrna0Z9vRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMRoFAqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33322C433C7;
	Tue, 12 Mar 2024 04:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710217505;
	bh=E+pWx3Zk9z+DnAIrPHeN09dSDp6eoVFKW7N9uyI2Vfs=;
	h=From:To:Cc:Subject:Date:From;
	b=OMRoFAqOmGZOracILGGUglNQeUCXvuaDcw26LFQlXqmvdThzewa198a1GlcHf7n6h
	 zkVhUmgVwi71EE3HWk7aHgVZkDvdm1xT9hx27jjlS5hY+ftqvwrb6UMlnMFEbZCCnu
	 8NMm8MHrBTbzS23fSJid7Gk3WPZ0SY8l8IOePJf9ujHSeLy5Eqxa5cZooNrTTfeNK7
	 E+3Vl+E4TIhsd7/NAOm8fYaeUIJBuoC/9/XZDZj7Hqo8Lny1+pzCEnHZMUiQIjWQ5k
	 MDd+7dMsAfVr5zLqrV2wxpLvBQTt+fKwycIUE9Yv+gfXWH5e7AciMwTEj7Jf0SSeZ2
	 AaUIJft3p/tDw==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	bpf@vger.kernel.org
Subject: [GIT PULL] Networking for v6.9
Date: Mon, 11 Mar 2024 21:25:04 -0700
Message-ID: <20240312042504.1835743-1-kuba@kernel.org>
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

I get what looks like blk-iocost deadlock when I try to run
your current tree on real Meta servers :( So tested the PR
merged with your tree only on QEMU and on real HW pure net-next
without pulling in your tree.

The following changes since commit df4793505abd5df399bc6d9a4d8fe81761f557cd:

  Merge tag 'net-6.8-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-03-07 09:23:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.9

for you to fetch changes up to ed1f164038b50c5864aa85389f3ffd456f050cca:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-03-11 20:38:36 -0700)

----------------------------------------------------------------
Networking changes for 6.9.

Core & protocols
----------------

 - Large effort by Eric to lower rtnl_lock pressure and remove locks:

   - Make commonly used parts of rtnetlink (address, route dumps etc.)
     lockless, protected by RCU instead of rtnl_lock.

   - Add a netns exit callback which already holds rtnl_lock,
     allowing netns exit to take rtnl_lock once in the core
     instead of once for each driver / callback.

   - Remove locks / serialization in the socket diag interface.

   - Remove 6 calls to synchronize_rcu() while holding rtnl_lock.

   - Remove the dev_base_lock, depend on RCU where necessary.

 - Support busy polling on a per-epoll context basis. Poll length
   and budget parameters can be set independently of system defaults.

 - Introduce struct net_hotdata, to make sure read-mostly global config
   variables fit in as few cache lines as possible.

 - Add optional per-nexthop statistics to ease monitoring / debug
   of ECMP imbalance problems.

 - Support TCP_NOTSENT_LOWAT in MPTCP.

 - Ensure that IPv6 temporary addresses' preferred lifetimes are long
   enough, compared to other configured lifetimes, and at least 2 sec.

 - Support forwarding of ICMP Error messages in IPSec, per RFC 4301.

 - Add support for the independent control state machine for bonding
   per IEEE 802.1AX-2008 5.4.15 in addition to the existing coupled
   control state machine.

 - Add "network ID" to MCTP socket APIs to support hosts with multiple
   disjoint MCTP networks.

 - Re-use the mono_delivery_time skbuff bit for packets which user
   space wants to be sent at a specified time. Maintain the timing
   information while traversing veth links, bridge etc.

 - Take advantage of MSG_SPLICE_PAGES for RxRPC DATA and ACK packets.

 - Simplify many places iterating over netdevs by using an xarray
   instead of a hash table walk (hash table remains in place, for
   use on fastpaths).

 - Speed up scanning for expired routes by keeping a dedicated list.

 - Speed up "generic" XDP by trying harder to avoid large allocations.

 - Support attaching arbitrary metadata to netconsole messages.

Things we sprinkled into general kernel code
--------------------------------------------

 - Enforce VM_IOREMAP flag and range in ioremap_page_range and introduce
   VM_SPARSE kind and vm_area_[un]map_pages (used by bpf_arena).

 - Rework selftest harness to enable the use of the full range of
   ksft exit code (pass, fail, skip, xfail, xpass).

Netfilter
---------

 - Allow userspace to define a table that is exclusively owned by a daemon
   (via netlink socket aliveness) without auto-removing this table when
   the userspace program exits. Such table gets marked as orphaned and
   a restarting management daemon can re-attach/regain ownership.

 - Speed up element insertions to nftables' concatenated-ranges set type.
   Compact a few related data structures.

BPF
---

 - Add BPF token support for delegating a subset of BPF subsystem
   functionality from privileged system-wide daemons such as systemd
   through special mount options for userns-bound BPF fs to a trusted
   & unprivileged application.

 - Introduce bpf_arena which is sparse shared memory region between BPF
   program and user space where structures inside the arena can have
   pointers to other areas of the arena, and pointers work seamlessly
   for both user-space programs and BPF programs.

 - Introduce may_goto instruction that is a contract between the verifier
   and the program. The verifier allows the program to loop assuming it's
   behaving well, but reserves the right to terminate it.

 - Extend the BPF verifier to enable static subprog calls in spin lock
   critical sections.

 - Support registration of struct_ops types from modules which helps
   projects like fuse-bpf that seeks to implement a new struct_ops type.

 - Add support for retrieval of cookies for perf/kprobe multi links.

 - Support arbitrary TCP SYN cookie generation / validation in the TC
   layer with BPF to allow creating SYN flood handling in BPF firewalls.

 - Add code generation to inline the bpf_kptr_xchg() helper which
   improves performance when stashing/popping the allocated BPF objects.

Wireless
--------

 - Add SPP (signaling and payload protected) AMSDU support.

 - Support wider bandwidth OFDMA, as required for EHT operation.

Driver API
----------

 - Major overhaul of the Energy Efficient Ethernet internals to support
   new link modes (2.5GE, 5GE), share more code between drivers
   (especially those using phylib), and encourage more uniform behavior.
   Convert and clean up drivers.

 - Define an API for querying per netdev queue statistics from drivers.

 - IPSec: account in global stats for fully offloaded sessions.

 - Create a concept of Ethernet PHY Packages at the Device Tree level,
   to allow parameterizing the existing PHY package code.

 - Enable Rx hashing (RSS) on GTP protocol fields.

Misc
----

 - Improvements and refactoring all over networking selftests.

 - Create uniform module aliases for TC classifiers, actions,
   and packet schedulers to simplify creating modprobe policies.

 - Address all missing MODULE_DESCRIPTION() warnings in networking.

 - Extend the Netlink descriptions in YAML to cover message encapsulation
   or "Netlink polymorphism", where interpretation of nested attributes
   depends on link type, classifier type or some other "class type".

Drivers
-------

 - Ethernet high-speed NICs:
   - Add a new driver for Marvell's Octeon PCI Endpoint NIC VF.
   - Intel (100G, ice, idpf):
     - support E825-C devices
   - nVidia/Mellanox:
     - support devices with one port and multiple PCIe links
   - Broadcom (bnxt):
     - support n-tuple filters
     - support configuring the RSS key
   - Wangxun (ngbe/txgbe):
     - implement irq_domain for TXGBE's sub-interrupts
   - Pensando/AMD:
     - support XDP
     - optimize queue submission and wakeup handling (+17% bps)
     - optimize struct layout, saving 28% of memory on queues

 - Ethernet NICs embedded and virtual:
   - Google cloud vNIC:
     - refactor driver to perform memory allocations for new queue
       config before stopping and freeing the old queue memory
   - Synopsys (stmmac):
     - obey queueMaxSDU and implement counters required by 802.1Qbv
   - Renesas (ravb):
     - support packet checksum offload
     - suspend to RAM and runtime PM support

 - Ethernet switches:
   - nVidia/Mellanox:
     - support for nexthop group statistics
   - Microchip:
     - ksz8: implement PHY loopback
     - add support for KSZ8567, a 7-port 10/100Mbps switch

 - PTP:
   - New driver for RENESAS FemtoClock3 Wireless clock generator.
   - Support OCP PTP cards designed and built by Adva.

 - CAN:
   - Support recvmsg() flags for own, local and remote traffic
     on CAN BCM sockets.
   - Support for esd GmbH PCIe/402 CAN device family.
   - m_can:
     - Rx/Tx submission coalescing
     - wake on frame Rx

 - WiFi:
   - Intel (iwlwifi):
     - enable signaling and payload protected A-MSDUs
     - support wider-bandwidth OFDMA
     - support for new devices
     - bump FW API to 89 for AX devices; 90 for BZ/SC devices
   - MediaTek (mt76):
     - mt7915: newer ADIE version support
     - mt7925: radio temperature sensor support
   - Qualcomm (ath11k):
     - support 6 GHz station power modes: Low Power Indoor (LPI),
       Standard Power) SP and Very Low Power (VLP)
     - QCA6390 & WCN6855: support 2 concurrent station interfaces
     - QCA2066 support
   - Qualcomm (ath12k):
     - refactoring in preparation for Multi-Link Operation (MLO) support
     - 1024 Block Ack window size support
     - firmware-2.bin support
     - support having multiple identical PCI devices (firmware needs to
       have ATH12K_FW_FEATURE_MULTI_QRTR_ID)
     - QCN9274: support split-PHY devices
     - WCN7850: enable Power Save Mode in station mode
     - WCN7850: P2P support
   - RealTek:
     - rtw88: support for more rtw8811cu and rtw8821cu devices
     - rtw89: support SCAN_RANDOM_SN and SET_SCAN_DWELL
     - rtlwifi: speed up USB firmware initialization
     - rtwl8xxxu:
       - RTL8188F: concurrent interface support
       - Channel Switch Announcement (CSA) support in AP mode
   - Broadcom (brcmfmac):
     - per-vendor feature support
     - per-vendor SAE password setup
     - DMI nvram filename quirk for ACEPC W5 Pro

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aahil Awatramani (1):
      bonding: Add independent control state machine

Aaradhana Sahu (1):
      wifi: ath12k: fix firmware assert during insmod in memory segment mode

Abhishek Chauhan (2):
      net: stmmac: dwmac-qcom-ethqos: Enable TBS on all queues but 0
      net: Re-use and set mono_delivery_time bit for userspace tstamp packets

Adam Li (1):
      net: make SK_MEMORY_PCPU_RESERV tunable

Aditya Kumar Singh (11):
      wifi: cfg80211: send link id in channel_switch ops
      wifi: mac80211: update beacon counters per link basis
      wifi: mac80211: handle set csa/after_csa beacon on per link basis
      wifi: mac80211: start and finalize channel switch on link basis
      wifi: mac80211: add support to call csa_finish on a link
      wifi: cfg80211: add support for link id attribute in NL80211_CMD_DEL_STATION
      wifi: mac80211: flush only stations using requests links
      wifi: mac80211: remove only own link stations during stop_ap
      wifi: mac80211: check beacon countdown is complete on per link basis
      wifi: mac80211_hwsim: add support for switch_vif_chanctx callback
      wifi: mac80211: handle netif carrier up/down with link AP during MLO

Ajay Singh (6):
      wifi: wilc1000: fix driver_handler when committing initial configuration
      wifi: wilc1000: do not realloc workqueue everytime an interface is added
      wifi: wilc1000: fix incorrect power down sequence
      wifi: wilc1000: fix multi-vif management when deleting a vif
      wifi: wilc1000: set preamble size to auto as default in wilc_init_fw_config()
      wifi: wilc1000: add missing read critical sections around vif list traversal

Ajit Khaparde (1):
      bnxt_en: Add RSS support for IPSEC headers

Alan Brady (11):
      idpf: add idpf_virtchnl.h
      idpf: implement virtchnl transaction manager
      idpf: refactor vport virtchnl messages
      idpf: refactor queue related virtchnl messages
      idpf: refactor remaining virtchnl messages
      idpf: add async_handler for MAC filter messages
      idpf: refactor idpf_recv_mb_msg
      idpf: cleanup virtchnl cruft
      idpf: prevent deinit uninitialized virtchnl core
      idpf: fix minor controlq issues
      idpf: remove dealloc vector msg err in idpf_intr_rel

Alessandro Marcolini (4):
      taprio: validate TCA_TAPRIO_ATTR_FLAGS through policy instead of open-coding
      tools: ynl: correct typo and docstring
      doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
      tools: ynl: add support for encoding multi-attr

Alex Elder (20):
      net: ipa: stash modem TX and RX endpoints
      net: ipa: begin simplifying TX queue stop
      net: ipa: kill the STARTED IPA power flag
      net: ipa: kill the IPA power STOPPED flag
      net: ipa: kill ipa_power_modem_queue_stop()
      net: ipa: kill ipa_power_modem_queue_active()
      net: ipa: kill ipa_power_modem_queue_wake()
      net: ipa: don't bother aborting system resume
      net: ipa: kill IPA_POWER_FLAG_SYSTEM
      net: ipa: kill the IPA_POWER_FLAG_RESUMED flag
      net: ipa: move ipa_interrupt_suspend_clear_all() up
      net: ipa: kill ipa_power_suspend_handler()
      net: ipa: don't bother zeroing an already zero register
      net: ipa: change ipa_interrupt_config() prototype
      net: ipa: introduce ipa_interrupt_init()
      net: ipa: pass a platform device to ipa_reg_init()
      net: ipa: pass a platform device to ipa_mem_init()
      net: ipa: pass a platform device to ipa_smp2p_irq_init()
      net: ipa: pass a platform device to ipa_smp2p_init()
      net: ipa: don't save the platform device

Alex Henrie (3):
      net: ipv6/addrconf: ensure that regen_advance is at least 2 seconds
      net: ipv6/addrconf: introduce a regen_min_advance sysctl
      net: ipv6/addrconf: clamp preferred_lft to the minimum required

Alexander Gordeev (2):
      net/iucv: fix virtual vs physical address confusion
      net/af_iucv: fix virtual vs physical address confusion

Alexander Lobakin (2):
      page_pool: disable direct recycling based on pool->cpuid on destroy
      bnxt_en: fix accessing vnic_info before allocating it

Alexander Stein (1):
      net: phy: dp83867: Add support for active-low LEDs

Alexei Starovoitov (42):
      Merge branch 'bpf-inline-bpf_kptr_xchg'
      bpf: Minor improvements for bpf_cmp.
      Merge branch 'enable-the-inline-of-kptr_xchg-for-arm64'
      Merge branch 'bpf-add-cookies-retrieval-for-perf-kprobe-multi-links'
      Merge branch 'trusted-ptr_to_btf_id-arg-support-in-global-subprogs'
      Merge branch 'annotate-kfuncs-in-btf_ids-section'
      Merge branch 'two-small-fixes-for-global-subprog-tagging'
      Merge branch 'enable-static-subprog-calls-in-spin-lock-critical-sections'
      Merge branch 'transfer-rcu-lock-state-across-subprog-calls'
      Merge branch 'xsk-support-redirect-to-any-socket-bound-to-the-same-umem'
      Merge branch 'fix-global-subprog-ptr_to_ctx-arg-handling'
      selftests/bpf: Remove intermediate test files.
      bpf: Shrink size of struct bpf_map/bpf_array.
      Merge branch 'selftests-bpf-reduce-tcp_custom_syncookie-verification-complexity'
      Merge branch 'bpf-arm64-support-exceptions'
      Merge branch 'bpf-arm64-use-bpf-prog-pack-allocator-in-bpf-jit'
      mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
      mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
      bpf: Introduce may_goto instruction
      bpf: Recognize that two registers are safe when their ranges match
      bpf: Add cond_break macro
      selftests/bpf: Test may_goto
      bpf: Allow kfuncs return 'void *'
      bpf: Recognize '__map' suffix in kfunc arguments
      bpf: Plumb get_unmapped_area() callback into bpf_map_ops
      libbpf: Allow specifying 64-bit integers in map BTF.
      bpf: Tell bpf programs kernel's PAGE_SIZE
      Merge branch 'fix-hash-bucket-overflow-checks-for-32-bit-arches'
      mm: Introduce vmap_page_range() to map pages in PCI address space
      bpf: Introduce bpf_arena.
      bpf: Disasm support for addr_space_cast instruction.
      bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.
      bpf: Add x86-64 JIT support for bpf_addr_space_cast instruction.
      bpf: Recognize addr_space_cast instruction in the verifier.
      bpf: Recognize btf_decl_tag("arg: Arena") as PTR_TO_ARENA.
      libbpf: Add __arg_arena to bpf_helpers.h
      libbpf: Add support for bpf_arena.
      bpftool: Recognize arena map type
      bpf: Add helper macro bpf_addr_space_cast()
      selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
      selftests/bpf: Add bpf_arena_list test.
      selftests/bpf: Add bpf_arena_htab test.

Alexey Berezhok (2):
      wifi: brcmfmac: do not cast hidden SSID attribute value to boolean
      wifi: brcmfmac: do not pass hidden SSID attribute as value directly

Alexey Kodanev (2):
      iavf: drop duplicate iavf_{add|del}_cloud_filter() calls
      i40e: remove unnecessary qv_info ptr NULL checks

Alexis Lothoré (9):
      wifi: wilc1000: fix declarations ordering
      wifi: wilc1000: fix RCU usage in connect path
      wifi: wilc1000: prevent use-after-free on vif when cleaning up all interfaces
      wifi: wilc1000: split deeply nested RCU list traversal in dedicated helper
      wifi: wilc1000: use SRCU instead of RCU for vif list traversal
      wifi: wilc1000: fix declarations ordering
      wifi: nl80211: force WLAN_AKM_SUITE_SAE in big endian in NL80211_CMD_EXTERNAL_AUTH
      wifi: wilc1000: remove AKM suite be32 conversion for external auth request
      wifi: wilc1000: revert reset line logic flip

Amit Cohen (7):
      mlxsw: spectrum: Change mlxsw_sp_upper to LAG structure
      mlxsw: spectrum: Remove mlxsw_sp_lag_get()
      mlxsw: spectrum: Query max_lag once
      mlxsw: spectrum: Search for free LAD ID once
      mlxsw: spectrum: Refactor LAG create and destroy code
      mlxsw: Use refcount_t for reference counting
      net: Do not return value from init_dummy_netdev()

Andre Werner (2):
      net: phy: phy_device: Prevent nullptr exceptions on ISR
      net: phy: adin1100: Add interrupt support for link change

Andrei Otcheretianski (1):
      wifi: mac80211_hwsim: Add 160MHz bw range to regdom_custom_04

Andrew Lunn (17):
      net: phy: c45 scanning: Don't consider -ENODEV fatal
      net: dsa: mv88e6xxx: Return -ENODEV when C45 not supported
      net: usb: r8152: Use linkmode helpers for EEE
      net: usb: ax88179_178a: Use linkmode helpers for EEE
      net: qlogic: qede: Use linkmode helpers for EEE
      net: ethernet: ixgbe: Convert EEE to use linkmodes
      net: intel: i40e/igc: Remove setting Autoneg in EEE capabilities
      net: intel: e1000e: Use linkmode helpers for EEE
      net: intel: igb: Use linkmode helpers for EEE
      net: intel: igc: Use linkmode helpers for EEE
      net: ethtool: eee: Remove legacy _u32 from keee
      net: phy: Add phydev->enable_tx_lpi to simplify adjust link callbacks
      net: phy: Keep track of EEE configuration
      net: phy: Immediately call adjust_link if only tx_lpi_enabled changes
      net: phy: Add phy_support_eee() indicating MAC support EEE
      net: fec: Move fec_enet_eee_mode_set() and helper earlier
      net: fec: Fixup EEE

Andrey Grafin (2):
      libbpf: Apply map_set_def_max_entries() for inner_maps on creation
      selftest/bpf: Add map_in_maps with BPF_MAP_TYPE_PERF_EVENT_ARRAY values

Andrey Skvortsov (2):
      Bluetooth: hci_h5: Add ability to allocate memory for private data
      Bluetooth: btrtl: fix out of bounds memory access

Andrii Nakryiko (77):
      selftests/bpf: fix test_loader check message
      bpf: make sure scalar args don't accept __arg_nonnull tag
      bpf: prepare btf_prepare_func_args() for multiple tags per argument
      bpf: support multiple tags per argument
      selftests/bpf: detect testing prog flags support
      libbpf: call dup2() syscall directly
      Merge branch 'skip-callback-tests-if-jit-is-disabled-in-test_verifier'
      bpf: Align CAP_NET_ADMIN checks with bpf_capable() approach
      bpf: Add BPF token delegation mount options to BPF FS
      bpf: Introduce BPF token object
      bpf: Add BPF token support to BPF_MAP_CREATE command
      bpf: Add BPF token support to BPF_BTF_LOAD command
      bpf: Add BPF token support to BPF_PROG_LOAD command
      bpf: Take into account BPF token when fetching helper protos
      bpf: Consistently use BPF token throughout BPF verifier logic
      bpf,lsm: Refactor bpf_prog_alloc/bpf_prog_free LSM hooks
      bpf,lsm: Refactor bpf_map_alloc/bpf_map_free LSM hooks
      bpf,lsm: Add BPF token LSM hooks
      libbpf: Add bpf_token_create() API
      libbpf: Add BPF token support to bpf_map_create() API
      libbpf: Add BPF token support to bpf_btf_load() API
      libbpf: Add BPF token support to bpf_prog_load() API
      selftests/bpf: Add BPF token-enabled tests
      bpf,selinux: Allocate bpf_security_struct per BPF token
      bpf: Fail BPF_TOKEN_CREATE if no delegation option was set on BPF FS
      bpf: Support symbolic BPF FS delegation mount options
      selftests/bpf: Utilize string values for delegate_xxx mount options
      libbpf: Split feature detectors definitions from cached results
      libbpf: Further decouple feature checking logic from bpf_object
      libbpf: Move feature detection code into its own file
      libbpf: Wire up token_fd into feature probing logic
      libbpf: Wire up BPF token support at BPF object level
      selftests/bpf: Add BPF object loading tests with explicit token passing
      selftests/bpf: Add tests for BPF object load with implicit token
      libbpf: Support BPF token path setting through LIBBPF_BPF_TOKEN_PATH envvar
      selftests/bpf: Add tests for LIBBPF_BPF_TOKEN_PATH envvar
      selftests/bpf: Incorporate LSM policy to token-based tests
      Merge branch 'bpf-token'
      libbpf: Fix faccessat() usage on Android
      libbpf: integrate __arg_ctx feature detector into kernel_supports()
      libbpf: fix __arg_ctx type enforcement for perf_event programs
      bpf: move arg:ctx type enforcement check inside the main logic loop
      bpf: add __arg_trusted global func arg tag
      bpf: add arg:nullable tag to be combined with trusted pointers
      libbpf: add __arg_trusted and __arg_nullable tag macros
      selftests/bpf: add trusted global subprog arg tests
      libbpf: add bpf_core_cast() macro
      selftests/bpf: convert bpf_rdonly_cast() uses to bpf_core_cast() macro
      libbpf: Call memfd_create() syscall directly
      libbpf: Add missing LIBBPF_API annotation to libbpf_set_memlock_rlim API
      libbpf: Add btf__new_split() API that was declared but not implemented
      libbpf: Add missed btf_ext__raw_data() API
      selftests/bpf: Fix bench runner SIGSEGV
      Merge branch 'improvements-for-tracking-scalars-in-the-bpf-verifier'
      bpf: handle trusted PTR_TO_BTF_ID_OR_NULL in argument check logic
      selftests/bpf: add more cases for __arg_trusted __arg_nullable args
      bpf: don't emit warnings intended for global subprogs for static subprogs
      libbpf: fix return value for PERF_EVENT __arg_ctx type fix up check
      selftests/bpf: mark dynptr kfuncs __weak to make them optional on old kernels
      Merge branch 'tools-resolve_btfids-fix-cross-compilation-to-non-host-endianness'
      bpf: simplify btf_get_prog_ctx_type() into btf_is_prog_ctx_type()
      bpf: handle bpf_user_pt_regs_t typedef explicitly for PTR_TO_CTX global arg
      bpf: don't infer PTR_TO_CTX for programs with unnamed context type
      selftests/bpf: add anonymous user struct as global subprog arg test
      bpf: emit source code file name and line number in verifier log
      bpf: Use O(log(N)) binary search to find line info record
      bpf: improve duplicate source code line detection
      Merge branch 'create-shadow-types-for-struct_ops-maps-in-skeletons'
      selftests/bpf: Extend uprobe/uretprobe triggering benchmarks
      Merge branch 'mm-enforce-ioremap-address-space-and-introduce-sparse-vm_area'
      Merge branch 'bpf-introduce-may_goto-and-cond_break'
      Merge branch 'libbpf-type-suffixes-and-autocreate-flag-for-struct_ops-maps'
      bpftool: rename is_internal_mmapable_map into is_mmapable_map
      selftests/bpf: Add fexit and kretprobe triggering benchmarks
      libbpf: Recognize __arena global variables.
      Merge branch 'bpf-introduce-bpf-arena'
      bpf: move sleepable flag from bpf_prog_aux to bpf_prog

Andy Shevchenko (6):
      wifi: cfg80211: Add KHZ_PER_GHZ to units.h and reuse
      ieee802154: at86rf230: Replace of_gpio.h by proper one
      ieee802154: mcr20a: Remove unused of_gpio.h
      lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
      net: mdio_bus: Remove unused of_gpio.h
      net: phy: marvell-88x2222: Remove unused of_gpio.h

Aniruddha Paul (1):
      ice: Add a new counter for Rx EIPE errors

Anjaneyulu (1):
      wifi: iwlwifi: Add support for PPAG cmd v5 and PPAG revision 3

Ankit Garg (1):
      gve: Modify rx_buf_alloc_fail counter centrally and closer to failure

Antony Antony (1):
      xfrm: introduce forwarding of ICMP Error messages

Arend van Spriel (7):
      wifi: brcmfmac: export firmware interface functions
      wifi: brcmfmac: add per-vendor feature detection callback
      wifi: brcmfmac: move feature overrides before feature_disable
      wifi: brcmfmac: avoid invalid list operation when vendor attach fails
      wifi: brcmfmac: allow per-vendor event handling
      wifi: brcmfmac: add linefeed at end of file
      wifi: brcmfmac: fix copyright year mentioned in platform_data header

Arnaldo Carvalho de Melo (1):
      bpftool: Be more portable by using POSIX's basename()

Arnd Bergmann (3):
      wifi: iwlwifi: fix #ifdef CONFIG_ACPI check
      wifi: brcmsmac: avoid function pointer casts
      igc: fix LEDS_CLASS dependency

Arseniy Krasnov (2):
      vsock/test: add '--peer-port' input argument
      vsock/test: print type for SOCK_SEQPACKET

Artem Chernyshev (1):
      wifi: brcmsmac: phy: Remove unreachable code

Artem Savkov (1):
      selftests/bpf: Fix potential premature unload in bpf_testmod

Arınç ÜNAL (26):
      net: dsa: mt7530: support OF-based registration of switch MDIO bus
      net: dsa: mt7530: select MEDIATEK_GE_PHY for NET_DSA_MT7530_MDIO
      net: dsa: mt7530: always trap frames to active CPU port on MT7530
      net: dsa: mt7530: use p5_interface_select as data type for p5_intf_sel
      net: dsa: mt7530: store port 5 SGMII capability of MT7531
      net: dsa: mt7530: improve comments regarding switch ports
      net: dsa: mt7530: improve code path for setting up port 5
      net: dsa: mt7530: do not set priv->p5_interface on mt7530_setup_port5()
      net: dsa: mt7530: do not run mt7530_setup_port5() if port 5 is disabled
      net: dsa: mt7530: empty default case on mt7530_setup_port5()
      net: dsa: mt7530: move XTAL check to mt7530_setup()
      net: dsa: mt7530: simplify mt7530_pad_clk_setup()
      net: dsa: mt7530: call port 6 setup from mt7530_mac_config()
      net: dsa: mt7530: remove pad_setup function pointer
      net: dsa: mt7530: correct port capabilities of MT7988
      net: dsa: mt7530: do not clear config->supported_interfaces
      net: dsa: remove OF-based MDIO bus registration from DSA core
      net: dsa: mt7530: remove .mac_port_config for MT7988 and make it optional
      net: dsa: mt7530: set interrupt register only for MT7530
      net: dsa: mt7530: do not use SW_PHY_RST to reset MT7531 switch
      net: dsa: mt7530: get rid of useless error returns on phylink code path
      net: dsa: mt7530: get rid of priv->info->cpu_port_config()
      net: dsa: mt7530: get rid of mt753x_mac_config()
      net: dsa: mt7530: put initialising PCS devices code back to original order
      net: dsa: mt7530: sort link settings ops and force link down on all ports
      net: dsa: mt7530: simplify link operations

Avraham Stern (1):
      wifi: iwlwifi: mvm: advertise support for protected ranging negotiation

Ayala Beker (7):
      wifi: ieee80211: add definitions for negotiated TID to Link map
      wifi: mac80211: process and save negotiated TID to Link mapping request
      wifi: mac80211_hwsim: handle TID to link mapping neg request
      wifi: mac80211_hwsim: handle BSS_CHANGED_MLD_TTLM
      wifi: mac80211: add support for negotiated TTLM request
      wifi: iwlwifi: mvm: add support for TID to link mapping neg request
      wifi: iwlwifi: mvm: use fast balance scan in case of an active P2P GO

Baochen Qiang (21):
      wifi: ath12k: support default regdb while searching board-2.bin for WCN7850
      wifi: ath11k: fix a possible dead lock caused by ab->base_lock
      wifi: ath12k: fix wrong definitions of hal_reo_update_rx_queue
      wifi: ath12k: add support for BA1024
      wifi: ath12k: change MAC buffer ring size to 2048
      wifi: ath12k: add support for collecting firmware log
      wifi: ath11k: enable 36 bit mask for stream DMA
      wifi: ath11k: remove invalid peer create logic
      wifi: ath11k: rename ath11k_start_vdev_delay()
      wifi: ath11k: avoid forward declaration of ath11k_mac_start_vdev_delay()
      wifi: ath11k: fix connection failure due to unexpected peer delete
      wifi: ath12k: enable 802.11 power save mode in station mode
      wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before use
      wifi: ath11k: initialize eirp_power before use
      wifi: ath11k: move pci.ops registration ahead
      wifi: ath11k: add support for QCA2066
      wifi: ath11k: rearrange IRQ enable/disable in reset path
      wifi: ath11k: remove MHI LOOPBACK channels
      wifi: ath11k: do not dump SRNG statistics during resume
      wifi: ath11k: fix warning on DMA ring capabilities event
      wifi: ath11k: decrease MHI channel buffer length to 8KB

Bartosz Golaszewski (1):
      Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()

Benjamin Berg (7):
      wifi: cfg80211: add RNR with reporting AP information
      wifi: mac80211: use deflink and fix typo in link ID check
      wifi: iwlwifi: skip affinity setting on non-SMP
      wifi: cfg80211: add a kunit test for 6 GHz colocated AP parsing
      wifi: cfg80211: tests: verify BSS use flags of NSTR links
      wifi: cfg80211: set correct param change count in ML element
      wifi: iwlwifi: mvm: unlock mvm if there is no primary link

Benjamin Lin (3):
      wifi: mt76: mt7996: fix incorrect interpretation of EHT MCS caps
      wifi: mt76: mt7996: ensure 4-byte alignment for beacon commands
      wifi: mt76: mt7996: fix HIF_TXD_V2_1 value

Benjamin Poirier (5):
      selftests: Introduce Makefile variable to list shared bash scripts
      selftests: bonding: Add net/forwarding/lib.sh to TEST_INCLUDES
      selftests: team: Add shared library scripts to TEST_INCLUDES
      selftests: dsa: Replace test symlinks by wrapper script
      selftests: forwarding: Redefine relative_path variable

Benjamin Tissoires (3):
      bpf: allow more maps in sleepable bpf programs
      bpf: introduce in_sleepable() helper
      bpf: add is_async_callback_calling_insn() helper

Biju Das (2):
      ravb: Add Rx checksum offload support for GbEth
      ravb: Add Tx checksum offload support for GbEth

Bitterblue Smith (13):
      wifi: rtl8xxxu: Fix LED control code of RTL8192FU
      wifi: rtl8xxxu: Fix off by one initial RTS rate
      wifi: rtlwifi: rtl_usb: Use sync register writes
      wifi: rtlwifi: rtl8192de: Don't read register in _rtl92de_query_rxphystatus
      wifi: rtlwifi: Speed up firmware loading for USB
      wifi: rtlwifi: rtl8192cu: Fix 2T2R chip type detection
      wifi: rtlwifi: rtl_usb: Store the endpoint addresses
      wifi: rtlwifi: rtl8192cu: Fix TX aggregation
      wifi: rtw88: 8821cu: Fix firmware upload fail
      wifi: rtw88: 8821cu: Fix connection failure
      wifi: rtw88: 8821c: Fix beacon loss and disconnect
      wifi: rtw88: 8821c: Fix false alarm count
      wifi: rtlwifi: Remove rtl_intf_ops.read_efuse_byte

Bo Liu (4):
      net: encx24j600: convert to use maple tree register cache
      net: ieee802154: at86rf230: convert to use maple tree register cache
      net: ieee802154: mcr20a: convert to use maple tree register cache
      net: ieee802154: mrf24j40: convert to use maple tree register cache

Brad Cowie (1):
      selftests: openvswitch: Test ICMP related matches work with SNAT

Breno Leitao (44):
      net/ipv6: Remove unnecessary pr_debug() logs
      net/ipv6: resolve warning in ip6_fib.c
      net: fill in MODULE_DESCRIPTION()s for encx24j600
      net: fill in MODULE_DESCRIPTION()s for ocelot
      net: fill in MODULE_DESCRIPTION()s for SMSC drivers
      net: fill in MODULE_DESCRIPTION()s for Qualcom drivers
      net: fill in MODULE_DESCRIPTION()s for dwmac-socfpga
      net: fill in MODULE_DESCRIPTION()s for cpsw-common
      net: fill in MODULE_DESCRIPTION()s for ec_bhf
      net: fill in MODULE_DESCRIPTION()s for PCS drivers
      net: fill in MODULE_DESCRIPTION()s for ieee802154
      net: fill in MODULE_DESCRIPTION()s for arcnet
      net: blackhole_dev: fix build warning for ethh set but not used
      net: ocelot: update the MODULE_DESCRIPTION()
      net: bql: allow the config to be disabled
      net: sysfs: Do not create sysfs for non BQL device
      net/dummy: Move stats allocation to core
      ipv6/sit: Do not allocate stats in the driver
      net/vsockmon: Leverage core stats allocator
      net/vsockmon: Do not set zeroed statistics
      xfrm: Do not allocate stats in the driver
      net: bridge: Do not allocate stats in the driver
      net: bridge: Exit if multicast_init_stats fails
      net: get stats64 if device if driver is configured
      net: sit: Do not set .ndo_get_stats64
      net: bareudp: Do not allocate stats in the driver
      net: bareudp: Remove generic .ndo_get_stats64
      net: ip6_tunnel: Leverage core stats allocator
      net: nlmon: Remove init and uninit functions
      net: nlmon: Simplify nlmon_get_stats64
      net: tuntap: Leverage core stats allocator
      net: tap: Remove generic .ndo_get_stats64
      net: macsec: Leverage core stats allocator
      net: gtp: Leverage core stats allocator
      net: gtp: Remove generic .ndo_get_stats64
      net: gtp: Move net_device assigned in setup
      net: geneve: Leverage core stats allocator
      net: geneve: Remove generic .ndo_get_stats64
      net: usbnet: Leverage core stats allocator
      net: usbnet: Remove generic .ndo_get_stats64
      net: amt: Move stats allocation to core
      net: amt: Remove generic .ndo_get_stats64
      vxlan: Do not alloc tstats manually
      vxlan: Remove generic .ndo_get_stats64

Brett Creeley (14):
      pds_core: Don't assign interrupt index/bound_intr to notifyq
      pds_core: Unmask adminq interrupt in work thread
      pds_core: Fix up some minor issues
      pds_core: Clean up init/uninit flows to be more readable
      ionic: Rework Tx start/stop flow
      ionic: Change default number of descriptors for Tx and Rx
      ionic: Shorten a Tx hotpath
      ionic: Make use napi_consume_skb
      ionic: Clean up BQL logic
      ionic: Check stop no restart
      ionic: Pass local netdev instead of referencing struct
      ionic: change the hwstamp likely check
      ionic: Use CQE profile for dim
      ionic: Clean RCT ordering issues

Carl Huang (2):
      wifi: ath11k: support 2 station interfaces
      wifi: ath11k: provide address list if chip supports 2 stations

Carolina Jubran (2):
      net/mlx5e: XSK, Exclude tailroom from non-linear SKBs memory calculations
      net/mlx5e: XDP, Exclude headroom and tailroom from memory calculations

Catalin Popescu (3):
      dt-bindings: net: dp83826: support TX data voltage tuning
      net: phy: dp83826: support TX data voltage tuning
      net: phy: dp83826: disable WOL at init

Chen Ni (1):
      sr9800: Add check for usbnet_get_endpoints

Chen Shen (1):
      libbpf: Correct debug message in btf__load_vmlinux_btf

Cheng-Chieh Hsieh (1):
      wifi: rtw89: 8922a: update the register used in DIG and the DIG flow

Chengming Zhou (1):
      net: remove SLAB_MEM_SPREAD flag usage

Chih-Kang Chang (3):
      wifi: rtw89: fix HW scan timeout due to TSF sync issue
      wifi: rtw89: fix disabling concurrent mode TX hang issue
      wifi: rtw89: 8922a: implement AP mode related reg for BE generation

Chin-Yen Lee (11):
      wifi: rtw89: pci: use DBI function for 8852AE/8852BE/8851BE
      wifi: rtw89: add new H2C for PS mode in 802.11be chip
      wifi: rtw89: update ps_state register for chips with different generation
      wifi: rtw89: pci: implement PCI CLK/ASPM/L1SS for WiFi 7 chips
      wifi: rtw89: wow: update WoWLAN reason register for different chips
      wifi: rtw89: wow: update WoWLAN status register for different generation
      wifi: rtw89: update DMA function with different generation
      wifi: rtw89: wow: update config mac function with different generation
      wifi: rtw89: update suspend/resume for different generation
      wifi: rtw89: wow: set security engine options for 802.11ax chips only
      wifi: rtw89: wow: move release offload packet earlier for WoWLAN mode

Ching-Te Ku (6):
      wifi: rtw89: coex: add init_info H2C command format version 7
      wifi: rtw89: coex: add BTC ctrl_info version 7 and related logic
      wifi: rtw89: coex: Reorder H2C command index to align with firmware
      wifi: rtw89: coex: add return value to ensure H2C command is success or not
      wifi: rtw89: coex: When Bluetooth not available don't set power/gain
      wifi: rtw89: coex: Add coexistence policy to decrease WiFi packet CRC-ERR

Christian Marangi (26):
      dt-bindings: net: phy: Make LED active-low property common
      dt-bindings: net: phy: Document LED inactive high impedance mode
      net: phy: add support for PHY LEDs polarity modes
      dt-bindings: net: Document QCA808x PHYs
      net: phy: at803x: add LED support for qca808x
      net: phy: move at803x PHY driver to dedicated directory
      net: phy: qcom: create and move functions to shared library
      net: phy: qcom: deatch qca83xx PHY driver from at803x
      net: phy: qcom: move additional functions to shared library
      net: phy: qcom: detach qca808x PHY driver from at803x
      dt-bindings: net: ipq4019-mdio: document now supported clock-frequency
      net: mdio: ipq4019: add support for clock-frequency property
      net: phy: qcom: qca808x: fix logic error in LED brightness set
      net: phy: qcom: qca808x: default to LED active High if not set
      dt-bindings: net: document ethernet PHY package nodes
      net: phy: add support for scanning PHY in PHY packages nodes
      net: phy: add devm/of_phy_package_join helper
      net: phy: qcom: move more function to shared library
      dt-bindings: net: Document Qcom QCA807x PHY package
      net: phy: provide whether link has changed in c37_read_status
      net: phy: qcom: move common qca808x LED define to shared header
      net: phy: qcom: generalize some qca808x LED functions
      net: phy: qca807x: add support for configurable LED
      net: phy: aquantia: add AQR111 and AQR111B0 PHY ID
      net: phy: aquantia: add AQR113 PHY ID
      net: phy: aquantia: add AQR813 PHY ID

Christoph Paasch (1):
      mpls: Do not orphan the skb

Christophe JAILLET (6):
      xdp: Remove usage of the deprecated ida_simple_xx() API
      nfc: hci: Introduce nfc_llc_del_engine() to reduce code duplication
      nfc: hci: Save a few bytes of memory when registering a 'nfc_llc' engine
      Bluetooth: Remove usage of the deprecated ida_simple_xx() API
      Bluetooth: btbcm: Use strreplace()
      Bluetooth: btbcm: Use devm_kstrdup()

Chun Qiu (1):
      wifi: rtl8xxxu: Add TP-Link TL-WN823N V2

Chung-Hsuan Hung (3):
      wifi: rtw89: phy: add parser to support RX gain dynamic setting flow
      wifi: rtw89: 8922a: set RX gain along with set_channel operation
      wifi: rtw89: 8922a: add BTG functions to assist BT coexistence to control TX/RX

Ciprian Regus (1):
      net: ethernet: adi: adin1110: Reduce the MDIO_TRDONE poll interval

Claudiu Beznea (21):
      net: ravb: Let IP-specific receive function to interrogate descriptors
      net: ravb: Rely on PM domain to enable gptp_clk
      net: ravb: Make reset controller support mandatory
      net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
      net: ravb: Use tabs instead of spaces
      net: ravb: Assert/de-assert reset on suspend/resume
      net: ravb: Move reference clock enable/disable on runtime PM APIs
      net: ravb: Move getting/requesting IRQs in the probe() method
      net: ravb: Split GTI computation and set operations
      net: ravb: Move delay mode set in the driver's ndo_open API
      net: ravb: Move DBAT configuration to the driver's ndo_open API
      net: ravb: Move PTP initialization in the driver's ndo_open API for ccc_gac platorms
      net: ravb: Set config mode in ndo_open and reset mode in ndo_close
      net: ravb: Simplify ravb_suspend()
      net: ravb: Simplify ravb_resume()
      net: ravb: Get rid of the temporary variable irq
      net: ravb: Keep the reverse order of operations in ravb_close()
      net: ravb: Return cached statistics if the interface is down
      net: ravb: Move the update of ndev->features to ravb_set_features()
      net: ravb: Do not apply features to hardware if the interface is down
      net: ravb: Add runtime PM support

Colin Ian King (13):
      wifi: rtw89: mac: Fix spelling mistakes "notfify" -> "notify"
      wifi: ath9k:  remove redundant assignment to variable ret
      wifi: iwlwifi: Fix spelling mistake "SESION" -> "SESSION"
      xirc2ps_cs: remove redundant assignment to variable okay, clean up freespace
      qed: remove duplicated assignment to variable opaque_fid
      netxen_nic: remove redundant assignment to variable capability
      wifi: carl9170: Remove redundant assignment to pointer super
      net: tcp: Remove redundant initialization of variable len
      wifi: mac80211: clean up assignments to pointer cache.
      wifi: mt76: Remove redundant assignment to variable tidno
      net: microchip: lan743x: Fix spelling mistake "erro" -> "error"
      net: chelsio: remove unused function calc_tx_descs
      tools: ynl: Fix spelling mistake "Constructred" -> "Constructed"

Conor Dooley (1):
      dt-bindings: leds: pwm-multicolour: re-allow active-low

Cristian Ciocaltea (2):
      dt-bindings: net: starfive,jh7110-dwmac: Add JH7100 SoC compatible
      net: stmmac: dwmac-starfive: Add support for JH7100 SoC

Csókás Bence (2):
      net: fec: Refactor: #define magic constants
      net: fec: Refactor: Replace FEC_ENET_FCE with FEC_RCR_FLOWCTL

Cupertino Miranda (1):
      libbpf: Add support to GCC in CORE macro definitions

Dacio Romero (1):
      wifi: mt76: mt76x2u: add netgear wdna3100v3 to device table

Dan Carpenter (3):
      wifi: rtl8xxxu: fix error messages
      wifi: iwlwifi: return negative -EINVAL instead of positive EINVAL
      Bluetooth: ISO: Clean up returns values in iso_connect_ind()

Daniel Amosi (1):
      wifi: iwlwifi: mvm: Keep connection in case of missed beacons during RX

Daniel Borkmann (1):
      bpf: Sync uapi bpf.h header for the tooling infra

Daniel Gabay (1):
      wifi: iwlwifi: mvm: log dropped packets due to MIC error

Daniel Xu (4):
      bpf: btf: Support flags for BTF_SET8 sets
      bpf: btf: Add BTF_KFUNCS_START/END macro pair
      bpf: treewide: Annotate BPF kfuncs in BTF
      bpf: Have bpf_rdonly_cast() take a const pointer

Daniil Dulov (1):
      can: softing: remove redundant NULL check

Dave Thaler (11):
      Introduce concept of conformance groups
      bpf, docs: Clarify that MOVSX is only for BPF_X not BPF_K
      bpf, docs: Clarify definitions of various instructions
      bpf, docs: Clarify which legacy packet instructions existed
      bpf, docs: Expand set of initial conformance groups
      bpf, docs: Fix typos in instructions-set.rst
      bpf, docs: Update ISA document title
      bpf, docs: Fix typos in instruction-set.rst
      bpf, docs: specify which BPF_ABS and BPF_IND fields were zero
      bpf, docs: Use IETF format for field definitions in instruction-set.rst
      bpf, docs: Rename legacy conformance group to packet

David Ahern (4):
      selftest: Update PATH for nettest in fcnal-test
      selftest: Fix set of ping_group_range in fcnal-test
      selftest: Show expected and actual return codes for test failures in fcnal-test
      selftests: Declare local variable for pause in fcnal-test.sh

David Arinzon (11):
      net: ena: Remove an unused field
      net: ena: Add more documentation for RX copybreak
      net: ena: Minor cosmetic changes
      net: ena: Enable DIM by default
      net: ena: Remove CQ tail pointer update
      net: ena: Change error print during ena_device_init()
      net: ena: Add more information on TX timeouts
      net: ena: Relocate skb_tx_timestamp() to improve time stamping accuracy
      net: ena: Change default print level for netif_ prints
      net: ena: handle ena_calc_io_queue_size() possible errors
      net: ena: Reduce lines with longer column width boundary

David Howells (21):
      rxrpc: Record the Tx serial in the rxrpc_txbuf and retransmit trace
      rxrpc: Convert rxrpc_txbuf::flags into a mask and don't use atomics
      rxrpc: Note cksum in txbuf
      rxrpc: Fix the names of the fields in the ACK trailer struct
      rxrpc: Strip barriers and atomics off of timer tracking
      rxrpc: Remove atomic handling on some fields only used in I/O thread
      rxrpc: Do lazy DF flag resetting
      rxrpc: Merge together DF/non-DF branches of data Tx function
      rxrpc: Add a kvec[] to the rxrpc_txbuf struct
      rxrpc: Split up the DATA packet transmission function
      rxrpc: Don't pick values out of the wire header when setting up security
      rxrpc: Move rxrpc_send_ACK() to output.c with rxrpc_send_ack_packet()
      rxrpc: Use rxrpc_txbuf::kvec[0] instead of rxrpc_txbuf::wire
      rxrpc: Do zerocopy using MSG_SPLICE_PAGES and page frags
      rxrpc: Parse received packets before dealing with timeouts
      rxrpc: Don't permit resending after all Tx packets acked
      rxrpc: Differentiate PING ACK transmission traces.
      rxrpc: Use ktimes for call timeout tracking and set the timer lazily
      rxrpc: Record probes after transmission and reduce number of time-gets
      rxrpc: Clean up the resend algorithm
      rxrpc: Extract useful fields from a received ACK to skb priv data

David Lechner (1):
      wifi: wilc1000: remove setting msg.spi

David Mosberger-Tang (2):
      wifi: wilc1000: correct CRC7 calculation
      wifi: wilc1000: validate chip id during bus probe

David S. Miller (71):
      Merge branch 'txgbe-irq_domain'
      Merge branch 'net-module-description'
      Merge branch 'stmmac-jh7100'
      Merge branch 'selftests-TEST_INCLUDES'
      Merge branch 'stmmac-EST'
      Merge branch 'ethtool-EEE'
      Merge branch 'qca_spi-improvements'
      Merge tag 'nf-next-24-01-29' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next Florian Westphal says:
      Merge branch 'net-ipq4019-rate'
      Merge branch 'octeontx2-af-dynamically-allocate-BPIDs'
      Merge tag 'batadv-next-pullrequest-20240201' of git://git.open-mesh.org/linux-merge
      Merge branch 'qca-phy-led-fixes'
      Merge branch 'mptcp-annotate-lockless'
      Merge branch 'qca8k-cleanup-fixes'
      Merge branch 'net-phy-c22-c45-enumeration'
      Merge branch 'netconsole-userdata-append'
      Merge branch 'wan-t7x-fastboot'
      Merge branch 'phy-package'
      Merge branch 'octeon_ep_vf'
      Merge branch 'ipv6-expired-routes'
      Merge branch 'dsa-realtek-common'
      Merge branch 'eth-common-fault-irq-support'
      Merge branch 'net-avoid-slow-rcu'
      Merge tag 'linux-can-next-for-6.9-20240213' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'per-epoll-context-busy-poll'
      Merge branch 'dev_base_lock-remove'
      Merge branch 'ravb-rutime-PM-support'
      Merge branch 'ionic-xdp-support'
      Merge branch 'net-phy-eee-2'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next -queue
      Merge branch 'pds_core-AER-handling'
      Merge branch 'net-constify-device_type'
      Merge branch 'net-kmem-cache-create'
      Merge tag 'wireless-next-2024-02-20' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'rework-genet-mdioclocking'
      Merge branch 'dp83826'
      Merge branch 'rtnetlink-reduce-rtnl-pressure'
      Merge branch 'pcs-xpcs-cleanups'
      Merge branch 'dsa-realtek-reset'
      Merge branch 'tcp-rcv-drop-reasons'
      Merge branch 'ioam6-mcast-events'
      Merge branch 'eee-linkmode-bitmaps'
      Merge branch 'ipv6-devconf-lockless'
      Merge branch 'qcom-phy-possible'
      Merge branch 'net-asp22-optimizations'
      Merge branch 'selftests-xfail'
      Merge branch 'netdevsim-link'
      Merge branch 'inet_dump_ifaddr-no-rtnl'
      Merge branch 'skb-helpers'
      Merge branch 'ionic-cleanups-and-perf-tuning'
      Merge branch 'net-gve-header-split-support'
      Merge branch 'mptcp-lowat-sockopt'
      Merge branch 'ipa-device-pointer-access'
      Merge branch 'mptcp-userspace-pm'
      Merge branch 'netlink-emsgsize'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'ravb-cleanups'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'tools-ynl-make-clean'
      Merge branch 'ynl-small-recv'
      Merge branch 'nexthop-group-stats'
      Merge tag 'ipsec-next-2024-03-06' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge branch 'ipv6-lockless-dump-addrs'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'ionic-diet'
      Merge branch 'hns3-fixes'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'qmc-hdlc'
      Merge branch 'getsockopt-parameter-validation'
      Merge branch 'tcp-wmem-data-races'

David Thompson (1):
      mlxbf_gige: add support to display pause frame counters

David Wei (6):
      netdevsim: add Makefile for selftests
      netdevsim: allow two netdevsim ports to be connected
      netdevsim: forward skbs from one connected port to another
      netdevsim: add ndo_get_iflink() implementation
      netdevsim: add selftest for forwarding skb between connected ports
      netdevsim: fix rtnetlink.sh selftest

Deren Wu (5):
      wifi: mt76: mt792xu: enable dmashdl support
      wifi: mt76: mt7925: update PCIe DMA settings
      wifi: mt76: mt7925: support temperature sensor
      wifi: mt76: mt7921e: fix use-after-free in free_irq()
      wifi: mt76: mt7925e: fix use-after-free in free_irq()

Dima Tisnek (1):
      libbpf: Correct bpf_core_read.h comment wrt bpf_core_relo struct

Dimitri Fedrau (14):
      net: phy: Add BaseT1 auto-negotiation constants
      net: phy: Support 100/1000BT1 linkmode advertisements
      net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
      net: phy: marvell-88q2xxx: fix typos
      net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
      net: phy: marvell-88q2xxx: add interrupt support for link detection
      net: phy: marvell-88q2xxx: add suspend / resume ops
      net: phy: marvell-88q2xxx: add support for temperature sensor
      net: phy: marvell-88q2xxx: add cable test support
      net: phy: marvell-88q2xxx: make mv88q2xxx_config_aneg generic
      net: phy: marvell-88q2xxx: switch to mv88q2xxx_config_aneg
      net: phy: marvell-88q2xxx: cleanup mv88q2xxx_config_init
      net: phy: marvell-88q2xxx: remove duplicated assignment of pma_extable
      net: phy: marvell-88q2xxx: move interrupt configuration

Diogo Ivo (1):
      net: ti: icssg-prueth: Remove duplicate cleanup calls in emac_ndo_stop()

Dmitry Antipov (8):
      wifi: ath11k: refactor ath11k_wmi_tlv_parse_alloc()
      wifi: ath9k: fix LNA selection in ath_ant_try_scan()
      wifi: ath12k: refactor ath12k_wmi_tlv_parse_alloc()
      wifi: rtlwifi: cleanup few rtlxxx_tx_fill_desc() routines
      wifi: rtw88: use kstrtoX_from_user() in debugfs handlers
      wifi: rt2x00: simplify rt2x00crypto_rx_insert_iv()
      wifi: wireless: avoid strlen() in cfg80211_michael_mic_failure()
      wifi: mwifiex: use kstrtoX_from_user() in debugfs handlers

Donald Hunter (19):
      tools/net/ynl: Add --output-json arg to ynl cli
      tools/net/ynl: Support sub-messages in nested attribute spaces
      doc/netlink: Describe sub-message selector resolution
      tools/net/ynl: Refactor fixed header encoding into separate method
      tools/net/ynl: Add support for encoding sub-messages
      tools/net/ynl: Encode default values for binary blobs
      tools/net/ynl: Combine struct decoding logic in ynl
      tools/net/ynl: Rename _fixed_header_size() to _struct_size()
      tools/net/ynl: Move formatted_string method out of NlAttr
      tools/net/ynl: Add support for nested structs
      doc/netlink: Describe nested structs in netlink raw docs
      tools/net/ynl: Add type info to struct members in generated docs
      doc/netlink/specs: Update the tc spec
      tools/net/ynl: Fix extack decoding for netlink-raw
      tools/net/ynl: Report netlink errors without stacktrace
      tools/net/ynl: Fix c codegen for array-nest
      tools/net/ynl: Add nest-type-value decoding
      doc/netlink: Allow empty enum-name in ynl specs
      doc/netlink/specs: Add spec for nlctrl netlink family

Duoming Zhou (2):
      wifi: brcm80211: handle pmk_op allocation failure
      nfp: flower: handle acti_netdevs allocation failure

Eduard Zingerman (22):
      bpf: make infinite loop detection in is_state_visited() exact
      selftests/bpf: check if imprecise stack spills confuse infinite loop detection
      bpf: One more maintainer for libbpf and BPF selftests
      libbpf: Remove unnecessary null check in kernel_supports()
      bpf: Handle scalar spill vs all MISC in stacksafe()
      selftests/bpf: States pruning checks for scalar vs STACK_MISC
      selftests/bpf: update tcp_custom_syncookie to use scalar packet offset
      libbpf: Allow version suffixes (___smth) for struct_ops types
      libbpf: Tie struct_ops programs to kernel BTF ids, not to local ids
      libbpf: Honor autocreate flag for struct_ops maps
      selftests/bpf: Test struct_ops map definition with type suffix
      selftests/bpf: Utility functions to capture libbpf log in test_progs
      selftests/bpf: Bad_struct_ops test
      selftests/bpf: Test autocreate behavior for struct_ops maps
      libbpf: Sync progs autoload with maps autocreate for struct_ops maps
      selftests/bpf: Verify struct_ops autoload/autocreate sync
      libbpf: Replace elf_state->st_ops_* fields with SEC_ST_OPS sec_type
      libbpf: Struct_ops in SEC("?.struct_ops") / SEC("?.struct_ops.link")
      libbpf: Rewrite btf datasec names starting from '?'
      selftests/bpf: Test case for SEC("?.struct_ops")
      bpf: Allow all printable characters in BTF DATASEC names
      selftests/bpf: Test cases for '?' in BTF names

Edward Adam Davis (1):
      Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Edwin Peer (1):
      bnxt_en: implement fully specified 5-tuple masks

Emmanuel Grumbach (9):
      wifi: iwlwifi: mvm: introduce PHY_CONTEXT_CMD_API_VER_5
      wifi: iwlwifi: mvm: disconnect station vifs if recovery failed
      wifi: iwlwifi: mvm: fix the TLC command after ADD_STA
      iwlwifi: fw: fix more kernel-doc warnings
      wifi: iwlwifi: mvm: don't send NDPs for new tx devices
      wifi: iwlwifi: mvm: don't send BT_COEX_CI command on new devices
      wifi: iwlwifi: mvm: don't support reduced tx power on ack for new devices
      wifi: iwlwifi: mvm: don't set the MFP flag for the GTK
      wifi: iwlwifi: mvm: don't send the smart fifo command if not needed

Eric Dumazet (134):
      sock_diag: annotate data-races around sock_diag_handlers[family]
      inet_diag: annotate data-races around inet_diag_table[]
      inet_diag: add module pointer to "struct inet_diag_handler"
      inet_diag: allow concurrent operations
      sock_diag: add module pointer to "struct sock_diag_handler"
      sock_diag: allow concurrent operations
      sock_diag: allow concurrent operation in sock_diag_rcv_msg()
      sock_diag: remove sock_diag_mutex
      inet_diag: skip over empty buckets
      ipv6: make addrconf_wq single threaded
      net: make dev_unreg_count global
      sctp: preserve const qualifier in sctp_sk()
      net: add exit_batch_rtnl() method
      nexthop: convert nexthop_net_exit_batch to exit_batch_rtnl method
      bareudp: use exit_batch_rtnl() method
      bonding: use exit_batch_rtnl() method
      geneve: use exit_batch_rtnl() method
      gtp: use exit_batch_rtnl() method
      ipv4: add __unregister_nexthop_notifier()
      vxlan: use exit_batch_rtnl() method
      ip6_gre: use exit_batch_rtnl() method
      ip6_tunnel: use exit_batch_rtnl() method
      ip6_vti: use exit_batch_rtnl() method
      sit: use exit_batch_rtnl() method
      ip_tunnel: use exit_batch_rtnl() method
      bridge: use exit_batch_rtnl() method
      xfrm: interface: use exit_batch_rtnl() method
      net-procfs: use xarray iterator to implement /proc/net/dev
      ethtool: do not use rtnl in ethnl_default_dumpit()
      ipv6: mcast: remove one synchronize_net() barrier in ipv6_mc_down()
      net: use synchronize_net() in dev_change_name()
      bridge: vlan: use synchronize_net() when holding RTNL
      ipv4/fib: use synchronize_net() when holding RTNL
      net: use synchronize_rcu_expedited in cleanup_net()
      netfilter: conntrack: expedite rcu in nf_conntrack_cleanup_net_list
      vlan: use xarray iterator to implement /proc/net/vlan/config
      rtnetlink: use xarray iterator to implement rtnl_dump_ifinfo()
      vlan: use netdev_lockdep_set_classes()
      net: bridge: use netdev_lockdep_set_classes()
      net: add netdev_lockdep_set_classes() to virtual drivers
      net: annotate data-races around dev->name_assign_type
      ip_tunnel: annotate data-races around t->parms.link
      dev: annotate accesses to dev->link
      net: convert dev->reg_state to u8
      net-sysfs: convert netdev_show() to RCU
      net-sysfs: use dev_addr_sem to remove races in address_show()
      net-sysfs: convert dev->operstate reads to lockless ones
      net-sysfs: convert netstat_show() to RCU
      net: remove stale mentions of dev_base_lock in comments
      net: add netdev_set_operstate() helper
      net: remove dev_base_lock from do_setlink()
      net: remove dev_base_lock from register_netdevice() and friends.
      net: remove dev_base_lock
      net: reorganize "struct sock" fields
      rtnetlink: prepare nla_put_iflink() to run under RCU
      ipv6: prepare inet6_fill_ifla6_attrs() for RCU
      ipv6: prepare inet6_fill_ifinfo() for RCU protection
      ipv6: use xarray iterator to implement inet6_dump_ifinfo()
      netlink: fix netlink_diag_dump() return value
      netlink: hold nlk->cb_mutex longer in __netlink_dump_start()
      rtnetlink: change nlk->cb_mutex role
      rtnetlink: add RTNL_FLAG_DUMP_UNLOCKED flag
      ipv6: switch inet6_dump_ifinfo() to RCU protection
      inet: allow ip_valid_fib_dump_req() to be called with RTNL or RCU
      nexthop: allow nexthop_mpath_fill_node() to be called without RTNL
      inet: switch inet_dump_fib() to RCU protection
      rtnetlink: make rtnl_fill_link_ifmap() RCU ready
      rtnetlink: provide RCU protection to rtnl_fill_prop_list()
      ipv6: anycast: complete RCU handling of struct ifacaddr6
      netlink: use kvmalloc() in netlink_alloc_large_skb()
      inet: annotate devconf data-races
      inet: do not use RTNL in inet_netconf_get_devconf()
      inet: use xa_array iterator to implement inet_netconf_dump_devconf()
      tcp: remove some holes in struct tcp_sock
      net: call skb_defer_free_flush() from __napi_busy_loop()
      inet6: expand rcu_read_lock() scope in inet6_dump_addr()
      ipv6: add ipv6_devconf_read_txrx cacheline_group
      ipv6: annotate data-races around cnf.disable_ipv6
      ipv6: addrconf_disable_ipv6() optimization
      ipv6: annotate data-races around cnf.mtu6
      ipv6: annotate data-races around cnf.hop_limit
      ipv6: annotate data-races around cnf.forwarding
      ipv6: annotate data-races in ndisc_router_discovery()
      ipv6: annotate data-races around idev->cnf.ignore_routes_with_linkdown
      ipv6: annotate data-races in rt6_probe()
      ipv6: annotate data-races around devconf->proxy_ndp
      ipv6: annotate data-races around devconf->disable_policy
      ipv6: addrconf_disable_policy() optimization
      ipv6/addrconf: annotate data-races around devconf fields (I)
      ipv6/addrconf: annotate data-races around devconf fields (II)
      ipv6: use xa_array iterator to implement inet6_netconf_dump_devconf()
      inet: annotate data-races around ifa->ifa_tstamp and ifa->ifa_cstamp
      inet: annotate data-races around ifa->ifa_valid_lft
      inet: annotate data-races around ifa->ifa_preferred_lft
      inet: annotate data-races around ifa->ifa_flags
      inet: prepare inet_base_seq() to run without RTNL
      inet: use xa_array iterator to implement inet_dump_ifaddr()
      net: adopt skb_network_offset() and similar helpers
      net: adopt skb_network_header_len() more broadly
      tcp: align tcp_sock_write_rx group
      net: gro: rename skb_gro_header_hard()
      net: gro: change skb_gro_network_header()
      net: gro: enable fast path for more cases
      tcp: gro: micro optimizations in tcp[4]_gro_complete()
      net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()
      netlink: let core handle error cases in dump operations
      net: introduce struct net_hotdata
      net: move netdev_budget and netdev_budget to net_hotdata
      net: move netdev_tstamp_prequeue into net_hotdata
      net: move ptype_all into net_hotdata
      net: move netdev_max_backlog to net_hotdata
      net: move ip_packet_offload and ipv6_packet_offload to net_hotdata
      net: move tcpv4_offload and tcpv6_offload to net_hotdata
      net: move dev_tx_weight to net_hotdata
      net: move dev_rx_weight to net_hotdata
      net: move skbuff_cache(s) to net_hotdata
      udp: move udpv4_offload and udpv6_offload to net_hotdata
      ipv6: move tcpv6_protocol and udpv6_protocol to net_hotdata
      inet: move tcp_protocol and udp_protocol to net_hotdata
      inet: move inet_ehash_secret and udp_ehash_secret into net_hotdata
      ipv6: move inet6_ehash_secret and udp6_ehash_secret into net_hotdata
      ipv6: move tcp_ipv6_hash_secret and udp_ipv6_hash_secret to net_hotdata
      net: introduce include/net/rps.h
      net: move rps_sock_flow_table to net_hotdata
      net: ip_tunnel: make sure to pull inner header in ip_tunnel_rcv()
      ipv6: make inet6_fill_ifaddr() lockless
      ipv6: make in6_dump_addrs() lockless
      ipv6: use xa_array iterator to implement inet6_dump_addr()
      ipv6: remove RTNL protection from inet6_dump_addr()
      net: add skb_data_unref() helper
      ipv6: raw: check sk->sk_rcvbuf earlier
      ipv4: raw: check sk->sk_rcvbuf earlier
      udp: no longer touch sk->sk_refcnt in early demux
      net: gro: move two declarations to include/net/gro.h

Erick Archer (2):
      wifi: iwlegacy: Use kcalloc() instead of kzalloc()
      net: wwan: t7xx: Prefer struct_size over open coded arithmetic

Ernesto Castellotti (1):
      ixgbe: Add 1000BASE-BX support

FUJITA Tomonori (2):
      rust: phy: use `srctree`-relative links
      rust: phy: use VTABLE_DEFAULT_ERROR

Fedor Pchelkin (1):
      mac802154: fix llsec key resources release in mac802154_llsec_key_del

Felix Fietkau (1):
      wifi: mt76: mt7915: fix error recovery with WED enabled

Florian Fainelli (4):
      net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses
      net: bcmgenet: Pass "main" clock down to the MDIO driver
      Revert "net: bcmgenet: Ensure MDIO unregistration has clocks enabled"
      net: dsa: Leverage core stats allocator

Florian Lehner (1):
      perf/bpf: Fix duplicate type check

Florian Westphal (12):
      netfilter: arptables: allow xtables-nft only builds
      netfilter: xtables: allow xtables-nft only builds
      netfilter: ebtables: allow xtables-nft only builds
      net: skbuff: add overflow debug check to pull/push helpers
      netfilter: xtables: fix up kconfig dependencies
      netfilter: nft_set_pipapo: constify lookup fn args where possible
      netfilter: nft_set_pipapo: do not rely on ZERO_SIZE_PTR
      netfilter: nft_set_pipapo: shrink data structures
      netfilter: nft_set_pipapo: speed up bulk element insertions
      netfilter: nft_set_pipapo: use GFP_KERNEL for insertions
      netfilter: move nf_reinject into nfnetlink_queue modules
      net: mpls: error out if inner headers are not set

Francesco Dolcini (1):
      can: m_can: remove redundant check for pm_clock_support

Frank Li (1):
      dt-bindings: net: fec: add iommus property

Frédéric Danis (1):
      Bluetooth: Fix eir name length

Gal Pressman (2):
      net/mlx5: Remove initial segmentation duplicate definitions
      net/mlx5: Change missing SyncE capability print to debug

Ganesh Babu Jothiram (1):
      wifi: ath12k: Read board id to support split-PHY QCN9274

Gavrilov Ilia (6):
      tcp: fix incorrect parameter validation in the do_tcp_getsockopt() function
      ipmr: fix incorrect parameter validation in the ip_mroute_getsockopt() function
      l2tp: fix incorrect parameter validation in the pppol2tp_getsockopt() function
      udp: fix incorrect parameter validation in the udp_lib_getsockopt() function
      net: kcm: fix incorrect parameter validation in the kcm_getsockopt) function
      net/x25: fix incorrect parameter validation in the x25_getsockopt() function

Geert Uytterhoeven (3):
      tcp: Spelling s/curcuit/circuit/
      octeon_ep_vf: Improve help text grammar
      Simplify net_dbg_ratelimited() dummy

Geetha sowjanya (2):
      octeontx2-af: Create BPIDs free pool
      octeontx2-af: Cleanup loopback device checks

Geliang Tang (47):
      selftests/bpf: Drop return in bpf_testmod_exit
      bpf, btf: Fix return value of register_btf_id_dtor_kfuncs
      bpf, btf: Add check_btf_kconfigs helper
      bpf, btf: Check btf for register_bpf_struct_ops
      selftests: mptcp: netlink: drop duplicate var ret
      selftests: mptcp: simult flows: define missing vars
      selftests: mptcp: join: change capture/checksum as bool
      selftests: mptcp: diag: change timeout_poll to 30
      mptcp: make pm_remove_addrs_and_subflows static
      mptcp: export mptcp_genl_family & mptcp_nl_fill_addr
      mptcp: implement mptcp_userspace_pm_dump_addr
      mptcp: add token for get-addr in yaml
      mptcp: dump addrs in userspace pm list
      mptcp: check userspace pm flags
      selftests: mptcp: add userspace pm subflow flag
      selftests: mptcp: add token for dump_addr
      selftests: mptcp: add mptcp_lib_check_output helper
      selftests: mptcp: dump userspace addrs list
      mptcp: add userspace_pm_lookup_addr_by_id helper
      mptcp: implement mptcp_userspace_pm_get_addr
      mptcp: get addr in userspace pm list
      selftests: mptcp: add token for get_addr
      selftests: mptcp: userspace pm get addr tests
      mptcp: drop duplicate header inclusions
      mptcp: update set_flags interfaces
      mptcp: set error messages for set_flags
      mptcp: drop lookup_by_id in lookup_addr
      selftests: mptcp: add mptcp_lib_check_tools helper
      selftests: mptcp: add local variables rndh
      selftests: mptcp: add mptcp_lib_ns_init/exit helpers
      selftests: mptcp: more operations in ns_init/exit
      selftests: mptcp: add mptcp_lib_events helper
      selftests: mptcp: print all error messages to stdout
      selftests: mptcp: connect: add dedicated port counter
      selftests: mptcp: connect: fix misaligned output
      selftests: mptcp: sockopt: print every test result
      selftests: mptcp: export TEST_COUNTER variable
      selftests: mptcp: add print_title in mptcp_lib
      selftests: mptcp: print test results with counters
      selftests: mptcp: use += operator to append strings
      selftests: mptcp: print test results with colors
      selftests: mptcp: call test_fail without argument
      selftests: mptcp: extract mptcp_lib_check_expected
      selftests: mptcp: print_test out of verify_listener_events
      selftests: mptcp: add mptcp_lib_verify_listener_events
      selftests: mptcp: declare event macros in mptcp_lib
      selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL

Gen Xu (1):
      wifi: mt76: mt792x: fix ethtool warning

George Guo (1):
      netlabel: cleanup struct netlbl_lsm_catmap

Gerhard Engleder (2):
      tsnep: Add link down PHY loopback support
      tsnep: Add helper for RX XDP_RING_NEED_WAKEUP flag

Gregory Greenman (1):
      wifi: iwlwifi: bump FW API to 87 for AX/BZ/SC devices

Grzegorz Nitka (3):
      ice: introduce new E825C devices family
      ice: Add helper function ice_is_generic_mac
      ice: add support for 3k signing DDP sections for E825C

Guillaume Nault (1):
      ipv4: Set the routing scope properly in ip_route_output_ports().

Gustavo A. R. Silva (1):
      wifi: brcmfmac: fweh: Fix boot crash on Raspberry Pi 4

Haiyue Wang (1):
      bpf,token: Use BIT_ULL() to convert the bit mask

Hamdan Igbaria (1):
      net/mlx5: DR, Change SWS usage to debug fs seq_file interface

Hangbin Liu (7):
      selftests/net/forwarding: add slowwait functions
      selftests: bonding: use tc filter to check if LACP was sent
      selftests: bonding: reduce garp_test/arp_validate test time
      selftests: bonding: use slowwait instead of hard code sleep
      selftests: bonding: make sure new active is not null
      tools: ynl-gen: support using pre-defined values in attr checks
      netlink: specs: support unterminated-ok

Hans de Goede (1):
      wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5 Pro

Hao Lan (2):
      net: hns3: add new 200G link modes for hisilicon device
      net: hns3: Disable SerDes serial loopback for HiLink H60

Hao Sun (1):
      bpf: Refactor ptr alu checking rules to allow alu explicitly

Hao Zhang (1):
      wifi: mt76: mt7925: fix mcu query command fail

Hariprasad Kelam (2):
      Octeontx2-af: Fetch MAC channel info from firmware
      Octeontx2-af: Fix an issue in firmware shared data reserved space

Harshit Mogalapalli (1):
      net: sched: Remove NET_ACT_IPT from Kconfig

Harshitha Prem (1):
      wifi: ath12k: add support for peer meta data version

Hayes Wang (1):
      r8152: fix unknown device for choose_configuration

Hector Martin (2):
      wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
      wifi: brcmfmac: Demote vendor-specific attach/detach messages to info

Heiner Kallweit (39):
      mlxsw: remove I2C_CLASS_HWMON from drivers w/o detect and address_list
      ethtool: replace struct ethtool_eee with a new struct ethtool_keee on kernel side
      ethtool: switch back from ethtool_keee to ethtool_eee for ioctl
      ethtool: adjust struct ethtool_keee to kernel needs
      ethtool: add suffix _u32 to legacy bitmap members of struct ethtool_keee
      ethtool: add linkmode bitmap support to struct ethtool_keee
      net: phy: c45: change genphy_c45_ethtool_[get|set]_eee to use EEE linkmode bitmaps
      net: phy: realtek: add support for RTL8126A-integrated 5Gbps PHY
      r8169: simplify EEE handling
      r8169: add support for RTL8126A
      net: phy: add helper phy_advertise_eee_all
      r8169: use new helper phy_advertise_eee_all
      tg3: convert EEE handling to use linkmode bitmaps
      net: phy: realtek: add 5Gbps support to rtl822x_config_aneg()
      r8169: remove setting LED default trigger, this is done by LED core now
      bnxt: convert EEE handling to use linkmode bitmaps
      r8169: improve checking for valid LED modes
      bnx2x: convert EEE handling to use linkmode bitmaps
      net: atlantic: convert EEE handling to use linkmode bitmaps
      net: phy: realtek: use generic MDIO helpers to simplify the code
      tg3: fix bug caused by uninitialized variable
      r8169: simplify code by using core-provided pcpu stats allocation
      r8169: add LED support for RTL8125/RTL8126
      r8169: add generic rtl_set_eee_txidle_timer function
      r8169: support setting the EEE tx idle timer on RTL8168h
      r8169: add support for returning tx_lpi_timer in ethtool get_eee
      net: mdio: add helpers for accessing the EEE CAP2 registers
      net: phy: add PHY_EEE_CAP2_FEATURES
      net: phy: c45: add and use genphy_c45_read_eee_cap2
      net: phy: c45: add support for EEE link partner ability 2 to genphy_c45_read_eee_lpa
      net: phy: c45: add support for MDIO_AN_EEE_ADV2
      r8169: add MODULE_FIRMWARE entry for RTL8126A
      tg3: copy only needed fields from userspace-provided EEE data
      tg3: simplify tg3_phy_autoneg_cfg
      net: phy: simplify genphy_c45_ethtool_set_eee
      ethtool: ignore unused/unreliable fields in set_eee op
      ethtool: remove ethtool_eee_use_linkmodes
      net: phy: simplify a check in phy_check_link_status
      r8169: switch to new function phy_support_eee

Herve Codina (4):
      net: wan: Add support for QMC HDLC
      MAINTAINERS: Add the Freescale QMC HDLC driver entry
      net: wan: fsl_qmc_hdlc: Add runtime timeslots changes support
      net: wan: fsl_qmc_hdlc: Add framer support

Horatiu Vultur (5):
      net: micrel: Fix set/get PHC time for lan8814
      net: lan966x: debugfs: Fix showing the port keyset
      net: micrel: Fix the frequency adjustments
      net: phy: micrel: lan8814 led errata
      net: phy: micrel: lan8814 cable improvement errata

Hou Tao (5):
      bpf: Support inlining bpf_kptr_xchg() helper
      selftests/bpf: Factor out get_xlated_program() helper
      selftests/bpf: Test the inlining of bpf_kptr_xchg()
      bpf, arm64: Enable the inline of bpf_kptr_xchg()
      selftests/bpf: Enable kptr_xchg_inline test for arm64

Howard Hsu (1):
      wifi: mt76: mt7996: fix HE beamformer phy cap for station vif

Ian Rogers (1):
      libbpf: Add some details for BTF parsing failures

Ido Schimmel (18):
      selftests: forwarding: Add missing multicast routing config entries
      selftests: vxlan_mdb: Avoid duplicate test names
      selftests: forwarding: Remove IPv6 L3 multipath hash tests
      selftests: forwarding: Parametrize mausezahn delay
      selftests: forwarding: Make tc-police pass on debug kernels
      selftests: forwarding: Make vxlan-bridge-1q pass on debug kernels
      selftests: forwarding: Make VXLAN ECN encap tests more robust
      selftests: forwarding: Make {, ip6}gre-inner-v6-multipath tests more robust
      net: nexthop: Add nexthop group entry stats
      net: nexthop: Expose nexthop group stats to user space
      net: nexthop: Add hardware statistics notifications
      net: nexthop: Add ability to enable / disable hardware statistics
      net: nexthop: Expose nexthop group HW stats to user space
      nexthop: Simplify dump error handling
      nexthop: Only parse NHA_OP_FLAGS for get messages that require it
      nexthop: Only parse NHA_OP_FLAGS for dump messages that require it
      nexthop: Fix out-of-bounds access during attribute validation
      nexthop: Fix splat with CONFIG_DEBUG_PREEMPT=y

Ilan Peer (8):
      wifi: mac80211_hwsim: Declare support for negotiated TTLM
      wifi: iwlwifi: mvm: Add support for removing responder TKs
      wifi: iwlwifi: mvm: Fix FTM initiator flags
      wifi: iwlwifi: mvm: Declare support for secure LTF measurement
      wifi: iwlwifi: mvm: Extend support for P2P service discovery
      wifi: iwlwifi: mvm: Fix the listener MAC filter flags
      wifi: mac80211: Allow beacons to update BSS table regardless of scan
      wifi: mac80211: Adjust CQM handling for MLO

Iulia Tanasescu (2):
      Bluetooth: ISO: Add hcon for listening bis sk
      Bluetooth: ISO: Reassemble PA data for bcast sink

Ivan Vecera (5):
      i40e: Use existing helper to find flow director VSI
      i40e: Introduce and use macros for iterating VSIs and VEBs
      i40e: Add helpers to find VSI and VEB by SEID and use them
      i40e: Fix broken support for floating VEBs
      i40e: Remove VEB recursion

Jacob Keller (14):
      ice: introduce PTP state machine
      ice: pass reset type to PTP reset functions
      ice: rename verify_cached to has_ready_bitmap
      ice: don't check has_ready_bitmap in E810 functions
      ice: rename ice_ptp_tx_cfg_intr
      ice: factor out ice_ptp_rebuild_owner()
      ice: stop destroying and reinitalizing Tx tracker during reset
      ice: pass VSI pointer into ice_vc_isvalid_q_id
      ice: remove unnecessary duplicate checks for VF VSI ID
      ice: use relative VSI index for VFs instead of PF VSI number
      ice: remove vf->lan_vsi_num field
      ice: rename ice_write_* functions to ice_pack_ctx_*
      ice: use GENMASK instead of BIT(n) - 1 in pack functions
      ice: cleanup line splitting for context set functions

Jakub Kicinski (128):
      Merge branch 'gve-alloc-before-freeing-when-changing-config'
      Revert "net: ethernet: qualcomm: Remove QDF24xx support"
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'selftests-tc-testing-misc-changes-for-tdc'
      Merge tag 'wireless-next-2024-01-25' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'selftests-updates-to-fcnal-test-for-autoamted-environment'
      Merge branch 'af_unix-random-improvements-for-gc'
      Merge branch 'net-phy-generic-polarity-led-support-for-qca808x'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-dsa-microchip-implement-phy-loopback'
      net: free altname using an RCU callback
      Merge branch 'mt7530-dsa-subdriver-improvements-act-i'
      Merge branch 'prevent-nullptr-exceptions-in-isr'
      Merge branch 'net-phy-split-at803x'
      Merge branch 'af_unix-remove-io_uring-dead-code-in-gc'
      Merge branch 'tools-net-ynl-add-features-for-tc-family'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-ipa-simplify-tx-power-handling'
      Merge branch 'net-sched-load-modules-via-alias'
      tools: ynl: include dpll and mptcp_pm in C codegen
      tools: ynl: generate code for ovs families
      tools: ynl: auto-gen for all genetlink families
      Merge branch 'tools-ynl-auto-gen-for-all-genetlink-families'
      selftests: netdevsim: stop using ifconfig
      Merge branch 'add-support-for-encoding-multi-attr-to-ynl'
      Merge branch 'net-phy-add-and-use-helper-phy_advertise_eee_all'
      Merge branch 'net-eee-network-driver-cleanups'
      Merge branch 'net-phy-realtek-complete-5gbps-support-and-replace-private-constants'
      Merge branch 'selftests-bonding-use-slowwait-when-waiting'
      Merge tag 'mlx5-updates-2024-02-01' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'mt7530-dsa-subdriver-improvements-act-ii'
      Merge branch 'net-more-factorization-in-cleanup_net-paths'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'add-hw-checksum-offload-support-for-rz-g2l-gbethernet-ip'
      Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'for-io_uring-add-napi-busy-polling-support'
      Merge branch 'bnxt_en-ntuple-and-rss-updates'
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-use-net-dev_by_index-in-two-places'
      Merge branch 'net-adopt-netdev_lockdep_set_classes'
      Merge branch 'r8169-extend-eee-tx-idle-timer-support'
      Merge branch 'add-multi-buff-support-for-xdp-running-in-generic-mode'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'for-thermal-genetlink-family-bind-unbind-callbacks'
      Merge branch 'net-phy-marvell-88q2xxx-add-driver-for-the-marvell-88q2220-phy'
      Merge tag 'wireless-next-2024-02-22' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'nf-next-24-02-21' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'net-staging-don-t-bother-filling-in-ethtool-driver-version'
      Merge branch 'tools-ynl-couple-of-cmdline-enhancements'
      genetlink: make info in GENL_REQ_ATTR_CHECK() const
      tools: ynl: fix header guards
      Merge branch 'mptcp-various-small-improvements'
      selftests: netdevsim: be less selective for FW for the devlink test
      tools: ynl: protect from old OvS headers
      tools: ynl: give up on libmnl for auto-ints
      tools: ynl: create local attribute helpers
      tools: ynl: create local for_each helpers
      tools: ynl: create local nlmsg access helpers
      tools: ynl: create local ARRAY_SIZE() helper
      tools: ynl: make yarg the first member of struct ynl_dump_state
      tools: ynl-gen: remove unused parse code
      tools: ynl: wrap recv() + mnl_cb_run2() into a single helper
      tools: ynl: use ynl_sock_read_msgs() for ACK handling
      tools: ynl: stop using mnl_cb_run2()
      tools: ynl: switch away from mnl_cb_t
      tools: ynl: switch away from MNL_CB_*
      tools: ynl: stop using mnl socket helpers
      tools: ynl: remove the libmnl dependency
      tools: ynl: use MSG_DONTWAIT for getting notifications
      Merge branch 'tools-ynl-stop-using-libmnl'
      Merge branch 'inet-implement-lockless-rtm_getnetconf-ops'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      selftests: kselftest_harness: use KSFT_* exit codes
      selftests: kselftest_harness: generate test name once
      selftests: kselftest_harness: save full exit code in metadata
      selftests: kselftest_harness: use exit code to store skip
      selftests: kselftest: add ksft_test_result_code(), handling all exit codes
      selftests: kselftest_harness: print test name for SKIP
      selftests: kselftest_harness: separate diagnostic message with # in ksft_test_result_code()
      selftests: kselftest_harness: let PASS / FAIL provide diagnostic
      selftests: kselftest_harness: support using xfail
      selftests: ip_local_port_range: use XFAIL instead of SKIP
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      eth: igc: remove unused embedded struct net_device
      Merge branch 'intel-wired-lan-driver-updates-2024-02-28-ixgbe-igc-igb-e1000e-e100'
      Merge branch 'selftests-forwarding-various-improvements'
      Merge branch 'net-phy-micrel-lan8814-erratas'
      Merge branch 'net-constify-struct-class-usage'
      Merge branch 'net-ethernet-rework-eee'
      selftests: avoid using SKIP(exit()) in harness fixure setup
      netlink: handle EMSGSIZE errors in the core
      netdev: let netlink core handle -EMSGSIZE errors
      genetlink: fit NLMSG_DONE into same read() as families
      tools: ynl: rename make hardclean -> distclean
      tools: ynl: add distclean to .PHONY in all makefiles
      tools: ynl: remove __pycache__ during clean
      tools: ynl: move the new line in NlMsg __repr__
      tools: ynl: allow setting recv() size
      tools: ynl: support debug printing messages
      tools: ynl: add --dbg-small-recv for easier kernel testing
      Merge branch 'mptcp-some-clean-up-patches'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      tools: ynl: check for overflow of constructed messages
      Merge branch 'isdn-constify-struct-class-usage'
      Merge branch 'tools-net-ynl-add-support-for-nlctrl-netlink-family'
      Merge tag 'rxrpc-iothread-20240305' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
      Merge branch 'selftests-mptcp-share-code-and-fix-shellcheck-warnings'
      Merge branch 'net-group-together-hot-data'
      netdev: add per-queue statistics
      netdev: add queue stat for alloc failures
      eth: bnxt: support per-queue statistics
      Merge branch 'netdev-add-per-queue-statistics'
      net: dqs: add NIC stall detector based on BQL
      Add Jeff Kirsher to .get_maintainer.ignore
      Merge tag 'wireless-next-2024-03-08' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'ieee802154-for-net-next-2024-03-07' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next
      Merge tag 'for-net-next-2024-03-08' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge tag 'mlx5-socket-direct-v3' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      ynl: samples: fix recycling rate calculation
      Merge branch 'mlxsw-support-for-nexthop-group-statistics'
      Merge branch 'selftests-mptcp-various-improvements'
      tools: ynl: remove trailing semicolon
      netlink: specs: support generating code for genl socket priv
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'nexthop-fix-two-nexthop-group-statistics-issues'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Jakub Sitnicki (1):
      selftests: udpgso: Pull up network setup into shell script

Jann Horn (1):
      net: ethtool: avoid rebuilds on UTS_RELEASE change

Jason Xing (15):
      tcp: no need to use acceptable for conn_request
      tcp: add a dropreason definitions and prepare for cookie check
      tcp: directly drop skb in cookie check for ipv4
      tcp: use drop reasons in cookie check for ipv4
      tcp: directly drop skb in cookie check for ipv6
      tcp: use drop reasons in cookie check for ipv6
      tcp: introduce dropreasons in receive path
      tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
      tcp: add dropreasons in tcp_rcv_state_process()
      tcp: make the dropreason really work when calling tcp_rcv_state_process()
      tcp: make dropreason in tcp_child_process() work
      tcp: add tracing of skb/skaddr in tcp_event_sk_skb class
      tcp: add tracing of skbaddr in tcp_event_skb class
      mptcp: annotate a data-race around sysctl_tcp_wmem[0]
      tcp: annotate a data-race around sysctl_tcp_wmem[0]

Javier Martinez Canillas (1):
      wifi: wlcore: sdio: Rate limit wl12xx_sdio_raw_{read,write}() failures warns

Jedrzej Jagielski (3):
      ixgbe: Convert ret val type from s32 to int
      ixgbe: Rearrange args to fix reverse Christmas tree
      ixgbe: Clarify the values of the returning status

Jeff Johnson (20):
      wifi: ath10k: use flexible array in struct wmi_host_mem_chunks
      wifi: ath10k: use flexible arrays for WMI start scan TLVs
      wifi: ath10k: remove struct wmi_pdev_chanlist_update_event
      wifi: ath10k: remove unused template structs
      wifi: ath10k: use flexible array in struct wmi_tdls_peer_capabilities
      wifi: ath10k: remove duplicate memset() in 10.4 TDLS peer update
      wifi: ath12k: Make QMI message rules const
      wifi: ath12k: Remove unnecessary struct qmi_txn initializers
      wifi: ath12k: Add missing qmi_txn_cancel() calls
      wifi: ath12k: Use initializers for QMI message buffers
      wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM
      wifi: ath10k: add missing wmi_10_4_feature_mask documentation
      wifi: ath10k: correctly document enum wmi_tlv_tx_pause_id
      wifi: ath10k: fix htt_q_state_conf & htt_q_state kernel-doc
      wifi: ath10k: Fix htt_data_tx_completion kernel-doc warning
      wifi: ath10k: Fix enum ath10k_fw_crash_dump_type kernel-doc
      Revert "nl80211/cfg80211: Specify band specific min RSSI thresholds with sched scan"
      wifi: ath11k: Really consistently use ath11k_vif_to_arvif()
      dt-bindings: net: wireless: qcom: Update maintainers
      wifi: ath11k: constify MHI channel and controller configs

Jeremy Kerr (11):
      net: mctp: avoid confusion over local/peer dest/source addresses
      net: mctp: Add some detail on the key allocation implementation
      net: mctp: make key lookups match the ANY address on either local or peer
      net: mctp: tests: create test skbs with the correct net and device
      net: mctp: separate key correlation across nets
      net: mctp: provide a more specific tag allocation ioctl
      net: mctp: tests: Add netid argument to __mctp_route_test_init
      net: mctp: tests: Add MCTP net isolation tests
      net: mctp: copy skb ext data when fragmenting
      net: mctp: tests: Test that outgoing skbs have flow data populated
      net: mctp: tests: Add a test for proper tag creation on local output

Jeroen de Borst (3):
      gve: Add header split device option
      gve: Add header split data path
      gve: Add header split ethtool stats

Jesper Nilsson (1):
      net: stmmac: mmc_core: Drop interrupt registers from stats

Jian Shen (1):
      net: hns3: add checking for vf id of mailbox

Jiawen Wu (4):
      net: txgbe: move interrupt codes to a separate file
      net: txgbe: use irq_domain for interrupt controller
      net: txgbe: fix GPIO interrupt blocking
      net: txgbe: fix to clear interrupt status after handling IRQ

Jie Wang (1):
      net: hns3: fix port duplex configure error in IMP reset

Jijie Shao (2):
      net: hns3: fix wrong judgment condition issue
      net: hns3: fix delete tc fail issue

Jimmy Assarsson (2):
      can: kvaser_pciefd: Add support for Kvaser M.2 PCIe 4xCAN
      can: kvaser_usb: Add support for Leaf v3

Jinjian Song (4):
      wwan: core: Add WWAN fastboot port type
      net: wwan: t7xx: Add sysfs attribute for device state machine
      net: wwan: t7xx: Infrastructure for early port configuration
      net: wwan: t7xx: Add fastboot WWAN port

Jinjie Ruan (1):
      wifi: mwifiex: debugfs: Drop unnecessary error check for debugfs_create_dir()

Jiri Olsa (9):
      bpf: Add cookie to perf_event bpf_link_info records
      bpf: Store cookies in kprobe_multi bpf_link_info data
      bpftool: Fix wrong free call in do_show_link
      selftests/bpf: Add cookies check for kprobe_multi fill_link_info test
      selftests/bpf: Add cookies check for perf_event fill_link_info test
      selftests/bpf: Add fill_link_info test for perf event
      bpftool: Display cookie for perf event link probes
      bpftool: Display cookie for kprobe multi link
      selftests/bpf: Add kprobe multi triggering benchmarks

Jiri Pirko (11):
      dpll: move xa_erase() call in to match dpll_pin_alloc() error path order
      dpll: extend uapi by lock status error attribute
      dpll: extend lock_status_get() op by status error and expose to user
      net/mlx5: DPLL, Implement lock status error value
      dpll: check that pin is registered in __dpll_pin_unregister()
      tools: ynl: don't access uninitialized attr_space variable
      tools: ynl: allow user to specify flag attr with bool values
      tools: ynl: process all scalar types encoding in single elif statement
      tools: ynl: allow user to pass enum string instead of scalar value
      dpll: spec: use proper enum for pin capabilities attribute
      dpll: fix dpll_xa_ref_*_del() for multiple registrations

Joe Damato (5):
      net/mlx5e: link NAPI instances to queues and IRQs
      eventpoll: support busy poll per epoll instance
      eventpoll: Add per-epoll busy poll packet budget
      eventpoll: Add per-epoll prefer busy poll option
      eventpoll: Add epoll ioctl for epoll_params

Johannes Berg (155):
      wifi: cfg80211: add support for SPP A-MSDUs
      wifi: mac80211: add support for SPP A-MSDUs
      wifi: mac80211_hwsim: advertise AP-side EMLSR/EMLMR capa
      wifi: mac80211: take EML/MLD capa from assoc response
      wifi: cfg80211: validate MLO connections better
      wifi: mac80211_hwsim: advertise 15 simultaneous links
      wifi: mac80211: simplify ieee80211_config_bw() prototype
      wifi: mac80211: remove extra element parsing
      wifi: mac80211: simplify HE capability access
      wifi: mac80211: disallow drivers with HT wider than HE
      wifi: mac80211: don't set bss_conf in parsing
      wifi: iwlwifi: add kunit test for devinfo ordering
      wifi: iwlwifi: make TB reallocation a debug message
      wifi: iwlwifi: mvm: limit EHT 320 MHz MCS for STEP URM
      wifi: iwlwifi: remove retry loops in start
      wifi: iwlwifi: nvm-parse: advertise common packet padding
      kunit: add wireless unit tests
      wifi: iwlwifi: mvm: report beacon protection failures
      wifi: iwlwifi: mvm: d3: disconnect on GTK rekey failure
      wifi: iwlwifi: fix some kernel-doc issues
      wifi: iwlwifi: dbg-tlv: avoid extra allocation/copy
      wifi: iwlwifi: dbg-tlv: use struct_size() for allocation
      wifi: iwlwifi: dbg-tlv: ensure NUL termination
      wifi: iwlwifi: fw: dbg: ensure correct config name sizes
      wifi: iwlwifi: acpi: fix WPFC reading
      wifi: iwlwifi: mvm: initialize rates in FW earlier
      wifi: iwlwifi: mvm: d3: fix IPN byte order
      wifi: iwlwifi: mvm: don't set trigger frame padding in AP mode
      wifi: iwlwifi: always have 'uats_enabled'
      wifi: iwlwifi: remove Gl A-step remnants
      wifi: iwlwifi: mvm: use FW rate for non-data only on new devices
      wifi: iwlwifi: mvm: support SPP A-MSDUs
      wifi: iwlwifi: mvm: refactor duplicate chanctx condition
      wifi: iwlwifi: mvm: d3: implement suspend with MLO
      wifi: iwlwifi: mvm: check AP supports EMLSR
      wifi: mac80211_hwsim: add control to skip beacons
      wifi: mac80211: trace SMPS requests from driver
      wifi: mac80211: clean up FILS discovery change flags handling
      wifi: nl80211: move WPA version validation to policy
      wifi: iwlwifi: remove unused function prototype
      wifi: iwlwifi: api: clean up some kernel-doc/typos
      wifi: iwlwifi: fw: fix compile w/o CONFIG_ACPI
      wifi: iwlwifi: fw: fix compiler warning for NULL string print
      wifi: iwlwifi: mvm: fix warnings from dmi_get_system_info()
      wifi: cfg80211: fix kunit exports
      Merge wireless into wireless-next
      wifi: mac80211: remove unused MAX_MSG_LEN define
      wifi: mac80211: remove extra shadowing variable
      wifi: mac80211: clean up band switch in duration
      wifi: mac80211: clean up connection process
      wifi: mac80211: clean up HE 6 GHz and EHT chandef parsing
      wifi: mac80211: simplify non-chanctx drivers
      wifi: mac80211: chan: chandef is non-NULL for reserved
      wifi: mac80211: introduce 'channel request'
      wifi: mac80211: add and use a link iteration macro
      wifi: mac80211: support wider bandwidth OFDMA config
      wifi: mac80211: validate assoc response channel config
      wifi: cfg80211: move puncturing validation code
      wifi: mac80211: refactor puncturing bitmap extraction
      wifi: wireless: declare different S1G chandefs incompatible
      wifi: cfg80211: simplify cfg80211_chandef_compatible()
      wifi: mac80211: use cfg80211_chandef_primary_freq()
      wifi: cfg80211/mac80211: move puncturing into chandef
      wifi: mac80211: add/use ieee80211_get_sn()
      wifi: mac80211: implement MLO multicast deduplication
      wifi: mac80211: disambiguate element parsing errors
      wifi: mac80211: disallow basic multi-link element in per-STA profile
      wifi: mac80211: simplify HE/EHT element length functions
      wifi: mac80211: adjust EHT capa when lowering bandwidth
      wifi: mac80211: limit HE RU capabilities when limiting bandwidth
      wifi: mac80211: rename ieee80211_ie_build_he_6ghz_cap()
      wifi: mac80211: tdls: use ieee80211_put_he_6ghz_cap()
      wifi: mac80211: simplify adding supported rates
      wifi: mac80211: start building elements in SKBs
      wifi: mac80211: move element parsing to a new file
      wifi: mac80211: convert ieee80211_ie_build_he_cap() to SKB use
      wifi: mac80211: convert ieee80211_ie_build_eht_cap() to SKB use
      wifi: mac80211: allow CSA to same channel
      wifi: mac80211: clarify vif handling in TX dequeue
      wifi: mac80211: add missing kernel-doc for fast_tx_check
      wifi: mac80211_hwsim: add missing kernel-doc
      wifi: mac80211: don't use sband->band early
      wifi: iwlwifi: pcie: don't allow hw-rfkill to stop device on gen2
      wifi: iwlwifi: mvm: const-ify chandef pointers
      wifi: iwlwifi: mvm: remove EHT code from mac80211.c
      wifi: iwlwifi: use system_unbound_wq for debug dump
      wifi: iwlwifi: mvm: remove one queue sync on BA session stop
      wifi: iwlwifi: mvm: expand queue sync warning messages
      wifi: iwlwifi: mvm: don't abort queue sync in CT-kill
      wifi: iwlwifi: mvm: combine condition/warning
      wifi: iwlwifi: mvm: limit pseudo-D3 to 60 seconds
      wifi: iwlwifi: mvm: fix erroneous queue index mask
      wifi: iwlwifi: mvm: don't do duplicate detection for nullfunc packets
      wifi: iwlwifi: fw: allow vmalloc for PNVM image
      wifi: iwlwifi: mvm: don't set replay counters to 0xff
      wifi: iwlwifi: mvm: remove flags for enable/disable beacon filter
      wifi: iwlwifi: mvm: show skb_mac_gso_segment() failure reason
      wifi: iwlwifi: mvm: move BA notif messages before action
      wifi: iwlwifi: queue: improve warning for no skb in reclaim
      wifi: cfg80211: fix kernel-doc for cfg80211_chandef_primary
      wifi: cfg80211: rename UHB to 6 GHz
      wifi: cfg80211: optionally support monitor on disabled channels
      wifi: mac80211: drop injection on disabled-chan monitor
      wifi: iwlwifi: mvm: work around A-MSDU size problem
      wifi: iwlwifi: api: fix constant version to match FW
      wifi: iwlwifi: don't use TRUE/FALSE with bool
      wifi: iwlwifi: mvm: fix thermal kernel-doc
      wifi: iwlwifi: error-dump: fix kernel-doc issues
      wifi: iwlwifi: api: dbg-tlv: fix up kernel-doc
      wifi: iwlwifi: fw: file: clean up kernel-doc
      wifi: iwlwifi: iwl-trans.h: clean up kernel-doc
      wifi: iwlwifi: mvm: check own capabilities for EMLSR
      Merge wireless into wireless-next
      wifi: cfg80211: use IEEE80211_MAX_MESH_ID_LEN appropriately
      wifi: cfg80211: remove cfg80211_inform_single_bss_frame_data()
      wifi: cfg80211: clean up cfg80211_inform_bss_frame_data()
      wifi: cfg80211: refactor RNR parsing
      wifi: mac80211: align ieee80211_mle_get_bss_param_ch_cnt()
      wifi: cfg80211: use ML element parsing helpers
      wifi: iwlwifi: mvm: support wider-bandwidth OFDMA
      wifi: iwlwifi: mvm: partially support PHY context version 6
      wifi: iwlwifi: mvm: support PHY context version 6
      wifi: iwlwifi: api: fix kernel-doc reference
      wifi: iwlwifi: iwl-fh.h: fix kernel-doc issues
      wifi: nl80211: refactor parsing CSA offsets
      wifi: b43: silence sparse warnings
      wifi: brcmsmac: silence sparse warnings
      wifi: rt2x00: silence sparse warnings
      wifi: zd1211rw: silence sparse warnings
      bitfield: suppress "dubious: x & !y" sparse warning
      wifi: mac80211: always initialize match_auth
      wifi: mac80211: check link exists before use
      wifi: mac80211: fix supported rate masking in scan
      wifi: mac80211: track capability/opmode NSS separately
      wifi: cfg80211: check A-MSDU format more carefully
      wifi: mac80211: don't add VHT capa on links without them
      wifi: mac80211: obtain AP HT/VHT data for assoc request
      wifi: cfg80211: print flags in tracing in hex
      wifi: mac80211: update scratch_pos after defrag
      wifi: mac80211: remove unnecessary ML element type check
      wifi: mac80211: add ieee80211_vif_link_active() helper
      wifi: mac80211: remove unnecessary ML element checks
      wifi: mac80211: simplify multi-link element parsing
      wifi: mac80211: defragment reconfiguration MLE when parsing
      wifi: mac80211: remove unneeded scratch_len subtraction
      wifi: mac80211: hide element parsing internals
      wifi: cfg80211: expose cfg80211_iter_rnr() to drivers
      wifi: cfg80211: allow cfg80211_defragment_element() without output
      wifi: mac80211: pass link_id to channel switch ops
      wifi: mac80211: pass link conf to abort_channel_switch
      wifi: mac80211: introduce a feature flag for quiet in CSA
      wifi: mac80211: mlme: unify CSA handling
      wifi: mac80211: remove TDLS peers only on affected link
      wifi: mac80211: remove TDLS peers on link deactivation
      wifi: cw1200: restore endian swapping

John Garry (2):
      rocker: Don't bother filling in ethtool driver version
      net: team: Don't bother filling in ethtool driver version

Jon Maxwell (1):
      intel: make module parameters readable in sys filesystem

Jonas Dreßler (8):
      Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
      Bluetooth: mgmt: Remove leftover queuing of power_off work
      Bluetooth: Add new state HCI_POWERING_DOWN
      Bluetooth: Disconnect connected devices before rfkilling adapter
      Bluetooth: Remove superfluous call to hci_conn_check_pending()
      Bluetooth: hci_event: Use HCI error defines instead of magic values
      Bluetooth: hci_conn: Only do ACL connections sequentially
      Bluetooth: Remove pending ACL connection attempts

Jones Syue 薛懷宗 (1):
      bonding: 802.3ad replace MAC_ADDRESS_EQUAL with __agg_has_partner

Jose E. Marchesi (9):
      bpf: avoid VLAs in progs/test_xdp_dynptr.c
      bpf: fix constraint in test_tcpbpf_kern.c
      bpf: Use r constraint instead of p constraint in selftests
      bpf: Use -Wno-error in certain tests when building with GCC
      bpf: Generate const static pointers for kernel helpers
      bpf: Build type-punning BPF selftests with -fno-strict-aliasing
      bpf: Move -Wno-compare-distinct-pointer-types to BPF_CFLAGS
      bpf: Use -Wno-address-of-packed-member in some selftests
      bpf: Abstract loop unrolling pragmas in BPF selftests

Juntong Deng (3):
      inet: Add getsockopt support for IP_ROUTER_ALERT and IPV6_ROUTER_ALERT
      net/netlink: Add getsockopt support for NETLINK_LISTEN_ALL_NSID
      net/packet: Add getsockopt support for PACKET_COPY_THRESH

Justin Chen (6):
      dt-bindings: net: brcm,unimac-mdio: Add asp-v2.2
      dt-bindings: net: brcm,asp-v2.0: Add asp-v2.2
      net: bcmasp: Add support for ASP 2.2
      net: phy: mdio-bcm-unimac: Add asp v2.2 support
      net: bcmasp: Keep buffers through power management
      net: bcmasp: Add support for PHY interrupts

Justin Iurman (4):
      uapi: ioam6: API for netlink multicast events
      net: ioam6: multicast event
      net: exthdrs: ioam6: send trace event
      net: ipv6: exthdrs: get rid of ipv6_skb_net()

Justin Swartz (2):
      net: x25: remove dead links from Kconfig
      net: dsa: mt7530: disable LEDs before reset

Jérémie Dautheribes (4):
      dt-bindings: net: dp83822: support configuring RMII master/slave mode
      net: phy: dp83826: Add support for phy-mode configuration
      net: phy: dp83826: support configuring RMII master/slave operation mode
      dt-bindings: net: dp83822: change ti,rmii-mode description

Jérôme Pouiller (1):
      wifi: wfx: fix memory leak when starting AP

Kalle Valo (9):
      Merge tag 'ath-next-20240130' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath
      wifi: zd1211rw: remove __nocast from zd_addr_t
      wifi: rsi: fix restricted __le32 degrades to integer sparse warnings
      wifi: cw1200: fix __le16 sparse warnings
      Merge tag 'ath-next-20240222' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath
      wifi: ath11k: thermal: don't try to register multiple times
      Merge tag 'mt76-for-kvalo-2024-02-22' of https://github.com/nbd168/wireless
      wifi: ath12k: fix license in p2p.c and p2p.h
      Merge tag 'ath-next-20240305' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

Kamal Heib (3):
      net: ena: Remove redundant assignment
      net: ena: Remove unlikely() from IS_ERR() condition
      net: ena: Remove ena_select_queue

Kang Yang (12):
      wifi: ath12k: fix broken structure wmi_vdev_create_cmd
      wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
      wifi: ath12k: change interface combination for P2P mode
      wifi: ath12k: add P2P IE in beacon template
      wifi: ath12k: implement handling of P2P NoA event
      wifi: ath12k: implement remain on channel for P2P mode
      wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
      wifi: ath12k: allow specific mgmt frame tx while vdev is not up
      wifi: ath12k: move peer delete after vdev stop of station for WCN7850
      wifi: ath12k: designating channel frequency for ROC scan
      wifi: ath12k: advertise P2P dev support for WCN7850
      wifi: ath12k: add rcu lock for ath12k_wmi_p2p_noa_event()

Karthikeyan Kathirvel (1):
      wifi: ath12k: subscribe required word mask from rx tlv

Karthikeyan Periyasamy (23):
      wifi: ath12k: relocate ath12k_dp_pdev_pre_alloc() call
      wifi: ath12k: refactor ath12k_mac_allocate() and ath12k_mac_destroy()
      wifi: ath12k: refactor ath12k_mac_setup_channels_rates()
      wifi: ath12k: refactor ath12k_mac_register() and ath12k_mac_unregister()
      wifi: ath12k: refactor ath12k_mac_op_config()
      wifi: ath12k: refactor ath12k_bss_assoc()
      wifi: ath12k: refactor ath12k_mac_op_conf_tx()
      wifi: ath12k: refactor ath12k_mac_op_start()
      wifi: ath12k: refactor ath12k_mac_op_stop()
      wifi: ath12k: refactor ath12k_mac_op_update_vif_offload()
      wifi: ath12k: refactor ath12k_mac_op_configure_filter()
      wifi: ath12k: refactor ath12k_mac_op_ampdu_action()
      wifi: ath12k: refactor ath12k_mac_op_flush()
      wifi: ath12k: ath12k_start_vdev_delay(): convert to use ar
      wifi: ath12k: refactor QMI MLO host capability helper function
      wifi: ath12k: add QMI PHY capability learn support
      wifi: ath12k: replace ENOTSUPP with EOPNOTSUPP
      wifi: ath11k: replace ENOTSUPP with EOPNOTSUPP
      wifi: ath10k: replace ENOTSUPP with EOPNOTSUPP
      wifi: ath12k: Refactor the mac80211 hw access from link/radio
      wifi: ath12k: Introduce the container for mac80211 hw
      wifi: ath12k: add MAC id support in WBM error path
      wifi: ath12k: refactor the rfkill worker

Kees Cook (7):
      bnx2x: Fix firmware version string character counts
      net/sun3_82586: Avoid reading past buffer in debug output
      wifi: mwifiex: Refactor 1-element array into flexible array in struct mwifiex_ie_types_chan_list_param_set
      net: sched: Annotate struct tc_pedit with __counted_by
      netfilter: x_tables: Use unsafe_memcpy() for 0-sized destination
      bpf: Replace bpf_lpm_trie_key 0-length array with flexible array
      sock: Use unsafe_memcpy() for sock_copy()

Kiran K (1):
      Bluetooth: btintel: Print Firmware Sequencer information

Konrad Dybcio (1):
      net: ethernet: qualcomm: Remove QDF24xx support

Kory Maincent (1):
      ptp: Move from simple ida to xarray

Krzysztof Kozlowski (4):
      dt-bindings: net: qcom,ipa: do not override firmware-name $ref
      dt-bindings: net: qca,ar9331: convert to DT schema
      net: wan: framer: constify of_phandle_args in xlate
      dt-bindings: net: ethernet-controller: drop redundant type from label

Kuan-Chung Chen (2):
      wifi: rtw89: advertise missing extended scan feature
      wifi: rtw89: Update EHT PHY beamforming capability

Kui-Feng Lee (37):
      bpf: refactory struct_ops type initialization to a function.
      bpf: get type information with BTF_ID_LIST
      bpf, net: introduce bpf_struct_ops_desc.
      bpf: add struct_ops_tab to btf.
      bpf: make struct_ops_map support btfs other than btf_vmlinux.
      bpf: pass btf object id in bpf_map_info.
      bpf: lookup struct_ops types from a given module BTF.
      bpf: pass attached BTF to the bpf_struct_ops subsystem
      bpf: hold module refcnt in bpf_struct_ops map creation and prog verification.
      bpf: validate value_type
      bpf, net: switch to dynamic registration
      libbpf: Find correct module BTFs for struct_ops maps and progs.
      bpf: export btf_ctx_access to modules.
      selftests/bpf: test case for register_bpf_struct_ops().
      bpf: Fix error checks against bpf_get_btf_vmlinux().
      bpf: Remove an unnecessary check.
      selftests/bpf: Suppress warning message of an unused variable.
      net/ipv6: set expires in rt6_add_dflt_router().
      net/ipv6: Remove unnecessary clean.
      net/ipv6: Remove expired routes with a separated list of routes.
      net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
      selftests/net: Adding test cases of replacing routes and route advertisements.
      bpf: add btf pointer to struct bpf_ctx_arg_aux.
      bpf: Move __kfunc_param_match_suffix() to btf.c.
      bpf: Create argument information for nullable arguments.
      selftests/bpf: Test PTR_MAYBE_NULL arguments of struct_ops operators.
      bpf: Check cfi_stubs before registering a struct_ops type.
      selftests/bpf: Test case for lacking CFI stub functions.
      libbpf: Set btf_value_type_id of struct bpf_map for struct_ops.
      libbpf: Convert st_ops->data to shadow type.
      bpftool: Generated shadow variables for struct_ops maps.
      bpftool: Add an example for struct_ops map and shadow type.
      selftests/bpf: Test if shadow types work correctly.
      bpf, net: validate struct_ops when updating value.
      bpf: struct_ops supports more than one page for trampolines.
      selftests/bpf: Test struct_ops maps with a large number of struct_ops program.
      selftests/net: fix waiting time for ipv6_gc test in fib_tests.sh.

Kumar Kartikeya Dwivedi (4):
      bpf: Allow calling static subprogs while holding a bpf_spin_lock
      selftests/bpf: Add test for static subprog call in lock cs
      bpf: Transfer RCU lock state between subprog calls
      selftests/bpf: Add tests for RCU lock transfer between subprogs

Kuniyuki Iwashima (15):
      tcp: Move tcp_ns_to_ts() to tcp.h
      tcp: Move skb_steal_sock() to request_sock.h
      bpf: tcp: Handle BPF SYN Cookie in skb_steal_sock().
      bpf: tcp: Handle BPF SYN Cookie in cookie_v[46]_check().
      bpf: tcp: Support arbitrary SYN Cookie.
      selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
      bpf: Define struct bpf_tcp_req_attrs when CONFIG_SYN_COOKIES=n.
      af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
      af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
      af_unix: Return struct unix_sock from unix_get_socket().
      af_unix: Run GC on only one CPU.
      af_unix: Try to run GC async.
      af_unix: Replace BUG_ON() with WARN_ON_ONCE().
      af_unix: Remove io_uring code for GC.
      af_unix: Remove CONFIG_UNIX_SCM.

Kunwu Chan (15):
      xfrm6_tunnel: Use KMEM_CACHE instead of kmem_cache_create
      netfilter: nf_conncount: Use KMEM_CACHE instead of kmem_cache_create()
      ipvs: Simplify the allocation of ip_vs_conn slab caches
      net: rds: Simplify the allocation of slab caches in rds_conn_init
      net: ipv4: Simplify the allocation of slab caches in inet_initpeers
      net: bridge: Use KMEM_CACHE instead of kmem_cache_create
      sctp: Simplify the allocation of slab caches
      net: dccp: Simplify the allocation of slab caches in dccp_ackvec_init
      xfrm: Simplify the allocation of slab caches in xfrm_policy_init
      netfilter: expect: Simplify the allocation of slab caches in nf_conntrack_expect_init
      net: kcm: Simplify the allocation of slab caches
      ip6mr: Simplify the allocation of slab caches in ip6_mr_init
      ipmr: Simplify the allocation of slab caches
      ipv4: Simplify the allocation of slab caches in ip_rt_init
      ipv6: Simplify the allocation of slab caches

Kurt Kanzenbach (5):
      igc: Use reverse xmas tree
      igc: Use netdev printing functions for flex filters
      igc: Unify filtering rule fields
      net: stmmac: Simplify mtl IRQ status checking
      igc: Add support for LEDs on i225/i226

Kévin L'hôpital (1):
      net: phy: fix phy_get_internal_delay accessing an empty array

Leon Romanovsky (4):
      xfrm: generalize xdo_dev_state_update_curlft to allow statistics update
      xfrm: get global statistics from the offloaded device
      net/mlx5e: Connect mlx5 IPsec statistics with XFRM core
      net/mlx5e: Delete obsolete IPsec code

Leon Yen (1):
      wifi: mt76: mt7921: fix a potential association failure upon resuming

Li Zhijian (1):
      drivers/ptp: Convert snprintf to sysfs_emit

Lingbo Kong (2):
      wifi: ath12k: add processing for TWT enable event
      wifi: ath12k: add processing for TWT disable event

Linus Walleij (5):
      wifi: ti: wlcore: sdio: Drop unused include
      wifi: brcmsmac: Drop legacy header
      wifi: mwifiex: Drop unused headers
      wifi: plfxlc: Drop unused include
      wifi: cw1200: Convert to GPIO descriptors

Lorenzo Bianconi (12):
      wifi: mac80211: remove gfp parameter from ieee80211_obss_color_collision_notify
      net: add generic percpu page_pool allocator
      xdp: rely on skb pointer reference in do_xdp_generic and netif_receive_generic_xdp
      xdp: add multi-buff support for xdp running in generic mode
      veth: rely on skb_pp_cow_data utility routine
      net: page_pool: fix recycle stats for system page_pool allocator
      net: fix pointer check in skb_pp_cow_data routine
      wifi: mt76: mt7996: fix fw loading timeout
      wifi: mt76: usb: create a dedicated queue for psd traffic
      wifi: mt76: usb: store usb endpoint in mt76_queue
      wifi: mt76: move wed common utilities in wed.c
      wifi: mt76: set page_pool napi pointer for mmio devices

Lucas Tanure (1):
      ptp: lan743x: Use spin_lock instead of spin_lock_bh

Luiz Angelo Daros de Luca (15):
      net: dsa: realtek: drop cleanup from realtek_ops
      net: dsa: realtek: introduce REALTEK_DSA namespace
      net: dsa: realtek: convert variants into real drivers
      net: dsa: realtek: keep variant reference in realtek_priv
      net: dsa: realtek: common rtl83xx module
      net: dsa: realtek: merge rtl83xx and interface modules into realtek_dsa
      net: dsa: realtek: get internal MDIO node by name
      net: dsa: realtek: clean user_mii_bus setup
      net: dsa: realtek: migrate user_mii_bus setup to realtek_dsa
      net: dsa: realtek: use the same mii bus driver for both interfaces
      net: dsa: realtek: embed dsa_switch into realtek_priv
      net: dsa: realtek: fix digital interface select macro for EXT0
      dt-bindings: net: dsa: realtek: reset-gpios is not required
      dt-bindings: net: dsa: realtek: add reset controller
      net: dsa: realtek: support reset controller

Luiz Augusto von Dentz (20):
      Bluetooth: hci_core: Cancel request on command timeout
      Bluetooth: Remove BT_HS
      Bluetooth: hci_event: Fix not indicating new connection for BIG Sync
      Bluetooth: hci_conn: Always use sk_timeo as conn_timeout
      Bluetooth: hci_conn: Fix UAF Write in __hci_acl_create_connection_sync
      Bluetooth: hci_sync: Add helper functions to manipulate cmd_sync queue
      Bluetooth: hci_sync: Attempt to dequeue connection attempt
      Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
      Bluetooth: hci_sync: Fix UAF on create_le_conn_complete
      Bluetooth: btintel: Fixe build regression
      Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
      Bluetooth: hci_sync: Use QoS to determine which PHY to scan
      Bluetooth: hci_sync: Fix overwriting request callback
      Bluetooth: hci_core: Fix possible buffer overflow
      Bluetooth: msft: Fix memory leak
      Bluetooth: btusb: Fix memory leak
      Bluetooth: bnep: Fix out-of-bound access
      Bluetooth: af_bluetooth: Fix deadlock
      Bluetooth: ISO: Align broadcast sync_timeout with connection timeout
      Bluetooth: hci_sync: Fix UAF in hci_acl_create_conn_sync

Lukas Bulwahn (1):
      Bluetooth: hci_event: Remove code to removed CONFIG_BT_HS

Maciej Fijalkowski (5):
      ice: make ice_vsi_cfg_rxq() static
      ice: make ice_vsi_cfg_txq() static
      ice: do not disable Tx queues twice in ice_down()
      ice: avoid unnecessary devm_ usage
      ixgbe: pull out stats update to common routines

Magnus Karlsson (2):
      xsk: support redirect to any socket bound to the same umem
      xsk: document ability to redirect to any socket bound to the same umem

Manu Bretelle (1):
      selftests/bpf: Disable IPv6 for lwt_redirect test

Marc Kleine-Budde (9):
      Merge patch series "can: esd: add support for esd GmbH PCIe/402 CAN interface"
      Merge patch series "can: m_can: Optimizations for m_can/tcan part 2"
      Merge patch "can network drivers maintainer"
      MAINTAINERS: can: xilinx_can: remove Naga Sureshkumar Relli
      Merge patch series "can: tcan4x5x: support resume upon rx can frame"
      Merge patch series "Add ECC feature support to Tx and Rx FIFOs for Xilinx CAN Controller."
      can: raw: raw_getsockopt(): reduce scope of err
      can: gs_usb: gs_cmd_reset(): use cpu_to_le32() to assign mode
      can: mcp251xfd: __mcp251xfd_get_berr_counter(): use CAN_BUS_OFF_THRESHOLD instead of open coding it

Marcel Ziswiler (1):
      Bluetooth: btnxpuart: Fix btnxpuart_close

Marco Elver (1):
      bpf: Allow compiler to inline most of bpf_local_storage_lookup()

Marcos Paulo de Souza (1):
      selftests/bpf: Remove empty TEST_CUSTOM_PROGS

Marek Behún (2):
      net: mdio: add 2.5g and 5g related PMA speed constants
      net: phy: realtek: use generic MDIO constants

Markus Elfring (5):
      batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()
      batman-adv: Improve exception handling in batadv_throw_uevent()
      tsnep: Use devm_platform_get_and_ioremap_resource() in tsnep_probe()
      ethernet: wiznet: Use devm_platform_get_and_ioremap_resource() in w5300_hw_probe()
      net: emaclite: Use devm_platform_get_and_ioremap_resource() in xemaclite_of_probe()

Markus Schneider-Pargmann (14):
      can: m_can: Start/Cancel polling timer together with interrupts
      can: m_can: Move hrtimer init to m_can_class_register
      can: m_can: Write transmit header and data in one transaction
      can: m_can: Implement receive coalescing
      can: m_can: Implement transmit coalescing
      can: m_can: Add rx coalescing ethtool support
      can: m_can: Add tx coalescing ethtool support
      can: m_can: Use u32 for putidx
      can: m_can: Cache tx putidx
      can: m_can: Use the workqueue as queue
      can: m_can: Introduce a tx_fifo_in_flight counter
      can: m_can: Use tx_fifo_in_flight for netif_queue control
      can: m_can: Implement BQL
      can: m_can: Implement transmit submission coalescing

Martin Hundebøll (3):
      dt-bindings: can: tcan4x5x: Document the wakeup-source flag
      can: m_can: allow keeping the transceiver running in suspend
      can: tcan4x5x: support resuming from rx interrupt signal

Martin Jocić (1):
      can: kvaser_pciefd: Add support for Kvaser PCIe 8xCAN

Martin KaFai Lau (12):
      Merge branch 'bpf: tcp: Support arbitrary SYN Cookie at TC.'
      Merge branch 'Registrating struct_ops types from modules'
      selftests/bpf: Fix the flaky tc_redirect_dtime test
      selftests/bpf: Wait for the netstamp_needed_key static key to be turned on
      libbpf: Ensure undefined bpf_attr field stays 0
      selftests/bpf: Remove "&>" usage in the selftests
      Merge branch 'libbpf: add bpf_core_cast() helper'
      Merge branch 'bpf, btf: Add DEBUG_INFO_BTF checks for __register_bpf_struct_ops'
      Merge branch 'Support PTR_MAYBE_NULL for struct_ops arguments.'
      Merge branch 'Check cfi_stubs before registering a struct_ops type.'
      Merge branch 'Allow struct_ops maps with a large number of programs'
      Merge branch 'bpf: arena prerequisites'

Martin Kaistra (25):
      wifi: rtl8xxxu: remove assignment of priv->vif in rtl8xxxu_bss_info_changed()
      wifi: rtl8xxxu: prepare supporting two virtual interfaces
      wifi: rtl8xxxu: support setting linktype for both interfaces
      wifi: rtl8xxxu: 8188e: convert usage of priv->vif to priv->vifs[0]
      wifi: rtl8xxxu: support setting mac address register for both interfaces
      wifi: rtl8xxxu: extend wifi connected check to both interfaces
      wifi: rtl8xxxu: extend check for matching bssid to both interfaces
      wifi: rtl8xxxu: don't parse CFO, if both interfaces are connected in STA mode
      wifi: rtl8xxxu: support setting bssid register for multiple interfaces
      wifi: rtl8xxxu: support multiple interfaces in set_aifs()
      wifi: rtl8xxxu: support multiple interfaces in update_beacon_work_callback()
      wifi: rtl8xxxu: support multiple interfaces in configure_filter()
      wifi: rtl8xxxu: support multiple interfaces in watchdog_callback()
      wifi: rtl8xxxu: support multiple interfaces in {add,remove}_interface()
      wifi: rtl8xxxu: support multiple interfaces in bss_info_changed()
      wifi: rtl8xxxu: support multiple interface in start_ap()
      wifi: rtl8xxxu: add macids for STA mode
      wifi: rtl8xxxu: remove obsolete priv->vif
      wifi: rtl8xxxu: add hw crypto support for AP mode
      wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
      wifi: rtl8xxxu: declare concurrent mode support for 8188f
      wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work
      wifi: rtl8xxxu: enable channel switch support
      wifi: rtl8xxxu: add missing number of sec cam entries for all variants
      wifi: rtl8xxxu: update rate mask per sta

Martin Kelly (1):
      bpf: Clarify batch lookup/lookup_and_delete semantics

Masahiro Yamada (3):
      net: ethernet: remove duplicated CONFIG_SUNGEM_PHY entry
      net: tipc: remove redundant 'bool' from CONFIG_TIPC_{MEDIA_UDP,CRYPTO}
      bpf: Merge two CONFIG_BPF entries

Matt Bobrowski (2):
      bpf: Minor clean-up to sleepable_lsm_hooks BTF set
      libbpf: Make remark about zero-initializing bpf_*_info structs

Matthew Wood (9):
      net: netconsole: cleanup formatting lints
      net: netconsole: move netconsole_target config_item to config_group
      net: netconsole: move newline trimming to function
      net: netconsole: add docs for appending netconsole user data
      net: netconsole: add a userdata config_group member to netconsole_target
      net: netconsole: cache userdata formatted string in netconsole_target
      net: netconsole: append userdata to netconsole messages
      net: netconsole: append userdata to fragmented netconsole messages
      net: netconsole: Add continuation line prefix to userdata messages

Matthieu Baerts (NGI0) (12):
      configs/debug: add NET debug config
      selftests: mptcp: lib: catch duplicated subtest entries
      mptcp: token kunit: set protocol
      mptcp: check the protocol in tcp_sk() with DEBUG_NET
      mptcp: check the protocol in mptcp_sk() with DEBUG_NET
      selftests: mptcp: stop forcing iptables-legacy
      selftests: mptcp: diag: fix shellcheck warnings
      selftests: mptcp: connect: fix shellcheck warnings
      selftests: mptcp: sockopt: fix shellcheck warnings
      selftests: mptcp: pm netlink: fix shellcheck warnings
      selftests: mptcp: simult flows: fix shellcheck warnings
      selftests: userspace pm: avoid relaunching pm events

Max Chou (1):
      Bluetooth: btrtl: Add the support for RTL8852BT/RTL8852BE-VT

Maxim Mikityanskiy (11):
      selftests/bpf: Fix the u64_offset_to_skb_data test
      bpf: Make bpf_for_each_spilled_reg consider narrow spills
      selftests/bpf: Add a test case for 32-bit spill tracking
      bpf: Add the assign_scalar_id_before_mov function
      bpf: Add the get_reg_width function
      bpf: Assign ID to scalars on spill
      selftests/bpf: Test assigning ID to scalars on spill
      bpf: Track spilled unbounded scalars
      selftests/bpf: Test tracking spilled unbounded scalars
      bpf: Preserve boundaries and track scalars on narrowing fill
      selftests/bpf: Add test cases for narrowing fill

Maxime Chevallier (2):
      doc: sfp-phylink: update the porting guide with PCS handling
      net: phylink: clean the pcs_get_state documentation

Menglong Dong (2):
      bpf: Remove unused field "mod" in struct bpf_trampoline
      net: tcp: accept old ack during closing

Michael Chan (6):
      bnxt_en: Use firmware provided maximum filter counts.
      bnxt_en: Add ethtool -N support for ether filters.
      bnxt_en: Support ethtool -n to display ether filters.
      bnxt_en: Refactor ring reservation functions
      bnxt_en: Explicitly specify P5 completion rings to reserve
      bnxt_en: Check additional resources in bnxt_check_rings()

Michael Lo (1):
      wifi: mt76: mt7921: fix suspend issue on MediaTek COB platform

Michael-CY Lee (4):
      wifi: mac80211: apply duration for SW scan
      wifi: cfg80211: Add utility for converting op_class into chandef
      wifi: mac80211: refactor STA CSA parsing flows
      wifi: mt76: mt7996: mark GCMP IGTK unsupported

Michal Koutný (4):
      net/sched: Add helper macros with module names
      net/sched: Add module aliases for cls_,sch_,act_ modules
      net/sched: Load modules via their alias
      net/sched: Remove alias of sch_clsact

Mickaël Salaün (3):
      selftests/landlock: Redefine TEST_F() as TEST_F_FORK()
      selftests/harness: Merge TEST_F_FORK() into TEST_F()
      selftests/harness: Fix TEST_F()'s vfork handling

Min Li (2):
      ptp: introduce PTP_CLOCK_EXTOFF event for the measured external offset
      ptp: add FemtoClock3 Wireless as ptp hardware clock

Mina Almasry (3):
      net: introduce abstraction for network memory
      net: add netmem to skb_frag_t
      net: page_pool: factor out page_pool recycle check

Ming Yen Hsieh (13):
      wifi: mt76: mt7925: fix connect to 80211b mode fail in 2Ghz band
      wifi: mt76: mt7925: fix wmm queue mapping
      wifi: mt76: mt7925: fix fw download fail
      wifi: mt76: mt7925: fix WoW failed in encrypted mode
      wifi: mt76: mt7925: fix the wrong header translation config
      wifi: mt76: mt7925: add support to set ifs time by mcu command
      wifi: mt76: mt7925: fix the wrong data type for scan command
      wifi: mt76: mt792x: add the illegal value check for mtcl table of acpi
      wifi: mt76: mt7921: fix incorrect type conversion for CLC command
      wifi: mt76: mt792x: fix a potential loading failure of the 6Ghz channel config from ACPI
      wifi: mt76: mt792x: update the country list of EU for ACPI SAR
      wifi: mt76: mt7921: fix the unfinished command of regd_notifier before suspend
      wifi: mt76: fix the issue of missing txpwr settings from ch153 to ch177

Miri Korenblit (43):
      wifi: iwlwifi: change link id in time event to s8
      wifi: iwlwifi: implement can_activate_links callback
      wifi: iwlwifi: add support for a wiphy_work rx handler
      wifi: iwlwifi: disable eSR when BT is active
      wifi: iwlwifi: implement GLAI ACPI table loading
      wifi: iwlwifi: cleanup uefi variables loading
      wifi: iwlwifi: fix EWRD table validity check
      wifi: iwlwifi: read BIOS PNVM only for non-Intel SKU
      wifi: iwlwifi: prepare for reading SAR tables from UEFI
      wifi: iwlwifi: cleanup sending PER_CHAIN_LIMIT_OFFSET_CMD
      wifi: iwlwifi: read SAR tables from UEFI
      wifi: iwlwifi: small cleanups in PPAG table flows
      wifi: iwlwifi: prepare for reading PPAG table from UEFI
      wifi: iwlwifi: validate PPAG table when sent to FW
      wifi: iwlwifi: read PPAG table from UEFI
      wifi: iwlwifi: don't check TAS block list size twice
      wifi: iwlwifi: prepare for reading TAS table from UEFI
      wifi: iwlwifi: separate TAS 'read-from-BIOS' and 'send-to-FW' flows
      wifi: iwlwifi: read WTAS table from UEFI
      wifi: mac80211_hwsim: enable all links only in MLO
      wifi: mac80211: don't allow deactivation of all links
      wifi: iwlwifi: prepare for reading SPLC from UEFI
      wifi: iwlwifi: read SPLC from UEFI
      wifi: iwlwifi: read WRDD table from UEFI
      wifi: iwlwifi: read ECKV table from UEFI
      wifi: iwlwifi: rfi: use a single DSM function for all RFI configurations
      wifi: iwlwifi: take send-DSM-to-FW flows out of ACPI ifdef
      wifi: iwlwifi: simplify getting DSM from ACPI
      wifi: iwlwifi: prepare for reading DSM from UEFI
      wifi: iwlwifi: read DSM functions from UEFI
      wifi: iwlwifi: bump FW API to 88 for AX/BZ/SC devices
      wifi: iwlwifi: add HONOR to PPAG approved list
      wifi: iwlwifi: adjust rx_phyinfo debugfs to MLO
      wifi: iwlwifi: read mac step from aux register
      wifi: iwlwifi: support EHT for WH
      wifi: iwlwifi: take SGOM and UATS code out of ACPI ifdef
      wifi: iwlwifi: properly check if link is active
      wifi: iwlwifi: bump FW API to 89 for AX/BZ/SC devices
      wifi: iwlwifi: mvm: remove IWL_MVM_STATUS_NEED_FLUSH_P2P
      wifi: iwlwifi: cancel session protection only if there is one
      wifi: mac80211: make associated BSS pointer visible to the driver
      wifi: iwlwifi: bump FW API to 90 for BZ/SC devices
      wifi: iwlwifi: handle per-phy statistics from fw

Moshe Shemesh (6):
      Documentation: Fix counter name of mlx5 vnic reporter
      net/mlx5: Rename mlx5_sf_dev_remove
      net/mlx5: remove fw_fatal reporter dump option for non PF
      net/mlx5: remove fw reporter dump option for non PF
      net/mlx5: SF, Stop waiting for FW as teardown was called
      net/mlx5: Return specific error code for timeout on wait_fw_init

Mukesh Sisodiya (6):
      wifi: iwlwifi: Add support for new 802.11be device
      wifi: iwlwifi: disable 160 MHz based on subsystem device ID
      wifi: iwlwifi: pcie: Add the PCI device id for new hardware
      wifi: iwlwifi: pcie: Add new PCI device id and CNVI
      wifi: iwlwifi: nvm: parse the VLP/AFC bit from regulatory
      wifi: iwlwifi: load b0 version of ucode for HR1/HR2

Nathan Chancellor (2):
      selftests/bpf: Update LLVM Phabricator links
      wifi: ath12k: Fix uninitialized use of ret in ath12k_mac_allocate()

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Resolve TX timeout error in power save stress test

Nick Morrow (1):
      wifi: rtw88: Add missing VID/PIDs for 8811CU and 8821CU

Nicolas Escande (6):
      wifi: ath11k: Do not directly use scan_flags in struct scan_req_params
      wifi: ath11k: Remove scan_flags union from struct scan_req_params
      wifi: ath12k: Do not use scan_flags from struct ath12k_wmi_scan_req_arg
      wifi: ath12k: Remove unused scan_flags from struct ath12k_wmi_scan_req_arg
      wifi: ath12k: remove the unused scan_events from ath12k_wmi_scan_req_arg
      wifi: ath11k: remove unused scan_events from struct scan_req_params

Nicolas Maier (1):
      can: bcm: add recvmsg flags for own, local and remote traffic

Niklas Söderlund (7):
      ravb: Group descriptor types used in Rx ring
      ravb: Make it clear the information relates to maximum frame size
      ravb: Create helper to allocate skb and align it
      ravb: Use the max frame size from hardware info for RZ/G2L
      ravb: Move maximum Rx descriptor data usage to info struct
      ravb: Unify Rx ring maintenance code paths
      ravb: Correct buffer size to map for R-Car Rx

Oleksij Rempel (5):
      net: dsa: microchip: ksz8: move BMCR specific code to separate function
      net: dsa: microchip: Remove redundant optimization in ksz8_w_phy_bmcr
      net: dsa: microchip: implement PHY loopback configuration for KSZ8794 and KSZ8873
      net: dsa: microchip: Add support for bridge port isolation
      net: dsa: microchip: make sure drive strength configuration is not lost by soft reset

Oliver Crumrine (1):
      bpf: remove check in __cgroup_bpf_run_filter_skb

Oliver Hartkopp (3):
      can: isotp: support dynamic flow control parameters
      can: canxl: add virtual CAN network identifier support
      can: raw: fix getsockopt() for new CAN_RAW_XL_VCID_OPTS

P Praneesh (2):
      wifi: ath12k: Add logic to write QRTR node id to scratch
      wifi: ath12k: fix PCI read and write

Pablo Neira Ayuso (4):
      netfilter: nf_tables: pass flags to set backend selection routine
      netfilter: nf_log: consolidate check for NULL logger in lookup function
      netfilter: nf_log: validate nf_logger_find_get()
      netfilter: nft_osf: simplify init path

Paolo Abeni (36):
      Merge branch 'inet_diag-remove-three-mutexes-in-diag-dumps'
      Merge branch 'ice-fix-timestamping-in-reset-process'
      Merge branch 'mlxsw-refactor-reference-counting-code'
      Merge branch 'net-mana-assigning-irq-affinity-on-ht-cores'
      Merge branch 'ena-driver-changes'
      Merge branch 'dpll-expose-lock-status-error-value-to-user'
      mptcp: annotate access for msk keys
      mptcp: annotate lockless access for the tx path
      mptcp: annotate lockless access for RX path fields
      mptcp: annotate lockless access for token
      mptcp: annotate lockless accesses around read-mostly fields
      Merge branch 'net-ravb-prepare-for-suspend-to-ram-and-runtime-pm-support-part-1'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'pds_core-various-improvements-cleanups'
      Merge branch 'nfc-hci-save-a-few-bytes-of-memory-when-registering-a-nfc_llc-engine'
      selftests: net: include forwarding lib
      selftests: net: ignore timing errors in txtimestamp if KSFT_MACHINE_SLOW
      Merge branch 'net-ipv6-addrconf-ensure-that-temporary-addresses-preferred-lifetimes-are-long-enough'
      Merge branch 'abstract-page-from-net-stack'
      Merge tag 'linux-can-next-for-6.9-20240220' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      udp: add local "peek offset enabled" flag
      Merge branch 'mctp-core-protocol-updates-minor-fixes-tests'
      Merge branch 'bnxt_en-ntuple-filter-improvements'
      Merge branch 'net-ipa-don-t-abort-system-suspend'
      Merge branch 'net-dsa-mv88e6xxx-add-amethyst-specific-smi-gpio-function'
      Merge branch 'net-collect-tstats-automatically'
      mptcp: cleanup writer wake-up
      mptcp: avoid some duplicate code in socket option handling
      mptcp: implement TCP_NOTSENT_LOWAT support
      mptcp: cleanup SOL_TCP handling
      Merge branch 'remove-page-frag-implementation-in-vhost_net'
      Merge branch 'mt7530-dsa-subdriver-improvements-act-iii'
      Merge branch 'net-gro-cleanups-and-fast-path-refinement'
      Merge tag 'linux-can-next-for-6.9-20240304' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'doc-sfp-phylink-update-the-porting-guide'
      Merge branch 'tcp-add-two-missing-addresses-when-using-trace'

Paul M Stillwell Jr (1):
      ice: remove incorrect comment

Pauli Virtanen (1):
      Bluetooth: fix use-after-free in accessing skb after sending it

Pavan Chebbi (12):
      bnxt_en: Add separate function to delete the filter structure
      bnxt_en: Save user configured filters in a lookup list
      bnxt_en: Retain user configured filters when closing
      bnxt_en: Restore all the user created L2 and ntuple filters
      bnxt_en: Add support for user configured RSS key
      bnxt_en: Invalidate user filters when needed
      bnxt_en: Improve RSS context reservation infrastructure
      bnxt_en: Refactor bnxt_set_features()
      bnxt_en: Define BNXT_VNIC_DEFAULT for the default vnic index
      bnxt_en: Provision for an additional VNIC for ntuple filters
      bnxt_en: Create and setup the additional VNIC for adding ntuple filters
      bnxt_en: Use the new VNIC to create ntuple filters

Pedro Tammela (6):
      selftests: tc-testing: add missing netfilter config
      selftests: tc-testing: check if 'jq' is available in taprio tests
      selftests: tc-testing: adjust fq test to latest iproute2
      selftests: tc-testing: enable all tdc tests
      selftests: tc-testing: return fail if a test fails in setup/teardown
      selftests/tc-testing: require an up to date iproute2 for blockcast tests

Peiyang Wang (1):
      net: hns3: fix reset timeout under full functions and queues

Peter Chiu (8):
      wifi: mt76: disable HW AMSDU when using fixed rate
      wifi: mt76: check txs format before getting skb by pid
      wifi: mt76: mt7915: update mt798x_wmac_adie_patch_7976
      dt-bindings: net: wireless: mt76: add interrupts description for MT7986
      wifi: mt76: mt7996: check txs format before getting skb by pid
      wifi: mt76: mt7996: fix TWT issues
      wifi: mt76: mt7996: disable AMSDU for non-data frames
      wifi: mt76: mt7996: remove TXS queue setting

Peter Tsao (1):
      Bluetooth: btusb: Add support Mediatek MT7920

Petr Machata (15):
      selftests: forwarding: Add missing config entries
      selftests: forwarding: Remove duplicated lib.sh content
      net: nexthop: Adjust netlink policy parsing for a new attribute
      net: nexthop: Add NHA_OP_FLAGS
      net: nexthop: Initialize NH group ID in resilient NH group notifiers
      net: nexthop: Have all NH notifiers carry NH ID
      mlxsw: spectrum_router: Rename two functions
      mlxsw: spectrum_router: Have mlxsw_sp_nexthop_counter_enable() return int
      mlxsw: spectrum: Allow fetch-and-clear of flow counters
      mlxsw: spectrum_router: Avoid allocating NH counters twice
      mlxsw: spectrum_router: Add helpers for nexthop counters
      mlxsw: spectrum_router: Track NH ID's of group members
      mlxsw: spectrum_router: Support nexthop group hardware statistics
      mlxsw: spectrum_router: Share nexthop counters in resilient groups
      selftests: forwarding: Add a test for NH group stats

Phil Sutter (3):
      netfilter: uapi: Document NFT_TABLE_F_OWNER flag
      netfilter: nf_tables: Introduce NFT_TABLE_F_PERSIST
      netfilter: nf_tables: Implement table adoption support

Philippe Schenker (2):
      dt-bindings: net: dsa: Add KSZ8567 switch support
      net: dsa: Add KSZ8567 switch support

Ping-Ke Shih (76):
      wifi: rtw89: phy: move bb_gain_info used by WiFi 6 chips to union
      wifi: rtw89: phy: ignore special data from BB parameter file
      wifi: rtw89: 8922a: add NCTL pre-settings for WiFi 7 chips
      wifi: rtw89: phy: add BB wrapper of TX power for WiFi 7 chips
      wifi: rtw89: phy: set channel_info for WiFi 7 chips
      wifi: rtw88: 8822ce: refine power parameters for RFE type 5
      wifi: rtw89: add firmware H2C command of BA CAM V1
      wifi: rtw89: mac: add feature_init to initialize BA CAM V1
      wifi: rtw89: add chip_ops::h2c_ba_cam() to configure BA CAM
      wifi: rtw89: 8922a: update BA CAM number to 24
      wifi: rtw89: fw: use struct to fill BA CAM H2C commands
      wifi: rtw89: refine H2C command that pause transmitting by MAC ID
      wifi: rtw89: add new H2C command to pause/sleep transmitting by MAC ID
      wifi: rtw89: use struct to fill H2C command to download beacon frame
      wifi: rtw89: add H2C command to download beacon frame for WiFi 7 chips
      wifi: rtw89: add chip_ops::update_beacon to abstract update beacon operation
      wifi: rtw89: adjust init_he_cap() to add EHT cap into iftype_data
      wifi: rtw89: change supported bandwidths of chip_info to bit mask
      wifi: rtw89: add EHT capabilities for WiFi 7 chips
      wifi: rtw89: declare EXT NSS BW of VHT capability
      wifi: rtw89: fw: add H2C command to update security CAM v2
      wifi: rtw89: fw: fill CMAC table to associated station for WiFi 7 chips
      wifi: rtw89: fw: add chip_ops to update CMAC table to associated station
      wifi: rtw89: fw: update TX AMPDU parameter to CMAC table
      wifi: rtw89: fw: add H2C command to reset CMAC table for WiFi 7
      wifi: rtw89: fw: add H2C command to reset DMAC table for WiFi 7
      wifi: rtw89: fw: use struct to fill JOIN H2C command
      wifi: rtw89: fw: extend JOIN H2C command to support WiFi 7 chips
      wifi: rtl8xxxu: convert EN_DESC_ID of TX descriptor to le32 type
      wifi: rtl8xxxu: make instances of iface limit and combination to be static const
      wifi: rtw89: add mlo_dbcc_mode for WiFi 7 chips
      wifi: rtw89: 8922a: add chip_ops::{enable,disable}_bb_rf
      wifi: rtw89: 8922a: add chip_ops related to BB init
      wifi: rtw89: 8922a: add register definitions of H2C, C2H, page, RRSR and EDCCA
      wifi: rtw89: 8922a: add TX power related ops
      wifi: rtw89: pci: update SER timer unit and timeout time
      wifi: rtw89: pci: validate RX tag for RXQ and RPQ
      wifi: rtw89: pci: enlarge RX DMA buffer to consider size of RX descriptor
      wifi: rtw89: 8922a: hook handlers of TX/RX descriptors to chip_ops
      wifi: rtw89: 8922a: implement {stop,resume}_sch_tx and cfg_ppdu
      wifi: rtw89: 8922a: add chip_ops::cfg_txrx_path
      wifi: rtw89: 8922a: add RF read/write v2
      wifi: rtw89: 8922a: add chip_ops to get thermal value
      wifi: rtw89: 8922a: set chip_ops FEM and GPIO to NULL
      wifi: rtw89: rfk: add a completion to wait RF calibration report from C2H event
      wifi: rtw89: rfk: send channel information to firmware for RF calibrations
      wifi: rtw89: rfk: add H2C command to trigger IQK
      wifi: rtw89: rfk: add H2C command to trigger RX DCK
      wifi: rtw89: rfk: add H2C command to trigger DPK
      wifi: rtw89: rfk: add H2C command to trigger DACK
      wifi: rtw89: rfk: add H2C command to trigger TXGAPK
      wifi: rtw89: rfk: add H2C command to trigger TSSI
      wifi: rtw89: 8922a: rfk: implement chip_ops to call RF calibrations
      wifi: rtw89: 8922a: add chip_ops::rfk_init_late to do initial RF calibrations later
      wifi: rtw89: 8922a: add chip_ops::rfk_hw_init
      wifi: rtw89: fw: consider checksum length of security data
      wifi: rtw89: fw: read firmware secure information from efuse
      wifi: rtw89: fw: parse secure section from firmware file
      wifi: rtw89: fw: download firmware with key data for secure boot
      wifi: rtw89: correct PHY register offset for PHY-1
      wifi: rtw89: load BB parameters to PHY-1
      wifi: rtw89: mac: return held quota of DLE when changing MAC-1
      wifi: rtw89: mac: correct MUEDCA setting for MAC-1
      wifi: rtw89: mac: reset PHY-1 hardware when going to enable/disable
      wifi: rtw89: use PLCP information to match BSS_COLOR and AID
      wifi: rtw89: 8922a: correct register definition and merge IO for ctrl_nbtg_bt_tx()
      wifi: rtw89: change qutoa to DBCC by default for WiFi 7 chips
      wifi: rtw89: fw: remove unnecessary rcu_read_unlock() for punctured
      wifi: rtw89: 8922a: add set_channel MAC part
      wifi: rtw89: 8922a: add set_channel BB part
      wifi: rtw89: 8922a: add set_channel RF part
      wifi: rtw89: 8922a: add helper of set_channel
      wifi: rtl8xxxu: check vif before using in rtl8xxxu_tx()
      wifi: rtlwifi: set initial values for unexpected cases of USB endpoint priority
      wifi: rtw89: mac: add coexistence helpers {cfg/get}_plt
      wifi: rtw89: 8922a: add coexistence helpers of SW grant

Po-Hao Huang (12):
      wifi: rtw89: refine add_chan H2C command to encode_bits
      wifi: rtw89: refine hardware scan C2H events
      wifi: rtw89: Set default CQM config if not present
      wifi: rtw89: disable RTS when broadcast/multicast
      wifi: rtw89: fix null pointer access when abort scan
      wifi: rtw89: add wait/completion for abort scan
      wifi: rtw89: update scan C2H messages for wifi 7 IC
      wifi: rtw89: debug: add FW log component for scan
      wifi: rtw89: prepare scan leaf functions for wifi 7 ICs
      wifi: rtw89: 8922a: add ieee80211_ops::hw_scan
      wifi: rtw89: 8922a: add more fields to beacon H2C command to support multi-links
      wifi: rtw89: reference quota mode when setting Tx power

Prabhav Kumar Vaish (1):
      selftests: net: Correct couple of spelling mistakes

Praveen Kumar Kannoju (1):
      bonding: rate-limit bonding driver inspect messages

Przemek Kitszel (1):
      ice: fix stats being updated by way too large values

Pu Lehui (8):
      riscv, bpf: Unify 32-bit sign-extension to emit_sextw
      riscv, bpf: Unify 32-bit zero-extension to emit_zextw
      riscv, bpf: Simplify sext and zext logics in branch instructions
      riscv, bpf: Add necessary Zbb instructions
      riscv, bpf: Optimize sign-extention mov insns with Zbb support
      riscv, bpf: Optimize bswap insns with Zbb support
      riscv, bpf: Enable inline bpf_kptr_xchg() for RV64
      selftests/bpf: Enable inline bpf_kptr_xchg() test for RV64

Puranjay Mohan (7):
      arm64: stacktrace: Implement arch_bpf_stack_walk() for the BPF JIT
      bpf, arm64: support exceptions
      arm64: patching: implement text_poke API
      bpf, arm64: use bpf_prog_pack for memory management
      bpf, riscv64/cfi: Support kCFI + BPF on riscv64
      arm64, bpf: Use bpf_prog_pack for arm64 bpf trampoline
      bpf: hardcode BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()

Quan Zhou (1):
      wifi: mt76: mt7925: add flow to avoid chip bt function fail

Rafał Miłecki (1):
      dt-bindings: net: wireless: mt76: allow all 4 interrupts for MT7981

Rahul Rameshbabu (4):
      wifi: b43: Stop/wake correct queue in DMA Tx path when QoS is disabled
      wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
      wifi: b43: Stop correct queue in DMA worker when QoS is disabled
      wifi: b43: Disable QoS for bcm4331

Raj Kumar Bhagat (5):
      wifi: ath12k: add firmware-2.bin support
      wifi: ath12k: fix fetching MCBC flag for QCN9274
      wifi: ath12k: split hal_ops to support RX TLVs word mask compaction
      wifi: ath12k: remove hal_desc_sz from hw params
      wifi: ath12k: disable QMI PHY capability learn in split-phy QCN9274

Raju Lakkaraju (1):
      net: phy: mxl-gpy: fill in possible_interfaces for GPY21x chipset

Rameshkumar Sundaram (1):
      wifi: mac80211: remove only link keys during stopping link AP

Randy Dunlap (3):
      net: filter: fix spelling mistakes
      tipc: socket: remove Excess struct member kernel-doc warning
      tipc: node: remove Excess struct member kernel-doc warnings

Ravi Gunasekaran (1):
      dt-bindings: net: ti: Update maintainers list

Ricardo B. Marliere (27):
      ssb: make ssb_bustype const
      bcma: make bcma_bus_type const
      netdevsim: make nsim_bus const
      net: mdio_bus: make mdio_bus_type const
      net: usbnet: constify the struct device_type usage
      net: dsa: constify the struct device_type usage
      net: bridge: constify the struct device_type usage
      net: vxlan: constify the struct device_type usage
      net: ppp: constify the struct device_type usage
      net: geneve: constify the struct device_type usage
      net: hsr: constify the struct device_type usage
      net: l2tp: constify the struct device_type usage
      net: vlan: constify the struct device_type usage
      net: netdevsim: constify the struct device_type usage
      net: wwan: core: constify the struct device_type usage
      net: hso: constify the struct device_type usage
      net: hns: make hnae_class constant
      net: wan: framer: make framer_class constant
      net: ppp: make ppp_class constant
      net: wwan: hwsim: make wwan_hwsim_class constant
      net: wwan: core: make wwan_class constant
      nfc: core: make nfc_class constant
      ieee802154: cfg802154: make wpan_phy_class constant
      Bluetooth: constify the struct device_type usage
      isdn: mISDN: make elements_class constant
      isdn: capi: make capi_class constant
      ptp: make ptp_class constant

Robert Marko (8):
      net: phy: qcom: add support for QCA807x PHY Family
      net: phy: aquantia: clear PMD Global Transmit Disable bit during init
      net: phy: qca807x: move interface mode check to .config_init_once
      net: dsa: mv88e6xxx: rename mv88e6xxx_g2_scratch_gpio_set_smi
      net: dsa: mv88e6xxx: add Amethyst specific SMI GPIO function
      net: phy: qcom: qca808x: add helper for checking for 1G only model
      net: phy: qcom: qca808x: fill in possible_interfaces
      net: phy: qca807x: fix compilation when CONFIG_GPIOLIB is not set

Rohan G Thomas (3):
      net: stmmac: Offload queueMaxSDU from tc-taprio
      net: stmmac: est: Per Tx-queue error count for HLBF
      net: stmmac: Report taprio offload status

Roman Smirnov (2):
      Bluetooth: mgmt: remove NULL check in mgmt_set_connectable_complete()
      Bluetooth: mgmt: remove NULL check in add_ext_adv_params_complete()

Ruan Jinjie (1):
      wifi: mwifiex: Use helpers to check multicast addresses

Russell King (1):
      net: add helpers for EEE configuration

Russell King (Oracle) (10):
      net: phy: constify phydev->drv
      net: stmmac: remove eee_enabled/eee_active in stmmac_ethtool_op_get_eee()
      net: sxgbe: remove eee_enabled/eee_active in sxgbe_get_eee()
      net: fec: remove eee_enabled/eee_active in fec_enet_get_eee()
      net: bcmgenet: remove eee_enabled/eee_active in bcmgenet_get_eee()
      net: bcmasp: remove eee_enabled/eee_active in bcmasp_get_eee()
      net: dsa: b53: remove eee_enabled/eee_active in b53_get_mac_eee()
      net: phy: marvell: add comment about m88e1111_config_init_1000basex()
      net: pcs: rzn1-miic: update PCS driver to use neg_mode
      net: dsa: mv88e6xxx: update 88e6185 PCS driver to use neg_mode

Sagi Maimon (1):
      ptp: ocp: add Adva timecard support

Sai Krishna (1):
      octeontx2-pf: Add TC flower offload support for TCP flags

Samuel Thibault (1):
      PPPoL2TP: Add more code snippets

Sarosh Hasan (1):
      net: stmmac: dwmac-qcom-ethqos: Update link clock rate only for RGMII

Sebastian Andrzej Siewior (1):
      net: dst: Make dst_destroy() static and return void.

Serge Semin (4):
      net: pcs: xpcs: Drop sentinel entry from 2500basex ifaces list
      net: pcs: xpcs: Drop redundant workqueue.h include directive
      net: pcs: xpcs: Return EINVAL in the internal methods
      net: pcs: xpcs: Explicitly return error on caps validation

Shailend Chand (6):
      gve: Define config structs for queue allocation
      gve: Refactor napi add and remove functions
      gve: Switch to config-aware queue allocation
      gve: Refactor gve_open and gve_close
      gve: Alloc before freeing when adjusting queues
      gve: Alloc before freeing when changing features

Shannon Nelson (28):
      ionic: set adminq irq affinity
      ionic: add helpers for accessing buffer info
      ionic: use dma range APIs
      ionic: add initial framework for XDP support
      ionic: Add XDP packet headroom
      ionic: Add XDP_TX support
      ionic: Add XDP_REDIRECT support
      ionic: add ndo_xdp_xmit
      ionic: implement xdp frags support
      pds_core: add simple AER handler
      pds_core: delete VF dev on reset
      pds_core: use pci_reset_function for health reset
      ionic: reduce the use of netdev
      ionic: change MODULE_AUTHOR to person name
      ionic: remove desc, sg_desc and cmb_desc from desc_info
      ionic: drop q mapping
      ionic: move adminq-notifyq handling to main file
      ionic: remove callback pointer from desc_info
      ionic: remove the cq_info to save more memory
      ionic: use specialized desc info structs
      ionic: fold adminq clean into service routine
      ionic: refactor skb building
      ionic: carry idev in ionic_cq struct
      ionic: rearrange ionic_qcq
      ionic: rearrange ionic_queue for better layout
      ionic: remove unnecessary NULL test
      ionic: better dma-map error handling
      ionic: keep stats struct local to error handling

Shaul Triebitz (10):
      wifi: iwlwifi: support link command version 2
      wifi: iwlwifi: mvm: make functions public
      wifi: iwlwifi: mvm: define RX queue sync timeout as a macro
      wifi: iwlwifi: mvm: fix the key PN index
      wifi: iwlwifi: mvm: always update keys in D3 exit
      wifi: iwlwifi: mvm: avoid garbage iPN
      wifi: nl80211: allow reporting wakeup for unprot deauth/disassoc
      wifi: cfg80211: report unprotected deauth/disassoc in wowlan
      wifi: iwlwifi: iwlmvm: handle unprotected deauth/disassoc in d3
      wifi: mac80211: add link id to ieee80211_gtk_rekey_add()

Shayne Chen (3):
      wifi: mt76: mt7915: add locking for accessing mapped registers
      wifi: mt76: mt7996: add locking for accessing mapped registers
      wifi: mt76: connac: set correct muar_idx for mt799x chipsets

Shigeru Yoshida (1):
      tipc: Cleanup tipc_nl_bearer_add() error paths

Shiji Yang (1):
      wifi: rtl8xxxu: fix mixed declarations in rtl8xxxu_set_aifs()

Shiming Cheng (1):
      ipv6: fib6_rules: flush route cache when rule is changed

Shinas Rasheed (8):
      octeon_ep_vf: Add driver framework and device initialization
      octeon_ep_vf: add hardware configuration APIs
      octeon_ep_vf: add VF-PF mailbox communication.
      octeon_ep_vf: add Tx/Rx ring resource setup and cleanup
      octeon_ep_vf: add support for ndo ops
      octeon_ep_vf: add Tx/Rx processing and interrupt support
      octeon_ep_vf: add ethtool support
      octeon_ep_vf: update MAINTAINERS

Shung-Hsi Yu (1):
      selftests/bpf: trace_helpers.c: do not use poisoned type

Simon Horman (3):
      mlx4: Address spelling errors
      net: wan: framer: remove children from struct framer_ops kdoc
      ps3/gelic: minor Kernel Doc corrections

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sneh Shah (1):
      net: stmmac: dwmac-qcom-ethqos: Add support for 2.5G SGMII

Song Yoong Siang (1):
      selftests/bpf: xdp_hw_metadata reduce sleep interval

Souradeep Chakrabarti (1):
      net: mana: Assigning IRQ affinity on HT cores

Sowmiya Sree Elavalagan (1):
      wifi: ath12k: fetch correct pdev id from WMI_SERVICE_READY_EXT_EVENTID

Srinivas Goud (3):
      dt-bindings: can: xilinx_can: Add 'xlnx,has-ecc' optional property
      can: xilinx_can: Add ECC support
      can: xilinx_can: Add ethtool stats interface for ECC errors

Sriram R (2):
      wifi: ath12k: Fix issues in channel list update
      wifi: ath12k: indicate NON MBSSID vdev by default during vdev start

Stanislaw Gruszka (1):
      genetlink: Add per family bind/unbind callbacks

StanleyYP Wang (1):
      wifi: mt76: mt7996: fix efuse reading issue

Stefan Mätje (2):
      MAINTAINERS: add Stefan Mätje as maintainer for the esd electronics GmbH PCIe/402 CAN drivers
      can: esd: add support for esd GmbH PCIe/402 CAN interface family

Stefan Wahren (15):
      qca_spi: Add check for kthread_stop
      qca_spi: Improve SPI thread creation
      qca_spi: Improve SPI IRQ handling
      qca_spi: Avoid skb_copy_expand in TX path
      qca_7k_common: Drop unnecessary function description
      qca_7k_common: Drop unused len from qcafrm_handle
      qca_spi: Add QCASPI prefix to ring defines
      qca_spi: Introduce QCASPI_RX_MAX_FRAMES
      qca_spi: Improve calculation of RX buffer size
      qca_spi: Log expected signature in error case
      qca_spi: Adjust log of SPI_REG_RDBUF_BYTE_AVA
      qca_7k: Replace BSD boilerplate with SPDX
      qca_7k: Replace old mail address
      mailmap: add entry for Stefan Wahren
      MAINTAINERS: add entry for qca7k driver(s)

Stephen Hemminger (2):
      net/tun: use reciprocal_scale
      net: sched: codel replace GPLv2/BSD boilerplate

Suman Ghosh (1):
      octeontx2-af: Add filter profiles in hardware to extract packet headers

Sunil Goutham (1):
      octeontx2-af: Fix devlink params

Suraj Jaiswal (2):
      dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for sa8775p
      net: stmmac: Add driver support for common safety IRQ

Sven Eckelmann (1):
      batman-adv: Drop usage of export.h

Takashi Iwai (2):
      wifi: iwlwifi: Add missing MODULE_FIRMWARE() for *.pnvm
      Bluetooth: btmtk: Add MODULE_FIRMWARE() for MT7922

Takeru Hayasaka (2):
      ethtool: Add GTP RSS hash options to ethtool.h
      ice: Implement RSS settings for GTP using ethtool

Tariq Toukan (15):
      net/mlx5: Add MPIR bit in mcam_access_reg
      net/mlx5: SD, Introduce SD lib
      net/mlx5: SD, Implement basic query and instantiation
      net/mlx5: SD, Implement devcom communication and primary election
      net/mlx5: SD, Implement steering for primary and secondaries
      net/mlx5: SD, Add informative prints in kernel log
      net/mlx5: SD, Add debugfs
      net/mlx5e: Create single netdev per SD group
      net/mlx5e: Create EN core HW resources for all secondary devices
      net/mlx5e: Let channels be SD-aware
      net/mlx5e: Support cross-vhca RSS
      net/mlx5e: Support per-mdev queue counter
      net/mlx5e: Block TLS device offload on combined SD netdev
      net/mlx5: Enable SD feature
      Documentation: networking: Add description for multi-pf netdev

Tejun Heo (1):
      ieee802154: ca8210: Drop spurious WQ_UNBOUND from alloc_ordered_workqueue() call

Thanh Quan (1):
      dt-bindings: net: renesas,etheravb: Add support for R-Car V4M

Tiezhu Yang (4):
      bpftool: Silence build warning about calloc()
      selftests/bpf: Move is_jit_enabled() into testing_helpers
      selftests/bpf: Skip callback tests if jit is disabled in test_verifier
      selftests/bpf: Add missing line break in test_verifier

Tim Pambor (1):
      net: phy: dp83822: Fix RGMII TX delay configuration

Tobias Schramm (1):
      dt-bindings: nfc: ti,trf7970a: fix usage example

Toke Høiland-Jørgensen (5):
      wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is complete
      libbpf: Use OPTS_SET() macro in bpf_xdp_query()
      bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
      bpf: Fix hashtab overflow check on 32-bit arches
      bpf: Fix stackmap overflow check on 32-bit arches

Ulrik Strid (1):
      Bluetooth: btusb: Add new VID/PID 13d3/3602 for MT7925

Uwe Kleine-König (4):
      wifi: ath9k: Convert to platform remove callback returning void
      ptp: fc3: Convert to platform remove callback returning void
      atm: fore200e: Convert to platform remove callback returning void
      net: wan: framer/pef2256: Convert to platform remove callback returning void

Varshini Rajendran (1):
      dt-bindings: net: cdns,macb: add sam9x7 ethernet interface

Venkat Duvvuru (1):
      bnxt_en: Add bnxt_get_total_vnics() to calculate number of VNICs

Victor Nogueira (1):
      selftests: tc-testing: add mirred to block tdc tests

Victor Stewart (1):
      bpf, docs: Fix bpf_redirect_peer header doc

Vikas Gupta (2):
      bnxt_en: Enhance ethtool ntuple support for ip flows besides TCP/UDP
      bnxt_en: Add drop action support for ntuple

Viktor Malik (2):
      tools/resolve_btfids: Refactor set sorting with types from btf_ids.h
      tools/resolve_btfids: Fix cross-compilation to non-host endianness

Vincent Mailhol (1):
      can: change can network drivers maintainer

Vinicius Costa Gomes (2):
      igc: Fix missing time sync events
      igb: Fix missing time sync events

Vinicius Peixoto (1):
      Bluetooth: Add new quirk for broken read key length on ATS2851

Vitaly Lifshits (1):
      e1000e: Minor flow correction in e1000_shutdown function

Vladimir Oltean (6):
      net: dsa: reindent arguments of dsa_user_vlan_for_each()
      net: dsa: qca8k: put MDIO controller OF node if unavailable
      net: dsa: qca8k: consistently use "ret" rather than "err" for error codes
      net: dsa: b53: unexport and move b53_eee_enable_set()
      net: dsa: remove "inline" from dsa_user_netpoll_send_skb()
      net: dsa: tag_sja1105: remove "inline" keyword

Wen Gong (16):
      wifi: ath12k: add string type to search board data in board-2.bin for WCN7850
      wifi: ath12k: add fallback board name without variant while searching board-2.bin
      wifi: ath12k: remove unused ATH12K_BD_IE_BOARD_EXT
      wifi: ath12k: add support to search regdb data in board-2.bin for WCN7850
      wifi: ath11k: add support to select 6 GHz regulatory type
      wifi: ath11k: store cur_regulatory_info for each radio
      wifi: ath11k: update regulatory rules when interface added
      wifi: ath11k: update regulatory rules when connect to AP on 6 GHz band for station
      wifi: ath11k: save power spectral density(PSD) of regulatory rule
      wifi: ath11k: add parse of transmit power envelope element
      wifi: ath11k: save max transmit power in vdev start response event from firmware
      wifi: ath11k: fill parameters for vdev set tpc power WMI command
      wifi: ath11k: add WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT service bit
      wifi: ath11k: add handler for WMI_VDEV_SET_TPC_POWER_CMDID
      wifi: ath11k: use WMI_VDEV_SET_TPC_POWER_CMDID when EXT_TPC_REG_SUPPORT for 6 GHz
      wifi: ath11k: change to move WMI_VDEV_PARAM_SET_HEMU_MODE before WMI_PEER_ASSOC_CMDID

Wen Gu (1):
      net/smc: change the term virtual ISM to Emulated-ISM

Wenli Looi (1):
      wifi: ath9k: delete some unused/duplicate macros

Willem de Bruijn (3):
      selftests/net: calibrate fq_band_pktlimit
      selftests/net: calibrate txtimestamp
      selftests/net: ignore timing errors in so_txtime if KSFT_MACHINE_SLOW

William Tu (3):
      Documentation: mlx5.rst: Add note for eswitch MD
      devlink: Fix length of eswitch inline-mode
      devlink: Add comments to use netlink gen tool

Wojciech Drewek (2):
      ice: Remove and readd netdev during devlink reload
      ice: Fix debugfs with devlink reload

Xin Long (1):
      tipc: rename the module name diag to tipc_diag

Xingyuan Mo (1):
      wifi: ath10k: fix NULL pointer dereference in ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()

Yafang Shao (2):
      selftests/bpf: Fix error checking for cpumask_success__load()
      selftests/bpf: Mark cpumask kfunc declarations as __weak

Yanteng Si (1):
      net: stmmac: fix typo in comment

Yonghong Song (9):
      bpf: Track aligned st store as imprecise spilled registers
      selftests/bpf: Add a selftest with not-8-byte aligned BPF_ST
      docs/bpf: Fix an incorrect statement in verifier.rst
      docs/bpf: Improve documentation of 64-bit immediate instructions
      selftests/bpf: Fix flaky test ptr_untrusted
      selftests/bpf: Fix flaky selftest lwt_redirect/lwt_reroute
      bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly
      selftests/bpf: Ensure fentry prog cannot attach to bpf_spin_{lock,unlcok}()
      bpf: Fix test verif_scale_strobemeta_subprogs failure due to llvm19

Yonglong Liu (1):
      net: hns3: fix kernel crash when 1588 is received on HIP08 devices

Yunjian Wang (2):
      tun: Fix code style issues in <linux/if_tun.h>
      tun: Implement ethtool's get_channels() callback

Yunsheng Lin (5):
      mm/page_alloc: modify page_frag_alloc_align() to accept align as an argument
      page_frag: unify gfp bits for order 3 page allocation
      net: introduce page_frag_cache_drain()
      vhost/net: remove vhost_net_page_frag_refill()
      tools: virtio: introduce vhost_net_test

Yury Norov (3):
      cpumask: add cpumask_weight_andnot()
      cpumask: define cleanup function for cpumasks
      net: mana: add a function to spread IRQs per CPUs

Zheng Wang (1):
      wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

Zhengchao Shao (4):
      ipv6: raw: remove useless input parameter in rawv6_err
      ipv6: raw: remove useless input parameter in rawv6_get/seticmpfilter
      netlabel: remove impossible return value in netlbl_bitmap_walk
      ipv4: raw: remove useless input parameter in do_raw_set/getsockopt

Zhenghao Gu (1):
      wifi: ath11k: fix IOMMU errors on buffer rings

Zhipeng Lu (1):
      wifi: libertas: fix some memleaks in lbs_allocate_cmd_buffer()

Zong-Zhe Yang (15):
      wifi: rtw89: 8852b: update TX power tables to R36
      wifi: rtw89: 8851b: update TX power tables to R37
      wifi: rtw89: pci: interrupt v2 refine IMR for SER
      wifi: rtw89: drop TIMING_BEACON_ONLY and sync beacon TSF by self
      wifi: rtw89: chan: add sub-entity swap function to cover replacing
      wifi: rtw89: chan: tweak bitmap recalc ahead before MLO
      wifi: rtw89: chan: tweak weight recalc ahead before MLO
      wifi: rtw89: chan: move handling from add/remove to assign/unassign for MLO
      wifi: rtw89: chan: MCC take reconfig into account
      wifi: rtw89: differentiate narrow_bw_ru_dis setting according to chip gen
      wifi: rtw89: fw: add definition of H2C command and C2H event for MRC series
      wifi: rtw89: mac: implement MRC C2H event handling
      wifi: rtw89: fw: implement MRC H2C command functions
      wifi: rtw89: chan: support MCC on Wi-Fi 7 chips
      wifi: rtw89: 8922a: declare to support two chanctx

fuyuanli (1):
      tcp: Add skb addr and sock addr to arguments of tracepoint tcp_probe.

rong.yan (1):
      wifi: mt76: mt7925: fix SAP no beacon issue in 5Ghz and 6Ghz band

 .get_maintainer.ignore                             |    1 +
 .mailmap                                           |    1 +
 Documentation/ABI/testing/sysfs-class-net-queues   |   23 +
 Documentation/admin-guide/sysctl/net.rst           |    5 +
 Documentation/bpf/kfuncs.rst                       |    8 +-
 Documentation/bpf/map_lpm_trie.rst                 |    2 +-
 .../bpf/standardization/instruction-set.rst        |  580 ++--
 Documentation/bpf/verifier.rst                     |    2 +-
 Documentation/dev-tools/kselftest.rst              |   12 +
 Documentation/devicetree/bindings/leds/common.yaml |   12 +
 .../devicetree/bindings/leds/leds-bcm63138.yaml    |    4 -
 .../devicetree/bindings/leds/leds-bcm6328.yaml     |    4 -
 .../devicetree/bindings/leds/leds-bcm6358.txt      |    2 -
 .../bindings/leds/leds-pwm-multicolor.yaml         |    4 +-
 .../devicetree/bindings/leds/leds-pwm.yaml         |    5 -
 .../devicetree/bindings/net/brcm,asp-v2.0.yaml     |    4 +
 .../devicetree/bindings/net/brcm,unimac-mdio.yaml  |    1 +
 .../devicetree/bindings/net/can/tcan4x5x.txt       |    3 +
 .../devicetree/bindings/net/can/xilinx,can.yaml    |    5 +
 .../devicetree/bindings/net/cdns,macb.yaml         |    5 +
 .../devicetree/bindings/net/dsa/ar9331.txt         |  147 -
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |    1 +
 .../devicetree/bindings/net/dsa/qca,ar9331.yaml    |  161 +
 .../devicetree/bindings/net/dsa/realtek.yaml       |    4 +-
 .../bindings/net/ethernet-controller.yaml          |    1 -
 .../bindings/net/ethernet-phy-package.yaml         |   52 +
 Documentation/devicetree/bindings/net/fsl,fec.yaml |    3 +
 .../devicetree/bindings/net/nfc/ti,trf7970a.yaml   |    2 +-
 .../devicetree/bindings/net/qca,qca808x.yaml       |   54 +
 .../devicetree/bindings/net/qcom,ethqos.yaml       |    9 +-
 .../devicetree/bindings/net/qcom,ipa.yaml          |    2 +-
 .../devicetree/bindings/net/qcom,ipq4019-mdio.yaml |   15 +
 .../devicetree/bindings/net/qcom,qca807x.yaml      |  184 ++
 .../devicetree/bindings/net/renesas,etheravb.yaml  |    1 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |   17 +-
 .../bindings/net/starfive,jh7110-dwmac.yaml        |   72 +-
 .../devicetree/bindings/net/ti,cpsw-switch.yaml    |    5 +-
 .../devicetree/bindings/net/ti,dp83822.yaml        |   34 +
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |    5 +-
 .../devicetree/bindings/net/ti,k3-am654-cpts.yaml  |    5 +-
 .../bindings/net/wireless/mediatek,mt76.yaml       |   33 +-
 .../bindings/net/wireless/qcom,ath10k.yaml         |    1 +
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |    1 +
 .../bindings/net/wireless/qcom,ath11k.yaml         |    1 +
 Documentation/netlink/genetlink-c.yaml             |   41 +-
 Documentation/netlink/genetlink-legacy.yaml        |   41 +-
 Documentation/netlink/genetlink.yaml               |   21 +-
 Documentation/netlink/netlink-raw.yaml             |   37 +-
 Documentation/netlink/specs/devlink.yaml           |    2 +-
 Documentation/netlink/specs/dpll.yaml              |   40 +
 Documentation/netlink/specs/mptcp_pm.yaml          |    3 +-
 Documentation/netlink/specs/netdev.yaml            |   91 +
 Documentation/netlink/specs/nlctrl.yaml            |  206 ++
 Documentation/netlink/specs/tc.yaml                | 2135 ++++++++++++-
 Documentation/networking/af_xdp.rst                |   31 +-
 Documentation/networking/bonding.rst               |   12 +
 Documentation/networking/can.rst                   |   34 +-
 .../device_drivers/ethernet/amazon/ena.rst         |    6 +
 .../networking/device_drivers/ethernet/index.rst   |    1 +
 .../device_drivers/ethernet/intel/ice.rst          |   21 +-
 .../ethernet/marvell/octeon_ep_vf.rst              |   24 +
 .../networking/device_drivers/wwan/t7xx.rst        |   46 +
 Documentation/networking/devlink/mlx5.rst          |    9 +-
 Documentation/networking/index.rst                 |    1 +
 Documentation/networking/ip-sysctl.rst             |   14 +-
 Documentation/networking/l2tp.rst                  |  137 +-
 Documentation/networking/multi-pf-netdev.rst       |  174 ++
 Documentation/networking/netconsole.rst            |   66 +
 Documentation/networking/netdevices.rst            |    4 +-
 Documentation/networking/sfp-phylink.rst           |  147 +-
 Documentation/networking/statistics.rst            |   15 +
 Documentation/networking/xfrm_device.rst           |    4 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 +
 .../userspace-api/netlink/netlink-raw.rst          |   42 +
 MAINTAINERS                                        |   37 +-
 arch/arm/mm/ioremap.c                              |    8 +-
 arch/arm64/include/asm/patching.h                  |    2 +
 arch/arm64/kernel/patching.c                       |   75 +
 arch/arm64/kernel/stacktrace.c                     |   26 +
 arch/arm64/net/bpf_jit_comp.c                      |  284 +-
 arch/loongarch/kernel/setup.c                      |    2 +-
 arch/mips/loongson64/init.c                        |    2 +-
 arch/powerpc/kernel/isa-bridge.c                   |    4 +-
 arch/riscv/include/asm/cfi.h                       |   17 +
 arch/riscv/kernel/cfi.c                            |   53 +
 arch/riscv/net/bpf_jit.h                           |  136 +-
 arch/riscv/net/bpf_jit_comp32.c                    |    2 +-
 arch/riscv/net/bpf_jit_comp64.c                    |  229 +-
 arch/riscv/net/bpf_jit_core.c                      |    9 +-
 arch/x86/net/bpf_jit_comp.c                        |  236 +-
 drivers/atm/fore200e.c                             |    6 +-
 drivers/bcma/main.c                                |    2 +-
 drivers/bluetooth/btbcm.c                          |   12 +-
 drivers/bluetooth/btintel.c                        |  116 +-
 drivers/bluetooth/btmtk.c                          |    5 +-
 drivers/bluetooth/btmtk.h                          |    1 +
 drivers/bluetooth/btnxpuart.c                      |   27 +-
 drivers/bluetooth/btrtl.c                          |   14 +
 drivers/bluetooth/btusb.c                          |   30 +-
 drivers/bluetooth/hci_h5.c                         |    5 +-
 drivers/bluetooth/hci_qca.c                        |    6 +-
 drivers/bluetooth/hci_serdev.c                     |    9 +-
 drivers/bluetooth/hci_uart.h                       |   12 +-
 drivers/dpll/dpll_core.c                           |   13 +-
 drivers/dpll/dpll_netlink.c                        |    9 +-
 drivers/hid/bpf/hid_bpf_dispatch.c                 |    8 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |    4 +-
 drivers/isdn/capi/capi.c                           |   21 +-
 drivers/isdn/mISDN/dsp_pipeline.c                  |   16 +-
 drivers/media/rc/bpf-lirc.c                        |    2 +-
 drivers/net/amt.c                                  |   10 +-
 drivers/net/arcnet/arcnet.c                        |    1 +
 drivers/net/bareudp.c                              |   25 +-
 drivers/net/bonding/bond_3ad.c                     |  165 +-
 drivers/net/bonding/bond_main.c                    |   56 +-
 drivers/net/bonding/bond_netlink.c                 |   16 +
 drivers/net/bonding/bond_options.c                 |   28 +-
 drivers/net/can/Kconfig                            |    3 +
 drivers/net/can/Makefile                           |    1 +
 drivers/net/can/esd/Kconfig                        |   12 +
 drivers/net/can/esd/Makefile                       |    7 +
 drivers/net/can/esd/esd_402_pci-core.c             |  514 ++++
 drivers/net/can/esd/esdacc.c                       |  764 +++++
 drivers/net/can/esd/esdacc.h                       |  356 +++
 drivers/net/can/kvaser_pciefd.c                    |   62 +-
 drivers/net/can/m_can/m_can.c                      |  579 +++-
 drivers/net/can/m_can/m_can.h                      |   35 +-
 drivers/net/can/m_can/m_can_pci.c                  |    1 +
 drivers/net/can/m_can/m_can_platform.c             |    5 +-
 drivers/net/can/m_can/tcan4x5x-core.c              |   33 +-
 drivers/net/can/softing/softing_fw.c               |    2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |    2 +-
 drivers/net/can/usb/Kconfig                        |    1 +
 drivers/net/can/usb/gs_usb.c                       |    2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |    3 +
 drivers/net/can/vxcan.c                            |    2 +-
 drivers/net/can/xilinx_can.c                       |  169 +-
 drivers/net/dsa/Kconfig                            |    2 +-
 drivers/net/dsa/b53/b53_common.c                   |   42 +-
 drivers/net/dsa/b53/b53_priv.h                     |    7 +-
 drivers/net/dsa/bcm_sf2.c                          |    2 +-
 drivers/net/dsa/microchip/ksz8795.c                |  410 ++-
 drivers/net/dsa/microchip/ksz8795_reg.h            |    1 +
 drivers/net/dsa/microchip/ksz9477_i2c.c            |    4 +
 drivers/net/dsa/microchip/ksz_common.c             |  112 +-
 drivers/net/dsa/microchip/ksz_common.h             |    2 +
 drivers/net/dsa/microchip/ksz_spi.c                |    5 +
 drivers/net/dsa/mt7530-mdio.c                      |    7 +-
 drivers/net/dsa/mt7530.c                           |  574 ++--
 drivers/net/dsa/mt7530.h                           |   38 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   11 +-
 drivers/net/dsa/mv88e6xxx/global2.h                |    4 +-
 drivers/net/dsa/mv88e6xxx/global2_scratch.c        |   35 +-
 drivers/net/dsa/mv88e6xxx/pcs-6185.c               |    3 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   19 +-
 drivers/net/dsa/qca/qca8k-common.c                 |    4 +-
 drivers/net/dsa/qca/qca8k.h                        |    4 +-
 drivers/net/dsa/realtek/Kconfig                    |   20 +-
 drivers/net/dsa/realtek/Makefile                   |   13 +-
 drivers/net/dsa/realtek/realtek-mdio.c             |  205 +-
 drivers/net/dsa/realtek/realtek-mdio.h             |   48 +
 drivers/net/dsa/realtek/realtek-smi.c              |  279 +-
 drivers/net/dsa/realtek/realtek-smi.h              |   48 +
 drivers/net/dsa/realtek/realtek.h                  |   14 +-
 drivers/net/dsa/realtek/rtl8365mb.c                |  132 +-
 drivers/net/dsa/realtek/rtl8366-core.c             |   22 +-
 drivers/net/dsa/realtek/rtl8366rb.c                |  119 +-
 drivers/net/dsa/realtek/rtl83xx.c                  |  335 +++
 drivers/net/dsa/realtek/rtl83xx.h                  |   24 +
 drivers/net/dummy.c                                |   11 +-
 drivers/net/ethernet/Kconfig                       |    3 -
 drivers/net/ethernet/adi/adin1110.c                |   10 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |  323 +-
 drivers/net/ethernet/amazon/ena/ena_com.h          |    7 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.c      |   49 +-
 drivers/net/ethernet/amazon/ena/ena_eth_com.h      |   39 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  181 +-
 drivers/net/ethernet/amazon/ena/ena_regs_defs.h    |    1 +
 drivers/net/ethernet/amazon/ena/ena_xdp.c          |    1 -
 drivers/net/ethernet/amd/pds_core/adminq.c         |   10 +-
 drivers/net/ethernet/amd/pds_core/auxbus.c         |   18 +-
 drivers/net/ethernet/amd/pds_core/core.c           |   95 +-
 drivers/net/ethernet/amd/pds_core/core.h           |    4 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c        |    8 +-
 drivers/net/ethernet/amd/pds_core/dev.c            |   22 +-
 drivers/net/ethernet/amd/pds_core/main.c           |   47 +-
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |   25 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |   90 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.h        |   25 +-
 .../net/ethernet/broadcom/asp2/bcmasp_ethtool.c    |   12 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  210 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |   23 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |   50 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.c   |   14 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  921 ++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   74 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  466 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.h  |    6 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   16 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |    2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   11 +-
 drivers/net/ethernet/broadcom/tg3.c                |   54 +-
 drivers/net/ethernet/broadcom/tg3.h                |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |   14 -
 drivers/net/ethernet/cisco/enic/enic_main.c        |    2 +-
 drivers/net/ethernet/ec_bhf.c                      |    1 +
 drivers/net/ethernet/engleder/tsnep_main.c         |   36 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |    4 +-
 drivers/net/ethernet/freescale/fec.h               |    2 +-
 drivers/net/ethernet/freescale/fec_main.c          |  148 +-
 drivers/net/ethernet/freescale/gianfar.c           |    4 +-
 drivers/net/ethernet/google/gve/gve.h              |  171 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |   50 +-
 drivers/net/ethernet/google/gve/gve_adminq.h       |   20 +-
 drivers/net/ethernet/google/gve/gve_dqo.h          |   18 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c      |   62 +-
 drivers/net/ethernet/google/gve/gve_main.c         |  936 +++---
 drivers/net/ethernet/google/gve/gve_rx.c           |  135 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |  159 +-
 drivers/net/ethernet/google/gve/gve_tx.c           |  128 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |  108 +-
 drivers/net/ethernet/google/gve/gve_utils.c        |   48 +-
 drivers/net/ethernet/google/gve/gve_utils.h        |    8 +
 drivers/net/ethernet/hisilicon/hns/hnae.c          |   13 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |    2 +
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |    2 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.h    |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c   |    2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |    2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |    4 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |    3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |    2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   44 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   11 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |    7 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |    2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   16 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |    1 +
 drivers/net/ethernet/i825xx/sun3_82586.c           |    2 +-
 drivers/net/ethernet/intel/Kconfig                 |    9 +
 drivers/net/ethernet/intel/e100.c                  |    4 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c        |   23 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |    8 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |   93 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c      |    4 -
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |   10 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   97 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   13 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  567 ++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    4 -
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   13 +-
 drivers/net/ethernet/intel/ice/ice.h               |    5 +-
 drivers/net/ethernet/intel/ice/ice_arfs.c          |    1 +
 drivers/net/ethernet/intel/ice/ice_base.c          |  134 +-
 drivers/net/ethernet/intel/ice/ice_base.h          |   10 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |  183 +-
 drivers/net/ethernet/intel/ice/ice_common.h        |   12 +-
 drivers/net/ethernet/intel/ice/ice_controlq.c      |    2 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c           |    4 +
 drivers/net/ethernet/intel/ice/ice_debugfs.c       |   13 +-
 drivers/net/ethernet/intel/ice/ice_devids.h        |    8 +
 drivers/net/ethernet/intel/ice/ice_devlink.c       |   68 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |    2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   95 +-
 drivers/net/ethernet/intel/ice/ice_flow.h          |   31 +-
 drivers/net/ethernet/intel/ice/ice_fwlog.c         |    2 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |  221 +-
 drivers/net/ethernet/intel/ice/ice_lib.h           |   12 -
 drivers/net/ethernet/intel/ice/ice_main.c          |  275 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  233 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   34 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |    1 -
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      |    8 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |    1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |   10 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |    5 -
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   31 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h      |    9 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c |    3 -
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   22 +-
 drivers/net/ethernet/intel/idpf/idpf.h             |  146 +-
 drivers/net/ethernet/intel/idpf/idpf_controlq.c    |    7 +-
 .../net/ethernet/intel/idpf/idpf_controlq_api.h    |    5 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c         |    1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   39 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c        |    6 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |    1 +
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c      |    3 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    | 2296 +++++++-------
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h    |   70 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |   43 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   27 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |    2 +-
 drivers/net/ethernet/intel/igc/Makefile            |    1 +
 drivers/net/ethernet/intel/igc/igc.h               |   10 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |   25 +-
 drivers/net/ethernet/intel/igc/igc_leds.c          |  280 ++
 drivers/net/ethernet/intel/igc/igc_main.c          |   41 +-
 drivers/net/ethernet/intel/igc/igc_regs.h          |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h           |   16 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |   72 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |  155 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    |  266 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.h    |  112 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c       |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.h       |   10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c |   26 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.h |   24 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.h |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   70 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   62 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       |   46 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |   10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       |  244 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |   54 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |    8 +-
 .../net/ethernet/intel/ixgbe/ixgbe_txrx_common.h   |    7 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |  189 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |   66 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h      |   18 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |  300 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |   17 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |    2 +-
 drivers/net/ethernet/marvell/Kconfig               |    1 +
 drivers/net/ethernet/marvell/Makefile              |    1 +
 drivers/net/ethernet/marvell/mvneta.c              |    4 +-
 drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig  |   19 +
 drivers/net/ethernet/marvell/octeon_ep_vf/Makefile |   10 +
 .../ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c  |  489 +++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c  |  500 ++++
 .../marvell/octeon_ep_vf/octep_vf_config.h         |  160 +
 .../marvell/octeon_ep_vf/octep_vf_ethtool.c        |  273 ++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.c  | 1231 ++++++++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.h  |  334 +++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c  |  430 +++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_mbox.h  |  166 +
 .../marvell/octeon_ep_vf/octep_vf_regs_cn9k.h      |  154 +
 .../marvell/octeon_ep_vf/octep_vf_regs_cnxk.h      |  162 +
 .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.c    |  510 ++++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.h    |  224 ++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_tx.c    |  330 ++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_tx.h    |  276 ++
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |    4 +
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |   16 +-
 .../ethernet/marvell/octeontx2/af/npc_profile.h    |  621 +++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |   16 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |   32 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |    4 +
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |   20 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  188 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |    8 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |    8 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |    3 +
 .../net/ethernet/marvell/octeontx2/af/rvu_sdp.c    |   14 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |   11 +
 drivers/net/ethernet/mediatek/mtk_wed_wo.c         |   17 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c           |    7 +-
 drivers/net/ethernet/mellanox/mlx4/cq.c            |    4 +-
 drivers/net/ethernet/mellanox/mlx4/en_clock.c      |    4 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |    6 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |    2 +-
 drivers/net/ethernet/mellanox/mlx4/en_tx.c         |    2 +-
 drivers/net/ethernet/mellanox/mlx4/eq.c            |    2 +-
 drivers/net/ethernet/mellanox/mlx4/fw_qos.h        |    8 +-
 drivers/net/ethernet/mellanox/mlx4/main.c          |    4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_stats.h    |    2 +-
 drivers/net/ethernet/mellanox/mlx4/port.c          |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |   32 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    9 +-
 .../net/ethernet/mellanox/mlx5/core/en/channels.c  |   10 +-
 .../net/ethernet/mellanox/mlx5/core/en/channels.h  |    6 +-
 .../ethernet/mellanox/mlx5/core/en/monitor_stats.c |   48 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   33 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |    3 -
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |    8 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |    4 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |    3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c   |  125 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h   |    9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c   |   17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h   |    4 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    |   62 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c  |   11 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/pool.c  |    6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |    8 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   26 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |    1 -
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |   25 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |    1 -
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c      |    1 -
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.c    |    2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.h    |    4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  187 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |   39 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |   45 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h |   12 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   |  524 ++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h   |   38 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   38 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    7 -
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c   |    9 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |   21 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_dbg.c  |  734 ++++-
 .../ethernet/mellanox/mlx5/core/steering/dr_dbg.h  |   20 +
 .../mellanox/mlxbf_gige/mlxbf_gige_ethtool.c       |   36 +
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_regs.h |   30 +
 .../mellanox/mlxsw/core_acl_flex_actions.c         |   16 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c   |    9 +-
 drivers/net/ethernet/mellanox/mlxsw/minimal.c      |    1 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  168 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |   19 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c |   13 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    |   17 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_dpipe.c   |   22 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_mr_tcam.c |    2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  333 ++-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.h  |    6 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |    8 +-
 drivers/net/ethernet/microchip/encx24j600-regmap.c |    5 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |    4 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |    2 +-
 drivers/net/ethernet/microchip/lan743x_ptp.c       |    4 +-
 .../microchip/lan966x/lan966x_vcap_debugfs.c       |    2 +
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   86 +-
 drivers/net/ethernet/mscc/ocelot.c                 |    1 +
 drivers/net/ethernet/netronome/nfp/flower/action.c |    2 +-
 .../net/ethernet/netronome/nfp/flower/lag_conf.c   |    5 +
 drivers/net/ethernet/nvidia/forcedeth.c            |    4 +-
 drivers/net/ethernet/pensando/ionic/ionic.h        |    2 +
 .../net/ethernet/pensando/ionic/ionic_debugfs.c    |    2 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |  105 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   90 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |    5 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  372 ++-
 drivers/net/ethernet/pensando/ionic/ionic_lif.h    |   23 +-
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |  117 +-
 drivers/net/ethernet/pensando/ionic/ionic_stats.c  |   18 +
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |  945 ++++--
 drivers/net/ethernet/pensando/ionic/ionic_txrx.h   |    4 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_init.c   |    2 -
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |    2 -
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   64 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |    2 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |    3 +-
 drivers/net/ethernet/qualcomm/emac/emac.c          |    1 +
 drivers/net/ethernet/qualcomm/qca_7k.c             |   17 +-
 drivers/net/ethernet/qualcomm/qca_7k.h             |   16 +-
 drivers/net/ethernet/qualcomm/qca_7k_common.c      |   17 +-
 drivers/net/ethernet/qualcomm/qca_7k_common.h      |   29 +-
 drivers/net/ethernet/qualcomm/qca_debug.c          |   21 +-
 drivers/net/ethernet/qualcomm/qca_debug.h          |   15 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |   71 +-
 drivers/net/ethernet/qualcomm/qca_spi.h            |   22 +-
 drivers/net/ethernet/qualcomm/qca_uart.c           |   17 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |    1 +
 drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c    |    2 +-
 drivers/net/ethernet/realtek/r8169.h               |    4 +
 drivers/net/ethernet/realtek/r8169_leds.c          |  145 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  271 +-
 drivers/net/ethernet/realtek/r8169_phy_config.c    |    7 +
 drivers/net/ethernet/renesas/Kconfig               |    1 +
 drivers/net/ethernet/renesas/ravb.h                |   60 +-
 drivers/net/ethernet/renesas/ravb_main.c           | 1205 ++++----
 drivers/net/ethernet/rocker/rocker_main.c          |    2 -
 drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h  |    1 -
 drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c |    6 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c    |    1 -
 drivers/net/ethernet/sfc/efx_common.c              |    2 +-
 drivers/net/ethernet/sfc/falcon/efx.c              |    2 +-
 drivers/net/ethernet/sfc/rx_common.c               |    1 +
 drivers/net/ethernet/sfc/siena/efx_common.c        |    2 +-
 drivers/net/ethernet/sfc/siena/rx_common.c         |    1 +
 drivers/net/ethernet/sfc/siena/tx_common.c         |    5 +-
 drivers/net/ethernet/sfc/tx_common.c               |    5 +-
 drivers/net/ethernet/sfc/tx_tso.c                  |    4 +-
 drivers/net/ethernet/smsc/smc91x.c                 |    1 +
 drivers/net/ethernet/smsc/smsc911x.c               |    1 +
 drivers/net/ethernet/smsc/smsc9420.c               |    1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |    6 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |    3 +
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |   35 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |   32 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/mmc.h          |    4 -
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |    3 -
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |    3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c   |    6 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |    8 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   69 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |    2 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    8 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |   87 +-
 drivers/net/ethernet/sun/sunvnet_common.c          |    4 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c        |    4 +-
 drivers/net/ethernet/ti/cpsw-common.c              |    1 +
 drivers/net/ethernet/ti/cpsw_ethtool.c             |    4 +-
 drivers/net/ethernet/ti/cpsw_priv.h                |    4 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c      |    4 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |    4 -
 drivers/net/ethernet/toshiba/ps3_gelic_net.c       |    8 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |    2 -
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   22 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |    1 -
 drivers/net/ethernet/wangxun/txgbe/Makefile        |    1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c     |  269 ++
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h     |    7 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |  141 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   82 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h     |    3 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |   17 +
 drivers/net/ethernet/wiznet/w5300.c                |    3 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |    3 +-
 drivers/net/ethernet/xircom/xirc2ps_cs.c           |    4 +-
 drivers/net/geneve.c                               |   40 +-
 drivers/net/gtp.c                                  |   39 +-
 drivers/net/ieee802154/at86rf230.c                 |    5 +-
 drivers/net/ieee802154/ca8210.c                    |   10 +-
 drivers/net/ieee802154/mcr20a.c                    |    5 +-
 drivers/net/ieee802154/mrf24j40.c                  |    4 +-
 drivers/net/ipa/ipa.h                              |    5 +-
 drivers/net/ipa/ipa_cmd.c                          |    6 +-
 drivers/net/ipa/ipa_endpoint.c                     |   29 +-
 drivers/net/ipa/ipa_interrupt.c                    |  119 +-
 drivers/net/ipa/ipa_interrupt.h                    |   30 +-
 drivers/net/ipa/ipa_main.c                         |   60 +-
 drivers/net/ipa/ipa_mem.c                          |   37 +-
 drivers/net/ipa/ipa_mem.h                          |    5 +-
 drivers/net/ipa/ipa_modem.c                        |  110 +-
 drivers/net/ipa/ipa_power.c                        |  108 +-
 drivers/net/ipa/ipa_power.h                        |   29 -
 drivers/net/ipa/ipa_qmi.c                          |   10 +-
 drivers/net/ipa/ipa_reg.c                          |    8 +-
 drivers/net/ipa/ipa_reg.h                          |    4 +-
 drivers/net/ipa/ipa_smp2p.c                        |   33 +-
 drivers/net/ipa/ipa_smp2p.h                        |    7 +-
 drivers/net/ipa/ipa_table.c                        |   18 +-
 drivers/net/ipa/ipa_uc.c                           |    9 +-
 drivers/net/ipvlan/ipvlan_main.c                   |    2 +-
 drivers/net/loopback.c                             |    1 +
 drivers/net/macsec.c                               |   12 +-
 drivers/net/macvlan.c                              |    2 +-
 drivers/net/mdio/mdio-bcm-unimac.c                 |   94 +-
 drivers/net/mdio/mdio-ipq4019.c                    |  109 +-
 drivers/net/mdio/of_mdio.c                         |   79 +-
 drivers/net/netconsole.c                           |  359 ++-
 drivers/net/netdevsim/bus.c                        |  149 +-
 drivers/net/netdevsim/netdev.c                     |   53 +-
 drivers/net/netdevsim/netdevsim.h                  |    3 +
 drivers/net/netkit.c                               |    2 +-
 drivers/net/nlmon.c                                |   24 +-
 drivers/net/pcs/pcs-lynx.c                         |    1 +
 drivers/net/pcs/pcs-mtk-lynxi.c                    |    1 +
 drivers/net/pcs/pcs-rzn1-miic.c                    |    5 +-
 drivers/net/pcs/pcs-xpcs.c                         |   18 +-
 drivers/net/phy/Kconfig                            |    8 +-
 drivers/net/phy/Makefile                           |    2 +-
 drivers/net/phy/adin1100.c                         |   55 +
 drivers/net/phy/aquantia/aquantia_main.c           |  103 +
 drivers/net/phy/at803x.c                           | 2432 ---------------
 drivers/net/phy/broadcom.c                         |    3 +-
 drivers/net/phy/dp83822.c                          |  211 +-
 drivers/net/phy/dp83867.c                          |   22 +
 drivers/net/phy/marvell-88q2xxx.c                  |  644 +++-
 drivers/net/phy/marvell-88x2222.c                  |    2 -
 drivers/net/phy/marvell.c                          |    7 +-
 drivers/net/phy/mdio_bus.c                         |   48 +-
 drivers/net/phy/micrel.c                           |  109 +-
 drivers/net/phy/mxl-gpy.c                          |   20 +-
 drivers/net/phy/phy-c45.c                          |  139 +-
 drivers/net/phy/phy.c                              |   61 +-
 drivers/net/phy/phy_device.c                       |  208 +-
 drivers/net/phy/phylink.c                          |    8 +-
 drivers/net/phy/qcom/Kconfig                       |   30 +
 drivers/net/phy/qcom/Makefile                      |    6 +
 drivers/net/phy/qcom/at803x.c                      | 1106 +++++++
 drivers/net/phy/qcom/qca807x.c                     |  849 ++++++
 drivers/net/phy/qcom/qca808x.c                     |  663 ++++
 drivers/net/phy/qcom/qca83xx.c                     |  275 ++
 drivers/net/phy/qcom/qcom-phy-lib.c                |  676 +++++
 drivers/net/phy/qcom/qcom.h                        |  243 ++
 drivers/net/phy/realtek.c                          |   44 +-
 drivers/net/phy/xilinx_gmii2rgmii.c                |    2 +-
 drivers/net/ppp/ppp_generic.c                      |   20 +-
 drivers/net/team/team.c                            |    2 -
 drivers/net/tun.c                                  |   34 +-
 drivers/net/usb/Kconfig                            |    1 +
 drivers/net/usb/ax88179_178a.c                     |   20 +-
 drivers/net/usb/cdc_mbim.c                         |    2 +-
 drivers/net/usb/hso.c                              |    2 +-
 drivers/net/usb/lan78xx.c                          |    4 +-
 drivers/net/usb/r8152.c                            |   49 +-
 drivers/net/usb/sr9800.c                           |    4 +-
 drivers/net/usb/usbnet.c                           |   13 +-
 drivers/net/veth.c                                 |   77 +-
 drivers/net/vsockmon.c                             |   19 +-
 drivers/net/vxlan/vxlan_core.c                     |   78 +-
 drivers/net/wan/Kconfig                            |   12 +
 drivers/net/wan/Makefile                           |    1 +
 drivers/net/wan/framer/framer-core.c               |   30 +-
 drivers/net/wan/framer/pef2256/pef2256.c           |    6 +-
 drivers/net/wan/fsl_qmc_hdlc.c                     |  797 +++++
 drivers/net/wireguard/receive.c                    |    2 +-
 drivers/net/wireless/admtek/adm8211.c              |    4 +
 drivers/net/wireless/ath/ar5523/ar5523.c           |    4 +
 drivers/net/wireless/ath/ath10k/core.c             |    4 +-
 drivers/net/wireless/ath/ath10k/coredump.h         |    8 +-
 drivers/net/wireless/ath/ath10k/htt.c              |    3 +-
 drivers/net/wireless/ath/ath10k/htt.h              |   12 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   12 +-
 drivers/net/wireless/ath/ath10k/pci.c              |   10 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |   11 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h          |    4 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   26 +-
 drivers/net/wireless/ath/ath10k/wmi.h              |   62 +-
 drivers/net/wireless/ath/ath11k/core.c             |  108 +-
 drivers/net/wireless/ath/ath11k/core.h             |   42 +
 drivers/net/wireless/ath/ath11k/dp.c               |   20 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |    6 +-
 drivers/net/wireless/ath/ath11k/hal.c              |   19 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    3 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |    4 +-
 drivers/net/wireless/ath/ath11k/hw.c               |    2 +-
 drivers/net/wireless/ath/ath11k/hw.h               |    1 +
 drivers/net/wireless/ath/ath11k/mac.c              | 1200 ++++++--
 drivers/net/wireless/ath/ath11k/mac.h              |    5 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |   73 +-
 drivers/net/wireless/ath/ath11k/pci.c              |   62 +-
 drivers/net/wireless/ath/ath11k/pci.h              |    3 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |   11 +
 drivers/net/wireless/ath/ath11k/qmi.c              |    5 +-
 drivers/net/wireless/ath/ath11k/reg.c              |  267 +-
 drivers/net/wireless/ath/ath11k/reg.h              |   11 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |    2 +-
 drivers/net/wireless/ath/ath11k/thermal.c          |    5 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  303 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |  151 +-
 drivers/net/wireless/ath/ath12k/Makefile           |    4 +-
 drivers/net/wireless/ath/ath12k/core.c             |  270 +-
 drivers/net/wireless/ath/ath12k/core.h             |   84 +-
 drivers/net/wireless/ath/ath12k/dp.c               |   25 +-
 drivers/net/wireless/ath/ath12k/dp.h               |   20 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |    9 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  166 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   30 +-
 drivers/net/wireless/ath/ath12k/fw.c               |  171 ++
 drivers/net/wireless/ath/ath12k/fw.h               |   33 +
 drivers/net/wireless/ath/ath12k/hal.c              |  415 ++-
 drivers/net/wireless/ath/ath12k/hal.h              |   20 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |   20 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |   15 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   33 +-
 drivers/net/wireless/ath/ath12k/hw.h               |   55 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 1307 +++++---
 drivers/net/wireless/ath/ath12k/mac.h              |    4 +-
 drivers/net/wireless/ath/ath12k/mhi.c              |   52 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |  142 +
 drivers/net/wireless/ath/ath12k/p2p.h              |   23 +
 drivers/net/wireless/ath/ath12k/pci.c              |   94 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    6 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  429 ++-
 drivers/net/wireless/ath/ath12k/qmi.h              |   35 +-
 drivers/net/wireless/ath/ath12k/reg.c              |   13 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h          |  116 +-
 drivers/net/wireless/ath/ath12k/trace.h            |   29 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  330 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |  202 +-
 drivers/net/wireless/ath/ath5k/mac80211-ops.c      |    4 +
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |    2 +-
 drivers/net/wireless/ath/ath9k/ahb.c               |    6 +-
 drivers/net/wireless/ath/ath9k/antenna.c           |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.h        |    9 -
 drivers/net/wireless/ath/ath9k/beacon.c            |    4 +-
 drivers/net/wireless/ath/ath9k/htc.h               |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c    |    4 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |    4 +
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |    4 +
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |    4 -
 drivers/net/wireless/ath/ath9k/main.c              |    4 +
 drivers/net/wireless/ath/ath9k/reg_aic.h           |    4 -
 drivers/net/wireless/ath/ath9k/wmi.c               |   10 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |    3 +-
 drivers/net/wireless/ath/carl9170/main.c           |    4 +
 drivers/net/wireless/ath/carl9170/tx.c             |    2 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    4 +
 drivers/net/wireless/atmel/at76c50x-usb.c          |    4 +
 drivers/net/wireless/broadcom/b43/b43.h            |   16 +
 drivers/net/wireless/broadcom/b43/dma.c            |    4 +-
 drivers/net/wireless/broadcom/b43/main.c           |   20 +-
 drivers/net/wireless/broadcom/b43/phy_ht.c         |    6 +-
 drivers/net/wireless/broadcom/b43/phy_n.c          |    4 +-
 drivers/net/wireless/broadcom/b43/pio.c            |    6 +-
 drivers/net/wireless/broadcom/b43legacy/main.c     |    4 +
 .../broadcom/brcm80211/brcmfmac/bca/core.c         |   30 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   76 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |    2 +
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |   18 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |   12 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.h    |    2 +-
 .../broadcom/brcm80211/brcmfmac/cyw/core.c         |   50 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/dmi.c |    9 +
 .../wireless/broadcom/brcm80211/brcmfmac/feature.c |   11 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |  152 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.h    |   60 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.c    |  116 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.h    |  125 +-
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwvid.c   |   13 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwvid.h   |   48 +-
 .../broadcom/brcm80211/brcmfmac/wcc/core.c         |   31 +-
 .../net/wireless/broadcom/brcm80211/brcmsmac/led.c |    1 -
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c      |    4 +
 .../broadcom/brcm80211/brcmsmac/phy/phy_cmn.c      |    6 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_int.h      |    2 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c      |    2 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        |   27 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.c         |    5 +-
 .../broadcom/brcm80211/brcmsmac/phy_shim.h         |    2 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |    4 +
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    4 +
 drivers/net/wireless/intel/iwlegacy/common.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/Kconfig         |    9 +
 drivers/net/wireless/intel/iwlwifi/Makefile        |    3 +
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |   10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   11 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   40 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |    4 +
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  623 +---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |  220 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h   |   14 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |    8 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |    1 +
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   27 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h    |   10 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   32 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |   17 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   40 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h     |    4 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   27 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    2 -
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   23 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   27 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |   49 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |  500 ++++
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |  199 ++
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   22 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |  427 ++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |  210 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   22 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   67 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   31 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |   10 +-
 .../net/wireless/intel/iwlwifi/iwl-eeprom-parse.c  |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        |   36 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   75 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |    2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   69 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |  132 +
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  150 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   55 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   10 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |    9 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  346 +--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   27 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   38 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  234 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |   36 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |   11 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  162 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   87 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  100 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |   40 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   29 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |   16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |    2 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   30 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   51 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c        |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   34 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    3 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  192 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   82 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |    2 +
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |    2 +-
 .../net/wireless/intel/iwlwifi/pcie/ctxt-info.c    |    4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   49 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   11 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |   18 +-
 drivers/net/wireless/intel/iwlwifi/tests/Makefile  |    7 +
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |   54 +
 drivers/net/wireless/intel/iwlwifi/tests/module.c  |   10 +
 drivers/net/wireless/intersil/p54/main.c           |    4 +
 drivers/net/wireless/marvell/libertas/cmd.c        |   13 +-
 drivers/net/wireless/marvell/libertas_tf/main.c    |    4 +
 drivers/net/wireless/marvell/mwifiex/11h.c         |    2 +-
 drivers/net/wireless/marvell/mwifiex/11n.c         |   12 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    2 +-
 drivers/net/wireless/marvell/mwifiex/debugfs.c     |   22 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |    2 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |    2 -
 drivers/net/wireless/marvell/mwifiex/scan.c        |   14 +-
 drivers/net/wireless/marvell/mwifiex/wmm.c         |    2 +-
 drivers/net/wireless/marvell/mwl8k.c               |    4 +
 drivers/net/wireless/mediatek/mt76/Makefile        |    2 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c        |    2 +-
 drivers/net/wireless/mediatek/mt76/dma.c           |  106 +-
 drivers/net/wireless/mediatek/mt76/dma.h           |    9 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   32 +-
 drivers/net/wireless/mediatek/mt76/mmio.c          |  107 -
 drivers/net/wireless/mediatek/mt76/mt76.h          |   61 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    4 +
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |    5 +
 .../net/wireless/mediatek/mt76/mt76_connac2_mac.h  |    5 +
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |    7 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |    7 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |    4 +
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |    4 +
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |    4 +
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c  |    2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci_main.c   |    4 +
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |    1 +
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c   |    4 +
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |    9 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |   55 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    1 +
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |    6 +
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   13 +
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |    1 +
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   13 +
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |    2 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |   56 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   26 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |  212 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |   94 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |    1 +
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |    3 +
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    2 +
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.c   |   38 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |    8 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |   15 +-
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h   |    8 +
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |   72 +-
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   81 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   11 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   34 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   74 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |    6 +-
 drivers/net/wireless/mediatek/mt76/usb.c           |   52 +-
 drivers/net/wireless/mediatek/mt76/wed.c           |  213 ++
 drivers/net/wireless/mediatek/mt7601u/main.c       |    4 +
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   16 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |  110 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   95 +-
 drivers/net/wireless/microchip/wilc1000/netdev.h   |    6 +
 drivers/net/wireless/microchip/wilc1000/spi.c      |   81 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   42 +-
 drivers/net/wireless/microchip/wilc1000/wlan.h     |   11 +
 drivers/net/wireless/purelifi/plfxlc/mac.c         |    5 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c     |    2 +-
 drivers/net/wireless/ralink/rt2x00/rt2400pci.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2500pci.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2500usb.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |    8 +-
 drivers/net/wireless/ralink/rt2x00/rt2800pci.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2800soc.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2800usb.c     |    4 +
 drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c  |    5 +-
 drivers/net/wireless/ralink/rt2x00/rt61pci.c       |    4 +
 drivers/net/wireless/ralink/rt2x00/rt73usb.c       |    4 +
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |    4 +
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    4 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   28 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c |    3 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c |    2 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c |   33 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c |    1 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |  596 +++-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h  |   15 +
 drivers/net/wireless/realtek/rtlwifi/core.c        |    4 +
 drivers/net/wireless/realtek/rtlwifi/efuse.c       |   36 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h       |    4 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   13 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/trx.c   |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/def.h   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/mac.c   |    3 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   |  109 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.h   |    3 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/trx.c   |    6 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |  195 +-
 drivers/net/wireless/realtek/rtlwifi/usb.h         |    2 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   43 +-
 drivers/net/wireless/realtek/rtw88/debug.c         |   44 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |    7 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    4 +
 drivers/net/wireless/realtek/rtw88/main.c          |    2 -
 drivers/net/wireless/realtek/rtw88/pci.c           |    4 +
 drivers/net/wireless/realtek/rtw88/phy.c           |    3 +
 drivers/net/wireless/realtek/rtw88/reg.h           |    3 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |   46 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   40 +
 drivers/net/wireless/realtek/rtw89/cam.c           |   61 +
 drivers/net/wireless/realtek/rtw89/cam.h           |  109 +
 drivers/net/wireless/realtek/rtw89/chan.c          |  648 +++-
 drivers/net/wireless/realtek/rtw89/chan.h          |    5 +
 drivers/net/wireless/realtek/rtw89/coex.c          |  393 ++-
 drivers/net/wireless/realtek/rtw89/coex.h          |   21 +
 drivers/net/wireless/realtek/rtw89/core.c          |  382 ++-
 drivers/net/wireless/realtek/rtw89/core.h          |  362 ++-
 drivers/net/wireless/realtek/rtw89/debug.c         |    9 +-
 drivers/net/wireless/realtek/rtw89/efuse.h         |    1 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c      |  142 +
 drivers/net/wireless/realtek/rtw89/fw.c            | 2494 +++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h            | 1522 +++++++---
 drivers/net/wireless/realtek/rtw89/mac.c           |  341 ++-
 drivers/net/wireless/realtek/rtw89/mac.h           |   93 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   19 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  363 ++-
 drivers/net/wireless/realtek/rtw89/pci.c           |  215 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   67 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |  121 +-
 drivers/net/wireless/realtek/rtw89/phy.c           | 1105 ++++++-
 drivers/net/wireless/realtek/rtw89/phy.h           |  113 +
 drivers/net/wireless/realtek/rtw89/phy_be.c        |  331 ++
 drivers/net/wireless/realtek/rtw89/ps.c            |   10 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |  572 +++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  160 +-
 .../net/wireless/realtek/rtw89/rtw8851b_table.c    |   72 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   78 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   82 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.c    |  142 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   81 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      | 1773 ++++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |  378 +++
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h  |   18 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    3 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |   50 +-
 drivers/net/wireless/rsi/rsi_91x_mac80211.c        |    8 +-
 drivers/net/wireless/rsi/rsi_91x_usb.c             |   12 +-
 drivers/net/wireless/silabs/wfx/sta.c              |   19 +-
 drivers/net/wireless/st/cw1200/cw1200_sdio.c       |   42 +-
 drivers/net/wireless/st/cw1200/cw1200_spi.c        |   77 +-
 drivers/net/wireless/st/cw1200/main.c              |    4 +
 drivers/net/wireless/ti/wl1251/main.c              |    4 +
 drivers/net/wireless/ti/wlcore/event.c             |    2 +-
 drivers/net/wireless/ti/wlcore/main.c              |    6 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |    9 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  147 +-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |    5 +-
 drivers/net/wireless/virtual/virt_wifi.c           |    2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_def.h       |    2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |    4 +
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |    5 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.c             |   47 +-
 drivers/net/wwan/t7xx/t7xx_hif_cldma.h             |   18 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.c             |   14 +-
 drivers/net/wwan/t7xx/t7xx_modem_ops.h             |    1 +
 drivers/net/wwan/t7xx/t7xx_pci.c                   |  103 +-
 drivers/net/wwan/t7xx/t7xx_pci.h                   |   14 +-
 drivers/net/wwan/t7xx/t7xx_port.h                  |    4 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c            |  114 +-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h            |   10 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c             |  115 +-
 drivers/net/wwan/t7xx/t7xx_reg.h                   |   24 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c         |  134 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.h         |    1 +
 drivers/net/wwan/wwan_core.c                       |   36 +-
 drivers/net/wwan/wwan_hwsim.c                      |   16 +-
 drivers/nvme/host/tcp.c                            |    7 +-
 drivers/nvme/target/tcp.c                          |    4 +-
 drivers/pci/pci.c                                  |    4 +-
 drivers/ptp/Kconfig                                |   12 +
 drivers/ptp/Makefile                               |    1 +
 drivers/ptp/ptp_clock.c                            |   68 +-
 drivers/ptp/ptp_fc3.c                              | 1014 +++++++
 drivers/ptp/ptp_fc3.h                              |   45 +
 drivers/ptp/ptp_ocp.c                              |  311 +-
 drivers/ptp/ptp_private.h                          |    2 +-
 drivers/ptp/ptp_sysfs.c                            |   13 +-
 drivers/ptp/ptp_vclock.c                           |    2 +-
 drivers/ssb/main.c                                 |    2 +-
 drivers/staging/vt6655/device_main.c               |    6 +-
 drivers/staging/vt6656/main_usb.c                  |    6 +-
 drivers/vhost/net.c                                |   91 +-
 fs/eventpoll.c                                     |  131 +-
 fs/verity/measure.c                                |    4 +-
 include/linux/bitfield.h                           |    3 +-
 include/linux/bitmap.h                             |  113 +
 include/linux/bpf-cgroup.h                         |    3 +-
 include/linux/bpf.h                                |  202 +-
 include/linux/bpf_local_storage.h                  |   30 +-
 include/linux/bpf_types.h                          |    1 +
 include/linux/bpf_verifier.h                       |   16 +-
 include/linux/btf.h                                |   36 +-
 include/linux/btf_ids.h                            |   21 +-
 include/linux/cpumask.h                            |   16 +
 include/linux/dpll.h                               |    1 +
 include/linux/dynamic_queue_limits.h               |   45 +
 include/linux/ethtool.h                            |   14 +-
 include/linux/filter.h                             |   28 +-
 include/linux/framer/framer-provider.h             |   15 +-
 include/linux/gfp.h                                |   16 +-
 include/linux/ieee80211.h                          |  169 +-
 include/linux/if_tun.h                             |   16 +-
 include/linux/inet_diag.h                          |    1 +
 include/linux/inetdevice.h                         |   14 +-
 include/linux/io.h                                 |    7 +
 include/linux/ipv6.h                               |   14 +-
 include/linux/lsm_hook_defs.h                      |   15 +-
 include/linux/marvell_phy.h                        |    1 +
 include/linux/mdio.h                               |   63 +
 include/linux/mfd/idtRC38xxx_reg.h                 |  273 ++
 include/linux/mlx5/driver.h                        |    1 +
 include/linux/mlx5/mlx5_ifc.h                      |   13 +-
 include/linux/net.h                                |    5 +-
 include/linux/netdevice.h                          |  132 +-
 include/linux/netfilter.h                          |    1 -
 include/linux/netlink.h                            |    2 +
 include/linux/phy.h                                |   53 +-
 include/linux/phylink.h                            |    7 +-
 include/linux/platform_data/brcmfmac.h             |    2 +-
 include/linux/platform_data/mdio-bcm-unimac.h      |    3 +
 include/linux/platform_data/microchip-ksz.h        |    1 +
 include/linux/platform_data/net-cw1200.h           |    4 -
 include/linux/ptp_clock_kernel.h                   |    3 +
 include/linux/rtnetlink.h                          |    3 +
 include/linux/security.h                           |   43 +-
 include/linux/skbuff.h                             |  141 +-
 include/linux/sock_diag.h                          |   10 +-
 include/linux/stmmac.h                             |    1 +
 include/linux/tcp.h                                |   10 +-
 include/linux/udp.h                                |   10 +
 include/linux/units.h                              |    5 +-
 include/linux/vmalloc.h                            |    5 +
 include/linux/wwan.h                               |    2 +
 include/net/act_api.h                              |    2 +
 include/net/addrconf.h                             |    7 +-
 include/net/af_unix.h                              |   22 +-
 include/net/bluetooth/bluetooth.h                  |    2 +
 include/net/bluetooth/hci.h                        |   19 +-
 include/net/bluetooth/hci_core.h                   |   37 +-
 include/net/bluetooth/hci_sync.h                   |   22 +-
 include/net/bluetooth/l2cap.h                      |   44 +-
 include/net/bond_3ad.h                             |    2 +
 include/net/bond_options.h                         |    1 +
 include/net/bonding.h                              |   23 +
 include/net/busy_poll.h                            |    4 +
 include/net/cfg80211.h                             |  138 +-
 include/net/cfg802154.h                            |    1 +
 include/net/dropreason-core.h                      |   26 +-
 include/net/dsa.h                                  |    4 +-
 include/net/dst.h                                  |    1 -
 include/net/eee.h                                  |   38 +
 include/net/genetlink.h                            |    6 +-
 include/net/gro.h                                  |   46 +-
 include/net/hotdata.h                              |   52 +
 include/net/if_inet6.h                             |    4 +-
 include/net/inet_sock.h                            |    1 +
 include/net/ioam6.h                                |    4 +
 include/net/ip6_fib.h                              |   52 +-
 include/net/ip6_route.h                            |    5 +-
 include/net/ip_fib.h                               |    1 +
 include/net/ip_tunnels.h                           |    3 +-
 include/net/ipv6.h                                 |    8 +-
 include/net/mac80211.h                             |  163 +-
 include/net/mctp.h                                 |    6 +-
 include/net/net_namespace.h                        |    5 +-
 include/net/netdev_queues.h                        |   56 +
 include/net/netfilter/nf_queue.h                   |    1 -
 include/net/netfilter/nf_tables.h                  |    6 +
 include/net/netlabel.h                             |    7 +-
 include/net/netmem.h                               |   41 +
 include/net/nexthop.h                              |   34 +-
 include/net/nfc/nfc.h                              |    2 +-
 include/net/page_pool/types.h                      |   13 +-
 include/net/pkt_cls.h                              |    2 +
 include/net/pkt_sched.h                            |    2 +
 include/net/protocol.h                             |    3 +
 include/net/request_sock.h                         |   39 +
 include/net/route.h                                |    7 +-
 include/net/rps.h                                  |  125 +
 include/net/rtnetlink.h                            |    1 +
 include/net/scm.h                                  |    1 +
 include/net/sctp/structs.h                         |    5 +-
 include/net/sock.h                                 |  177 +-
 include/net/tcp.h                                  |   51 +-
 include/net/xfrm.h                                 |   14 +-
 include/trace/events/napi.h                        |   33 +
 include/trace/events/rxrpc.h                       |  200 +-
 include/trace/events/tcp.h                         |   16 +-
 include/uapi/linux/bpf.h                           |  122 +-
 include/uapi/linux/can.h                           |    9 +-
 include/uapi/linux/can/isotp.h                     |    1 +
 include/uapi/linux/can/raw.h                       |   16 +
 include/uapi/linux/devlink.h                       |    5 +-
 include/uapi/linux/dpll.h                          |   30 +
 include/uapi/linux/ethtool.h                       |   48 +
 include/uapi/linux/eventpoll.h                     |   13 +
 include/uapi/linux/if_link.h                       |    1 +
 include/uapi/linux/ioam6_genl.h                    |   20 +
 include/uapi/linux/mctp.h                          |   32 +
 include/uapi/linux/mdio.h                          |    4 +
 include/uapi/linux/netdev.h                        |   20 +
 include/uapi/linux/netfilter/nf_tables.h           |    6 +-
 include/uapi/linux/nexthop.h                       |   45 +
 include/uapi/linux/nl80211.h                       |   71 +-
 include/uapi/linux/ptp_clock.h                     |   13 +-
 include/uapi/linux/tc_act/tc_pedit.h               |    2 +-
 init/Kconfig                                       |    5 -
 kernel/bpf/Kconfig                                 |    1 +
 kernel/bpf/Makefile                                |    5 +-
 kernel/bpf/arena.c                                 |  558 ++++
 kernel/bpf/arraymap.c                              |    2 +-
 kernel/bpf/bpf_iter.c                              |    4 +-
 kernel/bpf/bpf_local_storage.c                     |   52 +-
 kernel/bpf/bpf_lsm.c                               |   21 +-
 kernel/bpf/bpf_struct_ops.c                        |  773 +++--
 kernel/bpf/bpf_struct_ops_types.h                  |   12 -
 kernel/bpf/btf.c                                   |  574 +++-
 kernel/bpf/cgroup.c                                |   11 +-
 kernel/bpf/core.c                                  |   46 +-
 kernel/bpf/cpumap.c                                |    4 +-
 kernel/bpf/cpumask.c                               |    4 +-
 kernel/bpf/devmap.c                                |   11 +-
 kernel/bpf/disasm.c                                |   14 +
 kernel/bpf/hashtab.c                               |   14 +-
 kernel/bpf/helpers.c                               |   23 +-
 kernel/bpf/inode.c                                 |  276 +-
 kernel/bpf/log.c                                   |   65 +-
 kernel/bpf/lpm_trie.c                              |   20 +-
 kernel/bpf/map_iter.c                              |    4 +-
 kernel/bpf/stackmap.c                              |    9 +-
 kernel/bpf/syscall.c                               |  298 +-
 kernel/bpf/token.c                                 |  278 ++
 kernel/bpf/trampoline.c                            |    4 +-
 kernel/bpf/verifier.c                              |  744 +++--
 kernel/cgroup/rstat.c                              |    4 +-
 kernel/configs/debug.config                        |    6 +
 kernel/events/core.c                               |    8 +-
 kernel/trace/bpf_trace.c                           |   27 +-
 lib/bitmap.c                                       |    7 +
 lib/dynamic_queue_limits.c                         |   74 +
 lib/test_bitmap.c                                  |   42 +
 lib/test_blackhole_dev.c                           |    3 +-
 mm/page_alloc.c                                    |   22 +-
 mm/vmalloc.c                                       |   83 +-
 net/8021q/vlan_dev.c                               |   30 +-
 net/8021q/vlanproc.c                               |   46 +-
 net/Kconfig                                        |    1 +
 net/Makefile                                       |    2 +-
 net/batman-adv/distributed-arp-table.c             |    3 +-
 net/batman-adv/main.c                              |   14 +-
 net/batman-adv/main.h                              |    2 +-
 net/batman-adv/netlink.c                           |    1 -
 net/bluetooth/6lowpan.c                            |    4 +-
 net/bluetooth/Kconfig                              |    8 -
 net/bluetooth/Makefile                             |    1 -
 net/bluetooth/a2mp.c                               | 1054 -------
 net/bluetooth/a2mp.h                               |  154 -
 net/bluetooth/af_bluetooth.c                       |   10 +-
 net/bluetooth/amp.c                                |  590 ----
 net/bluetooth/amp.h                                |   60 -
 net/bluetooth/bnep/core.c                          |    5 +-
 net/bluetooth/eir.c                                |   29 +-
 net/bluetooth/hci_conn.c                           |  200 +-
 net/bluetooth/hci_core.c                           |  170 +-
 net/bluetooth/hci_event.c                          |  236 +-
 net/bluetooth/hci_request.c                        |    2 +-
 net/bluetooth/hci_sock.c                           |    4 +-
 net/bluetooth/hci_sync.c                           |  447 ++-
 net/bluetooth/iso.c                                |  104 +-
 net/bluetooth/l2cap_core.c                         | 1079 +------
 net/bluetooth/l2cap_sock.c                         |   21 +-
 net/bluetooth/mgmt.c                               |  120 +-
 net/bluetooth/msft.c                               |    3 +
 net/bluetooth/sco.c                                |    3 +-
 net/bpf/bpf_dummy_struct_ops.c                     |   36 +-
 net/bpf/test_run.c                                 |   12 +-
 net/bridge/br.c                                    |   15 +-
 net/bridge/br_device.c                             |   27 +-
 net/bridge/br_fdb.c                                |    5 +-
 net/bridge/br_netlink.c                            |    3 +-
 net/bridge/br_vlan.c                               |    4 +-
 net/bridge/netfilter/Kconfig                       |    7 +
 net/bridge/netfilter/Makefile                      |    2 +-
 net/can/af_can.c                                   |    2 +
 net/can/bcm.c                                      |   69 +-
 net/can/isotp.c                                    |    5 +-
 net/can/raw.c                                      |  104 +-
 net/core/Makefile                                  |    1 +
 net/core/dev.c                                     |  419 +--
 net/core/dev.h                                     |    7 +-
 net/core/dst.c                                     |    6 +-
 net/core/filter.c                                  |  173 +-
 net/core/gro.c                                     |   40 +-
 net/core/gro_cells.c                               |    3 +-
 net/core/gso.c                                     |    4 +-
 net/core/hotdata.c                                 |   22 +
 net/core/link_watch.c                              |   13 +-
 net/core/net-procfs.c                              |   55 +-
 net/core/net-sysfs.c                               |  137 +-
 net/core/net_namespace.c                           |   33 +-
 net/core/netdev-genl-gen.c                         |   12 +
 net/core/netdev-genl-gen.h                         |    2 +
 net/core/netdev-genl.c                             |  227 +-
 net/core/page_pool.c                               |   64 +-
 net/core/page_pool_user.c                          |    2 -
 net/core/rtnetlink.c                               |  132 +-
 net/core/scm.c                                     |    5 +
 net/core/skbuff.c                                  |  196 +-
 net/core/sock.c                                    |   82 +-
 net/core/sock_diag.c                               |  120 +-
 net/core/sysctl_net_core.c                         |   34 +-
 net/core/xdp.c                                     |   15 +-
 net/dccp/ackvec.c                                  |    8 +-
 net/dccp/diag.c                                    |    1 +
 net/devlink/netlink_gen.c                          |    2 +-
 net/dsa/dsa.c                                      |    7 +-
 net/dsa/tag_sja1105.c                              |    4 +-
 net/dsa/user.c                                     |   28 +-
 net/ethtool/eee.c                                  |   62 +-
 net/ethtool/ioctl.c                                |   60 +-
 net/ethtool/netlink.c                              |   14 +-
 net/hsr/hsr_device.c                               |   30 +-
 net/ieee802154/6lowpan/core.c                      |    3 +-
 net/ieee802154/socket.c                            |    1 +
 net/ieee802154/sysfs.c                             |    2 +-
 net/ieee802154/sysfs.h                             |    2 +-
 net/ipv4/af_inet.c                                 |   53 +-
 net/ipv4/bpf_tcp_ca.c                              |   26 +-
 net/ipv4/cipso_ipv4.c                              |    5 +-
 net/ipv4/datagram.c                                |    2 +-
 net/ipv4/devinet.c                                 |  309 +-
 net/ipv4/fib_frontend.c                            |   51 +-
 net/ipv4/fib_trie.c                                |    6 +-
 net/ipv4/fou_bpf.c                                 |    4 +-
 net/ipv4/fou_core.c                                |    2 +-
 net/ipv4/gre_offload.c                             |    2 +-
 net/ipv4/igmp.c                                    |    4 +-
 net/ipv4/inet_connection_sock.c                    |    7 +-
 net/ipv4/inet_diag.c                               |  101 +-
 net/ipv4/inet_hashtables.c                         |    3 +-
 net/ipv4/inetpeer.c                                |    5 +-
 net/ipv4/ip_gre.c                                  |   24 +-
 net/ipv4/ip_output.c                               |    3 +-
 net/ipv4/ip_sockglue.c                             |   13 +-
 net/ipv4/ip_tunnel.c                               |   53 +-
 net/ipv4/ip_vti.c                                  |    8 +-
 net/ipv4/ipip.c                                    |    8 +-
 net/ipv4/ipmr.c                                    |   13 +-
 net/ipv4/netfilter/Kconfig                         |   44 +-
 net/ipv4/netfilter/Makefile                        |    2 +-
 net/ipv4/nexthop.c                                 |  367 ++-
 net/ipv4/proc.c                                    |    2 +-
 net/ipv4/raw.c                                     |   20 +-
 net/ipv4/raw_diag.c                                |    1 +
 net/ipv4/route.c                                   |    9 +-
 net/ipv4/syncookies.c                              |   61 +-
 net/ipv4/tcp.c                                     |    9 +-
 net/ipv4/tcp_ao.c                                  |    2 +-
 net/ipv4/tcp_bbr.c                                 |    4 +-
 net/ipv4/tcp_cong.c                                |    6 +-
 net/ipv4/tcp_cubic.c                               |    4 +-
 net/ipv4/tcp_dctcp.c                               |    4 +-
 net/ipv4/tcp_diag.c                                |    1 +
 net/ipv4/tcp_input.c                               |   49 +-
 net/ipv4/tcp_ipv4.c                                |   17 +-
 net/ipv4/tcp_minisocks.c                           |   10 +-
 net/ipv4/tcp_offload.c                             |   36 +-
 net/ipv4/udp.c                                     |   14 +-
 net/ipv4/udp_diag.c                                |    2 +
 net/ipv4/udp_offload.c                             |   17 +-
 net/ipv4/xfrm4_input.c                             |    2 +-
 net/ipv6/addrconf.c                                |  782 ++---
 net/ipv6/af_inet6.c                                |    3 +-
 net/ipv6/anycast.c                                 |   61 +-
 net/ipv6/calipso.c                                 |    5 +-
 net/ipv6/exthdrs.c                                 |   34 +-
 net/ipv6/fib6_rules.c                              |    6 +
 net/ipv6/inet6_hashtables.c                        |    8 +-
 net/ipv6/ioam6.c                                   |   72 +-
 net/ipv6/ip6_fib.c                                 |   92 +-
 net/ipv6/ip6_gre.c                                 |   14 +-
 net/ipv6/ip6_input.c                               |    6 +-
 net/ipv6/ip6_offload.c                             |   18 +-
 net/ipv6/ip6_output.c                              |   12 +-
 net/ipv6/ip6_tunnel.c                              |   25 +-
 net/ipv6/ip6_vti.c                                 |   13 +-
 net/ipv6/ip6mr.c                                   |    9 +-
 net/ipv6/ipv6_sockglue.c                           |    8 +-
 net/ipv6/mcast.c                                   |   15 +-
 net/ipv6/ndisc.c                                   |   84 +-
 net/ipv6/netfilter/Kconfig                         |   20 +-
 net/ipv6/netfilter/Makefile                        |    2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |    4 +-
 net/ipv6/netfilter/nf_reject_ipv6.c                |    4 +-
 net/ipv6/output_core.c                             |    4 +-
 net/ipv6/raw.c                                     |   22 +-
 net/ipv6/reassembly.c                              |    4 +-
 net/ipv6/route.c                                   |   47 +-
 net/ipv6/seg6_hmac.c                               |    8 +-
 net/ipv6/sit.c                                     |   27 +-
 net/ipv6/syncookies.c                              |   31 +-
 net/ipv6/tcp_ipv6.c                                |   39 +-
 net/ipv6/tcpv6_offload.c                           |   16 +-
 net/ipv6/udp.c                                     |   24 +-
 net/ipv6/udp_offload.c                             |   21 +-
 net/ipv6/xfrm6_input.c                             |    2 +-
 net/ipv6/xfrm6_tunnel.c                            |    5 +-
 net/iucv/af_iucv.c                                 |   10 +-
 net/iucv/iucv.c                                    |   15 +-
 net/kcm/kcmsock.c                                  |   18 +-
 net/l2tp/l2tp_eth.c                                |    2 +-
 net/l2tp/l2tp_ip.c                                 |    2 +-
 net/l2tp/l2tp_ppp.c                                |    4 +-
 net/mac80211/Makefile                              |    2 +-
 net/mac80211/agg-tx.c                              |    2 +-
 net/mac80211/cfg.c                                 |  374 ++-
 net/mac80211/chan.c                                |  710 ++---
 net/mac80211/debug.h                               |   18 +-
 net/mac80211/debugfs.c                             |    3 +-
 net/mac80211/driver-ops.c                          |   14 +-
 net/mac80211/driver-ops.h                          |   27 +-
 net/mac80211/ht.c                                  |    6 +-
 net/mac80211/ibss.c                                |   55 +-
 net/mac80211/ieee80211_i.h                         |  205 +-
 net/mac80211/iface.c                               |   36 +-
 net/mac80211/key.c                                 |   20 +-
 net/mac80211/link.c                                |   15 +-
 net/mac80211/main.c                                |  231 +-
 net/mac80211/mesh.c                                |  162 +-
 net/mac80211/mesh.h                                |    3 +-
 net/mac80211/mesh_pathtbl.c                        |    6 +-
 net/mac80211/mesh_plink.c                          |   28 +-
 net/mac80211/mlme.c                                | 3156 +++++++++++---------
 net/mac80211/ocb.c                                 |    5 +-
 net/mac80211/offchannel.c                          |   21 +-
 net/mac80211/parse.c                               |  971 ++++++
 net/mac80211/rate.c                                |   14 +-
 net/mac80211/rx.c                                  |   53 +-
 net/mac80211/scan.c                                |   64 +-
 net/mac80211/spectmgmt.c                           |  337 ++-
 net/mac80211/sta_info.c                            |   21 +-
 net/mac80211/sta_info.h                            |   20 +-
 net/mac80211/tdls.c                                |   73 +-
 net/mac80211/tests/elems.c                         |    5 +-
 net/mac80211/trace.h                               |  201 +-
 net/mac80211/trace_msg.h                           |    2 -
 net/mac80211/tx.c                                  |   60 +-
 net/mac80211/util.c                                | 1806 ++++-------
 net/mac80211/vht.c                                 |   52 +-
 net/mac80211/wpa.c                                 |   33 +-
 net/mac802154/llsec.c                              |   18 +-
 net/mctp/Kconfig                                   |    1 +
 net/mctp/af_mctp.c                                 |  117 +-
 net/mctp/route.c                                   |  105 +-
 net/mctp/test/route-test.c                         |  413 ++-
 net/mctp/test/utils.c                              |    2 +
 net/mpls/af_mpls.c                                 |    4 +-
 net/mpls/mpls_gso.c                                |    3 +
 net/mpls/mpls_iptunnel.c                           |    2 -
 net/mptcp/diag.c                                   |    1 -
 net/mptcp/mptcp_diag.c                             |    2 +-
 net/mptcp/mptcp_pm_gen.c                           |    7 +-
 net/mptcp/mptcp_pm_gen.h                           |    2 +-
 net/mptcp/options.c                                |   20 +-
 net/mptcp/pm.c                                     |   29 +-
 net/mptcp/pm_netlink.c                             |  137 +-
 net/mptcp/pm_userspace.c                           |  221 +-
 net/mptcp/protocol.c                               |  107 +-
 net/mptcp/protocol.h                               |   93 +-
 net/mptcp/sockopt.c                                |   73 +-
 net/mptcp/subflow.c                                |   12 +-
 net/mptcp/token_test.c                             |    7 +-
 net/netfilter/Kconfig                              |   12 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |    4 +-
 net/netfilter/nf_bpf_link.c                        |    2 +-
 net/netfilter/nf_conncount.c                       |    8 +-
 net/netfilter/nf_conntrack_bpf.c                   |    4 +-
 net/netfilter/nf_conntrack_core.c                  |    2 +-
 net/netfilter/nf_conntrack_expect.c                |    4 +-
 net/netfilter/nf_log.c                             |    9 +-
 net/netfilter/nf_nat_bpf.c                         |    4 +-
 net/netfilter/nf_queue.c                           |  106 -
 net/netfilter/nf_synproxy_core.c                   |    2 +-
 net/netfilter/nf_tables_api.c                      |   35 +-
 net/netfilter/nfnetlink_queue.c                    |  142 +
 net/netfilter/nft_osf.c                            |   11 +-
 net/netfilter/nft_set_pipapo.c                     |  193 +-
 net/netfilter/nft_set_pipapo.h                     |   37 +-
 net/netfilter/nft_set_pipapo_avx2.c                |   59 +-
 net/netfilter/utils.c                              |   37 -
 net/netfilter/x_tables.c                           |    3 +-
 net/netlabel/netlabel_kapi.c                       |   10 +-
 net/netlink/af_netlink.c                           |   76 +-
 net/netlink/af_netlink.h                           |    5 +-
 net/netlink/diag.c                                 |    3 +-
 net/netlink/genetlink.c                            |   42 +-
 net/nfc/core.c                                     |    2 +-
 net/nfc/hci/llc.c                                  |   20 +-
 net/packet/af_packet.c                             |   11 +-
 net/packet/diag.c                                  |    3 +-
 net/rds/connection.c                               |    4 +-
 net/rxrpc/af_rxrpc.c                               |   12 +-
 net/rxrpc/ar-internal.h                            |   88 +-
 net/rxrpc/call_event.c                             |  359 +--
 net/rxrpc/call_object.c                            |   54 +-
 net/rxrpc/conn_client.c                            |    4 +-
 net/rxrpc/conn_event.c                             |   16 +-
 net/rxrpc/conn_object.c                            |    4 +
 net/rxrpc/input.c                                  |  114 +-
 net/rxrpc/insecure.c                               |   11 +-
 net/rxrpc/io_thread.c                              |   11 +
 net/rxrpc/local_object.c                           |    3 +
 net/rxrpc/misc.c                                   |    8 +-
 net/rxrpc/output.c                                 |  441 ++-
 net/rxrpc/proc.c                                   |   10 +-
 net/rxrpc/protocol.h                               |    6 +-
 net/rxrpc/rtt.c                                    |   36 +-
 net/rxrpc/rxkad.c                                  |   57 +-
 net/rxrpc/sendmsg.c                                |   63 +-
 net/rxrpc/sysctl.c                                 |   16 +-
 net/rxrpc/txbuf.c                                  |  172 +-
 net/sched/Kconfig                                  |   10 -
 net/sched/act_api.c                                |    2 +-
 net/sched/act_bpf.c                                |    1 +
 net/sched/act_connmark.c                           |    1 +
 net/sched/act_csum.c                               |    1 +
 net/sched/act_ct.c                                 |    1 +
 net/sched/act_ctinfo.c                             |    1 +
 net/sched/act_gact.c                               |    1 +
 net/sched/act_gate.c                               |    1 +
 net/sched/act_ife.c                                |    1 +
 net/sched/act_mirred.c                             |    1 +
 net/sched/act_mpls.c                               |    1 +
 net/sched/act_nat.c                                |    1 +
 net/sched/act_pedit.c                              |    3 +-
 net/sched/act_police.c                             |    1 +
 net/sched/act_sample.c                             |    1 +
 net/sched/act_simple.c                             |    1 +
 net/sched/act_skbedit.c                            |    1 +
 net/sched/act_skbmod.c                             |    1 +
 net/sched/act_tunnel_key.c                         |    1 +
 net/sched/act_vlan.c                               |    1 +
 net/sched/cls_api.c                                |    2 +-
 net/sched/cls_basic.c                              |    1 +
 net/sched/cls_bpf.c                                |    1 +
 net/sched/cls_cgroup.c                             |    1 +
 net/sched/cls_flow.c                               |    1 +
 net/sched/cls_flower.c                             |    1 +
 net/sched/cls_fw.c                                 |    1 +
 net/sched/cls_matchall.c                           |    1 +
 net/sched/cls_route.c                              |    1 +
 net/sched/cls_u32.c                                |    1 +
 net/sched/sch_api.c                                |    4 +-
 net/sched/sch_cake.c                               |    1 +
 net/sched/sch_cbs.c                                |    1 +
 net/sched/sch_choke.c                              |    1 +
 net/sched/sch_codel.c                              |   33 +-
 net/sched/sch_drr.c                                |    1 +
 net/sched/sch_etf.c                                |    1 +
 net/sched/sch_ets.c                                |    1 +
 net/sched/sch_fq.c                                 |    1 +
 net/sched/sch_fq_codel.c                           |    1 +
 net/sched/sch_generic.c                            |    3 +-
 net/sched/sch_gred.c                               |    1 +
 net/sched/sch_hfsc.c                               |    1 +
 net/sched/sch_hhf.c                                |    1 +
 net/sched/sch_htb.c                                |    1 +
 net/sched/sch_ingress.c                            |    3 +-
 net/sched/sch_mqprio.c                             |    1 +
 net/sched/sch_multiq.c                             |    1 +
 net/sched/sch_netem.c                              |    1 +
 net/sched/sch_pie.c                                |    1 +
 net/sched/sch_plug.c                               |    1 +
 net/sched/sch_prio.c                               |    1 +
 net/sched/sch_qfq.c                                |    1 +
 net/sched/sch_red.c                                |    1 +
 net/sched/sch_sfb.c                                |    1 +
 net/sched/sch_sfq.c                                |    1 +
 net/sched/sch_skbprio.c                            |    1 +
 net/sched/sch_taprio.c                             |   73 +-
 net/sched/sch_tbf.c                                |    1 +
 net/sctp/diag.c                                    |    1 +
 net/sctp/protocol.c                                |   10 +-
 net/sctp/socket.c                                  |    1 +
 net/smc/af_smc.c                                   |   22 +-
 net/smc/smc.h                                      |    4 +-
 net/smc/smc_clc.c                                  |    6 +-
 net/smc/smc_clc.h                                  |    2 +-
 net/smc/smc_core.c                                 |    4 +-
 net/smc/smc_diag.c                                 |    1 +
 net/smc/smc_ism.h                                  |   10 +-
 net/smc/smc_pnet.c                                 |   10 +
 net/socket.c                                       |    2 +-
 net/tipc/Kconfig                                   |    7 +-
 net/tipc/Makefile                                  |    4 +-
 net/tipc/bearer.c                                  |   15 +-
 net/tipc/diag.c                                    |    1 +
 net/tipc/node.c                                    |    2 -
 net/tipc/socket.c                                  |    1 -
 net/unix/Kconfig                                   |    5 -
 net/unix/Makefile                                  |    2 -
 net/unix/af_unix.c                                 |   73 +-
 net/unix/diag.c                                    |    1 +
 net/unix/garbage.c                                 |  200 +-
 net/unix/scm.c                                     |  159 -
 net/unix/scm.h                                     |   10 -
 net/vmw_vsock/diag.c                               |    1 +
 net/wireless/chan.c                                |  397 +--
 net/wireless/core.h                                |   52 +-
 net/wireless/mlme.c                                |  146 +-
 net/wireless/nl80211.c                             |  389 ++-
 net/wireless/reg.c                                 |   17 +-
 net/wireless/scan.c                                |  796 ++---
 net/wireless/sme.c                                 |    3 +-
 net/wireless/tests/Makefile                        |    2 +-
 net/wireless/tests/chan.c                          |  228 ++
 net/wireless/tests/fragmentation.c                 |   30 +-
 net/wireless/tests/scan.c                          |  277 +-
 net/wireless/trace.h                               |   62 +-
 net/wireless/util.c                                |   90 +-
 net/x25/Kconfig                                    |    2 -
 net/x25/af_x25.c                                   |    4 +-
 net/xdp/xsk.c                                      |    5 +-
 net/xdp/xsk_diag.c                                 |    1 +
 net/xfrm/espintcp.c                                |    4 +-
 net/xfrm/xfrm_input.c                              |    3 +-
 net/xfrm/xfrm_interface_bpf.c                      |    4 +-
 net/xfrm/xfrm_interface_core.c                     |   26 +-
 net/xfrm/xfrm_policy.c                             |  147 +-
 net/xfrm/xfrm_proc.c                               |    1 +
 net/xfrm/xfrm_state.c                              |   17 +-
 net/xfrm/xfrm_state_bpf.c                          |    4 +-
 net/xfrm/xfrm_user.c                               |    2 +-
 rust/kernel/net/phy.rs                             |   24 +-
 samples/bpf/map_perf_test_user.c                   |    2 +-
 samples/bpf/xdp_router_ipv4_user.c                 |    2 +-
 scripts/bpf_doc.py                                 |    2 +-
 security/security.c                                |  101 +-
 security/selinux/hooks.c                           |   47 +-
 tools/bpf/bpftool/Documentation/bpftool-gen.rst    |   58 +-
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |    2 +-
 tools/bpf/bpftool/gen.c                            |  277 +-
 tools/bpf/bpftool/link.c                           |   96 +-
 tools/bpf/bpftool/map.c                            |    2 +-
 tools/bpf/bpftool/prog.c                           |    2 +-
 tools/bpf/resolve_btfids/main.c                    |   70 +-
 tools/include/linux/btf_ids.h                      |    9 +
 tools/include/uapi/linux/bpf.h                     |  123 +-
 tools/include/uapi/linux/if_link.h                 |    1 +
 tools/include/uapi/linux/netdev.h                  |   20 +
 tools/lib/bpf/Build                                |    2 +-
 tools/lib/bpf/bpf.c                                |   42 +-
 tools/lib/bpf/bpf.h                                |   79 +-
 tools/lib/bpf/bpf_core_read.h                      |   60 +-
 tools/lib/bpf/bpf_helpers.h                        |    4 +
 tools/lib/bpf/btf.c                                |   43 +-
 tools/lib/bpf/elf.c                                |    2 -
 tools/lib/bpf/features.c                           |  583 ++++
 tools/lib/bpf/libbpf.c                             | 1160 ++++---
 tools/lib/bpf/libbpf.h                             |   23 +-
 tools/lib/bpf/libbpf.map                           |    6 +-
 tools/lib/bpf/libbpf_internal.h                    |   68 +-
 tools/lib/bpf/libbpf_probes.c                      |   19 +-
 tools/lib/bpf/linker.c                             |    2 +-
 tools/lib/bpf/netlink.c                            |    4 +-
 tools/lib/bpf/str_error.h                          |    3 +
 tools/net/ynl/Makefile                             |    4 +-
 tools/net/ynl/Makefile.deps                        |    5 +
 tools/net/ynl/cli.py                               |   43 +-
 tools/net/ynl/generated/Makefile                   |    9 +-
 tools/net/ynl/lib/Makefile                         |    5 +-
 tools/net/ynl/lib/__init__.py                      |    4 +-
 tools/net/ynl/lib/nlspec.py                        |   11 +-
 tools/net/ynl/lib/ynl-priv.h                       |  359 ++-
 tools/net/ynl/lib/ynl.c                            |  401 +--
 tools/net/ynl/lib/ynl.h                            |    5 +-
 tools/net/ynl/lib/ynl.py                           |  311 +-
 tools/net/ynl/samples/.gitignore                   |    1 +
 tools/net/ynl/samples/Makefile                     |    6 +-
 tools/net/ynl/samples/ovs.c                        |   60 +
 tools/net/ynl/samples/page-pool.c                  |    2 +
 tools/net/ynl/ynl-gen-c.py                         |  124 +-
 tools/net/ynl/ynl-gen-rst.py                       |    9 +-
 tools/testing/kunit/configs/all_tests.config       |    6 +
 tools/testing/selftests/Makefile                   |    7 +-
 tools/testing/selftests/alsa/test-pcmtest-driver.c |    4 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |    3 +-
 tools/testing/selftests/bpf/DENYLIST.s390x         |    3 +
 tools/testing/selftests/bpf/Makefile               |   51 +-
 tools/testing/selftests/bpf/README.rst             |   32 +-
 tools/testing/selftests/bpf/bench.c                |   40 +-
 tools/testing/selftests/bpf/benchs/bench_trigger.c |  182 +-
 .../selftests/bpf/benchs/run_bench_uprobes.sh      |    9 +
 tools/testing/selftests/bpf/bpf_arena_alloc.h      |   67 +
 tools/testing/selftests/bpf/bpf_arena_common.h     |   70 +
 tools/testing/selftests/bpf/bpf_arena_htab.h       |  100 +
 tools/testing/selftests/bpf/bpf_arena_list.h       |   92 +
 tools/testing/selftests/bpf/bpf_experimental.h     |   76 +-
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   30 +-
 .../testing/selftests/bpf/bpf_test_no_cfi/Makefile |   19 +
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c          |   84 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  129 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h        |   65 +
 tools/testing/selftests/bpf/config                 |    1 +
 .../testing/selftests/bpf/prog_tests/arena_htab.c  |   88 +
 .../testing/selftests/bpf/prog_tests/arena_list.c  |   68 +
 .../selftests/bpf/prog_tests/bad_struct_ops.c      |   67 +
 .../selftests/bpf/prog_tests/bpf_verif_scale.c     |    2 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |   29 +
 tools/testing/selftests/bpf/prog_tests/cpumask.c   |    6 +-
 .../testing/selftests/bpf/prog_tests/ctx_rewrite.c |   44 -
 .../selftests/bpf/prog_tests/decap_sanity.c        |    2 +-
 .../testing/selftests/bpf/prog_tests/fib_lookup.c  |    2 +-
 .../selftests/bpf/prog_tests/fill_link_info.c      |  114 +-
 .../selftests/bpf/prog_tests/ip_check_defrag.c     |    4 +-
 .../selftests/bpf/prog_tests/kptr_xchg_inline.c    |   52 +
 .../selftests/bpf/prog_tests/libbpf_probes.c       |    4 +
 .../testing/selftests/bpf/prog_tests/libbpf_str.c  |    6 +
 tools/testing/selftests/bpf/prog_tests/log_fixup.c |    4 +-
 .../testing/selftests/bpf/prog_tests/lwt_helpers.h |    2 -
 .../selftests/bpf/prog_tests/lwt_redirect.c        |    4 +-
 .../testing/selftests/bpf/prog_tests/lwt_reroute.c |    3 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c     |    2 +-
 .../selftests/bpf/prog_tests/rcu_read_lock.c       |    6 +
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |    2 +-
 .../selftests/bpf/prog_tests/sock_destroy.c        |    2 +-
 .../selftests/bpf/prog_tests/sock_iter_batch.c     |    4 +-
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |    2 +
 .../bpf/prog_tests/struct_ops_autocreate.c         |  159 +
 .../selftests/bpf/prog_tests/task_local_storage.c  |    6 -
 .../testing/selftests/bpf/prog_tests/tc_redirect.c |   90 +-
 .../bpf/prog_tests/tcp_custom_syncookie.c          |  150 +
 .../bpf/prog_tests/test_struct_ops_maybe_null.c    |   46 +
 .../bpf/prog_tests/test_struct_ops_module.c        |  101 +
 .../bpf/prog_tests/test_struct_ops_multi_pages.c   |   30 +
 .../bpf/prog_tests/test_struct_ops_no_cfi.c        |   35 +
 .../testing/selftests/bpf/prog_tests/test_tunnel.c |   18 +-
 tools/testing/selftests/bpf/prog_tests/token.c     | 1052 +++++++
 .../selftests/bpf/prog_tests/tracing_failure.c     |   37 +
 tools/testing/selftests/bpf/prog_tests/verifier.c  |    4 +
 tools/testing/selftests/bpf/prog_tests/xdpwall.c   |    2 +-
 tools/testing/selftests/bpf/progs/arena_htab.c     |   48 +
 tools/testing/selftests/bpf/progs/arena_htab_asm.c |    5 +
 tools/testing/selftests/bpf/progs/arena_list.c     |   87 +
 .../selftests/bpf/progs/async_stack_depth.c        |    4 +-
 tools/testing/selftests/bpf/progs/bad_struct_ops.c |   25 +
 .../testing/selftests/bpf/progs/bad_struct_ops2.c  |   14 +
 tools/testing/selftests/bpf/progs/bpf_compiler.h   |   33 +
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    2 +-
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |   16 +
 .../selftests/bpf/progs/cgrp_ls_recursion.c        |   26 -
 .../selftests/bpf/progs/connect_unix_prog.c        |    3 +-
 tools/testing/selftests/bpf/progs/cpumask_common.h |   55 +-
 .../selftests/bpf/progs/getpeername_unix_prog.c    |    3 +-
 .../selftests/bpf/progs/getsockname_unix_prog.c    |    3 +-
 tools/testing/selftests/bpf/progs/iters.c          |    9 +-
 .../testing/selftests/bpf/progs/kptr_xchg_inline.c |   48 +
 tools/testing/selftests/bpf/progs/loop4.c          |    4 +-
 tools/testing/selftests/bpf/progs/map_ptr_kern.c   |    2 +-
 tools/testing/selftests/bpf/progs/priv_map.c       |   13 +
 tools/testing/selftests/bpf/progs/priv_prog.c      |   13 +
 tools/testing/selftests/bpf/progs/profiler.inc.h   |   17 +-
 tools/testing/selftests/bpf/progs/pyperf.h         |    7 +-
 tools/testing/selftests/bpf/progs/rcu_read_lock.c  |  120 +
 .../selftests/bpf/progs/recvmsg_unix_prog.c        |    3 +-
 .../selftests/bpf/progs/sendmsg_unix_prog.c        |    3 +-
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c |    4 +-
 .../testing/selftests/bpf/progs/sock_iter_batch.c  |    4 +-
 tools/testing/selftests/bpf/progs/strobemeta.h     |   18 +-
 .../selftests/bpf/progs/struct_ops_autocreate.c    |   52 +
 .../selftests/bpf/progs/struct_ops_autocreate2.c   |   32 +
 .../selftests/bpf/progs/struct_ops_maybe_null.c    |   29 +
 .../bpf/progs/struct_ops_maybe_null_fail.c         |   24 +
 .../selftests/bpf/progs/struct_ops_module.c        |   56 +
 .../selftests/bpf/progs/struct_ops_multi_pages.c   |  102 +
 .../selftests/bpf/progs/task_ls_recursion.c        |   17 -
 .../selftests/bpf/progs/test_cls_redirect.c        |    7 +-
 .../selftests/bpf/progs/test_cls_redirect_dynptr.c |    2 +
 .../selftests/bpf/progs/test_core_reloc_type_id.c  |    2 +-
 .../selftests/bpf/progs/test_fill_link_info.c      |    6 +
 .../selftests/bpf/progs/test_global_func1.c        |    8 +-
 .../bpf/progs/test_global_func_ctx_args.c          |   19 +
 .../selftests/bpf/progs/test_lwt_seg6local.c       |    6 +-
 .../testing/selftests/bpf/progs/test_map_in_map.c  |   26 +
 .../selftests/bpf/progs/test_ptr_untrusted.c       |    6 +-
 tools/testing/selftests/bpf/progs/test_seg6_loop.c |    4 +-
 tools/testing/selftests/bpf/progs/test_siphash.h   |   64 +
 tools/testing/selftests/bpf/progs/test_skb_ctx.c   |    4 +-
 tools/testing/selftests/bpf/progs/test_spin_lock.c |   65 +
 .../selftests/bpf/progs/test_spin_lock_fail.c      |   44 +
 .../selftests/bpf/progs/test_sysctl_loop1.c        |    6 +-
 .../selftests/bpf/progs/test_sysctl_loop2.c        |    6 +-
 .../testing/selftests/bpf/progs/test_sysctl_prog.c |    6 +-
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |    5 +-
 .../bpf/progs/test_tcp_custom_syncookie.c          |  595 ++++
 .../bpf/progs/test_tcp_custom_syncookie.h          |  140 +
 .../testing/selftests/bpf/progs/test_tcpbpf_kern.c |    2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c       |    3 +-
 .../testing/selftests/bpf/progs/test_xdp_dynptr.c  |   10 +-
 tools/testing/selftests/bpf/progs/test_xdp_loop.c  |    3 +-
 .../selftests/bpf/progs/test_xdp_noinline.c        |    5 +-
 tools/testing/selftests/bpf/progs/token_lsm.c      |   32 +
 .../testing/selftests/bpf/progs/tracing_failure.c  |   20 +
 tools/testing/selftests/bpf/progs/trigger_bench.c  |   28 +
 tools/testing/selftests/bpf/progs/type_cast.c      |   13 +-
 tools/testing/selftests/bpf/progs/verifier_arena.c |  146 +
 .../bpf/progs/verifier_direct_packet_access.c      |    2 +-
 .../selftests/bpf/progs/verifier_global_ptr_args.c |  182 ++
 .../selftests/bpf/progs/verifier_global_subprogs.c |   29 +
 .../bpf/progs/verifier_iterating_callbacks.c       |  103 +-
 .../testing/selftests/bpf/progs/verifier_loops1.c  |   24 +
 .../selftests/bpf/progs/verifier_spill_fill.c      |  553 +++-
 .../selftests/bpf/progs/verifier_spin_lock.c       |    2 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |    6 +-
 tools/testing/selftests/bpf/progs/xdping_kern.c    |    3 +-
 tools/testing/selftests/bpf/test_loader.c          |   13 +-
 tools/testing/selftests/bpf/test_lpm_map.c         |   18 +-
 tools/testing/selftests/bpf/test_maps.c            |    6 +-
 tools/testing/selftests/bpf/test_progs.c           |   77 +-
 tools/testing/selftests/bpf/test_progs.h           |   10 +-
 tools/testing/selftests/bpf/test_sock_addr.c       |    3 +-
 tools/testing/selftests/bpf/test_verifier.c        |   60 +-
 tools/testing/selftests/bpf/testing_helpers.c      |   96 +-
 tools/testing/selftests/bpf/testing_helpers.h      |   10 +
 tools/testing/selftests/bpf/trace_helpers.c        |    2 +-
 .../selftests/bpf/verifier/bpf_loop_inline.c       |    6 +
 tools/testing/selftests/bpf/verifier/precise.c     |    6 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |    2 +-
 .../testing/selftests/drivers/net/bonding/Makefile |    7 +-
 .../drivers/net/bonding/bond-break-lacpdu-tx.sh    |   19 +-
 .../drivers/net/bonding/bond-eth-type-change.sh    |    2 +-
 .../drivers/net/bonding/bond-lladdr-target.sh      |   21 +-
 .../selftests/drivers/net/bonding/bond_options.sh  |   38 +-
 .../drivers/net/bonding/bond_topo_2d1c.sh          |    8 +-
 .../drivers/net/bonding/dev_addr_lists.sh          |    2 +-
 .../selftests/drivers/net/bonding/lag_lib.sh       |    7 +-
 .../drivers/net/bonding/mode-1-recovery-updelay.sh |    2 +-
 .../drivers/net/bonding/mode-2-recovery-updelay.sh |    2 +-
 .../drivers/net/bonding/net_forwarding_lib.sh      |    1 -
 tools/testing/selftests/drivers/net/dsa/Makefile   |   18 +-
 .../drivers/net/dsa/bridge_locked_port.sh          |    2 +-
 .../selftests/drivers/net/dsa/bridge_mdb.sh        |    2 +-
 .../selftests/drivers/net/dsa/bridge_mld.sh        |    2 +-
 .../selftests/drivers/net/dsa/bridge_vlan_aware.sh |    2 +-
 .../selftests/drivers/net/dsa/bridge_vlan_mcast.sh |    2 +-
 .../drivers/net/dsa/bridge_vlan_unaware.sh         |    2 +-
 tools/testing/selftests/drivers/net/dsa/lib.sh     |    1 -
 .../selftests/drivers/net/dsa/local_termination.sh |    2 +-
 .../selftests/drivers/net/dsa/no_forwarding.sh     |    2 +-
 .../drivers/net/dsa/run_net_forwarding_test.sh     |    9 +
 .../selftests/drivers/net/dsa/tc_actions.sh        |    2 +-
 .../testing/selftests/drivers/net/dsa/tc_common.sh |    1 -
 .../drivers/net/dsa/test_bridge_fdb_stress.sh      |    2 +-
 .../drivers/net/mlxsw/spectrum-2/tc_flower.sh      |    2 +-
 .../selftests/drivers/net/netdevsim/Makefile       |   18 +
 .../selftests/drivers/net/netdevsim/devlink.sh     |    2 +-
 .../selftests/drivers/net/netdevsim/ethtool-fec.sh |    2 +-
 .../selftests/drivers/net/netdevsim/peer.sh        |  143 +
 .../drivers/net/netdevsim/udp_tunnel_nic.sh        |   40 +-
 tools/testing/selftests/drivers/net/team/Makefile  |    7 +-
 .../selftests/drivers/net/team/dev_addr_lists.sh   |    4 +-
 .../testing/selftests/drivers/net/team/lag_lib.sh  |    1 -
 .../drivers/net/team/net_forwarding_lib.sh         |    1 -
 tools/testing/selftests/kselftest.h                |   45 +
 tools/testing/selftests/kselftest_harness.h        |  198 +-
 tools/testing/selftests/landlock/base_test.c       |    2 +-
 tools/testing/selftests/landlock/common.h          |   58 +-
 tools/testing/selftests/landlock/fs_test.c         |   26 +-
 tools/testing/selftests/landlock/net_test.c        |    4 +-
 tools/testing/selftests/landlock/ptrace_test.c     |    7 +-
 tools/testing/selftests/lib.mk                     |   19 +
 tools/testing/selftests/mm/hmm-tests.c             |    4 +-
 tools/testing/selftests/net/Makefile               |    2 +
 tools/testing/selftests/net/fcnal-test.sh          |   34 +-
 tools/testing/selftests/net/fib_nexthops.sh        |    6 +
 tools/testing/selftests/net/fib_tests.sh           |  148 +-
 tools/testing/selftests/net/forwarding/Makefile    |    4 +
 tools/testing/selftests/net/forwarding/config      |   35 +
 .../net/forwarding/custom_multipath_hash.sh        |   16 +-
 .../net/forwarding/forwarding.config.sample        |    2 +
 .../net/forwarding/gre_custom_multipath_hash.sh    |   16 +-
 .../net/forwarding/gre_inner_v4_multipath.sh       |    2 +-
 .../net/forwarding/gre_inner_v6_multipath.sh       |    6 +-
 .../selftests/net/forwarding/gre_multipath.sh      |    2 +-
 .../selftests/net/forwarding/gre_multipath_nh.sh   |   41 +-
 .../net/forwarding/gre_multipath_nh_res.sh         |   42 +-
 .../net/forwarding/ip6gre_custom_multipath_hash.sh |   16 +-
 .../net/forwarding/ip6gre_inner_v4_multipath.sh    |    2 +-
 .../net/forwarding/ip6gre_inner_v6_multipath.sh    |    6 +-
 .../testing/selftests/net/forwarding/ip6gre_lib.sh |    4 +-
 tools/testing/selftests/net/forwarding/lib.sh      |   67 +-
 .../selftests/net/forwarding/mirror_gre_lib.sh     |    2 +-
 .../net/forwarding/mirror_gre_topo_lib.sh          |    2 +-
 .../selftests/net/forwarding/router_mpath_nh.sh    |   52 +-
 .../net/forwarding/router_mpath_nh_lib.sh          |  129 +
 .../net/forwarding/router_mpath_nh_res.sh          |   17 +-
 .../selftests/net/forwarding/router_multipath.sh   |   43 +-
 .../testing/selftests/net/forwarding/tc_police.sh  |   16 +-
 .../selftests/net/forwarding/vxlan_bridge_1d.sh    |    4 +-
 .../net/forwarding/vxlan_bridge_1d_ipv6.sh         |    4 +-
 .../selftests/net/forwarding/vxlan_bridge_1q.sh    |   10 +-
 tools/testing/selftests/net/fq_band_pktlimit.sh    |   14 +-
 tools/testing/selftests/net/ip_local_port_range.c  |    6 +-
 tools/testing/selftests/net/mptcp/diag.sh          |   56 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  248 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  293 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  213 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  104 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |   63 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      |   39 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   60 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  173 +-
 .../selftests/net/openvswitch/openvswitch.sh       |   62 +
 tools/testing/selftests/net/rtnetlink.sh           |    2 +
 tools/testing/selftests/net/so_txtime.c            |    7 +-
 tools/testing/selftests/net/test_vxlan_mdb.sh      |   36 +-
 tools/testing/selftests/net/tls.c                  |    2 +-
 tools/testing/selftests/net/txtimestamp.c          |    3 +-
 tools/testing/selftests/net/txtimestamp.sh         |   12 +-
 tools/testing/selftests/net/udpgso.c               |  134 +-
 tools/testing/selftests/net/udpgso.sh              |   49 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |    9 +-
 tools/testing/selftests/tc-testing/config          |    1 +
 .../tc-testing/tc-tests/actions/mirred.json        |  403 +++
 .../selftests/tc-testing/tc-tests/qdiscs/fq.json   |    2 +-
 .../tc-testing/tc-tests/qdiscs/taprio.json         |    2 +
 tools/testing/selftests/tc-testing/tdc.py          |    2 +-
 tools/testing/selftests/tc-testing/tdc.sh          |    3 +-
 tools/testing/vsock/util.c                         |   17 +-
 tools/testing/vsock/util.h                         |    4 +
 tools/testing/vsock/vsock_diag_test.c              |   23 +-
 tools/testing/vsock/vsock_test.c                   |  102 +-
 tools/testing/vsock/vsock_test_zerocopy.c          |   12 +-
 tools/testing/vsock/vsock_uring_test.c             |   17 +-
 tools/virtio/.gitignore                            |    1 +
 tools/virtio/Makefile                              |    8 +-
 tools/virtio/linux/virtio_config.h                 |    4 +
 tools/virtio/vhost_net_test.c                      |  532 ++++
 1882 files changed, 91719 insertions(+), 36268 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/ar9331.txt
 create mode 100644 Documentation/devicetree/bindings/net/dsa/qca,ar9331.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
 create mode 100644 Documentation/netlink/specs/nlctrl.yaml
 create mode 100644 Documentation/networking/device_drivers/ethernet/marvell/octeon_ep_vf.rst
 create mode 100644 Documentation/networking/multi-pf-netdev.rst
 create mode 100644 drivers/net/can/esd/Kconfig
 create mode 100644 drivers/net/can/esd/Makefile
 create mode 100644 drivers/net/can/esd/esd_402_pci-core.c
 create mode 100644 drivers/net/can/esd/esdacc.c
 create mode 100644 drivers/net/can/esd/esdacc.h
 create mode 100644 drivers/net/dsa/realtek/realtek-mdio.h
 create mode 100644 drivers/net/dsa/realtek/realtek-smi.h
 create mode 100644 drivers/net/dsa/realtek/rtl83xx.c
 create mode 100644 drivers/net/dsa/realtek/rtl83xx.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
 create mode 100644 drivers/net/ethernet/intel/igc/igc_leds.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/Makefile
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_config.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_ethtool.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_mbox.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_regs_cn9k.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_regs_cnxk.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.h
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.c
 create mode 100644 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_tx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.h
 delete mode 100644 drivers/net/phy/at803x.c
 create mode 100644 drivers/net/phy/qcom/Kconfig
 create mode 100644 drivers/net/phy/qcom/Makefile
 create mode 100644 drivers/net/phy/qcom/at803x.c
 create mode 100644 drivers/net/phy/qcom/qca807x.c
 create mode 100644 drivers/net/phy/qcom/qca808x.c
 create mode 100644 drivers/net/phy/qcom/qca83xx.c
 create mode 100644 drivers/net/phy/qcom/qcom-phy-lib.c
 create mode 100644 drivers/net/phy/qcom/qcom.h
 create mode 100644 drivers/net/wan/fsl_qmc_hdlc.c
 create mode 100644 drivers/net/wireless/ath/ath12k/fw.c
 create mode 100644 drivers/net/wireless/ath/ath12k/fw.h
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.c
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/module.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/wed.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
 create mode 100644 drivers/ptp/ptp_fc3.c
 create mode 100644 drivers/ptp/ptp_fc3.h
 create mode 100644 include/linux/mfd/idtRC38xxx_reg.h
 create mode 100644 include/net/eee.h
 create mode 100644 include/net/hotdata.h
 create mode 100644 include/net/netmem.h
 create mode 100644 include/net/rps.h
 create mode 100644 kernel/bpf/arena.c
 delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
 create mode 100644 kernel/bpf/token.c
 delete mode 100644 net/bluetooth/a2mp.c
 delete mode 100644 net/bluetooth/a2mp.h
 delete mode 100644 net/bluetooth/amp.c
 delete mode 100644 net/bluetooth/amp.h
 create mode 100644 net/core/hotdata.c
 create mode 100644 net/mac80211/parse.c
 delete mode 100644 net/unix/scm.c
 delete mode 100644 net/unix/scm.h
 create mode 100644 net/wireless/tests/chan.c
 create mode 100644 tools/lib/bpf/features.c
 create mode 100644 tools/net/ynl/samples/ovs.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_alloc.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_common.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_htab.h
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_list.h
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_list.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/token.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_htab_asm.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops2.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_compiler.h
 create mode 100644 tools/testing/selftests/bpf/progs/kptr_xchg_inline.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/priv_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_maybe_null_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_siphash.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.h
 create mode 100644 tools/testing/selftests/bpf/progs/token_lsm.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
 delete mode 120000 tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/lib.sh
 create mode 100755 tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
 delete mode 120000 tools/testing/selftests/drivers/net/dsa/tc_common.sh
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh
 delete mode 120000 tools/testing/selftests/drivers/net/team/lag_lib.sh
 delete mode 120000 tools/testing/selftests/drivers/net/team/net_forwarding_lib.sh
 create mode 100644 tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
 create mode 100644 tools/virtio/vhost_net_test.c

