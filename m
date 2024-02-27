Return-Path: <linux-kernel+bounces-83083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7183A868E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3881F248A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E0B1386CA;
	Tue, 27 Feb 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS+kiTI0"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DA01386B2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031367; cv=none; b=N0JDEVdIqcUIqNZXMkz6HBOfWSe9joijlQbm+UrQcejPKLK9dZcZqHlaWV/MFL96jYOpOo6R+eSrbEvkPrhzI9gtPiB+Eq3SKLpB0BbEqHy1rrBtV2qF3kngflOioa8DfyZm+8P+dYMfKmF/hRJxtFJTX40Xp+lxYz97zxfkCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031367; c=relaxed/simple;
	bh=elc3cBUPonY/2yDphdlgad2Daw2VXi6iK4CbMVPevdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfJNuXHkc+UkxyxuUksv4qFqrexDrafmQuKs7CaNzPnnvZO559m3UmoaN4DqNKqJwf4D8cnm8S6OtzvI+0O2YQLcRl/nW9R9kgfqvVimtp2cC/eafvbomJxzlIIKP8pgEqBam/lOTS0lrllHpPDKS6Ad2IQJxOV74z4nJ03ulk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS+kiTI0; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso4399361276.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709031365; x=1709636165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED0zzN2J7aQW/TBXYhdK+COJTUND1pmDy7G6gypl/WU=;
        b=iS+kiTI0h9A/1BJ6W/YTDt7riQUhwKT4pmK+NMcFpCnANXCNkHj7ytP53PyzYdn4q8
         tIG46b7E5I5vrITunmeZlHUEqHCPrParK2sIgy31prmR4NGftR1EnIzgnL+va1cn/Gpy
         S29ZiN8QMEEIdLwtkawWc2K5JC3ssJZ/gcVb4RNrMjIlSdsKRKPmQl2kPwtvF6lADTIx
         Qh1ZSmyr5fi1VZ+tkXsNOusZZ47Kr+ydXCDl0hojnfYMewjtnXwcpWZa6Qdo7Qz9yqVC
         T3AgYgBAf9noo1C7z6Wkg9+YyDppN1GSWVE8K76J5TpERya5n/NMXwRPHVoDcQUdEI8S
         LvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709031365; x=1709636165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ED0zzN2J7aQW/TBXYhdK+COJTUND1pmDy7G6gypl/WU=;
        b=rPPXc1SfRln6fof16rV6KTpTidrxfzlfSF9J0CKC8eYtGRkvYG677ElVNpreNpNFtr
         kLZvvosNPlOMON7YPIaZE5Jb52a9kbqeIjXdtRlzWTqS8SapiZImm8oh6WT7ofAiJSEV
         +tLILmFncTG/jwSeyinClibfWHkkAyUNVzWQSra6cxvymfmnFTYwxCNm5S1lYtRBSfSA
         aT3tXRa/8bFQjG4pknDRgnSINCsYkJFP/ofN4AVUGpqVw0k7sV2K7po34HS88ivas+2k
         AjwbAltjwzH0fHM7wuBqtoHKoFo2AhQCb9Z1HAgVgd2CnqO9BahzlBbE8UMpdLgPPUWq
         ZbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVskqpxdH3gXBnnbjbMWwAPor4in0pE6TbCpY+NN1STZ5+c+d8kSpjUIK1K42GW8vfUfODU/0rzvsak+3zeu9amRmyLEV9cGlbSw5hG
X-Gm-Message-State: AOJu0YxNRlgULM5PRgbk4a7sTVzikJgjHsGEI76rcbXK6nSQZJLLFe7w
	TZWPz91vd5koYQ20KmthNDCWSp7SHHemdSnbVb2ewirgq749Ee/YBqNl5D06Z83399CABubhG/Y
	NL9ARVt1qGJtcHcY8oSgIDlXFJSpWp+BW35cpZg==
X-Google-Smtp-Source: AGHT+IG4KxVvRfi/gCW6H51rEZV6s8STfDt6xGv0klsD2sqx+jAHu0OLXuGKzZtIVphEcnqBLRPUUpLRbwLJxpULbnc=
X-Received: by 2002:a25:a128:0:b0:dcc:e854:d453 with SMTP id
 z37-20020a25a128000000b00dcce854d453mr1901576ybh.1.1709031364751; Tue, 27 Feb
 2024 02:56:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227024050.244567-1-21cnbao@gmail.com> <61b9dfc9-5522-44fd-89a4-140833ede8af@arm.com>
 <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com> <CAK1f24mOc+Y_UCA2nSC7VbNQMy0DahULz-6JsEPMqTyoAA+MoA@mail.gmail.com>
 <dbce43b4-cf69-41d0-af6c-fdfc3032fedb@redhat.com> <dc2ac3e5-a354-4447-a7da-26cae0c57b0d@arm.com>
In-Reply-To: <dc2ac3e5-a354-4447-a7da-26cae0c57b0d@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 27 Feb 2024 18:55:53 +0800
Message-ID: <CAK1f24mr=vkAnmPdAADsyQ3ymofv7SrxwegBPb9tQK2jve98RA@mail.gmail.com>
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Yin Fengwei <fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Ryan, Barry, David!

Best,
Lance

