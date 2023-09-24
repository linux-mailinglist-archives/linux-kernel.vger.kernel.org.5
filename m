Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EB37ACC18
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 23:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjIXVgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 17:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXVgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 17:36:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D9B8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:36:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32329d935d4so379858f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695591400; x=1696196200; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2RhATvAcghwuhcYQhwIiXnR6w9Qtf7gg/Iu9Sssu4ZU=;
        b=bLuni6eTTkdmf1al+m7p2BrXNORGnSg8kkWtJz5NNBdwy7/bVVGby3YoRrsLuUkgrJ
         ruQPUyHsJl/gxBQhbAdj7DRv/Y/ErIASyEVN4lZnlRfhhg6NKvfarxv4VQrgMkUQGqvz
         hDF8UZ1QNPIs4iw24Rc4oHY18KC/xPQOhd0oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695591400; x=1696196200;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RhATvAcghwuhcYQhwIiXnR6w9Qtf7gg/Iu9Sssu4ZU=;
        b=Zq1y9uDRi7UYUQEBktvotqMVWVg7FG2g5Y/UQNqqnH0OsRrDKF3YMwthlH76MA0dl0
         +oXUkDl0I7lpaAcStMbrJ/hHNyex71wxFqnWx/i6IEp9EQEckgoZlsXzcWdAJuyzfOXr
         sNj1Zv2b/VtYEIUroV8o5Fw2wUfU+c+k+tT6Ov3+YrM7D0XsyVg4cMBXBXNpDgtM/4LN
         3eywgqFLWu0WGLGkXOVcVIbjpEkArRK9Q2wLmEL55JWXSDRW5yDn521RIgU34wrQN4Bx
         DowsmstpSoCZ2/jrTuQLh59UNH3StDL3A4Sw25AUmhF/EbXEG9BVeWZNVsvJRV6L/HWY
         msAw==
X-Gm-Message-State: AOJu0Yw+zuieiGM78CfZE090nNpe9dAIMiSKDRcH6Zu4Gp270a7ItnFH
        IfdfwflOHtcq8w2SjPZbk5t9eMjMZ8N0r3gajCGHzg==
X-Google-Smtp-Source: AGHT+IF++95lvCbLXnXdDmsKg7Vs8MrTH0jbK7gEUTAlioi1uCCmp5zzkUGRidnz7FHtfRF7i+qPkQ==
X-Received: by 2002:adf:f004:0:b0:31a:e376:6bd6 with SMTP id j4-20020adff004000000b0031ae3766bd6mr4058055wro.45.1695591399914;
        Sun, 24 Sep 2023 14:36:39 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090614c400b00992b510089asm5395065ejc.84.2023.09.24.14.36.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 14:36:39 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso6200751a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 14:36:39 -0700 (PDT)
X-Received: by 2002:a05:6402:2050:b0:523:b1b0:f69f with SMTP id
 bc16-20020a056402205000b00523b1b0f69fmr3734225edb.32.1695591398593; Sun, 24
 Sep 2023 14:36:38 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 Sep 2023 14:36:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com>
Message-ID: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com>
Subject: Linux 6.6-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another week, another -rc.

As usual, rc3 is a bit larger than rc2, as people have started finding
more issues.

Unusually, we have a large chunk of changes in filesystems. Part of it
is the vfs-level revert of some of the timestamp handling that needs
to soak a bit more, and part of it is some xfs fixes. With a few other
filesystem fixes too.

But drivers and architecture updates are also up there, so it's not
like the fs stuff dominates. It's just more noticeable than it usually
is.

Anyway, please do go test. None of this looks scary,

                 Linus

---

Ahmad Khalifa (1):
      hwmon: (nct6775) Fix non-existent ALARM warning

Alexey Dobriyan (3):
      uapi: stddef.h: Fix header guard location
      uapi: stddef.h: Fix __DECLARE_FLEX_ARRAY for C++
      selftests/proc: fixup proc-empty-vm test after KSM changes

