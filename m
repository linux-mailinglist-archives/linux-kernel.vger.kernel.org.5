Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2227DAE9D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjJ2Vdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJ2Vdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:33:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45525F1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 14:33:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698615213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KvPzNavruI5q1crs74VkaMWvG3/h15J+8goS8aOYw6w=;
        b=DfjuQ8AdSCGgAXbq7zut+CkYEC/giGeSdk754iQi55UHh4vhXHCnXOc00A/7D0n9bwF7oe
        S7vOvXYm1qM+CZh0CAYoDlZersemPWpJomVgDJQzUz99ykQZvhK2r6e/7NcQdQyPGcHHlh
        7Pc/xy8ZMSfICL996S8uLRGsvKBrLrc0lsc0axutuUySmVXotd6XFyE4XAARyy9CttqEmR
        S7qb+pb0xFUOeHDT2BuZicKa8sVA6oToZ2RYkoX5oe16D7F4HIPzVCqSnJOTCALbsYZoP/
        NaNky3wOH9MIdRHpbTo5FI6JP45HrEsVWwIehDNLXT3QvObyzpJl6+t+0Wg86A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698615213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=KvPzNavruI5q1crs74VkaMWvG3/h15J+8goS8aOYw6w=;
        b=DvyHWdq8hzi8glOPKHLNK6Grhm9yU8Z42DNvW9HsEVuhGLhdLSG7hjXgtdq/kLJrllDD5f
        Peqe4yj7a7ShqADQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/core for v6.7-rc1
References: <169861500709.181063.7816209662289132093.tglx@xen13>
Message-ID: <169861501491.181063.16482926252873802124.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 29 Oct 2023 22:33:33 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-10=
-29-v2

up to:  92fe9bb77b0c: x86/apic, x86/hyperv: Use u32 in hv_snp_boot_ap() too


X86 core code updates:

  - Limit the hardcoded topology quirk for Hygon CPUs to those which have a
    model ID less than 4. The newer models have the topology CPUID leaf 0xB
    correctly implemented and are not affected.

  - Make SMT control more robust against enumeration failures

    SMT control was added to allow controlling SMT at boottime or
    runtime. The primary purpose was to provide a simple mechanism to
    disable SMT in the light of speculation attack vectors.

    It turned out that the code is sensible to enumeration failures and
    worked only by chance for XEN/PV. XEN/PV has no real APIC enumeration
    which means the primary thread mask is not set up correctly. By chance
    a XEN/PV boot ends up with smp_num_siblings =3D=3D 2, which makes the
    hotplug control stay at its default value "enabled". So the mask is
    never evaluated.

    The ongoing rework of the topology evaluation caused XEN/PV to end up
    with smp_num_siblings =3D=3D 1, which sets the SMT control to "not
    supported" and the empty primary thread mask causes the hotplug core to
    deny the bringup of the APS.

    Make the decision logic more robust and take 'not supported' and 'not
    implemented' into account for the decision whether a CPU should be
    booted or not.

  - Fake primary thread mask for XEN/PV

    Pretend that all XEN/PV vCPUs are primary threads, which makes the
    usage of the primary thread mask valid on XEN/PV. That is consistent
    with because all of the topology information on XEN/PV is fake or even
    non-existent.

  - Encapsulate topology information in cpuinfo_x86

    Move the randomly scattered topology data into a separate data
    structure for readability and as a preparatory step for the topology
    evaluation overhaul.

  - Consolidate APIC ID data type to u32

    It's fixed width hardware data and not randomly u16, int, unsigned long
    or whatever developers decided to use.

  - Cure the abuse of cpuinfo for persisting logical IDs.

    Per CPU cpuinfo is used to persist the logical package and die
    IDs. That's really not the right place simply because cpuinfo is
    subject to be reinitialized when a CPU goes through an offline/online
    cycle.

    Use separate per CPU data for the persisting to enable the further
    topology management rework. It will be removed once the new topology
    management is in place.

  - Provide a debug interface for inspecting topology information

    Useful in general and extremly helpful for validating the topology
    management rework in terms of correctness or "bug" compatibility.

Note:

There is a trivial conflict with the perf/core pull request in
arch/x86/events/amd/uncore.c. The perf/core variant needs to stay, but
needs a 's/get_llc_id/per_cpu_llc_id/' in amd_uncore_l3_ctx_scan().

The other trivial conflict in arch/x86/kernel/smpboot.c is against your
tree due to the upstream removal of smp_park_other_cpus_in_init().

Thanks,

	tglx

------------------>
Ingo Molnar (1):
      x86/apic, x86/hyperv: Use u32 in hv_snp_boot_ap() too

Pu Wen (1):
      x86/cpu/hygon: Fix the CPU topology evaluation for real

Thomas Gleixner (21):
      cpu/SMT: Make SMT control more robust against enumeration failures
      x86/apic: Fake primary thread mask for XEN/PV
      x86/cpu: Encapsulate topology information in cpuinfo_x86
      x86/cpu: Move phys_proc_id into topology info
      x86/cpu: Move cpu_die_id into topology info
      scsi: lpfc: Use topology_core_id()
      hwmon: (fam15h_power) Use topology_core_id()
      x86/cpu: Move cpu_core_id into topology info
      x86/cpu: Move cu_id into topology info
      x86/cpu: Remove pointless evaluation of x86_coreid_bits
      x86/cpu: Move logical package and die IDs into topology info
      x86/cpu: Move cpu_l[l2]c_id into topology info
      x86/apic: Use BAD_APICID consistently
      x86/apic: Use u32 for APIC IDs in global data
      x86/apic: Use u32 for check_apicid_used()
      x86/apic: Use u32 for cpu_present_to_apicid()
      x86/apic: Use u32 for phys_pkg_id()
      x86/apic: Use u32 for [gs]et_apic_id()
      x86/apic: Use u32 for wakeup_secondary_cpu[_64]()
      x86/cpu/topology: Cure the abuse of cpuinfo for persisting logical ids
      x86/cpu: Provide debug interface


 Documentation/arch/x86/topology.rst       | 12 ++---
 arch/x86/events/amd/uncore.c              |  2 +-
 arch/x86/events/intel/uncore.c            |  2 +-
 arch/x86/hyperv/hv_vtl.c                  |  2 +-
 arch/x86/hyperv/ivm.c                     |  2 +-
 arch/x86/include/asm/apic.h               | 39 +++++---------
 arch/x86/include/asm/cacheinfo.h          |  3 --
 arch/x86/include/asm/mpspec.h             |  2 +-
 arch/x86/include/asm/mshyperv.h           |  4 +-
 arch/x86/include/asm/processor.h          | 53 ++++++++++++------
 arch/x86/include/asm/smp.h                |  4 +-
 arch/x86/include/asm/topology.h           | 12 ++---
 arch/x86/include/asm/x86_init.h           |  2 +-
 arch/x86/kernel/acpi/boot.c               |  4 +-
 arch/x86/kernel/amd_nb.c                  |  4 +-
 arch/x86/kernel/apic/apic.c               | 29 ++++++----
 arch/x86/kernel/apic/apic_common.c        |  4 +-
 arch/x86/kernel/apic/apic_flat_64.c       |  8 ++-
 arch/x86/kernel/apic/apic_noop.c          |  8 +--
 arch/x86/kernel/apic/apic_numachip.c      | 16 +++---
 arch/x86/kernel/apic/bigsmp_32.c          |  6 +--
 arch/x86/kernel/apic/ipi.c                |  5 +-
 arch/x86/kernel/apic/local.h              |  7 +--
 arch/x86/kernel/apic/probe_32.c           | 12 ++++-
 arch/x86/kernel/apic/x2apic_phys.c        |  6 +--
 arch/x86/kernel/apic/x2apic_uv_x.c        |  6 +--
 arch/x86/kernel/cpu/Makefile              |  2 +
 arch/x86/kernel/cpu/amd.c                 | 34 ++++++------
 arch/x86/kernel/cpu/cacheinfo.c           | 49 +++++++----------
 arch/x86/kernel/cpu/common.c              | 45 +++++++---------
 arch/x86/kernel/cpu/cpu.h                 |  3 ++
 arch/x86/kernel/cpu/debugfs.c             | 58 ++++++++++++++++++++
 arch/x86/kernel/cpu/hygon.c               | 38 ++++++-------
 arch/x86/kernel/cpu/intel.c               | 13 -----
 arch/x86/kernel/cpu/mce/apei.c            |  4 +-
 arch/x86/kernel/cpu/mce/core.c            |  4 +-
 arch/x86/kernel/cpu/proc.c                |  8 +--
 arch/x86/kernel/cpu/topology.c            | 13 +++--
 arch/x86/kernel/cpu/zhaoxin.c             | 14 -----
 arch/x86/kernel/kvm.c                     |  6 +--
 arch/x86/kernel/sev.c                     |  2 +-
 arch/x86/kernel/smpboot.c                 | 89 ++++++++++++++++++-----------=
--
 arch/x86/kernel/vsmp_64.c                 |  2 +-
 arch/x86/mm/numa.c                        |  4 +-
 arch/x86/xen/apic.c                       | 10 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  2 +-
 drivers/hwmon/fam15h_power.c              |  7 ++-
 drivers/scsi/lpfc/lpfc_init.c             |  8 +--
 drivers/virt/acrn/hsm.c                   |  2 +-
 kernel/cpu.c                              | 18 +++++--
 50 files changed, 372 insertions(+), 317 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/debugfs.c

diff --git a/Documentation/arch/x86/topology.rst b/Documentation/arch/x86/top=
ology.rst
index 7f58010ea86a..08ebf9edbfc1 100644
--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -55,19 +55,19 @@ Package-related topology information in the kernel:
=20
     The number of dies in a package. This information is retrieved via CPUID.
=20
-  - cpuinfo_x86.cpu_die_id:
+  - cpuinfo_x86.topo.die_id:
=20
     The physical ID of the die. This information is retrieved via CPUID.
=20
-  - cpuinfo_x86.phys_proc_id:
+  - cpuinfo_x86.topo.pkg_id:
=20
     The physical ID of the package. This information is retrieved via CPUID
     and deduced from the APIC IDs of the cores in the package.
=20
     Modern systems use this value for the socket. There may be multiple
-    packages within a socket. This value may differ from cpu_die_id.
+    packages within a socket. This value may differ from topo.die_id.
=20
-  - cpuinfo_x86.logical_proc_id:
+  - cpuinfo_x86.topo.logical_pkg_id:
=20
     The logical ID of the package. As we do not trust BIOSes to enumerate the
     packages in a consistent way, we introduced the concept of logical packa=
