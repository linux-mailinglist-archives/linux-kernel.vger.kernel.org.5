Return-Path: <linux-kernel+bounces-152609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D2E8AC120
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440191C203F6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697DC41C71;
	Sun, 21 Apr 2024 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XDPrGmBB"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD623FB88
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713729253; cv=none; b=T0b5/cMUc0EY9hb8YGUd5CTdaqEzFRaPjiw6ch6KSl6cv/PyIBHENYQMkzZxNpkKNtz5FoApyphkHGTD38YyBdg3jyL1yICFeMktyG4hXkSUJQlmXz975OlAt4+Mrnt86pbXA6YeKWCV87ELWwjy272JLu+BWh7t7C0lfEjIDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713729253; c=relaxed/simple;
	bh=+ECMsSzu6BbZmt9r/o0ZAWrtbvRv96evr6NnmYnO6YQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QvX76qCj8lWd6+LHaEICtRo27nHvbO3gD+7RDdpdQxMH2d7HNv93Znnc9HrVd8xa7/EwOTf2xHzE1kzeg8zXx7wuUsAZQebuWuqB3U3pkv+p2YgrPxZbqnmx+N/DciVBo97PvjC9Kx0vk2ltq7AqRJrqiyf1fPx9JfdAZKcZ9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XDPrGmBB; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518b9527c60so4215112e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 12:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713729248; x=1714334048; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg0g7+efcb5ZMEkIKDREkQLx8DmZo+3aNmXqVtOcNVc=;
        b=XDPrGmBB8vXn+2mYrrR/wykgYiTzlwTMubK7jhVWiLZ+izpbPs1NvvHuD3dXnvHkW5
         eviJ9NtSEXIJkB91mNLJqXmrIs1kzuqaHHd7ieqAGp0YhwNRpa/7BFcP7q7yzif2jUMS
         Q4hkA6oye5g7O7PWS3KDct02lF5WgF8IrtBWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713729248; x=1714334048;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bg0g7+efcb5ZMEkIKDREkQLx8DmZo+3aNmXqVtOcNVc=;
        b=JEbdtFfPfE+HJnuH77z6VpazIObpAgHNGwevIZZhdzFosWH2HRGfNj7k8WsHrZUQsP
         Um0l3xpSw+VmNVi4exQ+/USamfyP4VhvXh2glvqiYR81xvOLOz39ed1yLKmzP5EP44qj
         Tklf2BD6Umg3XMr4d6ZS3JX8HnIANp6zwjo0+5s5DoLwwowKWX2YXALpIJGEgdtOEKuR
         iNH9jOTF+BKyHMe7k9QY0Xg02EzBpxCsfGJqK8MV7jB9UjBGt9N7Crx/EICNgzrTOg2o
         UuT9O5mXSIxfOxlhSJksX01Bd32zw79V2m5+rfeFlyXAVbYRJiRkGsbXR8kM0c/IgIHr
         +CFw==
X-Gm-Message-State: AOJu0YwbyHwaNFsGXHh2a+9khECZrpN30zgdQaZkYwnuBbD+SLpAq6W5
	lwF4gLvuXmsQmZMWTXaseVHy5JuLD0ul1vaVb53TlcvugF/mfyPMVX6Mb9tLHpB5ldehnrARWO9
	xllKzAQ==
X-Google-Smtp-Source: AGHT+IG0iMQ5g5ASidc3EfmOZbGnJ34wjjz9Dbu1U/VlOuAbCctAcR4Wa7ycrBEDMhtN725InDq/cw==
X-Received: by 2002:a05:6512:104a:b0:519:5a60:5fe7 with SMTP id c10-20020a056512104a00b005195a605fe7mr7215281lfb.66.1713729247377;
        Sun, 21 Apr 2024 12:54:07 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id dl14-20020a170907944e00b00a559aae2ea0sm2200740ejc.104.2024.04.21.12.54.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 12:54:06 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a523524e5baso391848466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 12:54:06 -0700 (PDT)
