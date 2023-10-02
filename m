Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBF7B5875
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbjJBQxp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbjJBQxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:53:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACDED9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:53:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-z1dzXJeKNDGXldiHZ7HiRw-1; Mon, 02 Oct 2023 17:53:36 +0100
X-MC-Unique: z1dzXJeKNDGXldiHZ7HiRw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 2 Oct
 2023 17:53:35 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 2 Oct 2023 17:53:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux@rasmusvillemoes.dk'" <linux@rasmusvillemoes.dk>,
        'Steven Rostedt' <rostedt@goodmis.org>,
        "'bvanassche@acm.org'" <bvanassche@acm.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH next] compiler.h: Move __is_constexpr() to compiler.h.
Thread-Topic: [PATCH next] compiler.h: Move __is_constexpr() to compiler.h.
Thread-Index: Adn1PNrdhhFKapOtSdeAhH/r8REupwACvOgAAAIu+xA=
Date:   Mon, 2 Oct 2023 16:53:34 +0000
Message-ID: <03fe9acd49c84e94b60fc48863f396ae@AcuMS.aculab.com>
References: <6d2b584e26544ee6a0810e494352d432@AcuMS.aculab.com>
 <202310020947.CAF558C6@keescook>
In-Reply-To: <202310020947.CAF558C6@keescook>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook
> Sent: 02 October 2023 17:48
>
> On Mon, Oct 02, 2023 at 02:34:05PM +0000, David Laight wrote:
> > Prior to f747e6667ebb2 __is_constexpr() was in its only user minmax.h.
> > That commit moved it to const.h - but that file just defined ULL(x) and
> >   UL(x) so that constants can be defined for .S and .c files.
> > So apart from the word 'const' it wasn't really a good location.
> > Instead move the definition to compiler.h just before the similar
> >   is_signed_type() and is_unsigned_type().
> > (Which were moved there by dcf8e5633e2e6)
> > This may not be a good long-term home, but the three definitions
> >   belong together.
> >
...
> > diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
> > index 435ddd72d2c4..81b8aae5a855 100644
> > --- a/tools/include/linux/const.h
> > +++ b/tools/include/linux/const.h
> > @@ -3,12 +3,4 @@
> >
> >  #include <vdso/const.h>
> >
> > -/*
> > - * This returns a constant expression while determining if an argument is
> > - * a constant expression, most importantly without evaluating the argument.
> > - * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> > - */
> > -#define __is_constexpr(x) \
> > -	(sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> 
> Doesn't tools/ still need its own copy somewhere?

Nothing failed to build with it removed...
I think I decided that tools actually used compiler.h.

There weren't extra definitions of is_signed_type().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

