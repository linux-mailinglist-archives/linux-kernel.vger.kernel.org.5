Return-Path: <linux-kernel+bounces-142858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4018A30F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC648B2555E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD94142E7B;
	Fri, 12 Apr 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/UFPVWf"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0D1419B1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932845; cv=none; b=uerYxNbsxc3ZviSg7VRVyYCozqok+yCacFWrqK2Gzr4FOgbq9qHC9cPsfO5tutU9L0ny8WwPJay6CvpGe63B8ecVpa2z9oqy+ISxlbiY8JirmEo7idARCph4/l3+NJJ0UyOQkKSLc1dDsQbFOBNbqvLydx5JfJT4jhrfi8HypiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932845; c=relaxed/simple;
	bh=GimcAQ1+DDN/eeyfcUdWKx5z5LNIjgTUM/wLYv+tNnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSgiC4cIZSRcs1w1GotoW2Jwsh9M69DZK2VRBbq5P7z50LDdMQA7CdLlwwvyQqQE0pJOjEMITy2TIAFLgPjjzWGoT3Lu4IzYldvc4QbQYAUiOys3PqE2XRDW1jHSU42Gvow/Jen4rS/2CovSPHawJoS0yks2Cagp+YntxikM1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/UFPVWf; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d82713f473so15401441fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712932842; x=1713537642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lrqomhnq0OHG4bH9VisndGkKutU0DOn+sYXpL/Qz37s=;
        b=h/UFPVWfJ4jlZr73NRiVz9hDPWvnf/KlaOyFMC8UUAszf8YXmEpZcBeNij0Uw3jVhQ
         k6C0tS13j4S8S5vo683XyNmg81lmNLNyX1gsmuxJpbxEJbc8qQsc99V9AymmhdlZNJdq
         jh8j1JxcpdefyqzFPO3WIwOWR1zaxAWNbHmS4+zWVLHkH8/RN9jV9Db+PK2/0Kllz54+
         ++IfieVjNSVct0Y7xh1OfDTyzhe5RAp9DbaD11Eg1n4O7XAOuOxv0XhEShqmtaK8c4sf
         3sKUKilQRgC3Aaq5cDYNMTR22BoZhimjHaxueLq9F3MEPi/qMuQ13+S4+MsqiM8BoYuN
         ZsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712932842; x=1713537642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lrqomhnq0OHG4bH9VisndGkKutU0DOn+sYXpL/Qz37s=;
        b=IEwAg66b+0meef4Wc+cPSBJvYSmx4kJbnilYaDz5tsgZf2nQlXsTtFxHsO9En5uk8Y
         u0/Yzk88er+tmcEhCBnzYfgNwT+K/hhX7rAX2oQN4nnKwhyNWidKJrd3DT7LOYwCrPa5
         mjlmDqQyZhInwoUQFcMG0dPRxI/+cM39aIgt6KG4oMbf0hDrAA7qXwMJRRsegHGr53g8
         uSi1s4V+2wjcx8zfPjGNNSxCknDhH1suXuxDHjUmmUx8juExJA2VMvV2bE/GfJWoIh2M
         E8jOj07kMPk5CNQ6rSROXlOgiWC8JZjL+X/x5AWW4lb/vbasJXmEMQXPUH4JQlk5ceC6
         KK2g==
X-Forwarded-Encrypted: i=1; AJvYcCUAk47/EwCoYawSizOmPxSNFj5zysXe/DnCV0ZuC9S77JTUHPUcFadCkTW/By3+ow/UlJJnVIo5uvo0OMpbCOGqgyAFIMSsZ2wnsmqa
X-Gm-Message-State: AOJu0YwhNqmD2Y9p/ZGg+lgm0UInGg6lPtMb4qiZ7fClUfxeJOF827j1
	d6UFtfs11NDrXXk6XtJHZ/iqLUzvhOGqtivDlYIftnQtYe28myNq8g4TfDMKXSqUzEu2NvXIKvm
	bVs2FiekbXSqQraK+uIVq6Npv6Zb5mg==
X-Google-Smtp-Source: AGHT+IHCA/r7OFj6KVq+9Bc9/aPA43T7go+Pq48oAgPVS29FSxvpIWrGhrFs2UcQqOkI4WgrU2+yKf5MjhqQ+Us6i58=
X-Received: by 2002:a2e:9e96:0:b0:2d8:64c9:8d39 with SMTP id
 f22-20020a2e9e96000000b002d864c98d39mr2216585ljk.37.1712932841632; Fri, 12
 Apr 2024 07:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412105839.2896281-1-dawei.li@shingroup.cn> <20240412105839.2896281-2-dawei.li@shingroup.cn>
In-Reply-To: <20240412105839.2896281-2-dawei.li@shingroup.cn>
From: Yury Norov <yury.norov@gmail.com>
Date: Fri, 12 Apr 2024 07:40:30 -0700
Message-ID: <CAAH8bW_97sChHOMCEY22jG0jvxZO-qa8syfotz9sF9T6oCr_4Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] cpumask: introduce cpumask_first_and_and()
To: Dawei Li <dawei.li@shingroup.cn>
Cc: tglx@linutronix.de, akpm@linux-foundation.org, maz@kernel.org, 
	florian.fainelli@broadcom.com, chenhuacai@kernel.org, jiaxun.yang@flygoat.com, 
	anup@brainfault.org, palmer@dabbelt.com, samuel.holland@sifive.com, 
	linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 3:59=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn> wr=
