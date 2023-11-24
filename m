Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4FD7F6DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344753AbjKXIGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjKXIGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:06:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741D21BCF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700813175; x=1732349175;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=VeIJKF2kYSgmlspkatXkM8Vav2oHi3gI1x/yScu/G+A=;
  b=fNh+A126UT8QJ97nSjXz8Vtb2Mjqi5gVzxcjDas6KzFADd1XZO8T7zKY
   MvMEaSi7pmoPnvRz4RKWKCYsO81+EM9I1ehvUogjP8WY+Uf2NDlK3Ve7u
   ejjYbVi86Ne+NS2Sja3QRTEqam7rcGz2Kw8sD6gbWotsBhCvQwPhxlVxU
   W79QOAW25w4qHJevrTuqVBO7j0jCbtWpW+Gb65YeyWwjIanBeVAo4zdfo
   K+rzd0oi4vl9i1/8waBEs775oDR3pqsdkliuDALpSkP6mWv2QvuJK8fqY
   zM4JPqeCLE+/E2wmpo4Gy/jIOXOnoUDlgQOTj44wkIXz/vd5GC7d0IZo3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389537769"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="389537769"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:06:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="15574227"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 00:06:12 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <aneesh.kumar@linux.ibm.com>,
        <shy828301@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [RFC PATCH] mm: filemap: avoid unnecessary major faults in
 filemap_fault()
In-Reply-To: <a4b53c04-681c-4cc0-07f1-db3fc702f8d1@huawei.com> (zhangpeng's
        message of "Fri, 24 Nov 2023 15:27:25 +0800")
References: <20231122140052.4092083-1-zhangpeng362@huawei.com>
        <f4dba5b5-2e6e-4c5a-a269-4abe8fe2bcd8@intel.com>
        <b0d869e4-108b-8ffe-e9f7-65c4d98f2bf8@huawei.com>
        <801bd0c9-7d0c-4231-93e5-7532e8231756@intel.com>
        <48235d73-3dc6-263d-7822-6d479b753d46@huawei.com>
        <87y1en7pq3.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87ttpb7p4z.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <a4b53c04-681c-4cc0-07f1-db3fc702f8d1@huawei.com>
Date:   Fri, 24 Nov 2023 16:04:11 +0800
Message-ID: <87lean7f2c.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"zhangpeng (AS)" <zhangpeng362@huawei.com> writes:

> On 2023/11/24 12:26, Huang, Ying wrote:
>
>> "Huang, Ying" <ying.huang@intel.com> writes:
>>
>>> "zhangpeng (AS)" <zhangpeng362@huawei.com> writes:
>>>
>>>> On 2023/11/23 13:26, Yin Fengwei wrote:
>>>>
>>>>> On 11/23/23 12:12, zhangpeng (AS) wrote:
>>>>>> On 2023/11/23 9:09, Yin Fengwei wrote:
>>>>>>
>>>>>>> Hi Peng,
>>>>>>>
>>>>>>> On 11/22/23 22:00, Peng Zhang wrote:
>>>>>>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>>>
>>>>>>>> The major fault occurred when using mlockall(MCL_CURRENT | MCL_FUT=
URE)
>>>>>>>> in application, which leading to an unexpected performance issue[1=
].
>>>>>>>>
>>>>>>>> This caused by temporarily cleared pte during a read/modify/write =
update
>>>>>>>> of the pte, eg, do_numa_page()/change_pte_range().
>>>>>>>>
>>>>>>>> For the data segment of the user-mode program, the global variable=
 area
