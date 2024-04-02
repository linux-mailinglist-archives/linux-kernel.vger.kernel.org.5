Return-Path: <linux-kernel+bounces-128469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF88D895B3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161CFB262A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD9B15AAD1;
	Tue,  2 Apr 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmUzFbYv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81C15AAD3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080639; cv=none; b=ZnhV2qWjqm8N7/RlqUF0N7zjLECwARy5BWzl+YZ7LGVdAQjrSJjwkZBRmY8n1UhrPkTHO8cg75KAjW00a7ymTtB5oC4Pw959Jsai5oPDRA9kqBHR3U12G17DKVvlc6AFAf4ZPUpHydwW6dhUrPD7sTXlKgYE70om774tjrk5QeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080639; c=relaxed/simple;
	bh=tC3zcsgL2xD2N8ZSlD19zHwV+OBFjP2Wp6jbk8SIhR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWzMKFotGxSH8eNdCSkSAm+NxMYjoY16Y9GDtrOqieYTf6DuELU7MgeuU1KR2nFOgTUhgNAnFEkOQPxjeB9hr1TNnde06TK2+WIP4lGZrR5HibKJvAGFypc2q0gOBIiA7goyxHeTaTTuaVrAuiPJLICJW2IxLyMAIdcev1zO4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmUzFbYv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712080636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cckNB/548d66B17v5XuC9h9z4O+OKKLqAwTgKcrl8/A=;
	b=UmUzFbYvuypWrjZwSOsBkydq3i0lpSDHuQwteTZhIRyDgjVj5dhGKIX+6baOCCmbuGhYgO
	+yZvk5kwoIRowkqcqrUhz/Igp6iMfaSjF9Sq8CZoNGsD85cvfWxqrMIiX/Ln/E4mj/qtck
	kbrvPo2dXABhxHQZCrxI4SruOok46j0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-ef-OiGhZMdaIFpbjJrBYnw-1; Tue, 02 Apr 2024 13:57:15 -0400
X-MC-Unique: ef-OiGhZMdaIFpbjJrBYnw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7830635331bso137500885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080632; x=1712685432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cckNB/548d66B17v5XuC9h9z4O+OKKLqAwTgKcrl8/A=;
        b=QLo4FJOwLbfic+YjRPdzUz5f37wqndhBhVUYecqb4L/ki7rxW87j05xrnWsHAAEpi7
         /wnaZ4Zbl1mqcRDpMsdXLNFnPcBGB7WU5zY6qDY7gTqAbF2nzaNyjdZcUXX4ttLxb52c
         +0M3PzVMVzIjWg1oYsdgf9+aP9Mda/dAM21uc9G7FNO6N1dwvnf5SPywUEocYo4efMVq
         hs8yO096L7pWgwsmN4CNfp54i5QxaopCIrYNfNNZrFZLv2ggFrlKQ4j81TeVmGT17kZc
         rSWDQDHZmZ/Fpt1JJMIctuPc4xJzNPEEe2LZQjroNvSUgmAPe2WCqqB5jbZ41dtoqRnl
         rZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAs/MfX/FGywJ8fbZMj3C7nj53GZDZPI8IkcBB6fuC80Stij3FRdCa22/P2HjfhK4krgvDtQ0yUC50SB8fytLWZNkBRSDbHh1x/q/W
X-Gm-Message-State: AOJu0YzC7+FlSBx5/cxi91zdfhlk6jVn+9NwiRijAjaa5j3Fgg8SoSob
	piLmiSQKzaSxyKpCEjrq7gB4GA0RDoEIgNTCCP26vTOtGJSvPrHfMP9BX/cNjC5yp3RLDNVjWD1
	w9MiaDE2FXRpjRJMlng9t3JdLIxQttSQXk3F1H7gUE6ho9fvkdj1VmjIdcPI7FA==
X-Received: by 2002:a05:620a:1369:b0:789:fc04:4708 with SMTP id d9-20020a05620a136900b00789fc044708mr13698982qkl.5.1712080631986;
        Tue, 02 Apr 2024 10:57:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT6zYOqu5UZCHbEFgDsV12qf7bWbYd5b1tzjBcwsBNAdkz7l0tPp008500JyPX5eMhgEMO5Q==
X-Received: by 2002:a05:620a:1369:b0:789:fc04:4708 with SMTP id d9-20020a05620a136900b00789fc044708mr13698955qkl.5.1712080631345;
        Tue, 02 Apr 2024 10:57:11 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id q13-20020a05620a0c8d00b00789e800c204sm4477872qki.62.2024.04.02.10.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:57:11 -0700 (PDT)
