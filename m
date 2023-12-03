Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45C802276
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjLCKS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:18:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F388DF2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:19:00 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54cae99a48aso577652a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 02:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701598739; x=1702203539; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7byI61Rve37DyI+9HZR0viP0VwOgeLhlzRKwptPmDzU=;
        b=TwuzUJAZjRzX7muc6/srttFRGHG06obrV4iSm8GSSKM1qonNT+93ueriMtIhq0BjsB
         yEoXuzAfHp0Xl6AteFp/z6gpZ2W7Recn2ZIQxtGla+RiwKQcgVrA7IZuIDGnBSD0A5bR
         DLQkfIJGAqaQAXjYJN7UUizJgFfPLJT9CvXlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701598739; x=1702203539;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7byI61Rve37DyI+9HZR0viP0VwOgeLhlzRKwptPmDzU=;
        b=DL13Xmel9PVcgDGnCthCx4k2JplHBSMyR0Ch03uDi+98N6b6zHsGO6kflAhBYzCn7n
         zeXb7pT+C9Gz5le8RkOGAWq+bBlUK91FnvkrrbRD28IhqmoteG3VTndSajAleJ+FvpYq
         OaXL9IXzvlhTpI2SD1eba5O9qqpPLBdDM6j9xIcwGptdRJpHYm1tg6e2ffyasMwMfk2+
         qmgtIOia1OwkbzWrgTkQqzAwtuwi4+zQJdiwWXuHxxVH1Yz8bzp1EddeTw4Pr/aNDV/4
         SJ19Dd4wzohHgEeH/pwc9GdJRcWwL6hvxo9GcrzuTwwcvhbGUu99KcFZxl4ZtEL4bcgZ
         QA3w==
X-Gm-Message-State: AOJu0YxYEpdSostp+m68fhO5u5N8KTEmOD8tI2btrflQTPesOSJRvL2q
        DY6Y3jf3KwvqhIibzlw9E7GNJpWX869x4vjdD09zxlqr
X-Google-Smtp-Source: AGHT+IGTEI1BPs3UEyFbYgc8C1ncNI8GJCkkpCBNOeWMT9T1hHsiqtQN/01bTQrOyIMcHqy95M/hMg==
X-Received: by 2002:a50:d7cd:0:b0:54b:5a7:1435 with SMTP id m13-20020a50d7cd000000b0054b05a71435mr3367302edj.4.1701598738839;
        Sun, 03 Dec 2023 02:18:58 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id z14-20020a056402274e00b0054c9211021csm1269829edd.69.2023.12.03.02.18.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 02:18:57 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-54cae99a48aso577613a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 02:18:57 -0800 (PST)
X-Received: by 2002:a50:bae4:0:b0:548:5671:c86d with SMTP id
 x91-20020a50bae4000000b005485671c86dmr4168613ede.2.1701598737151; Sun, 03 Dec
 2023 02:18:57 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Dec 2023 19:18:40 +0900
X-Gmail-Original-Message-ID: <CAHk-=wjsbytYq780PM-Wby_2rPabxg-WT-CRPZZaVYsmLiacHw@mail.gmail.com>
Message-ID: <CAHk-=wjsbytYq780PM-Wby_2rPabxg-WT-CRPZZaVYsmLiacHw@mail.gmail.com>
Subject: Linux 6.7-rc4
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

