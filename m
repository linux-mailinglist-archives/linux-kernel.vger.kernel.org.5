Return-Path: <linux-kernel+bounces-48387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A7C845B51
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F711C28267
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F3626B4;
	Thu,  1 Feb 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JtlrIm05"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71C626C3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800765; cv=none; b=tNkBatJhT+GRI82oSGaa4L57Olr7sT2H56L/ph5dOWjHWZ7qIW611/SPuJvE45TDPtpawLY4yYa6x/UM94uNVo/okIJ+utc3UpQ7IR0N+JbhpElJahQ1hg0IRc7oGDGXdkkuYg+fjHMaBRmQn3ku+8g+rLMgPTz5cdraLmSkjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800765; c=relaxed/simple;
	bh=8JgxEc+bX32pOS4kEsYG5U3qBoEUsZxAhbq3kWofItE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwrofmYM62GHaqkuLNmZjdfm390NaD2Ukp7BI6DiIcOiKbpyoVS5l00torYXg/R/9oP+CNqM2eWM8+5WdI5skxXINk+SqFRPocMZ8vuPm2RZmu10RyT+OZkoGNkQwi5P297+kJ2r1NMowTwSVloyWIZf3Bsj1AXddtXDG2WK4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JtlrIm05; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411F2Tw3023557;
	Thu, 1 Feb 2024 15:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=i6gECI69MXNoo5G6MJTFnb+hFeafreVhtwPn/Bx5RPE=;
 b=JtlrIm05BJoOpoTyf3Sz0cgx+RxOd5q6MFspPFrrn5la8w1Pax75D/T9tMh2DBnA1g8V
 PIoK++BMFtDwfaEV9hiowx6AJ/+W9NjueSz91Sm24VNxAW7bMXV457pe/hbIVqIVQUnr
 z0t+qm/hW0iBefAffYD7ujLbbIj4clOq4TUZc7bHpFR3XB/NLsN2SpQxzTWFBawkdbIC
 7wCyhuCmunjcRx7GqHB2aFruHmLDdayzjNWDLy5LIyJ2cTvMLdFT+7dWYrUTFHfxeTho
 C8fJfRAYn4TVYhJr7x3XSWCzObQvPSQjnf+gabBp3Pe3vNePbb6ybArkSQdqXsXrHvDc +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0dkc8h9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 15:19:12 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 411F2njV025002;
	Thu, 1 Feb 2024 15:19:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0dkc8h9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 15:19:11 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 411DmTm2007979;
	Thu, 1 Feb 2024 15:19:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnmcsq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 15:19:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 411FJA5m10682884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 15:19:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6348958056;
	Thu,  1 Feb 2024 15:19:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB99858052;
	Thu,  1 Feb 2024 15:19:06 +0000 (GMT)
Received: from [9.79.186.197] (unknown [9.79.186.197])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Feb 2024 15:19:06 +0000 (GMT)
Message-ID: <0c9e077c-c59a-40c7-878f-7f429e12ba24@linux.ibm.com>
Date: Thu, 1 Feb 2024 20:49:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6 RFT] sched/fair: change sched asym checking
 condition
Content-Language: en-US
To: kuiliang Shi <seakeel@gmail.com>, alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <20240130131708.429425-1-alexs@kernel.org>
 <20240130131708.429425-6-alexs@kernel.org>
 <20240201011038.GD18560@ranerica-svr.sc.intel.com>
 <4a6d2404-46ab-41ca-856e-e4cbfebba185@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <4a6d2404-46ab-41ca-856e-e4cbfebba185@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IuhuT-xNfM7HdyOznjggxKiGhiBbFKSs
X-Proofpoint-GUID: cRpym2fjRAHT73EYSC3SL2NWK3JGjp4h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=554
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402010119



On 2/1/24 5:10 PM, kuiliang Shi wrote:
> 
> 
> On 2/1/24 9:10 AM, Ricardo Neri wrote:
>> On Tue, Jan 30, 2024 at 09:17:08PM +0800, alexs@kernel.org wrote:
>>> From: Alex Shi <alexs@kernel.org>
>>>
>>> Asym only used on SMT sd, or core sd with ITMT and core idled.
>>> !sched_smt_active isn't necessary.
>>
>> sched_smt_active() is implemented as a static key. Thus, if SMT is not
>> enabled, we can quickly return without having to check the rest of the
>> conditions, as we should.
> 
> Hi Ricardo,
> 
> Thanks a lot for comments! I will drop this patch in this series.
> 
> But forgive my stupidity, asym feature is possible when SMT enabled instead of SMT disable. Why no SMT is a condition for asm feature? For this asym feature, I only see the SMT and MC domain use this, correct me if I'm wrong. 
> 

on power7 ASYM_PACKING is used to pack at SMT level. 

On x86, ITMT topology uses ASYM_PACKING to do load balancing instead of using different cpu capacities.

Its possible to have it in PKG(earlier referred as DIE) as well. 
In powerpc recently we did that for shared processor LPAR's. So asym feature is in PKG as well. 

>>
>>>

