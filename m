Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386897979E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbjIGRZi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 13:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbjIGRZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:25:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F13EE7F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:25:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-142-mAsshBkwN4ycognTopktyQ-1; Thu, 07 Sep 2023 09:55:54 +0100
X-MC-Unique: mAsshBkwN4ycognTopktyQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 7 Sep
 2023 09:55:51 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 7 Sep 2023 09:55:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
        'Vlastimil Babka' <vbabka@suse.cz>,
        'Christoph Lameter' <cl@linux.com>,
        'Pekka Enberg' <penberg@kernel.org>,
        'David Rientjes' <rientjes@google.com>,
        'Joonsoo Kim' <iamjoonsoo.kim@lge.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Eric Dumazet'" <edumazet@google.com>
Subject: RE: [PATCH] slab: kmalloc_size_roundup() must not return 0 for
 non-zero size
Thread-Topic: [PATCH] slab: kmalloc_size_roundup() must not return 0 for
 non-zero size
Thread-Index: AdngmrOo1jL765q1RK2Ib5JvSvHtFwASyysAACBZzlA=
Date:   Thu, 7 Sep 2023 08:55:51 +0000
Message-ID: <c7aa755a2155427ca4cca984efffc791@AcuMS.aculab.com>
References: <fcfee37ead054de19871139167aca787@AcuMS.aculab.com>
 <202309061106.C0690BDBB@keescook>
In-Reply-To: <202309061106.C0690BDBB@keescook>
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
> Sent: 06 September 2023 19:17
> 
> On Wed, Sep 06, 2023 at 08:18:21AM +0000, David Laight wrote:
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
> > Signed-off-by: David Laight <david.laight@aculab.com>
> > Fixes: 05a940656e1eb ("slab: Introduce kmalloc_size_roundup()")
> > ---
> > The 'sanity limit' value doesn't really matter (even if too small)
> > It could be 'MAX_ORDER + PAGE_SHIFT' but one ppc64 has MAX_ORDER 16
> > and I don't know if that also has large pages.
> > Maybe it could be 1ul << 30 on 64bit, but it really doesn't matter
> > if it is too big.
> 
> I agree that returning 0 for an (impossible to reach) non-zero
> is wrong, but the problem seen in netdev was that a truncation happened
> for a value returned by kmalloc_size_roundup().
> 
> So, for the first, it shouldn't be possible for "c" to ever be NULL here:

If it isn't possible there is no need to check :-)

> 
> 	c = kmalloc_slab(size, GFP_KERNEL, 0);
> 	return c ? c->object_size : 0;
> 
> But sure, we can return KMALLOC_MAX_SIZE for that.

Isn't KMALLOC_MAX_SIZE actually valid? - so would be wrong.
Returning 'size' is always valid, the later kmalloc() will
almost certainly fail, but it is also ok if it suceeds.

> The pathological case was this:

s/pathological/failing/

> 
> 	unsigned int truncated;
> 	size_t fullsize = UINT_MAX + 1;
> 
>  	ptr = kmalloc(truncated = kmalloc_size_roundup(fullsize), ...);

The actual pathological case is:
	kmalloc(kmalloc_size_roundup(~0ULL - PAGESIZE/2), ...)
which is kmalloc(0, ...) and suceeds.
	
> Should the logic be changed to return KMALLOC_MAX_SIZE for anything
> larger than KMALLOC_MAX_SIZE? This seems like a different kind of
> foot-gun.
> 
> Everything else in the allocator sanity checking (e.g. struct_size(),
> etc) uses SIZE_MAX as the saturation value, which is why
> kmalloc_size_roundup() did too.

SIZE_MAX (aka ~0ull) seems far too large for sanity checking lengths.
(Even without the issue of having no headroom.)

A limit related to an upper bound for vmalloc() would probably
be more appropriate, or maybe just a limit based on kernel VA.
So for 32bit 2^30 is way too large for any kind of allocate.
For 64bit you can go higher (even if the allocators can't
support the values), maybe 2^48?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

