Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709F67FCD21
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 04:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376783AbjK2DBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 22:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjK2DBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 22:01:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8899C1AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 19:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701226880; x=1732762880;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=IgR3AoQx3YsiledcrZ6K0fpNvdCWZyDBfaALg+pJUr8=;
  b=RKOij84qwgz1emccklqr6mmov1SZ0pBdGkvmgGfnoM+AcdumpSud4SY3
   lvkJX5ZA5QboZWPTDizkjDxYyX6xU+WAp918UnI0Krt4OrwmopjX1oQaS
   +WXhvp8JZz+7dJCo6UEIvYBcIgxrTblq2O3kHI1CzOrWT1XZaFQvL3Un/
   qZK4bPU9BGnOeUu8MQLBKHOT2ve1Vlzzno2pWi7Sg3IwThHm16xopTJwN
   P9v4KcypqmuavbHLXZwiDlndTGc1fxiRnGRl/h/HZ6L1V4hfJH1MyAqCT
   939t4dU+Ne1UylOCeOEM1UPV4qa9OuKlBAWIiyxU6vOWWj2ZVzUWEjgSR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6296212"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6296212"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 19:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="942156280"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="942156280"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 19:01:15 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <aneesh.kumar@linux.ibm.com>,
        <shy828301@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
In-Reply-To: <ab5cf58f-f7bd-73a8-5b71-4ffe90d811c1@huawei.com> (zhangpeng's
        message of "Wed, 29 Nov 2023 09:24:49 +0800")
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
Date:   Wed, 29 Nov 2023 10:59:14 +0800
Message-ID: <87plzt464d.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"zhangpeng (AS)" <zhangpeng362@huawei.com> writes:

> On 2023/11/24 16:04, Huang, Ying wrote:
>
>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>
>>> On 2023/11/24 12:26, Huang, Ying wrote:
>>>
>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>
>>>>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>>>>
>>>>>> On 2023/11/23 13:26, Yin Fengwei wrote:
>>>>>>
>>>>>>> On 11/23/23 12:12, zhangpeng (AS) wrote:
>>>>>>>> On 2023/11/23 9:09, Yin Fengwei wrote:
>>>>>>>>
>>>>>>>>> Hi Peng,
>>>>>>>>>
>>>>>>>>> On 11/22/23 22:00, Peng Zhang wrote:
>>>>>>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>>>>>
>>>>>>>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_F=
UTURE)
>>>>>>>>>> in application, which leading to an unexpected performance issue=
[1].
>>>>>>>>>>
>>>>>>>>>> This caused by temporarily cleared pte during a read/modify/writ=
e update
>>>>>>>>>> of the pte, eg, do_numa_page()/change_pte_range().
>>>>>>>>>>
>>>>>>>>>> For the data segment of the user-mode program, the global variab=
le area
>>>>>>>>>> is a private mapping. After the pagecache is loaded, the private=
 anonymous
>>>>>>>>>> page is generated after the COW is triggered. Mlockall can lock =
COW pages
>>>>>>>>>> (anonymous pages), but the original file pages cannot be locked =
and may
>>>>>>>>>> be reclaimed. If the global variable (private anon page) is acce=
ssed when
>>>>>>>>>> vmf->pte is zeroed in numa fault, a file page fault will be trig=
gered.
>>>>>>>>>>
>>>>>>>>>> At this time, the original private file page may have been recla=
imed.
>>>>>>>>>> If the page cache is not available at this time, a major fault w=
ill be
>>>>>>>>>> triggered and the file will be read, causing additional overhead.
>>>>>>>>>>
>>>>>>>>>> Fix this by rechecking the pte by holding ptl in filemap_fault()=
 before
