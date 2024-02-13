Return-Path: <linux-kernel+bounces-64127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4B853A61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC1F1C244B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B117604C9;
	Tue, 13 Feb 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAMsDWVY"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F999111BF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850636; cv=none; b=p6jXvlLVzm+HMcoc2dlbPnP2TOVbpolucrpGEvYiOP+vpW6U0O6te13iX76Qt2zZ+e182A+8D8pZYrccWfplLnZRz7yRZZU4l7R/B2xe8y9IamHIYHoiJHVdesHX9hajZ7WO7oau+yTCk9D5T7HnyK5rQ+iaJtrYjgLXJhpgokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850636; c=relaxed/simple;
	bh=Ab6/KRWXKyqviiIVltgPoMU4aIUhh8wKEZMvUQ13lgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FSyAgQfbOKHA8wdhEmDcPGg5iR0F7FHnkU2vSz4YAAuNCRNOkoykfUMVH0dol05lF6NiBs0QtUHD38kPnJIcL893HrcDa8PJ42Cx/q1orC1vovATNEThUnff2tLC6X5uV59OMHNWhTORWEnT7CnaJTScvLu2m7ZHACMdppgUEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAMsDWVY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso930061276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707850632; x=1708455432; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AizEZRsj9zp0aMtrzGKjLan03hrWjNj+oXUsjIKs8lg=;
        b=AAMsDWVYPE0xeA98BMXq2a5AFPzpFejhEx5lPTQlbgpg/Qjqh5bsmYb7lRrXg7i0sE
         1eSemTKgNIlmDhJwqBToBlOBZyoYT5O8g5t2sw8tBYvZkgxnJTFapmLxZX0dBGEeNVbt
         5+E5GRIMB0ayUv18nxW7e6gD9H6WRbrzbKXrrtbrsrIL1zT7reXvU9EzA2Esyz5AO7op
         O/fbpi5705oybxjHHzBNMGat8N8M73/cXHEFUKKZPX/UdC76m6sQUzFG6n5+KJQ1SPgK
         NdRX4uwoDASIKMk8m9tg4+X+7AlC1iQEKEE/PeO9Sk0+EKSOpQACnbgqf37oVvchxh0O
         nl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850632; x=1708455432;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AizEZRsj9zp0aMtrzGKjLan03hrWjNj+oXUsjIKs8lg=;
        b=wcIhgdSLfUcOJ80+/nGFPPYNHck+Wxh2tKFyCrkFsN/1ZedPGfS4f27qayHkWGNLpg
         +CLrCcZRgoXBnS5vuSSsye2WN5xQuhEluhiohIDXnXvnIELpa115GYmeli6ouRRUYa2Z
         niH7hAj3cG9k2akyVvB3fGnS+mzyz2S4yiA142pi4EduOXhuUh8h5nVKwyD/tTr7ynQV
         MCFV3H3/h6aNAJ9Xv0OVJ4/RyG6i17WhohgUMh8u2FWyUqVk9JdBCX4WTA52vKAm9PbX
         /uNXdNKpRSNjv0uAohvXXzfgAzogaJlj6cRhLN1rmDn6VPNYmbxvsO5B4PDoDpFhDtDj
         +wTA==
X-Forwarded-Encrypted: i=1; AJvYcCVBYuTLo0mXQysnEZ5sRLeMBeZaHwdxmJXnn7zTij6rx+9hMrRRjRIuObXcGpZmoXUzP4kyBpwz9Antc2am9BTr0Qn/ZttNxAWSp8v9
X-Gm-Message-State: AOJu0Ywx22DSL8V/4ziSIg7VTFmGM56jHxqe2IzUlZOexM3JLYH3WPMB
	g9hgUqe+JolFcpmXdotH6zuF/wL2srULNx8rvOMVQTk/pL3gI+D7hHwILOAsehg0yGDfx9RW59S
	x4W3xMhYQ5rzMZ4b2oKAacZqmiL7YJZA1U3/o
