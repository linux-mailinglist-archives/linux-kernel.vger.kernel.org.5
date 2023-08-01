Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3376BF43
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjHAVZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjHAVY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:24:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C77F2707
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4+/Q1nIn7pjeaoOkqiN8ZoN9dOzRXj0Qx8pmucBG9KU=; b=J8IHK9UeVvDpDEqjIjdyb+ueyD
        MZu72D5VRlzK2tgFk6E2Q19XNTvN6w4R97+txCz5/kQUErEhc2yg8x/4L9rokdCMEfx4NHRRpIjhh
        BmupbnZfuzBBcOzvXYkmurDDQkqYJVR+7bqQqWfeszzL94RmSahcvlCY0sz71Hu3ShBcJmRn4HVIW
        oGqKaY55edDIPUaXUF0TKedyjgYdxXvApczceNkZD6d2Nlc7uS47doikWbWyqjHJnIhPCUlIvhs5b
        JHQUnCDYksFwdhUdRC8afFXVARdY0EHUsRoFgfPKWRw6tgUQMNnYUYoByV+O2zkAEZavOIg2Ys3Xh
        FHwmGJMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQwqn-00EvTt-1a;
        Tue, 01 Aug 2023 21:24:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEDEB302781;
        Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5713220286FBA; Tue,  1 Aug 2023 23:24:15 +0200 (CEST)
Message-ID: <20230801211812.304154828@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Aug 2023 22:41:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] sched: Simplify try_steal_cookie()
References: <20230801204121.929256934@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use guards to reduce gotos and simplify control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6229,19 +6229,19 @@ static bool try_steal_cookie(int this, i
 	unsigned long cookie;
 	bool success = false;
 
-	local_irq_disable();
-	double_rq_lock(dst, src);
+	guard(irq)();
+	guard(double_rq_lock)(dst, src);
 
 	cookie = dst->core->core_cookie;
 	if (!cookie)
-		goto unlock;
+		return false;
 
 	if (dst->curr != dst->idle)
-		goto unlock;
+		return false;
 
 	p = sched_core_find(src, cookie);
 	if (!p)
-		goto unlock;
+		return false;
 
 	do {
 		if (p == src->core_pick || p == src->curr)
@@ -6253,9 +6253,10 @@ static bool try_steal_cookie(int this, i
 		if (p->core_occupation > dst->idle->core_occupation)
 			goto next;
 		/*
-		 * sched_core_find() and sched_core_next() will ensure that task @p
-		 * is not throttled now, we also need to check whether the runqueue
-		 * of the destination CPU is being throttled.
+		 * sched_core_find() and sched_core_next() will ensure
+		 * that task @p is not throttled now, we also need to
+		 * check whether the runqueue of the destination CPU is
+		 * being throttled.
 		 */
 		if (sched_task_is_throttled(p, this))
 			goto next;
@@ -6273,10 +6274,6 @@ static bool try_steal_cookie(int this, i
 		p = sched_core_next(p, cookie);
 	} while (p);
 
-unlock:
-	double_rq_unlock(dst, src);
-	local_irq_enable();
-
 	return success;
 }
 


