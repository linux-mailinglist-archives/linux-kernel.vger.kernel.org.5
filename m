Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D5375F8B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjGXNop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjGXNmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:42:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B141326B0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:40:59 -0700 (PDT)
Message-ID: <20230724132046.974792602@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TA8RTRP76/X19cT18S7neKhRCl/b+EEGzlCWZ6ao1A4=;
        b=HxclbIhTjLODKFO3RGC3dx6jYVZMYCcCtvfNhtkAXwiR1iwaf5cjIfijzUkstSqMBe7KZs
        Ye3glj+rDgbOuzbJKzzWfx5hAXK60b5XwKlv01lFgvwHQI2sOhLrzOu1TsLA1INa+VuyKH
        8J2k2vzvk47FCNelZ15dzyCpv+1pz0qqBM/YBWutxYmagKjjnGV5tq1QJV2SnRZU0V9zxE
        TxqN3aSH0q4xrGlBXcQdng/mj82swe1HqUGqNhMUDi+bTDsj6ES6/oAloaYpuMKvVXD4dM
        2hvuB1xzbsE6/WYA5HjD7tiXHtm/9ZcY1JbJhUZM70xGrzeCeqLjgXRsSJmbpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TA8RTRP76/X19cT18S7neKhRCl/b+EEGzlCWZ6ao1A4=;
        b=TksayY8yXQNhaZEX9TblG7l0MZ4DqWnyoJaM8Ior8TRe96BKQezS9gCcEyKy1nWFQxnhSn
        pRdLvj+JVNS2aHAg==
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
Subject: [patch V2 40/58] x86/apic: Wrap APIC ID validation into an inline
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:53 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

