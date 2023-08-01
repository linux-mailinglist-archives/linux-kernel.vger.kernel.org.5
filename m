Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE0776B236
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjHAKsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjHAKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:47:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E1212C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:04 -0700 (PDT)
Message-ID: <20230801103816.091409557@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=c71eHbYg+VP7OJhjZCVHVzp0AtRxO5V4C+TDLxCJHes=;
        b=idVBIXa4Fs2lwoQiWdD2Q4snEnHt3iM1K45yty2QV/5k8sfilQ0ShuvFIn8DOSVzpCnKVl
        4TPnUTeHLqCH0FrPYBVZK4bTnZQqSYpdAg0eMCXcnDD9EMfoCeEfJ/Ml8em7Hc4RWUVtbP
        WSqaWy8YKTYaqxS1yvrqRPeIbqOyIm81YHCdKCYcvMmBotbgJgOYNCIayT6dyHkKcoBknC
        wEvmPGUwrHF4paGtIc84iE5CtUFnfqE6BCNQlvsHBcdvg44zGSdMpY2+U8gQ2i6wlIxVG+
        pZx5DpTsPL9koa17rVrOgCBht7tt/3+1UFTrTOREetf20TB9gAYeYy+maxi67w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=c71eHbYg+VP7OJhjZCVHVzp0AtRxO5V4C+TDLxCJHes=;
        b=EeGtBu9YgOxpSzJ2uqnnp2vOhXDDQeDWcUacJGPIzeuSw1yRkoysZb0wiX2dtFW21G9naf
        aZH+1bl+fBunWfAA==
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
Subject: [patch V3 17/60] x86/apic: Sanitize num_processors handling
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:02 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

num_processors is 0 by default and only gets incremented when local APICs
are registered.

Make init_apic_mappings(), which tries to enable the local APIC in the case
that no SMP configuration was found set num_processors to 1.

This allows to remove yet another check for the local APIC and yet another
place which registers the boot CPUs local APIC ID.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/apic.c |    9 ++++++---
 arch/x86/kernel/smpboot.c   |   18 ------------------
 2 files changed, 6 insertions(+), 21 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2130,9 +2130,12 @@ void __init init_apic_mappings(void)
 	if (x2apic_mode)
 		return;
 
-	if (!smp_found_config && !detect_init_APIC()) {
-		pr_info("APIC: disable apic facility\n");
-		apic_disable();
+	if (!smp_found_config) {
+		if (!detect_init_APIC()) {
+			pr_info("APIC: disable apic facility\n");
+			apic_disable();
+		}
+		num_processors = 1;
 	}
 }
 
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1397,24 +1397,6 @@ early_param("possible_cpus", _setup_poss
 {
 	int i, possible;
 
-	/* No processor was found in mptable or ACPI MADT */
-	if (!num_processors) {
-		if (boot_cpu_has(X86_FEATURE_APIC)) {
-			int apicid = boot_cpu_physical_apicid;
-			int cpu = read_apic_id();
-
-			pr_warn("Boot CPU (id %d) not listed by BIOS\n", cpu);
-
-			/* Make sure boot cpu is enumerated */
-			if (apic->cpu_present_to_apicid(0) == BAD_APICID &&
-			    apic->apic_id_valid(apicid))
-				generic_processor_info(apicid);
-		}
-
-		if (!num_processors)
-			num_processors = 1;
-	}
-
 	i = setup_max_cpus ?: 1;
 	if (setup_possible_cpus == -1) {
 		possible = num_processors;

