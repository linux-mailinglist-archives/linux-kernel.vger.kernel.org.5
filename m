Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF876AA01
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjHAHap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjHAHan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:30:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0829410C7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:30:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690875039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKDi45RomPDaPvITn2bWtKKG+mSthkZD2kX8a9WVFsc=;
        b=UBCkqOYUywdrudkzkXzX84s89+hbkiIPqcwIz1U/JJp53kDXZdg3/tU/nONin6pniSevOB
        Iy/hR2llds/Xd95bqj5h1OOTCEFhmqltI9ddrgpqiM8kr+k+KaRSYq9XuF74/d9QvW8gl5
        X2/UlCnv1nwe4rf69xNX1s6rmXRgCmMkbGlE7T2V4V4ClcBPZyZFxbp+DCWC/PIFKipCWm
        CyZCU6Fk4vzZtBXhVzAG6zxJOy7koynq04Op3O8QD3dVCm9IUwX0QcNVaOd1TGZxbweTt8
        gNPp6JWXHdUaKGKFDcabebHbjxpn3kpCCZK+aQRFQD9RewuoTaBk/grJ5dkPUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690875039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKDi45RomPDaPvITn2bWtKKG+mSthkZD2kX8a9WVFsc=;
        b=/C2cSUOk8Ky7Z0o6OODwjZR22tbf37P+eRNlDgdDy654NZMF8QqMc/9ojyJ2E1j3ZS0FnJ
        Wq3CX52wJRS84OAA==
To:     Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
In-Reply-To: <87v8dzl0wm.ffs@tglx>
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
 <87v8dzl0wm.ffs@tglx>
Date:   Tue, 01 Aug 2023 09:30:39 +0200
Message-ID: <87r0onkyn4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01 2023 at 08:41, Thomas Gleixner wrote:

> On Mon, Jul 31 2023 at 17:48, Thomas Gleixner wrote:
>
>> On Mon, Jul 31 2023 at 15:10, Juergen Gross wrote:
>>> On 31.07.23 15:01, Thomas Gleixner wrote:
>>>>>    apic_driver(xen_pv_apic);
>>>> 
>>>> I wonder whether this explicit install is actually needed at all.
>>>> Shouldn't the driver be installed via the APIC probing mechanism
>>>> automagically?
>>>
>>> Only in case x86_init.irq.intr_mode_init is set appropriately. Today it is
>>> a nop for Xen PV, but that can be changed. I'll have a look.
>>
>> You could simply set that callback to default_setup_apic_routing() and
>> be done with it.
>
> Doesn't work because XEN overrides it already. So sure, lets just go
> with the solution you proposed. One more ugly or less in XEN/PV does not
> really matter much :)
>
> Let me grab this and put it into the right position in the queue.

Spoke too early. The below should work AFAICT from the code.


--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -99,10 +99,7 @@ static void xen_apic_icr_write(u32 low,
 
 static int xen_apic_probe_pv(void)
 {
-	if (xen_pv_domain())
-		return 1;
-
-	return 0;
+	return xen_pv_domain();
 }
 
 static int xen_madt_oem_check(char *oem_id, char *oem_table_id)
@@ -157,20 +154,14 @@ static struct apic xen_pv_apic = {
 	.icr_read 			= xen_apic_icr_read,
 	.icr_write 			= xen_apic_icr_write,
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
+	/*
+	 * On PV guests the APIC CPUID bit is disabled so none of the
+	 * routines end up executing.
+	 */
+	apic_install_driver(&xen_pv_apic);
 }
-apic_driver(xen_pv_apic);
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1325,7 +1325,7 @@ asmlinkage __visible void __init xen_sta
 	x86_platform.realmode_init = x86_init_noop;
 
 	x86_init.resources.memory_setup = xen_memory_setup;
-	x86_init.irqs.intr_mode_select	= x86_init_noop;
+	x86_init.irqs.intr_mode_select	= xen_init_apic;
 	x86_init.irqs.intr_mode_init	= x86_init_noop;
 	x86_init.oem.arch_setup = xen_arch_setup;
 	x86_init.oem.banner = xen_banner;
@@ -1366,13 +1366,6 @@ asmlinkage __visible void __init xen_sta
 
 	xen_init_capabilities();
 
-#ifdef CONFIG_X86_LOCAL_APIC
-	/*
-	 * set up the basic apic ops.
-	 */
-	xen_init_apic();
-#endif
-
 	machine_ops = xen_machine_ops;
 
 	/*
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -118,7 +118,11 @@ static inline void __init xen_init_vga(c
 
 void xen_add_preferred_consoles(void);
 
+#ifdef CONFIG_X86_LOCAL_APIC
 void __init xen_init_apic(void);
+#else
+# define xen_init_apic	x86_init_noop
+#endif
 
 #ifdef CONFIG_XEN_EFI
 extern void xen_efi_init(struct boot_params *boot_params);
