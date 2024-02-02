Return-Path: <linux-kernel+bounces-49820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF5E847001
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C041F24E9F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FC8140765;
	Fri,  2 Feb 2024 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LpzTI4ob"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3FA140764
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876226; cv=none; b=HteXaYPIxHztR0hob2hTmg25VBW51pptCsuuyZAvuXiWRkNIqAljT7jnNFI30ZQcLf2Rawc8rWAmHi+hJBWpPH/6L1jvgNqsgy55ZfA1+2dGvcUshEn8XuIE6yVd9yTZl+N5J4UBIP9ZaHIf7OmuU185Pdr1GDLuhqbtaXLSLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876226; c=relaxed/simple;
	bh=6WMlixFsMD3YXZFA7X0TiodSA2ARpqznFCPL+NJ64J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tI2sahJu98sKqdUWUXcSbmQGMCrGjFdlyEL/0trwl4/LWGCLF0PbTuVfk90bw7GVHOyegp/rC3FIVY2NFDsAeuvVs45gHm2Ba2s2YAgLcrPb0A3U2D2zazpk8Hvh74OjYb3igiwiVGnq/KJEsphivyV73LrJoXfrtVENTTCgwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LpzTI4ob; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29041136f73so1509850a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 04:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706876224; x=1707481024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ0esveh//cg9XCkiI/7xWePudzmiIjItwxrOruHVwk=;
        b=LpzTI4obYAxHG+Gkig1OmPJWjP1D7uCoxw6UBg4vbSrdCkGBoxM0DmUc7l0biBlLHO
         5WmQINucpkAfAX0/VONbedxa2YvfDqR8UPCIidaEWy5PTELhJMPbvyRbk1UctJFjqf5N
         KWD9EtZB5AjPgIhMX1zUwQFe8JOb42Vh8WwsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876224; x=1707481024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ0esveh//cg9XCkiI/7xWePudzmiIjItwxrOruHVwk=;
        b=SVELkBssHEYethpe5TTvFXbDxPkA3ow2YvwXK7/lQPByToTaz+bnlvMI3qiGMDtWfw
         bF6Y8dW2plBt5uqKP5KOS416WxbaBMhg22esO122WgIMtfbF6nxyhIpn6mFALGyQftZx
         WQVyARVu0PPIq0XKG8D/sM6OR2vYJ0BleQwDnoAbmNOhbrqZq2Cc4ztmsLPqLXjV2uEE
         VldRutLNqqnAEg2UXpCcSlkyP0VkuONmQaM7R0V/iEmn2dawYqPBhCf6F8skQYfO3igd
         MEa/YxaHxLaqN4LC5l0DN5ZfeC7OOoP0HO57yCyESPrFgZw6clQaoZm3u5i/nMxDw1NW
         4vDA==
X-Gm-Message-State: AOJu0Yy2nAjIGgpYZhMNHbrr5yGUVbWDVN034Kx6e4Y4sMARTHqbiL2t
	CWd16vbKIqG+VCERcXyAhO2HnkYSpqzl4QYPnWJbKIJyFpvDi/LMAGhVyrd7XQ==
X-Google-Smtp-Source: AGHT+IGg88zNLC34obB5/fOW4+rC0GoCG14stcT3rLU6L9HZrzANdbP1B4KMEzwmTO1dY9t5epZ2BQ==
X-Received: by 2002:a17:90b:1298:b0:296:1dcf:c296 with SMTP id fw24-20020a17090b129800b002961dcfc296mr1876188pjb.18.1706876223734;
        Fri, 02 Feb 2024 04:17:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUGVn+0c2h4HxapCQwK+CBO5gK3KOvlzIatkL3Eg+0hshg2pC4xRmXdAPGwrPO866Nj9YF+U6s6nJkm+zEO0B/JBsHbpfqLIrHUgGxhmDm7PR7dJOIlSKekZQeCfpS4kk6gdUCRy8AKy1koQcYXJUoBqPtoXthgUI8I+/eaEfrPbo4kflZwbchOOzcwU5swL0S6WdMTIJa+mw55to+6uV3nDPQwGmi8fzDIZ1/ceDsJxByCfPOeO0l/S81b9BgnbLDHSPgD7FlGPHvtp8Z/FomG1NkHrVilLrlukHP1pAw9wYKJnI22iJxJmSjYHmQniMGlZYsc/cdM58fBdkhFMawZoGvAvkTYiXvNll9VJlnJ8j/FX+IAuDXHo43itnq+OGQQdsBiGyQPYcczK3z4vcpWYVXqya3O7moVN8gWmQjkhvZgr8SZOqWDhbrhJgPiVmYM7CkU25sPa9I0PqKXD5aa7cvoHKmNkLXZ4/epetFyeC0sd5jBRU3IEcz8/3lo1E3SteGrn+6+Y/KEkJjGEjE/TlV+t7ZzrhslvL+T17oohFYN0g54YBk1TJzsBIkJwnqakFKkOfMS15bofbWnqaCKkx+rJlTObTtkF5AePTEEUWmqLLwa3jLiNLz4lnivpuzOGcGhWnPJl5a421rYycnirgqxJHh/cGTKPA8EmcYWycgZa67VxpoBN5oGlmkdby+KZtTF2BuWlV1VWF5HfxIzOVdG8qZz4Q257WM=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id su13-20020a17090b534d00b002927a36b7a0sm1671429pjb.23.2024.02.02.04.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:17:03 -0800 (PST)
