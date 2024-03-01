Return-Path: <linux-kernel+bounces-89113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EEF86EA9F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C1B1F2300A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CC1535C7;
	Fri,  1 Mar 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JHtXErIc"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60B5337B;
	Fri,  1 Mar 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326126; cv=none; b=gwV9JxjeljWkORO34wWRWIS3VEHrmM3JKrbDDoDD64juq1NxmcJ5q/jmHGOuemR8wZquQ+XGOCkzNCctxXtfTNIYaKDV1Eu7eKpYKt+XxWHFHEU72Imssjyo1gEOoxhdIKLh8GAHQj9sMwY+0LzaKzUfmuYdI/9tdgGjus1m9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326126; c=relaxed/simple;
	bh=+ebwOYoTVz9opdDkPoQlWXYXH71gZ3PmbdRZzQLy1B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n57YIgjYCK2WnCSlamHiopWj7vQa6tNdW9gDYPaAMcHgmeKECfqaHqa+IzjN73abEmQBRGtkmrN2/Sb7xqzkycPNC5hqCu0C5l+LWAO0LLaM+UkgpN797KYmk/FUDy0/SKseZyndtzGXdkTXbqb+rnS4OqzkHJud8f8Xf0iDEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JHtXErIc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421KTx7x006699;
	Fri, 1 Mar 2024 20:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Gjs+X61ERp7aMcqKFOVF5kpM2JM+Tyj248qb3Xu8te4=;
 b=JHtXErIc3I1iLV8fHrv48r2RNTH7FPYCSUahGo0oG4ush0lJk9/mRb5C78D06AAZohQh
 ZF1Y5UGPJX3zeoyF0HAVWlfYP5kHUrkgIS8paheNzfnFRzltR/UNhllTF/gZ2fhkMFZ9
 CAwmXIWFP7Wpi1f7ZgKZVPW0aDi6UIBCMQpgbKymlmnnmQ9umUvWLtDZtptmD94QJGk/
 JCsv6iH5kC4BCuHc5fFJqIdchUPMXn/hTvSQ/nZs7XAZcgcC3OKMIT8skkRDaFzLBKUj
 7YrbrKOFg00KaSE9BeaoF32QdzYsGlfEuURBm0PJ0qdjhmRiuGXha8ZQdctdDJl99WkK dw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wknpu0vw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 20:48:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 421J3RI5021762;
	Fri, 1 Mar 2024 20:48:32 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu60q3dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 20:48:32 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 421KmUq44063768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 20:48:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0650B5805B;
	Fri,  1 Mar 2024 20:48:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDC065806A;
	Fri,  1 Mar 2024 20:48:28 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Mar 2024 20:48:28 +0000 (GMT)
Message-ID: <8d33a745-ac77-4965-8d1d-35061b027f33@linux.ibm.com>
Date: Fri, 1 Mar 2024 15:48:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-2-stefanb@linux.ibm.com>
 <20240229091105.GA29363@wunner.de>
 <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>
 <CZIOY02QS2QC.LV0A0HNT7VKM@suppilovahvero>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZIOY02QS2QC.LV0A0HNT7VKM@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lE8FWyWYQ6cGIPHuEQWRNiN7etT_4rpv
X-Proofpoint-GUID: lE8FWyWYQ6cGIPHuEQWRNiN7etT_4rpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_21,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010173



On 3/1/24 15:26, Jarkko Sakkinen wrote:
> On Thu Feb 29, 2024 at 4:57 PM EET, Stefan Berger wrote:
>>
>>
>> On 2/29/24 04:11, Lukas Wunner wrote:
>>> On Fri, Feb 23, 2024 at 03:41:40PM -0500, Stefan Berger wrote:
>>>> +static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>>>> +					 u64 *out, unsigned int ndigits)
>>>> +{
>>>> +	unsigned int sz = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
>>>> +	u8 tmp[ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT];
>>>> +	unsigned int o = sz - nbytes;
>>>> +
>>>> +	memset(tmp, 0, o);
>>>> +	memcpy(&tmp[o], in, nbytes);
>>>> +	ecc_swap_digits(tmp, out, ndigits);
>>>> +}
>>>
>>> Copying the whole key into tmp seems inefficient.  You only need
>>> special handling for the first few bytes of "in" (6 bytes in the
>>> P521 case) and could use ecc_swap_digits() to convert the rest
>>> of "in" directly to "out" without using tmp.
>>>
>>> So it would be sufficient to allocate the first digit on the stack,
>>> memset + memcpy, then convert that to native byte order into "in[0]"
>>> and use ecc_swap_digits() for the rest.
>>>
>>> And the special handling would be conditional on "!o", so is skipped
>>> for existing curves.
>>
>> Thanks. It looks like this now:
>>
>> static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>>                                            u64 *out, unsigned int ndigits)
>> {
>>           unsigned int o = nbytes & 7;
>>           u64 msd = 0;
>>           size_t i;
>>
>>           if (o == 0) {
>>                   ecc_swap_digits(in, out, ndigits);
>>           } else {
>>                   for (i = 0; i < o; i++)
>>                           msd = (msd << 8) | in[i];
>>                   out[ndigits - 1] = msd;
>>                   ecc_swap_digits(&in[o], out, ndigits - 1);
> 
> This would be more stream-lined IMHO:
> 
>          unsigned int o = nbytes & 7;
> 	unsigned int n = ndigits;
>          u64 msd = 0;
>          size_t i;
> 
>          if (o != 0) {
>                  for (i = 0; i < o; i++)
>                          msd = (msd << 8) | in[i];
> 
>                  out[--n] = msd;
>          }
> 
>          ecc_swap_digits(in, out, n);

You forgot to advance 'in'.

> 
> BR, Jarkko
> 

