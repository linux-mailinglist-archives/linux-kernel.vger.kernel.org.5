Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8FA79D378
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbjILOWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjILOWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 748C010D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694528518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m1nb7Olx7p3SmXA6GhlSHidjjdzGfOLW1N9cx0IdLdo=;
        b=Dor6k3uZR55Z43/fNagkcDnm25tyMxfjnDctOe8b0Ofvf+C0xWDvXKrT7RGbAlTeKxu2Q8
        YC9t5fMsPpDiclC0OmkJeBRtn38/Jj7iGpcLJd2PavnTHGxXCzqVofEaMg7e2LVqnGxhJ+
        C+NiLtWV1BTUv5X8fRp2UFhmlOrWDvU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-ll3bDRKJNT-tdIxRXWrqcQ-1; Tue, 12 Sep 2023 10:21:55 -0400
X-MC-Unique: ll3bDRKJNT-tdIxRXWrqcQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99A27903B41;
        Tue, 12 Sep 2023 14:21:54 +0000 (UTC)
Received: from [10.22.33.195] (unknown [10.22.33.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D04440C2064;
        Tue, 12 Sep 2023 14:21:53 +0000 (UTC)
Message-ID: <1c8b60a4-f6e8-4e9c-99b9-f5a3ba2f4475@redhat.com>
Date:   Tue, 12 Sep 2023 10:21:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] locking/rwbase: Fix race condition in rwlock_rt fast path
Content-Language: en-US
To:     Haodong Wong <haydenw.kernel@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        haodong.wong@nio.com
References: <20230911120732.2007894-1-haydenw.kernel@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230911120732.2007894-1-haydenw.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 08:07, Haodong Wong wrote:
> When the writer in fast path check onwer before sub READER_BIAS,since
> var readers=READER_BIAS, reader thread can jump to critical section to
> access the data that modified by writer which may cause itself panic.
>
> For example we observed below panic in SMP PREEMPT RT:
>
> Call trace:
>
>      try_to_wake_up+0x374/0x5d0
>      default_wake_function+0x3c/0x70
>      autoremove_wake_function+0x3c/0x70
>      __wake_up_common+0x90/0x150
>      __wake_up_common_lock+0x7c/0xc0
>      __wake_up+0x40/0x50
>      ep_poll_callback+0xa0/0x260
>      __wake_up_common+0x90/0x150
>      __wake_up_common_lock+0x7c/0xc0
>      __wake_up_sync_key+0x40/0x50
>      sock_def_readable+0x44/0x90
>      tcp_data_ready+0x3c/0xf0
>      tcp_rcv_established+0x754/0x7f0
>      tcp_v4_do_rcv+0x1f0/0x2e0
>      tcp_v4_rcv+0xb60/0xc80
>      ip_protocol_deliver_rcu+0x44/0x200
>      ip_local_deliver_finish+0x68/0x80
>      ip_local_deliver+0x80/0x130
>      ip_sublist_rcv_finish+0x48/0x70
>      ip_sublist_rcv+0x178/0x1f0
>      ip_list_rcv+0x108/0x1b0
>      __netif_receive_skb_list_core+0x18c/0x220
>      netif_receive_skb_list_internal+0x18c/0x2a0
>      napi_complete_done+0xc4/0x210
>      ether_napi_poll_rx+0xa4/0xe0
>      net_rx_action+0x120/0x430
>      __do_softirq+0x120/0x3b4
>      __local_bh_enable_ip+0xd8/0x140
>      irq_forced_thread_fn+0x84/0xc0
>      irq_thread+0x150/0x260
>      kthread+0x17c/0x1a0
>      ret_from_fork+0x10/0x18
>
> The process is as follows:
> Writer Thread					Reader Thread
>
> ep_poll:					ep_poll_callback:
>    write_lock_irq:				  read_lock_irq:
>
> 	set rtmutex onwer in fast patch
> 							  if reader < 0
>                                                               exit read_lock
>    __remove_wait_queue

After subtracting READER_BIAS, rwbase_write_lock() will wait until the 
reader count is 0 before proceeding. So I don't see an obvious race here 
since the reader count has to be non-zero when that reader enters its 
critical section.


> 						   _wake_up PANIC happen
>
> Signed-off-by: Haodong Wong <haydenw.kernel@gmail.com>
> ---
>   kernel/locking/rtmutex_common.h | 15 +++++++++++++++
>   kernel/locking/rwbase_rt.c      |  9 +++++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
> index 1162e07cdaea..d81042657ce2 100644
> --- a/kernel/locking/rtmutex_common.h
> +++ b/kernel/locking/rtmutex_common.h
> @@ -161,6 +161,15 @@ static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
>   	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
>   }
>   
> +static inline struct task_struct *rt_mutex_owner_acquire(struct rt_mutex_base *lock)
> +{
> +	/* Add rt mutex onwer acquire method */
> +	unsigned long owner = (unsigned long) smp_load_acquire(&lock->owner);
> +
> +	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
> +}
> +
> +
>   /*
>    * Constants for rt mutex functions which have a selectable deadlock
>    * detection.
> @@ -229,6 +238,12 @@ static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
>   {
>   	return NULL;
>   }
> +
> +static inline struct task_struct *rt_mutex_owner_acquire(struct rt_mutex_base *lock)
> +{
> +	return NULL;
> +}
> +
>   #endif  /* !CONFIG_RT_MUTEXES */
>   
>   #endif
> diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
> index 25ec0239477c..ca271f57b9c1 100644
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -54,6 +54,15 @@ static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
>   {
>   	int r;
>   
> +	/*
> +	 * Reader should check if writer in fast patch in case of they
> +	 * have race condition in the first time.
> +	 */
> +
> +	if ((atomic_read(&lock->readers) == READER_BIAS) &&
> +			rt_mutex_owner_acquire(&lock->rtmutex))
> +		return 0;
> +

Does this patch even compile? There is no variable lock in 
rwbase_read_trylock().

Cheers,
Longman

