Return-Path: <linux-kernel+bounces-99959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3C1878FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81271C21676
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669E9779F1;
	Tue, 12 Mar 2024 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTInAmyR"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00217C8DD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232837; cv=none; b=i9XgKmI+QlS8BkkzGL3D+fYmRhPlAkqxtrSA6WCgHxwpNJclpOugNKMWRGtwSl+gQgkxPHbd8zIlUwpZx3dmKtsjrGIC/okLPl+h8X+0DMNsbPserBAuqvrPENeB+KeI80Mpjyv0UxI9V8VImu8prAU9vOYUFOFvXXVrx/Y1L7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232837; c=relaxed/simple;
	bh=8O6Hy3QBObMtC6gf4w2A+4tXTGqGSxu7MBPjB70npy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dn6xhbkVNFWruEqs8s9PEPFNTpslaIiWz0vKTkBgX60ZR3Pz2/vZAZ631wbDA1pHquY039q8Rk0XT9ojwpfKDY3k4Z5FCcDuwP2bi1O4hjF/JOe/g+6O0GX4VOvQeFg3dh2Bi757JXT7IwCcTObLpha4jmAKyCtt5R9Ed/As4qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTInAmyR; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4733d7040dfso371605137.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710232835; x=1710837635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKP46eG5/saPxTsFb0tVFVswud2dVG5J2Sni0MTUMQE=;
        b=fTInAmyRX1rrUvsBvArAg2nD1zlfglJ3nmKFiUKSBzzo/EHShbJlqoTu81Q0uSz8RH
         b3HQWggiMQINxVzCZntr918yOC0M688338a5WUQKIJ20F+8IXBoJLOLEUrNSrJf9eSRi
         ZxqScOHuApjBBjF8g7zM30fEh88Zt5FoLEhLZ70cFvwnXmBuC55UU5pccQwpFfsPg1g6
         w/swr8VHbpwG617Y+B2YR3wdHXw6kLxfVsvylQMl9W8+FifeIZSkK5TSKRn9SrQH/Wbi
         k/qXaSlsSwdZGeIpz5y+vC3aHQDByQqgV+oZJJ9HraZomBS9u7VtHRa6C6NE0366F6Dp
         570g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710232835; x=1710837635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKP46eG5/saPxTsFb0tVFVswud2dVG5J2Sni0MTUMQE=;
        b=Qsy8N+NqtsVPVAZIwJEdqxE+dzKMGQht/FZ4q6e7ghWrFBvYU+NLpp5hS5zT3bRXjU
         2U8ka4q2fVhOXA1rLv7jg5iHIfPd/I9zosQjjWah23UXeaqkCPO/KLuTJRfabOXM4h5z
         g34KhKFEszAvxiQCM7Zq2d6UslcxSeQm/IIZvIW8qAdRwysi7p2bg6PodDjf2Wb6gqid
         xeQqS0Frx9sL2v7UsnCGPr2uD22bKoM+UoCYDiigTbLeJ5FSRlLA7AF/Hh/wbwSlXWWR
         3ssuNSvg6e9DZzX/NnNITnkeoMJEJ1zaDCF3ZHCEXvF80tQu5h/U1HGeUqlsnCGnk32M
         UK9w==
X-Forwarded-Encrypted: i=1; AJvYcCUPHeszt0hqe9whMbSk1uADZJXUy62k7WoTbnZqIm0zIoaH2xSnCfYcrWHfPU/yj4RB8DuRWBzgqYGxcROnrKhBJ32Zbsdvrw9a5E42
X-Gm-Message-State: AOJu0YwjoR8KBznKkI/23LAizHbAqIQ8GYDS1wb+7C6kK52Mq4/TQSru
	CnUOdjVDvqtCVccsdRi/UFKcW645+GUE9ZUCLQKyQG+++CpBGjmsjrAHFWO8oQ9vDs7CNkyEepU
	YAyYKDBUmE9eEsS6F0zktBFZhMeg=