ge
@@ -79,9 +79,7 @@ Package-related topology information in the kernel:
     The maximum possible number of packages in the system. Helpful for per
     package facilities to preallocate per package information.
=20
-  - cpu_llc_id:
-
-    A per-CPU variable containing:
+  - cpuinfo_x86.topo.llc_id:
=20
       - On Intel, the first APIC ID of the list of CPUs sharing the Last Lev=
el
         Cache
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 83f15fe411b3..3213a39534cd 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -537,7 +537,7 @@ static int amd_uncore_cpu_starting(unsigned int cpu)
=20
 	if (amd_uncore_llc) {
 		uncore =3D *per_cpu_ptr(amd_uncore_llc, cpu);
-		uncore->id =3D get_llc_id(cpu);
+		uncore->id =3D per_cpu_llc_id(cpu);
=20
 		uncore =3D amd_uncore_find_online_sibling(uncore, amd_uncore_llc);
 		*per_cpu_ptr(amd_uncore_llc, cpu) =3D uncore;
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 69043e02e8a7..01023aa5125b 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -74,7 +74,7 @@ int uncore_device_to_die(struct pci_dev *dev)
 		struct cpuinfo_x86 *c =3D &cpu_data(cpu);
=20
 		if (c->initialized && cpu_to_node(cpu) =3D=3D node)
-			return c->logical_die_id;
+			return c->topo.logical_die_id;
 	}
=20
 	return -1;
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 36a562218010..052c5b509a6c 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -196,7 +196,7 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 	return ret;
 }
=20
-static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
+static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 {
 	int vp_id;
=20
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 8c6bf07f7d2b..c6edde1a1dec 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -288,7 +288,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vms=
a)
 		free_page((unsigned long)vmsa);
 }
=20
-int hv_snp_boot_ap(int cpu, unsigned long start_ip)
+int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 {
 	struct sev_es_save_area *vmsa =3D (struct sev_es_save_area *)
 		__get_free_page(GFP_KERNEL | __GFP_ZERO);
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 5af4ec1a0f71..b0d192f613b7 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -54,7 +54,7 @@ extern int local_apic_timer_c2_ok;
 extern bool apic_is_disabled;
 extern unsigned int lapic_timer_period;
=20
-extern int cpuid_to_apicid[];
+extern u32 cpuid_to_apicid[];
=20
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
@@ -292,19 +292,19 @@ struct apic {
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
 	bool	(*apic_id_registered)(void);
=20
-	bool	(*check_apicid_used)(physid_mask_t *map, int apicid);
+	bool	(*check_apicid_used)(physid_mask_t *map, u32 apicid);
 	void	(*init_apic_ldr)(void);
 	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
-	int	(*cpu_present_to_apicid)(int mps_cpu);
-	int	(*phys_pkg_id)(int cpuid_apic, int index_msb);
+	u32	(*cpu_present_to_apicid)(int mps_cpu);
+	u32	(*phys_pkg_id)(u32 cpuid_apic, int index_msb);
=20
-	u32	(*get_apic_id)(unsigned long x);
-	u32	(*set_apic_id)(unsigned int id);
+	u32	(*get_apic_id)(u32 id);
+	u32	(*set_apic_id)(u32 apicid);
=20
 	/* wakeup_secondary_cpu */
-	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
 	/* wakeup secondary CPU using 64-bit wakeup point */
-	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
=20
 	char	*name;
 };
@@ -322,8 +322,8 @@ struct apic_override {
 	void	(*send_IPI_self)(int vector);
 	u64	(*icr_read)(void);
 	void	(*icr_write)(u32 low, u32 high);
-	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
-	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
+	int	(*wakeup_secondary_cpu_64)(u32 apicid, unsigned long start_eip);
 };
=20
 /*
@@ -493,16 +493,6 @@ static inline bool lapic_vector_set_in_irr(unsigned int =
vector)
 	return !!(irr & (1U << (vector % 32)));
 }
=20
-static inline unsigned default_get_apic_id(unsigned long x)
-{
-	unsigned int ver =3D GET_APIC_VERSION(apic_read(APIC_LVR));
-
-	if (APIC_XAPIC(ver) || boot_cpu_has(X86_FEATURE_EXTD_APICID))
-		return (x >> 24) & 0xFF;
-	else
-		return (x >> 24) & 0x0F;
-}
-
 /*
  * Warm reset vector position:
  */
@@ -517,9 +507,9 @@ extern void generic_bigsmp_probe(void);
=20
 extern struct apic apic_noop;
=20
-static inline unsigned int read_apic_id(void)
+static inline u32 read_apic_id(void)
 {
-	unsigned int reg =3D apic_read(APIC_ID);
+	u32 reg =3D apic_read(APIC_ID);
=20
 	return apic->get_apic_id(reg);
 }
@@ -538,13 +528,12 @@ extern int default_apic_id_valid(u32 apicid);
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
=20
-extern bool default_check_apicid_used(physid_mask_t *map, int apicid);
 extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_=
t *retmap);
-extern int default_cpu_present_to_apicid(int mps_cpu);
+extern u32 default_cpu_present_to_apicid(int mps_cpu);
=20
 #else /* CONFIG_X86_LOCAL_APIC */
=20
-static inline unsigned int read_apic_id(void) { return 0; }
+static inline u32 read_apic_id(void) { return 0; }
=20
 #endif /* !CONFIG_X86_LOCAL_APIC */
=20
diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinf=
o.h
index ce9685fc78d8..5aa061199866 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -7,9 +7,6 @@ extern unsigned int memory_caching_control;
 #define CACHE_MTRR 0x01
 #define CACHE_PAT  0x02
=20
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
-void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
-
 void cache_disable(void);
 void cache_enable(void);
 void set_cache_aps_delayed_init(bool val);
diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index f46df8349e86..4b0f98a8d338 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -37,7 +37,7 @@ extern int mp_bus_id_to_type[MAX_MP_BUSSES];
=20
 extern DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
=20
-extern unsigned int boot_cpu_physical_apicid;
+extern u32 boot_cpu_physical_apicid;
 extern u8 boot_cpu_apic_version;
=20
 #ifdef CONFIG_X86_LOCAL_APIC
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 033b53f993c6..a9630e9ad3ab 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -276,11 +276,11 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_=
interrupt_entry *entry);
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
-int hv_snp_boot_ap(int cpu, unsigned long start_ip);
+int hv_snp_boot_ap(u32 cpu, unsigned long start_ip);
 #else
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) =
{}
-static inline int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0=
; }
+static inline int hv_snp_boot_ap(u32 cpu, unsigned long start_ip) { return 0=
; }
 #endif
=20
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index 0086920cda06..ffd03123b739 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -75,11 +75,36 @@ extern u16 __read_mostly tlb_lld_4m[NR_INFO];
 extern u16 __read_mostly tlb_lld_1g[NR_INFO];
=20
 /*
- *  CPU type and hardware bug flags. Kept separately for each CPU.
- *  Members of this structure are referenced in head_32.S, so think twice
- *  before touching them. [mj]
+ * CPU type and hardware bug flags. Kept separately for each CPU.
  */
