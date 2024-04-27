Return-Path: <linux-kernel+bounces-161063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B27C8B469E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A4E1C2178D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EFC50260;
	Sat, 27 Apr 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="2sOhvJeI"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B84F8A0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714227763; cv=none; b=OfqtwwmA8aT1nFO/+NpqcMgEovgasyXrO8hRXGiZ9E3//Tseax0fcdPHvxTeFqeLVr15VxuPm2P4n1tuR+2fSm8paMqPGYWxAdOfepQLv9aLUpDMXGjQzzoVp/Y+9pNbVa8SetyIrThsVnHbvw1K+D2DijgKjaYrHPCqfgOK2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714227763; c=relaxed/simple;
	bh=nTwNWxEsxbK6ttMKH6RkgIHZODyzl7FbYPFbXctiX3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDFDNZYaw1VSz1vpoBKxO0s9AhpMhbvpE/htdzpiw9Fw+NW3KNSi6xCeUax4HDbm6jQVC3gQwimHAv3yGUTslTI/kASdVbgjQUw1+ghY7o3DVS/NNeriPDT54/FtgDP6oUE4M1A3R8ivg8pHTEqb8DW/wPE5OdnqAo+S5WK5RN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=2sOhvJeI; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c85a9b9143so823370b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1714227759; x=1714832559; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=my9A5bfRcuk8Vub7UGZ+fWvF69oRVjwTLMcPliiDick=;
        b=2sOhvJeILVS4NS5Cwe7xWykq1hpBIkpt9I/oD3H1GTPGg3QQGGwMgTRqBTgQsCG4Jj
         cHx5W7lrOz+fQkZRtlAzcppzNtU5bpn0hNqttyJu11feIe2Iy0Zcdj7D8qbXmVLEpbVY
         RW2y5XhflnE/PrvfdGGD9NWTVt2z2I0oyU9ljlhyFOjxLWYEJtu4Arzmg2BDrV6dUo4Y
         ZXPoKeDRZ0D5G+BMty3b2LJ2z8ybV3/Q/eejq3KQv6bNTDVypEXJuqarZdv4YZqPSJI8
         fpjD1U1+wROLIHCuOd/NhMFJXax54LC/EVLRsuJcKFQ/jcUf/KodwUenmRbU3S1VAAS0
         i6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714227759; x=1714832559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=my9A5bfRcuk8Vub7UGZ+fWvF69oRVjwTLMcPliiDick=;
        b=gEEVmPyQ/UzWJbwVxGwShxnvdaxV9SD1SSsV7CBSKIjT7gWizo4bK0mPWLY7NnmPEA
         pzyFykQCj6wqytsK5ITtWiV6sfKEo06nJkSrQkKTDwm6BmZ1HQbTTruurG5XlE4kPVkC
         GvxPXkPvphzHP3FgrPCsk4yoNk6T8tB2edYl/PlPnN3l9bjjs4hIWrVtSwE6YgLcyjAA
         xZjTMWETXPLPq/DOQ/VhhgH+0IEBh48XSznlu3d4Rthbc9WhRy8vXGKl33dWAXxuU39z
         5oW95ZNKqlSIjVPFOQAJFuq9ZF0KBppeLpRieP7GUy85JY1zBZ+vP9qTXyem9056FrIc
         xX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOyBxrAk1q0TZrlHA1EsRgmZMqGYN0EU9g+gufCPL4u6q1AuxOVFrXWeMIp948YgRxocsADWVGJ2XmSGvybYMqvQQfBmpgzAeWJ2wM
X-Gm-Message-State: AOJu0Yy/kOszlRYDMlfUgHLgL5igL0VlXvq7LcWDue9TMOU4T+dqNr70
	Bh05rVEgDCj/v1cKGkkNiQ5uTyfhk1IqVmBOSTYz3CgGKyUdY8NpcA6NZRjQGxPrC8IcmfmwkI3
	H
X-Google-Smtp-Source: AGHT+IGlXUiLHaSxK/O81O0idYFAzC3VKjq1uq3uVPy3u/Opul3t1XhcpmxelrF849KjN41z3KT0Og==
X-Received: by 2002:a05:6808:a88:b0:3c8:47a3:3d01 with SMTP id q8-20020a0568080a8800b003c847a33d01mr5963751oij.34.1714227759436;
        Sat, 27 Apr 2024 07:22:39 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id y13-20020ad445ad000000b0069b4f48003bsm1847901qvu.100.2024.04.27.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 07:22:38 -0700 (PDT)
Date: Sat, 27 Apr 2024 10:22:34 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] memcg: pr_warn_once for unexpected events and
 stats
Message-ID: <20240427142234.GA1155473@cmpxchg.org>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
 <20240427003733.3898961-6-shakeel.butt@linux.dev>
 <CAJD7tkZJBBOfhHXfweJu367ov0GnppLTiUMLdoq=TcWnqu2q5w@mail.gmail.com>
 <dsxeqlmrxyxfi2i7yzhdrukwiczh7sjcwfobaytdgkckjez36b@u6ooikkgyyf4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dsxeqlmrxyxfi2i7yzhdrukwiczh7sjcwfobaytdgkckjez36b@u6ooikkgyyf4>

On Fri, Apr 26, 2024 at 06:18:13PM -0700, Shakeel Butt wrote:
> On Fri, Apr 26, 2024 at 05:58:16PM -0700, Yosry Ahmed wrote:
> > On Fri, Apr 26, 2024 at 5:38 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > >
> > > To reduce memory usage by the memcg events and stats, the kernel uses
> > > indirection table and only allocate stats and events which are being
> > > used by the memcg code. To make this more robust, let's add warnings
> > > where unexpected stats and events indexes are used.
> > >
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > ---
> > >  mm/memcontrol.c | 43 ++++++++++++++++++++++++++++++++++---------
> > >  1 file changed, 34 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 103e0e53e20a..36145089dcf5 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -671,9 +671,11 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
> > >                 return node_page_state(lruvec_pgdat(lruvec), idx);
> > >
> > >         i = memcg_stats_index(idx);
> > > -       if (i >= 0) {
> > > +       if (likely(i >= 0)) {
> > >                 pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> > >                 x = READ_ONCE(pn->lruvec_stats->state[i]);
> > > +       } else {
> > > +               pr_warn_once("%s: stat item index: %d\n", __func__, idx);
> > >         }
> > 
> > Can we make these more compact by using WARN_ON_ONCE() instead:
> > 
> > if (WARN_ON_ONCE(i < 0))
> >          return 0;
> > 
> > I guess the advantage of using pr_warn_once() is that we get to print
> > the exact stat index, but the stack trace from WARN_ON_ONCE() should
> > make it obvious in most cases AFAICT.

if (WARN_ONCE(i < 0, "stat item %d not in memcg_node_stat_items\n", i))
	return 0;

should work?

> > No strong opinions either way.
> 
> One reason I used pr_warn_once() over WARN_ON_ONCE() is the syzbot
> trigger. No need to trip the bot over this error condition.

The warn splat is definitely quite verbose. But I think that would
only be annoying initially, in case a site was missed. Down the line,
it seems helpful to have this stand out to somebody who is trying to
add a new cgroup stat and forgets to update the right enums.

