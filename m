Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7552791363
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbjIDI1K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Sep 2023 04:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjIDI1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:27:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69DE12E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:27:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-165-xe_fBOK-OuSM-5QU5OdlUg-1; Mon, 04 Sep 2023 09:27:00 +0100
X-MC-Unique: xe_fBOK-OuSM-5QU5OdlUg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Sep
 2023 09:26:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 4 Sep 2023 09:26:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Willy Tarreau' <w@1wt.eu>, Ammar Faizi <ammarfaizi2@gnuweeb.org>
CC:     =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        "Nicholas Rosenberg" <inori@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v1 3/5] tools/nolibc: x86-64: Use `rep cmpsb` for
 `memcmp()`
Thread-Topic: [RFC PATCH v1 3/5] tools/nolibc: x86-64: Use `rep cmpsb` for
 `memcmp()`
Thread-Index: AQHZ25BVzjdSsUQiYE6wDAvKxWgMfbAKWqPw
Date:   Mon, 4 Sep 2023 08:26:49 +0000
Message-ID: <db080b14cefc483493883f2eec31be26@AcuMS.aculab.com>
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org>
 <20230830135726.1939997-4-ammarfaizi2@gnuweeb.org> <ZO+0IW1zS9QNpP4y@1wt.eu>
In-Reply-To: <ZO+0IW1zS9QNpP4y@1wt.eu>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau
> Sent: 30 August 2023 22:27
> 
> On Wed, Aug 30, 2023 at 08:57:24PM +0700, Ammar Faizi wrote:
> > Simplify memcmp() on the x86-64 arch.
> >
> > The x86-64 arch has a 'rep cmpsb' instruction, which can be used to
> > implement the memcmp() function.
> >
> >     %rdi = source 1
> >     %rsi = source 2
> >     %rcx = length
> >
> > Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> > ---
> >  tools/include/nolibc/arch-x86_64.h | 19 +++++++++++++++++++
> >  tools/include/nolibc/string.h      |  2 ++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
> > index 42f2674ad1ecdd64..6c1b54ba9f774e7b 100644
> > --- a/tools/include/nolibc/arch-x86_64.h
> > +++ b/tools/include/nolibc/arch-x86_64.h
> > @@ -214,4 +214,23 @@ __asm__ (
> >  	"retq\n"
> >  );
> >
> > +#define NOLIBC_ARCH_HAS_MEMCMP
> > +static int memcmp(const void *s1, const void *s2, size_t n)
> > +{
> > +	const unsigned char *p1 = s1;
> > +	const unsigned char *p2 = s2;
> > +
> > +	if (!n)
> > +		return 0;
> > +
> > +	__asm__ volatile (
> > +		"rep cmpsb"
> > +		: "+D"(p2), "+S"(p1), "+c"(n)
> > +		: "m"(*(const unsigned char (*)[n])s1),
> > +		  "m"(*(const unsigned char (*)[n])s2)
> > +	);
> > +
> > +	return p1[-1] - p2[-1];
> > +}
> 
> Out of curiosity, given that you implemented the 3 other ones directly
> in an asm statement, is there a particular reason this one mixes a bit
> of C and asm ? It would probably be something around this, in the same
> vein:
> 
>   memcmp:
>     xchg  %esi,%eax   // source1

Aren't the arguments in %rdi, %rsi and %rdx so you only
need to move the count (below) ?
(Looks like you copied memchr())

	David

>     mov   %rdx,%rcx   // count
>     rep   cmpsb       // source2 in rdi; sets ZF on equal, CF if src1<src2
>     seta  %al         // 0 if src2 <= src1, 1 if src2 > src1
>     sbb   $0, %al     // 0 if src2 == src1, -1 if src2 < src1, 1 if src2 > src1
>     movsx %al, %eax   // sign extend to %eax
>     ret
> 
> Note that the output logic could have to be revisited, I'm not certain but
> at first glance it looks valid.
> 
> Regards,
> Willy

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

