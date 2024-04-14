Return-Path: <linux-kernel+bounces-144402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1B18A4577
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4395280611
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDF9136660;
	Sun, 14 Apr 2024 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AtB3avKQ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A43D56D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713127754; cv=none; b=BK0tngT8kdYvlnzpkLc1Z9ylDaYru84RafopjKFhdpWrRV6bW4erGlOrQk8FQXjtwFAlAVXKuFOYPRSDQGYtfbvtkARri2kqdG1xd87dXEyhx3kzsxdDuJR2Il7Dp11VqLuHGUIci1PV57WOV+qyrPxhnWN7YZjtX/7odJ5Zdg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713127754; c=relaxed/simple;
	bh=IYJVOi2ZHWlHABNCAv6T+bqFApuqpKhSEOcJhjagiYE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UeoQqrk/QAlk6CUrITLwXiZmfxrnBYNeqJHmVm5g0FZ5pKTrXIihWu4IWw39ZqwjMJcRHTgps2XE9F5R/Bv0duLjEkQYWAK4MSbKnviAWP2419J8eX+/V/f5hkdpbwJjca4krnW9CjPZY+m+W+7t1xfV7Xl9WsKAENz3+AW74WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AtB3avKQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e6acb39d4so3123482a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713127749; x=1713732549; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yxyp1ywaX6pbTmqnyjTXrOLRciZfNwmwSl3h7niGpck=;
        b=AtB3avKQ51LQEZ5z0KT2OabYH7xC2aawYjhi0dJ77yrqeRTyyr2TZbe6Vy3iWZm1VL
         ygTQZrHr5FeDOyn17NMFrjt001LiSH0Jlt2YkJl9lV1R3wdeM0ZVv/XmgIGNLyp1z32i
         zR4kYA+UKnEUFhczFhE2GCE48sKyNEGjOmFig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713127749; x=1713732549;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxyp1ywaX6pbTmqnyjTXrOLRciZfNwmwSl3h7niGpck=;
        b=pGNf+t8Ppw9wG0CMKPXedqWOb/aFZdqFSvFk1VWv89/Mm1tmOaqLrcOKfzljvmlggW
         pdapc0K4zLmEYFfQ4J65I0MxtaV9wFtUgjuvZuipRz5BC+TrODEWb/P7dbWFT3avgCx4
         E0NBWwXAs9InepFyJB14//CYNvLD45Kh8WjaUTgwlEN+bNZ1s4Li/DbwIAjVey2GGStI
         42UH1NZqSRTuSjqg1qyzjaQUkbMQDFh1Iyx20NU8aJaHeCI29UZu0o1hsPLGFrhWiWC9
         Fuze7wWczqiDfAfDYxnuOxGaSyn2jJIOu/d6hMP6TGTDTlVtH1eUeEHSKLIJtWC43uzu
         GP3Q==
X-Gm-Message-State: AOJu0YyIyY03r+CPJVdl79i5CXxCNNBE/n/7CeEOJ91VeV4tE8NgzV0E
	+X0xZcEMvhl/P3XAipnwj+RGaDp76pcctgakQjCp1nj+ecPwELKYidO6plW3zp2opyNx1rtMoU/
	BKz8=
X-Google-Smtp-Source: AGHT+IHJCeChl1qmppiKXdtLGVpXsOnzALnPVwCBPudOysIyn3EH1dxzRuRBGdyU/vfJyyAC/io88Q==
X-Received: by 2002:a17:906:3416:b0:a52:5487:1dce with SMTP id c22-20020a170906341600b00a5254871dcemr1911658ejb.28.1713127749123;
        Sun, 14 Apr 2024 13:49:09 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709063a9800b00a5268203c85sm734361ejd.107.2024.04.14.13.49.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 13:49:08 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a44ad785a44so290796066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 13:49:08 -0700 (PDT)
X-Received: by 2002:a17:907:9495:b0:a52:3efe:9208 with SMTP id
 dm21-20020a170907949500b00a523efe9208mr4892570ejc.55.1713127747762; Sun, 14
 Apr 2024 13:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 14 Apr 2024 13:48:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdUP62_7N6s837tTFjvmcGxyRnMGwnVnZwn2fDVf5E8A@mail.gmail.com>
