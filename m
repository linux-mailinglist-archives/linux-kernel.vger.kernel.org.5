Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0079C913
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjILIAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjILH6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:58:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B7710E2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:58:17 -0700 (PDT)
Message-ID: <20230912065502.022650614@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/mf0toaJNTepRqxmdRBH+YrhPsSto1ib/DfMaTt6vf0=;
        b=g45VjkWr4SZn3yjEAj2eWLFNcRhU+UHPjUtzawCFgwj/Glp/er+bg3ogM+X258L6hsbPhd
        8uOzYpmvZJRf5MXhO8pMKfhGcFtfLds6u8ni7NeMIGI6giAtelJvB6oW5/VPgpaszxG82j
        h+O684VQFMepqlCLQxUPWe2WB2U6G0u90vB9vvVITwx7anvS+JQIMtMQxB82rCbHXH5tPy
        M432JypKh6p+rafj1Gyz6gRn2mwi8/MZszvSku1nZuIfMXpYgWlbxbxewAJZFdE46sdJ2+
        RJid0AjY9zasC7LhtRNAFFMuSVdWdAOumkNDXCA/mXDZoNYwjjF9qmIn2xFgtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/mf0toaJNTepRqxmdRBH+YrhPsSto1ib/DfMaTt6vf0=;
        b=/tqFuXrIH08IG44vB+PEpoTe/F4Eob70a3awXZKlp3feakto4GsvX4axyQ/YfZtYZlDYvg
        OyvKE/06FGM4XuDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 20/30] x86/microcode: Sanitize __wait_for_cpus()
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:58:15 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The code is too complicated for no reason:

 - The return value is pointless as this is a strict boolean.

 - It's way simpler to count down from num_online_cpus() and check for
   zero.

  - The timeout argument is pointless as this is always one second.

  - Touching the NMI watchdog every 100ns does not make any sense, neither
    does checking every 100ns. This is really not a hotpath operation.

Preload the atomic counter with the number of online CPUs and simplify the
whole timeout logic. Delay for one microsecond and touch the NMI watchdog
once per millisecond.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/core.c |   41 ++++++++++++++---------------------
 1 file changed, 17 insertions(+), 24 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -324,31 +324,24 @@ static struct platform_device	*microcode
  *   requirement can be relaxed in the future. Right now, this is conservative
  *   and good.
  */
-#define SPINUNIT 100 /* 100 nsec */
+static atomic_t late_cpus_in, late_cpus_out;
 
-
-static atomic_t late_cpus_in;
-static atomic_t late_cpus_out;
-
-static int __wait_for_cpus(atomic_t *t, long long timeout)
+static bool wait_for_cpus(atomic_t *cnt)
 {
-	int all_cpus = num_online_cpus();
-
-	atomic_inc(t);
-
-	while (atomic_read(t) < all_cpus) {
-		if (timeout < SPINUNIT) {
-			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
-				all_cpus - atomic_read(t));
-			return 1;
-		}
+	unsigned int timeout;
 
-		ndelay(SPINUNIT);
-		timeout -= SPINUNIT;
+	WARN_ON_ONCE(atomic_dec_return(cnt) < 0);
 
-		touch_nmi_watchdog();
+	for (timeout = 0; timeout < USEC_PER_SEC; timeout++) {
+		if (!atomic_read(cnt))
+			return true;
+		udelay(1);
+		if (!(timeout % 1000))
+			touch_nmi_watchdog();
 	}
-	return 0;
+	/* Prevent the late comers to make progress and let them time out */
+	atomic_inc(cnt);
+	return false;
 }
 
 /*
@@ -366,7 +359,7 @@ static int __reload_late(void *info)
 	 * Wait for all CPUs to arrive. A load will not be attempted unless all
 	 * CPUs show up.
 	 * */
-	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
+	if (!wait_for_cpus(&late_cpus_in))
 		return -1;
 
 	/*
@@ -389,7 +382,7 @@ static int __reload_late(void *info)
 	}
 
 wait_for_siblings:
-	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC))
+	if (!wait_for_cpus(&late_cpus_out))
 		panic("Timeout during microcode update!\n");
 
 	/*
@@ -416,8 +409,8 @@ static int microcode_reload_late(void)
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 	pr_err("You should switch to early loading, if possible.\n");
 
-	atomic_set(&late_cpus_in,  0);
-	atomic_set(&late_cpus_out, 0);
+	atomic_set(&late_cpus_in, num_online_cpus());
+	atomic_set(&late_cpus_out, num_online_cpus());
 
 	/*
 	 * Take a snapshot before the microcode update in order to compare and

