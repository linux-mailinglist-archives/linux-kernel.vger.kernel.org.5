Return-Path: <linux-kernel+bounces-60171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C6850102
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58D71C25514
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D554111E;
	Sat, 10 Feb 2024 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKEBXRKe"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD885163
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524118; cv=none; b=XFhXIOFyUG4j2mnWINmSRL7DzqMOhfpRmDQDZdyX43oDucTlMh3neY5upf/PDTLVBWWYnY3Py7xEJ8M/GStZWScjq7PcCzrW5iMgyyGoY3715LHkWInYvG03faHhA0+XCKAHIAKjLZMV6PJ8rio+0iTTHlCD2YTDYTH9sRK7jvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524118; c=relaxed/simple;
	bh=LTW6g9ZRCOglVOUQlauFuhYvDqEy/Z2uN0TkWjjCMsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX3zn+qT4FDDHuf9H43PsfrLRqZfmvGu9Z5sVBIRk0hz0bssM6fnynmEXAw2Q63w17Bwp17VZsFbA1v4v21NgsgKeEajUqQQjGXTNr0OcShNDZ2EX0EAcH1Hu+7MLmOUnUVkH3a4nX+H1EaH82TlMpBeuwxhwTnYHxCGcEs4828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DKEBXRKe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d70b0e521eso11833085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707524116; x=1708128916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FiyysorK6znIgI+2wuJOTLlFRPw5jaKibjcyR06HcE=;
        b=DKEBXRKeLr/mc0lc5Du4rzurvICuOPU1810IRMtN0bRM7scw4Fn7uJzHLVPr1HWKQm
         0PQ5xE/Umq3QBmgowqbAZ3RRfJzfun8aAkxI2VDGjA690GKYexTIVbk0V0WzjkSiD3fg
         DT5j8pVFNhsrg1aPDkHZrZFTR8Fcw11OtIkIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524116; x=1708128916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FiyysorK6znIgI+2wuJOTLlFRPw5jaKibjcyR06HcE=;
        b=DzTY5AYYU8BlOvDhQxzHjCpSQ90u5ovoOHxOxWkIjokjvnoKeQ6w4zvV5vwGwoGP6D
         iFUQ7icQGrYaQART1dPBa3Y3QYks6UnjFQJDFpGYDqesT9atGGaMv6C2AfhqLjDySt74
         BVXlPAehwSw9bnFf9QVCW2QCw6uN61qzU55Jb8Za+iqUOsMrE4Pm82H6+efIrK7BgpAh
         Rl8LusgrAGii5Urc7wF2Ft0bp6Xfx3wg8bGhT6hD6dSQMdix3pShcuMn6iTqLiJ1gpOI
         yUdJc6mKW4srfb8Y8y42XKcUGAvjGpKw8d3NL27WqtQeG4Qv49J3sa6DIKusDbtbvh1N
         mxBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAjHzdOD41kUkth77TRYLMy+TMXSYkIbIZUp0l3bg8FkZp84w/kd0Os1uTvq6N/iCYyEDOI4K0iaFZVeAnIWwWcDWedv+0JzeHd4Qy
X-Gm-Message-State: AOJu0YwRCkhtYnA7XB/12TyeBLTtgiPKZAQrYE3NdBAuUI1sEmQjCISs
	QX/UktXRjK/hSwhlZSDlJ26cJDO0ZElOVFXO2ErfanqOWs3xalK3dwP4G8N9Pw==
X-Google-Smtp-Source: AGHT+IHcnc105ISBZpzkBts+vHKpOpd1JvTEF2MNZlIyBvOFYyyUrypuF9c50ZmYIR+2+QGKjRoQBQ==
X-Received: by 2002:a17:902:eb44:b0:1d8:f06a:9d68 with SMTP id i4-20020a170902eb4400b001d8f06a9d68mr809271pli.33.1707524116214;
        Fri, 09 Feb 2024 16:15:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3McYWgQ7cZ20ud+Cn7jcEJF/7usPcipggpCZVnWBKtd32PGB2zZqRgUIyt4ITla55fDqo8UHKan55fBAXEKFg1ROfB8uRTRzLwa1sNU4tJxBo0VjG+9sBKtH0PJYVSXe9ozJ/AtutXRyL+Xivg/6nwMkqJHA9y/r1rKAfyuhLjBcTYQujC92CbVNoGt+I5yCMzAJJdEId8QLBXQ3eF7Qhqg8hpQMMFFe7V4MfN9OSTTIgk1m/tfu+myOJSZ8tVjO+mhzMCTaUFD8nSSfzqHuoXbnf6uWouHYVsU/EB7fjSg88ocDUUAqkJmnZ40JHOPrOkNvg/TblR1oOZKGHCP5VyT6FKB4CHB+gE8SgnRy1WtVVEDYmFXVeAXLbC86hrH31Km/GYpmr1lNpZX34SoEMJ9m+ORKCvAIoSVETp8+2VAIuVcXetdq1qIeyteAujaZ04s9bPLcN6x/17445pCgYs17+Z48cqO+9+6zCFZhX4sfI4WVzjzUgzGHNg8eSBvttQnF3DNrYzd6xChoiU9jRG62R53fxLlXXJheu/703VriKzLz30fI1tTaQ4vM0//nf88lrQZ5ViE4P6LfUIYtgCTeuCCXWhiNTxj8OX7U1MiJSUftkkIu2sm6YTlLbQ/lexrG/VYS6Vra0YXaoPcBUObjuGr84Csc+tPqKXu5NQTfHpScpjrQ=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lo12-20020a170903434c00b001d9ed86a298sm2058495plb.137.2024.02.09.16.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:15:15 -0800 (PST)
