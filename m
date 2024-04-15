Return-Path: <linux-kernel+bounces-144906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D988A4C77
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF161F23596
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A1C5789F;
	Mon, 15 Apr 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IGjMzsHi"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B655761
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176746; cv=none; b=UdGRaTS4BqRdlupH6ODLrA/PjsSdjOwG4sK4DvPqejeuQ82cNykDYN2G8IYicWV51OKvAUnSihp5FtB2PGPWToDhAkp3bXYIWZ/MwDxH3DNU3gnqhJyND2kEyGIywcEOevsIGjBpTeAq0z/XHn0EaZzqFPtoHINuanX8BRzdywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176746; c=relaxed/simple;
	bh=+Wp39o8v7rFJX8PNmb8rvva8whE01Vp9zQsw694Firk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vm2z+16HeeDa2B4EpWO4Ybq+k1ZA2dcj+hbr8rek+4x77QoJaW/r+cokv2kZystz38MXyHFgC/F3eywjKAKtJvVCTNud42V5GS5aNpMULatRwmWun8r0G2JdJhi5lt3l4KREhHw+LM0RLnfa0lCU/g8e0RdealzPHNSw6QNW0ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IGjMzsHi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FAPIxq024605;
	Mon, 15 Apr 2024 10:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : reply-to : from :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=uBWNDvOjBgfnjZN9eEIBUMmLCCV7/fo4kQVllVTwZ2c=;
 b=IGjMzsHihyg3324vcv/1MDImzcEgaXZ2VxEYX0m3GzYwdz0t6vdtoXaaXyPteP5f9HnX
 GLUu5iBIoco8pC6mIXQWevHUVfUXglZ02rlpPTKWTLNAEj3I85zLa05mI4Yy2SNCSocJ
 TX2scmHP+EOmLLxtEtOWa6MbnvcpfIC5sD2r73dq6FSXvHE0JdCCLLDA+6wr4YQhXoVt
 IQq1KHjgp1vb0Hf/ofCU0jEUycIMyiPXPV9U8YewpOmb8WAFDGrbQ8JdNGgg68bslLJF
 HrSAMTcuCn5hDOjYtzh2L7Yl4e5LmlaAZQTIbdy/2aI6c1wSqDrviredvhEqC9MeHeyj bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xff7wkr5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:25:20 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FAPJYG024626;
	Mon, 15 Apr 2024 10:25:19 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xff7wkr2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:25:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43F92g9T018162;
	Mon, 15 Apr 2024 10:22:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg4csyfjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:22:19 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FAMGaH29229750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 10:22:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DC255805F;
	Mon, 15 Apr 2024 10:22:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5C305805E;
	Mon, 15 Apr 2024 10:22:11 +0000 (GMT)
Received: from [9.204.206.228] (unknown [9.204.206.228])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 10:22:11 +0000 (GMT)
Message-ID: <7577582d-46e2-4fe4-8e41-e6521326c31d@linux.ibm.com>
Date: Mon, 15 Apr 2024 15:52:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Improve rq selection for a blocked task when its
 affinity changes
Content-Language: en-US
To: Ze Gao <zegao2021@gmail.com>, 20240313085817.48892-1-zegao@tencent.com
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
 <65b1691d-8d90-4057-8ad0-da546a0ac8a1@linux.ibm.com>
 <CAD8CoPDxgL+dkUM_6oAGuAT-GQVdfrckJB2yOjufvbFE14hBxg@mail.gmail.com>
Reply-To: CAD8CoPDxgL+dkUM_6oAGuAT-GQVdfrckJB2yOjufvbFE14hBxg@mail.gmail.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <CAD8CoPDxgL+dkUM_6oAGuAT-GQVdfrckJB2yOjufvbFE14hBxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UHwkq3VQBNtLGJWK4CI5LPvgfCp9iXAH
X-Proofpoint-ORIG-GUID: pImrE_4r2Zj5qOD3GPwA3bjwbz4yRmA_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=977 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150068

Hi Ze Gao,

