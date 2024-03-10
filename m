Return-Path: <linux-kernel+bounces-98369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A72E877931
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9855281A78
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E51E3FBA0;
	Sun, 10 Mar 2024 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wXWX+DgZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNmCYEHT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95D3BBE8
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710113952; cv=none; b=P8lQz+g3Hz19XyaI7SrNbA3vnyKvZcGIBFCfn3mJWoNhXJrD0nY/WF4RpOvOLaoiu6MMbBXvI7CPBQ4SB8v1qb1nepjsws6X1k8DrzWbVUEUIvUf073WxJ9xpLPWH9FRKlp/xA/gesaSbAQIqdhSsAEvFBgYPre9ZHKeHJmBIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710113952; c=relaxed/simple;
	bh=GirV3PRst5bhTPG+/UqIW7iCT0p4Yp25eGVn8PxjJ3k=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=G6nd/zCg9QeasJ5zBLGUvejE1+2+Qcy0XW0v/b/5rsM2Xift5FJ3w3CYi+v1xndiCT3z2qrhNzYC5RgjlUHQ8cDBDTo4sfNhfjvU3stCixG3NglMNPHwnhQS50oJoAxqAEb1teJc92G3z4yfIMLC1pbpTOpvHWJCWxqGTCuCu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wXWX+DgZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNmCYEHT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710113939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=LuJB2sHcBrMZV5yjsfkUE8118rPpMDi8e3014hY1wYU=;
	b=wXWX+DgZuOpyF7fp5aWphGiQWj2BchB4E8TWA8LwK2D+DGSYOfXnwNpIhBdLCu5dvGxG7O
	8gWGeSST0zJ+6R1WoNDOS3xwTgEMlPlg9Z7CxMZCebfZpb7/vVqf9g3RxURT6wiKgHnmay
	zf+qjsUJcBgEeC+GuYGNr/RJDUNduLQKminDmYfYZov89Cd65qfl6Y5TlI2IY9dQLeDkVm
	K1dcBoRWSUndkG+Qqd03hxqjOkT4lA22e51vDA3ZK5dDOY5ugMc4tWcw7EY5x5lA8NOd6f
	OzLOdSuV6ZbNfZn342Ud0/sBpVOh3P/lXX9YNF9MigagzL0VHR/Pg2DUPM8gcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710113939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=LuJB2sHcBrMZV5yjsfkUE8118rPpMDi8e3014hY1wYU=;
	b=fNmCYEHT8sukFKI8/O4X1yp1UB1Qaw2lcPSVrSkrjYYOTq1ZOpwcgqCRqbtHEJRpoDeqDH
	VQ7lsAobnc9U2sDw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/apic for v6.9-rc1
References: <171011361246.2468526.10740060923051583953.tglx@xen13>
Message-ID: <171011362048.2468526.2240218025431476865.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Mar 2024 00:38:59 +0100 (CET)

Linus,

please pull the latest x86/apic branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2024-03=
-10

up to:  f0551af02130: x86/topology: Ignore non-present APIC IDs in a present =
package


Rework of APIC enumeration and topology evaluation:

The current implementation has a couple of shortcomings:

  - It fails to handle hybrid systems correctly.

  - The APIC registration code which handles CPU number assignents is in
    the middle of the APIC code and detached from the topology evaluation.

  - The various mechanisms which enumerate APICs, ACPI, MPPARSE and guest
    specific ones, tweak global variables as they see fit or in case of
    XENPV just hack around the generic mechanisms completely.

  - The CPUID topology evaluation code is sprinkled all over the vendor
    code and reevaluates global variables on every hotplug operation.

  - There is no way to analyze topology on the boot CPU before bringing up
    the APs. This causes problems for infrastructure like PERF which needs
    to size certain aspects upfront or could be simplified if that would be
    possible.

  - The APIC admission and CPU number association logic is incomprehensible
    and overly complex and needs to be kept around after boot instead of
    completing this right after the APIC enumeration.

This update addresses these shortcomings with the following changes:

  - Rework the CPUID evaluation code so it is common for all vendors and
    provides information about the APIC ID segments in a uniform way
    independent of the number of segments (Thread, Core, Module, ..., Die,
    Package) so that this information can be computed instead of rewriting
    global variables of dubious value over and over.

  - A few cleanups and simplifcations of the APIC, IO/APIC and related
    interfaces to prepare for the topology evaluation changes.

  - Seperation of the parser stages so the early evaluation which tries to
    find the APIC address can be seperately overridden from the late
    evaluation which enumerates and registers the local APIC as further
    preparation for sanitizing the topology evaluation.

  - A new registration and admission logic which

     - encapsulates the inner workings so that parsers and guest logic
       cannot longer fiddle in it

     - uses the APIC ID segments to build topology bitmaps at registration
       time

     - provides a sane admission logic

     - allows to detect the crash kernel case, where CPU0 does not run on
       the real BSP, automatically. This is required to prevent sending
       INIT/SIPI sequences to the real BSP which would reset the whole
       machine. This was so far handled by a tedious command line
       parameter, which does not even work in nested crash scenarios.

     - Associates CPU number after the enumeration completed and prevents
       the late registration of APICs, which was somehow tolerated before.

  - Converting all parsers and guest enumeration mechanisms over to the
    new interfaces.

    This allows to get rid of all global variable tweaking from the parsers
    and enumeration mechanisms and sanitizes the XEN[PV] handling so it can
    use CPUID evaluation for the first time.

  - Mopping up existing sins by taking the information from the APIC ID
    segment bitmaps.

    This evaluates hybrid systems correctly on the boot CPU and allows for
    cleanups and fixes in the related drivers, e.g. PERF.

The series has been extensively tested and the minimal late fallout due to
a broken ACPI/MADT table has been addressed by tightening the admission
logic further.

Thanks,

	tglx

------------------>
Ingo Molnar (3):
      smp: Avoid 'setup_max_cpus' namespace collision/shadowing
      smp: Provide 'setup_max_cpus' definition on UP too
      x86/apic: Build the x86 topology enumeration functions on UP APIC build=
s too

Pawan Gupta (1):
      x86/bugs: Use fixed addressing for VERW operand

Thomas Gleixner (72):
      x86/cpu: Provide cpuid_read() et al.
      x86/cpu: Provide cpu_init/parse_topology()
      x86/cpu: Add legacy topology parser
      x86/cpu: Use common topology code for Centaur and Zhaoxin
      x86/cpu: Move __max_die_per_package to common.c
      x86/cpu: Provide a sane leaf 0xb/0x1f parser
      x86/cpu: Use common topology code for Intel
      x86/cpu/amd: Provide a separate accessor for Node ID
      x86/cpu: Provide an AMD/HYGON specific topology parser
      x86/smpboot: Teach it about topo.amd_node_id
      x86/cpu: Use common topology code for AMD
      x86/cpu: Use common topology code for HYGON
      x86/mm/numa: Use core domain size on AMD
      x86/cpu: Make topology_amd_node_id() use the actual node info
      x86/cpu: Remove topology.c
      x86/cpu: Remove x86_coreid_bits
      x86/apic: Remove unused phys_pkg_id() callback
      x86/xen/smp_pv: Remove cpudata fiddling
      x86/apic/uv: Remove the private leaf 0xb parser
      x86/cpu/topology: Make the APIC mismatch warnings complete
      x86/platform/ce4100: Dont override x86_init.mpparse.setup_ioapic_ids
      x86/ioapic: Replace some more set bit nonsense
      x86/apic: Get rid of get_physical_broadcast()
      x86/ioapic: Make io_apic_get_unique_id() simpler
      x86/ioapic: Simplify setup_ioapic_ids_from_mpc_nocheck()
      x86/apic: Remove check_apicid_used() and ioapic_phys_id_map()
      x86/mpparse: Rename default_find_smp_config()
      x86/mpparse: Provide separate early/late callbacks
      x86/mpparse: Prepare for callback separation
      x86/dtb: Rename x86_dtb_init()
      x86/platform/ce4100: Prepare for separate mpparse callbacks
      x86/platform/intel-mid: Prepare for separate mpparse callbacks
      x86/jailhouse: Prepare for separate mpparse callbacks
      x86/xen/smp_pv: Prepare for separate mpparse callbacks
      x86/hyperv/vtl: Prepare for separate mpparse callbacks
      x86/mpparse: Switch to new init callbacks
      x86/mm/numa: Move early mptable evaluation into common code
      x86/mpparse: Remove the physid_t bitmap wrapper
      x86/apic: Remove the pointless writeback of boot_cpu_physical_apicid
      x86/apic: Remove yet another dubious callback
      x86/apic: Use a proper define for invalid ACPI CPU ID
      x86/cpu/topology: Move registration out of APIC code
      x86/cpu/topology: Provide separate APIC registration functions
      x86/acpi: Use new APIC registration functions
      x86/jailhouse: Use new APIC registration function
      x86/of: Use new APIC registration functions
      x86/mpparse: Use new APIC registration function
      x86/acpi: Dont invoke topology_register_apic() for XEN PV
      x86/xen/smp_pv: Register fake APICs
      x86/cpu/topology: Confine topology information
      x86/cpu/topology: Simplify APIC registration
      x86/cpu/topology: Use a data structure for topology info
      x86/smpboot: Make error message actually useful
      x86/cpu/topology: Sanitize the APIC admission logic
      x86/cpu/topology: Rework possible CPU management
      x86/cpu: Detect real BSP on crash kernels
      x86/topology: Add a mechanism to track topology via APIC IDs
      x86/cpu/topology: Reject unknown APIC IDs on ACPI hotplug
      x86/cpu/topology: Assign hotpluggable CPUIDs during init
      x86/xen/smp_pv: Count number of vCPUs early
      x86/cpu/topology: Let XEN/PV use topology from CPUID/MADT
      x86/cpu/topology: Use topology bitmaps for sizing
      x86/cpu/topology: Mop up primary thread mask handling
      x86/cpu/topology: Simplify cpu_mark_primary_thread()
      x86/cpu/topology: Provide logical pkg/die mapping
      x86/cpu/topology: Use topology logical mapping mechanism
      x86/cpu/topology: Retrieve cores per package from topology bitmaps
      x86/cpu/topology: Rename smp_num_siblings
      x86/cpu/topology: Rename topology_max_die_per_package()
      x86/cpu/topology: Provide __num_[cores|threads]_per_package
      x86/cpu/topology: Get rid of cpuinfo::x86_max_cores
      x86/topology: Ignore non-present APIC IDs in a present package


 Documentation/admin-guide/kdump/kdump.rst          |   7 +-
 Documentation/admin-guide/kernel-parameters.txt    |   9 -
 Documentation/arch/x86/topology.rst                |  24 +-
 arch/x86/events/amd/core.c                         |   2 +-
 arch/x86/events/intel/cstate.c                     |   2 +-
 arch/x86/events/intel/uncore.c                     |   2 +-
 arch/x86/events/intel/uncore_nhmex.c               |   4 +-
 arch/x86/events/intel/uncore_snb.c                 |   8 +-
 arch/x86/events/intel/uncore_snbep.c               |  18 +-
 arch/x86/events/rapl.c                             |   2 +-
 arch/x86/hyperv/hv_vtl.c                           |   5 +-
 arch/x86/include/asm/apic.h                        |  22 +-
 arch/x86/include/asm/cpu.h                         |  10 +-
 arch/x86/include/asm/cpuid.h                       |  36 ++
 arch/x86/include/asm/io_apic.h                     |   1 -
 arch/x86/include/asm/mpspec.h                      |  66 +--
 arch/x86/include/asm/nospec-branch.h               |   2 +-
 arch/x86/include/asm/perf_event_p4.h               |   4 +-
 arch/x86/include/asm/processor.h                   |   9 +-
 arch/x86/include/asm/prom.h                        |   4 +-
 arch/x86/include/asm/smp.h                         |   6 -
 arch/x86/include/asm/topology.h                    |  90 +++-
 arch/x86/include/asm/x86_init.h                    |  10 +-
 arch/x86/kernel/acpi/boot.c                        |  59 +--
 arch/x86/kernel/amd_nb.c                           |   4 +-
 arch/x86/kernel/apic/apic.c                        | 207 +-------
 arch/x86/kernel/apic/apic_common.c                 |  15 -
 arch/x86/kernel/apic/apic_flat_64.c                |  16 -
 arch/x86/kernel/apic/apic_noop.c                   |   5 -
 arch/x86/kernel/apic/apic_numachip.c               |  19 -
 arch/x86/kernel/apic/bigsmp_32.c                   |  20 -
 arch/x86/kernel/apic/io_apic.c                     |  92 ++--
 arch/x86/kernel/apic/local.h                       |   5 -
 arch/x86/kernel/apic/probe_32.c                    |   9 -
 arch/x86/kernel/apic/x2apic_cluster.c              |   4 -
 arch/x86/kernel/apic/x2apic_phys.c                 |  12 -
 arch/x86/kernel/apic/x2apic_uv_x.c                 |  69 +--
 arch/x86/kernel/cpu/Makefile                       |  15 +-
 arch/x86/kernel/cpu/amd.c                          | 146 ------
 arch/x86/kernel/cpu/cacheinfo.c                    |   8 +-
 arch/x86/kernel/cpu/centaur.c                      |   4 -
 arch/x86/kernel/cpu/common.c                       | 131 +----
 arch/x86/kernel/cpu/cpu.h                          |  13 +-
 arch/x86/kernel/cpu/debugfs.c                      |  47 +-
 arch/x86/kernel/cpu/hygon.c                        | 129 -----
 arch/x86/kernel/cpu/intel.c                        |  25 -
 arch/x86/kernel/cpu/mce/amd.c                      |   4 +-
 arch/x86/kernel/cpu/mce/inject.c                   |   8 +-
 arch/x86/kernel/cpu/microcode/intel.c              |   2 +-
 arch/x86/kernel/cpu/topology.c                     | 573 ++++++++++++++++---=
--
 arch/x86/kernel/cpu/topology.h                     |  67 +++
 arch/x86/kernel/cpu/topology_amd.c                 | 183 +++++++
 arch/x86/kernel/cpu/topology_common.c              | 218 ++++++++
 arch/x86/kernel/cpu/topology_ext.c                 | 130 +++++
 arch/x86/kernel/cpu/zhaoxin.c                      |   4 -
 arch/x86/kernel/devicetree.c                       |   4 +-
 arch/x86/kernel/jailhouse.c                        |  30 +-
 arch/x86/kernel/mpparse.c                          |  31 +-
 arch/x86/kernel/process.c                          |   2 +-
 arch/x86/kernel/setup.c                            |  27 +-
 arch/x86/kernel/smpboot.c                          | 233 +--------
 arch/x86/kernel/vsmp_64.c                          |  13 -
 arch/x86/kernel/x86_init.c                         |   5 +-
 arch/x86/mm/amdtopology.c                          |  34 +-
 arch/x86/platform/ce4100/ce4100.c                  |  14 +-
 arch/x86/platform/intel-mid/intel-mid.c            |   5 +-
 arch/x86/xen/apic.c                                |  27 +-
 arch/x86/xen/enlighten_hvm.c                       |   2 +-
 arch/x86/xen/enlighten_pv.c                        |   3 +
 arch/x86/xen/smp.c                                 |   2 -
 arch/x86/xen/smp.h                                 |   2 +
 arch/x86/xen/smp_pv.c                              |  69 ++-
 drivers/edac/amd64_edac.c                          |   4 +-
 drivers/edac/mce_amd.c                             |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |   2 +-
 drivers/hwmon/coretemp.c                           |   2 +-
 drivers/hwmon/fam15h_power.c                       |   2 +-
 .../x86/intel/uncore-frequency/uncore-frequency.c  |   2 +-
 drivers/powercap/intel_rapl_common.c               |   2 +-
 drivers/thermal/intel/intel_hfi.c                  |   2 +-
 drivers/thermal/intel/intel_powerclamp.c           |   2 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |   2 +-
 include/linux/cpu.h                                |   2 +-
 include/linux/smp.h                                |   2 +
 init/main.c                                        |   1 -
 kernel/cpu.c                                       |   6 +-
 86 files changed, 1555 insertions(+), 1569 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/topology.h
 create mode 100644 arch/x86/kernel/cpu/topology_amd.c
 create mode 100644 arch/x86/kernel/cpu/topology_common.c
 create mode 100644 arch/x86/kernel/cpu/topology_ext.c

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-=
guide/kdump/kdump.rst
index 5762e7477a0c..0302a93b1d40 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -191,9 +191,7 @@ Dump-capture kernel config options (Arch Dependent, i386 =
and x86_64)
    CPU is enough for kdump kernel to dump vmcore on most of systems.
=20
    However, you can also specify nr_cpus=3DX to enable multiple processors
-   in kdump kernel. In this case, "disable_cpu_apicid=3D" is needed to
-   tell kdump kernel which cpu is 1st kernel's BSP. Please refer to
-   admin-guide/kernel-parameters.txt for more details.
+   in kdump kernel.
=20
    With CONFIG_SMP=3Dn, the above things are not related.
=20
@@ -454,8 +452,7 @@ Notes on loading the dump-capture kernel:
   to use multi-thread programs with it, such as parallel dump feature of
   makedumpfile. Otherwise, the multi-thread program may have a great
   performance degradation. To enable multi-cpu support, you should bring up =
an
-  SMP dump-capture kernel and specify maxcpus/nr_cpus, disable_cpu_apicid=3D=
[X]
-  options while loading it.
+  SMP dump-capture kernel and specify maxcpus/nr_cpus options while loading =
it.
=20
 * For s390x there are two kdump modes: If a ELF header is specified with
   the elfcorehdr=3D kernel parameter, it is used by the kdump kernel as it
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 31b3a25680d0..4b9b4d662e31 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1100,15 +1100,6 @@
 			Disable TLBIE instruction. Currently does not work
 			with KVM, with HASH MMU, or with coherent accelerators.
=20
-	disable_cpu_apicid=3D [X86,APIC,SMP]
-			Format: <int>
-			The number of initial APIC ID for the
-			corresponding CPU to be disabled at boot,
-			mostly used for the kdump 2nd kernel to
-			disable BSP to wake up multiple CPUs without
-			causing system reset or hang due to sending
-			INIT from AP to BSP.
-
 	disable_ddw	[PPC/PSERIES]
 			Disable Dynamic DMA Window support. Use this
 			to workaround buggy firmware.
diff --git a/Documentation/arch/x86/topology.rst b/Documentation/arch/x86/top=
ology.rst
index 08ebf9edbfc1..7352ab89a55a 100644
--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -47,17 +47,21 @@ AMD nomenclature for package is 'Node'.
=20
 Package-related topology information in the kernel:
=20
-  - cpuinfo_x86.x86_max_cores:
+  - topology_num_threads_per_package()
=20
-    The number of cores in a package. This information is retrieved via CPUI=
D.
+    The number of threads in a package.
=20
-  - cpuinfo_x86.x86_max_dies:
+  - topology_num_cores_per_package()
=20
-    The number of dies in a package. This information is retrieved via CPUID.
+    The number of cores in a package.
+
+  - topology_max_dies_per_package()
+
+    The maximum number of dies in a package.
=20
   - cpuinfo_x86.topo.die_id:
=20
-    The physical ID of the die. This information is retrieved via CPUID.
+    The physical ID of the die.
=20
   - cpuinfo_x86.topo.pkg_id:
=20
@@ -96,16 +100,6 @@ are SMT- or CMT-type threads.
 AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
 "core".
=20
-Core-related topology information in the kernel:
-
-  - smp_num_siblings:
-
-    The number of threads in a core. The number of threads in a package can =
be
-    calculated by::
-
-	threads_per_package =3D cpuinfo_x86.x86_max_cores * smp_num_siblings
-
-
 Threads
 =3D=3D=3D=3D=3D=3D=3D
 A thread is a single scheduling unit. It's the equivalent to a logical Linux
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 81f6d8275b6b..69a3b02e50bb 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -579,7 +579,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	if (!x86_pmu.amd_nb_constraints)
 		return;
=20
-	nb_id =3D topology_die_id(cpu);
+	nb_id =3D topology_amd_node_id(cpu);
 	WARN_ON_ONCE(nb_id =3D=3D BAD_APICID);
=20
 	for_each_online_cpu(i) {
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 4b50a3a9818a..326c8cd5aa2d 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -834,7 +834,7 @@ static int __init cstate_init(void)
 	}
