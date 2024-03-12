Return-Path: <linux-kernel+bounces-100702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF2879C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E44FB21FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E432142636;
	Tue, 12 Mar 2024 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OJEo1Z/T"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B87E761;
	Tue, 12 Mar 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710270946; cv=none; b=PksDX7btnmc84WvLZgBh/vPzrI+xBm3WJGQk5slq2shIprg+KOZKro1Z5KGbfY+MpDbixbD5sw6xC6wDhFa6yzlwHgLgsyo5+A2dzK1N1MdUHx5NRjjnoJiMNycACRqF9mXlblNiJBVIpjtM86wwlfkfDpemJ9tUvu7+PKZQMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710270946; c=relaxed/simple;
	bh=frM7ZZicoOtQ6mKh8XzvL++PzOgKMg5Bqtz7F1aYL7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/LI02qjrOFccH6auP0ALKxrJXqCc+CW09C2NM4KSq0WqnTtS62mmWR300z3tnCjW6zbz2O7yfotLNE/fyOd0I0JklZacouRaO6+MGSc2uFWLwUfLN3uI0m8xIMdM9XQI8mcgAVN8Xm3WmsafM0tIcpbr+G4FicnN9BCuXss2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OJEo1Z/T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CJE0tJ003514;
	Tue, 12 Mar 2024 19:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Bqj5VRWaXPhFMckcrpeR0VkZPiw8NIJQSgfyWB6iOcg=;
 b=OJEo1Z/TV12t5dkLUGKFqTmLIlce0EtDIw79/iTDaruf5OC84ZjXNKo+A7VR0XaesGRQ
 YxmiHNHLfJ8VDmTaGFOVQfFVC8sj5Qb7mPPvMqzfnYgCwuiGEr8oQLmPbV5UbLC4PrQw
 BFp/O99sggxj+Qhle1wnKBGDhhMd3LfWdKvQq1DH/vdzRislvcTbnnG2xrTbwhtQIw9T
 bBWIgcQeQrR1IFs6vVk1KqZJyf/aYiSCV48i9vPbqasFfnxQ30Jh92bbM+F9CVvh6n1L
 PuxL8/ca56mX3ODNgaXqMkIbr5ZA1xSJzHKef1fp2+NR+GBO/mApnvAzxWifUhJHlS+e MA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtw0u00wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 19:15:31 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42CJF4JI005699;
	Tue, 12 Mar 2024 19:15:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtw0u00wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 19:15:31 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42CH4Eqb018119;
	Tue, 12 Mar 2024 19:15:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23t9bd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 19:15:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42CJFRff49873186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 19:15:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52CB25806E;
	Tue, 12 Mar 2024 19:15:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E2CC58059;
	Tue, 12 Mar 2024 19:15:26 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 19:15:26 +0000 (GMT)
Message-ID: <9d4aeb9e-4fd3-412b-92ed-55db2ca705d2@linux.ibm.com>
Date: Tue, 12 Mar 2024 15:15:25 -0400
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
To: Rob Herring <robh@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, jarkko@kernel.org,
        rnsastry@linux.ibm.com, peterhuewe@gmx.de, viparash@in.ibm.com
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-2-stefanb@linux.ibm.com> <87jzmenx2c.fsf@mail.lhotse>
 <20240307215214.GB3110385-robh@kernel.org>
 <851536a5-ad8f-4d65-8c33-707e2fe762df@linux.ibm.com>
 <20240308205751.GA1249866-robh@kernel.org> <87a5n34u5p.fsf@mail.lhotse>
 <20240312162238.GA2308643-robh@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240312162238.GA2308643-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lFqjDeovyX4N3whwNuAMgBjIOckPpnE2
X-Proofpoint-ORIG-GUID: hwuLMc5BarZQaCBhAqJtEdumC_AqrOph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_12,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120147



