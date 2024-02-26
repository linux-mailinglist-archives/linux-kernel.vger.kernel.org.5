Return-Path: <linux-kernel+bounces-81529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5070867723
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947E91F23D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D5712AADA;
	Mon, 26 Feb 2024 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M00khUpl"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CA12A146
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955234; cv=none; b=kA7R1rWYSaeDj0gv6eY5FKhB4pf5x1ssAhUNbADC7Tfu2fgYRhXCMA8yexlYkOviZqHWO6o+35UBfIHVsW6pjNLvpccwKf9jGUkzqSIkFUmgqDX8PDcEA/fYGWNQBBjOgTNGBpgCXt95SGcgQmURD1oQV9ZmWwthllzs+JCldjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955234; c=relaxed/simple;
	bh=YfrokfUsybNY74MtugqEcnTyIb7t+vGl7tW9pWrAewY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIdLV66ov8oPaDip2RQye4GuvZ0AmzlNimxMTH4gBnDIcdptuPq6N//p4U7CQSVy2Zi3QIM9EV+01MtH1JPbMPE31wQ+hERmiJClHSq0wwlUM60pjb2yWpBlfS2KiuY4ImjpexXED6qpqWtTzC4Nz1FpLJd2vslkmgt93p+P3n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M00khUpl; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-607e54b6cf5so20602347b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708955232; x=1709560032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3VNu3jbt2E2dPwyMwWXLjmnd7lyq2z8eAe3tEfU6WA=;
        b=M00khUplfsDX+0HrTs0wwASLK9eckclBujIbeZqxIYPV/HVRT/KhAk8s5QbWmM7oyi
         NDqzbC7rH5uC6WxF+pZPHLWouLPYIY4ZsWrTbA0KM/8vmxlWSpWPkDKhxb+ttVZA/+zF
         Nq4/REQ/mRjnHIHHfE57Jhwhu7tSPgVtREJ8qn4mpB1C2S1tCdP2pMUrTkfUt3UTKhCE
         vqKTz1dCWKiY1HZUiUVku9EEx6B5qHLqWKvEIY6/SqxytiB3O3m9Cr+L1x+Aamq9FJMj
         1l0Hc/t+l/t8B+G7kmQLdk7A+c3b1f2UxSpfHnRsiIt0U90uMsb2k2xPr1mNzfbXRceb
         9cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955232; x=1709560032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3VNu3jbt2E2dPwyMwWXLjmnd7lyq2z8eAe3tEfU6WA=;
        b=VqqknBW/23XaP/nme4bpYxOfDzB2ShGC/8jijEO34NNnq3RkvmFVeR/OpGnrimSw39
         NJMn1KYK3hmkqe6mA7KPYHSzwMowP2JcMPzZNd1/465IgR4OJjI/OTrYCADuzY4Os4yW
         18iuFnJtILrC5pOnzdC/Kb5wCWBROks4p8TdkgTvetDXrFXmgfz5cGfEVEpFbRz9XGIw
         qi3iuAw37fx5VOjJX3XplWlDRyP5ji44lY31kSLqfYlGDDE6zhCDl+7S7RBiQbTDgjr9
         R1Q+aYWKIoSaQ6i+FYhPJ1jO5sNpiWsTRzp7WR2vd0x7qCc59gWxfggZ2uI4bw9hroWJ
         3QeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj9B/qMVcr27kkabljXrFZ/ln72XLO8uJAxbayR9tLCDqP5tuRV8I1nuEh7VXWHgw+Xob5QSA48JM0UHNNoguagBm+Nhc9xKVkAAFq
X-Gm-Message-State: AOJu0YwQvoqviV1oeYi+LJ0DA6ITGMRmoVTcyUweZfaiYO7W1z3u/R49
	vN8SWMypc73cC9T0iSOV0VOwbHDmGdtkCA49h6U+pLPefniqm1eorYiQ3qf0C7P39P4GDys6vsr
	uZPx4TcoqzwN3WTe45G1L9dLP/x8=
X-Google-Smtp-Source: AGHT+IHVu12IKFVkB7sagqRbr02Yr/SH/2B72heqL/GYC7Lj8ZA2d9FyRXqO0S6/Xte+4CcI8bihGWkhT6PqCdJcWYM=
X-Received: by 2002:a0d:e813:0:b0:608:e551:d9e9 with SMTP id
 r19-20020a0de813000000b00608e551d9e9mr2190603ywe.16.1708955232261; Mon, 26
 Feb 2024 05:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <df416acb-d913-4e67-b810-cd991003242e@intel.com>
 <20240226083526.26002-1-ioworker0@gmail.com> <8b909691-ca53-43b9-aab1-dba3ef3577cd@arm.com>
 <517e4c23-11f8-4ded-a502-354c482c4e51@redhat.com>
