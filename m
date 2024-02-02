Return-Path: <linux-kernel+bounces-49168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9669F8466BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6912896CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B0DF4C;
	Fri,  2 Feb 2024 04:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VvdBz1nl"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049AE549
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846640; cv=none; b=HtcY1YTO6jphbA0I3uJcTkDPIbPwKU0FkXZmxBG3XOuilxDF5BXFYPn6lZfhqB47Q9tAk4j6E9tmzfiGrn934fYKd7Z+T2iJJrJ1iQTvm/waYE6690DXqHmSreb+6Cp8q0Po9iJ7gFgSb/QHers6lBnTPgIpj0Fmy90cEdA4KOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846640; c=relaxed/simple;
	bh=4eaGVcAq7zTNWzIKHGaRDBxIEfRMATFqDOHfO1lQH8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxAg2S4pZhsYEn/hBxApVMxFGwL4QizC8PIlSjgH/WbNKbMZax4OO3oncE01Ns1KG2aq16Ft/jREqytXC603AQQIFFM95QV/WqS89TDwLUJ1Ik0Zi3iu0q19D5iuxuqiRSVe5khzrRk3+hSRYMjRsk2aAEKcysMrqnrEF1Z2Wfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VvdBz1nl; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-219108b8e9cso211064fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 20:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706846637; x=1707451437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBPcz0GP5Gh1HSYLOPzBAm/cEGRCFW+Rm8/XCSszjkI=;
        b=VvdBz1nlcgqlNER9AlHRBIAmL68JjrS4MJow0N2ZhzSZZQN9yYTT5MHT8vaguL23CE
         STzyaGK4GAEqSzCBc+XB7QKQbelxmqjCa4M5MQO71hMdfWzMMj6VMmd/V3v8ZhHr1Brv
         3NYvUQ1vnKLA4PA+bOzPugw52WmcusNcqFzSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706846637; x=1707451437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBPcz0GP5Gh1HSYLOPzBAm/cEGRCFW+Rm8/XCSszjkI=;
        b=eaGE6potlhV7lxzB7xQF9vEUSZz+W6FXVJLT6FydkiNB/gSR/UW8rrCKQHybUEUyER
         Etw+SsrBX32Y5IAgycBfJBjn6v1hXnzieqsiQZUcZS7HrDPcOBTkgDFRQA3tgfCy0dnL
         4aONYBy/RhLr2sNG+bG+mkCxsiYTTVzjBIW7TudGOhyB98y5b7adLxSfbkFW7B2GMGL3
         y/DEKgE8bYLVMRGbWRTMM3X15tsv3qg078ZDqdxcpGZ39LzvlLHjsh9jzLUZvMLK/2Y6
         PM3dwzXURe5bXDUA7ixv5mdZLcWgHE8WrZdhiW4nciGaJ0imyolE2B3kVN32w8AW7wQ+
         Qzpg==
X-Gm-Message-State: AOJu0YygAUqtWBs1X+KV+EmdME83TuZI4OU6CYvPn9M37iaNy5yteDAV
	NGhGfXZwipqLkrUdgi58nYqhuPlc4zdaMlSrpPHCSj2Yqwwe8Hza+qxophti2gsnyr3DYO3XTB3
	Vrz8WhUXFY9zf+Hu0DVqlSFDBVJ2qtglXSL+6
X-Google-Smtp-Source: AGHT+IES4sq+g6F4jHLGGFMZ3vUJFlNPbI6MSO0M/CCogUCWKZrbwpoaixxpKt/8wANqpnBcfmTqY5IUCygQOB1rm1o=
X-Received: by 2002:a05:6870:40c1:b0:218:e4c3:e34 with SMTP id
 l1-20020a05687040c100b00218e4c30e34mr4696738oal.55.1706846637645; Thu, 01 Feb
 2024 20:03:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131175027.3287009-3-jeffxu@chromium.org>
 <20240201231151.GA41472@sol.localdomain> <CABi2SkWW78n3PK3Qk5cCzpjb57ZCoLmybA1ds3=rHrGMams7sw@mail.gmail.com>
 <96087.1706846050@cvs.openbsd.org>