X-Received: by 2002:a17:906:4a8a:b0:a52:8062:a8d0 with SMTP id
 x10-20020a1709064a8a00b00a528062a8d0mr6757132eju.58.1713729245998; Sun, 21
 Apr 2024 12:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Apr 2024 12:53:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfck-6-2YcD3Bzhjo0E0L0g2HGSZksB9pzRCah=Y4HBw@mail.gmail.com>
Message-ID: <CAHk-=wgfck-6-2YcD3Bzhjo0E0L0g2HGSZksB9pzRCah=Y4HBw@mail.gmail.com>
Subject: Linux 6.9-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Another week, another -rc. Things look fairly normal, although the
diffstat for rc5 looks a bit wonky due to another rash of bcachefs
fixes, and a perf tools header sync with the main kernel headers.

But if you ignore those oddities, it all looks pretty normal and
things appear fairly calm. Which is just as well, since the first part
of the week I was on a quick trip to Seattle, and the second part of
the week I've been doing a passable imitation of the Fontana di Trevi,
except my medium is mucus. Sooo much mucus.

Anyway, moving on..

Apart from the already mentioned bcachefs and header updates, it's
mostly various drivers (gpu, networking, usb, tty, sound..) some
architecture updates (mainly x86 kvm), some small MM patches, some
core networking, a couple of small filesystem updates (fuse, 9p, nfsd)
and just random singleton patches elsewhere.

Shortlog appended for anybody who wants to get a feel for the details,

              Linus

---

Ai Chao (1):
      ALSA: hda/realtek - Enable audio jacks of Haier Boyue G42 with ALC269=
VC

Alan Stern (1):
      fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Alex Deucher (3):
      Revert "drm/amd/display: fix USB-C flag update after enc10 feature in=
it"
      drm/radeon: make -fstrict-flex-arrays=3D3 happy
      drm/radeon: silence UBSAN warning (v3)

Alexander Usyskin (1):
      mei: me: disable RPL-S on SPS and IGN firmwares

Amir Goldstein (2):
      fuse: fix wrong ff->iomode state changes from parallel dio write
      fuse: fix parallel dio write on file open in passthrough mode

Andrew Jones (1):
      KVM: selftests: fix supported_flags for riscv

Andy Shevchenko (5):
      gpio: wcove: Use -ENOTSUPP consistently
      gpio: crystalcove: Use -ENOTSUPP consistently
      serial: 8250_pci: Remove redundant PCI IDs
      serial: core: Clearing the circular buffer before NULLifying it
      gpiolib: swnode: Remove wrong header inclusion

AngeloGioacchino Del Regno (2):
      usb: typec: mux: it5205: Fix ChipID value typo
      dt-bindings: pwm: mediatek,pwm-disp: Document power-domains property

Anshuman Khandual (1):
      arm64/hugetlb: Fix page table walk in huge_pte_alloc()

Ard Biesheuvel (2):
      arm64/head: Drop unnecessary pre-disable-MMU workaround
      arm64/head: Disable MMU at EL2 before clearing HCR_EL2.E2H

Ar=C4=B1n=C3=A7 =C3=9CNAL (2):
      net: dsa: mt7530: fix mirroring frames received on local port
      net: dsa: mt7530: fix port mirroring for MT7988 SoC switch

Asbj=C3=B8rn Sloth T=C3=B8nnesen (2):
      net: sparx5: flower: fix fragment flags handling
      octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation

Bart Van Assche (1):
      scsi: core: Fix handling of SCMD_FAIL_IF_RECOVERING

Borislav Petkov (AMD) (1):
      x86/retpolines: Enable the default thunk warning only on relevant con=
figs

Carlos Llamas (1):
      binder: check offset alignment in binder_get_object()

Carolina Jubran (2):
      net/mlx5e: Acquire RTNL lock before RQs/SQs activation/deactivation
      net/mlx5e: Prevent deadlock while disabling aRFS

Chao Yu (1):
      bcachefs: fix error path of __bch2_read_super()

Christian A. Ehrhardt (1):
      usb: typec: ucsi: Fix connector check on init

Christian K=C3=B6nig (3):
      drm/ttm: stop pooling cached NUMA pages v2
      drm/amdgpu: remove invalid resource->start check v2
      drm/amdgpu: fix visible VRAM handling during faults

