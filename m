Return-Path: <linux-kernel+bounces-35601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD098393DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619D71C23C55
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E95360B9C;
	Tue, 23 Jan 2024 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pbe+Hm45"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EAE60ECC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025331; cv=none; b=WLt5MLEYFo+Hbms+QwtZB7zbas1Fc1IYQam3DIEpcSdaDht8UMqDth8e6jLVZsKDgxNlx/d0ZAxgAbnejUgFltBN8ypNEMCmW7JBIQ0iM/EVHnUbg1ju/j5vDt0wKvJ2PF0ELHC0Uy7BlKUjIMQ52oO6zK2He588Wgw4a13I8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025331; c=relaxed/simple;
	bh=/Q0U9VdRTRhpqt0YxLQnrGFmXcEGuGAozA/KjhGotiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8Y5mwoIzpbOJVR7EeTAQajJjYY1C7FNo93j71KobALjz9kdZwLb4FFI6lp67xuBA0mvxsgHiHZ8sgbS3GxCmrsZvG8p7HIK2kssbmLWDovtkdFQeh4rGCjNvwKDCLbUkU5y2bb2jZspac28PXiOE8ZWvaSg986aR6HEpL4G5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pbe+Hm45; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so418599466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706025328; x=1706630128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpTrcf8Pjdlxs3p3QQII3oZRaQKfL8NQPq9NL8TsssI=;
        b=Pbe+Hm45fx+gKrnsKUiAJoV7gG8anPTibUjIY3CoJWj3TSrG5K492C3HIr4CVxAraa
         CrXA3fIYxhxZ0xzZrkJvVLSer5z0Sho8NmL/hgQ55rBlQbCoJyUL62xhoxHi2Sh9hx2S
         ygJ+9wxNKThGdEIjZVfhNuXmiWs4OkNZfxokrmIU3lElPalCGWPtkXKfmd2GDCTuk4kj
         SZnXZfWcE0nUw57783zCx/ZTBsDdoUvJV/G7pBBS+mF6aOkYos+rlI6OwidNE2AN5ETd
         YSeaTVG18JaLyaVY/7KkQAjlc4xb18Hs/R26KTUkFOkggUuDTGtdXvdga1HxBzKDn9Yp
         7LGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025328; x=1706630128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpTrcf8Pjdlxs3p3QQII3oZRaQKfL8NQPq9NL8TsssI=;
        b=cGzllOQt0DX12iLyZZnCCPKK9XiIzZLivEMogiSwie0kugbi8MEp6OvMwwy6GYHxyC
         oTo2PV7JsiQkFNvSwINpv+6oNp2+GwZMFfReC4/ZBzPknkbFGRaRAEUHj0FzD5O/sUwM
         gOAJFsUb2Jdtcl2bFMSgvD/jBtxyJMgH6bJYUpezo6DoQ20rV00zetRaDXvwm7auzbtE
         hC/74Pm+jrXbsZBCoJsgzX9AkIGsAFkEOBURyR5LbIJXhuv9YDEpJlc2h6Qg4kD3pIDs
         bVjZo2P4qOZ8Ah7+IaODOd+NNwye88IHA9uzkb62RY8nTFl6LYrmoZiyLEQ1366M6jAb
         zH2Q==
X-Gm-Message-State: AOJu0YyU/lLFH3O7n/i+x9/KdfByAKO30GHG4hicuBOMmVE1sUxqctEY
	2a5gZhAp1qyfngJA+uJKkIl2K1j4WZ/sGAmT0yaDu7jlEBsUfi3FgI8xCfdYxOZS5rsDGv7J35B
	lRAiMYboCIhp2S6CVsTiP2ZJ2d4rgvlexdXC20WUcODbgc0xu4X93Pqs=
X-Google-Smtp-Source: AGHT+IGk8v5B/HHFrp+7GSfwtJ8LCHem3Bf/VDYildiIzU95CdyFbAZ5Ll7ejvV4C4yLz+NGKv0w+myj7Ph4E6QOLCA=
X-Received: by 2002:a17:906:46d7:b0:a2e:cac9:97ca with SMTP id
 k23-20020a17090646d700b00a2ecac997camr37174ejs.85.1706025327705; Tue, 23 Jan
 2024 07:55:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com> <20240123153851.GA1745986@cmpxchg.org>
