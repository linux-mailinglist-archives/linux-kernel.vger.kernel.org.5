Return-Path: <linux-kernel+bounces-86694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A04586C91C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2881C22C25
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1A57D080;
	Thu, 29 Feb 2024 12:21:56 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8767C0B9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209316; cv=none; b=Yuqr3qavrNGME7AXNKZ3JN2lrKRHXzo2bhoweGdpOFxY0HOUDOe/LjucuHZ7+0ThIyiiSnl4VBpkPBN+Xts3Fah20k7NWf368qhcO3OnwrYvrONlFDgFOM6EDEhSJAW9qBvlVHPULCTKK1uPbnEbTUnYQY/NpjyQxsjFGJ2mlQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209316; c=relaxed/simple;
	bh=v4fm/0Jn2L/Ipgu9QqWTjs/UX0h2u9JyctTVG6vxe/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MmYc2belQ1Ib0uM2vnx1D2jxM2Pshrl1DbE7HaZHKC7Uk5ssaF2dHjVqe1vLwqnyHzWn66jrfyYA+wcVMfxExrCPpsCZ7QEviYEO51lzNy/oeziui/esejvKfkIXFIQQ/Rbk2HjJDb8MZDFMz1j07ZymvLkevYYyb02ZIYHupeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Tlr0w1h5zzqjgr;
	Thu, 29 Feb 2024 20:21:04 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id D859118002D;
	Thu, 29 Feb 2024 20:21:41 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 20:21:40 +0800
Message-ID: <958b204f-63ec-55b3-b6e2-dc72a3ce704d@huawei.com>
Date: Thu, 29 Feb 2024 20:21:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: <akpm@linux-foundation.org>, <willy@infradead.org>,
	<ying.huang@intel.com>, <fengwei.yin@intel.com>,
	<aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>, <hughd@google.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20240229060907.836589-1-zhangpeng362@huawei.com>
 <038e55eb-70a9-445d-89ef-4b989eaa9c66@redhat.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <038e55eb-70a9-445d-89ef-4b989eaa9c66@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/2/29 16:56, David Hildenbrand wrote:

