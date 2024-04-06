Return-Path: <linux-kernel+bounces-134104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2A89ADAB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 01:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367AB1F213D9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 23:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32357898;
	Sat,  6 Apr 2024 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqXwO1k8"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9E4E1BC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712446060; cv=none; b=e40IBiwwa8216c4xg7tDaTSxOL7nElJsJsllEjZdBKYMofLaVWnubKfOZK1LypSu79pzXOTyjroiGvXQyTDmDR9o3FydjS36CD2/CjaV/RhVNaYYZqRkMRX2bOtHMkwqXD6pf6CDA2OGJ7AHg51LHDY7qum/396PLcbuHop3d+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712446060; c=relaxed/simple;
	bh=Xtm39dWe1YLp3fM5IxDaIhe8okZRszM16/CKvxw1RfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QW6ZB9z439mwUMc2wWAiU/pMs6SZlcm3t4dYFg9Fn64Gaghli2T9TiqvqnFVMtgUJaAyYDdNiyfO1qAaF8pwRVEmMSU14Q+5rEpcxXjM0uTfjED8ugQXkww0LqIbbUVqIH/KRNd0wgIrFBl2uttfWG91255WBTphZaBYMEUauM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqXwO1k8; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5aa28cde736so98625eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 16:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712446057; x=1713050857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnH1kiwnCu7HwnCtgNx74KGATsGuzGIwPT6aRu5nxgY=;
        b=hqXwO1k8uOcCS0BcPDeaR1XjdoHiugBOG7wHp42B47mjSq+tqyCwWC6ffpxawmYlW0
         HUkJl2H9HsWoVAwMc7b4TgDzV1bMmV9HJLJaM++QS9SiPGfeRqcIhYbz0U0OeuNIdBkF
         LU3Ew2TdHhMKvOl38t2LGXQN/+qHP4XQp6bZ13gYz5RPT3VtoM2nCHCWEQC5bKLheYhW
         ZJMGehPdv3MG/GAdoLMuqDlRUmzP/ebBMr9Fv+KVeUyFnn+otHN6cITDmfPkEu//eVyn
         X9VI3pSqWuKVXPECy0jVGMS83wbh+EFhx7GR0tKo53aPiGbqDKBOaMq66o+bNmoetDln
         rKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712446057; x=1713050857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnH1kiwnCu7HwnCtgNx74KGATsGuzGIwPT6aRu5nxgY=;
        b=G8BIhdIRE5t9Z8xvA2iIb5tohZ9z86z51a3ntf5CcwuKfqMwJmP1UQNasCKVN70rjM
         bkGDb3KnN2w9sq3jbERT2upnrxWwROYgdZ1MnZRQfqMMgLSwe/Injt9aq5UDloD9arA5
         RNE3v7/vQUdTD8xFWuZOzBSxjKXuBd/flZLQeZyBR1wFj2mylamMupkIT5HTE3tvZtbK
         yaPGf5YS/RECyZU6CYsx3ZZmidLHjq1ryRwirkVoJajzuuQS9OAA+qITPK9zBoPN8pBt
         DxZQZS1gAW9p1r1PdldDqjjYm/LhVtSAILUUVycj9DcWFYc+JvacCzPzDTU7GpUjFvCn
         IbNg==
X-Forwarded-Encrypted: i=1; AJvYcCXFGWIM0i6LX0ELv5fdE4sr9gif1zxOUgLd9sc+41zG9ABItuuAS+KGBaZKNIjVZLrozVHcFWyaOS/dFp6K9OSgcpfBBasaqv3vpGGv
X-Gm-Message-State: AOJu0YwTrRUtDk+gwCtklx0hRlH084sGAUwUX7yOk6qtj8koswYIyN+L
	McPOiXRpt7vqcPmTL5HHZOx3lOLarbrG4Q3FSeSVzg3ErT/pWmcp1B6HSKHf0yIvxAU040on6Br
	PjC4YyhMVwgJvI4WzgCzG7n/TzCI=
X-Google-Smtp-Source: AGHT+IF174D7jDPyoJ2fAHftQW7Ge4KNMxdqgGqHD7s8pAgQLxbgZgbSewX8OUdaesaCSaQHpeZZFyu4+7pLvOhRJGQ=
X-Received: by 2002:a05:6358:d588:b0:186:1652:7c9c with SMTP id
 ms8-20020a056358d58800b0018616527c9cmr1422339rwb.31.1712446057451; Sat, 06
 Apr 2024 16:27:37 -0700 (PDT)
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
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 7 Apr 2024 11:27:26 +1200
Message-ID: <CAGsJ_4xKTj1PwmJAAZAzAvEN53kze5wSPHb01pVg9LBy80axGA@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
To: David Hildenbrand <david@redhat.com>
Cc: Chris Li <chrisl@kernel.org>, ryan.roberts@arm.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Barry Song <v-songbaohua@oppo.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:07=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
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

right.

We need to clarify that the new anon_folio might not necessarily be exclusi=
ve.
Unlike folio_add_new_anon_rmap, which assumes the new folio is exclusive,
folio_add_anon_rmap_ptes is capable of handling both exclusive and
non-exclusive new anon folios.

The code would be like:

 if (unlikely(folio !=3D swapcache && swapcache)) {
         folio_add_new_anon_rmap(folio, vma, vmf->address);
         folio_add_lru_vma(folio, vma);
 } else if (!folio_test_anon(folio)) {
         folio_add_anon_rmap_ptes(rmap_flags);
 } else {
         if (exclusive)
                 folio_add_new_anon_rmap();
         else
                 folio_add_new_shared_anon_rmap();
 }

It appears a bit lengthy?

>
> >
> > BTW, that test might have a race as well. By the time the task got
> > !anon result, this result might get changed by another task. We need
> > to make sure in the caller context this race can't happen. Otherwise
> > we can't do the above safely.
> Again, folio lock. Observe the folio_lock_or_retry() call that covers
> our existing folio_add_new_anon_rmap/folio_add_anon_rmap_pte calls.
>
> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