In-Reply-To: <517e4c23-11f8-4ded-a502-354c482c4e51@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 26 Feb 2024 21:47:00 +0800
Message-ID: <CAK1f24nP=g3xD=3FR11Qg0V3gsrioPcDU7a+9pjPAEORLzcd3A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, fengwei.yin@intel.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	minchan@kernel.org, peterx@redhat.com, shy828301@gmail.com, 
	songmuchun@bytedance.com, wangkefeng.wang@huawei.com, zokeefe@google.com, 
	21cnbao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 9:04=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 26.02.24 13:57, Ryan Roberts wrote:
> > On 26/02/2024 08:35, Lance Yang wrote:
> >> Hey Fengwei,
> >>
> >> Thanks for taking time to review!
> >>
> >>> On Mon, Feb 26, 2024 at 10:38=E2=80=AFAM Yin Fengwei <fengwei.yin@int=
el.com> wrote:
> >>>> On Sun, Feb 25, 2024 at 8:32=E2=80=AFPM Lance Yang <ioworker0@gmail.=
com> wrote:
> >> [...]
> >>>> --- a/mm/madvise.c
> >>>> +++ b/mm/madvise.c
> >>>> @@ -676,11 +676,43 @@ static int madvise_free_pte_range(pmd_t *pmd, =
unsigned long addr,
> >>>>                 */
> >>>>                if (folio_test_large(folio)) {
> >>>>                        int err;
> >>>> +                     unsigned long next_addr, align;
> >>>>
> >>>> -                     if (folio_estimated_sharers(folio) !=3D 1)
> >>>> -                             break;
> >>>> -                     if (!folio_trylock(folio))
> >>>> -                             break;
> >>>> +                     if (folio_estimated_sharers(folio) !=3D 1 ||
> >>>> +                         !folio_trylock(folio))
> >>>> +                             goto skip_large_folio;
> >>>> +
> >>>> +                     align =3D folio_nr_pages(folio) * PAGE_SIZE;
> >>>> +                     next_addr =3D ALIGN_DOWN(addr + align, align);
> >>> There is a possible corner case:
> >>> If there is a cow folio associated with this folio and the cow folio
> >>> has smaller size than this folio for whatever reason, this change can=
't
> >>> handle it correctly.
> >>
> >> Thanks for pointing that out; it's very helpful to me!
> >> I made some changes. Could you please check if this corner case is now=
 resolved?
> >>
> >> As a diff against this patch.
> >>
> >> diff --git a/mm/madvise.c b/mm/madvise.c
> >> index bcbf56595a2e..c7aacc9f9536 100644
> >> --- a/mm/madvise.c
> >> +++ b/mm/madvise.c
> >> @@ -686,10 +686,12 @@ static int madvise_free_pte_range(pmd_t *pmd, un=
signed long addr,
> >>                      next_addr =3D ALIGN_DOWN(addr + align, align);
> >>
> >>                      /*
> >> -                     * If we mark only the subpages as lazyfree,
> >> -                     * split the large folio.
> >> +                     * If we mark only the subpages as lazyfree, or
> >> +                     * if there is a cow folio associated with this f=
olio,
> >> +                     * then split the large folio.
> >>                       */
> >> -                    if (next_addr > end || next_addr - addr !=3D alig=
n)
> >> +                    if (next_addr > end || next_addr - addr !=3D alig=
n ||
> >> +                        folio_total_mapcount(folio) !=3D folio_nr_pag=
es(folio))
> >
> > I still don't think this is correct. I think you were previously assumi=
ng that
> > if you see a page from a large folio then the whole large folio should =
be
> > contiguously mapped? This new check doesn't validate that assumption re=
liably;
> > you need to iterate through every pte to generate a batch, like David d=
oes in
> > folio_pte_batch() for this to be safe.
> >
> > An example of when this check is insufficient; let's say you have a 4 p=
age anon
> > folio mapped contiguously in a process (total_mapcount=3D4). The proces=
s is forked
> > (total_mapcount=3D8). Then each process munmaps the second 2 pages
> > (total_mapcount=3D4). In place of the munmapped 2 pages, 2 new pages ar=
e mapped.
> > Then call madvise. It's probably even easier to trigger for file-backed=
 memory
> > (I think this code path is used for both file and anon?)
>
> What would work here is using folio_pte_batch() to get how many PTEs are
> mapped *here*, then comparing the the batch size to folio_nr_pages(). If
> both match, we are mapping all subpages.

Thanks! I'll use folio_pte_batch() here in v2.

Best,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

