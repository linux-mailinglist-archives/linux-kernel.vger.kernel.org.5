Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA965776A3F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjHIUgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjHIUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9FF211E;
        Wed,  9 Aug 2023 13:36:11 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5uAZpiHOIOxXPlrWU10E2qMf0DUM4rCEaNL/Wbwti3U=;
        b=3kKfteGQkhVY0civcHV6U+ZYPIC06IP9IC7rcllzcDqmzyPW9dEvZEPcU0pU5Lqn2zfSWk
        pCv2SVDRIlkuusbh8hJRIAkypz6tu4dd/07vS5cRDJY6XX4hYpvJlqEbnQ8mNvc1Cvp3GX
        Ur+0Ak+5eiFJaoOEsUc13a2x1g+iBHeGd+CTisGnSo9jJAsZHemPp2Sejkv0YZNEcHrPmv
        ssQOT+wT7puaa2n2pvgwhmEQntGGyNPaGrFQpDxf7KU4YxSw6M9P9aM/YPhk2heodSv2s+
        UzdD5AFH2F2l5GHV/qdOnrIQILI89KGSf0Anl8al9yATkEVGTyERy6ugdXk5lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5uAZpiHOIOxXPlrWU10E2qMf0DUM4rCEaNL/Wbwti3U=;
        b=6t5n5DvgmDt72KKbhHgcpBdc6BNYtlkQGKL4ViSt1kxRHlOSeTdliGuEVpyin3nwvL1KJS
        G7GSoNesN+vrV5DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove pointless arguments from
 [native_]eoi_write()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336950.27769.4615674305893044961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     185c8f33a048bd04fdedd08e7bd7861a85158834
Gitweb:        https://git.kernel.org/tip/185c8f33a048bd04fdedd08e7bd7861a85158834
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:15 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:33 -07:00

x86/apic: Remove pointless arguments from [native_]eoi_write()

Every callsite hands in the same constants which is a pointless exercise
and cannot be optimized by the compiler due to the indirect calls.

Use the constants in the eoi() callbacks and remove the arguments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/hyperv/hv_apic.c             |  6 +++---
 arch/x86/include/asm/apic.h           | 17 +++++++++++------
 arch/x86/kernel/apic/apic.c           |  8 ++++----
 arch/x86/kernel/apic/apic_flat_64.c   |  4 ++--
 arch/x86/kernel/apic/apic_noop.c      |  3 ++-
 arch/x86/kernel/apic/apic_numachip.c  |  4 ++--
 arch/x86/kernel/apic/bigsmp_32.c      |  2 +-
 arch/x86/kernel/apic/probe_32.c       |  2 +-
 arch/x86/kernel/apic/x2apic_cluster.c |  2 +-
 arch/x86/kernel/apic/x2apic_phys.c    |  2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c    |  2 +-
 arch/x86/kernel/kvm.c                 |  6 +++---
 arch/x86/xen/apic.c                   |  7 ++++++-
 13 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 1fbda2f..5513f60 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -86,14 +86,14 @@ static void hv_apic_write(u32 reg, u32 val)
 	}
 }
 
-static void hv_apic_eoi_write(u32 reg, u32 val)
+static void hv_apic_eoi_write(void)
 {
 	struct hv_vp_assist_page *hvp = hv_vp_assist_page[smp_processor_id()];
 
 	if (hvp && (xchg(&hvp->apic_assist, 0) & 0x1))
 		return;
 
-	wrmsr(HV_X64_MSR_EOI, val, 0);
+	wrmsr(HV_X64_MSR_EOI, APIC_EOI_ACK, 0);
 }
 
 static bool cpu_is_self(int cpu)
@@ -310,7 +310,7 @@ void __init hv_apic_init(void)
 		 * lazy EOI when available, but the same accessor works for
 		 * both xapic and x2apic because the field layout is the same.
 		 */
-		apic_set_eoi_write(hv_apic_eoi_write);
+		apic_set_eoi_cb(hv_apic_eoi_write);
 		if (!x2apic_enabled()) {
 			apic->read      = hv_apic_read;
 			apic->write     = hv_apic_write;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index ccf4e36..790f15d 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -98,6 +98,11 @@ static inline u32 native_apic_mem_read(u32 reg)
 	return *((volatile u32 *)(APIC_BASE + reg));
 }
 