=20
+struct cpuinfo_topology {
+	// Real APIC ID read from the local APIC
+	u32			apicid;
+	// The initial APIC ID provided by CPUID
+	u32			initial_apicid;
+
+	// Physical package ID
+	u32			pkg_id;
+
+	// Physical die ID on AMD, Relative on Intel
+	u32			die_id;
+
+	// Compute unit ID - AMD specific
+	u32			cu_id;
+
+	// Core ID relative to the package
+	u32			core_id;
+
+	// Logical ID mappings
+	u32			logical_pkg_id;
+	u32			logical_die_id;
+
+	// Cache level topology IDs
+	u32			llc_id;
+	u32			l2c_id;
+};
+
 struct cpuinfo_x86 {
 	__u8			x86;		/* CPU family */
 	__u8			x86_vendor;	/* CPU vendor */
@@ -96,7 +121,6 @@ struct cpuinfo_x86 {
 	__u8			x86_phys_bits;
 	/* CPUID returned core id bits: */
 	__u8			x86_coreid_bits;
-	__u8			cu_id;
 	/* Max extended CPUID function supported: */
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=3Dno CPUID: */
@@ -112,6 +136,7 @@ struct cpuinfo_x86 {
 	};
 	char			x86_vendor_id[16];
 	char			x86_model_id[64];
+	struct cpuinfo_topology	topo;
 	/* in KB - valid for CPUS which support this call: */
 	unsigned int		x86_cache_size;
 	int			x86_cache_alignment;	/* In bytes */
@@ -125,19 +150,9 @@ struct cpuinfo_x86 {
 	u64			ppin;
 	/* cpuid returned max cores value: */
 	u16			x86_max_cores;
-	u16			apicid;
-	u16			initial_apicid;
 	u16			x86_clflush_size;
 	/* number of cores as seen by the OS: */
 	u16			booted_cores;
-	/* Physical processor id: */
-	u16			phys_proc_id;
-	/* Logical processor id: */
-	u16			logical_proc_id;
-	/* Core id: */
-	u16			cpu_core_id;
-	u16			cpu_die_id;
-	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
 	/*  Is SMT active on this core? */
@@ -678,7 +693,15 @@ extern int set_tsc_mode(unsigned int val);
=20
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
=20
-extern u16 get_llc_id(unsigned int cpu);
+static inline u32 per_cpu_llc_id(unsigned int cpu)
+{
+	return per_cpu(cpu_info.topo.llc_id, cpu);
+}
+
+static inline u32 per_cpu_l2c_id(unsigned int cpu)
+{
+	return per_cpu(cpu_info.topo.l2c_id, cpu);
+}
=20
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_nodes_per_socket(void);
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ad98dd1d9cfb..eb74097f4330 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -17,10 +17,8 @@ DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 /* cpus sharing the last level cache: */
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
-DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
-DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
=20
-DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
+DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
=20
 struct task_struct;
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 3235ba1e5b06..5f87f6b9b09e 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -105,17 +105,17 @@ static inline void setup_node_to_cpumask_map(void) { }
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
=20
-#define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
-#define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
-#define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
-#define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
-#define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
+#define topology_logical_package_id(cpu)	(cpu_data(cpu).topo.logical_pkg_id)
+#define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
+#define topology_logical_die_id(cpu)		(cpu_data(cpu).topo.logical_die_id)
+#define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
+#define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
=20
 extern unsigned int __max_die_per_package;
=20
 #ifdef CONFIG_SMP
-#define topology_cluster_id(cpu)		(per_cpu(cpu_l2c_id, cpu))
+#define topology_cluster_id(cpu)		(cpu_data(cpu).topo.l2c_id)
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
 #define topology_cluster_cpumask(cpu)		(cpu_clustergroup_mask(cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 5240d88db52a..c878616a18b8 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -177,7 +177,7 @@ struct x86_init_ops {
  * struct x86_cpuinit_ops - platform specific cpu hotplug setups
  * @setup_percpu_clockev:	set up the per cpu clock event device
  * @early_percpu_clock_init:	early init of the per cpu clock event device
- * @fixup_cpu_id:		fixup function for cpuinfo_x86::phys_proc_id
+ * @fixup_cpu_id:		fixup function for cpuinfo_x86::topo.pkg_id
  * @parallel_bringup:		Parallel bringup control
  */
 struct x86_cpuinit_ops {
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2a0ea38955df..c5450706be76 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -359,7 +359,7 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header=
, const unsigned long e
 }
=20
 #ifdef CONFIG_X86_64
-static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
+static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {
 	/*
 	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
@@ -856,7 +856,7 @@ int acpi_unmap_cpu(int cpu)
 	set_apicid_to_node(per_cpu(x86_cpu_to_apicid, cpu), NUMA_NO_NODE);
 #endif
=20
-	per_cpu(x86_cpu_to_apicid, cpu) =3D -1;
+	per_cpu(x86_cpu_to_apicid, cpu) =3D BAD_APICID;
 	set_cpu_present(cpu, false);
 	num_processors--;
=20
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 356de955e78d..75df3c8712fc 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -386,7 +386,7 @@ int amd_get_subcaches(int cpu)
=20
 	pci_read_config_dword(link, 0x1d4, &mask);
=20
-	return (mask >> (4 * cpu_data(cpu).cpu_core_id)) & 0xf;
+	return (mask >> (4 * cpu_data(cpu).topo.core_id)) & 0xf;
 }
=20
 int amd_set_subcaches(int cpu, unsigned long mask)
@@ -412,7 +412,7 @@ int amd_set_subcaches(int cpu, unsigned long mask)
 		pci_write_config_dword(nb->misc, 0x1b8, reg & ~0x180000);
 	}
=20
-	cuid =3D cpu_data(cpu).cpu_core_id;
+	cuid =3D cpu_data(cpu).topo.core_id;
 	mask <<=3D 4 * cuid;
 	mask |=3D (0xf ^ (1 << cuid)) << 26;
=20
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 760adac3d1a8..41093cf20acd 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -36,6 +36,8 @@
 #include <linux/smp.h>
 #include <linux/mm.h>
=20
+#include <xen/xen.h>
+
 #include <asm/trace/irq_vectors.h>
 #include <asm/irq_remapping.h>
 #include <asm/pc-conf-reg.h>
@@ -70,7 +72,7 @@ unsigned int num_processors;
 unsigned disabled_cpus;
=20
 /* Processor that is doing the boot up */
-unsigned int boot_cpu_physical_apicid __ro_after_init =3D -1U;
+u32 boot_cpu_physical_apicid __ro_after_init =3D BAD_APICID;
 EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
=20
 u8 boot_cpu_apic_version __ro_after_init;
@@ -85,7 +87,7 @@ physid_mask_t phys_cpu_present_map;
  * disable_cpu_apicid=3D<int>, mostly used for the kdump 2nd kernel to
  * avoid undefined behaviour caused by sending INIT from AP to BSP.
  */
-static unsigned int disabled_cpu_apicid __ro_after_init =3D BAD_APICID;
+static u32 disabled_cpu_apicid __ro_after_init =3D BAD_APICID;
=20
 /*
  * This variable controls which CPUs receive external NMIs.  By default,
@@ -109,7 +111,7 @@ static inline bool apic_accessible(void)
 /*
  * Map cpu index to physical APIC ID
  */
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, U32_MAX);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
@@ -1763,7 +1765,7 @@ static void __x2apic_enable(void)
 static int __init setup_nox2apic(char *str)
 {
 	if (x2apic_enabled()) {
-		int apicid =3D native_apic_msr_read(APIC_ID);
+		u32 apicid =3D native_apic_msr_read(APIC_ID);
=20
 		if (apicid >=3D 255) {
 			pr_warn("Apicid: %08x, cannot enforce nox2apic\n",
@@ -2316,13 +2318,11 @@ static int nr_logical_cpuids =3D 1;
 /*
  * Used to store mapping between logical CPU IDs and APIC IDs.
  */
-int cpuid_to_apicid[] =3D {
-	[0 ... NR_CPUS - 1] =3D -1,
-};
+u32 cpuid_to_apicid[] =3D { [0 ... NR_CPUS - 1] =3D BAD_APICID, };
=20
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
-	return phys_id =3D=3D cpuid_to_apicid[cpu];
+	return phys_id =3D=3D (u64)cpuid_to_apicid[cpu];
 }
=20
 #ifdef CONFIG_SMP
@@ -2344,6 +2344,15 @@ static int __init smp_init_primary_thread_mask(void)
 {
 	unsigned int cpu;
=20
+	/*
+	 * XEN/PV provides either none or useless topology information.
+	 * Pretend that all vCPUs are primary threads.
+	 */
+	if (xen_pv_domain()) {
+		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
+		return 0;
+	}
+
 	for (cpu =3D 0; cpu < nr_logical_cpuids; cpu++)
 		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
 	return 0;
@@ -2382,7 +2391,7 @@ static int allocate_logical_cpuid(int apicid)
 	return nr_logical_cpuids++;
 }
=20
-static void cpu_update_apic(int cpu, int apicid)
+static void cpu_update_apic(int cpu, u32 apicid)
 {
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) =3D apicid;
@@ -2535,7 +2544,7 @@ static struct {
 	 */
 	int active;
 	/* r/w apic fields */
-	unsigned int apic_id;
+	u32 apic_id;
 	unsigned int apic_taskpri;
 	unsigned int apic_ldr;
 	unsigned int apic_dfr;
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_c=
ommon.c
index 7bc5d9bf59cd..8a00141073ea 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -18,7 +18,7 @@ u32 apic_flat_calc_apicid(unsigned int cpu)
 	return 1U << cpu;
 }
=20
-bool default_check_apicid_used(physid_mask_t *map, int apicid)
+bool default_check_apicid_used(physid_mask_t *map, u32 apicid)
 {
 	return physid_isset(apicid, *map);
 }
@@ -28,7 +28,7 @@ void default_ioapic_phys_id_map(physid_mask_t *phys_map, ph=
ysid_mask_t *retmap)
 	*retmap =3D *phys_map;
 }
=20
-int default_cpu_present_to_apicid(int mps_cpu)
+u32 default_cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < nr_cpu_ids && cpu_present(mps_cpu))
 		return (int)per_cpu(x86_cpu_to_apicid, mps_cpu);
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_=
flat_64.c
index 032a84e2c3cc..37daa3fd6819 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -56,17 +56,17 @@ flat_send_IPI_mask_allbutself(const struct cpumask *cpuma=
sk, int vector)
 	_flat_send_IPI_mask(mask, vector);
 }
=20
-static unsigned int flat_get_apic_id(unsigned long x)
+static u32 flat_get_apic_id(u32 x)
 {
 	return (x >> 24) & 0xFF;
 }
=20
-static u32 set_apic_id(unsigned int id)
+static u32 set_apic_id(u32 id)
 {
 	return (id & 0xFF) << 24;
 }
=20
-static int flat_phys_pkg_id(int initial_apic_id, int index_msb)
+static u32 flat_phys_pkg_id(u32 initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
 }
@@ -158,8 +158,6 @@ static struct apic apic_physflat __ro_after_init =3D {
=20
 	.disable_esr			=3D 0,
=20
-	.check_apicid_used		=3D NULL,
-	.ioapic_phys_id_map		=3D NULL,
 	.cpu_present_to_apicid		=3D default_cpu_present_to_apicid,
 	.phys_pkg_id			=3D flat_phys_pkg_id,
=20
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noo=
p.c
index 966d7cf10b95..b00d52ae84fa 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -18,6 +18,8 @@
=20
 #include <asm/apic.h>
=20
+#include "local.h"
+
 static void noop_send_IPI(int cpu, int vector) { }
 static void noop_send_IPI_mask(const struct cpumask *cpumask, int vector) { }
 static void noop_send_IPI_mask_allbutself(const struct cpumask *cpumask, int=
 vector) { }
@@ -25,10 +27,10 @@ static void noop_send_IPI_allbutself(int vector) { }
 static void noop_send_IPI_all(int vector) { }
 static void noop_send_IPI_self(int vector) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
-static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { =
return -1; }
+static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { =
return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
-static int noop_phys_pkg_id(int cpuid_apic, int index_msb) { return 0; }
-static unsigned int noop_get_apic_id(unsigned long x) { return 0; }
+static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
+static u32 noop_get_apic_id(u32 apicid) { return 0; }
 static void noop_apic_eoi(void) { }
=20
 static u32 noop_apic_read(u32 reg)
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic=
_numachip.c
index 63f3d7be9dc7..456a14c44f67 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -25,7 +25,7 @@ static const struct apic apic_numachip1;
 static const struct apic apic_numachip2;
 static void (*numachip_apic_icr_write)(int apicid, unsigned int val) __read_=
mostly;
=20
-static unsigned int numachip1_get_apic_id(unsigned long x)
+static u32 numachip1_get_apic_id(u32 x)
 {
 	unsigned long value;
 	unsigned int id =3D (x >> 24) & 0xff;
@@ -38,12 +38,12 @@ static unsigned int numachip1_get_apic_id(unsigned long x)
 	return id;
 }
=20
-static u32 numachip1_set_apic_id(unsigned int id)
+static u32 numachip1_set_apic_id(u32 id)
 {
 	return (id & 0xff) << 24;
 }
=20
-static unsigned int numachip2_get_apic_id(unsigned long x)
+static u32 numachip2_get_apic_id(u32 x)
 {
 	u64 mcfg;
=20
@@ -51,12 +51,12 @@ static unsigned int numachip2_get_apic_id(unsigned long x)
 	return ((mcfg >> (28 - 8)) & 0xfff00) | (x >> 24);
 }
=20
-static u32 numachip2_set_apic_id(unsigned int id)
+static u32 numachip2_set_apic_id(u32 id)
 {
 	return id << 24;
 }
=20
-static int numachip_phys_pkg_id(int initial_apic_id, int index_msb)
+static u32 numachip_phys_pkg_id(u32 initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
 }
@@ -71,7 +71,7 @@ static void numachip2_apic_icr_write(int apicid, unsigned i=
nt val)
 	numachip2_write32_lcsr(NUMACHIP2_APIC_ICR, (apicid << 12) | val);
 }
=20
-static int numachip_wakeup_secondary(int phys_apicid, unsigned long start_ri=
p)
+static int numachip_wakeup_secondary(u32 phys_apicid, unsigned long start_ri=
p)
 {
 	numachip_apic_icr_write(phys_apicid, APIC_DM_INIT);
 	numachip_apic_icr_write(phys_apicid, APIC_DM_STARTUP |
@@ -161,7 +161,7 @@ static void fixup_cpu_id(struct cpuinfo_x86 *c, int node)
 	u64 val;
 	u32 nodes =3D 1;
=20
-	this_cpu_write(cpu_llc_id, node);
+	c->topo.llc_id =3D node;
=20
 	/* Account for nodes per socket in multi-core-module processors */
 	if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
@@ -169,7 +169,7 @@ static void fixup_cpu_id(struct cpuinfo_x86 *c, int node)
 		nodes =3D ((val >> 3) & 7) + 1;
 	}
=20
-	c->phys_proc_id =3D node / nodes;
+	c->topo.pkg_id =3D node / nodes;
 }
=20
 static int __init numachip_system_init(void)
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_3=
2.c
index 0e5535add4b5..7ee3c486cb33 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -13,12 +13,12 @@
=20
 #include "local.h"
=20
-static unsigned bigsmp_get_apic_id(unsigned long x)
+static u32 bigsmp_get_apic_id(u32 x)
 {
 	return (x >> 24) & 0xFF;
 }
=20
-static bool bigsmp_check_apicid_used(physid_mask_t *map, int apicid)
+static bool bigsmp_check_apicid_used(physid_mask_t *map, u32 apicid)
 {
 	return false;
 }
@@ -29,7 +29,7 @@ static void bigsmp_ioapic_phys_id_map(physid_mask_t *phys_m=
ap, physid_mask_t *re
 	physids_promote(0xFFL, retmap);
 }
=20
-static int bigsmp_phys_pkg_id(int cpuid_apic, int index_msb)
+static u32 bigsmp_phys_pkg_id(u32 cpuid_apic, int index_msb)
 {
 	return cpuid_apic >> index_msb;
 }
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index a44ba7209ef3..0078730a512e 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -281,7 +281,7 @@ void default_send_IPI_mask_logical(const struct cpumask *=
cpumask, int vector)
 }
=20
 #ifdef CONFIG_SMP
-static int convert_apicid_to_cpu(int apic_id)
+static int convert_apicid_to_cpu(u32 apic_id)
 {
 	int i;
=20
@@ -294,7 +294,8 @@ static int convert_apicid_to_cpu(int apic_id)
=20
 int safe_smp_processor_id(void)
 {
-	int apicid, cpuid;
+	u32 apicid;
+	int cpuid;
=20
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return 0;
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index ec219c659c7d..9ea6186ea88c 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -15,9 +15,9 @@
=20
 /* X2APIC */
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int de=
st);
-unsigned int x2apic_get_apic_id(unsigned long id);
-u32 x2apic_set_apic_id(unsigned int id);
-int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
+u32 x2apic_get_apic_id(u32 id);
+u32 x2apic_set_apic_id(u32 id);
+u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb);
=20
 void x2apic_send_IPI_all(int vector);
 void x2apic_send_IPI_allbutself(int vector);
@@ -64,6 +64,7 @@ void default_send_IPI_all(int vector);
 void default_send_IPI_self(int vector);
=20
 bool default_apic_id_registered(void);
+bool default_check_apicid_used(physid_mask_t *map, u32 apicid);
=20
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int =
vector);
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 9a06df6cdd68..5eb3fbe472da 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -18,11 +18,21 @@
=20
 #include "local.h"
=20
-static int default_phys_pkg_id(int cpuid_apic, int index_msb)
+static u32 default_phys_pkg_id(u32 cpuid_apic, int index_msb)
 {
 	return cpuid_apic >> index_msb;
 }
=20
+static u32 default_get_apic_id(u32 x)
+{
+	unsigned int ver =3D GET_APIC_VERSION(apic_read(APIC_LVR));
+
+	if (APIC_XAPIC(ver) || boot_cpu_has(X86_FEATURE_EXTD_APICID))
+		return (x >> 24) & 0xFF;
+	else
+		return (x >> 24) & 0x0F;
+}
+
 /* should be called last. */
 static int probe_default(void)
 {
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic=
_phys.c
index 788cdb4ee394..7c9fe28f742f 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -124,17 +124,17 @@ static int x2apic_phys_probe(void)
 	return apic =3D=3D &apic_x2apic_phys;
 }
=20
-unsigned int x2apic_get_apic_id(unsigned long id)
+u32 x2apic_get_apic_id(u32 id)
 {
 	return id;
 }
=20
-u32 x2apic_set_apic_id(unsigned int id)
+u32 x2apic_set_apic_id(u32 id)
 {
 	return id;
 }
=20
-int x2apic_phys_pkg_id(int initial_apicid, int index_msb)
+u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb)
 {
 	return initial_apicid >> index_msb;
 }
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic=
_uv_x.c
index d9f5d7492f83..6efc499d5c14 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -701,7 +701,7 @@ static __init void build_uv_gr_table(void)
 	}
 }
