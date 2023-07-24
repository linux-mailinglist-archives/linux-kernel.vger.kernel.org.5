Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D8D75F885
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGXNh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjGXNgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:36:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E0719B7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:35:46 -0700 (PDT)
Message-ID: <20230724132047.321976097@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QxJCd5EJ/bsG/9bO98P8hnP2UT09lEdt9hSBI73j59Y=;
        b=jnht3IlQUevCKibeWaI+StPW2K0ERqCZ3clERExc/JIXUbdpCQFx8OBDHoo/DKOqOSS0s/
        HhPj/lBlTqE/+bEH736nmA6crF9+IVKNeMjZtG19zxWqGXSSBbRM3V6rwhF/90rbK26FNQ
        QDQOHwOdegXzQs8sRV8YNGBS024hQxK6bQNpopqnlBWSVHgzHZ96tHWPmw7nlPpD+lm7AC
        IP+GKIYW+jv71vAH9NKYiJQ8J5GoQIef/x60DPl6uswYMx3Bb4/MwyEOSidCRGiCdwIAVf
        43GzCDBJOoTyNaba7Ytw/iTEVtL75hwA3D6hHJknVBldPIMwNcfoSXj4AaB4IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QxJCd5EJ/bsG/9bO98P8hnP2UT09lEdt9hSBI73j59Y=;
        b=AN5F9Gs/MbSCtB5xfB1PETttRPQEgma/7jh/RyUdZ684f2wmsczwfJCzK45hkPmRXLeKb1
        Nj5B9y4GAOZdDdCQ==
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
Subject: [patch V2 46/58] x86/apic/noop: Tidy up the code
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:35:03 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all apic_noop can't be probed because it's not registered. So
there is no point for implementing a probe callback. The machine is
rightfully to die when that is invoked.

Remove the gunk and tidy up the other space consuming dummy callbacks.

This gunk should simply die. Nothing should ever invoke APIC callbacks once
this is installed, But that's a differrent story for another round of
cleanups. The comment on top of this file which was intentionally left in
place tells exactly why this is needed: voodoo programming.

In fact the kernel of today should just outright refuse to boot on a system
with no (functional) local APIC. That would spare tons of #ifdeffery and
other nonsense.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/apic_noop.c |   38 ++++++++------------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -8,6 +8,10 @@
  * Though in case if apic is disabled (for some reason) we try
  * to not uglify the caller's code and allow to call (some) apic routines
  * like self-ipi, etc...
+ *
+ * FIXME: Remove this gunk. The above argument which was intentionally left
+ * in place is silly to begin with because none of the callbacks except for
+ * APIC::read/write() have a WARN_ON_ONCE() in them. Sigh...
  */
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
@@ -21,35 +25,10 @@ static void noop_send_IPI_allbutself(int
 static void noop_send_IPI_all(int vector) { }
 static void noop_send_IPI_self(int vector) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
-
-static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip)
-{
-	return -1;
-}
-
-static u64 noop_apic_icr_read(void)
-{
-	return 0;
-}
-
-static int noop_phys_pkg_id(int cpuid_apic, int index_msb)
-{
-	return 0;
-}
-
-static unsigned int noop_get_apic_id(unsigned long x)
-{
-	return 0;
-}
-
-static int noop_probe(void)
-{
-	/*
-	 * NOOP apic should not ever be
-	 * enabled via probe routine
-	 */
-	return 0;
-}
+static int noop_wakeup_secondary_cpu(int apicid, unsigned long start_eip) { return -1; }
+static u64 noop_apic_icr_read(void) { return 0; }
+static int noop_phys_pkg_id(int cpuid_apic, int index_msb) { return 0; }
+static unsigned int noop_get_apic_id(unsigned long x) { return 0; }
 
 static u32 noop_apic_read(u32 reg)
 {
@@ -64,7 +43,6 @@ static void noop_apic_write(u32 reg, u32
 
 struct apic apic_noop __ro_after_init = {
 	.name				= "noop",
-	.probe				= noop_probe,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,

