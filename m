Return-Path: <linux-kernel+bounces-132201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0015F89913B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A2FB28032
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B69713C3EB;
	Thu,  4 Apr 2024 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0Vz4No7"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FAA13BC38
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269334; cv=none; b=S9W30LLyb6C5GgIU19j2+nZsrG1EMJ2jk+pIyvKTvkhGmNsyf/CGhewGqI11RLEE7sKzImuwoQhz2UfcERzGIHXV6DSpO3ltO2IB85P5dKa2UcKplPFb4ls3lCcFYSLt8f7GgryNTsHKzdgh3qbtLEphK15IDusaQVMPIhZxqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269334; c=relaxed/simple;
	bh=7q/S3v7wj78fJ9svdYqnxfBV9Iq1DU8R58pJjf9G87Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvjbKvUTC5yT0RDVhZ6gzydpnFLPvnQlkRFZsTlBNbVPMoPVJ9uE1fZ/AiW2CC++xcsfOTV7KyAr8fSI0aR7zqU9EPFtsHRu8yVvStO0B4482BRrEUh1TqSBaMHDZ2BYjrJT4IOa6kzJlQl9/efOVAr4EnWg5WYGPR47LWIkqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0Vz4No7; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7e3b3e33ab9so513070241.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712269332; x=1712874132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Pic4NZdzlP4xXihBtUAg9zgkAtIAqZuKoS+pSv1G+o=;
        b=U0Vz4No7sta0RJNDvIfxmVl+CW9dPxFO5+mN4ekOd2RXQUvQmmXU6bvn2wjgY+rhg4
         sE0y5Owl5mcmE4BBzNm+bHcCoC2+8qqiqKxWC+CG6RuvJdLHBAPefR5XFUi2Uy010Oro
         h7Uczrm5ylNoy+l2rszRldinp4/qincdebESoEww11OFemRqIGUyyXbKKonNWmsY9gC7
         UqJSqGnFXnv/XKNV/H7RI6Zp2CkJPs3EuFw6evNj8kMLCQ+PStH1+1irlaITcCsAn453
         fgIMOlRwlCRKWIUJpbUN/Ol4+W8rkrpJa2Fi/drzOI1+asnMVEcpQkAMBsgnQRGPEiTX
         Yspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712269332; x=1712874132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Pic4NZdzlP4xXihBtUAg9zgkAtIAqZuKoS+pSv1G+o=;
        b=Z3KAHBJh0Pt6kBjOctwiSwMNOxppeipQKMU/6vzjImvkQ/egD3qKjAl+N6PswXlg+s
         oXGP9LLZNITRitLrY99TA040yuTOjc6Nqq3ANES4DfYGHdWMQm2fnQg8MThQuEGha9es
         JUealN3+wObgipzmpSptdpvYXplH9eBTlh0EYL1/iONIyq02f9RM/O+wNCnoIUAviGpX
         JS7ZfjntkMpG5vGDNERI6nZ+l3IIzXKWC3BayqjGH5TbRHTVtKHEG77vUM6JvaaLC+jc
         yBk8ure9mD9SbAIKqrEoKWL/LM7JNYricews7T2myZ36RmP8p0Wrx82nXuPM1uFQMw6f
         CE8A==
X-Forwarded-Encrypted: i=1; AJvYcCV0NNcSO/l3tzUHsZqeX8h61VYLSvuU2VqqdroUinTJceL6Ql5JI0EoZxm5e4jkbzostEPgBiFQjz17/WIA5jafo45y8SIa28yHoBpV
X-Gm-Message-State: AOJu0YxqeYousA/ehPScqh0QVbuu99bsjEJDaoAZmPF3IpmegteH+1zL
	BwVQEmIZF1iUkXuM45/sVuM6c8MNN8dbclgrpZPdy81/5c/g+yHUJV+V3nMunib6iBL3QZyTuLV
	oU0dmKiJQK6Zs38kMG5y8vkQuQkHMbdnfW/Ez
