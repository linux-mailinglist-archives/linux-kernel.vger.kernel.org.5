Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC490776A52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjHIUg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjHIUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D142213F;
        Wed,  9 Aug 2023 13:36:14 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Pri/xAfFEOv7afiT8ifOWeBxfCrRsuTPLyFOHIFshE8=;
        b=zK/zCKnZ/SbHv16UlBU/YvKxAtMfugHWMLd+gQcJXdXrlqKRy4EmtlKzlW6VmWSpqrmeVF
        OmOsZ7VWjGD9LUE5i5VZUStNS8RIxs2ZIerp1sAu6DbqNiROxgMVosF0Nwn2Apndaz+KPC
        fRLzBZVBXJE2zDnHOn1HWoCJqklagK8HIFHqTvqgDcqAnJK4vmfaL+aXtv/iMZULQJNrDy
        ChDAxu2ZM5EvlgqrvoL+BQuwupWeo0+Dl2Mi+Yp173PW3x1ll8tCGekNuzIw2BcKWXCouN
        01VdncfasGvR5lx5miBZHIUw3TDraC51lK6iIE7no1VQBswMNzfmgO7CfN1vvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Pri/xAfFEOv7afiT8ifOWeBxfCrRsuTPLyFOHIFshE8=;
        b=XAlHzB77G9yknc40FN/DUY5wFDZiA2BqioYE4hQuUDWeJ+R8kpbnHa/MLv1Oca6dAiqrME
        iHXhicTIv+HIibAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Wrap APIC ID validation into an inline
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161337277.27769.12491244937778127318.tip-bot2@tip-bot2>
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

Commit-ID:     9132d720eb8a40be5eaa539ed940beaf2bd2e421
Gitweb:        https://git.kernel.org/tip/9132d720eb8a40be5eaa539ed940beaf2bd2e421
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:09 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:30 -07:00

x86/apic: Wrap APIC ID validation into an inline

Prepare for removing the callback and making this as simple comparison to
an upper limit, which is the obvious solution to do for limit checks...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/apic.h   | 5 +++++
 arch/x86/kernel/acpi/boot.c   | 2 +-
 arch/x86/kernel/apic/vector.c | 2 +-
 arch/x86/kernel/smpboot.c     | 5 ++---
 arch/x86/mm/srat.c            | 5 ++---
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 49b6c7e..5a01d51 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -372,6 +372,11 @@ static inline u32 safe_apic_wait_icr_idle(void)
 	return apic->safe_wait_icr_idle ? apic->safe_wait_icr_idle() : 0;
 }
 
+static inline bool apic_id_valid(u32 apic_id)
+{
+	return apic->apic_id_valid(apic_id);
+}
+
 extern void __init apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v));
 
 #else /* CONFIG_X86_LOCAL_APIC */
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index cca1a07..7f5b257 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -235,7 +235,7 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	if (!apic->apic_id_valid(apic_id)) {
+	if (!apic_id_valid(apic_id)) {
 		if (enabled)
 			pr_warn("x2apic entry ignored\n");
 		return 0;
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 71feae7..2ee3f5a 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -691,7 +691,7 @@ static int x86_vector_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 	 * if IRQ remapping is enabled. APIC IDs above 15 bits are
 	 * only permitted if IRQ remapping is enabled, so check that.
 	 */
-	if (apic->apic_id_valid(32768))
+	if (apic_id_valid(32768))
 		return 0;
 
 	return x86_fwspec_is_ioapic(fwspec) || x86_fwspec_is_hpet(fwspec);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index df1c5f0..7349974 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1064,9 +1064,8 @@ int native_kick_ap(unsigned int cpu, struct task_struct *tidle)
 
 	pr_debug("++++++++++++++++++++=_---CPU UP  %u\n", cpu);
 
-	if (apicid == BAD_APICID ||
-	    !physid_isset(apicid, phys_cpu_present_map) ||
-	    !apic->apic_id_valid(apicid)) {
+	if (apicid == BAD_APICID || !physid_isset(apicid, phys_cpu_present_map) ||
+	    !apic_id_valid(apicid)) {
 		pr_err("%s: bad cpu %d\n", __func__, cpu);
 		return -EINVAL;
 	}
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index dac07e4..9c52a95 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -40,9 +40,8 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 		return;
 	pxm = pa->proximity_domain;
 	apic_id = pa->apic_id;
-	if (!apic->apic_id_valid(apic_id)) {
-		printk(KERN_INFO "SRAT: PXM %u -> X2APIC 0x%04x ignored\n",
-			 pxm, apic_id);
+	if (!apic_id_valid(apic_id)) {
+		pr_info("SRAT: PXM %u -> X2APIC 0x%04x ignored\n", pxm, apic_id);
 		return;
 	}
 	node = acpi_map_pxm_to_node(pxm);