Christoph Hellwig (1):
      block: propagate partition scanning errors to the BLKRRPART ioctl

Christophe JAILLET (1):
      KVM: SVM: Remove a useless zeroing of allocated memory

Chuanhong Guo (1):
      USB: serial: option: add support for Fibocom FM650/FG650

Coia Prant (1):
      USB: serial: option: add Lonsung U8300/U9300 product

Dan Carpenter (1):
      serial: 8250_lpc18xx: disable clks on error in probe()

Daniel Golle (1):
      clk: mediatek: mt7988-infracfg: fix clocks for 2nd PCIe port

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 rmnet compositions

Danny Lin (1):
      fuse: fix leaked ENOSYS error on first statx call

Dave Airlie (1):
      nouveau: fix instmem race condition around ptr stores

David Hildenbrand (1):
      mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY pro=
perly

David Matlack (4):
      KVM: x86/mmu: Write-protect L2 SPTEs in TDP MMU when clearing dirty s=
tatus
      KVM: x86/mmu: Remove function comments above
clear_dirty_{gfn_range,pt_masked}()
      KVM: x86/mmu: Fix and clarify comments about clearing D-bit vs.
write-protecting
      KVM: selftests: Add coverage of EPT-disabled to vmx_dirty_log_test

Dmitry Baryshkov (2):
      drm/panel: visionox-rm69299: don't unregister DSI device
      drm/panel: novatek-nt36682e: don't unregister DSI device

Dmitry Safonov (4):
      selftests/tcp_ao: Make RST tests less flaky
      selftests/tcp_ao: Zero-init tcp_ao_info_opt
      selftests/tcp_ao: Fix fscanf() call for format-security
      selftests/tcp_ao: Printing fixes to confirm with format-security

Emil Kronborg (1):
      serial: mxs-auart: add spinlock around changing cts state

Eric Biggers (1):
      x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Eric Dumazet (1):
      net/sched: Fix mirred deadlock on device recursion

Eric Van Hensbergen (2):
      fs/9p: remove erroneous nlink init from legacy stat2inode
      fs/9p: Revert "fs/9p: fix dups even in uncached mode"

Fabio Estevam (1):
      usb: misc: onboard_usb_hub: Disable the USB hub clock on failure

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: fix WED + wifi reset

Felix Kuehling (1):
      drm/amdkfd: Fix memory leak in create_process failure

Finn Thain (1):
      serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Florian Westphal (1):
      netfilter: nft_set_pipapo: do not free live element

Gerd Bayer (1):
      s390/ism: Properly fix receive message buffer allocation

Gil Fine (2):
      thunderbolt: Fix wake configurations after device unplug
      thunderbolt: Avoid notify PM core about runtime PM resume

Greg Kroah-Hartman (1):
      Revert "usb: cdc-wdm: close race between read and workqueue"

Hans de Goede (1):
      serial: 8250_dw: Revert: Do not reclock if already at correct rate

Hou Wenlong (1):
      x86/fred: Fix incorrect error code printout in fred_bad_type()

Huayu Zhang (1):
      ALSA: hda/realtek: Fix volumn control of ThinkBook 16P Gen4

Jakub Kicinski (2):
      inet: bring NLM_DONE out to a separate recv() again
      selftests: kselftest_harness: fix Clang warning about zero-length for=
mat

James Bottomley (1):
      MAINTAINERS: update to working email address

Jason A. Donenfeld (2):
      random: handle creditable entropy from atomic process context
      Revert "vmgenid: emit uevent when VMGENID updates"

Jason Gunthorpe (1):
      iommufd: Add missing IOMMUFD_DRIVER kconfig for the selftest

Jeff Layton (1):
      9p: explicitly deny setlease attempts

Jeongjun Park (1):
      nilfs2: fix OOB in nilfs_set_de_type

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K sub-models

Joakim Sindholt (4):
      fs/9p: only translate RWX permissions for plain 9P2000
      fs/9p: translate O_TRUNC into OTRUNC
      fs/9p: fix the cache always being enabled on files with qid flags
      fs/9p: drop inodes immediately on non-.L too

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid writing the mac address before first re=
ading