Alison Schofield (2):
      cxl/region: Match auto-discovered region decoders by HPA range
      cxl/region: Refactor granularity select in cxl_port_setup_targets()

Andreas Gruenbacher (1):
      gfs2: Fix another freeze/thaw hang

Andrew Morton (1):
      revert "scripts/gdb/symbols: add specific ko module load command"

Andrii Nakryiko (1):
      selftests/bpf: ensure all CI arches set CONFIG_BPF_KPROBE_OVERRIDE=3D=
y

Andy Shevchenko (2):
      net: core: Use the bitmap API to allocate bitmaps
      LoongArch: Use _UL() and _ULL()

Anna Schumaker (1):
      Revert "SUNRPC: clean up integer overflow check"

Anup Patel (4):
      RISC-V: KVM: Fix KVM_GET_REG_LIST API for ISA_EXT registers
      RISC-V: KVM: Fix riscv_vcpu_get_isa_ext_single() for missing extensio=
ns
      KVM: riscv: selftests: Fix ISA_EXT register handling in get-reg-list
      KVM: riscv: selftests: Selectively filter-out AIA registers

Ard Biesheuvel (1):
      acpi: Provide ia64 dummy implementation of acpi_proc_quirk_mwait_chec=
k()

Arnd Bergmann (2):
      net: ti: icssg-prueth: add PTP dependency
      drm: fix up fbdev Kconfig defaults

Artem Chernyshev (1):
      net: rds: Fix possible NULL-pointer dereference

Artem Savkov (1):
      selftests/bpf: fix unpriv_disabled check in test_verifier

August Wikerfors (1):
      ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG

Bard Liao (1):
      ASoC: SOF: ipc4-topology: fix wrong sizeof argument

Bartosz Golaszewski (1):
      gpio: sim: fix an invalid __free() usage

Ben Skeggs (1):
      MAINTAINERS: remove myself as nouveau maintainer

Ben Wolsieffer (2):
      proc: nommu: /proc/<pid>/maps: release mmap read lock
      proc: nommu: fix empty /proc/<pid>/maps

Benjamin Gray (4):
      powerpc/watchpoints: Disable preemption in thread_change_pc()
      powerpc/watchpoint: Disable pagefaults when getting user instruction
      powerpc/watchpoints: Annotate atomic context in more places
      powerpc/dexcr: Move HASHCHK trap handler

Benjamin Poirier (1):
      vxlan: Add missing entries to vxlan_get_size()

Bernd Schubert (1):
      btrfs: file_remove_privs needs an exclusive lock in direct io write

Bibo Mao (1):
      LoongArch: Fix some build warnings with W=3D1

Bob Peterson (2):
      gfs2: fix glock shrinker ref issues
      gfs2: Fix quota=3Dquiet oversight

Cai Huoqing (1):
      net: hinic: Fix warning-hinic_set_vlan_fliter() warn: variable
dereferenced before check 'hwdev'

Chancel Liu (1):
      ASoC: imx-rpmsg: Set ignore_pmdown_time for dai_link

Charles Keepax (3):
      ASoC: soc-pcm: Shrink stack frame for __soc_pcm_hw_params
      ASoC: cs42l43: Add shared IRQ flag for shutters
      mfd: cs42l43: Use correct macro for new-style PM runtime ops

Chen Ni (1):
      ASoC: hdaudio.c: Add missing check for devm_kstrdup

Christian Brauner (5):
      Revert "tmpfs: add support for multigrain timestamps"
      Revert "xfs: switch to multigrain timestamps"
      Revert "ext4: switch to multigrain timestamps"
      Revert "btrfs: convert to multigrain timestamps"
      Revert "fs: add infrastructure for multigrain timestamps"

Christoph Hellwig (1):
      iomap: handle error conditions more gracefully in iomap_to_bh

Christophe JAILLET (5):
      bpf: Fix a erroneous check after snprintf()
      media: i2c: max9286: Remove an incorrect fwnode_handle_put() call
      media: i2c: rdacm21: Remove an incorrect fwnode_handle_put() call
      media: imx-mipi-csis: Remove an incorrect fwnode_handle_put() call
      gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()

