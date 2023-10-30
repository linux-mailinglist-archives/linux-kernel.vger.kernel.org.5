Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C87DB284
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 05:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjJ3E1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 00:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3E1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 00:27:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA46B4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 21:27:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507f1c29f25so5555657e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 21:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698640032; x=1699244832; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kENBr6e2aOnclW/af4JtmRg+0kfXEDvvlIMmqRvSs9s=;
        b=XbsW1Wo3Hu2e7xRqzqTIRk9zikIFqvpyPfShXOh6bl5rUUKx0n3P++xi7HY7Lh4EpL
         8gsrgtxCj5DMcIHzYuqd/Z5J+YezYjD0lpxyZPLoDgFrji01m17Mq33tkFwnKQfeKhx9
         T+NI1RJmsFI7A7y9VviBF0rnVvZgPO71ttEGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698640032; x=1699244832;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kENBr6e2aOnclW/af4JtmRg+0kfXEDvvlIMmqRvSs9s=;
        b=XBVgqJIRb767fDZdii1bjbuC/UHBfMdCilAh7Ke/e5R7CmjvpDZUqyQcSLGWjwbJEO
         tAtKgb/1F2HE33S7n0zBfE8TXeHfVrwhhkVYit8opjoPIAxJt+e/ZgKJPy66wByj9g6E
         pCqtReSrf7qUNprlSglGHxRv7LlvuAt5P9KuIw6CyCL/YnvvMbGup8+Yt8qjJGZnDmAN
         +2hTFNoeF2K24pCl0qUOc6zxf3bK0l/EQ1BaxmFdpUYxJrDXHNccvGHlr29urY83bYmS
         hyWCO0+xxmawT/h5Y37Yx7fvKGShSHXiMKIO2f2cz52UMcG+1LZW70MeARuwuR6NnZKV
         tkTQ==
X-Gm-Message-State: AOJu0YzK8fLjnwkorIxzA985A4uBDTkbgSxLk739SNO5UetqJ6TezUaI
        8NDSJ0yzjpS5TFvhCudOZilzQYo0xpXVrR/8BSFJpw==
X-Google-Smtp-Source: AGHT+IGhW0CM4iHEKCfWfvbnf1mQcGFlJisIDQHAjY37gQZ8eFWcvpETUcJtK9SJATjtWsUZ5LwNhw==
X-Received: by 2002:ac2:4218:0:b0:503:385c:4319 with SMTP id y24-20020ac24218000000b00503385c4319mr6114631lfh.19.1698640031393;
        Sun, 29 Oct 2023 21:27:11 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id e14-20020aa7d7ce000000b00540ea3a25e6sm5420356eds.72.2023.10.29.21.27.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 21:27:10 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9d224dca585so192426766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 21:27:10 -0700 (PDT)
X-Received: by 2002:a17:907:3e13:b0:9be:b7da:72d6 with SMTP id
 hp19-20020a1709073e1300b009beb7da72d6mr7283207ejc.63.1698640030313; Sun, 29
 Oct 2023 21:27:10 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Oct 2023 18:26:53 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiZuU984NWVgP4snp8sEt4Ux5Mp_pxAN5MNV9VpcGUo+A@mail.gmail.com>
Message-ID: <CAHk-=wiZuU984NWVgP4snp8sEt4Ux5Mp_pxAN5MNV9VpcGUo+A@mail.gmail.com>
Subject: Linux 6.6
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

So this last week has been pretty calm, and I have absolutely no
excuses to delay the v6.6 release any more, so here it is.

There's a random smattering of fixes all over, and apart from some
bigger fixes to the r8152 driver, it's all fairly small.  Below is the
shortlog for last week for anybody who really wants to get a flavor of
the details. It's short enough to scroll through.

This obviously means that the merge window for 6.7 opens tomorrow, and
I appreciate how many early pull requests I have lined up, with 40+
ready to go. That will make it a bit easier for me to deal with it,
since I'll be on the road for the first week of the merge window.

                Linus

---

Al Viro (4):
      nfsd: lock_rename() needs both directories to live on the same fs
      sparc32: fix a braino in fault handling in csum_and_copy_..._user()
      io_uring: kiocb_done() should *not* trust ->ki_pos if
->{read,write}_iter() failed
      ceph_wait_on_conflict_unlink(): grab reference before dropping ->d_lo=
ck

