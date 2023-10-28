Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089DC7DA49A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 03:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjJ1BRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 21:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjJ1BRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 21:17:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03A8128
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 18:17:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E6DC433C8;
        Sat, 28 Oct 2023 01:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698455862;
        bh=El9bazq3CNAJCthJI9bQOozLo415AcPjU1rpBAlH2vI=;
        h=From:To:Cc:Subject:Date:From;
        b=nT05/YQFjdmvZDl5p2SKqMhXxoVQudC/PXTQR+McQxTW6MV7Q62YvZreN3iGi2WiA
         O3So1IHVMUDuJ8WQHw13Mr1gwuJFFg/o9Ht9IYm+VV9yliTCWVoBVV0E8b+sOdDZI5
         iGcyZ0Kxho9bZL7O0KYVu9PaXcNTyZSGVIm1dmiLdvKs0X0MQixTnDlWaqQB0cFryY
         kbZA7NZx5d3BH1RpXbXFdhwSLY2UD+wHPLiwIzNeUnVY1Ou2FfffSBGGsltMpiivUQ
         v9H7kHCGqmckyq6+EgpgYo8H1KXdZ5lka2Dv8xyQsXno4Guf+RDM5siqQ9zL8Gb/xE
         QuBN2EuQYQRpg==
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: [GIT PULL] Networking for 6.7
Date:   Fri, 27 Oct 2023 18:17:41 -0700
Message-ID: <20231028011741.2400327-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

I'll be traveling next week, so anticipating no -rc8 here is our
merge window material.

The following changes since commit c17cda15cc86e65e9725641daddcd7a63cc9ad01:

  Merge tag 'net-6.6-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-10-26 07:41:27 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.7

for you to fetch changes up to f1c73396133cb3d913e2075298005644ee8dfade:

  net: pcs: xpcs: Add 2500BASE-X case in get state for XPCS drivers (2023-10-27 15:59:44 -0700)

----------------------------------------------------------------
Networking changes for 6.7.

Core & protocols
----------------

 - Support usec resolution of TCP timestamps, enabled selectively by
   a route attribute.

 - Defer regular TCP ACK while processing socket backlog, try to send
   a cumulative ACK at the end. Increase single TCP flow performance
   on a 200Gbit NIC by 20% (100Gbit -> 120Gbit).

 - The Fair Queuing (FQ) packet scheduler:
   - add built-in 3 band prio / WRR scheduling
   - support bypass if the qdisc is mostly idle (5% speed up for TCP RR)
   - improve inactive flow reporting
   - optimize the layout of structures for better cache locality

 - Support TCP Authentication Option (RFC 5925, TCP-AO), a more modern
   replacement for the old MD5 option.

 - Add more retransmission timeout (RTO) related statistics to TCP_INFO.

 - Support sending fragmented skbs over vsock sockets.

 - Make sure we send SIGPIPE for vsock sockets if socket was shutdown().

 - Add sysctl for ignoring lower limit on lifetime in Router
   Advertisement PIO, based on an in-progress IETF draft.

 - Add sysctl to control activation of TCP ping-pong mode.

 - Add sysctl to make connection timeout in MPTCP configurable.

 - Support rcvlowat and notsent_lowat on MPTCP sockets, to help apps
   limit the number of wakeups.

 - Support netlink GET for MDB (multicast forwarding), allowing user
   space to request a single MDB entry instead of dumping the entire
   table.

 - Support selective FDB flushing in the VXLAN tunnel driver.

 - Allow limiting learned FDB entries in bridges, prevent OOM attacks.

 - Allow controlling via configfs netconsole targets which were created
   via the kernel cmdline at boot, rather than via configfs at runtime.

 - Support multiple PTP timestamp event queue readers with different
   filters.

 - MCTP over I3C.

BPF
---

 - Add new veth-like netdevice where BPF program defines the logic
   of the xmit routine. It can operate in L3 and L2 mode.

 - Support exceptions - allow asserting conditions which should
   never be true but are hard for the verifier to infer.
   With some extra flexibility around handling of the exit / failure.
   https://lwn.net/Articles/938435/

 - Add support for local per-cpu kptr, allow allocating and storing
   per-cpu objects in maps. Access to those objects operates on
   the value for the current CPU. This allows to deprecate local
   one-off implementations of per-CPU storage like
   BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE maps.

 - Extend cgroup BPF sockaddr hooks for UNIX sockets. The use case is
   for systemd to re-implement the LogNamespace feature which allows
   running multiple instances of systemd-journald to process the logs
   of different services.

 - Enable open-coded task_vma iteration, after maple tree conversion
   made it hard to directly walk VMAs in tracing programs.

 - Add open-coded task, css_task and css iterator support.
   One of the use cases is customizable OOM victim selection via BPF.

 - Allow source address selection with bpf_*_fib_lookup().

 - Add ability to pin BPF timer to the current CPU.

 - Prevent creation of infinite loops by combining tail calls and
   fentry/fexit programs.

 - Add missed stats for kprobes to retrieve the number of missed kprobe
   executions and subsequent executions of BPF programs.

 - Inherit system settings for CPU security mitigations.

 - Add BPF v4 CPU instruction support for arm32 and s390x.

Changes to common code
----------------------

 - overflow: add DEFINE_FLEX() for on-stack definition of structs
   with flexible array members.

 - Process doc update with more guidance for reviewers.

Driver API
----------

 - Simplify locking in WiFi (cfg80211 and mac80211 layers), use wiphy
   mutex in most places and remove a lot of smaller locks.

 - Create a common DPLL configuration API. Allow configuring
   and querying state of PLL circuits used for clock syntonization,
   in network time distribution.

 - Unify fragmented and full page allocation APIs in page pool code.
   Let drivers be ignorant of PAGE_SIZE.

 - Rework PHY state machine to avoid races with calls to phy_stop().

 - Notify DSA drivers of MAC address changes on user ports, improve
   correctness of offloads which depend on matching port MAC addresses.

 - Allow antenna control on injected WiFi frames.

 - Reduce the number of variants of napi_schedule().

 - Simplify error handling when composing devlink health messages.

Misc
----

 - A lot of KCSAN data race "fixes", from Eric.

 - A lot of __counted_by() annotations, from Kees.

 - A lot of strncpy -> strscpy and printf format fixes.

 - Replace master/slave terminology with conduit/user in DSA drivers.

 - Handful of KUnit tests for netdev and WiFi core.

Removed
-------

 - AppleTalk COPS.

 - AppleTalk ipddp.

 - TI AR7 CPMAC Ethernet driver.

Drivers
-------

 - Ethernet high-speed NICs:
   - Intel (100G, ice, idpf):
     - add a driver for the Intel E2000 IPUs
     - make CRC/FCS stripping configurable
     - cross-timestamping for E823 devices
     - basic support for E830 devices
     - use aux-bus for managing client drivers
     - i40e: report firmware versions via devlink
   - nVidia/Mellanox:
     - support 4-port NICs
     - increase max number of channels to 256
     - optimize / parallelize SF creation flow
   - Broadcom (bnxt):
     - enhance NIC temperature reporting
     - support PAM4 speeds and lane configuration
   - Marvell OcteonTX2:
     - PTP pulse-per-second output support
     - enable hardware timestamping for VFs
   - Solarflare/AMD:
     - conntrack NAT offload and offload for tunnels
   - Wangxun (ngbe/txgbe):
     - expose HW statistics
   - Pensando/AMD:
     - support PCI level reset
     - narrow down the condition under which skbs are linearized
   - Netronome/Corigine (nfp):
     - support CHACHA20-POLY1305 crypto in IPsec offload

 - Ethernet NICs embedded, slower, virtual:
   - Synopsys (stmmac):
     - add Loongson-1 SoC support
     - enable use of HW queues with no offload capabilities
     - enable PPS input support on all 5 channels
     - increase TX coalesce timer to 5ms
   - RealTek USB (r8152): improve efficiency of Rx by using GRO frags
   - xen: support SW packet timestamping
   - add drivers for implementations based on TI's PRUSS (AM64x EVM)

 - nVidia/Mellanox Ethernet datacenter switches:
   - avoid poor HW resource use on Spectrum-4 by better block selection
     for IPv6 multicast forwarding and ordering of blocks in ACL region

 - Ethernet embedded switches:
   - Microchip:
     - support configuring the drive strength for EMI compliance
     - ksz9477: partial ACL support
     - ksz9477: HSR offload
     - ksz9477: Wake on LAN
   - Realtek:
     - rtl8366rb: respect device tree config of the CPU port

 - Ethernet PHYs:
   - support Broadcom BCM5221 PHYs
   - TI dp83867: support hardware LED blinking

 - CAN:
   - add support for Linux-PHY based CAN transceivers
   - at91_can: clean up and use rx-offload helpers

 - WiFi:
   - MediaTek (mt76):
     - new sub-driver for mt7925 USB/PCIe devices
     - HW wireless <> Ethernet bridging in MT7988 chips
     - mt7603/mt7628 stability improvements
   - Qualcomm (ath12k):
     - WCN7850:
       - enable 320 MHz channels in 6 GHz band
       - hardware rfkill support
       - enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS
         to make scan faster
       - read board data variant name from SMBIOS
     - QCN9274: mesh support
   - RealTek (rtw89):
     - TDMA-based multi-channel concurrency (MCC)
   - Silicon Labs (wfx):
     - Remain-On-Channel (ROC) support

 - Bluetooth:
   - ISO: many improvements for broadcast support
   - mark BCM4378/BCM4387 as BROKEN_LE_CODED
   - add support for QCA2066
   - btmtksdio: enable Bluetooth wakeup from suspend

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aananth V (2):
      tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed
      tcp: new TCP_INFO stats for RTO events

Abel Wu (3):
      sock: Code cleanup on __sk_mem_raise_allocated()
      sock: Doc behaviors for pressure heurisitics
      sock: Ignore memcg pressure heuristics when raising allocated

Abhishek Kumar (1):
      wifi: cfg80211: call reg_call_notifier on beacon hints

Adam Ford (1):
      net: ethernet: davinci_emac: Use MAC Address from Device Tree

Adham Faris (5):
      net/mlx5e: Refactor rx_res_init() and rx_res_free() APIs
      net/mlx5e: Refactor mlx5e_rss_set_rxfh() and mlx5e_rss_get_rxfh()
      net/mlx5e: Refactor mlx5e_rss_init() and mlx5e_rss_free() API's
      net/mlx5e: Preparations for supporting larger number of channels
      net/mlx5e: Increase max supported channels number to 256

Aditya Kumar Singh (5):
      wifi: cfg80211: export DFS CAC time and usable state helper functions
      wifi: ath11k: fix CAC running state during virtual interface start
      wifi: ath11k: fix Tx power value during active CAC
      wifi: ath11k: add parsing of phy bitmap for reg rules
      wifi: ath12k: add parsing of phy bitmap for reg rules

Ajay Singh (1):
      wifi: wilc1000: use vmm_table as array in wilc struct

Akihiko Odaki (1):
      bpf: Fix the comment for bpf_restore_data_end()

Alan Brady (4):
      idpf: configure resources for TX queues
      idpf: configure resources for RX queues
      idpf: add RX splitq napi poll support
      idpf: add ethtool callbacks

Albert Huang (1):
      xsk: Avoid starving the xsk further down the list

Alex Austin (1):
      sfc: make coding style of PTP addresses consistent with core

Alex Henrie (4):
      net: ipv6/addrconf: clamp preferred_lft to the maximum allowed
      net: ipv6/addrconf: clamp preferred_lft to the minimum required
      Documentation: networking: explain what happens if temp_valid_lft is too small
      Documentation: networking: explain what happens if temp_prefered_lft is too small or too large

Alexander Stein (2):
      net: fec: Fix device_get_match_data usage
      net: fec: Remove non-Coldfire platform IDs

Alexandre Ghiti (1):
      libbpf: Fix syscall access arguments on riscv

Alexei Starovoitov (12):
      Merge branch 'bpf-add-support-for-local-percpu-kptr'
      Merge branch 'bpf-enable-irq-after-irq_work_raise-completes'
      Merge branch 'bpf-task_group_seq_get_next-misc-cleanups'
      Merge branch 'bpf-x64-fix-tailcall-infinite-loop'
      Merge branch 'seltests-xsk-various-improvements-to-xskxceiver'
      Merge branch 'arm32-bpf-add-support-for-cpuv4-insns'
      Merge branch 'exceptions-1-2'
      bpf: Remove unused variables.
      Merge branch 'implement-cpuv4-support-for-s390x'
      Merge branch 'add-open-coded-task-css_task-and-css-iters'
      Merge branch 'bpf-fixes-for-per-cpu-kptr'
      Merge branch 'exact-states-comparison-for-iterator-convergence-checks'

Alexey Makhalov (1):
      MAINTAINERS: Maintainer change for ptp_vmw driver

Alice Michael (1):
      ice: Add 200G speed/phy type use

Allen Ye (1):
      wifi: mt76: check sta rx control frame to multibss capability

Aloka Dixit (7):
      wifi: nl80211: fixes to FILS discovery updates
      wifi: mac80211: fixes in FILS discovery updates
      wifi: cfg80211: modify prototype for change_beacon
      wifi: nl80211: additions to NL80211_CMD_SET_BEACON
      wifi: mac80211: additions to change_beacon()
      wifi: ath12k: call ath12k_mac_fils_discovery() without condition
      wifi: ath11k: call ath11k_mac_fils_discovery() without condition

Alon Giladi (1):
      wifi: iwlwifi: send EDT table to FW

Amit Cohen (19):
      mlxsw: Add 'ipv4_5' flex key
      mlxsw: spectrum_acl_flex_keys: Add 'ipv4_5b' flex key
      mlxsw: Edit IPv6 key blocks to use one less block for multicast forwarding
      mlxsw: Mark high entropy key blocks
      mlxsw: core_acl_flex_keys: Add a bitmap to save which blocks are chosen
      mlxsw: core_acl_flex_keys: Save chosen elements per block
      mlxsw: core_acl_flex_keys: Save chosen elements in all blocks per search
      mlxsw: core_acl_flex_keys: Fill blocks with high entropy first
      net: Handle bulk delete policy in bridge driver
      vxlan: vxlan_core: Make vxlan_flush() more generic for future use
      vxlan: vxlan_core: Do not skip default entry in vxlan_flush() by default
      vxlan: vxlan_core: Add support for FDB flush
      vxlan: vxlan_core: Support FDB flushing by source VNI
      vxlan: vxlan_core: Support FDB flushing by nexthop ID
      vxlan: vxlan_core: Support FDB flushing by destination VNI
      vxlan: vxlan_core: Support FDB flushing by destination port
      vxlan: vxlan_core: Support FDB flushing by destination IP
      selftests: Add test cases for FDB flush with VXLAN device
      selftests: fdb_flush: Add test cases for FDB flush with bridge device

Andrii Nakryiko (18):
      libbpf: Add basic BTF sanity validation
      Merge branch 'selftests/bpf: Optimize kallsyms cache'
      Merge branch 'libbpf: Support symbol versioning for uprobe'
      Merge branch 'add libbpf getters for individual ringbuffers'
      Merge branch 'bpf: Add missed stats for kprobes'
      Merge branch 'libbpf/selftests syscall wrapper fixes for RISC-V'
      Merge branch 'selftest/bpf, riscv: Improved cross-building support'
      selftests/bpf: Fix compiler warnings reported in -O2 mode
      selftests/bpf: Support building selftests in optimized -O2 mode
      selftests/bpf: Don't truncate #test/subtest field
      Merge branch 'Open-coded task_vma iter'
      selftests/bpf: Improve percpu_alloc test robustness
      selftests/bpf: Improve missed_kprobe_recursion test robustness
      selftests/bpf: Make align selftests more robust
      bpf: Disambiguate SCALAR register state output in verifier logs
      bpf: Ensure proper register state printing for cond jumps
      libbpf: Don't assume SHT_GNU_verdef presence for SHT_GNU_versym section
      bpf: Improve JEQ/JNE branch taken logic

Andrii Staikov (1):
      i40e: fix potential memory leaks in i40e_remove()

Andy Gospodarek (1):
      MAINTAINERS: update tg3 maintainer list

Andy Shevchenko (1):
      wwan: core: Use the bitmap API to allocate bitmaps

Anilkumar Kolli (1):
      wifi: ath11k: add firmware-2.bin support

Anjaneyulu (3):
      wifi: iwlwifi: implement enable/disable for China 2022 regulatory
      wifi: iwlwifi: mvm: implement new firmware API for statistics
      wifi: iwlwifi: mvm: debugfs for fw system stats

Arkadiusz Kubalewski (7):
      ice: add admin commands to access cgu configuration
      ice: implement dpll interface to control cgu
      dpll: docs: add support for pin signal phase offset/adjust
      dpll: spec: add support for pin-dpll signal phase offset/adjust
      dpll: netlink/core: add support for pin-dpll signal phase offset/adjust
      ice: dpll: implement phase related callbacks
      dpll: netlink/core: change pin frequency set behavior

Arnd Bergmann (3):
      appletalk: remove ipddp driver
      wifi: atmel: remove unused ioctl function
      wifi: hostap: remove unused ioctl function

Arowa Suliman (1):
      wifi: ath11k: mhi: add a warning message for MHI_CB_EE_RDDM crash

Arseniy Krasnov (18):
      vsock: send SIGPIPE on write to shutdowned socket
      test/vsock: shutdowned socket test
      vsock/virtio/vhost: read data from non-linear skb
      vsock/virtio: support to send non-linear skb
      vsock/virtio: non-linear skb handling for tap
      vsock/virtio: MSG_ZEROCOPY flag support
      vsock: set EPOLLERR on non-empty error queue
      vsock: read from socket's error queue
      vsock: check for MSG_ZEROCOPY support on send
      vsock: enable SOCK_SUPPORT_ZC bit
      vhost/vsock: support MSG_ZEROCOPY for transport
      vsock/virtio: support MSG_ZEROCOPY for transport
      vsock/loopback: support MSG_ZEROCOPY for transport
      vsock: enable setting SO_ZEROCOPY
      docs: net: description of MSG_ZEROCOPY for AF_VSOCK
      test/vsock: MSG_ZEROCOPY flag tests
      test/vsock: MSG_ZEROCOPY support for vsock_perf
      test/vsock: io_uring rx/tx tests

Artem Savkov (2):
      selftests/bpf: Skip module_fentry_shadow test when bpf_testmod is not available
      bpf: Change syscall_nr type to int in struct syscall_tp_t

Avraham Stern (2):
      wifi: iwlwifi: mvm: update station's MFP flag after association
      wifi: iwlwifi: mvm: fix removing pasn station for responder

Ayala Beker (4):
      wifi: mac80211: don't connect to an AP while it's in a CSA process
      wifi: mac80211: add support for parsing TID to Link mapping element
      wifi: mac80211: support handling of advertised TID-to-link mapping
      wifi: iwlwifi: mvm: advertise support for SCS traffic description

Bagas Sanjaya (3):
      Documentation: dpll: Fix code blocks
      Documentation: dpll: wrap DPLL_CMD_PIN_GET output in a code block
      MAINTAINERS: Remove linuxwwan@intel.com mailing list

Baochen Qiang (4):
      wifi: ath12k: fix possible out-of-bound read in ath12k_htt_pull_ppdu_stats()
      wifi: ath12k: fix possible out-of-bound write in ath12k_wmi_ext_hal_reg_caps()
      wifi: ath12k: fix DMA unmap warning on NULL DMA address
      wifi: ath11k: fix boot failure with one MSI vector

Ben Wolsieffer (1):
      net: stmmac: dwmac-stm32: refactor clock config

Beniamino Galvani (14):
      ipv6: mark address parameters of udp_tunnel6_xmit_skb() as const
      ipv4: rename and move ip_route_output_tunnel()
      ipv4: remove "proto" argument from udp_tunnel_dst_lookup()
      ipv4: add new arguments to udp_tunnel_dst_lookup()
      ipv4: use tunnel flow flags for tunnel route lookups
      geneve: add dsfield helper function
      geneve: use generic function for tunnel IPv4 route lookup
      vxlan: use generic function for tunnel IPv4 route lookup
      ipv6: rename and move ip6_dst_lookup_tunnel()
      ipv6: remove "proto" argument from udp_tunnel6_dst_lookup()
      ipv6: add new arguments to udp_tunnel6_dst_lookup()
      geneve: use generic function for tunnel IPv6 route lookup
      vxlan: use generic function for tunnel IPv6 route lookup
      bareudp: use ports to lookup route

Benjamin Berg (8):
      wifi: cfg80211: add ieee80211_fragment_element to public API
      wifi: mac80211: add more warnings about inserting sta info
      wifi: cfg80211: report per-link errors during association
      wifi: mac80211: report per-link error during association
      wifi: mac80211: reject MLO channel configuration if not supported
      wifi: mac80211: cleanup auth_data only if association continues
      wifi: mac80211: mesh: fix some kdoc warnings
      wifi: iwlwifi: mvm: Return success if link could not be removed

Benjamin Lin (1):
      wifi: mt76: mt7996: remove periodic MPDU TXS request

Benjamin Poirier (1):
      vxlan: Cleanup IFLA_VXLAN_PORT_RANGE entry in vxlan_get_size()

Björn Töpel (5):
      selftests/bpf: Define SYS_PREFIX for riscv
      selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for riscv
      selftests/bpf: Add cross-build support for urandom_read et al
      selftests/bpf: Enable lld usage for RISC-V
      selftests/bpf: Add uprobe_multi to gen_tar target

Bo Jiao (1):
      wifi: mt76: fix potential memory leak of beacon commands

Bragatheswaran Manickavel (1):
      amd/pds_core: core: No need for Null pointer check before kfree

Breno Leitao (4):
      netconsole: move init/cleanup functions lower
      netconsole: Initialize configfs_item for default targets
      netconsole: Attach cmdline target to dynamic target
      Documentation: netconsole: add support for cmdline targets

Brett Creeley (1):
      iavf: Fix promiscuous mode configuration flow messages

Chank Chen (1):
      wifi: mt76: connac: add MBSSID support for mt7996

Cheng-Chieh Hsieh (3):
      wifi: rtw89: modify the register setting and the flow of CFO tracking
      wifi: rtw89: correct the DCFO tracking flow to improve CFO compensation
      wifi: rtw89: move software DCFO compensation setting to proper position

Chin-Yen Lee (2):
      wifi: rtw88: debug: add to check if debug mask is enabled
      wifi: rtw88: dump firmware debug information in abnormal state

Christian Marangi (11):
      net: sfp: add quirk for Fiberstone GPON-ONU-34-20BI
      netdev: replace simple napi_schedule_prep/__napi_schedule to napi_schedule
      netdev: make napi_schedule return bool on NAPI successful schedule
      netdev: replace napi_reschedule with napi_schedule
      net: tc35815: rework network interface interrupt logic
      netdev: use napi_schedule bool instead of napi_schedule_prep/__napi_schedule
      net: cxgb3: simplify logic for rspq_check_napi
      net: introduce napi_is_scheduled helper
      net: stmmac: improve TX timer arm logic
      net: stmmac: move TX timer arm after DMA enable
      net: stmmac: increase TX coalesce timer to 5ms

Christophe JAILLET (6):
      net: hinic: Use devm_kasprintf()
      wifi: ath: dfs_pattern_detector: Fix a memory initialization issue
      wifi: ath: dfs_pattern_detector: Use flex array to simplify code
      udp_tunnel: Use flex array to simplify code
      net: openvswitch: Use struct_size()
      net: openvswitch: Annotate struct mask_array with __counted_by

Chuck Lever (2):
      handshake: Fix sign of socket file descriptor fields
      handshake: Fix sign of key_serial_t fields

Chung-Hsuan Hung (1):
      wifi: rtw89: phy: change naming related BT coexistence functions

Chuyi Zhou (8):
      cgroup: Prepare for using css_task_iter_*() in BPF
      bpf: Introduce css_task open-coded iterator kfuncs
      bpf: Introduce task open coded iterator kfuncs
      bpf: Introduce css open-coded iterator kfuncs
      bpf: teach the verifier to enforce css_iter and task_iter in RCU CS
      bpf: Let bpf_iter_task_new accept null task ptr
      selftests/bpf: rename bpf_iter_task.c to bpf_iter_tasks.c
      selftests/bpf: Add tests for open-coded task and css iter

Claudia Draghicescu (1):
      Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID

Colin Ian King (7):
      net: dsa: microchip: Fix spelling mistake "unxpexted" -> "unexpected"
      net: dsa: mv88e6xxx: make const read-only array lanes static
      wifi: cfg80211: make read-only array centers_80mhz static const
      net: dsa: sja1105: make read-only const arrays static
      wifi: cfg80211: make read-only array centers_80mhz static const
      wifi: rt2x00: remove redundant check if u8 array element is less than zero
      net: dsa: microchip: ksz9477: Fix spelling mistake "Enery" -> "Energy"

Daan De Meyer (9):
      selftests/bpf: Add missing section name tests for getpeername/getsockname
      bpf: Propagate modified uaddrlen from cgroup sockaddr programs
      bpf: Add bpf_sock_addr_set_sun_path() to allow writing unix sockaddr from bpf
      bpf: Implement cgroup sockaddr hooks for unix sockets
      libbpf: Add support for cgroup unix socket address hooks
      bpftool: Add support for cgroup unix socket address hooks
      documentation/bpf: Document cgroup unix socket address hooks
      selftests/bpf: Make sure mount directory exists
      selftests/bpf: Add tests for cgroup unix socket address hooks

Dan Carpenter (7):
      tcp: indent an if statement
      net: microchip: sparx5: clean up error checking in vcap_show_admin()
      ptp: ocp: fix error code in probe()
      ptp: prevent string overflow
      igb: Fix an end of loop test
      ixgbe: fix end of loop test in ixgbe_set_vf_macvlan()
      Bluetooth: msft: __hci_cmd_sync() doesn't return NULL

Dan Nowlin (1):
      ice: Add support for E830 DDP package segment

Daniel Borkmann (13):
      Merge branch 'bpf-xsk-sh-umem'
      Merge branch 'bpf-log-improvements'
      net, sched: Make tc-related drop reason more flexible
      net, sched: Add tcf_set_drop_reason for {__,}tcf_classify
      selftests/bpf: Add additional mprog query test coverage
      bpf, tcx: Get rid of tcx_link_const
      netkit, bpf: Add bpf programmable net device
      tools: Sync if_link uapi header
      libbpf: Add link-based API for netkit
      bpftool: Implement link show support for netkit
      bpftool: Extend net dump with netkit progs
      selftests/bpf: Add netlink helper library
      selftests/bpf: Add selftests for netkit

Daniel Gabay (2):
      wifi: iwlwifi: add support for SNPS DPHYIP region type
      wifi: iwlwifi: read DSM func 2 for specific RF types

Daniel Mendes (2):
      kselftest: rtnetlink.sh: add verbose flag
      kselftest: rtnetlink: add pause and pause on fail flag

Dave Marchevsky (4):
      bpf: Don't explicitly emit BTF for struct btf_iter_num
      selftests/bpf: Rename bpf_iter_task_vma.c to bpf_iter_task_vmas.c
      bpf: Introduce task_vma open-coded iterator kfuncs
      selftests/bpf: Add tests for open-coded task_vma iter

Dave Thaler (1):
      bpf, docs: Define signed modulo as using truncated division

David Morley (2):
      tcp: record last received ipv6 flowlabel
      tcp: change data receiver flowlabel after one dup

David S. Miller (61):
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'selftests-classid'
      Merge branch 'ipv6-data-races'
      Merge branch 'icssg-half-duplex-support'
      Merge branch 'loongson1-mac'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'dsa-microchip-drive-strength-support'
      Merge branch 'TCP_INFO-RTO'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next -queue
      Merge branch 'dpll-api'
      Merge branch 'devlink-instances-relationships'
      Merge branch 'phy-stopping-race'
      Merge https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'vsock-tests'
      Merge branch 'pds_core-pci-reset'
      Merge branch 'kselftest-rtnetlink'
      Merge branch 'stmmac-tx-coe'
      Merge branch 'stmmac-devvm_stmmac_probe_config_dt-conversion'
      Merge branch 'net-platform-remove-void'
      Merge branch 'dsa-platform-remove-void'
      Merge branch 'mdio-platform-remove-void'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'ionic-better-tx-sg=handling'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'mlxsw-multicast'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'tcp_delack_max'
      Merge branch 'sch_fq-improvements'
      Merge branch 'dev-stats-virtio-l2tp_eth'
      Merge branch 'socket-option-lockless'
      Merge branch 'inet-more-data-race-fixes'
      Merge branch 'mlxsw-next'
      Merge branch 'bnxt_en-hwmon-SRIOV'
      Merge branch 'sfc-conntrack-offloads'
      Merge branch 'mlxsw-ACL-region'
      Merge branch 'virtio-net-interrupt-moderation'
      Merge branch 'dsa-validate-remove'
      Merge branch 'skb_segment-testing'
      Merge branch 'vxlan-fdb-flushing'
      Merge branch 'tls-cleanups'
      Merge branch 'vsock-virtio-vhost-zerocopy'
      Merge branch 'sfc-conntrack-offload'
      Merge branch 'i40e-devlink'
      Merge branch 'dpll-phase-offset-phase-adjust'
      Merge branch 'ptp-multiple-readers'
      Merge branch 'udp-tunnel-route-lookups'
      Merge branch 'devlink-deadlock'
      Merge branch 'ethtool-forced-speed'
      Merge tag 'nf-next-23-10-18' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'devlink-errors-fmsg'
      Merge branch 'netlink-auto-integers'
      Merge branch 'mlxsw-lag-table-allocation'
      Merge branch 'ksz886x-forced-link-modes'
      Merge branch 'ice-vf-resource-tracking'
      Merge branch 'bnxt_en-next'
      Merge branch 'consolidate-udp-ipv6-route-lookups'
      Merge branch 'tcp-ts-usec-resolution'
      Merge branch 'dsa-microchip-WoL-support'
      Merge branch 'mv88e6xxx-dsa-bindings'
      Merge branch 'tcp-ao'
      Merge branch 'mdb-get'

David Vernet (2):
      bpf: Add ability to pin bpf timer to calling CPU
      selftests/bpf: Test pinning bpf timer to a core

