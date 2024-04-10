Return-Path: <linux-kernel+bounces-139286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9248A00EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF4E1C225D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0263F181B8B;
	Wed, 10 Apr 2024 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G96tQbub"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF9C18133F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779136; cv=none; b=HDWaUkXoYqEbKJIo7CiJCDBMOsIKyr+D/ylQHtW0g3iFEVS4jPPpuWi4hkEkVY8ikWEe7kvCPND0g3dQbrKClcQ7kh81vG02vBKv/SfOVDVovMBlpKtW9+A3Do11O3i/ZAVH/IDCCM5kkgxZTJYD9jzsN/zOsAbMPFSRGtAF/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779136; c=relaxed/simple;
	bh=MTNINs/uIDBPl2oAZyCzRZlZNV6A8HaJqOCgvS4/TfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHMGpxiElj1oNt9ah7R7oa72HcsxAmqdyw5RWgx2km6bn9upDyOYP0aDBELS59xLIN6t5e6VTzqJEZHIhXuPuqYI9FMj4kwXUpATIkTMKsNiIVj4SNHPGU44Ai7pc15DmhEUCYFxW9xSCnh6SrPmFAMGd5EUdBgJDmHgoJ1P4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G96tQbub; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712779132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxs+2ga91aRZGeZs4inMwPcuYTjJzWrBvKW8/ZIuNzA=;
	b=G96tQbublSoFzrr+KedoG6uetRYcBLngsCbYrOoeq6UvYk8a9YXzm8nK9uVopBHvpaCapM
	8+p8yaByUSw925B0RzZMidWk2d0vR+4QTl1DT3hln/44uBW3nCniaLXpa5oHkp3t+ZctSV
	p3dia4Q3+wpMC6n2MnHPHNnPExI47XE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-zcdthuNyMySR3Yz1ZCxVdQ-1; Wed, 10 Apr 2024 15:58:51 -0400
X-MC-Unique: zcdthuNyMySR3Yz1ZCxVdQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-69a01201ca0so18635156d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712779131; x=1713383931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxs+2ga91aRZGeZs4inMwPcuYTjJzWrBvKW8/ZIuNzA=;
        b=vyvNi+tKBw0bBEOdBotT5+M+qrqdYu16YicMBjh/EqKQ6+PhF5r7mbEnb7L3hfKgci
         c9ivn/y7DtWSvUA0cuH/eEP30dnOtT1Z4O0oxfSje7QAiKC8H3NWyCalymSFLV+FXmMm
         7qyYk1Ui8EfoVk7en9NSQd3pNeENVlePUEqbc3aXHYY+gJU8xlF5ooEYJEJoS09oIwxP
         wxhD8l17fVwf5wiYPKHJsYBmZ+MBdakSr48j9icioylsNhzVroKjyihvNDKt8Q6EXyp0
         nCQGTn+7iziL9VRo4/IQC12jFvT5ymeWI8aPLelju+UVrPfh8zRjtx2TiRf15c3a1SOf
         hulQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBODDyk4zTKdUt4/RhYo0xURfxAsx+V3pU/Inpz61XUE5VVWahubU/vHt8p+R5Y02w/E7IWfPjRzLrk0B5SLlL/bEzzkmnOSzOmGWB
X-Gm-Message-State: AOJu0YzTxTRsjP8Oo/78BRcLHS6/6XKLpkDQMarj9mTr0LUdk+BAtbRI
	cxyl1tcl62+FzVHbNx9WwRV53LHIc3KFq2Ho9N930mDNioyIMlDfEAxJVvFhGTMPtxydIYnzWLI
	FS7Ev8s79DKIw1DsPzK142+JtU3tnuLWOdEh59sLU0xHXoAcJC6WFj9DZQyuxYA==
X-Received: by 2002:a05:620a:4bc9:b0:78d:7760:e797 with SMTP id sw9-20020a05620a4bc900b0078d7760e797mr2835613qkn.2.1712779130645;
        Wed, 10 Apr 2024 12:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv1bdfgwWalbeb7W8lw1wQ8AyOawE9AJrFWRW0xu4CX1VzWDIy7HrETiPCNEoM1hdJNWYFiA==
X-Received: by 2002:a05:620a:4bc9:b0:78d:7760:e797 with SMTP id sw9-20020a05620a4bc900b0078d7760e797mr2835572qkn.2.1712779129838;
        Wed, 10 Apr 2024 12:58:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id vy23-20020a05620a491700b0078d66e2ac1bsm1043qkn.61.2024.04.10.12.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 12:58:49 -0700 (PDT)
