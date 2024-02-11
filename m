Return-Path: <linux-kernel+bounces-60948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30561850B77
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2C61C21AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E698C5915F;
	Sun, 11 Feb 2024 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mwf8hZ9C"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8270F41A84
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707683786; cv=none; b=Vt7NWaxyuEdgUDP9vGX3H01PRA0wS+xZZqHOe17Ij9R3a9wMPPIGXxCFTzfWT8KUyAiIdSOD/DZcWt0yv2Mm6ZlgNwjdsb7uhHkFZ2grZEMwI7y8TObRD12eFnnOmTIoXW58lMRYpaS4Yk/Fygi0E0F+ERXu3cX5GlHSO/zlzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707683786; c=relaxed/simple;
	bh=6fPBREhfOjP34qQAGgQVTkCC6UNRhvHWIAttyXtIpdU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=brI+Sj/nvsJl2ELSbh+358mDfD1hSoiTymvIOBbQE/ohhvRh4XC63uxve3s51Mnh6lEv+rpDHK/RL0A880vBZtyTlSaG+GUl4HNUws+4tn8iQhXLC83s/w6Z6IHF1gr7WRbGgpnttQ2WH49z7HOdru+bWimCVNr8OYUHDR66rww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mwf8hZ9C; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d09cf00214so33741841fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707683781; x=1708288581; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=19PyMb0QA5vBz+Q8+pDBjMuS+GfauVWfz316pbSFiZI=;
        b=Mwf8hZ9CVYYOnA7ieib1asUY4/dLeW2uTs9dCiawn8ZMBN28zTSKZW6Nju2+ROGOiG
         QZccyhiiHfn5h2pNGOH1zFw3fr0ozj1kQXcenF4FHJCzbcZqCbNIPwHrOl7ZDMYrsWOU
         yNjtDeuZb1EiO+t7aRbHNiJs423XsBYsN5JYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707683781; x=1708288581;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19PyMb0QA5vBz+Q8+pDBjMuS+GfauVWfz316pbSFiZI=;
        b=NF1G+NuvkyfsTWk/P1AHd3liWSF+BjkUtbu5+aYBhnn1DzgjXaRGt6Z+Q3rkIQN+rj
         ePvDK1QFyaL/PIJt7+6w4gl5uF/Y3vXN3l3Leluj2yqkCTjRdE/KjpqUTbFYRvxyja+y
         rIikS+BMaGlzJ86H8lT6HAuj40P8MxoET3BJ2my8UZYGaor/i04QsdAfjUkKvHRKz/KD
         oSnvpBIYg2qiXeN7ze7C+NwyW/nVwXnJfe8rANZPs2L6/4O6hMJEkLiUWlXicSGon3im
         e8pXlLPovFu9dUkNNmaxMfgornkutzKuHvh1Llu/TlxSODuW7qhXqGGUkJqrwtvGdQSg
         KaNg==
X-Gm-Message-State: AOJu0Yz0OgNJC+BXRqnF3rOovU/mk+lRy9nBmLg6KkIjahIyAOjTsIDO
	5UhaYKE9wXfgZ72OTA2912ZUEWjT+Rnj+nzc79+cJVq9XgtPc4PI2tkx+qO/ow5ELAVuZLqFU7y
	OEoE=
X-Google-Smtp-Source: AGHT+IGzd1Ovo5cp8rvglXgJ3m5mZD4A6d1c0CIDv493Btq/6+VAESCDPbZI4tk/ed0UzzNr5Cjp6g==
X-Received: by 2002:a2e:b88a:0:b0:2d0:77dd:f227 with SMTP id r10-20020a2eb88a000000b002d077ddf227mr3495242ljp.5.1707683780799;
        Sun, 11 Feb 2024 12:36:20 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id z28-20020a05651c023c00b002d0ae4d386csm1087724ljn.56.2024.02.11.12.36.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 12:36:20 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-511531f03f6so2998978e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:36:20 -0800 (PST)