On Tue, Feb 27, 2024 at 6:53=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 27/02/2024 10:30, David Hildenbrand wrote:
> > On 27.02.24 11:21, Lance Yang wrote:
> >> On Tue, Feb 27, 2024 at 5:14=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 27.02.24 10:07, Ryan Roberts wrote:
> >>>> On 27/02/2024 02:40, Barry Song wrote:
> >>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>
> >>>>> madvise and some others might need folio_pte_batch to check if a ra=
nge
> >>>>> of PTEs are completely mapped to a large folio with contiguous phys=
cial
> >>>>> addresses. Let's export it for others to use.
> >>>>>
> >>>>> Cc: Lance Yang <ioworker0@gmail.com>
> >>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >>>>> Cc: David Hildenbrand <david@redhat.com>
> >>>>> Cc: Yin Fengwei <fengwei.yin@intel.com>
> >>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>> ---
> >>>>>    -v1:
> >>>>>    at least two jobs madv_free and madv_pageout depend on it. To av=
oid
> >>>>>    conflicts and dependencies, after discussing with Lance, we pref=
er
> >>>>>    this one can land earlier.
> >>>>
> >>>> I think this will also ultimately be useful for mprotect too, though=
 I haven't
> >>>> looked at it properly yet.
> >>>>
> >>>
> >>> Yes, I think we briefly discussed that.
> >>>
> >>>>>
> >>>>>    mm/internal.h | 13 +++++++++++++
> >>>>>    mm/memory.c   | 11 +----------
> >>>>>    2 files changed, 14 insertions(+), 10 deletions(-)
> >>>>>
> >>>>> diff --git a/mm/internal.h b/mm/internal.h
> >>>>> index 13b59d384845..8e2bc304f671 100644
> >>>>> --- a/mm/internal.h
> >>>>> +++ b/mm/internal.h
> >>>>> @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct fol=
io *folio)
> >>>>>       return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
> >>>>>    }
> >>>>>
> >>>>> +/* Flags for folio_pte_batch(). */
> >>>>> +typedef int __bitwise fpb_t;
> >>>>> +
> >>>>> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> >>>>> +#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
> >>>>> +
> >>>>> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-di=
rty bit. */
> >>>>> +#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1)=
)
> >>>>> +
> >>>>> +extern int folio_pte_batch(struct folio *folio, unsigned long addr=
,
> >>>>> +            pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> >>>>> +            bool *any_writable);
> >>>>> +
> >>>>>    void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *fo=
lio,
> >>>>>                                               int nr_throttled);
> >>>>>    static inline void acct_reclaim_writeback(struct folio *folio)
> >>>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>>> index 1c45b6a42a1b..319b3be05e75 100644
> >>>>> --- a/mm/memory.c
> >>>>> +++ b/mm/memory.c
> >>>>> @@ -953,15 +953,6 @@ static __always_inline void __copy_present_pte=
s(struct
> >>>>> vm_area_struct *dst_vma,
> >>>>>       set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
> >>>>>    }
> >>>>>
> >>>>> -/* Flags for folio_pte_batch(). */
> >>>>> -typedef int __bitwise fpb_t;
> >>>>> -
> >>>>> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> >>>>> -#define FPB_IGNORE_DIRTY            ((__force fpb_t)BIT(0))
> >>>>> -
> >>>>> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-di=
rty bit. */
> >>>>> -#define FPB_IGNORE_SOFT_DIRTY               ((__force fpb_t)BIT(1)=
)
> >>>>> -
> >>>>>    static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t f=
lags)
> >>>>>    {
> >>>>>       if (flags & FPB_IGNORE_DIRTY)
> >>>>> @@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(p=
te_t
> >>>>> pte, fpb_t flags)
> >>>>>     * If "any_writable" is set, it will indicate if any other PTE b=
esides the
> >>>>>     * first (given) PTE is writable.
> >>>>>     */
> >>>>
> >>>> David was talking in Lance's patch thread, about improving the docs =
for this
> >>>> function now that its exported. Might be worth syncing on that.
> >>>
> >>> Here is my take:
> >>>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>>    mm/memory.c | 22 ++++++++++++++++++----
> >>>    1 file changed, 18 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index d0b855a1837a8..098356b8805ae 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -971,16 +971,28 @@ static inline pte_t __pte_batch_clear_ignored(p=
te_t
> >>> pte, fpb_t flags)
> >>>          return pte_wrprotect(pte_mkold(pte));
> >>>    }
> >>>
> >>> -/*
> >>> +/**
> >>> + * folio_pte_batch - detect a PTE batch for a large folio
> >>> + * @folio: The large folio to detect a PTE batch for.
> >>> + * @addr: The user virtual address the first page is mapped at.
> >>> + * @start_ptep: Page table pointer for the first entry.
> >>> + * @pte: Page table entry for the first page.
> >>
> >> Nit:
> >>
> >> - * @pte: Page table entry for the first page.
> >> + * @pte: Page table entry for the first page that must be the first s=
ubpage of
> >> + *               the folio excluding arm64 for now.
> >>
> >> IIUC, pte_batch_hint is always 1 excluding arm64 for now.
> >> I'm not sure if this modification will be helpful?
> >
> > IIRC, Ryan made sure that this also works when passing another subpage,=
 after
> > when cont-pte is set. Otherwise this would already be broken for fork/z=
ap.
> >
> > So I don't think this comment would actually be correct.
>
> Indeed, the spec for the function is exactly the same for arm64 as for ot=
her
> arches. It's just that arm64 can accelerate the implementation by skippin=
g
> forward to the next contpte boundary when the current pte is part of a co=
ntpte
> block.
>
> There is no requirement for pte (or addr or start_ptep) to point to the f=
irst
> subpage of a folio - they can point to any subpage.
>
> pte, addr and start_ptep must all refer to the same entry, but I think th=
at's
> clear from the existing text.
>
>

