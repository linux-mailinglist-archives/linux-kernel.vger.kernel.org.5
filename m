Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6326C7B49B9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 23:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbjJAVYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 17:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjJAVYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 17:24:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A2C9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 14:24:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32487efc319so3392643f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696195454; x=1696800254; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fzcjqI8CGx5CpehgFF59m4tbthGu7zpIJZ8ElUQ3M00=;
        b=IYT9KF0TOWpkEPDYImB1tu0Nmset8B/iF/Qc7r0eK2t2Qv1NlS4cP2mwKDcs7YLmv1
         eWIEiqPwynp8Q3F1im/In/EuV/4U53m6NmZFJBhnvS0cmMewUriSBv7q62wflDB8SHao
         M/LMJLkRh1nfNA6qr+/oQKQqi/8UrTdRYedck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696195454; x=1696800254;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzcjqI8CGx5CpehgFF59m4tbthGu7zpIJZ8ElUQ3M00=;
        b=bJKgtDeyJhBupePvSfXvbQOTFu1H7TJzs4HEwuwOzQ9PVKAGhsNtz1G+BIZzPdjxAc
         dKARVc7pkpoRs1c70/JTrfLV5o24JNQHaYKPUVibDcgHkfrxmFle6zO5fmSUUS8TOUgA
         B0IquoSJqVPlqJE9/AlAyYjG1bwFxr0UWSEWSA+socfU7DM9wg0uoZ4uXwTz1cBcDpzz
         06HZLTflYxjlEilpNlwanp/7rSIPVBX3gEe0uigF+HgEoqlCgJRe3KSPCclrl6OBSR/b
         hGLqjXM1flOpPYvk5JkmGKNfQfyWynLNuXPhdDT9LPrQ31JnlIjG3Ns7z1DcXsTWLBVK
         KR8w==
X-Gm-Message-State: AOJu0Ywjh4HO07pkM/RYRCh1JKJNDYRWMd0LTPlu/JPVDou+9I407ogM
        yeJtKdLiE0mMPkSIKQDLG3chz98OgvPHt3/h9lijV4sW
X-Google-Smtp-Source: AGHT+IGBMkQMdDyYACbNsu5EIJ75nhCaPm8rZ9WCQaLFbJJTOP7v73sNWyy9r3Edd7w0AtvoDi0TNg==
X-Received: by 2002:a05:6000:186c:b0:327:d08a:1fa2 with SMTP id d12-20020a056000186c00b00327d08a1fa2mr149904wri.36.1696195453916;
        Sun, 01 Oct 2023 14:24:13 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id lu8-20020a170906fac800b00997cce73cc7sm15770844ejb.29.2023.10.01.14.24.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 14:24:13 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so6309772a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 14:24:13 -0700 (PDT)
X-Received: by 2002:a05:6402:14ce:b0:533:87c9:4a81 with SMTP id
 f14-20020a05640214ce00b0053387c94a81mr8557665edx.29.1696195452585; Sun, 01
 Oct 2023 14:24:12 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Oct 2023 14:23:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wia2-4DRvD-aXz70AV64yrt+Vr50MxHiDunZ71dHATv-Q@mail.gmail.com>
Message-ID: <CAHk-=wia2-4DRvD-aXz70AV64yrt+Vr50MxHiDunZ71dHATv-Q@mail.gmail.com>
Subject: Linux 6.6-rc4
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

You all know the drill by now. There's nothing particularly odd in
here, if you don't count a week of no networking pull as being odd.
That does result in rc4 being fairly small, but I suspect we'll just
see a bigger rc5 to compensate.

The GPU changes are pretty small too, so both of the big driver
subsystems are being quiet, in fact.

But everything else looks very much normal. The libata suspend/resume
handling shows up due to it walking away from using the generic SCSI
version that caused issues. Other than that, it's a random mix of
fixes all over - misc drivers and architecture fixes, some tooling and
documentation, and filesystems and core kernel fixlets.

              Linus

---