=20
-static int uv_wakeup_secondary(int phys_apicid, unsigned long start_rip)
+static int uv_wakeup_secondary(u32 phys_apicid, unsigned long start_rip)
 {
 	unsigned long val;
 	int pnode;
@@ -779,7 +779,7 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
=20
-static u32 set_apic_id(unsigned int id)
+static u32 set_apic_id(u32 id)
 {
 	return id;
 }
@@ -789,7 +789,7 @@ static unsigned int uv_read_apic_id(void)
 	return x2apic_get_apic_id(apic_read(APIC_ID));
 }
=20
-static int uv_phys_pkg_id(int initial_apicid, int index_msb)
+static u32 uv_phys_pkg_id(u32 initial_apicid, int index_msb)
 {
 	return uv_read_apic_id() >> index_msb;
 }
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 4350f6bfc064..93eabf544031 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -54,6 +54,8 @@ obj-$(CONFIG_X86_LOCAL_APIC)		+=3D perfctr-watchdog.o
 obj-$(CONFIG_HYPERVISOR_GUEST)		+=3D vmware.o hypervisor.o mshyperv.o
 obj-$(CONFIG_ACRN_GUEST)		+=3D acrn.o
=20
+obj-$(CONFIG_DEBUG_FS)			+=3D debugfs.o
+
 quiet_cmd_mkcapflags =3D MKCAP   $@
       cmd_mkcapflags =3D $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $@ =
$^
=20
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index dd8379d84445..2cf4cb165dd9 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -378,7 +378,7 @@ static int nearby_node(int apicid)
 #endif
=20
 /*
- * Fix up cpu_core_id for pre-F17h systems to be in the
+ * Fix up topo::core_id for pre-F17h systems to be in the
  * [0 .. cores_per_node - 1] range. Not really needed but
  * kept so as not to break existing setups.
  */
@@ -390,7 +390,7 @@ static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
 		return;
=20
 	cus_per_node =3D c->x86_max_cores / nodes_per_socket;
-	c->cpu_core_id %=3D cus_per_node;
+	c->topo.core_id %=3D cus_per_node;
 }
=20
 /*
@@ -401,8 +401,6 @@ static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
  */
 static void amd_get_topology(struct cpuinfo_x86 *c)
 {
-	int cpu =3D smp_processor_id();
-
 	/* get information required for multi-node processors */
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
 		int err;
@@ -410,13 +408,13 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
=20
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
=20
-		c->cpu_die_id  =3D ecx & 0xff;
+		c->topo.die_id  =3D ecx & 0xff;
=20
 		if (c->x86 =3D=3D 0x15)
-			c->cu_id =3D ebx & 0xff;
+			c->topo.cu_id =3D ebx & 0xff;
=20
 		if (c->x86 >=3D 0x17) {
-			c->cpu_core_id =3D ebx & 0xff;
+			c->topo.core_id =3D ebx & 0xff;
=20
 			if (smp_num_siblings > 1)
 				c->x86_max_cores /=3D smp_num_siblings;
@@ -430,15 +428,14 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits =3D get_count_order(c->x86_max_cores);
=20
-		cacheinfo_amd_init_llc_id(c, cpu);
+		cacheinfo_amd_init_llc_id(c);
=20
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
=20
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->cpu_die_id =3D value & 7;
-
-		per_cpu(cpu_llc_id, cpu) =3D c->cpu_die_id;
+		c->topo.die_id =3D value & 7;
+		c->topo.llc_id =3D c->topo.die_id;
 	} else
 		return;
=20
@@ -455,15 +452,14 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 static void amd_detect_cmp(struct cpuinfo_x86 *c)
 {
 	unsigned bits;
-	int cpu =3D smp_processor_id();
=20
 	bits =3D c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
-	c->cpu_core_id =3D c->initial_apicid & ((1 << bits)-1);
+	c->topo.core_id =3D c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
-	c->phys_proc_id =3D c->initial_apicid >> bits;
+	c->topo.pkg_id =3D c->topo.initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) =3D c->cpu_die_id =3D c->phys_proc_id;
+	c->topo.llc_id =3D c->topo.die_id =3D c->topo.pkg_id;
 }
=20
 u32 amd_get_nodes_per_socket(void)
@@ -477,11 +473,11 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #ifdef CONFIG_NUMA
 	int cpu =3D smp_processor_id();
 	int node;
-	unsigned apicid =3D c->apicid;
+	unsigned apicid =3D c->topo.apicid;
=20
 	node =3D numa_cpu_node(cpu);
 	if (node =3D=3D NUMA_NO_NODE)
-		node =3D get_llc_id(cpu);
+		node =3D per_cpu_llc_id(cpu);
=20
 	/*
 	 * On multi-fabric platform (e.g. Numascale NumaChip) a
@@ -511,7 +507,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 		 * through CPU mapping may alter the outcome, directly
 		 * access __apicid_to_node[].
 		 */
-		int ht_nodeid =3D c->initial_apicid;
+		int ht_nodeid =3D c->topo.initial_apicid;
=20
 		if (__apicid_to_node[ht_nodeid] !=3D NUMA_NO_NODE)
 			node =3D __apicid_to_node[ht_nodeid];
@@ -1047,7 +1043,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_FSRS);
=20
 	/* get apicid instead of initial apic id from cpuid */
-	c->apicid =3D read_apic_id();
+	c->topo.apicid =3D read_apic_id();
=20
 	/* K6s reports MCEs but don't actually have all the MSRs */
 	if (c->x86 < 6)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 8f86eacf69f7..c131c412db89 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -661,7 +661,7 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
