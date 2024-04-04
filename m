Return-Path: <linux-kernel+bounces-131863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51E5898CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6499BB2949B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B517612BF02;
	Thu,  4 Apr 2024 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jjCgXMSo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609AC12AAE7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249980; cv=none; b=dR1Fx83F64fsEGjJQNYftuPhXiDvgZLJDLPI38Bp9yhhQLCUQflSYuEFESqMOaUSwNzh1YmC1EnUBs7CUqKfrCIr2fPkBRPVETiaXKZzAsbB7TVVfYy1Typ550p916DWzziva/YrMEBFhidqyvfZ83xI/fVgXBoFcI9mYMJLUkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249980; c=relaxed/simple;
	bh=GlIb1zMcmJBClF5rkpKIcHRkG94ygBl89eq+SVxh8p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=hKzJiAqmjXQAGKxS1+20Hy76tMqeWyDMg1a1/aQkv1q2Rsi6HfxHnzteny6Roje3HCu7kmA3zrUo9mThu8V408smaxZnnPEw0J+ff6Nx/giq9WT6KDk4waMvTuWL6HCf1hrvsp5phIt50NOeD2Gmpzy/X4F/P1+/0uRnzDqYj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jjCgXMSo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 434GA783019225;
	Thu, 4 Apr 2024 16:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : cc : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nw6gfRmvKmSjH//Zggr7B2O5ZxWfQkhxAmZHffHFRyI=;
 b=jjCgXMSol7RMTHgxgmxGCapA8pT1uG6d2UfiRK6lhBIIiv6twSgJB0l0v4e4LL+F5bDQ
 ecV3VhyfK9DU/YOruTBBTpgJwviCbCV2lRZ0+Nz4+rMxoltuFH5j36wmk30cdanIgE00
 s0cRm/ZKa8v2vIxFQhzULvhXiwtPTfq2G2+chbXpRxugtQd2ui5hD+v/ELcaezE5BnUr
 evN/wAET2PISaDvjckEl9u8zG3Fj39iPaa2TS9rV9y/hjKedi4hZA11jzWwZCEvpurGt
 0ELgfe9XAk4qFzO4lVFS5Ye3bB8Fhl1qYi5Tn7aMhcflRIwEd0EIXNo6m+GvMEfk/bvb jw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9yfr03q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 16:59:24 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 434GxNi4029746;
	Thu, 4 Apr 2024 16:59:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9yfr03q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 16:59:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 434GY98E009092;
	Thu, 4 Apr 2024 16:59:22 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x9epxwc8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 16:59:22 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 434GxKVq2949742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Apr 2024 16:59:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FDEC5806E;
	Thu,  4 Apr 2024 16:59:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38D0458058;
	Thu,  4 Apr 2024 16:59:17 +0000 (GMT)
Received: from [9.195.45.28] (unknown [9.195.45.28])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Apr 2024 16:59:16 +0000 (GMT)
Message-ID: <79632baa-746b-4da9-b73c-432f7a8d166a@linux.ibm.com>
Date: Thu, 4 Apr 2024 22:29:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Fix update of rd->sg_overutilized
To: Vincent Guittot <vincent.guittot@linaro.org>
References: <20240404155738.2866102-1-vincent.guittot@linaro.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20240404155738.2866102-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wQBNZjYr9GAU0K3ZdwX6Jc7i9hIHOPc2
X-Proofpoint-GUID: vnjLPUvgi55mJ0N_FKD1S6GfqZftPlCI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_13,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=891 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404040119



On 4/4/24 9:27 PM, Vincent Guittot wrote:
> sg_overloaded is used instead of sg_overutilized to update
> rd->sg_overutilized.

Yes. Good find. I missed to notice this as well.

> 
> Fixes: 4475cd8bfd9b ("sched/balancing: Simplify the sg_status bitmask and use separate ->overloaded and ->overutilized flags")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1dd37168da50..bb1ae4ed0d91 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10661,7 +10661,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		set_rd_overloaded(env->dst_rq->rd, sg_overloaded);
>  
>  		/* Update over-utilization (tipping point, U >= 0) indicator */
> -		set_rd_overutilized(env->dst_rq->rd, sg_overloaded);
> +		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
>  	} else if (sg_overutilized) {
>  		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
>  	}

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

