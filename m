Return-Path: <linux-kernel+bounces-36094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11411839B79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C3D289FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036AD4A987;
	Tue, 23 Jan 2024 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P/fYp5fR"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD78481A8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046756; cv=none; b=jAzWkEyi86YI081hBZ6Rq+xhTkODL2iWAyru2kh5cA01GG4N1GJJ/R4t1aOxmsHXwN8Se+jdF97fyGe2JbiRdA0CStkmibzSgEf+wKJORJXvmG+Sm7SYCaSRaCaPTax5fWGTXcbE8Qrbs8kc0tGAy79GfBxFlciEzvVe6+ZRdvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046756; c=relaxed/simple;
	bh=VUhlMv0YIbLBaprVX+mmJCjmL8UnZ1q4FSBZdfn36Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFh54bARh5aFe0aqbPrpigq74hhF6MwF7Lq4oIuBQdM6G/bKRaX99yyDNJxYwRbQ4KCoF3KQAi85FZrgKeAq0H030DMYxtAbFfzFrt5JRpzA9NFwc0hgbD6Xo0WYfgLRqY6OJAtmoiz5a/n2ByHd4stnN3qsp8wFFadnOOwyZHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P/fYp5fR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7431e702dso19685145ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706046754; x=1706651554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sj6Rxvm207/3+H8NF8WKC7zBV6u0ee5y25nooD5f1tg=;
        b=P/fYp5fRzOsBDHkrucMCFg3aa0kOezEUiLMjLvA3Jud+3RS3VWgOm6rAu8HZMbRuF2
         J3s7mpYUvE0JjafMvkqHHs80gYIR+X9M+Ci77C97ue9UOdV5a6CybMTKzifJDZYFQSgO
         w1HqjBzbXWdcXrpkKp6OLIEAzLHdFV2P6Jm+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046754; x=1706651554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj6Rxvm207/3+H8NF8WKC7zBV6u0ee5y25nooD5f1tg=;
        b=reKqHPZji8Ua3PvWMQyuUIt3VI1vMuM7BgSSo9lHpkIbOc3ChKI2vP7uT9WMCqFI8o
         q/DL9XWI706MoYTsvsF2F0PLhQjXPwAUZCEFcXwoe8e9U5+l5V3Wi+KeZN+egeo9fGnm
         4F1W+333I8RnAuNyANw3Js1gyw7BOktrX5KQ16zn4U1mEhvf3jTAY5hk2J+hk1q5YeLB
         /NGQkWmmaKzYiV4N2xz7epqidkaaVXsvVAPzjtrklmK0547qY1LT2/X11KNK1QOpRwLJ
         CIQ7GH4A8gQqIB0SORViwIG4QqihUJsibeJaoTbZK91gxdUxkINLcF4edleKreY+QPuY
         OdLA==
X-Gm-Message-State: AOJu0YzCGgwLo+aYdqv769dBh0tkNpFKXgEuZeIYSadizE2Q3hYAFqCZ
	mxAb9NKJMcvSkyIuTt3h3Jiu5g6s6uMeBg3+2NG1sPgAqpsZud+SLTmJdoOqcCBvqZjsnYeQaxw
	=
X-Google-Smtp-Source: AGHT+IFKAAxa7+zxk0HWVIDCHDWWNy0ZSAAupe8tRwFVU2gSFPlPb1yvRpztsCFviLTsRlN6y5jGJQ==
X-Received: by 2002:a17:902:e810:b0:1d7:6f5a:d390 with SMTP id u16-20020a170902e81000b001d76f5ad390mr1575176plg.55.1706046754292;
        Tue, 23 Jan 2024 13:52:34 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mf11-20020a170902fc8b00b001d748fb211csm4331068plb.276.2024.01.23.13.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:52:33 -0800 (PST)
Date: Tue, 23 Jan 2024 13:52:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/82] overflow: Introduce add_wrap()
Message-ID: <202401231352.7CE79C5F@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-3-keescook@chromium.org>
 <Za-FbFE7slBpwrbq@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za-FbFE7slBpwrbq@FVFF77S0Q05N>

On Tue, Jan 23, 2024 at 09:22:52AM +0000, Mark Rutland wrote:
> On Mon, Jan 22, 2024 at 04:26:38PM -0800, Kees Cook wrote:
> > Provide a helper that will perform wrapping addition without tripping
> > the arithmetic wrap-around sanitizers.
> > 
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/overflow.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index ac088f73e0fd..30779905a77a 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -124,6 +124,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >  		check_add_overflow(a, b, &__result);\
> >  	}))
> >  
> > +/**
> > + * add_wrap() - Intentionally perform a wrapping addition
> > + * @a: first addend
> > + * @b: second addend
> > + *
> > + * Return the potentially wrapped-around addition without
> > + * tripping any overflow sanitizers that may be enabled.
> > + */
> > +#define add_wrap(a, b)					\
> > +	({						\
> > +		typeof(a) __sum;			\
> > +		if (check_add_overflow(a, b, &__sum))	\
> > +			/* do nothing */;		\
> > +		__sum;					\
> > +	})
> 
> It's really difficult to see the semicolon for the empty statement here; could
> we make that part:
> 
> 		if ((check_add_overflow(a, b, &__sum)) {	\
> 			/* do nothing */			\
> 		}						\
> 
> ... to be a little clearer (and less at risk of breakage in a refactoring)?

Yeah, agreed -- that stands out more clearly.

-Kees

-- 
Kees Cook

