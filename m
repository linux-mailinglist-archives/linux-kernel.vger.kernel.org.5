Return-Path: <linux-kernel+bounces-34934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9AB83896B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAE81C254C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542985731C;
	Tue, 23 Jan 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z0xuabPq"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB805676A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999641; cv=none; b=Zqz9Wol5RlZxbJaHjlZzhg+sueCQ7S+dzSnzD6uFXdzg2nARZVeHFpQUPrLMeoel7i1GHoek3SUfs/spnLn6c65r4BiWOUTbtxkNButmMp5oaiB2N8blk6V29KQY9n8+Jo+MjLFUVRDHXE1Yxs6hjbknWFNZGSmdB24p3eWFC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999641; c=relaxed/simple;
	bh=wYJTtEJyiZar0bqQOEABOnzDbmzTtEQ88RxA6ggTMhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=VwiXBdXRQnr05Tz7HrdLkuKUmTqxEKHSH0k4tYcRp1wAbBv/g0A0f4HK3biQFc3Cc0zadN/gx+8eKUBxaf08tUK1t1C4Wg0pU9SS69K0uh/WpgdYVMpfBjvTQ74dpQCWYxspD//P8Ns8BLwAd5T8RhsnxVKq8X4Wuu8LTncC2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z0xuabPq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N8afwI032542;
	Tue, 23 Jan 2024 08:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : cc : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4gKJHVKIh8z0zP3yNXEdoGXm/qHNRGRq48lNu8mkjvg=;
 b=Z0xuabPqcXppFYrWPpc7xGTkq6DBLjQI/CEMzDfr0qOv50RjFKnC9uRdmdTRkVgb9RLk
 Dt4wJh15VzGjxhlpFX/gtWiudwG/2mnEq9o5qNmR4DYnLdNIJV/CRHIa1lq96WTFmy+X
 WlcDhOabojZ5Gcjqy162E69U18x0RjO/Lgmz3BZW7r2chlQiaozvID3DRChq5NOjaQPw
 jggBEOmcC7mPF7Qt9SGgorsr1SmsJ+4qR7+djN9ur9yFOnhzGwoa54yzs8Wf46z8I4qg
 +xf/sDRXwjUnT3UackIM3WwuGcne5kW81m7B4tAgPUdOVPP1NkIyxcdWBadTVwpwAwc3 +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vt9r8rn7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 08:47:08 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40N8cIHI009013;
	Tue, 23 Jan 2024 08:47:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vt9r8rn7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 08:47:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40N70B0K025272;
	Tue, 23 Jan 2024 08:47:06 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqk5q9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 08:47:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40N8l6qd13959762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 08:47:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26E0558065;
	Tue, 23 Jan 2024 08:47:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 154EC58055;
	Tue, 23 Jan 2024 08:47:02 +0000 (GMT)
Received: from [9.109.201.126] (unknown [9.109.201.126])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jan 2024 08:47:01 +0000 (GMT)
Message-ID: <dd4e5498-3e21-4ac1-b65a-fd132c2a7206@linux.ibm.com>
Date: Tue, 23 Jan 2024 14:17:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] sched/fair: narrow the sched_use_asym_prio checking
 scenario
To: alexs@kernel.org
References: <20240117085715.2614671-1-alexs@kernel.org>
 <20240117085715.2614671-5-alexs@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240117085715.2614671-5-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OhiTHFHVAyhChIW2-bMz9wZKXeVfR9g0
X-Proofpoint-ORIG-GUID: B2MR8yq5blMp-7U5yJazRhndCCt9oX_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_03,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230062



On 1/17/24 2:27 PM, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> Current function doesn't match it's comments, in fact, core_idle
> checking is only meaningful with non-SMT.
> So make the function right.
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 96163ab69ae0..0a321f639c79 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9741,8 +9741,8 @@ group_type group_classify(unsigned int imbalance_pct,
>   */
>  static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  {
> -	return (!sched_smt_active()) ||
> -		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
> +	return	(sd->flags & SD_SHARE_CPUCAPACITY) ||
> +		(!sched_smt_active() && is_core_idle(cpu));
>  }

This seems wrong. This would always return false for higher than SMT domains 
if smt is active. 

Was this meant to be sched_smt_active() && is_core_idle(cpu)? 

>  
>  static inline bool _sched_asym(struct sched_domain *sd,

