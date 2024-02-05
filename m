Return-Path: <linux-kernel+bounces-53914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF1B84A7F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9C71F28FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8879413398C;
	Mon,  5 Feb 2024 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imZrhUIn"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78813398A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164785; cv=none; b=PGaM5671Ufpy1L+b9l5MWr9s8EcZ4ILyAqUu30XQofZ41QyD/Hh5m53G3m5P6jgeAeUH0Krw6dvnTH5bHmp2jK6KL3jX/L1oJOzF65+HfoHsM8qR4bO7lCD/mbgoko4UlKWFumpzJmIMJ+uHcCYlQhDamiD/OOKFkw6Igup+MH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164785; c=relaxed/simple;
	bh=iuhwxc+kEC42K0xrnLOCMfh2WgameWmLaiGnuq+X9dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISng35I4ZwUqqFAgw1EvHUssKBbWHD2ZgwzNY1Vb5k9vWN1WNenjXHlGPi5UNCS/9acjXVHIedvgkszTYsfuCTEySgqCTYRqX2bKLxbMKlxBDiHQ4Jm5hUIGhcEXzMzqaUcrjT/QMlHt9D82dMqRoohJphrFNsQxhHvM/ct1dqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imZrhUIn; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60403c28ff6so54219977b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707164782; x=1707769582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDhsm2fdsB+fQAt2maFbmEiHwdZyphGxKvwl5nsbois=;
        b=imZrhUInybA3ljHIs1kd4w9NYlBWs8WQQOq2aU7DinutF2PqYXD+iyZdICnZZeHt/r
         uOv85wrEyyTQ0DEoJfYYbNvx6yfSK4BURbEdxakx17Yj9C9lQS/48SA0affuFGCg9eSj
         WvBHwjrGnprOEy5s4EHtG3j/YFDEdipfxRZ1o18ArFDL3osFNkzjEfO0rLcwEM/OS9h6
         rwhti6a1IRRZXH3uHJgzg80c8GI5J49EWZ8umDYE1diDpt0ZrHlGa5aI921OGATMCAFu
         zH5REgJxfTL0TeglrKV6AlpozM6FA5CI/qc5iKDsP/92+A4+/0gJFKeeJe+GGVrFYeeX
         pTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707164782; x=1707769582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDhsm2fdsB+fQAt2maFbmEiHwdZyphGxKvwl5nsbois=;
        b=rRyef5N4nEwsdTCdMOZLzgidL5GCt+EkDDgFJmbEjt3Im45/1XhuP0BOXiFllQkJL+
         Zff2Cxob8xvyh4/n9WmJiivecrTLX4mZ3/op1iV7nhhK0sI+w04CtLF+OWAKFnEEuinl
         V9E9SWjO98IdDvhqzABnVDQ7dbI8X/7knL3OPKjgDxNqHo1vA5BbJYwVMICbVEKcBmja
         NtF04JR+4JQXPWLzBm2Tcojks8VVE+/hXlmeNsgVsBWhnV31lerMiL0KaYZALzA9gYn3
         Tt99MVV6xxe9FlYGDfwishciyjlK7JYRLRCi1j5xFUwJ3pytdlpH+wV+8qI0TnvRRi8u
         j4Mg==
X-Gm-Message-State: AOJu0YxjG7rXGtVtrL9sSWYx4RZ/sWgW8yjO6+/EHdy81Edu42UNhSSi
	oeNKKGqSxrklkzGmPMdGNpow+oCU0nCSnFaBEw2wxTTrlWA2qN2uY/Bf2cqdAOdRQhW6bXeRk/W
	clB8lUdOzZDkRjY5z1swaamRboOdCfZvUrd/4