Davide Caratti (8):
      tools: ynl: add uns-admin-perm to genetlink legacy
      tools: ynl-gen: add support for exact-len validation
      net: mptcp: convert netlink from small_ops to ops
      Documentation: netlink: add a YAML spec for mptcp
      uapi: mptcp: use header file generated from YAML spec
      net: mptcp: rename netlink handlers to mptcp_pm_nl_<blah>_{doit,dumpit}
      net: mptcp: use policy generated by YAML spec
      doc/netlink: Update schema to support cmd-cnt-name and cmd-max-name

Denys Zagorui (2):
      bpftool: Fix -Wcast-qual warning
      samples: bpf: Fix syscall_tp openat argument

Deren Wu (10):
      wifi: mt76: connac: introduce helper for mt7925 chipset
      wifi: mt76: mt792x: support mt7925 chip init
      wifi: mt76: connac: export functions for mt7925
      wifi: mt76: connac: add eht support for phy mode config
      wifi: mt76: connac: add eht support for tx power
      wifi: mt76: connac: add data field in struct tlv
      wifi: mt76: connac: add more unified command IDs
      wifi: mt76: connac: add more unified event IDs
      wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips
      wifi: mt76: mt7921: move connac nic capability handling to mt7921

Dmitry Antipov (36):
      wifi: plfxlc: fix clang-specific fortify warning
      wifi: mac80211_hwsim: fix clang-specific fortify warning
      wifi: wext: avoid extra calls to strlen() in ieee80211_bss()
      wifi: ath9k: simplify ar9003_hw_process_ini()
      wifi: ath9k: use u32 for txgain indexes
      wifi: ath9k: fix clang-specific fortify warnings
      wifi: ath10k: fix clang-specific fortify warning
      wifi: mwifiex: cleanup struct mwifiex_sdio_mpa_rx
      wifi: ath10k: drop HTT_DATA_TX_STATUS_DOWNLOAD_FAIL
      wifi: ath11k: drop NULL pointer check in ath11k_update_per_peer_tx_stats()
      wifi: ath11k: drop redundant check in ath11k_dp_rx_mon_dest_process()
      wifi: ath11k: remove unused members of 'struct ath11k_base'
      wifi: mwifiex: simplify PCIE write operations
      wifi: mwifiex: followup PCIE and related cleanups
      wifi: ath11k: use kstrtoul_from_user() where appropriate
      wifi: ath11k: fix ath11k_mac_op_remain_on_channel() stack usage
      wifi: rtlwifi: cleanup few rtlxxxx_set_hw_reg() routines
      wifi: mt76: add DMA mapping error check in mt76_alloc_txwi()
      wifi: mt76: fix clang-specific fortify warnings
      wifi: ath10k: consistently use kstrtoX_from_user() functions
      wifi: rtlwifi: fix EDCA limit set by BT coexistence
      wifi: rtlwifi: use unsigned long for rtl_bssid_entry timestamp
      wifi: ath10k: simplify ath10k_peer_create()
      wifi: rtlwifi: remove unreachable code in rtl92d_dm_check_edca_turbo()
      wifi: rtlwifi: use unsigned long for bt_coexist_8723 timestamp
      wifi: ath12k: remove redundant memset() in ath12k_hal_reo_qdesc_setup()
      wifi: rtlwifi: use convenient list_count_nodes()
      wifi: rtlwifi: simplify TX command fill callbacks
      wifi: rtlwifi: cleanup struct rtl_ps_ctl
      wifi: rtlwifi: drop pre_fill_tx_bd_desc() from HAL interface
      wifi: rtlwifi: drop fill_fake_txdesc() from HAL interface
      wifi: rtlwifi: drop chk_switch_dmdp() from HAL interface
      wifi: remove unused argument of ieee80211_get_tdls_action()
      wifi: iwlwifi: check for kmemdup() return value in iwl_parse_tlv_firmware()
      wifi: iwlwifi: drop NULL pointer check in iwl_mvm_tzone_set_trip_temp()
      wifi: rtw89: cleanup firmware elements parsing

Dmitry Safonov (23):
      net/tcp: Prepare tcp_md5sig_pool for TCP-AO
      net/tcp: Add TCP-AO config and structures
      net/tcp: Introduce TCP_AO setsockopt()s
      net/tcp: Prevent TCP-MD5 with TCP-AO being set
      net/tcp: Calculate TCP-AO traffic keys
      net/tcp: Add TCP-AO sign to outgoing packets
      net/tcp: Add tcp_parse_auth_options()
      net/tcp: Add AO sign to RST packets
      net/tcp: Add TCP-AO sign to twsk
      net/tcp: Wire TCP-AO to request sockets
      net/tcp: Sign SYN-ACK segments with TCP-AO
      net/tcp: Verify inbound TCP-AO signed segments
      net/tcp: Add TCP-AO segments counters
      net/tcp: Add TCP-AO SNE support
      net/tcp: Add tcp_hash_fail() ratelimited logs
      net/tcp: Ignore specific ICMPs for TCP-AO connections
      net/tcp: Add option for TCP-AO to (not) hash header
      net/tcp: Add TCP-AO getsockopt()s
      net/tcp: Allow asynchronous delete for TCP-AO keys (MKTs)
      net/tcp: Add static_key for TCP-AO
      net/tcp: Wire up l3index to TCP-AO
      net/tcp: Add TCP_AO_REPAIR
      Documentation/tcp: Add TCP-AO documentation

Dongliang Mu (1):
      wifi: ath9k: clean up function ath9k_hif_usb_resume

Douglas Anderson (1):
      wifi: ath10k: Don't touch the CE interrupt registers after power up

Eduard Zingerman (7):
      bpf: move explored_state() closer to the beginning of verifier.c
      bpf: extract same_callsites() as utility function
      bpf: exact states comparison for iterator convergence checks
      selftests/bpf: tests with delayed read/precision makrs in loop body
      bpf: correct loop detection for iterators convergence
      selftests/bpf: test if state loops are detected in a tricky case
      bpf: print full verifier states on infinite loop detection

Edward Cree (6):
      sfc: support TC left-hand-side rules on foreign netdevs
      sfc: offload foreign RHS rules without an encap match
      sfc: ensure an extack msg from efx_tc_flower_replace_foreign EOPNOTSUPPs
      sfc: support TC rules which require OR-AR-CT-AR flow
      sfc: parse mangle actions (NAT) in conntrack entries
      sfc: support offloading ct(nat) action in RHS rules

Edwin Peer (5):
      bnxt_en: add infrastructure to lookup ethtool link mode
      bnxt_en: support lane configuration via ethtool
      bnxt_en: refactor speed independent ethtool modes
      bnxt_en: convert to linkmode_set_bit() API
      bnxt_en: extend media types to supported and autoneg modes

Emmanuel Grumbach (14):
      wifi: mac80211: add support for mld in ieee80211_chswitch_done
      wifi: iwlwifi: mvm: support CSA with MLD
      wifi: iwlwifi: honor the enable_ini value
      wifi: iwlwifi: mvm: log dropped frames
      wifi: iwlwifi: mvm: fix recovery flow in CSA
      wifi: iwlwifi: mvm: add a debug print when we get a BAR
      wifi: mac80211: update the rx_chains after set_antenna()
      wifi: iwlwifi: mvm: support set_antenna()
      wifi: mac80211: fix a expired vs. cancel race in roc
      wifi: iwlwifi: mvm: don't add dummy phy context
      wifi: iwlwifi: mvm: fold the ref++ into iwl_mvm_phy_ctxt_add
      wifi: iwlwifi: mvm: fix the PHY context resolution for p2p device
      wifi: iwlwifi: disable multi rx queue for 9000
      wifi: iwlwifi: mvm: simplify the reorder buffer

Erez Shitrit (3):
      net/mlx5: Bridge, Enable mcast in smfs steering mode
      net/mlx5: DR, Add check for multi destination FTE
      net/mlx5: DR, Handle multi destination action in the right order

Eric Dumazet (86):
      tcp: no longer release socket ownership in tcp_release_cb()
      net: sock_release_ownership() cleanup
      net: call prot->release_cb() when processing backlog
      tcp: defer regular ACK while processing socket backlog
      udp: introduce udp->udp_flags
      udp: move udp->no_check6_tx to udp->udp_flags
      udp: move udp->no_check6_rx to udp->udp_flags
      udp: move udp->gro_enabled to udp->udp_flags
      udp: add missing WRITE_ONCE() around up->encap_rcv
      udp: move udp->accept_udp_{l4|fraglist} to udp->udp_flags
      udp: lockless UDP_ENCAP_L2TPINUDP / UDP_GRO
      udp: annotate data-races around udp->encap_type
      udplite: remove UDPLITE_BIT
      udplite: fix various data-races
      ipv6: lockless IPV6_UNICAST_HOPS implementation
      ipv6: lockless IPV6_MULTICAST_LOOP implementation
      ipv6: lockless IPV6_MULTICAST_HOPS implementation
      ipv6: lockless IPV6_MTU implementation
      ipv6: lockless IPV6_MINHOPCOUNT implementation
      ipv6: lockless IPV6_RECVERR_RFC4884 implementation
      ipv6: lockless IPV6_MULTICAST_ALL implementation
      ipv6: lockless IPV6_AUTOFLOWLABEL implementation
      ipv6: lockless IPV6_DONTFRAG implementation
      ipv6: lockless IPV6_RECVERR implemetation
      ipv6: move np->repflow to atomic flags
      ipv6: lockless IPV6_ROUTER_ALERT_ISOLATE implementation
      ipv6: lockless IPV6_MTU_DISCOVER implementation
      ipv6: lockless IPV6_FLOWINFO_SEND implementation
      net: use indirect call helpers for sk->sk_prot->release_cb()
      net: add truesize debug checks in skb_{add|coalesce}_rx_frag()
      ipv6: lockless IPV6_ADDR_PREFERENCES implementation
      net: constify sk_dst_get() and __sk_dst_get() argument
      tcp: constify tcp_rto_min() and tcp_rto_min_us() argument
      tcp: derive delack_max from rto_min
      net_sched: constify qdisc_priv()
      net_sched: sch_fq: struct sched_data reorg
      net_sched: sch_fq: change how @inactive is tracked
      net_sched: sch_fq: add fast path for mostly idle qdisc
      net_sched: sch_fq: always garbage collect
      net: add DEV_STATS_READ() helper
      virtio_net: avoid data-races on dev->stats fields
      net: l2tp_eth: use generic dev->stats fields
      net: implement lockless SO_PRIORITY
      net: lockless SO_PASSCRED, SO_PASSPIDFD and SO_PASSSEC
      net: lockless SO_{TYPE|PROTOCOL|DOMAIN|ERROR } setsockopt()
      net: lockless implementation of SO_BUSY_POLL, SO_PREFER_BUSY_POLL, SO_BUSY_POLL_BUDGET
      net: implement lockless SO_MAX_PACING_RATE
      net: lockless implementation of SO_TXREHASH
      net: annotate data-races around sk->sk_tx_queue_mapping
      net: annotate data-races around sk->sk_dst_pending_confirm
      inet: implement lockless IP_MULTICAST_TTL
      inet: implement lockless IP_MTU_DISCOVER
      inet: implement lockless IP_TOS
      inet: lockless getsockopt(IP_OPTIONS)
      inet: lockless getsockopt(IP_MTU)
      inet: implement lockless getsockopt(IP_UNICAST_IF)
      inet: lockless IP_PKTOPTIONS implementation
      inet: implement lockless getsockopt(IP_MULTICAST_IF)
      tcp_metrics: add missing barriers on delete
      tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()
      tcp_metrics: do not create an entry from tcp_init_metrics()
      tcp_metrics: optimize tcp_metrics_flush_all()
      net: skb_queue_purge_reason() optimizations
      net_sched: sch_fq: remove q->ktime_cache
      net_sched: export pfifo_fast prio2band[]
      net_sched: sch_fq: add 3 bands and WRR scheduling
      net_sched: sch_fq: add TCA_FQ_WEIGHTS attribute
      net: sock_dequeue_err_skb() optimization
      inet: lock the socket in ip_sock_set_tos()
      chtls: fix tp->rcv_tstamp initialization
      tcp: fix cookie_init_timestamp() overflows
      tcp: add tcp_time_stamp_ms() helper
      tcp: introduce tcp_clock_ms()
      tcp: replace tcp_time_stamp_raw()
      tcp: rename tcp_skb_timestamp()
      tcp: move tcp_ns_to_ts() to net/ipv4/syncookies.c
      tcp: rename tcp_time_stamp() to tcp_time_stamp_ts()
      tcp: add tcp_rtt_tsopt_us()
      tcp: add RTAX_FEATURE_TCP_USEC_TS
      tcp: introduce TCP_PAWS_WRAP
      tcp: add support for usec resolution in TCP TS values
      tcp: add TCPI_OPT_USEC_TS
      net_sched: sch_fq: fix off-by-one error in fq_dequeue()
      net_sched: sch_fq: fastpath needs to take care of sk->sk_pacing_status
      virtio_net: use u64_stats_t infra to avoid data-races
      ipvlan: properly track tx_errors

Fabio Estevam (1):
      dt-bindings: net: fec: Add imx8dxl description

Fei Qin (1):
      nfp: using napi_build_skb() to replace build_skb()

Felipe Negrelli Wolter (1):
      wifi: wfx: fix case where rates are out of order

Felix Fietkau (9):
      wifi: mt76: mt7603: rework/fix rx pse hang check
      wifi: mt76: mt7603: improve watchdog reset reliablity
      wifi: mt76: mt7603: improve stuck beacon handling
      wifi: mt76: mt7603: add missing register initialization for MT7628
      wifi: mt76: mt7603: disable A-MSDU tx support on MT7628
      wifi: mt76: fix race condition related to checking tx queue fill status
      wifi: mt76: remove unused error path in mt76_connac_tx_complete_skb
      wifi: mt76: mt7915: fix monitor mode issues
      wifi: mt76: mt7915 add tc offloading support

Florian Fainelli (3):
      net: bcmgenet: Remove custom ndo_poll_controller()
      net: dsa: Use conduit and user terms
      net: dsa: Rename IFLA_DSA_MASTER to IFLA_DSA_CONDUIT

Florian Westphal (18):
      netfilter: nf_nat: undo erroneous tcp edemux lookup after port clash
      selftests: netfilter: test nat source port clash resolution interaction with tcp early demux
      netfilter: conntrack: simplify nf_conntrack_alter_reply
      netfilter: conntrack: prefer tcp_error_log to pr_debug
      net: gso_test: fix build with gcc-12 and earlier
      net: gso_test: release each segment individually
      netfilter: xt_mangle: only check verdict part of return value
      netfilter: nf_tables: mask out non-verdict bits when checking return value
      netfilter: conntrack: convert nf_conntrack_update to netfilter verdicts
      netfilter: nf_nat: mask out non-verdict bits when checking return value
      netfilter: make nftables drops visible in net dropmonitor
      netfilter: bridge: convert br_netfilter to NF_DROP_REASON
      netfilter: nf_tables: de-constify set commit ops function argument
      netfilter: nft_set_rbtree: rename gc deactivate+erase function
      netfilter: nft_set_rbtree: prefer sync gc to async worker
      br_netfilter: use single forward hook for ip and arp
      netfilter: conntrack: switch connlabels to atomic_t
      sched: act_ct: switch to per-action label counting

Gan Yi Fang (1):
      net: stmmac: Remove redundant checking for rx_coalesce_usecs

Gavrilov Ilia (3):
      ipv4: igmp: Remove redundant comparison in igmp_mcf_get_next()
      ipv6: mcast: Remove redundant comparison in igmp6_mcf_get_next()
      net: atm: Remove redundant check.

Geert Uytterhoeven (1):
      sctp: Spelling s/preceeding/preceding/g

Geliang Tang (12):
      selftests/bpf: Enable CONFIG_VSOCKETS in config
      selftests/bpf: Add pairs_redir_to_connected helper
      selftests: mptcp: run userspace pm tests slower
      selftests: mptcp: fix wait_rm_addr/sf parameters
      mptcp: userspace pm send RM_ADDR for ID 0
      mptcp: drop useless ssk in pm_subflow_check_next
      mptcp: use mptcp_check_fallback helper
      mptcp: use mptcp_get_ext helper
      mptcp: move sk assignment statement ahead
      mptcp: define more local variables sk
      selftests: mptcp: sockopt: drop mptcp_connect var
      selftests: mptcp: display simult in extra_msg

George Guo (1):
      netfilter: cleanup struct nft_table

Gerhard Engleder (2):
      tsnep: Inline small fragments within TX descriptor
      tsnep: Fix tsnep_request_irq() format-overflow warning

Giulio Benetti (1):
      net: phy: broadcom: add support for BCM5221 phy

Greg Kroah-Hartman (1):
      net: appletalk: remove cops support

Gregory Greenman (6):
      wifi: iwlwifi: fw: disable firmware debug asserts
      wifi: iwlwifi: bump FW API to 84 for AX/BZ/SC devices
      wifi: iwlwifi: fw: increase fw_version string size
      wifi: iwlwifi: mvm: fix size check for fw_link_id
      wifi: iwlwifi: mvm: fix regdb initialization
      wifi: iwlwifi: bump FW API to 86 for AX/BZ/SC devices

Guan Wentao (1):
      Bluetooth: btusb: Add 0bda:b85b for Fn-Link RTL8852BE

Gustavo A. R. Silva (9):
      gve: Use size_add() in call to struct_size()
      mlxsw: Use size_mul() in call to struct_size()
      tls: Use size_add() in call to struct_size()
      tipc: Use size_add() in calls to struct_size()
      net: spider_net: Use size_add() in call to struct_size()
      wifi: hostap: Add __counted_by for struct prism2_download_data and use struct_size()
      wifi: brcmfmac: fweh: Add __counted_by for struct brcmf_fweh_queue_item and use struct_size()
      net: wwan: t7xx: Add __counted_by for struct t7xx_fsm_event and use struct_size()
      wifi: mac80211: Add __counted_by for struct ieee802_11_elems and use struct_size()

Haim Dreyfuss (1):
      wifi: iwlwifi: mvm: extend alive timeout to 2 seconds

Haiyang Zhang (1):
      tcp: Set pingpong threshold via sysctl

Haiyue Wang (2):
      ice: Support FCS/CRC strip disable for VF
      ice: Check CRC strip requirement for VLAN strip

Hao Chen (1):
      net: hns3: add some link modes for hisilicon device

Hari Chandrakanthan (1):
      wifi: ath12k: do not drop data frames from unassociated stations

Harini Katakam (2):
      MAINTAINERS: Add an obsolete entry for LL TEMAC driver
      MAINTAINERS: Update LL TEMAC entry to Orphan

Hariprasad Kelam (2):
      octeontx2-pf: Enable PTP PPS output support
      octeontx2-pf: Tc flower offload support for MPLS

Harshitha Prem (2):
      wifi: ath12k: Ignore fragments from uninitialized peer in  dp
      wifi: ath12k: fix undefined behavior with __fls in dp

Hayes Wang (2):
      r8152: break the loop when the budget is exhausted
      r8152: use napi_gro_frags

Heiner Kallweit (1):
      r8169: fix rare issue with broken rx after link-down on RTL8125

Heng Guo (2):
      net: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after fragment check
      net: fix IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams.

Heng Qi (6):
      virtio-net: initially change the value of tx-frames
      virtio-net: fix mismatch of getting tx-frames
      virtio-net: consistently save parameters for per-queue
      virtio-net: fix per queue coalescing parameter setting
      virtio-net: fix the vq coalescing setting for vq resize
      virtio-net: a tiny comment update

Hengqi Chen (4):
      libbpf: Resolve symbol conflicts at the same offset for uprobe
      libbpf: Support symbol versioning for uprobe
      selftests/bpf: Add tests for symbol versioning for uprobe
      libbpf: Allow Golang symbols in uprobe secdef

Hou Tao (11):
      bpf: Enable IRQ after irq_work_raise() completes in unit_alloc()
      bpf: Enable IRQ after irq_work_raise() completes in unit_free{_rcu}()
      selftests/bpf: Test preemption between bpf_obj_new() and bpf_obj_drop()
      mm/percpu.c: don't acquire pcpu_lock for pcpu_chunk_addr_search()
      mm/percpu.c: introduce pcpu_alloc_size()
      bpf: Re-enable unit_size checking for global per-cpu allocator
      bpf: Use pcpu_alloc_size() in bpf_mem_free{_rcu}()
      bpf: Move the declaration of __bpf_obj_drop_impl() to bpf.h
      bpf: Use bpf_global_percpu_ma for per-cpu kptr in __bpf_obj_drop_impl()
      selftests/bpf: Add more test cases for bpf memory allocator
      bpf: Add more WARN_ON_ONCE checks for mismatched alloc and free

Howard Hsu (3):
      wifi: mt76: mt7996: fix beamform mcu cmd configuration
      wifi: mt76: mt7996: fix beamformee ss subfield in EHT PHY cap
      wifi: mt76: mt7996: support more options for mt7996_set_bitrate_mask()

Ian Rogers (2):
      bpftool: Align output skeleton ELF code
      bpftool: Align bpf_load_and_run_opts insns and data

Ido Schimmel (17):
      mlxsw: core_thermal: Fix -Wformat-truncation warning
      mlxsw: spectrum_ethtool: Fix -Wformat-truncation warning
      mlxsw: pci: Allocate skbs using GFP_KERNEL during initialization
      bridge: mcast: Dump MDB entries even when snooping is disabled
      bridge: mcast: Account for missing attributes
      bridge: mcast: Factor out a helper for PG entry size calculation
      bridge: mcast: Rename MDB entry get function
      vxlan: mdb: Adjust function arguments
      vxlan: mdb: Factor out a helper for remote entry size calculation
      bridge: add MDB get uAPI attributes
      net: Add MDB get device operation
      bridge: mcast: Add MDB get support
      vxlan: mdb: Add MDB get support
      rtnetlink: Add MDB get support
      selftests: bridge_mdb: Use MDB get instead of dump
      selftests: vxlan_mdb: Use MDB get instead of dump
      netdevsim: Block until all devices are released

Ilan Peer (15):
      wifi: mac80211: Fix SMPS handling in the context of MLO
      wifi: mac80211: Print local link address during authentication
      wifi: mac80211: Do not force off-channel for management Tx with MLO
      wifi: mac80211: Notify the low level driver on change in MLO valid links
      wifi: mac80211_hwsim: Handle BSS_CHANGED_VALID_LINKS
      wifi: mac80211: Rename and update IEEE80211_VIF_DISABLE_SMPS_OVERRIDE
      wifi: cfg80211: Include operating class 137 in 6GHz band
      wifi: cfg80211: Handle specific BSSID in 6GHz scanning
      wifi: mac80211: Fix setting vif links
      wifi: cfg80211: Fix typo in documentation
      wifi: iwlwifi: mvm: Add basic link selection logic
      wifi: iwlwifi: mvm: Don't always bind/link the P2P Device interface
      wifi: iwlwifi: mvm: Correctly set link configuration
      wifi: iwlwifi: mvm: Fix unreachable code path
      wifi: iwlwifi: mvm: Fix key flags for IGTK on AP interface

Ilya Leoshkevich (10):
      bpf: Disable zero-extension for BPF_MEMSX
      selftests/bpf: Unmount the cgroup2 work directory
      selftests/bpf: Add big-endian support to the ldsx test
      s390/bpf: Implement BPF_MOV | BPF_X with sign-extension
      s390/bpf: Implement BPF_MEMSX
      s390/bpf: Implement unconditional byte swap
      s390/bpf: Implement unconditional jump with 32-bit offset
      s390/bpf: Implement signed division
      selftests/bpf: Enable the cpuv4 tests for s390x
      selftests/bpf: Trim DENYLIST.s390x

Ilya Maximets (1):
      openvswitch: reduce stack usage in do_execute_actions

Ingo Rohloff (1):
      wifi: mt76: mt7921e: Support MT7992 IP in Xiaomi Redmibook 15 Pro (2023)

Iulia Tanasescu (5):
      Bluetooth: ISO: Fix BIS cleanup
      Bluetooth: ISO: Pass BIG encryption info through QoS
      Bluetooth: ISO: Allow binding a bcast listener to 0 bises
      Bluetooth: ISO: Match QoS adv handle with BIG handle
      Bluetooth: ISO: Fix bcast listener cleanup

Ivan Vecera (15):
      i40e: Remove back pointer from i40e_hw structure
      i40e: Move I40E_MASK macro to i40e_register.h
      i40e: Refactor I40E_MDIO_CLAUSE* macros
      virtchnl: Add header dependencies
      i40e: Simplify memory allocation functions
      i40e: Move memory allocation structures to i40e_alloc.h
      i40e: Split i40e_osdep.h
      i40e: Remove circular header dependencies and fix headers
      i40e: Move DDP specific macros and structures to i40e_ddp.c
      i40e: Add initial devlink support
      i40e: Split and refactor i40e_nvm_version_str()
      i40e: Add handler for devlink .info_get
      i40e: Refactor and rename i40e_read_pba_string()
      i40e: Add PBA as board id info to devlink .info_get
      i40e: Align devlink info versions with ice driver and add docs

Jacob Keller (11):
      ice: Support cross-timestamping for E823 devices
      ice: introduce hw->phy_model for handling PTP PHY differences
      ice: remove ICE_F_PTP_EXTTS feature flag
      ice: fix pin assignment for E810-T without SMA control
      ice: introduce ice_pf_src_tmr_owned
      ice: check netlist before enabling ICE_F_GNSS
      iavf: remove "inline" functions from iavf_txrx.c
      ice: fix linking when CONFIG_PTP_1588_CLOCK=n
      net: stub tcp_gro_complete if CONFIG_INET=n
      ice: make ice_get_pf_c827_idx static
      ice: cleanup ice_find_netlist_node

Jakub Kicinski (84):
      Merge branch 'batch-1-annotate-structs-with-__counted_by'
      Merge branch 'mlxsw-annotate-structs-with-__counted_by'
      Merge branch 'fix-implicit-sign-conversions-in-handshake-upcall'
      Merge branch 'bpf-remove-xdp_do_flush_map'
      Merge branch 'introduce-define_flex-macro'
      Merge branch 'documentation-fixes-for-dpll-subsystem'
      Revert "bnxt_en: Support QOS and TPID settings for the SRIOV VLAN"
      Merge tag 'nf-next-23-09-28' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'chelsio-annotate-structs-with-__counted_by'
      Merge branch 'r8152-modify-rx_bottom'
      Merge branch 'fix-a-couple-recent-instances-of-wincompatible-function-pointer-types-strict-from-mode_get-implementations'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      ynl: netdev: drop unnecessary enum-as-flags
      tools: ynl: don't regen on every make
      tools: ynl: use uAPI include magic for samples
      Merge branch 'ynl-makefile-cleanup'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'rework-tx-fault-fixups'
      tools: ynl-gen: use uapi header name for the header guard
      Merge tag 'linux-can-next-for-6.7-20231005' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge tag 'wireless-next-2023-10-06' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'tools-ynl-gen-lift-type-requirement-for-attribute-subsets'
      tools: ynl-gen: handle do ops with no input attrs
      Merge branch 'add-vf-fault-detect-support-for-hns3-ethernet-driver'
      tools: ynl: use ynl-gen -o instead of stdout in Makefile
      Merge tag 'nf-next-23-10-10' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'mlx5-next' of https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'wangxun-ethtool-stats'
      Merge branch 'net-netconsole-configfs-entries-for-boot-target'
      docs: try to encourage (netdev?) reviewers
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge tag 'wireless-next-2023-10-16' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'bridge-add-a-limit-on-learned-fdb-entries'
      eth: bnxt: fix backward compatibility with older devices
      Merge branch 'net-remove-last-of-the-phylink-validate-methods-and-clean-up'
      tools: ynl: fix converting flags to names after recent cleanup
      docs: netlink: clean up after deprecating version
      Merge tag 'mlx5-updates-2023-10-10' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'net-fec-fix-device_get_match_data-usage'
      Merge branch 'selftests-tc-testing-fixes-for-kselftest'
      Merge branch 'intel-wired-lan-driver-updates-2023-10-17'
      docs: networking: document multi-RSS context
      Merge branch 'dt-bindings-net-child-node-schema-cleanups'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      tools: ynl-gen: track attribute use
      tools: ynl-gen: support full range of min/max checks for integer values
      tools: ynl-gen: support limit names
      Merge branch 'tools-ynl-gen-support-full-range-of-min-max-checks'
      tools: ynl-gen: make the mnl_type() method public
      netlink: add variable-length / auto integers
      netlink: specs: add support for auto-sized scalars
      ethtool: untangle the linkmode and ethtool headers
      tools: ynl-gen: change spacing around __attribute__
      Merge branch 'intel-wired-lan-driver-updates-2023-10-19-idpf'
      Merge branch 'devlink-finish-conversion-to-generated-split_ops'
      Merge tag 'for-net-next-2023-10-23' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'introduce-page_pool_alloc-related-api'
      Merge branch 'mptcp-convert-netlink-code-to-use-yaml-spec'
      net: don't use input buffer of __dev_alloc_name() as a scratch space
      net: make dev_alloc_name() call dev_prep_valid_name()
      net: reduce indentation of __dev_alloc_name()
      net: trust the bitmap in __dev_alloc_name()
      net: remove dev_valid_name() check from __dev_alloc_name()
      net: remove else after return in dev_prep_valid_name()
      Merge branch 'net-deduplicate-netdev-name-allocation'
      Merge branch 'switch-dsa-to-inclusive-terminology'
      Merge branch 'net-ethernet-renesas-infrastructure-preparations-for-upcoming-driver'
      Revert "Merge branch 'mv88e6xxx-dsa-bindings'"
      Merge branch 'mptcp-features-and-fixes-for-v6-7'
      Merge branch 'ipv6-avoid-atomic-fragment-on-gso-output'
      Merge branch 'net-ipv6-addrconf-ensure-that-temporary-addresses-preferred-lifetimes-are-in-the-valid-range'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      netlink: make range pointers in policies const
      netlink: specs: support conditional operations
      tools: ynl-gen: respect attr-cnt-name at the attr set level
      Merge tag 'for-netdev' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge tag 'wireless-next-2023-10-26' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'intel-wired-lan-driver-updates-for-2023-10-25-ice'
      net: selftests: use ethtool_sprintf()
      Merge branch 'mptcp-fixes-and-cleanup-for-v6-7'
      Merge branch 'net-dsa-microchip-provide-wake-on-lan-support-part-2'
      Merge branch 'intel-wired-lan-driver-updates-for-2023-10-23-iavf'

