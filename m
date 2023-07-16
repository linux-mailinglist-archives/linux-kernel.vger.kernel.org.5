Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC78E7558A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjGPWzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPWzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:55:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E881BC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 15:55:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so4065316f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 15:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689548127; x=1692140127;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LMrup0GMjXh4HumPwN6PRg+cuNdhBlUZfnpJVjYS8dw=;
        b=E9rje2yHqpI/dRr1hYs9gECtfG2yl2s4+ui7CGTAMkR1xNNBshpFXqodBtOq2272P2
         6QfoQgNnL7/qlifMwWf40o2FIUV0v7DnEyq8lxDyL2M+QHKBTAqnSObNCSNsusWouBg4
         Ic3B2d4hHJi5sL/+fPcyPxxEV3jdOgxqu/31U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689548127; x=1692140127;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMrup0GMjXh4HumPwN6PRg+cuNdhBlUZfnpJVjYS8dw=;
        b=Npmr1XMpXqPVNP7MCy2vm2LswIvAWpyOdGuPnALGfnC2nD+MfYJaNjc8xy09Sp7dlY
         SUknKZyuJVNYdh4mFPO/XfVsjM2vqPkXmpLFKqbYVVcx/HibG8MABOHDsFOaqMjVrZc0
         nsaUlXf1W/G3U3psxP4hOzJQjnHOWu0pHTmVecc7hAJ3Vf9EhA4m4hjIJX52JyIRhk/A
         rX7uhEsWUReOsj3R7A0cIhjsxJHL81feiS9PPNIEEuy+dAx8ufsbX+rB9XRCfXx+2XqY
         tWGYAJ1zWf83W2q5I6MUtTQsq3156DB8nPjAakD2+G1j+KA7si/c0kZXlPTw5L09Vhx8
         k+8w==
X-Gm-Message-State: ABy/qLaVdU3uMiPA340AthWpzopgOPfV/XDE2V4E1i9ntC7H3Jn0Oy4L
        lH1+VcqkNDkWUuy7uZXkhnAgmaAyBhr9ozNfbQ2E2g==
X-Google-Smtp-Source: APBJJlEu6Ju/qCZ0fKp892t1AlbX/dRKHynaTDqzaoXY6MGkqziR99eEdb2oDeTl1lwVjffi6omnuA==
X-Received: by 2002:adf:ed49:0:b0:314:3997:530d with SMTP id u9-20020adfed49000000b003143997530dmr11548846wro.31.1689548126898;
        Sun, 16 Jul 2023 15:55:26 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id i21-20020aa7c9d5000000b0051495ce23absm8895560edt.10.2023.07.16.15.55.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 15:55:26 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so5102455a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 15:55:26 -0700 (PDT)
X-Received: by 2002:a05:6402:648:b0:51a:265a:8fca with SMTP id
 u8-20020a056402064800b0051a265a8fcamr10226805edx.27.1689548125677; Sun, 16
 Jul 2023 15:55:25 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Jul 2023 15:55:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXp01JfPMm9=xd6YDnNwoCbtoRZ7_fLYttLOuHnEeNJA@mail.gmail.com>
Message-ID: <CAHk-=whXp01JfPMm9=xd6YDnNwoCbtoRZ7_fLYttLOuHnEeNJA@mail.gmail.com>
Subject: Linux 6.5-rc2
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

No surprises here: this thing looks very normal. The patch stats are
about 60% drivers, with networking and gpu drivers being the bulk of
it, but there's a little bit of everything in there: nvme, pin
control, x86 platform drivers, HID, etc etc.

Ignoring drivers, it's a mixed set of fixes all over: architectures
(x86, powerpc, RISC-V, xtensa), some core networking (mainly
netfilter), core kernel (tracing, scheduler), filesystems (erofs, smb
client), and documentation and selftests.

And some minor noise elsewhere.

Full shortlog appended, but nothing in there looks particularly
thrilling. Unless, of course, it happened to fix a bug that affected
you.

Or maybe you're the kind of person who finds CFI annotations and
getting all the endbr64 annotations right to be endlessly fascinating.
In which case you're having a really good Sunday.

But please - don't think of this as "not very interesting", but more
as a "this looks safe to test, and it's not like I have anything
better to do".

Right?

              Linus

---

