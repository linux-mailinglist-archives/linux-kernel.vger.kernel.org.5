Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8417726C4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjHGNzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbjHGNwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:52:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D410EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:52:44 -0700 (PDT)
Message-ID: <20230807135026.750360590@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ywrW7M6Fms0CIM+WhzKuJj3dJ+Q03lWwDFSQkWbNJj4=;
        b=duVsiKR3IhfLqm1YxgowBgn9OsTg7/0Em3YJSm/4NOr/GAa1YAq3Zl62aXNCjUhXG7gXCw
        9JkbKk1zt6fH103uC6AeyBWd0ltnnPU5RKtOl87wdUMLN8WQCNccbrXMI2GvXRBCFO1vox
        QmbRnJ/oEMYVDiefiE7q9G6hMR2zADvgwG/pQZgDT815jTOlk8dv4ZMzCvEWBaYxeIgel8
        E9Nl6okjjmNsU59T1njcSoM/ZtI1s4c4t50iH9FUBtif569Si55sE/NUBA0mTy0x0L4TBM
        Hm1NPILRCRuSXHYfMlcz5/GIdvSAH1pcKhP8XYxBRQM0zH78JjrtW2rMpJzruw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ywrW7M6Fms0CIM+WhzKuJj3dJ+Q03lWwDFSQkWbNJj4=;
        b=z/LJe82IgSIz5k4djTUhMxGR5alkqU8dX/ygjvlLM9X9uYOcnyFJVM266DrIoMtCxFacUQ
        /aCl7d38FjGQZODg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 06/53] x86/ioapic: Make io_apic_get_unique_id() simpler
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:42 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to go through APIC callbacks. It's already established that this is
an ancient APIC. So just copy the present mask and use the direct physid*
functions all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |   22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2498,17 +2498,9 @@ static int io_apic_get_unique_id(int ioa
 	unsigned long flags;
 	int i = 0;
 
-	/*
-	 * The P4 platform supports up to 256 APIC IDs on two separate APIC
-	 * buses (one for LAPICs, one for IOAPICs), where predecessors only
-	 * supports up to 16 on one shared APIC bus.
-	 *
-	 * TBD: Expand LAPIC/IOAPIC support on P4-class systems to take full
-	 *      advantage of new APIC bus architecture.
-	 */
-
+	/* Initialize the ID map */
 	if (physids_empty(apic_id_map))
-		apic->ioapic_phys_id_map(&phys_cpu_present_map, &apic_id_map);
+		apic_id_map = phys_cpu_present_map;
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
 	reg_00.raw = io_apic_read(ioapic, 0);
@@ -2520,14 +2512,10 @@ static int io_apic_get_unique_id(int ioa
 		apic_id = reg_00.bits.ID;
 	}
 
-	/*
-	 * Every APIC in a system must have a unique ID or we get lots of nice
-	 * 'stuck on smp_invalidate_needed IPI wait' messages.
-	 */
-	if (apic->check_apicid_used(&apic_id_map, apic_id)) {
-
+	/* Every APIC in a system must have a unique ID */
+	if (physid_isset(apic_id, apic_id_map)) {
 		for (i = 0; i < broadcast_id; i++) {
-			if (!apic->check_apicid_used(&apic_id_map, i))
+			if (!physid_isset(i, apic_id_map))
 				break;
 		}
 

