Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C09F76B253
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjHAKu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjHAKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:50:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4598F4217
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:48:17 -0700 (PDT)
Message-ID: <20230801103817.404695655@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TA8RTRP76/X19cT18S7neKhRCl/b+EEGzlCWZ6ao1A4=;
        b=Q7HmM1TaKQjwNSSbocOLtyBXBadEO8vNPv5HwWURc5KkWs3nN0i+WcgQ0+3cGf8FIRwq4L
        Lr1ajhoZJiOVDJILgDbV1qR5sjeFx1DJA9IV6bbZ4XszqHdSGQzUWE4KkXxUrQwrj/Vtrl
        GkWqV7zm25XYhc9pvIuIe22j4PdvCy922G7+yK35xD/ywu0rYek7vXy057hvBxXH2MOsi0
        XWPy9pewf/DbSSQBdoiJW0M3lOEMhwXErIMP3lqzgx7ac7xaXNDfWFNUhtZRkNezNODflj
        Oeik13ckZW6vMXqDZC1KGDZeM/h0jKEkLLzaydVGHB5s7GfVFmCGWPLJwv9htw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TA8RTRP76/X19cT18S7neKhRCl/b+EEGzlCWZ6ao1A4=;
        b=3q1AiKVhJTvaVVpCiomKz+41fwdizJHnCdbGh/Qbnc2D4Fga4Rp5eEOHJsfhLo8erWmqPX
        YnAQYuFufRYnzkBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V3 41/60] x86/apic: Wrap APIC ID validation into an inline
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:31 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for removing the callback and making this as simple comparison to
an upper limit, which is the obvious solution to do for limit checks...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h   |    5 +++++
 arch/x86/kernel/acpi/boot.c   |    2 +-
 arch/x86/kernel/apic/vector.c |    2 +-
 arch/x86/kernel/smpboot.c     |    5 ++---
 arch/x86/mm/srat.c            |    5 ++---
 5 files changed, 11 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -372,6 +372,11 @@ static inline u32 safe_apic_wait_icr_idl
 	return apic->safe_wait_icr_idle ? apic->safe_wait_icr_idle() : 0;
 }
 
+static inline bool apic_id_valid(u32 apic_id)
+{
+	return apic->apic_id_valid(apic_id);
+}
+
 extern void __init apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v));
 
 #else /* CONFIG_X86_LOCAL_APIC */
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -235,7 +235,7 @@ acpi_parse_x2apic(union acpi_subtable_he
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	if (!apic->apic_id_valid(apic_id)) {
+	if (!apic_id_valid(apic_id)) {
 		if (enabled)
 			pr_warn("x2apic entry ignored\n");
 		return 0;
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -680,7 +680,7 @@ static int x86_vector_select(struct irq_
 	 * if IRQ remapping is enabled. APIC IDs above 15 bits are
 	 * only permitted if IRQ remapping is enabled, so check that.
 	 */
-	if (apic->apic_id_valid(32768))
+	if (apic_id_valid(32768))
 		return 0;
 
 	return x86_fwspec_is_ioapic(fwspec) || x86_fwspec_is_hpet(fwspec);
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1064,9 +1064,8 @@ int native_kick_ap(unsigned int cpu, str
 
 	pr_debug("++++++++++++++++++++=_---CPU UP  %u\n", cpu);
 
-	if (apicid == BAD_APICID ||
-	    !physid_isset(apicid, phys_cpu_present_map) ||
-	    !apic->apic_id_valid(apicid)) {
+	if (apicid == BAD_APICID || !physid_isset(apicid, phys_cpu_present_map) ||
+	    !apic_id_valid(apicid)) {
 		pr_err("%s: bad cpu %d\n", __func__, cpu);
 		return -EINVAL;
 	}
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -40,9 +40,8 @@ acpi_numa_x2apic_affinity_init(struct ac
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

