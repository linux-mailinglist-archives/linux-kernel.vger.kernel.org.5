Return-Path: <linux-kernel+bounces-90062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BE686F9A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6D41F2111F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47726BE7F;
	Mon,  4 Mar 2024 05:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLncKS53"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F2A59
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 05:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709530992; cv=none; b=THTaJGGn5SmVwCnxe9NpOq7ABGEiCkXnFCq1pRzjeyC2+3dD1/p1mcSLtpbGOTimmNETRRhVotMPYVvWTzKoVr7+StOkeSv+gQ1DwHZZR9uz52rfUmG9K3g4FE4Vx6hS5t3fGGzia9eEJ1mJ7iN3Ct5lZVMo9x2EKxPMgdtzqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709530992; c=relaxed/simple;
	bh=xV/fuhKSDLemtoH7XWKg980mNZhrSOCtufAVr1sOLQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwburudEYsq7l1h/h/L2FOqkDSf1qE3mamrnJ4oYaeIqx9z9xSfWsJmAFeBM79osOie23NJ5I98qi6UDq1/j6fcAWG0BflEOHdoaItaD3/4Iqu60QukLi31xk1hxuI/JAQIgNufPzP089jwYvzzuvIO6Zjk8BrW6JN7Fu1ivYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLncKS53; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7db123701bcso811514241.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 21:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709530989; x=1710135789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/g+ihsCrAtAeTgC7avXfAm7wA/HUc5ofGFAsJ0YST60=;
        b=QLncKS53WefWhcf6uEloXiL4QDYiSvT0KDE4ViooHA2GHBc/WgvLi3djkVvd2rdbDq
         sbLCKsM+vN8s26BOJ+TxdBSzRc3DKUxPTIz5ldykHsupQVnFFKcNXm+aJnGYXaTB6CNd
         1YNQjz1stp7CnDvPfM7lbpV6ygtmBbgmab20rDafA9rwhSzNQJPKeZS4KtO94H/7bqR9
         t8jwn4bsWsIhiCBwIMDRYONHGDjyt3sznHgdRUitHSc9lHsnQ6VZ7bPF/sbwTGfuq5wz
         yWSih6NVS38J5nCUoYx6IuaGb06UCNc4orizRN/X3PKZOJwtj5sL/oLyGJAbEvX8EhWN
         ObYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709530989; x=1710135789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g+ihsCrAtAeTgC7avXfAm7wA/HUc5ofGFAsJ0YST60=;
        b=jFhr/bcbcYFPqqAmFeWmbVoqBp4Ck0gZBqIaFG8xAmkzgcM7RO9iF+ppS7LC+MpNAN
         0m/H5UjSpmGvzo+INvhXQ66IQFZ8J52CynvADirwNsUPpJELBfRHuBXc6gn3AxomQKsx
         NSEdc7l4Y/BDEwBGxZXuF9MWujWdljj+lTioelL8K68kQ6mOCOd0hNpUItpOlc2wSiYv
         7+5YG/ZdavDUqomwndL4oVmFpyHwQytxCzIdgAVvW2YTeVi4+vAREqSXc2/RJjUNtAaL
         K7M1SoIcNi4yhnHuDsCRn7rwQq2ivK13nq9yToeXbtxhYU/r3SMW5WOeYxno0JVaDLzw
         UHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0xxjBT/jlvxaKY64KA1u06DfCvLFylpHVkHXJtQ/eEuFRJz+LN1NUiXQEFh32a1APUtWceJqSXqX1BsYAm6IA045ApL2k5EEWRyg7
X-Gm-Message-State: AOJu0Yy1kMI55j0wYNlRKZpJJMxkoOMEEOgUbPqouA2m20MtUFkC9/T6
	6JMJGbe7sKFlptc3iLD/rpwrkGaSAxVyYAiBGt7C6K/gV8IMMurxVw5cx91kQz1SOR23h+r4+eF
	bUFa1dWryb6j7OLgT9Ve/oHnEwus=
X-Google-Smtp-Source: AGHT+IHmrzHnlSGNMQT1LDr5ZPOnTBCSIRwmkXzZoCfJxJbVJW23l/KMqlLlKDS+J5plvFFi2h1EAIwizEqsXc4qcVk=
X-Received: by 2002:a05:6102:356e:b0:472:b188:30ad with SMTP id
 bh14-20020a056102356e00b00472b18830admr1766445vsb.1.1709530989623; Sun, 03
 Mar 2024 21:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com> <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com> <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com> <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
 <4a73b16e-9317-477a-ac23-8033004b0637@arm.com> <1195531c-d985-47e2-b7a2-8895fbb49129@redhat.com>
 <5ebac77a-5c61-481f-8ac1-03bc4f4e2b1d@arm.com> <ZeIC0Bn7N0JlP4TY@casper.infradead.org>
 <e56fbf5e-8051-4285-875b-1de529dc6809@arm.com> <af2b5141-7651-4805-8de9-c79a5c52ce74@arm.com>
 <CAGsJ_4wnSJryK8Jbq+ADVJgnr18r=0M8fkPCpgb8_bOABZkGtQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wnSJryK8Jbq+ADVJgnr18r=0M8fkPCpgb8_bOABZkGtQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 4 Mar 2024 18:42:58 +1300