=20
 	if (has_cstate_pkg) {
-		if (topology_max_die_per_package() > 1) {
+		if (topology_max_dies_per_package() > 1) {
 			err =3D perf_pmu_register(&cstate_pkg_pmu,
 						"cstate_die", -1);
 		} else {
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7927c0b832fa..258e2cdf28fa 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1893,7 +1893,7 @@ static int __init intel_uncore_init(void)
 		return -ENODEV;
=20
 	__uncore_max_dies =3D
-		topology_max_packages() * topology_max_die_per_package();
+		topology_max_packages() * topology_max_dies_per_package();
=20
 	id =3D x86_match_cpu(intel_uncore_match);
 	if (!id) {
diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/unc=
ore_nhmex.c
index 56eea2c66cfb..92da8aaa5966 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -1221,8 +1221,8 @@ void nhmex_uncore_cpu_init(void)
 		uncore_nhmex =3D true;
 	else
 		nhmex_uncore_mbox.event_descs =3D wsmex_uncore_mbox_events;
-	if (nhmex_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		nhmex_uncore_cbox.num_boxes =3D boot_cpu_data.x86_max_cores;
+	if (nhmex_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		nhmex_uncore_cbox.num_boxes =3D topology_num_cores_per_package();
 	uncore_msr_uncores =3D nhmex_msr_uncores;
 }
 /* end of Nehalem-EX uncore support */
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncor=
e_snb.c
index 7fd4334e12a1..9462fd9f3b7a 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -364,8 +364,8 @@ static struct intel_uncore_type *snb_msr_uncores[] =3D {
 void snb_uncore_cpu_init(void)
 {
 	uncore_msr_uncores =3D snb_msr_uncores;
-	if (snb_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		snb_uncore_cbox.num_boxes =3D boot_cpu_data.x86_max_cores;
+	if (snb_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		snb_uncore_cbox.num_boxes =3D topology_num_cores_per_package();
 }
=20
 static void skl_uncore_msr_init_box(struct intel_uncore_box *box)
@@ -428,8 +428,8 @@ static struct intel_uncore_type *skl_msr_uncores[] =3D {
 void skl_uncore_cpu_init(void)
 {
 	uncore_msr_uncores =3D skl_msr_uncores;
-	if (skl_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		skl_uncore_cbox.num_boxes =3D boot_cpu_data.x86_max_cores;
+	if (skl_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		skl_uncore_cbox.num_boxes =3D topology_num_cores_per_package();
 	snb_uncore_arb.ops =3D &skl_uncore_msr_ops;
 }
=20
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index a96496bef678..2eaf0f339849 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1172,8 +1172,8 @@ static struct intel_uncore_type *snbep_msr_uncores[] =
=3D {
=20
 void snbep_uncore_cpu_init(void)
 {
-	if (snbep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		snbep_uncore_cbox.num_boxes =3D boot_cpu_data.x86_max_cores;
+	if (snbep_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		snbep_uncore_cbox.num_boxes =3D topology_num_cores_per_package();
 	uncore_msr_uncores =3D snbep_msr_uncores;
 }
=20
@@ -1406,7 +1406,7 @@ static int topology_gidnid_map(int nodeid, u32 gidnid)
 	 */
 	for (i =3D 0; i < 8; i++) {
 		if (nodeid =3D=3D GIDNIDMAP(gidnid, i)) {
-			if (topology_max_die_per_package() > 1)
+			if (topology_max_dies_per_package() > 1)
 				die_id =3D i;
 			else
 				die_id =3D topology_phys_to_logical_pkg(i);
@@ -1845,8 +1845,8 @@ static struct intel_uncore_type *ivbep_msr_uncores[] =
=3D {
=20
 void ivbep_uncore_cpu_init(void)
 {
-	if (ivbep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		ivbep_uncore_cbox.num_boxes =3D boot_cpu_data.x86_max_cores;
+	if (ivbep_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		ivbep_uncore_cbox.num_boxes =3D topology_num_cores_per_package();
 	uncore_msr_uncores =3D ivbep_msr_uncores;
 }
=20
@@ -2917,8 +2917,8 @@ static bool hswep_has_limit_sbox(unsigned int device)
=20
 void hswep_uncore_cpu_init(void)
 {
-	if (hswep_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		hswep_uncore_cbox.num_boxes =3D boot_cpu_data.x86_max_cores;
+	if (hswep_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		hswep_uncore_cbox.num_boxes =3D topology_num_cores_per_package();
=20
 	/* Detect 6-8 core systems with only two SBOXes */
 	if (hswep_has_limit_sbox(HSWEP_PCU_DID))
@@ -3280,8 +3280,8 @@ static struct event_constraint bdx_uncore_pcu_constrain=
ts[] =3D {
=20
 void bdx_uncore_cpu_init(void)
 {
-	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
-		bdx_uncore_cbox.num_boxes =3D boot_cpu_data.x86_max_cores;
+	if (bdx_uncore_cbox.num_boxes > topology_num_cores_per_package())
+		bdx_uncore_cbox.num_boxes =3D topology_num_cores_per_package();
 	uncore_msr_uncores =3D bdx_msr_uncores;
=20
 	/* Detect systems with no SBOXes */
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8d98d468b976..fb2b1961e5a3 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -674,7 +674,7 @@ static const struct attribute_group *rapl_attr_update[] =
=3D {
=20
 static int __init init_rapl_pmus(void)
 {
-	int maxdie =3D topology_max_packages() * topology_max_die_per_package();
+	int maxdie =3D topology_max_packages() * topology_max_dies_per_package();
 	size_t size;
=20
 	size =3D sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 96e6c51515f5..804b629ea49d 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -26,8 +26,9 @@ void __init hv_vtl_init_platform(void)
 	x86_init.timers.timer_init =3D x86_init_noop;
=20
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_smp_config =3D x86_init_noop;
-	x86_init.mpparse.get_smp_config =3D x86_init_uint_noop;
+	x86_init.mpparse.find_mptable =3D x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg =3D x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg =3D x86_init_noop;
=20
 	x86_platform.get_wallclock =3D get_rtc_noop;
 	x86_platform.set_wallclock =3D set_rtc_noop;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9d159b771dc8..94ce0f7c9d3a 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -46,6 +46,10 @@ extern void x86_32_probe_apic(void);
 static inline void x86_32_probe_apic(void) { }
 #endif
=20
+extern u32 cpuid_to_apicid[];
+
+#define CPU_ACPIID_INVALID	U32_MAX
+
 #ifdef CONFIG_X86_LOCAL_APIC
=20
 extern int apic_verbosity;
@@ -54,8 +58,6 @@ extern int local_apic_timer_c2_ok;
 extern bool apic_is_disabled;
 extern unsigned int lapic_timer_period;
=20
-extern u32 cpuid_to_apicid[];
-
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
 	APIC_PIC,
@@ -169,6 +171,14 @@ extern bool apic_needs_pit(void);
=20
 extern void apic_send_IPI_allbutself(unsigned int vector);
=20
+extern void topology_register_apic(u32 apic_id, u32 acpi_id, bool present);
+extern void topology_register_boot_apic(u32 apic_id);
+extern int topology_hotplug_apic(u32 apic_id, u32 acpi_id);
+extern void topology_hotunplug_apic(unsigned int cpu);
+extern void topology_apply_cmdline_limits_early(void);
+extern void topology_init_possible_cpus(void);
+extern void topology_reset_possible_cpus_up(void);
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 #define local_apic_timer_c2_ok		1
@@ -183,6 +193,8 @@ static inline void apic_intr_mode_init(void) { }
 static inline void lapic_assign_system_vectors(void) { }
 static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
 static inline bool apic_needs_pit(void) { return true; }
+static inline void topology_apply_cmdline_limits_early(void) { }
+static inline void topology_init_possible_cpus(void) { }
 #endif /* !CONFIG_X86_LOCAL_APIC */
=20
 #ifdef CONFIG_X86_X2APIC
@@ -289,16 +301,11 @@ struct apic {
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	bool	(*apic_id_registered)(void);
=20
-	bool	(*check_apicid_used)(physid_mask_t *map, u32 apicid);
 	void	(*init_apic_ldr)(void);
-	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
-	u32	(*phys_pkg_id)(u32 cpuid_apic, int index_msb);
=20
 	u32	(*get_apic_id)(u32 id);
-	u32	(*set_apic_id)(u32 apicid);
=20
 	/* wakeup_secondary_cpu */
 	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
@@ -527,7 +534,6 @@ extern int default_apic_id_valid(u32 apicid);
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
=20
-extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_=
t *retmap);
 extern u32 default_cpu_present_to_apicid(int mps_cpu);
=20
 void apic_send_nmi_to_offline_cpu(unsigned int cpu);
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index f8f9a9b79395..aa30fd8cad7f 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -9,18 +9,10 @@
 #include <linux/percpu.h>
 #include <asm/ibt.h>
=20
-#ifdef CONFIG_SMP
-
-extern void prefill_possible_map(void);
-
-#else /* CONFIG_SMP */
-
-static inline void prefill_possible_map(void) {}
-
+#ifndef CONFIG_SMP
 #define cpu_physical_id(cpu)			boot_cpu_physical_apicid
 #define cpu_acpi_id(cpu)			0
 #define safe_smp_processor_id()			0
-
 #endif /* CONFIG_SMP */
=20
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 9bee3e7bf973..6b122a31da06 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -127,6 +127,42 @@ static inline unsigned int cpuid_edx(unsigned int op)
 	return edx;
 }
=20
+static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32=
 *regs)
+{
+	regs[CPUID_EAX] =3D leaf;
+	regs[CPUID_ECX] =3D subleaf;
+	__cpuid(regs + CPUID_EAX, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_=
EDX);
+}
+
+#define cpuid_subleaf(leaf, subleaf, regs) {		\
+	static_assert(sizeof(*(regs)) =3D=3D 16);		\
+	__cpuid_read(leaf, subleaf, (u32 *)(regs));	\
+}
+
+#define cpuid_leaf(leaf, regs) {			\
+	static_assert(sizeof(*(regs)) =3D=3D 16);		\
+	__cpuid_read(leaf, 0, (u32 *)(regs));		\
+}
+
+static inline void __cpuid_read_reg(unsigned int leaf, unsigned int subleaf,
+				    enum cpuid_regs_idx regidx, u32 *reg)
+{
+	u32 regs[4];
+
+	__cpuid_read(leaf, subleaf, regs);
+	*reg =3D regs[regidx];
+}
+
+#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg) {		\
+	static_assert(sizeof(*(reg)) =3D=3D 4);			\
+	__cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg));	\
+}
+
+#define cpuid_leaf_reg(leaf, regidx, reg) {			\
+	static_assert(sizeof(*(reg)) =3D=3D 4);			\
+	__cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));	\
+}
+
 static __always_inline bool cpuid_function_is_indexed(u32 function)
 {
 	switch (function) {
diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
index 51c782600e02..0d806513c4b3 100644
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -140,7 +140,6 @@ extern void mask_ioapic_entries(void);
 extern int restore_ioapic_entries(void);
=20
 extern void setup_ioapic_ids_from_mpc(void);
-extern void setup_ioapic_ids_from_mpc_nocheck(void);
=20
 extern int mp_find_ioapic(u32 gsi);
 extern int mp_find_ioapic_pin(int ioapic, u32 gsi);
diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 4b0f98a8d338..c72c7ff78fcd 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_MPSPEC_H
 #define _ASM_X86_MPSPEC_H
=20
+#include <linux/types.h>
=20
 #include <asm/mpspec_def.h>
 #include <asm/x86_init.h>
@@ -46,70 +47,31 @@ extern int smp_found_config;
 # define smp_found_config 0
 #endif
=20
-static inline void get_smp_config(void)
-{
-	x86_init.mpparse.get_smp_config(0);
-}
-
-static inline void early_get_smp_config(void)
-{
-	x86_init.mpparse.get_smp_config(1);
-}
-
-static inline void find_smp_config(void)
-{
-	x86_init.mpparse.find_smp_config();
-}
-
 #ifdef CONFIG_X86_MPPARSE
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
-extern void default_find_smp_config(void);
-extern void default_get_smp_config(unsigned int early);
+extern void mpparse_find_mptable(void);
+extern void mpparse_parse_early_smp_config(void);
+extern void mpparse_parse_smp_config(void);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
-#define enable_update_mptable 0
-#define default_find_smp_config x86_init_noop
-#define default_get_smp_config x86_init_uint_noop
+#define enable_update_mptable		0
+#define mpparse_find_mptable		x86_init_noop
+#define mpparse_parse_early_smp_config	x86_init_noop
+#define mpparse_parse_smp_config	x86_init_noop
 #endif
=20
-int generic_processor_info(int apicid);
+extern DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC);
=20
-#define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_LOCAL_APIC)
-
-struct physid_mask {
-	unsigned long mask[PHYSID_ARRAY_SIZE];
-};
-
-typedef struct physid_mask physid_mask_t;
-
-#define physid_set(physid, map)			set_bit(physid, (map).mask)
-#define physid_isset(physid, map)		test_bit(physid, (map).mask)
-
-#define physids_or(dst, src1, src2)					\
-	bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_LOCAL_APIC)
-
-#define physids_clear(map)					\
-	bitmap_zero((map).mask, MAX_LOCAL_APIC)
-
-#define physids_empty(map)					\
-	bitmap_empty((map).mask, MAX_LOCAL_APIC)
-
-static inline void physids_promote(unsigned long physids, physid_mask_t *map)
+static inline void reset_phys_cpu_present_map(u32 apicid)
 {
-	physids_clear(*map);
-	map->mask[0] =3D physids;
+	bitmap_zero(phys_cpu_present_map, MAX_LOCAL_APIC);
+	set_bit(apicid, phys_cpu_present_map);
 }
=20
-static inline void physid_set_mask_of_physid(int physid, physid_mask_t *map)
+static inline void copy_phys_cpu_present_map(unsigned long *dst)
 {
-	physids_clear(*map);
-	physid_set(physid, *map);
+	bitmap_copy(dst, phys_cpu_present_map, MAX_LOCAL_APIC);
 }
=20
-#define PHYSID_MASK_ALL		{ {[0 ... PHYSID_ARRAY_SIZE-1] =3D ~0UL} }
-#define PHYSID_MASK_NONE	{ {[0 ... PHYSID_ARRAY_SIZE-1] =3D 0UL} }
-
-extern physid_mask_t phys_cpu_present_map;
-
 #endif /* _ASM_X86_MPSPEC_H */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nosp=
ec-branch.h
index 2aa52cab1e46..ab19c7f1167b 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -323,7 +323,7 @@
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR=
_CPU_BUF
+	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
 .endm
=20
 #else /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/perf_event_p4.h b/arch/x86/include/asm/perf=
_event_p4.h
index 94de1a05aeba..d65e338b6a5f 100644
--- a/arch/x86/include/asm/perf_event_p4.h
+++ b/arch/x86/include/asm/perf_event_p4.h
@@ -181,7 +181,7 @@ static inline u64 p4_clear_ht_bit(u64 config)
 static inline int p4_ht_active(void)
 {
 #ifdef CONFIG_SMP
-	return smp_num_siblings > 1;
+	return __max_threads_per_core > 1;
 #endif
 	return 0;
 }
@@ -189,7 +189,7 @@ static inline int p4_ht_active(void)
 static inline int p4_ht_thread(int cpu)
 {
 #ifdef CONFIG_SMP
-	if (smp_num_siblings =3D=3D 2)
+	if (__max_threads_per_core =3D=3D 2)
 		return cpu !=3D cpumask_first(this_cpu_cpumask_var_ptr(cpu_sibling_map));
 #endif
 	return 0;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index 26620d7642a9..326581df4846 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -100,6 +100,9 @@ struct cpuinfo_topology {
 	u32			logical_pkg_id;
 	u32			logical_die_id;
=20
+	// AMD Node ID and Nodes per Package info
+	u32			amd_node_id;
+
 	// Cache level topology IDs
 	u32			llc_id;
 	u32			l2c_id;
@@ -119,8 +122,6 @@ struct cpuinfo_x86 {
 #endif
 	__u8			x86_virt_bits;
 	__u8			x86_phys_bits;
-	/* CPUID returned core id bits: */
-	__u8			x86_coreid_bits;
 	/* Max extended CPUID function supported: */
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=3Dno CPUID: */
@@ -148,8 +149,6 @@ struct cpuinfo_x86 {
 	unsigned long		loops_per_jiffy;
 	/* protected processor identification number */
 	u64			ppin;
-	/* cpuid returned max cores value: */
-	u16			x86_max_cores;
 	u16			x86_clflush_size;
 	/* number of cores as seen by the OS: */
 	u16			booted_cores;
@@ -704,12 +703,10 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
 }
=20
 #ifdef CONFIG_CPU_SUP_AMD
-extern u32 amd_get_nodes_per_socket(void);
 extern u32 amd_get_highest_perf(void);
 extern void amd_clear_divider(void);
 extern void amd_check_microcode(void);
 #else
-static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
 static inline void amd_clear_divider(void)		{ }
 static inline void amd_check_microcode(void)		{ }
diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
index 65dee2420624..043758a2e627 100644
--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -23,11 +23,11 @@ extern int of_ioapic;
 extern u64 initial_dtb;
 extern void add_dtb(u64 data);
 void x86_of_pci_init(void);
-void x86_dtb_init(void);
+void x86_dtb_parse_smp_config(void);
 #else
 static inline void add_dtb(u64 data) { }
 static inline void x86_of_pci_init(void) { }
-static inline void x86_dtb_init(void) { }
+static inline void x86_dtb_parse_smp_config(void) { }
 #define of_ioapic 0
 #endif
=20
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4fab2ed454f3..54d6d71e0eca 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -8,9 +8,6 @@
 #include <asm/current.h>
 #include <asm/thread_info.h>
=20
-extern int smp_num_siblings;
-extern unsigned int num_processors;
-
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
@@ -110,7 +107,6 @@ void cpu_disable_common(void);
 void native_smp_prepare_boot_cpu(void);
 void smp_prepare_cpus_common(void);
 void native_smp_prepare_cpus(unsigned int max_cpus);
-void calculate_max_logical_packages(void);
 void native_smp_cpus_done(unsigned int max_cpus);
 int common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_kick_ap(unsigned int cpu, struct task_struct *tidle);
@@ -174,8 +170,6 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 }
 #endif /* CONFIG_SMP */
=20
-extern unsigned disabled_cpus;
-
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
 extern void nmi_selftest(void);
 #else
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 5f87f6b9b09e..76b1d87f1531 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -102,6 +102,35 @@ static inline void setup_node_to_cpumask_map(void) { }
=20
 #include <asm-generic/topology.h>
=20
+/* Topology information */
+enum x86_topology_domains {
+	TOPO_SMT_DOMAIN,
+	TOPO_CORE_DOMAIN,
+	TOPO_MODULE_DOMAIN,
+	TOPO_TILE_DOMAIN,
+	TOPO_DIE_DOMAIN,
+	TOPO_DIEGRP_DOMAIN,
+	TOPO_PKG_DOMAIN,
+	TOPO_MAX_DOMAIN,
+};
+
+struct x86_topology_system {
+	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
+	unsigned int	dom_size[TOPO_MAX_DOMAIN];
+};
+
+extern struct x86_topology_system x86_topo_system;
+
+static inline unsigned int topology_get_domain_size(enum x86_topology_domain=
s dom)
+{
+	return x86_topo_system.dom_size[dom];
+}
+
+static inline unsigned int topology_get_domain_shift(enum x86_topology_domai=
ns dom)
+{
+	return dom =3D=3D TOPO_SMT_DOMAIN ? 0 : x86_topo_system.dom_shifts[dom - 1];
+}
+
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
=20
@@ -112,7 +141,42 @@ extern const struct cpumask *cpu_clustergroup_mask(int c=
pu);
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
=20
-extern unsigned int __max_die_per_package;
+#define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.amd_node_id)
+
+extern unsigned int __max_dies_per_package;
+extern unsigned int __max_logical_packages;
+extern unsigned int __max_threads_per_core;
+extern unsigned int __num_threads_per_package;
+extern unsigned int __num_cores_per_package;
+
+static inline unsigned int topology_max_packages(void)
+{
+	return __max_logical_packages;
+}
+
+static inline unsigned int topology_max_dies_per_package(void)
+{
+	return __max_dies_per_package;
+}
+
+static inline unsigned int topology_num_cores_per_package(void)
+{
+	return __num_cores_per_package;
+}
+
+static inline unsigned int topology_num_threads_per_package(void)
+{
+	return __num_threads_per_package;
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
+#else
+static inline int topology_get_logical_id(u32 apicid, enum x86_topology_doma=
ins at_level)
+{
+	return 0;
+}
+#endif
=20
 #ifdef CONFIG_SMP
 #define topology_cluster_id(cpu)		(cpu_data(cpu).topo.l2c_id)
@@ -121,12 +185,11 @@ extern unsigned int __max_die_per_package;
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
=20
-extern unsigned int __max_logical_packages;
-#define topology_max_packages()			(__max_logical_packages)
=20
-static inline int topology_max_die_per_package(void)
+static inline int topology_phys_to_logical_pkg(unsigned int pkg)
 {
-	return __max_die_per_package;
+	return topology_get_logical_id(pkg << x86_topo_system.dom_shifts[TOPO_PKG_D=
OMAIN],
+				       TOPO_PKG_DOMAIN);
 }
=20
 extern int __max_smt_threads;
@@ -138,9 +201,12 @@ static inline int topology_max_smt_threads(void)
=20
 #include <linux/cpu_smt.h>
=20
-int topology_update_package_map(unsigned int apicid, unsigned int cpu);
-int topology_update_die_map(unsigned int dieid, unsigned int cpu);
-int topology_phys_to_logical_pkg(unsigned int pkg);
+extern unsigned int __amd_nodes_per_pkg;
+
+static inline unsigned int topology_amd_nodes_per_pkg(void)
+{
+	return __amd_nodes_per_pkg;
+}
=20
 extern struct cpumask __cpu_primary_thread_mask;
 #define cpu_primary_thread_mask ((const struct cpumask *)&__cpu_primary_thre=
ad_mask)
@@ -153,16 +219,12 @@ static inline bool topology_is_primary_thread(unsigned =
int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_primary_thread_mask);
 }
+
 #else /* CONFIG_SMP */
-#define topology_max_packages()			(1)
-static inline int
-topology_update_package_map(unsigned int apicid, unsigned int cpu) { return =
0; }
-static inline int
-topology_update_die_map(unsigned int dieid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0;=
 }
-static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return tru=
e; }
+static inline unsigned int topology_amd_nodes_per_pkg(void) { return 0; };
 #endif /* !CONFIG_SMP */
=20
 static inline void arch_fix_phys_package_id(int num, u32 slot)
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c878616a18b8..9ca624749176 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -15,13 +15,15 @@ struct irq_domain;
 /**
  * struct x86_init_mpparse - platform specific mpparse ops
  * @setup_ioapic_ids:		platform specific ioapic id override
- * @find_smp_config:		find the smp configuration
- * @get_smp_config:		get the smp configuration
+ * @find_mptable:		Find MPTABLE early to reserve the memory region
+ * @early_parse_smp_cfg:	Parse the SMP configuration data early before initm=
em_init()
+ * @parse_smp_cfg:		Parse the SMP configuration data
  */
 struct x86_init_mpparse {
 	void (*setup_ioapic_ids)(void);
-	void (*find_smp_config)(void);
-	void (*get_smp_config)(unsigned int early);
+	void (*find_mptable)(void);
+	void (*early_parse_smp_cfg)(void);
+	void (*parse_smp_cfg)(void);
 };
=20
 /**
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 85a3ce2a3666..4bf82dbd2a6b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -164,35 +164,6 @@ static int __init acpi_parse_madt(struct acpi_table_head=
er *table)
 	return 0;
 }
=20
-/**
- * acpi_register_lapic - register a local apic and generates a logic cpu num=
ber
- * @id: local apic id to register
- * @acpiid: ACPI id to register
- * @enabled: this cpu is enabled or not
- *
- * Returns the logic cpu number which maps to the local apic
- */
-static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
-{
-	int cpu;
-
-	if (id >=3D MAX_LOCAL_APIC) {
-		pr_info("skipped apicid that is too big\n");
-		return -EINVAL;
-	}
-
-	if (!enabled) {
-		++disabled_cpus;
-		return -EINVAL;
-	}
-
-	cpu =3D generic_processor_info(id);
-	if (cpu >=3D 0)
-		early_per_cpu(x86_cpu_to_acpiid, cpu) =3D acpiid;
-
-	return cpu;
-}
-
 static bool __init acpi_is_processor_usable(u32 lapic_flags)
 {
 	if (lapic_flags & ACPI_MADT_ENABLED)
@@ -254,7 +225,7 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, co=
nst unsigned long end)
 		return 0;
 	}
=20
-	acpi_register_lapic(apic_id, processor->uid, enabled);
+	topology_register_apic(apic_id, processor->uid, enabled);
 #else
 	pr_warn("x2apic entry ignored\n");
 #endif
@@ -289,9 +260,9 @@ acpi_parse_lapic(union acpi_subtable_headers * header, co=
nst unsigned long end)
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	acpi_register_lapic(processor->id,	/* APIC ID */
-			    processor->processor_id, /* ACPI ID */
-			    processor->lapic_flags & ACPI_MADT_ENABLED);
+	topology_register_apic(processor->id,	/* APIC ID */
+			       processor->processor_id, /* ACPI ID */
+			       processor->lapic_flags & ACPI_MADT_ENABLED);
=20
 	has_lapic_cpus =3D true;
 	return 0;
@@ -309,9 +280,9 @@ acpi_parse_sapic(union acpi_subtable_headers *header, con=
st unsigned long end)
=20
 	acpi_table_print_madt_entry(&header->common);
=20
-	acpi_register_lapic((processor->id << 8) | processor->eid,/* APIC ID */
-			    processor->processor_id, /* ACPI ID */
-			    processor->lapic_flags & ACPI_MADT_ENABLED);
+	topology_register_apic((processor->id << 8) | processor->eid,/* APIC ID */
+			       processor->processor_id, /* ACPI ID */
+			       processor->lapic_flags & ACPI_MADT_ENABLED);
=20
 	return 0;
 }
@@ -844,12 +815,10 @@ static int acpi_map_cpu2node(acpi_handle handle, int cp=
u, int physid)
 	return 0;
 }
=20
-int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
-		 int *pcpu)
+int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *=
pcpu)
 {
-	int cpu;
+	int cpu =3D topology_hotplug_apic(physid, acpi_id);
=20
-	cpu =3D acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
 	if (cpu < 0) {
 		pr_info("Unable to map lapic to logical cpu number\n");
 		return cpu;
@@ -868,15 +837,11 @@ int acpi_unmap_cpu(int cpu)
 #ifdef CONFIG_ACPI_NUMA
 	set_apicid_to_node(per_cpu(x86_cpu_to_apicid, cpu), NUMA_NO_NODE);
 #endif
-
-	per_cpu(x86_cpu_to_apicid, cpu) =3D BAD_APICID;
-	set_cpu_present(cpu, false);
-	num_processors--;
-
-	return (0);
+	topology_hotunplug_apic(cpu);
+	return 0;
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
-#endif				/* CONFIG_ACPI_HOTPLUG_CPU */
+#endif	/* CONFIG_ACPI_HOTPLUG_CPU */
=20
 int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
 {
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 053f6dcc6b2c..5bf5f9fc5753 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -386,7 +386,7 @@ struct resource *amd_get_mmconfig_range(struct resource *=
res)
=20
 int amd_get_subcaches(int cpu)
 {
-	struct pci_dev *link =3D node_to_amd_nb(topology_die_id(cpu))->link;
+	struct pci_dev *link =3D node_to_amd_nb(topology_amd_node_id(cpu))->link;
 	unsigned int mask;
=20
 	if (!amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
@@ -400,7 +400,7 @@ int amd_get_subcaches(int cpu)
 int amd_set_subcaches(int cpu, unsigned long mask)
 {
 	static unsigned int reset, ban;
-	struct amd_northbridge *nb =3D node_to_amd_nb(topology_die_id(cpu));
+	struct amd_northbridge *nb =3D node_to_amd_nb(topology_amd_node_id(cpu));
 	unsigned int reg;
 	int cuid;
=20
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4667bc4b00ab..a42d8a6f7149 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -19,6 +19,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mc146818rtc.h>
 #include <linux/acpi_pmtmr.h>
+#include <linux/bitmap.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/memblock.h>
@@ -67,28 +68,12 @@
=20
 #include "local.h"
=20
-unsigned int num_processors;
-
-unsigned disabled_cpus;
-
 /* Processor that is doing the boot up */
 u32 boot_cpu_physical_apicid __ro_after_init =3D BAD_APICID;
 EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
=20
 u8 boot_cpu_apic_version __ro_after_init;
=20
-/*
- * Bitmask of physically existing CPUs:
- */
-physid_mask_t phys_cpu_present_map;
-
-/*
- * Processor to be disabled specified by kernel parameter
- * disable_cpu_apicid=3D<int>, mostly used for the kdump 2nd kernel to
- * avoid undefined behaviour caused by sending INIT from AP to BSP.
- */
-static u32 disabled_cpu_apicid __ro_after_init =3D BAD_APICID;
-
 /*
  * This variable controls which CPUs receive external NMIs.  By default,
  * external NMIs are delivered only to the BSP.
@@ -108,14 +93,6 @@ static inline bool apic_accessible(void)
 	return x2apic_mode || apic_mmio_base;
 }
=20
-/*
- * Map cpu index to physical APIC ID
- */
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, U32_MAX);
-EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
-EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
-
 #ifdef CONFIG_X86_32
 /* Local APIC was disabled by the BIOS and enabled by the kernel */
 static int enabled_via_apicbase __ro_after_init;
@@ -261,16 +238,6 @@ u64 native_apic_icr_read(void)
 	return icr1 | ((u64)icr2 << 32);
 }
=20
-#ifdef CONFIG_X86_32
-/**
- * get_physical_broadcast - Get number of physical broadcast IDs
- */
-int get_physical_broadcast(void)
-{
-	return modern_apic() ? 0xff : 0xf;
-}
-#endif
-
 /**
  * lapic_get_maxlvt - get the maximum number of local vector table entries
  */
@@ -1549,9 +1516,6 @@ static void setup_local_APIC(void)
 		apic_write(APIC_ESR, 0);
 	}
 #endif
-	/* Validate that the APIC is registered if required */
-	BUG_ON(apic->apic_id_registered && !apic->apic_id_registered());
-
 	/*
 	 * Intel recommends to set DFR, LDR and TPR before enabling
 	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
@@ -1690,8 +1654,6 @@ void apic_ap_setup(void)
 	end_local_APIC_setup();
 }
=20
-static __init void cpu_set_boot_apic(void);
-
 static __init void apic_read_boot_cpu_id(bool x2apic)
 {
 	/*
@@ -1706,7 +1668,8 @@ static __init void apic_read_boot_cpu_id(bool x2apic)
 		boot_cpu_physical_apicid =3D read_apic_id();
 		boot_cpu_apic_version =3D GET_APIC_VERSION(apic_read(APIC_LVR));
 	}
-	cpu_set_boot_apic();
+	topology_register_boot_apic(boot_cpu_physical_apicid);
+	x86_32_probe_bigsmp_early();
 }
=20
 #ifdef CONFIG_X86_X2APIC
@@ -2091,7 +2054,6 @@ void __init init_apic_mappings(void)
 			pr_info("APIC: disable apic facility\n");
 			apic_disable();
 		}
-		num_processors =3D 1;
 	}
 }
=20
@@ -2305,155 +2267,6 @@ void disconnect_bsp_APIC(int virt_wire_setup)
 	apic_write(APIC_LVT1, value);
 }
=20
-/*
- * The number of allocated logical CPU IDs. Since logical CPU IDs are alloca=
ted
- * contiguously, it equals to current allocated max logical CPU ID plus 1.
- * All allocated CPU IDs should be in the [0, nr_logical_cpuids) range,
- * so the maximum of nr_logical_cpuids is nr_cpu_ids.
- *
- * NOTE: Reserve 0 for BSP.
- */
-static int nr_logical_cpuids =3D 1;
-
-/*
- * Used to store mapping between logical CPU IDs and APIC IDs.
- */
-u32 cpuid_to_apicid[] =3D { [0 ... NR_CPUS - 1] =3D BAD_APICID, };
-
-bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
-{
-	return phys_id =3D=3D (u64)cpuid_to_apicid[cpu];
-}
-
-#ifdef CONFIG_SMP
-static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
-{
-	/* Isolate the SMT bit(s) in the APICID and check for 0 */
-	u32 mask =3D (1U << (fls(smp_num_siblings) - 1)) - 1;
-
-	if (smp_num_siblings =3D=3D 1 || !(apicid & mask))
-		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
-}
-
-/*
- * Due to the utter mess of CPUID evaluation smp_num_siblings is not valid
- * during early boot. Initialize the primary thread mask before SMP
- * bringup.
- */
-static int __init smp_init_primary_thread_mask(void)
-{
-	unsigned int cpu;
-
-	/*
-	 * XEN/PV provides either none or useless topology information.
-	 * Pretend that all vCPUs are primary threads.
-	 */
-	if (xen_pv_domain()) {
-		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
-		return 0;
-	}
-
-	for (cpu =3D 0; cpu < nr_logical_cpuids; cpu++)
-		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
-	return 0;
-}
-early_initcall(smp_init_primary_thread_mask);
-#else
-static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int ap=
icid) { }
-#endif
-
-/*
- * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
- * and cpuid_to_apicid[] synchronized.
- */
-static int allocate_logical_cpuid(int apicid)
-{
-	int i;
-
-	/*
-	 * cpuid <-> apicid mapping is persistent, so when a cpu is up,
-	 * check if the kernel has allocated a cpuid for it.
-	 */
-	for (i =3D 0; i < nr_logical_cpuids; i++) {
-		if (cpuid_to_apicid[i] =3D=3D apicid)
-			return i;
-	}
-
-	/* Allocate a new cpuid. */
-	if (nr_logical_cpuids >=3D nr_cpu_ids) {
-		WARN_ONCE(1, "APIC: NR_CPUS/possible_cpus limit of %u reached. "
-			     "Processor %d/0x%x and the rest are ignored.\n",
-			     nr_cpu_ids, nr_logical_cpuids, apicid);
-		return -EINVAL;
-	}
-
-	cpuid_to_apicid[nr_logical_cpuids] =3D apicid;
-	return nr_logical_cpuids++;
-}
-
-static void cpu_update_apic(int cpu, u32 apicid)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
-	early_per_cpu(x86_cpu_to_apicid, cpu) =3D apicid;
-#endif
-	set_cpu_possible(cpu, true);
-	physid_set(apicid, phys_cpu_present_map);
-	set_cpu_present(cpu, true);
-	num_processors++;
-
-	if (system_state !=3D SYSTEM_BOOTING)
-		cpu_mark_primary_thread(cpu, apicid);
-}
-
-static __init void cpu_set_boot_apic(void)
-{
-	cpuid_to_apicid[0] =3D boot_cpu_physical_apicid;
-	cpu_update_apic(0, boot_cpu_physical_apicid);
-	x86_32_probe_bigsmp_early();
-}
-
-int generic_processor_info(int apicid)
-{
-	int cpu, max =3D nr_cpu_ids;
-
-	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
-	if (cpuid_to_apicid[0] =3D=3D BAD_APICID)
-		panic("Boot CPU APIC not registered yet\n");
-
-	if (apicid =3D=3D boot_cpu_physical_apicid)
-		return 0;
-
-	if (disabled_cpu_apicid =3D=3D apicid) {
-		int thiscpu =3D num_processors + disabled_cpus;
-
-		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
-			thiscpu, apicid);
-
-		disabled_cpus++;
-		return -ENODEV;
-	}
-
-	if (num_processors >=3D nr_cpu_ids) {
-		int thiscpu =3D max + disabled_cpus;
-
-		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
-			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
-
-		disabled_cpus++;
-		return -EINVAL;
-	}
-
-	cpu =3D allocate_logical_cpuid(apicid);
-	if (cpu < 0) {
-		disabled_cpus++;
-		return -EINVAL;
-	}
-
-	cpu_update_apic(cpu, apicid);
-	return cpu;
-}
-
-
 void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 			   bool dmar)
 {
@@ -2496,10 +2309,7 @@ EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
=20
 static void __init apic_bsp_up_setup(void)
 {
-#ifdef CONFIG_X86_64
-	apic_write(APIC_ID, apic->set_apic_id(boot_cpu_physical_apicid));
-#endif
-	physid_set_mask_of_physid(boot_cpu_physical_apicid, &phys_cpu_present_map);
+	reset_phys_cpu_present_map(boot_cpu_physical_apicid);
 }
=20
 /**
@@ -2845,15 +2655,6 @@ static int __init lapic_insert_resource(void)
  */
 late_initcall(lapic_insert_resource);
=20
-static int __init apic_set_disabled_cpu_apicid(char *arg)
-{
-	if (!arg || !get_option(&arg, &disabled_cpu_apicid))
-		return -EINVAL;
-
-	return 0;
-}
-early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);
-
 static int __init apic_set_extnmi(char *arg)
 {
 	if (!arg)
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_c=
ommon.c
index 8a00141073ea..9ef3be866832 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -18,16 +18,6 @@ u32 apic_flat_calc_apicid(unsigned int cpu)
 	return 1U << cpu;
 }
=20
-bool default_check_apicid_used(physid_mask_t *map, u32 apicid)
-{
-	return physid_isset(apicid, *map);
-}
-
-void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retm=
ap)
-{
-	*retmap =3D *phys_map;
-}
-
 u32 default_cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < nr_cpu_ids && cpu_present(mps_cpu))
@@ -37,11 +27,6 @@ u32 default_cpu_present_to_apicid(int mps_cpu)
 }
 EXPORT_SYMBOL_GPL(default_cpu_present_to_apicid);
=20
-bool default_apic_id_registered(void)
-{
-	return physid_isset(read_apic_id(), phys_cpu_present_map);
-}
-
 /*
  * Set up the logical destination ID when the APIC operates in logical
  * destination mode.
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_=
flat_64.c
index b295a056a4fc..f37ad3392fec 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -61,16 +61,6 @@ static u32 flat_get_apic_id(u32 x)
 	return (x >> 24) & 0xFF;
 }
=20
-static u32 set_apic_id(u32 id)
-{
-	return (id & 0xFF) << 24;
-}
-
-static u32 flat_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return initial_apic_id >> index_msb;
-}
-
 static int flat_probe(void)
 {
 	return 1;
@@ -80,7 +70,6 @@ static struct apic apic_flat __ro_after_init =3D {
 	.name				=3D "flat",
 	.probe				=3D flat_probe,
 	.acpi_madt_oem_check		=3D flat_acpi_madt_oem_check,
-	.apic_id_registered		=3D default_apic_id_registered,
=20
 	.dest_mode_logical		=3D true,
=20
@@ -88,11 +77,9 @@ static struct apic apic_flat __ro_after_init =3D {
=20
 	.init_apic_ldr			=3D default_init_apic_ldr,
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
-	.phys_pkg_id			=3D flat_phys_pkg_id,
=20
 	.max_apic_id			=3D 0xFE,
 	.get_apic_id			=3D flat_get_apic_id,
-	.set_apic_id			=3D set_apic_id,
=20
 	.calc_dest_apicid		=3D apic_flat_calc_apicid,
=20
@@ -151,18 +138,15 @@ static struct apic apic_physflat __ro_after_init =3D {
 	.name				=3D "physical flat",
 	.probe				=3D physflat_probe,
 	.acpi_madt_oem_check		=3D physflat_acpi_madt_oem_check,
-	.apic_id_registered		=3D default_apic_id_registered,
=20
 	.dest_mode_logical		=3D false,
=20
 	.disable_esr			=3D 0,
=20
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
-	.phys_pkg_id			=3D flat_phys_pkg_id,
=20
 	.max_apic_id			=3D 0xFE,
 	.get_apic_id			=3D flat_get_apic_id,
-	.set_apic_id			=3D set_apic_id,
=20
 	.calc_dest_apicid		=3D apic_default_calc_apicid,
=20
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noo=
p.c
index 9f1d553eb48f..b5bb7a2e8340 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -29,7 +29,6 @@ static void noop_send_IPI_self(int vector) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
 static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { =
return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
-static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
 static u32 noop_get_apic_id(u32 apicid) { return 0; }
 static void noop_apic_eoi(void) { }
=20
@@ -51,12 +50,8 @@ struct apic apic_noop __ro_after_init =3D {
=20
 	.disable_esr			=3D 0,
=20
-	.check_apicid_used		=3D default_check_apicid_used,
-	.ioapic_phys_id_map		=3D default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
=20
-	.phys_pkg_id			=3D noop_phys_pkg_id,
-
 	.max_apic_id			=3D 0xFE,
 	.get_apic_id			=3D noop_get_apic_id,
=20
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic=
_numachip.c
index 7d0c51b9d3bc..16410f087b7a 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -38,11 +38,6 @@ static u32 numachip1_get_apic_id(u32 x)
 	return id;
 }
=20
-static u32 numachip1_set_apic_id(u32 id)
-{
-	return (id & 0xff) << 24;
-}
-
 static u32 numachip2_get_apic_id(u32 x)
 {
 	u64 mcfg;
@@ -51,16 +46,6 @@ static u32 numachip2_get_apic_id(u32 x)
 	return ((mcfg >> (28 - 8)) & 0xfff00) | (x >> 24);
 }
=20
-static u32 numachip2_set_apic_id(u32 id)
-{
-	return id << 24;
-}
-
-static u32 numachip_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return initial_apic_id >> index_msb;
-}
-
 static void numachip1_apic_icr_write(int apicid, unsigned int val)
 {
 	write_lcsr(CSR_G3_EXT_IRQ_GEN, (apicid << 16) | val);
@@ -227,11 +212,9 @@ static const struct apic apic_numachip1 __refconst =3D {
 	.disable_esr			=3D 0,
=20
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
-	.phys_pkg_id			=3D numachip_phys_pkg_id,
=20
 	.max_apic_id			=3D UINT_MAX,
 	.get_apic_id			=3D numachip1_get_apic_id,
-	.set_apic_id			=3D numachip1_set_apic_id,
=20
 	.calc_dest_apicid		=3D apic_default_calc_apicid,
=20
@@ -263,11 +246,9 @@ static const struct apic apic_numachip2 __refconst =3D {
 	.disable_esr			=3D 0,
=20
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
-	.phys_pkg_id			=3D numachip_phys_pkg_id,
=20
 	.max_apic_id			=3D UINT_MAX,
 	.get_apic_id			=3D numachip2_get_apic_id,
-	.set_apic_id			=3D numachip2_set_apic_id,
=20
 	.calc_dest_apicid		=3D apic_default_calc_apicid,
=20
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_3=
2.c
index 5a0d60b38e6b..9285d500d5b4 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -18,22 +18,6 @@ static u32 bigsmp_get_apic_id(u32 x)
 	return (x >> 24) & 0xFF;
 }
=20
-static bool bigsmp_check_apicid_used(physid_mask_t *map, u32 apicid)
-{
-	return false;
-}
-
-static void bigsmp_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t=
 *retmap)
-{
-	/* For clustered we don't have a good way to do this yet - hack */
-	physids_promote(0xFFL, retmap);
-}
-
-static u32 bigsmp_phys_pkg_id(u32 cpuid_apic, int index_msb)
-{
-	return cpuid_apic >> index_msb;
-}
-
 static void bigsmp_send_IPI_allbutself(int vector)
 {
 	default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
@@ -84,14 +68,10 @@ static struct apic apic_bigsmp __ro_after_init =3D {
=20
 	.disable_esr			=3D 1,
=20
-	.check_apicid_used		=3D bigsmp_check_apicid_used,
-	.ioapic_phys_id_map		=3D bigsmp_ioapic_phys_id_map,
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
-	.phys_pkg_id			=3D bigsmp_phys_pkg_id,
=20
 	.max_apic_id			=3D 0xFE,
 	.get_apic_id			=3D bigsmp_get_apic_id,
-	.set_apic_id			=3D NULL,
=20
 	.calc_dest_apicid		=3D apic_default_calc_apicid,
=20
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 40c7cf180c20..9f4fb3f2ddc4 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1458,20 +1458,20 @@ void restore_boot_irq_mode(void)
  *
  * by Matt Domsch <Matt_Domsch@dell.com>  Tue Dec 21 12:25:05 CST 1999
  */
-void __init setup_ioapic_ids_from_mpc_nocheck(void)
+static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 {
+	DECLARE_BITMAP(phys_id_present_map, MAX_LOCAL_APIC);
+	const u32 broadcast_id =3D 0xF;
 	union IO_APIC_reg_00 reg_00;
-	physid_mask_t phys_id_present_map;
-	int ioapic_idx;
-	int i;
 	unsigned char old_id;
 	unsigned long flags;
+	int ioapic_idx, i;
=20
 	/*
 	 * This is broken; anything with a real cpu count has to
 	 * circumvent this idiocy regardless.
 	 */
-	apic->ioapic_phys_id_map(&phys_cpu_present_map, &phys_id_present_map);
+	copy_phys_cpu_present_map(phys_id_present_map);
=20
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
@@ -1484,11 +1484,10 @@ void __init setup_ioapic_ids_from_mpc_nocheck(void)
=20
 		old_id =3D mpc_ioapic_id(ioapic_idx);
=20
-		if (mpc_ioapic_id(ioapic_idx) >=3D get_physical_broadcast()) {
-			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
-				ioapic_idx, mpc_ioapic_id(ioapic_idx));
-			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
-				reg_00.bits.ID);
+		if (mpc_ioapic_id(ioapic_idx) >=3D broadcast_id) {
+			pr_err(FW_BUG "IO-APIC#%d ID is %d in the MPC table!...\n",
+			       ioapic_idx, mpc_ioapic_id(ioapic_idx));
+			pr_err("... fixing up to %d. (tell your hw vendor)\n", reg_00.bits.ID);
 			ioapics[ioapic_idx].mp_config.apicid =3D reg_00.bits.ID;
 		}
=20
@@ -1497,23 +1496,21 @@ void __init setup_ioapic_ids_from_mpc_nocheck(void)
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 		 */
-		if (apic->check_apicid_used(&phys_id_present_map,
-					    mpc_ioapic_id(ioapic_idx))) {
-			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
-				ioapic_idx, mpc_ioapic_id(ioapic_idx));
-			for (i =3D 0; i < get_physical_broadcast(); i++)
-				if (!physid_isset(i, phys_id_present_map))
+		if (test_bit(mpc_ioapic_id(ioapic_idx), phys_id_present_map)) {
+			pr_err(FW_BUG "IO-APIC#%d ID %d is already used!...\n",
+			       ioapic_idx, mpc_ioapic_id(ioapic_idx));
+			for (i =3D 0; i < broadcast_id; i++)
+				if (!test_bit(i, phys_id_present_map))
 					break;
-			if (i >=3D get_physical_broadcast())
+			if (i >=3D broadcast_id)
 				panic("Max APIC ID exceeded!\n");
-			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
-				i);
-			physid_set(i, phys_id_present_map);
+			pr_err("... fixing up to %d. (tell your hw vendor)\n", i);
+			set_bit(i, phys_id_present_map);
 			ioapics[ioapic_idx].mp_config.apicid =3D i;
 		} else {
 			apic_printk(APIC_VERBOSE, "Setting %d in the phys_id_present_map\n",
 				    mpc_ioapic_id(ioapic_idx));
-			physid_set(mpc_ioapic_id(ioapic_idx), phys_id_present_map);
+			set_bit(mpc_ioapic_id(ioapic_idx), phys_id_present_map);
 		}
=20
 		/*
@@ -2209,7 +2206,7 @@ static inline void __init check_timer(void)
 	 * 8259A.
 	 */
 	if (pin1 =3D=3D -1) {
-		panic_if_irq_remap("BIOS bug: timer not connected to IO-APIC");
+		panic_if_irq_remap(FW_BUG "Timer not connected to IO-APIC");
 		pin1 =3D pin2;
 		apic1 =3D apic2;
 		no_pin1 =3D 1;
@@ -2494,56 +2491,41 @@ unsigned int arch_dynirq_lower_bound(unsigned int fro=
m)
 #ifdef CONFIG_X86_32
 static int io_apic_get_unique_id(int ioapic, int apic_id)
 {
+	static DECLARE_BITMAP(apic_id_map, MAX_LOCAL_APIC);
+	const u32 broadcast_id =3D 0xF;
 	union IO_APIC_reg_00 reg_00;
-	static physid_mask_t apic_id_map =3D PHYSID_MASK_NONE;
-	physid_mask_t tmp;
 	unsigned long flags;
 	int i =3D 0;
=20
-	/*
-	 * The P4 platform supports up to 256 APIC IDs on two separate APIC
-	 * buses (one for LAPICs, one for IOAPICs), where predecessors only
-	 * supports up to 16 on one shared APIC bus.
-	 *
-	 * TBD: Expand LAPIC/IOAPIC support on P4-class systems to take full
-	 *      advantage of new APIC bus architecture.
-	 */
-
-	if (physids_empty(apic_id_map))
-		apic->ioapic_phys_id_map(&phys_cpu_present_map, &apic_id_map);
+	/* Initialize the ID map */
+	if (bitmap_empty(apic_id_map, MAX_LOCAL_APIC))
+		copy_phys_cpu_present_map(apic_id_map);
=20
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
 	reg_00.raw =3D io_apic_read(ioapic, 0);
 	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
=20
-	if (apic_id >=3D get_physical_broadcast()) {
-		printk(KERN_WARNING "IOAPIC[%d]: Invalid apic_id %d, trying "
-			"%d\n", ioapic, apic_id, reg_00.bits.ID);
+	if (apic_id >=3D broadcast_id) {
+		pr_warn("IOAPIC[%d]: Invalid apic_id %d, trying %d\n",
+			ioapic, apic_id, reg_00.bits.ID);
 		apic_id =3D reg_00.bits.ID;
 	}
=20
-	/*
-	 * Every APIC in a system must have a unique ID or we get lots of nice
-	 * 'stuck on smp_invalidate_needed IPI wait' messages.
-	 */
-	if (apic->check_apicid_used(&apic_id_map, apic_id)) {
-
-		for (i =3D 0; i < get_physical_broadcast(); i++) {
-			if (!apic->check_apicid_used(&apic_id_map, i))
+	/* Every APIC in a system must have a unique ID */
+	if (test_bit(apic_id, apic_id_map)) {
+		for (i =3D 0; i < broadcast_id; i++) {
+			if (!test_bit(i, apic_id_map))
 				break;
 		}
=20
-		if (i =3D=3D get_physical_broadcast())
+		if (i =3D=3D broadcast_id)
 			panic("Max apic_id exceeded!\n");
=20
-		printk(KERN_WARNING "IOAPIC[%d]: apic_id %d already used, "
-			"trying %d\n", ioapic, apic_id, i);
-
+		pr_warn("IOAPIC[%d]: apic_id %d already used, trying %d\n", ioapic, apic_i=
d, i);
 		apic_id =3D i;
 	}
=20
-	physid_set_mask_of_physid(apic_id, &tmp);
-	physids_or(apic_id_map, apic_id_map, tmp);
+	set_bit(apic_id, apic_id_map);
=20
 	if (reg_00.bits.ID !=3D apic_id) {
 		reg_00.bits.ID =3D apic_id;
@@ -2569,11 +2551,9 @@ static int io_apic_get_unique_id(int ioapic, int apic_=
id)
=20
 static u8 io_apic_unique_id(int idx, u8 id)
 {
-	if ((boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL) &&
-	    !APIC_XAPIC(boot_cpu_apic_version))
+	if ((boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_INTEL) && !APIC_XAPIC(boot_=
cpu_apic_version))
 		return io_apic_get_unique_id(idx, id);
-	else
-		return id;
+	return id;
 }
 #else
 static u8 io_apic_unique_id(int idx, u8 id)
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 9ea6186ea88c..842fe28496be 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -16,8 +16,6 @@
 /* X2APIC */
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int de=
st);
 u32 x2apic_get_apic_id(u32 id);
-u32 x2apic_set_apic_id(u32 id);
-u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb);
=20
 void x2apic_send_IPI_all(int vector);
 void x2apic_send_IPI_allbutself(int vector);
@@ -63,9 +61,6 @@ void default_send_IPI_allbutself(int vector);
 void default_send_IPI_all(int vector);
 void default_send_IPI_self(int vector);
=20
-bool default_apic_id_registered(void);
-bool default_check_apicid_used(physid_mask_t *map, u32 apicid);
-
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int =
vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, in=
t vector);
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index c0f78059f06a..f75ee345c02d 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -18,11 +18,6 @@
=20
 #include "local.h"
=20
-static u32 default_phys_pkg_id(u32 cpuid_apic, int index_msb)
-{
-	return cpuid_apic >> index_msb;
-}
-
 static u32 default_get_apic_id(u32 x)
 {
 	unsigned int ver =3D GET_APIC_VERSION(apic_read(APIC_LVR));
@@ -43,17 +38,13 @@ static struct apic apic_default __ro_after_init =3D {
=20
 	.name				=3D "default",
 	.probe				=3D probe_default,
-	.apic_id_registered		=3D default_apic_id_registered,
=20
 	.dest_mode_logical		=3D true,
=20
 	.disable_esr			=3D 0,
=20
-	.check_apicid_used		=3D default_check_apicid_used,
 	.init_apic_ldr			=3D default_init_apic_ldr,
-	.ioapic_phys_id_map		=3D default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
-	.phys_pkg_id			=3D default_phys_pkg_id,
=20
 	.max_apic_id			=3D 0xFE,
 	.get_apic_id			=3D default_get_apic_id,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2a=
pic_cluster.c
index 28a7d3f2312d..567dbd2fe4b6 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -231,16 +231,12 @@ static struct apic apic_x2apic_cluster __ro_after_init =
=3D {
=20
 	.disable_esr			=3D 0,
=20
-	.check_apicid_used		=3D NULL,
 	.init_apic_ldr			=3D init_x2apic_ldr,
-	.ioapic_phys_id_map		=3D NULL,
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
-	.phys_pkg_id			=3D x2apic_phys_pkg_id,
=20
 	.max_apic_id			=3D UINT_MAX,
 	.x2apic_set_max_apicid		=3D true,
 	.get_apic_id			=3D x2apic_get_apic_id,
-	.set_apic_id			=3D x2apic_set_apic_id,
=20
 	.calc_dest_apicid		=3D x2apic_calc_apicid,
=20
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic=
_phys.c
index 409815a40668..12d4c35547a6 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -129,16 +129,6 @@ u32 x2apic_get_apic_id(u32 id)
 	return id;
 }
=20
-u32 x2apic_set_apic_id(u32 id)
-{
-	return id;
-}
-
-u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb)
-{
-	return initial_apicid >> index_msb;
-}
-
 static struct apic apic_x2apic_phys __ro_after_init =3D {
=20
 	.name				=3D "physical x2apic",
@@ -150,12 +140,10 @@ static struct apic apic_x2apic_phys __ro_after_init =3D=
 {
 	.disable_esr			=3D 0,
=20
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
-	.phys_pkg_id			=3D x2apic_phys_pkg_id,
=20
 	.max_apic_id			=3D UINT_MAX,
 	.x2apic_set_max_apicid		=3D true,
 	.get_apic_id			=3D x2apic_get_apic_id,
-	.set_apic_id			=3D x2apic_set_apic_id,
=20
 	.calc_dest_apicid		=3D apic_default_calc_apicid,
=20
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic=
_uv_x.c
index f1766b18dcd0..7fef504ca508 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -241,54 +241,20 @@ static void __init uv_tsc_check_sync(void)
 	is_uv(UV3) ? sname.s3.field :		\
 	undef)
=20
-/* [Copied from arch/x86/kernel/cpu/topology.c:detect_extended_topology()] */
-
-#define SMT_LEVEL			0	/* Leaf 0xb SMT level */
-#define INVALID_TYPE			0	/* Leaf 0xb sub-leaf types */
-#define SMT_TYPE			1
-#define CORE_TYPE			2
-#define LEAFB_SUBTYPE(ecx)		(((ecx) >> 8) & 0xff)
-#define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
-
-static void set_x2apic_bits(void)
-{
-	unsigned int eax, ebx, ecx, edx, sub_index;
-	unsigned int sid_shift;
-
-	cpuid(0, &eax, &ebx, &ecx, &edx);
-	if (eax < 0xb) {
-		pr_info("UV: CPU does not have CPUID.11\n");
-		return;
-	}
-
-	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	if (ebx =3D=3D 0 || (LEAFB_SUBTYPE(ecx) !=3D SMT_TYPE)) {
-		pr_info("UV: CPUID.11 not implemented\n");
-		return;
-	}
-
-	sid_shift =3D BITS_SHIFT_NEXT_LEVEL(eax);
-	sub_index =3D 1;
-	do {
-		cpuid_count(0xb, sub_index, &eax, &ebx, &ecx, &edx);
-		if (LEAFB_SUBTYPE(ecx) =3D=3D CORE_TYPE) {
-			sid_shift =3D BITS_SHIFT_NEXT_LEVEL(eax);
-			break;
-		}
-		sub_index++;
-	} while (LEAFB_SUBTYPE(ecx) !=3D INVALID_TYPE);
-
-	uv_cpuid.apicid_shift	=3D 0;
-	uv_cpuid.apicid_mask	=3D (~(-1 << sid_shift));
-	uv_cpuid.socketid_shift =3D sid_shift;
-}
-
 static void __init early_get_apic_socketid_shift(void)
 {
+	unsigned int sid_shift =3D topology_get_domain_shift(TOPO_PKG_DOMAIN);
+
 	if (is_uv2_hub() || is_uv3_hub())
 		uvh_apicid.v =3D uv_early_read_mmr(UVH_APICID);
=20
-	set_x2apic_bits();
+	if (sid_shift) {
+		uv_cpuid.apicid_shift	=3D 0;
+		uv_cpuid.apicid_mask	=3D (~(-1 << sid_shift));
+		uv_cpuid.socketid_shift =3D sid_shift;
+	} else {
+		pr_info("UV: CPU does not have valid CPUID.11\n");
+	}
=20
 	pr_info("UV: apicid_shift:%d apicid_mask:0x%x\n", uv_cpuid.apicid_shift, uv=
_cpuid.apicid_mask);
 	pr_info("UV: socketid_shift:%d pnode_mask:0x%x\n", uv_cpuid.socketid_shift,=
 uv_cpuid.pnode_mask);
@@ -779,21 +745,6 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
=20
-static u32 set_apic_id(u32 id)
-{
-	return id;
-}
-
-static unsigned int uv_read_apic_id(void)
-{
-	return x2apic_get_apic_id(apic_read(APIC_ID));
-}
-
-static u32 uv_phys_pkg_id(u32 initial_apicid, int index_msb)
-{
-	return uv_read_apic_id() >> index_msb;
-}
-
 static int uv_probe(void)
 {
 	return apic =3D=3D &apic_x2apic_uv_x;
@@ -810,11 +761,9 @@ static struct apic apic_x2apic_uv_x __ro_after_init =3D {
 	.disable_esr			=3D 0,
=20
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
-	.phys_pkg_id			=3D uv_phys_pkg_id,
=20
 	.max_apic_id			=3D UINT_MAX,
 	.get_apic_id			=3D x2apic_get_apic_id,
-	.set_apic_id			=3D set_apic_id,
=20
 	.calc_dest_apicid		=3D apic_default_calc_apicid,
=20
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 93eabf544031..eb4dbcdf41f1 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -17,7 +17,8 @@ KMSAN_SANITIZE_common.o :=3D n
 # As above, instrumenting secondary CPU boot code causes boot hangs.
 KCSAN_SANITIZE_common.o :=3D n
=20
-obj-y			:=3D cacheinfo.o scattered.o topology.o
+obj-y			:=3D cacheinfo.o scattered.o
+obj-y			+=3D topology_common.o topology_ext.o topology_amd.o
 obj-y			+=3D common.o
 obj-y			+=3D rdrand.o
 obj-y			+=3D match.o
@@ -25,14 +26,16 @@ obj-y			+=3D bugs.o
 obj-y			+=3D aperfmperf.o
 obj-y			+=3D cpuid-deps.o
 obj-y			+=3D umwait.o
+obj-y 			+=3D capflags.o powerflags.o
=20
-obj-$(CONFIG_PROC_FS)	+=3D proc.o
-obj-y +=3D capflags.o powerflags.o
+obj-$(CONFIG_X86_LOCAL_APIC)		+=3D topology.o
=20
-obj-$(CONFIG_IA32_FEAT_CTL) +=3D feat_ctl.o
+obj-$(CONFIG_PROC_FS)			+=3D proc.o
+
+obj-$(CONFIG_IA32_FEAT_CTL)		+=3D feat_ctl.o
 ifdef CONFIG_CPU_SUP_INTEL
-obj-y			+=3D intel.o intel_pconfig.o tsx.o
-obj-$(CONFIG_PM)	+=3D intel_epb.o
+obj-y					+=3D intel.o intel_pconfig.o tsx.o
+obj-$(CONFIG_PM)			+=3D intel_epb.o
 endif
 obj-$(CONFIG_CPU_SUP_AMD)		+=3D amd.o
 obj-$(CONFIG_CPU_SUP_HYGON)		+=3D hygon.o
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f3abca334199..c82069e5f341 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -27,13 +27,6 @@
=20
 #include "cpu.h"
=20
-/*
- * nodes_per_socket: Stores the number of nodes per socket.
- * Refer to Fam15h Models 00-0fh BKDG - CPUID Fn8000_001E_ECX
- * Node Identifiers[10:8]
- */
-static u32 nodes_per_socket =3D 1;
-
 static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 {
 	u32 gprs[8] =3D { 0 };
@@ -300,97 +293,6 @@ static int nearby_node(int apicid)
 }
 #endif
=20
-/*
- * Fix up topo::core_id for pre-F17h systems to be in the
- * [0 .. cores_per_node - 1] range. Not really needed but
- * kept so as not to break existing setups.
- */
-static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
-{
-	u32 cus_per_node;
-
-	if (c->x86 >=3D 0x17)
-		return;
-
-	cus_per_node =3D c->x86_max_cores / nodes_per_socket;
-	c->topo.core_id %=3D cus_per_node;
-}
-
-/*
- * Fixup core topology information for
- * (1) AMD multi-node processors
- *     Assumption: Number of cores in each internal node is the same.
- * (2) AMD processors supporting compute units
- */
-static void amd_get_topology(struct cpuinfo_x86 *c)
-{
-	/* get information required for multi-node processors */
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		int err;
-		u32 eax, ebx, ecx, edx;
-
-		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
-
-		c->topo.die_id  =3D ecx & 0xff;
-
-		if (c->x86 =3D=3D 0x15)
-			c->topo.cu_id =3D ebx & 0xff;
-
-		if (c->x86 >=3D 0x17) {
-			c->topo.core_id =3D ebx & 0xff;
-
-			if (smp_num_siblings > 1)
-				c->x86_max_cores /=3D smp_num_siblings;
-		}
-
-		/*
-		 * In case leaf B is available, use it to derive
-		 * topology information.
-		 */
-		err =3D detect_extended_topology(c);
-		if (!err)
-			c->x86_coreid_bits =3D get_count_order(c->x86_max_cores);
-
-		cacheinfo_amd_init_llc_id(c);
-
-	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
-		u64 value;
-
-		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->topo.die_id =3D value & 7;
-		c->topo.llc_id =3D c->topo.die_id;
-	} else
-		return;
-
-	if (nodes_per_socket > 1) {
-		set_cpu_cap(c, X86_FEATURE_AMD_DCM);
-		legacy_fixup_core_id(c);
-	}
-}
-
-/*
- * On a AMD dual core setup the lower bits of the APIC id distinguish the co=
res.
- * Assumes number of cores is a power of two.
- */
-static void amd_detect_cmp(struct cpuinfo_x86 *c)
-{
-	unsigned bits;
-
-	bits =3D c->x86_coreid_bits;
-	/* Low order bits define the core id (index of core in socket) */
-	c->topo.core_id =3D c->topo.initial_apicid & ((1 << bits)-1);
-	/* Convert the initial APIC ID into the socket ID */
-	c->topo.pkg_id =3D c->topo.initial_apicid >> bits;
-	/* use socket ID also for last level cache */
-	c->topo.llc_id =3D c->topo.die_id =3D c->topo.pkg_id;
-}
-
-u32 amd_get_nodes_per_socket(void)
-{
-	return nodes_per_socket;
-}
-EXPORT_SYMBOL_GPL(amd_get_nodes_per_socket);
-
 static void srat_detect_node(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_NUMA
@@ -442,32 +344,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
=20
-static void early_init_amd_mc(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned bits, ecx;
-
-	/* Multi core CPU? */
-	if (c->extended_cpuid_level < 0x80000008)
-		return;
-
-	ecx =3D cpuid_ecx(0x80000008);
-
-	c->x86_max_cores =3D (ecx & 0xff) + 1;
-
-	/* CPU telling us the core id bits shift? */
-	bits =3D (ecx >> 12) & 0xF;
-
-	/* Otherwise recompute */
-	if (bits =3D=3D 0) {
-		while ((1 << bits) < c->x86_max_cores)
-			bits++;
-	}
-
-	c->x86_coreid_bits =3D bits;
-#endif
-}
-
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
@@ -500,18 +376,6 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_MWAITX))
 		use_mwaitx_delay();
=20
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		u32 ecx;
-
-		ecx =3D cpuid_ecx(0x8000001e);
-		__max_die_per_package =3D nodes_per_socket =3D ((ecx >> 8) & 7) + 1;
-	} else if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
-		u64 value;
-
-		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		__max_die_per_package =3D nodes_per_socket =3D ((value >> 3) & 7) + 1;
-	}
-
 	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
 	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD) &&
 	    c->x86 >=3D 0x15 && c->x86 <=3D 0x17) {
@@ -649,8 +513,6 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	u64 value;
 	u32 dummy;
=20
-	early_init_amd_mc(c);
-
 	if (c->x86 >=3D 0xf)
 		set_cpu_cap(c, X86_FEATURE_K8);
=20
@@ -730,9 +592,6 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 		}
 	}
=20
-	if (cpu_has(c, X86_FEATURE_TOPOEXT))
-		smp_num_siblings =3D ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
-
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRT=
YPE)) {
 		if (c->x86 =3D=3D 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
@@ -1076,9 +935,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_FSRM))
 		set_cpu_cap(c, X86_FEATURE_FSRS);
=20
-	/* get apicid instead of initial apic id from cpuid */
-	c->topo.apicid =3D read_apic_id();
-
 	/* K6s reports MCEs but don't actually have all the MSRs */
 	if (c->x86 < 6)
 		clear_cpu_cap(c, X86_FEATURE_MCE);
@@ -1114,8 +970,6 @@ static void init_amd(struct cpuinfo_x86 *c)
=20
 	cpu_detect_cache_sizes(c);
=20
-	amd_detect_cmp(c);
-	amd_get_topology(c);
 	srat_detect_node(c);
=20
 	init_amd_cacheinfo(c);
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c131c412db89..f2241e7e96fd 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -301,7 +301,7 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	eax->split.type =3D types[leaf];
 	eax->split.level =3D levels[leaf];
 	eax->split.num_threads_sharing =3D 0;
-	eax->split.num_cores_on_die =3D __this_cpu_read(cpu_info.x86_max_cores) - 1;
+	eax->split.num_cores_on_die =3D topology_num_cores_per_package();
=20
=20
 	if (assoc =3D=3D 0xffff)
@@ -595,7 +595,7 @@ static void amd_init_l3_cache(struct _cpuid4_info_regs *t=
his_leaf, int index)
 	if (index < 3)
 		return;
=20
-	node =3D topology_die_id(smp_processor_id());
+	node =3D topology_amd_node_id(smp_processor_id());
 	this_leaf->nb =3D node_to_amd_nb(node);
 	if (this_leaf->nb && !this_leaf->nb->l3_cache.indices)
 		amd_calc_l3_indices(this_leaf->nb);
@@ -661,7 +661,7 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
=20
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c)
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
@@ -672,7 +672,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c)
=20
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
-		c->topo.llc_id =3D c->topo.die_id;
+		c->topo.llc_id =3D die_id;
 	} else if (c->x86 =3D=3D 0x17 && c->x86_model <=3D 0x1F) {
 		/*
 		 * LLC is at the core complex level.
diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 345f7d905db6..a3b55db35c96 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -128,10 +128,6 @@ static void init_centaur(struct cpuinfo_x86 *c)
 #endif
 	early_init_centaur(c);
 	init_intel_cacheinfo(c);
-	detect_num_cpu_cores(c);
-#ifdef CONFIG_X86_32
-	detect_ht(c);
-#endif
=20
 	if (c->cpuid_level > 9) {
 		unsigned int eax =3D cpuid_eax(10);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fbc4e60d027c..087d21734286 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -73,8 +73,20 @@
 u32 elf_hwcap2 __read_mostly;
=20
 /* Number of siblings per CPU package */
-int smp_num_siblings =3D 1;
-EXPORT_SYMBOL(smp_num_siblings);
+unsigned int __max_threads_per_core __ro_after_init =3D 1;
+EXPORT_SYMBOL(__max_threads_per_core);
+
+unsigned int __max_dies_per_package __ro_after_init =3D 1;
+EXPORT_SYMBOL(__max_dies_per_package);
+
+unsigned int __max_logical_packages __ro_after_init =3D 1;
+EXPORT_SYMBOL(__max_logical_packages);
+
+unsigned int __num_cores_per_package __ro_after_init =3D 1;
+EXPORT_SYMBOL(__num_cores_per_package);
+
+unsigned int __num_threads_per_package __ro_after_init =3D 1;
+EXPORT_SYMBOL(__num_threads_per_package);
=20
 static struct ppin_info {
 	int	feature;
@@ -790,19 +802,6 @@ static void get_model_name(struct cpuinfo_x86 *c)
 	*(s + 1) =3D '\0';
 }
=20
-void detect_num_cpu_cores(struct cpuinfo_x86 *c)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	c->x86_max_cores =3D 1;
-	if (!IS_ENABLED(CONFIG_SMP) || c->cpuid_level < 4)
-		return;
-
-	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
-	if (eax & 0x1f)
-		c->x86_max_cores =3D (eax >> 26) + 1;
-}
-
 void cpu_detect_cache_sizes(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, ebx, ecx, edx, l2size;
@@ -864,51 +863,6 @@ static void cpu_detect_tlb(struct cpuinfo_x86 *c)
 		tlb_lld_4m[ENTRIES], tlb_lld_1g[ENTRIES]);
 }
=20
-int detect_ht_early(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	u32 eax, ebx, ecx, edx;
-
-	if (!cpu_has(c, X86_FEATURE_HT))
-		return -1;
-
-	if (cpu_has(c, X86_FEATURE_CMP_LEGACY))
-		return -1;
-
-	if (cpu_has(c, X86_FEATURE_XTOPOLOGY))
-		return -1;
-
-	cpuid(1, &eax, &ebx, &ecx, &edx);
-
-	smp_num_siblings =3D (ebx & 0xff0000) >> 16;
-	if (smp_num_siblings =3D=3D 1)
-		pr_info_once("CPU0: Hyper-Threading is disabled\n");
-#endif
-	return 0;
-}
-
-void detect_ht(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	int index_msb, core_bits;
-
-	if (detect_ht_early(c) < 0)
-		return;
-
-	index_msb =3D get_count_order(smp_num_siblings);
-	c->topo.pkg_id =3D apic->phys_pkg_id(c->topo.initial_apicid, index_msb);
-
-	smp_num_siblings =3D smp_num_siblings / c->x86_max_cores;
-
-	index_msb =3D get_count_order(smp_num_siblings);
-
-	core_bits =3D get_count_order(c->x86_max_cores);
-
-	c->topo.core_id =3D apic->phys_pkg_id(c->topo.initial_apicid, index_msb) &
-		((1 << core_bits) - 1);
-#endif
-}
-
 static void get_cpu_vendor(struct cpuinfo_x86 *c)
 {
 	char *v =3D c->x86_vendor_id;
@@ -1592,6 +1546,8 @@ static void __init early_identify_cpu(struct cpuinfo_x8=
6 *c)
 		get_cpu_address_sizes(c);
 		cpu_parse_early_param();
=20
+		cpu_init_topology(c);
+
 		if (this_cpu->c_early_init)
 			this_cpu->c_early_init(c);
=20
@@ -1603,6 +1559,7 @@ static void __init early_identify_cpu(struct cpuinfo_x8=
6 *c)
 	} else {
 		setup_clear_cpu_cap(X86_FEATURE_CPUID);
 		get_cpu_address_sizes(c);
+		cpu_init_topology(c);
 	}
=20
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
@@ -1748,18 +1705,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
=20
 	get_cpu_address_sizes(c);
=20
-	if (c->cpuid_level >=3D 0x00000001) {
-		c->topo.initial_apicid =3D (cpuid_ebx(1) >> 24) & 0xFF;
-#ifdef CONFIG_X86_32
-# ifdef CONFIG_SMP
-		c->topo.apicid =3D apic->phys_pkg_id(c->topo.initial_apicid, 0);
-# else
-		c->topo.apicid =3D c->topo.initial_apicid;
-# endif
-#endif
-		c->topo.pkg_id =3D c->topo.initial_apicid;
-	}
-
 	get_model_name(c); /* Default name */
=20
 	/*
@@ -1780,29 +1725,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 #endif
 }
=20
-/*
- * Validate that ACPI/mptables have the same information about the
- * effective APIC id and update the package map.
- */
-static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned int cpu =3D smp_processor_id();
-	u32 apicid;
-
-	apicid =3D apic->cpu_present_to_apicid(cpu);
-
-	if (apicid !=3D c->topo.apicid) {
-		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
-		       cpu, apicid, c->topo.initial_apicid);
-	}
-	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
-	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
-#else
-	c->topo.logical_pkg_id =3D 0;
-#endif
-}
-
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -1816,11 +1738,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->x86_model =3D c->x86_stepping =3D 0;	/* So far unknown... */
 	c->x86_vendor_id[0] =3D '\0'; /* Unset */
 	c->x86_model_id[0] =3D '\0';  /* Unset */