>>>>>>>> is a private mapping. After the pagecache is loaded, the private a=
nonymous
>>>>>>>> page is generated after the COW is triggered. Mlockall can lock CO=
W pages
>>>>>>>> (anonymous pages), but the original file pages cannot be locked an=
d may
>>>>>>>> be reclaimed. If the global variable (private anon page) is access=
ed when
>>>>>>>> vmf->pte is zeroed in numa fault, a file page fault will be trigge=
red.
>>>>>>>>
>>>>>>>> At this time, the original private file page may have been reclaim=
ed.
>>>>>>>> If the page cache is not available at this time, a major fault wil=
l be
>>>>>>>> triggered and the file will be read, causing additional overhead.
>>>>>>>>
>>>>>>>> Fix this by rechecking the pte by holding ptl in filemap_fault() b=
efore
>>>>>>>> triggering a major fault.
>>>>>>>>
>>>>>>>> [1] https://lore.kernel.org/linux-mm/9e62fd9a-bee0-52bf-50a7-498fa=
17434ee@huawei.com/
>>>>>>>>
>>>>>>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>>>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>>> ---
>>>>>>>>   =C2=A0 mm/filemap.c | 14 ++++++++++++++
>>>>>>>>   =C2=A0 1 file changed, 14 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>>>>>> index 71f00539ac00..bb5e6a2790dc 100644
>>>>>>>> --- a/mm/filemap.c
>>>>>>>> +++ b/mm/filemap.c
>>>>>>>> @@ -3226,6 +3226,20 @@ vm_fault_t filemap_fault(struct vm_fault *v=
mf)
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mapping_locked =3D true;
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pte_t *ptep =3D pte_of=
fset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 vmf->address, &vmf->ptl);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ptep) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /*
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * Recheck pte with ptl locked as the pte can be cleared
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * temporarily during a read/modify/write update.
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (unlikely(!pte_none(ptep_get(ptep))))
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D VM_FAULT_NOPAGE;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 pte_unmap_unlock(ptep, vmf->ptl);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (unlikely(ret))
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>> I am curious. Did you try not to take PTL here and just check wheth=
er PTE is not NONE?
>>>>>> Thank you for your reply.
>>>>>>
>>>>>> If we don't take PTL, the current use case won't trigger this issue =
either.
>>>>> Is this verified by testing or just in theory?
>>>> If we add a delay between ptep_modify_prot_start() and ptep_modify_pro=
t_commit(),
>>>> this issue will also trigger. Without delay, we haven't reproduced thi=
s problem
>>>> so far.
>>>>
>>>>>> In most cases, if we don't take PTL, this issue won't be triggered. =
However,
>>>>>> there is still a possibility of triggering this issue. The corner ca=
se is that
>>>>>> task 2 triggers a page fault when task 1 is between ptep_modify_prot=
_start()
>>>>>> and ptep_modify_prot_commit() in do_numa_page(). Furthermore,task 2 =
passes the
>>>>>> check whether the PTE is not NONE before task 1 updates PTE in
>>>>>> ptep_modify_prot_commit() without taking PTL.
>>>>> There is very limited operations between ptep_modify_prot_start() and
>>>>> ptep_modify_prot_commit(). While the code path from page fault to thi=
s check is
>>>>> long. My understanding is it's very likely the PTE is not NONE when d=
o PTE check
>>>>> here without hold PTL (This is my theory. :)).
>>>> Yes, there is a high probability that this issue won't occur without t=
aking PTL.
>>>>
>>>>> In the other side, acquiring/releasing PTL may bring performance impa=
ction. It may
>>>>> not be big deal because the IO operations in this code path. But it's=
 better to
>>>>> collect some performance data IMHO.
>>>> We tested the performance of file private mapping page fault (page_fau=
lt2.c of
>>>> will-it-scale [1]) and file shared mapping page fault (page_fault3.c o=
f will-it-scale).
>>>> The difference in performance (in operations per second) before and af=
ter patch
>>>> applied is about 0.7% on a x86 physical machine.
>>> Whether is it improvement or reduction?
>> And I think that you need to test ramdisk cases too to verify whether
>> this will cause performance regression and how much.
>
> Yes, I will.
> In addition, are there any ramdisk test cases recommended? =F0=9F=98=81

I think that you can start with the will-it-scale test case you used
before.  And you can try some workload with large number of major fault,
like file read with mmap.

--
Best Regards,
Huang, Ying

>> --
>> Best Regards,
>> Huang, Ying
>>
>>> --
>>> Best Regards,
>>> Huang, Ying
>>>
>>>> [1] https://github.com/antonblanchard/will-it-scale/tree/master
>>>>
>>>>> Regards
>>>>> Yin, Fengwei
>>>>>
>>>>>>> Regards
>>>>>>> Yin, Fengwei
>>>>>>>
>>>>>>>> +
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* No pag=
e in the page cache at all */
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count_vm_=
event(PGMAJFAULT);
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count_mem=
cg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