ote:
>
> For some cases, it's required to make intersection between 3 cpumasks
> and return possible cpu bit. Current implementation for these cases are

/s/possible cpu bit/set cpu/

And sometimes you just need an intersection cpumask, and don't need to retu=
rn
any set cpu. This patch introduces new API, so description should be as
common as possible.

We've already have some 3-bitmap functions. Can you look at commit messages
there and align your wording?

I'll be OK if you just skip this part and go straight to "Introduce
.. to get rid of"

> allocating a temporary cpumask var(sometimes on stack) storing intermedia=
te
> calculation result.
>
> Introduce cpumask_first_and_and() to get rid of this intermediate orinted

what the 'orinted' is?

> approach. Instead, cpumask_first_and_and() works in-place with all inputs
> and produce desired output directly.

/s/produce/procuces/

>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  include/linux/cpumask.h | 17 +++++++++++++++++
>  include/linux/find.h    | 29 +++++++++++++++++++++++++++++
>  lib/find_bit.c          | 14 ++++++++++++++
>  3 files changed, 60 insertions(+)
>
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 1c29947db848..c46f9e9e1d66 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -187,6 +187,23 @@ unsigned int cpumask_first_and(const struct cpumask =
*srcp1, const struct cpumask
>         return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2=
), small_cpumask_bits);
>  }
>
> +/**
> + * cpumask_first_and_and - return the first cpu from *srcp1 & *srcp2 & *=
srcp3
> + * @srcp1: the first input
> + * @srcp2: the second input
> + * @srcp3: the third input
> + *
> + * Return: >=3D nr_cpu_ids if no cpus set in all.
> + */
> +static inline
> +unsigned int cpumask_first_and_and(const struct cpumask *srcp1,
> +                                  const struct cpumask *srcp2,
> +                                  const struct cpumask *srcp3)
> +{
> +       return find_first_and_and_bit(cpumask_bits(srcp1), cpumask_bits(s=
rcp2),
> +                                     cpumask_bits(srcp3), small_cpumask_=
bits);
> +}
> +
>  /**
>   * cpumask_last - get the last CPU in a cpumask
>   * @srcp:      - the cpumask pointer
> diff --git a/include/linux/find.h b/include/linux/find.h
> index c69598e383c1..047081c6b9f7 100644
> --- a/include/linux/find.h
> +++ b/include/linux/find.h
> @@ -29,6 +29,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned =
long *addr1, const unsign
>                                         unsigned long n);
>  extern unsigned long _find_first_and_bit(const unsigned long *addr1,
>                                          const unsigned long *addr2, unsi=
gned long size);
> +unsigned long _find_first_and_and_bit(const unsigned long *addr1, const =
unsigned long *addr2,
> +                                     const unsigned long *addr3, unsigne=
d long size);
>  extern unsigned long _find_first_zero_bit(const unsigned long *addr, uns=
igned long size);
>  extern unsigned long _find_last_bit(const unsigned long *addr, unsigned =
long size);
>
> @@ -345,6 +347,33 @@ unsigned long find_first_and_bit(const unsigned long=
 *addr1,
>  }
>  #endif
>
> +#ifndef find_first_and_and_bit

Don't need to protect new API unless you've got an actual arch implementati=
on.

> +/**
> + * find_first_and_and_bit - find the first set bit in 3 memory regions
> + * @addr1: The first address to base the search on
> + * @addr2: The second address to base the search on
> + * @addr3: The third address to base the search on
> + * @size: The bitmap size in bits
> + *
> + * Returns the bit number for the first set bit
> + * If no bits are set, returns @size.
> + */
> +static inline
> +unsigned long find_first_and_and_bit(const unsigned long *addr1,
> +                                    const unsigned long *addr2,
> +                                    const unsigned long *addr3,
> +                                    unsigned long size)
> +{
> +       if (small_const_nbits(size)) {
> +               unsigned long val =3D *addr1 & *addr2 & *addr3 & GENMASK(=
size - 1, 0);
> +
> +               return val ? __ffs(val) : size;
> +       }
> +
> +       return _find_first_and_and_bit(addr1, addr2, addr3, size);
> +}
> +#endif
> +
>  #ifndef find_first_zero_bit
>  /**
>   * find_first_zero_bit - find the first cleared bit in a memory region
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 32f99e9a670e..fdc5c4117e8b 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -116,6 +116,20 @@ unsigned long _find_first_and_bit(const unsigned lon=
g *addr1,
>  EXPORT_SYMBOL(_find_first_and_bit);
>  #endif
>
> +#ifndef find_first_and_and_bit
> +/*
> + * Find the first set bit in three memory regions.
> + */
> +unsigned long _find_first_and_and_bit(const unsigned long *addr1,
> +                                     const unsigned long *addr2,
> +                                     const unsigned long *addr3,
> +                                     unsigned long size)
> +{
> +       return FIND_FIRST_BIT(addr1[idx] & addr2[idx] & addr3[idx], /* no=
p */, size);
> +}
> +EXPORT_SYMBOL(_find_first_and_and_bit);
> +#endif
> +
>  #ifndef find_first_zero_bit
>  /*
>   * Find the first cleared bit in a memory region.
> --
> 2.27.0
>

