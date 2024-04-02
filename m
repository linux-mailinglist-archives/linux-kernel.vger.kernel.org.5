Return-Path: <linux-kernel+bounces-128237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF9C895821
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC361C22460
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2F12F393;
	Tue,  2 Apr 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPpGzZ3b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854912E1C1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071597; cv=none; b=r9ZOjnPd1QZayopMpmb8i9U0L7Jke52ehYbZPFg3/ByvA2LdwO5ScOov40ThOqLZY2VMzdkOheblWS0a7Ozs1UcZNO5JucQg751xJHqHLCRvvYhdTMsyuV3uO5l3DNajhsNJk4+VuNavIwmFO8q6oR4CV3rQadj1cuAS2nCyc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071597; c=relaxed/simple;
	bh=E0A2lgk54sv3MhBYSpBeens9YutKvatDYbJYgr+fU0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CedshDekpSkrvPO/W6x7BohK3b2OG+KoGnVzj/rAsoQpJRgiosX20gdXoEBN3CnFur+r1E6LEBRYJAC8Y5jB212fq8cQpnxI7TlPlWi15ZiV6oSQrg8CnQozKzwRSMnt/uOINCzaV002gR28mrFpvGsLQW2vT0DvVD4tbaRADzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPpGzZ3b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712071594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7z79/IwwmLCGU8YotNChJ6Ql1s/A3SEmP5H2/HA6uBA=;
	b=IPpGzZ3bjF1d2CHKsakCGR5OF6LolWo3gxXzD24F7bkVIz/tzErITGxymwkf0kdgc5mreI
	17GqPie3lvsAoAP9vGTLgv8lW1oWQe/mbkzCJ+uHHnAH2dDHhHsZTD7jwmONLk9rUBfK6w
	FgEFFe/CfWzCdbIIDRdyUaLrfcFKi7Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-9MHioANnPDKW9ISNps6NAw-1; Tue, 02 Apr 2024 11:26:32 -0400
X-MC-Unique: 9MHioANnPDKW9ISNps6NAw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34356b6e988so652531f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 08:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712071591; x=1712676391;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7z79/IwwmLCGU8YotNChJ6Ql1s/A3SEmP5H2/HA6uBA=;
        b=DN4e19AFzhGwi24obqSTNtZ7udUXZ0qn8wm42fupS72gPP3Cbq0JILOS3MMneF37cp
         RFLU8c5ICRlVf2K+dXPrTuZ3S6ROJ4269P2ZsHx8ErdPGXAc0L2+yUuOPrIeMS5LB8ac
         +zwrT8RZsYTMFTUyJNmR0clyjFDXorPWM6xmEhqW7gt5IlRNpFHDFcFApYgDQhejEwgi
         hAwrIyD13sUF06XI5ddoZdKpFF2LAlgDsxDVShV4ORkzVak3r56xPgkB9TACwS1omdpX
         kjBrcxBLYKQrZ7arxNecKQRlvVo0jx2OIOHzzzAtfMdmEZse+TsIl90f2+bxBrCq3OWF
         luEA==
X-Forwarded-Encrypted: i=1; AJvYcCUWU1gubkdy3JmZF9GEUYOnxLGNwBzIsoW2B2NVytKmlniPduzp1cFuteDz3Zs8emSLLDZxCJxU6dSMDVv9q/csdTJj2hOlhYoW5nKP
X-Gm-Message-State: AOJu0YwG44pZJI4eD5+82+LTD0k26ulLFRC0Ugb6I4Z4o16zW68M1LpW
	qZte2/qN6bHUa8+m2QdTp/IXXjXJv+qEt0MK3YdBbtrzfFFF9TS+LTxROa7qFkzJ3LvSx4DB2SI
	GmNcLn7MqPQxpkguAVBAK86uvDIMSJ8Lnq9A1fhnQAQQ5rlznUFQtp38+kIISEw==
X-Received: by 2002:a5d:474b:0:b0:343:6b09:653c with SMTP id o11-20020a5d474b000000b003436b09653cmr1611340wrs.43.1712071591412;
        Tue, 02 Apr 2024 08:26:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8SQOIZIZWhyBPTQm8MQ4jJTitAgfdzsVz9+NbSlk8sRvUDLsA7jSkSjvpJpo4JPfjy/OfOQ==
X-Received: by 2002:a5d:474b:0:b0:343:6b09:653c with SMTP id o11-20020a5d474b000000b003436b09653cmr1611299wrs.43.1712071590903;
        Tue, 02 Apr 2024 08:26:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c732:e600:4982:2903:710f:f20a? (p200300cbc732e60049822903710ff20a.dip0.t-ipconnect.de. [2003:cb:c732:e600:4982:2903:710f:f20a])
        by smtp.gmail.com with ESMTPSA id m19-20020a056000025300b0033e7de97214sm14353604wrz.40.2024.04.02.08.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 08:26:30 -0700 (PDT)
