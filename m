Return-Path: <linux-kernel+bounces-116465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6223889F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D981C33E86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F652F6F;
	Mon, 25 Mar 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RtSmV9og"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0842C1292C4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711343547; cv=none; b=n05JkIxIRrv7dK9EFel6kTQ9hcYoeBzKru2RLz/5szculwTxi36JT0c7WbwwUDFtIQjdHeoGIkkPdTLNr3XsKPlMpCL3+2ZBDf23cAarHUPp98VUhjwOuVArV/N1ZeZdT9+qeIbl/F/YlMBYB9G8HNJbKuRmio7SOd6V/CpSzhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711343547; c=relaxed/simple;
	bh=vNoEyKnp0XNLjr8zfpvmBh18zHPMtXvwf6EdNq+m0Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFWrVXHEp4gs/V9yBrIU6Uqb4R5UefXkqVIhKOizcdUXhKh9lKivwy+PMpsKdY/pdVVUSiM4HlxILhOR+J54Eh+zeHYvmpcMoPpeaG+O8x9G2fyhU2nH/VrnfnRK/l1qrxihbnkZ7dpucI5Xo8SG8W0KU1VW3TlXNkDjbyWvi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RtSmV9og; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42P4x8C4014876;
	Mon, 25 Mar 2024 05:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sy1iP2H7Z6mMOmvoxKSAWOB06oq7j8GbeRiGtH9T2Zw=;
 b=RtSmV9ognkyJm/vll7hI78vccArMZ0Qk0xW7kgYZcZO7vkwqZPq0+KrVkW1jEP1re9TG
 DvPOosbrG1lb8TGwog/vDI+XChwE5jsKFmCnngJVyupYFqJSkTDy06olNStcTdVImN8s
 6qgaGwLhJLB56DKrWSD3QeUECwboQBKvZraI2+Led965thtSdDdeptBRFtWXgl9sr0ch
 bGjgt1f9jCOKT7lgo1qae7h5rYHuCqwXYRRI/k9miy2FMGHj0noLa8sIiK0tx1rMrQ4+
 RiZzm+r8G0haGpIt85SU03NGyc3a4W5Dak3mAFTNEYbK0YQW8kaVw8mgUlRq/p5ciGL8 vw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2vxr0g16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:12:13 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42P5CDwN003802;
	Mon, 25 Mar 2024 05:12:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2vxr0g12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:12:13 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42P4WWCI016409;
	Mon, 25 Mar 2024 05:12:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dtq89d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 05:12:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42P5C9nr24904246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 05:12:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 848E458056;
	Mon, 25 Mar 2024 05:12:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DC5B58052;
	Mon, 25 Mar 2024 05:12:07 +0000 (GMT)
Received: from [9.124.31.56] (unknown [9.124.31.56])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Mar 2024 05:12:06 +0000 (GMT)
Message-ID: <59224c52-1864-4920-8bac-9da308d257db@linux.ibm.com>
Date: Mon, 25 Mar 2024 10:42:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sched/fair: Use helper functions to access
 rd->overload
To: Qais Yousef <qyousef@layalina.io>
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        vschneid@redhat.com, qperret@google.com
References: <20240322141632.28654-1-sshegde@linux.ibm.com>
 <20240322141632.28654-3-sshegde@linux.ibm.com>
 <20240324011620.f3mmywh44htvlb5m@airbuntu>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240324011620.f3mmywh44htvlb5m@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FKqsdZJVIGDZrd7MNagkz52Fii323nvt
X-Proofpoint-GUID: eJ9BfbFP_vdRx9wKz1EleH_Up7cgWi7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=780 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250027



On 3/24/24 6:46 AM, Qais Yousef wrote:
> On 03/22/24 19:46, Shrikanth Hegde wrote:

>>
>>  	if (!env->sd->parent) {
>>  		/* update overload indicator if we are at root domain */
>> -		if (READ_ONCE(env->dst_rq->rd->overload) != (sg_status & SG_OVERLOAD))
>> -			WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
>> +		if (is_rd_overloaded(env->dst_rq->rd) != (sg_status & SG_OVERLOAD))
>> +			set_rd_overload_status(env->dst_rq->rd,
>> +					       sg_status & SG_OVERLOAD);
> 
> A bit picky, but..
> 
> Wouldn't it be better to encapsulate the check of whether we're writing a new
> value inside set_rd_overload_status()? Only write if it the value changed and
> all future users wouldn't care then.
> 
> I think no need to wrap the line too.
> 

Yes. Makes sense all the places do the check and update, can be wrapped. 
I will send out v3.  

>>
>>  		/* Update over-utilization (tipping point, U >= 0) indicator */
>>  		set_rd_overutilized_status(env->dst_rq->rd,
>> @@ -12344,7 +12345,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
>>  	rcu_read_lock();
>>  	sd = rcu_dereference_check_sched_domain(this_rq->sd);
>>
>> -	if (!READ_ONCE(this_rq->rd->overload) ||
>> +	if (!is_rd_overloaded(this_rq->rd) ||
>>  	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>>
>>  		if (sd)
>> @@ -2518,8 +2528,8 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
>>
>>  #ifdef CONFIG_SMP
>>  	if (prev_nr < 2 && rq->nr_running >= 2) {
>> -		if (!READ_ONCE(rq->rd->overload))
>> -			WRITE_ONCE(rq->rd->overload, 1);
>> +		if (!is_rd_overloaded(rq->rd))
>> +			set_rd_overload_status(rq->rd, 1);
> 
> While at it, could you write SG_OVERLOAD instead of 1? 
Done.  
> 
> Both patches LGTM otherwise
> 
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> 
> 



