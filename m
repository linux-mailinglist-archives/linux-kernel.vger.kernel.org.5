Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E333177AAA1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjHMSrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHMSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 14:47:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F099D1702
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 11:47:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1d03e124so450428666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691952430; x=1692557230;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QSqvhJ1ozHUhd6VPjmgAzlmPbmw58i2YJpT7QJOzOFY=;
        b=LqqiF+wpo4RExj+TFWBncx3qu1yFBJBBp30701olqYlK8Yuv5GFXhJkqhbeVJNeKFF
         XnyQ/tL/bilnaYupSF9s4NrDbwlcUYvqtG0mQQCDDSztJvqie2EMCgeZJF3d8wBThYj/
         Pr3Ob5+JuWXBfu4AtpePkie47wIdT8Ji4x654=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691952430; x=1692557230;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSqvhJ1ozHUhd6VPjmgAzlmPbmw58i2YJpT7QJOzOFY=;
        b=dhSyPLnklEiLD5mG4uivLI2Q2PoR1ep0eXzjaE17YPjWgkwODInqMv8XEflHcz4uC9
         iThKnHbZJ1SgM1oPDakJma3b5lUF8D02Y3Cmkn5ZDgPiCX4n927/AZ653UKW/pmfQ56A
         U8bK6xTJwuVs0vDe5fJKMffRzocF1LYGaNeyEA64IAVY0NgaN9sQmv6REIZP/6X4lHZG
         Eywf/m56xpoUTUm7iz2Jfe47j84HpV2GVI1EnuiMBy8xSZezYyhsdxiTRCmWTIxxJh/i
         PJZbGjuNcq5rM1ZPdVWKXnB/z348bGRH+tPH8x1u/6blqVv9lNiEVg8r4JC6WMfCjwG2
         Oe1A==
X-Gm-Message-State: AOJu0YzcqaM45LRwwLTKyp0+9cCD1jmjDp4e319ZZJTsjwT5PzFGAWVM
        5vSn5B62szcpRYeTJ+xoVHskI0col+/K0sj7eeK+439d
X-Google-Smtp-Source: AGHT+IHLXJm8run8r73CSweTp2rDDb8gXbHF3/6NXw67Uhrq+psdQfK/lgc/UhYsGL49ZHbjXmBV/w==
X-Received: by 2002:a17:907:1dc4:b0:99b:4174:77f6 with SMTP id og4-20020a1709071dc400b0099b417477f6mr5726101ejc.33.1691952429701;
        Sun, 13 Aug 2023 11:47:09 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709060e9700b00977eec7b7e8sm4816831ejf.68.2023.08.13.11.47.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 11:47:09 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so4824193a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 11:47:09 -0700 (PDT)
X-Received: by 2002:aa7:c607:0:b0:525:5ea1:419c with SMTP id
 h7-20020aa7c607000000b005255ea1419cmr1140764edq.9.1691952428530; Sun, 13 Aug
 2023 11:47:08 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Aug 2023 11:46:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4pV_H8bWsfWPQGkcPUyHdVApc6pf6eETkZAF_zxgNNw@mail.gmail.com>
Message-ID: <CAHk-=wg4pV_H8bWsfWPQGkcPUyHdVApc6pf6eETkZAF_zxgNNw@mail.gmail.com>
Subject: Linux 6.5-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So apart from the regularly scheduled hardware mitigation patches,
everything looks fairly normal. And I guess the hw mitigation is to be
considered normal too, apart from the inevitable fixup patches it then
causes because the embargo keeps us from testing it widely and keeps
it from all our public automation. Sigh.

We have a fair number of other random fixes in here too, but nothing
that stands out to me. I guess the one-liner that just disables irq
use for the usual PC TPM device might be more noticeable than most, in
that it hopefully puts that whole sad saga behind us. But even that is
not going to be noticeable in any other way than "we no longer have to
fight the endless reports of irq storms on some laptops". Knock wood.