Alain Volmat (1):
      i2c: stm32f7: Fix PEC handling in case of SMBUS transfers

Alessandro Carminati (1):
      clk: Sanitize possible_parent_show to Handle Return Value of
of_clk_get_parent_name

Alex Bee (4):
      ARM: dts: rockchip: Fix i2c0 register address for RK3128
      ARM: dts: rockchip: Add missing arm timer interrupt for RK3128
      ARM: dts: rockchip: Add missing quirk for RK3128's dma engine
      ARM: dts: rockchip: Fix timer clocks for RK3128

Alexandre Ghiti (2):
      riscv: handle VM_FAULT_[HWPOISON|HWPOISON_LARGE] faults instead
of panicking
      riscv: fix set_huge_pte_at() for NAPOT mappings when a swap entry is =
set

Alexandru Matei (1):
      vsock/virtio: initialize the_virtio_vsock before using VQs

Ammar Faizi (1):
      tools/nolibc: i386: Fix a stack misalign bug on _start

Andrii Nakryiko (1):
      tracing/kprobes: Fix symbol counting logic by looking at modules as w=
ell

Aneesh Kumar K.V (1):
      powerpc/mm: Avoid calling arch_enter/leave_lazy_mmu() in set_ptes

Anjali Kulkarni (1):
      Fix NULL pointer dereference in cn_filter()

Arnd Bergmann (1):
      kasan: disable kasan_non_canonical_hook() for HW tags

Avraham Stern (1):
      wifi: mac80211: don't drop all unprotected public action frames

Bartosz Golaszewski (1):
      mailmap: map Bartosz's old address to the current one

Ben Greear (1):
      wifi: cfg80211: pass correct pointer to rdev_inform_bss()

Christian K=C3=B6nig (2):
      drm/amdgpu: ignore duplicate BOs again
      drm/amdkfd: reserve a fence slot while locking the BO

Christoph Hellwig (3):
      riscv: RISCV_NONSTANDARD_CACHE_OPS shouldn't depend on
RISCV_DMA_NONCOHERENT
      riscv: only select DMA_DIRECT_REMAP from RISCV_ISA_ZICBOM and
ERRATA_THEAD_PBMT
      soc: renesas: ARCH_R9A07G043 depends on !RISCV_ISA_ZICBOM

Christophe JAILLET (1):
      net: ieee802154: adf7242: Fix some potential buffer overflow in
adf7242_stats_show()

Christopher Obbard (2):
      arm64: dts: rockchip: Add i2s0-2ch-bus-bclk-off pins to RK3399
      arm64: dts: rockchip: Fix i2s0 pin conflict on ROCK Pi 4 boards

Conor Dooley (1):
      soc: renesas: Make ARCH_R9A07G043 depend on required options

Damien Le Moal (1):
      scsi: sd: Introduce manage_shutdown device flag

Dan Carpenter (2):
      ARM: omap2: fix a debug printk
      clk: stm32: Fix a signedness issue in clk_stm32_composite_determine_r=
ate()

David Lazar (1):
      platform/x86: Add s2idle quirk for more Lenovo laptops

Dell Jin (1):
      net: ethernet: adi: adin1110: Fix uninitialized variable

Deming Wang (2):
      net: ipv4: fix typo in comments
      net: ipv6: fix typo in comments

Douglas Anderson (8):
      r8152: Increase USB control msg timeout to 5000ms as per spec
      r8152: Run the unload routine if we have errors during probe
      r8152: Cancel hw_phy_work if we have an error in probe
      r8152: Release firmware if we have an error in probe
      r8152: Check for unplug in rtl_phy_patch_request()
      r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
      r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
      r8152: Block future register access if register access fails

Dragos Tatulea (2):
      vdpa/mlx5: Fix double release of debugfs entry
      vdpa/mlx5: Fix firmware error on creation of 1k VQs

Ekansh Gupta (4):
      misc: fastrpc: Reset metadata buffer to avoid incorrect free
      misc: fastrpc: Free DMA handles for RPC calls with no arguments
      misc: fastrpc: Clean buffers on remote invocation failures
      misc: fastrpc: Unmap only if buffer is unmapped from DSP

Eric Auger (1):
      vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE

Eric Dumazet (2):
      net: do not leave an empty skb in write queue
      neighbour: fix various data-races

Ermin Sunj (1):
      arm64: dts: rockchip: use codec as clock master on px30-ringneck-haik=
