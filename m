Return-Path: <linux-kernel+bounces-110313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AEA885D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E301C2186D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C5112BF26;
	Thu, 21 Mar 2024 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dAhpKMau"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F4F12BF23;
	Thu, 21 Mar 2024 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037399; cv=none; b=IzxLOt6Cmt9cj13kPkD5e8o19B/xbb5IT+p5Syby8KtyNTJcddGq1WxAJFWjoSwIM6I8wydipSWYn9zQReiFVOD9F6tnHDH7O8n5eh1FpvCMk1Beaf9I2sc7VGaBQywaVB+9Kj6ipq3f5h6EMRs4b8VZhEpr4oFHgLmuEj+pJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037399; c=relaxed/simple;
	bh=st0jyZD6fF0/ceWO3qsXCDcdlU28KeOqhR8RwZFHnqw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tj9HB7t84/+fsEn5jWsbB9kg1ie8k+4L+ANse0KduwwYVCEjVlw6m/anNuIIKs0HBx1rOj8XBwSjB9fiE/5GWVZoXDIMW/x14siIn3eFpwbPilP25SSmnhIrMn4HsSPjNkPJoQ4NYqQmq9b26mi4ZfHrciNFFfyZ/K5h8WW33p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dAhpKMau; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LFph7b011971;
	Thu, 21 Mar 2024 16:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vTNZJe0IJWDIMN1SbdzAB6ehGYLIFRs8Ff9IeHLNYtA=;
 b=dAhpKMaumPYzgeaXGcRz3+01DkOtPhvksdFiVh8TGtkFRAb/IqpxXB4MsrV9uToy1kOV
 UquqfsPRYvqL/saQ5GJBfVTKNMDbRpCS7HdTBPJrZwB0t1gq0h86r93GRYBqf0mM3HdZ
 yXYvl6Lukh2RoXLoq09vqDfaMvj3WZGpD8jsNyzFba3WYGJzGJ+8tE+i7butysP6F/5o
 0TVkN2IclH4HPIEh7GewCcGlzAJHMZZurAVqccyypqe/J6wsNrSK5ZLO0jBGl5JHLlY/
 kUWBYffiPTco3lA0qOwsrN7gCJOwCQNZECWihURnsJp6CGNEA85Tre9hsXmKS1sXx/bi pA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0nq48epm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 16:09:36 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LG9asD009100;
	Thu, 21 Mar 2024 16:09:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0nq48epg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 16:09:36 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42LDwf7R002773;
	Thu, 21 Mar 2024 16:09:35 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2wtqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 16:09:35 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42LG9Wpk58851816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 16:09:34 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7963458055;
	Thu, 21 Mar 2024 16:09:32 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62BF85804B;
	Thu, 21 Mar 2024 16:09:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 16:09:31 +0000 (GMT)
Message-ID: <d957dbd3-4975-48d7-abc5-1a01c0959ea3@linux.ibm.com>
Date: Thu, 21 Mar 2024 12:09:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: tpm_tis
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
        "Daniel P . Smith" <dpsmith@apertussolutions.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
References: <20240320085601.40450-1-jarkko@kernel.org>
 <afc9471c-1c28-4384-82c1-29464ca1fb1f@linux.ibm.com>
 <CZZJQR121P7H.3QS68A6320S32@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZZJQR121P7H.3QS68A6320S32@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SD3MVmc3-Va9D44QCOqk-nRPCX-gp5VX
X-Proofpoint-GUID: k7P-IGXBL7-en4PS3OqwZqkLuLHcI3iB
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
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=995 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210117



On 3/21/24 11:51, Jarkko Sakkinen wrote:
> On Wed Mar 20, 2024 at 6:15 PM EET, Stefan Berger wrote:
>>
>>
>> On 3/20/24 04:56, Jarkko Sakkinen wrote:
>>> Based recent discussions on LKML, provide preliminary bits of tpm_tis_core
>>> dependent drivers. Includes only bare essentials but can be extended later
>>> on case by case. This way some people may even want to read it later on.
>>>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> CC: Daniel P. Smith <dpsmith@apertussolutions.com>
>>> Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>>> Cc: Peter Huewe <peterhuewe@gmx.de>
>>> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
>>> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
>>> Cc: keyrings@vger.kernel.org
>>> Cc: linux-doc@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-integrity@vger.kernel.org
>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> ---
>>> v2:
>>> - Fixed errors reported by Randy:
>>>     https://lore.kernel.org/all/aed28265-d677-491a-a045-24b351854b24@infradead.org/
>>> - Improved the text a bit to have a better presentation.
>>> ---
>>>    Documentation/security/tpm/index.rst   |  1 +
>>>    Documentation/security/tpm/tpm_tis.rst | 30 ++++++++++++++++++++++++++
>>>    2 files changed, 31 insertions(+)
>>>    create mode 100644 Documentation/security/tpm/tpm_tis.rst
>>>
>>> diff --git a/Documentation/security/tpm/index.rst b/Documentation/security/tpm/index.rst
>>> index fc40e9f23c85..f27a17f60a96 100644
>>> --- a/Documentation/security/tpm/index.rst
>>> +++ b/Documentation/security/tpm/index.rst
>>> @@ -5,6 +5,7 @@ Trusted Platform Module documentation
>>>    .. toctree::
>>>    
>>>       tpm_event_log
>>> +   tpm_tis
>>>       tpm_vtpm_proxy
>>>       xen-tpmfront
>>>       tpm_ftpm_tee
>>> diff --git a/Documentation/security/tpm/tpm_tis.rst b/Documentation/security/tpm/tpm_tis.rst
>>> new file mode 100644
>>> index 000000000000..b331813b3c45
>>> --- /dev/null
>>> +++ b/Documentation/security/tpm/tpm_tis.rst
>>> @@ -0,0 +1,30 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +=========================
>>> +TPM FIFO interface Driver
>>> +=========================
>>> +
>>> +FIFO (First-In-First-Out) is the name of the hardware interface used by the
>>
>> FIFO is the type. I am surprised you call it a 'name'. I would say TIS
>> is the 'name'.
> 
> It's what the official specification calls it [1].
> 
> 
>>
>>> +tpm_tis_core dependent drivers. The prefix "tis" comes from the TPM Interface
>>
>> tis is a tla -- a three letter *acronym*. You aren't using it as a 'prefix'.
> 
> I don't know what "tla" means.
> 
>>
>>> +Specification, which is the hardware interface specification for TPM 1.x chips.
>>
>> It's also available for TPM2.
>   
> Yes, but TIS is the name used by the legacy specification.


The point is that TIS is not just a TPM 1.x interface but also used for 
TPM 2.
> 
>>
>>> +
>>> +Communication is based on a 5 KiB buffer shared by the TPM chip through a
>>
>> I thought it was typically 4 KiB.
> 
> You are basing this on table 9 in [1]?

Yes. See below.

> 
>>
>>> +hardware bus or memory map, depending on the physical wiring. The buffer is
>>> +further split into five equal-size buffers, which provide equivalent sets of

If you are referring to the MMIO region between 0xfed4 0000 and 0xfed4 
4fff as a buffer then you are talking about a **20kb** MMIO region 
(0x5000) that is **split** into equal-sized MMIO regions, each having 
4kb (0x1000). Yes, that's the 4kb then but there that one is no 5kb 
'further split into five equal-sized buffers' of presumably 1kb each. 
Each locality has a 0x1000 sized MMIO region.

