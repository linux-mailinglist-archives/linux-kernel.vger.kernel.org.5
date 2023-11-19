Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081107F09CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 00:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjKSXIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 18:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSXIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 18:08:23 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297AE139
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 15:08:18 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-543923af573so5387536a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 15:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700435296; x=1701040096; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9m9BAbNdBHv/TzbcS6UpoLiap6p6HBH1LCm32XWDZGc=;
        b=K3EnPPB4xS81fmv4sm/WRB/OFw8cYNawvJWXNwC8CWbowQHlp1zRMkhuS68eOemOl0
         bPgcWW4CzhdfFJe0UnWndX2X7tSA41YhtGHWaL1Qcg6LtkI3jY/7FIpoMmKj3uiYf3+1
         gLOTTgEzBVXK210iGqrgCSpLhrOog3T7pUD7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700435296; x=1701040096;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9m9BAbNdBHv/TzbcS6UpoLiap6p6HBH1LCm32XWDZGc=;
        b=nnpPlyQdISulBjUnNdCZB4jGz/e/Jbtq8t9Yf/E6VQuSwE23GkmNOVpNtZhZZg8ijz
         zEIW1eymTU9v/APy8OJbwjbFDqPTX/p0d2dm5RHZ+CR1GaSRsJOmzBw9naGXXYPQwJJx
         1hUZchGoh72TICcuRmZ8GZ6qbyCv6w7AHYByHVETo/r1LU0GS2Qrpwp4oB5kczNjfg5A
         bqE1Y5Q94BAG8wMuEHjccjuFHyFr6U3XXei2jjyT1YhmJl4fFipqXyXmnXreslYZRBiP
         +xORdCR86GBJXNiE2+OWgMSk9Yunep/okKozNxQBW44pIhYSZbUf7G3u/tJLg2fgwk7+
         pKcw==
X-Gm-Message-State: AOJu0YxzQT01iYRKC+WKjhMLF3nfcHuLrCSplEbBr4/9UBnxec1ua1+p
        lmN1+eVN26ySJW2xUXNDq/WINOSVd/ufS2ZR+KtidA==
X-Google-Smtp-Source: AGHT+IEZOf5yoNhFEODV9OkFwhRuFb7MqrrGBk4Rk+V+eT5UsvzeGHtMBHKLVRebPdmJJrztpR7epw==
X-Received: by 2002:a17:906:b2ca:b0:9fd:8cd9:7842 with SMTP id cf10-20020a170906b2ca00b009fd8cd97842mr1571183ejb.44.1700435296132;
        Sun, 19 Nov 2023 15:08:16 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id lo1-20020a170906fa0100b009a168ab6ee2sm3209108ejb.164.2023.11.19.15.08.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 15:08:15 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso5378305a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 15:08:15 -0800 (PST)
X-Received: by 2002:aa7:c6d9:0:b0:53e:b8e2:1d58 with SMTP id
 b25-20020aa7c6d9000000b0053eb8e21d58mr4285219eds.13.1700435295002; Sun, 19
 Nov 2023 15:08:15 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Nov 2023 15:07:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj6j3U5r8ixVf_RQXwRYD03DuEqnX2ZsfYwvB-9YxQNLA@mail.gmail.com>
Message-ID: <CAHk-=wj6j3U5r8ixVf_RQXwRYD03DuEqnX2ZsfYwvB-9YxQNLA@mail.gmail.com>
Subject: Linux 6.7-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I was expecting rc2 to be tiny, because we had a lot of people
(including me) traveling for either plumbers conf or maintainer summit
(or both). And rc2 tends to be small anyway.

But looking at the stats, rc2 is average to slightly larger than
average. Not huge like rc1 was, but certainly not tiny either.

The most noticeable thing is probably the turbostat tool update, which
actually came in during the merge window, but was delayed by just
waiting for getting the pull request properly signed. Maybe that at
least partially explains why rc2 isn't as small as I would have
expected.

But nothing looks bad or scary, so please do go right ahead and
continue testing,

              Linus

---

Abel Wu (1):
      sched/eevdf: Fix vruntime adjustment on reweight