Message-ID: <CAHk-=whdUP62_7N6s837tTFjvmcGxyRnMGwnVnZwn2fDVf5E8A@mail.gmail.com>
Subject: Linux 6.9-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nothing particularly unusual going on this week - some new hw
mitigations may stand out, but after a decade of this I can't really
call it "unusual" any more, can I? We also had a bit more bcachefs
fixes, and a turbostat tool update, but other than that it's the
regular drop of random stuff all over.

Drivers end up being the bulk of the remaining stuff, and we still had
some timer fallout from the big timer updates this merge window.
Nothing else really strikes me, but the foll shortlog is appended as
usual - easy enough to just scan through to get kind of a flavor of
what has been going on.

                Linus

---

Aaro Koskinen (6):
      ARM: OMAP2+: fix bogus MMC GPIO labels on Nokia N8x0
      ARM: OMAP2+: fix N810 MMC gpiod table
      mmc: omap: fix broken slot switch lookup
      mmc: omap: fix deferred probe
      mmc: omap: restore original power up/down steps
      ARM: OMAP2+: fix USB regression on Nokia N8x0

Abhinav Kumar (1):
      drm/msm/dp: fix typo in dp_display_handle_port_status_changed()

Adam Dunlap (1):
      x86/apic: Force native_apic_mem_read() to use the MOV instruction

Adrian Hunter (1):
      bug: Fix no-return-statement warning with !CONFIG_BUG

Alex Constantino (1):
      Revert "drm/qxl: simplify qxl_fence_wait"

Alex Deucher (1):
      drm/amdgpu: always force full reset for SOC21

Alex Hung (2):
      drm/amd/display: Skip on writeback when it's not applicable
      drm/amd/display: Return max resolution supported by DWB

Alexander Wetzel (1):
      scsi: sg: Avoid race in error handling & drop bogus warn

Alexey Izbyshev (1):
      io_uring: Fix io_cqring_wait() not restoring sigmask on
get_timespec64() failure

Amir Goldstein (1):
      kernfs: annotate different lockdep class for of->mutex of writable fi=
les

Anna-Maria Behnsen (1):
      PM: s2idle: Make sure CPUs will wakeup directly on resume

Archie Pusaka (1):
      Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNECTED bit

Ard Biesheuvel (1):
      gcc-plugins/stackleak: Avoid .head.text section

Arnd Bergmann (8):
      ubsan: fix unused variable warning in test module
      nouveau: fix function cast warning
      lib: checksum: hide unused expected_csum_ipv6_magic[]
      irqflags: Explicitly ignore lockdep_hrtimer_exit() argument
      ipv6: fib: hide unused 'pn' variable
      ipv4/route: avoid unused-but-set-variable warning
      net/mlx5: fix possible stack overflows
      tracing: hide unused ftrace_event_id_fops

Ar=C4=B1n=C3=A7 =C3=9CNAL (2):
      net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards
      net: dsa: mt7530: trap link-local frames regardless of ST Port State

Ashutosh Dixit (1):
      drm/xe: Label RING_CONTEXT_CONTROL as masked

Bagas Sanjaya (2):
      Documentation: filesystems: Add bcachefs toctree
      MAINTAINERS: Add entry for bcachefs documentation

Bernhard Rosenkr=C3=A4nzer (1):
      platform/x86: acer-wmi: Add support for Acer PH18-71

Bjorn Helgaas (1):
      Revert "PCI: Mark LSI FW643 to avoid bus reset"

Boris Brezillon (1):
      drm/panfrost: Fix the error path in panfrost_mmu_map_fault_addr()

Boris Burkov (6):
      btrfs: qgroup: correctly model root qgroup rsv in convert
      btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume operations
      btrfs: record delayed inode root in transaction
      btrfs: qgroup: convert PREALLOC to PERTRANS after record_root_in_tran=
s
      btrfs: make btrfs_clear_delalloc_extent() free delalloc reserve
      btrfs: always clear PERTRANS metadata during commit

