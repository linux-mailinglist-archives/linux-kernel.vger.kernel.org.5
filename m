Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599718055E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbjLEN1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjLEN1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:27:30 -0500
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B918A18C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:27:35 -0800 (PST)
Message-ID: <44421a37-4343-46d0-9e5c-17c2cd038cf2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701782853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSQSwpmn7M/CrcHDOooBYuyEVhVwNmvfJ9+Pn01yWSY=;
        b=FQUkcXNPzenZDQFP3uDNRiJagjcqB6wRxMxCMUudY3xEcp7t0F5y0sq8ygb37HMilKHsT7
        wCokJIR0Qe5WyJaR7p1ixr/kPXSlKnsUHrdNFITfIFuj5+OidhdweTLzaoECxwtrgSIkYm
        E+c7Xi5sOv4EUj01jKQJ94iF9id1whs=
Date:   Tue, 5 Dec 2023 21:27:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] mm/slub: free KFENCE objects in slab_free_hook()
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
 <20231204-slub-cleanup-hooks-v1-4-88b65f7cd9d5@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20231204-slub-cleanup-hooks-v1-4-88b65f7cd9d5@suse.cz>
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
> When freeing an object that was allocated from KFENCE, we do that in the
> slowpath __slab_free(), relying on the fact that KFENCE "slab" cannot be
> the cpu slab, so the fastpath has to fallback to the slowpath.
> 
> This optimization doesn't help much though, because is_kfence_address()
> is checked earlier anyway during the free hook processing or detached
> freelist building. Thus we can simplify the code by making the
> slab_free_hook() free the KFENCE object immediately, similarly to KASAN
> quarantine.
> 
> In slab_free_hook() we can place kfence_free() above init processing, as
> callers have been making sure to set init to false for KFENCE objects.
> This simplifies slab_free(). This places it also above kasan_slab_free()
> which is ok as that skips KFENCE objects anyway.
> 
> While at it also determine the init value in slab_free_freelist_hook()
> outside of the loop.
> 
> This change will also make introducing per cpu array caches easier.
> 
> Tested-by: Marco Elver <elver@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ed2fa92e914c..e38c2b712f6c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2039,7 +2039,7 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
>   * production configuration these hooks all should produce no code at all.
>   *
>   * Returns true if freeing of the object can proceed, false if its reuse
> - * was delayed by KASAN quarantine.
> + * was delayed by KASAN quarantine, or it was returned to KFENCE.
>   */
>  static __always_inline
>  bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
> @@ -2057,6 +2057,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
>  		__kcsan_check_access(x, s->object_size,
>  				     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
>  
> +	if (kfence_free(kasan_reset_tag(x)))

I'm wondering if "kasan_reset_tag()" is needed here?

The patch looks good to me!

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.

> +		return false;
> +
>  	/*
>  	 * As memory initialization might be integrated into KASAN,
>  	 * kasan_slab_free and initialization memset's must be
> @@ -2086,23 +2089,25 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  	void *object;
>  	void *next = *head;
>  	void *old_tail = *tail;
> +	bool init;
>  
>  	if (is_kfence_address(next)) {
>  		slab_free_hook(s, next, false);
> -		return true;
> +		return false;
>  	}
>  
>  	/* Head and tail of the reconstructed freelist */
>  	*head = NULL;
>  	*tail = NULL;
>  
> +	init = slab_want_init_on_free(s);
> +
>  	do {
>  		object = next;
>  		next = get_freepointer(s, object);
>  
>  		/* If object's reuse doesn't have to be delayed */
> -		if (likely(slab_free_hook(s, object,
> -					  slab_want_init_on_free(s)))) {
> +		if (likely(slab_free_hook(s, object, init))) {
>  			/* Move object to the new freelist */
>  			set_freepointer(s, object, *head);
>  			*head = object;
> @@ -4103,9 +4108,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  
>  	stat(s, FREE_SLOWPATH);
>  
> -	if (kfence_free(head))
> -		return;
> -
>  	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
>  		free_to_partial_list(s, slab, head, tail, cnt, addr);
>  		return;
> @@ -4290,13 +4292,9 @@ static __fastpath_inline
>  void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	       unsigned long addr)
>  {
> -	bool init;
> -
>  	memcg_slab_free_hook(s, slab, &object, 1);
>  
> -	init = !is_kfence_address(object) && slab_want_init_on_free(s);
> -
> -	if (likely(slab_free_hook(s, object, init)))
> +	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
>  		do_slab_free(s, slab, object, object, 1, addr);
>  }
>  
> 
