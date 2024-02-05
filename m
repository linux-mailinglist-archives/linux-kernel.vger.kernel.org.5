Return-Path: <linux-kernel+bounces-53061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A184A031
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1671F22DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC2144C70;
	Mon,  5 Feb 2024 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duG0H4Lp"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A944C64
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152851; cv=none; b=UuPokKd9q/LzfpbpKmR1pYdxL9uNcTAU20y/YZpvSRO15KYENobGSKikiP0AlXAs5ox7ughWTtkNEw8Zbi9o6tBLRZslQFEehJBVvY89mOXRGUTY2qrqfKdS+Ek1Fhc14NjIWBQNcS7ezrI9eum7AJq9pnYHjGGs+2Ch4IMsxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152851; c=relaxed/simple;
	bh=2Q1i1RHrUxU6byBUfds2Q8JCnwTEHlAU9LNt9f1skVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJE3JALaZXWzH9Vtr96Didry99oKeM/5Ed37F3dvriPqfn90vsiOjOcLG4yw4EL/8Q3M9TO9r/qBBoV9b/Jvi2SqIKDhAmF0CjJ5Qyb+0tLOHmLSrsiWYcACxNzM6Qcjz8ik/Ev4KMe1IktDed0Sf+CipGbb3LKkG0XJCd1k+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duG0H4Lp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e04e7b687bso400992b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707152849; x=1707757649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88D1RK/nOy77l4ZbsApJZs4VjFYfeQsWMWLEgTtNVGA=;
        b=duG0H4Lpk6EddW3Ie97Z8gfy+ThPpcHK/t8W0GPR37yrkuDzVXHEhfQ2ScyYupUgZl
         bfTCMi8eJ66ul6/CbkhmYuziC6IKi9QzSMHiN/4wHZbDHi+i1xuqkdMPB0IKxYWK4b2e
         KuwkFaKGXBWEdQK/kYqI5t1EhaYd4DMUXnsJVkSSznt7DtuL35ALNgwyHeBEQRZHYwuY
         alVyn+i76Kxq9UcXbz6K98Sr2Rh00tqd7UQmBrvT2GHXhdnMshqi+pEP5NqxW1XRHzYR
         EmCQpn4sHUzBBXtZOdjzOxAbKKHxUxXdm/hT2Z+85XhpmujAcFaeJ0Az1s8Aq8m30aIQ
         xnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152849; x=1707757649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88D1RK/nOy77l4ZbsApJZs4VjFYfeQsWMWLEgTtNVGA=;
        b=hfCYtYdeRSvUBSciLcAChSBqplbB1xokHT9D20i8HdQdOjf+A13MmzDcRF72v+US3h
         mR8UPA3TgGC4bg66PAGhdE+OXRmbB5Lunk4WmRIThmRkQYQ8PGIVtJVFnGrx/Ez+z6PR
         Bbh5OM2OFmUoaVEFaFlYSX2ptmYmJhCh6dOwOjScdh0qLarSU0Vb7hYlZrfjgA2TPZzH
         tiDjIb1x//X75TUkyUZuiiJnZAzoB46n/PvcozKWQ8VeN9IpRsnI2dOiCPfugRqz3074
         QuuR3lDFVpe6T5HhsEdaBiOFx4hHZT0rbbbhnm5RyAA5FFKEqoZ4+HoHcl22B+R7mO6K
         0VEw==
X-Gm-Message-State: AOJu0YwRNP543VgsooSpqncRWE+LYkzxJKNGmSBQ4cp06Pzrc4L+4lNz
	pzTnmMRH6CjFr9PVgLZMOE6p0cgIDJ++RAFR8Xgvyu0mXSSniMhEQ934EXt/7L9LVHHx3SKnS6U
	G3GuSs6I14OMYIGFd3kVz0rTOg8k=
X-Google-Smtp-Source: AGHT+IG3d9Ex5sF4UKpwysbNM/TqGT2KKEe4K6rs/cP9WQWpfDJTFBMSBnqfKweEDscuLgchA+SD2nBAFH0HEM4EPng=
X-Received: by 2002:a05:6a20:7291:b0:19a:1cff:f574 with SMTP id
 o17-20020a056a20729100b0019a1cfff574mr141172pzk.36.1707152848960; Mon, 05 Feb
 2024 09:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118133504.2910955-1-shy828301@gmail.com> <ad920491-9d73-4512-8996-badace520699@leemhuis.info>
In-Reply-To: <ad920491-9d73-4512-8996-badace520699@leemhuis.info>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 5 Feb 2024 09:07:16 -0800
Message-ID: <CAHbLzkp7s1CcSE0rc-CpfcCrNtMdepAA5-K+0P4wz11x4SK6=g@mail.gmail.com>
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32 bit
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: jirislaby@kernel.org, surenb@google.com, riel@surriel.com, 
	willy@infradead.org, cl@linux.com, akpm@linux-foundation.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>, yang@os.amperecomputing.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 1:24=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 18.01.24 14:35, Yang Shi wrote:
> > From: Yang Shi <yang@os.amperecomputing.com>
> >
> > The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> > boundaries") caused two issues [1] [2] reported on 32 bit system or com=
pat
> > userspace.
> >
> > It doesn't make too much sense to force huge page alignment on 32 bit
> > system due to the constrained virtual address space.
> >
> > [1] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1B=
thSDL8ROvUq2XxZMw@mail.gmail.com/T/#mf211643a0427f8d6495b5b53f8132f453d60ab=
95
> > [2] https://lore.kernel.org/linux-mm/CAHbLzkqa1SCBA10yjWTtA2mKCsoK5+M1B=
thSDL8ROvUq2XxZMw@mail.gmail.com/T/#me93dff2ccbd9902c3e395e1c022fb454e48ecb=
1d
>
> [FWIW, this is now 4ef9ad19e17676 ("mm: huge_memory: don't force huge
> page alignment on 32 bit") in mainline]
>
> Quick question: it it okay to ask Greg to pick this up for linux-6.7.y
> series?

Yes, definitely. Thanks for following up.

Yang

>
> I'm wondering because Jiri's report ([1] in above quote) sounded like
> this is something that will affect and annoy quite a few people with the
> linux-6.7.y.
>
> Ciao, Thorsten
>
> > Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP bounda=
ries")
> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > Reported-by: Suren Baghdasaryan <surenb@google.com>
> > Tested-by: Jiri Slaby <jirislaby@kernel.org>
> > Tested-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Christopher Lameter <cl@linux.com>
> > Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> > ---
> >  mm/huge_memory.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 94ef5c02b459..e9fbaccbe0c0 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/page_owner.h>
> >  #include <linux/sched/sysctl.h>
> >  #include <linux/memory-tiers.h>
> > +#include <linux/compat.h>
> >
> >  #include <asm/tlb.h>
> >  #include <asm/pgalloc.h>
> > @@ -811,6 +812,14 @@ static unsigned long __thp_get_unmapped_area(struc=
t file *filp,
> >       loff_t off_align =3D round_up(off, size);
> >       unsigned long len_pad, ret;
> >
> > +     /*
> > +      * It doesn't make too much sense to froce huge page alignment on
> > +      * 32 bit system or compat userspace due to the contrained virtua=
l
> > +      * address space and address entropy.
> > +      */
> > +     if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> > +             return 0;
> > +
> >       if (off_end <=3D off_align || (off_end - off_align) < size)
> >               return 0;
> >