Alex Deucher (5):
      drm/amdgpu/gmc11: fix logic typo in AGP check
      drm/amdgpu: add a module parameter to control the AGP aperture
      drm/amdgpu/gmc11: disable AGP aperture
      drm/amdgpu/gmc10: disable AGP aperture
      drm/amdgpu/gmc9: disable AGP aperture

Alex Pakhunov (2):
      tg3: Move the [rt]x_dropped counters to tg3_napi
      tg3: Increment tx_dropped in tg3_tso_bug()

Amir Goldstein (2):
      ovl: fix misformatted comment
      ovl: fix memory leak in ovl_parse_param()

Anastasia Belova (1):
      cifs: spnego: add ';' in HOST_KEY_LEN

Anders Roxell (1):
      selftests: bpf: xskxceiver: ksft_print_msg: fix format type error

Andrii Nakryiko (5):
      bpf: handle ldimm64 properly in check_cfg()
      bpf: fix precision backtracking instruction iteration
      selftests/bpf: add edge case backtracking logic test
      bpf: fix control-flow graph checking in privileged mode
      selftests/bpf: add more test cases for check_cfg()

Anthony Iliopoulos (1):
      xfs: fix again select in kconfig XFS_ONLINE_SCRUB_STATS

Arkadiusz Kubalewski (3):
      ice: dpll: fix initial lock status of dpll
      ice: dpll: fix check for dpll input priority range
      ice: dpll: fix output pin capabilities

Arnd Bergmann (2):
      stackleak: add declarations for global functions
      accel/ivpu: avoid build failure with CONFIG_PM=3Dn

Asad Kamal (2):
      drm/amd/pm: Update metric table for smu v13_0_6
      drm/amd/pm: Fill pcie error counters for gpu v1_4

Bagas Sanjaya (1):
      x86/Documentation: Indent 'note::' directive for protocol
version number note

Baruch Siach (2):
      net: stmmac: fix rx budget limit check
      net: stmmac: avoid rx queue overrun

Bj=C3=B6rn T=C3=B6pel (1):
      riscv, qemu_fw_cfg: Add support for RISC-V architecture

Bob Peterson (1):
      Remove myself as maintainer of GFS2

Boris Burkov (1):
      btrfs: make OWNER_REF_KEY type value smallest among inline refs

Breno Leitao (2):
      selftests/mm: restore number of hugepages
      selftests/mm: add hugetlb_fault_after_madv to .gitignore

Brenton Simpson (1):
      drm: panel-orientation-quirks: Add quirk for Lenovo Legion Go

Chandradeep Dey (1):
      ALSA: hda/realtek - Enable internal speaker of ASUS K6500ZC

Chen Yu (1):
      tools/power/turbostat: Enable the C-state Pre-wake printing

Christoph Hellwig (2):
      xfs: only remap the written blocks in xfs_reflink_end_cow_extent
      blk-mq: make sure active queue usage is held for bio_integrity_prep()

Chuck Lever (3):
      NFSD: Update nfsd_cache_append() to use xdr_stream
      NFSD: Fix "start of NFS reply" pointer passed to nfsd_cache_update()
      NFSD: Fix checksum mismatches in the duplicate reply cache

ChunHao Lin (2):
      r8169: add handling DASH when DASH is disabled
      r8169: fix network lost after resume on DASH systems

Dan Carpenter (8):
      vhost-vdpa: fix use after free in vhost_vdpa_probe()
      btrfs: directly return 0 on no error code in btrfs_insert_raid_extent=
()
      scsi: scsi_debug: Fix some bugs in sdebug_error_write()
      scsi: scsi_debug: Delete some bogus error checking
      netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()
      nouveau/gsp/r535: uninitialized variable in r535_gsp_acpi_mux_id()
      nouveau/gsp/r535: Fix a NULL vs error pointer bug
      mm/damon/sysfs: eliminate potential uninitialized variable warning

Dan Nowlin (1):
      ice: fix DDP package download for packages without signature segment

Daniel J Blueman (1):
      bcachefs: Fix potential sleeping during mount

Dave Airlie (2):
      nouveau: use an rwlock for the event lock.
      nouveau: don't fail driver load if no display hw present.

Dave Chinner (2):
      xfs: inode recovery does not validate the recovered inode
      xfs: recovery should not clear di_flushiter unconditionally

Duncan Ma (1):
      drm/amd/display: Negate IPS allow and commit bits

