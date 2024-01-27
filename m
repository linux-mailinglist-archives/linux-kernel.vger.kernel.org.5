Return-Path: <linux-kernel+bounces-41355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEE683EF7B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C64C6B2286F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B741F2E40E;
	Sat, 27 Jan 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4CKNEs8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F412D620
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706380146; cv=none; b=RG0wa4tc3219rylG4vwRvg1g+nUDgFjlKeq3IROTvleVAWqdTcXqCSaTaMzEjrob/GAb3mpqDmtm/FYMHYZJSJBV69dLcujCORcJzeWn56Uc5kgZn7CxlfJ1EYKl9lQq6UnXDVYp5VnSB8JPkp4j8BaIj6w+e1uvIK+25KBSsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706380146; c=relaxed/simple;
	bh=dr0SXMe6exhVT16lW97oChNwKRQZt8mjQ96sLPJ4bCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NGN8e0oG4GF54inX1nVU3M6mrcMDohnVC2wt9Dujhzu6CnWemU2T51YofXUoaauJhVBVqmhYeKANfibgfNgF5HK0xWt6E/TcmZCK5NOGJsJsUbQ5wC29ZpT1TlvR9xYaLh+frDjrjxjQYl2di72hze81TFGxGWsbKSFJHE7AOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4CKNEs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2EAC433C7;
	Sat, 27 Jan 2024 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706380146;
	bh=dr0SXMe6exhVT16lW97oChNwKRQZt8mjQ96sLPJ4bCI=;
	h=Date:From:To:Cc:Subject:From;
	b=A4CKNEs8EtJ7h+PIO0kbw/++q/oTsxcYydi2h+TYFLQkluBeDlnQ5qDRHEagX9AGD
	 QFSiFwh1JBsKhYDZB7I51A+h9kE8oh+6zNqD+sOU04g22UUFoMCR1E3/ErQdsTf2Jx
	 eP2y3jpnfJUuaucHI/WtZhud81ZoKx9Crkk1HtBeiWVvRlzvvRex/CLEv+wcEVNXoZ
	 KOsjxgPbRTn9BVprZcokfQS1TmFO+B05sFFavjc+rzAKH/8BjCG+mYLKFY8WZpWHsd
	 eX7fAWBuLoJcQkjXaURIH2pUUCgEoebnJyfIFTpph+y5zbc4c/IjDZRXIvC1iAzsJE
	 B3qpLJFNGtFvg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0DF3740441; Sat, 27 Jan 2024 15:29:03 -0300 (-03)
Date: Sat, 27 Jan 2024 15:29:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Jing Zhang <jingzhangos@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Durrant <pdurrant@amazon.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync kvm headers with the kernel
 sources
Message-ID: <ZbVLbkngp4oq13qN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes in:

  a5d3df8ae13fada7 ("KVM: remove deprecated UAPIs")
  6d72283526090850 ("KVM x86/xen: add an override for PVCLOCK_TSC_STABLE_BIT")
  89ea60c2c7b5838b ("KVM: x86: Add support for "protected VMs" that can utilize private memory")
  8dd2eee9d526c30f ("KVM: x86/mmu: Handle page fault for private memory")
  a7800aa80ea4d535 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
  5a475554db1e476a ("KVM: Introduce per-page memory attributes")
  16f95f3b95caded2 ("KVM: Add KVM_EXIT_MEMORY_FAULT exit to report faults to userspace")
  bb58b90b1a8f753b ("KVM: Introduce KVM_SET_USER_MEMORY_REGION2")
  3f9cd0ca848413fd ("KVM: arm64: Allow userspace to get the writable masks for feature ID registers")

That automatically adds support for some new ioctls and remove a bunch
of deprecated ones.

