Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF417633E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjGZKfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjGZKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:34:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F522126
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:34:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C4A6821CAC;
        Wed, 26 Jul 2023 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690367692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rP9cCoRQS2E3rGBBhQPwvc58rPFE1YgDISl0GEDJwyA=;
        b=3GiZP0ywJ9twiZK95tEdvn42lF3vNqbRlVXTr5uHmQaNt7gk5vdFLBVY7EF6iLkqgvX6HW
        TqgKt1lo2w+nb3z+EiAm6XT7r1M2LzPtgrwED4nO13z6nHBuQIIn2of1c7yXEsfCDd91Ag
        EH48EE4rY2WI4aAGVHWrsw+qxiHh+bU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690367692;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rP9cCoRQS2E3rGBBhQPwvc58rPFE1YgDISl0GEDJwyA=;
        b=anRpI62xl12WDfgp8LFxrUmRveWxcwf0808WL6NI7A4gnSaWp7oep1P4W5ox7tQdMKYt6J
        qHcUOgc2PzBiJmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78B7A139BD;
        Wed, 26 Jul 2023 10:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XMi7HMz2wGSzCwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 26 Jul 2023 10:34:52 +0000
Message-ID: <7a94996f-b6f0-c427-eb1e-126bcb97930c@suse.cz>
Date:   Wed, 26 Jul 2023 12:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC 1/2] Revert "mm, slub: change percpu partial accounting from
 objects to pages"
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Feng Tang <feng.tang@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        Binder Makin <merimus@google.com>, aneesh.kumar@linux.ibm.com,
        tsahu@linux.ibm.com, piyushs@linux.ibm.com, fengwei.yin@intel.com,
        ying.huang@intel.com, lkp <lkp@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230723190906.4082646-1-42.hyeyoo@gmail.com>
 <20230723190906.4082646-2-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230723190906.4082646-2-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit: I would change the subject from "Revert: " as it's not a revert
exactly. If we can come up with a good subject that's not very long :)

