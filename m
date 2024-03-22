Return-Path: <linux-kernel+bounces-111272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B578869F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FF91F25FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BAC38DC8;
	Fri, 22 Mar 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y+TbRhax"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84423778
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102037; cv=none; b=o2v8Mf3yO3n2xGyZEXPW8GYub/2wyXBG+ItpOrckEfh0nCVXp1L3DdnrYhJIWOfutmSr2j1UF6UWdpDgFFLlFp7MyUnXyW7QltsNwuvlBkZQuhBdD2/Tbco2BfC9xnCo9fv5X5/DGXTldfNIKFpjQQORoJCChzS3oxfGsW+HcsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102037; c=relaxed/simple;
	bh=7TtEdYzPi5fbQRciNfcHTMCffp6dm4m9znlEhabaVpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlLpgtevjMK+p64pQaFVy6okmGVRpL/Gs3uyQgs3no+6Vuj+wOzaxciAhZgwaYa0MYEnDr8LaVO6Zi9B7yMvdlYTJCy9HA+zarKf6oM9KGx0eUexqDK7InWdfqK75ImskICNuND1CzMOBaMvGGitd8AWS80oqub019c68I/VG7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y+TbRhax; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M92eR9012464;
	Fri, 22 Mar 2024 10:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9TMi6egVQdQZ0zgEWercfnyS9DH0TyrEgDXmK2bzoKo=;
 b=Y+TbRhaxoarvY2UQpSRlThS18yHtC23MaVoujjxN3cuNxdnAVeBCZRHNmNWcgBL3242P
 wV8DD0cfFIlNAv182nvVeTVqzFZ+kzvUHkFPVND2oP9f36AjlpIWorNGdeghd1/VVGOQ
 4wNA3JJQiV+PphtKJEDs11/a/rAEDThcknn5TC3UVsswfSUw+Ju3KKw3Tv6b4qK4nG0e
 MmV+c3l2gz7D2mR1PCx37QS/0SoFpes2NcK4H18JHEDa/rbJWu2/0/JClDcfIgnMCAY6
 SbJ/tfl2PMy7RSufuOPHJHJJ1B2OdRuusn5yS0w2t0EuPmQn1vAuvtkcl8keJMPQNk8y MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x170kg4wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 10:06:11 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MA6A6b013715;
	Fri, 22 Mar 2024 10:06:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x170kg4ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 10:06:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42M8kbre023107;
	Fri, 22 Mar 2024 10:06:10 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x0x14k1f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 10:06:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42MA67Y158327320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:06:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 079BC58054;
	Fri, 22 Mar 2024 10:06:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 695C558062;
	Fri, 22 Mar 2024 10:06:00 +0000 (GMT)
Received: from [9.109.245.191] (unknown [9.109.245.191])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Mar 2024 10:06:00 +0000 (GMT)
Message-ID: <e65b4e89-e8a9-475d-abc7-c63db8af435e@linux.ibm.com>
Date: Fri, 22 Mar 2024 15:35:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
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
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <87h6gyr7jf.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hUllS7CfOo4ofICQxkpMJXcJReClnl_Y
X-Proofpoint-ORIG-GUID: OQpOjerspSrz7iRtEskWfLOdJbyHARGt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220071


