Return-Path: <linux-kernel+bounces-43544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE3D841557
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AAF285B35
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B931E15956A;
	Mon, 29 Jan 2024 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e/c0xJXo"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36688604C5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565778; cv=none; b=GE0q6A+V05dtovXA/ephcZJL8khsq5q+QOauzm8R+hwnrgl2NU9PbLsY3fSk42+cDD1OA2Co5D65DnwEgcxpHTSGbHNLqNnecjNRfSMPp5edGsJ97npz+knx8REfR7PGD45oTpByQ4LzcAM4GbxwfAw5fBiaUDkIc5z9EOZxwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565778; c=relaxed/simple;
	bh=MW/5ZCjJ37qSeWHAtt0SmK5TN0mf0X1NxMCMQONYebk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmIYfqyEDI9bWoASme2f52XIA7Re6HKMOFcYR0VsxylBXlVf45AWj3cXdN0A0/3Bw0z0MOb8S1CktBOvm0WVUVyyW9oU9MJjqruKyMaCR8xjqdFIYaP4Cv6PMAiozMMLcbdY0papx5LpAufFvTki/RmZIb/6zFj/4c0DPQubL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e/c0xJXo; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59a0f490312so896844eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706565776; x=1707170576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol2CXx93aKg4WCXAQoWOfpsSTkl3lWgAytlfeS6JK5g=;
        b=e/c0xJXoHPd59RDwEH1yQcDrFchl3xFTSEhHaCCPmKkDlIdXEeg+ptTnZwR8NvZY+C
         n14HqRC3yFExxdqYAK6+LiITkqA4OHIX5dW0AMmksj96Hqx+NbPL/T4UgoVDA0JbWEZh
         9Vp0PJJcw80+KOz/kGXOAdyJSzi8UowipEyqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706565776; x=1707170576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ol2CXx93aKg4WCXAQoWOfpsSTkl3lWgAytlfeS6JK5g=;
        b=VBEbQL/2Rm1sMjOPybITfT81/TnNeWda43W747F/TFQlxzoP06OyzW3Byb6K3cdFdV
         lhfAIzKgplSSSiVFm3mf2/dOd6K8s4JJkClwC2yC3B2rA/9fhUXYu8jzOe4U7IxKd8rh
         O5oTKnYeabZldOd3bzXCGc2eSrd01OzvUGvs3o6tpABcfKBg7cp0VvdfPf7Zg/UnCZS/
         KjMOxlpzn8lZ8gYOSsV3MYZkTN0HWwsx9YzpH3Aex+jYfWkLgTA4j6pdZBtJaDcXuQP7
         wx/MCs17XtqW4l+iYbF2q1SbIISnrmjYGLNPcX17O/R9ztruhRHP9erSh0M544BZhYpN
         kpjw==
X-Gm-Message-State: AOJu0YyuZPF9ii8iroFGGcQSNtFYogMtYnGDhmhAzgi+UNaKiqUgGAd2
	g1WRebz6GdavaQmTDNFMqtWhDudCTCDQia9uh+VHO/4x7AfY76/0lOiDUCVbEQ==
X-Google-Smtp-Source: AGHT+IFsutnZlHnSpy1EV22HSoguu9M4O1lGXRQNALJKbsNXTVK5tbe3AinhAdaNuxbaT0oXSl1U6Q==
X-Received: by 2002:a05:6358:180c:b0:178:60fa:d700 with SMTP id u12-20020a056358180c00b0017860fad700mr2442904rwm.12.1706565776148;
        Mon, 29 Jan 2024 14:02:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b6-20020a62cf06000000b006dbdb5946d7sm6641686pfg.6.2024.01.29.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:02:55 -0800 (PST)
Date: Mon, 29 Jan 2024 14:02:55 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] string: Allow 2-argument strscpy()
Message-ID: <202401291357.DAA9670F3@keescook>
References: <20240129202901.work.282-kees@kernel.org>
 <20240129215525.4uxchtrywzzsrauc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129215525.4uxchtrywzzsrauc@google.com>

On Mon, Jan 29, 2024 at 09:55:25PM +0000, Justin Stitt wrote:
> Hi,
> 
> On Mon, Jan 29, 2024 at 12:29:04PM -0800, Kees Cook wrote:
> > Using sizeof(dst) is the overwhelmingly common case for strscpy().
> > Instead of requiring this everywhere, allow a 2-argument version to be
> > used that will use the sizeof() internally.
> 
> Yeah, this is definitely the case. I have a ton of patches replacing
> strncpy with strscpy [1] and many of them match the pattern of:
> | strscpy(dest, src, sizeof(dest))
> 
> BTW, this hack for function overloading is insane. Never really looked into
> it before.

