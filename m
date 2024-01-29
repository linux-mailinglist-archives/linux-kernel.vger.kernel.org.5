Return-Path: <linux-kernel+bounces-43107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D641B840BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4446D1F23C29
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F2215AAA2;
	Mon, 29 Jan 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+YZYA9S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456F15A4AB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545924; cv=none; b=uBPifmk2EnIFOg6k1RYI9+QjQhihQJ8RKf9rcUEeLSmXtKIJY6UEqxfjkrc1OS/Tu0n3Dnn5olJWZhj3bTYm6frBGUf4LOvcRSKZkg31Ih1eK14TjtFVgjwG/hZYrnQokHxzyKwryZYrU+bR7X7s5o+0GP8+/4+j+FAiNdK39kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545924; c=relaxed/simple;
	bh=/u1rFiHmhXAQAtlUXq7FgxQxSIB+dSj/HU6AwwQbRoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWL8xi3H11+V0Hoz0Nf4J1r/7JWMhrqF2BgsF35aYVPaqDjJUkbaobnMag+Ra7Z0ciQIRaUcDwTrDVUSqfrZDS9hbdIf2L8wkbfxKGnEDsnPv0riKJysbwP8MoAnJFKbi47LJormEbpNVkDa/uVM5vXxZBPyVt99iLhhheMu1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+YZYA9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FD4C4166B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706545923;
	bh=/u1rFiHmhXAQAtlUXq7FgxQxSIB+dSj/HU6AwwQbRoo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p+YZYA9S5HvYtpH/fWISTw5LLg6YC26CUaUE0OOkycY2NWeb4mIy88mZqtJ3zu2TA
	 CUpwtuAcyoVN25144BfjKst3mkyuVvnDA8ELm7vKAFrzBramuJCqNmRIupLIsrivd2
	 geGtoUhQzku9bIcOOwhNJN+srTO1fQyUOh+BcVTNpNbcBz6MB0QqnJnnC4jGeetD2g
	 Wie4q3thvfistpghwe9jY38naYjt0lob/XXbn5qr2OwB40a3CAeu0S/HRxRcCo4wDX
	 QnwcEq6FcIwOLHI4tx3LKCqZM/SIQ9VpKYbJbUomnYHU4Sdne44ItfBKJzV5dmXMCS
	 4v8lEFRTEDvyw==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3638b5f8240so313445ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:32:03 -0800 (PST)
X-Gm-Message-State: AOJu0Yz8kJydBcmd4YBuNVChyFvCuxpPA87ek50Mz9TcHYvk3LGWJu54
	xUQo6JZxhbhdroG1Hm24aLQenjoXE4DuceaInblNin2CXKBGFw60jKoEgP4y+ygMzgmPRU49DT0
	DQIdtQCUGawJEHjuDfTLuKyoT8y4jp1sJYuB6
X-Google-Smtp-Source: AGHT+IESDGAmy2d4K/fKQc27p+6fDI0mCGTCPnb2naFB86pPGb1OS+MLUkevgvtCdcIj3BNmBQogt+Hm5RAyE7VgE4c=
X-Received: by 2002:a92:a306:0:b0:360:73de:be5e with SMTP id
 a6-20020a92a306000000b0036073debe5emr4185014ili.14.1706545922962; Mon, 29 Jan
 2024 08:32:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-6-21cnbao@gmail.com> <58efd8d4-28aa-45d6-b384-7463568b24bb@redhat.com>
 <CAGsJ_4zwUpL7LihRBOefg-cmY2mgNjMm-MPkq9VFBdXS_4b=uQ@mail.gmail.com>
 <CAF8kJuNHrM+ZQSnTAOt6rrmGr1P=YS8eU+RSqhAc1CjQ7qdEwQ@mail.gmail.com> <c11d73d5-105e-4ae1-837a-b9da392d2dad@redhat.com>
