Return-Path: <linux-kernel+bounces-137074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5B989DBFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528FE1C2125F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A612FF93;
	Tue,  9 Apr 2024 14:15:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DDA12FB0F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672148; cv=none; b=azlSq8V+mEfJHbyk22xC6ZqWV7PV0M7e9G6wlbf28MjRmlZbX+tHwiHM0LW317bVn5OmU/PvwlVtsZVhaUYtxW0+pXZUssK9fyR1rs0F5uVsp1XJwuB+qC1uqz4QdPL1OML2RFOChNwfaogLHLpv/sZ4ICApVEUPM7P2YiIxyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672148; c=relaxed/simple;
	bh=r5H2wFPyQ8ZrN4fvic1xS376fv3+AcK6k51m9j+GChY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jYY3wzwJoW7kPEfC1KDZZQkRASmWphoT0a2efuqkwKMflOxLmNaJB3A/k6/jN95YRENka38btADYA72cuJHD8RdzV0z+NvG24M8fusPfs6BAYkC4GP7bCzmyB/sdlSdTCQZ8Nlips747M6b3L8+s7EoDSUTR8yTOc8ZSxla3psU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VDSdb1kB8zFr7V;
	Tue,  9 Apr 2024 22:14:43 +0800 (CST)
Received: from dggpemd100001.china.huawei.com (unknown [7.185.36.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A09D1400FD;
	Tue,  9 Apr 2024 22:15:41 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 22:15:40 +0800
Message-ID: <4d331659-badd-749d-fba1-271543631a8a@huawei.com>
Date: Tue, 9 Apr 2024 22:15:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] softirq: fix memory corruption when freeing
 tasklet_struct
To: Mikulas Patocka <mpatocka@redhat.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <dm-devel@lists.linux.dev>, Mike Snitzer
	<msnitzer@redhat.com>, Ignat Korchagin <ignat@cloudflare.com>, Damien Le Moal
	<damien.lemoal@wdc.com>, Bob Liu <bob.liu@oracle.com>, Hou Tao
	<houtao1@huawei.com>, Nathan Huckleberry <nhuck@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, "yukuai (C)"
	<yukuai3@huawei.com>, yangerkun <yangerkun@huawei.com>, "zhangyi (F)"
	<yi.zhang@huawei.com>, <lilingfeng3@huawei.com>, Li Lingfeng
	<lilingfeng@huaweicloud.com>
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemd100001.china.huawei.com (7.185.36.94)

Hi

I tried to reproduce the problem by adding mdelay() in 
tasklet_action_common() after t->func() but failed.
Since cc->io_queue is created without WQ_UNBOUND, the work queued to it 
will be executed by the CPU which queued the work, which means 
bio_endio() will not be called until tasklet_action_common has finished.
Could you please clarify how to reproduce the problem mentioned here?

Thanks

在 2024/1/26 2:29, Mikulas Patocka 写道:
> Hi
>
> There's a problem with the tasklet API - there is no reliable way how to
> free a structure that contains tasklet_struct. The problem is that the
> function tasklet_action_common calls task_unlock(t) after it called the
> callback. If the callback does something that frees tasklet_struct,
> task_unlock(t) would write into free memory.
>
> dm-crypt does this - it schedules a tasklet with tasklet_schedule, it does
> encryption inside the tasklet handler (because it performs better than
> doing the encryption in a workqueue), then it submits a workqueue entry
> and calls bio_endio from the workqueue entry.
>
> However, if the workqueue preempts ksoftirqd, this race condition happens:
>
> ksoftirqd:
> * tasklet_action_common
> * t->func(t->data)	(that points to kcryptd_crypt_tasklet)
> * kcryptd_crypt_tasklet
> * kcryptd_crypt
> * kcryptd_crypt_read_convert
> * crypt_dec_pending
> * queue_work(cc->io_queue, &io->work);
> now we switch to the workqueue process:
> * kcryptd_io_bio_endio
> * bio_endio(io->base_bio)	(this calls clone_endio)
> * clone_endio
> * free_tio
> * bio_put(clone) - the bio is freed
> now we switch back to ksoftirqd:
> * tasklet_action_common calls task_unlock(t)
> * task_unlock(t) touches memory that was already freed when the bio was freed
>
> dm-verity has a similar problem.
>
> In order to fix this bug, I am proposing to add a new flag
> TASKLET_STATE_ONESHOT. The flag indicates that the tasklet will be
> submitted only once and it prevents tasklet_action_common from touching
> the tasklet after the callback completed.
>
> If you have another idea how to solve this bug, let me know.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: 39d42fa96ba1 ("dm crypt: add flags to optionally bypass kcryptd workqueues")
> Fixes: 5721d4e5a9cd ("dm verity: Add optional "try_verify_in_tasklet" feature")
> Cc: stable@vger.kernel.org	# v5.9+
>
> ---
>   drivers/md/dm-crypt.c         |    1 +
>   drivers/md/dm-verity-target.c |    1 +
>   include/linux/interrupt.h     |    9 ++++++++-
>   kernel/softirq.c              |   22 +++++++++++++++-------
>   4 files changed, 25 insertions(+), 8 deletions(-)
>
> Index: linux-2.6/drivers/md/dm-crypt.c
> ===================================================================
> --- linux-2.6.orig/drivers/md/dm-crypt.c	2024-01-18 19:18:30.000000000 +0100
> +++ linux-2.6/drivers/md/dm-crypt.c	2024-01-25 16:42:17.000000000 +0100
> @@ -2265,6 +2265,7 @@ static void kcryptd_queue_crypt(struct d
>   		if (in_hardirq() || irqs_disabled()) {
>   			io->in_tasklet = true;
>   			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
> +			tasklet_set_oneshot(&io->tasklet);
>   			tasklet_schedule(&io->tasklet);
>   			return;
>   		}
> Index: linux-2.6/include/linux/interrupt.h
> ===================================================================
> --- linux-2.6.orig/include/linux/interrupt.h	2023-11-13 17:39:50.000000000 +0100
> +++ linux-2.6/include/linux/interrupt.h	2024-01-25 16:41:52.000000000 +0100
> @@ -684,7 +684,9 @@ struct tasklet_struct name = {				\
>   enum
>   {
>   	TASKLET_STATE_SCHED,	/* Tasklet is scheduled for execution */
> -	TASKLET_STATE_RUN	/* Tasklet is running (SMP only) */
> +	TASKLET_STATE_RUN,	/* Tasklet is running (SMP only) */
> +	TASKLET_STATE_ONESHOT	/* Don't unlock the tasklet after the callback
> +				   to avoid writing to free memory */
>   };
>   
>   #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
> @@ -756,6 +758,11 @@ extern void tasklet_init(struct tasklet_
>   extern void tasklet_setup(struct tasklet_struct *t,
>   			  void (*callback)(struct tasklet_struct *));
>   
> +static inline void tasklet_set_oneshot(struct tasklet_struct *t)
> +{
> +	__set_bit(TASKLET_STATE_ONESHOT, &t->state);
> +}
> +
>   /*
>    * Autoprobing for irqs:
>    *
> Index: linux-2.6/kernel/softirq.c
> ===================================================================
> --- linux-2.6.orig/kernel/softirq.c	2023-10-31 15:31:42.000000000 +0100
> +++ linux-2.6/kernel/softirq.c	2024-01-25 17:10:03.000000000 +0100
> @@ -774,18 +774,26 @@ static void tasklet_action_common(struct
>   
>   		if (tasklet_trylock(t)) {
>   			if (!atomic_read(&t->count)) {
> +				/*
> +				 * If oneshot is set, we must not touch the
> +				 * tasklet after the callback.
> +				 */
> +				bool oneshot = test_bit(TASKLET_STATE_ONESHOT, &t->state);
>   				if (tasklet_clear_sched(t)) {
>   					if (t->use_callback) {
> -						trace_tasklet_entry(t, t->callback);
> -						t->callback(t);
> -						trace_tasklet_exit(t, t->callback);
> +						void (*callback)(struct tasklet_struct *) = t->callback;
> +						trace_tasklet_entry(t, callback);
> +						callback(t);
> +						trace_tasklet_exit(t, callback);
>   					} else {
> -						trace_tasklet_entry(t, t->func);
> -						t->func(t->data);
> -						trace_tasklet_exit(t, t->func);
> +						void (*func)(unsigned long) = t->func;
> +						trace_tasklet_entry(t, func);
> +						func(t->data);
> +						trace_tasklet_exit(t, func);
>   					}
>   				}
> -				tasklet_unlock(t);
> +				if (!oneshot)
> +					tasklet_unlock(t);
>   				continue;
>   			}
>   			tasklet_unlock(t);
> Index: linux-2.6/drivers/md/dm-verity-target.c
> ===================================================================
> --- linux-2.6.orig/drivers/md/dm-verity-target.c	2024-01-18 19:18:30.000000000 +0100
> +++ linux-2.6/drivers/md/dm-verity-target.c	2024-01-25 18:12:09.000000000 +0100
> @@ -676,6 +676,7 @@ static void verity_end_io(struct bio *bi
>   
>   	if (static_branch_unlikely(&use_tasklet_enabled) && io->v->use_tasklet) {
>   		tasklet_init(&io->tasklet, verity_tasklet, (unsigned long)io);
> +		tasklet_set_oneshot(&io->tasklet);
>   		tasklet_schedule(&io->tasklet);
>   	} else {
>   		INIT_WORK(&io->work, verity_work);
>

