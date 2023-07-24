Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5175F85E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjGXNeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGXNd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:33:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC31E57
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:33:58 -0700 (PDT)
Message-ID: <20230724132045.001111465@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ubhxg5lHvUPqEcRAdngDyy9xlfFoerwPBN8zo0sYJDE=;
        b=Dhq4ahlmOkFNZ8GH00qGQiGuhOWtDHL9pKEDNpCIucyeIWBf2t2zNjzeSPGwr+GS8FYHfs
        JOIfNiauDkbZqWdSZFeDzo3njAQzdukQC7+hjlHKluf6Iswfk9vAOEhlcDgudCgiUu6BMe
        FIB9myAQ/+CK4CbFRPhW002I4rZpnTiNoCNwY7krPTeESo1avXNMMvqY2uvfI5PSLpNZEL
        w40x7ECVDmrQhUk3Lmjp0utziq/aRPt3e1hg1nF+h0CWSBMQD8aZu+iS8cCEG66L2M4Ggw
        /+J9IFm+G8gMjI34ZlXmY+1yTcAID51Q8KvN+sO7t1H6b+mqtt4MxlfO5cWhTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ubhxg5lHvUPqEcRAdngDyy9xlfFoerwPBN8zo0sYJDE=;
        b=6le5v9sTefCMIvuetqWVgfQR8/zvzIA8YS6nSBA8whjTtdynbfHwxgSDNBjkbYSZjjh4My
        VdKMgnpdcrY082Aw==
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
Subject: [patch V2 07/58] x86/apic: Remove unused max_physical_apicid
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:33:56 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/apic.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -74,11 +74,6 @@ EXPORT_SYMBOL_GPL(boot_cpu_physical_apic
 u8 boot_cpu_apic_version __ro_after_init;
 
 /*
- * The highest APIC ID seen during enumeration.
- */
-static unsigned int max_physical_apicid;
-
-/*
  * Bitmask of physically existing CPUs:
  */
 physid_mask_t phys_cpu_present_map;
@@ -2541,9 +2536,6 @@ int generic_processor_info(int apicid, i
 			boot_cpu_apic_version, cpu, version);
 	}
 
-	if (apicid > max_physical_apicid)
-		max_physical_apicid = apicid;
-
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
 #endif

