Return-Path: <linux-kernel+bounces-132172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF7C899097
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D531F239E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AFE13C3C4;
	Thu,  4 Apr 2024 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4cl7svS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25BC15EA6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712267291; cv=none; b=QBbjgnMLVqWGGPnW6gYgMMKP9EMW1OyHkswUmy0SY0xeCT2mskKUaWo9hP9mR/qdzv2UEgGzbuArvgEkM6gx5lrufK1Tw4kn1lB1GOqWRs2A6XDfEkuey/jimO3vZVY0ouvNOu80Q3LY9Hf5JVvpByoEnADlPQ4yeZ9hmuZjQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712267291; c=relaxed/simple;
	bh=tyOJweThBBmRhkj3LkV8VI78GqXfmC8mx6HCWpOuukE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtRqSKAbybIS5Hza+totM3DcTV04KVIzTbL36/lLwJzIkYkD3IwK+BeiCQEZJlSMTRK7iS0gQizTOltQk/guO0ZjHUkKP0KXaZ9bJZYbSRXKIHUqTpiQbDTbQinSOfUPL2U/6U+52k7V/UADW9CSPQRIpalabWuSlCgjSmWGs+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4cl7svS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712267288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d56SKhTEmtwwDufddPphJGQfZPKBUJnUzF2wWqxF3/c=;
	b=U4cl7svSlIK7RcjmgEdmdGc2rP4assD95p547ZSziMc3T4tfYTQxv+ScKab+haYTYNo7Vt
	R3WE+vIFpTo8SiXx0n4YzkXksCrsj8wEI1cUhrD+sT4hJX+L3kQ1j/GOYC9lTN3DXa/s5M
	UsYW5NdbrOllh8fYakYIWxjBpHttVNY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-na6ULbXRMXeUYWZKf4WfnQ-1; Thu, 04 Apr 2024 17:48:07 -0400
X-MC-Unique: na6ULbXRMXeUYWZKf4WfnQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78d346eeb02so53116885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 14:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712267287; x=1712872087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d56SKhTEmtwwDufddPphJGQfZPKBUJnUzF2wWqxF3/c=;
        b=jVMARoCTWgqVF7dqXa6vhSm2Wh84zyXFhQrH6ssBhbJ/wpVwCZ85wkFFwS4k6kFWtj
         9eQYS5ZBkL4mVbMYbGGSQoHgbB7LKOTbqeWv+exMWWLx/+9N5Zr+EpK072bAD6vf9ikv
         m9rt81zG9pteAPPaC72msNHd7LeGpZQEtY+Wcg47WgX81vMohYAa+qHMiav56u2TGB5Q
         PtvxiTxkiA/0ac/btlYEw8MC70LbvVznmSQh30strmsRBL24ikKdKc9h8N1+YwGp+RG9
         6gFkqQplqzjNd/rHO9qRICmVUzvJBZeut6w7ooJoHny9vEb5ht/xnopmxEdc1qNrnmnm
         8v+w==
X-Forwarded-Encrypted: i=1; AJvYcCXAg0W0UQUkcQnAU6FjF7bEWerZnsTaf1xxitzVvovnSsS/hLCVvP12Ma7rfBtZfq+W7sxg8TifmX5eoUesqKoYjuWOCDv1Ov0SO3tA
X-Gm-Message-State: AOJu0Ywp4uJCv9W/qEHIQoK9SPQ6Ee+B2wCeui2P7zSVzfkOtsmw8Z6W
	qk6/VqcJ38CAO2wXchT5LZUtlLi7C16znNuO2Zs1f4iSrX6yMHomEmkpf8eAKm+HvPBs+eo0rNr
	ljn1REweHK60sCZcc1Jx/H7/C9+uQMZ4nBHSkLygl+t3h0U48qk9Bn71lbhiBYw==
X-Received: by 2002:a05:620a:4710:b0:78d:3b13:f5ab with SMTP id bs16-20020a05620a471000b0078d3b13f5abmr4680975qkb.0.1712267286787;
        Thu, 04 Apr 2024 14:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGchKyZTo6ytc9p0sjvCKGDIoG+ERHoc+VJC1tNlLSTRdcMUNyMf3HEESrAIicSQ8HrtIJ6pQ==
