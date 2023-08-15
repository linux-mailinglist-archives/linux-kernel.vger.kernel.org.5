Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5B77CEEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbjHOPRZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Aug 2023 11:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbjHOPRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:17:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5691BD0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:17:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-193-Ping3woFOOOiUUPI28DQrQ-1; Tue, 15 Aug 2023 16:16:29 +0100
X-MC-Unique: Ping3woFOOOiUUPI28DQrQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 16:16:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 15 Aug 2023 16:16:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: RE: cleanup: Make no_free_ptr() __must_check
Thread-Topic: cleanup: Make no_free_ptr() __must_check
Thread-Index: AQHZz4AGFMD1jvh0k02ojUASiqmepq/rdtJA
Date:   Tue, 15 Aug 2023 15:16:26 +0000
Message-ID: <4ff59df127e24b83a7c3c9d9aba17857@AcuMS.aculab.com>
References: <20230815105204.GA927051@hirez.programming.kicks-ass.net>
 <fcc8a158-f6e4-8963-782f-ba04b47350b8@rasmusvillemoes.dk>
 <20230815135339.GA966323@hirez.programming.kicks-ass.net>
In-Reply-To: <20230815135339.GA966323@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 15 August 2023 14:54
...
> > Also, isn't it more complicated than necessary? Can we get rid of the
> > inner stmt expr and tmp var by just making it
> >
> >   ((void) (p), ((typeof(p))__no_free_ptr((void **)&(p)))
> >
> > which is more or less the whole reason comma expressions is a thing.
> 
> Ah, so the point of the statement expression before the comma is to
> validate that (p) is in fact a pointer, and to that effect we assign it
> to a 'void *' temporary.
> 
> If that case is invalid, we'll get a compile fail with a dodgy message.
> 
> I did this, because (void **)&(p) looses type integrity due to the cast.
> 
> But yeah, I suppose it all needs a wee comment.

Perhaps add an is_pointer_type() along with is_signed_type()
(and really is_constexpr()) to a global header.

Various checks can be used including:
#define is_pointer_type(t) (!is_constexpr((t)0))
which gives a 0/1 to play with rather than an immediate error.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

