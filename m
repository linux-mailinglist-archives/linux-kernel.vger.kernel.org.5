Return-Path: <linux-kernel+bounces-20777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C927E828512
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FA71F25ABB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0F36B1A;
	Tue,  9 Jan 2024 11:28:36 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A8381C8;
	Tue,  9 Jan 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T8TF658DYz1wrqC;
	Tue,  9 Jan 2024 19:27:54 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id F10E81402CB;
	Tue,  9 Jan 2024 19:28:30 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 19:28:30 +0800
Subject: Re: [RFC PATCH] kprobes: Use synchronize_rcu_tasks_rude in
 kprobe_optimizer
To: Chen Zhongjin <chenzhongjin@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <paulmck@kernel.org>, <mhiramat@kernel.org>,
	<akpm@linux-foundation.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<pmladek@suse.com>, <dianders@chromium.org>, <npiggin@gmail.com>,
	<mpe@ellerman.id.au>, <jkl820.git@gmail.com>,
	<juerg.haefliger@canonical.com>, <rick.p.edgecombe@intel.com>,
	<eric.devolder@oracle.com>, <mic@digikod.net>
References: <20240102034024.256326-1-chenzhongjin@huawei.com>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <29eaed4d-c4e5-cf9b-113b-da146b719820@huawei.com>
Date: Tue, 9 Jan 2024 19:28:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240102034024.256326-1-chenzhongjin@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Hello,

PING.

I had a similar problem. Is this solution feasible?

Thanks,
Yang

On 2024/1/2 11:40, Chen Zhongjin wrote:
> There is a deadlock scenario in kprobe_optimizer():
> 
> pid A				pid B			pid C
> kprobe_optimizer()		do_exit()		perf_kprobe_init()
> mutex_lock(&kprobe_mutex)	exit_tasks_rcu_start()	mutex_lock(&kprobe_mutex)
> synchronize_rcu_tasks()		zap_pid_ns_processes()	// waiting kprobe_mutex
> // waiting tasks_rcu_exit_srcu	kernel_wait4()
> 				// waiting pid C exit
> 
> To avoid this deadlock loop, use synchronize_rcu_tasks_rude() in kprobe_optimizer()
> rather than synchronize_rcu_tasks(). synchronize_rcu_tasks_rude() can also promise
> that all preempted tasks have scheduled, but it will not wait tasks_rcu_exit_srcu.
> 
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>   arch/Kconfig     | 2 +-
>   kernel/kprobes.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index f4b210ab0612..dc6a18854017 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
>   config OPTPROBES
>   	def_bool y
>   	depends on KPROBES && HAVE_OPTPROBES
> -	select TASKS_RCU if PREEMPTION
> +	select TASKS_RUDE_RCU
>   
>   config KPROBES_ON_FTRACE
>   	def_bool y
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index d5a0ee40bf66..09056ae50c58 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -623,7 +623,7 @@ static void kprobe_optimizer(struct work_struct *work)
>   	 * Note that on non-preemptive kernel, this is transparently converted
>   	 * to synchronoze_sched() to wait for all interrupts to have completed.
>   	 */
> -	synchronize_rcu_tasks();
> +	synchronize_rcu_tasks_rude();
>   
>   	/* Step 3: Optimize kprobes after quiesence period */
>   	do_optimize_kprobes();
> 

