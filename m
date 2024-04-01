Return-Path: <linux-kernel+bounces-126509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38588938D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BE61F2167D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C344C101C1;
	Mon,  1 Apr 2024 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Yig2SCAM"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957DAB67D;
	Mon,  1 Apr 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711958815; cv=none; b=JI4yR034TuurgQZ8ZxmzYeX9xS3z6/ip3NbXO3KFUBNHHrInskd2G1dHK5O9/uGkEhqrwJ0NJbrvUVFY6LYSNt2iWtQgr910otNLxDoHGycJbrd4DpE+qnTQ21OR05y/UKFpv2Z6Tbzjr8Iin0YYulW/f6Z8M4RuNzwPJ/8637w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711958815; c=relaxed/simple;
	bh=dv7waqHQs0vwYKfDcU27zXQuQ91eC/DvcVEwqH0xT7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJX15+IigKuizYg8aJaINNZ3JZv9IIdK3Q9bZLxHh7yuDo95tvOIsadTKslfT8VdXO7LWshqS1alIWS7IzgtxBsxw64dlVdQbJrnQnNhPxpVCUg4etGeYUUVee5FgJgRhCRoyty1LWO9NUXGzwGY+W+qlUgjxUbLZVs9yuwjgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Yig2SCAM; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=OWoUGFK7msyMCDg9YbIYisHA611Jcw8kSzLG0yI4RZs=;
	b=Yig2SCAMic+m84mKTiObnnVPcQ2fQR9yDPvdznkmbfr/aKG/9OS/Pjw1DsyAkb
	W6uJB/ENr99iQFhrEk1P+EuOAshXoJdTYnE8Zv6tti6Ge9nzwBiaCwdRjFXti7FO
	YkcfkyTDgEybJQHjEF3Yv3cQ+Tg6ceaac9o8ytPfHTOQ0=
Received: from [172.24.140.18] (unknown [111.204.182.99])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wD33+qRagpmB4MsAg--.37333S2;
	Mon, 01 Apr 2024 16:04:36 +0800 (CST)
Message-ID: <073e5bf0-99c4-4dc5-8894-5442e2d53a34@126.com>
Date: Mon, 1 Apr 2024 16:04:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix forked task check in vruntime_normalized
To: "mingyang.cui" <mingyang.cui@horizon.ai>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 stable@vger.kernel.org, tkjos@google.com, pjt@google.com,
 quentin.perret@arm.com, Patrick.Bellasi@arm.com, Chris.Redpath@arm.com,
 Morten.Rasmussen@arm.com, joaodias@google.com
References: <20240328062757.29803-1-mingyang.cui@horizon.ai>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <20240328062757.29803-1-mingyang.cui@horizon.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD33+qRagpmB4MsAg--.37333S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1kXw48JF4UXFW7Ar4kXrb_yoW5Xw13pF
	4kXFW3Jr4kWw12krnrJrZ7Jry5G393Ga17JrnIya4rAws8Ww1IyrW7Ka129FWjyr4xAFWf
	tF48tw4fGws0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jVQ6JUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiTxOzrWVLZlNMcQABsl



On 2024/3/28 14:27, mingyang.cui wrote:
> When rt_mutex_setprio changes a task's scheduling class to RT,
> sometimes the task's vruntime is not updated correctly upon
> return to the fair class.
> Specifically, the following is being observed:
> - task has just been created and running for a short time
> - task sleep while still in the fair class
> - task is boosted to RT via rt_mutex_setprio, which changes
>    the task to RT and calls check_class_changed.
> - check_class_changed leads to detach_task_cfs_rq, at which point
>    the vruntime_normalized check sees that the task's sum_exec_runtime
>    is zero, which results in skipping the subtraction of the
>    rq's min_vruntime from the task's vruntime
Hi Mingyang,

Did you do the test on the latest tree? vruntime_normalized was removed 
by e8f331bcc2 (sched/smp: Use lag to simplify cross-runqueue placement).

Thanks,
Honglei

> - later, when the prio is deboosted and the task is moved back
>    to the fair class, the fair rq's min_vruntime is added to
>    the task's vruntime, even though it wasn't subtracted earlier.
> 
> Since the task's vruntime is about double that of other tasks in cfs_rq,
> the task to be unable to run for a long time when there are continuous
> runnable tasks in cfs_rq.
> 
> The immediate result is inflation of the task's vruntime, giving
> it lower priority (starving it if there's enough available work).
> The longer-term effect is inflation of all vruntimes because the
> task's vruntime becomes the rq's min_vruntime when the higher
> priority tasks go idle. That leads to a vicious cycle, where
> the vruntime inflation repeatedly doubled.
> 
> The root cause of the problem is that the vruntime_normalized made a
> misjudgment. Since the sum_exec_runtime of some tasks that were just
> created and run for a short time is zero, the vruntime_normalized
> mistakenly thinks that they are tasks that have just been forked.
> Therefore, sum_exec_runtime is not subtracted from the vruntime of the
> task.
> 
> So, we fix this bug by adding a check condition for newly forked task.
> 
> Signed-off-by: mingyang.cui <mingyang.cui@horizon.ai>
> ---
>   kernel/sched/fair.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 73a89fbd81be..3d0c14f3731f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11112,7 +11112,7 @@ static inline bool vruntime_normalized(struct task_struct *p)
>   	 * - A task which has been woken up by try_to_wake_up() and
>   	 *   waiting for actually being woken up by sched_ttwu_pending().
>   	 */
> -	if (!se->sum_exec_runtime ||
> +	if (!se->sum_exec_runtime && p->state == TASK_NEW ||
>   	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
>   		return true;
>   