X-Google-Smtp-Source: AGHT+IEiR97DUM9oD42STYdu2QJ9SXD6hTNaKKADBvYUD5yfI5r4qhcPBqwPNyK4iEliEjUCka8aTia/tRWqdtwKhAE=
X-Received: by 2002:a25:83d0:0:b0:dcb:38d3:3c6a with SMTP id
 v16-20020a2583d0000000b00dcb38d33c6amr35575ybm.46.1707850631000; Tue, 13 Feb
 2024 10:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213001920.3551772-1-lokeshgidra@google.com>
 <20240213001920.3551772-4-lokeshgidra@google.com> <20240213033307.zbhrpjigco7vl56z@revolver>
 <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
 <20240213170609.s3queephdyxzrz7j@revolver> <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com> <20240213184905.tp4i2ifbglfzlwi6@revolver>
In-Reply-To: <20240213184905.tp4i2ifbglfzlwi6@revolver>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Feb 2024 10:56:58 -0800
Message-ID: <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:49=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [240213 13:25]:
> > On Tue, Feb 13, 2024 at 10:14=E2=80=AFAM Lokesh Gidra <lokeshgidra@goog=
le.com> wrote:
> > >
> > > On Tue, Feb 13, 2024 at 9:06=E2=80=AFAM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > >
> > > > * Lokesh Gidra <lokeshgidra@google.com> [240213 06:25]:
> > > > > On Mon, Feb 12, 2024 at 7:33=E2=80=AFPM Liam R. Howlett <Liam.How=
lett@oracle.com> wrote:
> > > > > >
> > > > > > * Lokesh Gidra <lokeshgidra@google.com> [240212 19:19]:
> > > > > > > All userfaultfd operations, except write-protect, opportunist=
ically use
> > > > > > > per-vma locks to lock vmas. On failure, attempt again inside =
mmap_lock
> > > > > > > critical section.
> > > > > > >
> > > > > > > Write-protect operation requires mmap_lock as it iterates ove=
r multiple
> > > > > > > vmas.
> > > > > > >
> > > > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > > > ---
> > > > > > >  fs/userfaultfd.c              |  13 +-
> > > > > > >  include/linux/userfaultfd_k.h |   5 +-
> > > > > > >  mm/userfaultfd.c              | 392 ++++++++++++++++++++++++=
++--------
> > > > > > >  3 files changed, 312 insertions(+), 98 deletions(-)
> > > > > > >
> > > > > > ...
> > > >
> > > > I just remembered an issue with the mmap tree that exists today tha=
t you
> > > > needs to be accounted for in this change.
> > > >
> > > > If you hit a NULL VMA, you need to fall back to the mmap_lock() sce=
nario
> > > > today.
> > >
> > > Unless I'm missing something, isn't that already handled in the patch=
?
> > > We get the VMA outside mmap_lock critical section only via
> > > lock_vma_under_rcu() (in lock_vma() and find_and_lock_vmas()) and in
> > > both cases if we get NULL in return, we retry in mmap_lock critical
> > > section with vma_lookup(). Wouldn't that suffice?
> >
> > I think that case is handled correctly by lock_vma().
>
> Yeah, it looks good.  I had a bit of a panic as I forgot to check that
> and I was thinking of a previous version.  I rechecked and v5 looks
> good.
>
> >
> > Sorry for coming back a bit late. The overall patch looks quite good
> > but the all these #ifdef CONFIG_PER_VMA_LOCK seem unnecessary to me.
> > Why find_and_lock_vmas() and lock_mm_and_find_vmas() be called the
> > same name (find_and_lock_vmas()) and in one case it would lock only
> > the VMA and in the other case it takes mmap_lock? Similarly
> > unlock_vma() would in one case unlock the VMA and in the other drop
> > the mmap_lock? That would remove all these #ifdefs from the code.
> > Maybe this was already discussed?
>
> Yes, I don't think we should be locking the mm in lock_vma(), as it
> makes things hard to follow.
>
> We could use something like uffd_prepare(), uffd_complete() but I
> thought of those names rather late in the cycle, but I've already caused
> many iterations of this patch set and that clean up didn't seem as vital
> as simplicity and clarity of the locking code.

Maybe lock_vma_for_uffd()/unlock_vma_for_uffd()? Whatever name is
better I'm fine with it but all these #ifdef's sprinkled around don't
contribute to the readability.
Anyway, I don't see this as a blocker, just nice to have.

>
> Thanks,
> Liam
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

