Return-Path: <linux-kernel+bounces-132400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6889940A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5941F29750
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E4F1CA81;
	Fri,  5 Apr 2024 04:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yHhShf11"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D41AAD7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 04:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712290600; cv=none; b=ao6JBPeTGXXEt+tm6FxhIjSBoCpjHvJRqVOiy6cLmr85UXFvjeKd9jtqt5z6XmHJleGbFDormPip5T5eI6M37139MaegPwl2dWGd6ylML/ymto4Nqi38XigjkAfYRY0ReyAOa4Lyu3MMXLrLuvOoTJhDQkped5leTSIfETiFwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712290600; c=relaxed/simple;
	bh=jKz1vkvj06M5TC2ER2UR9NOMXgnvaGL6mNg1X4l/lhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjDMQHbsPYMoNM1rUk5TLbk1rZq6eDtvynSoUP/nmVPRj1BNlBJ08+r0uHtwZKucMD/oKYAwjuf+8SQlX12Pt4F/4RjcH6RI+jXHQ9bnKD5uN584p3rwh9CaH+IVQ7Pa63UabynR4Wg3hRHmruC44+n5otjwvNJ0Ehcw0k8axSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yHhShf11; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51a20a6041so32611766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 21:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712290597; x=1712895397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cydfC+H9xsE4MXqT0hqtXVg8XyYzWAE2MO9hp55ZxcM=;
        b=yHhShf117EUrCdRoH2TzcbeMqgkpsofh4fUF64frPXVu6YGbIvFPSZ9ReUip5Q4KPs
         tFJZww6Jc8aUfpNecDXlc+aQXdLWOLh4tpinKUCd27Uci9I9MhWDsNlQvvALZ8UPYhV/
         NmUrX/dZkQRpkD38gFUopOOoqPJBtKkhxiQVP8YdlqMvuY0TBUGEDPxPbl24cLFlwfDz
         l5uNoe0SP6+ftOjyRKcPj4nl4obrqd37eTOVVXqSiwpeiwZ7Fq9NeapW7JAm7jCPHypG
         yBeTUJns/gu5OUQ89kqusO0L5Hr69Fgsje0GMQ1o/qsL2rwzZj85Bd0oBAhwzqD8tKY9
         QTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712290597; x=1712895397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cydfC+H9xsE4MXqT0hqtXVg8XyYzWAE2MO9hp55ZxcM=;
        b=bTMx4aMUHWkucVdL5QTmZW/y6ROGnO2LF/BwsHnkWDeJ1Cme/o5myczQ8KzDfArjxL
         SVcsLlN1tST/pjPFd9KvA1GedF2ROUr6CTXb41pAS/+IDSxcs2/JrWEkxWPb9SmZevdz
         0sYnLoMgebbd9dqaMuOvm7XbDPA5sArauu2yf3W3Wmx+vxK9YLG7GEi3aK0Lno+/jIAz
         mJ70ejbZmUTD+5PDgqMg3yyGKqMDSnuq5XD4zGPJzJx0J9AvVf1q48COz1r8PbtnrHVo
         iYAXkj8CZr5kAFWneu6AE30WaNvd5LhuZ7ptCLSQELeGW4pCUuP6S9LsvcL6xQsuDdGg
         kWmA==
X-Forwarded-Encrypted: i=1; AJvYcCU3bp4Rw4OL22bmhYC3CvydkAVM6Nui1ISCkmiQNZqbAdbPXM37Ri+Li4Q8LIpiZ8dcvwpiPTPbqwhM4QmBgR9r0hCZGQlQ+7r3MWO8
X-Gm-Message-State: AOJu0YzKooOiphPN3hvIm6CSr2NaV0h1k/+bADRWQ53uoBrNY5SZDW3y
	BzNGMadTTU6KQ7EvW7iQc3Z4kIQxGoX8qpcSqsPRp2L1qTw2dsOT+JQXutngmm1Cwqwa2KZovLf
	jUJVRqIfe2cgXCVZits/n39W9rs/OwmicoIB8
X-Google-Smtp-Source: AGHT+IEmezE7CD49WKnmsBrzb2WNWu1lEJTkRDyBYMZ2hukQ8fZl6Kj9Cb3kpok8ArAf9XcTUV6l6ULNi1d8qzu4MLA=
X-Received: by 2002:a17:906:e295:b0:a51:95f1:14fe with SMTP id
 gg21-20020a170906e29500b00a5195f114femr129985ejb.13.1712290597127; Thu, 04
 Apr 2024 21:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405013547.1859126-1-yosryahmed@google.com>
 <20240405013547.1859126-3-yosryahmed@google.com> <20240405024459.GE641486@cmpxchg.org>
In-Reply-To: <20240405024459.GE641486@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 4 Apr 2024 21:15:59 -0700
Message-ID: <CAJD7tkZz6+L1vLkWhmV4PTHp-2qhuZ76m14qJAJ0ZEQeEuXVKw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] mm: zswap: refactor limit checking from zswap_store()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:45=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Fri, Apr 05, 2024 at 01:35:44AM +0000, Yosry Ahmed wrote:
> > Refactor limit and acceptance threshold checking outside of
> > zswap_store(). This code will be moved around in a following patch, so
> > it would be cleaner to move a function call around.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/zswap.c | 32 ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 1cf3ab4b22e64..fba8f3c3596ab 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1391,6 +1391,21 @@ static void zswap_fill_page(void *ptr, unsigned =
long value)
> >       memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
> >  }
> >
> > +static bool zswap_check_full(void)
> > +{
> > +     unsigned long cur_pages =3D zswap_total_pages();
> > +     unsigned long thr =3D zswap_accept_thr_pages();
>
> I know this looks neater, but it adds an extra division to the very
> common path where the limit hasn't been reached yet. It should really
> stay inside the branch.

I assumed the compiler is smart enough to do the division only when
necessary, but I didn't check tbh.

>
> Another option could be to precalculate the max and the accept
> threshold in absolute pages whenever their respective module param
> changes. That would eliminate both divisions from the hot path.

Yeah, that's better and cleaner. I will do that in the next version.

Thanks!

>
> > +     unsigned long max_pages =3D zswap_max_pages();
> > +
> > +     if (cur_pages >=3D max_pages) {
> > +             zswap_pool_limit_hit++;
> > +             zswap_pool_reached_full =3D true;
> > +     } else if (zswap_pool_reached_full && cur_pages <=3D thr) {
> > +             zswap_pool_reached_full =3D false;
> > +     }
> > +     return zswap_pool_reached_full;
> > +}
> > +
> >  bool zswap_store(struct folio *folio)
> >  {
> >       swp_entry_t swp =3D folio->swap;

