Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48175705C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjGQXPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGQXPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:15:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2301A1BCF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:15:01 -0700 (PDT)
Message-ID: <20230717223224.030628920@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rxQN3La4uHdTmHXWvnEPxqt3sCLh4RNMZmN6BFMgny4=;
        b=NcyMzc1SpuMYk05jsCRG2BlucobaDGGxjcwIrVbflUWp+DfMWiCjUrOP+3T+SHBItpDnJz
        JQr/UwH+IrAWFgJHt+49ROFOgVq7XMwdrqWa3LoPyQNrsokPM2L/hm6rOLOxye6alIHXNu
        d+in5MQswN9Xf2J5maeJBeEjIlAiNDVaybk/8iFq9y+Pl7tX9B26CTM/jkG2tCTAzAxfex
        1gAqexir7pwpa8+ntX2jez7qrxyTZQjDNTsyGVvwhm3gQvaaOYMA5Q7jUuQ249K0aqwulA
        VuQ0imijJyYSAG6hb74CJdYn7kMHxSPWQEFrohzQ+t675BzWo6RSomjFTM4RHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rxQN3La4uHdTmHXWvnEPxqt3sCLh4RNMZmN6BFMgny4=;
        b=B6sKhRrWrOBnzZ3M5Uk7oINAy9QWuQJLDHj4bnToS+GnxoWP+NoHkWASgNtcqo603IhS08
        YD51KKO/6iFbZLCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 16/58] x86/apic: Sanitize num_processors handling
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:59 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
@@ -1389,24 +1389,6 @@ early_param("possible_cpus", _setup_poss
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

