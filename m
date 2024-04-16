Return-Path: <linux-kernel+bounces-147480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632FF8A7509
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873671C216EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EC91386D2;
	Tue, 16 Apr 2024 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jgy+Qg9u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E08613E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713296458; cv=none; b=FFasSBjEC24o2TYf+jc5MEmVlvbyQ/YwnTpY9fyA3TP5pmrpRNT3WPlvbk/zDTCIiIH812osX2dqk5IuEkOsYW2+IMN1i5D7iAkWV2CthBMVySKmdhPcGVadbEvWb0QhLQxdIs76tm+8Hj17Zfc4yheAOFQb+YSNwyeENu06qLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713296458; c=relaxed/simple;
	bh=K2fNxqUo3y/scVaeYErZB9zDnlewpeWBmhhFfdCDNVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVwX0PUubx6goqK8xq+OEFrwj2I1SSQaFLjqeeJ3gg2JLM6+Xp/cJ8ycCiMkoQkjeR0MnQVDZTbSD81AY20KTANbG/8IvIhjE1O4MMYlcM6pPzRNeh2aXcnlJVYFCutrLYW8gHEMxa1uJbawW1uiIdpOL53ffs20iv0XJmWW0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jgy+Qg9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713296455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/Ml3SF+cSrbD320vnXWBxDDeH0gsE7DWJx9HUiNlVQ=;
	b=Jgy+Qg9u2xMxKL5BV4b4UX2TZqAq8oaoOpyM+2J/3RQU7ZSpFO+GkMLINPia96PKfRi/Gk
	WUnssEgUQc8J6fLHhmARAKI4KXBR/yAjfy/UsbhWuLxkklenbJSBlKrOnFNHyCaWU0hsFI
	VOz0kv7bUMO180Iy69MODmKWCVxIMHE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-dtvYDjjDMeufzeYyR9ARDQ-1; Tue, 16 Apr 2024 15:40:54 -0400
X-MC-Unique: dtvYDjjDMeufzeYyR9ARDQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-437618f53efso755141cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713296453; x=1713901253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/Ml3SF+cSrbD320vnXWBxDDeH0gsE7DWJx9HUiNlVQ=;
        b=G4NE3e8HGUDrNRJu+E/9cBd4sicSa674Tfh1bOUuC7JlVXTKZxAaO0kCZmyvfZhZxw
         1AoiG9Sv0CrQCCbtsw/TyJ3+DAqYR0dBbIyVIONRCjXJP5t1T7RKwWhJ81IYP9H/GA0A
         jzGtolUX63h1dhhjut4fHciUxYRnFlFQlnjK1w2d9mwRJuVBeDid/CRnu3smv5psYyJ/
         QtPslf56ys6aEss72z31BZmPpxn5qEA2ICnwz5fgel35PbWFRT/ZRpp94BboY6BGELF6
         pdIsbyaMSk5Yj1M2ZOGeUGdqeeH7MrH9N+PM2qzxj+w07SGZ+ydAUguq2o4/AuC9kv98
         NGYA==
X-Forwarded-Encrypted: i=1; AJvYcCXVb9othJEU16jstkdgH2vhudrZ15VjRsp4UPyMfvvAgN62thDchwWd71690T5JKwghvwZEKNsio/qBNDpLNjN0iiz4j9N/i4LElHsW
X-Gm-Message-State: AOJu0YxyOensRvzfgi5pDVEUhZJrGpYk/xCiwMO8VLOFMqPALGN/cZUK
	ktSWyxePEjA/EIG3LSOAUY0Wpf97JnXIg6L/0jVdQ24yb9+f4BadYdLVoIHQcDj2bVM18AjpFpp
	xbUOuQEhM+Ch8/D+AC3B+Wg9ohVfMc5gEM8C6t0+gT/4ebfbjZLN6r6RPlLfKbw==
X-Received: by 2002:a0c:d64a:0:b0:69b:6124:1ac5 with SMTP id e10-20020a0cd64a000000b0069b61241ac5mr12574626qvj.6.1713296453253;
        Tue, 16 Apr 2024 12:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM2TMuxlTE64M5wRSrKp9X4hT8djPoNFx5MjBvlHy4YWGI0mZHWgHn5d59fTUt+Qi0LQ06Yw==
X-Received: by 2002:a0c:d64a:0:b0:69b:6124:1ac5 with SMTP id e10-20020a0cd64a000000b0069b61241ac5mr12574601qvj.6.1713296452672;
        Tue, 16 Apr 2024 12:40:52 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id v17-20020a0ced51000000b0069b7edb9665sm2468071qvq.19.2024.04.16.12.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:40:52 -0700 (PDT)
Date: Tue, 16 Apr 2024 15:40:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 0/8] Reimplement huge pages without hugepd on powerpc
 8xx
