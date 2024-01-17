Return-Path: <linux-kernel+bounces-29364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AE2830D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB0A1C21D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56252249F4;
	Wed, 17 Jan 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKBdo8Ei"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016B9249E0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705519891; cv=none; b=dTDrSzIvzg9IV+L1PwTYrnGLDNYMxS7vXZyOuUPuK1M8JraDLkHsXYJfiN01FOslqU+rFVGJsFrM2ZUIPKq8TFTMHLSb5SM3m0+Wh7G0+50vDgjBPFPOrVhGOy7kGu+K06RuX1cRaR8woLLUAXo8mZag/AywRoOmhVJzDnd4dlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705519891; c=relaxed/simple;
	bh=GjPXtmoYND+7N3PLDgQwb+J0MCbDB9eK6/RCdKcN2UA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=eepgUObi37tlujPr6AffyGALlZwqt+s08ptJU1iFB2TYth1pTzAGCFaswmFgZiRsHYWukxnoJXQVZpOWBSU/SjQ025CMy5FNNJOTD2k9y008IPhukWe1QAcWlY2oUvPdpimkeV7FyD5bb5JLNXx2TX6VsLdwzIE41C3q+1/yvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKBdo8Ei; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so1177032066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705519888; x=1706124688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUMHX6S+0IO5CvL0DocoythkWeWqWs33LQSD4/f8L0Y=;
        b=CKBdo8EifP+Rj/zTVrDX96GGjBd+Nef9XaiaiBw6HUq5c3N8JqKdDXJ+dBIyRZzzFc
         yi6ceNt45f7+CiCGjRX8fq29FRiwbQAwXAt1lsmahYU8gznhKkn8XIAjv8zJazBMCgAi
         3GfvmhGXcMmrxhA9ta0B7lGAVkQih4UF6S5XaQHB/3eERJt/oKW31Gu2+yimY/N42dlF
         hPVl96X+PBtAr7KC2typrHTzUoXunfVzje8jJtYPNqe1QrotfQI4/3SGpch7+M8IO258
         v/wEEyn5qvaLRGUcqs+r+j3RAsQbXIeWGjoJqdPcMwcPwcX40/1y02C9p3V/8l+njF59
         TXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705519888; x=1706124688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUMHX6S+0IO5CvL0DocoythkWeWqWs33LQSD4/f8L0Y=;
        b=otejIbaQzKpUEJ8Uwr5SToxVoDU/1k38+MQ1iTfqUhWAN/nBEgpYIa7DRivyZj6ivg
         PSm0G/NNbU4AW/MjRg2dwStv8VTICWnNCojOLxwcM/EWAcrEyvwtbisXwas55bdvaNjR
         kE1ytd6tHrbacUvfo1KWd5LIbOeSJzGSK/iKssadqhji4j4tKeU3/L6gjE0wlpOrW+vF
         qFsXJI32/c42tkduiD4W8S6c60hCJv2OFzYilKATFvc2p8/w7lBvnOWC7Se3CdSCy9Zs
         AnSnhiaoAHXf0kn+g8pbY2IaFKY9EJtjSlT0LTfIKfN5p9ctP2uwvhoaWtQfJbuVYijW
         PyGQ==
X-Gm-Message-State: AOJu0YxtXbU5c5h/LifhEcKQLkuwKeXmcBury96pnQBRQSb6Igc+eqAw
	phfnrVpGUUqtxn1WBAZFMRS4+IwCGf66hilul6yOQKZvfXS7
X-Google-Smtp-Source: AGHT+IESU8PNUGdO93lxbT3HckP0KLGKpX9LFWXeWklpI+hjGR0SlguYycREh9vBYKKO/sV4r8TYeRv9itfv8v8Dluo=
X-Received: by 2002:a17:906:2695:b0:a23:1e0d:565b with SMTP id
 t21-20020a170906269500b00a231e0d565bmr4826659ejc.1.1705519888090; Wed, 17 Jan
 2024 11:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com> <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
In-Reply-To: <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 11:30:50 -0800
Message-ID: <CAJD7tkb_uC_K7+C3GjVqg1rDRCmUkbHcEw950CkUHG66yokbcg@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To: Nhat Pham <nphamcs@gmail.com>
Cc: Ronald Monthero <debug.penguin32@gmail.com>, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, akpm@linux-foundation.org, chrisl@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:14=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Jan 16, 2024 at 5:32=E2=80=AFAM Ronald Monthero
> <debug.penguin32@gmail.com> wrote:
>
> + Johannes and Yosry
>
> >
> > The core-api create_workqueue is deprecated, this patch replaces
> > the create_workqueue with alloc_workqueue. The previous
> > implementation workqueue of zswap was a bounded workqueue, this
> > patch uses alloc_workqueue() to create an unbounded workqueue.
> > The WQ_UNBOUND attribute is desirable making the workqueue
> > not localized to a specific cpu so that the scheduler is free
> > to exercise improvisations in any demanding scenarios for
> > offloading cpu time slices for workqueues.
>
> nit: extra space between paragraph would be nice.
>
> > For example if any other workqueues of the same primary cpu
> > had to be served which are WQ_HIGHPRI and WQ_CPU_INTENSIVE.
> > Also Unbound workqueue happens to be more efficient
> > in a system during memory pressure scenarios in comparison
> >  to a bounded workqueue.
> >
> > shrink_wq =3D alloc_workqueue("zswap-shrink",
> >                      WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
> >
> > Overall the change suggested in this patch should be
> > seamless and does not alter the existing behavior,
> > other than the improvisation to be an unbounded workqueue.
> >
> > Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> > ---
> >  mm/zswap.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 74411dfdad92..64dbe3e944a2 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1620,7 +1620,8 @@ static int zswap_setup(void)
> >                 zswap_enabled =3D false;
> >         }
> >
> > -       shrink_wq =3D create_workqueue("zswap-shrink");
> > +       shrink_wq =3D alloc_workqueue("zswap-shrink",
> > +                       WQ_UNBOUND|WQ_MEM_RECLAIM, 1);
>
> Have you benchmarked this to check if there is any regression, just to
> be safe? With an unbounded workqueue, you're gaining scheduling
> flexibility at the cost of cache locality. My intuition is that it
> doesn't matter too much here, but you should probably double check by
> stress testing - run some workload with a relatively small zswap pool
> limit (i.e heavy global writeback), and see if there is any difference
> in performance.

I also think this shouldn't make a large difference. The global
shrinking work is already expensive, and I imagine that it exhausts
the caches anyway by iterating memcgs. A performance smoketest would
be reassuring for sure, but I believe it won't make a difference.

Keep in mind that even with WQ_UNBOUND, we prefer the local CPU (see
wq_select_unbound_cpu()), so it will take more than global writeback
to observe a difference. The local CPU must not be in
wq_unbound_cpumask, or CONFIG_DEBUG_WQ_FORCE_RR_CPU should be on.

>
> >         if (!shrink_wq)
> >                 goto fallback_fail;
> >
> > --
> > 2.34.1
> >
>
> On a different note, I wonder if it would help to perform synchronous
> reclaim here instead. With our current design, the zswap store failure
> (due to global limit hit) would leave the incoming page going to swap
> instead, creating an LRU inversion. Not sure if that's ideal.

The global shrink path keeps reclaiming until zswap can accept again
(by default, that means reclaiming 10% of the total limit). I think
this is too expensive to be done synchronously.

