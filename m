Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C3C7510EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGLTFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGLTFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:05:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A241BF8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:05:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6687446eaccso6545220b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689188735; x=1691780735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9bU+fRF6x4YdBE9Cc80fX0ZMXBlJsLMV0Bk7zaDMBG0=;
        b=NgBEjBP3fB2u+/3TnxSFEAX9s0FffbnO0wWLqZ7FQ449iNgFQtDYLhZFbp/xCO3SzB
         3YXuS7+98WixkG1bYz7vKVjJyYKvXaIH2hd2WZnMJr2/UYmUA0cosDCk3WS/giw+4Hq0
         XhVEt3aq/hwBDCM6Dn9zDLQCmlfi2brWzihGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689188735; x=1691780735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bU+fRF6x4YdBE9Cc80fX0ZMXBlJsLMV0Bk7zaDMBG0=;
        b=esAIBnN++uk89k1lsy14yTyeHMsvotYPG7eHM/hBOxUBItfnw057XDn/HMDtPk2xMz
         /1ItvvulHOBM2zjrZwZ1gb6vlkeJON48+mhY6OgMicMRn1s0ne+3MSIeFYGggwUl8eY9
         fVVQSLKJELkD6a6tide3E9247U6aW5WFfBn1ton4uUS4p3Ii5mVCGxiCxDzodHOugSPa
         ybtKpmZHiJ83evhD7eQh/yAgLI8TbRo1hmWrqCr+IpK/rIT96xoPIS+ldAH9dXNqNTJT
         1DOTnrE9ZAh9mn1fLAbTBikC4Kbj2AQCmIP/lwalgrRt6m98mYH2TgjgKBoePwgUsJgT
         vIzw==
X-Gm-Message-State: ABy/qLayehadUfFvyuMVl7Sc9MehKrn838iyHTGAYi1BP4dV17m/TxPd
        Y5z6YTvEWPCCqdYECRmRlb1pDZMBCb0cBYA2XTg=
X-Google-Smtp-Source: APBJJlGdfMhp/TGuNABeTjXEyYXOW37cNA5c+0SckjoOkSvUUZxRDlC9M1Vtjhajx9DaSwQJ+kNdRA==
X-Received: by 2002:a05:6a00:3907:b0:682:4c1c:a0f6 with SMTP id fh7-20020a056a00390700b006824c1ca0f6mr22784484pfb.3.1689188735674;
        Wed, 12 Jul 2023 12:05:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g19-20020aa78753000000b00663b712bfbdsm3961286pfo.57.2023.07.12.12.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:05:35 -0700 (PDT)
Date:   Wed, 12 Jul 2023 12:05:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] udf: Fix -Wstringop-overflow warnings
Message-ID: <202307121204.36EF4C1@keescook>
References: <ZK7wKS0NgZPfqrZu@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK7wKS0NgZPfqrZu@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:25:45PM -0600, Gustavo A. R. Silva wrote:
> Use unsigned type in call to macro mint_t(). This avoids confusing the
> compiler about possible negative values that would cause the value in
> _len_ to wrap around.
> 
> Fixes the following -Wstringop-warnings seen when building ARM
> architecture with allyesconfig (GCC 13):
> fs/udf/directory.c: In function 'udf_copy_fi':
> include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
>    57 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
>   648 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>   693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> fs/udf/directory.c:99:9: note: in expansion of macro 'memcpy'
>    99 |         memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
>       |         ^~~~~~
> include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' specified bound between 2147483648 and 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
>    57 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
>   648 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>   693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> fs/udf/directory.c:99:9: note: in expansion of macro 'memcpy'
>    99 |         memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
>       |         ^~~~~~
>   AR      fs/udf/built-in.a
> 
> This helps with the ongoing efforts to globally enable
> -Wstringop-overflow.
> 
> Link: https://github.com/KSPP/linux/issues/329
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/udf/directory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index 1c775e072b2f..93153665eb37 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -95,7 +95,7 @@ static int udf_copy_fi(struct udf_fileident_iter *iter)
>  	}
>  
>  	off = iter->pos & (blksize - 1);
> -	len = min_t(int, sizeof(struct fileIdentDesc), blksize - off);
> +	len = min_t(u32, sizeof(struct fileIdentDesc), blksize - off);
>  	memcpy(&iter->fi, iter->bh[0]->b_data + off, len);
>  	if (len < sizeof(struct fileIdentDesc))
>  		memcpy((char *)(&iter->fi) + len, iter->bh[1]->b_data,

len is u32, "off" can't be less than blksize, so this all looks correct
to me. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
