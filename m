Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5745A776A38
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjHIUg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbjHIUgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1222111;
        Wed,  9 Aug 2023 13:36:09 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8GaGJ3bnBR3FDNAqc73b+69m9a1DR32bbhdN0uUW04w=;
        b=g7fDQ2FWSDaX3naCXC9Z3yWPfqDwuQYvEASUoxQo9q+f9X4xq93uYAxEm2fdqFZmBQqPHu
        ND+ayNLEYUkhVGAeBRXnZYOrG0eLM8odhbHmlpqRdKCoUAbLzh2povBXnk/XV9T65ss/Am
        KFLTIyAYHY1wNHnjykZQtFrZPI7Wj23DbIXWnaf2K9iMygRdmE29GBMyd9LmQGlqVvq+NA
        fDAH9eTmfCTSpC8P+1Y/P5rMzjGMmLCVGfH5nSmPtZxYfDIZNa5sBKVao7k0FYCFBSCX6N
        EJ+SpLWm2Ykdg5Kkc8yQMwi3Oc9WYYTdow5q/WT+agk7urN1XOOtYQh0EclVvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8GaGJ3bnBR3FDNAqc73b+69m9a1DR32bbhdN0uUW04w=;
        b=/mH8eBUIgwJkGISBrGaShXVDbBjb/wjTUZNrU6cuybgUaNsOgpTZcrGbU+ytRqCyKjsX6Q
        VMO51TtQX9uOASCA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/xen/apic: Use standard apic driver mechanism for Xen PV
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <aa086365-fd02-210f-67c6-5c9175c0dfee@suse.com>
References: <aa086365-fd02-210f-67c6-5c9175c0dfee@suse.com>
MIME-Version: 1.0
Message-ID: <169161336764.27769.5356778195879024330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     3b5244bef15e0ec2b51ae5ea4182e1b674d01551
Gitweb:        https://git.kernel.org/tip/3b5244bef15e0ec2b51ae5ea4182e1b674d01551
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 08 Aug 2023 15:04:18 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 12:00:41 -07:00

x86/xen/apic: Use standard apic driver mechanism for Xen PV

Instead of setting the Xen PV apic driver very early during boot, just use
the standard apic driver probing by setting an appropriate
x86_init.irqs.intr_mode_init callback.

At the same time eliminate xen_apic_check() which has never been used.

The #ifdef CONFIG_X86_LOCAL_APIC around the call of xen_init_apic()
can be removed, too, as CONFIG_XEN depends on CONFIG_X86_LOCAL_APIC.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
Link: https://lore.kernel.org/lkml/aa086365-fd02-210f-67c6-5c9175c0dfee@suse.com
---
 arch/x86/xen/apic.c         | 11 -----------
 arch/x86/xen/enlighten_pv.c |  4 +---
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 1838aef..315ffd8 100644
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
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 93b6582..c393c44 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1326,7 +1326,7 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 
 	x86_init.resources.memory_setup = xen_memory_setup;
 	x86_init.irqs.intr_mode_select	= x86_init_noop;
-	x86_init.irqs.intr_mode_init	= x86_init_noop;
+	x86_init.irqs.intr_mode_init	= x86_64_probe_apic;
 	x86_init.oem.arch_setup = xen_arch_setup;
 	x86_init.oem.banner = xen_banner;
 	x86_init.hyper.init_platform = xen_pv_init_platform;
@@ -1366,12 +1366,10 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 
 	xen_init_capabilities();
 
-#ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * set up the basic apic ops.
 	 */
 	xen_init_apic();
-#endif
 
 	machine_ops = xen_machine_ops;
 
