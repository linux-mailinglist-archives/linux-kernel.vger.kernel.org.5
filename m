Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480FB76B237
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjHAKsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbjHAKrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:47:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5122133
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:05 -0700 (PDT)
Message-ID: <20230801103816.145455909@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6qIRs7n/9rrrflFIJeawzXHaVLgyJbrokbfl4taony4=;
        b=OLfUT9n1mUZyw5TECgbWAB5jfUJ52UrvxCKcdeBeSS+iYQgLuwWYiA3m6lc+1Bjd420tMf
        NvaC9yrqKrOYfGOiTgKeMDAHMSEC1NU2OZnm0I8KN5422y5ZIXCWFdQz04M2b76EmEPDTC
        7HOsC3qZUM+W59b42id+MtTuQg0KlzTMrzD22AVJPJPdCrt70pzEfSgK+uq4PTLNe6d29Q
        PRMyGAb/KXuWxB5J/8pGP1kSO2DJXCa1G+00W0IE5mMrRS7fasluWbmKsZ2iHr5PZJMled
        5iUdhst071WDCZ8dvAlRFyXaK1xSxnIPEQGl4MT4CJ+1kseIe2e5gHkN9SL0mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=6qIRs7n/9rrrflFIJeawzXHaVLgyJbrokbfl4taony4=;
        b=31sXViTLfNTTpcZVXA5t7x3tRVJZ2cGy49vy5qSl04ETXzv1N63xVYH/9ppPNU0ig73l6Q
        iqZMOqOaZVOJ3nCw==
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
Subject: [patch V3 18/60] x86/apic: Nuke another processor check
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:03 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
 

