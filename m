Return-Path: <linux-kernel+bounces-43537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B75841543
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9092D2880F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AD1158D96;
	Mon, 29 Jan 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlGdBqWw"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E7153BC1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565331; cv=none; b=mYQ0+hP/DHV4Wf8Usr+PywIt+V/TUkznJlbv614suITaaKAmre+dAAmfXesYJQEUHuR289uq/B+t+vNeqfsHK3obZUhpl/Wjzj7E/A8N2VidTump97aOAE5kogBVhWd0YqBgKlxVam9n9Y2VuHtz6v/6Z0BCEH2y4rwFV12QYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565331; c=relaxed/simple;
	bh=7NdD/H8tYAjurziXCoF2p47JeM5paOSUvy0/RLGCJ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyDQYY7u0qABhRv2QZKC0feS/xn2JMXJJGsSyX90l2wqmtrvCtedZ4Kpluw+fxSBrphanSHXj2WU8WRRZE6YR4uliuOnntAY7CXH8R3C2kx+4vq2KtDr0UAv9e3MdjDNu7QMUc/iF0P0kP5aHqTmyXora0f4BP/5CHaHJum3LPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlGdBqWw; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-210ce33ea1aso1651409fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706565328; x=1707170128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jh17q8IcdPL2+UDpzM24U2BtO6q6Y/Xn9YtDZkPXqGg=;
        b=GlGdBqWw5E/vB6qQTlFR8ABeJNQkSoEAGhodGxfbAMp/VdMYEpYEkJnTHcO7w9AyeF
         e+ivtFWXICc8QX/I9KsRj18qCzW+fCqrdbVicNBpgTGX4R1ufJf6aGvVFED/+/AbQQjf
         48Asu0XKq8y/m5Qf9Bfawh1qlBeiSPBckxtHudNT2EEK4i1xduViF7++3jlcHRA/zaOH
         1YzYUK3XPMtC1AHo9OePOY2tenJ6yFCFzETOYVtNTudvEkqYsM3Yh3CQb/WRvgGIDAgE
         LOSfQprCHJdiMTDLW7wDsHddHRm0FTW0xWl31X8g3XW2lO4108C/zDvySW3vhDTk1JCH
         DL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706565328; x=1707170128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jh17q8IcdPL2+UDpzM24U2BtO6q6Y/Xn9YtDZkPXqGg=;
        b=cbJKExcaqdpdD4Ck9sXisVxC+1Xl6m/CA3gZAxbaNt9QP7UbTBAduB+VlBHxLW55Mi
         j3rcFCj1TvOjg/Ey6EK+qIqV8rgz+kC/LQ5YI53jzuviQiheTwDU6TTsPrPM60F8AGJW
         qAwxM4yVuEgYS1l25xR3siFyOnERgKOjjKo5dP7JN346KbVg+zz8eBiH/u+tKB1agN6C
         nzRYnhXxBhs4ADogBs83g1DWqXW7w8BjgwMCaMlNKv/E+lV2E4ZmlEHt04VMdWSrHYHT
         r7RL47oGoMlLqHmnL+bCDIFdJqSsF/f7v+/rp3HL97Y47ioHYVJeSUgyWWXBDwg78sBD
         kLUg==
X-Gm-Message-State: AOJu0YySQOMAG1sM5gOCS6XfiobjNapx8W9L/eYl5VuDaeUHXZgOBwPV
	jOu2MmX1xTqr7s+qwTs3UGpELg8c0g6d38ZqbK2yp5LCvBFS9oVmQukUBxRZUw==