This ends up making the new binary to forget about the deprecated one,
so when used in an older system it will not be able to resolve those
codes to strings.

  $ tools/perf/trace/beauty/kvm_ioctl.sh > before
  $ cp include/uapi/linux/kvm.h tools/include/uapi/linux/kvm.h
  $ tools/perf/trace/beauty/kvm_ioctl.sh > after
  $ diff -u before after
  --- before	2024-01-27 14:48:16.523014020 -0300
  +++ after	2024-01-27 14:48:24.183932866 -0300
  @@ -14,6 +14,7 @@
   	[0x46] = "SET_USER_MEMORY_REGION",
   	[0x47] = "SET_TSS_ADDR",
   	[0x48] = "SET_IDENTITY_MAP_ADDR",
  +	[0x49] = "SET_USER_MEMORY_REGION2",
   	[0x60] = "CREATE_IRQCHIP",
   	[0x61] = "IRQ_LINE",
   	[0x62] = "GET_IRQCHIP",
  @@ -22,14 +23,8 @@
   	[0x65] = "GET_PIT",
   	[0x66] = "SET_PIT",
   	[0x67] = "IRQ_LINE_STATUS",
  -	[0x69] = "ASSIGN_PCI_DEVICE",
   	[0x6a] = "SET_GSI_ROUTING",
  -	[0x70] = "ASSIGN_DEV_IRQ",
   	[0x71] = "REINJECT_CONTROL",
  -	[0x72] = "DEASSIGN_PCI_DEVICE",
  -	[0x73] = "ASSIGN_SET_MSIX_NR",
  -	[0x74] = "ASSIGN_SET_MSIX_ENTRY",
  -	[0x75] = "DEASSIGN_DEV_IRQ",
   	[0x76] = "IRQFD",
   	[0x77] = "CREATE_PIT2",
   	[0x78] = "SET_BOOT_CPU_ID",
  @@ -66,7 +61,6 @@
   	[0x9f] = "GET_VCPU_EVENTS",
   	[0xa0] = "SET_VCPU_EVENTS",
   	[0xa3] = "ENABLE_CAP",
  -	[0xa4] = "ASSIGN_SET_INTX_MASK",
   	[0xa5] = "SIGNAL_MSI",
   	[0xa6] = "GET_XCRS",
   	[0xa7] = "SET_XCRS",
  @@ -97,6 +91,8 @@
   	[0xcd] = "SET_SREGS2",
   	[0xce] = "GET_STATS_FD",
   	[0xd0] = "XEN_HVM_EVTCHN_SEND",
  +	[0xd2] = "SET_MEMORY_ATTRIBUTES",
  +	[0xd4] = "CREATE_GUEST_MEMFD",
   	[0xe0] = "CREATE_DEVICE",
   	[0xe1] = "SET_DEVICE_ATTR",
   	[0xe2] = "GET_DEVICE_ATTR",
  $

