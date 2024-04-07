Return-Path: <linux-kernel+bounces-134642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6F89B405
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879A81C20C2F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426A93A267;
	Sun,  7 Apr 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZuymHfSx"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361AC1E864
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712522385; cv=none; b=a4VndpBtPkLKtk+JleXaSMcdMxCaMN1Xf1z0CFsSQL0N/B7XXr+XrP4wZ4JIIPihfIMfq/fzoEB5l6xr8lVER8/OIwWiVKPvP80uGV8zYyCFVFEIY5yt9tjAQIKFVrGlpUw957C7nQhNFLwpFHSmD/HDRfXpPAfqczjU71Y5jHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712522385; c=relaxed/simple;
	bh=vifw6lZpDLpzov9SuC+JasjNeyxHNHXUTiuUNkw4U5I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dpOjVZa4fp8qcy7Zf0uTggN7KMjr1K/mOY3sQmEyWgDJoZQESrnR9M9iAUXRNmGPGSdHlQ/lfjDF5IRzLXINVlLVvWdQnjtuTv72vlFl7lqDDiRJfj/Kv1uGZ6b0xgySD+1i5j3JeokdgCev/PJSOSczxYWeuReHqfE6849dcTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZuymHfSx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51daa8242cso6861966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712522380; x=1713127180; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/BlXEHyKgtJyz9Jxo/jQpId3pGFYJZqxPAXLaNMLBys=;
        b=ZuymHfSxy1P/rd3rAHI6X7/IG1QBPH3SF2krsLjP/9zhXdKLIbO252tStA7HniSiI1
         yaMKBKynR3bqOR1fI+awI2o0vOYNi5S04319G9ds2G6EfOxqqkWw71tvaW4BF+PiZWY5
         NDCUcn//th/T4M9N8ih7h4uyPf7foR5L1/95w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712522380; x=1713127180;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BlXEHyKgtJyz9Jxo/jQpId3pGFYJZqxPAXLaNMLBys=;
        b=NlwYIZRAMgGd/OOPU7aJL4uDXaWHS8Ojww9FUCh3QouVPlj6ct9BZeK4drYYs3no37
         VxGMUi+Dq54OWWIfh9mf2r+5A+MwZQmm9ueMR10Sk/Z+1DHVXe1V0Ui6pFmA7Gx+sRNm
         kaYwLUWmrFbd41GSC4hJx7Hx3IbQb6yZu8DthpKrbX7DV+1vujnQnQ1HS4ByGeLUoqdN
         YnVJKr13lO3PoUTDuf5su/2BvElVXgj7D//cXM6ehyViBsgSm4hY9cJHxxQEKEHoeMVP
         am6+ukl1lgWbCfEqXKfpphdMlGNnxzopi2zN6wlftiyQGkLq/shHugl0SB8rhPCiAfgG
         MC/Q==
X-Gm-Message-State: AOJu0YzBnuveygQQ8mNg28fjrBpCPQSTilRjwN2zd1OZe+P6f+fH70Eb
	AY9imOElgBUSH+oVHD/eHELgWRmXoA6wMd6VHUBVC3084FQVvaKC9ottoeXuUxv/8nejFgs9sFL
	h
X-Google-Smtp-Source: AGHT+IGdUL7mycpDxWTf4MTWWPk+k0734eGM5pEDXfQn/X95glgIuk+EBkd3ZAahk4jvRTQ1a6E9dg==
X-Received: by 2002:a17:906:3c59:b0:a51:9d1d:a96e with SMTP id i25-20020a1709063c5900b00a519d1da96emr4575441ejg.68.1712522379833;
        Sun, 07 Apr 2024 13:39:39 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id j5-20020a170906830500b00a4734125fd2sm3541355ejx.31.2024.04.07.13.39.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 13:39:39 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a519e04b142so325958166b.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 13:39:38 -0700 (PDT)
X-Received: by 2002:a17:907:94c7:b0:a51:d3da:99a9 with SMTP id
 dn7-20020a17090794c700b00a51d3da99a9mr1091593ejc.51.1712522378227; Sun, 07
 Apr 2024 13:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Apr 2024 13:39:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDuqyVC6xMkOnNt2EeTd-s4uqa3sYghj5UzkELFW2bpw@mail.gmail.com>
