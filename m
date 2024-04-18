Return-Path: <linux-kernel+bounces-150682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571DD8AA2F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B24A2810E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA017F394;
	Thu, 18 Apr 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fK4+rhQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49917736
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469202; cv=none; b=YGgYgPkDLl5YhLctVmWnb5o86UbsfQ8peZpqaFxKvtfL1pvvPeDqXp54l3ULLLkrdPR30BNkeRzc4QFhMHKybZtwrl+K+NSb7JxpbTPtcep3ndMx928hMNwR0O9FK28Ee/HlGvAqkFx3vzxUf0wbxA54wCBrs0m2vn7ov0cSRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469202; c=relaxed/simple;
	bh=c+2Am6FmwvmgOAIMm5qyWEX2cWFI5nJZcTTExzVFlr4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f9BFs2Q2tUgzBFnbJGd55FMdEJo9uv7NL/Ewidgi2+NeZuOvHj4kCaNsKLhod2kYpt3BpBFkZeRC5DvqbMUuqdjV6UyJZSFt1oC3tRINYTTHUIXADBZ6WsbuAXqOFomPcsE0DKzTglY58tMiR9zewfYg4sHmVL7YSMjUpod3tCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fK4+rhQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D52C113CC;
	Thu, 18 Apr 2024 19:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713469201;
	bh=c+2Am6FmwvmgOAIMm5qyWEX2cWFI5nJZcTTExzVFlr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fK4+rhQGDmnzaFkK6/D0dn6YdSRYFho6z8svfL2L9PlTAebnkFW27qjR3LaFGDOcd
	 xSS3Bymo7Z4k6IWpZHM+Lkh1fNZP27YvcVyRiAXpOnRKmWDVE8bk5Rb4iRrQzO9ah4
	 JvpvjVmqvf54AgJJyMRvxmJVSvBHG2SIaWl0zbj8=
Date: Thu, 18 Apr 2024 12:40:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <dennisszhou@gmail.com>, <shakeelb@google.com>, <jack@suse.cz>,
 <surenb@google.com>, <kent.overstreet@linux.dev>, <mhocko@suse.cz>,
 <vbabka@suse.cz>, <yuzhao@google.com>, <yu.ma@intel.com>,
 <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [RFC PATCH v2 1/2] percpu_counter: introduce atomic mode for
 percpu_counter
Message-Id: <20240418124000.ce4606dad982d7f31fc0d117@linux-foundation.org>
In-Reply-To: <20240418142008.2775308-2-zhangpeng362@huawei.com>
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
	<20240418142008.2775308-2-zhangpeng362@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 22:20:07 +0800 Peng Zhang <zhangpeng362@huawei.com> wrote:

> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Depending on whether counters is NULL, we can support two modes:
> atomic mode and perpcu mode. We implement both modes by grouping
> the s64 count and atomic64_t count_atomic in a union. At the same time,
> we create the interface for adding and reading in atomic mode and for
> switching atomic mode to percpu mode.
> 

I think it would be better if we had a detailed code comment in an
appropriate place which fully describes the tradeoffs here.  Tell
people when they would benefit from using one mode versus the other.


> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -153,7 +153,7 @@ EXPORT_SYMBOL(__percpu_counter_sum);
>  
>  int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
>  			       gfp_t gfp, u32 nr_counters,
> -			       struct lock_class_key *key)
> +			       struct lock_class_key *key, bool switch_mode)
>  {
>  	unsigned long flags __maybe_unused;
>  	size_t counter_size;
> @@ -174,7 +174,8 @@ int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
>  #ifdef CONFIG_HOTPLUG_CPU
>  		INIT_LIST_HEAD(&fbc[i].list);
>  #endif
> -		fbc[i].count = amount;
> +		if (likely(!switch_mode))
> +			fbc[i].count = amount;
>  		fbc[i].counters = (void *)counters + (i * counter_size);
>  
>  		debug_percpu_counter_activate(&fbc[i]);
> @@ -357,6 +358,32 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
>  	return good;
>  }
>  
> +/*
> + * percpu_counter_switch_to_pcpu_many: Converts struct percpu_counters from
> + * atomic mode to percpu mode.

Describe what happens if that GFP_ATOMIC allocation fails.  We remain
in atomic mode, yes?

> + */
> +int percpu_counter_switch_to_pcpu_many(struct percpu_counter *fbc,
> +				       u32 nr_counters)
> +{
> +	static struct lock_class_key __key;
> +	unsigned long flags;
> +	bool ret = 0;
> +
> +	if (percpu_counter_initialized(fbc))
> +		return 0;
> +
> +	preempt_disable();
> +	local_irq_save(flags);

Do we need both?  Does local_irq_save() always disable preemption? 
This might not be the case for RT kernels, I always forget.

> +	if (likely(!percpu_counter_initialized(fbc)))
> +		ret = __percpu_counter_init_many(fbc, 0,
> +					GFP_ATOMIC|__GFP_NOWARN|__GFP_ZERO,
> +					nr_counters, &__key, true);
> +	local_irq_restore(flags);
> +	preempt_enable();
> +
> +	return ret;
> +}
> +

Why is there no API for switching back to atomic mode?