This silences these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
    diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chao Peng <chao.p.peng@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jing Zhang <jingzhangos@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Durrant <pdurrant@amazon.com>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h |   3 +
 tools/include/uapi/linux/kvm.h        | 140 +++++++++-----------------
 2 files changed, 53 insertions(+), 90 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 1a6a1f98794967d2..a448d0964fc06ebd 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -562,4 +562,7 @@ struct kvm_pmu_event_filter {
 /* x86-specific KVM_EXIT_HYPERCALL flags. */
 #define KVM_EXIT_HYPERCALL_LONG_MODE	BIT(0)
 
+#define KVM_X86_DEFAULT_VM	0
+#define KVM_X86_SW_PROTECTED_VM	1
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 211b86de35ac53f6..c3308536482bdb2b 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -16,76 +16,6 @@
 
 #define KVM_API_VERSION 12
 
-/* *** Deprecated interfaces *** */
-
-#define KVM_TRC_SHIFT           16
-
-#define KVM_TRC_ENTRYEXIT       (1 << KVM_TRC_SHIFT)
-#define KVM_TRC_HANDLER         (1 << (KVM_TRC_SHIFT + 1))
-
-#define KVM_TRC_VMENTRY         (KVM_TRC_ENTRYEXIT + 0x01)
-#define KVM_TRC_VMEXIT          (KVM_TRC_ENTRYEXIT + 0x02)
-#define KVM_TRC_PAGE_FAULT      (KVM_TRC_HANDLER + 0x01)
-
-#define KVM_TRC_HEAD_SIZE       12
-#define KVM_TRC_CYCLE_SIZE      8
-#define KVM_TRC_EXTRA_MAX       7
-
-#define KVM_TRC_INJ_VIRQ         (KVM_TRC_HANDLER + 0x02)
-#define KVM_TRC_REDELIVER_EVT    (KVM_TRC_HANDLER + 0x03)
-#define KVM_TRC_PEND_INTR        (KVM_TRC_HANDLER + 0x04)
-#define KVM_TRC_IO_READ          (KVM_TRC_HANDLER + 0x05)
-#define KVM_TRC_IO_WRITE         (KVM_TRC_HANDLER + 0x06)
-#define KVM_TRC_CR_READ          (KVM_TRC_HANDLER + 0x07)
-#define KVM_TRC_CR_WRITE         (KVM_TRC_HANDLER + 0x08)
-#define KVM_TRC_DR_READ          (KVM_TRC_HANDLER + 0x09)
-#define KVM_TRC_DR_WRITE         (KVM_TRC_HANDLER + 0x0A)
-#define KVM_TRC_MSR_READ         (KVM_TRC_HANDLER + 0x0B)
-#define KVM_TRC_MSR_WRITE        (KVM_TRC_HANDLER + 0x0C)
-#define KVM_TRC_CPUID            (KVM_TRC_HANDLER + 0x0D)
-#define KVM_TRC_INTR             (KVM_TRC_HANDLER + 0x0E)
-#define KVM_TRC_NMI              (KVM_TRC_HANDLER + 0x0F)
-#define KVM_TRC_VMMCALL          (KVM_TRC_HANDLER + 0x10)
-#define KVM_TRC_HLT              (KVM_TRC_HANDLER + 0x11)
-#define KVM_TRC_CLTS             (KVM_TRC_HANDLER + 0x12)
-#define KVM_TRC_LMSW             (KVM_TRC_HANDLER + 0x13)
-#define KVM_TRC_APIC_ACCESS      (KVM_TRC_HANDLER + 0x14)
-#define KVM_TRC_TDP_FAULT        (KVM_TRC_HANDLER + 0x15)
-#define KVM_TRC_GTLB_WRITE       (KVM_TRC_HANDLER + 0x16)
-#define KVM_TRC_STLB_WRITE       (KVM_TRC_HANDLER + 0x17)
-#define KVM_TRC_STLB_INVAL       (KVM_TRC_HANDLER + 0x18)
-#define KVM_TRC_PPC_INSTR        (KVM_TRC_HANDLER + 0x19)
-
-struct kvm_user_trace_setup {
-	__u32 buf_size;
-	__u32 buf_nr;
-};
-
-#define __KVM_DEPRECATED_MAIN_W_0x06 \
-	_IOW(KVMIO, 0x06, struct kvm_user_trace_setup)
-#define __KVM_DEPRECATED_MAIN_0x07 _IO(KVMIO, 0x07)
-#define __KVM_DEPRECATED_MAIN_0x08 _IO(KVMIO, 0x08)
-
-#define __KVM_DEPRECATED_VM_R_0x70 _IOR(KVMIO, 0x70, struct kvm_assigned_irq)
-
-struct kvm_breakpoint {
-	__u32 enabled;
-	__u32 padding;
-	__u64 address;
-};
-
-struct kvm_debug_guest {
-	__u32 enabled;
-	__u32 pad;
-	struct kvm_breakpoint breakpoints[4];
-	__u32 singlestep;
-};
-
-#define __KVM_DEPRECATED_VCPU_W_0x87 _IOW(KVMIO, 0x87, struct kvm_debug_guest)
-
-/* *** End of deprecated interfaces *** */
-
-
 /* for KVM_SET_USER_MEMORY_REGION */
 struct kvm_userspace_memory_region {
 	__u32 slot;
@@ -95,6 +25,19 @@ struct kvm_userspace_memory_region {
 	__u64 userspace_addr; /* start of the userspace allocated memory */
 };
 
+/* for KVM_SET_USER_MEMORY_REGION2 */
+struct kvm_userspace_memory_region2 {
+	__u32 slot;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size;
+	__u64 userspace_addr;
+	__u64 guest_memfd_offset;
+	__u32 guest_memfd;
+	__u32 pad1;
+	__u64 pad2[14];
+};
+
 /*
  * The bit 0 ~ bit 15 of kvm_userspace_memory_region::flags are visible for
  * userspace, other bits are reserved for kvm internal use which are defined
@@ -102,6 +45,7 @@ struct kvm_userspace_memory_region {
  */
 #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
 #define KVM_MEM_READONLY	(1UL << 1)
+#define KVM_MEM_GUEST_MEMFD	(1UL << 2)
 
 /* for KVM_IRQ_LINE */
 struct kvm_irq_level {
@@ -265,6 +209,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_RISCV_CSR        36
 #define KVM_EXIT_NOTIFY           37
 #define KVM_EXIT_LOONGARCH_IOCSR  38
+#define KVM_EXIT_MEMORY_FAULT     39
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -518,6 +463,13 @@ struct kvm_run {
 #define KVM_NOTIFY_CONTEXT_INVALID	(1 << 0)
 			__u32 flags;
 		} notify;
+		/* KVM_EXIT_MEMORY_FAULT */
+		struct {
+#define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
+			__u64 flags;
+			__u64 gpa;
+			__u64 size;
+		} memory_fault;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -945,9 +897,6 @@ struct kvm_ppc_resize_hpt {
  */
 #define KVM_GET_VCPU_MMAP_SIZE    _IO(KVMIO,   0x04) /* in bytes */
 #define KVM_GET_SUPPORTED_CPUID   _IOWR(KVMIO, 0x05, struct kvm_cpuid2)
-#define KVM_TRACE_ENABLE          __KVM_DEPRECATED_MAIN_W_0x06
-#define KVM_TRACE_PAUSE           __KVM_DEPRECATED_MAIN_0x07
-#define KVM_TRACE_DISABLE         __KVM_DEPRECATED_MAIN_0x08
 #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
 #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
@@ -1201,6 +1150,11 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE 228
 #define KVM_CAP_ARM_SUPPORTED_BLOCK_SIZES 229
 #define KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES 230
+#define KVM_CAP_USER_MEMORY2 231
+#define KVM_CAP_MEMORY_FAULT_INFO 232
+#define KVM_CAP_MEMORY_ATTRIBUTES 233
+#define KVM_CAP_GUEST_MEMFD 234
+#define KVM_CAP_VM_TYPES 235
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1291,6 +1245,7 @@ struct kvm_x86_mce {
 #define KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL	(1 << 4)
 #define KVM_XEN_HVM_CONFIG_EVTCHN_SEND		(1 << 5)
 #define KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG	(1 << 6)
+#define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE	(1 << 7)
 
 struct kvm_xen_hvm_config {
 	__u32 flags;
@@ -1483,6 +1438,8 @@ struct kvm_vfio_spapr_tce {
 					struct kvm_userspace_memory_region)
 #define KVM_SET_TSS_ADDR          _IO(KVMIO,   0x47)
 #define KVM_SET_IDENTITY_MAP_ADDR _IOW(KVMIO,  0x48, __u64)
+#define KVM_SET_USER_MEMORY_REGION2 _IOW(KVMIO, 0x49, \
+					 struct kvm_userspace_memory_region2)
 
 /* enable ucontrol for s390 */
 struct kvm_s390_ucas_mapping {
@@ -1507,20 +1464,8 @@ struct kvm_s390_ucas_mapping {
 			_IOW(KVMIO,  0x67, struct kvm_coalesced_mmio_zone)
 #define KVM_UNREGISTER_COALESCED_MMIO \
 			_IOW(KVMIO,  0x68, struct kvm_coalesced_mmio_zone)
-#define KVM_ASSIGN_PCI_DEVICE     _IOR(KVMIO,  0x69, \
-				       struct kvm_assigned_pci_dev)
 #define KVM_SET_GSI_ROUTING       _IOW(KVMIO,  0x6a, struct kvm_irq_routing)
-/* deprecated, replaced by KVM_ASSIGN_DEV_IRQ */
-#define KVM_ASSIGN_IRQ            __KVM_DEPRECATED_VM_R_0x70
-#define KVM_ASSIGN_DEV_IRQ        _IOW(KVMIO,  0x70, struct kvm_assigned_irq)
 #define KVM_REINJECT_CONTROL      _IO(KVMIO,   0x71)
-#define KVM_DEASSIGN_PCI_DEVICE   _IOW(KVMIO,  0x72, \
-				       struct kvm_assigned_pci_dev)
-#define KVM_ASSIGN_SET_MSIX_NR    _IOW(KVMIO,  0x73, \
-				       struct kvm_assigned_msix_nr)
-#define KVM_ASSIGN_SET_MSIX_ENTRY _IOW(KVMIO,  0x74, \
-				       struct kvm_assigned_msix_entry)
-#define KVM_DEASSIGN_DEV_IRQ      _IOW(KVMIO,  0x75, struct kvm_assigned_irq)
 #define KVM_IRQFD                 _IOW(KVMIO,  0x76, struct kvm_irqfd)
 #define KVM_CREATE_PIT2		  _IOW(KVMIO,  0x77, struct kvm_pit_config)
 #define KVM_SET_BOOT_CPU_ID       _IO(KVMIO,   0x78)
@@ -1537,9 +1482,6 @@ struct kvm_s390_ucas_mapping {
 *  KVM_CAP_VM_TSC_CONTROL to set defaults for a VM */
 #define KVM_SET_TSC_KHZ           _IO(KVMIO,  0xa2)
 #define KVM_GET_TSC_KHZ           _IO(KVMIO,  0xa3)
-/* Available with KVM_CAP_PCI_2_3 */
-#define KVM_ASSIGN_SET_INTX_MASK  _IOW(KVMIO,  0xa4, \
-				       struct kvm_assigned_pci_dev)
 /* Available with KVM_CAP_SIGNAL_MSI */
 #define KVM_SIGNAL_MSI            _IOW(KVMIO,  0xa5, struct kvm_msi)
 /* Available with KVM_CAP_PPC_GET_SMMU_INFO */
@@ -1592,8 +1534,6 @@ struct kvm_s390_ucas_mapping {
 #define KVM_SET_SREGS             _IOW(KVMIO,  0x84, struct kvm_sregs)
 #define KVM_TRANSLATE             _IOWR(KVMIO, 0x85, struct kvm_translation)
 #define KVM_INTERRUPT             _IOW(KVMIO,  0x86, struct kvm_interrupt)
-/* KVM_DEBUG_GUEST is no longer supported, use KVM_SET_GUEST_DEBUG instead */
-#define KVM_DEBUG_GUEST           __KVM_DEPRECATED_VCPU_W_0x87
 #define KVM_GET_MSRS              _IOWR(KVMIO, 0x88, struct kvm_msrs)
 #define KVM_SET_MSRS              _IOW(KVMIO,  0x89, struct kvm_msrs)
 #define KVM_SET_CPUID             _IOW(KVMIO,  0x8a, struct kvm_cpuid)
@@ -2267,4 +2207,24 @@ struct kvm_s390_zpci_op {
 /* flags for kvm_s390_zpci_op->u.reg_aen.flags */
 #define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
 
+/* Available with KVM_CAP_MEMORY_ATTRIBUTES */
+#define KVM_SET_MEMORY_ATTRIBUTES              _IOW(KVMIO,  0xd2, struct kvm_memory_attributes)
+
+struct kvm_memory_attributes {
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+};
+
+#define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+
+#define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
+
+struct kvm_create_guest_memfd {
+	__u64 size;
+	__u64 flags;
+	__u64 reserved[6];
+};
+
 #endif /* __LINUX_KVM_H */
-- 
2.43.0


