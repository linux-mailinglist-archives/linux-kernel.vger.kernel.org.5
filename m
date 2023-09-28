Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9707B1672
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjI1Iwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjI1Iwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:52:35 -0400
Received: from out-209.mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC64C0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:52:33 -0700 (PDT)
Message-ID: <e60c7715-f3a9-8e09-2eb1-43654061adad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695891151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6YvlznqxvWuAukC+g68ihPuz53Yf7CKktPIwkut/8k=;
        b=eiFvDFfA5JNFYrfLCWGCoZ121EI+Wri1IWuiRsB9y4jyqQJuILccd8PYLglspXWY09GoQD
        Ne1gBqgFJGFkmcAk1Qw1RHq/2J1njJVpZuHaWcA2j667rvnKKHDjioDvfhpvT96E+73CgD
        Qbo9CffmU1FDI5V2P1zNEklI3++D9e0=
Date:   Thu, 28 Sep 2023 16:52:22 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2] sched/rt: move back to RT_GROUP_SCHED and rename it
 child
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20230920140127.1671945-1-yajun.deng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <20230920140127.1671945-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Steve,

Kindly ping...

Thank.

On 2023/9/20 22:01, Yajun Deng wrote:
> The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
> it should not place out of RT_GROUP_SCHED, move back to RT_GROUP_SCHED
> and rename it child. This would save a few bytes.
>
> Init child when parent isn't NULL in init_tg_rt_entry() and introduce
> for_each_sched_rt_entity_reverse() to iterate rt_se from top to down.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
> v2: fix the "uninitialized symbol 'root'" warning
> v1: https://lore.kernel.org/all/20230919035114.2364567-1-yajun.deng@linux.dev/
> ---
>   include/linux/sched.h |  2 +-
>   kernel/sched/rt.c     | 25 ++++++++++++++++---------
>   2 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 7fcf1b82cfa6..cd05f4bb6a26 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -594,8 +594,8 @@ struct sched_rt_entity {
>   	unsigned short			on_rq;
>   	unsigned short			on_list;
>   
> -	struct sched_rt_entity		*back;
>   #ifdef CONFIG_RT_GROUP_SCHED
> +	struct sched_rt_entity		*child;
>   	struct sched_rt_entity		*parent;
>   	/* rq on which this entity is (to be) queued: */
>   	struct rt_rq			*rt_rq;
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 0597ba0f85ff..473a21b76c62 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -230,8 +230,10 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
>   
>   	if (!parent)
>   		rt_se->rt_rq = &rq->rt;
> -	else
> +	else {
>   		rt_se->rt_rq = parent->my_q;
> +		parent->child = rt_se;
> +	}
>   
>   	rt_se->my_q = rt_rq;
>   	rt_se->parent = parent;
> @@ -564,6 +566,9 @@ static inline struct task_group *next_task_group(struct task_group *tg)
>   #define for_each_sched_rt_entity(rt_se) \
>   	for (; rt_se; rt_se = rt_se->parent)
>   
> +#define for_each_sched_rt_entity_reverse(rt_se) \
> +	for (; rt_se; rt_se = rt_se->child)
> +
>   static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
>   {
>   	return rt_se->my_q;
> @@ -669,6 +674,9 @@ typedef struct rt_rq *rt_rq_iter_t;
>   #define for_each_sched_rt_entity(rt_se) \
>   	for (; rt_se; rt_se = NULL)
>   
> +#define for_each_sched_rt_entity_reverse(rt_se) \
> +	for_each_sched_rt_entity(rt_se)
> +
>   static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
>   {
>   	return NULL;
> @@ -1481,22 +1489,21 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
>    */
>   static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
>   {
> -	struct sched_rt_entity *back = NULL;
> +	struct sched_rt_entity *root = NULL;
>   	unsigned int rt_nr_running;
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
>   		if (on_rt_rq(rt_se))
>   			__dequeue_rt_entity(rt_se, flags);
>   	}
>   
> -	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
> +	dequeue_top_rt_rq(rt_rq_of_se(root), rt_nr_running);
>   }
>   
>   static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