Dust Li (1):
      net/mlx5e: fix double free of encap_header

Ekaterina Esina (1):
      cifs: fix check of rc in function generate_smb3signingkey

Erez Shitrit (1):
      net/mlx5: DR, Allow old devices to use multi destination FTE

Eric Dumazet (4):
      ipvlan: add ipvlan_route_v6_outbound() helper
      ptp: annotate data-race around q->head and q->tail
      bonding: stop the device in bond_setup_by_slave()
      af_unix: fix use-after-free in unix_stream_read_actor()

Eymen Yigit (1):
      ALSA: hda/realtek: Enable Mute LED on HP 255 G8

Fang Xiang (1):
      irqchip/gic-v3-its: Flush ITS tables correctly in non-coherent GIC de=
signs

Fangzhi Zuo (1):
      drm/amd/display: Fix DSC not Enabled on Direct MST Sink

Filipe Manana (4):
      btrfs: use u64 for buffer sizes in the tree search ioctls
      btrfs: fix error pointer dereference after failure to allocate fs dev=
ices
      btrfs: fix race between accounting qgroup extents and removing a qgro=
up
      btrfs: fix qgroup record leaks when using simple quotas

Gal Pressman (1):
      net: Fix undefined behavior in netdev name allocation

Gavin Li (1):
      net/mlx5e: fix double free of encap_header in update funcs

Geliang Tang (1):
      mptcp: add validity check for sending RM_ADDR

Gustavo A. R. Silva (2):
      bcachefs: Use DECLARE_FLEX_ARRAY() helper and fix multiple
-Warray-bounds warnings
      bcachefs: Fix multiple -Warray-bounds warnings

Helge Deller (3):
      parisc: fix mmap_base calculation when stack grows upwards
      parisc/power: Fix power soft-off when running on qemu
      prctl: Disable prctl(PR_SET_MDWE) on parisc

Hyeongtak Ji (1):
      mm/damon/core.c: avoid unintentional filtering out of schemes

Itamar Gozlan (1):
      Revert "net/mlx5: DR, Supporting inline WQE when possible"

Jakub Kicinski (1):
      Revert "ptp: Fixes a null pointer dereference in ptp_ioctl"

Jakub Sitnicki (1):
      virtio_pci: Switch away from deprecated irq_set_affinity_hint

Jan Bottorff (1):
      i2c: designware: Fix corrupted memory seen in the ISR

Jan Kiszka (2):
      net: ti: icssg-prueth: Add missing icss_iep_put to error path
      net: ti: icssg-prueth: Fix error cleanup on failing
pruss_request_mem_region

Jens Axboe (1):
      io_uring/fdinfo: remove need for sqpoll lock for thread/pid retrieval

Jian Shen (2):
      net: hns3: fix add VLAN fail issue
      net: hns3: fix incorrect capability bit display for copper port

Jianbo Liu (1):
      net/mlx5e: Don't modify the peer sent-to-vport rules for IPSec offloa=
d

Jiapeng Chong (1):
      bcachefs: make bch2_target_to_text_sb static

Jijie Shao (2):
      net: hns3: fix VF reset fail issue
      net: hns3: fix VF wrong speed and duplex issue

Johannes Weiner (1):
      sched: psi: fix unprivileged polling against cgroups

Johnathan Mantey (1):
      Revert ncsi: Propagate carrier gain/loss events to the NCSI controlle=
r

Josef Bacik (1):
      btrfs: get correct owning_root when dropping snapshot

Jos=C3=A9 Pekkarinen (1):
      drm/amd/display: fix NULL dereference

Jozsef Kadlecsik (1):
      netfilter: ipset: fix race condition between swap/destroy and
kernel side add/del/test

Juergen Gross (8):
      xen/events: avoid using info_for_irq() in xen_send_IPI_one()
      xen/events: fix delayed eoi list handling
      xen/events: remove unused functions
      xen/events: reduce externally visible helper functions
      xen/events: remove some simple helpers from events_base.c
      xen/events: drop xen_allocate_irqs_dynamic()
      xen/events: modify internal [un]bind interfaces
      xen/events: remove some info_for_irq() calls in pirq handling

Kailang Yang (1):
      ALSA: hda/realtek - Add Dell ALC295 to pin fall back table