And we have all the usual small fixes for architectures, networking,
drivers, and selftests.

Shortlog appended with the details - scrolling through them gives a
good flavor of the kinds of things that have been going on.

                Linus

---

Alan Stern (2):
      USB: Gadget: core: Help prevent panic during UVC unconfigure
      usb-storage: alauda: Fix uninit-value in alauda_check_media()

Alejandro Tafalla (1):
      iio: imu: lsm6dsx: Fix mount matrix retrieval

Aleksa Sarai (1):
      io_uring: correct check for O_TMPFILE

Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Add selective 200ms delay after
sending ctrl report

Alex Deucher (5):
      drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()
      drm/amdgpu/gfx11: only enable CP GFX shadowing on SR-IOV
      drm/amdkfd: ignore crat by default
      drm/amdkfd: disable IOMMUv2 support for KV/CZ
      drm/amdkfd: disable IOMMUv2 support for Raven

Alexandra Diupina (1):
      scsi: 53c700: Check that command slot is not NULL

Alexandre Ghiti (3):
      riscv: Start of DRAM should at least be aligned on PMD size for
the direct mapping
      riscv: Do not allow vmap pud mappings for 3-level page table
      riscv: Implement flush_cache_vmap()

Alisa Roman (1):
      iio: adc: ad7192: Fix ac excitation feature

Alvin =C5=A0ipraga (1):
      iio: adc: ina2xx: avoid NULL pointer dereference on OF device match

Andrea Claudi (2):
      selftests: mptcp: join: fix 'delete and re-add' test
      selftests: mptcp: join: fix 'implicit EP' test

Andrea Parri (1):
      riscv,mmio: Fix readX()-to-delay() ordering

Andreas Gruenbacher (1):
      gfs2: Fix freeze consistency check in gfs2_trans_add_meta

Andrew Kanner (2):
      drivers: net: prevent tun_build_skb() to exceed the packet size limit
      net: core: remove unnecessary frame_sz check in bpf_xdp_adjust_tail()

Andrew Yang (1):
      zsmalloc: fix races between modifications of fullness and isolated

Anh Tuan Phan (1):
      tools/counter: Makefile: Replace rmdir by rm to avoid make,clean fail=
ure

Arnaldo Carvalho de Melo (2):
      Revert "perf report: Append inlines to non-DWARF callchains"
      tools arch x86: Sync the msr-index.h copy with the kernel sources

Arnd Bergmann (4):
      KVM: arm64: fix __kvm_host_psci_cpu_entry() prototype
      drm/nouveau: remove unused tu102_gr_load() function
      x86/speculation: Add cpu_show_gds() prototype
      x86: Move gds_ucode_mitigated() declaration to header

