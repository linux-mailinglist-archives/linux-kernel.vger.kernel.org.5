Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBEA7D0ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377453AbjJTLjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377407AbjJTLi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:38:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF60B1FE6;
        Fri, 20 Oct 2023 04:38:07 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCuiTwxOEeQPdkNesnDq60kBaeq+ULJll4LvEfr8PA8=;
        b=OHMAhqh89cCwJN3I+zgRkImtX6KAbqeh64ALIOz3IlxzfWkafhkn47jUpeJkMj2eytvTYU
        aImFG47Awtn859Goo1XHZEvyAyQmvcNQMLF5acnBo01OoGTX0cVqZ9/Ffo8lM+F5mns9Tr
        Nsko1rhzoNy7Diht3ae+robllRn4bQmClBA0Tg0cN6x6oOU+CYEZG1kpyA/Dv4znvj2BMi
        EBzaLtJSOUaEiaF1+o8+5H0e5yT2qhTtojFKoCGBBOtIInkjloEN0E8h08cxxVoIGj5WyY
        563lJNFYpIy4RI9nXKiBGECinnFLvS9WwhCM2xSbir/4dCvjkO1AT1VzNp2T4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCuiTwxOEeQPdkNesnDq60kBaeq+ULJll4LvEfr8PA8=;
        b=q4Zw3g0tHuz7+S47ZqMb0wCgJBf37Xt1wyqm3HxkbK3LjewQDxDuIECK4mJpYif8+iSyZt
        rt13S+CsphLeGQAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Sanitize __wait_for_cpus()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.204251527@linutronix.de>
References: <20231002115903.204251527@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780187089.3135.7641533277446562008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     7f21c0ed2cfefcbc6e2b383a6001c0c48a135ffe
Gitweb:        https://git.kernel.org/tip/7f21c0ed2cfefcbc6e2b383a6001c0c48a135ffe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:59 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 15:56:17 +02:00

x86/microcode: Sanitize __wait_for_cpus()

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115903.204251527@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 39 +++++++++++----------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 63c4e12..9fd5a96 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -252,31 +252,26 @@ static struct platform_device	*microcode_pdev;
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
+	unsigned int timeout;
 
-	atomic_inc(t);
+	WARN_ON_ONCE(atomic_dec_return(cnt) < 0);
 
-	while (atomic_read(t) < all_cpus) {
-		if (timeout < SPINUNIT) {
-			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
-				all_cpus - atomic_read(t));
-			return 1;
-		}
+	for (timeout = 0; timeout < USEC_PER_SEC; timeout++) {
+		if (!atomic_read(cnt))
+			return true;
 
-		ndelay(SPINUNIT);
-		timeout -= SPINUNIT;
+		udelay(1);
 
-		touch_nmi_watchdog();
+		if (!(timeout % USEC_PER_MSEC))
+			touch_nmi_watchdog();
 	}
-	return 0;
+	/* Prevent the late comers from making progress and let them time out */
+	atomic_inc(cnt);
+	return false;
 }
 
 /*
@@ -294,7 +289,7 @@ static int __reload_late(void *info)
 	 * Wait for all CPUs to arrive. A load will not be attempted unless all
 	 * CPUs show up.
 	 * */
-	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
+	if (!wait_for_cpus(&late_cpus_in))
 		return -1;
 
 	/*
@@ -317,7 +312,7 @@ static int __reload_late(void *info)
 	}
 
 wait_for_siblings:
-	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC))
+	if (!wait_for_cpus(&late_cpus_out))
 		panic("Timeout during microcode update!\n");
 
 	/*
@@ -344,8 +339,8 @@ static int microcode_reload_late(void)
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 	pr_err("You should switch to early loading, if possible.\n");
 
-	atomic_set(&late_cpus_in,  0);
-	atomic_set(&late_cpus_out, 0);
+	atomic_set(&late_cpus_in, num_online_cpus());
+	atomic_set(&late_cpus_out, num_online_cpus());
 
 	/*
 	 * Take a snapshot before the microcode update in order to compare and
