Return-Path: <linux-kernel+bounces-91333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8542870FA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F271C21D07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BD379950;
	Mon,  4 Mar 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNOtP+LN"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D946BA0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589487; cv=none; b=MO1CmOrJ4ntHFqZeEXLhk9LlTyxgirEk0J8sOvvad3ENHG+kt/MUuEZNMnpg8UJGGIdvg4q7gGLMQHrxA1NGSKLoW1K98RO/nB0VW7T+lELmOm0gvIw9iS7B748mmQ4IaEBbjKu3j4SqgPh1+E07wCdTEGZOiNkBElpxB8qhIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589487; c=relaxed/simple;
	bh=sn/Na6APvSpDPJTu5dE21znedniJ8b9aLdy/sUge760=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3izQjK014vErJsd9dlexHGbhgfTPMvNxC/pqf27MSkyGAyrNPU1whsgTlzbEqBJMCX5XM3ULHsgs2AlgKRZpHBEC+IqRSXovrk5LQcbSzWJ5pB3fI2AEtpOYN0M7D9CiIo+TSov/HG5KWZB0ysr/55uja1STK1EPDeWZ9fmRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNOtP+LN; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d5cbc4a585so1981845241.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709589484; x=1710194284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqoBwlFjrEGlkxzScTIHxrhFsM9u6GTewCZPhOqLJRc=;
        b=LNOtP+LNiZVz6z4qj0fbVg0bhw3YdO6qXh0yPSVPOWnc0c9aOe2dhy4iX8JDTT2QA8
         fMdaAmMymnr28LSvqeIuL+/+KdBGHkGbA3cQuBjwAkFC7gn+DDtZWJd+6OOi6vUr0puf
         9HFSU4VhetlXxphphMEQ51kFKiKD1S1T8n1iqDfhx1fIrJTuYtlVSS2dKzSo0WZMFneB
         V0CUwb5ZPdoUsXzyAU0DSn8PvgcR+uK8ph7/d4Zsij5+lXlgzO8spNCEhmR/VBRvsCsc
         BMqPalIRoc0AqKO9hCz/uE+BEq0H9PhjowJeubAkT51CKpEoz9p+m2tPswPV5zrJ3+Df
         +VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709589484; x=1710194284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqoBwlFjrEGlkxzScTIHxrhFsM9u6GTewCZPhOqLJRc=;
        b=KeBW91b4ZkXru5SQOXoFaGGs6QG7YnQm0ybgMANBhurtAIyR2mMv+pxPo09pS8acbE
         pqrxpwroE2x1sncSISJDeLLHWcwfqO9IWjw4FvDlO/0Mdlk6CoZX9gMEUB+QOg000zKU
         TYhkeo365gpghJNS+X6pJywImwicKgaLR/kpWH2EWU2QkbjXdQplQkYd5pi++TnireuO
         XDLim3IiElg8TXeO3fHW8/o5YCTBN9RVq1m/3NAfomKwEUYJP3rY6ZC4DI1mH/9o0vDT
         e1TWzFuChUrRPwh5XBi1o/lqnVrpJvEoVNhKbJzY1SnMjMKyON/4e9O15C69SmeyMR/m
         gNdw==
X-Forwarded-Encrypted: i=1; AJvYcCUSEzl2iRfa/tZTuL9eZEodnUj8eBY92NnniQv6/QbjsuawjtyL7TDWV0QL3eCHi7Xv3qkTU5C2QRljBox0PMVFUg9J8Vum+tNci1dn
X-Gm-Message-State: AOJu0YzCFMTE3KRmTVKBRLdZLXmvZCWcTTVSfCQi81thrz+P0XUjujWJ
	spDPLRO50GV0++m/kmyCaOLWDHwCFz35Wj/hDLZX7UsoekEeRJEuTnNSO2PqqliT0z3IEArPUkF
	bGBa3NDP34Q+3UQVfdGJmwJjldSE=
X-Google-Smtp-Source: AGHT+IFJylADP6V6ydrpu37OvmzYZGm3wMHZcijXhFmQ+Oi+Looal8ewdWIErgxOYA/rF/J9DUIr549t5Eh3HSk459c=
X-Received: by 2002:a05:6102:d8c:b0:472:cc6a:5dd8 with SMTP id
 d12-20020a0561020d8c00b00472cc6a5dd8mr71679vst.3.1709589483176; Mon, 04 Mar
 2024 13:58:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
In-Reply-To: <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 10:57:51 +1300
Message-ID: <CAGsJ_4wx7oSzt4vn6B+LRoZetMhH-fDXRFrCFRyoqVOakLidjg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@redhat.com, 
	chrisl@kernel.org, yuzhao@google.com, hanchuanhua@oppo.com, 
	linux-kernel@vger.kernel.org, willy@infradead.org, ying.huang@intel.com, 
	xiang@kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:21=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> Hi Barry,
