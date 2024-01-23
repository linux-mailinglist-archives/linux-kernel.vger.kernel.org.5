Return-Path: <linux-kernel+bounces-35256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75375838EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D6F28899D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFCF5EE66;
	Tue, 23 Jan 2024 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="etnJEnIm"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D2B482D3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706013767; cv=none; b=WLjidx2TFpX+0nDlujdC6o2YWNCwNDm8fRPiBvnKw6QdsvTlvLVjwCAwrkQaSIEk2WfdbPuwbVkqmlt+4jFWDltzsVTY0DNJrOnNAvX/nl/+FPm/osYnbQ3ZYtO+qdBDW4FGbkk0O9viiSOVhENoARIlC5816Q3F3FewIbGkwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706013767; c=relaxed/simple;
	bh=DQcb96syt8jqVys5hAvA2hSzjfV0RvY2zq7ivCsvwOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u8NQ4SVWc7uh1u2yrTA4nSK4rVHdo4NfHvvv6EiBIo9DJUJoWYpZ+FD92utH6s0nKDQoO3CbZAG6GjwuTdeqWPmEa2iNX056muv2FMZ08NXT3XSg2XxXj0tDKhcqPHOpujB/3SnaZBHyEjDjOIy7zhq8ZQcFUAvWdAHNoRE36F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=etnJEnIm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NAqltQ015393;
	Tue, 23 Jan 2024 12:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=QlSMSbBF/pOJ8fzj2CyybcmVIJvWE2Ya99r2/G/MXdE=;
 b=etnJEnIm6HU3lns9jRxAfqko83aT1FeIlRGwhlZIzCItajM7PhybSX/YOcCkEkxTgccn
 F2w60AlngLvJ53KvfTlso3Die7VQNp+fxtBXzgD5sN+V1L2XQ19OAmkclnhTJv2/YHMm
 ootGWNW4N19kIwsZug7UClk4dmTtVh8iODMpn2aPm5uJMn9KTY9v3nL5NUGitmGAByAN
 pV2ldXa1fuCD2Id9xkmHdKhh8ExzXvA+QX/lWHfBYncqexbNEAj2grcegW0uyf69YHVb
 /3h9d3aSUBH0w6eqnwosOsVh9OyGQfnWgK1c7DZideWh+SQOjKrz7FiZSJ0OJQxOSCLi rw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtc37t77e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 12:42:13 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40NCfReh013304;
	Tue, 23 Jan 2024 12:42:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtc37t762-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 12:42:12 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40N9Sewh022510;
	Tue, 23 Jan 2024 12:42:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0kxyw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 12:42:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40NCg9Ix8979020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 12:42:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BBDF2004B;
	Tue, 23 Jan 2024 12:42:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DDE420043;
	Tue, 23 Jan 2024 12:42:06 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.204.201.194])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jan 2024 12:42:06 +0000 (GMT)
Date: Tue, 23 Jan 2024 18:12:04 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Ze Gao <zegao2021@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: Re: [RFC PATCH] sched/eevdf: Use tunable knob
 sysctl_sched_base_slice as explicit time quanta
Message-ID: <Za-0HCP7WG3PIe7h@linux.ibm.com>
References: <20240111115745.62813-2-zegao@tencent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111115745.62813-2-zegao@tencent.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GlIrp6sOXUduV1fE0bG9rf8n-mgY9EIn
X-Proofpoint-ORIG-GUID: Anpz5YX1uUnuxaF6mDinBNS0kb6sqHnf
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_06,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=72 priorityscore=1501
 spamscore=72 clxscore=1011 impostorscore=0 bulkscore=0 malwarescore=0
 mlxscore=72 adultscore=0 suspectscore=0 mlxlogscore=-41 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230094