Josh Poimboeuf (1):
      x86/bugs: Fix BHI retpoline check

Kai-Heng Feng (1):
      usb: Disable USB3 LPM at shutdown

Kees Cook (1):
      ubsan: Add awareness of signed integer overflow traps

Kent Overstreet (23):
      bcachefs: Don't use bch2_btree_node_lock_write_nofail() in btree
split path
      bcachefs: Fix UAFs of btree_insert_entry array
      bcachefs: Check for packed bkeys that are too big
      bcachefs: btree node scan: handle encrypted nodes
      bcachefs: fix unsafety in bch2_extent_ptr_to_text()
      bcachefs: fix unsafety in bch2_stripe_to_text()
      bcachefs: fix race in bch2_btree_node_evict()
      bcachefs: don't queue btree nodes for rewrites during scan
      bcachefs: Standardize helpers for printing enum strs with bounds chec=
ks
      bcachefs: Go rw if running any explicit recovery passes
      bcachefs: Fix deadlock in journal replay
      bcachefs: Fix missing write refs in fs fio paths
      bcachefs: Run merges at BCH_WATERMARK_btree
      bcachefs: Disable merges from interior update path
      bcachefs: Fix btree node merging on write buffer btrees
      bcachefs: add missing bounds check in __bch2_bkey_val_invalid()
      bcachefs: Interior known are required to have known key types
      bcachefs: add safety checks in bch2_btree_node_fill()
      bcachefs: Fix bch2_btree_node_fill() for !path
      bcachefs: sysfs internal/trigger_journal_flush
      bcachefs: bch_member.btree_allocated_bitmap
      bcachefs: Check for backpointer bucket_offset >=3D bucket size
      bcachefs: set_btree_iter_dontneed also clears should_be_locked

Konrad Dybcio (1):
      interconnect: qcom: x1e80100: Remove inexistent ACV_PERF BCM

Krzysztof Kozlowski (2):
      usb: phy: MAINTAINERS: mark Freescale USB PHY as orphaned
      gpio: lpc32xx: fix module autoloading

Kuniyuki Iwashima (2):
      af_unix: Call manage_oob() for every skb in unix_stream_read_generic(=
).
      af_unix: Don't peek OOB data without MSG_OOB.

Kyle Tso (1):
      usb: typec: tcpm: Correct the PDO counting in pd_set

Lei Chen (1):
      tun: limit printing rate when illegal packet received by tun dev

Li Nan (1):
      blk-iocost: do not WARN if iocg was already offlined

Linus Torvalds (1):
      Linux 6.9-rc5

Lokesh Gidra (1):
      userfaultfd: change src_folio after ensuring it's unpinned in UFFDIO_=
MOVE

Lyude Paul (2):
      drm/nouveau/kms/nv50-: Disable AUX bus for disconnected DP ports
      drm/nouveau/dp: Don't probe eDP ports twice harder

Maarten Lankhorst (1):
      drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init

Manivannan Sadhasivam (1):
      scsi: ufs: qcom: Add missing interconnect bandwidth values for Gear 5

Marcin Szycik (1):
      ice: Fix checking for unsupported keys on non-tunnel device

Mario Limonciello (4):
      platform/x86/amd: pmf: Decrease error message to debug
      platform/x86/amd: pmf: Add infrastructure for quirking supported func=
s
      platform/x86/amd: pmf: Add quirk for ROG Zephyrus G14
      platform/x86/amd/pmc: Extend Framework 13 quirk to more BIOSes

Mark Zhang (1):
      RDMA/cm: Print the old state when cm_destroy_id gets timeout

Masami Hiramatsu (Google) (1):
      bootconfig: Fix the kerneldoc of _xbc_exit()

Mathias Nyman (1):
      xhci: Fix root hub port null pointer dereference in xhci tracepoints

Mathieu Desnoyers (1):
      sched: Add missing memory barrier in switch_mm_cid

Matthew Auld (1):
      drm/xe/vm: prevent UAF with asid based lookup