Message-ID: <Zh7UQl5kMd_Q1ow-@x1n>
References: <cover.1711377230.git.christophe.leroy@csgroup.eu>
 <20240325163840.GF6245@nvidia.com>
 <ZhgMqF7SNaISrYMJ@x1n>
 <d236ce4a-1dde-4ee9-8cef-fe96242c2f4b@csgroup.eu>
 <ZhlFokakZo3c90C6@x1n>
 <d3a4c5a6-0fd6-4518-a76b-04dcf2ea2f2c@csgroup.eu>
 <8f7d4343-6bfd-4c1c-aeaf-350abde770ca@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f7d4343-6bfd-4c1c-aeaf-350abde770ca@csgroup.eu>

On Tue, Apr 16, 2024 at 10:58:33AM +0000, Christophe Leroy wrote:
> 
> 
> Le 15/04/2024 à 21:12, Christophe Leroy a écrit :
> > 
> > 
> > Le 12/04/2024 à 16:30, Peter Xu a écrit :
> >> On Fri, Apr 12, 2024 at 02:08:03PM +0000, Christophe Leroy wrote:
> >>>
> >>>
> >>> Le 11/04/2024 à 18:15, Peter Xu a écrit :
> >>>> On Mon, Mar 25, 2024 at 01:38:40PM -0300, Jason Gunthorpe wrote:
> >>>>> On Mon, Mar 25, 2024 at 03:55:53PM +0100, Christophe Leroy wrote:
> >>>>>> This series reimplements hugepages with hugepd on powerpc 8xx.
> >>>>>>
> >>>>>> Unlike most architectures, powerpc 8xx HW requires a two-level
> >>>>>> pagetable topology for all page sizes. So a leaf PMD-contig approach
> >>>>>> is not feasible as such.
> >>>>>>
> >>>>>> Possible sizes are 4k, 16k, 512k and 8M.
> >>>>>>
> >>>>>> First level (PGD/PMD) covers 4M per entry. For 8M pages, two PMD 
> >>>>>> entries
> >>>>>> must point to a single entry level-2 page table. Until now that was
> >>>>>> done using hugepd. This series changes it to use standard page tables
> >>>>>> where the entry is replicated 1024 times on each of the two 
> >>>>>> pagetables
> >>>>>> refered by the two associated PMD entries for that 8M page.
> >>>>>>
> >>>>>> At the moment it has to look into each helper to know if the
> >>>>>> hugepage ptep is a PTE or a PMD in order to know it is a 8M page or
> >>>>>> a lower size. I hope this can me handled by core-mm in the future.
> >>>>>>
> >>>>>> There are probably several ways to implement stuff, so feedback is
> >>>>>> very welcome.
> >>>>>
> >>>>> I thought it looks pretty good!
> >>>>
> >>>> I second it.
> >>>>
> >>>> I saw the discussions in patch 1.  Christophe, I suppose you're 
> >>>> exploring
> >>>> the big hammer over hugepd, and perhaps went already with the 32bit pmd
> >>>> solution for nohash/32bit challenge you mentioned?
> >>>>
> >>>> I'm trying to position my next step; it seems like at least I should 
> >>>> not
> >>>> adding any more hugepd code, then should I go with ARCH_HAS_HUGEPD 
> >>>> checks,
> >>>> or you're going to have an RFC soon then I can base on top?
> >>>
> >>> Depends on what you expect by "soon".
> >>>
> >>> I sure won't be able to send any RFC before end of April.
> >>>
> >>> Should be possible to have something during May.
> >>
> >> That's good enough, thanks.  I'll see what is the best I can do.
> >>
> >> Then do you think I can leave p4d/pgd leaves alone?  Please check the 
> >> other
> >> email where I'm not sure whether pgd leaves ever existed for any of
> >> PowerPC.  That's so far what I plan to do, on teaching pgtable walkers
> >> recognize pud and lower for all leaves.  Then if Power can switch from
> >> hugepd to this it should just work.
> > 
> > Well, if I understand correctly, something with no PMD will include 
> > <asm-generic/pgtable-nopmd.h> and will therefore only have .... pmd 
> > entries (hence no pgd/p4d/pud entries). Looks odd but that's what it is. 
> > pgd_populate(), p4d_populate(), pud_populate() are all "do { } while 
> > (0)" and only pmd_populate exists. So only pmd_leaf() will exist in that 
> > case.
> > 
> > And therefore including <asm-generic/pgtable-nop4d.h> means .... you 
> > have p4d entries. Doesn't mean you have p4d_leaf() but that needs to be 
> > checked.
> > 
> > 
> >>
> >> Even if pgd exists (then something I overlooked..), I'm wondering whether
> >> we can push that downwards to be either pud/pmd (and looks like we all
> >> agree p4d is never used on Power).  That may involve some pgtable
> >> operations moving from pgd level to lower, e.g. my pure imagination would
> >> look like starting with:
> > 
> > Yes I think there is no doubt that p4d is never used:
> > 
> > arch/powerpc/include/asm/book3s/32/pgtable.h:#include 
> > <asm-generic/pgtable-nopmd.h>
> > arch/powerpc/include/asm/book3s/64/pgtable.h:#include 
> > <asm-generic/pgtable-nop4d.h>
> > arch/powerpc/include/asm/nohash/32/pgtable.h:#include 
> > <asm-generic/pgtable-nopmd.h>
> > arch/powerpc/include/asm/nohash/64/pgtable-4k.h:#include 
> > <asm-generic/pgtable-nop4d.h>
> > 
> > But that means that PPC32 have pmd entries and PPC64 have p4d entries ...
> > 
> >>
> >> #define PTE_INDEX_SIZE    PTE_SHIFT
> >> #define PMD_INDEX_SIZE    0
> >> #define PUD_INDEX_SIZE    0
> >> #define PGD_INDEX_SIZE    (32 - PGDIR_SHIFT)
> >>
> >> To:
> >>
> >> #define PTE_INDEX_SIZE    PTE_SHIFT
> >> #define PMD_INDEX_SIZE    (32 - PMD_SHIFT)
> >> #define PUD_INDEX_SIZE    0
> >> #define PGD_INDEX_SIZE    0
> > 
> > But then you can't anymore have #define PTRS_PER_PMD 1 from 
> > <asm-generic/pgtable-nop4d.h>
> > 
> >>
> >> And the rest will need care too.  I hope moving downward is easier
> >> (e.g. the walker should always exist for lower levels but not always for
> >> higher levels), but I actually have little idea on whether there's any
> >> other implications, so please bare with me on stupid mistakes.
> >>
> >> I just hope pgd leaves don't exist already, then I think it'll be 
> >> simpler.
> >>
> >> Thanks,
> >>
> 
> Digging into asm-generic/pgtable-nopmd.h, I see a definition of 
> pud_leaf() always returning 0, introduced by commit 2c8a81dc0cc5 
> ("riscv/mm: fix two page table check related issues")
> 
> So should asm-generic/pgtable-nopud.h contain the same for p4d_leaf() 

