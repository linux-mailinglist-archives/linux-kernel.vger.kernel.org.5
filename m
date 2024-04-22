Return-Path: <linux-kernel+bounces-153423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80248ACDF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E01F281AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE2D14F12A;
	Mon, 22 Apr 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wyw5SgMA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D2C14F122
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791652; cv=none; b=YNU5aHluJUvH02S5o7OWSJE4pxH8GxmT1d0KXbbZ/RvRcLQczyrgrK9CmK5MziizyIn3Nxn8LYhfE2PGwDc1G0HBwBz5CA6tkEnVBaMw2luLf481l1rhRiUOxxiElo/7NtXXiFGmoRM+TzeOhm/9cWIfONb6h1tc4715FCXqnJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791652; c=relaxed/simple;
	bh=2oEmwtXRHOAyk1KM4gmTqr/LESOX5QObPfyD3lEH11E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bvLkCNZfReSAFF6H/e5w6ZNfPiYuPK47i0O2+eWHzIz8POZqx7oi75Z2N25UqCVatCwqWh/3Ys8gP5g/HuYLCtO1YXkX2I3RJrbDSUg6FzViRy09p79pKcmXZ6V37aYzh7iDr43Rku7icmhVPqe22orI/iEc5Ykt6FpIl/6PPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wyw5SgMA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MCpY8T017704;
	Mon, 22 Apr 2024 13:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=C3Zv+VqQTbVwtsfjNcJssu7lKbDwdh8k6Dp/SxkWG2I=;
 b=Wyw5SgMAoRlcBceozj0xcGUhAtILBoME4unKvlWiI6p7f3e0++PKQW83cVrFhr0vIXyX
 rWFgl2rvTUpxoZqR9oIF9jxThgJKeBhTsSu1qng7TixlsKwin/0Jan6T6JsdcQbapapV
 Wwceb5l4g+dlrZunp7/S+zWr5VRBNrgAjtTcMVuiyxJWtbTb4pVFrp8YNdUmdI49JimO
 BxdAWatHql+Eet9DR1jJVR0vVjQd2UpASJCObh6ua387FEV6yanJt9DhWHCfyeO1vJvP
 Pmgi9Yod0bpycDZpZxUsIb889in7PZAH7AeFtLlm1Zz504MrTdkBeKeky692TplU301C qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnr0n02dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 13:13:28 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43MDDS4N019813;
	Mon, 22 Apr 2024 13:13:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnr0n02d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 13:13:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43MBXemS005373;
	Mon, 22 Apr 2024 13:13:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3c6jsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 13:13:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43MDDNmg32834202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 13:13:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA3322004F;
	Mon, 22 Apr 2024 13:13:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B3FC2004E;
	Mon, 22 Apr 2024 13:13:23 +0000 (GMT)
Received: from DESKTOP-2CCOB1S. (unknown [9.171.173.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 22 Apr 2024 13:13:23 +0000 (GMT)
Date: Mon, 22 Apr 2024 15:13:23 +0200
From: Tobias Huschle <huschle@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
        wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <ZiZic8t72/tG+z0T@DESKTOP-2CCOB1S.>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405110010.631664251@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SRr5Yuru2YcnG9JGicsu8H2u2zFMQpQR
X-Proofpoint-GUID: 79WTu4IeCKej8jnpymwaxlIr1YDt2dR_
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404220058

On Fri, Apr 05, 2024 at 12:28:02PM +0200, Peter Zijlstra wrote:
> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
> noting that lag is fundamentally a temporal measure. It should not be
> carried around indefinitely.
> 
> OTOH it should also not be instantly discarded, doing so will allow a
> task to game the system by purposefully (micro) sleeping at the end of
> its time quantum.
> 
> Since lag is intimately tied to the virtual time base, a wall-time
> based decay is also insufficient, notably competition is required for
> any of this to make sense.
> 
> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
> competing until they are eligible.
> 
> Strictly speaking, we only care about keeping them until the 0-lag
> point, but that is a difficult proposition, instead carry them around
> until they get picked again, and dequeue them at that point.
> 
> Since we should have dequeued them at the 0-lag point, truncate lag
> (eg. don't let them earn positive lag).
> 

I stumbled upon a subtle change between CFS and EEVDF which kinda relates
to the question how long lag should be carried around, but on the other 
side of the 0-lag value.

Assume that we have two tasks taking turns on a single CPU. 
Task 1 does something and wakes up Task 2.
Task 2 does something and goes to sleep.
And we're just repeating that.
Task 1 and task 2 only run for very short amounts of time, i.e. much 
shorter than a regular time slice.

Let's further assume, that task 1 runs longer than task 2. 
In CFS, this means, that vruntime of task 1 starts to outrun the vruntime
of task 2. This means that vruntime(task2) < vruntime(task1). Hence, task 2
always gets picked on wake up because it has the smaller vruntime. 
In EEVDF, this would translate to a permanent positive lag, which also 
causes task 2 to get consistently scheduled on wake up.

Let's now assume, that ocassionally, task 2 runs a little bit longer than
task 1. In CFS, this means, that task 2 can close the vruntime gap by a
bit, but, it can easily remain below the value of task 1. Task 2 would 
still get picked on wake up.
With EEVDF, in its current form, task 2 will now get a negative lag, which
in turn, will cause it not being picked on the next wake up.

So, it seems we have a change in the level of how far the both variants look 
into the past. CFS being willing to take more history into account, whereas
EEVDF does not (with update_entity_lag setting the lag value from scratch, 
and place_entity not taking the original vruntime into account).

All of this can be seen as correct by design, a task consumes more time
than the others, so it has to give way to others. The big difference
is now, that CFS allowed a task to collect some bonus by constantly using 
less CPU time than others and trading that time against ocassionally taking
more CPU time. EEVDF could do the same thing, by allowing the accumulation
of (positive) lag, which can then be traded against the one time the task
would get negative lag.

This might of course clash with other EEVDF assumptions but blends with the
question on how long lag should be preserved.

I stumbled upon a performance degredation caused by this nuance. EEVDF is 
not necessarily at fault here. The problem rather lies in a component
that relies on CFS allowing the above mentioned bonus aggregation while
knowing that the corresponding task 2 has to run.
See: https://lore.kernel.org/netdev/ZWbapeL34Z8AMR5f@DESKTOP-2CCOB1S./T/
With the reasoning above, the degradation can be explained perfectly, and 
even be fixed by allowing the accumulation of lag by applying the patch
below.

I was just wondering if my assumptions here are correct and whether this
would be an implicit change that one should be aware about.


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

