Return-Path: <linux-kernel+bounces-126687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0F1893B75
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6077F28188F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF5C3F9C5;
	Mon,  1 Apr 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EeT6QxYE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4233F8E0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978246; cv=none; b=YU85Ek3wABG+NR1C8pEgfHd7eeTfbzr0MDAzKzwxma0I+nuIfS+zDMJxXcYZ8d2EZTAdtDmA/8fSM2NBzEDTTkHX5ZY/duIGjylhuhQHtAY3lblNW8pzBPPTew6oa7geOUcAV4+4hoJUGLj3kV3pgMHL6MoqJFa0Z/HZRwJIN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978246; c=relaxed/simple;
	bh=l8Rmbnm5bfzqhkQDekEKXU/9L++kGmxGTPBiuQtYjkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNVeNM7tBgta3+vUYAlD2Vmi/sks4ZpUp2JklfiQOf7qAmJ1lldsSQtenh/f1oo28tVn92CMzAF6WTZEy0t1E7E9MOjt5HyKgonSKBH2QdCesgBl/brAV+NGeU5OqHOIr/CJGOGrTGZUfmIxIKgN4fvnIAHqV6Cds4TC8DJmxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EeT6QxYE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431DJlE7020912;
	Mon, 1 Apr 2024 13:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mZ054kOzWIIAqwTc19RMLPFYnX3vtoxYOe5U5coBzeM=;
 b=EeT6QxYEltimETBrskW1VpyiWQgjhPsxuRjsXAf/IMwnf3ffqQE/tOc/dk6rwhkVUC3E
 VCjiC2GrOOzFfKZNB2E8vTF6qIsDJUcFsR/LWhETRvB0McWgrF5Q5hdYU60lb88gZnOd
 TglCbA2a81b19eJ7QJNC1By1OY5z4x6ZxN3Fe0pDoU+K7eKyoBcctJByapOxHpaEtZlO
 eaAgnjvw44pibIBs9XzNELTv3VrQugIURssZGTfVTj1oPB/z4Q31laIWA3eD9qCVmg4i
 WYpU2E4wsJqAsrHkpPrqIeaznDWUp5UHCFkXh3fZpeCH3sBaV34ZwZ0/pRKrUALpcpT7 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7v2dr73y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 13:30:22 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 431DUL8e004136;
	Mon, 1 Apr 2024 13:30:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7v2dr73s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 13:30:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 431BYJRi025721;
	Mon, 1 Apr 2024 13:30:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6x2p0bv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 13:30:20 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 431DUHmY44957966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Apr 2024 13:30:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46CF958050;
	Mon,  1 Apr 2024 13:30:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B80F258069;
	Mon,  1 Apr 2024 13:30:12 +0000 (GMT)
Received: from [9.195.32.11] (unknown [9.195.32.11])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Apr 2024 13:30:12 +0000 (GMT)
Message-ID: <540e7569-de5f-4167-a0f3-e508c7bdd63c@linux.ibm.com>
Date: Mon, 1 Apr 2024 19:00:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs: cgroup-v1: clarify that domain levels are
 system-specific
To: Vitalii Bursov <vitaly@bursov.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
References: <cover.1711900396.git.vitaly@bursov.com>
 <af9562aac2e9208029aef1dd19c3b0e096dd42c7.1711900396.git.vitaly@bursov.com>
 <3d85926d-378a-4d5e-8303-92461bd3b100@linux.ibm.com>
 <78c60269-5aee-45d7-8014-2c0188f972da@bursov.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <78c60269-5aee-45d7-8014-2c0188f972da@bursov.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OZ0Cnki74i7rggO0SIKysMoaCBoejdi8
X-Proofpoint-ORIG-GUID: 9lnCPhCEZaFmhmv9cQJZ63nzawQ_qNvN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404010096



