Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2DB757085
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjGQXcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjGQXcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:32:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C035C173A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:31:27 -0700 (PDT)
Message-ID: <20230717223225.815511531@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tK1J3NRXP+lZRakGxXxjlSskh2I2ErwFZpn4/I2Qug8=;
        b=z+8xD/FiHJ9sr/IZ44QFKo65qGiyCig5Yc9pVVKeRxKO5Om5Susr9bNe7gA/wQoR+WSXo1
        sIkwkb2ciVPCECWtrGSkoKg4j15iGKWvESRI0sf1I79+p8I/tHGy9OQHO38rLLhgvwFqhP
        qhPpCBWARB3+wFKelnZ8IVeRQwPYPsrEQpzBpAe985A5er13fJ0f8z/0eiWtYif/HYaCkm
        yqw+iMUa0PzuwnqtoBEHqlbPlE1YyGjPKvb5RUdDGt9gT/9TXVKR+GzZCGULxJsSlY62Ri
        MSgWRww7o0hy7eJd4Xi5Mz76uYfVNtZ6gh6r0FnH2NkPmGG7wftxpgNfDce+4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tK1J3NRXP+lZRakGxXxjlSskh2I2ErwFZpn4/I2Qug8=;
        b=qQ7Hm4RcJivTCfhDxjNKiu6l+PxZgwY9s/INSRHRjcQSHhxJnOCdVav5b4/dGHJIE4wQhO
        w4PkOGEA+hvCNEAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 46/58] x86/apic/noop: Tidy up the code
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:46 +0200 (CEST)
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

