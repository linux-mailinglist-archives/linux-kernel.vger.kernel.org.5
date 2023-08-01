Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6266E76B22A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjHAKrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjHAKq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:46:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FEAE65
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:46:51 -0700 (PDT)
Message-ID: <20230801103815.539187255@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ubhxg5lHvUPqEcRAdngDyy9xlfFoerwPBN8zo0sYJDE=;
        b=HljuyfyltVKjl7uUiVZetULEOHHh8WkwlwScJKl6TCdEXVfObepUgcquNsKKdS4aUDLy8V
        IA6W7OjmXACp5HOS3d6UzNO8MHi7MBLvXKrFVEcdJ3dH0Em6ivWXD7TBzYL/u3PqDWGcn2
        E1b7umMH+qxLkvGfn1DRd7vabsQKibUBankqLXLMwX59BN2obw9Gk4ZOQjZWfxEfxtrshu
        AOS9IveSr5wTFtY2hVFwqyY1PA0onIICPGHQKYtPysxLUmNF9pJCRfNLNno9PyiZZmNLvL
        3avwIytuPdsNSa4jCg/KebLNO3Rm6oYK2Z1UOtipohDH7Rd1Z59UVLxjp2hiBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ubhxg5lHvUPqEcRAdngDyy9xlfFoerwPBN8zo0sYJDE=;
        b=uN9qJ1q5pSt/Ork14XvpZqsjkS5m5zW+YKrIboGP2K9Liysu+foM74Yw8pSRR/C8OwSdoj
        XRggIUm50W1Q6ADw==
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
Subject: [patch V3 07/60] x86/apic: Remove unused max_physical_apicid
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:46:49 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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

