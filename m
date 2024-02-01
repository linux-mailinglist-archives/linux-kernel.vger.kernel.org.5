Return-Path: <linux-kernel+bounces-48083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6259845704
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDD01F275C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE0615D5D6;
	Thu,  1 Feb 2024 12:10:33 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430115CD72
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789432; cv=none; b=XnshFOgUnaaLVrBqvMVOLPZ1Vw343Obe41YHXsTPwJaeal95sI3kQfnHQ/N5+fxlrc73VYVrDMVrBO6785PT4rS/rdbG3dGSxH6Zy5QXQ/2tAq0DHlSoqKUYzX7E+eDwmeJXaNJAuOel8N6LQlmCeb46gZ7s0lfgjqTtW2mEszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789432; c=relaxed/simple;
	bh=3zXdHysR0JAwX3tF3mnRMrYAEtkIGUPf6lPXcE2IErI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h0R8qRG/iFGbT6Ex8BJwSfZ7THeVymXKVMxymtcy+bANJuyqyZgQ3+GMh75CFr4Cwe/0Qu8aecZOEyAtvhO4h1gK0+D3W1Pe7b1gz1EboTVvDHKPdIbpg0dYB55nbNwsjwf65JgBWTinGy7rLHSRkNe0JNfhbRifwFP1f1p/uI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TQd3Q2PP9z1Q8TN;
	Thu,  1 Feb 2024 20:08:34 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AB3E14040D;
	Thu,  1 Feb 2024 20:10:26 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 20:10:24 +0800
Message-ID: <4da573ec-a2f9-84f4-f729-540492192957@huawei.com>
Date: Thu, 1 Feb 2024 20:10:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>
CC: Yin Fengwei <fengwei.yin@intel.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<willy@infradead.org>, <aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>,
	<hughd@google.com>, <david@redhat.com>, <wangkefeng.wang@huawei.com>,
	<sunnanyong@huawei.com>
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
 <f4dba5b5-2e6e-4c5a-a269-4abe8fe2bcd8@intel.com>
 <b0d869e4-108b-8ffe-e9f7-65c4d98f2bf8@huawei.com>
 <801bd0c9-7d0c-4231-93e5-7532e8231756@intel.com>
 <48235d73-3dc6-263d-7822-6d479b753d46@huawei.com>
 <87y1en7pq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87ttpb7p4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <a4b53c04-681c-4cc0-07f1-db3fc702f8d1@huawei.com>
 <87lean7f2c.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ab5cf58f-f7bd-73a8-5b71-4ffe90d811c1@huawei.com>
 <87plzt464d.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <87plzt464d.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2023/11/29 10:59, Huang, Ying wrote:

> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>
>> On 2023/11/24 16:04, Huang, Ying wrote:
>>
>>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>>
>>>> On 2023/11/24 12:26, Huang, Ying wrote:
>>>>
>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>
>>>>>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>>>>>
>>>>>>> On 2023/11/23 13:26, Yin Fengwei wrote:
>>>>>>>
>>>>>>>> On 11/23/23 12:12, zhangpeng (AS) wrote:
>>>>>>>>> On 2023/11/23 9:09, Yin Fengwei wrote:
>>>>>>>>>
>>>>>>>>>> Hi Peng,
>>>>>>>>>>
>>>>>>>>>> On 11/22/23 22:00, Peng Zhang wrote:
>>>>>>>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>>>>>>
>>>>>>>>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>>>>>>>>>>> in application, which leading to an unexpected performance issue[1].
>>>>>>>>>>>
>>>>>>>>>>> This caused by temporarily cleared pte during a read/modify/write update
>>>>>>>>>>> of the pte, eg, do_numa_page()/change_pte_range().
>>>>>>>>>>>
>>>>>>>>>>> For the data segment of the user-mode program, the global variable area
>>>>>>>>>>> is a private mapping. After the pagecache is loaded, the private anonymous
>>>>>>>>>>> page is generated after the COW is triggered. Mlockall can lock COW pages
>>>>>>>>>>> (anonymous pages), but the original file pages cannot be locked and may
>>>>>>>>>>> be reclaimed. If the global variable (private anon page) is accessed when
>>>>>>>>>>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>>>>>>>>>>>
>>>>>>>>>>> At this time, the original private file page may have been reclaimed.
>>>>>>>>>>> If the page cache is not available at this time, a major fault will be
>>>>>>>>>>> triggered and the file will be read, causing additional overhead.
>>>>>>>>>>>
>>>>>>>>>>> Fix this by rechecking the pte by holding ptl in filemap_fault() before
>>>>>>>>>>> triggering a major fault.
>>>>>>>>>>>
>>>>>>>>>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       mm/filemap.c | 14 ++++++++++++++
>>>>>>>>>>>       1 file changed, 14 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>>>>>>>>> index 71f00539ac00..bb5e6a2790dc 100644
>>>>>>>>>>> --- a/mm/filemap.c
>>>>>>>>>>> +++ b/mm/filemap.c
>>>>>>>>>>> @@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>>>>>>>>>>                   mapping_locked = true;
>>>>>>>>>>>               }
>>>>>>>>>>>           } else {
>>>>>>>>>>> +        pte_t *ptep = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>>>>>>>>>>> +                          vmf->address, &vmf->ptl);
>>>>>>>>>>> +        if (ptep) {
>>>>>>>>>>> +            /*
>>>>>>>>>>> +             * Recheck pte with ptl locked as the pte can be cleared
>>>>>>>>>>> +             * temporarily during a read/modify/write update.
>>>>>>>>>>> +             */
>>>>>>>>>>> +            if (unlikely(!pte_none(ptep_get(ptep))))
>>>>>>>>>>> +                ret = VM_FAULT_NOPAGE;
>>>>>>>>>>> +            pte_unmap_unlock(ptep, vmf->ptl);
>>>>>>>>>>> +            if (unlikely(ret))
>>>>>>>>>>> +                return ret;
>>>>>>>>>>> +        }
>>>>>>>>>> I am curious. Did you try not to take PTL here and just check whether PTE is not NONE?
>>>>>>>>> Thank you for your reply.
>>>>>>>>>
>>>>>>>>> If we don't take PTL, the current use case won't trigger this issue either.
>>>>>>>> Is this verified by testing or just in theory?
>>>>>>> If we add a delay between ptep_modify_prot_start() and ptep_modify_prot_commit(),
>>>>>>> this issue will also trigger. Without delay, we haven't reproduced this problem
>>>>>>> so far.
>>>>>>>
>>>>>>>>> In most cases, if we don't take PTL, this issue won't be triggered. However,
>>>>>>>>> there is still a possibility of triggering this issue. The corner case is that
>>>>>>>>> task 2 triggers a page fault when task 1 is between ptep_modify_prot_start()
>>>>>>>>> and ptep_modify_prot_commit() in do_numa_page(). Furthermore,task 2 passes the
>>>>>>>>> check whether the PTE is not NONE before task 1 updates PTE in
>>>>>>>>> ptep_modify_prot_commit() without taking PTL.
>>>>>>>> There is very limited operations between ptep_modify_prot_start() and
>>>>>>>> ptep_modify_prot_commit(). While the code path from page fault to this check is
>>>>>>>> long. My understanding is it's very likely the PTE is not NONE when do PTE check
>>>>>>>> here without hold PTL (This is my theory. :)).
>>>>>>> Yes, there is a high probability that this issue won't occur without taking PTL.
>>>>>>>
>>>>>>>> In the other side, acquiring/releasing PTL may bring performance impaction. It may
>>>>>>>> not be big deal because the IO operations in this code path. But it's better to
>>>>>>>> collect some performance data IMHO.
>>>>>>> We tested the performance of file private mapping page fault (page_fault2.c of
>>>>>>> will-it-scale [1]) and file shared mapping page fault (page_fault3.c of will-it-scale).
>>>>>>> The difference in performance (in operations per second) before and after patch
>>>>>>> applied is about 0.7% on a x86 physical machine.
>>>>>> Whether is it improvement or reduction?
>>>>> And I think that you need to test ramdisk cases too to verify whether
>>>>> this will cause performance regression and how much.
>>>> Yes, I will.
>>>> In addition, are there any ramdisk test cases recommended? 😁
>>> I think that you can start with the will-it-scale test case you used
>>> before.  And you can try some workload with large number of major fault,
>>> like file read with mmap.
>> I used will-it-scale to test the page faults of ext4 files and
>> tmpfs files. The data is the average change compared with the
>> mainline after the patch is applied. The test results are within
>> the range of fluctuation, and there is no obvious difference.
>> The test results are as follows:
>>
>>                            processes processes_idle threads threads_idle
>> ext4  private file write: -0.51%    0.08%          -0.03%  -0.04%
>> ext4  shared  file write:  0.135%  -0.531%          2.883% -0.772%
>> tmpfs private file write: -0.344%  -0.110%          0.200%  0.145%
>> tmpfs shared  file write:  0.958%   0.101%          2.781% -0.337%
>> tmpfs private file read:  -0.16%    0.00%          -0.12%   0.41%
> Thank you very much for test results!
>
> We shouldn't use tmpfs, because there will be no major faults.  Please
> check your major faults number to verify that.  IIUC, ram disk + disk
> file system should be used.
>
> And, please make sure that there's no heavy lock contention in the base
> kernel.  Because if some heavy lock contention kills performance, there
> will no performance difference between based and patched kernel.

I'm so sorry I was so late to finish the test and reply.

I used will-it-scale to test the page faults of ramdisk files. The
data is the average change compared with the mainline after the patch
is applied. The test results are as follows:

                           processes processes_idle threads threads_idle
ramdisk private file write: -0.48%   0.23%          -1.08%   0.27%
ramdisk private file  read:  0.07%  -6.90%          -5.85%  -0.70%


Applied patch:

diff --git a/mm/filemap.c b/mm/filemap.c
index 32eedf3afd45..2db9ccfbd5e3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3226,6 +3226,22 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
                         mapping_locked = true;
                 }
         } else {
+               if (!pmd_none(*vmf->pmd)) {
+                       pte_t *ptep = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
+                                                         vmf->address, &vmf->ptl);
+                       if (unlikely(!ptep))
+                               return VM_FAULT_NOPAGE;
+                       /*
+                        * Recheck pte with ptl locked as the pte can be cleared
+                        * temporarily during a read/modify/write update.
+                        */
+                       if (unlikely(!pte_none(ptep_get(ptep))))
+                               ret = VM_FAULT_NOPAGE;
+                       pte_unmap_unlock(ptep, vmf->ptl);
+                       if (unlikely(ret))
+                               return ret;
+               }
+
                 /* No page in the page cache at all */
                 count_vm_event(PGMAJFAULT);
                 count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);

> --
> Best Regards,
> Huang, Ying

-- 
Best Regards,
Peng


