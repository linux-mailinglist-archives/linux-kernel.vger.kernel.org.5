Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28437D16FD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjJTU2J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 16:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTU2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:28:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ED31A4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:28:05 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-257-zI88p2-XMhqEsh7vrL2SXA-1; Fri, 20 Oct 2023 21:28:01 +0100
X-MC-Unique: zI88p2-XMhqEsh7vrL2SXA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 20 Oct
 2023 21:27:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 20 Oct 2023 21:27:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        Eric Dumazet <edumazet@google.com>
CC:     gus Gusenleitner Klaus <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: RE: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Topic: AW: [PATCH] amd64: Fix csum_partial_copy_generic()
Thread-Index: AQHaAmMpLw1zxmi7jUCMTwySbq0j57BTHnww
Date:   Fri, 20 Oct 2023 20:27:59 +0000
Message-ID: <8b3d330b4d624bf3b77c1197a6bf9538@AcuMS.aculab.com>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV> <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV>
In-Reply-To: <20231019080615.GY800259@ZenIV>
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

From: Al Viro
> Sent: 19 October 2023 09:06
> 
> On Thu, Oct 19, 2023 at 09:39:45AM +0200, Eric Dumazet wrote:
> 
> > I wonder if the csum_and_copy_...() helpers are really needed in modern days,
> > with much bigger cpu caches.

The L1 data caches aren't that big.
OTOH ethernet chips tend to do checksum offloading.
I do wonder if the extra complexity is worth it.

Which code paths is it used on?

ICMP can't possibly be common enough to make any difference.
It can't be used for TCP receive - the check has to be done earlier.
Plausibly TCP transmit - but the bytestream nature must make that hard.
It might be usable on UDP transmit - but they'll be small and
still in the L1 cache later on.
For UDP receive I guess deferring the checksum check until recv()
might save the date being loaded in the cache twice - but it doesn't
need to be done with the copy for typical short UDP.

> >
> > Maybe we could remove them and use more standard copy + standard
> > checksum over kernel buffers.
> 
> FWIW, the reason we don't hit that shit all the time is that on almost
> all paths all-zeroes block of data would be rejected anyway/could not
> happen.  Note that e.g. for ICMPv6 the csum includes the pseudo-header
> and there's no way for that to be all-zeroes, etc.
> 
> Whatever we do long-term (and I'd really like to get that mess dealt
> with properly - fuckup is definitely mine, and I should have checked
> the users of that stuff properly back then), I don't believe that
> it's doable this late in the cycle.

What is wrong with something akin to the original suggested patch?
So that the csum fragment function can never return zero.

For x86 the fastest code might be 'xor %eax,%eax; dec %eax'
to avoid the 32bit immediate constant.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

