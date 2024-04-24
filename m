Return-Path: <linux-kernel+bounces-157787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5E28B1630
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316572810E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB116DEA4;
	Wed, 24 Apr 2024 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kx+gIttH"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11A23BE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997933; cv=none; b=Ai38brRmrnsy9HjJNSjyNzpUcTj37Vwr1OPvAxcy9esFhtRDUEFA/zeMY3a5MB87sXwU0DQBZX8ibq1WqL9htDJzNF7iOekgXcEmts16Tjlfyga4Pt76PsHh2lfgSAiPGoQut6fc0VkUh2AgDJvXOmINmPw0joQQXTfEhPwPOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997933; c=relaxed/simple;
	bh=uvZEBkA/MPyDoHJ5/C9wqvZpYhJJlinnsxmUnLpv1is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g34USzUlHnHerV0Bff2oSYU8lXkI7iLzz01Dz97e0Lqj9sFW8nctcw3Xtp4UOWQD6QrbdGfVtdiH1eaotdBy5IpMrPW3xtxTkuv7vkwAz/vKzZG6JqWEQgfRTHA2vUfNlgzW0oYu8g1lWyVIa/kFQMgxStikuqAv1VUUkIh2i68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kx+gIttH; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso365591b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713997931; x=1714602731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W5XW2EeZa2xzGai521vbraJwVDegbnZlLcrpCRyHG1Q=;
        b=Kx+gIttHeoiuuNGI10tI2jPgH1H8bQ7BfIHaBcOV8UOYyeTtHrs8UQMluz7MU8wM1F
         ZvgJCsx7aSoDHM/eTD9ildmKsGHa/e6MBoQd7JRT28WJMVM6YcmX6d4Rav84A1cw9uxJ
         Bhfh6uqIyrvSLAbvl8S8KKLnlVyNOgdQQHu1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713997931; x=1714602731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5XW2EeZa2xzGai521vbraJwVDegbnZlLcrpCRyHG1Q=;
        b=pO4bY/uU7MY+Sxj4XXazNPtUlfFEEgaVG3G/j519XJx0g+gwJ7JVg4luJYbtVpNQKp
         I/OWB8ek4KVK5ny2EJaoHPhYH11axkEYe2jIo1g2i9NDwUbz9z1CN1Ex997KoSDrI1n9
         9X/SzJLJMuptQoV8dYjNn6EaZ9IozjjnSCLDUWaWI4qQgEuZ/2c1X91vnY04A/6qCAks
         06AI+RaFXcmjv57Xa9zrGcl/z5J6QDgRNwfxpmTXiKrv7bZrH5sj8aT/A43e05UuSCHx
         veVhK4/h/p1Psaqh8+FOxqBThm88PXeH8lOIRtFlBQpTKXZyILz7DJC6wHxslHLeUWn7
         97YA==
X-Forwarded-Encrypted: i=1; AJvYcCVMECEfGEk/Z4eKHVvNdYGnfrWpKIHjLXsrUx82+qOiO0vxAHAraSErFXoAqEecuqK7HyLf79NNtPImOkoHSi07l4aCVW9tkdZA7XQk
X-Gm-Message-State: AOJu0YwtUEkZlsMa5rOwQZjgCbbDXiuWPk+OtcathTa3OkuwudK2SkcO
	imnZKeRxtlPQu88W8GebnevKC3fiPawbEvvVAwYgRh8TpTTy/TcpqkVnpZ8peA==
X-Google-Smtp-Source: AGHT+IFXP0SM3z7WAQFgdBp5CCxZlXZmSMJJS/NqcGG1stQP0tBD3jcLz3Jce0/lDIAfO16tzwVCPw==
X-Received: by 2002:a05:6a20:de89:b0:1a7:870a:86eb with SMTP id la9-20020a056a20de8900b001a7870a86ebmr3750218pzb.15.1713997931478;
        Wed, 24 Apr 2024 15:32:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u12-20020a056a00098c00b006f09d5807ebsm11488861pfg.82.2024.04.24.15.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 15:32:10 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:32:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: Avoid i386 UBSAN handler crashes with Clang
Message-ID: <202404241530.A26FA3CC2@keescook>
References: <20240424162942.work.341-kees@kernel.org>
 <20240424192652.GA3341665@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424192652.GA3341665@dev-arch.thelio-3990X>

