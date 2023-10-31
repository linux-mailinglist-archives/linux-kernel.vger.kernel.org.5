Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D2D7DCB8A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344016AbjJaLPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbjJaLPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:15:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F62C2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:15:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 57D981F38C;
        Tue, 31 Oct 2023 11:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698750916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+pxhu6U2beIsQvJMh0s4+kGPzPKAsf92Ad0drGIvEM=;
        b=RFcFgEZc1muAp735xAYMf9tuVAAm3vlyqM8pcSmaKShMF1A8odZZPWYIYmQlkpz73GVjpO
        CaXfrinpkH6aZ8BVINJZYqDe5/8aOneqdVpJLeOCHF8hBJMPZLts/Q8Nl9q0306Iwyh5ZJ
        yrcpwt5Ux+RyNS7bpXuZPkNNJcZsheI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698750916;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+pxhu6U2beIsQvJMh0s4+kGPzPKAsf92Ad0drGIvEM=;
        b=KcbYqta+bOeMlBkC/yv46SXoHM0N8uRn5oxK1dWQbzqEipseIwg4oeNWwhXO6lEKv3uyrH
        a5UpsIP0aOYnZ3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28BCD138EF;
        Tue, 31 Oct 2023 11:15:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 15cHCcThQGVTIgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 31 Oct 2023 11:15:16 +0000
Message-ID: <9db65a8d-9f0d-e8ab-55e4-4197dfc54032@suse.cz>
Date:   Tue, 31 Oct 2023 12:15:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v3 7/7] slub: Optimize deactivate_slab()
Content-Language: en-US
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <20231024093345.3676493-8-chengming.zhou@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231024093345.3676493-8-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 11:33, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Since the introduce of unfrozen slabs on cpu partial list, we don't
> need to synchronize the slab frozen state under the node list_lock.
> 
> The caller of deactivate_slab() and the caller of __slab_free() won't
> manipulate the slab list concurrently.
> 
> So we can get node list_lock in the last stage if we really need to
> manipulate the slab list in this path.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Nice simplification!

> ---
>  mm/slub.c | 70 ++++++++++++++++++++-----------------------------------
>  1 file changed, 25 insertions(+), 45 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 486d44421432..64d550e415eb 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2449,10 +2449,8 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
>  static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  			    void *freelist)
>  {
> -	enum slab_modes { M_NONE, M_PARTIAL, M_FREE, M_FULL_NOLIST };
>  	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>  	int free_delta = 0;
> -	enum slab_modes mode = M_NONE;
>  	void *nextfree, *freelist_iter, *freelist_tail;
>  	int tail = DEACTIVATE_TO_HEAD;
>  	unsigned long flags = 0;
> @@ -2499,58 +2497,40 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>  	 * unfrozen and number of objects in the slab may have changed.
>  	 * Then release lock and retry cmpxchg again.
>  	 */

This comment above (including parts not visible here) should be updated as
there is no more list manipulation during unfreeze.

> -redo:
> -
> -	old.freelist = READ_ONCE(slab->freelist);
> -	old.counters = READ_ONCE(slab->counters);
> -	VM_BUG_ON(!old.frozen);
> -
> -	/* Determine target state of the slab */
> -	new.counters = old.counters;
> -	if (freelist_tail) {
> -		new.inuse -= free_delta;
> -		set_freepointer(s, freelist_tail, old.freelist);
> -		new.freelist = freelist;
> -	} else
> -		new.freelist = old.freelist;
> +	do {
> +		old.freelist = READ_ONCE(slab->freelist);
> +		old.counters = READ_ONCE(slab->counters);
> +		VM_BUG_ON(!old.frozen);
> +
> +		/* Determine target state of the slab */
> +		new.counters = old.counters;
> +		new.frozen = 0;
> +		if (freelist_tail) {
> +			new.inuse -= free_delta;
> +			set_freepointer(s, freelist_tail, old.freelist);
> +			new.freelist = freelist;
> +		} else
> +			new.freelist = old.freelist;

Per coding style we should have the else with { } even if it's one line, to
match the if branch. Since we touch the code that was previously violating
the style, we can fix up.

>  
> -	new.frozen = 0;
> +	} while (!slab_update_freelist(s, slab,
> +		old.freelist, old.counters,
> +		new.freelist, new.counters,
> +		"unfreezing slab"));
>  
> +	/*
> +	 * Stage three: Manipulate the slab list based on the updated state.
> +	 */
>  	if (!new.inuse && n->nr_partial >= s->min_partial) {
> -		mode = M_FREE;
> +		stat(s, DEACTIVATE_EMPTY);
> +		discard_slab(s, slab);
> +		stat(s, FREE_SLAB);
>  	} else if (new.freelist) {
> -		mode = M_PARTIAL;
> -		/*
> -		 * Taking the spinlock removes the possibility that
> -		 * acquire_slab() will see a slab that is frozen
> -		 */
>  		spin_lock_irqsave(&n->list_lock, flags);
> -	} else {
> -		mode = M_FULL_NOLIST;
> -	}
> -
> -
> -	if (!slab_update_freelist(s, slab,
> -				old.freelist, old.counters,
> -				new.freelist, new.counters,
> -				"unfreezing slab")) {
> -		if (mode == M_PARTIAL)
> -			spin_unlock_irqrestore(&n->list_lock, flags);
> -		goto redo;
> -	}
> -
> -
> -	if (mode == M_PARTIAL) {
>  		add_partial(n, slab, tail);
>  		spin_unlock_irqrestore(&n->list_lock, flags);
>  		stat(s, tail);
> -	} else if (mode == M_FREE) {
> -		stat(s, DEACTIVATE_EMPTY);
> -		discard_slab(s, slab);
> -		stat(s, FREE_SLAB);
> -	} else if (mode == M_FULL_NOLIST) {
> +	} else
>  		stat(s, DEACTIVATE_FULL);
> -	}

Same here.

Thanks!

>  }
>  
>  #ifdef CONFIG_SLUB_CPU_PARTIAL

