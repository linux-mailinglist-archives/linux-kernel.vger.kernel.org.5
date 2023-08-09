Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F917763CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjHIPeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjHIPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113D21FEF;
        Wed,  9 Aug 2023 08:34:15 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pgKbflyUHw7shyB7LD5B16qyAlPeSkn2hMj3MnazB9E=;
        b=FsKOjyqPHSdbNrDMljfXVQ+En/ix2KPBpGJnIV5yLXxOZhlKjEBfYzVQL5A1PiNH+1Q5KF
        KBR1zlt+3LoWqF7AGJhXTEzhUVLUHxjdRoqreusMaXgJTgz1ATuEtMri4SDkoGbaKzEIoz
        U9cazeuuNp6EZM9ibYuQy9vLvTDubgsAkD3tWCE0xzXOwpFl/K3n6SvqLKVotp8U6tGR46
        vQoiKpoY4PeQnSTL9EmN3n5njXkQARsmgW8hh6fz8WPd4l2h01Yo73EWsOfcPJ8HOacFQ1
        Nv+3/ZG8vMu2AB+fbc7yU/FfBpkcuWoA/cZvzyiNWiUi5Gs7n4Bq0RCDqrNpLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595253;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pgKbflyUHw7shyB7LD5B16qyAlPeSkn2hMj3MnazB9E=;
        b=GKQ3rP0zruRgZ/V6u2MahjrD5yADDsFK0qxo/ilNkoPnNBzAErgvH+AOK3ghoui+xEiZvC
        MWo4v/UOVhhP6nCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Sanitize num_processors handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525313.27769.4574173069062588533.tip-bot2@tip-bot2>
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

Commit-ID:     90d584c599a6e7e4aa577a45ec925855d2215ade
Gitweb:        https://git.kernel.org/tip/90d584c599a6e7e4aa577a45ec925855d2215ade
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:50 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:11 -07:00

x86/apic: Sanitize num_processors handling

num_processors is 0 by default and only gets incremented when local APICs
are registered.

Make init_apic_mappings(), which tries to enable the local APIC in the case
that no SMP configuration was found set num_processors to 1.

This allows to remove yet another check for the local APIC and yet another
place which registers the boot CPUs local APIC ID.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/apic.c |  9 ++++++---
 arch/x86/kernel/smpboot.c   | 18 ------------------
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 84ff5b2..564d584 100644
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
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5467c58..fc2173b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1397,24 +1397,6 @@ __init void prefill_possible_map(void)
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
