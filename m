Return-Path: <linux-kernel+bounces-122436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A937088F768
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB821C24042
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4D48CC6;
	Thu, 28 Mar 2024 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hpVB75HD"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581593E480
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711604914; cv=none; b=VpjJlcoyrEeMhbLAz1QQJ0YScHifqYOQgGji9gsc7VmW1Kg+zQpxU2uHzK+eirVRrw3J5FlLUO/fkRVvRgon0dBXVc8R35Byed1ficrf0Cr0Q+mxIfZrJol5Mx/xoQ+iB4oCNl0cuYsbn+CnY0MIoxzhB5+F32DtqSOQosz5tkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711604914; c=relaxed/simple;
	bh=MvuqPwvbbbqdvPlx+rA7zYrmOuh+SWcfcVfPClp2XC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ijXFNwK5ftoNy3rQkQMzIu7/o6INRUddNKJ/AHHzBNyfTuawRuSHUUflQ5ZP5PA2D0iMHEd6H0LFqt7/0BeMK7EIbc+zGFXpuWoeElXhylFItWmxiXyCxEvTrPemvWPiC9Aken43gs92M1+iR1lTucfygcVpuTqacUISIm0lp9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hpVB75HD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S57QJY030861;
	Thu, 28 Mar 2024 05:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : cc : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1mBPQSp6iJK9AjeMtP5x2An5DOX3bsekImLaSP/w6aU=;
 b=hpVB75HDSYKc2nUoR1Wdx0ck8XQKC+evPVmTFpCMnwxuy5rYGEnoYarVh9G7P5xNv2fB
 /ipp4sy13GjIb6LG6i+nfS+0YU6LRESWihfQpP67SM4AJCPht3Sj61opD4AyOcEpdkTo
 CK8dFAvLcUBkjVDIZ0eyrZ67mi/GarkxMc2MwGWJLVVg3eqpJ/RdvGowbP9LT49UEMan
 c4KF7hqb0V6NiP+o1tzUI6mYFUeycWUpJUiHs3y1wELF0vHstIwxHjvm61uOo0Pw4jQ4
 gZYsY7b2VzI5UGLCwJZVUMGe+TS/gnY4jsc4JBhzIQLIyyuIZMBJjiJSFqR9UDKXus2N gQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x524a02hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:48:28 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42S3W2S9003747;
	Thu, 28 Mar 2024 05:48:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2c4332p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:48:27 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42S5mPqq38142284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 05:48:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EDEE58063;
	Thu, 28 Mar 2024 05:48:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A8DF58056;
	Thu, 28 Mar 2024 05:48:24 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 05:48:23 +0000 (GMT)
Message-ID: <29b1db65-03c6-41a6-8556-f788c4161efd@linux.ibm.com>
Date: Thu, 28 Mar 2024 11:18:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] sched/fair: allow disabling newidle_balance with
 sched_relax_domain_level
To: Vitalii Bursov <vitaly@bursov.com>
References: <cover.1711584739.git.vitaly@bursov.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cover.1711584739.git.vitaly@bursov.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CH4bubbfE5UEaRYt5C2KMMgtHhF2DhhS
X-Proofpoint-ORIG-GUID: CH4bubbfE5UEaRYt5C2KMMgtHhF2DhhS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_04,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280034



On 3/28/24 6:17 AM, Vitalii Bursov wrote:
> Hi,
> 
> During the upgrade from Linux 5.4 we found a small (around 3%) 
> performance regression which was tracked to commit 

You see the regression since it is doing more newidle balance? 

> c5b0a7eefc70150caf23e37bc9d639c68c87a097
> 
>     sched/fair: Remove sysctl_sched_migration_cost condition
> 
>     With a default value of 500us, sysctl_sched_migration_cost is
>     significanlty higher than the cost of load_balance. Remove the
>     condition and rely on the sd->max_newidle_lb_cost to abort
>     newidle_balance.
> 
> 
> Looks like "newidle" balancing is beneficial for a lot of workloads, 
> just not for this specific one. The workload is video encoding, there 
> are 100s-1000s of threads, some are synchonized with mutexes and

s/synchonized/synchronized/
 
> conditional variables. The process aims to have a portion of CPU idle, 
> so no CPU cores are 100% busy. Perhaps, the performance impact we see 
> comes from additional processing in the scheduler and additional cost 
> like more cache misses, and not from an incorrect balancing. See
> perf output below.
> 
> My understanding is that "sched_relax_domain_level" cgroup parameter 
> should control if newidle_balance() is called and what's the scope

s/newidle_balance()/sched_balance_newidle()   at all the places since the 
name has been changed recently. 

> of the balancing is, but it doesn't fully work for this case.
> 
> cpusets.rst documentation:
>> The 'cpuset.sched_relax_domain_level' file allows you to request changing
>> this searching range as you like.  This file takes int value which
>> indicates size of searching range in levels ideally as follows,
>> otherwise initial value -1 that indicates the cpuset has no request.
>>  
>> ====== ===========================================================
>>   -1   no request. use system default or follow request of others.
>>    0   no search.
>>    1   search siblings (hyperthreads in a core).
>>    2   search cores in a package.
>>    3   search cpus in a node [= system wide on non-NUMA system]
>>    4   search nodes in a chunk of node [on NUMA system]
>>    5   search system wide [on NUMA system]
>> ====== ===========================================================
> 

I think this document needs to be updated. levels need not be serial order 
due to sched domains degenation. It should have a paragraph which tells the user
to take a look at /sys/kernel/debug/sched/domains/cpu*/domain*/ for system 
specific details. 

> Setting cpuset.sched_relax_domain_level to 0 works as 1.
> 
> On a dual-CPU server, domains and levels are as follows:
>   domain 0: level 0, SMT
>   domain 1: level 2, MC
>   domain 2: level 5, NUMA
> 
> So, to support "0 no search", the value in 
> cpuset.sched_relax_domain_level should disable SD_BALANCE_NEWIDLE for a 
> specified level and keep it enabled for prior levels. For example, SMT 
> level is 0, so sched_relax_domain_level=0 should exclude levels >=0.
> 
> Instead, cpuset.sched_relax_domain_level enables the specified level,
> which effectively removes "no search" option. See below for domain
> flags for all cpuset.sched_relax_domain_level values.
> 
> Proposed patch allows clearing SD_BALANCE_NEWIDLE flags when 
> cpuset.sched_relax_domain_level is set to 0 and extends max
> value validation range beyond sched_domain_level_max. This allows
> setting SD_BALANCE_NEWIDLE on all levels and override platform
> default if it does not include all levels.
> 

