Return-Path: <linux-kernel+bounces-158135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93C78B1BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083921C23DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83806CDC9;
	Thu, 25 Apr 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS0GZCag"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552FC3D388
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030526; cv=none; b=l7P5HkKsoq+IXN3vEg9UMYaX94N6U9U+jZh4ZG9y5dsjyAFOqj+0t3tK7KuA+8XnqJJ7rrdo/EfV/GdHVTJ02z5zEIEDE4iAj37YH81xwOBn4cHbnfumHRdTllWuNRvB0PU7Xxm6H/LgQzL8cIi6tB/c5Df4kl6jFULLhUl3zWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030526; c=relaxed/simple;
	bh=++8VNUKGaCWOAGEffASctGXeUn0pNxKpjDzD38Ows8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DasV+ysO8H3e4Qm+iBEa5+MMsw1hyBJPvKFIx0H7NnxB9aCQ6zfyc8NtuLo3VHtnxO7P8IJblij4Tmjwx/OOJLqp8DWANVPD35URqHE06zPKzHGqY5cj3cxDflMJO6ExSungYgEYkNSPorJQJlp3T1xbLFH6TbjDLARA0Vtj6Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS0GZCag; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso773458a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714030523; x=1714635323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaaKX6CGPvrMO2CPjOuBz/J76IMH7mCKipJ4c4CyOgY=;
        b=cS0GZCagvXiW8pivu5H/bKNTwWTlbGMnrPmQP9//Pgd7cMAZEPDFc9oh9xg0xvsQm2
         FpN5AT9BJLgyEhFVxqP933G8+Jj4bKmkv/i6zIcbwKaxF+SnBqqA4dQoqdfNsc/k0Jz7
         nZhwjLkioUMEX5GJw3Ve/wUPI1AN6S1EKvupI6QKBU/Psy2Rb3Hv1W3K+pOqCAbZDkX5
         wqFYJ3ZABPDC0ZigATLyQB/pv7Te2Cl09/a4/V/8vtIEkmcJYf4fNRDcw1jQK5QpZMb/
         LkwGeFFtoNHSksVvlgYov6RpdExTP6OFeW3fEWZj+Cw+tc3QIq0INYShId7pSMnOFH8U
         F0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714030523; x=1714635323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaaKX6CGPvrMO2CPjOuBz/J76IMH7mCKipJ4c4CyOgY=;
        b=U4wEDd27qpOxnlnf9EmZHyksBb1KNmiWz37arQ92mTdgBv1xTp23pnHnwf3m8KAOVh
         JVM3jt8wgFCh4yRKMx/wn7vwhg7IFcPQQhUK3YAs3zTieyCnaIAHmRIQnqoI8RHrtMPp
         7dY1lWrBLmuq+LU4Z/ymS6jUwwPXKqVOwMsY11u28RrwO3gI1v4ehvtkwcCZ3j0gDaYX
         FmOpcdALq661IZxcrUpQ+Eey/LNZNkmJfN4KUqtSTDMV4KEH7r3AIrjIfDMDOn7qly6e
         Nyfoq29eRCZmvVHtRb1E+RNaFDG3HWrYubaIZOp5+v0waZEnG94CqWLiIJtT3c1Mtt1j
         WCKw==
X-Forwarded-Encrypted: i=1; AJvYcCUCDrH+Nj6ySXS5hvgPUNWSnMN/M9luyFJ85ENiJmlpEcXxp18UI/JtMeRPSk2OGWXQTR+MhVYK96k8bBLh1nAsdn4ez3Wk+bfhGZn+
X-Gm-Message-State: AOJu0YyRGEAD1l5Zvxbtk+IjWE0ThNgNeQ4jXHhXvkskd0kvGndKxtuD
	YQ2Ksyzu9oXyw5QzpZcvb++1pjJroTPu7m6uxYoP3soDaHkzuLBe99XnHrXwJQI6nduQcZg1edG
	ULRuAbAw/Zo7VYgB+AhUeR4XLed4=