X-Received: by 2002:a05:6512:3451:b0:511:8f53:9a05 with SMTP id
 j17-20020a056512345100b005118f539a05mr220968lfr.13.1707683779472; Sun, 11 Feb
 2024 12:36:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2024 12:36:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1c4Q1Ve6BG71DikHu-AEoKUUQoj1QbVdjwGQyTExqCw@mail.gmail.com>
Message-ID: <CAHk-=wg1c4Q1Ve6BG71DikHu-AEoKUUQoj1QbVdjwGQyTExqCw@mail.gmail.com>
Subject: Linux 6.8-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Commit counts and contents look normal for this phase of the release,
nothing here really stands out.

Sure, we've got a ntfs3 fix dump, which shows up a bit in the stats,
but the bulk is all the usual suspects: drivers (particularly gpu and
networking) and core networking.

The rest is the usual random collection of fixes all over: other
drivers, some architecture fixes (mainly x86 and RISC-V), and some
core vm and tracing noise. And selftests.

Please continue testing,

              Linus

---

Abhinav Kumar (1):
      drm/msm/dpu: check for valid hw_pp in dpu_encoder_helper_phys_cleanup

Aleksander Mazur (1):
      x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Alexander Stein (1):
      mmc: slot-gpio: Allow non-sleeping GPIO ro

Alexandra Winter (1):
      s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Alexandre Ghiti (6):
      riscv: Fix wrong size passed to local_flush_tlb_range_asid()
      riscv: Fix set_huge_pte_at() for NAPOT mapping
      riscv: Fix hugetlb_mask_last_page() when NAPOT is enabled
      riscv: Flush the tlb when a page directory is freed
      riscv: Fix arch_hugetlb_migration_supported() for NAPOT
      riscv: Fix arch_tlbbatch_flush() by clearing the batch cpumask

Alice Chao (1):
      scsi: ufs: core: Fix shift issue in ufshcd_clear_cmd()

Allison Henderson (1):
      MAINTAINERS: Maintainer change for rds

Alvin Lee (1):
      drm/amd/display: Update phantom pipe enable / disable sequence

Andrei Vagin (1):
      x86/fpu: Stop relying on userspace for info to fault in xsave buffer

Andrew Bresticker (2):
      efi: runtime: Fix potential overflow of soft-reserved region size
      efi: Don't add memblocks for soft-reserved memory

Antoine Tenart (1):
      tunnels: fix out of bounds access when building IPv6 PMTU error

Anup Patel (14):
      RISC-V: KVM: Allow Zbc extension for Guest/VM
      KVM: riscv: selftests: Add Zbc extension to get-reg-list test
      RISC-V: KVM: Allow scalar crypto extensions for Guest/VM
      KVM: riscv: selftests: Add scaler crypto extensions to get-reg-list test
      RISC-V: KVM: Allow vector crypto extensions for Guest/VM
      KVM: riscv: selftests: Add vector crypto extensions to get-reg-list test
      RISC-V: KVM: Allow Zfh[min] extensions for Guest/VM
      KVM: riscv: selftests: Add Zfh[min] extensions to get-reg-list test
      RISC-V: KVM: Allow Zihintntl extension for Guest/VM
      KVM: riscv: selftests: Add Zihintntl extension to get-reg-list test
      RISC-V: KVM: Allow Zvfh[min] extensions for Guest/VM
      KVM: riscv: selftests: Add Zvfh[min] extensions to get-reg-list test
      RISC-V: KVM: Allow Zfa extension for Guest/VM
      KVM: riscv: selftests: Add Zfa extension to get-reg-list test

Ard Biesheuvel (4):
      riscv/efistub: Tighten ELF relocation check
      x86/efistub: Give up if memory attribute protocol returns an error
      x86/efistub: Avoid placing the kernel below LOAD_PHYSICAL_ADDR
      x86/efistub: Use 1:1 file:memory mapping for PE/COFF .compat section

