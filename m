Return-Path: <linux-kernel+bounces-122102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB08788F1EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B340B218FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02F21F5E6;
	Wed, 27 Mar 2024 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yh4Edb5a"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A018EA5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578681; cv=none; b=St75/1jCgmAOtAWGBJ3qgjRIl6uypJcmIM+8Cog9UNh5BkMFCpHoo0rtZaLidblCNPKSQeQ1unpaJjcTwIZxE24K+D6F6DeOjHfydJC4z0e4NmPsk6tfd6wh87oHBEJAUlN1rr50TWZzPPn+zO/AKpGjHR+TjIE3k+tae165uPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578681; c=relaxed/simple;
	bh=Ytg/i9kiK5BHBqjiLevui63Wj6zRxAXDMrT3ObPMqqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4Wdtc0dZv8AV51oKIB8/sazKt1t3J4Q9FKYxKVE1uPtYjS5P0S5TOCPqb7DZsJX5idIcRfLBTtij0CwebicYusyGUgSYsQKuZNnkic5y1kwY7Fc1tNBUS6B07iTYm71otItDTGMSD8Jd3odu4pC1IjbvCoE5c/7NQkBauNgT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yh4Edb5a; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so42601466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711578678; x=1712183478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhI2O+U4pkuvafY9z8tvpoCUUisn8MZxFuwrvadh8N8=;
        b=Yh4Edb5aqP+xZiGrGmXG9DbAjisgOn4Pnfw+vmJtZqeJqg7MwhAcU3HWudt8ErBe4P
         41GOT8BLAMkM2MKM3fKnEeQtzmrZUgXDwkN/63Q8sR4PRHys83JJNZ8QxGTbj4/XiS1N
         VzaYgMS0ndbiMeS6f2znIbeAGRX3tQSeYUYP7mjc/1JsInO5H1I4MyHEExI7E7LiKIIY
         zzH0xk4w//tbeXj8tyMYF7r647nShaXhUCWzLs5RBqCqdrEikCA1weFWFl/+YseaX5f9
         9UwwBD4I9FP8cYJWuF3989Z3LpW7zYcgG10LINdAusuJgoghomu1IplP1kzNfMLXMsrb
         ZCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711578678; x=1712183478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhI2O+U4pkuvafY9z8tvpoCUUisn8MZxFuwrvadh8N8=;
        b=CFPxFNBYMJclLc/dQO66pn7XAp9RUlt3YBK+zXVOPfLqUQFkSf4aByP8JB4d7jlU9a
         WxOl2h2DWIho2fwj1f8QDtrPh5P456UwrPXv0VX+CW5gZGfjZ5EFIincJBHla9DNAvT9
         DsXtTnm8+dTE4Btw6Lf00fgjCYh+KngytOp29FlLVrNAF1W1CtrsAZpIu/gwBkG2xvm5
         86bRysk8pIaRo4NlRk/H5vBHrXvfrddvpi9/SDkpGfDELxDNtWww4nGoDfU+ekXqFkMR
         7uNvP5pY/FOgvx+fG5RZTyH/At+UNqwrEb9NEKVZe2BjxsPGEew27e9e3WSJ4D4VgKjF
         x+8A==
X-Forwarded-Encrypted: i=1; AJvYcCUNj4hGwqOWoNlvsofZCwVHUC7GlMMnDwCBaGPp2zFZRUHKtFfeFOchI6bskLLNxN/PieaM+QwFVx9lirqfak8g96wEZQUzg300onrJ
X-Gm-Message-State: AOJu0Yz/+0IhpHdpznKTaDH68TuKXywzclqS3Pt9dnEda7BFsF96P4L2
	fUrWNsN+12SaCQTUhIu0Bh/OW1JBSK0nfogQPhun/zVF5oGEL6DN8Mk8j9j78Xx6IHyWpZikg+o
	Y9NlxkbtogQOMV1yNo8ZEAP1zfPWJdpkpSWas
X-Google-Smtp-Source: AGHT+IHYdtFZLLM6MLjyjI3PjSwj1qBukHQZ732bf6USNfcPr28xseB+kxpPdK6MA1RL+fL1mZ5N0HQYZ0otnJPmLLM=
X-Received: by 2002:a17:906:39c1:b0:a4c:de71:54f7 with SMTP id
 i1-20020a17090639c100b00a4cde7154f7mr502577eje.27.1711578677866; Wed, 27 Mar
 2024 15:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-4-yosryahmed@google.com> <88957a87-fe4c-448c-a22a-9052d65ab643@linux.dev>
In-Reply-To: <88957a87-fe4c-448c-a22a-9052d65ab643@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 27 Mar 2024 15:30:41 -0700
Message-ID: <CAJD7tkbW3+4MLkkgNK=reVCZb0JY=6o7+LC_2W-gQfYdOx1PWw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] mm: zswap: refactor limit checking from zswap_store()
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:42=E2=80=AFPM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2024/3/26 07:50, Yosry Ahmed wrote:
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
> > index ff1975afb7e3d..6b890c8590ef7 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1415,6 +1415,21 @@ static void zswap_fill_page(void *ptr, unsigned =
long value)
> >       memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
> >  }
> >
> > +static bool zswap_check_limit(void)
> > +{
> > +     unsigned long cur_pages =3D zswap_total_pages();
> > +     unsigned long thr =3D zswap_accept_thr_pages();
> > +     unsigned long max_pages =3D zswap_max_pages();
> > +
> > +     if (cur_pages >=3D max_pages) {
> > +             zswap_pool_limit_hit++;
> > +             zswap_pool_reached_full =3D true;
> > +     } else if (zswap_pool_reached_full && cur_pages <=3D thr) {
> > +             zswap_pool_reached_full =3D false;
> > +     }
> > +     return !zswap_pool_reached_full;
>
> nit: Then we use "!zswap_check_limit()" below, double negation looks comp=
lex,
> should we change to zswap_should_reject() or something?

Good point. Will rename it in the next version.

Thanks!

