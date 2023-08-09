Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE6776838
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjHITNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjHITMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2621A2D4F;
        Wed,  9 Aug 2023 12:12:29 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QsdkW04j1Bduy4ECESsEb9beUBdQScODA//fkTgFUCI=;
        b=DQGIqLgVb9ZTYeIzA+O3KTCSf3+iwuj9RTFW9CIqml9cT2Dj4qs+MbygTPDV+Nz+6BUaIa
        iDGI2ROlzMR4xTUwd86wx61yoh2Y6Den7ipKr6/MepRm2VzSLtbGt/kROYyDYy5u3pFP0T
        rNIaR65PAofcL28ODCPmINJtZvPbISpxC9dcvPJrDT6JsZIIGaNcnDBm7MxqBX8+bhU7V6
        GjYOx9tXbxvTd5s6nSdpfoC/3mKRFkqWrW+HyMuvSqpdQtVeN2c927NbP3sIIMg6ieubVH
        GZFyHGCaiFvBdHyi136hYARh+ifvhS0q/bcZOf4WDjCReWUtlweAQGCz1d7Nog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QsdkW04j1Bduy4ECESsEb9beUBdQScODA//fkTgFUCI=;
        b=J1sHgZORUtL5j5ArSBoVHoUM+6sqpkBe+wnS2VLeP0+S46Em1xbHlI+Nh08S46rfncG+Mp
        YIlJigk+oiSp5nAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Sanitize num_processors handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834326.27769.10323770352453532680.tip-bot2@tip-bot2>
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

Commit-ID:     e8122513ff9e92cdc514ad6cbb5c25d551ac3629
Gitweb:        https://git.kernel.org/tip/e8122513ff9e92cdc514ad6cbb5c25d551ac3629
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:50 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:21 -07:00

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
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
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
