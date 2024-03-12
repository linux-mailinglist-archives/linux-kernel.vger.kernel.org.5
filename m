Return-Path: <linux-kernel+bounces-99811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D56878DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C368281FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AF0B673;
	Tue, 12 Mar 2024 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yjhUyvpi"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB6A16FF2B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710216278; cv=none; b=Xof7757OrJFiuby3sBpI3nLOYFNmom4JjF+uUCQ8i9TCGFESM6YXLaSS/XVPkUOJDBlPzj0gjfrXdJ/QmNZHso2ik7Kah/PhnXy7q6fdguBT8O+BxrltkYTcTZbit5QWUnegGDndYAa9eCfj3XUNN9tbACJdkD37RczMinDNWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710216278; c=relaxed/simple;
	bh=TApHmX3ZfnF/JWvRBVZ/APk2hxMJw/vVztjTlsQKCug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K2piMXvzDTIGd0ZTGQsPT9tDCRubGWQTALXc8YUJWzgsk21S21HMdElGp2wwozSJ0hwnfH6oOSI9wh/O7QNhH8VefAyn9EbXUjddB86S3PMSGj3An/hsMO3EsPwL/kE8ALTwwacyDvyWj2zV9FAAdOlqg27tQ9SP9pJj/rk1AGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yjhUyvpi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so6734467276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710216275; x=1710821075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKGHJnbXSzQyoajwNYJ2VuXwhIvgziwgeBLpVKyZTQA=;
        b=yjhUyvpiP9J1YMgY6HQNhO7XiO1tHQp52hRBvWSub+YwVj+k80krkUvxDuC5e/QBrD
         BqwCoP2dv0MrCEOyz/POvZToUF8zIl68QiaN0ywDa72IUGChloDCBnQiYI8keXmkPLpl
         hnO1GBblpUaU+y5vQ+c1z0b3jsQv9ULiCkYtYUJZB5pB/uFB02SEFNGbD8RzxESmjXOR
         P7W0EQYRVmp0k3icemvgi6AUZuXhoJP0nry7nyBRhnHcLwlyH2HZIrtkrkESbpkqSPTb
         7/cAqMmnCupYAqhUqGIqh2hWKn+LMyVCRDztdXa858VF5uQL2MVB+c7gTtyK0Joya6Th
         3MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710216275; x=1710821075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKGHJnbXSzQyoajwNYJ2VuXwhIvgziwgeBLpVKyZTQA=;
        b=WKH3tdgVX9YELThegz31DNJFOFp4uuyLDhiDo69aGWokoLhIp+cuG2mYEC/S6wPxul
         z1YmeNJsbqfHoAG8NbHwa8HFVHHdo3Y3pG34CKylWRd+40/9KG+A4EoHCdHE6PmVTgmU
         m0NKryWSUXCKECu8b8OUxaHF62sb7h3q3mQkr41D/bhIn8cVWlkFmYONYPIV/Wahw6Fj
         4h5y9/iyBWLIc4fL31/ZL/hFiMMUfiDsh0tL+nPJc0Cb5VT0cjLAxCrJJtvg8zaXov5d
         4OAKnWM+sa83q5Nvyyk+7iXjM+meVyg6idSl5nAZ/RX26G5rwdLzMGG3pCRK4Q/pGQcw
         gUhA==
X-Forwarded-Encrypted: i=1; AJvYcCUNoxJkXukg3CXhImvlh88yoOJXocRiYBiAh6652aA35mjZDO31epp3w8bJKdjLhDIQYeABiJKoYShLPFuvBnAN+2fH2vsUiv79N7Ol
X-Gm-Message-State: AOJu0Yy29KIq0Hk/0cV6GYW1LaugdK3OdXNmGaNmMdRlOL2MMQ4g1hfV
	hE9ESLX6kx9LjseU86LDieOggVPAfJbnyuXJZMAJ6MQXfAEXN/2DxrGQS37GgwvJcXAjLRnzxBX
	xr+wVaXaKtaeG4TblJA==
X-Google-Smtp-Source: AGHT+IHSM/RCW6tdjFD+iaaWS3QoWG/+A1iS87q9c84LEMGLBoDbTTaanEuiOY0eoHyvPbAVrOaVG1EO9mlzIkNe
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:c712:0:b0:dcf:6b50:9bd7 with SMTP
 id w18-20020a25c712000000b00dcf6b509bd7mr2202554ybe.7.1710216275352; Mon, 11
 Mar 2024 21:04:35 -0700 (PDT)
Date: Tue, 12 Mar 2024 04:04:33 +0000
In-Reply-To: <20240312023411.GA22705@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311161214.1145168-1-hannes@cmpxchg.org> <Ze-BH5HDNUG5ohJS@google.com>
 <20240312023411.GA22705@cmpxchg.org>
