Return-Path: <linux-kernel+bounces-80675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31117866B16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9F01F22194
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0CC1CAB2;
	Mon, 26 Feb 2024 07:33:17 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869B1C69A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932796; cv=none; b=SvJGk0C2RhThjAIAb0dLFe19qsWjiGzO+FyN1xVWhBodGl32L2uqdpbsDJ/uLS7OvS4cXGyRb8PVULEOYWc0vj8acrbuKdDoTnjmYwozlNdtAqYa7h3+fPXeVFBqX81ZV7ZqdCywlDsmZPwVTpTOkYRxeUoVK66iLC8RF43cN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932796; c=relaxed/simple;
	bh=VP1YTB1RmPKdiNgzEwDdlT/5h7UKJfQ5XWVF4M6bbGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WYGIYd+e6WvbdEbl2L9Jxq0VzJ7nZ9K4PMEFYv9z3sXxZVN4PbW+riiKi6iis2nyEZJ2Q7rIkiMmryW/3SnZ7JEj6axmGweWXwb8BWr1oB8N/naJYIkaKi+88tKPdlYOhchl/DFHp0vGQdHMvNco0qHSUZbnurGWBmRvgOme84Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TjslQ3yPszqhs8;
	Mon, 26 Feb 2024 15:32:34 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id CB6B51A0172;
	Mon, 26 Feb 2024 15:33:10 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 15:33:09 +0800
Message-ID: <43182940-ddaa-7073-001a-e95d0999c5ba@huawei.com>
Date: Mon, 26 Feb 2024 15:33:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <willy@infradead.org>, <fengwei.yin@intel.com>,
	<aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>, <hughd@google.com>,
	<david@redhat.com>, <wangkefeng.wang@huawei.com>, Nanyong Sun
	<sunnanyong@huawei.com>
References: <20240206092627.1421712-1-zhangpeng362@huawei.com>
 <87jznhypxy.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <a905dea7-018e-80c0-ab54-85766add8d96@huawei.com>
 <87frxfhibt.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <87frxfhibt.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/2/26 14:04, Huang, Ying wrote:

> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>
>> On 2024/2/7 10:21, Huang, Ying wrote:
>>
>>> Peng Zhang <zhangpeng362@huawei.com> writes:
>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>
>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>>>> in application, which leading to an unexpected performance issue[1].
>>>>
>>>> This caused by temporarily cleared PTE during a read+clear/modify/write
>>>> update of the PTE, eg, do_numa_page()/change_pte_range().
>>>>
>>>> For the data segment of the user-mode program, the global variable area
>>>> is a private mapping. After the pagecache is loaded, the private anonymous
>>>> page is generated after the COW is triggered. Mlockall can lock COW pages
>>>> (anonymous pages), but the original file pages cannot be locked and may
>>>> be reclaimed. If the global variable (private anon page) is accessed when
>>>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>>>>
>>>> At this time, the original private file page may have been reclaimed.
>>>> If the page cache is not available at this time, a major fault will be
>>>> triggered and the file will be read, causing additional overhead.
>>>>
>>>> Fix this by rechecking the PTE without acquiring PTL in filemap_fault()
>>>> before triggering a major fault.
>>>>
>>>> Testing file anonymous page read and write page fault performance in ext4
>>>> and ramdisk using will-it-scale[2] on a x86 physical machine. The data
>>>> is the average change compared with the mainline after the patch is
>>>> applied. The test results are within the range of fluctuation, and there
>>>> is no obvious difference. The test results are as follows:
>>> You still claim that there's no difference in the test results.  If so,
>>> why do you implement the patch?  IMHO, you need to prove your patch can
>>> improve the performance in some cases.
>> I'm sorry that maybe I didn't express myself clearly.
>>
>> The purpose of this patch is to fix the issue that major fault may still be triggered
>> with mlockall(), thereby improving a little performance. This patch is more of a bugfix
>> than a performance improvement patch.
>>
>> This issue affects our traffic analysis service. The inbound traffic is heavy. If a major
>> fault occurs, the I/O schedule is triggered and the original I/O is suspended. Generally,
>> the I/O schedule is 0.7 ms. If other applications are operating disks, the system needs
>> to wait for more than 10 ms. However, the inbound traffic is heavy and the NIC buffer is
>> small. As a result, packet loss occurs. The traffic analysis service can't tolerate packet
>> loss.
>>
>> To prevent packet loss, we use the mlockall() function to prevent I/O. It is unreasonable
>> that major faults will still be triggered after mlockall() is used.
>>
>> In our service test environment, the baseline is 7 major faults/12 hours. After applied the
>> unlock patch, the probability of triggering the major fault is 1 major faults/12 hours. After
>> applied the lock patch, no major fault will be triggered. So only the locked patch can actually
>> solve our problem.
> This is the data I asked for.
>
> But, you said that this is a feature bug fix instead of performance
> improvement.  So, I checked the mlock(2), and found the following words,
>
> "
>         mlockall() locks all pages mapped into the address space of the calling
>         process.  This includes the pages of the code, data, and stack segment,
>         as well as shared libraries, user space kernel data, shared memory, and
>         memory-mapped files.  All mapped pages are guaranteed to be resident in
>         RAM when the call returns successfully; the  pages  are  guaranteed  to
>         stay in RAM until later unlocked.
> "
>
> In theory, the locked page are in RAM.  So, IIUC, we don't violate the
> ABI.  But, in effect, we does do that.

