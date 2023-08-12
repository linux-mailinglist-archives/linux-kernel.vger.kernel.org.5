Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9777A248
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjHLUCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjHLUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:02:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F1E1FE7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:01:41 -0700 (PDT)
Message-ID: <20230812195729.097937370@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/mf0toaJNTepRqxmdRBH+YrhPsSto1ib/DfMaTt6vf0=;
        b=ugkIvFOaucjW/r7xM473OXfvK5pcVN3cknssl6tn+vYvunLZ6W+hSQkCtmIXvfA73xRLSm
        hPAzDXdozz4dj4vvIDkTPpuRA2ORtFo6x0+kt0gJW3DdiXGWjnHfoH84+kTHGbTObDexwb
        HPwk3+o2eG0sTkMTDGUU+DbnDGeN7J547WHDVEx/SwgZFL7QvTNt0eF6tcXQ2Il5fPt5tm
        ZzlxXsZ8f34v8J3lRgVWYidPt2dxJfLPCKmONlVLz/gZwUsOt6xHDuEXTSNjBu1IubYHQm
        8cGtHdeLM0eBszebHkIBO6FKYl5mnXjR8m/o8SeZD7V/7n7yW3UV4q57WEmccA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/mf0toaJNTepRqxmdRBH+YrhPsSto1ib/DfMaTt6vf0=;
        b=JKRJwqneRt2yMIREkHo8laWhBjmhaaOEaLFiuW5MU6G31/bb3r7ODSBZG7tmt/NPGGFAJ5
        daJHOharoQ7aZXAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 27/37] x86/microcode: Sanitize __wait_for_cpus()
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:18 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

