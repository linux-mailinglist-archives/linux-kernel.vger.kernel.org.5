Return-Path: <linux-kernel+bounces-159188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43788B2A71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31C72815D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C511553BD;
	Thu, 25 Apr 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fwaSUXof"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F915534E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079391; cv=none; b=JSwX7Kc/v1/cII0H0Wxtqg3lwEuDFOnUwp1+UbtMu5qmt7CxbVglxM0VCQrTNHNN+KggMZpk7CiCOvUIjpvxDIqnWYk4AqeUb1FPoBfUxpSxB7X/aQCX7owxdvb8DxUNPm8cDRoI9r52Pragc6veACulE81uBRHGbSP5YobGSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079391; c=relaxed/simple;
	bh=hwNZS76oWiIdn5n+tWivvlFReYO7EbPFLIBPF+1gTq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5I2dQhoqnn3JMplqaJ3FU+u4vQnTZ2YDwEUl9K8yLKBgb+8hFeEf5Qx/Clnj7PFWrQgfYtcRPD2ci2sniG+PydnsHkX3Cg4n72tJbjcQUSkUQlTck/8v/be2K4/jXo50nZ+HegE0Q7nTKosUnZjNXqpbTAh/mGi1y+N1dhvElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fwaSUXof; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Apr 2024 17:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714079387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BQT9j7sLQeMY/YB9pvp7PU2WrrBXiYonNuoxwRbYFE=;
	b=fwaSUXof6osVkLcezsvOOJo5sLF5ZSkRYS1kXifZw1N2Vj/4pQtg/ZlD5zdSf1ljvSMJep
	OdgD2AYS62LPpd7OvgZ0L0m4jlDBwGfoPtkapcid80whwL/WAsVsILYrNJzMMk943mhMza
	Y3FdBiDc37FhEeTKP2s+gBH5ZetXbNg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Avoid recursive loop with kmemleak
Message-ID: <ebc6pcoq4cle3ge526ch6q5hz2vvphmgwu2yqdveypjm24pa3b@cwsggjnoepaq>
References: <20240425205516.work.220-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425205516.work.220-kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 25, 2024 at 01:55:23PM -0700, Kees Cook wrote:
> The system will immediate fill up stack and crash when both
> CONFIG_DEBUG_KMEMLEAK and CONFIG_MEM_ALLOC_PROFILING are enabled.
> Avoid allocation tagging of kmemleak caches, otherwise recursive
> allocation tracking occurs.
> 
> Fixes: 279bb991b4d9 ("mm/slab: add allocation accounting into slab allocation and free paths")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: linux-mm@kvack.org
> ---
>  mm/kmemleak.c | 4 ++--
>  mm/slub.c     | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index c55c2cbb6837..fdcf01f62202 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -463,7 +463,7 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
>  
>  	/* try the slab allocator first */
>  	if (object_cache) {
> -		object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> +		object = kmem_cache_alloc_noprof(object_cache, gfp_kmemleak_mask(gfp));

What do these get accounted to, or does this now pop a warning with
CONFIG_MEM_ALLOC_PROFILING_DEBUG?

>  		if (object)
>  			return object;
>  	}
> @@ -947,7 +947,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
>  	untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);
>  
>  	if (scan_area_cache)
> -		area = kmem_cache_alloc(scan_area_cache, gfp_kmemleak_mask(gfp));
> +		area = kmem_cache_alloc_noprof(scan_area_cache, gfp_kmemleak_mask(gfp));
>  
>  	raw_spin_lock_irqsave(&object->lock, flags);
>  	if (!area) {
> diff --git a/mm/slub.c b/mm/slub.c
> index a94a0507e19c..9ae032ed17ed 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2016,7 +2016,7 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>  	if (!p)
>  		return NULL;
>  
> -	if (s->flags & SLAB_NO_OBJ_EXT)
> +	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
>  		return NULL;
>  
>  	if (flags & __GFP_NO_OBJ_EXT)
> -- 
> 2.34.1
> 

