Return-Path: <linux-kernel+bounces-70317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799228595F6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5331C20AE7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DE212E7A;
	Sun, 18 Feb 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qohDYRFC"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3FF1078D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708248493; cv=none; b=G7/X55DbPe2N11O2ry5B/Y7sPjYRbBq+SEm0DI2Sv5ibBtVTIZp72tnqDXXDp1a0LqmpAQxz4irfWoPiqge7kUj1lSnj02ycb0xJ/pabzTeka18G3XElHQjM5dhV04fmjlD3VJdlnqrBnTWG4VKjHaUX9cpNAUI1MKJHsIffGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708248493; c=relaxed/simple;
	bh=QQJt69Qct/LAYX2iHPCflLpaiVoIg1uaWtMYf1ztuQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b2j1pOveDwO9NRCP89G6fIniZyrEHuIv/SSriI1u0lZ58GzuHR0WVgm9/VqiqKPul9M2INmCBNexn/oje3ubms0fGtM15axptEiZmHq7OrQmO5enu9RqCw1XWMHUGyuG74FudBk/QVdgZZHQosn37V3nN/j1jKhgNK2QyQ+EzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qohDYRFC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41I91MIM002069;
	Sun, 18 Feb 2024 09:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : reply-to : from : in-reply-to :
 content-type : content-transfer-encoding : mime-version; s=pp1;
 bh=enwACisVPIk1tsqJRxr26XM6z9xy36cPivQsIhoqZ+E=;
 b=qohDYRFCM5SMnD8LJf8btiyGIpwIRjMZWK3uzAIi9eLEEY+Q9d4gqmli7PDhSwr/KtSZ
 ccqbI5nCD/vVJiSg1Iz9soEd++lNPcHhkcgIRTZUV8yJyTr/j0CImgAdp3PtQLL9fQi6
 ij2fgdQVbu7u1PC7zHTIqIcSMfdxZVUbtj0UhsAY1RSJTH16Kd7g+0goXIly80Y6FFrP
 7P+Ycds1z5Fqb17Ks1tagnJ0dveWyTwDian044HzP/AV6+HKhYvLxuvOSlvqRJsT1Jcu
 dGbhLXQeloZwdaXshOiGbQ1KOBqxxo12+YFFgm3tW84YCi58EXmcxeV9xKaeKpaQlAxK gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb1gnhbqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 09:27:30 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41I9R4Z6020548;
	Sun, 18 Feb 2024 09:27:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wb1gnhbqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 09:27:29 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41I74H6L013470;
	Sun, 18 Feb 2024 09:27:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7gyt9n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 09:27:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41I9RQeL14418640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Feb 2024 09:27:28 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 652C258050;
	Sun, 18 Feb 2024 09:27:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A58058045;
	Sun, 18 Feb 2024 09:27:19 +0000 (GMT)
Received: from [9.171.95.3] (unknown [9.171.95.3])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Feb 2024 09:27:18 +0000 (GMT)
Message-ID: <31622970-62e2-020a-b802-9b961a7db03d@linux.ibm.com>
Date: Sun, 18 Feb 2024 14:57:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/3] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
Content-Language: en-US
To: Chen Yu <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1700548379.git.yu.c.chen@intel.com>
Reply-To: cover.1700548379.git.yu.c.chen@intel.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <cover.1700548379.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NTkQEnsjv9OKf3PGFk82278UkIVibQ0_
X-Proofpoint-GUID: rvpAzrda06o1ZZiOhgsrOx5HcZ7_mrMg
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
 definitions=2024-02-18_07,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402180071

Hi Chen Yu,

