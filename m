Return-Path: <linux-kernel+bounces-98368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7F6877930
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A90B2116A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDAB3E47E;
	Sun, 10 Mar 2024 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n6IxhX0g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1OCw6rOj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9303BBE3
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710113949; cv=none; b=O9aNALhxO8PiERdXqG2IpAKrs01aH70WaHlvmtQHDAKrTWxwgAjrohHovPeNhnRuxPtS1UhT/cabG4Q5k9W9P6ZjFSrBYjlg2qSHWTztIoP0ORuzH1k9d/BxWA1H1sJI2eX3LOKB2qjxJRkAPHCDXG+NFgZLI00VdD2nMPgc51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710113949; c=relaxed/simple;
	bh=IUJrGeOrQ/XEwdFZGZdM5MNlxfgMZVCN/SQF+WsE4xU=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=MlLKzu1aH/6IQH54uc3u9uwF0T+9OfTRJt5pCKFKmGjrc5S9OHKWCDLT5Nf9PVZJ2cQ07Ewwpt7XD0Cx2eqhbeK0Lokl1/ST3rM+FacUBidB6qQ+uZnklKT62juxY2YSk44u84+SWXIZCJWJ2EgImYRCP6gOLraVWE9MvSLRWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n6IxhX0g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1OCw6rOj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710113941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=odBqIOBS+cM1p6mF/u+4KO0uBH+FEZj+Wbz3cAXOc5w=;
	b=n6IxhX0gbScmO3/fSEHhr60YwgNOaphU1o8d+9KEk5Truy8oChh/Fs0SZoBhrs7QH2p5Yy
	Ui5o2a7mKmgjIyBz+J6x1CCsLKcQkll7L7KW0IqoSnRSMsHPNjDeKvRcp6Dc3RfQVjpheM
	w2/lF3F27Y8wZsZos4DWO/gJauBppgyV3N8hY4cdzLm7Bb9Bshxt8QoHIft1DlULzcIu31
	L4XItKEHLYcXkRGCQfo1gyPbf1+VFDzn4CUFmKs+rvO1vZNsxiRg6KJpxt8DOKBCSs9T0M
	uehQaSlijMW+dCXkY6mVb+GA7/Mrvw+6Sb/gRos++pmK2Y2L5YwOZiRY+5++jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710113941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=odBqIOBS+cM1p6mF/u+4KO0uBH+FEZj+Wbz3cAXOc5w=;
	b=1OCw6rOjorf/sy15lQ2UWyy03M6SZoIU1f09GiEqqRxbKt72eVPKY+QlemqSsJrgR4Kn94
	DMZ5VV9ULOQ8Q9BA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/fred for v6.9-rc1
References: <171011361246.2468526.10740060923051583953.tglx@xen13>
Message-ID: <171011362209.2468526.15187874627966416701.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Mar 2024 00:39:00 +0100 (CET)

Linus,

please pull the latest x86/fred branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fred-2024-03=
-10

up to:  c416b5bac6ad: x86/fred: Fix init_task thread stack pointer initializa=
tion


Support for x86 Fast Return and Event Delivery (FRED):

FRED is a replacement for IDT event delivery on x86 and addresses most of
the technical nightmares which IDT exposes:

 1) Exception cause registers like CR2 need to be manually preserved in
    nested exception scenarios.

 2) Hardware interrupt stack switching is suboptimal for nested exceptions
    as the interrupt stack mechanism rewinds the stack on each entry which
    requires a massive effort in the low level entry of #NMI code to handle
    this.

 3) No hardware distinction between entry from kernel or from user which
    makes establishing kernel context more complex than it needs to be
    especially for unconditionally nestable exceptions like NMI.

 4) NMI nesting caused by IRET unconditionally reenabling NMIs, which is a
    problem when the perf NMI takes a fault when collecting a stack trace.

 5) Partial restore of ESP when returning to a 16-bit segment

 6) Limitation of the vector space which can cause vector exhaustion on
    large systems.

 7) Inability to differentiate NMI sources

FRED addresses these shortcomings by:

 1) An extended exception stack frame which the CPU uses to save exception
    cause registers. This ensures that the meta information for each
    exception is preserved on stack and avoids the extra complexity of
    preserving it in software.

 2) Hardware interrupt stack switching is non-rewinding if a nested
    exception uses the currently interrupt stack.

 3) The entry points for kernel and user context are separate and GS BASE
    handling which is required to establish kernel context for per CPU
    variable access is done in hardware.

 4) NMIs are now nesting protected. They are only reenabled on the return
    from NMI.

 5) FRED guarantees full restore of ESP

 6) FRED does not put a limitation on the vector space by design because it
    uses a central entry points for kernel and user space and the CPUstores
    the entry type (exception, trap, interrupt, syscall) on the entry stack
    along with the vector number. The entry code has to demultiplex this
    information, but this removes the vector space restriction.

    The first hardware implementations will still have the current
    restricted vector space because lifting this limitation requires
    further changes to the local APIC.

 7) FRED stores the vector number and meta information on stack which
    allows having more than one NMI vector in future hardware when the
    required local APIC changes are in place.

The series implements the initial FRED support by:

 - Reworking the existing entry and IDT handling infrastructure to
   accomodate for the alternative entry mechanism.

 - Expanding the stack frame to accomodate for the extra 16 bytes FRED
   requires to store context and meta information

 - Providing FRED specific C entry points for events which have information
   pushed to the extended stack frame, e.g. #PF and #DB.

 - Providing FRED specific C entry points for #NMI and #MCE

 - Implementing the FRED specific ASM entry points and the C code to
   demultiplex the events

 - Providing detection and initialization mechanisms and the necessary
   tweaks in context switching, GS BASE handling etc.

The FRED integration aims for maximum code reuse vs. the existing IDT
implementation to the extent possible and the deviation in hot paths like
context switching are handled with alternatives to minimalize the
impact. The low level entry and exit paths are seperate due to the extended
stack frame and the hardware based GS BASE swichting and therefore have no
impact on IDT based systems.

It has been extensively tested on existing systems and on the FRED
simulation and as of now there are know outstanding problems.

Thanks,

	tglx

------------------>
H. Peter Anvin (Intel) (20):
      x86/fred: Add Kconfig option for FRED (CONFIG_X86_FRED)
      x86/cpufeatures: Add the CPU feature bit for FRED
      x86/fred: Disable FRED support if CONFIG_X86_FRED is disabled
      x86/opcode: Add ERET[US] instructions to the x86 opcode map
      x86/objtool: Teach objtool about ERET[US]
      x86/cpu: Add X86_CR4_FRED macro
      x86/cpu: Add MSR numbers for FRED configuration
      x86/fred: Add a new header file for FRED definitions
      x86/fred: Reserve space for the FRED stack frame
      x86/fred: Update MSR_IA32_FRED_RSP0 during task switch
      x86/fred: Disallow the swapgs instruction when FRED is enabled
      x86/fred: No ESPFIX needed when FRED is enabled
      x86/fred: Allow single-step trap and NMI when starting a new task
      x86/fred: Make exc_page_fault() work for FRED
      x86/fred: Add a debug fault entry stub for FRED
      x86/fred: Add a NMI entry stub for FRED
      x86/fred: FRED entry/exit and dispatch code
      x86/fred: Let ret_from_fork_asm() jmp to asm_fred_exit_user when FRED i=
s enabled
      x86/fred: Add FRED initialization functions
      x86/fred: Invoke FRED initialization code to enable FRED

Peter Zijlstra (Intel) (1):
      x86/entry/calling: Allow PUSH_AND_CLEAR_REGS being used beyond actual e=
ntry code

Xin Li (14):
      x86/cpufeatures,opcode,msr: Add the WRMSRNS instruction support
      x86/entry: Remove idtentry_sysvec from entry_{32,64}.S
      x86/trapnr: Add event type macros to <asm/trapnr.h>
      Documentation/x86/64: Add documentation for FRED
      x86/fred: Add a fred=3D cmdline param
      x86/ptrace: Cleanup the definition of the pt_regs structure
      x86/ptrace: Add FRED additional information to the pt_regs structure
      x86/idtentry: Incorporate definitions/declarations of the FRED entries
      x86/fred: Add a machine check entry stub for FRED
      x86/traps: Add sysvec_install() to install a system interrupt handler
      x86/fred: Fixup fault on ERETU by jumping to fred_entrypoint_user
      x86/entry: Add fred_entry_from_kvm() for VMX to handle IRQ/NMI
      KVM: VMX: Call fred_entry_from_kvm() for IRQ/NMI handling
      x86/syscall: Split IDT syscall setup code into idt_syscall_init()

Xin Li (Intel) (3):
      x86/fred: Fix a build warning with allmodconfig due to 'inline' failing=
 to inline properly
      MAINTAINERS: Add a maintainer entry for FRED
      x86/fred: Fix init_task thread stack pointer initialization


 Documentation/admin-guide/kernel-parameters.txt |   6 +
 Documentation/arch/x86/x86_64/fred.rst          |  96 ++++++++
 Documentation/arch/x86/x86_64/index.rst         |   1 +
 MAINTAINERS                                     |  10 +
 arch/x86/Kconfig                                |   9 +
 arch/x86/entry/Makefile                         |   5 +-
 arch/x86/entry/calling.h                        |  15 +-
 arch/x86/entry/entry_32.S                       |   4 -
 arch/x86/entry/entry_64.S                       |  14 +-
 arch/x86/entry/entry_64_fred.S                  | 131 +++++++++++
 arch/x86/entry/entry_fred.c                     | 294 ++++++++++++++++++++++=
++
 arch/x86/entry/vsyscall/vsyscall_64.c           |   2 +-
 arch/x86/include/asm/asm-prototypes.h           |   1 +
 arch/x86/include/asm/barrier.h                  |   2 +-
 arch/x86/include/asm/cpufeatures.h              |   2 +
 arch/x86/include/asm/desc.h                     |   2 -
 arch/x86/include/asm/disabled-features.h        |   8 +-
 arch/x86/include/asm/extable_fixup_types.h      |   4 +-
 arch/x86/include/asm/fred.h                     |  97 ++++++++
 arch/x86/include/asm/ia32.h                     |   4 +-
 arch/x86/include/asm/idtentry.h                 |  88 ++++++-
 arch/x86/include/asm/msr-index.h                |  13 +-
 arch/x86/include/asm/msr.h                      |  18 ++
 arch/x86/include/asm/processor.h                |   6 +-
 arch/x86/include/asm/ptrace.h                   | 104 +++++++--
 arch/x86/include/asm/switch_to.h                |   8 +-
 arch/x86/include/asm/thread_info.h              |  12 +-
 arch/x86/include/asm/trapnr.h                   |  12 +
 arch/x86/include/asm/vmx.h                      |  17 +-
 arch/x86/include/uapi/asm/processor-flags.h     |   7 +
 arch/x86/kernel/Makefile                        |   1 +
 arch/x86/kernel/cpu/acrn.c                      |   4 +-
 arch/x86/kernel/cpu/common.c                    |  38 ++-
 arch/x86/kernel/cpu/cpuid-deps.c                |   2 +
 arch/x86/kernel/cpu/mce/core.c                  |  26 +++
 arch/x86/kernel/cpu/mshyperv.c                  |  15 +-
 arch/x86/kernel/espfix_64.c                     |   8 +
 arch/x86/kernel/fred.c                          |  59 +++++
 arch/x86/kernel/head_64.S                       |   3 +-
 arch/x86/kernel/idt.c                           |   4 +-
 arch/x86/kernel/irqinit.c                       |   7 +-
 arch/x86/kernel/kvm.c                           |   2 +-
 arch/x86/kernel/nmi.c                           |  42 ++++
 arch/x86/kernel/process_64.c                    |  67 +++++-
 arch/x86/kernel/traps.c                         |  74 +++++-
 arch/x86/kvm/vmx/vmx.c                          |  12 +-
 arch/x86/lib/x86-opcode-map.txt                 |   4 +-
 arch/x86/mm/extable.c                           |  78 +++++++
 arch/x86/mm/fault.c                             |   5 +-
 arch/x86/xen/xen-head.S                         |   2 +-
 drivers/xen/events/events_base.c                |   2 +-
 tools/arch/x86/include/asm/cpufeatures.h        |   2 +
 tools/arch/x86/include/asm/disabled-features.h  |   8 +-
 tools/arch/x86/include/asm/msr-index.h          |  13 +-
 tools/arch/x86/lib/x86-opcode-map.txt           |   4 +-
 tools/objtool/arch/x86/decode.c                 |  19 +-
 56 files changed, 1372 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/arch/x86/x86_64/fred.rst
 create mode 100644 arch/x86/entry/entry_64_fred.S
 create mode 100644 arch/x86/entry/entry_fred.c
 create mode 100644 arch/x86/include/asm/fred.h
 create mode 100644 arch/x86/kernel/fred.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 31b3a25680d0..d6ea4f42127c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1539,6 +1539,12 @@
 			Warning: use of this parameter will taint the kernel
 			and may cause unknown problems.