Jan Kiszka (1):
      net: ti: icssg-prueth: Add phys_port_name support

Janne Grunau (1):
      Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_CODED

Jeff Johnson (8):
      wifi: mac80211: Use flexible array in struct ieee80211_tim_ie
      wifi: cw1200: Avoid processing an invalid TIM IE
      wifi: ath12k: Consistently use ath12k_vif_to_arvif()
      wifi: ath11k: Remove unused struct ath11k_htc_frame
      wifi: ath11k: Introduce and use ath11k_sta_to_arsta()
      wifi: ath11k: Remove ath11k_base::bd_api
      wifi: ath12k: Remove ath12k_base::bd_api
      wifi: ath12k: Introduce and use ath12k_sta_to_arsta()

Jen-Hao Cheng (1):
      wifi: mt76: mt7996: support per-band LED control

Jeremy Kerr (1):
      i3c: Add support for bus enumeration & notification

Jesse Brandeburg (2):
      intel: fix string truncation warnings
      intel: fix format warnings

Jianbo Liu (2):
      net/mlx5e: Consider aggregated port speed during rate configuration
      net/mlx5e: Check police action rate for matchall filter

Jiapeng Chong (1):
      can: raw: Remove NULL check before dev_{put, hold}

Jiawen Wu (5):
      net: wangxun: move MDIO bus implementation to the library
      net: libwx: support hardware statistics
      net: txgbe: add ethtool stats support
      net: ngbe: add ethtool stats support
      net: wangxun: remove redundant kernel log

Jie Wang (2):
      net: hns3: add hns3 vf fault detect cap bit support
      net: hns3: add vf fault detect support

Jinghao Jia (2):
      samples/bpf: syscall_tp_user: Rename num_progs into nr_tests
      samples/bpf: syscall_tp_user: Fix array out-of-bound access

Jingyang Wang (1):
      Bluetooth: Add support ITTIM PE50-M75C

Jinjie Ruan (6):
      wifi: rtw88: debug: Fix the NULL vs IS_ERR() bug for debugfs_create_file()
      ethernet/intel: Use list_for_each_entry() helper
      wifi: mt76: Use PTR_ERR_OR_ZERO() to simplify code
      wifi: mt76: Drop unnecessary error check for debugfs_create_dir()
      wifi: rtw88: Remove duplicate NULL check before calling usb_kill/free_urb()
      net/mlx5: Use PTR_ERR_OR_ZERO() to simplify code

Jiri Olsa (9):
      bpf: Count stats for kprobe_multi programs
      bpf: Add missed value to kprobe_multi link info
      bpf: Add missed value to kprobe perf link info
      bpf: Count missed stats in trace_call_bpf
      bpftool: Display missed count for kprobe_multi link
      bpftool: Display missed count for kprobe perf link
      selftests/bpf: Add test for missed counts of perf event link kprobe
      selftests/bpf: Add test for recursion counts of perf event link kprobe
      selftests/bpf: Add test for recursion counts of perf event link tracepoint

Jiri Pirko (44):
      netdev: expose DPLL pin handle for netdevice
      mlx5: Implement SyncE support using DPLL infrastructure
      devlink: move linecard struct into linecard.c
      net/mlx5: Disable eswitch as the first thing in mlx5_unload()
      net/mlx5: Lift reload limitation when SFs are present
      devlink: put netnsid to nested handle
      devlink: move devlink_nl_put_nested_handle() into netlink.c
      devlink: extend devlink_nl_put_nested_handle() with attrtype arg
      devlink: introduce object and nested devlink relationship infra
      devlink: expose peer SF devlink instance
      net/mlx5: SF, Implement peer devlink set for SF representor devlink port
      devlink: convert linecard nested devlink to new rel infrastructure
      devlink: introduce possibility to expose info about nested devlinks
      net/mlx5e: Set en auxiliary devlink instance as nested
      net/mlx5: Call mlx5_sf_id_erase() once in mlx5_sf_dealloc()
      net/mlx5: Use devlink port pointer to get the pointer of container SF struct
      net/mlx5: Convert SF port_indices xarray to function_ids xarray
      net/mlx5: Move state lock taking into mlx5_sf_dealloc()
      net/mlx5: Rename mlx5_sf_deactivate_all() to mlx5_sf_del_all()
      net/mlx5: Push common deletion code into mlx5_sf_del()
      net/mlx5: Remove SF table reference counting
      net/mlx5: Remove redundant max_sfs check and field from struct mlx5_sf_dev_table
      tools: ynl-gen: lift type requirement for attribute subsets
      netlink: specs: remove redundant type keys from attributes in subsets
      netlink: specs: don't allow version to be specified for genetlink
      selftests: netdevsim: use suitable existing dummy file for flash test
      net: treat possible_net_t net pointer as an RCU one and add read_pnet_rcu()
      devlink: call peernet2id_alloc() with net pointer under RCU read lock
      devlink: take device reference for devlink object
      devlink: don't take instance lock for nested handle put
      Documentation: devlink: add nested instance section
      Documentation: devlink: add a note about RTNL lock into locking section
      devlink: document devlink_rel_nested_in_notify() function
      genetlink: don't merge dumpit split op for different cmds into single iter
      tools: ynl-gen: introduce support for bitfield32 attribute type
      tools: ynl-gen: render rsp_parse() helpers if cmd has only dump op
      netlink: specs: devlink: remove reload-action from devlink-get cmd reply
      netlink: specs: devlink: make dont-validate single line
      devlink: make devlink_flash_overwrite enum named one
      devlink: rename netlink callback to be aligned with the generated ones
      netlink: specs: devlink: add the remaining command to generate complete split_ops
      devlink: remove duplicated netlink callback prototypes
      devlink: remove netlink small_ops
      tools: ynl: introduce option to process unknown attributes or types

Jisheng Zhang (23):
      net: stmmac: dwmac-anarion: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-dwc-qos-eth: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-generic: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-generic: use devm_stmmac_pltfr_probe()
      net: stmmac: dwmac-imx: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-ingenic: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-intel-plat: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-ipq806x: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-lpc18xx: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-mediatek: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-meson: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-meson8b: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-rk: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-socfpga: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-starfive: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-sti: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-stm32: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-sun8i: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-sunxi: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-tegra: use devm_stmmac_probe_config_dt()
      net: stmmac: dwmac-visconti: use devm_stmmac_probe_config_dt()
      net: stmmac: rename stmmac_pltfr_remove_no_dt to stmmac_pltfr_remove
      net: stmmac: make stmmac_{probe|remove}_config_dt static

Johan Hovold (6):
      wifi: ath11k: fix temperature event locking
      wifi: ath11k: fix dfs radar event locking
      wifi: ath11k: fix htt pktlog locking
      wifi: ath11k: fix gtk offload status event locking
      wifi: ath12k: fix dfs-radar and temperature event locking
      wifi: ath12k: fix htt mlo-offset event locking

Johannes Berg (131):
      wifi: mac80211: tx: clarify conditions in if statement
      wifi: mac80211: rework ack_frame_id handling a bit
      wifi: mac80211: fix SMPS status handling
      wifi: mac80211: debugfs: lock wiphy instead of RTNL
      wifi: mac80211: hold wiphy lock in netdev/link debugfs
      wifi: mac80211: lock wiphy for aggregation debugfs
      wifi: cfg80211: check RTNL when iterating devices
      wifi: cfg80211: add flush functions for wiphy work
      wifi: mac80211: flush wiphy work where appropriate
      wifi: mac80211: convert A-MPDU work to wiphy work
      wifi: mac80211: add more ops assertions
      wifi: mac80211: move DFS CAC work to wiphy work
      wifi: mac80211: move radar detect work to wiphy work
      wifi: mac80211: move scan work to wiphy work
      wifi: mac80211: move monitor work to wiphy work
      wifi: mac80211: lock wiphy in IP address notifier
      wifi: mac80211: move offchannel works to wiphy work
      wifi: mac80211: move link activation work to wiphy work
      wifi: mac80211: move dynamic PS to wiphy work
      wifi: mac80211: move sched-scan stop work to wiphy work
      wifi: mac80211: move TDLS work to wiphy work
      wifi: mac80211: move key tailroom work to wiphy work
      wifi: mac80211: move tspec work to wiphy work
      wifi: mac80211: move filter reconfig to wiphy work
      wifi: mac80211: move CSA finalize to wiphy work
      wifi: mac80211: move color change finalize to wiphy work
      wifi: mac80211: check wiphy mutex in ops
      wifi: cfg80211: reg: hold wiphy mutex for wdev iteration
      wifi: cfg80211: sme: hold wiphy lock for wdev iteration
      wifi: cfg80211: hold wiphy lock in cfg80211_any_wiphy_oper_chan()
      wifi: cfg80211: check wiphy mutex is held for wdev mutex
      wifi: mac80211: ethtool: hold wiphy mutex
      wifi: mac80211: hold wiphy_lock around concurrency checks
      wifi: mac80211: extend wiphy lock in interface removal
      wifi: mac80211: take wiphy lock for MAC addr change
      wifi: mac80211: remove sta_mtx
      wifi: mac80211: remove key_mtx
      wifi: mac80211: remove chanctx_mtx
      wifi: mac80211: remove ampdu_mlme.mtx
      wifi: mac80211: remove local->mtx
      wifi: mac80211: reduce iflist_mtx
      wifi: mac80211: set wiphy for virtual monitors
      wifi: cfg80211: remove wdev mutex
      wifi: mac80211: fix TXQ error path and cleanup
      wifi: mac80211: fix BA session teardown race
      wifi: cfg80211: annotate iftype_data pointer with sparse
      wifi: mac80211: fix RCU usage warning in mesh fast-xmit
      wifi: cfg80211: fix off-by-one in element defrag
      wifi: cfg80211: add first kunit tests, for element defrag
      wifi: mac80211: add an element parsing unit test
      wifi: mac80211: remove unnecessary struct forward declaration
      wifi: mac80211: fix various kernel-doc issues
      wifi: cfg80211: reg: fix various kernel-doc issues
      wifi: mac80211_hwsim: clean up kernel-doc
      wifi: mac80211: fix # of MSDU in A-MSDU calculation
      wifi: mac80211: take MBSSID/EHT data also from probe resp
      wifi: mac80211: fix channel switch link data
      wifi: iwlwifi: mvm: increase session protection after CSA
      wifi: iwlwifi: mvm: disconnect long CSA only w/o alternative
      wifi: iwlwifi: fix some kernel-doc issues
      wifi: iwlwifi: queue: fix kernel-doc
      wifi: iwlwifi: dvm: remove kernel-doc warnings
      wifi: iwlwifi: pcie: fix kernel-doc issues
      wifi: iwlwifi: mvm: fix kernel-doc
      wifi: iwlwifi: fw: reconstruct the API/CAPA enum number
      wifi: iwlwifi: mvm: move RU alloc B2 placement
      wifi: iwlwifi: mvm: check link more carefully
      wifi: iwlwifi: mvm: reduce maximum RX A-MPDU size
      wifi: iwlwifi: pcie: fix RB status reading
      wifi: iwlwifi: increase number of RX buffers for EHT devices
      wifi: cfg80211: fix kernel-doc for wiphy_delayed_work_flush()
      wifi: cfg80211: remove scan_width support
      wifi: mac80211: remove shifted rate support
      wifi: iwlwifi: pcie: rescan bus if no parent
      wifi: iwlwifi: pcie: give up mem read if HW is dead
      wifi: iwlwifi: pcie: enable TOP fatal error interrupt
      wifi: iwlwifi: mvm: make "pldr_sync" mode effective
      wifi: iwlwifi: update context info structure definitions
      wifi: iwlwifi: mvm: move listen interval to constants
      wifi: cfg80211: fix kernel-doc for wiphy_delayed_work_flush()
      wifi: mac80211: ethtool: always hold wiphy mutex
      wifi: cfg80211: split struct cfg80211_ap_settings
      wifi: mac80211: use bandwidth indication element for CSA
      wifi: mac80211: relax RCU check in for_each_vif_active_link()
      wifi: mac80211: allow for_each_sta_active_link() under RCU
      wifi: cfg80211: reg: describe return values in kernel-doc
      wifi: mac80211: describe return values in kernel-doc
      wifi: mac80211_hwsim: move kernel-doc description
      wifi: mac80211: support antenna control in injection
      wifi: iwlwifi: mvm: iterate active links for STA queues
      wifi: iwlwifi: mvm: handle link-STA allocation in restart
      wifi: iwlwifi: pcie: (re-)assign BAR0 on driver bind
      wifi: iwlwifi: fail NIC access fast on dead NIC
      wifi: iwlwifi: mvm: make pldr_sync AX210 specific
      wifi: iwlwifi: mvm: refactor TX rate handling
      wifi: iwlwifi: mvm: support injection antenna control
      wifi: iwlwifi: mvm: check for iwl_mvm_mld_update_sta() errors
      wifi: cfg80211: add local_state_change to deauth trace
      wifi: mac80211: fix check for unusable RX result
      wifi: mac80211: remove RX_DROP_UNUSABLE
      wifi: mac80211: split ieee80211_drop_unencrypted_mgmt() return value
      wifi: mac80211: expand __ieee80211_data_to_8023() status
      wifi: mac80211: fix ieee80211_drop_unencrypted_mgmt return type/value
      wifi: mac80211: add back SPDX identifier
      wifi: mt76: use atomic iface iteration for pre-TBTT work
      Merge wireless into wireless-next
      wifi: iwlwifi: pcie: propagate iwl_pcie_gen2_apm_init() error
      wifi: iwlwifi: skip opmode start retries on dead transport
      wifi: iwlwifi: fix opmode start/stop race
      wifi: iwlwifi: pcie: clean up WFPM control bits
      wifi: iwlwifi: mvm: offload IGTK in AP if BIGTK is supported
      wifi: iwlwifi: mvm: use correct sta ID for IGTK/BIGTK
      wifi: mac80211: don't recreate driver link debugfs in reconfig
      wifi: cfg80211: wext: convert return value to kernel-doc
      wifi: mac80211: flush STA queues on unauthorization
      wifi: iwlwifi: mvm: rework debugfs handling
      wifi: iwlwifi: mvm: fix SB CFG check
      wifi: iwlwifi: mei: return error from register when not built
      wifi: mac80211: fix change_address deadlock during unregister
      wifi: iwlwifi: mvm: change iwl_mvm_flush_sta() API
      wifi: iwlwifi: mvm: fix iwl_mvm_mac_flush_sta()
      wifi: iwlwifi: mvm: remove TDLS stations from FW
      wifi: mac80211: fix another key installation error path
      wifi: iwlwifi: api: fix center_freq label in PHY diagram
      wifi: iwlwifi: mvm: remove set_tim callback for MLD ops
      wifi: iwlwifi: mvm: fix netif csum flags
      wifi: iwlwifi: pcie: synchronize IRQs before NAPI
      wifi: iwlwifi: trace full frames with TX status request
      wifi: iwlwifi: mvm: cycle FW link on chanctx removal
      wifi: iwlwifi: mvm: show dump even for pldr_sync
      wifi: mac80211: drop robust action frames before assoc

Johannes Nixdorf (5):
      net: bridge: Set BR_FDB_ADDED_BY_USER early in fdb_add_entry
      net: bridge: Track and limit dynamically learned FDB entries
      net: bridge: Add netlink knobs for number / max learned FDB entries
      net: bridge: Set strict_start_type for br_policy
      selftests: forwarding: bridge_fdb_learning_limit: Add a new selftest

Johannes Zink (6):
      net: stmmac: fix typo in comment
      net: stmmac: simplify debug message on stmmac_enable()
      net: stmmac: use correct PPS capture input index
      net: stmmac: intel: remove unnecessary field struct plat_stmmacenet_data::ext_snapshot_num
      net: stmmac: ptp: stmmac_enable(): move change of plat->flags into mutex
      net: stmmac: do not silently change auxiliary snapshot capture channel

Joshua Hay (5):
      idpf: add controlq init and reset checks
      idpf: add splitq start_xmit
      idpf: add TX splitq napi poll support
      idpf: add singleq start_xmit and napi poll
      idpf: add SRIOV support and other ndo_ops

Justin Stitt (48):
      can: peak_pci: replace deprecated strncpy with strscpy
      net: ax88796c: replace deprecated strncpy with strscpy
      net: atheros: replace deprecated strncpy with strscpy
      bcm63xx_enet: replace deprecated strncpy with strscpy
      liquidio: replace deprecated strncpy/strcpy with strscpy
      net: liquidio: replace deprecated strncpy with strscpy_pad
      liquidio: replace deprecated strncpy with strscpy
      cavium/liquidio: replace deprecated strncpy with strscpy
      net: dsa: qca8k: replace deprecated strncpy with ethtool_sprintf
      net: dsa: realtek: replace deprecated strncpy with ethtool_sprintf
      net: dsa: realtek: rtl8365mb: replace deprecated strncpy with ethtool_sprintf
      octeontx2-af: replace deprecated strncpy with strscpy
      net: mvpp2: replace deprecated strncpy with strscpy
      net: dsa: mt7530: replace deprecated strncpy with ethtool_sprintf
      net: dsa: lantiq_gswip: replace deprecated strncpy with ethtool_sprintf
      bna: replace deprecated strncpy with strscpy_pad
      net: fec: replace deprecated strncpy with ethtool_sprintf
      ibmvnic: replace deprecated strncpy with strscpy
      net: dsa: vsc73xx: replace deprecated strncpy with ethtool_sprintf
      nfp: replace deprecated strncpy with strscpy
      net/mlx4_core: replace deprecated strncpy with strscpy
      net: sparx5: replace deprecated strncpy with ethtool_sprintf
      ionic: replace deprecated strncpy with strscpy
      net: phy: tja11xx: replace deprecated strncpy with ethtool_sprintf
      sfc: replace deprecated strncpy with strscpy
      qed: replace uses of strncpy
      net: netcp: replace deprecated strncpy with strscpy
      net: phy: smsc: replace deprecated strncpy with ethtool_sprintf
      lan78xx: replace deprecated strncpy with strscpy
      net: usb: replace deprecated strncpy with strscpy
      hamradio: replace deprecated strncpy with strscpy_pad
      wifi: ath5k: replace deprecated strncpy with strscpy
      wifi: ath6kl: replace deprecated strncpy with memcpy
      e100: replace deprecated strncpy with strscpy
      e1000: replace deprecated strncpy with strscpy
      fm10k: replace deprecated strncpy with strscpy
      i40e: use scnprintf over strncpy+strncat
      igb: replace deprecated strncpy with strscpy
      igbvf: replace deprecated strncpy with strscpy
      igc: replace deprecated strncpy with strscpy
      net: wwan: replace deprecated strncpy with strscpy
      wifi: ipw2x00: replace deprecated strncpy with strscpy_pad
      wifi: wl1251: replace deprecated strncpy with strscpy
      wifi: wl18xx: replace deprecated strncpy with strscpy
      wifi: wlcore: boot: replace deprecated strncpy with strscpy
      wifi: wlcore: main: replace deprecated strncpy with strscpy
      s390/ctcm: replace deprecated strncpy with strscpy
      s390/qeth: replace deprecated strncpy with strscpy

Jérôme Pouiller (8):
      wifi: wfx: fix power_save setting when AP is stopped
      wifi: wfx: relocate wfx_rate_mask_to_hw()
      wifi: wfx: move wfx_skb_*() out of the header file
      wifi: wfx: introduce hif_scan_uniq()
      wifi: wfx: simplify exclusion between scan and Rx filters
      wifi: wfx: scan_lock is global to the device
      wifi: wfx: allow to send frames during ROC
      wifi: wfx: implement wfx_remain_on_channel()

Kalesh AP (8):
      bnxt_en: Enhance hwmon temperature reporting
      bnxt_en: Move hwmon functions into a dedicated file
      bnxt_en: Modify the driver to use hwmon_device_register_with_info
      bnxt_en: Expose threshold temperatures through hwmon
      bnxt_en: Use non-standard attribute to expose shutdown temperature
      bnxt_en: Event handler for Thermal event
      bnxt_en: Do not call sleeping hwmon_notify_event() from NAPI
      bnxt_en: Fix invoking hwmon_notify_event

Kalle Valo (14):
      wifi: ath11k: mac: fix struct ieee80211_sband_iftype_data handling
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
      wifi: ath12k: fix debug messages
      Merge tag 'mt76-for-kvalo-2023-09-30' of https://github.com/nbd168/wireless
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
      wifi: ath11k: ath11k_debugfs_register(): fix format-truncation warning
      wifi: mac80211: rename ieee80211_tx_status() to ieee80211_tx_status_skb()
      wifi: mac80211: rename struct cfg80211_rx_assoc_resp to cfg80211_rx_assoc_resp_data
      wifi: brcmfmac: fix format-truncation warnings
      wifi: ipw2x00: fix format-truncation warnings
      wifi: ath9k_htc: fix format-truncation warning
      wifi: ath11k: qmi: refactor ath11k_qmi_m3_load()
      Revert "wifi: ath11k: call ath11k_mac_fils_discovery() without condition"
      Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

Kang Yang (1):
      wifi: ath12k: add msdu_end structure for WCN7850

Karol Kolacinski (4):
      ice: retry acquiring hardware semaphore during cross-timestamp request
      ice: PTP: Clean up timestamp registers correctly
      ice: PTP: Rename macros used for PHY/QUAD port definitions
      ice: PTP: move quad value check inside ice_fill_phy_msg_e822

Karthikeyan Periyasamy (4):
      wifi: ath11k: rename the wmi_sc naming convention to wmi_ab
      wifi: ath11k: rename the sc naming convention to ab
      wifi: ath12k: rename the wmi_sc naming convention to wmi_ab
      wifi: ath12k: rename the sc naming convention to ab

Kees Cook (42):
      ceph: Annotate struct ceph_monmap with __counted_by
      wifi: brcmfmac: Annotate struct brcmf_gscan_config with __counted_by
      wifi: brcmfmac: firmware: Annotate struct brcmf_fw_request with __counted_by
      wifi: ipw2x00: Annotate struct libipw_txb with __counted_by
      wifi: wcn36xx: Annotate struct wcn36xx_hal_ind_msg with __counted_by
      wifi: ath10k: Annotate struct ath10k_ce_ring with __counted_by
      wifi: mt76: Annotate struct mt76_rx_tid with __counted_by
      ipv4: Annotate struct fib_info with __counted_by
      ipv4/igmp: Annotate struct ip_sf_socklist with __counted_by
      ipv6: Annotate struct ip6_sf_socklist with __counted_by
      net: hns: Annotate struct ppe_common_cb with __counted_by
      net: enetc: Annotate struct enetc_int_vector with __counted_by
      net: hisilicon: Annotate struct rcb_common_cb with __counted_by
      net: mana: Annotate struct mana_rxq with __counted_by
      net: ipa: Annotate struct ipa_power with __counted_by
      net: mana: Annotate struct hwc_dma_buf with __counted_by
      net: openvswitch: Annotate struct dp_meter_instance with __counted_by
      net: enetc: Annotate struct enetc_psfp_gate with __counted_by
      net: openvswitch: Annotate struct dp_meter with __counted_by
      net: tulip: Annotate struct mediatable with __counted_by
      mlxsw: Annotate struct mlxsw_linecards with __counted_by
      mlxsw: core: Annotate struct mlxsw_env with __counted_by
      mlxsw: spectrum: Annotate struct mlxsw_sp_counter_pool with __counted_by
      mlxsw: spectrum_router: Annotate struct mlxsw_sp_nexthop_group_info with __counted_by
      mlxsw: spectrum_span: Annotate struct mlxsw_sp_span with __counted_by
      chelsio/l2t: Annotate struct l2t_data with __counted_by
      cxgb4: Annotate struct clip_tbl with __counted_by
      cxgb4: Annotate struct cxgb4_tc_u32_table with __counted_by
      cxgb4: Annotate struct sched_table with __counted_by
      cxgb4: Annotate struct smt_data with __counted_by
      nexthop: Annotate struct nh_res_table with __counted_by
      nexthop: Annotate struct nh_notifier_res_table_info with __counted_by
      netem: Annotate struct disttable with __counted_by
      nfp: Annotate struct nfp_reprs with __counted_by
      nfp: nsp: Annotate struct nfp_eth_table with __counted_by
      netlink: Annotate struct netlink_policy_dump_state with __counted_by
      nexthop: Annotate struct nh_notifier_grp_info with __counted_by
      nexthop: Annotate struct nh_group with __counted_by
      net/packet: Annotate struct packet_fanout with __counted_by
      flow_offload: Annotate struct flow_action_entry with __counted_by
      bpf: Annotate struct bpf_stack_map with __counted_by
      wifi: p54: Annotate struct p54_cal_database with __counted_by

Keguang Zhang (3):
      dt-bindings: mfd: syscon: Add compatibles for Loongson-1 syscon
      dt-bindings: net: Add Loongson-1 Ethernet Controller
      net: stmmac: Add glue layer for Loongson-1 SoC

Konstantin Taranov (1):
      net: mana: Use xdp_set_features_flag instead of direct assignment

Kuan-Chung Chen (2):
      wifi: rtw89: 8852c: Update bandedge parameters for better performance
      wifi: rtw89: 8852c: Fix TSSI causes transmit power inaccuracy

Kumar Kartikeya Dwivedi (21):
      bpf: Use bpf_is_subprog to check for subprogs
      arch/x86: Implement arch_bpf_stack_walk
      bpf: Implement support for adding hidden subprogs
      bpf: Implement BPF exceptions
      bpf: Refactor check_btf_func and split into two phases
      bpf: Add support for custom exception callbacks
      bpf: Perform CFG walk for exception callback
      bpf: Treat first argument as return value for bpf_throw
      mm: kasan: Declare kasan_unpoison_task_stack_below in kasan.h
      bpf: Prevent KASAN false positive with bpf_throw
      bpf: Detect IP == ksym.end as part of BPF program
      bpf: Disallow fentry/fexit/freplace for exception callbacks
      bpf: Fix kfunc callback register type handling
      libbpf: Refactor bpf_object__reloc_code
      libbpf: Add support for custom exception callbacks
      selftests/bpf: Add BPF assertion macros
      selftests/bpf: Add tests for BPF exceptions
      selftests/bpf: Print log buffer for exceptions test only on failure
      bpf: Fix bpf_throw warning on 32-bit arch
      bpf: Disable exceptions when CONFIG_UNWINDER_FRAME_POINTER=y
      selftests/bpf: Make linked_list failure test more robust

Kuniyuki Iwashima (1):
      af_unix: Remove module remnants.

Larysa Zaremba (2):
      bpf: Allow to use kfunc XDP hints and frags together
      selftests/bpf: Add options and frags to xdp_hw_metadata

Leon Hwang (4):
      selftests/bpf: Correct map_fd to data_fd in tailcalls
      bpf, x64: Comment tail_call_cnt initialisation
      bpf, x64: Fix tailcall infinite loop
      selftests/bpf: Add testcases for tailcall infinite loop fixing

Leon Romanovsky (2):
      Merge branch 'mlx5-vfio' into mlx5-next
      net/mlx5e: Allow IPsec soft/hard limits in bytes

Liang Chen (2):
      pktgen: Automate flag enumeration for unknown flag handling
      pktgen: Introducing 'SHARED' flag for testing with non-shared skb

Liansen Zhai (1):
      cgroup, netclassid: on modifying netclassid in cgroup, only consider the main process.

Lingbo Kong (1):
      wifi: ath12k: add support for hardware rfkill for WCN7850

Linus Walleij (11):
      net: dsa: rtl8366rb: Implement setting up link on CPU port
      net: ixp4xx_eth: Specify min/max MTU
      net: phy: amd: Support the Altima AMI101L
      net: ixp4xx_eth: Support changing the MTU
      dt-bindings: net: dsa: Require ports or ethernet-ports
      dt-bindings: net: mvusb: Fix up DSA example
      ARM: dts: marvell: Fix some common switch mistakes
      ARM: dts: nxp: Fix some common switch mistakes
      ARM64: dts: marvell: Fix some common switch mistakes
      dt-bindings: marvell: Rewrite MV88E6xxx in schema
      dt-bindings: marvell: Add Marvell MV88E6060 DSA schema

Liu Jian (1):
      net: sched: sch_qfq: Use non-work-conserving warning handler

Lorenzo Bianconi (19):
      net: ethernet: mtk_eth_soc: rely on mtk_pse_port definitions in mtk_flow_set_output_device
      net: ethernet: mtk_wed: check update_wo_rx_stats in mtk_wed_update_rx_stats()
      net: ethernet: mtk_wed: do not assume offload callbacks are always set
      dt-bindings: soc: mediatek: mt7986-wo-ccif: add binding for MT7988 SoC
      dt-bindings: arm: mediatek: mt7622-wed: add WED binding for MT7988 SoC
      net: ethernet: mtk_wed: introduce versioning utility routines
      net: ethernet: mtk_wed: do not configure rx offload if not supported
      net: ethernet: mtk_wed: rename mtk_rxbm_desc in mtk_wed_bm_desc
      net: ethernet: mtk_wed: introduce mtk_wed_buf structure
      net: ethernet: mtk_wed: move mem_region array out of mtk_wed_mcu_load_firmware
      net: ethernet: mtk_wed: make memory region optional
      net: ethernet: mtk_wed: fix EXT_INT_STATUS_RX_FBUF definitions for MT7986 SoC
      net: ethernet: mtk_wed: add mtk_wed_soc_data structure
      net: ethernet: mtk_wed: refactor mtk_wed_check_wfdma_rx_fill routine
      net: ethernet: mtk_wed: debugfs: move wed_v2 specific regs out of regs array
      wifi: mt76: mt792x: move mt7921_skb_add_usb_sdio_hdr in mt792x module
      wifi: mt76: mt792x: move some common usb code in mt792x module
      net: ethernet: mtk_wed: fix firmware loading for MT7986 SoC
      net: ethernet: mtk_wed: remove wo pointer in wo_r32/wo_w32 signature

Luca Fancellu (1):
      xen-netback: add software timestamp capabilities

Lukas Bulwahn (3):
      MAINTAINERS: adjust header file entry in DPLL SUBSYSTEM
      appletalk: remove special handling code for ipddp
      net/mlx5: fix config name in Kconfig parameter documentation

Lukasz Majewski (2):
      net: dsa: tag_ksz: Extend ksz9477_xmit() for HSR frame duplication
      net: dsa: microchip: Enable HSR offloading for KSZ9477