X-Received: by 2002:a05:620a:4710:b0:78d:3b13:f5ab with SMTP id bs16-20020a05620a471000b0078d3b13f5abmr4680952qkb.0.1712267286207;
        Thu, 04 Apr 2024 14:48:06 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id wg6-20020a05620a568600b00789e49808ffsm105555qkn.105.2024.04.04.14.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 14:48:05 -0700 (PDT)
Date: Thu, 4 Apr 2024 17:48:03 -0400
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
Message-ID: <Zg8gEyE4o_VJsTmx@x1n>
References: <20240321220802.679544-1-peterx@redhat.com>
 <20240322161000.GJ159172@nvidia.com>
 <ZgHJaJSpoeJVEccN@x1n>
 <20240326140252.GH6245@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240326140252.GH6245@nvidia.com>

On Tue, Mar 26, 2024 at 11:02:52AM -0300, Jason Gunthorpe wrote:
> The more I look at this the more I think we need to get to Matthew's
> idea of having some kind of generic page table API that is not tightly
> tied to level. Replacing the hugetlb trick of 'everything is a PTE'
> with 5 special cases in every place seems just horrible.
> 
>    struct mm_walk_ops {
>        int (*leaf_entry)(struct mm_walk_state *state, struct mm_walk *walk);
>    }
> 
> And many cases really want something like:
>    struct mm_walk_state state;
> 
>    if (!mm_walk_seek_leaf(state, mm, address))
>           goto no_present
>    if (mm_walk_is_write(state)) ..
> 
> And detailed walking:
>    for_each_pt_leaf(state, mm, address) {
>        if (mm_walk_is_write(state)) ..
>    }
> 
> Replacing it with a mm_walk_state that retains the level or otherwise
> to allow decoding any entry composes a lot better. Forced Loop
> unrolling can get back to the current code gen in alot of places.
> 
> It also makes the power stuff a bit nicer as the mm_walk_state could
> automatically retain back pointers to the higher levels in the state
> struct too...
> 
> The puzzle is how to do it and still get reasonable efficient codegen,
> many operations are going to end up switching on some state->level to
> know how to decode the entry.

These discussions are definitely constructive, thanks Jason.  Very helpful.

I thought about this last week but got interrupted.  It does make sense to
me; it looks pretty generic and it is flexible enough as a top design.  At
least that's what I thought.

However now when I rethink about it, and look more into the code when I got
the chance, it turns out this will be a major rewrite of mostly every
walkers..  it doesn't mean that this is a bad idea, but then I'll need to
compare the other approach, because there can be a huge difference on when
we can get that code ready, I think. :)

Consider that what we (or.. I) want to teach the pXd layers are two things
right now: (1) hugetlb mappings (2) MMIO (PFN) mappings.  That mostly
shares the generic concept when working on the mm walkers no matter which
way to go, just different treatment on different type of mem.  (2) is on
top of current code and new stuff, while (1) is a refactoring to drop
hugetlb_entry() hook point as the goal.

Taking a simplest mm walker (smaps) as example, I think most codes are
ready thanks to THP's existance, and also like vm_normal_page[_pmd]() which
should even already work for pfnmaps; pud layer is missing but that should
be trivial.  It means we may have chance to drop hugetlb_entry() without an
huge overhaul yet.

Now the important question I'm asking myself is: do we really need huge p4d
or even bigger?  It's 512GB on x86, and we said "No 512 GiB pages yet"
(commit fe1e8c3e963) since 2017 - that is 7 years without chaning this
fact.  While on non-x86 p4d_leaf() never defined.  Then it's also
interesting to see how many codes are "ready" to handle p4d entries (by
looking at p4d_leaf() calls; much easier to see with the removal of the
rest huge apis..) even if none existed.

So, can we over-engineer too much if we go the generic route now?
Considering that we already have most of pmd/pud entries around in the mm
walker ops.  So far it sounds better we leave it for later, until further
justifed to be useful.  And that won't block it if it ever justified to be
needed, I'd say it can also be seen as a step forward if I can make it to
remove hugetlb_entry() first.

Comments welcomed (before I start to work on anything..).

Thanks,

-- 
Peter Xu


