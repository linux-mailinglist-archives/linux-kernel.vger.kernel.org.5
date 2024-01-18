Return-Path: <linux-kernel+bounces-29582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2AB831068
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62F7EB21E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88039E;
	Thu, 18 Jan 2024 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/isOis1"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C73D191
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536948; cv=none; b=nb3HB/kmH1g/Zk2R+vmmNtWasZlIXwGNLO01W2zvtvrcnWg6r8q3NexRQzzvM/LtIwQxuh6rqtpVTEYrNcrm2q01NMmttB2Nyaj5fo0uL4kvuQSz1Nh47mWnbMbReqNpZrl/D4FMWJ7rGROzq3YtpM+sqoc5iYnZLmret5B+Y5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536948; c=relaxed/simple;
	bh=Xkqs1HhVSl8pg0ra99BVYlhnlNAqTrL09FIkwHCs/PA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=lNHJBIPZTtsACswjexJljn/fx2g32GyhiFvPx9m7zF4ylusapNHJoMGEtrylK7L+otgXaT6gHTM4+3zNlv+ui8flP1wxU/foQypCt28y032BrHMLFpqzQOPPnn61U+TUCER3zCkUOjs/h6+ApjZNpmDZGJMNhwe4/btZ0C8oKcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/isOis1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28e7b2f1988so1539998a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705536946; x=1706141746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IynhXCUI0Z6fOdMc/TR5aKK0TAPM3oTT4ipOlj/ruhI=;
        b=W/isOis1npzaPitiF+m7YdvRHB29IbRkthQybVo7AopKec3fkv2GMr37qPjy6pp7jZ
         XMHJ4kl8UBp97gg45nZXEOszHNdJTk4OApLKhfKfW1AIT6ql8AX4kwzeWCmP04FMI8Lb
         stZCK6caUjIX+KaAGFoH3THRiKoC9ONVaYK6TYigM+HPDfGEDOODdzatyJMKugOOYjNt
         qb5CvvixG+guxzAZ56d12exmkU2PaRuB+C8DvGx8rEDkZa+RGSA3+DniKEYd5rrrT36c
         QLD2uvPQp6pgKdlwkTWkEp0QoHY6NIBempq/sNUyivtoppeo+z/jUL4VN+u8fnQNsMBw
         ySZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705536946; x=1706141746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IynhXCUI0Z6fOdMc/TR5aKK0TAPM3oTT4ipOlj/ruhI=;
        b=dn0Zr7ItiiK8KWN7gFtnSFW4lO4jC2wBCUabGoZi0NYN8lQM5UzYaBBmCx+96r1xJA
         trRhQAML7SsLEywjy0KsfVPYUCfOnfzwpH7ZOLBYjVdSPUD9024LKZ5wUkcRt5bkY5Gi
         Picw5jaEZUZ/tBd5DYuUEiSRE5Nm9G+uF42AgpaLQZwjdjrcizhkJ2gNX3GzHkbduMKu
         ZYRLnQuQX8dTKYnra7W1mbs6l1ljoJC64q8pARJpmRxkgKPpSMcpnq851ENoQEPa7IEP
         mtq/UpxO9F8rqh82upou/RWSHUI4YJVvHuSda1uUwwk7AGOjXhFS0n3vFjjToqnBpP6f
         f26w==
X-Gm-Message-State: AOJu0YziPjc2efjmTOMwkhdBGz12bcWPH066l+0C9febzxMXf7A7z9lh
	6YIW+/+tbAbmebXvq9NBMAN1Loxt/5QKUeLOOZrWjDVudrZCf27vGCNqKEJWJx74iQrAXQEFuTf
	4CXPgRLVRPre1QUET9tWBt46WK5A=
X-Google-Smtp-Source: AGHT+IGqjtmkSakkUWRfxiSFpKIGHiORUfAPzuYNIYFG8LDABnOjD5KjNhbQcS9B0dX8m6m11jRPvBQmBzoIZ5Ld8hw=
X-Received: by 2002:a17:90a:5d8d:b0:290:14a1:d6be with SMTP id
 t13-20020a17090a5d8d00b0029014a1d6bemr44039pji.75.1705536946436; Wed, 17 Jan
 2024 16:15:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAHbLzkoL6sCDciHqVMJga288853CHdOTa5thOPQ9SHKSqjGGPQ@mail.gmail.com>
 <CAJuCfpH_Lr5HgVA-rXg6J0-BBq+__gDmh-XbhTynKOFmNef8kw@mail.gmail.com> <CAJuCfpF7tK07rGHyWPFSVe=Lwv0_zN-J9WsV+nkhJffY+xdXkw@mail.gmail.com>