Date: Fri, 9 Feb 2024 16:15:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 2/4] uaccess: always export _copy_[from|to]_user with
 CONFIG_RUST
Message-ID: <202402091606.A181673F0A@keescook>
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
 <20240208-alice-mm-v2-2-d821250204a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-alice-mm-v2-2-d821250204a6@google.com>

On Thu, Feb 08, 2024 at 03:47:52PM +0000, Alice Ryhl wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Rust code needs to be able to access _copy_from_user and _copy_to_user
> so that it can skip the check_copy_size check in cases where the length
> is known at compile-time, mirroring the logic for when C code will skip
> check_copy_size. To do this, we ensure that exported versions of these
> methods are available when CONFIG_RUST is enabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  include/linux/uaccess.h | 37 +++++++++++++++++++++++--------------
>  lib/usercopy.c          | 30 ++++--------------------------
>  2 files changed, 27 insertions(+), 40 deletions(-)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 3064314f4832..835aa175d0ee 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -138,13 +138,18 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
>  	return raw_copy_to_user(to, from, n);
>  }
>  
> -#ifdef INLINE_COPY_FROM_USER
>  static inline __must_check unsigned long
> -_copy_from_user(void *to, const void __user *from, unsigned long n)
> +_inline_copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
>  	unsigned long res = n;
>  	might_fault();
>  	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
> +		/*
> +		 * Ensure that bad access_ok() speculation will not
> +		 * lead to nasty side effects *after* the copy is
> +		 * finished:
> +		 */
> +		barrier_nospec();

This means all callers just gained this barrier. That's a behavioral
change -- is it intentional here? I don't see it mentioned in the commit
log.

Also did this get tested with the CONFIG_TEST_USER_COPY tests? I would
expect it to be fine, but better to check and mention it in the commit
log.

-Kees

>  		instrument_copy_from_user_before(to, from, n);
>  		res = raw_copy_from_user(to, from, n);
>  		instrument_copy_from_user_after(to, from, n, res);
> @@ -153,14 +158,11 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
>  		memset(to + (n - res), 0, res);
>  	return res;
>  }
> -#else
>  extern __must_check unsigned long
>  _copy_from_user(void *, const void __user *, unsigned long);
> -#endif
>  
> -#ifdef INLINE_COPY_TO_USER
>  static inline __must_check unsigned long
> -_copy_to_user(void __user *to, const void *from, unsigned long n)
> +_inline_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
>  	might_fault();
>  	if (should_fail_usercopy())
> @@ -171,25 +173,32 @@ _copy_to_user(void __user *to, const void *from, unsigned long n)
>  	}
>  	return n;
>  }
> -#else
>  extern __must_check unsigned long
>  _copy_to_user(void __user *, const void *, unsigned long);
> -#endif
>  
>  static __always_inline unsigned long __must_check
>  copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> -	if (check_copy_size(to, n, false))
> -		n = _copy_from_user(to, from, n);
> -	return n;
> +	if (!check_copy_size(to, n, false))
> +		return n;
> +#ifdef INLINE_COPY_FROM_USER
> +	return _inline_copy_from_user(to, from, n);
> +#else
> +	return _copy_from_user(to, from, n);
> +#endif
>  }
>  
>  static __always_inline unsigned long __must_check
>  copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> -	if (check_copy_size(from, n, true))
> -		n = _copy_to_user(to, from, n);
> -	return n;
> +	if (!check_copy_size(from, n, true))
> +		return n;
> +
> +#ifdef INLINE_COPY_TO_USER
> +	return _inline_copy_to_user(to, from, n);
> +#else
> +	return _copy_to_user(to, from, n);
> +#endif
>  }
>  
>  #ifndef copy_mc_to_kernel
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index d29fe29c6849..de7f30618293 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -7,40 +7,18 @@
>  
>  /* out-of-line parts */
>  
> -#ifndef INLINE_COPY_FROM_USER
> +#if !defined(INLINE_COPY_FROM_USER) || defined(CONFIG_RUST)
>  unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> -	unsigned long res = n;
> -	might_fault();
> -	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
> -		/*
> -		 * Ensure that bad access_ok() speculation will not
> -		 * lead to nasty side effects *after* the copy is
> -		 * finished:
> -		 */
> -		barrier_nospec();
> -		instrument_copy_from_user_before(to, from, n);
> -		res = raw_copy_from_user(to, from, n);
> -		instrument_copy_from_user_after(to, from, n, res);
> -	}
> -	if (unlikely(res))
> -		memset(to + (n - res), 0, res);
> -	return res;
> +	return _inline_copy_from_user(to, from, n);
>  }
>  EXPORT_SYMBOL(_copy_from_user);
>  #endif
>  
> -#ifndef INLINE_COPY_TO_USER
> +#if !defined(INLINE_COPY_TO_USER) || defined(CONFIG_RUST)
>  unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> -	might_fault();
> -	if (should_fail_usercopy())
> -		return n;
> -	if (likely(access_ok(to, n))) {
> -		instrument_copy_to_user(to, from, n);
> -		n = raw_copy_to_user(to, from, n);
> -	}
> -	return n;
> +	return _inline_copy_to_user(to, from, n);
>  }
>  EXPORT_SYMBOL(_copy_to_user);
>  #endif
> 
> -- 
> 2.43.0.594.gd9cf4e227d-goog
> 

-- 
Kees Cook

