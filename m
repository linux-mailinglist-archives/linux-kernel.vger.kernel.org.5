Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B424278BDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjH2FWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjH2FWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:22:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED68CB3;
        Mon, 28 Aug 2023 22:22:37 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T3pwIx027829;
        Tue, 29 Aug 2023 05:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Q4WFTVRky80PUDedJZef7//Z/PDmwJEAE8dUwDbQ+Nk=;
 b=bUkCKBE3ODcGq9HmEi7MrJiT8fLqXFLQvWUyXYNQtfNUOtJASNGPFFDwGCn3cxlupmt9
 DIzdRG8MGNh/EWZOlwKOZ1XF+ho6qTJm5mtKvYQxq+RU1wdM5KHNh1ct5l02+v2oaxHF
 8O7p/7GflQ9ITVgI5dpRx0o3BMZnUSo7tECYel2ESpYV/JJWlCWA88DpqMgVU6R/THLA
 CB9hDg/sSiHVFfcIZtHvtF7QiswZIGRdYnsCbVLCxCx9HcEoFtwhZbD+4Ecct4eoE+RX
 fhLxC0NGP6uO7d/5VZDAG8k4yjCYLaXah8pkhx+lA/nUS2lPe5RC3bWDTO6XFcx6kejC kA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss4g6gfpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:22:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T5MIYC004802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 05:22:18 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 22:22:12 -0700
Date:   Tue, 29 Aug 2023 10:52:09 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Thomas Gleixner" <tglx@linutronix.de>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Prakash Viswalingam <quic_prakashv@quicinc.com>
Subject: Re: [PATCH] freezer,sched: Use saved_state to reduce some spurious
 wakeups
Message-ID: <f7d23e37-8c09-43ea-83fb-0731a3439c1a@quicinc.com>
References: <20230828-avoid-spurious-freezer-wakeups-v1-1-8be8cf761472@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230828-avoid-spurious-freezer-wakeups-v1-1-8be8cf761472@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kYHXY3WZWMuKW71hIRyzcMk0xW3R9xmU
X-Proofpoint-GUID: kYHXY3WZWMuKW71hIRyzcMk0xW3R9xmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_02,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:33:04AM -0700, Elliot Berman wrote:
> After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
> tasks that are in TASK_FREEZABLE state and end up getting frozen are

TASK_FREEZABLE state and what? Pls check once.

