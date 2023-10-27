Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23197D9CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346041AbjJ0PJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbjJ0PJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:09:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750AB18A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:09:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B560F21C90;
        Fri, 27 Oct 2023 15:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698419381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2hfwVR3KGrPcuMQgMeGPFWaKBiS51sl2TthGOqLtI0=;
        b=sYO9aFUt8EvnyTkLzUE8+o/58Ax2iL+VH7hPspPMHHuHXEHq3zOKc9sbV/+ejN85dEpPW0
        S/P4iKeJWkgcDhqS9wNIpo9VA6JqOio5wn2g8D9488Rb5J1OVA/pfvpAL91M7q88F6dU4G
        MMt3tLVlUhet97CZVKBerd30bWFUU5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698419381;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2hfwVR3KGrPcuMQgMeGPFWaKBiS51sl2TthGOqLtI0=;
        b=lVD+UYVvlFA7mV2CaffG+BU4Z1fFrKku71MT+w4Z2RM/qH2RNSR+n5be/xI7dr2phS5LXn
        vGZkSWl1DX2F4/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 893E41358C;
        Fri, 27 Oct 2023 15:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oPDZILXSO2U4EgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 27 Oct 2023 15:09:41 +0000
Message-ID: <6d054dbe-c90d-591d-11ca-b9ad3787683d@suse.cz>
Date:   Fri, 27 Oct 2023 17:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v3 1/7] slub: Keep track of whether slub is on the
 per-node partial list
Content-Language: en-US
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
 <20231024093345.3676493-2-chengming.zhou@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231024093345.3676493-2-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.60
X-Spamd-Result: default: False [-5.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FREEMAIL_CC(0.00)[google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
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
         RCPT_COUNT_SEVEN(0.00)[11];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 11:33, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Now we rely on the "frozen" bit to see if we should manipulate the
> slab->slab_list, which will be changed in the following patch.
> 
> Instead we introduce another way to keep track of whether slub is on
> the per-node partial list, here we reuse the PG_workingset bit.
> 
> We use __set_bit and __clear_bit directly instead of the atomic version
> for better performance and it's safe since it's protected by the slub
> node list_lock.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/slab.h | 19 +++++++++++++++++++
>  mm/slub.c |  3 +++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 8cd3294fedf5..50522b688cfb 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h

I think these helper might just go to mm/slub.c as nothing else would use them.

> @@ -193,6 +193,25 @@ static inline void __slab_clear_pfmemalloc(struct slab *slab)
>  	__folio_clear_active(slab_folio(slab));
>  }
>  
> +/*
> + * Slub reuse PG_workingset bit to keep track of whether it's on

"SLUB reuses" ...

Looks fine otherwise!

> + * the per-node partial list.
> + */
> +static inline bool slab_test_node_partial(const struct slab *slab)
> +{
> +	return folio_test_workingset((struct folio *)slab_folio(slab));
> +}
> +
> +static inline void slab_set_node_partial(struct slab *slab)
> +{
> +	__set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
> +}
> +
> +static inline void slab_clear_node_partial(struct slab *slab)
> +{
> +	__clear_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
> +}
> +
>  static inline void *slab_address(const struct slab *slab)
>  {
>  	return folio_address(slab_folio(slab));
> diff --git a/mm/slub.c b/mm/slub.c
> index 63d281dfacdb..3fad4edca34b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2127,6 +2127,7 @@ __add_partial(struct kmem_cache_node *n, struct slab *slab, int tail)
>  		list_add_tail(&slab->slab_list, &n->partial);
>  	else
>  		list_add(&slab->slab_list, &n->partial);
> +	slab_set_node_partial(slab);
>  }
>  
>  static inline void add_partial(struct kmem_cache_node *n,
> @@ -2141,6 +2142,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
>  {
>  	lockdep_assert_held(&n->list_lock);
>  	list_del(&slab->slab_list);
> +	slab_clear_node_partial(slab);
>  	n->nr_partial--;
>  }
>  
> @@ -4831,6 +4833,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
>  
>  			if (free == slab->objects) {
>  				list_move(&slab->slab_list, &discard);
> +				slab_clear_node_partial(slab);
>  				n->nr_partial--;
>  				dec_slabs_node(s, node, slab->objects);
>  			} else if (free <= SHRINK_PROMOTE_MAX)

