Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EACD78E05B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbjH3TJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243247AbjH3KaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:30:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563C0C0;
        Wed, 30 Aug 2023 03:30:06 -0700 (PDT)
Date:   Wed, 30 Aug 2023 10:30:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693391405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FfXPoY2Jgiw11kfJNWJwljQPcGeP9oorxEVHW8vr9Y=;
        b=nEgEkbIQjrpr6sd+xQT6QWAe39ojUMUk8ir8+nHj5NMIk18eGLIfrn+yCYtXMqznijvrKw
        D5KQh2hk3EAwLEhtb+WkdTOAIVb/vW+YNIRo6MDh7ilgXMx1bpQ1Z0OSpOQqFHLP/LZwid
        0kF0MMHdut8vuTcmxodMKYyf3QTGDh3o4jIxpqAcEMz3DiJhIiX96zBhl3dXa2qDt7z855
        Ca0m58i2UkyBkxB9TSc2lmTur2DtyzXcbWUe7qh8AGN+M8LQn8WXE9gJ7NFN5WLkWRRAqD
        mE7Vz8TXu29yzZ+uPukM2XpnAQqGYKFzEl9rcZJEFyi+i738+UrOen1gcQrmog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693391405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8FfXPoY2Jgiw11kfJNWJwljQPcGeP9oorxEVHW8vr9Y=;
        b=COB7gHE3yp7oU8oOOIXb9ak18SqRO8YX4mrEUMl+XMBPXGNnTBCrzitPmDYYMPcvWRbGKm
        LElA97UxwBmFHuDA==
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/rcu: Fix false positive "softirq work is
 pending" messages
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Wen Yang <wenyang.linux@foxmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230818200757.1808398-1-paul.gortmaker@windriver.com>
References: <20230818200757.1808398-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Message-ID: <169339140347.27769.9753097427140824629.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     96c1fa04f089a7e977a44e4e8fdc92e81be20bef
Gitweb:        https://git.kernel.org/tip/96c1fa04f089a7e977a44e4e8fdc92e81be20bef
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Fri, 18 Aug 2023 16:07:57 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Aug 2023 12:20:28 +02:00

tick/rcu: Fix false positive "softirq work is pending" messages

In commit 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle") the
new function report_idle_softirq() was created by breaking code out of the
existing can_stop_idle_tick() for kernels v5.18 and newer.

In doing so, the code essentially went from a one conditional:

	if (a && b && c)
		warn();

to a three conditional:

	if (!a)
		return;
	if (!b)
		return;
	if (!c)
		return;
	warn();

But that conversion got the condition for the RT specific
local_bh_blocked() wrong. The original condition was:

   	!local_bh_blocked()

but the conversion failed to negate it so it ended up as:

        if (!local_bh_blocked())
		return false;

This issue lay dormant until another fixup for the same commit was added
in commit a7e282c77785 ("tick/rcu: Fix bogus ratelimit condition").
This commit realized the ratelimit was essentially set to zero instead
of ten, and hence *no* softirq pending messages would ever be issued.

Once this commit was backported via linux-stable, both the v6.1 and v6.4
preempt-rt kernels started printing out 10 instances of this at boot:

  NOHZ tick-stop error: local softirq work is pending, handler #80!!!

Remove the negation and return when local_bh_blocked() evaluates to true to
bring the correct behaviour back.

Fixes: 0345691b24c0 ("tick/rcu: Stop allowing RCU_SOFTIRQ in idle")
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Wen Yang <wenyang.linux@foxmail.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230818200757.1808398-1-paul.gortmaker@windriver.com


---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4df14db..87015e9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1045,7 +1045,7 @@ static bool report_idle_softirq(void)
 		return false;
 
 	/* On RT, softirqs handling may be waiting on some lock */
-	if (!local_bh_blocked())
+	if (local_bh_blocked())
 		return false;
 
 	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x!!!\n",
