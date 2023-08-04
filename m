Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A14576FF7E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjHDLaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHDLau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:30:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB4B11B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:30:48 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691148646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JQwdy939tDLgVEjU3blR0W4WS7PLhzs+UNZZN7ZNvYc=;
        b=u7DpROMPSeu4vLTyIm1eQKV6AbU1077urtQngtOmaPkRgbmRLfpFktW96jij24kXRifHaQ
        25ZddmiOukvhvRuadw1bg+HjorgrZCwomriEoOycWP9tfcEW4X6Us0GZWGxp6nYEmH/Q2M
        MWESta7ZCQi0Dtq7Yg9IB8SjrHNQ0MZc3AC6N9Bv4C6r3NfD1ohydrd0e6StqG5Yd2JNqc
        ZmfNdOvq4ktq9WetLKye7PXN3NVm7Ud30lETVgpyONS9bBq2zS2Y1rLXQN2+g/523vG7B5
        QOVbCrh/2OpdyHAtZmrGnUQqIOG6JjrzAK5Wr9Pg68AivHCgTh8gaEla3Xy9tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691148646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JQwdy939tDLgVEjU3blR0W4WS7PLhzs+UNZZN7ZNvYc=;
        b=j73gmz9aXFfEpLj5gg5Z7vx/JyB15i+p+/gjPMtAXG7FtP7cj+VQSTQ33k1SvFynyH2MtV
        R7vygNyOfBNVCvCw==
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
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC PATCH 0/3] Allow to preempt a timer softirq on PREEMPT_RT.
Date:   Fri,  4 Aug 2023 13:30:36 +0200
Message-Id: <20230804113039.419794-1-bigeasy@linutronix.de>
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

Hi,

while the softirqs are served, bottom halves are disabled. By disabling
bottom halves (as per local_bh_disable()) PREEMPT_RT acquires a
local_lock_t. This lock ensures that the softirq is synchronized against
other softirq user on that CPU while keeping the context preemptible.

This leads to a scenario where context itself is preemptible but needs
to "complete" before the system can make progress. For instance, the
timer callback (in TIMER_SOFTIRQ) gets preempted because a
force-threaded interrupt thread, with higher priority, gets woken up.
Before the handler of the forced-threaded interrupt can be invoked,
bottom halves get disabled and this blocks on the same per-CPU lock.
This in turn leads to a PI-boost and the preempted timer softirq is back
on the CPU with higher priority completing its job (not just the timer,
all pending softirqs).

In the end the force threaded interrupt is blocked until all pending
softirqs have been served.

The PI-boost is usually intended to allow the thread with lower priority
to "quickly" finish what it was doing and leave the critical section
ASAP. This is not the case with softirqs and how this is handled by the
individual callbacks. Additionally the need_resched() check in
__do_softirq() is never true due to the boost. This means in worst case
this can run for MAX_SOFTIRQ_TIME or MAX_SOFTIRQ_RESTART.

One way of out would be to add preemption within the softirq handling at
which point the softirq-BKL can be dropped. This can be after all
softirqs have been served (__do_softirq() where the need_resched() check
is located), after each softirq handler or within the softirq handler
where it is considered safe to do so.

This series adds as an example such a preemption point to the timer
softirq handler. Should this fly then it would be needed the remaining
handlers as well.

Sebastian


