Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56821793E08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbjIFNtm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 09:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbjIFNtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:49:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B06171C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:49:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-270-TszICoJsPNy4wKpDdJ2-ow-1; Wed, 06 Sep 2023 14:49:30 +0100
X-MC-Unique: TszICoJsPNy4wKpDdJ2-ow-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Sep
 2023 14:49:24 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 6 Sep 2023 14:49:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Noah Goldstein' <goldstein.w.n@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: x86/csum: Remove unnecessary odd handling
Thread-Topic: x86/csum: Remove unnecessary odd handling
Thread-Index: AQHZ3SKcfs4a8+P0bkWBCjHsrqR0abAN10lQ
Date:   Wed, 6 Sep 2023 13:49:24 +0000
Message-ID: <3883a2c481dc4facb4e732a4e46fe2a4@AcuMS.aculab.com>
References: <20230628020657.957880-1-goldstein.w.n@gmail.com>
 <20230901222100.1027371-1-goldstein.w.n@gmail.com>
In-Reply-To: <20230901222100.1027371-1-goldstein.w.n@gmail.com>
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

From: Noah Goldstein
> Sent: 01 September 2023 23:21
> 
> The special case for odd aligned buffers is unnecessary and mostly
> just adds overhead. Aligned buffers is the expectations, and even for
> unaligned buffer, the only case that was helped is if the buffer was
> 1-byte from word aligned which is ~1/7 of the cases. Overall it seems
> highly unlikely to be worth to extra branch.
> 
> It was left in the previous perf improvement patch because I was
> erroneously comparing the exact output of `csum_partial(...)`, but
> really we only need `csum_fold(csum_partial(...))` to match so its
> safe to remove.

This is pretty much the same patch I send in Dec 2021...

Reviewed-by: David Laight <david.laight@aculab.com>

> 
> All csum kunit tests pass.
> 
> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
>  arch/x86/lib/csum-partial_64.c | 37 ++--------------------------------
>  1 file changed, 2 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
> index cea25ca8b8cf..d06112e98893 100644
> --- a/arch/x86/lib/csum-partial_64.c
> +++ b/arch/x86/lib/csum-partial_64.c
> @@ -11,28 +11,6 @@
>  #include <asm/checksum.h>
>  #include <asm/word-at-a-time.h>
> 
> -static inline unsigned short from32to16(unsigned a)
> -{
> -	unsigned short b = a >> 16;
> -	asm("addw %w2,%w0\n\t"
> -	    "adcw $0,%w0\n"
> -	    : "=r" (b)
> -	    : "0" (b), "r" (a));
> -	return b;
> -}
> -
> -static inline __wsum csum_tail(u64 temp64, int odd)
> -{
> -	unsigned int result;
> -
> -	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
> -	if (unlikely(odd)) {
> -		result = from32to16(result);
> -		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> -	}
> -	return (__force __wsum)result;
> -}
> -
>  /*
>   * Do a checksum on an arbitrary memory area.
>   * Returns a 32bit checksum.
> @@ -47,17 +25,6 @@ static inline __wsum csum_tail(u64 temp64, int odd)
>  __wsum csum_partial(const void *buff, int len, __wsum sum)
>  {
>  	u64 temp64 = (__force u64)sum;
> -	unsigned odd;
> -
> -	odd = 1 & (unsigned long) buff;
> -	if (unlikely(odd)) {
> -		if (unlikely(len == 0))
> -			return sum;
> -		temp64 = ror32((__force u32)sum, 8);
> -		temp64 += (*(unsigned char *)buff << 8);
> -		len--;
> -		buff++;
> -	}
> 
>  	/*
>  	 * len == 40 is the hot case due to IPv6 headers, but annotating it likely()
> @@ -73,7 +40,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  		    "adcq $0,%[res]"
>  		    : [res] "+r"(temp64)
>  		    : [src] "r"(buff), "m"(*(const char(*)[40])buff));
> -		return csum_tail(temp64, odd);
> +		return add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
>  	}
>  	if (unlikely(len >= 64)) {
>  		/*
> @@ -143,7 +110,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
>  		    : [res] "+r"(temp64)
>  		    : [trail] "r"(trail));
>  	}
> -	return csum_tail(temp64, odd);
> +	return add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
>  }
>  EXPORT_SYMBOL(csum_partial);
> 
> --
> 2.34.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

