Return-Path: <linux-kernel+bounces-36837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB84883A78F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F061F25C14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16831AAD1;
	Wed, 24 Jan 2024 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ne4fHdrW"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF21AAB1;
	Wed, 24 Jan 2024 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095004; cv=none; b=h3BsnpTbbn6r8pGfSWNG6WKKQ+j93Tm1HzQ4tZ9o3RkgIDxgRIiw4GDPWEFj39Gjds52/LGRbQTq9/zikiGLOSvTTJJ6nO/nhyhoX5kLKUjNXWhOR/tqirLQYwFLm253X0yNXfphHstXFCKLNOyVGWNzRCDA672ZuDN8uYG5kEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095004; c=relaxed/simple;
	bh=+urhngMzgJ0quyKjYQ0ggpLPBFKqVLr5OUEYXqueFAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=uApDUjvKUptdftK0D5NE5YJWeRLdE5OrHX23ZxwEeWXFvgOiAY/aLjoYYMNuDH9IllGPTzp+4Pq1Ho/M7VFpXjWSElmk2U94sVuoObj5Rhr/KA/BeFMU3uQdH7zniotlNtzVmmaVJfY5b3ZgDz9hwNyJdgioiyJkk0qWrGUtKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ne4fHdrW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAxnfX001738;
	Wed, 24 Jan 2024 11:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=XwsDcvUycr6MZCgZkrrnEzPidiDuzn7kT9+I19kmcFE=;
 b=Ne4fHdrWAnrGW7oMca75rLonV+7RFF6zoUNURr291Vn6+pArfcOMDqKs5pO2jvuO/0iS
 VW1ciO41rpA6r3TAdhYdpaosgMf4kgTORsurdBnBQPk+ZPMHoZnxabyAGSMKmka96Zv7
 KjHZkL9qxoXZvRbGN4erCJFe1T5Vn/4XUt8Nyr1oHoggD9ckNGdnrR/Fm3zKDp7QbYAB
 DHPFe83/d6Rt98vweOVSVZpXfXSqmA2VfxGwb4FahUsLbG4KTisTLulOF1PUugUywwTm
 VcKAxUnY2RTYOw2HCWXLIw/CTC+cW2+QUjHyZwMreHB5gYExluP2U22Q8+zJlSwTfcd0 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu0cd1umv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 11:15:58 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40OAxuxV002552;
	Wed, 24 Jan 2024 11:15:57 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vu0cd1ukj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 11:15:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40O8UAAB025268;
	Wed, 24 Jan 2024 11:15:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqkd269-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 11:15:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40OBFrUK39125384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:15:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44CAA20043;
	Wed, 24 Jan 2024 11:15:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76A8C20040;
	Wed, 24 Jan 2024 11:15:52 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 24 Jan 2024 11:15:52 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
 <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao
 <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman
 Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>, "Huang, Ying" <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>, Luis
 Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama
 <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang
 <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>, Alistair
 Popple <apopple@nvidia.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v9 02/10] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
In-Reply-To: <1188e67e-5c04-4bb5-b242-78d92c3fc85c@arm.com> (Ryan Roberts's
	message of "Mon, 15 Jan 2024 08:50:19 +0000")
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
	<20231207161211.2374093-3-ryan.roberts@arm.com>
	<ZaMR2EWN-HvlCfUl@krava>
	<41dc7dff-1ea8-4894-a487-88d46ec2b2d8@redhat.com>
	<ZaRKMwKJIBmh8-lD@krava>
	<1188e67e-5c04-4bb5-b242-78d92c3fc85c@arm.com>
Date: Wed, 24 Jan 2024 12:15:52 +0100
Message-ID: <yt9d1qa7x9qv.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5VToK-l8Q8W53Es6vhZ8EvF7HGfvts8A
X-Proofpoint-ORIG-GUID: K9bgcSWDgXer_hJD1KufHgSOFVoGI3i6
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_05,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240080

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 14/01/2024 20:55, Jiri Olsa wrote:
>> On Sun, Jan 14, 2024 at 06:33:56PM +0100, David Hildenbrand wrote:
>>> On 13.01.24 23:42, Jiri Olsa wrote:
>>>> On Thu, Dec 07, 2023 at 04:12:03PM +0000, Ryan Roberts wrote:
>>>>> In preparation for supporting anonymous multi-size THP, improve
>>>>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
>>>>> passed to it. In this case, all contained pages are accounted using the
>>>>> order-0 folio (or base page) scheme.
>>>>>
>>>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>>>>> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>   mm/rmap.c | 28 ++++++++++++++++++++--------
>>>>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 2a1e45e6419f..846fc79f3ca9 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1335,32 +1335,44 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>>>>>    * This means the inc-and-test can be bypassed.
>>>>>    * The folio does not have to be locked.
>>>>>    *
>>>>> - * If the folio is large, it is accounted as a THP.  As the folio
>>>>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>>>>>    * is new, it's assumed to be mapped exclusively by a single process.
>>>>>    */
>>>>>   void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>>>   		unsigned long address)
>>>>>   {
>>>>> -	int nr;
>>>>> +	int nr = folio_nr_pages(folio);
>>>>> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>>>>> +	VM_BUG_ON_VMA(address < vma->vm_start ||
>>>>> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>>>
>>>> hi,
>>>> I'm hitting this bug (console output below) with adding uprobe
>>>> on simple program like:
>>>>
>>>>    $ cat up.c
>>>>    int main(void)
>>>>    {
>>>>       return 0;
>>>>    }
>>>>
>>>>    # bpftrace -e 'uprobe:/home/jolsa/up:_start {}'
>>>>
>>>>    $ ./up
>>>>
>>>> it's on top of current linus tree master:
>>>>    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
>>>>
>>>> before this patch it seems to work, I can send my .config if needed
>
> Thanks for the bug report!

I just hit the same bug in our CI, but can't find the fix in -next. Is
this in the queue somewhere?

Thanks
Sven

