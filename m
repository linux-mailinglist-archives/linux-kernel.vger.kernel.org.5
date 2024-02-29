Return-Path: <linux-kernel+bounces-86362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE8A86C469
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7703B25019
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA09656B80;
	Thu, 29 Feb 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DMzK5rWr"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830A54FBB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197303; cv=none; b=gY8bMjYak2dk+v7JHVFzxzi2B8cVgZpMmY1QWxJ1imy+ZyDyyTcjJ41I7yFr1S9+kBN3XJd0uoSu/ajY6iyy4fjsMhkXsirHfYtPrDq1sXs2BeXonuhRIvYiVLT0ckZKQJz+S6MRTwICzJhyf3pdN3xx/mNqSbDp89Ww9BeEs+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197303; c=relaxed/simple;
	bh=hItLO7VanrN+m6xHMkLjQkLMEeRdSTJX+I7zjIOedNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJBOWdNZ9Fz+fWiUH3NesCHkQ7yRMwpmvceE45dWJMJv/JvESXoIka9uQfywi5rvOnAJuZCO05VQAvPRYx5qBIdxleczd3RH/vLjGMxjuW9+fYAim0yAF7X90FHuSMjKaTeIqp8A1eYuMI6QBQnXi4/DhvS5OM2AJMpw5wTBlxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DMzK5rWr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e57ab846a1so417368b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709197300; x=1709802100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=an35NBp5Mp8TLZfvQl1bisU8Xz+LHk2m54lQFmMBW7M=;
        b=DMzK5rWrKbxJ+Qh46csPH42MEENMj3ArUSbXNuWlVCNsSs1DDNGH9mEZiklKPHUhIh
         ZY8rWAZlN8NsT9gzvElSQ5G1sxmvdaAVNtaDq64d/BQmoexUpYv81dbFHvMYNgE8c6Cf
         n/kYDbo9A9Vh4Uuwg/7vrEGxFOiXIDKg/Ld72pYOUAsLfpD008ueMXFdLfZAiCqt3huU
         2HRXDLlupiOuQ/AhpLYHuH3NVIMbwjpB0hEqQ4yfL6syrEJNurp8C5Wi1hQgBEz2J9jK
         gWOqIWT78cXC92itNqYgOQNUXreBygsTuyocB5tyPIhUoRVvXWO+elVMemPRgeVJ/pyw
         CWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709197300; x=1709802100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=an35NBp5Mp8TLZfvQl1bisU8Xz+LHk2m54lQFmMBW7M=;
        b=KSKOzMqcnktYKfPs0RD/vpmVAWiFksuGIA6MGuERVOAvJSIfELLJPLjGQ6xtYkAxer
         iJmlUfnhNrqMxBcWWZIS917pqr3pvVGeeZclD7ps4gyTd2PzJCUAXp5QvQ9YF3CGfCK9
         nYi+QOX1EnwQiote9+l0e/MrkFRP/1X+6744Zfnst1Qum/WC4R1iC3LsDH/mAmucscpK
         rpNSjn6utZOY6Wi7TJ9+OleWlnn2HmPMUJGkAB4UkbKlIXToptZJh48QpYNfWiqvgc31
         tpCuO2qKklZHVI3SRglHxRa6R51duBbmBP7eE2/gIvTBQWHrsMYhTIq63Jc1X4jtvlww
         w9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmL0JHrz87TTsQAkcrk8mXyNeFJeI8DwwDuZWnEEgbl1FF4ZlDrxXUhtLRochI7Yr7qykkmBj+IVAJUiMrEwOFWqXCp/8PMm1zqIwQ
X-Gm-Message-State: AOJu0Yx7EPiDL8DewltWmiOypd2mNi0Au9B09OeuaumOdeSkUrpDks+G
	4E+LCNwCz9XwaKT7pyyEfyivUItcEyafqaf5YSKLq9skDo8/cBdKF9vufaX27Vo=
X-Google-Smtp-Source: AGHT+IFY3AHg4m8nBMNVAFaa01zrNve+4dbHUktxFyT7dirxUCQtarrXYNSe+xM10W0RtgItMALuOw==
X-Received: by 2002:a62:d44e:0:b0:6e4:f12c:c43e with SMTP id u14-20020a62d44e000000b006e4f12cc43emr1451475pfl.24.1709197300042;
        Thu, 29 Feb 2024 01:01:40 -0800 (PST)
Received: from [10.84.152.139] ([203.208.167.152])
        by smtp.gmail.com with ESMTPSA id a15-20020aa78e8f000000b006e5808b472esm807258pfr.95.2024.02.29.01.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 01:01:39 -0800 (PST)