On 7/23/23 21:09, Hyeonggon Yoo wrote:
> This is partial revert of commit b47291ef02b0 ("mm, slub: change percpu
> partial accounting from objects to pages"). and full revert of commit
> 662188c3a20e ("mm/slub: Simplify struct slab slabs field definition").
> 
> While b47291ef02b0 prevents percpu partial slab list becoming too long,
> it assumes that the order of slabs are always oo_order(s->oo).

I think I've considered this possibility, but decided it's not important
because if the system becomes memory pressured in a way that it can't
allocate the oo_order() and has to fallback, we no longer care about
accurate percpu caching, as we're unlikely having optimum performance anyway.

> The current approach can surprisingly lower the number of objects cached
> per cpu when it fails to allocate high order slabs. Instead of accounting
> the number of slabs, change it back to accounting objects, but keep
> the assumption that the slab is always half-full.

That's a nice solution as that avoids converting the sysfs variable, so I
wouldn't mind going that way even if I doubt the performance benefits in a
memory pressured system. But maybe there's a concern that if the system is
really memory pressured and has to fallback to smaller orders, before this
patch it would keep fewer percpu partial slabs than after this patch, which
would increase the pressure further and thus be counter-productive?

> With this change, the number of cached objects per cpu is not surprisingly
> decreased even when it fails to allocate high order slabs. It still
> prevents large inaccuracy because it does not account based on the
> number of free objects when taking slabs.
> ---
>  include/linux/slub_def.h |  2 --
>  mm/slab.h                |  6 ++++++
>  mm/slub.c                | 31 ++++++++++++-------------------
>  3 files changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index deb90cf4bffb..589ff6a2a23f 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -109,8 +109,6 @@ struct kmem_cache {
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  	/* Number of per cpu partial objects to keep around */
>  	unsigned int cpu_partial;
> -	/* Number of per cpu partial slabs to keep around */
> -	unsigned int cpu_partial_slabs;
>  #endif
>  	struct kmem_cache_order_objects oo;
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index 799a315695c6..be38a264df16 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -65,7 +65,13 @@ struct slab {
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  				struct {
>  					struct slab *next;
> +#ifdef CONFIG_64BIT
>  					int slabs;	/* Nr of slabs left */
> +					int pobjects;	/* Approximate count */
> +#else
> +					short int slabs;
> +					short int pobjects;
> +#endif
>  				};
>  #endif
>  			};
> diff --git a/mm/slub.c b/mm/slub.c
> index f7940048138c..199d3d03d5b9 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -486,18 +486,7 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
>  {
> -	unsigned int nr_slabs;
> -
>  	s->cpu_partial = nr_objects;
> -
> -	/*
> -	 * We take the number of objects but actually limit the number of
> -	 * slabs on the per cpu partial list, in order to limit excessive
> -	 * growth of the list. For simplicity we assume that the slabs will
> -	 * be half-full.
> -	 */
> -	nr_slabs = DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));
> -	s->cpu_partial_slabs = nr_slabs;
>  }
>  #else
>  static inline void
> @@ -2275,7 +2264,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  	struct slab *slab, *slab2;
>  	void *object = NULL;
>  	unsigned long flags;
> -	unsigned int partial_slabs = 0;
> +	int objects_taken = 0;
>  
>  	/*
>  	 * Racy check. If we mistakenly see no partial slabs then we
> @@ -2312,11 +2301,11 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  		} else {
>  			put_cpu_partial(s, slab, 0);
>  			stat(s, CPU_PARTIAL_NODE);
> -			partial_slabs++;
> +			objects_taken += slab->objects / 2;
>  		}
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
>  		if (!kmem_cache_has_cpu_partial(s)
> -			|| partial_slabs > s->cpu_partial_slabs / 2)
> +			|| objects_taken > s->cpu_partial / 2)
>  			break;
>  #else
>  		break;
> @@ -2699,13 +2688,14 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
>  	struct slab *slab_to_unfreeze = NULL;
>  	unsigned long flags;
>  	int slabs = 0;
> +	int pobjects = 0;
>  
>  	local_lock_irqsave(&s->cpu_slab->lock, flags);
>  
>  	oldslab = this_cpu_read(s->cpu_slab->partial);
>  
>  	if (oldslab) {
> -		if (drain && oldslab->slabs >= s->cpu_partial_slabs) {
> +		if (drain && oldslab->pobjects >= s->cpu_partial) {
>  			/*
>  			 * Partial array is full. Move the existing set to the
>  			 * per node partial list. Postpone the actual unfreezing
> @@ -2714,14 +2704,17 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
>  			slab_to_unfreeze = oldslab;
>  			oldslab = NULL;
>  		} else {
> +			pobjects = oldslab->pobjects;
>  			slabs = oldslab->slabs;
>  		}
>  	}
>  
>  	slabs++;
> +	pobjects += slab->objects / 2;
>  
>  	slab->slabs = slabs;
>  	slab->next = oldslab;
> +	slab->pobjects = pobjects;
>  
>  	this_cpu_write(s->cpu_slab->partial, slab);
>  
> @@ -5653,13 +5646,13 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
>  
>  		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
>  
> -		if (slab)
> +		if (slab) {
>  			slabs += slab->slabs;
> +			objects += slab->objects;
> +		}
>  	}
>  #endif
>  
> -	/* Approximate half-full slabs, see slub_set_cpu_partial() */
> -	objects = (slabs * oo_objects(s->oo)) / 2;
>  	len += sysfs_emit_at(buf, len, "%d(%d)", objects, slabs);
>  
>  #ifdef CONFIG_SLUB_CPU_PARTIAL
> @@ -5669,7 +5662,7 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
>  		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
>  		if (slab) {
>  			slabs = READ_ONCE(slab->slabs);
> -			objects = (slabs * oo_objects(s->oo)) / 2;
> +			objects = READ_ONCE(slab->pobjects);
>  			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
>  					     cpu, objects, slabs);
>  		}

