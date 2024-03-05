Return-Path: <linux-kernel+bounces-91963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E3A871915
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B631F23523
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9C65025C;
	Tue,  5 Mar 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVA6BgSr"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9C1E4AA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629728; cv=none; b=P02MGZ1npXgTRCLXx33LnUiJzNocUAtRj0KMuGRLSD3wWVJb0qFIVDaXFRQSXAkUOCvBb7la722lAtZrm08b6fedy/AZV/pVzMEX+XI3iJ/+uJOFFou8PSh92MDNSe5CnNB3CSt9bgFPSL89X02dBM7UCn6eGrJEi4nBg91ruok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629728; c=relaxed/simple;
	bh=uEIuWVJsH4N6qqWG2suy/nb/J8ICfcdEP9Kkz+NJQvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmm5oKu8our3YJfe9jFvDg1nvvXUliAOwlhl8YTWjN2kwdCR2ufWQJiDZVRiIqr5p3nSzDbUrzIexh2bhcYrxv6rrXLiaSp0biCQKOoyjxoKquOSr5LVNA5SnATDhxjBIjzZXLSJt5kT3SiUMwKJ36xtDoUzvot55o8il/vbuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVA6BgSr; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d5cbc4a585so2209266241.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709629725; x=1710234525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3UP6MqDIx5gIB8gV7yO8wiO4y+LssVv4w12YoavVWE=;
        b=WVA6BgSrWERbpIvNCyKc8nUcjsCbxIX/0S9FfsnCKN15zJQPKFGBS8LIBYzHxgqRRv
         lP2Yo4ANyWkYXFvDeZQMlN+2TMObRUaRgBKuoS/QmLdx+xjHhJU4P7he7+Ly1+9BHWGF
         SNBPpayNSPZhXNkZfNe2XiyJ74mH5z4Fye1+m13MycUtqPCko9ll0T2OoFMwuuMt2EED
         qbFNuKh6d27KAySW/4TWNMeRHHJrSuzJx3dyHuwo2XJGzDrMaUfogtIhzdzgv3hQRml2
         esiIZTdJfAIwk11sL/yTdSUVNhsyE6rjwQLPs7XsF1xROpGdR8bvdH9VFiqevjVt/Wri
         QUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629725; x=1710234525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3UP6MqDIx5gIB8gV7yO8wiO4y+LssVv4w12YoavVWE=;
        b=rbVggugIId95PCtG92Y4heUIL2Bm60/szzJjL6p9mSC8N5BJjgex9DNejKFafx6hI1
         K7XtGBMah/+73cJu86NLahBLS5LjA0h3d280DFEcfvZ9xLnlbw/6lgDm4ObOfkiXSCfh
         0uwvkFDs4lONOUq8J/X+g9dsGNi2jpApghcZaTcHV2aQSyUcuLoErsFIwrKyRZqGM9pN
         dA+i5NveNQd4aTqGscugCdz4SkUq5YVi4ix7YHDnC8UwjGuNxHSEA1dxIT4h5z3C/hIH
         bQ1W3jnGSHtOQJwFpfNRzd8xQsNiesm7jgNqEJNwiR1PZjR3EZW/sABsgpyyhRTmi0oT
         otvA==
X-Forwarded-Encrypted: i=1; AJvYcCVxdtzv4J3eKzz5izQNylMWuS682Wim2YkrShcDPegQTokfxcPpoqhKwNPRuq+ynqahmYRn1enweqwqfTebUqWK0GsNTlAScbFSETEh
X-Gm-Message-State: AOJu0YxhccsGUD/L0MlUVdpeu6kouw3ueWW9gUpFy14Dqgc7ofy0e1yE
	tm0EQWfeBMaXsB9sQbq5hOLnp4hTNJOIWhKYUpRul9ouspHDXsdO5Eu/hNxcFXbJAxKlNOla8tn
	qJRA9/pzTtbRIHSAubHXT4hHq3oQ=
