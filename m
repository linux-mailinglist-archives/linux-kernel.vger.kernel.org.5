Return-Path: <linux-kernel+bounces-72306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1287B85B1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA47282D82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCAC55E60;
	Tue, 20 Feb 2024 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jdXgvX7I"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6F54F94
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401891; cv=none; b=El7ceY3dRUhSinz6INrpO4VYqSaLXuxMjS4fjjkxTH7xqaV3LlMx/qME/iweTK48bc0PChzwLnoFdsTyGFB+K+4i4DvkGVHUjYL8DjJB0711sAed+yVj9E19ArZZfhZXoJxwmObzS+3M45oEEqMkM3XggZue2AeInXRNWPuOCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401891; c=relaxed/simple;
	bh=GH67LCty89vHUo8LQF2ouv/Za92p+R/LzvO9zerLKPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwzV0DEgNuZeKFVtxKoKYu9fjRhSHhP57LazLRX2AaPUuNgX2Gf35LOUllf9B1RzUYfRtD8iNY0bLRDVCkPFJ8uh3M/sXa9TX4BO3JUDUjGmjbI0pSCinBlSy9huVHkjjSG2pqn8r/WunnomwQt26ZN5dtzf6YMzv2dj+GObr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jdXgvX7I; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e2da00185dso2796728a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708401889; x=1709006689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjNAXhtqcq0OJbE00M8kzJyMouse+2xlykONtccgn1M=;
        b=jdXgvX7IVTrv2zueYDnFW7AhKs/AAg837pAMCb9CGkGF0h9AMqnrdWsi9fhd3aj/0U
         YqhHvaMcYfw7DMISqcBf/jQwp3J/Ib185fvZcb0WGdl6AbjZDuQq1mtlTkoUCKPi4mgv
         faH9+hvUSZXhcToTj2udLqJQzo9f97xMyIRvWTMXr8Hgw5bUxT7X5QroegsZgvWfgwFG
         BH0I2vM0EmnJej07sXjjsCDOnVQtqInSv/QbIXuPkmDi30lVvrrAaZJ7xLvA+KEkTTD1
         /G2deGdQHNweBwIph3GWFNlpgeSOz3rRtpb+eqemXb+esRk2nxxihZKqozs5k4u5rgli
         /fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708401889; x=1709006689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjNAXhtqcq0OJbE00M8kzJyMouse+2xlykONtccgn1M=;
        b=vO+NTTY9KXIA9LT1p9QiHBz3T6iDmdUE8yZIJkGDY0rN1D9BJf6Ti18H8qOWNn0hcr
         AK1cVUxR6TbfJJsxxjqJYq04UkXNhRZFj2yri6ZQnUDJa9cqK//tndhPunNryLEowNO8
         90ygcMOA22dHm8a6F4Re8LeXS3Sn8POeFAlPr1ZKZ0OyJQwk7WZaixWNHCA5ioebSeT2
         ABM2WjogA5Q9TqvMk2Mky0da3QRdK4VERIAyS5lgTUvjPVvDmPAYrbjBNQ9iLFFh9R5b
         7RrcXjcNQqUUxXVCI6fSSmxUco0g/NTPJ/d/wwF4Is1dAM8x0Vieq5yGEb0PxawOkk9w
         tQIw==
X-Forwarded-Encrypted: i=1; AJvYcCXpSfU3FT3x6Gw1TtTKpilueDYanvc960DjHyzWHgpAUuxmsX7zpTD0pJCrudLSYNNALneHk59OPFHPSuUFHoYknbB2Afrzt2qw4c0W
X-Gm-Message-State: AOJu0YwcUlvelCfD8RVsGZJCtcj96j8quF/Q00xBk3VLlLrJZaeWXVd7
	fDALooTfRD7gR8pcIRwhAk8PYtztHzqzhdxxp/MFXtB7dTqATJXnoqtiaMy4dF8=
X-Google-Smtp-Source: AGHT+IGqbIi3dcKVEvmS79jnBDZhkymxCYUewjSajJgJfGj/gxvlqCjJlNdTmxFPxJrM8w9NtR3ytw==
X-Received: by 2002:a05:6358:8187:b0:17a:fa59:bb87 with SMTP id r7-20020a056358818700b0017afa59bb87mr14885552rwk.16.1708401888822;
        Mon, 19 Feb 2024 20:04:48 -0800 (PST)
Received: from [10.254.101.216] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id o9-20020a62f909000000b006e0814dbb3bsm5756211pfh.96.2024.02.19.20.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 20:04:48 -0800 (PST)
Message-ID: <9d8cf754-86ad-491f-9c3b-cca9efb2f5b2@bytedance.com>
Date: Tue, 20 Feb 2024 12:04:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
To: Chen Yu <yu.c.chen@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, aubrey.li@linux.intel.com,
 Tiwei Bie <tiwei.btw@antgroup.com>,
 Honglei Wang <wanghonglei@didichuxing.com>, Aaron Lu <aaron.lu@intel.com>
References: <202401301012.2ed95df0-oliver.sang@intel.com>
 <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
 <ZdNOb7fOLIoY5sgW@chenyu5-mobl2>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZdNOb7fOLIoY5sgW@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 8:49 PM, Chen Yu Wrote:
> 
> While looking at pick_eevdf(), I have a thought.
> Currently the sched entity is sorted by their deadline. During task
> pickup, the pick_eevdf() scans for an candidate sched entity with the
> smallest deadline. Meanwhile this candidate sched entity must also be
> eligible.
> 
> The scan is O(lgn) on average, and O(1) at best case. How about making the
> average scan even faster by sorting the sched entity not only by deadline,
> but also the eligibility? The idea is that, the eligible sched entity with
> smaller deadline is sorted at the front the tree. Otherwise, if the entity
> is not eligible, even if it has a smaller deadline, it should be sorted
> at the end of the tree.

Eligibility is dynamic due to the nature of weighted average vruntime.
IIUC if doing so like above, update_curr() should take the responsibility
to re-sort the tree which seems to be O(logN).

> 
> After the change, pick_eevdf() get the leftmost sched entity at O(1) on
> average. Besides, it is guaranteed to return non-NULL sched entity in
> pick_eevdf(), which prevents suspicious NULL pointer exception in pick_eevdf().

It is guaranteed when doing pick that the rbtree is non-NULL, and given
that rq lock is held, I don't think the bug is inside pick_eevdf().

> 
> For example, suppose there are two sched entities to be queued, se_a and se_b.
> Consider their eligibility and deadline, there are 6 combination:
> 
> 1. se_a is eligible, se_b is eligible, se_a.deadline < se_b.deadline
> 2. se_a is eligible, se_b is eligible, se_a.deadline >= se_b.deadline
> 3. se_a is eligible, se_b is not eligible
> 4. se_a is not eligible, se_b is eligible
> 5. se_a is not eligible, se_b is not eligible, se_a.deadline < se_b.deadline
> 6. se_a is not eligible, se_b is not eligible, se_a.deadline >= se_b.deadline
> 
> In scenario 1, 3, 5, sched_entity se_a should be sorted before se_b,
> so pick_eevdf() would pick se_a first.
> 
> When enqueuing a new sched entity, it is regarded as eligible if its
> vlag is positive. In theory later in pick_eevdf(), the eligibility
> of this sched entity should be re-checked via entity_eligible(). But
> consider if the sched entity is eliglble when enqueued, it is very
> likely the same sched entity remains eligible when pick_eevdf(), because
> the V keeps moving forward but the vruntime of this sched entity remain
> unchanged - the vlag could get larger.
> 
> Something like this untested:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..831043cc1432 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -551,11 +551,19 @@ static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
>   static inline bool entity_before(const struct sched_entity *a,
>   				 const struct sched_entity *b)
>   {
> -	/*
> -	 * Tiebreak on vruntime seems unnecessary since it can
> -	 * hardly happen.
> -	 */
> -	return (s64)(a->deadline - b->deadline) < 0;
> +	bool eli_a, eli_b;
> +
> +	eli_a = (a->vlag >= 0) ? true : false;
> +	eli_b = (b->vlag >= 0) ? true : false;
> +
> +	if ((eli_a && eli_b) || (!eli_a && !eli_b))
> +		/*
> +		 * Tiebreak on vruntime seems unnecessary since it can
> +		 * hardly happen.
> +		 */
> +		return (s64)(a->deadline - b->deadline) < 0;
> +
> +	return eli_a ? 1 : 0;
>   }
>   
>   static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
> @@ -877,10 +885,8 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
>    */
>   static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   {
> -	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
>   	struct sched_entity *se = __pick_first_entity(cfs_rq);
>   	struct sched_entity *curr = cfs_rq->curr;
> -	struct sched_entity *best = NULL;
>   
>   	/*
>   	 * We can safely skip eligibility check if there is only one entity
> @@ -899,45 +905,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
>   		return curr;
>   
> -	/* Pick the leftmost entity if it's eligible */
> -	if (se && entity_eligible(cfs_rq, se)) {
> -		best = se;
> -		goto found;
> -	}
> -
> -	/* Heap search for the EEVD entity */
> -	while (node) {
> -		struct rb_node *left = node->rb_left;
> -
> -		/*
> -		 * Eligible entities in left subtree are always better
> -		 * choices, since they have earlier deadlines.
> -		 */
> -		if (left && vruntime_eligible(cfs_rq,
> -					__node_2_se(left)->min_vruntime)) {
> -			node = left;
> -			continue;
> -		}
> -
> -		se = __node_2_se(node);
> -
> -		/*
> -		 * The left subtree either is empty or has no eligible
> -		 * entity, so check the current node since it is the one
> -		 * with earliest deadline that might be eligible.
> -		 */
> -		if (entity_eligible(cfs_rq, se)) {
> -			best = se;
> -			break;
> -		}
> -
> -		node = node->rb_right;
> -	}
> -found:
> -	if (!best || (curr && entity_before(curr, best)))
> -		best = curr;
> -
> -	return best;
> +	/* Pick the leftmost entity */
> +	return se;
>   }
>   
>   #ifdef CONFIG_SCHED_DEBUG

