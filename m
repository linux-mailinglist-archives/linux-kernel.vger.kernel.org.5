Return-Path: <linux-kernel+bounces-152307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFE18ABC24
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 17:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2274AB2112D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C8E2837C;
	Sat, 20 Apr 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1gp7Axs"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201220DCC
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713625512; cv=none; b=sxooAkFSL6pHmJHqvB5wd+iS/63uguD/svXG6sGAcxPdj+mEo6yTb/U9Ooj6IZ3eXklBGYg5AhOfY91sxGlY1oWQUOZ2kHwLLuZA2ZDjILFAbjN9dgpZTl7Shh+CRGI0CjreUpBwJMWmuUvQYNSvLfKm3u1gddQq84LbxmWG0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713625512; c=relaxed/simple;
	bh=wVSreNKMomL5nHsWPdIQxBjIVDvm6Gadb+z1hsNqbUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh1RZk5tzKOU0AgX1OSizHD2fst8TM70nfWbqJ9n8UZ6x4DtaHXD+LMuuha9JpAEFvV52wQ8bEisvVsqjPYOpVSdVPGSPJTyTS04XWNUpXh2WL01YggBQbI8KspfW1qxqrkcAPKMZ5HIwzx6G7H/7tyi7MTd2pGVFH3Doq30A+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1gp7Axs; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d9fe2b37acso40334621fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713625508; x=1714230308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/Z3LywiOUmVKDDbHF9Ud8LmToX4stM0xrCXMXcjArM=;
        b=W1gp7AxsN4GE9Ig9WCSbwXC6y9pfzkDWVfrmB7YK/zFgfUE+5J+6vuSpq2ncm3q8IZ
         q3dRE9G7Fy+Mngopvd+o4S4aC4BBOf63UsGfQGwXPcDEwlsyAPgeIjcIPstmsZO80nhG
         0a0sLfx7R0pR0ZGKHzGNkjnl5q72lDRO2nTMbNI0VQYiZJDN2mVmOZRGcvhMfXt2LCJe
         okDDy03mwqBmOxV7PdnWiVhieFmUe9uh3aVcXNzR/PR8MN3j9thjPRERh7e8Rm+nWJKe
         CnpVqPKVstFH39gmPDVHRReeRcyLlC3oqgozcZurLtjPbb3sYTewltFH4ZI6hOTBy/dv
         zsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713625508; x=1714230308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/Z3LywiOUmVKDDbHF9Ud8LmToX4stM0xrCXMXcjArM=;
        b=oGce36+moKAqVkOZg+Ta4NOzSz6mSddyos4bbl2SIa4ztr4RfpPXTwQlQgCzKwT+tn
         6mEdC0HCE1W20aiNJNhSXY5QBQ5Yuw5DuIIErXJreAZysNWSHrhfiac0K7jm4UgRUHP3
         7HUynH2OKoI3gXZBT5zmvgTX5tX+UDw0bdoW3ioIH0uCaZmMzOj/pJs55vsMqinyqfhY
         cZTtGajkT3chGGMZgxgwNM5/3BPWgEUpP2wqs7PiNr+uxeD8F/FUlx/Ujcav4QZB/TIJ
         HYD6H3MfuJWeVONXZh5lc+/8WoVRnvPjdD3rwjP39LA+G1JuFHhTukeRPu4ch2dT4DFc
         5tFw==
X-Forwarded-Encrypted: i=1; AJvYcCXNxV3bWN+GKs0fjt+1OAZ5IVg6FXk/nRzf/isd7TkZthq6wWidyHC3nkS8/idTdFTWxV8iVPqgERB6iulqzJoLSgD/GFXgEev0mJZW
X-Gm-Message-State: AOJu0YxrU+cAtAYLPmE1IPXL1qxpDhsKTNR+TNZClRt2e+k39j6E/1Eg
	wPtZ9D19rNtzr1UDAQ3lzzuU6dfVkobieJOdCII5Wr8aCO+6ePKlqnOvl6qmgZD+pECqAInnLaX
	+CM2b/9TnnRrKoXCSnwlNzyHGswE=
