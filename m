Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4743793762
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjIFIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjIFIsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:48:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80158E7D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:47:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38B962243E;
        Wed,  6 Sep 2023 08:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693990077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0uT0YFvIdeCTeE263WdlZfe3neZinltqXCqjpX729zw=;
        b=21NqZz92+OsEE5a9/xev+KsJtysrVwI5yH5OkVNTHBXjHiP/HmE1qvNQs92sjF41gsmJEv
        rca7+EX4iPm9W3uhzvXEkuils4PvkhMQ864WRdkD2eHWzAfrt5EyqDoz2Wq61jjI2LugAn
        pw+ga6eLVsJEaPrfH7q5qZ0iLBfO2mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693990077;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0uT0YFvIdeCTeE263WdlZfe3neZinltqXCqjpX729zw=;
        b=Yv4ga7yRQr/H6F4uobneZT4bXjAHJB1O9JB6TvbS5TJPFZputXmEpCrYcFYon7Q47xd/fN
        uHYl8gIdoHu+R+BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08B8B1333E;
        Wed,  6 Sep 2023 08:47:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4tsoAb08+GQndAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 06 Sep 2023 08:47:57 +0000
Message-ID: <2cb3f35b-a18c-75fa-d73e-95a4fb8cf079@suse.cz>
Date:   Wed, 6 Sep 2023 10:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] slab: kmalloc_size_roundup() must not return 0 for
 non-zero size
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>
Cc:     'Kees Cook' <keescook@chromium.org>,
        'Christoph Lameter' <cl@linux.com>,
        'Pekka Enberg' <penberg@kernel.org>,
        'David Rientjes' <rientjes@google.com>,
        'Joonsoo Kim' <iamjoonsoo.kim@lge.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Eric Dumazet' <edumazet@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <fcfee37ead054de19871139167aca787@AcuMS.aculab.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <fcfee37ead054de19871139167aca787@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_SOFTFAIL,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please Cc: also R: folks in MAINTAINERS, adding them now.

On 9/6/23 10:18, David Laight wrote:
> The typical use of kmalloc_size_roundup() is:
> 	ptr = kmalloc(sz = kmalloc_size_roundup(size), ...);
> 	if (!ptr) return -ENOMEM.
> This means it is vitally important that the returned value isn't
> less than the argument even if the argument is insane.
> In particular if kmalloc_slab() fails or the value is above
> (MAX_ULONG - PAGE_SIZE) zero is returned and kmalloc() will return
> it's single zero-length buffer.
> 
> Fix by returning the input size on error or if the size exceeds
> a 'sanity' limit.
> kmalloc() will then return NULL is the size really is too big.
> 
> Signed-off-by: David Laight <david.laight@aculab.com>
> Fixes: 05a940656e1eb ("slab: Introduce kmalloc_size_roundup()")
> ---
> The 'sanity limit' value doesn't really matter (even if too small)
> It could be 'MAX_ORDER + PAGE_SHIFT' but one ppc64 has MAX_ORDER 16
> and I don't know if that also has large pages.

Well we do have KMALLOC_MAX_SIZE, which is based on MAX_ORDER + PAGE_SHIFT
(and no issues on ppc64 so I'd expect the combination of MAX_ORDER and
PAGE_SHIFT should always be such that it doesn't overflow on the particular
arch) so I think it would be the most straightforward to simply use that.

> Maybe it could be 1ul << 30 on 64bit, but it really doesn't matter
> if it is too big.
> 
> The original patch also added kmalloc_size_roundup() to mm/slob.c
> that can also round up a value to zero - but has since been removed.
> 
>  mm/slab_common.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index cd71f9581e67..8418eccda8cf 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -747,22 +747,21 @@ size_t kmalloc_size_roundup(size_t size)
>  {
>  	struct kmem_cache *c;
>  
> -	/* Short-circuit the 0 size case. */
> -	if (unlikely(size == 0))
> -		return 0;
> -	/* Short-circuit saturated "too-large" case. */
> -	if (unlikely(size == SIZE_MAX))
> -		return SIZE_MAX;
> -	/* Above the smaller buckets, size is a multiple of page size. */
> -	if (size > KMALLOC_MAX_CACHE_SIZE)
> -		return PAGE_SIZE << get_order(size);
> +	if (size && size <= KMALLOC_MAX_CACHE_SIZE) {

I guess the whole test could all be likely().

Also this patch could probably be just replacing the SIZE_MAX test with >=
KMALLOC_MAX_SIZE, but since the majority is expected to be 0 < size <=
KMALLOC_MAX_CACHE_SIZE, your reordering makes sense to me.

> +		/*
> +		 * The flags don't matter since size_index is common to all.
> +		 * Neither does the caller for just getting ->object_size.
> +		 */
> +		c = kmalloc_slab(size, GFP_KERNEL, 0);
> +		return likely(c) ? c->object_size : size;
> +	}
>  
> -	/*
> -	 * The flags don't matter since size_index is common to all.
> -	 * Neither does the caller for just getting ->object_size.
> -	 */
> -	c = kmalloc_slab(size, GFP_KERNEL, 0);
> -	return c ? c->object_size : 0;
> +	/* Return 'size' for 0 and very large - kmalloc() may fail. */
> +	if (unlikely((size - 1) >> (sizeof (long) == 8 ? 34 : 30)))

So I'd just test for size == 0 || size > KMALLOC_MAX_SIZE?

> +		return size;
> +
> +	/* Above the smaller buckets, size is a multiple of page size. */
> +	return PAGE_SIZE << get_order(size);
>  }
>  EXPORT_SYMBOL(kmalloc_size_roundup);
>  

