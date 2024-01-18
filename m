Return-Path: <linux-kernel+bounces-30430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAB5831E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F246EB21754
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94352D04F;
	Thu, 18 Jan 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="s33QlwOz"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D362D047
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599584; cv=none; b=E2kYXxTcKF58+2h6PHvA0v3KhZYacrKS5wZXSp5oj/ia1FB5DBXt+SJ1deKllSBARN2Icm98NMN33y1GfgGKSAX3nYErWrGYRUyOdKYLqFDQ+9dfAe23+Fk6CQXbCZGLmRMfJmkmZ/zH9NUotzPtOlvYCqH418y28uUJ4awwD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599584; c=relaxed/simple;
	bh=zRO6cEdtWk6YI0eWCOoxxFBcS+v2nLysBcJbEvv6Z6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsbGvQMTfScfl3U8N2F8PVjr8rDHd15195V+vB+W/6rjUDX32+r46cs8AuapgW/As7FINB2826/Zk3qhNU/1hZaU6DVMSWW+1aRM1BsQ0eqEQZVEf5MdVKNlp/n0ofxQYFSMnsrezT2Px8uf/NNO5nTXbYDxt4pWV3XV/lt8wYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=s33QlwOz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a12b8db9eso11405001cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705599580; x=1706204380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvq0mFjEzgAFfzxKF8Z+G+SXAKzYV+yY1dbbQe58I6s=;
        b=s33QlwOzrE9PFHsrOdiahpM0qwziDOBRfBzGohy/PHpaoJ5rXwhJK6ck2zJQ9oBlU5
         9k3PGCzVI//JOQn3VIvF00DNuhxJRlgBL+w8ps/ebW7pRBgtahetTKuKZcUvKVGt3RqM
         N8DLGQdqJ3UQtqhHsjArQ/GE1ROl8cKqbbyFCTiK2HT/sYAjxD7d6Sv/RbSYHKLXxUAL
         KOrYkB02iczBjZbhroSZjuMVddcHn7jfA6OV5xdTrasBRwdAhYVQX7RYytn0GRukDVpH
         7cc37mUztBZ4hfgR82W/UTMpQ0qM58KI2+RReHoAqxdV0A1nuvSFf4K8azYkFQURQcIx
         B5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705599580; x=1706204380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uvq0mFjEzgAFfzxKF8Z+G+SXAKzYV+yY1dbbQe58I6s=;
        b=ku7RCnyMnJ1a4OcvSrRDMeLmzIJsi6RusHTuI4SZ00VVdcgbvAwsrDYoIIrARWdjbg
         vgVCNvQtEEaZ1yx/nvJQaBm8SyVoKXQTYCHkJmof80G9EjCASeryk9aHvVZDhzCBEj1D
         7cJosa+qAB5HggLO3KiDBh2X5dDvg211KluSKzrP7cUxrNoz/NixC9gC2TYXW5ylJfIl
         ZhY7SaLJrQjAMUU5oCVk+CaNibd8GeNW6HHChYcQlKjl+U0PNiJcXIfxxsbDXM1is42E
         ER/rE8jEBtn1XeMOTFPRGk3iSAZJNtoPLoo84n0mnnkScBdmB2l8JKqcy7ctN5vaxpGA
         wcQg==
X-Gm-Message-State: AOJu0YzSzOlpO1gjoAF6SRNh9Z86GiMRfE9jkYMmw5BjAAW0OUsOYUmV
	Xs1pv/IWrJOJKsf8DTtr7vwsbhsPAlf6Ih0BLu1nIP7C2k5C5LWYbMiOXlPAofs=
X-Google-Smtp-Source: AGHT+IGspJSI/C69p7u1x0P0yeqzHz6GoQcIQ+/Ac9KGCXOZYgh660IbmTXvzXJ4S3SKmSxi0Vs6rw==
X-Received: by 2002:a05:622a:3cf:b0:429:b273:22cb with SMTP id k15-20020a05622a03cf00b00429b27322cbmr1178392qtx.60.1705599580109;
        Thu, 18 Jan 2024 09:39:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:1096])
        by smtp.gmail.com with ESMTPSA id bx3-20020a05622a090300b004299d262017sm6903232qtb.66.2024.01.18.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 09:39:39 -0800 (PST)
Date: Thu, 18 Jan 2024 12:39:27 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Ronald Monthero <debug.penguin32@gmail.com>, sjenning@redhat.com,
	ddstreet@ieee.org, vitaly.wool@konsulko.com,
	akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
Message-ID: <20240118173927.GL939255@cmpxchg.org>
References: <CAKEwX=NLe-N6dLvOVErPSL3Vfw6wqHgcUBQoNRLeWkN6chdvLQ@mail.gmail.com>
 <20240116133145.12454-1-debug.penguin32@gmail.com>
 <CAKEwX=PjraCg_NjP4Tnkbv8uqnVw8yJGh-mbuZC02Gp6HMcDBw@mail.gmail.com>
 <CAJD7tkb_uC_K7+C3GjVqg1rDRCmUkbHcEw950CkUHG66yokbcg@mail.gmail.com>
 <20240118161601.GJ939255@cmpxchg.org>
 <CAJD7tkb+NCocjpjvM08Nv2fPMDqm4t-YH05TJckz8m1AYFNWUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkb+NCocjpjvM08Nv2fPMDqm4t-YH05TJckz8m1AYFNWUg@mail.gmail.com>

On Thu, Jan 18, 2024 at 09:06:43AM -0800, Yosry Ahmed wrote:
> > > > On a different note, I wonder if it would help to perform synchronous
> > > > reclaim here instead. With our current design, the zswap store failure
> > > > (due to global limit hit) would leave the incoming page going to swap
> > > > instead, creating an LRU inversion. Not sure if that's ideal.
> > >
> > > The global shrink path keeps reclaiming until zswap can accept again
> > > (by default, that means reclaiming 10% of the total limit). I think
> > > this is too expensive to be done synchronously.
> >
> > That thresholding code is a bit weird right now.
> >
> > It wakes the shrinker and rejects at the same time. We're guaranteed
> > to see rejections, even if the shrinker has no trouble flushing some
> > entries a split second later.
> >
> > It would make more sense to wake the shrinker at e.g. 95% full and
> > have it run until 90%.
> >
> > But with that in place we also *should* do synchronous reclaim once we
> > hit 100%. Just enough to make room for the store. This is important to
> > catch the case where reclaim rate exceeds swapout rate. Rejecting and
> > going to swap means the reclaimer will be throttled down to IO rate
> > anyway, and the app latency isn't any worse. But this way we keep the
> > pipeline alive, and keep swapping out the oldest zswap entries,
> > instead of rejecting and swapping what would be the hottest ones.
> 
> I fully agree with the thresholding code being weird, and with waking
> up the shrinker before the pool is full. What I don't understand is
> how we can do synchronous reclaim when we hit 100% and still respect
> the acceptance threshold :/
> 
> Are you proposing we change the semantics of the acceptance threshold
> to begin with?

I kind of am. It's worth looking at the history of this knob.

It was added in 2020 by 45190f01dd402112d3d22c0ddc4152994f9e1e55, and
from the changelogs and the code in this patch I do not understand how
this was supposed to work.

It also *didn't* work for very basic real world applications. See
Domenico's follow-up (e0228d590beb0d0af345c58a282f01afac5c57f3), which
effectively reverted it to get halfway reasonable behavior.

If there are no good usecases for this knob, then I think it makes
sense to phase it out again.

