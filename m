Return-Path: <linux-kernel+bounces-89908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F3786F727
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34C5281778
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBBF7A158;
	Sun,  3 Mar 2024 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JUa1gq2H"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC1262BD
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709500580; cv=none; b=Fc9+RDgzUb7cfA+5wXi5W8lRyUsqFYkk/7D5wICUyPZ0S+ii6IyWA6xOVA8/5ZyzkIbJ4OYXHqWFb97nivCAl/BAneTNlRfBkAugM+SPhtTrNOb0zxKWh1WpGwH53Sh7f6S3Dj4tzVTdwdjDoa+NYt76f3efN/pf/Z+EtSU+Z6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709500580; c=relaxed/simple;
	bh=GR/vrfHAk/Dyrk4prTrLMA3MJD01g4fqdNK+DxwEb7Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KWh4sAy1Xf1x/z51NuNufaATkMzQPf+YEgO3b8wI6Eydjaz8k7ZGzWRTUt7qnOR5NCDEdYDghcyXPJhED9VduzOapQc3jKi1q8vyNsYJ2D8gWj66gsFulVFwQLA4e0b9CKtU3kd5ynZNiQ0tROjTT0qsheM+4qU1Ddfra4adD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JUa1gq2H; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5131c48055cso3696181e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 13:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709500575; x=1710105375; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mc04wugKS99XOuZ4Ibpth7EwG8e51vNP1anVAXjz+w8=;
        b=JUa1gq2H220kmnQ8bTv7Tbgqggr3NcfYrqvrpKet6DbzPGhApD/YnxxJkGZEpjzB49
         X8AxDYJNPA7DC7s5OX5Lo/ujqsSUjNGi4D354D3N9BK4nJTfT88qylLUkPp9wSHvugN2
         YADBHuVSqMhtLsQ+9hx7oG6Z7Ppmk51GRIBFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709500575; x=1710105375;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mc04wugKS99XOuZ4Ibpth7EwG8e51vNP1anVAXjz+w8=;
        b=tDT7YijmejYG+C4Q9CUDajpDxqaQni0sWpblo0CsEpOl19ALwsDm7osyIx4KGyU5tu
         LkXG1H8xeEueWp56ZD9xf+H9nWnAGWRtVzKEuLMSA39ZLvR4enBkeZxVQ7s57aHtChiy
         xXlVTnyTgYNtgLImizN+GjTGxRJ/xyKDJFrrPAIOvK+6RmReQZPBCXZi4caudBXhE/Ty
         YRmgNELM+4WnQtvxYSxjDOQ4Y9GldlZXMQOXtKE2rTRJLYrEVeNWCU97LqZycdl3BawQ
         u3nUXkBdfP0I8xnBuNPqTZ1xpJ5G7zgR/AImqKbd641mrOh0Wq0Kweph40co9JhEWC/l
         5/Cg==
X-Gm-Message-State: AOJu0YzvMgb9tLa2wOMG+UEFu4wJluOhn3Zk4VwUVPtTgFHa1mKk0RvD
	56MJL5SG4wwzPh311QkTECwHnHuGxTYegGTfksQltDj08R5quabqaruSddZf9tSSbZYZ15KCaS4
	Wi3X2Xw==
X-Google-Smtp-Source: AGHT+IEE0esxG5pmjExabRCcTb4FBzjZd6DZt/ssVdidwXa9gJwZoKjs67QZmYJzSaD14NYy1iPVwA==
X-Received: by 2002:ac2:4306:0:b0:512:c8f0:1954 with SMTP id l6-20020ac24306000000b00512c8f01954mr4375719lfh.0.1709500575026;
        Sun, 03 Mar 2024 13:16:15 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r11-20020ac24d0b000000b00513143a72bfsm1436720lfi.239.2024.03.03.13.16.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 13:16:14 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d29111272eso59902191fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 13:16:14 -0800 (PST)
