Return-Path: <linux-kernel+bounces-36057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54246839AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED94B25D63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9CC2C1B0;
	Tue, 23 Jan 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="aVeU24on"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0231A27A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043895; cv=none; b=Sod9D7mFhvUYId+anks743y2whj5ctVvt0EDFp/XaUv3zQXojuH+XY2VVYoC2kBM1oa2EKED95JxWBbRkF8Gki6/pPU5uectwCw5/ZqGS01UenLRMbZvSN+tuanCD74yVVWyhhvuz+Nm8AQtuFdim4gxoaSwR1327dr8/mOHpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043895; c=relaxed/simple;
	bh=3yre6/GfV9EsV09fKOVH0VSEsL+ZNHD1GahVnqq2AwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdL9rV/DPwrrDII8kQyDz3BW6sxU9AOXA9crTqSDTvgJcxki6oWs1QPgiUOFdvVwpbIfoDP+dWB6roqkUKE1M5G4yLs+npO1jITAe+T6Fm8SaUkv/LCFDdPCsYCQllDezlXBOidaW0a2hxsvZhQBkGzYHG2sAr52Ijj4qDg1ePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVeU24on; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2e0be86878so1080001266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706043892; x=1706648692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH6Q8mXoj5QFsHrSFXa0Fq0YxBOnIiyggYtErbKhYfQ=;
        b=aVeU24onZvsdFYw4lTggVfuGXyiZ+TCZXXvh8FBb1jIohNLRD+1Z4+gt8VUaD35LtE
         ChZc8IJrmu+CqZ87tZBf/DV8mcbuasXe0gXcby5RI+QfkyYQbASvL3FruOR/vvH/WSBk
         SGntHE/VwpgRgJ2Oh580Pu0T0Ey9/KGTT1OH+nCfBDwaNPeu1+ax85EyBEG4SWQVbRi2
         GjdcpjhQifPcpcGrHutWxC/hs3tTOGX1xBw6fDIkv2j6mYRK5HIfyA3fVdDOXw+FSTP4
         O8oEzMVzev16QDatW8aW1EA5L9mHQa4lYWsS/A6Bv5CYFASRluVf6Co3/qdU4MyW09eJ
         2NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706043892; x=1706648692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mH6Q8mXoj5QFsHrSFXa0Fq0YxBOnIiyggYtErbKhYfQ=;
        b=SYsyuo9+3LFgmF26h1oj3hFfqFt5gZqzkwsSAICYjgKXTawoZVbPBY78NPvr226lPG
         FqaGErMut16lhNbokMLUrIX4QWqJDqq+RL7EVW4eacw7uDwW6TpoI2EWFRANSVK+zJH8
         u8Ri+wTHd55McOgDd95x7/xw45M13Kufx24jnwOBC+1GEHNqdNRCt/LVWM8PXiziS+RG
         IQaiJ1K2Ga+6pNTmp86oX/H8Gj4xeO8nQ/MpqYXN+n+3nKEU4Db/fDKkbMOh/K7ZVNDU
         QZMsiemk+gE9Ae59u5UURuGKCKEX3QtxmOdX42DUn1rC5ZWnCPTLark7kpog5rAih/Qm
         wv2Q==
X-Gm-Message-State: AOJu0YwzDAvNFYU8nknmcVRpIkN4rL0j7GI53nA/RhJQ7JwP5rR/OdQg
	GxW/ljy4ScIDozroiwQ2qdWwRITFZJwZo4oG4nqyyJ9sZYMi1rEb0QYjoOXAbxJ9N6CRaTvxMPP
	juNx8vOaFUtnkPf42fBtNjmqv48aRh7x2oN1W
X-Google-Smtp-Source: AGHT+IEO8kzTGXcdOGqKIS/vbQryVHEh7kUyOxjZhCV3nLSsBO7SzKGk+BAwskEyqe16MD7245agZ71nqKBKsUlPjR4=
X-Received: by 2002:a17:906:2a02:b0:a30:428c:b1b8 with SMTP id
 j2-20020a1709062a0200b00a30428cb1b8mr167644eje.42.1706043891672; Tue, 23 Jan
 2024 13:04:51 -0800 (PST)
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
 <CAKEwX=OcyTXrLNYoBAJkWv0iUi5o6h1=bx1qaCH2CodWctc0Tw@mail.gmail.com>
In-Reply-To: <CAKEwX=OcyTXrLNYoBAJkWv0iUi5o6h1=bx1qaCH2CodWctc0Tw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 23 Jan 2024 13:04:15 -0800
Message-ID: <CAJD7tkaizXg6CMzwwYnyGHD8oHjfyKBS-owjDsCvpNVgXc4PNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Nhat Pham <nphamcs@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:30=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Jan 23, 2024 at 7:55=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
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
> I need to read this code closer. But this smells like a race to me as wel=
l.
>
> Long term speaking, I think decoupling swap and zswap will fix this,
> no? We won't need to kfree(tree) inside swapoff. IOW, if we have a
> single zswap tree that is not tied down to any swapfile, then we can't
> have this race. There might be other races introduced by the
> decoupling that I might have not foreseen tho :)

Ideally yes, it should make the zswap <-> swapfile interaction more
straightforward. Ideally in that world, writeback is handled in the
swap core and is just moving an entry from one backend to another, so
synchronization with things like swapoff should be easier. Also, I
think in that world we don't need a zswap tree to begin with, there's
a global tree(s) that maps a swap index directly to a swapfile swap
entry or a zswap entry.

>
> Short term, no clue hmm. Let me think a bit more about this.

See my response to Johannes, I think we may be able to fix this with
refcounting + RCU.

