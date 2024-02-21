Return-Path: <linux-kernel+bounces-74127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C1A85D041
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8628A1F25DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE3339FF2;
	Wed, 21 Feb 2024 06:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHdXJ5Sa"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D339FE4;
	Wed, 21 Feb 2024 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495848; cv=none; b=VIP1/zXxzEwcp3sRe8+GeuU3JPJsfjaCs0q2DGctxax7Ggp7pVChy47JJEMBr+2j86Or47pEjv6QjU/GMS52EYqgKnXUPWld9ksK662uuSbfGBTeA2meod4oSeGmp8Uirqaf/PAh5R4Zn+HsOTdY1szbBW97+iNj5WuqRlFG78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495848; c=relaxed/simple;
	bh=nOFgbZ8HBxTz94wttEmZFotxCzQC7NygkRCq5asfT10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kygH3WsnG28FCyCj3gvKg7RNnTAgR8iuNooN9WRtC/51biCSjXSN6lOLh36jY1njVaBZH0FCQaGc9cOFpthiu+4hpLvK026Kl3Xkd5uKCuHgVrGq4UmCHK6fFARSQFARNqnixKGANj8qIT8KwkoVJq/FLCrrGYvVz5nefXMfcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHdXJ5Sa; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so139462241.3;
        Tue, 20 Feb 2024 22:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708495845; x=1709100645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gP/yx5IKqNIOfZ+RA2vffQW+rHFO3lsQYKh8HrE0o3E=;
        b=HHdXJ5SaGesN3QoM3eABmgK5F+SX8IV+DuslS3L7SLDs53TWts7Fklks9moa0IiM9K
         JB/Nd72eaEVmVFAb2xJkAFMAuhkFSHjA89IbHeWQM0yPKwdx1VnbtYKeEIHVbjO+zKUp
         UBYX4o5vgARhcrLq3Q/eu4Tn+ZrB/J63lQDIbNUt+C06XjEyOQpMhCu5UqcN1qiMHdWL
         N+kGDsm19yDog+C40SGQsyqHei8nyg0qnlin5Kir6G7o43QnB6tDe7WRoVj1cStaZZKE
         aoPflG2ADsSUnlwH8CVhfaNwfdv2gVR/X7NrXY2YXFnBFhcNbv9txvkz1Ta/OHiEYGPg
         iWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708495845; x=1709100645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gP/yx5IKqNIOfZ+RA2vffQW+rHFO3lsQYKh8HrE0o3E=;
        b=fmliHnE/a1FTZWVD3Bo2jnRuKcfBgEfijolIoJOOXTzD9pi+uJPWCV3+ngt8Q3un3e
         NDb/TaxF4Ph+PPr+s4HlmRewdFmWgcqTi3GPF1MMNaUQdzIcj02JIrOCSPnTZhDb1RPN
         1VM5yI+6nGr9mEx3zdKEnfMYCpk3EpoDwhRNJK7vcMX2BDLTgXfOKjYs/9ZQaI2NFmbh
         BsJBus2FF7AclF67bWHAVS0MHAbtsoGZquhecsSZfH0hwxBKxSsfJBvM3w5FLoAuIshb
         riQrUMWiZKzRB4mbF+a1a6S6lSwiO10mz+fU/WjfhCvUtOxsfD5w+J3XEDhg80AnmbYv
         u5cA==
X-Forwarded-Encrypted: i=1; AJvYcCV/D2XdjKQqkQ1q0HziZoc4xjQ/as4ayanKgsx27kGmE7SBHkcUoR2vvZKbf72+JxnFvRS+c6EGaH48aQvUnddxdGvd/kQ1qVPURY/P9jBdCLvd6djIM2xf5hlH/Uvhz95G8uqd5v58QBkn
X-Gm-Message-State: AOJu0YwE2iOOeB4Rlk54obCJJVargmQrGWeL7iTtkZuszeBFnsacUuWc
	5hmF0RD7F9zpAxYLOyI3E/r0S99XVzB9tnCmH4EnfWAwRvUYn01jZn1DhB6lDzM7XNhzE7p3MT7
	V+3VjY+4qoRn2C29pd0P0nScOsS0=
