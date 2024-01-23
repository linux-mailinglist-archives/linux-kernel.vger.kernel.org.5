Return-Path: <linux-kernel+bounces-35574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A20783937F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC691C25673
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522ED6167A;
	Tue, 23 Jan 2024 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="FlsQcOUa"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5960253
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024340; cv=none; b=CvWJ4tcrI4pTsjZgHjMVn88SnXQklSI6zsSfG4OJQYR3T7zQ0n57PUQmFceOwQfyZ3ZACz3hItFoSBHPFnVkmrVNLM9OOryz39YcN6SUGixTUpWHbVgtLaoSGV/gPwNkbbNlgIGZeAEm4BsBZfTHrl7cwCuVDQdjaFUANyA5KkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024340; c=relaxed/simple;
	bh=t1G+kBjFokoEv87HEn+pzRZOA6hOVC+Lp7RYHJOHV4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhD2wnjVIcJHIOvhJ5JV8cur0Bt8jl2M55HqbSlqJPwkJMWwzlaGqtOEfJEtKWkZtGbA4PQ8CT6nc+OPiMvlcoFec6jlFBRUHGLGX3FlvKy+J1H/4dL5z/rJhwnhKGrfp9ltxMpAyVREsDCor+WmDshHBsQ3aKmjWb5oZDDMH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=FlsQcOUa; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21499c9650cso152657fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706024336; x=1706629136; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1nP0lWvVSdV3ePRrfwC4/bRX6mgra3C2ztXq0kulIvo=;
        b=FlsQcOUa0H3BtIu5tvcmvdBnDPAYqmHKRqe/BbF5wEXMsMBn5fb2qHIIQcHi0GBpIl
         af3gJb+z/Jmdz0XIsODS5/0a9dMo5OJXwwm+Zdmx4zbNT09/FDnDiuf52Be8IgBQJCX3
         CB3aXoNome2VPBQu+1vf6xvIkp98e44orh2SomftkmRb/2K7nF2bboXHr5qhTpit7JVh
         VSEYUU0Pp9CMg12XVMli0bPciOKNrix75ziaK8uOK+UST6y/PxDcwz6NtY60M6wuL0AN
         B77BUpAX9Zots+KRVYHr0kYXUePoyh07mDO1fe5wHKSwqn7Wu35TppxVwRTCqxZSaAUj
         nX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024336; x=1706629136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nP0lWvVSdV3ePRrfwC4/bRX6mgra3C2ztXq0kulIvo=;
        b=ShaIhLHj/r/SKsKgCLQUPg9l6syDZygrUbDI5aovEEk3RbdCC1zUZg3qwbC2Up1OQp
         Gg6XY6H5I6BZV1AWbAaK0E2bu0hscEfAF5RCBUBI+GutEBWSSyi9TVMmVP9RltRRYcyC
         ktlHW1GyXBQQz3kNXT57hk173NuX6rq+HYRpJIpELyyqd4UZ4OZO0kJFw9QbkledXJVH
         Rwn34jNj93HSGZnh+odtfC17GVdnSmAAtKQifkH+LZvbnxV3X7o3yHkGQNtoJSDSVJt3
         IKzViUFDL401zciqoQPZnxas9NCrjwlS2F10Ur8cdIvOqeiVi/AWXPM1kBMlEBbUr48v
         j7NQ==
X-Gm-Message-State: AOJu0YyHzz1HHX+qVDPoAzAOQtHkXVVIJkHV025I3PkpujxgPIay/fvm
	H8nRMwZhm4bGiPZK7VVSyx5B6Z0P6gSuIhJdLBLRptu5W0v9HiJ6eeR8ZuUMbl0=
X-Google-Smtp-Source: AGHT+IEjyxHRQmDZau+xZqO7ups8UN2Vf2ApNGwlzm1r1pP4SSCaGsrMcbfuRBOxqpOwUglj0NWFgw==
X-Received: by 2002:a05:6871:5224:b0:203:88b1:31ce with SMTP id ht36-20020a056871522400b0020388b131cemr1659751oac.117.1706024336410;
        Tue, 23 Jan 2024 07:38:56 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-97cf-7b55-44af-acd6.res6.spectrum.com. [2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id d15-20020a056214184f00b006819a4354basm3567426qvy.37.2024.01.23.07.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:38:56 -0800 (PST)
Date: Tue, 23 Jan 2024 10:38:51 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in
 zswap_swapoff()
Message-ID: <20240123153851.GA1745986@cmpxchg.org>
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com>
 <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>

On Mon, Jan 22, 2024 at 12:39:16PM -0800, Yosry Ahmed wrote:
> On Mon, Jan 22, 2024 at 12:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Sat, Jan 20, 2024 at 02:40:07AM +0000, Yosry Ahmed wrote:
> > > During swapoff, try_to_unuse() makes sure that zswap_invalidate() is
> > > called for all swap entries before zswap_swapoff() is called. This means
> > > that all zswap entries should already be removed from the tree. Simplify
> > > zswap_swapoff() by removing the tree cleanup loop, and leaving an
> > > assertion in its place.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > That's a great simplification.
> >
> > Removing the tree->lock made me double take, but at this point the
> > swapfile and its cache should be fully dead and I don't see how any of
> > the zswap operations that take tree->lock could race at this point.
> 
> It took me a while staring at the code to realize this loop is pointless.
> 
> However, while I have your attention on the swapoff path, there's a
> slightly irrelevant problem that I think might be there, but I am not
> sure.
> 
> It looks to me like swapoff can race with writeback, and there may be
> a chance of UAF for the zswap tree. For example, if zswap_swapoff()
> races with shrink_memcg_cb(), I feel like we may free the tree as it
> is being used. For example if zswap_swapoff()->kfree(tree) happen
> right before shrink_memcg_cb()->list_lru_isolate(l, item).
> 
> Please tell me that I am being paranoid and that there is some
> protection against zswap writeback racing with swapoff. It feels like
> we are very careful with zswap entries refcounting, but not with the
> zswap tree itself.

Hm, I don't see how.

Writeback operates on entries from the LRU. By the time
zswap_swapoff() is called, try_to_unuse() -> zswap_invalidate() should
will have emptied out the LRU and tree.

Writeback could have gotten a refcount to the entry and dropped the
tree->lock. But then it does __read_swap_cache_async(), and while
holding the page lock checks the tree under lock once more; if that
finds the entry valid, it means try_to_unuse() hasn't started on this
page yet, and would be held up by the page lock/writeback state.

> > > Chengming, Chris, I think this should make the tree split and the xarray
> > > conversion patches simpler (especially the former). If others agree,
> > > both changes can be rebased on top of this.
> >
> > The resulting code is definitely simpler, but this patch is not a
> > completely trivial cleanup, either. If you put it before Chengming's
> > patch and it breaks something, it would be difficult to pull out
> > without affecting the tree split.
> 
> Are you suggesting I rebase this on top of Chengming's patches? I can
> definitely do this, but the patch will be slightly less
> straightforward, and if the tree split patches break something it
> would be difficult to pull out as well. If you feel like this patch is
> more likely to break things, I can rebase.

Yeah I think it's more subtle. I'd only ask somebody to rebase an
already tested patch on a newer one if the latter were an obvious,
low-risk, prep-style patch. Your patch is good, but it doesn't quite
fit into this particular category, so I'd say no jumping the queue ;)

