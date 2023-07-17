Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C573757070
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjGQXTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjGQXS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:18:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D0F18B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:18:14 -0700 (PDT)
Message-ID: <20230717223225.455893009@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UJGgSk85bCjHVvLP0ge+jZsQpl98WT3tTk4TUIufIuY=;
        b=34XUGULgjMZnaDR0zYz+a2ScDMU1gMClqjqwfOMIqqvFLURLF0fWGBewpUzjQprH5bGEAN
        gXL25vmys9ZGKNx2svTpmbTkzSFEGUDis1BFJCXF7IWkCbaVp2PDZjcPy601BjPlVxeFjM
        j3C0yEgbVpHkPnMmPvSIYyFi/6vqwjn+wVNZOZuB143DhiXJ0PPq9lh+U8Xq+uUw/bY6Dg
        8TaquW6QI16PSztszaFX1jkN4AffIvzZILM5aiwJTWm0DY6TEh1g6E+ZbHirvbhIooebur
        H+7a/8guqbYwJig6huGevK/4YUbkeP+e0YAD6O1u0cpm/0JIvTKODZ4EZ3XTJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UJGgSk85bCjHVvLP0ge+jZsQpl98WT3tTk4TUIufIuY=;
        b=SyyQCuPOHu36zMqQjGqNhA/yh5lP9vpGv4aV3nUSXYM45fPGbFQXh1L3CnIdZDdBkG6bNF
        qMaKe780Iu8e8TDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 40/58] x86/apic: Wrap APIC ID validation into an inline
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:36 +0200 (CEST)
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

