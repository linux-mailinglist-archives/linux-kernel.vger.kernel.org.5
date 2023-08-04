Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106876FF80
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjHDLa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHDLau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:30:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D321122
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:30:48 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691148647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9DRriWNDJonfqILcAsrrLxxJbWS0AzfymHX8jUCjo8=;
        b=fk745ondrh8eLE4m+TZCnu5htor3AbCLsT4+gFHOWDRVKIbdOc2TCz6/3Rf3T9RhXPsMNG
        +IqdHUMAIID8mVdpg3Y9QmcRvEf4at/XN1X9ZCQYAXrVspw6fUL+TdrTIWzjagne9uHgoL
        R2VhE9VJuQ9xSOqdTCNZYoZ7klEeTxH5DglueMXM8samBWOEi3VcICroY+KLuV0OA/05pJ
        O+WNMMcWkJHgRfxm2gL3I2O2seurRBpcZSLFdzWrMnWTUAg8jiGVT98xViKDo20s4XLuRw
        /XTSpZVmctAOtP2fIA5N36/N3omJ/I/ZBa871vz5UAqUaMpfpvZKPcOZTvy+SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691148647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9DRriWNDJonfqILcAsrrLxxJbWS0AzfymHX8jUCjo8=;
        b=GmBffpV5Rx7yoUp7D7U90VSB2AeDuKYy9aGkOaDP6w1kbSCJCZkUAhLR0rDVNZamigz879
        akaXrATbou6VVCBg==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 3/3] time: Allow to preempt after a callback.
Date:   Fri,  4 Aug 2023 13:30:39 +0200
Message-Id: <20230804113039.419794-4-bigeasy@linutronix.de>
In-Reply-To: <20230804113039.419794-1-bigeasy@linutronix.de>
References: <20230804113039.419794-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIMER_SOFTIRQ handler invokes timer callbacks of the expired timers.
Before each invocation the timer_base::lock is dropped. The only lock
that is still held is the timer_base::expiry_lock and the per-CPU
bh-lock as part of local_bh_disable(). The former is released as part
of lock up prevention if the timer is preempted by the caller which is
waiting for its completion.

Both locks are already released as part of timer_sync_wait_running().
This can be extended by also releasing in bh-lock. The timer core does
not rely on any state that is serialized by the bh-lock. The timer
callback expects the bh-state to be serialized by the lock but there is
no need to keep state synchronized while invoking multiple callbacks.

Preempt handling softirqs and release all locks after a timer invocation
if the current has inherited priority.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd4..b76856bc2edd2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1470,9 +1470,16 @@ static inline void timer_base_unlock_expiry(struct t=
imer_base *base)
  */
 static void timer_sync_wait_running(struct timer_base *base)
 {
-	if (atomic_read(&base->timer_waiters)) {
+	bool need_preempt;
+
+	need_preempt =3D task_is_pi_boosted(current);
+	if (need_preempt || atomic_read(&base->timer_waiters)) {
 		raw_spin_unlock_irq(&base->lock);
 		spin_unlock(&base->expiry_lock);
+
+		if (need_preempt)
+			softirq_preempt();
+
 		spin_lock(&base->expiry_lock);
 		raw_spin_lock_irq(&base->lock);
 	}
--=20
2.40.1

