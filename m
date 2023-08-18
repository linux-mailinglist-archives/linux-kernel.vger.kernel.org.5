Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EFE7805FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358082AbjHRGx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358108AbjHRGxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:53:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F384C273C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:53:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so21599a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1692341620; x=1692946420;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCDawg9XpU55ewyHKwVLA/Xkln6SC57eMlqWx9DLiEo=;
        b=T9yCbIc7LfPUTkoO8VIvyyAql3VtqdbkZ5ZaXDPGrkECIIk8uWr9Bk90c2L6yxLWhA
         ZMEJoxHdzpODc7YuJ7nVEvxxFIzy9X2EUpxPbQYsJsCiD5Hy50uNEBx85g3oUYB9I3+z
         54oxFjYnz615ROWpsQvpWCgliOk7B6Llps1jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692341620; x=1692946420;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCDawg9XpU55ewyHKwVLA/Xkln6SC57eMlqWx9DLiEo=;
        b=Aj+9ai/wS+wXt+W73+UQykwdSZfvS2ThHVFYUtAnx33VC3v9TiY9Uc1FDsSc+qLEID
         zkZMhB2zilfBTaWx+ReHiEaVneMaot5M/qvMv8o1NOUEATco/XK7bNl5w6l1bO9gQ56m
         l20M0VsNc5ZWGsUwt3AK9juKH3atKI9p2Gfjfmtg4EpdsluAe+pXpRmMmDWScNLZ5E0p
         bB2jxMbN6YArCPHVgCGwqEUDE96IzsUfgXVuKLiqqX+KYUNUtYrjmfeFnjAJqC56gLRB
         sAqp/IQ03sZ0iFC9c5H2WzlUiZy8YRwIbTU+o/qKM+mE4uKvX6kq7rVRG5V+WnNdkJ4N
         icWQ==
X-Gm-Message-State: AOJu0Yzv02ljKYVI8jxoVGz4vKLvLmM2EObNj2VokHvw6XXm/RMFWhPh
        RC4juLAJA62OHkxu/pM+vp//8wFLer6SX1dWAF159g==
X-Google-Smtp-Source: AGHT+IF6LS3DQ1jhWajlCgKZKxhAQc1GaQN3VyutqVz3uuH/zwutZNcndawwmJjuJX8c31EW2DJB5A==
X-Received: by 2002:aa7:c414:0:b0:521:d2ab:e4df with SMTP id j20-20020aa7c414000000b00521d2abe4dfmr1524947edq.19.1692341620319;
        Thu, 17 Aug 2023 23:53:40 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402019400b005259dd903e5sm720024edv.67.2023.08.17.23.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 23:53:39 -0700 (PDT)
Message-ID: <e66919a4-afdc-efdb-f6ae-07cfc5bde105@rasmusvillemoes.dk>
Date:   Fri, 18 Aug 2023 08:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/2] bitmap: Optimize memset() calls
Content-Language: en-US, da
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
References: <20230817165453.713353-1-andriy.shevchenko@linux.intel.com>
 <20230817165453.713353-3-andriy.shevchenko@linux.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230817165453.713353-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 18.54, Andy Shevchenko wrote:
> Intead of byte memset() calls use 32- or 64-bit version depending
> on the compile-time BITS_PER_LONG value.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/bitmap.h | 16 ++++++++++++----
>  lib/bitmap.c           |  4 ++--
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 2d5042d1b501..6eec4d4fd623 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -234,22 +234,30 @@ extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
>  
>  static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
>  {
> -	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> +	unsigned int len = BITS_TO_LONGS(nbits);
>  
>  	if (small_const_nbits(nbits))
>  		*dst = 0;
>  	else
> -		memset(dst, 0, len);
> +#if BITS_PER_LONG == 64
> +		memset64((uint64_t *)dst, 0, len);
> +#else
> +		memset32((uint32_t *)dst, 0, len);
> +#endif
>  }
>  

So _if_ this is worth it at all, all those new '#if BITS_PER_LONG == 64'
suggests that we should instead have a new helper memset_long(), no?

In fact, string.h already has that:

static inline void *memset_l(unsigned long *p, unsigned long v,
                __kernel_size_t n)


>  static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
>  {
> -	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
> +	unsigned int len = BITS_TO_LONGS(nbits);
>  
>  	if (small_const_nbits(nbits))
>  		*dst = ~0UL;
>  	else
> -		memset(dst, 0xff, len);
> +#if BITS_PER_LONG == 64
> +		memset64((uint64_t *)dst, GENMASK(63, 0), len);
> +#else
> +		memset32((uint32_t *)dst, GENMASK(31, 0), len);
> +#endif>  }
>

Please just spell an all-ones long "~0UL", that also matches the
small_const case.


>  static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 935e0f96e785..df0fb37a5732 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -128,7 +128,7 @@ void __bitmap_shift_right(unsigned long *dst, const unsigned long *src,
>  		dst[k] = lower | upper;
>  	}
>  	if (off)
> -		memset(&dst[lim - off], 0, off*sizeof(unsigned long));
> +		bitmap_zero(&dst[lim - off], off);

This... can't be right. bitmap_zero() still takes an argument which is
the size in bits, while off is the whole number of words to shift. So if
called with say shift=128, we'd have off==2, and that bitmap_zero()
would, because bitmap_zero() rounds up to a whole number of words, end
up clearing just one word.

Perhaps a chance to add some more test cases? Maybe we're not exercising
any of the "shift more than BITS_PER_LONG" logic.

But rather than using bitmap_zero() here, forcing you to convert off to
a number of bits and then bitmap_zero to divide again, if you do this at
all, just change that memset() to memset_l().

>  }
>  EXPORT_SYMBOL(__bitmap_shift_right);
>  
> @@ -166,7 +166,7 @@ void __bitmap_shift_left(unsigned long *dst, const unsigned long *src,
>  		dst[k + off] = lower | upper;
>  	}
>  	if (off)
> -		memset(dst, 0, off*sizeof(unsigned long));
> +		bitmap_zero(dst, off);
>  }

Same here. Cannot possibly be correct, but will work by chance for off
<= 1, i.e. shift <= BITS_PER_LONG.

Rasmus