Kees Cook (2):
      gcc-plugins: randstruct: Only warn about true flexible arrays
      parisc: Replace strlcpy() with strscpy()

Keisuke Nishimura (1):
      sched/fair: Fix the decision for load balance

Kent Overstreet (18):
      bcachefs: Use correct fgf_t type as function argument
      bcachefs: Fix null ptr deref in bch2_backpointer_get_node()
      bcachefs: Guard against insufficient devices to create stripes
      bcachefs: Split out btree_key_cache_types.h
      bcachefs: Run btree key cache shrinker less aggressively
      bcachefs: btree_trans->write_locked
      bcachefs: Make sure to drop/retake btree locks before reclaim
      bcachefs: Check for nonce offset inconsistency in data_update path
      bcachefs: Kill journal pre-reservations
      bcachefs: Fix iterator leak in may_delete_deleted_inode()
      bcachefs: Fix error path in bch2_mount()
      bcachefs: Fix missing transaction commit
      bcachefs: Disable debug log statements
      bcachefs: Don't decrease BTREE_ITER_MAX when LOCKDEP=3Dy
      bcachefs: Fix bch2_check_nlinks() for snapshots
      bcachefs: Fix no_data_io mode checksum check
      bcachefs: six locks: Fix lost wakeup
      bcachefs: Fix missing locking for dentry->d_parent access

Kirill A. Shutemov (1):
      MAINTAINERS: Add Intel TDX entry

Konstantin Runov (1):
      gcc-plugins: latent_entropy: Fix typo (args -> argc) in plugin descri=
ption

Le Ma (1):
      drm/amdgpu: finalizing mem_partitions at the end of GMC v9 sw_fini

Leah Rumancik (1):
      xfs: up(ic_sema) if flushing data device fails

Len Brown (2):
      tools/power/turbostat: bugfix "--show IPC"
      tools/power turbostat: version 2023.11.07

Lewis Huang (1):
      drm/amd/display: Change the DMCUB mailbox memory location from FB to =
inbox

Lijo Lazar (1):
      drm/amd/pm: Don't send unload message for reset

Linkui Xiao (1):
      netfilter: nf_conntrack_bridge: initialize err to 0

Linus Torvalds (2):
      drm/ci: make github dependabot happy again
      Linux 6.7-rc2

Linus Walleij (3):
      net: ethernet: cortina: Fix max RX frame define
      net: ethernet: cortina: Handle large frames
      net: ethernet: cortina: Fix MTU max setting

Long Li (2):
      xfs: factor out xfs_defer_pending_abort
      xfs: abort intent items when recovery intents fail

Lukas Bulwahn (1):
      linux/export: clean up the IA-64 KSYM_FUNC macro

MD Danish Anwar (1):
      MAINTAINERS: add entry for TI ICSSG Ethernet driver

Maarten Lankhorst (1):
      ALSA: hda: i915: Alays handle -EPROBE_DEFER

Maher Sanalla (1):
      net/mlx5: Free used cpus mask when an IRQ is released

Mahmoud Adam (1):
      nfsd: fix file memleak on client_opens_release

Marek Beh=C3=BAn (1):
      net: mdio: fix typo in header

Mario Limonciello (1):
      drm/amd/display: fix a NULL pointer dereference in amdgpu_dm_i2c_xfer=
()

Masahiro Yamada (2):
      modpost: fix section mismatch message for RELA
      kconfig: fix memory leak from range properties

Matthew Wilcox (Oracle) (1):
      XFS: Update MAINTAINERS to catch all XFS documentation

Matus Malych (1):
      ALSA: hda/realtek: Enable Mute LED on HP 255 G10

Michael S. Tsirkin (1):
      virtio_pci: move structure to a header

Mike Christie (1):
      scsi: sd: Fix sshdr use in sd_suspend_common()

Mikulas Patocka (6):
      dm-delay: fix a race between delay_presuspend and delay_bio
      dm-delay: fix bugs introduced by kthread mode
      dm-delay: avoid duplicate logic
      dm-bufio: fix no-sleep mode
      dm-verity: don't use blocking calls from tasklets
      dm-crypt: start allocating with MAX_ORDER

Muhammad Ahmed (1):
      drm/amd/display: Add null checks for 8K60 lightup

