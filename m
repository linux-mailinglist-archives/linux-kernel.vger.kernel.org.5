Return-Path: <linux-kernel+bounces-136371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A768889D34C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9EE282DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E87D3E3;
	Tue,  9 Apr 2024 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pb7dKC6c"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B7E7C6CC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648156; cv=none; b=ri6uWiwpafZOkriaAIes6n9vvDdIQ71qS32ZxaqWOisHcs2zFK9C+n4c2Wf3gTl0Qebv+aqKYWnWjdrk70ncBjQcuLFYlfEcTGfJsoBJGVonvXcS4GbRmoA8u8stUrMZL6i1l+vwWpcocXdkf/RxF/9EHw6XA4V5gx6px3j5CFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648156; c=relaxed/simple;
	bh=G1PHgsYK6Hi8kJaHfak0CzSmoGGO8wVYUfL7WphTOOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ellYEh8JGLbWCX+jcIw2muBCqRgaOY4iZywC502sfpCBweHiVuSLyiYamfl/oiclZgdjFiWOC9AZkmwTJrtPbU/w0oxpZ+aKmsPPBzauUWhzz4W6yz9Iz09wGBZhy7ko/uJFla+nM9Ni36iPhOI32V+M0pYD1cPtttHFVsnqAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pb7dKC6c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4397NwIo016110;
	Tue, 9 Apr 2024 07:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2+7diTVZ3rSZnpTn6NllEJkVpD9Qyx7pIep06/Paocs=;
 b=Pb7dKC6cjvTuGecDxZjCa6+Sqew6tlPvZhqgTqtYSZ2ZU+gNUyhRzM1jaQYXpy2OeTAX
 sS9MPaMM2RRdwlar0zG9wVoVthpT9w7eS52LlxBfmW/nfy0WltbVsKIFSxSeZdVDtcNY
 57/W+zqQluUKsNbh1uM6aZvUi6Qr20GgbMHJohIs2PdgVf1VOcEW+aYTrgoiEPBP+XpN
 Wai4pijI7d0bMqqTXu0gFwYuxQUzZRncwTRXKgZTvglD2nQiQX4ksw1gbnCkrSlFjNdL
 mmPb9WdXRjSOBv3+y2gQzOMRS00Ddp320vsxWT4oUr4aG+x032sCoKPN8hfKel2E4tON GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xd0ty82jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 07:35:35 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4397ZY3L002336;
	Tue, 9 Apr 2024 07:35:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xd0ty82jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 07:35:34 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4394eaLl019082;
	Tue, 9 Apr 2024 07:35:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbh405188-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 07:35:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4397ZTFq50266544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Apr 2024 07:35:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B887820040;
	Tue,  9 Apr 2024 07:35:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72E072004B;
	Tue,  9 Apr 2024 07:35:29 +0000 (GMT)