-	c->x86_max_cores =3D 1;
-	c->x86_coreid_bits =3D 0;
-	c->topo.cu_id =3D 0xff;
-	c->topo.llc_id =3D BAD_APICID;
-	c->topo.l2c_id =3D BAD_APICID;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size =3D 64;
 	c->x86_phys_bits =3D 36;
@@ -1839,17 +1756,14 @@ static void identify_cpu(struct cpuinfo_x86 *c)
=20
 	generic_identify(c);
=20
+	cpu_parse_topology(c);
+
 	if (this_cpu->c_identify)
 		this_cpu->c_identify(c);
=20
 	/* Clear/Set all flags overridden by options, after probe */
 	apply_forced_caps(c);
=20
-#ifdef CONFIG_X86_64
-	c->topo.apicid =3D apic->phys_pkg_id(c->topo.initial_apicid, 0);
-#endif
-
-
 	/*
 	 * Set default APIC and TSC_DEADLINE MSR fencing flag. AMD and
 	 * Hygon will clear it in ->c_init() below.
@@ -1903,10 +1817,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 				c->x86, c->x86_model);
 	}
=20
-#ifdef CONFIG_X86_64
-	detect_ht(c);
-#endif
-
 	x86_init_rdrand(c);
 	setup_pku(c);
 	setup_cet(c);
@@ -1998,7 +1908,6 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	validate_apic_and_package_id(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
 	if (boot_cpu_has_bug(X86_BUG_GDS))
@@ -2347,7 +2256,7 @@ void __init arch_cpu_finalize_init(void)
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
 	 */
