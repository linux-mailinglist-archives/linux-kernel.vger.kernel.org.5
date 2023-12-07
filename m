Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D868808636
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjLGJ7m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Dec 2023 04:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjLGJ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:59:41 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E28122
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:59:44 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-6-n5yQ08V_MnaoJcWm685PQg-1; Thu, 07 Dec 2023 09:59:39 +0000
X-MC-Unique: n5yQ08V_MnaoJcWm685PQg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 7 Dec
 2023 09:58:48 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 7 Dec 2023 09:58:48 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "gus Gusenleitner Klaus" <gus@keba.com>,
        Al Viro <viro@ftp.linux.org.uk>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Subject: RE: [RFC][PATCHES v2] checksum stuff
Thread-Topic: [RFC][PATCHES v2] checksum stuff
Thread-Index: AQHaJyGyb9WP/snuGU2gdqpp5IxoMLCcGsYAgADCXYCAALXl0A==
Date:   Thu, 7 Dec 2023 09:58:48 +0000
Message-ID: <d7faa6ef028c4bac9bc94c92d3af9f38@AcuMS.aculab.com>
References: <20231019050250.GV800259@ZenIV> <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV> <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV> <20231022194020.GA972254@ZenIV>
 <20231205022100.GB1674809@ZenIV>
 <602ab11ffa2c4cc49bb9ecae2f0540b0@AcuMS.aculab.com>
 <20231206224359.GR1674809@ZenIV>
In-Reply-To: <20231206224359.GR1674809@ZenIV>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro
> Sent: 06 December 2023 22:44
> 
> On Wed, Dec 06, 2023 at 11:10:45AM +0000, David Laight wrote:
> 
> > Do we?
> > I've not seen any justification for this at all.
> > IIRC the ICMPv4 reply code needs the checksum function return 0xffff
> > for all-zero input.
> >
> > So the correct and simple fix is to initialise the sum to 0xffff
> > in the checksum function.
> 
> You do realize that ICMPv4 reply code is not the only user of those,
> right?  Sure, we can special-case it there.  And audit the entire
> call tree, proving that no other call chains need the same.
> 
> Care to post the analysis?  I have the beginnings of that and it's already
> long and convoluted and touches far too many places, all of which will
> have to be watched indefinitely, so that changes in there don't introduce
> new breakage.
> 
> I could be wrong.  About many things, including the depth of your
> aversion to RTFS.  But frankly, until that analysis shows up somewhere,
> I'm going to ignore your usual handwaving.

This code is calculating the ip-checksum of a buffer.
The is subtly different from the 16bit 1's complement sum of
the buffer.
Now 0x0000 and 0xffff are mathematically equivalent but various specs
to treat them differently.

Consider the UDP header checksum.
For IPv4 the checksum field can be zero - but that means 'not
calculated' and should be treated as a valid checksum.
But IPv6 treats zero as an error.
If the 1's complement sum is 0xffff then the checksum field
need to contain 0xffff not 0.
This means you really need to calculate 1 + ~sum16(1, buff, len)
(ie initialise the sum to 1 rather than 0 or 0xffff.)

The issue that showed this was zero being put into an ICMP message
when all the bytes were zero instead of the required 0xffff.
The reporter had changed the initialiser and got the required 0xffff
and everything then worked.

That wasn't the copy+checksum path either - since the packet got
sent rather than EFAULT being generated.

If I read the code/specs I'll only find places where the buffer
is guaranteed to be non-zero (pretty much all of IP, TCP and UDP)
or 0xffff is the required valued (ICMP).

Since you are proposing this patch I think you need to show
a concrete example of where an all zero buffer is required to
generate a zero checksum value but a non-zero buffer must
generate 0xffff.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

