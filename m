Return-Path: <linux-kernel+bounces-152435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BE88ABE64
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 04:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF80B20E69
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 02:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588D34437;
	Sun, 21 Apr 2024 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4mKdvum"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74517E9
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713664847; cv=none; b=Q+IEEmP2r29Lf3I5uu0LES16NhkHW9E2iwo+dGbNBU/UkgIBcCJ2B8l7f0U5n18T8kx303UGdRnVYekPRKlFUpihTli0uDM38IPtnK8s0dQ1MOTE0eC0WVuU/GH5xsTMfOkyHFt75bExi7R4XeVQuZPNVFPK7Q3o8PTy5AWWZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713664847; c=relaxed/simple;
	bh=UX084RJuO8/Yi2y3ycQjZg7ttqpn2HQzNvlO1h+YOaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCvsUUCkn4p2UcWiI7kYL20InAvr38YZVKM7bUHTOrXh3HLkjS2oD+h4rVyS6oral32ELJmL3MuBzY0FJp3qJktKGosG5F9s7LzyERd1R3daALwFiATctVC8IbY6KkqvF1Ro3MAqIUXaWbhndkj7j9WSdfcHKTSo/g9gukq6oPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4mKdvum; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so3791453a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 19:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713664844; x=1714269644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOA8/8IHq5Ni0TXZsu2O3+zUeAqA/LqMRJ+FKorgPcU=;
        b=U4mKdvumy+1JCcrSv3oC64M4FXF0e/K6pu8xrveN5vWzJSUux2vovqT6pDFykudezv
         YPu+D3Lk6DSNBWSolIWLZ0DnkXekHDpsVuUfZeGRGmy+0XzJwFTAdFTEITiBrFKo2Fzs
         hpOPpCxkne6eb6gvr9F3N2SwheoA6lx/g0mpbxJU/l0Gs3IVk5+eNZAwozNszhF4kqq1
         bLloJlNSJ/g4BPMNmnYI6l+z8JyvHzWMdYmpnr3ThpT0/26WmeHX2blqWp+gtr28lSwv
         2INa8hkpmAnmLyzOYJr5zJ2J+NNm6becprP7O3/6UHWG78yG8PjypOp/xWlvFxJVcuGZ
         QfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713664844; x=1714269644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOA8/8IHq5Ni0TXZsu2O3+zUeAqA/LqMRJ+FKorgPcU=;
        b=gARaAzvkVluLeZ4zsjO/KJFRmJorhdVJNfmRYekmzFp+lUBqu5FNT7bbr7zEEvNUKq
         TSKYBS79m9809/vbIU+jyOEJEWYZpSb7H5fi5IuqCVCozDm8tNbe4YsQm11y0W3r3BPf
         hzTpT0MeDap84EeWzhsYXM/CTSc0QOoc6xOeTVu767uKJ1l0GPiUBb0kNDd6BZQM0MeL
         aR36mxeUqW6mVPLBxFa8izx8fyouvqH4Ewyis5hBPnZHV35FotdBZw1piXJXOl78ZPOk
         xyISwckhR3aiyrHpXxz/khTsSir70gnbEig9vT6AnMN/qhqrU4hyj9+gbz188mJuwGEe
         JiTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7l8iFHO0um41NvhAJQj/8wy/zyZDfUvQVEP0qj2AqaFoXExtn+s9r8yH/e/LkzySfdUYnA0UssDnOOOhnJJVtOHLmmBte8K50HUu3
X-Gm-Message-State: AOJu0Yz/815yth7ThQ6ddg/6QZEVmOLy4wf150rqJF2FZimjdgA3z++o
	YFU/mnDGoRy9sSwn2aOOnprSEm36SOw+YAHC5pT1qm0buSnv8Njlee6fqCv2GuOAkwg3SxNtQ9v
	EW18nJJlQrRCdnA+5bVuLYj2xCtQ=
X-Google-Smtp-Source: AGHT+IGrL9DdbCsLfMFzILRzKabWsYb07qZDYvM4C93oOZ9YaLgGGSHIVQuDw3wG//qShdWfNFDdnXDYj5SDXL0gkM0=
X-Received: by 2002:a50:9b19:0:b0:56d:fca8:d204 with SMTP id
 o25-20020a509b19000000b0056dfca8d204mr3583965edi.27.1713664843421; Sat, 20
 Apr 2024 19:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417141111.77855-1-ioworker0@gmail.com> <Zh_mBxJmYe6eCA29@casper.infradead.org>
 <CAK1f24=Mrk7TFnDd=ouCrHaDH9K3VGCUAJbLH9cbn0pGncP+Hw@mail.gmail.com>
 <CAK1f24=0S8qFFNhf5h=wbbAHvYt-n563MOu=bJheLcrfcPAE_Q@mail.gmail.com> <b50af6b1-2fa7-4285-998f-88d28bf57713@redhat.com>