Mauro Carvalho Chehab (1):
      ALSA: hda/realtek: Add quirks for Huawei Matebook D14 NBLB-WAX9N

Maxim Levitsky (1):
      KVM: selftests: fix max_guest_memory_test with more that 256 vCPUs

Ma=C3=ADra Canal (1):
      drm/v3d: Don't increment `enabled_ns` twice

Miaohe Lin (2):
      mm/memory-failure: fix deadlock when hugetlb_optimize_vmemmap is enab=
led
      fork: defer linking file vma until vma is fully initialized

Michael Ellerman (2):
      powerpc/crypto/chacha-p10: Fix failure on non Power10
      Documentation: embargoed-hardware-issues.rst: Add myself for Power

Michael Guralnik (1):
      RDMA/mlx5: Fix port number for counter query in multi-port configurat=
ion

Michal Swiatkowski (2):
      ice: tc: check src_vsi in case of traffic from VF
      ice: tc: allow zero flags in parsing tc flower

Mika Westerberg (1):
      thunderbolt: Do not create DisplayPort tunnels on adapters of
the same router

Mike Tipton (1):
      interconnect: Don't access req_list while it's being manipulated

Mikhail Kobuk (1):
      drm: nv04: Fix out of bounds access

Minas Harutyunyan (1):
      usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Muhammad Usama Anjum (1):
      iommufd: Add config needed for iommufd_fail_nth

Namhyung Kim (11):
      perf annotate: Make sure to call symbol__annotate2() in TUI
      perf lock contention: Add a missing NULL check
      tools/include: Sync uapi/drm/i915_drm.h with the kernel sources
      tools/include: Sync uapi/linux/fs.h with the kernel sources
      tools/include: Sync uapi/linux/kvm.h and asm/kvm.h with the kernel so=
urces
      tools/include: Sync uapi/sound/asound.h with the kernel sources
      tools/include: Sync x86 CPU feature headers with the kernel sources
      tools/include: Sync x86 asm/irq_vectors.h with the kernel sources
      tools/include: Sync x86 asm/msr-index.h with the kernel sources
      tools/include: Sync asm-generic/bitops/fls.h with the kernel sources
      tools/include: Sync arm64 asm/cputype.h with the kernel sources

Naohiro Aota (2):
      btrfs: zoned: do not flag ZEROOUT on non-dirty extent buffer
      btrfs: zoned: add ASSERT and WARN for EXTENT_BUFFER_ZONED_ZEROOUT han=
dling

Naoya Horiguchi (1):
      MAINTAINERS: update Naoya Horiguchi's email address

Nathan Chancellor (2):
      configs/hardening: Fix disabling UBSAN configurations
      configs/hardening: Disable CONFIG_UBSAN_SIGNED_WRAP

Nathan Lynch (1):
      selftests/powerpc/papr-vpd: Fix missing variable initialization

Nikita Zhandarovich (1):
      comedi: vmk80xx: fix incomplete endpoint checking

Norihiko Hama (1):
      usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep
transport error

Oliver Neukum (1):
      usb: xhci: correct return value in case of STS_HCE

Oscar Salvador (6):
      mm,page_owner: update metadata for tail pages
      mm,page_owner: fix refcount imbalance
      mm,page_owner: fix accounting of pages when migrating
      mm,page_owner: fix printing of stack records
      mm,swapops: update check in is_pfn_swap_entry for hwpoison entries
      mm,page_owner: defer enablement of static branch

Pablo Neira Ayuso (7):
      netfilter: br_netfilter: skip conntrack input hook for promisc packet=
s
      netfilter: nft_set_pipapo: walk over current view on netlink dump
      netfilter: flowtable: validate pppoe header
      netfilter: flowtable: incorrect pppoe tuple
      netfilter: nf_tables: missing iterator type in lookup walk
      netfilter: nf_tables: restore set elements when delete set fails
      netfilter: nf_tables: fix memleak in map from abort path

Paul Barker (4):
      net: ravb: Count packets instead of descriptors in R-Car RX path
      net: ravb: Allow RX loop to move past DMA mapping errors
      net: ravb: Fix GbEth jumbo packet RX checksum handling
      net: ravb: Fix RX byte accounting for jumbo packets

