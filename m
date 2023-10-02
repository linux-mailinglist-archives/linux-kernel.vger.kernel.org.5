Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566257B5923
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbjJBRjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbjJBRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:39:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCB6BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2uF5B4jlJDMw2wEtd51kntvtEJhbdl5wGQqW1fZr3ik=; b=QL+uQIhlTp2Y9i4CnmEROK5BKw
        ChdMIvA1Tc0A4/e5l0sHozPpe5Edna8JxG8UuZckmaIoZLGz3jT0EdE5ITgtNpA00BSlDCgDG8S4L
        xbDc5Z/CDunt+T6pCn657W2/rUutTm6cnKlWtgOz0N82e3vtIhN0kWqhpDBphdZhmsz0rpRtr2kV4
        Oj6xvPmJn2lhP4s7VN+IKb0vxiCbVRwH3c2gjiZg5acXoxm7udrRBjUHanMxCEwPRTEbR/+U/V/2K
        bZMRPPPi1IrC+tio0FpRnLHvgFzbGzygIVCuEZpfshTKcQ2XVQoVazUeFCFwYl9/XJ+3OJzQZRUnR
        lEFH/dfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qnMss-00AJEh-1A; Mon, 02 Oct 2023 17:39:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94730300454; Mon,  2 Oct 2023 19:39:04 +0200 (CEST)
Date:   Mon, 2 Oct 2023 19:39:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Segall <bsegall@google.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [PATCH 05/15] sched/fair: Implement an EEVDF like policy
Message-ID: <20231002173904.GA27267@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.931005524@infradead.org>
 <xm265y3sodyo.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm265y3sodyo.fsf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 02:40:31PM -0700, Benjamin Segall wrote:

> > +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> > +{
> > +	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
> > +	struct sched_entity *curr = cfs_rq->curr;
> > +	struct sched_entity *best = NULL;
> > +
> > +	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> > +		curr = NULL;
> > +
> > +	while (node) {
> > +		struct sched_entity *se = __node_2_se(node);
> > +
> > +		/*
> > +		 * If this entity is not eligible, try the left subtree.
> > +		 */
> > +		if (!entity_eligible(cfs_rq, se)) {
> > +			node = node->rb_left;
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * If this entity has an earlier deadline than the previous
> > +		 * best, take this one. If it also has the earliest deadline
> > +		 * of its subtree, we're done.
> > +		 */
> > +		if (!best || deadline_gt(deadline, best, se)) {
> > +			best = se;
> > +			if (best->deadline == best->min_deadline)
> > +				break;
> > +		}
> > +
> > +		/*
> > +		 * If the earlest deadline in this subtree is in the fully
> > +		 * eligible left half of our space, go there.
> > +		 */
> > +		if (node->rb_left &&
> > +		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
> > +			node = node->rb_left;
> > +			continue;
> > +		}
> > +
> > +		node = node->rb_right;
> > +	}
> 
> I believe that this can fail to actually find the earliest eligible
> deadline, because the earliest deadline (min_deadline) can be in the
> right branch, but that se isn't eligible, and the actual target se is in
> the left branch. A trivial 3-se example with the nodes represented by
> (vruntime, deadline, min_deadline):
> 
>    (5,9,7)
>  /        \
> (4,8,8)  (6,7,7)
> 
> AIUI, here the EEVDF pick should be (4,8,8), but pick_eevdf() will
> instead pick (5,9,7), because it goes into the right branch and then
> fails eligibility.
> 
> I'm not sure how much of a problem this is in practice, either in
> frequency or severity, but it probably should be mentioned if it's
> an intentional tradeoff.

Well, that is embarrassing :-(

You're quite right -- and I *SHOULD* have double checked my decade old
patches, but alas.

Re-reading the paper, your proposal is fairly close to what they have.
Let me go stare at your patch in more detail.


