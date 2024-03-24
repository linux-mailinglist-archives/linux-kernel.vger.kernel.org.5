Return-Path: <linux-kernel+bounces-112731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE0887D8B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B741C20D4B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25BC1A5AC;
	Sun, 24 Mar 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z/9vfQ4D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UyhvoVj3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8E18EAF
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711296938; cv=none; b=FlLEt/s3wM2rcUGTvp67xVK7tEJfo27btzKrg/HEX54wjB2YstHUF1LbBQnHSV1KucFk2cQf+zM7P5os6Exwmhh4nQmKVEJtOw2jBGV1tFPoUDtNvuUML6khyGetd1LyjCC3IoVkoS6WI6IjKS99gbwLH7NZXDuy/NOf/KhH1IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711296938; c=relaxed/simple;
	bh=30uLfVISp80elDo5otS9LQH7OTSuIGjXZF+pTTCQ0Is=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=eGVAl0xqBJ6yfB8+dBFStY549lPrHhzDmzCO6NK1jX/Itt8EJdJWA5JnTaYgXgEIifPGUK4kGPPD/r1O0T5GA2pEZMo6kQAGVODIUc3qEgiOz8mEVkaEu7PSznvuHnhOXZk6i5l5SiiUlQbMjrWp8L12E75KQFQf9Hqmr4pACtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z/9vfQ4D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UyhvoVj3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711296934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=UhmVOlEIUWNnWrgD1dNd0ViiDE0Z7G09fEEWxFJqUBQ=;
	b=z/9vfQ4DqWQNaE0skGfHEmZSQSfuHntDTOAdQ4Xs2C+0L37U6aPXWGBG5A9MTX1Boe+dj1
	d7Lkb0hozf6EblC4ASjiGA5M8oWqA8MUta11KyKyAQUEy7Ips+3PhSCKg9WkBBp70efswo
	3a5NZLuDb2S3XvT5OYNRaZxkP+jnAdfwy+PWmSD+orNPL+KD7iZqsuZkcl57ga11/Ugt8F
	8JljOOLXzvwlzkHnOPF22nyPTBgiXaDoIoNUfHwGDlCgis0dfysmzOpKvrPc4/e4suQIzo
	B3HzYAl+j0M7KbLOczJ1Qd1MbtWxOQCtxcC3wLN3OABZaUpSmTY3eBdw+L8zqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711296934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=UhmVOlEIUWNnWrgD1dNd0ViiDE0Z7G09fEEWxFJqUBQ=;
	b=UyhvoVj3/o3tFW/zbuggGca9ORRaHL9o8gG24k6WE2TPXkmDwohXmFK7yA5wePvYwENKjS
	C4/CmQKWk6otYMBQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v6.9-rc1
References: <171129691660.2804823.9714349244324963954.tglx@xen13>
Message-ID: <171129691819.2804823.13323681878641552052.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Mar 2024 17:15:33 +0100 (CET)

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-=
03-24

up to:  9843231c9726: x86/boot/64: Move 5-level paging global variable assign=
ments back

A set of x86 fixes:

  - Ensure that the encryption mask at boot is properly propagated on
    5-level page tables, otherwise the PGD entry is incorrectly set to
    non-encrypted, which causes system crashes during boot.

  - Undo the deferred 5-level page table setup as it cannot work with
    memory encryption enabled.

  - Prevent inconsistent XFD state on CPU hotplug, where the MSR is reset
    to the default value but the cached variable is not, so subsequent
    comparisons might yield the wrong result and as a consequence the
    result prevents updating the MSR.

  - Register the local APIC address only once in the MPPARSE enumeration to
    prevent triggering the related WARN_ONs() in the APIC and topology code.

  - Handle the case where no APIC is found gracefully by registering a fake
    APIC in the topology code. That makes all related topology functions
    work correctly and does not affect the actual APIC driver code at all.

  - Don't evaluate logical IDs during early boot as the local APIC IDs are
    not yet enumerated and the invoked function returns an error
    code. Nothing requires the logical IDs before the final CPUID
    enumeration takes place, which happens after the enumeration.

  - Cure the fallout of the per CPU rework on UP which misplaced the
    copying of boot_cpu_data to per CPU data so that the final update to
    boot_cpu_data got lost which caused inconsistent state and boot
    crashes.

  - Use copy_from_kernel_nofault() in the kprobes setup as there is no
    guarantee that the address can be safely accessed.

  - Reorder struct members in struct saved_context to work around another
    kmemleak false positive

  - Remove the buggy code which tries to update the E820 kexec table for
    setup_data as that is never passed to the kexec kernel.

  - Update the resource control documentation to use the proper units.

  - Fix a Kconfig warning observed with tinyconfig

