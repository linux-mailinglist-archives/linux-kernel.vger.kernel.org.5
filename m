Return-Path: <linux-kernel+bounces-98934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAF0878137
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422D72851AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83733FB3E;
	Mon, 11 Mar 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oLCIrGnk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984643FB2E;
	Mon, 11 Mar 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165803; cv=none; b=RETlfY/DY2wDaiRUTukkDCTkfS8PirTECS/QzIy2Yd4s1CxVhOWpUxUayqDPbdxO3YaJSgY9rerBxPt32cIf9Hj/NQKAorUc9J+gR/4AaOBDLHz+TdJ14wUujmO9RQF87vqkBIsCuL6eF5FL4h0aIPE7TFJUOt0TiRctj8qHaVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165803; c=relaxed/simple;
	bh=zHlbOM9VEhV99I0Z//rqPfGKQMLunzf3ukxad2ISZ3U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=FHF7iX/P0aRKpZRykN+j85lAJWUYUC3B+WO31vnbkQ8t/kIi9XCsbRO2KeemHSbzjj5NY8S4+9l5StiYWQV/z1zvEZg86sVuV5UMebVhGKCM4jWUL0KVqnBBTqstOCrQze+mAwq9Mpvkn6Wm0fYyWJ4dKvn7imoX9vrUkhEnsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oLCIrGnk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BDgX8m025858;
	Mon, 11 Mar 2024 14:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : subject; s=pp1;
 bh=DESa/OZ5nu8PaHfd/PhU2Jm9cowwz5f4WkjSRiI76ZU=;
 b=oLCIrGnk1lgZZQTPAMbWF8mxdrlGXlLKeh1EkGhD//nvLh6akQ6HLWmtgi47ZhvRuPBJ
 wWQdkB2M6kQMR/UDrJJN+2/o8/kF8KJb0C+Bf7ZTX7JKdp7bmaRGaYf/t++Yr04KArf3
 giDXwvksx+FRiUAfhE5EXNdnLDaKUlCzk5K5KAB/gtafLIWtDoyYNw1D61K//+ZMBbMS
 7EjR6WZ4UZhYU/UdcnImuiKEkBtopN03ITafA/v5hYnfarcIsvJOb/hzbMIoeFe/WTc8
 kpHKSB6J9Nlu2vHfdmwEQIq/PDxTVJS6TiIqy9vc8hnJUijL3E4WGby0liQgmAEEj6o5 oA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt32urn0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 14:03:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42BDAB2W014995;
	Mon, 11 Mar 2024 14:03:11 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33ngv4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 14:03:11 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BE38lT46989770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 14:03:11 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C935C5806C;
	Mon, 11 Mar 2024 14:03:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AAE35806D;
	Mon, 11 Mar 2024 14:03:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 14:03:07 +0000 (GMT)
Message-ID: <5ea60bdb-6059-4345-bf46-004c0af8382c@linux.ibm.com>
Date: Mon, 11 Mar 2024 10:03:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bharat Bhushan <bbhushan2@marvell.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saulo.alessandre@tse.jus.br" <saulo.alessandre@tse.jus.br>,
        "lukas@wunner.de" <lukas@wunner.de>
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
 <20240306222257.979304-6-stefanb@linux.ibm.com>
 <SN7PR18MB53143E3480E99EA90B9FEB88E3242@SN7PR18MB5314.namprd18.prod.outlook.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <SN7PR18MB53143E3480E99EA90B9FEB88E3242@SN7PR18MB5314.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T0dWzmEbQy4K4PA48zlTWkqYKIeYQuTn
X-Proofpoint-GUID: T0dWzmEbQy4K4PA48zlTWkqYKIeYQuTn
Subject: Re:  [PATCH v5 05/12] crypto: ecc - Implement vli_mmod_fast_521 for NIST
 p521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110106



On 3/11/24 01:07, Bharat Bhushan wrote:
> Minor nits
> 
>> -----Original Message-----
>> From: Stefan Berger <stefanb@linux.ibm.com>
>> Sent: Thursday, March 7, 2024 3:53 AM
>> To: keyrings@vger.kernel.org; linux-crypto@vger.kernel.org;
>> herbert@gondor.apana.org.au; davem@davemloft.net
>> Cc: linux-kernel@vger.kernel.org; saulo.alessandre@tse.jus.br;
>> lukas@wunner.de; Stefan Berger <stefanb@linux.ibm.com>
>> Subject: [EXTERNAL] [PATCH v5 05/12] crypto: ecc - Implement
>> vli_mmod_fast_521 for NIST p521
>>   
>> ----------------------------------------------------------------------
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
>> diff --git a/crypto/ecc.c b/crypto/ecc.c index f53fb4d6af99..373660e7b19d
>> 100644
>> --- a/crypto/ecc.c
>> +++ b/crypto/ecc.c
>> @@ -902,6 +902,31 @@ static void vli_mmod_fast_384(u64 *result, const
>> u64 *product,  #undef AND64H  #undef AND64L
>>
>> +/* Computes result = product % curve_prime
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

I have also modified this here now to initialize 'result' from lowest 
521 bis of product without the detour through tmp.

>> +
>> +
>> +	for (i = 0; i < ndigits; i++)
>> +		tmp[i] = (product[8 + i] >> 9) | (product[9 + i] << 55);
>> +	tmp[8] &= 0x1ff;
>> +
>> +	vli_mod_add(result, result, tmp, curve_prime, ndigits); }
>> +
>> +
>>   /* Computes result = product % curve_prime for different curve_primes.
>>    *
>>    * Note that curve_primes are distinguished just by heuristic check and @@ -
>> 941,6 +966,12 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
>>   	case 6:
>>   		vli_mmod_fast_384(result, product, curve_prime, tmp);
>>   		break;
>> +	case 9:
> 
> Can we use ECC_CURVE_NIST_P384_DIGITS, ECC_CURVE_NIST_P256_DIGITS  in this function?
>   
> And define ECC_CURVE_NIST_P521_DIGITS, which is same as ECC_MAX_DIGITS defined below in this patch?
> 
>> +		if (curve->nbits == 521) {

If I replace the numbers with these hash-defines's in here (in an 
additional patch on existing code) then I can just about remove the 
check on nbits here as well... ?


>> +			vli_mmod_fast_521(result, product, curve_prime,
>> tmp);
>> +			break;
>> +		}
>> +		fallthrough;
>>   	default:
>>   		pr_err_ratelimited("ecc: unsupported digits size!\n");
>>   		return false;
>> diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h index
>> 4a556b41873e..de17bcdeb53a 100644
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
>> --
>> 2.43.0
>>
> 