In-Reply-To: <20240123153851.GA1745986@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 23 Jan 2024 07:54:49 -0800
Message-ID: <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 7:38=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Jan 22, 2024 at 12:39:16PM -0800, Yosry Ahmed wrote:
> > On Mon, Jan 22, 2024 at 12:19=E2=80=AFPM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > > On Sat, Jan 20, 2024 at 02:40:07AM +0000, Yosry Ahmed wrote:
> > > > During swapoff, try_to_unuse() makes sure that zswap_invalidate() i=
s
> > > > called for all swap entries before zswap_swapoff() is called. This =
means
> > > > that all zswap entries should already be removed from the tree. Sim=
plify
> > > > zswap_swapoff() by removing the tree cleanup loop, and leaving an
> > > > assertion in its place.
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > >
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > > That's a great simplification.
> > >
> > > Removing the tree->lock made me double take, but at this point the
> > > swapfile and its cache should be fully dead and I don't see how any o=
f
> > > the zswap operations that take tree->lock could race at this point.
> >
> > It took me a while staring at the code to realize this loop is pointles=
s.
> >
> > However, while I have your attention on the swapoff path, there's a
> > slightly irrelevant problem that I think might be there, but I am not
> > sure.
> >
> > It looks to me like swapoff can race with writeback, and there may be
> > a chance of UAF for the zswap tree. For example, if zswap_swapoff()
> > races with shrink_memcg_cb(), I feel like we may free the tree as it
> > is being used. For example if zswap_swapoff()->kfree(tree) happen
> > right before shrink_memcg_cb()->list_lru_isolate(l, item).
> >
> > Please tell me that I am being paranoid and that there is some
> > protection against zswap writeback racing with swapoff. It feels like
> > we are very careful with zswap entries refcounting, but not with the
> > zswap tree itself.
>
> Hm, I don't see how.
>
> Writeback operates on entries from the LRU. By the time
> zswap_swapoff() is called, try_to_unuse() -> zswap_invalidate() should
> will have emptied out the LRU and tree.
>
> Writeback could have gotten a refcount to the entry and dropped the
> tree->lock. But then it does __read_swap_cache_async(), and while
> holding the page lock checks the tree under lock once more; if that
> finds the entry valid, it means try_to_unuse() hasn't started on this
> page yet, and would be held up by the page lock/writeback state.

Consider the following race:

CPU 1                                 CPU 2
# In shrink_memcg_cb()     # In swap_off
list_lru_isolate()
                                            zswap_invalidate()
                                            ..
                                            zswap_swapoff() -> kfree(tree)
spin_lock(&tree->lock);

Isn't this a UAF or am I missing something here?

>
> > > > Chengming, Chris, I think this should make the tree split and the x=
array
> > > > conversion patches simpler (especially the former). If others agree=
,
> > > > both changes can be rebased on top of this.
> > >
> > > The resulting code is definitely simpler, but this patch is not a
> > > completely trivial cleanup, either. If you put it before Chengming's
> > > patch and it breaks something, it would be difficult to pull out
> > > without affecting the tree split.
> >
> > Are you suggesting I rebase this on top of Chengming's patches? I can
> > definitely do this, but the patch will be slightly less
> > straightforward, and if the tree split patches break something it
> > would be difficult to pull out as well. If you feel like this patch is
> > more likely to break things, I can rebase.
>
> Yeah I think it's more subtle. I'd only ask somebody to rebase an
> already tested patch on a newer one if the latter were an obvious,
> low-risk, prep-style patch. Your patch is good, but it doesn't quite
> fit into this particular category, so I'd say no jumping the queue ;)

My intention was to reduce the diff in both this patch and the tree
split patches, but I do understand this is more subtle. I can rebase
on top of Chengming's patches instead.

