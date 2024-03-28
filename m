Return-Path: <linux-kernel+bounces-122934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD78C88FFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8FF1F257FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359F7EF13;
	Thu, 28 Mar 2024 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SZ9i9kI+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F852F6F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630768; cv=none; b=nPTIyiS9MfcT856xoAVgVBCbBpF7YSpR42l8JfNjgMaXyHUkprrtiZhHZZo8mq5TJQTZ9kJPwZQLq7s2MQDl8sCJfk3SIu+YIrHDD5xA9TLaVLyxDLiHDBf5h/zjSZr6NsinLsYVYTDzxMZhXPOTG60hLleKV14arTujAcS62kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630768; c=relaxed/simple;
	bh=VoNwYI0BpMUamtvxeLEmRm86/HziZqT+7mbcMtBT4aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0IcW/6wNS3Aqltgc4whMSJPEC8SF/BAbTMM6lRyieFvv8/2Uwv80hppD+AVo5EhcmqYhDf+h5hrOJRpXkB8Zloe3pBHhZXFUxxbwgjpnpM2uW8h8cmSxKlFcA/4v50qyWxw5Fkex/VTSbt1KZOOqaO+lL7SCdjrd6xCcObPPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SZ9i9kI+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SC0CNG001805;
	Thu, 28 Mar 2024 12:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5vaAlGKoMasCss0O/Zs1kybRjPorfY06TxnoBIa4oKI=;
 b=SZ9i9kI+MiHYMeEKGnkAdkyyEKf9n+N7xaDXcZ4owj6GVIa75pSCqCdtHL5nZCyE5Ok2
 9eTkfybFmYlK8x6aefKzrb8oG5BGt8KwaN3jtuXHr27eb+GncVJVAzGqaXYjXqEWI4nR
 u9QUPRixo5PxEBQja2m7o7nO62Lv58AJZV0atgIepcHTvUpdp7/0DQaEClYxCXMFDM0x
 a839hPgEyYa1vdQte1MYHWu8wjgh4jbUX7ICCa/+gjOnzJB3xHvz9zJFjGRdj0PbGNo1
 K8SLR83VHIYlvjGBK51T9/uQQG+rFmrq0Kowm5VdsiCwMsI7YTwyP498zwM2dPjOs/K0 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5829g521-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 12:59:10 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SCx9ei012223;
	Thu, 28 Mar 2024 12:59:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5829g51t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 12:59:09 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42SAftkE028685;
	Thu, 28 Mar 2024 12:59:08 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adpnhsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 12:59:08 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42SCx6aa24183318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 12:59:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E35C58059;
	Thu, 28 Mar 2024 12:59:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C701C5805F;
	Thu, 28 Mar 2024 12:59:03 +0000 (GMT)
Received: from [9.79.190.254] (unknown [9.79.190.254])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 12:59:03 +0000 (GMT)
Message-ID: <d0a7eebf-eab0-4a8d-b1bb-b4cbc9da18b8@linux.ibm.com>
Date: Thu, 28 Mar 2024 18:28:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] sched: Minor changes for rd->overload access
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, linux-kernel@vger.kernel.org, vschneid@redhat.com
References: <20240325054505.201995-1-sshegde@linux.ibm.com>
 <ZgFTtAOw39tIyfzR@gmail.com>
 <3c92c18b-6a19-4477-9972-1219c29b3d71@linux.ibm.com>
 <ZgKApcWeuwxc2+WO@gmail.com>
 <38c39ea6-21df-44e9-96e7-6f6fd35822a7@linux.ibm.com>
 <ZgVHq65XKsOZpfgK@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <ZgVHq65XKsOZpfgK@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pTvmYwOe2dICIwkoa57mg-DdUCA-w5-P
X-Proofpoint-GUID: G_07Evd_MSLo-9-taBEhCJvm70RIpAU_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_13,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403280088



On 3/28/24 4:04 PM, Ingo Molnar wrote:
> 
> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> 

>>
>> Hi Ingo. 
>>
>> These two patches apply cleanly now to sched/core. 
>>
>> 7a9dd7ef946c (HEAD -> sched/core) sched/fair: Use helper functions to access rd->overload
>> 4f24aa918558 sched/fair: Check rd->overload value before update
>> c829d6818b60 (origin/sched/core) sched/fair: Simplify the continue_balancing logic in sched_balance_newidle()
>> d0f5d3cefc25 sched/fair: Introduce is_rd_overutilized() helper function to access root_domain::overutilized
> 
> I've applied them, but note that there were quite a few avoidable typos 
> and grammar mistakes in the changelogs. Please always review what 
> you've submitted versus what I have applied and try to learn from that: 
> I almost invariable have to edit some detail to make the changelog more 
> presentable... Could you please take more care with future patches?
> 

Noted. 
I will learn for it, thank you. 

> I also renamed the accessor functions in the second patch to:
> 
>       get_rd_overload()
>       set_rd_overload()
> 
> Plus I've applied a patch to rename ::overload to ::overloaded. It is 
> silly to use an ambiguous noun instead of a clear adjective when naming 
> such a flag ...
> 

sure. looks fine.

> Thanks,
> 
> 	Ingo