Christophe Leroy (1):
      powerpc/82xx: Select FSL_SOC

Cong Liu (1):
      drm/amdgpu: fix a memory leak in amdgpu_ras_feature_enable

Dan Carpenter (3):
      ASoC: codecs: aw88395: Fix some error codes
      nouveau/u_memcpya: fix NULL vs error pointer bug
      drm/i915/gt: Prevent error pointer dereference

Dan Williams (1):
      cxl/port: Fix cxl_test register enumeration regression

Daniel Scally (1):
      i2c: xiic: Correct return value check for xiic_reinit()

Danilo Krummrich (2):
      drm/nouveau: fence: fix type cast warning in nouveau_fence_emit()
      drm/nouveau: sched: fix leaking memory of timedout job

Darrick J. Wong (16):
      xfs: fix per-cpu CIL structure aggregation racing with dying cpus
      xfs: fix an agbno overflow in __xfs_getfsmap_datadev
      xfs: use per-mount cpumask to track nonempty percpu inodegc lists
      xfs: remove the all-mounts list
      xfs: remove CPU hotplug infrastructure
      xfs: use i_prev_unlinked to distinguish inodes that are not on
the unlinked list
      xfs: allow inode inactivation during a ro mount log recovery
      xfs: reload entire unlinked bucket lists
      xfs: fix log recovery when unknown rocompat bits are set
      xfs: reserve less log space when recovering log intent items
      xfs: load uncached unlinked inodes into memory on demand
      xfs: make inode unlinked bucket recovery work with quotacheck
      xfs: require a relatively recent V5 filesystem for LARP mode
      xfs: only call xchk_stats_merge after validating scrub inputs
      iomap: don't skip reading in !uptodate folios when unsharing a range
      iomap: convert iomap_unshare_iter to use large folios

Dave Airlie (1):
      nouveau/u_memcpya: use vmemdup_user

Dave Wysochanski (1):
      netfs: Only call folio_start_fscache() one time for each folio

David Christensen (1):
      ionic: fix 16bit math issue when PAGE_SIZE >=3D 64KB

Dennis Bonke (1):
      platform/x86: thinkpad_acpi: Take mutex in hotkey_resume

Ding Xiang (1):
      selftests: ALSA: remove unused variables

Eduard Zingerman (2):
      bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init
      selftests/bpf: Offloaded prog after non-offloaded should not cause BU=
G

Edward Cree (1):
      sfc: handle error pointers returned by rhashtable_lookup_get_insert_f=
ast()

Eric Dumazet (3):
      scsi: iscsi_tcp: restrict to TCP sockets
      dccp: fix dccp_v4_err()/dccp_v6_err() again
      net: bridge: use DEV_STATS_INC()

Filipe Manana (3):
      btrfs: set last dir index to the current last index when opening dir
      btrfs: refresh dir last index during a rewinddir(3) call
      btrfs: fix race between reading a directory and adding entries to it

Florian Westphal (3):
      netfilter: conntrack: fix extension size table
      netfilter: nf_tables: disable toggling dormant table state more than =
once
      netfilter: nf_tables: fix memleak when more than 255 elements expired

Geert Uytterhoeven (1):
      sh: mm: re-add lost __ref to ioremap_prot() to fix modpost warning

Gerhard Engleder (3):
      tsnep: Fix NAPI scheduling
      tsnep: Fix ethtool channels
      tsnep: Fix NAPI polling with budget 0

Guenter Roeck (1):
      ASoC: wm8960: Fix error handling in probe

Hamza Mahfooz (1):
      drm/amd/display: fix the ability to use lower resolution modes on eDP

Han Xu (1):
      spi: nxp-fspi: reset the FLSHxCR1 registers

Hans Verkuil (2):
      media: bt8xx: bttv_risc_packed(): remove field checks
      media: vb2: frame_vector.c: replace WARN_ONCE with a comment

