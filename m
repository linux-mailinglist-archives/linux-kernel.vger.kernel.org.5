Return-Path: <linux-kernel+bounces-77705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFF386093C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ADF286616
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE810A0F;
	Fri, 23 Feb 2024 03:12:17 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D303B10A01
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657936; cv=none; b=UCue/DJQz0K9Iy50P6c2tUuLSitMEeAW8T/8ej7pyUJ1hDfmqprTUaKFB+yYOJB/vXqAR6nJ5Nl78Ti3c1B2nr+uFc/jd/xvZvqzlZVMbwzHrnKqLMc10Npw0cl5dby+P4E+Lvwwg9XQgPhr6yae5tr7onReH+w+qFhwPHKDtFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657936; c=relaxed/simple;
	bh=IfE0Mw15HNypz38gIE6amDvs+YXN4zqJPoCZprGys4c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ji17z+6ODoc9o8LG51wngk2U8B/XCmmcftITpvq8Dz33RLCXtTIqJ1rJWcdQ+XuTpswbozSaqxNSbztnzPTx80kjq6DCjbyOA5bZEY/58lQznsBJh88Lz0RkKFJlVLA/uC5Jn72w+pTYVY9e7GW3mrrw5KeC9hzeDxJqUv/r7EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 155E640AA8; Thu, 22 Feb 2024 19:12:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 14C8D40788;
	Thu, 22 Feb 2024 19:12:14 -0800 (PST)
Date: Thu, 22 Feb 2024 19:12:14 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
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
In-Reply-To: <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
Message-ID: <8bc31ec7-5d6e-b4c0-9d6e-42849673f35f@linux.com>
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz> <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 20 Feb 2024, Vlastimil Babka wrote:

> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..a93c5a17cbbb 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -306,13 +306,13 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
>
> /* Internal SLUB flags */
> /* Poison object */
> -#define __OBJECT_POISON		((slab_flags_t __force)0x80000000U)
> +#define __OBJECT_POISON		__SF_BIT(_SLAB_OBJECT_POISON)
> /* Use cmpxchg_double */
>
> #ifdef system_has_freelist_aba
> -#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0x40000000U)
> +#define __CMPXCHG_DOUBLE	__SF_BIT(_SLAB_CMPXCHG_DOUBLE)
> #else
> -#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0U)
> +#define __CMPXCHG_DOUBLE	0
> #endif

Maybe its good to put these internal flags together with the other flags. 
After all there is no other slab allocator available anymore and having 
them all together avoids confusion.