Arend van Spriel (1):
      MAINTAINERS: wifi: brcm80211: cleanup entry

Arnd Bergmann (1):
      drm/xe: circumvent bogus stringop-overflow warning

Bartosz Golaszewski (1):
      gpio: remove GPIO device from the list unconditionally in error path

Ben Dooks (1):
      riscv: declare overflow_stack as exported from traps.c

Benjamin Berg (2):
      wifi: iwlwifi: mvm: skip adding debugfs symlink for reconfig
      wifi: iwlwifi: do not announce EPCS support

Boris Burkov (2):
      btrfs: forbid creating subvol qgroups
      btrfs: forbid deleting live subvol qgroup

Breno Leitao (9):
      wifi: fill in MODULE_DESCRIPTION()s for wlcore
      wifi: fill in MODULE_DESCRIPTION()s for wl1251 and wl12xx
      wifi: fill in MODULE_DESCRIPTION()s for Broadcom WLAN
      wifi: fill in MODULE_DESCRIPTION()s for ar5523
      wifi: fill in MODULE_DESCRIPTION()s for wcn36xx
      wifi: fill in MODULE_DESCRIPTION()s for p54spi
      wifi: fill in MODULE_DESCRIPTION()s for wl18xx
      wifi: fill in MODULE_DESCRIPTION()s for wilc1000
      wifi: fill in MODULE_DESCRIPTION()s for mt76 drivers

Chaitanya Kulkarni (1):
      nvme-core: fix comment to reflect right functions

Chengming Zhou (1):
      mm/zswap: don't return LRU_SKIP if we have dropped lru lock

Christian Borntraeger (1):
      KVM: s390: vsie: fix race during shadow creation

Christophe JAILLET (1):
      fs/ntfs3: Slightly simplify ntfs_inode_printk()

Dan Carpenter (4):
      fs/ntfs3: Fix an NULL dereference bug
      drm/i915/gvt: Fix uninitialized variable in handle_mmio()
      PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()
      PCI: dwc: Clean up dw_pcie_ep_raise_msi_irq() alignment

Daniel Basilio (1):
      nfp: use correct macro for LengthSelect in BAR config

Daniel de Villiers (1):
      nfp: flower: prevent re-adding mac index for bonded port

Dave Airlie (1):
      nouveau/gsp: use correct size for registry rpc.

David Howells (4):
      rxrpc: Fix generation of serial numbers to skip zero
      rxrpc: Fix delayed ACKs to not set the reference serial number
      rxrpc: Fix response to PING RESPONSE ACKs to a dead call
      rxrpc: Fix counting of new acks and nacks

David Sterba (1):
      btrfs: send: return EOPNOTSUPP on unknown flags

Dmitry Baryshkov (1):
      drm/msm/mdss: specify cfg bandwidth for SDM670

Dmitry Safonov (1):
      selftests/net: Amend per-netns counter checks

Edward Adam Davis (1):
      fs/ntfs3: Fix oob in ntfs_listxattr

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix a battery life regression

Eric Dumazet (3):
      netdevsim: avoid potential loop in nsim_dev_trap_report_work()
      inet: read sk->sk_family once in inet_recv_error()
      ppp_async: limit MRU to 64K

Eric Farman (1):
      KVM: s390: fix cc for successful PQAP

Eugen Hristev (1):
      pmdomain: mediatek: fix race conditions with genpd

Fangzhi Zuo (1):
      drm/amd/display: Fix MST Null Ptr for RV

Fedor Pchelkin (1):
      ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails

Felix Fietkau (1):
      wifi: mt76: mt7996: fix fortify warning

Felix Huettner (1):
      netfilter: ctnetlink: fix filtering for zone 0

Florian Westphal (4):
      netfilter: nfnetlink_queue: un-break NF_REPEAT
      netfilter: nft_set_pipapo: store index in scratch maps
      netfilter: nft_set_pipapo: add helper to release pcpu scratch area
      netfilter: nft_set_pipapo: remove scratch_aligned pointer