>>>>>>>>>> triggering a major fault.
>>>>>>>>>>
>>>>>>>>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498=
fa17434ee@huawei.com/
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>>>>> ---
>>>>>>>>>>    =C2=A0 mm/filemap.c | 14 ++++++++++++++
>>>>>>>>>>    =C2=A0 1 file changed, 14 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>>>>>>>> index 71f00539ac00..bb5e6a2790dc 100644
>>>>>>>>>> --- a/mm/filemap.c
>>>>>>>>>> +++ b/mm/filemap.c
>>>>>>>>>> @@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_fault =
*vmf)
>>>>>>>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 mapping_locked =3D true;
>>>>>>>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte_t *ptep =3D pte_=
offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 vmf->address, &vmf->ptl);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ptep) {
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /*
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * Recheck pte with ptl locked as the pte can be cleared
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * temporarily during a read/modify/write update.
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (unlikely(!pte_none(ptep_get(ptep))))
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D VM_FAULT_NOPAGE;
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pte_unmap_unlock(ptep, vmf->ptl);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (unlikely(ret))
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>> I am curious. Did you try not to take PTL here and just check whe=
ther PTE is not NONE?
>>>>>>>> Thank you for your reply.
>>>>>>>>
>>>>>>>> If we don't take PTL, the current use case won't trigger this issu=
e either.
>>>>>>> Is this verified by testing or just in theory?
>>>>>> If we add a delay between ptep_modify_prot_start() and ptep_modify_p=
rot_commit(),
>>>>>> this issue will also trigger. Without delay, we haven't reproduced t=
his problem
>>>>>> so far.
>>>>>>
>>>>>>>> In most cases, if we don't take PTL, this issue won't be triggered=
. However,
>>>>>>>> there is still a possibility of triggering this issue. The corner =
case is that
>>>>>>>> task 2 triggers a page fault when task 1 is between ptep_modify_pr=
ot_start()
>>>>>>>> and ptep_modify_prot_commit() in do_numa_page(). Furthermore,task =
2 passes the
>>>>>>>> check whether the PTE is not NONE before task 1 updates PTE in
>>>>>>>> ptep_modify_prot_commit() without taking PTL.
>>>>>>> There is very limited operations between ptep_modify_prot_start() a=
nd
>>>>>>> ptep_modify_prot_commit(). While the code path from page fault to t=
his check is
>>>>>>> long. My understanding is it's very likely the PTE is not NONE when=
 do PTE check
>>>>>>> here without hold PTL (This is my theory. :)).
>>>>>> Yes, there is a high probability that this issue won't occur without=
 taking PTL.
>>>>>>
>>>>>>> In the other side, acquiring/releasing PTL may bring performance im=
paction. It may
>>>>>>> not be big deal because the IO operations in this code path. But it=
's better to
>>>>>>> collect some performance data IMHO.
>>>>>> We tested the performance of file private mapping page fault (page_f=
ault2.c of
>>>>>> will-it-scale [1]) and file shared mapping page fault (page_fault3.c=
 of will-it-scale).
>>>>>> The difference in performance (in operations per second) before and =
after patch
>>>>>> applied is about 0.7% on a x86 physical machine.
>>>>> Whether is it improvement or reduction?
>>>> And I think that you need to test ramdisk cases too to verify whether
>>>> this will cause performance regression and how much.
>>> Yes, I will.
>>> In addition, are there any ramdisk test cases recommended? =F0=9F=98=81
>> I think that you can start with the will-it-scale test case you used
>> before.  And you can try some workload with large number of major fault,
>> like file read with mmap.
>
> I used will-it-scale to test the page faults of ext4 files and
> tmpfs files. The data is the average change compared with the
> mainline after the patch is applied. The test results are within
> the range of fluctuation, and there is no obvious difference.
> The test results are as follows:
>
>                           processes processes_idle threads threads_idle
> ext4  private file write: -0.51%    0.08%          -0.03%  -0.04%
> ext4  shared  file write:  0.135%  -0.531%          2.883% -0.772%
> tmpfs private file write: -0.344%  -0.110%          0.200%  0.145%
> tmpfs shared  file write:  0.958%   0.101%          2.781% -0.337%
> tmpfs private file read:  -0.16%    0.00%          -0.12%   0.41%

Thank you very much for test results!

We shouldn't use tmpfs, because there will be no major faults.  Please
check your major faults number to verify that.  IIUC, ram disk + disk
file system should be used.

And, please make sure that there's no heavy lock contention in the base
kernel.  Because if some heavy lock contention kills performance, there
will no performance difference between based and patched kernel.

--
Best Regards,
Huang, Ying
