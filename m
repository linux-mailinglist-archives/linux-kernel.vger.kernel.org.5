Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED1978BF28
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjH2HXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjH2HXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:23:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0718E1A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:22:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf1f632b8so540594766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1693293774; x=1693898574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fEM1R+XUlViJgUzA6tgLIBYY3JKJyTTorDzbDnZTUGM=;
        b=TZhQhB8PHTntcrUjWhuhfhySiRBIVuZMgT1mG5mEp28URa3+VIEVhVRTkKaXJg0YST
         HxeJPQqHbIve1tPTGh/3TLackV2L9aIUzXHjw2uWpfM/kp85d3x2ezvPM7dib/yC4ymf
         gymIDmP0rYUxZjNRMSDD50+GMcuA7R/1z1Ycw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693293774; x=1693898574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEM1R+XUlViJgUzA6tgLIBYY3JKJyTTorDzbDnZTUGM=;
        b=BqNn99BWj2IwqOzQ8IzjmZ6xb7510RK4Iu1xHU3zAn19PZgaA+bDfr58Z7am4FebAy
         wl24UFCD90l8klu7CueBeCmFqA0WabSvtWIMX+KVDVBJnM5T8v7Bmd3VmyEmdjNyrKwl
         G8FrRGzg+KiEyUfZQrUDqiPhPGunRhL5uh/bhkwzsOW1TeYkT7jzn+4ZGaKcBqwoBwXM
         H0xY6Zde+K930q6rb0rLq42RTs0vNInfHwIUMIlDSNCaI0F9s8eWtNwmOK0zF4GvTJwU
         dFgUDOZsQMyOafmip2S1M683Zi8JsgbNrsCNEMqzjd2pNXE293XElqiyPFSl3gHhPyzt
         l4Kw==
X-Gm-Message-State: AOJu0YySE76HkMo3vVShxQAV8uJB3pDhin2EoFGprhVLHfUk5aMMeqBH
        e6qecJ/wPq2tqp0RhL/+6M7HJ03k+T0UeIMdqUJ2kQ==
X-Google-Smtp-Source: AGHT+IHDS2+KfndvHck9vtrRrirGUfUhAX8OlhzAHMEwUqkMQR4pjcpZ2kJUPJQ9QYulW2nGsib9LA==
X-Received: by 2002:a17:906:d14d:b0:9a5:8eab:49da with SMTP id br13-20020a170906d14d00b009a58eab49damr6737998ejb.19.1693293774498;
        Tue, 29 Aug 2023 00:22:54 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906718700b0099bcf1c07c6sm5637348ejk.138.2023.08.29.00.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 00:22:54 -0700 (PDT)
Message-ID: <945c1c2e-03ab-e531-bbba-6e69e2bfff4f@rasmusvillemoes.dk>
Date:   Tue, 29 Aug 2023 09:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/12] bitmap: add bitmap_weight_from()
Content-Language: en-US, da
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230828184353.5145-1-yury.norov@gmail.com>
 <20230828184353.5145-3-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230828184353.5145-3-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 20.43, Yury Norov wrote:
> Add a _from flavor for bitmap_weight(). It's useful when traversing
> bitmaps in a loop to not count bits from the beginning every time.
> 
> The test for bitmap_weight{,_from}() is added as well.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  include/linux/bitmap.h | 14 ++++++++++++++
>  lib/bitmap.c           | 25 +++++++++++++++++++++++++
>  lib/test_bitmap.c      | 18 ++++++++++++++++++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 692d0a1dbe92..6acbdd2abd0c 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -168,6 +168,8 @@ bool __bitmap_subset(const unsigned long *bitmap1,
>  unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
>  unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
>  				 const unsigned long *bitmap2, unsigned int nbits);
> +unsigned int __bitmap_weight_from(const unsigned long *bitmap,
> +					unsigned int bits, unsigned int start);
>  void __bitmap_set(unsigned long *map, unsigned int start, int len);
>  void __bitmap_clear(unsigned long *map, unsigned int start, int len);
>  
> @@ -446,6 +448,18 @@ unsigned long bitmap_weight_and(const unsigned long *src1,
>  	return __bitmap_weight_and(src1, src2, nbits);
>  }
>  
> +static __always_inline
> +unsigned int bitmap_weight_from(const unsigned long *src, unsigned int nbits, unsigned int start)
> +{
> +	if (unlikely(start >= nbits))
> +		return 0;
> +
> +	if (small_const_nbits(nbits - start) && nbits / BITS_PER_LONG == start / BITS_PER_LONG)
> +		return hweight_long(*src & GENMASK(nbits-1, start));

This must be buggy. If I pass compile-time constants nbits==96 and
start==64, the whole if() is true, and we call GENMASK with total
garbage arguments, and access src[0] and not src[1] as that start-value
would suggest.

Don't optimize for irrelevant cases. The expected use of this function
must be that start is some runtime thing. So just make the whole if()
just test whether nbits is small_const, and if so, I think the
hweight_long() line is actually right as-is (though I can never remember
GENMASK argument order).
>  
> +#define BITMAP_WEIGHT_FROM(FETCH, bits, start)					\
> +({										\
> +	unsigned long __bits = (bits), val, idx, w = 0, __start = (start), mask;\
> +										\
> +	mask = BITMAP_FIRST_WORD_MASK(__start);					\
> +	idx = __start / BITS_PER_LONG;						\
> +										\
> +	for (val = (FETCH) & mask; idx < __bits / BITS_PER_LONG; val = (FETCH))	{\
> +		w += hweight_long(val);						\
> +		idx++;								\
> +	}									\
> +										\
> +	if (__bits % BITS_PER_LONG)						\
> +		w += hweight_long((val) & BITMAP_LAST_WORD_MASK(__bits));	\
> +										\
> +	w;									\
> +})
>

Why does the entire function body need to be an unholy statement expression?

Rasmus

