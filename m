Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33407D22CD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjJVLDs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 22 Oct 2023 07:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVLDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:03:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE3DD
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:03:44 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-309-2jbcHpCpNfONH8lCgy8ooA-1; Sun, 22 Oct 2023 12:03:41 +0100
X-MC-Unique: 2jbcHpCpNfONH8lCgy8ooA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 22 Oct
 2023 12:03:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 22 Oct 2023 12:03:39 +0100
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
Thread-Index: AQHaBG0ELw1zxmi7jUCMTwySbq0j57BVpWHg
Date:   Sun, 22 Oct 2023 11:03:39 +0000
Message-ID: <5487af5c8c184ac896af2d0b32b3ff42@AcuMS.aculab.com>
References: <VI1PR0702MB3840EB26EF2A1A35BFEA53BFD9D5A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV> <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV> <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV>
In-Reply-To: <20231021222203.GA800259@ZenIV>
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

From: Al Viro
> Sent: 21 October 2023 23:22
> 
> > I don't think -rc7 is a good time for that, though.  At the
> > very least it needs a review on linux-arch - I think I hadn't
> > fucked the ABI for returning u64 up, but...
> >
> > Anyway, completely untested patch follows:
> 
> ... and now something that at least builds (with some brainos fixed); it's still
> slightly suboptimal representation on big-endian 32bit - there it would be better to
> have have the csum in upper half of the 64bit getting returned and use the lower
> half as fault indicator, but dealing with that cleanly takes some massage of
> includes in several places, so I'd left that alone for now.  In any case, the
> overhead of that is pretty much noise.
> 
> diff --git a/arch/alpha/include/asm/checksum.h b/arch/alpha/include/asm/checksum.h
> index 99d631e146b2..80c57b370edb 100644
> --- a/arch/alpha/include/asm/checksum.h
> +++ b/arch/alpha/include/asm/checksum.h
> @@ -43,7 +43,7 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
>   */
>  #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
>  #define _HAVE_ARCH_CSUM_AND_COPY
> -__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len);
> +__u64 csum_and_copy_from_user(const void __user *src, void *dst, int len);
...
> +			return -1;

If you are going to return -1 the return type should be signed.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

