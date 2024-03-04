Return-Path: <linux-kernel+bounces-90776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A78D8704CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0CE1C21D96
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897F46548;
	Mon,  4 Mar 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qnlTj/Zo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433353FB02
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564753; cv=none; b=Bz+3exhLCyVDe2xpT1sRNWYF7cBKr4Wt5l0TqbKRCvcfze+0Xs1FEEQjpd5M3tBZC2Le//Hf4k8gxAs6GoqiIWwndd7W2VBDZpzC/1y0p9hK7jOhhHt0gJ8d8im5OEjUFqhxPAxMU7X5rEdSOw5bQwHq3at83yJHyyvVvpSYzBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564753; c=relaxed/simple;
	bh=SLGqesSWItVJZQlYxLYtvek+3bJ1IS4thJEzT0yKQ8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ALHMH9I+OP5015EqXUb8/f0iUG4Flt9nW1Jx7L21gdjXMcXlnmfv+zMoMw2slbH/a8RmgCTXTeZEmLjqbGSLCGl1y+GC1WR5saxc1UI1WkDGWXN28/KnC1jpIsUA7hJom1XAI8ca7pEAP7TAQ9iL/0rnqZu/HZ65uNs4PnF17Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qnlTj/Zo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424F3HiS000695;
	Mon, 4 Mar 2024 15:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SVkCf0mk998qypkF1bYWrQmV7cb8GywUK9ieQlzdD50=;
 b=qnlTj/Zo7/SEV1FzslrIlz1ECjZawQH8GeREloZP78QxNjqWrlTNy5FyboUZfS0BjhJz
 J6SJmyZADqwrWs2YkwsZkd7MngEdTcog1rRRxiVbaiZ4lLohJWrqv7T6gxBuJNzHuyPL
 6QULNI3UK7ewC+J6wkiXtMZahvQmjZA8Cl46ucdqYU3HNcWjosD0nRuff8FGcDv83aCs
 QWtpjuh+DaAJ4iGU633E2Br92jxnOepv5/DJ6rjwTyG0MuQYk+VFQL3cIXRhtJIuwOwK
 GQBsBom7Q+Y8alG+WDkqLrMjShlq4yrKNU34+PrUDmZ4+QO9gWEyMnjXCsybcmrEd6gk nA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wngksg25s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 15:05:36 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 424F4dFx008422;
	Mon, 4 Mar 2024 15:05:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wngksg255-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 15:05:36 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 424F5Xxd025376;
	Mon, 4 Mar 2024 15:05:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmety9dxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 15:05:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 424F5WYr31523306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Mar 2024 15:05:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E358B5806A;
	Mon,  4 Mar 2024 15:05:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57A4958053;
	Mon,  4 Mar 2024 15:05:28 +0000 (GMT)
Received: from [9.43.1.27] (unknown [9.43.1.27])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Mar 2024 15:05:28 +0000 (GMT)
Message-ID: <aa13842e-ab81-45e0-87d4-2b5360ff4782@linux.ibm.com>
Date: Mon, 4 Mar 2024 20:35:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] sched/balancing: Remove reliance on 'enum
 cpu_idle_type' ordering when iterating [CPU_MAX_IDLE_TYPES] arrays in
 show_schedstat()
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-3-mingo@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240304094831.3639338-3-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YzxPoT2MH6e_9rY-oUW6sY3Bux7VmXna
X-Proofpoint-GUID: 1kh1SnAK-p_CYPXb3DD36UoyIoRSNxnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_10,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040114



On 3/4/24 3:18 PM, Ingo Molnar wrote:
> From: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> Shrikanth Hegde reported that show_schedstat() output broke when
> the ordering of the definitions in 'enum cpu_idle_type' is changed,
> because show_schedstat() assumed that 'CPU_IDLE' is 0.
>
Hi Ingo. 
Feel free to drop me from the changelog. 

> @@ -150,8 +150,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
>  
>  			seq_printf(seq, "domain%d %*pb", dcount++,
>  				   cpumask_pr_args(sched_domain_span(sd)));
> -			for (itype = CPU_IDLE; itype < CPU_MAX_IDLE_TYPES;
> -					itype++) {
> +			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {


It would still not be same order as current documentation of schedstat. no? The documentation 
would need changes too. Change SCHEDSTAT_VERSION to 16? 

 
Current documentation says this. 
--------------------
The next 24 are a variety of load_balance() statistics in grouped into types
of idleness (idle, busy, and newly idle):

Above code will do. 
(busy, idle and newly idle)


--------------------
Verified with the v3 patch as well using the previous method. 
Before patch:
cpu0 0 0 4400 1485 1624 1229 301472313236 120382198 7714    
				   [-------- idle --------][-----------busy--------][-------new-idle--]                    
domain0 00000000,00000000,00000055 1661 1661 0 0 0 0 0 1661 2495 2495 0 0 0 0 0 2495 67 66 1 2 0 0 0 66 0 0 0 0 0 0 0 0 0 133 38 0
domain1 ff000000,00ff0000,ffffffff 382 369 13 13 4 0 2 207 198 195 3 36 0 0 0 195 67 64 3 3 0 0 0 64 4 0 4 0 0 0 0 0 0 124 9 0
domain2 ff00ffff,00ffffff,ffffffff 586 585 1 6 0 0 0 365 118 116 2 96 0 0 0 116 67 67 0 0 0 0 0 67 0 0 0 0 0 0 0 0 0 59 0 0
domain3 ffffffff,ffffffff,ffffffff 481 479 2 58 0 0 0 387 97 97 0 0 0 0 0 96 67 67 0 0 0 0 0 67 0 0 0 0 0 0 0 0 0 79 0 0

After patch:
cpu0 0 0 3924 728 1940 1540 302019558490 425784368 8793
				   [-------- busy ----------][-----------idle--------][-------new-idle--]   
domain0 00000000,00000000,00000055 2494 2489 3 37 2 0 0 2489 1691 1691 0 0 0 0 0 1691 21 19 0 2 2 0 0 19 0 0 0 0 0 0 0 0 0 89 2 0
domain1 ff000000,00ff0000,ffffffff 196 193 3 44 0 0 0 193 411 400 10 2060 4 1 4 260 19 16 3 1028 0 0 0 16 3 0 3 0 0 0 0 0 0 59 2 0
domain2 ff00ffff,00ffffff,ffffffff 116 116 0 0 0 0 0 116 590 588 2 3 0 0 0 447 19 18 1 2 0 0 0 18 0 0 0 0 0 0 0 0 0 192 0 0
domain3 ffffffff,ffffffff,ffffffff 97 97 0 0 0 0 0 96 457 457 0 0 0 0 0 427 19 18 1 27 0 0 0 18 0 0 0 0 0 0 0 0 0 60 0 0



>  				seq_printf(seq, " %u %u %u %u %u %u %u %u",
>  				    sd->lb_count[itype],
>  				    sd->lb_balanced[itype],

