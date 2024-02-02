Return-Path: <linux-kernel+bounces-49790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406AD846F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAEC28C6AD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BE13DBA7;
	Fri,  2 Feb 2024 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MRVriyfr"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01F5C5E6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874645; cv=none; b=DvTcQdM2I0QQNsq0DYNuaX8P868XSqki5xP+q/51rmgfValLygu+WMxoupYUDpr/A7tBHEZNL/BsBPW1FN0/f3H7d9GCVQox1HsTuITRQLWzgmteif8PkdDQDODBrsD7TtNNnXQLIpEiQTen1OJnT5rb1J6oNccZs5ZhdgMSjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874645; c=relaxed/simple;
	bh=tUlYG97I+6I0C2eoxBUOD+g9pq/Kkv4HLwFbOwsNgms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LfmTHo7Y5tTBUPbRd3DHehlLcilANvHVbRz1GmjHqbK7gNFbnAx7vjJkM07oJm09IPOMf32jYzpyfx4gAWK4b+1skbSuFBXqplr/YDDH8+3fhyBHlQfAiN2ENAxy9XFIEVguCmzNzdJMfpFty0vipIek5aT7xdHTtovKtnz6tlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MRVriyfr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412AHfN8004187;
	Fri, 2 Feb 2024 11:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=B/bnXWxdDftdJnFJiZ4/Le6/GvIOpsVAJOUqKPeVzOk=;
 b=MRVriyfryKzDTUxs5PxxhaFNKqA2gd1FFm7IN7wjhPqcx9pkus7Rz1Uzo1ETUTAarj5Y
 1ONRzn9PWBM3BlhEFHZUcYSf+CVo51lhNCJUEX6eFIz507dmVLTYlHUivKWP94T+FWD8
 biD0tPPgyYfKuzBpImacziJoauswIjvHiZtmkYSgWPBYXv26sSxyuTc6gZc6w6xDrrso
 qPR+DkfCUk6odRTmdhRZU64kQNVY5d68AyfBqVU7XvuUaHsV6gQGD+Ig16RWzgn0Ta69
 JRrczTnnwpOs4fCS4GdX6uDVcQPmlXtpOUZOMk8QHI3MJq4XB8RroyHp9Q6wl88uRTXX JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0xgpa3ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 11:50:11 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412BoAhF012789;
	Fri, 2 Feb 2024 11:50:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0xgpa3tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 11:50:10 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4129oLNt008242;
	Fri, 2 Feb 2024 11:50:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnmjwar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 11:50:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 412Bo6wu24314484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 11:50:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 818A72004D;
	Fri,  2 Feb 2024 11:50:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC3602004B;
	Fri,  2 Feb 2024 11:50:03 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.204.201.194])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Feb 2024 11:50:03 +0000 (GMT)
Date: Fri, 2 Feb 2024 17:20:00 +0530
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
Message-ID: <ZbzW6EuJ1gFTi80U@linux.ibm.com>
References: <20240111115745.62813-2-zegao@tencent.com>
 <Za-0HCP7WG3PIe7h@linux.ibm.com>
 <CAD8CoPAJh9ggK8ODYFiUaF2WXPG4d5ERDUdpL532N5kc=-xuSw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8CoPAJh9ggK8ODYFiUaF2WXPG4d5ERDUdpL532N5kc=-xuSw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UvxqIWrDXmKdJbIu0y9r73-0oS0LX_Wt
X-Proofpoint-GUID: FW71LebVE3zraVtaruNHMNoAeztO8pqq
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=613
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020086

On Wed, Jan 24, 2024 at 10:32:08AM +0800, Ze Gao wrote:
> > Hi, How are you setting custom request values for process A and B?
> 
> I cherry-picked peter's commit[1], and adds a SCHED_QUANTA feature control
> for testing w/o my patch.  You can check out [2] to see how it works.
> 
Thank you sharing your setup.

Built the kernel according to [2] keeping v6.8.0-rc1 as base

// NO_SCHED_QUANTA
# perf script -i perf.data.old  -s perf-latency.py
PID 355045: Average Delta = 87.72726154385964 ms, Max Delta = 110.015044 ms, Count = 57
PID 355044: Average Delta = 92.2655679245283 ms, Max Delta = 110.017182 ms, Count = 53

// SCHED_QUANTA
# perf script -i perf.data  -s perf-latency.py
PID 355065: Average Delta = 10.00 ms, Max Delta = 10.012708 ms, Count = 500
PID 355064: Average Delta = 9.959 ms, Max Delta = 10.023588 ms, Count = 501

