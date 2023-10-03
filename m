Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B0F7B668B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjJCKhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjJCKhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:37:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3CAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sYFV784QNfVsvR6OfaRbdZY0R9+sNWsxSwOAX+vHka8=; b=Lzyv0kqTljtDaZ9pNT6SbEsAdc
        Pu0My9FYykJIiQ0T4evWjXkmtINCQEWTnRLZ4g3zJtcQUkuN1RSht1vJhTs4wWKqq/uIn1m4lDdQ6
        KfNOLcCGWVq944pMfLucy8bauWFXszNB/pIXN8hrDuNJpGH/n3OegC1oYsNks83392gSfcc7g3Ef1
        fXwfe4dG8vFlokRkqQtx0ZwX+n8T+VcFH6a4kQrzmBlDgOwtPyFYnGDMMm99oViMcZllh0TJVgHQ0
        oIABSlqqyGzgZmYOB02cnI2oGKv3gBHOuLWBOxKxH1OnhyGSt7Z/+YHRvTAy27kqBt27K7/OExLbC
        Kz5pi/DA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qnclb-00EWuG-Te; Tue, 03 Oct 2023 10:36:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 630AE300348; Tue,  3 Oct 2023 12:36:39 +0200 (CEST)
Date:   Tue, 3 Oct 2023 12:36:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v4] sched/rt: move back to RT_GROUP_SCHED and rename it
 child
Message-ID: <20231003103639.GD1539@noisy.programming.kicks-ass.net>
References: <20230803050317.2240948-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803050317.2240948-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 01:03:17PM +0800, Yajun Deng wrote:

> @@ -564,6 +566,9 @@ static inline struct task_group *next_task_group(struct task_group *tg)
>  #define for_each_sched_rt_entity(rt_se) \
>  	for (; rt_se; rt_se = rt_se->parent)
>  
> +#define for_each_sched_rt_entity_reverse(rt_se) \
> +	for (; rt_se; rt_se = rt_se->child)
> +
>  static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
>  {
>  	return rt_se->my_q;
> @@ -669,6 +674,9 @@ typedef struct rt_rq *rt_rq_iter_t;
>  #define for_each_sched_rt_entity(rt_se) \
>  	for (; rt_se; rt_se = NULL)
>  
> +#define for_each_sched_rt_entity_reverse(rt_se) \
> +	for_each_sched_rt_entity(rt_se)
> +
>  static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
>  {
>  	return NULL;
> @@ -1481,22 +1489,21 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
>   */
>  static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
>  {
> -	struct sched_rt_entity *back = NULL;
> +	struct sched_rt_entity *root;
>  	unsigned int rt_nr_running;
>  
> -	for_each_sched_rt_entity(rt_se) {
> -		rt_se->back = back;
> -		back = rt_se;
> -	}
> +	for_each_sched_rt_entity(rt_se)
> +		root = rt_se;
>  
> -	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
> +	rt_nr_running = rt_rq_of_se(root)->rt_nr_running;
>  
> -	for (rt_se = back; rt_se; rt_se = rt_se->back) {
> +	rt_se = root;
> +	for_each_sched_rt_entity_reverse(rt_se) {
>  		if (on_rt_rq(rt_se))
>  			__dequeue_rt_entity(rt_se, flags);
>  	}
>  
> -	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
> +	dequeue_top_rt_rq(rt_rq_of_se(root), rt_nr_running);
>  }

Urgh, please don't do this. The whole thing is super fragile. Creating
these abstractions makes it appear like
for_each_sched_rt_entity_reverse() is somehow a sane thing to do. Aside
from the name being insanely long, the whole thing makes no sense
what-so-ever unless you first went and did the normal iteration and set
the back pointers.

It's called back for a reason, it walks back the path it first walked.
Normals and unambiguous iteration is up the tree, towards the root,
walking back down is not.
