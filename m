Return-Path: <linux-kernel+bounces-35420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296208390C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9AF1F22BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8295F861;
	Tue, 23 Jan 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J5wf3pnt"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F85F563;
	Tue, 23 Jan 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018602; cv=none; b=aMhqIv58vkNs4mHjM1T+GjFoNVVUzEAGoxtoZxJJ/e3xS4MC32i8qS6zRIEvNeiVJ1pRFGyuUpnMhqgIXS8/MpyQf1dEHUWLrqQziIrjWggcRfv+Vw7dWeeK9dYj0UPn7JAgRNQKnQoaCy1x9eEUSozm6P2teIvjJilh4BADQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018602; c=relaxed/simple;
	bh=hlKrbnklZRHtyhAfgwLZQF2nt4+9pCu/Iy9MfEcp0IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VharcbwWajpjQGr8nYnuoiAqs0aJznWI7R5vpo5NbkBZjDC7pR/kya7egwJrgiPofQH7wLWkOmWmOwp94bqWjbovjBACWLrV9ipk1V29aYnAQT+exTgKdm1WCi6lbzEupxtNUMlC8R5avWKHVAEczrt/kfK67uI74Dw76dv4/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J5wf3pnt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NDrToc024811;
	Tue, 23 Jan 2024 14:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JtE9UsiqiWfdyi4MV6/bGG5MDHlb4VIcfi2PP2a34vw=;
 b=J5wf3pntzgos836U9Igqyp65p1eHWSa4rnwQ8WXisVURXzm8AUL0QOU5TaLMCRTreB61
 c3sY7pPhfuwPc0aT6XuXmNflGahMwdUFXO5NJd4dToNrhHO9iNd5XZUJTEebYp0PQhcs
 2Hj3LiHo1m9qZCaTzwGW7S+Upx6sqdD62KCd0Tms7rEPYTTAy1bW5M7CJ0XoIcmo0aaX
 1/fy1FWabQCdLlOYemdAIqVxJe7AYFM8p0+ojDa0zQts8xCjef6GUhq0OMeotihkHcuy
 xs5YlA3bhCMAPU4IohXVYFMdGo9Tqp9IfmiVC/Kx6zxOVtOqsjty5vKiWEOE+3B1rA3t Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vteqwr9a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 14:03:10 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40NDs7LK026468;
	Tue, 23 Jan 2024 14:03:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vteqwr99g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 14:03:09 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40NBX7Mm026508;
	Tue, 23 Jan 2024 14:03:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgt7s09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 14:03:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40NE35Vl56295866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 14:03:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9A892007B;
	Tue, 23 Jan 2024 14:03:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AD0920078;
	Tue, 23 Jan 2024 14:03:05 +0000 (GMT)
Received: from [9.152.224.38] (unknown [9.152.224.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jan 2024 14:03:05 +0000 (GMT)
Message-ID: <3c51c969-3884-4104-b38d-570c61525214@linux.ibm.com>
Date: Tue, 23 Jan 2024 15:03:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
To: Wen Gu <guwen@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <f98849a7-41e9-421b-97b7-36d720cc43ee@linux.alibaba.com>
 <20a1a1f3-789a-4d91-9a94-dca16161afd7@linux.ibm.com>
 <1860588f-2246-4dcd-9db5-4ccd7add0f4a@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1860588f-2246-4dcd-9db5-4ccd7add0f4a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SSW86zNU0u0yqe7OCema3jFlkIu8Ysiz
X-Proofpoint-ORIG-GUID: COMkbAp-6ED6dcEelzULVI7hCHml2eV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_06,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=649 adultscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230103



On 19.01.24 02:46, Wen Gu wrote:
> 
> 
> On 2024/1/18 21:59, Wenjia Zhang wrote:
>>
>>
>> On 18.01.24 09:27, Wen Gu wrote:
>>>
>>>
>>> On 2024/1/11 20:00, Wen Gu wrote:
>>>> This patch set acts as the second part of the new version of [1] (The first
>>>> part can be referred from [2]), the updated things of this version are listed
>>>> at the end.
>>>>
>>>
>>> Hi Wenjia and Jan, I would appreciate any thoughts or comments you might have
>>> on this series. Thank you very much!
>>>
>> Hi Wen,
>>
>> I'm still in the middle of the proto type on IPPROTO_SMC and other issues, so that I need more time to review this patch series.
>>
>> Thank you for your patience!
>> Wenjia
> 
> Understood. Thank you! Wenjia.
> 
> Best regards,
> Wen Gu
> 

Hello Wen Gu and others,

I just wanted to let you know that unfortunately both Wenjia and Jan have called in sick and we don't know
when they will be back at work. 
So I'm sorry but there may be mroe delays in the review of this patchset.

Kind regards
Alexandra Winter