Adri=C3=A1n Larumbe (1):
      drm: bridge: dw_hdmi: fix connector access for scdc

Andres Freund (1):
      io_uring: Use io_schedule* in cqring wait

Andrew Halaney (1):
      MAINTAINERS: Add another mailing list for QUALCOMM ETHQOS ETHERNET DR=
IVER

Andy Shevchenko (2):
      platform/x86: wmi: Break possible infinite loop when parsing GUID
      platform/x86: wmi: Replace open coded guid_parse_and_compare()

Aneesh Kumar K.V (1):
      powerpc/mm/book3s64/hash/4k: Add pmd_same callback for 4K page size

Ankit Kumar (1):
      nvme: fix the NVME_ID_NS_NVM_STS_MASK definition

Aravindhan Gunasekaran (1):
      igc: Handle PPS start time programming for past time values

Armin Wolf (2):
      platform/x86: dell-ddv: Improve error handling
      platform/x86: dell-ddv: Fix mangled list in documentation

Arnd Bergmann (4):
      scsi: aacraid: Avoid -Warray-bounds warning
      HID: hyperv: avoid struct memcpy overrun warning
      tracing: arm64: Avoid missing-prototype warnings
      sparc: mark __arch_xchg() as __always_inline

Arthur Simchaev (1):
      scsi: ufs: core: Add support for qTimestamp attribute

Artur Rojek (1):
      sh: hd64461: Handle virq offset for offchip IRQ base and HD64461 IRQ

Azat Khuzhin (1):
      PM: hibernate: Fix writing maj:min to /sys/power/resume

Azeem Shaikh (1):
      net: sched: Replace strlcpy with strscpy

Bart Van Assche (1):
      block/mq-deadline: Fix a bug in deadline_from_pos()

Basavaraj Natikar (2):
      HID: amd_sfh: Rename the float32 variable
      HID: amd_sfh: Fix for shift-out-of-bounds

Beau Belgrave (2):
      tracing/user_events: Fix struct arg size match check
      selftests/user_events: Test struct size match cases

Benjamin Tissoires (1):
      selftests: hid: fix vmtests.sh not running make headers

Bharath SM (1):
      cifs: if deferred close is disabled then close files immediately

Biju Das (1):
      pinctrl: renesas: rzg2l: Handle non-unique subnode names

Bj=C3=B6rn T=C3=B6pel (1):
      riscv, bpf: Fix inconsistent JIT image generation

Boris Brezillon (2):
      drm/sched: Make sure we wait for all dependencies in kill_jobs_cb()
      drm/sched: Call drm_sched_fence_set_parent() from
drm_sched_fence_scheduled()

Brian Gerst (2):
      x86/32: Remove schedule_tail_wrapper()
      x86: Rewrite ret_from_fork() in C

Can Guo (1):
      scsi: ufs: core: Update contact email for monitor sysfs nodes

Chengming Zhou (1):
      blk-mq: fix start_time_ns and alloc_time_ns for pre-allocated rq

Christian K=C3=B6nig (3):
      drm/ttm: fix warning that we shouldn't mix && and ||
      dma-buf: keep the signaling time of merged fences v3
      drm/ttm: never consider pinned BOs for eviction&swap

Christoph Hellwig (2):
      nvme: don't reject probe due to duplicate IDs for single-ported
PCIe devices
      block: queue data commands from the flush state machine at the head

Chungkai Yang (1):
      PM: QoS: Restore support for default value on frequency QoS

Chunhai Guo (2):
      erofs: avoid useless loops in z_erofs_pcluster_readmore() when
reading beyond EOF
      erofs: avoid infinite loop in z_erofs_do_read_page() when
reading beyond EOF

Damien Le Moal (6):
      scsi: sd_zbc: Set zone limits before revalidating zones
      scsi: nvme: zns: Set zone limits before revalidating zones
      scsi: block: nullblk: Set zone limits before revalidating zones
      scsi: block: virtio_blk: Set zone limits before revalidating zones
      scsi: block: Improve checks in blk_revalidate_disk_zones()
      nvmet: use PAGE_SECTORS_SHIFT

Dan Carpenter (6):
      scsi: qla2xxx: Silence a static checker warning
      scsi: qla2xxx: Fix error code in qla2x00_start_sp()
      dma-buf: fix an error pointer vs NULL bug
      KEYS: asymmetric: Fix error codes
      netdevsim: fix uninitialized data in nsim_dev_trap_fa_cookie_write()
      iommu/sva: Fix signedness bug in iommu_sva_alloc_pasid()