=20
+	fred=3D		[X86-64]
+			Enable/disable Flexible Return and Event Delivery.
+			Format: { on | off }
+			on: enable FRED when it's present.
+			off: disable FRED, the default setting.
+
 	ftrace=3D[tracer]
 			[FTRACE] will set and start the specified tracer
 			as early as possible in order to facilitate early
diff --git a/Documentation/arch/x86/x86_64/fred.rst b/Documentation/arch/x86/=
x86_64/fred.rst
new file mode 100644
index 000000000000..9f57e7b91f7e
--- /dev/null
+++ b/Documentation/arch/x86/x86_64/fred.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Flexible Return and Event Delivery (FRED)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+The FRED architecture defines simple new transitions that change
+privilege level (ring transitions). The FRED architecture was
+designed with the following goals:
+
+1) Improve overall performance and response time by replacing event
+   delivery through the interrupt descriptor table (IDT event
+   delivery) and event return by the IRET instruction with lower
+   latency transitions.
+
+2) Improve software robustness by ensuring that event delivery
+   establishes the full supervisor context and that event return
+   establishes the full user context.
+
+The new transitions defined by the FRED architecture are FRED event
+delivery and, for returning from events, two FRED return instructions.
+FRED event delivery can effect a transition from ring 3 to ring 0, but
+it is used also to deliver events incident to ring 0. One FRED
+instruction (ERETU) effects a return from ring 0 to ring 3, while the
+other (ERETS) returns while remaining in ring 0. Collectively, FRED
+event delivery and the FRED return instructions are FRED transitions.
+
+In addition to these transitions, the FRED architecture defines a new
+instruction (LKGS) for managing the state of the GS segment register.
+The LKGS instruction can be used by 64-bit operating systems that do
+not use the new FRED transitions.
+
+Furthermore, the FRED architecture is easy to extend for future CPU
+architectures.
+
+Software based event dispatching
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+FRED operates differently from IDT in terms of event handling. Instead
+of directly dispatching an event to its handler based on the event
+vector, FRED requires the software to dispatch an event to its handler
+based on both the event's type and vector. Therefore, an event dispatch
+framework must be implemented to facilitate the event-to-handler
+dispatch process. The FRED event dispatch framework takes control
+once an event is delivered, and employs a two-level dispatch.
+
+The first level dispatching is event type based, and the second level
+dispatching is event vector based.
+
+Full supervisor/user context
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+FRED event delivery atomically save and restore full supervisor/user
+context upon event delivery and return. Thus it avoids the problem of
+transient states due to %cr2 and/or %dr6, and it is no longer needed
+to handle all the ugly corner cases caused by half baked entry states.
+
+FRED allows explicit unblock of NMI with new event return instructions
+ERETS/ERETU, avoiding the mess caused by IRET which unconditionally
+unblocks NMI, e.g., when an exception happens during NMI handling.
+
+FRED always restores the full value of %rsp, thus ESPFIX is no longer
+needed when FRED is enabled.
+
+LKGS
+=3D=3D=3D=3D
+
+LKGS behaves like the MOV to GS instruction except that it loads the
+base address into the IA32_KERNEL_GS_BASE MSR instead of the GS
+segment=E2=80=99s descriptor cache. With LKGS, it ends up with avoiding
+mucking with kernel GS, i.e., an operating system can always operate
+with its own GS base address.
+
+Because FRED event delivery from ring 3 and ERETU both swap the value
+of the GS base address and that of the IA32_KERNEL_GS_BASE MSR, plus
+the introduction of LKGS instruction, the SWAPGS instruction is no
+longer needed when FRED is enabled, thus is disallowed (#UD).
+
+Stack levels
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+4 stack levels 0~3 are introduced to replace the nonreentrant IST for
+event handling, and each stack level should be configured to use a
+dedicated stack.
+
+The current stack level could be unchanged or go higher upon FRED
+event delivery. If unchanged, the CPU keeps using the current event
+stack. If higher, the CPU switches to a new event stack specified by
+the MSR of the new stack level, i.e., MSR_IA32_FRED_RSP[123].
+
+Only execution of a FRED return instruction ERET[US], could lower the
+current stack level, causing the CPU to switch back to the stack it was
+on before a previous event delivery that promoted the stack level.
diff --git a/Documentation/arch/x86/x86_64/index.rst b/Documentation/arch/x86=
/x86_64/index.rst
index a56070fc8e77..ad15e9bd623f 100644
--- a/Documentation/arch/x86/x86_64/index.rst
+++ b/Documentation/arch/x86/x86_64/index.rst
@@ -15,3 +15,4 @@ x86_64 Support
    cpu-hotplug-spec
    machinecheck
    fsgs
+   fred
diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..29574c65b26e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11151,6 +11151,16 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/wwan/iosm/
=20
+INTEL(R) FLEXIBLE RETURN AND EVENT DELIVERY
+M:	Xin Li <xin@zytor.com>
+M:	"H. Peter Anvin" <hpa@zytor.com>
+S:	Supported
+F:	Documentation/arch/x86/x86_64/fred.rst
+F:	arch/x86/entry/entry_64_fred.S
+F:	arch/x86/entry/entry_fred.c
+F:	arch/x86/include/asm/fred.h
+F:	arch/x86/kernel/fred.c
+
 INTEL(R) TRACE HUB
 M:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 S:	Supported
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5edec175b9bf..854ab38a359a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -496,6 +496,15 @@ config X86_CPU_RESCTRL
=20
 	  Say N if unsure.
=20
+config X86_FRED
+	bool "Flexible Return and Event Delivery"
+	depends on X86_64
+	help
+	  When enabled, try to use Flexible Return and Event Delivery
+	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
+	  ring transitions and exception/interrupt handling if the
+	  system supports.
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index ca2fe186994b..c93e7f5c2a06 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -18,6 +18,9 @@ obj-y				+=3D vdso/
 obj-y				+=3D vsyscall/
=20
 obj-$(CONFIG_PREEMPTION)	+=3D thunk_$(BITS).o
+CFLAGS_entry_fred.o		+=3D -fno-stack-protector
+CFLAGS_REMOVE_entry_fred.o	+=3D -pg $(CC_FLAGS_FTRACE)
+obj-$(CONFIG_X86_FRED)		+=3D entry_64_fred.o entry_fred.o
+
 obj-$(CONFIG_IA32_EMULATION)	+=3D entry_64_compat.o syscall_32.o
 obj-$(CONFIG_X86_X32_ABI)	+=3D syscall_x32.o
-
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9f1d94790a54..3ff925b17b7e 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -65,7 +65,7 @@ For 32-bit we have the following conventions - kernel is bu=
ilt with
  * for assembly code:
  */
=20
-.macro PUSH_REGS rdx=3D%rdx rcx=3D%rcx rax=3D%rax save_ret=3D0
+.macro PUSH_REGS rdx=3D%rdx rcx=3D%rcx rax=3D%rax save_ret=3D0 unwind_hint=
=3D1
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
@@ -87,14 +87,17 @@ For 32-bit we have the following conventions - kernel is =
built with
 	pushq	%r13		/* pt_regs->r13 */
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
+
+	.if \unwind_hint
 	UNWIND_HINT_REGS
+	.endif
=20
 	.if \save_ret
 	pushq	%rsi		/* return address on top of stack */
 	.endif
 .endm
=20
-.macro CLEAR_REGS
+.macro CLEAR_REGS clear_bp=3D1
 	/*
 	 * Sanitize registers of values that a speculation attack might
 	 * otherwise want to exploit. The lower registers are likely clobbered
@@ -109,7 +112,9 @@ For 32-bit we have the following conventions - kernel is =
built with
 	xorl	%r10d, %r10d	/* nospec r10 */
 	xorl	%r11d, %r11d	/* nospec r11 */
 	xorl	%ebx,  %ebx	/* nospec rbx */
+	.if \clear_bp
 	xorl	%ebp,  %ebp	/* nospec rbp */
+	.endif
 	xorl	%r12d, %r12d	/* nospec r12 */
 	xorl	%r13d, %r13d	/* nospec r13 */
 	xorl	%r14d, %r14d	/* nospec r14 */
@@ -117,9 +122,9 @@ For 32-bit we have the following conventions - kernel is =
built with
=20
 .endm
=20
-.macro PUSH_AND_CLEAR_REGS rdx=3D%rdx rcx=3D%rcx rax=3D%rax save_ret=3D0
-	PUSH_REGS rdx=3D\rdx, rcx=3D\rcx, rax=3D\rax, save_ret=3D\save_ret
-	CLEAR_REGS
+.macro PUSH_AND_CLEAR_REGS rdx=3D%rdx rcx=3D%rcx rax=3D%rax save_ret=3D0 cle=
ar_bp=3D1 unwind_hint=3D1
+	PUSH_REGS rdx=3D\rdx, rcx=3D\rcx, rax=3D\rax, save_ret=3D\save_ret unwind_h=
int=3D\unwind_hint
+	CLEAR_REGS clear_bp=3D\clear_bp
 .endm
=20
 .macro POP_REGS pop_rdi=3D1
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index c73047bf9f4b..89a7ec0920ec 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -649,10 +649,6 @@ SYM_CODE_START_LOCAL(asm_\cfunc)
 SYM_CODE_END(asm_\cfunc)
 .endm
=20
-.macro idtentry_sysvec vector cfunc
-	idtentry \vector asm_\cfunc \cfunc has_error_code=3D0
-.endm
-
 /*
  * Include the defines which emit the idt entries which are shared
  * shared between 32 and 64 bit and emit the __irqentry_text_* markers
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c40f89ab1b4c..7c4b7263b857 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -247,7 +247,13 @@ SYM_CODE_START(ret_from_fork_asm)
 	 * and unwind should work normally.
 	 */
 	UNWIND_HINT_REGS
+
+#ifdef CONFIG_X86_FRED
+	ALTERNATIVE "jmp swapgs_restore_regs_and_return_to_usermode", \
+		    "jmp asm_fred_exit_user", X86_FEATURE_FRED
+#else
 	jmp	swapgs_restore_regs_and_return_to_usermode
+#endif
 SYM_CODE_END(ret_from_fork_asm)
 .popsection
=20
@@ -370,14 +376,6 @@ SYM_CODE_END(\asmsym)
 	idtentry \vector asm_\cfunc \cfunc has_error_code=3D1
 .endm
=20
-/*
- * System vectors which invoke their handlers directly and are not
- * going through the regular common device interrupt handling code.
- */
-.macro idtentry_sysvec vector cfunc
-	idtentry \vector asm_\cfunc \cfunc has_error_code=3D0
-.endm
-
 /**
  * idtentry_mce_db - Macro to generate entry stubs for #MC and #DB
  * @vector:		Vector number
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
new file mode 100644
index 000000000000..a02bc6f3d2e6
--- /dev/null
+++ b/arch/x86/entry/entry_64_fred.S
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The actual FRED entry points.
+ */
+
+#include <linux/export.h>
+
+#include <asm/asm.h>
+#include <asm/fred.h>
+#include <asm/segment.h>
+
+#include "calling.h"
+
+	.code64
+	.section .noinstr.text, "ax"
+
+.macro FRED_ENTER
+	UNWIND_HINT_END_OF_STACK
+	ENDBR
+	PUSH_AND_CLEAR_REGS
+	movq	%rsp, %rdi	/* %rdi -> pt_regs */
+.endm
+
+.macro FRED_EXIT
+	UNWIND_HINT_REGS
+	POP_REGS
+.endm
+
+/*
+ * The new RIP value that FRED event delivery establishes is
+ * IA32_FRED_CONFIG & ~FFFH for events that occur in ring 3.
+ * Thus the FRED ring 3 entry point must be 4K page aligned.
+ */
+	.align 4096
+
+SYM_CODE_START_NOALIGN(asm_fred_entrypoint_user)
+	FRED_ENTER
+	call	fred_entry_from_user
+SYM_INNER_LABEL(asm_fred_exit_user, SYM_L_GLOBAL)
+	FRED_EXIT
+1:	ERETU
+
+	_ASM_EXTABLE_TYPE(1b, asm_fred_entrypoint_user, EX_TYPE_ERETU)
+SYM_CODE_END(asm_fred_entrypoint_user)
+
+/*
+ * The new RIP value that FRED event delivery establishes is
+ * (IA32_FRED_CONFIG & ~FFFH) + 256 for events that occur in
+ * ring 0, i.e., asm_fred_entrypoint_user + 256.
+ */
+	.org asm_fred_entrypoint_user + 256, 0xcc
+SYM_CODE_START_NOALIGN(asm_fred_entrypoint_kernel)
+	FRED_ENTER
+	call	fred_entry_from_kernel
+	FRED_EXIT
+	ERETS
+SYM_CODE_END(asm_fred_entrypoint_kernel)
+
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+SYM_FUNC_START(asm_fred_entry_from_kvm)
+	push %rbp
+	mov %rsp, %rbp
+
+	UNWIND_HINT_SAVE
+
+	/*
+	 * Both IRQ and NMI from VMX can be handled on current task stack
+	 * because there is no need to protect from reentrancy and the call
+	 * stack leading to this helper is effectively constant and shallow
+	 * (relatively speaking). Do the same when FRED is active, i.e., no
+	 * need to check current stack level for a stack switch.
+	 *
+	 * Emulate the FRED-defined redzone and stack alignment.
+	 */
+	sub $(FRED_CONFIG_REDZONE_AMOUNT << 6), %rsp
+	and $FRED_STACK_FRAME_RSP_MASK, %rsp
+
+	/*
+	 * Start to push a FRED stack frame, which is always 64 bytes:
+	 *
+	 * +--------+-----------------+
+	 * | Bytes  | Usage           |
+	 * +--------+-----------------+
+	 * | 63:56  | Reserved        |
+	 * | 55:48  | Event Data      |
+	 * | 47:40  | SS + Event Info |
+	 * | 39:32  | RSP             |
+	 * | 31:24  | RFLAGS          |
+	 * | 23:16  | CS + Aux Info   |
+	 * |  15:8  | RIP             |
+	 * |   7:0  | Error Code      |
+	 * +--------+-----------------+
+	 */
+	push $0				/* Reserved, must be 0 */
+	push $0				/* Event data, 0 for IRQ/NMI */
+	push %rdi			/* fred_ss handed in by the caller */
+	push %rbp
+	pushf
+	mov $__KERNEL_CS, %rax
+	push %rax
+
+	/*
+	 * Unlike the IDT event delivery, FRED _always_ pushes an error code
+	 * after pushing the return RIP, thus the CALL instruction CANNOT be
+	 * used here to push the return RIP, otherwise there is no chance to
+	 * push an error code before invoking the IRQ/NMI handler.
+	 *
+	 * Use LEA to get the return RIP and push it, then push an error code.
+	 */
+	lea 1f(%rip), %rax
+	push %rax				/* Return RIP */
+	push $0					/* Error code, 0 for IRQ/NMI */
+
+	PUSH_AND_CLEAR_REGS clear_bp=3D0 unwind_hint=3D0
+	movq %rsp, %rdi				/* %rdi -> pt_regs */
+	call __fred_entry_from_kvm		/* Call the C entry point */
+	POP_REGS
+	ERETS
+1:
+	/*
+	 * Objtool doesn't understand what ERETS does, this hint tells it that
+	 * yes, we'll reach here and with what stack state. A save/restore pair
+	 * isn't strictly needed, but it's the simplest form.
+	 */
+	UNWIND_HINT_RESTORE
+	pop %rbp
+	RET
+
+SYM_FUNC_END(asm_fred_entry_from_kvm)
+EXPORT_SYMBOL_GPL(asm_fred_entry_from_kvm);
+#endif
diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
new file mode 100644
index 000000000000..ac120cbdaaf2
--- /dev/null
+++ b/arch/x86/entry/entry_fred.c
@@ -0,0 +1,294 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The FRED specific kernel/user entry functions which are invoked from
+ * assembly code and dispatch to the associated handlers.
+ */
+#include <linux/kernel.h>
+#include <linux/kdebug.h>
+#include <linux/nospec.h>
+
+#include <asm/desc.h>
+#include <asm/fred.h>
+#include <asm/idtentry.h>
+#include <asm/syscall.h>
+#include <asm/trapnr.h>
+#include <asm/traps.h>
+
+/* FRED EVENT_TYPE_OTHER vector numbers */
+#define FRED_SYSCALL			1
+#define FRED_SYSENTER			2
+
+static noinstr void fred_bad_type(struct pt_regs *regs, unsigned long error_=
code)
+{
+	irqentry_state_t irq_state =3D irqentry_nmi_enter(regs);
+
+	instrumentation_begin();
+
+	/* Panic on events from a high stack level */
+	if (regs->fred_cs.sl > 0) {
+		pr_emerg("PANIC: invalid or fatal FRED event; event type %u "
+			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
+			 regs->fred_ss.type, regs->fred_ss.vector, regs->orig_ax,
+			 fred_event_data(regs), regs->cs, regs->ip);
+		die("invalid or fatal FRED event", regs, regs->orig_ax);
+		panic("invalid or fatal FRED event");
+	} else {
+		unsigned long flags =3D oops_begin();
+		int sig =3D SIGKILL;
+
+		pr_alert("BUG: invalid or fatal FRED event; event type %u "
+			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
+			 regs->fred_ss.type, regs->fred_ss.vector, regs->orig_ax,
+			 fred_event_data(regs), regs->cs, regs->ip);
+
+		if (__die("Invalid or fatal FRED event", regs, regs->orig_ax))
+			sig =3D 0;
+
+		oops_end(flags, regs, sig);
+	}
+
+	instrumentation_end();
+	irqentry_nmi_exit(regs, irq_state);
+}
+
+static noinstr void fred_intx(struct pt_regs *regs)
+{
+	switch (regs->fred_ss.vector) {
+	/* Opcode 0xcd, 0x3, NOT INT3 (opcode 0xcc) */
+	case X86_TRAP_BP:
+		return exc_int3(regs);
+
+	/* Opcode 0xcd, 0x4, NOT INTO (opcode 0xce) */
+	case X86_TRAP_OF:
+		return exc_overflow(regs);
+
+#ifdef CONFIG_IA32_EMULATION
+	/* INT80 */
+	case IA32_SYSCALL_VECTOR:
+		if (ia32_enabled())
+			return int80_emulation(regs);
+		fallthrough;
+#endif
+
+	default:
+		return exc_general_protection(regs, 0);
+	}
+}
+
+static __always_inline void fred_other(struct pt_regs *regs)
+{
+	/* The compiler can fold these conditions into a single test */
+	if (likely(regs->fred_ss.vector =3D=3D FRED_SYSCALL && regs->fred_ss.lm)) {
+		regs->orig_ax =3D regs->ax;
+		regs->ax =3D -ENOSYS;
+		do_syscall_64(regs, regs->orig_ax);
+		return;
+	} else if (ia32_enabled() &&
+		   likely(regs->fred_ss.vector =3D=3D FRED_SYSENTER && !regs->fred_ss.lm))=
 {
+		regs->orig_ax =3D regs->ax;
+		regs->ax =3D -ENOSYS;
+		do_fast_syscall_32(regs);
+		return;
+	} else {
+		exc_invalid_op(regs);
+		return;
+	}
+}
+
+#define SYSVEC(_vector, _function) [_vector - FIRST_SYSTEM_VECTOR] =3D fred_=
sysvec_##_function
+
+static idtentry_t sysvec_table[NR_SYSTEM_VECTORS] __ro_after_init =3D {
+	SYSVEC(ERROR_APIC_VECTOR,		error_interrupt),
+	SYSVEC(SPURIOUS_APIC_VECTOR,		spurious_apic_interrupt),
+	SYSVEC(LOCAL_TIMER_VECTOR,		apic_timer_interrupt),
+	SYSVEC(X86_PLATFORM_IPI_VECTOR,		x86_platform_ipi),
+
+	SYSVEC(RESCHEDULE_VECTOR,		reschedule_ipi),
+	SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	call_function_single),
+	SYSVEC(CALL_FUNCTION_VECTOR,		call_function),
+	SYSVEC(REBOOT_VECTOR,			reboot),
+
+	SYSVEC(THRESHOLD_APIC_VECTOR,		threshold),
+	SYSVEC(DEFERRED_ERROR_VECTOR,		deferred_error),
+	SYSVEC(THERMAL_APIC_VECTOR,		thermal),
+
+	SYSVEC(IRQ_WORK_VECTOR,			irq_work),
+
+	SYSVEC(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
+	SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	kvm_posted_intr_wakeup_ipi),
+	SYSVEC(POSTED_INTR_NESTED_VECTOR,	kvm_posted_intr_nested_ipi),
+};
+
+static bool fred_setup_done __initdata;
+
+void __init fred_install_sysvec(unsigned int sysvec, idtentry_t handler)
+{
+	if (WARN_ON_ONCE(sysvec < FIRST_SYSTEM_VECTOR))
+		return;
+
+	if (WARN_ON_ONCE(fred_setup_done))
+		return;
+
+	if (!WARN_ON_ONCE(sysvec_table[sysvec - FIRST_SYSTEM_VECTOR]))
+		 sysvec_table[sysvec - FIRST_SYSTEM_VECTOR] =3D handler;
+}
+
+static noinstr void fred_handle_spurious_interrupt(struct pt_regs *regs)
+{
+	spurious_interrupt(regs, regs->fred_ss.vector);
+}
+
+void __init fred_complete_exception_setup(void)
+{
+	unsigned int vector;
+
+	for (vector =3D 0; vector < FIRST_EXTERNAL_VECTOR; vector++)
+		set_bit(vector, system_vectors);
+
+	for (vector =3D 0; vector < NR_SYSTEM_VECTORS; vector++) {
+		if (sysvec_table[vector])
+			set_bit(vector + FIRST_SYSTEM_VECTOR, system_vectors);
+		else
+			sysvec_table[vector] =3D fred_handle_spurious_interrupt;
+	}
+	fred_setup_done =3D true;
+}
+
+static noinstr void fred_extint(struct pt_regs *regs)
+{
+	unsigned int vector =3D regs->fred_ss.vector;
+	unsigned int index =3D array_index_nospec(vector - FIRST_SYSTEM_VECTOR,
+						NR_SYSTEM_VECTORS);
+
+	if (WARN_ON_ONCE(vector < FIRST_EXTERNAL_VECTOR))
+		return;
+
+	if (likely(vector >=3D FIRST_SYSTEM_VECTOR)) {
+		irqentry_state_t state =3D irqentry_enter(regs);
+
+		instrumentation_begin();
+		sysvec_table[index](regs);
+		instrumentation_end();
+		irqentry_exit(regs, state);
+	} else {
+		common_interrupt(regs, vector);
+	}
+}
+
+static noinstr void fred_hwexc(struct pt_regs *regs, unsigned long error_cod=
e)
+{
+	/* Optimize for #PF. That's the only exception which matters performance wi=
se */
+	if (likely(regs->fred_ss.vector =3D=3D X86_TRAP_PF))
+		return exc_page_fault(regs, error_code);
+
+	switch (regs->fred_ss.vector) {
+	case X86_TRAP_DE: return exc_divide_error(regs);
+	case X86_TRAP_DB: return fred_exc_debug(regs);
+	case X86_TRAP_BR: return exc_bounds(regs);
+	case X86_TRAP_UD: return exc_invalid_op(regs);
+	case X86_TRAP_NM: return exc_device_not_available(regs);
+	case X86_TRAP_DF: return exc_double_fault(regs, error_code);
+	case X86_TRAP_TS: return exc_invalid_tss(regs, error_code);
+	case X86_TRAP_NP: return exc_segment_not_present(regs, error_code);
+	case X86_TRAP_SS: return exc_stack_segment(regs, error_code);
+	case X86_TRAP_GP: return exc_general_protection(regs, error_code);
+	case X86_TRAP_MF: return exc_coprocessor_error(regs);
+	case X86_TRAP_AC: return exc_alignment_check(regs, error_code);
+	case X86_TRAP_XF: return exc_simd_coprocessor_error(regs);
+
+#ifdef CONFIG_X86_MCE
+	case X86_TRAP_MC: return fred_exc_machine_check(regs);
+#endif
+#ifdef CONFIG_INTEL_TDX_GUEST
+	case X86_TRAP_VE: return exc_virtualization_exception(regs);
+#endif
+#ifdef CONFIG_X86_CET
+	case X86_TRAP_CP: return exc_control_protection(regs, error_code);
+#endif
+	default: return fred_bad_type(regs, error_code);
+	}
+
+}
+
+static noinstr void fred_swexc(struct pt_regs *regs, unsigned long error_cod=
e)
+{
+	switch (regs->fred_ss.vector) {
+	case X86_TRAP_BP: return exc_int3(regs);
+	case X86_TRAP_OF: return exc_overflow(regs);
+	default: return fred_bad_type(regs, error_code);
+	}
+}
+
+__visible noinstr void fred_entry_from_user(struct pt_regs *regs)
+{
+	unsigned long error_code =3D regs->orig_ax;
+
+	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
+	regs->orig_ax =3D -1;
+
+	switch (regs->fred_ss.type) {
+	case EVENT_TYPE_EXTINT:
+		return fred_extint(regs);
+	case EVENT_TYPE_NMI:
+		if (likely(regs->fred_ss.vector =3D=3D X86_TRAP_NMI))
+			return fred_exc_nmi(regs);
+		break;
+	case EVENT_TYPE_HWEXC:
+		return fred_hwexc(regs, error_code);
+	case EVENT_TYPE_SWINT:
+		return fred_intx(regs);
+	case EVENT_TYPE_PRIV_SWEXC:
+		if (likely(regs->fred_ss.vector =3D=3D X86_TRAP_DB))
+			return fred_exc_debug(regs);
+		break;
+	case EVENT_TYPE_SWEXC:
+		return fred_swexc(regs, error_code);
+	case EVENT_TYPE_OTHER:
+		return fred_other(regs);
+	default: break;
+	}
+
+	return fred_bad_type(regs, error_code);
+}
+
+__visible noinstr void fred_entry_from_kernel(struct pt_regs *regs)
+{
+	unsigned long error_code =3D regs->orig_ax;
+
+	/* Invalidate orig_ax so that syscall_get_nr() works correctly */
+	regs->orig_ax =3D -1;
+
+	switch (regs->fred_ss.type) {
+	case EVENT_TYPE_EXTINT:
+		return fred_extint(regs);
+	case EVENT_TYPE_NMI:
+		if (likely(regs->fred_ss.vector =3D=3D X86_TRAP_NMI))
+			return fred_exc_nmi(regs);
+		break;
+	case EVENT_TYPE_HWEXC:
+		return fred_hwexc(regs, error_code);
+	case EVENT_TYPE_PRIV_SWEXC:
+		if (likely(regs->fred_ss.vector =3D=3D X86_TRAP_DB))
+			return fred_exc_debug(regs);
+		break;
+	case EVENT_TYPE_SWEXC:
+		return fred_swexc(regs, error_code);
+	default: break;
+	}
+
+	return fred_bad_type(regs, error_code);
+}
+
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+__visible noinstr void __fred_entry_from_kvm(struct pt_regs *regs)
+{
+	switch (regs->fred_ss.type) {
+	case EVENT_TYPE_EXTINT:
+		return fred_extint(regs);
+	case EVENT_TYPE_NMI:
+		return fred_exc_nmi(regs);
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+#endif
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/=
vsyscall_64.c
index e0ca8120aea8..a3c0df11d0e6 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -76,7 +76,7 @@ static void warn_bad_vsyscall(const char *level, struct pt_=
regs *regs,
 	if (!show_unhandled_signals)
 		return;
=20
-	printk_ratelimited("%s%s[%d] %s ip:%lx cs:%lx sp:%lx ax:%lx si:%lx di:%lx\n=
",
+	printk_ratelimited("%s%s[%d] %s ip:%lx cs:%x sp:%lx ax:%lx si:%lx di:%lx\n",
 			   level, current->comm, task_pid_nr(current),
 			   message, regs->ip, regs->cs,
 			   regs->sp, regs->ax, regs->si, regs->di);
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm=
-prototypes.h
index b1a98fa38828..076bf8dee702 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -12,6 +12,7 @@
 #include <asm/special_insns.h>
 #include <asm/preempt.h>
 #include <asm/asm.h>
+#include <asm/fred.h>
 #include <asm/gsseg.h>
=20
 #ifndef CONFIG_X86_CMPXCHG64
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 0216f63a366b..fe1e7e3cc844 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -33,7 +33,7 @@
  * Returns:
  *     0 - (index < size)
  */
-static inline unsigned long array_index_mask_nospec(unsigned long index,
+static __always_inline unsigned long array_index_mask_nospec(unsigned long i=
ndex,
 		unsigned long size)
 {
 	unsigned long mask;
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufea=
tures.h
index 29cb275a219d..ccbf914b3d1a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -326,7 +326,9 @@
 #define X86_FEATURE_FZRM		(12*32+10) /* "" Fast zero-length REP MOVSB */
 #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
+#define X86_FEATURE_FRED		(12*32+17) /* Flexible Return and Event Delivery */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
+#define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-serializing WRMSR */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD5=
2[H,L]UQ */
 #define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index ab97b22ac04a..ec95fe44fa3a 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -402,8 +402,6 @@ static inline void set_desc_limit(struct desc_struct *des=
c, unsigned long limit)
 	desc->limit1 =3D (limit >> 16) & 0xf;
 }
=20
-void alloc_intr_gate(unsigned int n, const void *addr);
-
 static inline void init_idt_data(struct idt_data *data, unsigned int n,
 				 const void *addr)
 {
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/=
disabled-features.h
index 702d93fdd10e..f40b29d3abad 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -117,6 +117,12 @@
 #define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
 #endif
=20
+#ifdef CONFIG_X86_FRED
+# define DISABLE_FRED	0
+#else
+# define DISABLE_FRED	(1 << (X86_FEATURE_FRED & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -133,7 +139,7 @@
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
-#define DISABLED_MASK12	(DISABLE_LAM)
+#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/as=
m/extable_fixup_types.h
index fe6312045042..7acf0383be80 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -64,6 +64,8 @@
 #define	EX_TYPE_UCOPY_LEN4		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(4))
 #define	EX_TYPE_UCOPY_LEN8		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(8))
=20
-#define EX_TYPE_ZEROPAD			20 /* longword load with zeropad on fault */
+#define	EX_TYPE_ZEROPAD			20 /* longword load with zeropad on fault */
+
+#define	EX_TYPE_ERETU			21
=20
 #endif
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
new file mode 100644
index 000000000000..e86c7ba32435
--- /dev/null
+++ b/arch/x86/include/asm/fred.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros for Flexible Return and Event Delivery (FRED)
+ */
+
+#ifndef ASM_X86_FRED_H
+#define ASM_X86_FRED_H
+
+#include <linux/const.h>
+
+#include <asm/asm.h>
+#include <asm/trapnr.h>
+
+/*
+ * FRED event return instruction opcodes for ERET{S,U}; supported in
+ * binutils >=3D 2.41.
+ */
+#define ERETS			_ASM_BYTES(0xf2,0x0f,0x01,0xca)
+#define ERETU			_ASM_BYTES(0xf3,0x0f,0x01,0xca)
+
+/*
+ * RSP is aligned to a 64-byte boundary before used to push a new stack frame
+ */
+#define FRED_STACK_FRAME_RSP_MASK	_AT(unsigned long, (~0x3f))
+
+/*
+ * Used for the return address for call emulation during code patching,
+ * and measured in 64-byte cache lines.
+ */
+#define FRED_CONFIG_REDZONE_AMOUNT	1
+#define FRED_CONFIG_REDZONE		(_AT(unsigned long, FRED_CONFIG_REDZONE_AMOUNT)=
 << 6)
+#define FRED_CONFIG_INT_STKLVL(l)	(_AT(unsigned long, l) << 9)
+#define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_X86_FRED
+#include <linux/kernel.h>
+
+#include <asm/ptrace.h>
+
+struct fred_info {
+	/* Event data: CR2, DR6, ... */
+	unsigned long edata;
+	unsigned long resv;
+};
+
+/* Full format of the FRED stack frame */
+struct fred_frame {
+	struct pt_regs   regs;
+	struct fred_info info;
+};
+
+static __always_inline struct fred_info *fred_info(struct pt_regs *regs)
+{
+	return &container_of(regs, struct fred_frame, regs)->info;
+}
+
+static __always_inline unsigned long fred_event_data(struct pt_regs *regs)
+{
+	return fred_info(regs)->edata;
+}
+
+void asm_fred_entrypoint_user(void);
+void asm_fred_entrypoint_kernel(void);
+void asm_fred_entry_from_kvm(struct fred_ss);
+
+__visible void fred_entry_from_user(struct pt_regs *regs);
+__visible void fred_entry_from_kernel(struct pt_regs *regs);
+__visible void __fred_entry_from_kvm(struct pt_regs *regs);
+
+/* Can be called from noinstr code, thus __always_inline */
+static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned =
int vector)
+{
+	struct fred_ss ss =3D {
+		.ss     =3D__KERNEL_DS,
+		.type   =3D type,
+		.vector =3D vector,
+		.nmi    =3D type =3D=3D EVENT_TYPE_NMI,
+		.lm     =3D 1,
+	};
+
+	asm_fred_entry_from_kvm(ss);
+}
+
+void cpu_init_fred_exceptions(void);
+void fred_complete_exception_setup(void);
+
+#else /* CONFIG_X86_FRED */
+static __always_inline unsigned long fred_event_data(struct pt_regs *regs) {=
 return 0; }
+static inline void cpu_init_fred_exceptions(void) { }
+static inline void fred_complete_exception_setup(void) { }
+static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned =
int vector) { }
+#endif /* CONFIG_X86_FRED */
+#endif /* !__ASSEMBLY__ */
+
+#endif /* ASM_X86_FRED_H */
diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index c7ef6ea2fa99..4212c00c9708 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -69,7 +69,7 @@ extern void ia32_pick_mmap_layout(struct mm_struct *mm);
=20
 extern bool __ia32_enabled;
=20
-static inline bool ia32_enabled(void)
+static __always_inline bool ia32_enabled(void)
 {
 	return __ia32_enabled;
 }
@@ -81,7 +81,7 @@ static inline void ia32_disable(void)
=20
 #else /* !CONFIG_IA32_EMULATION */
=20
-static inline bool ia32_enabled(void)
+static __always_inline bool ia32_enabled(void)
 {
 	return IS_ENABLED(CONFIG_X86_32);
 }
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 13639e57e1f8..47d4c04d103d 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -13,15 +13,18 @@
=20
 #include <asm/irq_stack.h>
=20
+typedef void (*idtentry_t)(struct pt_regs *regs);
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
  * @vector:	Vector number (ignored for C)
  * @func:	Function name of the entry point
  *
- * Declares three functions:
+ * Declares four functions:
  * - The ASM entry point: asm_##func
  * - The XEN PV trap entry point: xen_##func (maybe unused)
+ * - The C handler called from the FRED event dispatcher (maybe unused)
  * - The C handler called from the ASM entry point
  *
  * Note: This is the C variant of DECLARE_IDTENTRY(). As the name says it
@@ -31,6 +34,7 @@
 #define DECLARE_IDTENTRY(vector, func)					\
 	asmlinkage void asm_##func(void);				\
 	asmlinkage void xen_asm_##func(void);				\
+	void fred_##func(struct pt_regs *regs);				\
 	__visible void func(struct pt_regs *regs)
=20
 /**
@@ -137,6 +141,17 @@ static __always_inline void __##func(struct pt_regs *reg=
s,		\
 #define DEFINE_IDTENTRY_RAW(func)					\
 __visible noinstr void func(struct pt_regs *regs)
=20
+/**
+ * DEFINE_FREDENTRY_RAW - Emit code for raw FRED entry points
+ * @func:	Function name of the entry point
+ *
+ * @func is called from the FRED event dispatcher with interrupts disabled.
+ *
+ * See @DEFINE_IDTENTRY_RAW for further details.
+ */
+#define DEFINE_FREDENTRY_RAW(func)					\
+noinstr void fred_##func(struct pt_regs *regs)
+
 /**
  * DECLARE_IDTENTRY_RAW_ERRORCODE - Declare functions for raw IDT entry poin=
ts
  *				    Error code pushed by hardware
@@ -233,17 +248,27 @@ static noinline void __##func(struct pt_regs *regs, u32=
 vector)
 #define DEFINE_IDTENTRY_SYSVEC(func)					\
 static void __##func(struct pt_regs *regs);				\
 									\
+static __always_inline void instr_##func(struct pt_regs *regs)		\
+{									\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	run_sysvec_on_irqstack_cond(__##func, regs);			\
+}									\
+									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state =3D irqentry_enter(regs);			\
 									\
 	instrumentation_begin();					\
-	kvm_set_cpu_l1tf_flush_l1d();					\
-	run_sysvec_on_irqstack_cond(__##func, regs);			\
+	instr_##func (regs);						\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
 }									\
 									\
+void fred_##func(struct pt_regs *regs)					\
+{									\
+	instr_##func (regs);						\
+}									\
+									\
 static noinline void __##func(struct pt_regs *regs)
=20
 /**
@@ -260,19 +285,29 @@ static noinline void __##func(struct pt_regs *regs)
 #define DEFINE_IDTENTRY_SYSVEC_SIMPLE(func)				\
 static __always_inline void __##func(struct pt_regs *regs);		\
 									\
-__visible noinstr void func(struct pt_regs *regs)			\
+static __always_inline void instr_##func(struct pt_regs *regs)		\
 {									\
-	irqentry_state_t state =3D irqentry_enter(regs);			\
-									\
-	instrumentation_begin();					\
 	__irq_enter_raw();						\
 	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs);						\
 	__irq_exit_raw();						\
+}									\
+									\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	irqentry_state_t state =3D irqentry_enter(regs);			\
+									\
+	instrumentation_begin();					\
+	instr_##func (regs);						\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
 }									\
 									\
+void fred_##func(struct pt_regs *regs)					\
+{									\
+	instr_##func (regs);						\
+}									\
+									\
 static __always_inline void __##func(struct pt_regs *regs)
=20
 /**
@@ -410,17 +445,35 @@ __visible noinstr void func(struct pt_regs *regs,			\
 /* C-Code mapping */
 #define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_RAW
 #define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
+#define DEFINE_FREDENTRY_NMI		DEFINE_FREDENTRY_RAW
=20
 #ifdef CONFIG_X86_64
 #define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE_USER	DEFINE_IDTENTRY_NOIST
+#define DEFINE_FREDENTRY_MCE		DEFINE_FREDENTRY_RAW
=20
 #define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG_USER	DEFINE_IDTENTRY_NOIST
+#define DEFINE_FREDENTRY_DEBUG		DEFINE_FREDENTRY_RAW
+#endif
+
+void idt_install_sysvec(unsigned int n, const void *function);
+
+#ifdef CONFIG_X86_FRED
+void fred_install_sysvec(unsigned int vector, const idtentry_t function);
+#else
+static inline void fred_install_sysvec(unsigned int vector, const idtentry_t=
 function) { }
 #endif
=20
+#define sysvec_install(vector, function) {				\
+	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
+		fred_install_sysvec(vector, function);			\
+	else								\
+		idt_install_sysvec(vector, asm_##function);		\
+}
+
 #else /* !__ASSEMBLY__ */
=20
 /*
@@ -447,7 +500,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
=20
 /* System vector entries */
 #define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
-	idtentry_sysvec vector func
+	DECLARE_IDTENTRY(vector, func)
=20
 #ifdef CONFIG_X86_64
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
@@ -655,23 +708,36 @@ DECLARE_IDTENTRY(RESCHEDULE_VECTOR,			sysvec_reschedule=
_ipi);
 DECLARE_IDTENTRY_SYSVEC(REBOOT_VECTOR,			sysvec_reboot);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_si=
ngle);
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VECTOR,		sysvec_call_function);
+#else
+# define fred_sysvec_reschedule_ipi			NULL
+# define fred_sysvec_reboot				NULL
+# define fred_sysvec_call_function_single		NULL
+# define fred_sysvec_call_function			NULL
 #endif
