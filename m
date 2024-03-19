Return-Path: <linux-kernel+bounces-107284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222B887FA66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BD82822F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478577E767;
	Tue, 19 Mar 2024 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SaXvhvnU"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA27E583
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839312; cv=none; b=CRPKCNKjSu1S+jMoh8uLofS75CldC3gdcDbl4jT+7Uf8hhlx5oFA0eInQlqZMCuRXRSeSZ14xV6io/PZRSGjC+ccpvBjmlRUKQLPPIGYbrPGrBwsH5aCv2+G+SSzH2I/ZllbZ+bYAiOO5wvr957dSvrI6CdKfvrZmhin+sF9C9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839312; c=relaxed/simple;
	bh=GJPWIAqExu7dk4QR5nLqPJij1LLLsrMi+OMgqffGMb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=byNDxYG5IRmYLZaX8eF9cqWoWEy87cwHPsQAcZrUbpf7Bw/y8y53KbLfAliZe1VkaUCJAhAU9ZW4FDnmcxu/aC5B9345Svr+eRdTM3pDIUAJ2ikTIZV1aK5xJucqQ4dvzODG+vgT189QuYNPNRf4tfWNXGRwBr/lUjkNMIy923o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SaXvhvnU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42J92R6A029460;
	Tue, 19 Mar 2024 09:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : in-reply-to : references : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=S99aALjqHdt5vxeAAk7T9rQZ0KYFIS8P38QG1M9RXxs=;
 b=SaXvhvnUCT0OOqT6Gb4lY5BqV8t/2YFNoZXuxiNN+XUsFLi1DBJRgkIoarmRIIYfxvgL
 2AUJhyg5/zhwrUvMC8Q3phAXnKDFktWXmhe5ukqR5mNskGgTgAVBbozIlgQGOLaox687
 iMbi4AwwzX4qtWxDDbJBEd/CJAaDHNrv6fmR5I9RXiClNJSoii8q8MMuE7x19+A1jY6q
 PR0X4op9S9EqM5e8HCQFuBAR7aGXBl1cgGWiENF+ssBzWFAAa5AMwWYZ80L8Q0jqSsGB
 i0jL51+mbHKyXXobZx8ZOvYxqmnRdfqIYpQCLnuLZf9s08XdgDAcwQ643ZVcLj16zjpu ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy7qhr16e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:08:07 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42J96v1a006375;
	Tue, 19 Mar 2024 09:08:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wy7qhr164-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:08:06 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42J8U23i011615;
	Tue, 19 Mar 2024 09:08:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8kx792-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 09:08:06 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42J9835j44106156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 09:08:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7982858063;
	Tue, 19 Mar 2024 09:08:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0F8758065;
	Tue, 19 Mar 2024 09:08:02 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Mar 2024 09:08:02 +0000 (GMT)
Date: Tue, 19 Mar 2024 10:08:02 +0100
From: Tobias Huschle <huschle@linux.ibm.com>
To: Luis Machado <luis.machado@arm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, nd <nd@arm.com>
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
In-Reply-To: <66c4286e-deaf-44a0-be62-0928529ae73f@arm.com>
References: <20240228161018.14253-1-huschle@linux.ibm.com>
 <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
 <ZfL/hROYxQudcTuX@DESKTOP-2CCOB1S.>
 <66c4286e-deaf-44a0-be62-0928529ae73f@arm.com>
Message-ID: <4b25ab45b762e64b9df09d4d12d8289f@linux.ibm.com>
X-Sender: huschle@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WDxQaEywQuysNpKZbGQ-CLMB-p-6-mbS
X-Proofpoint-GUID: cadWNAtsfNUd71EnJPbC7SXTnV4Ucb6I
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
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0
 mlxlogscore=998 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190070

On 2024-03-18 15:45, Luis Machado wrote:
> On 3/14/24 13:45, Tobias Huschle wrote:
>> On Fri, Mar 08, 2024 at 03:11:38PM +0000, Luis Machado wrote:
>>> On 2/28/24 16:10, Tobias Huschle wrote:
>>>> 
>>>> Questions:
>>>> 1. The kworker getting its negative lag occurs in the following 
>>>> scenario
>>>>    - kworker and a cgroup are supposed to execute on the same CPU
>>>>    - one task within the cgroup is executing and wakes up the 
>>>> kworker
>>>>    - kworker with 0 lag, gets picked immediately and finishes its
>>>>      execution within ~5000ns
>>>>    - on dequeue, kworker gets assigned a negative lag
>>>>    Is this expected behavior? With this short execution time, I 
>>>> would
>>>>    expect the kworker to be fine.
>>> 
>>> That strikes me as a bit odd as well. Have you been able to determine 
>>> how a negative lag
>>> is assigned to the kworker after such a short runtime?
>>> 
>> 
>> I did some more trace reading though and found something.
>> 
>> What I observed if everything runs regularly:
>> - vhost and kworker run alternating on the same CPU
>> - if the kworker is done, it leaves the runqueue
>> - vhost wakes up the kworker if it needs it
>> --> this means:
>>   - vhost starts alone on an otherwise empty runqueue
>>   - it seems like it never gets dequeued
>>     (unless another unrelated task joins or migration hits)
>>   - if vhost wakes up the kworker, the kworker gets selected
>>   - vhost runtime > kworker runtime
>>     --> kworker gets positive lag and gets selected immediately next 
>> time
>> 
>> What happens if it does go wrong:
>> From what I gather, there seem to be occasions where the vhost either
>> executes suprisingly quick, or the kworker surprinsingly slow. If 
>> these
>> outliers reach critical values, it can happen, that
>>    vhost runtime < kworker runtime
>> which now causes the kworker to get the negative lag.
>> 
>> In this case it seems like, that the vhost is very fast in waking up
>> the kworker. And coincidentally, the kworker takes, more time than 
>> usual
>> to finish. We speak of 4-digit to low 5-digit nanoseconds.
>> 
>> So, for these outliers, the scheduler extrapolates that the kworker
>> out-consumes the vhost and should be slowed down, although in the 
>> majority
>> of other cases this does not happen.
> 
> Thanks for providing the above details Tobias. It does seem like EEVDF 
> is strict
> about the eligibility checks and making tasks wait when their lags are
> negative, even
> if just a little bit as in the case of the kworker.
> 
> There was a patch to disable the eligibility checks
> (https://lore.kernel.org/lkml/20231013030213.2472697-1-youssefesmat@chromium.org/),
> which would make EEVDF more like EVDF, though the deadline comparison 
> would
> probably still favor the vhost task instead of the kworker with the
> negative lag.
> 
> I'm not sure if you tried it, but I thought I'd mention it.

Haven't seen that one yet. Unfortunately, it does not help to ignore the 
eligibility.

I'm inclined to rather propose propose a documentation change, which 
describes that tasks should not rely on woken up tasks being scheduled 
immediately.

Changing things in the code to address for the specific scenario I'm 
seeing seems to mostly create unwanted side effects and/or would require 
the definition of some magic cut-off values.