X-Google-Smtp-Source: AGHT+IEC4mk/79rg9qunBsxTl0hy7B1wG1nWoGnl3shs9m7Fv4hs8dl+Pn9sauvzLmUcSGHVDFdCF1muxDuOUqrsjGQ=
X-Received: by 2002:a05:6102:1894:b0:470:4bff:830a with SMTP id
 ji20-20020a056102189400b004704bff830amr7751496vsb.13.1708495845413; Tue, 20
 Feb 2024 22:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220064414.262582-1-21cnbao@gmail.com> <20240220064414.262582-4-21cnbao@gmail.com>
 <ZdWLim6zYSl/x1Bk@gondor.apana.org.au> <CAGsJ_4xCgSWz832N8+RsE=5StWwuc1zu3KpeCGxq7LdyVLY+Sg@mail.gmail.com>
In-Reply-To: <CAGsJ_4xCgSWz832N8+RsE=5StWwuc1zu3KpeCGxq7LdyVLY+Sg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 21 Feb 2024 19:10:33 +1300
Message-ID: <CAGsJ_4y69s7-_UW=gaUuk3TJzwj3xRCoZhamsn0-6k65cbeR0A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] crypto: scompress: remove memcpy if sg_nents is 1
To: Herbert Xu <herbert@gondor.apana.org.au>, akpm@linux-foundation.org
Cc: davem@davemloft.net, hannes@cmpxchg.org, linux-crypto@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, yosryahmed@google.com, 
	zhouchengming@bytedance.com, chriscli@google.com, chrisl@kernel.org, 
	ddstreet@ieee.org, linux-kernel@vger.kernel.org, sjenning@redhat.com, 
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 6:55=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Feb 21, 2024 at 6:35=E2=80=AFPM Herbert Xu <herbert@gondor.apana.=
org.au> wrote:
> >
> > On Tue, Feb 20, 2024 at 07:44:14PM +1300, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > while sg_nents is 1 which is always true for the current kernel
> > > as the only user - zswap is the case, we should remove two big
> > > memcpy.
> > >
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> > > ---
> > >  crypto/scompress.c | 36 +++++++++++++++++++++++++++++-------
> > >  1 file changed, 29 insertions(+), 7 deletions(-)
> >
> > This patch is independent of the other two.  Please split it
> > out so I can apply it directly.
>
> Ok. OTOH, patch 3/3 has no dependency with other patches. so patch
> 3/3 should be perfectly applicable to crypto :-)
>
> Hi Andrew,
> Would you please handle patch 1/3 and 2/3 in mm-tree given Herbert's ack =
on
> 1/3?
>
> >
> > > @@ -134,13 +135,25 @@ static int scomp_acomp_comp_decomp(struct acomp=
_req *req, int dir)
> > >       scratch =3D raw_cpu_ptr(&scomp_scratch);
> > >       spin_lock(&scratch->lock);
> > >
> > > -     scatterwalk_map_and_copy(scratch->src, req->src, 0, req->slen, =
0);
> > > +     if (sg_nents(req->src) =3D=3D 1) {
> > > +             src =3D kmap_local_page(sg_page(req->src)) + req->src->=
offset;
> >
> > What if the SG entry is longer than PAGE_SIZE (or indeed crosses a
> > page boundary)? I think the test needs to be strengthened.
>
> I don't understand what is the problem for a nents to cross two pages
> as anyway they are contiguous in both physical and virtual addresses.
> if they are not contiguous, they will be two nents.

second thought,  you are right.  sorry for my noise.
The test was running on a platform like arm64 without HIGHMEM. thus,
kmap_local_page always returns mapped page_address of normal
zone.

but for platforms with HIGHMEM for example arm32, x86_32 , we can't use
the virtual address of the first page as the start address of two pages tho=
ugh
they are physically contiguous.

I will rework on this.  ideally, we should still avoid the memcpy though
two pages are within one nents :-) we are really this case for zswap
as the dst is always two pages in case the compressed data is
longer than the original data.

>
> >
> > Thanks,
> > --
> > Email: Herbert Xu <herbert@gondor.apana.org.au>
> > Home Page: http://gondor.apana.org.au/~herbert/
> > PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
>

Thanks
Barry