Francis Pravin (1):
      nvme: use ns->head->pi_size instead of t10_pi_tuple structure size

Fred Ai (1):
      mmc: sdhci-pci-o2micro: Fix a warm reboot issue that disk can't
be detected by BIOS

Frederic Weisbecker (1):
      hrtimer: Report offline hrtimer enqueue

Furong Xu (2):
      net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
      net: stmmac: xgmac: fix a typo of register name in DPP safety handling

Geert Uytterhoeven (1):
      pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Gerhard Engleder (1):
      tsnep: Fix mapping for zero copy XDP_TX action

Gregory Greenman (1):
      MAINTAINERS: remove myself as iwlwifi driver maintainer

Grzegorz Trzebiatowski (1):
      accel/ivpu: Add job status for jobs aborted by the driver

Guoyu Ou (1):
      bcachefs: unlock parent dir if entry is not found in subvolume deletion

Hannes Reinecke (1):
      scsi: lpfc: Use unsigned type for num_sge

Helge Deller (1):
      bcachefs: Fix build on parisc by avoiding __multi3()

Herbert Xu (2):
      crypto: cbc - Ensure statesize is zero
      crypto: algif_hash - Remove bogus SGL free on zero-length error path

Huacai Chen (2):
      LoongArch: Change acpi_core_pic[NR_CPUS] to acpi_core_pic[MAX_CORE_PIC]
      LoongArch: Fix earlycon parameter if KASAN enabled

Ira Weiny (2):
      cxl/cper: Fix errant CPER prints for CXL events
      cxl/trace: Remove unnecessary memcpy's

Ism Hong (1):
      fs/ntfs3: use non-movable memory for ntfs3 MFT buffer cache

Ivan Vecera (1):
      net: atlantic: Fix DMA mapping for PTP hwts ring

Jacek Lawrynowicz (1):
      accel/ivpu: Disable d3hot_delay on all NPU generations

Jakub Kicinski (1):
      selftests: cmsg_ipv6: repeat the exact packet

James Hershaw (1):
      nfp: enable NETDEV_XDP_ACT_REDIRECT feature flag

Jan Kara (1):
      blk-wbt: Fix detection of dirty-throttled tasks

Jan Kiszka (1):
      riscv/efistub: Ensure GP-relative addressing is not used

Jesse Brandeburg (1):
      net: intel: fix old compiler regressions

Jiri Pirko (1):
      devlink: avoid potential loop in devlink_rel_nested_in_notify_work()

Johannes Berg (13):
      wifi: iwlwifi: fix double-free bug
      wifi: cfg80211: fix wiphy delayed work queueing
      wifi: iwlwifi: remove extra kernel-doc
      wifi: cfg80211: detect stuck ECSA element in probe resp
      wifi: mac80211: improve CSA/ECSA connection refusal
      wifi: mac80211: fix RCU use in TDLS fast-xmit
      wifi: mac80211: set station RX-NSS on reconfig
      wifi: mac80211: fix driver debugfs for vif type change
      wifi: mac80211: initialize SMPS mode correctly
      wifi: mac80211: fix unsolicited broadcast probe config
      wifi: mac80211: fix waiting for beacons logic
      wifi: mac80211: adding missing drv_mgd_complete_tx() call
      wifi: mac80211: accept broadcast probe responses on 6 GHz

Johannes Weiner (1):
      mm: zswap: fix objcg use-after-free in entry destruction

John Moon (1):
      mailmap: switch email address for John Moon

Jozsef Kadlecsik (1):
      netfilter: ipset: Missing gc cancellations fixed

Kees Cook (2):
      wifi: brcmfmac: Adjust n_channels usage for __counted_by
      LoongArch: vDSO: Disable UBSAN instrumentation

Keith Busch (1):
      nvme: move passthrough logging attribute to head

Kent Overstreet (1):
      bcachefs: time_stats: Check for last_event == 0 when updating freq stats

