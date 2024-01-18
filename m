Return-Path: <linux-kernel+bounces-29576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F5C83105D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A56B20F81
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096C9395;
	Thu, 18 Jan 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuGLPp4Y"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9439191
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536600; cv=none; b=VqCAwGVXSZDSUuWlg2bZreraQXvMTRziZb8E1xC9fx2RPkpn+iBWN9kPABtm2HWBDBTaW3Mu+4tbJ/F8tuU9MlzJXeoR9rKxBkA83kR3ok5CnMAyM9HUWGCNz0mYE7Sw8viKG6q8SxpdHR3bqO/rBfLmOzoNcHlbXR2i4GiCe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536600; c=relaxed/simple;
	bh=6NPTBdTuM2318YZyN9z5uQFEN4h2zarvDoRSHlB5Seo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ocmHh2NfzXHcN+ij5Vg/eeyBvBjdvN9SYdu6FelMr5L2xHUT7mHAC1luu+1hdF4GGwee9ay/URU6A0+m6m7q0LCrdykSdPE0H97R4qDE4LV0QOAA6xvD8XVTeu4lwaJ4xyQ9PXJvI1tq+iXt8A4I6Kqdd0k2lLFzN2ILMkXFQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuGLPp4Y; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f75aee31d2so105635037b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705536597; x=1706141397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWj/m/g6g6US/nsTw5NmJ8dd+nkVoLNoyL8nmayW6s4=;
        b=uuGLPp4Yci7wPRl4aPxxeqsiAZd/sOAiaD31spLKv+Sh0rZzOfzG88bfK27vVePgyX
         Co3A40uMZjjquShHaidXbPRRyeR2dngkcpgZW2CJF6ExFgQT9LLndYC1yPoU7C4kOIOV
         pVVVBF02miQfB7hiwnvpFVLHKsGNHnMoavFsDDUKpuat8dV9g4VmI4QKqKQkAsi7omZb
         TwLi3AP9a4KPxWUaWC0LnE27tcbIJnJHTXek79BoQCcJ08iMmGinJON8DB83hTjBcPaA
         50GirfdaZtKb7HtI1DOUkn7dS8ijOMkQS4P5P3NuBDSJRk30CBE1D7B2IQ1Vf2e7drpt
         flWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705536597; x=1706141397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWj/m/g6g6US/nsTw5NmJ8dd+nkVoLNoyL8nmayW6s4=;
        b=gMVIC0mp2O+OS72yyFFhK2cnn04slEUowMoa2salxSn5ar4B++EIPO/ErpQ5XYA9Ms
         Vqxr+HgBxAnt/xPu1iY+5Zy38VYfdo9N81XmsmA84VIUiN9Kd4jRLFJQeaufTZQJBRL2
         Ylr8gPX9Povy+exJbffye2254mW9CHHbLYAIv7zquHDGqZ/0Y2BKG7x1dU1+RBQh3ba7
         WdudLPuQXdx8Gls6V6IGJNVKeMYnJjai5ylE1Ud4/zybtUjg8ljXH6gV29izY1+FZ3sN
         5f8mQxsbmXddTY+ZsrCpqPZOGWkiLQLraX55fY3RcBV5OMrVZybgq/KJTkHfwuXn0ufv
         l5+g==
X-Gm-Message-State: AOJu0YyifW9yF3lWFut56UwwmeAQ0ORidnb6BlKoLY5LyZzO4vTcNJiW
	/dwHIErXIVFBgcTYbednl9Fx3Z5FBa5cpVNrBfR3TwpRFUkfmIiP+TAeyP2rPlY7NiEdS/sXqvi
	uJywz9K6MtXvIDup0vm5RhJSac+ANP5lCuAdl
X-Google-Smtp-Source: AGHT+IGkkyQpgYqThfZopVmNDT533MxU48Z7x0jPEpVKuX8XeupBR0DuLlFQJLlLZfmwDdSnGUzYv/dErsJU/cMwbR8=
X-Received: by 2002:a81:7103:0:b0:5ee:82ad:5151 with SMTP id
 m3-20020a817103000000b005ee82ad5151mr32472ywc.74.1705536597460; Wed, 17 Jan
 2024 16:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAHbLzkoL6sCDciHqVMJga288853CHdOTa5thOPQ9SHKSqjGGPQ@mail.gmail.com>
In-Reply-To: <CAHbLzkoL6sCDciHqVMJga288853CHdOTa5thOPQ9SHKSqjGGPQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jan 2024 16:09:46 -0800
Message-ID: <CAJuCfpH_Lr5HgVA-rXg6J0-BBq+__gDmh-XbhTynKOFmNef8kw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Yang Shi <shy828301@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 4:07=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org>=
 wrote:
> >
> > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > Hi,
> > >
> > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > >> Align larger anonymous memory mappings on THP boundaries by
> > >> going through thp_get_unmapped_area if THPs are enabled for
> > >> the current process.
> > >>
> > >> With this patch, larger anonymous mappings are now THP aligned.
> > >> When a malloc library allocates a 2MB or larger arena, that
> > >> arena can now be mapped with THPs right from the start, which
> > >> can result in better TLB hit rates and execution time.
> > >
> > > This appears to break 32bit processes on x86_64 (at least). In
> > > particular, 32bit kernel or firefox builds in our build system.
> > >
> > > Reverting this on top of 6.7 makes it work again.
> > >
> > > Downstream report:
> > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > >
> > > So running:
> > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlin=
ux.btf
> > >
> > > crashes or errors out with some random errors:
> > > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_size=3D0 type=
=3D181346
> > > Error emitting field
> > >
> > > strace shows mmap() fails with ENOMEM right before the errors:
> > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > ...
> > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cannot allocat=
e
> > > memory)
> > >
> > > Note the .tmp_vmlinux.btf above can be arbitrary, but likely large
> > > enough. For reference, one is available at:
> > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > >
> > > Any ideas?
> >
> > This works around the problem, of course (but is a band-aid, not a fix)=
:
> >
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned lon=
g
> > addr, unsigned long len,
> >                   */
> >                  pgoff =3D 0;
> >                  get_area =3D shmem_get_unmapped_area;
> > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > !in_32bit_syscall()) {
> >                  /* Ensures that larger anonymous mappings are THP
> > aligned. */
> >                  get_area =3D thp_get_unmapped_area;
> >          }
> >
> >
> > thp_get_unmapped_area() does not take care of the legacy stuff...
>
> Could you please help test the below patch? It is compiled, but I
> don't have 32 bit userspace or machine to test it.

Hmm. I think you misunderstood me. This is happening on x86_64 emulated sys=
tem.

>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 94ef5c02b459..a4d0839e5f31 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -811,6 +811,9 @@ static unsigned long
> __thp_get_unmapped_area(struct file *filp,
>         loff_t off_align =3D round_up(off, size);
>         unsigned long len_pad, ret;
>
> +       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
> +               return 0;
> +
>         if (off_end <=3D off_align || (off_end - off_align) < size)
>                 return 0;
>
>
> >
> > regards,
> > --
> > js
> > suse labs
> >
>

