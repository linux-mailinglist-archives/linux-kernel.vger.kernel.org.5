Return-Path: <linux-kernel+bounces-89089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60E86EA57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7F0B20946
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD73C47A;
	Fri,  1 Mar 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NFYP+4Nn"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726243B795
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324969; cv=none; b=itdZTTAMGVaNsHBM7PdRNW+9RGKihyrtoH6nNnwef/EfC8TsY9bCnQNs4YLWIx6wpcGV82RKN4FVGEE5sl1c4wZ5qCE4wG8W1mIh1VoR7Hk9w693YfEkmC7KBOII30dp9tWE/ycFf7qtS/nz1zRUlRenYp1BvAY3mwovMMmosXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324969; c=relaxed/simple;
	bh=lY1M7XvAe4z3xW/aHER3sstij01V5RYloi+hF3mLnqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkXYJXxa07MM4RIs4QyOSBftNE+USOZeP970mGp24Y2DVIea/5C/x1xdzUPE3rlsNfw0lh4Xp65CG6Hu9pT1S3TIMvIzL5dJ4jkzP/UihKT56cPAZrFg8pAFRIBp4iEAh6suYn684OX+LH+Eii5EACAKW9DysQ7L4g2pGZ8A0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NFYP+4Nn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso2270087b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709324968; x=1709929768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uX4LCOmXabkT2zWb6MvvpjJWPlAoaia9rOgotZGNs1M=;
        b=NFYP+4NnEYJQK+DP/+lVnanpr4cx+7mAW26Bv4vf5SJyZdEUW/aN00XLEKnkUBcmXS
         MUbD8Xsr+5pHhMw0dEpFsNNvn1d0jF9wT1/i7Oj6utornQnGfsoIFSRD/EwyfuHsfNd2
         YrLm+3uQNJmnnBa9kfwjcXTYSgARExJRuGAuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324968; x=1709929768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX4LCOmXabkT2zWb6MvvpjJWPlAoaia9rOgotZGNs1M=;
        b=H0Qm+aVuh5ySOuJp84NxHkLHlsXAgchYiViEXoxpq/7NlcK9Cx674qkgoQu0nDMyut
         agAXApuZCr/2Emynyl5R0i1TSdQJYxvLZRbn/NHPp65RVVFqqLqNFhuw9OraG5tmqp5L
         5XS0pYDEIIyclbGKQYcaYYjFUn5s5x+8Tp1iaeNfFKIIq4dclEX7IRdGhe6sOugcW1Xl
         TOY89Up3yLP47OzxtDgnqyr6XqxKsess0ywz7IvSz+zm3Dldi2NtVt9jE2kb1/7ybdkt
         fLVT8A0zf/mEGUdxA5z93/5Xo1Nq/M/tMSEHu7iPnMfKd2iMjTOt7KgME/dq+dUrAkml
         MWkA==
X-Forwarded-Encrypted: i=1; AJvYcCXfIcDGztN3LAKuYdVIeaFN8nZGSK4W7d0k7m24cn/HuXtFOT4EQ/LfW6h08A86fYjqr1jdfna3MGmuLlaZn9oqlYTfm0gRoy/Vg0Vq
X-Gm-Message-State: AOJu0Yz3aKIMSdZTO2tghhkQnNgT6EqEKNzrOVhoKhjZ3mgptEKTlzjJ
	y1aM6KGRSUpY8tn2mnBz1VIWeV06QvvaXZlmfrFBT6q/S84kJDESXYd613SsrQ==
X-Google-Smtp-Source: AGHT+IGC7DoYc1DKeYyd+Zj6CpoEtnPTOkULM9u+8uslMr+Qkuc2usm+ZIcd5hSRFzYUXEXYgYBZ9g==
X-Received: by 2002:a05:6a00:23c8:b0:6e4:eee0:57ad with SMTP id g8-20020a056a0023c800b006e4eee057admr3218997pfc.20.1709324967820;
        Fri, 01 Mar 2024 12:29:27 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b76-20020a63344f000000b005dc4829d0e1sm3433867pga.85.2024.03.01.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:29:27 -0800 (PST)
Date: Fri, 1 Mar 2024 12:29:26 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] string: Convert helpers selftest to KUnit
Message-ID: <202403011227.6C63925@keescook>
References: <20240301002416.it.092-kees@kernel.org>
 <20240301002650.1544829-2-keescook@chromium.org>
 <CAHp75Vf+zzVyVZ=fcXgdCMsp1MZdHmJ1aBTKFE4jHai2pWi27g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf+zzVyVZ=fcXgdCMsp1MZdHmJ1aBTKFE4jHai2pWi27g@mail.gmail.com>

On Fri, Mar 01, 2024 at 01:20:41PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 1, 2024 at 2:26 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Convert test-string_helpers.c to KUnit so it can be easily run with
> > everything else.
> 
> ...
> 
> > -#include <linux/array_size.h>
> >  #include <linux/init.h>
> > +#include <kunit/test.h>
> 
> I know the order is broken here, but don't make it worse, please. And
> stick with one schema where to put kunit/test.h always before
> everything else and somewhere else (like always after linux/*).

Fixed.

> 
> > +#include <linux/array_size.h>
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> 
> ...
> 
> > +static void test_string_check_buf(struct kunit *test,
> > +                                 const char *name, unsigned int flags,
> > +                                 char *in, size_t p,
> > +                                 char *out_real, size_t q_real,
> > +                                 char *out_test, size_t q_test)
> >  {
> > -       if (q_real == q_test && !memcmp(out_test, out_real, q_test))
> > -               return true;
> > +       int result;
> > +
> > +       KUNIT_EXPECT_EQ(test, q_real, q_test);
> 
> This needs a message.
> 
> > +       result = memcmp(out_test, out_real, q_test);
> 
> > +       KUNIT_EXPECT_EQ(test, 0, result);
> 
> Why do we need this assertion? We have a dump below to show what's wrong.

I've improved this all around with ...STREQ and ...MEMEQ calls, and
added _MSG versions where needed to retain the prior reported test
context.

> ...
> 
> > +#define test_string_get_size_one(size, blk_size, exp_result10, exp_result2)      \
> > +       do {                                                                     \
> > +               BUILD_BUG_ON(sizeof(exp_result10) >= string_get_size_maxbuf);    \
> > +               BUILD_BUG_ON(sizeof(exp_result2) >= string_get_size_maxbuf);     \
> 
> No analogous assertions in KUnit?

It's designed for runtime testing. This is fine as-is for compile-time
asserts.

Thanks for the reviews!

-Kees

-- 
Kees Cook

