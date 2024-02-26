Return-Path: <linux-kernel+bounces-80560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5320586697E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB6B1C20BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20461B7E1;
	Mon, 26 Feb 2024 05:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cfc/o67r"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B463DF51
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708923957; cv=none; b=tHG2gx304R95zlJwwEcdZtcc1kC4H4H0Exz52nXIFyqxawILMj5ucOl1N+u0icfMPXQtbUQlOxbSVmELwoFnoBHMUC2uxeaCcK0gzcMIRCjVR6CT2TQ5h/Z48LPkISe8vK4GuCPzXoNAQjqO0Jw1AIIZS0K6A5LGoJTWz81l9Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708923957; c=relaxed/simple;
	bh=6OoXSMBS9gARhyGFZOACx9S88j++4mZxmWYv/6V2Qe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3lkXkrI8Y2gLgeMeVvqLhZPufuZF/ZLCXEXXYeX7om8iAEOfERqP/ahcp4q9udc6D/7bZtK6J1NIkR5yJZQBKAm/wqhLfKOZTxYIGXBNfR81X0f2akNE5aqx+cif2K3348Mf3IXRyl9B9ssOzN3OWmdl8lCk3TGrIvTVc5KMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cfc/o67r; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so1798608241.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 21:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708923954; x=1709528754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0sV/ZkJed5YTOmJzKp3YfxIPpujeOY2hnQ4Z72HoPQ=;
        b=Cfc/o67rzD6zpyFJhAb9MVl5m1O5cruahGu/MDGugTze2QhXqGSeHbpMV0DLKRJnAm
         Rm4GJSJoOfYzlf4NhUerTnc84hGypCJzVPQPjslprVce71VAMBTR/hXBvvfJumh23GnZ
         ZqLi0mtktoFTZV4w9PSEPJs5CygtRw2rD/8PTHXC6Ke5US2W/ou5cA+5z3E2ad6Cau+A
         j9r3JbYNS0y1FndMPzCKt5tRSU10GknyB7boa+5C3QZWkDmgsF1w0AwWq/IqI9bg50xS
         N2zJUpXp0HntynVnQHwaF5ebPVSefGzC/hSwk3elliFWP5oDJ2BWJtREOl8PWX0zu9SK
         Px8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708923954; x=1709528754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0sV/ZkJed5YTOmJzKp3YfxIPpujeOY2hnQ4Z72HoPQ=;
        b=U3Wko6zdpd9yMMXOualh6P+JTzcfmY6sZvZSGcsKpDIL53YcRKEUoLMlp+wHIom8Ay
         UpuBSYF/aq4UZQ+TZrdmh37f1xtNYmtDCXZnJ/5dZ5wOmef8zbGP/QR4ZHVq5HAKxKSO
         ZP8P7fimJrY9qpZe3mRBW+5spk43JgcY2J53xIGNM1I73ly6mPiEcN+xutElrLkzxrwc
         HlASvDFdKJzoI/DmTtg3Dp+CXilkfMrLo8SsbqvFHiN859YJpeiGBsrxLSfPlHQ7DbxR
         pxHn9+gXBI9pARuCLvwMamGNFeL94GGTzmaLIL1pL09B3EP31cw4uIOQA9KJHd8yUpsY
         08ew==
X-Forwarded-Encrypted: i=1; AJvYcCV4siUeq1X6yBRcCIzfweusHZ7oij8RAYz+y/LCHQBZ7N4rARKoptJXZeFssRhhWHesoRfuZ/vAVdR/NzVy3N6iMzR0fk+ByPhQJYeY
X-Gm-Message-State: AOJu0Yw7oKBAu6tUkEAPGvgQuNHL8s/HuHglDiCGvV5iOq9OmhGqa8P9
	ZH6AAAHZZhm2su0tSofTL4vSOJtKz856ZOP+1HnNqZnZbpGXw+ntfSRzn2YwKZlGwW+4f8UynSZ
	GjxpKf6BW3nZBIXNwV52qxbhwyks=
X-Google-Smtp-Source: AGHT+IHBzo46moG0layxvLBfJZRHuu4bELDVi9idfDPBnL5nE0tDjUn+TE4R77py2A2yeUoxtrBM9/4KA9fJSj31Zsc=
X-Received: by 2002:a05:6102:3f53:b0:470:4aa5:2c5b with SMTP id
 l19-20020a0561023f5300b004704aa52c5bmr4598628vsv.0.1708923954489; Sun, 25 Feb
 2024 21:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-6-21cnbao@gmail.com> <58efd8d4-28aa-45d6-b384-7463568b24bb@redhat.com>
 <CAGsJ_4zwUpL7LihRBOefg-cmY2mgNjMm-MPkq9VFBdXS_4b=uQ@mail.gmail.com>
 <CAF8kJuNHrM+ZQSnTAOt6rrmGr1P=YS8eU+RSqhAc1CjQ7qdEwQ@mail.gmail.com>
 <c11d73d5-105e-4ae1-837a-b9da392d2dad@redhat.com> <CAF8kJuMmh06rCXuiu5V0BiT8t1ckEEnY4rM-ivRBQ+xdyMhRKQ@mail.gmail.com>