X-Received: by 2002:a05:6512:234d:b0:512:f741:5263 with SMTP id
 p13-20020a056512234d00b00512f7415263mr6161712lfu.44.1709500573672; Sun, 03
 Mar 2024 13:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Mar 2024 13:15:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwt9b3yMxAQRCVJ0Jh6-4Dz1Fgo2au7g_U9VWVxXoS6Q@mail.gmail.com>
Message-ID: <CAHk-=wgwt9b3yMxAQRCVJ0Jh6-4Dz1Fgo2au7g_U9VWVxXoS6Q@mail.gmail.com>
Subject: Linux 6.8-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So we finally have a week where things have calmed down, and in fact
6.8-rc7 is smaller than usual at this point in time. So if that keeps
up (but that's a fairly notable "if") I won't feel like I need to do
an rc8 this release after all.

So no guarantees, but assuming no bad surprises, we'll have the final
6.8 next weekend.

You can see the rc7 fixes in the shortlog below, and I don't think
there's anything particularly notable in there. It's not only fairly
small for an rc7, all the stats look fairly normal: just over half of
the diff is driver fixes, with the rest being a fairly random mix of
arch updates (powerpc and RISC-C dominate - although "dominate" may
not the right word when it's all pretty small) some filesystem fixes
(btrfs stands out), some core networking and mm fixes, and some more
networking selftest updates.

It really is all pretty small. Let's hope it stays that way,

                  Linus

---

Abel Vesa (1):
      phy: qualcomm: eusb2-repeater: Rework init to drop redundant zero-out=
 loop

Alex Deucher (1):
      Revert "drm/amd/pm: resolve reboot exception for si oland"

Alexander Ofitserov (1):
      gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Alexander Stein (1):
      phy: freescale: phy-fsl-imx8-mipi-dphy: Fix alias name to use dashes

Alexandre Ghiti (3):
      riscv: Fix build error if !CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
      Revert "riscv: mm: support Svnapot in huge vmap"
      riscv: Fix pte_leaf_size() for NAPOT

Amritha Nambiar (1):
      ice: Fix ASSERT_RTNL() warning during certain scenarios

Andre Werner (1):
      net: smsc95xx: add support for SYS TEC USB-SPEmodule1

Andy Shevchenko (1):
      gpiolib: Fix the error path order in gpiochip_add_data_with_key()

Aneesh Kumar K.V (IBM) (1):
      mm/debug_vm_pgtable: fix BUG_ON with pud advanced test

Ard Biesheuvel (3):
      crypto: arm64/neonbs - fix out-of-bounds access on short input
      efivarfs: Drop redundant cleanup on fill_super() failure
      efivarfs: Drop 'duplicates' bool parameter on efivar_init()

Arkadiusz Kubalewski (4):
      ice: fix dpll input pin phase_adjust value updates
      ice: fix dpll and dpll_pin data access on PF reset
      ice: fix dpll periodic work data updates on PF reset
      ice: fix pin phase adjust updates on PF reset

Arnd Bergmann (3):
      efi/capsule-loader: fix incorrect allocation size
      scsi: mpi3mr: Reduce stack usage in mpi3mr_refresh_sas_ports()
      drm/xe/mmio: fix build warning for BAR resize on 32-bit

Arturas Moskvinas (1):
      gpio: 74x164: Enable output pins after registers are reset

Bart Van Assche (1):
      fs/aio: Make io_cancel() generate completions again

Bartosz Golaszewski (1):
      gpio: fix resource unwinding order in error path

Benjamin Berg (1):
      wifi: iwlwifi: mvm: ensure offloading TID queue exists

Bjorn Andersson (1):
      pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation

Byungchul Park (1):
      mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index

Christian K=C3=B6nig (1):
      drm/ttm/tests: depend on UML || COMPILE_TEST

Christophe Kerello (1):
      mmc: mmci: stm32: fix DMA API overlapping mappings warning

Christophe Leroy (1):
      kunit: Fix again checksum tests on big endian CPUs

Colin Ian King (1):
      ASoC: qcom: Fix uninitialized pointer dmactl

Conor Dooley (1):
      RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs

Cristian Marussi (1):
      pmdomain: arm: Fix NULL dereference on scmi_perf_domain removal

Curtis Klein (1):
      dmaengine: fsl-qdma: init irq after reg initialization

Dave Airlie (1):
      nouveau: report byte usage in VRAM usage.

David Howells (1):
      afs: Fix endless loop in directory parsing

David Sterba (1):
      btrfs: dev-replace: properly validate device names

Davide Caratti (1):
      mptcp: fix double-free on socket dismantle

Dimitris Vlachos (1):
      riscv: Sparse-Memory/vmemmap out-of-bounds fix

Dmitry Baryshkov (2):
      phy: qcom-qmp-usb: fix v3 offsets data
      Revert "drm/msm/dp: use drm_bridge_hpd_notify() to report HPD
status changes"

Doug Smythies (1):
      cpufreq: intel_pstate: fix pstate limits enforcement for
adjust_perf call back

Elad Nachman (3):
      mtd: rawnand: marvell: fix layouts
      mmc: sdhci-xenon: fix PHY init clock stability
      mmc: sdhci-xenon: add timeout for PHY init complete

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix the TXF mapping for BZ devices

Eniac Zhang (1):
      ALSA: hda/realtek: fix mute/micmute LED For HP mt440

Eric Dumazet (3):
      ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()
      dpll: rely on rcu for netdev_dpll_pin()
      dpll: fix build failure due to rcu_dereference_check() on unknown typ=
e

Fei Wu (1):
      perf: RISCV: Fix panic on pmu overflow handler

Felix Fietkau (1):
      wifi: mac80211: only call drv_sta_rc_update for uploaded stations

Fenghua Yu (2):
      dmaengine: idxd: Remove shadow Event Log head stored in idxd
      dmaengine: idxd: Ensure safe user copy of completion record

Filipe Manana (6):
      btrfs: send: don't issue unnecessary zero writes for trailing hole
      btrfs: fix data races when accessing the reserved amount of block res=
erves
      btrfs: fix data race at btrfs_use_block_rsv() when accessing block re=
serve
      btrfs: fix race between ordered extent completion and fiemap
      btrfs: ensure fiemap doesn't race with writes when
FIEMAP_FLAG_SYNC is given
      btrfs: fix double free of anonymous device after snapshot creation fa=
ilure

Florian Westphal (4):
      netlink: add nla be16/32 types to minlen array
      net: ip_tunnel: prevent perpetual headroom growth
      netfilter: bridge: confirm multicast packets before passing them
up the stack
      selftests: netfilter: add bridge conntrack + multicast test case

Francois Dugast (1):
      drm/xe/uapi: Remove unused flags

Frank Li (2):
      dmaengine: fsl-edma: correct max_segment_size setting
      dmaengine: fsl-qdma: add __iomem and struct in union to fix sparse wa=
rning

Fr=C3=A9d=C3=A9ric Danis (1):
      Bluetooth: mgmt: Fix limited discoverable off timeout

Gaurav Batra (1):
      powerpc/pseries/iommu: IOMMU table is not initialized for kdump
over SR-IOV

Geliang Tang (3):
      mptcp: map v4 address to v6 when destroying subflow
      selftests: mptcp: rm subflow with v4/v4mapped addr
      selftests: mptcp: join: add ss mptcp support check

Geoff Levand (1):
      ps3/gelic: Fix SKB allocation

Gergo Koteles (1):
      ALSA: hda/realtek: tas2781: enable subwoofer volume control

Haiyue Wang (1):
      Documentations: correct net_cachelines title for struct inet_sock

Han Xu (1):
      mtd: spinand: gigadevice: Fix the get ecc status issue

Hans Peter (1):
      ALSA: hda/realtek: Enable Mute LED on HP 840 G8 (MB 8AB8)

Hans de Goede (1):
      power: supply: bq27xxx-i2c: Do not free non existing IRQ

Herbert Xu (1):
      crypto: lskcipher - Copy IV in lskcipher glue code always

Ignat Korchagin (1):
      netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_valida=
te()

Ivan Semenov (1):
      mmc: core: Fix eMMC initialization with 1-bit bus connection

Jakub Kicinski (4):
      net: veth: clear GRO when clearing XDP even when down
      selftests: net: veth: test syncing GRO and XDP state while device is =
down
      veth: try harder when allocating queue memory
      tools: ynl: fix handling of multiple mcast groups

Jakub Raczynski (1):
      stmmac: Clear variable when destroying workqueue

Janaki Ramaiah Thota (1):
      Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT

Jaroslav Kysela (1):
      ALSA: pcm: clarify and fix default msbits value for all formats

Jason Gunthorpe (1):
      iommufd/selftest: Don't check map/unmap pairing with HUGE_PAGES

Javier Carrasco (1):
      net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Jay Ajit Mate (1):
      ALSA: hda/realtek: Fix top speaker connection on Dell Inspiron
16 Plus 7630

Jeff Johnson (2):
      MAINTAINERS: wifi: update Jeff Johnson e-mail address
      MAINTAINERS: wifi: Add N: ath1*k entries to match .yaml files

Jeremy Kerr (1):
      net: mctp: take ownership of skb in mctp_local_output

Jiawei Wang (2):
      ASoC: amd: yc: add new YC platform variant (0x63) support
      ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2

Jiri Bohac (1):
      x86/e820: Don't reserve SETUP_RNG_SEED in e820

Jiri Slaby (SUSE) (1):
      fbcon: always restore the old font data in fbcon_do_set_font()

Jisheng Zhang (1):
      riscv: tlb: fix __p*d_free_tlb()

Johan Hovold (4):
      drm/bridge: aux-hpd: fix OF node leaks
      drm/bridge: aux-hpd: separate allocation and registration
      soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
      Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid

Johannes Berg (1):
      wifi: nl80211: reject iftype change with mesh ID change

Johannes Thumshirn (1):
      btrfs: zoned: don't skip block group profile checks on conventional z=
ones

Johnny Hsieh (1):
      ASoC: amd: yc: Add Lenovo ThinkBook 21J0 into DMI quirk table

Jonas Dre=C3=9Fler (1):
      Bluetooth: hci_sync: Check the correct flag before starting a scan

Jos=C3=A9 Roberto de Souza (1):
      drm/xe/uapi: Remove DRM_XE_VM_BIND_FLAG_ASYNC comment left over

Joy Zou (1):
      dmaengine: fsl-edma: correct calculation of 'nbytes' in
multi-fifo scenario

Justin Iurman (1):
      uapi: in6: replace temporary label with rfc9486

Kai-Heng Feng (1):
      Bluetooth: Enforce validation on max value of connection interval

Kailang Yang (1):
      ALSA: hda/realtek - ALC285 reduce pop noise from Headphone port

Kory Maincent (6):
      dmaengine: dw-edma: Fix the ch_count hdma callback
      dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
      dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
      dmaengine: dw-edma: Add HDMA remote interrupt configuration
      dmaengine: dw-edma: HDMA: Add sync read before starting the DMA
transfer in remote setup
      dmaengine: dw-edma: eDMA: Add sync read before starting the DMA
transfer in remote setup

Kurt Kanzenbach (1):
      net: stmmac: Complete meta data only when enabled

Lin Ma (1):
      rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back

Linus Torvalds (1):
      Linux 6.8-rc7

Lorenzo Stoakes (1):
      MAINTAINERS: add memory mapping entry with reviewers

Lucas De Marchi (1):
      drm/xe: Use pointers in trace events

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix accept_list when attempting to suspend
      Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Lukas Bulwahn (1):
      MAINTAINERS: repair entry for MICROCHIP MCP16502 PMIC DRIVER

Lukasz Majewski (2):
      net: hsr: Fix typo in the hsr_forward_do() function comment
      net: hsr: Use correct offset for HSR TLV values in supervisory HSR fr=
ames

Ma Jun (1):
      drm/amdgpu/pm: Fix the power1_min_cap value

Maarten Lankhorst (1):
      drm/xe: Add uapi for dumpable bos

Marco Elver (2):
      stackdepot: use variable size records for non-evictable entries
      kasan: revert eviction of stack traces in generic mode

Mark Brown (1):
      spi: Drop mismerged fix

Mark O'Donovan (1):
      fs/ntfs3: fix build without CONFIG_NTFS3_LZX_XPRESS

Masami Hiramatsu (Google) (1):
      fprobe: Fix to allocate entry_data_size buffer with rethook instances

Matthew Auld (3):
      drm/buddy: fix range bias
      drm/buddy: check range allocation matches alignment
      drm/tests/drm_buddy: add alloc_range_bias test

Matthew Brost (3):
      drm/xe: Fix execlist splat
      drm/xe: Don't support execlists in xe_gt_tlb_invalidation layer
      drm/xe: Use vmalloc for array of bind allocation in bind IOCTL

Matthieu Baerts (NGI0) (1):
      mptcp: avoid printing warning once on client side

Michael Ellerman (1):
      selftests/powerpc: Fix fpu_signal failures

Micka=C3=ABl Sala=C3=BCn (3):
      selinux: fix lsm_get_self_attr()
      apparmor: fix lsm_get_self_attr()
      landlock: Fix asymmetric private inodes referring

Mika Kuoppala (2):
      drm/xe: Expose user fence from xe_sync_entry
      drm/xe: Deny unbinds if uapi ufence pending

Mikko Perttunen (1):
      gpu: host1x: Skip reset assert on Tegra186

Ming Lei (1):
      block: define bvec_iter as __packed __aligned(4)

Miquel Raynal (1):
      mtd: Fix possible refcounting issue when going through partition node=
s

Naresh Solanki (1):
      regulator: max5970: Fix regulator child node name

Nathan Chancellor (2):
      kbuild: Add -Wa,--fatal-warnings to as-instr invocation
      RISC-V: Drop invalid test from CONFIG_AS_HAS_OPTION_ARCH

Nathan Lynch (1):
      powerpc/rtas: use correct function name for resetting TCE tables

Nhat Pham (1):
      mm: cachestat: fix folio read-after-free in cache walk

Nicolin Chen (3):
      iommufd: Fix iopt_access_list_id overwrite bug
      iommufd/selftest: Fix mock_dev_num bug
      iommufd: Fix protection fault in iommufd_test_syz_conv_iova

Oleksij Rempel (3):
      lan78xx: enable auto speed configuration for LAN7850 if no
EEPROM is detected
      net: lan78xx: fix "softirq work is pending" error
      igb: extend PTP timestamp adjustments to i211

Paolo Abeni (5):
      mptcp: push at DSS boundaries
      mptcp: fix snd_wnd initialization for passive socket
      mptcp: fix potential wake-up event loss
      mptcp: fix possible deadlock in subflow diag
      selftests: mptcp: explicitly trigger the listener diag code-path

Paolo Bonzini (2):
      x86/cpu: Allow reducing x86_phys_bits during early_identify_cpu()
      x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registe=
rs

Paulo Zanoni (1):
      drm/xe: get rid of MAX_BINDS

Peng Ma (1):
      dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

Prike Liang (1):
      drm/amdgpu: Enable gpu reset for S3 abort cases on Raven series

Priyanka Dandamudi (2):
      drm/xe/xe_bo_move: Enhance xe_bo_move trace
      drm/xe/xe_trace: Add move_lacks_source detail to xe_bo_move trace

Rafael J. Wysocki (1):
      Revert "ACPI: EC: Use a spin lock without disabing interrupts"

Randy Dunlap (1):
      net: ethernet: adi: move PHYLIB from vendor to driver symbol

Ranjan Kumar (1):
      scsi: mpt3sas: Prevent sending diag_reset when the controller is read=
y

Richard Fitzgerald (2):
      ASoC: cs35l56: Must clear HALO_STATE before issuing SYSTEM_RESET
      ASoC: soc-card: Fix missing locking in snd_soc_card_get_kcontrol()

Rob Clark (1):
      soc: qcom: pmic_glink: Fix boot when QRTR=3Dm

Ryan Lin (1):
      drm/amd/display: Add monitor patch for specific eDP

Ryosuke Yasuoka (1):
      netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Sabrina Dubroca (4):
      tls: decrement decrypt_pending if no async completion will be called
      tls: fix peeking with sync+async decryption
      tls: separate no-async decryption request handling from async
      tls: fix use-after-free on failed backlog decryption

Samuel Holland (4):
      MAINTAINERS: Update SiFive driver maintainers
      riscv: Fix enabling cbo.zero when running in M-mode
      riscv: Add a custom ISA extension for the [ms]envcfg CSR
      riscv: Save/restore envcfg CSR during CPU suspend

Saravana Kannan (1):
      of: property: fw_devlink: Fix stupid bug in remote-endpoint parsing

Shannon Nelson (3):
      ionic: check before releasing pci regions
      ionic: check cmd_regs before copying in or out
      ionic: restore netdev feature bits after reset

Shiyang Ruan (1):
      xfs: drop experimental warning for FSDAX

Sid Pranjale (1):
      drm/nouveau: keep DMA buffers required for suspend/resume

Srinivasan Shanmugam (1):
      drm/amd/display: Prevent potential buffer overflow in map_hw_resource=
s

Tadeusz Struk (1):
      dmaengine: ptdma: use consistent DMA masks

Takashi Iwai (2):
      ALSA: ump: Fix the discard error code from snd_ump_legacy_open()
      ALSA: Drop leftover snd-rtctimer stuff from Makefile

Takashi Sakamoto (2):
      ALSA: firewire-lib: fix to check cycle continuity
      firewire: core: use long bus reset on gap count error

Tetsuo Handa (1):
      tomoyo: fix UAF write bug in tomoyo_write_control()

Thierry Reding (1):
      drm/tegra: Remove existing framebuffer only if we support display

Thomas Wei=C3=9Fschuh (1):
      power: supply: mm8013: select REGMAP_I2C

Th=C3=A9o Lebrun (4):
      spi: cadence-qspi: fix pointer reference in runtime PM hooks
      spi: cadence-qspi: remove system-wide suspend helper calls from
runtime PM hooks
      spi: cadence-qspi: put runtime in runtime PM hooks names
      spi: cadence-qspi: add system-wide suspend and resume callbacks

Tim Schumacher (1):
      efivarfs: Request at most 512 bytes for variable names

Vadim Shakirov (2):
      drivers: perf: added capabilities for legacy PMU
      drivers: perf: ctr_get_width function for legacy is not defined

Vladimir Oltean (1):
      net: dpaa: fman_memac: accept phy-interface-type =3D "10gbase-r"
in the device tree

Willian Wang (1):
      ALSA: hda/realtek: Add special fixup for Lenovo 14IRP8

Xiubo Li (1):
      ceph: switch to corrected encoding of max_xattr_size in mdsmap

Yang Yingliang (1):
      phy: qcom: phy-qcom-m31: fix wrong pointer pass to PTR_ERR()

Yangyu Chen (1):
      riscv: mm: fix NOCACHE_THEAD does not set bit[61] correctly

Ying Hsu (1):
      Bluetooth: Avoid potential use-after-free in hci_error_reset

Yochai Hagvi (1):
      ice: fix connection state of DPLL and out pin

Yuezhang Mo (1):
      exfat: fix appending discontinuous clusters to empty file

Yunjian Wang (1):
      tun: Fix xdp_rxq_info's queue_index when detaching

Yuxuan Hu (1):
      Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security

Zhangfei Gao (1):
      iommu/sva: Fix SVA handle sharing in multi device case

Zijun Hu (3):
      Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR
      Bluetooth: qca: Fix wrong event type for patch config command
      Bluetooth: qca: Fix triggering coredump implementation

Zong Li (1):
      riscv: add CALLER_ADDRx support

