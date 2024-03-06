Return-Path: <linux-kernel+bounces-93678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E1687332A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BFD1C23DFF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A09C5F473;
	Wed,  6 Mar 2024 09:54:49 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD45F470
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718888; cv=none; b=IToAE4re2+ADoo8cCnUTPh91PxbT1Iq1IwimXOjicTZCy5KOkJ9IUmqM8jwU5aibYYx0Mkd2LyjAD9JAEk4+HUZnSNKF9UHpg3SngFzLora1Kjj3QrJJiAb9Nhv+k79FAXnWWSoLtyH9tQX3OAYjMJgEl694zEtr/m7GlQgy0/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718888; c=relaxed/simple;
	bh=xh91JLOgR2kNsYKEWZgBzfvf+Kmb4c7kAobQzP3t/90=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ijkbl9GQVxws0ydkAkAdq1PdjEyYCWXwftY3DdDL8shR3rJzI2NiA9IxMxZ36NxTTthPSeetWaWFVmrS4Ul0FlPLn+wwu/4egen0PdYOjhwrlJnVY5vTVGcA9SOyc020ETdf4FsYkP8zr46EkrrSfNh2LXXUaJJqkvRQRcS8Kvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TqSRG4rVdz1xqHm;
	Wed,  6 Mar 2024 17:52:58 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 5553D14011A;
	Wed,  6 Mar 2024 17:54:36 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 17:54:35 +0800
Message-ID: <3f2b71de-6d90-8b9a-cd7c-fea947a8a2ba@huawei.com>
Date: Wed, 6 Mar 2024 17:54:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <willy@infradead.org>, <fengwei.yin@intel.com>,
	<david@redhat.com>, <aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>,
	<hughd@google.com>, <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20240306083809.1236634-1-zhangpeng362@huawei.com>
 <871q8n926m.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <871q8n926m.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/3/6 16:47, Huang, Ying wrote:

> Peng Zhang <zhangpeng362@huawei.com> writes:
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
>> triggering a major fault. We do this check only if vma is VM_LOCKED to
>> reduce the performance impact in common scenarios.
>>
>> In our product environment, there were 7 major faults every 12 hours.
>> After the patch is applied, no major fault have been triggered.
>>
>> Testing file page read and write page fault performance in ext4 and
>> ramdisk using will-it-scale[2] on a x86 physical machine. The data is
>> the average change compared with the mainline after the patch is applied.
>> The test results are within the range of fluctuation. We do this check
>> only if vma is VM_LOCKED, therefore, no performance regressions is caused
>> for most common cases.
>>
>> The test results are as follows:
>>                            processes processes_idle  threads threads_idle
>> ext4    private file write:  0.22%    0.26%           1.21%  -0.15%
>> ext4    private file  read:  0.03%    1.00%           1.39%   0.34%
>> ext4    shared  file write: -0.50%   -0.02%          -0.14%  -0.02%
>> ramdisk private file write:  0.07%    0.02%           0.53%   0.04%
>> ramdisk private file  read:  0.01%    1.60%          -0.32%  -0.02%
>>
>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>> [2] https://github.com/antonblanchard/will-it-scale/
>>
>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> LGTM, Thanks!  Feel free to add
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Thanks ! 😁

>> ---
>> v3->v4:
>> - Update the performance data and commit message
>> - Check PTE without lock firstly per Huang, Ying
>> - Update comments for recheck function per David Hildenbrand
>> - Simply return 0 to make it easier to read per David Hildenbrand
>> - Check !FAULT_FLAG_ORIG_PTE_VALID instead of pmd_none()
>>
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
>>   mm/filemap.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index b4858d89f1b1..31ab455c4537 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3181,6 +3181,48 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>>   	return fpin;
>>   }
>>   
>> +static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>> +{
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	vm_fault_t ret = 0;
>> +	pte_t *ptep;
>> +
>> +	/*
>> +	 * We might have COW'ed a pagecache folio and might now have an mlocked
>> +	 * anon folio mapped. The original pagecache folio is not mlocked and
>> +	 * might have been evicted. During a read+clear/modify/write update of
>> +	 * the PTE, such as done in do_numa_page()/change_pte_range(), we
>> +	 * temporarily clear the PTE under PT lock and might detect it here as
>> +	 * "none" when not holding the PT lock.
>> +	 *
>> +	 * Not rechecking the PTE under PT lock could result in an unexpected
>> +	 * major fault in an mlock'ed region. Recheck only for this special
>> +	 * scenario while holding the PT lock, to not degrade non-mlocked
>> +	 * scenarios. Recheck the PTE without PT lock firstly, thereby reducing
>> +	 * the number of times we hold PT lock.
>> +	 */
>> +	if (!(vma->vm_flags & VM_LOCKED))
>> +		return 0;
>> +
>> +	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
>> +		return 0;
>> +
>> +	ptep = pte_offset_map(vmf->pmd, vmf->address);
>> +	if (unlikely(!ptep))
>> +		return VM_FAULT_NOPAGE;
>> +
>> +	if (unlikely(!pte_none(ptep_get_lockless(ptep)))) {
>> +		ret = VM_FAULT_NOPAGE;
>> +	} else {
>> +		spin_lock(vmf->ptl);
>> +		if (unlikely(!pte_none(ptep_get(ptep))))
>> +			ret = VM_FAULT_NOPAGE;
>> +		spin_unlock(vmf->ptl);
>> +	}
>> +	pte_unmap(ptep);
>> +	return ret;
>> +}
>> +
>>   /**
>>    * filemap_fault - read in file data for page fault handling
>>    * @vmf:	struct vm_fault containing details of the fault
>> @@ -3236,6 +3278,10 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>   			mapping_locked = true;
>>   		}
>>   	} else {
>> +		ret = filemap_fault_recheck_pte_none(vmf);
>> +		if (unlikely(ret))
>> +			return ret;
>> +
>>   		/* No page in the page cache at all */
>>   		count_vm_event(PGMAJFAULT);
>>   		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);

-- 
Best Regards,
Peng


