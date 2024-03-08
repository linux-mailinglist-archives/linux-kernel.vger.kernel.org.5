Return-Path: <linux-kernel+bounces-96997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D19876438
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1820C2814A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA156B70;
	Fri,  8 Mar 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rqw0fYeO"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39162537E5;
	Fri,  8 Mar 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900632; cv=none; b=m2XzVsBYzg6A1Xp6sYMhb8PC37HcKnFCmzgnYk4mJoqhwQXkZaxQb5cDp8bTV517qhJVI/r61+g2xavgyg0QswhsnOvUYftFN8urxLFmBLt5TJDS77Nc6sec4a9xi7Eulmr7fB5mBBBtmQy1rYuvTgsdYxkkEc9RoP/tYqlfLGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900632; c=relaxed/simple;
	bh=hfx1eX/0pdpRvQbWZNMymmeVZCicleQqUgHbKjP4P64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FRFnEmd8fBk0XbRqhHRipxGiMUW9ycDDvptGtOZi6ucBWGjTiSTHC0cFLgtNEBa5OWRDqcglDFNTv9Nq1PeA6jZ6z7A5l24alpNpSiq2VZ7v/nYJWctfL7lx4KPdJe5ik3Atm/6SBu15GaB0KDU4UOPyrEWsykUrNU8ae8Cjtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rqw0fYeO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428CMrLG026298;
	Fri, 8 Mar 2024 12:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=i/GpeF8aIkUiB3ATFSlTu7zEj8XwcmOJq0bYMsncVRo=;
 b=rqw0fYeOrE+wZ5VQxbB8+0WdZE/naJlaUljuw339OITZYeEeGzCae+SddWTxbFaTpUNA
 u1ZtHPOhY/Q9gsaZakGWPh/osQ21Yt7dlRnTZpD07XFAPfszpkjGTOz0IveUOLPzI52R
 ZsvBkizNjW+jDdgCw2PG1ZHaFfMRjDV+li4oADdG6R2ZlGj5HpJ5flzFhPB1ur6kDHZP
 uK3Wc+lPaUjy/xPtG5nXMKrCyyaFxnrQv8MCvIPbjSBqaM6I5f468jkGiSdMg53ahTMP
 h/jWhyiktVxCpokypLYIYOjNF2IV1Dj5ptOAVHIk25G76Vg/fn2oaBwc95DQIXoN8gYQ JA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr2mk00ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:23:41 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428CN5bW026609;
	Fri, 8 Mar 2024 12:23:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr2mk00kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:23:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4289tIZb010886;
	Fri, 8 Mar 2024 12:23:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52uvbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:23:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428CNaja35717604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 12:23:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F2EA58066;
	Fri,  8 Mar 2024 12:23:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD6A458057;
	Fri,  8 Mar 2024 12:23:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 12:23:35 +0000 (GMT)
Message-ID: <851536a5-ad8f-4d65-8c33-707e2fe762df@linux.ibm.com>
Date: Fri, 8 Mar 2024 07:23:35 -0500
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
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240307215214.GB3110385-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OnG9UxkmCSl9Pj-ME8nh6ntAyQQlV3Hq
X-Proofpoint-GUID: ZrkP2al_ODQpPZDwS3ZLQ66v5sWS64Pw
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
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080099



On 3/7/24 16:52, Rob Herring wrote:
> On Thu, Mar 07, 2024 at 09:41:31PM +1100, Michael Ellerman wrote:
>> Stefan Berger <stefanb@linux.ibm.com> writes:
>>> linux,sml-base holds the address of a buffer with the TPM log. This
>>> buffer may become invalid after a kexec and therefore embed the whole TPM
>>> log in linux,sml-log. This helps to protect the log since it is properly
>>> carried across a kexec with both of the kexec syscalls.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>   arch/powerpc/kernel/prom_init.c | 8 ++------
>>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>>

> 
> 
>> Also adding the new linux,sml-log property should be accompanied by a
>> change to the device tree binding.
>>
>> The syntax is not very obvious to me, but possibly something like?
>>
>> diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>> index 50a3fd31241c..cd75037948bc 100644
>> --- a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>> +++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>> @@ -74,8 +74,6 @@ required:
>>     - ibm,my-dma-window
>>     - ibm,my-drc-index
>>     - ibm,loc-code
>> -  - linux,sml-base
>> -  - linux,sml-size
> 
> Dropping required properties is an ABI break. If you drop them, an older
> OS version won't work.

1) On PowerVM and KVM on Power these two properties were added in the 
Linux code. I replaced the creation of these properties with creation of 
linux,sml-log (1/2 in this series). I also replaced the handling of
these two (2/2 in this series) for these two platforms but leaving it 
for powernv systems where the firmware creates these.

https://elixir.bootlin.com/linux/latest/source/arch/powerpc/kernel/prom_init.c#L1959

2) There is an example in the ibm,vtpm.yaml file that has both of these
and the test case still passes the check when the two entries above are 
removed. I will post v2 with the changes to the DT bindings for 
linux,sml-log including an example for linux,sml-log. [The test cases 
fail, as expected, when an additional property is added, such as when 
linux,sml-base is added when linux,sml-log is there or linux,sml-log is 
added when linux,sml-base is there.]

> 
>>   
>>   allOf:
>>     - $ref: tpm-common.yaml#
>> diff --git a/Documentation/devicetree/bindings/tpm/tpm-common.yaml b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
>> index 3c1241b2a43f..616604707c95 100644
>> --- a/Documentation/devicetree/bindings/tpm/tpm-common.yaml
>> +++ b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
>> @@ -25,6 +25,11 @@ properties:
>>         base address of reserved memory allocated for firmware event log
>>       $ref: /schemas/types.yaml#/definitions/uint64
>>   
>> +  linux,sml-log:
> 
> Why is this Linux specific?

I am not sure about the criteria when to prefix with 'linux,' and when 
not to. In this case I did it because it is created by Linux and because 
of existing linux,sml-base and linux,sml-size.

