Return-Path: <linux-kernel+bounces-110835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2667A886482
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE02D283F17
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33299818;
	Fri, 22 Mar 2024 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeMkIaYl"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6115B376
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711068977; cv=none; b=rmSaHYTXmzCwwYudN1qJNa8VHHCueFTDW8RyDT4IFGDnPhoWnaJNQje5tEV81s3elAqwG9XE9uxlIQfCSmGpJrpEyvtSegbm73nXWeJF7h/NHnvZzwOdVJznwQM7D+wIgJSSrgfVT2H6hVeRdy1/7TXriqL/orfuE0gRVQmqba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711068977; c=relaxed/simple;
	bh=qCENaW54h1vFKxX65sZ7MxeiiFAmBjrBvLKI872ABLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbdKrckEjsMGwJheQvuoB7G53vc7XoEKPYjNxmsKZpSOsNvcbDGET0gCEFtY+xtXKW7Q/nCQIQ43U2VZi0bxGobzQIG9W6L8iz8TW2sH1eOtEI9s3P8o9vjPX8Mg0Li/0JM36NePdXExEDoELTDqXoZJxNAx1u8hZfz2KpFlK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeMkIaYl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so26599951fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711068973; x=1711673773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcVrCip4Ps9anS18xqoWS2f/zJ/l51Fqge92mpqaEh8=;
        b=PeMkIaYl/tQu9kFNzqwMIP8VyBxzFYg1Bsw14RAE4FEnXBnT+azUWL9rAAfnwPLNPp
         oYBHv0uyfxUnbpirdJxdzBONTx0pFYsWj0dgNQtPs7KY7Ng5yQXzooOQKUMXlZBL23yA
         5HmVEet8YXqZ0iYmP1WR9sXeiLQiaanGuzz5e1gPmfnym1LMk3C9zZEc4eOdi8gKaoY8
         nc/Hyysq1RGDqqEPC+kGzTqBk+oH2LDdrp56t5ArViSZ3e7bZ054z7ID7dybKBjkl6+U
         mf96TkDNBQ+N+UB5t2G+GRFw+6aNVLsnGLAfqTSdnSwaznvUl5Xio6arfpc36YPg0WjO
         3dlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711068973; x=1711673773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcVrCip4Ps9anS18xqoWS2f/zJ/l51Fqge92mpqaEh8=;
        b=khUT8hP9LGBZksywSQylthzXbiCdOyMI+3dYuh9VSTRYHCsd2PJF/U8zAoP9vFFRW7
         L7WEuDhUGrGsJ+kdg3Zbopds5LR53g3imN1Wm4PI1eEb0HTAls/3qamev6S5G9Zpto7h
         4GheOQdERcgrtQfYgsdcQMNUcnDv/ZTf9kbWXs3GAeXNNJEMCOarmzNoEawZk1o15hsg
         4LxPRJePNjdDTthjrJ1Q1Vy2/WGhRjOub5IIqhblA8bk+9NHtr/nHCozm9IB/IELjuuQ
         /Nfvt1Bk3gYdLqiC13C/TcMjeSU7wUtEd/H4pHqOBMWfpvZ7NCtbx3eMJCzxNxFQLOR1
         kE5A==
X-Forwarded-Encrypted: i=1; AJvYcCUCj/gmKM0lsmEXgXkaogHiKlhWNXrKKaFqZxPnMtyW+fQfGKF2eKmsuaQmOD69+gdIQp34OQFceCdcEhIN9gnwqYkqrqGTwJwInSar
X-Gm-Message-State: AOJu0YyTOj7aS2m5rOAijhtfQouoLGq8g4HqfcrjqtK1bMtHIJDr/RNK
	s+Y2l2BNjtfsW8MO5wF/+IaAOjx8Gl33DjkUQE0RwkRY/XapKqssoxUFDSUbCb7061ylqQZq/W1
	b5rnBqu649Pf3OayAQlmFbwgeVbvDsgQJSohM52rC
