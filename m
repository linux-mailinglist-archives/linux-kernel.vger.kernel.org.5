Return-Path: <linux-kernel+bounces-95097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A1987492E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27DF285E20
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE06312B;
	Thu,  7 Mar 2024 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBvYuw4l"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D063105
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798442; cv=none; b=qk2mLlXPqtnIeMeROzpRb3Ze0qrJByZ5dui62V4Oz1D/wIEppRNFxvQsCFmwQJrleqzgFqn+3RkmaRfVp00QgxKnYlIPBkr62dalDU+Yc43TK3QqQjPfBeGJ/5F+/VERyD1VKuiY8AtNAAPLiI+FhYBY38ngUkaiekCADdnsiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798442; c=relaxed/simple;
	bh=ATcWJp5z4xOvtZ7AeQbHvr2q4zsC6Z9jHdEupyiLmGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwOh8080EKWOnFubBSgei8cZD7Cb+dR9BGI2y5EVjvOky5CK95p/P/0kPAmgMA8l6g9+JIvnC0Rk1ArJaa6sq5UptZrNRwbcklEeBIR82Dijit1njvpw69TgZiPZc6swGNhwD2/aovG31RUlmO+mLEaINYTmeJiD+5qNR725zFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBvYuw4l; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60974cb1cd7so5888767b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709798440; x=1710403240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwyP8Dm0lc4Sbthfzn9A87q7hRvRihfjLXqB9VmL5M0=;
        b=LBvYuw4lxM3aO+hCVat1VjTQfhE89yoLIDcbvlCkxp3JZTgFeutCMvKOxLA98f0Poh
         fLvHAUxRbruT6tlYW4Oyaw8RF2T9hdKOBA9QABl8XFO42JU4svbxMx0IcXBVoFaQq6ob
         /fth3ZJVCdpvCK9tggrDymjaA8jJseAb6PScFXh29pTyL92a4nx9qNTjPhJG6TtKo5Vs
         j1zSLdkck7kUgHzz/PzfIfiHiYKd9g2kwI4kV/KuEiUaAg+DDkn5Dd+6Bb+f9FlJgH3q
         sVkFcHzLUOPQQZYdkQWKcN+e7j1deBknhjehEf30sp89WmtXt6wKPl+i0BTVnyHjvPjq
         /a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798440; x=1710403240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwyP8Dm0lc4Sbthfzn9A87q7hRvRihfjLXqB9VmL5M0=;
        b=pascxPNw+S4leTQPGgbAw5CetX/3Xe/ia3ErUlS9/pwoGNhSgID73/cQhfdCdZV/cC
         UpG/F4hiytTpYnIfzFtu5IlhWoLEqdi1JMuSsEEi7UtJqVWt62j86HNOj0bHv4VpzU1n
         +aR/PrNzBE2bAOOq5aygWdsYKtvuF84cnTTziXJcjH+BFjH6UQkeVaVeATBW2+YyMFKj
         hlPOS0LbXIDhq/qw+dXoJUr3TLtW9qNdekUUysNHxZGlZluxs1W7mg/Afj53IjCffQ6D
         xEbTKqkpu1lEX1r+Zo0mnDPUz2o+/9wwi1BSO5pnmeKgDhGOdOiui2ZttyFxKdHY0IuU
         620g==
X-Forwarded-Encrypted: i=1; AJvYcCV2NM/VswWTshTOW85tILjDfCcUVhn9u7MWfNtw98U7edJtJeGVHVckyM8ryxNOy0mK949Dh1kSn6HW25iYqwMRA/3tVpdbJ06NWAaD
X-Gm-Message-State: AOJu0YwttNP4McO7sZQEYhHt6ZpTHMasqcWUWiATvnAh9AuK0o4Kv5RJ
	4Ihhy+JbnT0WrPSp3d8PXJyIum0/uLZ34eg/egzV7hsaGY8ysV4R1Jr+rPbjE8K1tb+ceF2g6oK
	Z5iUAbYBqXbWXv5MD3iWHPcxzBb0=
X-Google-Smtp-Source: AGHT+IG7m2wyaFgf4jMNTIDNeymu55YnQOUk7Bx9o0bwiNttjvwPt3wSoRc9BpMQkLYtK7Z+uwPEk0+hkGq1asnSiJM=
X-Received: by 2002:a81:5b8a:0:b0:608:cda9:b735 with SMTP id
 p132-20020a815b8a000000b00608cda9b735mr18176444ywb.39.1709798440191; Thu, 07
 Mar 2024 00:00:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307061425.21013-1-ioworker0@gmail.com> <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
In-Reply-To: <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 7 Mar 2024 16:00:28 +0800
Message-ID: <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, david@redhat.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Barry,

Thanks for taking time to review!