David Howells (2):
      crypto: af_alg - Fix merging of written data into spliced pages
      crypto: algif_hash - Fix race between MORE and non-MORE sends

Dmitry Torokhov (1):
      HID: input: fix mapping for camera access keys

Douglas Anderson (1):
      drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime

Dragos Tatulea (2):
      net/mlx5e: RX, Fix flush and close release flow of regular rq
for legacy rq
      net/mlx5e: RX, Fix page_pool page fragment tracking for XDP

Eric Biggers (1):
      blk-crypto: use dynamic lock class for blk_crypto_profile::lock

Eric Dumazet (1):
      udp6: fix udp6_ehashfn() typo

Eric Lin (1):
      perf: RISC-V: Remove PERF_HES_STOPPED flag checking in riscv_pmu_star=
t()

Evan Quan (1):
      drm/amd/pm: share the code around SMU13 pcie parameters update

Fabio Estevam (1):
      drm/panel: simple: Add connector_type for innolux_at043tn24

Felix Fietkau (1):
      wifi: cfg80211: fix receiving mesh packets without RFC1042 header

Florent Revest (3):
      netfilter: conntrack: Avoid nf_ct_helper_hash uses after free
      samples: ftrace: Save required argument registers in sample trampolin=
es
      arm64: ftrace: Add direct call trampoline samples support

Florian Kauer (6):
      igc: Rename qbv_enable to taprio_offload_enable
      igc: Do not enable taprio offload for invalid arguments
      igc: Handle already enabled taprio offload for basetime 0
      igc: No strict mode in pure launchtime/CBS offload
      igc: Fix launchtime before start of cycle
      igc: Fix inserting of empty frame for launchtime

Florian Westphal (2):
      netfilter: conntrack: gre: don't set assured flag for clash entries
      netfilter: conntrack: don't fold port numbers into addresses
before hashing

Gao Xiang (2):
      erofs: get rid of the remaining kmap_atomic()
      erofs: simplify z_erofs_transform_plain()

Geert Uytterhoeven (5):
      drm/fbdev-dma: Fix documented default preferred_bpp value
      pinctrl: renesas: rzv2m: Handle non-unique subnode names
      sh: mach-r2d: Handle virq offset in cascaded IRL demux
      sh: mach-highlander: Handle virq offset in cascaded IRL demux
      sh: mach-dreamcast: Handle virq offset in cascaded IRQ demux

Gustavo A. R. Silva (1):
      smb: client: Fix -Wstringop-overflow issues

Ido Schimmel (1):
      net/sched: flower: Ensure both minimum and maximum ports are specifie=
d

Ilya Dryomov (1):
      libceph: harden msgr2.1 frame segment length checks

Ingo Molnar (1):
      x86/cfi: Only define poison_cfi() if CONFIG_X86_KERNEL_IBT=3Dy

Isaac J. Manjarres (1):
      regmap-irq: Fix out-of-bounds access when allocating config buffers

Ivan Babrou (1):
      udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint

Jaewon Kim (1):
      spi: s3c64xx: clear loopback bit after loopback test

Jakub Kicinski (1):
      docs: netdev: update the URL of the status page

Jan Beulich (1):
      x86/Xen: tidy xen-head.S

Jason Gunthorpe (1):
      iommu: Fix crash during syfs iommu_groups/N/type

Jens Axboe (1):
      block: remove dead struc request->completion_data field

Jiasheng Jiang (1):
      net: dsa: qca8k: Add check for skb_copy

Jiawen Wu (1):
      net: txgbe: fix eeprom calculation error

Jiri Olsa (1):
      fprobe: Release rethook after the ftrace_ops is unregistered

Jisheng Zhang (1):
      riscv: mm: fix truncation warning on RV32

Johannes Berg (1):
      wifi: iwlwifi: remove 'use_tfh' config to fix crash

Jonas Gorski (3):
      spi: bcm63xx: fix max prepend length
      MAINTAINERS: add myself for spi-bcm63xx
      mailmap: add entry for Jonas Gorski

