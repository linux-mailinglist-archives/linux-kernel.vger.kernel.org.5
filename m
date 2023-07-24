Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFFC75F867
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGXNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjGXNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:34:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB05211E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:34:22 -0700 (PDT)
Message-ID: <20230724132045.614331630@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6qIRs7n/9rrrflFIJeawzXHaVLgyJbrokbfl4taony4=;
        b=yeHEihXy381bMxg0/berhdUeLmV4Qg9sbpFO01ntVycKkAtyqwA9OJJ58t8UxqG9i8dtaz
        gge4YJEyfgQnvji8/cElTBmP/j2g94LqLZrUadi3aOTwJxhYc5te42NXdt7zRv2HX3BcEU
        5TAYlvp3rSXNpW6b+YSkFkD0PuvGME1PimooGOk4PQ3z9jqQwxFAJaHsQn9GmaNHthdhhn
        ZAnxIpYfmvv5IK1niDrCuhRbr+8/ViWGkkZZzJwoKIb4c8Rup6Q0WoJt0TYzDfqUZ8ngjJ
        H/6O86YehJaqRfRksiE5cTtdQAM95dN9G2Lv/FH2iPBRA+lQdpYKVCqnDQ6EsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6qIRs7n/9rrrflFIJeawzXHaVLgyJbrokbfl4taony4=;
        b=hS+QON+pKFsEgAFNZ2BSK1ClN3+9JScu5V9ULvbIxew7wwmdyIbbotKCCHnd8mRlvyqZz9
        3r6T1Z04/+H87NCw==
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
Subject: [patch V2 17/58] x86/apic: Nuke another processor check
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:13 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boot CPUs local APIC is now always registered, so there is no point to
have another unreadable validatation for it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/smpboot.c |   17 -----------------
 1 file changed, 17 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1181,23 +1181,6 @@ static void __init smp_sanity_check(void
 		set_nr_cpu_ids(8);
 	}
 #endif
-
-	if (!physid_isset(read_apic_id(), phys_cpu_present_map)) {
-		pr_warn("weird, boot CPU (#%d) not listed by the BIOS\n",
-			read_apic_id());
-
-		physid_set(read_apic_id(), phys_cpu_present_map);
-	}
-
-	/*
-	 * Should not be necessary because the MP table should list the boot
-	 * CPU too, but we do it for the sake of robustness anyway.
-	 */
-	if (!apic->check_phys_apicid_present(boot_cpu_physical_apicid)) {
-		pr_notice("weird, boot CPU (#%d) not listed by the BIOS\n",
-			  boot_cpu_physical_apicid);
-		physid_set(read_apic_id(), phys_cpu_present_map);
-	}
 	preempt_enable();
 }
 