Kim Phillips (1):
      crypto: ccp - Fix null pointer dereference in
__sev_platform_shutdown_locked

Kirill A. Shutemov (1):
      x86/kvm: Fix SEV check in sev_map_percpu_data()

Konrad Dybcio (1):
      pmdomain: core: Move the unused cleanup to a _sync initcall

Konstantin Komarov (23):
      fs/ntfs3: Improve alternative boot processing
      fs/ntfs3: Modified fix directory element type detection
      fs/ntfs3: Improve ntfs_dir_count
      fs/ntfs3: Correct hard links updating when dealing with DOS names
      fs/ntfs3: Print warning while fixing hard links count
      fs/ntfs3: Reduce stack usage
      fs/ntfs3: Fix multithreaded stress test
      fs/ntfs3: Fix detected field-spanning write (size 8) of single
field "le->name"
      fs/ntfs3: Correct use bh_read
      fs/ntfs3: Add file_modified
      fs/ntfs3: Drop suid and sgid bits as a part of fpunch
      fs/ntfs3: Implement super_operations::shutdown
      fs/ntfs3: ntfs3_forced_shutdown use int instead of bool
      fs/ntfs3: Add and fix comments
      fs/ntfs3: Add NULL ptr dereference checking at the end of
attr_allocate_frame()
      fs/ntfs3: Fix c/mtime typo
      fs/ntfs3: Disable ATTR_LIST_ENTRY size check
      fs/ntfs3: Use kvfree to free memory allocated by kvmalloc
      fs/ntfs3: Prevent generic message "attempt to access beyond end of device"
      fs/ntfs3: Use i_size_read and i_size_write
      fs/ntfs3: Correct function is_rst_area_valid
      fs/ntfs3: Fixed overflow check in mi_enum_attr()
      fs/ntfs3: Update inode->i_size after success write into compressed file

Krystian Pradzynski (2):
      accel/ivpu/40xx: Enable D0i3 message
      accel/ivpu/40xx: Stop passing SKU boot parameters to FW

Kuniyuki Iwashima (1):
      af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.

Kuogee Hsieh (2):
      drm/msms/dp: fixed link clock divider bits be over written in
BPC unknown case
      drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case

Leo Yan (1):
      MAINTAINERS: Leo Yan has moved

Li Ma (1):
      drm/amdgpu: remove asymmetrical irq disabling in jpeg 4.0.5 suspend

Li zeming (1):
      kprobes: Remove unnecessary initial values of variables

Lijo Lazar (2):
      drm/amdgpu: Avoid fetching VRAM vendor info
      drm/amdgpu: Fix HDP flush for VFs on nbio v7.9

Linus Torvalds (2):
      work around gcc bugs with 'asm goto' with outputs
      Linux 6.8-rc4

Loic Prylli (1):
      hwmon: (aspeed-pwm-tacho) mutex for tach reading

Maciej S. Szmigiero (1):
      KVM: x86: Give a hint when Win2016 might fail to boot due to
XSAVES erratum

Mario Limonciello (3):
      wifi: mac80211: Drop WBRF debugging statements
      pinctrl: amd: Add IRQF_ONESHOT to the interrupt request
      drm/amd/display: Clear phantom stream count and plane count

Masahiro Yamada (2):
      LoongArch: Select ARCH_ENABLE_THP_MIGRATION instead of redefining it
      LoongArch: Select HAVE_ARCH_SECCOMP to use the common SECCOMP menu

Masami Hiramatsu (Google) (3):
      tracing/probes: Fix to show a parse error for bad type for $comm
      tracing/probes: Fix to set arg size and fmt after setting type from BTF
      ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default

Mathias Krause (1):
      bcachefs: install fd later to avoid race with close

Matthew Auld (1):
      drm/xe/vm: don't ignore error when in_kthread

Matthew Brost (7):
      drm/sched: Re-queue run job worker when