X-Google-Smtp-Source: AGHT+IGS5wQ1zJBIfmparRJhTV7vgezYtEhRoiva+MDXE6AhUccrrTSVvaUls3svW67fVwF7i6ZV/7hQ7SGd3DWJixU=
X-Received: by 2002:a05:651c:1245:b0:2d8:6c9f:418 with SMTP id
 h5-20020a05651c124500b002d86c9f0418mr2825439ljh.44.1713625507603; Sat, 20 Apr
 2024 08:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417141111.77855-1-ioworker0@gmail.com> <Zh_mBxJmYe6eCA29@casper.infradead.org>
 <CAK1f24=Mrk7TFnDd=ouCrHaDH9K3VGCUAJbLH9cbn0pGncP+Hw@mail.gmail.com>
In-Reply-To: <CAK1f24=Mrk7TFnDd=ouCrHaDH9K3VGCUAJbLH9cbn0pGncP+Hw@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 20 Apr 2024 23:04:56 +0800
Message-ID: <CAK1f24=0S8qFFNhf5h=wbbAHvYt-n563MOu=bJheLcrfcPAE_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 12:59=E2=80=AFPM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> Hey Matthew,
>
> Thanks for taking time to review!
>
> On Wed, Apr 17, 2024 at 11:09=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> >
> > On Wed, Apr 17, 2024 at 10:11:11PM +0800, Lance Yang wrote:
> > > When the user no longer requires the pages, they would use madvise(ma=
dv_free)
> > > to mark the pages as lazy free. IMO, they would not typically rewrite=
 to the
> > > given range.
> > >
> > > At present, a PMD-mapped THP marked as lazyfree during shrink_folio_l=
ist()
> > > is unconditionally split, which may be unnecessary. If the THP is exc=
lusively
> > > mapped and clean, and the PMD associated with it is also clean, then =
we can
> > > attempt to remove the PMD mapping from it. This change will improve t=
he
> > > efficiency of memory reclamation in this case.
> > >
> > > On an Intel i5 CPU, reclaiming 1GiB of PMD-mapped THPs using
> > > mem_cgroup_force_empty() results in the following runtimes in seconds
> > > (shorter is better):
> > >
> > > --------------------------------------------
> > > |     Old       |      New       |  Change  |
> > > --------------------------------------------
> > > |   0.683426    |    0.049197    |  -92.80% |
> > > --------------------------------------------
> > >
> > > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > > ---
> > >  include/linux/huge_mm.h |  1 +
> > >  include/linux/rmap.h    |  1 +
> > >  mm/huge_memory.c        |  2 +-
> > >  mm/rmap.c               | 81 +++++++++++++++++++++++++++++++++++++++=
++
> > >  mm/vmscan.c             |  7 ++++
> > >  5 files changed, 91 insertions(+), 1 deletion(-)
> >
> > I'm confused why we need all this extra code.  If we remove a folio
>
> Thanks for pointing that out!
>
> I've added a lot of extra code to rmap.c, and we don't need it
> for file pages - sorry. I'll reconsider where to place this code.
>
> > from the pagecache, we can just call truncate_inode_folio() and
> > unmap_mapping_folio() takes care of all the necessary unmappings.
> > Why can't you call unmap_mapping_folio() here?
>
> Thanks for your suggestion.
>
> But this change only avoids the splitting of *anon* large folios
> (PMD-mapped THPs) that are marked as lazyfree during
> shrink_folio_list().
>
> IIUC, in some cases, we cannot unmap the THP marked as lazyfree
> here, such as when it's not exclusively mapped, dirty, pinned, etc.

I=E2=80=99d like to make a correction.

IMO, we can unmap the THP that is not exclusively mapped, but
ensuring folio_ref_count() equals folio_mapcount() +1.

Thanks,
Lance

> In such situations, we still need to return to try_to_unmap_one(), and
> then call split_huge_pmd_address() to split it.
>
> Thanks again for the review.
> Lance

