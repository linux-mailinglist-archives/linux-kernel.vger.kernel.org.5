Return-Path: <linux-kernel+bounces-30245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDB8831C29
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE38284B99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44E61E88D;
	Thu, 18 Jan 2024 15:15:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2061E532
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590952; cv=none; b=TMEgRtvZ4L7NffPER/uQ3DEDVd912Y6uHIZZ8IYNBi3h0P6JUMx4xPps2gg9aofhghiu1KNHK1+552QneL59+dZ1Q+1HnPRJfuJSWgomXQmY9uwpa6qdSQ82yN48SI3WfLw1DkkSjE0BYI/XO3KKmYlVHxPvl7agbnSeQcCS+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590952; c=relaxed/simple;
	bh=/hJ+jFjPcZBpWrtzOj9idrYCeyAyNSL3T466ON4vT4M=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=JkYFTENi//nHBaPY5WJBwk9Ecocm02RNjjQhDO35ixZ/m3MnCzWCbKjkN5rczcVVIV/gvuyTeckVZM9ufgEmg7TZNbWHCChvacfauWsJ8GRNgtplA6E5dk7L97rAvzOwhhT29QTtWu5yuRicsROOWU2ejgI4A/UKlA/EJJ8f83w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E4711042;
	Thu, 18 Jan 2024 07:16:27 -0800 (PST)
Received: from [10.57.77.97] (unknown [10.57.77.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE12B3F73F;
	Thu, 18 Jan 2024 07:15:37 -0800 (PST)
Message-ID: <9e60b948-0044-4826-8551-0a3888650657@arm.com>
Date: Thu, 18 Jan 2024 15:15:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] mm/gup: Drop folio_fast_pin_allowed() in hugepd
 processing
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "peterx@redhat.com" <peterx@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 James Houghton <jthoughton@google.com>, David Hildenbrand
 <david@redhat.com>, "Kirill A . Shutemov" <kirill@shutemov.name>,
 Yang Shi <shy828301@gmail.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Rik van Riel <riel@surriel.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Mike Rapoport <rppt@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
 Michael Ellerman <mpe@ellerman.id.au>, Andrew Jones
 <andrew.jones@linux.dev>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Christoph Hellwig
 <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20240103091423.400294-1-peterx@redhat.com>
 <20240103091423.400294-7-peterx@redhat.com>
 <20240115183748.GR734935@nvidia.com>
 <c60c9d88-33aa-4312-a23c-20206e503b6e@csgroup.eu>
 <20240116123138.GZ734935@nvidia.com>
 <44e450cb-5d3f-407e-97a3-024eb936f74b@csgroup.eu>
 <20240117132243.GG734935@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240117132243.GG734935@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 13:22, Jason Gunthorpe wrote:
> On Tue, Jan 16, 2024 at 06:32:32PM +0000, Christophe Leroy wrote:
>>>> hugepd is a page directory dedicated to huge pages, where you have huge
>>>> pages listed instead of regular pages. For instance, on powerpc 32 with
>>>> each PGD entries covering 4Mbytes, a regular page table has 1024 PTEs. A
>>>> hugepd for 512k is a page table with 8 entries.
>>>>
>>>> And for 8Mbytes entries, the hugepd is a page table with only one entry.
>>>> And 2 consecutive PGS entries will point to the same hugepd to cover the
>>>> entire 8Mbytes.
>>>
>>> That still sounds alot like the ARM thing - except ARM replicates the
>>> entry, you also said PPC relicates the entry like ARM to get to the
>>> 8M?
>>
>> Is it like ARM ? Not sure. The PTE is not in the PGD it must be in a L2 
>> directory, even for 8M.
> 
> Your diagram looks almost exactly like ARM to me.
> 
> The key thing is that the address for the L2 Table is *always* formed as:
> 
>    L2 Table Base << 12 + L2 Index << 2 + 00
> 
> Then the L2 Descriptor must contains bits indicating the page
> size. The L2 Descriptor is replicated to every 4k entry that the page
> size covers.
> 
> The only difference I see is the 8M case which has a page size greater
> than a single L1 entry.
> 
>> Yes that's how it works on powerpc. For 8xx we used to do that for both 
>> 8M and 512k pages. Now for 512k pages we do kind of like ARM (which 
>> means replicating the entry 128 times) as that's needed to allow mixing 
>> different page sizes for a given PGD entry.
> 
> Right, you want to have granular page sizes or it becomes unusable in
> the general case
>  
>> But for 8M pages that would mean replicating the entry 2048 times. 
>> That's a bit too much isn't it ?
> 
> Indeed, de-duplicating the L2 Table is a neat optimization.
> 
>>> So if you imagine a pmd_leaf(), pmd_leaf_size() and a pte_leaf_size()
>>> that would return enough information for both.
>>
>> pmd_leaf() ? Unless I'm missing something I can't do leaf at PMD (PGD) 
>> level. It must be a two-level process even for pages bigger than a PMD 
>> entry.
> 
> Right, this is the normal THP/hugetlb situation on x86/etc. It
> wouldn't apply here since it seems the HW doesn't have a bit in the L1
> descriptor to indicate leaf.
> 
> Instead for PPC this hugepd stuff should start to follow Ryan's
> generic work for ARM contig:
> 
> https://lore.kernel.org/all/20231218105100.172635-1-ryan.roberts@arm.com/
> 
> Specifically the arch implementation:
> 
> https://lore.kernel.org/linux-mm/20231218105100.172635-15-ryan.roberts@arm.com/
> 
> Ie the arch should ultimately wire up the replication and variable
> page size bits within its implementation of set_ptes(). set_ptes()s
> gets a contiguous run of address and should install it with maximum
> use of the variable page sizes. The core code will start to call
> set_ptes() in more cases as Ryan gets along his project.

Note that it's not just set_ptes() that you want to batch; there are other calls
that can benefit too. See patches 2 and 3 in the series you linked. (although
I'm working with DavidH on this and the details are going to change a little).

> 
> For the purposes of GUP, where are are today and where we are going,
> it would be much better to not have a special PPC specific "hugepd"
> parser. Just process each of the 4k replicates one by one like ARM is
> starting with.
> 
> The arch would still have to return the correct page address from
> pte_phys() which I think Ryan is doing by having the replicates encode
> the full 4k based address in each entry.

Yes; although its actually also a requirement of the arm architecture. Since the
contig bit is just a hint that the HW may or may not take any notice of, the
page tables have to be correct for the case where the HW just reads them in base
pages. Fixing up the bottom bits should be trivial using the PTE pointer, if
needed for ppc.

> The HW will ignore those low
> bits and pte_phys() then works properly. This would work for PPC as
> well, excluding the 8M optimization.
> 
> Going forward I'd expect to see some pte_page_size() that returns the
> size bits and GUP can have logic to skip reading replicates.

Yes; pte_batch_remaining() in patch 2 is an attempt at this. But as I said the
details will likely change a little.

> 
> The advantage of all this is that it stops making the feature special
> and the work Ryan is doing to generically push larger folios into
> set_ptes will become usable on these PPC platforms as well. And we can
> kill the PPC specific hugepd.
> 
> Jason


