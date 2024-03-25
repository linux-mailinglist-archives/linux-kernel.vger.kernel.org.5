Return-Path: <linux-kernel+bounces-116533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD7888A106
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59BEBC3397
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A8680C18;
	Mon, 25 Mar 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eFwZh5Zu"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AD82C71
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711342996; cv=none; b=Tx3DmZlBg6pfjBLowsQv4jtyouHgG4N874una/59TVbM1abGa3fNhfUCq+a86E/ekfDW/4XKgTMCDVziX4eXAc48BEAusxwqyoNlCcvfk5/PIc2IUY7AM2x4tu805CFh1SJFjsUbH3NOZi1fri62t/kmsUrsPqJnZXOTSRRfmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711342996; c=relaxed/simple;
	bh=bzcb9J1zOIuRE+mdB4zKLyWN6R25h6DJb00PiUbZ5EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQDj/Zuc2PRf03FUpe2zaKYx3F5zoZK2HEBDWIvvyfwl5aJwDrVl9nRrQ6A51yRyL7oiCAuFxXdryzWiL+eyb/jDHGkMwW0+t3KTwi8ASHcD4vdVHkbPUDF0BpjBGgJnscm60lwK5cxXiVljEVN6n2p6NfmmRnH2HLUf6zpQQx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eFwZh5Zu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42P4jXjk000871;
	Mon, 25 Mar 2024 05:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qgEOJHHINd6gVGciNHxGiBy5AgfGlWmbQJemalMcRNo=;
 b=eFwZh5ZuO9jpVW8ovfjsaNj9hGOMHZcC6XrLUtUU+OYtpMDxEUspH5ItkdKc0jnoJlqb
 lz8ZbqIx/gLW7quDO6mILVVkp797WzmGhtHLk8oTeqyZ9bynd6CtXCH64GnFMhfLWbVy
 johlwWIAwoD+CXyjlFRlC5bhWFM/AuwkX97qOX7B6GaOC2tCQyTSQMZfvYn5yKmBPrgd
 xqTVHofgEdJwaIV7IN/OSmkIutd000dFjCErD1H99EZWTFYKR7UGqPDhObK5B+BD7IXD
 iFaOil008VTAt/quS+Ec4ZHAjGSJuskwN9MiSVcQsnhUYhYqnG3kfvnjJwTlesMUpEGo wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2h6t1feg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:02:30 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42P52TvA027023;
	Mon, 25 Mar 2024 05:02:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2h6t1fef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:02:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42P4JnWZ016410;
	Mon, 25 Mar 2024 05:02:28 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dtq6u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:02:28 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42P52Qi527460312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 05:02:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0ACF258079;
	Mon, 25 Mar 2024 05:02:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B0B45807D;
	Mon, 25 Mar 2024 05:02:19 +0000 (GMT)
Received: from [9.109.245.191] (unknown [9.109.245.191])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Mar 2024 05:02:19 +0000 (GMT)
Message-ID: <61054afa-9f18-45f1-987d-e6f242012096@linux.ibm.com>
Date: Mon, 25 Mar 2024 10:32:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Aneesh Kumar <aneesh.kumar@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <cover.1711002865.git.donettom@linux.ibm.com>
 <b1599085e1d2f3e48dc71c7991283b8aaa0fe00c.1711002865.git.donettom@linux.ibm.com>
 <87h6gyr7jf.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <e65b4e89-e8a9-475d-abc7-c63db8af435e@linux.ibm.com>
 <875xxbqb51.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <875xxbqb51.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bJuITvuynOeSBj7ytHw3NgXcX9j_qAd2
X-Proofpoint-ORIG-GUID: u5B-9gb0OMzVfbP0MrJAZF2rGbuMzj1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250026