-	cpu_smt_set_num_threads(smp_num_siblings, smp_num_siblings);
+	cpu_smt_set_num_threads(__max_threads_per_core, __max_threads_per_core);
=20
 	if (!IS_ENABLED(CONFIG_SMP)) {
 		pr_info("CPU: ");
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 885281ae79a5..ea9e07d57c8d 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -2,6 +2,11 @@
 #ifndef ARCH_X86_CPU_H
 #define ARCH_X86_CPU_H
=20
+#include <asm/cpu.h>
+#include <asm/topology.h>
+
+#include "topology.h"
+
 /* attempt to consolidate cpu attributes */
 struct cpu_dev {
 	const char	*c_vendor;
@@ -71,14 +76,9 @@ extern void init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_hygon_cacheinfo(struct cpuinfo_x86 *c);
=20
-extern void detect_num_cpu_cores(struct cpuinfo_x86 *c);
-extern int detect_extended_topology_early(struct cpuinfo_x86 *c);
-extern int detect_extended_topology(struct cpuinfo_x86 *c);
-extern int detect_ht_early(struct cpuinfo_x86 *c);
-extern void detect_ht(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
=20
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c);
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c);
=20
 unsigned int aperfmperf_get_khz(int cpu);
@@ -96,4 +96,5 @@ static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2=
_mitigation mode)
 	       mode =3D=3D SPECTRE_V2_EIBRS_RETPOLINE ||
 	       mode =3D=3D SPECTRE_V2_EIBRS_LFENCE;
 }
+
 #endif /* ARCH_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 0c179d684b3b..3baf3e435834 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -5,6 +5,8 @@
 #include <asm/apic.h>
 #include <asm/processor.h>
=20
+#include "cpu.h"
+
 static int cpu_debug_show(struct seq_file *m, void *p)
 {
 	unsigned long cpu =3D (unsigned long)m->private;
@@ -24,9 +26,12 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
 	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
-	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
-	seq_printf(m, "max_die_per_pkg:     %u\n", __max_die_per_package);
-	seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
+	seq_printf(m, "amd_node_id:         %u\n", c->topo.amd_node_id);
+	seq_printf(m, "amd_nodes_per_pkg:   %u\n", topology_amd_nodes_per_pkg());
+	seq_printf(m, "num_threads:         %u\n", __num_threads_per_package);
+	seq_printf(m, "num_cores:           %u\n", __num_cores_per_package);
+	seq_printf(m, "max_dies_per_pkg:    %u\n", __max_dies_per_package);
+	seq_printf(m, "max_threads_per_core:%u\n", __max_threads_per_core);
 	return 0;
 }
=20
@@ -42,12 +47,48 @@ static const struct file_operations dfs_cpu_ops =3D {
 	.release	=3D single_release,
 };
