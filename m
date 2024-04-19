Return-Path: <linux-kernel+bounces-151576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A6E8AB0A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B586F1C219E4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC912D76B;
	Fri, 19 Apr 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="RPcZBAc+"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D21292DC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536562; cv=none; b=S8GRj4jFE5NhlBcENMSsJfdGtLUo3wARORmphFIgtSEErbx3MiV5GlUIJDPu4kCuuBTiku8YNmKFsyqWNROmIDUXa/xxVWhFsx99DeJmt+9BvCKJStCAhTSxqzBkEfTEWbRNchk1Bqtc4NIvdWcB62DvaOh0UVFJmIp65/jlb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536562; c=relaxed/simple;
	bh=+LiWUh2zMmA3ZvW6BiIH2guXxJ9WZ0K6RkAq9Pn05SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYeXFMa787/rXKN13uMN8eRH+OQNxV2DtJSm2Sp0YNh3cRuAGtiWdydABocKp3gsrktD1hBxI5n8i6wsEQhmBuhDrznDEHzM8N0cNjAC7TFzqE5EGhbQLjvrwxW56fX0mOkBibovvmYp/vUYJ+kDhlUf9vOsBIqFMhXjmgFcLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=RPcZBAc+; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69cb4a046dfso7270036d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1713536557; x=1714141357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LbB4KcsnZXNmzG/MHQb9mgjRPkbbsvmUawk+gcbg5EQ=;
        b=RPcZBAc+vReJTc4kGIYjReLCAN89malZo6YbnkAaoY/KPfSS2vGRMwdBdPT9uDEJjE
         VsLYEPiHJm0/heo1i33vvYtjGRl+6IQaiN+SGB1WZBtzoS6kDB/gdUaNCHPng7NhEvfo
         nIcya1SsBxdbwjeWgKF2DeikK6Kc8pKqgRvxKRX+q3CDeYSNTlekLfvUU9g7ZI1YiGYT
         YbAFHbcqJ7VZyrgNluj+uwuGklyjM4UTG7PH+M8MqtpJJTl9stVi2tL6sEdmVyWeWIfF
         io+k8oj/mf5dBE3o6NsfJ/1bun2YPpWaMtRLIChWSbZLMhvAaB+dL2Zkrg9ZsoWOsLvV
         GIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713536557; x=1714141357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbB4KcsnZXNmzG/MHQb9mgjRPkbbsvmUawk+gcbg5EQ=;
        b=ET8YvUuHIwQjCvcMJwEgV9QR1gokbdPAZSNKxUp6TxFbNc9FiB/btejeWs3Op+UOWv
         VXt9dTm1r22L5M8BGjHw6fJ0qDQykqSD2jPb3jGcYnOE01qBcDfVXXBoipNHOpH8OSi5
         Mq8yjKBoaZ3KM8ilFoOA0KeDNfY813RYjBat+y8OGkKNGwCHTpAdffbqA1bGNaeb5Cpf
         QqVxqjBbDhbZwBsJ1dY8+5ktMn8+SDXgMW9yRADROuMdEvud+d2Zwah+Jdqh2F9MWXok
         pL4CssbptpOz1DTAfhkumZHLZvrvTiaFasvUlcjAMAfFMKjQ86lKPHr2Eq4cYE57L3QB
         MSww==
X-Forwarded-Encrypted: i=1; AJvYcCWNW/6todNmAOim/vzeQG5EO6FeVcVES9+Gm2hC33lw7dTyHiBE7sX4mVUUpXGjuGBWt+zClf3kfspWaowYxLpPqlXRGxgX8OghT+ln
X-Gm-Message-State: AOJu0Yy8/HseJ4Wz+TwGCLInbzqUOkwX8S5MSFO171Tz47nOOGXDVI/g
	tJQhkA0TX4uR3xlWf+6/U2/0ojzKzbArsZnPRLKhn8I9JG71hcSX9U0mso91Bww=
X-Google-Smtp-Source: AGHT+IGAI3mZDZDKIm7knl47VQHYokRRNSjt45GZvvX762bmRlykoI881JSyUDU3V8LFn5GMhKzNWA==
X-Received: by 2002:ad4:5981:0:b0:69b:2897:4fc4 with SMTP id ek1-20020ad45981000000b0069b28974fc4mr2177086qvb.58.1713536557076;
        Fri, 19 Apr 2024 07:22:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:fe4f])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cab4b000000b0069b59897310sm1582606qvb.63.2024.04.19.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 07:22:36 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:22:31 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Christian Heusel <christian@heusel.eu>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>, Seth Jennings <sjenning@redhat.com>,
	Dan Streetman <ddstreet@ieee.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Runge <dave@sleepmap.de>,
	"Richard W.M. Jones" <rjones@redhat.com>,
	Mark W <instruform@gmail.com>, regressions@lists.linux.dev
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
Message-ID: <20240419142231.GD1055428@cmpxchg.org>
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
 <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
 <CAKEwX=NM1y-K1-Yw=CH3cM-8odER1PZBVoWo-rs7_OdjFG_puw@mail.gmail.com>
 <CAKEwX=MWPUf1NMGdn+1AkRdOUf25ifAbPyoP9zppPTx3U3Tv2Q@mail.gmail.com>
 <246c1f4d-af13-40fa-b968-fbaf36b8f91f@linux.dev>
 <20240417143324.GA1055428@cmpxchg.org>
 <4c3ppfjxnrqx6g52qvvhqzcc4pated2q5g4mi32l22nwtrkqfq@a4lk6s5zcwvb>
 <20240418124043.GC1055428@cmpxchg.org>
 <CAJD7tkaPMQqQtfxcLWraz-vnbAxZKxuJRJ7vKuDOCCXtpBSF1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaPMQqQtfxcLWraz-vnbAxZKxuJRJ7vKuDOCCXtpBSF1A@mail.gmail.com>

