Return-Path: <linux-kernel+bounces-49576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23905846BF0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C69BC28445D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B52777F10;
	Fri,  2 Feb 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e1wJtdll"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2678F7C097
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865972; cv=none; b=ZaAJqPeNuoHYE6Gs8AwsHWdKubQmHUkPmr7T4tN2yB99GTum057sj5HddWb46UsHMNHSrxpCSM4m3xSAi6Z6CLvWKOjbgnM6qUD7BEqj5HotXlzOA2aCb7ki9R7HB/e1uxk/e1JR8FSpHzttrRDbs1EUlOPzOAZeaPFHNjHxlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865972; c=relaxed/simple;
	bh=r1KSDdshTOdl1eD90GEdgP1GIyuWH5dotuZGtVETZPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0WReLOkjfRuTzeAerrgLK8ZgK4z80JFZ8uZ3vh/GprO+pkmG4WuJzX1rcHNL565s6HIEjQYfyeaDKq8iAT4Rxg94+zJfLTL1NNzZhgB0dB1PkExT9ZJil5xs4odsciBkY8UFiDDknQ5Lw3tiGtmqC5mUTNh2TC14wUYC2nyKmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e1wJtdll; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso1661440a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706865970; x=1707470770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lv2NKH9WWB74jvhBNElogS2Uwp+4e3LBP2aAu2jyOBc=;
        b=e1wJtdllY5htY7mrWKLoyLFT/f7Q4YClbuYH9O/Asnj8KJuVEZK+QCDVoVPlscQQWd
         6+2nCpxQYSBRsZHI2VpvJWuugJCA8hZaVEOCCwvmx9Ako7BcR3Ax7+Ae0K3MURBGa+jp
         0e92KZB1bBgiiV3kDcC/5a06/Hy32x6Al92cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706865970; x=1707470770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lv2NKH9WWB74jvhBNElogS2Uwp+4e3LBP2aAu2jyOBc=;
        b=j/1mEiAZN8gjH6pYkzZHb13DnTS68pGw3Aango9ctl2ELSMXp/MvIIq6HWn7agbm/b
         74G2+GK+HFdovc4b8jfuRFxmZVK4EQrbR8qz+/1y55+hjywnSdlaqv8WD8fxAxiM5sZt
         e1njnzBolQd2IoGLTnKEHYLvXi5Ks1oZY8R+f9tXDwwKqLd1JfpwlDij0TrDenIwFRjG
         a2Q0KMbxtVXdYMmeVH6b7Zn6vmx6FnU4MEc69J7tbL265ps2UwntPgOejksf/O9TrHl5
         l4pSymE5I9+yxwTypXckYjI7S6OKg/Z9AgwxO0/df1yZreSZ0IHh/GNtOLgWz2FPt6SI
         fXWw==
X-Gm-Message-State: AOJu0Yy6GYUBtV3P7FbtCfnygGWs2Pv7JZlP1e/S0MO6HnlYax+yz1/t
	Dk24phIJxdPjIaP1FqD5+YEdgJXDRVA8t4GcrhqowzIcmEB3Ho4zl5UD5rzmGA==
X-Google-Smtp-Source: AGHT+IFVXwt3ZODto1D6uO78oFjr3U556S4oIO8F6WGJXjqUqMx9HKzgXSKcznjwitA2R8bviSg61Q==
X-Received: by 2002:a05:6a21:2c82:b0:19c:9d4d:7d7 with SMTP id ua2-20020a056a212c8200b0019c9d4d07d7mr6590870pzb.41.1706865970497;
        Fri, 02 Feb 2024 01:26:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUlcw3+jmJncLOKzKlDlKSkf2ZjgJtgJGOC6FlRhNPhCDEe66sr6BxngOa4HC33wqxuh7mE+IJLP3MzYEsY30WoPHLK+jYHPtb15IcNR79Mk8UQnW/N4kc9DVrfxHSxMKktDwocU9ZBml81w4EFV3Wf1zFWnVclBXHDqDogvyS6Qcdt27Yf+IEZ27WTYj2nPUjEbBCVzE2+y6TpV32SvGjcakPZQVKZSxISv7zZTSQVIWXKx8SNFabr9j5ye+/i95QcRGRpWjENb/zMVJBBIY7fCGQA5xisKvcb7THROKTn6PuAj68u0E0bftE3cv9SUnOpuNABN3SB8QAXy6RWhwugPDsqK1OfFKI9r/oKPicqE2qibeM6AafHPmB5XaqwOKzq/hbKaIYBhsoXlM8yScllZ525aboabholHCbQXPxiq5CU/NYCc0g3rXNlxMNWsKHUUKY1zeG/UU1q0mBq/iFMuI3ghFwadThzaI8jzHkVwg+oPA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p20-20020a056a0026d400b006dfedc6a43dsm1140656pfw.208.2024.02.02.01.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:26:09 -0800 (PST)