=20
 #ifdef CONFIG_X86_LOCAL_APIC
 # ifdef CONFIG_X86_MCE_THRESHOLD
 DECLARE_IDTENTRY_SYSVEC(THRESHOLD_APIC_VECTOR,		sysvec_threshold);
+# else
+# define fred_sysvec_threshold				NULL
 # endif
=20
 # ifdef CONFIG_X86_MCE_AMD
 DECLARE_IDTENTRY_SYSVEC(DEFERRED_ERROR_VECTOR,		sysvec_deferred_error);
+# else
+# define fred_sysvec_deferred_error			NULL
 # endif
=20
 # ifdef CONFIG_X86_THERMAL_VECTOR
 DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VECTOR,		sysvec_thermal);
+# else
+# define fred_sysvec_thermal				NULL
 # endif
=20
 # ifdef CONFIG_IRQ_WORK
 DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,		sysvec_irq_work);
+# else
+# define fred_sysvec_irq_work				NULL
 # endif
 #endif
=20
@@ -679,12 +745,16 @@ DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,		sysvec_irq_wo=
rk);
 DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_VECTOR,		sysvec_kvm_posted_intr_ipi);
 DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	sysvec_kvm_posted_intr_wa=
keup_ipi);
 DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_ne=
sted_ipi);
+#else
+# define fred_sysvec_kvm_posted_intr_ipi		NULL
+# define fred_sysvec_kvm_posted_intr_wakeup_ipi		NULL
+# define fred_sysvec_kvm_posted_intr_nested_ipi		NULL
 #endif
