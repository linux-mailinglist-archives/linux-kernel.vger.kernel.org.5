Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119AB75705D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjGQXQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGQXP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:15:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC62A1BE9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:15:06 -0700 (PDT)
Message-ID: <20230717223224.087678447@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XkrXDbsHY2D9ad8FanhOEsbWH/XRHFiUnXbnPluBQA4=;
        b=qHr9oU0r8qd75flp4JICvC2WzEGZhBOzfBTH3weDwjKcfD6yYyGalQdW4miVeRgWj0l2e/
        tIDwfzYN6GoMqSDz2C9DJDCM2DFUEtyol2WRxlDye+RWteoV9blj8j1+KozQJQlZvu9Qo8
        XuFhXBO9qA6pYyfvhWleXKXTiw7IjJko1rC/K63sU+BkFiX2YhaO/4iEWZqfizTTIFMPeB
        ifAgFG8CjrNLaQ2LP0KVQR8U/PW+1xWjo8JhDNmjTccvNR3jtSAfRzQvk1HGSb7wBS+NAf
        NswX7cpXaJtqH6x9MQpUsffedDA9nI9KrDeKCFwpMdRD0Xu4zfd7Fl7ZISn68g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XkrXDbsHY2D9ad8FanhOEsbWH/XRHFiUnXbnPluBQA4=;
        b=Y2epMBLyA0KIYVFu+nXXQ8o2u/0MgriTKxN4OMyc74CJxKXayyzEDBjmXwEq0julz01liv
        r0SLracH4XiXNzBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 17/58] x86/apic: Nuke another processor check
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:00 +0200 (CEST)
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
 

