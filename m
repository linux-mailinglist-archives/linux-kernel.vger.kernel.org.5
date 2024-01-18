Return-Path: <linux-kernel+bounces-29588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0537831085
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEF91F22666
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FCFA5C;
	Thu, 18 Jan 2024 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BfDwjsp2"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C4A20
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705537721; cv=none; b=SqkV85fZ+lqJArU0o7ehuYK7D+15Jin7S04v3XwmtzihKG87LjxLXU4mYMbnOmct8PdZNIF8xbvHuAULUmhzC4JbUoEBJLsed3Gec/c0c2mUBqaIAgqIc7D/g09uEa1xGDRoapEjEUHkFu4gAOuGNUzL4kkptTWCz873ghzig4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705537721; c=relaxed/simple;
	bh=RGt7rY5kBSTowAqUQ4gSymkaPjpVbt3b/ttQKOGS7+I=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=bOGqwjgT0m/nX/XuVCrRAPlI3S/9wFHxsMbPIYHflWYtVC6m8kncOjHWmjrtQmCRgaDq0RYg0BvfE/IrFHkt/TJKNRR1qHvEQwftMrlYBP7nEuRtDFkg3UbrpfqfmQym1qkm3o69Q1KeIjlCg8DaDUAu6D1sgNsfdQBY3RZjhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfDwjsp2; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5eefd0da5c0so121174527b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705537719; x=1706142519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY0wnVP2IVWwz/uO1z2ovVtLcTm9gQg3X53Rr9rGgIY=;
        b=BfDwjsp2APp4NRvz3ArQMZD86OMhQw57Q7zf3jIVj3L8hhngVPKTgfVnYQJcRQ0EuV
         uxjzUeRg6blvV0APuYduCCkDLlOF1bl45B5UmgKu6AL4TdEnUWSgRMB+pWaV/iP2Q2pz
         Ar3ock9FP9ChcAXh7JRLhZDLB5MnNg8fFFe0Xi8wjNuS6+N+oir2sMPFbeFYzNsEOklb
         dZOx83OL4mTWAnCIJcwdW3xrrQcjtq8np0gLFz+j3FE6/T5yDqdg37TDwCPQBpKPSU+H
         F/KuAvYKHzM4Hqw0uiEgDYL3mR37PtRDKDgZ/yobA8rAFA7quoqajvP69RfztdXH0uKb
         m3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705537719; x=1706142519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY0wnVP2IVWwz/uO1z2ovVtLcTm9gQg3X53Rr9rGgIY=;
        b=jZTQGzQn87k0IGln/EZSybYYsnZP6QNEEg7jtkghxm2WItZoGJsN5dgVLghxrzuWci
         x+JMs9BxfiG7ivjcv8MAiDBc/MZGehuB1Nhn/YZaUzrQIPVFnpoQKKYfZW01lgKNJcCf
         2K3n2v3i3O4he3O+hdiDOhgUq6ly0ksHirhyRlKDHanFJ3YC5gZN8tqV2VyAbEGsnLKw
         KafgFxwRdQXc+6wWDCmzL5Wup2lf5gKCmGL6ZbnrdzijbPF9LAgci748wI6Md9NybAzQ
         EndKeiTf1XCLodjyRcojBzvCxR/8H1OuKA0HnyMwsl6CG+OF9AuUOlU/B8XZ3QORXkP8
         6h6A==
X-Gm-Message-State: AOJu0YxaIycBd9egVCPUslkRA0Ca1KXcavFr5oQ6SKRThF+yQJGadvrc
	8mrh9vyg3fTK2rNtMXdBzOfMghYQZZIjfa9EgxL2y8RJOiVUC+0/WiSQ6+HqHoEPmkPTgMJZ04b
	hW+lKvZcTEyY0iqSy/1n/WS8IcJmn6GappfAX
X-Google-Smtp-Source: AGHT+IHPUIfgjLqHB+yEcEOpBY1uwAF24/DOg1T1dLE2qFz25IuG0GYLrSb6RCT8bk4nnZaTkSlUcKgc2cdTp1Pbgj4=
X-Received: by 2002:a81:91c6:0:b0:5eb:5ebb:7155 with SMTP id
 i189-20020a8191c6000000b005eb5ebb7155mr57018ywg.15.1705537718591; Wed, 17 Jan
 2024 16:28:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAHbLzkoL6sCDciHqVMJga288853CHdOTa5thOPQ9SHKSqjGGPQ@mail.gmail.com>
 <CAJuCfpH_Lr5HgVA-rXg6J0-BBq+__gDmh-XbhTynKOFmNef8kw@mail.gmail.com>
 <CAJuCfpF7tK07rGHyWPFSVe=Lwv0_zN-J9WsV+nkhJffY+xdXkw@mail.gmail.com> <CAHbLzko=pN_5NtU_=aKTMs9c+GHMn0_gKMs5SifQzaR68hD6KQ@mail.gmail.com>