In-Reply-To: <CAJuCfpF7tK07rGHyWPFSVe=Lwv0_zN-J9WsV+nkhJffY+xdXkw@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 17 Jan 2024 16:15:34 -0800
Message-ID: <CAHbLzko=pN_5NtU_=aKTMs9c+GHMn0_gKMs5SifQzaR68hD6KQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Suren Baghdasaryan <surenb@google.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 4:11=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jan 17, 2024 at 4:09=E2=80=AFPM Suren Baghdasaryan <surenb@google=
com> wrote:
> >
> > On Wed, Jan 17, 2024 at 4:07=E2=80=AFPM Yang Shi <shy828301@gmail.com> =
wrote:
> > >
> > > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@kernel.=
org> wrote:
> > > >
> > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > Hi,
> > > > >
> > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > >> Align larger anonymous memory mappings on THP boundaries by
> > > > >> going through thp_get_unmapped_area if THPs are enabled for
> > > > >> the current process.
> > > > >>
> > > > >> With this patch, larger anonymous mappings are now THP aligned.
> > > > >> When a malloc library allocates a 2MB or larger arena, that
> > > > >> arena can now be mapped with THPs right from the start, which
> > > > >> can result in better TLB hit rates and execution time.
> > > > >
> > > > > This appears to break 32bit processes on x86_64 (at least). In
> > > > > particular, 32bit kernel or firefox builds in our build system.
> > > > >
> > > > > Reverting this on top of 6.7 makes it work again.
> > > > >
> > > > > Downstream report:
> > > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > > > >
> > > > > So running:
> > > > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_v=
mlinux.btf
> > > > >
> > > > > crashes or errors out with some random errors:
> > > > > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_size=3D0 =
type=3D181346
> > > > > Error emitting field
> > > > >
> > > > > strace shows mmap() fails with ENOMEM right before the errors:
> > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > ...
> > > > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cannot all=
ocate
> > > > > memory)
> > > > >
> > > > > Note the .tmp_vmlinux.btf above can be arbitrary, but likely larg=
e
> > > > > enough. For reference, one is available at:
> > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > >
> > > > > Any ideas?
> > > >
> > > > This works around the problem, of course (but is a band-aid, not a =
fix):
> > > >
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned=
 long
> > > > addr, unsigned long len,
> > > >                   */
> > > >                  pgoff =3D 0;
> > > >                  get_area =3D shmem_get_unmapped_area;
> > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > > > !in_32bit_syscall()) {
> > > >                  /* Ensures that larger anonymous mappings are THP
> > > > aligned. */
> > > >                  get_area =3D thp_get_unmapped_area;
> > > >          }
> > > >
> > > >
> > > > thp_get_unmapped_area() does not take care of the legacy stuff...
> > >
> > > Could you please help test the below patch? It is compiled, but I
> > > don't have 32 bit userspace or machine to test it.
> >
> > Hmm. I think you misunderstood me. This is happening on x86_64 emulated=
 system.
>
> I mean it's x86_64 Android emulator, so kernel is 64bit.

No, I didn't. This patch is aimed to solve the -ENOMEM problem
reported by Jiri Slaby. I believe his test was run on 32 bit machine
or 32 bit userspace on 64 bit kernel.

>
> >
> > >
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 94ef5c02b459..a4d0839e5f31 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -811,6 +811,9 @@ static unsigned long
> > > __thp_get_unmapped_area(struct file *filp,
> > >         loff_t off_align =3D round_up(off, size);
> > >         unsigned long len_pad, ret;
> > >
> > > +       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> > > +               return 0;
> > > +
> > >         if (off_end <=3D off_align || (off_end - off_align) < size)
> > >                 return 0;
> > >
> > >
> > > >
> > > > regards,
> > > > --
> > > > js
> > > > suse labs
> > > >
> > >