=20
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
@@ -672,13 +672,13 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, i=
nt cpu)
=20
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
-		per_cpu(cpu_llc_id, cpu) =3D c->cpu_die_id;
+		c->topo.llc_id =3D c->topo.die_id;
 	} else if (c->x86 =3D=3D 0x17 && c->x86_model <=3D 0x1F) {
 		/*
 		 * LLC is at the core complex level.
 		 * Core complex ID is ApicId[3] for these processors.
 		 */
-		per_cpu(cpu_llc_id, cpu) =3D c->apicid >> 3;
+		c->topo.llc_id =3D c->topo.apicid >> 3;
 	} else {
 		/*
 		 * LLC ID is calculated from the number of threads sharing the
@@ -694,12 +694,12 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, i=
nt cpu)
 		if (num_sharing_cache) {
 			int bits =3D get_count_order(num_sharing_cache);
=20
-			per_cpu(cpu_llc_id, cpu) =3D c->apicid >> bits;
+			c->topo.llc_id =3D c->topo.apicid >> bits;
 		}
 	}
 }
=20
-void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu)
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
@@ -712,7 +712,7 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, i=
nt cpu)
 	 * LLC is at the core complex level.
 	 * Core complex ID is ApicId[3] for these processors.
 	 */
-	per_cpu(cpu_llc_id, cpu) =3D c->apicid >> 3;
+	c->topo.llc_id =3D c->topo.apicid >> 3;
 }
=20
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
@@ -740,9 +740,6 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	unsigned int new_l1d =3D 0, new_l1i =3D 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 =3D 0, new_l3 =3D 0, i; /* Cache sizes from cpuid(4) */
 	unsigned int l2_id =3D 0, l3_id =3D 0, num_threads_sharing, index_msb;
-#ifdef CONFIG_SMP
-	unsigned int cpu =3D c->cpu_index;
-#endif
=20
 	if (c->cpuid_level > 3) {
 		static int is_initialized;
@@ -776,13 +773,13 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 				new_l2 =3D this_leaf.size/1024;
 				num_threads_sharing =3D 1 + this_leaf.eax.split.num_threads_sharing;
 				index_msb =3D get_count_order(num_threads_sharing);
-				l2_id =3D c->apicid & ~((1 << index_msb) - 1);
+				l2_id =3D c->topo.apicid & ~((1 << index_msb) - 1);
 				break;
 			case 3:
 				new_l3 =3D this_leaf.size/1024;
 				num_threads_sharing =3D 1 + this_leaf.eax.split.num_threads_sharing;
 				index_msb =3D get_count_order(num_threads_sharing);
-				l3_id =3D c->apicid & ~((1 << index_msb) - 1);
+				l3_id =3D c->topo.apicid & ~((1 << index_msb) - 1);
 				break;
 			default:
 				break;
@@ -856,30 +853,24 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
=20
 	if (new_l2) {
 		l2 =3D new_l2;
-#ifdef CONFIG_SMP
-		per_cpu(cpu_llc_id, cpu) =3D l2_id;
-		per_cpu(cpu_l2c_id, cpu) =3D l2_id;
-#endif
+		c->topo.llc_id =3D l2_id;
+		c->topo.l2c_id =3D l2_id;
 	}
=20
 	if (new_l3) {
 		l3 =3D new_l3;
-#ifdef CONFIG_SMP
-		per_cpu(cpu_llc_id, cpu) =3D l3_id;
-#endif
+		c->topo.llc_id =3D l3_id;
 	}
=20
-#ifdef CONFIG_SMP
 	/*
-	 * If cpu_llc_id is not yet set, this means cpuid_level < 4 which in
+	 * If llc_id is not yet set, this means cpuid_level < 4 which in
 	 * turns means that the only possibility is SMT (as indicated in
 	 * cpuid1). Since cpuid2 doesn't specify shared caches, and we know
 	 * that SMT shares all caches, we can unconditionally set cpu_llc_id to
-	 * c->phys_proc_id.
+	 * c->topo.pkg_id.
 	 */
-	if (per_cpu(cpu_llc_id, cpu) =3D=3D BAD_APICID)
-		per_cpu(cpu_llc_id, cpu) =3D c->phys_proc_id;
-#endif
+	if (c->topo.llc_id =3D=3D BAD_APICID)
+		c->topo.llc_id =3D c->topo.pkg_id;
=20
 	c->x86_cache_size =3D l3 ? l3 : (l2 ? l2 : (l1i+l1d));
=20
@@ -915,7 +906,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int=
 index,
 		unsigned int apicid, nshared, first, last;
=20
 		nshared =3D base->eax.split.num_threads_sharing + 1;
-		apicid =3D cpu_data(cpu).apicid;
+		apicid =3D cpu_data(cpu).topo.apicid;
 		first =3D apicid - (apicid % nshared);
 		last =3D first + nshared - 1;
=20
@@ -924,14 +915,14 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, i=
nt index,
 			if (!this_cpu_ci->info_list)
 				continue;
=20
-			apicid =3D cpu_data(i).apicid;
+			apicid =3D cpu_data(i).topo.apicid;
 			if ((apicid < first) || (apicid > last))
 				continue;
=20
 			this_leaf =3D this_cpu_ci->info_list + index;
=20
 			for_each_online_cpu(sibling) {
-				apicid =3D cpu_data(sibling).apicid;
+				apicid =3D cpu_data(sibling).topo.apicid;
 				if ((apicid < first) || (apicid > last))
 					continue;
 				cpumask_set_cpu(sibling,
@@ -969,7 +960,7 @@ static void __cache_cpumap_setup(unsigned int cpu, int in=
dex,
 	index_msb =3D get_count_order(num_threads_sharing);
=20
 	for_each_online_cpu(i)
-		if (cpu_data(i).apicid >> index_msb =3D=3D c->apicid >> index_msb) {
+		if (cpu_data(i).topo.apicid >> index_msb =3D=3D c->topo.apicid >> index_ms=
b) {
 			struct cpu_cacheinfo *sib_cpu_ci =3D get_cpu_cacheinfo(i);
=20
 			if (i =3D=3D cpu || !sib_cpu_ci->info_list)
@@ -1024,7 +1015,7 @@ static void get_cache_id(int cpu, struct _cpuid4_info_r=
egs *id4_regs)
=20
 	num_threads_sharing =3D 1 + id4_regs->eax.split.num_threads_sharing;
 	index_msb =3D get_count_order(num_threads_sharing);
-	id4_regs->id =3D c->apicid >> index_msb;
+	id4_regs->id =3D c->topo.apicid >> index_msb;
 }
=20
 int populate_cache_leaves(unsigned int cpu)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 382d4e6b848d..62919adf2258 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -74,18 +74,6 @@ u32 elf_hwcap2 __read_mostly;
 int smp_num_siblings =3D 1;
 EXPORT_SYMBOL(smp_num_siblings);
=20
-/* Last level cache ID of each logical CPU */
-DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) =3D BAD_APICID;
-
-u16 get_llc_id(unsigned int cpu)
-{
-	return per_cpu(cpu_llc_id, cpu);
-}
-EXPORT_SYMBOL_GPL(get_llc_id);
-
-/* L2 cache ID of each logical CPU */
-DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) =3D BAD_APICID;
-
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
@@ -914,7 +902,7 @@ void detect_ht(struct cpuinfo_x86 *c)
 		return;
=20
 	index_msb =3D get_count_order(smp_num_siblings);
-	c->phys_proc_id =3D apic->phys_pkg_id(c->initial_apicid, index_msb);
+	c->topo.pkg_id =3D apic->phys_pkg_id(c->topo.initial_apicid, index_msb);
=20
 	smp_num_siblings =3D smp_num_siblings / c->x86_max_cores;
=20
@@ -922,8 +910,8 @@ void detect_ht(struct cpuinfo_x86 *c)
=20
 	core_bits =3D get_count_order(c->x86_max_cores);
=20
-	c->cpu_core_id =3D apic->phys_pkg_id(c->initial_apicid, index_msb) &
-				       ((1 << core_bits) - 1);
+	c->topo.core_id =3D apic->phys_pkg_id(c->topo.initial_apicid, index_msb) &
+		((1 << core_bits) - 1);
 #endif
 }
=20
@@ -1761,15 +1749,15 @@ static void generic_identify(struct cpuinfo_x86 *c)
 	get_cpu_address_sizes(c);
=20
 	if (c->cpuid_level >=3D 0x00000001) {
-		c->initial_apicid =3D (cpuid_ebx(1) >> 24) & 0xFF;
+		c->topo.initial_apicid =3D (cpuid_ebx(1) >> 24) & 0xFF;
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_SMP
-		c->apicid =3D apic->phys_pkg_id(c->initial_apicid, 0);
+		c->topo.apicid =3D apic->phys_pkg_id(c->topo.initial_apicid, 0);
 # else
-		c->apicid =3D c->initial_apicid;
+		c->topo.apicid =3D c->topo.initial_apicid;
 # endif
 #endif
-		c->phys_proc_id =3D c->initial_apicid;
+		c->topo.pkg_id =3D c->topo.initial_apicid;
 	}
=20
 	get_model_name(c); /* Default name */
@@ -1799,18 +1787,19 @@ static void generic_identify(struct cpuinfo_x86 *c)
 static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
-	unsigned int apicid, cpu =3D smp_processor_id();
+	unsigned int cpu =3D smp_processor_id();
+	u32 apicid;
=20
 	apicid =3D apic->cpu_present_to_apicid(cpu);
=20
-	if (apicid !=3D c->apicid) {
+	if (apicid !=3D c->topo.apicid) {
 		pr_err(FW_BUG "CPU%u: APIC id mismatch. Firmware: %x APIC: %x\n",
-		       cpu, apicid, c->initial_apicid);
+		       cpu, apicid, c->topo.initial_apicid);
 	}
-	BUG_ON(topology_update_package_map(c->phys_proc_id, cpu));
-	BUG_ON(topology_update_die_map(c->cpu_die_id, cpu));
+	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
+	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
 #else
-	c->logical_proc_id =3D 0;
+	c->topo.logical_pkg_id =3D 0;
 #endif
 }
=20
@@ -1829,7 +1818,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->x86_model_id[0] =3D '\0';  /* Unset */
 	c->x86_max_cores =3D 1;
 	c->x86_coreid_bits =3D 0;
-	c->cu_id =3D 0xff;
+	c->topo.cu_id =3D 0xff;
+	c->topo.llc_id =3D BAD_APICID;
+	c->topo.l2c_id =3D BAD_APICID;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size =3D 64;
 	c->x86_phys_bits =3D 36;
@@ -1855,7 +1846,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	apply_forced_caps(c);
=20
 #ifdef CONFIG_X86_64
-	c->apicid =3D apic->phys_pkg_id(c->initial_apicid, 0);
+	c->topo.apicid =3D apic->phys_pkg_id(c->topo.initial_apicid, 0);
 #endif
=20
 	/*
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 1dcd7d4e38ef..885281ae79a5 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -78,6 +78,9 @@ extern int detect_ht_early(struct cpuinfo_x86 *c);
 extern void detect_ht(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
=20
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c);
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c);
+
 unsigned int aperfmperf_get_khz(int cpu);
 void cpu_select_mitigations(void);
=20
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
new file mode 100644
index 000000000000..0c179d684b3b
--- /dev/null
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/debugfs.h>
+
+#include <asm/apic.h>
+#include <asm/processor.h>
+
+static int cpu_debug_show(struct seq_file *m, void *p)
+{
+	unsigned long cpu =3D (unsigned long)m->private;
+	struct cpuinfo_x86 *c =3D per_cpu_ptr(&cpu_info, cpu);
+
+	seq_printf(m, "online:              %d\n", cpu_online(cpu));
+	if (!c->initialized)
+		return 0;
+
+	seq_printf(m, "initial_apicid:      %x\n", c->topo.initial_apicid);
+	seq_printf(m, "apicid:              %x\n", c->topo.apicid);
+	seq_printf(m, "pkg_id:              %u\n", c->topo.pkg_id);
+	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
+	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
+	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
+	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
+	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
+	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
+	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
+	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
+	seq_printf(m, "max_die_per_pkg:     %u\n", __max_die_per_package);
+	seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
+	return 0;
+}
+
+static int cpu_debug_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cpu_debug_show, inode->i_private);
+}
+
+static const struct file_operations dfs_cpu_ops =3D {
+	.open		=3D cpu_debug_open,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+static __init int cpu_init_debugfs(void)
+{
+	struct dentry *dir, *base =3D debugfs_create_dir("topo", arch_debugfs_dir);
+	unsigned long id;
+	char name[24];
+
+	dir =3D debugfs_create_dir("cpus", base);
+	for_each_possible_cpu(id) {
+		sprintf(name, "%lu", id);
+		debugfs_create_file(name, 0444, dir, (void *)id, &dfs_cpu_ops);
+	}
+	return 0;
+}
+late_initcall(cpu_init_debugfs);
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index defdc594be14..332c298afd96 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -63,8 +63,6 @@ static void hygon_get_topology_early(struct cpuinfo_x86 *c)
  */
 static void hygon_get_topology(struct cpuinfo_x86 *c)
 {
-	int cpu =3D smp_processor_id();
-
 	/* get information required for multi-node processors */
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
 		int err;
@@ -72,9 +70,9 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
=20
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
=20
-		c->cpu_die_id  =3D ecx & 0xff;
+		c->topo.die_id  =3D ecx & 0xff;
=20
-		c->cpu_core_id =3D ebx & 0xff;
+		c->topo.core_id =3D ebx & 0xff;
=20
 		if (smp_num_siblings > 1)
 			c->x86_max_cores /=3D smp_num_siblings;
@@ -87,17 +85,20 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits =3D get_count_order(c->x86_max_cores);
=20
-		/* Socket ID is ApicId[6] for these processors. */
-		c->phys_proc_id =3D c->apicid >> APICID_SOCKET_ID_BIT;
+		/*
+		 * Socket ID is ApicId[6] for the processors with model <=3D 0x3
+		 * when running on host.
+		 */
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && c->x86_model <=3D 0x3)
+			c->topo.pkg_id =3D c->topo.apicid >> APICID_SOCKET_ID_BIT;
=20
-		cacheinfo_hygon_init_llc_id(c, cpu);
+		cacheinfo_hygon_init_llc_id(c);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
=20
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->cpu_die_id =3D value & 7;
-
-		per_cpu(cpu_llc_id, cpu) =3D c->cpu_die_id;
+		c->topo.die_id =3D value & 7;
+		c->topo.llc_id =3D c->topo.die_id;
 	} else
 		return;
