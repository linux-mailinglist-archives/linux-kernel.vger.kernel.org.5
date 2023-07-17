Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8372A757061
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjGQXQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjGQXQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:16:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002A4132
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:15:42 -0700 (PDT)
Message-ID: <20230717223224.387322230@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oBy16z9oVs8uzIdM6vzKosS3I9qeD3Jk8eFl+Cs6+fk=;
        b=tmIcEk9XpjQcUhC77tzrt+q6FJfA7Knf1Ts0BMgMqrctHb+QoRjibisDoJ+IlNuvLYbdHv
        Y3t5PbjQ34QB12uGL4rRDgtbBlTsBEQM1vUxhslhlp+EL0AXi6WVOspkW3vWriRoDHWIcF
        21rlQp09gIBPBDTSx5doUgfDue9Dj3Lope9QbyjBGRcC+4Cm52sVTdR9caVuRM9ub1XIyf
        VeDbUgz7AcsvfhZUDIy3CS8yderQtxaVl1K0cR6ELUAAA0RG9Mv6X6IA57H6O05F5gE60d
        8U9Y6un/5bfDVB6EWESnD706BJrJHTDUmKTYhdgwzI0qnB0Fppl2yyODXwiD+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oBy16z9oVs8uzIdM6vzKosS3I9qeD3Jk8eFl+Cs6+fk=;
        b=OMBprqP0VGos8jmJkNRVP95C0AxZwsyctJ+1dU9Xsy94RSKAwUReBcNWlf5zFtOlMcIbqH
        rmyWLpGg2NiFaDAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 22/58] x86/apic/ipi: Code cleanup
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:08 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove completely useless and mindlessly copied comments and tidy up the
code which causes eye bleed when looking at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/ipi.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -184,18 +184,13 @@ void default_send_IPI_single_phys(int cp
 
 void default_send_IPI_mask_sequence_phys(const struct cpumask *mask, int vector)
 {
-	unsigned long query_cpu;
 	unsigned long flags;
+	unsigned long cpu;
 
-	/*
-	 * Hack. The clustered APIC addressing mode doesn't allow us to send
-	 * to an arbitrary mask, so I do a unicast to each CPU instead.
-	 * - mbligh
-	 */
 	local_irq_save(flags);
-	for_each_cpu(query_cpu, mask) {
+	for_each_cpu(cpu, mask) {
 		__default_send_IPI_dest_field(per_cpu(x86_cpu_to_apicid,
-				query_cpu), vector, APIC_DEST_PHYSICAL);
+				cpu), vector, APIC_DEST_PHYSICAL);
 	}
 	local_irq_restore(flags);
 }
@@ -203,18 +198,15 @@ void default_send_IPI_mask_sequence_phys
 void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask,
 						 int vector)
 {
-	unsigned int this_cpu = smp_processor_id();
-	unsigned int query_cpu;
+	unsigned int cpu, this_cpu = smp_processor_id();
 	unsigned long flags;
 
-	/* See Hack comment above */
-
 	local_irq_save(flags);
-	for_each_cpu(query_cpu, mask) {
-		if (query_cpu == this_cpu)
+	for_each_cpu(cpu, mask) {
+		if (cpu == this_cpu)
 			continue;
 		__default_send_IPI_dest_field(per_cpu(x86_cpu_to_apicid,
-				 query_cpu), vector, APIC_DEST_PHYSICAL);
+				 cpu), vector, APIC_DEST_PHYSICAL);
 	}
 	local_irq_restore(flags);
 }
@@ -283,7 +275,6 @@ void default_send_IPI_mask_logical(const
 	local_irq_restore(flags);
 }
 
-/* must come after the send_IPI functions above for inlining */
 static int convert_apicid_to_cpu(int apic_id)
 {
 	int i;

