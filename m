Return-Path: <linux-kernel+bounces-29577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06B983105E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77865283564
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC0630;
	Thu, 18 Jan 2024 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0m3Luz5"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D5370
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536674; cv=none; b=RZ6SNoYjl1o5QKZ69+ppSKZ7mHjMHsvddq+c6OtxtWJETkql/frt52LaR+I3y+fMEvDDxn0BU8rUo19Py5EBfXxtG0dk4dE51xuxtTrBz9c1704poheoLrjvqspHZ/Jj8rYaYY7YjrC+NEhkXNnfVW/Vb6pRm05qKZREn58mPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536674; c=relaxed/simple;
	bh=0cy4KIXUASFhW97OAs+eymqmHd51eLlQbcrYnDf5r2s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=RtdYtseYU80hX1bRq92Fl+px+7oB9d2zV4CgqmQs6se95JtZK8Jt7WREDCoayEjGqjiqSalhdY0LghDQRFCE2pgMyRs+S8MrlFi63tzGrC8bxPJ0E5ATQg/5ZjzENBB7/BI9YGpQuxqTbxaRmVxGpbi+j23iAv2zrF8uVyQzgX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0m3Luz5; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ff828b93f0so3823507b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705536672; x=1706141472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoDZgidcfDcF1qVsgYjkpOu/KB4eCKUf/VJq/PI9JJY=;
        b=g0m3Luz5on1adarGeCpvUUnrGwlEXHM6dgTXSI7amx0dUevHG6Cjk/tVk7Ek073qjv
         TVfMIlm82zLwo5slaTIlMvylbDzQbKJv9dvkxwq3DOaO6VTv2VYea9Q2wU0o1RmY7xn7
         EzDwsvIABmWosg7419sonfr/FCKo3cWXIpgrWilYWjIUoGhlwGj415/RDPsUMZX0dIX4
         25glPMp47h+ugINWH8KVBeHs/3E6IVL6gjBmGekz26+WtoViRy9kJtDg0I1RyLz9TCzJ
         lBiNg6MSyh9kZeUJaS2rTQH9s9F3A1yZLU84ybNY+YMXgmi3b86/JXxYFAb9Z0ZbqSHS
         WF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705536672; x=1706141472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoDZgidcfDcF1qVsgYjkpOu/KB4eCKUf/VJq/PI9JJY=;
        b=UfrlgSkDbSdfsbbz2fgGjKT9G1YxEkOfaqJFY8Jp3xWWmVK/x/+LX1CJS4x1E56jFK
         Eapv6nAk4lpOobd8ByYKETFLIX5oa0Tu36Okr9Ryn1vA11PY4eFUG/tY30Z4plt9/63L
         iAwmq6QY2yaDn7WJ2ZXKFtxgW5BAu3uJzM4qCQvzxAxco3sKMWv3/4NKbY5bFindEXvJ
         2SLrlWP9loAv5dZ8gE7tuKgGgHgVr+gpOhVNTp/oorSb+/M5Xh0re3bgYBJ25dvHrLqw
         /bh+DUiF/aSH6XDTLqfqhMKNprrTeamLbRvXJ5Aqbmko9VDKdRM9KPS143/Fpe3RRPrT
         USZg==
X-Gm-Message-State: AOJu0Yys+vzeybMj0FvXrYtmEF8XqhNchDbmL31wepuhxoDfmO5JGXFw
	gRlQd5ilwaJQUfqLmqosis59hkl7wRf9NShKoEEayhvowwzpIVZQ2AGGWoQUWnB5yDlXrscg1lL
	yqnYB2+vPimld0nGRwjBq2ZCYZ6qMGWZLJwLy
X-Google-Smtp-Source: AGHT+IHLrYpLoBhkEmiQ/l5XTtyxJhQzMl5guq0AWfDPU3CEMKgzuCK8+TXekH1cTOV6v7QI7bHSur5R1aZ7Tfy7yUc=
X-Received: by 2002:a81:a08a:0:b0:5ff:5222:5214 with SMTP id
 x132-20020a81a08a000000b005ff52225214mr40555ywg.22.1705536671713; Wed, 17 Jan
 2024 16:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAHbLzkoL6sCDciHqVMJga288853CHdOTa5thOPQ9SHKSqjGGPQ@mail.gmail.com>
 <CAJuCfpH_Lr5HgVA-rXg6J0-BBq+__gDmh-XbhTynKOFmNef8kw@mail.gmail.com>
In-Reply-To: <CAJuCfpH_Lr5HgVA-rXg6J0-BBq+__gDmh-XbhTynKOFmNef8kw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jan 2024 16:11:00 -0800
Message-ID: <CAJuCfpF7tK07rGHyWPFSVe=Lwv0_zN-J9WsV+nkhJffY+xdXkw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Yang Shi <shy828301@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 4:09=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jan 17, 2024 at 4:07=E2=80=AFPM Yang Shi <shy828301@gmail.com> wr=
ote:
> >
> > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@kernel.or=
g> wrote:
> > >
> > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > Hi,
> > > >
> > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > >> Align larger anonymous memory mappings on THP boundaries by
> > > >> going through thp_get_unmapped_area if THPs are enabled for
> > > >> the current process.
> > > >>
> > > >> With this patch, larger anonymous mappings are now THP aligned.
> > > >> When a malloc library allocates a 2MB or larger arena, that
> > > >> arena can now be mapped with THPs right from the start, which
> > > >> can result in better TLB hit rates and execution time.
> > > >
> > > > This appears to break 32bit processes on x86_64 (at least). In
> > > > particular, 32bit kernel or firefox builds in our build system.
> > > >
> > > > Reverting this on top of 6.7 makes it work again.
> > > >
> > > > Downstream report:
> > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > > >
> > > > So running:
> > > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vml=
inux.btf
> > > >
> > > > crashes or errors out with some random errors:
> > > > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_size=3D0 ty=
pe=3D181346
> > > > Error emitting field
> > > >
> > > > strace shows mmap() fails with ENOMEM right before the errors:
> > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > ...
> > > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cannot alloc=
ate
> > > > memory)
> > > >
> > > > Note the .tmp_vmlinux.btf above can be arbitrary, but likely large
> > > > enough. For reference, one is available at:
> > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > >
> > > > Any ideas?
> > >
> > > This works around the problem, of course (but is a band-aid, not a fi=
x):
> > >
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned l=
ong
> > > addr, unsigned long len,
> > >                   */
> > >                  pgoff =3D 0;
> > >                  get_area =3D shmem_get_unmapped_area;
> > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > > !in_32bit_syscall()) {
> > >                  /* Ensures that larger anonymous mappings are THP
> > > aligned. */
> > >                  get_area =3D thp_get_unmapped_area;
> > >          }
> > >
> > >
> > > thp_get_unmapped_area() does not take care of the legacy stuff...
> >
> > Could you please help test the below patch? It is compiled, but I
> > don't have 32 bit userspace or machine to test it.
>
> Hmm. I think you misunderstood me. This is happening on x86_64 emulated s=
ystem.

I mean it's x86_64 Android emulator, so kernel is 64bit.

>
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 94ef5c02b459..a4d0839e5f31 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -811,6 +811,9 @@ static unsigned long
> > __thp_get_unmapped_area(struct file *filp,
> >         loff_t off_align =3D round_up(off, size);
> >         unsigned long len_pad, ret;
> >
> > +       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> > +               return 0;
> > +
> >         if (off_end <=3D off_align || (off_end - off_align) < size)
> >                 return 0;
> >
> >
> > >
> > > regards,
> > > --
> > > js
> > > suse labs
> > >
> >