Thanks,

	tglx

------------------>
Adamos Ttofari (1):
      x86/fpu: Keep xfd_state in sync with MSR_IA32_XFD

Anton Altaparmakov (1):
      x86/pm: Work around false positive kmemleak report in msr_build_context=
()

Dave Young (1):
      x86/kexec: Do not update E820 kexec table for setup_data

Masahiro Yamada (1):
      x86/config: Fix warning for 'make ARCH=3Dx86_64 tinyconfig'

Masami Hiramatsu (Google) (1):
      kprobes/x86: Use copy_from_kernel_nofault() to read from unsafe address

Thomas Gleixner (4):
      x86/cpu: Ensure that CPU info updates are propagated on UP
      x86/topology: Don't evaluate logical IDs during early boot
      x86/topology: Handle the !APIC case gracefully
      x86/mpparse: Register APIC address only once

Tom Lendacky (2):
      x86/boot/64: Apply encryption mask to 5-level pagetable update
      x86/boot/64: Move 5-level paging global variable assignments back

Tony Luck (2):
      Documentation/x86: Document that resctrl bandwidth control units are MiB
      x86/cpu: Add model number for another Intel Arrow Lake mobile processor


 Documentation/arch/x86/resctrl.rst    |  8 ++++----
 arch/x86/configs/tiny.config          |  1 +
 arch/x86/include/asm/intel-family.h   |  1 +
 arch/x86/include/asm/suspend_32.h     | 10 +++++-----
 arch/x86/kernel/cpu/common.c          |  9 +++++++++
 arch/x86/kernel/cpu/topology.c        | 11 +++++++++++
 arch/x86/kernel/cpu/topology_common.c | 12 +++++++-----
 arch/x86/kernel/e820.c                | 17 +----------------
 arch/x86/kernel/fpu/xstate.c          |  5 +++--
 arch/x86/kernel/fpu/xstate.h          | 14 ++++++++++----
 arch/x86/kernel/head64.c              | 18 ++++++++----------
 arch/x86/kernel/kprobes/core.c        | 11 ++++++++++-
 arch/x86/kernel/mpparse.c             | 10 +++++-----
 arch/x86/kernel/setup.c               | 10 ----------
 arch/x86/kernel/smpboot.c             | 32 +++++---------------------------
 15 files changed, 80 insertions(+), 89 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resc=
trl.rst
index a6279df64a9d..3712d81cb50c 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -45,7 +45,7 @@ mount options are:
 	Enable code/data prioritization in L2 cache allocations.
 "mba_MBps":
 	Enable the MBA Software Controller(mba_sc) to specify MBA
-	bandwidth in MBps
+	bandwidth in MiBps
 "debug":
 	Make debug files accessible. Available debug files are annotated with
 	"Available only with debug option".
@@ -526,7 +526,7 @@ threads start using more cores in an rdtgroup, the actual=
 bandwidth may
 increase or vary although user specified bandwidth percentage is same.
=20
 In order to mitigate this and make the interface more user friendly,
-resctrl added support for specifying the bandwidth in MBps as well.  The
+resctrl added support for specifying the bandwidth in MiBps as well.  The
 kernel underneath would use a software feedback mechanism or a "Software
 Controller(mba_sc)" which reads the actual bandwidth using MBM counters
 and adjust the memory bandwidth percentages to ensure::
@@ -573,13 +573,13 @@ Memory b/w domain is L3 cache.
=20
 	MB:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...
=20
-Memory bandwidth Allocation specified in MBps
+Memory bandwidth Allocation specified in MiBps
 ---------------------------------------------
=20
 Memory bandwidth domain is L3 cache.
 ::
=20
-	MB:<cache_id0>=3Dbw_MBps0;<cache_id1>=3Dbw_MBps1;...
+	MB:<cache_id0>=3Dbw_MiBps0;<cache_id1>=3Dbw_MiBps1;...
=20
 Slow Memory Bandwidth Allocation (SMBA)
 ---------------------------------------
diff --git a/arch/x86/configs/tiny.config b/arch/x86/configs/tiny.config
index 66c9e2aab16c..be3ee4294903 100644
--- a/arch/x86/configs/tiny.config
+++ b/arch/x86/configs/tiny.config
@@ -1,5 +1,6 @@
 CONFIG_NOHIGHMEM=3Dy
 # CONFIG_HIGHMEM4G is not set
 # CONFIG_HIGHMEM64G is not set