=20
+static int dom_debug_show(struct seq_file *m, void *p)
+{
+	static const char *domain_names[TOPO_MAX_DOMAIN] =3D {
+		[TOPO_SMT_DOMAIN]	=3D "Thread",
+		[TOPO_CORE_DOMAIN]	=3D "Core",
+		[TOPO_MODULE_DOMAIN]	=3D "Module",
+		[TOPO_TILE_DOMAIN]	=3D "Tile",
+		[TOPO_DIE_DOMAIN]	=3D "Die",
+		[TOPO_DIEGRP_DOMAIN]	=3D "DieGrp",
+		[TOPO_PKG_DOMAIN]	=3D "Package",
+	};
+	unsigned int dom, nthreads =3D 1;
+
+	for (dom =3D 0; dom < TOPO_MAX_DOMAIN; dom++) {
+		nthreads *=3D x86_topo_system.dom_size[dom];
+		seq_printf(m, "domain: %-10s shift: %u dom_size: %5u max_threads: %5u\n",
+			   domain_names[dom], x86_topo_system.dom_shifts[dom],
+			   x86_topo_system.dom_size[dom], nthreads);
+	}
+	return 0;
+}
+
+static int dom_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dom_debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_dom_ops =3D {
+	.open		=3D dom_debug_open,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
 static __init int cpu_init_debugfs(void)
 {
 	struct dentry *dir, *base =3D debugfs_create_dir("topo", arch_debugfs_dir);
 	unsigned long id;
 	char name[24];
=20
+	debugfs_create_file("domains", 0444, base, NULL, &dfs_dom_ops);
+
 	dir =3D debugfs_create_dir("cpus", base);
 	for_each_possible_cpu(id) {
 		sprintf(name, "%lu", id);
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index f0cd95502faa..c5191b06f9f2 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -18,14 +18,6 @@
=20
 #include "cpu.h"
=20
-#define APICID_SOCKET_ID_BIT 6
-
-/*
- * nodes_per_socket: Stores the number of nodes per socket.
- * Refer to CPUID Fn8000_001E_ECX Node Identifiers[10:8]
- */
-static u32 nodes_per_socket =3D 1;
-
 #ifdef CONFIG_NUMA
 /*
  * To workaround broken NUMA config.  Read the comment in
@@ -49,80 +41,6 @@ static int nearby_node(int apicid)
 }
 #endif
=20
-static void hygon_get_topology_early(struct cpuinfo_x86 *c)
-{
-	if (cpu_has(c, X86_FEATURE_TOPOEXT))
-		smp_num_siblings =3D ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
-}
-
-/*
- * Fixup core topology information for
- * (1) Hygon multi-node processors
- *     Assumption: Number of cores in each internal node is the same.
- * (2) Hygon processors supporting compute units
- */
-static void hygon_get_topology(struct cpuinfo_x86 *c)
-{
-	/* get information required for multi-node processors */
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		int err;
-		u32 eax, ebx, ecx, edx;
-
-		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
-
-		c->topo.die_id  =3D ecx & 0xff;
-
-		c->topo.core_id =3D ebx & 0xff;
-
-		if (smp_num_siblings > 1)
-			c->x86_max_cores /=3D smp_num_siblings;
-
-		/*
-		 * In case leaf B is available, use it to derive
-		 * topology information.
-		 */
-		err =3D detect_extended_topology(c);
-		if (!err)
-			c->x86_coreid_bits =3D get_count_order(c->x86_max_cores);
-
-		/*
-		 * Socket ID is ApicId[6] for the processors with model <=3D 0x3
-		 * when running on host.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && c->x86_model <=3D 0x3)
-			c->topo.pkg_id =3D c->topo.apicid >> APICID_SOCKET_ID_BIT;
-
-		cacheinfo_hygon_init_llc_id(c);
-	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
-		u64 value;
-
-		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->topo.die_id =3D value & 7;
-		c->topo.llc_id =3D c->topo.die_id;
-	} else
-		return;
-
-	if (nodes_per_socket > 1)
-		set_cpu_cap(c, X86_FEATURE_AMD_DCM);
-}
-
-/*
- * On Hygon setup the lower bits of the APIC id distinguish the cores.
- * Assumes number of cores is a power of two.
- */
-static void hygon_detect_cmp(struct cpuinfo_x86 *c)
-{
-	unsigned int bits;
-
-	bits =3D c->x86_coreid_bits;
-	/* Low order bits define the core id (index of core in socket) */
-	c->topo.core_id =3D c->topo.initial_apicid & ((1 << bits)-1);
-	/* Convert the initial APIC ID into the socket ID */
-	c->topo.pkg_id =3D c->topo.initial_apicid >> bits;
-	/* Use package ID also for last level cache */
-	c->topo.llc_id =3D c->topo.die_id =3D c->topo.pkg_id;
-}
-
 static void srat_detect_node(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_NUMA
@@ -173,32 +91,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
=20
-static void early_init_hygon_mc(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned int bits, ecx;
-
-	/* Multi core CPU? */
-	if (c->extended_cpuid_level < 0x80000008)
-		return;
-
-	ecx =3D cpuid_ecx(0x80000008);
-
-	c->x86_max_cores =3D (ecx & 0xff) + 1;
-
-	/* CPU telling us the core id bits shift? */
-	bits =3D (ecx >> 12) & 0xF;
-
-	/* Otherwise recompute */
-	if (bits =3D=3D 0) {
-		while ((1 << bits) < c->x86_max_cores)
-			bits++;
-	}
-
-	c->x86_coreid_bits =3D bits;
-#endif
-}
-
 static void bsp_init_hygon(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
@@ -212,18 +104,6 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_MWAITX))
 		use_mwaitx_delay();
=20
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		u32 ecx;
-
-		ecx =3D cpuid_ecx(0x8000001e);
-		__max_die_per_package =3D nodes_per_socket =3D ((ecx >> 8) & 7) + 1;
-	} else if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
-		u64 value;
-
-		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		__max_die_per_package =3D nodes_per_socket =3D ((value >> 3) & 7) + 1;
-	}
-
 	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
 	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD)) {
 		/*
@@ -242,8 +122,6 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
 {
 	u32 dummy;
=20
-	early_init_hygon_mc(c);
-
 	set_cpu_cap(c, X86_FEATURE_K8);
=20
 	rdmsr_safe(MSR_AMD64_PATCH_LEVEL, &c->microcode, &dummy);
@@ -284,8 +162,6 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
 	 * we can set it unconditionally.
 	 */
 	set_cpu_cap(c, X86_FEATURE_VMMCALL);
-
-	hygon_get_topology_early(c);
 }
=20
 static void init_hygon(struct cpuinfo_x86 *c)
@@ -302,9 +178,6 @@ static void init_hygon(struct cpuinfo_x86 *c)
=20
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
=20
-	/* get apicid instead of initial apic id from cpuid */
-	c->topo.apicid =3D read_apic_id();
-
 	/*
 	 * XXX someone from Hygon needs to confirm this DTRT
 	 *
@@ -316,8 +189,6 @@ static void init_hygon(struct cpuinfo_x86 *c)
=20
 	cpu_detect_cache_sizes(c);
=20
-	hygon_detect_cmp(c);
-	hygon_get_topology(c);
 	srat_detect_node(c);
=20
 	init_hygon_cacheinfo(c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 40dec9b56f87..be30d7fa2e66 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -400,13 +400,6 @@ static void early_init_intel(struct cpuinfo_x86 *c)
=20
 	check_memory_type_self_snoop_errata(c);
=20
-	/*
-	 * Get the number of SMT siblings early from the extended topology
-	 * leaf, if available. Otherwise try the legacy SMT detection.
-	 */
-	if (detect_extended_topology_early(c) < 0)
-		detect_ht_early(c);
-
 	/*
 	 * Adjust the number of physical bits early because it affects the
 	 * valid bits of the MTRR mask registers.
@@ -610,24 +603,6 @@ static void init_intel(struct cpuinfo_x86 *c)
=20
 	intel_workarounds(c);
=20
-	/*
-	 * Detect the extended topology information if available. This
-	 * will reinitialise the initial_apicid which will be used
-	 * in init_intel_cacheinfo()
-	 */
-	detect_extended_topology(c);
-
-	if (!cpu_has(c, X86_FEATURE_XTOPOLOGY)) {
-		/*
-		 * let's use the legacy cpuid vector 0x1 and 0x4 for topology
-		 * detection.
-		 */
-		detect_num_cpu_cores(c);
-#ifdef CONFIG_X86_32
-		detect_ht(c);
-#endif
-	}
-
 	init_intel_cacheinfo(c);
=20
 	if (c->cpuid_level > 9) {
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 2b46eb0fdf3a..9a0133ef7e20 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1231,7 +1231,7 @@ static int threshold_create_bank(struct threshold_bank =
**bp, unsigned int cpu,
 		return -ENODEV;
=20
 	if (is_shared_bank(bank)) {
-		nb =3D node_to_amd_nb(topology_die_id(cpu));
+		nb =3D node_to_amd_nb(topology_amd_node_id(cpu));
=20
 		/* threshold descriptor already initialized on this node? */
 		if (nb && nb->bank4) {
@@ -1335,7 +1335,7 @@ static void threshold_remove_bank(struct threshold_bank=
 *bank)
 		 * The last CPU on this node using the shared bank is going
 		 * away, remove that bank now.
 		 */
-		nb =3D node_to_amd_nb(topology_die_id(smp_processor_id()));
+		nb =3D node_to_amd_nb(topology_amd_node_id(smp_processor_id()));
 		nb->bank4 =3D NULL;
 	}
=20
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/injec=
t.c
index 72f0695c3dc1..94953d749475 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -430,11 +430,9 @@ static void trigger_thr_int(void *info)
=20
 static u32 get_nbc_for_node(int node_id)
 {
-	struct cpuinfo_x86 *c =3D &boot_cpu_data;
 	u32 cores_per_node;
=20
-	cores_per_node =3D (c->x86_max_cores * smp_num_siblings) / amd_get_nodes_pe=
r_socket();
-
+	cores_per_node =3D topology_num_threads_per_package() / topology_amd_nodes_=
per_pkg();
 	return cores_per_node * node_id;
 }
=20
@@ -543,8 +541,8 @@ static void do_inject(void)
 	if (boot_cpu_has(X86_FEATURE_AMD_DCM) &&
 	    b =3D=3D 4 &&
 	    boot_cpu_data.x86 < 0x17) {
-		toggle_nb_mca_mst_cpu(topology_die_id(cpu));
-		cpu =3D get_nbc_for_node(topology_die_id(cpu));
+		toggle_nb_mca_mst_cpu(topology_amd_node_id(cpu));
+		cpu =3D get_nbc_for_node(topology_amd_node_id(cpu));
 	}
=20
 	cpus_read_lock();
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/micr=
ocode/intel.c
index 857e608af641..5f0414452b67 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -641,7 +641,7 @@ static __init void calc_llc_size_per_core(struct cpuinfo_=
x86 *c)
 {
 	u64 llc_size =3D c->x86_cache_size * 1024ULL;
=20
-	do_div(llc_size, c->x86_max_cores);
+	do_div(llc_size, topology_num_cores_per_package());
 	llc_size_per_core =3D (unsigned int)llc_size;
 }
=20
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index dc136703566f..3259b1d4fefe 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -1,167 +1,510 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- * Check for extended topology enumeration cpuid leaf 0xb and if it
- * exists, use it for populating initial_apicid and cpu topology
- * detection.
+ * CPU/APIC topology
+ *
+ * The APIC IDs describe the system topology in multiple domain levels.
+ * The CPUID topology parser provides the information which part of the
+ * APIC ID is associated to the individual levels:
+ *
+ * [PACKAGE][DIEGRP][DIE][TILE][MODULE][CORE][THREAD]
+ *
+ * The root space contains the package (socket) IDs.
+ *
+ * Not enumerated levels consume 0 bits space, but conceptually they are
+ * always represented. If e.g. only CORE and THREAD levels are enumerated
+ * then the DIE, MODULE and TILE have the same physical ID as the PACKAGE.
+ *
+ * If SMT is not supported, then the THREAD domain is still used. It then
+ * has the same physical ID as the CORE domain and is the only child of
+ * the core domain.
+ *
+ * This allows a unified view on the system independent of the enumerated
+ * domain levels without requiring any conditionals in the code.
  */
-
+#define pr_fmt(fmt) "CPU topo: " fmt
 #include <linux/cpu.h>
+
+#include <xen/xen.h>
+
 #include <asm/apic.h>
-#include <asm/memtype.h>
-#include <asm/processor.h>
+#include <asm/hypervisor.h>
+#include <asm/io_apic.h>
+#include <asm/mpspec.h>
+#include <asm/smp.h>
=20
 #include "cpu.h"
=20
-/* leaf 0xb SMT level */
-#define SMT_LEVEL	0
+/*
+ * Map cpu index to physical APIC ID
+ */
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, CPU_ACPIID_INVALID);
+EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
+EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
=20
-/* extended topology sub-leaf types */
-#define INVALID_TYPE	0
-#define SMT_TYPE	1
-#define CORE_TYPE	2
-#define DIE_TYPE	5
+/* Bitmap of physically present CPUs. */
+DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC) __read_mostly;
=20
-#define LEAFB_SUBTYPE(ecx)		(((ecx) >> 8) & 0xff)
-#define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
-#define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
+/* Used for CPU number allocation and parallel CPU bringup */
+u32 cpuid_to_apicid[] __ro_after_init =3D { [0 ... NR_CPUS - 1] =3D BAD_APIC=
ID, };
+
+/* Bitmaps to mark registered APICs at each topology domain */
+static struct { DECLARE_BITMAP(map, MAX_LOCAL_APIC); } apic_maps[TOPO_MAX_DO=
MAIN] __ro_after_init;
+
+/*
+ * Keep track of assigned, disabled and rejected CPUs. Present assigned
+ * with 1 as CPU #0 is reserved for the boot CPU.
+ */
+static struct {
+	unsigned int		nr_assigned_cpus;
+	unsigned int		nr_disabled_cpus;
+	unsigned int		nr_rejected_cpus;
+	u32			boot_cpu_apic_id;
+	u32			real_bsp_apic_id;
+} topo_info __ro_after_init =3D {
+	.nr_assigned_cpus	=3D 1,
+	.boot_cpu_apic_id	=3D BAD_APICID,
+	.real_bsp_apic_id	=3D BAD_APICID,
+};
=20
-unsigned int __max_die_per_package __read_mostly =3D 1;
-EXPORT_SYMBOL(__max_die_per_package);
+#define domain_weight(_dom)	bitmap_weight(apic_maps[_dom].map, MAX_LOCAL_API=
C)
+
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return phys_id =3D=3D (u64)cpuid_to_apicid[cpu];
+}
=20
 #ifdef CONFIG_SMP
+static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
+{
+	if (!(apicid & (__max_threads_per_core - 1)))
+		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
+}
+#else
+static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int ap=
icid) { }
+#endif
+
 /*
- * Check if given CPUID extended topology "leaf" is implemented
+ * Convert the APIC ID to a domain level ID by masking out the low bits
+ * below the domain level @dom.
  */
-static int check_extended_topology_leaf(int leaf)
+static inline u32 topo_apicid(u32 apicid, enum x86_topology_domains dom)
+{
+	if (dom =3D=3D TOPO_SMT_DOMAIN)
+		return apicid;
+	return apicid & (UINT_MAX << x86_topo_system.dom_shifts[dom - 1]);
+}
+
+static int topo_lookup_cpuid(u32 apic_id)
 {
-	unsigned int eax, ebx, ecx, edx;
+	int i;
=20
-	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
+	/* CPU# to APICID mapping is persistent once it is established */
+	for (i =3D 0; i < topo_info.nr_assigned_cpus; i++) {
+		if (cpuid_to_apicid[i] =3D=3D apic_id)
+			return i;
+	}
+	return -ENODEV;
+}
=20
-	if (ebx =3D=3D 0 || (LEAFB_SUBTYPE(ecx) !=3D SMT_TYPE))
-		return -1;
+static __init int topo_get_cpunr(u32 apic_id)
+{
+	int cpu =3D topo_lookup_cpuid(apic_id);
=20
-	return 0;
+	if (cpu >=3D 0)
+		return cpu;
+
+	return topo_info.nr_assigned_cpus++;
 }
-/*
- * Return best CPUID Extended Topology Leaf supported
+
+static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
+	early_per_cpu(x86_cpu_to_apicid, cpu) =3D apic_id;
+	early_per_cpu(x86_cpu_to_acpiid, cpu) =3D acpi_id;
+#endif
+	set_cpu_possible(cpu, true);
+	set_cpu_present(cpu, true);
+}
+
+static __init bool check_for_real_bsp(u32 apic_id)
+{
+	/*
+	 * There is no real good way to detect whether this a kdump()
+	 * kernel, but except on the Voyager SMP monstrosity which is not
+	 * longer supported, the real BSP APIC ID is the first one which is
+	 * enumerated by firmware. That allows to detect whether the boot
+	 * CPU is the real BSP. If it is not, then do not register the APIC
+	 * because sending INIT to the real BSP would reset the whole
+	 * system.
+	 *
+	 * The first APIC ID which is enumerated by firmware is detectable
+	 * because the boot CPU APIC ID is registered before that without
+	 * invoking this code.
+	 */
+	if (topo_info.real_bsp_apic_id !=3D BAD_APICID)
+		return false;
+
+	if (apic_id =3D=3D topo_info.boot_cpu_apic_id) {
+		topo_info.real_bsp_apic_id =3D apic_id;
+		return false;
+	}
+
+	pr_warn("Boot CPU APIC ID not the first enumerated APIC ID: %x > %x\n",
+		topo_info.boot_cpu_apic_id, apic_id);
+	pr_warn("Crash kernel detected. Disabling real BSP to prevent machine INIT\=
n");
+
+	topo_info.real_bsp_apic_id =3D apic_id;
+	return true;
+}
+
+static unsigned int topo_unit_count(u32 lvlid, enum x86_topology_domains at_=
level,
+				    unsigned long *map)
+{
+	unsigned int id, end, cnt =3D 0;
+
+	/* Calculate the exclusive end */
+	end =3D lvlid + (1U << x86_topo_system.dom_shifts[at_level]);
+
+	/* Unfortunately there is no bitmap_weight_range() */
+	for (id =3D find_next_bit(map, end, lvlid); id < end; id =3D find_next_bit(=
map, end, ++id))
+		cnt++;
+	return cnt;
+}
+
+static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
+{
+	int cpu, dom;
+
+	if (present) {
+		set_bit(apic_id, phys_cpu_present_map);
+
+		/*
+		 * Double registration is valid in case of the boot CPU
+		 * APIC because that is registered before the enumeration
+		 * of the APICs via firmware parsers or VM guest
+		 * mechanisms.
+		 */
+		if (apic_id =3D=3D topo_info.boot_cpu_apic_id)
+			cpu =3D 0;
+		else
+			cpu =3D topo_get_cpunr(apic_id);
+
+		cpuid_to_apicid[cpu] =3D apic_id;
+		topo_set_cpuids(cpu, apic_id, acpi_id);
+	} else {
+		u32 pkgid =3D topo_apicid(apic_id, TOPO_PKG_DOMAIN);
+
+		/*
+		 * Check for present APICs in the same package when running
+		 * on bare metal. Allow the bogosity in a guest.
+		 */
+		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
+		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
+			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
+				     apic_id);
+			topo_info.nr_rejected_cpus++;
+			return;
+		}
+
+		topo_info.nr_disabled_cpus++;
+	}
+
+	/* Register present and possible CPUs in the domain maps */
+	for (dom =3D TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++)
+		set_bit(topo_apicid(apic_id, dom), apic_maps[dom].map);
+}
+
+/**
+ * topology_register_apic - Register an APIC in early topology maps
+ * @apic_id:	The APIC ID to set up
+ * @acpi_id:	The ACPI ID associated to the APIC
+ * @present:	True if the corresponding CPU is present
  */
