Return-Path: <linux-kernel+bounces-97759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B185876F0A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E3AB21455
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBF736126;
	Sat,  9 Mar 2024 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEiw/en1"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194FD12E5B;
	Sat,  9 Mar 2024 03:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709956734; cv=none; b=aL/VsJNjR0aaK7BqulaP5E62Ady+tFTCfsVe/wYbPM//JyQX/XlSy+yWL0iGXVa3ZG50cVuQk6ZvBFydW9axg7jCSCpVwJvnpO4FwB+McN3ckB3Xve7Ff4ezIAmjTyAFyygQAQZdKHgvX9vydo2PzTTZFFpocuI5+facuTvsk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709956734; c=relaxed/simple;
	bh=WOWDmQLOfrcLJP+YuwqPLvKgx1NT/RrP7qLlDsih1q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRVmJBMXyL01uswMKMGxOcPPc0oaI8DgN6oeMOU+IKMcwMaUoy5qLeQoofHSiR/Vx/9VLvQiaBJQoeJ669MVxT4ww5u0Wslcm/1PAbcVj4GjGFC+commsQ19UoLe+hhD8J1sj0XQM0tEU78U+osTGqb17UpskwRVPLxzfcTeyVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEiw/en1; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7db26980225so662250241.0;
        Fri, 08 Mar 2024 19:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709956732; x=1710561532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7n9LEXpLClFkriaPc7m9Dsp028MApBRBmYp4M2ZTTo=;
        b=YEiw/en11VaW4j4Y5VrS1VyEFS9QTboBsu4CSwHbFZO4b1nNQH393t8IZFx6Jw1XMJ
         jH5HuYdNxa6xc4ewrK28B65caiUKaPGeEjxs/RweTVxajyKlXFzMT823VPA3FLvl2F2A
         sEIBY4peeNkigbXOSqXNNu6mGwGTDyr4aihAZgjrG7ks5U8pXvV+6F2xBNXXKoBRkADG
         UjYhSvyBOmDt723g1mQDbmvHlmnFm1ScshatHJG8TpIWwm9vFi7cWCG5QBZ9FrgOAtTa
         j3G+MeMJ7vJxAqSbrImcx+9ub3BAuBUx3T3jlq3luxMkVfGuMJC43yrP6a7P2T+Rm1/s
         9A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709956732; x=1710561532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7n9LEXpLClFkriaPc7m9Dsp028MApBRBmYp4M2ZTTo=;
        b=IQu5xGpkq5NhM/nFYmHQnOL27P3NV6vTXLp8Jd4rX20aH7JfZmpgvmgsxRA65lntbp
         XnyVf4mO5K0M5WA8q1vI4RKpYfVwdfK6Izdky51VmVXcVNWhywda4U5diOBjBnVFq+xE
         jmmOr7Ao6J+7Vh0Xpg7S6QMnuAGCJ2Cmz9tug5m9o+/PfLg/Tl2Z1dkPbe5a6Uv+ecg4
         To9Tq+Gh+CCJDTr10PiOgkDkpqx2ogH1mf/4CA4bSRhodBD0ZKkz6xAJkqjbmWlM+8WC
         SjaCM1V7fdS9tJmZYyHBEf+y8iuwKlP3faPOc/2n/pHghMke2njLuqR+//Xoto4h8Jyg
         oRGg==
X-Forwarded-Encrypted: i=1; AJvYcCVNnjnrsKmxBuvjLeR4hwilyT89d1sD8gyk/qqKFc2Y+O7L4Zb8fWIJv7aErVK2pEOLn7tLDt3xo++Imf9o3U0hCrwOhfevW5gNeX1LCWKD4R1r8hfzCfR3DzFkdmdj4thJGnJ+0kmsQ8ax
X-Gm-Message-State: AOJu0Yy2LPNqm4nWofqJ1vLRw47FG6zf0h4QvBAXy5tOaZxkJewv2+M7
	EdtHPX1xcTsixowEhmxshmZripvKprwKaU+vQo7GSHUo+TF8RC3RgUPxbuFl56vEqO9dyuwtxLO
	4GTESz8PlOrPXD8zYdHcFAtdqsMg=