Hans de Goede (6):
      ASoC: rt5640: Revert "Fix sleep in atomic context"
      ASoC: rt5640: Fix sleep in atomic context
      ASoC: rt5640: Do not disable/enable IRQ twice on suspend/resume
      ASoC: rt5640: Enable the IRQ on resume after configuring jack-detect
      ASoC: rt5640: Fix IRQ not being free-ed for HDA jack detect mode
      ASoC: rt5640: Only cancel jack-detect work on suspend if active

Heiko Carstens (1):
      s390: update defconfigs

Heiner Kallweit (1):
      i2c: i801: unregister tco_pdev in i801_probe() error path

Helge Deller (1):
      LoongArch: Fix lockdep static memory detection

Hou Tao (5):
      bpf: Adjust size_index according to the value of KMALLOC_MIN_SIZE
      bpf: Don't prefill for unused bpf_mem_cache
      bpf: Ensure unit_size is matched with slab cache object size
      selftests/bpf: Test all valid alloc sizes for bpf mem allocator
      bpf: Skip unit_size checking for global per-cpu allocator

Huacai Chen (3):
      LoongArch: Set all reserved memblocks on Node#0 at initialization
      kasan: Cleanup the __HAVE_ARCH_SHADOW_MAP usage
      LoongArch: Don't inline kasan_mem_to_shadow()/kasan_shadow_to_mem()

Ilpo J=C3=A4rvinen (2):
      MAINTAINERS: Add myself into x86 platform driver maintainers
      MAINTAINERS: Add x86 platform drivers patchwork

Ilya Leoshkevich (1):
      netfilter, bpf: Adjust timeouts of non-confirmed CTs in
bpf_ct_insert_entry()

Ira Weiny (1):
      cxl/mbox: Fix CEL logic for poison and security commands

Ivan Vecera (1):
      i40e: Fix VF VLAN offloading when port VLAN is configured

Jani Nikula (1):
      drm/meson: fix memory leak on ->hpd_notify callback

Janusz Krzysztofik (1):
      drm/tests: Fix incorrect argument in drm_test_mm_insert_range

Jean-Philippe Brucker (1):
      KVM: arm64: nvhe: Ignore SVE hint in SMCCC function ID

Jens Axboe (1):
      task_work: add kerneldoc annotation for 'data' argument

Jerome Brunet (1):
      ASoC: meson: spdifin: start hw on dai probe

Jian Shen (1):
      net: hns3: only enable unicast promisc when mac table full

Jie Wang (3):
      net: hns3: add cmdq check for vf periodic service task
      net: hns3: fix GRE checksum offload issue
      net: hns3: add 5ms delay before clear firmware reset irq source

Jijie Shao (1):
      net: hns3: fix fail to delete tc flower rules during reset issue

Jinjie Ruan (6):
      net: microchip: sparx5: Fix memory leak for
vcap_api_rule_add_keyvalue_test()
      net: microchip: sparx5: Fix memory leak for
vcap_api_rule_add_actionvalue_test()
      net: microchip: sparx5: Fix possible memory leak in
vcap_api_encode_rule_test()
      net: microchip: sparx5: Fix possible memory leaks in
test_vcap_xn_rule_creator()
      net: microchip: sparx5: Fix possible memory leaks in vcap_api_kunit
      net/handshake: Fix memory leak in __sock_create() and sock_alloc_file=
()

Jiri Olsa (5):
      bpf: Add override check to kprobe multi link attach
      selftests/bpf: Add kprobe_multi override test
      selftests/bpf: Fix kprobe_multi_test/attach_override test
      bpf: Fix uprobe_multi get_pid_task error path
      bpf: Fix BTF_ID symbol generation collision

Jisheng Zhang (1):
      net: stmmac: fix incorrect rxq|txq_stats reference

Johan Hovold (1):
      spi: zynqmp-gqspi: fix clock imbalance on probe failure

Johannes Weiner (2):
      mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong buddy lis=