Message-ID: <CAHk-=whDuqyVC6xMkOnNt2EeTd-s4uqa3sYghj5UzkELFW2bpw@mail.gmail.com>
Subject: Linux 6.9-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, so this rc3 looks a bit different than the usual ones, because
there's a large series to bcachefs to do filesystem repair after
corruption. Not normally something we'd see in an rc kernel, but hey,
if you had a corrupted bcachefs filesystem you'd probably want this,
and if you thought bcachefs was stable already, I have a bridge to
sell you. Special deal only for you, real cheap.

The bcachefs part is a bit over a third of the patch, and if you
ignore that part, things look fairly normal, although there's perhaps
a bit more sound SoC noise than is common.

So the rest is mostly drivers (already mentioned sound, but also
networking and gpu), architecture fixes (mainly x86 and s390, some
arm64), some other filesystem noise (mainly smb client), some selftest
updates, and a random smattering elsewhere.

It's not really all that big, although the bcachefs changes do make it
bigger than typical for an rc3.

Shortlog appended, please keep testing,

                 Linus

---

Adam Goldman (1):
      firewire: ohci: mask bus reset interrupts between ISR and bottom half

Aleksandr Loktionov (2):
      i40e: fix i40e_count_filters() to count only active/new filters
      i40e: fix vf may be used uninitialized in this function warning

Aleksandr Mishin (2):
      net: phy: micrel: Fix potential null pointer dereference
      octeontx2-af: Add array index check

Alexandre Ghiti (2):
      riscv: Fix warning by declaring arch_cpu_idle() as noinstr
      riscv: Disable preemption when using patch_map()

Alexey Makhalov (1):
      MAINTAINERS: change vmware.com addresses to broadcom.com

Amadeusz S=C5=82awi=C5=84ski (1):
      ASoC: Intel: avs: boards: Add modules description

Andi Shyti (4):
      drm/i915/gt: Limit the reserved VM space to only the platforms
that need it
      drm/i915/gt: Disable HW load balancing for CCS
      drm/i915/gt: Do not generate the command streamer for all the CCS
      drm/i915/gt: Enable only one CCS for compute workload

Andreas Schwab (1):
      riscv: use KERN_INFO in do_trap

Andrey Albershteyn (1):
      xfs: allow cross-linking special files without project quota

Andrii Nakryiko (2):
      bpf: put uprobe link's path and task in release callback
      bpf: support deferring bpf_link dealloc to after RCU grace period

Andr=C3=A9 Apitzsch (1):
      regulator: tps65132: Add of_match table

Ankit Nautiyal (1):
      drm/i915/dp: Fix the computation for compressed_bpp for DISPLAY < 13

Anna-Maria Behnsen (1):
      timers/migration: Return early on deactivation

Antoine Tenart (5):
      udp: do not accept non-tunnel GSO skbs landing in a tunnel
      gro: fix ownership transfer
      udp: do not transition UDP GRO fraglist partial checksums to unnecess=
ary
      udp: prevent local UDP tunnel packets from being GROed
      selftests: net: gro fwd: update vxlan GRO test expectations

Anton Protopopov (1):
      bpf: fix possible file descriptor leaks in verifier

Anup Patel (2):
      RISC-V: KVM: Fix APLIC setipnum_le/be write emulation
      RISC-V: KVM: Fix APLIC in_clrip[x] read emulation

Arnd Bergmann (6):
      ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit
      scsi: mylex: Fix sysfs buffer lengths
      vdso: Use CONFIG_PAGE_SHIFT in vdso/datapage.h
      i2c: pxa: hide unused icr_bits[] variable
      ata: sata_mv: Fix PCI device ID table declaration compilation warning
      x86/numa/32: Include missing <asm/pgtable_areas.h>

Arun R Murthy (1):
      drm/i915/dp: Remove support for UHBR13.5

Ashish Kalra (1):
      KVM: SVM: Add support for allowing zero SEV ASIDs

Atlas Yu (1):
      r8169: skip DASH fw status checks when DASH is disabled

Bartosz Golaszewski (1):
      gpio: cdev: check for NULL labels when sanitizing them for irqs

Bastien Nocera (1):
      Bluetooth: Fix TOCTOU in HCI debugfs implementation

Bj=C3=B6rn T=C3=B6pel (1):
      riscv: Fix vector state restore in rt_sigreturn()

Borislav Petkov (AMD) (6):
      x86/retpoline: Do the necessary fixup to the Zen3/4 srso return
