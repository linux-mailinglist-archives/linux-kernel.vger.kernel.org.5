Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D4C7A4455
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbjIRIQ1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 04:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240815AbjIRIQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:16:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6905FCC1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:15:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-66-N0-7TwoNMhaGpIJMQjun6Q-1; Mon, 18 Sep 2023 09:14:51 +0100
X-MC-Unique: N0-7TwoNMhaGpIJMQjun6Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Sep
 2023 09:14:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Sep 2023 09:14:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Thread-Topic: [PATCH next v4 0/5] minmax: Relax type checks in min() and
 max().
Thread-Index: AdnqB/CwAvMQ3gkdSO607JUF4aSKdg==
Date:   Mon, 18 Sep 2023 08:14:40 +0000
Message-ID: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
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

The min() (etc) functions in minmax.h require that the arguments have
exactly the same types.

However when the type check fails, rather than look at the types and
fix the type of a variable/constant, everyone seems to jump on min_t().
In reality min_t() ought to be rare - when something unusual is being
done, not normality.

The orginal min() (added in 2.4.9) replaced several inline functions and
included the type - so matched the implicit casting of the function call.
This was renamed min_t() in 2.4.10 and the current min() added.
There is no actual indication that the conversion of negatve values
to large unsigned values has ever been an actual problem.

A quick grep shows 5734 min() and 4597 min_t().
Having the casts on almost half of the calls shows that something
is clearly wrong.

If the wrong type is picked (and it is far too easy to pick the type
of the result instead of the larger input) then significant bits can
get discarded.
Pretty much the worst example is in the derived clamp_val(), consider:
        unsigned char x = 200u;
        y = clamp_val(x, 10u, 300u);

I also suspect that many of the min_t(u16, ...) are actually wrong.
For example copy_data() in printk_ringbuffer.c contains:
        data_size = min_t(u16, buf_size, len);
Here buf_size is 'unsigned int' and len 'u16', pass a 64k buffer
(can you prove that doesn't happen?) and no data is returned.
Apparantly it did - and has since been fixed.

The only reason that most of the min_t() are 'fine' is that pretty
much all the values in the kernel are between 0 and INT_MAX.

Patch 1 adds umin(), this uses integer promotions to convert
both arguments to 'unsigned long long'. It can be used to compare a
signed type that is known to contain a non-negative value with an
unsigned type. The compiler typically optimises it all away.
Added first so that it can be referred to in patch 2.

Patch 2 replaces the 'same type' check with a 'same signedness' one.
This makes min(unsigned_int_var, sizeof()) be ok.
The error message is also improved and will contain the expanded
form of both arguments (useful for seeing how constants are defined).

Patch 3 just fixes some whitespace.

Patch 4 allows comparisons of 'unsigned char' and 'unsigned short'
to signed types. The integer promotion rules convert them both
to 'signed int' prior to the comparison so they can never cause
a negative value be converted to a large positive one.

Patch 5 (rewritted for v4) allows comparisons of unsigned values
against non-negative constant integer expressions.
This makes min(unsigned_int_var, 4) be ok.

The only common case that is still errored is the comparison of
signed values against unsigned constant integer expressions
below __INT_MAX__.
Typcally min(int_val, sizeof (foo)), the real fix for this is casting
the constant: min(int_var, (int)sizeof (foo)).

With all the patches applied pretty much all the min_t() could be
replaced by min(), and most of the rest by umin().
However they all need careful inspection due to code like:
        sz = min_t(unsigned char, sz - 1, LIM - 1) + 1;
which converts 0 to LIM.

v4: Patch 5 no longer allows min(int_var, 4u), only min(uint_var, 4).
    min_unsigned() rename umin().
    Rebased on 6.6-rc1.
v3: Fix more issues found by the build robot
v2: Fixes some issues found by the kernel build robot.

David Laight (5):
  minmax: Add umin(a, b) and umax(a, b)
  minmax: Allow min()/max()/clamp() if the arguments have the same
    signedness.
  minmax: Fix indentation of __cmp_once() and __clamp_once()
  minmax: Allow comparisons of 'int' against 'unsigned char/short'.
  minmax: Relax check to allow comparison between unsigned arguments and
    signed constants.

 include/linux/minmax.h | 103 +++++++++++++++++++++++++++--------------
 1 file changed, 68 insertions(+), 35 deletions(-)

-- 
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

