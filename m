Return-Path: <linux-kernel+bounces-6217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F52819607
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5300D1F22F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127546A4;
	Wed, 20 Dec 2023 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PCAaEnQO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715A3D75
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=twuVdNI7X+eOgqTug2j27yqgLemDEtt6zo+hBkRI6rQ=; b=PCAaEnQOu1aWysFtjXLiImGC8B
	f5THTKRbGcvv4DhGRLw53u8PsEAa0b4PlCTJnQ+kgmoSws7f7qPaOg1vGFjnKWhcU5ah68Pj+hc62
	Rq3SkHfz4EZJyZc3yVq76wyYP6SuhBQ8gherhAXcYVCfjC6NxmIUxCwfI7hMUwqVoZruw5ZUnpUEI
	BYJ3hiKsetWNRO7EMNTx5JcfrzH4/wpcoT5QZu4IelRu3b1At3SK3K3TRFdNMQb8ri/lyf1U9XVzw
	vho0v0uPk6FV2hgCbgMriav/gU0HKVW/bCNr27u33MzyMbkMyl968DDYqNnCQkPkLYp3HGZrDa2SI
	bnS0eOiA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFkvW-00FqzU-18;
	Wed, 20 Dec 2023 00:59:10 +0000
Message-ID: <338faf05-e545-4b17-b941-32a4a02adbd4@infradead.org>
Date: Tue, 19 Dec 2023 16:59:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 17/23] sched: Initial sched_football test
 implementation
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
References: <20231220001856.3710363-1-jstultz@google.com>
 <20231220001856.3710363-18-jstultz@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231220001856.3710363-18-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi John,

On 12/19/23 16:18, John Stultz wrote:
> Reimplementation of the sched_football test from LTP:
> https://github.com/linux-test-project/ltp/blob/master/testcases/realtime/func/sched_football/sched_football.c
> 
> But reworked to run in the kernel and utilize mutexes
> to illustrate proper boosting of low priority mutex
> holders.
> 
> TODO:
> * Need a rt_mutex version so it can work w/o proxy-execution
> * Need a better place to put it
> 
> Cc: kernel-team@android.com
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  kernel/sched/Makefile              |   1 +
>  kernel/sched/test_sched_football.c | 242 +++++++++++++++++++++++++++++
>  lib/Kconfig.debug                  |  14 ++
>  3 files changed, 257 insertions(+)
>  create mode 100644 kernel/sched/test_sched_football.c
> 


> diff --git a/kernel/sched/test_sched_football.c b/kernel/sched/test_sched_football.c
> new file mode 100644
> index 000000000000..9742c45c0fe0
> --- /dev/null
> +++ b/kernel/sched/test_sched_football.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Module-based test case for RT scheduling invariant
> + *
> + * A reimplementation of my old sched_football test
> + * found in LTP:
> + *   https://github.com/linux-test-project/ltp/blob/master/testcases/realtime/func/sched_football/sched_football.c
> + *
> + * Similar to that test, this tries to validate the RT
> + * scheduling invariant, that the across N available cpus, the
> + * top N priority tasks always running.
> + *
> + * This is done via having N offsensive players that are
> + * medium priority, which constantly are trying to increment the
> + * ball_pos counter.
> + *
> + * Blocking this, are N defensive players that are higher

no comma           ^

> + * priority which just spin on the cpu, preventing the medium
> + * priroity tasks from running.
> + *
> + * To complicate this, there are also N defensive low priority
> + * tasks. These start first and each aquire one of N mutexes.

                                        acquire

> + * The high priority defense tasks will later try to grab the
> + * mutexes and block, opening a window for the offsensive tasks

                                                  offensive