Breno Leitao (1):
      virtio_net: Do not send RSS key if it is not supported

Brett Creeley (1):
      pds_core: Fix pdsc_check_pci_health function to use work thread

Carolina Jubran (4):
      net/mlx5e: RSS, Block changing channels number when RXFH is configure=
d
      net/mlx5e: Fix mlx5e_priv_init() cleanup flow
      net/mlx5e: HTB, Fix inconsistencies with QoS SQs number
      net/mlx5e: RSS, Block XOR hash with over 128 channels

Chen Yu (1):
      tools/power turbostat: Do not print negative LPI residency

Cosmin Ratiu (2):
      net/mlx5: Properly link new fs rules into the tree
      net/mlx5: Correctly compare pkt reformat ids

Cristian Marussi (1):
      firmware: arm_scmi: Make raw debugfs entries non-seekable

Damien Le Moal (2):
      ata: ahci: Add mask_port_map module parameter
      ata: libata-scsi: Fix ata_scsi_dev_rescan() error path

Dan Carpenter (2):
      bcachefs: fix ! vs ~ typo in __clear_bit_le64()
      scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()

Daniel Machon (1):
      net: sparx5: fix wrong config being used when reconfiguring PCS

Daniel Sneddon (3):
      x86/bhi: Define SPEC_CTRL_BHI_DIS_S
      KVM: x86: Add BHI_NO
      x86/bugs: Fix return type of spectre_bhi_state()

Dave Airlie (2):
      nouveau: fix devinit paths to only handle display on GSP.
      amdkfd: use calloc instead of kzalloc to avoid integer overflow

Dave Jiang (6):
      cxl/core/regs: Fix usage of map->reg_type in
cxl_decode_regblock() before assigned
      cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
      cxl: Fix retrieving of access_coordinates in PCIe path
      cxl: Fix incorrect region perf data calculation
      cxl: Consolidate dport access_coordinate ->hb_coord and
->sw_coord into ->coord
      cxl: Add checks to access_coordinate calculation to fail missing data

David Arinzon (4):
      net: ena: Fix potential sign extension issue
      net: ena: Wrong missing IO completions check order
      net: ena: Fix incorrect descriptor free behavior
      net: ena: Set tx_info->xdpf value to NULL

David McFarland (1):
      platform/x86/intel/hid: Don't wake on 5-button releases

Dexuan Cui (1):
      swiotlb: do not set total_used to 0 in swiotlb_create_debugfs_files()

Dillon Varone (1):
      drm/amd/display: Do not recursively call manual trigger programming

Dmitry Antipov (1):
      Bluetooth: Fix memory leak in hci_req_sync_complete()

Dmitry Baryshkov (3):
      drm/msm/dpu: don't allow overriding data from catalog
      drm/msm/dpu: make error messages at
dpu_core_irq_register_callback() more sensible
      dt-bindings: display/msm: sm8150-mdss: add DP node

Doug Smythies (1):
      tools/power turbostat: Fix added raw MSR output

Eric Dumazet (6):
      xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING
      geneve: fix header validation in geneve[6]_xmit_skb
      net: add copy_safe_from_sockptr() helper
      mISDN: fix MISDN_TIME_STAMP handling
      nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
      netfilter: complete validation of user input

Erni Sri Satya Vennela (1):
      x86/hyperv: Cosmetic changes for hv_apic.c

Fabio Estevam (2):
      ARM: dts: imx7-mba7: Use 'no-mmc' property
      ARM: dts: imx7s-warp: Pass OV2680 link-frequencies

Frank Li (8):
      arm64: dts: imx8-ss-conn: fix usdhc wrong lpcg clock order
      arm64: dts: imx8-ss-lsio: fix pwm lpcg indices
      arm64: dts: imx8-ss-conn: fix usb lpcg indices
      arm64: dts: imx8-ss-dma: fix spi lpcg indices
      arm64: dts: imx8-ss-dma: fix pwm lpcg indices
      arm64: dts: imx8-ss-dma: fix adc lpcg indices
      arm64: dts: imx8-ss-dma: fix can lpcg indices
      arm64: dts: imx8qm-ss-dma: fix can lpcg indices