thunk for !SRSO
      x86/kvm/Kconfig: Have KVM_AMD_SEV select ARCH_HAS_CC_PLATFORM
      x86/cc: Add cc_platform_set/_clear() helpers
      x86/CPU/AMD: Track SNP host status with cc_platform_*()
      x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
      x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk

Brendan Jackman (1):
      Documentation: dev-tools: Add link to RV docs

Carlos Song (1):
      spi: spi-fsl-lpspi: remove redundant spi_controller_put call

Chaitanya Kumar Borah (1):
      ASoC: SOF: Core: Add remove_late() to sof_init_environment failure pa=
th

Charles Keepax (1):
      ASoC: cs42l43: Correct extraction of data pointer in suspend/resume

Chen Ni (1):
      ata: sata_gemini: Check clk_enable() result

Chengming Zhou (1):
      9p: remove SLAB_MEM_SPREAD flag usage

Christian Bendiksen (1):
      ALSA: hda/realtek: Add sound quirks for Lenovo Legion slim 7
16ARHA7 models

Christian Brauner (3):
      block: handle BLK_OPEN_RESTRICT_WRITES correctly
      block: count BLK_OPEN_RESTRICT_WRITES openers
      fs,block: yield devices early

Christian G=C3=B6ttsche (1):
      selinux: avoid dereference of garbage after mount failure

Christian Hewitt (1):
      drm/panfrost: fix power transition timeout warnings

Christoffer Sandberg (1):
      ALSA: hda/realtek - Fix inactive headset mic jack

Christoph Hellwig (3):
      nvme-multipath: don't inherit LBA-related fields for the multipath no=
de
      nvme: split nvme_update_zone_info
      nvme: don't create a multipath node for zero capacity devices

Christophe JAILLET (4):
      ata: ahci_st: Remove an unused field in struct st_ahci_drv_data
      vboxsf: Avoid an spurious warning if load_nls_xxx() fails
      vboxsf: Remove usage of the deprecated ida_simple_xx() API
      net: dsa: sja1105: Fix parameters order in sja1110_pcs_mdio_write_c45=
()

Chuck Lever (1):
      SUNRPC: Fix a slow server-side memory leak with RPC-over-TCP

Colin Ian King (4):
      KVM: selftests: Fix spelling mistake "trigged" -> "triggered"
      RISC-V: KVM: Remove second semicolon
      drm/nouveau/gr/gf100: Remove second semicolon
      vboxsf: remove redundant variable out_len

Damien Le Moal (1):
      nullblk: Fix cleanup order in null_add_dev() error path

Dan Carpenter (1):
      ice: Fix freeing uninitialized pointers

Daniel Wagner (2):
      nvmet-fc: move RCU read lock to nvmet_fc_assoc_exists
      nvme-fc: rename free_ctrl callback to match name pattern

Dave Airlie (1):
      nouveau/uvmm: fix addr/range calcs for remap operations

David Hildenbrand (2):
      mm/secretmem: fix GUP-fast succeeding on secretmem folios
      x86/mm/pat: fix VM_PAT handling in COW mappings

David Howells (1):
      cifs: Fix caching to try to do open O_WRONLY as rdwr on server

David Thompson (1):
      mlxbf_gige: stop interface during shutdown

Davide Caratti (1):
      mptcp: don't account accept() of non-MPC client as fallback to TCP

Dominique Martinet (1):
      9p: Fix read/write debug statements to report server reply

Donald Hunter (1):
      docs: Fix bitfield handling in kernel-doc

Duanqiang Wen (1):
      net: txgbe: fix i2c dev name cannot match clkdev

Duoming Zhou (1):
      ax25: fix use-after-free bugs caused by ax25_ds_del_timer

Edward Liaw (1):
      selftests/mm: include strings.h for ffsl

Eric Dumazet (5):
      net: do not consume a cacheline for system_page_pool
      erspan: make sure erspan_base_hdr is present in skb->head
      net/sched: fix lockdep splat in qdisc_tree_reduce_backlog()
      net/sched: act_skbmod: prevent kernel-infoleak
      netfilter: validate user input for expected length

Frederic Weisbecker (1):
      timers/migration: Fix ignored event due to missing CPU update

Geliang Tang (1):
      selftests: mptcp: join: fix dev in check_endpoint

Gergo Koteles (1):
      ASoC: tas2781: mark dvc_tlv with __maybe_unused