August Wikerfors (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G

Ayush Jain (1):
      selftests: mm: ksm: fix incorrect evaluation of parameter

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Fix response to vsafe0V event

Baoquan He (1):
      idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM

Bartosz Golaszewski (1):
      gpio: sim: mark the GPIO chip as a one that can sleep

Bjorn Helgaas (1):
      Revert "PCI: mvebu: Mark driver as BROKEN"

Bob Peterson (1):
      gfs2: Don't use filemap_splice_read

Boris Brezillon (1):
      drm/shmem-helper: Reset vma->vm_ops before calling dma_buf_mmap()

Borislav Petkov (AMD) (15):
      x86/bugs: Increase the x86 bugs vector size to two u32s
      x86/srso: Add a Speculative RAS Overflow mitigation
      x86/srso: Add IBPB_BRTYPE support
      x86/srso: Add SRSO_NO support
      x86/srso: Add IBPB
      x86/srso: Add IBPB on VMEXIT
      x86/srso: Add a forgotten NOENDBR annotation
      x86/srso: Tie SBPB bit setting to microcode patch detection
      x86/sev: Do not try to parse for the CC blob on non-AMD hardware
      x86/CPU/AMD: Do not leak quotient data after a division by 0
      Documentation/hw-vuln: Unify filename specification in index
      driver core: cpu: Unify redundant silly stubs
      Documentation/srso: Document IBPB aspect and fix formatting
      driver core: cpu: Make cpu_show_not_affected() static
      driver core: cpu: Fix the fallback cpu_show_gds() name

Chengfeng Ye (1):
      scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock

Chengming Zhou (1):
      blk-iocost: fix queue stats accounting

Chris Mi (1):
      net/mlx5e: Unoffload post act rule when handling FIB events

Christoph Hellwig (4):
      zram: take device and not only bvec offset into account
      btrfs: don't stop integrity writeback too early
      btrfs: don't wait for writeback on clean pages in extent_write_cache_=
pages
      btrfs: properly clear end of the unreserved range in cow_file_range

Christophe JAILLET (2):
      usb: typec: nb7vpq904m: Add an error handling path in nb7vpq904m_prob=
e()
      dmaengine: mcf-edma: Fix a potential un-allocated memory access

Claudiu Beznea (1):
      MAINTAINERS: update Claudiu Beznea's email address

Colin Ian King (1):
      radix tree test suite: fix incorrect allocation size for pthreads

Cristian Ciocaltea (1):
      x86/cpu/amd: Enable Zenbleed fix for AMD Custom APU 0405

Damien Le Moal (1):
      zonefs: fix synchronous direct writes to sequential files

Dan Carpenter (1):
      iio: frequency: admv1013: propagate errors from regulator_get_voltage=
()

Daniel Jurgens (3):
      net/mlx5: Return correct EC_VF function ID
      net/mlx5: Allow 0 for total host VFs
      net/mlx5: Fix devlink controller number for ECVF

Daniel Sneddon (4):
      x86/speculation: Add Gather Data Sampling mitigation
      x86/speculation: Add force option to GDS mitigation
      x86/speculation: Add Kconfig option for GDS
      KVM: Add GDS_NO support to KVM

Daniel Stone (1):
      drm/rockchip: Don't spam logs in atomic check

Dave Hansen (1):
      Documentation/x86: Fix backwards on/off logic about YMM support

David Howells (1):
      crypto, cifs: fix error handling in extract_iter_to_sg()

David Rheinsberg (1):
      net/unix: use consistent error code in SO_PEERPIDFD

Douglas Miller (1):
      IB/hfi1: Fix possible panic during hotplug remove

Elson Roy Serrao (1):
      usb: dwc3: Properly handle processing of pending events

Eric Dumazet (4):
      net/packet: annotate data-races around tp->status
      dccp: fix data-race around dp->dccps_mss_cache
      macsec: use DEV_STATS_INC()
      tcp: add missing family to tcp_set_ca_state() tracepoint

Esteban Blanc (1):
      misc: tps6594-esm: Disable ESM for rev 1 PMIC

Evan Quan (1):
      drm/amd/pm: disable the SMU13 OD feature support temporarily

Fedor Pchelkin (1):
      drivers: vxlan: vnifilter: free percpu vni stats on error path

Felix Fietkau (1):
      wifi: cfg80211: fix sband iftype data lookup for AP_VLAN

Fenghua Yu (1):
      dmaengine: idxd: Clear PRS disable flag when disabling IDXD device

Florian Westphal (3):
      tunnels: fix kasan splat when generating ipv4 pmtu error
      selftests: net: test vxlan pmtu exceptions with tcp
      netfilter: nf_tables: don't skip expired elements during walk

Fuad Tabba (7):
      KVM: arm64: Factor out code for checking (h)VHE mode into a macro
      KVM: arm64: Use the appropriate feature trap register for SVE at EL2 =
setup
      KVM: arm64: Disable SME traps for (h)VHE at setup
      KVM: arm64: Helper to write to appropriate feature trap register
based on mode
      KVM: arm64: Use the appropriate feature trap register when
activating traps
      KVM: arm64: Fix resetting SVE trap values on reset for hVHE
      KVM: arm64: Fix resetting SME trap values on reset for (h)VHE

Gal Pressman (1):
      net/mlx5e: Take RTNL lock when needed before calling xdp_set_features=
()

Geert Uytterhoeven (1):
      workqueue: Fix cpu_intensive_thresh_us name in help text

George Stark (1):
      iio: adc: meson: fix core clock enable/disable moment

Gerd Bayer (2):
      net/smc: Fix setsockopt and sysctl to specify same buffer size again
      net/smc: Use correct buffer sizes when switching between TCP and SMC

Gustavo A. R. Silva (1):
      media: venus: Use struct_size_t() helper in pkt_session_unset_buffers=
()

Hans de Goede (5):
      ACPI: resource: revert "Remove "Zen" specific match and quirks"
      ACPI: resource: Always use MADT override IRQ settings for all
legacy non i8042 IRQs
      ACPI: resource: Honor MADT INT_SRC_OVR settings for IRQ1 on AMD Zen
      ACPI: resource: Add IRQ override quirk for PCSpecialist Elimina Pro 1=
6 M
      platform/x86: lenovo-ymc: Only bind on machines with a
convertible DMI chassis-type

Hao Chen (1):
      net: hns3: fix strscpy causing content truncation issue

Heikki Krogerus (1):
      usb: typec: mux: intel: Add dependency on USB_COMMON

Helge Deller (16):
      io_uring/parisc: Adjust pgoff in io_uring mmap() for parisc
      parisc: Fix lightweight spinlock checks to not break futexes
      parisc: fault: Use C99 arrary initializers
      parisc: ioremap: Fix sparse warnings
      parisc: signal: Fix sparse incorrect type in assignment warning
      parisc: firmware: Fix sparse context imbalance warnings
      parisc: firmware: Mark pdc_result buffers local
      parisc: ucmpdi2: Fix no previous prototype for '__ucmpdi2' warning
      parisc: parisc_ksyms: Include libgcc.h for libgcc prototypes
      parisc: dma: Add prototype for pcxl_dma_start
      parisc: Move proc_mckinley_root and proc_runway_root to sba_iommu
      parisc: unaligned: Include linux/sysctl.h for unaligned_enabled
      parisc: processor: Include asm/smp.h for init_per_cpu()
      parisc: boot: Nuke some sparse warnings in decompressor
      parisc: ftrace: Add declaration for ftrace_function_trampoline()
      parisc: perf: Make cpu_device variable static

Ian Rogers (1):
      perf stat: Don't display zero tool counts

Ido Schimmel (20):
      nexthop: Fix infinite nexthop dump when using maximum nexthop ID
      nexthop: Make nexthop bucket dump more efficient
      nexthop: Fix infinite nexthop bucket dump when using maximum nexthop =
ID
      selftests: forwarding: Skip test when no interfaces are specified
      selftests: forwarding: Switch off timeout
      selftests: forwarding: bridge_mdb: Check iproute2 version
      selftests: forwarding: bridge_mdb_max: Check iproute2 version
      selftests: forwarding: Set default IPv6 traceroute utility
      selftests: forwarding: Add a helper to skip test when using veth pair=
s
      selftests: forwarding: ethtool: Skip when using veth pairs
      selftests: forwarding: ethtool_extended_state: Skip when using veth p=
airs
      selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
      selftests: forwarding: ethtool_mm: Skip when MAC Merge is not support=
ed
      selftests: forwarding: tc_actions: Use ncat instead of nc
      selftests: forwarding: tc_flower: Relax success criterion
      selftests: forwarding: tc_tunnel_key: Make filters more specific
      selftests: forwarding: tc_flower_l2_miss: Fix failing test with old l=
ibnet
      selftests: forwarding: bridge_mdb: Fix failing test with old libnet
      selftests: forwarding: bridge_mdb_max: Fix failing test with old libn=
et
      selftests: forwarding: bridge_mdb: Make test more robust

Igor Mammedov (1):
      PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only
for non-root bus

Ilpo J=C3=A4rvinen (1):
      dmaengine: pl330: Return DMA_PAUSED when transaction is paused

Jakub Kicinski (2):
      net: tls: avoid discarding data on record close
      net: tls: set MSG_SPLICE_PAGES consistently

James Clark (1):
      scripts/kallsyms: Fix build failure by setting errno before
calling getline()

Jarkko Sakkinen (1):
      tpm_tis: Opt-in interrupts

Jason A. Donenfeld (1):
      wireguard: allowedips: expand maximum node depth

Jean Delvare (1):
      platform/x86: msi-ec: Fix the build

Jeffrey Hugo (1):
      dmaengine: qcom_hidma: Update codeaurora email domain

Jens Axboe (2):
      block: get rid of unused plug->nowait flag
      block: don't make REQ_POLLED imply REQ_NOWAIT

Jian Shen (1):
      net: hns3: restore user pause configure when disable autoneg

Jianbo Liu (1):
      net/mlx5e: TC, Fix internal port memory leak

Jie Wang (2):
      net: hns3: refactor hclge_mac_link_status_wait for interface reuse
      net: hns3: add wait until mac link down

Jinghao Jia (1):
      x86/linkage: Fix typo of BUILD_VDSO in asm/linkage.h

Johan Hovold (1):
      Revert "PCI: dwc: Wait for link up only if link is started"

Johannes Weiner (2):
      mm: compaction: fix endless looping over same migrate block
      selftests: cgroup: fix test_kmem_basic false positives

Jonas Gorski (1):
      net: marvell: prestera: fix handling IPv4 routes with nhid

Jonathan McDowell (1):
      tpm/tpm_tis: Disable interrupts for Lenovo P620 devices

Josef Bacik (2):
      btrfs: wait for actual caching progress during allocation
      btrfs: set cache_block_group_error if we find an error

Josh Poimboeuf (1):
      x86/srso: Fix return thunks in generated code

Junxian Huang (1):
      MAINTAINERS: Remove maintainer of HiSilicon RoCE

Justin Tee (1):
      scsi: lpfc: Remove reftag check in DIF paths

Kalesh AP (1):
      RDMA/bnxt_re: Fix error handling in probe failure path

Karan Tilak Kumar (1):
      scsi: fnic: Replace return codes in fnic_clean_pending_aborts()

Karol Herbst (2):
      drm/nouveau/gr: enable memory loads on helper invocation on all chann=
els
      drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_mo=
des

Karol Wachowski (1):
      accel/ivpu: Add set_pages_array_wc/uc for internal buffers

Kashyap Desai (1):
      RDMA/bnxt_re: Initialize dpi_tbl_lock mutex

Kees Cook (1):
      vboxsf: Use flexible arrays for trailing string member

Keith Yeo (1):
      wifi: nl80211: fix integer overflow in nl80211_parse_mbssid_elems()

Kenneth Feng (1):
      drm/amd/pm: correct the pcie width for smu 13.0.0

Kirill A. Shutemov (2):
      mm: Fix access_remote_vm() regression on tagged addresses
      x86/mm: Fix VDSO and VVAR placement on 5-level paging machines

Krzysztof Kozlowski (1):
      dt-bindings: iio: adi,ad74115: remove ref from -nanoamp

Krzysztof Wilczy=C5=84ski (1):
      MAINTAINERS: Add Manivannan Sadhasivam as DesignWare PCIe driver
maintainer

Kunihiko Hayashi (1):
      mmc: sdhci-f-sdh30: Replace with sdhci_pltfm

Lama Kayal (1):
      net/mlx5e: Add capability check for vnic counters

Larry Finger (2):
      MAINTAINERS: Update entry for rtl8187
      MAINTAINERS: Remove tree entry for rtl8180

Li Yang (2):
      net: phy: at803x: fix the wol setting functions
      net: phy: at803x: remove set/get wol callbacks for AR8032

Liam R. Howlett (1):
      MAINTAINERS: add maple tree mailing list

Lijo Lazar (2):
      drm/amdgpu: Match against exact bootloader status
      drm/amd/pm: Fix SMU v13.0.6 energy reporting

Linus Torvalds (1):
      Linux 6.5-rc6

Long Li (1):
      ksmbd: validate command request size

Lorenzo Stoakes (1):
      fs/proc/kcore: reinstate bounce buffer for KCORE_TEXT regions

Lyude Paul (1):
      drm/nouveau/nvkm/dp: Add workaround to fix DP 1.3+ DPCD issues

Maciej =C5=BBenczykowski (1):
      ipv6: adjust ndisc_is_useropt() to also return true for PIO

Magnus Karlsson (1):
      xsk: fix refcount underflow in error path

Mario Limonciello (5):
      tpm: Disable RNG for all AMD fTPMs
      drm/amd: Disable S/G for APUs when 64GB or more host memory
      drm/amd/display: Don't show stack trace for missing eDP
      drm/amd/display: Fix a regression on Polaris cards
      tpm: Add a helper for checking hwrng enabled

Mark Brown (1):
      selftests/rseq: Fix build with undefined __weak

Masahiro Yamada (1):
      alpha: remove __init annotation from exported page_is_ram()

Mateusz Guzik (1):
      locking: remove spin_lock_prefetch

Matti Vaittinen (3):
      iio: light: bu27034: Fix scale format
      iio: light: bu27008: Fix scale format
      iio: light: bu27008: Fix intensity data type

Maulik Shah (2):
      cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
      cpuidle: psci: Move enabling OSI mode after power domains creation

Melissa Wen (1):
      drm/amd/display: check attr flag before set cursor degamma on DCN3+

Miaohe Lin (3):
      mm/swapfile: fix wrong swap entry type for hwpoisoned swapcache page
      mm: memory-failure: fix potential unexpected return value from
unpoison_memory()
      mm: memory-failure: avoid false hwpoison page mapped error info

Michael Guralnik (1):
      RDMA/umem: Set iova in ODP flow

Michael Kelley (1):
      scsi: storvsc: Fix handling of virtual Fibre Channel timeouts

Mika Westerberg (1):
      thunderbolt: Fix memory leak in tb_handle_dp_bandwidth_request()

Mike Kravetz (1):
      hugetlb: do not clear hugetlb dtor until allocating vmemmap

Mike Tipton (1):
      interconnect: qcom: Add support for mask-based BCMs

Milan Zamazal (1):
      iio: core: Prevent invalid memory access when there is no parent

Ming Lei (4):
      nvme: fix possible hang when removing a controller during error recov=
ery
      nvme-tcp: fix potential unbalanced freeze & unfreeze
      nvme-rdma: fix potential unbalanced freeze & unfreeze
      nvme: core: don't hold rcu read lock in nvme_ns_chr_uring_cmd_iopoll

Minjie Du (1):
      dmaengine: xilinx: xdma: Fix Judgment of the return value

Miquel Raynal (2):
      dmaengine: xilinx: xdma: Fix interrupt vector setting
      dmaengine: xilinx: xdma: Fix typo

Moshe Shemesh (2):
      net/mlx5: Skip clock update work when device is in error state
      net/mlx5: Reload auxiliary devices in pci error handlers

Muhammad Husaini Zulkifli (1):
      igc: Add lock to safeguard global Qbv variables

Namjae Jeon (1):
      ksmbd: fix wrong next length validation of ea buffer in smb2_set_ea()

Nathan Chancellor (1):
      mISDN: Update parameter type of dsp_cmx_send()

Neil Armstrong (4):
      interconnect: qcom: sm8450: add enable_mask for bcm nodes
      interconnect: qcom: sm8550: add enable_mask for bcm nodes
      interconnect: qcom: sa8775p: add enable_mask for bcm nodes
      Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packe=
t"

Nick Child (5):
      ibmvnic: Enforce stronger sanity checks on login response
      ibmvnic: Unmap DMA login rsp buffer on send login fail
      ibmvnic: Handle DMA unmapping of login buffs in release functions
      ibmvnic: Do partial reset on login failure
      ibmvnic: Ensure login failure recovery is safe from other resets

Nick Desaulniers (2):
      riscv: mm: fix 2 instances of -Wmissing-variable-declarations
      x86/srso: Fix build breakage with the LLVM linker

Nilesh Javali (2):
      scsi: qedi: Fix firmware halt over suspend and resume
      scsi: qedf: Fix firmware halt over suspend and resume

Nitya Sunkad (1):
      ionic: Add missing err handling for queue reconfig

Oliver Upton (3):
      KVM: arm64: Allow pKVM on v1.0 compatible FF-A implementations
      KVM: arm64: Rephrase percpu enable/disable tracking in terms of hyp
      KVM: arm64: Skip instruction after emulating write to TCR_EL1

Pablo Neira Ayuso (4):
      netfilter: nf_tables: GC transaction API to avoid race with control p=
lane
      netfilter: nf_tables: adapt set backend to use GC transaction API
      netfilter: nft_set_hash: mark set element as dead when deleting
from packet path
      netfilter: nf_tables: remove busy mark and gc batch API

Paolo Abeni (2):
      mptcp: avoid bogus reset on fallback close
      mptcp: fix disconnect vs accept race

Paolo Bonzini (3):
      KVM: SEV: snapshot the GHCB before accessing it
      KVM: SEV: only access GHCB fields once
      KVM: SEV: remove ghcb variable declarations

Peter Ujfalusi (1):
      tpm: tpm_tis: Fix UPX-i11 DMI_MATCH condition

Petr Tesarik (1):
      wifi: brcm80211: handle params_v1 allocation failure

Pin-yen Lin (1):
      drm/bridge: it6505: Check power state with it6505->powered in IRQ han=
dler

Ping-Ke Shih (1):
      wifi: rtw89: fix 8852AE disconnection caused by RX full flags

Piotr Gardocki (1):
      iavf: fix potential races for FDIR filters

Prashanth K (1):
      usb: common: usb-conn-gpio: Prevent bailing out if initial role is no=
ne

Qi Zheng (1):
      binder: fix memory leak in binder_init()

Qu Wenruo (3):
      btrfs: avoid race between qgroup tree creation and relocation
      btrfs: exit gracefully if reloc roots don't match
      btrfs: reject invalid reloc tree root keys with stack dump

RD Babiera (1):
      usb: typec: altmodes/displayport: Signal hpd when configuring
pin assignment

Raghavendra Rao Ananta (1):
      KVM: arm64: Fix hardware enable/disable flows for pKVM

Ricky WU (1):
      misc: rtsx: judge ASPM Mode to set PETXCFG Reg

Ross Lagerwall (1):
      xen/netback: Fix buffer overrun triggered by unusual packet

Ryusuke Konishi (1):
      nilfs2: fix use-after-free of nilfs_root in dirtying inodes via iput

Samuel Holland (1):
      riscv: Fix CPU feature detection with SMP disabled

Sanjay R Mehta (1):
      thunderbolt: Fix Thunderbolt 3 display flickering issue on 2nd
hot plug onwards

Selvin Xavier (1):
      RDMA/bnxt_re: Properly order ib_device_unalloc() to avoid UAF

SeongJae Park (1):
      mm/damon/core: initialize damo_filter->list from damos_new_filter()

Sergei Antonov (1):
      mmc: moxart: read scr register without changing byte order

Shay Drory (1):
      net/mlx5: LAG, Check correct bucket when modifying LAG

Simon Trimmer (1):
      ACPI: scan: Create platform device for CS35L56

Souradeep Chakrabarti (1):
      net: mana: Fix MANA VF unload when hardware is unresponsive

Srinivas Pandruvada (1):
      platform/x86: ISST: Reduce noise for missing numa information in logs

Takashi Iwai (1):
      tpm/tpm_tis: Disable interrupts for TUXEDO InfinityBook S 15/17 Gen7

Tao Ren (1):
      hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100

Tejun Heo (1):
      workqueue: Scale up wq_cpu_intensive_thresh_us if BogoMIPS is below 4=
000

Thomas Wei=C3=9Fschuh (1):
      cpufreq: amd-pstate: fix global sysfs attribute type

Tim Huang (1):
      drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU v13.0.4/11

Tom Rix (1):
      sysctl: set variable key_sysctls storage-class-specifier to static

Tony Battersby (1):
      scsi: core: Fix legacy /proc parsing buffer overflow

Torsten Duwe (2):
      riscv/kexec: handle R_RISCV_CALL_PLT relocation type
      riscv/kexec: load initrd high in available memory

Vadim Pasternak (4):
      platform: mellanox: Fix order in exit flow
      platform: mellanox: mlx-platform: Fix signals polarity and latch mask
      platform: mellanox: mlx-platform: Modify graceful shutdown
callback and power down mask
      platform: mellanox: Change register offset addresses

Vlad Buslov (1):
      vlan: Fix VLAN 0 memory leak

Vladimir Oltean (4):
      net: dsa: ocelot: call dsa_tag_8021q_unregister() under
rtnl_lock() on driver remove
      PCI: move OF status =3D "disabled" detection to dev->match_driver
      net: enetc: reimplement RFS/RSS memory clearing as PCI quirk
      net: enetc: remove of_device_is_available() handling

Vlastimil Babka (1):
      PM: hibernate: fix resume_store() return value when hibernation
not available

Wen Gong (1):
      wifi: ath12k: Fix buffer overflow when scanning with extraie

William Breathitt Gray (3):
      counter: Fix menuconfig "Counter support" submenu entries disappearan=
ce
      counter: Fix menuconfig "Counter support" submenu entries disappearan=
ce
      gpio: ws16c48: Fix off-by-one error in WS16C48 resource region extent

Xiang Yang (1):
      mptcp: fix the incorrect judgment for msk->cb_flags

Xin Li (1):
      x86/vdso: Choose the right GDT_ENTRY_CPUNODE for 32-bit getcpu()
on 64-bit kernel

Xu Kuohai (4):
      bpf, sockmap: Fix map type error in sock_map_del_link
      bpf, sockmap: Fix bug that strp_done cannot be called
      selftests/bpf: fix a CI failure caused by vsock sockmap test
      selftests/bpf: Add sockmap test for redirecting partial skb data

Yang Li (1):
      platform/x86/amd/pmf: Fix unsigned comparison with less than zero

Yang Yingliang (1):
      parisc: pdt: Use PTR_ERR_OR_ZERO() to simplify code

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix wrong allocation of modify hdr pattern

Yiyuan Guo (1):
      iio: cros_ec: Fix the allocation size for cros_ec_command

Yonglong Liu (1):
      net: hns3: fix deadlock issue when externel_lb and reset are
executed together

Yoshihiro Shimoda (1):
      scsi: ufs: renesas: Fix private allocation

Zhang Jianhua (1):
      dmaengine: owl-dma: Modify mismatched function name

Zhu Wang (2):
      scsi: core: Fix possible memory leak if device_add() fails
      scsi: snic: Fix possible memory leak if device_add() fails

Ziyang Xuan (1):
      bonding: Fix incorrect deletion of ETH_P_8021AD protocol vid from sla=
ves
