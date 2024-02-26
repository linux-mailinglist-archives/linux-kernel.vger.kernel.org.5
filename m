Return-Path: <linux-kernel+bounces-82299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E58CA86820E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F2C7B216CB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABB5130E46;
	Mon, 26 Feb 2024 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACnsvKAp"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7034D12C55E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980613; cv=none; b=I++AoVzr9XNae6DEZruZvBJcoqfzQQMlyI3KBbl1r8g6OC9ZNJ7ph6NcjidanBziYf4nAjNZIe4hYkNE/rmVD81WLv6YQvh2Qo6hD/A7vlMQGBC7e4BM5k0J7ibIcDqL4wD2nPwcyMau1WUnD613A8xRPnaEheMdeG7TeuTOH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980613; c=relaxed/simple;
	bh=EFzQ048XVQadnpWaezrhvIBalzckp/A18w0hw0sx5VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDtrBfZ5DjBAJkvHzESAfxzdg19fYQ+iypXWc7c062PVmRgl7D6vMEiYU4BYdsmRzhBCx3biHgsU/ohoZTzRAYw00Z1+/1fVaxXAVUbsdtvwt/2lZgsIISVLntKf60SizvLQ8gJGBxjOSaKdIqwmQFZRnFAnrh4u5Yw6bVbkr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACnsvKAp; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7da6e831977so437371241.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708980611; x=1709585411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21VVnvV+8fyMK5A5F+ykm7rHLhBGKI6x/dMJLjTkT0M=;
        b=ACnsvKApS5YGBQM+UOys6bKszxCXB7/rBsji/kqrBMbkDthW6a3sROB8jpZaxqimS5
         6dNVLXY+NI0pt1qF7DkxWeVsSlhmkxcX2oSDCC2bphR/zh1lmd5rTIzgrXgTuv/uTRXc
         c5jrvsjw5ozocSiKx85rxup4H0LkEROfXYjdi8E/NwJvZOodpUJWELozxLhXM7XNJu3B
         CFFhF21z/1yn+MeAS6+QowtyIi91MmkZa8sWu4wgjQ6tzp+S99cyGWtyYUKJdMbuFZ9m
         +BcDW3rMiXjisegCj7hUN8Hc44uh5i7wIo0CQvzZSJSQwQNpcDXOX2PkwEoYcHM36r4o
         V1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708980611; x=1709585411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21VVnvV+8fyMK5A5F+ykm7rHLhBGKI6x/dMJLjTkT0M=;
        b=gh4tr8aPG4mh85x4jQnJAvFkRSV9gjcfUP6HewRA+WjDGFZBqZT4/o4okDjK9G54ib
         /z3rqC+mKZ/O2Br6VJT3nJFj8rE0Hjp9/skxKEEObA5PGHxZsZkgzDuLuTtkTGSmLwzF
         GQX7V/iL3yrj7ts9kIB85k4zDs0ShpS1tYNAS8ww7ov4luGolSOGyV9W1D+R7oHvnJTj
         iGkIHN8sX/vgysdqLERd3b/0MiWVkNlCEZOxsmh5jTJzfLfWs+oLk+VOTDC74JjsD8/g
         ezyJsDbStYWgyolAKMF9ZGXVBxI/VUTXIo77hXMugl4MiaHf9BzPl2xbtA0VdNit1ykL
         qaeg==
X-Forwarded-Encrypted: i=1; AJvYcCWPNeEMAGeDPfocsEylRkYui7E6M0P7UCE/hN33c+XUH6j/y+TJ0TPC8MgZobrmjvx8s+nNcfDKBduhp0Y4PMfyxv8+2mZeSiHoETOJ
X-Gm-Message-State: AOJu0YwmSEheHxVsAnZAongchMTUYfmdNTvICA0AfqggjuIKgTSAePBC
	z4pKBVg+N69NWKlxvPrAl9weXQEe0QLfEA5uhaDxBVLDfozmT1Yw/zKCVLt5elA1RCE1S7qEwmI
	mCXa6/c/xDt/Q+6HQsLg9pXCsYmQ=
X-Google-Smtp-Source: AGHT+IEdCPFYY2btKi3bJxNTN4gBmARMBQKwxn/TaiW7B5j0KDJgX6OVZmbI4zx7wFjzdoqCzTgIPANPctbqrt0SXrE=
X-Received: by 2002:a05:6102:510a:b0:472:2e63:ef2c with SMTP id
 bm10-20020a056102510a00b004722e63ef2cmr2433610vsb.9.1708980611352; Mon, 26
 Feb 2024 12:50:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com> <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
 <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com> <318be511-06de-423e-8216-af869f27f849@arm.com>
In-Reply-To: <318be511-06de-423e-8216-af869f27f849@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Feb 2024 09:49:59 +1300
Message-ID: <CAGsJ_4z+0yXUDYwxKNAqYwxAAYpfKpKd2u_dVTDP3b-KPOQT1g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Lance Yang <ioworker0@gmail.com>, David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	minchan@kernel.org, peterx@redhat.com, shy828301@gmail.com, 
	songmuchun@bytedance.com, wangkefeng.wang@huawei.com, zokeefe@google.com, 
	fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:04=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 26/02/2024 08:55, Lance Yang wrote:
> > Hey David,
> >
> > Thanks for your suggestion!
> >
> > On Mon, Feb 26, 2024 at 4:41=E2=80=AFPM David Hildenbrand <david@redhat=
com> wrote:
> >>
> > [...]
> >>> On Mon, Feb 26, 2024 at 12:00=E2=80=AFPM Barry Song <21cnbao@gmail.co=
m> wrote:
> >>> [...]
> >>>> On Mon, Feb 26, 2024 at 1:33=E2=80=AFAM Lance Yang <ioworker0@gmail.=
com> wrote:
> >>> [...]
> > [...]
> >>> +static inline bool pte_range_cont_mapped(pte_t *pte, unsigned long n=
r)
> >>> +{
> >>> +     pte_t pte_val;
> >>> +     unsigned long pfn =3D pte_pfn(pte);
> >>> +     for (int i =3D 0; i < nr; i++) {
> >>> +             pte_val =3D ptep_get(pte + i);
> >>> +             if (pte_none(pte_val) || pte_pfn(pte_val) !=3D (pfn + i=
))
> >>> +                     return false;
> >>> +     }
> >>> +     return true;
> >>> +}
> >>
> >> I dislike the "cont mapped" terminology.
> >>
> >> Maybe folio_pte_batch() does what you want?
> >
> > folio_pte_batch() is a good choice. Appreciate it!
>
> Agreed, folio_pte_batch() is likely to be widely useful for this change a=
nd
> others, so suggest exporting it from memory.c and reusing as is if possib=
le.

I actually missed folio_pte_batch() in cont-pte series and re-invented
a function
to check if a large folio is entirely mapped in MADV_PAGEOUT[1]. exporting
folio_pte_batch() will also benefit that case. The problem space is same.

[1] https://lore.kernel.org/linux-mm/20240118111036.72641-7-21cnbao@gmail.c=
om/

>
> >
> > Best,
> > Lance
> >
> >>
> >> --
> >> Cheers,
> >>
> >> David / dhildenb

Thanks
Barry