On Thu, Jan 11, 2024 at 06:57:46AM -0500, Ze Gao wrote:
> AFAIS, We've overlooked what role of the concept of time quanta plays
> in EEVDF. According to Theorem 1 in [1], we have
> 
> 	-r_max < log_k(t) < max(r_max, q)
> 
> cleary we don't want either r_max (the maximum user request) or q (time
> quanta) to be too much big.
> 
> To trade for throughput, in [2] it chooses to do tick preemtion at
> per request boundary (i.e., once a cetain request is fulfilled), which
> means we literally have no concept of time quanta defined anymore.
> Obviously this is no problem if we make
> 
> 	q = r_i = sysctl_sched_base_slice
> 
> just as exactly what we have for now, which actually creates a implict
> quanta for us and works well.
> 
> However, with custom slice being possible, the lag bound is subject
> only to the distribution of users requested slices given the fact no
> time quantum is available now and we would pay the cost of losing
> many scheduling opportunities to maintain fairness and responsiveness
> due to [2]. What's worse, we may suffer unexpected unfairness and
> lantecy.
> 
> For example, take two cpu bound processes with the same weight and bind
> them to the same cpu, and let process A request for 100ms whereas B
> request for 0.1ms each time (with HZ=1000, sysctl_sched_base_slice=3ms,
> nr_cpu=42).  And we can clearly see that playing with custom slice can
> actually incur unfair cpu bandwidth allocation (10706 whose request
> length is 0.1ms gets more cpu time as well as better latency compared to
> 10705. Note you might see the other way around in different machines but
> the allocation inaccuracy retains, and even top can show you the
> noticeble difference in terms of cpu util by per second reporting), which
> is obviously not what we want because that would mess up the nice system
> and fairness would not hold.

Hi, How are you setting custom request values for process A and B?

> 
> 			stress-ng-cpu:10705	stress-ng-cpu:10706
> ---------------------------------------------------------------------
> Slices(ms)		100			0.1
> Runtime(ms)		4934.206		5025.048
> Switches		58			67
> Average delay(ms)	87.074			73.863
> Maximum delay(ms)	101.998			101.010
> 
> In contrast, using sysctl_sched_base_slice as the size of a 'quantum'
> in this patch gives us a better control of the allocation accuracy and
> the avg latency:
> 
> 			stress-ng-cpu:10584	stress-ng-cpu:10583
> ---------------------------------------------------------------------
> Slices(ms)		100			0.1
> Runtime(ms)		4980.309		4981.356
> Switches		1253			1254
> Average delay(ms)	3.990			3.990
> Maximum delay(ms)	5.001			4.014
> 
> Furthmore, with sysctl_sched_base_slice = 10ms, we might benefit from
> less switches at the cost of worse delay:
> 
> 			stress-ng-cpu:11208	stress-ng-cpu:11207
> ---------------------------------------------------------------------
> Slices(ms)		100			0.1
> Runtime(ms)		4983.722		4977.035
> Switches		456			456
> Average delay(ms)	10.963			10.939
> Maximum delay(ms)	19.002			21.001
> 
> By being able to tune sysctl_sched_base_slice knob, we can achieve
> the goal to strike a good balance between throughput and latency by
> adjusting the frequency of context switches, and the conclusions are
> much close to what's covered in [1] with the explicit definition of
> a time quantum. And it aslo gives more freedom to choose the eligible
> request length range(either through nice value or raw value)
> without worrying about overscheduling or underscheduling too much.
> 
> Note this change should introduce no obvious regression because all
> processes have the same request length as sysctl_sched_base_slice as
> in the status quo. And the result of benchmarks proves this as well.
> 
> schbench -m2 -F128 -n10	-r90	w/patch	tip/6.7-rc7
> Wakeup  (usec): 99.0th:		3028	95
> Request (usec): 99.0th:		14992	21984
> RPS    (count): 50.0th:		5864	5848
> 
> hackbench -s 512 -l 200 -f 25 -P	w/patch	 tip/6.7-rc7
> -g 10 					0.212	0.223
> -g 20					0.415	0.432
> -g 30				 	0.625	0.639
> -g 40					0.852	0.858
> 
> [1]: https://dl.acm.org/doi/10.5555/890606
> [2]: https://lore.kernel.org/all/20230420150537.GC4253@hirez.programming.kicks-ass.net/T/#u
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---


