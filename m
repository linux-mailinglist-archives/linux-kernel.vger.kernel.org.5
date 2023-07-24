Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D911D75F875
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjGXNfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjGXNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:34:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5821FFE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:34:18 -0700 (PDT)
Message-ID: <20230724132045.555787669@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=c71eHbYg+VP7OJhjZCVHVzp0AtRxO5V4C+TDLxCJHes=;
        b=Zdsd/qAkSfkyv7R28hxTmnj8gmeJl+Sk5X2N8xiveIMJFkd8XPmRlQrXnd/6VX5U+F2lIF
        kNXiNRZdmjiuN3l4BMGRZifB9vSb3+pwS/9cMLK1WALqkQa1l8cTRQQ0FmQQ/XXnhnaeod
        Y3ImaBtA0xH3dmU7EECqoF+Us6O2qG2htggxB3Y6+CHulp/UcO7ton+jsg09i0B3d2Cuxb
        XiL49T9wHAWaofWRJs5bEJHbPgev7b90L66QjmYnGAQNmuYIkQz3essgRe6hO9mPOgJan3
        KWrDU9HCFkFxZghZOCw4JFX8yNzFja2B7eDgJc4F8mD8LsI17fnZbkWD+4F07w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=c71eHbYg+VP7OJhjZCVHVzp0AtRxO5V4C+TDLxCJHes=;
        b=ZeJdIWWQ5lDzV+3Aicl/OcNNEhnGtBOTGMXALhCu54bgHHASFrWxy2Obb3Ogq3bHihKxoB
        pJbSvCno/WGeh7CA==
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
Subject: [patch V2 16/58] x86/apic: Sanitize num_processors handling
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:11 +0200 (CEST)
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