On 3/22/24 14:02, Huang, Ying wrote:
> Donet Tom <donettom@linux.ibm.com> writes:
>
>> commit bda420b98505 ("numa balancing: migrate on fault among multiple bound
>> nodes") added support for migrate on protnone reference with MPOL_BIND
>> memory policy. This allowed numa fault migration when the executing node
>> is part of the policy mask for MPOL_BIND. This patch extends migration
>> support to MPOL_PREFERRED_MANY policy.
>>
>> Currently, we cannot specify MPOL_PREFERRED_MANY with the mempolicy flag
>> MPOL_F_NUMA_BALANCING. This causes issues when we want to use
>> NUMA_BALANCING_MEMORY_TIERING. To effectively use the slow memory tier,
>> the kernel should not allocate pages from the slower memory tier via
>> allocation control zonelist fallback. Instead, we should move cold pages
>> from the faster memory node via memory demotion. For a page allocation,
>> kswapd is only woken up after we try to allocate pages from all nodes in
>> the allocation zone list. This implies that, without using memory
>> policies, we will end up allocating hot pages in the slower memory tier.
>>
>> MPOL_PREFERRED_MANY was added by commit b27abaccf8e8 ("mm/mempolicy: add
>> MPOL_PREFERRED_MANY for multiple preferred nodes") to allow better
>> allocation control when we have memory tiers in the system. With
>> MPOL_PREFERRED_MANY, the user can use a policy node mask consisting only
>> of faster memory nodes. When we fail to allocate pages from the faster
>> memory node, kswapd would be woken up, allowing demotion of cold pages
>> to slower memory nodes.
>>
>> With the current kernel, such usage of memory policies implies we can't
>> do page promotion from a slower memory tier to a faster memory tier
>> using numa fault. This patch fixes this issue.
>>
>> For MPOL_PREFERRED_MANY, if the executing node is in the policy node
>> mask, we allow numa migration to the executing nodes. If the executing
>> node is not in the policy node mask, we do not allow numa migration.
> Can we provide more information about this?  I suggest to use an
> example, for instance, pages may be distributed among multiple sockets
> unexpectedly.

Thank you for your suggestion. However, this commit message explains all the scenarios.

For example, Consider a system with 3 numa nodes (N0,N1 and N6).
N0 and N1 are tier1 DRAM nodes  and N6 is tier 2 PMEM node.

Scenario 1: The process is executing on N1,
             If the executing node is in the policy node mask,
             Curr Loc Pages - The numa node where page present(folio node)
==================================================================================
Process      Policy          Curr Loc Pages                 Observations
-----------------------------------------------------------------------------------
N1           N0 N1 N6              N0                   Pages Migrated from N0 to N1
N1           N0 N1 N6              N6                   Pages Migrated from N6 to N1
N1           N0 N1                 N1                   Pages Migrated from N1 to N6
N1           N0 N1                 N6                   Pages Migrated from N6 to N1
------------------------------------------------------------------------------------
Scenario 2:  The process is executing on N1,
              If the executing node is NOT in the policy node mask,
              Curr Loc Pages - The numa node where page present(folio node)
===================================================================================
Process       Policy       Curr Loc Pages       Observations
-----------------------------------------------------------------------------------
N1            N0 N6             N0              Pages are not Migrating
N1            N0 N6             N6              Pages are not migration,
N1            N0                N0              Pages are not Migrating
------------------------------------------------------------------------------------

Scenario 3: The process is executing on N1,
             If the executing node and folio nodes are  NOT in the policy node mask,
             Curr Loc Pages - The numa node where page present (folio node)
====================================================================================
Thread    Policy       Curr Loc Pages           Observations
------------------------------------------------------------------------------------
N1          N0               N6                 Pages are not Migrating
N1          N6               N0                 Pages are not Migrating
------------------------------------------------------------------------------------

We can conclude that even if the pages are distributed among multiple sockets,
if the executing node is in the policy node mask, we allow numa migration to the
executing nodes. If the executing node is not in the policy node mask,
we do not allow numa migration.

Thanks
Donet Tom

>
> --
> Best Regards,
> Huang, Ying
>
>> Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>> ---
>>   mm/mempolicy.c | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index aa48376e2d34..13100a290918 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -1504,9 +1504,10 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
>>   	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
>>   		return -EINVAL;
>>   	if (*flags & MPOL_F_NUMA_BALANCING) {
>> -		if (*mode != MPOL_BIND)
>> +		if (*mode == MPOL_BIND || *mode == MPOL_PREFERRED_MANY)
>> +			*flags |= (MPOL_F_MOF | MPOL_F_MORON);
>> +		else
>>   			return -EINVAL;
>> -		*flags |= (MPOL_F_MOF | MPOL_F_MORON);
>>   	}
>>   	return 0;
>>   }
>> @@ -2770,15 +2771,26 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
>>   		break;
>>   
>>   	case MPOL_BIND:
>> -		/* Optimize placement among multiple nodes via NUMA balancing */
>> +	case MPOL_PREFERRED_MANY:
>> +		/*
>> +		 * Even though MPOL_PREFERRED_MANY can allocate pages outside
>> +		 * policy nodemask we don't allow numa migration to nodes
>> +		 * outside policy nodemask for now. This is done so that if we
>> +		 * want demotion to slow memory to happen, before allocating
>> +		 * from some DRAM node say 'x', we will end up using a
>> +		 * MPOL_PREFERRED_MANY mask excluding node 'x'. In such scenario
>> +		 * we should not promote to node 'x' from slow memory node.
>> +		 */
>>   		if (pol->flags & MPOL_F_MORON) {
>> +			/*
>> +			 * Optimize placement among multiple nodes
>> +			 * via NUMA balancing
>> +			 */
>>   			if (node_isset(thisnid, pol->nodes))
>>   				break;
>>   			goto out;
>>   		}
>> -		fallthrough;
>>   
>> -	case MPOL_PREFERRED_MANY:
>>   		/*
>>   		 * use current page if in policy nodemask,
>>   		 * else select nearest allowed node, if any.