X-Google-Smtp-Source: AGHT+IH6raTTot+XyOBM82iAckU1J1fggMed0iKNgAS0FhUrBwZqv0ssKTP8PWpyjDQKrR17BkF3oKlqxJEfphY11Ho=
X-Received: by 2002:a2e:a4b7:0:b0:2d6:a31f:b66b with SMTP id
 g23-20020a2ea4b7000000b002d6a31fb66bmr702997ljm.21.1711068973108; Thu, 21 Mar
 2024 17:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com> <CAGsJ_4wpjqRsn7ouO=Ut9oMBLSh803=XuSPX6gJ5nQ3jyqh3hQ@mail.gmail.com>
 <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com> <CAK1f24k1AuHDdrLFNLvwdoOy=xJTVkVdfY4+SN+KW5-EiMSa9Q@mail.gmail.com>
 <7ba06704-2090-4eb2-9534-c4d467cc085a@arm.com> <CAK1f24=yDVwOC31sNMaoZ6K2q1X8vA7p4CtS7nW5WXCm19iEdg@mail.gmail.com>
 <add3b9fc-f08a-4bd4-b01e-4409e81d5a2d@arm.com> <CAK1f24kRXZtKckRFxJfQCNSHJOHy4_nv67T+BfWeWyVtEggdNQ@mail.gmail.com>
 <269375a4-78a3-4c22-8e6e-570368a2c053@arm.com> <CAK1f24m+oQgBYdxUaTASMtJpnUEQvWh-t_kVw7CJzVM4Siddcg@mail.gmail.com>
 <9930c86a-c0c8-4112-9122-0e4faca475f5@arm.com>