On 3/12/24 12:22, Rob Herring wrote:
> On Tue, Mar 12, 2024 at 09:32:50PM +1100, Michael Ellerman wrote:
>> Rob Herring <robh@kernel.org> writes:
>>> On Fri, Mar 08, 2024 at 07:23:35AM -0500, Stefan Berger wrote:
>>>> On 3/7/24 16:52, Rob Herring wrote:
>>>>> On Thu, Mar 07, 2024 at 09:41:31PM +1100, Michael Ellerman wrote:
>>>>>> Stefan Berger <stefanb@linux.ibm.com> writes:
>>>>>>> linux,sml-base holds the address of a buffer with the TPM log. This
>>>>>>> buffer may become invalid after a kexec and therefore embed the whole TPM
>>>>>>> log in linux,sml-log. This helps to protect the log since it is properly
>>>>>>> carried across a kexec with both of the kexec syscalls.
>>>>>>>
>>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>>>> ---
>>>>>>>    arch/powerpc/kernel/prom_init.c | 8 ++------
>>>>>>>    1 file changed, 2 insertions(+), 6 deletions(-)
>>>>>>>
>>>>
>>>>>
>>>>>
>>>>>> Also adding the new linux,sml-log property should be accompanied by a
>>>>>> change to the device tree binding.
>>>>>>
>>>>>> The syntax is not very obvious to me, but possibly something like?
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>>>>>> index 50a3fd31241c..cd75037948bc 100644
>>>>>> --- a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>>>>>> @@ -74,8 +74,6 @@ required:
>>>>>>      - ibm,my-dma-window
>>>>>>      - ibm,my-drc-index
>>>>>>      - ibm,loc-code
>>>>>> -  - linux,sml-base
>>>>>> -  - linux,sml-size
>>>>>
>>>>> Dropping required properties is an ABI break. If you drop them, an older
>>>>> OS version won't work.
>>>>
>>>> 1) On PowerVM and KVM on Power these two properties were added in the Linux
>>>> code. I replaced the creation of these properties with creation of
>>>> linux,sml-log (1/2 in this series). I also replaced the handling of
>>>> these two (2/2 in this series) for these two platforms but leaving it for
>>>> powernv systems where the firmware creates these.
>>>
>>> Okay, I guess your case is not a ABI break if the kernel is populating
>>> it and the same kernel consumes it.
>>>
>>> You failed to answer my question on using /reserved-memory. Again, why
>>> can't that be used? That is the standard way we prevent chunks of memory
>>> from being clobbered.
>>
>> Yes I think that would mostly work. I don't see support for
>> /reserved-memory in kexec-tools, so that would need fixing I think.
>>
>> My logic was that the memory is not special. It's just a buffer we
>> allocated during early boot to store the log. There isn't anything else
>> in the system that relies on that memory remaining untouched. So it
>> seemed cleaner to just put the log in the device tree, rather than a
>> pointer to it.
> 
> My issue is we already have 2 ways to describe the log to the OS. I
> don't see a good reason to add a 3rd way. (Though it might actually be a
> 4th way, because the chosen property for the last attempt was accepted
> to dtschema yet the code has been abandoned.)

I have a revert for this in my tree...

> 
> If you put the log into the DT, then the memory for the log remains
> untouched too because the FDT remains untouched. For reserved-memory
> regions, the OS is free to free them if it knows what the region is and
> that it is no longer needed. IOW, if freeing the log memory is desired,
> then the suggested approach doesn't work.

The log, once embedded in the FDT, would stay there forever. The TPM 
subsystem looks at it when initializing and will look at it again when 
initializing after a kexec soft reboot.

> 
>>
>> Having the log external to the device tree creates several problems,
>> like the crash kernel region colliding with it, it being clobbered by
>> kexec, etc.
> 
> We have multiple regions to pass/maintain thru kexec, so how does having
> one less really matter?

I had tried it with the newer kexec syscall. Yes, there was a way of 
doing it but the older kexec call is still around and since that one is 
also still being used the problems with corrupted memory for example 
still persisted. So that's why we now embed it in the FDT because both 
syscalls carry that across unharmed.

> 
> Rob