Adam Ford (3):
      bus: ti-sysc: Fix missing AM35xx SoC matching
      arm64: dts: imx8mp: Fix SDMA2/3 clocks
      arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock

Al Viro (1):
      direct_write_fallback(): on error revert the ->ki_pos update
from buffered write

Alexander Stein (1):
      arm64: dts: freescale: tqma9352: Fix gpio hog

Andrew Jeffery (1):
      MAINTAINERS: aspeed: Update Andrew's email address

Andy Shevchenko (1):
      serial: 8250_port: Check IRQ data before use

Arnaldo Carvalho de Melo (6):
      perf tools: Update copy of libbpf's hashmap.c
      tools headers UAPI: Sync files changed by new fchmodat2 and
map_shadow_stack syscalls with the kernel sources
      tools headers UAPI: Copy seccomp.h to be able to build 'perf
bench' in older systems
      perf bench sched-seccomp-notify: Use the tools copy of seccomp.h UAPI
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Update tools's copy of drm.h headers

Arnd Bergmann (2):
      Documentation: kbuild: explain handling optional dependencies
      ARM: locomo: fix locomolcd_power declaration

Aurelien Jarno (1):
      riscv: dts: starfive: fix NOR flash reserved-data partition size

Baoquan He (1):
      Crash: add lock to serialize crash hotplug handling

Beau Belgrave (2):
      selftests/user_events: Fix to unmount tracefs when test created mount
      tracing/user_events: Align set_bit() address for all archs

Biju Das (4):
      dt-bindings: clock: versaclock3: Add description for #clock-cells pro=
perty
      clk: vc3: Fix 64 by 64 division
      clk: vc3: Fix output clock mapping
      clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum values

Binbin Zhou (5):
      soc: loongson: loongson_pm2: Add dependency for INPUT
      dt-bindings: soc: loongson,ls2k-pmc: Use fallbacks for ls2k-pmc compa=
tible
      soc: loongson: loongson_pm2: Drop useless of_device_id compatible
      dt-bindings: soc: loongson,ls2k-pmc: Allow
syscon-reboot/syscon-poweroff as child
      soc: loongson: loongson_pm2: Populate children syscon nodes

Breno Leitao (1):
      perf/x86/amd: Do not WARN() on every IRQ

Charles Kearney (1):
      spi: spi-gxp: BUG: Correct spi write return value

Charles Keepax (1):
      spi: cs42l43: Remove spurious pm_runtime_disable

Chengfeng Ye (1):
      gpio: timberdale: Fix potential deadlock on &tgpio->lock

Chris Morgan (1):
      power: supply: rk817: Fix node refcount leak

Christian Brauner (3):
      porting: document new block device opening order
      porting: document superblock as block device holder
      ntfs3: put resources during ntfs_fill_super()

Christoph Hellwig (2):
      MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled
      iomap: add a workaround for racy i_size updates on block devices

Christophe JAILLET (3):
      power: supply: rt9467: Fix rt9467_run_aicl()
      firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_channe=
ls()
      x86/kgdb: Fix a kerneldoc warning when build with W=3D1

Chuck Lever (1):
      NFSD: Fix zero NFSv4 READ results when RQ_SPLICE_OK is not set

Chunhai Guo (1):
      fs-writeback: do not requeue a clean inode having skipped pages

Cl=C3=A9ment L=C3=A9ger (1):
      tracing: relax trace_event_eval_update() execution with cond_resched(=
)

Damien Le Moal (12):
      scsi: core: ata: Do no try to probe for CDL on old drives
      ata: libata-core: Fix ata_port_request_pm() locking
      ata: libata-core: Fix port and device removal
      ata: libata-scsi: link ata port and scsi device
      scsi: sd: Differentiate system and runtime start/stop management
      ata: libata-scsi: Disable scsi device manage_system_start_stop
      scsi: Do not attempt to rescan suspended devices
      ata: libata-scsi: Fix delayed scsi_rescan_device() execution
      ata: libata-core: Do not register PM operations for SAS ports
      scsi: sd: Do not issue commands to suspended disks on shutdown
      ata: libata-core: Fix compilation warning in ata_dev_config_ncq()
      ata: libata-eh: Fix compilation warning in ata_eh_link_report()

