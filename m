Return-Path: <linux-kernel+bounces-64149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB68853AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D7C1F227DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3412E3E4;
	Tue, 13 Feb 2024 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZEvGTPT"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641711CD10
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851911; cv=none; b=V5uHQuaN0meldFtHwP9wAOeuwndI6A9EEpkdxykRCpfs3SpI7m+9jLq9IVpag7FBOxGzivfgNqkLpP+u/sLHNHqAjE16pKWRabJZd/Cpe+JZ2iovEM/U2yaAXfE5RIfHL2uUj82c9zPayXGSeC2iX0mGXSy8S6CSWas3KJ1PMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851911; c=relaxed/simple;
	bh=a5mMRWzTFO8UllGnXCIR+TWz9Xn1DAwcV6AGubTqrF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSbEZP2/SrF/8JT+58ke0JC7ogRQidNLQENh66OXjB9kZrmpaO4qJ22cJ2YGWOA6fPlMx+kTy5GWNfAg+qaeLq2v+uERgjxYTP1XzJFX46+BEjZoK3JtFuMJ8OeAvbxi9cqAk8/cSpM3y/4oX7h9xzDhya8UI4D6iCbxnaHBTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZEvGTPT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-411d5dd7924so3106155e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707851907; x=1708456707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCX6UoytF2NcZYARqpkHqcF31HoM7Upx7WmM/K8jfRI=;
        b=hZEvGTPTsxHkB4dexv/sIqnOe39nr2IK+1KSjy+5wlC6NXB5D4H/iQBMPMjFm6R6ry
         D4whKsYpLIse8I87XO2rHNZbP3htNbrLCBDgo/SblGeJVFMX6vg+3CKjkfHW++yI+b0M
         evkWPApR2niJA5qnsNlQ5CpmoaOUBd5wUsRZUlC+I8y3pt0pGz/zrfuck2MgqLghf4rn
         ojtiyUer4WDDvRFRnPyJG53g5FT4uqXHN3yfDUZP0nwUOY0GVgWKrefJ3obLVNWmN8Id
         8/kmfHi9NAVoe65+BRuhEDyV0O/II9lTfMOA4gXyhhMJqIEE1QT2M028LuCzj1vQlA9+
         ek2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851907; x=1708456707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCX6UoytF2NcZYARqpkHqcF31HoM7Upx7WmM/K8jfRI=;
        b=LJrmKhFWSX+L+wWctfSLEx8WSDRnX15VNmyEJI1SQx+CCbyc2bEFOED3bYINc1qO8d
         g5aiibyog/O0lltUtpt73P/7UAXO6Z/MZrObpuhZLXEBahjq6H1/SglQoY/jy9tbHkR9
         OFvgDnfPnCRJ8sE+rY5DJz5sdInhtmocr3yHU58I8v7aiWyEBjIBj6T1Lp1zjgaEyr6y
         0SqD0Pyf1h9z4g2dNTAw4KDd1Frqh6nHJnVJtSh4zku0GMUu5N/i0bdORP2HzzmHEQVJ
         qCimYS+0d0hvHiw3+ft+kyg/oplixRAt4fgelE8IZf1ZpbJ5raHzoyMUZcqVnXGt/0W6
         caQg==
X-Forwarded-Encrypted: i=1; AJvYcCVj1PulxJ7omMDL2tWAP37QguUi/frzyJgb+yDRTpPp83rdTs0sLqHaDRTNxfWcJgAijJAZjZDfEmOyZtw/VSSEOrGUQzum/rn4kGFS
X-Gm-Message-State: AOJu0YwYLr89LSi3XiR69dobMr1oIhaTR8ZodmqAha2CRQE52niK1oO7
	xVo+LsGrcu1RxXkZo3gIDWlIGW4ITqcKSoxBobei3LrOctp51ZRSwOQoIZP3REhGOQvr55RL+an
	J/b/T+k6YaCjRyOR98eD//GdZa2V7UrJnfarp
X-Google-Smtp-Source: AGHT+IEMHwkro+xsqN6z9qNfjrhRyFhmvQhXDoENBJPQ6ipKebPJrHzy8YnGUaSmsX5qm/wdi6FYHsoNKdwoTN72x5c=
X-Received: by 2002:a5d:54cc:0:b0:33b:45b6:b589 with SMTP id
 x12-20020a5d54cc000000b0033b45b6b589mr160513wrv.66.1707851907393; Tue, 13 Feb
 2024 11:18:27 -0800 (PST)
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
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
 <20240213184905.tp4i2ifbglfzlwi6@revolver> <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
