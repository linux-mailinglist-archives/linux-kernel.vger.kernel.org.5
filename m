Return-Path: <linux-kernel+bounces-104202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C795E87CA9D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC7A9B20D89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F30417C74;
	Fri, 15 Mar 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h6qLCyfU"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC117C66
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494457; cv=none; b=CgRrZ2xgxj8BayVdLt8+UkfmDuW0/0nhTtfHSXDxDoMy5fA/USF7NzTOSIXFTLPHzwOnhUgr/36+5+UJBUf4cKePO4iHrdl2sELiBk0sHQicyzev9G317eRZKGVIaquutC16jb5hBDhC1A+smqg7hZ52VNNvfm/x1cO/3QsY27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494457; c=relaxed/simple;
	bh=MMyl2VJmuAhURiMGWl8UnQ7eqLCi9Tg3DQdqDfPp4wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G67rgYCjNvKoPW7sLHQQWQgQBMQaIN4xygzOJEUMPegalc9lH/hSQoyXVgQ3KDpHhB8SM25kuFiKP9KXqFvJGI37WTwpvNpcgFCHOjwhZEnLhM0R2xVSJgFSPSY+t9VOLx3RJ7IN/znBMthHEkvRpSrh1H3NT8bz5sXCpQ+KBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h6qLCyfU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42F88EAK012926;
	Fri, 15 Mar 2024 09:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wg/BUKERLwP/z9R2x2jPaOO/GkMtdw1xQM3HNnqODDU=;
 b=h6qLCyfUijiEFns2cy/Rz+w3N1h9WzErLBJ/HzUxWW+A0fsPkJUkb+uMxOpn3XIr9CQP
 L6xrEu8zqkE+CBTnciBeQAomAuy2fU91KjjOJkIKydgWVp6+pmxfuw77R4r94cvInqdd
 WhJbIyg7FST0MfRRfNuhPeNGZtBmFvers7OIP3+dTUSDAD4DZclyfCCRzlU+7X2ImcUG
 P5ex4QhLCAQjFAKa6BIUYz+nOjcRhwk/tUQPOPgBRwECNE/4GtKjUcF4O/ZBPMwlhiaD
 Ui2+tmq+n/KFDlL2u7itZpcQhPamXJJ4EbQ572ULan4JPI7UC78OSZ+KFvF/aZoEeSqb 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvjhygtj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 09:20:42 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42F8lbnZ022030;
	Fri, 15 Mar 2024 09:20:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvjhygthw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 09:20:41 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42F7D1O6014861;
	Fri, 15 Mar 2024 09:20:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33pawvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 09:20:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42F9KcAS46793102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 09:20:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00C9058066;
	Fri, 15 Mar 2024 09:20:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CCB458063;
	Fri, 15 Mar 2024 09:20:35 +0000 (GMT)
Received: from [9.124.31.199] (unknown [9.124.31.199])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 09:20:34 +0000 (GMT)
Message-ID: <40325480-238a-4839-98e5-018e1890ab78@linux.ibm.com>
Date: Fri, 15 Mar 2024 14:50:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] sched/debug: Increase SCHEDSTAT_VERSION to 16
To: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann
 <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@kernel.org>
References: <20240308105901.1096078-1-mingo@kernel.org>
 <20240308105901.1096078-5-mingo@kernel.org>
 <14d29fdf-ef10-48e6-a102-f1f0bb27c181@linux.ibm.com>
 <ZfAoEmH6KRhjyUor@gmail.com> <ZfKJaztM0FhKRmjg@BLR-5CG11610CF.amd.com>
 <66f1e42c-9035-4f9b-8c77-976ab50638bd@amd.com>
 <d5a53c05-6ff3-4bb3-96e0-b8865bd81611@linux.ibm.com>
 <07b35339-c369-4c5c-b5a5-b557fdaa5827@amd.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <07b35339-c369-4c5c-b5a5-b557fdaa5827@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nBlH09aSFUn6cN9YBQa5gqfOLt1aCoTZ
X-Proofpoint-GUID: lRLJoz4c3eL00LlaoCw7dKl-ZJt1s8-M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150075



On 3/15/24 2:36 PM, Swapnil Sapkal wrote:
> Hello Shrikanth,
> 
> Thank you for reviewing.
> 
> On 3/15/2024 10:07 AM, Shrikanth Hegde wrote:
>>

>>> 19 20
>>> 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
>>> +domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
>>> 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43
>>> 44 45
>>>     The first field is a bit mask indicating what cpus this domain
>>> operates
>>> over.
>>>   
>> IIUC, this is editing the content of Version 15, But changes would
>> happen on Version 16.
>> Instead can we add the section for Version 16 and not modify for 15?
> 
> This file contains the field details of current schedstat version and
> the short
> summary of what change across the versions. Maintaining each versions
> details will
> increase the file size. Instead I will add the links to previous version's
> documentation.
>  

I hadn't seen that. what you are saying is right. it would bloat up.  

> Thoughts on this?
> 
>>> -The next 24 are a variety of sched_balance_rq() statistics in grouped
>>> into types
>>> +The next 33 are a variety of sched_balance_rq() statistics in grouped
>>> into types
>>>   of idleness (idle, busy, and newly idle):

Please change this to
 of idleness (busy, idle, and newly idle): 

>>>         1)  # of times in this domain sched_balance_rq() was called
>>> when the
>>> +        cpu was busy
>>> +    2)  # of times in this domain sched_balance_rq() checked but
>>> found the
>>> +        load did not require balancing when busy

