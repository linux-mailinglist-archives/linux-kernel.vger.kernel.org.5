Return-Path: <linux-kernel+bounces-30439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE414831EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E4A286B78
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A7D2D60A;
	Thu, 18 Jan 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOQu6kCp"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873072D601
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600132; cv=none; b=QK+UlWSLHnj5W41+7LfQCesm1N0YVuaZVgS7HGEAp1KrjisQ7jO+yulZuZ+v3o7ke0UOgcOIOUTXjEDE3XlIjwatg0oHuWN7+E0nkZjYQpSnTC9DBM02iKw8Hl34Rn0N7GTtnmARfzwSd3KYfRy9ejPPomO/Brkuv8V6Diu5b04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600132; c=relaxed/simple;
	bh=x2ljgtYncxo9smPJhrs2Dwlzt4P3ejdL5CScLYbOmXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXD5nuZAX376+XlOPBHCNjuRJMV9HdpUMmI49oaEFjm9LwuyjPSztdJl01y9NxElTMQaBPWOBPYnSea03V3IvUFwnQJCkme+vYQ++SVVxxgc/0yrzkrzcUwdFB90L1xXiN5HT9hcn+Pp+aRHcIQAwtI9EFFYovQOyoJnU3ZDVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOQu6kCp; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5e734251f48so8473167b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705600130; x=1706204930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xMCVpjt6og7IYSWfVKabA1D+KrdlbrTvIb7TgeO+2U=;
        b=FOQu6kCpC7n710rTKaI8ClQL0nuxvEVW2iLmQu8X2yUZsk3oCbm30F7jg+6RO8nJNF
         Js5UDzfOIafijo7Z4rgAyy6rG5DH09eI4EkIPLEJlyVUaBmUnQNsv02xzAN7lZ5uePJM
         OBgayU0LydwtAuPrc0E5y42Gfzw0Ks0o/5ZGakPVbvGO6Re63UBHvwuR7SQVhqqEJe+V
         mmsf3GZTvMikzGFBv+71UcwBGapTr6SVTFhklgVFuu5rISL/rshhWhYvl3+S/EJJ181B
         jmyytqwkWRmlRHY9+3bn61MiyVKRz8F/oItTI2f0Vilqg2aRpMldXVBi2zf6KMVXt12q
         6G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600130; x=1706204930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xMCVpjt6og7IYSWfVKabA1D+KrdlbrTvIb7TgeO+2U=;
        b=dw7dy3RP/W2eL+2zbvcN6QMqoe9tU1G+39owcKB3fnmo7dGkgRzIaSlvGaT+tUxQwk
         zIHunxKeR9RAnyFMtQjxmGn91Sxq6uHTg4oHIXbiK1fjp50f7QmO92NOOAKueh4WY8ER
         mDExvf0wZnvbsxLLFBm4a+wjafXyURN5ij5GphCogtyPOEv+7IB7+ea+L8qo0PmhN0cj
         mX6AGFSmg6s5lAnabklbtZset1Giz7DG+iZZfyBmC6utUSfVrSTEbr886EDY2w/uRE6M
         SpGoImOCPRCINS4Mm70zhB3+U2Vub04Le4ac2YDajq61Jm7W7HahyPWDrV3JYSWYd/67
         N3ZQ==
X-Gm-Message-State: AOJu0YyNuGS4O7XL62qAFXU8Zcz9Qtd3TrekJWUG5d9aK8SE6F1EEFF1
	bZvuVdi4dXKxHXIPyRVECmKvA2tdFcdnuzTjfU+THKKrSHvUMiuB/FGhaqIljnMmb9XA8LZg3hA
	5IGVNF6lH6QAH9Rhntr8ziCDeVvkHTNUjtZg7
X-Google-Smtp-Source: AGHT+IG53tiLl7cTdCfaGiMMsuvtGsCGttyvvh7ebp0TX11EfeB5sD3LHATqXNJDujKp//K6P7X4Oit3RdJJOpmdg9A=
X-Received: by 2002:a81:8416:0:b0:5ff:7e39:69a0 with SMTP id
 u22-20020a818416000000b005ff7e3969a0mr1670609ywf.31.1705600130272; Thu, 18
 Jan 2024 09:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAHbLzkoL6sCDciHqVMJga288853CHdOTa5thOPQ9SHKSqjGGPQ@mail.gmail.com>
 <7103dfea-0db3-44b7-9b2e-e89d4edd19d7@kernel.org>
In-Reply-To: <7103dfea-0db3-44b7-9b2e-e89d4edd19d7@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 18 Jan 2024 09:48:39 -0800
Message-ID: <CAJuCfpFKLfMM16VbzdaEHaMELgB2pAo6_t1OKsRO80BL2iAzsg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Yang Shi <shy828301@gmail.com>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:05=E2=80=AFPM Jiri Slaby <jirislaby@kernel.org> =
wrote:
>
> On 18. 01. 24, 1:07, Yang Shi wrote:
> >> This works around the problem, of course (but is a band-aid, not a fix=
):
> >>
> >> --- a/mm/mmap.c
> >> +++ b/mm/mmap.c
> >> @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned lo=
ng
> >> addr, unsigned long len,
> >>                    */
> >>                   pgoff =3D 0;
> >>                   get_area =3D shmem_get_unmapped_area;
> >> -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> >> +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> >> !in_32bit_syscall()) {
> >>                   /* Ensures that larger anonymous mappings are THP
> >> aligned. */
> >>                   get_area =3D thp_get_unmapped_area;
> >>           }
> >>
> >>
> >> thp_get_unmapped_area() does not take care of the legacy stuff...
> >
> > Could you please help test the below patch? It is compiled, but I
> > don't have 32 bit userspace or machine to test it.
>
> Yeah, for x86_64, it's semantically the same as the above, so this works
> too:
>
> Tested-by: Jiri Slaby <jirislaby@kernel.org>

With the addition of  #include <linux/compat.h> it builds and passes
our tests as well. Thanks!

Tested-by: Suren Baghdasaryan <surenb@google.com>

>
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -811,6 +811,9 @@ static unsigned long
> > __thp_get_unmapped_area(struct file *filp,
> >          loff_t off_align =3D round_up(off, size);
> >          unsigned long len_pad, ret;
> >
> > +       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> > +               return 0;
> > +
> >          if (off_end <=3D off_align || (off_end - off_align) < size)
> >                  return 0;
>
> thanks,
> --
> js
> suse labs
>
>

