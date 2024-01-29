Return-Path: <linux-kernel+bounces-42046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD6B83FB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9121C284104
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E698D2E5;
	Mon, 29 Jan 2024 01:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G8F+z34M"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89864D268
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490807; cv=none; b=AoEKpZfgHmh6aSCc3lRm3HMSfBMoiAPVguEEtQqaeav2M2N/pX1Oj3WOAfbXvzum5ec28mrLjo7s76n531wS6lKJFyzI2r3qdXGoMWngPaCMbpOHRogXyvITIH9CzzxeTOLqctmGkqQ6nTg0GoqlWTJ25MVisUtwkMhhV0wQK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490807; c=relaxed/simple;
	bh=UZmCK0p93CdAnGCflomFvaJXip4L+2EP+/6BAfwDC0U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=khG3Pag/8NBerL7b8Gh6mni0gHwUPewwVEvpzOxn5mj06GRjPMV+kkfcgAm/jgSzJfMurKFB2LZm/YVXVnd9H9pKBkBTS0c752aJjL3USNFO/qEIk5+CaW0CJ32sGQ+2Hkhh8H9xxsjZKojBuRLs7z+BkFMNbYfnGee7RD/HEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G8F+z34M; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf42ca9bb2so26632621fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 17:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706490802; x=1707095602; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2+M5xnGnUWF4jPN5LpLgMm869JIuxBAO59BAOEkmenQ=;
        b=G8F+z34MQsRFOPwZb8JZnhBLOZ7j7N8pS+EkOA2E2lLiuktBIpBY3O0ZFIfZtYMTS/
         5tDgfQRD1uKmFw5MNg96Q7j8ilJ/eetyxDIxuEfnswD5CTUoDupmbwQW72ozPDOkQgtu
         OgwGNMhYEQouDHnlm3iAXDOCG6bSDW24icRM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706490802; x=1707095602;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+M5xnGnUWF4jPN5LpLgMm869JIuxBAO59BAOEkmenQ=;
        b=NDNg5w6yHfl3ctRD0ATUGDkrdlkzyCA8u7zKqC7jETEo4IQYdjbtqzVxQpx+WH0/ti
         yLBFbtVRU0BybNc5E3cMIb44k1JnK+SS1lFZ+Z4yu2XM+JQD3CY8Jwk+G9Ohar+eovq9
         94RRRkDaYS4E8kMcta+5rtCvADy0kpMd17rZ2qHOAn2eTg/4DUs3g0nHSilKLMuGnPrD
         RwXitIlKIOXOiM+ePWCsGRg3mhYxblP4OB3uKWTrYBUO1OZ6IpxqwVj507DeEh4UsCfd
         kwcZ/NgAva4AQ3TLWZmYy4LLMisb71xvjYN3PnPvAb7SXRYE/NFmN8pb8cTbMTtEgRIZ
         R4+g==
X-Gm-Message-State: AOJu0YxFtrV4n/LyFJtssCYYeF02l8aH2MI3RJ1DrzN1+x2aepd2pmdk
	6b7NNMnCqj3mNC91v6UFU3uFEgyVOPlRslkmLC28pv1Y83lc5VTVWwYW2suVUdgqEtWEsWgR8Vf
	J5V/d8g==
X-Google-Smtp-Source: AGHT+IH4jhnQXzUH0K4j7iiyxXh28kRvXkiZtmpGL33o/7onHw4m4daOnL0KlCiRXMFL3blUs9qeGA==
X-Received: by 2002:a05:651c:1255:b0:2cc:e976:5915 with SMTP id h21-20020a05651c125500b002cce9765915mr2418690ljh.49.1706490801791;
        Sun, 28 Jan 2024 17:13:21 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p17-20020a2e9a91000000b002cf114820dasm982645lji.124.2024.01.28.17.13.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 17:13:21 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so23031861fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 17:13:21 -0800 (PST)