> always woken up. Prior to that commit, tasks could ask freezer to
> consider them "frozen enough" via freezer_do_not_conut(). As described
> in Peter's commit, the reason for this change is to prevent these tasks
> from being woken before SMP is back. The commit introduced a
> TASK_FREEZABLE state which allows freezer to immediately mark the task
> as TASK_FROZEN without waking up the task. On the thaw path, the task is
> woken up even if the task didn't need to wake up and goes back to its
> TASK_(UN)INTERRUPTIBLE state. Although these tasks are capable of
> handling of the wakeup, we can observe a power/perf impact from the
> extra wakeup.
> 
> We observed on Android many tasks wait in the TASK_FREEZABLE state
> (particularly due to many of them being binder clients). We observed
> nearly 4x the number of tasks and a corresponding (almost) linear increase in
> latency and power consumption when thawing the system. The latency
> increased from ~15ms to ~50ms.
> 
> Save the state of TASK_FREEZABLE tasks and restore it after thawing the
> task without waking the task up. If the task received a wake up for the
> saved_state before thawing, then the task is still woken upon thawing.
> 
> Re-use saved_state from RT sleeping spinlocks because freezer doesn't
> consider TASK_RTLOCK_WAIT freezable.
> 
> Reported-by: Prakash Viswalingam <quic_prakashv@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
> For testing purposes, I use these commands can help see how many tasks were
> woken during thawing:
> 
> 1. Setup:
>    mkdir /sys/kernel/tracing/instances/freezer
>    cd /sys/kernel/tracing/instances/freezer 
>    echo 0 > tracing_on ; echo > trace
>    echo power:suspend_resume > set_event
>    echo 'enable_event:sched:sched_wakeup if action == \"thaw_processes\" && start == 1' > events/power/suspend_resume/trigger
>    echo 'traceoff if action == \"thaw_processes\" && start == 0' > events/power/suspend_resume/trigger
>    echo 1 > tracing_on
> 
> 2. Let kernel go to suspend
> 
> 3. After kernel's back up:
>    cat /sys/kernel/tracing/instances/freezer/trace | grep sched_wakeup | grep -o "pid=[0-9]*" | sort -u | wc -l
> ---
>  include/linux/sched.h |  4 ++--
>  kernel/freezer.c      | 15 +++++++++++++--
>  kernel/sched/core.c   | 21 +++++++++++++--------
>  3 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index eed5d65b8d1f..e4ade5a18df2 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -746,8 +746,8 @@ struct task_struct {
>  #endif
>  	unsigned int			__state;
>  
> -#ifdef CONFIG_PREEMPT_RT
> -	/* saved state for "spinlock sleepers" */
> +#if IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_FREEZER)
> +	/* saved state for "spinlock sleepers" and freezer */
>  	unsigned int			saved_state;
>  #endif
>  
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index 4fad0e6fca64..6222cbfd97ab 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -71,7 +71,11 @@ bool __refrigerator(bool check_kthr_stop)
>  	for (;;) {
>  		bool freeze;
>  
> +		raw_spin_lock_irq(&current->pi_lock);
>  		set_current_state(TASK_FROZEN);
> +		/* unstale saved_state so that __thaw_task() will wake us up */
> +		current->saved_state = TASK_RUNNING;
> +		raw_spin_unlock_irq(&current->pi_lock);
>  
>  		spin_lock_irq(&freezer_lock);
>  		freeze = freezing(current) && !(check_kthr_stop && kthread_should_stop());
> @@ -129,6 +133,7 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
>  		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
>  #endif
>  
> +	p->saved_state = p->__state;
>  	WRITE_ONCE(p->__state, TASK_FROZEN);
>  	return TASK_FROZEN;
>  }
> @@ -174,10 +179,16 @@ bool freeze_task(struct task_struct *p)
>   * state in p->jobctl. If either of them got a wakeup that was missed because
>   * TASK_FROZEN, then their canonical state reflects that and the below will
>   * refuse to restore the special state and instead issue the wakeup.
> + *
> + * Otherwise, restore the saved_state before the task entered freezer. For
> + * typical tasks in the __refrigerator(), saved_state == 0 so nothing happens
> + * here. For tasks which were TASK_NORMAL | TASK_FREEZABLE, their initial state
> + * is returned unless they got an expected wakeup. Then they will be woken up as
> + * TASK_FROZEN back in __thaw_task().
>   */

Thanks for the detailed comment. The change looks good to me.

>  static int __set_task_special(struct task_struct *p, void *arg)
>  {
> -	unsigned int state = 0;
> +	unsigned int state = p->saved_state;
>  
>  	if (p->jobctl & JOBCTL_TRACED)
>  		state = TASK_TRACED;
> @@ -188,7 +199,7 @@ static int __set_task_special(struct task_struct *p, void *arg)
>  	if (state)
>  		WRITE_ONCE(p->__state, state);
>  
> -	return state;
> +	return state & ~TASK_FROZEN;
>  }

void __thaw_task(struct task_struct *p)
{

...

	if (lock_task_sighand(p, &flags2)) {
		/* TASK_FROZEN -> TASK_{STOPPED,TRACED} */
		bool ret = task_call_func(p, __set_task_special, NULL);
		unlock_task_sighand(p, &flags2);
		if (ret)
			goto unlock;
	}

	wake_up_state(p, TASK_FROZEN);
unlock:
	spin_unlock_irqrestore(&freezer_lock, flags);
}


The comment there about task change needs update. I feel the "ret"
should be renamed approriately to indicate whether wakeup is needed 
or not.

Now that we have saved_state capturing the previous and any state change
while task is frozen, can that be used and remove the job control and
associated locking here? for ex: if saved_state is running, we need to
wakeup otherwise, simply restore the __state from saved_state.

>  
>  void __thaw_task(struct task_struct *p)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..815d955764a5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3992,13 +3992,17 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
>   * The caller holds p::pi_lock if p != current or has preemption
>   * disabled when p == current.
>   *
> - * The rules of PREEMPT_RT saved_state:
> + * The rules of saved_state:
>   *
>   *   The related locking code always holds p::pi_lock when updating
>   *   p::saved_state, which means the code is fully serialized in both cases.
>   *
> - *   The lock wait and lock wakeups happen via TASK_RTLOCK_WAIT. No other
> - *   bits set. This allows to distinguish all wakeup scenarios.
> + *   For PREEMPT_RT, the lock wait and lock wakeups happen via TASK_RTLOCK_WAIT.
> + *   No other bits set. This allows to distinguish all wakeup scenarios.
> + *
> + *   For FREEZER, the wakeup happens via TASK_FROZEN. No other bits set. This
> + *   allows us to prevent early wakeup of tasks before they can be run on
> + *   asymmetric ISA architectures (eg ARMv9).
>   */
>  static __always_inline
>  bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
> @@ -4013,13 +4017,14 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
>  		return true;
>  	}
>  
> -#ifdef CONFIG_PREEMPT_RT
> +#if IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_FREEZER)
>  	/*
>  	 * Saved state preserves the task state across blocking on
> -	 * an RT lock.  If the state matches, set p::saved_state to
> -	 * TASK_RUNNING, but do not wake the task because it waits
> -	 * for a lock wakeup. Also indicate success because from
> -	 * the regular waker's point of view this has succeeded.
> +	 * an RT lock or TASK_FREEZABLE tasks.  If the state matches,
> +	 * set p::saved_state to TASK_RUNNING, but do not wake the task
> +	 * because it waits for a lock wakeup or __thaw_task(). Also
> +	 * indicate success because from the regular waker's point of
> +	 * view this has succeeded.
>  	 *
>  	 * After acquiring the lock the task will restore p::__state
>  	 * from p::saved_state which ensures that the regular
> 
> ---
> base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
> change-id: 20230817-avoid-spurious-freezer-wakeups-9f8619680b3a

Your patch seems based on v6.4. You might want to resend the patch on
v6.5 to take the below commit into account.

1c06918788e8a ("sched: Consider task_struct::saved_state in
wait_task_inactive()")

Thanks,
Pavan