Dan Carpenter (1):
      power: supply: ucs1002: fix error code in ucs1002_get_property()

Daniel Starke (1):
      Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux"

Danilo Krummrich (1):
      MAINTAINERS: update nouveau maintainers

Darrick J. Wong (1):
      xfs: fix reloading entire unlinked bucket lists

David Laight (1):
      slab: kmalloc_size_roundup() must not return 0 for non-zero size

David Thompson (1):
      pwr-mlxbf: extend Kconfig to include gpio-mlxbf3 dependency

Dinghao Liu (1):
      ACPI: video: Fix NULL pointer dereference in acpi_video_bus_add()

Domenico Cerasuolo (1):
      mm: zswap: fix potential memory corruption on duplicate store

Dongliang Mu (1):
      soc: loongson: loongson2_guts: Convert to devm_platform_ioremap_resou=
rce()

Fabio Estevam (2):
      dt-bindings: i2c: mxs: Pass ref and 'unevaluatedProperties: false'
      dt-bindings: spi: fsl-imx-cspi: Document missing entries

Filipe Manana (5):
      btrfs: fix race when refilling delayed refs block reserve
      btrfs: prevent transaction block reserve underflow when starting
transaction
      btrfs: return -EUCLEAN for delayed tree ref with a ref count not
equals to 1
      btrfs: remove redundant BUG_ON() from __btrfs_inc_extent_ref()
      btrfs: log message if extent item not found when running delayed exte=
nt op

Frederic Weisbecker (1):
      timers: Tag (hr)timer softirq as hotplug safe

Geert Uytterhoeven (1):
      iomap: Spelling s/preceeding/preceding/g

Greg Ungerer (1):
      fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Haitao Huang (1):
      x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race

Hal Feng (2):
      riscv: dts: starfive: visionfive 2: Enable usb0
      riscv: dts: starfive: visionfive 2: Fix uart0 pins sort order

Harshit Mogalapalli (1):
      power: supply: mt6370: Fix missing error code in mt6370_chg_toggle_cf=
o()

Heiner Kallweit (1):
      i2c: mux: Avoid potential false error message in i2c_mux_add_adapter

Huacai Chen (1):
      LoongArch: numa: Fix high_memory calculation

Ian Rogers (4):
      perf bpf-prologue: Remove unused file
      perf trace: Avoid compile error wrt redefining bool
      perf jevents metric: Fix type of strcmp_cpuid_str
      perf pmu: Ensure all alias variables are initialized

Ilya Dryomov (5):
      Revert "ceph: make members in struct ceph_mds_request_args_ext a unio=
n"
      rbd: move rbd_dev_refresh() definition
      rbd: decouple header read-in from updating rbd_dev->header
      rbd: decouple parent info read-in from updating rbd_dev
      rbd: take header_rwsem in rbd_dev_refresh() only when updating

Jacek Lawrynowicz (1):
      accel/ivpu: Don't flood dmesg with VPU ready message

Javier Pello (1):
      drm/i915/gt: Fix reservation address in ggtt_reserve_guc_top

Jeff Layton (1):
      overlayfs: set ctime when setting mtime and atime

Jens Axboe (2):
      ovl: disable IOCB_DIO_CALLER_COMP
      io_uring/fs: remove sqe->rw_flags checking from LINKAT

Jinjie Ruan (2):
      vfio/mdev: Fix a null-ptr-deref bug for mdev_unregister_parent()
      mm/damon/vaddr-test: fix memory leak in
damon_do_test_apply_three_regions()

Joel Fernandes (Google) (1):
      sched/rt: Fix live lock between select_fallback_rq() and RT push

Josef Bacik (3):
      btrfs: properly report 0 avail for very full file systems
      btrfs: make sure to initialize start and len in find_free_dev_extent
      btrfs: initialize start_slot in btrfs_log_prealloc_extents

Julien Panis (1):
      bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()