#  cat /sys/kernel/debug/sched/base_slice_ns
3000000

base slice is not being enforced.

Next, Looking closing at the perf.data file

# perf script -i perf.data -C 1 | grep switch
..
 stress-ng-cpu 355064 [001] 776706.003222:       sched:sched_switch: stress-ng-cpu:355064 [120] R ==> stress-ng-cpu:355065 [120]
 stress-ng-cpu 355065 [001] 776706.013218:       sched:sched_switch: stress-ng-cpu:355065 [120] R ==> stress-ng-cpu:355064 [120]
 stress-ng-cpu 355064 [001] 776706.023218:       sched:sched_switch: stress-ng-cpu:355064 [120] R ==> stress-ng-cpu:355065 [120]
 stress-ng-cpu 355065 [001] 776706.033218:       sched:sched_switch: stress-ng-cpu:355065 [120] R ==> stress-ng-cpu:355064 [120]
..

Delta wait time is approx 0.01s or 10ms
So, switch is not happening at base_slice_ns boundary.

But why? is it possible base_slice_ns is not properly used in
arch != x86 ?

> 
> echo NO_SCHED_QUANTA > /sys/kernel/debug/sched/features
> test
> sleep 2
> echo SCHED_QUANTA > /sys/kernel/debug/sched/features
> test
> 
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/kernel/sched?h=sched/eevdf&id=98866150f92f268a2f08eb1d884de9677eb4ec8f
> [2]: https://github.com/zegao96/linux/tree/sched-eevdf
> 
> 
> Regards,
>         -- Ze
> 
> > >
> > >                       stress-ng-cpu:10705     stress-ng-cpu:10706
> > > ---------------------------------------------------------------------
> > > Slices(ms)            100                     0.1
> > > Runtime(ms)           4934.206                5025.048
> > > Switches              58                      67
> > > Average delay(ms)     87.074                  73.863
> > > Maximum delay(ms)     101.998                 101.010
> > >
> > > In contrast, using sysctl_sched_base_slice as the size of a 'quantum'
> > > in this patch gives us a better control of the allocation accuracy and
> > > the avg latency:
> > >
> > >                       stress-ng-cpu:10584     stress-ng-cpu:10583
> > > ---------------------------------------------------------------------
> > > Slices(ms)            100                     0.1
> > > Runtime(ms)           4980.309                4981.356
> > > Switches              1253                    1254
> > > Average delay(ms)     3.990                   3.990
> > > Maximum delay(ms)     5.001                   4.014
> > >
> > > Furthmore, with sysctl_sched_base_slice = 10ms, we might benefit from
> > > less switches at the cost of worse delay:
> > >
> > >                       stress-ng-cpu:11208     stress-ng-cpu:11207
> > > ---------------------------------------------------------------------
> > > Slices(ms)            100                     0.1
> > > Runtime(ms)           4983.722                4977.035
> > > Switches              456                     456
> > > Average delay(ms)     10.963                  10.939
> > > Maximum delay(ms)     19.002                  21.001
> > >
> > > By being able to tune sysctl_sched_base_slice knob, we can achieve
> > > the goal to strike a good balance between throughput and latency by
> > > adjusting the frequency of context switches, and the conclusions are
> > > much close to what's covered in [1] with the explicit definition of
> > > a time quantum. And it aslo gives more freedom to choose the eligible
> > > request length range(either through nice value or raw value)
> > > without worrying about overscheduling or underscheduling too much.
> > >
> > > Note this change should introduce no obvious regression because all
> > > processes have the same request length as sysctl_sched_base_slice as
> > > in the status quo. And the result of benchmarks proves this as well.
> > >
> > > schbench -m2 -F128 -n10       -r90    w/patch tip/6.7-rc7
> > > Wakeup  (usec): 99.0th:               3028    95
> > > Request (usec): 99.0th:               14992   21984
> > > RPS    (count): 50.0th:               5864    5848
> > >
> > > hackbench -s 512 -l 200 -f 25 -P      w/patch  tip/6.7-rc7
> > > -g 10                                         0.212   0.223
> > > -g 20                                 0.415   0.432
> > > -g 30                                 0.625   0.639
> > > -g 40                                 0.852   0.858
> > >
> > > [1]: https://dl.acm.org/doi/10.5555/890606
> > > [2]: https://lore.kernel.org/all/20230420150537.GC4253@hirez.programming.kicks-ass.net/T/#u
> > >
> > > Signed-off-by: Ze Gao <zegao@tencent.com>
> > > ---
> >
> 

