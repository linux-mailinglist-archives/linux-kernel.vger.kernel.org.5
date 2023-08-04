Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3783C76F98B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 07:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjHDF1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 01:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjHDF0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:26:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B9E524D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 22:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Kd5bIJRcZl2FvBcfi7bDth6ZcrHschPde64PUN3D7jE=; b=RhP2tFXUIDm82hXXXEjAidNHuZ
        CpWjMlOwtUah2m6Rbp9JbF9o/L2VfvmMZL3fBMOqeWv0IxvGEmA5y6bm5nZPlXSkJE756PpyLc+r7
        ru26IcYQUG0Ou/GXmboGyZuPDAxiiTcEcFXczN7MhiwPUSznDLmasC5jA1tnhOD/BtJPw63XKtNbJ
        Ah97w0sAqoUYR0KY1seS1qoma0IvCVLCTRzft5lt4XGk0vytWj2XKSV/U8RuHO+G0Hcem3f8dinlK
        IbGKTuHtJQaxTWbhRgsY7mZtzadIdVz/AFpBY+wNCJ0fWxjZXlNKU6TVDHVxtvV3ByhUD52njBkl3
        AeffetEw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRnHx-00BbHA-0V;
        Fri, 04 Aug 2023 05:23:49 +0000
Message-ID: <a1640e13-75b5-bc3c-74a6-5eaf6d74e7bc@infradead.org>
Date:   Thu, 3 Aug 2023 22:23:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] math.h: Document abs_diff()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
References: <20230804050934.83223-1-andriy.shevchenko@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230804050934.83223-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 22:09, Andy Shevchenko wrote:
> Initially abs_diff() has lack of documentation. Add it.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/math.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/math.h b/include/linux/math.h
> index 336e3e3678e7..dfba59b59998 100644
> --- a/include/linux/math.h
> +++ b/include/linux/math.h
> @@ -155,6 +155,18 @@ __STRUCT_FRACT(u32)
>  	__builtin_types_compatible_p(typeof(x), unsigned type),		\
>  	({ signed type __x = (x); __x < 0 ? -__x : __x; }), other)
>  
> +/**
> + * abs_diff - return absolute value of the difference between the arguments
> + * @a: the first argument
> + * @b: the second argument
> + *
> + * @a and @b has to be of the same type. With this restriction we compare

Preferably s/has/have/.

> + * signed to signed and unsigned to unsigned. The result is the subtraction
> + * the smaller of the two from the bigger, hence result is always a positive
> + * value.
> + *
> + * Return: an absolute value of the difference between the @a and @b.
> + */
>  #define abs_diff(a, b) ({			\
>  	typeof(a) __a = (a);			\
>  	typeof(b) __b = (b);			\

-- 
~Randy