On 4/1/24 4:05 PM, Vitalii Bursov wrote:
> 
> 
> On 01.04.24 07:05, Shrikanth Hegde wrote:
>>
>>
>> On 3/31/24 9:31 PM, Vitalii Bursov wrote:
>>> Add a clarification that domain levels are system-specific
>>> and where to check for system details.
>>>
>>> Add CPU clusters to the scheduler domain levels table.
>>>
>>> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
>>> ---
>>>  Documentation/admin-guide/cgroup-v1/cpusets.rst | 16 +++++++++++-----
>>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
>>> index 7d3415eea..d16a3967d 100644
>>> --- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
>>> +++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
>>> @@ -568,19 +568,25 @@ on the next tick.  For some applications in special situation, waiting
>>>  
>>>  The 'cpuset.sched_relax_domain_level' file allows you to request changing
>>>  this searching range as you like.  This file takes int value which
>>> -indicates size of searching range in levels ideally as follows,
>>> +indicates size of searching range in levels approximately as follows,
>>>  otherwise initial value -1 that indicates the cpuset has no request.
>>>  
>>>  ====== ===========================================================
>>>    -1   no request. use system default or follow request of others.
>>>     0   no search.
>>>     1   search siblings (hyperthreads in a core).
>>> -   2   search cores in a package.
>>> -   3   search cpus in a node [= system wide on non-NUMA system]
>>> -   4   search nodes in a chunk of node [on NUMA system]
>>> -   5   search system wide [on NUMA system]
>>> +   2   search cpu clusters
>>> +   3   search cores in a package.
>>> +   4   search cpus in a node [= system wide on non-NUMA system]
>>> +   5   search nodes in a chunk of node [on NUMA system]
>>> +   6   search system wide [on NUMA system]
>>
>> I think above block of documentation need not change. SD_CLUSTER is a software 
>> construct, not a sched domain per se. 
>>
> 
> I added "cpu clusters" because the original table:
> ====== ===========================================================
>   -1   no request. use system default or follow request of others.
>    0   no search.
>    1   search siblings (hyperthreads in a core).
>    2   search cores in a package.
>    3   search cpus in a node [= system wide on non-NUMA system]
>    4   search nodes in a chunk of node [on NUMA system]
>    5   search system wide [on NUMA system]
> ====== ===========================================================
> does not match to what I see on a few systems I checked.
> 
> AMD Ryzen and the same dual-CPU Intel server with NUMA disabled:
>   level:0 - SMT
>   level:2 - MC
>   level:3 - PKG
> 
> Server with NUMA enabled:
>   level:0 - SMT
>   level:2 - MC
>   level:5 - NUMA
> 

None of these are "cpu clusters". 

From what i know, the description for the above are.
SMT - multi-threads/hyperthreads
MC - Multi-Core 
PKG - Package/Socket level 
NUMA - Node level. When you enable, PKG gets degenerated since pkg mask and numa mask would 
have been same. 

 

> So, for the relax level original table:
>   1 -> enables 0 SMP -> OK
>   2 -> enables 1 unknown -> does not enable cores in a package
>   3 -> enables 2 MC -> OK for NUMA, but not system wide on non-NUMA system
>   5 -> enables 4 unknown -> does not enable system wide on NUMA
> 
> The updated table
> ====== ===========================================================
>   -1   no request. use system default or follow request of others.
>    0   no search.
>    1   search siblings (hyperthreads in a core).
>    2   search cpu clusters
>    3   search cores in a package.
>    4   search cpus in a node [= system wide on non-NUMA system]
>    5   search nodes in a chunk of node [on NUMA system]
>    6   search system wide [on NUMA system]
> ====== ===========================================================
> would work like this:
>   1 -> enables 0 SMP -> OK
>   2 -> enables 1 unknown -> does nothing new
>   3 -> enables 2 MC -> OK, cores in a package for NUMA and non-NUMA system
>   4 -> enables 3 PKG -> OK on non-NUMA system

It wont, PKG domain itself wont be there. It gets removed.

>   6 -> enables 5 NUMA -> OK
> 
> I think it would look more correct on "average" systems, but anyway,
> please confirm and I'll remove the table update in an updated patch.
> 

IMHO, the table need not get updated. Just adding a paragraph pointing 
to refer to the sysfs files is good enough. 


> Thanks
> 
>> IMO the next paragraph that is added is good enough and the above change can be removed.
> 
>>>  ====== ===========================================================
>>>  
>>> +Not all levels can be present and values can change depending on the
>>> +system architecture and kernel configuration. Check
>>> +/sys/kernel/debug/sched/domains/cpu*/domain*/ for system-specific
>>> +details.
>>> +
>>>  The system default is architecture dependent.  The system default
>>>  can be changed using the relax_domain_level= boot parameter.
>>>  