=20
@@ -112,15 +113,14 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 static void hygon_detect_cmp(struct cpuinfo_x86 *c)
 {
 	unsigned int bits;
-	int cpu =3D smp_processor_id();
=20
 	bits =3D c->x86_coreid_bits;
 	/* Low order bits define the core id (index of core in socket) */
-	c->cpu_core_id =3D c->initial_apicid & ((1 << bits)-1);
+	c->topo.core_id =3D c->topo.initial_apicid & ((1 << bits)-1);
 	/* Convert the initial APIC ID into the socket ID */
-	c->phys_proc_id =3D c->initial_apicid >> bits;
-	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) =3D c->cpu_die_id =3D c->phys_proc_id;
+	c->topo.pkg_id =3D c->topo.initial_apicid >> bits;
+	/* Use package ID also for last level cache */
+	c->topo.llc_id =3D c->topo.die_id =3D c->topo.pkg_id;
 }
=20
 static void srat_detect_node(struct cpuinfo_x86 *c)
@@ -128,11 +128,11 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #ifdef CONFIG_NUMA
 	int cpu =3D smp_processor_id();
 	int node;
-	unsigned int apicid =3D c->apicid;
+	unsigned int apicid =3D c->topo.apicid;
=20
 	node =3D numa_cpu_node(cpu);
 	if (node =3D=3D NUMA_NO_NODE)
-		node =3D per_cpu(cpu_llc_id, cpu);
+		node =3D c->topo.llc_id;
=20
 	/*
 	 * On multi-fabric platform (e.g. Numascale NumaChip) a
@@ -161,7 +161,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 		 * through CPU mapping may alter the outcome, directly
 		 * access __apicid_to_node[].
 		 */
-		int ht_nodeid =3D c->initial_apicid;
+		int ht_nodeid =3D c->topo.initial_apicid;
=20
 		if (__apicid_to_node[ht_nodeid] !=3D NUMA_NO_NODE)
 			node =3D __apicid_to_node[ht_nodeid];
@@ -301,7 +301,7 @@ static void init_hygon(struct cpuinfo_x86 *c)
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
=20
 	/* get apicid instead of initial apic id from cpuid */
-	c->apicid =3D read_apic_id();
+	c->topo.apicid =3D read_apic_id();
=20
 	/*
 	 * XXX someone from Hygon needs to confirm this DTRT
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index be4045628fd3..55efadb0e998 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -314,19 +314,6 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		setup_clear_cpu_cap(X86_FEATURE_PGE);
 	}
=20
-	if (c->cpuid_level >=3D 0x00000001) {
-		u32 eax, ebx, ecx, edx;
-
-		cpuid(0x00000001, &eax, &ebx, &ecx, &edx);
-		/*
-		 * If HTT (EDX[28]) is set EBX[16:23] contain the number of
-		 * apicids which are reserved per package. Store the resulting
-		 * shift value for the package management code.
-		 */
-		if (edx & (1U << 28))
-			c->x86_coreid_bits =3D get_count_order((ebx >> 16) & 0xff);
-	}
-
 	check_memory_type_self_snoop_errata(c);
=20
 	/*
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 8ed341714686..7f7309ff67d0 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -103,9 +103,9 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *c=
tx_info, u64 lapic_id)
 	m.socketid =3D -1;
=20
 	for_each_possible_cpu(cpu) {
-		if (cpu_data(cpu).initial_apicid =3D=3D lapic_id) {
+		if (cpu_data(cpu).topo.initial_apicid =3D=3D lapic_id) {
 			m.extcpu =3D cpu;
-			m.socketid =3D cpu_data(m.extcpu).phys_proc_id;
+			m.socketid =3D cpu_data(m.extcpu).topo.pkg_id;
 			break;
 		}
 	}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6f35f724cc14..8007526fec52 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -123,8 +123,8 @@ void mce_setup(struct mce *m)
 	m->time =3D __ktime_get_real_seconds();
 	m->cpuvendor =3D boot_cpu_data.x86_vendor;
 	m->cpuid =3D cpuid_eax(1);
-	m->socketid =3D cpu_data(m->extcpu).phys_proc_id;
-	m->apicid =3D cpu_data(m->extcpu).initial_apicid;
+	m->socketid =3D cpu_data(m->extcpu).topo.pkg_id;
+	m->apicid =3D cpu_data(m->extcpu).topo.initial_apicid;
 	m->mcgcap =3D __rdmsr(MSR_IA32_MCG_CAP);
 	m->ppin =3D cpu_data(m->extcpu).ppin;
 	m->microcode =3D boot_cpu_data.microcode;
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 31c0e68f6227..e65fae63660e 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -20,13 +20,13 @@ static void show_cpuinfo_core(struct seq_file *m, struct =
cpuinfo_x86 *c,
 			      unsigned int cpu)
 {
 #ifdef CONFIG_SMP
-	seq_printf(m, "physical id\t: %d\n", c->phys_proc_id);
+	seq_printf(m, "physical id\t: %d\n", c->topo.pkg_id);
 	seq_printf(m, "siblings\t: %d\n",
 		   cpumask_weight(topology_core_cpumask(cpu)));
-	seq_printf(m, "core id\t\t: %d\n", c->cpu_core_id);
+	seq_printf(m, "core id\t\t: %d\n", c->topo.core_id);
 	seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
-	seq_printf(m, "apicid\t\t: %d\n", c->apicid);
-	seq_printf(m, "initial apicid\t: %d\n", c->initial_apicid);
+	seq_printf(m, "apicid\t\t: %d\n", c->topo.apicid);
+	seq_printf(m, "initial apicid\t: %d\n", c->topo.initial_apicid);
 #endif
 }
=20
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 0270925fe013..dc136703566f 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -78,7 +78,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
 	/*
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
-	c->initial_apicid =3D edx;
+	c->topo.initial_apicid =3D edx;
 	smp_num_siblings =3D max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 #endif
 	return 0;
@@ -108,7 +108,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	 * Populate HT related information from sub-leaf level 0.
 	 */
 	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	c->initial_apicid =3D edx;
+	c->topo.initial_apicid =3D edx;
 	core_level_siblings =3D LEVEL_MAX_SIBLINGS(ebx);
 	smp_num_siblings =3D max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 	core_plus_mask_width =3D ht_mask_width =3D BITS_SHIFT_NEXT_LEVEL(eax);
@@ -146,20 +146,19 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	die_select_mask =3D (~(-1 << die_plus_mask_width)) >>
 				core_plus_mask_width;
