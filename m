Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF7A7C55EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjJKNw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjJKNwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:52:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840089E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tU3Q4smiecfzaPbU8gayq4O/BF4mTANtwE+FQfuAtLQ=; b=HjJqesWETz8i/NpERymjrNpncs
        veO+JGueoQeQDpgny8C7lX8kIqFOG/YTYOTqBUtKzonRUxk7Bf2izubyqGtDHg4KkpdzIiJrlWF4H
        hG7BGjL6qsjbJ30rhonJn6Hib9HA/hOA5ggkkrMjhBn6LTwjfIpkoCag4JMfy1nDjxKyhxlK+JS/K
        IwSN4Vz8XWP8VKO5iMrLhtc2AzseR7l2Txz0W88exrobEbbl7foxse0GvX//E6+QEPV+uLUVbg+nV
        HP3Es9pPdr9Q6rW9Ie+dEdc0LqR3pHQf5sGkbShW5Rb95Q0rEIyT0lFtBQ6mv7e5vLBvapybSRBw/
        Ipg0sMWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqZde-00B7Aa-W1; Wed, 11 Oct 2023 13:52:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F10430036C; Wed, 11 Oct 2023 15:52:38 +0200 (CEST)
Date:   Wed, 11 Oct 2023 15:52:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankit Jain <ankitja@vmware.com>
Cc:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, qyousef@layalina.io, pjt@google.com,
        joshdon@google.com, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, namit@vmware.com,
        amakhalov@vmware.com, srinidhir@vmware.com, vsirnapalli@vmware.com,
        vbrahmajosyula@vmware.com, akaher@vmware.com,
        srivatsa@csail.mit.edu
Subject: Re: [PATCH RFC] cpumask: Randomly distribute the tasks within
 affinity mask
Message-ID: <20231011135238.GG6337@noisy.programming.kicks-ass.net>
References: <20231011071925.761590-1-ankitja@vmware.com>
 <20231011105329.GA17066@noisy.programming.kicks-ass.net>
 <20231011114642.GA36521@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011114642.GA36521@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 01:46:42PM +0200, Peter Zijlstra wrote:

> Now, looking at the code, I don't think the current code actually
> behaves correct in this case :-(, somewhere along the line we should
> truncate cpu_valid_mask to a single bit. Let me see where the sane place
> is to do that.

Something like so I suppose, that limits newmask to the first
root_domain, which should be a superset of the cpuset if there is such a
thing.


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 23f638d431d6..334c5bc59160 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3081,6 +3081,29 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	return 0;
 }
 
+static struct cpumask *root_domain_allowed(struct cpumask *newmask,
+					   struct cpumask *scratch,
+					   struct cpumask *valid)
+{
+	struct root_domain *rd;
+	struct cpumask *mask;
+	struct rq *rq;
+
+	int first = cpumask_first_and(newmask, valid);
+	if (first >= nr_cpu_ids)
+		return NULL;
+
+	mask = cpumask_of(first);
+	rd = cpu_rq(first)->rd;
+	if (rd)
+		mask = rd->span;
+
+	if (!cpumask_and(scratch, newmask, mask))
+		return NULL;
+
+	return scratch;
+}
+
 /*
  * Called with both p->pi_lock and rq->lock held; drops both before returning.
  */
@@ -3113,6 +3136,13 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
 		cpu_valid_mask = cpu_online_mask;
 	}
 
+	ctx->new_mask = root_domain_allowed(ctx->new_mask,
+					    rq->scratch_mask, cpu_valid_mask);
+	if (!ctx->new_mask) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!kthread && !cpumask_subset(ctx->new_mask, cpu_allowed_mask)) {
 		ret = -EINVAL;
 		goto out;
