Return-Path: <linux-kernel+bounces-27744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E35082F529
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30267285DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E93C1CFB6;
	Tue, 16 Jan 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="d67qHmh+"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B01CF9A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432589; cv=none; b=ppJKbojY4MFALM6dD5z0ZyQq+5qAnO41V4bITVBIub8cTQHKURFK7rBhU1A6iGfwueRPGOLz7iYgB4woFC0hR/j/aq9fi6MORQEs2PAF1JxzlTViuz7/wBZOLVChL9F1ar3/QWfsI7rrpCgDpxarqjcYRYtofM3E/WimTmeITdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432589; c=relaxed/simple;
	bh=14HJ9UKoJ5tDBLOPu3W4EXdsFr0EJssH8lM6QFwd/Yo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=nJ7tE1E+qgQpgz911f8CD3ksJKp7BOHdBwN89v1lhbJF2rMzZxfNkRTztSTIjL2gtvjqToRqn8xUIhHqr0hI/FBfvsSa616MG1QrgLbhW0CxQNttJNvSz+ZbWAMa0QsOAJ1mw5f0///Gwsa4Jz7bLaIn1YSDGP6Ajfk7rXEBBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d67qHmh+; arc=none smtp.client-ip=209.85.128.176
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ff45c65e60so13901117b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705432587; x=1706037387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgBHmnfd7ftHo1oCGQ72PVUXCJag4GsreqtntUHFIw4=;
        b=d67qHmh+XTAzBg/2a1I4AxWYyJ4oBilrvHiTbURCWOfixTkVhm2LIPHjDxEHBoiajt
         AcUJg5PtvLTlyMNjnm4i+KZ6YjIs5xa1Pv7dA4E/Q8qnpkk2ztEuuDyWlxUQcfq+SV+O
         5HaWtZNzIlOVWEDJ0Fr+YaN6Qhfq5wJoABl2nH61ePiyx8i2MfXjgrrFLFX8LUL8NJLq
         uS5jCMGvpqRb7GAJGVis1fx+Z0lmadapDZ642rFNM24hxEjMD3xtTl+p0bqhL+reMoe0
         xw46HIfhGgH0m7OHsB+4xbxB8FzNw0oHMgh/AQfETue+XhmTTtj/R4796Bx2t/fvSyTZ
         cRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705432587; x=1706037387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgBHmnfd7ftHo1oCGQ72PVUXCJag4GsreqtntUHFIw4=;
        b=VEVbWX1Fq6zGvnoZuRPpSedDKN44h9P5G6Z8RHViBfoNIF4xa6ESZ2f12K7lwLLZeJ
         wGC6cGml1HiZxCtjl2pVYuAtSSwrlceMg/htKyMpqHj5zKXFf3R4t2P05o5J0J/xw96x
         zdBi8v30EICKNNmlHw81b9yI+UL+KoFW0jhLn9I7wocquJJM1z+Ue+dKmT8liamYhoGI
         dvQ4JlBFMpCT8dc3YNiEHpXnFllRsLlfb/pctXQzLn8R2I/PeMJ5x4JuN7H4qTROiXmY
         Ir8CyqjLUDq66A1enkztOcyJMYa8S4tVy+Dn5wgGqErD7VmaY0+H6tnxv7DsMxcF0fli
         6HjA==
X-Gm-Message-State: AOJu0YzHTtfjJOJ7iNJvxYXhSyz/gQqQBiNKXDiMI4FvALfd9FLFkchH
	4KTZ9/lH+RTUlioRHVmLodDNRyqwV/xgYrCqWWdlGup72pn+
X-Google-Smtp-Source: AGHT+IGE+FOK6HQRzkgJqrsc3p8e3hGFho/tTwQoWKzbujvJDU+6W6pENfSWZeoQafy82GNtxLC8nq3gG6yA15oD0jk=
X-Received: by 2002:a0d:d88d:0:b0:5ff:4572:a30b with SMTP id
 a135-20020a0dd88d000000b005ff4572a30bmr1642636ywe.59.1705432586654; Tue, 16
 Jan 2024 11:16:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org>
In-Reply-To: <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Jan 2024 11:16:15 -0800
Message-ID: <CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > Hi,
> >
> > On 09. 08. 22, 20:24, Rik van Riel wrote:
> >> Align larger anonymous memory mappings on THP boundaries by
> >> going through thp_get_unmapped_area if THPs are enabled for
> >> the current process.
> >>
> >> With this patch, larger anonymous mappings are now THP aligned.
> >> When a malloc library allocates a 2MB or larger arena, that
> >> arena can now be mapped with THPs right from the start, which
> >> can result in better TLB hit rates and execution time.
> >
> > This appears to break 32bit processes on x86_64 (at least). In
> > particular, 32bit kernel or firefox builds in our build system.
> >
> > Reverting this on top of 6.7 makes it work again.
> >
> > Downstream report:
> >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> >
> > So running:
> > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlinux=
btf
> >
> > crashes or errors out with some random errors:
> > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_size=3D0 type=
=3D181346
> > Error emitting field
> >
> > strace shows mmap() fails with ENOMEM right before the errors:
> > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > ...
> > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cannot allocate
> > memory)
> >
> > Note the .tmp_vmlinux.btf above can be arbitrary, but likely large
> > enough. For reference, one is available at:
> > https://decibel.fi.muni.cz/~xslaby/n/btf
> >
> > Any ideas?
>
> This works around the problem, of course (but is a band-aid, not a fix):
>
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned long
> addr, unsigned long len,
>                   */
>                  pgoff =3D 0;
>                  get_area =3D shmem_get_unmapped_area;
> -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> !in_32bit_syscall()) {
>                  /* Ensures that larger anonymous mappings are THP
> aligned. */
>                  get_area =3D thp_get_unmapped_area;
>          }
>
>
> thp_get_unmapped_area() does not take care of the legacy stuff...

This change also affects the entropy of allocations. With this patch
Android test [1] started failing and it requires only 8 bits of
entropy. The feedback from our security team:

8 bits of entropy is already embarrassingly low, but was necessary for
32 bit ARM targets with low RAM at the time. It's definitely not
acceptable for 64 bit targets.

Could this change be either reverted or made optional (opt-in/opt-out)?
Thanks,
Suren.

[1] https://cs.android.com/android/platform/superproject/main/+/main:cts/te=
sts/aslr/src/AslrMallocTest.cpp;l=3D130

>
> regards,
> --
> js
> suse labs
>
>

