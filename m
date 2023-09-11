Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF41C79B236
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345070AbjIKVPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242826AbjIKQXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:23:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E2DCC3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:23:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54CEB1F88C;
        Mon, 11 Sep 2023 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694449389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=O4KvfJvNifaqg6M/GRoEaRUwz5YRGBylZkZlSzC5HTY=;
        b=Osy2cVXlRluXOG9o+EaR+0pghLH+oFXRjJitAtuEk+bJLXrHTB/0WwtKzRk5ypa2R0CHhd
        qUzRshukM0ISlMozx89Lt2eE4wd0lw3w2jQpjkvs4rXuPP5VsYKYyKZ3JkexYoKdPr8pEN
        XEMrgzJLyFwhGxKDOKpKQ34M9V7MnDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694449389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=O4KvfJvNifaqg6M/GRoEaRUwz5YRGBylZkZlSzC5HTY=;
        b=H8T9HyNdY+KCsWAlHahC0YYvdYenZpCFE6sEFD+3fbF53T18DurXHa08aXmZ/BVuhPZYyA
        Uczgt1YIXlvEt9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23480139CC;
        Mon, 11 Sep 2023 16:23:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AhLeB+0+/2QnCAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Sep 2023 16:23:09 +0000
Message-ID: <1d634412-c0e5-4c16-92a4-447bde684ad6@suse.cz>
Date:   Mon, 11 Sep 2023 18:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: [PATCH v2] slab: kmalloc_size_roundup() must not return
 0 for non-zero size
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Kees Cook' <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
        'Christoph Lameter' <cl@linux.com>,
        'Pekka Enberg' <penberg@kernel.org>,
        'David Rientjes' <rientjes@google.com>,
        'Joonsoo Kim' <iamjoonsoo.kim@lge.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Eric Dumazet' <edumazet@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <4d31a2bf7eb544749023cf491c0eccc8@AcuMS.aculab.com>
 <202309071235.CB4F6B2@keescook>
 <20ca0a567a874052a1161e9be0870463@AcuMS.aculab.com>
 <e17c58a4-2dd8-4a1b-9feb-ab307e3877c2@suse.cz>
 <1bf41b7c8d7c428c8bfb5504ec9f680e@AcuMS.aculab.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 tR6d+JzM8nFUZA==