+# CONFIG_UNWINDER_ORC is not set
 CONFIG_UNWINDER_GUESS=3Dy
 # CONFIG_UNWINDER_FRAME_POINTER is not set
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel=
-family.h
index b65e9c46b922..d0941f4c2724 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -127,6 +127,7 @@
=20
 #define INTEL_FAM6_ARROWLAKE_H		0xC5
 #define INTEL_FAM6_ARROWLAKE		0xC6
+#define INTEL_FAM6_ARROWLAKE_U		0xB5
=20
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
=20
diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend=
_32.h
index a800abb1a992..d8416b3bf832 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -12,11 +12,6 @@
=20
 /* image of the saved processor state */
 struct saved_context {
-	/*
-	 * On x86_32, all segment registers except gs are saved at kernel
-	 * entry in pt_regs.
-	 */
-	u16 gs;
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	struct saved_msrs saved_msrs;
@@ -27,6 +22,11 @@ struct saved_context {
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
+	/*
+	 * On x86_32, all segment registers except gs are saved at kernel
+	 * entry in pt_regs.
+	 */
+	u16 gs;
 	bool misc_enable_saved;
 } __attribute__((packed));
=20
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ba8cf5e9ce56..5c1e6d6be267 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2307,6 +2307,8 @@ void arch_smt_update(void)
=20
 void __init arch_cpu_finalize_init(void)
 {
+	struct cpuinfo_x86 *c =3D this_cpu_ptr(&cpu_info);
+
 	identify_boot_cpu();
=20
 	select_idle_routine();
@@ -2345,6 +2347,13 @@ void __init arch_cpu_finalize_init(void)
 	fpu__init_system();
 	fpu__init_cpu();
=20
+	/*
+	 * Ensure that access to the per CPU representation has the initial
+	 * boot CPU configuration.
+	 */
+	*c =3D boot_cpu_data;
+	c->initialized =3D true;
+
 	alternative_instructions();
=20
 	if (IS_ENABLED(CONFIG_X86_64)) {
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 3259b1d4fefe..aaca8d235dc2 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -415,6 +415,17 @@ void __init topology_init_possible_cpus(void)
 	unsigned int total =3D assigned + disabled;
 	u32 apicid, firstid;
=20
+	/*
+	 * If there was no APIC registered, then fake one so that the
+	 * topology bitmap is populated. That ensures that the code below
+	 * is valid and the various query interfaces can be used
+	 * unconditionally. This does not affect the actual APIC code in
+	 * any way because either the local APIC address has not been
+	 * registered or the local APIC was disabled on the command line.
+	 */
+	if (topo_info.boot_cpu_apic_id =3D=3D BAD_APICID)
+		topology_register_boot_apic(0);
+
 	if (!restrict_to_up()) {
 		if (WARN_ON_ONCE(assigned > nr_cpu_ids)) {
 			disabled +=3D assigned - nr_cpu_ids;
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topo=
logy_common.c
index a50ae8d63d1c..9a6069e7133c 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -140,7 +140,7 @@ static void parse_topology(struct topo_scan *tscan, bool =
early)
 	}
 }
=20
-static void topo_set_ids(struct topo_scan *tscan)
+static void topo_set_ids(struct topo_scan *tscan, bool early)
 {
 	struct cpuinfo_x86 *c =3D tscan->c;
 	u32 apicid =3D c->topo.apicid;
@@ -148,8 +148,10 @@ static void topo_set_ids(struct topo_scan *tscan)
 	c->topo.pkg_id =3D topo_shift_apicid(apicid, TOPO_PKG_DOMAIN);
 	c->topo.die_id =3D topo_shift_apicid(apicid, TOPO_DIE_DOMAIN);
=20
-	c->topo.logical_pkg_id =3D topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
-	c->topo.logical_die_id =3D topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+	if (!early) {
+		c->topo.logical_pkg_id =3D topology_get_logical_id(apicid, TOPO_PKG_DOMAIN=
);
+		c->topo.logical_die_id =3D topology_get_logical_id(apicid, TOPO_DIE_DOMAIN=
);
+	}
=20
 	/* Package relative core ID */
 	c->topo.core_id =3D (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
@@ -187,7 +189,7 @@ void cpu_parse_topology(struct cpuinfo_x86 *c)
 		       tscan.dom_shifts[dom], x86_topo_system.dom_shifts[dom]);
 	}
=20
-	topo_set_ids(&tscan);
+	topo_set_ids(&tscan, false);
 }
=20
 void __init cpu_init_topology(struct cpuinfo_x86 *c)
@@ -208,7 +210,7 @@ void __init cpu_init_topology(struct cpuinfo_x86 *c)
 		x86_topo_system.dom_size[dom] =3D 1U << sft;
 	}
=20
-	topo_set_ids(&tscan);
+	topo_set_ids(&tscan, true);
=20
 	/*
 	 * AMD systems have Nodes per package which cannot be mapped to
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index b66f540de054..6f1b379e3b38 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1016,17 +1016,6 @@ void __init e820__reserve_setup_data(void)
=20
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_T=
YPE_RESERVED_KERN);
=20
-		/*
-		 * SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED are supplied by
-		 * kexec and do not need to be reserved.
-		 */
-		if (data->type !=3D SETUP_EFI &&
-		    data->type !=3D SETUP_IMA &&
-		    data->type !=3D SETUP_RNG_SEED)
-			e820__range_update_kexec(pa_data,
-						 sizeof(*data) + data->len,
-						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-
 		if (data->type =3D=3D SETUP_INDIRECT) {
 			len +=3D data->len;
 			early_memunmap(data, sizeof(*data));
@@ -1038,12 +1027,9 @@ void __init e820__reserve_setup_data(void)
=20
 			indirect =3D (struct setup_indirect *)data->data;
=20
-			if (indirect->type !=3D SETUP_INDIRECT) {
+			if (indirect->type !=3D SETUP_INDIRECT)
 				e820__range_update(indirect->addr, indirect->len,
 						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-				e820__range_update_kexec(indirect->addr, indirect->len,
-							 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-			}
 		}
=20
 		pa_data =3D pa_next;
@@ -1051,7 +1037,6 @@ void __init e820__reserve_setup_data(void)
 	}
=20
 	e820__update_table(e820_table);
-	e820__update_table(e820_table_kexec);
=20
 	pr_info("extended physical RAM map:\n");
 	e820__print_table("reserve setup_data");
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 117e74c44e75..33a214b1a4ce 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -178,10 +178,11 @@ void fpu__init_cpu_xstate(void)
 	 * Must happen after CR4 setup and before xsetbv() to allow KVM
 	 * lazy passthrough.  Write independent of the dynamic state static
 	 * key as that does not work on the boot CPU. This also ensures
-	 * that any stale state is wiped out from XFD.
+	 * that any stale state is wiped out from XFD. Reset the per CPU
+	 * xfd cache too.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_XFD))
-		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
+		xfd_set_state(init_fpstate.xfd);
=20
 	/*
 	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 3518fb26d06b..19ca623ffa2a 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -148,20 +148,26 @@ static inline void xfd_validate_state(struct fpstate *f=
pstate, u64 mask, bool rs
 #endif
=20
 #ifdef CONFIG_X86_64
+static inline void xfd_set_state(u64 xfd)
+{
+	wrmsrl(MSR_IA32_XFD, xfd);
+	__this_cpu_write(xfd_state, xfd);
+}
+
 static inline void xfd_update_state(struct fpstate *fpstate)
 {
 	if (fpu_state_size_dynamic()) {
 		u64 xfd =3D fpstate->xfd;
=20
-		if (__this_cpu_read(xfd_state) !=3D xfd) {
-			wrmsrl(MSR_IA32_XFD, xfd);
-			__this_cpu_write(xfd_state, xfd);
-		}
+		if (__this_cpu_read(xfd_state) !=3D xfd)
+			xfd_set_state(xfd);
 	}
 }
=20
 extern int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu);
 #else
+static inline void xfd_set_state(u64 xfd) { }
+
 static inline void xfd_update_state(struct fpstate *fpstate) { }
=20
 static inline int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fp=
u) {
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 212e8e06aeba..a817ed0724d1 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -81,6 +81,13 @@ static inline bool check_la57_support(void)
 	if (!(native_read_cr4() & X86_CR4_LA57))
 		return false;
=20
+	RIP_REL_REF(__pgtable_l5_enabled)	=3D 1;
+	RIP_REL_REF(pgdir_shift)		=3D 48;
+	RIP_REL_REF(ptrs_per_p4d)		=3D 512;
+	RIP_REL_REF(page_offset_base)		=3D __PAGE_OFFSET_BASE_L5;
+	RIP_REL_REF(vmalloc_base)		=3D __VMALLOC_BASE_L5;
+	RIP_REL_REF(vmemmap_base)		=3D __VMEMMAP_BASE_L5;
+
 	return true;
 }
=20
@@ -175,7 +182,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 		p4d =3D (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
 		p4d[MAX_PTRS_PER_P4D - 1] +=3D load_delta;
=20
-		pgd[pgd_index(__START_KERNEL_map)] =3D (pgdval_t)p4d | _PAGE_TABLE_NOENC;
+		pgd[pgd_index(__START_KERNEL_map)] =3D (pgdval_t)p4d | _PAGE_TABLE;
 	}
=20
 	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud +=3D load_delta;
@@ -431,15 +438,6 @@ asmlinkage __visible void __init __noreturn x86_64_start=
_kernel(char * real_mode
 				(__START_KERNEL & PGDIR_MASK)));
 	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <=3D MODULES_END);
=20
-	if (check_la57_support()) {
-		__pgtable_l5_enabled	=3D 1;
-		pgdir_shift		=3D 48;
-		ptrs_per_p4d		=3D 512;
-		page_offset_base	=3D __PAGE_OFFSET_BASE_L5;
-		vmalloc_base		=3D __VMALLOC_BASE_L5;
-		vmemmap_base		=3D __VMEMMAP_BASE_L5;
-	}
-
 	cr4_init_shadow();
=20
 	/* Kill off the identity-map trampoline */
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 091b3ab76a18..d0e49bd7c6f3 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -373,7 +373,16 @@ static bool can_probe(unsigned long paddr)
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long o=
ffset,
 					 bool *on_func_entry)
 {
-	if (is_endbr(*(u32 *)addr)) {
+	u32 insn;
+
+	/*
+	 * Since 'addr' is not guaranteed to be safe to access, use
+	 * copy_from_kernel_nofault() to read the instruction:
+	 */
+	if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
+		return NULL;
+
+	if (is_endbr(insn)) {
 		*on_func_entry =3D !offset || offset =3D=3D 4;
 		if (*on_func_entry)
 			offset =3D 4;
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 1ccd30c8246f..e89171b0347a 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -197,12 +197,12 @@ static int __init smp_read_mpc(struct mpc_table *mpc, u=
nsigned early)
 	if (!smp_check_mpc(mpc, oem, str))
 		return 0;
=20
-	/* Initialize the lapic mapping */
-	if (!acpi_lapic)
-		register_lapic_address(mpc->lapic);
-
-	if (early)
+	if (early) {
+		/* Initialize the lapic mapping */
+		if (!acpi_lapic)
+			register_lapic_address(mpc->lapic);
 		return 1;
+	}
=20
 	/* Now process the configuration blocks. */
 	while (count < mpc->length) {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3e1e96efadfe..ef206500ed6f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1206,16 +1206,6 @@ void __init i386_reserve_resources(void)
=20
 #endif /* CONFIG_X86_32 */
=20
-#ifndef CONFIG_SMP
-void __init smp_prepare_boot_cpu(void)
-{
-	struct cpuinfo_x86 *c =3D &cpu_data(0);
-
-	*c =3D boot_cpu_data;
-	c->initialized =3D true;
-}
-#endif
-
 static struct notifier_block kernel_offset_notifier =3D {
 	.notifier_call =3D dump_kernel_offset
 };
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe355c89f6c1..76bb65045c64 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -313,14 +313,6 @@ static void notrace start_secondary(void *unused)
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
=20
-static void __init smp_store_boot_cpu_info(void)
-{
-	struct cpuinfo_x86 *c =3D &cpu_data(0);
-
-	*c =3D boot_cpu_data;
-	c->initialized =3D true;
-}
-
 /*
  * The bootstrap kernel entry code has set these up. Save them for
  * a given CPU
@@ -1039,29 +1031,15 @@ static __init void disable_smp(void)
 	cpumask_set_cpu(0, topology_die_cpumask(0));
 }
=20
-static void __init smp_cpu_index_default(void)
-{
-	int i;
-	struct cpuinfo_x86 *c;
-
-	for_each_possible_cpu(i) {
-		c =3D &cpu_data(i);
-		/* mark all to hotplug */
-		c->cpu_index =3D nr_cpu_ids;
-	}
-}
-
 void __init smp_prepare_cpus_common(void)
 {
 	unsigned int i;
=20
-	smp_cpu_index_default();
-
-	/*
-	 * Setup boot CPU information
-	 */
-	smp_store_boot_cpu_info(); /* Final full version of the data */
-	mb();
+	/* Mark all except the boot CPU as hotpluggable */
+	for_each_possible_cpu(i) {
+		if (i)
+			per_cpu(cpu_info.cpu_index, i) =3D nr_cpu_ids;
+	}
=20
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);