t
      mm: memcontrol: fix GFP_NOFS recursion in memory.high enforcement

Johnathan Mantey (1):
      ncsi: Propagate carrier gain/loss events to the NCSI controller

Josef Bacik (1):
      btrfs: don't clear uptodate on write errors

Josh Poimboeuf (5):
      x86/srso: Fix srso_show_state() side effect
      x86/srso: Set CPUID feature bits independently of bug or mitigation s=
tatus
      x86/srso: Don't probe microcode in a guest
      x86/srso: Fix SBPB enablement for spec_rstack_overflow=3Doff
      x86/alternatives: Remove faulty optimization

Jos=C3=A9 Pekkarinen (1):
      drm/virtio: clean out_fence on complete_submit

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWA=
P

Juergen Gross (4):
      xen: simplify evtchn_do_upcall() call maze
      arm/xen: remove lazy mode related definitions
      x86/xen: move paravirt lazy code
      x86/xen: allow nesting of same lazy mode

Julia Lawall (1):
      ASoC: rsnd: add missing of_node_put

Justin Stitt (1):
      xen/efi: refactor deprecated strncpy

Kailang Yang (3):
      ALSA: hda/realtek - Fixed two speaker platform
      ALSA: hda: Disable power save for solving pop issue on Lenovo
ThinkCentre M70q
      ALSA: hda/realtek - ALC287 Realtek I2S speaker platform support

Kajol Jain (1):
      powerpc/perf/hv-24x7: Update domain value check

Karol Wachowski (1):
      accel/ivpu/40xx: Fix buttress interrupt handling

Kees Cook (1):
      cxl/acpi: Annotate struct cxl_cxims_data with __counted_by

Kirill A. Shutemov (1):
      efi/unaccepted: Make sure unaccepted table is mapped

Knyazev Arseniy (1):
      ALSA: hda/realtek: Splitting the UX3402 into two separate models

Kristina Martsenko (1):
      arm64: cpufeature: Fix CLRBHB and BC detection

Kyle Zeng (1):
      ipv4: fix null-deref in ipv4_link_failure

Laurent Pinchart (3):
      media: i2c: imx219: Fix a typo referring to a wrong variable
      media: i2c: imx219: Fix crop rectangle setting when changing format
      media: i2c: imx219: Perform a full mode set unconditionally

Liam R. Howlett (1):
      kernel/sched: Modify initial boot task idle setup

Liang He (1):
      i2c: mux: gpio: Add missing fwnode_handle_put()

Lijo Lazar (1):
      Revert "drm/amdgpu: Report vbios version instead of PN"

Linus Torvalds (1):
      Linux 6.6-rc3

Lukas Bulwahn (1):
      xfs: fix select in config XFS_ONLINE_SCRUB_STATS

Lukasz Majewski (1):
      net: hsr: Properly parse HSRv1 supervisor frames.

Marc Zyngier (1):
      KVM: arm64: Properly return allocated EL2 VA from
hyp_alloc_private_va_range()

Mark Brown (3):
      arm64/sme: Include ID_AA64PFR1_EL1.SME in cpu-feature-registers.rst
      arm64/hbc: Document HWCAP2_HBC
      arm64: Document missing userspace visible fields in ID_AA64ISAR2_EL1

Mark Rutland (1):
      locking/atomic: scripts: fix fallback ifdeffery

Matthew Wilcox (Oracle) (1):
      btrfs: convert btrfs_read_merkle_tree_page() to use a folio

Michael Walle (1):
      MAINTAINERS: gpio-regmap: make myself a maintainer of it

Michal Wilczynski (1):
      ACPI: processor: Fix uninitialized access of buf in acpi_set_pdc_bits=
()

Mika Westerberg (2):
      spi: intel-pci: Add support for Granite Rapids SPI serial flash
      net: thunderbolt: Fix TCPv6 GSO checksum calculation

Mike Rapoport (IBM) (2):
      memblock tests: fix warning: "__ALIGN_KERNEL" redefined
      memblock tests: fix warning =E2=80=98struct seq_file=E2=80=99 declare=
