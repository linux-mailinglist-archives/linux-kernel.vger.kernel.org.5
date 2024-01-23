Return-Path: <linux-kernel+bounces-36081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12328839B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B95286B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CAD3A8EE;
	Tue, 23 Jan 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NjzM2DSa"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA511C8FD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045890; cv=none; b=eFZGZ8pVTWxCwpVUsnrqsoJSvDWq/EqgZLHnFUafspUQ0Ok6d+jXes7CaKJMLYcOXTQsLFjucXWMCF2sVaT1A6DSce3iYLtkYWoDEhEgCM9QGO+lwF7H6pdqAmIQMrr7aMeh5YjB+JtGtXlUNgFgHCJvACLeJUGmFPhaf8XJnX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045890; c=relaxed/simple;
	bh=Q1sznM/S5mqUKJJ+NwJ1o0bscr4Kus2dQ+61NX22TnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWyINfJQLrS5kBylZdYaIRhFZORjazk1EprADEVcNySLSdLarx5943OlaPAA8uZbYwNviWb3FvG8FKhG9435BHlJ/6FE8AhshzlcRy2px4cRh6uISUd2mtEjcoKyNxn7+paoqpnpFaTVZuJsdEA3G9EV5oUuBtNOkI/muELkQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NjzM2DSa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so2674453b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706045887; x=1706650687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKF99EW1nwbD3BFEhWV3Q7Xu4D4ZSEv9qrH8VfYUa8Y=;
        b=NjzM2DSaFegrpn3uREWVmjQW3Eqh7IgT3S38qJDJGgHZri1/0dcLnxQ2sqx9q12OyH
         fitsz1tw3uz53+b0MeVtIIkiG3wLgFUk8BASgyEyVKmXEIgnwP30TmBuZbFln+N2rNc2
         uvC7RCOAEt6itr7G1QFdeTnQxvpLnIx5hMuQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045887; x=1706650687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKF99EW1nwbD3BFEhWV3Q7Xu4D4ZSEv9qrH8VfYUa8Y=;
        b=kDRXWIIL4jMGi4Obyp62IYP5X/TFd37Iz4iPfDHt4OEx5Z5M89HiTABMD14QU47KFk
         BnrleOvohfJM6b8HnMVJXbQ8cFdSgYjrxbDv3JVGmCU/CjQED7VG6J4IqGzp29yU3z8G
         FzVHaOpe/CKIY7S2+MQTa/8tZlea83NA8PT6NMFqt2bWhiuqI03CGku8q09eMkqPQTtr
         UChA+19ffIBiNdqOfsUQxnnz3DoYY1gyvLvxdXz2FQeKno+u+o/Wh4BeMGK5m8gSof4i
         Ja8L4OI3blCKnnECE47A1GGEV7w62dSXWWF6301jnJxCQN1EX1j7aXJaQX/Iwmi33UdP
         fChA==
X-Gm-Message-State: AOJu0YwllRmAkQ6Sag+hfDbEcOxNQK8oSkPe7dtrgxDRRY8pkIFmbmLo
	eGFalrAdIx8abGKrAGddtFqNVr6rA6NgFv2lH/vMzscAhpoORQPx7a2H4iwO5slY/mybLMHoygc
	9rQ==
X-Google-Smtp-Source: AGHT+IH5n65f4ayBJ0shws4yKzuwCr37u50lJB8acovsMZ1i0lGrNKUQIKK1RcNlF0t2Naa5zvfiTw==
X-Received: by 2002:a05:6a00:9382:b0:6dd:84ce:4602 with SMTP id ka2-20020a056a00938200b006dd84ce4602mr1015895pfb.6.1706045886959;
        Tue, 23 Jan 2024 13:38:06 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fj1-20020a056a003a0100b006cbe1bb5e3asm12143746pfb.138.2024.01.23.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:38:06 -0800 (PST)
Date: Tue, 23 Jan 2024 13:38:05 -0800
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/82] overflow: Introduce add_would_overflow()
Message-ID: <202401231332.135AFC9@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-2-keescook@chromium.org>
 <53a886c9-10df-4bc5-9de2-d9f99ea78278@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a886c9-10df-4bc5-9de2-d9f99ea78278@prevas.dk>

On Tue, Jan 23, 2024 at 09:03:10AM +0100, Rasmus Villemoes wrote:
> On 23/01/2024 01.26, Kees Cook wrote:
> > For instances where only the overflow needs to be checked (and the sum
> > isn't used), provide the new helper add_would_overflow(), which is
> > a wrapper for check_add_overflow().
> > 
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/overflow.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 099f2e559aa8..ac088f73e0fd 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -108,6 +108,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >  		__builtin_add_overflow(__filter_integral(a), b,		\
> >  				       __filter_ptrint(d))))
> >  
> > +/**
> > + * add_would_overflow() - Check if an addition would overflow
> > + * @a: first addend
> > + * @b: second addend
> > + *
> > + * Returns true if the sum would overflow.
> > + *
> > + * To keep a copy of the sum when the addition doesn't overflow, use
> > + * check_add_overflow() instead.
> > + */
> > +#define add_would_overflow(a, b)			\
> > +	__must_check_overflow(({			\
> > +		size_t __result;			\
> > +		check_add_overflow(a, b, &__result);\
> > +	}))
> 
> Hm, I think this is a bit too ill-defined. Why is the target type
> hard-coded as size_t? What if a and b are u64, and we're on a 32 bit
> target? Then a+b might not overflow but this helper would claim it did.

Oooh, yes. That's no good. Thanks.

> But we also cannot just use typeof(a+b) instead of size_t, since that
> breaks when a and b are narrower than int (adding two u16 never
> overflows since they get promoted to int, but then if assigning the
> result to a u16 one truncates...).

The add_would_overflow() is aimed at replacing the "v + o < v" pattern,
so perhaps use typeof(a) ?

> Perhaps the target type must be explicit? sum_fits_in_type(T, a, b) ?
> IDK, I just don't think size_t is the right thing to use in something
> that is otherwise supposed to be type-generic.

I will use typeof(a) and check binary differences to see if there are
any places doing something unexpected...

-Kees

-- 
Kees Cook