In-Reply-To: <c11d73d5-105e-4ae1-837a-b9da392d2dad@redhat.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 29 Jan 2024 08:31:51 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMmh06rCXuiu5V0BiT8t1ckEEnY4rM-ivRBQ+xdyMhRKQ@mail.gmail.com>
Message-ID: <CAF8kJuMmh06rCXuiu5V0BiT8t1ckEEnY4rM-ivRBQ+xdyMhRKQ@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, ryan.roberts@arm.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Barry Song <v-songbaohua@oppo.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 2:07=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 29.01.24 04:25, Chris Li wrote:
> > Hi David and Barry,
> >
> > On Mon, Jan 22, 2024 at 10:49=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> >>
> >>>
> >>>
> >>> I have on my todo list to move all that !anon handling out of
> >>> folio_add_anon_rmap_ptes(), and instead make swapin code call add
> >>> folio_add_new_anon_rmap(), where we'll have to pass an exclusive flag
> >>> then (-> whole new folio exclusive).
> >>>
> >>> That's the cleaner approach.
> >>>
> >>
> >> one tricky thing is that sometimes it is hard to know who is the first
> >> one to add rmap and thus should
> >> call folio_add_new_anon_rmap.
> >> especially when we want to support swapin_readahead(), the one who
> >> allocated large filio might not
> >> be that one who firstly does rmap.
> >
> > I think Barry has a point. Two tasks might race to swap in the folio
> > then race to perform the rmap.
> > folio_add_new_anon_rmap() should only call a folio that is absolutely
> > "new", not shared. The sharing in swap cache disqualifies that
> > condition.
>
> We have to hold the folio lock. So only one task at a time might do the
> folio_add_anon_rmap_ptes() right now, and the
> folio_add_new_shared_anon_rmap() in the future [below].
>

Ah, I see. The folio_lock() is the answer I am looking for.

> Also observe how folio_add_anon_rmap_ptes() states that one must hold
> the page lock, because otherwise this would all be completely racy.
>
>  From the pte swp exclusive flags, we know for sure whether we are
> dealing with exclusive vs. shared. I think patch #6 does not properly
> check that all entries are actually the same in that regard (all
> exclusive vs all shared). That likely needs fixing.
>
> [I have converting per-page PageAnonExclusive flags to a single
> per-folio flag on my todo list. I suspect that we'll keep the
> per-swp-pte exlusive bits, but the question is rather what we can
> actually make work, because swap and migration just make it much more
> complicated. Anyhow, future work]
>
> >
> >> is it an acceptable way to do the below in do_swap_page?
> >> if (!folio_test_anon(folio))
> >>        folio_add_new_anon_rmap()
> >> else
> >>        folio_add_anon_rmap_ptes()
> >
> > I am curious to know the answer as well.
>
>
> Yes, the end code should likely be something like:
>
> /* ksm created a completely new copy */
> if (unlikely(folio !=3D swapcache && swapcache)) {
>         folio_add_new_anon_rmap(folio, vma, vmf->address);
>         folio_add_lru_vma(folio, vma);
> } else if (folio_test_anon(folio)) {
>         folio_add_anon_rmap_ptes(rmap_flags)
> } else {
>         folio_add_new_anon_rmap(rmap_flags)
> }
>
> Maybe we want to avoid teaching all existing folio_add_new_anon_rmap()
> callers about a new flag, and just have a new
> folio_add_new_shared_anon_rmap() instead. TBD.

There is more than one caller needed to perform that dance around
folio_test_anon() then decide which function to call. It would be nice
to have a wrapper function folio_add_new_shared_anon_rmap() to
abstract this behavior.


>
> >
> > BTW, that test might have a race as well. By the time the task got
> > !anon result, this result might get changed by another task. We need
> > to make sure in the caller context this race can't happen. Otherwise
> > we can't do the above safely.
> Again, folio lock. Observe the folio_lock_or_retry() call that covers
> our existing folio_add_new_anon_rmap/folio_add_anon_rmap_pte calls.

Ack. Thanks for the explanation.

Chris

