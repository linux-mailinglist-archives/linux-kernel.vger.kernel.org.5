Return-Path: <linux-kernel+bounces-53818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4484A6F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1919E1C26A1C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED875B67C;
	Mon,  5 Feb 2024 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ai9Jc+KH"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783275B686
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161406; cv=none; b=VMQY3oikH3TbJVoyQQiQLPgBliYenWsvtJHRxQexsg4gSFrC2RxZFPaoJ7ymH4imtmc5VP2v7ZmnSxQuj3pGUXKDjiTRRdHSnBld5VImCEodj8vQZckebXjsQpDFMtH3trwD6zCkEhWvH5mHVUUZnyKkqKgkgywtVfUtjP5sPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161406; c=relaxed/simple;
	bh=hv/515ixhg1b1irAW/kbpYEWdizYkHO4avvo3y8I560=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPypDNYaDUh1XgZ2scTlUhsrRTWcJuDKVDK6agNuTsJMwhLbhQkBigENCRkgP920cBPnfgy8FggFZaiULv6bnbD2MfGATSAGjHmQ7rLiF75L1FH0U65uuD8kArSLeRzFqmifVzwZIIRMdMZMLkNw3oXfekngvq2KH2ArNraeBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ai9Jc+KH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ffdf06e009so41861817b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707161402; x=1707766202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4WN4Xb7dp47SMoVjUS6Uu6ut1YvXAAoP/+0s4mxi3o=;
        b=ai9Jc+KH8ES/2P+WdWvS5qgc35Crjl1jmXKq046xRWEROJyFtSCRPpl5dywPhgV51z
         GUCdSZrEX6T+hP0zwFB9oQd3UrAe2WRm3TIPnnleWcBgoGTYngPLiG6w5xCynHrPd7fK
         CTbwp14ko+CtwRYgfoUA8EVotokixe2j90EBgjuW/YMUY9eXZmCRW7J4nwAnRya+TcZW
         9OtkjPYAYFJsuE35Z9UlUhBjRzuzFdLdjvmyTkKQePU+HfZZ43/Q3W6DnAIQZXAep27s
         Nn6ZntMuntXzFU7tg5NaJF8nd3yOuW4OsdzvC2TEH3eDdAPryTzisexhIPx4+Rv3mES2
         KrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707161402; x=1707766202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4WN4Xb7dp47SMoVjUS6Uu6ut1YvXAAoP/+0s4mxi3o=;
        b=iv6wz6SzLe/2f+DtEUwD6DQP9ee6AQwxgAIY7Y0T0DxclsZX2zov8j685f1PkYHSC/
         sEtlHzKu7nxdv8MwyUTFbhmVCeWiCTff/jXtohxBdtclkcsp+ifjwfxJPPcpmAsSRyR4
         KXVl52IQ6RYpjCtHtdDoOxHs7fqIuLnuPVFUK4ATSnmFe+f7GVtIC2yde3127GUy7ljJ
         ufH6SNOK8V8RhcIEssMO/5B/zW6xj25tY2bvdJhDdwhGw9PoVVrFmfQDx3LRshzoFzlh
         dJSvIVIquaI6J47zL8saDqfGJDKoRVh9Av4HOcRwIIcHZA/Zjm8eVFvvdkzmrBpp878L
         85kw==
X-Gm-Message-State: AOJu0YxpKpMH190t21f+yyBDNB+irQuOKQ0P+jY9BTyKQQ48beT/vVgI
	hKs7RHUeYEA+rGfI5MVKegdAAZjojPTiDxvOgeyOiRnAw75awAh2ew1r1COuXAhMQzFy7QC8yvC
	jYR47BPRzSd5BNZ2qLQRRbieX+vKCQ/UJVkh8
X-Google-Smtp-Source: AGHT+IFdX8B1HIDI6xRkkY0IE+V+KdYvFauYmlhUmVafK81CJG44zOMPQ20ffZHQKgCeaNCwkpO4MJXz/ig0GgDIZTU=
X-Received: by 2002:a81:6d16:0:b0:604:3a16:8aee with SMTP id
 i22-20020a816d16000000b006043a168aeemr533115ywc.33.1707161402144; Mon, 05 Feb
 2024 11:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202233855.1236422-1-tjmercier@google.com> <ZcC7Kgew3GDFNIux@tiehlicka>
In-Reply-To: <ZcC7Kgew3GDFNIux@tiehlicka>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 5 Feb 2024 11:29:49 -0800
Message-ID: <CABdmKX3HbSxX6zLF4z3f+=Ybiq1bA71jckkeHv5QJxAjSexgaA@mail.gmail.com>
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

