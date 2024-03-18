Return-Path: <linux-kernel+bounces-106764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4553B87F33E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0521282C80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C46A5A799;
	Mon, 18 Mar 2024 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N4OLzegp"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B75A0FB;
	Mon, 18 Mar 2024 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801965; cv=none; b=U18PVLW+vMupANTt83QOdw1STsouKbUmjFqVlrlYEPgCZA65cdsCqJOf2VXEgX4+uPh+URkj6q8/qiS4vzbKQfJqtDwJcYP1AEkCfhZH6OLDWUwL+PM+6dEqga4GpcQZS/aXl0A/LAszdUPvkjxrAm20mcfoszP1T1na8mGYGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801965; c=relaxed/simple;
	bh=1bSHVw+7ROworXARJSF/6FIF6IZEfEX+JYRSjIREoCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ne9UGqekJ0Ih/PYsC8VsNPuYUNVjt9R7h18IHR8CONU8N1Flc3VLoAUtO5wBgzExN5KQijIYFZKW9E8MEe80Sg6rcD+2kNxJRG78aIRxYJ5n27sGYpeM7+jG1djD7SMTRLT5o5kT3p9Ecp37M+jWhf3OF1EJPJsdf8L6S16WFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N4OLzegp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42IMjotg029272;
	Mon, 18 Mar 2024 22:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SwZ/ixC/W3Q/ptPj9ai6jJwYKq0mQQoP2rRohnW0DI4=;
 b=N4OLzegpbwc5B2Mm34Pxd9wtx7DURjCpTpbf09nl0D9J2gqkkTetThnKByTWgdgqDQh7
 WpJVNVIoJi6pvAELbH9NGCd0fVE3QeCb7ihnwr5KHxXUloZKvh3hkdid/WF6uEh0QaS6
 wD0SupMfUbfYf/2eMMyUl0eCnLuz961LiA9YwZMH9cAkC+DkgJI+f0EuwDMs5R+pnH2M
 K3S5D/x46Z/xnGad8pXBStIFeasqLc6Le+sHG7k7erdsPFzkDbPswkYXapcwSn1jqHVJ
 3szRaT06rl+rp3Tj+7USy4IVRru5FxMWeGJeuUZDrBJTRS2uMx2Xtb7OQNV6Z+91fwOU /w== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxvy08exq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 22:45:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42IM1cW8011582;
	Mon, 18 Mar 2024 22:42:17 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8kuh50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 22:42:17 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42IMgFP025494210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 22:42:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF8EA58067;
	Mon, 18 Mar 2024 22:42:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B975558066;
	Mon, 18 Mar 2024 22:42:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Mar 2024 22:42:13 +0000 (GMT)
Message-ID: <a8385505-b3f2-40f8-b603-fd3435c5ba24@linux.ibm.com>
Date: Mon, 18 Mar 2024 18:42:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/13] crypto: asymmetric_keys - Adjust signature size
 calculation for NIST P521
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br, lukas@wunner.de,
        bbhushan2@marvell.com
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-13-stefanb@linux.vnet.ibm.com>
 <CZX6OOKP5RQD.3BN0EDSAF7QXR@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZX6OOKP5RQD.3BN0EDSAF7QXR@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2LlQZJMjA33WSlNTt4TK8W_jf4TsVVdZ
X-Proofpoint-ORIG-GUID: 2LlQZJMjA33WSlNTt4TK8W_jf4TsVVdZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180172



On 3/18/24 17:12, Jarkko Sakkinen wrote:
> On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Adjust the calculation of the maximum signature size for support of
>> NIST P521. While existing curves may prepend a 0 byte to their coordinates
>> (to make the number positive), NIST P521 will not do this since only the
>> first bit in the most significant byte is used.
>>
>> If the encoding of the x & y coordinates requires at least 128 bytes then
>> an additional byte is needed for the encoding of the length. Take this into
>> account when calculating the maximum signature size.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>> Tested-by: Lukas Wunner <lukas@wunner.de>
>> ---
>>   crypto/asymmetric_keys/public_key.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
>> index e5f22691febd..16cc0be28929 100644
>> --- a/crypto/asymmetric_keys/public_key.c
>> +++ b/crypto/asymmetric_keys/public_key.c
>> @@ -233,6 +233,7 @@ static int software_key_query(const struct kernel_pkey_params *params,
>>   	info->key_size = len * 8;
>>   
>>   	if (strncmp(pkey->pkey_algo, "ecdsa", 5) == 0) {
>> +		int slen = len;
>>   		/*
>>   		 * ECDSA key sizes are much smaller than RSA, and thus could
>>   		 * operate on (hashed) inputs that are larger than key size.
>> @@ -246,8 +247,19 @@ static int software_key_query(const struct kernel_pkey_params *params,
>>   		 * Verify takes ECDSA-Sig (described in RFC 5480) as input,
>>   		 * which is actually 2 'key_size'-bit integers encoded in
>>   		 * ASN.1.  Account for the ASN.1 encoding overhead here.
>> +		 *
>> +		 * NIST P192/256/384 may prepend a '0' to a coordinate to
>> +		 * indicate a positive integer. NIST P521 never needs it.
>>   		 */
>> -		info->max_sig_size = 2 * (len + 3) + 2;
>> +		if (strcmp(pkey->pkey_algo, "ecdsa-nist-p521") != 0)
>> +			slen += 1;
> 
> Just wondering the logic of picking between these:
> 
> 1. "strncmp"
> 2. "strcmp"
> 

strncmp: prefix-matching
strcmp: full string matching

> Now the "ecdsa" is matched with strncmp and "ecdsa-nist-p521" is
> compared with strcmp.

That's prefix matching vs. full string match.

. and indeed 'ecdsa' is a prefix of 'ecdsa-nist-p521'.

> 
> So is there a good reason to use different function in these
> cases?

Yes, there is.

> 
> I'd guess both could be using strcmp since comparing against
> constant...

No, prefix versus full string matching requires different function calls.

> 
>> +		/* Length of encoding the x & y coordinates */
>> +		slen = 2 * (slen + 2);
>> +		/*
>> +		 * If coordinate encoding takes at least 128 bytes then an
>> +		 * additional byte for length encoding is needed.
>> +		 */
>> +		info->max_sig_size = 1 + (slen >= 128) + 1 + slen;
>>   	} else {
>>   		info->max_data_size = len;
>>   		info->max_sig_size = len;
> 
> 
> BR, Jarkko
> 