Muhammad Usama Anjum (2):
      selftests: mm: skip whole test instead of failure
      selftests: mm: fix some build warnings

Naohiro Aota (2):
      btrfs: zoned: drop no longer valid write pointer check
      btrfs: zoned: wait for data BG to be finished on direct IO allocation

Naomi Chu (1):
      scsi: ufs: core: Expand MCQ queue slot to DeviceQueueDepth + 1

Neil Armstrong (1):
      scsi: ufs: qcom-ufs: dt-bindings: Document the SM8650 UFS Controller

Nicholas Kazlauskas (1):
      drm/amd/display: Guard against invalid RPTR/WPTR being set

Nicholas Susanto (1):
      drm/amd/display: Fix encoder disable logic

Nick Terrell (1):
      zstd: Fix array-index-out-of-bounds UBSAN warning

Niklas S=C3=B6derlund (1):
      dt-bindings: net: ethernet-controller: Fix formatting error

Omar Sandoval (1):
      xfs: fix internal error from AGFL exhaustion

Pablo Neira Ayuso (2):
      netfilter: nf_tables: bogus ENOENT when destroying element which
does not exist
      netfilter: nf_tables: split async and sync catchall in two functions

Paolo Abeni (4):
      mptcp: deal with large GSO size
      mptcp: fix possible NULL pointer dereference on close
      mptcp: fix setsockopt(IP_TOS) subflow locking
      selftests: mptcp: fix fastclose with csum failure

Paul Hsieh (1):
      drm/amd/display: Clear dpcd_sink_ext_caps if not set

Paul Moore (1):
      audit: don't WARN_ON_ONCE(!current->mm) in audit_exe_compare()

Peter Wang (1):
      scsi: ufs: core: Fix racing issue between ufshcd_mcq_abort() and ISR

Peter Zijlstra (2):
      futex: Fix hardcoded flags
      perf/core: Fix cpuctx refcounting

Qu Wenruo (1):
      btrfs: make found_logical_ret parameter mandatory for function
queue_scrub_stripe()

Quinn Tran (1):
      scsi: qla2xxx: Fix system crash due to bad pointer access

Rahul Rameshbabu (7):
      net/mlx5: Decouple PHC .adjtime and .adjphase implementations
      net/mlx5e: Avoid referencing skb after free-ing in drop path of
mlx5e_sq_xmit_wqe
      net/mlx5e: Track xmit submission to PTP WQ after populating metadata =
map
      net/mlx5e: Update doorbell for port timestamping CQ before the
software counter
      net/mlx5: Increase size of irq name buffer
      net/mlx5e: Check return value of snprintf writing to fw_version buffe=
r
      net/mlx5e: Check return value of snprintf writing to fw_version
buffer for representors

Randy Dunlap (1):
      xen/shbuf: eliminate 17 kernel-doc warnings

Ravi Gunasekaran (1):
      MAINTAINERS: net: Update reviewers for TI's Ethernet drivers

Rick Edgecombe (1):
      x86/shstk: Delay signal entry SSP write until after user accesses

Robert Marko (1):
      Revert "i2c: pxa: move to generic GPIO recovery"

Roger Pau Monne (1):
      acpi/processor: sanitize _OSC/_PDC capabilities for Xen dom0

Roman Gushchin (1):
      mm: kmem: drop __GFP_NOFAIL when allocating objcg vectors

Ryan Roberts (1):
      mm: more ptep_get() conversion

Saeed Mahameed (1):
      net/mlx5e: Reduce the size of icosq_str

Samuel Holland (1):
      i2c: ocores: Move system PM hooks to the NOIRQ phase

SeongJae Park (3):
      mm/damon/sysfs: check error from damon_sysfs_update_target()
      mm/damon/sysfs-schemes: handle tried regions sysfs directory
allocation failure
      mm/damon/sysfs-schemes: handle tried region directory allocation fail=
ure

Shannon Nelson (2):
      pds_core: use correct index to mask irq
      pds_core: fix up some format-truncation complaints

Shigeru Yoshida (2):
      tty: Fix uninit-value access in ppp_sync_receive()
      tipc: Fix kernel-infoleak due to uninitialized TLV value

