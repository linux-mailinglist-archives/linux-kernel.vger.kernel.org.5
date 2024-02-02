Return-Path: <linux-kernel+bounces-49037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B71884651D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C84B286408
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB9E63CB;
	Fri,  2 Feb 2024 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3aHWtoZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25B63AD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706834501; cv=none; b=PCGjTUfTVkQjnvCZNPUjhbtM83MUtF/6ERGzkm9RUHa3hrMC2m01BA2OMSax1t1YHIHQa/cvUV/FWHCmxIgKldVMrbPAdwKwjcHyyANJnoVT0Si9BrrvOBqDFgZ7Eiv38k0g39y815+vLWtfPiJe2hIZaDLjQ422B6Cf+m1obB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706834501; c=relaxed/simple;
	bh=HtYrXDLKOD6BHnTEFNusFxbc9wuUkDPz62Q/9vC2Bq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YXzybvwvYzstbRl8r5Ypmk08PgRyAfiKJ/JdZSyaoXymMsWfsKx12oBQobFGBmAq7N5usa2Wm98IfB+EI9Ihfg7PS6krRlWJRi/3c/+sZ9r1jL/GZSuHF9Kfj89Awtum41GHTs+SNQQT9O6iEX38whoeFy4hu7zjLDeCHYlM3s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3aHWtoZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706834499; x=1738370499;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=HtYrXDLKOD6BHnTEFNusFxbc9wuUkDPz62Q/9vC2Bq0=;
  b=B3aHWtoZ0fS14NZgttAxQDQbkXi6gPUtaNX4mx4tE4OM/BmairyLnL+L
   1kpazsalg9WvgZGneAyBqpnoTycJUldgILf5qzbowcejpTNNwc2kcSkup
   y5gUaERuNM8Z7/oriU48D3/d9+K4BK3ZNT57htfKslD1M1NfViZQlDvef
   e5NOPX9z7QXc6qojiK1Jp0WXkoLWpNd4O18UjXwYstZoA2u+luOt0n+fH
   hKf9d85QbEpHBamJUfAdsc/+tiX4yTTL6+UOHjP2s1W11ew8B9u9Mew3z
   CEczpWOFdWQZnzJ50TWX/znM0iqhE49t6guDPJGa64J1/BhKWF4oK0sfJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="3896157"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="3896157"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 16:41:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="4569001"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 16:41:35 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  <akpm@linux-foundation.org>,
  <willy@infradead.org>,  <aneesh.kumar@linux.ibm.com>,
  <shy828301@gmail.com>,  <hughd@google.com>,  <david@redhat.com>,
  <wangkefeng.wang@huawei.com>,  <sunnanyong@huawei.com>
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
In-Reply-To: <4da573ec-a2f9-84f4-f729-540492192957@huawei.com> (zhangpeng's
	message of "Thu, 1 Feb 2024 20:10:24 +0800")
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
	<4da573ec-a2f9-84f4-f729-540492192957@huawei.com>
Date: Fri, 02 Feb 2024 08:39:39 +0800
Message-ID: <87wmrnbsxg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"zhangpeng (AS)" <zhangpeng362@huawei.com> writes:

> On 2023/11/29 10:59, Huang, Ying wrote:
>
>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>
>>> On 2023/11/24 16:04, Huang, Ying wrote:
>>>
>>>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>>>
>>>>> On 2023/11/24 12:26, Huang, Ying wrote:
>>>>>
>>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>>
>>>>>>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>>>>>>
>>>>>>>> On 2023/11/23 13:26, Yin Fengwei wrote:
>>>>>>>>
>>>>>>>>> On 11/23/23 12:12, zhangpeng (AS) wrote:
>>>>>>>>>> On 2023/11/23 9:09, Yin Fengwei wrote:
>>>>>>>>>>
>>>>>>>>>>> Hi Peng,
>>>>>>>>>>>
>>>>>>>>>>> On 11/22/23 22:00, Peng Zhang wrote:
>>>>>>>>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>>>>>>>
>>>>>>>>>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL=
_FUTURE)
>>>>>>>>>>>> in application, which leading to an unexpected performance iss=
ue[1].
>>>>>>>>>>>>
>>>>>>>>>>>> This caused by temporarily cleared pte during a read/modify/wr=
ite update
>>>>>>>>>>>> of the pte, eg, do_numa_page()/change_pte_range().
>>>>>>>>>>>>
>>>>>>>>>>>> For the data segment of the user-mode program, the global vari=
able area
>>>>>>>>>>>> is a private mapping. After the pagecache is loaded, the priva=
te anonymous
>>>>>>>>>>>> page is generated after the COW is triggered. Mlockall can loc=
k COW pages
>>>>>>>>>>>> (anonymous pages), but the original file pages cannot be locke=
d and may
>>>>>>>>>>>> be reclaimed. If the global variable (private anon page) is ac=
cessed when
>>>>>>>>>>>> vmf->pte is zeroed in numa fault, a file page fault will be tr=
iggered.
>>>>>>>>>>>>
>>>>>>>>>>>> At this time, the original private file page may have been rec=
laimed.
>>>>>>>>>>>> If the page cache is not available at this time, a major fault=
 will be