On Thu, Mar 7, 2024 at 3:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Thu, Mar 7, 2024 at 7:15=E2=80=AFPM Lance Yang <ioworker0@gmail.com> w=
rote:
> >
[...]
> > +static inline bool can_mark_large_folio_lazyfree(unsigned long addr,
> > +                                                struct folio *folio, p=
te_t *start_pte)
> > +{
> > +       int nr_pages =3D folio_nr_pages(folio);
> > +       fpb_t flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
> > +
> > +       for (int i =3D 0; i < nr_pages; i++)
> > +               if (page_mapcount(folio_page(folio, i)) !=3D 1)
> > +                       return false;
>
> we have moved to folio_estimated_sharers though it is not precise, so
> we don't do
> this check with lots of loops and depending on the subpage's mapcount.

If we don't check the subpage=E2=80=99s mapcount, and there is a cow folio =
associated
with this folio and the cow folio has smaller size than this folio,
should we still
mark this folio as lazyfree?

> BTW, do we need to rebase our work against David's changes[1]?
> [1] https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@redhat=
com/

Yes, we should rebase our work against David=E2=80=99s changes.

>
> > +
> > +       return nr_pages =3D=3D folio_pte_batch(folio, addr, start_pte,
> > +                                        ptep_get(start_pte), nr_pages,=
 flags, NULL);
> > +}
> > +
> >  static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
> >                                 unsigned long end, struct mm_walk *walk=
)
> >
> > @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
igned long addr,
> >                  */
> >                 if (folio_test_large(folio)) {
> >                         int err;
> > +                       unsigned long next_addr, align;
> >
> > -                       if (folio_estimated_sharers(folio) !=3D 1)
> > -                               break;
> > -                       if (!folio_trylock(folio))
> > -                               break;
> > +                       if (folio_estimated_sharers(folio) !=3D 1 ||
> > +                           !folio_trylock(folio))
> > +                               goto skip_large_folio;
>
>
> I don't think we can skip all the PTEs for nr_pages, as some of them migh=
t be
> pointing to other folios.
>
> for example, for a large folio with 16PTEs, you do MADV_DONTNEED(15-16),
> and write the memory of PTE15 and PTE16, you get page faults, thus PTE15
> and PTE16 will point to two different small folios. We can only skip when=
 we
> are sure nr_pages =3D=3D folio_pte_batch() is sure.

Agreed. Thanks for pointing that out.

>
> > +
> > +                       align =3D folio_nr_pages(folio) * PAGE_SIZE;
> > +                       next_addr =3D ALIGN_DOWN(addr + align, align);
> > +
> > +                       /*
> > +                        * If we mark only the subpages as lazyfree, or
> > +                        * cannot mark the entire large folio as lazyfr=
ee,
> > +                        * then just split it.
> > +                        */
> > +                       if (next_addr > end || next_addr - addr !=3D al=
ign ||
> > +                           !can_mark_large_folio_lazyfree(addr, folio,=
 pte))
> > +                               goto split_large_folio;
> > +
> > +                       /*
> > +                        * Avoid unnecessary folio splitting if the lar=
ge
> > +                        * folio is entirely within the given range.
> > +                        */
> > +                       folio_clear_dirty(folio);
> > +                       folio_unlock(folio);
> > +                       for (; addr !=3D next_addr; pte++, addr +=3D PA=
GE_SIZE) {
> > +                               ptent =3D ptep_get(pte);
> > +                               if (pte_young(ptent) || pte_dirty(ptent=
)) {
> > +                                       ptent =3D ptep_get_and_clear_fu=
ll(
> > +                                               mm, addr, pte, tlb->ful=
lmm);
> > +                                       ptent =3D pte_mkold(ptent);
> > +                                       ptent =3D pte_mkclean(ptent);
> > +                                       set_pte_at(mm, addr, pte, ptent=
);
> > +                                       tlb_remove_tlb_entry(tlb, pte, =
addr);
> > +                               }
>
> Can we do this in batches? for a CONT-PTE mapped large folio, you are unf=
olding
> and folding again. It seems quite expensive.

Thanks for your suggestion. I'll do this in batches in v3.

Thanks again for your time!

Best,
Lance

>
> > +                       }
> > +                       folio_mark_lazyfree(folio);
> > +                       goto next_folio;
> > +
> > +split_large_folio:
> >                         folio_get(folio);
> >                         arch_leave_lazy_mmu_mode();
> >                         pte_unmap_unlock(start_pte, ptl);
> > @@ -688,13 +736,28 @@ static int madvise_free_pte_range(pmd_t *pmd, uns=
igned long addr,
> >                         err =3D split_folio(folio);
> >                         folio_unlock(folio);
> >                         folio_put(folio);
> > -                       if (err)
> > -                               break;
> > -                       start_pte =3D pte =3D
> > -                               pte_offset_map_lock(mm, pmd, addr, &ptl=
);
> > -                       if (!start_pte)
> > -                               break;
> > -                       arch_enter_lazy_mmu_mode();
> > +
> > +                       /*
> > +                        * If the large folio is locked or cannot be sp=
lit,
> > +                        * we just skip it.
> > +                        */
> > +                       if (err) {
> > +skip_large_folio:
> > +                               if (next_addr >=3D end)
> > +                                       break;
> > +                               pte +=3D (next_addr - addr) / PAGE_SIZE=
;
> > +                               addr =3D next_addr;
> > +                       }
> > +
> > +                       if (!start_pte) {
> > +                               start_pte =3D pte =3D pte_offset_map_lo=
ck(
> > +                                       mm, pmd, addr, &ptl);
> > +                               if (!start_pte)
> > +                                       break;
> > +                               arch_enter_lazy_mmu_mode();
> > +                       }
> > +
> > +next_folio:
> >                         pte--;
> >                         addr -=3D PAGE_SIZE;
> >                         continue;
> > --
> > 2.33.1
> >
>
> Thanks
> Barry

