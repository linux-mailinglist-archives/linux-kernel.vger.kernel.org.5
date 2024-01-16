Return-Path: <linux-kernel+bounces-28325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D282FCF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03081F2A13A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704BC405F6;
	Tue, 16 Jan 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZyz0etP"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4701D6BD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442286; cv=none; b=FakwZIYIhv6V7VPO7yHRZ0QFEdvWFlQsNquPJYf1no1ZIl6N+smtQejEM2pecDl6G0jQZMoCzcv1/dWu3/rX7cvY0IhUe5c46qG0f8obUehnCefSDFWUuw5iEHsAyivbneiOpSq5VKFfq8jdBkn2QWb16U3bZjaEUrvve6A3t0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442286; c=relaxed/simple;
	bh=MZxAn23bElILIUnpWhnwgWVy9ThNG7v3JiFvLTV9Fio=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=qBGpmdTHULzxIYCzsjbQoM70IIrXQrhWnZxQpNVEojJNFWWkDEiQh8m+yloqgFipP7k3Q59PkBqm33VOYkSIqooE81+yi1l4kgG1/l8VvEkAYhnFA4/Mlw5tA84nAXBskOoZfODjXMBLCWM1Vg11vRKKIycHNzfUwAa/XqpnBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZyz0etP; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5ff45c65e60so15509987b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 13:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705442284; x=1706047084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5EIKchs1VAjD0fWApUQn73nGGFLSeKVzKK9a2evomA=;
        b=lZyz0etPK7mJWLSySVRw9F732njgwYlD2gpvqKna6Lk1rJxNaOr40nT6j0tD/8vI63
         8ySOKylkFfOwyGORNOTN45ajrQZ/+IVKDD8g0xoGQ4wF8UZm/R9YQ57B1P9IOVetthow
         YFtZSGJe/JkOhVCxu/Fcd+kMpfT2rn/UBQKVqHs9PwhJr3MF8yQn8RALVpIHquZS29AO
         oS3mxwiEIUGdQg2glkteBTCPmzOzdVzp4aWTf3lGJoAIhG1dGGM8xRW5JQl3HWOTi7KB
         UCkUyuYA0m/uk/Kord1N7CSWo/J2b1uifAPqxUXJhAdwjSlL6GOY02/Avo9OQkbjIWEA
         j2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705442284; x=1706047084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5EIKchs1VAjD0fWApUQn73nGGFLSeKVzKK9a2evomA=;
        b=qnQc8eNHVas6lZ9qpolxqlz/jKSUuMu9opVmenkn6ATN2RapX6rQgKSqkXClGsh51n
         wp9g3kO6/gw1fuBWcLUkwiiw0FxopHd6xyY9UiRJbDcQ8cbQMOt9XAMnJP73bdtSdAqO
         kNSXX+IwHp9zpNjRwtUpEV4SJLjPs2adOf/Fc2i1Y8h9LNGk19VEVJ8UWbhSI4nh+1R6
         7iqJC97P5E1tDA3Y5h/Qa29MyvGwnVPS/BWjxnjwljSGU1h9FGsk2S8WFXN4EnA3YKR8
         tZzB8SpDtEibga/1isb4iyptI50h3t+WYCnl4XDPFjwoqZzbgJyKlbDYtlsDRb16Fadb
         NQiw==
X-Gm-Message-State: AOJu0YwwR1+qSivaxxgVYahG9WxQPsvRQyZE/ZDwQ5DEOqGhG0wPKnoE
	e+neTcoEag7iTs6v9hXxRvjKc2eLuCF/Z3JeSos6MFvOZopoyg5FhHdjNJTjPm4d
X-Google-Smtp-Source: AGHT+IHSLdmfAQB+KscAa57I8uCekxyfrJgKP+h7BH6GjVSJQ78/sUgcmCZzKsgN5EU0XNpmXTZt0KvdtCvKOA9VOTI=
X-Received: by 2002:a81:57c3:0:b0:5e8:e0c7:f8d7 with SMTP id
 l186-20020a8157c3000000b005e8e0c7f8d7mr3956417ywb.93.1705442283734; Tue, 16
 Jan 2024 13:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com>
 <CAHbLzkpEWYhRAabAhrr6zuQqh0rO-mh=NZupDxJJ1BidOt_uiA@mail.gmail.com>
In-Reply-To: <CAHbLzkpEWYhRAabAhrr6zuQqh0rO-mh=NZupDxJJ1BidOt_uiA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Jan 2024 13:57:51 -0800
Message-ID: <CAJuCfpH5gwQc0mBzQ5LOMY9URCTh=58yUJd8pbzzynqAy8_yXw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Yang Shi <shy828301@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 12:56=E2=80=AFPM Yang Shi <shy828301@gmail.com> wro=
te:
>
> On Tue, Jan 16, 2024 at 11:16=E2=80=AFAM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
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
> > This change also affects the entropy of allocations. With this patch
> > Android test [1] started failing and it requires only 8 bits of
> > entropy. The feedback from our security team:
> >
> > 8 bits of entropy is already embarrassingly low, but was necessary for
> > 32 bit ARM targets with low RAM at the time. It's definitely not
> > acceptable for 64 bit targets.
>
> Thanks for the report. Is it 32 bit only or 64 bit is also impacted?
> If I understand the code correctly, it expects the address allocated
> by malloc() is kind of randomized, right?

Yes, correct, the test expects a certain level of address randomization.
The test failure was reported while running kernel_virt_x86_64 target
(Android emulator on x86), so it does impact 64bit targets.

>
> >
> > Could this change be either reverted or made optional (opt-in/opt-out)?
> > Thanks,
> > Suren.
> >
> > [1] https://cs.android.com/android/platform/superproject/main/+/main:ct=
s/tests/aslr/src/AslrMallocTest.cpp;l=3D130
> >
> > >
> > > regards,
> > > --
> > > js
> > > suse labs
> > >
> > >

