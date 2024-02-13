Return-Path: <linux-kernel+bounces-64065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB18539B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D151F24808
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BCD605C6;
	Tue, 13 Feb 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCMpu/EB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC0E605B3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848094; cv=none; b=qv+Sd4czsBVNdOZUr8dAArr7SqXaikH4Zytz7zN//30V5vqI67+c4/D8hCOjSMAxGq7Fl2UDYLMsfQBYQPBovwMVADrNy5TLA0WWM0Rc79A/uxRC0eHOVS+OsczTbtHA1dim0sGrkqHKmpgLfqT9F2GZe8+oOt7aL3UHzmaUjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848094; c=relaxed/simple;
	bh=pFTVmcL+7AKQTzSgLeowHwXQTcO1RcbCaNlkKYs1gnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=T4hdkq9RacuEBuQQsBm9ge571XqlFn+cmax+A88eGFUWYzAxk3jbJRWYy6kQ1MG2VxECDYSYpapuV+RfiJk9m05D1MwCVn0flLy+tK2x8xOkUztsyJCWwwwNszYVcp0DMx1wiWnYvcOfyHjgogW8QHB8vPLjVCNrNbwbCQNHwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCMpu/EB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-411a6ada28dso8891695e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707848091; x=1708452891; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21wqIURVqzFnw45KjAoFtF/+uk4paqLSEGTh7Vx6QVg=;
        b=aCMpu/EBJ6sZhv5YK9hDRBnrW7Kxu1zoc+KdL8/2ckZLPgGMElbnoAfoG5YwvvwAh4
         jZaB0+472a7OmuyDKSXfBEEnADpGBxI9OT70szgnBB4170/gsVFt85AGn/nq24CzIMPi
         7fD7H0PXI3W9dkWFIkggSreaPckOELEu8hUeEKauPa1qcXcSBXmLLS7P//8yRTqZbmAQ
         uVWjJMbIFnULXwecfYCbbAgu1IY33Hs9d9wGqHtLrFoTYKTq1SvAIfY5itidGlZkrtSA
         noPKKvuQFIBVSk9ZJ4o02DuuoliCCrq6zujgMtD+MyyTDh5WFHbRGHBAbjikyj+7P1HP
         mhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848091; x=1708452891;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21wqIURVqzFnw45KjAoFtF/+uk4paqLSEGTh7Vx6QVg=;
        b=mM5sb/KMgNAfSxfXgmd16y3xWPXQtIrbwzJezi3wNHEYkvHd5n7J659Sj0dVPBXa5L
         Vgzo+yXG/1RTl1CMbX9uBMmrFULU3n12HAUVmn96u32H2gljx/8K952xMJMlPIdgHXYC
         xOPJwJK2JslqZ0kZAj71wQu4AMnKHTdcOGY7onbCVjMUXjQD8oEoNKAw5vMXHA/rYL0J
         r09+cC1tXMaIyipaVZ8DT2Jf7ht5ZSk5IbJwI6vwj3dXxCCU5p5W6TfUxRe8qgE1dXwe
         zJCJXAXkbXahJbfTOoj/ghAdij+tX8RDqK4JPqFIq7ZmlnyH2VwtvCoW2vJNEqSgEIkA
         ZXhg==
X-Forwarded-Encrypted: i=1; AJvYcCUftX6uekPq9MHOrZw9DJCsXUs4UvjwomjssXI3v7jc/M2ibDT4ZM0OfSPjIWLQ79+8LiLy6EG35ekvH3cTTcT9F4us3uc4aDDD/Qmk
X-Gm-Message-State: AOJu0Yxtj0P7XjoJEgpu9CiXMiz1PgIvarxjKvZ1mXiskczEHRfJ3lX4
	xv9kbkNhxfaiFGnxpd3UyAncaFHfkEu5FmX3l2FHXiQdq6Xn5uzoS5aXF8h+qpAPBZc0I3WOmws
	NWSBpTtY6/b3CyOE1iQZUopk2KnvTG2JFqo9u
X-Google-Smtp-Source: AGHT+IHa9OPCnufh29WeyTz37tt24QgiXTn7F4Oa5szGRAx0/ViE47Xj2M6mCNxNaVvo2Iopvz+vIdo89Ixon6TNfyY=
X-Received: by 2002:a05:600c:1d1f:b0:40e:fb76:5344 with SMTP id
 l31-20020a05600c1d1f00b0040efb765344mr313051wms.11.1707848090744; Tue, 13 Feb
 2024 10:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213001920.3551772-1-lokeshgidra@google.com>
 <20240213001920.3551772-4-lokeshgidra@google.com> <20240213033307.zbhrpjigco7vl56z@revolver>
 <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com> <20240213170609.s3queephdyxzrz7j@revolver>
In-Reply-To: <20240213170609.s3queephdyxzrz7j@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 13 Feb 2024 10:14:38 -0800
Message-ID: <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 9:06=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240213 06:25]:
> > On Mon, Feb 12, 2024 at 7:33=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Lokesh Gidra <lokeshgidra@google.com> [240212 19:19]:
> > > > All userfaultfd operations, except write-protect, opportunistically=
 use
> > > > per-vma locks to lock vmas. On failure, attempt again inside mmap_l=
ock
> > > > critical section.
> > > >
> > > > Write-protect operation requires mmap_lock as it iterates over mult=
iple
> > > > vmas.
> > > >
> > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > ---
> > > >  fs/userfaultfd.c              |  13 +-
> > > >  include/linux/userfaultfd_k.h |   5 +-
> > > >  mm/userfaultfd.c              | 392 ++++++++++++++++++++++++++----=
----
> > > >  3 files changed, 312 insertions(+), 98 deletions(-)
> > > >
> > > ...
>
> I just remembered an issue with the mmap tree that exists today that you
> needs to be accounted for in this change.
>
> If you hit a NULL VMA, you need to fall back to the mmap_lock() scenario
> today.

Unless I'm missing something, isn't that already handled in the patch?
We get the VMA outside mmap_lock critical section only via
lock_vma_under_rcu() (in lock_vma() and find_and_lock_vmas()) and in
both cases if we get NULL in return, we retry in mmap_lock critical
section with vma_lookup(). Wouldn't that suffice?
>
> This is a necessity to avoid a race of removal/replacement of a VMA in
> the mmap(MAP_FIXED) case.  In this case, we munmap() prior to mmap()'ing
> an area - which means you could see a NULL when there never should have
> been a null.
>
> Although this would be exceedingly rare, you need to handle this case.
>
> Sorry I missed this earlier,
> Liam

