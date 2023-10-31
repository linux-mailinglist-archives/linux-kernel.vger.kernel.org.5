Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4957DD0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbjJaPwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjJaPw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:52:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8D48DF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:52:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02DA42F;
        Tue, 31 Oct 2023 08:53:08 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F3073F67D;
        Tue, 31 Oct 2023 08:52:24 -0700 (PDT)
Message-ID: <d1b613d5-2207-45dd-8aa2-a276502ccaa1@arm.com>
Date:   Tue, 31 Oct 2023 16:52:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] sched/uclamp: Track uclamped util_avg in
 sched_avg
Content-Language: en-US
To:     Hongyan Xia <Hongyan.Xia2@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Loehle <christian.loehle@arm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1696345700.git.Hongyan.Xia2@arm.com>
 <5564fc23d5e6425d069c36b4cef48edbe77fe64d.1696345700.git.Hongyan.Xia2@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <5564fc23d5e6425d069c36b4cef48edbe77fe64d.1696345700.git.Hongyan.Xia2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 11:04, Hongyan Xia wrote:
> From: Hongyan Xia <hongyan.xia2@arm.com>

[...]

> @@ -6445,6 +6450,21 @@ static int sched_idle_cpu(int cpu)
>  }
>  #endif
>  
> +void ___update_util_avg_uclamp(struct sched_avg *avg, struct sched_entity *se);

IMHO, `struct sched_avg *avg` can only be the one of a cfs_rq. So
passing a cfs_rq would eliminate the question whether this can be from
another se.

> +static void update_se_chain(struct task_struct *p)
> +{
> +#ifdef CONFIG_UCLAMP_TASK
> +	struct sched_entity *se = &p->se;
> +	struct rq *rq = task_rq(p);
> +
> +	for_each_sched_entity(se) {
> +		struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +		___update_util_avg_uclamp(&cfs_rq->avg, se);
> +	}
> +#endif
> +}
>  /*
>   * The enqueue_task method is called before nr_running is
>   * increased. Here we update the fair scheduling stats and
> @@ -6511,6 +6531,16 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  			goto enqueue_throttle;
>  	}
>  
> +	/*
> +	 * Re-evaluate the se hierarchy now that on_rq is true. This is
> +	 * important to enforce uclamp the moment a task with uclamp is
> +	 * enqueued, rather than waiting a timer tick for uclamp to kick in.
> +	 *
> +	 * XXX: This duplicates some of the work already done in the above for
> +	 * loops.
> +	 */
> +	update_se_chain(p);

I try to figure out why this is necessary here:

enqueue_task_fair()
  for_each_sched_entity()
    enqueue_entity()
      update_load_avg()
        __update_load_avg_se()
          ___update_util_avg_uclamp()        <-- if se->on_rq,
                                                 update p (se) if we
                                                 cross PELT period (1)
                                                 boundaries
          ___decay_util_avg_uclamp_towards() <-- decay p (se)      (2)

      enqueue_util_avg_uclamp()          <-- enqueue p into cfs_rq (3)

      se->on_rq = 1                          <-- set p (se) on_rq  (4)

  for_each_sched_entity()
    update_load_avg()                        <-- update all on_rq se's
                                                 in the hierarchy  (5)

  update_se_chain()                          <-- update p (se) and its
                                                 se hierarchy      (6)

(1) Skip p since it is !se->on_rq.

(2) Decay p->se->avg.util_avg_uclamp to 0 since it was sleeping.

(3) Attach p to its cfs_rq

...

(6) Update all all se's and cfs_rq's involved in p's task_group
    hierarchy (including propagation from se (level=x+1) to cfs_rq
    (level=x))

Question for me is why can't you integrate the util_avg_uclamp signals
for se's and cfs_rq's/rq's much closer into existing PELT functions?

[...]