Received: from DESKTOP-2CCOB1S. (unknown [9.171.210.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Apr 2024 07:35:29 +0000 (GMT)
Date: Tue, 9 Apr 2024 09:35:27 +0200
From: Tobias Huschle <huschle@linux.ibm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Luis Machado <luis.machado@arm.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, nd <nd@arm.com>
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
Message-ID: <ZhTvvz9oq7qhLJRs@DESKTOP-2CCOB1S.>
References: <20240228161018.14253-1-huschle@linux.ibm.com>
 <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
 <ZfL/hROYxQudcTuX@DESKTOP-2CCOB1S.>
 <66c4286e-deaf-44a0-be62-0928529ae73f@arm.com>
 <4b25ab45b762e64b9df09d4d12d8289f@linux.ibm.com>
 <CAKfTPtDyrsnq-CSFo+upzdOJpuH=JkRzSALad-OL29OvqkK2dg@mail.gmail.com>
 <65fa8a7c.050a0220.c8ec5.0278SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAKfTPtBA7ECeYJYdzL9ybeXLbpEudLfB6V9s+DZiJUmpnPf_kQ@mail.gmail.com>
 <65fc25ae.810a0220.f705f.4cdbSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAKfTPtCv37JA+5D6WQbgsjeY7-Vx4tD+6PFDH+wc8TtPE58T9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCv37JA+5D6WQbgsjeY7-Vx4tD+6PFDH+wc8TtPE58T9A@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fRbtPw482L_B4nDgFsZ88BlC8FJn39pH
X-Proofpoint-GUID: 7obpUKdEzUtebrDf-jRoQWSL32CwjP1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_04,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404090046

On Fri, Mar 22, 2024 at 06:02:05PM +0100, Vincent Guittot wrote:
> and then
>     se->vruntime = max_vruntime(se->vruntime, vruntime)
> 

First things first, I was wrong to assume a "boost" in the CFS code. So I
dug a bit deeper and tried to pinpoint what the difference between CFS and
EEVDF actually is. I found the following:

Let's assume we have two tasks taking turns on a single CPU.
Task 1 is always runnable.
Task 2 gets woken up by task 1 and goes back to sleep when it is done.
This means, task 1 runs, wakes up task 2, task 2 runs, goes to sleep and
task 1 runs again and we repeat.
Most of the time: runtime(task1) > runtime(task2)
Rare occasions:   runtime(task1) < runtime(task2)
So, task 1 usually consumes more of its designated time slices until it gets
rescheduled by the wakeup of task2 than task 2 does. But both never consume
their full time slice. Rather the opposite, both run for low 5-digit ns or
less.

So something like this:

task 1    |----------|    |---------|    |------...
task 2               |----|         |----|

This creates different behaviors under CFS and EEVDF:

### CFS ####################################

In CFS the difference in runtimes means that task 2 cannot catch up with 
task 1 vruntime-wise

With every exchange between task 1 and task 2, task 2 falls back more on
vruntime. Once a difference in the magnitude of sysctl_sched_latency is 
established, the difference remains stable due to the max handling in 
place_entity.

Occasionally, task 2 may run longer than task 1. In those cases, it
will catch up slightly. But in the majority of cases, task 2 runs
shorter, thereby increasing the difference in vruntime.

This would explain why task 2 gets always scheduled immediately on wakeup.

### EEVDF ##################################

The rare occasions where task 2 runs longer than task 1 seem to cause 
issues with EEVDF:

In the regular case where task 1 runs longer than task 2. Task 2 gets 
a positive lag and is selected on wake up --> good.
In the irregular case where task 2 runs longer than task 1 task 2 
now gets a negative lag and is no longer chosen on wakeup --> bad (in some cases).

This would explain why task 2 gets not selected on wake up occasionally. 

### Summary ################################

So my wording, that a woken up task gets "boosted" was obviously wrong. 
Task 2 is not getting boosted in CFS, it gets "outrun" by task 1, with 
no chance of catching up. Leaving it with a smaller vruntime value.

EEVDF on the other hand, does not allow lag to accumulate if an entity, like 
task 2 in this case, regularly dequeues itself. So it will always have 
a lag with an upper boundary of whatever difference it encountered in 
comparison to the runtime with task 1.

The patch below, allows tasks to accumulate lag over time. This fixes the
original regression, that made me stumble into this topic. But, this might 
of course come with arbitrary side effects.

I'm not suggesting to actually implement this, but would like to confirm 
whether my understanding is correct that this is the aspect where CFS and 
EEVDF differ, where CFS is more aware of the past in this particular case
than EEVDF is.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..b83a72311d2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -701,7 +701,7 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
        s64 lag, limit;
 
        SCHED_WARN_ON(!se->on_rq);
-       lag = avg_vruntime(cfs_rq) - se->vruntime;
+       lag = se->vlag + avg_vruntime(cfs_rq) - se->vruntime;
 
        limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
        se->vlag = clamp(lag, -limit, limit);