In-Reply-To: <1bf41b7c8d7c428c8bfb5504ec9f680e@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 18:12, David Laight wrote:
> From: Vlastimil Babka
>> Sent: 11 September 2023 16:54
>> 
>> On 9/8/23 10:26, David Laight wrote:
>> > From: Kees Cook
>> >> Sent: 07 September 2023 20:38
>> >>
>> >> On Thu, Sep 07, 2023 at 12:42:20PM +0000, David Laight wrote:
>> >> > The typical use of kmalloc_size_roundup() is:
>> >> > 	ptr = kmalloc(sz = kmalloc_size_roundup(size), ...);
>> >> > 	if (!ptr) return -ENOMEM.
>> >> > This means it is vitally important that the returned value isn't
>> >> > less than the argument even if the argument is insane.
>> >> > In particular if kmalloc_slab() fails or the value is above
>> >> > (MAX_ULONG - PAGE_SIZE) zero is returned and kmalloc() will return
>> >> > it's single zero-length buffer.
>> >> >
>> >> > Fix by returning the input size on error or if the size exceeds
>> >> > a 'sanity' limit.
>> >> > kmalloc() will then return NULL is the size really is too big.
>> >> >
>> >> >
>> >> > Signed-off-by: David Laight <david.laight@aculab.com>
>> >> > Fixes: 05a940656e1eb ("slab: Introduce kmalloc_size_roundup()")
>> >> > ---
>> >> > v2:
>> >> >     - Use KMALLOC_MAX_SIZE for upper limit.
>> >> >       (KMALLOC_MAX_SIZE + 1 may give better code on some archs!)
>> >> >     - Invert test for overlarge for consistency.
>> >> >     - Put a likely() on result of kmalloc_slab().
>> >> >
>> >> >  mm/slab_common.c | 26 +++++++++++++-------------
>> >> >  1 file changed, 13 insertions(+), 13 deletions(-)
>> >> >
>> >> > diff --git a/mm/slab_common.c b/mm/slab_common.c
>> >> > index cd71f9581e67..0fb7c7e19bad 100644
>> >> > --- a/mm/slab_common.c
>> >> > +++ b/mm/slab_common.c
>> >> > @@ -747,22 +747,22 @@ size_t kmalloc_size_roundup(size_t size)
>> >> >  {
>> >> >  	struct kmem_cache *c;
>> >> >
>> >> > -	/* Short-circuit the 0 size case. */
>> >> > -	if (unlikely(size == 0))
>> >> > -		return 0;
>> >>
>> >> If we want to allow 0, let's just leave this case as-is: the compiler
>> >> will optimize it against the other tests.
>> >
>> > I doubt the compiler will optimise it away - especially with
>> > the unlikely().
>> 
>> Yeah I also think compiler can't do much optimizations except for build-time
>> constant 0 here.
> 
> Only relevant if the code were inlined - and it isn't.

Aha, I thought it was, good point.

> (and is probably a bit big.)
> I'm not sure you'd want to expose kmalloc_slab() to the wider kernel.

No, let's keep it that way.

> OTOH, it could have an inline version for constants > KMALLOC_CACHE_SIZE.
> But they may not happen often enough to make any difference.

Yeah, unnecessary.

>> 
>> > OTOH the explicit checks for (size && size <= LIMIT) do
>> > get optimised to ((size - 1) <= LIMIT - 1) so become
>> > a single compare.
>> >
>> > Then returning 'size' at the bottom means that zero is returned
>> > in the arg is zero - which is fine.
>> >
>> >>
>> >> > -	/* Short-circuit saturated "too-large" case. */
>> >> > -	if (unlikely(size == SIZE_MAX))
>> >> > -		return SIZE_MAX;
>> >> > +	if (size && size <= KMALLOC_MAX_CACHE_SIZE) {
>> >> > +		/*
>> >> > +		 * The flags don't matter since size_index is common to all.
>> >> > +		 * Neither does the caller for just getting ->object_size.
>> >> > +		 */
>> >> > +		c = kmalloc_slab(size, GFP_KERNEL, 0);
>> >> > +		return likely(c) ? c->object_size : size;
>> >>
>> >> I would like to have this fail "safe". c should never be NULL here, so
>> >> let's return "KMALLOC_MAX_SIZE + 1" to force failures.
>> >
>> > Why even try to force failure here?
>> > The whole function is just an optimisation so that the caller
>> > can use the spare space.
>> >
>> > The only thing it mustn't do is return a smaller value.
>> 
>> If "c" is NULL it means either the kernel build must be broken e.g. by
>> somebody breaking the KMALLOC_MAX_CACHE_SIZE value, and we could just ignore
>> c being NULL and let it crash because of that.
>> But I think it can also be NULL due to trying to call kmalloc_size_roundup()
>> too early, when kmalloc_caches array is not yet populated. Note if we call
>> kmalloc() itself too early, we get a NULL as a result, AFAICS. I can imagine
>> two scenarios:
>> 
>> - kmalloc_size_roundup() is called with result immediately fed to kmalloc()
>> that happens too early, in that case we best should not crash on c being
>> NULL and make sure the kmalloc() returns NULL.
>> - kmalloc_size_roundup() is called in some init code to get a value that
>> some later kmalloc() call uses. We might want also not crash in that case,
>> but informing the developer that they did something wrong would be also useful?
>> 
>> Clearly returning 0 if c == NULL, as done currently, is wrong for both
>> scenarios. Retuning "size" is OK for the first scenario, also valid for the
>> second one, but the caller will silently lose the benefit of
>> kmalloc_size_roundup() and the developer introducing that won't realize it's
>> done too early and could be fixed.
> 
> I'm sure that won't matter.

For the performance, sure. It just feels silly to me to have a code that
looks like it does something, but silently doesn't. Leads to cargo cult
copying it to other places etc.

>> So perhaps the best would be to return size for c == NULL, but also do a
>> WARN_ONCE?
> 
> That would add a real function call to an otherwise leaf function
> and almost certainly require the compiler create a stack frame.

Hm I thought WARN is done by tripping on undefined instruction like BUG
these days. Also any code that accepts the call to kmalloc_size_roundup
probably could accept that too.

> 
> ...
> 
> I did have an interesting 'lateral thought' idea.
> It is all very silly doing all the work twice, what you really
> want is kmalloc() to return both the pointer and actual size.
> But returning a 'two word' structure is done by reference and
> would kill performance/
> OTOH a lot of archs can return two word integers in a register pair
> (dx:ax on x86).
> Could you have the real function return ((unsigned __int64)size << 64 | (long)ptr)
> and then extract the size in a wrapper macro?
> (With different types for 32bit)
> 
> That will, of course, break the 'it's like malloc' checks the
> compiler is doing - unless it is taught what is going on.

Probably this is something not worth all the trouble.

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

