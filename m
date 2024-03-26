Return-Path: <linux-kernel+bounces-120023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7AD88D065
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02401F292DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F082913D8A0;
	Tue, 26 Mar 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUiCDIk+"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7221D54F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490682; cv=none; b=q4e6SIjn/rDafsayafXchhQw6rOxuC1odY3ghY4AtwgCleawB7bIQpPAtOIzgvMCZzxuf4/NxjCZMHzP2pA+8jKMv+9vcl6m55mbyXJikTza4ii1i5ojd25RopCxpcIKmE2k0Wv3Vv4CKc9vk2IiUcQSs4dPBkQnYW3086Aq2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490682; c=relaxed/simple;
	bh=Tx+RS8m9OUDqhX+9afWSumARca29eJQ7Q45HXh7ti4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZg89G9JrS3CFZqQo4YCvwyfxEhsqW6GbcJWGXRV1EoDuznG0/VmsishS09DSIsq1/pBG0+164I0E+uKWwK667chAYf1JFpRfUgLvjLofUbmtoqc/Dvhzz+MVpSUe8LeGHIlu7fV5r3rfwPmM5WlOQaztzyfX5LmN8hMDQmIQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUiCDIk+; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c3aa9ca414so3861539b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711490679; x=1712095479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cf2ibnougTR001tC5MQWCKZFCMu1RmcpUnZDVA3FWTQ=;
        b=nUiCDIk+DoI8jNuiOERYhb6M3EGNVizY4hoMbs3AbZfqyGx121DNT2UVKCzJP9lg/T
         m10WMywxPGYcnIYRyWMxSDlLC3YN21zNONSrWa9k+ZQmZKPhUGHVi1cSuuk/vIR4Xqjg
         BPcEmgmPOKuFCmKyJQSDBELmK4KgTRJ+UANsN4l+bfNR5IvphWJQJX/NIOtfd++1hivN
         IyELs37jlhbz8T7NHkZcQRX867gcQvbGKQ2OH/sCdbmKMzCYmapL/zEoVdacNK1J8kME
         w1rUdUSbu+g/WbndsExtsx8B4DuQc7HA9u8ECW/miq4eUPamHzpAejYNZiL6yMD9fHST
         cQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711490679; x=1712095479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cf2ibnougTR001tC5MQWCKZFCMu1RmcpUnZDVA3FWTQ=;
        b=pCWJ8EJN5ZBJBoWQ0tFhsmwPWVpAUtNuZA7YiQQR5sHjvsC43qUNLBg0ytoGIlOPO5
         TYQbTXTCNPhS7fXiXzZrghi+YZtuZUxkGy9piApy3KAjU6cXC+GYOXEnVgyAyVpBWiB6
         DAo07oUIJ2sAuiauOJDw52FH9OL7VCOlA7lToCttVRwBqfIVOto61Ph6ANri2oTsrLcx
         k0FIV1SEvyvFUxKdv58w54MEDLiMIqGgGDtiYCfRgd4TFVHTyFAvQWGomedja7GzNAVX
         hFwvkBn9SNaRKkhAXT+6nkGFhgYEFCI8UhZZ/H6NZmXEhk4ae1NqIxa+/Gxk72FoV8sI
         4ZJw==
X-Forwarded-Encrypted: i=1; AJvYcCVTT0nQjAXns2LF2VOJ2ztQUra5ufCtq32NRKoFEFleAtSiktOS+sA0AsLzzb35hPLVoThmj+3LzdBl+fGlUGTzYxA4r0aYU9TDn5GZ
X-Gm-Message-State: AOJu0YypFf1S3B/AHe5tLFAAv+r0vr3M5/8Um/VP7dBsoOAaUAYBo23O
	CVA9XUYhUqpkcON9Mds3C97iRa5zWng7oDWZHvQzbIAOXu2mfBqdTCKlwrrWSUh6qSB57zeVeaR
	QnQT8wYnlrpUWNFpwHYWbuiLXADZw1RpsL+s=
X-Google-Smtp-Source: AGHT+IGq4y2/FOCu1WV399yRnNG6DblJxt62YKejBUXGv2D+hCtgo/96epQ9kUwJ/qs8tXaOIGaI+ZlmQIRVYPltu1k=
X-Received: by 2002:a05:6808:103:b0:3c3:ac2b:97f0 with SMTP id
 b3-20020a056808010300b003c3ac2b97f0mr2194011oie.13.1711490679417; Tue, 26 Mar
 2024 15:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306095219.71086-1-21cnbao@gmail.com> <cf16a19d-cc3b-4f19-a46f-83554a472368@redhat.com>
 <b63b965e-0aa1-4389-a7e0-badfe43e8dc5@arm.com>