drm_sched_entity_pop_job() returns NULL
      drm/xe: Fix loop in vm_bind_ioctl_ops_unwind
      drm/xe: Take a reference in xe_exec_queue_last_fence_get()
      drm/xe: Pick correct userptr VMA to repin on REMAP op failure
      drm/xe: Map both mem.kernel_bb_pool and usm.bb_pool
      drm/xe: Assume large page size if VMA not yet bound
      drm/xe: Remove TEST_VM_ASYNC_OPS_ERROR

Maurizio Lombardi (1):
      nvme-host: fix the updating of the firmware version

Miaohe Lin (1):
      mm/memory-failure: fix crash in split_huge_page_to_list from
soft_offline_page

Michael Lass (1):
      net: Fix from address in memcpy_to_iter_csum()

Ming Lei (1):
      scsi: core: Move scsi_host_busy() out of host lock if it is for
per-command

Miri Korenblit (1):
      wifi: iwlwifi: exit eSR only after the FW does

Muhammad Usama Anjum (1):
      selftests: core: include linux/close_range.h for CLOSE_RANGE_* macros

Nathan Chancellor (2):
      x86/coco: Define cc_vendor without CONFIG_ARCH_HAS_CC_PLATFORM
      drm/amd/display: Increase frame-larger-than for all display_mode_vba files

NeilBrown (1):
      nfsd: don't take fi_lock in nfsd_break_deleg_cb()

Nekun (1):
      fs/ntfs3: Add ioctl operation for directories (FITRIM)

Nicholas Kazlauskas (1):
      drm/amd/display: Increase eval/entry delay for DCN35

Oleg Nesterov (5):
      getrusage: move thread_group_cputime_adjusted() outside of
lock_task_sighand()
      getrusage: use sig->stats_lock rather than lock_task_sighand()
      fs/proc: do_task_stat: move thread_group_cputime_adjusted()
outside of lock_task_sighand()
      fs/proc: do_task_stat: use sig->stats_lock to gather the
threads/children stats
      exit: wait_task_zombie: kill the no longer necessary
spin_lock_irq(siglock)

Oscar Salvador (1):
      fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super

Pablo Neira Ayuso (7):
      netfilter: nft_compat: narrow down revision to unsigned 8-bits
      netfilter: nft_compat: reject unused compat flag
      netfilter: nft_compat: restrict match/target protocol to u16
      netfilter: nft_set_pipapo: remove static in nft_pipapo_get()
      netfilter: nft_ct: reject direction for ct id
      netfilter: nf_tables: use timestamp to check for set element timeout
      netfilter: nft_set_rbtree: skip end interval element from gc

Paolo Abeni (5):
      selftests: net: cut more slack for gro fwd tests.
      selftests: net: fix setup_ns usage in rtnetlink.sh
      selftests: net: fix tcp listener handling in pmtu.sh
      selftests: net: avoid just another constant wait
      selftests: net: let big_tcp test cope with slow env

Paulo Alcantara (1):
      smb: client: set correct d_type for reparse points under DFS mounts

Petr Tesarik (1):
      net: stmmac: protect updates of 64-bit statistics counters

Prakash Sangappa (1):
      mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE

Prike Liang (2):
      drm/amdgpu: skip to program GFXDEC registers for suspend abort
      drm/amdgpu: reset gpu for s3 suspend abort case

Qiuxu Zhuo (1):
      x86/lib: Revert to _ASM_EXTABLE_UA() for {get,put}_user() fixups

Qu Wenruo (1):
      btrfs: do not ASSERT() if the newly created subvolume already got read

Randy Dunlap (1):
      drm/msm/dpu: fix kernel-doc warnings

Ratheesh Kannoth (1):
      octeontx2-af: Initialize maps.

Rishabh Dave (1):
      ceph: prevent use-after-free in encode_cap_msg()

Rodrigo Siqueira (1):
      drm/amd/display: Disable ODM by default for DCN35