Fudongwang (1):
      drm/amd/display: fix disable otg wa logic in DCN316

Gavin Shan (3):
      vhost: Add smp_rmb() in vhost_vq_avail_empty()
      vhost: Add smp_rmb() in vhost_enable_notify()
      arm64: tlb: Fix TLBI RANGE operand

Geetha sowjanya (1):
      octeontx2-af: Fix NIX SQ mode and BP config

Gerd Bayer (2):
      s390/ism: fix receive message buffer allocation
      Revert "s390/ism: fix receive message buffer allocation"

Gergo Koteles (1):
      platform/x86: lg-laptop: fix %s null argument warning

Gwendal Grignou (2):
      platform/x86: intel-vbtn: Use acpi_has_method to check for switch
      platform/x86: intel-vbtn: Update tablet mode switch at end of probe

Haiyue Wang (1):
      io-uring: correct typo in comment for IOU_F_TWQ_LAZY_WAKE

Hans de Goede (2):
      ACPI: scan: Do not increase dep_unmet for already met dependencies
      platform/x86: toshiba_acpi: Silence logging for some events

Hariprasad Kelam (1):
      octeontx2-pf: Fix transmit scheduler resource leak

Harish Kasiviswanathan (1):
      drm/amdkfd: Reset GPU on queue preemption failure

Harry Wentland (2):
      drm/amd/display: Program VSC SDP colorimetry for all DP sinks >=3D 1.=
4
      drm/amd/display: Set VSC SDP Colorimetry same way for MST and SST

Heiner Kallweit (2):
      r8169: fix LED-related deadlock on module removal
      r8169: add missing conditional compiling for call to r8169_remove_led=
s

Himal Prasad Ghimiray (1):
      drm/xe/xe_migrate: Cast to output precision before multiplying operan=
ds

Hongbo Li (1):
      bcachefs: fix the count of nr_freed_pcpu after changing
bc->freed_nonpcpu list

Huacai Chen (7):
      mm: Move lowmem_page_address() a little later
      LoongArch: Make {virt, phys, page, pfn} translation work with KFENCE
      LoongArch: Make virt_addr_valid()/__virt_addr_valid() work with KFENC=
E
      LoongArch: Update dts for Loongson-2K1000 to support ISA/LPC
      LoongArch: Update dts for Loongson-2K2000 to support ISA/LPC
      LoongArch: Update dts for Loongson-2K2000 to support PCI-MSI
      LoongArch: Update dts for Loongson-2K2000 to support GMAC/GNET

Igor Pylypiv (1):
      ata: libata-core: Allow command duration limits detection for ACS-4 d=
rives

Ilya Maximets (1):
      net: openvswitch: fix unwanted error log on timeout policy probing

Ingo Molnar (1):
      x86/bugs: Rename various 'ia32_cap' variables to 'x86_arch_cap_msr'

Irui Wang (1):
      media: mediatek: vcodec: Handle VP9 superframe bitstream with 8 sub-f=
rames

Jacek Lawrynowicz (5):
      accel/ivpu: Remove d3hot_after_power_off WA
      accel/ivpu: Put NPU back to D3hot after failed resume
      accel/ivpu: Return max freq for DRM_IVPU_PARAM_CORE_CLOCK_RATE
      accel/ivpu: Fix missed error message after VPU rename
      accel/ivpu: Fix deadlock in context_xa

Jacob Pan (1):
      iommu/vt-d: Allocate local memory for page request queue

Jammy Huang (1):
      drm/ast: Fix soft lockup

Jeff Layton (1):
      MAINTAINERS: remove myself as a Reviewer for Ceph

Jens Wiklander (1):
      firmware: arm_ffa: Fix the partition ID check in
ffa_notification_info_get()

Jiaxun Yang (1):
      MIPS: scall: Save thread_info.syscall unconditionally on entry

Jiri Benc (1):
      ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr

Johan Hovold (2):
      drm/msm/dp: fix runtime PM leak on disconnect
      drm/msm/dp: fix runtime PM leak on connect failure