In-Reply-To: <b63b965e-0aa1-4389-a7e0-badfe43e8dc5@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 27 Mar 2024 11:04:28 +1300
Message-ID: <CAGsJ_4yhpcgkgchOMzjHmrgAVoeoQY-Kp0_Dofk0zkRoOBO-Vw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: hold PTL from the first PTE while reclaiming a
 large folio
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	chrisl@kernel.org, hanchuanhua@oppo.com, hughd@google.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	v-songbaohua@oppo.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 5:17=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 26/03/2024 16:10, David Hildenbrand wrote:
> > On 06.03.24 10:52, Barry Song wrote:
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> Within try_to_unmap_one(), page_vma_mapped_walk() races with other
> >> PTE modifications preceded by pte clear. While iterating over PTEs
> >> of a large folio, it only starts acquiring PTL from the first valid
> >> (present) PTE. PTE modifications can temporarily set PTEs to
> >> pte_none. Consequently, the initial PTEs of a large folio might
> >> be skipped in try_to_unmap_one().
> >> For example, for an anon folio, if we skip PTE0, we may have PTE0
> >> which is still present, while PTE1 ~ PTE(nr_pages - 1) are swap
> >> entries after try_to_unmap_one().
> >> So folio will be still mapped, the folio fails to be reclaimed
> >> and is put back to LRU in this round.
> >> This also breaks up PTEs optimization such as CONT-PTE on this
> >> large folio and may lead to accident folio_split() afterwards.
> >> And since a part of PTEs are now swap entries, accessing those
> >> parts will introduce overhead - do_swap_page.
> >> Although the kernel can withstand all of the above issues, the
> >> situation still seems quite awkward and warrants making it more
> >> ideal.
> >> The same race also occurs with small folios, but they have only
> >> one PTE, thus, it won't be possible for them to be partially
> >> unmapped.
> >> This patch holds PTL from PTE0, allowing us to avoid reading PTE
> >> values that are in the process of being transformed. With stable
> >> PTE values, we can ensure that this large folio is either
> >> completely reclaimed or that all PTEs remain untouched in this
> >> round.
> >> A corner case is that if we hold PTL from PTE0 and most initial
> >> PTEs have been really unmapped before that, we may increase the
> >> duration of holding PTL. Thus we only apply this optimization to
> >> folios which are still entirely mapped (not in deferred_split
> >> list).
> >>
> >> Cc: Hugh Dickins <hughd@google.com>
> >> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> ---
> >>   v2:
> >>    * Refine commit message and code comment after reading all comments
> >>      from Ryan and David, thanks!
> >>    * Avoid increasing the duration of PTL by applying optimization
> >>      on folios not in deferred_split_list with respect to Ying's
> >>      comment, thanks!
> >>
> >>   mm/vmscan.c | 12 ++++++++++++
> >>   1 file changed, 12 insertions(+)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 0b888a2afa58..7106741387e8 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1270,6 +1270,18 @@ static unsigned int shrink_folio_list(struct li=
st_head
> >> *folio_list,
> >>                 if (folio_test_pmd_mappable(folio))
> >>                   flags |=3D TTU_SPLIT_HUGE_PMD;
> >> +            /*
> >> +             * Without TTU_SYNC, try_to_unmap will only begin to hold=
 PTL
> >> +             * from the first present PTE within a large folio. Some =
initial
> >> +             * PTEs might be skipped due to races with parallel PTE w=
rites
> >> +             * in which PTEs can be cleared temporarily before being =
written
> >> +             * new present values. This will lead to a large folio is=
 still
> >> +             * mapped while some subpages have been partially unmappe=
d after
> >> +             * try_to_unmap; TTU_SYNC helps try_to_unmap acquire PTL =
from the
> >> +             * first PTE, eliminating the influence of temporary PTE =
values.
> >> +             */
> >> +            if (folio_test_large(folio) && list_empty(&folio->_deferr=
ed_list))
> >> +                flags |=3D TTU_SYNC;
> >>                 try_to_unmap(folio, flags);
> >>               if (folio_mapped(folio)) {
> >
> > Hopefully this won't have unexpected performance "surprises".
> >
> > I do wonder if we should really care about the "_deferred_list" optimiz=
ation
> > here, though, I'd just drop it.

this is for a corner case:  <0, nr_pages-2> of a large folio have been unma=
pped
but nr_pages - 1 is still mapped. we are holding PTL to skip <0, nr_pages-2=
> w/
the patch, otherwise, we are skipping those PTEs w/o PTL.

But Ryan's swap-out will anyway split the folio before try_to_unmap,
so I feel we can
drop it.

>
> I also concluded that we do need the data_race() annotation around list_e=
mpty()
> if you do wind up keeping it. But I agree with David about dropping it.
>
> >
> > In any case
> >
> > Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

> >