MD Danish Anwar (4):
      dt-bindings: net: Add compatible for AM64x in ICSSG
      net: ti: icssg-prueth: Add AM64x icssg support
      dt-bindings: net: Add documentation for Half duplex support.
      net: ti: icssg-prueth: Add support for half duplex operation

Ma Ke (1):
      wifi: ath12k: mhi: fix potential memory leak in ath12k_mhi_register()

Magnus Karlsson (10):
      selftests/xsk: print per packet info in verbose mode
      selftests/xsk: add timeout for Tx thread
      selftests/xsk: add option to only run tests in a single mode
      selftests/xsk: move all tests to separate functions
      selftests/xsk: declare test names in struct
      selftests/xsk: add option that lists all tests
      selftests/xsk: add option to run single test
      selftests/xsk: use ksft_print_msg uniformly
      selftests/xsk: fail single test instead of all tests
      selftests/xsk: display command line options with -h

Manish Dharanenthiran (2):
      wifi: ath12k: fix WARN_ON during ath12k_mac_update_vif_chan
      wifi: ath12k: fix radar detection in 160 MHz

Manu Bretelle (2):
      bpftool: Fix printing of pointer value
      bpftool: Wrap struct_ops dump in an array

Marc Kleine-Budde (35):
      Merge patch series "can: etas_es58x: clean-up of new GCC W=1 and old checkpatch warnings"
      can: dev: can_restart(): don't crash kernel if carrier is OK
      can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()
      can: dev: can_restart(): reverse logic to remove need for goto
      can: dev: can_restart(): move debug message and stats after successful restart
      can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds
      Merge patch series "can: dev: fix can_restart() and replace BUG_ON() by error handling"
      can: dev: add can_state_get_by_berr_counter() to return the CAN state based on the current error counters
      can: at91_can: use a consistent indention
      can: at91_can: at91_irq_tx(): remove one level of indention
      can: at91_can: BR register: convert to FIELD_PREP()
      can: at91_can: ECR register: convert to FIELD_GET()
      can: at91_can: MMR registers: convert to FIELD_PREP()
      can: at91_can: MID registers: convert access to FIELD_PREP(), FIELD_GET()
      can: at91_can: MSR Register: convert to FIELD_PREP()
      can: at91_can: MCR Register: convert to FIELD_PREP()
      can: at91_can: add more register definitions
      can: at91_can: at91_setup_mailboxes(): update comments
      can: at91_can: rename struct at91_priv::{tx_next,tx_echo} to {tx_head,tx_tail}
      can: at91_can: at91_set_bittiming(): demote register output to debug level
      can: at91_can: at91_chip_start(): don't disable IRQs twice
      can: at91_can: at91_open(): forward request_irq()'s return value in case or an error
      can: at91_can: add CAN transceiver support
      can: at91_can: at91_poll_err(): fold in at91_poll_err_frame()
      can: at91_can: at91_poll_err(): increase stats even if no quota left or OOM
      can: at91_can: at91_irq_err_frame(): call directly from IRQ handler
      can: at91_can: at91_irq_err_frame(): move next to at91_irq_err()
      can: at91_can: at91_irq_err(): rename to at91_irq_err_line()
      can: at91_can: at91_irq_err_line(): make use of can_state_get_by_berr_counter()
      can: at91_can: at91_irq_err_line(): take reg_sr into account for bus off
      can: at91_can: at91_irq_err_line(): make use of can_change_state() and can_bus_off()
      can: at91_can: at91_irq_err_line(): send error counters with state change
      can: at91_can: at91_alloc_can_err_skb() introduce new function
      can: at91_can: switch to rx-offload implementation
      Merge patch series "can: at91: add can_state_get_by_berr_counter() helper, cleanup and convert to rx_offload"

Marcel Ziswiler (1):
      Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err

Martin KaFai Lau (5):
      Merge branch 'bpf: expose information about netdev xdp-metadata kfunc support'
      Merge branch 'bpf: Fix src IP addr related limitation in bpf_*_fib_lookup()'
      Merge branch 'Add cgroup sockaddr hooks for unix sockets'
      net/bpf: Avoid unused "sin_addr_len" warning when CONFIG_CGROUP_BPF is not set
      Merge branch 'Add bpf programmable net device'

Martin Kelly (14):
      libbpf: Refactor cleanup in ring_buffer__add
      libbpf: Switch rings to array of pointers
      libbpf: Add ring_buffer__ring
      selftests/bpf: Add tests for ring_buffer__ring
      libbpf: Add ring__producer_pos, ring__consumer_pos
      selftests/bpf: Add tests for ring__*_pos
      libbpf: Add ring__avail_data_size
      selftests/bpf: Add tests for ring__avail_data_size
      libbpf: Add ring__size
      selftests/bpf: Add tests for ring__size
      libbpf: Add ring__map_fd
      selftests/bpf: Add tests for ring__map_fd
      libbpf: Add ring__consume
      selftests/bpf: Add tests for ring__consume

Martynas Pumputis (2):
      bpf: Derive source IP addr via bpf_*_fib_lookup()
      selftests/bpf: Add BPF_FIB_LOOKUP_SRC tests

Masum Reza (1):
      Bluetooth: btusb: Add RTW8852BE device 13d3:3570 to device tables

Matt Chen (1):
      wifi: iwlmvm: fw: Add new OEM vendor to tas approved list

Matt Johnston (2):
      dt-bindings: i3c: Add mctp-controller property
      mctp i3c: MCTP I3C driver

MeiChia Chiu (2):
      wifi: mt76: update beacon size limitation
      wifi: mt76: mt7915: fix beamforming availability check

Michael Chan (3):
      bnxt_en: Update firmware interface to 1.10.2.171
      bnxt_en: Refactor NRZ/PAM4 link speed related logic
      bnxt_en: Fix 2 stray ethtool -S counters

Michal Kubiak (1):
      idpf: set scheduling mode for completion queue

Michal Michalik (4):
      ice: Auxbus devices & driver for E822 TS
      ice: Use PTP auxbus for all PHYs restart in E822
      ice: PTP: add clock domain number to auxiliary interface
      ice: Remove the FW shared parameters

Michal Schmidt (9):
      iavf: delete unused iavf_mac_info fields
      iavf: fix comments about old bit locks
      iavf: simplify mutex_trylock+sleep loops
      iavf: in iavf_down, don't queue watchdog_task if comms failed
      iavf: fix the waiting time for initial reset
      iavf: rely on netdev's own registered state
      iavf: use unregister_netdev
      iavf: add a common function for undoing the interrupt scheme
      iavf: delete the iavf client interface

Michal Swiatkowski (5):
      ice: add drop rule matching on not active lport
      ice: implement num_msix field per VF
      ice: add bitmap to track VF MSI-X usage
      ice: set MSI-X vector count on VF
      ice: manage VFs MSI-X using resource tracking

Ming Yen Hsieh (5):
      wifi: mt76: mt7921: enable set txpower for UNII-4
      wifi: mt76: mt7921: add 6GHz power type support for clc
      wifi: mt76: mt7921: get regulatory information from the clc event
      wifi: mt76: mt7921: update the channel usage when the regd domain changed
      wifi: mt76: mt7921: fix kernel panic by accessing invalid 6GHz channel info

Miquel Raynal (1):
      can: sja1000: Fix comment

Miri Korenblit (21):
      wifi: iwlwifi: don't use an uninitialized variable
      wifi: iwlwifi: remove dead-code
      wifi: iwlwifi: Use FW rate for non-data frames
      wifi: iwlwifi: no power save during transition to D3
      wifi: mac80211: add a driver callback to add vif debugfs
      wifi: mac80211: handle debugfs when switching to/from MLO
      wifi: mac80211: make mgd_protect_tdls_discover MLO-aware
      wifi: mac80211: purge TX queues in flush_queues flow
      wifi: mac80211: Check if we had first beacon with relevant links
      wifi: mac80211: add link id to mgd_prepare_tx()
      wifi: iwlwifi: Extract common prph mac/phy regions data dump logic
      wifi: iwlwifi: add support for new ini region types
      wifi: iwlwifi: mvm: add a per-link debugfs
      wifi: iwlwifi: abort scan when rfkill on but device enabled
      wifi: iwlwifi: mvm: cleanup MLO and non-MLO unification code
      wifi: iwlwifi: add support for activating UNII-1 in WW via BIOS
      wifi: iwlwifi: make time_events MLO aware
      wifi: iwlwifi: support link_id in SESSION_PROTECTION cmd
      wifi: iwlwifi: support link id in SESSION_PROTECTION_NOTIF
      wifi: iwlwifi: mvm: add a print when sending RLC command
      wifi: iwlwifi: empty overflow queue during flush

Moshe Shemesh (1):
      net/mlx5: Add a health error syndrome for pci data poisoned

Muhammad Muzammil (2):
      drivers: net: wwan: wwan_core.c: resolved spelling mistake
      drivers: net: wwan: iosm: Fixed multiple typos in multiple files

Mukesh Sisodiya (5):
      wifi: iwlwifi: add mapping of a periphery register crf for WH RF
      wifi: iwlwifi: fw: Fix debugfs command sending
      wifi: iwlwifi: fix the rf step and flavor bits range
      wifi: iwlwifi: add new RF support for wifi7
      wifi: iwlwifi: fw: Add support for UATS table in UHB

Muna Sinada (2):
      wifi: ath11k: move references from rsvd2 to info fields
      wifi: ath11k: fix tid bitmap is 0 in peer rx mu stats

Nathan Chancellor (2):
      ptp: Fix type of mode parameter in ptp_ocp_dpll_mode_get()
      mlx5: Fix type of mode parameter in mlx5_dpll_device_mode_get()

Nikolay Aleksandrov (2):
      netkit: Remove explicit active/peer ptr initialization
      net: bridge: fill in MODULE_DESCRIPTION()

Norbert Zulinski (1):
      iavf: Add ability to turn off CRC stripping for VF

Oleg Nesterov (5):
      bpf: task_group_seq_get_next: cleanup the usage of next_thread()
      bpf: task_group_seq_get_next: cleanup the usage of get/put_task_struct
      bpf: task_group_seq_get_next: fix the skip_if_dup_files check
      bpf: task_group_seq_get_next: kill next_task
      bpf: task_group_seq_get_next: simplify the "next tid" logic

Oleksij Rempel (16):
      dt-bindings: net: dsa: microchip: Update ksz device tree bindings for drive strength
      net: dsa: microchip: Add drive strength configuration
      net: dsa: microchip: Move *_port_setup code to dsa_switch_ops::port_setup()
      net: dsa: microchip: Add partial ACL support for ksz9477 switches
      net: dsa: microchip: Fix uninitialized var in ksz9477_acl_move_entries()
      net: dsa: microchip: ksz8: Enable MIIM PHY Control reg access
      net: phy: micrel: Fix forced link mode for KSZ886X switches
      net: dsa: microchip: Add missing MAC address register offset for ksz8863
      dt-bindings: net: dsa: microchip: add wakeup-source property
      net: dsa: microchip: use wakeup-source DT property to enable PME output
      net: dsa: microchip: ksz9477: add Wake on LAN support
      net: dsa: microchip: ksz9477: Add Wake on Magic Packet support
      net: dsa: microchip: Refactor comment for ksz_switch_macaddr_get() function
      net: dsa: microchip: Add error handling for ksz_switch_macaddr_get()
      net: dsa: microchip: Refactor switch shutdown routine for WoL preparation
      net: dsa: microchip: Ensure Stable PME Pin State for Wake-on-LAN

Pablo Neira Ayuso (6):
      netfilter: nf_tables: missing extended netlink error in lookup functions
      netfilter: nft_set_pipapo: no need to call pipapo_deactivate() from flush
      netfilter: nf_tables: set backend .flush always succeeds
      netfilter: nf_tables: expose opaque set element as struct nft_elem_priv
      netfilter: nf_tables: shrink memory consumption of set elements
      netfilter: nf_tables: set->ops->insert returns opaque set element in case of EEXIST

Paolo Abeni (28):
      Merge branch 'add-support-for-icssg-on-am64x-evm'
      Merge branch 'tcp-backlog-processing-optims'
      Merge branch 'vsock-handle-writes-to-shutdowned-socket'
      Merge branch 'udp-round-of-data-races-fixes'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'add-wed-support-for-mt7988-chipset'
      Merge branch 'vsock-virtio-vhost-msg_zerocopy-preparations'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'selftests-tc-testing-parallel-tdc'
      Merge tag 'mlx5-updates-2023-09-19' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch 'tcp_metrics-four-fixes'
      Merge branch 'net-dsa-hsr-enable-hsr-hw-offloading-for-ksz9477'
      Merge branch 'tcp-save-flowlabel-and-use-for-receiver-repathing'
      Merge branch 'mlxsw-fix-wformat-truncation-warnings'
      Merge branch 'i3c-mctp-net-driver'
      Merge branch 'rswitch-add-pm-ops'
      Merge branch 'net-stmmac-use-correct-pps-input-indexing'
      Merge branch 'net-stmmac-improve-tx-timer-logic'
      mptcp: add a new sysctl for make after break timeout
      mptcp: properly account fastopen data
      mptcp: use plain bool instead of custom binary enum
      tcp: define initial scaling factor value as a macro
      mptcp: give rcvlowat some love
      mptcp: use copy_from_iter helpers on transmit
      mptcp: consolidate sockopt synchronization
      mptcp: ignore notsent_lowat setting at the subflow level
      mptcp: refactor sndbuf auto-tuning
      Merge tag 'nf-next-23-10-25' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next

Patrick Rohr (1):
      net: add sysctl to disable rfc4862 5.5.3e lifetime handling

Patrisious Haddad (9):
      RDMA/mlx5: Send events from IB driver about device affiliation state
      net/mlx5: Register mlx5e priv to devcom in MPV mode
      net/mlx5: Store devcom pointer inside IPsec RoCE
      net/mlx5: Add alias flow table bits
      net/mlx5: Implement alias object allow and create functions
      net/mlx5: Add create alias flow table function to ipsec roce
      net/mlx5: Configure IPsec steering for egress RoCEv2 MPV traffic
      net/mlx5: Configure IPsec steering for ingress RoCEv2 MPV traffic
      net/mlx5: Handle IPsec steering upon master unbind/bind

Paul E. McKenney (1):
      bpf: Fold smp_mb__before_atomic() into atomic_set_release()

Paul Greenwalt (4):
      ethtool: Add forced speed to supported link modes maps
      qede: Refactor qede_forced_speed_maps_init()
      ice: Add E830 device IDs, MAC type and registers
      ice: Add ice_get_link_status_datalen

Paul M Stillwell Jr (1):
      virtchnl: Add CRC stripping capability

Pavan Chebbi (1):
      tg3: Improve PTP TX timestamping logic

Pavan Kumar Linga (6):
      virtchnl: add virtchnl version 2 ops
      idpf: add core init and interrupt request
      idpf: add create vport and netdev configuration
      idpf: add ptypes and MAC filter support
      idpf: initialize interrupts and enable vport
      idpf: cancel mailbox work in error path

Pavithra Sathyanarayanan (1):
      net: microchip: lan743x: add fixed phy unregister support

Pawel Chmielewski (3):
      ice: Refactor finding advertised link speed
      ice: Remove redundant zeroing of the fields.
      ice: Hook up 4 E830 devices by adding their IDs

Pedro Tammela (11):
      selftests/tc-testing: cls_fw: add tests for classid
      selftests/tc-testing: cls_route: add tests for classid
      selftests/tc-testing: cls_u32: add tests for classid
      net/sched: cls_route: make netlink errors meaningful
      selftests/tc-testing: localize test resources
      selftests/tc-testing: update test definitions for local resources
      selftests/tc-testing: implement tdc parallel test run
      selftests/tc-testing: update tdc documentation
      selftests: tc-testing: add missing Kconfig options to 'config'
      selftests: tc-testing: move auxiliary scripts to a dedicated folder
      selftests: tc-testing: add test for 'rt' upgrade on hfsc

Peter Chiu (6):
      wifi: mt76: mt7996: set correct wcid in txp
      wifi: mt76: mt7996: fix wmm queue mapping
      wifi: mt76: mt7996: fix rx rate report for CBW320-2
      wifi: mt76: mt7996: fix TWT command format
      wifi: mt76: check vif type before reporting cca and csa
      wifi: mt76: mt7915: update mpdu density capability

Peter Lafreniere (1):
      hamradio: baycom: remove useless link in Kconfig

Petr Machata (11):
      mlxsw: reg: Drop SGCR.llb
      mlxsw: reg: Add SGCR.lag_lookup_pgt_base
      mlxsw: cmd: Fix omissions in CONFIG_PROFILE field names in comments
      mlxsw: cmd: Add CONFIG_PROFILE.{set_, }lag_mode
      mlxsw: cmd: Add QUERY_FW.lag_mode_support
      mlxsw: core, pci: Add plumbing related to LAG mode
      mlxsw: pci: Permit toggling LAG mode
      mlxsw: spectrum_fid: Allocate PGT for the whole FID family in one go
      mlxsw: spectrum_pgt: Generalize PGT allocation
      mlxsw: spectrum: Allocate LAG table when in SW LAG mode
      mlxsw: spectrum: Set SW LAG mode on Spectrum>1

Phani Burra (1):
      idpf: add module register and probe functionality

Phil Sutter (17):
      netfilter: nf_tables: Utilize NLA_POLICY_NESTED_ARRAY
      netfilter: nf_tables: Always allocate nft_rule_dump_ctx
      netfilter: nf_tables: Drop pointless memset when dumping rules
      netfilter: nf_tables: Carry reset flag in nft_rule_dump_ctx
      netfilter: nf_tables: Carry s_idx in nft_rule_dump_ctx
      netfilter: nf_tables: Don't allocate nft_rule_dump_ctx
      net: skb_find_text: Ignore patterns extending past 'to'
      netfilter: nf_tables: Open-code audit log call in nf_tables_getrule()
      netfilter: nf_tables: Introduce nf_tables_getrule_single()
      netfilter: nf_tables: Add locking for NFT_MSG_GETRULE_RESET requests
      netfilter: nf_tables: Drop pointless memset in nf_tables_dump_obj
      netfilter: nf_tables: Unconditionally allocate nft_obj_filter
      netfilter: nf_tables: A better name for nft_obj_filter
      netfilter: nf_tables: Carry s_idx in nft_obj_dump_ctx
      netfilter: nf_tables: nft_obj_filter fits into cb->ctx
      netfilter: nf_tables: Carry reset boolean in nft_obj_dump_ctx
      netfilter: nf_tables: Carry reset boolean in nft_set_dump_ctx

Ping-Ke Shih (26):
      wifi: rtw89: fw: move polling function of firmware path ready to an individual function
      wifi: rtw89: fw: generalize download firmware flow by mac_gen pointers
      wifi: rtw89: fw: implement supported functions of download firmware for WiFi 7 chips
      wifi: rtw89: fw: add checking type for variant type of firmware
      wifi: rtw89: fw: propagate an argument include_bb for BB MCU firmware
      wifi: rtw89: 8922a: add chip_ops::bb_preinit to enable BB before downloading firmware
      wifi: rtw89: fw: refine download flow to support variant firmware suits
      wifi: rtw89: 8922a: set memory heap address for secure firmware
      wifi: mac80211: don't return unset power in ieee80211_get_tx_power()
      wifi: rtw89: add to query RX descriptor format v2
      wifi: rtw89: add to fill TX descriptor for firmware command v2
      wifi: rtw89: add to fill TX descriptor v2
      wifi: rtw89: add chip_info::txwd_info size to generalize TX WD submit
      wifi: rtw89: consolidate registers of mac port to struct
      wifi: rtw89: add mac_gen pointer to access mac port registers
      wifi: rtw89: add subband index of primary channel to struct rtw89_chan
      wifi: radiotap: add bandwidth definition of EHT U-SIG
      wifi: rtw89: parse EHT information from RX descriptor and PPDU status packet
      wifi: rtw89: Add EHT rate mask as parameters of RA H2C command
      wifi: rtw89: parse TX EHT rate selected by firmware from RA C2H report
      wifi: rtw89: show EHT rate in debugfs
      wifi: rtw89: add EHT radiotap in monitor mode
      wifi: rtw89: coex: add annotation __counted_by() for struct rtw89_btc_btf_set_slot_table
      wifi: rtw89: coex: add annotation __counted_by() to struct rtw89_btc_btf_set_mon_reg
      wifi: rtw89: mac: add registers of MU-EDCA parameters for WiFi 7 chips
      wifi: rtw89: phy: generalize valid bit of BSS color

Po-Hao Huang (4):
      wifi: rtw88: fix typo rtw8822cu_probe
      wifi: ieee80211: add UL-bandwidth definition of trigger frame
      wifi: rtw89: refine uplink trigger based control mechanism
      wifi: rtw89: refine bandwidth 160MHz uplink OFDMA performance

Prasurjya Rohan Saikia (1):
      wifi: wilc1000: add back-off algorithm to balance tx queue packets

Przemek Kitszel (21):
      overflow: add DEFINE_FLEX() for on-stack allocs
      ice: ice_sched_remove_elems: replace 1 elem array param by u32
      ice: drop two params of ice_aq_move_sched_elems()
      ice: make use of DEFINE_FLEX() in ice_ddp.c
      ice: make use of DEFINE_FLEX() for struct ice_aqc_add_tx_qgrp
      ice: make use of DEFINE_FLEX() for struct ice_aqc_dis_txq_item
      ice: make use of DEFINE_FLEX() in ice_switch.c
      devlink: retain error in struct devlink_fmsg
      netdevsim: devlink health: use retained error fmsg API
      pds_core: devlink health: use retained error fmsg API
      bnxt_en: devlink health: use retained error fmsg API
      hinic: devlink health: use retained error fmsg API
      octeontx2-af: devlink health: use retained error fmsg API
      mlxsw: core: devlink health: use retained error fmsg API
      net/mlx5: devlink health: use retained error fmsg API
      qed: devlink health: use retained error fmsg API
      staging: qlge: devlink health: use retained error fmsg API
      devlink: convert most of devlink_fmsg_*() to return void
      ice: remove unused ice_flow_entry fields
      ice: store VF's pci_dev ptr in ice_vf
      net/mlx5: fix uninit value use

Puranjay Mohan (9):
      arm32, bpf: add support for 32-bit offset jmp instruction
      arm32, bpf: add support for sign-extension load instruction
      arm32, bpf: add support for sign-extension mov instruction
      arm32, bpf: add support for unconditional bswap instruction
      arm32, bpf: add support for 32-bit signed division
      arm32, bpf: add support for 64 bit division instruction
      selftest, bpf: enable cpu v4 tests for arm32
      bpf/tests: add tests for cpuv4 instructions
      MAINTAINERS: Add myself for ARM32 BPF JIT maintainer.

Quan Tian (1):
      docs/bpf: update out-of-date doc in BPF flow dissector

Raj Kumar Bhagat (1):
      wifi: cfg80211: allow reg update by driver even if wiphy->regd is set

Raju Lakkaraju (2):
      net: sfp: add quirk for FS's 2.5G copper SFP
      net: pcs: xpcs: Add 2500BASE-X case in get state for XPCS drivers

Ramya Gnanasekar (2):
      wifi: ath12k: register EHT mesh capabilities
      wifi: ath12k: Enable Mesh support for QCN9274

Rand Deeb (1):
      ssb: Fix division by zero issue in ssb_calc_clock_rate

Randy Dunlap (4):
      ssb: relax SSB_EMBEDDED dependencies
      wifi: cfg80211: fix header kernel-doc typos
      wifi: mac80211: fix header kernel-doc typos
      wifi: nl80211: fix doc typos

Rob Herring (14):
      atm: fore200e: Drop unnecessary of_match_device()
      net: ethernet: Use device_get_match_data()
      net: ethernet: wiznet: Use spi_get_device_match_data()
      net: mdio: xgene: Use device_get_match_data()
      wifi: ath11k: Use device_get_match_data()
      dt-bindings: net: Add missing (unevaluated|additional)Properties on child node schemas
      dt-bindings: net: renesas: Drop ethernet-phy node schema
      dt-bindings: net: dsa/switch: Make 'ethernet-port' node addresses hex
      dt-bindings: net: ethernet-switch: Add missing 'ethernet-ports' level
      dt-bindings: net: ethernet-switch: Rename $defs "base" to 'ethernet-ports'
      dt-bindings: net: mscc,vsc7514-switch: Clean-up example indentation
      dt-bindings: net: mscc,vsc7514-switch: Simplify DSA and switch references
      dt-bindings: net: dsa: Drop 'ethernet-ports' node properties
      net: mdio: xgene: Fix unused xgene_mdio_of_match warning for !CONFIG_OF

Rohan G Thomas (2):
      dt-bindings: net: snps,dwmac: Tx coe unsupported
      net: stmmac: Tx coe sw fallback

Rong Tao (2):
      selftests/bpf: trace_helpers.c: Optimize kallsyms cache
      selftests/bpf: trace_helpers.c: Add a global ksyms initialization mutex

Rotem Saado (1):
      wifi: iwlwifi: yoyo: swap cdb and jacket bits values

Ruowen Qin (1):
      samples/bpf: Add -fsanitize=bounds to userspace programs

Russell King (Oracle) (18):
      net: phy: always call phy_process_state_change() under lock
      net: phy: call phy_error_precise() while holding the lock
      net: phy: move call to start aneg
      net: phy: move phy_suspend() to end of phy_state_machine()
      net: phy: move phy_state_machine()
      net: phy: split locked and unlocked section of phy_state_machine()
      net: phy: convert phy_stop() to use split state machine
      net: phy: fix regression with AX88772A PHY driver
      net: dsa: mt753x: remove mt753x_phylink_pcs_link_up()
      net: sfp: re-implement ignoring the hardware TX_FAULT signal
      net: sfp: improve Nokia GPON sfp fixup
      net: dsa: vsc73xx: add phylink capabilities
      net: dsa: dsa_loop: add phylink capabilities
      net: dsa: remove dsa_port_phylink_validate()
      net: phylink: provide mac_get_caps() method
      net: fman: convert to .mac_get_caps()
      net: phylink: remove .validate() method
      net: phylink: remove a bunch of unused validation methods

Sabrina Dubroca (15):
      tls: get salt using crypto_info_salt in tls_enc_skb
      tls: drop unnecessary cipher_type checks in tls offload
      tls: store rec_seq directly within cipher_context
      tls: rename MAX_IV_SIZE to TLS_MAX_IV_SIZE
      tls: store iv directly within cipher_context
      tls: extract context alloc/initialization out of tls_set_sw_offload
      tls: move tls_prot_info initialization out of tls_set_sw_offload
      tls: also use init_prot_info in tls_set_device_offload
      tls: add a helper to allocate/initialize offload_ctx_tx
      tls: remove tls_context argument from tls_set_sw_offload
      tls: remove tls_context argument from tls_set_device_offload
      tls: validate crypto_info in a separate helper
      chcr_ktls: use tls_offload_context_tx and driver_state like other drivers
      tls: use fixed size for tls_offload_context_{tx,rx}.driver_state
      tls: don't reset prot->aad_size and prot->tail_size for TLS_HW

Sascha Hauer (1):
      net: phy: dp83867: Add support for hardware blinking LEDs

Sean Wang (4):
      wifi: mt76: move struct ieee80211_chanctx_conf up to struct mt76_vif
      wifi: mt76: mt7921: fix the wrong rate pickup for the chanctx driver
      wifi: mt76: mt7921: fix the wrong rate selected in fw for the chanctx driver
      wifi: mt76: reduce spin_lock_bh held up in mt76_dma_rx_cleanup

Sebastian Andrzej Siewior (3):
      net: Tree wide: Replace xdp_do_flush_map() with xdp_do_flush().
      bpf: Remove xdp_do_flush_map().
      net, bpf: Add a warning if NAPI cb missed xdp_do_flush().

Sergey Temerkhanov (1):
      ice: prefix clock timer command enumeration values with ICE_PTP

Shannon Nelson (7):
      pds_core: check health in devcmd wait
      pds_core: keep viftypes table across reset
      pds_core: implement pci reset handlers
      pds_core: add attempts to fix broken PCI
      ionic: count SGs in packet to minimize linearize
      ionic: add a check for max SGs and SKB frags
      ionic: expand the descriptor bufs array

Shaul Triebitz (2):
      wifi: iwlwifi: mvm: enable FILS DF Tx on non-PSC channel
      wifi: iwlwifi: mvm: implement ROC version 3

Shay Drory (4):
      net/mlx5: Enable 4 ports multiport E-switch
      net/mlx5: Avoid false positive lockdep warning by adding lock_class_key
      net/mlx5: Refactor LAG peer device lookout bus logic to mlx5 devcom
      net/mlx5: Replace global mlx5_intf_lock with HCA devcom component lock

Shayne Chen (2):
      wifi: mt76: mt7996: only set vif teardown cmds at remove interface
      wifi: mt76: fix per-band IEEE80211_CONF_MONITOR flag comparison

Shihong Wang (1):
      nfp: add support CHACHA20-POLY1305 offload for ipsec

Shiji Yang (5):
      wifi: rt2x00: fix MT7620 low RSSI issue
      wifi: rt2x00: fix rt2800 watchdog function
      wifi: rt2x00: improve MT7620 register initialization
      wifi: rt2x00: rework MT7620 channel config function
      wifi: rt2x00: rework MT7620 PA/LNA RF calibration

Shinas Rasheed (3):
      octeon_ep: support to fetch firmware info
      octeon_ep: restructured interrupt handlers
      octeon_ep: assert hardware structure sizes

Sidhanta Sahu (1):
      wifi: ath12k: Set default beacon mode to burst mode

Sieng-Piaw Liew (2):
      atl1c: Work around the DMA RX overflow issue
      net: atl1c: switch to napi_consume_skb()

Song Liu (2):
      bpf: Charge modmem for struct_ops trampoline
      bpf: Fix unnecessary -EBUSY from htab_lock_bucket

Sonia Sharma (1):
      hv_netvsc: fix netvsc_send_completion to avoid multiple message length checks

Sreekanth Reddy (1):
      bnxt_en: Support QOS and TPID settings for the SRIOV VLAN

Stanislav Fomichev (3):
      bpf: make it easier to add new metadata kfunc
      bpf: expose information about supported xdp metadata kfunc
      tools: ynl: extend netdev sample to dump xdp-rx-metadata-features

