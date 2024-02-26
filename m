Return-Path: <linux-kernel+bounces-81448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 992AD867618
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124E01F25C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D718174C;
	Mon, 26 Feb 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pD55HlzZ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99E7FBCB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953015; cv=none; b=jvmP4R62Nb6mO78cuiBwxSur4OIeafaLbwz6OPTVtc1x3jPUDj4PoviwETBE7US6ULVkoCZrpKzJ6ncezUty9K9QgiPqKzPe7hwyy7KmhdxajffDH3/nADpfEZ4R2KB7fhJ7lF+VqmMcwTL4TID8h2Y7KTR0w1NzcKsW1rNG+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953015; c=relaxed/simple;
	bh=2QpTE8HEcaEB2BJ0B8nzDrAHeb/l9ZbZW410PvVHIdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayQ3hlOe06SxzupksAyJlLVbPjp1sHclo87Vz0VuSspDe0F524BoyQYUvBNmZ6cgDqSY2TJUvCcgbCBrJ7FhsSsI6N+gVIfGkk/o4w2z5Hwz3czWDEQm42yM8VGSRpNoSuzSkEmPZ4qq0ue4erSQIhSQX8zR3reaxbASfWqBOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pD55HlzZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QCsw90023561;
	Mon, 26 Feb 2024 13:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VfWtWmbtiXwnoVJ0ekIYKJDZKxJUaW6dtIBwoZb8OTs=;
 b=pD55HlzZoKE8GNEreGe8NBja7n1xHXsUz8nIW3ZOjC5WTWHgsG+42mDEjrEjmTjvDLSt
 d0SKGP6AE7BVOifXeib9SJxcLKmZQOC/JZ9U8MTX8RxWhQmU1JZHrra7Z7Yk3l4/5604
 9ChPv4AHjBU8C1scQ5oj484YZSUwWBDmgk7I7jeQZKayxNDWbkoCMUmy2M85ajz1VMID
 LDSrC7UeG3ZjwRkGeH3Y9w4xNXhLT8Xa6q/4295j5jXYGnJ/m1zqrK120klvdzlZ5f8n
 mZNxJpqPra/rWlj5U8NYhltlwb3v9HHoJhYl+/KJt9qTsAjN/c4RDpWvpqRm0HpL/2ZY Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgdvuqy2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 13:09:33 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41QD1UxN026834;
	Mon, 26 Feb 2024 13:09:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgdvuqy1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 13:09:32 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QAmiPe021762;
	Mon, 26 Feb 2024 13:09:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu5ysays-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 13:09:31 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QD9SUo44237468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 13:09:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E288F58071;
	Mon, 26 Feb 2024 13:09:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCC005805F;
	Mon, 26 Feb 2024 13:09:18 +0000 (GMT)
Received: from [9.109.245.191] (unknown [9.109.245.191])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 13:09:18 +0000 (GMT)
Message-ID: <0e633718-2313-4a0f-9907-b0fa5ffa18bc@linux.ibm.com>
Date: Mon, 26 Feb 2024 18:39:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/numa_balancing:Allow migrate on protnone reference
 with MPOL_PREFERRED_MANY policy
To: Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Ben Widawsky <ben.widawsky@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz
 <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
 <ZdNjmOlkMqEOGci1@tiehlicka>
 <25b420aa-3fe6-40a4-8d60-a46ab61ee7b7@linux.ibm.com>
 <ZdOoF_pMAa-FGN4m@tiehlicka>
 <0f0fd8e3-98b2-4001-ba6a-6a8a26a5393f@kernel.org>
 <ZdRneVbsts8t3VAW@tiehlicka>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <ZdRneVbsts8t3VAW@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vKlneigSdiNmbAH5ZLTjdnHMAGvwyw3x
X-Proofpoint-ORIG-GUID: y8fV19dnBkQNypfuOyDjvBmB4Xeu5cOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_09,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 mlxlogscore=748 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402260099


On 2/20/24 14:18, Michal Hocko wrote:
> On Tue 20-02-24 09:27:25, Aneesh Kumar K.V wrote:
> [...]
>> 	case MPOL_PREFERRED_MANY:
>> 		if (pol->flags & MPOL_F_MORON) {
>> 			if (!mpol_preferred_should_numa_migrate(thisnid, curnid, pol))
>> 				goto out;
>> 			break;
>> 		}
>>
>> 		/*
>> 		 * use current page if in policy nodemask,
>> 		 * else select nearest allowed node, if any.
>> 		 * If no allowed nodes, use current [!misplaced].
>> 		 */
>> 		if (node_isset(curnid, pol->nodes))
>> 			goto out;
>> 		z = first_zones_zonelist(
>> 				node_zonelist(thisnid, GFP_HIGHUSER),
>> 				gfp_zone(GFP_HIGHUSER),
>> 				&pol->nodes);
>> 		polnid = zone_to_nid(z->zone);
>> 		break;
>>   ....
>> ..
>>         }
>>
>> 	/* Migrate the folio towards the node whose CPU is referencing it */
>> 	if (pol->flags & MPOL_F_MORON) {
>> 		polnid = thisnid;
>>
>> 		if (!should_numa_migrate_memory(current, folio, curnid,
>> 						thiscpu))
>> 			goto out;
>> 	}
>>
>> 	if (curnid != polnid)
>> 		ret = polnid;
>> out:
>> 	mpol_cond_put(pol);
>>
>> 	return ret;
>> }
> Ohh, right this code is confusing as hell. Thanks for the clarification.
> With this in mind. There should be a comment warning about MPOL_F_MOF
> always being unset as the userspace cannot really set it up.
>
> Thanks!
>
Hi Michal

Sorry For the late reply.
If we set  MPOL_F_NUMA_BALANCING from userspace then MPOL_F_MOF and MPOL_F_MORON flags will get set in kernel.

/* Basic parameter sanity check used by both mbind() and set_mempolicy() */
static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
{
     *flags = *mode & MPOL_MODE_FLAGS;
     *mode &= ~MPOL_MODE_FLAGS;

     if ((unsigned int)(*mode) >=  MPOL_MAX)
         return -EINVAL;

     if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
         return -EINVAL;

     if (*flags & MPOL_F_NUMA_BALANCING) {
         if (*mode == MPOL_BIND || *mode == MPOL_PREFERRED_MANY)
             *flags |= (MPOL_F_MOF | MPOL_F_MORON);
         else
             return -EINVAL;
}

In current kernel it is supported only for MPOL_BIND and we added suppor for MPOL_PREFERRED_MANY also.

Why MPOL_F_MOF  flag is required?
---------------------------------
For NUMA migration the process memory is unmapped by "task_numa_work" periodically, if unmapped memory got
accessed again then NUMA hinting page fault will occur and in page fault handler the pages get migrated.

If MPOL_F_MOF is not set then "task_numa_work" will not unmap the process pages and NUMA hinting page fault
and migration will not occur. This change has been introduced by commit
fc3147245d193b (mm: numa: Limit NUMA scanning to migrate-on-fault VMAs).

How new implementation works
----------------------------
MPOL_PREFERRED_MANY is able to set  MPOL_F_MOF and MPOL_F_MORON through MPOL_F_NUMA_BALANCING. So NUMA hinting
page faults will occur. In mpol_misplaced if we can do numa migration, we select the currently executing node as the target node
otherwise we end up returning from the function with ret = NUMA_NO_NODE.

So since we are able to set MPOL_F_MOF from userspace through MPOL_F_NUMA_BALANCING, no need to add this comment right?

Thanks
Donet Tom



