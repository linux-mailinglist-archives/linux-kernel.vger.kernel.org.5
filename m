Return-Path: <linux-kernel+bounces-89139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA9F86EB10
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 777D9B23D19
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD8E3FE0;
	Fri,  1 Mar 2024 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SobCjazG"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EDA56B8A;
	Fri,  1 Mar 2024 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328016; cv=none; b=fyEPJ4zD2FIvtJQOokwFP+ozRBk5ERbor0YFuWOTOj7YyUsDjcQ8YEv3EqK30VnYTpslxKDqXDDZH6VaWSOuj59lLhcnNgGg+2U0nu0ih9s9clywd12VEiNSW4aPpxvIrS1lNLjpcwTPboZwe2crUnX0brGoZAomcygwXmEKrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328016; c=relaxed/simple;
	bh=Fp36LTyYV9kpvNDK+hVtBJ7X8DZcQYNdYOtSiayQAFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNNWYK8t9lK8209oonXKBs47nsD9g0nwbvsE0gi7y94JzTfmMvm/maA2rPPzrk3VbJiKmwRShSyIO98Ly8ejqBInIx8lijayPLC4ec5VKXgWzfLiQlhEfitymahexDUld4C8VZ4HSlt94sgEis+wyz1a5y2hDma/SAyQk/3uJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SobCjazG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421LHs9n003197;
	Fri, 1 Mar 2024 21:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+RMLsOnNosJmVE5b3aZfPjID67/Lvajwmqc6g347uww=;
 b=SobCjazGG0pUI4x3HPRPyh5z9AlBLh3s6MkkBZm0vVwVYI7NPMz0WgW90v6ayP8DqAMa
 MQOAdZaL5JwVFXzurGEIQU9VlF0DwlvCjymfnR9+0eJn2kSrH07M3ps8HMtNAql1AJHz
 u5ScJdkaSxnPlyjVksSszF3z8WFTacW3UnULDwXxceUvC6ZCwPJD/Jjp3OO4wLokstST
 dpwVAzgoKSw1zBEqZgiDZCfOI7aamS+zA7SKE5U8hrwp+y5AmAjjhl/fLniBYjvflcPi
 99iMSd8BAACl3XCatV9qr6G5ZyhVZnYRQ3ecxJ8kjp4s3EeXiysfMetwcfUUHLdH93ty gg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wkpt5g1ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 21:20:05 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 421K0KM7008142;
	Fri, 1 Mar 2024 21:20:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mxxtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 21:20:04 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 421LK1w27078838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 21:20:04 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93F0158055;
	Fri,  1 Mar 2024 21:20:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F4F158063;
	Fri,  1 Mar 2024 21:20:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 21:20:00 +0000 (GMT)
Message-ID: <00bd9f8d-cde7-44a7-ab1a-888d8fd66cd8@linux.ibm.com>
Date: Fri, 1 Mar 2024 16:20:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] crypto: ecdsa - Rename keylen to bufsize where
 necessary
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-10-stefanb@linux.ibm.com>
 <CZIPDP0W9TOP.3CCT8QUB0R4L3@suppilovahvero>
 <90606a3c-1384-407b-8270-dd76dccc700b@linux.ibm.com>
 <CZIPKTL42F1Z.2U4Q28IIQ159K@suppilovahvero>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZIPKTL42F1Z.2U4Q28IIQ159K@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nXiz26RnlBkFlwg5vbrlGyglIK2iYYA4
X-Proofpoint-ORIG-GUID: nXiz26RnlBkFlwg5vbrlGyglIK2iYYA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_22,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010177



On 3/1/24 15:50, Jarkko Sakkinen wrote:
> On Fri Mar 1, 2024 at 10:47 PM EET, Stefan Berger wrote:
>>
>>
>> On 3/1/24 15:41, Jarkko Sakkinen wrote:
>>> On Fri Mar 1, 2024 at 4:20 AM EET, Stefan Berger wrote:
>>>> In some cases the name keylen does not reflect the purpose of the variable
>>>> anymore once NIST P521 is used but it is the size of the buffer. There-
>>>> for, rename keylen to bufsize where appropriate.
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> ---
>>>>    crypto/ecdsa.c | 12 ++++++------
>>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
>>>> index 4daefb40c37a..4e847b59622a 100644
>>>> --- a/crypto/ecdsa.c
>>>> +++ b/crypto/ecdsa.c
>>>> @@ -35,8 +35,8 @@ struct ecdsa_signature_ctx {
>>>>    static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
>>>>    				  const void *value, size_t vlen, unsigned int ndigits)
>>>>    {
>>>> -	size_t keylen = ndigits * sizeof(u64);
>>>> -	ssize_t diff = vlen - keylen;
>>>> +	size_t bufsize = ndigits * sizeof(u64);
>>>
>>> why not just "* 8"? using sizeof here makes this function only unreadable.
>>
>> 'unreadable' is a 'strong' word ...
> 
> so what is the gain when writing sizeof(u64)?

It matches existing code and a digit is a 'u64'.


> 
> BR, Jarkko

