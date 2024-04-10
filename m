Return-Path: <linux-kernel+bounces-138873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7296D89FB88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DCC1F268DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819D416EC11;
	Wed, 10 Apr 2024 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKfXx6da"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62351E878
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762928; cv=none; b=SitxkNcsMUAlQFvUp8ylwyhtMF6wRlTgfx1lJxpoa+HgYOCNksaHX0ri1ZjCN6F51MHQIeT2a4R9KORDs/j+/k1eixe26zYE3FmmbKNKlSGY6bo+k0EfBo5nXaxJGa2kzp8kdA8+t0mVi5g3n5R3pu0zMl62rjEPXQNNsE9YAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762928; c=relaxed/simple;
	bh=lSxDCqVmS49joX+KK2vOQBOuXPAF5oXxcuK+9LJdVFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grDD1CxGAM7qCUxDf1o4Bkzi6pZ+imRnS8sd3MpeYqDsxqoFHOwCueN3VDqzIeGNkRmddEuZOVsC+k8TaDJY0NbTSbDAtQ1lzHuLGmHq3aeBJa0oQCcmcAzwEBLwp6hgtLselaNT/6AgJbRcF+M++b/VxRmQjW89x6k4Jh2hqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fKfXx6da; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712762925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ci1baLlwDbOm6Wup8/nHleUUTbOV/R7CG6mxApYjz0M=;
	b=fKfXx6daHhl5PrK4E9aFrZnlTgfulS/1gTixVI5lppIUn4QLmTYyjG7U4WgxMei2HJbxBT
	7SVDXcWl22mWqiKidMiB7KG1dnUUDPhhg9qCiyxMp65QfNZ8hvoqNH50JXwt6dWgt5YVGi
	M08HmR8HVH0LI9O+xUtY7i/e5LucBTw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-AfH0EcHqMXSmp7c7iAiAdQ-1; Wed, 10 Apr 2024 11:28:44 -0400
X-MC-Unique: AfH0EcHqMXSmp7c7iAiAdQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69627b26a51so2057506d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712762923; x=1713367723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci1baLlwDbOm6Wup8/nHleUUTbOV/R7CG6mxApYjz0M=;
        b=FVZ6uatgI+RSHU74x81lbNnQOh5a6EPBshQednr3olXMRH7RphuWAyIHRdimiSistw
         Lw+wxQOiHxq1y05W42/6MZ9759NF+X4oWDzx7F/jM70X87E3kT/Z/PmNTRlMSph5IhNf
         eHLAwe9DBD/sDAXGaHsT8v0bgwmF5qYW7pk66PZp1HkPMHmfvwdvZVUFKEtyK/QLWe7M
         l5HHD0CITqE3VFW5npEiBmAUSa8gPipLT9ylrBwUdKLewUVPmQjWnf+TxlirccY0v+AG
         4UmrMBVJ1Q86yXGgXkA4lOw+Ia9hvqt/OYpHDRJ+NIn1Un390UorGEXPXxqlIbF3OksS
         Kxpw==
X-Forwarded-Encrypted: i=1; AJvYcCVcVad48PgObdzYQx+jkIuiqP+Onor1J4LZrvAIUgAie3XAyERXVdeJ/VndoIYZRd2/0p7YWlPVunPSC+AxaNate0brYdPSMi3/OfB+
X-Gm-Message-State: AOJu0YytSlGfBtIq77tNDDYaek4oPno3FlaPmPEnZuohxOU8Pc8yPD5i
	VlllKKvVn07I7fXWPOERSQRVqjD/IYGd8oOZHGatiZ9gzk1p4owC+ecxYnGUyeE1jg1gV3BQzUf
	kRHFWDgcYK/Qb6QEDS6rvPzNtJKLQW7UXLHKvOjvOTgRtfi4o+JIT1Z5dDiOrWA==
X-Received: by 2002:a05:6214:5090:b0:69b:ce6:271b with SMTP id kk16-20020a056214509000b0069b0ce6271bmr3168089qvb.2.1712762923251;
        Wed, 10 Apr 2024 08:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZs5MCkL0IJwntJvXwMvElTS5kl/yk1ExPO6tDqr2NK62DfB6pdbW0p2/DjTaMvJz9lDcKPw==
X-Received: by 2002:a05:6214:5090:b0:69b:ce6:271b with SMTP id kk16-20020a056214509000b0069b0ce6271bmr3168047qvb.2.1712762922544;
        Wed, 10 Apr 2024 08:28:42 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id ek1-20020ad45981000000b00699032e555bsm5208543qvb.127.2024.04.10.08.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:28:42 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:28:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yang Shi <shy828301@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Andrew Jones <andrew.jones@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	linux-riscv@lists.infradead.org,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 00/12] mm/gup: Unify hugetlb, part 2
Message-ID: <ZhawJ-VD6DtLZ2Zm@x1n>
References: <20240321220802.679544-1-peterx@redhat.com>
 <20240322161000.GJ159172@nvidia.com>
 <ZgHJaJSpoeJVEccN@x1n>
 <20240326140252.GH6245@nvidia.com>
 <Zg8gEyE4o_VJsTmx@x1n>
 <20240405181633.GH5383@nvidia.com>
 <ZhBwVLyHr8WEKSx2@x1n>
 <20240409234355.GJ5383@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240409234355.GJ5383@nvidia.com>

