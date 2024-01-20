Return-Path: <linux-kernel+bounces-31788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367108333FA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A2F2834F6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783BEDF46;
	Sat, 20 Jan 2024 12:04:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E7320F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705752276; cv=none; b=cyf+46QC0zs6lC16j9TMZb6JxR35FthdV+eCXiyFkwctq9jyevqfh69cb6kQHt7taTNc3h8mbp3P+sCx1Fq2e9o3/Z/gciXYWi+QkA6mFzoMCXwOjcUyMxkk6z/s7vsUu0quKFDdj/ErF/f0qTCDRzNBAqTonqrZTJmJmBqpLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705752276; c=relaxed/simple;
	bh=JGHHIeeSQkkhOiF9xDJpJfV8D72cqbDoW1Z0fU46CrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKXQO26GkCGZYOXlFibFradpAxnie+LERSEXsM1rFo73tlXz98+YhTK75SaAHFFXzGMp+171Lc7wCD2AkePTAMbG68pn225DH8nCd6qspV06wFMWteNBg3itXaqiiD4p/u9+ows4zK1cmN07dLBPWysll6f8uCFOgyw25FY14HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50EC7DA7;
	Sat, 20 Jan 2024 04:05:16 -0800 (PST)
Received: from [10.57.77.97] (unknown [10.57.77.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1925D3F73F;
	Sat, 20 Jan 2024 04:04:28 -0800 (PST)
Message-ID: <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>
Date: Sat, 20 Jan 2024 12:04:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com,
 shy828301@gmail.com, willy@infradead.org, cl@linux.com,
 akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231214223423.1133074-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/12/2023 22:34, Yang Shi wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Align larger anonymous memory mappings on THP boundaries by going through
> thp_get_unmapped_area if THPs are enabled for the current process.
> 
> With this patch, larger anonymous mappings are now THP aligned.  When a
> malloc library allocates a 2MB or larger arena, that arena can now be
> mapped with THPs right from the start, which can result in better TLB hit
> rates and execution time.
> 
> Link: https://lkml.kernel.org/r/20220809142457.4751229f@imladris.surriel.com
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christopher Lameter <cl@linux.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> This patch was applied to v6.1, but was reverted due to a regression
> report.  However it turned out the regression was not due to this patch.
> I ping'ed Andrew to reapply this patch, Andrew may forget it.  This
> patch helps promote THP, so I rebased it onto the latest mm-unstable.

Hi Yang,

I'm not sure what regression you are referring to above, but I'm seeing a
performance regression in the virtual_address_range mm selftest on arm64, caused
by this patch (which is now in v6.7).

I see 2 problems when running the test; 1) it takes much longer to execute, and
2) the test fails. Both are related:

The (first part of the) test allocates as many 1GB anonymous blocks as it can in
the low 256TB of address space, passing NULL as the addr hint to mmap. Before
this patch, all allocations were abutted and contained in a single, merged VMA.
However, after this patch, each allocation is in its own VMA, and there is a 2M
gap between each VMA. This causes 2 problems: 1) mmap becomes MUCH slower
because there are so many VMAs to check to find a new 1G gap. 2) It fails once
it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting this limit then
causes a subsequent calloc() to fail, which causes the test to fail.

Looking at the code, I think the problem is that arm64 selects
ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area() allocates
len+2M then always aligns to the bottom of the discovered gap. That causes the
2M hole. As far as I can see, x86 allocates bottom up, so you don't get a hole.

I'm not quite sure what the fix is - perhaps __thp_get_unmapped_area() should be
implemented around vm_unmapped_area(), which can manage the alignment more
intelligently?

But until/unless someone comes along with a fix, I think this patch should be
reverted.

Thanks,
Ryan


> 
> 
>  mm/mmap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9d780f415be3..dd25a2aa94f7 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2232,6 +2232,9 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  		 */
>  		pgoff = 0;
>  		get_area = shmem_get_unmapped_area;
> +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +		/* Ensures that larger anonymous mappings are THP aligned. */
> +		get_area = thp_get_unmapped_area;
>  	}
>  
>  	addr = get_area(file, addr, len, pgoff, flags);