Message-ID: <5d9dd9a7-e544-4741-944c-469b79c2c649@redhat.com>
Date: Tue, 2 Apr 2024 17:26:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] mm/gup: Handle hugetlb in the generic
 follow_page_mask code
To: Ryan Roberts <ryan.roberts@arm.com>, peterx@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Yang Shi <shy828301@gmail.com>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, Mike Kravetz <mike.kravetz@oracle.com>,
 John Hubbard <jhubbard@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Jones <andrew.jones@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Rik van Riel <riel@surriel.com>,
 linux-arm-kernel@lists.infradead.org, Andrea Arcangeli
 <aarcange@redhat.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, James Houghton <jthoughton@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>
References: <20240327152332.950956-1-peterx@redhat.com>
 <20240327152332.950956-14-peterx@redhat.com>
 <adfdd89b-ee56-4758-836e-c66a0be7de25@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <adfdd89b-ee56-4758-836e-c66a0be7de25@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.24 16:48, Ryan Roberts wrote:
> Hi Peter,
> 
> On 27/03/2024 15:23, peterx@redhat.com wrote:
>> From: Peter Xu <peterx@redhat.com>
>>
>> Now follow_page() is ready to handle hugetlb pages in whatever form, and
>> over all architectures.  Switch to the generic code path.
>>
>> Time to retire hugetlb_follow_page_mask(), following the previous
>> retirement of follow_hugetlb_page() in 4849807114b8.
>>
>> There may be a slight difference of how the loops run when processing slow
>> GUP over a large hugetlb range on cont_pte/cont_pmd supported archs: each
>> loop of __get_user_pages() will resolve one pgtable entry with the patch
>> applied, rather than relying on the size of hugetlb hstate, the latter may
>> cover multiple entries in one loop.
>>
>> A quick performance test on an aarch64 VM on M1 chip shows 15% degrade over
>> a tight loop of slow gup after the path switched.  That shouldn't be a
>> problem because slow-gup should not be a hot path for GUP in general: when
>> page is commonly present, fast-gup will already succeed, while when the
>> page is indeed missing and require a follow up page fault, the slow gup
>> degrade will probably buried in the fault paths anyway.  It also explains
>> why slow gup for THP used to be very slow before 57edfcfd3419 ("mm/gup:
>> accelerate thp gup even for "pages != NULL"") lands, the latter not part of
>> a performance analysis but a side benefit.  If the performance will be a
>> concern, we can consider handle CONT_PTE in follow_page().
>>
>> Before that is justified to be necessary, keep everything clean and simple.
>>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Afraid I'm seeing an oops when running gup_longterm test on arm64 with current mm-unstable. Git bisect blames this patch. The oops reproduces for me every time on 2 different machines:
> 
> 
> [    9.340416] kernel BUG at mm/gup.c:778!
> [    9.340746] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> [    9.341199] Modules linked in:
> [    9.341481] CPU: 1 PID: 1159 Comm: gup_longterm Not tainted 6.9.0-rc2-00210-g910ff1a347e4 #11
> [    9.342232] Hardware name: linux,dummy-virt (DT)
> [    9.342647] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    9.343195] pc : follow_page_mask+0x4d4/0x880
> [    9.343580] lr : follow_page_mask+0x4d4/0x880
> [    9.344018] sp : ffff8000898b3aa0
> [    9.344345] x29: ffff8000898b3aa0 x28: fffffdffc53973e8 x27: 00003c0005d08000
> [    9.345028] x26: ffff00014e5cfd08 x25: ffffd3513a40c000 x24: fffffdffc5d08000
> [    9.345682] x23: ffffc1ffc0000000 x22: 0000000000080101 x21: ffff8000898b3ba8
> [    9.346337] x20: 0000fffff4200000 x19: ffff00014e52d508 x18: 0000000000000010
> [    9.347005] x17: 5f656e6f7a5f7369 x16: 2120262620296567 x15: 6170286461654865
> [    9.347713] x14: 6761502128454741 x13: 2929656761702865 x12: 6761705f65636976
> [    9.348371] x11: 65645f656e6f7a5f x10: ffffd3513b31d6e0 x9 : ffffd3513852f090
> [    9.349062] x8 : 00000000ffffefff x7 : ffffd3513b31d6e0 x6 : 0000000000000000
> [    9.349753] x5 : ffff00017ff98cc8 x4 : 0000000000000fff x3 : 0000000000000000
> [    9.350397] x2 : 0000000000000000 x1 : ffff000190e8b480 x0 : 0000000000000052
> [    9.351097] Call trace:
> [    9.351312]  follow_page_mask+0x4d4/0x880
> [    9.351700]  __get_user_pages+0xf4/0x3e8
> [    9.352089]  __gup_longterm_locked+0x204/0xa70
> [    9.352516]  pin_user_pages+0x88/0xc0
> [    9.352873]  gup_test_ioctl+0x860/0xc40
> [    9.353249]  __arm64_sys_ioctl+0xb0/0x100
> [    9.353648]  invoke_syscall+0x50/0x128
> [    9.354022]  el0_svc_common.constprop.0+0x48/0xf8
> [    9.354488]  do_el0_svc+0x28/0x40
> [    9.354822]  el0_svc+0x34/0xe0
> [    9.355128]  el0t_64_sync_handler+0x13c/0x158
> [    9.355489]  el0t_64_sync+0x190/0x198
> [    9.355793] Code: aa1803e0 d000d8e1 91220021 97fff560 (d4210000)
> [    9.356280] ---[ end trace 0000000000000000 ]---
> [    9.356651] note: gup_longterm[1159] exited with irqs disabled
> [    9.357141] note: gup_longterm[1159] exited with preempt_count 2
> [    9.358033] ------------[ cut here ]------------
> [    9.358800] WARNING: CPU: 1 PID: 0 at kernel/context_tracking.c:128 ct_kernel_exit.constprop.0+0x108/0x120
> [    9.360157] Modules linked in:
> [    9.360541] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D            6.9.0-rc2-00210-g910ff1a347e4 #11
> [    9.361626] Hardware name: linux,dummy-virt (DT)
> [    9.362087] pstate: 204003c5 (nzCv DAIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    9.362758] pc : ct_kernel_exit.constprop.0+0x108/0x120
> [    9.363306] lr : ct_idle_enter+0x10/0x20
> [    9.363845] sp : ffff8000801abdc0
> [    9.364222] x29: ffff8000801abdc0 x28: 0000000000000000 x27: 0000000000000000
> [    9.364961] x26: 0000000000000000 x25: ffff00014149d780 x24: 0000000000000000
> [    9.365557] x23: 0000000000000000 x22: ffffd3513b299d48 x21: ffffd3513a785730
> [    9.366239] x20: ffffd3513b299c28 x19: ffff00017ffa7da0 x18: 0000fffff5ffffff
> [    9.366869] x17: 0000000000000000 x16: 1fffe0002a21a8c1 x15: 0000000000000000
> [    9.367524] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000002
> [    9.368207] x11: 0000000000000001 x10: 0000000000000ad0 x9 : ffffd35138589230
> [    9.369123] x8 : ffff00014149e2b0 x7 : 0000000000000000 x6 : 000000000f8c0fb2
> [    9.370403] x5 : 4000000000000002 x4 : ffff2cb045825000 x3 : ffff8000801abdc0
> [    9.371170] x2 : ffffd3513a782da0 x1 : 4000000000000000 x0 : ffffd3513a782da0
> [    9.372279] Call trace:
> [    9.372519]  ct_kernel_exit.constprop.0+0x108/0x120
> [    9.373216]  ct_idle_enter+0x10/0x20
> [    9.373562]  default_idle_call+0x3c/0x160
> [    9.374055]  do_idle+0x21c/0x280
> [    9.374394]  cpu_startup_entry+0x3c/0x50
> [    9.374797]  secondary_start_kernel+0x140/0x168
> [    9.375220]  __secondary_switched+0xb8/0xc0
> [    9.375875] ---[ end trace 0000000000000000 ]---
> 
> 
> The oops trigger is at mm/gup.c:778:
> VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
> 
> 
> This is the output of gup_longterm (last output is just before oops):
> 
> # [INFO] detected hugetlb page size: 2048 KiB
> # [INFO] detected hugetlb page size: 32768 KiB
> # [INFO] detected hugetlb page size: 64 KiB
> # [INFO] detected hugetlb page size: 1048576 KiB
> TAP version 13
> 1..70
> # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd
> ok 1 Should have worked
> # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with tmpfile
> ok 2 Should have failed
> # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with local tmpfile
> ok 3 Should have failed
> # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (2048 kB)
> ok 4 Should have worked
> # [RUN] R/W longterm GUP pin in MAP_SHARED file mapping ... with memfd hugetlb (32768 kB)
> 
> 
> So 2M passed ok, and its failing for 32M, which is cont-pmd. I'm guessing you're trying to iterate 2M into a cont-pmd folio and ending up with an unexpected tail page?

I assume we find the expected tail page, it's just that the check

VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);

Doesn't make sense with hugetlb folios. We might have a tail page mapped 
in a cont-pmd entry. As soon as we call follow_huge_pmd() on "not the 
first cont-pmd entry", we trigger this check.

Likely this sanity check must also allow for hugetlb folios. Or we 
should just remove it completely.

In the past, we wanted to make sure that we never get tail pages of THP 
from PMD entries, because something would currently be broken (we don't 
support THP > PMD).

-- 
Cheers,

David / dhildenb


