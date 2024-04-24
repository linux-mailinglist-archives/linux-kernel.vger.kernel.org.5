Return-Path: <linux-kernel+bounces-156430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2CB8B02B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA945B23860
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5F1158A0B;
	Wed, 24 Apr 2024 06:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZFNk3/00"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DC4157A58
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941740; cv=none; b=t3iEXU+L0fowCnJ/XA9sDzbyyRaVNO24NjWhKGFMGC4Pmh0gNtievFWfJWiKf2B74JOw05F5OfO6H/sn8iiBHlQCiPeyu3cXshwl7AOAgMRvATms/0UOzt+EBAZVGgDK28evBK8BoXujAhn96XJfGJBWXOT6bCR9QNH4Yaw4/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941740; c=relaxed/simple;
	bh=TXRX2uyfbwu6I5DEAHexhw0wFLD0sAWld9bXxN+zwSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2hWWGc/VBOJC6GoRNUpPBeGYLNzdd4SPFTkAcuD0AFJrP35lTE0BHn1i48C8xi8zUPeUIvH1vTUZ4DCROyvX6y/fdDYFKSwN9eMjJbRAqvETUU2o3V63lh1rk+q+p+V00aWElpliHV5wH5AOeoyC1icNSyvaUY6C2qa1CrZyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZFNk3/00; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713941730; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=b07EZ7LT5dczTtPhKaX3n1AzQq/O2KWgxHIqHzYhZFM=;
	b=ZFNk3/006oB9kJLX2VAIsE52s2taRCMYv8h6MjTchAYAYFL4wxN2MR0/icjOrGGEZZ2IGqIBdr/nxri1jNKlOq6hPwMLgslce9hPkw1UnUyBE3t9BWTFjdkWogfU8CbHxMmZvKE2FxkTiE8PdzHxf5+jcxtMg6u1p+cYGqxxcEQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5BTi-9_1713941726;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5BTi-9_1713941726)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 14:55:28 +0800
Message-ID: <c1f68109-7665-4905-996f-f1067dfa2cb6@linux.alibaba.com>
Date: Wed, 24 Apr 2024 14:55:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add mTHP support for anonymous share pages
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 21cnbao@gmail.com, ying.huang@intel.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <4b998e7d-153f-48cc-a9bb-8c84bb675581@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <4b998e7d-153f-48cc-a9bb-8c84bb675581@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/23 18:41, Ryan Roberts wrote:
> On 22/04/2024 08:02, Baolin Wang wrote:
>> Anonymous pages have already been supported for multi-size (mTHP) allocation
>> through commit 19eaf44954df, that can allow THP to be configured through the
>> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>
>> However, the anonymous shared pages will ignore the anonymous mTHP rule
>> configured through the sysfs interface, and can only use the PMD-mapped
>> THP, that is not reasonable. Many implement anonymous page sharing through
>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
>> therefore, users expect to apply an unified mTHP strategy for anonymous pages,
>> also including the anonymous shared pages, in order to enjoy the benefits of
>> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
>> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.
> 
> This sounds like a very useful addition!
> 
> Out of interest, can you point me at any workloads (and off-the-shelf benchmarks
> for those workloads) that predominantly use shared anon memory?

As far as I know, some database related workloads make extensive use of 
shared anonymous page, such as PolarDB[1] in our Alibaba fleet, or MySQL 
likely also uses shared anonymous memory. And I still need to do some 
investigation to measure the performance.

[1] https://github.com/ApsaraDB/PolarDB-for-PostgreSQL

>> The primary strategy is that, the use of huge pages for anonymous shared pages
>> still follows the global control determined by the mount option "huge=" parameter
>> or the sysfs interface at '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>> The utilization of mTHP is allowed only when the global 'huge' switch is enabled.
>> Subsequently, the mTHP sysfs interface (/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled)
>> is checked to determine the mTHP size that can be used for large folio allocation
>> for these anonymous shared pages.
> 
> I'm not sure about this proposed control mechanism; won't it break
> compatibility? I could be wrong, but I don't think shmem's use of THP used to
> depend upon the value of /sys/kernel/mm/transparent_hugepage/enabled? So it

Yes, I realized this after more testing.

> doesn't make sense to me that we now depend upon the
> /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled values (which by
> default disables all sizes except 2M, which is set to "inherit" from
> /sys/kernel/mm/transparent_hugepage/enabled).
> 
> The other problem is that shmem_enabled has a different set of options
> (always/never/within_size/advise/deny/force) to enabled (always/madvise/never)
> 
> Perhaps it would be cleaner to do the same trick we did for enabled; Introduce
> /mm/transparent_hugepage/hugepage-XXkb/shmem_enabled, which can have all the
> same values as the top-level /sys/kernel/mm/transparent_hugepage/shmem_enabled,
> plus the additional "inherit" option. By default all sizes will be set to
> "never" except 2M, which is set to "inherit".

Sounds good to me. But I do not want to copy all same values from 
top-level '/sys/kernel/mm/transparent_hugepage/shmem_enabled':
always within_size advise never deny force

For mTHP's shmem_enabled interface, we can just keep below values:
always within_size advise never

Cause when checking if mTHP can be used for anon shmem, 'deny' is equal 
to 'never', and 'force' is equal to 'always'.

> Of course the huge= mount option would also need to take a per-size option in
> this case. e.g. huge=2048kB:advise,64kB:always

IMO, I do not want to change the global 'huge=' mount option, which can 
control both anon shmem and tmpfs, but mTHP now is only applied for anon 
shmem. So let's keep it be same with the global sysfs interface: 
/sys/kernel/mm/transparent_hugepage/shmem_enabled.

For tmpfs large folio strategy, I plan to address it later, and we may 
need more discussion to determine if it should follow the file large 
folio strategy or not (no investigation now).

Thanks for reviewing.

>> TODO:
>>   - More testing and provide some performance data.
>>   - Need more discussion about the large folio allocation strategy for a 'regular
>> file' operation created by memfd_create(), for example using ftruncate(fd) to specify
>> the 'file' size, which need to follow the anonymous mTHP rule too?
>>   - Do not split the large folio when share memory swap out.
>>   - Can swap in a large folio for share memory.
>>
>> Baolin Wang (5):
>>    mm: memory: extend finish_fault() to support large folio
>>    mm: shmem: add an 'order' parameter for shmem_alloc_hugefolio()
>>    mm: shmem: add THP validation for PMD-mapped THP related statistics
>>    mm: shmem: add mTHP support for anonymous share pages
>>    mm: shmem: add anonymous share mTHP counters
>>
>>   include/linux/huge_mm.h |   4 +-
>>   mm/huge_memory.c        |   8 ++-
>>   mm/memory.c             |  25 +++++++---
>>   mm/shmem.c              | 107 ++++++++++++++++++++++++++++++----------
>>   4 files changed, 108 insertions(+), 36 deletions(-)
>>