Julia Lawall (2):
      scsi: fnic: Use vmalloc_array() and vcalloc()
      scsi: qla2xxx: Use vmalloc_array() and vcalloc()

Junfeng Guo (2):
      gve: Set default duplex configuration to full
      gve: unify driver name usage

Karol Herbst (4):
      drm/nouveau/disp: fix HDMI on gt215+
      drm/nouveau/disp/g94: enable HDMI
      drm/nouveau/acr: Abort loading ACR if no firmware was found
      drm/nouveau: bring back blit subchannel for pre nv50 GPUs

Karol Wachowski (2):
      accel/ivpu: Fix VPU register access in irq disable
      accel/ivpu: Clear specific interrupt status bits on C0

Kees Cook (1):
      MAINTAINERS: Foolishly claim maintainership of string routines

Keguang Zhang (1):
      dt-bindings: watchdog: Add Loongson-1 watchdog

Keith Busch (2):
      nvme: warn only once for legacy uuid attribute
      nvme: ensure disabling pairs with unquiesce

Klaus Kudielka (1):
      net: mvneta: fix txq_map in case of txq_number=3D=3D1

Krister Johansen (1):
      net: ena: fix shift-out-of-bounds in exponential backoff

Kumar Kartikeya Dwivedi (2):
      bpf: Fix max stack depth check for async callbacks
      selftests/bpf: Add selftest for check_stack_max_depth bug

Kuniyuki Iwashima (1):
      icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev()=
.

Larysa Zaremba (1):
      xdp: use trusted arguments in XDP hints kfuncs

Li zeming (2):
      kprobes: Remove unnecessary =E2=80=98NULL=E2=80=99 values from correc=
t_ret_addr
      kernel: kprobes: Remove unnecessary =E2=80=980=E2=80=99 values

Linus Torvalds (1):
      Linux 6.5-rc2

Lu Hongfei (1):
      net: dsa: Removed unneeded of_node_put in felix_parse_ports_node

Lyude Paul (1):
      drm/nouveau/kms/nv50-: Fix drm_dp_remove_payload() invocation

M A Ramdhan (1):
      net/sched: cls_fw: Fix improper refcount update leads to use-after-fr=
ee

Maher Sanalla (1):
      net/mlx5: Query hca_cap_2 only when supported

Marek Vasut (1):
      drm/panel: simple: Add Powertip PH800480T013 drm_display_mode flags

Mario Limonciello (9):
      platform/x86: Move s2idle quirk from thinkpad-acpi to amd-pmc
      platform/x86/amd: pmc: Apply nvme quirk to HP 15s-eq2xxx
      drm/amd/pm: conditionally disable pcie lane/speed switching for SMU13
      drm/amd: Move helper for dynamic speed switch check out of smu13
      drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters
implementation with SMU13
      pinctrl: amd: Only use special debounce behavior for GPIO 0
      pinctrl: amd: Use amd_pinconf_set() for all config options
      pinctrl: amd: Drop pull up select configuration
      pinctrl: amd: Unify debounce handling into amd_pinconf_set()

Masami Hiramatsu (Google) (7):
      fprobe: Ensure running fprobe_exit_handler() finished before
calling rethook_free()
      fprobes: Add a comment why fprobe_kprobe_handler exits if kprobe
is running
      tracing/probes: Fix to avoid double count of the string length
on the array
      tracing/probes: Fix not to count error code to total length
      tracing/probes: Fix to update dynamic data counter if fetcharg uses i=
t
      Revert "tracing: Add "(fault)" name injection to kernel probes"
      tracing/probes: Fix to record 0-length data_loc in
fetch_store_string*() if fails

Maurizio Lombardi (1):
      scsi: scsi_debug: Remove dead code

Max Filippov (3):
      xtensa: ISS: add comment about etherdev freeing
      xtensa: ISS: fix call to split_if_spec
      xtensa: fix unaligned and load/store configuration interaction

Miaohe Lin (1):
      sched/fair: Use recent_used_cpu to test p->cpus_ptr

Michael Ellerman (3):
      powerpc/64s: Fix native_hpte_remove() to be irq-safe
      powerpc/security: Fix Speculation_Store_Bypass reporting on Power10
      powerpc/64e: Fix obtool warnings in exceptions-64e.S

Michael Kelley (1):
      scsi: storvsc: Handle SRB status value 0x30

