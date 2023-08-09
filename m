Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C28776A42
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjHIUgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjHIUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22882125;
        Wed,  9 Aug 2023 13:36:11 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vZC+MMNaenBhj07GBnw7x7mIB9D3DZZseP5+hGYx4qs=;
        b=OXUnqFYfNZqjfT0H+Ruj+UvzDc8q/z2rg8a5zvhdijlFEki5ZP2k3zfmXz0uEuFySIS9dR
        AxKVNDO7msEIithSCIrJdLHLUojY4UKX8EH48RqEKK0AsmjkhyactD6icRyhQBfqosIjka
        jNr4okqx1Kk9sdBpLzV0Fzr5fXsQsSCBiJKSHdhVA+nIoKmMN660qlJrebxzF5u+M1GmIo
        SVbQ7zti9BEnuYsyr75Xz4mLCsZvMxH/9x/aQH9ufLphja0LFhj3hDU5721q9aVxft5AmX
        QBa1NweRJdl3Iezx7ZEwDvD2FwF3wazOG8uUMBVpyP6Kp3DDFkt9pVMS69kiEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vZC+MMNaenBhj07GBnw7x7mIB9D3DZZseP5+hGYx4qs=;
        b=OJTTjtQ3mSgbhJ0YYWcZJ2eFJVeoclMLCouDb38IkVgxj1cpZLr1UveBTvh1d2WWMFZ5l5
        6q+7VrWG024OhwCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/noop: Tidy up the code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336997.27769.6634475409776925662.tip-bot2@tip-bot2>
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

Commit-ID:     3600ceb0df845beb7a204ab599aaff1213129314
Gitweb:        https://git.kernel.org/tip/3600ceb0df845beb7a204ab599aaff1213129314
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:04:14 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:33 -07:00

x86/apic/noop: Tidy up the code

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/kernel/apic/apic_noop.c | 38 ++++++-------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 28b693b..e33bea0 100644
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
@@ -21,35 +25,10 @@ static void noop_send_IPI_allbutself(int vector) { }
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
@@ -64,7 +43,6 @@ static void noop_apic_write(u32 reg, u32 val)
 
 struct apic apic_noop __ro_after_init = {
 	.name				= "noop",
-	.probe				= noop_probe,
 
 	.delivery_mode			= APIC_DELIVERY_MODE_FIXED,
 	.dest_mode_logical		= true,