Date: Fri, 2 Feb 2024 01:26:09 -0800
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] overflow: Expand check_add_overflow() for pointer
 addition
Message-ID: <202402020105.0759D4CD@keescook>
References: <20240130220218.it.154-kees@kernel.org>
 <20240130220614.1154497-2-keescook@chromium.org>
 <6d66deda-e09d-4899-b3a3-5137eeee449c@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d66deda-e09d-4899-b3a3-5137eeee449c@prevas.dk>

On Wed, Jan 31, 2024 at 09:35:35AM +0100, Rasmus Villemoes wrote:
> On 30/01/2024 23.06, Kees Cook wrote:
> > [...]
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 6f1ca49306d2..d27b58fddfaa 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -375,6 +375,16 @@ struct ftrace_likely_data {
> >  /* Are two types/vars the same type (ignoring qualifiers)? */
> >  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
> >  
> > +/* Is variable addressable? */
> > +#define __is_ptr_or_array(p)	(__builtin_classify_type(p) == 5)
> 
> That magic constant is a bit ugly, but I don't think there's a better
> way. However, a comment saying "pointer_type_class in gcc/typeclass.h in
> gcc source code" or something like that might help. Do we know for sure
> that clang uses the same value? I can't find it documented anywhere.

Very true. Offlist, Keith Packard suggested I switch to this, so we can
avoid the constant:

+#define __is_ptr_or_array(p)	(__builtin_classify_type(p) == \
				 __builtin_classify_type(NULL))

> 
> __check_ptr_add_overflow() - Calculate pointer addition with overflow
> checking
> > + * @a: pointer addend
> > + * @b: numeric addend
> > + * @d: pointer to store sum
> > + *
> > + * Returns 0 on success, 1 on wrap-around.
> > + *
> > + * Do not use this function directly, use check_add_overflow() instead.
> > + *
> > + * *@d holds the results of the attempted addition, which may wrap-around.
> > + */
> > +#define __check_ptr_add_overflow(a, b, d)		\
> > +	({						\
> > +		typeof(a) __a = (a);			\
> > +		typeof(b) __b = (b);			\
> > +		size_t __bytes;				\
> > +		bool __overflow;			\
> > +							\
> > +		/* we want to perform the wrap-around, but retain the result */ \
> > +		__overflow = __builtin_mul_overflow(sizeof(*(__a)), __b, &__bytes); \
> > +		__builtin_add_overflow((unsigned long)(__a), __bytes, (unsigned long *)(d)) || \
> > +		__overflow;				\
> > +	})
> 
> So I've tried to wrap my head around all these layers of macros, and it
> seems ok. However, here I'm a bit worried that there's no type checking
> of the destination. In particular, the user could perhaps end up doing
> 
>   check_add_overflow(p, x, p)

I tried to make sure the top-level filtering would require a pointer to
an integral type. I'm sure there is a way to foot-gun it, if one tries
hard enough. :)

> 
> which will go horribly wrong. Do we have any infrastructure for testing
> "this should fail to compile"? It would be good to have, not just for
> this, but in general for checking our sanity checks.
> 
> Another thing is that this will always fail with negative offsets (if b
> has signed type and a negative value, the multiplication won't fit in an
> unsigned type). I think __bytes should be ptrdiff_t.

Ew. A negative "add"... yes. I'll take a closer look.

Thanks for the review!

As it turns out, I may not need this patch at all yet, so I may hold off
on it until I can prove that we really will need it.

-Kees

-- 
Kees Cook

