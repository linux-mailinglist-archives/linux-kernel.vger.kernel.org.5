Return-Path: <linux-kernel+bounces-80947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E92866E54
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958C7284BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB3D5B68C;
	Mon, 26 Feb 2024 08:46:10 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB035B67A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937170; cv=none; b=V/0vDa2+0cxvvwpGQJQKS8WRwVSBVgfI3LTjCIwYMdGHjnxTp15yZzTFeWznbXrAhOc60yVZOlrlFvluqYf44alZuQZpI7MDnXvaUC4vgce074JgPRgOcomBrWwpr6mQM2dRggfLAyIfgF7gU4Lq1pMmLiWI4z3dTRexwCqCpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937170; c=relaxed/simple;
	bh=UY8UOhk7ftwA2QGpByE16I6C5vSz2mv2Ox9M8vz+S30=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H/+wn4PPtsGfT4li3ToJKizYvNpDysyBwIRRBg8BdYEXOL4hwYUUZcCbpCN/oyawW4BKAaxDdg/HRjuavC7Fq1XE2j/oNu5oMHPxxz/zMzlB6PTaNe0Z82KLn7C83vj8nbTtwbRbtWflyqL5wm5XA0k1+fZ+tQYH6ZYZR89DlhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TjvKd5jkbz1h0Z1;
	Mon, 26 Feb 2024 16:43:49 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id C007C18001A;
	Mon, 26 Feb 2024 16:46:02 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 16:46:01 +0800
Message-ID: <ad4f0b57-25b2-3f48-3222-6f37f35ed81b@huawei.com>
Date: Mon, 26 Feb 2024 16:46:00 +0800
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
To: David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <willy@infradead.org>, <fengwei.yin@intel.com>,
	<aneesh.kumar@linux.ibm.com>, <shy828301@gmail.com>, <hughd@google.com>,
	<wangkefeng.wang@huawei.com>, Nanyong Sun <sunnanyong@huawei.com>
References: <20240206092627.1421712-1-zhangpeng362@huawei.com>
 <87jznhypxy.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <a905dea7-018e-80c0-ab54-85766add8d96@huawei.com>
 <87frxfhibt.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <43182940-ddaa-7073-001a-e95d0999c5ba@huawei.com>
 <87il2bek6f.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <fdbe3a71-ff6b-4397-8276-9ca2f3e6db89@redhat.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <fdbe3a71-ff6b-4397-8276-9ca2f3e6db89@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/2/26 16:20, David Hildenbrand wrote:

> On 26.02.24 08:52, Huang, Ying wrote:
>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>
>>> On 2024/2/26 14:04, Huang, Ying wrote:
>>>
>>>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>>>
>>>>> On 2024/2/7 10:21, Huang, Ying wrote:
>>>>>
>>>>>> Peng Zhang <zhangpeng362@huawei.com> writes:
>>>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>>
>>>>>>> The major fault occurred when using mlockall(MCL_CURRENT | 
>>>>>>> MCL_FUTURE)
>>>>>>> in application, which leading to an unexpected performance 
>>>>>>> issue[1].
>>>>>>>
>>>>>>> This caused by temporarily cleared PTE during a 
>>>>>>> read+clear/modify/write
>>>>>>> update of the PTE, eg, do_numa_page()/change_pte_range().
>>>>>>>
>>>>>>> For the data segment of the user-mode program, the global 
>>>>>>> variable area
>>>>>>> is a private mapping. After the pagecache is loaded, the private 
>>>>>>> anonymous
>>>>>>> page is generated after the COW is triggered. Mlockall can lock 
>>>>>>> COW pages
>>>>>>> (anonymous pages), but the original file pages cannot be locked 
>>>>>>> and may
>>>>>>> be reclaimed. If the global variable (private anon page) is 
>>>>>>> accessed when
>>>>>>> vmf->pte is zeroed in numa fault, a file page fault will be 
>>>>>>> triggered.
>>>>>>>
>>>>>>> At this time, the original private file page may have been 
>>>>>>> reclaimed.
>>>>>>> If the page cache is not available at this time, a major fault 
>>>>>>> will be
>>>>>>> triggered and the file will be read, causing additional overhead.
>>>>>>>
>>>>>>> Fix this by rechecking the PTE without acquiring PTL in 
>>>>>>> filemap_fault()
>>>>>>> before triggering a major fault.
>>>>>>>
>>>>>>> Testing file anonymous page read and write page fault 
>>>>>>> performance in ext4
>>>>>>> and ramdisk using will-it-scale[2] on a x86 physical machine. 
>>>>>>> The data
>>>>>>> is the average change compared with the mainline after the patch is
>>>>>>> applied. The test results are within the range of fluctuation, 
>>>>>>> and there
>>>>>>> is no obvious difference. The test results are as follows:
>>>>>> You still claim that there's no difference in the test results.  
>>>>>> If so,
>>>>>> why do you implement the patch?  IMHO, you need to prove your 
>>>>>> patch can
>>>>>> improve the performance in some cases.
>>>>> I'm sorry that maybe I didn't express myself clearly.
>>>>>
>>>>> The purpose of this patch is to fix the issue that major fault may 
>>>>> still be triggered
>>>>> with mlockall(), thereby improving a little performance. This 
>>>>> patch is more of a bugfix
>>>>> than a performance improvement patch.
>>>>>
>>>>> This issue affects our traffic analysis service. The inbound 
>>>>> traffic is heavy. If a major
>>>>> fault occurs, the I/O schedule is triggered and the original I/O 
>>>>> is suspended. Generally,
>>>>> the I/O schedule is 0.7 ms. If other applications are operating 
>>>>> disks, the system needs
>>>>> to wait for more than 10 ms. However, the inbound traffic is heavy 
>>>>> and the NIC buffer is
>>>>> small. As a result, packet loss occurs. The traffic analysis 
>>>>> service can't tolerate packet
>>>>> loss.
>>>>>
>>>>> To prevent packet loss, we use the mlockall() function to prevent 
>>>>> I/O. It is unreasonable
>>>>> that major faults will still be triggered after mlockall() is used.
>>>>>
>>>>> In our service test environment, the baseline is 7 major faults/12 
>>>>> hours. After applied the
>>>>> unlock patch, the probability of triggering the major fault is 1 
>>>>> major faults/12 hours. After
>>>>> applied the lock patch, no major fault will be triggered. So only 
>>>>> the locked patch can actually
>>>>> solve our problem.
>>>> This is the data I asked for.
>>>>
>>>> But, you said that this is a feature bug fix instead of performance
>>>> improvement.  So, I checked the mlock(2), and found the following 
>>>> words,
>>>>
>>>> "
>>>>          mlockall() locks all pages mapped into the address space 
>>>> of the calling
>>>>          process.  This includes the pages of the code, data, and 
>>>> stack segment,
>>>>          as well as shared libraries, user space kernel data, 
>>>> shared memory, and
>>>>          memory-mapped files.  All mapped pages are guaranteed to 
>>>> be resident in
>>>>          RAM when the call returns successfully; the  pages are  
>>>> guaranteed  to
>>>>          stay in RAM until later unlocked.
>>>> "
>>>>
>>>> In theory, the locked page are in RAM.  So, IIUC, we don't violate the
>>>> ABI.  But, in effect, we does do that.
>>>
>>> "mlockall() locks all pages mapped into the address space of the 
>>> calling process."
>>> For a private mapping, mlockall() can lock COW pages (anonymous 
>>> pages), but the
>>> original file pages can't be locked. Maybe, we violate the ABI here.
>>
>> If so, please make it explicit and loudly.
>>
>>> This is also
>>> the cause of this issue. The patch fix the impact of this issue: 
>>> prevent major
>>> faults, reduce IO, and fix the service packet loss issue.
>>>
>>> Preventing major faults, and thus reducing IO, could be an important 
>>> reason to use
>>> mlockall(). Could we fix this with the locked patch? Or is there 
>>> another way?
>>
>> Unfortunately, locked patch cause performance regressions for more
>> common cases.  Is it possible for us to change ptep_modify_prot_start()
>> to use some magic PTE value instead of 0?  That may be possible.  But,
>> that isn't enough, you need to change all ptep_get_and_clear() users.
>
> Trigger (false) major faults for mlocked memory is suboptimal.
>
> Having such pages temporarily not mapped (e.g., page migration) is 
> acceptable (pages are in RAM but are getting moved). We handle that 
> using nonswap migration entries.
>
> Let me understand the issue first:
>
> 1) MAP_PRIVATE file mapping that is mlocked.
>
> 2) We caused COW, so we now have an anonymous page mapped. That anon
>    page is mlocked.
>
> 3) Change of protection (under PT lock) will temporarily clear the PTE
>
> 4) Page fault will trigger and find the PTE still cleared (without PT
>    lock)
>
> 5) We don't realize that there is a page mapped and, therefore, trigger
>    a major fault.
>
> Using the PT lock would fix it properly. Doing it as in this patch can 
> only be considered an optimization, not a proper fix.
>
> Using a magic PTE to work around "just use the PT lock like everyone 
> else" feels a bit odd. The patch states "We don't hold PTL here as 
> acquiring PTL hurts performance" -- do we have any numbers on that?
>
Testing file anonymous page read and write page fault performance in ext4
, tmpfs and ramdisk using will-it-scale[2] on a x86 physical machine. The
data is the average change compared with the mainline after the patch is
applied.

with the locked patch:
                           processes processes_idle threads threads_idle
ext4    private file write: -0.51%    0.08%          -0.03%  -0.04%
ext4    shared  file write:  0.135%  -0.531%          2.883% -0.772%
ramdisk private file write: -0.48%    0.23%          -1.08%   0.27%
ramdisk private file  read:  0.07%   -6.90%          -5.85%  -0.70%
tmpfs   private file write: -0.344%  -0.110%          0.200%  0.145%
tmpfs   shared  file write:  0.958%   0.101%          2.781% -0.337%
tmpfs    private file read: -0.16%    0.00%          -0.12%   0.41%

with the no locked patch:
                           processes processes_idle threads threads_idle
ext4    private file write: -1.14%  -0.08%         -1.87%   0.13%
ext4    private file  read:  0.03%  -0.65%         -0.51%  -0.08%
ramdisk private file write: -1.21%  -0.21%         -1.12%   0.11%
ramdisk private file  read:  0.00%  -0.68%         -0.33%  -0.02%

I could also run other tests if needed.

> We could special-case that for MLOCK'ed VMAs with MCL_FUTURE, meaning, 
> take the PTL to double-check only in such VMAs.
>
Agreed. I think this solution is great. Thanks for your suggestion!

-- 
Best Regards,
Peng