Stanislaw Gruszka (1):
      MAINTAINERS: wifi: rt2x00: drop Helmut Schaa

StanleyYP Wang (1):
      wifi: mt76: get rid of false alamrs of tx emission issues

Stefano Garzarella (5):
      vsock/test: add recv_buf() utility function
      vsock/test: use recv_buf() in vsock_test.c
      vsock/test: add send_buf() utility function
      vsock/test: use send_buf() in vsock_test.c
      vsock/test: track bytes in sk_buff merging test for SOCK_SEQPACKET

Stephen Douthit (1):
      wifi: mac80211: Sanity check tx bitrate if not provided by driver

Su Hui (3):
      pds_core: add an error code check in pdsc_dl_info_get
      net: dsa: mv88e6xxx: add an error code check in mv88e6352_tai_event_work
      net: lan966x: remove useless code in lan966x_xtr_irq_handler

Subbaraya Sundeep (1):
      octeontx2-af: Enable hardware timestamping for VFs

Sujuan Chen (5):
      net: ethernet: mtk_wed: introduce WED support for MT7988
      net: ethernet: mtk_wed: introduce partial AMSDU offload support for MT7988
      net: ethernet: mtk_wed: introduce hw_rro support for MT7988
      net: ethernet: mtk_wed: debugfs: add WED 3.0 debugfs entries
      net: ethernet: mtk_wed: add wed 3.0 reset support

Swarup Laxman Kotiaklapudi (1):
      selftests: net: change ifconfig with ip command

Tiezhu Yang (1):
      bpf, docs: Add loongarch64 as arch supporting BPF JIT

Tim Jiang (1):
      Bluetooth: qca: add support for QCA2066

Tirthendu Sarkar (1):
      xsk: add multi-buffer support for sockets sharing umem

Tom Rix (1):
      wifi: lib80211: remove unused variables iv32 and iv16

Tushar Vyavahare (8):
      selftests/xsk: Move pkt_stream to the xsk_socket_info
      selftests/xsk: Rename xsk_xdp_metadata.h to xsk_xdp_common.h
      selftests/xsk: Move src_mac and dst_mac to the xsk_socket_info
      selftests/xsk: Iterate over all the sockets in the receive pkts function
      selftests/xsk: Remove unnecessary parameter from pkt_set() function call
      selftests/xsk: Iterate over all the sockets in the send pkts function
      selftests/xsk: Modify xsk_update_xskmap() to accept the index as an argument
      selftests/xsk: Add a test for shared umem feature

Uwe Kleine-König (84):
      wifi: wlcore: Convert to platform remove callback returning void
      net: ethernet: 8390: Convert to platform remove callback returning void
      net: ethernet: actions: Convert to platform remove callback returning void
      net: ethernet: aeroflex: Convert to platform remove callback returning void
      net: ethernet: allwinner: Convert to platform remove callback returning void
      net: ethernet: altera: Convert to platform remove callback returning void
      net: ethernet: amd: Convert to platform remove callback returning void
      net: ethernet: apm: Convert to platform remove callback returning void
      net: ethernet: apple: Convert to platform remove callback returning void
      net: ethernet: arc: Convert to platform remove callback returning void
      net: ethernet: atheros: Convert to platform remove callback returning void
      net: ethernet: broadcom: Convert to platform remove callback returning void
      net: ethernet: cadence: Convert to platform remove callback returning void
      net: ethernet: calxeda: Convert to platform remove callback returning void
      net: ethernet: cavium: Convert to platform remove callback returning void
      net: ethernet: cirrus: Convert to platform remove callback returning void
      net: ethernet: cortina: Convert to platform remove callback returning void
      net: ethernet: davicom: Convert to platform remove callback returning void
      net: ethernet: dnet: Convert to platform remove callback returning void
      net: ethernet: engleder: Convert to platform remove callback returning void
      net: ethernet: ethoc: Convert to platform remove callback returning void
      net: ethernet: faraday: Convert to platform remove callback returning void
      net: ethernet: hisilicon: Convert to platform remove callback returning void
      net: ethernet: i825xx: Convert to platform remove callback returning void
      net: ethernet: ibm: Convert to platform remove callback returning void
      net: ethernet: korina: Convert to platform remove callback returning void
      net: ethernet: lantiq_etop: Convert to platform remove callback returning void
      net: ethernet: lantiq_xrx200: Convert to platform remove callback returning void
      net: ethernet: litex: Convert to platform remove callback returning void
      net: ethernet: marvell: Convert to platform remove callback returning void
      net: ethernet: mediatek: Convert to platform remove callback returning void
      net: ethernet: mellanox: Convert to platform remove callback returning void
      net: ethernet: micrel: Convert to platform remove callback returning void
      net: ethernet: microchip: Convert to platform remove callback returning void
      net: ethernet: moxa:: Convert to platform remove callback returning void
      net: ethernet: mscc: Convert to platform remove callback returning void
      net: ethernet: natsemi: Convert to platform remove callback returning void
      net: ethernet: natsemi: Convert to platform remove callback returning void
      net: ethernet: ni: Convert to platform remove callback returning void
      net: ethernet: nxp: Convert to platform remove callback returning void
      net: ethernet: qualcomm: Convert to platform remove callback returning void
      net: ethernet: renesas: Convert to platform remove callback returning void
      net: ethernet: samsung: Convert to platform remove callback returning void
      net: ethernet: seeq: Convert to platform remove callback returning void
      net: ethernet: sgi: Convert to platform remove callback returning void
      net: ethernet: smsc: Convert to platform remove callback returning void
      net: ethernet: socionext: Convert to platform remove callback returning void
      net: ethernet: sun: Convert to platform remove callback returning void
      net: ethernet: sunplus: Convert to platform remove callback returning void
      net: ethernet: ti: Convert to platform remove callback returning void
      net: ethernet: tundra: Convert to platform remove callback returning void
      net: ethernet: via: Convert to platform remove callback returning void
      net: ethernet: wiznet: Convert to platform remove callback returning void
      net: ethernet: xilinx: Convert to platform remove callback returning void
      net: ethernet: xscale: Convert to platform remove callback returning void
      net: dsa: b53: Convert to platform remove callback returning void
      net: dsa: bcm_sf2: Convert to platform remove callback returning void
      net: dsa: hirschmann: Convert to platform remove callback returning void
      net: dsa: lantiq_gswip: Convert to platform remove callback returning void
      net: dsa: mt7530: Convert to platform remove callback returning void
      net: dsa: ocelot: Convert to platform remove callback returning void
      net: dsa: realtek: Convert to platform remove callback returning void
      net: dsa: rzn1_a5psw: Convert to platform remove callback returning void
      net: dsa: vitesse-vsc73xx: Convert to platform remove callback returning void
      net: mdio: aspeed: Convert to platform remove callback returning void
      net: mdio: bcm-iproc: Convert to platform remove callback returning void
      net: mdio: bcm-unimac: Convert to platform remove callback returning void
      net: mdio: gpio: Convert to platform remove callback returning void
      net: mdio: hisi-femac: Convert to platform remove callback returning void
      net: mdio: ipq4019: Convert to platform remove callback returning void
      net: mdio: ipq8064: Convert to platform remove callback returning void
      net: mdio: moxart: Convert to platform remove callback returning void
      net: mdio: mscc-miim: Convert to platform remove callback returning void
      net: mdio: mux-bcm-iproc: Convert to platform remove callback returning void
      net: mdio: mux-bcm6368: Convert to platform remove callback returning void
      net: mdio: mux-gpio: Convert to platform remove callback returning void
      net: mdio: mux-meson-g12a: Convert to platform remove callback returning void
      net: mdio: mux-meson-gxl: Convert to platform remove callback returning void
      net: mdio: mux-mmioreg: Convert to platform remove callback returning void
      net: mdio: mux-multiplexer: Convert to platform remove callback returning void
      net: mdio: octeon: Convert to platform remove callback returning void
      net: mdio: sun4i: Convert to platform remove callback returning void
      net: mdio: xgene: Convert to platform remove callback returning void
      net: ethernet: xilinx: Drop kernel doc comment about return value

Vadim Fedorenko (5):
      dpll: documentation on DPLL subsystem interface
      dpll: spec: Add Netlink spec in YAML
      dpll: core: Add DPLL framework base functions
      dpll: netlink: Add DPLL framework base functions
      ptp_ocp: implement DPLL ops

Vadim Pasternak (3):
      mlxsw: reg: Limit MTBR register payload to a single data record
      mlxsw: core: Extend allowed list of external cooling devices for thermal zone binding
      mlxsw: i2c: Utilize standard macros for dividing buffer into chunks

Vijay Satija (1):
      Bluetooth: Add support for Intel Misty Peak - 8087:0038

Vikas Gupta (1):
      bnxt_en: Update VNIC resource calculation for VFs

Viktor Malik (3):
      samples/bpf: Allow building with custom CFLAGS/LDFLAGS
      samples/bpf: Fix passing LDFLAGS to libbpf
      samples/bpf: Allow building with custom bpftool

Vinayak Yadawad (2):
      wifi: cfg80211: OWE DH IE handling offload
      wifi: cfg80211: Allow AP/P2PGO to indicate port authorization to peer STA/P2PClient

Vincent Mailhol (2):
      can: etas_es58x: rework the version check logic to silence -Wformat-truncation
      can: etas_es58x: add missing a blank line after declaration

Vishvambar Panth S (1):
      net: microchip: lan743x: improve throughput with rx timestamp config

Vlad Pruteanu (1):
      Bluetooth: ISO: Set CIS bit only for devices with CIS support

Vladimir Oltean (3):
      net: dsa: propagate extack to ds->ops->port_hsr_join()
      net: dsa: notify drivers of MAC address changes on user ports
      net: dsa: microchip: move REG_SW_MAC_ADDR to dev->info->regs[]

Víctor Gonzalo (1):
      wifi: mwifiex: use MODULE_FIRMWARE to add firmware files metadata

Wei Zhang (2):
      net/mlx5: Parallelize vhca event handling
      net/mlx5: Redesign SF active work to remove table_lock

Wen Gong (15):
      wifi: cfg80211: save power spectral density(psd) of regulatory rule
      wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band in EHT PHY capability for WCN7850
      wifi: ath12k: change to initialize recovery variables earlier in ath12k_core_reset()
      wifi: ath11k: add chip id board name while searching board-2.bin for WCN6855
      wifi: ath12k: fix recovery fail while firmware crash when doing channel switch
      wifi: ath12k: indicate to mac80211 scan complete with aborted flag for ATH12K_SCAN_STARTING state
      wifi: ath12k: indicate scan complete for scan canceled when scan running
      wifi: ath12k: change to treat alpha code na as world wide regdomain
      wifi: ath12k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN7850
      wifi: ath12k: add read variant from SMBIOS for download board data
      wifi: ath12k: add keep backward compatibility of PHY mode to avoid firmware crash
      wifi: ath10k: indicate to mac80211 scan complete with aborted flag for ATH10K_SCAN_STARTING state
      wifi: ath12k: configure RDDM size to MHI for device recovery
      wifi: ath12k: add ath12k_qmi_free_resource() for recovery
      wifi: ath12k: fix invalid m3 buffer address

Willem de Bruijn (3):
      net: add skb_segment kunit test
      net: parametrize skb_segment unit test to expand coverage
      net: expand skb_segment unit test with frag_list coverage

Wolfram Sang (3):
      net: cpmac: remove driver to prepare for platform removal
      net: ethernet: renesas: group entries in Makefile
      net: ethernet: renesas: drop SoC names in Kconfig

Wu Yunchuan (9):
      wifi: ar5523: Remove unnecessary (void*) conversions
      wifi: wcn36xx: remove unnecessary (void*) conversions
      wifi: ath5k: remove unnecessary (void*) conversions
      wifi: ath6kl: remove unnecessary (void*) conversions
      wifi: ath10k: Remove unnecessary (void*) conversions
      wifi: ath12k: Remove unnecessary (void*) conversions
      wifi: ath11k: remove unnecessary (void*) conversions
      wifi: carl9170: remove unnecessary (void*) conversions
      wifi: ray_cs: Remove unnecessary (void*) conversions

Xabier Marquiegui (6):
      posix-clock: introduce posix_clock_context concept
      ptp: Replace timestamp event queue with linked list
      ptp: support multiple timestamp event readers
      ptp: support event queue reader channel masks
      ptp: add debugfs interface to see applied channel masks
      ptp: add testptp mask test

Yafang Shao (5):
      bpf: Inherit system settings for CPU security mitigations
      bpf: Avoid unnecessary audit log for CPU security mitigations
      bpf: Fix missed rcu read lock in bpf_task_under_cgroup()
      selftests/bpf: Add selftest for bpf_task_under_cgroup() in sleepable prog
      selftests/bpf: Fix selftests broken by mitigations=off

Yajun Deng (2):
      i40e: Add rx_missed_errors for buffer exhaustion
      net/core: Introduce netdev_core_stats_inc()

Yan Zhai (3):
      ipv6: drop feature RTAX_FEATURE_ALLFRAG
      ipv6: refactor ip6_finish_output for GSO handling
      ipv6: avoid atomic fragment on GSO packets

Yang Li (1):
      netdev: Remove unneeded semicolon

Yedidya Benshimol (2):
      wifi: iwlwifi: mvm: add support for new wowlan_info_notif
      wifi: iwlwifi: mvm: update IGTK in mvmvif upon D3 resume

Yi-Chia Hsieh (3):
      wifi: mt76: mt7996: get tx_retries and tx_failed from txfree
      wifi: mt76: mt7996: Add mcu commands for getting sta tx statistic
      wifi: mt76: mt7996: enable PPDU-TxS to host

Yishai Hadas (1):
      net/mlx5: Introduce ifc bits for migration in a chunk mode

Yonghong Song (14):
      bpf: Add support for non-fix-size percpu mem allocation
      bpf: Add BPF_KPTR_PERCPU as a field type
      bpf: Add alloc/xchg/direct_access support for local percpu kptr
      bpf: Add bpf_this_cpu_ptr/bpf_per_cpu_ptr support for allocated percpu obj
      selftests/bpf: Update error message in negative linked_list test
      libbpf: Add __percpu_kptr macro definition
      selftests/bpf: Add bpf_percpu_obj_{new,drop}() macro in bpf_experimental.h
      selftests/bpf: Add tests for array map with local percpu kptr
      bpf: Mark OBJ_RELEASE argument as MEM_RCU when possible
      selftests/bpf: Remove unnecessary direct read of local percpu kptr
      selftests/bpf: Add tests for cgrp_local_storage with local percpu kptr
      selftests/bpf: Add some negative tests
      bpf: Mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated
      net: bpf: Use sockopt_lock_sock() in ip_sock_set_tos()

Yoshihiro Shimoda (2):
      rswitch: Use unsigned int for port related array index
      rswitch: Add PM ops

Yu Liao (1):
      net/mlx5e: Use PTR_ERR_OR_ZERO() to simplify code

Yue Haibing (1):
      net/mlx5: Remove unused declaration

Yunsheng Lin (6):
      page_pool: fragment API support for 32-bit arch with 64-bit DMA
      page_pool: unify frag_count handling in page_pool_is_last_frag()
      page_pool: remove PP_FLAG_PAGE_FRAG
      page_pool: introduce page_pool_alloc() API
      page_pool: update document about fragment API
      net: veth: use newly added page pool API for veth with xdp

Zenm Chen (2):
      wifi: rtl8xxxu: mark TOTOLINK N150UA V5/N150UA-B as tested
      wifi: rtl8xxxu: Add a description about the device ID 0x7392:0xb722

ZhengHan Wang (1):
      Bluetooth: Fix double free in hci_conn_cleanup

Zhengchao Shao (1):
      net: dst: remove unnecessary input parameter in dst_alloc and dst_init

Zhengping Jiang (1):
      Bluetooth: btmtksdio: enable bluetooth wakeup in system suspend

Ziyang Xuan (1):
      Bluetooth: Make handle of hci_conn be unique

Zong-Zhe Yang (45):
      wifi: rtw89: mcc: initialize start flow
      wifi: rtw89: mcc: fill fundamental configurations
      wifi: rtw89: mcc: consider and determine BT duration
      wifi: rtw89: mcc: decide pattern and calculate parameters
      wifi: rtw89: fix typo of rtw89_fw_h2c_mcc_macid_bitmap()
      wifi: rtw89: mcc: trigger FW to start/stop MCC
      wifi: rtw89: 52c: rfk: refine MCC channel info notification
      wifi: rtw89: rfk: disable driver tracking during MCC
      wifi: rtw89: 52c: rfk: disable DPK during MCC
      wifi: rtw89: mcc: update role bitmap when changed
      wifi: rtw89: mcc: track beacon offset and update when needed
      wifi: rtw89: mcc: deal with P2P PS change
      wifi: rtw89: mcc: deal with BT slot change
      wifi: rtw89: mcc: deal with beacon NoA if GO exists
      wifi: rtw89: indicate TX shape table inside RFE parameter
      wifi: rtw89: indicate TX power by rate table inside RFE parameter
      wifi: rtw89: phy: refine helpers used for raw TX power
      wifi: rtw89: load TX power by rate when RFE parms setup
      wifi: rtw89: phy: extend TX power common stuffs for Wi-Fi 7 chips
      wifi: rtw89: load TX power related tables from FW elements
      wifi: rtw89: mcc: fix NoA start time when GO is auxiliary
      wifi: rtw89: pause/proceed MCC for ROC and HW scan
      wifi: rtw89: 8852c: declare to support two chanctx
      wifi: rtw89: declare MCC in interface combination
      wifi: rtw89: regd: configure Thailand in regulation type
      wifi: rtw89: 8852c: update TX power tables to R67
      wifi: rtw89: 8852b: update TX power tables to R35
      wifi: rtw89: 8851b: update TX power tables to R34
      wifi: rtw89: mac: get TX power control register according to chip gen
      wifi: rtw89: phy: set TX power by rate according to chip gen
      wifi: rtw89: phy: set TX power offset according to chip gen
      wifi: rtw89: phy: set TX power limit according to chip gen
      wifi: rtw89: phy: set TX power RU limit according to chip gen
      wifi: rtw89: debug: show txpwr table according to chip gen
      wifi: rtw89: debug: txpwr table supports Wi-Fi 7 chips
      wifi: rtw88: regd: configure QATAR and UK
      wifi: rtw88: 8821c: update TX power limit to V67
      wifi: rtw88: 8822c: update TX power limit to V70
      wifi: rtw88: regd: update regulatory map to R64-R42
      wifi: rtw88: 8821c: tweak CCK TX filter setting for SRRC regulation
      wifi: rtw89: mac: update RTS threshold according to chip gen
      wifi: rtw89: mac: generalize register of MU-EDCA switch according to chip gen
      wifi: rtw89: mac: set bfee_ctrl() according to chip gen
      wifi: rtw89: mac: set bf_assoc capabilities according to chip gen
      wifi: rtw89: mac: do bf_monitor only if WiFi 6 chips

iallouch (1):
      wifi: iwlwifi: mvm: add start mac ctdp sum calculation debugfs handler

youwan Wang (1):
      Bluetooth: btusb: Add date->evt_skb is NULL check

