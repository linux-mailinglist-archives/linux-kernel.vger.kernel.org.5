Return-Path: <linux-kernel+bounces-162715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965768B5F71
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C1B284045
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2D586260;
	Mon, 29 Apr 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bqMkonM1"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9CC8613E;
	Mon, 29 Apr 2024 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409854; cv=none; b=A3Z+vlFcs0D2AWFKC9kl3ec8LgsMXfblWwHy01xvM/xjg2yZCU2mQQyEOFgugpvUYk6GZfcLnXcQkhqkxkMaUpBXtOfMVKmbiAUQ78DNzAT0IrV2tt0F7EVp0H8ASQL8zlOqoka8TTc09u1qPTgEC5NJDKXNIB583tjG8v9RkyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409854; c=relaxed/simple;
	bh=/SuGvf8UkdCZnz5+I7ZPOCp3GfImi4Fd9AOTgaarsnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1Tvft/pX0cmMAFQGEMTKTbZrBgE+v77udecIo2FxBRPefChSvdJjCiAn4VrNv0PmXkbxwk9hVOPRr640p+xQaRv6sY5H8DRQlA3J9vxmGzZ3clPTFvEy1RmR8wtVpZRvP2wfqcYhj8duSW3fBrcDjiYLzlDQpIbqQgEGg3mdOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bqMkonM1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TG2DOO005539;
	Mon, 29 Apr 2024 16:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xuoovfx2POhGX/fjXgHfC5zmT1B1rEDq+Am+MvjR7Dk=;
 b=bqMkonM1zBlCPV9qJae6YHqtEmjrt+Ujqu3sxHVKbyKOoX8qveHu5f1GdmQYzHuz5x2u
 2qjPNyAmxaDNUdWP0ZcYonOG5yTC47rFkIc0ISi/qfSoFbGAo2JHLdUOfaiu6GewaK78
 mWRK7XCp2rhDfxYdEepLNbU0ARFJIT1JCwIoTAVNvROGwMBy/djpIHqt5wFF3bdQw0YF
 C+77e890foTPbWVMKMRANENqfeR+7V5KXl4umPe9zp6ADduVUcW2o5g8XzdcAGbU0BZl
 ij8HJmGmQD3jnxUeq/Em6HBhz2uYfKD3LA+ImsnSe9rdz1Ryan8QpHoLQcitEDr8vl5f cg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xteqar5nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:57:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43TE8HVf027569;
	Mon, 29 Apr 2024 16:57:25 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xsc308jkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 16:57:25 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43TGvMKo21168688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 16:57:24 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A65058058;
	Mon, 29 Apr 2024 16:57:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D458858057;
	Mon, 29 Apr 2024 16:57:21 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2024 16:57:21 +0000 (GMT)
Message-ID: <f001bc3f-0c70-4118-bc71-8455808004b4@linux.ibm.com>
Date: Mon, 29 Apr 2024 12:57:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] crypto: ecc - Prevent ecc_digits_from_bytes from
 reading too many bytes
To: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, lukas@wunner.de
References: <20240429161316.3146626-1-stefanb@linux.ibm.com>
 <D0WRD3IZ3AJC.GWZHZLHHBJ5B@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <D0WRD3IZ3AJC.GWZHZLHHBJ5B@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b67sJDTXArPPA2BrAC3Tgs_2GLeWBIsP
X-Proofpoint-ORIG-GUID: b67sJDTXArPPA2BrAC3Tgs_2GLeWBIsP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290109



On 4/29/24 12:47, Jarkko Sakkinen wrote:
> On Mon Apr 29, 2024 at 7:13 PM EEST, Stefan Berger wrote:
>> Prevent ecc_digits_from_bytes from reading too many bytes from the input
>> byte array in case an insufficient number of bytes is provided to fill the
>> output digit array of ndigits. Therefore, initialize the most significant
>> digits with 0 to avoid trying to read too many bytes later on. Convert the
>> function into a regular function since it is getting too big for an inline
>> function.
>>
>> If too many bytes are provided on the input byte array the extra bytes
>> are ignored since the input variable 'ndigits' limits the number of digits
>> that will be filled.
>>
>> Fixes: d67c96fb97b5 ("crypto: ecdsa - Convert byte arrays with key coordinates to digits")
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> ---
>>
>> v2:
>>   - un-inline function
>>   - use memset
>> ---
>>   crypto/ecc.c                  | 22 ++++++++++++++++++++++
>>   include/crypto/internal/ecc.h | 15 ++-------------
>>   2 files changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/crypto/ecc.c b/crypto/ecc.c
>> index c1d2e884be1e..fe761256e335 100644
>> --- a/crypto/ecc.c
>> +++ b/crypto/ecc.c
>> @@ -68,6 +68,28 @@ const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
>>   }
>>   EXPORT_SYMBOL(ecc_get_curve);
>>   
> 
> Just a minor nit:
> 
> For exported symbol you need to document the function,including
> the parameters [1].

Like other functions, the ecc_digits_from_bytes also still/already has 
the documentation in the header file:

/**
  * ecc_digits_from_bytes() - Create ndigits-sized digits array from 
byte array
  * @in:       Input byte array
  * @nbytes    Size of input byte array
  * @out       Output digits array
  * @ndigits:  Number of digits to create from byte array
  */
void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
                            u64 *out, unsigned int ndigits);

  Should be ok?