On 3/25/24 08:18, Huang, Ying wrote:
> Donet Tom <donettom@linux.ibm.com> writes:
>
>> On 3/22/24 14:02, Huang, Ying wrote:
>>> Donet Tom <donettom@linux.ibm.com> writes:
>>>
>>>> commit bda420b98505 ("numa balancing: migrate on fault among multiple bound
>>>> nodes") added support for migrate on protnone reference with MPOL_BIND
>>>> memory policy. This allowed numa fault migration when the executing node
>>>> is part of the policy mask for MPOL_BIND. This patch extends migration
>>>> support to MPOL_PREFERRED_MANY policy.
>>>>
>>>> Currently, we cannot specify MPOL_PREFERRED_MANY with the mempolicy flag
>>>> MPOL_F_NUMA_BALANCING. This causes issues when we want to use
>>>> NUMA_BALANCING_MEMORY_TIERING. To effectively use the slow memory tier,
>>>> the kernel should not allocate pages from the slower memory tier via
>>>> allocation control zonelist fallback. Instead, we should move cold pages
>>>> from the faster memory node via memory demotion. For a page allocation,
>>>> kswapd is only woken up after we try to allocate pages from all nodes in
>>>> the allocation zone list. This implies that, without using memory
>>>> policies, we will end up allocating hot pages in the slower memory tier.
>>>>
>>>> MPOL_PREFERRED_MANY was added by commit b27abaccf8e8 ("mm/mempolicy: add
>>>> MPOL_PREFERRED_MANY for multiple preferred nodes") to allow better
>>>> allocation control when we have memory tiers in the system. With
>>>> MPOL_PREFERRED_MANY, the user can use a policy node mask consisting only
>>>> of faster memory nodes. When we fail to allocate pages from the faster
>>>> memory node, kswapd would be woken up, allowing demotion of cold pages
>>>> to slower memory nodes.
>>>>
>>>> With the current kernel, such usage of memory policies implies we can't
>>>> do page promotion from a slower memory tier to a faster memory tier
>>>> using numa fault. This patch fixes this issue.
>>>>
>>>> For MPOL_PREFERRED_MANY, if the executing node is in the policy node
>>>> mask, we allow numa migration to the executing nodes. If the executing
>>>> node is not in the policy node mask, we do not allow numa migration.
>>> Can we provide more information about this?  I suggest to use an
>>> example, for instance, pages may be distributed among multiple sockets
>>> unexpectedly.
>> Thank you for your suggestion. However, this commit message explains all the scenarios.
> Yes.  The commit message is correct and covers many cases.  What I
> suggested is to describe why we do that?  An examples can not covers all
> possibility, but it is easy to be understood.  For example, something as
> below?
>
> For example, on a 2-sockets system, there are N0, N1, N2 in socket 0, N3
> in socket 1.  N0, N1, N3 have fast memory and CPU, while N2 has slow
> memory and no CPU.  For a workload, we may use MPOL_PREFERRED_MANY with
> nodemask with N0 and N1 set because the workload runs on CPUs of socket
> 0 at most times.  Then, even if the workload runs on CPUs of N3
> occasionally, we will not try to migrate the workload pages from N2 to
> N3 because users may want to avoid cross-socket access as much as
> possible in the long term.
>
>> For example, Consider a system with 3 numa nodes (N0,N1 and N6).
>> N0 and N1 are tier1 DRAM nodes  and N6 is tier 2 PMEM node.
>>
>> Scenario 1: The process is executing on N1,
>>              If the executing node is in the policy node mask,
>>              Curr Loc Pages - The numa node where page present(folio node)
>> ==================================================================================
>> Process      Policy          Curr Loc Pages                 Observations
>> -----------------------------------------------------------------------------------
>> N1           N0 N1 N6              N0                   Pages Migrated from N0 to N1
>> N1           N0 N1 N6              N6                   Pages Migrated from N6 to N1
>> N1           N0 N1                 N1                   Pages Migrated from N1 to N6
> Pages are not Migrating ?

Sorry .This is a mistake. In this case Pages are not migrating.

Thanks
Donet.

>
>> N1           N0 N1                 N6                   Pages Migrated from N6 to N1
>> ------------------------------------------------------------------------------------
>> Scenario 2:  The process is executing on N1,
>>               If the executing node is NOT in the policy node mask,
>>               Curr Loc Pages - The numa node where page present(folio node)
>> ===================================================================================
>> Process       Policy       Curr Loc Pages       Observations
>> -----------------------------------------------------------------------------------
>> N1            N0 N6             N0              Pages are not Migrating
>> N1            N0 N6             N6              Pages are not migration,
>> N1            N0                N0              Pages are not Migrating
>> ------------------------------------------------------------------------------------
>>
>> Scenario 3: The process is executing on N1,
>>              If the executing node and folio nodes are  NOT in the policy node mask,
>>              Curr Loc Pages - The numa node where page present (folio node)
>> ====================================================================================
>> Thread    Policy       Curr Loc Pages           Observations
>> ------------------------------------------------------------------------------------
>> N1          N0               N6                 Pages are not Migrating
>> N1          N6               N0                 Pages are not Migrating
>> ------------------------------------------------------------------------------------
>>
>> We can conclude that even if the pages are distributed among multiple sockets,
>> if the executing node is in the policy node mask, we allow numa migration to the
>> executing nodes. If the executing node is not in the policy node mask,
>> we do not allow numa migration.
>>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

