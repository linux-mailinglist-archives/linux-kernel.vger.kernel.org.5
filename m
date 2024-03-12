Return-Path: <linux-kernel+bounces-99889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD55A878ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7974C281F25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2EC56B86;
	Tue, 12 Mar 2024 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9CDIArp"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C235676F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224483; cv=none; b=h/6D7q1eg+RZqHatUoDHufylWbvdtFHHtya5RHlQw2UPYBLl4c19SqtpLzV150l6/l+tFTde+QlXeJ5pe8NqtMoAN7kvpmpidARInpwsX14ZapVfAoe+9TnYkWrZKkK9b9Ki/SPwtm7Sd/mPOB5bNIqOKCVtAOH1uEg1JuCtSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224483; c=relaxed/simple;
	bh=957+m0lXURZKTwRtIVJ3mpW+Gp132FVq0fzY3Svy5gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8q/84fb8aJLSpoggeXzHkTi8rDOX3p+9cjde2YLj4Lz/+Ws3pTLTyhmujv8+md6UuLKkeqIAGrVN7vQ0kOQcp4WttHMoOsnKgbOMMk8Fau0WQRtWnFG/GWs4O5zcD+ClmuKxAxhO9nlJ9BLh6pn9ViTBp/xANh41wcLe8D9GjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f9CDIArp; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd749f4e-2086-4ef9-80f7-b0984350c195@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710224477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kq/kPt1JxT4dVExlnhMNYe5OTKfRBTQE/YRVss6FppQ=;
	b=f9CDIArpzDnDB5LXsCrK+Z8ZI/iwYX/JKwvhmOJb5NOo+JW/dnxsMBSLo3y5qBraTpNZ14
	awrKJs4WXqJk0meccldW2nkDG76G/iUzbfXAKONDPIBo7e8GlxTHQxq7wevJ8niJHvm12+
	wsBxfNbPdZbECLcMa3E1ZD1bxglGXYI=
Date: Tue, 12 Mar 2024 14:21:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/slub: Simplify get_partial_node()
Content-Language: en-US
To: sxwjean@me.com, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Xiongwei Song <xiongwei.song@windriver.com>
References: <20240311132720.37741-1-sxwjean@me.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240311132720.37741-1-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/11 21:27, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> Remove the check of !kmem_cache_has_cpu_partial() because it is always
> false, we've known this by calling kmem_cache_debug() before calling
> remove_partial(), so we can remove the check.

This is correct.

> 
> Meanwhile, redo filling cpu partial and add comment to improve the
> readability.
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>  mm/slub.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a3ab096c38c0..62388f2a0ac7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2620,19 +2620,21 @@ static struct slab *get_partial_node(struct kmem_cache *s,
>  		if (!partial) {
>  			partial = slab;
>  			stat(s, ALLOC_FROM_PARTIAL);
> -		} else {
> +
> +			/* Fill cpu partial if needed from next iteration, or break */
> +			if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL))
> +				continue;
> +			else
> +				break;
> +		}
> +
> +		if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL)) {

But this won't work since "s->cpu_partial_slabs" is defined under CONFIG_SLUB_CPU_PARTIAL,
you would get compiler error if building without CONFIG_SLUB_CPU_PARTIAL.

Thanks.

>  			put_cpu_partial(s, slab, 0);
>  			stat(s, CPU_PARTIAL_NODE);
> -			partial_slabs++;
> -		}
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -		if (!kmem_cache_has_cpu_partial(s)
> -			|| partial_slabs > s->cpu_partial_slabs / 2)
> -			break;
> -#else
> -		break;
> -#endif
>  
> +			if (++partial_slabs > s->cpu_partial_slabs/2)
> +				break;
> +		}
>  	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
>  	return partial;

