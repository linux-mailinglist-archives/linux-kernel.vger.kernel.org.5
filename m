Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8024377C9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbjHOI7O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Aug 2023 04:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjHOI6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:58:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57721FE5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:56:01 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-Zp5xXA1jN9KEuQKoEhG7Og-1; Tue, 15 Aug 2023 09:55:57 +0100
X-MC-Unique: Zp5xXA1jN9KEuQKoEhG7Og-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 15 Aug
 2023 09:55:55 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 15 Aug 2023 09:55:55 +0100
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
Thread-Index: AdnGwQ6IGYkn0IjZSjuTaOSyeQI0UwIK8m4AABl1+KA=
Date:   Tue, 15 Aug 2023 08:55:55 +0000
Message-ID: <2dd09c4033644239a314247e635fa735@AcuMS.aculab.com>
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <202308141416.89AC5C2@keescook>
In-Reply-To: <202308141416.89AC5C2@keescook>
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
> Sent: 14 August 2023 22:21
> 
> On Fri, Aug 04, 2023 at 10:50:59AM +0000, David Laight wrote:
> > [...]
> > I also suspect that many of the min_t(u16, ...) are actually wrong.
> > For example copy_data() in printk_ringbuffer.c contains:
> >         data_size = min_t(u16, buf_size, len);
> > Here buf_size is 'unsigned int' and len 'u16', pass a 64k buffer
> > (can you prove that doesn't happen?) and no data is returned.
> 
> Stars aligning... this exact bug (as you saw in the other thread[1]) got
> hit. And in the analysis, I came to the same conclusion: min_t() is a
> serious foot-gun, and we should be able to make min() Just Work in the
> most common situations.

It is all a question of what 'work' means.
To my mind (but Linus disagrees!) the only problematic case
is where a negative signed value gets converted to a large
unsigned value.
This snippet from do_tcp_getsockopt() shows what I mean:

	copy_from_user(&len,...)
	len = min_t(unsigned int, len, sizeof(int));

	if (len < 0)
		return -EINVAL;

That can clearly never return -EINVAL.
That has actually been broken since the test was added in 2.4.4.
That predates min_t() in 2.4.10 (renamed from min() in 2.4.9
when the 'strict typecheck' version on min() was added).
So min_t() actually predates min()!

> It seems like the existing type_max/type_min macros could be used to
> figure out that the args are safe to appropriately automatically cast,
> etc. e.g. type_max(u16) <= type_max(unsigned int) && type_min(u16) >=
> type_min(unsigned int) ...

That doesn't really help; min(a,b) is ok if any of:
1) is_signed(a) == is_signed(b).
2) is_signed(a + 0) == is_signed(b + 0)  // Converts char/short to int.
3) a or b is a constant between 0 and MAXINT and is cast to int.

The one you found passes (1) - both types are unsigned.
min(len, sizeof (int)) passes (3) and is converted to
min(len, (int)sizeof (int)) and can still return the expected negatives.

(Clearly that getsockopt code only works for len != 4 on LE.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

