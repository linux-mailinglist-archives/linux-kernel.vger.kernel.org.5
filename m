Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08A978536E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjHWJDV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Aug 2023 05:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbjHWI4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:56:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440EC2100
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:52:27 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-253-4plRHwIrPLObDoLYHSMUZw-1; Wed, 23 Aug 2023 09:52:24 +0100
X-MC-Unique: 4plRHwIrPLObDoLYHSMUZw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 23 Aug
 2023 09:52:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 23 Aug 2023 09:52:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH next v3 0/5] minmax: Relax type checks in min() and max().
Thread-Topic: [PATCH next v3 0/5] minmax: Relax type checks in min() and
 max().
Thread-Index: AdnGwQ6IGYkn0IjZSjuTaOSyeQI0UwIK8m4AABl1+KABQGc+AAAmLwYw
Date:   Wed, 23 Aug 2023 08:52:23 +0000
Message-ID: <acf8a7389d1f47a5ac55390b7ea76692@AcuMS.aculab.com>
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <202308141416.89AC5C2@keescook>
 <2dd09c4033644239a314247e635fa735@AcuMS.aculab.com>
 <202308211113.4F49E73109@keescook>
In-Reply-To: <202308211113.4F49E73109@keescook>
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

From: Kees Cook <keescook@chromium.org>
> Sent: Monday, August 21, 2023 7:24 PM
....
> > > It seems like the existing type_max/type_min macros could be used to
> > > figure out that the args are safe to appropriately automatically cast,
> > > etc. e.g. type_max(u16) <= type_max(unsigned int) && type_min(u16) >=
> > > type_min(unsigned int) ...
> >
> > That doesn't really help; min(a,b) is ok if any of:
> > 1) is_signed(a) == is_signed(b).
> > 2) is_signed(a + 0) == is_signed(b + 0)  // Converts char/short to int.
> > 3) a or b is a constant between 0 and MAXINT and is cast to int.
> >
> > The one you found passes (1) - both types are unsigned.
> > min(len, sizeof (int)) passes (3) and is converted to
> > min(len, (int)sizeof (int)) and can still return the expected negatives.
> 
> It seems like the foot-gun problems are when a value gets clamped by the
> imposed type. Can't we just warn about those cases?

Also when -1 gets converted to 0xffffffff.

...
> But this is also unsafe:
> 
> 	unsigned int a = ...;
>         u16 b = ...;
> 	unsigned int c = min_t(u16, a, b);
> 
> Both are unsigned, but "a > U16_MAX" still goes sideways.

Right, this is one reason why min_t() is broken.
If min() allowed that - no reason why it shouldn't - then it wouldn't
get written in the first place.

> I worry that weakening the min/max() type checking gets into silent errors:
> 
> 	unsigned int a = ...;
>         u16 b = ...;
> 	u16 c = max(a, b);
> 
> when "a > U16_MAX".

Nothing can be done on the RHS to detect invalid narrowing in assignments.
And you don't want the compiler to complain because that will just cause
explicit casts be added making the code harder to read and (probably)
adding more bugs.

> Looking at warning about clamped types on min_t(), though I see tons of
> int vs unsigned int issue. (e.g. dealing with PAGE_SIZE vs an int).

Linus doesn't like me silently converting unsigned constants
to signed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

