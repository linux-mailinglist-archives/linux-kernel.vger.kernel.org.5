Return-Path: <linux-kernel+bounces-92570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6120087225A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A521C21013
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296AD126F2F;
	Tue,  5 Mar 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ACrryp5E"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05255126F02
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651021; cv=none; b=e5yZRCgDnMu8aSDIuX2rt3+jgeD452BC6OVOUbUN7dOiQsu0m2lWpurDd3eiAeCpnzZVgnYmsPG9D9ii2NIpFSCEiBH4JDjRcq57PdwCgwPk8WKodnvxaeNvFdcPgt8ye/EHCp0BwMN6HFO3hpXFIzTJBRV2x1V/vZfpPvULp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651021; c=relaxed/simple;
	bh=ovK+xDrXZozbhrnptM8u3dp58JPuSazr4S6Xn+dv9UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mr8two4xuKImpt0QIDMjkpWj2WamabK8Sot7OMA7zf1+1gJHyW7q2sHjQI0vaSi5RpGIDymR9PEtmOIf9Qqc4kBBPn5b1HCZQuvD4rSLvUatyotwYh9gmC0nH5Odvl/S8cCWr+tM9JHclYAwrMr/VaECH18NUw29jyy9LvOR0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ACrryp5E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425F205f003563;
	Tue, 5 Mar 2024 15:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=d+err22il2gKfp4Cq1EkZkWnxavfLbojN62KH00FfHI=;
 b=ACrryp5EN5E0FMRjeX3wnQcZ2fkKYbP6lu06pb9PfEKB72CFm/A3gPXungSWnjv6Un6n
 FAU1N2zc/Yan9lA2TsZj5tS6cA2nYgQTVwFoZZwWRdUrhryctq9FAuiCcXjw831xQViq
 /2hk8cD4NnzLeq9y5/cLhSOlqZJoPVR3mDKvECLdp0+VXIohiI+4bqKMPPb899R9cSkK
 vO0Oki18hnT60j6CEH+c0iB2vrv68RC0frGZqBT0h+XFJiJv7Ufm2xgejSOiZOwP6SCy
 Tyq2jhWtbJ/Z5WF69L+5DY5FHrAj9Fcy1QW2yGdOB/hyM4QHXEDRAsyDqHxkqgmpdswf Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wp5p6r2wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 15:03:28 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 425F3Qlw011423;
	Tue, 5 Mar 2024 15:03:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wp5p6r2r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 15:03:26 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 425DXsWm026296;
	Tue, 5 Mar 2024 15:03:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfenr8bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 15:03:23 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 425F3Kie25166156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Mar 2024 15:03:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F48558052;
	Tue,  5 Mar 2024 15:03:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44CA858056;
	Tue,  5 Mar 2024 15:03:16 +0000 (GMT)
Received: from [9.43.117.244] (unknown [9.43.117.244])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Mar 2024 15:03:15 +0000 (GMT)
Message-ID: <251f9b0d-3e00-4ca7-829b-e622fc0b4c49@linux.ibm.com>
Date: Tue, 5 Mar 2024 20:33:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] sched/fair: Use helper function to access
 rd->overutilized
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, peterz@infradead.org, yu.c.chen@intel.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        nysal@linux.ibm.com, aboorvad@linux.ibm.com, srikar@linux.ibm.com,
        vschneid@redhat.com, pierre.gondois@arm.com, morten.rasmussen@arm.com,
        qyousef@layalina.io
References: <20240301151725.874604-1-sshegde@linux.ibm.com>
 <20240301151725.874604-3-sshegde@linux.ibm.com>
 <CAKfTPtCzHf_R4SwR29FsnxXTv2J4Xrmh3gfoHcVPu3KU5OLDcQ@mail.gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <CAKfTPtCzHf_R4SwR29FsnxXTv2J4Xrmh3gfoHcVPu3KU5OLDcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Ea4MRrRlDrGcFoCfwWxYweaSFcUsZk4
X-Proofpoint-GUID: kJZIEEvi5Hx6_BzxpNDfBek9WyZQeb1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=789 spamscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403050120



On 3/5/24 7:35 PM, Vincent Guittot wrote:
> On Fri, 1 Mar 2024 at 16:18, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> 
> It seems that is_rd_overutilized() is always used with
> sched_energy_enabled() in the pattern:
> 
> If (sched_energy_enabled() && !is_rd_overutilized(rd))
>        do something
> 
> This pattern includes feec() case where we have in select_task_rq_fair():
> 
> If (sched_energy_enabled())
>        feec():
>        |->  if (is_rd_overutilized())
>        |->       goto unlock
> 
> which could be changed into
> If (sched_energy_enabled() && !is_rd_overutilized(rd))
>        feec()
> 
> Then you can create the function is_rd_not_overutilized() instead of
> is_rd_overutilized()
> 
> -static inline int is_rd_overutilized(struct root_domain *rd)
> +static inline int is_rd_not_overutilized(struct root_domain *rd)
>  {
> -       return READ_ONCE(rd->overutilized);
> +       return sched_energy_enabled() && READ_ONCE(rd->overutilized);
>  }
> 
> and use is_rd_not_overutilized() instead
> 

Ok. Makes sense. I will keep this patch as is. and use the above 
approach in a new patch. 

>> +
>>  static inline void set_rd_overutilized_status(struct root_domain *rd,
>>                                               unsigned int status)
>>  {
>> @@ -6686,13 +6695,14 @@ static inline void check_update_overutilized_status(struct rq *rq)
>>         if (!sched_energy_enabled())
>>                 return;
>>
>> -       if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
>> +       if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
>>                 set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
>>  }
>>  #else
>>  static inline void check_update_overutilized_status(struct rq *rq) { }
>>  static inline void set_rd_overutilized_status(struct root_domain *rd,
>>                                               unsigned int status) { }
>> +static inline int is_rd_overutilized(struct root_domain *rd) { }
> 
> It should be
> static inline int is_rd_overutilized(struct root_domain *rd) { return 0; }

ok. 

> 
>>  #endif
>>
>>  /* Runqueue only has SCHED_IDLE tasks enqueued */
>> @@ -7974,7 +7984,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>
>>         rcu_read_lock();

>>