-static int detect_extended_topology_leaf(struct cpuinfo_x86 *c)
+void __init topology_register_apic(u32 apic_id, u32 acpi_id, bool present)
 {
-	if (c->cpuid_level >=3D 0x1f) {
-		if (check_extended_topology_leaf(0x1f) =3D=3D 0)
-			return 0x1f;
+	if (apic_id >=3D MAX_LOCAL_APIC) {
+		pr_err_once("APIC ID %x exceeds kernel limit of: %x\n", apic_id, MAX_LOCAL=
_APIC - 1);
+		topo_info.nr_rejected_cpus++;
+		return;
+	}
+
+	if (check_for_real_bsp(apic_id)) {
+		topo_info.nr_rejected_cpus++;
+		return;
 	}
=20
-	if (c->cpuid_level >=3D 0xb) {
-		if (check_extended_topology_leaf(0xb) =3D=3D 0)
-			return 0xb;
+	/* CPU numbers exhausted? */
+	if (apic_id !=3D topo_info.boot_cpu_apic_id && topo_info.nr_assigned_cpus >=
=3D nr_cpu_ids) {
+		pr_warn_once("CPU limit of %d reached. Ignoring further CPUs\n", nr_cpu_id=
s);
+		topo_info.nr_rejected_cpus++;
+		return;
 	}
=20
-	return -1;
+	topo_register_apic(apic_id, acpi_id, present);
+}
+
+/**
+ * topology_register_boot_apic - Register the boot CPU APIC
+ * @apic_id:	The APIC ID to set up
+ *
+ * Separate so CPU #0 can be assigned
+ */
+void __init topology_register_boot_apic(u32 apic_id)
+{
+	WARN_ON_ONCE(topo_info.boot_cpu_apic_id !=3D BAD_APICID);
+
+	topo_info.boot_cpu_apic_id =3D apic_id;
+	topo_register_apic(apic_id, CPU_ACPIID_INVALID, true);
+}
+
+/**
+ * topology_get_logical_id - Retrieve the logical ID at a given topology dom=
ain level
+ * @apicid:		The APIC ID for which to lookup the logical ID
+ * @at_level:		The topology domain level to use
+ *
+ * @apicid must be a full APIC ID, not the normalized variant. It's valid to=
 have
+ * all bits below the domain level specified by @at_level to be clear. So bo=
th
+ * real APIC IDs and backshifted normalized APIC IDs work correctly.
+ *
+ * Returns:
+ *  - >=3D 0:	The requested logical ID
+ *  - -ERANGE:	@apicid is out of range
+ *  - -ENODEV:	@apicid is not registered
+ */
+int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
+{
+	/* Remove the bits below @at_level to get the proper level ID of @apicid */
+	unsigned int lvlid =3D topo_apicid(apicid, at_level);
+
+	if (lvlid >=3D MAX_LOCAL_APIC)
+		return -ERANGE;
+	if (!test_bit(lvlid, apic_maps[at_level].map))
+		return -ENODEV;
+	/* Get the number of set bits before @lvlid. */
+	return bitmap_weight(apic_maps[at_level].map, lvlid);
+}
+EXPORT_SYMBOL_GPL(topology_get_logical_id);
+
+/**
+ * topology_unit_count - Retrieve the count of specified units at a given to=
pology domain level
+ * @apicid:		The APIC ID which specifies the search range
+ * @which_units:	The domain level specifying the units to count
+ * @at_level:		The domain level at which @which_units have to be counted
+ *
+ * This returns the number of possible units according to the enumerated
+ * information.
+ *
+ * E.g. topology_count_units(apicid, TOPO_CORE_DOMAIN, TOPO_PKG_DOMAIN)
+ * counts the number of possible cores in the package to which @apicid
+ * belongs.
+ *
+ * @at_level must obviously be greater than @which_level to produce useful
+ * results.  If @at_level is equal to @which_units the result is
+ * unsurprisingly 1. If @at_level is less than @which_units the results
+ * is by definition undefined and the function returns 0.
+ */
+unsigned int topology_unit_count(u32 apicid, enum x86_topology_domains which=
_units,
+				 enum x86_topology_domains at_level)
+{
+	/* Remove the bits below @at_level to get the proper level ID of @apicid */
+	unsigned int lvlid =3D topo_apicid(apicid, at_level);
+
+	if (lvlid >=3D MAX_LOCAL_APIC)
+		return 0;
+	if (!test_bit(lvlid, apic_maps[at_level].map))
+		return 0;
+	if (which_units > at_level)
+		return 0;
+	if (which_units =3D=3D at_level)
+		return 1;
+	return topo_unit_count(lvlid, at_level, apic_maps[which_units].map);
+}
+
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+/**
+ * topology_hotplug_apic - Handle a physical hotplugged APIC after boot
+ * @apic_id:	The APIC ID to set up
+ * @acpi_id:	The ACPI ID associated to the APIC
+ */
+int topology_hotplug_apic(u32 apic_id, u32 acpi_id)
+{
+	int cpu;
+
+	if (apic_id >=3D MAX_LOCAL_APIC)
+		return -EINVAL;
+
+	/* Reject if the APIC ID was not registered during enumeration. */
+	if (!test_bit(apic_id, apic_maps[TOPO_SMT_DOMAIN].map))
+		return -ENODEV;
+
+	cpu =3D topo_lookup_cpuid(apic_id);
+	if (cpu < 0)
+		return -ENOSPC;
+
+	set_bit(apic_id, phys_cpu_present_map);
+	topo_set_cpuids(cpu, apic_id, acpi_id);
+	cpu_mark_primary_thread(cpu, apic_id);
+	return cpu;
+}
+
+/**
+ * topology_hotunplug_apic - Remove a physical hotplugged APIC after boot
+ * @cpu:	The CPU number for which the APIC ID is removed
+ */
+void topology_hotunplug_apic(unsigned int cpu)
+{
+	u32 apic_id =3D cpuid_to_apicid[cpu];
+
+	if (apic_id =3D=3D BAD_APICID)
+		return;
+
+	per_cpu(x86_cpu_to_apicid, cpu) =3D BAD_APICID;
+	clear_bit(apic_id, phys_cpu_present_map);
+	set_cpu_present(cpu, false);
 }
 #endif
=20
-int detect_extended_topology_early(struct cpuinfo_x86 *c)
+#ifdef CONFIG_X86_LOCAL_APIC
+static unsigned int max_possible_cpus __initdata =3D NR_CPUS;
+
+/**
+ * topology_apply_cmdline_limits_early - Apply topology command line limits =
early
+ *
+ * Ensure that command line limits are in effect before firmware parsing
+ * takes place.
+ */
+void __init topology_apply_cmdline_limits_early(void)
 {
-#ifdef CONFIG_SMP
-	unsigned int eax, ebx, ecx, edx;
-	int leaf;
+	unsigned int possible =3D nr_cpu_ids;
=20
-	leaf =3D detect_extended_topology_leaf(c);
-	if (leaf < 0)
-		return -1;
+	/* 'maxcpus=3D0' 'nosmp' 'nolapic' 'disableapic' 'noapic' */
+	if (!setup_max_cpus || ioapic_is_disabled || apic_is_disabled)
+		possible =3D 1;
=20
-	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
+	/* 'possible_cpus=3DN' */
+	possible =3D min_t(unsigned int, max_possible_cpus, possible);
+
+	if (possible < nr_cpu_ids) {
+		pr_info("Limiting to %u possible CPUs\n", possible);
+		set_nr_cpu_ids(possible);
+	}
+}
=20
-	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
+static __init bool restrict_to_up(void)
+{
+	if (!smp_found_config || ioapic_is_disabled)
+		return true;
 	/*
-	 * initial apic id, which also represents 32-bit extended x2apic id.
+	 * XEN PV is special as it does not advertise the local APIC
+	 * properly, but provides a fake topology for it so that the
+	 * infrastructure works. So don't apply the restrictions vs. APIC
+	 * here.
 	 */
-	c->topo.initial_apicid =3D edx;
-	smp_num_siblings =3D max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
-#endif
-	return 0;
+	if (xen_pv_domain())
+		return false;
+
+	return apic_is_disabled;
 }
=20
-/*
- * Check for extended topology enumeration cpuid leaf, and if it
- * exists, use it for populating initial_apicid and cpu topology
- * detection.
- */
-int detect_extended_topology(struct cpuinfo_x86 *c)
+void __init topology_init_possible_cpus(void)
 {
-#ifdef CONFIG_SMP
-	unsigned int eax, ebx, ecx, edx, sub_index;
-	unsigned int ht_mask_width, core_plus_mask_width, die_plus_mask_width;
-	unsigned int core_select_mask, core_level_siblings;
-	unsigned int die_select_mask, die_level_siblings;
-	unsigned int pkg_mask_width;
-	bool die_level_present =3D false;
-	int leaf;
-
-	leaf =3D detect_extended_topology_leaf(c);
-	if (leaf < 0)
-		return -1;
+	unsigned int assigned =3D topo_info.nr_assigned_cpus;
+	unsigned int disabled =3D topo_info.nr_disabled_cpus;
+	unsigned int cnta, cntb, cpu, allowed =3D 1;
+	unsigned int total =3D assigned + disabled;
+	u32 apicid, firstid;
+
+	if (!restrict_to_up()) {
+		if (WARN_ON_ONCE(assigned > nr_cpu_ids)) {
+			disabled +=3D assigned - nr_cpu_ids;
+			assigned =3D nr_cpu_ids;
+		}
+		allowed =3D min_t(unsigned int, total, nr_cpu_ids);
+	}
+
+	if (total > allowed)
+		pr_warn("%u possible CPUs exceed the limit of %u\n", total, allowed);
+
+	assigned =3D min_t(unsigned int, allowed, assigned);
+	disabled =3D allowed - assigned;
=20
+	topo_info.nr_assigned_cpus =3D assigned;
+	topo_info.nr_disabled_cpus =3D disabled;
+
+	total_cpus =3D allowed;
+	set_nr_cpu_ids(allowed);
+
+	cnta =3D domain_weight(TOPO_PKG_DOMAIN);
+	cntb =3D domain_weight(TOPO_DIE_DOMAIN);
+	__max_logical_packages =3D cnta;
+	__max_dies_per_package =3D 1U << (get_count_order(cntb) - get_count_order(c=
nta));
+
+	pr_info("Max. logical packages: %3u\n", cnta);
+	pr_info("Max. logical dies:     %3u\n", cntb);
+	pr_info("Max. dies per package: %3u\n", __max_dies_per_package);
+
+	cnta =3D domain_weight(TOPO_CORE_DOMAIN);
+	cntb =3D domain_weight(TOPO_SMT_DOMAIN);
 	/*
-	 * Populate HT related information from sub-leaf level 0.
+	 * Can't use order delta here as order(cnta) can be equal
+	 * order(cntb) even if cnta !=3D cntb.
 	 */
-	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	c->topo.initial_apicid =3D edx;
-	core_level_siblings =3D LEVEL_MAX_SIBLINGS(ebx);
-	smp_num_siblings =3D max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
-	core_plus_mask_width =3D ht_mask_width =3D BITS_SHIFT_NEXT_LEVEL(eax);
-	die_level_siblings =3D LEVEL_MAX_SIBLINGS(ebx);
-	pkg_mask_width =3D die_plus_mask_width =3D BITS_SHIFT_NEXT_LEVEL(eax);
-
-	sub_index =3D 1;
-	while (true) {
-		cpuid_count(leaf, sub_index, &eax, &ebx, &ecx, &edx);
+	__max_threads_per_core =3D DIV_ROUND_UP(cntb, cnta);
+	pr_info("Max. threads per core: %3u\n", __max_threads_per_core);
=20
-		/*
-		 * Check for the Core type in the implemented sub leaves.
-		 */
-		if (LEAFB_SUBTYPE(ecx) =3D=3D CORE_TYPE) {
-			core_level_siblings =3D LEVEL_MAX_SIBLINGS(ebx);
-			core_plus_mask_width =3D BITS_SHIFT_NEXT_LEVEL(eax);
-			die_level_siblings =3D core_level_siblings;
-			die_plus_mask_width =3D BITS_SHIFT_NEXT_LEVEL(eax);
-		}
-		if (LEAFB_SUBTYPE(ecx) =3D=3D DIE_TYPE) {
-			die_level_present =3D true;
-			die_level_siblings =3D LEVEL_MAX_SIBLINGS(ebx);
-			die_plus_mask_width =3D BITS_SHIFT_NEXT_LEVEL(eax);
-		}
+	firstid =3D find_first_bit(apic_maps[TOPO_SMT_DOMAIN].map, MAX_LOCAL_APIC);
+	__num_cores_per_package =3D topology_unit_count(firstid, TOPO_CORE_DOMAIN, =
TOPO_PKG_DOMAIN);
+	pr_info("Num. cores per package:   %3u\n", __num_cores_per_package);
+	__num_threads_per_package =3D topology_unit_count(firstid, TOPO_SMT_DOMAIN,=
 TOPO_PKG_DOMAIN);
+	pr_info("Num. threads per package: %3u\n", __num_threads_per_package);
=20
-		if (LEAFB_SUBTYPE(ecx) !=3D INVALID_TYPE)
-			pkg_mask_width =3D BITS_SHIFT_NEXT_LEVEL(eax);
-		else
-			break;
+	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabl=
ed);
+	if (topo_info.nr_rejected_cpus)
+		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
=20
-		sub_index++;
+	init_cpu_present(cpumask_of(0));
+	init_cpu_possible(cpumask_of(0));
+
+	/* Assign CPU numbers to non-present CPUs */
+	for (apicid =3D 0; disabled; disabled--, apicid++) {
+		apicid =3D find_next_andnot_bit(apic_maps[TOPO_SMT_DOMAIN].map, phys_cpu_p=
resent_map,
+					      MAX_LOCAL_APIC, apicid);
+		if (apicid >=3D MAX_LOCAL_APIC)
+			break;
+		cpuid_to_apicid[topo_info.nr_assigned_cpus++] =3D apicid;
 	}
=20
-	core_select_mask =3D (~(-1 << pkg_mask_width)) >> ht_mask_width;
-	die_select_mask =3D (~(-1 << die_plus_mask_width)) >>
-				core_plus_mask_width;
+	for (cpu =3D 0; cpu < allowed; cpu++) {
+		apicid =3D cpuid_to_apicid[cpu];
=20
-	c->topo.core_id =3D apic->phys_pkg_id(c->topo.initial_apicid,
-				ht_mask_width) & core_select_mask;
+		set_cpu_possible(cpu, true);
=20
-	if (die_level_present) {
-		c->topo.die_id =3D apic->phys_pkg_id(c->topo.initial_apicid,
-					core_plus_mask_width) & die_select_mask;
+		if (apicid =3D=3D BAD_APICID)
+			continue;
+
+		cpu_mark_primary_thread(cpu, apicid);
+		set_cpu_present(cpu, test_bit(apicid, phys_cpu_present_map));
 	}
+}
=20
-	c->topo.pkg_id =3D apic->phys_pkg_id(c->topo.initial_apicid, pkg_mask_width=
);
-	/*
-	 * Reinit the apicid, now that we have extended initial_apicid.
-	 */
-	c->topo.apicid =3D apic->phys_pkg_id(c->topo.initial_apicid, 0);
+/*
+ * Late SMP disable after sizing CPU masks when APIC/IOAPIC setup failed.
+ */
+void __init topology_reset_possible_cpus_up(void)
+{
+	init_cpu_present(cpumask_of(0));
+	init_cpu_possible(cpumask_of(0));
=20
-	c->x86_max_cores =3D (core_level_siblings / smp_num_siblings);
-	__max_die_per_package =3D (die_level_siblings / core_level_siblings);
-#endif
+	bitmap_zero(phys_cpu_present_map, MAX_LOCAL_APIC);
+	if (topo_info.boot_cpu_apic_id !=3D BAD_APICID)
+		set_bit(topo_info.boot_cpu_apic_id, phys_cpu_present_map);
+}
+
+static int __init setup_possible_cpus(char *str)
+{
+	get_option(&str, &max_possible_cpus);
 	return 0;
 }
+early_param("possible_cpus", setup_possible_cpus);
+#endif
diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topology.h
new file mode 100644
index 000000000000..37326297f80c
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_X86_TOPOLOGY_H
+#define ARCH_X86_TOPOLOGY_H
+
+struct topo_scan {
+	struct cpuinfo_x86	*c;
+	unsigned int		dom_shifts[TOPO_MAX_DOMAIN];
+	unsigned int		dom_ncpus[TOPO_MAX_DOMAIN];
+
+	/* Legacy CPUID[1]:EBX[23:16] number of logical processors */
+	unsigned int		ebx1_nproc_shift;
+
+	/* AMD specific node ID which cannot be mapped into APIC space. */
+	u16			amd_nodes_per_pkg;
+	u16			amd_node_id;
+};
+
+void cpu_init_topology(struct cpuinfo_x86 *c);
+void cpu_parse_topology(struct cpuinfo_x86 *c);
+void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
+		      unsigned int shift, unsigned int ncpus);
+bool cpu_parse_topology_ext(struct topo_scan *tscan);
+void cpu_parse_topology_amd(struct topo_scan *tscan);
+void cpu_topology_fixup_amd(struct topo_scan *tscan);
+
+static inline u32 topo_shift_apicid(u32 apicid, enum x86_topology_domains do=
m)
+{
+	if (dom =3D=3D TOPO_SMT_DOMAIN)
+		return apicid;
+	return apicid >> x86_topo_system.dom_shifts[dom - 1];
+}
+
+static inline u32 topo_relative_domain_id(u32 apicid, enum x86_topology_doma=
ins dom)
+{
+	if (dom !=3D TOPO_SMT_DOMAIN)
+		apicid >>=3D x86_topo_system.dom_shifts[dom - 1];
+	return apicid & (x86_topo_system.dom_size[dom] - 1);
+}
+
+static inline u32 topo_domain_mask(enum x86_topology_domains dom)
+{
+	return (1U << x86_topo_system.dom_shifts[dom]) - 1;
+}
+
+/*
+ * Update a domain level after the fact without propagating. Used to fixup
+ * broken CPUID enumerations.
+ */
+static inline void topology_update_dom(struct topo_scan *tscan, enum x86_top=
ology_domains dom,
+				       unsigned int shift, unsigned int ncpus)
+{
+	tscan->dom_shifts[dom] =3D shift;
+	tscan->dom_ncpus[dom] =3D ncpus;
+}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+unsigned int topology_unit_count(u32 apicid, enum x86_topology_domains which=
_units,
+				 enum x86_topology_domains at_level);
+#else
+static inline unsigned int topology_unit_count(u32 apicid, enum x86_topology=
_domains which_units,
+					       enum x86_topology_domains at_level)
+{
+	return 1;
+}
+#endif
+
+#endif /* ARCH_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topolog=
y_amd.c
new file mode 100644
index 000000000000..1a8b3ad493af
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpu.h>
+
+#include <asm/apic.h>
+#include <asm/memtype.h>
+#include <asm/processor.h>
+
+#include "cpu.h"
+
+static bool parse_8000_0008(struct topo_scan *tscan)
+{
+	struct {
+		// ecx
+		u32	cpu_nthreads		:  8, // Number of physical threads - 1
+						:  4, // Reserved
+			apicid_coreid_len	:  4, // Number of thread core ID bits (shift) in APIC =
ID
+			perf_tsc_len		:  2, // Performance time-stamp counter size
+						: 14; // Reserved
+	} ecx;
+	unsigned int sft;
+
+	if (tscan->c->extended_cpuid_level < 0x80000008)
+		return false;
+
+	cpuid_leaf_reg(0x80000008, CPUID_ECX, &ecx);
+
+	/* If the thread bits are 0, then get the shift value from ecx.cpu_nthreads=
 */
+	sft =3D ecx.apicid_coreid_len;
+	if (!sft)
+		sft =3D get_count_order(ecx.cpu_nthreads + 1);
+
+	topology_set_dom(tscan, TOPO_SMT_DOMAIN, sft, ecx.cpu_nthreads + 1);
+	return true;
+}
+
+static void store_node(struct topo_scan *tscan, unsigned int nr_nodes, u16 n=
ode_id)
+{
+	/*
+	 * Starting with Fam 17h the DIE domain could probably be used to
+	 * retrieve the node info on AMD/HYGON. Analysis of CPUID dumps
+	 * suggests it's the topmost bit(s) of the CPU cores area, but
+	 * that's guess work and neither enumerated nor documented.
+	 *
+	 * Up to Fam 16h this does not work at all and the legacy node ID
+	 * has to be used.
+	 */
+	tscan->amd_nodes_per_pkg =3D nr_nodes;
+	tscan->amd_node_id =3D node_id;
+}
+
+static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
+{
+	struct {
+		// eax
+		u32	ext_apic_id		: 32; // Extended APIC ID
+		// ebx
+		u32	core_id			:  8, // Unique per-socket logical core unit ID
+			core_nthreads		:  8, // #Threads per core (zero-based)
+						: 16; // Reserved
+		// ecx
+		u32	node_id			:  8, // Node (die) ID of invoking logical CPU
+			nnodes_per_socket	:  3, // #nodes in invoking logical CPU's package/socket
+						: 21; // Reserved
+		// edx
+		u32				: 32; // Reserved
+	} leaf;
+
+	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
+		return false;
+
+	cpuid_leaf(0x8000001e, &leaf);
+
+	tscan->c->topo.initial_apicid =3D leaf.ext_apic_id;
+
+	/*
+	 * If leaf 0xb is available, then SMT shift is set already. If not
+	 * take it from ecx.threads_per_core and use topo_update_dom() -
+	 * topology_set_dom() would propagate and overwrite the already
+	 * propagated CORE level.
+	 */
+	if (!has_0xb) {
+		unsigned int nthreads =3D leaf.core_nthreads + 1;
+
+		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nth=
reads);
+	}
+
+	store_node(tscan, leaf.nnodes_per_socket + 1, leaf.node_id);
+
+	if (tscan->c->x86_vendor =3D=3D X86_VENDOR_AMD) {
+		if (tscan->c->x86 =3D=3D 0x15)
+			tscan->c->topo.cu_id =3D leaf.core_id;
+
+		cacheinfo_amd_init_llc_id(tscan->c, leaf.node_id);
+	} else {
+		/*
+		 * Package ID is ApicId[6..] on certain Hygon CPUs. See
+		 * commit e0ceeae708ce for explanation. The topology info
+		 * is screwed up: The package shift is always 6 and the
+		 * node ID is bit [4:5].
+		 */
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && tscan->c->x86_model <=3D 0x3)=
 {
+			topology_set_dom(tscan, TOPO_CORE_DOMAIN, 6,
+					 tscan->dom_ncpus[TOPO_CORE_DOMAIN]);
+		}
+		cacheinfo_hygon_init_llc_id(tscan->c);
+	}
+	return true;
+}
+
+static bool parse_fam10h_node_id(struct topo_scan *tscan)
+{
+	struct {
+		union {
+			u64	node_id		:  3,
+				nodes_per_pkg	:  3,
+				unused		: 58;
+			u64	msr;
+		};
+	} nid;
+
+	if (!boot_cpu_has(X86_FEATURE_NODEID_MSR))
+		return false;
+
+	rdmsrl(MSR_FAM10H_NODE_ID, nid.msr);
+	store_node(tscan, nid.nodes_per_pkg + 1, nid.node_id);
+	tscan->c->topo.llc_id =3D nid.node_id;
+	return true;
+}
+
+static void legacy_set_llc(struct topo_scan *tscan)
+{
+	unsigned int apicid =3D tscan->c->topo.initial_apicid;
+
+	/* parse_8000_0008() set everything up except llc_id */
+	tscan->c->topo.llc_id =3D apicid >> tscan->dom_shifts[TOPO_CORE_DOMAIN];
+}
+
+static void parse_topology_amd(struct topo_scan *tscan)
+{
+	bool has_0xb =3D false;
+
+	/*
+	 * If the extended topology leaf 0x8000_001e is available
+	 * try to get SMT and CORE shift from leaf 0xb first, then
+	 * try to get the CORE shift from leaf 0x8000_0008.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
+		has_0xb =3D cpu_parse_topology_ext(tscan);
+
+	if (!has_0xb && !parse_8000_0008(tscan))
+		return;
+
+	/* Prefer leaf 0x8000001e if available */
+	if (parse_8000_001e(tscan, has_0xb))
+		return;
+
+	/* Try the NODEID MSR */
+	if (parse_fam10h_node_id(tscan))
+		return;
+
+	legacy_set_llc(tscan);
+}
+
+void cpu_parse_topology_amd(struct topo_scan *tscan)
+{
+	tscan->amd_nodes_per_pkg =3D 1;
+	parse_topology_amd(tscan);
+
+	if (tscan->amd_nodes_per_pkg > 1)
+		set_cpu_cap(tscan->c, X86_FEATURE_AMD_DCM);
+}
+
+void cpu_topology_fixup_amd(struct topo_scan *tscan)
+{
+	struct cpuinfo_x86 *c =3D tscan->c;
+
+	/*
+	 * Adjust the core_id relative to the node when there is more than
+	 * one node.
+	 */
+	if (tscan->c->x86 < 0x17 && tscan->amd_nodes_per_pkg > 1)
+		c->topo.core_id %=3D tscan->dom_ncpus[TOPO_CORE_DOMAIN] / tscan->amd_nodes=
_per_pkg;
+}
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topo=
logy_common.c
new file mode 100644
index 000000000000..a50ae8d63d1c
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpu.h>
+
+#include <xen/xen.h>
+
+#include <asm/apic.h>
+#include <asm/processor.h>
+#include <asm/smp.h>
+
+#include "cpu.h"
+
+struct x86_topology_system x86_topo_system __ro_after_init;
+EXPORT_SYMBOL_GPL(x86_topo_system);
+
+unsigned int __amd_nodes_per_pkg __ro_after_init;
+EXPORT_SYMBOL_GPL(__amd_nodes_per_pkg);
+
+void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
+		      unsigned int shift, unsigned int ncpus)
+{
+	topology_update_dom(tscan, dom, shift, ncpus);
+
+	/* Propagate to the upper levels */
+	for (dom++; dom < TOPO_MAX_DOMAIN; dom++) {
+		tscan->dom_shifts[dom] =3D tscan->dom_shifts[dom - 1];
+		tscan->dom_ncpus[dom] =3D tscan->dom_ncpus[dom - 1];
+	}
+}
+
+static unsigned int __maybe_unused parse_num_cores_legacy(struct cpuinfo_x86=
 *c)