I think should be yes for this, and..

> and asm-generic/pgtable-nop4d.h contain the same for pgd_leaf() ?

. probably no for this?  It seems pgd is just slightly special.

Firstly, I notice that the -nopmd.h actually includes -nopud.h already, and
further that includes -nop4d.h.  It means we can only have below options:

  a) nopmd + nopud + nop4d
  b) nopud + nop4d
  c) nop4d

It should also mean we can't randomly choose which layer to skip with the
current header arrangements.. at the meantime, all 32bit PowerPC should
perhaps fall into a), while 64 bits fall into c).  That looks all fine for
now.

Above p4d_leaf()==false [1] should be fine when -nopud.h included, because
that already included nop4d.h, it means "p4d level is skipped" in the
pgtable.  Then it doesn't make sense if p4d_leaf() can ever return true.
That's the same when pud_leaf()==false looks sane when an arch included
-nopmd.h as that in turn implies -nopud too.

pgd seems different, because -nop4d.h didn't include anything else like
"-nopgd.h"..  so I don't see further implication on pgd sololy from the
headers. I guess that's also why 32bit Power uses pgd+pte for the two
levels; it looks like pgd is special among the others.

However I think it still didn't mean that we can't push pgd to pmd, making
pgd+pte into pmd+pte.  Though here we may want to move from:

  #include <asm-generic/pgtable-nopmd.h>
  (pmd/pud/p4d not used)

Into:

  #include <asm-generic/pgtable-nopud.h>
  (pud/p4d not used)

Then we may need to provide something similar to what's in -nopXd.h for
pgds.

But let's loop back to the very beginning: I don't think we have either pgd
leaves or p4d leaves for PowerPC.  Note that hugepd looks possible to exist
in pgd entries (per wiki page [1]), however I don't even think it's true in
reality, as I mentioned elsewhere on reading __find_linux_pte() and it
always go directly into p4d.  I highly doubt in reality the "pgd hugepd
entries" are actually processed by the p4d layer here:

	if (is_hugepd(__hugepd(p4d_val(p4d)))) {
		hpdp = (hugepd_t *)&p4d;
		goto out_huge;
	}

Because when with "nop4d" it doesn't mean "there is no p4d" but what it
really meant is "we have only one p4d entry (which is actually exactly the
pgd entry..)".  After all, is_hugepd() works for all levels.

Taking E500 nohash 32 as example, it has these:

  "pgd entry covering 2M" -> "hugepd with one hugepte covering one 4M hugepage"
                                   ^
  "pgd entry covering 2M" ---------+

I suspect this "pgd covering 2M" is processed by the p4d code above, rather
than pgd level.  Then in the future world where there's no hugepd, it'll
naturally become a pgtable page at pte level.

Thanks,

[1] https://github.com/linuxppc/wiki/wiki/Huge-pages

-- 
Peter Xu