X-Google-Smtp-Source: AGHT+IGWSsvQGbb3Ji0caS6I5YZQm1287kiSLKn180PnzjHWg4Z9toNVHqRFdWbDb65/G4yLEFaEHA==
X-Received: by 2002:a05:6870:4c17:b0:218:a2aa:1673 with SMTP id pk23-20020a0568704c1700b00218a2aa1673mr1177361oab.18.1706565328394;
        Mon, 29 Jan 2024 13:55:28 -0800 (PST)
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id l14-20020a056638220e00b0046e1f0f6d92sm1933199jas.76.2024.01.29.13.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:55:27 -0800 (PST)
Date: Mon, 29 Jan 2024 21:55:25 +0000
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] string: Allow 2-argument strscpy()
Message-ID: <20240129215525.4uxchtrywzzsrauc@google.com>
References: <20240129202901.work.282-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129202901.work.282-kees@kernel.org>

Hi,

On Mon, Jan 29, 2024 at 12:29:04PM -0800, Kees Cook wrote:
> Using sizeof(dst) is the overwhelmingly common case for strscpy().
> Instead of requiring this everywhere, allow a 2-argument version to be
> used that will use the sizeof() internally.

Yeah, this is definitely the case. I have a ton of patches replacing
strncpy with strscpy [1] and many of them match the pattern of:
| strscpy(dest, src, sizeof(dest))

BTW, this hack for function overloading is insane. Never really looked into
it before.

>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> What do people think of this idea? It's usually very redundant to
> include the 3rd argument, so this might improve readability (and
> perhaps make things more robust by avoiding mistakes when the
> destination name changes).

I like this, though, should you include documentation changes/additions?

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  include/linux/fortify-string.h | 4 ++--
>  include/linux/string.h         | 9 ++++++++-
>  lib/string.c                   | 4 ++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 89a6888f2f9e..56be4d4a5dea 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -215,7 +215,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
>  }
>
>  /* Defined after fortified strnlen() to reuse it. */
> -extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
> +extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(sized_strscpy);
>  /**
>   * strscpy - Copy a C-string into a sized buffer
>   *
> @@ -234,7 +234,7 @@ extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
>   * Returns the number of characters copied in @p (not including the
>   * trailing %NUL) or -E2BIG if @size is 0 or the copy of @q was truncated.
>   */
> -__FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, size_t size)
> +__FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const POS q, size_t size)
>  {
>  	/* Use string size rather than possible enclosing struct size. */
>  	const size_t p_size = __member_size(p);
> diff --git a/include/linux/string.h b/include/linux/string.h
> index ab148d8dbfc1..0bb1c8d05f18 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -67,9 +67,16 @@ extern char * strcpy(char *,const char *);
>  extern char * strncpy(char *,const char *, __kernel_size_t);
>  #endif
>  #ifndef __HAVE_ARCH_STRSCPY
> -ssize_t strscpy(char *, const char *, size_t);
> +ssize_t sized_strscpy(char *, const char *, size_t);
>  #endif
>
> +#define __strscpy0(dst, src, ...)	sized_strscpy(dst, src, sizeof(dst))
> +
> +#define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
> +
> +#define strscpy(dst, src, ...)	\
> +	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
> +
>  /* Wraps calls to strscpy()/memset(), no arch specific code required */
>  ssize_t strscpy_pad(char *dest, const char *src, size_t count);
>
> diff --git a/lib/string.c b/lib/string.c
> index 6891d15ce991..2869895a1180 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -104,7 +104,7 @@ EXPORT_SYMBOL(strncpy);
>  #endif
>
>  #ifndef __HAVE_ARCH_STRSCPY
> -ssize_t strscpy(char *dest, const char *src, size_t count)
> +ssize_t sized_strscpy(char *dest, const char *src, size_t count)
>  {
>  	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
>  	size_t max = count;
> @@ -170,7 +170,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
>
>  	return -E2BIG;
>  }
> -EXPORT_SYMBOL(strscpy);
> +EXPORT_SYMBOL(sized_strscpy);
>  #endif
>
>  /**
> --
> 2.34.1
>

[1]: https://lore.kernel.org/all/?q=f%3A%22justinstitt%40google.com%22+AND+b%3Astrscpy+AND+NOT+s%3A%22Re%22

Thanks
Justin