In-Reply-To: <9930c86a-c0c8-4112-9122-0e4faca475f5@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 22 Mar 2024 08:56:01 +0800
Message-ID: <CAK1f24ki4cTinggmRDVnFH1+sv-k6KGZpmXcVxVoxeAE4XZyNw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 11:24=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 21/03/2024 14:55, Lance Yang wrote:
> > On Thu, Mar 21, 2024 at 9:38=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >>>>>>>>>> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio=
);
> >>>>>>>>>> -
> >>>>>>>>>> -               if (!pageout && pte_young(ptent)) {
> >>>>>>>>>> -                       ptent =3D ptep_get_and_clear_full(mm, =
addr, pte,
> >>>>>>>>>> -                                                       tlb->f=
ullmm);
> >>>>>>>>>> -                       ptent =3D pte_mkold(ptent);
> >>>>>>>>>> -                       set_pte_at(mm, addr, pte, ptent);
> >>>>>>>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >>>>>>>>>> +               if (!pageout) {
> >>>>>>>>>> +                       for (; nr !=3D 0; nr--, pte++, addr +=
=3D PAGE_SIZE) {
> >>>>>>>>>> +                               if (ptep_test_and_clear_young(=
vma, addr, pte))
> >>>>>>>>>> +                                       tlb_remove_tlb_entry(t=
lb, pte, addr);
> >>>>>>>
> >>>>>>> IIRC, some of the architecture(ex, PPC) don't update TLB with set=
_pte_at and
> >>>>>>> tlb_remove_tlb_entry. So, didn't we consider remapping the PTE wi=
th old after
> >>>>>>> pte clearing?
> >>>>>>
> >>>>>> Sorry Lance, I don't understand this question, can you rephrase? A=
re you saying
> >>>>>> there is a good reason to do the original clear-mkold-set for some=
 arches?
> >>>>>
> >>>>> IIRC, some of the architecture(ex, PPC)  don't update TLB with
> >>>>> ptep_test_and_clear_young()
> >>>>> and tlb_remove_tlb_entry().
> >>
> >> Afraid I'm still struggling with this comment. Do you mean to say that=
 powerpc
> >> invalidates the TLB entry as part of the call to ptep_test_and_clear_y=
oung()? So
> >> tlb_remove_tlb_entry() would be redundant here, and likely cause perfo=
rmance
> >> degradation on that architecture?
> >
> > I just thought that using ptep_test_and_clear_young() instead of
> > ptep_get_and_clear_full() + pte_mkold() might not be correct.
> > However, it's most likely that I was mistaken :(
>
> OK, I'm pretty confident that my usage is correct.
>
> >
> > I also have a question. Why aren't we using ptep_test_and_clear_young()=
 in
> > madvise_cold_or_pageout_pte_range(), but instead
> > ptep_get_and_clear_full() + pte_mkold() as we did previously.
> >
> > /*
> > * Some of architecture(ex, PPC) don't update TLB
> > * with set_pte_at and tlb_remove_tlb_entry so for
> > * the portability, remap the pte with old|clean
> > * after pte clearing.
> > */
>
> Ahh, I see; this is a comment from madvise_free_pte_range() I don't quite
> understand that comment. I suspect it might be out of date, or saying tha=
t doing
> set_pte_at(pte_mkold(ptep_get(ptent))) is not correct because it is not a=
tomic
> and the HW could set the dirty bit between the get and the set. Doing the=
 atomic
> ptep_get_and_clear_full() means you go via a pte_none() state, so if the =
TLB is
> racing it will see the entry isn't valid and fault.

Thanks for your analysis and explanations!

>
> Note that madvise_free_pte_range() is trying to clear both the access and=
 dirty
> bits, whereas madvise_cold_or_pageout_pte_range() is only trying to clear=
 the
> access bit. There is a special helper to clear the access bit atomically =
-
> ptep_test_and_clear_young() - but there is no helper to clear the access =
*and*
> dirty bit, I don't believe. There is ptep_set_access_flags(), but that se=
ts
> flags to a "more permissive setting" (i.e. allows setting the flags, not
> clearing them). Perhaps this constraint can be relaxed given we will foll=
ow up
> with an explicit TLBI - it would require auditing all the implementations=
.

Thanks for bringing this! I'll take a closer look at it.

Thanks again for your time!
Lance

>
> >
> > According to this comment from madvise_free_pte_range. IIUC, we need to
> > call ptep_get_and_clear_full() to clear the PTE, and then remap the
> > PTE with old|clean.
> >
> > Thanks,
> > Lance
> >
> >>
> >> IMHO, ptep_test_and_clear_young() really shouldn't be invalidating the=
 TLB
> >> entry, that's what ptep_clear_flush_young() is for.
> >>
> >> But I do see that for some cases of the 32-bit ppc, there appears to b=
e a flush:
> >>
> >> #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> >> static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
> >>                                               unsigned long addr, pte_=
t *ptep)
> >> {
> >>         unsigned long old;
> >>         old =3D pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
> >>         if (old & _PAGE_HASHPTE)
> >>                 flush_hash_entry(mm, ptep, addr);   <<<<<<<<
> >>
> >>         return (old & _PAGE_ACCESSED) !=3D 0;
> >> }
> >> #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
> >>         __ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep)
> >>
> >> Is that what you are describing? Does any anyone know why flush_hash_e=
ntry() is
> >> called? I'd say that's a bug in ppc and not a reason not to use
> >> ptep_test_and_clear_young() in the common code!
> >>
> >> Thanks,
> >> Ryan
> >>
> >>
> >>>>
> >>>> Err, I assumed tlb_remove_tlb_entry() meant "invalidate the TLB entr=
y for this
> >>>> address please" - albeit its deferred and batched. I'll look into th=
is.
> >>>>
> >>>>>
> >>>>> In my new patch[1], I use refresh_full_ptes() and
> >>>>> tlb_remove_tlb_entries() to batch-update the
> >>>>> access and dirty bits.
> >>>>
> >>>> I want to avoid the per-pte clear-modify-set approach, because this =
doesn't
> >>>> perform well on arm64 when using contpte mappings; it will cause the=
 contpe
> >>>> mapping to be unfolded by the first clear that touches the contpte b=
lock, then
> >>>> refolded by the last set to touch the block. That's expensive.
> >>>> ptep_test_and_clear_young() doesn't suffer that problem.
> >>>
> >>> Thanks for explaining. I got it.
> >>>
> >>> I think that other architectures will benefit from the per-pte clear-=
modify-set
> >>> approach. IMO, refresh_full_ptes() can be overridden by arm64.
> >>>
> >>> Thanks,
> >>> Lance
> >>>>
> >>>>>
> >>>>> [1] https://lore.kernel.org/linux-mm/20240316102952.39233-1-ioworke=
r0@gmail.com
> >>>>>
> >>>>> Thanks,
> >>>>> Lance
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Lance
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>>>> +                       }
> >>>>>>>>>
> >>>>>>>>> This looks so smart. if it is not pageout, we have increased pt=
e
> >>>>>>>>> and addr here; so nr is 0 and we don't need to increase again i=
n
> >>>>>>>>> for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE)
> >>>>>>>>>
> >>>>>>>>> otherwise, nr won't be 0. so we will increase addr and
> >>>>>>>>> pte by nr.
> >>>>>>>>
> >>>>>>>> Indeed. I'm hoping that Lance is able to follow a similar patter=
n for
> >>>>>>>> madvise_free_pte_range().
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>                 }
> >>>>>>>>>>
> >>>>>>>>>>                 /*
> >>>>>>>>>> --
> >>>>>>>>>> 2.25.1
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Overall, LGTM,
> >>>>>>>>>
> >>>>>>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>>>>
> >>>>>>>> Thanks!
> >>>>>>>>
> >>>>>>>>
> >>>>>>
> >>>>
> >>
>