X-Received: by 2002:a05:651c:150b:b0:2cc:9ec8:fc5a with SMTP id
 e11-20020a05651c150b00b002cc9ec8fc5amr3467244ljf.39.1706490800332; Sun, 28
 Jan 2024 17:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 17:13:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgxzm+Oc1ywuNGxb1R1=ZEC85LJi776R2QEpk6=_2Qfdw@mail.gmail.com>
Message-ID: <CAHk-=wgxzm+Oc1ywuNGxb1R1=ZEC85LJi776R2QEpk6=_2Qfdw@mail.gmail.com>
Subject: Linux 6.8-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So we had a number of small annoying issues in rc1, including an
amdgpu scheduling bug that could cause a hung desktop (that would
*eventually* recover, but after a long enough timeout that most people
probably ended up rebooting instead. That one seems to have hit a fair
number of people.

There was also a btrfs bug wrt zstd-compressed inline extents,
although (somewhat) happily that wasn't in rc1 and got noticed and
reverted fairly quickly, so hopefully it didn't hit very many people.
It did me.

Anyway, I hope that with rc2, we're now in the more stable part of the
release cycle, with those kinds of problems that might affect a lot of
testers sorted out. So hopefully the fixes will be more subtle and not
affect common core setups.

So go out and test. It's safe now. You trust me, right?

                 Linus

---

Aleksander Jan Bajkowski (1):
      MIPS: lantiq: register smp_ops on non-smp platforms

Alex Deucher (2):
      drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs
      drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs

Alexander Stein (1):
      spi: spi-imx: Use dev_err_probe for failed DMA channel requests

Alexey Dobriyan (2):
      ELF, MAINTAINERS: specifically mention ELF
      smb: client: delete "true", "false" defines

Alvin Lee (1):
      drm/amd/display: Add Replay IPS register for DMUB command table

Amir Goldstein (1):
      ovl: mark xwhiteouts directory with overlay.opaque=3D'x'

Amit Kumar Mahapatra (1):
      spi: spi-cadence: Reverse the order of interleaved write and
read operations

Andreas Larsson (1):
      MAINTAINERS: Add Andreas Larsson as co-maintainer for arch/sparc

Arkadiusz Kubalewski (4):
      dpll: fix broken error path in dpll_pin_alloc(..)
      dpll: fix pin dump crash for rebound module
      dpll: fix userspace availability of pins
      dpll: fix register pin with unregistered parent pin

Armin Wolf (5):
      platform/x86: wmi: Fix error handling in legacy WMI notify
handler functions
      platform/x86: wmi: Return immediately if an suitable WMI event is fou=
nd
      platform/x86: wmi: Decouple legacy WMI notify handlers from wmi_block=
_list
      platform/x86: wmi: Fix notify callback locking
      platform/x86: intel-wmi-sbl-fw-update: Fix function name in error mes=
sage

Arnd Bergmann (2):
      drm/panel/raydium-rm692e5: select CONFIG_DRM_DISPLAY_DP_HELPER
      drm/exynos: fix accidental on-stack copy of exynos_drm_plane

Artur Weber (2):
      drm/panel: samsung-s6d7aa0: drop DRM_BUS_FLAG_DE_HIGH for lsl080al02
      ARM: dts: exynos4212-tab3: add samsung,invert-vclk flag to fimd

Askar Safin (1):
      exec: remove useless comment

Bagas Sanjaya (1):
      drm/dp_mst: Separate @failing_port list in
drm_dp_mst_atomic_check_mgr() comment

Benjamin Berg (1):
      wifi: ath11k: rely on mac80211 debugfs handling for vif

Benjamin Gaignard (1):
      media: media videobuf2: Stop direct calls to queue num_buffers field

Benjamin Poirier (1):
      selftests: bonding: Increase timeout to 1200s

Bernd Edlinger (2):
      exec: Fix error handling in begin_new_exec()
      net: stmmac: Wait a bit for the reset to take effect

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Add X86_FEATURE_ZEN5

Brandon Brnich (2):
      dt-bindings: media: Remove K3 Family Prefix from Compatible
      media: chips-media: wave5: Remove K3 References

Breno Leitao (10):
      net: fill in MODULE_DESCRIPTION()s for 8390
      net: fill in MODULE_DESCRIPTION()s for Broadcom bgmac
      net: fill in MODULE_DESCRIPTION()s for liquidio
      net: fill in MODULE_DESCRIPTION()s for ep93xxx_eth
      net: fill in MODULE_DESCRIPTION()s for nps_enet
      net: fill in MODULE_DESCRIPTION()s for enetc
      net: fill in MODULE_DESCRIPTION()s for fec
      net: fill in MODULE_DESCRIPTION()s for fsl_pq_mdio
      net: fill in MODULE_DESCRIPTION()s for litex
      net: fill in MODULE_DESCRIPTION()s for rvu_mbox

Charles Keepax (1):
      spi: cs42l43: Handle error from devm_pm_runtime_enable

Christian A. Ehrhardt (1):
      block: Fix WARNING in _copy_from_iter

Christoph Hellwig (1):
      bcachefs: fix incorrect usage of REQ_OP_FLUSH

Christophe JAILLET (1):
      rbd: remove usage of the deprecated ida_simple_*() API

ChunTao Tso (1):
      drm/amd/display: Replay + IPS + ABM in Full Screen VPB

Chung-Chiang Cheng (1):
      btrfs: tree-checker: fix inline ref size in error messages

Cong Liu (1):
      platform/x86/amd/pmf: Fix memory leak in amd_pmf_get_pb_data()

Conrad Kostecki (1):
      ahci: asm1166: correct count of reported ports

Cristian Marussi (11):
      firmware: arm_scmi: Check mailbox/SMT channel for consistency
      firmware: arm_scmi: Use xa_insert() to store opps
      firmware: arm_scmi: Use xa_insert() when saving raw queues
      firmware: arm_scmi: Fix the clock protocol version for v3.2
      firmware: arm_scmi: Fix the clock protocol supported version
      firmware: arm_ffa: Add missing rwlock_init() in ffa_setup_partitions(=
)
      firmware: arm_ffa: Add missing rwlock_init() for the driver partition
      firmware: arm_ffa: Check xa_load() return value
      firmware: arm_ffa: Simplify ffa_partitions_cleanup()
      firmware: arm_ffa: Use xa_insert() and check for result
      firmware: arm_ffa: Handle partitions setup failures

Dan Carpenter (3):
      platform/x86: wmi: Fix wmi_dev_probe()
      netfs, fscache: Prevent Oops in fscache_put_cache()
      netfs: Fix a NULL vs IS_ERR() check in netfs_perform_write()

Dan Williams (2):
      tools/testing/cxl: Disable "missing prototypes / declarations" warnin=
gs
      tools/testing/nvdimm: Disable "missing prototypes / declarations" war=
nings

Dave Airlie (1):
      Revert "nouveau: push event block/allowing out of the fence context"

Dave Chinner (1):
      xfs: read only mounts with fsopen mount API are busted

David Howells (11):
      netfs, cachefiles: Change mailing list
      netfs: Add Jeff Layton as reviewer
      netfs: Don't use certain unnecessary folio_*() functions
      afs: Don't use certain unnecessary folio_*() functions
      cifs: Don't use certain unnecessary folio_*() functions
      cachefiles, erofs: Fix NULL deref in when cachefiles is not
doing ondemand-mode
      afs: Hide silly-rename files from userspace
      afs: Fix error handling with lookup via FS.InlineBulkStatus
      afs: Remove afs_dynroot_d_revalidate() as it is redundant
      afs: Fix missing/incorrect unlocking of RCU read lock
      cifs: Share server EOF pos with netfslib

David Lechner (1):
      spi: fix finalize message on error return

David Sterba (1):
      btrfs: don't warn if discard range is not aligned to sector

Dawei Li (1):
      genirq: Initialize resend_node hlist for all interrupt descriptors

Devyn Liu (1):
      spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected

Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_any_create_groups

Dmitry Antipov (1):
      btrfs: fix kvcalloc() arguments order in btrfs_ioctl_send()

Douglas Anderson (2):
      drm/bridge: parade-ps8640: Wait for HPD when doing an AUX transfer
      drm/bridge: parade-ps8640: Make sure we drop the AUX mutex in
the error case

Emmanuel Grumbach (1):
      wifi: iwlwifi: fix a memory corruption

Eric Dumazet (2):
      llc: make llc_ui_sendmsg() more robust against bonding changes
      udp: fix busy polling

Fedor Pchelkin (4):
      btrfs: ref-verify: free ref cache before clearing mount opt
      drm/ttm: fix ttm pool initialization for no-dma-device drivers
      drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume
      drm/ttm: fix ttm pool initialization for no-dma-device drivers

Felix Fietkau (1):
      wifi: mac80211: fix race condition on enabling fast-xmit

Florian Fainelli (3):
      MIPS: Cobalt: Fix missing prototypes
      MIPS: Alchemy: Fix missing prototypes
      MIPS: BCM63XX: Fix missing prototypes

Florian Westphal (3):
      netfilter: nft_limit: reject configurations that cause integer overfl=
ow
      netfilter: nf_tables: restrict anonymous set and map names to 16 byte=
s
      netfilter: nf_tables: reject QUEUE/DROP verdict parameters

Frederic Weisbecker (1):
      rcu: Defer RCU kthreads wakeup when CPU is dying

Fullway Wang (2):
      fbdev: savage: Error out if pixclock equals zero
      fbdev: sis: Error out if pixclock equals zero

Geert Uytterhoeven (1):
      fbcon: Fix incorrect printed function name in fbcon_prepare_logo()

George Guo (1):
      netfilter: nf_tables: cleanup documentation

Gerhard Engleder (2):
      tsnep: Remove FCS for XDP data path
      tsnep: Fix XDP_RING_NEED_WAKEUP for empty fill ring

Gustavo A. R. Silva (2):
      Makefile: Enable -Wstringop-overflow globally
      init: Kconfig: Disable -Wstringop-overflow for GCC-11

Gustavo Sousa (1):
      docs/sphinx: Fix TOC scroll hack for the home page

Hangbin Liu (1):
      selftests: bonding: do not test arp/ns target with mode balance-alb/t=
lb

Hans Verkuil (1):
      media: vb2: refactor setting flags and caps, fix missing cap

Hans de Goede (2):
      platform/x86: silicom-platform: Add missing "Description:" for
power_cycle sysfs attr
      MAINTAINERS: remove defunct acpi4asus project info from asus
notebooks section

Hawking Zhang (1):
      drm/amdgpu: Fix null pointer dereference

Heiner Kallweit (1):
      MAINTAINERS: Remove Perry Yuan as DELL WMI HARDWARE PRIVACY
SUPPORT maintainer

Helge Deller (1):
      fbdev: stifb: Fix crash in stifb_blank()

Himal Prasad Ghimiray (1):
      drm/xe/xe2: Use XE_CACHE_WB pat index

Horatiu Vultur (1):
      net: micrel: Fix PTP frame parsing for lan8814

Hsin-Yi Wang (1):
      drm/bridge: anx7625: Ensure bridge is suspended in disable()

Hu Haowen (1):
      docs/accel: correct links to mailing list archives

Huacai Chen (2):
      LoongArch/smp: Call rcutree_report_cpu_starting() at tlb_init()
      LoongArch: KVM: Fix build due to API changes

Huang Pei (3):
      MIPS: reserve exception vector space ONLY ONCE
      MIPS: loongson64: set nid for reserved memblock region
      MIPS: loongson64: set nid for reserved memblock region

Ido Schimmel (1):
      net/sched: flower: Fix chain template offload

Ilya Dryomov (1):
      rbd: don't move requests to the running list on errors

Inki Dae (1):
      drm/exynos: fix incorrect type issue

Inochi Amaoto (1):
      riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit
aclint format

Ira Weiny (1):
      cxl/pci: Skip irq features if MSI/MSI-X are not supported

Jacek Lawrynowicz (8):
      accel/ivpu: Fix for missing lock around drm_gem_shmem_vmap()
      accel/ivpu: Free buffer sgt on unbind
      accel/ivpu: Disable buffer sharing among VPU contexts
      accel/ivpu: Improve buffer object debug logs
      accel/ivpu: Disable PLL after VPU IP reset during FLR
      accel/ivpu: Fix dev open/close races with unbind
      accel/ivpu: Improve stability of ivpu_submit_ioctl()
      accel/ivpu: Improve recovery and reset support

Jakub Kicinski (4):
      net: fix removing a namespace with conflicting altnames
      selftests: fill in some missing configs for net
      selftests: net: fix rps_default_mask with >32 CPUs
      selftests: netdevsim: fix the udp_tunnel_nic test

Jan Beulich (1):
      xen-netback: don't produce zero-size SKB frags

Jenishkumar Maheshbhai Patel (1):
      net: mvpp2: clear BM pool before initialization

Jiapeng Chong (1):
      fbdev: vt8500lcdfb: Remove unnecessary print function dev_err()

Jiri Wiesner (1):
      clocksource: Skip watchdog check for large watchdog intervals

Jithu Joseph (1):
      platform/x86/intel/ifs: Call release_firmware() when handling errors.

Johannes Berg (1):
      wifi: mac80211: fix potential sta-link leak

Josef Bacik (2):
      btrfs: use the original mount's mount options for the legacy reconfig=
ure
      btrfs: don't unconditionally call folio_start_writeback in subpage

Juergen Gross (1):
      x86/paravirt: Make BUG_func() usable by non-GPL modules

Kalle Valo (1):
      wifi: p54: fix GCC format truncation warning with wiphy->fw_version

Kamal Dasu (1):
      spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Kees Cook (4):
      exec: Add do_close_execat() helper
      smb: Work around Clang __bdos() type confusion
      exec: Check __FMODE_EXEC instead of in_execve for LSMs
      exec: Distinguish in_execve from in_exec

Kenneth Feng (1):
      drm/amd/pm: update the power cap setting

Kent Overstreet (3):
      bcachefs: Add gfp flags param to bch2_prt_task_backtrace()
      bcachefs: discard path uses unlock_long()
      bcachefs: __lookup_dirent() works in snapshot, not subvol

Khaled Almahallawy (1):
      drm/i915/dp: Fix passing the correct DPCD_REV for
drm_dp_set_phy_test_pattern

Kuniyuki Iwashima (2):
      llc: Drop support for ETH_P_TR_802_2.
      selftest: Don't reuse port for SO_INCOMING_CPU test.

Lennert Buytenhek (1):
      ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers

Leon Romanovsky (2):
      net/mlx5e: Allow software parsing when IPsec crypto is enabled
      net/mlx5e: Ignore IPsec replay window values on sender side

Li Lingfeng (1):
      block: Move checking GENHD_FL_NO_PART to bdev_add_partition()

Lijo Lazar (3):
      drm/amdgpu: Avoid fetching vram vendor information
      drm/amdgpu: Show vram vendor only if available
      drm/amd/pm: Fetch current power limit from FW

Liming Sun (1):
      platform/mellanox: mlxbf-tmfifo: Drop Tx network packet when Tx
TmFIFO is full

Lin Ma (2):
      vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING
      ksmbd: fix global oob in ksmbd_nl_policy

Linus Torvalds (4):
      Revert "btrfs: zstd: fix and simplify the inline extent decompression=
"
      samples/cgroup: add .gitignore file for generated samples
      uselib: remove use of __FMODE_EXEC
      Linux 6.8-rc2

Lucas De Marchi (5):
      drm/i915: Drop -Wstringop-overflow
      drm/xe: Use _ULL for u64 division
      drm/xe/mmio: Cast to u64 when printing
      drm/xe/display: Avoid calling readq()
      drm/xe: Remove PVC from xe_wa kunit tests

Lucas Stach (1):
      SUNRPC: use request size to initialize bio_vec in svc_udp_sendto()

Lukas Bulwahn (2):
      wifi: cfg80211/mac80211: remove dependency on non-existing option
      docs: admin-guide: remove obsolete advice related to SLAB allocator

Lukas Wunner (2):
      ARM: dts: Fix TPM schema violations
      arm64: dts: Fix TPM schema violations

Luke D. Jones (1):
      MAINTAINERS: add Luke Jones as maintainer for asus notebooks

Ma Jun (1):
      drm/amdgpu/pm: Fix the power source flag error

Maciej Fijalkowski (10):
      xsk: recycle buffer in case Rx queue was full
      xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags
      xsk: fix usage of multi-buffer BPF helpers for ZC XDP
      ice: work on pre-XDP prog frag count
      ice: remove redundant xdp_rxq_info registration
      intel: xsk: initialize skb_frag_t::bv_offset in ZC drivers
      ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue
      xdp: reflect tail increase for MEM_TYPE_XSK_BUFF_POOL
      i40e: set xdp_rxq_info::frag_size
      i40e: update xdp_rxq_info::frag_size for ZC enabled Rx queue

Maksim Kiselev (1):
      aoe: avoid potential deadlock at set_capacity

Mario Limonciello (3):
      gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04
      cpufreq/amd-pstate: Fix setting scaling max/min freq values
      x86/CPU/AMD: Add more models to X86_FEATURE_ZEN5

Mark Brown (1):
      spi: Raise limit on number of chip selects

Markus Niebel (1):
      drm: panel-simple: add missing bus flags for Tianma tm070jvhg[30/33]

Matthew Brost (1):
      drm/sched: Drain all entities in DRM sched run job worker

Ma=C3=ADra Canal (1):
      drm/v3d: Free the job and assign it to NULL if initialization fails

Michael Chan (5):
      bnxt_en: Wait for FLR to complete during probe
      bnxt_en: Fix memory leak in bnxt_hwrm_get_rings()
      bnxt_en: Fix RSS table entries calculation for P5_PLUS chips
      bnxt_en: Prevent kernel warning when running offline self test
      bnxt_en: Fix possible crash after creating sw mqprio TCs

Michael Kelley (1):
      hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes

Michael Walle (1):
      drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE

Michal Kazior (1):
      wifi: cfg80211: fix missing interfaces when dumping

Michal Schmidt (1):
      idpf: distinguish vports by the dev_port attribute

Micha=C5=82 Winiarski (1):
      drm/tests: mm: Call drm_mm_print in drm_test_mm_debug

Mika Westerberg (2):
      spi: intel-pci: Remove Meteor Lake-S SoC PCI ID from the list
      spi: intel-pci: Add support for Arrow Lake SPI serial flash

Mikulas Patocka (1):
      md: fix a suspicious RCU usage warning

Mimi Zohar (1):
      Revert "KEYS: encrypted: Add check for strsep"

Moshe Shemesh (1):
      net/mlx5: Bridge, fix multicast packets sent to uplink

Moti Haimovski (1):
      drm/xe/vm: bugfix in xe_vm_create_ioctl

Naohiro Aota (4):
      btrfs: zoned: factor out prepare_allocation_zoned()
      btrfs: zoned: optimize hint byte for zoned allocator
      btrfs: fix unbalanced unlock of mapping_tree_lock
      btrfs: zoned: fix lock ordering in btrfs_zone_activate()

Nathan Chancellor (1):
      platform/x86: intel-uncore-freq: Fix types in sysfs callbacks

NeilBrown (1):
      nfsd: fix RELEASE_LOCKOWNER

Nicholas Kazlauskas (1):
      drm/amd/display: Allow IPS2 during Replay

Niklas Cassel (1):
      ata: libata-sata: improve sysfs description for ATA_LPM_UNKNOWN

Omar Sandoval (2):
      btrfs: don't abort filesystem when attempting to snapshot
deleted subvolume
      btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of
subvolume being deleted

Pablo Neira Ayuso (2):
      netfilter: nft_chain_filter: handle NETDEV_UNREGISTER for
inet/ingress basechain
      netfilter: nf_tables: validate NFPROTO_* family

Paul Moore (1):
      io_uring: enable audit and restrict cred override for
IORING_OP_FIXED_FD_INSTALL

Petr Pavlu (1):
      tracing: Ensure visibility when inserting an element into tracing_map

Phoenix Chen (1):
      platform/x86: touchscreen_dmi: Add info for the TECLAST X16 Plus tabl=
et

Pin-yen Lin (1):
      drm/bridge: parade-ps8640: Ensure bridge is suspended in .post_disabl=
e()

Pu Lehui (1):
      riscv, bpf: Fix unpredictable kernel crash about RV64 struct_ops

Qu Wenruo (6):
      btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args
      btrfs: zlib: fix and simplify the inline extent decompression
      btrfs: lzo: fix and simplify the inline extent decompression
      btrfs: zstd: fix and simplify the inline extent decompression
      btrfs: scrub: avoid use-after-free when chunk length is not 64K align=
ed
      btrfs: scrub: limit RST scrub to chunk boundary

Quanquan Cao (1):
      cxl/region=EF=BC=9AFix overflow issue in alloc_hpa()

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Refine computation of P-state for given freque=
ncy

Rahul Rameshbabu (3):
      Revert "net: macsec: use skb_ensure_writable_head_tail to expand the =
skb"
      net/mlx5e: Fix operation precedence bug in port timestamping
napi_poll context
      net/mlx5: Use mlx5 device constant for selecting CQ period mode for A=
SO

Randy Dunlap (1):
      LoongArch: KVM: Add returns to SIMD stubs

Richard Palethorpe (1):
      x86/entry/ia32: Ensure s32 is sign extended to s64

Rob Herring (1):
      dt-bindings: display: samsung,exynos-mixer: Fix 'regs' typo

Roman Li (4):
      drm/amd/display: Add IPS checks before dcn register access
      drm/amd/display: Disable ips before dc interrupt setting
      drm/amd: Add a DC debug mask for IPS
      drm/amd/display: "Enable IPS by default"

Saeed Mahameed (1):
      net/mlx5e: Use the correct lag ports number when creating TISes

Salvatore Dipietro (1):
      tcp: Add memory barrier to tcp_push()

Sebastian Andrzej Siewior (1):
      futex: Prevent the reuse of stale pi_state

Sharath Srinivasan (1):
      net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Shenwei Wang (1):
      net: fec: fix the unhandled context fault from smmu

Shin'ichiro Kawasaki (2):
      platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe
      platform/x86: p2sb: Use pci_resource_n() in p2sb_read_bar0()

Shravan Kumar Ramani (1):
      platform/mellanox: mlxbf-pmc: Fix offset calculation for crspace even=
ts

Shyam Prasad N (6):
      cifs: cifs_pick_channel should try selecting active channels
      cifs: translate network errors on send to -ECONNABORTED
      cifs: helper function to check replayable error codes
      cifs: commands that are retried should have replay flag set
      cifs: set replay flag for retries of write command
      cifs: fix stray unlock in cifs_chan_skip_or_disable

Shyam Sundar S K (2):
      platform/x86/amd/pmf: Get Human presence information from AMD SFH dri=
ver
      platform/x86/amd/pmf: Get ambient light information from AMD SFH driv=
er

Srinivas Pandruvada (1):
      thermal: intel: powerclamp: Remove dead code for target mwait value

Srinivasan Shanmugam (1):
      drm/amd/display: Fix uninitialized variable usage in core_link_
'read_dpcd() & write_dpcd()' functions

Stanley Chan (1):
      tools cpupower bench: Override CFLAGS assignments

Steven Rostedt (Google) (1):
      eventfs: Save directory inodes in the eventfs_inode structure

Tanzir Hasan (1):
      firmware: arm_scmi: Replace asm-generic/bug.h with linux/bug.h

Tariq Toukan (2):
      net/mlx5: Fix query of sd_group field
      net/mlx5e: Fix inconsistent hairpin RQT sizes

Thomas Bogendoerfer (5):
      MIPS: sgi-ip27: Fix missing prototypes
      MIPS: fw arc: Fix missing prototypes
      MIPS: sgi-ip30: Fix missing prototypes
      MIPS: sgi-ip32: Fix missing prototypes
      Revert "MIPS: loongson64: set nid for reserved memblock region"

Thomas Hellstr=C3=B6m (2):
      drm/xe/dmabuf: Make xe_dmabuf_ops static
      drm/xe: Use a NULL pointer instead of 0.

Thomas Zimmermann (1):
      Revert "drivers/firmware: Move sysfb_init() from device_initcall
to subsys_initcall_sync"

Tim Chen (1):
      tick/sched: Preserve number of idle sleeps across CPU hotplug events

Tirthendu Sarkar (1):
      i40e: handle multi-buffer packets that are shrunk by xdp prog

Tom St Denis (1):
      drm/amd/amdgpu: Assign GART pages to AMD device mapping

Tomi Valkeinen (2):
      drm/bridge: sii902x: Fix probing race issue
      drm/bridge: sii902x: Fix audio codec unregistration

Tony Luck (1):
      x86/cpu: Add model number for Intel Clearwater Forest processor

Tudor Ambarus (1):
      arm64: dts: exynos: gs101: comply with the new cmu_misc clock names

Umesh Nerlige Ramappa (1):
      drm/i915/perf: Update handling of MMIO triggered reports

Vegard Nossum (1):
      doc: admin-guide/kernel-parameters: remove useless comment

Ville Syrj=C3=A4l=C3=A4 (2):
      Revert "drm/i915/dsi: Do display on sequence later on icl+"
      drm/i915/psr: Only allow PSR in LPSP mode on HSW non-ULT

Vlad Buslov (1):
      net/mlx5e: Fix peer flow lists handling

Wachowski, Karol (5):
      accel/ivpu: Dump MMU events in case of VPU boot timeout
      accel/ivpu: Call diagnose failure in ivpu_mmu_cmdq_sync()
      accel/ivpu: Add debug prints for MMU map/unmap operations
      accel/ivpu: Add diagnostic messages when VPU fails to boot or suspend
      accel/ivpu: Deprecate DRM_IVPU_PARAM_CONTEXT_PRIORITY param

Wen Gu (1):
      net/smc: fix illegal rmb_desc access in SMC-D connection dump

Wenhua Lin (1):
      gpio: eic-sprd: Clear interrupt after set the interrupt type

Xi Ruoyao (1):
      mips: Call lose_fpu(0) before initializing fcr31 in
mips_set_personality_nan

Yajun Deng (1):
      memblock: fix crash when reserved memory is not added to memory

Yang Li (1):
      smb: Fix some kernel-doc comments

Yang Wang (1):
      drm/amd/pm: udpate smu v13.0.6 message permission

Yangyu Chen (1):
      drm/ttm: allocate dummy_read_page without DMA32 on fail

Yevgeny Kliteynik (2):
      net/mlx5: DR, Use the right GVMI number for drop action
      net/mlx5: DR, Can't go to uplink vport on RX rule

Yishai Hadas (1):
      net/mlx5: Fix a WARN upon a callback command failure

Yunjian Wang (2):
      tun: fix missing dropped counter in tun_xdp_act
      tun: add missing rx stats accounting in tun_xdp_act

Zhengchao Shao (3):
      tcp: make sure init the accept_queue's spinlocks once
      netlink: fix potential sleeping issue in mqueue_flush_file
      ipv6: init the accept_queue's spinlocks in inet6_create

Zhipeng Lu (2):
      net/mlx5e: fix a double-free in arfs_create_groups
      fjes: fix memleaks in fjes_hw_setup