> On 29.02.24 07:09, Peng Zhang wrote:
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>> in application, which leading to an unexpected issue[1].
>>
>> This caused by temporarily cleared PTE during a read+clear/modify/write
>> update of the PTE, eg, do_numa_page()/change_pte_range().
>>
>> For the data segment of the user-mode program, the global variable area
>> is a private mapping. After the pagecache is loaded, the private 
>> anonymous
>> page is generated after the COW is triggered. Mlockall can lock COW 
>> pages
>> (anonymous pages), but the original file pages cannot be locked and may
>> be reclaimed. If the global variable (private anon page) is accessed 
>> when
>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>> At this time, the original private file page may have been reclaimed.
>> If the page cache is not available at this time, a major fault will be
>> triggered and the file will be read, causing additional overhead.
>>
>> This issue affects our traffic analysis service. The inbound traffic is
>> heavy. If a major fault occurs, the I/O schedule is triggered and the
>> original I/O is suspended. Generally, the I/O schedule is 0.7 ms. If
>> other applications are operating disks, the system needs to wait for
>> more than 10 ms. However, the inbound traffic is heavy and the NIC 
>> buffer
>> is small. As a result, packet loss occurs. But the traffic analysis 
>> service
>> can't tolerate packet loss.
>>
>> Fix this by holding PTL and rechecking the PTE in filemap_fault() before
>> triggering a major fault. We do this check only if vma is VM_LOCKED. In
>> our service test environment, the baseline is 7 major faults / 12 hours.
>> After the patch is applied, no major fault will be triggered.
>>
>> Testing file anonymous page read and write page fault performance in
>> ext4, tmpfs and ramdisk using will-it-scale[2] on a x86 physical 
>> machine.
>> The data is the average change compared with the mainline after the 
>> patch
>> is applied. The test results are indicates some performance regressions.
>> We do this check only if vma is VM_LOCKED, therefore, no performance
>> regressions is caused for most common cases.
>>
>> The test results are as follows:
>>                            processes processes_idle threads threads_idle
>> ext4    private file write: -0.51%    0.08%          -0.03% -0.04%
>> ext4    shared  file write:  0.135%  -0.531%          2.883% -0.772%
>> ramdisk private file write: -0.48%    0.23%          -1.08% 0.27%
>> ramdisk private file  read:  0.07%   -6.90%          -5.85% -0.70%
>> tmpfs   private file write: -0.344%  -0.110%          0.200% 0.145%
>> tmpfs   shared  file write:  0.958%   0.101%          2.781% -0.337%
>> tmpfs   private file  read: -0.16%    0.00%          -0.12% 0.41%
>>
>> [1] 
>> https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>> [2] https://github.com/antonblanchard/will-it-scale/
>>
>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>> v2->v3:
>> - Do this check only if vma is VM_LOCKED per David Hildenbrand
>> - Hold PTL and recheck the PTE
>> - Place the recheck code in a new function filemap_fault_recheck_pte()
>>
>> v1->v2:
>> - Add more test results per Huang, Ying
>> - Add more comments before check PTE per Huang, Ying, David Hildenbrand
>>    and Yin Fengwei
>> - Change pte_offset_map_nolock to pte_offset_map as the PTL won't
>>    be used
>>
>> RFC->v1:
>> - Add error handling when ptep == NULL per Huang, Ying and Matthew
>>    Wilcox
>> - Check the PTE without acquiring PTL in filemap_fault(), suggested by
>>    Huang, Ying and Yin Fengwei
>> - Add pmd_none() check before PTE map
>> - Update commit message and add performance test information
>>
>>   mm/filemap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index b4858d89f1b1..2668bac68df7 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3181,6 +3181,42 @@ static struct file 
>> *do_async_mmap_readahead(struct vm_fault *vmf,
>>       return fpin;
>>   }
>>   +/*
>> + * filemap_fault_recheck_pte - hold PTL and recheck whether pte is 
>> none.
>> + * @vmf - the vm_fault for this fault.
>> + *
>> + * Recheck PTE as the PTE can be cleared temporarily during a 
>> read+clear/modify
>> + * /write update of the PTE, eg, do_numa_page()/change_pte_range(). 
>> This will
>> + * trigger an unexpected major fault, even if we use mlockall(), 
>> which may
>> + * increase IO and thus cause other unexpected behavior.
>> + *
>> + * Return VM_FAULT_NOPAGE if the PTE is not none or 
>> pte_offset_map_lock()
>> + * fails. In other cases, 0 is returned.
>> + */
>
> That documentation is imprecise, as you are not explaining the mlock 
> limitation.
>
> It's an internal helper, I'd drop all that and rather add a comment 
> below right next to the conditions that are performing the check ...
>
That makes sense.

>> +static vm_fault_t filemap_fault_recheck_pte(struct vm_fault *vmf)
>> +{
>> +    struct vm_area_struct *vma = vmf->vma;
>> +    vm_fault_t ret = 0;
>> +    pte_t *ptep;
>> +
>> +    if (!(vma->vm_flags & VM_LOCKED))
>> +        return ret;
>
> I was wondering if we also want to do:
>
> if (!is_cow_mappinng(vma->vm_flags))
>     return 0;
>
> But likely it's not helpful.
>
Maybe it's enough to check if the VMA is VM_LOCKED?
No performance degradation for most common scenarios.

>
> Then add something like:
>
> /*
>  * We might have COW'ed a pageache folio and might now have an mlocked

Nit: s/pageache/pagecache

>  * anon folio mapped. The original pagecache folio is not mlocked and
>  * might have been evicted. During a read+clear/modify/write update of
>  * the PTE, such as done in do_numa_page()/change_pte_range(), we
>  * temporarily clear the PTE under PT lock and might detect it here as
>  * "none" when not holding the PT lock.
>  *
>  * Not rechecking the PTE under PT lock could result in an
>  * unexpected major fault in an mlock'ed region. Recheck only for
>  * this special scenario while holding the PT lock, to not degrade
>  * non-mlocked scenarios.
>  */
>
Thanks!

I'll add these comments in the next version.

>> +
>> +    if (pmd_none(*vmf->pmd))
>> +        return ret;
>
> I'd  simply return 0 in both cases, easier to read.
>
Agreed.

>> +
>> +    ptep = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>> +                   &vmf->ptl);
>> +    if (unlikely(!ptep))
>> +        return VM_FAULT_NOPAGE;
>> +
>> +    if (unlikely(!pte_none(ptep_get(ptep))))
>> +        ret = VM_FAULT_NOPAGE;
>> +
>> +    pte_unmap_unlock(ptep, vmf->ptl);
>> +    return ret;
>> +}
>
-- 
Best Regards,
Peng