=20
-	c->cpu_core_id =3D apic->phys_pkg_id(c->initial_apicid,
+	c->topo.core_id =3D apic->phys_pkg_id(c->topo.initial_apicid,
 				ht_mask_width) & core_select_mask;
=20
 	if (die_level_present) {
-		c->cpu_die_id =3D apic->phys_pkg_id(c->initial_apicid,
+		c->topo.die_id =3D apic->phys_pkg_id(c->topo.initial_apicid,
 					core_plus_mask_width) & die_select_mask;
 	}
=20
-	c->phys_proc_id =3D apic->phys_pkg_id(c->initial_apicid,
-				pkg_mask_width);
+	c->topo.pkg_id =3D apic->phys_pkg_id(c->topo.initial_apicid, pkg_mask_width=
);
 	/*
 	 * Reinit the apicid, now that we have extended initial_apicid.
 	 */
-	c->apicid =3D apic->phys_pkg_id(c->initial_apicid, 0);
+	c->topo.apicid =3D apic->phys_pkg_id(c->topo.initial_apicid, 0);
=20
 	c->x86_max_cores =3D (core_level_siblings / smp_num_siblings);
 	__max_die_per_package =3D (die_level_siblings / core_level_siblings);
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 05fa4ef63490..415564a6523b 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -65,20 +65,6 @@ static void early_init_zhaoxin(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
 	}
-
-	if (c->cpuid_level >=3D 0x00000001) {
-		u32 eax, ebx, ecx, edx;
-
-		cpuid(0x00000001, &eax, &ebx, &ecx, &edx);
-		/*
-		 * If HTT (EDX[28]) is set EBX[16:23] contain the number of
-		 * apicids which are reserved per package. Store the resulting
-		 * shift value for the package management code.
-		 */
-		if (edx & (1U << 28))
-			c->x86_coreid_bits =3D get_count_order((ebx >> 16) & 0xff);
-	}
-
 }
=20
 static void init_zhaoxin(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index b8ab9ee5896c..0ddb3bd0f1aa 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -500,13 +500,13 @@ static bool pv_sched_yield_supported(void)
 static void __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	unsigned long flags;
-	int cpu, apic_id, icr;
-	int min =3D 0, max =3D 0;
+	int cpu, min =3D 0, max =3D 0;
 #ifdef CONFIG_X86_64
 	__uint128_t ipi_bitmap =3D 0;
 #else
 	u64 ipi_bitmap =3D 0;
 #endif
+	u32 apic_id, icr;
 	long ret;
=20
 	if (cpumask_empty(mask))
@@ -1028,8 +1028,8 @@ arch_initcall(activate_jump_labels);
 /* Kick a cpu by its apicid. Used to wake up a halted vcpu */
 static void kvm_kick_cpu(int cpu)
 {
-	int apicid;
 	unsigned long flags =3D 0;
+	u32 apicid;
=20
 	apicid =3D per_cpu(x86_cpu_to_apicid, cpu);
 	kvm_hypercall2(KVM_HC_KICK_CPU, flags, apicid);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2787826d9f60..edf9b74b6f73 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -940,7 +940,7 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vms=
a)
 		free_page((unsigned long)vmsa);
 }
=20
-static int wakeup_cpu_via_vmgexit(int apic_id, unsigned long start_ip)
+static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 {
 	struct sev_es_save_area *cur_vmsa, *vmsa;
 	struct ghcb_state state;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 4e45ff44aa07..54541a1a07f8 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -124,7 +124,20 @@ struct mwait_cpu_dead {
  */
 static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
=20
-/* Logical package management. We might want to allocate that dynamically */
+/* Logical package management. */
+struct logical_maps {
+	u32	phys_pkg_id;
+	u32	phys_die_id;
+	u32	logical_pkg_id;
+	u32	logical_die_id;
+};
+
+/* Temporary workaround until the full topology mechanics is in place */
+static DEFINE_PER_CPU_READ_MOSTLY(struct logical_maps, logical_maps) =3D {
+	.phys_pkg_id	=3D U32_MAX,
+	.phys_die_id	=3D U32_MAX,
+};
+
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
 static unsigned int logical_packages __read_mostly;
@@ -337,10 +350,8 @@ int topology_phys_to_logical_pkg(unsigned int phys_pkg)
 	int cpu;
=20
 	for_each_possible_cpu(cpu) {
-		struct cpuinfo_x86 *c =3D &cpu_data(cpu);
-
-		if (c->initialized && c->phys_proc_id =3D=3D phys_pkg)
-			return c->logical_proc_id;
+		if (per_cpu(logical_maps.phys_pkg_id, cpu) =3D=3D phys_pkg)
+			return per_cpu(logical_maps.logical_pkg_id, cpu);
 	}
 	return -1;
 }
@@ -355,14 +366,12 @@ EXPORT_SYMBOL(topology_phys_to_logical_pkg);
  */
 static int topology_phys_to_logical_die(unsigned int die_id, unsigned int cu=
r_cpu)
 {
-	int cpu, proc_id =3D cpu_data(cur_cpu).phys_proc_id;
+	int cpu, proc_id =3D cpu_data(cur_cpu).topo.pkg_id;
=20
 	for_each_possible_cpu(cpu) {
-		struct cpuinfo_x86 *c =3D &cpu_data(cpu);
-
-		if (c->initialized && c->cpu_die_id =3D=3D die_id &&
-		    c->phys_proc_id =3D=3D proc_id)
-			return c->logical_die_id;
+		if (per_cpu(logical_maps.phys_pkg_id, cpu) =3D=3D proc_id &&
+		    per_cpu(logical_maps.phys_die_id, cpu) =3D=3D die_id)
+			return per_cpu(logical_maps.logical_die_id, cpu);
 	}
 	return -1;
 }
@@ -387,7 +396,9 @@ int topology_update_package_map(unsigned int pkg, unsigne=
d int cpu)
 			cpu, pkg, new);
 	}
 found:
-	cpu_data(cpu).logical_proc_id =3D new;
+	per_cpu(logical_maps.phys_pkg_id, cpu) =3D pkg;
+	per_cpu(logical_maps.logical_pkg_id, cpu) =3D new;
+	cpu_data(cpu).topo.logical_pkg_id =3D new;
 	return 0;
 }
 /**
@@ -410,7 +421,9 @@ int topology_update_die_map(unsigned int die, unsigned in=
t cpu)
 			cpu, die, new);
 	}
 found:
-	cpu_data(cpu).logical_die_id =3D new;
+	per_cpu(logical_maps.phys_die_id, cpu) =3D die;
+	per_cpu(logical_maps.logical_die_id, cpu) =3D new;
+	cpu_data(cpu).topo.logical_die_id =3D new;
 	return 0;
 }
=20
@@ -421,8 +434,8 @@ static void __init smp_store_boot_cpu_info(void)
=20
 	*c =3D boot_cpu_data;
 	c->cpu_index =3D id;
-	topology_update_package_map(c->phys_proc_id, id);
-	topology_update_die_map(c->cpu_die_id, id);
+	topology_update_package_map(c->topo.pkg_id, id);
+	topology_update_die_map(c->topo.die_id, id);
 	c->initialized =3D true;
 }
=20
@@ -476,21 +489,21 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpu=
info_x86 *o)
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
 		int cpu1 =3D c->cpu_index, cpu2 =3D o->cpu_index;
=20
-		if (c->phys_proc_id =3D=3D o->phys_proc_id &&
-		    c->cpu_die_id =3D=3D o->cpu_die_id &&
-		    per_cpu(cpu_llc_id, cpu1) =3D=3D per_cpu(cpu_llc_id, cpu2)) {
-			if (c->cpu_core_id =3D=3D o->cpu_core_id)
+		if (c->topo.pkg_id =3D=3D o->topo.pkg_id &&
+		    c->topo.die_id =3D=3D o->topo.die_id &&
+		    per_cpu_llc_id(cpu1) =3D=3D per_cpu_llc_id(cpu2)) {
+			if (c->topo.core_id =3D=3D o->topo.core_id)
 				return topology_sane(c, o, "smt");
=20
-			if ((c->cu_id !=3D 0xff) &&
-			    (o->cu_id !=3D 0xff) &&
-			    (c->cu_id =3D=3D o->cu_id))
+			if ((c->topo.cu_id !=3D 0xff) &&
+			    (o->topo.cu_id !=3D 0xff) &&
+			    (c->topo.cu_id =3D=3D o->topo.cu_id))
 				return topology_sane(c, o, "smt");
 		}
=20
-	} else if (c->phys_proc_id =3D=3D o->phys_proc_id &&
-		   c->cpu_die_id =3D=3D o->cpu_die_id &&
-		   c->cpu_core_id =3D=3D o->cpu_core_id) {
+	} else if (c->topo.pkg_id =3D=3D o->topo.pkg_id &&
+		   c->topo.die_id =3D=3D o->topo.die_id &&
+		   c->topo.core_id =3D=3D o->topo.core_id) {
 		return topology_sane(c, o, "smt");
 	}
=20
@@ -499,8 +512,8 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuin=
fo_x86 *o)
=20
 static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
-	if (c->phys_proc_id =3D=3D o->phys_proc_id &&
-	    c->cpu_die_id =3D=3D o->cpu_die_id)
+	if (c->topo.pkg_id =3D=3D o->topo.pkg_id &&
+	    c->topo.die_id =3D=3D o->topo.die_id)
 		return true;
 	return false;
 }
@@ -510,11 +523,11 @@ static bool match_l2c(struct cpuinfo_x86 *c, struct cpu=
info_x86 *o)
 	int cpu1 =3D c->cpu_index, cpu2 =3D o->cpu_index;
=20
 	/* If the arch didn't set up l2c_id, fall back to SMT */
-	if (per_cpu(cpu_l2c_id, cpu1) =3D=3D BAD_APICID)
+	if (per_cpu_l2c_id(cpu1) =3D=3D BAD_APICID)
 		return match_smt(c, o);
=20
 	/* Do not match if L2 cache id does not match: */
-	if (per_cpu(cpu_l2c_id, cpu1) !=3D per_cpu(cpu_l2c_id, cpu2))
+	if (per_cpu_l2c_id(cpu1) !=3D per_cpu_l2c_id(cpu2))
 		return false;
=20
 	return topology_sane(c, o, "l2c");
@@ -527,7 +540,7 @@ static bool match_l2c(struct cpuinfo_x86 *c, struct cpuin=
fo_x86 *o)
  */
 static bool match_pkg(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
-	if (c->phys_proc_id =3D=3D o->phys_proc_id)
+	if (c->topo.pkg_id =3D=3D o->topo.pkg_id)
 		return true;
 	return false;
 }