>>>>>>>>>>>> triggered and the file will be read, causing additional overhe=
ad.
>>>>>>>>>>>>
>>>>>>>>>>>> Fix this by rechecking the pte by holding ptl in filemap_fault=
() before
>>>>>>>>>>>> triggering a major fault.
>>>>>>>>>>>>
>>>>>>>>>>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-4=
98fa17434ee@huawei.com/
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>>>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>     =C2=A0 mm/filemap.c | 14 ++++++++++++++
>>>>>>>>>>>>     =C2=A0 1 file changed, 14 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>>>>>>>>>> index 71f00539ac00..bb5e6a2790dc 100644
>>>>>>>>>>>> --- a/mm/filemap.c
>>>>>>>>>>>> +++ b/mm/filemap.c
>>>>>>>>>>>> @@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_faul=
t *vmf)
>>>>>>>>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mapping_locked =3D true;
>>>>>>>>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte_t *ptep =3D pt=
e_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 vmf->address, &vmf->ptl);
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ptep) {
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /*
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * Recheck pte with ptl locked as the pte can be cleared
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * temporarily during a read/modify/write update.
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (unlikely(!pte_none(ptep_get(ptep))))
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D VM_FAULT_NOPAGE;
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pte_unmap_unlock(ptep, vmf->ptl);
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (unlikely(ret))
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> I am curious. Did you try not to take PTL here and just check w=
hether PTE is not NONE?
>>>>>>>>>> Thank you for your reply.
>>>>>>>>>>
>>>>>>>>>> If we don't take PTL, the current use case won't trigger this is=
sue either.
>>>>>>>>> Is this verified by testing or just in theory?
>>>>>>>> If we add a delay between ptep_modify_prot_start() and ptep_modify=
_prot_commit(),
>>>>>>>> this issue will also trigger. Without delay, we haven't reproduced=
 this problem
>>>>>>>> so far.
>>>>>>>>
>>>>>>>>>> In most cases, if we don't take PTL, this issue won't be trigger=
ed. However,
>>>>>>>>>> there is still a possibility of triggering this issue. The corne=
r case is that
>>>>>>>>>> task 2 triggers a page fault when task 1 is between ptep_modify_=
prot_start()
>>>>>>>>>> and ptep_modify_prot_commit() in do_numa_page(). Furthermore,tas=
k 2 passes the
>>>>>>>>>> check whether the PTE is not NONE before task 1 updates PTE in
>>>>>>>>>> ptep_modify_prot_commit() without taking PTL.
>>>>>>>>> There is very limited operations between ptep_modify_prot_start()=
 and
>>>>>>>>> ptep_modify_prot_commit(). While the code path from page fault to=
 this check is
>>>>>>>>> long. My understanding is it's very likely the PTE is not NONE wh=
en do PTE check
>>>>>>>>> here without hold PTL (This is my theory. :)).
>>>>>>>> Yes, there is a high probability that this issue won't occur witho=
ut taking PTL.
>>>>>>>>
>>>>>>>>> In the other side, acquiring/releasing PTL may bring performance =
impaction. It may
>>>>>>>>> not be big deal because the IO operations in this code path. But =
it's better to
>>>>>>>>> collect some performance data IMHO.
>>>>>>>> We tested the performance of file private mapping page fault (page=
_fault2.c of
>>>>>>>> will-it-scale [1]) and file shared mapping page fault (page_fault3=
c of will-it-scale).
>>>>>>>> The difference in performance (in operations per second) before an=
d after patch
>>>>>>>> applied is about 0.7% on a x86 physical machine.
>>>>>>> Whether is it improvement or reduction?
>>>>>> And I think that you need to test ramdisk cases too to verify whether
>>>>>> this will cause performance regression and how much.
>>>>> Yes, I will.
>>>>> In addition, are there any ramdisk test cases recommended? =F0=9F=98=
=81
>>>> I think that you can start with the will-it-scale test case you used
>>>> before.  And you can try some workload with large number of major faul=
t,
>>>> like file read with mmap.
>>> I used will-it-scale to test the page faults of ext4 files and
>>> tmpfs files. The data is the average change compared with the
>>> mainline after the patch is applied. The test results are within
>>> the range of fluctuation, and there is no obvious difference.
>>> The test results are as follows:
>>>
>>>                            processes processes_idle threads threads_idle
>>> ext4  private file write: -0.51%    0.08%          -0.03%  -0.04%
>>> ext4  shared  file write:  0.135%  -0.531%          2.883% -0.772%
>>> tmpfs private file write: -0.344%  -0.110%          0.200%  0.145%
>>> tmpfs shared  file write:  0.958%   0.101%          2.781% -0.337%
>>> tmpfs private file read:  -0.16%    0.00%          -0.12%   0.41%
>> Thank you very much for test results!
>>
>> We shouldn't use tmpfs, because there will be no major faults.  Please
>> check your major faults number to verify that.  IIUC, ram disk + disk
>> file system should be used.
>>
>> And, please make sure that there's no heavy lock contention in the base
>> kernel.  Because if some heavy lock contention kills performance, there
>> will no performance difference between based and patched kernel.
>
> I'm so sorry I was so late to finish the test and reply.
>
> I used will-it-scale to test the page faults of ramdisk files. The
> data is the average change compared with the mainline after the patch
> is applied. The test results are as follows:
>
>                            processes processes_idle threads threads_idle
> ramdisk private file write: -0.48%   0.23%          -1.08%   0.27%
> ramdisk private file  read:  0.07%  -6.90%          -5.85%  -0.70%
                                                      ~~~~~~

It appears that the patch will cause some visible performance regression
in this benchmark.  We can try to verify that via `perf profile`.  Or,
we can just try Fengwei's idea, that is, check pte_none() without
acquiring PTL.

--
Best Regards,
Huang, Ying

>
> Applied patch:
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 32eedf3afd45..2db9ccfbd5e3 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3226,6 +3226,22 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>                          mapping_locked =3D true;
>                  }
>          } else {
> +               if (!pmd_none(*vmf->pmd)) {
> +                       pte_t *ptep =3D pte_offset_map_lock(vmf->vma->vm_=
mm, vmf->pmd,
> +                                                         vmf->address, &=
vmf->ptl);
> +                       if (unlikely(!ptep))
> +                               return VM_FAULT_NOPAGE;
> +                       /*
> +                        * Recheck pte with ptl locked as the pte can be =
cleared
> +                        * temporarily during a read/modify/write update.
> +                        */
> +                       if (unlikely(!pte_none(ptep_get(ptep))))
> +                               ret =3D VM_FAULT_NOPAGE;
> +                       pte_unmap_unlock(ptep, vmf->ptl);
> +                       if (unlikely(ret))
> +                               return ret;
> +               }
> +
>                  /* No page in the page cache at all */
>                  count_vm_event(PGMAJFAULT);
>                  count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
>
>> --
>> Best Regards,
>> Huang, Ying