ou

Filipe Manana (1):
      btrfs: fix unwritten extent buffer after snapshotting a new subvolume

Fred Chen (1):
      tcp: fix wrong RTO timeout when received SACK reneging

Gavin Shan (1):
      virtio_balloon: Fix endless deflation and inflation on arm64

Gregory Price (1):
      mm/migrate: fix do_pages_move for compat pointers

Haibo Li (1):
      kasan: print the original fault addr when access invalid shadow

Hao Ge (1):
      firmware/imx-dsp: Fix use_after_free in imx_dsp_setup_channels()

Herve Codina (3):
      i2c: muxes: i2c-mux-pinctrl: Use of_get_i2c_adapter_by_node()
      i2c: muxes: i2c-demux-pinctrl: Use of_get_i2c_adapter_by_node()
      i2c: muxes: i2c-mux-gpmux: Use of_get_i2c_adapter_by_node()

Ivan Vecera (2):
      i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
      i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: set codec system-clock-fixed on px30-ringneck-h=
aikou

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix MODEM initialization failure

Jens Axboe (2):
      io_uring/fdinfo: lock SQ thread while retrieving thread cpu/pid
      io_uring/rw: disable IOCB_DIO_CALLER_COMP

Jian Zhang (1):
      i2c: aspeed: Fix i2c bus hang in slave read

Jinjie Ruan (1):
      fpga: Fix memory leak for fpga_region_test_class_find()

Jisheng Zhang (1):
      riscv: dts: thead: set dma-noncoherent to soc bus

Johannes Berg (1):
      wifi: cfg80211: fix assoc response warning on failed links

Johannes Weiner (1):
      mm: zswap: fix pool refcount bug around shrink_worker()

Karol Wachowski (1):
      accel/ivpu/37xx: Fix missing VPUIP interrupts

Kemeng Shi (1):
      mm/page_alloc: correct start page when guard page debug is enabled

Khazhismel Kumykov (1):
      blk-throttle: check for overflow in calculate_bytes_allowed

Krzysztof Kozlowski (4):
      arm64: dts: qcom: sa8775p: correct PMIC GPIO label in gpio-ranges
      arm64: dts: qcom: apq8096-db820c: fix missing clock populate
      arm64: dts: qcom: msm8996-xiaomi: fix missing clock populate
      dt-bindings: iio: add missing reset-gpios constrain

Kunwu Chan (2):
      treewide: Spelling fix in comment
      isdn: mISDN: hfcsusb: Spelling fix in comment

Liam R. Howlett (4):
      mm/mempolicy: fix set_mempolicy_home_node() previous VMA pointer
      mmap: fix vma_iterator in error path of vma_merge()
      mmap: fix error paths with dup_anon_vma()
      maple_tree: add GFP_KERNEL to allocations in mas_expected_entries()

Liming Wu (1):
      tools/virtio: Add dma sync api for virtio test

Linus Torvalds (1):
      Linux 6.6

Linus Walleij (1):
      iio: afe: rescale: Accept only offset channels

Lu Baolu (1):
      iommu: Avoid unnecessary cache invalidations

Luben Tuikov (1):
      drm/amdgpu: Remove redundant call to priority_is_valid()

Lukasz Majczak (1):
      drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()

Maciej Fijalkowski (1):
      i40e: xsk: remove count_mask

Marc Zyngier (1):
      irqchip/gic-v3-its: Don't override quirk settings with default values

Marco Pagani (1):
      fpga: disable KUnit test suites when module support is enabled

Marek Szyprowski (1):
      iio: exynos-adc: request second interupt only when touchscreen
mode is used

Mario Limonciello (1):
      drm/amd: Disable ASPM for VI w/ all Intel systems

Mateusz Palczewski (1):
      igb: Fix potential memory leak in igb_add_ethtool_nfc_entry

Matt Roper (1):
      drm/i915/mcr: Hold GT forcewake during steering operations

Maxime Ripard (1):
      clk: socfpga: gate: Account for the divider in determine_rate

Maximilian Heyne (1):
      virtio-mmio: fix memory leak of vm_dev

Michael Ellerman (1):
      powerpc/mm: Fix boot crash with FLATMEM

Michael Sit Wei Hong (1):
      net: stmmac: update MAC capabilities when tx queues are updated

