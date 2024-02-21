Return-Path: <linux-kernel+bounces-74194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4268285D0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE3C28484F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D63A26E;
	Wed, 21 Feb 2024 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Con9hWh/"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299A3C1D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499538; cv=none; b=k+aCmldRQTSAR9K7eYKTrXz3rx7ktX1gOC+nqYCQkRgMmI5qPSXfwYcqyjwqehdqI38hguL/1RZROhAxgaYujRZEQaItzmRyzHW6ieUFBhBvbOqzHivUjiNcAqWH+XNScK28tA3/eB4MOOPIpU9h99UAo5/WvHyCIDuJBE3mb94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499538; c=relaxed/simple;
	bh=FrU9cdCMGIf9qG80/qS7H4d6s+orqSzB9ZJ5kxcAPNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nv2m9sLjTlJ5szdtevEqehXmak6HLIEosaANed1fdtA928r+/MrwI2BV9HaN7KuLbjpqg7h49qQRUVjxjkFrKYI4Qpk+6OE4y4GIMXqHimjpSwen7WtAVBSgeaLibMnFS3s+cmPsUwzBiaT1RMkmLkFTpCWpkVb6pq6c86V3kI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Con9hWh/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f75362d9-eea1-443e-8997-45a7b98b7915@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708499529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSnP/0YdPJWcrqeadRLJ8c8YxbEnoLRUfscJ82NzOdg=;
	b=Con9hWh/qgjDQEXO+YEOr5FjUtVBPnumYSQTLumrCqVYXjQm/Ebok6lUO0t/I6ZhVZnaag
	CWaLu905U7Jrv9AR4XCR2JpU8eUzKGUZB7ttzDkvJMOVCIx/geOWiWsyqF8q52gL8LNGrC
	r2a6Dzgmpy6lJIS0WjUPJX8XDFYqSag=
Date: Wed, 21 Feb 2024 15:11:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] mm, slab: deprecate SLAB_MEM_SPREAD flag
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Zheng Yejian <zhengyejian1@huawei.com>,
 Xiongwei Song <xiongwei.song@windriver.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 Steven Rostedt <rostedt@goodmis.org>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-1-e657e373944a@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240220-slab-cleanup-flags-v1-1-e657e373944a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/21 00:58, Vlastimil Babka wrote:
> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed.  SLUB instead relies on the page allocator's NUMA policies.
> Change the flag's value to 0 to free up the value it had, and mark it
> for full removal once all users are gone.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20240131172027.10f64405@gandalf.local.home/
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks!

> ---
>  include/linux/slab.h | 5 +++--
>  mm/slab.h            | 1 -
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index b5f5ee8308d0..6252f44115c2 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -96,8 +96,6 @@
>   */
>  /* Defer freeing slabs to RCU */
>  #define SLAB_TYPESAFE_BY_RCU	((slab_flags_t __force)0x00080000U)
> -/* Spread some memory over cpuset */
> -#define SLAB_MEM_SPREAD		((slab_flags_t __force)0x00100000U)
>  /* Trace allocations and frees */
>  #define SLAB_TRACE		((slab_flags_t __force)0x00200000U)
>  
> @@ -164,6 +162,9 @@
>  #endif
>  #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
>  
> +/* Obsolete unused flag, to be removed */
> +#define SLAB_MEM_SPREAD		0
> +
>  /*
>   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>   *
> diff --git a/mm/slab.h b/mm/slab.h
> index 54deeb0428c6..f4534eefb35d 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -469,7 +469,6 @@ static inline bool is_kmalloc_cache(struct kmem_cache *s)
>  			      SLAB_STORE_USER | \
>  			      SLAB_TRACE | \
>  			      SLAB_CONSISTENCY_CHECKS | \
> -			      SLAB_MEM_SPREAD | \
>  			      SLAB_NOLEAKTRACE | \
>  			      SLAB_RECLAIM_ACCOUNT | \
>  			      SLAB_TEMPORARY | \
> 

