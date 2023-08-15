Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202F477CB90
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbjHOLRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbjHOLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:17:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5366BFE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ssLCWBNexAqMxY5nOdoi4YvdUan+K2TVkqWurGQmVsY=; b=SCghBTSMIDiXa6bUQDGItYDvRw
        JqGwh1wVkztWJlrJBQjauI1dp23GAw2jlm55xTX4QDuJgJCmpvwnEsjsPOCELnUPWr0xOIX98jdYo
        xXkNN+TeYmR0u2Ak2ozOuB3xfhH0olRQ6PciFZsBXc6fTtu4fFtI85Ik+GHEZYFKjmIxeXFfb/dGL
        BMc5EOdbFkAh6VDXsNJ6PrrrhQrxBSqMnoRM0jtoIp2zKOET/b8jauOMeUmQnXqfvzy+YP6A304Nw
        vKetUeq4AwL7QQd3MqEawc41qgjGLnhQZb9as9+xU7Rffo5AmuCC4o5vW4bCR19V01YeRhwHptRuE
        UkFIjs2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qVs2c-007rqQ-9G; Tue, 15 Aug 2023 11:16:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 143483004AF;
        Tue, 15 Aug 2023 13:16:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EBFEF2074B3DA; Tue, 15 Aug 2023 13:16:48 +0200 (CEST)
Message-ID: <20230815111430.154558666@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Aug 2023 13:01:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bigeasy@linutronix.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        bsegall@google.com, boqun.feng@gmail.com, swood@redhat.com,
        bristot@redhat.com, dietmar.eggemann@arm.com, mingo@redhat.com,
        jstultz@google.com, juri.lelli@redhat.com, mgorman@suse.de,
        rostedt@goodmis.org, vschneid@redhat.com,
        vincent.guittot@linaro.org, longman@redhat.com, will@kernel.org
Subject: [PATCH 1/6] sched: Constrain locks in sched_submit_work()
References: <20230815110121.117752409@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though sched_submit_work() is ran from preemptible context,
it is discouraged to have it use blocking locks due to the recursion
potential.

Enforce this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6737,11 +6737,18 @@ void __noreturn do_task_dead(void)
 
 static inline void sched_submit_work(struct task_struct *tsk)
 {
+	static DEFINE_WAIT_OVERRIDE_MAP(sched_map, LD_WAIT_CONFIG);
 	unsigned int task_flags;
 
 	if (task_is_running(tsk))
 		return;
 
+	/*
+	 * Establish LD_WAIT_CONFIG context to ensure none of the code called
+	 * will use a blocking primitive -- which would lead to recursion.
+	 */
+	lock_map_acquire_try(&sched_map);
+
 	task_flags = tsk->flags;
 	/*
 	 * If a worker goes to sleep, notify and ask workqueue whether it
@@ -6766,6 +6773,8 @@ static inline void sched_submit_work(str
 	 * make sure to submit it to avoid deadlocks.
 	 */
 	blk_flush_plug(tsk->plug, true);
+
+	lock_map_release(&sched_map);
 }
 
 static void sched_update_worker(struct task_struct *tsk)


