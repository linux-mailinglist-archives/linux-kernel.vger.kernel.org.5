Return-Path: <linux-kernel+bounces-82579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36EE86869E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DC41C22FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47377F4FB;
	Tue, 27 Feb 2024 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9NG9NOB"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1257437E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708999975; cv=none; b=oejqWE3+yTgL6gH9n8IfDsldKqp5olRiG3h/Sb9AIBCYcVBhmCmiocWx3wZJtUe5ndJFkqYiSztSNyS8wSbbmbHznweD1eRltLhDHSIXhF/krAek01v9GH/m4cP2BXqKrbL6FhMq71AT9JEx1gXtvjKHKx95a7qahEwAuPYax40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708999975; c=relaxed/simple;
	bh=vESwIVXswi9nugB34EWR/L/vu4C3av3Yags8x4JfyzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IK7VBOv8uf7+Iz4I4fOcyF4/MOvBTrha/FA4P3WaNF8glccjqfNM7Nk6Gx/y2NGR8B7D7UMcRmVysOAeJIrJjtm/sm5vTt5rmb0kAYOfD2d9snd50cFVstwynzeW1jSkzn/U0yvy2ocrCv+eQ54muiuyoh1ddPNAwiBe0GWPZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9NG9NOB; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4704c69a3d9so508503137.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708999973; x=1709604773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4AL21Kby9XJrGNwCYh+T8ly2jOpVTK59tg/4cTmKhs=;
        b=M9NG9NOBduBHFeoHYAJLCig10IzcrUxFnz80qJ39jORH0oFRyr1zLjwhPTgOYPf+X0
         BRafs9vA0rVYmYzR8mrZFRF5KmFu+kdmcrspsWNu01rclwDF8tK+9x9FNAAR2LU4NR1M
         eHsfKo/3NtMYIg2Q13RrKFY4mdWXRMGejILFxOdT+RQxHHZWg8kXb2uiYN2ziUqsoADu
         yXoGZ449a7KGIc5eahM8KwFBubYPJ9+QZNwK4QmZEmLLAbbHtehwwOOp7EmwGgruQqVx
         KSgbYpa6TX/d/XzcSTF93UxFKimGDrbRZsfGm3Pecdm4lV0tU/eo8hqdkzz9sSWkluFB
         Nzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708999973; x=1709604773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4AL21Kby9XJrGNwCYh+T8ly2jOpVTK59tg/4cTmKhs=;
        b=HSmTW5xoEPikI4hwGQc/RW7/Q6bjNHvpfzvYWrEM4wmbBiM8ANSTrLtxwXs1YPjKfS
         WbNg5Xl/A9cQOa+esNEz+mL+p7AJwxqM3kXJxPV3WOVUbQ3r49Nrk4flvO5BO3I0HeCu
         ZG3mWOiAg5M1HBTXBk+vDrnlGOWzIRZEI8MV6dRUQutUdVR1NRW6cURnucFhLWOSpdTK
         7y+Tv83rKxWopfzVBkjR7HiGE+Slheb5/B5CYHIM8Pybc/vCEpQbzkw/ZzAQiHivkQKj
         XTctvnoFJjNlzapPmE745xGmV0TGbpMdscfs+sA8IJnIOIcBAxfzOZUW9d7LkinXakVJ
         nOWg==
X-Forwarded-Encrypted: i=1; AJvYcCWTBrgK1Rui36rAkEWXJzswHFNaHuGniWI4H8AKE+RL3Dt19Uxm0CO0JbTYg8byLp2KqNrlhAj5IVGCloEj3ab7kU8Qgj9HAvoxXxvj
X-Gm-Message-State: AOJu0Yw9ND+EeU1tOYmYjJ29VD485Y0KogujhL3qI62xSwxvdSnBa+Or
	ifaVhvQLqNat64/QNZMfPrkZ3xW6X4RClOp2xuF2tunFEHqiqJY7pcPv+1eEpMDeEy9YF/ZIuAS
	BtBK7ngDblugzMcK2enl3y9fr5rU=
