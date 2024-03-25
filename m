Return-Path: <linux-kernel+bounces-116948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD788A561
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A992E5D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511651C5ABA;
	Mon, 25 Mar 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cWp42Zi2"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5616ABF1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366414; cv=none; b=bHoJOBrEtsMXeAUO1QPTXyRFZsApvsJRlWXBbgm+Uu4gUKgoeGMFdhSrNEGKMwezfbyySGvA48x/36GJtxoCpeMRKMWiSlMcTTATFvTOcy67NUJDXkG6xFZwOuKA1YUpP0XjMSHjSo1lSsP2ljW83tagqQZ4XcIrFlPiAYfbInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366414; c=relaxed/simple;
	bh=ElIwG6psa/J4635YmK5pkDzO7EjX+/RBo0kQUz9jl0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sKreW6YuMxONxGMPwLhedvOgJj5Au+sM745Z3qkoNDNlA3lc0JrhQDOm0OIiHRu78RB84K1y8rl6pI6JuaUYXnv3/040bNv5Yg0LNpxzDKGs+2zwtkBFZ5r/8FCuKcfFLr+K87ze0aGsGG6dMWOeMrVLm8IM/X5OhbfByWqiFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cWp42Zi2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PARjem021184;
	Mon, 25 Mar 2024 11:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jXWX8mwJBS3pmxEX7wnapQBypJUxG/fCxgLjHBdv+Tw=;
 b=cWp42Zi2mFDJ4WsHQVRiB3LOVdC1LOcTrgF0DP1w/tBXQ2xSjaXj+v3AhgpMrXVmBuEy
 ltMCelaDY24P4UW2NW8TfvZ3yjMM8ZRw71uM1Y3TXu7ZNqJtK3mtrtFc/1oydC0nVrbG
 A+PbgnAerxyfCpI3bG+EEWWyHixjeC7B7os4KSge2VCt5KchrQzvY8HSEebKiTfygd9y
 Io8YlNEv5Ed/pKBTgVdFXzS/LbE7ExPT2IUGg7OU8vjh+AaS5HtWaWBFcGNhozk/Itjz
 xuXnsYL9ODI50hgDNV8uw7QALCSvJa05YwQAhVPG96dm7H9xjic/iBOCNY2f10ZWlzg8 Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x37hd83pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 11:33:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42PBXHip022393;
	Mon, 25 Mar 2024 11:33:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x37hd83pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 11:33:17 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42PBAaZg012991;
	Mon, 25 Mar 2024 11:33:16 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t08yfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 11:33:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42PBXDJc44302652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 11:33:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5805D5806B;
	Mon, 25 Mar 2024 11:33:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5916E58057;
	Mon, 25 Mar 2024 11:33:11 +0000 (GMT)
Received: from [9.195.43.175] (unknown [9.195.43.175])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Mar 2024 11:33:11 +0000 (GMT)
Message-ID: <3c92c18b-6a19-4477-9972-1219c29b3d71@linux.ibm.com>
Date: Mon, 25 Mar 2024 17:03:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] sched: Minor changes for rd->overload access
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, linux-kernel@vger.kernel.org, vschneid@redhat.com
References: <20240325054505.201995-1-sshegde@linux.ibm.com>
 <ZgFTtAOw39tIyfzR@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <ZgFTtAOw39tIyfzR@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vGoJulDxx4BD7hWdjfuqKVZ0zkpa4uwL
X-Proofpoint-GUID: RszKkONAwqbIIyRBcORzEMPjq9FoTwiA
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
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=697
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250064



On 3/25/24 4:06 PM, Ingo Molnar wrote:
> 
> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> 
>> v2 -> v3:
>> - Wrapped check for value change inside ser_rd_overload_status
>>   as suggested by Qais.
>> - Added reviewed-by tags.
>>
>> v1 -> v2:
>> - dropped Fixes tag.
>> - Added one of the perf probes in the changelog for reference.
>> - Added reviewed-by tags.
>>
>> tl;dr
>> When running workloads in large systems, it was observed that access to
>> rd->overload was taking time. It would be better to check the value
>> before updating since value changes less often. Patch 1/2 does that.
>> With patch updates happen only if necessary. CPU Bus traffic reduced a
>> bit. No significant gains in workload performance.
> 
> Could you please post this against the latest scheduler tree, ie. tip:sched/core?
> 
> Thanks,
> 
> 	Ingo

Hi Ingo. I had mentioned the same in cover letter. Sorry if I didn't 
mention it in the correct place. 

*These patches depend on below to be applied first*
https://lore.kernel.org/all/20240307085725.444486-1-sshegde@linux.ibm.com/

After that the above patch would apply. I kept the dependency since these are in similar 
code area. Can we please consider the above patch as well? Is there any other change that needs 
to be done? 

On tip
1043c003415b (HEAD -> master) sched/fair: Use helper functions to access rd->overload
3049bc16643d sched/fair: Check rd->overload value before update
436d634f2cad sched/fair: Combine EAS check with overutilized access
379aa2cd62e0 sched/fair: Use helper function to access rd->overutilized
19bfeb2d565e sched/fair: Add EAS checks before updating overutilized
71706005072c (origin/master, origin/HEAD) Merge branch into tip/master: 'x86/shstk'


fa63c2c111ea (HEAD -> sched/core) sched/fair: Use helper functions to access rd->overload
9bef486d044b sched/fair: Check rd->overload value before update
21f90cae75c8 sched/fair: Combine EAS check with overutilized access
e835f1fa3654 sched/fair: Use helper function to access rd->overutilized
ddf390f9449d sched/fair: Add EAS checks before updating overutilized
58eeb2d79b54 (origin/sched/core) sched/fair: Don't double balance_interval for migrate_misfit


