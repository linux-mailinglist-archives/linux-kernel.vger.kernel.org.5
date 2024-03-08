Return-Path: <linux-kernel+bounces-97598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF11876C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0755C1C21034
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC25FB81;
	Fri,  8 Mar 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OcQ2gZG9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7FF53373;
	Fri,  8 Mar 2024 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933193; cv=none; b=cjVTfKamYqmB8e9YGawcMmKz87Cnu6dxcSe7zW2DAU/T7buy1kNXWGeEc0Z7vMFU0IgVIIsVxuBiKGhizn03CKVN0KvZTr4lvMX+ANX44tAbzJb0wxkK/XO7jg6lngknwBRCQCf7vZ8Hr5eJ+PhbnOuXCDaJhNh854bTCkWbDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933193; c=relaxed/simple;
	bh=TtftsKrq64OL+gn3neLgZsHm14djxEaeQKGGyi5rUOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwozFpgoEcNqy9vwNezzZOL8k3Eq/un/1L4X496DukrovIoroPdZjJqbfDOzFhGu4epKv54xa9B4f80u8G4COOfu0fJSvNPAz60Lq4sEmd7BQE0vn+r4TJemnBJZsdTVr95RkMwDwlnHagwFbC8i5bkMHLlOWPo8I6uSiHqBvLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OcQ2gZG9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428LM1tu004777;
	Fri, 8 Mar 2024 21:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=s0gkiRNbL6HNjdy/CztATN5tw8vtyHslfldPjeW+FVE=;
 b=OcQ2gZG9vzn+KBzfpWPwbWrp7wjpm0FCxpNKraU9rfDyOK7FoJA7GQ8pa5gubZpuga3B
 EDRUozHwTe93A9Sln9uGjzakEIhKIYS+hCwaKX560qnv7icCMtkxAgyRslGnopRL/O4e
 ZKH9P9tC7UP29FKhg4IRXtFvVy5vfVgg297ZTNenLqCHacobD9r6aaMEjmXLfb+0NbJ4
 svizvgigTceh/n52CSSPETzpVjSTQFmrYRfhitarVLtiTNV7P/zp2lG9ohDfbRtefyVY
 4NOMUuH8ulvpQZM+lGog/cuGl5j/nckpFLp3CcS0ORlW6v8b12RWruyvXsHmH+q+ohur kA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wraav8637-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 21:26:13 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428LPDdX016123;
	Fri, 8 Mar 2024 21:26:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wraav862v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 21:26:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428JsfXZ026296;
	Fri, 8 Mar 2024 21:26:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfepf16d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 21:26:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428LQ9L743057558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 21:26:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2799058063;
	Fri,  8 Mar 2024 21:26:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 839CF5805A;
	Fri,  8 Mar 2024 21:26:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 21:26:08 +0000 (GMT)
Message-ID: <5a980105-b148-4e4e-9a6e-7905e5598b7e@linux.ibm.com>
Date: Fri, 8 Mar 2024 16:26:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/prom_init: Replace linux,sml-base/sml-size
 with linux,sml-log
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jarkko@kernel.org, rnsastry@linux.ibm.com, peterhuewe@gmx.de,
        viparash@in.ibm.com
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-2-stefanb@linux.ibm.com> <87jzmenx2c.fsf@mail.lhotse>
 <20240307215214.GB3110385-robh@kernel.org>
 <851536a5-ad8f-4d65-8c33-707e2fe762df@linux.ibm.com>
 <20240308205751.GA1249866-robh@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240308205751.GA1249866-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7q-L3xuWuOOMUzbxJJqSYGId0nLfueMR
X-Proofpoint-ORIG-GUID: 6Wjl17oKeA-UIxLKOhsgiWygrA9LW2Kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403080169



On 3/8/24 15:57, Rob Herring wrote:
> On Fri, Mar 08, 2024 at 07:23:35AM -0500, Stefan Berger wrote:
>>
>>
>> On 3/7/24 16:52, Rob Herring wrote:
>>> On Thu, Mar 07, 2024 at 09:41:31PM +1100, Michael Ellerman wrote:
>>>> Stefan Berger <stefanb@linux.ibm.com> writes:
>>>>> linux,sml-base holds the address of a buffer with the TPM log. This
>>>>> buffer may become invalid after a kexec and therefore embed the whole TPM
>>>>> log in linux,sml-log. This helps to protect the log since it is properly
>>>>> carried across a kexec with both of the kexec syscalls.
>>>>>
>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>> ---
>>>>>    arch/powerpc/kernel/prom_init.c | 8 ++------
>>>>>    1 file changed, 2 insertions(+), 6 deletions(-)
>>>>>
>>
>>>
>>>
>>>> Also adding the new linux,sml-log property should be accompanied by a
>>>> change to the device tree binding.
>>>>
>>>> The syntax is not very obvious to me, but possibly something like?
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>>>> index 50a3fd31241c..cd75037948bc 100644
>>>> --- a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>>>> +++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>>>> @@ -74,8 +74,6 @@ required:
>>>>      - ibm,my-dma-window
>>>>      - ibm,my-drc-index
>>>>      - ibm,loc-code
>>>> -  - linux,sml-base
>>>> -  - linux,sml-size
>>>
>>> Dropping required properties is an ABI break. If you drop them, an older
>>> OS version won't work.
>>
>> 1) On PowerVM and KVM on Power these two properties were added in the Linux
>> code. I replaced the creation of these properties with creation of
>> linux,sml-log (1/2 in this series). I also replaced the handling of
>> these two (2/2 in this series) for these two platforms but leaving it for
>> powernv systems where the firmware creates these.
> 
> Okay, I guess your case is not a ABI break if the kernel is populating
> it and the same kernel consumes it.
> 
> You failed to answer my question on using /reserved-memory. Again, why

I am not familiar with /reserved-memory and whether it is supported on 
the targeted platforms.