Message-ID: <CAGsJ_4yyEf9qX55JBskmv4gq6zinvPtdiF3TmOkQj0SmcSBRiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Huang Ying <ying.huang@intel.com>, 
	Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 5:52=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Sat, Mar 2, 2024 at 6:08=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
> >
> > On 01/03/2024 16:44, Ryan Roberts wrote:
> > > On 01/03/2024 16:31, Matthew Wilcox wrote:
> > >> On Fri, Mar 01, 2024 at 04:27:32PM +0000, Ryan Roberts wrote:
> > >>> I've implemented the batching as David suggested, and I'm pretty co=
nfident it's
> > >>> correct. The only problem is that during testing I can't provoke th=
e code to
> > >>> take the path. I've been pouring through the code but struggling to=
 figure out
> > >>> under what situation you would expect the swap entry passed to
> > >>> free_swap_and_cache() to still have a cached folio? Does anyone hav=
e any idea?
> > >>>
> > >>> This is the original (unbatched) function, after my change, which c=
aused David's
> > >>> concern that we would end up calling __try_to_reclaim_swap() far to=
o much:
> > >>>
> > >>> int free_swap_and_cache(swp_entry_t entry)
> > >>> {
> > >>>     struct swap_info_struct *p;
> > >>>     unsigned char count;
> > >>>
> > >>>     if (non_swap_entry(entry))
> > >>>             return 1;
> > >>>
> > >>>     p =3D _swap_info_get(entry);
> > >>>     if (p) {
> > >>>             count =3D __swap_entry_free(p, entry);
> > >>>             if (count =3D=3D SWAP_HAS_CACHE)
> > >>>                     __try_to_reclaim_swap(p, swp_offset(entry),
> > >>>                                           TTRS_UNMAPPED | TTRS_FULL=
);
> > >>>     }
> > >>>     return p !=3D NULL;
> > >>> }
> > >>>
> > >>> The trouble is, whenever its called, count is always 0, so
> > >>> __try_to_reclaim_swap() never gets called.
> > >>>
> > >>> My test case is allocating 1G anon memory, then doing madvise(MADV_=
PAGEOUT) over
> > >>> it. Then doing either a munmap() or madvise(MADV_FREE), both of whi=
ch cause this
> > >>> function to be called for every PTE, but count is always 0 after
> > >>> __swap_entry_free() so __try_to_reclaim_swap() is never called. I'v=
e tried for
> > >>> order-0 as well as PTE- and PMD-mapped 2M THP.
> > >>
> > >> I think you have to page it back in again, then it will have an entr=
y in
> > >> the swap cache.  Maybe.  I know little about anon memory ;-)
> > >
> > > Ahh, I was under the impression that the original folio is put into t=
he swap
> > > cache at swap out, then (I guess) its removed once the IO is complete=
? I'm sure
> > > I'm miles out... what exactly is the lifecycle of a folio going throu=
gh swap out?
> > >
> > > I guess I can try forking after swap out, then fault it back in in th=
e child and
> > > exit. Then do the munmap in the parent. I guess that could force it? =
Thanks for
> > > the tip - I'll have a play.
> >
> > That has sort of solved it, the only problem now is that all the folios=
 in the
> > swap cache are small (because I don't have Barry's large swap-in series=
). So
> > really I need to figure out how to avoid removing the folio from the ca=
che in
> > the first place...
>
> I am quite sure we have a chance to hit a large swapcache even using zRAM=
 -
> a sync swapfile and even during swap-out.
>
> I have a test case as below,
> 1. two threads to run MADV_PAGEOUT
> 2. two threads to read data being swapped-out
>
> in do_swap_page, from time to time, I can get a large swapcache.
>
> We have a short time window after add_to_swap() and before
> __removing_mapping() of
> vmscan,  a large folio is still in swapcache.
>
> So Ryan, I guess you can trigger this by adding one more thread of
> MADV_DONTNEED to do zap_pte_range?

Ryan, I have modified my test case to have 4 threads:
1. MADV_PAGEOUT
2. MADV_DONTNEED
3. write data
4. read data

and git push the code here so that you can get it,
https://github.com/BarrySong666/swaptest/blob/main/swptest.c

I can reproduce the issue in zap_pte_range() in just a couple of minutes.

>
>
> >
> > >
> > >>
> > >> If that doesn't work, perhaps use tmpfs, and use some memory pressur=
e to
> > >> force that to swap?
> > >>
> > >>> I'm guessing the swapcache was already reclaimed as part of MADV_PA=
GEOUT? I'm
> > >>> using a block ram device as my backing store - I think this does sy=
nchronous IO
> > >>> so perhaps if I have a real block device with async IO I might have=
 more luck?
> > >>> Just a guess...
> > >>>
> > >>> Or perhaps this code path is a corner case? In which case, perhaps =
its not worth
> > >>> adding the batching optimization after all?
> > >>>
> > >>> Thanks,
> > >>> Ryan
> > >>>
> > >

Thanks
Barry