=20
 #if IS_ENABLED(CONFIG_HYPERV)
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
 DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlig=
htenment);
-DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
+DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,		sysvec_hyperv_stimer0);
 #endif
=20
 #if IS_ENABLED(CONFIG_ACRN_GUEST)
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index f1bd7b91b3c6..1f9dc9bd13eb 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -36,8 +36,19 @@
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
=20
-/* Intel MSRs. Some also available on other CPUs */
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0	0x1cc			/* Level 0 stack pointer */
+#define MSR_IA32_FRED_RSP1	0x1cd			/* Level 1 stack pointer */
+#define MSR_IA32_FRED_RSP2	0x1ce			/* Level 2 stack pointer */
+#define MSR_IA32_FRED_RSP3	0x1cf			/* Level 3 stack pointer */
+#define MSR_IA32_FRED_STKLVLS	0x1d0			/* Exception stack levels */
+#define MSR_IA32_FRED_SSP0	MSR_IA32_PL0_SSP	/* Level 0 shadow stack pointer =
*/
+#define MSR_IA32_FRED_SSP1	0x1d1			/* Level 1 shadow stack pointer */
+#define MSR_IA32_FRED_SSP2	0x1d2			/* Level 2 shadow stack pointer */
+#define MSR_IA32_FRED_SSP3	0x1d3			/* Level 3 shadow stack pointer */
+#define MSR_IA32_FRED_CONFIG	0x1d4			/* Entrypoint and interrupt stack level=
 */
