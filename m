Return-Path: <linux-kernel+bounces-91980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D2871956
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9121C227E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4252E52F6F;
	Tue,  5 Mar 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK6s8/Mj"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5A524C9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630119; cv=none; b=RIwaSQbQteJ8TzYD4TJU+RQvISBX+jyCdRVEcPrdqFJkUpHx92gVqyHWogvt+Qskd/F0KBc80cYu0j2xikNdGchK4oxQOj+61jIkIeGBS3rxDGHtsL0IBsKFBkuDjv9tuLNVdG//PMZrCCBKC3SA53baaECMUS65DyDE7pbvP4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630119; c=relaxed/simple;
	bh=tN5CB3ET9UzZDMAy3wgdr5vipfJkhH6/9PsJIfKdbl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0YSU1QDTHxmHA+5jF0TxfL4vPVPEl1JEmYRRSpCN2vro+hdxpNWmeChZZLlJVt2wbKzH6LsfsEqY97ThrwB5VnlcmmcTZD/kYgxp3762vAVuvYgJHzOlA6qVNXwtxey8tTqmswee70CVflXSKHAZqtEuOT3AXvUvyJRnnaq6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK6s8/Mj; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4d3857240a7so425439e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709630116; x=1710234916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFy/rhDqRjl/7+RRY4ULRREu+YI2oDuY7n8pNvXEX6E=;
        b=VK6s8/MjZKS+RBkVVtBavoL5sWk6nnLBoSBj+fuUF2GIaijBE9ihTGgZSbZTNFaiHS
         DepTTbCO7NOS4RmW91jN0NcuEGFQSES/8I2cn2IDQqvixeF7pkGZZ8EOI/n8Vp4gaLAl
         kz5lVG13o/hEo3yAYwiNDI0TNXDlS1+T9smmEIpy4mufg9gDym9NhQnhw0IUN0FTcnhs
         FxDW+XGSlYhZBzkRah+ehE9xU/LxTLpGxq6TUxrBkNxXiF55Lv7tirIsRgULTjiOvMR8
         0Uwcv1QaVMfBV723XtYz7PVDkfk9x9cvb2E8+yrSEdsMWe3BKTLLbCiAYO1fErptJOwx
         1CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630116; x=1710234916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFy/rhDqRjl/7+RRY4ULRREu+YI2oDuY7n8pNvXEX6E=;
        b=qMzI3Y2Z812PEHd2BqCBYCVQGtTxaz3RnneOLfa1v0QjmTtLoZNmBibjit/chEuy5w
         PS3z1/MuxJM7qHF434eFxD+DYo+hlUlIiEEF7bjNf4FWusSezWSCOwe8F4raBNxjFaQf
         Coysg0kyAd8E2ApNxQ7Fgmy9Vg21Oy6I+2xnK79EmI9iByMYzwW15an9ljgIhBCKnFRM
         PKp/mbwal51NPDk7DlqGU6RUPP2PKwbFY6AjG0AWH9RywcfbiCGEFJKsXrEi4mlWmlhK
         szZ9Yur12i7mEuN1DB1owRR8HSJyC4NFRvrELZNsPdDwL6RL1r9ZknB5nHiELakSfOFs
         EkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVctR29227t1yFow8YX6jXmfGUpVoRfrmdsx0AT/3GFyvvjOGDdVf7uUoQAXaqxkhdk24NqSvtjVIlrhiN3RYIatoL3Q+NJCaipx9C/
X-Gm-Message-State: AOJu0YzdRkyHBFXHmyo7rT3RpyBf0wB3mqBjTeCanx+RF1nxQPf44J7K
	SX4yHWbU8oLRIKQk+fmljcfWRiaDoxzp9QqFIW/VS4x+tRpYSg77b8qoN6xzWrlTZJyMQMBXzM2
	/btTihNTJlHZfgOy7AuHxk2zHi9U=
X-Google-Smtp-Source: AGHT+IFKK6p0mlckr4RGREpNVh9sVck6+RrZOAt2murQmvxEgMevlA6APsHEhaukGn4f+zmpG9hyH+5q5dVzIyqd+uw=
X-Received: by 2002:a05:6122:1d94:b0:4d3:37d1:5a70 with SMTP id
 gg20-20020a0561221d9400b004d337d15a70mr1270858vkb.7.1709630116640; Tue, 05
 Mar 2024 01:15:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <CAGsJ_4wx7oSzt4vn6B+LRoZetMhH-fDXRFrCFRyoqVOakLidjg@mail.gmail.com>
 <e5e14ef9-1bd2-45a8-818d-e92910e97f8f@arm.com> <CAGsJ_4xtVhka9J3c6zDySBEJ34+mn9OLiuP0JJ+Ag+p9n9K5EA@mail.gmail.com>
 <0a644230-f7a8-4091-9d00-ded6c8c3fc19@arm.com>