Date: Fri, 2 Feb 2024 04:17:02 -0800
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Fangrui Song <maskray@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Bill Wendling <morbo@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/6] ubsan: Reintroduce signed and unsigned overflow
 sanitizers
Message-ID: <202402020405.7E0B5B3784@keescook>
References: <20240202101311.it.893-kees@kernel.org>
 <20240202101642.156588-2-keescook@chromium.org>
 <CANpmjNPPbTNPJfM5MNE6tW-jCse+u_RB8bqGLT3cTxgCsL+x-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPPbTNPJfM5MNE6tW-jCse+u_RB8bqGLT3cTxgCsL+x-A@mail.gmail.com>

On Fri, Feb 02, 2024 at 12:01:55PM +0100, Marco Elver wrote:
> On Fri, 2 Feb 2024 at 11:16, Kees Cook <keescook@chromium.org> wrote:
> > [...]
> > +config UBSAN_UNSIGNED_WRAP
> > +       bool "Perform checking for unsigned arithmetic wrap-around"
> > +       depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> > +       depends on !X86_32 # avoid excessive stack usage on x86-32/clang
> > +       depends on !COMPILE_TEST
> > +       help
> > +         This option enables -fsanitize=unsigned-integer-overflow which checks
> > +         for wrap-around of any arithmetic operations with unsigned integers. This
> > +         currently causes x86 to fail to boot.
> 
> My hypothesis is that these options will quickly be enabled by various
> test and fuzzing setups, to the detriment of kernel developers. While
> the commit message states that these are for experimentation, I do not
> think it is at all clear from the Kconfig options.

I can certainly rephrase it more strongly. I would hope that anyone
enabling the unsigned sanitizer would quickly realize how extremely
noisy it is.

> Unsigned integer wrap-around is relatively common (it is _not_ UB
> after all). While I can appreciate that in some cases wrap around is a
> genuine semantic bug, and that's what we want to find with these
> changes, ultimately marking all semantically valid wrap arounds to
> catch the unmarked ones. Given these patterns are so common, and C
> programmers are used to them, it will take a lot of effort to mark all
> the intentional cases. But I fear that even if we get to that place,
> _unmarked_  but semantically valid unsigned wrap around will keep
> popping up again and again.

I agree -- it's going to be quite a challenge. My short-term goal is to
see how far the sanitizer itself can get with identifying intentional
uses. For example, I found two more extremely common code patterns that
trip it now:

	unsigned int i = ...;
	...
	while (i--) { ... }

This trips the sanitizer at loop exit. :P It seems like churn to
refactor all of these into "for (; i; i--)". The compiler should be able
to identify this by looking for later uses of "i", etc.

The other is negative constants: -1UL, -3ULL, etc. These are all over
the place and very very obviously intentional and should be ignored by
the compiler.

> What is the long-term vision to minimize the additional churn this may
> introduce?

My hope is that we can evolve the coverage over time. Solving it all at
once won't be possible, but I think we can get pretty far with the
signed overflow sanitizer, which runs relatively cleanly already.

If we can't make meaningful progress in unsigned annotations, I think
we'll have to work on gaining type-based operator overloading so we can
grow type-aware arithmetic. That will serve as a much cleaner
annotation. E.g. introduce jiffie_t, which wraps.

> I think the problem reminds me a little of the data race problem,
> although I suspect unsigned integer wraparound is much more common
> than data races (which unlike unsigned wrap around is actually UB) -
> so chasing all intentional unsigned integer wrap arounds and marking
> will take even more effort than marking all intentional data races
> (which we're still slowly, but steadily, making progress towards).
> 
> At the very least, these options should 'depends on EXPERT' or even
> 'depends on BROKEN' while the story is still being worked out.

Perhaps I should hold off on bringing the unsigned sanitizer back? I was
hoping to work in parallel with the signed sanitizer, but maybe this
isn't the right approach?

-- 
Kees Cook

