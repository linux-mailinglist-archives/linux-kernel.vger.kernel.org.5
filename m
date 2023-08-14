Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EC477BA24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHNNdp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 09:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjHNNdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:33:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0110C10CE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:33:23 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-253-nY0m2V98Pem1hrz_0Np7AQ-1; Mon, 14 Aug 2023 14:33:21 +0100
X-MC-Unique: nY0m2V98Pem1hrz_0Np7AQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Aug
 2023 14:33:09 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Aug 2023 14:33:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petr Mladek' <pmladek@suse.com>
CC:     'Kees Cook' <keescook@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] printk: ringbuffer: Fix truncating buffer size min_t cast
Thread-Topic: [PATCH] printk: ringbuffer: Fix truncating buffer size min_t
 cast
Thread-Index: AQHZzBcPYpG1g1kNlkm6DrLi5BIXA6/pnsfQgAAVrACAABVCEA==
Date:   Mon, 14 Aug 2023 13:33:09 +0000
Message-ID: <c9494b6e8aa04543812b93622cbc4ff7@AcuMS.aculab.com>
References: <20230811054528.never.165-kees@kernel.org>
 <42a1e2099fe141c3a57e808cbf06d8a0@AcuMS.aculab.com> <ZNokaoSFTXeB_LP4@alley>
In-Reply-To: <ZNokaoSFTXeB_LP4@alley>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek
> Sent: 14 August 2023 13:56
> 
> On Mon 2023-08-14 10:42:26, David Laight wrote:
> > From: Kees Cook
> > > Sent: 11 August 2023 06:46
> > >
> > > If an output buffer size exceeded U16_MAX, the min_t(u16, ...) cast in
> > > copy_data() was causing writes to truncate. This manifested as output
> > > bytes being skipped, seen as %NUL bytes in pstore dumps when the available
> > > record size was larger than 65536. Fix the cast to no longer truncate
> > > the calculation.
> > >
> > ...
> > > diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> > > index 2dc4d5a1f1ff..fde338606ce8 100644
> > > --- a/kernel/printk/printk_ringbuffer.c
> > > +++ b/kernel/printk/printk_ringbuffer.c
> > > @@ -1735,7 +1735,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
> > >  	if (!buf || !buf_size)
> > >  		return true;
> > >
> > > -	data_size = min_t(u16, buf_size, len);
> > > +	data_size = min_t(unsigned int, buf_size, len);
> >
> > I'd noticed that during one of my test compiles while looking
> > at making min() less fussy.
> >
> > A better fix would be:
> > 	data_size = min(buf_size + 0u, len);
> 
> This looks like a magic to me. The types are:

Not quite the right magic though, needs to be 'len + 0u'.

> 
> 	unsigned int data_size;
> 	unsigned int buf_size;
> 	u16 len
> 
> I would naively expect that
> 
> 	data_size = min(buf_size, len);
> 
> would do the right job and expand @len to "unsigned int".
> 
> I do not remember why "min_t" was used. Was it an optimization?
> Did we miss the problem with casting "u32" down to "u16"?

The underlying problem is that (presumably) in order to stop
min(signed_a, unsigned_b) converting a negative value to a large
unsigned one (very nasty) min() contains (effectively) sizeof(&a == &b)
so barfs if the types differ at all.

I'm sure the intent was that the types would be fixed - in this case
chasing 'len' back all the way back and using 'unsigned int'.
(That probably generates better code as well.)

However everyone just uses min_t(type,a,b) if type is 32bit unsigned
they are mostly ok because the kernel only really deals in 'small'
unsigned values.
But, as in the case here, it is easy to pick a type that is too small.
Pretty much all the min_t() with u8/u16 are likely to be dubious.
I found an 'unsigned long' case in a filesystem where one value
was u64 - could be problematic for a large file on 32bit.
(The u64 definitely contained a 'file size' value.)

The patch set I proposed (see https://lore.kernel.org/lkml/01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com/)
changes the basic test to (is_signed(a) == is_signed(b)) which will
never generate the 'nasty' conversion of -1 to 0xffffffffull.

Of course, it is never quite that simple :-)
Linus seems willing to accept min(unsigned_var, 20) but not
min(signed_var, 20u) - typically as min(signed_var, sizeof(type)).

...
> PS: I have already pushed the patch because it looked reasonable and
>     got testing. I have to admit that I am probably in a pre-vacation
>     hurry mode.

Don't worry it is now not any worse than the other 4500 min_t().
Much the same as the number of min().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

