Return-Path: <linux-kernel+bounces-81536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798DC867735
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BB51F2B533
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA31292E0;
	Mon, 26 Feb 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaUfPEvB"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C7E128386
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955426; cv=none; b=Q2mH1ch3M2DmR6c9g7QfZaQUaJR5nAi/qDf+a+KDBiRFZeRMpCsXlp/UXJkf15pw0lomgxu3fAfm1jx2BJ71b2DihqamdaKlVapNW8TeoyK3vrK7j1oiCSP6mTDtFLXKhEVSiNB2dV6XNa4ezzMTfVM544iClFvIGesaTlIgS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955426; c=relaxed/simple;
	bh=A+ufEQd/O5cq93BCY001GP/W1BLQHWqILZyzYhgtUe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLRTWIh3DCbXBjUn5EyQHFnUbcHj5MLNf8TwDV26TPk6G4tf8ieQ6yHsdm2LpQzSFGBJwOJfsk1mnpqIrlcJd+Vpt7upiMnmY0XEauJff1QTgVxgmJdOnHAgP5kW5KsrTJfyI5qBMUSDD1bMh40f0VDLvHD8a1QEYWQQ80tDiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaUfPEvB; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2818313276.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708955423; x=1709560223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJhncUTfkuo0jdDz1sV5i9HS2I+N7q1J5xNow39o664=;
        b=gaUfPEvBAln1QPm2uQfPeIvwTs58KHElxU1i1iPw7TtV/rI2XY0lgpK/VbZVmHsd3x
         jhGzyXPWLDweJ5YxQhyNDlN6p2A2UNeJrck6JujmPhwOSMI132fqU4UY72fVVOXk2fAi
         /IMdyfgo1cLn9k9gafEdz1fhonHYw5ZR/mMOfFblGMtM3ur8XGvgEHfOHvcsUSLPK8b4
         3c/4aK0VEWh+pLZavZ/zKUwVS/BrNnlXywPJBj6fvV1+ydCJZWuDXrfX1EY91GYQ0BGz
         KZ+NivfuYVMYVLVGQ2x6/7xvVA1b+oYcMUDoJfC4ZZoEX4AKV70ROyamTwvVE0m8PWVX
         iWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955423; x=1709560223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJhncUTfkuo0jdDz1sV5i9HS2I+N7q1J5xNow39o664=;
        b=VucA+5HRJt6mozNLhMDoLMhk8UKavXO3vnrCe3NNHZnPTKxCR/tvkU7iWMV5otajey
         uWRe5jeoszSeHgC6D/1ZHPoXYAhC2g4uEMsShm9rL17SAC93x4HRqFdHs5e9tUoFKCoM
         9ki8bWXxQafVP7quH8xOGIQz7tDk6RgPCp3R5+Nx1/tuq8vJzjzdH/bzsy+9RnmM0KIZ
         Ra3IDyNyvk3ZMoOsj3sb5W7qrbCxmh6Q4p3H+BMUaqWo2GoOHpKdP3mDlXEgTsgMfrOz
         O7U+kV3//FiJlzc5sImgxnNSy5dypeA4AltB5ATn2bT1sU+3V8sud/sYCb39ax5oJVHN
         ABdg==
X-Forwarded-Encrypted: i=1; AJvYcCWP6lfAAxD4bqZ6HpwB19seYfWkFwcDDqxS8RBSC2BYmylYGGKUbL9dLcYVRd6a9m0YuCe5sufJZ/EBrHC9BfbXJz9Wt+EPfH3hpaLr
X-Gm-Message-State: AOJu0YyBL39bvfTw1iQSDdf5AHt+CEibV76A7OXYCjkJ4R5laRCF2v21
	M7AFdDpvNC0fmCOG8jfnYJu7mwPLQHNXx8sBIVTV6SdarzSF0BGyTkjLc4oy95Vm6i9ILlIUuY3
	GlJGxLfuLLgxC0dHQCJPHNa2wOx0=
X-Google-Smtp-Source: AGHT+IGpdSB28Oq3AP2DsRHs45c7+4tgbkWMmVmRJnM+CPWhqkg1f1F2q+2W+SFD8dmP611lRHRK2LZq19U52UrvE2I=
X-Received: by 2002:a25:abb1:0:b0:dcc:cadf:3376 with SMTP id
 v46-20020a25abb1000000b00dcccadf3376mr4643365ybi.18.1708955422889; Mon, 26
 Feb 2024 05:50:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com> <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
 <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com> <318be511-06de-423e-8216-af869f27f849@arm.com>
In-Reply-To: <318be511-06de-423e-8216-af869f27f849@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 26 Feb 2024 21:50:11 +0800
Message-ID: <CAK1f24=yWPQnYuQYgc3cXdBC0HoR1yAwY59Xs2DYPAC4DQzw0A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	minchan@kernel.org, peterx@redhat.com, shy828301@gmail.com, 
	songmuchun@bytedance.com, wangkefeng.wang@huawei.com, zokeefe@google.com, 
	fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 9:04=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 26/02/2024 08:55, Lance Yang wrote:
> > Hey David,
> >
> > Thanks for your suggestion!
> >
> > On Mon, Feb 26, 2024 at 4:41=E2=80=AFPM David Hildenbrand <david@redhat=
com> wrote:
> >>
> > [...]
> >>> On Mon, Feb 26, 2024 at 12:00=E2=80=AFPM Barry Song <21cnbao@gmail.co=
m> wrote:
> >>> [...]
> >>>> On Mon, Feb 26, 2024 at 1:33=E2=80=AFAM Lance Yang <ioworker0@gmail.=
com> wrote:
> >>> [...]
> > [...]
> >>> +static inline bool pte_range_cont_mapped(pte_t *pte, unsigned long n=
r)
> >>> +{
> >>> +     pte_t pte_val;
> >>> +     unsigned long pfn =3D pte_pfn(pte);
> >>> +     for (int i =3D 0; i < nr; i++) {
> >>> +             pte_val =3D ptep_get(pte + i);
> >>> +             if (pte_none(pte_val) || pte_pfn(pte_val) !=3D (pfn + i=
))
> >>> +                     return false;
> >>> +     }
> >>> +     return true;
> >>> +}
> >>
> >> I dislike the "cont mapped" terminology.
> >>
> >> Maybe folio_pte_batch() does what you want?
> >
> > folio_pte_batch() is a good choice. Appreciate it!
>
> Agreed, folio_pte_batch() is likely to be widely useful for this change a=
nd
> others, so suggest exporting it from memory.c and reusing as is if possib=
le.

Thanks for your suggestion. I'll use folio_pte_batch() in v2.

Best,
Lance

>
> >
> > Best,
> > Lance
> >
> >>
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >>
>

