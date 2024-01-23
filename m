Return-Path: <linux-kernel+bounces-36009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0E1839A10
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA51C277CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4A282D99;
	Tue, 23 Jan 2024 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="nJKuqU3e"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601E260EE4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040764; cv=none; b=FOb/Qid4wimg0xCNSC3vpvhUYqSV9Hk561CbqOsuBPlhgBCOdE+AAo7RLg1Z6K3f1VsJieThEsy9UroF7NemKgYyDZUNJ76L/N7pKKqpyb8eXcDAT5tAV6J+lZ5myjeDdG4JaIKPRPv1PF/NPKAPptkVTCNsIk5oXQznlp+ViyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040764; c=relaxed/simple;
	bh=RhOsBONDInTHVMDMesY5uYaQKhwdN7vLZj/DsxcUXPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taUqid+BwelUJr/QRNWevlhxrUnjMN+DKFWucDPc0mCOSlxusNmNZu8Up/T6xcTT4tJt4+Zt2xvWJiNSz14QH/YKwRGa1PpmXgK6cgBrDs1sG79NkxiFqYIpw2LCVzLePvsyFk51uW7mnv/MH3m5yWcUQGG73oMrmPRESzH7mtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=nJKuqU3e; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dbbcb1aff8so3301948b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706040760; x=1706645560; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q24KVFfei+cia4T3WP6Kgi33KWd4bcIhvTEH02DjEqs=;
        b=nJKuqU3ee1OZYkEsPgkOnnPhLwt+U/aeJAkFMzUinLBDoOQQToGOejX5mwqVioOWah
         Dn4Q/FCG7yY1uuSPNeAu/aGz8pcvOyaNhkHCE3RHKGhMM1lbQoyGP0M6GuAWIxBMdQC4
         SjFAXKCZMPkxVBVLZEVEqW/WZ0a3mZr9mQhdTf1srdl5KLn4tAsu9+bqgQ09LMwvV2DD
         TvhOUisd9MH/xE8cidMX3Mxu0y0BSNwQ5Z1LLuFJY30/kZAmytj+J8F4ukkx0ivIoYfF
         3Hkz97vQf71KDY5et/NR8EqNWQ8FSCISWHvSGZkMmSt3N7ISUaubZ76g1cUOMKPn8tb3
         uh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706040760; x=1706645560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q24KVFfei+cia4T3WP6Kgi33KWd4bcIhvTEH02DjEqs=;
        b=DMGJHBjjekVzyLNKi5n7ee18+ZgSTrAgvUAnSrfCvTK0TklfoUN7pWs0ar/q9DaXqz
         t+2i9Pii8rAclHWMIqE2dSXKtkx1XAis2eGaH8zkHqGlE3Kz4Napbu99zi7PXNqB3PhM
         wm/2OHdgw5nM2eIffmIVNhxl90N1o6khPreDY21aOs1jJgBjB5F9TfIcQ1LYFtNaP1c2
         hjuaPlCunAidq9yfSHwl5WLF3a1dOQgKHW0oo8Wpe/nUZg4lZL7rGRdzSXWG6vpynGUX
         l5Uq8bOomNLAh8dlSmOL+drcuxxPacHfJa8r0Ktv14z7fX0lD6q64gPOdF1fnm2JVhdA
         57BA==
X-Gm-Message-State: AOJu0Yz4MomfeHGITHmqK3jmc8mLb6Hs+lTTJp2aP472GAhJF4jO09JW
	rjNP1lFkfNYbkx1jbOYnmH3qj5fJWLBHd1UMhHsRQZ+xMQaVActlAvlBSHfzL04=
X-Google-Smtp-Source: AGHT+IEcQiYu55Hik8wDlo7Ps+NIXOV8U19eTqLxlMvYghAEPGspeoISpv6RbsjOhufVhuWEsZ5o0g==
X-Received: by 2002:a05:6a20:28a3:b0:19a:3d26:d40f with SMTP id q35-20020a056a2028a300b0019a3d26d40fmr3266995pzf.39.1706040760622;
        Tue, 23 Jan 2024 12:12:40 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:e07e])
        by smtp.gmail.com with ESMTPSA id x126-20020a626384000000b006dbd7e5bd1esm5508869pfb.52.2024.01.23.12.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:12:40 -0800 (PST)
Date: Tue, 23 Jan 2024 15:12:34 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in
 zswap_swapoff()
Message-ID: <20240123201234.GC1745986@cmpxchg.org>
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com>
 <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org>
 <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>

