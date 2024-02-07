Return-Path: <linux-kernel+bounces-56228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D9084C79E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F96028C511
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2145822EE8;
	Wed,  7 Feb 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mp2Qgq4l"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDDB22330
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298514; cv=none; b=GGHjfXuzjkym9H1mN2yKhjVFdH2wtiWFzCYl7VYz9Gbr0OmTh/cS/QdrFI2i+yEgL5tE/epuGLA2sQlWRuEPMXKBplw00sv578FiikD3FyuR306i1iz23QycLT9Nl2G5/UcqKuRlzmEPlferRZLpzql5MiyB9VjR2Q8T9fLOmaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298514; c=relaxed/simple;
	bh=XjpRzdoTfjP3OQt5mqE+y9WThcPznmjyICcveK2XvE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8iu3FE3j71SdUBgJYTBfOyRCo4LO0k/eiI0vdtUSKq8YcmaXvSghkBzCicnulPavXFpncykJllIjyiJ5lV3pd3iQgA7Qzq/fzRtes+A/ehPrAhKR8TYUrn+Brrh4m5KoAjJ3PUss05afSRsKtQRd0sorgwmcIevhrqm8yiIXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mp2Qgq4l; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e04e7b687bso248219b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707298512; x=1707903312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lnzs6TPIgp3HqVBCfdcD7KxhniQZ5JYkJZ6YNmMCISs=;
        b=mp2Qgq4ltvOvC+3iDb//06CICpkJJTdcqCM/FvZ9jpuxIfYxLsgSc+5uQB5yBtVFf5
         tno0XYnwDiAuOkPzh0FnLztgL08ONAC6rPWoI1frOFzyJX3kKDOBog9xOtelb7Mydo/C
         99r0VR8uMuIRQUG0X7ebItltvEoZXB/8mvB6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298512; x=1707903312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lnzs6TPIgp3HqVBCfdcD7KxhniQZ5JYkJZ6YNmMCISs=;
        b=Y5TO1n3sWblLPSod9t9OV0PovE4OmY33diQ4W45rVDxg2vJ6+p3K2Rp2B2eTrZYcua
         iHpBimICdv2kdrxbXOyEUdRCXq3NlZ+fQame0wJK2STUwJfJoF0M5G0ETCFa3e/xF4o7
         Ib/fyPuv1/jjlytYsQhUxZRsgwKW+9rA2EzRL4t725RaEMv4f4MJiCxxRG2/tLRcn8Sq
         Mdkqovd8vLFU/UZiX05UmCAj2wi/zB1+WEJ/vikLhbPBq8+05ZjCdiQeYUX1GqBEjSDz
         2qL2Ui6lvVgPoG5PrHtGqgq+WBp39l969dbTi4AjKbVZnNTR2DxLpnx5sM0a6LdWJpnS
         IY1g==
X-Gm-Message-State: AOJu0YzTmE9nYB7ESAOvndXvOjoR8hMAORnamRoKL1a2w1gBTgWut1WA
	kr9gL7aaQ6FrOVwz5aulYZajOkUR+SXyi7WJEYnrGYvrPArBPciZs+Bs3ef58Q==
X-Google-Smtp-Source: AGHT+IEkEilvjof7TiSRF97ozyPZg+g25k745KHQmjN0ECt8d5Z5zPMmfEBaBMrEFYqdYbnRc0Guyw==
X-Received: by 2002:a05:6a21:2d0a:b0:19e:9f2d:9814 with SMTP id tw10-20020a056a212d0a00b0019e9f2d9814mr2957878pzb.39.1707298512206;
        Wed, 07 Feb 2024 01:35:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5fXL+oPKiDobv+fb/lHAozLsmX7lK/yZb08Gn9bfd2pAuX+sot8hH0/znY26GmybtpE91R7S10ham8tIjbvT1yzWzIltOtz9zURXpQfQdTaE1E3KqHTrF09ABSgIuq0yFEQl64KuyMPyNH/jxEAHaxCQMHFIee4Xmv5J4t7pF3zNF4a+0BAK2U4cNEgS7yp3wyHkdL4RB5IHEjtQgFv/ZpNPqO6EsfmNDgg7Od/DVl15J6Zyzub1pYZo82EFL06rfZnoTQfAFC2nPbLRJEoxM3WP+9Q05oKwtFwnJ
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lb6-20020a170902fa4600b001d95407f6f5sm986587plb.48.2024.02.07.01.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:35:11 -0800 (PST)
Date: Wed, 7 Feb 2024 01:35:10 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] overflow: Introduce wrapping_add(),
 wrapping_sub(), and wrapping_mul()
Message-ID: <202402070134.53727173F@keescook>
References: <20240206102354.make.081-kees@kernel.org>
 <20240206103201.2013060-2-keescook@chromium.org>
 <4bde6e72-c7f6-434d-9489-3a0de7804b18@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bde6e72-c7f6-434d-9489-3a0de7804b18@embeddedor.com>

On Tue, Feb 06, 2024 at 10:54:06AM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 2/6/24 04:31, Kees Cook wrote:
> > Provide helpers that will perform wrapping addition, subtraction, or
> > multiplication without tripping the arithmetic wrap-around sanitizers. The
> > first argument is the type under which the wrap-around should happen
> > with. In other words, these two calls will get very different results:
> > 
> > 	wrapping_mul(int, 50, 50) == 2500
> > 	wrapping_mul(u8,  50, 50) ==  196
> > 
> > Add to the selftests to validate behavior and lack of side-effects.
> > 
> > Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Eric Biggers <ebiggers@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-hardening@vger.kernel.org
> > Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   include/linux/overflow.h | 54 ++++++++++++++++++++++++++++++++++++++++
> >   lib/overflow_kunit.c     | 24 +++++++++++++++---
> >   2 files changed, 74 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 4e741ebb8005..429c4d61a940 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -64,6 +64,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >   #define check_add_overflow(a, b, d)	\
> >   	__must_check_overflow(__builtin_add_overflow(a, b, d))
> > +/**
> > + * wrapping_add() - Intentionally perform a wrapping addition
> > + * @type: type for result of calculation
> > + * @a: first addend
> > + * @b: second addend
> > + *
> > + * Return the potentially wrapped-around addition without
> > + * tripping any wrap-around sanitizers that may be enabled.
> > + */
> > +#define wrapping_add(type, a, b)				\
> > +	({							\
> > +		type __val;					\
> > +		if (__builtin_add_overflow(a, b, &__val)) {	\
> > +			/* do nothing */			\
> > +		}						\
> > +		__val;						\
> 
> mmh... now that __builtin_*_overflow() is directly used, I guess
> we don't need to _check_ for overflow anymore.

/me slaps his forehead

Yes indeed! I will adjust it.

-- 
Kees Cook