+static inline void native_apic_mem_eoi(void)
+{
+	native_apic_mem_write(APIC_EOI, APIC_EOI_ACK);
+}
+
 extern void native_apic_icr_write(u32 low, u32 id);
 extern u64 native_apic_icr_read(void);
 
@@ -189,7 +194,7 @@ static inline void native_apic_msr_write(u32 reg, u32 v)
 	wrmsr(APIC_BASE_MSR + (reg >> 4), v, 0);
 }
 
-static inline void native_apic_msr_eoi_write(u32 reg, u32 v)
+static inline void native_apic_msr_eoi(void)
 {
 	__wrmsr(APIC_BASE_MSR + (APIC_EOI >> 4), APIC_EOI_ACK, 0);
 }
@@ -250,8 +255,8 @@ struct irq_data;
  */
 struct apic {
 	/* Hotpath functions first */
-	void	(*eoi_write)(u32 reg, u32 v);
-	void	(*native_eoi_write)(u32 reg, u32 v);
+	void	(*eoi)(void);
+	void	(*native_eoi)(void);
 	void	(*write)(u32 reg, u32 v);
 	u32	(*read)(u32 reg);
 
@@ -351,7 +356,7 @@ static inline void apic_write(u32 reg, u32 val)
 
 static inline void apic_eoi(void)
 {
-	apic->eoi_write(APIC_EOI, APIC_EOI_ACK);
+	apic->eoi();
 }
 
 static inline u64 apic_icr_read(void)
@@ -380,7 +385,7 @@ static inline bool apic_id_valid(u32 apic_id)
 	return apic_id <= apic->max_apic_id;
 }
 
-extern void __init apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v));
+extern void __init apic_set_eoi_cb(void (*eoi)(void));
 
 #else /* CONFIG_X86_LOCAL_APIC */
 
@@ -391,7 +396,7 @@ static inline u64 apic_icr_read(void) { return 0; }
 static inline void apic_icr_write(u32 low, u32 high) { }
 static inline void apic_wait_icr_idle(void) { }
 static inline u32 safe_apic_wait_icr_idle(void) { return 0; }
-static inline void apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v)) {}
+static inline void apic_set_eoi_cb(void (*eoi)(void)) {}
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 80a31f2..33d5ed6 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2502,15 +2502,15 @@ void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
  * interrupts disabled, so we know this does not race with actual APIC driver
  * use.
  */
