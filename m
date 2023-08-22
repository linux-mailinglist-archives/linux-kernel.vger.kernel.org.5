Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526DF784A03
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjHVTMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHVTMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB00CE5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692731506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Shv17jTZAkKCjE44GHF0Xqxtw72d64wxEGUZCylGcP4=;
        b=Jy2SmZdqE46Ai57aGPUhM/koHk8V0RUjevw7DzI6Lhm3341je2ofWHwFX5gJgOLlQSuMiQ
        7/163uFPrIRjx4PwNde2bhazqMqEPIPg5K/oNXIOzybWQmyO6H+LIkmaX23MqjuTzDo64b
        MJkUv/vb/TyTGvqRlOLqx+YaAOng5V4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-6R8jjTdHNSyiUhChpqQXXw-1; Tue, 22 Aug 2023 15:11:42 -0400
X-MC-Unique: 6R8jjTdHNSyiUhChpqQXXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 906BD85C6E2;
        Tue, 22 Aug 2023 19:11:41 +0000 (UTC)
Received: from [10.22.17.88] (unknown [10.22.17.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57BD340C2073;
        Tue, 22 Aug 2023 19:11:40 +0000 (UTC)
Message-ID: <034a302d-773d-5bdb-a32b-bd283d6c7710@redhat.com>
Date:   Tue, 22 Aug 2023 15:11:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 02/19] locking/mutex: Removes wakeups from under
 mutex::wait_lock
Content-Language: en-US
To:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
References: <20230819060915.3001568-1-jstultz@google.com>
 <20230819060915.3001568-3-jstultz@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230819060915.3001568-3-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/23 02:08, John Stultz wrote:
> In preparation to nest mutex::wait_lock under rq::lock we need to remove
> wakeups from under it.
>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E . McKenney" <paulmck@kernel.org>
> Cc: kernel-team@android.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [Heavily changed after 55f036ca7e74 ("locking: WW mutex cleanup") and
> 08295b3b5bee ("locking: Implement an algorithm choice for Wound-Wait
> mutexes")]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> [jstultz: rebased to mainline, added extra wake_up_q & init
>   to avoid hangs, similar to Connor's rework of this patch]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v5:
> * Reverted back to an earlier version of this patch to undo
>    the change that kept the wake_q in the ctx structure, as
>    that broke the rule that the wake_q must always be on the
>    stack, as its not safe for concurrency.
> ---
>   kernel/locking/mutex.c    | 15 ++++++++++++---
>   kernel/locking/ww_mutex.h | 29 ++++++++++++++++++-----------
>   2 files changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index d973fe6041bf..118b6412845c 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -570,6 +570,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   		    struct lockdep_map *nest_lock, unsigned long ip,
>   		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
>   {
> +	DEFINE_WAKE_Q(wake_q);
>   	struct mutex_waiter waiter;
>   	struct ww_mutex *ww;
>   	int ret;
> @@ -620,7 +621,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   	 */
>   	if (__mutex_trylock(lock)) {
>   		if (ww_ctx)
> -			__ww_mutex_check_waiters(lock, ww_ctx);
> +			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
>   
>   		goto skip_wait;
>   	}
> @@ -640,7 +641,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   		 * Add in stamp order, waking up waiters that must kill
>   		 * themselves.
>   		 */
> -		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
> +		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx, &wake_q);
>   		if (ret)
>   			goto err_early_kill;
>   	}
> @@ -676,6 +677,10 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   		}
>   
>   		raw_spin_unlock(&lock->wait_lock);
> +		/* Make sure we do wakeups before calling schedule */
> +		wake_up_q(&wake_q);
> +		wake_q_init(&wake_q);
> +

The wake_q may have task to wake up only in the case of ww_mutex which 
is a minority in the kernel. IOW, wake_up_q() which is a function call 
will do nothing in most cases. From an optimization point of view, it is 
better to do a "!wake_q_empty(&wake_q)" check before calling wake_up_q().


>   		schedule_preempt_disabled();
>   
>   		first = __mutex_waiter_is_first(lock, &waiter);
> @@ -709,7 +714,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   		 */
>   		if (!ww_ctx->is_wait_die &&
>   		    !__mutex_waiter_is_first(lock, &waiter))
> -			__ww_mutex_check_waiters(lock, ww_ctx);
> +			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
>   	}
>   
>   	__mutex_remove_waiter(lock, &waiter);
> @@ -725,6 +730,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   		ww_mutex_lock_acquired(ww, ww_ctx);
>   
>   	raw_spin_unlock(&lock->wait_lock);
> +	wake_up_q(&wake_q);
>   	preempt_enable();
>   	return 0;
>   
> @@ -736,6 +742,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>   	raw_spin_unlock(&lock->wait_lock);
>   	debug_mutex_free_waiter(&waiter);
>   	mutex_release(&lock->dep_map, ip);
> +	wake_up_q(&wake_q);
>   	preempt_enable();
>   	return ret;
>   }
> @@ -946,9 +953,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>   	if (owner & MUTEX_FLAG_HANDOFF)
>   		__mutex_handoff(lock, next);
>   
> +	preempt_disable();
>   	raw_spin_unlock(&lock->wait_lock);
>   
>   	wake_up_q(&wake_q);
> +	preempt_enable();
>   }

I think it looks better to put the preempt_disable() right before 
raw_spin_lock() for proper nesting.

Cheers,
Longman