d inside
parameter list

Muhammad Ahmed (1):
      drm/amd/display: Fix MST recognizes connected displays as one

Muhammad Husaini Zulkifli (1):
      igc: Expose tx-usecs coalesce setting to user

Naveen N Rao (1):
      powerpc: Fix build issue with LD_DEAD_CODE_DATA_ELIMINATION and
FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY

Nick Desaulniers (1):
      bpf: Fix BTF_ID symbol generation collision in tools/

Olga Kornievskaia (2):
      NFSv4.1: fix pnfs MDS=3DDS session trunking
      NFSv4.1: fix zero value filehandle in post open getattr

Oliver Upton (1):
      MAINTAINERS: Use wildcard pattern for ARM PMU headers

Pablo Neira Ayuso (6):
      netfilter: nf_tables: disallow rule removal from chain binding
      netfilter: nft_set_rbtree: use read spinlock to avoid datapath conten=
tion
      netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall=
 GC
      netfilter: nft_set_pipapo: stop GC iteration if GC transaction
allocation fails
      netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
      netfilter: nf_tables: disallow element removal on anonymous sets

Paolo Abeni (5):
      mptcp: fix bogus receive window shrinkage with multiple subflows
      mptcp: move __mptcp_error_report in protocol.c
      mptcp: process pending subflow error on close
      mptcp: rename timer related helper to less confusing names
      mptcp: fix dangling connection hang-up

Paolo Bonzini (2):
      KVM: x86/mmu: Do not filter address spaces in
for_each_tdp_mmu_root_yield_safe()
      KVM: SVM: INTERCEPT_RDTSCP is never intercepted anyway

Paulo Alcantara (1):
      smb: client: handle STATUS_IO_REPARSE_TAG_NOT_HANDLED

Peter Lafreniere (3):
      Documentation: netdev: fix dead link in ax25.rst
      MAINTAINERS: Update link for linux-ax25.org
      ax25: Kconfig: Update link for linux-ax25.org

Peter Oberparleiter (1):
      s390/cert_store: fix string length handling

Peter Ujfalusi (6):
      ALSA: core: Use dev_name of card_dev as debugfs directory name
      ALSA: hda: intel-sdw-acpi: Use u8 type for link index
      ALSA: usb-audio: mixer: Remove temporary string use in
parse_clock_source_unit
      ASoC: SOF: sof-audio: Fix DSP core put imbalance on widget setup fail=
ure
      ASoC: SOF: core: Only call sof_ops_free() on remove if the probe
was successful
      ALSA: usb-audio: scarlett_gen2: Fix another -Wformat-truncation warni=
ng

Peter Zijlstra (1):
      x86,static_call: Fix static-call vs return-thunk

Petr Oros (2):
      iavf: add iavf_schedule_aq_request() helper
      iavf: schedule a request immediately after add/delete vlan

Phil Sutter (2):
      netfilter: nf_tables: Fix entries val in rule reset audit log
      selftests: netfilter: Test nf_tables audit logging

Radoslaw Tyl (1):
      iavf: do not process adminq tasks when __IAVF_IN_REMOVE_TASK is set

Rafael J. Wysocki (1):
      thermal: sysfs: Fix trip_point_hyst_store()

Randy Dunlap (4):
      bpf, cgroup: fix multiple kernel-doc warnings
      scatterlist: add missing function params to kernel-doc
      argv_split: fix kernel-doc warnings
      pidfd: prevent a kernel-doc warning

Ranjani Sridharan (1):
      ASoC: SOF: Intel: MTL: Reduce the DSP init timeout

Ricardo Ribalda (1):
      media: uvcvideo: Fix OOB read

