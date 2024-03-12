Return-Path: <linux-kernel+bounces-100430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B20879772
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2979A1F23755
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0D7C0A5;
	Tue, 12 Mar 2024 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rigdOnXH"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6A7A71D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257009; cv=none; b=p1KVVhHIoQLzx06rUf2ih/9docL6/0ZyJjVKUYeScjLKjNcX7S5TE/Tv64ETl8hgCxoOHoWrgkZRUYlT/FLrg5zOH+6Kj1qCqEVxr+rkEl3TbsWTt7mLvZy+euUpNPerEvmBuCE5b44PiGwBgF71InvS9kBtSQHM8yVkbvj7YSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257009; c=relaxed/simple;
	bh=NKeq8I2ypWn1MTZg/ytCtrtFUFYIsegN3wqrzMQ/leY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvEQgDwfEmAR7aB2D1RN7KSI2637dBQ85Kbgm0aS0LrCbLEeducHYkMXqRFt2nW/+XERzOvyJLp0JZzim1fAOmrnevB9XUzmZ/KxF7Q1qXPWX4hhMoOJmM5PrYmg6ba9a/eSi+XPUoWISYY1PvjBUlAqj9b5e6Bhc0RqkrQF5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rigdOnXH; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <38beee7c-aceb-4d59-ac79-e7e412a01588@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710257004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrI0LmH16nBL8Fs5qJACoyJ/98w4jqaFfRvlIhPxmt4=;
	b=rigdOnXH1zLZxxRdzAfFhhFARZneuylNq3K5BJxQBbvup7nGm3dqF0e7mDM7zar+2allmS
	cj0WJXZKJUeVM8gT4oi6jSTgGsS4eHbHUr2R7xzt8rQQ1HyGcrstbzXmn07LinKmvJaaYs
	4mVpgLQGR5/NbNTafw24wjDJevg7MZs=
Date: Tue, 12 Mar 2024 23:22:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm/slub: Simplify get_partial_node()
Content-Language: en-US
To: sxwjean@me.com, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Xiongwei Song <xiongwei.song@windriver.com>
References: <20240312140532.64124-1-sxwjean@me.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240312140532.64124-1-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/3/12 22:05, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> Remove the check of !kmem_cache_has_cpu_partial() because it is always
> false, we've known this by calling kmem_cache_debug() before calling
> remove_partial(), so we can remove the check.
> 
> Meanwhile, redo filling cpu partial and add comment to improve the
> readability.
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
> Changes in v2:
>  - Use "#if IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL)" to instead 
>    "if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL))" to fix build error.
>    (Thanks Chengming Zhou)
>  - Add __maybe_unused for partial_slabs to prevent compiler warning.
> 
> v1: 
>  https://lore.kernel.org/linux-kernel/20240311132720.37741-1-sxwjean@me.com/T/
> ---
>  mm/slub.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a3ab096c38c0..ab526960ee5b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2588,7 +2588,7 @@ static struct slab *get_partial_node(struct kmem_cache *s,
>  {
>  	struct slab *slab, *slab2, *partial = NULL;
>  	unsigned long flags;
> -	unsigned int partial_slabs = 0;
> +	unsigned int __maybe_unused partial_slabs = 0;
>  
>  	/*
>  	 * Racy check. If we mistakenly see no partial slabs then we
> @@ -2620,19 +2620,21 @@ static struct slab *get_partial_node(struct kmem_cache *s,
>  		if (!partial) {
>  			partial = slab;
>  			stat(s, ALLOC_FROM_PARTIAL);
> -		} else {
> -			put_cpu_partial(s, slab, 0);
> -			stat(s, CPU_PARTIAL_NODE);
> -			partial_slabs++;
> +
> +			/* Fill cpu partial if needed from next iteration, or break */
> +			if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL))
> +				continue;
> +			else
> +				break;
>  		}
> -#ifdef CONFIG_SLUB_CPU_PARTIAL
> -		if (!kmem_cache_has_cpu_partial(s)
> -			|| partial_slabs > s->cpu_partial_slabs / 2)
> +
> +#if IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL)

Hmm, these two CONFIG_SLUB_CPU_PARTIAL look verbose to me :(

How about using just one, maybe like this?

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..a018c715b648 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2620,19 +2620,16 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 		if (!partial) {
 			partial = slab;
 			stat(s, ALLOC_FROM_PARTIAL);
+#ifdef CONFIG_SLUB_CPU_PARTIAL
 		} else {
 			put_cpu_partial(s, slab, 0);
 			stat(s, CPU_PARTIAL_NODE);
-			partial_slabs++;
-		}
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-		if (!kmem_cache_has_cpu_partial(s)
-			|| partial_slabs > s->cpu_partial_slabs / 2)
-			break;
+			if (++partial_slabs > s->cpu_partial_slabs / 2)
+				break;
 #else
-		break;
+			break;
 #endif
-
+		}
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return partial;


> +		put_cpu_partial(s, slab, 0);
> +		stat(s, CPU_PARTIAL_NODE);
> +
> +		if (++partial_slabs > s->cpu_partial_slabs/2)
>  			break;
> -#else
> -		break;
>  #endif
> -
>  	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
>  	return partial;