> + * to run and increment the ball. If priority inheritance or
> + * proxy execution is used, the low priority defense players
> + * should be boosted to the high priority levels, and will
> + * prevent the mid priority offensive tasks from running.
> + *
> + * Copyright © International Business Machines  Corp., 2007, 2008
> + * Copyright (C) Google, 2023
> + *
> + * Authors: John Stultz <jstultz@google.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/kthread.h>
> +#include <linux/delay.h>
> +#include <linux/sched/rt.h>
> +#include <linux/spinlock.h>
> +#include <linux/mutex.h>
> +#include <linux/rwsem.h>
> +#include <linux/smp.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched.h>
> +#include <uapi/linux/sched/types.h>
> +#include <linux/rtmutex.h>
> +
> +atomic_t players_ready;
> +atomic_t ball_pos;
> +int players_per_team;
> +bool game_over;
> +
> +struct mutex *mutex_low_list;
> +struct mutex *mutex_mid_list;
> +

[]

Is this the referee?

> +int ref_thread(void *arg)
> +{
> +	struct task_struct *kth;
> +	long game_time = (long)arg;
> +	unsigned long final_pos;
> +	long i;
> +
> +	pr_info("%s: started ref, game_time: %ld secs !\n", __func__,
> +		game_time);
> +
> +	/* Create low  priority defensive team */
> +	for (i = 0; i < players_per_team; i++)
> +		kth = create_fifo_thread(defense_low_thread, (void *)i,
> +					 "defese-low-thread", 2);

					  defense

> +	/* Wait for the defense threads to start */
> +	while (atomic_read(&players_ready) < players_per_team)
> +		msleep(1);
> +
> +	for (i = 0; i < players_per_team; i++)
> +		kth = create_fifo_thread(defense_mid_thread,
> +					 (void *)(players_per_team - i - 1),
> +					 "defese-mid-thread", 3);

					  ditto

> +	/* Wait for the defense threads to start */
> +	while (atomic_read(&players_ready) < players_per_team * 2)
> +		msleep(1);
> +
> +	/* Create mid priority offensive team */
> +	for (i = 0; i < players_per_team; i++)
> +		kth = create_fifo_thread(offense_thread, NULL,
> +					 "offense-thread", 5);
> +	/* Wait for the offense threads to start */
> +	while (atomic_read(&players_ready) < players_per_team * 3)
> +		msleep(1);
> +
> +	/* Create high priority defensive team */
> +	for (i = 0; i < players_per_team; i++)
> +		kth = create_fifo_thread(defense_hi_thread, (void *)i,
> +					 "defese-hi-thread", 10);

					  ditto

> +	/* Wait for the defense threads to start */
> +	while (atomic_read(&players_ready) < players_per_team * 4)
> +		msleep(1);
> +
> +	/* Create high priority defensive team */
> +	for (i = 0; i < players_per_team; i++)
> +		kth = create_fifo_thread(crazy_fan_thread, NULL,
> +					 "crazy-fan-thread", 15);
> +	/* Wait for the defense threads to start */
> +	while (atomic_read(&players_ready) < players_per_team * 5)
> +		msleep(1);
> +
> +	pr_info("%s: all players checked in! Starting game.\n", __func__);
> +	atomic_set(&ball_pos, 0);
> +	msleep(game_time * 1000);
> +	final_pos = atomic_read(&ball_pos);
> +	pr_info("%s: final ball_pos: %ld\n", __func__, final_pos);
> +	WARN_ON(final_pos != 0);
> +	game_over = true;
> +	return 0;
> +}
> +


> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 4405f81248fb..1d90059d190f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1238,6 +1238,20 @@ config SCHED_DEBUG
>  	  that can help debug the scheduler. The runtime overhead of this
>  	  option is minimal.
>  
> +config SCHED_RT_INVARIENT_TEST

                   INVARIANT

> +	tristate "RT invarient scheduling tester"

	             invariant

> +	depends on DEBUG_KERNEL
> +	help
> +	  This option provides a kernel module that runs tests to make
> +	  sure the RT invarient holds (top N priority tasks run on N

	              invariant

> +	  available cpus).
> +
> +	  Say Y here if you want kernel rt scheduling tests

	                                RT

> +	  to be built into the kernel.
> +	  Say M if you want this test to build as a module.
> +	  Say N if you are unsure.
> +
> +
>  config SCHED_INFO
>  	bool
>  	default n

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