Guenter Roeck (2):
      mean_and_variance: Drop always failing tests
      nios2: Only use built-in devicetree blob if configured to do so

Haiyang Zhang (1):
      net: mana: Fix Rx DMA datasize and skb_over_panic

Hannes Reinecke (1):
      nvmet: implement unique discovery NQN

Hans de Goede (1):
      gpiolib: Fix triggering "kobject: 'gpiochipX' is not
initialized, yet" kobject_get() errors

Hariprasad Kelam (1):
      octeontx2-af: Fix issue with loading coalesced KPU profiles

Heiko Carstens (1):
      s390/mm: fix NULL pointer dereference

Heiner Kallweit (1):
      r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d

Herve Codina (2):
      driver core: Introduce device_link_wait_removal()
      of: dynamic: Synchronize of_changeset_destroy() with the devlink remo=
vals

Hongbo Li (1):
      bcachefs: fix trans->mem realloc in __bch2_trans_kmalloc

Horatiu Vultur (1):
      net: phy: micrel: lan8814: Fix when enabling/disabling 1-step timesta=
mping

Huai-Yuan Liu (1):
      spi: mchp-pci1xxx: Fix a possible null pointer dereference in
pci1xxx_spi_probe

Hui Wang (1):
      Bluetooth: hci_event: set the conn encrypted before conn establishes

I Gede Agastya Darma Laksana (1):
      ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support
headset with microphone

Ilya Leoshkevich (2):
      s390/atomic: mark all functions __always_inline
      s390/preempt: mark all functions __always_inline

Imre Deak (1):
      drm/i915/dp: Fix DSC state HW readout for SST connectors

Ivan Vecera (2):
      i40e: Enforce software interrupt during busy-poll exit
      i40e: Fix VF MAC filter removal

Jaewon Kim (1):
      spi: s3c64xx: Use DMA mode from fifo size

Jakub Kicinski (1):
      selftests: reuseaddr_conflict: add missing new line at the end
of the output

Jakub Sitnicki (1):
      bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Jason A. Donenfeld (1):
      x86/coco: Require seeding RNG with RDRAND on CoCo systems

Jeff Layton (2):
      vboxsf: explicitly deny setlease attempts
      nfsd: hold a lighter-weight client reference over CB_RECALL_ANY

Jens Axboe (7):
      io_uring/rw: don't allow multishot reads without NOWAIT support
      io_uring: disable io-wq execution of multishot NOWAIT requests
      io_uring: use private workqueue for exit work
      io_uring/kbuf: get rid of lower BGID lists
      io_uring/kbuf: get rid of bl->is_ready
      io_uring/kbuf: protect io_buffer_list teardown with a reference
      io_uring/kbuf: hold io_buffer_list reference over mmap

Jesper Dangaard Brouer (1):
      xen-netfront: Add missing skb_mark_for_recycle

Jisheng Zhang (1):
      riscv: mm: implement pgprot_nx

Joan Bruguera Mic=C3=B3 (1):
      x86/bpf: Fix IP for relocating call depth accounting

Johan Hovold (5):
      Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
      dt-bindings: bluetooth: add 'qcom,local-bd-address-broken'
      arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken
      Bluetooth: add quirk for broken address properties
      Bluetooth: qca: fix device-address endianness

John Sperbeck (1):
      init: open output files from cpio unpacking with O_LARGEFILE

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid the interface always configured as
random address

Joshua Hay (1):
      idpf: fix kernel panic on unknown packet types

Jouni H=C3=B6gander (3):
      drm/i915/psr: Calculate PIPE_SRCSZ_ERLY_TPT value
      drm/i915/psr: Move writing early transport pipe src
      drm/i915/psr: Fix intel_psr2_sel_fetch_et_alignment usage

Justin Stitt (1):
      smb: client: replace deprecated strncpy with strscpy

Kan Liang (1):
      perf/x86/intel/ds: Don't clear ->pebs_data_cfg for the last PEBS even=
t

Kent Gibson (1):
      gpio: cdev: fix missed label sanitizing in debounce_setup()

Kent Overstreet (48):
      bcachefs: Fix assert in bch2_backpointer_invalid()
      bcachefs: Fix journal pins in btree write buffer
      bcachefs: fix mount error path
      bcachefs: Add an assertion for trying to evict btree root
      bcachefs: Move snapshot table size to struct snapshot_table
      bcachefs: Add checks for invalid snapshot IDs
      bcachefs: Don't do extent merging before journal replay is finished
      bcachefs: btree_and_journal_iter now respects