+{
+	struct {
+		u32	cache_type	:  5,
+			unused		: 21,
+			ncores		:  6;
+	} eax;
+
+	if (c->cpuid_level < 4)
+		return 1;
+
+	cpuid_subleaf_reg(4, 0, CPUID_EAX, &eax);
+	if (!eax.cache_type)
+		return 1;
+
+	return eax.ncores + 1;
+}
+
+static void parse_legacy(struct topo_scan *tscan)
+{
+	unsigned int cores, core_shift, smt_shift =3D 0;
+	struct cpuinfo_x86 *c =3D tscan->c;
+
+	cores =3D parse_num_cores_legacy(c);
+	core_shift =3D get_count_order(cores);
+
+	if (cpu_has(c, X86_FEATURE_HT)) {
+		if (!WARN_ON_ONCE(tscan->ebx1_nproc_shift < core_shift))
+			smt_shift =3D tscan->ebx1_nproc_shift - core_shift;
+		/*
+		 * The parser expects leaf 0xb/0x1f format, which means
+		 * the number of logical processors at core level is
+		 * counting threads.
+		 */
+		core_shift +=3D smt_shift;
+		cores <<=3D smt_shift;
+	}
+
+	topology_set_dom(tscan, TOPO_SMT_DOMAIN, smt_shift, 1U << smt_shift);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, core_shift, cores);
+}
+
+static bool fake_topology(struct topo_scan *tscan)
+{
+	/*
+	 * Preset the CORE level shift for CPUID less systems and XEN_PV,
+	 * which has useless CPUID information.
+	 */
+	topology_set_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 0, 1);
+
+	return tscan->c->cpuid_level < 1;
+}
+
+static void parse_topology(struct topo_scan *tscan, bool early)
+{
+	const struct cpuinfo_topology topo_defaults =3D {
+		.cu_id			=3D 0xff,
+		.llc_id			=3D BAD_APICID,
+		.l2c_id			=3D BAD_APICID,
+	};
+	struct cpuinfo_x86 *c =3D tscan->c;
+	struct {
+		u32	unused0		: 16,
+			nproc		:  8,
+			apicid		:  8;
+	} ebx;
+
+	c->topo =3D topo_defaults;
+
+	if (fake_topology(tscan))
+		return;
+
+	/* Preset Initial APIC ID from CPUID leaf 1 */
+	cpuid_leaf_reg(1, CPUID_EBX, &ebx);
+	c->topo.initial_apicid =3D ebx.apicid;
+
+	/*
+	 * The initial invocation from early_identify_cpu() happens before
+	 * the APIC is mapped or X2APIC enabled. For establishing the
+	 * topology, that's not required. Use the initial APIC ID.
+	 */
+	if (early)
+		c->topo.apicid =3D c->topo.initial_apicid;
+	else
+		c->topo.apicid =3D read_apic_id();
+
+	/* The above is sufficient for UP */
+	if (!IS_ENABLED(CONFIG_SMP))
+		return;
+
+	tscan->ebx1_nproc_shift =3D get_count_order(ebx.nproc);
+
+	switch (c->x86_vendor) {
+	case X86_VENDOR_AMD:
+		if (IS_ENABLED(CONFIG_CPU_SUP_AMD))
+			cpu_parse_topology_amd(tscan);
+		break;
+	case X86_VENDOR_CENTAUR:
+	case X86_VENDOR_ZHAOXIN:
+		parse_legacy(tscan);
+		break;
+	case X86_VENDOR_INTEL:
+		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
+			parse_legacy(tscan);
+		break;
+	case X86_VENDOR_HYGON:
+		if (IS_ENABLED(CONFIG_CPU_SUP_HYGON))
+			cpu_parse_topology_amd(tscan);
+		break;
+	}
+}
+
+static void topo_set_ids(struct topo_scan *tscan)
+{
+	struct cpuinfo_x86 *c =3D tscan->c;
+	u32 apicid =3D c->topo.apicid;
+
+	c->topo.pkg_id =3D topo_shift_apicid(apicid, TOPO_PKG_DOMAIN);
+	c->topo.die_id =3D topo_shift_apicid(apicid, TOPO_DIE_DOMAIN);
+
+	c->topo.logical_pkg_id =3D topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
+	c->topo.logical_die_id =3D topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+
+	/* Package relative core ID */
+	c->topo.core_id =3D (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
+		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
+
+	c->topo.amd_node_id =3D tscan->amd_node_id;
+
+	if (c->x86_vendor =3D=3D X86_VENDOR_AMD)
+		cpu_topology_fixup_amd(tscan);
+}
+
+void cpu_parse_topology(struct cpuinfo_x86 *c)
+{
+	unsigned int dom, cpu =3D smp_processor_id();
+	struct topo_scan tscan =3D { .c =3D c, };
+
+	parse_topology(&tscan, false);
+
+	if (IS_ENABLED(CONFIG_X86_LOCAL_APIC)) {
+		if (c->topo.initial_apicid !=3D c->topo.apicid) {
+			pr_err(FW_BUG "CPU%4u: APIC ID mismatch. CPUID: 0x%04x APIC: 0x%04x\n",
+			       cpu, c->topo.initial_apicid, c->topo.apicid);
+		}
+
+		if (c->topo.apicid !=3D cpuid_to_apicid[cpu]) {
+			pr_err(FW_BUG "CPU%4u: APIC ID mismatch. Firmware: 0x%04x APIC: 0x%04x\n",
+			       cpu, cpuid_to_apicid[cpu], c->topo.apicid);
+		}
+	}
+
+	for (dom =3D TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++) {
+		if (tscan.dom_shifts[dom] =3D=3D x86_topo_system.dom_shifts[dom])
+			continue;
+		pr_err(FW_BUG "CPU%d: Topology domain %u shift %u !=3D %u\n", cpu, dom,
+		       tscan.dom_shifts[dom], x86_topo_system.dom_shifts[dom]);
+	}
+
+	topo_set_ids(&tscan);
+}
+
+void __init cpu_init_topology(struct cpuinfo_x86 *c)
+{
+	struct topo_scan tscan =3D { .c =3D c, };
+	unsigned int dom, sft;
+
+	parse_topology(&tscan, true);
+
+	/* Copy the shift values and calculate the unit sizes. */
+	memcpy(x86_topo_system.dom_shifts, tscan.dom_shifts, sizeof(x86_topo_system=
dom_shifts));
+
+	dom =3D TOPO_SMT_DOMAIN;
+	x86_topo_system.dom_size[dom] =3D 1U << x86_topo_system.dom_shifts[dom];
+
+	for (dom++; dom < TOPO_MAX_DOMAIN; dom++) {
+		sft =3D x86_topo_system.dom_shifts[dom] - x86_topo_system.dom_shifts[dom -=
 1];
+		x86_topo_system.dom_size[dom] =3D 1U << sft;
+	}
+
+	topo_set_ids(&tscan);
+
+	/*
+	 * AMD systems have Nodes per package which cannot be mapped to
+	 * APIC ID.
+	 */
+	__amd_nodes_per_pkg =3D tscan.amd_nodes_per_pkg;
+}
diff --git a/arch/x86/kernel/cpu/topology_ext.c b/arch/x86/kernel/cpu/topolog=
y_ext.c
new file mode 100644
index 000000000000..e477228cd5b2
--- /dev/null
+++ b/arch/x86/kernel/cpu/topology_ext.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/cpu.h>
+
+#include <asm/apic.h>
+#include <asm/memtype.h>
+#include <asm/processor.h>
+
+#include "cpu.h"
+
+enum topo_types {
+	INVALID_TYPE		=3D 0,
+	SMT_TYPE		=3D 1,
+	CORE_TYPE		=3D 2,
+	MAX_TYPE_0B		=3D 3,
+	MODULE_TYPE		=3D 3,
+	TILE_TYPE		=3D 4,
+	DIE_TYPE		=3D 5,
+	DIEGRP_TYPE		=3D 6,
+	MAX_TYPE_1F		=3D 7,
+};
+
+/*
+ * Use a lookup table for the case that there are future types > 6 which
+ * describe an intermediate domain level which does not exist today.
+ */
+static const unsigned int topo_domain_map_0b_1f[MAX_TYPE_1F] =3D {
+	[SMT_TYPE]	=3D TOPO_SMT_DOMAIN,
+	[CORE_TYPE]	=3D TOPO_CORE_DOMAIN,
+	[MODULE_TYPE]	=3D TOPO_MODULE_DOMAIN,
+	[TILE_TYPE]	=3D TOPO_TILE_DOMAIN,
+	[DIE_TYPE]	=3D TOPO_DIE_DOMAIN,
+	[DIEGRP_TYPE]	=3D TOPO_DIEGRP_DOMAIN,
+};
+
+static inline bool topo_subleaf(struct topo_scan *tscan, u32 leaf, u32 suble=
af,
+				unsigned int *last_dom)
+{
+	unsigned int dom, maxtype;
+	const unsigned int *map;
+	struct {
+		// eax
+		u32	x2apic_shift	:  5, // Number of bits to shift APIC ID right
+					      // for the topology ID at the next level
+					: 27; // Reserved
+		// ebx
+		u32	num_processors	: 16, // Number of processors at current level
+					: 16; // Reserved
+		// ecx
+		u32	level		:  8, // Current topology level. Same as sub leaf number
+			type		:  8, // Level type. If 0, invalid
+					: 16; // Reserved
+		// edx
+		u32	x2apic_id	: 32; // X2APIC ID of the current logical processor
+	} sl;
+
+	switch (leaf) {
+	case 0x0b: maxtype =3D MAX_TYPE_0B; map =3D topo_domain_map_0b_1f; break;
+	case 0x1f: maxtype =3D MAX_TYPE_1F; map =3D topo_domain_map_0b_1f; break;
+	default: return false;
+	}
+
+	cpuid_subleaf(leaf, subleaf, &sl);
+
+	if (!sl.num_processors || sl.type =3D=3D INVALID_TYPE)
+		return false;
+
+	if (sl.type >=3D maxtype) {
+		pr_err_once("Topology: leaf 0x%x:%d Unknown domain type %u\n",
+			    leaf, subleaf, sl.type);
+		/*
+		 * It really would have been too obvious to make the domain
+		 * type space sparse and leave a few reserved types between
+		 * the points which might change instead of following the
+		 * usual "this can be fixed in software" principle.
+		 */
+		dom =3D *last_dom + 1;
+	} else {
+		dom =3D map[sl.type];
+		*last_dom =3D dom;
+	}
+
+	if (!dom) {
+		tscan->c->topo.initial_apicid =3D sl.x2apic_id;
+	} else if (tscan->c->topo.initial_apicid !=3D sl.x2apic_id) {
+		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf %d APIC ID mismatch %x !=3D %=
x\n",
+			     leaf, subleaf, tscan->c->topo.initial_apicid, sl.x2apic_id);
+	}
+
+	topology_set_dom(tscan, dom, sl.x2apic_shift, sl.num_processors);
+	return true;
+}
+
+static bool parse_topology_leaf(struct topo_scan *tscan, u32 leaf)
+{
+	unsigned int last_dom;
+	u32 subleaf;
+
+	/* Read all available subleafs and populate the levels */
+	for (subleaf =3D 0, last_dom =3D 0; topo_subleaf(tscan, leaf, subleaf, &las=
t_dom); subleaf++);
+
+	/* If subleaf 0 failed to parse, give up */
+	if (!subleaf)
+		return false;
+
+	/*
+	 * There are machines in the wild which have shift 0 in the subleaf
+	 * 0, but advertise 2 logical processors at that level. They are
+	 * truly SMT.
+	 */
+	if (!tscan->dom_shifts[TOPO_SMT_DOMAIN] && tscan->dom_ncpus[TOPO_SMT_DOMAIN=
] > 1) {
+		unsigned int sft =3D get_count_order(tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
+
+		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf 0 has shift level 0 but %u CP=
Us. Fixing it up.\n",
+			     leaf, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
+		topology_update_dom(tscan, TOPO_SMT_DOMAIN, sft, tscan->dom_ncpus[TOPO_SMT=
_DOMAIN]);
+	}
+
+	set_cpu_cap(tscan->c, X86_FEATURE_XTOPOLOGY);
+	return true;
+}
+
+bool cpu_parse_topology_ext(struct topo_scan *tscan)
+{
+	/* Intel: Try leaf 0x1F first. */
+	if (tscan->c->cpuid_level >=3D 0x1f && parse_topology_leaf(tscan, 0x1f))
+		return true;
+
+	/* Intel/AMD: Fall back to leaf 0xB if available */
+	return tscan->c->cpuid_level >=3D 0x0b && parse_topology_leaf(tscan, 0x0b);
+}
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 415564a6523b..90eba7eb5335 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -71,10 +71,6 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
 {
 	early_init_zhaoxin(c);
 	init_intel_cacheinfo(c);
-	detect_num_cpu_cores(c);
-#ifdef CONFIG_X86_32
-	detect_ht(c);
-#endif
=20
 	if (c->cpuid_level > 9) {
 		unsigned int eax =3D cpuid_eax(10);
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index afd09924094e..4aeafe63521b 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -136,7 +136,7 @@ static void __init dtb_cpu_setup(void)
 			pr_warn("%pOF: missing local APIC ID\n", dn);
 			continue;
 		}
-		generic_processor_info(apic_id);
+		topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 	}
 }
=20
@@ -302,7 +302,7 @@ void __init x86_flattree_get_config(void)
 }
 #endif
=20
-void __init x86_dtb_init(void)
+void __init x86_dtb_parse_smp_config(void)
 {
 	if (!of_have_populated_dt())
 		return;
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 578d16fc040f..df337860612d 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -89,7 +89,7 @@ static void __init jailhouse_x2apic_init(void)
 #endif
 }
=20
-static void __init jailhouse_get_smp_config(unsigned int early)
+static void __init jailhouse_parse_smp_config(void)
 {
 	struct ioapic_domain_cfg ioapic_cfg =3D {
 		.type =3D IOAPIC_DOMAIN_STRICT,
@@ -102,7 +102,7 @@ static void __init jailhouse_get_smp_config(unsigned int =
early)
 	register_lapic_address(0xfee00000);
=20
 	for (cpu =3D 0; cpu < setup_data.v1.num_cpus; cpu++)
-		generic_processor_info(setup_data.v1.cpu_ids[cpu]);
+		topology_register_apic(setup_data.v1.cpu_ids[cpu], CPU_ACPIID_INVALID, tru=
e);
=20
 	smp_found_config =3D 1;
=20
@@ -201,21 +201,23 @@ static void __init jailhouse_init_platform(void)
 	struct setup_data header;
 	void *mapping;
=20
-	x86_init.irqs.pre_vector_init	=3D x86_init_noop;
-	x86_init.timers.timer_init	=3D jailhouse_timer_init;
-	x86_init.mpparse.get_smp_config	=3D jailhouse_get_smp_config;
-	x86_init.pci.arch_init		=3D jailhouse_pci_arch_init;
+	x86_init.irqs.pre_vector_init		=3D x86_init_noop;
+	x86_init.timers.timer_init		=3D jailhouse_timer_init;
+	x86_init.mpparse.find_mptable		=3D x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	=3D x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		=3D jailhouse_parse_smp_config;
+	x86_init.pci.arch_init			=3D jailhouse_pci_arch_init;
=20
-	x86_platform.calibrate_cpu	=3D jailhouse_get_tsc;
-	x86_platform.calibrate_tsc	=3D jailhouse_get_tsc;
-	x86_platform.get_wallclock	=3D jailhouse_get_wallclock;
-	x86_platform.legacy.rtc		=3D 0;
-	x86_platform.legacy.warm_reset	=3D 0;
-	x86_platform.legacy.i8042	=3D X86_LEGACY_I8042_PLATFORM_ABSENT;
+	x86_platform.calibrate_cpu		=3D jailhouse_get_tsc;
+	x86_platform.calibrate_tsc		=3D jailhouse_get_tsc;
+	x86_platform.get_wallclock		=3D jailhouse_get_wallclock;
+	x86_platform.legacy.rtc			=3D 0;
+	x86_platform.legacy.warm_reset		=3D 0;
+	x86_platform.legacy.i8042		=3D X86_LEGACY_I8042_PLATFORM_ABSENT;
=20
-	legacy_pic			=3D &null_legacy_pic;
+	legacy_pic				=3D &null_legacy_pic;
=20
-	machine_ops.emergency_restart	=3D jailhouse_no_restart;
+	machine_ops.emergency_restart		=3D jailhouse_no_restart;
=20
 	while (pa_data) {
 		mapping =3D early_memremap(pa_data, sizeof(header));
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index b223922248e9..1ccd30c8246f 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -36,6 +36,8 @@
  * Checksum an MP configuration block.
  */
=20
+static unsigned int num_procs __initdata;
+
 static int __init mpf_checksum(unsigned char *mp, int len)
 {
 	int sum =3D 0;
@@ -50,16 +52,15 @@ static void __init MP_processor_info(struct mpc_cpu *m)
 {
 	char *bootup_cpu =3D "";
=20
-	if (!(m->cpuflag & CPU_ENABLED)) {
-		disabled_cpus++;
+	topology_register_apic(m->apicid, CPU_ACPIID_INVALID, m->cpuflag & CPU_ENAB=
LED);
+	if (!(m->cpuflag & CPU_ENABLED))
 		return;
-	}
=20
 	if (m->cpuflag & CPU_BOOTPROCESSOR)
 		bootup_cpu =3D " (Bootup-CPU)";
=20
 	pr_info("Processor #%d%s\n", m->apicid, bootup_cpu);
-	generic_processor_info(m->apicid);
+	num_procs++;
 }
=20
 #ifdef CONFIG_X86_IO_APIC
@@ -236,9 +237,9 @@ static int __init smp_read_mpc(struct mpc_table *mpc, uns=
igned early)
 		}
 	}
=20
-	if (!num_processors)
+	if (!num_procs && !acpi_lapic)
 		pr_err("MPTABLE: no processors registered!\n");
-	return num_processors;
+	return num_procs || acpi_lapic;
 }
=20
 #ifdef CONFIG_X86_IO_APIC
@@ -473,7 +474,7 @@ static int __init check_physptr(struct mpf_intel *mpf, un=
signed int early)
 /*
  * Scan the memory blocks for an SMP configuration block.
  */
-void __init default_get_smp_config(unsigned int early)
+static __init void mpparse_get_smp_config(unsigned int early)
 {
 	struct mpf_intel *mpf;
=20
@@ -529,8 +530,8 @@ void __init default_get_smp_config(unsigned int early)
 	} else
 		BUG();
=20
-	if (!early)
-		pr_info("Processors: %d\n", num_processors);
+	if (!early && !acpi_lapic)
+		pr_info("Processors: %d\n", num_procs);
 	/*
 	 * Only use the first configuration found.
 	 */
@@ -538,6 +539,16 @@ void __init default_get_smp_config(unsigned int early)
 	early_memunmap(mpf, sizeof(*mpf));
 }
=20
+void __init mpparse_parse_early_smp_config(void)
+{
+	mpparse_get_smp_config(true);
+}
+
+void __init mpparse_parse_smp_config(void)
+{
+	mpparse_get_smp_config(false);
+}
+
 static void __init smp_reserve_memory(struct mpf_intel *mpf)
 {
 	memblock_reserve(mpf->physptr, get_mpc_size(mpf->physptr));
@@ -587,7 +598,7 @@ static int __init smp_scan_config(unsigned long base, uns=
igned long length)
 	return ret;
 }
=20
-void __init default_find_smp_config(void)
+void __init mpparse_find_mptable(void)
 {
 	unsigned int address;
=20
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ab49ade31b0d..6121c2b42ecf 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -936,7 +936,7 @@ static __cpuidle void mwait_idle(void)
 void select_idle_routine(const struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
-	if (boot_option_idle_override =3D=3D IDLE_POLL && smp_num_siblings > 1)
+	if (boot_option_idle_override =3D=3D IDLE_POLL && __max_threads_per_core > =
1)
 		pr_warn_once("WARNING: polling idle and HT enabled, performance may degrad=
e\n");
 #endif
 	if (x86_idle_set() || boot_option_idle_override =3D=3D IDLE_POLL)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84201071dfac..4e320d4d3898 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -970,10 +970,8 @@ void __init setup_arch(char **cmdline_p)
 	high_memory =3D (void *)__va(max_pfn * PAGE_SIZE - 1) + 1;
 #endif
=20
-	/*
-	 * Find and reserve possible boot-time SMP configuration:
-	 */
-	find_smp_config();
+	/* Find and reserve MPTABLE area */
+	x86_init.mpparse.find_mptable();
=20
 	early_alloc_pgt_buf();
=20
@@ -1090,7 +1088,9 @@ void __init setup_arch(char **cmdline_p)
=20
 	early_platform_quirks();
=20
+	/* Some platforms need the APIC registered for NUMA configuration */
 	early_acpi_boot_init();
+	x86_init.mpparse.early_parse_smp_cfg();
=20
 	x86_flattree_get_config();
=20
@@ -1131,24 +1131,19 @@ void __init setup_arch(char **cmdline_p)
=20
 	early_quirks();
=20
-	/*
-	 * Read APIC and some other early information from ACPI tables.
-	 */
-	acpi_boot_init();
-	x86_dtb_init();
+	topology_apply_cmdline_limits_early();
=20
 	/*
-	 * get boot-time SMP configuration:
+	 * Parse SMP configuration. Try ACPI first and then the platform
+	 * specific parser.
 	 */
-	get_smp_config();
+	acpi_boot_init();
+	x86_init.mpparse.parse_smp_cfg();
=20
-	/*
-	 * Systems w/o ACPI and mptables might not have it mapped the local
-	 * APIC yet, but prefill_possible_map() might need to access it.
-	 */
+	/* Last opportunity to detect and map the local APIC */
 	init_apic_mappings();
=20
-	prefill_possible_map();
+	topology_init_possible_cpus();
=20
 	init_cpu_to_node();
 	init_gi_nodes();
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f57ce68a3f1..9c1e1219c28f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -125,25 +125,6 @@ struct mwait_cpu_dead {
  */
 static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
=20
-/* Logical package management. */
-struct logical_maps {
-	u32	phys_pkg_id;
-	u32	phys_die_id;
-	u32	logical_pkg_id;
-	u32	logical_die_id;
-};
-
-/* Temporary workaround until the full topology mechanics is in place */
-static DEFINE_PER_CPU_READ_MOSTLY(struct logical_maps, logical_maps) =3D {
-	.phys_pkg_id	=3D U32_MAX,
-	.phys_die_id	=3D U32_MAX,
-};
-
-unsigned int __max_logical_packages __read_mostly;
-EXPORT_SYMBOL(__max_logical_packages);
-static unsigned int logical_packages __read_mostly;
-static unsigned int logical_die __read_mostly;
-
 /* Maximum number of SMT threads on any online core */
 int __read_mostly __max_smt_threads =3D 1;
=20
@@ -336,103 +317,11 @@ static void notrace start_secondary(void *unused)
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
=20
-/**
- * topology_phys_to_logical_pkg - Map a physical package id to a logical
- * @phys_pkg:	The physical package id to map
- *
- * Returns logical package id or -1 if not found
- */
-int topology_phys_to_logical_pkg(unsigned int phys_pkg)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		if (per_cpu(logical_maps.phys_pkg_id, cpu) =3D=3D phys_pkg)
-			return per_cpu(logical_maps.logical_pkg_id, cpu);
-	}
-	return -1;
-}
-EXPORT_SYMBOL(topology_phys_to_logical_pkg);
-
-/**
- * topology_phys_to_logical_die - Map a physical die id to logical
- * @die_id:	The physical die id to map
- * @cur_cpu:	The CPU for which the mapping is done
- *
- * Returns logical die id or -1 if not found
- */
-static int topology_phys_to_logical_die(unsigned int die_id, unsigned int cu=
r_cpu)
-{
-	int cpu, proc_id =3D cpu_data(cur_cpu).topo.pkg_id;
-
-	for_each_possible_cpu(cpu) {
-		if (per_cpu(logical_maps.phys_pkg_id, cpu) =3D=3D proc_id &&
-		    per_cpu(logical_maps.phys_die_id, cpu) =3D=3D die_id)
-			return per_cpu(logical_maps.logical_die_id, cpu);
-	}
-	return -1;
-}
-
-/**
- * topology_update_package_map - Update the physical to logical package map
- * @pkg:	The physical package id as retrieved via CPUID
- * @cpu:	The cpu for which this is updated
- */
-int topology_update_package_map(unsigned int pkg, unsigned int cpu)
-{
-	int new;
-
-	/* Already available somewhere? */
-	new =3D topology_phys_to_logical_pkg(pkg);
-	if (new >=3D 0)
-		goto found;
-
-	new =3D logical_packages++;
-	if (new !=3D pkg) {
-		pr_info("CPU %u Converting physical %u to logical package %u\n",
-			cpu, pkg, new);
-	}
-found:
-	per_cpu(logical_maps.phys_pkg_id, cpu) =3D pkg;
-	per_cpu(logical_maps.logical_pkg_id, cpu) =3D new;
-	cpu_data(cpu).topo.logical_pkg_id =3D new;
-	return 0;
-}
-/**
- * topology_update_die_map - Update the physical to logical die map
- * @die:	The die id as retrieved via CPUID
- * @cpu:	The cpu for which this is updated
- */
-int topology_update_die_map(unsigned int die, unsigned int cpu)
-{
-	int new;
-
-	/* Already available somewhere? */
-	new =3D topology_phys_to_logical_die(die, cpu);
-	if (new >=3D 0)
-		goto found;
-
-	new =3D logical_die++;
-	if (new !=3D die) {
-		pr_info("CPU %u Converting physical %u to logical die %u\n",
-			cpu, die, new);
-	}
-found:
-	per_cpu(logical_maps.phys_die_id, cpu) =3D die;
-	per_cpu(logical_maps.logical_die_id, cpu) =3D new;
-	cpu_data(cpu).topo.logical_die_id =3D new;
-	return 0;
-}
-
 static void __init smp_store_boot_cpu_info(void)
 {
-	int id =3D 0; /* CPU 0 */
-	struct cpuinfo_x86 *c =3D &cpu_data(id);
+	struct cpuinfo_x86 *c =3D &cpu_data(0);
=20
 	*c =3D boot_cpu_data;
-	c->cpu_index =3D id;
-	topology_update_package_map(c->topo.pkg_id, id);
-	topology_update_die_map(c->topo.die_id, id);
 	c->initialized =3D true;
 }
=20
@@ -488,6 +377,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuin=
fo_x86 *o)
=20
 		if (c->topo.pkg_id =3D=3D o->topo.pkg_id &&
 		    c->topo.die_id =3D=3D o->topo.die_id &&
+		    c->topo.amd_node_id =3D=3D o->topo.amd_node_id &&
 		    per_cpu_llc_id(cpu1) =3D=3D per_cpu_llc_id(cpu2)) {
 			if (c->topo.core_id =3D=3D o->topo.core_id)
 				return topology_sane(c, o, "smt");
@@ -509,10 +399,13 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpu=
info_x86 *o)
=20
 static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
-	if (c->topo.pkg_id =3D=3D o->topo.pkg_id &&
-	    c->topo.die_id =3D=3D o->topo.die_id)
-		return true;
-	return false;
+	if (c->topo.pkg_id !=3D o->topo.pkg_id || c->topo.die_id !=3D o->topo.die_i=
d)
+		return false;
+
+	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT) && topology_amd_nodes_per_pkg(=
) > 1)
+		return c->topo.amd_node_id =3D=3D o->topo.amd_node_id;
+
+	return true;
 }
=20
 static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
@@ -670,8 +563,8 @@ static void __init build_sched_topology(void)
=20
 void set_cpu_sibling_map(int cpu)
 {
-	bool has_smt =3D smp_num_siblings > 1;
-	bool has_mp =3D has_smt || boot_cpu_data.x86_max_cores > 1;
+	bool has_smt =3D __max_threads_per_core > 1;
+	bool has_mp =3D has_smt || topology_num_cores_per_package() > 1;
 	struct cpuinfo_x86 *c =3D &cpu_data(cpu);
 	struct cpuinfo_x86 *o;
 	int i, threads;
@@ -1068,9 +961,13 @@ int native_kick_ap(unsigned int cpu, struct task_struct=
 *tidle)
=20
 	pr_debug("++++++++++++++++++++=3D_---CPU UP  %u\n", cpu);
=20
-	if (apicid =3D=3D BAD_APICID || !physid_isset(apicid, phys_cpu_present_map)=
 ||
-	    !apic_id_valid(apicid)) {
-		pr_err("%s: bad cpu %d\n", __func__, cpu);
+	if (apicid =3D=3D BAD_APICID || !apic_id_valid(apicid)) {
+		pr_err("CPU %u has invalid APIC ID %x. Aborting bringup\n", cpu, apicid);
+		return -EINVAL;
+	}
+
+	if (!test_bit(apicid, phys_cpu_present_map)) {
+		pr_err("CPU %u APIC ID %x is not present. Aborting bringup\n", cpu, apicid=
);
 		return -EINVAL;
 	}
=20
@@ -1139,14 +1036,8 @@ static __init void disable_smp(void)
 	pr_info("SMP disabled\n");
=20
 	disable_ioapic_support();
+	topology_reset_possible_cpus_up();
=20
-	init_cpu_present(cpumask_of(0));
-	init_cpu_possible(cpumask_of(0));
-
-	if (smp_found_config)
-		physid_set_mask_of_physid(boot_cpu_physical_apicid, &phys_cpu_present_map);
-	else
-		physid_set_mask_of_physid(0, &phys_cpu_present_map);
 	cpumask_set_cpu(0, topology_sibling_cpumask(0));
 	cpumask_set_cpu(0, topology_core_cpumask(0));
 	cpumask_set_cpu(0, topology_die_cpumask(0));
@@ -1265,102 +1156,16 @@ void __init native_smp_prepare_boot_cpu(void)
 	native_pv_lock_init();
 }
=20
-void __init calculate_max_logical_packages(void)
-{
-	int ncpus;
-
-	/*
-	 * Today neither Intel nor AMD support heterogeneous systems so
-	 * extrapolate the boot cpu's data to all packages.
-	 */
-	ncpus =3D cpu_data(0).booted_cores * topology_max_smt_threads();
-	__max_logical_packages =3D DIV_ROUND_UP(total_cpus, ncpus);
-	pr_info("Max logical packages: %u\n", __max_logical_packages);
-}
-
 void __init native_smp_cpus_done(unsigned int max_cpus)
 {
 	pr_debug("Boot done\n");
=20
-	calculate_max_logical_packages();
 	build_sched_topology();
 	nmi_selftest();
 	impress_friends();
 	cache_aps_init();
 }
=20
-static int __initdata setup_possible_cpus =3D -1;
-static int __init _setup_possible_cpus(char *str)
-{
-	get_option(&str, &setup_possible_cpus);
-	return 0;
-}
-early_param("possible_cpus", _setup_possible_cpus);
-
-
-/*
- * cpu_possible_mask should be static, it cannot change as cpu's
- * are onlined, or offlined. The reason is per-cpu data-structures
- * are allocated by some modules at init time, and don't expect to
- * do this dynamically on cpu arrival/departure.
- * cpu_present_mask on the other hand can change dynamically.
- * In case when cpu_hotplug is not compiled, then we resort to current
- * behaviour, which is cpu_possible =3D=3D cpu_present.
- * - Ashok Raj
- *
- * Three ways to find out the number of additional hotplug CPUs:
- * - If the BIOS specified disabled CPUs in ACPI/mptables use that.
- * - The user can overwrite it with possible_cpus=3DNUM
- * - Otherwise don't reserve additional CPUs.
- * We do this because additional CPUs waste a lot of memory.
- * -AK
- */
-__init void prefill_possible_map(void)
-{
-	int i, possible;
-
-	i =3D setup_max_cpus ?: 1;
-	if (setup_possible_cpus =3D=3D -1) {
-		possible =3D num_processors;
-#ifdef CONFIG_HOTPLUG_CPU
-		if (setup_max_cpus)
-			possible +=3D disabled_cpus;
-#else
-		if (possible > i)
-			possible =3D i;
-#endif
-	} else
-		possible =3D setup_possible_cpus;
-
-	total_cpus =3D max_t(int, possible, num_processors + disabled_cpus);
-
-	/* nr_cpu_ids could be reduced via nr_cpus=3D */
-	if (possible > nr_cpu_ids) {
-		pr_warn("%d Processors exceeds NR_CPUS limit of %u\n",
-			possible, nr_cpu_ids);
-		possible =3D nr_cpu_ids;
-	}
-
-#ifdef CONFIG_HOTPLUG_CPU
-	if (!setup_max_cpus)
-#endif
-	if (possible > i) {
-		pr_warn("%d Processors exceeds max_cpus limit of %u\n",
-			possible, setup_max_cpus);
-		possible =3D i;
-	}
-
-	set_nr_cpu_ids(possible);
-
-	pr_info("Allowing %d CPUs, %d hotplug CPUs\n",
-		possible, max_t(int, possible - num_processors, 0));
-
-	reset_cpu_possible_mask();
-
-	for (i =3D 0; i < possible; i++)
-		set_cpu_possible(i, true);
-}
-
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index d3fc01770558..73511332bb67 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -127,25 +127,12 @@ static void __init vsmp_cap_cpus(void)
 #endif
 }