Ryan Roberts (1):
      mm/userfaultfd: UFFDIO_MOVE implementation should use ptep_get()

Ryusuke Konishi (3):
      nilfs2: fix data corruption in dsync block recovery for small block sizes
      nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
      nilfs2: fix potential bug in end_buffer_async_write

SEO HOYOUNG (1):
      scsi: ufs: core: Remove the ufshcd_release() in
ufshcd_err_handling_prepare()

SeongJae Park (1):
      mm/damon/sysfs-schemes: fix wrong DAMOS tried regions update timeout setup

Sergey Senozhatsky (1):
      mm/madvise: don't forget to leave lazy MMU mode in
madvise_cold_or_pageout_pte_range()

Shigeru Yoshida (1):
      tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

Shradha Gupta (1):
      hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Shyam Prasad N (2):
      cifs: change tcon status when need_reconnect is set on it
      cifs: handle cases where multiple sessions share connection

Sinthu Raja (2):
      net: ethernet: ti: cpsw_new: enable mac_managed_pm to fix mdio
      net: ethernet: ti: cpsw: enable mac_managed_pm to fix mdio

Srinivasan Shanmugam (3):
      drm/amd/display: Fix 'panel_cntl' could be null in
'dcn21_set_backlight_level()'
      drm/amd/display: Add NULL test for 'timing generator' in
'dcn21_set_pipe()'
      drm/amd/display: Implement bounds check for stream encoder
creation in DCN301

Stanley.Yang (1):
      drm/amdgpu: Fix shared buff copy to user

Steve French (2):
      smb3: add missing null server pointer check
      smb3: clarify mount warning

Steven Rostedt (Google) (1):
      tracing: Fix wasted memory in saved_cmdlines logic

Suren Baghdasaryan (1):
      arch/arm/mm: fix major fault accounting when retrying under per-VMA lock

Takashi Sakamoto (1):
      firewire: core: send bus reset promptly on gap count error

Tejun Heo (1):
      blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Tengfei Yu (1):
      KVM: x86: Check irqchip mode before create PIT

Timur Tabi (2):
      drm/nouveau: fix several DMA buffer leaks
      drm/nouveau: nvkm_gsp_radix3_sg() should use nvkm_gsp_mem_ctor()

Vincent Chen (1):
      riscv: mm: execute local TLB flush after populating vmemmap

Wachowski, Karol (2):
      accel/ivpu: Force snooping for MMU writes
      accel/ivpu: Correct MMU queue size checking functions

Wenjing Liu (1):
      drm/amd/display: set odm_combine_policy based on context in dcn32 resource

Xiaoming Wang (1):
      drm/xe/display: Fix memleak in display initialization

Xiubo Li (5):
      libceph: fail sparse-read if the data length doesn't match
      libceph: rename read_sparse_msg_*() to read_partial_sparse_msg_*()
      libceph: just wait for more data to be available on the socket
      ceph: always set initial i_blkbits to CEPH_FSCRYPT_BLOCK_SHIFT
      ceph: always check dir caps asynchronously

Yang Li (2):
      efi/libstub: Add one kernel-doc comment
      ksmbd: Add kernel-doc for ksmbd_extract_sharename() function

Yi Sun (1):
      virtio-blk: Ensure no requests in virtqueues before deleting vqs.

Yosry Ahmed (1):
      mm: memcg: optimize parent iteration in memcg_rstat_updated()

Zhang Rui (3):
      hwmon: (coretemp) Fix out-of-bounds memory access
      hwmon: (coretemp) Fix bogus core_id to attr name mapping
      hwmon: (coretemp) Enlarge per package core count limit

Zhenyu Wang (1):
      drm/i915: Replace dead 01.org link

Zhi Wang (1):
      MAINTAINERS: Update Zhi Wang's email address

Zhipeng Lu (2):
      atm: idt77252: fix a memleak in open_card_ubr0
      octeontx2-pf: Fix a memleak otx2_sq_init

