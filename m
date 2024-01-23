Return-Path: <linux-kernel+bounces-36052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD0839ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D938F1F22006
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1265680;
	Tue, 23 Jan 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Vu5M4xAZ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38CA2905
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043770; cv=none; b=ZljZbJNK87I2uTI1NT9B3Iikf7pY4Wcd9lRv2WhF2lg2sOqaSk5wkAnPzswJOj6n/p9S5JxLMz/ezd9Y9WvKAQxx7iDmW24+1iwuep8pWZ5vvFt1lPNsTpJiPM4X4JmpUUclCqGU66PUGDz+GNTTQdE6xlvt9BrdngICjCPSMlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043770; c=relaxed/simple;
	bh=EsFzAGJ4S6mAvGc0aJMrviJ9tzA+5JnLU7RF1pgaPk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqd66JmQPYimG7sQUIwXlw2FQFNFm/+isyISy8UeErDm4mJSh5lT4IW9MRxtQ6eCp0h3s+1XTVI7VCrg706RagFeKaOrYbeDvQXz8//XOD5Uzd46Yyc/xkgaiHp2XntYASWZYMOVC8G0QyDfn5N5PjwqYqKodE/UARj06Jh8Rt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vu5M4xAZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a30799d6aa0so230535166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706043767; x=1706648567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjsQ/F9yGV71FP1Lt6gnrNyQE+7vVsFWBqMv4ElwWB0=;
        b=Vu5M4xAZqrEnyK2epB+5ZSpWohShe0D/kfhUSUM40XgcuhxCic+eRGGiBQcdauQwep
         U9RKctkChbpDbMH7QEYoJ2fuIFB/y8tLvLCwBhdGfupCrsSA9Ubo58lWFpn9Q0TaFlW2
         0T2Ihy1zwP7ny7eT+BncNPHKZNaPODPz9vs5LvRannCD5yOmOTkWIchjZTG5Qfaw41kD
         4yX8uAwDC0phT4q8Lf2kHJWnq+a2c+uks3CWxp0sh0DKH2BTr5qQkRqH6QrcKl8DxPRf
         VujO7xLKF+h7GDjGPo5azEHlc3i3ZExSGRS02Cp4H/JGlDA9h2tZW1TGqF6qsBA25JO+
         zeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706043767; x=1706648567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjsQ/F9yGV71FP1Lt6gnrNyQE+7vVsFWBqMv4ElwWB0=;
        b=fJXs4oZK6WpN8TAL1l3kfjYtQom46N4voIug83M+9MRGI7UIqR1Xy75DIW8t9L3LGO
         wmczmFhn5RIzbFzzfAvmNB50Arf/EpDSh7ZrHSuUA2ixNOyPtHvszUYzMoHPH4t09MNQ
         1D//WICfml+0AyBkSeN1UeaPY8Xy1PIlPwzD42Hq2TuqSKVKKatkPgM1tPrA8QiO+Jth
         kSSQ9J0zpHA7vEXSbwSp9JXCOo3dvhFCzdzNToJV0SoyL75ivMpax3w/xxBlNj6Jp5L2
         QsuJXbvadevfrqS3Ig2qGNx99CwhzGjs8w0YXeaoTPkqzEJkzTTRL3AbUaagsHDB9HSV
         Lnhg==
X-Gm-Message-State: AOJu0YzT+5kXFMQdlxnz8HzeF/SkxY+gdOzbVtp3WufDCLlPr2R07oYH
	4iu4gv5K8HmdbrVD+AHOtaOZ44nAmaBNe0J6bh7/Vbf1N2YpKWnPryBEcOlYVpKwjg8ko/4sBzS
	92sRRQC3jbJW6on4KXiOLZ0HuJUQ0CJ+VOTz9
X-Google-Smtp-Source: AGHT+IGPeJEGgA4gwneSIqzSjD3ji/NQrp7lLJa1aPwjVdMww/v1xJL9NN4OLnI7saN1wVNCbcM5Om/d8Dj7fndx3mw=
X-Received: by 2002:a17:906:198e:b0:a30:db53:5bb5 with SMTP id
 g14-20020a170906198e00b00a30db535bb5mr259332ejd.58.1706043766802; Tue, 23 Jan
 2024 13:02:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org> <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org>
In-Reply-To: <20240123201234.GC1745986@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 23 Jan 2024 13:02:10 -0800
Message-ID: <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:12=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Jan 23, 2024 at 07:54:49AM -0800, Yosry Ahmed wrote:
> > On Tue, Jan 23, 2024 at 7:38=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
org> wrote:
> > >
> > > On Mon, Jan 22, 2024 at 12:39:16PM -0800, Yosry Ahmed wrote:
> > > > On Mon, Jan 22, 2024 at 12:19=E2=80=AFPM Johannes Weiner <hannes@cm=
pxchg.org> wrote:
> > > > >
> > > > > On Sat, Jan 20, 2024 at 02:40:07AM +0000, Yosry Ahmed wrote:
> > > > > > During swapoff, try_to_unuse() makes sure that zswap_invalidate=
() is
> > > > > > called for all swap entries before zswap_swapoff() is called. T=
his means
> > > > > > that all zswap entries should already be removed from the tree.=
 Simplify