=20
+/* Intel MSRs. Some also available on other CPUs */
 #define MSR_TEST_CTRL				0x00000033
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT=
_BIT)
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 65ec1965cd28..c284ff9ebe67 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -97,6 +97,19 @@ static __always_inline void __wrmsr(unsigned int msr, u32 =
low, u32 high)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
=20
+/*
+ * WRMSRNS behaves exactly like WRMSR with the only difference being
+ * that it is not a serializing instruction by default.
+ */
+static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
+{
+	/* Instruction opcode for WRMSRNS; supported in binutils >=3D 2.40. */
+	asm volatile("1: .byte 0x0f,0x01,0xc6\n"
+		     "2:\n"
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
+		     : : "c" (msr), "a"(low), "d" (high));
+}
+
 #define native_rdmsr(msr, val1, val2)			\
 do {							\
 	u64 __val =3D __rdmsr((msr));			\
@@ -297,6 +310,11 @@ do {							\
=20
 #endif	/* !CONFIG_PARAVIRT_XXL */
=20
+static __always_inline void wrmsrns(u32 msr, u64 val)
+{
+	__wrmsrns(msr, val, val >> 32);
+}
+
 /*
  * 64-bit version of wrmsr_safe():
  */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index 26620d7642a9..17fe81998ce4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -664,8 +664,10 @@ static __always_inline void prefetchw(const void *x)
 #else
 extern unsigned long __end_init_task[];
=20
-#define INIT_THREAD {							    \
-	.sp	=3D (unsigned long)&__end_init_task - sizeof(struct pt_regs), \
+#define INIT_THREAD {							\
+	.sp	=3D (unsigned long)&__end_init_task -			\
+		  TOP_OF_KERNEL_STACK_PADDING -				\
+		  sizeof(struct pt_regs),				\
 }
=20
 extern unsigned long KSTK_ESP(struct task_struct *task);
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index f4db78b09c8f..5a83fbd9bc0b 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -56,18 +56,64 @@ struct pt_regs {
=20
 #else /* __i386__ */
=20
+struct fred_cs {
+		/* CS selector */
+	u64	cs	: 16,
+		/* Stack level at event time */
+		sl	:  2,
+		/* IBT in WAIT_FOR_ENDBRANCH state */
+		wfe	:  1,
+			: 45;
+};
+
+struct fred_ss {
+		/* SS selector */
+	u64	ss	: 16,
+		/* STI state */
+		sti	:  1,
+		/* Set if syscall, sysenter or INT n */
+		swevent	:  1,
+		/* Event is NMI type */
+		nmi	:  1,
+			: 13,
+		/* Event vector */
+		vector	:  8,
+			:  8,
+		/* Event type */
+		type	:  4,
+			:  4,
+		/* Event was incident to enclave execution */
+		enclave	:  1,
+		/* CPU was in long mode */
+		lm	:  1,
+		/*
+		 * Nested exception during FRED delivery, not set
+		 * for #DF.
+		 */
+		nested	:  1,
+			:  1,
+		/*
+		 * The length of the instruction causing the event.
+		 * Only set for INTO, INT1, INT3, INT n, SYSCALL
+		 * and SYSENTER.  0 otherwise.
+		 */
+		insnlen	:  4;
+};
+
 struct pt_regs {
-/*
- * C ABI says these regs are callee-preserved. They aren't saved on kernel e=
ntry
- * unless syscall needs a complete, fully filled "struct pt_regs".
- */
+	/*
+	 * C ABI says these regs are callee-preserved. They aren't saved on
+	 * kernel entry unless syscall needs a complete, fully filled
+	 * "struct pt_regs".
+	 */
 	unsigned long r15;
 	unsigned long r14;
 	unsigned long r13;
 	unsigned long r12;
 	unsigned long bp;
 	unsigned long bx;
-/* These regs are callee-clobbered. Always saved on kernel entry. */
+
+	/* These regs are callee-clobbered. Always saved on kernel entry. */
 	unsigned long r11;
 	unsigned long r10;
 	unsigned long r9;
@@ -77,18 +123,50 @@ struct pt_regs {
 	unsigned long dx;
 	unsigned long si;
 	unsigned long di;
-/*
- * On syscall entry, this is syscall#. On CPU exception, this is error code.
- * On hw interrupt, it's IRQ number:
- */
+
+	/*
+	 * orig_ax is used on entry for:
+	 * - the syscall number (syscall, sysenter, int80)
+	 * - error_code stored by the CPU on traps and exceptions
+	 * - the interrupt number for device interrupts
+	 *
+	 * A FRED stack frame starts here:
+	 *   1) It _always_ includes an error code;
+	 *
+	 *   2) The return frame for ERET[US] starts here, but
+	 *      the content of orig_ax is ignored.
+	 */
 	unsigned long orig_ax;
-/* Return frame for iretq */
+
+	/* The IRETQ return frame starts here */
 	unsigned long ip;
-	unsigned long cs;
+
+	union {
+		/* CS selector */
+		u16		cs;
+		/* The extended 64-bit data slot containing CS */
+		u64		csx;
+		/* The FRED CS extension */
+		struct fred_cs	fred_cs;
+	};
+
 	unsigned long flags;
 	unsigned long sp;
-	unsigned long ss;
-/* top of stack page */
+
+	union {
+		/* SS selector */
+		u16		ss;
+		/* The extended 64-bit data slot containing SS */
+		u64		ssx;
+		/* The FRED SS extension */
+		struct fred_ss	fred_ss;
+	};
+
+	/*
+	 * Top of stack on IDT systems, while FRED systems have extra fields
+	 * defined above for storing exception related information, e.g. CR2 or
+	 * DR6.
+	 */
 };
=20
 #endif /* !__i386__ */
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_t=
o.h
index f42dbf17f52b..c3bd0c0758c9 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -70,9 +70,13 @@ static inline void update_task_stack(struct task_struct *t=
ask)
 #ifdef CONFIG_X86_32
 	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
-	/* Xen PV enters the kernel on the thread stack. */
-	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		/* WRMSRNS is a baseline feature for FRED. */
+		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_=
SIZE);
+	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
+		/* Xen PV enters the kernel on the thread stack. */
 		load_sp0(task_top_of_stack(task));
+	}
 #endif
 }
=20
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread=
_info.h
index d63b02940747..12da7dfd5ef1 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -31,7 +31,9 @@
  * In vm86 mode, the hardware frame is much longer still, so add 16
  * bytes to make room for the real-mode segments.
  *
- * x86_64 has a fixed-length stack frame.
+ * x86-64 has a fixed-length stack frame, but it depends on whether
+ * or not FRED is enabled. Future versions of FRED might make this
+ * dynamic, but for now it is always 2 words longer.
  */
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_VM86
@@ -39,8 +41,12 @@
 # else
 #  define TOP_OF_KERNEL_STACK_PADDING 8
 # endif
-#else
-# define TOP_OF_KERNEL_STACK_PADDING 0
+#else /* x86-64 */
+# ifdef CONFIG_X86_FRED
+#  define TOP_OF_KERNEL_STACK_PADDING (2 * 8)
+# else
+#  define TOP_OF_KERNEL_STACK_PADDING 0
+# endif
 #endif
=20
 /*
diff --git a/arch/x86/include/asm/trapnr.h b/arch/x86/include/asm/trapnr.h
index f5d2325aa0b7..8d1154cdf787 100644
--- a/arch/x86/include/asm/trapnr.h
+++ b/arch/x86/include/asm/trapnr.h
@@ -2,6 +2,18 @@
 #ifndef _ASM_X86_TRAPNR_H
 #define _ASM_X86_TRAPNR_H
=20
+/*
+ * Event type codes used by FRED, Intel VT-x and AMD SVM
+ */
+#define EVENT_TYPE_EXTINT	0	// External interrupt
+#define EVENT_TYPE_RESERVED	1
+#define EVENT_TYPE_NMI		2	// NMI
+#define EVENT_TYPE_HWEXC	3	// Hardware originated traps, exceptions
+#define EVENT_TYPE_SWINT	4	// INT n
+#define EVENT_TYPE_PRIV_SWEXC	5	// INT1
+#define EVENT_TYPE_SWEXC	6	// INTO, INT3
+#define EVENT_TYPE_OTHER	7	// FRED SYSCALL/SYSENTER, VT-x MTF
+
 /* Interrupts/Exceptions */