Juntong Deng (1):
      selftests/mm: fix awk usage in charge_reserved_hugetlb.sh and
hugetlb_reparenting_test.sh that may cause error

Justin Stitt (1):
      power: vexpress: fix -Wvoid-pointer-to-enum-cast warning

Karol Wachowski (4):
      accel/ivpu/40xx: Ensure clock resource ownership Ack before Power-Up
      accel/ivpu/40xx: Disable frequency change interrupt
      accel/ivpu/40xx: Fix missing VPUIP interrupts
      accel/ivpu: Use cached buffers for FW loading

Kees Cook (1):
      aio: Annotate struct kioctx_table with __counted_by

Kemeng Shi (1):
      block: correct stale comment in rq_qos_wait

Krzysztof Kozlowski (2):
      power: reset: use capital "OR" for multiple licenses in SPDX
      arm64: defconfig: enable syscon-poweroff driver

Liam R. Howlett (2):
      maple_tree: add mas_is_active() to detect in-tree walks
      maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states

Linus Torvalds (1):
      Linux 6.6-rc4

Linus Walleij (1):
      power: supply: ab8500: Set typing and props

Liu Ying (1):
      arm64: dts: imx8mm-evk: Fix hdmi@3d node

Lu=C3=ADs Henriques (1):
      ceph: remove unnecessary check for NULL in parse_longname()

Marek Vasut (2):
      clk: si521xx: Use REGCACHE_FLAT instead of NONE
      clk: si521xx: Fix regmap write accessor

Martin Nybo Andersen (1):
      kbuild: Use CRC32 and a 1MiB dictionary for XZ compressed modules

Masahiro Yamada (2):
      vmlinux.lds.h: remove unused CPU_KEEP and CPU_DISCARD macros
      kbuild: remove stale code for 'source' symlink in packaging scripts

Matthew Wilcox (Oracle) (3):
      i915: Limit the length of an sg list to the requested length
      mm: report success more often from filemap_map_folio_range()
      mm: abstract moving to the next PFN

Matthias Schiffer (1):
      ata: libata-sata: increase PMP SRST timeout to 10s

Mauricio Faria de Oliveira (1):
      modpost: add missing else to the "of" check

Max Filippov (2):
      xtensa: add default definition for XCHAL_HAVE_DIV32
      xtensa: boot/lib: fix function prototypes

Max Kellermann (1):
      fs/pipe: remove duplicate "offset" initializer

Michael Ellerman (2):
      powerpc/stacktrace: Fix arch_stack_walk_reliable()
      selftests/powerpc: Fix emit_tests to work with run_kselftest.sh

Michal Hocko (1):
      mm, memcg: reconsider kmem.limit_in_bytes deprecation

Mikko Rapeli (1):
      arm64: defconfig: remove CONFIG_COMMON_CLK_NPCM8XX=3Dy

Mingtong Bao (1):
      soc: loongson: loongson2_guts: Remove unneeded semicolon

Namjae Jeon (2):
      ksmbd: return invalid parameter error response if smb2 request is inv=
alid
      ksmbd: check iov vector index in ksmbd_conn_write()

Nathan Rossi (1):
      soc: imx8m: Enable OCOTP clock for imx8mm before reading registers

Nicolas Frattaroli (1):
      power: supply: rk817: Add missing module alias

Niklas Cassel (1):
      ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED
OPERATION CODES

Pan Bian (1):
      nilfs2: fix potential use after free in nilfs_gccache_submit_read_dat=
a()

Petr Tesarik (1):
      swiotlb: fix the check whether a device has used software IO TLB

Pu Wen (1):
      x86/srso: Add SRSO mitigation for Hygon processors

Qu Wenruo (1):
      btrfs: reset destination buffer when read_extent_buffer() gets
invalid range

Quang Le (1):
      fs/smb/client: Reset password pointer to NULL

Rafael Aquini (1):
      mm/slab_common: fix slab_caches list corruption after kmem_cache_dest=
roy()

