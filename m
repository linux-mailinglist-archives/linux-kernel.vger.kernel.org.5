Return-Path: <linux-kernel+bounces-126381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74B3893654
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 00:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06AE1F21A01
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36802148314;
	Sun, 31 Mar 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MkwgtaBD"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C791E4A2
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711922759; cv=none; b=gutO94AIA+agOvh+/mdTIBHWSpWiwDEUm8Xx+wR3JrhzOSgnnXyBob8ZTMiigzFrZVtEYEAK36q4u22UZLrdBFnLulDTygYHObg6y8ytdbRt8xcenWj+MqxXqmBLhTdidiwBSpYyQ8lkP6Yq2giskuKVbyZ73FgDyU7icF9K7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711922759; c=relaxed/simple;
	bh=JQOlAtEny39GqICQu0Uj77842MSu1ujdivjTHEcHX4w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Pv0Pti4tAdJbedXMguJfeIxiM80s5jtJ+yCBrpi75W4oVnM1S/6RFKVs9CRAV3wLUeIkpkJPvep1ueYdiFL7BL8OSLc8A/r3w3rz8L4mxXCRmQCP7DB18bJDFsN3NeVTd+vKnxP1Td4ggptiS2KPtqAFsXV7eO028HviIJSIzb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MkwgtaBD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4e60a64abcso67120566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711922754; x=1712527554; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=16DAhmj0d3UXHWskFIKDaxv5LwnQlDFU9b0r4B7w7EU=;
        b=MkwgtaBDGd9ssHNMb6RjWYYB2DTm435RheDIPizsvvi+gKeSqllSMyWngx4QsCGDwW
         zcx0L2TgTbvqjaCOlQjdmAVXPfoaEbtF6FMKkfwZ02sJMkAD1BhupJdWfBWI8sMTHiWz
         sh/zQl9RU0y46RNsCosXQvx6u0AnaI1n9Z/aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711922754; x=1712527554;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16DAhmj0d3UXHWskFIKDaxv5LwnQlDFU9b0r4B7w7EU=;
        b=dzKIEqQtcKyZL78t0dgOu+yW0k8s8DgXmWP+GUuz1LdbOfw607vu8tIddGt9wTTKT6
         uxBr+aQAjv/EPjxTvm+LmlGpZziNYqwsEl63V28/i4vMaMZZdWAVj0VGLP85DEHKIAet
         VDfb3f562MywVcpcGgsMRTjVjQDz9FYRLFfEfGzRF+rLncqYtqkvM0uNnDl2bIEFaAaW
         vRmAjWMSQb/cqoMN8LYevqT+LgO0UTraGi0Vn4oy4OdGHBXU4Q1N6CB/cJZz5cy78K7V
         +EDAnc6TZkuI9DWgcUA3pV61+UfCEuuu9SCBLgIun3kSbXZfMlZzASUepq3cw/JoVufG
         qi0g==
X-Gm-Message-State: AOJu0YwwesA5PdE+boaiJ44x/z4Xq4Tvaq+nJUPh/ynqCJA2gnpaYQfp
	NmVpXTwPTo11Z4ISYLOcvqU8jY4leT5/4nHQz8j4C59Z0VynqfOuS00iLRUeQzYpfmofuOG50x4
	7GNRINg==
X-Google-Smtp-Source: AGHT+IEKksZ1Nr9DI9rRwtniMA+wMYwtha8i9F+2KDOFFM0uOP71HOnzSUAa5Vjmc91tuWTm2mN4Sw==
X-Received: by 2002:a17:906:2c44:b0:a4e:65a2:4fcd with SMTP id f4-20020a1709062c4400b00a4e65a24fcdmr1547861ejh.18.1711922754175;
        Sun, 31 Mar 2024 15:05:54 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id z3-20020a170906714300b00a4650ec48d0sm4679468ejj.140.2024.03.31.15.05.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 15:05:53 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a47385a4379so804751766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 15:05:53 -0700 (PDT)