Paul Cercueil (2):
      usb: gadget: functionfs: Fix inverted DMA fence direction
      usb: gadget: functionfs: Wait for fences before enqueueing DMABUF

Peter Oberparleiter (3):
      s390/qdio: handle deferred cc1
      s390/cio: fix race condition during online processing
      s390/cio: log fake IRB events

Peter Xu (1):
      mm/userfaultfd: allow hugetlb change protection upon poison entry

Phillip Lougher (1):
      Squashfs: check the inode number is not the invalid value of zero

Pin-yen Lin (1):
      clk: mediatek: Do a runtime PM get on controllers during probe

Qiang Zhang (1):
      bootconfig: use memblock_free_late to free xbc memory to buddy

Qu Wenruo (1):
      btrfs: do not wait for short bulk allocation

Raag Jadav (1):
      pwm: dwc: allow suspend/resume for 16 channels

Rafael J. Wysocki (1):
      thermal/debugfs: Add missing count increment to thermal_debug_tz_trip=
_up()

Rahul Rameshbabu (1):
      net/mlx5e: Use channel mdev reference instead of global mdev
instance for coalescing

Randy Dunlap (1):
      peci: linux/peci.h: fix Excess kernel-doc description warning

Richard Genoud (1):
      MAINTAINERS: mailmap: update Richard Genoud's email address

Rick Edgecombe (1):
      KVM: x86/mmu: x86: Don't overflow lpage_info when checking attributes

Ricky Wu (1):
      misc: rtsx: Fix rts5264 driver status incorrect when card removed

Sakari Ailus (2):
      Revert "mei: vsc: Call wake_up() in the threaded IRQ handler"
      mei: vsc: Unregister interrupt handler for system suspend

Samuel Thibault (1):
      speakup: Avoid crash on very long word

Sandipan Das (1):
      KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms

Sean Christopherson (20):
      KVM: Add helpers to consolidate gfn_to_pfn_cache's page split check
      KVM: Check validity of offset+length of gfn_to_pfn_cache prior
to activation
      KVM: Explicitly disallow activatating a gfn_to_pfn_cache with INVALID=
_GPA
      KVM: x86/pmu: Disable support for adaptive PEBS
      KVM: x86/pmu: Set enable bits for GP counters in
PERF_GLOBAL_CTRL at "RESET"
      KVM: selftests: Verify post-RESET value of PERF_GLOBAL_CTRL in PMCs t=
est
      KVM: SVM: Create a stack frame in __svm_vcpu_run() for unwinding
      KVM: SVM: Wrap __svm_sev_es_vcpu_run() with #ifdef CONFIG_KVM_AMD_SEV
      KVM: SVM: Drop 32-bit "support" from __svm_sev_es_vcpu_run()
      KVM: SVM: Clobber RAX instead of RBX when discarding spec_ctrl_interc=
epted
      KVM: SVM: Save/restore non-volatile GPRs in SEV-ES VMRUN via
host save area
      KVM: SVM: Save/restore args across SEV-ES VMRUN via host save area
      KVM: SVM: Create a stack frame in __svm_sev_es_vcpu_run()
      KVM: x86: Stop compiling vmenter.S with OBJECT_FILES_NON_STANDARD
      KVM: x86: Snapshot if a vCPU's vendor model is AMD vs. Intel compatib=
le
      KVM: VMX: Snapshot LBR capabilities during module initialization
      perf/x86/intel: Expose existence of callback support to KVM
      KVM: VMX: Disable LBR virtualization if the CPU doesn't support
LBR callstacks
      KVM: x86/mmu: Precisely invalidate MMU root_role during CPUID update
      KVM: Drop unused @may_block param from gfn_to_pfn_cache_invalidate_st=
art()

Serge Semin (3):
      net: stmmac: Apply half-duplex-less constraint for DW QoS Eth only
      net: stmmac: Fix max-speed being ignored on queue re-init
      net: stmmac: Fix IP-cores specific MAC capabilities

