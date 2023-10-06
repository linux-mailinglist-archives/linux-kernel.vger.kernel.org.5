Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFF07BB32D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjJFI2T convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 04:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjJFI2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:28:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5721CDE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:28:07 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-170-uSPFK65kPNWIoiEJ1iteNg-1; Fri, 06 Oct 2023 09:28:05 +0100
X-MC-Unique: uSPFK65kPNWIoiEJ1iteNg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 6 Oct
 2023 09:28:04 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 6 Oct 2023 09:28:04 +0100
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
Subject: RE: [PATCH v2 next] compiler.h: Move __is_constexpr() to compiler.h.
Thread-Topic: [PATCH v2 next] compiler.h: Move __is_constexpr() to compiler.h.
Thread-Index: AQHZ96gTRq31SBDNvUGrpdwig3TLHLA8axEg
Date:   Fri, 6 Oct 2023 08:28:04 +0000
Message-ID: <a52781cd79104c978289d3d5e98b0cd4@AcuMS.aculab.com>
References: <2a6680bbe2e84459816a113730426782@AcuMS.aculab.com>
 <202310050921.F0B15702D4@keescook>
In-Reply-To: <202310050921.F0B15702D4@keescook>
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
> Sent: 05 October 2023 17:22
> 
> On Thu, Oct 05, 2023 at 11:39:54AM +0000, David Laight wrote:
> > Prior to f747e6667ebb2 __is_constexpr() was in its only user minmax.h.
> > That commit moved it to const.h - but that file just defines ULL(x) and
> >   UL(x) so that constants can be defined for .S and .c files.
> > So apart from the word 'const' it wasn't really a good location.
> > Instead move the definition to compiler.h just before the similar
> >   is_signed_type() and is_unsigned_type().
> > This may not be a good long-term home, but the three definitions
> >   belong together.
> >
> > Signed-off-by: David Laight <david.laight@aculab.com>
> 
> Yeah, this is what I'd expect (a duplicate move in tools/). Thanks!

I did try to run something that might have built 'perf'.
But it complained about a lot of stuff not being installed.

I do wonder if a better home for all these is_xxx() and __is_xxx()
would be at the top of build_bug.h.

While they can be used on their own (eg with __builtin_choose_expr())
they are typically used with the compile-time asserts
(or at least with code that is also doing asserts.)
So there might only be a few places that need the extra #include.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