=20
-static u32 apicid_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return read_apic_id() >> index_msb;
-}
-
-static void vsmp_apic_post_init(void)
-{
-	/* need to update phys_pkg_id */
-	apic->phys_pkg_id =3D apicid_phys_pkg_id;
-}
-
 void __init vsmp_init(void)
 {
 	detect_vsmp_box();
 	if (!is_vsmp_box())
 		return;
=20
-	x86_platform.apic_post_init =3D vsmp_apic_post_init;
-
 	vsmp_cap_cpus();
=20
 	set_vsmp_ctl();
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a37ebd3b4773..a42830dc151b 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -70,8 +70,9 @@ struct x86_init_ops x86_init __initdata =3D {
=20
 	.mpparse =3D {
 		.setup_ioapic_ids	=3D x86_init_noop,
-		.find_smp_config	=3D default_find_smp_config,
-		.get_smp_config		=3D default_get_smp_config,
+		.find_mptable		=3D mpparse_find_mptable,
+		.early_parse_smp_cfg	=3D mpparse_parse_early_smp_config,
+		.parse_smp_cfg		=3D mpparse_parse_smp_config,
 	},
=20
 	.irqs =3D {
diff --git a/arch/x86/mm/amdtopology.c b/arch/x86/mm/amdtopology.c
index b3ca7d23e4b0..9332b36a1091 100644
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -54,13 +54,11 @@ static __init int find_northbridge(void)
=20
 int __init amd_numa_init(void)
 {
-	u64 start =3D PFN_PHYS(0);
+	unsigned int numnodes, cores, apicid;
+	u64 prevbase, start =3D PFN_PHYS(0);
 	u64 end =3D PFN_PHYS(max_pfn);
-	unsigned numnodes;
-	u64 prevbase;
-	int i, j, nb;
 	u32 nodeid, reg;
-	unsigned int bits, cores, apicid_base;
+	int i, j, nb;
=20
 	if (!early_pci_allowed())
 		return -EINVAL;
@@ -158,26 +156,18 @@ int __init amd_numa_init(void)
 		return -ENOENT;
=20
 	/*
-	 * We seem to have valid NUMA configuration.  Map apicids to nodes
-	 * using the coreid bits from early_identify_cpu.
+	 * We seem to have valid NUMA configuration. Map apicids to nodes
+	 * using the size of the core domain in the APIC space.
 	 */
-	bits =3D boot_cpu_data.x86_coreid_bits;
-	cores =3D 1 << bits;
-	apicid_base =3D 0;
+	cores =3D topology_get_domain_size(TOPO_CORE_DOMAIN);
=20
-	/*
-	 * get boot-time SMP configuration:
-	 */
-	early_get_smp_config();
+	apicid =3D boot_cpu_physical_apicid;
+	if (apicid > 0)
+		pr_info("BSP APIC ID: %02x\n", apicid);
=20
-	if (boot_cpu_physical_apicid > 0) {
-		pr_info("BSP APIC ID: %02x\n", boot_cpu_physical_apicid);
-		apicid_base =3D boot_cpu_physical_apicid;
+	for_each_node_mask(i, numa_nodes_parsed) {
+		for (j =3D 0; j < cores; j++, apicid++)
+			set_apicid_to_node(apicid, i);
 	}
-
-	for_each_node_mask(i, numa_nodes_parsed)
-		for (j =3D apicid_base; j < cores + apicid_base; j++)
-			set_apicid_to_node((i << bits) + j, i);
-
 	return 0;
 }
diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4=
100.c
index 40745664d92f..f32451bdcfdd 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -135,13 +135,13 @@ static void sdv_pci_init(void)
  */
 void __init x86_ce4100_early_setup(void)
 {
-	x86_init.oem.arch_setup =3D sdv_arch_setup;
-	x86_init.resources.probe_roms =3D x86_init_noop;
-	x86_init.mpparse.get_smp_config =3D x86_init_uint_noop;
-	x86_init.mpparse.find_smp_config =3D x86_init_noop;
-	x86_init.mpparse.setup_ioapic_ids =3D setup_ioapic_ids_from_mpc_nocheck;
-	x86_init.pci.init =3D ce4100_pci_init;
-	x86_init.pci.init_irq =3D sdv_pci_init;
+	x86_init.oem.arch_setup			=3D sdv_arch_setup;
+	x86_init.resources.probe_roms		=3D x86_init_noop;
+	x86_init.mpparse.find_mptable		=3D x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	=3D x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		=3D x86_dtb_parse_smp_config;
+	x86_init.pci.init			=3D ce4100_pci_init;
+	x86_init.pci.init_irq			=3D sdv_pci_init;
=20
 	/*
 	 * By default, the reboot method is ACPI which is supported by the
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/inte=
l-mid/intel-mid.c
index f4592dc7a1c1..7be71c2cdc83 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -118,7 +118,8 @@ void __init x86_intel_mid_early_setup(void)
 	machine_ops.emergency_restart  =3D intel_mid_reboot;
=20
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_smp_config =3D x86_init_noop;
-	x86_init.mpparse.get_smp_config =3D x86_init_uint_noop;
+	x86_init.mpparse.find_mptable		=3D x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	=3D x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		=3D x86_init_noop;
 	set_bit(MP_BUS_ISA, mp_bus_not_pci);
 }
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 9dd5490b3318..8b045dd25196 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -33,12 +33,6 @@ static unsigned int xen_io_apic_read(unsigned apic, unsign=
ed reg)
 	return 0xfd;
 }
=20
-static u32 xen_set_apic_id(u32 x)
-{
-	WARN_ON(1);
-	return x;
-}
-
 static u32 xen_get_apic_id(u32 x)
 {
 	return ((x)>>24) & 0xFFu;
@@ -49,20 +43,20 @@ static u32 xen_apic_read(u32 reg)
 	struct xen_platform_op op =3D {
 		.cmd =3D XENPF_get_cpuinfo,
 		.interface_version =3D XENPF_INTERFACE_VERSION,
-		.u.pcpu_info.xen_cpuid =3D 0,
 	};
-	int ret;
-
-	/* Shouldn't need this as APIC is turned off for PV, and we only
-	 * get called on the bootup processor. But just in case. */
-	if (!xen_initial_domain() || smp_processor_id())
-		return 0;
+	int ret, cpu;
=20
 	if (reg =3D=3D APIC_LVR)
 		return 0x14;
 	if (reg !=3D APIC_ID)
 		return 0;
=20
+	cpu =3D smp_processor_id();
+	if (!xen_initial_domain())
+		return cpu ? cpuid_to_apicid[cpu] << 24 : 0;
+
+	op.u.pcpu_info.xen_cpuid =3D cpu;
+
 	ret =3D HYPERVISOR_platform_op(&op);
 	if (ret)
 		op.u.pcpu_info.apic_id =3D BAD_APICID;
@@ -110,11 +104,6 @@ static int xen_madt_oem_check(char *oem_id, char *oem_ta=
ble_id)
 	return xen_pv_domain();
 }
=20
-static u32 xen_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return initial_apic_id >> index_msb;
-}
-
 static u32 xen_cpu_present_to_apicid(int cpu)
 {
 	if (cpu_present(cpu))
@@ -133,11 +122,9 @@ static struct apic xen_pv_apic __ro_after_init =3D {
 	.disable_esr			=3D 0,
=20
 	.cpu_present_to_apicid		=3D xen_cpu_present_to_apicid,
-	.phys_pkg_id			=3D xen_phys_pkg_id, /* detect_ht */
=20
 	.max_apic_id			=3D UINT_MAX,
 	.get_apic_id			=3D xen_get_apic_id,
-	.set_apic_id			=3D xen_set_apic_id,
=20
 	.calc_dest_apicid		=3D apic_flat_calc_apicid,
=20
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 3f8c34707c50..99a68fa71dbe 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -168,7 +168,7 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
 	 */
 	xen_uninit_lock_cpu(cpu);
=20
-	if (cpu_acpi_id(cpu) !=3D U32_MAX)
+	if (cpu_acpi_id(cpu) !=3D CPU_ACPIID_INVALID)
 		per_cpu(xen_vcpu_id, cpu) =3D cpu_acpi_id(cpu);
 	else
 		per_cpu(xen_vcpu_id, cpu) =3D cpu;
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index aeb33e0a3f76..ace2eb054053 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -200,6 +200,9 @@ static void __init xen_pv_init_platform(void)
 		xen_set_mtrr_data();
 	else
 		mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
+
+	/* Adjust nr_cpu_ids before "enumeration" happens */
+	xen_smp_count_cpus();
 }
=20
 static void __init xen_pv_guest_late_init(void)
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 1fb9a1644d94..935771726f9c 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -135,8 +135,6 @@ void __init xen_smp_cpus_done(unsigned int max_cpus)
 {
 	if (xen_hvm_domain())
 		native_smp_cpus_done(max_cpus);
-	else
-		calculate_max_logical_packages();
 }
=20
 void xen_smp_send_reschedule(int cpu)
diff --git a/arch/x86/xen/smp.h b/arch/x86/xen/smp.h
index c20cbb14c82b..b8efdbc693f7 100644
--- a/arch/x86/xen/smp.h
+++ b/arch/x86/xen/smp.h
@@ -19,6 +19,7 @@ extern void xen_smp_intr_free(unsigned int cpu);
 int xen_smp_intr_init_pv(unsigned int cpu);
 void xen_smp_intr_free_pv(unsigned int cpu);
=20
+void xen_smp_count_cpus(void);
 void xen_smp_cpus_done(unsigned int max_cpus);
=20
 void xen_smp_send_reschedule(int cpu);
@@ -44,6 +45,7 @@ static inline int xen_smp_intr_init_pv(unsigned int cpu)
 	return 0;
 }
 static inline void xen_smp_intr_free_pv(unsigned int cpu) {}
+static inline void xen_smp_count_cpus(void) { }
 #endif /* CONFIG_SMP */
=20
 #endif
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index a0f07bbfcd6e..27d1a5b7f571 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -29,6 +29,7 @@
 #include <asm/idtentry.h>
 #include <asm/desc.h>
 #include <asm/cpu.h>
+#include <asm/apic.h>
 #include <asm/io_apic.h>
=20
 #include <xen/interface/xen.h>
@@ -73,7 +74,6 @@ static void cpu_bringup(void)
 	}
 	cpu =3D smp_processor_id();
 	smp_store_cpu_info(cpu);
-	cpu_data(cpu).x86_max_cores =3D 1;
 	set_cpu_sibling_map(cpu);
=20
 	speculative_store_bypass_ht_init();
@@ -149,39 +149,16 @@ int xen_smp_intr_init_pv(unsigned int cpu)
 	return rc;
 }
=20
-static void __init _get_smp_config(unsigned int early)
+static void __init xen_pv_smp_config(void)
 {
-	int i, rc;
-	unsigned int subtract =3D 0;
-
-	if (early)
-		return;
-
-	num_processors =3D 0;
-	disabled_cpus =3D 0;
-	for (i =3D 0; i < nr_cpu_ids; i++) {
-		rc =3D HYPERVISOR_vcpu_op(VCPUOP_is_up, i, NULL);
-		if (rc >=3D 0) {
-			num_processors++;
-			set_cpu_possible(i, true);
-		} else {
-			set_cpu_possible(i, false);
-			set_cpu_present(i, false);
-			subtract++;
-		}
-	}
-#ifdef CONFIG_HOTPLUG_CPU
-	/* This is akin to using 'nr_cpus' on the Linux command line.
-	 * Which is OK as when we use 'dom0_max_vcpus=3DX' we can only
-	 * have up to X, while nr_cpu_ids is greater than X. This
-	 * normally is not a problem, except when CPU hotplugging
-	 * is involved and then there might be more than X CPUs
-	 * in the guest - which will not work as there is no
-	 * hypercall to expand the max number of VCPUs an already
-	 * running guest has. So cap it up to X. */
-	if (subtract)
-		set_nr_cpu_ids(nr_cpu_ids - subtract);
-#endif
+	u32 apicid =3D 0;
+	int i;
+
+	topology_register_boot_apic(apicid++);
+
+	for (i =3D 1; i < nr_cpu_ids; i++)
+		topology_register_apic(apicid++, CPU_ACPIID_INVALID, true);
+
 	/* Pretend to be a proper enumerated system */
 	smp_found_config =3D 1;
 }
@@ -224,8 +201,6 @@ static void __init xen_pv_smp_prepare_cpus(unsigned int m=
ax_cpus)
=20
 	smp_prepare_cpus_common();
=20
-	cpu_data(0).x86_max_cores =3D 1;
-
 	speculative_store_bypass_ht_init();
=20
 	xen_pmu_init(0);
@@ -434,6 +409,20 @@ static irqreturn_t xen_irq_work_interrupt(int irq, void =
*dev_id)
 	return IRQ_HANDLED;
 }
=20
+void __init xen_smp_count_cpus(void)
+{
+	unsigned int cpus;
+
+	for (cpus =3D 0; cpus < nr_cpu_ids; cpus++) {
+		if (HYPERVISOR_vcpu_op(VCPUOP_is_up, cpus, NULL) < 0)
+			break;
+	}
+
+	pr_info("Xen PV: Detected %u vCPUS\n", cpus);
+	if (cpus < nr_cpu_ids)
+		set_nr_cpu_ids(cpus);
+}
+
 static const struct smp_ops xen_smp_ops __initconst =3D {
 	.smp_prepare_boot_cpu =3D xen_pv_smp_prepare_boot_cpu,
 	.smp_prepare_cpus =3D xen_pv_smp_prepare_cpus,
@@ -458,6 +447,12 @@ void __init xen_smp_init(void)
 	smp_ops =3D xen_smp_ops;
=20
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_smp_config =3D x86_init_noop;
-	x86_init.mpparse.get_smp_config =3D _get_smp_config;
+	x86_init.mpparse.find_mptable		=3D x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	=3D x86_init_noop;
+
+	/* XEN/PV Dom0 has halfways sane topology information via CPUID/MADT */
+	if (xen_initial_domain())
+		x86_init.mpparse.parse_smp_cfg	=3D x86_init_noop;
+	else
+		x86_init.mpparse.parse_smp_cfg	=3D xen_pv_smp_config;
 }
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 537b9987a431..2b8c20bb926a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1915,7 +1915,7 @@ static void dct_determine_memory_type(struct amd64_pvt =
*pvt)
 /* On F10h and later ErrAddr is MC4_ADDR[47:1] */
 static u64 get_error_address(struct amd64_pvt *pvt, struct mce *m)
 {
-	u16 mce_nid =3D topology_die_id(m->extcpu);
+	u16 mce_nid =3D topology_amd_node_id(m->extcpu);
 	struct mem_ctl_info *mci;
 	u8 start_bit =3D 1;
 	u8 end_bit   =3D 47;
@@ -3446,7 +3446,7 @@ static void get_cpus_on_this_dct_cpumask(struct cpumask=
 *mask, u16 nid)
 	int cpu;
=20
 	for_each_online_cpu(cpu)
-		if (topology_die_id(cpu) =3D=3D nid)
+		if (topology_amd_node_id(cpu) =3D=3D nid)
 			cpumask_set_cpu(cpu, mask);
 }
=20
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index ec8b6c9fedfd..8130c3dc64da 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -584,7 +584,7 @@ static void decode_mc3_mce(struct mce *m)
 static void decode_mc4_mce(struct mce *m)
 {
 	unsigned int fam =3D x86_family(m->cpuid);
-	int node_id =3D topology_die_id(m->extcpu);
+	int node_id =3D topology_amd_node_id(m->extcpu);
 	u16 ec =3D EC(m->status);
 	u8 xec =3D XEC(m->status, 0x1f);
 	u8 offset =3D 0;
@@ -746,7 +746,7 @@ static void decode_smca_error(struct mce *m)
=20
 	if ((bank_type =3D=3D SMCA_UMC || bank_type =3D=3D SMCA_UMC_V2) &&
 	    xec =3D=3D 0 && decode_dram_ecc)
-		decode_dram_ecc(topology_die_id(m->extcpu), m);
+		decode_dram_ecc(topology_amd_node_id(m->extcpu), m);
 }
=20
 static inline void amd_decode_err_code(u16 ec)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 2ff6deedef95..da1f43999d09 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -451,7 +451,7 @@ static int vangogh_init_smc_tables(struct smu_context *sm=
u)
=20
 #ifdef CONFIG_X86
 	/* AMD x86 APU only */
-	smu->cpu_core_num =3D boot_cpu_data.x86_max_cores;
+	smu->cpu_core_num =3D topology_num_cores_per_package();
 #else
 	smu->cpu_core_num =3D 4;
 #endif
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index b8fc8d1ef20d..b0991dde2e59 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -782,7 +782,7 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
=20
-	max_zones =3D topology_max_packages() * topology_max_die_per_package();
+	max_zones =3D topology_max_packages() * topology_max_dies_per_package();
 	zone_devices =3D kcalloc(max_zones, sizeof(struct platform_device *),
 			      GFP_KERNEL);
 	if (!zone_devices)
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 6307112c2c0c..9ed2c4b6734e 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -209,7 +209,7 @@ static ssize_t power1_average_show(struct device *dev,
 	 * With the new x86 topology modelling, x86_max_cores is the
 	 * compute unit number.
 	 */
-	cu_num =3D boot_cpu_data.x86_max_cores;
+	cu_num =3D topology_num_cores_per_package();
=20
 	ret =3D read_registers(data);
 	if (ret)
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b=
/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index a5e0f5c22179..b89c0dda9e5d 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -242,7 +242,7 @@ static int __init intel_uncore_init(void)
 		return -ENODEV;
=20
 	uncore_max_entries =3D topology_max_packages() *
-					topology_max_die_per_package();
+					topology_max_dies_per_package();
 	uncore_instances =3D kcalloc(uncore_max_entries,
 				   sizeof(*uncore_instances), GFP_KERNEL);
 	if (!uncore_instances)
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_ra=
pl_common.c
index 2feed036c1cd..00c861899a47 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1564,7 +1564,7 @@ struct rapl_package *rapl_add_package(int id, struct ra=
pl_if_priv *priv, bool id
 	if (id_is_cpu) {
 		rp->id =3D topology_logical_die_id(id);
 		rp->lead_cpu =3D id;
-		if (topology_max_die_per_package() > 1)
+		if (topology_max_dies_per_package() > 1)
 			snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
 				 topology_physical_package_id(id), topology_die_id(id));
 		else
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_=
hfi.c
index 3b04c6ec4fca..40d664a66cdc 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -607,7 +607,7 @@ void __init intel_hfi_init(void)
=20
 	/* There is one HFI instance per die/package. */
 	max_hfi_instances =3D topology_max_packages() *
-			    topology_max_die_per_package();
+			    topology_max_dies_per_package();
=20
 	/*
 	 * This allocation may fail. CPU hotplug callbacks must check
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel=
/intel_powerclamp.c
index bc6eb0dd66a4..4ba649370aa1 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -587,7 +587,7 @@ static int powerclamp_idle_injection_register(void)
 	poll_pkg_cstate_enable =3D false;
 	if (cpumask_equal(cpu_present_mask, idle_injection_cpu_mask)) {
 		ii_dev =3D idle_inject_register_full(idle_injection_cpu_mask, idle_inject_=
update);
-		if (topology_max_packages() =3D=3D 1 && topology_max_die_per_package() =3D=
=3D 1)
+		if (topology_max_packages() =3D=3D 1 && topology_max_dies_per_package() =
=3D=3D 1)
 			poll_pkg_cstate_enable =3D true;
 	} else {
 		ii_dev =3D idle_inject_register(idle_injection_cpu_mask);
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/i=
ntel/x86_pkg_temp_thermal.c
index 11a7f8108bbb..f6c2e5964b8f 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -494,7 +494,7 @@ static int __init pkg_temp_thermal_init(void)
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
=20
-	max_id =3D topology_max_packages() * topology_max_die_per_package();
+	max_id =3D topology_max_packages() * topology_max_dies_per_package();
 	zones =3D kcalloc(max_id, sizeof(struct zone_device *),
 			   GFP_KERNEL);
 	if (!zones)
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index dcb89c987164..61a0ddf2bef6 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -112,7 +112,7 @@ void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
 int bringup_hibernate_cpu(unsigned int sleep_cpu);
-void bringup_nonboot_cpus(unsigned int setup_max_cpus);
+void bringup_nonboot_cpus(unsigned int max_cpus);
=20
 #else	/* CONFIG_SMP */
 #define cpuhp_tasks_frozen	0
diff --git a/include/linux/smp.h b/include/linux/smp.h
index e87520dc2959..7a83fd2fccbe 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -218,6 +218,8 @@ smp_call_function_any(const struct cpumask *mask, smp_cal=
l_func_t func,
 static inline void kick_all_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
=20
+#define setup_max_cpus 0
+
 #ifdef CONFIG_UP_LATE_INIT
 extern void __init up_late_init(void);
 static inline void smp_init(void) { up_late_init(); }
diff --git a/init/main.c b/init/main.c
index e24b0780fdff..5644bb133fb4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -603,7 +603,6 @@ static int __init rdinit_setup(char *str)
 __setup("rdinit=3D", rdinit_setup);
=20
 #ifndef CONFIG_SMP
-static const unsigned int setup_max_cpus =3D NR_CPUS;
 static inline void setup_nr_cpu_ids(void) { }
 static inline void smp_prepare_cpus(unsigned int maxcpus) { }
 #endif
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6ec3ba4950b..023ddf8d625a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1909,14 +1909,14 @@ static bool __init cpuhp_bringup_cpus_parallel(unsign=
ed int ncpus)
 static inline bool cpuhp_bringup_cpus_parallel(unsigned int ncpus) { return =
false; }
 #endif /* CONFIG_HOTPLUG_PARALLEL */
=20
-void __init bringup_nonboot_cpus(unsigned int setup_max_cpus)
+void __init bringup_nonboot_cpus(unsigned int max_cpus)
 {
 	/* Try parallel bringup optimization if enabled */
-	if (cpuhp_bringup_cpus_parallel(setup_max_cpus))
+	if (cpuhp_bringup_cpus_parallel(max_cpus))
 		return;
=20
 	/* Full per CPU serialized bringup */
-	cpuhp_bringup_mask(cpu_present_mask, setup_max_cpus, CPUHP_ONLINE);
+	cpuhp_bringup_mask(cpu_present_mask, max_cpus, CPUHP_ONLINE);
 }
=20
 #ifdef CONFIG_PM_SLEEP_SMP


