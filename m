Return-Path: <linux-kernel+bounces-154886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0178AE27C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28682B20DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB17E56C;
	Tue, 23 Apr 2024 10:41:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BC078C9A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868889; cv=none; b=gCEzbtjlGK1JDjwnz3n9SsgWOP9Wct9yuCnyfYx0S8Rh/gMTyJh9QO+4CDaJfqg7JSa8wn5vFeCqPXXaM7OdYGc/Yaj0xHU3/cdT8ph5KjqOBUwKjGS2Cv91bsi7gDsJxov3MS3zaKI0D6dR085oct9hbhJpfaOGffzaxl0o2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868889; c=relaxed/simple;
	bh=3oKcimRYJQ/XdLZiaAT41c0AZ7QVosTbTDGLlxdj5LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGJcja6dnSgknqz7WLtQCLoljOEhIDF4OzZiq2P2Eovxi4L8mLKAVgfVsZjZL1k9ZdvPe+Hg4XbnyNJOWyjdzVwasXBS2DrPJaMWmMkIQO+9yM5OJrJcqB3fSuI0/HqJSZLbhYsKRWujDr+vH4btbfhpfOGf/U8LEb/ts5bxWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7D0E339;
	Tue, 23 Apr 2024 03:41:54 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 420F13F7BD;
	Tue, 23 Apr 2024 03:41:25 -0700 (PDT)
Message-ID: <4b998e7d-153f-48cc-a9bb-8c84bb675581@arm.com>
Date: Tue, 23 Apr 2024 11:41:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add mTHP support for anonymous share pages
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 21cnbao@gmail.com, ying.huang@intel.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 08:02, Baolin Wang wrote:
> Anonymous pages have already been supported for multi-size (mTHP) allocation
> through commit 19eaf44954df, that can allow THP to be configured through the
> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
> 
> However, the anonymous shared pages will ignore the anonymous mTHP rule
> configured through the sysfs interface, and can only use the PMD-mapped
> THP, that is not reasonable. Many implement anonymous page sharing through
> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
> therefore, users expect to apply an unified mTHP strategy for anonymous pages,
> also including the anonymous shared pages, in order to enjoy the benefits of
> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.

This sounds like a very useful addition!

Out of interest, can you point me at any workloads (and off-the-shelf benchmarks
for those workloads) that predominantly use shared anon memory?

> 
> The primary strategy is that, the use of huge pages for anonymous shared pages
> still follows the global control determined by the mount option "huge=" parameter
> or the sysfs interface at '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
> The utilization of mTHP is allowed only when the global 'huge' switch is enabled.
> Subsequently, the mTHP sysfs interface (/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled)
> is checked to determine the mTHP size that can be used for large folio allocation
> for these anonymous shared pages.

I'm not sure about this proposed control mechanism; won't it break
compatibility? I could be wrong, but I don't think shmem's use of THP used to
depend upon the value of /sys/kernel/mm/transparent_hugepage/enabled? So it
doesn't make sense to me that we now depend upon the
/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled values (which by
default disables all sizes except 2M, which is set to "inherit" from
/sys/kernel/mm/transparent_hugepage/enabled).

The other problem is that shmem_enabled has a different set of options
(always/never/within_size/advise/deny/force) to enabled (always/madvise/never)

Perhaps it would be cleaner to do the same trick we did for enabled; Introduce
/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled, which can have all the
same values as the top-level /sys/kernel/mm/transparent_hugepage/shmem_enabled,
plus the additional "inherit" option. By default all sizes will be set to
"never" except 2M, which is set to "inherit".

Of course the huge= mount option would also need to take a per-size option in
this case. e.g. huge=2048kB:advise,64kB:always

> 
> TODO:
>  - More testing and provide some performance data.
>  - Need more discussion about the large folio allocation strategy for a 'regular
> file' operation created by memfd_create(), for example using ftruncate(fd) to specify
> the 'file' size, which need to follow the anonymous mTHP rule too?
>  - Do not split the large folio when share memory swap out.
>  - Can swap in a large folio for share memory.
> 
> Baolin Wang (5):
>   mm: memory: extend finish_fault() to support large folio
>   mm: shmem: add an 'order' parameter for shmem_alloc_hugefolio()
>   mm: shmem: add THP validation for PMD-mapped THP related statistics
>   mm: shmem: add mTHP support for anonymous share pages
>   mm: shmem: add anonymous share mTHP counters
> 
>  include/linux/huge_mm.h |   4 +-
>  mm/huge_memory.c        |   8 ++-
>  mm/memory.c             |  25 +++++++---
>  mm/shmem.c              | 107 ++++++++++++++++++++++++++++++----------
>  4 files changed, 108 insertions(+), 36 deletions(-)
> 


