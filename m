Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90567D5195
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbjJXNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjJXNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:21:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AE210F2;
        Tue, 24 Oct 2023 06:20:58 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:20:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nqIL7Iij6I91YwjLhm5Atb9zwAdORcuJ6MTRIlljPo=;
        b=JiLr3irN9KQhUedxbCVsmgxMVQI+2vR1Qa32ZDyGv9O7oRGQ25amTqDVw/8FbGDdVTdzfz
        I1VgheOnM6pU5vh/uXI5/Fbia1jd2PqR+QeolxEt1lJJIaZuhf4AfgL03uxFT9hykEs8Ed
        yQ49NLZQujfyhgOm6DiJG+eAocR//yU4Zhe0svtcKHw4SbSqURDBORCLK6NJvNPHggAgQ2
        vMVfBMNwIgIPXr82p9EAY0bwuJ79UuPsIpcqTZJ9RbyGghxM0FpxCO64qf2rk9mjWioxKH
        0uon1YhvV6ngAG6P49/KIvu8ouHgNNxJ1uzDqGJSDXwP0G6HMcKINsrcvjewyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nqIL7Iij6I91YwjLhm5Atb9zwAdORcuJ6MTRIlljPo=;
        b=qgllPvVzNuIuWXlUXhFzweYxTa2RboVnHyq1ftCvxFtpzmalPKUimqXNMHAKpkVZtUVYyJ
        EZb4UZwVIHvY/iBA==
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
Message-ID: <169815365590.3135.705159316165017003.tip-bot2@tip-bot2>
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

Commit-ID:     0772b9aa1a8f7322dce8588c231cff8b57298a53
Gitweb:        https://git.kernel.org/tip/0772b9aa1a8f7322dce8588c231cff8b57298a53
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:59 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:05:54 +02:00

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
