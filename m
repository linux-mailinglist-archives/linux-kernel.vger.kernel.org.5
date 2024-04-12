Return-Path: <linux-kernel+bounces-143103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF538A343C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7AF1F22FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EFD14C5BF;
	Fri, 12 Apr 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L/sLXm7Q"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5D314BF8B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941208; cv=none; b=hX70EKT8TKhF3xSxIN3Ztf+BNe06Ai8qaj3WWTjHB1R50gEDc9N2N9mAx0Jt5usV25zpMnrtTBmWVMA+L1rrMoKDeZHAY1N9jf10N2IUZ1q39VI8AyIUWqWYsudpxVfAeWxUPKPDPFbMTilucciEdic8jeNVN2/5RpirNHS8lg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941208; c=relaxed/simple;
	bh=nlm/PlL7S0d86mipB9qgwefzeZzjCi8t2bhdskjNnOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAEx9pEAemzN5RoFekakngQINVyP7nIqAKSUpgwOFUcdaSGPAGgQwCNsp90YCRatQN/AT3FyW2v5XfUhYxcwOO6ITWPHXA1fZqO+RcrgF1HHxas+fAkcaPWL1sN5uyoRwyD0QF1RK/0kZW9dISJb4RgNb3ALytgOCBhnsrh+7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L/sLXm7Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CGv9vC019167;
	Fri, 12 Apr 2024 16:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : reply-to : from :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=5XL2E6x0dqCo3xg8bJjmVErWdlQ1QDlpDbOFaY04e+c=;
 b=L/sLXm7Qvh1DVU4KeiufxOITRxXcpsnpzJAbiCofsdIXQZI12ILXuRXq8LNAoRv4Fnbi
 qArQJ91zBDI4bzNll8M05RZuiZjr2SHWXvx2utNEqSgE+TbN2mOXR6zB8EVmkF3sk5zf
 ZsYdbMZOHyXeWoo15J39CU89PSNENiIpJtkLpk+q6zHGMW1MsBsg87nnFZBWQVczVTmx
 BjtWFr8WO/LwYsb+7LD68A+gOPHMTOhlhKx7sCUgQRLLUKm5zsQvFeecxrEF7Ux1VkwI
 WR6/WfEFMWJy9u+8aZ1Nxj8qs9D52/waHRNiZwLoM3J7luZYjmA96ELKE3SYNKS000V+ FA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf74yr91c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:59:33 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43CGxWMW024219;
	Fri, 12 Apr 2024 16:59:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf74yr914-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:59:32 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43CEoNkv029907;
	Fri, 12 Apr 2024 16:59:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbj7mtx0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 16:59:30 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43CGxRtK26084080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 16:59:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D974C5806C;
	Fri, 12 Apr 2024 16:59:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92DB758062;
	Fri, 12 Apr 2024 16:59:20 +0000 (GMT)
Received: from [9.43.52.155] (unknown [9.43.52.155])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Apr 2024 16:59:20 +0000 (GMT)
Message-ID: <65b1691d-8d90-4057-8ad0-da546a0ac8a1@linux.ibm.com>
Date: Fri, 12 Apr 2024 22:29:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Improve rq selection for a blocked task when its
 affinity changes
To: Ze Gao <zegao2021@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240313085817.48892-1-zegao@tencent.com>
Content-Language: en-US
Reply-To: 20240313085817.48892-1-zegao@tencent.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240313085817.48892-1-zegao@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u7TN5oyhrxA3pBw5t-mFwbZefT3J2lTS
X-Proofpoint-GUID: Wh5Mt0rqumQ8sWWFEi8SBZ9KZ1vkHbGc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_13,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 adultscore=0 priorityscore=1501
 mlxlogscore=616 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120124

Hi Ze Gao,

On 13/03/24 14:28, Ze Gao wrote:
> We observered select_idle_sibling() is likely to return the *target* cpu
> early which is likely to be the previous cpu this task is running on even
> when it's actually not within the affinity list newly set, from where after
> we can only rely on select_fallback_rq() to choose one for us at its will
> (the first valid mostly for now).
> 
> However, the one chosen by select_fallback_rq() is highly likely not a
> good enough candidate, sometimes it has to rely on load balancer to kick
> in to place itself to a better cpu, which adds one or more unnecessary
> migrations in no doubt. For example, this is what I get when I move task
> 3964 to cpu 23-24 where cpu 23 has a cpu bound work pinned already:
> 
>         swapper       0 [013]   959.791829: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=13 dest_cpu=23
> kworker/24:2-mm    1014 [024]   959.806148: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=23 dest_cpu=24
> 

I am able to reproduce this scenario of having an extra migration through load balance
swapper       0 [031] 398764.057232: sched:sched_migrate_task: comm=loop pid=178687 prio=120 orig_cpu=31 dest_cpu=33
ksoftirqd/0  13 [000] 398764.356138: sched:sched_migrate_task: comm=loop pid=178687 prio=120 orig_cpu=33 dest_cpu=34

I wrote a simple c program that blocks for few seconds, meanwhile I taskset it to CPUs 33,34 while I already have a
busy task running on CPU 33.

> The thing is we can actually do better if we do checks early and take more
> advantages of the *target* in select_idle_sibling(). That is, we continue
> the idle cpu selection if *target* fails the test of cpumask_test_cpu(
> *target*, p->cpus_ptr). By doing so, we are likely to pick a good candidate,
> especially when the newly allowed cpu set shares some cpu resources with
> *target*.
> 
> And with this change, we clearly see the improvement when I move task 3964
> to cpu 25-26 where cpu 25 has a cpu bound work pinned already.
> 
>         swapper       0 [027]  4249.204658: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=27 dest_cpu=26

But after applying this patch, The extra migration is still happening as CPU 33 is still chosen by try_to_wake_up.

On placing some perf probes and testing,
    migration/57     304 [057] 12216.988491:       sched:sched_migrate_task: comm=loop pid=11172 prio=120 orig_cpu=57 dest_cpu=4
         swapper       0 [004] 12226.989065: probe:select_idle_sibling_L124: (c0000000001bafc0) i=-1 recent_used_cpu=-1 prev_aff=-1
         swapper       0 [004] 12226.989071:       probe:select_fallback_rq: (c0000000001a2e38) cpu=4
         swapper       0 [004] 12226.989074:       sched:sched_migrate_task: comm=loop pid=11172 prio=120 orig_cpu=4 dest_cpu=33
         swapper       0 [000] 12227.007768:       sched:sched_migrate_task: comm=loop pid=11172 prio=120 orig_cpu=33 dest_cpu=34

It is observed that, select_fallback_rq is still taken in this scenario as default target is returned at the end of select_idle_sibling
which was CPU 4.

In most of my testing, default target is returned at the end of the function due to the initial checks. It's possible that there would
be cases where we can get optimal CPU before we reach end of the select_idle_sibling function but it would be interesting to know if the
extra time spent in finding an optimal cpu have an impact instead of returning it earlier if in most of the times we are returning the
default target at the end. 

Thanks and Regards
Madadi Vineeth Reddy

> 
> Note we do the same check for *prev* in select_idle_sibling() as well.
> 
> Signed-off-by: Ze Gao <zegao@tencent.com>
> ---