=20
 #define X86_TRAP_DE		 0	/* Divide-by-zero */
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 0e73616b82f3..4dba17363008 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
=20
 #include <uapi/asm/vmx.h>
+#include <asm/trapnr.h>
 #include <asm/vmxfeatures.h>
=20
 #define VMCS_CONTROL_BIT(x)	BIT(VMX_FEATURE_##x & 0x1f)
@@ -374,14 +375,14 @@ enum vmcs_field {
 #define VECTORING_INFO_DELIVER_CODE_MASK    	INTR_INFO_DELIVER_CODE_MASK
 #define VECTORING_INFO_VALID_MASK       	INTR_INFO_VALID_MASK
=20
-#define INTR_TYPE_EXT_INTR              (0 << 8) /* external interrupt */
-#define INTR_TYPE_RESERVED              (1 << 8) /* reserved */
-#define INTR_TYPE_NMI_INTR		(2 << 8) /* NMI */
-#define INTR_TYPE_HARD_EXCEPTION	(3 << 8) /* processor exception */
-#define INTR_TYPE_SOFT_INTR             (4 << 8) /* software interrupt */
-#define INTR_TYPE_PRIV_SW_EXCEPTION	(5 << 8) /* ICE breakpoint - undocumente=
d */
-#define INTR_TYPE_SOFT_EXCEPTION	(6 << 8) /* software exception */
-#define INTR_TYPE_OTHER_EVENT           (7 << 8) /* other event */
+#define INTR_TYPE_EXT_INTR		(EVENT_TYPE_EXTINT << 8)	/* external interrupt */
+#define INTR_TYPE_RESERVED		(EVENT_TYPE_RESERVED << 8)	/* reserved */
+#define INTR_TYPE_NMI_INTR		(EVENT_TYPE_NMI << 8)		/* NMI */
+#define INTR_TYPE_HARD_EXCEPTION	(EVENT_TYPE_HWEXC << 8)		/* processor excep=
tion */
+#define INTR_TYPE_SOFT_INTR		(EVENT_TYPE_SWINT << 8)		/* software interrupt =
*/
+#define INTR_TYPE_PRIV_SW_EXCEPTION	(EVENT_TYPE_PRIV_SWEXC << 8)	/* ICE brea=
kpoint */
+#define INTR_TYPE_SOFT_EXCEPTION	(EVENT_TYPE_SWEXC << 8)		/* software except=
ion */
+#define INTR_TYPE_OTHER_EVENT		(EVENT_TYPE_OTHER << 8)		/* other event */
=20
 /* GUEST_INTERRUPTIBILITY_INFO flags. */
 #define GUEST_INTR_STATE_STI		0x00000001
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/u=
api/asm/processor-flags.h
index d898432947ff..f1a4adc78272 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -139,6 +139,13 @@
 #define X86_CR4_LAM_SUP_BIT	28 /* LAM for supervisor pointers */
 #define X86_CR4_LAM_SUP		_BITUL(X86_CR4_LAM_SUP_BIT)
=20
+#ifdef __x86_64__
+#define X86_CR4_FRED_BIT	32 /* enable FRED kernel entry */
+#define X86_CR4_FRED		_BITUL(X86_CR4_FRED_BIT)
+#else
+#define X86_CR4_FRED		(0)
+#endif
+
 /*
  * x86-64 Task Priority Register, CR8
  */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0000325ab98f..0dcbfc1a4c41 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -48,6 +48,7 @@ obj-y			+=3D platform-quirks.o
 obj-y			+=3D process_$(BITS).o signal.o signal_$(BITS).o
 obj-y			+=3D traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+=3D time.o ioport.o dumpstack.o nmi.o
+obj-$(CONFIG_X86_FRED)	+=3D fred.o
 obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+=3D ldt.o
 obj-$(CONFIG_X86_KERNEL_IBT)		+=3D ibt_selftest.o
 obj-y			+=3D setup.o x86_init.o i8259.o irqinit.o
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index bfeb18fad63f..2c5b51aad91a 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -26,8 +26,8 @@ static u32 __init acrn_detect(void)
=20
 static void __init acrn_init_platform(void)
 {
-	/* Setup the IDT for ACRN hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_acrn_hv_callback);
+	/* Install system interrupt handler for ACRN hypervisor callback */
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
=20
 	x86_platform.calibrate_tsc =3D acrn_get_tsc_khz;
 	x86_platform.calibrate_cpu =3D acrn_get_tsc_khz;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0b97bcde70c6..cf82e3181f7a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -61,6 +61,7 @@
 #include <asm/microcode.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
+#include <asm/fred.h>
 #include <asm/uv/uv.h>
 #include <asm/ia32.h>
 #include <asm/set_memory.h>
@@ -382,9 +383,8 @@ static __always_inline void setup_umip(struct cpuinfo_x86=
 *c)
 }
=20
 /* These bits should not change their value after CPU init is finished. */
-static const unsigned long cr4_pinned_mask =3D
-	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
-	X86_CR4_FSGSBASE | X86_CR4_CET;
+static const unsigned long cr4_pinned_mask =3D X86_CR4_SMEP | X86_CR4_SMAP |=
 X86_CR4_UMIP |
+					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
=20
@@ -2067,10 +2067,8 @@ static void wrmsrl_cstar(unsigned long val)
 		wrmsrl(MSR_CSTAR, val);
 }
=20
-/* May not be marked __init: used by software suspend */
-void syscall_init(void)
+static inline void idt_syscall_init(void)
 {
-	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
=20
 	if (ia32_enabled()) {
@@ -2104,6 +2102,23 @@ void syscall_init(void)
 	       X86_EFLAGS_AC|X86_EFLAGS_ID);
 }
=20
+/* May not be marked __init: used by software suspend */
+void syscall_init(void)
+{
+	/* The default user and kernel segments */
+	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
+
+	/*
+	 * Except the IA32_STAR MSR, there is NO need to setup SYSCALL and
+	 * SYSENTER MSRs for FRED, because FRED uses the ring 3 FRED
+	 * entrypoint for SYSCALL and SYSENTER, and ERETU is the only legit
+	 * instruction to return to ring 3 (both sysexit and sysret cause
+	 * #UD when FRED is enabled).
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		idt_syscall_init();
+}
+
 #else	/* CONFIG_X86_64 */
=20
 #ifdef CONFIG_STACKPROTECTOR
@@ -2207,8 +2222,9 @@ void cpu_init_exception_handling(void)
 	/* paranoid_entry() gets the CPU number from the GDT */
 	setup_getcpu(cpu);
=20
-	/* IST vectors need TSS to be set up. */
-	tss_setup_ist(tss);
+	/* For IDT mode, IST vectors need to be set in TSS. */
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		tss_setup_ist(tss);
 	tss_setup_io_bitmap(tss);
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
=20
@@ -2217,8 +2233,10 @@ void cpu_init_exception_handling(void)
 	/* GHCB needs to be setup to handle #VC. */
 	setup_ghcb();
=20
-	/* Finally load the IDT */
-	load_current_idt();
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		cpu_init_fred_exceptions();
+	else
+		load_current_idt();
 }
=20
 /*
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-dep=
s.c
index e462c1d3800a..b7174209d855 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -82,6 +82,8 @@ static const struct cpuid_dep cpuid_deps[] =3D {
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
+	{ X86_FEATURE_FRED,			X86_FEATURE_WRMSRNS   },
 	{}
 };
=20
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bc39252bc54f..04acdc3534c8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -46,6 +46,7 @@
 #include <linux/hardirq.h>
 #include <linux/kexec.h>
=20
+#include <asm/fred.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
 #include <asm/traps.h>
@@ -2166,6 +2167,31 @@ DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 	exc_machine_check_user(regs);
 	local_db_restore(dr7);
 }
+
+#ifdef CONFIG_X86_FRED
+/*
+ * When occurred on different ring level, i.e., from user or kernel
+ * context, #MCE needs to be handled on different stack: User #MCE
+ * on current task stack, while kernel #MCE on a dedicated stack.
+ *
+ * This is exactly how FRED event delivery invokes an exception
+ * handler: ring 3 event on level 0 stack, i.e., current task stack;
+ * ring 0 event on the #MCE dedicated stack specified in the
+ * IA32_FRED_STKLVLS MSR. So unlike IDT, the FRED machine check entry
+ * stub doesn't do stack switch.
+ */
+DEFINE_FREDENTRY_MCE(exc_machine_check)
+{
+	unsigned long dr7;
+
+	dr7 =3D local_db_save();
+	if (user_mode(regs))
+		exc_machine_check_user(regs);
+	else
+		exc_machine_check_kernel(regs);
+	local_db_restore(dr7);
+}
+#endif
 #else
 /* 32bit unified entry point */
 DEFINE_IDTENTRY_RAW(exc_machine_check)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 01fa06dd06b6..45e0e70e238c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -539,19 +539,18 @@ static void __init ms_hyperv_init_platform(void)
 	 */
 	x86_platform.apic_post_init =3D hyperv_init;
 	hyperv_setup_mmu_ops();
-	/* Setup the IDT for hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_hyperv_callback);
=20
-	/* Setup the IDT for reenlightenment notifications */
+	/* Install system interrupt handler for hypervisor callback */
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
+
+	/* Install system interrupt handler for reenlightenment notifications */
 	if (ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT) {
-		alloc_intr_gate(HYPERV_REENLIGHTENMENT_VECTOR,
-				asm_sysvec_hyperv_reenlightenment);
+		sysvec_install(HYPERV_REENLIGHTENMENT_VECTOR, sysvec_hyperv_reenlightenmen=
t);
 	}
=20
-	/* Setup the IDT for stimer0 */
+	/* Install system interrupt handler for stimer0 */
 	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE) {
-		alloc_intr_gate(HYPERV_STIMER0_VECTOR,
-				asm_sysvec_hyperv_stimer0);
+		sysvec_install(HYPERV_STIMER0_VECTOR, sysvec_hyperv_stimer0);
 	}
=20
 # ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index 16f9814c9be0..6726e0473d0b 100644
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -106,6 +106,10 @@ void __init init_espfix_bsp(void)
 	pgd_t *pgd;
 	p4d_t *p4d;
=20
+	/* FRED systems always restore the full value of %rsp */
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		return;
+
 	/* Install the espfix pud into the kernel page directory */
 	pgd =3D &init_top_pgt[pgd_index(ESPFIX_BASE_ADDR)];
 	p4d =3D p4d_alloc(&init_mm, pgd, ESPFIX_BASE_ADDR);
@@ -129,6 +133,10 @@ void init_espfix_ap(int cpu)
 	void *stack_page;
 	pteval_t ptemask;