@@ -560,11 +573,11 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpu=
info_x86 *o)
 	bool intel_snc =3D id && id->driver_data;
=20
 	/* Do not match if we do not have a valid APICID for cpu: */
-	if (per_cpu(cpu_llc_id, cpu1) =3D=3D BAD_APICID)
+	if (per_cpu_llc_id(cpu1) =3D=3D BAD_APICID)
 		return false;
=20
 	/* Do not match if LLC id does not match: */
-	if (per_cpu(cpu_llc_id, cpu1) !=3D per_cpu(cpu_llc_id, cpu2))
+	if (per_cpu_llc_id(cpu1) !=3D per_cpu_llc_id(cpu2))
 		return false;
=20
 	/*
@@ -803,7 +816,7 @@ static void __init smp_quirk_init_udelay(void)
 /*
  * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-static void send_init_sequence(int phys_apicid)
+static void send_init_sequence(u32 phys_apicid)
 {
 	int maxlvt =3D lapic_get_maxlvt();
=20
@@ -829,7 +842,7 @@ static void send_init_sequence(int phys_apicid)
 /*
  * Wake up AP by INIT, INIT, STARTUP sequence.
  */
-static int wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long star=
t_eip)
+static int wakeup_secondary_cpu_via_init(u32 phys_apicid, unsigned long star=
t_eip)
 {
 	unsigned long send_status =3D 0, accept_status =3D 0;
 	int num_starts, j, maxlvt;
@@ -976,7 +989,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *i=
dle)
  * Returns zero if startup was successfully sent, else error code from
  * ->wakeup_secondary_cpu.
  */
-static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
+static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip =3D real_mode_header->trampoline_start;
 	int ret;
@@ -1044,7 +1057,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task=
_struct *idle)
=20
 int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 {
-	int apicid =3D apic->cpu_present_to_apicid(cpu);
+	u32 apicid =3D apic->cpu_present_to_apicid(cpu);
 	int err;
=20
 	lockdep_assert_irqs_enabled();
@@ -1237,7 +1250,7 @@ void arch_thaw_secondary_cpus_end(void)
 bool smp_park_other_cpus_in_init(void)
 {
 	unsigned int cpu, this_cpu =3D smp_processor_id();
-	unsigned int apicid;
+	u32 apicid;
=20
 	if (apic->wakeup_secondary_cpu_64 || apic->wakeup_secondary_cpu)
 		return false;
@@ -1426,7 +1439,7 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
 	cpumask_clear(topology_die_cpumask(cpu));
-	c->cpu_core_id =3D 0;
+	c->topo.core_id =3D 0;
 	c->booted_cores =3D 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
 	recompute_smt_state();
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index 65e96b76c423..d3fc01770558 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -127,7 +127,7 @@ static void __init vsmp_cap_cpus(void)
 #endif
 }
=20
-static int apicid_phys_pkg_id(int initial_apic_id, int index_msb)
+static u32 apicid_phys_pkg_id(u32 initial_apic_id, int index_msb)
 {
 	return read_apic_id() >> index_msb;
 }
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f..02ee0d115e71 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -56,7 +56,7 @@ s16 __apicid_to_node[MAX_LOCAL_APIC] =3D {
=20
 int numa_cpu_node(int cpu)
 {
-	int apicid =3D early_per_cpu(x86_cpu_to_apicid, cpu);
+	u32 apicid =3D early_per_cpu(x86_cpu_to_apicid, cpu);
=20
 	if (apicid !=3D BAD_APICID)
 		return __apicid_to_node[apicid];
@@ -786,7 +786,7 @@ void __init init_gi_nodes(void)
 void __init init_cpu_to_node(void)
 {
 	int cpu;
-	u16 *cpu_to_apicid =3D early_per_cpu_ptr(x86_cpu_to_apicid);
+	u32 *cpu_to_apicid =3D early_per_cpu_ptr(x86_cpu_to_apicid);
=20
 	BUG_ON(cpu_to_apicid =3D=3D NULL);
=20
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 7ad91225fdf4..9dd5490b3318 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -33,13 +33,13 @@ static unsigned int xen_io_apic_read(unsigned apic, unsig=
ned reg)
 	return 0xfd;
 }
=20
-static u32 xen_set_apic_id(unsigned int x)
+static u32 xen_set_apic_id(u32 x)
 {
 	WARN_ON(1);
 	return x;
 }
=20
-static unsigned int xen_get_apic_id(unsigned long x)
+static u32 xen_get_apic_id(u32 x)
 {
 	return ((x)>>24) & 0xFFu;
 }
@@ -110,15 +110,15 @@ static int xen_madt_oem_check(char *oem_id, char *oem_t=
able_id)
 	return xen_pv_domain();
 }
=20
-static int xen_phys_pkg_id(int initial_apic_id, int index_msb)
+static u32 xen_phys_pkg_id(u32 initial_apic_id, int index_msb)
 {
 	return initial_apic_id >> index_msb;
 }
=20
-static int xen_cpu_present_to_apicid(int cpu)
+static u32 xen_cpu_present_to_apicid(int cpu)
 {
 	if (cpu_present(cpu))
-		return cpu_data(cpu).apicid;
+		return cpu_data(cpu).topo.apicid;
 	else
 		return BAD_APICID;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_topology.c
index ff98fded9534..70acfbb6a8fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2209,7 +2209,7 @@ static int kfd_cpumask_to_apic_id(const struct cpumask =
*cpumask)
 	if (first_cpu_of_numa_node >=3D nr_cpu_ids)
 		return -1;
 #ifdef CONFIG_X86_64
-	return cpu_data(first_cpu_of_numa_node).apicid;
+	return cpu_data(first_cpu_of_numa_node).topo.apicid;
 #else
 	return first_cpu_of_numa_node;
 #endif
diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 521534d5c1e5..6307112c2c0c 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -17,6 +17,7 @@
 #include <linux/cpumask.h>
 #include <linux/time.h>
 #include <linux/sched.h>
+#include <linux/topology.h>
 #include <asm/processor.h>
 #include <asm/msr.h>
=20
@@ -134,15 +135,13 @@ static DEVICE_ATTR_RO(power1_crit);
 static void do_read_registers_on_cu(void *_data)
 {
 	struct fam15h_power_data *data =3D _data;
-	int cpu, cu;
-
-	cpu =3D smp_processor_id();
+	int cu;
=20
 	/*
 	 * With the new x86 topology modelling, cpu core id actually
 	 * is compute unit id.
 	 */
-	cu =3D cpu_data(cpu).cpu_core_id;
+	cu =3D topology_core_id(smp_processor_id());
=20
 	rdmsrl_safe(MSR_F15H_CU_PWR_ACCUMULATOR, &data->cu_acc_power[cu]);
 	rdmsrl_safe(MSR_F15H_PTSC, &data->cpu_sw_pwr_ptsc[cu]);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 9e59c050103d..e7c47ee185a4 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -12442,9 +12442,6 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int ve=
ctors)
 	int max_core_id, min_core_id;
 	struct lpfc_vector_map_info *cpup;
 	struct lpfc_vector_map_info *new_cpup;
-#ifdef CONFIG_X86
-	struct cpuinfo_x86 *cpuinfo;
-#endif
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	struct lpfc_hdwq_stat *c_stat;
 #endif
@@ -12458,9 +12455,8 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int ve=
ctors)
 	for_each_present_cpu(cpu) {
 		cpup =3D &phba->sli4_hba.cpu_map[cpu];
 #ifdef CONFIG_X86
-		cpuinfo =3D &cpu_data(cpu);
-		cpup->phys_id =3D cpuinfo->phys_proc_id;
-		cpup->core_id =3D cpuinfo->cpu_core_id;
+		cpup->phys_id =3D topology_physical_package_id(cpu);
+		cpup->core_id =3D topology_core_id(cpu);
 		if (lpfc_find_hyper(phba, cpu, cpup->phys_id, cpup->core_id))
 			cpup->flag |=3D LPFC_CPU_MAP_HYPER;
 #else
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index 423ea888d79a..c24036c4e51e 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -447,7 +447,7 @@ static ssize_t remove_cpu_store(struct device *dev,
 	if (cpu_online(cpu))
 		remove_cpu(cpu);
=20
-	lapicid =3D cpu_data(cpu).apicid;
+	lapicid =3D cpu_data(cpu).topo.apicid;
 	dev_dbg(dev, "Try to remove cpu %lld with lapicid %lld\n", cpu, lapicid);
 	ret =3D hcall_sos_remove_cpu(lapicid);
 	if (ret < 0) {
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6de7c6bb74ee..1a189da3bdac 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -659,11 +659,19 @@ static inline bool cpu_smt_thread_allowed(unsigned int =
cpu)
 #endif
 }
=20
-static inline bool cpu_smt_allowed(unsigned int cpu)
+static inline bool cpu_bootable(unsigned int cpu)
 {
 	if (cpu_smt_control =3D=3D CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
 		return true;
=20
+	/* All CPUs are bootable if controls are not configured */
+	if (cpu_smt_control =3D=3D CPU_SMT_NOT_IMPLEMENTED)
+		return true;
+
+	/* All CPUs are bootable if CPU is not SMT capable */
+	if (cpu_smt_control =3D=3D CPU_SMT_NOT_SUPPORTED)
+		return true;
+
 	if (topology_is_primary_thread(cpu))
 		return true;
=20
@@ -685,7 +693,7 @@ bool cpu_smt_possible(void)
 EXPORT_SYMBOL_GPL(cpu_smt_possible);
=20
 #else
-static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
+static inline bool cpu_bootable(unsigned int cpu) { return true; }
 #endif
=20
 static inline enum cpuhp_state
@@ -788,10 +796,10 @@ static int bringup_wait_for_ap_online(unsigned int cpu)
 	 * SMT soft disabling on X86 requires to bring the CPU out of the
 	 * BIOS 'wait for SIPI' state in order to set the CR4.MCE bit.  The
 	 * CPU marked itself as booted_once in notify_cpu_starting() so the
-	 * cpu_smt_allowed() check will now return false if this is not the
+	 * cpu_bootable() check will now return false if this is not the
 	 * primary sibling.
 	 */
-	if (!cpu_smt_allowed(cpu))
+	if (!cpu_bootable(cpu))
 		return -ECANCELED;
 	return 0;
 }
@@ -1741,7 +1749,7 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state ta=
rget)
 		err =3D -EBUSY;
 		goto out;
 	}
-	if (!cpu_smt_allowed(cpu)) {
+	if (!cpu_bootable(cpu)) {
 		err =3D -EPERM;
 		goto out;
 	}