zhujun2 (1):
      selftests: net: remove unused variables

 Documentation/admin-guide/sysctl/net.rst           |    1 +
 Documentation/bpf/libbpf/program_types.rst         |   10 +
 Documentation/bpf/prog_flow_dissector.rst          |    2 +-
 .../bpf/standardization/instruction-set.rst        |    8 +
 .../bindings/arm/mediatek/mediatek,mt7622-wed.yaml |    1 +
 Documentation/devicetree/bindings/i3c/i3c.yaml     |    6 +
 Documentation/devicetree/bindings/mfd/syscon.yaml  |    2 +
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |    2 +
 .../devicetree/bindings/net/brcm,asp-v2.0.yaml     |    2 +-
 .../devicetree/bindings/net/dsa/brcm,sf2.yaml      |    1 +
 Documentation/devicetree/bindings/net/dsa/dsa.yaml |   11 +-
 .../bindings/net/dsa/mediatek,mt7530.yaml          |   10 +-
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |   22 +
 .../bindings/net/dsa/microchip,lan937x.yaml        |    3 +-
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |    4 +-
 .../devicetree/bindings/net/dsa/qca8k.yaml         |    1 +
 .../devicetree/bindings/net/dsa/realtek.yaml       |    2 +
 .../bindings/net/dsa/renesas,rzn1-a5psw.yaml       |   10 +-
 .../devicetree/bindings/net/engleder,tsnep.yaml    |    1 +
 .../devicetree/bindings/net/ethernet-switch.yaml   |   14 +-
 Documentation/devicetree/bindings/net/fsl,fec.yaml |    1 +
 .../bindings/net/loongson,ls1b-gmac.yaml           |  114 +
 .../bindings/net/loongson,ls1c-emac.yaml           |  113 +
 .../bindings/net/mscc,vsc7514-switch.yaml          |   44 +-
 .../devicetree/bindings/net/nxp,tja11xx.yaml       |    1 +
 .../devicetree/bindings/net/renesas,ether.yaml     |    3 +-
 .../devicetree/bindings/net/renesas,etheravb.yaml  |    3 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |    5 +
 .../devicetree/bindings/net/ti,cpsw-switch.yaml    |    2 +-
 .../devicetree/bindings/net/ti,icssg-prueth.yaml   |    8 +
 .../soc/mediatek/mediatek,mt7986-wo-ccif.yaml      |    1 +
 Documentation/driver-api/80211/mac80211.rst        |    2 +-
 Documentation/driver-api/dpll.rst                  |  551 +++
 Documentation/driver-api/index.rst                 |    1 +
 Documentation/netlink/genetlink-c.yaml             |   45 +-
 Documentation/netlink/genetlink-legacy.yaml        |   51 +-
 Documentation/netlink/genetlink.yaml               |   39 +-
 Documentation/netlink/netlink-raw.yaml             |   23 +-
 Documentation/netlink/specs/devlink.yaml           | 1568 ++++++-
 Documentation/netlink/specs/dpll.yaml              |  510 +++
 Documentation/netlink/specs/ethtool.yaml           |    3 -
 Documentation/netlink/specs/handshake.yaml         |    8 +-
 Documentation/netlink/specs/mptcp.yaml             |  393 ++
 Documentation/netlink/specs/netdev.yaml            |   21 +-
 .../networking/device_drivers/appletalk/cops.rst   |   80 -
 .../networking/device_drivers/appletalk/index.rst  |   18 -
 .../networking/device_drivers/ethernet/index.rst   |    1 +
 .../device_drivers/ethernet/intel/idpf.rst         |  160 +
 .../ethernet/mellanox/mlx5/kconfig.rst             |    2 +-
 Documentation/networking/device_drivers/index.rst  |    1 -
 Documentation/networking/devlink/i40e.rst          |   59 +
 Documentation/networking/devlink/index.rst         |   29 +
 Documentation/networking/dsa/b53.rst               |   14 +-
 Documentation/networking/dsa/bcm_sf2.rst           |    2 +-
 Documentation/networking/dsa/configuration.rst     |  102 +-
 Documentation/networking/dsa/dsa.rst               |  162 +-
 Documentation/networking/dsa/lan9303.rst           |    2 +-
 Documentation/networking/dsa/sja1105.rst           |    6 +-
 Documentation/networking/filter.rst                |    4 +-
 Documentation/networking/index.rst                 |    2 +-
 Documentation/networking/ip-sysctl.rst             |   41 +-
 Documentation/networking/ipddp.rst                 |   78 -
 Documentation/networking/mptcp-sysctl.rst          |   11 +
 Documentation/networking/msg_zerocopy.rst          |   13 +-
 Documentation/networking/netconsole.rst            |   22 +-
 Documentation/networking/page_pool.rst             |    4 +-
 Documentation/networking/pktgen.rst                |   12 +
 Documentation/networking/scaling.rst               |   42 +
 Documentation/networking/sfp-phylink.rst           |   10 +-
 Documentation/networking/tcp_ao.rst                |  444 ++
 Documentation/networking/xdp-rx-metadata.rst       |    7 +
 Documentation/process/7.AdvancedTopics.rst         |   18 +
 Documentation/process/maintainer-netdev.rst        |   15 +
 .../userspace-api/netlink/genetlink-legacy.rst     |   16 +-
 Documentation/userspace-api/netlink/specs.rst      |   23 +-
 MAINTAINERS                                        |   51 +-
 arch/arm/net/bpf_jit_32.c                          |  280 +-
 arch/arm/net/bpf_jit_32.h                          |    4 +
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |    2 +-
 arch/arm64/net/bpf_jit_comp.c                      |    2 +-
 arch/s390/net/bpf_jit_comp.c                       |  267 +-
 arch/x86/net/bpf_jit_comp.c                        |  148 +-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/atm/fore200e.c                             |    8 +-
 drivers/bluetooth/btmtksdio.c                      |   44 +-
 drivers/bluetooth/btqca.c                          |   68 +
 drivers/bluetooth/btqca.h                          |    5 +-
 drivers/bluetooth/btusb.c                          |   11 +
 drivers/bluetooth/hci_bcm4377.c                    |    5 +
 drivers/bluetooth/hci_qca.c                        |   11 +
 drivers/dpll/Kconfig                               |    7 +
 drivers/dpll/Makefile                              |    9 +
 drivers/dpll/dpll_core.c                           |  798 ++++
 drivers/dpll/dpll_core.h                           |   89 +
 drivers/dpll/dpll_netlink.c                        | 1423 +++++++
 drivers/dpll/dpll_netlink.h                        |   13 +
 drivers/dpll/dpll_nl.c                             |  164 +
 drivers/dpll/dpll_nl.h                             |   51 +
 drivers/i3c/master.c                               |   35 +
 drivers/infiniband/hw/mlx5/main.c                  |   17 +
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |    4 +-
 drivers/net/Kconfig                                |    9 +
 drivers/net/Makefile                               |    2 +-
 drivers/net/Space.c                                |    6 -
 drivers/net/appletalk/Kconfig                      |  102 -
 drivers/net/appletalk/Makefile                     |    7 -
 drivers/net/appletalk/cops.c                       | 1005 -----
 drivers/net/appletalk/cops.h                       |   61 -
 drivers/net/appletalk/cops_ffdrv.h                 |  532 ---
 drivers/net/appletalk/cops_ltdrv.h                 |  241 --
 drivers/net/appletalk/ipddp.c                      |  345 --
 drivers/net/appletalk/ipddp.h                      |   28 -
 drivers/net/bareudp.c                              |   45 +-
 drivers/net/bonding/bond_netlink.c                 |    2 +-
 drivers/net/can/Kconfig                            |    1 +
 drivers/net/can/at91_can.c                         |  998 ++---
 drivers/net/can/dev/dev.c                          |   51 +-
 drivers/net/can/dev/rx-offload.c                   |    2 +-
 drivers/net/can/dev/skb.c                          |    6 +-
 drivers/net/can/sja1000/peak_pci.c                 |    2 +-
 drivers/net/can/sja1000/sja1000.c                  |    2 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c        |    1 +
 drivers/net/can/usb/etas_es58x/es58x_core.h        |    6 +-
 drivers/net/can/usb/etas_es58x/es58x_devlink.c     |   57 +-
 drivers/net/dsa/b53/b53_common.c                   |    4 +-
 drivers/net/dsa/b53/b53_mdio.c                     |    2 +-
 drivers/net/dsa/b53/b53_mmap.c                     |    6 +-
 drivers/net/dsa/b53/b53_srab.c                     |    8 +-
 drivers/net/dsa/bcm_sf2.c                          |   49 +-
 drivers/net/dsa/bcm_sf2.h                          |    2 +-
 drivers/net/dsa/bcm_sf2_cfp.c                      |    4 +-
 drivers/net/dsa/dsa_loop.c                         |    9 +
 drivers/net/dsa/hirschmann/hellcreek.c             |    8 +-
 drivers/net/dsa/lan9303-core.c                     |    4 +-
 drivers/net/dsa/lantiq_gswip.c                     |   45 +-
 drivers/net/dsa/microchip/Makefile                 |    2 +-
 drivers/net/dsa/microchip/ksz8795.c                |   86 +-
 drivers/net/dsa/microchip/ksz8795_reg.h            |   21 -
 drivers/net/dsa/microchip/ksz9477.c                |  274 ++
 drivers/net/dsa/microchip/ksz9477.h                |   43 +
 drivers/net/dsa/microchip/ksz9477_acl.c            | 1436 +++++++
 drivers/net/dsa/microchip/ksz9477_i2c.c            |    5 +-
 drivers/net/dsa/microchip/ksz9477_reg.h            |   20 -
 drivers/net/dsa/microchip/ksz9477_tc_flower.c      |  281 ++
 drivers/net/dsa/microchip/ksz_common.c             |  645 ++-
 drivers/net/dsa/microchip/ksz_common.h             |   42 +
 drivers/net/dsa/microchip/ksz_ptp.c                |    2 +-
 drivers/net/dsa/microchip/ksz_spi.c                |    5 +-
 drivers/net/dsa/mt7530-mmio.c                      |    7 +-
 drivers/net/dsa/mt7530.c                           |   32 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |    4 +-
 drivers/net/dsa/mv88e6xxx/pcs-639x.c               |    2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c                    |    4 +
 drivers/net/dsa/ocelot/felix.c                     |   68 +-
 drivers/net/dsa/ocelot/felix.h                     |    6 +-
 drivers/net/dsa/ocelot/ocelot_ext.c                |    8 +-
 drivers/net/dsa/ocelot/seville_vsc9953.c           |    8 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   50 +-
 drivers/net/dsa/qca/qca8k-common.c                 |    7 +-
 drivers/net/dsa/qca/qca8k-leds.c                   |    6 +-
 drivers/net/dsa/qca/qca8k.h                        |    2 +-
 drivers/net/dsa/realtek/realtek-smi.c              |   36 +-
 drivers/net/dsa/realtek/realtek.h                  |    2 +-
 drivers/net/dsa/realtek/rtl8365mb.c                |    5 +-
 drivers/net/dsa/realtek/rtl8366-core.c             |    8 +-
 drivers/net/dsa/realtek/rtl8366rb.c                |   44 +-
 drivers/net/dsa/rzn1_a5psw.c                       |    8 +-
 drivers/net/dsa/sja1105/sja1105_clocking.c         |   21 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |    4 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |   49 +-
 drivers/net/dsa/vitesse-vsc73xx-platform.c         |    8 +-
 drivers/net/dsa/xrs700x/xrs700x.c                  |   30 +-
 drivers/net/ethernet/8390/ax88796.c                |    6 +-
 drivers/net/ethernet/8390/mcf8390.c                |    5 +-
 drivers/net/ethernet/8390/ne.c                     |    5 +-
 drivers/net/ethernet/actions/owl-emac.c            |    6 +-
 drivers/net/ethernet/aeroflex/greth.c              |    6 +-
 drivers/net/ethernet/allwinner/sun4i-emac.c        |    5 +-
 drivers/net/ethernet/altera/altera_tse.h           |    2 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |   19 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |    2 +-
 drivers/net/ethernet/amd/au1000_eth.c              |    6 +-
 drivers/net/ethernet/amd/pds_core/core.c           |   50 +-
 drivers/net/ethernet/amd/pds_core/core.h           |    7 +
 drivers/net/ethernet/amd/pds_core/dev.c            |   11 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |   31 +-
 drivers/net/ethernet/amd/pds_core/main.c           |   50 +
 drivers/net/ethernet/amd/sunlance.c                |    6 +-
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c      |   48 +-
 drivers/net/ethernet/apm/xgene-v2/main.c           |    6 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |   21 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h   |    3 +-
 drivers/net/ethernet/apple/macmace.c               |    6 +-
 drivers/net/ethernet/arc/emac_arc.c                |    6 +-
 drivers/net/ethernet/arc/emac_rockchip.c           |    5 +-
 drivers/net/ethernet/asix/ax88796c_ioctl.c         |    2 +-
 drivers/net/ethernet/atheros/ag71xx.c              |    8 +-
 drivers/net/ethernet/atheros/atl1c/atl1c.h         |    3 -
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |   80 +-
 drivers/net/ethernet/atheros/atlx/atl1.c           |    4 +-
 drivers/net/ethernet/atheros/atlx/atl2.c           |    2 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |    8 +-
 drivers/net/ethernet/broadcom/bcm4908_enet.c       |    6 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |   14 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |    8 +-
 drivers/net/ethernet/broadcom/bgmac-platform.c     |    6 +-
 drivers/net/ethernet/broadcom/bnxt/Makefile        |    1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  275 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   13 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |   95 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  694 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |  541 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c    |  241 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h    |   30 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c     |    2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h     |   14 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |   26 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |   26 +-
 drivers/net/ethernet/broadcom/sb1250-mac.c         |    6 +-
 drivers/net/ethernet/broadcom/tg3.c                |   81 +-
 drivers/net/ethernet/broadcom/tg3.h                |    3 +
 drivers/net/ethernet/brocade/bna/bfa_ioc.c         |    2 +-
 drivers/net/ethernet/cadence/macb_main.c           |    6 +-
 drivers/net/ethernet/calxeda/xgmac.c               |    6 +-
 drivers/net/ethernet/cavium/liquidio/lio_ethtool.c |   18 +-
 drivers/net/ethernet/cavium/liquidio/lio_main.c    |    2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c  |    3 +-
 .../net/ethernet/cavium/liquidio/octeon_device.c   |   11 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c   |    5 +-
 drivers/net/ethernet/chelsio/cxgb3/l2t.h           |    2 +-
 drivers/net/ethernet/chelsio/cxgb3/sge.c           |   15 +-
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h      |    2 +-
 .../ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h    |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/l2t.c           |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/sched.h         |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/smt.h           |    2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c         |    2 +-
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c      |   43 +-
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.h      |   36 +-
 .../chelsio/inline_crypto/chtls/chtls_cm.c         |    2 +-
 drivers/net/ethernet/cirrus/cs89x0.c               |    5 +-
 drivers/net/ethernet/cirrus/ep93xx_eth.c           |    8 +-
 drivers/net/ethernet/cirrus/mac89x0.c              |    5 +-
 drivers/net/ethernet/cortina/gemini.c              |   12 +-
 drivers/net/ethernet/davicom/dm9000.c              |    6 +-
 drivers/net/ethernet/dec/tulip/tulip.h             |    2 +-
 drivers/net/ethernet/dnet.c                        |    6 +-
 drivers/net/ethernet/engleder/tsnep.h              |    2 +-
 drivers/net/ethernet/engleder/tsnep_hw.h           |    2 +
 drivers/net/ethernet/engleder/tsnep_main.c         |  121 +-
 drivers/net/ethernet/ethoc.c                       |    6 +-
 drivers/net/ethernet/ezchip/nps_enet.c             |    2 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |    5 +-
 drivers/net/ethernet/faraday/ftmac100.c            |    5 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |    2 +-
 drivers/net/ethernet/freescale/enetc/enetc.h       |    2 +-
 drivers/net/ethernet/freescale/enetc/enetc_qos.c   |    2 +-
 drivers/net/ethernet/freescale/fec_main.c          |   83 +-
 drivers/net/ethernet/freescale/fman/fman_memac.c   |   11 +-
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |   18 +-
 drivers/net/ethernet/freescale/fs_enet/mii-fec.c   |   10 +-
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |   12 +-
 drivers/net/ethernet/google/gve/gve_main.c         |    4 +-
 drivers/net/ethernet/hisilicon/hip04_eth.c         |    6 +-
 drivers/net/ethernet/hisilicon/hisi_femac.c        |    6 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      |   17 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |    6 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h  |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h  |    2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |    5 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |    5 +
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |    1 +
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.h    |    2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |    3 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |    3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |  116 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |    2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  161 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   18 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |    2 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c          |    5 +-
 drivers/net/ethernet/huawei/hinic/hinic_devlink.c  |  217 +-
 drivers/net/ethernet/huawei/hinic/hinic_tx.c       |    8 +-
 drivers/net/ethernet/i825xx/sni_82596.c            |    5 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c          |   10 +-
 drivers/net/ethernet/ibm/emac/core.c               |    6 +-
 drivers/net/ethernet/ibm/emac/mal.c                |    8 +-
 drivers/net/ethernet/ibm/emac/rgmii.c              |    6 +-
 drivers/net/ethernet/ibm/emac/tah.c                |    6 +-
 drivers/net/ethernet/ibm/emac/zmii.c               |    6 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |    2 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |    5 +-
 drivers/net/ethernet/intel/Kconfig                 |   14 +
 drivers/net/ethernet/intel/Makefile                |    1 +
 drivers/net/ethernet/intel/e100.c                  |    2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c      |    2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c   |    8 +-
 drivers/net/ethernet/intel/i40e/Makefile           |    3 +-
 drivers/net/ethernet/intel/i40e/i40e.h             |  216 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |    8 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.h      |    3 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |    2 +
 drivers/net/ethernet/intel/i40e/i40e_alloc.h       |   24 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c      |    1 -
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   69 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c         |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |    2 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c         |   31 +-
 drivers/net/ethernet/intel/i40e/i40e_debug.h       |   47 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |    3 +-
 drivers/net/ethernet/intel/i40e/i40e_devlink.c     |  236 ++
 drivers/net/ethernet/intel/i40e/i40e_devlink.h     |   18 +
 drivers/net/ethernet/intel/i40e/i40e_diag.h        |    5 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   16 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.c         |   16 +-
 drivers/net/ethernet/intel/i40e/i40e_hmc.h         |    4 +
 drivers/net/ethernet/intel/i40e/i40e_io.h          |   16 +
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     |    9 +-
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h     |    2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  125 +-
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |    2 +
 drivers/net/ethernet/intel/i40e/i40e_osdep.h       |   59 -
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   12 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |    3 +-
 drivers/net/ethernet/intel/i40e/i40e_register.h    |    5 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |    9 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |    1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx_common.h |    2 +
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   60 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |    4 -
 drivers/net/ethernet/intel/i40e/i40e_xsk.h         |    4 +
 drivers/net/ethernet/intel/iavf/Makefile           |    2 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   46 +-
 drivers/net/ethernet/intel/iavf/iavf_client.c      |  578 ---
 drivers/net/ethernet/intel/iavf/iavf_client.h      |  169 -
 drivers/net/ethernet/intel/iavf/iavf_common.c      |   32 -
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |    8 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  244 +-
 drivers/net/ethernet/intel/iavf/iavf_prototype.h   |    2 -
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |   46 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h        |   12 -
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |  117 +-
 drivers/net/ethernet/intel/ice/Makefile            |    2 +-
 drivers/net/ethernet/intel/ice/ice.h               |   23 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |  306 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |  750 +++-
 drivers/net/ethernet/intel/ice/ice_common.h        |   51 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c           |  475 ++-
 drivers/net/ethernet/intel/ice/ice_ddp.h           |   27 +-
 drivers/net/ethernet/intel/ice/ice_devids.h        |   10 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          | 2120 ++++++++++
 drivers/net/ethernet/intel/ice/ice_dpll.h          |  114 +
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c    |    6 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  228 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.h       |    8 +
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |   24 +-
 drivers/net/ethernet/intel/ice/ice_flow.c          |    5 +-
 drivers/net/ethernet/intel/ice/ice_flow.h          |    3 -
 drivers/net/ethernet/intel/ice/ice_gnss.c          |    3 +
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |   53 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |  135 +-
 drivers/net/ethernet/intel/ice/ice_lag.h           |    2 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |   43 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   96 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  679 +++-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   41 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |  758 +++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   95 +-
 drivers/net/ethernet/intel/ice/ice_sched.c         |   56 +-
 drivers/net/ethernet/intel/ice/ice_sched.h         |    6 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |  307 +-
 drivers/net/ethernet/intel/ice/ice_sriov.h         |   17 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |   63 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      |    2 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |   29 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |    2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |    9 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   71 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c |   29 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   22 +-
 drivers/net/ethernet/intel/idpf/Makefile           |   18 +
 drivers/net/ethernet/intel/idpf/idpf.h             |  968 +++++
 drivers/net/ethernet/intel/idpf/idpf_controlq.c    |  621 +++
 drivers/net/ethernet/intel/idpf/idpf_controlq.h    |  130 +
 .../net/ethernet/intel/idpf/idpf_controlq_api.h    |  169 +
 .../net/ethernet/intel/idpf/idpf_controlq_setup.c  |  171 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c         |  165 +
 drivers/net/ethernet/intel/idpf/idpf_devids.h      |   10 +
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     | 1369 +++++++
 drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h |  124 +
 drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h    |  293 ++
 drivers/net/ethernet/intel/idpf/idpf_lan_vf_regs.h |  128 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c         | 2379 +++++++++++
 drivers/net/ethernet/intel/idpf/idpf_main.c        |  279 ++
 drivers/net/ethernet/intel/idpf/idpf_mem.h         |   20 +
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    | 1183 ++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        | 4292 ++++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        | 1023 +++++
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c      |  163 +
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    | 3798 +++++++++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h        | 1273 ++++++
 .../net/ethernet/intel/idpf/virtchnl2_lan_desc.h   |  451 ++
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |    4 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   55 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |    2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |    5 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   26 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |    2 +-
 drivers/net/ethernet/korina.c                      |    6 +-
 drivers/net/ethernet/lantiq_etop.c                 |    6 +-
 drivers/net/ethernet/lantiq_xrx200.c               |    6 +-
 drivers/net/ethernet/litex/litex_liteeth.c         |    6 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   11 +-
 drivers/net/ethernet/marvell/mvmdio.c              |    6 +-
 drivers/net/ethernet/marvell/mvneta.c              |    8 +-
 drivers/net/ethernet/marvell/mvneta_bm.c           |    6 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   12 +-
 .../net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c |  168 +-
 .../net/ethernet/marvell/octeon_ep/octep_config.h  |   22 +-
 .../ethernet/marvell/octeon_ep/octep_ctrl_net.c    |   24 +-
 .../ethernet/marvell/octeon_ep/octep_ctrl_net.h    |   18 +
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |  213 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.h    |   13 +-
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h         |    4 +
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.h  |    3 +
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h  |    4 +
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    8 +-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   11 +-
 drivers/net/ethernet/marvell/octeontx2/af/npc.h    |    8 +
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c    |   88 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cgx.c    |    7 +-
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |   53 +
 .../ethernet/marvell/octeontx2/af/rvu_devlink.c    |  464 +--
 .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c |   62 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |    2 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_ptp.c  |   31 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |   58 +
 drivers/net/ethernet/marvell/pxa168_eth.c          |    5 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   11 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |    2 +-
 drivers/net/ethernet/mediatek/mtk_ppe.c            |    4 +-
 drivers/net/ethernet/mediatek/mtk_ppe.h            |   19 +-
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |   12 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            | 1432 +++++--
 drivers/net/ethernet/mediatek/mtk_wed.h            |   57 +
 drivers/net/ethernet/mediatek/mtk_wed_debugfs.c    |  400 +-
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c        |  152 +-
 drivers/net/ethernet/mediatek/mtk_wed_regs.h       |  369 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.h         |    3 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |    2 +-
 drivers/net/ethernet/mellanox/mlx4/fw.c            |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |    8 +
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    3 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   70 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |  122 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |   11 -
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   49 +-
 .../mellanox/mlx5/core/diag/reporter_vnic.c        |  118 +-
 .../mellanox/mlx5/core/diag/reporter_vnic.h        |    6 +-
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |  432 ++
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   13 +-
 .../net/ethernet/mellanox/mlx5/core/en/devlink.c   |    8 +
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |    1 -
 .../net/ethernet/mellanox/mlx5/core/en/health.c    |  187 +-
 .../net/ethernet/mellanox/mlx5/core/en/health.h    |   14 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |  418 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |  342 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c   |   32 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h   |    9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c   |  152 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h   |   20 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    |  105 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   26 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |   25 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  146 +-
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |    3 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |    1 -
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |    8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   97 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |   32 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   16 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge_mcast.c |   11 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |   96 +-
 drivers/net/ethernet/mellanox/mlx5/core/events.c   |    5 -
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   10 +-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |  129 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |   24 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   47 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |    1 +
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |   27 +-
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |   10 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |   25 +
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |    6 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h   |    1 -
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c         |  542 ++-
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.h         |   14 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   33 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   36 +-
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c   |  101 +-
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.h   |    6 +
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |   26 +
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |  244 +-
 .../ethernet/mellanox/mlx5/core/sf/vhca_event.c    |   69 +-
 .../ethernet/mellanox/mlx5/core/sf/vhca_event.h    |    3 +
 .../mellanox/mlx5/core/steering/dr_action.c        |   35 +-
 .../mellanox/mlx5/core/steering/dr_types.h         |    5 +-
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |    9 +-
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |    6 +-
 drivers/net/ethernet/mellanox/mlxsw/cmd.h          |   43 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         |  178 +-
 drivers/net/ethernet/mellanox/mlxsw/core.h         |    6 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c   |   72 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.h   |   15 +-
 drivers/net/ethernet/mellanox/mlxsw/core_env.c     |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c   |    2 +-
 .../ethernet/mellanox/mlxsw/core_linecard_dev.c    |    9 +-
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |    3 +-
 drivers/net/ethernet/mellanox/mlxsw/i2c.c          |    4 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |   37 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h          |   20 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |   95 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |    3 +-
 .../ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c    |   20 +-
 .../mellanox/mlxsw/spectrum_acl_bloom_filter.c     |    2 +-
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c        |   30 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c |    2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_ethtool.c |    2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c |   93 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_pgt.c |   20 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |    2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_span.c    |    2 +-
 drivers/net/ethernet/micrel/ks8842.c               |    5 +-
 drivers/net/ethernet/micrel/ks8851_par.c           |    6 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |    3 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |   51 +-
 drivers/net/ethernet/microchip/lan743x_main.h      |    8 +
 drivers/net/ethernet/microchip/lan743x_ptp.c       |    9 +
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |    7 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |    3 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |    6 +-
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.c |    2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |    5 +-
 drivers/net/ethernet/moxa/moxart_ether.c           |    6 +-
 drivers/net/ethernet/mscc/ocelot_vsc7514.c         |    6 +-
 drivers/net/ethernet/natsemi/jazzsonic.c           |    6 +-
 drivers/net/ethernet/natsemi/macsonic.c            |    6 +-
 drivers/net/ethernet/natsemi/xtsonic.c             |    6 +-
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c  |   45 +-
 drivers/net/ethernet/netronome/nfp/nfd3/dp.c       |    2 +-
 drivers/net/ethernet/netronome/nfp/nfd3/xsk.c      |    2 +-
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c       |    2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.h  |    2 +-
 .../net/ethernet/netronome/nfp/nfpcore/nfp_nsp.h   |    2 +-
 .../ethernet/netronome/nfp/nfpcore/nfp_resource.c  |    2 +-
 drivers/net/ethernet/ni/nixge.c                    |   11 +-
 drivers/net/ethernet/nxp/lpc_eth.c                 |    6 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |    3 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   12 +
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |    4 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |   77 +-
 drivers/net/ethernet/qlogic/qed/qed_debug.c        |    7 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c      |    6 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |   46 +-
 drivers/net/ethernet/qualcomm/emac/emac.c          |    6 +-
 drivers/net/ethernet/realtek/r8169_main.c          |    4 +
 drivers/net/ethernet/renesas/Kconfig               |    9 +-
 drivers/net/ethernet/renesas/Makefile              |    4 +-
 drivers/net/ethernet/renesas/ravb_main.c           |    6 +-
 drivers/net/ethernet/renesas/rswitch.c             |   55 +-
 drivers/net/ethernet/renesas/rswitch.h             |    2 +-
 drivers/net/ethernet/renesas/sh_eth.c              |    6 +-
 .../net/ethernet/samsung/sxgbe/sxgbe_platform.c    |    6 +-
 drivers/net/ethernet/seeq/sgiseeq.c                |    6 +-
 drivers/net/ethernet/sfc/efx_channels.c            |    2 +-
 drivers/net/ethernet/sfc/mae.c                     |   62 +-
 drivers/net/ethernet/sfc/mcdi.c                    |    3 +-
 drivers/net/ethernet/sfc/ptp.c                     |   27 +-
 drivers/net/ethernet/sfc/siena/efx_channels.c      |    2 +-
 drivers/net/ethernet/sfc/tc.c                      |  337 +-
 drivers/net/ethernet/sfc/tc.h                      |    8 +
 drivers/net/ethernet/sfc/tc_conntrack.c            |   91 +-
 drivers/net/ethernet/sgi/ioc3-eth.c                |    6 +-
 drivers/net/ethernet/sgi/meth.c                    |    6 +-
 drivers/net/ethernet/smsc/smc91x.c                 |    6 +-
 drivers/net/ethernet/smsc/smsc911x.c               |    6 +-
 drivers/net/ethernet/socionext/netsec.c            |    8 +-
 drivers/net/ethernet/socionext/sni_ave.c           |    6 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 drivers/net/ethernet/stmicro/stmmac/common.h       |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    |   10 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |   15 +-
 .../net/ethernet/stmicro/stmmac/dwmac-generic.c    |   15 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |   13 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    |   33 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |   34 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |    1 -
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |   27 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson1.c  |  209 +
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    |   19 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c  |   25 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |   53 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   14 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   16 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |   10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |   14 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |  148 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |   23 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |   10 +-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |   18 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |    2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   50 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   75 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |    5 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c   |   34 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h   |    2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |    2 +-
 drivers/net/ethernet/sun/niu.c                     |    5 +-
 drivers/net/ethernet/sun/sunbmac.c                 |    6 +-
 drivers/net/ethernet/sun/sunqe.c                   |    6 +-
 drivers/net/ethernet/sunplus/spl2sw_driver.c       |    6 +-
 drivers/net/ethernet/ti/Kconfig                    |    9 +-
 drivers/net/ethernet/ti/Makefile                   |    1 -
 drivers/net/ethernet/ti/cpmac.c                    | 1251 ------
 drivers/net/ethernet/ti/cpsw_priv.c                |    2 +-
 drivers/net/ethernet/ti/davinci_emac.c             |   40 +-
 drivers/net/ethernet/ti/davinci_mdio.c             |    6 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c       |   14 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |   49 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |    2 +
 drivers/net/ethernet/ti/netcp_core.c               |    5 +-
 drivers/net/ethernet/ti/netcp_ethss.c              |    4 +-
 drivers/net/ethernet/toshiba/spider_net.c          |    2 +-
 drivers/net/ethernet/toshiba/tc35815.c             |   10 +-
 drivers/net/ethernet/tundra/tsi108_eth.c           |    6 +-
 drivers/net/ethernet/via/via-rhine.c               |    6 +-
 drivers/net/ethernet/via/via-velocity.c            |    6 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |  169 +
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.h    |    8 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |  191 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.h         |    9 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   20 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   82 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c   |    5 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_hw.c        |    2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |    7 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c      |  119 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h      |    3 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c |    5 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      |  110 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.h      |    1 -
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |   10 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |   56 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |    6 -
 drivers/net/ethernet/wiznet/w5100-spi.c            |   12 +-
 drivers/net/ethernet/wiznet/w5100.c                |   10 +-
 drivers/net/ethernet/wiznet/w5300.c                |    5 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c        |    5 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    6 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c      |    8 +-
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |   74 +-
 drivers/net/fjes/fjes_main.c                       |    2 +-
 drivers/net/geneve.c                               |  207 +-
 drivers/net/gtp.c                                  |    4 +-
 drivers/net/hamradio/Kconfig                       |   15 +-
 drivers/net/hamradio/baycom_epp.c                  |    4 +-
 drivers/net/hyperv/netvsc.c                        |   18 +-
 drivers/net/ipa/ipa_power.c                        |    2 +-
 drivers/net/ipvlan/ipvlan_core.c                   |    8 +-
 drivers/net/ipvlan/ipvlan_main.c                   |    1 +
 drivers/net/macsec.c                               |    6 +-
 drivers/net/mctp/Kconfig                           |    9 +
 drivers/net/mctp/Makefile                          |    1 +
 drivers/net/mctp/mctp-i3c.c                        |  755 ++++
 drivers/net/mdio/mdio-aspeed.c                     |    6 +-
 drivers/net/mdio/mdio-bcm-iproc.c                  |    6 +-
 drivers/net/mdio/mdio-bcm-unimac.c                 |    6 +-
 drivers/net/mdio/mdio-gpio.c                       |    6 +-
 drivers/net/mdio/mdio-hisi-femac.c                 |    6 +-
 drivers/net/mdio/mdio-ipq4019.c                    |    6 +-
 drivers/net/mdio/mdio-ipq8064.c                    |    7 +-
 drivers/net/mdio/mdio-moxart.c                     |    6 +-
 drivers/net/mdio/mdio-mscc-miim.c                  |    6 +-
 drivers/net/mdio/mdio-mux-bcm-iproc.c              |    6 +-
 drivers/net/mdio/mdio-mux-bcm6368.c                |    6 +-
 drivers/net/mdio/mdio-mux-gpio.c                   |    5 +-
 drivers/net/mdio/mdio-mux-meson-g12a.c             |    6 +-
 drivers/net/mdio/mdio-mux-meson-gxl.c              |    6 +-
 drivers/net/mdio/mdio-mux-mmioreg.c                |    6 +-
 drivers/net/mdio/mdio-mux-multiplexer.c            |    6 +-
 drivers/net/mdio/mdio-octeon.c                     |    5 +-
 drivers/net/mdio/mdio-sun4i.c                      |    6 +-
 drivers/net/mdio/mdio-xgene.c                      |   27 +-
 drivers/net/netconsole.c                           |  155 +-
 drivers/net/netdevsim/bus.c                        |   12 +
 drivers/net/netdevsim/health.c                     |  118 +-
 drivers/net/netkit.c                               |  936 +++++
 drivers/net/pcs/pcs-xpcs.c                         |   29 +
 drivers/net/pcs/pcs-xpcs.h                         |    2 +
 drivers/net/phy/Kconfig                            |    4 +-
 drivers/net/phy/amd.c                              |   33 +-
 drivers/net/phy/ax88796b.c                         |    2 +-
 drivers/net/phy/broadcom.c                         |  156 +-
 drivers/net/phy/dp83867.c                          |  137 +
 drivers/net/phy/micrel.c                           |   22 +
 drivers/net/phy/nxp-tja11xx.c                      |    6 +-
 drivers/net/phy/phy.c                              |  207 +-
 drivers/net/phy/phylink.c                          |   45 +-
 drivers/net/phy/sfp.c                              |   41 +-
 drivers/net/phy/smsc.c                             |    6 +-
 drivers/net/ppp/pppoe.c                            |    2 +-
 drivers/net/usb/lan78xx.c                          |    2 +-
 drivers/net/usb/r8152.c                            |   85 +-
 drivers/net/usb/sr9800.c                           |    4 +-
 drivers/net/veth.c                                 |   25 +-
 drivers/net/virtio_net.c                           |  258 +-
 drivers/net/vxlan/vxlan_core.c                     |  452 ++-
 drivers/net/vxlan/vxlan_mdb.c                      |  190 +-
 drivers/net/vxlan/vxlan_private.h                  |    2 +
 drivers/net/wan/ixp4xx_hss.c                       |    4 +-
 drivers/net/wireless/ath/ar5523/ar5523.c           |    2 +-
 drivers/net/wireless/ath/ath10k/ce.h               |    2 +-
 drivers/net/wireless/ath/ath10k/debug.c            |   49 +-
 drivers/net/wireless/ath/ath10k/htt.h              |    3 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |    1 -
 drivers/net/wireless/ath/ath10k/htt_tx.c           |   16 +-
 drivers/net/wireless/ath/ath10k/mac.c              |   26 +-
 drivers/net/wireless/ath/ath10k/pci.c              |    2 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |   18 +-
 drivers/net/wireless/ath/ath10k/spectral.c         |   26 +-
 drivers/net/wireless/ath/ath11k/Makefile           |    3 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   10 +-
 drivers/net/wireless/ath/ath11k/core.c             |  127 +-
 drivers/net/wireless/ath/ath11k/core.h             |   23 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |    8 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |   30 +-
 drivers/net/wireless/ath/ath11k/dp.c               |    2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   39 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |    4 +-
 drivers/net/wireless/ath/ath11k/fw.c               |  168 +
 drivers/net/wireless/ath/ath11k/fw.h               |   27 +
 drivers/net/wireless/ath/ath11k/hal.c              |    8 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |   31 +-
 drivers/net/wireless/ath/ath11k/hal_rx.h           |   18 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c           |    2 +-
 drivers/net/wireless/ath/ath11k/hif.h              |   54 +-
 drivers/net/wireless/ath/ath11k/htc.h              |   12 -
 drivers/net/wireless/ath/ath11k/mac.c              |  116 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |   19 +-
 drivers/net/wireless/ath/ath11k/pci.c              |   24 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |    6 +-
 drivers/net/wireless/ath/ath11k/peer.c             |    2 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |   54 +-
 drivers/net/wireless/ath/ath11k/reg.c              |   11 +
 drivers/net/wireless/ath/ath11k/reg.h              |    3 +
 drivers/net/wireless/ath/ath11k/spectral.c         |   28 +-
 drivers/net/wireless/ath/ath11k/thermal.c          |   22 +-
 drivers/net/wireless/ath/ath11k/thermal.h          |    8 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   70 +-
 drivers/net/wireless/ath/ath12k/core.c             |  137 +-
 drivers/net/wireless/ath/ath12k/core.h             |   31 +-
 drivers/net/wireless/ath/ath12k/debug.c            |    2 +-
 drivers/net/wireless/ath/ath12k/dp.c               |    1 +
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   16 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   55 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   16 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   12 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |    2 -
 drivers/net/wireless/ath/ath12k/hif.h              |   18 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   24 +-
 drivers/net/wireless/ath/ath12k/hw.h               |    6 +
 drivers/net/wireless/ath/ath12k/mac.c              |  311 +-
 drivers/net/wireless/ath/ath12k/mac.h              |    2 +
 drivers/net/wireless/ath/ath12k/mhi.c              |   12 +-
 drivers/net/wireless/ath/ath12k/pci.c              |    4 +-
 drivers/net/wireless/ath/ath12k/peer.h             |    3 +
 drivers/net/wireless/ath/ath12k/qmi.c              |   12 +
 drivers/net/wireless/ath/ath12k/qmi.h              |    1 +
 drivers/net/wireless/ath/ath12k/reg.c              |   14 +
 drivers/net/wireless/ath/ath12k/reg.h              |    6 +
 drivers/net/wireless/ath/ath12k/rx_desc.h          |   91 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  131 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   28 +
 drivers/net/wireless/ath/ath5k/base.c              |    6 +-
 drivers/net/wireless/ath/ath5k/led.c               |    3 +-
 drivers/net/wireless/ath/ath5k/pci.c               |    4 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |    8 +-
 drivers/net/wireless/ath/ath6kl/init.c             |    2 +-
 drivers/net/wireless/ath/ath6kl/main.c             |    4 +-
 drivers/net/wireless/ath/ath6kl/txrx.c             |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.c        |   11 +-
 drivers/net/wireless/ath/ath9k/debug.c             |    2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   34 +-
 drivers/net/wireless/ath/ath9k/hif_usb.h           |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c     |    2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |    2 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |    2 +-
 drivers/net/wireless/ath/carl9170/usb.c            |   10 +-
 drivers/net/wireless/ath/dfs_pattern_detector.c    |   21 +-
 drivers/net/wireless/ath/wcn36xx/dxe.c             |    6 +-
 drivers/net/wireless/ath/wcn36xx/smd.c             |   20 +-
 drivers/net/wireless/ath/wcn36xx/smd.h             |    2 +-
 drivers/net/wireless/ath/wcn36xx/testmode.c        |    2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |    3 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |    2 -
 drivers/net/wireless/atmel/atmel.c                 |   72 -
 drivers/net/wireless/broadcom/b43/dma.c            |    4 +-
 drivers/net/wireless/broadcom/b43/pio.c            |    2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    5 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c         |    6 +-
 .../broadcom/brcm80211/brcmfmac/firmware.h         |    2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fweh.c    |    6 +-
 .../broadcom/brcm80211/brcmfmac/fwil_types.h       |    2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |   20 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |   23 +-
 drivers/net/wireless/intel/ipw2x00/libipw.h        |    2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |    2 +-
 drivers/net/wireless/intel/iwlegacy/common.c       |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   16 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   12 +-
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h  |   33 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h       |   14 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |    6 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rs.h        |   12 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h        |    9 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c        |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   42 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |    8 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |   30 +
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |   46 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   38 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |   22 +
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   10 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   68 +-
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |    6 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h    |    7 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |   16 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h  |  153 +-
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |   78 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/txq.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  203 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    1 +
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   14 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   32 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.h        |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/notif-wait.h |    3 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c         |    1 -
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    4 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |   50 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |   17 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   10 +-
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h |   10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    2 +
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h   |    5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h  |    8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   90 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |    2 +-
 .../net/wireless/intel/iwlwifi/iwl-eeprom-parse.c  |    5 +-
 .../net/wireless/intel/iwlwifi/iwl-eeprom-parse.h  |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        |   13 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   83 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |   19 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |   20 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   24 +-
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h   |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    2 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  177 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   78 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  148 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.h   |    1 +
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  141 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   30 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  572 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |   16 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  266 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   25 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  176 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   44 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |   68 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |    5 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h        |   23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |  157 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  335 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   39 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |    7 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  200 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.h    |   21 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |    7 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |  130 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   61 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |    7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   59 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   12 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |    6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   46 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |    9 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.h      |    8 +-
 drivers/net/wireless/intersil/hostap/hostap.h      |    1 -
 .../net/wireless/intersil/hostap/hostap_download.c |    3 +-
 .../net/wireless/intersil/hostap/hostap_ioctl.c    |  228 --
 drivers/net/wireless/intersil/hostap/hostap_main.c |    3 -
 drivers/net/wireless/intersil/hostap/hostap_wlan.h |    2 +-
 drivers/net/wireless/intersil/p54/p54.h            |    2 +-
 drivers/net/wireless/legacy/ray_cs.c               |    6 +-
 drivers/net/wireless/marvell/mwifiex/11h.c         |    4 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    3 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |    4 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |  322 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   10 -
 drivers/net/wireless/marvell/mwifiex/sdio.h        |    4 -
 drivers/net/wireless/mediatek/mt76/Kconfig         |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile        |    1 +
 drivers/net/wireless/mediatek/mt76/debugfs.c       |    2 -
 drivers/net/wireless/mediatek/mt76/dma.c           |   14 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c        |    7 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   64 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |   36 +-
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c |   80 +-
 drivers/net/wireless/mediatek/mt76/mt7603/core.c   |    2 +
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   |    8 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c    |   52 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h   |    5 +
 drivers/net/wireless/mediatek/mt76/mt7615/init.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7615/pci_mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76_connac.h   |    6 +
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |   18 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mac.c   |   28 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |  191 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.h   |   60 +-
 .../net/wireless/mediatek/mt76/mt76x02_beacon.c    |    8 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  |   11 +-
 .../net/wireless/mediatek/mt76/mt76x02_usb_core.c  |   13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c   |   33 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   53 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |   79 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |   18 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |    4 +
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h   |    1 +
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c    |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7921/init.c   |   57 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |   78 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |  155 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h    |   13 +
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h |   18 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |    2 +
 .../net/wireless/mediatek/mt76/mt7921/pci_mac.c    |    2 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio_mcu.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7925/Kconfig  |   30 +
 drivers/net/wireless/mediatek/mt76/mt7925/Makefile |    9 +
 .../net/wireless/mediatek/mt76/mt7925/debugfs.c    |  319 ++
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |  235 ++
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c    | 1452 +++++++
 drivers/net/wireless/mediatek/mt76/mt7925/mac.h    |   23 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   | 1454 +++++++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    | 3174 +++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |  537 +++
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |  309 ++
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c    |  586 +++
 .../net/wireless/mediatek/mt76/mt7925/pci_mac.c    |  148 +
 .../net/wireless/mediatek/mt76/mt7925/pci_mcu.c    |   53 +
 drivers/net/wireless/mediatek/mt76/mt7925/regs.h   |   92 +
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c    |  332 ++
 drivers/net/wireless/mediatek/mt76/mt792x.h        |   38 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |   30 +-
 drivers/net/wireless/mediatek/mt76/mt792x_dma.c    |   49 +-
 drivers/net/wireless/mediatek/mt76/mt792x_usb.c    |    9 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   53 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |  115 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   65 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  359 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   37 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/regs.h   |    8 +
 drivers/net/wireless/mediatek/mt76/tx.c            |  108 +-
 drivers/net/wireless/mediatek/mt7601u/tx.c         |    2 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |    4 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   20 +-
 drivers/net/wireless/microchip/wilc1000/netdev.h   |    2 +
 drivers/net/wireless/microchip/wilc1000/wlan.c     |    2 +-
 drivers/net/wireless/purelifi/plfxlc/mac.c         |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |    4 +-
 drivers/net/wireless/quantenna/qtnfmac/commands.c  |    5 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c      |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c     |    4 +-
 drivers/net/wireless/ralink/rt2x00/rt2800.h        |   18 +
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |  310 +-
 drivers/net/wireless/ralink/rt2x00/rt2800mmio.c    |    3 +
 drivers/net/wireless/ralink/rt2x00/rt2x00.h        |    6 +
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |    2 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |    2 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |    6 -
 drivers/net/wireless/realtek/rtlwifi/core.c        |   18 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c          |   17 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/dm.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/hw.c    |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8188ee/trx.c   |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/trx.h   |    1 -
 .../wireless/realtek/rtlwifi/rtl8192c/dm_common.c  |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/hw.c    |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8192ce/trx.c   |    9 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/trx.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   |   34 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.h   |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/dm.c    |   18 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/fw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/dm.c    |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.c   |   16 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.h   |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8192se/fw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/trx.c   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/trx.h   |    4 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/dm.c    |    2 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c   |   16 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/hw.c    |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8723ae/trx.c   |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/trx.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8723be/dm.c    |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |    6 -
 .../net/wireless/realtek/rtlwifi/rtl8723be/trx.c   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8723be/trx.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/dm.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/trx.c   |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/trx.h   |    1 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   15 +-
 drivers/net/wireless/realtek/rtw88/debug.c         |    4 +-
 drivers/net/wireless/realtek/rtw88/debug.h         |   12 +
 drivers/net/wireless/realtek/rtw88/fw.c            |   74 +
 drivers/net/wireless/realtek/rtw88/fw.h            |    3 +
 drivers/net/wireless/realtek/rtw88/main.h          |   10 +-
 drivers/net/wireless/realtek/rtw88/ps.c            |    2 +
 drivers/net/wireless/realtek/rtw88/reg.h           |   23 +
 drivers/net/wireless/realtek/rtw88/regd.c          |   24 +-
 drivers/net/wireless/realtek/rtw88/regd.h          |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |   67 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.h      |    1 +
 .../net/wireless/realtek/rtw88/rtw8821c_table.c    | 1154 ++++--
 .../net/wireless/realtek/rtw88/rtw8822c_table.c    | 1239 +++---
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c     |    4 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |    9 +-
 drivers/net/wireless/realtek/rtw89/chan.c          | 1576 ++++++-
 drivers/net/wireless/realtek/rtw89/chan.h          |   34 +
 drivers/net/wireless/realtek/rtw89/coex.c          |   25 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  465 ++-
 drivers/net/wireless/realtek/rtw89/core.h          |  429 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |  286 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  712 +++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  144 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  211 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   49 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   19 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  397 ++
 drivers/net/wireless/realtek/rtw89/pci.c           |    3 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  535 ++-
 drivers/net/wireless/realtek/rtw89/phy.h           |  136 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |  576 +++
 drivers/net/wireless/realtek/rtw89/reg.h           |  409 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |    4 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   29 +-
 .../net/wireless/realtek/rtw89/rtw8851b_table.c    | 1347 +++---
 .../net/wireless/realtek/rtw89/rtw8851b_table.h    |    3 -
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   28 +-
 .../net/wireless/realtek/rtw89/rtw8852a_table.c    |    2 +
 .../net/wireless/realtek/rtw89/rtw8852a_table.h    |    1 -
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   37 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.c    |  333 +-
 .../net/wireless/realtek/rtw89/rtw8852b_table.h    |    3 -
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   57 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |  107 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h  |    3 +
 .../wireless/realtek/rtw89/rtw8852c_rfk_table.c    |   42 +-
 .../net/wireless/realtek/rtw89/rtw8852c_table.c    | 3782 +++++++++++++++--
 .../net/wireless/realtek/rtw89/rtw8852c_table.h    |    3 -
 drivers/net/wireless/realtek/rtw89/txrx.h          |  271 ++
 drivers/net/wireless/realtek/rtw89/wow.c           |    4 +-
 drivers/net/wireless/silabs/wfx/data_tx.c          |  125 +-
 drivers/net/wireless/silabs/wfx/data_tx.h          |   21 +-
 drivers/net/wireless/silabs/wfx/hif_tx.c           |   43 +
 drivers/net/wireless/silabs/wfx/hif_tx.h           |    1 +
 drivers/net/wireless/silabs/wfx/main.c             |    5 +
 drivers/net/wireless/silabs/wfx/queue.c            |   38 +-
 drivers/net/wireless/silabs/wfx/queue.h            |    1 +
 drivers/net/wireless/silabs/wfx/scan.c             |   66 +-
 drivers/net/wireless/silabs/wfx/scan.h             |    6 +
 drivers/net/wireless/silabs/wfx/sta.c              |   41 +-
 drivers/net/wireless/silabs/wfx/sta.h              |    1 -
 drivers/net/wireless/silabs/wfx/wfx.h              |    8 +-
 drivers/net/wireless/st/cw1200/txrx.c              |    4 +-
 drivers/net/wireless/ti/wl1251/main.c              |    2 +-
 drivers/net/wireless/ti/wl1251/tx.c                |    6 +-
 drivers/net/wireless/ti/wl12xx/main.c              |    6 +-
 drivers/net/wireless/ti/wl18xx/main.c              |    7 +-
 drivers/net/wireless/ti/wlcore/boot.c              |    5 +-
 drivers/net/wireless/ti/wlcore/event.c             |    2 +-
 drivers/net/wireless/ti/wlcore/main.c              |   16 +-
 drivers/net/wireless/ti/wlcore/wlcore.h            |    2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   58 +-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |   19 +-
 drivers/net/wwan/iosm/iosm_ipc_chnl_cfg.h          |    2 +-
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.h          |    4 +-
 drivers/net/wwan/iosm/iosm_ipc_mux.h               |    2 +-
 drivers/net/wwan/iosm/iosm_ipc_pm.h                |    2 +-
 drivers/net/wwan/iosm/iosm_ipc_port.h              |    2 +-
 drivers/net/wwan/iosm/iosm_ipc_trace.h             |    2 +-
 drivers/net/wwan/rpmsg_wwan_ctrl.c                 |    2 +-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c         |    2 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c         |    3 +-
 drivers/net/wwan/t7xx/t7xx_state_monitor.h         |    2 +-
 drivers/net/wwan/wwan_core.c                       |    9 +-
 drivers/net/xen-netback/interface.c                |    5 +-
 drivers/ptp/Kconfig                                |    1 +
 drivers/ptp/ptp_chardev.c                          |  129 +-
 drivers/ptp/ptp_clock.c                            |   45 +-
 drivers/ptp/ptp_ocp.c                              |  369 +-
 drivers/ptp/ptp_private.h                          |   28 +-
 drivers/ptp/ptp_sysfs.c                            |   15 +-
 drivers/s390/net/ctcm_main.c                       |    4 +-
 drivers/s390/net/qeth_core_main.c                  |    2 +-
 drivers/ssb/Kconfig                                |    3 +-
 drivers/ssb/main.c                                 |    2 +-
 drivers/staging/qlge/qlge_devlink.c                |   60 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    9 +-
 drivers/vhost/vsock.c                              |   21 +-
 include/linux/avf/virtchnl.h                       |   15 +-
 include/linux/bpf-cgroup-defs.h                    |    5 +
 include/linux/bpf-cgroup.h                         |   90 +-
 include/linux/bpf.h                                |   64 +-
 include/linux/bpf_mem_alloc.h                      |    1 +
 include/linux/bpf_verifier.h                       |   44 +-
 include/linux/brcmphy.h                            |   10 +
 include/linux/btf.h                                |    1 +
 include/linux/can/dev.h                            |    4 +
 include/linux/ceph/mon_client.h                    |    2 +-
 include/linux/cgroup.h                             |   12 +-
 include/linux/compiler_types.h                     |   32 +-
 include/linux/dpll.h                               |  170 +
 include/linux/dsa/sja1105.h                        |    2 +-
 include/linux/ethtool.h                            |   19 +
 include/linux/filter.h                             |   67 +-
 include/linux/fortify-string.h                     |    4 -
 include/linux/i3c/master.h                         |   11 +
 include/linux/ieee80211.h                          |  106 +-
 include/linux/igmp.h                               |    2 +-
 include/linux/ipv6.h                               |   50 +-
 include/linux/kasan.h                              |    2 +
 include/linux/linkmode.h                           |   18 +-
 include/linux/micrel_phy.h                         |    4 +
 include/linux/mlx5/device.h                        |    3 +
 include/linux/mlx5/driver.h                        |   20 +-
 include/linux/mlx5/fs.h                            |    1 +
 include/linux/mlx5/mlx5_ifc.h                      |  131 +-
 include/linux/mm_types.h                           |   13 +-
 include/linux/netdevice.h                          |  100 +-
 include/linux/netfilter.h                          |   10 +
 include/linux/overflow.h                           |   35 +
 include/linux/pci_ids.h                            |    2 +
 include/linux/pds/pds_core_if.h                    |    1 +
 include/linux/percpu.h                             |    1 +
 include/linux/phy.h                                |    1 +
 include/linux/phylink.h                            |   56 +-
 include/linux/posix-clock.h                        |   35 +-
 include/linux/soc/mediatek/mtk_wed.h               |   76 +-
 include/linux/socket.h                             |    1 +
 include/linux/sockptr.h                            |   23 +
 include/linux/stmmac.h                             |    2 +-
 include/linux/tcp.h                                |   61 +-
 include/linux/trace_events.h                       |    6 +-
 include/linux/udp.h                                |   66 +-
 include/linux/virtio_vsock.h                       |   10 +
 include/net/Space.h                                |    1 -
 include/net/af_vsock.h                             |    7 +
 include/net/bluetooth/bluetooth.h                  |    2 +-
 include/net/bluetooth/hci.h                        |    3 +
 include/net/bluetooth/hci_core.h                   |   74 +-
 include/net/bluetooth/hci_sync.h                   |    2 +
 include/net/cfg80211.h                             |  257 +-
 include/net/devlink.h                              |   61 +-
 include/net/dropreason-core.h                      |   33 +
 include/net/dsa.h                                  |   69 +-
 include/net/dsa_stubs.h                            |   22 +-
 include/net/dst.h                                  |   11 +-
 include/net/flow_offload.h                         |    2 +-
 include/net/ieee80211_radiotap.h                   |    6 +
 include/net/if_inet6.h                             |    2 +-
 include/net/inet_connection_sock.h                 |   22 +-
 include/net/inet_sock.h                            |   11 +-
 include/net/inet_timewait_sock.h                   |    3 +-
 include/net/ip.h                                   |   15 +-
 include/net/ip6_route.h                            |   19 +-
 include/net/ip_fib.h                               |    2 +-
 include/net/ipv6.h                                 |   42 +-
 include/net/ipv6_stubs.h                           |    5 +
 include/net/mac80211.h                             |  134 +-
 include/net/mana/hw_channel.h                      |    2 +-
 include/net/mana/mana.h                            |    2 +-
 include/net/net_namespace.h                        |   15 +-
 include/net/netfilter/nf_conntrack.h               |   14 +-
 include/net/netfilter/nf_conntrack_labels.h        |    2 +-
 include/net/netfilter/nf_tables.h                  |   67 +-
 include/net/netkit.h                               |   38 +
 include/net/netlink.h                              |   73 +-
 include/net/netns/conntrack.h                      |    2 +-
 include/net/netns/ipv4.h                           |    3 +
 include/net/nexthop.h                              |    8 +-
 include/net/page_pool/helpers.h                    |  226 +-
 include/net/page_pool/types.h                      |    6 +-
 include/net/pkt_cls.h                              |    6 +
 include/net/pkt_sched.h                            |    8 +-
 include/net/regulatory.h                           |    1 +
 include/net/route.h                                |   10 +-
 include/net/sch_generic.h                          |    4 +-
 include/net/sock.h                                 |   41 +-
 include/net/tc_act/tc_ct.h                         |    1 +
 include/net/tcp.h                                  |  371 +-
 include/net/tcp_ao.h                               |  362 ++
 include/net/tcx.h                                  |    7 +-
 include/net/tls.h                                  |   21 +-
 include/net/udp_tunnel.h                           |   30 +-
 include/net/udplite.h                              |   14 +-
 include/net/xdp.h                                  |   19 +-
 include/net/xdp_sock.h                             |   18 +
 include/net/xfrm.h                                 |    2 +-
 include/trace/events/mptcp.h                       |    2 +-
 .../trace/events/vsock_virtio_transport_common.h   |   12 +-
 include/uapi/linux/bpf.h                           |   52 +-
 include/uapi/linux/devlink.h                       |    3 +-
 include/uapi/linux/dpll.h                          |  207 +
 include/uapi/linux/if_bridge.h                     |   18 +
 include/uapi/linux/if_link.h                       |   32 +-
 include/uapi/linux/mptcp.h                         |  172 +-
 include/uapi/linux/mptcp_pm.h                      |  150 +
 include/uapi/linux/netdev.h                        |   16 +
 include/uapi/linux/netlink.h                       |    5 +
 include/uapi/linux/nl80211.h                       |   43 +-
 include/uapi/linux/pkt_sched.h                     |   15 +-
 include/uapi/linux/ptp_clock.h                     |    2 +
 include/uapi/linux/rtnetlink.h                     |   16 +-
 include/uapi/linux/snmp.h                          |    8 +-
 include/uapi/linux/tcp.h                           |  118 +
 include/uapi/linux/vm_sockets.h                    |   17 +
 kernel/bpf/bpf_iter.c                              |    2 -
 kernel/bpf/bpf_struct_ops.c                        |   26 +-
 kernel/bpf/btf.c                                   |   35 +-
 kernel/bpf/cgroup.c                                |   28 +-
 kernel/bpf/cgroup_iter.c                           |   65 +
 kernel/bpf/core.c                                  |   37 +-
 kernel/bpf/cpumap.c                                |   10 +
 kernel/bpf/devmap.c                                |   10 +
 kernel/bpf/hashtab.c                               |    7 +-
 kernel/bpf/helpers.c                               |  113 +-
 kernel/bpf/memalloc.c                              |   72 +-
 kernel/bpf/offload.c                               |   18 +-
 kernel/bpf/ringbuf.c                               |    3 +-
 kernel/bpf/stackmap.c                              |    2 +-
 kernel/bpf/syscall.c                               |   71 +-
 kernel/bpf/task_iter.c                             |  282 +-
 kernel/bpf/tcx.c                                   |    4 +-
 kernel/bpf/trampoline.c                            |    4 +-
 kernel/bpf/verifier.c                              | 1293 +++++-
 kernel/cgroup/cgroup.c                             |   18 +-
 kernel/time/posix-clock.c                          |   36 +-
 kernel/trace/bpf_trace.c                           |   10 +-
 kernel/trace/trace_kprobe.c                        |   14 +-
 kernel/trace/trace_syscalls.c                      |    4 +-
 lib/nlattr.c                                       |   22 +
 lib/test_bpf.c                                     |  371 ++
 mm/kasan/kasan.h                                   |    1 -
 mm/percpu.c                                        |   35 +-
 net/Kconfig                                        |   11 +-
 net/appletalk/Kconfig                              |   30 +
 net/appletalk/aarp.c                               |    2 +-
 net/appletalk/ddp.c                                |   36 -
 net/atm/atm_sysfs.c                                |    2 -
 net/ax25/af_ax25.c                                 |    2 +-
 net/bluetooth/amp.c                                |    3 +-
 net/bluetooth/hci_conn.c                           |  123 +-
 net/bluetooth/hci_core.c                           |    3 +
 net/bluetooth/hci_event.c                          |   92 +-
 net/bluetooth/hci_sync.c                           |   36 +-
 net/bluetooth/hci_sysfs.c                          |   23 +-
 net/bluetooth/iso.c                                |   38 +-
 net/bluetooth/l2cap_sock.c                         |    2 +-
 net/bluetooth/msft.c                               |   20 +-
 net/bridge/br.c                                    |    1 +
 net/bridge/br_device.c                             |    3 +-
 net/bridge/br_fdb.c                                |   71 +-
 net/bridge/br_input.c                              |    2 +-
 net/bridge/br_mdb.c                                |  184 +-
 net/bridge/br_multicast.c                          |    5 +-
 net/bridge/br_netfilter_hooks.c                    |   98 +-
 net/bridge/br_netfilter_ipv6.c                     |    6 +-
 net/bridge/br_netlink.c                            |   17 +-
 net/bridge/br_private.h                            |   26 +-
 net/can/j1939/socket.c                             |    2 +-
 net/can/raw.c                                      |    5 +-
 net/ceph/mon_client.c                              |    2 +-
 net/core/Makefile                                  |    1 +
 net/core/dev.c                                     |  182 +-
 net/core/dev.h                                     |    6 +
 net/core/dev_ioctl.c                               |    2 +-
 net/core/dst.c                                     |   10 +-
 net/core/filter.c                                  |   83 +-
 net/core/gso_test.c                                |  278 ++
 net/core/netclassid_cgroup.c                       |    6 +
 net/core/netdev-genl.c                             |   12 +-
 net/core/page_pool.c                               |   31 +-
 net/core/pktgen.c                                  |  102 +-
 net/core/rtnetlink.c                               |  152 +-
 net/core/selftests.c                               |    9 +-
 net/core/skbuff.c                                  |   27 +-
 net/core/sock.c                                    |  228 +-
 net/core/xdp.c                                     |    4 +-
 net/dccp/ipv4.c                                    |    2 +-
 net/dccp/ipv6.c                                    |   10 +-
 net/dccp/timer.c                                   |    4 +-
 net/devlink/core.c                                 |  223 +-
 net/devlink/dev.c                                  |   60 +-
 net/devlink/devl_internal.h                        |   98 +-
 net/devlink/dpipe.c                                |   14 +-
 net/devlink/health.c                               |  411 +-
 net/devlink/linecard.c                             |   83 +-
 net/devlink/netlink.c                              |  358 +-
 net/devlink/netlink_gen.c                          |  757 +++-
 net/devlink/netlink_gen.h                          |   64 +-
 net/devlink/param.c                                |   14 +-
 net/devlink/port.c                                 |   66 +-
 net/devlink/rate.c                                 |    6 +-
 net/devlink/region.c                               |    8 +-
 net/devlink/resource.c                             |    4 +-
 net/devlink/sb.c                                   |   17 +-
 net/devlink/trap.c                                 |    9 +-
 net/dsa/Makefile                                   |    6 +-
 net/dsa/{master.c => conduit.c}                    |  118 +-
 net/dsa/conduit.h                                  |   22 +
 net/dsa/dsa.c                                      |  246 +-
 net/dsa/dsa.h                                      |   12 +-
 net/dsa/master.h                                   |   22 -
 net/dsa/netlink.c                                  |   22 +-
 net/dsa/port.c                                     |  144 +-
 net/dsa/port.h                                     |    7 +-
 net/dsa/slave.h                                    |   69 -
 net/dsa/switch.c                                   |   20 +-
 net/dsa/switch.h                                   |    8 +-
 net/dsa/tag.c                                      |   10 +-
 net/dsa/tag.h                                      |   26 +-
 net/dsa/tag_8021q.c                                |   22 +-
 net/dsa/tag_8021q.h                                |    2 +-
 net/dsa/tag_ar9331.c                               |    4 +-
 net/dsa/tag_brcm.c                                 |   14 +-
 net/dsa/tag_dsa.c                                  |    6 +-
 net/dsa/tag_gswip.c                                |    4 +-
 net/dsa/tag_hellcreek.c                            |    4 +-
 net/dsa/tag_ksz.c                                  |   20 +-
 net/dsa/tag_lan9303.c                              |    4 +-
 net/dsa/tag_mtk.c                                  |    4 +-
 net/dsa/tag_none.c                                 |    6 +-
 net/dsa/tag_ocelot.c                               |   22 +-
 net/dsa/tag_ocelot_8021q.c                         |   12 +-
 net/dsa/tag_qca.c                                  |    6 +-
 net/dsa/tag_rtl4_a.c                               |    6 +-
 net/dsa/tag_rtl8_4.c                               |    6 +-
 net/dsa/tag_rzn1_a5psw.c                           |    4 +-
 net/dsa/tag_sja1105.c                              |   30 +-
 net/dsa/tag_trailer.c                              |    4 +-
 net/dsa/tag_xrs700x.c                              |    4 +-
 net/dsa/{slave.c => user.c}                        | 1469 +++----
 net/dsa/user.h                                     |   69 +
 net/ethtool/common.c                               |   21 +
 net/handshake/genl.c                               |    2 +-
 net/handshake/netlink.c                            |    2 +-
 net/handshake/tlshd.c                              |    6 +-
 net/ipv4/Kconfig                                   |   17 +
 net/ipv4/Makefile                                  |    2 +
 net/ipv4/af_inet.c                                 |    9 +-
 net/ipv4/datagram.c                                |    6 +-
 net/ipv4/igmp.c                                    |    2 -
 net/ipv4/inet_diag.c                               |    4 +-
 net/ipv4/ip_forward.c                              |    4 +-
 net/ipv4/ip_output.c                               |   17 +-
 net/ipv4/ip_sockglue.c                             |  189 +-
 net/ipv4/netfilter/iptable_mangle.c                |    9 +-
 net/ipv4/ping.c                                    |   15 +-
 net/ipv4/proc.c                                    |    8 +-
 net/ipv4/raw.c                                     |   19 +-
 net/ipv4/route.c                                   |   54 +-
 net/ipv4/syncookies.c                              |   36 +-
 net/ipv4/sysctl_net_ipv4.c                         |   17 +
 net/ipv4/tcp.c                                     |  276 +-
 net/ipv4/tcp_ao.c                                  | 2392 +++++++++++
 net/ipv4/tcp_bbr.c                                 |   13 +-
 net/ipv4/tcp_input.c                               |  209 +-
 net/ipv4/tcp_ipv4.c                                |  384 +-
 net/ipv4/tcp_lp.c                                  |    2 +-
 net/ipv4/tcp_metrics.c                             |   22 +-
 net/ipv4/tcp_minisocks.c                           |   69 +-
 net/ipv4/tcp_output.c                              |  316 +-
 net/ipv4/tcp_sigpool.c                             |  358 ++
 net/ipv4/tcp_timer.c                               |   63 +-
 net/ipv4/udp.c                                     |  101 +-
 net/ipv4/udp_offload.c                             |    4 +-
 net/ipv4/udp_tunnel_core.c                         |   51 +-
 net/ipv4/udp_tunnel_nic.c                          |   11 +-
 net/ipv4/udplite.c                                 |    1 -
 net/ipv4/xfrm4_input.c                             |    4 +-
 net/ipv6/Makefile                                  |    1 +
 net/ipv6/addrconf.c                                |   57 +-
 net/ipv6/af_inet6.c                                |   19 +-
 net/ipv6/datagram.c                                |   15 +-
 net/ipv6/icmp.c                                    |    4 +-
 net/ipv6/inet6_connection_sock.c                   |    2 +-
 net/ipv6/ioam6_iptunnel.c                          |    2 +-
 net/ipv6/ip6_flowlabel.c                           |    8 +-
 net/ipv6/ip6_output.c                              |  171 +-
 net/ipv6/ip6_udp_tunnel.c                          |   75 +-
 net/ipv6/ipv6_sockglue.c                           |  242 +-
 net/ipv6/mcast.c                                   |   11 +-
 net/ipv6/ndisc.c                                   |    6 +-
 net/ipv6/netfilter/ip6table_mangle.c               |    9 +-
 net/ipv6/ping.c                                    |    6 +-
 net/ipv6/proc.c                                    |    3 +-
 net/ipv6/raw.c                                     |   18 +-
 net/ipv6/route.c                                   |    6 +-
 net/ipv6/syncookies.c                              |    5 +
 net/ipv6/tcp_ao.c                                  |  168 +
 net/ipv6/tcp_ipv6.c                                |  409 +-
 net/ipv6/udp.c                                     |   52 +-
 net/ipv6/udplite.c                                 |    1 -
 net/ipv6/xfrm6_input.c                             |    4 +-
 net/ipv6/xfrm6_output.c                            |    2 +-
 net/l2tp/l2tp_core.c                               |    6 +-
 net/l2tp/l2tp_eth.c                                |   34 +-
 net/l2tp/l2tp_ip6.c                                |    6 +-
 net/mac80211/Kconfig                               |   11 +
 net/mac80211/Makefile                              |    2 +
 net/mac80211/agg-rx.c                              |   63 +-
 net/mac80211/agg-tx.c                              |   63 +-
 net/mac80211/airtime.c                             |   10 +-
 net/mac80211/cfg.c                                 |  496 +--
 net/mac80211/chan.c                                |  156 +-
 net/mac80211/debugfs.c                             |   11 +-
 net/mac80211/debugfs_key.c                         |   20 +-
 net/mac80211/debugfs_netdev.c                      |  161 +-
 net/mac80211/debugfs_netdev.h                      |   15 +-
 net/mac80211/debugfs_sta.c                         |    4 +-
 net/mac80211/driver-ops.c                          |   54 +-
 net/mac80211/driver-ops.h                          |  159 +-
 net/mac80211/drop.h                                |   49 +-
 net/mac80211/ethtool.c                             |   20 +-
 net/mac80211/ht.c                                  |   60 +-
 net/mac80211/ibss.c                                |  104 +-
 net/mac80211/ieee80211_i.h                         |  223 +-
 net/mac80211/iface.c                               |  180 +-
 net/mac80211/key.c                                 |  149 +-
 net/mac80211/key.h                                 |   11 +-
 net/mac80211/link.c                                |   63 +-
 net/mac80211/main.c                                |   93 +-
 net/mac80211/mesh.c                                |   24 +-
 net/mac80211/mesh_hwmp.c                           |    2 +
 net/mac80211/mesh_pathtbl.c                        |   22 +-
 net/mac80211/mesh_plink.c                          |    6 +-
 net/mac80211/mesh_ps.c                             |    6 +-
 net/mac80211/mesh_sync.c                           |    4 +-
 net/mac80211/mlme.c                                |  709 ++--
 net/mac80211/ocb.c                                 |   19 +-
 net/mac80211/offchannel.c                          |  120 +-
 net/mac80211/pm.c                                  |   13 +-
 net/mac80211/rc80211_minstrel_ht.c                 |    7 +-
 net/mac80211/rx.c                                  |  113 +-
 net/mac80211/s1g.c                                 |   15 +-
 net/mac80211/scan.c                                |  226 +-
 net/mac80211/spectmgmt.c                           |   13 +-
 net/mac80211/sta_info.c                            |  171 +-
 net/mac80211/sta_info.h                            |   26 +-
 net/mac80211/status.c                              |  111 +-
 net/mac80211/tdls.c                                |   88 +-
 net/mac80211/tests/Makefile                        |    3 +
 net/mac80211/tests/elems.c                         |  101 +
 net/mac80211/tests/module.c                        |   10 +
 net/mac80211/trace.h                               |   11 +-
 net/mac80211/tx.c                                  |   73 +-
 net/mac80211/util.c                                |  263 +-
 net/mac80211/wep.c                                 |    9 +-
 net/mac80211/wpa.c                                 |   42 +-
 net/mptcp/Makefile                                 |    3 +-
 net/mptcp/ctrl.c                                   |   16 +
 net/mptcp/fastopen.c                               |    1 +
 net/mptcp/mptcp_pm_gen.c                           |  179 +
 net/mptcp/mptcp_pm_gen.h                           |   58 +
 net/mptcp/pm.c                                     |    2 +-
 net/mptcp/pm_netlink.c                             |  114 +-
 net/mptcp/pm_userspace.c                           |   89 +-
 net/mptcp/protocol.c                               |   75 +-
 net/mptcp/protocol.h                               |   92 +-
 net/mptcp/sockopt.c                                |   83 +-
 net/mptcp/subflow.c                                |   46 +-
 net/netfilter/core.c                               |    6 +-
 net/netfilter/ipvs/ip_vs_sync.c                    |   16 +-
 net/netfilter/nf_conntrack_core.c                  |   76 +-
 net/netfilter/nf_conntrack_helper.c                |    7 +-
 net/netfilter/nf_conntrack_labels.c                |   17 +-
 net/netfilter/nf_conntrack_proto_tcp.c             |    7 +-
 net/netfilter/nf_nat_proto.c                       |   69 +-
 net/netfilter/nf_synproxy_core.c                   |    2 +-
 net/netfilter/nf_tables_api.c                      |  578 +--
 net/netfilter/nf_tables_core.c                     |    8 +-
 net/netfilter/nf_tables_trace.c                    |    8 +-
 net/netfilter/nfnetlink_queue.c                    |   15 +-
 net/netfilter/nft_dynset.c                         |   23 +-
 net/netfilter/nft_set_bitmap.c                     |   53 +-
 net/netfilter/nft_set_hash.c                       |  109 +-
 net/netfilter/nft_set_pipapo.c                     |   80 +-
 net/netfilter/nft_set_pipapo.h                     |    4 +-
 net/netfilter/nft_set_rbtree.c                     |  200 +-
 net/netlink/genetlink.c                            |    3 +-
 net/netlink/policy.c                               |   29 +-
 net/netrom/af_netrom.c                             |    2 +-
 net/openvswitch/actions.c                          |   27 +-
 net/openvswitch/flow_table.c                       |    7 +-
 net/openvswitch/flow_table.h                       |    2 +-
 net/openvswitch/meter.h                            |    4 +-
 net/packet/internal.h                              |    2 +-
 net/rose/af_rose.c                                 |    2 +-
 net/sched/act_ct.c                                 |   41 +-
 net/sched/cls_api.c                                |   26 +-
 net/sched/cls_route.c                              |   37 +-
 net/sched/em_meta.c                                |    2 +-
 net/sched/sch_fq.c                                 |  391 +-
 net/sched/sch_fq_pie.c                             |    2 +-
 net/sched/sch_frag.c                               |    4 +-
 net/sched/sch_generic.c                            |    9 +-
 net/sched/sch_netem.c                              |    2 +-
 net/sched/sch_qfq.c                                |    4 +-
 net/sched/sch_taprio.c                             |    2 +-
 net/sctp/ipv6.c                                    |    9 +-
 net/sctp/protocol.c                                |    4 +-
 net/sctp/sm_make_chunk.c                           |    2 +-
 net/smc/af_smc.c                                   |    2 +-
 net/tipc/link.c                                    |    4 +-
 net/tls/tls.h                                      |   11 +-
 net/tls/tls_device.c                               |  101 +-
 net/tls/tls_device_fallback.c                      |   23 +-
 net/tls/tls_main.c                                 |   62 +-
 net/tls/tls_sw.c                                   |  198 +-
 net/unix/af_unix.c                                 |   58 +-
 net/vmw_vsock/af_vsock.c                           |   66 +-
 net/vmw_vsock/virtio_transport.c                   |   97 +-
 net/vmw_vsock/virtio_transport_common.c            |  305 +-
 net/vmw_vsock/vsock_loopback.c                     |    6 +
 net/wireless/Kconfig                               |   11 +
 net/wireless/Makefile                              |    1 +
 net/wireless/ap.c                                  |   24 +-
 net/wireless/chan.c                                |   55 +-
 net/wireless/core.c                                |   72 +-
 net/wireless/core.h                                |   64 +-
 net/wireless/ibss.c                                |   76 +-
 net/wireless/lib80211_crypt_tkip.c                 |   12 +-
 net/wireless/mesh.c                                |   28 +-
 net/wireless/mlme.c                                |   23 +-
 net/wireless/nl80211.c                             |  544 +--
 net/wireless/nl80211.h                             |    7 +-
 net/wireless/ocb.c                                 |   43 +-
 net/wireless/pmsr.c                                |    4 +-
 net/wireless/rdev-ops.h                            |    2 +-
 net/wireless/reg.c                                 |   99 +-
 net/wireless/reg.h                                 |   16 +-
 net/wireless/scan.c                                |  111 +-
 net/wireless/sme.c                                 |   82 +-
 net/wireless/sysfs.c                               |    4 +-
 net/wireless/tests/Makefile                        |    3 +
 net/wireless/tests/fragmentation.c                 |  157 +
 net/wireless/tests/module.c                        |   10 +
 net/wireless/trace.h                               |   80 +-
 net/wireless/util.c                                |   60 +-
 net/wireless/wext-compat.c                         |   47 +-
 net/wireless/wext-sme.c                            |   59 +-
 net/x25/af_x25.c                                   |    2 +-
 net/xdp/xsk.c                                      |   32 +-
 net/xdp/xsk_buff_pool.c                            |    3 +
 net/xfrm/xfrm_policy.c                             |    2 +-
 samples/bpf/Makefile                               |   19 +-
 samples/bpf/syscall_tp_kern.c                      |   15 +-
 samples/bpf/syscall_tp_user.c                      |   45 +-
 tools/bpf/bpftool/Documentation/bpftool-cgroup.rst |   16 +-
 tools/bpf/bpftool/Documentation/bpftool-net.rst    |    8 +-
 tools/bpf/bpftool/Documentation/bpftool-prog.rst   |    8 +-
 tools/bpf/bpftool/bash-completion/bpftool          |   14 +-
 tools/bpf/bpftool/btf_dumper.c                     |    2 +-
 tools/bpf/bpftool/cgroup.c                         |   16 +-
 tools/bpf/bpftool/gen.c                            |   58 +-
 tools/bpf/bpftool/link.c                           |   15 +
 tools/bpf/bpftool/net.c                            |    7 +-
 tools/bpf/bpftool/prog.c                           |    7 +-
 tools/bpf/bpftool/struct_ops.c                     |    6 +
 tools/include/uapi/linux/bpf.h                     |   52 +-
 tools/include/uapi/linux/if_link.h                 |  141 +
 tools/include/uapi/linux/netdev.h                  |   16 +
 tools/lib/bpf/bpf.c                                |   16 +
 tools/lib/bpf/bpf.h                                |    5 +
 tools/lib/bpf/bpf_helpers.h                        |    1 +
 tools/lib/bpf/bpf_tracing.h                        |    2 -
 tools/lib/bpf/btf.c                                |  160 +
 tools/lib/bpf/elf.c                                |  143 +-
 tools/lib/bpf/libbpf.c                             |  237 +-
 tools/lib/bpf/libbpf.h                             |   88 +
 tools/lib/bpf/libbpf.map                           |    8 +
 tools/lib/bpf/ringbuf.c                            |   85 +-
 tools/net/ynl/Makefile                             |    1 -
 tools/net/ynl/cli.py                               |    3 +-
 tools/net/ynl/generated/Makefile                   |    6 +-
 tools/net/ynl/generated/devlink-user.c             | 3861 +++++++++++++++++-
 tools/net/ynl/generated/devlink-user.h             | 3301 ++++++++++++++-
 tools/net/ynl/generated/ethtool-user.h             |   82 +-
 tools/net/ynl/generated/fou-user.h                 |    2 +-
 tools/net/ynl/generated/handshake-user.h           |   12 +-
 tools/net/ynl/generated/netdev-user.c              |   19 +
 tools/net/ynl/generated/netdev-user.h              |    7 +-
 tools/net/ynl/lib/nlspec.py                        |    6 +
 tools/net/ynl/lib/ynl.c                            |   12 +
 tools/net/ynl/lib/ynl.h                            |   22 +-
 tools/net/ynl/lib/ynl.py                           |   77 +-
 tools/net/ynl/samples/Makefile                     |    3 +
 tools/net/ynl/samples/netdev.c                     |    8 +-
 tools/net/ynl/ynl-gen-c.py                         |  287 +-
 tools/testing/selftests/bpf/DENYLIST.aarch64       |    2 +
 tools/testing/selftests/bpf/DENYLIST.s390x         |   26 +-
 tools/testing/selftests/bpf/Makefile               |   56 +-
 tools/testing/selftests/bpf/bpf_experimental.h     |  346 ++
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   14 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |    5 +
 .../selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h  |    2 +
 tools/testing/selftests/bpf/cgroup_helpers.c       |   38 +-
 tools/testing/selftests/bpf/config                 |    2 +
 tools/testing/selftests/bpf/liburandom_read.map    |   15 +
 .../selftests/bpf/map_tests/map_in_map_batch_ops.c |    4 +-
 tools/testing/selftests/bpf/netlink_helpers.c      |  358 ++
 tools/testing/selftests/bpf/netlink_helpers.h      |   46 +
 tools/testing/selftests/bpf/network_helpers.c      |   34 +
 tools/testing/selftests/bpf/network_helpers.h      |    1 +
 tools/testing/selftests/bpf/prog_tests/align.c     |  241 +-
 .../selftests/bpf/prog_tests/bloom_filter_map.c    |    4 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |   44 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |    4 +-
 .../selftests/bpf/prog_tests/connect_ping.c        |    4 +-
 .../testing/selftests/bpf/prog_tests/exceptions.c  |  409 ++
 .../testing/selftests/bpf/prog_tests/fib_lookup.c  |   83 +-
 .../selftests/bpf/prog_tests/fill_link_info.c      |    2 +-
 tools/testing/selftests/bpf/prog_tests/iters.c     |  208 +
 .../bpf/prog_tests/kprobe_multi_testmod_test.c     |   20 +-
 .../testing/selftests/bpf/prog_tests/libbpf_str.c  |    6 +-
 .../testing/selftests/bpf/prog_tests/linked_list.c |   16 +-
 .../testing/selftests/bpf/prog_tests/lwt_helpers.h |    3 +-
 tools/testing/selftests/bpf/prog_tests/missed.c    |  138 +
 .../bpf/prog_tests/module_fentry_shadow.c          |    5 +
 .../selftests/bpf/prog_tests/percpu_alloc.c        |  128 +
 .../selftests/bpf/prog_tests/preempted_bpf_ma_op.c |   89 +
 .../selftests/bpf/prog_tests/queue_stack_map.c     |    2 +-
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   |   26 +
 .../selftests/bpf/prog_tests/ringbuf_multi.c       |   15 +
 .../selftests/bpf/prog_tests/section_names.c       |   45 +
 tools/testing/selftests/bpf/prog_tests/sock_addr.c |  612 +++
 .../selftests/bpf/prog_tests/sockmap_basic.c       |    8 +-
 .../selftests/bpf/prog_tests/sockmap_helpers.h     |    2 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c      |  170 +-
 tools/testing/selftests/bpf/prog_tests/tailcalls.c |  269 +-
 .../selftests/bpf/prog_tests/task_under_cgroup.c   |   11 +-
 .../testing/selftests/bpf/prog_tests/tc_helpers.h  |    4 +
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c |  687 ++++
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   |  131 +-
 .../testing/selftests/bpf/prog_tests/test_bpf_ma.c |   20 +-
 tools/testing/selftests/bpf/prog_tests/timer.c     |    4 +
 tools/testing/selftests/bpf/prog_tests/uprobe.c    |   95 +
 .../selftests/bpf/prog_tests/xdp_metadata.c        |    2 +-
 .../{bpf_iter_task_vma.c => bpf_iter_task_vmas.c}  |    0
 .../progs/{bpf_iter_task.c => bpf_iter_tasks.c}    |    0
 tools/testing/selftests/bpf/progs/bpf_misc.h       |    3 +
 .../selftests/bpf/progs/connect_unix_prog.c        |   40 +
 tools/testing/selftests/bpf/progs/exceptions.c     |  368 ++
 .../selftests/bpf/progs/exceptions_assert.c        |  135 +
 tools/testing/selftests/bpf/progs/exceptions_ext.c |   72 +
 .../testing/selftests/bpf/progs/exceptions_fail.c  |  347 ++
 .../selftests/bpf/progs/getpeername_unix_prog.c    |   39 +
 .../selftests/bpf/progs/getsockname_unix_prog.c    |   39 +
 tools/testing/selftests/bpf/progs/iters.c          |  695 ++++
 tools/testing/selftests/bpf/progs/iters_css.c      |   72 +
 tools/testing/selftests/bpf/progs/iters_css_task.c |   47 +
 tools/testing/selftests/bpf/progs/iters_task.c     |   41 +
 .../selftests/bpf/progs/iters_task_failure.c       |  105 +
 tools/testing/selftests/bpf/progs/iters_task_vma.c |   44 +
 .../testing/selftests/bpf/progs/linked_list_fail.c |    4 +-
 tools/testing/selftests/bpf/progs/missed_kprobe.c  |   30 +
 .../selftests/bpf/progs/missed_kprobe_recursion.c  |   48 +
 .../selftests/bpf/progs/missed_tp_recursion.c      |   41 +
 .../selftests/bpf/progs/percpu_alloc_array.c       |  190 +
 .../bpf/progs/percpu_alloc_cgrp_local_storage.c    |  109 +
 .../selftests/bpf/progs/percpu_alloc_fail.c        |  164 +
 .../selftests/bpf/progs/preempted_bpf_ma_op.c      |  106 +
 tools/testing/selftests/bpf/progs/profiler.inc.h   |    2 +-
 .../selftests/bpf/progs/recvmsg_unix_prog.c        |   39 +
 .../selftests/bpf/progs/sendmsg_unix_prog.c        |   40 +
 .../selftests/bpf/progs/tailcall_bpf2bpf_fentry.c  |   18 +
 .../selftests/bpf/progs/tailcall_bpf2bpf_fexit.c   |   18 +
 tools/testing/selftests/bpf/progs/test_bpf_ma.c    |  180 +-
 tools/testing/selftests/bpf/progs/test_ldsx_insn.c |    9 +-
 .../selftests/bpf/progs/test_task_under_cgroup.c   |   28 +-
 tools/testing/selftests/bpf/progs/test_tc_link.c   |   13 +
 tools/testing/selftests/bpf/progs/test_uprobe.c    |   61 +
 tools/testing/selftests/bpf/progs/test_vmlinux.c   |    4 +-
 tools/testing/selftests/bpf/progs/timer.c          |   63 +-
 tools/testing/selftests/bpf/progs/verifier_bswap.c |    4 +-
 tools/testing/selftests/bpf/progs/verifier_gotol.c |    4 +-
 tools/testing/selftests/bpf/progs/verifier_ldsx.c  |  152 +-
 tools/testing/selftests/bpf/progs/verifier_movsx.c |    4 +-
 tools/testing/selftests/bpf/progs/verifier_sdiv.c  |    4 +-
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |    2 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |    4 +-
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c  |   22 +-
 .../selftests/bpf/test_bpftool_synctypes.py        |    9 +
 tools/testing/selftests/bpf/test_loader.c          |    4 +-
 tools/testing/selftests/bpf/test_progs.c           |    2 +-
 tools/testing/selftests/bpf/test_progs.h           |    2 +
 tools/testing/selftests/bpf/test_xsk.sh            |   40 +-
 tools/testing/selftests/bpf/trace_helpers.c        |  142 +-
 tools/testing/selftests/bpf/trace_helpers.h        |    8 +-
 tools/testing/selftests/bpf/unpriv_helpers.c       |   33 +-
 tools/testing/selftests/bpf/urandom_read.c         |   15 +-
 tools/testing/selftests/bpf/urandom_read_lib1.c    |   22 +
 tools/testing/selftests/bpf/xdp_features.c         |    4 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |   80 +-
 tools/testing/selftests/bpf/xsk.c                  |    3 +-
 tools/testing/selftests/bpf/xsk.h                  |    2 +-
 tools/testing/selftests/bpf/xsk_prereqs.sh         |   10 +-
 tools/testing/selftests/bpf/xsk_xdp_common.h       |   12 +
 tools/testing/selftests/bpf/xsk_xdp_metadata.h     |    5 -
 tools/testing/selftests/bpf/xskxceiver.c           | 1024 +++--
 tools/testing/selftests/bpf/xskxceiver.h           |   57 +-
 .../selftests/drivers/net/netdevsim/devlink.sh     |   21 +-
 tools/testing/selftests/net/Makefile               |    1 +
 tools/testing/selftests/net/af_unix/scm_pidfd.c    |    1 -
 .../testing/selftests/net/af_unix/test_unix_oob.c  |    2 -
 tools/testing/selftests/net/fdb_flush.sh           |  812 ++++
 tools/testing/selftests/net/forwarding/Makefile    |    3 +-
 .../net/forwarding/bridge_fdb_learning_limit.sh    |  283 ++
 .../testing/selftests/net/forwarding/bridge_mdb.sh |  184 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   23 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |    1 -
 tools/testing/selftests/net/nettest.c              |    5 +-
 tools/testing/selftests/net/route_localnet.sh      |    6 +-
 tools/testing/selftests/net/rtnetlink.sh           |  985 ++---
 tools/testing/selftests/net/test_vxlan_mdb.sh      |  108 +-
 tools/testing/selftests/netfilter/Makefile         |    2 +-
 tools/testing/selftests/netfilter/nf_nat_edemux.sh |   46 +-
 tools/testing/selftests/netfilter/xt_string.sh     |  128 +
 tools/testing/selftests/ptp/ptpchmaskfmt.sh        |   14 +
 tools/testing/selftests/ptp/testptp.c              |   19 +-
 tools/testing/selftests/tc-testing/Makefile        |    2 +-
 tools/testing/selftests/tc-testing/README          |   65 +-
 tools/testing/selftests/tc-testing/TdcPlugin.py    |    4 +-
 tools/testing/selftests/tc-testing/TdcResults.py   |    3 +-
 tools/testing/selftests/tc-testing/config          |    9 +
 .../selftests/tc-testing/plugin-lib/nsPlugin.py    |  194 +-
 .../selftests/tc-testing/plugin-lib/rootPlugin.py  |    4 +-
 .../tc-testing/plugin-lib/valgrindPlugin.py        |    5 +-
 .../{ => scripts}/taprio_wait_for_admin.sh         |    0
 .../tc-testing/tc-tests/actions/connmark.json      |   45 +
 .../tc-testing/tc-tests/actions/csum.json          |   69 +
 .../selftests/tc-testing/tc-tests/actions/ct.json  |   54 +
 .../tc-testing/tc-tests/actions/ctinfo.json        |   36 +
 .../tc-testing/tc-tests/actions/gact.json          |   75 +
 .../tc-testing/tc-tests/actions/gate.json          |   36 +
 .../selftests/tc-testing/tc-tests/actions/ife.json |  144 +
 .../tc-testing/tc-tests/actions/mirred.json        |   72 +
 .../tc-testing/tc-tests/actions/mpls.json          |  159 +
 .../selftests/tc-testing/tc-tests/actions/nat.json |   81 +
 .../tc-testing/tc-tests/actions/pedit.json         |  198 +
 .../tc-testing/tc-tests/actions/police.json        |  102 +
 .../tc-testing/tc-tests/actions/sample.json        |   87 +
 .../tc-testing/tc-tests/actions/simple.json        |   27 +
 .../tc-testing/tc-tests/actions/skbedit.json       |   90 +
 .../tc-testing/tc-tests/actions/skbmod.json        |   54 +
 .../tc-testing/tc-tests/actions/tunnel_key.json    |  117 +
 .../tc-testing/tc-tests/actions/vlan.json          |  108 +
 .../selftests/tc-testing/tc-tests/actions/xt.json  |   24 +
 .../selftests/tc-testing/tc-tests/filters/bpf.json |   10 +-
 .../selftests/tc-testing/tc-tests/filters/fw.json  |  315 +-
 .../tc-testing/tc-tests/filters/matchall.json      |  141 +-
 .../tc-testing/tc-tests/filters/route.json         |   25 +
 .../selftests/tc-testing/tc-tests/filters/u32.json |   25 +
 .../tc-testing/tc-tests/infra/actions.json         |  144 +-
 .../tc-testing/tc-tests/infra/filter.json          |    9 +-
 .../selftests/tc-testing/tc-tests/qdiscs/cake.json |   82 +-
 .../selftests/tc-testing/tc-tests/qdiscs/cbs.json  |   38 +-
 .../tc-testing/tc-tests/qdiscs/choke.json          |   30 +-
 .../tc-testing/tc-tests/qdiscs/codel.json          |   34 +-
 .../selftests/tc-testing/tc-tests/qdiscs/drr.json  |   10 +-
 .../selftests/tc-testing/tc-tests/qdiscs/etf.json  |   18 +-
 .../selftests/tc-testing/tc-tests/qdiscs/ets.json  |  284 +-
 .../selftests/tc-testing/tc-tests/qdiscs/fifo.json |   98 +-
 .../selftests/tc-testing/tc-tests/qdiscs/fq.json   |   68 +-
 .../tc-testing/tc-tests/qdiscs/fq_codel.json       |   54 +-
 .../tc-testing/tc-tests/qdiscs/fq_pie.json         |    5 +-
 .../selftests/tc-testing/tc-tests/qdiscs/gred.json |   28 +-
 .../selftests/tc-testing/tc-tests/qdiscs/hfsc.json |   58 +-
 .../selftests/tc-testing/tc-tests/qdiscs/hhf.json  |   36 +-
 .../selftests/tc-testing/tc-tests/qdiscs/htb.json  |   46 +-
 .../tc-testing/tc-tests/qdiscs/ingress.json        |   36 +-
 .../tc-testing/tc-tests/qdiscs/netem.json          |   62 +-
 .../tc-testing/tc-tests/qdiscs/pfifo_fast.json     |   18 +-
 .../selftests/tc-testing/tc-tests/qdiscs/plug.json |   30 +-
 .../selftests/tc-testing/tc-tests/qdiscs/prio.json |   85 +-
 .../selftests/tc-testing/tc-tests/qdiscs/qfq.json  |   39 +-
 .../selftests/tc-testing/tc-tests/qdiscs/red.json  |   34 +-
 .../selftests/tc-testing/tc-tests/qdiscs/sfb.json  |   48 +-
 .../selftests/tc-testing/tc-tests/qdiscs/sfq.json  |   40 +-
 .../tc-testing/tc-tests/qdiscs/skbprio.json        |   16 +-
 .../tc-testing/tc-tests/qdiscs/taprio.json         |    8 +-
 .../selftests/tc-testing/tc-tests/qdiscs/tbf.json  |   36 +-
 .../selftests/tc-testing/tc-tests/qdiscs/teql.json |   34 +-
 tools/testing/selftests/tc-testing/tdc.py          |  250 +-
 tools/testing/vsock/.gitignore                     |    1 +
 tools/testing/vsock/Makefile                       |   11 +-
 tools/testing/vsock/msg_zerocopy_common.c          |   87 +
 tools/testing/vsock/msg_zerocopy_common.h          |   18 +
 tools/testing/vsock/util.c                         |  311 +-
 tools/testing/vsock/util.h                         |    8 +
 tools/testing/vsock/vsock_perf.c                   |   80 +-
 tools/testing/vsock/vsock_test.c                   |  341 +-
 tools/testing/vsock/vsock_test_zerocopy.c          |  358 ++
 tools/testing/vsock/vsock_test_zerocopy.h          |   15 +
 tools/testing/vsock/vsock_uring_test.c             |  342 ++
 1865 files changed, 121439 insertions(+), 33186 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1b-gmac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/loongson,ls1c-emac.yaml
 create mode 100644 Documentation/driver-api/dpll.rst
 create mode 100644 Documentation/netlink/specs/dpll.yaml
 create mode 100644 Documentation/netlink/specs/mptcp.yaml
 delete mode 100644 Documentation/networking/device_drivers/appletalk/cops.rst
 delete mode 100644 Documentation/networking/device_drivers/appletalk/index.rst
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/idpf.rst
 create mode 100644 Documentation/networking/devlink/i40e.rst
 delete mode 100644 Documentation/networking/ipddp.rst
 create mode 100644 Documentation/networking/tcp_ao.rst
 create mode 100644 drivers/dpll/Kconfig
 create mode 100644 drivers/dpll/Makefile
 create mode 100644 drivers/dpll/dpll_core.c
 create mode 100644 drivers/dpll/dpll_core.h
 create mode 100644 drivers/dpll/dpll_netlink.c
 create mode 100644 drivers/dpll/dpll_netlink.h
 create mode 100644 drivers/dpll/dpll_nl.c
 create mode 100644 drivers/dpll/dpll_nl.h
 delete mode 100644 drivers/net/appletalk/Kconfig
 delete mode 100644 drivers/net/appletalk/Makefile
 delete mode 100644 drivers/net/appletalk/cops.c
 delete mode 100644 drivers/net/appletalk/cops.h
 delete mode 100644 drivers/net/appletalk/cops_ffdrv.h
 delete mode 100644 drivers/net/appletalk/cops_ltdrv.h
 delete mode 100644 drivers/net/appletalk/ipddp.c
 delete mode 100644 drivers/net/appletalk/ipddp.h
 create mode 100644 drivers/net/dsa/microchip/ksz9477_acl.c
 create mode 100644 drivers/net/dsa/microchip/ksz9477_tc_flower.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_debug.h
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_devlink.c
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_devlink.h
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_io.h
 delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_osdep.h
 delete mode 100644 drivers/net/ethernet/intel/iavf/iavf_client.c
 delete mode 100644 drivers/net/ethernet/intel/iavf/iavf_client.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_dpll.h
 create mode 100644 drivers/net/ethernet/intel/idpf/Makefile
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_dev.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devids.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ethtool.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_vf_regs.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lib.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_main.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_txrx.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_txrx.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/idpf/virtchnl2.h
 create mode 100644 drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/dpll.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
 delete mode 100644 drivers/net/ethernet/ti/cpmac.c
 create mode 100644 drivers/net/mctp/mctp-i3c.c
 create mode 100644 drivers/net/netkit.c
 create mode 100644 drivers/net/wireless/ath/ath11k/fw.c
 create mode 100644 drivers/net/wireless/ath/ath11k/fw.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/pci_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/regs.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/usb.c
 create mode 100644 include/linux/dpll.h
 create mode 100644 include/net/netkit.h
 create mode 100644 include/net/tcp_ao.h
 create mode 100644 include/uapi/linux/dpll.h
 create mode 100644 include/uapi/linux/mptcp_pm.h
 create mode 100644 net/appletalk/Kconfig
 create mode 100644 net/core/gso_test.c
 rename net/dsa/{master.c => conduit.c} (76%)
 create mode 100644 net/dsa/conduit.h
 delete mode 100644 net/dsa/master.h
 delete mode 100644 net/dsa/slave.h
 rename net/dsa/{slave.c => user.c} (62%)
 create mode 100644 net/dsa/user.h
 create mode 100644 net/ipv4/tcp_ao.c
 create mode 100644 net/ipv4/tcp_sigpool.c
 create mode 100644 net/ipv6/tcp_ao.c
 create mode 100644 net/mac80211/tests/Makefile
 create mode 100644 net/mac80211/tests/elems.c
 create mode 100644 net/mac80211/tests/module.c
 create mode 100644 net/mptcp/mptcp_pm_gen.c
 create mode 100644 net/mptcp/mptcp_pm_gen.h
 create mode 100644 net/wireless/tests/Makefile
 create mode 100644 net/wireless/tests/fragmentation.c
 create mode 100644 net/wireless/tests/module.c
 create mode 100644 tools/testing/selftests/bpf/liburandom_read.map
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.c
 create mode 100644 tools/testing/selftests/bpf/netlink_helpers.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/missed.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/preempted_bpf_ma_op.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_netkit.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe.c
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task_vma.c => bpf_iter_task_vmas.c} (100%)
 rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)
 create mode 100644 tools/testing/selftests/bpf/progs/connect_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_assert.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_css_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/missed_tp_recursion.c
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_array.c
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/preempted_bpf_ma_op.c
 create mode 100644 tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_uprobe.c
 create mode 100644 tools/testing/selftests/bpf/xsk_xdp_common.h
 delete mode 100644 tools/testing/selftests/bpf/xsk_xdp_metadata.h
 create mode 100755 tools/testing/selftests/net/fdb_flush.sh
 create mode 100755 tools/testing/selftests/net/forwarding/bridge_fdb_learning_limit.sh
 create mode 100755 tools/testing/selftests/netfilter/xt_string.sh
 create mode 100644 tools/testing/selftests/ptp/ptpchmaskfmt.sh
 rename tools/testing/selftests/tc-testing/{ => scripts}/taprio_wait_for_admin.sh (100%)
 create mode 100644 tools/testing/vsock/msg_zerocopy_common.c
 create mode 100644 tools/testing/vsock/msg_zerocopy_common.h
 create mode 100644 tools/testing/vsock/vsock_test_zerocopy.c
 create mode 100644 tools/testing/vsock/vsock_test_zerocopy.h
 create mode 100644 tools/testing/vsock/vsock_uring_test.c