=20
+	/* FRED systems always restore the full value of %rsp */
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		return;
+
 	/* We only have to do this once... */
 	if (likely(per_cpu(espfix_stack, cpu)))
 		return;		/* Already initialized */
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
new file mode 100644
index 000000000000..4bcd8791ad96
--- /dev/null
+++ b/arch/x86/kernel/fred.c
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/kernel.h>
+
+#include <asm/desc.h>
+#include <asm/fred.h>
+#include <asm/tlbflush.h>
+#include <asm/traps.h>
+
+/* #DB in the kernel would imply the use of a kernel debugger. */
+#define FRED_DB_STACK_LEVEL		1UL
+#define FRED_NMI_STACK_LEVEL		2UL
+#define FRED_MC_STACK_LEVEL		2UL
+/*
+ * #DF is the highest level because a #DF means "something went wrong
+ * *while delivering an exception*." The number of cases for which that
+ * can happen with FRED is drastically reduced and basically amounts to
+ * "the stack you pointed me to is broken." Thus, always change stacks
+ * on #DF, which means it should be at the highest level.
+ */
+#define FRED_DF_STACK_LEVEL		3UL
+
+#define FRED_STKLVL(vector, lvl)	((lvl) << (2 * (vector)))
+
+void cpu_init_fred_exceptions(void)
+{
+	/* When FRED is enabled by default, remove this log message */
+	pr_info("Initialize FRED on CPU%d\n", smp_processor_id());
+
+	wrmsrl(MSR_IA32_FRED_CONFIG,
+	       /* Reserve for CALL emulation */
+	       FRED_CONFIG_REDZONE |
+	       FRED_CONFIG_INT_STKLVL(0) |
+	       FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
+
+	/*
+	 * The purpose of separate stacks for NMI, #DB and #MC *in the kernel*
+	 * (remember that user space faults are always taken on stack level 0)
+	 * is to avoid overflowing the kernel stack.
+	 */
+	wrmsrl(MSR_IA32_FRED_STKLVLS,
+	       FRED_STKLVL(X86_TRAP_DB,  FRED_DB_STACK_LEVEL) |
+	       FRED_STKLVL(X86_TRAP_NMI, FRED_NMI_STACK_LEVEL) |
+	       FRED_STKLVL(X86_TRAP_MC,  FRED_MC_STACK_LEVEL) |
+	       FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
+
+	/* The FRED equivalents to IST stacks... */
+	wrmsrl(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(DB));
+	wrmsrl(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(NMI));
+	wrmsrl(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(DF));
+
+	/* Enable FRED */
+	cr4_set_bits(X86_CR4_FRED);
+	/* Any further IDT use is a bug */
+	idt_invalidate();
+
+	/* Use int $0x80 for 32-bit system calls in FRED mode */
+	setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
+	setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
+}
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d4918d03efb4..c38e43589046 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -26,6 +26,7 @@
 #include <asm/apicdef.h>
 #include <asm/fixmap.h>
 #include <asm/smp.h>
+#include <asm/thread_info.h>
=20
 /*
  * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
@@ -66,7 +67,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	mov	%rsi, %r15
=20
 	/* Set up the stack for verify_cpu() */
-	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
+	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %=
rsp
=20
 	leaq	_text(%rip), %rdi
=20
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 660b601f1d6c..0cd53fa8c65d 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -337,7 +337,7 @@ void idt_invalidate(void)
 	load_idt(&idt);
 }
=20
-void __init alloc_intr_gate(unsigned int n, const void *addr)
+void __init idt_install_sysvec(unsigned int n, const void *function)
 {
 	if (WARN_ON(n < FIRST_SYSTEM_VECTOR))
 		return;
@@ -346,5 +346,5 @@ void __init alloc_intr_gate(unsigned int n, const void *a=
ddr)
 		return;
=20
 	if (!WARN_ON(test_and_set_bit(n, system_vectors)))
-		set_intr_gate(n, addr);
+		set_intr_gate(n, function);
 }
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index c683666876f1..f79c5edc0b89 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/i8259.h>
 #include <asm/traps.h>
+#include <asm/fred.h>
 #include <asm/prom.h>
=20
 /*
@@ -96,7 +97,11 @@ void __init native_init_IRQ(void)
 	/* Execute any quirks before the call gates are initialised: */
 	x86_init.irqs.pre_vector_init();
=20
-	idt_setup_apic_and_irq_gates();
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		fred_complete_exception_setup();
+	else
+		idt_setup_apic_and_irq_gates();
+
 	lapic_assign_system_vectors();
=20
 	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs()) {
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index dfe9945b9bec..b05557918ae2 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -829,7 +829,7 @@ static void __init kvm_guest_init(void)
=20
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_INT) && kvmapf) {
 		static_branch_enable(&kvm_async_pf_enabled);
-		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_kvm_asyncpf_interru=
pt);
+		sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_kvm_asyncpf_interrupt);
 	}
=20
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 17e955ab69fe..3130a66b0f48 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -35,6 +35,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/microcode.h>
 #include <asm/sev.h>
+#include <asm/fred.h>
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
@@ -651,6 +652,47 @@ void nmi_backtrace_stall_check(const struct cpumask *btp)
=20
 #endif