In-Reply-To: <0a644230-f7a8-4091-9d00-ded6c8c3fc19@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 22:15:05 +1300
Message-ID: <CAGsJ_4woFHT3eLzQ+Dg2dAUMve=wd=0SEZfZ4NqLyBVqeskkVg@mail.gmail.com>
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

On Tue, Mar 5, 2024 at 10:11=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 05/03/2024 09:08, Barry Song wrote:
> > On Tue, Mar 5, 2024 at 9:54=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> On 04/03/2024 21:57, Barry Song wrote:
> >>> On Tue, Mar 5, 2024 at 1:21=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
com> wrote:
> >>>>
> >>>> Hi Barry,
> >>>>
> >>>> On 04/03/2024 10:37, Barry Song wrote:
> >>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>
> >>>>> page_vma_mapped_walk() within try_to_unmap_one() races with other
> >>>>> PTEs modification such as break-before-make, while iterating PTEs
> >>>>> of a large folio, it will only begin to acquire PTL after it gets
> >>>>> a valid(present) PTE. break-before-make intermediately sets PTEs
> >>>>> to pte_none. Thus, a large folio's PTEs might be partially skipped
> >>>>> in try_to_unmap_one().
> >>>>
> >>>> I just want to check my understanding here - I think the problem occ=
urs for
> >>>> PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large =
folios? Now
> >>>> that I've had a look at the code and have a better understanding, I =
think that
> >>>> must be the case? And therefore this problem exists independently of=
 my work to
> >>>> support swap-out of mTHP? (From your previous report I was under the=
 impression
> >>>> that it only affected mTHP).
> >>>
> >>> I think this affects all large folios with PTEs entries more than 1. =
but hugeTLB
> >>> is handled as a whole in try_to_unmap_one and its rmap is removed all
> >>> together, i feel hugeTLB doesn't have this problem.
> >>>
> >>>>
> >>>> Its just that the problem is becoming more pronounced because with m=
THP,
> >>>> PTE-mapped large folios are much more common?
> >>>
> >>> right. as now large folios become a more common case, and it is my ca=
se
> >>> running in millions of phones.
> >>>
> >>> BTW, I feel we can somehow learn from hugeTLB, for example, we can re=
claim
> >>> all PTEs all together rather than iterating PTEs one by one. This wil=
l improve
> >>> performance. for example, a batched
> >>> set_ptes_to_swap_entries()
> >>> {
> >>> }
> >>> then we only need to loop once for a large folio, right now we are lo=
oping
> >>> nr_pages times.
> >>
> >> You still need a pte-pte loop somewhere. In hugetlb's case it's in the=
 arch
> >> implementation. HugeTLB ptes are all a fixed size for a given VMA, whi=
ch makes
> >> things a bit easier too, whereas in the regular mm, they are now a var=
iable size.
> >>
> >> David and I introduced folio_pte_batch() to help gather batches of pte=
s, and it
> >> uses the contpte bit to avoid iterating over intermediate ptes. And I'=
m adding
> >> swap_pte_batch() which does a similar thing for swap entry batching in=
 v4 of my
> >> swap-out series.
> >>
> >> For your set_ptes_to_swap_entries() example, I'm not sure what it woul=
d do other
> >> than loop over the PTEs setting an incremented swap entry to each one?=
 How is
> >> that more performant?
> >
> > right now, while (page_vma_mapped_walk(&pvmw)) will loop nr_pages for e=
ach
> > PTE, if each PTE, we do lots of checks within the loop.
> >
> > by implementing set_ptes_to_swap_entries(), we can iterate once for
> > page_vma_mapped_walk(), after folio_pte_batch() has confirmed
> > the large folio is completely mapped, we set nr_pages swap entries
> > all together.
> >
> > we are replacing
> >
> > for(i=3D0;i<nr_pages;i++)     /* page_vma_mapped_walk */
> > {
> >         lots of checks;
> >         clear PTEn
> >         set PTEn to swap
> > }
>
> OK so you are effectively hoisting "lots of checks" out of the loop?

no. page_vma_mapped_walk returns nr_pages times. We are doing
same check each time.  Each time, we do tlbi and set one PTE.

>
> >
> > by
> >
> > if (large folio && folio_pte_batch() =3D=3D nr_pages)
> >     set_ptes_to_swap_entries().

for this, we do check for one time, and we do much less tlbi.

> >
> >>
> >
> > Thanks,
> > Ryan

Thanks
Barry