On 15/04/24 07:33, Ze Gao wrote:
> On Sat, Apr 13, 2024 at 12:59 AM Madadi Vineeth Reddy
> <vineethr@linux.ibm.com> wrote:
>>
>> Hi Ze Gao,
>>
>> On 13/03/24 14:28, Ze Gao wrote:
>>> We observered select_idle_sibling() is likely to return the *target* cpu
>>> early which is likely to be the previous cpu this task is running on even
>>> when it's actually not within the affinity list newly set, from where after
>>> we can only rely on select_fallback_rq() to choose one for us at its will
>>> (the first valid mostly for now).
>>>
>>> However, the one chosen by select_fallback_rq() is highly likely not a
>>> good enough candidate, sometimes it has to rely on load balancer to kick
>>> in to place itself to a better cpu, which adds one or more unnecessary
>>> migrations in no doubt. For example, this is what I get when I move task
>>> 3964 to cpu 23-24 where cpu 23 has a cpu bound work pinned already:
>>>
>>>         swapper       0 [013]   959.791829: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=13 dest_cpu=23
>>> kworker/24:2-mm    1014 [024]   959.806148: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=23 dest_cpu=24
>>>
>>
>> I am able to reproduce this scenario of having an extra migration through load balance
>> swapper       0 [031] 398764.057232: sched:sched_migrate_task: comm=loop pid=178687 prio=120 orig_cpu=31 dest_cpu=33
>> ksoftirqd/0  13 [000] 398764.356138: sched:sched_migrate_task: comm=loop pid=178687 prio=120 orig_cpu=33 dest_cpu=34
>>
>> I wrote a simple c program that blocks for few seconds, meanwhile I taskset it to CPUs 33,34 while I already have a
>> busy task running on CPU 33.
>>
>>> The thing is we can actually do better if we do checks early and take more
>>> advantages of the *target* in select_idle_sibling(). That is, we continue
>>> the idle cpu selection if *target* fails the test of cpumask_test_cpu(
>>> *target*, p->cpus_ptr). By doing so, we are likely to pick a good candidate,
>>> especially when the newly allowed cpu set shares some cpu resources with
>>> *target*.
>>>
>>> And with this change, we clearly see the improvement when I move task 3964
>>> to cpu 25-26 where cpu 25 has a cpu bound work pinned already.
>>>
>>>         swapper       0 [027]  4249.204658: sched:sched_migrate_task: comm=stress-ng-cpu pid=3964 prio=120 orig_cpu=27 dest_cpu=26
>>
>> But after applying this patch, The extra migration is still happening as CPU 33 is still chosen by try_to_wake_up.
>>
>> On placing some perf probes and testing,
>>     migration/57     304 [057] 12216.988491:       sched:sched_migrate_task: comm=loop pid=11172 prio=120 orig_cpu=57 dest_cpu=4
>>          swapper       0 [004] 12226.989065: probe:select_idle_sibling_L124: (c0000000001bafc0) i=-1 recent_used_cpu=-1 prev_aff=-1
>>          swapper       0 [004] 12226.989071:       probe:select_fallback_rq: (c0000000001a2e38) cpu=4
>>          swapper       0 [004] 12226.989074:       sched:sched_migrate_task: comm=loop pid=11172 prio=120 orig_cpu=4 dest_cpu=33
>>          swapper       0 [000] 12227.007768:       sched:sched_migrate_task: comm=loop pid=11172 prio=120 orig_cpu=33 dest_cpu=34
>>
>> It is observed that, select_fallback_rq is still taken in this scenario as default target is returned at the end of select_idle_sibling
>> which was CPU 4.
> 
> My best guess is that you may have hit the code path for running tasks
> (taskset happens right after the task is woken up). Should that happen,
> the picking is done via:
> 
>         dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);

Yes, I verified that cpumask_any_and_distribute is hit.

> 
> and it also makes sense that select_fallback_rq() returns 4 since that happens
> before you change the affinities.

In this case, 4 is passed as an argument to select_fallback_rq(), it's not the return
value. It actually returns the first affined CPU which is 33 here.

Also, I see select_fallback_rq() happening after cpumask_any_and_distribute.

> 
> you may need to rule out this case first :)
> 

I am not sure on how to avoid hitting cpumask_any_and_distribute, Can you explain how did you move the tasks in case
of stress-ng?

Thanks and Regards
Madadi Vineeth Reddy

> Regards,
> Ze
> 
>> In most of my testing, default target is returned at the end of the function due to the initial checks. It's possible that there would
>> be cases where we can get optimal CPU before we reach end of the select_idle_sibling function but it would be interesting to know if the
>> extra time spent in finding an optimal cpu have an impact instead of returning it earlier if in most of the times we are returning the
>> default target at the end.
>>
>> Thanks and Regards
>> Madadi Vineeth Reddy
>>
>>>
>>> Note we do the same check for *prev* in select_idle_sibling() as well.
>>>
>>> Signed-off-by: Ze Gao <zegao@tencent.com>
>>> ---
>>