X-Google-Smtp-Source: AGHT+IFHQ1ICqE+J6hW/J7OaMc5Lypw2vG5/kzSrs2LQSEtUBd5XY4MjXXu6Sg3/hEB9BZH1jIihdxxu26Yl8EyIOXY=
X-Received: by 2002:a81:ae66:0:b0:5ff:86cb:ea77 with SMTP id
 g38-20020a81ae66000000b005ff86cbea77mr36550ywk.10.1707164782501; Mon, 05 Feb
 2024 12:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202233855.1236422-1-tjmercier@google.com>
 <ZcC7Kgew3GDFNIux@tiehlicka> <CABdmKX3HbSxX6zLF4z3f+=Ybiq1bA71jckkeHv5QJxAjSexgaA@mail.gmail.com>
 <ZcE5n9cTdTGJChmq@tiehlicka>
In-Reply-To: <ZcE5n9cTdTGJChmq@tiehlicka>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 5 Feb 2024 12:26:10 -0800
Message-ID: <CABdmKX0Du2F+bko=hjLBqdQO-bJSFcG3y1Bbuu2v6J8aVB39sw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>, 
	android-mm@google.com, yuzhao@google.com, mkoutny@suse.com, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 11:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 05-02-24 11:29:49, T.J. Mercier wrote:
> > On Mon, Feb 5, 2024 at 2:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
> > >
> > > On Fri 02-02-24 23:38:54, T.J. Mercier wrote:
> > > > Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proac=
tive
> > > > reclaim") we passed the number of pages for the reclaim request dir=
ectly
> > > > to try_to_free_mem_cgroup_pages, which could lead to significant
> > > > overreclaim. After 0388536ac291 the number of pages was limited to =
a
> > > > maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overreclaim.
> > > > However such a small batch size caused a regression in reclaim
> > > > performance due to many more reclaim start/stop cycles inside
> > > > memory_reclaim.
> > >
> > > You have mentioned that in one of the previous emails but it is good =
to
> > > mention what is the source of that overhead for the future reference.
> >
> > I can add a sentence about the restart cost being amortized over more
> > pages with a large batch size. It covers things like repeatedly
> > flushing stats, walking the tree, evaluating protection limits, etc.
> >
> > > > Reclaim tries to balance nr_to_reclaim fidelity with fairness acros=
s
> > > > nodes and cgroups over which the pages are spread. As such, the big=
ger
> > > > the request, the bigger the absolute overreclaim error. Historic
> > > > in-kernel users of reclaim have used fixed, small sized requests to
> > > > approach an appropriate reclaim rate over time. When we reclaim a u=
ser
> > > > request of arbitrary size, use decaying batch sizes to manage error=
 while
> > > > maintaining reasonable throughput.
> > >
> > > These numbers are with MGLRU or the default reclaim implementation?
> >
> > These numbers are for both. root uses the memcg LRU (MGLRU was
> > enabled), and /uid_0 does not.
>
> Thanks it would be nice to outline that in the changelog.

Ok, I'll update the table below for each case.

