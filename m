Return-Path: <linux-kernel+bounces-86124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD96886BFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BE91F22BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D05838F97;
	Thu, 29 Feb 2024 04:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jqE252JX"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD22374EA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709182274; cv=none; b=R2SrJ67MDIqaEdKYzw91YqdtcdBVDsS4STyq3/7g0+E8v3e72gzfWUPYAmaFFSFwKs4nQJZyOwzWWPBO6FYvGTzK/lf+b6xs69OCbZM/hw+8Xu2aELsVMrAKzbOMEF6cofP1zKAhNGzUEZAJk1upSm/TkuTg71MZ6W4RRZIh/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709182274; c=relaxed/simple;
	bh=DMwSyXHVYtlcE39DYPUGiJ1K7z0IF3xCoLii2Sd+HCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjBiXtqwQHMR6O9cAG0TE6WRfYJPRdX1aGSiWw0BMs50pnsyP81mU47JpZrDc7Kt3FswF2eyQmt3W6PfgBj525ApYqxASj8VRQmP50Yu7pHXPmBnx9hmTtYQPyVUA/JEj6e+Bqqq9X09P7yuMND8fR/wilHkjAMeA3WPKUoJP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jqE252JX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T3x6a0020886;
	Thu, 29 Feb 2024 04:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=F1j6OMAur2EReyq9uj1aosLkqEbI8SlT5bNl5MURpv4=;
 b=jqE252JXeQsT4tL1QaG4ucsRBvP9SxjSPbEfhmz5CdrS6247PbKd3hOHjQfkVliguh+H
 MrOjDBbRVGWbj4oX72MIQZUcPw0ZzMkzIkd8lWiXfRjpR661WnQdL0cU8cMWjKQrYh3F
 ApWhsFYn9s/tLKYF5ew8OwfVa2KtGgeqzWRkLiXSbXq+eP7LHdLhh7m6I6KDZxG+CbDv
 K13540TgjDULwBl1F/akwd4ltPMUlvmAXd+zo7yFQdY6S/Wkem3kDh+4s2NU9d8+irHj
 8aBs4SRL0fKAvFbKmANda//Xtd7MeUBTLiPcuSSGKWodSkqMqNZw2J/ZCH0xgoaFoUc4 Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjj8p1f7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 04:50:55 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41T4m7Xa030470;
	Thu, 29 Feb 2024 04:50:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjj8p1f5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 04:50:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41T2mM5f008178;
	Thu, 29 Feb 2024 04:46:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mjvfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 04:46:56 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41T4krqM36831586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 04:46:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 702CE58061;
	Thu, 29 Feb 2024 04:46:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B33E55805C;
	Thu, 29 Feb 2024 04:46:48 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 04:46:48 +0000 (GMT)
Message-ID: <ff18e64e-d444-40a4-91a7-778d3a523050@linux.ibm.com>
Date: Thu, 29 Feb 2024 10:16:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] sched/fair: Limit access to overutilized
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com
References: <20240228071621.602596-1-sshegde@linux.ibm.com>
 <20240229000817.n2bnr4kioigaqtct@airbuntu>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240229000817.n2bnr4kioigaqtct@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gdikrROokuNS7VWchLzpdurmXl9rRuZf
X-Proofpoint-ORIG-GUID: bT1nYwcRrlPwGD45CyWhVpK2OEOrlEnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290035



On 2/29/24 5:38 AM, Qais Yousef wrote:
> On 02/28/24 12:46, Shrikanth Hegde wrote:
[...]
>> Overutilized was added for EAS(Energy aware scheduler) to choose either
>> EAS aware load balancing or regular load balance. As checked, on x86 and
> 
> It actually toggles load balance on/off (off if !overutilized).
> 
> misfit load balance used to be controlled by this but this was decoupled since
> commit e5ed0550c04c ("sched/fair: unlink misfit task from cpu overutilized")
> 

Ok.

>> powerpc both overload and overutilized share the same cacheline in rd.
>> Updating overutilized is not required for non-EAS platforms.
> 
> Is the fact these two share the cacheline is part of the problem? From patch
> 1 it seems the fact that overutlized is updated often on different cpus is the
> problem? Did you try to move overutlized to different places to see if this
> alternatively helps?
> 
> The patches look fine to me. I am just trying to verify that indeed the access
> to overutilzed is the problem, not something else being on the same cacheline
> is accidentally being slowed down, which means the problem can resurface in the
> future.
> 

We did explicit cachealign for overload. By doing that newidle_balance goes away from
perf profile. But enqueue_task_fair still remains. That because there is load-store 
tearing happening on overutilized field alone due to different CPUs accessing and 
updating it at the same time. 

We have also verified that rq->rd->overutilized in enqueue_task_fair path is the reason
for it showing up in perf profile. 

>>
[...]
>>
>> --
>> 2.39.3
>>