X-Google-Smtp-Source: AGHT+IGGNn6I7Iux67fpLD0A4nxfGqtlFXrBviwt/csf2bAXF45nEz9/NJSFVh4k9T+BpXB30GTtfPnm9KBuMiTxpOQ=
X-Received: by 2002:a05:6102:c07:b0:472:7b61:70c6 with SMTP id
 x7-20020a0561020c0700b004727b6170c6mr1290749vss.2.1709629725473; Tue, 05 Mar
 2024 01:08:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304103757.235352-1-21cnbao@gmail.com> <706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
 <CAGsJ_4wx7oSzt4vn6B+LRoZetMhH-fDXRFrCFRyoqVOakLidjg@mail.gmail.com> <e5e14ef9-1bd2-45a8-818d-e92910e97f8f@arm.com>
In-Reply-To: <e5e14ef9-1bd2-45a8-818d-e92910e97f8f@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Mar 2024 22:08:34 +1300
Message-ID: <CAGsJ_4xtVhka9J3c6zDySBEJ34+mn9OLiuP0JJ+Ag+p9n9K5EA@mail.gmail.com>
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

On Tue, Mar 5, 2024 at 9:54=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 04/03/2024 21:57, Barry Song wrote:
> > On Tue, Mar 5, 2024 at 1:21=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> Hi Barry,
> >>
> >> On 04/03/2024 10:37, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> page_vma_mapped_walk() within try_to_unmap_one() races with other
> >>> PTEs modification such as break-before-make, while iterating PTEs
> >>> of a large folio, it will only begin to acquire PTL after it gets
> >>> a valid(present) PTE. break-before-make intermediately sets PTEs
> >>> to pte_none. Thus, a large folio's PTEs might be partially skipped
> >>> in try_to_unmap_one().
> >>
> >> I just want to check my understanding here - I think the problem occur=
s for
> >> PTE-mapped, PMD-sized folios as well as smaller-than-PMD-size large fo=
lios? Now
> >> that I've had a look at the code and have a better understanding, I th=
ink that
> >> must be the case? And therefore this problem exists independently of m=
y work to
> >> support swap-out of mTHP? (From your previous report I was under the i=
mpression
> >> that it only affected mTHP).
> >
> > I think this affects all large folios with PTEs entries more than 1. bu=
t hugeTLB
> > is handled as a whole in try_to_unmap_one and its rmap is removed all
> > together, i feel hugeTLB doesn't have this problem.
> >
> >>
> >> Its just that the problem is becoming more pronounced because with mTH=
P,
> >> PTE-mapped large folios are much more common?
> >
> > right. as now large folios become a more common case, and it is my case
> > running in millions of phones.
> >
> > BTW, I feel we can somehow learn from hugeTLB, for example, we can recl=
aim
> > all PTEs all together rather than iterating PTEs one by one. This will =
improve
> > performance. for example, a batched
> > set_ptes_to_swap_entries()
> > {
> > }
> > then we only need to loop once for a large folio, right now we are loop=
ing
> > nr_pages times.
>
> You still need a pte-pte loop somewhere. In hugetlb's case it's in the ar=
ch
> implementation. HugeTLB ptes are all a fixed size for a given VMA, which =
makes
> things a bit easier too, whereas in the regular mm, they are now a variab=
le size.
>
> David and I introduced folio_pte_batch() to help gather batches of ptes, =
and it
> uses the contpte bit to avoid iterating over intermediate ptes. And I'm a=
dding
> swap_pte_batch() which does a similar thing for swap entry batching in v4=
 of my
> swap-out series.
>
> For your set_ptes_to_swap_entries() example, I'm not sure what it would d=
o other
> than loop over the PTEs setting an incremented swap entry to each one? Ho=
w is
> that more performant?

right now, while (page_vma_mapped_walk(&pvmw)) will loop nr_pages for each
PTE, if each PTE, we do lots of checks within the loop.

by implementing set_ptes_to_swap_entries(), we can iterate once for
page_vma_mapped_walk(), after folio_pte_batch() has confirmed
the large folio is completely mapped, we set nr_pages swap entries
all together.

we are replacing

for(i=3D0;i<nr_pages;i++)     /* page_vma_mapped_walk */
{
        lots of checks;
        clear PTEn
        set PTEn to swap
}

by

if (large folio && folio_pte_batch() =3D=3D nr_pages)
    set_ptes_to_swap_entries().

>

Thanks,
Ryan