Date: Tue, 2 Apr 2024 13:57:07 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v4 13/13] mm/gup: Handle hugetlb in the generic
 follow_page_mask code
Message-ID: <ZgxG8-LNZ0Hqtp6J@x1n>
References: <20240327152332.950956-1-peterx@redhat.com>
 <20240327152332.950956-14-peterx@redhat.com>
 <adfdd89b-ee56-4758-836e-c66a0be7de25@arm.com>
 <5d9dd9a7-e544-4741-944c-469b79c2c649@redhat.com>
 <ZgwwOq3XXKlS_7LQ@x1n>
 <8b0b24bb-3c38-4f27-a2c9-f7d7adc4a115@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b0b24bb-3c38-4f27-a2c9-f7d7adc4a115@redhat.com>

On Tue, Apr 02, 2024 at 06:39:31PM +0200, David Hildenbrand wrote:
> On 02.04.24 18:20, Peter Xu wrote:
> > On Tue, Apr 02, 2024 at 05:26:28PM +0200, David Hildenbrand wrote:
> > > On 02.04.24 16:48, Ryan Roberts wrote:
> > > > Hi Peter,
> > 
> > Hey, Ryan,
> > 
> > Thanks for the report!
> > 
> > > > 
> > > > On 27/03/2024 15:23, peterx@redhat.com wrote:
> > > > > From: Peter Xu <peterx@redhat.com>
> > > > > 
> > > > > Now follow_page() is ready to handle hugetlb pages in whatever form, and
> > > > > over all architectures.  Switch to the generic code path.
> > > > > 
> > > > > Time to retire hugetlb_follow_page_mask(), following the previous
> > > > > retirement of follow_hugetlb_page() in 4849807114b8.
> > > > > 
> > > > > There may be a slight difference of how the loops run when processing slow
> > > > > GUP over a large hugetlb range on cont_pte/cont_pmd supported archs: each
> > > > > loop of __get_user_pages() will resolve one pgtable entry with the patch
> > > > > applied, rather than relying on the size of hugetlb hstate, the latter may
> > > > > cover multiple entries in one loop.
> > > > > 
> > > > > A quick performance test on an aarch64 VM on M1 chip shows 15% degrade over
> > > > > a tight loop of slow gup after the path switched.  That shouldn't be a
> > > > > problem because slow-gup should not be a hot path for GUP in general: when
> > > > > page is commonly present, fast-gup will already succeed, while when the
> > > > > page is indeed missing and require a follow up page fault, the slow gup
> > > > > degrade will probably buried in the fault paths anyway.  It also explains
> > > > > why slow gup for THP used to be very slow before 57edfcfd3419 ("mm/gup:
> > > > > accelerate thp gup even for "pages != NULL"") lands, the latter not part of
> > > > > a performance analysis but a side benefit.  If the performance will be a
> > > > > concern, we can consider handle CONT_PTE in follow_page().
> > > > > 
> > > > > Before that is justified to be necessary, keep everything clean and simple.
> > > > > 
> > > > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > 
> > > > Afraid I'm seeing an oops when running gup_longterm test on arm64 with current mm-unstable. Git bisect blames this patch. The oops reproduces for me every time on 2 different machines:
> > > > 
> > > > 
> > > > [    9.340416] kernel BUG at mm/gup.c:778!
> > > > [    9.340746] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > > > [    9.341199] Modules linked in:
> > > > [    9.341481] CPU: 1 PID: 1159 Comm: gup_longterm Not tainted 6.9.0-rc2-00210-g910ff1a347e4 #11
> > > > [    9.342232] Hardware name: linux,dummy-virt (DT)
> > > > [    9.342647] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > [    9.343195] pc : follow_page_mask+0x4d4/0x880
> > > > [    9.343580] lr : follow_page_mask+0x4d4/0x880
> > > > [    9.344018] sp : ffff8000898b3aa0
> > > > [    9.344345] x29: ffff8000898b3aa0 x28: fffffdffc53973e8 x27: 00003c0005d08000
> > > > [    9.345028] x26: ffff00014e5cfd08 x25: ffffd3513a40c000 x24: fffffdffc5d08000
> > > > [    9.345682] x23: ffffc1ffc0000000 x22: 0000000000080101 x21: ffff8000898b3ba8
> > > > [    9.346337] x20: 0000fffff4200000 x19: ffff00014e52d508 x18: 0000000000000010
> > > > [    9.347005] x17: 5f656e6f7a5f7369 x16: 2120262620296567 x15: 6170286461654865
> > > > [    9.347713] x14: 6761502128454741 x13: 2929656761702865 x12: 6761705f65636976
> > > > [    9.348371] x11: 65645f656e6f7a5f x10: ffffd3513b31d6e0 x9 : ffffd3513852f090
> > > > [    9.349062] x8 : 00000000ffffefff x7 : ffffd3513b31d6e0 x6 : 0000000000000000
> > > > [    9.349753] x5 : ffff00017ff98cc8 x4 : 0000000000000fff x3 : 0000000000000000
> > > > [    9.350397] x2 : 0000000000000000 x1 : ffff000190e8b480 x0 : 0000000000000052
> > > > [    9.351097] Call trace:
> > > > [    9.351312]  follow_page_mask+0x4d4/0x880
> > > > [    9.351700]  __get_user_pages+0xf4/0x3e8
> > > > [    9.352089]  __gup_longterm_locked+0x204/0xa70
> > > > [    9.352516]  pin_user_pages+0x88/0xc0
> > > > [    9.352873]  gup_test_ioctl+0x860/0xc40
> > > > [    9.353249]  __arm64_sys_ioctl+0xb0/0x100
> > > > [    9.353648]  invoke_syscall+0x50/0x128
> > > > [    9.354022]  el0_svc_common.constprop.0+0x48/0xf8
> > > > [    9.354488]  do_el0_svc+0x28/0x40
> > > > [    9.354822]  el0_svc+0x34/0xe0
> > > > [    9.355128]  el0t_64_sync_handler+0x13c/0x158
> > > > [    9.355489]  el0t_64_sync+0x190/0x198
> > > > [    9.355793] Code: aa1803e0 d000d8e1 91220021 97fff560 (d4210000)
> > > > [    9.356280] ---[ end trace 0000000000000000 ]---
> > > > [    9.356651] note: gup_longterm[1159] exited with irqs disabled
> > > > [    9.357141] note: gup_longterm[1159] exited with preempt_count 2
> > > > [    9.358033] ------------[ cut here ]------------
> > > > [    9.358800] WARNING: CPU: 1 PID: 0 at kernel/context_tracking.c:128 ct_kernel_exit.constprop.0+0x108/0x120
> > > > [    9.360157] Modules linked in:
> > > > [    9.360541] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D            6.9.0-rc2-00210-g910ff1a347e4 #11
> > > > [    9.361626] Hardware name: linux,dummy-virt (DT)
> > > > [    9.362087] pstate: 204003c5 (nzCv DAIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > [    9.362758] pc : ct_kernel_exit.constprop.0+0x108/0x120
> > > > [    9.363306] lr : ct_idle_enter+0x10/0x20
> > > > [    9.363845] sp : ffff8000801abdc0
> > > > [    9.364222] x29: ffff8000801abdc0 x28: 0000000000000000 x27: 0000000000000000
> > > > [    9.364961] x26: 0000000000000000 x25: ffff00014149d780 x24: 0000000000000000
> > > > [    9.365557] x23: 0000000000000000 x22: ffffd3513b299d48 x21: ffffd3513a785730
> > > > [    9.366239] x20: ffffd3513b299c28 x19: ffff00017ffa7da0 x18: 0000fffff5ffffff
> > > > [    9.366869] x17: 0000000000000000 x16: 1fffe0002a21a8c1 x15: 0000000000000000
> > > > [    9.367524] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000002
> > > > [    9.368207] x11: 0000000000000001 x10: 0000000000000ad0 x9 : ffffd35138589230
> > > > [    9.369123] x8 : ffff00014149e2b0 x7 : 0000000000000000 x6 : 000000000f8c0fb2
> > > > [    9.370403] x5 : 4000000000000002 x4 : ffff2cb045825000 x3 : ffff8000801abdc0
> > > > [    9.371170] x2 : ffffd3513a782da0 x1 : 4000000000000000 x0 : ffffd3513a782da0
> > > > [    9.372279] Call trace:
> > > > [    9.372519]  ct_kernel_exit.constprop.0+0x108/0x120
> > > > [    9.373216]  ct_idle_enter+0x10/0x20
> > > > [    9.373562]  default_idle_call+0x3c/0x160
> > > > [    9.374055]  do_idle+0x21c/0x280
> > > > [    9.374394]  cpu_startup_entry+0x3c/0x50
> > > > [    9.374797]  secondary_start_kernel+0x140/0x168
> > > > [    9.375220]  __secondary_switched+0xb8/0xc0
> > > > [    9.375875] ---[ end trace 0000000000000000 ]---
> > > > 
> > > > 
> > > > The oops trigger is at mm/gup.c:778:
> > > > VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
> > > > 
> > > > 
> > > > This is the output of gup_longterm (last output is just before oops):
> > > > 
> > > > # [INFO] detected hugetlb page size: 2048 KiB
> > > > # [INFO] detected hugetlb page size: 32768 KiB
> > > > # [INFO] detected hugetlb page size: 64 KiB
> > > > # [INFO] detected hugetlb page size: 1048576 KiB
> > > > TAP version 13
> > > > 1..70
> > > > # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd
> > > > ok 1 Should have worked
> > > > # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
> > > > ok 2 Should have failed
> > > > # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with local tmpfile
> > > > ok 3 Should have failed
> > > > # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
> > > > ok 4 Should have worked
> > > > # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (32768 kB)
> > > > 
> > > > 
> > > > So 2M passed ok, and its failing for 32M, which is cont-pmd. I'm guessing you're trying to iterate 2M into a cont-pmd folio and ending up with an unexpected tail page?
> > > 
> > > I assume we find the expected tail page, it's just that the check
> > > 
> > > VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
> > > 
> > > Doesn't make sense with hugetlb folios. We might have a tail page mapped in
> > > a cont-pmd entry. As soon as we call follow_huge_pmd() on "not the first
> > > cont-pmd entry", we trigger this check.
> > > 
> > > Likely this sanity check must also allow for hugetlb folios. Or we should
> > > just remove it completely.
> > 
> > Right, IMHO it'll be easier we remove it, actually I see there's one more
> > at the end, so I think we need to remove both.
> > 
> > > 
> > > In the past, we wanted to make sure that we never get tail pages of THP from
> > > PMD entries, because something would currently be broken (we don't support
> > > THP > PMD).
> > 
> > There's probably one more thing we need to do, on allowing
> > PageAnonExclusive() to work with hugetlb tails. Even if we remove the
> > warnings and if I read the code right, we can BUG_ON again on checking tail
> > pages over anon-exclusive for PageHuge.
> > 
> > So I assume to fix it completely, we may need two changes: Patch 1 to
> > prepare PageAnonExclusive() to work on hugetlb tails, then patch 2 to be
> > squashed into the patch "mm/gup: handle huge pmd for follow_pmd_mask()".
> > Note: not this patch to fixup, as this patch only does the "switchover" to
> > the new path, the culprit should be the other patch..
> > 
> > I have them attached below first, before I'll also go and see whether I can
> > run some arm tests later today or tomorrow.  David, any comments from
> > anon-exclusive side?
> 
> I added the PageAnonExclusive checks for hugetlb back then, because calling
> it on a tail page indicated real trouble for hugetlb.
> 
> Well, and I didn't want to have runtime-hugetlb checks in PageAnonExclusive
> code called on certainly-not-hugetlb code paths.
> 
> Personally, I'd fixup the problematic callsite where we know nothing nasty
> is happening (like we did for gup_must_unshare(), because we don't expect
> hugetlb tail pages from arbitrary other code).
> 
> But as I'm getting closer to a folio_test_anon_exclusive() implementation as
> we speak (closer, but not done :) ... ), where I'd remove any such hugetlb
> special handling, I don't particularly care how we handle GUP here in the
> meantime.

That's what I was looking for and found missing just now, when I wanted to
allow follow_huge_pmd() pass page / folio (which will be the head then)
properly into different checks.  I think that patch 1 is the simplest I can
come up with that works mostly like what you said before a follow up
cleanup on top if possible.  It mostly pushed the existing runtime check in
gup_must_unshare() to be more generic.

IIUC it's also a matter of whether you'd want PageAnonExclusive() to take
care of both thp + hugetlb in one shot, rather than let callers handle it
by things like "if (PageHuge()) ... else ...", which I would try to avoid.
It seems so far cleaner to allow PageAnonExclusive() take whatever tail
pages, thp or hugetlb.  But maybe your ultimate patchset can be even better
than that.

Thanks,

-- 
Peter Xu