John Harrison (1):
      drm/i915/guc: Fix the fix for reset lock confusion

John Stultz (3):
      selftests: timers: Fix valid-adjtimex signed left-shift undefined beh=
avior
      selftests: timers: Fix posix_timers ksft_print_msg() warning
      selftests: timers: Fix abs() warning in posix_timers test

Josh Poimboeuf (7):
      x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file
      x86/bugs: Fix BHI documentation
      x86/bugs: Cache the value of MSR_IA32_ARCH_CAPABILITIES
      x86/bugs: Fix BHI handling of RRSBA
      x86/bugs: Clarify that syscall hardening isn't a BHI mitigation
      x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=3Dauto
      x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with
CONFIG_MITIGATION_SPECTRE_BHI

Justin Ernst (1):
      tools/power/turbostat: Fix uncore frequency file string

Karthik Poosa (1):
      drm/xe/hwmon: Cast result to output precision on left shift of operan=
d

Kees Cook (2):
      randomize_kstack: Improve entropy diffusion
      nouveau/gsp: Avoid addressing beyond end of rpc->entries

Kenneth Feng (1):
      drm/amd/pm: fix the high voltage issue after unload

Kent Overstreet (19):
      bcachefs: Make snapshot_is_ancestor() safe
      bcachefs: Bump limit in btree_trans_too_many_iters()
      bcachefs: Move btree_updates to debugfs
      bcachefs: Further improve btree_update_to_text()
      bcachefs: Print shutdown journal sequence number
      bcachefs: Fix rebalance from durability=3D0 device
      bcachefs: fix rand_delete unit test
      bcachefs: Fix BCH_IOCTL_FSCK_OFFLINE for encrypted filesystems
      bcachefs: Disable errors=3Dpanic for BCH_IOCTL_FSCK_OFFLINE
      bcachefs: JOURNAL_SPACE_LOW
      bcachefs: Fix gap buffer bug in bch2_journal_key_insert_take()
      bcachefs: fix bch2_get_acl() transaction restart handling
      bcachefs: fix eytzinger0_find_gt()
      bcachefs: Fix check_topology() when using node scan
      bcachefs: Don't scan for btree nodes when we can reconstruct
      bcachefs: btree_node_scan: Respect member.data_allowed
      bcachefs: Fix a race in btree_update_nodes_written()
      bcachefs: Kill read lock dropping in bch2_btree_node_lock_write_nofai=
l()
      bcachefs: Fix __bch2_btree_and_journal_iter_init_node_iter()

Krzysztof Kozlowski (3):
      virtio: store owner from modules with register_virtio_driver()
      MAINTAINERS: Change Krzysztof Kozlowski's email address
      iommu: mtk: fix module autoloading

Kuniyuki Iwashima (1):
      af_unix: Clear stale u->oob_skb.

Kuogee Hsieh (1):
      drm/msm/dp: assign correct DP controller ID to x1e80100 interface tab=
le

Kwangjin Ko (1):
      cxl/core: Fix initialization of mbox_cmd.size_out in get event

Lang Yu (1):
      drm/amdgpu/umsch: reinitialize write pointer in hw init

Len Brown (4):
      tools/power turbostat: Expand probe_intel_uncore_frequency()
      tools/power turbostat: Fix warning upon failed /dev/cpu_dma_latency r=
ead
      tools/power turbostat: enhance -D (debug counter dump) output
      tools/power turbostat: v2024.04.10

Li Ma (1):
      drm/amd/display: add DCN 351 version for microcode load

Li Zhijian (1):
      hv: vmbus: Convert sprintf() family to sysfs_emit() family

Lijo Lazar (3):
      drm/amdgpu: Refine IB schedule error logging
      drm/amdgpu: Reset dGPU if suspend got aborted
      drm/amdgpu: Fix VCN allocation in CPX partition

Linus Torvalds (3):
      x86/syscall: Don't force use of indirect calls for system calls
      Kconfig: add some hidden tabs on purpose
      Linux 6.9-rc4

