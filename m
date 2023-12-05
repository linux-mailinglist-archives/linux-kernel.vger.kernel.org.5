Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F33804BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbjLEIMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346735AbjLEILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:11:06 -0500
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [IPv6:2001:41d0:203:375::b0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D707187
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:11:11 -0800 (PST)
Message-ID: <c9867365-3a44-4699-a2d3-717bae0d4853@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701763870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7tcXxVB37+e74YIJ/SoIf8Zq3/8qsP6opp7sTACB/E=;
        b=JtHkQHyeKWUXLqCtj1D8woxmlUkmgsj3Um+0N3QTI3d/nMPguMeFOjwjbSAInQkyo3dw0D
        7ZF4YwUoaQ7Wm4u+Abva2IoSi7um8PSW/xk+rytL9QW97nhEQrts6YnggQOIkjGr9NtkGO
        AkrlZet2qEakUYb2N7eODaod68dWZW8=
Date:   Tue, 5 Dec 2023 16:11:03 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] mm/slub: fix bulk alloc and free stats
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20231204-slub-cleanup-hooks-v1-0-88b65f7cd9d5@suse.cz>
 <20231204-slub-cleanup-hooks-v1-1-88b65f7cd9d5@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20231204-slub-cleanup-hooks-v1-1-88b65f7cd9d5@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/5 03:34, Vlastimil Babka wrote:
> The SLUB sysfs stats enabled CONFIG_SLUB_STATS have two deficiencies
> identified wrt bulk alloc/free operations:
> 
> - Bulk allocations from cpu freelist are not counted. Add the
>   ALLOC_FASTPATH counter there.
> 
> - Bulk fastpath freeing will count a list of multiple objects with a
>   single FREE_FASTPATH inc. Add a stat_add() variant to count them all.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Looks good to me!

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

> ---
>  mm/slub.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3f8b95757106..d7b0ca6012e0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -396,6 +396,14 @@ static inline void stat(const struct kmem_cache *s, enum stat_item si)
>  #endif
>  }
>  
> +static inline
> +void stat_add(const struct kmem_cache *s, enum stat_item si, int v)
> +{
> +#ifdef CONFIG_SLUB_STATS
> +	raw_cpu_add(s->cpu_slab->stat[si], v);
> +#endif
> +}
> +
>  /*
>   * The slab lists for all objects.
>   */
> @@ -4268,7 +4276,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>  
>  		local_unlock(&s->cpu_slab->lock);
>  	}
> -	stat(s, FREE_FASTPATH);
> +	stat_add(s, FREE_FASTPATH, cnt);
>  }
>  #else /* CONFIG_SLUB_TINY */
>  static void do_slab_free(struct kmem_cache *s,
> @@ -4545,6 +4553,7 @@ static inline int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
>  		c->freelist = get_freepointer(s, object);
>  		p[i] = object;
>  		maybe_wipe_obj_freeptr(s, p[i]);
> +		stat(s, ALLOC_FASTPATH);
>  	}
>  	c->tid = next_tid(c->tid);
>  	local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
> 