Randy Dunlap (17):
      power: supply: rt5033_charger: recognize EXTCON setting
      xtensa: fault: include <asm/traps.h>
      xtensa: irq: include <asm/traps.h>
      xtensa: ptrace: add prototypes to <asm/ptrace.h>
      xtensa: processor.h: add init_arch() prototype
      xtensa: signal: include headers for function prototypes
      xtensa: stacktrace: include <asm/ftrace.h> for prototype
      xtensa: traps: add <linux/cpu.h> for function prototype
      irqchip: irq-xtensa-mx: include header for missing prototype
      xtensa: smp: add headers for missing function prototypes
      xtensa: hw_breakpoint: include header for missing prototype
      xtensa: tlb: include <asm/tlb.h> for missing prototype
      xtensa: iss/network: make functions static
      xtensa: boot: don't add include-dirs
      xtensa: umulsidi3: fix conditional expression
      block: fix kernel-doc for disk_force_media_change()
      ARM: uniphier: fix cache kernel-doc warnings

Ricky WU (1):
      misc: rtsx: Fix some platforms can not boot and move the l1ss
judgment to probe

Rob Herring (3):
      arm64: dts: mediatek: Fix "mediatek,merge-mute" and
"mediatek,merge-fifo-en" types
      arm64: dts: imx: Add imx8mm-prt8mm.dtb to build
      dt-bindings: ata: pata-common: Add missing additionalProperties
on child nodes

Ross Lagerwall (1):
      swiotlb: use the calculated number of areas

Ryan Roberts (2):
      mm: hugetlb: add huge page size param to set_huge_pte_at()
      arm64: hugetlb: fix set_huge_pte_at() to work with all swap entries

Sandipan Das (1):
      perf/x86/amd/core: Fix overflow reset on hotplug

Sebastian Reichel (1):
      power: supply: core: fix use after free in uevent

Shigeru Yoshida (1):
      reiserfs: Replace 1-element array with C99 style flex-array

Shixiong Ou (2):
      vfio/pds: Add missing PCI_IOV depends
      vfio/pds: Use proper PF device access helper

Sibi Sankar (1):
      firmware: arm_scmi: Fixup perf power-cost/microwatt support

Stanislaw Gruszka (2):
      accel/ivpu: Add Arrow Lake pci id
      accel/ivpu: Do not use wait event interruptible

Steven Rostedt (Google) (3):
      workqueue: Removed double allocation of wq_update_pod_attrs_buf
      ring-buffer: Update "shortest_full" in polling
      eventfs: Test for dentries array allocated in eventfs_release()

Sudeep Holla (1):
      firmware: arm_ffa: Don't set the memory region attributes for MEM_LEN=
D

Thomas Richter (1):
      perf jevent: fix core dump on software events on s390

Tiezhu Yang (3):
      LoongArch: Define relocation types for ABI v2.10
      LoongArch: Add support for 32_PCREL relocation type
      LoongArch: Add support for 64_PCREL relocation type

Timo Alho (1):
      clk: tegra: fix error return case for recalc_rate

Tony Lindgren (5):
      ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3/4
      ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boo=
t
      ARM: dts: ti: omap: Fix noisy serial with overrun-throttle-ms for map=
phone
      ARM: omap2+: Downgrade u-boot version warnings to debug statements
      bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-u=
p

Umesh Nerlige Ramappa (1):
      i915/guc: Get runtime pm in busyness worker only if already active

Uwe Kleine-K=C3=B6nig (2):
      MAINTAINERS: Fix Florian Fainelli's email address
      modpost: Don't let "driver"s reference .exit.*

Wenhua Lin (1):
      gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip

William A. Kennington III (1):
      i2c: npcm7xx: Fix callback completion ordering

Yang Shi (1):
      mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and
MPOL_MF_MOVE are specified

Yue Haibing (1):
      tee: Remove unused declarations

Zev Weiss (1):
      MAINTAINERS: aspeed: Update git tree URL

Zhifeng Tang (1):
      clk: sprd: Fix thm_parents incorrect configuration

Zqiang (1):
      workqueue: Fix missed pwq_release_worker creation in
wq_cpu_intensive_thresh_init()
