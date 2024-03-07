Return-Path: <linux-kernel+bounces-96207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB461875894
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4451F2535D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC211386C5;
	Thu,  7 Mar 2024 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HDn3EUrI"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D4D249F9;
	Thu,  7 Mar 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843879; cv=none; b=Bn7Ef0S7vn/mFOsuy0I9XopCQcumNQqidtqcp10oeZzB37g+1c4qVsd+Io1qNtqB1xKzP9G/rBX7go3JZZ29TjznbUIAHVwEx2jB5we6HfxcODCWik7ISHP+Zd2shwQCF0MSexnpdcv/36v4QhZx5caipxkF3Sfkk0yKgIvvzIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843879; c=relaxed/simple;
	bh=JgOQc7MmbNLce2Mll6WNbdTsHSAXklCZO2PLkOHxAeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwW4BPGy7bxy9AYjt2Uk5vAw+p8rBlXkhXYsMMc9m9jz0PfC5PbSWJmR4Z8DOaQSv+EghRj9vS5rkOTWMsugNRfflPqLJU/2Tvi2ufa9OKkjo1ZqMiJ3moqnzxOQegyimPPQdUeetRQ3BRtskH9JHqfleTuMOxicC5zGdNB0oAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HDn3EUrI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427K2w4X021424;
	Thu, 7 Mar 2024 20:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=g63b/PBrnnuXflTDFulUfhSuY8FRmrMXimX5J3dULCI=;
 b=HDn3EUrIZi1X/ZJMXR/L9tJs9apki59TW23BWQRZ091/DOQpTNCx86eKQUCbU4ZjCGof
 lDLhl62BtzBezKfOtW/seLIy0ixqeQpm8vo6ciRBt1gG2D17KTY7taqGT7G3wELDywX8
 LHgCv2PV2eLSO9iO8QRgCAR1YhGDbhYFlq/49s5hYFnnOcca7HldK95WAacaqZKEakK4
 D3IjLGiSoeenNo9wolBZ94TmNS9QVxFoGmu/dIql67c8ul5GW5Vb35ABcw4dSCegyOIz
 g17jAFB6Dm0cByeF+JFNt6irO796wM3axoh8cJSwQX2PjGqaCipjVDJiQldiHFoonxBJ gA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqm950mdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 20:37:45 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 427I3Vbq031542;
	Thu, 7 Mar 2024 20:37:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnkfq2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 20:37:44 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 427KbgAv45351402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 20:37:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0694658059;
	Thu,  7 Mar 2024 20:37:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49B6458043;
	Thu,  7 Mar 2024 20:37:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 20:37:41 +0000 (GMT)
Message-ID: <9992981f-0960-4cd3-b7c1-0f64bbcf394f@linux.ibm.com>
Date: Thu, 7 Mar 2024 15:37:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] crypto: ecc - Implement vli_mmod_fast_521 for
 NIST p521
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
 <20240306222257.979304-6-stefanb@linux.ibm.com>
 <CZNR8E07IQ14.301SKAK0CJX1G@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZNR8E07IQ14.301SKAK0CJX1G@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fyzH6dPb_C8_lgffWmbbUa__PPCgbFkN
X-Proofpoint-ORIG-GUID: fyzH6dPb_C8_lgffWmbbUa__PPCgbFkN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_15,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=971
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403070145



On 3/7/24 14:11, Jarkko Sakkinen wrote:
> On Thu Mar 7, 2024 at 12:22 AM EET, Stefan Berger wrote:
>> Implement vli_mmod_fast_521 following the description for how to calculate
>> the modulus for NIST P521 in the NIST publication "Recommendations for
>> Discrete Logarithm-Based Cryptography: Elliptic Curve Domain Parameters"
>> section G.1.4.
>>
>> NIST p521 requires 9 64bit digits, so increase the ECC_MAX_DIGITS so that
>> arrays fit the larger numbers.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Tested-by: Lukas Wunner <lukas@wunner.de>
>> ---
>>   crypto/ecc.c                  | 31 +++++++++++++++++++++++++++++++
>>   include/crypto/internal/ecc.h |  2 +-
>>   2 files changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/crypto/ecc.c b/crypto/ecc.c
>> index f53fb4d6af99..373660e7b19d 100644
>> --- a/crypto/ecc.c
>> +++ b/crypto/ecc.c
>> @@ -902,6 +902,31 @@ static void vli_mmod_fast_384(u64 *result, const u64 *product,
>>   #undef AND64H
>>   #undef AND64L
>>   
>> +/* Computes result = product % curve_prime
> 
> Missing empty comment line:
> 
> /*
>   *
> 
>> + * from "Recommendations for Discrete Logarithm-Based Cryptography:
>> + *       Elliptic Curve Domain Parameters" G.1.4
>> + */
>> +static void vli_mmod_fast_521(u64 *result, const u64 *product,
>> +				const u64 *curve_prime, u64 *tmp)
>> +{
>> +	const unsigned int ndigits = 9;
>> +	size_t i;
>> +
>> +	for (i = 0; i < ndigits; i++)
>> +		tmp[i] = product[i];
>> +	tmp[8] &= 0x1ff;
>> +
>> +	vli_set(result, tmp, ndigits);
>> +
>> +
>> +	for (i = 0; i < ndigits; i++)
>> +		tmp[i] = (product[8 + i] >> 9) | (product[9 + i] << 55);
>> +	tmp[8] &= 0x1ff;
>> +
>> +	vli_mod_add(result, result, tmp, curve_prime, ndigits);
>> +}
>> +
>> +
>>   /* Computes result = product % curve_prime for different curve_primes.
>>    *
>>    * Note that curve_primes are distinguished just by heuristic check and
>> @@ -941,6 +966,12 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
>>   	case 6:
>>   		vli_mmod_fast_384(result, product, curve_prime, tmp);
>>   		break;
>> +	case 9:
>> +		if (curve->nbits == 521) {
> 
> Missing inline comment about the branching decision, and has a magic
> number.


Ok, will add comment to this and 6/12.
> 
>> +			vli_mmod_fast_521(result, product, curve_prime, tmp);
>> +			break;
>> +		}
>> +		fallthrough;
>>   	default:
>>   		pr_err_ratelimited("ecc: unsupported digits size!\n");
>>   		return false;
>> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
>> index 4a556b41873e..de17bcdeb53a 100644
>> --- a/include/crypto/internal/ecc.h
>> +++ b/include/crypto/internal/ecc.h
>> @@ -33,7 +33,7 @@
>>   #define ECC_CURVE_NIST_P192_DIGITS  3
>>   #define ECC_CURVE_NIST_P256_DIGITS  4
>>   #define ECC_CURVE_NIST_P384_DIGITS  6
>> -#define ECC_MAX_DIGITS              (512 / 64) /* due to ecrdsa */
>> +#define ECC_MAX_DIGITS              DIV_ROUND_UP(521, 64) /* NIST P521 */
>>   
>>   #define ECC_DIGITS_TO_BYTES_SHIFT 3
>>   
> 
> BR, Jarkko

