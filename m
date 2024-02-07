Return-Path: <linux-kernel+bounces-56167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A475E84C6E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63891C23869
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138D520B34;
	Wed,  7 Feb 2024 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nRZgvTgz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663A208D6;
	Wed,  7 Feb 2024 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296903; cv=none; b=O8YTllcoTs+i4WeiHRZ2XBLUG2Fbq6L/2RXf63TxcmXIXbyj152LacZ1OTdRWHuxzTKQ/a6z2o8RQRGjJtgkXo8BY3AA+mVL+h/SDmoRwNoGyS+Ehej/ZQJV6sWaPAjWH6r38zO/9tQAAphOEotIkwQL/klFL4Yacvenliy9hQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296903; c=relaxed/simple;
	bh=zQcmyPzidh2ULzN2fhkznfu/Jvo6esPfod05O3lf1Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ou21LdUNEzYi65FPPbzjgnF4vsDa2T+loQ0iCMPXLBs1HudmTitZQyIHrn2JEIlk5Cx+eXUVW9gcRqI3/tcFHCxTUreIS5FUGQyZyIMHRmyFBQJ0oc5JNUd32W68WK8EhzfKxJ+Ng1xlFLyOERP3NfoTMAyVdxocZuOz2306wn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nRZgvTgz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41792Gog032577;
	Wed, 7 Feb 2024 09:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=h+biz4tUuljiF+ayL/YbyRBen4Dw0b9YaXGCt/2B6uM=;
 b=nRZgvTgz2uIJXskW8SRj6EHIDglstjXOqwydsOxRZjJ+baGngp1t6YsoXcywhlwamOTp
 1U7c0UBq+frTDFjzgFDAkvGJynCxqT/myr3mbWeomo1vICa4fxYbZX7QC8y9OxiLKXTB
 6ppq+fRSwXh6076Mr5dewQH+jUghjE8Sc/TQIOsEGuqsqRP2e2X8wVvbuZElKzToXlr3
 E3twHXIsrvYrYt/5b9sjTyHjLKJ+FskqRRK2B/SgTfGYKahqdQt1NeT0OkkJRgnyMOsF
 QTfJFNctOrTljf/+agFPdtKVe8GZOqseEMnsggNRglvMLD6AD6DQz44cr6fsz5QCMMly Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w46vgg4hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 09:08:16 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41792LER000358;
	Wed, 7 Feb 2024 09:08:15 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w46vgg4h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 09:08:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4176Mods020371;
	Wed, 7 Feb 2024 09:08:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytt50w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 09:08:14 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41798D0q6554116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Feb 2024 09:08:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6F035805C;
	Wed,  7 Feb 2024 09:08:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 857E658054;
	Wed,  7 Feb 2024 09:08:10 +0000 (GMT)
Received: from [9.171.63.25] (unknown [9.171.63.25])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Feb 2024 09:08:10 +0000 (GMT)
Message-ID: <2cfe62d4-b903-46aa-bcc3-26e1786f7cc1@linux.ibm.com>
Date: Wed, 7 Feb 2024 10:08:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>,
        Alexandra Winter
 <wintera@linux.ibm.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <f98849a7-41e9-421b-97b7-36d720cc43ee@linux.alibaba.com>
 <20a1a1f3-789a-4d91-9a94-dca16161afd7@linux.ibm.com>
 <1860588f-2246-4dcd-9db5-4ccd7add0f4a@linux.alibaba.com>
 <3c51c969-3884-4104-b38d-570c61525214@linux.ibm.com>
 <47c1b777-6d4e-40ac-9297-61240c126d6a@linux.alibaba.com>
 <a29ead38-7a39-4bbb-80cc-619c1b0dfd62@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <a29ead38-7a39-4bbb-80cc-619c1b0dfd62@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AiVMsJyngXP4eYc6Cv8d172WmThcBFdi
X-Proofpoint-ORIG-GUID: dMWmfPKEniCtuTfKAx4QvYiEWbrHUKi0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 mlxlogscore=755 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402070067



On 05.02.24 11:05, Wen Gu wrote:
> 
> On 2024/1/24 14:33, Wen Gu wrote:
>>
>>
>> On 2024/1/23 22:03, Alexandra Winter wrote:
>>> Hello Wen Gu and others,
>>>
>>> I just wanted to let you know that unfortunately both Wenjia and Jan 
>>> have called in sick and we don't know
>>> when they will be back at work.
>>> So I'm sorry but there may be mroe delays in the review of this 
>>> patchset.
>>>
>>> Kind regards
>>> Alexandra Winter
>>
>> Hi Alexandra,
>>
>> Thank you for the update. Health comes first. Wishing Wenjia and Jan
>> both make a swift recovery.
>>
>> Best regards,
>> Wen Gu
> 
> Hi, Wenjia and Jan
> 
> I would like to ask if I should wait for the review of this version
> or send a v2 (with some minor changes) ?
> 
> Thanks!

Hi Wen,

Finally I can carve out some time on this patches, the review is still 
ongoing. I'll send my comments out, as soon as I finish all of them.

Thank you for the patience!
Wenjia

