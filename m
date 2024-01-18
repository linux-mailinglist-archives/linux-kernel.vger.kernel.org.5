Return-Path: <linux-kernel+bounces-30456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA52831EEF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4671F23571
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0F92D612;
	Thu, 18 Jan 2024 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Jj3QDk2p"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D62C842
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601225; cv=none; b=INR2HXaTz040rPN64LXrK65YzSkZRvdu1gVLBkXKdrUGTYq90XkvWSq19R6e3tpULhI5mHjX65MK+qtR96XPRWfET4sk/w4d3CO2dUxHt7GI2woV24r69TLhq6qyttbyLLzzkpLgfNty6kU1vJwELcT39I8O8jqp1DIW57dJI+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601225; c=relaxed/simple;
	bh=wYMUz7M82CRmVJYjs+F0MvYTs7b94mlZN8ahcx/N++k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEDSWTpd0qUB/izeBMlMAe+f9lODMoyd4xnzFY/SyphNZEM1NWztgqZeECICEwSgJpwZleQdCHr9e3yIlCfkMnH2pIWHWI6sqsvq9jcO+UzuIw3JBJuGDygsiC04oO23JTHN6WYPhqQhsU2NJeU3VSU/Ak76/5k/z/vvSdjnHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Jj3QDk2p; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7831e87ba13so1070006085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 10:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705601221; x=1706206021; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g17qqdCkc/4dLWzvWkxlImPJQBvAa5kSq+wGioXKCYI=;
        b=Jj3QDk2pa5gxjb9BVymaCbw+koj7V07v2QOT7OVlFnfQMsE9pXiOtt1dkUfVu60eAx
         h4z7lrBMx/I2XH7z/dydmmhZHO2pskU7kaFiTUmfmv+IqzdT0nvoFGJk1DqvwhRA3VfC
         qiLgECyE72cxEUmdglSOU6OcSchjQxVWMvYAJEL6y1psseZ/8J74bhh6JkNghihYHYrB
         JVWJ0oDxE7e+HsuJfCT+V1mWLnhYXRUHh0ZeRPnc7NNUIaeKF49JloDUWB2OjKPFWUr0
         URdJTjuaUAmHAR7lu5W/jvKuwycIefGeqX2hX+b4zzD6AZvDCwm/JBR6bFoKroQPLYyG
         uqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601221; x=1706206021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g17qqdCkc/4dLWzvWkxlImPJQBvAa5kSq+wGioXKCYI=;
        b=CmLfwl5j0oPSKlpKi8A0g/LyUMlxHJvHwMWA336Lok9A7m7Nm8Kl3FiVV9u0odaJpN
         EWiWyJU4jfXbUu/hrKkG+pOCCegQww+fkXCV2SejmGft+aB4aTZZpHHmDGPec7eOsmVW
         F98fqs4xVB27NSp5pzomK5r9Df3dnK8F0nqQdSDxcEV84sfs0G03eFk2TuC9MGHonC5/
         nCSerfhti8WkEu9zTZBDLeNaHf1xdn0nXcQYHawBjyS9WqdAsUzCN8hwqt3sGyHHi3bd
         xjGsQZhsd9baJMFkEXj0yjqjgXAhdUdU6a/Lm2+BD0d8Hmdo/XIP3/LXrbXeE6gnnBrP
         S1Qg==
X-Gm-Message-State: AOJu0Ywwihcy2Un2Xj7Anp8KVvMVpejoDk+RgeiLZdKCUANIwxOPES/Y
	iyU8sxrCpG1OKz5Z7C02+GrpMcko6g5nl9wdCOItI7may/B08s/QsrBpID0/EMFBPiTuc/TDNj2
	W
X-Google-Smtp-Source: AGHT+IGh8foTcnko5oTEcDKBL65oF+epxyQdhBOJToNTcir/tYgwy2wIme/dSH+bt3bWZKQNx34XNg==
X-Received: by 2002:a05:620a:1127:b0:783:4eb:1bd0 with SMTP id p7-20020a05620a112700b0078304eb1bd0mr51075qkk.0.1705601220815;
        Thu, 18 Jan 2024 10:07:00 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:1f5c])
        by smtp.gmail.com with ESMTPSA id c10-20020a37e10a000000b0078337726eefsm5428137qkm.6.2024.01.18.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:07:00 -0800 (PST)
