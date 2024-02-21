Return-Path: <linux-kernel+bounces-75302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D934385E61C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC671F24326
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53958562A;
	Wed, 21 Feb 2024 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z+qxW5XT"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7141097B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540455; cv=none; b=cXpWTsSaen4Mb7PJAK63qPj8f+ilVP2i+HLUwRqKNkMl58+dv61bi0af+a91UgL9dUEXMl+ulLK6DaWKjBDKzC6jZSf5ZofolkYHxuGKY2KVGJWkvHUcYWnw76GWOcRxw+oH5u66a4ZdbLASA0O/vDqveeJf+CFLPDVbBUz7+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540455; c=relaxed/simple;
	bh=LgjqrzXO+tkiNjtq7bVcYwIGi3coMgZGbOl9VQtJOO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpxKGVq3l9Tnke1J696BmJWkw8lAHvcJWaafyY4nvHtP0FGlCGp8yL9DjfoSDteAXPQjkrqEawDfRGl9G7ldbvUUwF3QbNUa3O+hu66Lk8OYat521ddIba3C8g79xgIhThfz0ospqZVCA7k88AK+6HF/x/21VIELsMCaBMGySNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z+qxW5XT; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Feb 2024 10:33:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708540450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZfYq+o4HUAg6zk4DYlNdaruLQWY+JIsadSfBudqmUQ=;
	b=Z+qxW5XTS5ZBzmp50/Rw0CQto8fpUGAvw1L9hMrCBlgRWfmWCZL2QMyMRJBhhvUXyZrCZQ
	7I1L3xEY0CBBjHvs/Nkvq6QoC4K4YDSewb5cbAQFUxNPOxqyAUBKyLOz9LQ0CPf5K9diqz
	sLS+cybCN1xIPho6etnzuEUulDq//M0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 2/3] mm, slab: use an enum to define SLAB_ cache creation
 flags
Message-ID: <ZdZCDEFX4_UuHSWR@P9FQF9L96D.corp.robot.car>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 20, 2024 at 05:58:26PM +0100, Vlastimil Babka wrote:
> The values of SLAB_ cache creation flagsare defined by hand, which is
> tedious and error-prone. Use an enum to assign the bit number and a
> __SF_BIT() macro to #define the final flags.
> 
> This renumbers the flag values, which is OK as they are only used
> internally.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h | 81 ++++++++++++++++++++++++++++++++++++++--------------
>  mm/slub.c            |  6 ++--
>  2 files changed, 63 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 6252f44115c2..f893a132dd5a 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -21,29 +21,68 @@
>  #include <linux/cleanup.h>
>  #include <linux/hash.h>
>  
> +enum _slab_flag_bits {
> +	_SLAB_CONSISTENCY_CHECKS,
> +	_SLAB_RED_ZONE,
> +	_SLAB_POISON,
> +	_SLAB_KMALLOC,
> +	_SLAB_HWCACHE_ALIGN,
> +	_SLAB_CACHE_DMA,
> +	_SLAB_CACHE_DMA32,
> +	_SLAB_STORE_USER,
> +	_SLAB_PANIC,
> +	_SLAB_TYPESAFE_BY_RCU,
> +	_SLAB_TRACE,
> +#ifdef CONFIG_DEBUG_OBJECTS
> +	_SLAB_DEBUG_OBJECTS,
> +#endif
> +	_SLAB_NOLEAKTRACE,
> +	_SLAB_NO_MERGE,
> +#ifdef CONFIG_FAILSLAB
> +	_SLAB_FAILSLAB,
> +#endif
> +#ifdef CONFIG_MEMCG_KMEM
> +	_SLAB_ACCOUNT,
> +#endif
> +#ifdef CONFIG_KASAN_GENERIC
> +	_SLAB_KASAN,
> +#endif
> +	_SLAB_NO_USER_FLAGS,
> +#ifdef CONFIG_KFENCE
> +	_SLAB_SKIP_KFENCE,
> +#endif
> +#ifndef CONFIG_SLUB_TINY
> +	_SLAB_RECLAIM_ACCOUNT,
> +#endif
> +	_SLAB_OBJECT_POISON,
> +	_SLAB_CMPXCHG_DOUBLE,
> +	_SLAB_FLAGS_LAST_BIT
> +};
> +
> +#define __SF_BIT(nr)	((slab_flags_t __force)(1U << (nr)))

I'd rename it to (__)SLAB_FLAG_BIT(), as SF is a bit cryptic, but not a strong
preference. Otherwise looks really good to me, nice cleanup.

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