Shiwu Zhang (1):
      drm/amdgpu: add and populate the port num into xgmi topology info

Shyam Prasad N (2):
      cifs: fix leak of iface for primary channel
      cifs: fix lock ordering while disabling multichannel

Simon Glass (1):
      kbuild: Move the single quotes for image name

Simon Trimmer (1):
      ALSA: hda: cs35l56: Enable low-power hibernation mode on i2c

Srinivas Pandruvada (1):
      tools/power/turbostat: Move process to root cgroup

Srinivasan Shanmugam (1):
      drm/amdgpu: Address member 'ring' not described in 'amdgpu_ vce,
uvd_entity_init()'

Stanislav Fomichev (1):
      net: set SOCK_RCU_FREE before inserting socket into hashtable

Stefan Binding (2):
      ALSA: hda/realtek: Add quirks for ASUS 2024 Zenbooks
      ALSA: hda/realtek: Add quirks for HP Laptops

Stefan Roesch (1):
      mm: fix for negative counter: nr_file_hugepages

Stefano Garzarella (1):
      vdpa_sim_blk: allocate the buffer zeroed

Sumeet Pawnikar (2):
      tools/power/turbostat: Add initial support for ArrowLake
      tools/power/turbostat: Add initial support for LunarLake

Sven Auhagen (1):
      net: mvneta: fix calls to page_pool_get_stats

Thomas Gleixner (1):
      hrtimers: Push pending hrtimers away from outgoing CPU earlier

Tianci Yin (1):
      drm/amd/display: Enable fast plane updates on DCN3.2 and above

Victor Lu (1):
      drm/amdgpu: Do not program VF copy regs in mmhub v1.8 under SRIOV (v2=
)

Vlad Buslov (2):
      net/mlx5e: Fix pedit endianness
      macvlan: Don't propagate promisc change to lower dev in passthru

Willem de Bruijn (2):
      net: gso_test: support CONFIG_MAX_SKB_FRAGS up to 45
      ppp: limit MRU to 64K

Xin Long (1):
      net: sched: do not offload flows with a helper in act_ct

Yang Li (1):
      netfilter: nft_set_rbtree: Remove unused variable nft_net

Yang Wang (1):
      drm/amdgpu: fix ras err_data null pointer issue in amdgpu_ras.c

Yonghong Song (1):
      bpf: Do not allocate percpu memory at init stage

Yonglong Liu (3):
      net: hns3: add barrier in vf mailbox reply process
      net: hns3: fix out-of-bounds access may occur when coalesce info
is read via debugfs
      net: hns3: fix variable may not initialized problem in
hns3_init_mac_addr()

YuanShang (1):
      drm/amdgpu: correct chunk_ptr to a pointer to chunk.

Yuran Pereira (1):
      ptp: Fixes a null pointer dereference in ptp_ioctl

Zhang Rui (81):
      tools/power/turbostat: Fix failure with new uncore sysfs
      tools/power/turbostat: Fix a knl bug
      tools/power/turbostat: Enable TCC Offset on more models
      tools/power/turbostat: Support alternative graphics sysfs knobs
      tools/power/turbostat: Replace raw value cpu model with Macro
      tools/power/turbostat: Remove redundant duplicates
      tools/power/turbostat: Remove pseudo check for two models
      tools/power/turbostat: Add skeleton support for table driven
feature enumeration
      tools/power/turbostat: Abstract MSR_MISC_FEATURE_CONTROL support
      tools/power/turbostat: Abstract MSR_MISC_PWR_MGMT support
      tools/power/turbostat: Abstract BCLK frequency support
      tools/power/turbostat: Abstract Package cstate limit decoding support
      tools/power/turbostat: Abstract Nehalem MSRs support
      tools/power/turbostat: Remove a redundant check
      tools/power/turbostat: Rename some functions
      tools/power/turbostat: Abstract Turbo Ratio Limit MSRs support
      tools/power/turbostat: Rename some TRL functions
      tools/power/turbostat: Abstract Config TDP MSRs support
      tools/power/turbostat: Abstract TCC Offset bits support
      tools/power/turbostat: Abstract Perf Limit Reasons MSRs support
      tools/power/turbostat: Abstract Automatic Cstate Conversion support
      tools/power/turbostat: Abstract hardcoded Crystal Clock frequency
      tools/power/turbostat: Redefine RAPL macros
      tools/power/turbostat: Simplify the logic for RAPL enumeration
      tools/power/turbostat: Abstract RAPL MSRs support
      tools/power/turbostat: Abstract Per Core RAPL support
      tools/power/turbostat: Abstract RAPL divisor support
      tools/power/turbostat: Abstract fixed DRAM Energy unit support
      tools/power/turbostat: Abstract hardcoded TDP value
      tools/power/turbostat: Remove unused family/model parameters for
