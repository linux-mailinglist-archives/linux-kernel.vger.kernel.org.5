Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532327D3B95
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjJWQAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:00:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8582BFF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:00:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC08121ACA;
        Mon, 23 Oct 2023 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698076810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ci88fiZi7x2IyI2FoMPvCXZY9i+2+BsJo5XNRuhXCuo=;
        b=uXyg/KeBZX/Re+jNaOI9y6whNxibc2jQ9bW8t5qPWI0FPL8KcQzDlU4e/aiFpniQTmcSUJ
        +vwQX7OhHcrcsQyW0Og1uwvnrZLEp1OTNspguNqgnOqZ0Vd7LQ74736azAkrIkwweYVDfu
        bTwwgJL5bP8usPRf7uVnAs9QZS42oPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698076810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ci88fiZi7x2IyI2FoMPvCXZY9i+2+BsJo5XNRuhXCuo=;
        b=I7aHMkZQe2271mJL9HefEhf8yWzkerTubwUp7aSXhfSLTHDskn8f2WXIwcFFctq8F39ABD
        lvz5tx5u1R0RQaAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85B35132FD;
        Mon, 23 Oct 2023 16:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QaDLH4qYNmUdIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Oct 2023 16:00:10 +0000
Message-ID: <79a879cc-f5f8-08ef-0afa-3688d433a756@suse.cz>
Date:   Mon, 23 Oct 2023 18:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 3/6] slub: Don't freeze slabs for cpu partial
Content-Language: en-US
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, willy@infradead.org, pcc@google.com,
        tytso@mit.edu, maz@kernel.org, ruansy.fnst@fujitsu.com,
        vishal.moola@gmail.com, lrh2000@pku.edu.cn, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
 <20231021144317.3400916-4-chengming.zhou@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231021144317.3400916-4-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.60
X-Spamd-Result: default: False [-5.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FREEMAIL_CC(0.00)[google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,infradead.org,mit.edu,kernel.org,fujitsu.com,pku.edu.cn,vger.kernel.org,kvack.org,bytedance.com];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[19];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/23 16:43, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Now we will freeze slabs when moving them out of node partial list to
> cpu partial list, this method needs two cmpxchg_double operations:
> 
> 1. freeze slab (acquire_slab()) under the node list_lock
> 2. get_freelist() when pick used in ___slab_alloc()
> 
> Actually we don't need to freeze when moving slabs out of node partial
> list, we can delay freeze to use slab freelist in ___slab_alloc(), so
> we can save one cmpxchg_double().
> 
> And there are other good points:
> 
> 1. The moving of slabs between node partial list and cpu partial list
>    becomes simpler, since we don't need to freeze or unfreeze at all.
> 
> 2. The node list_lock contention would be less, since we only need to
>    freeze one slab under the node list_lock. (In fact, we can first
>    move slabs out of node partial list, don't need to freeze any slab
>    at all, so the contention on slab won't transfer to the node list_lock
>    contention.)
> 
> We can achieve this because there is no concurrent path would manipulate
> the partial slab list except the __slab_free() path, which is serialized
> now.
> 
> Note this patch just change the parts of moving the partial slabs for
> easy code review, we will fix other parts in the following patches.
> Specifically this patch change three paths:
> 1. get partial slab from node: get_partial_node()
> 2. put partial slab to node: __unfreeze_partials()
> 3. cache partail slab on cpu when __slab_free()

So the problem with this approach that one patch breaks things and another
one fixes them up, is that git bisect becomes problematic, so we shouldn't
do that and instead bite the bullet and deal with a potentially large patch.
At some level it's unavoidable as one has to grasp all the moving pieces
anyway to see e.g. if the changes in allocation path are compatible with the
changes in freeing.
When possible, we can do preparatory stuff that doesn't break things like in
patches 1 and 2, maybe get_cpu_partial() could also be introduced (even if
unused) before switching the world over to the new scheme in a single patch
(and possible cleanups afterwards). So would it be possible to redo it in
such way please?

<snip>

> @@ -2621,23 +2622,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
>  			spin_lock_irqsave(&n->list_lock, flags);
>  		}
>  
> -		do {
> -
> -			old.freelist = slab->freelist;
> -			old.counters = slab->counters;
> -			VM_BUG_ON(!old.frozen);
> -
> -			new.counters = old.counters;
> -			new.freelist = old.freelist;
> -
> -			new.frozen = 0;
> -
> -		} while (!__slab_update_freelist(s, slab,
> -				old.freelist, old.counters,
> -				new.freelist, new.counters,
> -				"unfreezing slab"));
> -
> -		if (unlikely(!new.inuse && n->nr_partial >= s->min_partial)) {
> +		if (unlikely(!slab->inuse && n->nr_partial >= s->min_partial)) {
>  			slab->next = slab_to_discard;
>  			slab_to_discard = slab;
>  		} else {
> @@ -3634,18 +3619,8 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  		was_frozen = new.frozen;
>  		new.inuse -= cnt;
>  		if ((!new.inuse || !prior) && !was_frozen) {
> -
> -			if (kmem_cache_has_cpu_partial(s) && !prior) {
> -
> -				/*
> -				 * Slab was on no list before and will be
> -				 * partially empty
> -				 * We can defer the list move and instead
> -				 * freeze it.
> -				 */
> -				new.frozen = 1;
> -
> -			} else { /* Needs to be taken off a list */
> +			/* Needs to be taken off a list */
> +			if (!kmem_cache_has_cpu_partial(s) || prior) {
>  
>  				n = get_node(s, slab_nid(slab));
>  				/*
> @@ -3675,7 +3650,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  			 * activity can be necessary.
>  			 */
>  			stat(s, FREE_FROZEN);
> -		} else if (new.frozen) {
> +		} else if (kmem_cache_has_cpu_partial(s) && !prior) {
>  			/*
>  			 * If we just froze the slab then put it onto the
>  			 * per cpu partial list.

I think this comment is now misleading, we didn't freeze the slab, so it's
now something like "if we started with a full slab...".