Michael Liang (2):
      nvme-fc: return non-zero status code when fails to create association
      nvme-fc: fix race between error recovery and creating association

Michael Schmitz (1):
      block/partition: fix signedness issue for Amiga partitions

Michal Kubecek (1):
      objtool: initialize all of struct elf

Ming Lei (1):
      nvme-pci: fix DMA direction of unmapping integrity data

Minjie Du (1):
      nvme: fix parameter check in nvme_fault_inject_init()

Mohamed Khalfella (1):
      tracing/histograms: Add histograms to hist_vars if they have
referenced variables

Muhammad Husaini Zulkifli (3):
      igc: Add condition for qbv_config_change_errors counter
      igc: Remove delay during TX ring configuration
      igc: Fix TX Hang issue when QBV Gate is closed

Namhyung Kim (1):
      perf/x86: Fix lockdep warning in for_each_sibling_event() on SPR

Niklas Schnelle (3):
      s390/ism: Fix locking for forwarding of IRQs and events to clients
      s390/ism: Fix and simplify add()/remove() callback handling
      s390/ism: Do not unregister clients with registered DMBs

Nitya Sunkad (1):
      ionic: remove WARN_ON to prevent panic_on_warn

Pablo Neira Ayuso (1):
      netfilter: nf_tables: report use refcount overflow

Palmer Dabbelt (2):
      Documentation: RISC-V: hwprobe: Fix a formatting error
      RISC-V: Don't include Zicsr or Zifencei in I from ACPI

Pankaj Raghav (1):
      nvme: add BOGUS_NID quirk for Samsung SM953

Paolo Abeni (1):
      net: prevent skb corruption on frag list segmentation

Paulo Alcantara (1):
      smb: client: fix missed ses refcounting

Pedro Tammela (5):
      net/sched: make psched_mtu() RTNL-less safe
      net/sched: sch_qfq: reintroduce lmax bound check for MTU
      selftests: tc-testing: add tests for qfq mtu sanity check
      net/sched: sch_qfq: account for stab overhead in qfq_enqueue
      selftests: tc-testing: add test for qfq with stab overhead

Peter Zijlstra (5):
      x86/cfi: Extend {JMP,CAKK}_NOSPEC comment
      x86/alternative: Rename apply_ibt_endbr()
      x86/cfi: Extend ENDBR sealing to kCFI
      x86/fineibt: Poison ENDBR at +0
      iov_iter: Mark copy_iovec_from_user() noclone

Petr Pavlu (2):
      xen/virtio: Fix NULL deref when a bridge of PCI root bus has no paren=
t
      vmlinux.lds.h: Remove a reference to no longer used sections
.text..refcount

Prasad Koya (1):
      igc: set TP bit in 'supported' and 'advertising' fields of
ethtool_link_ksettings

Pu Lehui (1):
      bpf: cpumap: Fix memory leak in cpu_map_update_elem

Quan Zhou (1):
      wifi: mt76: mt7921e: fix init command fail with enabled device

Rafa=C5=82 Mi=C5=82ecki (1):
      net: bgmac: postpone turning IRQs off to avoid SoC hangs

Rahul Rameshbabu (1):
      HID: nvidia-shield: Pack inner/related declarations in HOSTCMD report=
s

Randy Dunlap (2):
      scsi: ufs: ufs-mediatek: Add dependency for RESET_CONTROLLER
      wifi: airo: avoid uninitialized warning in airo_get_rate()

Ratheesh Kannoth (1):
      octeontx2-af: Promisc enable/disable through mbox

Ryan Wanner (1):
      MAINTAINERS: Add myself as a maintainer for Microchip SPI

Saeed Mahameed (1):
      net/mlx5: Register a unique thermal zone per device

Sai Krishna (1):
      octeontx2-af: Move validation of ptp pointer before its usage

Shannon Nelson (1):
      ionic: remove dead device fail path

Shyam Prasad N (2):
      cifs: is_network_name_deleted should return a bool
      cifs: fix mid leak during reconnection after timeout threshold

Shyam Sundar S K (2):
      platform/x86/amd: pmc: Add new ACPI ID AMDI000A
      platform/x86/amd: pmf: Add new ACPI ID AMDI0103

Simon Horman (1):
      net: lan743x: select FIXED_PHY