It very much is. :P Hence the RFC nature of this patch. I don't think we
any any other API in the kernel that does this (though there are plenty
of wild macro wrappers to do similar tricks, like the syscall wrappers).

> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > What do people think of this idea? It's usually very redundant to
> > include the 3rd argument, so this might improve readability (and
> > perhaps make things more robust by avoiding mistakes when the
> > destination name changes).
> 
> I like this, though, should you include documentation changes/additions?

Yeah, though I'm not sure how to do this -- kerndoc expects a fixed
number of arguments. :P Maybe I can just do something like add
"optional" to @size:

 * strscpy - Copy a C-string into a sized buffer
 * @p: Where to copy the string to
 * @q: Where to copy the string from
 * @size: Size of destination buffer (optional)

> 
> Reviewed-by: Justin Stitt <justinstitt@google.com>
> 
> > ---
> >  include/linux/fortify-string.h | 4 ++--
> >  include/linux/string.h         | 9 ++++++++-
> >  lib/string.c                   | 4 ++--
> >  3 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> > index 89a6888f2f9e..56be4d4a5dea 100644
> > --- a/include/linux/fortify-string.h
> > +++ b/include/linux/fortify-string.h
> > @@ -215,7 +215,7 @@ __kernel_size_t __fortify_strlen(const char * const POS p)
> >  }
> >
> >  /* Defined after fortified strnlen() to reuse it. */
> > -extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
> > +extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(sized_strscpy);
> >  /**
> >   * strscpy - Copy a C-string into a sized buffer
> >   *
> > @@ -234,7 +234,7 @@ extern ssize_t __real_strscpy(char *, const char *, size_t) __RENAME(strscpy);
> >   * Returns the number of characters copied in @p (not including the
> >   * trailing %NUL) or -E2BIG if @size is 0 or the copy of @q was truncated.
> >   */
> > -__FORTIFY_INLINE ssize_t strscpy(char * const POS p, const char * const POS q, size_t size)
> > +__FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const POS q, size_t size)
> >  {
> >  	/* Use string size rather than possible enclosing struct size. */
> >  	const size_t p_size = __member_size(p);
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index ab148d8dbfc1..0bb1c8d05f18 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -67,9 +67,16 @@ extern char * strcpy(char *,const char *);
> >  extern char * strncpy(char *,const char *, __kernel_size_t);
> >  #endif
> >  #ifndef __HAVE_ARCH_STRSCPY
> > -ssize_t strscpy(char *, const char *, size_t);
> > +ssize_t sized_strscpy(char *, const char *, size_t);
> >  #endif
> >
> > +#define __strscpy0(dst, src, ...)	sized_strscpy(dst, src, sizeof(dst))

In thinking about this slightly longer, I realize that the size may be
better as: sizeof(dst) + __must_be_array(dst)

otherwise a "char *" will be allowed as a dst for the 2-arg method, and
will get a 1 byte size. :)

> > +
> > +#define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
> > +

And I should probably relocate the kern-doc to here...

> > +#define strscpy(dst, src, ...)	\
> > +	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
> > +
> >  /* Wraps calls to strscpy()/memset(), no arch specific code required */
> >  ssize_t strscpy_pad(char *dest, const char *src, size_t count);
> >
> > diff --git a/lib/string.c b/lib/string.c
> > index 6891d15ce991..2869895a1180 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -104,7 +104,7 @@ EXPORT_SYMBOL(strncpy);
> >  #endif
> >
> >  #ifndef __HAVE_ARCH_STRSCPY
> > -ssize_t strscpy(char *dest, const char *src, size_t count)
> > +ssize_t sized_strscpy(char *dest, const char *src, size_t count)
> >  {
> >  	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
> >  	size_t max = count;
> > @@ -170,7 +170,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
> >
> >  	return -E2BIG;
> >  }
> > -EXPORT_SYMBOL(strscpy);
> > +EXPORT_SYMBOL(sized_strscpy);
> >  #endif
> >
> >  /**
> > --
> > 2.34.1
> >
> 
> [1]: https://lore.kernel.org/all/?q=f%3A%22justinstitt%40google.com%22+AND+b%3Astrscpy+AND+NOT+s%3A%22Re%22
> 
> Thanks
> Justin

-- 
Kees Cook

