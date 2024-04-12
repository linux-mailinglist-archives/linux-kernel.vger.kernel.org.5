Return-Path: <linux-kernel+bounces-142483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15CC8A2C27
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CC91C2177C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D02F53816;
	Fri, 12 Apr 2024 10:20:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60844369
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917201; cv=none; b=SoIcF/LtDJTicJVMRk8x8/2LctUNeSTi9KfxzjrHnMdEvFA3lV/r3X76VE7sJNYh9hkvsvXQ4FAZrNy7BHpGPHajDhUi5d9n2nEydSyM1tcIpFzhif0EudgZdR2KV5qiN6v+vxGfzxQXk6bpqT6uGFJKWi+fw7JclHM72sHKIx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917201; c=relaxed/simple;
	bh=K9W+Y4I98n2qqn8cSmOOvctrkBrlVZxDqpqIIWfNgRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW/GXMg9Hw9TgkbLMajQOy3PpKQGzo2H4KFGMcLbd5sBFLYMJLgYQhBlIqo20kHejqnt2LxLp6+XxvTNcMdqQawTUEb+usWxToH2xPyM/kvwqQLfo9VEMTx146arL2a1UvMcqmWe958AB00qqX+Jr5CkbnVMqz842U4VH4OuE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C11CD339;
	Fri, 12 Apr 2024 03:20:28 -0700 (PDT)
Received: from [10.57.73.208] (unknown [10.57.73.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82D393F64C;
	Fri, 12 Apr 2024 03:19:57 -0700 (PDT)
Message-ID: <b1f417fb-1f8b-4349-a6bc-97694b92587f@arm.com>
Date: Fri, 12 Apr 2024 11:19:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] mm: add docs for per-order mTHP counters and
 transhuge_page ABI
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com, chrisl@kernel.org, david@redhat.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, peterx@redhat.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com, corbet@lwn.net
References: <20240412073740.294272-1-21cnbao@gmail.com>
 <20240412073740.294272-4-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240412073740.294272-4-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2024 08:37, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This patch includes documentation for mTHP counters and an ABI file
> for sys-kernel-mm-transparent-hugepage, which appears to have been
> missing for some time.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>

A few nits, but regardless:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  .../sys-kernel-mm-transparent-hugepage        | 17 +++++++++++
>  Documentation/admin-guide/mm/transhuge.rst    | 28 +++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage
> 
> diff --git a/Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage b/Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage
> new file mode 100644
> index 000000000000..80dde0fd576c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sys-kernel-mm-transparent-hugepage
> @@ -0,0 +1,17 @@
> +What:		/sys/kernel/mm/hugepages/

Err, transparent_hugepage, right? copy/paste error?

> +Date:		April 2024
> +Contact:	Barry Song <baohua@kernel.org>

Looks like a bunch of mm sysfs interfaces use:

Contact:	Linux memory management mailing list <linux-mm@kvack.org>

I'll leave that up to you!

> +Description:
> +		/sys/kernel/mm/transparent_hugepage/ contains a number of files and
> +		subdirectories,
> +			- defrag
> +			- enabled
> +			- hpage_pmd_size
> +			- khugepaged
> +			- shmem_enabled
> +			- use_zero_page
> +			- subdirectories of the form hugepages-<size>kB, where <size>
> +			  is the page size of the hugepages supported by the kernel/CPU
> +			  combination.
> +
> +		See Documentation/admin-guide/mm/transhuge.rst for details.> diff --git a/Documentation/admin-guide/mm/transhuge.rst
b/Documentation/admin-guide/mm/transhuge.rst
> index 04eb45a2f940..f436ff982f22 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -447,6 +447,34 @@ thp_swpout_fallback
>  	Usually because failed to allocate some continuous swap space
>  	for the huge page.
>  
> +In /sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/stats, There are
> +also individual counters for each huge page size, which can be utilized to
> +monitor the system's effectiveness in providing huge pages for usage. Each
> +counter has its own corresponding file.
> +
> +anon_fault_alloc
> +	is incremented every time a huge page is successfully
> +	allocated and charged to handle a page fault.
> +
> +anon_fault_fallback
> +	is incremented if a page fault fails to allocate or charge
> +	a huge page and instead falls back to using huge pages with
> +	lower orders or small pages.
> +
> +anon_fault_fallback_charge
> +	is incremented if a page fault fails to charge a huge page and
> +	instead falls back to using huge pages with lower orders or
> +	small pages even though the allocation was successful.
> +
> +anon_swpout
> +	is incremented every time a huge page is swapout in one

nit: swapout -> "swapped out"? Although I see this is just a copy/paste of the
description of the existing counter...

> +	piece without splitting.
> +
> +anon_swpout_fallback
> +	is incremented if a huge page has to be split before swapout.
> +	Usually because failed to allocate some continuous swap space
> +	for the huge page.
> +
>  As the system ages, allocating huge pages may be expensive as the
>  system uses memory compaction to copy data around memory to free a
>  huge page for use. There are some counters in ``/proc/vmstat`` to help