"mlockall() locks all pages mapped into the address space of the calling process."
For a private mapping, mlockall() can lock COW pages (anonymous pages), but the
original file pages can't be locked. Maybe, we violate the ABI here. This is also
the cause of this issue. The patch fix the impact of this issue: prevent major
faults, reduce IO, and fix the service packet loss issue.

Preventing major faults, and thus reducing IO, could be an important reason to use
mlockall(). Could we fix this with the locked patch? Or is there another way?

> But, from git history, we have cleared the PTE during modification from
> 2.6.12-rc2 at least.  I guess that because Linux isn't a hard real time
> OS, users don't expect that too.
>
> --
> Best Regards,
> Huang, Ying
>
>> The test data provided is intended to prove that the patch does not have a major impact
>> on the performance of the page fault itself.
>>
>>>> 	                 processes processes_idle threads threads_idle
>>>> ext4    private file write: -1.14%  -0.08%         -1.87%   0.13%
>>>> ext4    shared  file write:  0.14%  -0.53%          2.88%  -0.77%
>>>> ext4    private file  read:  0.03%  -0.65%         -0.51%  -0.08%
>>>> tmpfs   private file write: -0.34%  -0.11%          0.20%   0.15%
>>>> tmpfs   shared  file write:  0.96%   0.10%          2.78%  -0.34%
>>>> ramdisk private file write: -1.21%  -0.21%         -1.12%   0.11%
>>>> ramdisk private file  read:  0.00%  -0.68%         -0.33%  -0.02%
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>>>> [2] https://github.com/antonblanchard/will-it-scale/
>>>>
>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Suggested-by: Yin Fengwei <fengwei.yin@intel.com>
>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>> v1->v2:
>>>> - Add more test results per Huang, Ying
>>>> - Add more comments before check PTE per Huang, Ying, David Hildenbrand
>>>>     and Yin Fengwei
>>>> - Change pte_offset_map_nolock to pte_offset_map as the ptl lock won't
>>>>     be used
>>>>
>>>> RFC->v1:
>>>> - Add error handling when ptep == NULL per Huang, Ying and Matthew
>>>>     Wilcox
>>>> - Check the PTE without acquiring PTL in filemap_fault(), suggested by
>>>>     Huang, Ying and Yin Fengwei
>>>> - Add pmd_none() check before PTE map
>>>> - Update commit message and add performance test information
>>>>
>>>>    mm/filemap.c | 34 ++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 34 insertions(+)
>>>>
>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>> index 142864338ca4..a2c1a98bc771 100644
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -3238,6 +3238,40 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>>>    			mapping_locked = true;
>>>>    		}
>>>>    	} else {
>>>> +		if (!pmd_none(*vmf->pmd)) {
>>>> +			pte_t *ptep;
>>>> +
>>>> +			ptep = pte_offset_map(vmf->pmd, vmf->address);
>>>> +			if (unlikely(!ptep))
>>>> +				return VM_FAULT_NOPAGE;
>>>> +			/*
>>>> +			 * Recheck PTE as the PTE can be cleared temporarily
>>>> +			 * during a read+clear/modify/write update of the PTE,
>>>> +			 * eg, do_numa_page()/change_pte_range(). This will
>>>> +			 * trigger a major fault, even if we use mlockall,
>>>> +			 * which may affect performance.
>>>> +			 * We don't hold PTL here as acquiring PTL hurts
>>>> +			 * performance. So the check is still racy, but
>>>> +			 * the race window seems small enough.
>>>> +			 *
>>>> +			 * If we lose the race during the check, the page_fault
>>>> +			 * will be triggered. Butthe page table entry lock
>>>> +			 * still make sure the correctness:
>>>> +			 * - If the page cache is not reclaimed, the page_fault
>>>> +			 *   will work like the page fault was served already
>>>> +			 *   and bail out.
>>>> +			 * - If the page cache is reclaimed, the major fault
>>>> +			 *   will be triggered, page cache is filled,
>>>> +			 *   page_fault also work like the page fault was
>>>> +			 *   served already and bail out.
>>>> +			 */
>>> IMHO, this is too long.  It can be shorten to like,
>>>
>>> If we lose the race, major fault may be triggered unnecessary.  This
>>> hurts performance but not functionality.
>> OK, I'll fix it in the next version.
>>
>>>> +			if (unlikely(!pte_none(ptep_get_lockless(ptep))))
>>>> +				ret = VM_FAULT_NOPAGE;
>>>> +			pte_unmap(ptep);
>>>> +			if (unlikely(ret))
>>>> +				return ret;
>>>> +		}
>>>> +
>>>>    		/* No page in the page cache at all */
>>>>    		count_vm_event(PGMAJFAULT);
>>>>    		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
>>> --
>>> Best Regards,
>>> Huang, Ying

-- 
Best Regards,
Peng