Date: Thu, 18 Jan 2024 13:06:55 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Chris Li <chriscli@google.com>, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
Message-ID: <20240118180655.GM939255@cmpxchg.org>
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <CAJD7tkY7Xvjg37EEw2M=uRknphY0pf3ZVpyX2s2QyiJ=Axhihw@mail.gmail.com>
 <20240118153425.GI939255@cmpxchg.org>
 <CAJD7tkY48=2-4_iG6c-FcbzT3EBriem2spOFTTpGMfqmOmsx2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkY48=2-4_iG6c-FcbzT3EBriem2spOFTTpGMfqmOmsx2Q@mail.gmail.com>

On Thu, Jan 18, 2024 at 09:30:12AM -0800, Yosry Ahmed wrote:
> On Thu, Jan 18, 2024 at 7:34 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Jan 17, 2024 at 10:37:22AM -0800, Yosry Ahmed wrote:
> > > On Wed, Jan 17, 2024 at 1:23 AM Chengming Zhou
> > > <zhouchengming@bytedance.com> wrote:
> > > >
> > > > When testing the zswap performance by using kernel build -j32 in a tmpfs
> > > > directory, I found the scalability of zswap rb-tree is not good, which
> > > > is protected by the only spinlock. That would cause heavy lock contention
> > > > if multiple tasks zswap_store/load concurrently.
> > > >
> > > > So a simple solution is to split the only one zswap rb-tree into multiple
> > > > rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea is
> > > > from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").
> > > >
> > > > Although this method can't solve the spinlock contention completely, it
> > > > can mitigate much of that contention. Below is the results of kernel build
> > > > in tmpfs with zswap shrinker enabled:
> > > >
> > > >      linux-next  zswap-lock-optimize
> > > > real 1m9.181s    1m3.820s
> > > > user 17m44.036s  17m40.100s
> > > > sys  7m37.297s   4m54.622s
> > > >
> > > > So there are clearly improvements. And it's complementary with the ongoing
> > > > zswap xarray conversion by Chris. Anyway, I think we can also merge this
> > > > first, it's complementary IMHO. So I just refresh and resend this for
> > > > further discussion.
> > >
> > > The reason why I think we should wait for the xarray patch(es) is
> > > there is a chance we may see less improvements from splitting the tree
> > > if it was an xarray. If we merge this series first, there is no way to
> > > know.
> >
> > I mentioned this before, but I disagree quite strongly with this
> > general sentiment.
> >
> > Chengming's patches are simple, mature, and have convincing
> > numbers. IMO it's poor form to hold something like that for "let's see
> > how our other experiment works out". The only exception would be if we
> > all agree that the earlier change flies in the face of the overall
> > direction we want to pursue, which I don't think is the case here.
> 
> My intention was not to delay merging these patches until the xarray
> patches are merged in. It was only to wait until the xarray patches
> are *posted*, so that we can redo the testing on top of them and
> verify that the gains are still there. That should have been around
> now, but the xarray patches were posted in a form that does not allow
> this testing (because we still have a lock on the read path), so I am
> less inclined.
> 
> My rationale was that if the gains from splitting the tree become
> minimal after we switch to an xarray, we won't know. It's more
> difficult to remove optimizations than to add them, because we may
> cause a regression. I am kind of paranoid about having code sitting
> around that we don't have full information about how much it's needed.

Yeah I understand that fear.

I expect the splitting to help more than the move to xarray because
it's the writes that are hot. Luckily in this case it should be fairly
easy to differential-test after it's been merged by changing that tree
lookup macro/function locally to always return &trees[type][0], right?

> In this case, I suppose we can redo the testing (1 tree vs. split
> trees) once the xarray patches are in a testable form, and before we
> have formed any strong dependencies on the split trees (we have time
> until v6.9 is released, I assume).
> 
> How about that?

That sounds reasonable.

> > With the xarray we'll still have a per-swapfile lock for writes. That
> > lock is the reason SWAP_ADDRESS_SPACE segmentation was introduced for
> > the swapcache in the first place. Lockless reads help of course, but
> > read-only access to swap are in the minority - stores will write, and
> > loads are commonly followed by invalidations. Somebody already went
> > through the trouble of proving that xarrays + segmentation are worth
> > it for swap load and store access patterns. Why dismiss that?
> 
> Fair point, although I think the swapcache lock may be more contended
> than the zswap tree lock.

Right, it has two updates for each transition, compared to the one for
zswap. But we know that in a concurrent system under pressure a
globally shared swap lock will hurt. There is a history in Chengming's
numbers, your previous patch to split the zpools,
235b62176712b970c815923e36b9a9cc05d4d901 etc.

> > So my vote is that we follow the ususal upstreaming process here:
> > merge the ready patches now, and rebase future work on top of it.
> 
> No objections given the current state of the xarray patches as I
> mentioned earlier, but I prefer we redo the testing once possible with
> the xarray.

Cool, sounds good to me.

