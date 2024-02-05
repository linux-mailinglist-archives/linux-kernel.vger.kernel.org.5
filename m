Return-Path: <linux-kernel+bounces-52135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EA184947A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A0B1F26539
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F9C111A0;
	Mon,  5 Feb 2024 07:25:08 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC711198
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117907; cv=none; b=UDi0p6bGAKhX6j70Su79hZTm6DpGNYDqtWxaqKsWMEtE4m8ZF5nHJSinH0/x90yQ+Gh2FI4u4e9SeA5+7Ee4eEIMePWfE8g3NvAGK9LwYrCB2dmCL2BaFvF8ioCeINPBo2plgWs5rFw60NyRbcllJW7OGQvurWALnYexMjRY7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117907; c=relaxed/simple;
	bh=kXIiViVczn2OKW14zNwf56BRUdl6PZg5wCcUqWj0CZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XXR50joljYG9odVTDJGJy9jJgTsK50op5F1Fw1uS06K+ByVsHMku/Fu2xZodd7qUWxK28XnwPzxEsw1Trisr/JHHxA5uofZK0gicIBGRGLMdjVit4gU66ijtjPEx+JX4d6+0JYQS5CaWUlaeiufH59TPc1UkHJMSOddsdkym/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TSyT65J6Cz1FKLQ;
	Mon,  5 Feb 2024 15:20:26 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 10CCC1A0172;
	Mon,  5 Feb 2024 15:25:01 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 15:24:59 +0800
Message-ID: <25de8872-ad79-e5e6-054c-9ac5e7191416@huawei.com>
Date: Mon, 5 Feb 2024 15:24:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] filemap: avoid unnecessary major faults in
 filemap_fault()
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <willy@infradead.org>, <fengwei.yin@intel.com>,
	<aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>, <hughd@google.com>,
	<david@redhat.com>, <wangkefeng.wang@huawei.com>
References: <20240204093526.212636-1-zhangpeng362@huawei.com>
 <87zfwf39ha.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <85e03dd9-8bd7-d516-ebe4-84dd449a9fb2@huawei.com>
 <87mssf2yiv.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <87mssf2yiv.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/2/5 14:52, Huang, Ying wrote:

> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>> On 2024/2/5 10:56, Huang, Ying wrote:
>>> Peng Zhang <zhangpeng362@huawei.com> writes:
>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>
>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>>>> in application, which leading to an unexpected performance issue[1].
>>>>
>>>> This caused by temporarily cleared PTE during a read/modify/write update
>>>> of the PTE, eg, do_numa_page()/change_pte_range().
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
>>>> 			processes processes_idle threads threads_idle
>>>> ext4 file write:	-1.14%    -0.08%         -1.87%  0.13%
>>>> ext4 file read:		 0.03%	  -0.65%         -0.51%	-0.08%
>>>> ramdisk file write:	-1.21%    -0.21%         -1.12%  0.11%
>>>> ramdisk file read:	 0.00%    -0.68%         -0.33% -0.02%
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com/
>>>> [2] https://github.com/antonblanchard/will-it-scale/
>>>>
>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Suggested-by: Yin Fengwei <fengwei.yin@intel.com>
>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>> RFC->v1:
>>>> - Add error handling when ptep == NULL per Huang, Ying and Matthew Wilcox
>>>> - Check the PTE without acquiring PTL in filemap_fault(), suggested by
>>>>     Huang, Ying and Yin Fengwei
>>>> - Add pmd_none() check before PTE map
>>>> - Update commit message and add performance test information
>>>>
>>>>    mm/filemap.c | 18 ++++++++++++++++++
>>>>    1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>> index 142864338ca4..b29cdeb6a03b 100644
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -3238,6 +3238,24 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>>>    			mapping_locked = true;
>>>>    		}
>>>>    	} else {
>>>> +		if (!pmd_none(*vmf->pmd)) {
>>>> +			pte_t *ptep;
>>>> +
>>>> +			ptep = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
>>>> +						     vmf->address, &vmf->ptl);
>>>> +			if (unlikely(!ptep))
>>>> +				return VM_FAULT_NOPAGE;
>>>> +			/*
>>>> +			 * Recheck pte as the pte can be cleared temporarily
>>>> +			 * during a read/modify/write update.
>>>> +			 */
>>> I think that we should add some comments here about the racy checking.
>> I'll add comments in a v2 as follows:
>> /*
>>   * Recheck PTE as the PTE can be cleared temporarily
>>   * during a read/modify/write update of the PTE, eg,
>>   * do_numa_page()/change_pte_range(). This will trigger
>>   * a major fault, even if we use mlockall, which may
>>   * affect performance.
>>   */
> Sorry, my previous words aren't clear enough.  I mean some comments as
> follows,
>
> We don't hold PTL here, so the check is still racy.  But acquiring PTL
> hurts performance and the race window seems small enough.

Got it. I'll add comments in a v2 as follows:
/*
  * Recheck PTE as the PTE can be cleared temporarily
  * during a read/modify/write update of the PTE.
  * We don't hold PTL here as acquiring PTL hurts
  * performance. So the check is still racy, but
  * the race window seems small enough.
  */

>
> --
> Best Regards,
> Huang, Ying
>
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

-- 
Best Regards,
Peng