>
> On 04/03/2024 10:37, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > page_vma_mapped_walk() within try_to_unmap_one() races with other
> > PTEs modification such as break-before-make, while iterating PTEs
> > of a large folio, it will only begin to acquire PTL after it gets
> > a valid(present) PTE. break-before-make intermediately sets PTEs
> > to pte_none. Thus, a large folio's PTEs might be partially skipped
> > in try_to_unmap_one().
>
> I just want to check my understanding here - I think the problem occurs f=
or
> PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large folio=
s? Now
> that I've had a look at the code and have a better understanding, I think=
 that
> must be the case? And therefore this problem exists independently of my w=
ork to
> support swap-out of mTHP? (From your previous report I was under the impr=
ession
> that it only affected mTHP).

I think this affects all large folios with PTEs entries more than 1. but hu=
geTLB
is handled as a whole in try_to_unmap_one and its rmap is removed all
together, i feel hugeTLB doesn't have this problem.

>
> Its just that the problem is becoming more pronounced because with mTHP,
> PTE-mapped large folios are much more common?

right. as now large folios become a more common case, and it is my case
running in millions of phones.

BTW, I feel we can somehow learn from hugeTLB, for example, we can reclaim
all PTEs all together rather than iterating PTEs one by one. This will impr=
ove
performance. for example, a batched
set_ptes_to_swap_entries()
{
}
then we only need to loop once for a large folio, right now we are looping
nr_pages times.

>
> > For example, for an anon folio, after try_to_unmap_one(), we may
> > have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries.
> > So folio will be still mapped, the folio fails to be reclaimed.
> > What=E2=80=99s even more worrying is, its PTEs are no longer in a unifi=
ed
> > state. This might lead to accident folio_split() afterwards. And
> > since a part of PTEs are now swap entries, accessing them will
> > incur page fault - do_swap_page.
> > It creates both anxiety and more expense. While we can't avoid
> > userspace's unmap to break up unified PTEs such as CONT-PTE for
> > a large folio, we can indeed keep away from kernel's breaking up
> > them due to its code design.
> > This patch is holding PTL from PTE0, thus, the folio will either
> > be entirely reclaimed or entirely kept. On the other hand, this
> > approach doesn't increase PTL contention. Even w/o the patch,
> > page_vma_mapped_walk() will always get PTL after it sometimes
> > skips one or two PTEs because intermediate break-before-makes
> > are short, according to test. Of course, even w/o this patch,
> > the vast majority of try_to_unmap_one still can get PTL from
> > PTE0. This patch makes the number 100%.
> > The other option is that we can give up in try_to_unmap_one
> > once we find PTE0 is not the first entry we get PTL, we call
> > page_vma_mapped_walk_done() to end the iteration at this case.
> > This will keep the unified PTEs while the folio isn't reclaimed.
> > The result is quite similar with small folios with one PTE -
> > either entirely reclaimed or entirely kept.
> > Reclaiming large folios by holding PTL from PTE0 seems a better
> > option comparing to giving up after detecting PTL begins from
> > non-PTE0.
> >
> > Cc: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>
> Do we need a Fixes tag?

I don't feel a strong need for this as this doesn't cause a crash, memory
leak or whatever serious.

>
> > ---
> >  mm/vmscan.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 0b888a2afa58..e4722fbbcd0c 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1270,6 +1270,17 @@ static unsigned int shrink_folio_list(struct lis=
t_head *folio_list,
> >
> >                       if (folio_test_pmd_mappable(folio))
> >                               flags |=3D TTU_SPLIT_HUGE_PMD;
> > +                     /*
> > +                      * if page table lock is not held from the first =
PTE of
> > +                      * a large folio, some PTEs might be skipped beca=
use of
> > +                      * races with break-before-make, for example, PTE=
s can
> > +                      * be pte_none intermediately, thus one or more P=
TEs
> > +                      * might be skipped in try_to_unmap_one, we might=
 result
> > +                      * in a large folio is partially mapped and parti=
ally
> > +                      * unmapped after try_to_unmap
> > +                      */
> > +                     if (folio_test_large(folio))
> > +                             flags |=3D TTU_SYNC;
>
> This looks sensible to me after thinking about it for a while. But I also=
 have a
> gut feeling that there might be some more subtleties that are going over =
my
> head, since I'm not expert in this area. So will leave others to provide =
R-b :)
>

ok, thanks :-)

> Thanks,
> Ryan
>
> >
> >                       try_to_unmap(folio, flags);
> >                       if (folio_mapped(folio)) {
>

Thanks
Barry

