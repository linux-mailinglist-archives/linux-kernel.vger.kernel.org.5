Return-Path: <linux-kernel+bounces-86181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A4C86C0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA931F23731
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279DB44C65;
	Thu, 29 Feb 2024 06:35:56 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2994A44C67
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188555; cv=none; b=T9Vn1BvolRWbXSrVqO7RRGXIS7CIjKzZ/ojVwz2GGzz2mttFQ7Xum/TfWSOg1zhcYRcwVDbKxo5jEnO+L7sKcv6Sx0coAJbJOyS20vkNr2jtL2u10vYsl7nU2BZxSVgRcwW4TmcUXhqguSxSdzMFY2hhzNXcIze9MMcAp9Hxqmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188555; c=relaxed/simple;
	bh=uaBjgOnDJy5dT2qCjAJpAFj29tdUxdG+gV89QUOhvDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M0dkb78WrhJ38wHZIfp1SJOAQ7r+XjVsgNSVe1Ai65SQulqvOlnV6rSn3vjfjlgxdulPLgiIdKBllyc0Ea8Hif6kzJX1WjrOU00TL5N0OkcwHdiS0ftThV1Z7/vapbteYD8GwKapmnirBf/OA6K0G7pj4fEta6i0+7fo0Pe/B7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TlhKg659HzNnCY;
	Thu, 29 Feb 2024 14:35:03 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 73D41140118;
	Thu, 29 Feb 2024 14:35:43 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 14:35:42 +0800
Message-ID: <9650670c-abb7-bd0f-a5ff-2499d4963429@huawei.com>
Date: Thu, 29 Feb 2024 14:35:41 +0800
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
To: "Huang, Ying" <ying.huang@intel.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <willy@infradead.org>, <fengwei.yin@intel.com>,
	<david@redhat.com>, <aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>,
	<hughd@google.com>, <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20240229060907.836589-1-zhangpeng362@huawei.com>
 <87il27dbo4.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <87il27dbo4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/2/29 14:31, Huang, Ying wrote:

> Peng Zhang <zhangpeng362@huawei.com> writes:
>
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>> in application, which leading to an unexpected issue[1].
>>
>> This caused by temporarily cleared PTE during a read+clear/modify/write
>> update of the PTE, eg, do_numa_page()/change_pte_range().
>>
>> For the data segment of the user-mode program, the global variable area
>> is a private mapping. After the pagecache is loaded, the private anonymous
>> page is generated after the COW is triggered. Mlockall can lock COW pages
>> (anonymous pages), but the original file pages cannot be locked and may
>> be reclaimed. If the global variable (private anon page) is accessed when
>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>> At this time, the original private file page may have been reclaimed.
>> If the page cache is not available at this time, a major fault will be
>> triggered and the file will be read, causing additional overhead.
>>
>> This issue affects our traffic analysis service. The inbound traffic is
>> heavy. If a major fault occurs, the I/O schedule is triggered and the
>> original I/O is suspended. Generally, the I/O schedule is 0.7 ms. If
>> other applications are operating disks, the system needs to wait for
>> more than 10 ms. However, the inbound traffic is heavy and the NIC buffer
>> is small. As a result, packet loss occurs. But the traffic analysis service
>> can't tolerate packet loss.
>>
>> Fix this by holding PTL and rechecking the PTE in filemap_fault() before
>> triggering a major fault. We do this check only if vma is VM_LOCKED. In
>> our service test environment, the baseline is 7 major faults / 12 hours.
>> After the patch is applied, no major fault will be triggered.
>>
>> Testing file anonymous page read and write page fault performance in
>> ext4, tmpfs and ramdisk using will-it-scale[2] on a x86 physical machine.
>> The data is the average change compared with the mainline after the patch
>> is applied. The test results are indicates some performance regressions.
>> We do this check only if vma is VM_LOCKED, therefore, no performance
>> regressions is caused for most common cases.
>>
>> The test results are as follows:
>>                            processes processes_idle threads threads_idle
>> ext4    private file write: -0.51%    0.08%          -0.03%  -0.04%
>> ext4    shared  file write:  0.135%  -0.531%          2.883% -0.772%
>> ramdisk private file write: -0.48%    0.23%          -1.08%   0.27%
>> ramdisk private file  read:  0.07%   -6.90%          -5.85%  -0.70%
> Have you retested with the VM_LOCKED optimization?  Why are there still
> performance regression?

Sorry I will update the performance data in the next version.

>> tmpfs   private file write: -0.344%  -0.110%          0.200%  0.145%
>> tmpfs   shared  file write:  0.958%   0.101%          2.781% -0.337%
>> tmpfs   private file  read: -0.16%    0.00%          -0.12%   0.41%
>>
>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
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
>>    and Yin Fengwei
>> - Change pte_offset_map_nolock to pte_offset_map as the PTL won't
>>    be used
>>
>> RFC->v1:
>> - Add error handling when ptep == NULL per Huang, Ying and Matthew
>>    Wilcox
>> - Check the PTE without acquiring PTL in filemap_fault(), suggested by
>>    Huang, Ying and Yin Fengwei
>> - Add pmd_none() check before PTE map
>> - Update commit message and add performance test information
>>
>>   mm/filemap.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index b4858d89f1b1..2668bac68df7 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3181,6 +3181,42 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>>   	return fpin;
>>   }
>>   
>> +/*
>> + * filemap_fault_recheck_pte - hold PTL and recheck whether pte is none.
>> + * @vmf - the vm_fault for this fault.
>> + *
>> + * Recheck PTE as the PTE can be cleared temporarily during a read+clear/modify
>> + * /write update of the PTE, eg, do_numa_page()/change_pte_range(). This will
>> + * trigger an unexpected major fault, even if we use mlockall(), which may
>> + * increase IO and thus cause other unexpected behavior.
>> + *
>> + * Return VM_FAULT_NOPAGE if the PTE is not none or pte_offset_map_lock()
>> + * fails. In other cases, 0 is returned.
>> + */
>> +static vm_fault_t filemap_fault_recheck_pte(struct vm_fault *vmf)
>> +{
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	vm_fault_t ret = 0;
>> +	pte_t *ptep;
>> +
>> +	if (!(vma->vm_flags & VM_LOCKED))
>> +		return ret;
>> +
>> +	if (pmd_none(*vmf->pmd))
>> +		return ret;
>> +
> How about check PTE without lock firstly?  I guess that this can improve
> performance in common case (no race).
>
>> +	ptep = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>> +				   &vmf->ptl);
>> +	if (unlikely(!ptep))
>> +		return VM_FAULT_NOPAGE;
>> +
>> +	if (unlikely(!pte_none(ptep_get(ptep))))
>> +		ret = VM_FAULT_NOPAGE;
>> +
>> +	pte_unmap_unlock(ptep, vmf->ptl);
>> +	return ret;
>> +}
>> +
>>   /**
>>    * filemap_fault - read in file data for page fault handling
>>    * @vmf:	struct vm_fault containing details of the fault
>> @@ -3236,6 +3272,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>   			mapping_locked = true;
>>   		}
>>   	} else {
>> +		ret = filemap_fault_recheck_pte(vmf);
>> +		if (unlikely(ret))
>> +			return ret;
>> +
>>   		/* No page in the page cache at all */
>>   		count_vm_event(PGMAJFAULT);
>>   		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
> --
> Best Regards,
> Huang, Ying

-- 
Best Regards,
Peng


