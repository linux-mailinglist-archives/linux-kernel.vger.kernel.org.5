Return-Path: <linux-kernel+bounces-164792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E53AD8B82E7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B013B237E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C71BF6EE;
	Tue, 30 Apr 2024 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wl3R5p/X"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CC21A38DE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518466; cv=none; b=JFfHaD00sdI0/UouOFA/W2En4zu3v5KjY+F5SL3VCOG/BZFKviGJzhl5vAN1I20Iu85myf1bhFCRt4z5TIY10SVy+D+1xNwt0OHK1sy2aAw/DHSKVKgHK73sta5fm6hmLRqPDChiPOnCQtfQYZX+16mEOE6je0stW5sxP1OxSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518466; c=relaxed/simple;
	bh=uPucxD96zlnvHpGfo/0h9rz4gjVxdwhwNcSJTZ2X/ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOy1ZXJKh02XQPHe1kPWrFF5WQxy71TLCQyPXDWzvLxJqb6wTO6mRaihMXGNQBfA7mFCSKSOJYRKGcjxTEcLUoAIqPnv92GqqJPiu9GcYkd6zVnGpMLwQlfjdqeG2QgtbKwNThV1x4iLCEIwukaDASBQWyR8QOAgElORbXChsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wl3R5p/X; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58eb9a42d9so483466466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714518463; x=1715123263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWHSx8x3CglXCpDsqd2sqLojUv7uUIhFAB1g3nMJgVQ=;
        b=Wl3R5p/XX1iuunawwp/dkVu1MR4D33X+xxoxG9o5GlAUCgF8R0iOj2iajOvRFmYUg2
         aRGLjJMAsVb+MKk9nZDqwntjseq64TjAUi/niCUNYdic4wRUFbOqm2PSW5qoaGHJjAyj
         NgnbpOvFGEJyM/ICzJ0ZSQ3o/gg76T4vsQ9i8jYAv1tDJcL1gWzsN9UV9wAVKFE6wJIF
         /WdQ2jtCW5CWHQCEsMhHZZVGptiVsF3yZHpMBwuuLZQlter5FAC1jlrV8xzKyY96OO9T
         tGdGsqDvCM625bSqqxV98v4BKpEKl0DhmwhxNo7jZkjRtaa6VBbs8o5PqpWR0DvQN+vw
         stAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518463; x=1715123263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWHSx8x3CglXCpDsqd2sqLojUv7uUIhFAB1g3nMJgVQ=;
        b=QGAs1AJ3U61JasKngwHuj7mWHLooA6VJ5GOjd317+5IyhzgJLoC92Y6htOC02w6iqm
         UgbSUEylkJK88XSxXjyotzJPs6YSey9Xp78ElEdo4w93a0fP2fQXhrTdbd8v2ZtMoCRk
         afeOy6idRklLjOQVydOEQaz9jg/G248IX7EPRMcdOpUyQrherJ3/NcAKduXnQQ/EQuKt
         ZbTSFQn7Vfz7FyTV3by6+Q443WVm4NE5olt2utwV5fe+j9tplfM194JYgGQeds1pRTnJ
         /Gg7t990567gCmmT6lQXxYhZC4eeB5EF6Jqr1IrFp66m4gIoaoTXqFeeRF9LN6vEj7Rf
         UJ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRbzi48VC3unRSjw0jGmxoTTEPCTmxm6+uQaB0RcrlhD6ivyw2KrBeWV1WXYhXo08wosAjPYmeZ4ejz3WJa8XnEb2Le4Z13XMoEHL6
X-Gm-Message-State: AOJu0Yys7OjXvWuZO8t4s7K6BtrIQveoIPb1F/7ryJZ9pzB6ofNTQeI9
	jCGZ/7k2v9CmiHPob/6M1ZA1Vx2IvjMlY1/lUthy5Suun/XNSSDiQh36wcHyCQW0jQ8IoXqkEOk
	DFjXrp29moiJfYMwTG7qI4vQmp2l8RwdXFxGU
X-Google-Smtp-Source: AGHT+IGA4OCcGROuejRidml9TPv3K1lykvce1DRnVEz/IoowhfwrU1qPRaqaxWUMBc5Cjk0KUTlQ2N0VCZ1aAbsKciE=
X-Received: by 2002:a17:906:b351:b0:a59:674:a297 with SMTP id
 cd17-20020a170906b35100b00a590674a297mr692168ejb.64.1714518462865; Tue, 30
 Apr 2024 16:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
 <20240430060612.2171650-5-shakeel.butt@linux.dev> <CAJD7tkZnXY+Nbip8e6c7WC4qoYC21x=MHop_hT4NqYLKL8Fp6Q@mail.gmail.com>
 <u3okwix7ovvzzfossbmfalwpq23qa3bmv3secg7tpjk7ghyemq@w3ngvr526rc2>
 <CAJD7tkZh-bLHQhaPsU7h1WUmK3xwHVoacVcR=P55i+7d0FzfFw@mail.gmail.com> <gmel2s2pysaavfetoqit3zq7grcrsbbfqh7sitg577yip7knwh@bufhf7ymlyd7>
In-Reply-To: <gmel2s2pysaavfetoqit3zq7grcrsbbfqh7sitg577yip7knwh@bufhf7ymlyd7>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 30 Apr 2024 16:07:05 -0700
Message-ID: <CAJD7tkbue8S86YZE3y_1qOF5ee14F9MCuh2iJ0BNBZC8QpL=_Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] memcg: reduce memory for the lruvec and memcg stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, "T . J . Mercier" <tjmercier@google.com>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 4:00=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Apr 30, 2024 at 10:41:01AM -0700, Yosry Ahmed wrote:
> > On Tue, Apr 30, 2024 at 10:38=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Tue, Apr 30, 2024 at 01:41:38AM -0700, Yosry Ahmed wrote:
> > > > On Mon, Apr 29, 2024 at 11:06=E2=80=AFPM Shakeel Butt <shakeel.butt=
@linux.dev> wrote:
> > > > >
> > > [...]
> > > > > +
> > > > > +#define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_item=
s)
> > > > > +#define NR_MEMCG_STATS (NR_MEMCG_NODE_STAT_ITEMS + ARRAY_SIZE(me=
mcg_stat_items))
> > > > > +static int8_t mem_cgroup_stats_index[MEMCG_NR_STAT] __read_mostl=
y;
> > > >
> > > > NR_MEMCG_STATS and MEMCG_NR_STAT are awfully close and have differe=
nt
> > > > meanings. I think we should come up with better names (sorry nothin=
g
> > > > comes to mind) or add a comment to make the difference more obvious=
.
> > > >
> > >
> > > How about the following comment?
> >
> > The comment LGTM. I prefer renaming them though if someone can come up
> > with better names.
> >
>
> I will be posting v4 and will change the name (still thinking about the
> name) becasuse:
>
> > > > > +static void init_memcg_stats(void)
> > > > > +{
> > > > > +       int8_t i, j =3D 0;
> > > > > +
> > > > > +       /* Switch to short once this failure occurs. */
> > > > > +       BUILD_BUG_ON(NR_MEMCG_STATS >=3D 127 /* INT8_MAX */);
>
> The above should be MEMCG_NR_STAT instead of NR_MEMCG_STATS.

Yeah it's pretty confusing :)

How about something explicit like:

NR_MEMCG_POSSIBLE_STAT_ITEMS / MEMCG_MAX_STAT_ITEM
NR_MEMCG_ACTUAL_STAT_ITEMS / MEMCG_ACTUAL_NR_STAT

They look ugly, but I can't think of anything better. Maybe they will
inspire something better :)