X-Google-Smtp-Source: AGHT+IH6WxZXuaQ2KDDgVGD+4L4UibBW1FPLrkLrszFYU+BaDE+DPoJY6k+LqcB6+bN/1Z2XrXPyYRmAf8TxO71oCjM=
X-Received: by 2002:a67:fa55:0:b0:478:99a3:6fd0 with SMTP id
 j21-20020a67fa55000000b0047899a36fd0mr4023682vsq.17.1712269331896; Thu, 04
 Apr 2024 15:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404162515.527802-1-fvdl@google.com> <20240404162515.527802-2-fvdl@google.com>
 <e74cfee3-565f-4c69-bb7b-bdd40d01d212@redhat.com> <CAPTztWbpDizLVk14jfxtS8mzQo3KvR+3KHiAiksxCXo=SQ4HrQ@mail.gmail.com>
In-Reply-To: <CAPTztWbpDizLVk14jfxtS8mzQo3KvR+3KHiAiksxCXo=SQ4HrQ@mail.gmail.com>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 4 Apr 2024 15:22:00 -0700
Message-ID: <CAPTztWbeikpcm7QYqAdYrfqr_Zea=L9qGjS7mieWhC+2ZGucgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to cma_declare_contiguous_nid
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:44=E2=80=AFPM Frank van der Linden <fvdl@google.co=
m> wrote:
>
> On Thu, Apr 4, 2024 at 1:13=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 04.04.24 18:25, Frank van der Linden wrote:
> > > The hugetlb_cma code passes 0 in the order_per_bit argument to
> > > cma_declare_contiguous_nid (the alignment, computed using the
> > > page order, is correctly passed in).
> > >
> > > This causes a bit in the cma allocation bitmap to always represent
> > > a 4k page, making the bitmaps potentially very large, and slower.
> > >
> > > So, correctly pass in the order instead.
> > >
> > > Signed-off-by: Frank van der Linden <fvdl@google.com>
> > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugep=
ages using cma")
> >
> > It might be subopimal, but do we call it a "BUG" that needs "fixing". I
> > know, controversial :)
> >
> > > ---
> > >   mm/hugetlb.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 23ef240ba48a..6dc62d8b2a3a 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -7873,9 +7873,9 @@ void __init hugetlb_cma_reserve(int order)
> > >                * huge page demotion.
> > >                */
> > >               res =3D cma_declare_contiguous_nid(0, size, 0,
> > > -                                             PAGE_SIZE << HUGETLB_PA=
GE_ORDER,
> > > -                                              0, false, name,
> > > -                                              &hugetlb_cma[nid], nid=
);
> > > +                                     PAGE_SIZE << HUGETLB_PAGE_ORDER=
,
> > > +                                     HUGETLB_PAGE_ORDER, false, name=
,
> > > +                                     &hugetlb_cma[nid], nid);
> > >               if (res) {
> > >                       pr_warn("hugetlb_cma: reservation failed: err %=
d, node %d",
> > >                               res, nid);
> >
> > ... I'm afraid this is not completely correct.
> >
> > For example, on arm64, HUGETLB_PAGE_ORDER is essentially PMD_ORDER.
> >
> > ... but we do support smaller hugetlb sizes than that (cont-pte hugetlb
> > size is 64 KiB, not 2 MiB -- PMD -- on a 4k kernel)
>
> Right,  smaller hugetlb page sizes exist. But, the value here is not
> intended to represent the minimum hugetlb page size - it's the minimum
> hugetlb page size that we can demote a CMA-allocated hugetlb page to.
> See:
>
> a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to CMA")
>
> So, this just restricts demotion of the gigantic, CMA-allocated pages
> to HUGETLB_PAGE_ORDER-sized chunks.
>
> - Frank

Just to clarify what I'm saying here: the restriction of the size you
can demote a CMA-allocated gigantic page to was already there, my
patch doesn't change anything in that regard.