In-Reply-To: <CAHbLzko=pN_5NtU_=aKTMs9c+GHMn0_gKMs5SifQzaR68hD6KQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jan 2024 16:28:27 -0800
Message-ID: <CAJuCfpHq3nSVNftnZgn8NdF-SYOQjUXcUq=rUDcKXvZH3pq=yQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Yang Shi <shy828301@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 4:15=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Wed, Jan 17, 2024 at 4:11=E2=80=AFPM Suren Baghdasaryan <surenb@google=
com> wrote:
> >
> > On Wed, Jan 17, 2024 at 4:09=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Wed, Jan 17, 2024 at 4:07=E2=80=AFPM Yang Shi <shy828301@gmail.com=
> wrote:
> > > >
> > > > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@kerne=
l.org> wrote:
> > > > >
> > > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > > >> Align larger anonymous memory mappings on THP boundaries by
> > > > > >> going through thp_get_unmapped_area if THPs are enabled for
> > > > > >> the current process.
> > > > > >>
> > > > > >> With this patch, larger anonymous mappings are now THP aligned=
.
> > > > > >> When a malloc library allocates a 2MB or larger arena, that
> > > > > >> arena can now be mapped with THPs right from the start, which
> > > > > >> can result in better TLB hit rates and execution time.
> > > > > >
> > > > > > This appears to break 32bit processes on x86_64 (at least). In
> > > > > > particular, 32bit kernel or firefox builds in our build system.
> > > > > >
> > > > > > Reverting this on top of 6.7 makes it work again.
> > > > > >
> > > > > > Downstream report:
> > > > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > > > > >
> > > > > > So running:
> > > > > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp=
_vmlinux.btf
> > > > > >
> > > > > > crashes or errors out with some random errors:
> > > > > > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_size=3D=
0 type=3D181346
> > > > > > Error emitting field
> > > > > >
> > > > > > strace shows mmap() fails with ENOMEM right before the errors:
> > > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > > ...
> > > > > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cannot a=
llocate
> > > > > > memory)
> > > > > >
> > > > > > Note the .tmp_vmlinux.btf above can be arbitrary, but likely la=
rge
> > > > > > enough. For reference, one is available at:
> > > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > > >
> > > > > > Any ideas?
> > > > >
> > > > > This works around the problem, of course (but is a band-aid, not =
a fix):
> > > > >
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsign=
ed long
> > > > > addr, unsigned long len,
> > > > >                   */
> > > > >                  pgoff =3D 0;
> > > > >                  get_area =3D shmem_get_unmapped_area;
> > > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > > > > !in_32bit_syscall()) {
> > > > >                  /* Ensures that larger anonymous mappings are TH=
P
> > > > > aligned. */
> > > > >                  get_area =3D thp_get_unmapped_area;
> > > > >          }
> > > > >
> > > > >
> > > > > thp_get_unmapped_area() does not take care of the legacy stuff...
> > > >
> > > > Could you please help test the below patch? It is compiled, but I
> > > > don't have 32 bit userspace or machine to test it.
> > >
> > > Hmm. I think you misunderstood me. This is happening on x86_64 emulat=
ed system.
> >
> > I mean it's x86_64 Android emulator, so kernel is 64bit.
>
> No, I didn't. This patch is aimed to solve the -ENOMEM problem
> reported by Jiri Slaby. I believe his test was run on 32 bit machine
> or 32 bit userspace on 64 bit kernel.

Oh, sorry, I didn't realize you were asking Jiri to test for the
problem he reported :)

>
> >
> > >
> > > >
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index 94ef5c02b459..a4d0839e5f31 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -811,6 +811,9 @@ static unsigned long
> > > > __thp_get_unmapped_area(struct file *filp,
> > > >         loff_t off_align =3D round_up(off, size);
> > > >         unsigned long len_pad, ret;
> > > >
> > > > +       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> > > > +               return 0;
> > > > +
> > > >         if (off_end <=3D off_align || (off_end - off_align) < size)
> > > >                 return 0;
> > > >
> > > >
> > > > >
> > > > > regards,
> > > > > --
> > > > > js
> > > > > suse labs
> > > > >
> > > >