On Tue, Apr 09, 2024 at 08:43:55PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 05, 2024 at 05:42:44PM -0400, Peter Xu wrote:
> > In short, hugetlb mappings shouldn't be special comparing to other huge pXd
> > and large folio (cont-pXd) mappings for most of the walkers in my mind, if
> > not all.  I need to look at all the walkers and there can be some tricky
> > ones, but I believe that applies in general.  It's actually similar to what
> > I did with slow gup here.
> 
> I think that is the big question, I also haven't done the research to
> know the answer.
> 
> At this point focusing on moving what is reasonable to the pXX_* API
> makes sense to me. Then reviewing what remains and making some
> decision.
> 
> > Like this series, for cont-pXd we'll need multiple walks comparing to
> > before (when with hugetlb_entry()), but for that part I'll provide some
> > performance tests too, and we also have a fallback plan, which is to detect
> > cont-pXd existance, which will also work for large folios.
> 
> I think we can optimize this pretty easy.
>  
> > > I think if you do the easy places for pXX conversion you will have a
> > > good idea about what is needed for the hard places.
> > 
> > Here IMHO we don't need to understand "what is the size of this hugetlb
> > vma"
> 
> Yeh, I never really understood why hugetlb was linked to the VMA.. The
> page table is self describing, obviously.

Attaching to vma still makes sense to me, where we should definitely avoid
a mixture of hugetlb and !hugetlb pages in a single vma - hugetlb pages are
allocated, managed, ...  totally differently.

And since hugetlb is designed as file-based (which also makes sense to me,
at least for now), it's also natural that it's vma-attached.

> 
> > or "which level of pgtable does this hugetlb vma pages locate",
> 
> Ditto
> 
> > because we may not need that, e.g., when we only want to collect some smaps
> > statistics.  "whether it's hugetlb" may matter, though. E.g. in the mm
> > walker we see a huge pmd, it can be a thp, it can be a hugetlb (when
> > hugetlb_entry removed), we may need extra check later to put things into
> > the right bucket, but for the walker itself it doesn't necessarily need
> > hugetlb_entry().
> 
> Right, places may still need to know it is part of a huge VMA because we
> have special stuff linked to that.
> 
> > > But then again we come back to power and its big list of page sizes
> > > and variety :( Looks like some there have huge sizes at the pgd level
> > > at least.
> > 
> > Yeah this is something I want to be super clear, because I may miss
> > something: we don't have real pgd pages, right?  Powerpc doesn't even
> > define p4d_leaf(), AFAICT.
> 
> AFAICT it is because it hides it all in hugepd.

IMHO one thing we can benefit from such hugepd rework is, if we can squash
all the hugepds like what Christophe does, then we push it one more layer
down, and we have a good chance all things should just work.

So again my Power brain is close to zero, but now I'm referring to what
Christophe shared in the other thread:

https://github.com/linuxppc/wiki/wiki/Huge-pages

Together with:

https://lore.kernel.org/r/288f26f487648d21fd9590e40b390934eaa5d24a.1711377230.git.christophe.leroy@csgroup.eu

Where it has:

--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -98,6 +98,7 @@ config PPC_BOOK3S_64
        select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
        select ARCH_ENABLE_SPLIT_PMD_PTLOCK
        select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
+       select ARCH_HAS_HUGEPD if HUGETLB_PAGE
        select ARCH_SUPPORTS_HUGETLBFS
        select ARCH_SUPPORTS_NUMA_BALANCING
        select HAVE_MOVE_PMD
@@ -290,6 +291,7 @@ config PPC_BOOK3S
 config PPC_E500
        select FSL_EMB_PERFMON
        bool
+       select ARCH_HAS_HUGEPD if HUGETLB_PAGE
        select ARCH_SUPPORTS_HUGETLBFS if PHYS_64BIT || PPC64
        select PPC_SMP_MUXED_IPI
        select PPC_DOORBELL

So I think it means we have three PowerPC systems that supports hugepd
right now (besides the 8xx which Christophe is trying to drop support
there), besides 8xx we still have book3s_64 and E500.

Let's check one by one:

  - book3s_64

    - hash

      - 64K: p4d is not used, largest pgsize pgd 16G @pud level.  It
        means after squashing it'll be a bunch of cont-pmd, all good.

      - 4K: p4d also not used, largest pgsize pgd 128G, after squashed
        it'll be cont-pud. all good.

    - radix

      - 64K: largest 1G @pud, then cont-pmd after squashed. all good.

      - 4K: largest 1G @pud, then cont-pmd, all good.

  - e500 & 8xx

    - both of them use 2-level pgtables (pgd + pte), after squashed hugepd
      @pgd level they become cont-pte. all good.

I think the trick here is there'll be no pgd leaves after hugepd squashing
to lower levels, then since PowerPC seems to never have p4d, then all
things fall into pud or lower.  We seem to be all good there?

> 
> If the goal is to purge hugepd then some of the options might turn out
> to convert hugepd into huge p4d/pgd, as I understand it. It would be
> nice to have certainty on this at least.

Right.  I hope the pmd/pud plan I proposed above can already work too with
such ambicious goal too.  But review very welcomed from either you or
Christophe.

PS: I think I'll also have a closer look at Christophe's series this week
or next.

> 
> We have effectively three APIs to parse a single page table and
> currently none of the APIs can return 100% of the data for power.

Thanks,

-- 
Peter Xu


