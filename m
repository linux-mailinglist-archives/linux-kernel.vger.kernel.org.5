Return-Path: <linux-kernel+bounces-70940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A61859E64
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF976281E53
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D3224DC;
	Mon, 19 Feb 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jk6S1oc/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91351224C9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331748; cv=none; b=P2TVF1TdM1VnkKYnRuuiwLZwX4Yo/rVBdY8A3Iv+Ti4ACCv382e5DKUHUXjRxrLsvx66yS070uL6hweNPKrnzMxLfeOVc5UtSwMaQnXvNOZANiywF/kLiyxvcGJO0NshfCUmNkqb37HSJhPW+xcghNeHBna9lLqT23v98FtkfnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331748; c=relaxed/simple;
	bh=BRI+jBcPAJ6HgLYpoJx6rbmANXx2dSqiqZs/tVZfAwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CyAJLJk21brSWWh++5UYxbyrgrYuqvThd6YYrUgl+XVTf2xawnKE6+mcgEo/nlRrSwhqtNMEQxEjRE2ZEHQnyDLE2+SvL2lQdgWVgAFSSYjvRfbW116IQPgYoQ0r2sFJovvLB2W6HKUYGmZEJLiOXHJF3KF9cSSyQUKmcrwXVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jk6S1oc/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J7HrJ1015351;
	Mon, 19 Feb 2024 08:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=W+DlIcgGzAZl3NaBK8gp9F/M4NDAB6yQAnUg1uqgJSI=;
 b=jk6S1oc/QppIW6bPUVZqW+zCfehnok3b3tO+XA+2KUPSXxX4nvuu4dpi2KRs01XNT+CJ
 FudN5AUUrh99QYip96lO11F5GxHkQ7bu0vU3nJhXz+HSjBCPZBfthQu8isqGYFGY4ojQ
 dTNGz+9uhUFw/x3oLVzCqWGNbKyZQnp3rHU5QZy6YjwUwExdoJZvZzNDsjuaSbeSwZF5
 8uT5CK6Vp2bo/ujFazaaOaWQ9iYvM9FBVKVESTLAVjKsnsxqBlm01mJjEsAMPU47DYk0
 b5xOwK8f3OeV8RIwSRBpFstCWfQypOEBG1LKAqfpC3vMY4LC3LLu5k3xWF629DO28IT0 oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb3w79juj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 08:34:42 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41J8B5xS023389;
	Mon, 19 Feb 2024 08:34:41 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb3w79jub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 08:34:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41J6UYcZ031118;
	Mon, 19 Feb 2024 08:34:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bkfktg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 08:34:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41J8Ybll21037570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 08:34:40 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA0D458064;
	Mon, 19 Feb 2024 08:34:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3802758066;
	Mon, 19 Feb 2024 08:34:30 +0000 (GMT)
Received: from [9.109.245.191] (unknown [9.109.245.191])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 08:34:29 +0000 (GMT)
Message-ID: <63a0f7c4-3c3f-4097-9a24-d1e3fc7b6030@linux.ibm.com>
Date: Mon, 19 Feb 2024 14:04:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/mempolicy: Use the already fetched local variable
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Ben Widawsky <ben.widawsky@intel.com>,
        Feng Tang <feng.tang@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
 <20240218133851.22c22b55460e866a099be5ce@linux-foundation.org>
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20240218133851.22c22b55460e866a099be5ce@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JdZqDiB5eVcS1JeYf3jBi_8uBg7XTy8o
X-Proofpoint-GUID: VtJweGyLEc8FaQ0QA9ztAUpcNFKPxVNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_05,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402190063


On 2/19/24 03:08, Andrew Morton wrote:
> On Sat, 17 Feb 2024 01:31:33 -0600 Donet Tom <donettom@linux.ibm.com> wrote:
>
>> Avoid doing a per cpu read and use the local variable thisnid. IMHO
>> this also makes the code more readable.
>>
>> ...
>>
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -2526,7 +2526,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
>>   		if (node_isset(curnid, pol->nodes))
>>   			goto out;
>>   		z = first_zones_zonelist(
>> -				node_zonelist(numa_node_id(), GFP_HIGHUSER),
>> +				node_zonelist(thisnid, GFP_HIGHUSER),
>>   				gfp_zone(GFP_HIGHUSER),
>>   				&pol->nodes);
>>   		polnid = zone_to_nid(z->zone);
> 	int thisnid = cpu_to_node(thiscpu);
>
> Is there any dofference between numa_node_id() and
> cpu_to_node(raw_smp_processor_id())?  And it it explicable that we're
> using one here and not the other?

Hi Andrew

Both numa_node_id() and cpu_to_node(raw_smp_processor_id()) return the current execution node id,
Since the current execution node is already fetched at the beginning (thisnid) we can reuse it instead of getting it again.

Thanks
Donet Tom

>