Another -rc with slightly odd timing due to time zones and travel
(hey, it's Sunday afternoon *somewhere* right now), but it's the last
trip of the year, so we won't be seeing any more of that.

Of course, instead of travel, we have the holidays coming up. As
usual, that makes for an interesting release cadence, but at least
this time I think the timing ends up working out, with the holidays
happening during the tail end of the release schedule.

And that "tail end of the release schedule" is while the current 6.7
release is supposed to be very quiet anyway, which sounds nice and
like it all is working out just fine from a timing perspective.  But
the tail end of the release is then also when developers are supposed
to get ready for the _next_ merge window.

So while it all looks superficially convenient from a 6.7 release
schedule, it almost certainly means that we'll have to do something
about the 6.8 merge window.

We'll see. Maybe people will decide to try to get their ducks lined up
super-early for 6.8, or maybe we'll delay the next merge window or
something. I haven't decided yet, and nobody has emailed me in a panic
about it (yet).

*Anyway*, right now we're still a few weeks away from that, and this
is just the rc4 release. And things look fine for now, with a fairly
small rc4 - although that might also be due to me not being the only
developer on the road for conferences...

The appended shortlog gives the details, but the last week looks
pretty normal, with drivers dominating (drm and particularly the AMD
GPU side showing up in the diffstat). But we've got a little bit of
everything, including tooling, filesystems (bcachefs showing up, but
noise elsewhere too) and core networking. Some minor architecture
fixes too.

Please test,

          Linus

---

Abdul Halim, Mohd Syazwan (1):
      iommu/vt-d: Add MTL to quirk list to skip TE disabling

Adrian Hunter (6):
      mmc: block: Do not lose cache flush during CQE error recovery
      mmc: cqhci: Increase recovery halt timeout
      mmc: block: Be sure to wait while busy in CQE error recovery
      mmc: block: Retry commands in CQE error recovery
      mmc: cqhci: Warn of halt or task clear failure
      mmc: cqhci: Fix task clearing in CQE error recovery

Alex Deucher (1):
      drm/amdgpu: fix AGP addressing when GART is not at 0

Alex Sierra (1):
      drm/amdgpu: Force order between a read and write to the same address

Alvin Lee (3):
      drm/amd/display: Include udelay when waiting for INBOX0 ACK
      drm/amd/display: Use DRAM speed from validation for dummy p-state
      drm/amd/display: Increase num voltage states to 40

Antonio Borneo (1):
      pinctrl: stm32: fix array read out of bound

Ard Biesheuvel (1):
      arm64: Avoid enabling KPTI unnecessarily

Arnaldo Carvalho de Melo (1):
      tools: Disable __packed attribute compiler warning due to
-Werror=3Dattributes

Arnd Bergmann (1):
      media: pci: mgb4: add COMMON_CLK dependency

Ayush Jain (1):
      cpufreq/amd-pstate: Only print supported EPP values for
performance governor

Bart Van Assche (1):
      block: Document the role of the two attribute groups

Ben Greear (1):
      wifi: mac80211: handle 320 MHz in ieee80211_ht_cap_ie_to_sta_ht_cap

Bragatheswaran Manickavel (1):
      btrfs: ref-verify: fix memory leaks in btrfs_ref_tree_mod()

Brett Creeley (2):
      vfio/pds: Fix mutex lock->magic !=3D lock warning
      vfio/pds: Fix possible sleep while in atomic context

Brian Foster (1):
      bcachefs: preserve device path as device name

Camille Cho (1):
      drm/amd/display: Simplify brightness initialization

Candice Li (1):
      drm/amdgpu: Update EEPROM I2C address for smu v13_0_0

Charles Keepax (1):
      pinctrl: lochnagar: Don't build on MIPS

Chen Ni (1):
      pinctrl: stm32: Add check for devm_kcalloc

Chester Lin (2):
      pinctrl: s32cc: Avoid possible string truncation
      dt-bindings: pinctrl: s32g2: change a maintainer email address

Christian K=C3=B6nig (1):
      dma-buf: fix check in dma_resv_add_fence

Christoph Niedermaier (1):
      cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Claudiu Beznea (6):
      net: ravb: Check return value of reset_control_deassert()
      net: ravb: Use pm_runtime_resume_and_get()
      net: ravb: Make write access to CXR35 first before accessing
other EMAC registers
      net: ravb: Start TX queues after HW initialization succeeded
      net: ravb: Stop DMA in case of failures on ravb_open()
      net: ravb: Keep reverse order of operations in ravb_remove()

Damien Le Moal (2):
      scsi: Change SCSI device boolean fields to single bit flags
      scsi: sd: Fix system start for ATA devices

Dan Carpenter (4):
      media: v4l2-subdev: Fix a 64bit bug
      wifi: iwlwifi: mvm: fix an error code in iwl_mvm_mld_add_sta()
      xen/events: fix error code in xen_bind_pirq_msi_to_irq()
      nouveau/gsp/r535: remove a stray unlock in r535_gsp_rpc_send()

Daniel Borkmann (1):
      netkit: Reject IFLA_NETKIT_PEER_INFO in netkit_change_link

Daniel Mentz (1):
      iommu: Fix printk arg in of_iommu_get_resv_regions()

Dave Airlie (1):
      nouveau: find the smallest page allocation to cover a buffer alloc.

Dave Ertman (1):
      ice: Fix VF Reset paths when interface in a failed over aggregate

Dave Jiang (1):
      ACPI: Fix ARM32 platforms compile issue introduced by fw_table change=
s

David Howells (2):
      cifs: Fix FALLOC_FL_ZERO_RANGE by setting i_size if EOF moved
      cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size after EOF moved

David Sterba (1):
      btrfs: fix 64bit compat send ioctl arguments not initializing
version member

Dinghao Liu (1):
      drm/amd/pm: fix a memleak in aldebaran_tables_init

Dmitry Antipov (2):
      uapi: propagate __struct_group() attributes to the container union
      smb: client, common: fix fortify warnings

Dmitry Baryshkov (1):
      MAINTAINERS: list all Qualcomm IOMMU drivers in the QUALCOMM IOMMU en=
try

Dmytro Laktyushkin (1):
      drm/amd/display: update dcn315 lpddr pstate latency

Edward Adam Davis (1):
      mptcp: fix uninit-value in mptcp_incoming_options

Elena Salomatkina (1):
      octeontx2-af: Fix possible buffer overflow

Ewan D. Milne (1):
      nvme: check for valid nvme_identify_ns() before using it

Felix Kuehling (1):
      Revert "drm/prime: Unexport helpers for fd/handle conversion"

Filipe Manana (2):
      btrfs: fix off-by-one when checking chunk map includes logical addres=
s
      btrfs: make error messages more clear when getting a chunk map

Furong Xu (1):
      net: stmmac: xgmac: Disable FPE MMC interrupts

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Fix the return value of amd_pstate_fast_switch()

Geetha sowjanya (1):
      octeontx2-pf: Fix adding mbox work queue entry when num_vfs > 64

Greg Ungerer (2):
      net: dsa: mv88e6xxx: fix marvell 6350 switch probing
      net: dsa: mv88e6xxx: fix marvell 6350 probe crash

Gustavo A. R. Silva (3):
      gcc-plugins: randstruct: Update code comment in relayout_struct()
      neighbour: Fix __randomize_layout crash in struct neighbour
      nouveau/gsp: replace zero-length array with flex-array member
and use __counted_by

Hamza Mahfooz (1):
      drm/amd/display: fix ABM disablement

Hans de Goede (1):
      ACPI: video: Use acpi_video_device for cooling-dev driver data

Hawking Zhang (1):
      drm/amdgpu: Do not issue gpu reset from nbio v7_9 bif interrupt

Heiner Kallweit (2):
      r8169: fix deadlock on RTL8125 in jumbo mtu mode
      r8169: prevent potential deadlock in rtl8169_close

Hou Tao (1):
      bpf: Add missed allocation hint for bpf_mem_cache_alloc_flags()

Ilya Bakoulin (1):
      drm/amd/display: Fix MPCC 1DLUT programming

Ioana Ciornei (2):
      dpaa2-eth: increase the needed headroom to account for alignment
      dpaa2-eth: recycle the RX buffer only after all processing done

JP Kobryn (1):
      kprobes: consistent rcu api usage for kretprobe holder

Jakub Kicinski (2):
      ethtool: don't propagate EOPNOTSUPP from dumps
      tools: ynl-gen: always construct struct ynl_req_state

Jann Horn (1):
      btrfs: send: ensure send_fd is writable

Jason Gunthorpe (1):
      iommu: Flow ERR_PTR out from __iommu_domain_alloc()

Jens Axboe (8):
      io_uring: don't allow discontig pages for IORING_SETUP_NO_MMAP
      io_uring: don't guard IORING_OFF_PBUF_RING with SETUP_NO_MMAP
      io_uring: enable io_mem_alloc/free to be used in other parts
      io_uring/kbuf: defer release of mapped buffer rings
      io_uring/kbuf: recycle freed mapped buffer ring entries
      io_uring/kbuf: prune deferred locked cache when tearing down
      io_uring: free io_buffer_list entries via RCU
      io_uring: use fget/fput consistently

Jiawen Wu (1):
      net: libwx: fix memory leak on msix entry

Johannes Berg (9):
      wifi: cfg80211: fix CQM for non-range use
      wifi: cfg80211: lock wiphy mutex for rfkill poll
      wifi: cfg80211: hold wiphy mutex for send_interface
      debugfs: fix automount d_fsdata usage
      debugfs: annotate debugfs handlers vs. removal with lockdep
      debugfs: add API to allow debugfs operations cancellation
      wifi: cfg80211: add locked debugfs wrappers
      wifi: mac80211: use wiphy locked debugfs helpers for agg_status
      wifi: mac80211: use wiphy locked debugfs for sdata/link

John Fastabend (2):
      bpf, sockmap: af_unix stream sockets need to hold ref for pair sock
      bpf, sockmap: Add af_unix test with both sockets in map

Jonathan Kim (1):
      drm/amdgpu: update xgmi num links info post gc9.4.2

Juergen Gross (1):
      x86/xen: fix percpu vcpu_info allocation

Kailang Yang (2):
      ALSA: hda/realtek: Headset Mic VREF to 100%
      ALSA: hda/realtek: Add supported ALC257 for ChromeOS

Keith Busch (1):
      nvme-core: check for too small lba shift

Kent Overstreet (22):
      closures: CLOSURE_CALLBACK() to fix type punning
      bcachefs: Put erasure coding behind an EXPERIMENTAL kconfig option
      bcachefs: bch2_moving_ctxt_flush_all()
      bcachefs: Make sure bch2_move_ratelimit() also waits for move_ops
      bcachefs: Don't stop copygc thread on device resize
      bcachefs: Start gc, copygc, rebalance threads after initing writes re=
f
      bcachefs: Fix an endianness conversion
      bcachefs: Proper refcounting for journal_keys
      bcachefs: deallocate_extra_replicas()
      bcachefs: Data update path won't accidentaly grow replicas
      bcachefs: Fix ec + durability calculation
      bcachefs: bpos is misaligned on big endian
      bcachefs: Fix zstd compress workspace size
      bcachefs: Add missing validation for jset_entry_data_usage
      bcachefs: Fix bucket data type for stripe buckets
      bcachefs: Fix split_race livelock
      bcachefs: trace_move_extent_start_fail() now includes errcode
      bcachefs: -EROFS doesn't count as move_extent_start_fail
      bcachefs: move journal seq assertion
      bcachefs: Fix race between btree writes and metadata drop
      bcachefs: Convert gc_alloc_start() to for_each_btree_key2()
      bcachefs: Extra kthread_should_stop() calls for copygc

Kornel Dul=C4=99ba (1):
      mmc: sdhci-pci-gli: Disable LPM during initialization

Kunwu Chan (1):
      iommu/vt-d: Set variable intel_dirty_ops to static

Laurent Pinchart (1):
      media: vsp1: Remove unbalanced .s_stream(0) calls

Li Ma (1):
      drm/amdgpu: add init_registers for nbio v7.11

Lijo Lazar (1):
      drm/amdgpu: Use another offset for GC 9.4.3 remap

Linus Torvalds (1):
      Linux 6.7-rc4

Linus Walleij (4):
      pinctrl: cy8c95x0: Fix doc warning
      Revert "drm/bridge: panel: Check device dependency before
managing device link"
      Revert "driver core: Export device_is_dependent() to modules"
      Revert "drm/bridge: panel: Add a device link between drm device
and panel device"

Liu Ying (2):
      drm/bridge: panel: Check device dependency before managing device lin=
k
      driver core: Export device_is_dependent() to modules

Lorenzo Bianconi (1):
      wifi: mt76: mt7925: fix typo in mt7925_init_he_caps

Lu Baolu (5):
      iommu/vt-d: Support enforce_cache_coherency only for empty domains
      iommu/vt-d: Omit devTLB invalidation requests when TES=3D0
      iommu/vt-d: Disable PCI ATS in legacy passthrough mode
      iommu/vt-d: Make context clearing consistent with context mapping
      iommu/vt-d: Fix incorrect cache invalidation for mm notification

Lu Yao (1):
      drm/amdgpu: Fix cat debugfs amdgpu_regs_didt causes kernel null point=
er

Lukasz Luba (1):
      powercap: DTPM: Fix unneeded conversions to micro-Watts

Maria Yu (1):
      pinctrl: avoid reload of p state in list iteration

Mario Limonciello (1):
      drm/amd: Enable PCIe PME from D3

Mark O'Donovan (1):
      nvme: fine-tune sending of first keep-alive

Markus Weippert (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR

Martin T=C5=AFma (1):
      media: mgb4: Added support for T200 card variant

Masami Hiramatsu (Google) (1):
      rethook: Use __rcu pointer for rethook::handler

Maurizio Lombardi (1):
      nvme-core: fix a memory leak in nvme_ns_info_from_identify()

Maxime Ripard (1):
      kunit: Warn if tests are slow

Michael Roth (1):
      efi/unaccepted: Fix off-by-one when checking for overlapping ranges

Michael Strauss (1):
      drm/amd/display: Do not read DPREFCLK spread info from LUT on DCN35

Michael-CY Lee (1):
      wifi: avoid offset calculation on NULL pointer

Michal Wajdeczko (1):
      kunit: Reset suite counter right before running tests

Mikulas Patocka (2):
      dm-verity: align struct dm_verity_fec_io properly
      dm-flakey: start allocating with MAX_ORDER

Ming Lei (2):
      block: move .bd_inode into 1st cacheline of block_device
      blk-mq: don't count completed flush data request as inflight in
case of quiesce

Ming Yen Hsieh (1):
      wifi: mt76: mt7921: fix 6GHz disabled by the missing default CLC conf=
ig

Mukul Joshi (1):
      drm/amdkfd: Use common function for IP version check

Namhyung Kim (14):
      tools headers UAPI: Update tools's copy of drm headers
      tools headers UAPI: Update tools's copy of fscrypt.h header
      tools headers UAPI: Update tools's copy of kvm.h header
      tools headers UAPI: Update tools's copy of mount.h header
      tools headers UAPI: Update tools's copy of vhost.h header
      tools headers UAPI: Update tools's copy of unistd.h header
      tools headers: Update tools's copy of socket.h header
      tools headers: Update tools's copy of x86/asm headers
      tools headers: Update tools's copy of arm64/asm headers
      tools headers: Update tools's copy of s390/asm headers
      tools/perf: Update tools's copy of x86 syscall table
      tools/perf: Update tools's copy of powerpc syscall table
      tools/perf: Update tools's copy of s390 syscall table
      tools/perf: Update tools's copy of mips syscall table

Namjae Jeon (6):
      ksmbd: fix possible deadlock in smb2_open
      ksmbd: separately allocate ci per dentry
      ksmbd: move oplock handling after unlock parent dir
      ksmbd: release interim response after sending status pending response
      ksmbd: move setting SMB2_FLAGS_ASYNC_COMMAND and AsyncId
      ksmbd: don't update ->op_state as OPLOCK_STATE_NONE on error

Nicholas Kazlauskas (8):
      drm/amd/display: Add z-state support policy for dcn35
      drm/amd/display: Update DCN35 watermarks
      drm/amd/display: Add Z8 watermarks for DML2 bbox overrides
      drm/amd/display: Feed SR and Z8 watermarks into DML2 for DCN35
      drm/amd/display: Remove min_dst_y_next_start check for Z8
      drm/amd/display: Update min Z8 residency time to 2100 for DCN314
      drm/amd/display: Update DCN35 clock table policy
      drm/amd/display: Allow DTBCLK disable for DCN35

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: Fix KVM_RUN clobbering FP/VEC user registers

Old=C5=99ich Jedli=C4=8Dka (1):
      wifi: mac80211: do not pass AP_VLAN vif pointer to drivers during flu=
sh

Oliver Upton (2):
      tools perf: Add arm64 sysreg files to MANIFEST
      perf build: Ensure sysreg-defs Makefile respects output dir

Paulo Alcantara (2):
      smb: client: fix missing mode bits for SMB symlinks
      smb: client: report correct st_size for SMB and NFS symlinks

Perry Yuan (1):
      drm/amdgpu: optimize RLC powerdown notification on Vangogh

Peter Ujfalusi (1):
      ALSA: hda: intel-nhlt: Ignore vbps when looking for DMIC 32 bps forma=
t

Peter Wang (1):
      scsi: ufs: core: Clear cmd if abort succeeds in MCQ mode

Prike Liang (1):
      drm/amdgpu: correct the amdgpu runtime dereference usage count

Qu Wenruo (4):
      btrfs: tree-checker: add type and sequence check for inline backrefs
      btrfs: do not abort transaction if there is already an existing qgrou=
p
      btrfs: add dmesg output for first mount and last unmount of a filesys=
tem
      btrfs: free the allocated memory if btrfs_alloc_page_array() fails

Richard Fitzgerald (2):
      kunit: test: Avoid cast warning when adding kfree() as an action
      ALSA: hda: cs35l56: Enable low-power hibernation mode on SPI

Ritesh Harjani (IBM) (1):
      ext2: Fix ki_pos update for DIO buffered-io fallback case

Robin Murphy (1):
      iommu: Avoid more races around device probe

Sean Christopherson (1):
      vfio: Drop vfio_file_iommu_group() stub to fudge around a KVM wart

Stanislav Fomichev (1):
      netdevsim: Don't accept device bound programs

Stefan Binding (2):
      ALSA: hda: cs35l41: Remove unnecessary boolean state variable
firmware_running
      ALSA: cs35l41: Fix for old systems which do not support command

Stephan Gerhold (3):
      cpufreq: qcom-nvmem: Enable virtual power domain devices
      cpufreq: qcom-nvmem: Preserve PM domain votes in system suspend
      pmdomain: qcom: rpmpd: Set GENPD_FLAG_ACTIVE_WAKEUP

Subbaraya Sundeep (1):
      octeontx2-pf: Restore TC ingress police rules when interface is up

Sung Joon Kim (1):
      drm/amd/display: Fix black screen on video playback with embedded pan=
el

Taimur Hassan (3):
      drm/amd/display: Remove config update
      drm/amd/display: Fix conversions between bytes and KB
      drm/amd/display: Fix some HostVM parameters in DML

Takashi Iwai (2):
      leds: class: Don't expose color sysfs entry
      ALSA: hda: Disable power-save on KONTRON SinglePC

Thomas Hellstr=C3=B6m (1):
      drm/gpuvm: Fix deprecated license identifier

Tim Huang (1):
      drm/amdgpu: fix memory overflow in the IB test

Timothy Pearson (1):
      powerpc: Don't clobber f0/vs0 during fp|altivec register save

Tvrtko Ursulin (1):
      drm/i915/gsc: Mark internal GSC engine with reserved uabi class

Tzuyi Chang (1):
      pinctrl: realtek: Fix logical error when finding descriptor

Ulf Hansson (1):
      pmdomain: arm: Avoid polling for scmi_perf_domain

Vasiliy Kovalev (1):
      ALSA: hda - Fix speaker and headset mic pin config for CHUWI CoreBook=
 XPro

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Also check for VGA converter in eDP probe
      drm/i915: Call intel_pre_plane_updates() also for pipes getting enabl=
ed

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix vqmmc not shutting down after the card was pulle=
d

Wenjing Liu (1):
      drm/amd/display: fix a pipe mapping error in dcn32_fpu

Willem de Bruijn (4):
      selftests/net: ipsec: fix constant out of range
      selftests/net: fix a char signedness issue
      selftests/net: unix: fix unused variable compiler warning
      selftests/net: mptcp: fix uninitialized variable warnings

Wu Bo (2):
      dm verity: initialize fec io before freeing it
      dm verity: don't perform FEC for failed readahead IO

Wyes Karny (1):
      cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update

Yang Jihong (2):
      perf kwork: Fix a build error on 32-bit
      perf lock contention: Fix a build error on 32-bit

Yang Yingliang (2):
      drm/panel: nt36523: fix return value check in nt36523_probe()
      firewire: core: fix possible memory leak in create_units()

Yoshihiro Shimoda (4):
      net: rswitch: Fix type of ret in rswitch_start_xmit()
      net: rswitch: Fix return value in rswitch_start_xmit()
      net: rswitch: Fix missing dev_kfree_skb_any() in error path
      ravb: Fix races between ravb_tx_timeout_work() and net related ops

Yu Kuai (1):
      block: warn once for each partition in bio_check_ro()

ZhenGuo Yin (1):
      drm/amdkfd: Free gang_ctx_bo and wptr_bo in pqm_uninit

Zhengchao Shao (1):
      ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet

Zhongwei (1):
      drm/amd/display: force toggle rate wa for first link training
for a retimer

Zongmin Zhou (1):
      ksmbd: prevent memory leak on error return

ndesaulniers@google.com (1):
      MAINTAINERS: refresh LLVM support

wuqiang.matt (1):
      lib: objpool: fix head overrun on RK3588 SBC

xiazhengqiao (1):
      drm/panel: starry-2081101qfh032011-53g: Fine tune the panel power seq=
uence