X-Google-Smtp-Source: AGHT+IEn9Q4OROYSWs3z77bMr2noi6omg7s7GADR2IZlrTVeK6Mo0tUALc2VX5D7GtWTnunpuNiVz/TfwXUSzS2nl54=
X-Received: by 2002:a67:fc84:0:b0:470:3afd:81dd with SMTP id
 x4-20020a67fc84000000b004703afd81ddmr6274013vsp.4.1708999972959; Mon, 26 Feb
 2024 18:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK1f24=yWPQnYuQYgc3cXdBC0HoR1yAwY59Xs2DYPAC4DQzw0A@mail.gmail.com>
 <20240227012127.174048-1-21cnbao@gmail.com> <CAK1f24kuorp8nzdeugURmnGunBhcA5VFTXi_G8M_r+Fmm=_DaQ@mail.gmail.com>
In-Reply-To: <CAK1f24kuorp8nzdeugURmnGunBhcA5VFTXi_G8M_r+Fmm=_DaQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 15:12:42 +1300
Message-ID: <CAGsJ_4yAbtMzUifVRLO8nZREOX+nW2_dEcV7++Y7-9SGNK_nsg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, fengwei.yin@intel.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	minchan@kernel.org, peterx@redhat.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com, 
	zokeefe@google.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:48=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> On Tue, Feb 27, 2024 at 9:21=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > > Thanks for your suggestion. I'll use folio_pte_batch() in v2.
> >
> > Hi Lance,
> > Obviously, we both need this. While making large folio swap-in
> > v2, I am exporting folio_pte_batch() as below,
>
> Thanks, Barry.
>
> Could you separate the export of folio_pte_batch() from the large folio
> swap-in v2? Prioritizing the push for this specific change would aid in
> the development of the v2 based on it.

I agree we should make this one pulled in by Andrew early to avoid potentia=
l
dependencies and conflicts in two jobs.

>
> Best,
> Lance
>
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> > Date: Tue, 27 Feb 2024 14:05:43 +1300
> > Subject: [PATCH] mm: export folio_pte_batch as a couple of modules need=
 it
> >
> > MADV_FREE, MADV_PAGEOUT and some other modules might need folio_pte_bat=
ch
> > to check if a range of PTEs are completely mapped to a large folio with
> > contiguous physcial offset.
> >
> > Cc: Lance Yang <ioworker0@gmail.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/internal.h | 13 +++++++++++++
> >  mm/memory.c   |  2 +-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 36c11ea41f47..7e11aea3eda9 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio *=
folio)
> >         return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
> >  }
> >
> > +/* Flags for folio_pte_batch(). */
> > +typedef int __bitwise fpb_t;
> > +
> > +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> > +#define FPB_IGNORE_DIRTY               ((__force fpb_t)BIT(0))
> > +
> > +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty =
bit. */
> > +#define FPB_IGNORE_SOFT_DIRTY          ((__force fpb_t)BIT(1))
> > +
> > +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
> > +               pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> > +               bool *any_writable);
> > +
> >  void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
> >                                                 int nr_throttled);
> >  static inline void acct_reclaim_writeback(struct folio *folio)
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 6378f6bc22c5..dd9bd67f037a 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -989,7 +989,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t=
 pte, fpb_t flags)
> >   * If "any_writable" is set, it will indicate if any other PTE besides=
 the
> >   * first (given) PTE is writable.
> >   */
> > -static inline int folio_pte_batch(struct folio *folio, unsigned long a=
ddr,
> > +int folio_pte_batch(struct folio *folio, unsigned long addr,
> >                 pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> >                 bool *any_writable)
> >  {
> > --
> > 2.34.1
> >
> > > Best,
> > > Lance
> >
Thanks
Barry
> >

