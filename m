Return-Path: <linux-kernel+bounces-118598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0F888BD16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A35EB220E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54FE41740;
	Tue, 26 Mar 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tt+HzGbj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025863FB1D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443676; cv=none; b=Hm+YjM3ecQfgUX13eV8RHmF4ZF50MmkqZvXwPDQroOfI9f5eaxCbvcIyMlZsccR+9KIwnBnmKFcRyyciZ9SsrdCyMUQDzD3t+Gy61JAjdwuslb1/rZZBEXfHOjCsXzPFjhvfSbmtBRMDkTLUXulOD+7o8dsz+59heir0WUAAoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443676; c=relaxed/simple;
	bh=XMllxASyUUpm/HYNpi1plVabSHtZgVInVdQq9jkOEKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqWuLiM0OMHpfXmgC3zW5NjMSt3ehTdmImayknF79lwSjIxeU+hft7WrgqNzUbHzLhCsWNHQjfhcNKYlO2WNpcq5UarcyrALtvT4O9mM2f9utF6KZrOAym3YKgOGpDdRcYFc+25+DSfX8uzojEkWSw8D5PskhZ/SqluFy0a7qao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tt+HzGbj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q8Rme5024659;
	Tue, 26 Mar 2024 09:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IJ/NNPdHFnh+ZIxqDWq0+7h9aFMvd04jLhyj0AH3uSQ=;
 b=tt+HzGbjEYQANoKhHdsuUT5ML8yGsXSkLiXeSyNqA/elCIgNcZiLA1pGgS+o99XLBpKa
 4BTkWe7QTcBjfUEBtCiE4DG6cwpKqLHGEBgQTJ5qecU5CdqN1PtOtaYheolB8jETsXGD
 jASF/6rqRtQO/L3LKrYtZjK4BlmruWm4rnR1OUN0eW0/NTc4qAgKnYw7RdtmbbZnEgCK
 a/9C2g6NvyfzVvkVv6UlqJR6U2IXYLMft42MsmCkG0O3ADSuQFmmAoyWcoWwbj8ihxcZ
 RnRxlqLwX1ts0ty+2vsP5vdgoYlCUmfbPwkO0zLBfAd7Yqj+++WvKx+xnEy8akNEq7VH ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3tv2g2kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 09:00:41 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42Q90epF018573;
	Tue, 26 Mar 2024 09:00:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3tv2g2kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 09:00:40 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q6W9kT025481;
	Tue, 26 Mar 2024 09:00:39 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2awmpk2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 09:00:39 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42Q90a7x46006726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 09:00:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B114B5806E;
	Tue, 26 Mar 2024 09:00:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F22F458070;
	Tue, 26 Mar 2024 09:00:31 +0000 (GMT)
Received: from [9.79.190.64] (unknown [9.79.190.64])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 09:00:31 +0000 (GMT)
Message-ID: <7e6789d6-1e85-4945-8a7b-02cadc95cfa5@linux.ibm.com>
Date: Tue, 26 Mar 2024 14:30:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Simplify continue_balancing for newidle
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, linux-kernel@vger.kernel.org, vschneid@redhat.com,
        joshdon@google.com, riel@surriel.com
References: <20240325153926.274284-1-sshegde@linux.ibm.com>
 <ZgKCXrUbBIxp6+mu@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <ZgKCXrUbBIxp6+mu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: au4vibnv6RhbUaZe8WI-8sYv9PQ7eWHK
X-Proofpoint-ORIG-GUID: mMBKNlIqD4mp5sBndtS9IeoA7ZQWBaBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260060



On 3/26/24 1:37 PM, Ingo Molnar wrote:
> 
> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> 
>> newidle(CPU_NEWLY_IDLE) balancing doesn't stop the load balancing if the
>> continue_balancing flag is reset. Other two balancing (IDLE, BUSY) do
>> that. newidle balance stops the load balancing if rq has a task or there
>> is wakeup pending. The same checks are present in should_we_balance for
>> newidle. Hence use the return value and simplify continue_balancing
>> mechanism for newidle. Update the comment surrounding it as well.
> 
> Assuming there are no side-effects to balancing behavior.

I ran hackbench. More or less same results with patch. But thats very 
limited set of benchmarks. Let me do some more testing with it and send the 
results. 

> 
>> No change in functionality intended.
> 
> Is this actually true? Any change to behavior invalidates such a sentence.

From what i think, code path is same and I don't see any functionality changing. 
Correct me if i am wrong. 

Currently, sched_balance_newidle does the same check to bail out as the
should_we_balance check in case of newidle.  i.e  

should_we_balance
	if (env->dst_rq->nr_running > 0 || env->dst_rq->ttwu_pending)
			return 0;

sched_balance_newidle
		if (pulled_task || this_rq->nr_running > 0 ||
			this_rq->ttwu_pending)
			break;
		}

> 
>>  	/*
>> +	 * We must set idle_stamp _before_ calling sched_balance_rq()
>> +	 * for CPU_NEWLY_IDLE, such that we measure the this duration
>> +	 * as idle time.
>>  	 */
> 
> 'the this' ...?

Sorry for the typo. it should be.
"such that we measure this duration as idle time"

> 
> Thanks,
> 
> 	Ingo