X-Google-Smtp-Source: AGHT+IEPtAgVwQ5+RwMGBe5KAm2qJ01EYqT5RmcX7DUpqLLBOsFL5WQpGQp3feejuccQRlMrt4vtgzJ8KwXkyOe6oYA=
X-Received: by 2002:a67:ce92:0:b0:471:e032:8c8b with SMTP id
 c18-20020a67ce92000000b00471e0328c8bmr5545892vse.12.1710232834868; Tue, 12
 Mar 2024 01:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-6-ryan.roberts@arm.com> <CAGsJ_4zq4jdDdG6Cne6SESSmJQJnGwaQF5y3BHOaLHFdED0zYg@mail.gmail.com>
 <b9200ea1-c555-40c0-b748-c449ac6bebc2@arm.com>
In-Reply-To: <b9200ea1-c555-40c0-b748-c449ac6bebc2@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 12 Mar 2024 21:40:24 +1300
Message-ID: <CAGsJ_4wXDGBKjuTv8-_hk2F3TKKfeuy4O1Tj8_v4rxqDz++uWg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:12=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 11/03/2024 22:30, Barry Song wrote:
> > On Mon, Mar 11, 2024 at 11:01=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
com> wrote:
> >>
> >> Now that swap supports storing all mTHP sizes, avoid splitting large
> >> folios before swap-out. This benefits performance of the swap-out path
> >> by eliding split_folio_to_list(), which is expensive, and also sets us
> >> up for swapping in large folios in a future series.
> >>
> >> If the folio is partially mapped, we continue to split it since we wan=
t
> >> to avoid the extra IO overhead and storage of writing out pages
> >> uneccessarily.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  mm/vmscan.c | 9 +++++----
> >>  1 file changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index cf7d4cf47f1a..0ebec99e04c6 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct l=
ist_head *folio_list,
> >>                                         if (!can_split_folio(folio, NU=
LL))
> >>                                                 goto activate_locked;
> >>                                         /*
> >> -                                        * Split folios without a PMD =
map right
> >> -                                        * away. Chances are some or a=
ll of the
> >> -                                        * tail pages can be freed wit=
hout IO.
> >> +                                        * Split partially mapped foli=
os map
> >> +                                        * right away. Chances are som=
e or all
> >> +                                        * of the tail pages can be fr=
eed
> >> +                                        * without IO.
> >>                                          */
> >> -                                       if (!folio_entire_mapcount(fol=
io) &&
> >> +                                       if (!list_empty(&folio->_defer=
red_list) &&
> >
> > Hi Ryan,
> > After reconsidering our previous discussion about PMD-mapped large
> > folios, I've pondered
> > the possibility of PMD-mapped Transparent Huge Pages (THPs) being
> > mapped by multiple
> > processes. In such a scenario, if one process decides to unmap a
> > portion of the folio while
> > others retain the entire mapping, it raises questions about how the
> > system should handle
> > this situation. Would the large folio be placed in a deferred list?
>
> No - if the large folio is entirely mapped (via PMD), then the folio will=
 not be
> put on the deferred split list in the first place. See __folio_remove_rma=
p():
>
>         last =3D (last < ENTIRELY_MAPPED);
>
> means that nr will never be incremented above 0. (_nr_pages_mapped is
> incremented by ENTIRELY_MAPPED for every PMD map).

you are right, I missed this part, we are breaking early in RMAP_LEVEL_PTE.
so we won't get to if (nr). Thanks for your clarification. now we get
unified code
for both pmd-mapped and pte-mapped large folios. feel free to add,

Reviewed-by: Barry Song <v-songbaohua@oppo.com>

>
> > If
> > so, splitting it might not
> > yield benefits, as neither I/O nor swap slots would increase in this
> > case by not splitting it.
> >
> > Regarding PTE-mapped large folios, the absence of an indicator like
> > "entire_map" makes it
> > challenging to identify cases where the entire folio is mapped. Thus,
> > splitting seems to be
> > the only viable solution in such circumstances.
> >
> >>                                             split_folio_to_list(folio,
> >>                                                                 folio_=
list))
> >>                                                 goto activate_locked;
> >> --
> >> 2.25.1
>

Thanks
Barry