Lu Baolu (1):
      iommu/vt-d: Fix WARN_ON in iommu probe path

Luca Weiss (1):
      drm/msm/adreno: Set highest_bank_bit for A619

Lucas De Marchi (1):
      drm/xe/display: Fix double mutex initialization

Luiz Augusto von Dentz (7):
      Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset
      Bluetooth: hci_sync: Fix using the same interval and window for Coded=
 PHY
      Bluetooth: SCO: Fix not validating setsockopt user input
      Bluetooth: RFCOMM: Fix not validating setsockopt user input
      Bluetooth: L2CAP: Fix not validating setsockopt user input
      Bluetooth: ISO: Fix not validating setsockopt user input
      Bluetooth: hci_sock: Fix not validating setsockopt user input

Manivannan Sadhasivam (1):
      MAINTAINERS: Drop Gustavo Pimentel as PCI DWC Maintainer

Marek Vasut (2):
      net: ks8851: Inline ks8851_rx_skb()
      net: ks8851: Handle softirqs at the end of IRQ thread to fix hang

Masami Hiramatsu (1):
      fs/proc: Skip bootloader comment if no embedded kernel parameters

Maurizio Lombardi (1):
      scsi: target: Fix SELinux error when systemd-modules loads the
target module

Michael Kelley (2):
      swiotlb: fix swiotlb_bounce() to do partial sync's correctly
      Drivers: hv: vmbus: Don't free ring buffers that couldn't be re-encry=
pted

Michael Liang (1):
      net/mlx5: offset comp irq index in name by one

Michael S. Tsirkin (1):
      vhost-vdpa: change ioctl # for VDPA_GET_VRING_SIZE

Michal Luczaj (1):
      af_unix: Fix garbage collector racing against connect()

Miguel Ojeda (1):
      drm/msm: fix the `CRASHDUMP_READ` target of `a6xx_get_shader_block()`

Minda Chen (2):
      net: stmmac: mmc_core: Add GMAC LPI statistics
      net: stmmac: mmc_core: Add GMAC mmc tx/rx missing statistics

Ming Lei (2):
      block: fix q->blkg_list corruption during disk rebind
      block: allow device to have both virt_boundary_mask and max segment s=
ize

Namhyung Kim (1):
      perf/x86: Fix out of range data

Nathan Chancellor (1):
      selftests: kselftest: Mark functions that unconditionally call
exit() as __noreturn

NeilBrown (1):
      ceph: redirty page before returning AOP_WRITEPAGE_ACTIVATE

Nianyao Tang (1):
      irqchip/gic-v3-its: Fix VSYNC referencing an unmapped VPE on GIC v4.1

Nicolas Dufresne (1):
      media: mediatek: vcodec: Fix oops when HEVC init fails

Noah Loomans (1):
      platform/chrome: cros_ec_uart: properly fix race condition

Nuno Das Neves (1):
      mshyperv: Introduce hv_numa_node_to_pxm_info()

Oleg Nesterov (2):
      selftests/timers/posix_timers: Reimplement check_timer_distribution()
      selftests: kselftest: Fix build failure with NOLIBC

Patryk Wlazlyn (11):
      tools/power turbostat: Print ucode revision only if valid
      tools/power turbostat: Read base_hz and bclk from CPUID.16H if availa=
ble
      tools/power turbostat: Add --no-msr option
      tools/power turbostat: Add --no-perf option
      tools/power turbostat: Add reading aperf and mperf via perf API
      tools/power turbostat: detect and disable unavailable BICs at runtime
      tools/power turbostat: add early exits for permission checks
      tools/power turbostat: Clear added counters when in no-msr mode
      tools/power turbostat: Add proper re-initialization for perf
file descriptors
      tools/power turbostat: read RAPL counters via perf
      tools/power turbostat: Add selftests

Paulo Alcantara (2):
      smb: client: fix NULL ptr deref in
cifs_mark_open_handles_for_deleted_file()
      smb: client: instantiate when creating SFU files

Pavan Chebbi (1):
      bnxt_en: Reset PTP tx_avail after possible firmware reset

