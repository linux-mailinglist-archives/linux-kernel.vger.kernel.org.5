Return-Path: <linux-kernel+bounces-43539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959AB841547
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41FA9B23A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C7E158D98;
	Mon, 29 Jan 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E4GRtBmW"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0826153BC1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706565379; cv=none; b=gFJc0JFrwPSw7W/2IaOzMkvtKt39cgSnD0UEtc15n9FBGe+YebijrOpUjFUXvzJSAWZ+Zfwmjx2+dy9Tl8dLfT266hhxH7Hbz0mQm2sNJ+NHEygGd/zFHNxWtqpxFB9fbSDqxGDHCAYrwR7NVMXJ9RhcAk6qC7yIJaxbIFC0rDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706565379; c=relaxed/simple;
	bh=SGut10VocypQdQV3KZ8JxNWSezKusO01V74qBOL3voA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sToeLWQnWbIu5Wz1dZh0lCS6wK53Y5/cy57T2P+gyH+zXiCfznwZY6RnPHEmSX96HEOEWmaNQJc6ZnJU9mjOR9yGhKvFT+7zaDDjAeuwEvVjmlJW8CMwXcev+iPO9kVikakpntAf4NprgUVP7kT05PY4+rSPfbJ95+9iFRFWorU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E4GRtBmW; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59a27fbe832so632733eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706565376; x=1707170176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sVQfnYTeTh5M6YXr0RwVkYHFBKg3/KVCWcIRRHP0C1w=;
        b=E4GRtBmWFQWnxRqms5+PXHjJpLYTUZ/wWpScrajH9Q6wv6YRrxEJe8bYMa6yoFtJyR
         B+afITcLWw4JC+I9mJcFDN9UwWa6VI8T2ffXK1nj9An1OtpqJC+/A/67HIZk3hw6OhlU
         /f2T1sg2MkqEckH8mprQZUFffM1P/1Wc6i46c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706565376; x=1707170176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVQfnYTeTh5M6YXr0RwVkYHFBKg3/KVCWcIRRHP0C1w=;
        b=He2+X3g/dgX39AIPX/Ex3ZNlX06n184OeVhjmHVd755wtveAAcy87+n7L+6JAPhP51
         DQ7+GdrRUMSAAlV/wBusul3/21FVBILGmcporNNX8G7fvR+7QWTuKk/jEKBVKoK/iiwv
         DHEK2PwSE/Mt6S5rF6w2GG9gGukd5jTbI3aLuR9UC5tE4Co/zqMxsoyBPWBCI2LZ6VDZ
         YlnxVRD7yaFf1gazXDASD8zPWvtxnOUwWhgxg1dh1Cn0g6Jxw6NaXWtOcPyWTeT8yHzQ
         58AS2+Vsu89hSR0I+vd2zCiur0pOL/sFHp2t0anNJDOqLiSxr24MRqge7A1YY19JL+iT
         ZKSA==
X-Gm-Message-State: AOJu0YzopMJeukkR/KvGLloYCxL6Fq5aMRF1npDDEyvYD65k9uDB0tIB
	bx4mvEBuhJEkoiP4rWnk11CZoGxQ55qrjjJfwaBMDh5HrRuVwLuFq39H2tN9qQ==
X-Google-Smtp-Source: AGHT+IESvdtCmLe+CNtI14Gg/BY5kJrVtDarakUMqov6S6A5Y8Q7+73nxlvky29dvBOp4+LRENC4/Q==
X-Received: by 2002:a05:6358:5709:b0:176:4fce:27 with SMTP id a9-20020a056358570900b001764fce0027mr3844045rwf.6.1706565375937;
        Mon, 29 Jan 2024 13:56:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y3-20020a63de43000000b005cf9e59477esm6779865pgi.26.2024.01.29.13.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 13:56:15 -0800 (PST)
Date: Mon, 29 Jan 2024 13:56:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 5/5] overflow: Introduce inc_wrap() and dec_wrap()
Message-ID: <202401291234.00B6A1B4D@keescook>
References: <20240129182845.work.694-kees@kernel.org>
 <20240129183411.3791340-5-keescook@chromium.org>
 <33dcfa96-e584-404e-a9e5-afeca9105818@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33dcfa96-e584-404e-a9e5-afeca9105818@prevas.dk>

On Mon, Jan 29, 2024 at 09:16:36PM +0100, Rasmus Villemoes wrote:
> On 29/01/2024 19.34, Kees Cook wrote:
> > This allows replacements of the idioms "var += offset" and "var -= offset"
> > with the inc_wrap() and dec_wrap() helpers respectively. They will avoid
> > wrap-around sanitizer instrumentation.
> > 
> > Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/overflow.h | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 4f945e9e7881..080b18b84498 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -138,6 +138,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >  		__sum;					\
> >  	})
> >  
> > +/**
> > + * add_wrap() - Intentionally perform a wrapping increment
> 
> inc_wrap

Thanks, fixed.

> 
> > + * @a: variable to be incremented
> > + * @b: amount to add
> > + *
> > + * Increments @a by @b with wrap-around. Returns the resulting
> > + * value of @a. Will not trip any wrap-around sanitizers.
> > + */
> > +#define inc_wrap(var, offset)					\
> > +	({							\
> > +		if (check_add_overflow(var, offset, &var)) {	\
> > +			/* do nothing */			\
> > +		}						\
> > +		var;						\
> 
> Hm. I wonder if multiple evaluations of var could be a problem.

I am normally defensive about this, but due to @a normally being an
lvalue, I lacked the imagination to think of other side-effects, but
you've set me straight below.

> Obviously never if var is actually some automatic variable, nor if it is
> some simple foo->bar expression. But nothing really prevents var from
> being, say, foo[gimme_an_index()] or something similarly convoluted.
> 
> Does the compiler generate ok code if one does
> 
>   typeof(var) *__pvar = &(var);
>   if (check_add_overflow(*__pvar, offset, __pvar)) {}
>   *__pvar;
> 
> [in fact, does it even generate code, i.e. does it compile?]
> 
> I dunno, maybe it's overkill to worry about.

Yeah, an index-fetch is a great example that would get lost here. I've
updated these to be defined in terms of add/sub_wrap() and to use your
pointer typing method to avoid side-effects.

-- 
Kees Cook