Sridhar Samudrala (2):
      ice: Fix max_rate check while configuring TX rate limits
      ice: Fix tx queue rate limit when TCs are configured

Srinivas Pandruvada (1):
      platform/x86/intel/tpmi: Prevent overflow for cap_offset

Stafford Horne (1):
      openrisc: Union fpcsr and oldmask in sigcontext to unbreak userspace =
ABI

Stanislav Lisovskiy (1):
      drm/i915: Don't preserve dpll_hw_state for slave crtc in Bigjoiner

Steven Rostedt (Google) (1):
      tracing: Stop FORTIFY_SOURCE complaining about stack trace caller

Stuart Hayhurst (1):
      HID: logitech-hidpp: Add wired USB id for Logitech G502 Lightspeed

Suman Ghosh (1):
      octeontx2-pf: Add additional check for MCAM rules

Suren Baghdasaryan (1):
      sched/psi: use kernfs polling functions for PSI trigger polling

Tan Tee Min (1):
      igc: Include the length/type field and VLAN tag in queueMaxSDU

Thadeu Lima de Souza Cascardo (2):
      netfilter: nf_tables: do not ignore genmask when looking up chain by =
id
      netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

Thomas GENTY (1):
      platform/x86: touchscreen_dmi: Add info for the Archos 101
Cesium Educ tablet

Thomas Hellstr=C3=B6m (2):
      drm/ttm: Don't leak a resource on eviction error
      drm/ttm: Don't leak a resource on swapout move error

Thomas Zimmermann (1):
      drm/client: Send hotplug event after registering a client

Tom Rix (1):
      platform/x86: int3472/discrete: set variable
skl_int3472_regulator_second_sensor storage-class-specifier to static

Tuo Li (1):
      scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()

Tvrtko Ursulin (2):
      drm/i915: Remove dead code from gen8_pte_encode
      drm/i915: Fix one wrong caching mode enum usage

Tzvetomir Stoyanov (VMware) (1):
      kernel/trace: Fix cleanup logic of enable_trace_eprobe

Umesh Nerlige Ramappa (1):
      drm/i915/perf: Consider OA buffer boundary when zeroing out reports

Viresh Kumar (1):
      cpufreq: sparc: Don't mark cpufreq callbacks with __init

Vlad Buslov (1):
      net/mlx5e: Check for NOT_READY flag state after locking

Vladimir Oltean (3):
      net: mscc: ocelot: extend ocelot->fwd_domain_lock to cover
ocelot->tas_lock
      net: dsa: felix: make vsc9959_tas_guard_bands_update() visible
to ocelot->ops
      net: mscc: ocelot: fix oversize frame dropping for preemptible TCs

Wei Fang (4):
      net: fec: dynamically set the NETDEV_XDP_ACT_NDO_XMIT feature of XDP
      net: fec: recycle pages for transmitted XDP frames
      net: fec: increase the size of tx ring and update tx_wake_threshold
      net: fec: use netdev_err_once() instead of netdev_err()

Xin Yin (1):
      erofs: fix fsdax unavailability for chunk-based regular files

Yang Wang (1):
      drm/amd/pm: fix smu i2c data read risk

Yevgeny Kliteynik (1):
      net/mlx5e: TC, CT: Offload ct clear only once

Yonghong Song (1):
      kallsyms: strip LTO-only suffixes from promoted global functions

YueHaibing (1):
      x86/ftrace: Remove unsued extern declaration ftrace_regs_caller_ret()

Yunxiang Li (1):
      drm/ttm: fix bulk_move corruption when adding a entry

Ze Gao (1):
      fprobe: add unlock to match a succeeded ftrace_test_recursion_trylock

Zhang Shurong (1):
      wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()

Zheng Yejian (3):
      ring-buffer: Fix deadloop issue on reading trace_pipe
      ftrace: Fix possible warning on checking all pages used in
ftrace_process_locs()
      tracing: Fix memory leak of iter->temp when reading trace_pipe

Zhengchao Shao (3):
      net/mlx5e: fix double free in mlx5e_destroy_flow_table
      net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create
      net/mlx5e: fix memory leak in mlx5e_ptp_open

Ziyang Xuan (1):
      ipv6/addrconf: fix a potential refcount underflow for idev

gaba (1):
      drm/amdgpu: avoid restore process run into dead loop.