On Mon, Feb 5, 2024 at 2:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Fri 02-02-24 23:38:54, T.J. Mercier wrote:
> > Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
> > reclaim") we passed the number of pages for the reclaim request directl=
y
> > to try_to_free_mem_cgroup_pages, which could lead to significant
> > overreclaim. After 0388536ac291 the number of pages was limited to a
> > maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overreclaim.
> > However such a small batch size caused a regression in reclaim
> > performance due to many more reclaim start/stop cycles inside
> > memory_reclaim.
>
> You have mentioned that in one of the previous emails but it is good to
> mention what is the source of that overhead for the future reference.

I can add a sentence about the restart cost being amortized over more
pages with a large batch size. It covers things like repeatedly
flushing stats, walking the tree, evaluating protection limits, etc.

> > Reclaim tries to balance nr_to_reclaim fidelity with fairness across
> > nodes and cgroups over which the pages are spread. As such, the bigger
> > the request, the bigger the absolute overreclaim error. Historic
> > in-kernel users of reclaim have used fixed, small sized requests to
> > approach an appropriate reclaim rate over time. When we reclaim a user
> > request of arbitrary size, use decaying batch sizes to manage error whi=
le
> > maintaining reasonable throughput.
>
> These numbers are with MGLRU or the default reclaim implementation?

These numbers are for both. root uses the memcg LRU (MGLRU was
enabled), and /uid_0 does not.

> > root - full reclaim       pages/sec   time (sec)
> > pre-0388536ac291      :    68047        10.46
> > post-0388536ac291     :    13742        inf
> > (reclaim-reclaimed)/4 :    67352        10.51
> >
> > /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> > pre-0388536ac291      :    258822       1.12            107.8
> > post-0388536ac291     :    105174       2.49            3.5
> > (reclaim-reclaimed)/4 :    233396       1.12            -7.4
> >
> > /uid_0 - full reclaim     pages/sec   time (sec)
> > pre-0388536ac291      :    72334        7.09
> > post-0388536ac291     :    38105        14.45
> > (reclaim-reclaimed)/4 :    72914        6.96
> >
> > Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactiv=
e reclaim")
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > ---
> > v3: Formatting fixes per Yosry Ahmed and Johannes Weiner. No functional
> > changes.
> > v2: Simplify the request size calculation per Johannes Weiner and Micha=
l Koutn=C3=BD
> >
> >  mm/memcontrol.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 46d8d02114cf..f6ab61128869 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6976,9 +6976,11 @@ static ssize_t memory_reclaim(struct kernfs_open=
_file *of, char *buf,
> >               if (!nr_retries)
> >                       lru_add_drain_all();
> >
> > +             /* Will converge on zero, but reclaim enforces a minimum =
*/
> > +             unsigned long batch_size =3D (nr_to_reclaim - nr_reclaime=
d) / 4;
>
> This doesn't fit into the existing coding style. I do not think there is
> a strong reason to go against it here.

There's been some back and forth here. You'd prefer to move this to
the top of the while loop, under the declaration of reclaimed? It's
farther from its use there, but it does match the existing style in
the file better.

> > +
> >               reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> > -                                     min(nr_to_reclaim - nr_reclaimed,=
 SWAP_CLUSTER_MAX),
> > -                                     GFP_KERNEL, reclaim_options);
> > +                                     batch_size, GFP_KERNEL, reclaim_o=
ptions);
>
> Also with the increased reclaim target do we need something like this?
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4f9c854ce6cc..94794cf5ee9f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1889,7 +1889,7 @@ static unsigned long shrink_inactive_list(unsigned =
long nr_to_scan,
>
>                 /* We are about to die and free our memory. Return now. *=
/
>                 if (fatal_signal_pending(current))
> -                       return SWAP_CLUSTER_MAX;
> +                       return sc->nr_to_reclaim;
>         }
>
>         lru_add_drain();
> >
> >               if (!reclaimed && !nr_retries--)
> >                       return -EAGAIN;
> > --

This is interesting, but I don't think it's closely related to this
change. This section looks like it was added to delay OOM kills due to
apparent lack of reclaim progress when pages are isolated and the
direct reclaimer is scheduled out. A couple things:

In the context of proactive reclaim, current is not really undergoing
reclaim due to memory pressure. It's initiated from userspace. So
whether it has a fatal signal pending or not doesn't seem like it
should influence the return value of shrink_inactive_list for some
probably unrelated process. It seems more straightforward to me to
return 0, and add another fatal signal pending check to the caller
(shrink_lruvec) to bail out early (dealing with OOM kill avoidance
there if necessary) instead of waiting to accumulate fake
SWAP_CLUSTER_MAX values from shrink_inactive_list.

As far as changing the value, SWAP_CLUSTER_MAX puts the final value of
sc->nr_reclaimed pretty close to sc->nr_to_reclaim. Since there's a
loop for each evictable lru in shrink_lruvec, we could end up with 4 *
sc->nr_to_reclaim in sc->nr_reclaimed if we switched to
sc->nr_to_reclaim from SWAP_CLUSTER_MAX... an even bigger lie. So I
don't think we'd want to do that.

