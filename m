Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AE276B223
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjHAKqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjHAKqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:46:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F08E9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:46:43 -0700 (PDT)
Message-ID: <20230801103042.936020332@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=gddeRoPs5mtWh3jrpXwXoH25By/eZKLOXLpdHngWqR0=;
        b=I1dTGQAirB5sJR3ctSAkVS9Oh+mvQFxVYJ7rWzu3UtqI2P4IchZWhj9m9zrVQCcqU5qiKE
        ZJ/oFNr248bBs10UGv4n+a4nIxfSHjAvs4cFDTNmVDlsbJYB/pkor+2Q2A8duFG69tUUZZ
        Jw/R0FH+9kI74gM0ZnIRkhD8OUlvJoPPwp5H84juT5zhtH/RcbsgOYpcnh8/0kiywBqnfj
        rnR2XIyR47Fgx0zW/sdG9e4IBXzFtJMAeoHBKQt4LqthjSCRA8hknmkWFgRF3DfkJvYbOJ
        mPyUwVjEMTHQKUk6pbethfBdvXRLmvHkhadmO6MLPoqfSnPXC0awjia2m87tuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=gddeRoPs5mtWh3jrpXwXoH25By/eZKLOXLpdHngWqR0=;
        b=q6eh3XeA/G4+3zXgklBxQMDXUJanqiYCYHYxZ4gNsXBDLiovFedgiUz3BaUIgKlCBzC16n
        hhpztFYheqoJABCg==
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
Subject: [patch V3 00/60] x86/apic: Decrapification and static calls
Date:   Tue,  1 Aug 2023 12:46:41 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the follow up to:

  https://lore.kernel.org/lkml/20230724131206.500814398@linutronix.de

which addresses the XEN PV fallout decoded by Juergen.

TLDR: This cleans up accrued and partially unused gunk in order to convert
the APIC callbacks to static calls.

The changes vs. V2:

  - Unbreak XEN/PV - Juergen

    Resulting delta patch below.

  - Rebased to 6.5-rc4 in preparation for the CPUID overhaul on top, which
    has some collisions due to the recent mitigation muck.

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git apic-static-call-v3

Thanks,

	tglx
---
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 468406f511ff..7ad91225fdf4 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -155,20 +155,9 @@ static struct apic xen_pv_apic __ro_after_init = {
 	.icr_read			= xen_apic_icr_read,
 	.icr_write			= xen_apic_icr_write,
 };
-
-static void __init xen_apic_check(void)
-{
-	apic_install_driver(&xen_pv_apic);
-}
+apic_driver(xen_pv_apic);
 
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
-apic_driver(xen_pv_apic);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 93b658248d01..c393c44892ac 100644
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
 
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index c6b42c66c60c..a0f07bbfcd6e 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -182,7 +182,8 @@ static void __init _get_smp_config(unsigned int early)
 	if (subtract)
 		set_nr_cpu_ids(nr_cpu_ids - subtract);
 #endif
-
+	/* Pretend to be a proper enumerated system */
+	smp_found_config = 1;
 }
 
 static void __init xen_pv_smp_prepare_boot_cpu(void)


