Return-Path: <linux-kernel+bounces-108270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA249880898
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D261C2289E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97825A3F;
	Wed, 20 Mar 2024 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUHgELVC"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AB4C90
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894933; cv=none; b=DzcEl8sEdV6v8FdBF53DoVGw5UIQT+qnpPogrXYyR4fAGUB820NxK5sQWftU8dVKZtgYSfZ/o8F2Lls/BiYzWPl4emotxn7LT+pcn2gM9djbI94VKIkdQ0AQzXWIgxX4zKevDvy6CnRXNLtHDmooGkHpuhcV/XCAeuVQYCoix80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894933; c=relaxed/simple;
	bh=1o1U/hYDLGxcTlL8MA5lcT+IV4KO9u5uC4rIDNmOgk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrXFQ/RLiaiAiEbe9YxTa9d1NJYBCBmW8LCH66+jd2rZxbegNuLunv8DC127bpFdO/2knkHBPrZiJui51V7AgRB/kRxXTGbyPoBWR5u0vN9EyH4qXmakusnojofyWq6guJ8jVBl25PPicvRfofBFktN6S/WRSD5/8AWJQCuyRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WUHgELVC; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c8b777ff8bso157074039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710894930; x=1711499730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iivMpJVqhfyzonHOxre7J+bRKHRX9ehBdH0rm4sUurE=;
        b=WUHgELVC1AUjL/5vOlXKtEl4H51fIg+3uBRF+lX8fyz45oRlUA4RCAwmo08GVz6L+m
         tpncx3bUTh+E4yBfk4diddflMbIrb9/ZFRUrDjM0UJBfg37XjVI2ELMvGibBUxSvgiUH
         GH097XxMJvAkedwGwl3pTqgFEp8i7wi6XUsLkwEwmj5L3sWDIKDc8d/E37zfCUafPA8R
         5UuOMCwDGHWZjpjArxK4hoGMfPxy5zBlsLfP0D9d1WVI6CPC/C1R2KDsMHfEyRBRyO1k
         UtcL/xap0ESLkWMOsq0q4tcyf4hsMmAri9CD71sg9tE9woClIglhfunSd60nwHELPgXE
         kbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710894930; x=1711499730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iivMpJVqhfyzonHOxre7J+bRKHRX9ehBdH0rm4sUurE=;
        b=Ps5Hrrb0cpHVRaMUHiajHWLJ5oD5La/ZWeGutOCubBIBCO2rfYe9fKIzp1g2m0laFD
         nB4lxca82EIx/tyrxi2nAZ+mAM2EpT+h7zD8JWiDFb2wh/odIvxHPJeurRiMB6gdqYPd
         VmEhSH0NdnOCYjvBdWE0/B/LVgzjNQS9z9mP91exo9HFuoUQuyeQ2tOkYJPD77/C7JuQ
         evreS8br6yWdHrDe3J5baUuTMeaKPiUn49QvH4B8U9MK+76BzOyIQde1WVWA5BMfE1Ib
         IN0/TQ6uP3MHvM6PZsqIM+K8Ms+g4k6cYwQ9qmNaoK7QZJLNOdQ+IfUe0oCCIQi7Ihda
         OvCw==
X-Forwarded-Encrypted: i=1; AJvYcCUsfBMjJdJUNfZ+XzIJB88t7v1pTRnVp6FXQybCOCA0BKOHxHTr0nzmlpyEfvsmS2JeGcdtaQRdaEgRaGywwZ5/CZvMJgVezNMpoHoJ
X-Gm-Message-State: AOJu0YwBMJaztgqvEQd4eQTB46o9nYfBrk6kk0UPQrIw4Yv6snThwG87
	XV9pQ5oMLQxZ/FH82vIhE8e8YSazRJ+rl21phqtfRnnt+L7mGNuVh5BHNypONg==
X-Google-Smtp-Source: AGHT+IHL5M1Y99f/4ysXVs8RyF/LnwoomQGXivL3Tqb5JP1fIdQh86qmd50vXgbwJFBJRpBWgsNT+Q==
X-Received: by 2002:a6b:7119:0:b0:7cc:7d9f:b659 with SMTP id q25-20020a6b7119000000b007cc7d9fb659mr4478105iog.12.1710894930542;
        Tue, 19 Mar 2024 17:35:30 -0700 (PDT)
Received: from google.com (26.103.132.34.bc.googleusercontent.com. [34.132.103.26])
        by smtp.gmail.com with ESMTPSA id w13-20020a6bf00d000000b007cbfbda1bd5sm2588952ioc.53.2024.03.19.17.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 17:35:29 -0700 (PDT)
Date: Wed, 20 Mar 2024 00:35:25 +0000
From: Justin Stitt <justinstitt@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, ndesaulniers@google.com, morbo@google.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Subject: Re: [PATCH 1/2] compiler_types: Ensure __diag_clang() is always
 available
Message-ID: <qn6cklc5fvjg4cnvavyncj73qmc6k5eyzrmpqsrkpaihi35per@3k2sodhtlcnt>
References: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
 <20240319-tracing-fully-silence-wstring-compare-v1-1-81adb44403f5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-tracing-fully-silence-wstring-compare-v1-1-81adb44403f5@kernel.org>

Hi,

On Tue, Mar 19, 2024 at 09:07:52AM -0700, Nathan Chancellor wrote:
> Attempting to use __diag_clang() and build with GCC results in a build
> error:
> 
>   include/linux/compiler_types.h:468:38: error: 'ignore' undeclared (first use in this function); did you mean 'inode'?
>     468 |         __diag_ ## compiler(version, ignore, option)
>         |                                      ^~~~~~
> 
> This error occurs because __diag_clang() is only defined in
> compiler-clang.h, which is only included when using clang as the
> compiler. This error has not been seen before because __diag_clang() has
> only been used in __diag_ignore_all(), which is defined in both
> compiler-clang.h and compiler-gcc.h.
> 
> Add an empty stub for __diag_clang() in compiler_types.h, so that it is
> always defined and just becomes a no-op when using GCC.
> 
> Fixes: f014a00bbeb0 ("compiler-clang.h: Add __diag infrastructure for clang")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  include/linux/compiler_types.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 3e64ec0f7ac8..fb0c3ff5497d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -461,6 +461,10 @@ struct ftrace_likely_data {
>  #define __diag_GCC(version, severity, string)
>  #endif
>  
> +#ifndef __diag_clang
> +#define __diag_clang(version, severity, string)
> +#endif
> +
>  #define __diag_push()	__diag(push)
>  #define __diag_pop()	__diag(pop)
>  
> 
> -- 
> 2.44.0

Thanks
Justin

