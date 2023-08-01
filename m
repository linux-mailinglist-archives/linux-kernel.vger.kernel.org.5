Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512FA76B256
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbjHAKve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjHAKvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:51:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A249D3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:48:43 -0700 (PDT)
Message-ID: <20230801103817.996980460@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Q8bPz8OSR7Dw0div3KJHyiz5smjtpl0ETsImY01rMac=;
        b=YxBqGI1i1OUJtBhM2j5Ghxb2h7CmNslx+ErwQHf2TTWhmdHDc6EVk0tQ04BVFAc2fa8D+m
        M8Ot1DFQFNOL3OBXPpJpSQOetpgLK0xbAQFl3GgqQTJ24bRKJzs4ct0zqM4xQiLIQUCNe+
        QgCmPOZuGFCcxKlOx/h0QoGpfXng24GKNlnkVM9l/P3kEhdzOPpDZ2I5pV3HtnsL0YWNkK
        CInABts2J+ViQ8Lbv55wfUxMTKhX7OGovUNnNQdsacyJTpVhc7+FtiD9Kt54xqDXqy/hLm
        dKcBtP14BfmI3ax9a7K9EOoZken0vr/MAHWqpaUy3PLxavg9eHuXHNSQQmq0lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Q8bPz8OSR7Dw0div3KJHyiz5smjtpl0ETsImY01rMac=;
        b=38ETvICZ3PHedt8pZ667v+ToVqjm87wEQsWaFrWu9bPLMAN/c6ipdtNBwEJNEI2YsXviZ8
        Y1qxF2E+UrrKqFCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>
Subject: [patch V3 52/60] x86/xen/apic: Use standard apic driver mechanism for
 Xen PV
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:45 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of setting the Xen PV apic driver very early during boot, just use
the standard apic driver probing by setting an appropriate
x86_init.irqs.intr_mode_init callback.

At the same time eliminate xen_apic_check() which has never been used.

The #ifdef CONFIG_X86_LOCAL_APIC around the call of xen_init_apic()
can be removed, too, as CONFIG_XEN depends on CONFIG_X86_LOCAL_APIC.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/aa086365-fd02-210f-67c6-5c9175c0dfee@suse.com
---
V3: New patch to address the XenPV fallout
---
 arch/x86/xen/apic.c         |   11 -----------
 arch/x86/xen/enlighten_pv.c |    4 +---
 2 files changed, 1 insertion(+), 14 deletions(-)

--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -158,19 +158,8 @@ static struct apic xen_pv_apic = {
 	.icr_write 			= xen_apic_icr_write,
 };
 
-static void __init xen_apic_check(void)
-{
-	apic_install_driver(&xen_pv_apic);
-}
-
 void __init xen_init_apic(void)
 {
 	x86_apic_ops.io_apic_read = xen_io_apic_read;
-	/* On PV guests the APIC CPUID bit is disabled so none of the
-	 * routines end up executing. */
-	if (!xen_initial_domain())
-		apic_install_driver(&xen_pv_apic);
-
-	x86_platform.apic_post_init = xen_apic_check;
 }
 apic_driver(xen_pv_apic);
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1326,7 +1326,7 @@ asmlinkage __visible void __init xen_sta
 
 	x86_init.resources.memory_setup = xen_memory_setup;
 	x86_init.irqs.intr_mode_select	= x86_init_noop;
-	x86_init.irqs.intr_mode_init	= x86_init_noop;
+	x86_init.irqs.intr_mode_init	= x86_64_probe_apic;
 	x86_init.oem.arch_setup = xen_arch_setup;
 	x86_init.oem.banner = xen_banner;
 	x86_init.hyper.init_platform = xen_pv_init_platform;
@@ -1366,12 +1366,10 @@ asmlinkage __visible void __init xen_sta
 
 	xen_init_capabilities();
 
-#ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * set up the basic apic ops.
 	 */
 	xen_init_apic();
-#endif
 
 	machine_ops = xen_machine_ops;
 

