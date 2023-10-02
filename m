Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC137B58E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjJBRd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjJBRdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:33:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDA6AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:33:52 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c5cd27b1acso372255ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696268032; x=1696872832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rRb6SjgSwWAACsZX0/4Czm5+jXbNVrlYY55MOVJCmE=;
        b=FlGqQZK4kcphn/IjeIEJMF6zCP7rSj+D8uTj1LYNTWnJ//mOT2k8gevqYspkf1g/Js
         akTjRKv1UutKHazO7q+eVKWMKYecBYSHstIik+QRhvHpYXXtY58wOT0fhjLQY9q194kP
         ++6j7Ah2Y7+fmV4ZKVBXnnx2RJeBtkjfyOREU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268032; x=1696872832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rRb6SjgSwWAACsZX0/4Czm5+jXbNVrlYY55MOVJCmE=;
        b=Bu+P+0jslE1UlXcYPyldwmAuZfK1ERe3KWutcFVij82pEEFm7R1Kjd12Y/5EwwX1Ay
         Q7MhAeu/hkZODpVMnj1L2nXrXC6PO1w+3i7BXySUEAm2VDhD4ywXHLQq7o2CNKDbJxHb
         fXMplp1GkKYfXRa6WDdbMyknKjUVMy2M75SM00nr2cwoOsvBKm0dAeUUPMbJTxZtgiGa
         HgX3JGIpvGrP5T3R8/gwlWxzrBpisLNcgNxLJ4vz9A0sAnVPJgS8agSgWYzQeYvd0XUm
         cFIRu9MMlqhcivLtZbBcWDur4nrY+ARivvLeXwgxEIL/wIZKm+ld+cPMW6gDuL+tv0cA
         wNZQ==
X-Gm-Message-State: AOJu0YxY3//MmToEunz0oTCH/CkjhthVw/wshjT1ViBwllCZKnjCkOHy
        vt3akSrFP5mo83WO01Y4o7Y4MQ==
X-Google-Smtp-Source: AGHT+IGRCML+r2Jip9vCDGfd1NGpA5p6h4nQxL00b7LD3Gc92A7E2BFJlmHz7gXdkSag+UNANxGkkw==
X-Received: by 2002:a17:902:d508:b0:1c6:1733:fb3f with SMTP id b8-20020a170902d50800b001c61733fb3fmr14128485plg.49.1696268032303;
        Mon, 02 Oct 2023 10:33:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902ed4d00b001c60d0a6d84sm16188290plb.127.2023.10.02.10.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:33:51 -0700 (PDT)
Date:   Mon, 2 Oct 2023 10:33:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] extract and use FILE_LINE macro
Message-ID: <202310021033.A5F0159F25@keescook>
References: <ebf12ac4-5a61-4b12-b8b0-1253eb371332@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf12ac4-5a61-4b12-b8b0-1253eb371332@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 09:21:31PM +0300, Alexey Dobriyan wrote:
> Extract nifty FILE_LINE useful for printk style debugging:
> 
> 	printk("%s\n", FILE_LINE);
> 
> 
> It should not be used en mass probably because __FILE__ string literals
> can be merged while FILE_LINE's won't. But for debugging it is what
> the doctor ordered.
> 
> Don't add leading and trailing underscores, they're painful to type.
> Trust me, I've tried both versions.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  include/linux/fortify-string.h |    2 +-
>  include/linux/stringify.h      |    2 ++
>  include/linux/timer.h          |    3 +--
>  sound/pci/asihpi/hpidebug.h    |    9 ++++-----
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -643,7 +643,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>  				     __q_size_field, #op),		\
>  		  #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
>  		  __fortify_size,					\
> -		  "field \"" #p "\" at " __FILE__ ":" __stringify(__LINE__), \
> +		  "field \"" #p "\" at " FILE_LINE,			\
>  		  __p_size_field);					\
>  	__underlying_##op(p, q, __fortify_size);			\
>  })
> --- a/include/linux/stringify.h
> +++ b/include/linux/stringify.h
> @@ -9,4 +9,6 @@
>  #define __stringify_1(x...)	#x
>  #define __stringify(x...)	__stringify_1(x)
>  
> +#define FILE_LINE	__FILE__ ":" __stringify(__LINE__)
> +
>  #endif	/* !__LINUX_STRINGIFY_H */
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
> @@ -77,8 +77,7 @@ struct timer_list {
>  		.entry = { .next = TIMER_ENTRY_STATIC },	\
>  		.function = (_function),			\
>  		.flags = (_flags),				\
> -		__TIMER_LOCKDEP_MAP_INITIALIZER(		\
> -			__FILE__ ":" __stringify(__LINE__))	\
> +		__TIMER_LOCKDEP_MAP_INITIALIZER(FILE_LINE)	\
>  	}
>  
>  #define DEFINE_TIMER(_name, _function)				\
> --- a/sound/pci/asihpi/hpidebug.h
> +++ b/sound/pci/asihpi/hpidebug.h
> @@ -29,16 +29,15 @@ enum { HPI_DEBUG_LEVEL_ERROR = 0,	/* always log errors */
>     the start of each message, eg see linux kernel hpios.h */
>  
>  #ifdef SOURCEFILE_NAME
> +#undef FILE_LINE
>  #define FILE_LINE  SOURCEFILE_NAME ":" __stringify(__LINE__) " "

Should this drop the trailing " " to match the new macro?

-Kees

> -#else
> -#define FILE_LINE  __FILE__ ":" __stringify(__LINE__) " "
>  #endif
>  
>  #define HPI_DEBUG_ASSERT(expression) \
>  	do { \
>  		if (!(expression)) { \
>  			printk(KERN_ERR  FILE_LINE \
> -				"ASSERT " __stringify(expression)); \
> +				" ASSERT " __stringify(expression)); \
>  		} \
>  	} while (0)
>  
> @@ -46,7 +45,7 @@ enum { HPI_DEBUG_LEVEL_ERROR = 0,	/* always log errors */
>  	do { \
>  		if (hpi_debug_level >= HPI_DEBUG_LEVEL_##level) { \
>  			printk(HPI_DEBUG_FLAG_##level \
> -			FILE_LINE  __VA_ARGS__); \
> +			FILE_LINE " " __VA_ARGS__); \
>  		} \
>  	} while (0)
>  
> @@ -70,7 +69,7 @@ void hpi_debug_data(u16 *pdata, u32 len);
>  	do { \
>  		if (hpi_debug_level >= HPI_DEBUG_LEVEL_##level) { \
>  			hpi_debug_message(phm, HPI_DEBUG_FLAG_##level \
> -				FILE_LINE __stringify(level)); \
> +				FILE_LINE " " __stringify(level)); \
>  		} \
>  	} while (0)
>  

-- 
Kees Cook
