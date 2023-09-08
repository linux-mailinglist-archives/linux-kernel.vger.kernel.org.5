Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141427983FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbjIHI0w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 04:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbjIHI0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:26:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC6D173B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:26:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-162-3H32lV7WNIegh-Ql8HGViw-1; Fri, 08 Sep 2023 09:26:43 +0100
X-MC-Unique: 3H32lV7WNIegh-Ql8HGViw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 8 Sep
 2023 09:26:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 8 Sep 2023 09:26:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>
CC:     'Vlastimil Babka' <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
        'Christoph Lameter' <cl@linux.com>,
        'Pekka Enberg' <penberg@kernel.org>,
        'David Rientjes' <rientjes@google.com>,
        'Joonsoo Kim' <iamjoonsoo.kim@lge.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Eric Dumazet'" <edumazet@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Roman Gushchin" <roman.gushchin@linux.dev>
Subject: RE: Subject: [PATCH v2] slab: kmalloc_size_roundup() must not return
 0 for non-zero size
Thread-Topic: Subject: [PATCH v2] slab: kmalloc_size_roundup() must not return
 0 for non-zero size
Thread-Index: Adnhh8rbtLpHk7QBQE+HpPR0NWDZ5gAMq8SAABymU5A=
Date:   Fri, 8 Sep 2023 08:26:40 +0000
Message-ID: <20ca0a567a874052a1161e9be0870463@AcuMS.aculab.com>
References: <4d31a2bf7eb544749023cf491c0eccc8@AcuMS.aculab.com>
 <202309071235.CB4F6B2@keescook>
In-Reply-To: <202309071235.CB4F6B2@keescook>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook
> Sent: 07 September 2023 20:38
> 
> On Thu, Sep 07, 2023 at 12:42:20PM +0000, David Laight wrote:
> > The typical use of kmalloc_size_roundup() is:
> > 	ptr = kmalloc(sz = kmalloc_size_roundup(size), ...);
> > 	if (!ptr) return -ENOMEM.
> > This means it is vitally important that the returned value isn't
> > less than the argument even if the argument is insane.
> > In particular if kmalloc_slab() fails or the value is above
> > (MAX_ULONG - PAGE_SIZE) zero is returned and kmalloc() will return
> > it's single zero-length buffer.
> >
> > Fix by returning the input size on error or if the size exceeds
> > a 'sanity' limit.
> > kmalloc() will then return NULL is the size really is too big.
> >
> >
> > Signed-off-by: David Laight <david.laight@aculab.com>
> > Fixes: 05a940656e1eb ("slab: Introduce kmalloc_size_roundup()")
> > ---
> > v2:
> >     - Use KMALLOC_MAX_SIZE for upper limit.
> >       (KMALLOC_MAX_SIZE + 1 may give better code on some archs!)
> >     - Invert test for overlarge for consistency.
> >     - Put a likely() on result of kmalloc_slab().
> >
> >  mm/slab_common.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index cd71f9581e67..0fb7c7e19bad 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -747,22 +747,22 @@ size_t kmalloc_size_roundup(size_t size)
> >  {
> >  	struct kmem_cache *c;
> >
> > -	/* Short-circuit the 0 size case. */
> > -	if (unlikely(size == 0))
> > -		return 0;
> 
> If we want to allow 0, let's just leave this case as-is: the compiler
> will optimize it against the other tests.

I doubt the compiler will optimise it away - especially with
the unlikely().

OTOH the explicit checks for (size && size <= LIMIT) do
get optimised to ((size - 1) <= LIMIT - 1) so become
a single compare.

Then returning 'size' at the bottom means that zero is returned
in the arg is zero - which is fine.

> 
> > -	/* Short-circuit saturated "too-large" case. */
> > -	if (unlikely(size == SIZE_MAX))
> > -		return SIZE_MAX;
> > +	if (size && size <= KMALLOC_MAX_CACHE_SIZE) {
> > +		/*
> > +		 * The flags don't matter since size_index is common to all.
> > +		 * Neither does the caller for just getting ->object_size.
> > +		 */
> > +		c = kmalloc_slab(size, GFP_KERNEL, 0);
> > +		return likely(c) ? c->object_size : size;
> 
> I would like to have this fail "safe". c should never be NULL here, so
> let's return "KMALLOC_MAX_SIZE + 1" to force failures.

Why even try to force failure here?
The whole function is just an optimisation so that the caller
can use the spare space.

The only thing it mustn't do is return a smaller value.

> 
> > +	}
> > +
> >  	/* Above the smaller buckets, size is a multiple of page size. */
> > -	if (size > KMALLOC_MAX_CACHE_SIZE)
> > +	if (size && size <= KMALLOC_MAX_SIZE)
> >  		return PAGE_SIZE << get_order(size);
> >
> > -	/*
> > -	 * The flags don't matter since size_index is common to all.
> > -	 * Neither does the caller for just getting ->object_size.
> > -	 */
> > -	c = kmalloc_slab(size, GFP_KERNEL, 0);
> > -	return c ? c->object_size : 0;
> > +	/* Return 'size' for 0 and very large - kmalloc() may fail. */
> 
> I want to _be certain_ failure happens. If we get here we need to return
> "KMALLOC_MAX_SIZE + 1"

Why care?

	David

> 
> -Kees
> 
> > +	return size;
> > +
> >  }
> >  EXPORT_SYMBOL(kmalloc_size_roundup);
> >
> > --
> > 2.17.1
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)
> >
> 
> --
> Kees Cook

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

