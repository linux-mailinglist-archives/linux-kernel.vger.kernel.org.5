Return-Path: <linux-kernel+bounces-120355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CF388D635
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD77B23246
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1CA18026;
	Wed, 27 Mar 2024 06:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yf/vaOld"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D48B8836
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711519522; cv=none; b=AMf3XiSraJ0kI1cAqmjARgadWINLVN5UNSC7JvOYb+C/qJXZcdNCegNrw6PpbYHjz5p9REyCt+Yzr6q/I+NddBdSvYp1Qi7p4DGCQboIu6PsyKGknf3Mliq5bb3yVfahG82n6zn8qIYq3pXcHW8F2ivpqk6+XhXLG7OvyVApJUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711519522; c=relaxed/simple;
	bh=mSQPYVtc1HoH7v5nM/yLI99AjFqmSX9f4oWfeYB5x0c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VM70w1n74wp2ttFSoUU7lRJd+SZKpHCeQc4vbSl6M9+ZOvgwZHwzhn6k7K1Sd6Rg73bQn4LLHF/Gw1RmuiqcZ2kXbyhpw49voX3H02RHFIWazgthwyTcWW73nRB06oBQulrKYdkB+pomtSOtl9A4VpTxgHhm7YngfiHgo172hnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yf/vaOld; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42R4OMx5004704;
	Wed, 27 Mar 2024 06:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=K6f6lKHz57smj6OhZGBqGWexJC1/2bKn4+unUFT0fIU=;
 b=Yf/vaOldn4nOTldky7zK63B6eEVaf5Fhscjo/Bfq2c8hAjHaDACczDs5Sten5A/6CGdF
 BYKOQV7RzH1NldXVKqyDAwYtnvchDCSK54qjg0AcBdSMb3b+PchkL89kbMYBEeAo+qTD
 OvWVqzOatwmSnFy7ucfQDd6KyoLJ1wcMpyBf5Tz9Te46BqyjSfLYpNo9lH0nwo6EosqD
 81YzDbq/dDyxLcxIleWF76sff+c10Qnnhxy4IEpHaK0Qg0iVAsASpmy0I/JhshdHOI/C
 bn6KH61kTQCvy7ubyc3uLfZP5uqLc/R3O4FJcd/Szhq79jzIUjYNAEWVjTRAEHeaHF3N 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x49abrdu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 06:05:01 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42R650Ru027338;
	Wed, 27 Mar 2024 06:05:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x49abrdu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 06:05:00 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42R4x2gJ011238;
	Wed, 27 Mar 2024 06:05:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmm4d7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 06:05:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42R64v9459507178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Mar 2024 06:04:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 965885805D;
	Wed, 27 Mar 2024 06:04:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 900CD5806A;
	Wed, 27 Mar 2024 06:04:55 +0000 (GMT)
Received: from [9.195.42.203] (unknown [9.195.42.203])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Mar 2024 06:04:55 +0000 (GMT)
Message-ID: <38c39ea6-21df-44e9-96e7-6f6fd35822a7@linux.ibm.com>
Date: Wed, 27 Mar 2024 11:34:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] sched: Minor changes for rd->overload access
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, linux-kernel@vger.kernel.org, vschneid@redhat.com
References: <20240325054505.201995-1-sshegde@linux.ibm.com>
 <ZgFTtAOw39tIyfzR@gmail.com>
 <3c92c18b-6a19-4477-9972-1219c29b3d71@linux.ibm.com>
 <ZgKApcWeuwxc2+WO@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <ZgKApcWeuwxc2+WO@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IwtaeeRy4nQ0AXIyR4dNGkLzgOnYFdUD
X-Proofpoint-ORIG-GUID: ZBQXITSR5lVcSmpSh3qNzp0UgmxNE45W
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
 definitions=2024-03-27_02,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270037



On 3/26/24 1:30 PM, Ingo Molnar wrote:
> 
> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> 
>>
>>
>> On 3/25/24 4:06 PM, Ingo Molnar wrote:
>>>
>>> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>>
>>>> v2 -> v3:
>>>> - Wrapped check for value change inside ser_rd_overload_status
>>>>   as suggested by Qais.
>>>> - Added reviewed-by tags.
>>>>
>>>> v1 -> v2:
>>>> - dropped Fixes tag.
>>>> - Added one of the perf probes in the changelog for reference.
>>>> - Added reviewed-by tags.
>>>>
>>>> tl;dr
>>>> When running workloads in large systems, it was observed that access to
>>>> rd->overload was taking time. It would be better to check the value
>>>> before updating since value changes less often. Patch 1/2 does that.
>>>> With patch updates happen only if necessary. CPU Bus traffic reduced a
>>>> bit. No significant gains in workload performance.
>>>
>>> Could you please post this against the latest scheduler tree, ie. tip:sched/core?
>>>
>>> Thanks,
>>>
>>> 	Ingo
>>
>> Hi Ingo. I had mentioned the same in cover letter. Sorry if I didn't 
>> mention it in the correct place. 
>>
>> *These patches depend on below to be applied first*
>> https://lore.kernel.org/all/20240307085725.444486-1-sshegde@linux.ibm.com/
>>
>> After that the above patch would apply.

Hi Ingo. 

These two patches apply cleanly now to sched/core. 

7a9dd7ef946c (HEAD -> sched/core) sched/fair: Use helper functions to access rd->overload
4f24aa918558 sched/fair: Check rd->overload value before update
c829d6818b60 (origin/sched/core) sched/fair: Simplify the continue_balancing logic in sched_balance_newidle()
d0f5d3cefc25 sched/fair: Introduce is_rd_overutilized() helper function to access root_domain::overutilized


> 
> OK, I missed that, but I don't really like patch #3 of that other series, 
> so we'll need to address that first.
> 

That will be a standalone patch now and can go later based on the discussions. 

> Thanks,
> 
> 	Ingo

