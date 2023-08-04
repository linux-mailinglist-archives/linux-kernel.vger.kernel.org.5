Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E180277053C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjHDPu0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Aug 2023 11:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjHDPuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:50:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534E0212D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:50:23 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-76-qm7ktrQ9OHKl6gBtn9SNaQ-1; Fri, 04 Aug 2023 16:50:20 +0100
X-MC-Unique: qm7ktrQ9OHKl6gBtn9SNaQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 4 Aug
 2023 16:50:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 4 Aug 2023 16:50:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Helge Deller" <deller@gmx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: RE: [PATCH v4 1/1] drm/i915: Move abs_diff() to math.h
Thread-Topic: [PATCH v4 1/1] drm/i915: Move abs_diff() to math.h
Thread-Index: AQHZxi9qpYx0cq9pFEOYLGUrdsezOq/aSRTQ
Date:   Fri, 4 Aug 2023 15:50:18 +0000
Message-ID: <7c1885528d474c719bb4d4e0cf985753@AcuMS.aculab.com>
References: <20230803131918.53727-1-andriy.shevchenko@linux.intel.com>
 <20230803102446.8edf94acc77e81ab2e09cee3@linux-foundation.org>
In-Reply-To: <20230803102446.8edf94acc77e81ab2e09cee3@linux-foundation.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton
> Sent: 03 August 2023 18:25
> 
> On Thu,  3 Aug 2023 16:19:18 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > abs_diff() belongs to math.h. Move it there.
> > This will allow others to use it.
> >
> > ...
> >
> > --- a/include/linux/math.h
> > +++ b/include/linux/math.h
> > @@ -155,6 +155,13 @@ __STRUCT_FRACT(u32)
> >  	__builtin_types_compatible_p(typeof(x), unsigned type),		\
> >  	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
> >
> > +#define abs_diff(a, b) ({			\
> > +	typeof(a) __a = (a);			\
> > +	typeof(b) __b = (b);			\
> > +	(void)(&__a == &__b);			\
> > +	__a > __b ? (__a - __b) : (__b - __a);	\
> > +})
> 
> Can we document it please?
> 
> Also, the open-coded type comparison could be replaced with __typecheck()?
> 
> And why the heck isn't __typecheck() in typecheck.h, to be included by
> minmax.h.

And why would you want to use __typecheck() anyway?
It pretty much isn't the test you are looking for.
If you are trying to explicitly avoid converting negative value
to large positive unsigned ones then you want something like:
	is_signed_type(typeof(a)) == is_signed_type(typeof(b))
but it isn't even that simple :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