Pavel Begunkov (1):
      io_uring/net: restore msg_control on sendzc retry

Pawan Gupta (4):
      x86/bhi: Add support for clearing branch history at syscall entry
      x86/bhi: Enumerate Branch History Injection (BHI) bug
      x86/bhi: Add BHI mitigation knob
      x86/bhi: Mitigate KVM by default

Peng Liu (1):
      tools/power turbostat: Fix Bzy_MHz documentation typo

Petr Tesarik (2):
      swiotlb: extend buffer pre-padding to alloc_align_mask if necessary
      u64_stats: fix u64_stats_init() for lockdep when used repeatedly
in one file

Pierre Gondois (1):
      firmware: arm_scmi: Fix wrong fastchannel initialization

Prasad Pandit (1):
      tracing: Fix FTRACE_RECORD_RECURSION_SIZE Kconfig entry

Raag Jadav (1):
      ACPI: bus: allow _UID matching for integer zero

Rahul Rameshbabu (1):
      net/mlx5e: Do not produce metadata freelist entries in Tx port ts WQE=
 xmit

Randy Dunlap (1):
      LoongArch: Include linux/sizes.h in addrspace.h to prevent build erro=
rs

Rick Edgecombe (4):
      Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails
      Drivers: hv: vmbus: Track decrypted status in vmbus_gpadl
      hv_netvsc: Don't free decrypted memory
      uio_hv_generic: Don't free decrypted memory

Rik van Riel (1):
      blk-iocost: avoid out of bounds shift

Samuel Holland (1):
      cache: sifive_ccache: Partially convert to a platform driver

Sean Christopherson (1):
      x86/cpu: Actually turn off mitigations by default for
SPECULATION_MITIGATIONS=3Dn

Sebastian Andrzej Siewior (1):
      locking: Make rwsem_assert_held_write_nolockdep() build with PREEMPT_=
RT=3Dy

Shay Drory (2):
      net/mlx5: E-switch, store eswitch pointer before registering devlink_=
param
      net/mlx5: Register devlink first under devlink lock

Shradha Gupta (1):
      hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for keyfile format

Stephen Boyd (1):
      drm/msm: Add newlines to some debug prints

Steve French (2):
      smb3: fix Open files on server counter going negative
      smb3: fix broken reconnect when password changing on the server
by allowing password rotation

Steven Rostedt (Google) (1):
      ring-buffer: Only update pages_touched when a new page is touched

Sumeet Pawnikar (1):
      platform/x86/intel/hid: Add Lunar Lake and Arrow Lake support

Suraj Kandpal (1):
      drm/i915/hdcp: Fix get remote hdcp capability function

Sven Eckelmann (1):
      batman-adv: Avoid infinite loop trying to resize local TT

Tao Zhou (1):
      drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2

Tariq Toukan (1):
      net/mlx5: Disallow SRIOV switchdev mode when in multi-PF netdev

Thierry Reding (1):
      gpu: host1x: Do not setup DMA for virtual devices

Thomas Bertschinger (1):
      bcachefs: create debugfs dir for each btree

Thomas Gleixner (5):
      timekeeping: Use READ/WRITE_ONCE() for tick_do_timer_cpu
      x86/topology: Don't update cpu_possible_map in topo_set_cpuids()
      x86/cpu/amd: Make the CPUID 0x80000008 parser correct
      x86/cpu/amd: Make the NODEID_MSR union actually work
      x86/cpu/amd: Move TOPOEXT enablement into the topology parser

Thorsten Blum (3):
      bcachefs: Rename struct field swap to prevent macro naming collision
      compiler.h: Add missing quote in macro comment
      zonefs: Use str_plural() to fix Coccinelle warning

Tim Harvey (2):
      arm64: dts: freescale: imx8mp-venice-gw72xx-2x: fix USB vbus regulato=
r
      arm64: dts: freescale: imx8mp-venice-gw73xx-2x: fix USB vbus regulato=
r

Tim Huang (2):
      drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11
      drm/amdgpu: fix incorrect number of active RBs for gfx11