Richard Fitzgerald (12):
      ASoC: cs35l56: Call pm_runtime_dont_use_autosuspend()
      ALSA: hda: cs35l56: Call pm_runtime_dont_use_autosuspend()
      ASoC: cs35l56: Disable low-power hibernation mode
      ALSA: hda: cs35l56: Disable low-power hibernation mode
      ASoC: cs42l42: Ensure a reset pulse meets minimum pulse width.
      ASoC: cs42l42: Don't rely on GPIOD_OUT_LOW to set RESET initially low
      ASoC: cs42l42: Avoid stale SoundWire ATTACH after hard reset
      firmware: cirrus: cs_dsp: Only log list of algorithms in debug build
      ASoC: wm_adsp: Fix missing locking in wm_adsp_[read|write]_ctl()
      ALSA: hda: cs35l56: Don't 'return ret' if ret is always zero
      ALSA: hda: cs35l56: Fix missing RESET GPIO if _SUB is missing
      ALSA: hda: cs35l56: Use the new RUNTIME_PM_OPS() macro

Rick Edgecombe (3):
      x86/shstk: Handle vfork clone failure correctly
      x86/shstk: Remove useless clone error handling
      x86/shstk: Add warning for shadow stack double unmap

Rik van Riel (1):
      x86/mm, kexec, ima: Use memblock_free_late() from ima_free_kexec_buff=
er()

Rong Tao (1):
      memblock tests: Fix compilation errors.

Ryan Roberts (1):
      selftests: link libasan statically for tests with -fsanitize=3Daddres=
s

Sabrina Dubroca (1):
      selftests: tls: swap the TX and RX sockets in some tests

Sakari Ailus (4):
      media: pci: ivsc: Select build dependencies
      media: v4l: Use correct dependency for camera sensor drivers
      media: via: Use correct dependency for camera sensor drivers
      media: ivsc: Depend on VIDEO_DEV

Sameer Pujar (2):
      ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol
      ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates

Sasha Neftin (1):
      net/core: Fix ETH_P_1588 flow dissector

Sean Christopherson (3):
      KVM: selftests: Assert that vasprintf() is successful
      KVM: x86/mmu: Open code leaf invalidation from mmu_notifier
      KVM: x86/mmu: Stop zapping invalidated TDP MMU roots asynchronously

