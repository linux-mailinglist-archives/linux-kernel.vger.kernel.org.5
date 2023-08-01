Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66D176B23E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHAKtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjHAKsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:48:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75332113
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:20 -0700 (PDT)
Message-ID: <20230801103816.638137038@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XhABCxwHPGY7DF2UNzN4o5WpsX1JegdIqFCLm4OuXKU=;
        b=ZLJEXzsJtJYGRrxFytcloiCsPbo6DqPVeh8GFOjdTD/P9EvePOxkscKnA6aOO9mvH1unrL
        Y5NLH2mAfWlBpAGsoWlacrOyInhzSmDcL1G9jravJrzZ0G8HR0Vjhn1LNETu3HM3l/IeC2
        zjHqfO8nUHHhMi/6zsEwlAQV9pYRncra/NONW2RwLgxCpbAjnqCn7seCryVh2nI5FwcqNY
        /HKORR4B6yTSpzikvN6OLlu8u768Kh9bCbD81+SmQGYRwb593+V81ERkdQWBhKkhExgTER
        btvfRgyPUP+nsKov9XAGpyWCBza8QlujwuGrJH6KUdQLgWxF5MYHjt0DsL6smw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XhABCxwHPGY7DF2UNzN4o5WpsX1JegdIqFCLm4OuXKU=;
        b=Up0KUSj8J7MVjxiRALiNOwtofePybPN5BfjmopOobB8WDGZKPQm8PksdLK/zwX1Yutw08L
        qE5gagXEVSw4clBg==
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
Subject: [patch V3 27/60] x86/apic/32: Remove bigsmp_cpu_present_to_apicid()
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:14 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a copy of default_cpu_present_to_apicid() with the omission of the
actual check whether the CPU is present.

This APIC callback should die completely, but the XEN APIC implementation
does something different which needs to be addressed first.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/bigsmp_32.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -43,14 +43,6 @@ static void bigsmp_setup_apic_routing(vo
 		nr_ioapics);
 }
 
-static int bigsmp_cpu_present_to_apicid(int mps_cpu)
-{
-	if (mps_cpu < nr_cpu_ids)
-		return (int) per_cpu(x86_cpu_to_apicid, mps_cpu);
-
-	return BAD_APICID;
-}
-
 static void bigsmp_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap)
 {
 	/* For clustered we don't have a good way to do this yet - hack */
@@ -119,7 +111,7 @@ static struct apic apic_bigsmp __ro_afte
 	.init_apic_ldr			= bigsmp_init_apic_ldr,
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.setup_apic_routing		= bigsmp_setup_apic_routing,
-	.cpu_present_to_apicid		= bigsmp_cpu_present_to_apicid,
+	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 	.apicid_to_cpu_present		= physid_set_mask_of_physid,
 	.phys_pkg_id			= bigsmp_phys_pkg_id,
 