On 21/11/23 13:09, Chen Yu wrote:
> v1  -> v2:
> - Move the task sleep duration from sched_entity to task_struct. (Aaron Lu)
> - Refine the task sleep duration calculation based on task's previous running
>   CPU. (Aaron Lu)
> - Limit the cache-hot idle CPU scan depth to reduce the time spend on
>   searching, to fix the regression. (K Prateek Nayak)
> - Add test results of the real life workload per request from Ingo
>     Daytrader on a power system. (Madadi Vineeth Reddy)
>     OLTP workload on Xeon Sapphire Rapids.
> - Refined the commit log, added Reviewed-by tag to PATCH 1/3
>   (Mathieu Desnoyers).
> 
> RFC -> v1:
> - drop RFC
> - Only record the short sleeping time for each task, to better honor the
>   burst sleeping tasks. (Mathieu Desnoyers)
> - Keep the forward movement monotonic for runqueue's cache-hot timeout value.
>   (Mathieu Desnoyers, Aaron Lu)
> - Introduce a new helper function cache_hot_cpu() that considers
>   rq->cache_hot_timeout. (Aaron Lu)
> - Add analysis of why inhibiting task migration could bring better throughput
>   for some benchmarks. (Gautham R. Shenoy)
> - Choose the first cache-hot CPU, if all idle CPUs are cache-hot in
>   select_idle_cpu(). To avoid possible task stacking on the waker's CPU.
>   (K Prateek Nayak)
> 
> Thanks for the comments and tests!
> 
> ----------------------------------------------------------------------
> 
> This series aims to continue the discussion of how to make the wakee
> to choose its previous CPU easier.
> 
> When task p is woken up, the scheduler leverages select_idle_sibling()
> to find an idle CPU for it. p's previous CPU is usually a preference
> because it can improve cache locality. However in many cases, the
> previous CPU has already been taken by other wakees, thus p has to
> find another idle CPU.
> 
> Inhibit the task migration could benefit many workloads. Inspired by
> Mathieu's proposal to limit the task migration ratio[1], introduce
> the SIS_CACHE. It considers the sleep time of the task for better
> task placement. Based on the task's short sleeping history, tag p's
> previous CPU as cache-hot. Later when p is woken up, it can choose
> its previous CPU in select_idle_sibling(). When other task is
> woken up, skip this cache-hot idle CPU and try the next idle CPU
> when possible. The idea of SIS_CACHE is to optimize the idle CPU
> scan sequence. The extra scan time is minimized by restricting the
> scan depth of cache-hot CPUs to 50% of the scan depth of SIS_UTIL.
> 
> This test is based on tip/sched/core, on top of
> Commit ada87d23b734
> ("x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram")
> 
> This patch set has shown 15% ~ 70% improvements for client/server
> workloads like netperf and tbench. It shows 0.7% improvement of
> OLTP with 0.2% run-to-run variation on Xeon 240 CPUs system.
> There is 2% improvement of another real life workload Daytrader
> per the test of Madadi on a power system with 96 CPUs. Prateek
> has helped check there is no obvious microbenchmark regression
> of the v2 on a 3rd Generation EPYC System with 128 CPUs.
> 
> Link: https://lore.kernel.org/lkml/20230905171105.1005672-2-mathieu.desnoyers@efficios.com/ #1
> 
> Chen Yu (3):
>   sched/fair: Record the task sleeping time as the cache hot duration
>   sched/fair: Calculate the cache-hot time of the idle CPU
>   sched/fair: skip the cache hot CPU in select_idle_cpu()
> 
>  include/linux/sched.h   |  4 ++
>  kernel/sched/fair.c     | 88 +++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/features.h |  1 +
>  kernel/sched/sched.h    |  1 +
>  4 files changed, 91 insertions(+), 3 deletions(-)
> 

Any update or progress regarding this patch?

I was working on a patch that improves scheduler performance in power10 by making changes
to the order in which domains are accessed for cpu selection during wakeup. It turns out
that this patch is helpful in that regard and my patch is giving better performance on top
of this patch.

So, looking forward to know the progress/status of this patch.

Thanks and Regards
Madadi Vineeth Reddy