trans->journal_replay_not_finished
      bcachefs: Be careful about btree node splits during journal replay
      bcachefs: Improved topology repair checks
      bcachefs: Check btree ptr min_key in .invalid
      bcachefs: Fix btree node keys accounting in topology repair path
      bcachefs: Fix use after free in bch2_check_fix_ptrs()
      bcachefs: Fix repair path for missing indirect extents
      bcachefs: Fix use after free in check_root_trans()
      bcachefs: Kill bch2_bkey_ptr_data_type()
      bcachefs: Fix bch2_btree_increase_depth()
      bcachefs: fix backpointer for missing alloc key msg
      bcachefs: Split out recovery_passes.c
      bcachefs: Add error messages to logged ops fns
      bcachefs: Resume logged ops after fsck
      bcachefs: Flush journal immediately after replay if we did early repa=
ir
      bcachefs: Ensure bch_sb_field_ext always exists
      bcachefs: bch2_run_explicit_recovery_pass_persistent()
      bcachefs: Improve -o norecovery; opts.recovery_pass_limit
      bcachefs: Logged op errors should be ignored
      bcachefs: Fix remove_dirent()
      bcachefs: Fix overlapping extent repair
      bcachefs: On emergency shutdown, print out current journal sequence n=
umber
      bcachefs: Fix btree node reserve
      bcachefs: BCH_WATERMARK_interior_updates
      bcachefs: fix nocow lock deadlock
      bcachefs: Improve bch2_btree_update_to_text()
      bcachefs: Check for bad needs_discard before doing discard
      bcachefs: ratelimit informational fsck errors
      bcachefs: Clear recovery_passes_required as they complete without err=
ors
      bcachefs: bch2_shoot_down_journal_keys()
      bcachefs: Etyzinger cleanups
      bcachefs: bch2_btree_root_alloc() -> bch2_btree_root_alloc_fake()
      bcachefs: Don't skip fake btree roots in fsck
      bcachefs: Repair pass for scanning for btree nodes
      bcachefs: Topology repair now uses nodes found by scanning to fill ho=
les
      bcachefs: Flag btrees with missing data
      bcachefs: Reconstruct missing snapshot nodes
      bcachefs: Check for extents that point to same space
      bcachefs: Subvolume reconstruction
      bcachefs: reconstruct_inode()
      aio: Fix null ptr deref in aio_complete() wakeup

Krzysztof Kozlowski (11):
      docs: dt-bindings: add missing address/size-cells to example
      dt-bindings: ufs: qcom: document SC8180X UFS
      dt-bindings: ufs: qcom: document SC7180 UFS
      dt-bindings: ufs: qcom: document SM6125 UFS
      ptp: MAINTAINERS: drop Jeff Sipek
      ata: pata_macio: drop driver owner assignment
      dt-bindings: clock: keystone: remove unstable remark
      dt-bindings: clock: ti: remove unstable remark
      dt-bindings: remoteproc: ti,davinci: remove unstable remark
      dt-bindings: soc: fsl: narrow regex for unit address to hex numbers
      dt-bindings: timer: narrow regex for unit address to hex numbers

Kuniyuki Iwashima (9):
      tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6
non-wildcard addresses.
      tcp: Fix bind() regression for v6-only wildcard and
v4(-mapped-v6) non-wildcard addresses.
      selftest: tcp: Make bind() selftest flexible.
      selftest: tcp: Define the reverse order bind() tests explicitly.
      selftest: tcp: Add v4-v4 and v6-v6 bind() conflict tests.
      selftest: tcp: Add more bind() calls.
      selftest: tcp: Add bind() tests for IPV6_V6ONLY.
      selftest: tcp: Add bind() tests for SO_REUSEADDR/SO_REUSEPORT.
      ipv6: Fix infinite recursion in fib6_dump_done().

Li Nan (2):
      scsi: sd: Unregister device if device_add_disk() failed in sd_probe()
      block: fix overflow in blk_ioctl_discard()

Linus Torvalds (1):
      Linux 6.9-rc3

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sy=
nc

Lukasz Majewski (1):
      net: hsr: Use full string description when opening HSR network device

Luke D. Jones (1):
      ALSA: hda/realtek: cs35l41: Support ASUS ROG G634JYR