Date: Wed, 10 Apr 2024 15:58:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yang Shi <shy828301@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Andrew Jones <andrew.jones@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 00/12] mm/gup: Unify hugetlb, part 2
Message-ID: <Zhbvd9WZzWl3IA8Y@x1n>
References: <20240321220802.679544-1-peterx@redhat.com>
 <20240322161000.GJ159172@nvidia.com>
 <ZgHJaJSpoeJVEccN@x1n>
 <20240326140252.GH6245@nvidia.com>
 <Zg8gEyE4o_VJsTmx@x1n>
 <20240405181633.GH5383@nvidia.com>
 <ZhBwVLyHr8WEKSx2@x1n>
 <20240409234355.GJ5383@nvidia.com>
 <ZhawJ-VD6DtLZ2Zm@x1n>
 <7b75c4db-9dbe-4ff1-b649-06a9218ae0aa@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b75c4db-9dbe-4ff1-b649-06a9218ae0aa@csgroup.eu>

On Wed, Apr 10, 2024 at 04:30:41PM +0000, Christophe Leroy wrote:
> 
> 
> Le 10/04/2024 à 17:28, Peter Xu a écrit :
> > On Tue, Apr 09, 2024 at 08:43:55PM -0300, Jason Gunthorpe wrote:
> >> On Fri, Apr 05, 2024 at 05:42:44PM -0400, Peter Xu wrote:
> >>> In short, hugetlb mappings shouldn't be special comparing to other huge pXd
> >>> and large folio (cont-pXd) mappings for most of the walkers in my mind, if
> >>> not all.  I need to look at all the walkers and there can be some tricky
> >>> ones, but I believe that applies in general.  It's actually similar to what
> >>> I did with slow gup here.
> >>
> >> I think that is the big question, I also haven't done the research to
> >> know the answer.
> >>
> >> At this point focusing on moving what is reasonable to the pXX_* API
> >> makes sense to me. Then reviewing what remains and making some
> >> decision.
> >>
> >>> Like this series, for cont-pXd we'll need multiple walks comparing to
> >>> before (when with hugetlb_entry()), but for that part I'll provide some
> >>> performance tests too, and we also have a fallback plan, which is to detect
> >>> cont-pXd existance, which will also work for large folios.
> >>
> >> I think we can optimize this pretty easy.
> >>   
> >>>> I think if you do the easy places for pXX conversion you will have a
> >>>> good idea about what is needed for the hard places.
> >>>
> >>> Here IMHO we don't need to understand "what is the size of this hugetlb
> >>> vma"
> >>
> >> Yeh, I never really understood why hugetlb was linked to the VMA.. The
> >> page table is self describing, obviously.
> > 
> > Attaching to vma still makes sense to me, where we should definitely avoid
> > a mixture of hugetlb and !hugetlb pages in a single vma - hugetlb pages are
> > allocated, managed, ...  totally differently.
> > 
> > And since hugetlb is designed as file-based (which also makes sense to me,
> > at least for now), it's also natural that it's vma-attached.
> > 
> >>
> >>> or "which level of pgtable does this hugetlb vma pages locate",
> >>
> >> Ditto
> >>
> >>> because we may not need that, e.g., when we only want to collect some smaps
> >>> statistics.  "whether it's hugetlb" may matter, though. E.g. in the mm
> >>> walker we see a huge pmd, it can be a thp, it can be a hugetlb (when
> >>> hugetlb_entry removed), we may need extra check later to put things into
> >>> the right bucket, but for the walker itself it doesn't necessarily need
> >>> hugetlb_entry().
> >>
> >> Right, places may still need to know it is part of a huge VMA because we
> >> have special stuff linked to that.
> >>
> >>>> But then again we come back to power and its big list of page sizes
> >>>> and variety :( Looks like some there have huge sizes at the pgd level
> >>>> at least.
> >>>
> >>> Yeah this is something I want to be super clear, because I may miss
> >>> something: we don't have real pgd pages, right?  Powerpc doesn't even
> >>> define p4d_leaf(), AFAICT.
> >>
> >> AFAICT it is because it hides it all in hugepd.
> > 
> > IMHO one thing we can benefit from such hugepd rework is, if we can squash
> > all the hugepds like what Christophe does, then we push it one more layer
> > down, and we have a good chance all things should just work.
> > 
> > So again my Power brain is close to zero, but now I'm referring to what
> > Christophe shared in the other thread:
> > 
> > https://github.com/linuxppc/wiki/wiki/Huge-pages
> > 
> > Together with:
> > 
> > https://lore.kernel.org/r/288f26f487648d21fd9590e40b390934eaa5d24a.1711377230.git.christophe.leroy@csgroup.eu
> > 
> > Where it has:
> > 
> > --- a/arch/powerpc/platforms/Kconfig.cputype
> > +++ b/arch/powerpc/platforms/Kconfig.cputype
> > @@ -98,6 +98,7 @@ config PPC_BOOK3S_64
> >          select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
> >          select ARCH_ENABLE_SPLIT_PMD_PTLOCK
> >          select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> > +       select ARCH_HAS_HUGEPD if HUGETLB_PAGE
> >          select ARCH_SUPPORTS_HUGETLBFS
> >          select ARCH_SUPPORTS_NUMA_BALANCING
> >          select HAVE_MOVE_PMD
> > @@ -290,6 +291,7 @@ config PPC_BOOK3S
> >   config PPC_E500
> >          select FSL_EMB_PERFMON
> >          bool
> > +       select ARCH_HAS_HUGEPD if HUGETLB_PAGE
> >          select ARCH_SUPPORTS_HUGETLBFS if PHYS_64BIT || PPC64
> >          select PPC_SMP_MUXED_IPI
> >          select PPC_DOORBELL
> > 
> > So I think it means we have three PowerPC systems that supports hugepd
> > right now (besides the 8xx which Christophe is trying to drop support
> > there), besides 8xx we still have book3s_64 and E500.
> > 
> > Let's check one by one:
> > 
> >    - book3s_64
> > 
> >      - hash
> > 
> >        - 64K: p4d is not used, largest pgsize pgd 16G @pud level.  It
> >          means after squashing it'll be a bunch of cont-pmd, all good.
> > 
> >        - 4K: p4d also not used, largest pgsize pgd 128G, after squashed
> >          it'll be cont-pud. all good.
> > 
> >      - radix
> > 
> >        - 64K: largest 1G @pud, then cont-pmd after squashed. all good.
> > 
> >        - 4K: largest 1G @pud, then cont-pmd, all good.
> > 
> >    - e500 & 8xx
> > 
> >      - both of them use 2-level pgtables (pgd + pte), after squashed hugepd
> >        @pgd level they become cont-pte. all good.
> 
> e500 has two modes: 32 bits and 64 bits.
> 
> For 32 bits:
> 
> 8xx is the only one handling it through HW-assisted pagetable walk hence 
> requiring a 2-level whatever the pagesize is.

Hmm I think maybe finally I get it..

I think the confusion came from when I saw there's always such level-2
table described in Figure 8-5 of the manual:

https://www.nxp.com/docs/en/reference-manual/MPC860UM.pdf

So I suppose you meant for 8M, the PowerPC 8xx system hardware will be
aware of such 8M pgtable (from level-1's entry, where it has bit 28-29 set
011b), then it won't ever read anything starting from "Level-2 Descriptor
1" (but only read the only entry "Level-2 Descriptor 0"), so fundamentally
hugepd format must look like such for 8xx?

But then perhaps it's still compatible with cont-pte because the rest
entries (pte index 1+) will simply be ignored by the hardware?

> 
> On e500 it is all software so pages 2M and larger should be cont-PGD (by 
> the way I'm a bit puzzled that on arches that have only 2 levels, ie PGD 
> and PTE, the PGD entries are populated by a function called PMD_populate()).

Yeah.. I am also wondering whether pgd_populate() could also work there
(perhaps with some trivial changes, or maybe not even needed..), as when
p4d/pud/pmd levels are missing, linux should just do something like an
enforced cast from pgd_t* -> pmd_t* in this case.

I think currently they're already not pgd, as __find_linux_pte() already
skipped pgd unconditionally:

	pgdp = pgdir + pgd_index(ea);
	p4dp = p4d_offset(pgdp, ea);

> 
> Current situation for 8xx is illustrated here: 
> https://github.com/linuxppc/wiki/wiki/Huge-pages#8xx
> 
> I also tried to better illustrate e500/32 here: 
> https://github.com/linuxppc/wiki/wiki/Huge-pages#e500
> 
> For 64 bits:
> We have PTE/PMD/PUD/PGD, no P4D
> 
> See arch/powerpc/include/asm/nohash/64/pgtable-4k.h

We don't have anything that is above pud in this category, right?  That's
what I read from your wiki (and thanks for providing that in the first
place; helps a lot for me to understand how it works on PowerPC).

I want to make sure if I can move on without caring on p4d/pgd leafs like
what we do right now, even after if we can remove hugepd for good, in this
case since p4d always missing, then it's about whether "pud|pmd|pte_leaf()"
can also cover the pgd ones when that day comes, iiuc.

Thanks,

> 
> 
> > 
> > I think the trick here is there'll be no pgd leaves after hugepd squashing
> > to lower levels, then since PowerPC seems to never have p4d, then all
> > things fall into pud or lower.  We seem to be all good there?
> > 
> >>
> >> If the goal is to purge hugepd then some of the options might turn out
> >> to convert hugepd into huge p4d/pgd, as I understand it. It would be
> >> nice to have certainty on this at least.
> > 
> > Right.  I hope the pmd/pud plan I proposed above can already work too with
> > such ambicious goal too.  But review very welcomed from either you or
> > Christophe.
> > 
> > PS: I think I'll also have a closer look at Christophe's series this week
> > or next.
> > 
> >>
> >> We have effectively three APIs to parse a single page table and
> >> currently none of the APIs can return 100% of the data for power.
> > 
> > Thanks,
> > 

-- 
Peter Xu