X-Google-Smtp-Source: AGHT+IFb7GMtTiKxWFYZHNVCtOCEKDF3SdV9CJvzSD4QbYGTRENQ1u704E8MXErV/KDPVJ6RLIpg9g8X3puZGDq+nFE=
X-Received: by 2002:a67:f4d3:0:b0:471:f1a2:13c8 with SMTP id
 s19-20020a67f4d3000000b00471f1a213c8mr627866vsn.11.1709956731762; Fri, 08 Mar
 2024 19:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081135.173040-1-21cnbao@gmail.com> <CAGsJ_4wMGNDcgc3pqSUicYoH7Z_miczkT=uwZU+yhDF0fd57Rg@mail.gmail.com>
 <20240308192334.845b27504a663ec8af4f2aad@linux-foundation.org>
In-Reply-To: <20240308192334.845b27504a663ec8af4f2aad@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 9 Mar 2024 11:58:39 +0800
Message-ID: <CAGsJ_4xSwNZmHN5GvipS-1kELX2NBwHxoGE=aG4sekm1LcYVPw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] zswap: remove the memcpy if acomp is not sleepable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: herbert@gondor.apana.org.au, chriscli@google.com, chrisl@kernel.org, 
	ddstreet@ieee.org, linux-kernel@vger.kernel.org, sjenning@redhat.com, 
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>, davem@davemloft.net, 
	hannes@cmpxchg.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
	zhouchengming@bytedance.com, nphamcs@gmail.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 11:23=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 8 Mar 2024 19:57:38 +0800 Barry Song <21cnbao@gmail.com> wrote:
>
> > Hi Andrew,
> >
> > On Thu, Feb 22, 2024 at 4:11=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > In zswap, if we use zsmalloc, we cannot sleep while we map the
> > > compressed memory, so we copy it to a temporary buffer. By
> > > knowing the alg won't sleep can help zswap to avoid the
> > > memcpy.
> > > Thus we introduce an API in crypto to expose if acomp is async,
> > > and zswap can use it to decide if it can remove copying to the
> > > tmp buffer.
> > >
> > > -v6:
> > >  * add acked-by of Herbert, Thanks!
> > >  * remove patch 3/3 from the series, as that one will go
> > >    through crypto
> >
> > Can you please pull this into mm-tree? This used to have 3 patches.
> >
> > 3/3 was separated according to Herbert's requirements and has
> > been in a crypto tree.
> > crypto: scomp - remove memcpy if sg_nents is 1 and pages are lowmem
> > https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.g=
it/commit/?id=3D77292bb8ca
> >
> > Two drivers fixes(patch 1 needs) have also been in crypto tree:
> > crypto: hisilicon/zip - fix the missing CRYPTO_ALG_ASYNC in cra_flags
> > https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.g=
it/commit/?id=3Ddb8ac88385
> >
> > crypto: iaa - fix the missing CRYPTO_ALG_ASYNC in cra_flags
> > https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.g=
it/commit/?id=3D30dd94dba35
> >
> > So it should be quite safe to pull this series into mm-tree now.
>
> But this zswap chage requires the presence of the other patches, yes?

As far as I understand, we rely on two driver fixes because those drivers d=
idn't
set the correct cra_flags needed by our patch1. Without those fixes impleme=
nted,
two platforms might encounter issues: Intel with IAA (Intel Analytics
Accelerator)
and Hisilicon with ZIP. Other platforms should be unaffected.

The two driver fixes have been merged into the crypto tree.

>
> So the mm.git tree alone will be buggy?  And if mm.git merges ahead of
> the other trees, there will be a window where mainline will be buggy?

Before 6.9-rc1, there might be issues if mm enters Linus' tree before Herbe=
rt's
crypto tree. However, by 6.9-rc1, everything should be fine.

>
> If so, I think it wuold be better to merge the zswap patch in the next
> merge window.
>

Okay, I understand. Since this patch improves zswap's performance, I wanted
it to be integrated sooner to contribute. However, I'm perfectly willing to
respect your concerns and adhere to the community's best practices.

So please handle it in the best way you think :-)

Thanks
Barry

