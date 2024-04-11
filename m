Return-Path: <linux-kernel+bounces-141653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EEF8A2138
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EE8283673
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2823B182;
	Thu, 11 Apr 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFrZS9bD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D21865A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872761; cv=none; b=icUVobowW5ACxnBz9TRHyM3mWs1fOFcmTblxnc65XTt/NTennlBNNRFJXSTD2ZiZg0TMGzbKLn1s9wXz0t3heJ1HcMSEuKGchDAmTYZmu1vvSFiUJRzMKRebAixcjNihHInhPWfB/uEJVkTTQczPAhJZdJ1HjrVM1rnTBK3vA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872761; c=relaxed/simple;
	bh=ULHaS3HYHzzVFeQkzdYMbdDl69FrvK58JGZl45LqbXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C43VaiW06zPG/d/b3rk3yChBTrSnqJbXr68/B/7Pzx6aaz5L4arOqL1JDUawU+VckKpSffF2enuLg/mjQt9jw//3Rq0WBcIinS2qF6ljhLjME9SFWhqNXL0C5Er+ZsrHu0Qv0h9RawKROm0prfd5eq8SteSBhXIVcCBKTMgfEP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFrZS9bD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516c403cc46so667092e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712872758; x=1713477558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATjB4IMVnw3WXwF1N9IZiesyfgmls8vjWPpfZttEQvA=;
        b=eFrZS9bDLCcOR6Fc+Ago7qfdQWZAI3VKgr8NXIYgj9VJdoQe21ACtVdWCQzarmp0U7
         7JzCZOF8Q7opxaG+4J4RtZpBpeNlgZFMnhzaFuNfOR3RBa/lxG08lvZq/49c6VjHJ4jQ
         /11wsXh/5bXV6ImMXjl05rQn+bF216SoCwZlt5i9ywyCUCzpKmqJaU2v0v2L6EYoSy2V
         zvA3cTs3mbUW8Ue5pRpx7Kcz0IuKBg5oGojaNk7LlR9apmJAumAdlZzFKHa+0mrJY23Q
         DKTO4dqvzTXQTepJ84M6TSPMoxa1Wh+oQ9w5joiGsQmzksCIrEaQIjhTcaH2Ut6nFSNr
         U1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712872758; x=1713477558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATjB4IMVnw3WXwF1N9IZiesyfgmls8vjWPpfZttEQvA=;
        b=bFAGdEHUsQviWWnfRoKWYWq4Cj99/0MT9Kx8UnOMtpQVnHLZDMusa5KCUqERrmVWmy
         r0KFyWT0U5F9EQ7XGd/2/eCz9W59wFLPhqIQJoo6yc0OQ0JR6kjTt4E5h2uAnmx1y+JD
         Mms1SRE48nmwNu487vAwSQ29W520kjg3H6x/Jmix5B4UTd9vPSZng4qw39YbeYxOTx+9
         Y3yPHgoZr4YYOqXwwX2OxtN55XAJkYo0gy9wRdqh7Pre8ur/aS9VrjZO78gdy5e5Tu/X
         zGkAOfEp0W/tyDgIFNctDwPlu1uCeruvokSZEDGjf3q4GKkkGEmy2mNXM2zk428Pqigk
         o0uw==
X-Forwarded-Encrypted: i=1; AJvYcCVHg5jXMfjSEzLRKeYuoLp8vb0wXEhWNIzpd55NVFd9mm27pJ0stlh7niJ1ie+J2bwpmgaSHVJf0TtxDMyHSQqJBUC6hkN7GXT69rmm
X-Gm-Message-State: AOJu0YzV2WTr4D3u/7xLFF32Ppy49pUr+6ijIMjiz3kjoLDaCG8afn15
	a/gC66+D/LRHsk38i9kacei3OwbWVqArpXVo8lZX17R6iFhlGiCIa7Ncexk6ZhdvLz6hCkx+I1Y
	pCFr1XVG5NlPeL/456wtGBpXk0hQ=
X-Google-Smtp-Source: AGHT+IGXq3eeVHYDDYQQGHpXeCy56vyTljtgTLUXn3P7uFG8swKtVBa66Qk7DjBVP3Cn4ENsWxWsp6BzqPcoBSot6qI=
X-Received: by 2002:ac2:4dad:0:b0:516:d09b:cbe4 with SMTP id
 h13-20020ac24dad000000b00516d09bcbe4mr704337lfe.53.1712872757355; Thu, 11 Apr
 2024 14:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411153232.169560-1-zi.yan@sent.com> <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <CAHbLzkr99knWKZvE4WCWKKr=eezkg89idpE59oo_oBneAQynAA@mail.gmail.com> <86722546-1d54-4224-9f31-da4f368cd47e@redhat.com>