> > > > root - full reclaim       pages/sec   time (sec)
> > > > pre-0388536ac291      :    68047        10.46
> > > > post-0388536ac291     :    13742        inf
> > > > (reclaim-reclaimed)/4 :    67352        10.51
> > > >
> > > > /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> > > > pre-0388536ac291      :    258822       1.12            107.8
> > > > post-0388536ac291     :    105174       2.49            3.5
> > > > (reclaim-reclaimed)/4 :    233396       1.12            -7.4
> > > >
> > > > /uid_0 - full reclaim     pages/sec   time (sec)
> > > > pre-0388536ac291      :    72334        7.09
> > > > post-0388536ac291     :    38105        14.45
> > > > (reclaim-reclaimed)/4 :    72914        6.96
> > > >
> > > > Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proa=
ctive reclaim")
> > > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > >
> > > > ---
> > > > v3: Formatting fixes per Yosry Ahmed and Johannes Weiner. No functi=
onal
> > > > changes.
> > > > v2: Simplify the request size calculation per Johannes Weiner and M=
ichal Koutn=C3=BD
> > > >
> > > >  mm/memcontrol.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 46d8d02114cf..f6ab61128869 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -6976,9 +6976,11 @@ static ssize_t memory_reclaim(struct kernfs_=
open_file *of, char *buf,
> > > >               if (!nr_retries)
> > > >                       lru_add_drain_all();
> > > >
> > > > +             /* Will converge on zero, but reclaim enforces a mini=
mum */
> > > > +             unsigned long batch_size =3D (nr_to_reclaim - nr_recl=
aimed) / 4;
> > >
> > > This doesn't fit into the existing coding style. I do not think there=
 is
> > > a strong reason to go against it here.
> >
> > There's been some back and forth here. You'd prefer to move this to
> > the top of the while loop, under the declaration of reclaimed? It's
> > farther from its use there, but it does match the existing style in
> > the file better.
>
> This is not something I deeply care about but generally it is better to
> not mix styles unless that is a clear win. If you want to save one LOC
> you can just move it up - just couple of lines up, or you can keep the
> definition closer and have a separate declaration.

I find it nicer to have to search as little as possible for both the
declaration (type) and definition, but I am not attached to it either
and it's not worth annoying anyone over here. Let's move it up like
Yosry suggested initially.

> > > > +
> > > >               reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> > > > -                                     min(nr_to_reclaim - nr_reclai=
med, SWAP_CLUSTER_MAX),
> > > > -                                     GFP_KERNEL, reclaim_options);
> > > > +                                     batch_size, GFP_KERNEL, recla=
im_options);
> > >
> > > Also with the increased reclaim target do we need something like this=
?
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 4f9c854ce6cc..94794cf5ee9f 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -1889,7 +1889,7 @@ static unsigned long shrink_inactive_list(unsig=
ned long nr_to_scan,
> > >
> > >                 /* We are about to die and free our memory. Return no=
w. */
> > >                 if (fatal_signal_pending(current))
> > > -                       return SWAP_CLUSTER_MAX;
> > > +                       return sc->nr_to_reclaim;
> > >         }
> > >
> > >         lru_add_drain();
> > > >
> > > >               if (!reclaimed && !nr_retries--)
> > > >                       return -EAGAIN;
> > > > --
> >
> > This is interesting, but I don't think it's closely related to this
> > change. This section looks like it was added to delay OOM kills due to
> > apparent lack of reclaim progress when pages are isolated and the
> > direct reclaimer is scheduled out. A couple things:
> >
> > In the context of proactive reclaim, current is not really undergoing
> > reclaim due to memory pressure. It's initiated from userspace. So
> > whether it has a fatal signal pending or not doesn't seem like it
> > should influence the return value of shrink_inactive_list for some
> > probably unrelated process. It seems more straightforward to me to
> > return 0, and add another fatal signal pending check to the caller
> > (shrink_lruvec) to bail out early (dealing with OOM kill avoidance
> > there if necessary) instead of waiting to accumulate fake
> > SWAP_CLUSTER_MAX values from shrink_inactive_list.
>
> The point of this code is to bail out early if the caller has fatal
> signals pending. That could be SIGTERM sent to the process performing
> the reclaim for whatever reason. The bail out is tuned for
> SWAP_CLUSTER_MAX as you can see and your patch is increasing the reclaim
> target which means that bailout wouldn't work properly and you wouldn't
> get any useful work done but not really bail out.

It's increasing to 1/4 of what it was 6 months ago before 88536ac291
("mm:vmscan: fix inaccurate reclaim during proactive reclaim") and
this hasn't changed since then, so if anything the bailout should
happen quicker than originally tuned for.

> > As far as changing the value, SWAP_CLUSTER_MAX puts the final value of
> > sc->nr_reclaimed pretty close to sc->nr_to_reclaim. Since there's a
> > loop for each evictable lru in shrink_lruvec, we could end up with 4 *
> > sc->nr_to_reclaim in sc->nr_reclaimed if we switched to
> > sc->nr_to_reclaim from SWAP_CLUSTER_MAX... an even bigger lie. So I
> > don't think we'd want to do that.
>
> The actual number returned from the reclaim is not really important
> because memory_reclaim would break out of the loop and userspace would
> never see the result.

This makes sense, but it makes me uneasy. I can't point to anywhere
this would cause a problem currently (except maybe super unlikely
overflow of nr_reclaimed), but it feels like a setup for future
unintended consequences.