Shay Drory (2):
      net/mlx5: Lag, restore buckets number to default after hash LAG
deactivation
      net/mlx5: Restore mistakenly dropped parts in register devlink flow

Shenghao Ding (2):
      ALSA: hda/tas2781: correct the register for pow calibrated data
      ALSA: hda/tas2781: Add new vendor_id and subsystem_id to support
ThinkPad ICE-1

Shengyu Li (1):
      selftests/harness: Prevent infinite loop due to Assert in FIXTURE_TEA=
RDOWN

Shivaprasad G Bhat (1):
      powerpc/iommu: Refactor spapr_tce_platform_iommu_attach_dev()

Siddharth Vadapalli (1):
      net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using =
them

Srinivas Pandruvada (2):
      platform/x86: ISST: Add Granite Rapids-D to HPM CPU list
      platform/x86/intel-uncore-freq: Increase minor number support

Stephen Boyd (5):
      clk: Remove prepare_lock hold assertion in __clk_release()
      clk: Don't hold prepare_lock when calling kref_put()
      clk: Initialize struct clk_core kref earlier
      clk: Get runtime PM before walking tree during disable_unused
      clk: Get runtime PM before walking tree for clk_summary

Steven Rostedt (Google) (1):
      SUNRPC: Fix rpcgss_context trace event acceptor field

Sumanth Korikkar (1):
      mm/shmem: inline shmem_is_huge() for disabled transparent hugepages

Sven Schnelle (1):
      s390/mm: Fix NULL pointer dereference

Takashi Iwai (1):
      ALSA: seq: ump: Fix conversion from MIDI2 to MIDI1 UMP messages

Tao Su (1):
      KVM: VMX: Ignore MKTME KeyID bits when intercepting #PF for
allow_smaller_maxphyaddr

Tariq Toukan (1):
      net/mlx5: SD, Handle possible devcom ERR_PTR

Thinh Nguyen (1):
      usb: dwc3: ep0: Don't reset resource alloc flag

Tony Lindgren (2):
      serial: core: Fix regression when runtime PM is not enabled
      serial: core: Fix missing shutdown and startup for serial base port

Uwe Kleine-K=C3=B6nig (5):
      clk: Provide !COMMON_CLK dummy for devm_clk_rate_exclusive_get()
      usb: gadget: fsl: Initialize udc before using it
      MAINTAINERS: Drop Li Yang as their email address stopped working
      serial: stm32: Return IRQ_NONE in the ISR if no handling happend
      serial: stm32: Reset .throttled state in .startup()

Vanillan Wang (2):
      net:usb:qmi_wwan: support Rolling modules
      USB: serial: option: add Rolling RW101-GL and RW135-GL support

Vasily Gorbik (1):
      NFSD: fix endianness issue in nfsd4_encode_fattr4

Vitalii Torshyn (1):
      ALSA: hda/realtek: Fixes for Asus GU605M and GA403U sound

Vitaly Rodionov (1):
      ALSA: hda/realtek: Add quirk for HP SnowWhite laptops

Xin Li (Intel) (1):
      x86/fred: Fix INT80 emulation for FRED

Yang Li (1):
      cuse: add kernel-doc comments to cuse_process_init_reply()

Yanjun.Zhu (1):
      RDMA/rxe: Fix the problem "mutex_destroy missing"

Yaxiong Tian (1):
      arm64: hibernate: Fix level3 translation fault in swsusp_save()

Yuanhe Shu (1):
      selftests/ftrace: Limit length in subsystem-enable tests

Yuntao Wang (1):
      init/main.c: Fix potential static_command_line memory overflow

Yuri Benditovich (1):
      net: change maximum number of UDP segments to 128

Zack Rusin (3):
      drm/vmwgfx: Fix prime import/export
      drm/vmwgfx: Fix crtc's atomic check conditional
      drm/vmwgfx: Sort primary plane formats by order of preference

Ziyang Xuan (2):
      netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get(=
)
      netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()

bolan wang (1):
      USB: serial: option: add Fibocom FM135-GL variants

xinhui pan (1):
      drm/amdgpu: validate the parameters of bo mapping operations more cle=
arly