> > > > > > zswap_swapoff() by removing the tree cleanup loop, and leaving =
an
> > > > > > assertion in its place.
> > > > > >
> > > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > >
> > > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > >
> > > > > That's a great simplification.
> > > > >
> > > > > Removing the tree->lock made me double take, but at this point th=
e
> > > > > swapfile and its cache should be fully dead and I don't see how a=
ny of
> > > > > the zswap operations that take tree->lock could race at this poin=
t.
> > > >
> > > > It took me a while staring at the code to realize this loop is poin=
tless.
> > > >
> > > > However, while I have your attention on the swapoff path, there's a
> > > > slightly irrelevant problem that I think might be there, but I am n=
ot
> > > > sure.
> > > >
> > > > It looks to me like swapoff can race with writeback, and there may =
be
> > > > a chance of UAF for the zswap tree. For example, if zswap_swapoff()
> > > > races with shrink_memcg_cb(), I feel like we may free the tree as i=
t
> > > > is being used. For example if zswap_swapoff()->kfree(tree) happen
> > > > right before shrink_memcg_cb()->list_lru_isolate(l, item).
> > > >
> > > > Please tell me that I am being paranoid and that there is some
> > > > protection against zswap writeback racing with swapoff. It feels li=
ke
> > > > we are very careful with zswap entries refcounting, but not with th=
e
> > > > zswap tree itself.
> > >
> > > Hm, I don't see how.
> > >
> > > Writeback operates on entries from the LRU. By the time
> > > zswap_swapoff() is called, try_to_unuse() -> zswap_invalidate() shoul=
d
> > > will have emptied out the LRU and tree.
> > >
> > > Writeback could have gotten a refcount to the entry and dropped the
> > > tree->lock. But then it does __read_swap_cache_async(), and while
> > > holding the page lock checks the tree under lock once more; if that
> > > finds the entry valid, it means try_to_unuse() hasn't started on this
> > > page yet, and would be held up by the page lock/writeback state.
> >
> > Consider the following race:
> >
> > CPU 1                                 CPU 2
> > # In shrink_memcg_cb()     # In swap_off
> > list_lru_isolate()
> >                                             zswap_invalidate()
> >                                             ..
> >                                             zswap_swapoff() -> kfree(tr=
ee)
> > spin_lock(&tree->lock);
> >
> > Isn't this a UAF or am I missing something here?
>
> Oof. You're right, it looks like there is a bug. Digging through the
> history, I think this is actually quite old: the original backend
> shrinkers would pluck something off their LRU, drop all locks, then
> try to acquire tree->lock. There is no protection against swapoff.
>
> The lock that is supposed to protect this is the LRU lock. That's
> where reclaim and invalidation should synchronize. But it's not right:
>
> 1. We drop the LRU lock before acquiring the tree lock. We should
>    instead trylock the tree while still holding the LRU lock to make
>    sure the tree is safe against swapoff.
>
> 2. zswap_invalidate() acquires the LRU lock when refcount hits 0. But
>    it must always cycle the LRU lock before freeing the tree for that
>    synchronization to work.
>
> Once we're holding a refcount to the entry, it's safe to drop all
> locks for the next step because we'll then work against the swapcache
> and entry: __read_swap_cache_async() will try to pin and lock whatever
> swap entry is at that type+offset. This also pins the type's current
> tree. HOWEVER, if swapoff + swapon raced, this could be a different
> tree than what we had in @tree, so
>
> 3. we shouldn't pass @tree to zswap_writeback_entry(). It needs to
>    look up zswap_trees[] again after __read_swap_cache_async()
>    succeeded to validate the entry.
>
> Once it succeeded, we can validate the entry. The entry is valid due
> to our refcount. The zswap_trees[type] is valid due to the cache pin.
>
> However, if validation failed and we have a non-zero writeback_result,
> there is one last bug:
>
> 4. the original entry's tree is no longer valid for the entry put.
>
> The current scheme handles invalidation fine (which is good because
> that's quite common). But it's fundamentally unsynchronized against
> swapoff (which has probably gone undetected because that's rare).
>
> I can't think of an immediate solution to this, but I wanted to put my
> analysis out for comments.


Thanks for the great analysis, I missed the swapoff/swapon race myself :)

The first solution that came to mind for me was refcounting the zswap
tree with RCU with percpu-refcount, similar to how cgroup refs are
handled (init in zswap_swapon() and kill in zswap_swapoff()). I think
the percpu-refcount may be an overkill in terms of memory usage
though. I think we can still do our own refcounting with RCU, but it
may be more complicated.