In-Reply-To: <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 13 Feb 2024 11:18:15 -0800
Message-ID: <CA+EESO6M5VudYK-CqT2snvs25dnrdTLzzKAjoSe7368X-PcFew@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:57=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Feb 13, 2024 at 10:49=E2=80=AFAM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [240213 13:25]:
> > > On Tue, Feb 13, 2024 at 10:14=E2=80=AFAM Lokesh Gidra <lokeshgidra@go=
ogle.com> wrote:
> > > >
> > > > On Tue, Feb 13, 2024 at 9:06=E2=80=AFAM Liam R. Howlett <Liam.Howle=
tt@oracle.com> wrote:
> > > > >
> > > > > * Lokesh Gidra <lokeshgidra@google.com> [240213 06:25]:
> > > > > > On Mon, Feb 12, 2024 at 7:33=E2=80=AFPM Liam R. Howlett <Liam.H=
owlett@oracle.com> wrote:
> > > > > > >
> > > > > > > * Lokesh Gidra <lokeshgidra@google.com> [240212 19:19]:
> > > > > > > > All userfaultfd operations, except write-protect, opportuni=
stically use
> > > > > > > > per-vma locks to lock vmas. On failure, attempt again insid=
e mmap_lock
> > > > > > > > critical section.
> > > > > > > >
> > > > > > > > Write-protect operation requires mmap_lock as it iterates o=
ver multiple
> > > > > > > > vmas.
> > > > > > > >
> > > > > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > > > > ---
> > > > > > > >  fs/userfaultfd.c              |  13 +-
> > > > > > > >  include/linux/userfaultfd_k.h |   5 +-
> > > > > > > >  mm/userfaultfd.c              | 392 ++++++++++++++++++++++=
++++--------
> > > > > > > >  3 files changed, 312 insertions(+), 98 deletions(-)
> > > > > > > >
> > > > > > > ...
> > > > >
> > > > > I just remembered an issue with the mmap tree that exists today t=
hat you
> > > > > needs to be accounted for in this change.
> > > > >
> > > > > If you hit a NULL VMA, you need to fall back to the mmap_lock() s=
cenario
> > > > > today.
> > > >
> > > > Unless I'm missing something, isn't that already handled in the pat=
ch?
> > > > We get the VMA outside mmap_lock critical section only via
> > > > lock_vma_under_rcu() (in lock_vma() and find_and_lock_vmas()) and i=
n
> > > > both cases if we get NULL in return, we retry in mmap_lock critical
> > > > section with vma_lookup(). Wouldn't that suffice?
> > >
> > > I think that case is handled correctly by lock_vma().
> >
> > Yeah, it looks good.  I had a bit of a panic as I forgot to check that
> > and I was thinking of a previous version.  I rechecked and v5 looks
> > good.
> >
> > >
> > > Sorry for coming back a bit late. The overall patch looks quite good
> > > but the all these #ifdef CONFIG_PER_VMA_LOCK seem unnecessary to me.
> > > Why find_and_lock_vmas() and lock_mm_and_find_vmas() be called the
> > > same name (find_and_lock_vmas()) and in one case it would lock only
> > > the VMA and in the other case it takes mmap_lock? Similarly
> > > unlock_vma() would in one case unlock the VMA and in the other drop
> > > the mmap_lock? That would remove all these #ifdefs from the code.
> > > Maybe this was already discussed?
> >
> > Yes, I don't think we should be locking the mm in lock_vma(), as it
> > makes things hard to follow.
> >
> > We could use something like uffd_prepare(), uffd_complete() but I
> > thought of those names rather late in the cycle, but I've already cause=
d
> > many iterations of this patch set and that clean up didn't seem as vita=
l
> > as simplicity and clarity of the locking code.

I anyway have to send another version to fix the error handling that
you reported earlier. I can take care of this in that version.

mfill_atomic...() functions (annoyingly) have to sometimes unlock and
relock. Using prepare/complete in that context seems incompatible.

>
> Maybe lock_vma_for_uffd()/unlock_vma_for_uffd()? Whatever name is
> better I'm fine with it but all these #ifdef's sprinkled around don't
> contribute to the readability.

I'll wait for an agreement on this because I too don't like using so
many ifdef's either.

Since these functions are supposed to have prototype depending on
mfill/move, how about the following names:

uffd_lock_mfill_vma()/uffd_unlock_mfill_vma()
uffd_lock_move_vmas()/uffd_unlock_move_vmas()

Of course, I'm open to other suggestions as well.

> Anyway, I don't see this as a blocker, just nice to have.
>
> >
> > Thanks,
> > Liam
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >

