Return-Path: <linux-kernel+bounces-30560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A3832085
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330A21F24985
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918102E84E;
	Thu, 18 Jan 2024 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODQEbv7z"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE92E834
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610409; cv=none; b=UXdCWDE4NMv0Y9L69oZeXhcZ4ZCSsS8PHpxMeX5VGXmR0w9NNyjKZG13lRGKCJGQy2owSOHZkXvusrx889qVwLGbSzrImk2c+BSq/B2tfyuA43bqAqwlc3lgAdqpv3gjkb4c8PqT8NWoDTWpe46vlg0Q056JA2wJo5QJskB/bac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610409; c=relaxed/simple;
	bh=oj+woU1qlwRFN6R7LTRvUuNkhRxu+3svD2gHe+UFh4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2ukHaSBRRySaozF1NuVpXiutC8mOccEjuIrWq30cNabYm2kJ+K4BBfdgui2ZUjYYx4azHXThPNo5ZJ2yljzNC1G0NEJhFqhXZoYznnHhYmvbTgjJMVXEpuHYaSA0Tx6j/jFJhylf6h1pH7KvHsicMtqg0VkIKd1uqvniEAkR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODQEbv7z; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso44451a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705610408; x=1706215208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unJHXk3Hp2ibcUfqvrgh8Bl9tlcLgzvJdZ77M8CZ0h8=;
        b=ODQEbv7zX2mpQI7rezUvLDEBO7Sl7liOiSHHMLumYSondnhPTSvwXhoV8STs+JI1sw
         u3lkXrQBY/952G9E8Wzoa5UHaBj0mQPRcm+eqM1AZOyAoliWjXG0VZJKxaqIq3jUPJjl
         03gTluZCInPuYZLuygMiUSdGOJIaELi9u0ayIWsMP6aTalXLqtuOcRBg9nCqV06xn0oq
         BDPHaWaEI1W3iwG8BRnG0j/PbXOUUUaKrYIWeWw/Zs21l1yzH08WF6pkq5T7oLkz9m/5
         nLLjUSKZ7FcZRG3eckBnGEaDHewdXSMtLJFIBVQljpt5orgp6cJ5i3d7splgNVv77idu
         +4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705610408; x=1706215208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unJHXk3Hp2ibcUfqvrgh8Bl9tlcLgzvJdZ77M8CZ0h8=;
        b=cCcPGVz772NvDbtEyH8MZKhuMlykjZjPhIcd1/7NO0J/99Tdd8PmToTS3iYgBEQZMs
         Q1tExn4fMxOFS2SFmfcginpAqQ7X06fBnBvp8t/FZ2WQvtLvZ1WWpQYhr22tV/yMNvNl
         lKMZxy/3z3p7gYKSL0LnrrSpFzEBT/96zWPlWlhyp5pFnvTLaVcYKSEJMZYGhjctqBbI
         aE8oe0uZ57otoyXxgWAdSRlkhBYhnBRBx5DoAyeMHzBGTPxzQvfigDAkM5S2mAaEp+QF
         F3PDqyu3blyka07F32kszjd+2NFLFZ2a3TnUmTbhIWWB/8yV0MKTOKPfeCdqDe/Gpux4
         vr3w==
X-Gm-Message-State: AOJu0YyxAFMDYglx9I1JULWC9YmEoO9BHaBS9CWWeRbYua+Vkzc8lKAU
	zQUKP6YFWUxDfK02evkEcEZmk/pyV4ElEgRGyuHlZw9LSrhDqVvUG2/yH6TJ0KMOg7RE6DR4RS2
	JuymNqh5gJNBLg6c6jXZX6pCx5NY=
X-Google-Smtp-Source: AGHT+IEHGBxZ+QDquZury3ZN0qWI8ZD51kO5nJOfoqW3hk/Y4+0Pwqs6gXwc5RgEeLIPsc4eU/plhD1Ma/HWdNbm13w=
X-Received: by 2002:a17:90b:3794:b0:28d:dd91:fdf5 with SMTP id
 mz20-20020a17090b379400b0028ddd91fdf5mr1436229pjb.23.1705610407970; Thu, 18
 Jan 2024 12:40:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118133504.2910955-1-shy828301@gmail.com> <ZamGsyJ5JTQ9GYNL@casper.infradead.org>
In-Reply-To: <ZamGsyJ5JTQ9GYNL@casper.infradead.org>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 18 Jan 2024 12:39:55 -0800
Message-ID: <CAHbLzkotGn9HifF9GQB5W5wMPZpxQviCFTStHcQCD5D37v8UVw@mail.gmail.com>
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32 bit
To: Matthew Wilcox <willy@infradead.org>
Cc: jirislaby@kernel.org, surenb@google.com, riel@surriel.com, cl@linux.com, 
	akpm@linux-foundation.org, yang@os.amperecomputing.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 12:14=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Jan 18, 2024 at 05:35:04AM -0800, Yang Shi wrote:
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
> I feel sure there are shorter URLs for those messages ...

Oh, yeah, I just found.

[1] https://lore.kernel.org/linux-mm/d0a136a0-4a31-46bc-adf4-2db109a61672@k=
ernel.org/
[2] https://lore.kernel.org/linux-mm/CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZ=
TRpU0eHHKD-sQ@mail.gmail.com/

>
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
>
> I honestly wouldn't even comment this.  But if you must,
>
>         /* Using THP alignment is not as important as address randomisati=
on */

It is not only about address randomization. Removing the comment is fine to=
o.

>
> > +     if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> > +             return 0;
> > +
> >       if (off_end <=3D off_align || (off_end - off_align) < size)
> >               return 0;
> >
> > --
> > 2.41.0
> >

