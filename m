Return-Path: <linux-kernel+bounces-68170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A658576C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFED2B211C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7059415E90;
	Fri, 16 Feb 2024 07:24:49 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC1412E75
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708068289; cv=none; b=O+6mQJAhA9rL4qE9fme19Z5XAZUSJSObr1w3XPyFPQ7aV2A3YhPyhKoeqHvKaNB6E/4Frekg6i8rLQqJDkwHorrbgEP/omBfErkEEunpULvLh+X3EgWYYcC+vKS0TzvlWKvnHpyw/dLjbXeBk0QZR2ZPWyJtUh+bu1OOhHciPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708068289; c=relaxed/simple;
	bh=Lk7daBY/Jy9gaZOSw5t3PWrAv/St8ebhXqQG+kXb+VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3uUvjG9wH0n1Wc5xkvg2JENhs5+VGzm27+1cp7MghfHIqHO2Hqv+5Vbsg6hR4Di3uglr54uk9PDJNlQIG/JI2uFkDvyB61xniH81QQeO8Bqox80aahJnCUFB7laqQXkJxpObOzZn0pMOajxlvYaNVGdlObkMZ0+bAm6+TLv6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-6b-65cf0db7c462
Date: Fri, 16 Feb 2024 16:24:34 +0900
From: Byungchul Park <byungchul@sk.com>
To: Yu Zhao <yuzhao@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [PATCH] mm, vmscan: Don't turn on cache_trim_mode at the highest
 scan priority
Message-ID: <20240216072434.GC32626@system.software.com>
References: <20240208061825.36640-1-byungchul@sk.com>
 <CAOUHufYUC-oWePfqbbmm15Ue9QLfPg1G2nhXn6iSX_A460O6Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYUC-oWePfqbbmm15Ue9QLfPg1G2nhXn6iSX_A460O6Uw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC9ZZnoe523vOpBg8XmFvMWb+GzeLyrjls
	FvfW/Ge1eDfhC6sDi8eCTaUemz5NYvc4MeM3i8fnTXIBLFFcNimpOZllqUX6dglcGUenPGMq
	OCJYsW3TDpYGxl28XYycHBICJhIbrq5mhLG3nb3GBGKzCKhKXH7ZwApiswmoS9y48ZMZxBYR
	kJeY8PIZexcjBwezQJbE9NYoEFNYIFZi6cdwkApeAQuJH/2HwCYKCdRILP50lQUiLihxcuYT
	MJsZaOKfeZeYIaZISyz/xwERlpdo3jobbBGnQKDEs/UbwcaICihLHNh2HOgwLqAj57BJ3P25
	kBXiYkmJgytusExgFJyFZMUsJCtmIayYhWTFAkaWVYxCmXlluYmZOSZ6GZV5mRV6yfm5mxiB
	wb2s9k/0DsZPF4IPMQpwMCrx8B74czZViDWxrLgy9xCjBAezkgjvpN4zqUK8KYmVValF+fFF
	pTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoY+R+cDQ4S/fdTqmbVlJ9f9Hjn
	JvQy6F/8XtTwJ5qN8btTRPQniWthtoEvtn9RbVi3f83PxmoTId6qk8GaTspCC7zX+gQ3mU5W
	vPIspfP1y083uBN3Cc/oMuCXfbDPdM5imXPibDOLb75pWs69h3lt2GfXvoqaYqH2mPWOTy4+
	9DM7kcXBoLxeiaU4I9FQi7moOBEAHPkeHGoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsXC5WfdrLud93yqwYnDBhZz1q9hszg89ySr
	xeVdc9gs7q35z2rxbsIXVgdWjwWbSj02fZrE7nFixm8Wj8UvPjB5fN4kF8AaxWWTkpqTWZZa
	pG+XwJVxdMozpoIjghXbNu1gaWDcxdvFyMkhIWAise3sNSYQm0VAVeLyywZWEJtNQF3ixo2f
	zCC2iIC8xISXz9i7GDk4mAWyJKa3RoGYwgKxEks/hoNU8ApYSPzoP8QIYgsJ1Egs/nSVBSIu
	KHFy5hMwmxlo4p95l5ghpkhLLP/HARGWl2jeOhtsEadAoMSz9RvBxogKKEsc2HacaQIj3ywk
	k2YhmTQLYdIsJJMWMLKsYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAzVZbV/Ju5g/HLZ/RCj
	AAejEg/vgT9nU4VYE8uKK3MPMUpwMCuJ8E7qPZMqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcr
	PDVBSCA9sSQ1OzW1ILUIJsvEwSnVwMhTNlft8QvJOGldjykvwqq6Ig86e7LNyjm1c+4hgcP3
	36+W052cspz1FV84h4gJU7fhOr+dn8vMEz4ftt194/Z9bR8L6fa0Lp5vE19FPJjMK1x4u3OZ
	nKX3U+OZ1SJHvRbY89Xf+umi/PPfB52jP89nnHglVnDfZeaU+XnTly+1szjJ82ljdbYSS3FG
	oqEWc1FxIgAhchrLUQIAAA==
X-CFilter-Loop: Reflected

On Fri, Feb 16, 2024 at 12:55:17AM -0500, Yu Zhao wrote:
> On Thu, Feb 8, 2024 at 1:18 AM Byungchul Park <byungchul@sk.com> wrote:
> >
> > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> > pages. However, it should be more careful to turn on the mode because
> > it's going to prevent anon pages from reclaimed even if there are huge
> > ammount of anon pages that are very cold so should be reclaimed. Even
> > worse, that can lead kswapd_failures to be MAX_RECLAIM_RETRIES and stop
> > until direct reclaim eventually works to resume kswapd.
> 
> Is a theory or something observed in the real world? If it's the
> former, would this change risk breaking existing use cases? It's the

I faced the latter case.

> latter, where are the performance numbers to show what it looks like
> before and after this patch?

Before:

Whenever the system meets the condition to turn on cache_trim_mode but
few cache pages to trim, kswapd fails without scanning anon pages that
are plenty and cold for sure and it retries 8 times and looks *stopped
for ever*.

After:

When the system meets the condition to turn on cache_trim_mode but few
cache pages to trim, kswapd finally works at the highest scan priority.
So kswap looks working well even in the same condition.

> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  mm/vmscan.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bba207f41b14..25b55fdc0d41 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2268,7 +2268,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >          * anonymous pages.
> >          */
> >         file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> > -       if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> > +       if (sc->priority != 1 && file >> sc->priority &
> 
> Why 1?

It means the highest scan priority. The priority goes from DEF_PRIORITY
to 1.

	Byungchul

> > +           !(sc->may_deactivate & DEACTIVATE_FILE))
> >                 sc->cache_trim_mode = 1;
> >         else
> >                 sc->cache_trim_mode = 0;