On Wed, Apr 24, 2024 at 12:26:52PM -0700, Nathan Chancellor wrote:
> Hi Kees,
> 
> On Wed, Apr 24, 2024 at 09:29:43AM -0700, Kees Cook wrote:
> > When generating Runtime Calls, Clang doesn't respect the -mregparm=3
> > option used on i386. Hopefully this will be fixed correctly in Clang 19:
> > https://github.com/llvm/llvm-project/pull/89707
> > but we need to fix this for earlier Clang versions today. Force the
> > calling convention to use non-register arguments.
> > 
> > Reported-by: ernsteiswuerfel
> 
> FWIW, I think this can be
> 
>   Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> 
> since it has been used in the kernel before, the reporter is well known
> :)

Ah! Okay, thanks. I wasn't able to find an associated email address. :)

> 
> > Closes: https://github.com/KSPP/linux/issues/350
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: Marco Elver <elver@google.com>
> > Cc: Andrey Konovalov <andreyknvl@gmail.com>
> > Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Bill Wendling <morbo@google.com>
> > Cc: Justin Stitt <justinstitt@google.com>
> > Cc: llvm@lists.linux.dev
> > Cc: kasan-dev@googlegroups.com
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >  lib/ubsan.h | 41 +++++++++++++++++++++++++++--------------
> >  1 file changed, 27 insertions(+), 14 deletions(-)
> > 
> > diff --git a/lib/ubsan.h b/lib/ubsan.h
> > index 50ef50811b7c..978828f6099d 100644
> > --- a/lib/ubsan.h
> > +++ b/lib/ubsan.h
> > @@ -124,19 +124,32 @@ typedef s64 s_max;
> >  typedef u64 u_max;
> >  #endif
> >  
> > -void __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
> > -void __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
> > -void __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
> > -void __ubsan_handle_negate_overflow(void *_data, void *old_val);
> > -void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
> > -void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
> > -void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
> > -void __ubsan_handle_out_of_bounds(void *_data, void *index);
> > -void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
> > -void __ubsan_handle_builtin_unreachable(void *_data);
> > -void __ubsan_handle_load_invalid_value(void *_data, void *val);
> > -void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
> > -					 unsigned long align,
> > -					 unsigned long offset);
> > +/*
> > + * When generating Runtime Calls, Clang doesn't respect the -mregparm=3
> > + * option used on i386. Hopefully this will be fixed correctly in Clang 19:
> > + * https://github.com/llvm/llvm-project/pull/89707
> > + * but we need to fix this for earlier Clang versions today. Force the
> 
> It may be better to link to the tracking issue upstream instead of the
> pull request just in case someone comes up with an alternative fix (not
> that I think your change is wrong or anything but it seems like that
> happens every so often).
> 
> I also get leary of the version information in the comment, even though
> I don't doubt this will be fixed in clang 19.
> 
> > + * calling convention to use non-register arguments.
> > + */
> > +#if defined(__clang__) && defined(CONFIG_X86_32)
> 
> While __clang__ is what causes CONFIG_CC_IS_CLANG to get set and there
> is some existing use of it throughout the kernel, I think
> CONFIG_CC_IS_CLANG makes it easier to audit the workarounds that we
> have, plus this will be presumably covered to
> 
>   CONFIG_CLANG_VERSION < 190000

Yeah, that seems much cleaner. I will adjust it...

> 
> when the fix actually lands. This file is not expected to be used
> outside of the kernel, right? That is the only thing I could think of
> where this distinction would actually matter.
> 
> > +# define ubsan_linkage asmlinkage
> 
> Heh, clever...
> 
> > +#else
> > +# define ubsan_linkage /**/
> 
> Why is this defined as a comment rather than just nothing?

I dunno; this is a coding style glitch of mine. :P I will drop it.

Thanks for the review!

-Kees

> 
> > +#endif
> > +
> > +void ubsan_linkage __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
> > +void ubsan_linkage __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
> > +void ubsan_linkage __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
> > +void ubsan_linkage __ubsan_handle_negate_overflow(void *_data, void *old_val);
> > +void ubsan_linkage __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
> > +void ubsan_linkage __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
> > +void ubsan_linkage __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
> > +void ubsan_linkage __ubsan_handle_out_of_bounds(void *_data, void *index);
> > +void ubsan_linkage __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
> > +void ubsan_linkage __ubsan_handle_builtin_unreachable(void *_data);
> > +void ubsan_linkage __ubsan_handle_load_invalid_value(void *_data, void *val);
> > +void ubsan_linkage __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
> > +						       unsigned long align,
> > +						       unsigned long offset);
> >  
> >  #endif
> > -- 
> > 2.34.1
> > 
> > 

-- 
Kees Cook

