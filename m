Return-Path: <linux-kernel+bounces-93848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE8A8735A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A421C20A8F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12477FBBD;
	Wed,  6 Mar 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S3N9L1m9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3080020
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724723; cv=none; b=CHoF2GQiNFURUO970xOJiGrXPHy6Ys5hIWj5pHso3+/UkZPpCWUeoEPs/pwFuj/MST0PgD+AtB6M2KdeWzFD3vNGrCk2JnGuaK7rgBLK1r/eCvyW4qjEiVkqQjhMAXBVuwij9LkR18LKd2mBSVCSVNBaAtVoctVhk9Q8VqckuRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724723; c=relaxed/simple;
	bh=A3uV2BFGkQ0UK2N+fegpTsUFuGh/aaZ9hzW6Wbb4/Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UlANNv09DLeBGGov6gd6Exvqxw6ZHXuf2RTbiAcL7U/v2VsUGC7bRCDkrbA3cLua5zNQklSNRUZCJ9YGsBEmYdRRV0ZFP7w6LPjRCFkFx8VM3r/cW4XdicBqy7LSE2CqfCj2B9rII5lJmiGDdr7Jc+eC9odhwS8VjAgdl1OuYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S3N9L1m9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426BRuw6003931;
	Wed, 6 Mar 2024 11:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=nP8e8WQAM79G2ow6PcA0nvmRxu4/vNk9UzJLeTOvxm8=;
 b=S3N9L1m9xACV+eE9RwI0PRtIUMOyEoJH7iNdOm7O6mcj6VoPP1nJH78A/+ZatI05P1UW
 B7iZX2KR4aQAIlzU2QRQyVXqIuiMnTFHHmzPN74BUaLhCH0yaFNmZKk88S2RucFq4wN8
 Y7PVj7sDiWG6hpIph3b49CoV6w2pRn6QD5R1NOz6u/EeE1s0KzZmx3Kz8FDwAx4FFfkR
 bBFrVD7GDVT4MRXkM4PT7JgWiZQ/7Uy1oARk6bgPNMJFBYrhwIpZPpkA1/1ZxgtfufHt
 j99OsGvm3i22NZXAc8MpqTWU51ddTWzBhB88+eDbX/FcT0Kqf0F6HfCpkFvFTeOJNB/n Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpqmt08r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 11:31:39 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426BSB7K004795;
	Wed, 6 Mar 2024 11:31:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpqmt08pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 11:31:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426AGoOR026228;
	Wed, 6 Mar 2024 11:31:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfenxaae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 11:31:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426BVXHL42336704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 11:31:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EC5E20040;
	Wed,  6 Mar 2024 11:31:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 376BF20043;
	Wed,  6 Mar 2024 11:31:33 +0000 (GMT)
Received: from DESKTOP-2CCOB1S. (unknown [9.171.196.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Mar 2024 11:31:33 +0000 (GMT)
Date: Wed, 6 Mar 2024 12:31:31 +0100
From: Tobias Huschle <huschle@linux.ibm.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, Xuewen Yan <xuewen.yan@unisoc.com>,
        xuewen.yan94@gmail.com, ke.wang@unisoc.com
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
Message-ID: <ZehUE9un8oIlwBKX@DESKTOP-2CCOB1S.>
References: <20240228161018.14253-1-huschle@linux.ibm.com>
 <fe8462ae-9144-6925-1679-a5079e5b0556@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8462ae-9144-6925-1679-a5079e5b0556@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _kwtHa3WcAKyP48c5JEQgdSQ0Z3EvEo7
X-Proofpoint-ORIG-GUID: uzfJOcYhXSlP10TssDu9opckAfb7pCfk
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=839
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060092

On Thu, Feb 29, 2024 at 09:06:16AM +0530, K Prateek Nayak wrote:
> (+ Xuewen Yan, Ke Wang)
> 
> Hello Tobias,
> 
<...>
> > 
> > Questions:
> > 1. The kworker getting its negative lag occurs in the following scenario
> >    - kworker and a cgroup are supposed to execute on the same CPU
> >    - one task within the cgroup is executing and wakes up the kworker
> >    - kworker with 0 lag, gets picked immediately and finishes its
> >      execution within ~5000ns
> >    - on dequeue, kworker gets assigned a negative lag
> >    Is this expected behavior? With this short execution time, I would
> >    expect the kworker to be fine.
> >    For a more detailed discussion on this symptom, please see:
> >    https://lore.kernel.org/netdev/ZWbapeL34Z8AMR5f@DESKTOP-2CCOB1S./T/
> 
> Does the lag clamping path from Xuewen Yan [1] work for the vhost case
> mentioned in the thread? Instead of placing the task just behind the
> 0-lag point, clamping the lag seems to be more principled approach since
> EEVDF already does it in update_entity_lag().
> 
> If the lag is still too large, maybe the above coupled with Peter's
> delayed dequeue patch can help [2] (Note: tree is prone to force
> updates)
> 
> [1] https://lore.kernel.org/lkml/20240130080643.1828-1-xuewen.yan@unisoc.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=e62ef63a888c97188a977daddb72b61548da8417

I tried Peter's patches a while ago. Unfortunately, reducing the lag
is not sufficient in this particular case. The calling entity expects
the woken up kworker to run instantly.

In order to have a chance that the woken up kworker is scheduled right
away, the kworker must not have any negative lag. To guarantee it being 
scheduled it should even have a positive lag which allows it to pass
all other entities on the queue.

Therefore I proposed to just wipe the negative lag in these cases, 
which seems to map to strategy #2 of the underlying paper.

The other way to think about this would be:
The assumption, that woken up tasks get a high probability to run
is no longer valid. In that case, the entity triggering the wake
up has to explicitly give up the CPU. If there are no other tasks,
apart from the 2 involved so far, has good chances of being 
scheduled. If the runqueue is busy, other tasks might intervene.

I keep playing around with these options, but potential side effects
are worrying me.

> 
<...>