In-Reply-To: <b50af6b1-2fa7-4285-998f-88d28bf57713@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sun, 21 Apr 2024 10:00:31 +0800
Message-ID: <CAK1f24nN+DgU7rz0zV4DEwJwWe_CZcpR7GROMxWfWbo+cnr71g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, maskray@google.com, 
	ziy@nvidia.com, ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 12:32=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 20.04.24 17:04, Lance Yang wrote:
> > On Sat, Apr 20, 2024 at 12:59=E2=80=AFPM Lance Yang <ioworker0@gmail.co=
m> wrote:
> >>
> >> Hey Matthew,
> >>
> >> Thanks for taking time to review!
> >>
> >> On Wed, Apr 17, 2024 at 11:09=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> >>>
> >>> On Wed, Apr 17, 2024 at 10:11:11PM +0800, Lance Yang wrote:
> >>>> When the user no longer requires the pages, they would use madvise(m=
adv_free)
> >>>> to mark the pages as lazy free. IMO, they would not typically rewrit=
e to the
> >>>> given range.
> >>>>
> >>>> At present, a PMD-mapped THP marked as lazyfree during shrink_folio_=
list()
> >>>> is unconditionally split, which may be unnecessary. If the THP is ex=
clusively
> >>>> mapped and clean, and the PMD associated with it is also clean, then=
 we can
> >>>> attempt to remove the PMD mapping from it. This change will improve =
the
> >>>> efficiency of memory reclamation in this case.
> >>>>
> >>>> On an Intel i5 CPU, reclaiming 1GiB of PMD-mapped THPs using
> >>>> mem_cgroup_force_empty() results in the following runtimes in second=
s
> >>>> (shorter is better):
> >>>>
> >>>> --------------------------------------------
> >>>> |     Old       |      New       |  Change  |
> >>>> --------------------------------------------
> >>>> |   0.683426    |    0.049197    |  -92.80% |
> >>>> --------------------------------------------
> >>>>
> >>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>>> ---
> >>>>   include/linux/huge_mm.h |  1 +
> >>>>   include/linux/rmap.h    |  1 +
> >>>>   mm/huge_memory.c        |  2 +-
> >>>>   mm/rmap.c               | 81 +++++++++++++++++++++++++++++++++++++=
++++
> >>>>   mm/vmscan.c             |  7 ++++
> >>>>   5 files changed, 91 insertions(+), 1 deletion(-)
> >>>
> >>> I'm confused why we need all this extra code.  If we remove a folio
> >>
> >> Thanks for pointing that out!
> >>
> >> I've added a lot of extra code to rmap.c, and we don't need it
> >> for file pages - sorry. I'll reconsider where to place this code.
> >>
> >>> from the pagecache, we can just call truncate_inode_folio() and
> >>> unmap_mapping_folio() takes care of all the necessary unmappings.
> >>> Why can't you call unmap_mapping_folio() here?
> >>
> >> Thanks for your suggestion.
> >>
> >> But this change only avoids the splitting of *anon* large folios
> >> (PMD-mapped THPs) that are marked as lazyfree during
> >> shrink_folio_list().
> >>
> >> IIUC, in some cases, we cannot unmap the THP marked as lazyfree
> >> here, such as when it's not exclusively mapped, dirty, pinned, etc.
> >
> > I=E2=80=99d like to make a correction.
> >
> > IMO, we can unmap the THP that is not exclusively mapped, but
> > ensuring folio_ref_count() equals folio_mapcount() +1.
>

Hey David,

Thanks a lot for clarifying!

> You must follow the exact same logic as in try_to_unmap_one() I guess.

Agreed. I'll take a closer look at try_to_unmap_one() and follow
the exact same logic - thanks!

>
> That is, unmap the page, syncing against concurrent GUP-fast. Then,
> check mapcount vs. refcount. If there are unexpected references, remap
> the page (set_pte_at).

Yep, I understood. Could you please provide some suggestions on
where to place the exact same logic?

Thanks again for your time!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