On Tue, Jan 23, 2024 at 07:54:49AM -0800, Yosry Ahmed wrote:
> On Tue, Jan 23, 2024 at 7:38 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Jan 22, 2024 at 12:39:16PM -0800, Yosry Ahmed wrote:
> > > On Mon, Jan 22, 2024 at 12:19 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Sat, Jan 20, 2024 at 02:40:07AM +0000, Yosry Ahmed wrote:
> > > > > During swapoff, try_to_unuse() makes sure that zswap_invalidate() is
> > > > > called for all swap entries before zswap_swapoff() is called. This means
> > > > > that all zswap entries should already be removed from the tree. Simplify
> > > > > zswap_swapoff() by removing the tree cleanup loop, and leaving an
> > > > > assertion in its place.
> > > > >
> > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > >
> > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > >
> > > > That's a great simplification.
> > > >
> > > > Removing the tree->lock made me double take, but at this point the
> > > > swapfile and its cache should be fully dead and I don't see how any of
> > > > the zswap operations that take tree->lock could race at this point.
> > >
> > > It took me a while staring at the code to realize this loop is pointless.
> > >
> > > However, while I have your attention on the swapoff path, there's a
> > > slightly irrelevant problem that I think might be there, but I am not
> > > sure.
> > >
> > > It looks to me like swapoff can race with writeback, and there may be
> > > a chance of UAF for the zswap tree. For example, if zswap_swapoff()
> > > races with shrink_memcg_cb(), I feel like we may free the tree as it
> > > is being used. For example if zswap_swapoff()->kfree(tree) happen
> > > right before shrink_memcg_cb()->list_lru_isolate(l, item).
> > >
> > > Please tell me that I am being paranoid and that there is some
> > > protection against zswap writeback racing with swapoff. It feels like
> > > we are very careful with zswap entries refcounting, but not with the
> > > zswap tree itself.
> >
> > Hm, I don't see how.
> >
> > Writeback operates on entries from the LRU. By the time
> > zswap_swapoff() is called, try_to_unuse() -> zswap_invalidate() should
> > will have emptied out the LRU and tree.
> >
> > Writeback could have gotten a refcount to the entry and dropped the
> > tree->lock. But then it does __read_swap_cache_async(), and while
> > holding the page lock checks the tree under lock once more; if that
> > finds the entry valid, it means try_to_unuse() hasn't started on this
> > page yet, and would be held up by the page lock/writeback state.
> 
> Consider the following race:
> 
> CPU 1                                 CPU 2
> # In shrink_memcg_cb()     # In swap_off
> list_lru_isolate()
>                                             zswap_invalidate()
>                                             ..
>                                             zswap_swapoff() -> kfree(tree)
> spin_lock(&tree->lock);
> 
> Isn't this a UAF or am I missing something here?

Oof. You're right, it looks like there is a bug. Digging through the
history, I think this is actually quite old: the original backend
shrinkers would pluck something off their LRU, drop all locks, then
try to acquire tree->lock. There is no protection against swapoff.

The lock that is supposed to protect this is the LRU lock. That's
where reclaim and invalidation should synchronize. But it's not right:

1. We drop the LRU lock before acquiring the tree lock. We should
   instead trylock the tree while still holding the LRU lock to make
   sure the tree is safe against swapoff.

2. zswap_invalidate() acquires the LRU lock when refcount hits 0. But
   it must always cycle the LRU lock before freeing the tree for that
   synchronization to work.

Once we're holding a refcount to the entry, it's safe to drop all
locks for the next step because we'll then work against the swapcache
and entry: __read_swap_cache_async() will try to pin and lock whatever
swap entry is at that type+offset. This also pins the type's current
tree. HOWEVER, if swapoff + swapon raced, this could be a different
tree than what we had in @tree, so

3. we shouldn't pass @tree to zswap_writeback_entry(). It needs to
   look up zswap_trees[] again after __read_swap_cache_async()
   succeeded to validate the entry.

Once it succeeded, we can validate the entry. The entry is valid due
to our refcount. The zswap_trees[type] is valid due to the cache pin.

However, if validation failed and we have a non-zero writeback_result,
there is one last bug:

4. the original entry's tree is no longer valid for the entry put.

The current scheme handles invalidation fine (which is good because
that's quite common). But it's fundamentally unsynchronized against
swapoff (which has probably gone undetected because that's rare).

I can't think of an immediate solution to this, but I wanted to put my
analysis out for comments.