In-Reply-To: <86722546-1d54-4224-9f31-da4f368cd47e@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 11 Apr 2024 14:59:05 -0700
Message-ID: <CAHbLzkrxR_cpVd_KF1rz9CTVmr4q0KX7T=SseOo8X5u23-5ZJQ@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 2:15=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 11.04.24 21:01, Yang Shi wrote:
> > On Thu, Apr 11, 2024 at 8:46=E2=80=AFAM David Hildenbrand <david@redhat=
com> wrote:
> >>
> >> On 11.04.24 17:32, Zi Yan wrote:
> >>> From: Zi Yan <ziy@nvidia.com>
> >>>
> >>> In __folio_remove_rmap(), a large folio is added to deferred split li=
st
> >>> if any page in a folio loses its final mapping. It is possible that
> >>> the folio is unmapped fully, but it is unnecessary to add the folio
> >>> to deferred split list at all. Fix it by checking folio mapcount befo=
re
> >>> adding a folio to deferred split list.
> >>>
> >>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>> ---
> >>>    mm/rmap.c | 9 ++++++---
> >>>    1 file changed, 6 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>> index 2608c40dffad..d599a772e282 100644
> >>> --- a/mm/rmap.c
> >>> +++ b/mm/rmap.c
> >>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
> >>>                enum rmap_level level)
> >>>    {
> >>>        atomic_t *mapped =3D &folio->_nr_pages_mapped;
> >>> -     int last, nr =3D 0, nr_pmdmapped =3D 0;
> >>> +     int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
> >>>        enum node_stat_item idx;
> >>>
> >>>        __folio_rmap_sanity_checks(folio, page, nr_pages, level);
> >>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
> >>>                        break;
> >>>                }
> >>>
> >>> -             atomic_sub(nr_pages, &folio->_large_mapcount);
> >>> +             mapcount =3D atomic_sub_return(nr_pages,
> >>> +                                          &folio->_large_mapcount) +=
 1;
> >>
> >> That becomes a new memory barrier on some archs. Rather just re-read i=
t
> >> below. Re-reading should be fine here.
> >>
> >>>                do {
> >>>                        last =3D atomic_add_negative(-1, &page->_mapco=
unt);
> >>>                        if (last) {
> >>> @@ -1554,7 +1555,9 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
> >>>                 * is still mapped.
> >>>                 */
> >>>                if (folio_test_large(folio) && folio_test_anon(folio))
> >>> -                     if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmdm=
apped)
> >>> +                     if ((level =3D=3D RMAP_LEVEL_PTE &&
> >>> +                          mapcount !=3D 0) ||
> >>> +                         (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmd=
mapped))
> >>>                                deferred_split_folio(folio);
> >>>        }
> >>
> >> But I do wonder if we really care? Usually the folio will simply get
> >> freed afterwards, where we simply remove it from the list.
> >>
> >> If it's pinned, we won't be able to free or reclaim, but it's rather a
> >> corner case ...
> >>
> >> Is it really worth the added code? Not convinced.
> >
> > It is actually not only an optimization, but also fixed the broken
> > thp_deferred_split_page counter in /proc/vmstat.
> >
> > The counter actually counted the partially unmapped huge pages (so
> > they are on deferred split queue), but it counts the fully unmapped
> > mTHP as well now. For example, when a 64K THP is fully unmapped, the
> > thp_deferred_split_page is not supposed to get inc'ed, but it does
> > now.
> >
> > The counter is also useful for performance analysis, for example,
> > whether a workload did a lot of partial unmap or not. So fixing the
> > counter seems worthy. Zi Yan should have mentioned this in the commit
> > log.
>
> Yes, all that is information that is missing from the patch description.
> If it's a fix, there should be a "Fixes:".
>
> Likely we want to have a folio_large_mapcount() check in the code below.
> (I yet have to digest the condition where this happens -- can we have an
> example where we'd use to do the wrong thing and now would do the right
> thing as well?)

For example, map 1G memory with 64K mTHP, then unmap the whole 1G or
some full 64K areas, you will see thp_deferred_split_page increased,
but it shouldn't.

It looks __folio_remove_rmap() incorrectly detected whether the mTHP
is fully unmapped or partially unmapped by comparing the number of
still-mapped subpages to ENTIRELY_MAPPED, which should just work for
PMD-mappable THP.

However I just realized this problem was kind of workaround'ed by commit:

commit 98046944a1597f3a02b792dbe9665e9943b77f28
Author: Baolin Wang <baolin.wang@linux.alibaba.com>
Date:   Fri Mar 29 14:59:33 2024 +0800

    mm: huge_memory: add the missing folio_test_pmd_mappable() for THP
split statistics

    Now the mTHP can also be split or added into the deferred list, so add
    folio_test_pmd_mappable() validation for PMD mapped THP, to avoid
    confusion with PMD mapped THP related statistics.

    Link: https://lkml.kernel.org/r/a5341defeef27c9ac7b85c97f030f93e4368bbc=
1.1711694852.git.baolin.wang@linux.alibaba.com
    Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
    Acked-by: David Hildenbrand <david@redhat.com>
    Cc: Muchun Song <muchun.song@linux.dev>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

This commit made thp_deferred_split_page didn't count mTHP anymore, it
also made thp_split_page didn't count mTHP anymore.

However Zi Yan's patch does make the code more robust and we don't
need to worry about the miscounting issue anymore if we will add
deferred_split_page and split_page counters for mTHP in the future.

> --
> Cheers,
>
> David / dhildenb
>