In-Reply-To: <96087.1706846050@cvs.openbsd.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 1 Feb 2024 20:03:45 -0800
Message-ID: <CABi2SkWP=N_V9+VvH3omw3gw=VcRqhqenti-qABijo-SNqXxhQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] mseal: add mseal syscall
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Eric Biggers <ebiggers@kernel.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:54=E2=80=AFPM Theo de Raadt <deraadt@openbsd.org> =
wrote:
>
> Jeff Xu <jeffxu@chromium.org> wrote:
>
> > On Thu, Feb 1, 2024 at 3:11=E2=80=AFPM Eric Biggers <ebiggers@kernel.or=
g> wrote:
> > >
> > > On Wed, Jan 31, 2024 at 05:50:24PM +0000, jeffxu@chromium.org wrote:
> > > > [PATCH v8 2/4] mseal: add mseal syscall
> > > [...]
> > > > +/*
> > > > + * The PROT_SEAL defines memory sealing in the prot argument of mm=
ap().
> > > > + */
> > > > +#define PROT_SEAL    0x04000000      /* _BITUL(26) */
> > > > +
> > > >  /* 0x01 - 0x03 are defined in linux/mman.h */
> > > >  #define MAP_TYPE     0x0f            /* Mask for type of mapping *=
/
> > > >  #define MAP_FIXED    0x10            /* Interpret addr exactly */
> > > > @@ -33,6 +38,9 @@
> > > >  #define MAP_UNINITIALIZED 0x4000000  /* For anonymous mmap, memory=
 could be
> > > >                                        * uninitialized */
> > > >
> > > > +/* map is sealable */
> > > > +#define MAP_SEALABLE 0x8000000       /* _BITUL(27) */
> > >
> > > IMO this patch is misleading, as it claims to just be adding a new sy=
scall, but
> > > it actually adds three new UAPIs, only one of which is the new syscal=
l.  The
> > > other two new UAPIs are new flags to the mmap syscall.
> > >
> > The description does include all three. I could update the patch title.
> >
> > > Based on recent discussions, it seems the usefulness of the new mmap =
flags has
> > > not yet been established.  Note also that there are only a limited nu=
mber of
> > > mmap flags remaining, so we should be careful about allocating them.
> > >
> > > Therefore, why not start by just adding the mseal syscall, without th=
e new mmap
> > > flags alongside it?
> > >
> > > I'll also note that the existing PROT_* flags seem to be conventional=
ly used for
> > > the CPU page protections, as opposed to kernel-specific properties of=
 the VMA
> > > object.  As such, PROT_SEAL feels a bit out of place anyway.  If it's=
 added at
> > > all it perhaps should be a MAP_* flag, not PROT_*.  I'm not sure this=
 aspect has
> > > been properly discussed yet, seeing as the patchset is presented as j=
ust adding
> > > sys_mseal().  Some reviewers may not have noticed or considered the n=
ew flags.
> > >
> > MAP_ flags is more used for type of mapping, such as MAP_FIXED_NOREPLAC=
E.
> >
> > The PROT_SEAL might make more sense because sealing the protection bit
> > is the main functionality of the sealing at this moment.
>
> Jeff, please show a piece of software that needs to do PROT_SEAL as
> mprotect() or mmap() argument.
>
I didn't propose mprotect().

for mmap() here is a potential use case:

fs/binfmt_elf.c
if (current->personality & MMAP_PAGE_ZERO) {
                /* Why this, you ask???  Well SVr4 maps page 0 as read-only=
,
                   and some applications "depend" upon this behavior.
                   Since we do not have the power to recompile these, we
                   emulate the SVr4 behavior. Sigh. */

                error =3D vm_mmap(NULL, 0, PAGE_SIZE,
                                PROT_READ | PROT_EXEC,   <-- add PROT_SEAL
                                MAP_FIXED | MAP_PRIVATE, 0);
        }

I don't see the benefit of RWX page 0, which might make a null
pointers error to become executable for some code.


> Please don't write it as a vague essay.
>
> Instead, take a piece of existing code, write a diff, and show your work.
>
> Then explain that diff, justify why doing the PROT_SEAL as an argument
> of mprotect() or mmap() is a required improvement, and show your Linux
> developer peers that you can do computer science.
>
> I did the same work in OpenBSD, at least 25% time over 2 years, and I
> had to prove my work inside my development community.  I had to prove
> that it worked system wide, not in 1 program, with hand-waving for the
> rest.  If I had said "Looks, it works in ssh, trust me it works in other
> programs", it would not have gone further.
>
> glibc is the best example to demonstrate, but smaller examples might
> convince.