On Thu, Apr 18, 2024 at 01:09:22PM -0700, Yosry Ahmed wrote:
> On Thu, Apr 18, 2024 at 5:40 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Apr 17, 2024 at 07:18:14PM +0200, Christian Heusel wrote:
> > > On 24/04/17 10:33AM, Johannes Weiner wrote:
> > > >
> > > > Christian, can you please test the below patch on top of current
> > > > upstream?
> > > >
> > >
> > > Hey Johannes,
> > >
> > > I have applied your patch on top of 6.9-rc4 and it did solve the crash for
> > > me, thanks for hacking together a fix so quickly! 🤗
> > >
> > > Tested-By: Christian Heusel <christian@heusel.eu>
> >
> > Thanks for confirming it, and sorry about the breakage.
> >
> > Andrew, can you please use the updated changelog below?
> >
> > ---
> >
> > From 52f67f5fab6a743c2aedfc8e04a582a9d1025c28 Mon Sep 17 00:00:00 2001
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Date: Thu, 18 Apr 2024 08:26:28 -0400
> > Subject: [PATCH] mm: zswap: fix shrinker NULL crash with cgroup_disable=memory
> >
> > Christian reports a NULL deref in zswap that he bisected down to the
> > zswap shrinker. The issue also cropped up in the bug trackers of
> > libguestfs [1] and the Red Hat bugzilla [2].
> >
> > The problem is that when memcg is disabled with the boot time flag,
> > the zswap shrinker might get called with sc->memcg == NULL. This is
> > okay in many places, like the lruvec operations. But it crashes in
> > memcg_page_state() - which is only used due to the non-node accounting
> > of cgroup's the zswap memory to begin with.
> >
> > Nhat spotted that the memcg can be NULL in the memcg-disabled case,
> > and I was then able to reproduce the crash locally as well.
> >
> > [1] https://github.com/libguestfs/libguestfs/issues/139
> > [2] https://bugzilla.redhat.com/show_bug.cgi?id=2275252
> >
> > Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> > Cc: stable@vger.kernel.org      [v6.8]
> > Link: https://lkml.kernel.org/r/20240417143324.GA1055428@cmpxchg.org
> > Reported-by: Christian Heusel <christian@heusel.eu>
> > Debugged-by: Nhat Pham <nphamcs@gmail.com>
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Tested-By: Christian Heusel <christian@heusel.eu>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Thanks for fixing this. A couple of comments/questions below, but anyway LGTM:
> 
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
> 
> > ---
> >  mm/zswap.c | 25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index caed028945b0..6f8850c44b61 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1331,15 +1331,22 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
> >         if (!gfp_has_io_fs(sc->gfp_mask))
> >                 return 0;
> >
> > -#ifdef CONFIG_MEMCG_KMEM
> > -       mem_cgroup_flush_stats(memcg);
> > -       nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
> > -       nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
> > -#else
> > -       /* use pool stats instead of memcg stats */
> > -       nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
> > -       nr_stored = atomic_read(&zswap_nr_stored);
> > -#endif
> > +       /*
> > +        * For memcg, use the cgroup-wide ZSWAP stats since we don't
> > +        * have them per-node and thus per-lruvec. Careful if memcg is
> > +        * runtime-disabled: we can get sc->memcg == NULL, which is ok
> > +        * for the lruvec, but not for memcg_page_state().
> > +        *
> > +        * Without memcg, use the zswap pool-wide metrics.
> > +        */
> > +       if (!mem_cgroup_disabled()) {
> 
> With the current shrinker code, it seems like we cannot get sc->memcg
> == NULL unless mem_cgroup_disabled() is true indeed. However, maybe
> it's better to check if sc->memcg is not NULL directly instead?
> 
> This would be more resilient in case the shrinker code changes and
> passing sc->memcg == NULL becomes possible in other cases (e.g. during
> global shrinking). It seems like other shrinkers do this, for example
> see count_shadow_nodes() and deferred_split_count().

Eh, I'm not sure it's better or worse, so it's a bit hard to care. We
shouldn't get NULL here when memcg is enabled, and if somebody
introduces that bug it's better to catch it early than run into subtle
priority inversions when the kernel is deployed to millions of hosts.

> I am also wondering if we should also check !mem_cgroup_is_root()
> here? We can avoid the expensive global flush and use the global stats
> directly in this case. I could also send a follow up patch for this if
> that's preferred.

I'd rather not proliferate more memcg internals in this code. If this
is a concern, optimizing it in the flush and stat functions would make
more sense. Reclaim already flushes the subtree before getting here,
so odds are good this is a no-op in most cases.