Sebastian Andrzej Siewior (8):
      net: hsr: Add __packed to struct hsr_sup_tlv.
      selftests: hsr: Use `let' properly.
      selftests: hsr: Reorder the testsuite.
      selftests: hsr: Extend the testsuite to also cover HSRv1.
      locking/seqlock: Do the lockdep annotation before locking in
do_write_seqcount_begin_nested()
      net: ena: Flush XDP packets on error.
      bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI
      octeontx2-pf: Do xdp_do_flush() after redirects.

Shengjiu Wang (2):
      ASoC: fsl: imx-pcm-rpmsg: Add SNDRV_PCM_INFO_BATCH flag
      ASoC: imx-audmix: Fix return error with devm_clk_get()

Shinas Rasheed (1):
      octeon_ep: fix tx dma unmap len values in SG

Smita Koralahalli (3):
      cxl/pci: Fix appropriate checking for _OSC while handling CXL
RAS registers
      PCI/AER: Export pcie_aer_is_native()
      cxl/pci: Replace host_bridge->native_aer with pcie_aer_is_native()

Stanislav Fomichev (2):
      bpf: Clarify error expectations from bpf_clone_redirect
      selftests/bpf: Update bpf_clone_redirect expected return code

Stefan Moring (1):
      spi: imx: Take in account bits per word instead of assuming 8-bits

Stephen Boyd (4):
      platform/x86: intel_scu_ipc: Check status after timeout in busy_loop(=
)
      platform/x86: intel_scu_ipc: Check status upon timeout in
ipc_wait_for_interrupt()
      platform/x86: intel_scu_ipc: Don't override scu in
intel_scu_ipc_dev_simple_command()
      platform/x86: intel_scu_ipc: Fail IPC send if still busy

Steve French (4):
      smb3: Add dynamic trace points for RDMA (smbdirect) reconnect
      smb3: do not start laundromat thread when dir leases  disabled
      smb3: remove duplicate error mapping
      smb3: fix confusing debug message

Steven Rostedt (Google) (1):
      eventfs: Remember what dentries were created on dir open

Takashi Iwai (19):
      ALSA: docs: Fix a typo of midi2_ump_probe option for snd-usb-audio
      ALSA: seq: Avoid delivery of events for disabled UMP groups
      ALSA: seq: ump: Fix -Wformat-truncation warning
      ALSA: seq: midi: Fix -Wformat-truncation warning
      ALSA: usb-audio: scarlett_gen2: Fix -Wformat-truncation warning
      ALSA: caiaq: Fix -Wformat-truncation warning
      ALSA: sscape: Fix -Wformat-truncation warning
      ALSA: cs4236: Fix -Wformat-truncation warning
      ALSA: es1688: Fix -Wformat-truncation warning
      ALSA: opti9x: Fix -Wformat-truncation warning
      ALSA: xen: Fix -Wformat-truncation warning
      ALSA: firewire: Fix -Wformat-truncation warning for longname string
      ALSA: firewire: Fix -Wformat-truncation warning for MIDI stream names
      ALSA: cmipci: Fix -Wformat-truncation warning
      ALSA: hda: generic: Check potential mixer name string truncation
      ALSA: ad1848: Fix -Wformat-truncation warning for longname string
      ALSA: cs4231: Fix -Wformat-truncation warning for longname string
      ALSA: riptide: Fix -Wformat-truncation warning for longname string
      ALSA: rawmidi: Fix NULL dereference at proc read

Thomas Zimmermann (1):
      fbdev/sh7760fb: Depend on FB=3Dy

Tianjia Zhang (1):
      crypto: sm2 - Fix crash caused by uninitialized context

Tiezhu Yang (3):
      LoongArch: Remove dead code in relocate_new_kernel
      docs/LoongArch: Update the links of ABI
      docs/zh_CN/LoongArch: Update the links of ABI

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      bpf: Avoid deadlock when using queue and stack maps from NMI

Tom Lendacky (2):
      KVM: SVM: Fix TSC_AUX virtualization setup
      KVM: SVM: Do not use user return MSR support for virtualized TSC_AUX

Trond Myklebust (9):
      NFS: Fix error handling for O_DIRECT write scheduling
      NFS: Fix O_DIRECT locking issues
      NFS: More O_DIRECT accounting fixes for error paths
      NFS: Use the correct commit info in nfs_join_page_group()
      NFS: More fixes for nfs_direct_write_reschedule_io()
      NFS/pNFS: Report EINVAL errors from connect() to the server
      SUNRPC: Mark the cred for revalidation if the server rejects it
      Revert "SUNRPC: Fail faster on bad verifier"
      SUNRPC: Silence compiler complaints about tautological comparisons

Umesh Nerlige Ramappa (1):
      i915/pmu: Move execlist stats initialization to execlist specific set=
up

Valentin Caron (1):
      spi: stm32: add a delay before SPI disable

Vincent Whitchurch (2):
      regulator: Fix voltage range selection
      x86/asm: Fix build of UML with KASAN

Vinicius Costa Gomes (1):
      igc: Fix infinite initialization loop with early XDP redirect

Walt Holman (1):
      Add DMI ID for MSI Bravo 15 B7ED

Wang Jianchao (1):
      xfs: use roundup_pow_of_two instead of ffs during xlog_find_tail

Xiaoke Wang (1):
      i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()

Yann Sionneau (1):
      i2c: designware: fix __i2c_dw_disable() in case master is holding SCL=
 low

Yin Fengwei (1):
      filemap: add filemap_map_order0_folio() to handle order0 folio

YuBiao Wang (1):
      drm/amdkfd: Use gpu_offset for user queue's wptr

Zhang Xiaoxu (1):
      cifs: Fix UAF in cifs_demultiplex_thread()

Zheng Yejian (1):
      ring-buffer: Fix bytes info in per_cpu buffer stats

Ziyang Xuan (1):
      team: fix null-ptr-deref when team device type is changed