Message-ID: <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
Date: Thu, 29 Feb 2024 17:00:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: Tim Chen <tim.c.chen@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>,
 Honglei Wang <wanghonglei@didichuxing.com>, Aaron Lu <aaron.lu@intel.com>,
 Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20240226082349.302363-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chen, thanks for detailed analysis.

The title of this patch sounds a little weird to me, since any
non-empty cfs_rq should have at least one eligible entity. Besides,
choosing the leftmost entity which could be non-eligible can be
sub-optimal, anyway this is only a workaround..

On 2/26/24 4:23 PM, Chen Yu Wrote:
> There is occasional report from lkp that the kernel hits the NULL pointer
> exception:
> 
> [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
> [  512.080897][ T8305] #PF: supervisor read access in kernel mode
> [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
> [  512.082337][ T8305] *pde = 00000000
> [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
> [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W
> [  512.086203][ T8305] EIP: set_next_entity (fair.c:?)
> 
> This is caused by NULL candidate returned by pick_eevdf() as Abel analyzed.
> After
> commit 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadline")
> the NULL candidate would trigger the NULL pointer exception. While before
> this commit, there would be warning.
> 
> This NULL entity issue was always there before above commit. With debug
> patch to print the cfs_rq and all the entities in the tree, we have the
> information when the issue was reproduced:
> 
> [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 min_vruntime:763383370431
> [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852013562231446
> 			min_vruntime:18437121115753667698 vruntime:18435852013561943404, load:629
> [  514.536772][ T8390] Traverse rb-tree from left to right
> [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
> [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> [  514.538539][ T8390] Traverse rb-tree from topdown
> [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
> [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> [  514.540340][ T8390] Found best:0x0
> [  514.540613][ T8390] BUG: kernel NULL pointer dereference, address: 00000074
> 
> We can see that non of the entities in the tree are eligible, neither is
> the current entity on this cfs_rq. As a result, curr is set to NULL:
> if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> 	curr = NULL;
> 
> and the best is set to NULL, which caused the problem:
> if (!best || (curr && entity_before(curr, best)))
> 	best = curr;
> 
> The cause is that, the curr is eligible, but vruntime_eligible()
> returns false. And the false negative is due to the following
> code in vruntime_eligible():
> 
> return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
> 
> According to the log, vruntime is 18435852013561943404, the
> cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
> thus:
> s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
>      delta * 2677 = 7733399554989275921
> that is to say, the multiply result overflow the s64, which turns the
> negative value into a positive value, thus eligible check fails.

Indeed.

> 
> So where is this insane huge vruntime 18435852013561943404 coming from?
> My guess is that, it is because the initial value of cfs_rq->min_vruntime
> is set to (unsigned long)(-(1LL << 20)). If the task(watchdog in this case)
> seldom scheduled in, its vruntime might not move forward too much and
> remain its original value by previous place_entity().

So why not just initialize to 0? The (unsigned long)(-(1LL << 20))
thing is dangerous as it can easily blow up lots of calculations in
lag, key, avg_vruntime and so on.

Say during this pre-life, which is about 1ms for 1024-weight entity,
there is only one entity running in this cfs_rq. Now another entity
with funny lag joins in, being placed somewhere at 0+ vruntime, so
cfs_rq->min_vruntime needs to be adjusted accordingly which leads to
the breakage of cfs_rq->curr's key as you showed above.

> 
> The proper fix should deal with the overflow of entity_key() * load, but
> I don't have much clue on that, so propose this conservative method to
> restore the previous behavior before the mentioned commit.

Inspired by Xuewen's proposal, will it work if limit the key?

Thanks & BR,
	Abel

> 
> Fixes: 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadline")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@intel.com/
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>   kernel/sched/fair.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..fb9202f464e2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -880,7 +880,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
>   	struct sched_entity *se = __pick_first_entity(cfs_rq);
>   	struct sched_entity *curr = cfs_rq->curr;
> -	struct sched_entity *best = NULL;
> +	struct sched_entity *best = NULL, *leftmost;
>   
>   	/*
>   	 * We can safely skip eligibility check if there is only one entity
> @@ -905,6 +905,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   		goto found;
>   	}
>   
> +	leftmost = se;
> +
>   	/* Heap search for the EEVD entity */
>   	while (node) {
>   		struct rb_node *left = node->rb_left;
> @@ -937,6 +939,15 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   	if (!best || (curr && entity_before(curr, best)))
>   		best = curr;
>   
> +	/*
> +	 * entity_eligible() could bring false negative due to
> +	 * multiply overflow, which reports no eligible entity.
> +	 * Return leftmost entity as a backup(it is guaranteed
> +	 * the tree is not NULL.
> +	 */
> +	if (!best)
> +		best = leftmost;
> +
>   	return best;
>   }
>   

