Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A920B7F6B31
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjKXEQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXEQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:16:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEAA101
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 20:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700799397; x=1732335397;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=wLbfhTiNsp3RmLNz+uw+lM6yKEd6DDGxnCGNuclyhiQ=;
  b=c+dwFPnloZKqX/SphJnrwz8E2Smk/w1fB9/YVfeMAoTeL6aMyY7BC/xg
   mLm6uEuVzcuI5mYbfWidsj+BHMSzHf2WL6+mXnsfawmDtYQ3Jxg2l3GtJ
   /NHyspaq7lQemffV9AQW93aBTHDsEYeGV7JjBmOfZwYANjD/ywql6xMil
   STPsdSMMmuWJhL5+EWws/2GMHjyFjUS7J3H2VSvHRRoTXmkAGwxVpyJLp
   T+WJb/3/yhlwymg3IFwjIpFjg7s9aZVccEAruYTZwsc+2V6DSADZv2gzP
   xdskke3Mqyg56o/pR3gZ364Rx3BdHjBvHVuxPK+y2PC2SDmq1uBW8x8Rq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382766473"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="382766473"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 20:16:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="858254423"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="858254423"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 20:15:57 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <aneesh.kumar@linux.ibm.com>,
        <shy828301@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
In-Reply-To: <48235d73-3dc6-263d-7822-6d479b753d46@huawei.com> (zhangpeng's
        message of "Thu, 23 Nov 2023 15:57:44 +0800")
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
        <f4dba5b5-2e6e-4c5a-a269-4abe8fe2bcd8@intel.com>
        <b0d869e4-108b-8ffe-e9f7-65c4d98f2bf8@huawei.com>
        <801bd0c9-7d0c-4231-93e5-7532e8231756@intel.com>
        <48235d73-3dc6-263d-7822-6d479b753d46@huawei.com>
Date:   Fri, 24 Nov 2023 12:13:56 +0800
Message-ID: <87y1en7pq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"zhangpeng (AS)" <zhangpeng362@huawei.com> writes:

> On 2023/11/23 13:26, Yin Fengwei wrote:
>
>> On 11/23/23 12:12, zhangpeng (AS) wrote:
>>> On 2023/11/23 9:09, Yin Fengwei wrote:
>>>
>>>> Hi Peng,
>>>>
>>>> On 11/22/23 22:00, Peng Zhang wrote:
>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>
>>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUTURE)
>>>>> in application, which leading to an unexpected performance issue[1].
>>>>>
>>>>> This caused by temporarily cleared pte during a read/modify/write upd=
ate
>>>>> of the pte, eg, do_numa_page()/change_pte_range().
>>>>>
>>>>> For the data segment of the user-mode program, the global variable ar=
ea
>>>>> is a private mapping. After the pagecache is loaded, the private anon=
ymous
>>>>> page is generated after the COW is triggered. Mlockall can lock COW p=
ages
>>>>> (anonymous pages), but the original file pages cannot be locked and m=
ay
>>>>> be reclaimed. If the global variable (private anon page) is accessed =
when
>>>>> vmf->pte is zeroed in numa fault, a file page fault will be triggered.
>>>>>
>>>>> At this time, the original private file page may have been reclaimed.
>>>>> If the page cache is not available at this time, a major fault will be
>>>>> triggered and the file will be read, causing additional overhead.
>>>>>
>>>>> Fix this by rechecking the pte by holding ptl in filemap_fault() befo=
re
>>>>> triggering a major fault.
>>>>>
>>>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa174=
34ee@huawei.com/
>>>>>
>>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>> ---
>>>>>  =C2=A0 mm/filemap.c | 14 ++++++++++++++
>>>>>  =C2=A0 1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>>> index 71f00539ac00..bb5e6a2790dc 100644
>>>>> --- a/mm/filemap.c
>>>>> +++ b/mm/filemap.c
>>>>> @@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 mapping_locked =3D true;
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte_t *ptep =3D pte_offse=
t_map_lock(vmf->vma->vm_mm, vmf->pmd,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 vmf->address, &vmf->ptl);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ptep) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * Recheck pte with ptl locked as the pte can be cleared
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 * temporarily during a read/modify/write update.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (unlikely(!pte_none(ptep_get(ptep))))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D VM_FAULT_NOPAGE;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
te_unmap_unlock(ptep, vmf->ptl);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (unlikely(ret))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> I am curious. Did you try not to take PTL here and just check whether =
PTE is not NONE?
>>> Thank you for your reply.
>>>
>>> If we don't take PTL, the current use case won't trigger this issue eit=
her.
>> Is this verified by testing or just in theory?
>
> If we add a delay between ptep_modify_prot_start() and ptep_modify_prot_c=
ommit(),
> this issue will also trigger. Without delay, we haven't reproduced this p=
roblem
> so far.
>
>>> In most cases, if we don't take PTL, this issue won't be triggered. How=
ever,
>>> there is still a possibility of triggering this issue. The corner case =
is that
>>> task 2 triggers a page fault when task 1 is between ptep_modify_prot_st=
art()
>>> and ptep_modify_prot_commit() in do_numa_page(). Furthermore,task 2 pas=
ses the
>>> check whether the PTE is not NONE before task 1 updates PTE in
>>> ptep_modify_prot_commit() without taking PTL.
>> There is very limited operations between ptep_modify_prot_start() and
>> ptep_modify_prot_commit(). While the code path from page fault to this c=
heck is
>> long. My understanding is it's very likely the PTE is not NONE when do P=
TE check
>> here without hold PTL (This is my theory. :)).
>
> Yes, there is a high probability that this issue won't occur without taki=
ng PTL.
>
>> In the other side, acquiring/releasing PTL may bring performance impacti=
on. It may
>> not be big deal because the IO operations in this code path. But it's be=
tter to
>> collect some performance data IMHO.
>
> We tested the performance of file private mapping page fault (page_fault2=
.c of
> will-it-scale [1]) and file shared mapping page fault (page_fault3.c of w=
ill-it-scale).
> The difference in performance (in operations per second) before and after=
 patch
> applied is about 0.7% on a x86 physical machine.

Whether is it improvement or reduction?

--
Best Regards,
Huang, Ying

> [1] https://github.com/antonblanchard/will-it-scale/tree/master
>
>>
>> Regards
>> Yin, Fengwei
>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>> +
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No page in=
 the page cache at all */
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count_vm_even=
t(PGMAJFAULT);
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count_memcg_e=
vent_mm(vmf->vma->vm_mm, PGMAJFAULT);