Mahmoud Adam (1):
      net/rds: fix possible cp null dereference

Marc Zyngier (2):
      arm64: Fix early handling of FEAT_E2H0 not being implemented
      KVM: arm64: Rationalise KVM banner output

Marco Pinna (1):
      vsock/virtio: fix packet delivery to tap device

Mark Brown (1):
      arm64/ptrace: Use saved floating point state type to determine SVE la=
yout

Masahiro Yamada (2):
      riscv: compat_vdso: install compat_vdso.so.dbg to /lib/modules/*/vdso=
/
      riscv: compat_vdso: align VDSOAS build log

Matthew Brost (1):
      drm/xe: Use ordered wq for preempt fence waiting

Michael Krummsdorf (1):
      net: dsa: mv88e6xxx: fix usable ports on 88e6020

Namjae Jeon (3):
      ksmbd: don't send oplock break if rename fails
      ksmbd: validate payload size in ipc response
      ksmbd: do not set SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

Natanael Copa (1):
      tools/resolve_btfids: fix build with musl libc

Nikita Kiryushin (1):
      tg3: Remove residual error handling in tg3_suspend

Nikita Travkin (2):
      thermal: gov_power_allocator: Allow binding without cooling devices
      thermal: gov_power_allocator: Allow binding without trip points

Oleksandr Natalenko (1):
      drm/display: fix typo

Oliver Upton (1):
      KVM: arm64: Fix host-programmed guest events in nVHE

Oswald Buddenhagen (1):
      Revert "ALSA: emu10k1: fix synthesizer sample playback position
and caching"

Pablo Neira Ayuso (5):
      netfilter: nf_tables: release batch on table validation from abort pa=
th
      netfilter: nf_tables: release mutex after nft_gc_seq_end from abort p=
ath
      netfilter: nf_tables: flush pending destroy work before exit_net rele=
ase
      netfilter: nf_tables: reject new basechain after table flag update
      netfilter: nf_tables: discard table flag update with pending
basechain deletion

Paolo Abeni (2):
      mptcp: prevent BPF accessing lowat from a subflow socket.
      Revert "tg3: Remove residual error handling in tg3_suspend"

Paolo Bonzini (3):
      KVM: SEV: fix compat ABI for KVM_MEMORY_ENCRYPT_OP
      Documentation: kvm/sev: separate description of firmware
      Documentation: kvm/sev: clarify usage of KVM_MEMORY_ENCRYPT_OP

Paul Barker (2):
      net: ravb: Always process TX descriptor ring
      net: ravb: Always update error counters

Paulo Alcantara (14):
      smb: client: fix UAF in smb2_reconnect_server()
      smb: client: guarantee refcounted children from parent session
      smb: client: refresh referral without acquiring refpath_lock
      smb: client: handle DFS tcons in cifs_construct_tcon()
      smb: client: serialise cifs_construct_tcon() with cifs_mount_mutex
      smb: client: fix potential UAF in cifs_debug_files_proc_show()
      smb: client: fix potential UAF in cifs_dump_full_key()
      smb: client: fix potential UAF in cifs_stats_proc_write()
      smb: client: fix potential UAF in cifs_stats_proc_show()
      smb: client: fix potential UAF in smb2_is_valid_lease_break()
      smb: client: fix potential UAF in smb2_is_valid_oplock_break()
      smb: client: fix potential UAF in is_valid_oplock_break()
      smb: client: fix potential UAF in smb2_is_network_name_deleted()
      smb: client: fix potential UAF in cifs_signal_cifsd_for_reconnect()

Peter Collingbourne (1):
      stackdepot: rename pool_index to pool_index_plus_1

Peter Ujfalusi (19):
      ASoC: SOF: Add dsp_max_burst_size_in_ms member to snd_sof_pcm_stream
      ASoC: SOF: ipc4-topology: Save the DMA maximum burst size for PCMs
      ASoC: SOF: Intel: hda-pcm: Use dsp_max_burst_size_in_ms to place
constraint
      ASoC: SOF: Intel: hda: Implement get_stream_position (Linear
Link Position)
      ASoC: SOF: Intel: mtl/lnl: Use the generic get_stream_position callba=
ck
      ASoC: SOF: Introduce a new callback pair to be used for PCM
delay reporting
      ASoC: SOF: Intel: Set the dai/host get frame/byte counter callbacks
      ASoC: SOF: ipc4-pcm: Use the snd_sof_pcm_get_dai_frame_counter()
for pcm_delay
      ASoC: SOF: Intel: hda-common-ops: Do not set the
get_stream_position callback
      ASoC: SOF: Remove the get_stream_position callback
      ASoC: SOF: ipc4-pcm: Move struct sof_ipc4_timestamp_info
definition locally
      ASoC: SOF: ipc4-pcm: Combine the SOF_IPC4_PIPE_PAUSED cases in pcm_tr=
igger
      ASoC: SOF: ipc4-pcm: Invalidate the stream_start_offset in PAUSED sta=
te
      ASoC: SOF: sof-pcm: Add pointer callback to sof_ipc_pcm_ops
      ASoC: SOF: ipc4-pcm: Correct the delay calculation
      ALSA: hda: Add pplcllpl/u members to hdac_ext_stream
      ASoC: SOF: Intel: hda: Compensate LLP in case it is not reset
      ASoC: SOF: Intel: hda-dsp: Skip IMR boot on ACE platforms in
case of S3 suspend
      ASoC: SOF: Intel: lnl: Disable DMIC/SSP offload on remove

Peter Wang (2):
      scsi: ufs: core: WLUN suspend dev/link state error recovery
      scsi: ufs: core: Fix MCQ mode dev command timeout

Petr Oros (1):
      ice: fix enabling RX VLAN filtering

Phil Elwell (1):
      net: bcmgenet: Reset RBUF on first open

Pierre-Louis Bossart (6):
      ASoC: rt5682-sdw: fix locking sequence
      ASoC: rt711-sdca: fix locking sequence
      ASoC: rt711-sdw: fix locking sequence
      ASoC: rt712-sdca-sdw: fix locking sequence
      ASoC: rt722-sdca-sdw: fix locking sequence
      ASoC: rt-sdw*: add __func__ to all error logs

Piotr Wejman (1):
      net: stmmac: fix rx queue priority assignment

Pu Lehui (1):
      drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while not supported

Rander Wang (1):
      ASoC: SOF: mtrace: rework mtrace timestamp setting

Randy Dunlap (7):
      9p/trans_fd: remove Excess kernel-doc comment
      time/timecounter: Fix inline documentation
      time/timekeeping: Fix kernel-doc warnings and typos
      timers: Fix kernel-doc format and add Return values
      tick/sched: Fix various kernel-doc warnings
      tick/sched: Fix struct tick_sched doc warnings
      timers: Fix text inconsistencies and spelling

Reinette Chatre (1):
      x86/resctrl: Fix uninitialized memory read when last CPU of
domain goes offline

Richard Fitzgerald (3):
      ASoC: wm_adsp: Fix missing mutex_lock in wm_adsp_write_ctl()
      regmap: maple: Fix cache corruption in regcache_maple_drop()
      regmap: maple: Fix uninitialized symbol 'ret' warnings

Ritvik Budhiraja (1):
      smb3: retrying on failed server close

Rob Clark (1):
      drm/prime: Unbreak virtgpu dma-buf export

Rob Herring (1):
      MAINTAINERS: Add TPM DT bindings to TPM maintainers

Roberto Sassu (1):
      security: Place security_path_post_mknod() where the original IMA cal=
l was

Sami Tolvanen (1):
      riscv: Mark __se_sys_* functions __used

Samuel Holland (2):
      riscv: mm: Fix prototype to avoid discarding const
      riscv: Fix spurious errors from __get/put_kernel_nofault

Sean Christopherson (5):
      KVM: SVM: Set sev->asid in sev_asid_new() instead of overloading
the return
      KVM: SVM: Use unsigned integers when dealing with ASIDs
      KVM: SVM: Return -EINVAL instead of -EBUSY on attempt to re-init
SEV/SEV-ES
      KVM: selftests: Fix __GUEST_ASSERT() format warnings in ARM's
arch timer test
      x86/cpufeatures: Add CPUID_LNX_5 to track recently added
Linux-defined word

Sergey Shtylyov (1):
      of: module: prevent NULL pointer dereference in vsnprintf()

Simon Trimmer (3):
      ASoC: cs-amp-lib: Check for no firmware controls when writing calibra=
tion
      ALSA: hda: cs35l56: Add ACPI device match tables
      ALSA: hda/realtek: Add quirks for ASUS Laptops using CS35L56

Stefan O'Rear (1):
      riscv: process: Fix kernel gp leakage

Stephen Horvath (1):
      ACPI: thermal: Register thermal zones without valid trip points

Stephen Lee (1):
      ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw

Su Hui (1):
      octeontx2-pf: check negative error code in otx2_open()

Sumanth Korikkar (1):
      s390/entry: align system call table on 8 bytes

Takashi Iwai (1):
      ALSA: line6: Zero-initialize message buffers

Tariq Toukan (1):
      MAINTAINERS: mlx5: Add Tariq Toukan

Thomas Bertschinger (1):
      bcachefs: fix misplaced newline in __bch2_inode_unpacked_to_text()

Thomas Hellstr=C3=B6m (4):
      drm/xe: Use ring ops TLB invalidation for rebinds
      drm/xe: Rework rebinding
      drm/xe: Make TLB invalidation fences unordered
      drm/xe: Move vma rebinding to the drm_exec locking loop

Thomas Richter (1):
      s390/pai: fix sampling event removal for PMU device driver

Uladzislau Rezki (Sony) (2):
      mm: vmalloc: bail out early in find_vmap_area() if vmap is not init
      mm: vmalloc: fix lockdep warning

Uros Bizjak (1):
      x86/bpf: Fix IP after emitting call depth accounting

Uwe Kleine-K=C3=B6nig (2):
      pwm: Fix setting period with #pwm-cells =3D <1> and of_pwm_single_xla=
te()
      OSS: dmasound/paula: Mark driver struct with __refdata to
prevent section mismatch

Victor Isaev (1):
      RISC-V: Update AT_VECTOR_SIZE_ARCH for new AT_MINSIGSTKSZ

Vijendar Mukunda (3):
      ASoC: amd: acp: fix for acp pdm configuration check
      ASoC: amd: acp: fix for acp_init function error handling
      ASoC: SOF: amd: fix for false dsp interrupts

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/mst: Limit MST+DSC to TGL+
      drm/i915/mst: Reject FEC+MST on ICL

Vincent Guittot (1):
      PM: EM: fix wrong utilization estimation in em_cpu_energy()

Vitaly Chikunov (1):
      tracing: Fix documentation on tp_printk cmdline option

Vitaly Kuznetsov (3):
      KVM: x86: Introduce __kvm_get_hypervisor_cpuid() helper
      KVM: x86: Use actual kvm_cpuid.base for clearing KVM_FEATURE_PV_UNHAL=
T
      KVM: selftests: Check that PV_UNHALT is cleared when HLT exiting
is disabled

Vitaly Lifshits (2):
      e1000e: Workaround for sporadic MDI error on Meteor Lake systems
      e1000e: move force SMBUS from enable ulp function to avoid PHY loss i=
ssue

Vladimir Isaev (1):
      riscv: hwprobe: do not produce frtace relocation

Wei Fang (1):
      net: fec: Set mac_managed_pm during probe

Weiji Wang (1):
      docs: zswap: fix shell command format

Will Deacon (4):
      KVM: arm64: Don't defer TLB invalidation when zapping table entries
      KVM: arm64: Don't pass a TLBI level hint when zapping table entries
      KVM: arm64: Use TLBI_TTL_UNKNOWN in __kvm_tlb_flush_vmid_range()
      KVM: arm64: Ensure target address is granule-aligned for range TLBI

William Tu (1):
      Documentation: Add documentation for eswitch attribute

Wujie Duan (1):
      KVM: arm64: Fix out-of-IPA space translation fault handling

Xiaoyao Li (2):
      x86/kvm: Use separate percpu variable to track the enabling of asyncp=
f
      KVM: x86: Improve documentation of MSR_KVM_ASYNC_PF_EN

Yihang Li (1):
      scsi: libsas: Align SMP request allocation to ARCH_DMA_MINALIGN

Zhang Yi (4):
      ASoC: codecs: ES8326: Solve error interruption issue
      ASoC: codecs: ES8326: modify clock table
      ASoC: codecs: ES8326: Solve a headphone detection issue after
suspend and resume
      ASoC: codecs: ES8326: Removing the control of ADC_SCALE

Ziyang Xuan (1):
      netfilter: nf_tables: Fix potential data-race in
__nft_flowtable_type_get()

zhuxiaohui (1):
      bcachefs: add REQ_SYNC and REQ_IDLE in write dio

