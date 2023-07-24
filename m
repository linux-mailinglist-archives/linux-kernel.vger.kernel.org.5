Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6885875F870
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjGXNgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjGXNfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:35:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E910D1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:35:10 -0700 (PDT)
Message-ID: <20230724132045.915729323@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b8Xt5cYn7tsxj5f5GzHs5GjoZDN6ZZKDqaLjg/BbaXY=;
        b=hyVDnZMm328zZyvf5QBemGKZs+Q2iE0T1EdrVijsFxWqAS2fUUxpP8WALjYfMR+YwppUbY
        qHAFXvKGC9M8pqE9cI+U/AjvUK1RwJRJbPFlI1hBkqMVOdClqwyBKhMUlZtDEFl5yKtVeS
        H5QFXU6FiJOW4MocZSvwsBTBvU6ft6bekujhK0qJwclAviiwJf54FzRUWRoHBLf/5jy5XX
        U3VjGCIrF+y2bzUP1eH7FedSCFuUdr6JJl/TJjhMkRnurmJ+DWLcc/dhgAGuQFovH9jgbD
        PDhMWjMfw6Nrw28K331XGg+d9wHv/jtn41npDI5DsnwqRnxvI1UlMB9yfgfVxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=b8Xt5cYn7tsxj5f5GzHs5GjoZDN6ZZKDqaLjg/BbaXY=;
        b=oNFcrUX9MSZdx8ndzCs18KMcIfoCWf+qfisJhR231Lqe7MP6altfQ9GLb98G94mZYBp0ul
        PYJAF/u6OclYjIAw==
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
Subject: [patch V2 22/58] x86/apic/ipi: Code cleanup
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:22 +0200 (CEST)
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