RAPL functions
      tools/power/turbostat: Abstract TSC tweak support
      tools/power/turbostat: Add skeleton support for cstate enumeration
      tools/power/turbostat: Adjust cstate for models with .has_nhm_msrs se=
t
      tools/power/turbostat: Adjust cstate for has_snb_msrs() models
      tools/power/turbostat: Adjust cstate for models with .cst_limit set
      tools/power/turbostat: Adjust cstate for has_snb_msrs() models
      tools/power/turbostat: Adjust cstate for has_slv_msrs() models
      tools/power/turbostat: Adjust cstate for is_jvl() models
      tools/power/turbostat: Adjust cstate for is_dnv() models
      tools/power/turbostat: Adjust cstate for is_skx()/is_icx()/is_spr() m=
odels
      tools/power/turbostat: Adjust cstate for is_bdx() models
      tools/power/turbostat: Adjust cstate for has_c8910_msrs() models
      tools/power/turbostat: Adjust cstate for
is_slm()/is_knl()/is_cnl()/is_ehl() models
      tools/power/turbostat: Use fine grained IRTL output
      tools/power/turbostat: Abstract IRTL support
      tools/power/turbostat: Abstract MSR_CORE_C1_RES support
      tools/power/turbostat: Abstract MSR_MODULE_C6_RES_MS support
      tools/power/turbostat: Abstract MSR_CC6/MC6_DEMOTION_POLICY_CONFIG su=
pport
      tools/power/turbostat: Abstract MSR_ATOM_PKG_C6_RESIDENCY support
      tools/power/turbostat: Abstract MSR_KNL_CORE_C6_RESIDENCY support
      tools/power/turbostat: Abstract extended cstate MSRs support
      tools/power/turbostat: Abstract aperf/mperf multiplier support
      tools/power/turbostat: Abstract cstate prewake bit support
      tools/power/turbostat: Delete intel_model_duplicates()
      tools/power/turbostat: Improve probe_platform_features() logic
      tools/power/turbostat: Relocate cstate probing code
      tools/power/turbostat: Relocate pstate probing code
      tools/power/turbostat: Rename uncore probing function
      tools/power/turbostat: Rename rapl probing function
      tools/power/turbostat: Relocate graphics probing code
      tools/power/turbostat: Relocate lpi probing code
      tools/power/turbostat: Relocate thermal probing code
      tools/power/turbostat: Reorder some functions
      tools/power/turbostat: Relocate more probing related code
      tools/power/turbostat: Introduce probe_pm_features()
      tools/power/turbostat: Enable MSR_CORE_C1_RES on recent Intel
client platforms
      tools/power/turbostat: Remove PC7/PC9 support on ADL/RPL
      tools/power/turbostat: Introduce cpu_allowed_set
      tools/power/turbostat: Obey allowed CPUs when accessing CPU counters
      tools/power/turbostat: Obey allowed CPUs during startup
      tools/power/turbostat: Abstract several functions
      tools/power/turbostat: Obey allowed CPUs for primary thread/core dete=
ction
      tools/power/turbostat: Obey allowed CPUs for system summary
      tools/power/turbostat: Handle offlined CPUs in cpu_subset
      tools/power/turbostat: Abstrct function for parsing cpu string
      tools/power/turbostat: Handle cgroup v2 cpu limitation
      tools/power/turbostat: Add MSR_CORE_C1_RES support for spr_features
      tools/power/turbostat: Add initial support for GraniteRapids
      tools/power/turbostat: Add initial support for SierraForest
      tools/power/turbostat: Add initial support for GrandRidge
      x86/acpi: Ignore invalid x2APIC entries

Ziwei Xiao (1):
      gve: Fixes for napi_poll when budget is 0
