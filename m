Return-Path: <linux-kernel+bounces-88628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F8286E47F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47BD4B2432F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED4E70CAE;
	Fri,  1 Mar 2024 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mBcJPww9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE796BFA0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307339; cv=none; b=MlWa74QHNy/dT0NhpCMsQusYHLwL+zK3OmT+EqkoHjz5cg8lefBi8n8pWH6ia7xiRntQhG0yOkro/mkqD7zCJweYgz0Pg3pBVbvbe0XvqMTE7rdduohuSBKF7tEEumn1Ea65MVL8ow6NU/rxz3sqqdnVsUjsWKQn/fJHDUMNXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307339; c=relaxed/simple;
	bh=9axGj7bssCMt/pTo6jk4CoQ/Dc+4FugBqYlEE0EkPEg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AZ9LJeDeHaj7Xhek1qvPSh3a/PLaWPhMKdqmRZPJMal0Jt3gPSnvNW1jJ0ScXx9kkVChFmILSUSuybaTcZUNl0r9AxHHIyF0ZaYRJ7q3L1JuEIsJFprJej9zaJEI2g6jRceIZaXJf4rVTvlSe8fg6EHjf+UGQYG8RuCpMBnqbV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mBcJPww9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421F6FWW020348;
	Fri, 1 Mar 2024 15:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=DuwfaYUgwN8+v0yPaldvlZPQ08K9YZMF/hqSJTIJZbk=;
 b=mBcJPww9XXYLOrFOzo++Zm8VaOGHlKXZ6mWKauY6NrTgSx/7gjGGXYXijXt56Pp9+I/Z
 rAwjRZ9ypyuctyc2WPru+ziaUF9btLU/MZooSXMyXryv3Ld0cZOY9K556KGAURKMnkqa
 7ktRyZhn4sPngHuCS7xEE8aD2ByBO9Fdu+HUEuOUgYxm/rnr7XGZPeq8nTqtB28a764U
 LHBamNppE5/p0ipQYdMR2fdkohW/752SY/ZVnJzBBBRrxqzWISYma6QhOkXKNRhSy+2/
 ljy+/i3rEwzPErffLsvGKPYCciYXYOlm2NR90NsyqC/DLnud60VUQZcEbKcrQhiWYFi/ nw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkh7v13vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 15:35:11 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 421FJYxZ029410;
	Fri, 1 Mar 2024 15:35:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkh7v13ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 15:35:10 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 421DqhUG012324;
	Fri, 1 Mar 2024 15:35:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg2vsgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 15:35:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 421FZ7sx41288010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 15:35:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35D6958061;
	Fri,  1 Mar 2024 15:35:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 448AC58068;
	Fri,  1 Mar 2024 15:35:04 +0000 (GMT)
Received: from [9.43.59.36] (unknown [9.43.59.36])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 15:35:03 +0000 (GMT)
Message-ID: <703aad5f-40ce-4b37-bd5d-4a85615085e4@linux.ibm.com>
Date: Fri, 1 Mar 2024 21:05:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] sched/balancing: Switch the
 'DEFINE_SPINLOCK(balancing)' spinlock into an 'atomic_t
 sched_balance_running' flag
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20240301110951.3707367-1-mingo@kernel.org>
 <20240301110951.3707367-2-mingo@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240301110951.3707367-2-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _6QaWMMlsIR-KJ6SQtkoxDX_75FXiC5b
X-Proofpoint-ORIG-GUID: iI-mhrJtOD3w5KAJ_Q9nCWruUGndZcMw
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_14,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 mlxlogscore=707 adultscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010129



On 3/1/24 4:39 PM, Ingo Molnar wrote:
> The 'balancing' spinlock added in:

Hi Ingo. 

> 
>   08c183f31bdb ("[PATCH] sched: add option to serialize load balancing")
>

 
[...]

>  
>  		need_serialize = sd->flags & SD_SERIALIZE;
>  		if (need_serialize) {
> -			if (!spin_trylock(&balancing))
> +			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))

Thinking from very little I know, I may be completely wrong. 

Is it possible that arch_spin_trylock, which would be called from spin_trylock is 
faster in some architectures? Maybe in contended case? 

For example, in powerpc, queued_spin_trylock, uses more optimal ll/sc style access patterns 
rather than cmpxchg. 
https://lore.kernel.org/all/20221126095932.1234527-4-npiggin@gmail.com/

+nick 


>  				goto out;
>  		}
>  
> @@ -11729,7 +11742,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
>  			interval = get_sd_balance_interval(sd, busy);
>  		}
>  		if (need_serialize)
> -			spin_unlock(&balancing);
> +			atomic_set_release(&sched_balance_running, 0);
>  out:
>  		if (time_after(next_balance, sd->last_balance + interval)) {
>  			next_balance = sd->last_balance + interval;

