Return-Path: <linux-kernel+bounces-54644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8216F84B1E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3975A2866D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32112DD8C;
	Tue,  6 Feb 2024 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SDxukGF4"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186281E4AE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213945; cv=none; b=VDw7fYKrXeyMLPC3RSWM4zsiG4FnIGp4F8suHKeOwUUz5YBxSO4BKkyyd31RHGtaofbQT8nUiHua1PSSu63I8tFYDZjpDmaEe1RtrYSoxnLaQdnCpLZXlofMtIMVKLZfH6WuG9mNAXW7njKzBeu132h/UvloR4TqArtQoeezW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213945; c=relaxed/simple;
	bh=x5XCUSFKEL2GondDLeTtmfSmJigahMLLxVaHa2PuE1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mi8a1+RfmgQdeZKhDw9hA+VvtenBCheYODd8TT/TcbX94cMOuLlDay0OVu2uYnMSs6977I8ui0/fmb3TA3i5TWHxrwBMIfAtA8X/mj00QZFR1mdE8PQvPYgPtsuk6BvIt+meIsxlzBqLpnK0vLWjGGPS+WIjWbQk62VodfSa5E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SDxukGF4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d731314e67so36233155ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707213943; x=1707818743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5I9TObzmAi1P/AMsCzIFNvlVehNJlwvLmZ8xF0j6GmY=;
        b=SDxukGF4Q+ZsBJzqb7clde6fdHFkfEjMLUaPgI2AjFx88gPET1HJckAzWX175PqNlk
         YtKr1Jee3rH1ZbrCEocIMkAngQtWDS/a1kF+zNbk7GXCvzcPw+ZXiEQTP92l3AHNOAb/
         5zT/a0xgNApv8zLe/meKrdm4WQIP097R84Ms8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707213943; x=1707818743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5I9TObzmAi1P/AMsCzIFNvlVehNJlwvLmZ8xF0j6GmY=;
        b=JygiEqjfCcVWzVmJA6Wl7c75PqVBmUeCBLygRlgMAx/IgUGSYWl8SE2HKxEEwYLCcX
         We+TDflcw/Pypd40be+KfFESJaVmxwEP1/Ic8HAgz43tLujVvhI5fbEIAwCy6mGYJjka
         uG2oXQmLaLe/WV5Hy/5LXMjDVNvMuAeBWPnpg/oE4MOBoWJmq+np8IJUS/V0zPAX0eMT
         aLYdfKus3f5sYrVWXqR8q4r5vb6urKdVo1el4Rtcir9yFTmk1SONL9xorD763DHorDUV
         vdn8t8mzV1pI6LGdJ83L87gVoUOmWOGTUJoQO1ZVqExoF57hm4XZaR/PawNv8E1kHpOA
         ISew==
X-Gm-Message-State: AOJu0Yy1TMAZGzX3Wn278wrranPG48Ck5/umY7v/W1kV6nlasEpNA9uw
	AbVwAXCeooMkZ2AWtMwLWAhYg2Z2NFBfI5TVhmB3MIYkDsE5+tzKQTl98N3djg==
X-Google-Smtp-Source: AGHT+IGIF2iri9Zv8bM1b90EVV71H6JyQykLn1MgWKEbonz0H/0sEvP3zTH6IzVHYMxzE25+Na2ifg==
X-Received: by 2002:a17:903:442:b0:1d9:624e:126d with SMTP id iw2-20020a170903044200b001d9624e126dmr1036329plb.62.1707213943305;
        Tue, 06 Feb 2024 02:05:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXH1mTi7oy21rdcMXL/VIGIk0z2hwXV3OyoaD2elNdc69nHoOYhwMv05AcpghGxk6TAob65+qWXI+gqj8+bvDo6LDQ9tMbqZxGS7ludBhsqOm4ewKnllp4ItZ/91yCrVrRg9YPSOBl8Wwc/0y7COfovbJDvMjFKSHGI0f1aftEVgQVa3K6NQFcBC3UJoozE0pdwCYF8bg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ju8-20020a170903428800b001d8d6ec2d7fsm1464771plb.61.2024.02.06.02.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:05:42 -0800 (PST)
Date: Tue, 6 Feb 2024 02:05:42 -0800
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and
 mul_wrap()
Message-ID: <202402060204.A19FFF8FD5@keescook>
References: <20240205090854.make.507-kees@kernel.org>
 <20240205091233.1357377-2-keescook@chromium.org>
 <CANpmjNNExn8DX2+Cnz3GDWXNZv-jZcpFSedCYx+y6HEemFoHRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNExn8DX2+Cnz3GDWXNZv-jZcpFSedCYx+y6HEemFoHRw@mail.gmail.com>

On Mon, Feb 05, 2024 at 02:31:04PM +0100, Marco Elver wrote:
> On Mon, 5 Feb 2024 at 10:12, Kees Cook <keescook@chromium.org> wrote:
> >
> > Provide helpers that will perform wrapping addition, subtraction, or
> > multiplication without tripping the arithmetic wrap-around sanitizers. The
> > first argument is the type under which the wrap-around should happen
> > with. In other words, these two calls will get very different results:
> >
> >         mul_wrap(int, 50, 50) == 2500
> >         mul_wrap(u8,  50, 50) ==  196
> >
> > Add to the selftests to validate behavior and lack of side-effects.
> >
> > Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/overflow.h | 54 ++++++++++++++++++++++++++++++++++++++++
> >  lib/overflow_kunit.c     | 23 ++++++++++++++---
> >  2 files changed, 73 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 4e741ebb8005..9b8c05bdb788 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -64,6 +64,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >  #define check_add_overflow(a, b, d)    \
> >         __must_check_overflow(__builtin_add_overflow(a, b, d))
> >
> > +/**
> > + * add_wrap() - Intentionally perform a wrapping addition
> > + * @type: type for result of calculation
> > + * @a: first addend
> > + * @b: second addend
> > + *
> > + * Return the potentially wrapped-around addition without
> > + * tripping any wrap-around sanitizers that may be enabled.
> > + */
> > +#define add_wrap(type, a, b)                           \
> > +       ({                                              \
> > +               type __val;                             \
> > +               if (check_add_overflow(a, b, &__val)) { \
> > +                       /* do nothing */                \
> 
> The whole reason check_*_overflow() exists is to wrap the builtin in a
> function with __must_check. Here the result is explicitly ignored, so
> do we have to go through the check_add_overflow indirection? Why not
> just use the builtin directly? It might make sense to make the

Yes, this follows now. This is a leftover from extending the helpers to
work with pointers, which I don't have any current use for now. I'll fix
this.

> compiler's job a little easier, because I predict that
> __must_check_overflow will be outlined with enough instrumentation
> (maybe it should have been __always_inline).

I could change that separately, yeah.

-- 
Kees Cook