=20
+#ifdef CONFIG_X86_FRED
+/*
+ * With FRED, CR2/DR6 is pushed to #PF/#DB stack frame during FRED
+ * event delivery, i.e., there is no problem of transient states.
+ * And NMI unblocking only happens when the stack frame indicates
+ * that so should happen.
+ *
+ * Thus, the NMI entry stub for FRED is really straightforward and
+ * as simple as most exception handlers. As such, #DB is allowed
+ * during NMI handling.
+ */
+DEFINE_FREDENTRY_NMI(exc_nmi)
+{
+	irqentry_state_t irq_state;
+
+	if (arch_cpu_is_offline(smp_processor_id())) {
+		if (microcode_nmi_handler_enabled())
+			microcode_offline_nmi_handler();
+		return;
+	}
+
+	/*
+	 * Save CR2 for eventual restore to cover the case where the NMI
+	 * hits the VMENTER/VMEXIT region where guest CR2 is life. This
+	 * prevents guest state corruption in case that the NMI handler
+	 * takes a page fault.
+	 */
+	this_cpu_write(nmi_cr2, read_cr2());
+
+	irq_state =3D irqentry_nmi_enter(regs);
+
+	inc_irq_stat(__nmi_count);
+	default_do_nmi(regs);
+
+	irqentry_nmi_exit(regs, irq_state);
+
+	if (unlikely(this_cpu_read(nmi_cr2) !=3D read_cr2()))
+		write_cr2(this_cpu_read(nmi_cr2));
+}
+#endif
+
 void stop_nmi(void)
 {
 	ignore_nmis++;
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 33b268747bb7..c075591b7b46 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -56,6 +56,7 @@
 #include <asm/resctrl.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
+#include <asm/fred.h>
 #ifdef CONFIG_IA32_EMULATION
 /* Not included via unistd.h */
 #include <asm/unistd_32_ia32.h>
@@ -117,7 +118,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mod=
e mode,
=20
 	printk("%sFS:  %016lx(%04x) GS:%016lx(%04x) knlGS:%016lx\n",
 	       log_lvl, fs, fsindex, gs, gsindex, shadowgs);
-	printk("%sCS:  %04lx DS: %04x ES: %04x CR0: %016lx\n",
+	printk("%sCS:  %04x DS: %04x ES: %04x CR0: %016lx\n",
 		log_lvl, regs->cs, ds, es, cr0);
 	printk("%sCR2: %016lx CR3: %016lx CR4: %016lx\n",
 		log_lvl, cr2, cr3, cr4);
@@ -166,7 +167,29 @@ static noinstr unsigned long __rdgsbase_inactive(void)
=20
 	lockdep_assert_irqs_disabled();
=20
-	if (!cpu_feature_enabled(X86_FEATURE_XENPV)) {
+	/*
+	 * SWAPGS is no longer needed thus NOT allowed with FRED because
+	 * FRED transitions ensure that an operating system can _always_
+	 * operate with its own GS base address:
+	 * - For events that occur in ring 3, FRED event delivery swaps
+	 *   the GS base address with the IA32_KERNEL_GS_BASE MSR.
+	 * - ERETU (the FRED transition that returns to ring 3) also swaps
+	 *   the GS base address with the IA32_KERNEL_GS_BASE MSR.
+	 *
+	 * And the operating system can still setup the GS segment for a
+	 * user thread without the need of loading a user thread GS with:
+	 * - Using LKGS, available with FRED, to modify other attributes
+	 *   of the GS segment without compromising its ability always to
+	 *   operate with its own GS base address.
+	 * - Accessing the GS segment base address for a user thread as
+	 *   before using RDMSR or WRMSR on the IA32_KERNEL_GS_BASE MSR.
+	 *
+	 * Note, LKGS loads the GS base address into the IA32_KERNEL_GS_BASE
+	 * MSR instead of the GS segment=E2=80=99s descriptor cache. As such, the
+	 * operating system never changes its runtime GS base address.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    !cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		native_swapgs();
 		gsbase =3D rdgsbase();
 		native_swapgs();
@@ -191,7 +214,8 @@ static noinstr void __wrgsbase_inactive(unsigned long gsb=
ase)
 {
 	lockdep_assert_irqs_disabled();
=20
-	if (!cpu_feature_enabled(X86_FEATURE_XENPV)) {
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    !cpu_feature_enabled(X86_FEATURE_XENPV)) {
 		native_swapgs();
 		wrgsbase(gsbase);
 		native_swapgs();
@@ -505,7 +529,7 @@ void x86_gsbase_write_task(struct task_struct *task, unsi=
gned long gsbase)
 static void
 start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		    unsigned long new_sp,
-		    unsigned int _cs, unsigned int _ss, unsigned int _ds)
+		    u16 _cs, u16 _ss, u16 _ds)
 {
 	WARN_ON_ONCE(regs !=3D current_pt_regs());
=20
@@ -522,11 +546,36 @@ start_thread_common(struct pt_regs *regs, unsigned long=
 new_ip,
 	loadsegment(ds, _ds);
 	load_gs_index(0);
=20
-	regs->ip		=3D new_ip;
-	regs->sp		=3D new_sp;
-	regs->cs		=3D _cs;
-	regs->ss		=3D _ss;
-	regs->flags		=3D X86_EFLAGS_IF;
+	regs->ip	=3D new_ip;
+	regs->sp	=3D new_sp;
+	regs->csx	=3D _cs;
+	regs->ssx	=3D _ss;
+	/*
+	 * Allow single-step trap and NMI when starting a new task, thus
+	 * once the new task enters user space, single-step trap and NMI
+	 * are both enabled immediately.
+	 *
+	 * Entering a new task is logically speaking a return from a
+	 * system call (exec, fork, clone, etc.). As such, if ptrace
+	 * enables single stepping a single step exception should be
+	 * allowed to trigger immediately upon entering user space.
+	 * This is not optional.
+	 *
+	 * NMI should *never* be disabled in user space. As such, this
+	 * is an optional, opportunistic way to catch errors.
+	 *
+	 * Paranoia: High-order 48 bits above the lowest 16 bit SS are
+	 * discarded by the legacy IRET instruction on all Intel, AMD,
+	 * and Cyrix/Centaur/VIA CPUs, thus can be set unconditionally,
+	 * even when FRED is not enabled. But we choose the safer side
+	 * to use these bits only when FRED is enabled.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		regs->fred_ss.swevent	=3D true;
+		regs->fred_ss.nmi	=3D true;
+	}
+
+	regs->flags	=3D X86_EFLAGS_IF | X86_EFLAGS_FIXED;
 }
=20
 void
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c3b2f863acf0..6cb31df3d5ff 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -51,6 +51,7 @@
 #include <asm/ftrace.h>
 #include <asm/traps.h>
 #include <asm/desc.h>
+#include <asm/fred.h>
 #include <asm/fpu/api.h>
 #include <asm/cpu.h>
 #include <asm/cpu_entry_area.h>
@@ -935,8 +936,7 @@ static bool notify_debug(struct pt_regs *regs, unsigned l=
ong *dr6)
 	return false;
 }
=20
-static __always_inline void exc_debug_kernel(struct pt_regs *regs,
-					     unsigned long dr6)
+static noinstr void exc_debug_kernel(struct pt_regs *regs, unsigned long dr6)
 {
 	/*
 	 * Disable breakpoints during exception handling; recursive exceptions
@@ -948,6 +948,11 @@ static __always_inline void exc_debug_kernel(struct pt_r=
egs *regs,
 	 *
 	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
 	 * includes the entry stack is excluded for everything.
+	 *
+	 * For FRED, nested #DB should just work fine. But when a watchpoint or
+	 * breakpoint is set in the code path which is executed by #DB handler,
+	 * it results in an endless recursion and stack overflow. Thus we stay
+	 * with the IDT approach, i.e., save DR7 and disable #DB.
 	 */
 	unsigned long dr7 =3D local_db_save();
 	irqentry_state_t irq_state =3D irqentry_nmi_enter(regs);
@@ -977,7 +982,8 @@ static __always_inline void exc_debug_kernel(struct pt_re=
gs *regs,
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
 	 * watchpoint at the same time then that will still be handled.
 	 */
-	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    (dr6 & DR_STEP) && is_sysenter_singlestep(regs))
 		dr6 &=3D ~DR_STEP;
=20
 	/*
@@ -1009,8 +1015,7 @@ static __always_inline void exc_debug_kernel(struct pt_=
regs *regs,
 	local_db_restore(dr7);
 }
=20
-static __always_inline void exc_debug_user(struct pt_regs *regs,
-					   unsigned long dr6)
+static noinstr void exc_debug_user(struct pt_regs *regs, unsigned long dr6)
 {
 	bool icebp;
=20
@@ -1094,6 +1099,34 @@ DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 {
 	exc_debug_user(regs, debug_read_clear_dr6());
 }
+
+#ifdef CONFIG_X86_FRED
+/*
+ * When occurred on different ring level, i.e., from user or kernel
+ * context, #DB needs to be handled on different stack: User #DB on
+ * current task stack, while kernel #DB on a dedicated stack.
+ *
+ * This is exactly how FRED event delivery invokes an exception
+ * handler: ring 3 event on level 0 stack, i.e., current task stack;
+ * ring 0 event on the #DB dedicated stack specified in the
+ * IA32_FRED_STKLVLS MSR. So unlike IDT, the FRED debug exception
+ * entry stub doesn't do stack switch.
+ */
+DEFINE_FREDENTRY_DEBUG(exc_debug)
+{
+	/*
+	 * FRED #DB stores DR6 on the stack in the format which
+	 * debug_read_clear_dr6() returns for the IDT entry points.
+	 */
+	unsigned long dr6 =3D fred_event_data(regs);
+
+	if (user_mode(regs))
+		exc_debug_user(regs, dr6);
+	else
+		exc_debug_kernel(regs, dr6);
+}
+#endif /* CONFIG_X86_FRED */
+
 #else
 /* 32 bit does not have separate entry points. */
 DEFINE_IDTENTRY_RAW(exc_debug)
@@ -1369,8 +1402,34 @@ DEFINE_IDTENTRY_SW(iret_error)
 }
 #endif
=20
+/* Do not enable FRED by default yet. */
+static bool enable_fred __ro_after_init =3D false;
+
+#ifdef CONFIG_X86_FRED
+static int __init fred_setup(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		return 0;
+
+	if (!strcmp(str, "on"))
+		enable_fred =3D true;
+	else if (!strcmp(str, "off"))
+		enable_fred =3D false;
+	else
+		pr_warn("invalid FRED option: 'fred=3D%s'\n", str);
+	return 0;
+}
+early_param("fred", fred_setup);
+#endif
+
 void __init trap_init(void)
 {
+	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+
 	/* Init cpu_entry_area before IST entries are set up */
 	setup_cpu_entry_areas();
=20
@@ -1379,7 +1438,10 @@ void __init trap_init(void)
=20
 	/* Initialize TSS before setting up traps so ISTs work */
 	cpu_init_exception_handling();
+
 	/* Setup traps as cpu_init() might #GP */
-	idt_setup_traps();
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		idt_setup_traps();
+
 	cpu_init();
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e262bc2ba4e5..cce92f701dee 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -38,6 +38,7 @@
 #include <asm/desc.h>
 #include <asm/fpu/api.h>
 #include <asm/fpu/xstate.h>
+#include <asm/fred.h>
 #include <asm/idtentry.h>
 #include <asm/io.h>
 #include <asm/irq_remapping.h>
@@ -6960,14 +6961,16 @@ static void handle_external_interrupt_irqoff(struct k=
vm_vcpu *vcpu)
 {
 	u32 intr_info =3D vmx_get_intr_info(vcpu);
 	unsigned int vector =3D intr_info & INTR_INFO_VECTOR_MASK;
-	gate_desc *desc =3D (gate_desc *)host_idt_base + vector;
=20
 	if (KVM_BUG(!is_external_intr(intr_info), vcpu->kvm,
 	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
 		return;
=20
 	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
-	vmx_do_interrupt_irqoff(gate_offset(desc));
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
+	else
+		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
 	kvm_after_interrupt(vcpu);
=20
 	vcpu->arch.at_instruction_boundary =3D true;
@@ -7260,7 +7263,10 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcp=
u *vcpu,
 	if ((u16)vmx->exit_reason.basic =3D=3D EXIT_REASON_EXCEPTION_NMI &&
 	    is_nmi(vmx_get_intr_info(vcpu))) {
 		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
-		vmx_do_nmi_irqoff();
+		if (cpu_feature_enabled(X86_FEATURE_FRED))
+			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
+		else
+			vmx_do_nmi_irqoff();
 		kvm_after_interrupt(vcpu);
 	}
=20
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 5168ee0360b2..12af572201a2 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -1051,8 +1051,8 @@ GrpTable: Grp6
 EndTable
=20
 GrpTable: Grp7
-0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B=
) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
-1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | ST=
AC (011),(11B) | ENCLS (111),(11B)
+0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B=
) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (1=
10),(11B)
+1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | ST=
AC (011),(11B) | ENCLS (111),(11B) | ERETU (F3),(010),(11B) | ERETS (F2),(010=
),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | =
XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 271dcb2deabc..b522933bfa56 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -6,6 +6,7 @@
 #include <xen/xen.h>
=20
 #include <asm/fpu/api.h>
+#include <asm/fred.h>
 #include <asm/sev.h>
 #include <asm/traps.h>
 #include <asm/kdebug.h>
@@ -223,6 +224,79 @@ static bool ex_handler_ucopy_len(const struct exception_=
table_entry *fixup,
 	return ex_handler_uaccess(fixup, regs, trapnr, fault_address);
 }
=20
+#ifdef CONFIG_X86_FRED
+static bool ex_handler_eretu(const struct exception_table_entry *fixup,
+			     struct pt_regs *regs, unsigned long error_code)
+{
+	struct pt_regs *uregs =3D (struct pt_regs *)(regs->sp - offsetof(struct pt_=
regs, orig_ax));
+	unsigned short ss =3D uregs->ss;
+	unsigned short cs =3D uregs->cs;
+
+	/*
+	 * Move the NMI bit from the invalid stack frame, which caused ERETU
+	 * to fault, to the fault handler's stack frame, thus to unblock NMI
+	 * with the fault handler's ERETS instruction ASAP if NMI is blocked.
+	 */
+	regs->fred_ss.nmi =3D uregs->fred_ss.nmi;
+
+	/*
+	 * Sync event information to uregs, i.e., the ERETU return frame, but
+	 * is it safe to write to the ERETU return frame which is just above
+	 * current event stack frame?
+	 *
+	 * The RSP used by FRED to push a stack frame is not the value in %rsp,
+	 * it is calculated from %rsp with the following 2 steps:
+	 * 1) RSP =3D %rsp - (IA32_FRED_CONFIG & 0x1c0)	// Reserve N*64 bytes
+	 * 2) RSP =3D RSP & ~0x3f		// Align to a 64-byte cache line
+	 * when an event delivery doesn't trigger a stack level change.
+	 *
+	 * Here is an example with N*64 (N=3D1) bytes reserved:
+	 *
+	 *  64-byte cache line =3D=3D>  ______________
+	 *                         |___Reserved___|
+	 *                         |__Event_data__|
+	 *                         |_____SS_______|
+	 *                         |_____RSP______|
+	 *                         |_____FLAGS____|
+	 *                         |_____CS_______|
+	 *                         |_____IP_______|
+	 *  64-byte cache line =3D=3D> |__Error_code__| <=3D=3D ERETU return frame
+	 *                         |______________|
+	 *                         |______________|
+	 *                         |______________|
+	 *                         |______________|
+	 *                         |______________|
+	 *                         |______________|
+	 *                         |______________|
+	 *  64-byte cache line =3D=3D> |______________| <=3D=3D RSP after step 1) a=
nd 2)
+	 *                         |___Reserved___|
+	 *                         |__Event_data__|
+	 *                         |_____SS_______|
+	 *                         |_____RSP______|
+	 *                         |_____FLAGS____|
+	 *                         |_____CS_______|
+	 *                         |_____IP_______|
+	 *  64-byte cache line =3D=3D> |__Error_code__| <=3D=3D ERETS return frame
+	 *
+	 * Thus a new FRED stack frame will always be pushed below a previous
+	 * FRED stack frame ((N*64) bytes may be reserved between), and it is
+	 * safe to write to a previous FRED stack frame as they never overlap.
+	 */
+	fred_info(uregs)->edata =3D fred_event_data(regs);
+	uregs->ssx =3D regs->ssx;
+	uregs->fred_ss.ss =3D ss;
+	/* The NMI bit was moved away above */
+	uregs->fred_ss.nmi =3D 0;
+	uregs->csx =3D regs->csx;
+	uregs->fred_cs.sl =3D 0;
+	uregs->fred_cs.wfe =3D 0;
+	uregs->cs =3D cs;
+	uregs->orig_ax =3D error_code;
+
+	return ex_handler_default(fixup, regs);
+}
+#endif
+
 int ex_get_fixup_type(unsigned long ip)
 {
 	const struct exception_table_entry *e =3D search_exception_tables(ip);
@@ -300,6 +374,10 @@ int fixup_exception(struct pt_regs *regs, int trapnr, un=
signed long error_code,
 		return ex_handler_ucopy_len(e, regs, trapnr, fault_addr, reg, imm);
 	case EX_TYPE_ZEROPAD:
 		return ex_handler_zeropad(e, regs, fault_addr);
+#ifdef CONFIG_X86_FRED
+	case EX_TYPE_ERETU:
+		return ex_handler_eretu(e, regs, error_code);
+#endif
 	}
 	BUG();
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 679b09cfe241..fa2d69951f25 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -34,6 +34,7 @@
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 #include <asm/irq_stack.h>
+#include <asm/fred.h>
=20
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1518,8 +1519,10 @@ handle_page_fault(struct pt_regs *regs, unsigned long =
error_code,
=20
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 {
-	unsigned long address =3D read_cr2();
 	irqentry_state_t state;
+	unsigned long address;
+
+	address =3D cpu_feature_enabled(X86_FEATURE_FRED) ? fred_event_data(regs) :=
 read_cr2();
=20
 	prefetchw(&current->mm->mmap_lock);
=20
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index a0ea285878db..04101b984f24 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -49,7 +49,7 @@ SYM_CODE_START(startup_xen)
 	ANNOTATE_NOENDBR
 	cld
=20
-	leaq	(__end_init_task - PTREGS_SIZE)(%rip), %rsp
+	leaq	(__end_init_task - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE)(%rip), %=
rsp
=20
 	/* Set up %gs.
 	 *
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_bas=
e.c
index b8cfea7812d6..e2813bac92d4 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -2216,7 +2216,7 @@ static __init void xen_alloc_callback_vector(void)
 		return;
=20
 	pr_info("Xen HVM callback vector for event delivery is enabled\n");
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_xen_hvm_callback);
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_xen_hvm_callback);
 }
 #else
 void xen_setup_callback_vector(void) {}
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/includ=
e/asm/cpufeatures.h
index f4542d2718f4..953e6efead26 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -321,7 +321,9 @@
 #define X86_FEATURE_FZRM		(12*32+10) /* "" Fast zero-length REP MOVSB */
 #define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
 #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
+#define X86_FEATURE_FRED		(12*32+17) /* Flexible Return and Event Delivery */
 #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
+#define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-serializing WRMSR */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD5=
2[H,L]UQ */
 #define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/=
include/asm/disabled-features.h
index 702d93fdd10e..f40b29d3abad 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -117,6 +117,12 @@
 #define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
 #endif
=20
+#ifdef CONFIG_X86_FRED
+# define DISABLE_FRED	0
+#else
+# define DISABLE_FRED	(1 << (X86_FEATURE_FRED & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -133,7 +139,7 @@
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
 			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
-#define DISABLED_MASK12	(DISABLE_LAM)
+#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/=
asm/msr-index.h
index 1d51e1850ed0..74f2c63ce717 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -36,8 +36,19 @@
 #define EFER_FFXSR		(1<<_EFER_FFXSR)
 #define EFER_AUTOIBRS		(1<<_EFER_AUTOIBRS)
=20
-/* Intel MSRs. Some also available on other CPUs */
+/* FRED MSRs */
+#define MSR_IA32_FRED_RSP0	0x1cc			/* Level 0 stack pointer */
+#define MSR_IA32_FRED_RSP1	0x1cd			/* Level 1 stack pointer */
+#define MSR_IA32_FRED_RSP2	0x1ce			/* Level 2 stack pointer */
+#define MSR_IA32_FRED_RSP3	0x1cf			/* Level 3 stack pointer */
+#define MSR_IA32_FRED_STKLVLS	0x1d0			/* Exception stack levels */
+#define MSR_IA32_FRED_SSP0	MSR_IA32_PL0_SSP	/* Level 0 shadow stack pointer =
*/
+#define MSR_IA32_FRED_SSP1	0x1d1			/* Level 1 shadow stack pointer */
+#define MSR_IA32_FRED_SSP2	0x1d2			/* Level 2 shadow stack pointer */
+#define MSR_IA32_FRED_SSP3	0x1d3			/* Level 3 shadow stack pointer */
+#define MSR_IA32_FRED_CONFIG	0x1d4			/* Entrypoint and interrupt stack level=
 */
=20
+/* Intel MSRs. Some also available on other CPUs */
 #define MSR_TEST_CTRL				0x00000033
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT=
_BIT)
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-o=
pcode-map.txt
index 5168ee0360b2..12af572201a2 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -1051,8 +1051,8 @@ GrpTable: Grp6
 EndTable
=20
 GrpTable: Grp7
-0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B=
) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
-1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | ST=
AC (011),(11B) | ENCLS (111),(11B)
+0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B=
) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (1=
10),(11B)
+1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | ST=
AC (011),(11B) | ENCLS (111),(11B) | ERETU (F3),(010),(11B) | ERETS (F2),(010=
),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | =
XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index e327cd827135..3a1d80a7878d 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -509,11 +509,20 @@ int arch_decode_instruction(struct objtool_file *file, =
const struct section *sec
=20
 		if (op2 =3D=3D 0x01) {
=20
-			if (modrm =3D=3D 0xca)
-				insn->type =3D INSN_CLAC;
-			else if (modrm =3D=3D 0xcb)
-				insn->type =3D INSN_STAC;
-
+			switch (insn_last_prefix_id(&ins)) {
+			case INAT_PFX_REPE:
+			case INAT_PFX_REPNE:
+				if (modrm =3D=3D 0xca)
+					/* eretu/erets */
+					insn->type =3D INSN_CONTEXT_SWITCH;
+				break;
+			default:
+				if (modrm =3D=3D 0xca)
+					insn->type =3D INSN_CLAC;
+				else if (modrm =3D=3D 0xcb)
+					insn->type =3D INSN_STAC;
+				break;
+			}
 		} else if (op2 >=3D 0x80 && op2 <=3D 0x8f) {
=20
 			insn->type =3D INSN_JUMP_CONDITIONAL;