X-Received: by 2002:a17:906:24c8:b0:a4e:6489:ab89 with SMTP id
 f8-20020a17090624c800b00a4e6489ab89mr1711972ejb.20.1711922751867; Sun, 31 Mar
 2024 15:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 31 Mar 2024 15:05:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjf=8JusO9TgkMfNziLjjSHdMOUpes_6f5m9_w+7taeBA@mail.gmail.com>
Message-ID: <CAHk-=wjf=8JusO9TgkMfNziLjjSHdMOUpes_6f5m9_w+7taeBA@mail.gmail.com>
Subject: Linux 6.9-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Neither snow nor rain nor heat nor gloom of night stays kernel rc releases.

Nor does Easter.

So here we are. Another week has passed, and rc2 is out. Nothing here
look all that remarkable, and the fixes are fairly evenly spread out
(so mostly drivers, because that's the bulk of the code).

Outside of the driver fixes (see shortlog below for details), we've
got some more selftest work (mostly networking and bpf but also some
random fixes), some architecture fixes (mostly x86), some filesystem
work (xfs and btrfs) and random noise in other parts (mm, core kernel,
networking, Kbuild..).

Nothing stands out to me or looks unusual.

                 Linus

---

Alan Stern (3):
      USB: core: Fix deadlock in usb_deauthorize_interface()
      USB: core: Add hub_get() and hub_put() routines
      USB: core: Fix deadlock in port "disable" sysfs attribute

Alexander Stein (1):
      Revert "usb: phy: generic: Get the vbus supply"

Alexander Wetzel (1):
      scsi: sg: Avoid sg device teardown race

Alexandra Winter (1):
      s390/qeth: handle deferred cc1

Alexei Starovoitov (4):
      bpf: Clarify bpf_arena comments.
      libbpf, selftests/bpf: Adjust libbpf, bpftool, selftests to match LLV=
M
      selftests/bpf: Remove hard coded PAGE_SIZE macro.
      selftests/bpf: Add arena test case for 4Gbyte corner case

Anand Jain (2):
      btrfs: validate device maj:min during open
      btrfs: return accurate error code on open failure in open_fs_devices(=
)

Andrei Matei (2):
      bpf: Check bloom filter map value size
      bpf: Protect against int overflow for stack access size

Andrew Price (1):
      gfs2: Fix invalid metadata access in punch_hole

Andrii Nakryiko (1):
      libbpf: fix u64-to-pointer cast on 32-bit arches

Andy Shevchenko (1):
      gpiolib: Fix debug messaging in gpiod_find_and_request()

Andy Yan (1):
      drm/rockchip: vop2: Remove AR30 and AB30 format support

Ard Biesheuvel (3):
      x86/efistub: Add missing boot_params for mixed mode compat entry
      efi/libstub: Cast away type warning in use of max()
      x86/efistub: Reinstate soft limit for initrd loading

Arnaldo Carvalho de Melo (1):
      libbpf: Define MFD_CLOEXEC if not available

Arnd Bergmann (6):
      staging: vc04_services: changen strncpy() to strscpy_pad()
      irqchip/armada-370-xp: Suppress unused-function warning
      ACPI: APEI: EINJ: mark remove callback as non-__exit
      ALSA: aoa: avoid false-positive format truncation warning
      dm integrity: fix out-of-range warning
      kbuild: make -Woverride-init warnings more consistent

Artem Savkov (1):
      arm64: bpf: fix 32bit unconditional bswap

Ar=C4=B1n=C3=A7 =C3=9CNAL (1):
      net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7=
530

Ayala Beker (1):
      wifi: mac80211: correctly set active links upon TTLM

Baoquan He (1):
      crash: use macro to add crashk_res into iomem early for specific arch

Barry Song (1):
      mm: zswap: fix kernel BUG in sg_init_one

Bartosz Golaszewski (1):
      gpio: cdev: sanitize the label before requesting the interrupt

Benjamin Berg (2):
      wifi: iwlwifi: mvm: guard against invalid STA ID on removal
      wifi: iwlwifi: mvm: include link ID when releasing frames

Bhanuprakash Modem (2):
      drm/i915/drrs: Refactor CPU transcoder DRRS check
      drm/i915/display/debugfs: Fix duplicate checks in i915_drrs_status

Bikash Hazarika (1):
      scsi: qla2xxx: Update manufacturer detail

Bj=C3=B8rn Mork (1):
      net: wwan: t7xx: Split 64bit accesses to fix alignment issues

Borislav Petkov (AMD) (3):
      x86/vdso: Fix rethunk patching for vdso-image-x32.o too
      x86/bugs: Fix the SRSO mitigation on Zen3/4
      kbuild: Disable KCSAN for autogenerated *.mod.c intermediaries

Brent Lu (2):
      ALSA: hda: intel-nhlt: add intel_nhlt_ssp_device_type() function
      ASoC: SOF: ipc4-topology: support NHLT device type

Carlos Maiolino (1):
      tmpfs: fix race on handling dquot rbtree

Chris Bainbridge (1):
      drm/dp: Fix divide-by-zero regression on DP MST unplug with nouveau

Chris Park (1):
      drm/amd/display: Prevent crash when disable stream

Chris Wilson (1):
      drm/i915/gt: Reset queue_priority_hint on parking

Christian A. Ehrhardt (5):
      usb: typec: ucsi: Clear EVENT_PENDING under PPM lock
      usb: typec: ucsi: Check for notifications after init
      usb: typec: ucsi: Ack unsupported commands
      usb: typec: ucsi_acpi: Refactor and fix DELL quirk
      usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

Christian Marangi (1):
      net: phy: qcom: at803x: fix kernel panic with at8031_probe

Christoph Hellwig (1):
      block: don't reject too large max_user_sectors in blk_validate_limits

Chuck Lever (2):
      SUNRPC: Revert 561141dd494382217bace4d1a51d08168420eace
      NFSD: CREATE_SESSION must never cache NFS4ERR_DELAY replies

Claus Hansen Ries (1):
      net: ll_temac: platform_get_resource replaced by wrong function

Colin Ian King (2):
      scsi: target: iscsi: Remove unused variable xfer_len
      fs/9p: remove redundant pointer v9ses

Cong Liu (1):
      tools/Makefile: remove cgroup target

Damien Le Moal (2):
      scsi: sd: Fix TCG OPAL unlock on system resume
      block: Do not force full zone append completion in req_bio_endio()

Dan Carpenter (2):
      nexthop: fix uninitialized variable in nla_put_nh_group_stats()
      staging: vc04_services: fix information leak in create_component()

Daniel Lezcano (1):
      Revert "thermal: core: Don't update trip points inside the
hysteresis range"

Dave Airlie (1):
      drm/i915: add bug.h include to i915_memcpy.c

Dave Chinner (2):
      xfs: allow sunit mount option to repair bad primary sb stripe values
      xfs: don't use current->journal_info

David Gow (1):
      kunit: configs: Enable CONFIG_DAMON_DBGFS_DEPRECATED for --alltests

David Howells (1):
      cifs: Fix duplicate fscache cookie warnings

David Thompson (2):
      mlxbf_gige: stop PHY during open() error paths
      mlxbf_gige: call request_irq() after NAPI initialized

Dmitry Baryshkov (1):
      scsi: ufs: qcom: Provide default cycles_in_1us value

Duoming Zhou (2):
      nouveau/dmem: handle kcalloc() allocation failure
      ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Edward Liaw (2):
      selftests/mm: sigbus-wp test requires UFFD_FEATURE_WP_HUGETLBFS_SHMEM
      selftests/mm: fix ARM related issue with fork after pthread_create

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: pick the version of SESSION_PROTECTION_NOTIF

Eric Biggers (1):
      Revert "crypto: pkcs7 - remove sha1 support"

Eric Dumazet (1):
      tcp: properly terminate timers for kernel sockets

Eric Huang (1):
      drm/amdkfd: fix TLB flush after unmap for GFX9.4.2

Eric Van Hensbergen (1):
      fs/9p: fix uninitialized values during inode evict

Felix Fietkau (1):
      wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes

Filipe Manana (4):
      btrfs: fix extent map leak in unexpected scenario at unpin_extent_cac=
he()
      btrfs: fix warning messages not printing interval at unpin_extent_ran=
ge()
      btrfs: fix message not properly printing interval when adding extent =
map
      btrfs: use btrfs_warn() to log message at btrfs_add_extent_mapping()

Florian Westphal (1):
      inet: inet_defrag: prevent sk release while still in use

Francesco Dolcini (1):
      MAINTAINERS: wifi: mwifiex: add Francesco as reviewer

Gao Xiang (1):
      erofs: drop experimental warning for FSDAX

George Shen (1):
      drm/amd/display: Remove MPC rate control logic from DCN30 and above

Gergo Koteles (4):
      ALSA: hda/tas2781: remove digital gain kcontrol
      ALSA: hda/tas2781: add locks to kcontrols
      ALSA: hda/tas2781: add debug statements to kcontrols
      ALSA: hda/tas2781: remove useless dev_dbg from playback_hook

Guilherme G. Piccoli (1):
      scsi: core: Fix unremoved procfs host directory regression

Hamza Mahfooz (1):
      drm/amd/display: fix IPX enablement

Hangbin Liu (1):
      scripts/bpf_doc: Use silent mode when exec make cmd

Hari Bathini (1):
      bpf: fix warning for crash_kexec

Hariprasad Kelam (1):
      Octeontx2-af: fix pause frame configuration in GMP mode

Harry Wentland (1):
      Revert "drm/amd/display: Fix sending VSC (+ colorimetry) packets
for DP/eDP displays without PSR"

Heikki Krogerus (1):
      usb: dwc3: pci: Drop duplicate ID

Herve Codina (1):
      net: wan: framer: Add missing static inline qualifiers

Ido Schimmel (2):
      ipv6: Fix address dump when IPv6 is disabled on an interface
      selftests: vxlan_mdb: Fix failures with old libnet

Igor Artemiev (1):
      wifi: cfg80211: fix rdev_dump_mpp() arguments order

Ilan Peer (1):
      wifi: iwlwifi: mvm: Configure the link mapping for non-MLD FW

Ilya Leoshkevich (1):
      s390/bpf: Fix bpf_plt pointer arithmetic

Ingo Molnar (2):
      Documentation/x86: Fix title underline length
      Revert "x86/mm/ident_map: Use gbpages only where full GB page
should be mapped."

Isak Ellmer (1):
      kconfig: Fix typo HEIGTH to HEIGHT

Jakub Kicinski (2):
      tools: ynl: fix setting presence bits in simple nests
      selftests: netdevsim: set test timeout to 10 minutes

Jameson Thies (1):
      usb: typec: ucsi: Check capabilities before cable and identity discov=
ery

Jan Kara (1):
      nfsd: Fix error cleanup path in nfsd_rename()

Janusz Krzysztofik (2):
      drm/i915/hwmon: Fix locking inversion in sysfs getter
      drm/i915/vma: Fix UAF on destroy against retire race

Jason Gunthorpe (2):
      iommu/arm-smmu-v3: Add cpu_to_le64() around STRTAB_STE_0_V
      iommu: Validate the PASID in iommu_attach_device_pasid()

Jeff Johnson (1):
      wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc

Jesse Brandeburg (1):
      ice: fix memory corruption bug with suspend and rebuild

Jian Shen (1):
      net: hns3: mark unexcuted loopback test result as UNEXECUTED

Jie Wang (1):
      net: hns3: fix index limit to support all queue stats

Jocelyn Falempe (1):
      drm/vmwgfx: Create debugfs ttm_resource_manager entry only if needed

Johan Hovold (1):
      wifi: mac80211: fix mlme_link_id_dbg()

Johannes Berg (8):
      wifi: cfg80211: add a flag to disable wireless extensions
      wifi: iwlwifi: mvm: disable MLO for the time being
      wifi: mac80211: fix prep_connection error path
      wifi: iwlwifi: mvm: rfi: fix potential response leaks
      wifi: iwlwifi: fw: don't always use FW dump trig
      wifi: iwlwifi: read txq->read_ptr under lock
      wifi: iwlwifi: mvm: handle debugfs names more carefully
      kunit: fix wireless test dependencies

Johannes Thumshirn (3):
      btrfs: zoned: use zone aware sb location for scrub
      btrfs: zoned: fix use-after-free in do_zone_finish()
      btrfs: zoned: don't skip block groups with 100% zone unusable

Johannes Weiner (4):
      mm: cachestat: fix two shmem bugs
      mm: zswap: fix writeback shinker GFP_NOIO/GFP_NOFS recursion
      mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
      drm/amdgpu: fix deadlock while reading mqd from debugfs

John Garry (1):
      block: Make blk_rq_set_mixed_merge() static

John Ogness (1):
      printk: Update @console_may_schedule in console_trylock_spinning()

John Sperbeck (1):
      init: open /initrd.image with O_LARGEFILE

Jonathan Kim (1):
      drm/amdkfd: range check cp bad op exception interrupts

Jonathon Hall (1):
      drm/i915: Do not match JSL in ehl_combo_pll_div_frac_wa_needed()

Joonas Lahtinen (1):
      drm/i915: Add includes for BUG_ON/BUILD_BUG_ON in i915_memcpy.c

Jos=C3=A9 Roberto de Souza (1):
      drm/i915: Do not print 'pxp init failed with 0' when it succeed

Juha-Pekka Heikkila (1):
      drm/i915/display: Disable AuxCCS framebuffers if built for Xe

Justin Chen (2):
      net: bcmasp: Bring up unimac after PHY link up
      net: bcmasp: Remove phy_{suspend/resume}

Justin Stitt (1):
      binfmt: replace deprecated strncpy

Justin Tee (12):
      scsi: lpfc: Remove unnecessary log message in queuecommand path
      scsi: lpfc: Move NPIV's transport unregistration to after
resource clean up
      scsi: lpfc: Remove IRQF_ONESHOT flag from threaded IRQ handling
      scsi: lpfc: Update lpfc_ramp_down_queue_handler() logic
      scsi: lpfc: Replace hbalock with ndlp lock in lpfc_nvme_unregister_po=
rt()
      scsi: lpfc: Release hbalock before calling lpfc_worker_wake_up()
      scsi: lpfc: Use a dedicated lock for ras_fwlog state
      scsi: lpfc: Define lpfc_nodelist type for ctx_ndlp ptr
      scsi: lpfc: Define lpfc_dmabuf type for ctx_buf ptr
      scsi: lpfc: Define types in a union for generic void *context3 ptr
      scsi: lpfc: Update lpfc version to 14.4.0.1
      scsi: lpfc: Copyright updates for 14.4.0.1 patches

Kees Cook (2):
      selftests/exec: execveat: Improve debug reporting
      selftests/exec: Convert remaining /bin/sh to /bin/bash

Ken Raeburn (1):
      dm vdo murmurhash3: use kernel byteswapping routines instead of GCC o=
nes

Kevin Loughlin (1):
      x86/sev: Skip ROM range scans and validation for SEV-SNP guests

Krishna Kurapati (1):
      usb: typec: ucsi: Fix race between typec_switch and role_switch

Kuan-Wei Chiu (2):
      MAINTAINERS: remove incorrect M: tag for dm-devel@lists.linux.dev
      MAINTAINERS: Remove incorrect M: tag for dm-devel@lists.linux.dev

Kuniyuki Iwashima (1):
      netfilter: arptables: Select NETFILTER_FAMILY_ARP when building
arp_tables.c

Kurt Kanzenbach (1):
      igc: Remove stale comment about Tx timestamping

Kyle Tso (3):
      usb: typec: tcpm: Correct port source pdo array in pd_set callback
      usb: typec: tcpm: Update PD of Type-C port upon pd_set
      usb: typec: Return size of buffer if pd_set operation succeeds

Lang Yu (2):
      drm/amdgpu/umsch: update UMSCH 4.0 FW interface
      drm/amdgpu: enable UMSCH 4.0.6

Leonard Crestez (1):
      mailmap: update entry for Leonard Crestez

Liming Sun (1):
      sdhci-of-dwcmshc: disable PM runtime in dwcmshc_remove()

Linus Torvalds (4):
      Fix memory leak in posix_clock_open()
      Fix build errors due to new UIO_MEM_DMA_COHERENT mess
      mm: clean up populate_vma_page_range() FOLL_* flag handling
      Linux 6.9-rc2

Lizhi Xu (1):
      fs/9p: fix uaf in in v9fs_stat2inode_dotl

Lokesh Gidra (1):
      userfaultfd: fix deadlock warning when locking src and dst VMAs

Luca Weiss (1):
      drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE

Lucas De Marchi (1):
      drm/xe: Fix END redefinition

Mario Limonciello (1):
      drm/amd: Flush GFXOFF requests in prepare stage

Mark Brown (2):
      gpiolib: Add stubs for GPIO lookup functions
      selftests/seccomp: Try to fit runtime of benchmark into timeout

Mark Rutland (1):
      selftests/ftrace: Fix event filter target_func selection

Masahiro Yamada (6):
      cxl: remove CONFIG_CXL_PMU entry in drivers/cxl/Kconfig
      MIPS: move unselectable FIT_IMAGE_FDT_EPM5 out of the "System type" c=
hoice
      kconfig: do not reparent the menu inside a choice block
      export.h: remove include/asm-generic/export.h
      modpost: do not make find_tosym() return NULL
      x86/build: Use obj-y to descend into arch/x86/virt/

Masami Hiramatsu (Google) (1):
      tracing: probes: Fix to zero initialize a local variable

Matt Bobrowski (1):
      bpf: update BPF LSM designated reviewer list

Matthew Auld (5):
      drm/xe/guc_submit: use jiffies for job timeout
      drm/xe/queue: fix engine_class bounds check
      drm/xe/device: fix XE_MAX_GT_PER_TILE check
      drm/xe/device: fix XE_MAX_TILES_PER_DEVICE check
      drm/xe/query: fix gt_id bounds check

Matthew Wilcox (Oracle) (1):
      mm: increase folio batch size

Max Filippov (1):
      exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Maxim Levitsky (1):
      i2c: i801: Fix a refactoring that broke a touchpad on Lenovo P1

Miguel Ojeda (2):
      drm/qxl: remove unused `count` variable from `qxl_surface_id_alloc()`
      drm/qxl: remove unused variable from `qxl_process_single_command()`

Mikko Rapeli (2):
      mmc: core: Initialize mmc_blk_ioc_data
      mmc: core: Avoid negative index with array access

Mikulas Patocka (1):
      objtool: Fix compile failure when using the x32 compiler

Minas Harutyunyan (5):
      usb: dwc2: host: Fix hibernation flow
      usb: dwc2: host: Fix remote wakeup from hibernation
      usb: dwc2: host: Fix ISOC flow in DDMA mode
      usb: dwc2: gadget: Fix exiting from clock gating
      usb: dwc2: gadget: LPM flow fix

Mostafa Saleh (1):
      iommu/arm-smmu-v3: Fix access for STE.SHCFG

Muhammad Usama Anjum (7):
      scsi: lpfc: Correct size for wqe for memset()
      scsi: lpfc: Correct size for cmdwqe/rspwqe for memset()
      selftests/exec: binfmt_script: Add the overall result line
according to TAP
      selftests/exec: load_address: conform test to TAP format output
      selftests/exec: recursion-depth: conform test to TAP format output
      selftests: mm: restore settings from only parent process
      selftests: dmabuf-heap: add config file for the test

Mukul Joshi (1):
      drm/amdkfd: Check cgroup when returning DMABuf info

Natanel Roizenman (1):
      drm/amd/display: Increase Z8 watermark times.

Nathan Chancellor (2):
      hexagon: vmlinux.lds.S: handle attributes section
      Documentation/llvm: Note s390 LLVM=3D1 support with LLVM 18.1.0 and n=
ewer

Neil Armstrong (1):
      Revert "drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE"

Nikita Kiryushin (1):
      ACPICA: debugger: check status of acpi_evaluate_object() in
acpi_db_walk_for_fields()

Nilesh Javali (1):
      scsi: qla2xxx: Update version to 10.02.09.200-k

Nirmoy Das (1):
      drm/xe: Remove unused xe_bo->props struct

Oliver Neukum (1):
      usb: cdc-wdm: close race between read and workqueue

Oscar Salvador (1):
      mm,page_owner: fix recursion

Pablo Neira Ayuso (3):
      netfilter: nf_tables: reject destroy command to remove basechain hook=
s
      netfilter: nf_tables: reject table flag and netdev basechain updates
      netfilter: nf_tables: skip netdev hook unregistration if table is dor=
mant

Paul E. McKenney (1):
      x86/nmi: Upgrade NMI backtrace stall checks & messages

Pavel Sakharov (1):
      dma-buf: Fix NULL pointer dereference in sanitycheck()

Peter Wang (1):
      scsi: ufs: core: Add config_scsi_dev vops comment

Peter Xu (1):
      mm/memory: fix missing pte marker for !page on pte zaps

Peyton Lee (1):
      drm/amdgpu/vpe: power on vpe when hw_init

Ping-Ke Shih (2):
      wifi: rtw89: coex: fix configuration for shared antenna for 8922A
      MAINTAINERS: wifi: add git tree for Realtek WiFi drivers

Prasad Pandit (1):
      dpll: indent DPLL option type by a tab

Przemek Kitszel (1):
      ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Pu Lehui (1):
      riscv, bpf: Fix kfunc parameters incompatibility between bpf and risc=
v abi

Puranjay Mohan (5):
      bpf: Temporarily disable atomic operations in BPF arena
      bpf, arm64: fix bug in BPF_LDX_MEMSX
      bpf: verifier: fix addr_space_cast from as(1) to as(0)
      selftests/bpf: verifier_arena: fix mmap address for arm64
      bpf: verifier: reject addr_space_cast insn without arena

Quentin Monnet (1):
      MAINTAINERS: Update email address for Quentin Monnet

Quinn Tran (6):
      scsi: qla2xxx: Prevent command send on chip reset
      scsi: qla2xxx: Fix N2N stuck connection
      scsi: qla2xxx: Split FCE|EFT trace control
      scsi: qla2xxx: NVME|FCP prefer flag not being honored
      scsi: qla2xxx: Fix command flush on cable pull
      scsi: qla2xxx: Delay I/O Abort on PCI error

Rafael J. Wysocki (1):
      genirq: Introduce IRQF_COND_ONESHOT and use it in pinctrl-amd

Raju Lakkaraju (1):
      net: lan743x: Add set RFE read fifo threshold for PCI1x1x chips

Ravi Gunasekaran (1):
      net: hsr: hsr_slave: Fix the promiscuous mode in offload mode

Ricardo B. Marliere (5):
      scsi: sg: Make sg_sysfs_class constant
      scsi: pmcraid: Make pmcraid_class constant
      scsi: cxlflash: Make cxlflash_class constant
      scsi: ch: Make ch_sysfs_class constant
      scsi: st: Make st_sysfs_class constant

Rohit Ner (1):
      scsi: ufs: core: Fix MCQ MAC configuration

Romain Naour (1):
      mmc: sdhci-omap: re-tuning is needed after a pm transition to
support emmc HS200 mode

Roman Li (1):
      drm/amd/display: Fix bounds check for dcn35 DcfClocks

Ryosuke Yasuoka (1):
      nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Sabrina Dubroca (4):
      tls: recv: process_rx_list shouldn't use an offset with kvec
      tls: adjust recv return with async crypto and failed copy to userspac=
e
      selftests: tls: add test with a partially invalid iov
      tls: get psock ref after taking rxlock to avoid leak

Sandeep Dhavale (1):
      MAINTAINERS: erofs: add myself as reviewer

Sandipan Das (4):
      x86/cpufeatures: Add new word for scattered features
      perf/x86/amd/lbr: Use freeze based on availability
      perf/x86/amd/core: Update and fix stalled-cycles-* events for
Zen 2 and later
      perf/x86/amd/core: Define a proper ref-cycles event for Zen 4 and lat=
er

Saurav Kashyap (4):
      scsi: qla2xxx: Fix double free of the ha->vp_map pointer
      scsi: qla2xxx: Fix double free of fcport
      scsi: qla2xxx: Change debug message during driver unload
      scsi: bnx2fc: Remove spin_lock_bh while releasing resources after upl=
oad

Sergey Shtylyov (1):
      MAINTAINERS: split Renesas Ethernet drivers entry

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: consider having one active link

Shin'ichiro Kawasaki (1):
      scsi: mpi3mr: Avoid memcpy field-spanning write WARNING

Simon Trimmer (2):
      ALSA: hda: cs35l56: Raise device name message log level
      ALSA: hda: cs35l56: Set the init_done flag before component_add()

Stanislav Fomichev (1):
      xsk: Don't assume metadata is always requested in TX completion

Steve French (1):
      smb3: add trace event for mknod

Steven Zou (1):
      ice: Refactor FW data type and fix bitmap casting issue

Sung Joon Kim (1):
      drm/amd/display: Update dcn351 to latest dcn35 config

Taimur Hassan (1):
      drm/amd/display: Send DTBCLK disable message on first commit

Tavian Barnes (1):
      btrfs: fix race in read_extent_buffer_pages()

Tejas Upadhyay (1):
      drm/i915/mtl: Update workaround 14018575942

Thinh Nguyen (1):
      usb: dwc3: Properly set system wakeup

Thomas Gleixner (1):
      MAINTAINERS: Add co-maintainers for time[rs]

Thomas Zimmermann (1):
      fbdev: Select I/O-memory framebuffer ops for SBus

Tom Zanussi (1):
      crypto: iaa - Fix nr_cpus < nr_iaa case

Uros Bizjak (1):
      x86/percpu: Disable named address spaces for KCSAN

Ville Syrj=C3=A4l=C3=A4 (6):
      drm/i915: Stop doing double audio enable/disable on SDVO and g4x+ DP
      drm/i915/dsi: Go back to the previous INIT_OTP/DISPLAY_ON order, most=
ly
      drm/i915/vrr: Generate VRR "safe window" for DSB
      drm/i915/dsb: Fix DSB vblank waits when using VRR
      drm/i915: Pre-populate the cursor physical dma address
      drm/i915/bios: Tolerate devdata=3D=3DNULL in
intel_bios_encoder_supports_dp_dual_mode()

Vitaly Chikunov (1):
      selftests/mm: Fix build with _FORTIFY_SOURCE

Vitaly Prosyak (1):
      drm/sched: fix null-ptr-deref in init entity

Weitao Wang (1):
      USB: UAS: return ENODEV when submit urbs fail with device not attache=
d

Wenjing Liu (1):
      drm/amd/display: fix a dereference of a NULL pointer

Xi Liu (2):
      drm/amd/display: increase bb clock for DCN351
      drm/amd/display: Set DCN351 BB and IP the same as DCN35

Xingui Yang (2):
      scsi: libsas: Add a helper sas_get_sas_addr_and_dev_type()
      scsi: libsas: Fix disk not being scanned in after being removed

Xu Yang (1):
      usb: typec: tcpm: fix double-free issue in tcpm_port_unregister_pd()

Yazen Ghannam (3):
      RAS/AMD/FMPM: Avoid NULL ptr deref in get_saved_records()
      RAS/AMD/FMPM: Safely handle saved records of various sizes
      RAS: Avoid build errors when CONFIG_DEBUG_FS=3Dn

Ye Zhang (1):
      thermal: devfreq_cooling: Fix perf state when calculate dfc res_util

Yonglong Liu (1):
      net: hns3: fix kernel crash when devlink reload during pf initializat=
ion

Yongzhi Liu (1):
      usb: misc: ljca: Fix double free in error handling path

Zev Weiss (2):
      prctl: generalize PR_SET_MDWE support check to be per-arch
      ARM: prctl: reject PR_SET_MDWE on pre-ARMv6

Zoltan HERPAI (1):
      pwm: img: fix pwm clock lookup

lima1002 (1):
      drm/amd/swsmu: add smu 14.0.1 vcn and jpeg msg

linke li (1):
      net: mark racy access on sk->sk_rcvbuf

yuan linyu (1):
      usb: udc: remove warning when queue disabled ep