Michal Schmidt (2):
      iavf: initialize waitqueues before starting watchdog_task
      iavf: in iavf_down, disable queues when removing the driver

Mirsad Goran Todorovac (3):
      r8169: fix the KCSAN reported data-race in rtl_tx() while
reading tp->cur_tx
      r8169: fix the KCSAN reported data-race in rtl_tx while reading
TxDescArray[entry].opts1
      r8169: fix the KCSAN reported data race in rtl_rx while reading
desc->opts1

Moritz Wanzenb=C3=B6ck (1):
      net/handshake: fix file ref count in handshake_nl_accept_doit()

Nam Cao (1):
      riscv: dts: starfive: visionfive 2: correct spi's ss pin

Oleksij Rempel (1):
      mailmap: correct email aliasing for Oleksij Rempel

Ondrej Jirman (1):
      MAINTAINERS: Ondrej has moved

Pablo Neira Ayuso (3):
      gtp: uapi: fix GTPA_MAX
      gtp: fix fragmentation needed check with gso
      netfilter: flowtable: GC pushes back packets to classic path

Peng Fan (3):
      nvmem: imx: correct nregs for i.MX6SLL
      nvmem: imx: correct nregs for i.MX6UL
      nvmem: imx: correct nregs for i.MX6ULL

Peter Zijlstra (1):
      perf/core: Fix potential NULL deref

Petr Tesarik (1):
      swiotlb: do not try to allocate a TLB bigger than MAX_ORDER pages

Pieter Jansen van Vuuren (1):
      sfc: cleanup and reduce netlink error messages

Randy Dunlap (1):
      ARM: OMAP: timer32K: fix all kernel-doc warnings

Rik van Riel (3):
      hugetlbfs: clear resv_map pointer if mmap fails
      hugetlbfs: extend hugetlb_vma_lock to private VMAs
      hugetlbfs: close race between MADV_DONTNEED and page fault

Rob Herring (1):
      net: xgene: Fix unused xgene_enet_of_match warning for !CONFIG_OF

Robert Hancock (2):
      iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature thres=
holds
      iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScal=
e

Robert Marko (2):
      MAINTAINERS: uDPU: make myself maintainer of it
      MAINTAINERS: uDPU: add remaining Methode boards

Russ Weight (1):
      fpga: m10bmc-sec: Change contact for secure update driver

Samasth Norway Ananda (1):
      selftests/mm: include mman header to access MREMAP_DONTUNMAP identifi=
er

Sasha Neftin (1):
      igc: Fix ambiguity in the ethtool advertising

Sebastian Ott (1):
      mm: fix vm_brk_flags() to not bail out while holding lock

SeongJae Park (1):
      mm/damon/sysfs: check DAMOS regions update progress from
before_terminate()

Shawn.Shao (1):
      vdpa_sim_blk: Fix the potential leak of mgmt_dev

Shigeru Yoshida (1):
      net: usb: smsc95xx: Fix uninit-value access in smsc95xx_read_reg

Su Hui (1):
      net: chelsio: cxgb4: add an error code check in t4_load_phy_fw

Sui Jingfeng (1):
      drm/logicvc: Kconfig: select REGMAP and REGMAP_MMIO

Thomas Gleixner (2):
      x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility
      x86/tsc: Defer marking TSC unstable to a worker

Thomas Wei=C3=9Fschuh (2):
      MAINTAINERS: nolibc: update tree location
      tools/nolibc: mark start_c as weak

Tirthendu Sarkar (1):
      i40e: sync next_to_clean and next_to_process for programming status d=
esc

Tony Lindgren (2):
      clk: ti: Fix missing omap4 mcbsp functional clock and aliases
      clk: ti: Fix missing omap5 mcbsp functional clock and aliases

Tony Luck (1):
      x86/cpu: Add model number for Intel Arrow Lake mobile processor

Umesh Nerlige Ramappa (2):
      drm/i915/perf: Determine context valid in OA reports
      drm/i915/pmu: Check if pmu is closed before stopping event

Vlad Buslov (1):
      net/sched: act_ct: additional checks for outdated flows

Xiang Chen (1):
      ACPI: NFIT: Install Notify() handler before getting NFIT table

Xuan Zhuo (1):
      virtio_pci: fix the common cfg map size

Yujie Liu (1):
      tracing/kprobes: Fix the description of variable length arguments

zhenwei pi (1):
      virtio-crypto: handle config changed by work queue