Uwe Kleine-K=C3=B6nig (1):
      MAINTAINERS: Drop Li Yang as their email address stopped working

Vasant Hegde (3):
      iommu/amd: Fix possible irq lock inversion dependency issue
      iommu/amd: Do not enable SNP when V2 page table is enabled
      iommu/amd: Change log message severity

Vikas Gupta (2):
      bnxt_en: Fix possible memory leak in bnxt_rdma_aux_device_init()
      bnxt_en: Fix error recovery for RoCE ulp client

Ville Syrj=C3=A4l=C3=A4 (7):
      drm/client: Fully protect modes[] with dev->mode_config.mutex
      drm/i915/cdclk: Fix CDCLK programming order when pipes are active
      drm/i915/cdclk: Fix voltage_level programming edge case
      drm/i915/psr: Disable PSR when bigjoiner is used
      drm/i915: Disable port sync when bigjoiner is used
      drm/i915: Disable live M/N updates when using bigjoiner
      drm/i915/vrr: Disable VRR when using bigjoiner

Wachowski, Karol (3):
      accel/ivpu: Check return code of ipc->lock init
      accel/ivpu: Fix PCI D0 state entry in resume
      accel/ivpu: Improve clarity of MMU error messages

Wei Yang (3):
      memblock tests: fix undefined reference to `early_pfn_to_nid'
      memblock tests: fix undefined reference to `panic'
      memblock tests: fix undefined reference to `BIT'

Wenjing Liu (1):
      drm/amd/display: always reset ODM mode in context when adding first p=
lane

Wyes Karny (1):
      tools/power turbostat: Increase the limit for fd opened

Xiang Chen (2):
      scsi: hisi_sas: Handle the NCQ error returned by D2H frame
      scsi: hisi_sas: Modify the deadline for ata_wait_after_reset()

Xianting Tian (1):
      vhost: correct misleading printing information

Xiubo Li (1):
      ceph: switch to use cap_delay_lock for the unlink delay list

Xuchun Shang (1):
      iommu/vt-d: Fix wrong use of pasid config

Yang Li (1):
      eventfs: Fix kernel-doc comments to functions

Yifan Zhang (2):
      drm/amdgpu: add smu 14.0.1 discovery support
      drm/amdgpu: differentiate external rev id for gfx 11.5.0

Yu Kuai (2):
      raid1: fix use-after-free for original bio in raid1_write_request()
      block: fix that blk_time_get_ns() doesn't update time after schedule

Yunfei Dong (3):
      media: mediatek: vcodec: adding lock to protect decoder context list
      media: mediatek: vcodec: adding lock to protect encoder context list
      media: mediatek: vcodec: support 36 bits physical address

Yuquan Wang (1):
      cxl/mem: Fix for the index of Clear Event Record Handle

Zack Rusin (1):
      drm/vmwgfx: Enable DMA mappings with SEV

Zhang Rui (6):
      tools/power/turbostat: Enable MSR_CORE_C1_RES support for ICX
      tools/power/turbostat: Cache graphics sysfs path
      tools/power/turbostat: Unify graphics sysfs snapshots
      tools/power/turbostat: Introduce BIC_SAM_mc6/BIC_SAMMHz/BIC_SAMACTMHz
      tools/power/turbostat: Add support for new i915 sysfs knobs
      tools/power/turbostat: Add support for Xe sysfs knobs

ZhenGuo Yin (1):
      drm/amdgpu: clear set_q_mode_offs when VM changed

Zheng Yejian (1):
      kprobes: Fix possible use-after-free issue on kprobe registration

Zhenhua Huang (1):
      fs/proc: remove redundant comments from /proc/bootconfig

Zhigang Luo (1):
      amd/amdkfd: sync all devices to wait all processes being evicted

Zhongwei (1):
      drm/amd/display: Adjust dprefclk by down spread percentage.

lima1002 (1):
      drm/amd/swsmu: Update smu v14.0.0 headers to be 14.0.1 compatible

shaoyunl (2):
      drm/amdgpu : Add mes_log_enable to control mes log feature
      drm/amdgpu : Increase the mes log buffer size as per new MES FW versi=
on

