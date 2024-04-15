Return-Path: <linux-kernel+bounces-144922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BADA8A4CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032EC1F21770
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE725C600;
	Mon, 15 Apr 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fikHU574"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B585B666
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177435; cv=none; b=P4VsEJG4VWR1NcAN9AQyWSviW55WdaJz9q+k1CTIbl9nLjlXRxGadgFPaZJU6x2bOzdmwxAdrC9V/TAfpkIHSNjDoh8zzCYf2ZR32nE/HO5Nd3O+wRSpKKdh1MsOcRhn+qMQ0Waf3ltMw8sQ5IN+wkl6744U34H/keuP/rkDjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177435; c=relaxed/simple;
	bh=GpuCppNdjgHd4PxtxjqQ7/SR447EOkzCMuzdv5ywiIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIRwJtkH5tt5EE7DRKb37dJc+Un7CN7fK++vL6ZZu2RVH8JjJ1Va82PJw9vtFo9Hajjc4IBv+RgXfpANJcwCrA7kRpyBlleMcArsy0lxFM/Of6WhwxOczk5Gl/EeS2n1mMz1yfKMX3aAurTQIFEFZkvJAIYl1psnMNrLPoggm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fikHU574; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FAPRoa018171;
	Mon, 15 Apr 2024 10:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : reply-to : from :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=EfpN42utemMCNxxgWsct835ziKCBcRAU7y23Kj9YijA=;
 b=fikHU574aI7/uJdBlHJiN3Ub83cbHl9gRFGwrzMG+XigoopwrJHMwNhVx6sY4Fz1qkD4
 cvHJrnDG8dFd4oik4waP8UvULh8xPfGHuzY2RiVmp0n/XdaN+kCnGnR1NcpXfHlb3yGv
 ypLs+Dse03731+5bPh7cVRGgeuW2I6XZbmXP8YAc6axp00yN/M4OMpiUjefC3TK5lFxi
 ufkV/vPg8F7MQvOYz0KS6LlqFltBZ+YscmG9MBk1hQgbjhVnPIqICwZin9PuWXnCPWn9
 AEqWWK6/1D6GmvYdT+10100Ou2YMUMdKYNUqDD8sOHeRQ1Rj9kNWljTMIRW/zuv8xfz8 nA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xgyg98cmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:36:47 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FAYeDi032733;
	Mon, 15 Apr 2024 10:36:46 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xgyg98cmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:36:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43F7bXvq011164;
	Mon, 15 Apr 2024 10:36:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg7326v8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 10:36:45 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FAahZ146268876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 10:36:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B772E5810A;
	Mon, 15 Apr 2024 10:36:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41F5758102;
	Mon, 15 Apr 2024 10:36:37 +0000 (GMT)
Received: from [9.204.206.228] (unknown [9.204.206.228])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 10:36:36 +0000 (GMT)
Message-ID: <e8cafcdf-a1aa-4ff1-b614-7c6fd4fa9716@linux.ibm.com>
Date: Mon, 15 Apr 2024 16:06:35 +0530
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
 <65b1691d-8d90-4057-8ad0-da546a0ac8a1@linux.ibm.com>
 <CAD8CoPDajt_EciU0x8G_BocajfaJrQ1FKLYkp_nLSfF9+9FJVw@mail.gmail.com>
Reply-To: CAD8CoPDajt_EciU0x8G_BocajfaJrQ1FKLYkp_nLSfF9+9FJVw@mail.gmail.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <CAD8CoPDajt_EciU0x8G_BocajfaJrQ1FKLYkp_nLSfF9+9FJVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gDILjrd7M6Dme5LExKbokBNLJvz94ECt
X-Proofpoint-GUID: KCrjA7QRXu_6C3KaUVffYq2HZohQwMf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150070

On 15/04/24 11:10, Ze Gao wrote:
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
> After second thoughts, it indeed could happen if CPU 4 shares nothing
> with CPU 33(34),
> for example, in different numa nodes.
> 
> IOW, it cannot benefit from select_idle_siblings() and has to rely on
> select_fallback_rq
> as the last resort. Just like what I said in the changelog, this patch
> aims to improve rq
> selection for cases where the newly allowed cpu set shares some cpu
> resources with
> the old cpu set.

Right. In power 10(where I tested), LLC is smaller being at SMT4 small core
level. So, I think there are less chances of affined CPUs to share resources
with the old CPU set.

I also ran schbench and hackbench just to make sure that there is no regression
in powerpc. Luckily there is no regression.

Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks and Regards
Madadi Vineeth Reddy

> 
> Sorry for not being able to recall all details immediately, since this
> thread has been inactive
> for a long while and receives no feedback from sched folks.
> 
> Best,
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