Message-ID: <Ze_UUeajWWkKpZJ0@google.com>
Subject: Re: [PATCH 1/2] mm: zswap: optimize zswap pool size tracking
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024 at 10:34:11PM -0400, Johannes Weiner wrote:
> On Mon, Mar 11, 2024 at 10:09:35PM +0000, Yosry Ahmed wrote:
> > On Mon, Mar 11, 2024 at 12:12:13PM -0400, Johannes Weiner wrote:
> > > Profiling the munmap() of a zswapped memory region shows 50%(!) of the
> > > total cycles currently going into updating the zswap_pool_total_size.
> > 
> > Yikes. I have always hated that size update scheme FWIW.
> > 
> > I have also wondered whether it makes sense to just maintain the number
> > of pages in zswap as an atomic, like zswap_stored_pages. I guess your
> > proposed scheme is even cheaper for the load/invalidate paths because we
> > do nothing at all.  It could be an option if the aggregation in other
> > paths ever becomes a problem, but we would need to make sure it
> > doesn't regress the load/invalidate paths. Just sharing some thoughts.
> 
> Agree with you there. I actually tried doing it that way at first, but
> noticed zram uses zs_get_total_pages() and actually wants a per-pool
> count. I didn't want the backend to have to update two atomics, so I
> settled for this version.

Could be useful to document this context if you send a v2. This version
is a big improvement anyway, so hopefully we don' t need to revisit.

> 
> > > There are three consumers of this counter:
> > > - store, to enforce the globally configured pool limit
> > > - meminfo & debugfs, to report the size to the user
> > > - shrink, to determine the batch size for each cycle
> > > 
> > > Instead of aggregating everytime an entry enters or exits the zswap
> > > pool, aggregate the value from the zpools on-demand:
> > > 
> > > - Stores aggregate the counter anyway upon success. Aggregating to
> > >   check the limit instead is the same amount of work.
> > > 
> > > - Meminfo & debugfs might benefit somewhat from a pre-aggregated
> > >   counter, but aren't exactly hotpaths.
> > > 
> > > - Shrinking can aggregate once for every cycle instead of doing it for
> > >   every freed entry. As the shrinker might work on tens or hundreds of
> > >   objects per scan cycle, this is a large reduction in aggregations.
> > > 
> > > The paths that benefit dramatically are swapin, swapoff, and
> > > unmaps. There could be millions of pages being processed until
> > > somebody asks for the pool size again. This eliminates the pool size
> > > updates from those paths entirely.
> > 
> > This looks like a big win, thanks! I wonder if you have any numbers of
> > perf profiles to share. That would be nice to have, but I think the
> > benefit is clear regardless.
> 
> I deleted the perf files already, but can re-run it tomorrow.

Thanks!

> 
> > I also like the implicit cleanup when we switch to maintaining the
> > number of pages rather than bytes. The code looks much better with all
> > the shifts and divisions gone :)
> > 
> > I have a couple of comments below. With them addressed, feel free to
> > add:
> > Acked-by: Yosry Ahmed <yosryahmed@google.com>
> 
> Thanks!
> 
> > > @@ -1385,6 +1365,10 @@ static void shrink_worker(struct work_struct *w)
> > >  {
> > >  	struct mem_cgroup *memcg;
> > >  	int ret, failures = 0;
> > > +	unsigned long thr;
> > > +
> > > +	/* Reclaim down to the accept threshold */
> > > +	thr = zswap_max_pages() * zswap_accept_thr_percent / 100;
> > 
> > This calculation is repeated twice, so I'd rather keep a helper for it
> > as an alternative to zswap_can_accept(). Perhaps zswap_threshold_page()
> > or zswap_acceptance_pages()?
> 
> Sounds good. I went with zswap_accept_thr_pages().

Even better.

> 
> > > @@ -1711,6 +1700,13 @@ void zswap_swapoff(int type)
> > >  
> > >  static struct dentry *zswap_debugfs_root;
> > >  
> > > +static int debugfs_get_total_size(void *data, u64 *val)
> > > +{
> > > +	*val = zswap_total_pages() * PAGE_SIZE;
> > > +	return 0;
> > > +}
> > > +DEFINE_DEBUGFS_ATTRIBUTE(total_size_fops, debugfs_get_total_size, NULL, "%llu");
> > 
> > I think we are missing a newline here to maintain the current format
> > (i.e "%llu\n").
> 
> Oops, good catch! I had verified the debugfs file (along with the
> others) with 'grep . *', which hides that this is missing. Fixed up.
> 
> Thanks for taking a look. The incremental diff is below. I'll run the
> tests and recapture the numbers tomorrow, then send v2.

LGTM. Feel free to carry the Ack forward.