X-Google-Smtp-Source: AGHT+IHJMHfgqmCZ5/YjYU7g0gUNhkA4W67823fF4Ofsrv/7vaR8b8FFWSWF8GzRHdUBBPZ4OZs83vEKr6j0mb3AwCI=
X-Received: by 2002:a50:9b5b:0:b0:56e:2e17:a3d1 with SMTP id
 a27-20020a509b5b000000b0056e2e17a3d1mr3501504edj.25.1714030522476; Thu, 25
 Apr 2024 00:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424224614.477221-1-zi.yan@sent.com> <CAK1f24mHG+CZL38CAp++9urMkciWqd0wAgyFi+QjfCTAVk3Rew@mail.gmail.com>
 <5e6bf4c6-c4a5-4be3-b203-ecc77ba4e5d9@redhat.com> <CAK1f24n3SBcMm=VrKEcMSn3VQ6qMpjE=Lg3fh3_QxFt8wtaSWQ@mail.gmail.com>
 <38205f34-88ee-4a67-bffb-ec16e9edf7ca@redhat.com>
In-Reply-To: <38205f34-88ee-4a67-bffb-ec16e9edf7ca@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Apr 2024 15:35:10 +0800
Message-ID: <CAK1f24=9FBivuce5AjoXygVoLdZ8X5evqwGPGE9iPgaFJ=__Kw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 3:29=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 25.04.24 09:27, Lance Yang wrote:
> > On Thu, Apr 25, 2024 at 3:21=E2=80=AFPM David Hildenbrand <david@redhat=
com> wrote:
> >>
> >> On 25.04.24 05:45, Lance Yang wrote:
> >>> Hey Zi,
> >>>
> >>> On Thu, Apr 25, 2024 at 6:46=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrot=
e:
> >>>>
> >>>> From: Zi Yan <ziy@nvidia.com>
> >>>>
> >>>> In __folio_remove_rmap(), a large folio is added to deferred split l=
ist
> >>>> if any page in a folio loses its final mapping. It is possible that
> >>>> the folio is unmapped fully, but it is unnecessary to add the folio
> >>>
> >>> Agreed. If a folio is fully unmapped, then that's unnecessary to add
> >>> to the deferred split list.
> >>>
> >>>> to deferred split list at all. Fix it by checking folio->_nr_pages_m=
apped
> >>>> before adding a folio to deferred split list. If the folio is alread=
y
> >>>> on the deferred split list, it will be skipped. This issue applies t=
o
> >>>> both PTE-mapped THP and mTHP.
> >>>>
> >>>> Commit 98046944a159 ("mm: huge_memory: add the missing
> >>>> folio_test_pmd_mappable() for THP split statistics") tried to exclud=
e
> >>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does =
not
> >>>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was sti=
ll
> >>>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
> >>>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
> >>>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable(=
).
> >>>> However, this miscount was present even earlier due to implementatio=
n,
> >>>> since PTEs are unmapped individually and first PTE unmapping adds th=
e THP
> >>>> into the deferred split list.
> >>>>
> >>>> With commit b06dc281aa99 ("mm/rmap: introduce
> >>>> folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-ma=
pped
> >>>> folios in one shot without causing the miscount, hence this patch.
> >>>>
> >>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>> Reviewed-by: Yang Shi <shy828301@gmail.com>
> >>>> ---
> >>>>    mm/rmap.c | 7 ++++---
> >>>>    1 file changed, 4 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>> index a7913a454028..2809348add7b 100644
> >>>> --- a/mm/rmap.c
> >>>> +++ b/mm/rmap.c
> >>>> @@ -1553,9 +1553,10 @@ static __always_inline void __folio_remove_rm=
ap(struct folio *folio,
> >>>>                    * page of the folio is unmapped and at least one =
page
> >>>>                    * is still mapped.
> >>>>                    */
> >>>> -               if (folio_test_large(folio) && folio_test_anon(folio=
))
> >>>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_p=
mdmapped)
> >>>> -                               deferred_split_folio(folio);
> >>>> +               if (folio_test_large(folio) && folio_test_anon(folio=
) &&
> >>>> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(map=
ped)) ||
> >>>> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapp=
ed)))
> >>>
> >>> Perhaps we only need to check the mapcount?
> >>>
> >>> IIUC, if a large folio that was PMD/PTE mapped is fully unmapped here=
,
> >>> then folio_mapcount() will return 0.
> >>
> >> See discussion on v1. folio_large_mapcount() would achieve the same
> >> without another folio_test_large() check, but in the context of this
> >> patch it doesn't really matter.
> >
> > Got it. Thanks for pointing that out!
> > I'll take a closer look at the discussion in v1.
>
> Forgot to add: as long as the large mapcount patches are not upstream,
> folio_large_mapcount() would be expensive. So this patch can be added
> independent of the other stuff.

Thanks for clarifying!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