In-Reply-To: <CAF8kJuMmh06rCXuiu5V0BiT8t1ckEEnY4rM-ivRBQ+xdyMhRKQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 26 Feb 2024 18:05:43 +1300
Message-ID: <CAGsJ_4wanQr8mniGnJrzDHKGzWt8J2vT_Mx65+46=qk-R0iM3w@mail.gmail.com>
Subject: Re: [PATCH RFC 5/6] mm: rmap: weaken the WARN_ON in __folio_add_anon_rmap()
To: Chris Li <chrisl@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, ryan.roberts@arm.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Barry Song <v-songbaohua@oppo.com>, 
	Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 5:32=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Mon, Jan 29, 2024 at 2:07=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 29.01.24 04:25, Chris Li wrote:
> > > Hi David and Barry,
> > >
> > > On Mon, Jan 22, 2024 at 10:49=E2=80=AFPM Barry Song <21cnbao@gmail.co=
m> wrote:
> > >>
> > >>>
> > >>>
> > >>> I have on my todo list to move all that !anon handling out of
> > >>> folio_add_anon_rmap_ptes(), and instead make swapin code call add
> > >>> folio_add_new_anon_rmap(), where we'll have to pass an exclusive fl=
ag
> > >>> then (-> whole new folio exclusive).
> > >>>
> > >>> That's the cleaner approach.
> > >>>
> > >>
> > >> one tricky thing is that sometimes it is hard to know who is the fir=
st
> > >> one to add rmap and thus should
> > >> call folio_add_new_anon_rmap.
> > >> especially when we want to support swapin_readahead(), the one who
> > >> allocated large filio might not
> > >> be that one who firstly does rmap.
> > >
> > > I think Barry has a point. Two tasks might race to swap in the folio
> > > then race to perform the rmap.
> > > folio_add_new_anon_rmap() should only call a folio that is absolutely
> > > "new", not shared. The sharing in swap cache disqualifies that
> > > condition.
> >
> > We have to hold the folio lock. So only one task at a time might do the
> > folio_add_anon_rmap_ptes() right now, and the
> > folio_add_new_shared_anon_rmap() in the future [below].
> >
>
> Ah, I see. The folio_lock() is the answer I am looking for.
>
> > Also observe how folio_add_anon_rmap_ptes() states that one must hold
> > the page lock, because otherwise this would all be completely racy.
> >
> >  From the pte swp exclusive flags, we know for sure whether we are
> > dealing with exclusive vs. shared. I think patch #6 does not properly
> > check that all entries are actually the same in that regard (all
> > exclusive vs all shared). That likely needs fixing.
> >
> > [I have converting per-page PageAnonExclusive flags to a single
> > per-folio flag on my todo list. I suspect that we'll keep the
> > per-swp-pte exlusive bits, but the question is rather what we can
> > actually make work, because swap and migration just make it much more
> > complicated. Anyhow, future work]
> >
> > >
> > >> is it an acceptable way to do the below in do_swap_page?
> > >> if (!folio_test_anon(folio))
> > >>        folio_add_new_anon_rmap()
> > >> else
> > >>        folio_add_anon_rmap_ptes()
> > >
> > > I am curious to know the answer as well.
> >
> >
> > Yes, the end code should likely be something like:
> >
> > /* ksm created a completely new copy */
> > if (unlikely(folio !=3D swapcache && swapcache)) {
> >         folio_add_new_anon_rmap(folio, vma, vmf->address);
> >         folio_add_lru_vma(folio, vma);
> > } else if (folio_test_anon(folio)) {
> >         folio_add_anon_rmap_ptes(rmap_flags)
> > } else {
> >         folio_add_new_anon_rmap(rmap_flags)
> > }
> >
> > Maybe we want to avoid teaching all existing folio_add_new_anon_rmap()
> > callers about a new flag, and just have a new
> > folio_add_new_shared_anon_rmap() instead. TBD.

if we have to add a wrapper like folio_add_new_shared_anon_rmap()
to avoid "if (folio_test_anon(folio))" and "else" everywhere, why not
we just do it in folio_add_anon_rmap_ptes() ?

folio_add_anon_rmap_ptes()
{
      if (!folio_test_anon(folio))
               return folio_add_new_anon_rmap();
}

Anyway, I am going to change the patch 4/6 to if(folio_test_anon)/else firs=
t
and drop this 5/6.
we may figure out if we need a wrapper later.

>
> There is more than one caller needed to perform that dance around
> folio_test_anon() then decide which function to call. It would be nice
> to have a wrapper function folio_add_new_shared_anon_rmap() to
> abstract this behavior.
>
>
> >
> > >
> > > BTW, that test might have a race as well. By the time the task got
> > > !anon result, this result might get changed by another task. We need
> > > to make sure in the caller context this race can't happen. Otherwise
> > > we can't do the above safely.
> > Again, folio lock. Observe the folio_lock_or_retry() call that covers
> > our existing folio_add_new_anon_rmap/folio_add_anon_rmap_pte calls.
>
> Ack. Thanks for the explanation.
>
> Chris

Thanks
Barry