-void __init apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v))
+void __init apic_set_eoi_cb(void (*eoi)(void))
 {
 	struct apic **drv;
 
 	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++) {
 		/* Should happen once for each apic */
-		WARN_ON((*drv)->eoi_write == eoi_write);
-		(*drv)->native_eoi_write = (*drv)->eoi_write;
-		(*drv)->eoi_write = eoi_write;
+		WARN_ON((*drv)->eoi == eoi);
+		(*drv)->native_eoi = (*drv)->eoi;
+		(*drv)->eoi = eoi;
 	}
 }
 
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index f65419d..5ce1b37 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -106,7 +106,7 @@ static struct apic apic_flat __ro_after_init = {
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
-	.eoi_write			= native_apic_mem_write,
+	.eoi				= native_apic_mem_eoi,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
@@ -182,7 +182,7 @@ static struct apic apic_physflat __ro_after_init = {
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
-	.eoi_write			= native_apic_mem_write,
+	.eoi				= native_apic_mem_eoi,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index e33bea0..966d7cf 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -29,6 +29,7 @@ static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { retu
 static u64 noop_apic_icr_read(void) { return 0; }
 static int noop_phys_pkg_id(int cpuid_apic, int index_msb) { return 0; }
 static unsigned int noop_get_apic_id(unsigned long x) { return 0; }
+static void noop_apic_eoi(void) { }
 
 static u32 noop_apic_read(u32 reg)
 {
@@ -71,7 +72,7 @@ struct apic apic_noop __ro_after_init = {
 
 	.read				= noop_apic_read,
 	.write				= noop_apic_write,
-	.eoi_write			= noop_apic_write,
+	.eoi				= noop_apic_eoi,
 	.icr_read			= noop_apic_icr_read,
 	.icr_write			= noop_apic_icr_write,
 };
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 9df0187..63f3d7b 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -247,7 +247,7 @@ static const struct apic apic_numachip1 __refconst = {
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
-	.eoi_write			= native_apic_mem_write,
+	.eoi				= native_apic_mem_eoi,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 };
@@ -284,7 +284,7 @@ static const struct apic apic_numachip2 __refconst = {
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
-	.eoi_write			= native_apic_mem_write,
+	.eoi				= native_apic_mem_eoi,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 };
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index ffcd114..23c29a0 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -105,7 +105,7 @@ static struct apic apic_bigsmp __ro_after_init = {
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
-	.eoi_write			= native_apic_mem_write,
+	.eoi				= native_apic_mem_eoi,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 5facf42..3671cc1 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -60,7 +60,7 @@ static struct apic apic_default __ro_after_init = {
 
 	.read				= native_apic_mem_read,
 	.write				= native_apic_mem_write,
-	.eoi_write			= native_apic_mem_write,
+	.eoi				= native_apic_mem_eoi,
 	.icr_read			= native_apic_icr_read,
 	.icr_write			= native_apic_icr_write,
 	.wait_icr_idle			= apic_mem_wait_icr_idle,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 12b9c31..affbff6 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -254,7 +254,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
-	.eoi_write			= native_apic_msr_eoi_write,
+	.eoi				= native_apic_msr_eoi,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
 };
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 47ee5c6..788cdb4 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -169,7 +169,7 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
-	.eoi_write			= native_apic_msr_eoi_write,
+	.eoi				= native_apic_msr_eoi,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
 };
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 5692514..1cedb25 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -831,7 +831,7 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 
 	.read				= native_apic_msr_read,
 	.write				= native_apic_msr_write,
-	.eoi_write			= native_apic_msr_eoi_write,
+	.eoi				= native_apic_msr_eoi,
 	.icr_read			= native_x2apic_icr_read,
 	.icr_write			= native_x2apic_icr_write,
 };
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 1cceac5..c2e3e7a 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -332,7 +332,7 @@ static void kvm_register_steal_time(void)
 
 static DEFINE_PER_CPU_DECRYPTED(unsigned long, kvm_apic_eoi) = KVM_PV_EOI_DISABLED;
 
-static notrace void kvm_guest_apic_eoi_write(u32 reg, u32 val)
+static notrace void kvm_guest_apic_eoi_write(void)
 {
 	/**
 	 * This relies on __test_and_clear_bit to modify the memory
@@ -343,7 +343,7 @@ static notrace void kvm_guest_apic_eoi_write(u32 reg, u32 val)
 	 */
 	if (__test_and_clear_bit(KVM_PV_EOI_BIT, this_cpu_ptr(&kvm_apic_eoi)))
 		return;
-	apic->native_eoi_write(APIC_EOI, APIC_EOI_ACK);
+	apic->native_eoi();
 }
 
 static void kvm_guest_cpu_init(void)
@@ -825,7 +825,7 @@ static void __init kvm_guest_init(void)
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
-		apic_set_eoi_write(kvm_guest_apic_eoi_write);
+		apic_set_eoi_cb(kvm_guest_apic_eoi_write);
 
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_INT) && kvmapf) {
 		static_branch_enable(&kvm_async_pf_enabled);
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 661eecf..804a26b 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -81,6 +81,11 @@ static void xen_apic_write(u32 reg, u32 val)
 	WARN(1,"register: %x, value: %x\n", reg, val);
 }
 
+static void xen_apic_eoi(void)
+{
+	WARN_ON_ONCE(1);
+}
+
 static u64 xen_apic_icr_read(void)
 {
 	return 0;
@@ -147,7 +152,7 @@ static struct apic xen_pv_apic = {
 #endif
 	.read				= xen_apic_read,
 	.write				= xen_apic_write,
-	.eoi_write			= xen_apic_write,
+	.eoi				= xen_apic_eoi,
 
 	.icr_read 			= xen_apic_icr_read,
 	.icr_write 			= xen_apic_icr_write,
